module frame_check #(parameter N = 8)(
    input logic clk,
    input logic rst,
    input logic frame_chech_En,
    input logic i_rx,
    output logic frame_chech_done,
    output logic frame_err
);
    logic captured_stop;

    always_ff @(posedge clk or negedge rst) begin
        if (!rst)
            captured_stop <= 1'b1;
        else if (frame_chech_En)
            captured_stop <= i_rx;
    end

    assign frame_chech_done = frame_chech_En;
    assign frame_err = ~captured_stop;
endmodule

