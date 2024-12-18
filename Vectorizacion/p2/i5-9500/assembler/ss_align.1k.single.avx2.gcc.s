
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
  // printf("NTIMES: %u\n", NTIMES);

  printf("Direcciones de los vectores\n");
  401084:	bf 7b 20 40 00       	mov    $0x40207b,%edi
  401089:	e8 b2 ff ff ff       	call   401040 <puts@plt>
  printf("  @x[0]: %p\n", &x);
  40108e:	be c0 40 40 00       	mov    $0x4040c0,%esi
  401093:	bf 97 20 40 00       	mov    $0x402097,%edi
  401098:	31 c0                	xor    %eax,%eax
  40109a:	e8 b1 ff ff ff       	call   401050 <printf@plt>
  printf("  @x[1]: %p\n", &x[1]);
  40109f:	be c4 40 40 00       	mov    $0x4040c4,%esi
  4010a4:	bf a4 20 40 00       	mov    $0x4020a4,%edi
  4010a9:	31 c0                	xor    %eax,%eax
  4010ab:	e8 a0 ff ff ff       	call   401050 <printf@plt>
  printf("  @x[8]: %p\n", &x[8]);
  4010b0:	be e0 40 40 00       	mov    $0x4040e0,%esi
  4010b5:	bf b1 20 40 00       	mov    $0x4020b1,%edi
  4010ba:	31 c0                	xor    %eax,%eax
  4010bc:	e8 8f ff ff ff       	call   401050 <printf@plt>
  printf("\n");
  4010c1:	bf 0a 00 00 00       	mov    $0xa,%edi
  4010c6:	e8 65 ff ff ff       	call   401030 <putchar@plt>

  printf("                      Time      TPE\n");
  4010cb:	bf c0 20 40 00       	mov    $0x4020c0,%edi
  4010d0:	e8 6b ff ff ff       	call   401040 <puts@plt>
  printf("         Loop          ns      ps/el      Checksum\n");
  4010d5:	bf e8 20 40 00       	mov    $0x4020e8,%edi
  4010da:	e8 61 ff ff ff       	call   401040 <puts@plt>

  ss_align_v1();         /* x[] alineado */
  4010df:	31 c0                	xor    %eax,%eax
  4010e1:	e8 fa 01 00 00       	call   4012e0 <ss_align_v1>
  ss_align_v2();         /* x[] no alineado */
  4010e6:	31 c0                	xor    %eax,%eax
  4010e8:	e8 d3 02 00 00       	call   4013c0 <ss_align_v2>
  ss_align_v1_intr();    /* v1 con intrinsecos */
  4010ed:	31 c0                	xor    %eax,%eax
  4010ef:	e8 ac 03 00 00       	call   4014a0 <ss_align_v1_intr>
  ss_align_v2_intr();    /* v2 con intrínsecos */
  4010f4:	31 c0                	xor    %eax,%eax
  4010f6:	e8 85 04 00 00       	call   401580 <ss_align_v2_intr>
  //ss_align_v1_intru();     /* v1 con intrinsecos pero vectores no alineados */

  exit(0);
  4010fb:	31 ff                	xor    %edi,%edi
  4010fd:	e8 6e ff ff ff       	call   401070 <exit@plt>

0000000000401102 <.annobin_elf_init.c.hot>:
  401102:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  401109:	00 00 00 
  40110c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401110 <_start>:
  401110:	f3 0f 1e fa          	endbr64 
  401114:	31 ed                	xor    %ebp,%ebp
  401116:	49 89 d1             	mov    %rdx,%r9
  401119:	5e                   	pop    %rsi
  40111a:	48 89 e2             	mov    %rsp,%rdx
  40111d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  401121:	50                   	push   %rax
  401122:	54                   	push   %rsp
  401123:	49 c7 c0 90 17 40 00 	mov    $0x401790,%r8
  40112a:	48 c7 c1 20 17 40 00 	mov    $0x401720,%rcx
  401131:	48 c7 c7 80 10 40 00 	mov    $0x401080,%rdi
  401138:	ff 15 aa 2e 00 00    	call   *0x2eaa(%rip)        # 403fe8 <__libc_start_main@GLIBC_2.2.5>
  40113e:	f4                   	hlt    

000000000040113f <.annobin_init.c>:
  40113f:	90                   	nop

0000000000401140 <_dl_relocate_static_pie>:
  401140:	f3 0f 1e fa          	endbr64 
  401144:	c3                   	ret    

