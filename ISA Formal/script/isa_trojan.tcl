# you can modify it
clear -all
check_cov -init -type all

# include source code
analyze -v2k [glob ./source/trojan/biriscv/icache/*.v]
analyze -v2k [glob ./source/trojan/biriscv/dcache/*.v]
analyze -v2k [glob ./source/trojan/biriscv/core/*.v]
analyze -v2k [glob ./source/trojan/biriscv/top/riscv_top.v]

# include assertion property
analyze -sv  [glob ./property/isa.sva]

# top module
elaborate -top riscv_top

# icache always hit
stopat u_core.u_frontend.icache_valid_i
assume {u_core.u_frontend.icache_valid_i == 1'b1}

# set clock and reset signal
clock clk_i
reset rst_i

# set max runtime
set_prove_time_limit 259200s
set_engine_mode {Mp R Oh Hps Hts Tri}

# make jg execute the properties
prove -all