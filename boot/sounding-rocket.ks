// wait for the vessel to load
wait until ship:unpacked.

// open the terminal
core:part:getmodule("kosProcessor"):doevent("Open Terminal").

// run the launch
function toTime {
    parameter number.
    return floor(timeSpan(number):days) + ":" + timeStamp(number):clock.
}

//  Round to 'n' decimal places
function toDecimals {
    parameter number, places is 2.
    set number to round(number, places)+"".
    if places > 0 {
        if not number:contains(".") { set number to number+".". }
        // append zeros up to places
        set number to number:padright(places + number:find(".") + 1):replace(" ", "0").
    }
    return number.
}

//  convert to SI
function toSi {
    // function arguments
    parameter number, places is 2.
    // si prefixes
    local prefixes is list("n", "μ", "m", "", "K", "M", "G", "T").
    // determine the largest power of 1000 smaller than our number, beware log(0) = -inf.
    local power is choose min(4, max(-3, floor(log10(abs(number)) / 3))) if number else 0.
    // divide our number by that power
    return toDecimals(number / 1000^power, places) + prefixes[power+3].
}

// wait for user input.
print "Press [Anything] to begin launch sequence".
terminal:input:getchar().

// engage SAS
sas on.

// throttle to maximum
lock throttle to 1.0.

// countdown
print "T-3".
wait 1.0.
print "T-2".
wait 1.0.
print "T-1".
wait 1.0.

// stage
print "T-0 - Launch!".
stage.

// Triggers to update things
//  staging trigger, always stage when thrust hits zero.
when maxThrust = 0 then {
    print "staging".
    wait 0.1.
    stage.
    if (stage:number > 0) {
        preserve.
    }
}

//  mission time trigger
function drawMET {
    print "MET: " + toTime(missionTime) at(1, 20).
}
on floor(missionTime) {
    drawMET().
    return true.
} drawMET().

// code execution to keep the script running
until false {
    print "Altitude: " + toSi(altitude) + "m      " at (1, 21).
    wait 0.25.
}