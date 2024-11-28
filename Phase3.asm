.data
# Prices for products
water_price: .word 2
snacks_price: .word 4
sandwich_price: .word 7
meal_price: .word 10

# Choice for products
water_choice: .word 1
snacks_choice: .word 2
sandwich_choice: .word 3
meal_choice: .word 4
exit_choice: .word -1

# Messages
enterMoney: .asciiz "Enter the amount of money: "
chooseItem: .asciiz "\nChoose an item (1: Water, 2: Snacks, 3: Sandwiches, 4: Meals, -1 to exit): "
minBalance: .asciiz "\nNot enough balance. Please choose another option.\n"
balance: .asciiz "\nRemaining balance: $"
exitMessage: .asciiz "\nThank you for using the vending machine! Remaining balance: $"

.text
.global main

main:
# Ask user for the initial money

# Without syscall

# enterMoney message
addi $t6, $zero, 8196 #store input location in $t6
la $t0, enterMoney # get location of enterMoney message in $t0
j print_msg_1

print_msg_1:
lb $t1, 0($t0) # load a byte from the string stored in $t0
beq $t1, $zero, read_money # if you reached the end of the string, read money entered
sw $t1, 4($t6) # store the byte in output location 8200
add, $t0, $t0, 1 # move onto next memory address
j print_msg_1 # loop

read_money:
lw $t2, 0($t6) # load the input from memory location -$t2 holds the value of balance entered
addi $t4, $zero, 8190 # choosing arbitrary memory location for $t4 to store
sw $t2, 0($t4) # 8190 memory location will be used to store remaining balances 
la $t0, chooseItem
j print_msg_2

print_msg_2:
lb $t1, 0($t0) # load a byte from the string stored in $t0
beq $t1, $zero, read_item # if you reached the end of the string, read item consumer chose
sw $t1, 4($t6) # store the byte in output location 8200
addi, $t0, 1 # move onto next memory address
j print_msg_2 # loop

read_item:
lw $t3, 0($t6) # load the input from memory location - $t3 holds value of the selected item

la $t0, water_choice # load memory location of water_choice to $t0
lb $t1, 0($t0) # load the byte that holds choice 1 onto $t1
beq $t3, $t1, water_case

la $t0, snacks_choice # load memory location of snacks_choice to $t0
lb $t1, 0($t0) # load the byte that holds choice 2 onto $t1
beq $t3, $t1, snacks_case

la $t0, sandwich_choice # load memory location of sandwich_choice to $t0
lb $t1, 0($t0) # load the byte that holds choice 3 onto $t1
beq $t3, $t1, sandwich_case

la $t0, meal_choice # load memory location of meal_choice to $t0
lb $t1, 0($t0) # load the byte that holds choice 4 onto $t1
beq $t3, $t1, meal_case

la $t0, exit_choice # load memory location of exit_choice to $t0
lb $t1, 0($t0) # load the byte that holds choice -1 onto $t1
beq $t3, $t1, exit_case

j read_item # let the consumer keep reading items

water_case:
la $t0, water_price # load water price memory address
lw $t1, 0($t0) # load the value of water price
lw $t2, 0($t4) # load the current balance in memory location
bgt $t1, $t2, error_message # if the balance is less than the price of water, then go to error   message
sub $t2, $t2, $t1 # if not, subtract water_price from balance
sw $t2, 0($t4) # store remaining balance in memory location 8190
j read_item

snacks_case:
la $t0, snacks_price # load snacks price memory address
lw $t1, 0($t0) # load value of snacks price
lw $t2, 0($t4) # load the current balance from memory location
bgt $t1, $t2, error_message # if the balance is less than the price of snacks, then go to error   message
sub $t2, $t2, $t1 # if not, subtract snacks_price from balance
sw $t2, 0($t4) # store remaining balance in memory location 8190
j read_item

sandwich_case:
la $t0, sandwich_price # load sandwich price memory address
lw $t1, 0($t0) # load value of sandwich price
lw $t2, 0($t4) # load the current balance from memory location
bgt $t1, $t2, error_message # if the balance is less than the price of sandwich, then go to error   message
sub $t2, $t2, $t1 # if not, subtract sandwich_price from balance
sw $t2, 0($t4) # store remaining balance in memory location 8190
j read_item

meal_case:
la $t0, meal_price # load meal price memory address
lw $t1, 0($t0) # load value of meal price
lw $t2, 0($t4) # load the current balance from memory location
bgt $t1, $t2, error_message # if the balance is less than the price of meal, then go to error   message
sub $t2, $t2, $t1 # if not, subtract meal_price from balance
sw $t2, 0($t4) # store remaining balance in memory location 8190
j read_item

exit_case:
# enter exit message
la $t0, exitMessage # load memory address of exitMessage
j print_exit_msg

print_exit_msg:
lb $t1, 0($t0) # load a byte from the string stored in $t0
beq $t1, $zero, print_final_balance # if you reached the end of the string, print final balance
sw $t1, 4($t6) # store the byte in output location 8200
add, $t0, $t0, 1 # move onto next memory address
j print_exit_msg # loop

error_message:
# print error msg
la $t0, minBalance # load memory address of minBalance
j print_error_msg

print_error_msg:
lb $t1, 0($t0) # load a byte from the string stored in $t0
beq $t1, $zero, read_item # if you reached the end of the string, go to back to read_item
sw $t1, 4($t6) # store the byte in output location 8200
add, $t0, $t0, 1 # move onto next memory address
j print_error_msg # loop

print_final_balance:
la $t0, balance # store location of balance message in $t0
j print_balance_msg

print_balance_msg:
lb $t1, 0($t0) # load a byte from the string stored in $t0
beq $t1, $zero, print_value # if you reached the end of the string, then print value of balance
sw $t1, 4($t6) # store the byte in output location 8200
add, $t0, $t0, 1 # move onto next memory address
j print_balance_msg # loop

print_value:
lw $t2, 0($t4) # load the remaining balance from memory location $t4 onto $t2
sw $t2, 4($t6) # store the remaining balance in output location 8200
j Done

Done:
