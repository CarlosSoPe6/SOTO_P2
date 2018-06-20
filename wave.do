onerror {resume}
quietly virtual signal -install /MIPS_Processor_TB/DUV/ControlUnit { (context /MIPS_Processor_TB/DUV/ControlUnit )&{OP , RegDst , BranchEQ , BranchNE , MemRead , MemtoReg , MemWrite , ALUSrc , RegWrite ,ALUOp }} Control
quietly virtual signal -install /MIPS_Processor_TB/DUV/ControlUnit { (concat_noflatten) (context /MIPS_Processor_TB/DUV/ControlUnit )&{OP , RegDst , BranchEQ , BranchNE , MemRead , MemtoReg , MemWrite , ALUSrc , RegWrite , ALUOp }} Control001
quietly WaveActivateNextPane {} 0
add wave -noupdate /MIPS_Processor_TB/clk
add wave -noupdate /MIPS_Processor_TB/reset
add wave -noupdate -radix decimal /MIPS_Processor_TB/PortIn
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/ALUResultOut
add wave -noupdate -radix decimal /MIPS_Processor_TB/PortOut
add wave -noupdate -divider ROM
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ROMProgramMemory/Address
add wave -noupdate -color Yellow -radix hexadecimal /MIPS_Processor_TB/DUV/ROMProgramMemory/Instruction
add wave -noupdate -divider Control
add wave -noupdate -expand -group Ctrl /MIPS_Processor_TB/DUV/ControlUnit/OP
add wave -noupdate -expand -group Ctrl /MIPS_Processor_TB/DUV/ControlUnit/Function
add wave -noupdate -expand -group Ctrl /MIPS_Processor_TB/DUV/ControlUnit/ShamtSelector
add wave -noupdate -expand -group Ctrl /MIPS_Processor_TB/DUV/ControlUnit/RegDst
add wave -noupdate -expand -group Ctrl /MIPS_Processor_TB/DUV/ControlUnit/BranchEQ
add wave -noupdate -expand -group Ctrl /MIPS_Processor_TB/DUV/ControlUnit/BranchNE
add wave -noupdate -expand -group Ctrl /MIPS_Processor_TB/DUV/ControlUnit/MemRead
add wave -noupdate -expand -group Ctrl /MIPS_Processor_TB/DUV/ControlUnit/MemtoReg
add wave -noupdate -expand -group Ctrl /MIPS_Processor_TB/DUV/ControlUnit/MemWrite
add wave -noupdate -expand -group Ctrl /MIPS_Processor_TB/DUV/ControlUnit/ALUSrc
add wave -noupdate -expand -group Ctrl /MIPS_Processor_TB/DUV/ControlUnit/RegWrite
add wave -noupdate -expand -group Ctrl /MIPS_Processor_TB/DUV/ControlUnit/ALUOp
add wave -noupdate -expand -group Ctrl /MIPS_Processor_TB/DUV/ControlUnit/ControlValues
add wave -noupdate -expand -group Ctrl /MIPS_Processor_TB/DUV/ControlUnit/Control
add wave -noupdate -divider ALU
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/A
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/B
add wave -noupdate -divider DataAndInm
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MUX_ForReadDataAndInmediate/Selector
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MUX_ForReadDataAndInmediate/MUX_Data0
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MUX_ForReadDataAndInmediate/MUX_Data1
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MUX_ForReadDataAndInmediate/MUX_Output
add wave -noupdate -divider Shamt
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MUX_ForRegOrShamt/Selector
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MUX_ForRegOrShamt/MUX_Data0
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MUX_ForRegOrShamt/MUX_Data1
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MUX_ForRegOrShamt/MUX_Output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {2 ps} {74 ps}
