
ss_alias.1k.single.avx2.gcc:     file format elf64-x86-64


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
  check(y);
  return 0;
}

int main()
{
  401070:	48 83 ec 08          	sub    $0x8,%rsp
  //x = aligned_alloc(SIMD_ALIGN, (LEN+1)*sizeof(real));
  //y = aligned_alloc(SIMD_ALIGN, (LEN+1)*sizeof(real));
    
  /* y[] = alpha*x[] + beta */

  printf("                     Time       TPE\n");
  401074:	bf 70 20 40 00       	mov    $0x402070,%edi
  401079:	e8 b2 ff ff ff       	call   401030 <puts@plt>
  printf("             Loop     ns       ps/el     Checksum\n");
  40107e:	bf 98 20 40 00       	mov    $0x402098,%edi
  401083:	e8 a8 ff ff ff       	call   401030 <puts@plt>

  ss_alias_v1(&y[1], y);      /* solapamiento y dependencia */
  401088:	be 80 40 40 00       	mov    $0x404080,%esi
  40108d:	bf 84 40 40 00       	mov    $0x404084,%edi
  401092:	e8 69 02 00 00       	call   401300 <ss_alias_v1>
  ss_alias_v1(y, &y[1]);      /* solapamiento, no dependencia */
  401097:	be 84 40 40 00       	mov    $0x404084,%esi
  40109c:	bf 80 40 40 00       	mov    $0x404080,%edi
  4010a1:	e8 5a 02 00 00       	call   401300 <ss_alias_v1>
  ss_alias_v1(y, y);          /* solapamiento, no dependencia */
  4010a6:	be 80 40 40 00       	mov    $0x404080,%esi
  4010ab:	48 89 f7             	mov    %rsi,%rdi
  4010ae:	e8 4d 02 00 00       	call   401300 <ss_alias_v1>
  ss_alias_v1(y, x);          /* no solapamiento, no dependencia */
  4010b3:	be c0 50 40 00       	mov    $0x4050c0,%esi
  4010b8:	bf 80 40 40 00       	mov    $0x404080,%edi
  4010bd:	e8 3e 02 00 00       	call   401300 <ss_alias_v1>

  /* restrict en parametros */
  ss_alias_v2(&y[1], &x[1]);    /* no solapamiento, no dependencia */
  4010c2:	be c4 50 40 00       	mov    $0x4050c4,%esi
  4010c7:	bf 84 40 40 00       	mov    $0x404084,%edi
  4010cc:	e8 7f 03 00 00       	call   401450 <ss_alias_v2>
  ss_alias_v2(y, x);            /* no solapamiento, no dependencia */
  4010d1:	be c0 50 40 00       	mov    $0x4050c0,%esi
  4010d6:	bf 80 40 40 00       	mov    $0x404080,%edi
  4010db:	e8 70 03 00 00       	call   401450 <ss_alias_v2>

  /* #pragma GCC ivdep */
  ss_alias_v3(&y[1], &x[1]);    /* no solapamiento, no dependencia */
  4010e0:	be c4 50 40 00       	mov    $0x4050c4,%esi
  4010e5:	bf 84 40 40 00       	mov    $0x404084,%edi
  4010ea:	e8 41 04 00 00       	call   401530 <ss_alias_v3>
  ss_alias_v3(y, x);            /* no solapamiento, no dependencia */
  4010ef:	be c0 50 40 00       	mov    $0x4050c0,%esi
  4010f4:	bf 80 40 40 00       	mov    $0x404080,%edi
  4010f9:	e8 32 04 00 00       	call   401530 <ss_alias_v3>

  /* restrict en parametros + __builtin_assume_aligned() */
  ss_alias_v4(y, x);             /* no solapamiento, no dependencia */
  4010fe:	be c0 50 40 00       	mov    $0x4050c0,%esi
  401103:	bf 80 40 40 00       	mov    $0x404080,%edi
  401108:	e8 03 05 00 00       	call   401610 <ss_alias_v4>

  /* scale_and_shift variables globales */
  scale_and_shift();                             /* solapamiento, no dependencia */
  40110d:	31 c0                	xor    %eax,%eax
  40110f:	e8 dc 05 00 00       	call   4016f0 <scale_and_shift>

  return 0;
}
  401114:	31 c0                	xor    %eax,%eax
  401116:	48 83 c4 08          	add    $0x8,%rsp
  40111a:	c3                   	ret    

000000000040111b <.annobin_elf_init.c.hot>:
  40111b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000401120 <_start>:
  401120:	f3 0f 1e fa          	endbr64 
  401124:	31 ed                	xor    %ebp,%ebp
  401126:	49 89 d1             	mov    %rdx,%r9
  401129:	5e                   	pop    %rsi
  40112a:	48 89 e2             	mov    %rsp,%rdx
  40112d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  401131:	50                   	push   %rax
  401132:	54                   	push   %rsp
  401133:	49 c7 c0 40 18 40 00 	mov    $0x401840,%r8
  40113a:	48 c7 c1 d0 17 40 00 	mov    $0x4017d0,%rcx
  401141:	48 c7 c7 70 10 40 00 	mov    $0x401070,%rdi
  401148:	ff 15 9a 2e 00 00    	call   *0x2e9a(%rip)        # 403fe8 <__libc_start_main@GLIBC_2.2.5>
  40114e:	f4                   	hlt    

