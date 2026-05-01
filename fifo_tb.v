```
`include "fifo.v"
module top;
    reg clk_i;
    reg rst_i;
    reg wr_en_i;
    reg [7:0] wdata_i;
    reg rd_en_i;
    wire [7:0] rdata_o;
    wire full_o;
    wire empty_o;
    wire error_o;

    // ✅ DUT instantiation
    fifo dut(
        .clk_i   (clk_i),
        .rst_i   (rst_i),
        .wr_en_i (wr_en_i),
        .wdata_i (wdata_i),
        .rd_en_i (rd_en_i),
        .rdata_o (rdata_o),
        .full_o  (full_o),
        .empty_o (empty_o),
        .error_o (error_o)
    );

    // ✅ Clock generation
    always begin
        clk_i = 0; #5;
        clk_i = 1; #5;
    end

    // ✅ Reset + init
    initial begin
        rst_i   = 1;
        wdata_i = 0;
        wr_en_i = 0;
        rd_en_i = 0;
        repeat(2) @(posedge clk_i);
        rst_i = 0;
    end

    // ✅ Finish
    initial begin
        #1000;
        $finish();
    end

    // ✅ Main test - runs all tests automatically
    initial begin
        @(negedge rst_i);  // Wait for reset release
        #2;                // Small delay for safety

        $display("=== TEST 1: FIFO FULL TEST ===");
        write_fifo(16);
        #20;

        $display("=== TEST 2: FULL ERROR TEST ===");
        write_fifo(1);     // Should trigger error_o
        #20;

        $display("=== TEST 3: READ ALL DATA ===");
        read_fifo(16);
        #20;

        $display("=== TEST 4: EMPTY ERROR TEST ===");
        read_fifo(1);      // Should trigger error_o
        #20;

        $display("=== ALL TESTS DONE ===");
        $finish();
    end

    // ✅ Write task
    task write_fifo(integer num_writes);
        integer j;
        begin
            for (j = 0; j < num_writes; j = j + 1) begin
                @(posedge clk_i); #1;
                wdata_i = $random();
                wr_en_i = 1;
                @(posedge clk_i); #1;
                wr_en_i = 0;
                wdata_i = 0;
            end
        end
    endtask

    // ✅ Read task
    task read_fifo(integer num_reads);
        integer k;
        begin
            for (k = 0; k < num_reads; k = k + 1) begin
                @(posedge clk_i); #1;
                rd_en_i = 1;
                @(posedge clk_i); #1;
                rd_en_i = 0;
            end
        end
    endtask

endmodule
```
