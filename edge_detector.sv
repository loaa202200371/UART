module edge_dt (
    input  logic clk,
    input  logic rst,
    input  logic i_rx,
    output logic edge_A
);
    logic A_reg;

    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            A_reg <= 1'b1;
        end else begin
            A_reg <= i_rx;
        end
    end
    
    assign edge_A = A_reg && !i_rx;
endmodule