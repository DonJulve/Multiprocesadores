
scale_shift.1k.single.esc.avx512.gcc:     file format elf64-x86-64


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
  40108a:	e8 01 02 00 00       	call   401290 <scale_shift>
  ss_intr_SSE();
  40108f:	31 c0                	xor    %eax,%eax
  401091:	e8 da 02 00 00       	call   401370 <ss_intr_SSE>
  ss_intr_AVX();
  401096:	31 c0                	xor    %eax,%eax
  401098:	e8 c3 03 00 00       	call   401460 <ss_intr_AVX>
  printf("\nLEN: %u, NTIMES: %lu\n\n", LEN, NTIMES);
  40109d:	bf 53 20 40 00       	mov    $0x402053,%edi
  4010a2:	ba 00 00 f0 00       	mov    $0xf00000,%edx
  4010a7:	31 c0                	xor    %eax,%eax
  4010a9:	be 00 04 00 00       	mov    $0x400,%esi
  4010ae:	e8 8d ff ff ff       	call   401040 <printf@plt>
  exit(0);
  4010b3:	31 ff                	xor    %edi,%edi
  4010b5:	e8 a6 ff ff ff       	call   401060 <exit@plt>

00000000004010ba <.annobin_elf_init.c.hot>:
  4010ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000004010c0 <_start>:
  4010c0:	f3 0f 1e fa          	endbr64 
  4010c4:	31 ed                	xor    %ebp,%ebp
  4010c6:	49 89 d1             	mov    %rdx,%r9
  4010c9:	5e                   	pop    %rsi
  4010ca:	48 89 e2             	mov    %rsp,%rdx
  4010cd:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  4010d1:	50                   	push   %rax
  4010d2:	54                   	push   %rsp
  4010d3:	49 c7 c0 e0 15 40 00 	mov    $0x4015e0,%r8
  4010da:	48 c7 c1 70 15 40 00 	mov    $0x401570,%rcx
  4010e1:	48 c7 c7 70 10 40 00 	mov    $0x401070,%rdi
  4010e8:	ff 15 fa 2e 00 00    	call   *0x2efa(%rip)        # 403fe8 <__libc_start_main@GLIBC_2.2.5>
  4010ee:	f4                   	hlt    

00000000004010ef <.annobin_init.c>:
  4010ef:	90                   	nop

00000000004010f0 <_dl_relocate_static_pie>:
  4010f0:	f3 0f 1e fa          	endbr64 
  4010f4:	c3                   	ret    

00000000004010f5 <.annobin__dl_relocate_static_pie.end>:
  4010f5:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4010fc:	00 00 00 
  4010ff:	90                   	nop

