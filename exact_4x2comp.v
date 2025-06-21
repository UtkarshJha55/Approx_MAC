module exact_4x2comp (cout, carry, sum, x1, x2, x3, x4, cin);
	input x1, x2, x3, x4, cin;
	output cout, carry, sum; // cout for next 4-2 compressor, carry for next stage
	wire in_sum;
	FA FA1(cout, in_sum, x1, x2, x3);
	FA FA2(carry, sum, in_sum, x4, cin);
endmodule 

//module exact_4x2comp (cout, carry, sum, x1, x2, x3, x4, cin, enable);
//    input x1, x2, x3, x4, cin, enable;
//    output cout, carry, sum;
//    wire in_sum;
//    
//    // Clock gating for in_sum signal
//    assign in_sum = (enable) ? x1 ^ x2 ^ x3 : 1'b0;
//    
//    // Compute FA1 and FA2 outputs only when enable is active
//    FAenable FA1(cout, in_sum, x1, x2, x3, enable);
//    FAenable FA2(carry, sum, in_sum, x4, cin, enable);
//endmodule
