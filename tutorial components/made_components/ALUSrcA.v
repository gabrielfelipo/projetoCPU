module ALUScrA(
    input wire              selector,
    input wire      [31:0]  Data_0,
    input wire      [31:0]  Data_1,
    output wire     [31:0]  Data_out
);
    // caso o seletor for 1, vai pegar Data_1. Data_0 caso contrário
    assign Data_out = (selector) ? Data_1 : Data_0;

endmodule

// Completar esse mux depois!!
// Data_0 = PC
// Data_1 = A