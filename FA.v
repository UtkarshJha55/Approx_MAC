module FA(carry, sum, a, b, c);
	input a, b, c;
	output sum, carry;
	assign sum = a ^ b ^ c;
	assign carry = (a&b)|(b&c)|(c&a);
endmodule

// Full adder with enable
module FAenable(carry, sum, a, b, c, enable);
    input a, b, c, enable;
    output sum, carry;
    
    // Compute sum and carry based on enable
    assign sum = (enable) ? (a ^ b ^ c) : sum;
    assign carry = (enable) ? ((a & b) | (b & c) | (c & a)) : carry;
endmodule
