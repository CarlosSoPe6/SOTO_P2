# potencia.asm
.text
	add		$zero, $zero, $zero	
	add		$zero, $zero, $zero
	add		$zero, $zero, $zero
_main:
    addi	$v0, $zero, 0			# $v0 = $zero + 0
    addi	$a0, $zero, 6			# $a0 = $zero + 6
    addi	$a1, $zero, 6			# $a1 = $zero + 6
    jal		_pow				    # jump to _pow and save position to $ra
    j		end				        # jump to end

_pow:
    addi	$v0, $zero, 1			# $v0 = $zero + 1
    slt     $t0, $a1, $zero
    addi    $a1, $a1, -1
    beq		$t0, $zero, loop	    # if $t0 == $zero then loop
    jr      $ra

loop:
    addi	$sp, $sp, -4			# $sp = $sp - 4
    sw      $ra, 0($sp)             # Storing n
    jal     _pow
    addi	$sp, $sp, 4			    # $sp = $sp + 4
    lw		$ra, 0($sp)		        
    add     $v0, $v0, $a0
    jr      $ra
    
end:
	add		$zero, $zero, $zero
