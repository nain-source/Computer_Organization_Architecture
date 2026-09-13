# ============================================================
# Computer Architecture Lab (EL-2012)
# Lab #04 - Task 4
# Array Sum
# ============================================================

.data
array: .word 1, 2, 3, 4, 5

.text
.globl main

main:
    la a0, array
    li a1, 5
    call arraysum
    j exit

.globl arraysum
arraysum:
    # a0 = int a[]
    # a1 = int size
    # t0 = ret
    # t1 = i

    li    t0, 0
    li    t1, 0

1:
    bge   t1, a1, 1f
    slli  t2, t1, 2
    add   t2, a0, t2
    lw    t2, 0(t2)
    add   t0, t0, t2
    addi  t1, t1, 1
    j     1b

1:
    mv    a0, t0
    ret

exit:
    li    a7, 10
    ecall
