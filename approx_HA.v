module approx_HA (carry, sum, a, b);
	input a, b;
	output sum, carry;
	assign sum = a+b;
	assign carry = a&b;
endmodule