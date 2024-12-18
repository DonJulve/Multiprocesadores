
scale_shift.1k.single.vec.avxfma.gcc:     file format elf64-x86-64


Disassembly of section .init:

0000000000401000 <_init>:
  401000:	f3 0f 1e fa          	endbr64 
  401004:	48 83 ec 08          	sub    $0x8,%rsp
  401008:	48 8b 05 e1 2f 00 00 	mov    0x2fe1(%rip),%rax        # 403ff0 <__gmon_start__@Base>
  40100f:	48 85 c0             	test   %rax,%rax
  401012:	74 02                	je     401016 <_init+0x16>
  401014:	ff d0                	call   *%rax
  401016:	48 83 c4 08          	add    $0x8,%rsp
  40101a:	c3                   	ret    

Disassembly of section .plt:

0000000000401020 <puts@plt-0x10>:
  401020:	ff 35 e2 2f 00 00    	push   0x2fe2(%rip)        # 404008 <_GLOBAL_OFFSET_TABLE_+0x8>
  401026:	ff 25 e4 2f 00 00    	jmp    *0x2fe4(%rip)        # 404010 <_GLOBAL_OFFSET_TABLE_+0x10>
  40102c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401030 <puts@plt>:
  401030:	ff 25 e2 2f 00 00    	jmp    *0x2fe2(%rip)        # 404018 <puts@GLIBC_2.2.5>
  401036:	68 00 00 00 00       	push   $0x0
  40103b:	e9 e0 ff ff ff       	jmp    401020 <_init+0x20>

0000000000401040 <printf@plt>:
  401040:	ff 25 da 2f 00 00    	jmp    *0x2fda(%rip)        # 404020 <printf@GLIBC_2.2.5>
  401046:	68 01 00 00 00       	push   $0x1
  40104b:	e9 d0 ff ff ff       	jmp    401020 <_init+0x20>

0000000000401050 <gettimeofday@plt>:
  401050:	ff 25 d2 2f 00 00    	jmp    *0x2fd2(%rip)        # 404028 <gettimeofday@GLIBC_2.2.5>
  401056:	68 02 00 00 00       	push   $0x2
  40105b:	e9 c0 ff ff ff       	jmp    401020 <_init+0x20>

0000000000401060 <exit@plt>:
  401060:	ff 25 ca 2f 00 00    	jmp    *0x2fca(%rip)        # 404030 <exit@GLIBC_2.2.5>
  401066:	68 03 00 00 00       	push   $0x3
  40106b:	e9 b0 ff ff ff       	jmp    401020 <_init+0x20>

Disassembly of section .text:

0000000000401070 <main>:
  check(x);
  return 0;
}

