module MUX (
    input  logic Ser_in,
    input  logic Par_bit,
    input  logic [1:0] Sel,
    output logic Tx_out
);
    always_comb begin
        case (Sel)
            2'b00:   Tx_out = 1'b0;
            2'b01:   Tx_out = 1'b1;
            2'b10:   Tx_out = Par_bit;
            2'b11:   Tx_out = Ser_in;
            default: Tx_out = 1'b1;
        endcase
    end
endmodule