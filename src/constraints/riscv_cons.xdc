create_clock -period 5.000 -name CLK -waveform {0.000 2.500} [get_ports -regexp -filter { NAME =~  ".*CLK.*" && DIRECTION == "IN" }]

