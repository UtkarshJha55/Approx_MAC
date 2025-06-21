module approx_ANDORwallace (A, B, clk, appxANS, accml, multiply, sum, carry);
	// appxANS - approx multiply
	// multiply - approx answer with error recovery vector added
	input clk;
	input [7:0] A, B;
	reg [7:0] wallace[7:0];
	output [15:0] appxANS, multiply;
    output reg [15:0] accml;
    initial accml = 0;
	wire [15:0] anscheck;
	wire [12:0] and34;
	wire [11:0] and12;
	wire [12:0] or34;
	wire [15:0] and56;
	wire [11:0] or12;
	wire [14:0] add1, add2, add3, add4;
	wire [12:0] add5, add6;
	wire [14:0] error1;
	wire [12:0] error2;
	output [15:0] sum, carry;
	wire [9:0] or1;
	wire [10:0] or2;
	wire [10:0] or3;
	wire [10:0] or4;
	
	integer i, j;
// Previous inputs
    reg [7:0] prev_A=0; 
    reg [7:0] prev_B=0;
	
			//stage 1
			
	always@(*) begin
		for(i=0; i<=7; i=i+1)
				for(j=0; j<=7; j=j+1)
					wallace[i][j] = A[i] & B[j];
	end
	
// Multiply and accumulate
    always @(posedge clk) begin
        if (A != prev_A || B != prev_B) begin
                accml <= accml + multiply;
                prev_A <= A;
                prev_B <= B;
        end
    end    	
    
			//stage 2-1: AndOr operations
	
	//part 1: PP0, PP1
	//wire [9:0] or1;
	wire [9:0] and1;
	approx_HA AO110(and1[0], or1[0], wallace[0][0], 0);
	approx_HA AO111(and1[1], or1[1], wallace[1][0], wallace[0][1]);
	approx_HA AO112(and1[2], or1[2], wallace[2][0], wallace[1][1]);
	approx_HA AO113(and1[3], or1[3], wallace[3][0], wallace[2][1]);
	approx_HA AO114(and1[4], or1[4], wallace[4][0], wallace[3][1]);
	approx_HA AO115(and1[5], or1[5], wallace[5][0], wallace[4][1]);
	approx_HA AO116(and1[6], or1[6], wallace[6][0], wallace[5][1]);
	approx_HA AO117(and1[7], or1[7], wallace[7][0], wallace[6][1]);
	approx_HA AO118(and1[8], or1[8], 0, wallace[7][1]);
	approx_HA AO119(and1[9], or1[9], 0, 0);
	//assign and1[14:10] = 0;
	
	//part 2: PP2, PP3					
	//wire [10:0] or2;
	wire [10:0] and2;
	approx_HA AO220(and2[0], or2[0], 0, 0);
	approx_HA AO221(and2[1], or2[1], wallace[0][2], 0);
	approx_HA AO222(and2[2], or2[2], wallace[1][2], wallace[0][3]);
	approx_HA AO223(and2[3], or2[3], wallace[2][2], wallace[1][3]);
	approx_HA AO224(and2[4], or2[4], wallace[3][2], wallace[2][3]);
	approx_HA AO225(and2[5], or2[5], wallace[4][2], wallace[3][3]);
	approx_HA AO226(and2[6], or2[6], wallace[5][2], wallace[4][3]);
	approx_HA AO227(and2[7], or2[7], wallace[6][2], wallace[5][3]);
	approx_HA AO228(and2[8], or2[8], wallace[7][2], wallace[6][3]);
	approx_HA AO229(and2[9], or2[9], 0, wallace[7][3]);
	approx_HA AO22X(and2[10], or2[10], 0, 0);
	//assign and2[14:11] = 0;
	
	//part 3: PP4, PP5
	//wire [10:0] or3;
	wire [10:0] and3;
	approx_HA AO330(and3[0], or3[0], 0, 0);
	approx_HA AO331(and3[1], or3[1], wallace[0][4], 0);
	approx_HA AO332(and3[2], or3[2], wallace[1][4], wallace[0][5]);
	approx_HA AO333(and3[3], or3[3], wallace[2][4], wallace[1][5]);
	approx_HA AO334(and3[4], or3[4], wallace[3][4], wallace[2][5]);
	approx_HA AO335(and3[5], or3[5] ,wallace[4][4], wallace[3][5]);
	approx_HA AO336(and3[6], or3[6] ,wallace[5][4], wallace[4][5]);
	approx_HA AO337(and3[7], or3[7] ,wallace[6][4], wallace[5][5]);
	approx_HA AO338(and3[8], or3[8] ,wallace[7][4], wallace[6][5]);
	approx_HA AO339(and3[9], or3[9], 0, wallace[7][5]);
	approx_HA AO33X(and3[10], or3[10], 0, 0);
	//assign and3[14:11] = 0;
	
	//part 4: PP6, PP7
