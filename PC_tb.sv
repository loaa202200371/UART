module Par_calc_TB #(parameter N=8);
    logic P_Bit;
    logic clk, res;
    logic V_input;
    logic [N-1:0] P_in;
    logic Par_bit;

    Par_calc DUT(
        .P_Bit(P_Bit),
        .clk(clk),
        .res(res),
        .V_input(V_input),
        .P_in(P_in),
        .Par_bit(Par_bit)
    );
    initial begin
        clk=0;
    forever begin
        #5 clk=~clk;
    end
    end

    initial begin
        $monitor ("P_Bit=%b |clk=%b | res=%b | V_input=%b| P_in=%b |Par_bit=%b", P_Bit, clk, res, V_input, P_in, Par_bit);
    end

    initial begin 
        clk = 1'b0; res = 1'b1; P_Bit = 1'b0;
 	V_input = 1'b0; P_in = 8'b0;
    
	#10 res = 1'b0;  
	#10 res = 1'b1; 
        P_Bit=1'b1; V_input=1'b1; P_in=8'b00001111;
        #10; 
        P_Bit=1'b1; V_input=1'b0; P_in=8'b00001111;
        #10;
        P_Bit=1'b0; V_input=1'b1; P_in=8'b00001111;
        #10
        P_Bit=1'b0; V_input=1'b0; P_in=8'b00001111;
	#10;

        P_Bit=1'b1; V_input=1'b1; P_in=8'b00000001;
        #10; 
        P_Bit=1'b1; V_input=1'b0; P_in=8'b00000001;
        #10;
        P_Bit=1'b0; V_input=1'b1; P_in=8'b00000001;
        #10
        P_Bit=1'b0; V_input=1'b0; P_in=8'b00000001;
    end

endmodule


