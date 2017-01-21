# Find the maximum number in a list of numbers
#
# %edi = current list position
# %eax = current number being checked
# %ebx = current highest number

.section .data

    # Only values less than 255 are allowed and the last number must be 0
    data_items: .long 3, 25, 9, 4, 32, 199, 89, 4, 99 

.section .text

    # Empty

.globl _start
_start:
    movl $0, %edi                  # Move first number address in list to %edi
    movl data_items(,%edi,4), %eax # (4 := long) Move current value of second number in data_items to %eax
    movl %eax, %ebx                # Move that value to %eax to indicate the biggest so far

start_loop:
    cmpl $0, %eax                  # Check to see if we've no more numbers
    je loop_exit                   # if so, then finish

    incl %edi                      #increment the value of %edi by 1
    movl data_items(,%edi,4), %eax # Move current position() to %eax
    cmpl %ebx, %eax                # Compare with current highest value
    jle start_loop                 # Jump to start_loop if %ebx < %eax

    movl %eax, %ebx                # Otherwise, move the current value to %ebx, the new max value
    jmp start_loop                 # and then jump to start_loop

loop_exit:
    movl $1, %eax                  # 1 is the exit() syscall
    int $0x80                      # Wake up the kernel (or whoever has control of interrupts)



# Move current number to %eax

