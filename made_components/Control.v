module Control (
    input wire      clk,
    input wire      reset,
//flags
    input wire      Of,
    input wire      Ng,
    input wire      Zr,
    input wire      Eq,
    input wire      Gt,
    input wire      Lt,
 // OPCODE
    input wire [5:0]    OPCODE,
 // controladores 1 bit   
    output reg      PCWrite,
    output reg      MemWrite,
    output reg      IRWrite,
    output reg      RegWrite,
    output reg      ABWrite,
// Controladores com mais de 1 bit
    output reg  [2:0]    ULA_c,
// Controladores dos mux
    output reg      RegDst_sig,
    output reg      M_ULAA,
    output reg  [1:0]    M_ULAB,
// controlador especial para o reset
    output reg      rst_out
);


//variaveis
reg    [1:0]   STATE;
reg    [2:0]   COUNTER;

//constantes

parameter  ST_COMMON    = 2'b00;
parameter  ST_ADD       = 2'b01;
parameter  ST_ADDI      = 2'b10;
parameter  ST_RESET     = 2'b11;

// OPCODES

parameter  ADD          = 6'b000000;
parameter  ADDI         = 6'b001000;
parameter  RESET        = 6'b111111;



initial begin
    rst_out = 1'b1;    
end

always @(posedge clk) begin
    
    if (reset == 1'b1) begin
        if (STATE != ST_RESET)begin
            STATE = ST_RESET;
            PCWrite     =   1'b0;
            MemWrite    =   1'b0;
            IRWrite     =   1'b0;
            RegWrite    =   1'b0;
            ABWrite     =   1'b0;
            ULA_c       =   3'b000;
        end
        
    end

end

endmodule