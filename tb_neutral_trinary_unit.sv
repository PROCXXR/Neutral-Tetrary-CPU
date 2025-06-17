// tb_neutral_trinary_unit.sv

module tb_neutral_trinary_unit;
    logic clk = 0;
    logic rst;
    logic start;
    logic [1:0] init_state;
    logic [1:0] result;

    always #5 clk = ~clk;  // 100MHz clock

    NeutralTrinaryUnit uut (
        .clk(clk),
        .rst(rst),
        .start_process(start),
        .initial_state(init_state),
        .resolved_state(result)
    );

    initial begin
        $display("Simulation start");
        rst = 1;
        start = 0;
        init_state = 2'b10; // Unstable state
        #10;
        rst = 0;
        start = 1;
        #10;
        start = 0;

        repeat (5) begin
            #10;
            $display("Resolved State: %b", result);
        end

        $finish;
    end
endmodule
