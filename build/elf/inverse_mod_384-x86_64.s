.text	

.align	32
.Lone:
.quad	1,0,0,0,0,0,0,0

.globl	eucl_inverse_mod_384
.hidden	eucl_inverse_mod_384
.type	eucl_inverse_mod_384,@function
.align	32
eucl_inverse_mod_384:
.cfi_startproc
	.byte	0xf3,0x0f,0x1e,0xfa


	pushq	%rbp
.cfi_adjust_cfa_offset	8
.cfi_offset	%rbp,-16
	pushq	%rbx
.cfi_adjust_cfa_offset	8
.cfi_offset	%rbx,-24
	pushq	%r12
.cfi_adjust_cfa_offset	8
.cfi_offset	%r12,-32
	pushq	%r13
.cfi_adjust_cfa_offset	8
.cfi_offset	%r13,-40
	pushq	%r14
.cfi_adjust_cfa_offset	8
.cfi_offset	%r14,-48
	pushq	%r15
.cfi_adjust_cfa_offset	8
.cfi_offset	%r15,-56
	subq	$536,%rsp
.cfi_adjust_cfa_offset	536


	movq	%rdi,0(%rsp)
	leaq	.Lone(%rip),%rbp
	cmpq	$0,%rcx
	cmoveq	%rbp,%rcx

	movq	0(%rsi),%rax
	movq	8(%rsi),%r9
	movq	16(%rsi),%r10
	movq	24(%rsi),%r11
	movq	32(%rsi),%r12
	movq	40(%rsi),%r13

	movq	%rax,%r8
	orq	%r9,%rax
	orq	%r10,%rax
	orq	%r11,%rax
	orq	%r12,%rax
	orq	%r13,%rax
	jz	.Labort

	leaq	8+255(%rsp),%rsi
	andq	$-256,%rsi

	movq	0(%rcx),%r14
	movq	8(%rcx),%r15
	movq	16(%rcx),%rax
	movq	24(%rcx),%rbx
	movq	32(%rcx),%rbp
	movq	40(%rcx),%rdi

	movq	%r8,0(%rsi)
	movq	%r9,8(%rsi)
	movq	%r10,16(%rsi)
	movq	%r11,24(%rsi)
	movq	%r12,32(%rsi)
	movq	%r13,40(%rsi)

	leaq	128(%rsi),%rcx
	movq	0(%rdx),%r8
	movq	8(%rdx),%r9
	movq	16(%rdx),%r10
	movq	24(%rdx),%r11
	movq	32(%rdx),%r12
	movq	40(%rdx),%r13

	movq	%r14,48(%rsi)
	movq	%r15,56(%rsi)
	movq	%rax,64(%rsi)
	movq	%rbx,72(%rsi)
	movq	%rbp,80(%rsi)
	movq	%rdi,88(%rsi)

	movq	%r8,0(%rcx)
	movq	%r9,8(%rcx)
	movq	%r10,16(%rcx)
	movq	%r11,24(%rcx)
	movq	%r12,32(%rcx)
	movq	%r13,40(%rcx)

	xorl	%eax,%eax
	movq	%rax,48(%rcx)
	movq	%rax,56(%rcx)
	movq	%rax,64(%rcx)
	movq	%rax,72(%rcx)
	movq	%rax,80(%rcx)
	movq	%rax,88(%rcx)
	jmp	.Loop_inv

.align	32
.Loop_inv:


	call	__remove_powers_of_2

	movq	$128,%rcx
	xorq	%rsi,%rcx

	subq	0(%rcx),%r8
	sbbq	8(%rcx),%r9
	sbbq	16(%rcx),%r10
	sbbq	24(%rcx),%r11
	sbbq	32(%rcx),%r12
	sbbq	40(%rcx),%r13
	jae	.Lu_greater_than_v


	xchgq	%rcx,%rsi

	notq	%r8
	notq	%r9
	notq	%r10
	notq	%r11
	notq	%r12
	notq	%r13

	addq	$1,%r8
	adcq	$0,%r9
	adcq	$0,%r10
	adcq	$0,%r11
	adcq	$0,%r12
	adcq	$0,%r13

.Lu_greater_than_v:
	movq	48(%rsi),%r14
	movq	56(%rsi),%r15
	movq	64(%rsi),%rax
	movq	72(%rsi),%rbx
	movq	80(%rsi),%rbp
	movq	88(%rsi),%rdi

	subq	48(%rcx),%r14
	sbbq	56(%rcx),%r15
	sbbq	64(%rcx),%rax
	sbbq	72(%rcx),%rbx
	sbbq	80(%rcx),%rbp
	sbbq	88(%rcx),%rdi

	movq	%r8,0(%rsi)
	sbbq	%rcx,%rcx
	movq	%r9,8(%rsi)
	orq	%r9,%r8
	movq	%rcx,%r9
	movq	%r10,16(%rsi)
	orq	%r10,%r8
	movq	%rcx,%r10
	movq	%r11,24(%rsi)
	orq	%r11,%r8
	movq	%rcx,%r11
	movq	%r12,32(%rsi)
	orq	%r12,%r8
	movq	%rcx,%r12
	movq	%r13,40(%rsi)
	orq	%r13,%r8
	movq	%rcx,%r13

	andq	0(%rdx),%rcx
	andq	8(%rdx),%r9
	andq	16(%rdx),%r10
	andq	24(%rdx),%r11
	andq	32(%rdx),%r12
	andq	40(%rdx),%r13

	addq	%rcx,%r14
	adcq	%r9,%r15
	adcq	%r10,%rax
	adcq	%r11,%rbx
	adcq	%r12,%rbp
	adcq	%r13,%rdi

	movq	%r14,48(%rsi)
	movq	%r15,56(%rsi)
	movq	%rax,64(%rsi)
	movq	%rbx,72(%rsi)
	movq	%rbp,80(%rsi)
	movq	%rdi,88(%rsi)

	testq	%r8,%r8
	jnz	.Loop_inv

	xorq	$128,%rsi
	movq	0(%rsp),%rdi
	movl	$1,%eax

	movq	48(%rsi),%r8
	movq	56(%rsi),%r9
	movq	64(%rsi),%r10
	movq	72(%rsi),%r11
	movq	80(%rsi),%r12
	movq	88(%rsi),%r13

