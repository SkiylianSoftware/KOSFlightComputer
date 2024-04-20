// Standard rocket design to use this script
// stage 0: light engines
// stage 1: release clamps + light solid motors
// stage 2+: standard rocket stuff.

// await a launch command
println("Press [Anything] to begin launch sequence").
terminal:input:getchar().

// countdown
from {local t is 5.} until t=0 step { set t to t-1. } do {
    println("T-"+t). wait 1.
}

// spool up engines, ignite engines
sas on.
lock throttle to 1.
stage.

// if thrust doesnt match expected -> failure: abort
// TODO.

// otherwise: release the clamps, continue as normal
println("Launch!").

when maxThrust = 0 then {
    println("Staging").
    wait 0.1.
    stage.
    if (stage:number > 0) {
        preserve.
    }
}
