module TOP(clk,reset,RD,RS1,RS2,imm);
input clk;
input reset;
output [4:0] RD;
output [4:0] RS1;
output [4:0] RS2;
output [11:0] imm;
wire [7:0] PCi, PCo;
wire [31:0] IS;

	PC PCf (clk, reset, PCi, PCo);
	adder adderf (clk, reset, PCi, PCo);
	ROM ROMf (IS, clk, PCo);
	instruc_decoder decoderf (IS, RD, RS1, RS2,imm);

endmodule





module PC(clk,reset,PCi,PCo);
input clk;
input reset;
input [7:0] PCi;
output reg [7:0] PCo;

always @(posedge clk) begin
	if (reset)
		PCo = 8'd0;
		
	else 
		PCo = PCi;
	end
endmodule




module adder(clk,reset,PCi,PCo);
input clk;
input reset;
output reg [7:0] PCi;
input [7:0] PCo;

always @(posedge clk) begin
	if (reset)
		PCi = 8'd0;
		
	else
		PCi = PCo +8'd4;
	end
endmodule




module ROM (IS, clk, PCo);
output reg [31:0] IS;
input [7:0] PCo;
input clk;

always @(posedge clk) begin

	case (PCo)
	
		8'd00: IS = 32'h00450693;
		8'd04: IS = 32'h00100713;
		8'd08: IS = 32'h00b76463;
		8'd12: IS = 32'h00008067;
		8'd16: IS = 32'h0006a803;
		8'd20: IS = 32'h00068613;
		8'd24: IS = 32'h00070793;
		8'd28: IS = 32'hffc62883;
		8'd32: IS = 32'h01185a63;
		8'd36: IS = 32'h01162023;
		8'd40: IS = 32'hfff78793;
		8'd44: IS = 32'hffc60613;
		8'd48: IS = 32'hfe0796e3;
		8'd52: IS = 32'h00279793;
		8'd56: IS = 32'h00f507b3;
		8'd60: IS = 32'h0107a023;
		8'd64: IS = 32'h00170713;
		8'd68: IS = 32'h00468693;
		8'd72: IS = 32'hfc1ff06f;
		
	endcase
end
endmodule




module instruc_decoder(IS,RD,RS1,RS2,imm);
input [31:0] IS;
output reg [4:0] RD;
output reg [4:0] RS1;
output reg [4:0] RS2;
output reg [11:0] imm;

always @(IS) begin

	RD = IS [11:7];
	RS1 = IS [19:15];
	RS2 = IS [24:20];
	imm = IS [31:20];
	
	end
endmodule




