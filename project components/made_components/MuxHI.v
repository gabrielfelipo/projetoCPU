module MuxHI (
    input wire selector,
    input wire [31:0] Div_out,
    input wire [31:0] Mult_out,

    output wire [31:0] data_out
);

    assign data_out = (selector) ? Mult_out: Div_out;
    
endmodule