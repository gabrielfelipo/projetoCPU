module CPU (
    input wire clk,
    input wire reset
);

/////////////////// control wires //////////////////

    wire            PCWrite;
    wire            MemWrite;
    wire            IRWrite;
    wire            RegWrite;
    wire            ABWrite;  

    wire            RegDst_sig;



////////////////////////////////////////////////////


/////////////////// data wires /////////////////////

    wire    [5:0]   OPCODE;
    wire    [4:0]   RS;
    wire    [4:0]   RT;
    wire    [15:0]  OFFSET;

    wire    [4:0]   WriteRegister // saída do RegDst

    wire    [31:0]  ULA_out;
    wire    [31:0]  PC_out;
    wire    [31:0]  Mem_out;

    wire    [31:0]  R_to_A;
    wire    [31:0]  R_to_B;  
    wire    [31:0]  A_out;
    wire    [31:0]  B_out;  
////////////////////////////////////////////////////




    Registrador PC (
        clk,
        reset,
        PCWrite,
        ULA_out, // ALTERAR DEPOIS PARA UM MUX !!!!
        PC_out
    );

    Memoria MemData (
        PC_out,
        clk,
        MemWrite,
        ULA_out, //depois alterar essa variável, essa nao é a entrada definitiva da memoria
        Mem_out // saída da memória
    );

    Instr_Reg IR (
        clk,
        reset,
        IRWrite,
        Mem_out, // entrada do IR
        OPCODE,
        RS,
        RT,
        OFFSET 
    );

    RegDst Reg_destiny (
        RegDst_sig, // sinal do seletor para o mux
        RT,
        OFFSET,
        WriteRegister
    );

    Banco_reg Registers (
        clk,
        reset,
        RegWrite,
        RS,
        RT,
        WriteRegister, //saída do mux Reg_destiny
        ULA_out, // ALTERAR DEPOIS PARA UM MUX !!!!
        R_to_A,
        R_to_B
    );

    Registrador A (
        clk,
        reset,
        ABWrite,
        R_to_A,
        A_out // saída do registrador A
    );

    Registrador B (
        clk,
        reset,
        ABWrite,
        R_to_B,
        B_out // saída do registrador B
    );

    SignExtend Sign_E (
        OFFSET,
        Sign_E_out
    );

    ALUSrcA mux_A (
        
    );

endmodule