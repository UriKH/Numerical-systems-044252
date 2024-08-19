.text
main:
        # testing ADDI
        lw              t5, 8(x0)
        addi            t4, t5, 12
        sw              t4, 16(x0)

        # continue to loop
        add		t6, x0, x0
        beq		t6, x0, finish

deadend: beq	t6, x0, deadend        

finish:
        lw		t4, 0(x0)
        lw		t5, 4(x0)
        sw		t5, 0xFF(t4)
        beq		t6, x0, deadend