0000000000401100 <deregister_tm_clones>:
  401100:	48 8d 3d 39 2f 00 00 	lea    0x2f39(%rip),%rdi        # 404040 <__TMC_END__>
  401107:	48 8d 05 32 2f 00 00 	lea    0x2f32(%rip),%rax        # 404040 <__TMC_END__>
  40110e:	48 39 f8             	cmp    %rdi,%rax
  401111:	74 15                	je     401128 <deregister_tm_clones+0x28>
  401113:	48 8b 05 c6 2e 00 00 	mov    0x2ec6(%rip),%rax        # 403fe0 <_ITM_deregisterTMCloneTable@Base>
  40111a:	48 85 c0             	test   %rax,%rax
  40111d:	74 09                	je     401128 <deregister_tm_clones+0x28>
  40111f:	ff e0                	jmp    *%rax
  401121:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401128:	c3                   	ret    
  401129:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000401130 <register_tm_clones>:
  401130:	48 8d 3d 09 2f 00 00 	lea    0x2f09(%rip),%rdi        # 404040 <__TMC_END__>
  401137:	48 8d 35 02 2f 00 00 	lea    0x2f02(%rip),%rsi        # 404040 <__TMC_END__>
  40113e:	48 29 fe             	sub    %rdi,%rsi
  401141:	48 89 f0             	mov    %rsi,%rax
  401144:	48 c1 ee 3f          	shr    $0x3f,%rsi
  401148:	48 c1 f8 03          	sar    $0x3,%rax
  40114c:	48 01 c6             	add    %rax,%rsi
  40114f:	48 d1 fe             	sar    %rsi
  401152:	74 14                	je     401168 <register_tm_clones+0x38>
  401154:	48 8b 05 9d 2e 00 00 	mov    0x2e9d(%rip),%rax        # 403ff8 <_ITM_registerTMCloneTable@Base>
  40115b:	48 85 c0             	test   %rax,%rax
  40115e:	74 08                	je     401168 <register_tm_clones+0x38>
  401160:	ff e0                	jmp    *%rax
  401162:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  401168:	c3                   	ret    
  401169:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000401170 <__do_global_dtors_aux>:
  401170:	f3 0f 1e fa          	endbr64 
  401174:	80 3d c5 2e 00 00 00 	cmpb   $0x0,0x2ec5(%rip)        # 404040 <__TMC_END__>
  40117b:	75 13                	jne    401190 <__do_global_dtors_aux+0x20>
  40117d:	55                   	push   %rbp
  40117e:	48 89 e5             	mov    %rsp,%rbp
  401181:	e8 7a ff ff ff       	call   401100 <deregister_tm_clones>
  401186:	c6 05 b3 2e 00 00 01 	movb   $0x1,0x2eb3(%rip)        # 404040 <__TMC_END__>
  40118d:	5d                   	pop    %rbp
  40118e:	c3                   	ret    
  40118f:	90                   	nop
  401190:	c3                   	ret    
  401191:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  401198:	00 00 00 00 
  40119c:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004011a0 <frame_dummy>:
  4011a0:	f3 0f 1e fa          	endbr64 
  4011a4:	eb 8a                	jmp    401130 <register_tm_clones>

00000000004011a6 <dummy>:
  4011a6:	55                   	push   %rbp
  4011a7:	48 89 e5             	mov    %rsp,%rbp
  4011aa:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  4011ae:	f3 0f 11 45 f4       	movss  %xmm0,-0xc(%rbp)
  4011b3:	f3 0f 11 4d f0       	movss  %xmm1,-0x10(%rbp)
  4011b8:	b8 00 00 00 00       	mov    $0x0,%eax
  4011bd:	5d                   	pop    %rbp
  4011be:	c3                   	ret    
  4011bf:	90                   	nop

00000000004011c0 <get_wall_time>:
{
  4011c0:	48 83 ec 18          	sub    $0x18,%rsp
    if (gettimeofday(&time,NULL)) {
  4011c4:	31 f6                	xor    %esi,%esi
  4011c6:	48 89 e7             	mov    %rsp,%rdi
  4011c9:	e8 82 fe ff ff       	call   401050 <gettimeofday@plt>
  4011ce:	85 c0                	test   %eax,%eax
  4011d0:	75 22                	jne    4011f4 <get_wall_time+0x34>
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  4011d2:	c5 f0 57 c9          	vxorps %xmm1,%xmm1,%xmm1
  4011d6:	c4 e1 f3 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm1,%xmm0
  4011dd:	c5 fb 59 05 eb 0e 00 	vmulsd 0xeeb(%rip),%xmm0,%xmm0        # 4020d0 <__dso_handle+0xc8>
  4011e4:	00 
  4011e5:	c4 e1 f3 2a 0c 24    	vcvtsi2sdq (%rsp),%xmm1,%xmm1
}
  4011eb:	48 83 c4 18          	add    $0x18,%rsp
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  4011ef:	c5 fb 58 c1          	vaddsd %xmm1,%xmm0,%xmm0
}
  4011f3:	c3                   	ret    
        exit(-1); // return 0;
  4011f4:	83 cf ff             	or     $0xffffffff,%edi
  4011f7:	e8 64 fe ff ff       	call   401060 <exit@plt>
  4011fc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401200 <check>:
    for (unsigned int i = 0; i < LEN; i++)
  401200:	48 8d 87 00 10 00 00 	lea    0x1000(%rdi),%rax
    real sum = 0;
  401207:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  40120b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
        sum += arr[i];
  401210:	c5 fa 58 07          	vaddss (%rdi),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  401214:	48 83 c7 04          	add    $0x4,%rdi
  401218:	48 39 f8             	cmp    %rdi,%rax
  40121b:	75 f3                	jne    401210 <check+0x10>
    printf("%f \n", sum);
  40121d:	bf 10 20 40 00       	mov    $0x402010,%edi
  401222:	b8 01 00 00 00       	mov    $0x1,%eax
  401227:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40122b:	e9 10 fe ff ff       	jmp    401040 <printf@plt>

