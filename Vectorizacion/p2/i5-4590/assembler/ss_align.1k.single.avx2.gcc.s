
ss_align.1k.single.avx2.gcc:     file format elf64-x86-64


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

0000000000401020 <putchar@plt-0x10>:
  401020:	ff 35 e2 2f 00 00    	push   0x2fe2(%rip)        # 404008 <_GLOBAL_OFFSET_TABLE_+0x8>
  401026:	ff 25 e4 2f 00 00    	jmp    *0x2fe4(%rip)        # 404010 <_GLOBAL_OFFSET_TABLE_+0x10>
  40102c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401030 <putchar@plt>:
  401030:	ff 25 e2 2f 00 00    	jmp    *0x2fe2(%rip)        # 404018 <putchar@GLIBC_2.2.5>
  401036:	68 00 00 00 00       	push   $0x0
  40103b:	e9 e0 ff ff ff       	jmp    401020 <_init+0x20>

0000000000401040 <puts@plt>:
  401040:	ff 25 da 2f 00 00    	jmp    *0x2fda(%rip)        # 404020 <puts@GLIBC_2.2.5>
  401046:	68 01 00 00 00       	push   $0x1
  40104b:	e9 d0 ff ff ff       	jmp    401020 <_init+0x20>

0000000000401050 <printf@plt>:
  401050:	ff 25 d2 2f 00 00    	jmp    *0x2fd2(%rip)        # 404028 <printf@GLIBC_2.2.5>
  401056:	68 02 00 00 00       	push   $0x2
  40105b:	e9 c0 ff ff ff       	jmp    401020 <_init+0x20>

0000000000401060 <gettimeofday@plt>:
  401060:	ff 25 ca 2f 00 00    	jmp    *0x2fca(%rip)        # 404030 <gettimeofday@GLIBC_2.2.5>
  401066:	68 03 00 00 00       	push   $0x3
  40106b:	e9 b0 ff ff ff       	jmp    401020 <_init+0x20>

0000000000401070 <exit@plt>:
  401070:	ff 25 c2 2f 00 00    	jmp    *0x2fc2(%rip)        # 404038 <exit@GLIBC_2.2.5>
  401076:	68 04 00 00 00       	push   $0x4
  40107b:	e9 a0 ff ff ff       	jmp    401020 <_init+0x20>

Disassembly of section .text:

0000000000401080 <main>:
  check(x);
  return 0;
}

