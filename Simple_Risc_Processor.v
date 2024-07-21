module Simple_Risc_Processor(
    input clk,
    input reset
);
    // Wires to connect stages
    wire [31:0] pc,pc_current, instr, immx, branch_Target, operand1, operand2, aluResult, ldResult, branchPC;
    wire isSt, isLd, isBeq, isBgt, isRet, isImmediate, isWb, isUBranch, isCall;
    wire isAdd, isSub, isCmp, isMul, isDiv, isMod, isLsl, isLsr, isAsr, isOr, isAnd, isNot, isMov;
    wire [3:0] reg_addr1, reg_addr2, write_addr; 
    wire [31:0] reg_data1, reg_data2;
    wire [31:0] write_data;

    // Instantiate Instruction Fetch stage
    Instruction_Fetch IF (
        .PC(pc),
        .Clk(clk),
        .Reset(reset),
        .IsBranchTaken(isBranchTaken),
        .BranchPC(branchPC),
        .pc_current(pc_current),
        .Instruction(instr)
    );

    // Instantiate Operand Fetch stage
    Operand_Fetch OF (
        .clk(clk),
        .reset(reset),
        .isRet(isRet),
        .isSt(isSt),
        .pc(pc_current),
        .instr(instr),
        .immx(immx),
        .branch_Target(branch_Target),
        .operand1(operand1),
        .operand2(operand2),
        .opcode_Ibit(opcode_Ibit),
        // Register File Interface
        .reg_addr1(reg_addr1),
        .reg_addr2(reg_addr2),
        .reg_data1(reg_data1),
        .reg_data2(reg_data2)
    );

    // Instantiate the Register File module
    Register_File RF (
        .clk(clk),
        .reset(reset),
        .isWb(isWb),
        .addr1(reg_addr1),
        .addr2(reg_addr2),
        .addr3(write_addr),
        .data3(write_data),
        .data1(reg_data1),
        .data2(reg_data2)
    );

    // Instantiate Control Unit
    ControlUnit CU (
        .Instruction(instr),
        .isSt(isSt),
        .isLd(isLd),
        .isBeq(isBeq),
        .isBgt(isBgt),
        .isRet(isRet),
        .isImmediate(isImmediate),
        .isWb(isWb),
        .isUBranch(isUBranch),
        .isCall(isCall),
        .isAdd(isAdd),
        .isSub(isSub),
        .isCmp(isCmp),
        .isMul(isMul),
        .isDiv(isDiv),
        .isMod(isMod),
        .isLsl(isLsl),
        .isLsr(isLsr),
        .isAsr(isAsr),
        .isOr(isOr),
        .isAnd(isAnd),
        .isNot(isNot),
        .isMov(isMov)
    );

    // Instantiate Execute stage
    ExecuteStage EX (
        .branch_Target(branch_Target),
        .op1(operand1),
        .op2(operand2),
        .immx(immx),
        .isRet(isRet),
        .isBeq(isBeq),
        .isBgt(isBgt),
        .isUbranch(isUBranch),
        .isImmediate(isImmediate),
        .isAdd(isAdd),
        .isSub(isSub),
        .isComp(isCmp),
        .isMul(isMul),
        .isDiv(isDiv),
        .isMod(isMod),
        .isLSL(isLsl),
        .isLSR(isLsr),
        .isASR(isAsr),
        .isOR(isOr),
        .isAND(isAnd),
        .isNOT(isNot),
        .isMov(isMov),
        .branchPC(branchPC),
        .isBranchTaken(isBranchTaken),
        .aluResult(aluResult)
    );

    // Instantiate Memory Access stage
    Memory_Access MA (
        .clk(clk),
        .op2(operand2),
        .aluR(aluResult),
        .isLd(isLd),
        .isSt(isSt),
        .ldResult(ldResult)
    );

    // Instantiate Register Write Back stage
    Register_Write_Back WB (
        .clk(clk),
        .reset(reset),
        .pc(pc_current),
        .rd(instr[25:22]),
        .ra(32'd15),
        .instr(instr),
        .aluResult(aluResult),
        .ldResult(ldResult),
        .isLd(isLd),
        .isWb(isWb),
        .isCall(isCall),
        .write_data(write_data),
        .write_addr(write_addr)
    );

endmodule