0000000000401145 <.annobin__dl_relocate_static_pie.end>:
  401145:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40114c:	00 00 00 
  40114f:	90                   	nop

0000000000401150 <deregister_tm_clones>:
  401150:	48 8d 3d f1 2e 00 00 	lea    0x2ef1(%rip),%rdi        # 404048 <__TMC_END__>
  401157:	48 8d 05 ea 2e 00 00 	lea    0x2eea(%rip),%rax        # 404048 <__TMC_END__>
  40115e:	48 39 f8             	cmp    %rdi,%rax
  401161:	74 15                	je     401178 <deregister_tm_clones+0x28>
  401163:	48 8b 05 76 2e 00 00 	mov    0x2e76(%rip),%rax        # 403fe0 <_ITM_deregisterTMCloneTable@Base>
  40116a:	48 85 c0             	test   %rax,%rax
  40116d:	74 09                	je     401178 <deregister_tm_clones+0x28>
  40116f:	ff e0                	jmp    *%rax
  401171:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401178:	c3                   	ret    
  401179:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000401180 <register_tm_clones>:
  401180:	48 8d 3d c1 2e 00 00 	lea    0x2ec1(%rip),%rdi        # 404048 <__TMC_END__>
  401187:	48 8d 35 ba 2e 00 00 	lea    0x2eba(%rip),%rsi        # 404048 <__TMC_END__>
  40118e:	48 29 fe             	sub    %rdi,%rsi
  401191:	48 89 f0             	mov    %rsi,%rax
  401194:	48 c1 ee 3f          	shr    $0x3f,%rsi
  401198:	48 c1 f8 03          	sar    $0x3,%rax
  40119c:	48 01 c6             	add    %rax,%rsi
  40119f:	48 d1 fe             	sar    %rsi
  4011a2:	74 14                	je     4011b8 <register_tm_clones+0x38>
  4011a4:	48 8b 05 4d 2e 00 00 	mov    0x2e4d(%rip),%rax        # 403ff8 <_ITM_registerTMCloneTable@Base>
  4011ab:	48 85 c0             	test   %rax,%rax
  4011ae:	74 08                	je     4011b8 <register_tm_clones+0x38>
  4011b0:	ff e0                	jmp    *%rax
  4011b2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  4011b8:	c3                   	ret    
  4011b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000004011c0 <__do_global_dtors_aux>:
  4011c0:	f3 0f 1e fa          	endbr64 
  4011c4:	80 3d b5 2e 00 00 00 	cmpb   $0x0,0x2eb5(%rip)        # 404080 <completed.0>
  4011cb:	75 13                	jne    4011e0 <__do_global_dtors_aux+0x20>
  4011cd:	55                   	push   %rbp
  4011ce:	48 89 e5             	mov    %rsp,%rbp
  4011d1:	e8 7a ff ff ff       	call   401150 <deregister_tm_clones>
  4011d6:	c6 05 a3 2e 00 00 01 	movb   $0x1,0x2ea3(%rip)        # 404080 <completed.0>
  4011dd:	5d                   	pop    %rbp
  4011de:	c3                   	ret    
  4011df:	90                   	nop
  4011e0:	c3                   	ret    
  4011e1:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4011e8:	00 00 00 00 
  4011ec:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004011f0 <frame_dummy>:
  4011f0:	f3 0f 1e fa          	endbr64 
  4011f4:	eb 8a                	jmp    401180 <register_tm_clones>

00000000004011f6 <dummy>:
  4011f6:	55                   	push   %rbp
  4011f7:	48 89 e5             	mov    %rsp,%rbp
  4011fa:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  4011fe:	f3 0f 11 45 f4       	movss  %xmm0,-0xc(%rbp)
  401203:	f3 0f 11 4d f0       	movss  %xmm1,-0x10(%rbp)
  401208:	b8 00 00 00 00       	mov    $0x0,%eax
  40120d:	5d                   	pop    %rbp
  40120e:	c3                   	ret    
  40120f:	90                   	nop

