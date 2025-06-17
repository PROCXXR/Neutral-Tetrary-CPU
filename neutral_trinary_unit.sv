// neutral_trinary_unit.sv

module NeutralTrinaryUnit (
    input  logic        clk,
    input  logic        rst,
    input  logic        start_process,
    input  logic [1:0]  initial_state,  // 2'b00 = '+/-', 2'b01 = '+/-', 2'b10 = '+/- or +/-'
    output logic [1:0]  resolved_state
);

    // State encoding
    localparam STATE_POS     = 2'b00;
    localparam STATE_NEG     = 2'b01;
    localparam STATE_UNSTABLE = 2'b10;

    logic [1:0] state;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= STATE_UNSTABLE;  // default
        end else if (start_process) begin
            // If state is unstable, randomly resolve to + or -
            if (initial_state == STATE_UNSTABLE) begin
                state <= ($urandom % 2 == 0) ? STATE_POS : STATE_NEG;
            end else begin
                state <= initial_state;
            end
        end
    end

    assign resolved_state = state;

endmodule
