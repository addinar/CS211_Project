# Phase 3
# Addina Rahaman, Saanavi Goyal, Raeesah Iram

.data
# Prices for products
water_price: .word 2
snacks_price: .word 4
sandwich_price: .word 7
meal_price: .word 10

# Messages
enterMoney: .asciiz "Enter the amount of money: "
chooseItem: .asciiz "\nChoose an item (1: Water $2, 2: Snacks $4, 3: Sandwiches $7, 4: Meals $10, -1 to exit): "
minBalance: .asciiz "\nNot enough balance. Please choose another option.\n"
balance: .asciiz "\nRemaining balance: $"
exitMessage: .asciiz "\nThank you for using the vending machine! Remaining balance: $"

# Selected item messages
selectedWater: .asciiz "\nYou selected Water."
selectedSnacks: .asciiz "\nYou selected Snacks."
selectedSandwich: .asciiz "\nYou selected Sandwiches"
selectedMeal: .asciiz "\nYou selected Meals.”


.text
.globl main

main:
    # get initial money
    la $a0, enterMoney  # load the address of enterMoney onto $a0
    li $v0, 4  # value of 4 in $v0 indicates to print the string
    syscall # executes the call

    li $v0, 5 # value of 5 in $v0 indicates to read integer
    syscall # execute call
    move $t0, $v0 # stores that input in $t0 - $t0 stores init balance

# while loop
item_selection: 
    # item selection message
    la $a0, chooseItem
    li $v0, 4 # value of 4 in $v0 indicates to print string
    syscall

    # get user choice
    li $v0, 5 # values of 5 in $v0 indicates to read input
    syscall
    move $t1, $v0  # store user choice in $t1

    # check if user wants to exit
    li $t2, -1 # load value -1 in $t2
    beq $t1, $t2, exit_program # if input is -1, then go to exit_program label 

    # Process choices
    li $t2, 1 # load value 1 in $t2
    beq $t1, $t2, water_case # if input 1, then go to water_case

    li $t2, 2 # load value 2 in $t2
    beq $t1, $t2, snacks_case # if input is 2, then go to snacks_case

    li $t2, 3 # load value 3 in $t2
    beq $t1, $t2, sandwich_case # if input is 3, then go to sandwich_case

    li $t2, 4
    beq $t1, $t2, meal_case # if input is 4, then go meal_case

    # Invalid choice, loop back
    j item_selection # loop back

water_case:
    # selected item message
    la $a0, selectedWater
    li $v0, 4
    syscall

    lw $t2, water_price   # load water price
    j process_purchase

snacks_case:
    # selected item message
    la $a0, selectedSnacks
    li $v0, 4
    syscall

    lw $t2, snacks_price  # load snacks price
    j process_purchase

sandwich_case:
    # selected item message
    la $a0, selectedSandwich
    li $v0, 4
    syscall

    lw $t2, sandwich_price # Load sandwich price
    j process_purchase

meal_case:
    # selected item message
    la $a0, selectedMeal
    li $v0, 4
    syscall

    lw $t2, meal_price    # load meal price

process_purchase:
    # if the remaining balance is less than price, then go to insufficient_balance label
    blt $t0, $t2, insufficient_balance

    # deduct price from balance
    sub $t0, $t0, $t2 # if not, then subtract the price from current balance
    j item_selection # loop back to item selection so user can keep picking multiple options

insufficient_balance:
    # insufficient balance message
    la $a0, minBalance
    li $v0, 4
    syscall
    j item_selection # loop back to item selection so user can keep picking multiple options

exit_program: # when you choose -1
    # Display exit message
    la $a0, exitMessage
    li $v0, 4
    syscall

    move $a0, $t0 # load balance into $a0 
    li $v0, 1  #value of 1 in $v0 indicates to print an integer
    syscall

    # Exit program
    li $v0, 10  # value of 10 in $v0 indicates to exit program
    syscall
