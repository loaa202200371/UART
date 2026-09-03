module uart_tx #(parameter DATA_W = 8) (
    input logic i_clk,
    input logic i_rst_n,
    input logic [DATA_W-1:0] i_data,
    input logic i_valid,
    input logic i_par_en,
    input logic i_par_odd,
    output logic o_busy,
    output logic o_tx
);
    logic Ser_done;
    logic Ser_En;
    logic Par_bit;
    logic [1:0] Sel;
    logic Ser_in;

    Par_calc #(.N(DATA_W)) Par_calc_1 (
        .V_input (i_valid),
        .P_in (i_data),
        .P_Bit (i_par_odd),
        .clk (i_clk),
        .Par_bit (Par_bit),
        .res (i_rst_n)
    );

    Serializer #(.N(DATA_W)) Serializer_1 (
        .P_in (i_data),
        .Ser_En (Ser_En),
        .Ser_in (Ser_in),
        .Ser_done (Ser_done),
        .clk (i_clk),
        .res (i_rst_n)
    );

    FSM_control FSM_control_1 (
        .Busy (o_busy),
        .Sel (Sel),
        .Ser_En (Ser_En),
        .Ser_done (Ser_done),
        .V_input (i_valid),
        .P_En (i_par_en),
        .clk (i_clk),
        .res (i_rst_n)
    );

    MUX MUX_1 (
        .Ser_in (Ser_in),
        .Par_bit (Par_bit),
        .Sel (Sel),
        .Tx_out (o_tx)
    );
endmodule