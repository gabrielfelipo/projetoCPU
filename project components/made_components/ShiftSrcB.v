module ShiftSrcB (
    input wire [1:0] selector,
    input wire [31:0] data0,
    input wire [31:0] data1,
    input wire [31:0] data2,
    input wire [31:0] data3,

    output wire [31:0] data_out
);
    
    always @(*) begin
        case (selector)
            2'b00: data_out = data0;
            2'b01: data_out = data1;
            2'b10: data_out = data2;
            2'b11: data_out = data3;
        endcase
    end

endmodule