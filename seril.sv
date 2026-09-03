module Serializer #(parameter N = 8)(
    input  logic clk,
    input  logic res,
    input  logic Ser_En,
    input  logic [N-1:0] P_in,
    output logic Ser_done,
    output logic Ser_in
);
    logic [N-1:0] shift_reg;
    logic [$clog2(N):0] counter;

    always_ff @(posedge clk or negedge res) begin
        if (!res) begin
            Ser_in <= 1'b0;
            counter <= 0;
            shift_reg <= 0;
        end
        else if (Ser_En) begin
            if (counter == 0) begin
                shift_reg <= P_in >> 1;
                Ser_in <= P_in[0];
                counter <= counter + 1'b1;
            end
            else if (counter < N) begin
                Ser_in <= shift_reg[0];
                shift_reg <= shift_reg >> 1;
                counter <= counter + 1'b1;
            end
        end
        else begin
            counter <= 0;
        end
    end
    assign Ser_done = Ser_En && (counter == N);
endmodule