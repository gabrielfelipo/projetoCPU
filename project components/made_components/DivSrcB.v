module DivSrcB (
    input wire selector,
    input wire [31:0] data0,
    input wire [31:0] data1,

    output wire [31:0] data_out
);

    assign data_out = (selector) ? data1 : data0;

endmodule