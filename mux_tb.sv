module Mux_TB();
    logic B_start;
    logic B_end;
    logic Ser_in;
    logic Par_bit;
    logic [1:0]Sel;
    logic Tx_out;

    MUX DUT(
        .B_start(B_start),
        .B_end(B_end),
        .Ser_in(Ser_in),
        .Par_bit(Par_bit),
        .Sel(Sel),
        .Tx_out(Tx_out)
    );
	initial begin
	$monitor("B_start=%b |B_end=%b |Ser_in=%b |Par_bit=%b |Sel=%b |Tx_out=%b", 
	B_start, B_end, Ser_in, Par_bit, Sel, Tx_out );
	end
    initial begin
        B_start=1'b0;
        B_end=1'b1;
        Ser_in=1'b0;
        Par_bit=1'b1;

        #10;
        Sel=2'b00; #10;
        Sel=2'b01; #10;
        Sel=2'b10; #10;
        Sel=2'b11; #10;
    end
endmodule