000000000040114f <.annobin_init.c>:
  40114f:	90                   	nop

0000000000401150 <_dl_relocate_static_pie>:
  401150:	f3 0f 1e fa          	endbr64 
  401154:	c3                   	ret    

0000000000401155 <.annobin__dl_relocate_static_pie.end>:
  401155:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40115c:	00 00 00 
  40115f:	90                   	nop

0000000000401160 <deregister_tm_clones>:
  401160:	48 8d 3d d9 2e 00 00 	lea    0x2ed9(%rip),%rdi        # 404040 <__TMC_END__>
  401167:	48 8d 05 d2 2e 00 00 	lea    0x2ed2(%rip),%rax        # 404040 <__TMC_END__>
  40116e:	48 39 f8             	cmp    %rdi,%rax
  401171:	74 15                	je     401188 <deregister_tm_clones+0x28>
  401173:	48 8b 05 66 2e 00 00 	mov    0x2e66(%rip),%rax        # 403fe0 <_ITM_deregisterTMCloneTable@Base>
  40117a:	48 85 c0             	test   %rax,%rax
  40117d:	74 09                	je     401188 <deregister_tm_clones+0x28>
  40117f:	ff e0                	jmp    *%rax
  401181:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401188:	c3                   	ret    
  401189:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000401190 <register_tm_clones>:
  401190:	48 8d 3d a9 2e 00 00 	lea    0x2ea9(%rip),%rdi        # 404040 <__TMC_END__>
  401197:	48 8d 35 a2 2e 00 00 	lea    0x2ea2(%rip),%rsi        # 404040 <__TMC_END__>
  40119e:	48 29 fe             	sub    %rdi,%rsi
  4011a1:	48 89 f0             	mov    %rsi,%rax
  4011a4:	48 c1 ee 3f          	shr    $0x3f,%rsi
  4011a8:	48 c1 f8 03          	sar    $0x3,%rax
  4011ac:	48 01 c6             	add    %rax,%rsi
  4011af:	48 d1 fe             	sar    %rsi
  4011b2:	74 14                	je     4011c8 <register_tm_clones+0x38>
  4011b4:	48 8b 05 3d 2e 00 00 	mov    0x2e3d(%rip),%rax        # 403ff8 <_ITM_registerTMCloneTable@Base>
  4011bb:	48 85 c0             	test   %rax,%rax
  4011be:	74 08                	je     4011c8 <register_tm_clones+0x38>
  4011c0:	ff e0                	jmp    *%rax
  4011c2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  4011c8:	c3                   	ret    
  4011c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000004011d0 <__do_global_dtors_aux>:
  4011d0:	f3 0f 1e fa          	endbr64 
  4011d4:	80 3d 65 2e 00 00 00 	cmpb   $0x0,0x2e65(%rip)        # 404040 <__TMC_END__>
  4011db:	75 13                	jne    4011f0 <__do_global_dtors_aux+0x20>
  4011dd:	55                   	push   %rbp
  4011de:	48 89 e5             	mov    %rsp,%rbp
  4011e1:	e8 7a ff ff ff       	call   401160 <deregister_tm_clones>
  4011e6:	c6 05 53 2e 00 00 01 	movb   $0x1,0x2e53(%rip)        # 404040 <__TMC_END__>
  4011ed:	5d                   	pop    %rbp
  4011ee:	c3                   	ret    
  4011ef:	90                   	nop
  4011f0:	c3                   	ret    
  4011f1:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4011f8:	00 00 00 00 
  4011fc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401200 <frame_dummy>:
  401200:	f3 0f 1e fa          	endbr64 
  401204:	eb 8a                	jmp    401190 <register_tm_clones>

0000000000401206 <dummy>:
  401206:	55                   	push   %rbp
  401207:	48 89 e5             	mov    %rsp,%rbp
  40120a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  40120e:	f3 0f 11 45 f4       	movss  %xmm0,-0xc(%rbp)
  401213:	f3 0f 11 4d f0       	movss  %xmm1,-0x10(%rbp)
  401218:	b8 00 00 00 00       	mov    $0x0,%eax
  40121d:	5d                   	pop    %rbp
  40121e:	c3                   	ret    
  40121f:	90                   	nop

