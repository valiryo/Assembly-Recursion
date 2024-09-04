.data
.text
.globl main
main:			# Este código simples leva em conta as operações mais básicas (de 32 bits) da arquitetura MIPS. Por isso, o maior valor de n funcional aqui é 11.


	li $s1, 1	# Constante para verificação do caso base
	li $t0, 5          # Valor do fatorial que desejamos calcular
	move $a0, $t0	# Passando t0 para o registrador de parâmetro "a0"
	subi $sp, $sp, 12	# Alocando espaço na pilha
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	sw $fp, 8($sp)
	move $fp, $sp		# Copiando o frame pointer para o stack pointer, para delimitar cada pilha entre as chamadas recursivas
	jal fact
	lw $a0, 0($sp)		# Restaurando Valores
	lw $ra, 4($sp)	
	lw $fp, 8($sp)
	addi $sp, $sp, 12
	j fim

fact:
	subi $sp, $fp, 12	# Alocando espaço na pilha e salvando variáveis
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	sw $fp, 8($sp)
	blt $a0, $s1, retorno 	# Verifica caso base
	subi $a0, $a0, 1	# Diminui o valor em a0 para passagem de parâmetro para próxima chamada
	move $fp, $sp		# Ajusta o frame pointer
	jal fact		# Próxima chamada recursiva com o valor de a0 subtraido em 1
	lw $a0, 0($sp)		# Restaurando variáveis
	lw $ra, 4($sp)
	lw $fp, 8($sp)
	addi $t1, $a0, 1
	mul $v0, $v0, $t1	# Calcula e acumula os valores de retorno entre as chamadas
	addi $sp, $sp, 12
	jr $ra
	

retorno:
	li $v0, 1		# Caso base
	addi $sp, $sp, 12
	move $fp, $sp
	jr $ra

fim:				# Imprime o resultado e encerra o programa
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 10
	syscall
