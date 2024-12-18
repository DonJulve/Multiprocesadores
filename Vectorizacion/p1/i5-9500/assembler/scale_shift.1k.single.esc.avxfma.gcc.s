
scale_shift.1k.single.esc.avxfma.gcc:     file format elf64-x86-64


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
  401098:	e8 e3 03 00 00       	call   401480 <ss_intr_AVX>
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
  4010f3:	49 c7 c0 00 16 40 00 	mov    $0x401600,%r8
  4010fa:	48 c7 c1 90 15 40 00 	mov    $0x401590,%rcx
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
  4012b0:	41 54                	push   %r12
    init();
  4012b2:	31 c0                	xor    %eax,%eax
    start_t = get_wall_time();
  4012b4:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  4012ba:	55                   	push   %rbp
  4012bb:	53                   	push   %rbx
  4012bc:	bb 80 50 40 00       	mov    $0x405080,%ebx
  4012c1:	48 83 ec 10          	sub    $0x10,%rsp
    init();
  4012c5:	e8 86 ff ff ff       	call   401250 <init>
    start_t = get_wall_time();
  4012ca:	31 c0                	xor    %eax,%eax
  4012cc:	e8 0f ff ff ff       	call   4011e0 <get_wall_time>
  4012d1:	c5 fa 10 15 27 0e 00 	vmovss 0xe27(%rip),%xmm2        # 402100 <__dso_handle+0xf8>
  4012d8:	00 
  4012d9:	c5 fa 10 0d 3f 0e 00 	vmovss 0xe3f(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  4012e0:	00 
  4012e1:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  4012e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  4012ee:	00 00 
        for (unsigned int i = 0; i < LEN; i++)
  4012f0:	bd 80 40 40 00       	mov    $0x404080,%ebp
{
  4012f5:	48 89 e8             	mov    %rbp,%rax
  4012f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  4012ff:	00 
            x[i] = alpha*x[i] + beta;
  401300:	c5 f8 28 c2          	vmovaps %xmm2,%xmm0
  401304:	c4 e2 71 99 00       	vfmadd132ss (%rax),%xmm1,%xmm0
        for (unsigned int i = 0; i < LEN; i++)
  401309:	48 83 c0 04          	add    $0x4,%rax
            x[i] = alpha*x[i] + beta;
  40130d:	c5 fa 11 40 fc       	vmovss %xmm0,-0x4(%rax)
        for (unsigned int i = 0; i < LEN; i++)
  401312:	48 39 c3             	cmp    %rax,%rbx
  401315:	75 e9                	jne    401300 <scale_shift+0x50>
        dummy(x, alpha, beta);
  401317:	c5 f8 28 c2          	vmovaps %xmm2,%xmm0
  40131b:	bf 80 40 40 00       	mov    $0x404080,%edi
  401320:	e8 a1 fe ff ff       	call   4011c6 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  401325:	41 83 ec 01          	sub    $0x1,%r12d
  401329:	c5 fa 10 15 cf 0d 00 	vmovss 0xdcf(%rip),%xmm2        # 402100 <__dso_handle+0xf8>
  401330:	00 
  401331:	c5 fa 10 0d e7 0d 00 	vmovss 0xde7(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  401338:	00 
  401339:	75 b5                	jne    4012f0 <scale_shift+0x40>
    end_t = get_wall_time();
  40133b:	31 c0                	xor    %eax,%eax
  40133d:	e8 9e fe ff ff       	call   4011e0 <get_wall_time>
    results(end_t - start_t, "scale_shift");
  401342:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  401348:	bf 2f 20 40 00       	mov    $0x40202f,%edi
  40134d:	e8 2e ff ff ff       	call   401280 <results>
    real sum = 0;
  401352:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  401356:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40135d:	00 00 00 
        sum += arr[i];
  401360:	c5 fa 58 45 00       	vaddss 0x0(%rbp),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  401365:	48 83 c5 04          	add    $0x4,%rbp
  401369:	48 39 eb             	cmp    %rbp,%rbx
  40136c:	75 f2                	jne    401360 <scale_shift+0xb0>
    printf("%f \n", sum);
  40136e:	bf 10 20 40 00       	mov    $0x402010,%edi
  401373:	b8 01 00 00 00       	mov    $0x1,%eax
  401378:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40137c:	e8 bf fc ff ff       	call   401040 <printf@plt>
}
  401381:	48 83 c4 10          	add    $0x10,%rsp
  401385:	31 c0                	xor    %eax,%eax
  401387:	5b                   	pop    %rbx
  401388:	5d                   	pop    %rbp
  401389:	41 5c                	pop    %r12
  40138b:	c3                   	ret    
  40138c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401390 <ss_intr_SSE>:
{
  401390:	41 54                	push   %r12
    init();
  401392:	31 c0                	xor    %eax,%eax
    start_t = get_wall_time();
  401394:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  40139a:	55                   	push   %rbp
  40139b:	53                   	push   %rbx
  40139c:	bb 80 50 40 00       	mov    $0x405080,%ebx
  4013a1:	48 83 ec 10          	sub    $0x10,%rsp
    init();
  4013a5:	e8 a6 fe ff ff       	call   401250 <init>
    start_t = get_wall_time();
  4013aa:	31 c0                	xor    %eax,%eax
  4013ac:	e8 2f fe ff ff       	call   4011e0 <get_wall_time>
  4013b1:	c4 e2 79 18 1d 46 0d 	vbroadcastss 0xd46(%rip),%xmm3        # 402100 <__dso_handle+0xf8>
  4013b8:	00 00 
  4013ba:	c4 e2 79 18 15 5d 0d 	vbroadcastss 0xd5d(%rip),%xmm2        # 402120 <__dso_handle+0x118>
  4013c1:	00 00 
  4013c3:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  4013c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
        for (unsigned int i = 0; i < LEN; i+= SSE_LEN)
  4013d0:	bd 80 40 40 00       	mov    $0x404080,%ebp
{
  4013d5:	48 89 e8             	mov    %rbp,%rax
  4013d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  4013df:	00 
/* Perform the respective operation on the four SPFP values in A and B.  */

extern __inline __m128 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_add_ps (__m128 __A, __m128 __B)
{
  return (__m128) ((__v4sf)__A + (__v4sf)__B);
  4013e0:	c5 f8 28 c3          	vmovaps %xmm3,%xmm0
  4013e4:	c4 e2 69 98 00       	vfmadd132ps (%rax),%xmm2,%xmm0
        for (unsigned int i = 0; i < LEN; i+= SSE_LEN)
  4013e9:	48 83 c0 10          	add    $0x10,%rax

/* Store four SPFP values.  The address must be 16-byte aligned.  */
extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_store_ps (float *__P, __m128 __A)
{
  *(__m128 *)__P = __A;
  4013ed:	c5 f8 29 40 f0       	vmovaps %xmm0,-0x10(%rax)
  4013f2:	48 39 c3             	cmp    %rax,%rbx
  4013f5:	75 e9                	jne    4013e0 <ss_intr_SSE+0x50>
        dummy(x, alpha, beta);
  4013f7:	c5 fa 10 0d 21 0d 00 	vmovss 0xd21(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  4013fe:	00 
  4013ff:	c5 fa 10 05 f9 0c 00 	vmovss 0xcf9(%rip),%xmm0        # 402100 <__dso_handle+0xf8>
  401406:	00 
  401407:	bf 80 40 40 00       	mov    $0x404080,%edi
  40140c:	e8 b5 fd ff ff       	call   4011c6 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  401411:	41 83 ec 01          	sub    $0x1,%r12d
  401415:	c5 f8 28 1d e3 0c 00 	vmovaps 0xce3(%rip),%xmm3        # 402100 <__dso_handle+0xf8>
  40141c:	00 
  40141d:	c5 f8 28 15 fb 0c 00 	vmovaps 0xcfb(%rip),%xmm2        # 402120 <__dso_handle+0x118>
  401424:	00 
  401425:	75 a9                	jne    4013d0 <ss_intr_SSE+0x40>
  end_t = get_wall_time();
  401427:	31 c0                	xor    %eax,%eax
  401429:	e8 b2 fd ff ff       	call   4011e0 <get_wall_time>
  results(end_t - start_t, "ss_intr_SSE");
  40142e:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  401434:	bf 3b 20 40 00       	mov    $0x40203b,%edi
  401439:	e8 42 fe ff ff       	call   401280 <results>
    real sum = 0;
  40143e:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  401442:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
        sum += arr[i];
  401448:	c5 fa 58 45 00       	vaddss 0x0(%rbp),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  40144d:	48 83 c5 04          	add    $0x4,%rbp
  401451:	48 39 eb             	cmp    %rbp,%rbx
  401454:	75 f2                	jne    401448 <ss_intr_SSE+0xb8>
    printf("%f \n", sum);
  401456:	bf 10 20 40 00       	mov    $0x402010,%edi
  40145b:	b8 01 00 00 00       	mov    $0x1,%eax
  401460:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  401464:	e8 d7 fb ff ff       	call   401040 <printf@plt>
}
  401469:	48 83 c4 10          	add    $0x10,%rsp
  40146d:	31 c0                	xor    %eax,%eax
  40146f:	5b                   	pop    %rbx
  401470:	5d                   	pop    %rbp
  401471:	41 5c                	pop    %r12
  401473:	c3                   	ret    
  401474:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  40147b:	00 00 00 00 
  40147f:	90                   	nop

0000000000401480 <ss_intr_AVX>:
{
  401480:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  401485:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  401489:	31 c0                	xor    %eax,%eax
{
  40148b:	41 ff 72 f8          	push   -0x8(%r10)
  40148f:	55                   	push   %rbp
  401490:	48 89 e5             	mov    %rsp,%rbp
  401493:	41 55                	push   %r13
  start_t = get_wall_time();
  401495:	41 bd 00 00 f0 00    	mov    $0xf00000,%r13d
{
  40149b:	41 54                	push   %r12
  40149d:	41 52                	push   %r10
  40149f:	53                   	push   %rbx
  4014a0:	bb 80 50 40 00       	mov    $0x405080,%ebx
  4014a5:	48 83 ec 30          	sub    $0x30,%rsp
  init();
  4014a9:	e8 a2 fd ff ff       	call   401250 <init>
  start_t = get_wall_time();
  4014ae:	31 c0                	xor    %eax,%eax
  4014b0:	e8 2b fd ff ff       	call   4011e0 <get_wall_time>
  4014b5:	c4 e2 7d 18 1d 42 0c 	vbroadcastss 0xc42(%rip),%ymm3        # 402100 <__dso_handle+0xf8>
  4014bc:	00 00 
  4014be:	c4 e2 7d 18 15 59 0c 	vbroadcastss 0xc59(%rip),%ymm2        # 402120 <__dso_handle+0x118>
  4014c5:	00 00 
  4014c7:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  4014cc:	0f 1f 40 00          	nopl   0x0(%rax)
        for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  4014d0:	41 bc 80 40 40 00    	mov    $0x404080,%r12d
{
  4014d6:	4c 89 e0             	mov    %r12,%rax
  4014d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
}

extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_add_ps (__m256 __A, __m256 __B)
{
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  4014e0:	c5 fc 28 c3          	vmovaps %ymm3,%ymm0
  4014e4:	c4 e2 6d 98 00       	vfmadd132ps (%rax),%ymm2,%ymm0
        for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  4014e9:	48 83 c0 20          	add    $0x20,%rax
}

extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_store_ps (float *__P, __m256 __A)
{
  *(__m256 *)__P = __A;
  4014ed:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
  4014f2:	48 39 c3             	cmp    %rax,%rbx
  4014f5:	75 e9                	jne    4014e0 <ss_intr_AVX+0x60>
        dummy(x, alpha, beta);
  4014f7:	c5 fa 10 0d 21 0c 00 	vmovss 0xc21(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  4014fe:	00 
  4014ff:	c5 fa 10 05 f9 0b 00 	vmovss 0xbf9(%rip),%xmm0        # 402100 <__dso_handle+0xf8>
  401506:	00 
  401507:	bf 80 40 40 00       	mov    $0x404080,%edi
  40150c:	c5 f8 77             	vzeroupper 
  40150f:	e8 b2 fc ff ff       	call   4011c6 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  401514:	41 83 ed 01          	sub    $0x1,%r13d
  401518:	c5 fc 28 1d e0 0b 00 	vmovaps 0xbe0(%rip),%ymm3        # 402100 <__dso_handle+0xf8>
  40151f:	00 
  401520:	c5 fc 28 15 f8 0b 00 	vmovaps 0xbf8(%rip),%ymm2        # 402120 <__dso_handle+0x118>
  401527:	00 
  401528:	75 a6                	jne    4014d0 <ss_intr_AVX+0x50>
  end_t = get_wall_time();
  40152a:	31 c0                	xor    %eax,%eax
  40152c:	c5 f8 77             	vzeroupper 
  40152f:	e8 ac fc ff ff       	call   4011e0 <get_wall_time>
  results(end_t - start_t, "ss_intr_AVX");
  401534:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  401539:	bf 47 20 40 00       	mov    $0x402047,%edi
  40153e:	e8 3d fd ff ff       	call   401280 <results>
    real sum = 0;
  401543:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  401547:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40154e:	00 00 
        sum += arr[i];
  401550:	c4 c1 7a 58 04 24    	vaddss (%r12),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  401556:	49 83 c4 04          	add    $0x4,%r12
  40155a:	4c 39 e3             	cmp    %r12,%rbx
  40155d:	75 f1                	jne    401550 <ss_intr_AVX+0xd0>
    printf("%f \n", sum);
  40155f:	bf 10 20 40 00       	mov    $0x402010,%edi
  401564:	b8 01 00 00 00       	mov    $0x1,%eax
  401569:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40156d:	e8 ce fa ff ff       	call   401040 <printf@plt>
}
  401572:	48 83 c4 30          	add    $0x30,%rsp
  401576:	31 c0                	xor    %eax,%eax
  401578:	5b                   	pop    %rbx
  401579:	41 5a                	pop    %r10
  40157b:	41 5c                	pop    %r12
  40157d:	41 5d                	pop    %r13
  40157f:	5d                   	pop    %rbp
  401580:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  401584:	c3                   	ret    
  401585:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40158c:	00 00 00 
  40158f:	90                   	nop

0000000000401590 <__libc_csu_init>:
  401590:	f3 0f 1e fa          	endbr64 
  401594:	41 57                	push   %r15
  401596:	49 89 d7             	mov    %rdx,%r15
  401599:	41 56                	push   %r14
  40159b:	49 89 f6             	mov    %rsi,%r14
  40159e:	41 55                	push   %r13
  4015a0:	41 89 fd             	mov    %edi,%r13d
  4015a3:	41 54                	push   %r12
  4015a5:	4c 8d 25 3c 28 00 00 	lea    0x283c(%rip),%r12        # 403de8 <__frame_dummy_init_array_entry>
  4015ac:	55                   	push   %rbp
  4015ad:	48 8d 2d 44 28 00 00 	lea    0x2844(%rip),%rbp        # 403df8 <__do_global_dtors_aux_fini_array_entry>
  4015b4:	53                   	push   %rbx
  4015b5:	4c 29 e5             	sub    %r12,%rbp
  4015b8:	48 83 ec 08          	sub    $0x8,%rsp
  4015bc:	e8 3f fa ff ff       	call   401000 <_init>
  4015c1:	48 c1 fd 03          	sar    $0x3,%rbp
  4015c5:	74 1f                	je     4015e6 <__libc_csu_init+0x56>
  4015c7:	31 db                	xor    %ebx,%ebx
  4015c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  4015d0:	4c 89 fa             	mov    %r15,%rdx
  4015d3:	4c 89 f6             	mov    %r14,%rsi
  4015d6:	44 89 ef             	mov    %r13d,%edi
  4015d9:	41 ff 14 dc          	call   *(%r12,%rbx,8)
  4015dd:	48 83 c3 01          	add    $0x1,%rbx
  4015e1:	48 39 dd             	cmp    %rbx,%rbp
  4015e4:	75 ea                	jne    4015d0 <__libc_csu_init+0x40>
  4015e6:	48 83 c4 08          	add    $0x8,%rsp
  4015ea:	5b                   	pop    %rbx
  4015eb:	5d                   	pop    %rbp
  4015ec:	41 5c                	pop    %r12
  4015ee:	41 5d                	pop    %r13
  4015f0:	41 5e                	pop    %r14
  4015f2:	41 5f                	pop    %r15
  4015f4:	c3                   	ret    

00000000004015f5 <.annobin___libc_csu_fini.start>:
  4015f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4015fc:	00 00 00 00 

0000000000401600 <__libc_csu_fini>:
  401600:	f3 0f 1e fa          	endbr64 
  401604:	c3                   	ret    

Disassembly of section .fini:

0000000000401608 <_fini>:
  401608:	f3 0f 1e fa          	endbr64 
  40160c:	48 83 ec 08          	sub    $0x8,%rsp
  401610:	48 83 c4 08          	add    $0x8,%rsp
  401614:	c3                   	ret    
