// Sounding rocket launch - V1

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

// When our thrust decreases to zero, stage.
//  Don't if we are at the final stage.
when maxThrust = 0 then {
    print "staging".
    stage.
    if (Vessel:stagenum > 0) {
        preserve.
    }
}