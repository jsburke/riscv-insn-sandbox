/////////////////////////////////////////////////
//                                             //
//  Templates to generate new insns            //
//                                             //
//    Comments reference rv user spec          //
//    Chapter 24, the listing                  //
//    some refer to bitmanip work              //
//                                             //
/////////////////////////////////////////////////

.equ RV_CUSTOM_OPCODE_0, 0x17 // 0b00010111
.equ RV_CUSTOM_OPCODE_1, 0x57 // 0b01010111

#define new_r_type_insn(_funct7, _rs2, _rs1, _funct3, _rd, _opcode) \
.word (((_funct7) << 25) | ((_rs2) << 20) | ((_rs1) << 15) | ((_funct3) << 12) | ((_rd) << 7) | ((_opcode) << 0))

  // R2-type is meant for bitmanip insns like clz or pcnt
  // one source reg, one dest, and a constant where r2 is in R-Type

#define new_r2_type_insn(_funct7, _r2_const, _rs1, _funct3, _rd, _opcode) \
.word (((_funct7) << 25) | ((_r2_const) << 20) | ((_rs1) << 15) | ((_funct3) << 12) | ((_rd) << 7) | ((_opcode) << 0))

  // R4-type is meant for some floating and bitmanip insns
  // 3 source registers, one destination

#define new_r4_type_insn(_rs3, _funct2, _rs2, _rs1, _funct3, _rd, _opcode) \
.word (((_rs3) << 27) |((_funct2) << 25) | ((_rs2) << 20) | ((_rs1) << 15) | ((_funct3) << 12) | ((_rd) << 7) | ((_opcode) << 0))

  // I-type instructions imm here is all 12 bits in order imm[11:0] in the spec

#define new_i_type_insn(_imm, _rs1, _funct3, _rd, _opcode) \
.word ((_imm << 20)| (_rs1 << 15)| (_funct3 << 12)| (_rd << 7) | (_opcode << 0))

  // S-Type instructions have _imm_hi correspond to imm[11:5] and _imm_lo to imm[4:0] in spec
  // B-Type instructions have _imm_hi correspond to imm[12|10:5] and _imm_lo to imm[4:1|11] in spec

#define new_sb_type_insn(_imm_hi, _rs2, _rs1, _funct3, _imm_lo, _opcode) \
.word (((_imm_hi) << 25) | ((_rs2) << 20) | ((_rs1) << 15) | ((_funct3) << 12) | ((_imm_lo) << 7) | ((_opcode) << 0))

  // U-Type instructions have imm as imm[31:12] from the spec
  // J-Type instructions have imm as imm[20|10:1|11|19:12] from the spec

#define new_uj_type_insn(_imm, _rd, _opcode) \
.word (((_imm) << 12) | ((_rd) << 7) | ((_opcode) << 0))
