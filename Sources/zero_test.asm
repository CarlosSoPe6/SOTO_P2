
.text
main:	
        addi    $sp, $zero, 0x10010800  #Adjusting stack pointer
        add     $t1, $zero, 0x10010000
for: 
	beq	$t1, $sp, endfor	# if $t1 == $t0 then endfor
	sw 	$zero, 0($t1)         # Loading data from memory (vector1)
	addi	$t1, $t1, 4			# $t0 = $t0 + 4
	j 	for
endfor:
      
      add $zero, $zero, $zero 
