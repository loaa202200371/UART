module FSM_control_TB();
    logic P_En;
    logic clk, res;
    logic V_input;
    logic Ser_done;
    logic Ser_En;
    logic [1:0]Sel;
    logic Busy;

    FSM_control DUT(
        .clk(clk),
        .res(res),
        .P_En(P_En),
        .V_input(V_input),
        .Ser_done(Ser_done),
        .Ser_En(Ser_En),
        .Sel(Sel),
        .Busy(Busy)
    );
    initial begin
        clk=0;
        forever begin
            #5 clk=~clk;
        end
    end
    initial begin
        $monitor("P_En=%b |V_input=%b |Ser_done=%b |Ser_En=%b |Sel=%b |Busy=%b ",
        P_En, V_input, Ser_done, Ser_En, Sel, Busy);
    end

    initial begin
        clk=1'b0; res=1'b1; P_En=1'b0; V_input=1'b0; Ser_done=1'b0;
        #10 res=0;
        P_En=1'b0; V_input=1'b0; Ser_done=1'b0; #10;
        P_En=1'b0; V_input=1'b0; Ser_done=1'b1; #10;
        P_En=1'b0; V_input=1'b1; Ser_done=1'b0; #10;
        P_En=1'b0; V_input=1'b1; Ser_done=1'b1; #10;
        P_En=1'b1; V_input=1'b0; Ser_done=1'b0; #10;
        P_En=1'b1; V_input=1'b0; Ser_done=1'b1; #10;
        P_En=1'b1; V_input=1'b1; Ser_done=1'b0; #10;
        P_En=1'b1; V_input=1'b1; Ser_done=1'b1; #10;
    end





    endmodule
