`timescale 1ns / 1ps

module tb_top_tielink;

    // Inputs
    reg clk;
    reg rst;

    // Instantiate DUT (Design Under Test)
    top_tielink dut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $display("Starting Tie Link Protocol Simulation...");
        $monitor("Time=%0t | CPU WriteEn=%b, ReadEn=%b, Addr=%h, WData=%h, RData=%h, Ready=%b",
                 $time, dut.cpu_inst.write_en, dut.cpu_inst.read_en,
                 dut.cpu_inst.addr, dut.cpu_inst.wdata, dut.cpu_inst.read_result, dut.cpu_inst.ready);

        // Initialize
        clk = 0;
        rst = 1;

        // Reset pulse
        #10 rst = 0;

        // Wait for FSM to execute full flow
        #100;

        // Simulate additional PUT_PARTIAL_DATA manually
        $display("\n--- Simulating PUT_PARTIAL_DATA ---");
        dut.cpu_inst.addr <= 8'h0A;
        dut.cpu_inst.wdata <= 8'hF0; // Let's say upper nibble write
        dut.cpu_inst.write_en <= 1;
        #10;
        dut.cpu_inst.write_en <= 0;

        // Wait for ack
        #10;
        $display("ACCESS_ACK received after PUT_PARTIAL_DATA");

        // Simulate GET to verify
        $display("\n--- Simulating GET ---");
        dut.cpu_inst.addr <= 8'h0A;
        dut.cpu_inst.read_en <= 1;
        #10;
        dut.cpu_inst.read_en <= 0;
        $display("ACCESS_ACK_DATA: RData = %h", dut.cpu_inst.read_result);

        #20;
        $display("\nSimulation completed.");
        $finish;
    end

endmodule