.Labort:
	movq	%r8,0(%rdi)
	movq	%r9,8(%rdi)
	movq	%r10,16(%rdi)
	movq	%r11,24(%rdi)
	movq	%r12,32(%rdi)
	movq	%r13,40(%rdi)

	leaq	536(%rsp),%r8
	movq	0(%r8),%r15
.cfi_restore	%r15
	movq	8(%r8),%r14
.cfi_restore	%r14
	movq	16(%r8),%r13
.cfi_restore	%r13
	movq	24(%r8),%r12
.cfi_restore	%r12
	movq	32(%r8),%rbx
.cfi_restore	%rbx
	movq	40(%r8),%rbp
.cfi_restore	%rbp
	leaq	48(%r8),%rsp
.cfi_adjust_cfa_offset	-536-8*6

	.byte	0xf3,0xc3
.cfi_endproc	
.size	eucl_inverse_mod_384,.-eucl_inverse_mod_384

.type	__remove_powers_of_2,@function
.align	32
__remove_powers_of_2:
.cfi_startproc
	.byte	0xf3,0x0f,0x1e,0xfa

	movq	0(%rsi),%r8
	movq	8(%rsi),%r9
	movq	16(%rsi),%r10
	movq	24(%rsi),%r11
	movq	32(%rsi),%r12
	movq	40(%rsi),%r13

.Loop_of_2:
	bsfq	%r8,%rcx
	movl	$63,%eax
	cmovzl	%eax,%ecx

	cmpl	$0,%ecx
	je	.Loop_of_2_done

	shrq	%cl,%r8
	movq	%r9,%r14
	shrq	%cl,%r9
	movq	%r10,%r15
	shrq	%cl,%r10
	movq	%r11,%rax
	shrq	%cl,%r11
	movq	%r12,%rbx
	shrq	%cl,%r12
	movq	%r13,%rbp
	shrq	%cl,%r13
	negb	%cl
	shlq	%cl,%r14
	shlq	%cl,%r15
	orq	%r14,%r8
	movq	48(%rsi),%r14
	shlq	%cl,%rax
	orq	%r15,%r9
	movq	56(%rsi),%r15
	shlq	%cl,%rbx
	orq	%rax,%r10
	movq	64(%rsi),%rax
	shlq	%cl,%rbp
	orq	%rbx,%r11
	movq	72(%rsi),%rbx
	orq	%rbp,%r12
	movq	80(%rsi),%rbp
	negb	%cl
	movq	88(%rsi),%rdi

	movq	%r8,0(%rsi)
	movq	%r9,8(%rsi)
	movq	%r10,16(%rsi)
	movq	%r11,24(%rsi)
	movq	%r12,32(%rsi)
	movq	%r13,40(%rsi)
	jmp	.Loop_div_by_2

.align	32
.Loop_div_by_2:
	movq	$1,%r13
	movq	0(%rdx),%r8
	andq	%r14,%r13
	movq	8(%rdx),%r9
	negq	%r13
	movq	16(%rdx),%r10
	andq	%r13,%r8
	movq	24(%rdx),%r11
	andq	%r13,%r9
	movq	32(%rdx),%r12
	andq	%r13,%r10
	andq	%r13,%r11
	andq	%r13,%r12
	andq	40(%rdx),%r13

	addq	%r8,%r14
	adcq	%r9,%r15
	adcq	%r10,%rax
	adcq	%r11,%rbx
	adcq	%r12,%rbp
	adcq	%r13,%rdi
	sbbq	%r13,%r13

	shrq	$1,%r14
	movq	%r15,%r8
	shrq	$1,%r15
	movq	%rax,%r9
	shrq	$1,%rax
	movq	%rbx,%r10
	shrq	$1,%rbx
	movq	%rbp,%r11
	shrq	$1,%rbp
	movq	%rdi,%r12
	shrq	$1,%rdi
	shlq	$63,%r8
	shlq	$63,%r9
	orq	%r8,%r14
	shlq	$63,%r10
	orq	%r9,%r15
	shlq	$63,%r11
	orq	%r10,%rax
	shlq	$63,%r12
	orq	%r11,%rbx
	shlq	$63,%r13
	orq	%r12,%rbp
	orq	%r13,%rdi

	decl	%ecx
	jnz	.Loop_div_by_2

	movq	0(%rsi),%r8
	movq	8(%rsi),%r9
	movq	16(%rsi),%r10
	movq	24(%rsi),%r11
	movq	32(%rsi),%r12
	movq	40(%rsi),%r13

	movq	%r14,48(%rsi)
	movq	%r15,56(%rsi)
	movq	%rax,64(%rsi)
	movq	%rbx,72(%rsi)
	movq	%rbp,80(%rsi)
	movq	%rdi,88(%rsi)

	testq	$1,%r8
.byte	0x2e
	jz	.Loop_of_2

.Loop_of_2_done:
	.byte	0xf3,0xc3
.cfi_endproc
.size	__remove_powers_of_2,.-__remove_powers_of_2

.section	.note.GNU-stack,"",@progbits
.section	.note.gnu.property,"a",@note
	.long	4,2f-1f,5
	.byte	0x47,0x4E,0x55,0
1:	.long	0xc0000002,4,3
.align	8
2:
