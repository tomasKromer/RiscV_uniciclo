//Modulo CPU
//Funciones: Instaciar todos los modulos particulares del cpu e interconectarlos para lograr el funcionamiento de un cpu
//Recordar que este sistema es de CPI = 1


module CPU #(parameter Nbits=64)
           (input logic clk,rst,
           //output logic [Nbits-1:0] dataOut,
           output logic led);

logic aluSRC,memToReg,r_enable,w_enable_reg,w_enable_mem,branch,zero,selInstrNext;
logic [63:0] regData,memData,pc,reg1,reg2,w_data_mem,r_data_mem,immediate,aluInB,aluInA,aluResult,nextIns,pc_actual,nextInsBranch,muxMemToReg;
logic [31:0] instruc;
logic [1:0] aluOp;
logic [3:0] selOp;
logic [2:0] fun3;
logic [6:0] fun7;
logic [4:0] addr_reg1,addr_reg2,addr_regW;
logic [6:0] opcode;
logic [63:0] x6;


//instanciacion de multiplexores del sistema
mux2 selAluS(reg2,immediate,aluSRC,aluInB);//multiplexor para control entrada B de la ALU
mux2 selMemToReg(aluResult,r_data_mem,memToReg,muxMemToReg);//multiplexor para control si la salida es de memoria o de la ALU
mux2 selBranch(nextIns,nextInsBranch,selInstrNext,pc);//multiplexor para control del salto por branch


//instanciacion de unidades de control del sistema
controlCPU monitoreo(opcode,aluOp,branch,w_enable_mem,w_enable_reg,memToReg,aluSRC,r_enable);//unidad de control de todo el sistema
PC contadordeProg (pc,clk,rst,pc_actual);//bloque donde se actualiza el programCounter
aluControl controlALU(fun3,fun7,aluOp,selOp);//unidad de contro de la ALU

//instanciacion de unidades de memoria del sistema
instrucMem memoriaInstruc(pc_actual,instruc);//Memoria de instruccion
memSys memoriaSistema (w_enable_mem,clk,r_enable,aluResult,w_data_mem,r_data_mem);//Memoria del sistema 
regMem memoriaRegistros (w_enable_reg,clk,addr_reg1 ,addr_reg2,addr_regW,muxMemToReg,reg1,reg2,x6);//Registros de memoria del procesador


//instanciacion de unidades de procesamiento del sistema
alu aluPro (aluInA,aluInB,selOp,zero,aluResult);//La unidad ALU del procesador
immedia_32a64 traduccion32a64(instruc,immediate);//Traduccion de la constante inmediata de 12 a 64 bits
addNextIns calNextInst(pc_actual,nextIns);// calculador de la siguiente instruccion
nextInsBran nextInsSiBranch (pc_actual,immediate,nextInsBranch); //Calculador de la siguiente instruccion si hubo un branch


//logica adicional del sistema
assign w_data_mem = reg2;
assign aluInA = reg1;
assign selInstrNext = zero & branch;
assign addr_reg1 = instruc[19:15];
assign addr_reg2 = instruc[24:20];
assign addr_regW = instruc[11:7];
assign opcode = instruc[6:0];
assign fun3 = instruc[14:12];
assign fun7 = instruc[31:25];
assign led = x6[0];

endmodule