0000000000401230 <init>:
    for (unsigned int j = 0; j < LEN; j++)
  401230:	c5 fa 10 05 b0 0e 00 	vmovss 0xeb0(%rip),%xmm0        # 4020e8 <__dso_handle+0xe0>
  401237:	00 
  401238:	b8 80 40 40 00       	mov    $0x404080,%eax
  40123d:	0f 1f 00             	nopl   (%rax)
	    x[j] = 1.0;
  401240:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    for (unsigned int j = 0; j < LEN; j++)
  401244:	48 83 c0 04          	add    $0x4,%rax
  401248:	48 3d 80 50 40 00    	cmp    $0x405080,%rax
  40124e:	75 f0                	jne    401240 <init+0x10>
}
  401250:	31 c0                	xor    %eax,%eax
  401252:	c3                   	ret    
  401253:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  40125a:	00 00 00 00 
  40125e:	66 90                	xchg   %ax,%ax

0000000000401260 <results>:
{
  401260:	48 89 fe             	mov    %rdi,%rsi
    printf("%18s  %5.1f    %5.1f     ",
  401263:	b8 02 00 00 00       	mov    $0x2,%eax
  401268:	bf 15 20 40 00       	mov    $0x402015,%edi
  40126d:	c5 fb 5e 15 6b 0e 00 	vdivsd 0xe6b(%rip),%xmm0,%xmm2        # 4020e0 <__dso_handle+0xd8>
  401274:	00 
  401275:	c5 fb 5e 0d 5b 0e 00 	vdivsd 0xe5b(%rip),%xmm0,%xmm1        # 4020d8 <__dso_handle+0xd0>
  40127c:	00 
  40127d:	c5 eb 10 c2          	vmovsd %xmm2,%xmm2,%xmm0
  401281:	e9 ba fd ff ff       	jmp    401040 <printf@plt>
  401286:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40128d:	00 00 00 

0000000000401290 <scale_shift>:
{
  401290:	41 54                	push   %r12
    init();
  401292:	31 c0                	xor    %eax,%eax
    start_t = get_wall_time();
  401294:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  40129a:	55                   	push   %rbp
  40129b:	53                   	push   %rbx
  40129c:	bb 80 50 40 00       	mov    $0x405080,%ebx
  4012a1:	48 83 ec 10          	sub    $0x10,%rsp
    init();
  4012a5:	e8 86 ff ff ff       	call   401230 <init>
    start_t = get_wall_time();
  4012aa:	31 c0                	xor    %eax,%eax
  4012ac:	e8 0f ff ff ff       	call   4011c0 <get_wall_time>
  4012b1:	c5 fa 10 15 47 0e 00 	vmovss 0xe47(%rip),%xmm2        # 402100 <__dso_handle+0xf8>
  4012b8:	00 
  4012b9:	c5 fa 10 0d 5f 0e 00 	vmovss 0xe5f(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  4012c0:	00 
  4012c1:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  4012c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  4012ce:	00 00 
        for (unsigned int i = 0; i < LEN; i++)
  4012d0:	bd 80 40 40 00       	mov    $0x404080,%ebp
{
  4012d5:	48 89 e8             	mov    %rbp,%rax
  4012d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  4012df:	00 
            x[i] = alpha*x[i] + beta;
  4012e0:	c5 ea 59 00          	vmulss (%rax),%xmm2,%xmm0
        for (unsigned int i = 0; i < LEN; i++)
  4012e4:	48 83 c0 04          	add    $0x4,%rax
            x[i] = alpha*x[i] + beta;
  4012e8:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  4012ec:	c5 fa 11 40 fc       	vmovss %xmm0,-0x4(%rax)
        for (unsigned int i = 0; i < LEN; i++)
  4012f1:	48 39 c3             	cmp    %rax,%rbx
  4012f4:	75 ea                	jne    4012e0 <scale_shift+0x50>
        dummy(x, alpha, beta);
  4012f6:	c5 f8 28 c2          	vmovaps %xmm2,%xmm0
  4012fa:	bf 80 40 40 00       	mov    $0x404080,%edi
  4012ff:	e8 a2 fe ff ff       	call   4011a6 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  401304:	41 83 ec 01          	sub    $0x1,%r12d
  401308:	c5 fa 10 15 f0 0d 00 	vmovss 0xdf0(%rip),%xmm2        # 402100 <__dso_handle+0xf8>
  40130f:	00 
  401310:	c5 fa 10 0d 08 0e 00 	vmovss 0xe08(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  401317:	00 
  401318:	75 b6                	jne    4012d0 <scale_shift+0x40>
    end_t = get_wall_time();
  40131a:	31 c0                	xor    %eax,%eax
  40131c:	e8 9f fe ff ff       	call   4011c0 <get_wall_time>
    results(end_t - start_t, "scale_shift");
  401321:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  401327:	bf 2f 20 40 00       	mov    $0x40202f,%edi
  40132c:	e8 2f ff ff ff       	call   401260 <results>
    real sum = 0;
  401331:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  401335:	0f 1f 00             	nopl   (%rax)
        sum += arr[i];
  401338:	c5 fa 58 45 00       	vaddss 0x0(%rbp),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  40133d:	48 83 c5 04          	add    $0x4,%rbp
  401341:	48 39 eb             	cmp    %rbp,%rbx
  401344:	75 f2                	jne    401338 <scale_shift+0xa8>
    printf("%f \n", sum);
  401346:	bf 10 20 40 00       	mov    $0x402010,%edi
  40134b:	b8 01 00 00 00       	mov    $0x1,%eax
  401350:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  401354:	e8 e7 fc ff ff       	call   401040 <printf@plt>
}
  401359:	48 83 c4 10          	add    $0x10,%rsp
  40135d:	31 c0                	xor    %eax,%eax
  40135f:	5b                   	pop    %rbx
  401360:	5d                   	pop    %rbp
  401361:	41 5c                	pop    %r12
  401363:	c3                   	ret    
  401364:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  40136b:	00 00 00 00 
  40136f:	90                   	nop

0000000000401370 <ss_intr_SSE>:
{
  401370:	41 54                	push   %r12
    init();
  401372:	31 c0                	xor    %eax,%eax
    start_t = get_wall_time();
  401374:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  40137a:	55                   	push   %rbp
  40137b:	53                   	push   %rbx
  40137c:	bb 80 50 40 00       	mov    $0x405080,%ebx
  401381:	48 83 ec 10          	sub    $0x10,%rsp
    init();
  401385:	e8 a6 fe ff ff       	call   401230 <init>
    start_t = get_wall_time();
  40138a:	31 c0                	xor    %eax,%eax
  40138c:	e8 2f fe ff ff       	call   4011c0 <get_wall_time>
  401391:	c4 e2 79 18 1d 66 0d 	vbroadcastss 0xd66(%rip),%xmm3        # 402100 <__dso_handle+0xf8>
  401398:	00 00 
  40139a:	c4 e2 79 18 15 7d 0d 	vbroadcastss 0xd7d(%rip),%xmm2        # 402120 <__dso_handle+0x118>
  4013a1:	00 00 
  4013a3:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  4013a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
        for (unsigned int i = 0; i < LEN; i+= SSE_LEN)
  4013b0:	bd 80 40 40 00       	mov    $0x404080,%ebp
{
  4013b5:	48 89 e8             	mov    %rbp,%rax
  4013b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  4013bf:	00 
}

extern __inline __m128 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_mul_ps (__m128 __A, __m128 __B)
{
  return (__m128) ((__v4sf)__A * (__v4sf)__B);
  4013c0:	c5 e0 59 00          	vmulps (%rax),%xmm3,%xmm0
        for (unsigned int i = 0; i < LEN; i+= SSE_LEN)
  4013c4:	48 83 c0 10          	add    $0x10,%rax
  return (__m128) ((__v4sf)__A + (__v4sf)__B);
  4013c8:	c5 f8 58 c2          	vaddps %xmm2,%xmm0,%xmm0

/* Store four SPFP values.  The address must be 16-byte aligned.  */
extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_store_ps (float *__P, __m128 __A)
{
  *(__m128 *)__P = __A;
  4013cc:	c5 f8 29 40 f0       	vmovaps %xmm0,-0x10(%rax)
  4013d1:	48 39 c3             	cmp    %rax,%rbx
  4013d4:	75 ea                	jne    4013c0 <ss_intr_SSE+0x50>
        dummy(x, alpha, beta);
  4013d6:	c5 fa 10 0d 42 0d 00 	vmovss 0xd42(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  4013dd:	00 
  4013de:	bf 80 40 40 00       	mov    $0x404080,%edi
  4013e3:	c5 fa 10 05 15 0d 00 	vmovss 0xd15(%rip),%xmm0        # 402100 <__dso_handle+0xf8>
  4013ea:	00 
  4013eb:	e8 b6 fd ff ff       	call   4011a6 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  4013f0:	41 83 ec 01          	sub    $0x1,%r12d
  4013f4:	c5 f8 28 1d 04 0d 00 	vmovaps 0xd04(%rip),%xmm3        # 402100 <__dso_handle+0xf8>
  4013fb:	00 
  4013fc:	c5 f8 28 15 1c 0d 00 	vmovaps 0xd1c(%rip),%xmm2        # 402120 <__dso_handle+0x118>
  401403:	00 
  401404:	75 aa                	jne    4013b0 <ss_intr_SSE+0x40>
  end_t = get_wall_time();
  401406:	31 c0                	xor    %eax,%eax
  401408:	e8 b3 fd ff ff       	call   4011c0 <get_wall_time>
  results(end_t - start_t, "ss_intr_SSE");
  40140d:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  401413:	bf 3b 20 40 00       	mov    $0x40203b,%edi
  401418:	e8 43 fe ff ff       	call   401260 <results>
    real sum = 0;
  40141d:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  401421:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
        sum += arr[i];
  401428:	c5 fa 58 45 00       	vaddss 0x0(%rbp),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  40142d:	48 83 c5 04          	add    $0x4,%rbp
  401431:	48 39 eb             	cmp    %rbp,%rbx
  401434:	75 f2                	jne    401428 <ss_intr_SSE+0xb8>
    printf("%f \n", sum);
  401436:	bf 10 20 40 00       	mov    $0x402010,%edi
  40143b:	b8 01 00 00 00       	mov    $0x1,%eax
  401440:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  401444:	e8 f7 fb ff ff       	call   401040 <printf@plt>
}
  401449:	48 83 c4 10          	add    $0x10,%rsp
  40144d:	31 c0                	xor    %eax,%eax
  40144f:	5b                   	pop    %rbx
  401450:	5d                   	pop    %rbp
  401451:	41 5c                	pop    %r12
  401453:	c3                   	ret    
  401454:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  40145b:	00 00 00 00 
  40145f:	90                   	nop

0000000000401460 <ss_intr_AVX>:
{
  401460:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  401465:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  401469:	31 c0                	xor    %eax,%eax
{
  40146b:	41 ff 72 f8          	push   -0x8(%r10)
  40146f:	55                   	push   %rbp
  401470:	48 89 e5             	mov    %rsp,%rbp
  401473:	41 55                	push   %r13
  start_t = get_wall_time();
  401475:	41 bd 00 00 f0 00    	mov    $0xf00000,%r13d
{
  40147b:	41 54                	push   %r12
  40147d:	41 52                	push   %r10
  40147f:	53                   	push   %rbx
  401480:	bb 80 50 40 00       	mov    $0x405080,%ebx
  401485:	48 83 ec 30          	sub    $0x30,%rsp
  init();
  401489:	e8 a2 fd ff ff       	call   401230 <init>
  start_t = get_wall_time();
  40148e:	31 c0                	xor    %eax,%eax
  401490:	e8 2b fd ff ff       	call   4011c0 <get_wall_time>
  401495:	c4 e2 7d 18 1d 62 0c 	vbroadcastss 0xc62(%rip),%ymm3        # 402100 <__dso_handle+0xf8>
  40149c:	00 00 
  40149e:	c4 e2 7d 18 15 79 0c 	vbroadcastss 0xc79(%rip),%ymm2        # 402120 <__dso_handle+0x118>
  4014a5:	00 00 
  4014a7:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  4014ac:	0f 1f 40 00          	nopl   0x0(%rax)
        for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  4014b0:	41 bc 80 40 40 00    	mov    $0x404080,%r12d
{
  4014b6:	4c 89 e0             	mov    %r12,%rax
  4014b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
}

extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_mul_ps (__m256 __A, __m256 __B)
{
  return (__m256) ((__v8sf)__A * (__v8sf)__B);
  4014c0:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
        for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  4014c4:	48 83 c0 20          	add    $0x20,%rax
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  4014c8:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
}

extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_store_ps (float *__P, __m256 __A)
{
  *(__m256 *)__P = __A;
  4014cc:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
  4014d1:	48 39 c3             	cmp    %rax,%rbx
  4014d4:	75 ea                	jne    4014c0 <ss_intr_AVX+0x60>
        dummy(x, alpha, beta);
  4014d6:	c5 fa 10 0d 42 0c 00 	vmovss 0xc42(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  4014dd:	00 
  4014de:	bf 80 40 40 00       	mov    $0x404080,%edi
  4014e3:	c5 fa 10 05 15 0c 00 	vmovss 0xc15(%rip),%xmm0        # 402100 <__dso_handle+0xf8>
  4014ea:	00 
  4014eb:	c5 f8 77             	vzeroupper 
  4014ee:	e8 b3 fc ff ff       	call   4011a6 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  4014f3:	41 83 ed 01          	sub    $0x1,%r13d
  4014f7:	c5 fc 28 1d 01 0c 00 	vmovaps 0xc01(%rip),%ymm3        # 402100 <__dso_handle+0xf8>
  4014fe:	00 
  4014ff:	c5 fc 28 15 19 0c 00 	vmovaps 0xc19(%rip),%ymm2        # 402120 <__dso_handle+0x118>
  401506:	00 
  401507:	75 a7                	jne    4014b0 <ss_intr_AVX+0x50>
  end_t = get_wall_time();
  401509:	31 c0                	xor    %eax,%eax
  40150b:	c5 f8 77             	vzeroupper 
  40150e:	e8 ad fc ff ff       	call   4011c0 <get_wall_time>
  results(end_t - start_t, "ss_intr_AVX");
  401513:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  401518:	bf 47 20 40 00       	mov    $0x402047,%edi
  40151d:	e8 3e fd ff ff       	call   401260 <results>
    real sum = 0;
  401522:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  401526:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40152d:	00 00 00 
        sum += arr[i];
  401530:	c4 c1 7a 58 04 24    	vaddss (%r12),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  401536:	49 83 c4 04          	add    $0x4,%r12
  40153a:	4c 39 e3             	cmp    %r12,%rbx
  40153d:	75 f1                	jne    401530 <ss_intr_AVX+0xd0>
    printf("%f \n", sum);
  40153f:	bf 10 20 40 00       	mov    $0x402010,%edi
  401544:	b8 01 00 00 00       	mov    $0x1,%eax
  401549:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40154d:	e8 ee fa ff ff       	call   401040 <printf@plt>
}
  401552:	48 83 c4 30          	add    $0x30,%rsp
  401556:	31 c0                	xor    %eax,%eax
  401558:	5b                   	pop    %rbx
  401559:	41 5a                	pop    %r10
  40155b:	41 5c                	pop    %r12
  40155d:	41 5d                	pop    %r13
  40155f:	5d                   	pop    %rbp
  401560:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  401564:	c3                   	ret    
  401565:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40156c:	00 00 00 
  40156f:	90                   	nop

0000000000401570 <__libc_csu_init>:
  401570:	f3 0f 1e fa          	endbr64 
  401574:	41 57                	push   %r15
  401576:	49 89 d7             	mov    %rdx,%r15
  401579:	41 56                	push   %r14
  40157b:	49 89 f6             	mov    %rsi,%r14
  40157e:	41 55                	push   %r13
  401580:	41 89 fd             	mov    %edi,%r13d
  401583:	41 54                	push   %r12
  401585:	4c 8d 25 64 28 00 00 	lea    0x2864(%rip),%r12        # 403df0 <__frame_dummy_init_array_entry>
  40158c:	55                   	push   %rbp
  40158d:	48 8d 2d 64 28 00 00 	lea    0x2864(%rip),%rbp        # 403df8 <__do_global_dtors_aux_fini_array_entry>
  401594:	53                   	push   %rbx
  401595:	4c 29 e5             	sub    %r12,%rbp
  401598:	48 83 ec 08          	sub    $0x8,%rsp
  40159c:	e8 5f fa ff ff       	call   401000 <_init>
  4015a1:	48 c1 fd 03          	sar    $0x3,%rbp
  4015a5:	74 1f                	je     4015c6 <__libc_csu_init+0x56>
  4015a7:	31 db                	xor    %ebx,%ebx
  4015a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  4015b0:	4c 89 fa             	mov    %r15,%rdx
  4015b3:	4c 89 f6             	mov    %r14,%rsi
  4015b6:	44 89 ef             	mov    %r13d,%edi
  4015b9:	41 ff 14 dc          	call   *(%r12,%rbx,8)
  4015bd:	48 83 c3 01          	add    $0x1,%rbx
  4015c1:	48 39 dd             	cmp    %rbx,%rbp
  4015c4:	75 ea                	jne    4015b0 <__libc_csu_init+0x40>
  4015c6:	48 83 c4 08          	add    $0x8,%rsp
  4015ca:	5b                   	pop    %rbx
  4015cb:	5d                   	pop    %rbp
  4015cc:	41 5c                	pop    %r12
  4015ce:	41 5d                	pop    %r13
  4015d0:	41 5e                	pop    %r14
  4015d2:	41 5f                	pop    %r15
  4015d4:	c3                   	ret    

00000000004015d5 <.annobin___libc_csu_fini.start>:
  4015d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4015dc:	00 00 00 00 

00000000004015e0 <__libc_csu_fini>:
  4015e0:	f3 0f 1e fa          	endbr64 
  4015e4:	c3                   	ret    

Disassembly of section .fini:

00000000004015e8 <_fini>:
  4015e8:	f3 0f 1e fa          	endbr64 
  4015ec:	48 83 ec 08          	sub    $0x8,%rsp
  4015f0:	48 83 c4 08          	add    $0x8,%rsp
  4015f4:	c3                   	ret    
