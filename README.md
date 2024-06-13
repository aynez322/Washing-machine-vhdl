# Washing-machine-vhdl
Initially, the machine is in an inactive state, with the washing machine door open. The user can set the operating parameters manually (manual mode) or select one of the pre-programmed modes.

In manual mode, you can set:

Temperature (30°C, 40°C, 60°C, or 90°C)
Speed (800, 1000, 1200 revolutions per minute)
Select/cancel prewash, additional rinse
The running time of the program depends on the selected temperature (the water starts at 15°C and heats up by 1°C every 2 seconds) and the selected functions (prewash – the same method as the main wash, additional rinse – rinse twice; these functions are described in detail below).

The selectable automatic modes are as follows:

Quick wash - 30°C, speed 1200, no prewash, no additional rinse
Shirts - 60°C, speed 800, no prewash, no additional rinse
Dark colors - 40°C, speed 1000, no prewash, additional rinse
Dirty laundry - 40°C, speed 1000, with prewash, no additional rinse
Anti-allergic - 90°C, speed 1200, no prewash, additional rinse
Each program contains the following steps:

Main wash (feed the machine with water, heat the water, rotate at a speed of 60 revolutions per minute for 20 minutes, drain the water)
Rinsing (fill with water, rotate at a speed of 120 revolutions per minute for 10 minutes, drain the water)
Spin (rotate at the selected speed for 10 minutes)
If the prewash is selected, it follows the same method as the main wash, except that it spins for 10 minutes.

The door locks after starting the program and opens one minute after the program ends. The machine does not start with the door open.

While selecting the desired mode (manual or one of the automatic modes), the duration of the program is displayed. After the program starts, the remaining time is displayed (the time is shown on 7-segment displays).






