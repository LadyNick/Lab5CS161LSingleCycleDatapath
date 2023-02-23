LW $v0,31($zero) # Load 361 (0001 0110 1001) at line 31
LW $v1,32($zero) # Load 174 (0000 1010 1110) at line 32
add  $a0, $v0, $v1 # a0 = 535 
addi $a0, $v0, 100 # a0 = 461 

lw $v0, 31($zero) # Looad 3 into V0 at line 31
subi $v0, v0, 1   #
slt  $v1, $v0, $zerr
beq  $v1 $zero -8 