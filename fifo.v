```
module fifo(
    clk_i, rst_i, wr_en_i, wdata_i, rd_en_i, rdata_o, full_o, empty_o, error_o
);
    input clk_i;
    input rst_i;
    input wr_en_i;
    input [7:0] wdata_i;
    input rd_en_i;
    output reg [7:0] rdata_o;
    output reg full_o;
    output reg empty_o;
    output reg error_o;

    reg [3:0] wr_ptr, rd_ptr;
    reg wr_toggle_f, rd_toggle_f;
    reg [7:0] fifo [15:0];
    integer i;

    always @(posedge clk_i) begin
        if (rst_i == 1) begin
            rdata_o     <= 0;
            error_o     <= 0;
            wr_ptr      <= 0;
            rd_ptr      <= 0;
            wr_toggle_f <= 0;
            rd_toggle_f <= 0;
            for (i = 0; i < 16; i = i + 1)
                fifo[i] <= 0;
            //  Don't drive full_o/empty_o here
            // Let combinational block handle it
        end
        else begin
            error_o <= 0;

            if (wr_en_i == 1) begin
                if (full_o == 1) begin
                    error_o <= 1;
                end
                else begin
                    fifo[wr_ptr] <= wdata_i;
                    if (wr_ptr == 15) begin
                        wr_ptr      <= 0;
                        wr_toggle_f <= ~wr_toggle_f;
                    end
                    else
                        wr_ptr <= wr_ptr + 1;
                end
            end

            if (rd_en_i == 1) begin
                if (empty_o == 1) begin
                    error_o <= 1;
                end
                else begin
                    rdata_o <= fifo[rd_ptr];
                    if (rd_ptr == 15) begin
                        rd_ptr      <= 0;
                        rd_toggle_f <= ~rd_toggle_f;
                    end
                    else
                        rd_ptr <= rd_ptr + 1;
                end
            end
        end
    end

    //  Combinational block for full/empty
    // Runs automatically when pointers change
    always @(wr_ptr, rd_ptr, wr_toggle_f, rd_toggle_f) begin
        full_o  = 0;
        empty_o = 0;
        if (wr_ptr == rd_ptr) begin
            if (wr_toggle_f == rd_toggle_f)
                empty_o = 1;  //  Correctly 1 after reset
            else
                full_o = 1;
        end
    end

endmodule

```
