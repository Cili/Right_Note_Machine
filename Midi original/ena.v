module ena(
    input clk,
    output reg pulse1,
    output reg pulse2,
    output reg pulse3
    
    );//100Mhz clk signal
    integer ii = 0,kk = 0,cc = 0;// set 3 time counting number 
    parameter I = 99999, K = 3125000,C=6250000;//
    always@ (posedge clk)
    begin
        if (ii == I - 1)
        begin 
        ii <= 0; pulse1 <= 1;
        end
        else
        begin 
        ii <= ii+1;pulse1 <= 0;
        end
    end
        always@ (posedge clk)
    begin
        if (kk == K-1)
        begin 
        kk <= 0; pulse2 <= 1;
        end
        else
        begin 
        kk <= kk+1;pulse2<= 0;
        end
    end 
         always@ (posedge clk)
    begin
        if (cc == C-1)
        begin 
        cc <= 0; pulse3 <= 1;
        end
        else
        begin 
        cc <= cc+1;pulse3<= 0;
        end
    end 
endmodule