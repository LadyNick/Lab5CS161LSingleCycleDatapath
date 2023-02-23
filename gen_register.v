//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: 
// Email: 
// 
// Assignment name: 
// Lab section: 
// TA: 
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

//=========================================================================
//
// DO NOT CHANGE ANYTHING BELOW THIS COMMENT. IT IS PROVIDED TO MAKE SURE 
// YOUR LAB IS SUCCESSFULL. 
//
//=========================================================================

`timescale 1ns / 1ps

module gen_register (clk, rst, write_en, data_in, data_out);

parameter WORD_SIZE = 32 ; 

input wire clk , rst, write_en ;
input wire [WORD_SIZE-1:0] data_in ; 
output reg [WORD_SIZE-1:0] data_out; 

always @(posedge rst or posedge clk )
begin 

	if (rst)  begin 
		data_out <= { WORD_SIZE {1'b0} };
	end 
	else if (clk) begin
	
		if ( write_en )  begin 
			data_out  <= data_in ; 
		end 		
	end 

end 

endmodule
