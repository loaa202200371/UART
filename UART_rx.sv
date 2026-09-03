module uart_rx #(parameter DATA_W = 8) (
    input  logic i_clk,
    input  logic i_rst_n,
    input  logic i_rx,
    input  logic i_par_en,
    input  logic i_par_odd,
    output logic [DATA_W-1:0] o_data,
    output logic o_valid,
    output logic o_busy,
    output logic o_parity_err,
    output logic o_frame_err
);
    logic parellal_en;
    logic s2p_done;
    logic edge_A;
    logic parity_check_En;
    logic parity_check_done;
    logic frame_chech_done;
    logic frame_chech_En;

    fsm_rx fsm_rx (
        .clk(i_clk),
        .rst(i_rst_n),
        .i_rx(i_rx),
        .o_valid(o_valid),
        .o_busy(o_busy),
        .par_en(i_par_en),
        .edge_A(edge_A),
        .parellal_en(parellal_en),
        .s2p_done(s2p_done),
        .parity_check_En(parity_check_En),
        .parity_check_done(parity_check_done),
        .frame_chech_En(frame_chech_En),
        .frame_chech_done(frame_chech_done)
    );

    parity_check #(.N(DATA_W)) parity_check (
        .clk(i_clk),
        .rst(i_rst_n),
        .i_rx(i_rx),
        .o_data(o_data),
        .o_parity_err(o_parity_err),
        .parity_check_done(parity_check_done),
        .parity_check_En(parity_check_En),
        .parity_en(i_par_en),
        .parity_odd(i_par_odd)
    );

    s2p #(.N(DATA_W)) s2p (
        .serial_in(i_rx),
        .parellal_en(parellal_en),
        .clk(i_clk),
        .rst(i_rst_n),
        .o_data(o_data),
        .s2p_done(s2p_done)
    );

    edge_dt edge_dt (
        .clk(i_clk),
        .rst(i_rst_n),
        .i_rx(i_rx),
        .edge_A(edge_A)
    );

    frame_check #(.N(DATA_W)) frame_check (
        .clk(i_clk),
        .rst(i_rst_n),
        .i_rx(i_rx),
        .frame_chech_En(frame_chech_En),
        .frame_chech_done(frame_chech_done),
        .frame_err(o_frame_err)
    );
endmodule
