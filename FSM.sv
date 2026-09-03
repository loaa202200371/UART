module FSM_control (
    input  logic P_En,
    input  logic clk, res,
    input  logic V_input,
    input  logic Ser_done,
    output logic Ser_En,
    output logic [1:0] Sel,
    output logic Busy
);
    typedef enum logic [2:0] {
        S0_IDLE,
        S1_START,
        S2_DATA,
        S3_PARITY,
        S4_STOP
    } FSM_state;

    FSM_state current_state, next_state;

    always_ff @(posedge clk or negedge res) begin
        if (!res) current_state <= S0_IDLE;
        else 
	    current_state <= next_state;
    end

    always_comb begin
        next_state = current_state;
        Ser_En = 1'b0;
        Busy = 1'b1;
        Sel = 2'b01;

        case (current_state)
            S0_IDLE: begin
                Busy = 1'b0;
                Sel = 2'b01;
                if (V_input) begin
                    next_state = S1_START;
                end
            end

            S1_START: begin
                Sel = 2'b00;
                Ser_En = 1'b1; 
                next_state = S2_DATA;
            end

            S2_DATA: begin
                Ser_En = 1'b1;
                Sel = 2'b11;
                if (Ser_done) begin
                    next_state = P_En ? S3_PARITY : S4_STOP;
                end
            end

            S3_PARITY: begin
                Sel = 2'b10; 
                next_state = S4_STOP;
            end

            S4_STOP: begin
                Sel = 2'b01; 
                next_state = S0_IDLE;
            end

            default: next_state = S0_IDLE;
        endcase
    end
endmodule