module PCSource (
    input wire [2:0] selector,
    input wire [31:0] data0,
    input wire [31:0] data1,
    input wire [31:0] data2,
    input wire [31:0] data3,
    input wire [31:0] data4

    output wire [31:0] data_out,
);

    always @(*) begin
        case(selector)
            3'b000: data_out = data0;
            3'b001: data_out = data1;
            3'b010: data_out = data2;
            3'b011: data_out = data3;
            3'b100: data_out = data4;
        endcase
    end
    
endmodule