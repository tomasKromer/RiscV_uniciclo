

module top(input logic clk,sw,
           output logic led);

logic clk_out;
    
clk_wiz_0 inst1 (clk_out,sw,clk);
CPU cpu1 (clk_out,sw,led);

    
    
endmodule
