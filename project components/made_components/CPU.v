module CPU (
    input wire clk, reset
);
    // INSTRUCTION
    wire [5:0] opcode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [15:0] immediate;

    // DATA WIRES
        // ALUSrcA entries
    wire [1:0] CtrlALUSrcA;
    wire [31:0] PC_out;
    wire [31:0] Memdata_out;
    // rs already instantiated
    wire [31:0] ALUSrcA_out;

        // ALUSrcB entries
    wire [1:0] CtrlALUSrcB;
    // rt already instantiated
    wire [31:0] ExtendShiftLeft2;
    wire [31:0] ALUSrcB_out;

        // PCSource entries
    wire [2:0] CtrlPCSource;
    wire [31:0] MDRls_out;
    wire [31:0] ALU_result;
    wire [31:0] ALU_out;
    wire [31:0] PC_out;
    wire [31:0] EPC_out;
    wire [31:0] PCSource_out;

        // RegDst entries
    wire [2:0] CtrlRegDst;
    // rt already instantiated
    // immediate already instantiated
    // MDRls_out already instantiated
    wire [31:0] RegDst_out;

        // MemtoReg entries
    wire [3:0] CtrlMemtoReg;
    // ALU_out already instantiated
    // MDRls_out already instantiated
    wire [31:0] LO_out;
    wire [31:0] HI_out;
    wire [31:0] ShiftReg_out;
    wire [31:0] ExtendShiftLeft16;
    // immediate already instantiated
    // ALU_result already instantiated
    wire [31:0] LTExtend;
    wire [31:0] MemtoReg_out;

        // Iord entries
    wire [2:0] CtrlIord;
    // PC_out already instantiated
    // ALU_out already instantiated
    // ALU_result already instantiated
    wire [31:0] Iord_out;

        // DivSrcA entries
    wire CtrlDivSrcA;
    // rs already instantiated
    wire [31:0] MDR_out;
    wire [31:0] DivSrcA_out;

        // DivSrcB entries
    wire CtrlDivSrcB;
    // rt already instantiated
    // Memdata_out alredy instantiated
    wire [31:0] DivSrcB_out;

        // MuxSSrcB entries
    wire CtrlMuxSSrcB;
    // immediate already instantiated
    // rt already instantiated
    wire [31:0] MuxSSrcB_out;

        // ShiftSrcA entries
    wire CtrlShifSrcA;
    // rt already instantiated
    // rs already instantiated
    wire [31:0] ShiftSrcA_out;

        // ShiftSrcB entries
    wire [1:0] CtrlShifSrcB;
    // immediate already instantiated
    // rt already instantiated
    wire [31:0] Extend16_32_out,
    wire [31:0] ShiftSrcA_out;

////////////////////////////////////////////////////

    ShiftSrcB M_ShiftSrcB_(
        CtrlShifSrcB,
        immediate[10:6],
        rt,
        Extend16_32_out,
        Memdata_out
    );

    ShiftSrcA M_ShiftSrcA_(
        CtrlShifSrcA,
        rt,
        rs,
        ShiftSrcA_out
    );

    MuxSSrcB M_SSrcB_(
        CtrlMuxSSrcB,
        immediate[10:6],
        rt,
        MuxSSrcB_out
    );
    
    DivSrcB M_DIVB_(
        CtrlDivSrcB,
        rt,
        Memdata_out,
        DivSrcB_out
    );
    
    DivSrcA M_DIVA_(
        CtrlDivSrcA,
        rs,
        MDR_out,
        DivSrcA_out
    );

    Iord M_IORD_(
        CtrlIord,
        PC_out,
        ALU_out,
        ALU_result,
        Iord_out
    );

    MemtoReg M_MEM_(
        CtrlMemtoReg,
        ALU_out,
        MDRls_out,
        LO_out,
        HI_out,
        ShiftReg_out,
        ExtendShiftLeft16,
        immediate,
        ALU_result,
        LTExtend,
        MemtoReg_out
    );

    RegDst M_REG_(
        CtrlRegDst,
        rt,
        immediate,
        MDRls_out,
        RegDst_out
    );

    PCSource M_PC_(
        CtrlPCSource,
        MDRls_out,
        ALU_result,
        ALU_out,
        PC_out,
        EPC_out,
        PCSource_out
    );

    ALUSrcA M_ULAA_(
        CtrlALUSrcA,
        PC_out,
        Memdata_out,
        rs,
        ALUSrcA_out
    );

    ALUSrcB M_ULAB_(
        CtrlALUSrcB,
        rt,
        immediate,
        ExtendShiftLeft2
        ALUSrcB_out
    );

    

endmodule