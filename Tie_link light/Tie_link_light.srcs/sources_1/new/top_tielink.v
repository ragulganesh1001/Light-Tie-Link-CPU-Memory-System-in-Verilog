// top_tielink.v
module top_tielink (
    input clk,
    input rst
);
    // Internal wires connecting components
    wire [7:0] addr, wdata, rdata;
    wire write_en, read_en, ready;

    wire [7:0] mem_addr, mem_wdata, mem_rdata;
    wire mem_write_en, mem_read_en, mem_ready;

    // Instantiate CPU
    cpu cpu_inst (
        .clk(clk),
        .rst(rst),
        .addr(addr),
        .wdata(wdata),
        .write_en(write_en),
        .read_en(read_en),
        .rdata(rdata),
        .ready(ready)
    );

    // Instantiate Light Tie Link
    light_tielink tielink_inst (
        .clk(clk),
        .rst(rst),
        .cpu_addr(addr),
        .cpu_wdata(wdata),
        .cpu_write_en(write_en),
        .cpu_read_en(read_en),
        .cpu_rdata(rdata),
        .cpu_ready(ready),
        .mem_addr(mem_addr),
        .mem_wdata(mem_wdata),
        .mem_write_en(mem_write_en),
        .mem_read_en(mem_read_en),
        .mem_rdata(mem_rdata),
        .mem_ready(mem_ready)
    );

    // Instantiate Memory
    memory mem_inst (
        .clk(clk),
        .addr(mem_addr),
        .wdata(mem_wdata),
        .write_en(mem_write_en),
        .read_en(mem_read_en),
        .rdata(mem_rdata),
        .ready(mem_ready)
    );

endmodule
