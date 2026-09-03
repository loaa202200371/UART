module Serializer_tb #(parameter N = 8);
    logic [N-1:0] P_in;
    logic Ser_En;
    logic clk, res;
    logic Ser_done;
    logic Ser_in;


    Serializer #(N) DUT (
        .clk(clk),
        .P_in(P_in),
        .res(res),
        .Ser_done(Ser_done),
        .Ser_En(Ser_En),
        .Ser_in(Ser_in)
    );


    initial begin 
        clk = 0;
        forever begin
	#5 clk = ~clk;
    end
    end
 
    initial begin
        $monitor(" clk=%b | res=%b | P_in=%b | Ser_En=%b | Ser_done=%b | Ser_in=%b", 
                  clk, res, P_in, Ser_En, Ser_done, Ser_in);
    end

    initial begin

        res = 1'b0; 
        Ser_En = 1'b0; 
        P_in = 8'b0;
        
        #10 res = 1'b1;
        

        #10  P_in = 8'b11000001; 
            Ser_En = 1'b1;
        #100;
        

    end

endmodule
