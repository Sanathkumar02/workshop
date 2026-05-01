```
# ==================================================
# Simple SDC File for FIFO - Training Purpose
# ==================================================

# --------------------------------------------------
# STEP 1: CREATE CLOCK
# --------------------------------------------------
create_clock -name clk_i -period 10 [get_ports clk_i]
#            clock name   10ns=100MHz  which port

# --------------------------------------------------
# STEP 2: CLOCK UNCERTAINTY
# --------------------------------------------------
set_clock_uncertainty -setup 0.5 [get_clocks clk_i]
set_clock_uncertainty -hold  0.3 [get_clocks clk_i]

# --------------------------------------------------
# STEP 3: CLOCK TRANSITION
# --------------------------------------------------
set_clock_transition -rise 0.2 [get_clocks clk_i]
set_clock_transition -fall 0.2 [get_clocks clk_i]

# --------------------------------------------------
# STEP 4: INPUT DELAY
# --------------------------------------------------
set_input_delay -max 2 -clock clk_i [get_ports rst_i]
set_input_delay -max 2 -clock clk_i [get_ports wr_en_i]
set_input_delay -max 2 -clock clk_i [get_ports rd_en_i]
set_input_delay -max 2 -clock clk_i [get_ports wdata_i]

# --------------------------------------------------
# STEP 5: OUTPUT DELAY
# --------------------------------------------------
set_output_delay -max 2 -clock clk_i [get_ports rdata_o]
set_output_delay -max 2 -clock clk_i [get_ports full_o]
set_output_delay -max 2 -clock clk_i [get_ports empty_o]
set_output_delay -max 2 -clock clk_i [get_ports error_o]

# --------------------------------------------------
# STEP 6: FALSE PATH FOR RESET
# --------------------------------------------------
set_false_path -from [get_ports rst_i]
```
