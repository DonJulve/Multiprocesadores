
ss_stride.1k.single.avx2.gcc:     file format elf64-x86-64


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
  return 0;
}
#endif

int main()
{
  401070:	48 83 ec 08          	sub    $0x8,%rsp
  printf("                     Time       TPE\n");
  401074:	bf 50 20 40 00       	mov    $0x402050,%edi
  401079:	e8 b2 ff ff ff       	call   401030 <puts@plt>
  printf("             Loop     ns       ps/el     Checksum\n");
  40107e:	bf 78 20 40 00       	mov    $0x402078,%edi
  401083:	e8 a8 ff ff ff       	call   401030 <puts@plt>
  ss_stride_esc();
  401088:	31 c0                	xor    %eax,%eax
  40108a:	e8 01 02 00 00       	call   401290 <ss_stride_esc>
  ss_stride_vec();
  40108f:	31 c0                	xor    %eax,%eax
  401091:	e8 9a 02 00 00       	call   401330 <ss_stride_vec>
  //ss_stride_v2(x);
  return 0;
}
  401096:	31 c0                	xor    %eax,%eax
  401098:	48 83 c4 08          	add    $0x8,%rsp
  40109c:	c3                   	ret    

000000000040109d <.annobin_elf_init.c.startup>:
  40109d:	0f 1f 00             	nopl   (%rax)

00000000004010a0 <set_fast_math>:
  4010a0:	f3 0f 1e fa          	endbr64 
  4010a4:	0f ae 5c 24 fc       	stmxcsr -0x4(%rsp)
  4010a9:	81 4c 24 fc 40 80 00 	orl    $0x8040,-0x4(%rsp)
  4010b0:	00 
  4010b1:	0f ae 54 24 fc       	ldmxcsr -0x4(%rsp)
  4010b6:	c3                   	ret    

00000000004010b7 <.annobin_elf_init.c.hot>:
  4010b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  4010be:	00 00 