int main()
{
  401070:	48 83 ec 08          	sub    $0x8,%rsp
  printf("                     Time    TPE\n");
  401074:	bf 70 20 40 00       	mov    $0x402070,%edi
  401079:	e8 b2 ff ff ff       	call   401030 <puts@plt>
  printf("              Loop    ns     ps/el     Checksum \n");
  40107e:	bf 98 20 40 00       	mov    $0x402098,%edi
  401083:	e8 a8 ff ff ff       	call   401030 <puts@plt>
  scale_shift();
  401088:	31 c0                	xor    %eax,%eax
  40108a:	e8 21 02 00 00       	call   4012b0 <scale_shift>
  ss_intr_SSE();
  40108f:	31 c0                	xor    %eax,%eax
  401091:	e8 fa 02 00 00       	call   401390 <ss_intr_SSE>
  ss_intr_AVX();
  401096:	31 c0                	xor    %eax,%eax
  401098:	e8 b3 03 00 00       	call   401450 <ss_intr_AVX>
  printf("\nLEN: %u, NTIMES: %lu\n\n", LEN, NTIMES);
  40109d:	bf 53 20 40 00       	mov    $0x402053,%edi
  4010a2:	ba 00 00 f0 00       	mov    $0xf00000,%edx
  4010a7:	31 c0                	xor    %eax,%eax
  4010a9:	be 00 04 00 00       	mov    $0x400,%esi
  4010ae:	e8 8d ff ff ff       	call   401040 <printf@plt>
  exit(0);
  4010b3:	31 ff                	xor    %edi,%edi
  4010b5:	e8 a6 ff ff ff       	call   401060 <exit@plt>

00000000004010ba <.annobin_elf_init.c.startup>:
  4010ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000004010c0 <set_fast_math>:
  4010c0:	f3 0f 1e fa          	endbr64 
  4010c4:	0f ae 5c 24 fc       	stmxcsr -0x4(%rsp)
  4010c9:	81 4c 24 fc 40 80 00 	orl    $0x8040,-0x4(%rsp)
  4010d0:	00 
  4010d1:	0f ae 54 24 fc       	ldmxcsr -0x4(%rsp)
  4010d6:	c3                   	ret    

00000000004010d7 <.annobin_elf_init.c.hot>:
  4010d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  4010de:	00 00 

00000000004010e0 <_start>:
  4010e0:	f3 0f 1e fa          	endbr64 
  4010e4:	31 ed                	xor    %ebp,%ebp
  4010e6:	49 89 d1             	mov    %rdx,%r9
  4010e9:	5e                   	pop    %rsi
  4010ea:	48 89 e2             	mov    %rsp,%rdx
  4010ed:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  4010f1:	50                   	push   %rax
  4010f2:	54                   	push   %rsp
  4010f3:	49 c7 c0 a0 15 40 00 	mov    $0x4015a0,%r8
  4010fa:	48 c7 c1 30 15 40 00 	mov    $0x401530,%rcx
  401101:	48 c7 c7 70 10 40 00 	mov    $0x401070,%rdi
  401108:	ff 15 da 2e 00 00    	call   *0x2eda(%rip)        # 403fe8 <__libc_start_main@GLIBC_2.2.5>
  40110e:	f4                   	hlt    

000000000040110f <.annobin_init.c>:
  40110f:	90                   	nop

0000000000401110 <_dl_relocate_static_pie>:
  401110:	f3 0f 1e fa          	endbr64 
  401114:	c3                   	ret    

0000000000401115 <.annobin__dl_relocate_static_pie.end>:
  401115:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40111c:	00 00 00 
  40111f:	90                   	nop

0000000000401120 <deregister_tm_clones>:
  401120:	48 8d 3d 19 2f 00 00 	lea    0x2f19(%rip),%rdi        # 404040 <__TMC_END__>
  401127:	48 8d 05 12 2f 00 00 	lea    0x2f12(%rip),%rax        # 404040 <__TMC_END__>
  40112e:	48 39 f8             	cmp    %rdi,%rax
  401131:	74 15                	je     401148 <deregister_tm_clones+0x28>
  401133:	48 8b 05 a6 2e 00 00 	mov    0x2ea6(%rip),%rax        # 403fe0 <_ITM_deregisterTMCloneTable@Base>
  40113a:	48 85 c0             	test   %rax,%rax
  40113d:	74 09                	je     401148 <deregister_tm_clones+0x28>
  40113f:	ff e0                	jmp    *%rax
  401141:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401148:	c3                   	ret    
  401149:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000401150 <register_tm_clones>:
  401150:	48 8d 3d e9 2e 00 00 	lea    0x2ee9(%rip),%rdi        # 404040 <__TMC_END__>
  401157:	48 8d 35 e2 2e 00 00 	lea    0x2ee2(%rip),%rsi        # 404040 <__TMC_END__>
  40115e:	48 29 fe             	sub    %rdi,%rsi
  401161:	48 89 f0             	mov    %rsi,%rax
  401164:	48 c1 ee 3f          	shr    $0x3f,%rsi
  401168:	48 c1 f8 03          	sar    $0x3,%rax
  40116c:	48 01 c6             	add    %rax,%rsi
  40116f:	48 d1 fe             	sar    %rsi
  401172:	74 14                	je     401188 <register_tm_clones+0x38>
  401174:	48 8b 05 7d 2e 00 00 	mov    0x2e7d(%rip),%rax        # 403ff8 <_ITM_registerTMCloneTable@Base>
  40117b:	48 85 c0             	test   %rax,%rax
  40117e:	74 08                	je     401188 <register_tm_clones+0x38>
  401180:	ff e0                	jmp    *%rax
  401182:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  401188:	c3                   	ret    
  401189:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000401190 <__do_global_dtors_aux>:
  401190:	f3 0f 1e fa          	endbr64 
  401194:	80 3d a5 2e 00 00 00 	cmpb   $0x0,0x2ea5(%rip)        # 404040 <__TMC_END__>
  40119b:	75 13                	jne    4011b0 <__do_global_dtors_aux+0x20>
  40119d:	55                   	push   %rbp
  40119e:	48 89 e5             	mov    %rsp,%rbp
  4011a1:	e8 7a ff ff ff       	call   401120 <deregister_tm_clones>
  4011a6:	c6 05 93 2e 00 00 01 	movb   $0x1,0x2e93(%rip)        # 404040 <__TMC_END__>
  4011ad:	5d                   	pop    %rbp
  4011ae:	c3                   	ret    
  4011af:	90                   	nop
  4011b0:	c3                   	ret    
  4011b1:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4011b8:	00 00 00 00 
  4011bc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004011c0 <frame_dummy>:
  4011c0:	f3 0f 1e fa          	endbr64 
  4011c4:	eb 8a                	jmp    401150 <register_tm_clones>

00000000004011c6 <dummy>:
  4011c6:	55                   	push   %rbp
  4011c7:	48 89 e5             	mov    %rsp,%rbp
  4011ca:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  4011ce:	f3 0f 11 45 f4       	movss  %xmm0,-0xc(%rbp)
  4011d3:	f3 0f 11 4d f0       	movss  %xmm1,-0x10(%rbp)
  4011d8:	b8 00 00 00 00       	mov    $0x0,%eax
  4011dd:	5d                   	pop    %rbp
  4011de:	c3                   	ret    
  4011df:	90                   	nop

00000000004011e0 <get_wall_time>:
{
  4011e0:	48 83 ec 18          	sub    $0x18,%rsp
    if (gettimeofday(&time,NULL)) {
  4011e4:	31 f6                	xor    %esi,%esi
  4011e6:	48 89 e7             	mov    %rsp,%rdi
  4011e9:	e8 62 fe ff ff       	call   401050 <gettimeofday@plt>
  4011ee:	85 c0                	test   %eax,%eax
  4011f0:	75 1f                	jne    401211 <get_wall_time+0x31>
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  4011f2:	c5 f0 57 c9          	vxorps %xmm1,%xmm1,%xmm1
  4011f6:	c4 e1 f3 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm1,%xmm0
  4011fd:	c4 e1 f3 2a 0c 24    	vcvtsi2sdq (%rsp),%xmm1,%xmm1
  401203:	c4 e2 f1 99 05 c4 0e 	vfmadd132sd 0xec4(%rip),%xmm1,%xmm0        # 4020d0 <__dso_handle+0xc8>
  40120a:	00 00 
}
  40120c:	48 83 c4 18          	add    $0x18,%rsp
  401210:	c3                   	ret    
        exit(-1); // return 0;
  401211:	83 cf ff             	or     $0xffffffff,%edi
  401214:	e8 47 fe ff ff       	call   401060 <exit@plt>
  401219:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000401220 <check>:
    for (unsigned int i = 0; i < LEN; i++)
  401220:	48 8d 87 00 10 00 00 	lea    0x1000(%rdi),%rax
    real sum = 0;
  401227:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  40122b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
        sum += arr[i];
  401230:	c5 fa 58 07          	vaddss (%rdi),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  401234:	48 83 c7 04          	add    $0x4,%rdi
  401238:	48 39 f8             	cmp    %rdi,%rax
  40123b:	75 f3                	jne    401230 <check+0x10>
    printf("%f \n", sum);
  40123d:	bf 10 20 40 00       	mov    $0x402010,%edi
  401242:	b8 01 00 00 00       	mov    $0x1,%eax
  401247:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40124b:	e9 f0 fd ff ff       	jmp    401040 <printf@plt>

0000000000401250 <init>:
    for (unsigned int j = 0; j < LEN; j++)
  401250:	c5 fa 10 05 90 0e 00 	vmovss 0xe90(%rip),%xmm0        # 4020e8 <__dso_handle+0xe0>
  401257:	00 
  401258:	b8 80 40 40 00       	mov    $0x404080,%eax
  40125d:	0f 1f 00             	nopl   (%rax)
	    x[j] = 1.0;
  401260:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    for (unsigned int j = 0; j < LEN; j++)
  401264:	48 83 c0 04          	add    $0x4,%rax
  401268:	48 3d 80 50 40 00    	cmp    $0x405080,%rax
  40126e:	75 f0                	jne    401260 <init+0x10>
}
  401270:	31 c0                	xor    %eax,%eax
  401272:	c3                   	ret    
  401273:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  40127a:	00 00 00 00 
  40127e:	66 90                	xchg   %ax,%ax

0000000000401280 <results>:
    printf("%18s  %5.1f    %5.1f     ",
  401280:	c5 fb 59 15 58 0e 00 	vmulsd 0xe58(%rip),%xmm0,%xmm2        # 4020e0 <__dso_handle+0xd8>
  401287:	00 
{
  401288:	48 89 fe             	mov    %rdi,%rsi
    printf("%18s  %5.1f    %5.1f     ",
  40128b:	b8 02 00 00 00       	mov    $0x2,%eax
  401290:	bf 15 20 40 00       	mov    $0x402015,%edi
  401295:	c5 fb 59 0d 3b 0e 00 	vmulsd 0xe3b(%rip),%xmm0,%xmm1        # 4020d8 <__dso_handle+0xd0>
  40129c:	00 
  40129d:	c5 eb 10 c2          	vmovsd %xmm2,%xmm2,%xmm0
  4012a1:	e9 9a fd ff ff       	jmp    401040 <printf@plt>
  4012a6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4012ad:	00 00 00 

00000000004012b0 <scale_shift>:
{
  4012b0:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  4012b5:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
    init();
  4012b9:	31 c0                	xor    %eax,%eax
{
  4012bb:	41 ff 72 f8          	push   -0x8(%r10)
  4012bf:	55                   	push   %rbp
  4012c0:	48 89 e5             	mov    %rsp,%rbp
  4012c3:	41 54                	push   %r12
    start_t = get_wall_time();
  4012c5:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  4012cb:	41 52                	push   %r10
  4012cd:	53                   	push   %rbx
  4012ce:	bb 80 50 40 00       	mov    $0x405080,%ebx
  4012d3:	48 83 ec 38          	sub    $0x38,%rsp
    init();
  4012d7:	e8 74 ff ff ff       	call   401250 <init>
    start_t = get_wall_time();
  4012dc:	31 c0                	xor    %eax,%eax
  4012de:	e8 fd fe ff ff       	call   4011e0 <get_wall_time>
  4012e3:	c4 e2 7d 18 1d 14 0e 	vbroadcastss 0xe14(%rip),%ymm3        # 402100 <__dso_handle+0xf8>
  4012ea:	00 00 
  4012ec:	c4 e2 7d 18 15 2b 0e 	vbroadcastss 0xe2b(%rip),%ymm2        # 402120 <__dso_handle+0x118>
  4012f3:	00 00 
  4012f5:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  4012fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
        for (unsigned int i = 0; i < LEN; i++)
  401300:	b8 80 40 40 00       	mov    $0x404080,%eax
  401305:	0f 1f 00             	nopl   (%rax)
            x[i] = alpha*x[i] + beta;
  401308:	c5 fc 28 c3          	vmovaps %ymm3,%ymm0
  40130c:	c4 e2 6d 98 00       	vfmadd132ps (%rax),%ymm2,%ymm0
  401311:	48 83 c0 20          	add    $0x20,%rax
  401315:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
        for (unsigned int i = 0; i < LEN; i++)
  40131a:	48 39 c3             	cmp    %rax,%rbx
  40131d:	75 e9                	jne    401308 <scale_shift+0x58>
        dummy(x, alpha, beta);
  40131f:	c5 fa 10 0d f9 0d 00 	vmovss 0xdf9(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  401326:	00 
  401327:	c5 fa 10 05 d1 0d 00 	vmovss 0xdd1(%rip),%xmm0        # 402100 <__dso_handle+0xf8>
  40132e:	00 
  40132f:	bf 80 40 40 00       	mov    $0x404080,%edi
  401334:	c5 f8 77             	vzeroupper 
  401337:	e8 8a fe ff ff       	call   4011c6 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  40133c:	41 83 ec 01          	sub    $0x1,%r12d
  401340:	c5 fc 28 1d b8 0d 00 	vmovaps 0xdb8(%rip),%ymm3        # 402100 <__dso_handle+0xf8>
  401347:	00 
  401348:	c5 fc 28 15 d0 0d 00 	vmovaps 0xdd0(%rip),%ymm2        # 402120 <__dso_handle+0x118>
  40134f:	00 
  401350:	75 ae                	jne    401300 <scale_shift+0x50>
    end_t = get_wall_time();
  401352:	31 c0                	xor    %eax,%eax
  401354:	c5 f8 77             	vzeroupper 
  401357:	e8 84 fe ff ff       	call   4011e0 <get_wall_time>
    results(end_t - start_t, "scale_shift");
  40135c:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  401361:	bf 2f 20 40 00       	mov    $0x40202f,%edi
  401366:	e8 15 ff ff ff       	call   401280 <results>
    check(x);
  40136b:	bf 80 40 40 00       	mov    $0x404080,%edi
  401370:	e8 ab fe ff ff       	call   401220 <check>
}
  401375:	48 83 c4 38          	add    $0x38,%rsp
  401379:	31 c0                	xor    %eax,%eax
  40137b:	5b                   	pop    %rbx
  40137c:	41 5a                	pop    %r10
  40137e:	41 5c                	pop    %r12
  401380:	5d                   	pop    %rbp
  401381:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  401385:	c3                   	ret    
  401386:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40138d:	00 00 00 

0000000000401390 <ss_intr_SSE>:
{
  401390:	55                   	push   %rbp
    init();
  401391:	31 c0                	xor    %eax,%eax
    start_t = get_wall_time();
  401393:	bd 00 00 f0 00       	mov    $0xf00000,%ebp
{
  401398:	53                   	push   %rbx
  401399:	bb 80 50 40 00       	mov    $0x405080,%ebx
  40139e:	48 83 ec 18          	sub    $0x18,%rsp
    init();
  4013a2:	e8 a9 fe ff ff       	call   401250 <init>
    start_t = get_wall_time();
  4013a7:	31 c0                	xor    %eax,%eax
  4013a9:	e8 32 fe ff ff       	call   4011e0 <get_wall_time>
  4013ae:	c4 e2 79 18 1d 49 0d 	vbroadcastss 0xd49(%rip),%xmm3        # 402100 <__dso_handle+0xf8>
  4013b5:	00 00 
  4013b7:	c4 e2 79 18 15 60 0d 	vbroadcastss 0xd60(%rip),%xmm2        # 402120 <__dso_handle+0x118>
  4013be:	00 00 
  4013c0:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  4013c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4013cd:	00 00 00 
        for (unsigned int i = 0; i < LEN; i+= SSE_LEN)
  4013d0:	b8 80 40 40 00       	mov    $0x404080,%eax
  4013d5:	0f 1f 00             	nopl   (%rax)
/* Perform the respective operation on the four SPFP values in A and B.  */

extern __inline __m128 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_add_ps (__m128 __A, __m128 __B)
{
  return (__m128) ((__v4sf)__A + (__v4sf)__B);
  4013d8:	c5 f8 28 c3          	vmovaps %xmm3,%xmm0
  4013dc:	c4 e2 69 98 00       	vfmadd132ps (%rax),%xmm2,%xmm0
  4013e1:	48 83 c0 10          	add    $0x10,%rax

/* Store four SPFP values.  The address must be 16-byte aligned.  */
extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_store_ps (float *__P, __m128 __A)
{
  *(__m128 *)__P = __A;
  4013e5:	c5 f8 29 40 f0       	vmovaps %xmm0,-0x10(%rax)
  4013ea:	48 39 c3             	cmp    %rax,%rbx
  4013ed:	75 e9                	jne    4013d8 <ss_intr_SSE+0x48>
        dummy(x, alpha, beta);
  4013ef:	c5 fa 10 0d 29 0d 00 	vmovss 0xd29(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  4013f6:	00 
  4013f7:	c5 fa 10 05 01 0d 00 	vmovss 0xd01(%rip),%xmm0        # 402100 <__dso_handle+0xf8>
  4013fe:	00 
  4013ff:	bf 80 40 40 00       	mov    $0x404080,%edi
  401404:	e8 bd fd ff ff       	call   4011c6 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  401409:	83 ed 01             	sub    $0x1,%ebp
  40140c:	c5 f8 28 1d ec 0c 00 	vmovaps 0xcec(%rip),%xmm3        # 402100 <__dso_handle+0xf8>
  401413:	00 
  401414:	c5 f8 28 15 04 0d 00 	vmovaps 0xd04(%rip),%xmm2        # 402120 <__dso_handle+0x118>
  40141b:	00 
  40141c:	75 b2                	jne    4013d0 <ss_intr_SSE+0x40>
  end_t = get_wall_time();
  40141e:	31 c0                	xor    %eax,%eax
  401420:	e8 bb fd ff ff       	call   4011e0 <get_wall_time>
  results(end_t - start_t, "ss_intr_SSE");
  401425:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  40142b:	bf 3b 20 40 00       	mov    $0x40203b,%edi
  401430:	e8 4b fe ff ff       	call   401280 <results>
  check(x);
  401435:	bf 80 40 40 00       	mov    $0x404080,%edi
  40143a:	e8 e1 fd ff ff       	call   401220 <check>
}
  40143f:	48 83 c4 18          	add    $0x18,%rsp
  401443:	31 c0                	xor    %eax,%eax
  401445:	5b                   	pop    %rbx
  401446:	5d                   	pop    %rbp
  401447:	c3                   	ret    
  401448:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40144f:	00 

0000000000401450 <ss_intr_AVX>:
{
  401450:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  401455:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  401459:	31 c0                	xor    %eax,%eax
{
  40145b:	41 ff 72 f8          	push   -0x8(%r10)
  40145f:	55                   	push   %rbp
  401460:	48 89 e5             	mov    %rsp,%rbp
  401463:	41 54                	push   %r12
  start_t = get_wall_time();
  401465:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  40146b:	41 52                	push   %r10
  40146d:	53                   	push   %rbx
  40146e:	bb 80 50 40 00       	mov    $0x405080,%ebx
  401473:	48 83 ec 38          	sub    $0x38,%rsp
  init();
  401477:	e8 d4 fd ff ff       	call   401250 <init>
  start_t = get_wall_time();
  40147c:	31 c0                	xor    %eax,%eax
  40147e:	e8 5d fd ff ff       	call   4011e0 <get_wall_time>
  401483:	c4 e2 7d 18 1d 74 0c 	vbroadcastss 0xc74(%rip),%ymm3        # 402100 <__dso_handle+0xf8>
  40148a:	00 00 
  40148c:	c4 e2 7d 18 15 8b 0c 	vbroadcastss 0xc8b(%rip),%ymm2        # 402120 <__dso_handle+0x118>
  401493:	00 00 
  401495:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  40149a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
        for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  4014a0:	b8 80 40 40 00       	mov    $0x404080,%eax
  4014a5:	0f 1f 00             	nopl   (%rax)
}

extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_add_ps (__m256 __A, __m256 __B)
{
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  4014a8:	c5 fc 28 c3          	vmovaps %ymm3,%ymm0
  4014ac:	c4 e2 6d 98 00       	vfmadd132ps (%rax),%ymm2,%ymm0
  4014b1:	48 83 c0 20          	add    $0x20,%rax
}

extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_store_ps (float *__P, __m256 __A)
{
  *(__m256 *)__P = __A;
  4014b5:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
  4014ba:	48 39 c3             	cmp    %rax,%rbx
  4014bd:	75 e9                	jne    4014a8 <ss_intr_AVX+0x58>
        dummy(x, alpha, beta);
  4014bf:	c5 fa 10 0d 59 0c 00 	vmovss 0xc59(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  4014c6:	00 
  4014c7:	c5 fa 10 05 31 0c 00 	vmovss 0xc31(%rip),%xmm0        # 402100 <__dso_handle+0xf8>
  4014ce:	00 
  4014cf:	bf 80 40 40 00       	mov    $0x404080,%edi
  4014d4:	c5 f8 77             	vzeroupper 
  4014d7:	e8 ea fc ff ff       	call   4011c6 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  4014dc:	41 83 ec 01          	sub    $0x1,%r12d
  4014e0:	c5 fc 28 1d 18 0c 00 	vmovaps 0xc18(%rip),%ymm3        # 402100 <__dso_handle+0xf8>
  4014e7:	00 
  4014e8:	c5 fc 28 15 30 0c 00 	vmovaps 0xc30(%rip),%ymm2        # 402120 <__dso_handle+0x118>
  4014ef:	00 
  4014f0:	75 ae                	jne    4014a0 <ss_intr_AVX+0x50>
  end_t = get_wall_time();
  4014f2:	31 c0                	xor    %eax,%eax
  4014f4:	c5 f8 77             	vzeroupper 
  4014f7:	e8 e4 fc ff ff       	call   4011e0 <get_wall_time>
  results(end_t - start_t, "ss_intr_AVX");
  4014fc:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  401501:	bf 47 20 40 00       	mov    $0x402047,%edi
  401506:	e8 75 fd ff ff       	call   401280 <results>
  check(x);
  40150b:	bf 80 40 40 00       	mov    $0x404080,%edi
  401510:	e8 0b fd ff ff       	call   401220 <check>
}
  401515:	48 83 c4 38          	add    $0x38,%rsp
  401519:	31 c0                	xor    %eax,%eax
  40151b:	5b                   	pop    %rbx
  40151c:	41 5a                	pop    %r10
  40151e:	41 5c                	pop    %r12
  401520:	5d                   	pop    %rbp
  401521:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  401525:	c3                   	ret    
  401526:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40152d:	00 00 00 

0000000000401530 <__libc_csu_init>:
  401530:	f3 0f 1e fa          	endbr64 
  401534:	41 57                	push   %r15
  401536:	49 89 d7             	mov    %rdx,%r15
  401539:	41 56                	push   %r14
  40153b:	49 89 f6             	mov    %rsi,%r14
  40153e:	41 55                	push   %r13
  401540:	41 89 fd             	mov    %edi,%r13d
  401543:	41 54                	push   %r12
  401545:	4c 8d 25 9c 28 00 00 	lea    0x289c(%rip),%r12        # 403de8 <__frame_dummy_init_array_entry>
  40154c:	55                   	push   %rbp
  40154d:	48 8d 2d a4 28 00 00 	lea    0x28a4(%rip),%rbp        # 403df8 <__do_global_dtors_aux_fini_array_entry>
  401554:	53                   	push   %rbx
  401555:	4c 29 e5             	sub    %r12,%rbp
  401558:	48 83 ec 08          	sub    $0x8,%rsp
  40155c:	e8 9f fa ff ff       	call   401000 <_init>
  401561:	48 c1 fd 03          	sar    $0x3,%rbp
  401565:	74 1f                	je     401586 <__libc_csu_init+0x56>
  401567:	31 db                	xor    %ebx,%ebx
  401569:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401570:	4c 89 fa             	mov    %r15,%rdx
  401573:	4c 89 f6             	mov    %r14,%rsi
  401576:	44 89 ef             	mov    %r13d,%edi
  401579:	41 ff 14 dc          	call   *(%r12,%rbx,8)
  40157d:	48 83 c3 01          	add    $0x1,%rbx
  401581:	48 39 dd             	cmp    %rbx,%rbp
  401584:	75 ea                	jne    401570 <__libc_csu_init+0x40>
  401586:	48 83 c4 08          	add    $0x8,%rsp
  40158a:	5b                   	pop    %rbx
  40158b:	5d                   	pop    %rbp
  40158c:	41 5c                	pop    %r12
  40158e:	41 5d                	pop    %r13
  401590:	41 5e                	pop    %r14
  401592:	41 5f                	pop    %r15
  401594:	c3                   	ret    

0000000000401595 <.annobin___libc_csu_fini.start>:
  401595:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  40159c:	00 00 00 00 

00000000004015a0 <__libc_csu_fini>:
  4015a0:	f3 0f 1e fa          	endbr64 
  4015a4:	c3                   	ret    

Disassembly of section .fini:

00000000004015a8 <_fini>:
  4015a8:	f3 0f 1e fa          	endbr64 
  4015ac:	48 83 ec 08          	sub    $0x8,%rsp
  4015b0:	48 83 c4 08          	add    $0x8,%rsp
  4015b4:	c3                   	ret    
