onerror {resume}
quietly virtual signal -install /MIPS_Processor_TB/DUV/ControlUnit { (context /MIPS_Processor_TB/DUV/ControlUnit )&{OP , RegDst , BranchEQ , BranchNE , MemRead , MemtoReg , MemWrite , ALUSrc , RegWrite ,ALUOp }} Control
quietly virtual signal -install /MIPS_Processor_TB/DUV/ControlUnit { (concat_noflatten) (context /MIPS_Processor_TB/DUV/ControlUnit )&{OP , RegDst , BranchEQ , BranchNE , MemRead , MemtoReg , MemWrite , ALUSrc , RegWrite , ALUOp }} Control001
quietly WaveActivateNextPane {} 0
add wave -noupdate /MIPS_Processor_TB/clk
add wave -noupdate /MIPS_Processor_TB/reset
add wave -noupdate -radix decimal /MIPS_Processor_TB/PortIn
add wave -noupdate -radix decimal /MIPS_Processor_TB/ALUResultOut
add wave -noupdate -radix decimal /MIPS_Processor_TB/PortOut
add wave -noupdate -divider ROM
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ROMProgramMemory/Address
add wave -noupdate -color Yellow -radix hexadecimal /MIPS_Processor_TB/DUV/ROMProgramMemory/Instruction
add wave -noupdate -divider Control
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/Control001
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {144 ps} 0}
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
WaveRestoreZoom {132 ps} {204 ps}
