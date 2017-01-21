# Computes the value of a formula,
# (2^3) + (5^2)
#
# Notes:
#
# 'call' handles passing you the return address.
# 'ret' handles using that address to return bck to where the function was called.
#
# We are using the C calling convention. For more detailed analysis, take a look at
# http://www.linuxbase.org/spec/refspecs/
#

.globl _start
_start:

# Function call
pushl $3      # second function argument is pushed onto the stack. %esp is subtracted by 4. 
pushl $2      # first function argument is pushed onto the stack. %esp is subtracted by 4. 

call power    # call the function. 
              # This pushes addr of next inst (the return address) onto the stack. %esp subtracts.
              # Then modifies %eip, the instr pointer, to point to the start of the function.

# When 'power' finishes, we return here ...
addl $8, %esp # move the stack pointer back

pushl %eax    # save the first answer before calling the next function

# Function call
pushl %2      # second function argument
pushl %5      # first function argument
call power    # call the function
addl $8, %esp

popl %ebx       # The second answer is in %eax (see `pushl %eax`)
addl %eax, %ebx # Add the two answers
movl %1, %eax   # exit
int $0x80

# %ebx = base arg
# %ecx = power arg
# -4(%ebp) = current result
# %eax = tmp space
.type power, @function
    power:
    pushl %ebp          # save old base pointer
    movl %esp, %ebp     # make stack pointer the base pointer
    subl $4, %esp       # make room for local variables
    movl 8(%ebp), %ebx  # copy first arg to %ebx
    movl 12(%ebp), %ecx # copy second arg to %ecx
    movl %ebx, -4(%ebp) # copy  current result, the base number, to our result space

    power_loop_start:
        cmpl $1, %ecx # if the power is 1, end
        je end_power

        movl -4(%ebp), %eax # copy current result to %eax
        imull %ebx, %eax    # multiply current result by base arg 
        movl %eax, -4(%esp) # store the current result
        decl %ecx           # decrease the power
        jmp power_loop_start

    end_power:
        movl -4(%ebp), %eax # copy return value to %eax
        movl %ebp, %esp     # restore the stack pointer
        popl %ebp           # restore the base pointer
        ret
