onerror {resume}
quietly set dataset_list [list sim vsim]
if {[catch {datasetcheck $dataset_list}]} {abort}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Basic
add wave -noupdate sim:/MIPS_Processor_TB/clk
add wave -noupdate sim:/MIPS_Processor_TB/reset
add wave -noupdate -radix hexadecimal sim:/MIPS_Processor_TB/DUV/ALUResultOut
add wave -noupdate -radix hexadecimal sim:/MIPS_Processor_TB/DUV/if_blackBox/Instruction_wire
add wave -noupdate -radix hexadecimal sim:/MIPS_Processor_TB/DUV/if_blackBox/PC_wire
add wave -noupdate -divider Signals
add wave -noupdate -radix hexadecimal sim:/MIPS_Processor_TB/DUV/ex_mem_pipelineRegister/in_ALUResult
add wave -noupdate -radix hexadecimal sim:/MIPS_Processor_TB/DUV/ex_mem_pipelineRegister/out_ALUResult
add wave -noupdate -radix hexadecimal sim:/MIPS_Processor_TB/DUV/mem_wb_pipelineregister/in_ALUResult
add wave -noupdate -radix hexadecimal sim:/MIPS_Processor_TB/DUV/mem_wb_pipelineregister/out_ALUResult
add wave -noupdate sim:/MIPS_Processor_TB/DUV/mem_wb_pipelineregister/in_CtrlRegWrite
add wave -noupdate sim:/MIPS_Processor_TB/DUV/mem_wb_pipelineregister/out_CtrlRegWrite
add wave -noupdate -radix hexadecimal sim:/MIPS_Processor_TB/DUV/mem_wb_pipelineregister/in_WriteRegister
add wave -noupdate -radix hexadecimal sim:/MIPS_Processor_TB/DUV/mem_wb_pipelineregister/out_WriteRegister
add wave -noupdate -radix hexadecimal sim:/MIPS_Processor_TB/DUV/id_blackBox/in_WriteRegister
add wave -noupdate -radix hexadecimal sim:/MIPS_Processor_TB/DUV/id_blackBox/WriteRegister_wire
add wave -noupdate sim:/MIPS_Processor_TB/DUV/id_blackBox/in_RegWrite
add wave -noupdate -divider RegFile
add wave -noupdate -radix hexadecimal sim:/MIPS_Processor_TB/DUV/id_blackBox/Register_File/RegWrite
add wave -noupdate -radix hexadecimal sim:/MIPS_Processor_TB/DUV/id_blackBox/Register_File/WriteRegister
add wave -noupdate -radix hexadecimal sim:/MIPS_Processor_TB/DUV/id_blackBox/Register_File/WriteData
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20 ps} 0}
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
WaveRestoreZoom {25 ps} {57 ps}
