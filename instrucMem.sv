//Modulo de memoria de instrucciones
//Funcionalidad: introducir direccion y devolver siguiente instruccion

module instrucMem #(parameter Nbits=32)
                   (input logic [63:0] address,
                    output logic [Nbits-1:0] instruc);

logic [Nbits-1:0] ram [255:0];

initial
begin
    $readmemh("memInst.mem", ram);
end
                    
assign instruc = ram[address[7:0]/4];                    
                    
endmodule
