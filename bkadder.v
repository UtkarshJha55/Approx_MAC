module bkadder(
		input [15:0] a,
		input [15:0] b,
	output [15:0] sum
	);

	localparam [0:0]  FIX = 1'b1;					//	Added to fix code om two places

	wire [15:0] p;
	wire [15:0] g;
	wire [15:0] cp1;
	wire [15:0] cg1;
	wire cp22;
	wire cg22;
	wire cp23;
	wire cg23;
	wire cp27;
	wire cg27;
	wire cp34;
	wire cg34;
	wire cp35;
	wire cg35;
	wire cp36;
	wire cg36;
	wire cp37;
	wire cg37;
	wire cp211;
	wire cg211;
	wire cp215;
	wire cg215;
	wire cp315;
	wire cg315;
	wire cp411;
	wire cg411;
	wire cp415;
	wire cg415;
	wire cp59;
	wire cg59;
	wire cp513;
	wire cg513;
	wire cp68;
	wire cg68;
	wire cp610;
	wire cg610;
	wire cp612;
	wire cg612;
	wire cp614;
	wire cg614;
	
	wire [16:0] s;
	// LEVEL 0 & 1
	assign p[0] = a[0] ^ b[0];//first level zero bit start
	assign g[0] = a[0] & b[0];
	assign cp1[0] = p[0];
	assign cg1[0] = g[0]; //first level zero bit complete
	
	assign p[1] = a[1] ^ b[1]; //first level first bit start
	assign g[1] = a[1] & b[1];
	assign cg1[1] = (p[1] & g[0])| g[1];
	assign cp1[1] = p[1] & p[0]; // first level first bit complete
	
	assign p[2] = a[2] ^ b[2]; //first level 2nd bit start
	assign g[2] = a[2] & b[2];
	assign cp1[2] = p[2];
	assign cg1[2] = g[2]; // first level 2nd bit complete
	
	assign p[3] = a[3] ^ b[3]; //first level 3rd bit start
	assign g[3] = a[3] & b[3];
	assign cg1[3] = (p[3] & g[2]) | g[3];
	assign cp1[3] = p[3] & p[2]; //first level 3rd bit complete
	
	assign p[4] = a[4] ^ b[4]; //first level 3rd bit start
	assign g[4] = a[4] & b[4];
	assign cg1[4] = g[4];
	assign cp1[4] = p[4]; //first level 3rd bit complete
	
	assign p[5] = a[5] ^ b[5]; //first level 3rd bit start
	assign g[5] = a[5] & b[5];
	assign cg1[5] = (p[5] & g[4]) | g[5];
	assign cp1[5] = p[5] & p[4]; //first level 3rd bit complete
	
	assign p[6] = a[6] ^ b[6]; //first level 3rd bit start
	assign g[6] = a[6] & b[6];
	assign cg1[6] = g[6];
	assign cp1[6] = p[6]; //first level 3rd bit complete
	
	assign p[7] = a[7] ^ b[7]; 
	assign g[7] = a[7] & b[7];
	assign cg1[7] = (p[7] & g[6]) | g[7];
	assign cp1[7] = p[7] & p[6];
	
	assign p[8] = a[8] ^ b[8]; 
	assign g[8] = a[8] & b[8];
	assign cg1[8] = g[8];
	assign cp1[8] = p[8];
	
	assign p[9] = a[9] ^ b[9]; 
	assign g[9] = a[9] & b[9];
	assign cg1[9] = (p[9] & g[8]) | g[9];
	assign cp1[9] = p[9] & p[8];
	
	assign p[10] = a[10] ^ b[10]; 
	assign g[10] = a[10] & b[10];
	assign cg1[10] = g[10];
	assign cp1[10] = p[10];
	
	assign p[11] = a[11] ^ b[11]; 
	assign g[11] = a[11] & b[11];
	if (FIX) begin
		assign cg1[11] = (p[11] & g[10]) | g[11];				//WAS:  g[11];
		assign cp1[11] = p[11] & p[10];							//WAS:  p[11];
	end else begin
		//	original code
		assign cg1[11] = g[11];
		assign cp1[11] = p[11];
	end

	assign p[12] = a[12] ^ b[12]; 
	assign g[12] = a[12] & b[12];
	assign cg1[12] = g[12];
	assign cp1[12] = p[12];
	
	assign p[13] = a[13] ^ b[13]; 
	assign g[13] = a[13] & b[13];
	assign cg1[13] = (p[13] & g[12]) | g[13];
	assign cp1[13] = p[13] & p[12];
	
	assign p[14] = a[14] ^ b[14]; 
	assign g[14] = a[14] & b[14];
	assign cg1[14] = g[14];
	assign cp1[14] = p[14];
	
	assign p[15] = a[15] ^ b[15]; 
	assign g[15] = a[15] & b[15];
	assign cg1[15] = (p[15] & g[14]) | g[15];
	assign cp1[15] = p[15] & p[14];

	//	LEVEL 2
	assign cg22 = (cp1[2] & cg1[1]) | cg1[2];					//	LEVEL 7, should be cg72, actually
	assign cp22 = cp1[2] & cp1[1];								//	LEVEL 7, should be cp72, actually

	assign cg23 = (cp1[3] & cg1[1]) | cg1[3];
	assign cp23 = cp1[3] & cp1[1]; 
	
	assign cg27 = (cp1[7] & cg1[5]) | cg1[7];
	assign cp27 = cp1[7] & cp1[5]; 

	assign cg211 = (cp1[11] & cg1[9]) | cg1[11];
	assign cp211 = cp1[11] & cp1[9];

	if (FIX) begin
		assign cg215 = (cp1[15] & cg1[13]) | cg1[15];			//WAS: (cp1[15] & cg1[11]) | cg1[15];
		assign cp215 = cp1[15] & cp1[13];						//WAS:	cp1[15] & cp1[11];
	end else begin
		//	original code
		assign cg215 = (cp1[15] & cg1[11]) | cg1[15];
		assign cp215 = cp1[15] & cp1[11];
	end

	//	LEVEL 3
	assign cg34 = (cp1[4] & cg23) | cg1[4];						//	LEVEL 7: should be named cg74
	assign cp34 = cp1[4] & cp23;								//	LEVEL 7: should be named cp74
	
	assign cg35 = (cp1[5] & cg23) | cg1[5];						//	LEVEL 6: should be named cg65
	assign cp35 = cp1[5] & cp23;								//	LEVEL 6: should be named cp65
	
	assign cg36 = (cp1[6] & cg35) | cg1[6];						//	LEVEL 7: should be named cg76
	assign cp36 = cp1[6] & cp35;								//	LEVEL 7: should be named cp76

	assign cg37 = (cp27 & cg23) | cg27;
	assign cp37 = cp27 & cp23;
	
	assign cg315 = (cp215 & cg211) | cg215;
	assign cp315 = cp215 & cp211;
	
	//	LEVEL 4
	assign cg411 = (cp211 & cg37) | cg211;						//	LEVEL 5: should be named cg511
	assign cp411 = cp211 & cp37;								//	LEVEL 5: should be named cp511
	
	assign cg415 = (cp315 & cg37) | cg315;
	assign cp415 = cp315 & cp37;

	//	LEVEL 5
	assign cg59 = (cp1[9] & cg37) | cg1[9];						//	LEVEL 6: should be named cg69
	assign cp59 = cp1[9] & cp37;								//	LEVEL 6: should be named cp69
	
	assign cg513 = (cp1[13] & cg411) | cg1[13];					//	LEVEL 6: should be named cg613
	assign cp513 = cp1[13] & cp411;								//	LEVEL 6: should be named cp613
	
	//	LEVEL 6
	assign cg68 = (cp1[8] & cg37) | cg1[8];						//	LEVEL 7: should be named cg78
	assign cp68 = cp1[8] & cp37;								//	LEVEL 7: should be named cp78
	
	assign cg610 = (cp1[10] & cg59) | cg1[10];					//	LEVEL 7: should be named cg710
	assign cp610 = cp1[10] & cp59;								//	LEVEL 7: should be named cp710
	
	assign cg612 = (cp1[12] & cg411) | cg1[12];					//	LEVEL 7: should be named cg712
	assign cp612 = cp1[12] & cp411;								//	LEVEL 7: should be named cp712
	
	assign cg614 = (cp1[14] & cg513) | cg1[14];					//	LEVEL 7: should be named cg714
	assign cp614 = cp1[14] & cp513;								//	LEVEL 7: should be named cp714
	
	assign s[0] = p[0];
	assign s[1] = p[1] ^ cg1[0];
	assign s[2] = p[2] ^ cg1[1];
	assign s[3] = p[3] ^ cg22;
	assign s[4] = p[4] ^ cg23;
	assign s[5] = p[5] ^ cg34;
	assign s[6] = p[6] ^ cg35;
	assign s[7] = p[7] ^ cg36;
	assign s[8] = p[8] ^ cg37;
	assign s[9] = p[9] ^ cg68;
	assign s[10] = p[10] ^ cg59;
	assign s[11] = p[11] ^ cg610;
	assign s[12] = p[12] ^ cg411;
	assign s[13] = p[13] ^ cg612;
	assign s[14] = p[14] ^ cg513;
	assign s[15] = p[15] ^ cg614;
	assign s[16] = cg415;
	assign sum = {s[15:0]};

endmodule