0000000000401210 <get_wall_time>:
{
  401210:	48 83 ec 18          	sub    $0x18,%rsp
    if (gettimeofday(&time,NULL)) {
  401214:	31 f6                	xor    %esi,%esi
  401216:	48 89 e7             	mov    %rsp,%rdi
  401219:	e8 42 fe ff ff       	call   401060 <gettimeofday@plt>
  40121e:	85 c0                	test   %eax,%eax
  401220:	75 22                	jne    401244 <get_wall_time+0x34>
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  401222:	c5 f0 57 c9          	vxorps %xmm1,%xmm1,%xmm1
  401226:	c4 e1 f3 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm1,%xmm0
  40122d:	c5 fb 59 05 eb 0e 00 	vmulsd 0xeeb(%rip),%xmm0,%xmm0        # 402120 <__dso_handle+0x118>
  401234:	00 
  401235:	c4 e1 f3 2a 0c 24    	vcvtsi2sdq (%rsp),%xmm1,%xmm1
}
  40123b:	48 83 c4 18          	add    $0x18,%rsp
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  40123f:	c5 fb 58 c1          	vaddsd %xmm1,%xmm0,%xmm0
}
  401243:	c3                   	ret    
        exit(-1); // return 0;
  401244:	83 cf ff             	or     $0xffffffff,%edi
  401247:	e8 24 fe ff ff       	call   401070 <exit@plt>
  40124c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401250 <check>:
  for (unsigned int i = 0; i < LEN; i++)
  401250:	48 8d 87 00 10 00 00 	lea    0x1000(%rdi),%rax
  real sum = 0;
  401257:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  40125b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    sum += arr[i];
  401260:	c5 fa 58 07          	vaddss (%rdi),%xmm0,%xmm0
  for (unsigned int i = 0; i < LEN; i++)
  401264:	48 83 c7 04          	add    $0x4,%rdi
  401268:	48 39 f8             	cmp    %rdi,%rax
  40126b:	75 f3                	jne    401260 <check+0x10>
  printf("%f \n", sum);
  40126d:	bf 10 20 40 00       	mov    $0x402010,%edi
  401272:	b8 01 00 00 00       	mov    $0x1,%eax
  401277:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40127b:	e9 d0 fd ff ff       	jmp    401050 <printf@plt>

0000000000401280 <init>:
    for (unsigned int j = 0; j < LEN; j++)
  401280:	c5 fa 10 05 b0 0e 00 	vmovss 0xeb0(%rip),%xmm0        # 402138 <__dso_handle+0x130>
  401287:	00 
  401288:	b8 c0 40 40 00       	mov    $0x4040c0,%eax
  40128d:	0f 1f 00             	nopl   (%rax)
	    x[j] = 1.0;
  401290:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    for (unsigned int j = 0; j < LEN; j++)
  401294:	48 83 c0 04          	add    $0x4,%rax
  401298:	48 3d c0 50 40 00    	cmp    $0x4050c0,%rax
  40129e:	75 f0                	jne    401290 <init+0x10>
}
  4012a0:	31 c0                	xor    %eax,%eax
  4012a2:	c3                   	ret    
  4012a3:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4012aa:	00 00 00 00 
  4012ae:	66 90                	xchg   %ax,%ax

