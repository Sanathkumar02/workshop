set target_library ./../ref/lib/stdcell_rvt/saed32rvt_tt0p78vn40c.db 

      set link_library ./../ref/lib/stdcell_rvt/saed32rvt_tt0p78vn40c.db
       
       set RTL_SOURCE_FILES ./../Design/fifo.v

	set DESIGN_NAME fifo

       define_design_lib WORK -path ./WORK
       set_app_var hdlin_enable_hier_map true
       analyze -format verilog ${RTL_SOURCE_FILES}
       elaborate ${DESIGN_NAME}
      link
      
current_design
    
read_sdc ./../Design/fifo.sdc

      
      
      
      set_verification_top
      compile
      report_timing -delay_type max
      report_timing -delay_type min
      compile_ultra
      
      report_timing -delay_type min
      
      report_timing -delay_type max
      write -format verilog -hierarchy -output ./
      write -format verilog -hierarchy -output ./full_adder_netlist.v
      report_qor
      report_area
      report_power
