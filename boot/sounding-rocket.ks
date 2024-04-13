// wait for the vessel to load
wait until ship:unpacked.

// open the terminal
core:part:getmodule("kosProcessor"):doevent("Open Terminal").

// login to the archive
switch to 0.

// run the launch
run "sounding-rocket/sounding-rocket-launch.ks".