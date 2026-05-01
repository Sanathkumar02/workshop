set target_library ./dc/ref/models/saed90nm_typ_ht.db
       set link_library ./dc/ref/models/saed90nm_typ_ht.db
       set $RTL_SOURCE_FILES ./full_adder.v
       set RTL_SOURCE_FILES ./full_adder.v
       set DESIGN_NAME full_adder
       define_design_lib WORK -path ./WORK
       set_app_var hdlin_enable_hier_map true
       analyze -format verilog ${RTL_SOURCE_FILES}
       elaborate ${DESIGN_NAME}
      link
      current_design
     read_sdc ./full_adder.sdc
      vi full_adder.sdc
      read_sdc ./full_adder.sdc
      report_timing -delay_type min
     report_timing -delay_type max
      start_gui
      compile
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
