// **********************************************************************
// Technion EE 044252: Digital Systems and Computer Structure course    *
// Simple Multicycle RISC-V model                                       *
// ==============================                                       *
// Control plane                                                        *
// **********************************************************************
 module rv_ctl
 (

     // Output to memory
     output logic memrw,

     // Interface with datapath
     input logic [31:0] instr,
     input logic zero,
     output logic pcsourse,
     output logic pcwrite,
     output logic pccen,
     output logic irwrite,
     output logic [1:0] wbsel,
     output logic regwen,
     output logic [2:0] immsel,
     output logic [1:0]asel,
     output logic [1:0]bsel,
     output logic [3:0] alusel,
     output logic mdrwrite,
     
     // Clock and reset
     input logic clk,
     input logic rst
 );
 
 // Design parameters
 `include "params.inc"

 // =========================================================
 // The state machine
 // =================

 // State declarations
 typedef enum{
    FETCH       = 0,
    DECODE      = 1,
    LSW_ADDR    = 2,
    LW_MEM      = 3,
    LW_WB       = 4,
    SW_MEM      = 5,
    IRTYPE_ALU  = 6,
    ITYPE_ALU   = 7,
    IRTYPE_WB   = 8,
    BEQ_EXEC    = 9,
    JAL_EXEC    = 10
	} sm_type;

sm_type current,next;

 logic [9:0] opcode_funct3;

 // Next state sampling
 always_ff @(posedge clk or posedge rst)
     if (rst)            current <= FETCH;
     else                current <= next;

 // Opcode + Funct3 fields define the instruction
 assign opcode_funct3 = {instr[6:0], instr[14:12]};

 // State transitions
 // ~~~~~~~~~~~~~~~~~
 always_comb
 begin
    case (current)
        FETCH:
            next = DECODE;
        DECODE: begin
            casex (opcode_funct3)
                LW:     next = LSW_ADDR;
                SW:     next = LSW_ADDR;
                ALU:    next = IRTYPE_ALU;
                ADDI:   next = IRTYPE_ALU;
                BEQ:    next = BEQ_EXEC;
                JAL:    next = JAL_EXEC;
                // For unimplemented instructions do nothing
                default:next = FETCH; 
            endcase
        end
        LSW_ADDR: begin
            casex (opcode_funct3)
                LW:     next = LW_MEM;
                SW:     next = SW_MEM;
                // This is never reached
                default:next = SW_MEM;
            endcase
        end
        LW_MEM:
            next = LW_WB;
        LW_WB:
            next = FETCH;
        SW_MEM:
            next = FETCH;
        IRTYPE_ALU: begin
            case (opcode_funct3)
                ALU:    next = IRTYPE_WB;
                ADDI:   next = ITYPE_ALU;
                default:next = IRTYPE_WB;
            endcase
        end
            // next = RTYPE_WB;
        ITYPE_ALU:
            next = IRTYPE_WB;
        IRTYPE_WB:
            next = FETCH; 
        BEQ_EXEC:
            next = FETCH;
        JAL_EXEC:
            next = FETCH;
        default: // Should never reach this
            next = FETCH;
    endcase
 end

 // State Machine Outputs
 // ~~~~~~~~~~~~~~~~~~~~~
 
 always_comb
 begin
     // Default values of all the controls to avoid latches
    pcsourse = PC_INC;
    pcwrite = 1'b0;
    pccen = 1'b0;
    irwrite = 1'b0;
    wbsel = WB_PC;
    regwen = 1'b0;
    immsel = IMM_B;
    asel = ALUA_REG;
    bsel = ALUB_REG;
    alusel = ALU_ADD;
    mdrwrite = 1'b0;
    memrw = 1'b0;
    case (current)
        FETCH:
        begin
            pccen       = 1'b1;
            pcwrite     = 1'b1;
            irwrite     = 1'b1;
            pcsourse    = PC_INC;
        end
        DECODE: begin
            immsel      = IMM_B;
            asel        = ALUA_PCC;
            bsel        = ALUB_IMM;
            alusel      = ALU_ADD;
        end
        LSW_ADDR: begin
            immsel      = (opcode_funct3 == LW) ? IMM_L : IMM_S;
            asel        = ALUA_REG;
            bsel        = ALUB_IMM;
            alusel      = ALU_ADD;
        end
        LW_MEM:
            mdrwrite    = 1'b1;
        LW_WB: begin
            wbsel       = WB_MDR;
            regwen      = 1'b1;
        end
        SW_MEM:
            memrw       = 1'b1;
        IRTYPE_ALU: begin
            case (opcode_funct3)
                ADDI: begin
                    alusel      = ALU_ADD;
                    immsel      = IMM_I;
                    asel        = ALUA_REG;
                    bsel        = ALUB_IMM;
                end
                default: begin // ALU type
                    asel        = ALUA_REG;
                    bsel        = ALUB_REG;
                    alusel      = {instr[14:12],instr[30]}; // Funct3 and INST[30]
                end
            endcase
        end
        ITYPE_ALU: begin
            asel        = ALUA_ALUOUT;
            bsel        = ALUB_MASK;
            alusel      = ALU_XOR;
        end
        IRTYPE_WB: begin
            wbsel       = WB_ALUOUT;
            regwen      = 1'b1;
        end
        BEQ_EXEC: begin
            asel        = ALUA_REG;
            bsel        = ALUB_REG;
            alusel      = ALU_SUB;
            pcsourse    = PC_ALU;
            if (zero)
                pcwrite = 1'b1;
        end
        JAL_EXEC: begin
            asel        = ALUA_PCC;
            bsel        = ALUB_IMM;
            alusel      = ALU_ADD;
            pcsourse    = PC_ALU;
            pcwrite     = 1'b1;
            regwen      = 1'b1;
            wbsel       = WB_PC;
        end
    endcase
 end

endmodule
