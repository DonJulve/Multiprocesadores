
ss_stride.1k.single.avx2.icx:     file format elf64-x86-64


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

0000000000401070 <_start>:
  401070:	f3 0f 1e fa          	endbr64 
  401074:	31 ed                	xor    %ebp,%ebp
  401076:	49 89 d1             	mov    %rdx,%r9
  401079:	5e                   	pop    %rsi
  40107a:	48 89 e2             	mov    %rsp,%rdx
  40107d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  401081:	50                   	push   %rax
  401082:	54                   	push   %rsp
  401083:	49 c7 c0 e0 17 40 00 	mov    $0x4017e0,%r8
  40108a:	48 c7 c1 70 17 40 00 	mov    $0x401770,%rcx
  401091:	48 c7 c7 00 15 40 00 	mov    $0x401500,%rdi
  401098:	ff 15 4a 2f 00 00    	call   *0x2f4a(%rip)        # 403fe8 <__libc_start_main@GLIBC_2.2.5>
  40109e:	f4                   	hlt    

000000000040109f <.annobin_init.c>:
  40109f:	90                   	nop

00000000004010a0 <_dl_relocate_static_pie>:
  4010a0:	f3 0f 1e fa          	endbr64 
  4010a4:	c3                   	ret    

00000000004010a5 <.annobin__dl_relocate_static_pie.end>:
  4010a5:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4010ac:	00 00 00 
  4010af:	90                   	nop

00000000004010b0 <deregister_tm_clones>:
  4010b0:	48 8d 3d 89 2f 00 00 	lea    0x2f89(%rip),%rdi        # 404040 <__TMC_END__>
  4010b7:	48 8d 05 82 2f 00 00 	lea    0x2f82(%rip),%rax        # 404040 <__TMC_END__>
  4010be:	48 39 f8             	cmp    %rdi,%rax
  4010c1:	74 15                	je     4010d8 <deregister_tm_clones+0x28>
  4010c3:	48 8b 05 16 2f 00 00 	mov    0x2f16(%rip),%rax        # 403fe0 <_ITM_deregisterTMCloneTable@Base>
  4010ca:	48 85 c0             	test   %rax,%rax
  4010cd:	74 09                	je     4010d8 <deregister_tm_clones+0x28>
  4010cf:	ff e0                	jmp    *%rax
  4010d1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  4010d8:	c3                   	ret    
  4010d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000004010e0 <register_tm_clones>:
  4010e0:	48 8d 3d 59 2f 00 00 	lea    0x2f59(%rip),%rdi        # 404040 <__TMC_END__>
  4010e7:	48 8d 35 52 2f 00 00 	lea    0x2f52(%rip),%rsi        # 404040 <__TMC_END__>
  4010ee:	48 29 fe             	sub    %rdi,%rsi
  4010f1:	48 89 f0             	mov    %rsi,%rax
  4010f4:	48 c1 ee 3f          	shr    $0x3f,%rsi
  4010f8:	48 c1 f8 03          	sar    $0x3,%rax
  4010fc:	48 01 c6             	add    %rax,%rsi
  4010ff:	48 d1 fe             	sar    %rsi
  401102:	74 14                	je     401118 <register_tm_clones+0x38>
  401104:	48 8b 05 ed 2e 00 00 	mov    0x2eed(%rip),%rax        # 403ff8 <_ITM_registerTMCloneTable@Base>
  40110b:	48 85 c0             	test   %rax,%rax
  40110e:	74 08                	je     401118 <register_tm_clones+0x38>
  401110:	ff e0                	jmp    *%rax
  401112:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  401118:	c3                   	ret    
  401119:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000401120 <__do_global_dtors_aux>:
  401120:	f3 0f 1e fa          	endbr64 
  401124:	80 3d 15 2f 00 00 00 	cmpb   $0x0,0x2f15(%rip)        # 404040 <__TMC_END__>
  40112b:	75 13                	jne    401140 <__do_global_dtors_aux+0x20>
  40112d:	55                   	push   %rbp
  40112e:	48 89 e5             	mov    %rsp,%rbp
  401131:	e8 7a ff ff ff       	call   4010b0 <deregister_tm_clones>
  401136:	c6 05 03 2f 00 00 01 	movb   $0x1,0x2f03(%rip)        # 404040 <__TMC_END__>
  40113d:	5d                   	pop    %rbp
  40113e:	c3                   	ret    
  40113f:	90                   	nop
  401140:	c3                   	ret    
  401141:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  401148:	00 00 00 00 
  40114c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401150 <frame_dummy>:
  401150:	f3 0f 1e fa          	endbr64 
  401154:	eb 8a                	jmp    4010e0 <register_tm_clones>
  401156:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40115d:	00 00 00 

