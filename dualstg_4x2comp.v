//module dualstg_4x2comp (carry, sum, x1, x2, x3, x4);
//	input x1, x2, x3, x4;
//	output carry, sum;
//	wire select, opt0, opt1;
//	nor car(carry, x1, x2);
//	xor sel(select, x1, x2);
//	nand MUX0(opt0, x3, x4);
//	nor MUX1(opt1, x3, x4);
//	assign sum = (select)?opt1:opt0;
//endmodule

module dualstg_4x2comp (carry, sum, x1, x2, x3, x4, enable);
    input x1, x2, x3, x4, enable;
    output carry, sum;
    wire select, opt0, opt1;
    
    // Clock gating for select signal
    assign select = (enable) ? x1 ^ x2 : 1'b0;
    
    // Compute opt0 and opt1 only when enable is active
    assign opt0 = ~(x3 & x4);
    assign opt1 = ~(x3 | x4);
    
    // Compute sum based on enable
    assign sum = (enable) ? ((select) ? opt1 : opt0) : sum;
    
    // Compute carry based on enable
    assign carry = (enable) ? (x1 & x2) : carry;
endmodule
