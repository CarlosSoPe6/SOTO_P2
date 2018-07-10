onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/clk
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/reset
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/ALUResultOut
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/if_blackBox/ProgramCounter/PCValue
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/if_blackBox/ROMProgramMemory/Instruction
add wave -noupdate -divider {IF/ID Instruction}
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/if_id_pipelineRegister/in_Instruction
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/if_id_pipelineRegister/out_Instruction
add wave -noupdate -divider ID/EX
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/id_ex_pipelineRegister/in_ALUOp
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/id_ex_pipelineRegister/in_ReadData1
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/id_ex_pipelineRegister/in_RegisterOrShamt
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/id_ex_pipelineRegister/in_ReadData2
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/id_ex_pipelineRegister/out_ReadData2OrInmmediate
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/id_ex_pipelineRegister/out_ReadData1
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/id_ex_pipelineRegister/in_ReadData2OrInmmediate
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/id_ex_pipelineRegister/out_RegisterOrShamt
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/id_ex_pipelineRegister/out_ALUOp
add wave -noupdate -divider EX/MEM
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ex_mem_pipelineRegister/in_ALUResult
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ex_mem_pipelineRegister/in_ReadData1
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ex_mem_pipelineRegister/in_ReadData2
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ex_mem_pipelineRegister/out_ALUResult
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ex_mem_pipelineRegister/out_ReadData1
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ex_mem_pipelineRegister/out_ReadData2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4 ps} 0}
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
WaveRestoreZoom {250 ps} {282 ps}