00000000004012b0 <results>:
{
  4012b0:	48 89 fe             	mov    %rdi,%rsi
    printf("%18s  %6.1f    %6.1f     ",
  4012b3:	b8 02 00 00 00       	mov    $0x2,%eax
  4012b8:	bf 15 20 40 00       	mov    $0x402015,%edi
  4012bd:	c5 fb 5e 15 6b 0e 00 	vdivsd 0xe6b(%rip),%xmm0,%xmm2        # 402130 <__dso_handle+0x128>
  4012c4:	00 
  4012c5:	c5 fb 5e 0d 5b 0e 00 	vdivsd 0xe5b(%rip),%xmm0,%xmm1        # 402128 <__dso_handle+0x120>
  4012cc:	00 
  4012cd:	c5 eb 10 c2          	vmovsd %xmm2,%xmm2,%xmm0
  4012d1:	e9 7a fd ff ff       	jmp    401050 <printf@plt>
  4012d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4012dd:	00 00 00 

00000000004012e0 <ss_align_v1>:
{
  4012e0:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  4012e5:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  4012e9:	31 c0                	xor    %eax,%eax
{
  4012eb:	41 ff 72 f8          	push   -0x8(%r10)
  4012ef:	55                   	push   %rbp
  4012f0:	48 89 e5             	mov    %rsp,%rbp
  4012f3:	41 54                	push   %r12
  start_t = get_wall_time();
  4012f5:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  4012fb:	41 52                	push   %r10
  4012fd:	53                   	push   %rbx
  4012fe:	bb c0 50 40 00       	mov    $0x4050c0,%ebx
  401303:	48 83 ec 38          	sub    $0x38,%rsp
  init();
  401307:	e8 74 ff ff ff       	call   401280 <init>
  start_t = get_wall_time();
  40130c:	31 c0                	xor    %eax,%eax
  40130e:	e8 fd fe ff ff       	call   401210 <get_wall_time>
  401313:	c4 e2 7d 18 1d 24 0e 	vbroadcastss 0xe24(%rip),%ymm3        # 402140 <__dso_handle+0x138>
  40131a:	00 00 
  40131c:	c4 e2 7d 18 15 3b 0e 	vbroadcastss 0xe3b(%rip),%ymm2        # 402160 <__dso_handle+0x158>
  401323:	00 00 
  401325:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40132a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    for (unsigned int i = 0; i < LEN; i++)
  401330:	b8 c0 40 40 00       	mov    $0x4040c0,%eax
  401335:	0f 1f 00             	nopl   (%rax)
        x[i] = alpha*x[i] + beta;
  401338:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  40133c:	48 83 c0 20          	add    $0x20,%rax
  401340:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  401344:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
    for (unsigned int i = 0; i < LEN; i++)
  401349:	48 39 c3             	cmp    %rax,%rbx
  40134c:	75 ea                	jne    401338 <ss_align_v1+0x58>
    dummy(x, alpha, beta);
  40134e:	c5 fa 10 0d 0a 0e 00 	vmovss 0xe0a(%rip),%xmm1        # 402160 <__dso_handle+0x158>
  401355:	00 
  401356:	c5 fa 10 05 e2 0d 00 	vmovss 0xde2(%rip),%xmm0        # 402140 <__dso_handle+0x138>
  40135d:	00 
  40135e:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  401363:	c5 f8 77             	vzeroupper 
  401366:	e8 8b fe ff ff       	call   4011f6 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40136b:	41 83 ec 01          	sub    $0x1,%r12d
  40136f:	c5 fc 28 1d c9 0d 00 	vmovaps 0xdc9(%rip),%ymm3        # 402140 <__dso_handle+0x138>
  401376:	00 
  401377:	c5 fc 28 15 e1 0d 00 	vmovaps 0xde1(%rip),%ymm2        # 402160 <__dso_handle+0x158>
  40137e:	00 
  40137f:	75 af                	jne    401330 <ss_align_v1+0x50>
  end_t = get_wall_time();
  401381:	31 c0                	xor    %eax,%eax
  401383:	c5 f8 77             	vzeroupper 
  401386:	e8 85 fe ff ff       	call   401210 <get_wall_time>
  results(end_t - start_t, "ss_align_v1");
  40138b:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  401390:	bf 2f 20 40 00       	mov    $0x40202f,%edi
  401395:	e8 16 ff ff ff       	call   4012b0 <results>
  check(x);
  40139a:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  40139f:	e8 ac fe ff ff       	call   401250 <check>
}
  4013a4:	48 83 c4 38          	add    $0x38,%rsp
  4013a8:	31 c0                	xor    %eax,%eax
  4013aa:	5b                   	pop    %rbx
  4013ab:	41 5a                	pop    %r10
  4013ad:	41 5c                	pop    %r12
  4013af:	5d                   	pop    %rbp
  4013b0:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  4013b4:	c3                   	ret    
  4013b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4013bc:	00 00 00 00 

00000000004013c0 <ss_align_v2>:
{
  4013c0:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  4013c5:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  4013c9:	31 c0                	xor    %eax,%eax
{
  4013cb:	41 ff 72 f8          	push   -0x8(%r10)
  4013cf:	55                   	push   %rbp
  4013d0:	48 89 e5             	mov    %rsp,%rbp
  4013d3:	41 54                	push   %r12
  start_t = get_wall_time();
  4013d5:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  4013db:	41 52                	push   %r10
  4013dd:	53                   	push   %rbx
  4013de:	bb c4 50 40 00       	mov    $0x4050c4,%ebx
  4013e3:	48 83 ec 38          	sub    $0x38,%rsp
  init();
  4013e7:	e8 94 fe ff ff       	call   401280 <init>
  start_t = get_wall_time();
  4013ec:	31 c0                	xor    %eax,%eax
  4013ee:	e8 1d fe ff ff       	call   401210 <get_wall_time>
  4013f3:	c4 e2 7d 18 1d 44 0d 	vbroadcastss 0xd44(%rip),%ymm3        # 402140 <__dso_handle+0x138>
  4013fa:	00 00 
  4013fc:	c4 e2 7d 18 15 5b 0d 	vbroadcastss 0xd5b(%rip),%ymm2        # 402160 <__dso_handle+0x158>
  401403:	00 00 
  401405:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40140a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    for (unsigned int i = 0; i < LEN; i++)
  401410:	b8 c4 40 40 00       	mov    $0x4040c4,%eax
  401415:	0f 1f 00             	nopl   (%rax)
        x[i+1] = alpha*x[i+1] + beta;
  401418:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  40141c:	48 83 c0 20          	add    $0x20,%rax
  401420:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  401424:	c5 fc 11 40 e0       	vmovups %ymm0,-0x20(%rax)
    for (unsigned int i = 0; i < LEN; i++)
  401429:	48 39 c3             	cmp    %rax,%rbx
  40142c:	75 ea                	jne    401418 <ss_align_v2+0x58>
    dummy(x, alpha, beta);
  40142e:	c5 fa 10 0d 2a 0d 00 	vmovss 0xd2a(%rip),%xmm1        # 402160 <__dso_handle+0x158>
  401435:	00 
  401436:	c5 fa 10 05 02 0d 00 	vmovss 0xd02(%rip),%xmm0        # 402140 <__dso_handle+0x138>
  40143d:	00 
  40143e:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  401443:	c5 f8 77             	vzeroupper 
  401446:	e8 ab fd ff ff       	call   4011f6 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40144b:	41 83 ec 01          	sub    $0x1,%r12d
  40144f:	c5 fc 28 1d e9 0c 00 	vmovaps 0xce9(%rip),%ymm3        # 402140 <__dso_handle+0x138>
  401456:	00 
  401457:	c5 fc 28 15 01 0d 00 	vmovaps 0xd01(%rip),%ymm2        # 402160 <__dso_handle+0x158>
  40145e:	00 
  40145f:	75 af                	jne    401410 <ss_align_v2+0x50>
  end_t = get_wall_time();
  401461:	31 c0                	xor    %eax,%eax
  401463:	c5 f8 77             	vzeroupper 
  401466:	e8 a5 fd ff ff       	call   401210 <get_wall_time>
  results(end_t - start_t, "ss_align_v2");
  40146b:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  401470:	bf 3b 20 40 00       	mov    $0x40203b,%edi
  401475:	e8 36 fe ff ff       	call   4012b0 <results>
  check(x);
  40147a:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  40147f:	e8 cc fd ff ff       	call   401250 <check>
}
  401484:	48 83 c4 38          	add    $0x38,%rsp
  401488:	31 c0                	xor    %eax,%eax
  40148a:	5b                   	pop    %rbx
  40148b:	41 5a                	pop    %r10
  40148d:	41 5c                	pop    %r12
  40148f:	5d                   	pop    %rbp
  401490:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  401494:	c3                   	ret    
  401495:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  40149c:	00 00 00 00 

00000000004014a0 <ss_align_v1_intr>:
{
  4014a0:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  4014a5:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  4014a9:	31 c0                	xor    %eax,%eax
{
  4014ab:	41 ff 72 f8          	push   -0x8(%r10)
  4014af:	55                   	push   %rbp
  4014b0:	48 89 e5             	mov    %rsp,%rbp
  4014b3:	41 54                	push   %r12
  start_t = get_wall_time();
  4014b5:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  4014bb:	41 52                	push   %r10
  4014bd:	53                   	push   %rbx
  4014be:	bb c0 50 40 00       	mov    $0x4050c0,%ebx
  4014c3:	48 83 ec 38          	sub    $0x38,%rsp
  init();
  4014c7:	e8 b4 fd ff ff       	call   401280 <init>
  start_t = get_wall_time();
  4014cc:	31 c0                	xor    %eax,%eax
  4014ce:	e8 3d fd ff ff       	call   401210 <get_wall_time>
  4014d3:	c4 e2 7d 18 1d 64 0c 	vbroadcastss 0xc64(%rip),%ymm3        # 402140 <__dso_handle+0x138>
  4014da:	00 00 
  4014dc:	c4 e2 7d 18 15 7b 0c 	vbroadcastss 0xc7b(%rip),%ymm2        # 402160 <__dso_handle+0x158>
  4014e3:	00 00 
  4014e5:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4014ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  4014f0:	b8 c0 40 40 00       	mov    $0x4040c0,%eax
  4014f5:	0f 1f 00             	nopl   (%rax)
}

extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_mul_ps (__m256 __A, __m256 __B)
{
  return (__m256) ((__v8sf)__A * (__v8sf)__B);
  4014f8:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  4014fc:	48 83 c0 20          	add    $0x20,%rax
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  401500:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
}

extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_store_ps (float *__P, __m256 __A)
{
  *(__m256 *)__P = __A;
  401504:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
  401509:	48 39 c3             	cmp    %rax,%rbx
  40150c:	75 ea                	jne    4014f8 <ss_align_v1_intr+0x58>
    dummy(x, alpha, beta);
  40150e:	c5 fa 10 0d 4a 0c 00 	vmovss 0xc4a(%rip),%xmm1        # 402160 <__dso_handle+0x158>
  401515:	00 
  401516:	c5 fa 10 05 22 0c 00 	vmovss 0xc22(%rip),%xmm0        # 402140 <__dso_handle+0x138>
  40151d:	00 
  40151e:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  401523:	c5 f8 77             	vzeroupper 
  401526:	e8 cb fc ff ff       	call   4011f6 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40152b:	41 83 ec 01          	sub    $0x1,%r12d
  40152f:	c5 fc 28 1d 09 0c 00 	vmovaps 0xc09(%rip),%ymm3        # 402140 <__dso_handle+0x138>
  401536:	00 
  401537:	c5 fc 28 15 21 0c 00 	vmovaps 0xc21(%rip),%ymm2        # 402160 <__dso_handle+0x158>
  40153e:	00 
  40153f:	75 af                	jne    4014f0 <ss_align_v1_intr+0x50>
  end_t = get_wall_time();
  401541:	31 c0                	xor    %eax,%eax
  401543:	c5 f8 77             	vzeroupper 
  401546:	e8 c5 fc ff ff       	call   401210 <get_wall_time>
  results(end_t - start_t, "ss_align_v1_intr");
  40154b:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  401550:	bf 47 20 40 00       	mov    $0x402047,%edi
  401555:	e8 56 fd ff ff       	call   4012b0 <results>
  check(x);
  40155a:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  40155f:	e8 ec fc ff ff       	call   401250 <check>
}
  401564:	48 83 c4 38          	add    $0x38,%rsp
  401568:	31 c0                	xor    %eax,%eax
  40156a:	5b                   	pop    %rbx
  40156b:	41 5a                	pop    %r10
  40156d:	41 5c                	pop    %r12
  40156f:	5d                   	pop    %rbp
  401570:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  401574:	c3                   	ret    
  401575:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  40157c:	00 00 00 00 

0000000000401580 <ss_align_v2_intr>:
{
  401580:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  401585:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  401589:	31 c0                	xor    %eax,%eax
{
  40158b:	41 ff 72 f8          	push   -0x8(%r10)
  40158f:	55                   	push   %rbp
  401590:	48 89 e5             	mov    %rsp,%rbp
  401593:	41 52                	push   %r10
  401595:	53                   	push   %rbx
  start_t = get_wall_time();
  401596:	bb 00 00 f0 00       	mov    $0xf00000,%ebx
{
  40159b:	48 83 ec 20          	sub    $0x20,%rsp
  init();
  40159f:	e8 dc fc ff ff       	call   401280 <init>
  start_t = get_wall_time();
  4015a4:	31 c0                	xor    %eax,%eax
  4015a6:	e8 65 fc ff ff       	call   401210 <get_wall_time>
  4015ab:	c4 e2 7d 18 1d 8c 0b 	vbroadcastss 0xb8c(%rip),%ymm3        # 402140 <__dso_handle+0x138>
  4015b2:	00 00 
  4015b4:	c4 e2 7d 18 15 a3 0b 	vbroadcastss 0xba3(%rip),%ymm2        # 402160 <__dso_handle+0x158>
  4015bb:	00 00 
  4015bd:	c5 fb 11 45 e8       	vmovsd %xmm0,-0x18(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4015c2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  4015c8:	b8 c4 40 40 00       	mov    $0x4040c4,%eax
  4015cd:	0f 1f 00             	nopl   (%rax)
  return (__m256) ((__v8sf)__A * (__v8sf)__B);
  4015d0:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  4015d4:	48 83 c0 20          	add    $0x20,%rax
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  4015d8:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
}

extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_storeu_ps (float *__P, __m256 __A)
{
  *(__m256_u *)__P = __A;
  4015dc:	c5 fc 11 40 e0       	vmovups %ymm0,-0x20(%rax)
  4015e1:	48 3d c4 50 40 00    	cmp    $0x4050c4,%rax
  4015e7:	75 e7                	jne    4015d0 <ss_align_v2_intr+0x50>
    dummy(x, alpha, beta);
  4015e9:	c5 fa 10 0d 6f 0b 00 	vmovss 0xb6f(%rip),%xmm1        # 402160 <__dso_handle+0x158>
  4015f0:	00 
  4015f1:	c5 fa 10 05 47 0b 00 	vmovss 0xb47(%rip),%xmm0        # 402140 <__dso_handle+0x138>
  4015f8:	00 
  4015f9:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  4015fe:	c5 f8 77             	vzeroupper 
  401601:	e8 f0 fb ff ff       	call   4011f6 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  401606:	83 eb 01             	sub    $0x1,%ebx
  401609:	c5 fc 28 1d 2f 0b 00 	vmovaps 0xb2f(%rip),%ymm3        # 402140 <__dso_handle+0x138>
  401610:	00 
  401611:	c5 fc 28 15 47 0b 00 	vmovaps 0xb47(%rip),%ymm2        # 402160 <__dso_handle+0x158>
  401618:	00 
  401619:	75 ad                	jne    4015c8 <ss_align_v2_intr+0x48>
  end_t = get_wall_time();
  40161b:	31 c0                	xor    %eax,%eax
  40161d:	c5 f8 77             	vzeroupper 
  401620:	e8 eb fb ff ff       	call   401210 <get_wall_time>
  results(end_t - start_t, "ss_align_v2_intr");
  401625:	c5 fb 5c 45 e8       	vsubsd -0x18(%rbp),%xmm0,%xmm0
  40162a:	bf 58 20 40 00       	mov    $0x402058,%edi
  40162f:	e8 7c fc ff ff       	call   4012b0 <results>
  check(x);
  401634:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  401639:	e8 12 fc ff ff       	call   401250 <check>
}
  40163e:	48 83 c4 20          	add    $0x20,%rsp
  401642:	31 c0                	xor    %eax,%eax
  401644:	5b                   	pop    %rbx
  401645:	41 5a                	pop    %r10
  401647:	5d                   	pop    %rbp
  401648:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  40164c:	c3                   	ret    
  40164d:	0f 1f 00             	nopl   (%rax)

0000000000401650 <ss_align_v1_intru>:
{
  401650:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  401655:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  401659:	31 c0                	xor    %eax,%eax
{
  40165b:	41 ff 72 f8          	push   -0x8(%r10)
  40165f:	55                   	push   %rbp
  401660:	48 89 e5             	mov    %rsp,%rbp
  401663:	41 52                	push   %r10
  401665:	53                   	push   %rbx
  start_t = get_wall_time();
  401666:	bb 00 00 f0 00       	mov    $0xf00000,%ebx
{
  40166b:	48 83 ec 20          	sub    $0x20,%rsp
  init();
  40166f:	e8 0c fc ff ff       	call   401280 <init>
  start_t = get_wall_time();
  401674:	31 c0                	xor    %eax,%eax
  401676:	e8 95 fb ff ff       	call   401210 <get_wall_time>
  40167b:	c4 e2 7d 18 1d bc 0a 	vbroadcastss 0xabc(%rip),%ymm3        # 402140 <__dso_handle+0x138>
  401682:	00 00 
  401684:	c4 e2 7d 18 15 d3 0a 	vbroadcastss 0xad3(%rip),%ymm2        # 402160 <__dso_handle+0x158>
  40168b:	00 00 
  40168d:	c5 fb 11 45 e8       	vmovsd %xmm0,-0x18(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  401692:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  401698:	b8 c4 40 40 00       	mov    $0x4040c4,%eax
  40169d:	0f 1f 00             	nopl   (%rax)
  return (__m256) ((__v8sf)__A * (__v8sf)__B);
  4016a0:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  4016a4:	48 83 c0 20          	add    $0x20,%rax
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  4016a8:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  *(__m256 *)__P = __A;
  4016ac:	c5 fc 11 40 e0       	vmovups %ymm0,-0x20(%rax)
  4016b1:	48 3d c4 50 40 00    	cmp    $0x4050c4,%rax
  4016b7:	75 e7                	jne    4016a0 <ss_align_v1_intru+0x50>
    dummy(x, alpha, beta);
  4016b9:	c5 fa 10 0d 9f 0a 00 	vmovss 0xa9f(%rip),%xmm1        # 402160 <__dso_handle+0x158>
  4016c0:	00 
  4016c1:	c5 fa 10 05 77 0a 00 	vmovss 0xa77(%rip),%xmm0        # 402140 <__dso_handle+0x138>
  4016c8:	00 
  4016c9:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  4016ce:	c5 f8 77             	vzeroupper 
  4016d1:	e8 20 fb ff ff       	call   4011f6 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4016d6:	83 eb 01             	sub    $0x1,%ebx
  4016d9:	c5 fc 28 1d 5f 0a 00 	vmovaps 0xa5f(%rip),%ymm3        # 402140 <__dso_handle+0x138>
  4016e0:	00 
  4016e1:	c5 fc 28 15 77 0a 00 	vmovaps 0xa77(%rip),%ymm2        # 402160 <__dso_handle+0x158>
  4016e8:	00 
  4016e9:	75 ad                	jne    401698 <ss_align_v1_intru+0x48>
  end_t = get_wall_time();
  4016eb:	31 c0                	xor    %eax,%eax
  4016ed:	c5 f8 77             	vzeroupper 
  4016f0:	e8 1b fb ff ff       	call   401210 <get_wall_time>
  results(end_t - start_t, "ss_align_v1_intru");
  4016f5:	c5 fb 5c 45 e8       	vsubsd -0x18(%rbp),%xmm0,%xmm0
  4016fa:	bf 69 20 40 00       	mov    $0x402069,%edi
  4016ff:	e8 ac fb ff ff       	call   4012b0 <results>
  check(x);
  401704:	bf c0 40 40 00       	mov    $0x4040c0,%edi
  401709:	e8 42 fb ff ff       	call   401250 <check>
}
  40170e:	48 83 c4 20          	add    $0x20,%rsp
  401712:	31 c0                	xor    %eax,%eax
  401714:	5b                   	pop    %rbx
  401715:	41 5a                	pop    %r10
  401717:	5d                   	pop    %rbp
  401718:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  40171c:	c3                   	ret    
  40171d:	0f 1f 00             	nopl   (%rax)

0000000000401720 <__libc_csu_init>:
  401720:	f3 0f 1e fa          	endbr64 
  401724:	41 57                	push   %r15
  401726:	49 89 d7             	mov    %rdx,%r15
  401729:	41 56                	push   %r14
  40172b:	49 89 f6             	mov    %rsi,%r14
  40172e:	41 55                	push   %r13
  401730:	41 89 fd             	mov    %edi,%r13d
  401733:	41 54                	push   %r12
  401735:	4c 8d 25 b4 26 00 00 	lea    0x26b4(%rip),%r12        # 403df0 <__frame_dummy_init_array_entry>
  40173c:	55                   	push   %rbp
  40173d:	48 8d 2d b4 26 00 00 	lea    0x26b4(%rip),%rbp        # 403df8 <__do_global_dtors_aux_fini_array_entry>
  401744:	53                   	push   %rbx
  401745:	4c 29 e5             	sub    %r12,%rbp
  401748:	48 83 ec 08          	sub    $0x8,%rsp
  40174c:	e8 af f8 ff ff       	call   401000 <_init>
  401751:	48 c1 fd 03          	sar    $0x3,%rbp
  401755:	74 1f                	je     401776 <__libc_csu_init+0x56>
  401757:	31 db                	xor    %ebx,%ebx
  401759:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401760:	4c 89 fa             	mov    %r15,%rdx
  401763:	4c 89 f6             	mov    %r14,%rsi
  401766:	44 89 ef             	mov    %r13d,%edi
  401769:	41 ff 14 dc          	call   *(%r12,%rbx,8)
  40176d:	48 83 c3 01          	add    $0x1,%rbx
  401771:	48 39 dd             	cmp    %rbx,%rbp
  401774:	75 ea                	jne    401760 <__libc_csu_init+0x40>
  401776:	48 83 c4 08          	add    $0x8,%rsp
  40177a:	5b                   	pop    %rbx
  40177b:	5d                   	pop    %rbp
  40177c:	41 5c                	pop    %r12
  40177e:	41 5d                	pop    %r13
  401780:	41 5e                	pop    %r14
  401782:	41 5f                	pop    %r15
  401784:	c3                   	ret    

0000000000401785 <.annobin___libc_csu_fini.start>:
  401785:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  40178c:	00 00 00 00 

0000000000401790 <__libc_csu_fini>:
  401790:	f3 0f 1e fa          	endbr64 
  401794:	c3                   	ret    

Disassembly of section .fini:

0000000000401798 <_fini>:
  401798:	f3 0f 1e fa          	endbr64 
  40179c:	48 83 ec 08          	sub    $0x8,%rsp
  4017a0:	48 83 c4 08          	add    $0x8,%rsp
  4017a4:	c3                   	ret    
