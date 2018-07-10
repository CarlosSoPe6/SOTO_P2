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
add wave -noupdate /MIPS_Processor_TB/DUV/exStage/ArithmeticLogicUnit/ALUOperation
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/exStage/ArithmeticLogicUnit/A
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/exStage/ArithmeticLogicUnit/B
add wave -noupdate -divider EX/MEM
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ex_mem_pipelineRegister/in_ALUResult
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ex_mem_pipelineRegister/out_ALUResult
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ex_mem_pipelineRegister/out_ReadData1
add wave -noupdate -divider MUX
add wave -noupdate -group MUXFA -radix hexadecimal /MIPS_Processor_TB/DUV/exStage/forwardingA/Selector
add wave -noupdate -group MUXFA -radix hexadecimal /MIPS_Processor_TB/DUV/exStage/forwardingA/MUX_Data0
add wave -noupdate -group MUXFA -radix hexadecimal /MIPS_Processor_TB/DUV/exStage/forwardingA/MUX_Data1
add wave -noupdate -group MUXFA -radix hexadecimal /MIPS_Processor_TB/DUV/exStage/forwardingA/MUX_Data2
add wave -noupdate -group MUXFA -radix hexadecimal /MIPS_Processor_TB/DUV/exStage/forwardingA/MUX_Output
add wave -noupdate -divider MUX
add wave -noupdate -group MUXFB -radix hexadecimal /MIPS_Processor_TB/DUV/exStage/forwardingB/Selector
add wave -noupdate -group MUXFB -radix hexadecimal /MIPS_Processor_TB/DUV/exStage/forwardingB/MUX_Data0
add wave -noupdate -group MUXFB -radix hexadecimal /MIPS_Processor_TB/DUV/exStage/forwardingB/MUX_Data1
add wave -noupdate -group MUXFB -radix hexadecimal /MIPS_Processor_TB/DUV/exStage/forwardingB/MUX_Data2
add wave -noupdate -group MUXFB -radix hexadecimal /MIPS_Processor_TB/DUV/exStage/forwardingB/MUX_Output
add wave -noupdate -divider Forward
add wave -noupdate -group Forward -radix hexadecimal /MIPS_Processor_TB/DUV/forwardingunit/EX_MEM_RegWrite
add wave -noupdate -group Forward -radix hexadecimal /MIPS_Processor_TB/DUV/forwardingunit/MEM_WB_RegWrite
add wave -noupdate -group Forward -radix hexadecimal /MIPS_Processor_TB/DUV/forwardingunit/ID_EX_RegisterRs
add wave -noupdate -group Forward -radix hexadecimal /MIPS_Processor_TB/DUV/forwardingunit/ID_EX_RegisterRt
add wave -noupdate -group Forward -radix hexadecimal /MIPS_Processor_TB/DUV/forwardingunit/EX_MEM_RegisterRd
add wave -noupdate -group Forward -radix hexadecimal /MIPS_Processor_TB/DUV/forwardingunit/MEM_WB_RegisterRd
add wave -noupdate -group Forward -radix hexadecimal /MIPS_Processor_TB/DUV/forwardingunit/ForwardA
add wave -noupdate -group Forward -radix hexadecimal /MIPS_Processor_TB/DUV/forwardingunit/ForwardB
add wave -noupdate -divider Hazard
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/hazardDetectionUnit/clk
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/hazardDetectionUnit/reset
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/hazardDetectionUnit/ID_EX_MemRead
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/hazardDetectionUnit/ID_EX_RegisterRt
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/hazardDetectionUnit/IF_ID_RegisterRs
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/hazardDetectionUnit/IF_ID_RegisterRt
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/hazardDetectionUnit/Stall
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/hazardDetectionUnit/Flush
add wave -noupdate /MIPS_Processor_TB/DUV/hazardDetectionUnit/BranchControl
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {64 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 173
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
WaveRestoreZoom {54 ps} {85 ps}
