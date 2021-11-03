module ALUSrcB(
    input wire      [1:0]   selector,
    input wire      [31:0]  Data_0,
    input wire      [31:0]  Data_1,
    output wire     [31:0]  Data_out
);

    wire[31:0] A1;
    
    assign A1 = (selector[0]) ?  32'd4 : Data_0;
    assign Data_out = (selector[1]) ? Data_1 : A1;


endmodule

// completar esse mux depois!
// TABELA DA VERDADE!
//      0    0  =   B
//      0    1  =   4
//      1    0  =   Data_1 (Sign Extend)
//      1    1  =   Data_1 (Sign Extend)