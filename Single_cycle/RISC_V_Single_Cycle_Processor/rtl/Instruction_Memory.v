module Instruction_Memory(
			  input [31:0] 	A,
			  output [31:0] RD
			  );

   initial
     begin
	$readmemh("/home/govardhan/Documents/RISC_V_Single_Cycle_Processor/sources_1/imports/src_single/instructions.txt",I_MEM_BLOCK);
	//$readmemh("C:/Users/saigo/Desktop/Govardhan_RISC_V/Single_Cycle_Govardhan_Final/Single_Cycle_Govardhan_Final.srcs/sources_1/imports/src_single/instructions.txt",I_MEM_BLOCK);
     end

   assign RD = I_MEM_BLOCK[A[31:2]]; // word aligned

endmodule
