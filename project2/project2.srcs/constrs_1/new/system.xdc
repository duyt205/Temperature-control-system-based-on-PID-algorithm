# Clock
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
set_property PACKAGE_PIN H4 [get_ports {clk}]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}]

# Reset
set_property IOSTANDARD LVCMOS33 [get_ports {rst_n}]
set_property PACKAGE_PIN C3 [get_ports {rst_n}]

# DHT
set_property IOSTANDARD LVCMOS33 [get_ports {io_data}]
set_property PACKAGE_PIN A5 [get_ports {io_data}]
set_property PULLUP true [get_ports {io_data}]

#PID
set_property IOSTANDARD LVCMOS33 [get_ports {uk}]
set_property PACKAGE_PIN J1 [get_ports {uk}]

#LCD
set_property PACKAGE_PIN A12 [get_ports {lcd_data[7]}]
set_property PACKAGE_PIN C12 [get_ports {lcd_data[6]}]
set_property PACKAGE_PIN A10 [get_ports {lcd_data[5]}]
set_property PACKAGE_PIN B6 [get_ports {lcd_data[4]}]
set_property PACKAGE_PIN B5 [get_ports {lcd_data[3]}]
set_property PACKAGE_PIN A4 [get_ports {lcd_data[2]}]
set_property PACKAGE_PIN A3 [get_ports {lcd_data[1]}]
set_property PACKAGE_PIN B3 [get_ports {lcd_data[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[0]}]

set_property PACKAGE_PIN A2 [get_ports lcd_en]
set_property PACKAGE_PIN B2 [get_ports lcd_rw]
set_property PACKAGE_PIN B1 [get_ports lcd_rs]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_en]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_rw]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_rs]

set_property PACKAGE_PIN H1 [get_ports OE]
set_property IOSTANDARD LVCMOS33 [get_ports OE]
