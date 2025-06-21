
module wallacetest(output[15:0] result, input[7:0] a, input[7:0] b, input clk, output reg [15:0] accml = 0);

    reg wall00, wall01, wall02, wall03, wall04, wall05, wall06, wall07;
	 reg wall10, wall11, wall12, wall13, wall14, wall15, wall16, wall17;
	 reg wall20, wall21, wall22, wall23, wall24, wall25, wall26, wall27;
	 reg wall30, wall31, wall32, wall33, wall34, wall35, wall36, wall37;
	 reg wall40, wall41, wall42, wall43, wall44, wall45, wall46, wall47;
	 reg wall50, wall51, wall52, wall53, wall54, wall55, wall56, wall57;
	 reg wall60, wall61, wall62, wall63, wall64, wall65, wall66, wall67;
	 reg wall70, wall71, wall72, wall73, wall74, wall75, wall76, wall77;

    always @(a, b) begin
		wall00 = a[0] & b[0]; wall10 = a[1] & b[0]; wall20 = a[2] & b[0]; wall30 = a[3] & b[0];
		wall01 = a[0] & b[1]; wall11 = a[1] & b[1]; wall21 = a[2] & b[1]; wall31 = a[3] & b[1];
		wall02 = a[0] & b[2]; wall12 = a[1] & b[2]; wall22 = a[2] & b[2]; wall32 = a[3] & b[2];
		wall03 = a[0] & b[3]; wall13 = a[1] & b[3]; wall23 = a[2] & b[3]; wall33 = a[3] & b[3];
		wall04 = a[0] & b[4]; wall14 = a[1] & b[4]; wall24 = a[2] & b[4]; wall34 = a[3] & b[4];
		wall05 = a[0] & b[5]; wall15 = a[1] & b[5]; wall25 = a[2] & b[5]; wall35 = a[3] & b[5];
		wall06 = a[0] & b[6]; wall16 = a[1] & b[6]; wall26 = a[2] & b[6]; wall36 = a[3] & b[6];
		wall07 = a[0] & b[7]; wall17 = a[1] & b[7]; wall27 = a[2] & b[7]; wall37 = a[3] & b[7];
		
		wall40 = a[4] & b[0]; wall50 = a[5] & b[0]; wall60 = a[6] & b[0]; wall70 = a[7] & b[0];
		wall41 = a[4] & b[1]; wall51 = a[5] & b[1]; wall61 = a[6] & b[1]; wall71 = a[7] & b[1];
		wall42 = a[4] & b[2]; wall52 = a[5] & b[2]; wall62 = a[6] & b[2]; wall72 = a[7] & b[2];
		wall43 = a[4] & b[3]; wall53 = a[5] & b[3]; wall63 = a[6] & b[3]; wall73 = a[7] & b[3];
		wall44 = a[4] & b[4]; wall54 = a[5] & b[4]; wall64 = a[6] & b[4]; wall74 = a[7] & b[4];
		wall45 = a[4] & b[5]; wall55 = a[5] & b[5]; wall65 = a[6] & b[5]; wall75 = a[7] & b[5];
		wall46 = a[4] & b[6]; wall56 = a[5] & b[6]; wall66 = a[6] & b[6]; wall76 = a[7] & b[6];
		wall47 = a[4] & b[7]; wall57 = a[5] & b[7]; wall67 = a[6] & b[7]; wall77 = a[7] & b[7];
    end
	 
