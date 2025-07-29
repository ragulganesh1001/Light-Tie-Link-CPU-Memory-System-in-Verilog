// memory.v
module memory (
    input clk,
    input [7:0] addr,
    input [7:0] wdata,
    input write_en,
    input read_en,
    output reg [7:0] rdata,
    output reg ready
);

    // 256 x 8-bit memory
    reg [7:0] mem [0:255];

    // Memory behavior: 1-cycle access delay
    always @(posedge clk) begin
        ready <= 0;

        if (write_en) begin
            mem[addr] <= wdata;
            ready <= 1;  // Write done
        end else if (read_en) begin
            rdata <= mem[addr];
            ready <= 1;  // Read done
        end
    end

endmodule