0000000000401220 <get_wall_time>:
{
  401220:	48 83 ec 18          	sub    $0x18,%rsp
    if (gettimeofday(&time,NULL)) {
  401224:	31 f6                	xor    %esi,%esi
  401226:	48 89 e7             	mov    %rsp,%rdi
  401229:	e8 22 fe ff ff       	call   401050 <gettimeofday@plt>
  40122e:	85 c0                	test   %eax,%eax
  401230:	75 22                	jne    401254 <get_wall_time+0x34>
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  401232:	c5 f0 57 c9          	vxorps %xmm1,%xmm1,%xmm1
  401236:	c4 e1 f3 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm1,%xmm0
  40123d:	c5 fb 59 05 8b 0e 00 	vmulsd 0xe8b(%rip),%xmm0,%xmm0        # 4020d0 <__dso_handle+0xc8>
  401244:	00 
  401245:	c4 e1 f3 2a 0c 24    	vcvtsi2sdq (%rsp),%xmm1,%xmm1
}
  40124b:	48 83 c4 18          	add    $0x18,%rsp
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  40124f:	c5 fb 58 c1          	vaddsd %xmm1,%xmm0,%xmm0
}
  401253:	c3                   	ret    
        exit(-1); // return 0;
  401254:	83 cf ff             	or     $0xffffffff,%edi
  401257:	e8 04 fe ff ff       	call   401060 <exit@plt>
  40125c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401260 <check>:
  for (unsigned int i = 0; i < LEN; i++)
  401260:	48 8d 87 00 10 00 00 	lea    0x1000(%rdi),%rax
  real sum = 0;
  401267:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  40126b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    sum += arr[i];
  401270:	c5 fa 58 07          	vaddss (%rdi),%xmm0,%xmm0
  for (unsigned int i = 0; i < LEN; i++)
  401274:	48 83 c7 04          	add    $0x4,%rdi
  401278:	48 39 f8             	cmp    %rdi,%rax
  40127b:	75 f3                	jne    401270 <check+0x10>
  printf("%f \n", sum);
  40127d:	bf 10 20 40 00       	mov    $0x402010,%edi
  401282:	b8 01 00 00 00       	mov    $0x1,%eax
  401287:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40128b:	e9 b0 fd ff ff       	jmp    401040 <printf@plt>