0000000000401160 <dummy>:
  401160:	31 c0                	xor    %eax,%eax
  401162:	c3                   	ret    
  401163:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40116a:	00 00 00 
  40116d:	0f 1f 00             	nopl   (%rax)

0000000000401170 <get_wall_time>:

/* return wall time in seconds */
__attribute__ ((noinline))
double
get_wall_time()
{
  401170:	48 83 ec 18          	sub    $0x18,%rsp
  401174:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    struct timeval time;
    if (gettimeofday(&time,NULL)) {
  401179:	31 f6                	xor    %esi,%esi
  40117b:	e8 d0 fe ff ff       	call   401050 <gettimeofday@plt>
  401180:	85 c0                	test   %eax,%eax
  401182:	75 1f                	jne    4011a3 <get_wall_time+0x33>
        exit(-1); // return 0;
    }
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  401184:	c4 e1 fb 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm0,%xmm0
  40118b:	c4 e1 f3 2a 4c 24 10 	vcvtsi2sdq 0x10(%rsp),%xmm1,%xmm1
  401192:	c5 f3 59 0d 76 0e 00 	vmulsd 0xe76(%rip),%xmm1,%xmm1        # 402010 <__dso_handle+0x8>
  401199:	00 
  40119a:	c5 f3 58 c0          	vaddsd %xmm0,%xmm1,%xmm0
  40119e:	48 83 c4 18          	add    $0x18,%rsp
  4011a2:	c3                   	ret    
        exit(-1); // return 0;
  4011a3:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  4011a8:	e8 b3 fe ff ff       	call   401060 <exit@plt>
  4011ad:	0f 1f 00             	nopl   (%rax)

00000000004011b0 <check>:
#ifndef __INTEL_LLVM_COMPILER
   __attribute__((optimize("no-tree-vectorize")))
#endif
__attribute__ ((noinline))
void check(real arr[LEN])
{
  4011b0:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  4011b4:	31 c0                	xor    %eax,%eax
  4011b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4011bd:	00 00 00 
  real sum = 0;
#ifdef __INTEL_LLVM_COMPILER
  #pragma novector
#endif
  for (unsigned int i = 0; i < LEN; i++)
    sum += arr[i];
  4011c0:	c5 f8 10 0c 07       	vmovups (%rdi,%rax,1),%xmm1
  4011c5:	c5 f0 58 4c 07 10    	vaddps 0x10(%rdi,%rax,1),%xmm1,%xmm1
  4011cb:	c4 e3 79 05 d1 01    	vpermilpd $0x1,%xmm1,%xmm2
  4011d1:	c5 f0 58 ca          	vaddps %xmm2,%xmm1,%xmm1
  4011d5:	c5 fa 16 d1          	vmovshdup %xmm1,%xmm2
  4011d9:	c5 f2 58 ca          	vaddss %xmm2,%xmm1,%xmm1
  4011dd:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  for (unsigned int i = 0; i < LEN; i++)
  4011e1:	48 83 c0 20          	add    $0x20,%rax
  4011e5:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  4011eb:	75 d3                	jne    4011c0 <check+0x10>

  printf("%f \n", sum);
  4011ed:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  4011f1:	bf 34 20 40 00       	mov    $0x402034,%edi
  4011f6:	b0 01                	mov    $0x1,%al
  4011f8:	e9 43 fe ff ff       	jmp    401040 <printf@plt>
  4011fd:	0f 1f 00             	nopl   (%rax)

0000000000401200 <init>:
#ifndef __INTEL_LLVM_COMPILER
  __attribute__((optimize("no-tree-vectorize")))
#endif
__attribute__ ((noinline))
int init()
{
  401200:	48 c7 c0 00 f0 ff ff 	mov    $0xfffffffffffff000,%rax
#ifdef __INTEL_LLVM_COMPILER
  #pragma novector
#endif
  for (unsigned int j = 0; j < LEN; j++)
  {
    x[j] = 1.0;
  401207:	c4 e2 7d 18 05 18 0e 	vbroadcastss 0xe18(%rip),%ymm0        # 402028 <__dso_handle+0x20>
  40120e:	00 00 
  401210:	c5 fc 11 80 80 50 40 	vmovups %ymm0,0x405080(%rax)
  401217:	00 
  for (unsigned int j = 0; j < LEN; j++)
  401218:	48 83 c0 20          	add    $0x20,%rax
  40121c:	75 f2                	jne    401210 <init+0x10>
  }
  return 0;
  40121e:	31 c0                	xor    %eax,%eax
  401220:	c5 f8 77             	vzeroupper 
  401223:	c3                   	ret    
  401224:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  40122b:	00 00 00 00 00 

0000000000401230 <results>:
__attribute__ ((noinline))
void results(const double wall_time, const char *loop)
{
    printf("%18s  %6.1f    %6.1f     ",
          loop /* loop name */,
          wall_time/(1e-9*NTIMES),     /* ns/loop */
  401230:	c5 fb 59 15 e0 0d 00 	vmulsd 0xde0(%rip),%xmm0,%xmm2        # 402018 <__dso_handle+0x10>
  401237:	00 
  401238:	48 89 fe             	mov    %rdi,%rsi
            wall_time/(1e-12*NTIMES*LEN) /* ps/el */);
  40123b:	c5 fb 59 0d dd 0d 00 	vmulsd 0xddd(%rip),%xmm0,%xmm1        # 402020 <__dso_handle+0x18>
  401242:	00 
    printf("%18s  %6.1f    %6.1f     ",
  401243:	bf 39 20 40 00       	mov    $0x402039,%edi
  401248:	c5 f9 28 c2          	vmovapd %xmm2,%xmm0
  40124c:	b0 02                	mov    $0x2,%al
  40124e:	e9 ed fd ff ff       	jmp    401040 <printf@plt>
  401253:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  40125a:	84 00 00 00 00 00 

0000000000401260 <ss_stride_esc>:
/* funciones de cálculo */
#ifndef __INTEL_LLVM_COMPILER
  __attribute__((optimize("no-tree-vectorize")))
#endif
int ss_stride_esc()
{
  401260:	53                   	push   %rbx
  401261:	48 83 ec 10          	sub    $0x10,%rsp
  double start_t, end_t;

  init();
  401265:	e8 96 ff ff ff       	call   401200 <init>
  40126a:	31 db                	xor    %ebx,%ebx
  start_t = get_wall_time();
  40126c:	e8 ff fe ff ff       	call   401170 <get_wall_time>
  401271:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
  401277:	c5 fa 10 0d ad 0d 00 	vmovss 0xdad(%rip),%xmm1        # 40202c <__dso_handle+0x24>
  40127e:	00 
  40127f:	c5 fa 10 15 a9 0d 00 	vmovss 0xda9(%rip),%xmm2        # 402030 <__dso_handle+0x28>
  401286:	00 
  401287:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40128e:	00 00 
  401290:	48 c7 c0 00 e0 ff ff 	mov    $0xffffffffffffe000,%rax
  401297:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40129e:	00 00 
#ifdef __INTEL_LLVM_COMPILER
  #pragma novector
#endif
    for (unsigned int i = 0; i < 2*LEN; i+=2)
    {
      x[i] = alpha*x[i] + beta;
  4012a0:	c5 f2 59 80 80 60 40 	vmulss 0x406080(%rax),%xmm1,%xmm0
  4012a7:	00 
  4012a8:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  4012ac:	c5 fa 11 80 80 60 40 	vmovss %xmm0,0x406080(%rax)
  4012b3:	00 
  4012b4:	c5 f2 59 80 88 60 40 	vmulss 0x406088(%rax),%xmm1,%xmm0
  4012bb:	00 
  4012bc:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  4012c0:	c5 fa 11 80 88 60 40 	vmovss %xmm0,0x406088(%rax)
  4012c7:	00 
  4012c8:	c5 f2 59 80 90 60 40 	vmulss 0x406090(%rax),%xmm1,%xmm0
  4012cf:	00 
  4012d0:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  4012d4:	c5 fa 11 80 90 60 40 	vmovss %xmm0,0x406090(%rax)
  4012db:	00 
  4012dc:	c5 f2 59 80 98 60 40 	vmulss 0x406098(%rax),%xmm1,%xmm0
  4012e3:	00 
  4012e4:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  4012e8:	c5 fa 11 80 98 60 40 	vmovss %xmm0,0x406098(%rax)
  4012ef:	00 
  4012f0:	c5 f2 59 80 a0 60 40 	vmulss 0x4060a0(%rax),%xmm1,%xmm0
  4012f7:	00 
  4012f8:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  4012fc:	c5 fa 11 80 a0 60 40 	vmovss %xmm0,0x4060a0(%rax)
  401303:	00 
  401304:	c5 f2 59 80 a8 60 40 	vmulss 0x4060a8(%rax),%xmm1,%xmm0
  40130b:	00 
  40130c:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  401310:	c5 fa 11 80 a8 60 40 	vmovss %xmm0,0x4060a8(%rax)
  401317:	00 
  401318:	c5 f2 59 80 b0 60 40 	vmulss 0x4060b0(%rax),%xmm1,%xmm0
  40131f:	00 
  401320:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  401324:	c5 fa 11 80 b0 60 40 	vmovss %xmm0,0x4060b0(%rax)
  40132b:	00 
  40132c:	c5 f2 59 80 b8 60 40 	vmulss 0x4060b8(%rax),%xmm1,%xmm0
  401333:	00 
  401334:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  401338:	c5 fa 11 80 b8 60 40 	vmovss %xmm0,0x4060b8(%rax)
  40133f:	00 
    for (unsigned int i = 0; i < 2*LEN; i+=2)
  401340:	48 83 c0 40          	add    $0x40,%rax
  401344:	0f 85 56 ff ff ff    	jne    4012a0 <ss_stride_esc+0x40>
    }
    dummy(x, alpha, beta);
  40134a:	bf 80 40 40 00       	mov    $0x404080,%edi
  40134f:	c5 f8 28 c1          	vmovaps %xmm1,%xmm0
  401353:	c5 f8 28 ca          	vmovaps %xmm2,%xmm1
  401357:	e8 04 fe ff ff       	call   401160 <dummy>
  40135c:	c5 fa 10 15 cc 0c 00 	vmovss 0xccc(%rip),%xmm2        # 402030 <__dso_handle+0x28>
  401363:	00 
  401364:	c5 fa 10 0d c0 0c 00 	vmovss 0xcc0(%rip),%xmm1        # 40202c <__dso_handle+0x24>
  40136b:	00 
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40136c:	ff c3                	inc    %ebx
  40136e:	81 fb 00 00 f0 00    	cmp    $0xf00000,%ebx
  401374:	0f 85 16 ff ff ff    	jne    401290 <ss_stride_esc+0x30>
  }
  end_t = get_wall_time();
  40137a:	e8 f1 fd ff ff       	call   401170 <get_wall_time>
  results(end_t - start_t, "ss_stride_esc");
  40137f:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  401385:	bf 53 20 40 00       	mov    $0x402053,%edi
  40138a:	e8 a1 fe ff ff       	call   401230 <results>
  check(x);
  40138f:	bf 80 40 40 00       	mov    $0x404080,%edi
  401394:	e8 17 fe ff ff       	call   4011b0 <check>
  return 0;
  401399:	31 c0                	xor    %eax,%eax
  40139b:	48 83 c4 10          	add    $0x10,%rsp
  40139f:	5b                   	pop    %rbx
  4013a0:	c3                   	ret    
  4013a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  4013a8:	0f 1f 84 00 00 00 00 
  4013af:	00 

00000000004013b0 <ss_stride_vec>:
}

int ss_stride_vec()
{
  4013b0:	53                   	push   %rbx
  4013b1:	48 83 ec 10          	sub    $0x10,%rsp
  double start_t, end_t;

  init();
  4013b5:	e8 46 fe ff ff       	call   401200 <init>
  4013ba:	31 db                	xor    %ebx,%ebx
  start_t = get_wall_time();
  4013bc:	e8 af fd ff ff       	call   401170 <get_wall_time>
  4013c1:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
  4013c7:	c5 fa 10 0d 5d 0c 00 	vmovss 0xc5d(%rip),%xmm1        # 40202c <__dso_handle+0x24>
  4013ce:	00 
  4013cf:	c5 fa 10 15 59 0c 00 	vmovss 0xc59(%rip),%xmm2        # 402030 <__dso_handle+0x28>
  4013d6:	00 
  4013d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  4013de:	00 00 
  4013e0:	48 c7 c0 00 e0 ff ff 	mov    $0xffffffffffffe000,%rax
  4013e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  4013ee:	00 00 
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  {
    for (unsigned int i = 0; i < 2*LEN; i+=2)
    {
        x[i] = alpha*x[i] + beta;
  4013f0:	c5 f2 59 80 80 60 40 	vmulss 0x406080(%rax),%xmm1,%xmm0
  4013f7:	00 
  4013f8:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  4013fc:	c5 fa 11 80 80 60 40 	vmovss %xmm0,0x406080(%rax)
  401403:	00 
  401404:	c5 f2 59 80 88 60 40 	vmulss 0x406088(%rax),%xmm1,%xmm0
  40140b:	00 
  40140c:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  401410:	c5 fa 11 80 88 60 40 	vmovss %xmm0,0x406088(%rax)
  401417:	00 
  401418:	c5 f2 59 80 90 60 40 	vmulss 0x406090(%rax),%xmm1,%xmm0
  40141f:	00 
  401420:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  401424:	c5 fa 11 80 90 60 40 	vmovss %xmm0,0x406090(%rax)
  40142b:	00 
  40142c:	c5 f2 59 80 98 60 40 	vmulss 0x406098(%rax),%xmm1,%xmm0
  401433:	00 
  401434:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  401438:	c5 fa 11 80 98 60 40 	vmovss %xmm0,0x406098(%rax)
  40143f:	00 
  401440:	c5 f2 59 80 a0 60 40 	vmulss 0x4060a0(%rax),%xmm1,%xmm0
  401447:	00 
  401448:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  40144c:	c5 fa 11 80 a0 60 40 	vmovss %xmm0,0x4060a0(%rax)
  401453:	00 
  401454:	c5 f2 59 80 a8 60 40 	vmulss 0x4060a8(%rax),%xmm1,%xmm0
  40145b:	00 
  40145c:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  401460:	c5 fa 11 80 a8 60 40 	vmovss %xmm0,0x4060a8(%rax)
  401467:	00 
  401468:	c5 f2 59 80 b0 60 40 	vmulss 0x4060b0(%rax),%xmm1,%xmm0
  40146f:	00 
  401470:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  401474:	c5 fa 11 80 b0 60 40 	vmovss %xmm0,0x4060b0(%rax)
  40147b:	00 
  40147c:	c5 f2 59 80 b8 60 40 	vmulss 0x4060b8(%rax),%xmm1,%xmm0
  401483:	00 
  401484:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  401488:	c5 fa 11 80 b8 60 40 	vmovss %xmm0,0x4060b8(%rax)
  40148f:	00 
    for (unsigned int i = 0; i < 2*LEN; i+=2)
  401490:	48 83 c0 40          	add    $0x40,%rax
  401494:	0f 85 56 ff ff ff    	jne    4013f0 <ss_stride_vec+0x40>
    }
    dummy(x, alpha, beta);
  40149a:	bf 80 40 40 00       	mov    $0x404080,%edi
  40149f:	c5 f8 28 c1          	vmovaps %xmm1,%xmm0
  4014a3:	c5 f8 28 ca          	vmovaps %xmm2,%xmm1
  4014a7:	e8 b4 fc ff ff       	call   401160 <dummy>
  4014ac:	c5 fa 10 15 7c 0b 00 	vmovss 0xb7c(%rip),%xmm2        # 402030 <__dso_handle+0x28>
  4014b3:	00 
  4014b4:	c5 fa 10 0d 70 0b 00 	vmovss 0xb70(%rip),%xmm1        # 40202c <__dso_handle+0x24>
  4014bb:	00 
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4014bc:	ff c3                	inc    %ebx
  4014be:	81 fb 00 00 f0 00    	cmp    $0xf00000,%ebx
  4014c4:	0f 85 16 ff ff ff    	jne    4013e0 <ss_stride_vec+0x30>
  }
  end_t = get_wall_time();
  4014ca:	e8 a1 fc ff ff       	call   401170 <get_wall_time>
  results(end_t - start_t, "ss_stride_vec");
  4014cf:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  4014d5:	bf 61 20 40 00       	mov    $0x402061,%edi
  4014da:	e8 51 fd ff ff       	call   401230 <results>
  check(x);
  4014df:	bf 80 40 40 00       	mov    $0x404080,%edi
  4014e4:	e8 c7 fc ff ff       	call   4011b0 <check>
  return 0;
  4014e9:	31 c0                	xor    %eax,%eax
  4014eb:	48 83 c4 10          	add    $0x10,%rsp
  4014ef:	5b                   	pop    %rbx
  4014f0:	c3                   	ret    
  4014f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  4014f8:	0f 1f 84 00 00 00 00 
  4014ff:	00 

0000000000401500 <main>:
  return 0;
}
#endif

int main()
{
  401500:	53                   	push   %rbx
  401501:	48 83 ec 10          	sub    $0x10,%rsp
  401505:	c5 f8 ae 5c 24 04    	vstmxcsr 0x4(%rsp)
  40150b:	81 4c 24 04 40 80 00 	orl    $0x8040,0x4(%rsp)
  401512:	00 
  401513:	c5 f8 ae 54 24 04    	vldmxcsr 0x4(%rsp)
  printf("                     Time       TPE\n");
  401519:	bf 6f 20 40 00       	mov    $0x40206f,%edi
  40151e:	e8 0d fb ff ff       	call   401030 <puts@plt>
  printf("             Loop     ns       ps/el     Checksum\n");
  401523:	bf 93 20 40 00       	mov    $0x402093,%edi
  401528:	e8 03 fb ff ff       	call   401030 <puts@plt>
  init();
  40152d:	e8 ce fc ff ff       	call   401200 <init>
  401532:	31 db                	xor    %ebx,%ebx
  start_t = get_wall_time();
  401534:	e8 37 fc ff ff       	call   401170 <get_wall_time>
  401539:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
  40153f:	90                   	nop
  401540:	48 c7 c0 00 e0 ff ff 	mov    $0xffffffffffffe000,%rax
  401547:	c5 fa 10 15 dd 0a 00 	vmovss 0xadd(%rip),%xmm2        # 40202c <__dso_handle+0x24>
  40154e:	00 
  40154f:	c5 fa 10 0d d9 0a 00 	vmovss 0xad9(%rip),%xmm1        # 402030 <__dso_handle+0x28>
  401556:	00 
  401557:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40155e:	00 00 
      x[i] = alpha*x[i] + beta;
  401560:	c5 ea 59 80 80 60 40 	vmulss 0x406080(%rax),%xmm2,%xmm0
  401567:	00 
  401568:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  40156c:	c5 fa 11 80 80 60 40 	vmovss %xmm0,0x406080(%rax)
  401573:	00 
  401574:	c5 ea 59 80 88 60 40 	vmulss 0x406088(%rax),%xmm2,%xmm0
  40157b:	00 
  40157c:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  401580:	c5 fa 11 80 88 60 40 	vmovss %xmm0,0x406088(%rax)
  401587:	00 
  401588:	c5 ea 59 80 90 60 40 	vmulss 0x406090(%rax),%xmm2,%xmm0
  40158f:	00 
  401590:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  401594:	c5 fa 11 80 90 60 40 	vmovss %xmm0,0x406090(%rax)
  40159b:	00 
  40159c:	c5 ea 59 80 98 60 40 	vmulss 0x406098(%rax),%xmm2,%xmm0
  4015a3:	00 
  4015a4:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  4015a8:	c5 fa 11 80 98 60 40 	vmovss %xmm0,0x406098(%rax)
  4015af:	00 
  4015b0:	c5 ea 59 80 a0 60 40 	vmulss 0x4060a0(%rax),%xmm2,%xmm0
  4015b7:	00 
  4015b8:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  4015bc:	c5 fa 11 80 a0 60 40 	vmovss %xmm0,0x4060a0(%rax)
  4015c3:	00 
  4015c4:	c5 ea 59 80 a8 60 40 	vmulss 0x4060a8(%rax),%xmm2,%xmm0
  4015cb:	00 
  4015cc:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  4015d0:	c5 fa 11 80 a8 60 40 	vmovss %xmm0,0x4060a8(%rax)
  4015d7:	00 
  4015d8:	c5 ea 59 80 b0 60 40 	vmulss 0x4060b0(%rax),%xmm2,%xmm0
  4015df:	00 
  4015e0:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  4015e4:	c5 fa 11 80 b0 60 40 	vmovss %xmm0,0x4060b0(%rax)
  4015eb:	00 
  4015ec:	c5 ea 59 80 b8 60 40 	vmulss 0x4060b8(%rax),%xmm2,%xmm0
  4015f3:	00 
  4015f4:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  4015f8:	c5 fa 11 80 b8 60 40 	vmovss %xmm0,0x4060b8(%rax)
  4015ff:	00 
    for (unsigned int i = 0; i < 2*LEN; i+=2)
  401600:	48 83 c0 40          	add    $0x40,%rax
  401604:	0f 85 56 ff ff ff    	jne    401560 <main+0x60>
    dummy(x, alpha, beta);
  40160a:	bf 80 40 40 00       	mov    $0x404080,%edi
  40160f:	c5 f8 28 c2          	vmovaps %xmm2,%xmm0
  401613:	e8 48 fb ff ff       	call   401160 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  401618:	ff c3                	inc    %ebx
  40161a:	81 fb 00 00 f0 00    	cmp    $0xf00000,%ebx
  401620:	0f 85 1a ff ff ff    	jne    401540 <main+0x40>
  end_t = get_wall_time();
  401626:	e8 45 fb ff ff       	call   401170 <get_wall_time>
  results(end_t - start_t, "ss_stride_esc");
  40162b:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  401631:	bf 53 20 40 00       	mov    $0x402053,%edi
  401636:	e8 f5 fb ff ff       	call   401230 <results>
  check(x);
  40163b:	bf 80 40 40 00       	mov    $0x404080,%edi
  401640:	e8 6b fb ff ff       	call   4011b0 <check>
  init();
  401645:	e8 b6 fb ff ff       	call   401200 <init>
  40164a:	31 db                	xor    %ebx,%ebx
  start_t = get_wall_time();
  40164c:	e8 1f fb ff ff       	call   401170 <get_wall_time>
  401651:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
  401657:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40165e:	00 00 
  401660:	48 c7 c0 00 e0 ff ff 	mov    $0xffffffffffffe000,%rax
  401667:	c5 fa 10 15 bd 09 00 	vmovss 0x9bd(%rip),%xmm2        # 40202c <__dso_handle+0x24>
  40166e:	00 
  40166f:	c5 fa 10 0d b9 09 00 	vmovss 0x9b9(%rip),%xmm1        # 402030 <__dso_handle+0x28>
  401676:	00 
  401677:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40167e:	00 00 
        x[i] = alpha*x[i] + beta;
  401680:	c5 ea 59 80 80 60 40 	vmulss 0x406080(%rax),%xmm2,%xmm0
  401687:	00 
  401688:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  40168c:	c5 fa 11 80 80 60 40 	vmovss %xmm0,0x406080(%rax)
  401693:	00 
  401694:	c5 ea 59 80 88 60 40 	vmulss 0x406088(%rax),%xmm2,%xmm0
  40169b:	00 
  40169c:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  4016a0:	c5 fa 11 80 88 60 40 	vmovss %xmm0,0x406088(%rax)
  4016a7:	00 
  4016a8:	c5 ea 59 80 90 60 40 	vmulss 0x406090(%rax),%xmm2,%xmm0
  4016af:	00 
  4016b0:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  4016b4:	c5 fa 11 80 90 60 40 	vmovss %xmm0,0x406090(%rax)
  4016bb:	00 
  4016bc:	c5 ea 59 80 98 60 40 	vmulss 0x406098(%rax),%xmm2,%xmm0
  4016c3:	00 
  4016c4:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  4016c8:	c5 fa 11 80 98 60 40 	vmovss %xmm0,0x406098(%rax)
  4016cf:	00 
  4016d0:	c5 ea 59 80 a0 60 40 	vmulss 0x4060a0(%rax),%xmm2,%xmm0
  4016d7:	00 
  4016d8:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  4016dc:	c5 fa 11 80 a0 60 40 	vmovss %xmm0,0x4060a0(%rax)
  4016e3:	00 
  4016e4:	c5 ea 59 80 a8 60 40 	vmulss 0x4060a8(%rax),%xmm2,%xmm0
  4016eb:	00 
  4016ec:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  4016f0:	c5 fa 11 80 a8 60 40 	vmovss %xmm0,0x4060a8(%rax)
  4016f7:	00 
  4016f8:	c5 ea 59 80 b0 60 40 	vmulss 0x4060b0(%rax),%xmm2,%xmm0
  4016ff:	00 
  401700:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  401704:	c5 fa 11 80 b0 60 40 	vmovss %xmm0,0x4060b0(%rax)
  40170b:	00 
  40170c:	c5 ea 59 80 b8 60 40 	vmulss 0x4060b8(%rax),%xmm2,%xmm0
  401713:	00 
  401714:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  401718:	c5 fa 11 80 b8 60 40 	vmovss %xmm0,0x4060b8(%rax)
  40171f:	00 
    for (unsigned int i = 0; i < 2*LEN; i+=2)
  401720:	48 83 c0 40          	add    $0x40,%rax
  401724:	0f 85 56 ff ff ff    	jne    401680 <main+0x180>
    dummy(x, alpha, beta);
  40172a:	bf 80 40 40 00       	mov    $0x404080,%edi
  40172f:	c5 f8 28 c2          	vmovaps %xmm2,%xmm0
  401733:	e8 28 fa ff ff       	call   401160 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  401738:	ff c3                	inc    %ebx
  40173a:	81 fb 00 00 f0 00    	cmp    $0xf00000,%ebx
  401740:	0f 85 1a ff ff ff    	jne    401660 <main+0x160>
  end_t = get_wall_time();
  401746:	e8 25 fa ff ff       	call   401170 <get_wall_time>
  results(end_t - start_t, "ss_stride_vec");
  40174b:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  401751:	bf 61 20 40 00       	mov    $0x402061,%edi
  401756:	e8 d5 fa ff ff       	call   401230 <results>
  check(x);
  40175b:	bf 80 40 40 00       	mov    $0x404080,%edi
  401760:	e8 4b fa ff ff       	call   4011b0 <check>
  ss_stride_esc();
  ss_stride_vec();
  //ss_stride_v2(x);
  return 0;
  401765:	31 c0                	xor    %eax,%eax
  401767:	48 83 c4 10          	add    $0x10,%rsp
  40176b:	5b                   	pop    %rbx
  40176c:	c3                   	ret    
  40176d:	0f 1f 00             	nopl   (%rax)

0000000000401770 <__libc_csu_init>:
  401770:	f3 0f 1e fa          	endbr64 
  401774:	41 57                	push   %r15
  401776:	49 89 d7             	mov    %rdx,%r15
  401779:	41 56                	push   %r14
  40177b:	49 89 f6             	mov    %rsi,%r14
  40177e:	41 55                	push   %r13
  401780:	41 89 fd             	mov    %edi,%r13d
  401783:	41 54                	push   %r12
  401785:	4c 8d 25 54 26 00 00 	lea    0x2654(%rip),%r12        # 403de0 <__frame_dummy_init_array_entry>
  40178c:	55                   	push   %rbp
  40178d:	48 8d 2d 54 26 00 00 	lea    0x2654(%rip),%rbp        # 403de8 <__do_global_dtors_aux_fini_array_entry>
  401794:	53                   	push   %rbx
  401795:	4c 29 e5             	sub    %r12,%rbp
  401798:	48 83 ec 08          	sub    $0x8,%rsp
  40179c:	e8 5f f8 ff ff       	call   401000 <_init>
  4017a1:	48 c1 fd 03          	sar    $0x3,%rbp
  4017a5:	74 1f                	je     4017c6 <__libc_csu_init+0x56>
  4017a7:	31 db                	xor    %ebx,%ebx
  4017a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  4017b0:	4c 89 fa             	mov    %r15,%rdx
  4017b3:	4c 89 f6             	mov    %r14,%rsi
  4017b6:	44 89 ef             	mov    %r13d,%edi
  4017b9:	41 ff 14 dc          	call   *(%r12,%rbx,8)
  4017bd:	48 83 c3 01          	add    $0x1,%rbx
  4017c1:	48 39 dd             	cmp    %rbx,%rbp
  4017c4:	75 ea                	jne    4017b0 <__libc_csu_init+0x40>
  4017c6:	48 83 c4 08          	add    $0x8,%rsp
  4017ca:	5b                   	pop    %rbx
  4017cb:	5d                   	pop    %rbp
  4017cc:	41 5c                	pop    %r12
  4017ce:	41 5d                	pop    %r13
  4017d0:	41 5e                	pop    %r14
  4017d2:	41 5f                	pop    %r15
  4017d4:	c3                   	ret    

00000000004017d5 <.annobin___libc_csu_fini.start>:
  4017d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4017dc:	00 00 00 00 

00000000004017e0 <__libc_csu_fini>:
  4017e0:	f3 0f 1e fa          	endbr64 
  4017e4:	c3                   	ret    

Disassembly of section .fini:

00000000004017e8 <_fini>:
  4017e8:	f3 0f 1e fa          	endbr64 
  4017ec:	48 83 ec 08          	sub    $0x8,%rsp
  4017f0:	48 83 c4 08          	add    $0x8,%rsp
  4017f4:	c3                   	ret    
