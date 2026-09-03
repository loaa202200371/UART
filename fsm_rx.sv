module fsm_rx(
    input logic clk,
    input logic rst,
    input logic i_rx,
    input logic edge_A,
    input logic par_en,
    input logic s2p_done,
    input logic parity_check_done,   
    input logic frame_chech_done,   
    output logic parellal_en,
    output logic parity_check_En,
    output logic frame_chech_En,
    output logic o_busy,
    output logic o_valid
);
    typedef enum logic [2:0] {
        S0_idle,
        S1_data,
        S2_parity,
        S3_stop,
        S4_done
    } fsm_state;

    fsm_state curr_state, next_state;

    always_ff @(posedge clk or negedge rst) begin
        if (!rst) curr_state <= S0_idle;
        else      
	    curr_state <= next_state;
    end

    always_comb begin
        next_state = curr_state;
        parellal_en = 1'b0;
        parity_check_En = 1'b0;
        frame_chech_En = 1'b0;
        o_busy = 1'b0;
        o_valid = 1'b0;

        case (curr_state)
            S0_idle: begin
                if (edge_A) begin
                    next_state = S1_data; 
            end
            end

            S1_data: begin
                o_busy = 1'b1;
                parellal_en = 1'b1;
                if (s2p_done) begin
                    next_state = par_en ? S2_parity : S3_stop;
                end
            end

            S2_parity: begin
                o_busy = 1'b1;
                parity_check_En = 1'b1;  
                next_state = S3_stop;
            end

            S3_stop: begin
                o_busy = 1'b1;
                frame_chech_En = 1'b1; 
                next_state = S4_done;
            end

            S4_done: begin
                o_valid = 1'b1;
                next_state = S0_idle;
            end

            default: next_state = S0_idle;
        endcase
    end
endmodule