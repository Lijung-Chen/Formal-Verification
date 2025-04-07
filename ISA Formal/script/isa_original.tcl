# you can modify it
clear -all
check_cov -init -type all

# include source code
analyze -v2k [glob ./source/original/biriscv/icache/*.v]
analyze -v2k [glob ./source/original/biriscv/dcache/*.v]
analyze -v2k [glob ./source/original/biriscv/core/*.v]
analyze -v2k [glob ./source/original/biriscv/top/riscv_top.v]

# include assertion property
analyze -sv  [glob ./property/isa.sva]

# top module
elaborate -top riscv_top

# icache always hit
stopat u_core.u_frontend.icache_valid_i
assume {u_core.u_frontend.icache_valid_i == 1'b1}

# no interrupt
stopat u_core.take_interrupt_w
assume {u_core.take_interrupt_w == 1'b0}

# always fetch legal instruction
stopat u_core.u_frontend.fetch_instr_w
assume {
    ((((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h7013)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h13)            ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h2013)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h3013)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h6013)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h4013)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hfc00707f) == 32'h1013)      ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hfc00707f) == 32'h5013)      ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hfc00707f) == 32'h40005013)  ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h7f) == 32'h37)              ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h7f) == 32'h17)              ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hfe00707f) == 32'h33)        ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hfe00707f) == 32'h40000033)  ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hfe00707f) == 32'h2033)      ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hfe00707f) == 32'h3033)      ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hfe00707f) == 32'h4033)      ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hfe00707f) == 32'h6033)      ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hfe00707f) == 32'h7033)      ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hfe00707f) == 32'h1033)      ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hfe00707f) == 32'h5033)      ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hfe00707f) == 32'h40005033)  ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h7f) == 32'h6f)              ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h67)            ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h63)            ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h1063)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h4063)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h5063)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h6063)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h7063)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h3)             ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h1003)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h2003)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h4003)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h5003)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h6003)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h23)            ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h1023)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h2023)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hffffffff) == 32'h73)        ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hffffffff) == 32'h100073)    ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hcfffffff) == 32'h200073)    ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h1073)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h2073)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h3073)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h5073)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h6073)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h7073)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hffff8fff) == 32'h10500073)  ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'hf)             ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'h707f) == 32'h100f)          ||
     (((u_core.u_frontend.fetch_instr_w[6:0]) & 32'hfe007fff) == 32'h12000073))
}

assume {
    ((((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h7013)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h13)            ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h2013)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h3013)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h6013)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h4013)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hfc00707f) == 32'h1013)      ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hfc00707f) == 32'h5013)      ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hfc00707f) == 32'h40005013)  ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h7f) == 32'h37)              ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h7f) == 32'h17)              ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hfe00707f) == 32'h33)        ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hfe00707f) == 32'h40000033)  ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hfe00707f) == 32'h2033)      ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hfe00707f) == 32'h3033)      ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hfe00707f) == 32'h4033)      ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hfe00707f) == 32'h6033)      ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hfe00707f) == 32'h7033)      ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hfe00707f) == 32'h1033)      ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hfe00707f) == 32'h5033)      ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hfe00707f) == 32'h40005033)  ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h7f) == 32'h6f)              ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h67)            ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h63)            ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h1063)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h4063)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h5063)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h6063)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h7063)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h3)             ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h1003)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h2003)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h4003)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h5003)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h6003)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h23)            ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h1023)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h2023)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hffffffff) == 32'h73)        ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hffffffff) == 32'h100073)    ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hcfffffff) == 32'h200073)    ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h1073)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h2073)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h3073)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h5073)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h6073)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h7073)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hffff8fff) == 32'h10500073)  ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'hf)             ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'h707f) == 32'h100f)          ||
     (((u_core.u_frontend.fetch_instr_w[38:32]) & 32'hfe007fff) == 32'h12000073))
}

# set clock and reset signal
clock clk_i
reset rst_i

# set max runtime
set_prove_time_limit 259200s

# make jg execute the properties
prove -all