// Previous inputs
    reg [7:0] prev_A=0; 
    reg [7:0] prev_B=0;
	 
	 // Multiply and accumulate
    always @(posedge clk) begin
        if (a != prev_A || b != prev_B) begin
                accml <= accml + result;
                prev_A <= a;
                prev_B <= b;
        end
    end    	
	 
    // result[0]
    assign result[0] = wall00;

    // result[1]
    wire result1_c;
    HA result1_HA_1(result1_c, result[1], wall01, wall10);

    // result[2]
    wire result2_c_temp_1, result2_c, result2_temp_1;
    FA result2_FA_1(result2_c_temp_1, result2_temp_1, wall02, wall11, result1_c);
    HA result2_HA_1(result2_c, result[2], wall20, result2_temp_1);

    // result[3]
    wire result3_c_temp_1, result3_c_temp_2, result3_c, result3_temp_1, result3_temp_2;
    FA result3_FA_1(result3_c_temp_1, result3_temp_1, wall03, wall12, result2_c);
    FA result3_FA_2(result3_c_temp_2, result3_temp_2, wall21, result3_temp_1, result2_c_temp_1);
    HA result3_HA_1(result3_c, result[3], wall30, result3_temp_2);

    // result[4]
    wire result4_c_temp_1, result4_c_temp_2, result4_c_temp_3, result4_c, result4_temp_1, result4_temp_2, result4_temp_3;
    FA result4_FA_1(result4_c_temp_1, result4_temp_1, wall04, wall13, result3_c);
    FA result4_FA_2(result4_c_temp_2, result4_temp_2, wall22, result4_temp_1, result3_c_temp_1);
    FA result4_FA_3(result4_c_temp_3, result4_temp_3, wall31, result4_temp_2, result3_c_temp_2);
    HA result4_HA_1(result4_c, result[4], wall40, result4_temp_3);

    // result[5]
    wire result5_c_temp_1, result5_c_temp_2, result5_c_temp_3, result5_c_temp_4, result5_c, result5_temp_1, result5_temp_2, result5_temp_3, result5_temp_4;
    FA result5_FA_1(result5_c_temp_1, result5_temp_1, wall05, wall14, result4_c);
    FA result5_FA_2(result5_c_temp_2, result5_temp_2, wall23, result5_temp_1, result4_c_temp_1);
    FA result5_FA_3(result5_c_temp_3, result5_temp_3, wall32, result5_temp_2, result4_c_temp_2);
    FA result5_FA_4(result5_c_temp_4, result5_temp_4, wall41, result5_temp_3, result4_c_temp_3);
    HA result5_HA_1(result5_c, result[5], wall50, result5_temp_4);

    // result[6]
    wire result6_c_temp_1, result6_c_temp_2, result6_c_temp_3, result6_c_temp_4, result6_c_temp_5, result6_c, result6_temp_1, result6_temp_2, result6_temp_3, result6_temp_4, result6_temp_5;
    FA result6_FA_1(result6_c_temp_1, result6_temp_1, wall06, wall15, result5_c);
    FA result6_FA_2(result6_c_temp_2, result6_temp_2, wall24, result6_temp_1, result5_c_temp_1);
    FA result6_FA_3(result6_c_temp_3, result6_temp_3, wall33, result6_temp_2, result5_c_temp_2);
    FA result6_FA_4(result6_c_temp_4, result6_temp_4, wall42, result6_temp_3, result5_c_temp_3);
    FA result6_FA_5(result6_c_temp_5, result6_temp_5, wall51, result6_temp_4, result5_c_temp_4);
    HA result6_HA_1(result6_c, result[6], wall60, result6_temp_5);

    // result[7]
    wire result7_c_temp_1, result7_c_temp_2, result7_c_temp_3, result7_c_temp_4, result7_c_temp_5, result7_c_temp_6, result7_c, result7_temp_1, result7_temp_2, result7_temp_3, result7_temp_4, result7_temp_5, result7_temp_6;
    FA result7_FA_1(result7_c_temp_1, result7_temp_1, wall07, wall16, result6_c);
    FA result7_FA_2(result7_c_temp_2, result7_temp_2, wall25, result7_temp_1, result6_c_temp_1);
    FA result7_FA_3(result7_c_temp_3, result7_temp_3, wall34, result7_temp_2, result6_c_temp_2);
    FA result7_FA_4(result7_c_temp_4, result7_temp_4, wall43, result7_temp_3, result6_c_temp_3);
    FA result7_FA_5(result7_c_temp_5, result7_temp_5, wall52, result7_temp_4, result6_c_temp_4);
    FA result7_FA_6(result7_c_temp_6, result7_temp_6, wall61, result7_temp_5, result6_c_temp_5);
    HA result7_HA_1(result7_c, result[7], wall70, result7_temp_6);

    // result[8]
    wire result8_c_temp_1, result8_c_temp_2, result8_c_temp_3, result8_c_temp_4, result8_c_temp_5, result8_c_temp_6, result8_c, result8_temp_1, result8_temp_2, result8_temp_3, result8_temp_4, result8_temp_5, result8_temp_6;
    FA result8_FA_1(result8_c_temp_1, result8_temp_1, wall17, wall26, result7_c);
    FA result8_FA_2(result8_c_temp_2, result8_temp_2, wall35, result8_temp_1, result7_c_temp_1);
    FA result8_FA_3(result8_c_temp_3, result8_temp_3, wall44, result8_temp_2, result7_c_temp_2);
    FA result8_FA_4(result8_c_temp_4, result8_temp_4, wall53, result8_temp_3, result7_c_temp_3);
    FA result8_FA_5(result8_c_temp_5, result8_temp_5, wall62, result8_temp_4, result7_c_temp_4);
    FA result8_FA_6(result8_c_temp_6, result8_temp_6, wall71, result8_temp_5, result7_c_temp_5);
    HA result8_HA_1(result8_c, result[8], result8_temp_6, result7_c_temp_6);

    // result[9]
    wire result9_c_temp_1, result9_c_temp_2, result9_c_temp_3, result9_c_temp_4, result9_c_temp_5, result9_c, result9_temp_1, result9_temp_2, result9_temp_3, result9_temp_4, result9_temp_5;
    FA result9_FA_1(result9_c_temp_1, result9_temp_1, wall27, wall36, result8_c);
    FA result9_FA_2(result9_c_temp_2, result9_temp_2, wall45, result9_temp_1, result8_c_temp_1);
    FA result9_FA_3(result9_c_temp_3, result9_temp_3, wall54, result9_temp_2, result8_c_temp_2);
    FA result9_FA_4(result9_c_temp_4, result9_temp_4, wall63, result9_temp_3, result8_c_temp_3);
    FA result9_FA_5(result9_c_temp_5, result9_temp_5, wall72, result9_temp_4, result8_c_temp_4);
    FA result9_FA_6(result9_c, result[9], result9_temp_5, result8_c_temp_5, result8_c_temp_6);

    // result[10]
    wire result10_c_temp_1, result10_c_temp_2, result10_c_temp_3, result10_c_temp_4, result10_c, result10_temp_1, result10_temp_2, result10_temp_3, result10_temp_4;
    FA result10_FA_1(result10_c_temp_1, result10_temp_1, wall37, wall46, result9_c);
    FA result10_FA_2(result10_c_temp_2, result10_temp_2, wall55, result10_temp_1, result9_c_temp_1);
    FA result10_FA_3(result10_c_temp_3, result10_temp_3, wall64, result10_temp_2, result9_c_temp_2);
    FA result10_FA_4(result10_c_temp_4, result10_temp_4, wall73, result10_temp_3, result9_c_temp_3);
    FA result10_FA_5(result10_c, result[10], result10_temp_4, result9_c_temp_4, result9_c_temp_5);

    // result[11]
    wire result11_c_temp_1, result11_c_temp_2, result11_c_temp_3, result11_c, result11_temp_1, result11_temp_2, result11_temp_3;
    FA result11_FA_1(result11_c_temp_1, result11_temp_1, wall47, wall56, result10_c);
    FA result11_FA_2(result11_c_temp_2, result11_temp_2, wall65, result11_temp_1, result10_c_temp_1);
    FA result11_FA_3(result11_c_temp_3, result11_temp_3, wall74, result11_temp_2, result10_c_temp_2);
    FA result11_FA_4(result11_c, result[11], result11_temp_3, result10_c_temp_3, result10_c_temp_4);

    // result[12]
    wire result12_c_temp_1, result12_c, result12_temp_1, result12_c_temp_2, result12_temp_2;
    FA result12_FA_1(result12_c_temp_1, result12_temp_1, wall57, wall66, result11_c);
    FA result12_FA_2(result12_c_temp_2, result12_temp_2, wall75, result12_temp_1, result11_c_temp_1);
    FA result12_FA_3(result12_c, result[12], result12_temp_2, result11_c_temp_2, result11_c_temp_3);

    // result[13]
    wire result13_c, result13_temp_1, result13_c_temp_1;
    FA result13_FA_1(result13_c_temp_1, result13_temp_1, wall67, wall76, result12_c);
    FA result13_FA_2(result13_c, result[13], result13_temp_1, result12_c_temp_2, result12_c_temp_1);

    // result[14]
    wire result14_c;
    FA result14_FA_1(result14_c, result[14], wall77, result13_c, result13_c_temp_1);

    // result[15]
    assign result[15] = result14_c;
endmodule