0000000000401290 <init>:
    for (unsigned int j = 0; j < LEN+1; j++)
  401290:	c5 fa 10 0d 50 0e 00 	vmovss 0xe50(%rip),%xmm1        # 4020e8 <__dso_handle+0xe0>
  401297:	00 
  401298:	c5 fa 10 05 4c 0e 00 	vmovss 0xe4c(%rip),%xmm0        # 4020ec <__dso_handle+0xe4>
  40129f:	00 
{
  4012a0:	31 c0                	xor    %eax,%eax
  4012a2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
        vx[j] = 2.0;
  4012a8:	c5 fa 11 0c 07       	vmovss %xmm1,(%rdi,%rax,1)
        vy[j] = 1.0;
  4012ad:	c5 fa 11 04 06       	vmovss %xmm0,(%rsi,%rax,1)
    for (unsigned int j = 0; j < LEN+1; j++)
  4012b2:	48 83 c0 04          	add    $0x4,%rax
  4012b6:	48 3d 04 10 00 00    	cmp    $0x1004,%rax
  4012bc:	75 ea                	jne    4012a8 <init+0x18>
}
  4012be:	31 c0                	xor    %eax,%eax
  4012c0:	c3                   	ret    
  4012c1:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4012c8:	00 00 00 00 
  4012cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004012d0 <results>:
{
  4012d0:	48 89 fe             	mov    %rdi,%rsi
    printf("%18s  %6.1f    %6.1f     ",
  4012d3:	b8 02 00 00 00       	mov    $0x2,%eax
  4012d8:	bf 15 20 40 00       	mov    $0x402015,%edi
  4012dd:	c5 fb 5e 15 fb 0d 00 	vdivsd 0xdfb(%rip),%xmm0,%xmm2        # 4020e0 <__dso_handle+0xd8>
  4012e4:	00 
  4012e5:	c5 fb 5e 0d eb 0d 00 	vdivsd 0xdeb(%rip),%xmm0,%xmm1        # 4020d8 <__dso_handle+0xd0>
  4012ec:	00 
  4012ed:	c5 eb 10 c2          	vmovsd %xmm2,%xmm2,%xmm0
  4012f1:	e9 4a fd ff ff       	jmp    401040 <printf@plt>
  4012f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4012fd:	00 00 00 

0000000000401300 <ss_alias_v1>:
{
  401300:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  401305:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  401309:	41 ff 72 f8          	push   -0x8(%r10)
  40130d:	55                   	push   %rbp
  40130e:	48 89 e5             	mov    %rsp,%rbp
  401311:	41 55                	push   %r13
  start_t = get_wall_time();
  401313:	41 bd 00 00 f0 00    	mov    $0xf00000,%r13d
{
  401319:	41 54                	push   %r12
  40131b:	49 89 f4             	mov    %rsi,%r12
  init(vx, vy);
  40131e:	48 89 fe             	mov    %rdi,%rsi
{
  401321:	41 52                	push   %r10
  401323:	53                   	push   %rbx
  401324:	48 89 fb             	mov    %rdi,%rbx
  init(vx, vy);
  401327:	4c 89 e7             	mov    %r12,%rdi
{
  40132a:	48 83 ec 30          	sub    $0x30,%rsp
  init(vx, vy);
  40132e:	e8 5d ff ff ff       	call   401290 <init>
  start_t = get_wall_time();
  401333:	31 c0                	xor    %eax,%eax
  401335:	e8 e6 fe ff ff       	call   401220 <get_wall_time>
  40133a:	49 8d 54 24 04       	lea    0x4(%r12),%rdx
  40133f:	48 89 d8             	mov    %rbx,%rax
  401342:	c5 fa 10 15 b6 0d 00 	vmovss 0xdb6(%rip),%xmm2        # 402100 <__dso_handle+0xf8>
  401349:	00 
  40134a:	48 29 d0             	sub    %rdx,%rax
  40134d:	c5 fa 10 0d cb 0d 00 	vmovss 0xdcb(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  401354:	00 
  401355:	c5 fb 11 45 c0       	vmovsd %xmm0,-0x40(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40135a:	48 83 f8 18          	cmp    $0x18,%rax
  40135e:	0f 86 c6 00 00 00    	jbe    40142a <ss_alias_v1+0x12a>
  401364:	c4 e2 7d 18 25 93 0d 	vbroadcastss 0xd93(%rip),%ymm4        # 402100 <__dso_handle+0xf8>
  40136b:	00 00 
  40136d:	c5 fa 10 15 8b 0d 00 	vmovss 0xd8b(%rip),%xmm2        # 402100 <__dso_handle+0xf8>
  401374:	00 
  401375:	c4 e2 7d 18 1d a2 0d 	vbroadcastss 0xda2(%rip),%ymm3        # 402120 <__dso_handle+0x118>
  40137c:	00 00 
{
  40137e:	31 c0                	xor    %eax,%eax
        vy[i] = alpha*vx[i] + beta;
  401380:	c4 c1 5c 59 04 04    	vmulps (%r12,%rax,1),%ymm4,%ymm0
  401386:	c5 fc 58 c3          	vaddps %ymm3,%ymm0,%ymm0
  40138a:	c5 fc 11 04 03       	vmovups %ymm0,(%rbx,%rax,1)
    for (unsigned int i = 0; i < LEN; i++)
  40138f:	48 83 c0 20          	add    $0x20,%rax
  401393:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  401399:	75 e5                	jne    401380 <ss_alias_v1+0x80>
    dummy(vy, alpha, beta);
  40139b:	c5 fa 10 0d 7d 0d 00 	vmovss 0xd7d(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  4013a2:	00 
  4013a3:	c5 f8 28 c2          	vmovaps %xmm2,%xmm0
  4013a7:	c5 fa 11 55 cc       	vmovss %xmm2,-0x34(%rbp)
  4013ac:	48 89 df             	mov    %rbx,%rdi
  4013af:	c5 f8 77             	vzeroupper 
  4013b2:	e8 4f fe ff ff       	call   401206 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4013b7:	41 83 ed 01          	sub    $0x1,%r13d
  4013bb:	c5 fa 10 55 cc       	vmovss -0x34(%rbp),%xmm2
  4013c0:	c5 fc 28 25 38 0d 00 	vmovaps 0xd38(%rip),%ymm4        # 402100 <__dso_handle+0xf8>
  4013c7:	00 
  4013c8:	c5 fc 28 1d 50 0d 00 	vmovaps 0xd50(%rip),%ymm3        # 402120 <__dso_handle+0x118>
  4013cf:	00 
  4013d0:	75 ac                	jne    40137e <ss_alias_v1+0x7e>
  4013d2:	c5 f8 77             	vzeroupper 
  end_t = get_wall_time();
  4013d5:	31 c0                	xor    %eax,%eax
  4013d7:	e8 44 fe ff ff       	call   401220 <get_wall_time>
  results(end_t - start_t, "ss_alias_v1");
  4013dc:	c5 fb 5c 45 c0       	vsubsd -0x40(%rbp),%xmm0,%xmm0
  4013e1:	bf 2f 20 40 00       	mov    $0x40202f,%edi
  4013e6:	e8 e5 fe ff ff       	call   4012d0 <results>
  check(vy);
  4013eb:	48 89 df             	mov    %rbx,%rdi
  4013ee:	e8 6d fe ff ff       	call   401260 <check>
}
  4013f3:	48 83 c4 30          	add    $0x30,%rsp
  4013f7:	31 c0                	xor    %eax,%eax
  4013f9:	5b                   	pop    %rbx
  4013fa:	41 5a                	pop    %r10
  4013fc:	41 5c                	pop    %r12
  4013fe:	41 5d                	pop    %r13
  401400:	5d                   	pop    %rbp
  401401:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  401405:	c3                   	ret    
    dummy(vy, alpha, beta);
  401406:	c5 f8 28 c2          	vmovaps %xmm2,%xmm0
  40140a:	48 89 df             	mov    %rbx,%rdi
  40140d:	c5 fa 11 55 cc       	vmovss %xmm2,-0x34(%rbp)
  401412:	e8 ef fd ff ff       	call   401206 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  401417:	41 83 ed 01          	sub    $0x1,%r13d
  40141b:	c5 fa 10 55 cc       	vmovss -0x34(%rbp),%xmm2
  401420:	c5 fa 10 0d f8 0c 00 	vmovss 0xcf8(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  401427:	00 
  401428:	74 ab                	je     4013d5 <ss_alias_v1+0xd5>
  start_t = get_wall_time();
  40142a:	31 c0                	xor    %eax,%eax
  40142c:	0f 1f 40 00          	nopl   0x0(%rax)
        vy[i] = alpha*vx[i] + beta;
  401430:	c4 c1 6a 59 04 04    	vmulss (%r12,%rax,1),%xmm2,%xmm0
  401436:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  40143a:	c5 fa 11 04 03       	vmovss %xmm0,(%rbx,%rax,1)
    for (unsigned int i = 0; i < LEN; i++)
  40143f:	48 83 c0 04          	add    $0x4,%rax
  401443:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  401449:	75 e5                	jne    401430 <ss_alias_v1+0x130>
  40144b:	eb b9                	jmp    401406 <ss_alias_v1+0x106>
  40144d:	0f 1f 00             	nopl   (%rax)

0000000000401450 <ss_alias_v2>:
{
  401450:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  401455:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  401459:	41 ff 72 f8          	push   -0x8(%r10)
  40145d:	55                   	push   %rbp
  40145e:	48 89 e5             	mov    %rsp,%rbp
  401461:	41 55                	push   %r13
  start_t = get_wall_time();
  401463:	41 bd 00 00 f0 00    	mov    $0xf00000,%r13d
{
  401469:	41 54                	push   %r12
  40146b:	49 89 f4             	mov    %rsi,%r12
  init(vx, vy);
  40146e:	48 89 fe             	mov    %rdi,%rsi
{
  401471:	41 52                	push   %r10
  401473:	53                   	push   %rbx
  401474:	48 89 fb             	mov    %rdi,%rbx
  init(vx, vy);
  401477:	4c 89 e7             	mov    %r12,%rdi
{
  40147a:	48 83 ec 30          	sub    $0x30,%rsp
  init(vx, vy);
  40147e:	e8 0d fe ff ff       	call   401290 <init>
  start_t = get_wall_time();
  401483:	31 c0                	xor    %eax,%eax
  401485:	e8 96 fd ff ff       	call   401220 <get_wall_time>
  40148a:	c4 e2 7d 18 1d 6d 0c 	vbroadcastss 0xc6d(%rip),%ymm3        # 402100 <__dso_handle+0xf8>
  401491:	00 00 
  401493:	c4 e2 7d 18 15 84 0c 	vbroadcastss 0xc84(%rip),%ymm2        # 402120 <__dso_handle+0x118>
  40149a:	00 00 
  40149c:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4014a1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
{
  4014a8:	31 c0                	xor    %eax,%eax
  4014aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
        vy[i] = alpha*vx[i] + beta;
  4014b0:	c4 c1 64 59 04 04    	vmulps (%r12,%rax,1),%ymm3,%ymm0
  4014b6:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  4014ba:	c5 fc 11 04 03       	vmovups %ymm0,(%rbx,%rax,1)
    for (unsigned int i = 0; i < LEN; i++)
  4014bf:	48 83 c0 20          	add    $0x20,%rax
  4014c3:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  4014c9:	75 e5                	jne    4014b0 <ss_alias_v2+0x60>
    dummy(vy, alpha, beta);
  4014cb:	c5 fa 10 0d 4d 0c 00 	vmovss 0xc4d(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  4014d2:	00 
  4014d3:	c5 fa 10 05 25 0c 00 	vmovss 0xc25(%rip),%xmm0        # 402100 <__dso_handle+0xf8>
  4014da:	00 
  4014db:	48 89 df             	mov    %rbx,%rdi
  4014de:	c5 f8 77             	vzeroupper 
  4014e1:	e8 20 fd ff ff       	call   401206 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4014e6:	41 83 ed 01          	sub    $0x1,%r13d
  4014ea:	c5 fc 28 15 2e 0c 00 	vmovaps 0xc2e(%rip),%ymm2        # 402120 <__dso_handle+0x118>
  4014f1:	00 
  4014f2:	c5 fc 28 1d 06 0c 00 	vmovaps 0xc06(%rip),%ymm3        # 402100 <__dso_handle+0xf8>
  4014f9:	00 
  4014fa:	75 ac                	jne    4014a8 <ss_alias_v2+0x58>
  end_t = get_wall_time();
  4014fc:	31 c0                	xor    %eax,%eax
  4014fe:	c5 f8 77             	vzeroupper 
  401501:	e8 1a fd ff ff       	call   401220 <get_wall_time>
  results(end_t - start_t, "ss_alias_v2");
  401506:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  40150b:	bf 3b 20 40 00       	mov    $0x40203b,%edi
  401510:	e8 bb fd ff ff       	call   4012d0 <results>
  check(vy);
  401515:	48 89 df             	mov    %rbx,%rdi
  401518:	e8 43 fd ff ff       	call   401260 <check>
}
  40151d:	48 83 c4 30          	add    $0x30,%rsp
  401521:	31 c0                	xor    %eax,%eax
  401523:	5b                   	pop    %rbx
  401524:	41 5a                	pop    %r10
  401526:	41 5c                	pop    %r12
  401528:	41 5d                	pop    %r13
  40152a:	5d                   	pop    %rbp
  40152b:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  40152f:	c3                   	ret    

0000000000401530 <ss_alias_v3>:
{
  401530:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  401535:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  401539:	41 ff 72 f8          	push   -0x8(%r10)
  40153d:	55                   	push   %rbp
  40153e:	48 89 e5             	mov    %rsp,%rbp
  401541:	41 55                	push   %r13
  start_t = get_wall_time();
  401543:	41 bd 00 00 f0 00    	mov    $0xf00000,%r13d
{
  401549:	41 54                	push   %r12
  40154b:	49 89 f4             	mov    %rsi,%r12
  init(vx, vy);
  40154e:	48 89 fe             	mov    %rdi,%rsi
{
  401551:	41 52                	push   %r10
  401553:	53                   	push   %rbx
  401554:	48 89 fb             	mov    %rdi,%rbx
  init(vx, vy);
  401557:	4c 89 e7             	mov    %r12,%rdi
{
  40155a:	48 83 ec 30          	sub    $0x30,%rsp
  init(vx, vy);
  40155e:	e8 2d fd ff ff       	call   401290 <init>
  start_t = get_wall_time();
  401563:	31 c0                	xor    %eax,%eax
  401565:	e8 b6 fc ff ff       	call   401220 <get_wall_time>
  40156a:	c4 e2 7d 18 1d 8d 0b 	vbroadcastss 0xb8d(%rip),%ymm3        # 402100 <__dso_handle+0xf8>
  401571:	00 00 
  401573:	c4 e2 7d 18 15 a4 0b 	vbroadcastss 0xba4(%rip),%ymm2        # 402120 <__dso_handle+0x118>
  40157a:	00 00 
  40157c:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  401581:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
{
  401588:	31 c0                	xor    %eax,%eax
  40158a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
      vy[i] = alpha*vx[i] + beta;
  401590:	c4 c1 64 59 04 04    	vmulps (%r12,%rax,1),%ymm3,%ymm0
  401596:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  40159a:	c5 fc 11 04 03       	vmovups %ymm0,(%rbx,%rax,1)
    for (unsigned int i = 0; i < LEN; i++)
  40159f:	48 83 c0 20          	add    $0x20,%rax
  4015a3:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  4015a9:	75 e5                	jne    401590 <ss_alias_v3+0x60>
    dummy(vy, alpha, beta);
  4015ab:	c5 fa 10 0d 6d 0b 00 	vmovss 0xb6d(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  4015b2:	00 
  4015b3:	c5 fa 10 05 45 0b 00 	vmovss 0xb45(%rip),%xmm0        # 402100 <__dso_handle+0xf8>
  4015ba:	00 
  4015bb:	48 89 df             	mov    %rbx,%rdi
  4015be:	c5 f8 77             	vzeroupper 
  4015c1:	e8 40 fc ff ff       	call   401206 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4015c6:	41 83 ed 01          	sub    $0x1,%r13d
  4015ca:	c5 fc 28 15 4e 0b 00 	vmovaps 0xb4e(%rip),%ymm2        # 402120 <__dso_handle+0x118>
  4015d1:	00 
  4015d2:	c5 fc 28 1d 26 0b 00 	vmovaps 0xb26(%rip),%ymm3        # 402100 <__dso_handle+0xf8>
  4015d9:	00 
  4015da:	75 ac                	jne    401588 <ss_alias_v3+0x58>
  end_t = get_wall_time();
  4015dc:	31 c0                	xor    %eax,%eax
  4015de:	c5 f8 77             	vzeroupper 
  4015e1:	e8 3a fc ff ff       	call   401220 <get_wall_time>
  results(end_t - start_t, "ss_alias_v3");
  4015e6:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  4015eb:	bf 47 20 40 00       	mov    $0x402047,%edi
  4015f0:	e8 db fc ff ff       	call   4012d0 <results>
  check(vy);
  4015f5:	48 89 df             	mov    %rbx,%rdi
  4015f8:	e8 63 fc ff ff       	call   401260 <check>
}
  4015fd:	48 83 c4 30          	add    $0x30,%rsp
  401601:	31 c0                	xor    %eax,%eax
  401603:	5b                   	pop    %rbx
  401604:	41 5a                	pop    %r10
  401606:	41 5c                	pop    %r12
  401608:	41 5d                	pop    %r13
  40160a:	5d                   	pop    %rbp
  40160b:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  40160f:	c3                   	ret    

0000000000401610 <ss_alias_v4>:
{
  401610:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  401615:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  401619:	41 ff 72 f8          	push   -0x8(%r10)
  40161d:	55                   	push   %rbp
  40161e:	48 89 e5             	mov    %rsp,%rbp
  401621:	41 55                	push   %r13
  start_t = get_wall_time();
  401623:	41 bd 00 00 f0 00    	mov    $0xf00000,%r13d
{
  401629:	41 54                	push   %r12
  40162b:	49 89 f4             	mov    %rsi,%r12
  init(xx, yy);
  40162e:	48 89 fe             	mov    %rdi,%rsi
{
  401631:	41 52                	push   %r10
  401633:	53                   	push   %rbx
  401634:	48 89 fb             	mov    %rdi,%rbx
  init(xx, yy);
  401637:	4c 89 e7             	mov    %r12,%rdi
{
  40163a:	48 83 ec 30          	sub    $0x30,%rsp
  init(xx, yy);
  40163e:	e8 4d fc ff ff       	call   401290 <init>
  start_t = get_wall_time();
  401643:	31 c0                	xor    %eax,%eax
  401645:	e8 d6 fb ff ff       	call   401220 <get_wall_time>
  40164a:	c4 e2 7d 18 1d ad 0a 	vbroadcastss 0xaad(%rip),%ymm3        # 402100 <__dso_handle+0xf8>
  401651:	00 00 
  401653:	c4 e2 7d 18 15 c4 0a 	vbroadcastss 0xac4(%rip),%ymm2        # 402120 <__dso_handle+0x118>
  40165a:	00 00 
  40165c:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  401661:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
{
  401668:	31 c0                	xor    %eax,%eax
  40166a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
      yy[i] = alpha*xx[i] + beta;
  401670:	c4 c1 64 59 04 04    	vmulps (%r12,%rax,1),%ymm3,%ymm0
  401676:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  40167a:	c5 fc 29 04 03       	vmovaps %ymm0,(%rbx,%rax,1)
    for (unsigned int i = 0; i < LEN; i++)
  40167f:	48 83 c0 20          	add    $0x20,%rax
  401683:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  401689:	75 e5                	jne    401670 <ss_alias_v4+0x60>
    dummy(yy, alpha, beta);
  40168b:	c5 fa 10 0d 8d 0a 00 	vmovss 0xa8d(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  401692:	00 
  401693:	c5 fa 10 05 65 0a 00 	vmovss 0xa65(%rip),%xmm0        # 402100 <__dso_handle+0xf8>
  40169a:	00 
  40169b:	48 89 df             	mov    %rbx,%rdi
  40169e:	c5 f8 77             	vzeroupper 
  4016a1:	e8 60 fb ff ff       	call   401206 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4016a6:	41 83 ed 01          	sub    $0x1,%r13d
  4016aa:	c5 fc 28 15 6e 0a 00 	vmovaps 0xa6e(%rip),%ymm2        # 402120 <__dso_handle+0x118>
  4016b1:	00 
  4016b2:	c5 fc 28 1d 46 0a 00 	vmovaps 0xa46(%rip),%ymm3        # 402100 <__dso_handle+0xf8>
  4016b9:	00 
  4016ba:	75 ac                	jne    401668 <ss_alias_v4+0x58>
  end_t = get_wall_time();
  4016bc:	31 c0                	xor    %eax,%eax
  4016be:	c5 f8 77             	vzeroupper 
  4016c1:	e8 5a fb ff ff       	call   401220 <get_wall_time>
  results(end_t - start_t, "ss_alias_v4");
  4016c6:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  4016cb:	bf 53 20 40 00       	mov    $0x402053,%edi
  4016d0:	e8 fb fb ff ff       	call   4012d0 <results>
  check(yy);
  4016d5:	48 89 df             	mov    %rbx,%rdi
  4016d8:	e8 83 fb ff ff       	call   401260 <check>
}
  4016dd:	48 83 c4 30          	add    $0x30,%rsp
  4016e1:	31 c0                	xor    %eax,%eax
  4016e3:	5b                   	pop    %rbx
  4016e4:	41 5a                	pop    %r10
  4016e6:	41 5c                	pop    %r12
  4016e8:	41 5d                	pop    %r13
  4016ea:	5d                   	pop    %rbp
  4016eb:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  4016ef:	c3                   	ret    

00000000004016f0 <scale_and_shift>:
{
  4016f0:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  4016f5:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init(x, y);
  4016f9:	be 80 40 40 00       	mov    $0x404080,%esi
  4016fe:	bf c0 50 40 00       	mov    $0x4050c0,%edi
{
  401703:	41 ff 72 f8          	push   -0x8(%r10)
  401707:	55                   	push   %rbp
  401708:	48 89 e5             	mov    %rsp,%rbp
  40170b:	41 52                	push   %r10
  40170d:	53                   	push   %rbx
  start_t = get_wall_time();
  40170e:	bb 00 00 f0 00       	mov    $0xf00000,%ebx
{
  401713:	48 83 ec 20          	sub    $0x20,%rsp
  init(x, y);
  401717:	e8 74 fb ff ff       	call   401290 <init>
  start_t = get_wall_time();
  40171c:	31 c0                	xor    %eax,%eax
  40171e:	e8 fd fa ff ff       	call   401220 <get_wall_time>
  401723:	c4 e2 7d 18 1d d4 09 	vbroadcastss 0x9d4(%rip),%ymm3        # 402100 <__dso_handle+0xf8>
  40172a:	00 00 
  40172c:	c4 e2 7d 18 15 eb 09 	vbroadcastss 0x9eb(%rip),%ymm2        # 402120 <__dso_handle+0x118>
  401733:	00 00 
  401735:	c5 fb 11 45 e8       	vmovsd %xmm0,-0x18(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40173a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
{
  401740:	31 c0                	xor    %eax,%eax
  401742:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
      y[i] = alpha*x[i] + beta;
  401748:	c5 e4 59 80 c0 50 40 	vmulps 0x4050c0(%rax),%ymm3,%ymm0
  40174f:	00 
  401750:	48 83 c0 20          	add    $0x20,%rax
  401754:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  401758:	c5 fc 29 80 60 40 40 	vmovaps %ymm0,0x404060(%rax)
  40175f:	00 
    for (unsigned int i = 0; i < LEN; i++)
  401760:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  401766:	75 e0                	jne    401748 <scale_and_shift+0x58>
        dummy(y, alpha, beta);
  401768:	c5 fa 10 0d b0 09 00 	vmovss 0x9b0(%rip),%xmm1        # 402120 <__dso_handle+0x118>
  40176f:	00 
  401770:	c5 fa 10 05 88 09 00 	vmovss 0x988(%rip),%xmm0        # 402100 <__dso_handle+0xf8>
  401777:	00 
  401778:	bf 80 40 40 00       	mov    $0x404080,%edi
  40177d:	c5 f8 77             	vzeroupper 
  401780:	e8 81 fa ff ff       	call   401206 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  401785:	83 eb 01             	sub    $0x1,%ebx
  401788:	c5 fc 28 15 90 09 00 	vmovaps 0x990(%rip),%ymm2        # 402120 <__dso_handle+0x118>
  40178f:	00 
  401790:	c5 fc 28 1d 68 09 00 	vmovaps 0x968(%rip),%ymm3        # 402100 <__dso_handle+0xf8>
  401797:	00 
  401798:	75 a6                	jne    401740 <scale_and_shift+0x50>
  end_t = get_wall_time();
  40179a:	31 c0                	xor    %eax,%eax
  40179c:	c5 f8 77             	vzeroupper 
  40179f:	e8 7c fa ff ff       	call   401220 <get_wall_time>
  results(end_t - start_t, "scale_and_shift");
  4017a4:	c5 fb 5c 45 e8       	vsubsd -0x18(%rbp),%xmm0,%xmm0
  4017a9:	bf 5f 20 40 00       	mov    $0x40205f,%edi
  4017ae:	e8 1d fb ff ff       	call   4012d0 <results>
  check(y);
  4017b3:	bf 80 40 40 00       	mov    $0x404080,%edi
  4017b8:	e8 a3 fa ff ff       	call   401260 <check>
}
  4017bd:	48 83 c4 20          	add    $0x20,%rsp
  4017c1:	31 c0                	xor    %eax,%eax
  4017c3:	5b                   	pop    %rbx
  4017c4:	41 5a                	pop    %r10
  4017c6:	5d                   	pop    %rbp
  4017c7:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  4017cb:	c3                   	ret    
  4017cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004017d0 <__libc_csu_init>:
  4017d0:	f3 0f 1e fa          	endbr64 
  4017d4:	41 57                	push   %r15
  4017d6:	49 89 d7             	mov    %rdx,%r15
  4017d9:	41 56                	push   %r14
  4017db:	49 89 f6             	mov    %rsi,%r14
  4017de:	41 55                	push   %r13
  4017e0:	41 89 fd             	mov    %edi,%r13d
  4017e3:	41 54                	push   %r12
  4017e5:	4c 8d 25 14 26 00 00 	lea    0x2614(%rip),%r12        # 403e00 <__frame_dummy_init_array_entry>
  4017ec:	55                   	push   %rbp
  4017ed:	48 8d 2d 14 26 00 00 	lea    0x2614(%rip),%rbp        # 403e08 <__do_global_dtors_aux_fini_array_entry>
  4017f4:	53                   	push   %rbx
  4017f5:	4c 29 e5             	sub    %r12,%rbp
  4017f8:	48 83 ec 08          	sub    $0x8,%rsp
  4017fc:	e8 ff f7 ff ff       	call   401000 <_init>
  401801:	48 c1 fd 03          	sar    $0x3,%rbp
  401805:	74 1f                	je     401826 <__libc_csu_init+0x56>
  401807:	31 db                	xor    %ebx,%ebx
  401809:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401810:	4c 89 fa             	mov    %r15,%rdx
  401813:	4c 89 f6             	mov    %r14,%rsi
  401816:	44 89 ef             	mov    %r13d,%edi
  401819:	41 ff 14 dc          	call   *(%r12,%rbx,8)
  40181d:	48 83 c3 01          	add    $0x1,%rbx
  401821:	48 39 dd             	cmp    %rbx,%rbp
  401824:	75 ea                	jne    401810 <__libc_csu_init+0x40>
  401826:	48 83 c4 08          	add    $0x8,%rsp
  40182a:	5b                   	pop    %rbx
  40182b:	5d                   	pop    %rbp
  40182c:	41 5c                	pop    %r12
  40182e:	41 5d                	pop    %r13
  401830:	41 5e                	pop    %r14
  401832:	41 5f                	pop    %r15
  401834:	c3                   	ret    

0000000000401835 <.annobin___libc_csu_fini.start>:
  401835:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  40183c:	00 00 00 00 

0000000000401840 <__libc_csu_fini>:
  401840:	f3 0f 1e fa          	endbr64 
  401844:	c3                   	ret    

Disassembly of section .fini:

0000000000401848 <_fini>:
  401848:	f3 0f 1e fa          	endbr64 
  40184c:	48 83 ec 08          	sub    $0x8,%rsp
  401850:	48 83 c4 08          	add    $0x8,%rsp
  401854:	c3                   	ret    
