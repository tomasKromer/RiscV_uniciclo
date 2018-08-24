module PC #(parameter Nbits=64)
         (input logic [Nbits-1:0] inPC,
          input logic clk,rst,
          output logic [Nbits-1:0] outPC);
 
         
 always_ff @(posedge clk)
    if (rst)
        outPC <= 0;
    else
        outPC <= inPC;        
         
endmodule
