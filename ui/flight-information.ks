// Constantly display flight information.

cls().
// Static UI elements
print "Orbital Information" at(1, 10).
print "BDY: " at(1, 12).
print "APO: " at(1, 13).
print "PER: " at(1, 14).
print "VEL: " at(1, 15).
print "OBT: " at(1, 16).

// print "SMA"
// print "ECC"
// print "INC"
// print "ARG"
// print "LAN"

print "Vessel Information" at(1, 20).
print "ALT: " at (1, 22).
print "MAS: " at (1, 23).
print "SPD: " at (1, 24).
print "SΔV: " at (1, 25).
print "VΔV: " at (1, 26).

// UI Update loop
until false {
    wait 0. // wait a single physics tick
    
    // Orbital information
    println(body:name, 6, 12).
    println(toSi(obt:apoapsis)+"m", 6, 13).
    println(toSi(obt:periapsis)+"m", 6, 14).
    println(toSi(obt:velocity:orbit:mag)+"m/s", 6, 15).
    println(toTime(obt:period), 6, 16).

    // vessel information
    println(toSi(altitude) + "m", 6, 22).
    println(toSi(mass)+"t", 6, 23).
    println(toSi(ship:velocity:surface:mag)+"m/s", 6, 24).
    println(toSi(ship:deltav:asl)+"m/s", 6, 25).
    println(toSi(ship:deltav:vacuum)+"m/s", 6, 25).
}