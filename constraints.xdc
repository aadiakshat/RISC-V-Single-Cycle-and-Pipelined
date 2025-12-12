###########################################
## Clock Input
###########################################
set_property PACKAGE_PIN Y9 [get_ports {clk}]      ; # GCLK
set_property IOSTANDARD LVCMOS33 [get_ports {clk}] ; # Bank 13 is fixed 3.3V


###########################################
## Reset Input (BTNC button)
###########################################
set_property PACKAGE_PIN P16 [get_ports {rst}]       ; # BTNC pushbutton
set_property IOSTANDARD LVCMOS18 [get_ports {rst}]   ; # Bank 34 default = 1.8V
set_property PACKAGE_PIN T22 [get_ports {leds[0]}]
set_property PACKAGE_PIN T21 [get_ports {leds[1]}]
set_property PACKAGE_PIN U22 [get_ports {leds[2]}]
set_property PACKAGE_PIN U21 [get_ports {leds[3]}]
set_property PACKAGE_PIN V22 [get_ports {leds[4]}]
set_property PACKAGE_PIN W22 [get_ports {leds[5]}]
set_property PACKAGE_PIN U19 [get_ports {leds[6]}]
set_property PACKAGE_PIN U14 [get_ports {leds[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[*]}]
