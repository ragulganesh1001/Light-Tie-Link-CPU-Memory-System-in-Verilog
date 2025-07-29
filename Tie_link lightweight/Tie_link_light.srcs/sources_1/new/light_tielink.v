// tielink_light
module light_tielink (
    input clk,
    input rst,

    // CPU-side inputs
    input [7:0] cpu_addr,
    input [7:0] cpu_wdata,
    input cpu_write_en,
    input cpu_read_en,

    // CPU-side outputs
    output [7:0] cpu_rdata,
    output cpu_ready,

    // Memory-side outputs
    output [7:0] mem_addr,
    output [7:0] mem_wdata,
    output mem_write_en,
    output mem_read_en,

    // Memory-side inputs
    input [7:0] mem_rdata,
    input mem_ready
);

    // Simple signal forwarding
    assign mem_addr      = cpu_addr;
    assign mem_wdata     = cpu_wdata;
    assign mem_write_en  = cpu_write_en;
    assign mem_read_en   = cpu_read_en;

    assign cpu_rdata     = mem_rdata;
    assign cpu_ready     = mem_ready;

endmodule
