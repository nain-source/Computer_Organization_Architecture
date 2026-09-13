# ============================================================
# Computer Architecture Lab (EL-2012)
# Lab #04 - Task 5
# Table of Two and Memory Loads
# ============================================================

.data
table: .word 2
       .word 4
       .word 6
       .word 8
       .word 10
       .word 12
       .word 14
       .word 16
       .word 18
       .word 20

.text
.globl main

main:
    la t0, table

    lw s0, 0(t0)
    lw s1, 4(t0)
    lw s2, 8(t0)
    lw s3, 12(t0)
    lw s4, 16(t0)
    lw s5, 20(t0)
    lw s6, 24(t0)
    lw s7, 28(t0)
    lw s8, 32(t0)
    lw s9, 36(t0)
