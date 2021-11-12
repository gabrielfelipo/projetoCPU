module MemtoReg (
    input wire [3:0] selector,
    input wire [31:0] data0,
    input wire [31:0] data1,
    input wire [31:0] data2,
    input wire [31:0] data3,
    input wire [31:0] data4,
    input wire [31:0] data5,
    input wire [31:0] data6,
    input wire [31:0] data7,

    output wire [31:0] data_out
);

    always @(*) begin
        case (selector)
            4'b0000: data_out = data0;
            4'b0001: data_out = data1;
            4'b0010: data_out = data2;
            4'b0011: data_out = data3;
            4'b0100: data_out = data4;
            4'b0101: data_out = data5;
            4'b0110: data_out = data6;
            4'b0111: data_out = 32'b00000000000000000000000011100011;
            4'b1000: data_out = data7;
        endcase
    end
    
endmodule