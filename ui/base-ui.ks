// show the KOS and script version.
// have an updating mission time here
// Ship name, connection status. boot disk size.

clearScreen. switch to 0.

// refrencable variables
local bar is "=":padright(w):replace(" ", "=").
local cap is volume(1):capacity.
lock fs to volume(1):freespace.
lock con to (choose 2 if homeConnection:isconnected else (choose 1 if controlConnection:isconnected else 0)).

//  clear everything in the dynamic ui area.
function cls {
    local blank is " ":padright(w).
    for _y in range(4, h-8) {
        print blank at(0, _y).
    }
}.
function println {
    parameter text, _x is 1, _y is 5.
    print text:padright(w-_x) at(_x, _y).
}
function toTime {
    parameter number.
    return floor(timeSpan(number):days) + ":" + timeStamp(number):clock.
}
function toDecimals {
    parameter number, places is 3.
    set number to round(number, places)+"".
    if places > 0 {
        if not number:contains(".") { set number to number+".". }
        set number to number:padright(places + number:find(".") + 1):replace(" ", "0").
    }
    return number.
}
function toSi {
    parameter number, places is 3.
    if number:istype("string") { set number to number:toscalar(). }
    local prefixes is list("n", "μ", "m", "", "K", "M", "G", "T").
    local power is choose min(4, max(-3, floor(log10(abs(number)) / 3))) if number else 0.
    return toDecimals(number / 1000^power, places) + prefixes[power+3].
}
function toBi {
    parameter number, places is 3.
    if number:istype("string") { set number to number:toscalar(). }
    local prefixes is list("", "Ki", "Mi", "Gi").
    local power is choose min(3, max(0, floor(log10(abs(number)) / log10(1024)))) if number else 0.
    return toDecimals(number / 1024^power, choose places if power else 0) + prefixes[power].
}

// static UI elements
print bar at(0,3).print bar at(0,h-3).print bar at(0,h).

print "MET: " at(1, 1).
print shipName at(1, 2).
print "DSK: " at(1, h-2).
print "CON: " at(1, h-1).

// Dynamic UI elements
function drawMET { print toTime(missionTime) at(6, 1). }
function drawBAT { local pow is toSi(ship:electriccharge * 1000)+"J".
    print pow:padleft(10) at(w-10-1, 1). }
function drawSTS { print status:padleft(16) at(w-16-1, 2). }
function drawDSK { println(toBi(cap - fs) + "B / " + toBi(cap) + "B", 6, h-2). }
function drawCON { local context is (choose "No Signal" if not con else ( choose "Space Centre" if con=2 else "Remote")).
    println(context, 6, h-1). }

// UI elements triggers
on floor(missionTime) { drawMET(). return true. } drawMET().
on round(ship:electriccharge, 1) { drawBAT(). return true. } drawBAT().
on status { drawSTS(). return true. } drawSTS().
on fs { drawDSK(). return true. } drawDSK().
on con { drawCON(). return true. } drawCON().