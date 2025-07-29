// cpu.v
module cpu (
    input clk,
    input rst,
    output reg [7:0] addr,
    output reg [7:0] wdata,
    output reg write_en,
    output reg read_en,
    input [7:0] rdata,
    input ready
);

    // FSM states
    reg [3:0] state;

    // Register to store the read data
    reg [7:0] read_result;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 0;
            addr <= 8'd0;
            wdata <= 8'd0;
            write_en <= 1'b0;
            read_en <= 1'b0;
            read_result <= 8'd0;
        end else begin
            case (state)
                4'd0: begin
                    // Start: Write phase
                    addr <= 8'd5;        // Memory address
                    wdata <= 8'hA5;      // Data to write
                    write_en <= 1'b1;    // Enable write
                    read_en <= 1'b0;
                    state <= 4'd1;
                end

                4'd1: begin
                    // Wait for write complete
                    if (ready) begin
                        write_en <= 1'b0;
                        state <= 4'd2;
                    end
                end

                4'd2: begin
                    // Start: Read phase
                    addr <= 8'd5;
                    read_en <= 1'b1;
                    write_en <= 1'b0;
                    state <= 4'd3;
                end

                4'd3: begin
                    // Wait for read complete
                    if (ready) begin
                        read_en <= 1'b0;
                        read_result <= rdata;  // Capture read data
                        state <= 4'd4;
                    end
                end

                4'd4: begin
                    // Idle / Done
                    // Remain here or optionally compare result
                    state <= 4'd4;
                end

                default: state <= 4'd0;
            endcase
        end
    end

endmodule
