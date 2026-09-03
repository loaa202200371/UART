module s2p #(parameter N = 8)(
    input  logic serial_in,
    input  logic parellal_en,
    input  logic clk,
    input  logic rst,
    output logic [N-1:0] o_data,
    output logic s2p_done
);
    logic [N-1:0] register;
    logic [$clog2(N):0] counter;

    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            o_data <= {N{1'b0}};
            register <= 0;
            counter <= 0;
        end
        else if (parellal_en) begin
            register <= {serial_in, register[N-1:1]};
            if (counter == (N-1)) begin
                counter <= 1'b0;
                o_data <= {serial_in, register[N-1:1]};  
            end
            else begin
                counter <= counter + 1'b1;
            end
        end
        else begin
            counter <= 0;
        end
    end

    assign s2p_done = parellal_en && (counter == (N-1));
endmodule