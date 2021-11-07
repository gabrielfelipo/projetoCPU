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
            RegDst_sig  =   1'b0;
            M_ULAA      =   1'b0;
            M_ULAB      =   2'b00;
            rst_out     =   1'b1; ///
            //setting counter for next operation

            COUNTER     =   3'b000;
        end
        else begin
            STATE = ST_COMMON;
            PCWrite     =   1'b0;
            MemWrite    =   1'b0;
            IRWrite     =   1'b0;
            RegWrite    =   1'b0;
            ABWrite     =   1'b0;
            ULA_c       =   3'b000;
            RegDst_sig  =   1'b0;
            M_ULAA      =   1'b0;
            M_ULAB      =   2'b00;
            rst_out     =   1'b0; /// modificação aqui
            //setting counter for next operation

            COUNTER     =   3'b000;
            
        end
        
    end
    else begin
        case (STATE)
            ST_COMMON: begin
                if (COUNTER == 3'b000 || COUNTER = 3'b001 || COUNTER = 3'b010) begin
                    STATE = ST_COMMON;
                    PCWrite     =   1'b0;
                    MemWrite    =   1'b0; /// 
                    IRWrite     =   1'b0;
                    RegWrite    =   1'b0;
                    ABWrite     =   1'b0;
                    ULA_c       =   3'b001; /// 
                    RegDst_sig  =   1'b0;
                    M_ULAA      =   1'b0;   /// 
                    M_ULAB      =   2'b01;  /// 
                    rst_out     =   1'b0; 
                    //setting counter for next operation

                    COUNTER     =   COUNTER + 1;
                end

                else if (COUNTER == 3'b011) begin
                    STATE = ST_COMMON;
                    PCWrite     =   1'b1; ///
                    MemWrite    =   1'b0; /// 
                    IRWrite     =   1'b1; ///
                    RegWrite    =   1'b0;
                    ABWrite     =   1'b0;
                    ULA_c       =   3'b001; /// 
                    RegDst_sig  =   1'b0;
                    M_ULAA      =   1'b0;   /// 
                    M_ULAB      =   2'b01;  /// 
                    rst_out     =   1'b0; 
                    //setting counter for next operation

                    COUNTER     =   COUNTER + 1;
                    
                end

                else if (COUNTER == 3'b100) begin
                    STATE = ST_COMMON;
                    PCWrite     =   1'b0; 
                    MemWrite    =   1'b0; 
                    IRWrite     =   1'b0; 
                    RegWrite    =   1'b0;
                    ABWrite     =   1'b1;   ///
                    ULA_c       =   3'b000;
                    RegDst_sig  =   1'b0;
                    M_ULAA      =   1'b0;
                    M_ULAB      =   2'b00;
                    rst_out     =   1'b0; 
                    //setting counter for next operation

                    COUNTER     =   COUNTER + 1;
                end
                else if (COUNTER == 3'b101) begin
                    case (OPCODE)
                        ADD: begin
                            STATE = ST_ADD;
                        end
                        ADDI: begin
                            STATE = ST_ADDI;
                        end
                        RESET: begin
                            STATE = ST_RESET;
                        end    
                    endcase
                    STATE = ST_COMMON;
                    PCWrite     =   1'b0; 
                    MemWrite    =   1'b0; 
                    IRWrite     =   1'b0; 
                    RegWrite    =   1'b0;
                    ABWrite     =   1'b0;
                    ULA_c       =   3'b000;
                    RegDst_sig  =   1'b0;
                    M_ULAA      =   1'b0;
                    M_ULAB      =   2'b00;
                    rst_out     =   1'b0; 
                    //setting counter for next operation
                    COUNTER     =   3'b000;
                    
                end
            end

            ST_ADD: begin
                if (COUNTER == 3'b000) begin
                    STATE = ST_ADD;
                    PCWrite     =   1'b0; 
                    MemWrite    =   1'b0; 
                    IRWrite     =   1'b0; 
                    RegWrite    =   1'b1;   ///
                    ABWrite     =   1'b0;   
                    ULA_c       =   3'b001; ///
                    RegDst_sig  =   1'b1;   ///
                    M_ULAA      =   1'b1;   ///
                    M_ULAB      =   2'b00;  ///
                    rst_out     =   1'b0; 
                    //setting counter for next operation

                    COUNTER     =   COUNTER + 1;
                end
                else if (COUNTER == 3'b001) begin
                    STATE = ST_COMMON;
                    PCWrite     =   1'b0; 
                    MemWrite    =   1'b0; 
                    IRWrite     =   1'b0; 
                    RegWrite    =   1'b1;   ///
                    ABWrite     =   1'b0;  
                    ULA_c       =   3'b001; ///
                    RegDst_sig  =   1'b1;   ///
                    M_ULAA      =   1'b1;   ///
                    M_ULAB      =   2'b00;  ///
                    rst_out     =   1'b0; 
                    //setting counter for next operation

                    COUNTER     =   3'b000;
                    end
                end

            ST_ADDI: begin
                if (COUNTER == 3'b000) begin
                    STATE = ST_ADDI;
                    PCWrite     =   1'b0; 
                    MemWrite    =   1'b0; 
                    IRWrite     =   1'b0; 
                    RegWrite    =   1'b1;   ///
                    ABWrite     =   1'b0;   
                    ULA_c       =   3'b001; ///
                    RegDst_sig  =   1'b0;   ///
                    M_ULAA      =   1'b1;   ///
                    M_ULAB      =   2'b10;  ///
                    rst_out     =   1'b0; 
                    //setting counter for next operation

                    COUNTER     =   COUNTER + 1;
                end
                else if (COUNTER == 3'b001) begin
                    STATE = ST_COMMON;
                    PCWrite     =   1'b0; 
                    MemWrite    =   1'b0; 
                    IRWrite     =   1'b0; 
                    RegWrite    =   1'b1;   ///
                    ABWrite     =   1'b0;  
                    ULA_c       =   3'b001; ///
                    RegDst_sig  =   1'b0;   ///
                    M_ULAA      =   1'b1;   ///
                    M_ULAB      =   2'b10;  ///
                    rst_out     =   1'b0; 
                    //setting counter for next operation

                    COUNTER     =   3'b000;
                end
            end
            ST_RESET: begin
                if (COUNTER == 3'b000) begin
                    STATE = ST_RESET;
                    PCWrite     =   1'b0; 
                    MemWrite    =   1'b0; 
                    IRWrite     =   1'b0; 
                    RegWrite    =   1'b0;   
                    ABWrite     =   1'b0;   
                    ULA_c       =   3'b000; 
                    RegDst_sig  =   1'b0;   
                    M_ULAA      =   1'b0;   
                    M_ULAB      =   2'b00;  
                    rst_out     =   1'b1; 
                    //setting counter for next operation

                    COUNTER     =   3'b000;
                end
                
            end      
        endcase
    end

end

endmodule