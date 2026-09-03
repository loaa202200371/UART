module Par_calc #(parameter N = 8)(
    input  logic P_Bit,
    input  logic clk,
    input  logic res,
    input  logic V_input,
    input  logic [N-1:0] P_in,
    output logic Par_bit
);
    always_ff @(posedge clk or negedge res) begin
        if (!res) begin
            Par_bit <= 1'b0;
        end
        else if (V_input) begin
            if (P_Bit == 1'b0)
                Par_bit <= ^P_in;  
            else
                Par_bit <= ~^P_in;  
        end
    end
endmodule