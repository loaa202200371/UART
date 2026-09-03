module parity_check #(parameter N = 8)(
    input  logic clk,
    input  logic rst,
    input  logic parity_check_En,
    input  logic i_rx,
    input  logic [N-1:0] o_data,
    input  logic parity_odd,
    input  logic parity_en,
    output logic parity_check_done,
    output logic o_parity_err
);
    logic captured_parity;
    logic expected_parity;

    always_ff @(posedge clk or negedge rst) begin
        if (!rst)
            captured_parity <= 1'b0;
        else if (parity_check_En)
            captured_parity <= i_rx;
    end

    assign parity_check_done = parity_check_En;
    assign expected_parity   = parity_odd ? ~^o_data : ^o_data;

    always_comb begin
        if (!parity_en)
            o_parity_err = 1'b0;
        else
            o_parity_err = (captured_parity !== expected_parity);
    end
endmodule
