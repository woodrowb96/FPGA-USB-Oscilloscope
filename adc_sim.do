
add wave *
force clk 0 @ 0, 1 @ .01us -r .02us
force reset_n 1 @ 0, 0 @ .03us, 1 @ .05us
force sdata 0 @ 0, 1 @ .05us -r .1us
run 10us