module RegDst (
    input wire [2:0] selector,
    input wire [31:0] data0,
    input wire [31:0] data1,
    input wire [31:0] data2,

    output wire [31:0] data_out
);

    always @(*) begin
        case
            3'b000: data_out = data0;
            3'b001: data_out = 32'b00000000000000000000000000011101;
            3'b010: data_out = 32'b00000000000000000000000000011111;
            3'b011: data_out = data1;
            3'b100: data_out = data2;
        endcase
    end
    
endmodule