00000000004010c0 <_start>:
  4010c0:	f3 0f 1e fa          	endbr64 
  4010c4:	31 ed                	xor    %ebp,%ebp
  4010c6:	49 89 d1             	mov    %rdx,%r9
  4010c9:	5e                   	pop    %rsi
  4010ca:	48 89 e2             	mov    %rsp,%rdx
  4010cd:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  4010d1:	50                   	push   %rax
  4010d2:	54                   	push   %rsp
  4010d3:	49 c7 c0 e0 14 40 00 	mov    $0x4014e0,%r8
  4010da:	48 c7 c1 70 14 40 00 	mov    $0x401470,%rcx
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
  4011d0:	75 1f                	jne    4011f1 <get_wall_time+0x31>
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  4011d2:	c5 f0 57 c9          	vxorps %xmm1,%xmm1,%xmm1
  4011d6:	c4 e1 f3 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm1,%xmm0
  4011dd:	c4 e1 f3 2a 0c 24    	vcvtsi2sdq (%rsp),%xmm1,%xmm1
  4011e3:	c4 e2 f1 99 05 c4 0e 	vfmadd132sd 0xec4(%rip),%xmm1,%xmm0        # 4020b0 <__dso_handle+0xa8>
  4011ea:	00 00 
}
  4011ec:	48 83 c4 18          	add    $0x18,%rsp
  4011f0:	c3                   	ret    
        exit(-1); // return 0;
  4011f1:	83 cf ff             	or     $0xffffffff,%edi
  4011f4:	e8 67 fe ff ff       	call   401060 <exit@plt>
  4011f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

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
  401230:	c5 fa 10 05 90 0e 00 	vmovss 0xe90(%rip),%xmm0        # 4020c8 <__dso_handle+0xc0>
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
    printf("%18s  %6.1f    %6.1f     ",
  401260:	c5 fb 59 15 58 0e 00 	vmulsd 0xe58(%rip),%xmm0,%xmm2        # 4020c0 <__dso_handle+0xb8>
  401267:	00 
{
  401268:	48 89 fe             	mov    %rdi,%rsi
    printf("%18s  %6.1f    %6.1f     ",
  40126b:	b8 02 00 00 00       	mov    $0x2,%eax
  401270:	bf 15 20 40 00       	mov    $0x402015,%edi
  401275:	c5 fb 59 0d 3b 0e 00 	vmulsd 0xe3b(%rip),%xmm0,%xmm1        # 4020b8 <__dso_handle+0xb0>
  40127c:	00 
  40127d:	c5 eb 10 c2          	vmovsd %xmm2,%xmm2,%xmm0
  401281:	e9 ba fd ff ff       	jmp    401040 <printf@plt>
  401286:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40128d:	00 00 00 

0000000000401290 <ss_stride_esc>:
{
  401290:	53                   	push   %rbx
  init();
  401291:	31 c0                	xor    %eax,%eax
  start_t = get_wall_time();
  401293:	bb 00 00 f0 00       	mov    $0xf00000,%ebx
{
  401298:	48 83 ec 10          	sub    $0x10,%rsp
  init();
  40129c:	e8 8f ff ff ff       	call   401230 <init>
  start_t = get_wall_time();
  4012a1:	31 c0                	xor    %eax,%eax
  4012a3:	e8 18 ff ff ff       	call   4011c0 <get_wall_time>
  4012a8:	c5 fa 10 15 70 0e 00 	vmovss 0xe70(%rip),%xmm2        # 402120 <__dso_handle+0x118>
  4012af:	00 
  4012b0:	c5 fa 10 0d 88 0e 00 	vmovss 0xe88(%rip),%xmm1        # 402140 <__dso_handle+0x138>
  4012b7:	00 
  4012b8:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4012be:	66 90                	xchg   %ax,%ax
    for (unsigned int i = 0; i < 2*LEN; i+=2)
  4012c0:	b8 80 40 40 00       	mov    $0x404080,%eax
  4012c5:	0f 1f 00             	nopl   (%rax)
      x[i] = alpha*x[i] + beta;
  4012c8:	c5 f8 28 c2          	vmovaps %xmm2,%xmm0
  4012cc:	c4 e2 71 99 00       	vfmadd132ss (%rax),%xmm1,%xmm0
    for (unsigned int i = 0; i < 2*LEN; i+=2)
  4012d1:	48 83 c0 08          	add    $0x8,%rax
      x[i] = alpha*x[i] + beta;
  4012d5:	c5 fa 11 40 f8       	vmovss %xmm0,-0x8(%rax)
    for (unsigned int i = 0; i < 2*LEN; i+=2)
  4012da:	48 3d 80 60 40 00    	cmp    $0x406080,%rax
  4012e0:	75 e6                	jne    4012c8 <ss_stride_esc+0x38>
    dummy(x, alpha, beta);
  4012e2:	c5 f8 28 c2          	vmovaps %xmm2,%xmm0
  4012e6:	bf 80 40 40 00       	mov    $0x404080,%edi
  4012eb:	e8 b6 fe ff ff       	call   4011a6 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4012f0:	83 eb 01             	sub    $0x1,%ebx
  4012f3:	c5 fa 10 15 25 0e 00 	vmovss 0xe25(%rip),%xmm2        # 402120 <__dso_handle+0x118>
  4012fa:	00 
  4012fb:	c5 fa 10 0d 3d 0e 00 	vmovss 0xe3d(%rip),%xmm1        # 402140 <__dso_handle+0x138>
  401302:	00 
  401303:	75 bb                	jne    4012c0 <ss_stride_esc+0x30>
  end_t = get_wall_time();
  401305:	31 c0                	xor    %eax,%eax
  401307:	e8 b4 fe ff ff       	call   4011c0 <get_wall_time>
  results(end_t - start_t, "ss_stride_esc");
  40130c:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  401312:	bf 2f 20 40 00       	mov    $0x40202f,%edi
  401317:	e8 44 ff ff ff       	call   401260 <results>
  check(x);
  40131c:	bf 80 40 40 00       	mov    $0x404080,%edi
  401321:	e8 da fe ff ff       	call   401200 <check>
}
  401326:	48 83 c4 10          	add    $0x10,%rsp
  40132a:	31 c0                	xor    %eax,%eax
  40132c:	5b                   	pop    %rbx
  40132d:	c3                   	ret    
  40132e:	66 90                	xchg   %ax,%ax

0000000000401330 <ss_stride_vec>:
{
  401330:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  401335:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  401339:	31 c0                	xor    %eax,%eax
{
  40133b:	41 ff 72 f8          	push   -0x8(%r10)
  40133f:	55                   	push   %rbp
  401340:	48 89 e5             	mov    %rsp,%rbp
  401343:	41 52                	push   %r10
  401345:	53                   	push   %rbx
  start_t = get_wall_time();
  401346:	bb 00 00 f0 00       	mov    $0xf00000,%ebx
{
  40134b:	48 83 ec 20          	sub    $0x20,%rsp
  init();
  40134f:	e8 dc fe ff ff       	call   401230 <init>
  start_t = get_wall_time();
  401354:	31 c0                	xor    %eax,%eax
  401356:	e8 65 fe ff ff       	call   4011c0 <get_wall_time>
  40135b:	c5 fd 6f 2d 7d 0d 00 	vmovdqa 0xd7d(%rip),%ymm5        # 4020e0 <__dso_handle+0xd8>
  401362:	00 
  401363:	c5 fd 6f 25 95 0d 00 	vmovdqa 0xd95(%rip),%ymm4        # 402100 <__dso_handle+0xf8>
  40136a:	00 
  40136b:	c4 e2 7d 18 1d ac 0d 	vbroadcastss 0xdac(%rip),%ymm3        # 402120 <__dso_handle+0x118>
  401372:	00 00 
  401374:	c5 fb 11 45 e8       	vmovsd %xmm0,-0x18(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  401379:	c4 e2 7d 18 15 be 0d 	vbroadcastss 0xdbe(%rip),%ymm2        # 402140 <__dso_handle+0x138>
  401380:	00 00 
  401382:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    for (unsigned int i = 0; i < 2*LEN; i+=2)
  401388:	b8 80 40 40 00       	mov    $0x404080,%eax
  40138d:	0f 1f 00             	nopl   (%rax)
        x[i] = alpha*x[i] + beta;
  401390:	c4 e2 55 36 00       	vpermd (%rax),%ymm5,%ymm0
  401395:	c4 e2 5d 36 48 20    	vpermd 0x20(%rax),%ymm4,%ymm1
  40139b:	48 83 c0 40          	add    $0x40,%rax
  40139f:	c4 e3 7d 0c c1 f0    	vblendps $0xf0,%ymm1,%ymm0,%ymm0
  4013a5:	c4 e2 6d 98 c3       	vfmadd132ps %ymm3,%ymm2,%ymm0
  4013aa:	c5 fa 11 40 c0       	vmovss %xmm0,-0x40(%rax)
  4013af:	c4 e3 79 17 40 c8 01 	vextractps $0x1,%xmm0,-0x38(%rax)
  4013b6:	c4 e3 79 17 40 d0 02 	vextractps $0x2,%xmm0,-0x30(%rax)
  4013bd:	c4 e3 79 17 40 d8 03 	vextractps $0x3,%xmm0,-0x28(%rax)
  4013c4:	c4 e3 7d 19 c0 01    	vextractf128 $0x1,%ymm0,%xmm0
  4013ca:	c5 fa 11 40 e0       	vmovss %xmm0,-0x20(%rax)
  4013cf:	c4 e3 79 17 40 e8 01 	vextractps $0x1,%xmm0,-0x18(%rax)
  4013d6:	c4 e3 79 17 40 f0 02 	vextractps $0x2,%xmm0,-0x10(%rax)
  4013dd:	c4 e3 79 17 40 f8 03 	vextractps $0x3,%xmm0,-0x8(%rax)
    for (unsigned int i = 0; i < 2*LEN; i+=2)
  4013e4:	48 3d 80 60 40 00    	cmp    $0x406080,%rax
  4013ea:	75 a4                	jne    401390 <ss_stride_vec+0x60>
    dummy(x, alpha, beta);
  4013ec:	c5 fa 10 0d 4c 0d 00 	vmovss 0xd4c(%rip),%xmm1        # 402140 <__dso_handle+0x138>
  4013f3:	00 
  4013f4:	c5 fa 10 05 24 0d 00 	vmovss 0xd24(%rip),%xmm0        # 402120 <__dso_handle+0x118>
  4013fb:	00 
  4013fc:	bf 80 40 40 00       	mov    $0x404080,%edi
  401401:	c5 f8 77             	vzeroupper 
  401404:	e8 9d fd ff ff       	call   4011a6 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  401409:	83 eb 01             	sub    $0x1,%ebx
  40140c:	c5 fd 6f 2d cc 0c 00 	vmovdqa 0xccc(%rip),%ymm5        # 4020e0 <__dso_handle+0xd8>
  401413:	00 
  401414:	c5 fd 6f 25 e4 0c 00 	vmovdqa 0xce4(%rip),%ymm4        # 402100 <__dso_handle+0xf8>
  40141b:	00 
  40141c:	c5 fc 28 1d fc 0c 00 	vmovaps 0xcfc(%rip),%ymm3        # 402120 <__dso_handle+0x118>
  401423:	00 
  401424:	c5 fc 28 15 14 0d 00 	vmovaps 0xd14(%rip),%ymm2        # 402140 <__dso_handle+0x138>
  40142b:	00 
  40142c:	0f 85 56 ff ff ff    	jne    401388 <ss_stride_vec+0x58>
  end_t = get_wall_time();
  401432:	31 c0                	xor    %eax,%eax
  401434:	c5 f8 77             	vzeroupper 
  401437:	e8 84 fd ff ff       	call   4011c0 <get_wall_time>
  results(end_t - start_t, "ss_stride_vec");
  40143c:	c5 fb 5c 45 e8       	vsubsd -0x18(%rbp),%xmm0,%xmm0
  401441:	bf 3d 20 40 00       	mov    $0x40203d,%edi
  401446:	e8 15 fe ff ff       	call   401260 <results>
  check(x);
  40144b:	bf 80 40 40 00       	mov    $0x404080,%edi
  401450:	e8 ab fd ff ff       	call   401200 <check>
}
  401455:	48 83 c4 20          	add    $0x20,%rsp
  401459:	31 c0                	xor    %eax,%eax
  40145b:	5b                   	pop    %rbx
  40145c:	41 5a                	pop    %r10
  40145e:	5d                   	pop    %rbp
  40145f:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  401463:	c3                   	ret    
  401464:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40146b:	00 00 00 
  40146e:	66 90                	xchg   %ax,%ax

0000000000401470 <__libc_csu_init>:
  401470:	f3 0f 1e fa          	endbr64 
  401474:	41 57                	push   %r15
  401476:	49 89 d7             	mov    %rdx,%r15
  401479:	41 56                	push   %r14
  40147b:	49 89 f6             	mov    %rsi,%r14
  40147e:	41 55                	push   %r13
  401480:	41 89 fd             	mov    %edi,%r13d
  401483:	41 54                	push   %r12
  401485:	4c 8d 25 5c 29 00 00 	lea    0x295c(%rip),%r12        # 403de8 <__frame_dummy_init_array_entry>
  40148c:	55                   	push   %rbp
  40148d:	48 8d 2d 64 29 00 00 	lea    0x2964(%rip),%rbp        # 403df8 <__do_global_dtors_aux_fini_array_entry>
  401494:	53                   	push   %rbx
  401495:	4c 29 e5             	sub    %r12,%rbp
  401498:	48 83 ec 08          	sub    $0x8,%rsp
  40149c:	e8 5f fb ff ff       	call   401000 <_init>
  4014a1:	48 c1 fd 03          	sar    $0x3,%rbp
  4014a5:	74 1f                	je     4014c6 <__libc_csu_init+0x56>
  4014a7:	31 db                	xor    %ebx,%ebx
  4014a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  4014b0:	4c 89 fa             	mov    %r15,%rdx
  4014b3:	4c 89 f6             	mov    %r14,%rsi
  4014b6:	44 89 ef             	mov    %r13d,%edi
  4014b9:	41 ff 14 dc          	call   *(%r12,%rbx,8)
  4014bd:	48 83 c3 01          	add    $0x1,%rbx
  4014c1:	48 39 dd             	cmp    %rbx,%rbp
  4014c4:	75 ea                	jne    4014b0 <__libc_csu_init+0x40>
  4014c6:	48 83 c4 08          	add    $0x8,%rsp
  4014ca:	5b                   	pop    %rbx
  4014cb:	5d                   	pop    %rbp
  4014cc:	41 5c                	pop    %r12
  4014ce:	41 5d                	pop    %r13
  4014d0:	41 5e                	pop    %r14
  4014d2:	41 5f                	pop    %r15
  4014d4:	c3                   	ret    

00000000004014d5 <.annobin___libc_csu_fini.start>:
  4014d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4014dc:	00 00 00 00 

00000000004014e0 <__libc_csu_fini>:
  4014e0:	f3 0f 1e fa          	endbr64 
  4014e4:	c3                   	ret    

Disassembly of section .fini:

00000000004014e8 <_fini>:
  4014e8:	f3 0f 1e fa          	endbr64 
  4014ec:	48 83 ec 08          	sub    $0x8,%rsp
  4014f0:	48 83 c4 08          	add    $0x8,%rsp
  4014f4:	c3                   	ret    