int main()
{
  401080:	48 83 ec 08          	sub    $0x8,%rsp
  printf("NTIMES: %u\n", NTIMES);
  401084:	be 00 00 f0 00       	mov    $0xf00000,%esi
  401089:	bf 7b 20 40 00       	mov    $0x40207b,%edi
  40108e:	31 c0                	xor    %eax,%eax
  401090:	e8 bb ff ff ff       	call   401050 <printf@plt>
  printf("Direcciones de los vectores\n");
  401095:	bf 87 20 40 00       	mov    $0x402087,%edi
  40109a:	e8 a1 ff ff ff       	call   401040 <puts@plt>
  printf("  @x[0]: %p\n", &x);
  40109f:	be c0 40 40 00       	mov    $0x4040c0,%esi
  4010a4:	bf a3 20 40 00       	mov    $0x4020a3,%edi
  4010a9:	31 c0                	xor    %eax,%eax
  4010ab:	e8 a0 ff ff ff       	call   401050 <printf@plt>
  printf("  @x[1]: %p\n", &x[1]);
  4010b0:	be c4 40 40 00       	mov    $0x4040c4,%esi
  4010b5:	bf b0 20 40 00       	mov    $0x4020b0,%edi
  4010ba:	31 c0                	xor    %eax,%eax
  4010bc:	e8 8f ff ff ff       	call   401050 <printf@plt>
  printf("  @x[8]: %p\n", &x[8]);
  4010c1:	be e0 40 40 00       	mov    $0x4040e0,%esi
  4010c6:	bf bd 20 40 00       	mov    $0x4020bd,%edi
  4010cb:	31 c0                	xor    %eax,%eax
  4010cd:	e8 7e ff ff ff       	call   401050 <printf@plt>
  printf("\n");
  4010d2:	bf 0a 00 00 00       	mov    $0xa,%edi
  4010d7:	e8 54 ff ff ff       	call   401030 <putchar@plt>

  printf("                      Time      TPE\n");
  4010dc:	bf d0 20 40 00       	mov    $0x4020d0,%edi
  4010e1:	e8 5a ff ff ff       	call   401040 <puts@plt>
  printf("         Loop          ns      ps/el      Checksum\n");
  4010e6:	bf f8 20 40 00       	mov    $0x4020f8,%edi
  4010eb:	e8 50 ff ff ff       	call   401040 <puts@plt>

  ss_align_v1();         /* x[] alineado */
  4010f0:	31 c0                	xor    %eax,%eax
  4010f2:	e8 f9 01 00 00       	call   4012f0 <ss_align_v1>
  ss_align_v2();         /* x[] no alineado */
  4010f7:	31 c0                	xor    %eax,%eax
  4010f9:	e8 d2 02 00 00       	call   4013d0 <ss_align_v2>
  ss_align_v1_intr();    /* v1 con intrinsecos */
  4010fe:	31 c0                	xor    %eax,%eax
  401100:	e8 ab 03 00 00       	call   4014b0 <ss_align_v1_intr>
  ss_align_v2_intr();    /* v2 con intrínsecos */
  401105:	31 c0                	xor    %eax,%eax
  401107:	e8 84 04 00 00       	call   401590 <ss_align_v2_intr>
  //ss_align_v1_intru();     /* v1 con intrinsecos pero vectores no alineados */

  exit(0);
  40110c:	31 ff                	xor    %edi,%edi
  40110e:	e8 5d ff ff ff       	call   401070 <exit@plt>

0000000000401113 <.annobin_elf_init.c.hot>:
  401113:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40111a:	00 00 00 
  40111d:	0f 1f 00             	nopl   (%rax)

0000000000401120 <_start>:
  401120:	f3 0f 1e fa          	endbr64 
  401124:	31 ed                	xor    %ebp,%ebp
  401126:	49 89 d1             	mov    %rdx,%r9
  401129:	5e                   	pop    %rsi
  40112a:	48 89 e2             	mov    %rsp,%rdx
  40112d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  401131:	50                   	push   %rax
  401132:	54                   	push   %rsp
  401133:	49 c7 c0 a0 17 40 00 	mov    $0x4017a0,%r8
  40113a:	48 c7 c1 30 17 40 00 	mov    $0x401730,%rcx
  401141:	48 c7 c7 80 10 40 00 	mov    $0x401080,%rdi
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
  401160:	48 8d 3d e1 2e 00 00 	lea    0x2ee1(%rip),%rdi        # 404048 <__TMC_END__>
  401167:	48 8d 05 da 2e 00 00 	lea    0x2eda(%rip),%rax        # 404048 <__TMC_END__>
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
  401190:	48 8d 3d b1 2e 00 00 	lea    0x2eb1(%rip),%rdi        # 404048 <__TMC_END__>
  401197:	48 8d 35 aa 2e 00 00 	lea    0x2eaa(%rip),%rsi        # 404048 <__TMC_END__>
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
  4011d4:	80 3d a5 2e 00 00 00 	cmpb   $0x0,0x2ea5(%rip)        # 404080 <completed.0>
  4011db:	75 13                	jne    4011f0 <__do_global_dtors_aux+0x20>
  4011dd:	55                   	push   %rbp
  4011de:	48 89 e5             	mov    %rsp,%rbp
  4011e1:	e8 7a ff ff ff       	call   401160 <deregister_tm_clones>
  4011e6:	c6 05 93 2e 00 00 01 	movb   $0x1,0x2e93(%rip)        # 404080 <completed.0>
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
  401229:	e8 32 fe ff ff       	call   401060 <gettimeofday@plt>
  40122e:	85 c0                	test   %eax,%eax
  401230:	75 22                	jne    401254 <get_wall_time+0x34>
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  401232:	c5 f0 57 c9          	vxorps %xmm1,%xmm1,%xmm1
  401236:	c4 e1 f3 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm1,%xmm0
  40123d:	c5 fb 59 05 eb 0e 00 	vmulsd 0xeeb(%rip),%xmm0,%xmm0        # 402130 <__dso_handle+0x128>
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
  401257:	e8 14 fe ff ff       	call   401070 <exit@plt>
  40125c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401260 <check>:
  for (unsigned int i = 0; i < LEN+1; i++)
  401260:	48 8d 87 04 10 00 00 	lea    0x1004(%rdi),%rax
  real sum = 0;
  401267:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  40126b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    sum += arr[i];
  401270:	c5 fa 58 07          	vaddss (%rdi),%xmm0,%xmm0
  for (unsigned int i = 0; i < LEN+1; i++)
  401274:	48 83 c7 04          	add    $0x4,%rdi
  401278:	48 39 f8             	cmp    %rdi,%rax
  40127b:	75 f3                	jne    401270 <check+0x10>
  printf("%f \n", sum);
  40127d:	bf 10 20 40 00       	mov    $0x402010,%edi
  401282:	b8 01 00 00 00       	mov    $0x1,%eax
  401287:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40128b:	e9 c0 fd ff ff       	jmp    401050 <printf@plt>

0000000000401290 <init>:
    for (unsigned int j = 0; j < LEN+1; j++)
  401290:	c5 fa 10 05 b0 0e 00 	vmovss 0xeb0(%rip),%xmm0        # 402148 <__dso_handle+0x140>
  401297:	00 
  401298:	b8 c0 40 40 00       	mov    $0x4040c0,%eax
  40129d:	0f 1f 00             	nopl   (%rax)
	    x[j] = 1.0;
  4012a0:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    for (unsigned int j = 0; j < LEN+1; j++)
  4012a4:	48 83 c0 04          	add    $0x4,%rax
  4012a8:	48 3d c4 50 40 00    	cmp    $0x4050c4,%rax
  4012ae:	75 f0                	jne    4012a0 <init+0x10>
}
  4012b0:	31 c0                	xor    %eax,%eax
  4012b2:	c3                   	ret    
  4012b3:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4012ba:	00 00 00 00 
  4012be:	66 90                	xchg   %ax,%ax

