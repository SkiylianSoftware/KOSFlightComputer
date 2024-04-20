// Configure
clearscreen.
global w is 49. global h is 40.
set terminal:width to w+1. set terminal:height to h+1.
// Setup
wait until ship:unpacked. core:part:getmodule("kosProcessor"):doevent("Open Terminal").
until homeConnection:isconnected {
    print "Awaiting connection..." at(5, 5).
    wait 0.
}
// UI
switch to 0.
run "ui/base-ui".
run "control/launch-sequence".
run "ui/flight-information".