//	wire [10:0] or4;
	wire [10:0] and4;
	approx_HA AO440(and4[0], or4[0], 0, 0);
	approx_HA AO441(and4[1], or4[1], wallace[0][6], 0);
	approx_HA AO442(and4[2], or4[2], wallace[1][6], wallace[0][7]); 		// MSB of ACCL replaces with LSB of PP7
	approx_HA AO443(and4[3], or4[3], wallace[2][6], wallace[1][7]);
	approx_HA AO444(and4[4], or4[4], wallace[3][6], wallace[2][7]);
	approx_HA AO445(and4[5], or4[5], wallace[4][6], wallace[3][7]);
	approx_HA AO446(and4[6], or4[6], wallace[5][6], wallace[4][7]);
	approx_HA AO447(and4[7], or4[7], wallace[6][6], wallace[5][7]);
	approx_HA AO448(and4[8], or4[8], wallace[7][6], wallace[6][7]);
	approx_HA AO449(and4[9], or4[9], 0, wallace[7][7]);
	approx_HA AO44X(and4[10], or4[10], 0, 0);
	//assign and4[14:11] = 0;
	
			// stage 2-2
	//part 5: or1, or2
	//wire [11:0] or12;
	//wire [12:0] and12;
	approx_HA AO120(and12[0], or12[0], or1[0], 0);
	approx_HA AO121(and12[1], or12[1], or1[1], or2[0]);
	approx_HA AO122(and12[2], or12[2], or1[2], or2[1]);
	approx_HA AO123(and12[3], or12[3], or1[3], or2[2]);
	approx_HA AO124(and12[4], or12[4], or1[4], or2[3]);
	approx_HA AO125(and12[5], or12[5], or1[5], or2[4]);
	approx_HA AO126(and12[6], or12[6], or1[6], or2[5]);
	approx_HA AO127(and12[7], or12[7], or1[7], or2[6]);
	approx_HA AO128(and12[8], or12[8], or1[8], or2[7]);
	approx_HA AO129(and12[9], or12[9], or1[9], or2[8]);
	approx_HA AO12X(and12[10], or12[10], 0, or2[9]);
	approx_HA AO12XI(and12[11], or12[11], 0, or2[10]);
	//assign and12[12] = 0;
	
	//part 6: or3, or4
	//wire [12:0] and34, or34;
	approx_HA AO340(and34[0], or34[0], or3[0], 0);
	approx_HA AO341(and34[1], or34[1], or3[1], 0);
	approx_HA AO342(and34[2], or34[2], or3[2], or4[0]);
	approx_HA AO343(and34[3], or34[3], or3[3], or4[1]);
	approx_HA AO344(and34[4], or34[4], or3[4], or4[2]);
	approx_HA AO345(and34[5], or34[5], or3[5], or4[3]);
	approx_HA AO346(and34[6], or34[6], or3[6], or4[4]);
	approx_HA AO347(and34[7], or34[7], or3[7], or4[5]);
	approx_HA AO348(and34[8], or34[8], or3[8], or4[6]);
	approx_HA AO349(and34[9], or34[9], or3[9], or4[7]);
	approx_HA AO34X(and34[10], or34[10], or3[10], or4[8]);
	approx_HA AO34XI(and34[11], or34[11], 0, or4[9]);
	approx_HA AO34XII(and34[12], or34[12], 0, or4[10]);
	
			// stage 2-3
	//Approx compressed result: or5, or6
	//wire [15:0] and56;
	approx_HA MACop0(and56[0], appxANS[0], or12[0], 0);
	approx_HA MACop1(and56[1], appxANS[1], or12[1], 0);
	approx_HA MACop2(and56[2], appxANS[2], or12[2], 0);
	approx_HA MACop3(and56[3], appxANS[3], or12[3], or34[0]);
	approx_HA MACop4(and56[4], appxANS[4], or12[4], or34[1]);
	approx_HA MACop5(and56[5], appxANS[5], or12[5], or34[2]);
	approx_HA MACop6(and56[6], appxANS[6], or12[6], or34[3]);
	approx_HA MACop7(and56[7], appxANS[7], or12[7], or34[4]);
	approx_HA MACop8(and56[8], appxANS[8], or12[8], or34[5]);
	approx_HA MACop9(and56[9], appxANS[9], or12[9], or34[6]);
	approx_HA MACop10(and56[10], appxANS[10], or12[10], or34[7]);
	approx_HA MACop11(and56[11], appxANS[11], or12[11], or34[8]);
	approx_HA MACop12(and56[12], appxANS[12], 0, or34[9]);
	approx_HA MACop13(and56[13], appxANS[13], 0, or34[10]);
	approx_HA MACop14(and56[14], appxANS[14], 0, or34[11]);
	approx_HA MACop15(and56[15], appxANS[15], 0, or34[12]);
	
			// stage 3
	//wire [15:0] sum;
	//wire [15:0] error1;
	//wire [15:0] carry;
	//wire [12:0] error2;
	//wire [14:0] add1, add2, add3, add4;
	assign error1[0] = and1[0];
	assign error1[1] = and1[1];
	assign error1[2] = and1[2]|and2[0];
	assign error1[3] = and1[3]|and2[1];
	assign error1[4] = and1[4]|and2[2]|and3[0];
	assign error1[5] = and1[5]|and2[3]|and3[1];
	assign error1[6] = and1[6]|and2[4]|and3[2]|and4[0];
	assign error1[7] = and1[7]|and2[5]|and3[3]|and4[1];
	assign error1[8] = and1[8]+and2[6]+and3[4]+and4[2];
	assign error1[9] = and2[7]+and3[5]+and4[3];
	assign error1[10] = and2[8]+and3[6]+and4[4];
	assign error1[11] = and2[0]+and3[7]+and4[5];
	assign error1[12] = and2[0]+and3[8]+and4[6];
	assign error1[13] = and4[7];
	assign error1[14] = and4[8];
	
	assign error2[0] = and12[1];
	assign error2[1] = and12[2];
	assign error2[2] = and12[3];
	assign error2[3] = and12[4];
	assign error2[4] = and12[5]|and34[2];
	assign error2[5] = and12[6]|and34[3];
	assign error2[6] = and12[7]|and34[4];
	assign error2[7] = and12[8]|and34[5];
	assign error2[8] = and12[9]|and34[6];
	assign error2[9] = and34[7];
	assign error2[10] = and34[8];
	assign error2[11] = and34[9];
	assign error2[12] = and34[10];
	
	wire enable;
   assign enable = (error1||error2||and56)?1:0;

    wire [13:8] cout;
	 approx_HA stg3A0(carry[0], sum[0], appxANS[0], error1[0]);//(o70,v10)
	 dualstg_4x2comp stg3A1(carry[1], sum[1], appxANS[1], 0, error2[0], error1[1], enable);
    dualstg_4x2comp stg3A2(carry[2], sum[2], appxANS[2], 0, error2[1], error1[2], enable);
    dualstg_4x2comp stg3A3(carry[3], sum[3], appxANS[3], and56[0], error2[2], error1[3], enable);
	 dualstg_4x2comp stg3A4(carry[4], sum[4], appxANS[4], and56[1], error2[3], error1[4], enable);
    dualstg_4x2comp stg3A5(carry[5], sum[5], appxANS[5], and56[2], error2[4], error1[5], enable);
	 dualstg_4x2comp stg3A6(carry[6], sum[6], appxANS[6], and56[3], error2[5], error1[6], enable);
    dualstg_4x2comp stg3A7(carry[7], sum[7], appxANS[7], and56[4], error2[6], error1[7], enable);
	 exact_4x2comp stg3A8 (cout[8], carry[8], sum[8], appxANS[8], and56[5], error2[7], error1[8], 0);
    exact_4x2comp stg3A9 (cout[9], carry[9], sum[9], appxANS[9], and56[6], error2[8], error1[9], cout[8]);
	 exact_4x2comp stg3A10(cout[10], carry[10], sum[10], appxANS[10], and56[7], error2[9], error1[10], cout[9]);
    exact_4x2comp stg3A11(cout[11], carry[11], sum[11], appxANS[11], and56[8], error2[10], error1[11], cout[10]);
	 exact_4x2comp stg3A12(cout[12], carry[12], sum[12], appxANS[12], 0, error2[11], error1[12], cout[11]);
    exact_4x2comp stg3A13(cout[13], carry[13], sum[13], appxANS[13], 0, error2[12], error1[13], cout[12]);
	 FAenable stg3A14(carry[14], sum[14], appxANS[14], error1[14], cout[13], enable); //(car15, sum15, o714, co14, v114)
	 assign sum[15] = appxANS[15];
	 assign carry[15] = 0;
	
			// stage 4: final adder - BK Adder
	
	bkadder finaladd(sum, carry, anscheck);
	
	assign multiply = (enable)?anscheck:appxANS;
	//always@(posedge clk) begin
	//   if(anscheck < appxANS)  multiply

endmodule