00000000004012c0 <results>:
{
  4012c0:	48 89 fe             	mov    %rdi,%rsi
    printf("%18s  %6.1f    %6.1f     ",
  4012c3:	b8 02 00 00 00       	mov    $0x2,%eax
  4012c8:	bf 15 20 40 00       	mov    $0x402015,%edi
  4012cd:	c5 fb 5e 15 6b 0e 00 	vdivsd 0xe6b(%rip),%xmm0,%xmm2        # 402140 <__dso_handle+0x138>
  4012d4:	00 
  4012d5:	c5 fb 5e 0d 5b 0e 00 	vdivsd 0xe5b(%rip),%xmm0,%xmm1        # 402138 <__dso_handle+0x130>
  4012dc:	00 
  4012dd:	c5 eb 10 c2          	vmovsd %xmm2,%xmm2,%xmm0
  4012e1:	e9 6a fd ff ff       	jmp    401050 <printf@plt>
  4012e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4012ed:	00 00 00 

00000000004012f0 <ss_align_v1>:
{
  4012f0:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  4012f5:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  4012f9:	31 c0                	xor    %eax,%eax
{
  4012fb:	41 ff 72 f8          	push   -0x8(%r10)
  4012ff:	55                   	push   %rbp
  401300:	48 89 e5             	mov    %rsp,%rbp
  401303:	41 54                	push   %r12
  start_t = get_wall_time();
  401305:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  40130b:	41 52                	push   %r10
  40130d:	53                   	push   %rbx
  40130e:	bb c0 50 40 00       	mov    $0x4050c0,%ebx
  401313:	48 83 ec 38          	sub    $0x38,%rsp
  init();
  401317:	e8 74 ff ff ff       	call   401290 <init>
  start_t = get_wall_time();
  40131c:	31 c0                	xor    %eax,%eax
  40131e:	e8 fd fe ff ff       	call   401220 <get_wall_time>
  401323:	c4 e2 7d 18 1d 34 0e 	vbroadcastss 0xe34(%rip),%ymm3        # 402160 <__dso_handle+0x158>
  40132a:	00 00 
  40132c:	c4 e2 7d 18 15 4b 0e 	vbroadcastss 0xe4b(%rip),%ymm2        # 402180 <__dso_handle+0x178>
  401333:	00 00 
  401335:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40133a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    for (unsigned int i = 0; i < LEN; i++)
  401340:	b8 c0 40 40 00       	mov    $0x4040c0,%eax
  401345:	0f 1f 00             	nopl   (%rax)
        x[i] = alpha*x[i] + beta;
  401348:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  40134c:	48 83 c0 20          	add    $0x20,%rax
  401350:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  401354:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
    for (unsigned int i = 0; i < LEN; i++)
  401359:	48 39 c3             	cmp    %rax,%rbx
  40135c:	75 ea                	jne    401348 <ss_align_v1+0x58>
    dummy(x, alpha, beta);
  40135e:	c5 fa 10 0d 1a 0e 00 	vmovss 0xe1a(%rip),%xmm1        # 402180 <__dso_handle+0x178>
  401365:	00 
  401366:	c5 fa 10 05 f2 0d 00 	vmovss 0xdf2(%rip),%xmm0        # 402160 <__dso_handle+0x158>
  40136d:	00 
  40136e:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  401373:	c5 f8 77             	vzeroupper 
  401376:	e8 8b fe ff ff       	call   401206 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40137b:	41 83 ec 01          	sub    $0x1,%r12d
  40137f:	c5 fc 28 1d d9 0d 00 	vmovaps 0xdd9(%rip),%ymm3        # 402160 <__dso_handle+0x158>
  401386:	00 
  401387:	c5 fc 28 15 f1 0d 00 	vmovaps 0xdf1(%rip),%ymm2        # 402180 <__dso_handle+0x178>
  40138e:	00 
  40138f:	75 af                	jne    401340 <ss_align_v1+0x50>
  end_t = get_wall_time();
  401391:	31 c0                	xor    %eax,%eax
  401393:	c5 f8 77             	vzeroupper 
  401396:	e8 85 fe ff ff       	call   401220 <get_wall_time>
  results(end_t - start_t, "ss_align_v1");
  40139b:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  4013a0:	bf 2f 20 40 00       	mov    $0x40202f,%edi
  4013a5:	e8 16 ff ff ff       	call   4012c0 <results>
  check(x);
  4013aa:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  4013af:	e8 ac fe ff ff       	call   401260 <check>
}
  4013b4:	48 83 c4 38          	add    $0x38,%rsp
  4013b8:	31 c0                	xor    %eax,%eax
  4013ba:	5b                   	pop    %rbx
  4013bb:	41 5a                	pop    %r10
  4013bd:	41 5c                	pop    %r12
  4013bf:	5d                   	pop    %rbp
  4013c0:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  4013c4:	c3                   	ret    
  4013c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4013cc:	00 00 00 00 

00000000004013d0 <ss_align_v2>:
{
  4013d0:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  4013d5:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  4013d9:	31 c0                	xor    %eax,%eax
{
  4013db:	41 ff 72 f8          	push   -0x8(%r10)
  4013df:	55                   	push   %rbp
  4013e0:	48 89 e5             	mov    %rsp,%rbp
  4013e3:	41 54                	push   %r12
  start_t = get_wall_time();
  4013e5:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  4013eb:	41 52                	push   %r10
  4013ed:	53                   	push   %rbx
  4013ee:	bb c4 50 40 00       	mov    $0x4050c4,%ebx
  4013f3:	48 83 ec 38          	sub    $0x38,%rsp
  init();
  4013f7:	e8 94 fe ff ff       	call   401290 <init>
  start_t = get_wall_time();
  4013fc:	31 c0                	xor    %eax,%eax
  4013fe:	e8 1d fe ff ff       	call   401220 <get_wall_time>
  401403:	c4 e2 7d 18 1d 54 0d 	vbroadcastss 0xd54(%rip),%ymm3        # 402160 <__dso_handle+0x158>
  40140a:	00 00 
  40140c:	c4 e2 7d 18 15 6b 0d 	vbroadcastss 0xd6b(%rip),%ymm2        # 402180 <__dso_handle+0x178>
  401413:	00 00 
  401415:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40141a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    for (unsigned int i = 0; i < LEN; i++)
  401420:	b8 c4 40 40 00       	mov    $0x4040c4,%eax
  401425:	0f 1f 00             	nopl   (%rax)
        x[i+1] = alpha*x[i+1] + beta;
  401428:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  40142c:	48 83 c0 20          	add    $0x20,%rax
  401430:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  401434:	c5 fc 11 40 e0       	vmovups %ymm0,-0x20(%rax)
    for (unsigned int i = 0; i < LEN; i++)
  401439:	48 39 c3             	cmp    %rax,%rbx
  40143c:	75 ea                	jne    401428 <ss_align_v2+0x58>
    dummy(x, alpha, beta);
  40143e:	c5 fa 10 0d 3a 0d 00 	vmovss 0xd3a(%rip),%xmm1        # 402180 <__dso_handle+0x178>
  401445:	00 
  401446:	c5 fa 10 05 12 0d 00 	vmovss 0xd12(%rip),%xmm0        # 402160 <__dso_handle+0x158>
  40144d:	00 
  40144e:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  401453:	c5 f8 77             	vzeroupper 
  401456:	e8 ab fd ff ff       	call   401206 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40145b:	41 83 ec 01          	sub    $0x1,%r12d
  40145f:	c5 fc 28 1d f9 0c 00 	vmovaps 0xcf9(%rip),%ymm3        # 402160 <__dso_handle+0x158>
  401466:	00 
  401467:	c5 fc 28 15 11 0d 00 	vmovaps 0xd11(%rip),%ymm2        # 402180 <__dso_handle+0x178>
  40146e:	00 
  40146f:	75 af                	jne    401420 <ss_align_v2+0x50>
  end_t = get_wall_time();
  401471:	31 c0                	xor    %eax,%eax
  401473:	c5 f8 77             	vzeroupper 
  401476:	e8 a5 fd ff ff       	call   401220 <get_wall_time>
  results(end_t - start_t, "ss_align_v2");
  40147b:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  401480:	bf 3b 20 40 00       	mov    $0x40203b,%edi
  401485:	e8 36 fe ff ff       	call   4012c0 <results>
  check(x);
  40148a:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  40148f:	e8 cc fd ff ff       	call   401260 <check>
}
  401494:	48 83 c4 38          	add    $0x38,%rsp
  401498:	31 c0                	xor    %eax,%eax
  40149a:	5b                   	pop    %rbx
  40149b:	41 5a                	pop    %r10
  40149d:	41 5c                	pop    %r12
  40149f:	5d                   	pop    %rbp
  4014a0:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  4014a4:	c3                   	ret    
  4014a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4014ac:	00 00 00 00 

00000000004014b0 <ss_align_v1_intr>:
{
  4014b0:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  4014b5:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  4014b9:	31 c0                	xor    %eax,%eax
{
  4014bb:	41 ff 72 f8          	push   -0x8(%r10)
  4014bf:	55                   	push   %rbp
  4014c0:	48 89 e5             	mov    %rsp,%rbp
  4014c3:	41 54                	push   %r12
  start_t = get_wall_time();
  4014c5:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  4014cb:	41 52                	push   %r10
  4014cd:	53                   	push   %rbx
  4014ce:	bb c0 50 40 00       	mov    $0x4050c0,%ebx
  4014d3:	48 83 ec 38          	sub    $0x38,%rsp
  init();
  4014d7:	e8 b4 fd ff ff       	call   401290 <init>
  start_t = get_wall_time();
  4014dc:	31 c0                	xor    %eax,%eax
  4014de:	e8 3d fd ff ff       	call   401220 <get_wall_time>
  4014e3:	c4 e2 7d 18 1d 74 0c 	vbroadcastss 0xc74(%rip),%ymm3        # 402160 <__dso_handle+0x158>
  4014ea:	00 00 
  4014ec:	c4 e2 7d 18 15 8b 0c 	vbroadcastss 0xc8b(%rip),%ymm2        # 402180 <__dso_handle+0x178>
  4014f3:	00 00 
  4014f5:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4014fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  401500:	b8 c0 40 40 00       	mov    $0x4040c0,%eax
  401505:	0f 1f 00             	nopl   (%rax)
}

extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_mul_ps (__m256 __A, __m256 __B)
{
  return (__m256) ((__v8sf)__A * (__v8sf)__B);
  401508:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  40150c:	48 83 c0 20          	add    $0x20,%rax
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  401510:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
}

extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_store_ps (float *__P, __m256 __A)
{
  *(__m256 *)__P = __A;
  401514:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
  401519:	48 39 c3             	cmp    %rax,%rbx
  40151c:	75 ea                	jne    401508 <ss_align_v1_intr+0x58>
    dummy(x, alpha, beta);
  40151e:	c5 fa 10 0d 5a 0c 00 	vmovss 0xc5a(%rip),%xmm1        # 402180 <__dso_handle+0x178>
  401525:	00 
  401526:	c5 fa 10 05 32 0c 00 	vmovss 0xc32(%rip),%xmm0        # 402160 <__dso_handle+0x158>
  40152d:	00 
  40152e:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  401533:	c5 f8 77             	vzeroupper 
  401536:	e8 cb fc ff ff       	call   401206 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40153b:	41 83 ec 01          	sub    $0x1,%r12d
  40153f:	c5 fc 28 1d 19 0c 00 	vmovaps 0xc19(%rip),%ymm3        # 402160 <__dso_handle+0x158>
  401546:	00 
  401547:	c5 fc 28 15 31 0c 00 	vmovaps 0xc31(%rip),%ymm2        # 402180 <__dso_handle+0x178>
  40154e:	00 
  40154f:	75 af                	jne    401500 <ss_align_v1_intr+0x50>
  end_t = get_wall_time();
  401551:	31 c0                	xor    %eax,%eax
  401553:	c5 f8 77             	vzeroupper 
  401556:	e8 c5 fc ff ff       	call   401220 <get_wall_time>
  results(end_t - start_t, "ss_align_v1_intr");
  40155b:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  401560:	bf 47 20 40 00       	mov    $0x402047,%edi
  401565:	e8 56 fd ff ff       	call   4012c0 <results>
  check(x);
  40156a:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  40156f:	e8 ec fc ff ff       	call   401260 <check>
}
  401574:	48 83 c4 38          	add    $0x38,%rsp
  401578:	31 c0                	xor    %eax,%eax
  40157a:	5b                   	pop    %rbx
  40157b:	41 5a                	pop    %r10
  40157d:	41 5c                	pop    %r12
  40157f:	5d                   	pop    %rbp
  401580:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  401584:	c3                   	ret    
  401585:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  40158c:	00 00 00 00 

0000000000401590 <ss_align_v2_intr>:
{
  401590:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  401595:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  401599:	31 c0                	xor    %eax,%eax
{
  40159b:	41 ff 72 f8          	push   -0x8(%r10)
  40159f:	55                   	push   %rbp
  4015a0:	48 89 e5             	mov    %rsp,%rbp
  4015a3:	41 52                	push   %r10
  4015a5:	53                   	push   %rbx
  start_t = get_wall_time();
  4015a6:	bb 00 00 f0 00       	mov    $0xf00000,%ebx
{
  4015ab:	48 83 ec 20          	sub    $0x20,%rsp
  init();
  4015af:	e8 dc fc ff ff       	call   401290 <init>
  start_t = get_wall_time();
  4015b4:	31 c0                	xor    %eax,%eax
  4015b6:	e8 65 fc ff ff       	call   401220 <get_wall_time>
  4015bb:	c4 e2 7d 18 1d 9c 0b 	vbroadcastss 0xb9c(%rip),%ymm3        # 402160 <__dso_handle+0x158>
  4015c2:	00 00 
  4015c4:	c4 e2 7d 18 15 b3 0b 	vbroadcastss 0xbb3(%rip),%ymm2        # 402180 <__dso_handle+0x178>
  4015cb:	00 00 
  4015cd:	c5 fb 11 45 e8       	vmovsd %xmm0,-0x18(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4015d2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  4015d8:	b8 c4 40 40 00       	mov    $0x4040c4,%eax
  4015dd:	0f 1f 00             	nopl   (%rax)
  return (__m256) ((__v8sf)__A * (__v8sf)__B);
  4015e0:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  4015e4:	48 83 c0 20          	add    $0x20,%rax
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  4015e8:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
}

extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_storeu_ps (float *__P, __m256 __A)
{
  *(__m256_u *)__P = __A;
  4015ec:	c5 fc 11 40 e0       	vmovups %ymm0,-0x20(%rax)
  4015f1:	48 3d c4 50 40 00    	cmp    $0x4050c4,%rax
  4015f7:	75 e7                	jne    4015e0 <ss_align_v2_intr+0x50>
    dummy(x, alpha, beta);
  4015f9:	c5 fa 10 0d 7f 0b 00 	vmovss 0xb7f(%rip),%xmm1        # 402180 <__dso_handle+0x178>
  401600:	00 
  401601:	c5 fa 10 05 57 0b 00 	vmovss 0xb57(%rip),%xmm0        # 402160 <__dso_handle+0x158>
  401608:	00 
  401609:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  40160e:	c5 f8 77             	vzeroupper 
  401611:	e8 f0 fb ff ff       	call   401206 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  401616:	83 eb 01             	sub    $0x1,%ebx
  401619:	c5 fc 28 1d 3f 0b 00 	vmovaps 0xb3f(%rip),%ymm3        # 402160 <__dso_handle+0x158>
  401620:	00 
  401621:	c5 fc 28 15 57 0b 00 	vmovaps 0xb57(%rip),%ymm2        # 402180 <__dso_handle+0x178>
  401628:	00 
  401629:	75 ad                	jne    4015d8 <ss_align_v2_intr+0x48>
  end_t = get_wall_time();
  40162b:	31 c0                	xor    %eax,%eax
  40162d:	c5 f8 77             	vzeroupper 
  401630:	e8 eb fb ff ff       	call   401220 <get_wall_time>
  results(end_t - start_t, "ss_align_v2_intr");
  401635:	c5 fb 5c 45 e8       	vsubsd -0x18(%rbp),%xmm0,%xmm0
  40163a:	bf 58 20 40 00       	mov    $0x402058,%edi
  40163f:	e8 7c fc ff ff       	call   4012c0 <results>
  check(x);
  401644:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  401649:	e8 12 fc ff ff       	call   401260 <check>
}
  40164e:	48 83 c4 20          	add    $0x20,%rsp
  401652:	31 c0                	xor    %eax,%eax
  401654:	5b                   	pop    %rbx
  401655:	41 5a                	pop    %r10
  401657:	5d                   	pop    %rbp
  401658:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  40165c:	c3                   	ret    
  40165d:	0f 1f 00             	nopl   (%rax)

0000000000401660 <ss_align_v1_intru>:
{
  401660:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  401665:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  401669:	31 c0                	xor    %eax,%eax
{
  40166b:	41 ff 72 f8          	push   -0x8(%r10)
  40166f:	55                   	push   %rbp
  401670:	48 89 e5             	mov    %rsp,%rbp
  401673:	41 52                	push   %r10
  401675:	53                   	push   %rbx
  start_t = get_wall_time();
  401676:	bb 00 00 f0 00       	mov    $0xf00000,%ebx
{
  40167b:	48 83 ec 20          	sub    $0x20,%rsp
  init();
  40167f:	e8 0c fc ff ff       	call   401290 <init>
  start_t = get_wall_time();
  401684:	31 c0                	xor    %eax,%eax
  401686:	e8 95 fb ff ff       	call   401220 <get_wall_time>
  40168b:	c4 e2 7d 18 1d cc 0a 	vbroadcastss 0xacc(%rip),%ymm3        # 402160 <__dso_handle+0x158>
  401692:	00 00 
  401694:	c4 e2 7d 18 15 e3 0a 	vbroadcastss 0xae3(%rip),%ymm2        # 402180 <__dso_handle+0x178>
  40169b:	00 00 
  40169d:	c5 fb 11 45 e8       	vmovsd %xmm0,-0x18(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4016a2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  4016a8:	b8 c4 40 40 00       	mov    $0x4040c4,%eax
  4016ad:	0f 1f 00             	nopl   (%rax)
  return (__m256) ((__v8sf)__A * (__v8sf)__B);
  4016b0:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  4016b4:	48 83 c0 20          	add    $0x20,%rax
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  4016b8:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  *(__m256 *)__P = __A;
  4016bc:	c5 fc 11 40 e0       	vmovups %ymm0,-0x20(%rax)
  4016c1:	48 3d c4 50 40 00    	cmp    $0x4050c4,%rax
  4016c7:	75 e7                	jne    4016b0 <ss_align_v1_intru+0x50>
    dummy(x, alpha, beta);
  4016c9:	c5 fa 10 0d af 0a 00 	vmovss 0xaaf(%rip),%xmm1        # 402180 <__dso_handle+0x178>
  4016d0:	00 
  4016d1:	c5 fa 10 05 87 0a 00 	vmovss 0xa87(%rip),%xmm0        # 402160 <__dso_handle+0x158>
  4016d8:	00 
  4016d9:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  4016de:	c5 f8 77             	vzeroupper 
  4016e1:	e8 20 fb ff ff       	call   401206 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4016e6:	83 eb 01             	sub    $0x1,%ebx
  4016e9:	c5 fc 28 1d 6f 0a 00 	vmovaps 0xa6f(%rip),%ymm3        # 402160 <__dso_handle+0x158>
  4016f0:	00 
  4016f1:	c5 fc 28 15 87 0a 00 	vmovaps 0xa87(%rip),%ymm2        # 402180 <__dso_handle+0x178>
  4016f8:	00 
  4016f9:	75 ad                	jne    4016a8 <ss_align_v1_intru+0x48>
  end_t = get_wall_time();
  4016fb:	31 c0                	xor    %eax,%eax
  4016fd:	c5 f8 77             	vzeroupper 
  401700:	e8 1b fb ff ff       	call   401220 <get_wall_time>
  results(end_t - start_t, "ss_align_v1_intru");
  401705:	c5 fb 5c 45 e8       	vsubsd -0x18(%rbp),%xmm0,%xmm0
  40170a:	bf 69 20 40 00       	mov    $0x402069,%edi
  40170f:	e8 ac fb ff ff       	call   4012c0 <results>
  check(x);
  401714:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  401719:	e8 42 fb ff ff       	call   401260 <check>
}
  40171e:	48 83 c4 20          	add    $0x20,%rsp
  401722:	31 c0                	xor    %eax,%eax
  401724:	5b                   	pop    %rbx
  401725:	41 5a                	pop    %r10
  401727:	5d                   	pop    %rbp
  401728:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  40172c:	c3                   	ret    
  40172d:	0f 1f 00             	nopl   (%rax)

0000000000401730 <__libc_csu_init>:
  401730:	f3 0f 1e fa          	endbr64 
  401734:	41 57                	push   %r15
  401736:	49 89 d7             	mov    %rdx,%r15
  401739:	41 56                	push   %r14
  40173b:	49 89 f6             	mov    %rsi,%r14
  40173e:	41 55                	push   %r13
  401740:	41 89 fd             	mov    %edi,%r13d
  401743:	41 54                	push   %r12
  401745:	4c 8d 25 b4 26 00 00 	lea    0x26b4(%rip),%r12        # 403e00 <__frame_dummy_init_array_entry>
  40174c:	55                   	push   %rbp
  40174d:	48 8d 2d b4 26 00 00 	lea    0x26b4(%rip),%rbp        # 403e08 <__do_global_dtors_aux_fini_array_entry>
  401754:	53                   	push   %rbx
  401755:	4c 29 e5             	sub    %r12,%rbp
  401758:	48 83 ec 08          	sub    $0x8,%rsp
  40175c:	e8 9f f8 ff ff       	call   401000 <_init>
  401761:	48 c1 fd 03          	sar    $0x3,%rbp
  401765:	74 1f                	je     401786 <__libc_csu_init+0x56>
  401767:	31 db                	xor    %ebx,%ebx
  401769:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401770:	4c 89 fa             	mov    %r15,%rdx
  401773:	4c 89 f6             	mov    %r14,%rsi
  401776:	44 89 ef             	mov    %r13d,%edi
  401779:	41 ff 14 dc          	call   *(%r12,%rbx,8)
  40177d:	48 83 c3 01          	add    $0x1,%rbx
  401781:	48 39 dd             	cmp    %rbx,%rbp
  401784:	75 ea                	jne    401770 <__libc_csu_init+0x40>
  401786:	48 83 c4 08          	add    $0x8,%rsp
  40178a:	5b                   	pop    %rbx
  40178b:	5d                   	pop    %rbp
  40178c:	41 5c                	pop    %r12
  40178e:	41 5d                	pop    %r13
  401790:	41 5e                	pop    %r14
  401792:	41 5f                	pop    %r15
  401794:	c3                   	ret    

0000000000401795 <.annobin___libc_csu_fini.start>:
  401795:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  40179c:	00 00 00 00 

00000000004017a0 <__libc_csu_fini>:
  4017a0:	f3 0f 1e fa          	endbr64 
  4017a4:	c3                   	ret    

Disassembly of section .fini:

00000000004017a8 <_fini>:
  4017a8:	f3 0f 1e fa          	endbr64 
  4017ac:	48 83 ec 08          	sub    $0x8,%rsp
  4017b0:	48 83 c4 08          	add    $0x8,%rsp
  4017b4:	c3                   	ret    
