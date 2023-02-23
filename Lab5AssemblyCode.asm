lw   $v0 128($zero)  # PC <=  0, write_addr <= 2, write_data <= 86 Make sure to load the value 86 at line 32 of the .coe (00000000000000000000000001010110)
add  $v1 $v0 $v0     # PC <=  4, write_addr <= 3, write_data <= 172
sw   $v1 132 $zero   # PC <=  8, write_addr <= X, write_data <= X
sub  $a0 $v1 $v0     # PC <= 12, write_addr <= 4, write_data <= 86
addi $a1 $v1 12      # PC <= 16, write_addr <= 5, write_data <= 184
and  $a2 $a1 $v1     # PC <= 20, write_addr <= 6, write_data <= 168
or   $a3 $a2 $v0     # PC <= 24, write_addr <= 7, write_data <= 254
nor  $t0 $a2 $v0     # PC <= 28, write_addr <= 8, write_data <= 4294967041
slt  $a2 $a1 $a0     # PC <= 32, write_addr <= 6, write_data <= 0
beq  $a1 $zero -32   # PC <= 36, write_addr <= X, write_data <= X
lw   $t0, 132($zero) # PC <= 40, write_addr <= 8, write_data <= 172 Used to verify correct execution of the program.