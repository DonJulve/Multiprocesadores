
cond.1k.single.avx2.gcc:     file format elf64-x86-64


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
  check(z);
  return 0;
}

int main()
{
  401070:	48 83 ec 08          	sub    $0x8,%rsp
  printf("                     Time       TPE\n");
  401074:	bf 48 20 40 00       	mov    $0x402048,%edi
  401079:	e8 b2 ff ff ff       	call   401030 <puts@plt>
  printf("             Loop     ns       ps/el     Checksum\n");
  40107e:	bf 70 20 40 00       	mov    $0x402070,%edi
  401083:	e8 a8 ff ff ff       	call   401030 <puts@plt>
  cond_esc();
  401088:	31 c0                	xor    %eax,%eax
  40108a:	e8 f1 02 00 00       	call   401380 <cond_esc>
  cond_vec();
  40108f:	31 c0                	xor    %eax,%eax
  401091:	e8 ea 03 00 00       	call   401480 <cond_vec>
  return 0;
}
  401096:	31 c0                	xor    %eax,%eax
  401098:	48 83 c4 08          	add    $0x8,%rsp
  40109c:	c3                   	ret    

000000000040109d <.annobin_elf_init.c.hot>:
  40109d:	0f 1f 00             	nopl   (%rax)

00000000004010a0 <_start>:
  4010a0:	f3 0f 1e fa          	endbr64 
  4010a4:	31 ed                	xor    %ebp,%ebp
  4010a6:	49 89 d1             	mov    %rdx,%r9
  4010a9:	5e                   	pop    %rsi
  4010aa:	48 89 e2             	mov    %rsp,%rdx
  4010ad:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  4010b1:	50                   	push   %rax
  4010b2:	54                   	push   %rsp
  4010b3:	49 c7 c0 d0 15 40 00 	mov    $0x4015d0,%r8
  4010ba:	48 c7 c1 60 15 40 00 	mov    $0x401560,%rcx
  4010c1:	48 c7 c7 70 10 40 00 	mov    $0x401070,%rdi
  4010c8:	ff 15 1a 2f 00 00    	call   *0x2f1a(%rip)        # 403fe8 <__libc_start_main@GLIBC_2.2.5>
  4010ce:	f4                   	hlt    

00000000004010cf <.annobin_init.c>:
  4010cf:	90                   	nop

00000000004010d0 <_dl_relocate_static_pie>:
  4010d0:	f3 0f 1e fa          	endbr64 
  4010d4:	c3                   	ret    

00000000004010d5 <.annobin__dl_relocate_static_pie.end>:
  4010d5:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4010dc:	00 00 00 
  4010df:	90                   	nop

00000000004010e0 <deregister_tm_clones>:
  4010e0:	48 8d 3d 59 2f 00 00 	lea    0x2f59(%rip),%rdi        # 404040 <__TMC_END__>
  4010e7:	48 8d 05 52 2f 00 00 	lea    0x2f52(%rip),%rax        # 404040 <__TMC_END__>
  4010ee:	48 39 f8             	cmp    %rdi,%rax
  4010f1:	74 15                	je     401108 <deregister_tm_clones+0x28>
  4010f3:	48 8b 05 e6 2e 00 00 	mov    0x2ee6(%rip),%rax        # 403fe0 <_ITM_deregisterTMCloneTable@Base>
  4010fa:	48 85 c0             	test   %rax,%rax
  4010fd:	74 09                	je     401108 <deregister_tm_clones+0x28>
  4010ff:	ff e0                	jmp    *%rax
  401101:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401108:	c3                   	ret    
  401109:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000401110 <register_tm_clones>:
  401110:	48 8d 3d 29 2f 00 00 	lea    0x2f29(%rip),%rdi        # 404040 <__TMC_END__>
  401117:	48 8d 35 22 2f 00 00 	lea    0x2f22(%rip),%rsi        # 404040 <__TMC_END__>
  40111e:	48 29 fe             	sub    %rdi,%rsi
  401121:	48 89 f0             	mov    %rsi,%rax
  401124:	48 c1 ee 3f          	shr    $0x3f,%rsi
  401128:	48 c1 f8 03          	sar    $0x3,%rax
  40112c:	48 01 c6             	add    %rax,%rsi
  40112f:	48 d1 fe             	sar    %rsi
  401132:	74 14                	je     401148 <register_tm_clones+0x38>
  401134:	48 8b 05 bd 2e 00 00 	mov    0x2ebd(%rip),%rax        # 403ff8 <_ITM_registerTMCloneTable@Base>
  40113b:	48 85 c0             	test   %rax,%rax
  40113e:	74 08                	je     401148 <register_tm_clones+0x38>
  401140:	ff e0                	jmp    *%rax
  401142:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  401148:	c3                   	ret    
  401149:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000401150 <__do_global_dtors_aux>:
  401150:	f3 0f 1e fa          	endbr64 
  401154:	80 3d e5 2e 00 00 00 	cmpb   $0x0,0x2ee5(%rip)        # 404040 <__TMC_END__>
  40115b:	75 13                	jne    401170 <__do_global_dtors_aux+0x20>
  40115d:	55                   	push   %rbp
  40115e:	48 89 e5             	mov    %rsp,%rbp
  401161:	e8 7a ff ff ff       	call   4010e0 <deregister_tm_clones>
  401166:	c6 05 d3 2e 00 00 01 	movb   $0x1,0x2ed3(%rip)        # 404040 <__TMC_END__>
  40116d:	5d                   	pop    %rbp
  40116e:	c3                   	ret    
  40116f:	90                   	nop
  401170:	c3                   	ret    
  401171:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  401178:	00 00 00 00 
  40117c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401180 <frame_dummy>:
  401180:	f3 0f 1e fa          	endbr64 
  401184:	eb 8a                	jmp    401110 <register_tm_clones>

0000000000401186 <dummy>:
  401186:	55                   	push   %rbp
  401187:	48 89 e5             	mov    %rsp,%rbp
  40118a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  40118e:	f3 0f 11 45 f4       	movss  %xmm0,-0xc(%rbp)
  401193:	f3 0f 11 4d f0       	movss  %xmm1,-0x10(%rbp)
  401198:	b8 00 00 00 00       	mov    $0x0,%eax
  40119d:	5d                   	pop    %rbp
  40119e:	c3                   	ret    
  40119f:	90                   	nop

00000000004011a0 <set1d.constprop.1.isra.0>:
    for (unsigned int i = 0; i < LEN; i += stride)
  4011a0:	c5 fa 10 05 fc 0e 00 	vmovss 0xefc(%rip),%xmm0        # 4020a4 <__dso_handle+0x9c>
  4011a7:	00 
  4011a8:	b8 80 60 40 00       	mov    $0x406080,%eax
  4011ad:	ba 80 70 40 00       	mov    $0x407080,%edx
      arr[i] = value;
  4011b2:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    for (unsigned int i = 0; i < LEN; i += stride)
  4011b6:	48 83 c0 04          	add    $0x4,%rax
  4011ba:	48 39 c2             	cmp    %rax,%rdx
  4011bd:	75 f3                	jne    4011b2 <set1d.constprop.1.isra.0+0x12>
}
  4011bf:	c3                   	ret    

00000000004011c0 <set1d.constprop.0.isra.0>:
    for (unsigned int i = 0; i < LEN; i++)
  4011c0:	c5 fa 10 0d dc 0e 00 	vmovss 0xedc(%rip),%xmm1        # 4020a4 <__dso_handle+0x9c>
  4011c7:	00 
  4011c8:	c5 e8 57 d2          	vxorps %xmm2,%xmm2,%xmm2
set1d(real arr[LEN], real value, int stride)
  4011cc:	b8 01 00 00 00       	mov    $0x1,%eax
  4011d1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
      arr[i] = 1. / (real) (i+1);
  4011d8:	c5 ea 2a c0          	vcvtsi2ss %eax,%xmm2,%xmm0
  4011dc:	c5 f2 5e c0          	vdivss %xmm0,%xmm1,%xmm0
  4011e0:	c5 fa 11 44 87 fc    	vmovss %xmm0,-0x4(%rdi,%rax,4)
    for (unsigned int i = 0; i < LEN; i++)
  4011e6:	48 83 c0 01          	add    $0x1,%rax
  4011ea:	48 3d 01 04 00 00    	cmp    $0x401,%rax
  4011f0:	75 e6                	jne    4011d8 <set1d.constprop.0.isra.0+0x18>
}
  4011f2:	c3                   	ret    
  4011f3:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4011fa:	00 00 00 00 
  4011fe:	66 90                	xchg   %ax,%ax

0000000000401200 <get_wall_time>:
{
  401200:	48 83 ec 18          	sub    $0x18,%rsp
    if (gettimeofday(&time,NULL)) {
  401204:	31 f6                	xor    %esi,%esi
  401206:	48 89 e7             	mov    %rsp,%rdi
  401209:	e8 42 fe ff ff       	call   401050 <gettimeofday@plt>
  40120e:	85 c0                	test   %eax,%eax
  401210:	75 22                	jne    401234 <get_wall_time+0x34>
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  401212:	c5 f0 57 c9          	vxorps %xmm1,%xmm1,%xmm1
  401216:	c4 e1 f3 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm1,%xmm0
  40121d:	c5 fb 59 05 8b 0e 00 	vmulsd 0xe8b(%rip),%xmm0,%xmm0        # 4020b0 <__dso_handle+0xa8>
  401224:	00 
  401225:	c4 e1 f3 2a 0c 24    	vcvtsi2sdq (%rsp),%xmm1,%xmm1
}
  40122b:	48 83 c4 18          	add    $0x18,%rsp
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  40122f:	c5 fb 58 c1          	vaddsd %xmm1,%xmm0,%xmm0
}
  401233:	c3                   	ret    
        exit(-1); // return 0;
  401234:	83 cf ff             	or     $0xffffffff,%edi
  401237:	e8 24 fe ff ff       	call   401060 <exit@plt>
  40123c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401240 <set1d>:
  if (stride == -1) {
  401240:	c5 f0 57 c9          	vxorps %xmm1,%xmm1,%xmm1
{  
  401244:	48 89 fa             	mov    %rdi,%rdx
  if (stride == -1) {
  401247:	83 fe ff             	cmp    $0xffffffff,%esi
  40124a:	0f 84 82 00 00 00    	je     4012d2 <set1d+0x92>
  else if (stride == -2) {
  401250:	83 fe fe             	cmp    $0xfffffffe,%esi
  401253:	74 45                	je     40129a <set1d+0x5a>
    for (unsigned int i = 0; i < LEN; i += stride)
  401255:	31 c0                	xor    %eax,%eax
  401257:	83 fe 01             	cmp    $0x1,%esi
  40125a:	75 1c                	jne    401278 <set1d+0x38>
  40125c:	0f 1f 40 00          	nopl   0x0(%rax)
      arr[i] = value;
  401260:	89 c1                	mov    %eax,%ecx
    for (unsigned int i = 0; i < LEN; i += stride)
  401262:	83 c0 01             	add    $0x1,%eax
      arr[i] = value;
  401265:	c5 fa 11 04 8a       	vmovss %xmm0,(%rdx,%rcx,4)
    for (unsigned int i = 0; i < LEN; i += stride)
  40126a:	3d 00 04 00 00       	cmp    $0x400,%eax
  40126f:	75 ef                	jne    401260 <set1d+0x20>
}
  401271:	31 c0                	xor    %eax,%eax
  401273:	c3                   	ret    
  401274:	0f 1f 40 00          	nopl   0x0(%rax)
      arr[i] = value;
  401278:	89 c1                	mov    %eax,%ecx
    for (unsigned int i = 0; i < LEN; i += stride)
  40127a:	01 f0                	add    %esi,%eax
      arr[i] = value;
  40127c:	c5 fa 11 04 8a       	vmovss %xmm0,(%rdx,%rcx,4)
    for (unsigned int i = 0; i < LEN; i += stride)
  401281:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  401286:	77 e9                	ja     401271 <set1d+0x31>
      arr[i] = value;
  401288:	89 c1                	mov    %eax,%ecx
    for (unsigned int i = 0; i < LEN; i += stride)
  40128a:	01 f0                	add    %esi,%eax
      arr[i] = value;
  40128c:	c5 fa 11 04 8a       	vmovss %xmm0,(%rdx,%rcx,4)
    for (unsigned int i = 0; i < LEN; i += stride)
  401291:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  401296:	76 e0                	jbe    401278 <set1d+0x38>
  401298:	eb d7                	jmp    401271 <set1d+0x31>
  40129a:	c5 fa 10 15 02 0e 00 	vmovss 0xe02(%rip),%xmm2        # 4020a4 <__dso_handle+0x9c>
  4012a1:	00 
  4012a2:	b8 01 00 00 00       	mov    $0x1,%eax
  4012a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  4012ae:	00 00 
      arr[i] = 1. / (real) ((i+1) * (i+1));
  4012b0:	89 c1                	mov    %eax,%ecx
  4012b2:	0f af c8             	imul   %eax,%ecx
  4012b5:	c5 f2 2a c1          	vcvtsi2ss %ecx,%xmm1,%xmm0
  4012b9:	c5 ea 5e c0          	vdivss %xmm0,%xmm2,%xmm0
  4012bd:	c5 fa 11 44 82 fc    	vmovss %xmm0,-0x4(%rdx,%rax,4)
    for (unsigned int i = 0; i < LEN; i++)
  4012c3:	48 83 c0 01          	add    $0x1,%rax
  4012c7:	48 3d 01 04 00 00    	cmp    $0x401,%rax
  4012cd:	75 e1                	jne    4012b0 <set1d+0x70>
}
  4012cf:	31 c0                	xor    %eax,%eax
  4012d1:	c3                   	ret    
  4012d2:	c5 fa 10 15 ca 0d 00 	vmovss 0xdca(%rip),%xmm2        # 4020a4 <__dso_handle+0x9c>
  4012d9:	00 
  4012da:	b8 01 00 00 00       	mov    $0x1,%eax
  4012df:	90                   	nop
      arr[i] = 1. / (real) (i+1);
  4012e0:	c5 f2 2a c0          	vcvtsi2ss %eax,%xmm1,%xmm0
  4012e4:	c5 ea 5e c0          	vdivss %xmm0,%xmm2,%xmm0
  4012e8:	c5 fa 11 44 82 fc    	vmovss %xmm0,-0x4(%rdx,%rax,4)
    for (unsigned int i = 0; i < LEN; i++)
  4012ee:	48 83 c0 01          	add    $0x1,%rax
  4012f2:	48 3d 01 04 00 00    	cmp    $0x401,%rax
  4012f8:	75 e6                	jne    4012e0 <set1d+0xa0>
}
  4012fa:	31 c0                	xor    %eax,%eax
  4012fc:	c3                   	ret    
  4012fd:	0f 1f 00             	nopl   (%rax)

0000000000401300 <check>:
  for (unsigned int i = 0; i < LEN; i++)
  401300:	48 8d 87 00 10 00 00 	lea    0x1000(%rdi),%rax
  real sum = 0;
  401307:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  40130b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    sum += arr[i];
  401310:	c5 fa 58 07          	vaddss (%rdi),%xmm0,%xmm0
  for (unsigned int i = 0; i < LEN; i++)
  401314:	48 83 c7 04          	add    $0x4,%rdi
  401318:	48 39 f8             	cmp    %rdi,%rax
  40131b:	75 f3                	jne    401310 <check+0x10>
  printf("%f \n", sum);
  40131d:	bf 10 20 40 00       	mov    $0x402010,%edi
  401322:	b8 01 00 00 00       	mov    $0x1,%eax
  401327:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40132b:	e9 10 fd ff ff       	jmp    401040 <printf@plt>

0000000000401330 <init>:
  set1d(x, one, unit);
  401330:	e8 6b fe ff ff       	call   4011a0 <set1d.constprop.1.isra.0>
  set1d(y, any, frac1);
  401335:	bf 80 50 40 00       	mov    $0x405080,%edi
  40133a:	e8 81 fe ff ff       	call   4011c0 <set1d.constprop.0.isra.0>
  set1d(z, any, frac1);
  40133f:	bf 80 40 40 00       	mov    $0x404080,%edi
  401344:	e8 77 fe ff ff       	call   4011c0 <set1d.constprop.0.isra.0>
}
  401349:	31 c0                	xor    %eax,%eax
  40134b:	c3                   	ret    
  40134c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401350 <results>:
{
  401350:	48 89 fe             	mov    %rdi,%rsi
    printf("%18s  %6.1f    %6.1f     ",
  401353:	b8 02 00 00 00       	mov    $0x2,%eax
  401358:	bf 15 20 40 00       	mov    $0x402015,%edi
  40135d:	c5 fb 5e 15 5b 0d 00 	vdivsd 0xd5b(%rip),%xmm0,%xmm2        # 4020c0 <__dso_handle+0xb8>
  401364:	00 
  401365:	c5 fb 5e 0d 4b 0d 00 	vdivsd 0xd4b(%rip),%xmm0,%xmm1        # 4020b8 <__dso_handle+0xb0>
  40136c:	00 
  40136d:	c5 eb 10 c2          	vmovsd %xmm2,%xmm2,%xmm0
  401371:	e9 ca fc ff ff       	jmp    401040 <printf@plt>
  401376:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40137d:	00 00 00 

0000000000401380 <cond_esc>:
{
  401380:	53                   	push   %rbx
  init();
  401381:	31 c0                	xor    %eax,%eax
  start_t = get_wall_time();
  401383:	bb 00 00 a0 00       	mov    $0xa00000,%ebx
{
  401388:	48 83 ec 10          	sub    $0x10,%rsp
  init();
  40138c:	e8 9f ff ff ff       	call   401330 <init>
  start_t = get_wall_time();
  401391:	31 c0                	xor    %eax,%eax
  401393:	e8 68 fe ff ff       	call   401200 <get_wall_time>
  401398:	c5 fa 10 0d 40 0d 00 	vmovss 0xd40(%rip),%xmm1        # 4020e0 <__dso_handle+0xd8>
  40139f:	00 
  4013a0:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4013a6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  4013ad:	00 00 00 
{
  4013b0:	31 c0                	xor    %eax,%eax
  4013b2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
      if (y[i] < umbral)
  4013b8:	c5 fa 10 80 80 50 40 	vmovss 0x405080(%rax),%xmm0
  4013bf:	00 
  4013c0:	c5 f8 2f c8          	vcomiss %xmm0,%xmm1
  4013c4:	0f 87 96 00 00 00    	ja     401460 <cond_esc+0xe0>
         z[i] = x[i];
  4013ca:	c5 fa 10 80 80 60 40 	vmovss 0x406080(%rax),%xmm0
  4013d1:	00 
    for (unsigned int i = 0; i < LEN; i++)
  4013d2:	48 83 c0 04          	add    $0x4,%rax
  4013d6:	c5 fa 11 80 7c 40 40 	vmovss %xmm0,0x40407c(%rax)
  4013dd:	00 
  4013de:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  4013e4:	75 d2                	jne    4013b8 <cond_esc+0x38>
    dummy(x, y, z, scalar);
  4013e6:	ba 80 40 40 00       	mov    $0x404080,%edx
  4013eb:	be 80 50 40 00       	mov    $0x405080,%esi
  4013f0:	bf 80 60 40 00       	mov    $0x406080,%edi
  4013f5:	c5 fa 10 05 ab 0c 00 	vmovss 0xcab(%rip),%xmm0        # 4020a8 <__dso_handle+0xa0>
  4013fc:	00 
  4013fd:	e8 84 fd ff ff       	call   401186 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  401402:	83 eb 01             	sub    $0x1,%ebx
  401405:	c5 fa 10 0d d3 0c 00 	vmovss 0xcd3(%rip),%xmm1        # 4020e0 <__dso_handle+0xd8>
  40140c:	00 
  40140d:	75 a1                	jne    4013b0 <cond_esc+0x30>
  end_t = get_wall_time();
  40140f:	31 c0                	xor    %eax,%eax
  401411:	e8 ea fd ff ff       	call   401200 <get_wall_time>
  results(end_t - start_t, "cond_esc");
  401416:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  40141c:	bf 2f 20 40 00       	mov    $0x40202f,%edi
  401421:	e8 2a ff ff ff       	call   401350 <results>
  for (unsigned int i = 0; i < LEN; i++)
  401426:	b8 80 40 40 00       	mov    $0x404080,%eax
  real sum = 0;
  40142b:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  40142f:	90                   	nop
    sum += arr[i];
  401430:	c5 fa 58 00          	vaddss (%rax),%xmm0,%xmm0
  for (unsigned int i = 0; i < LEN; i++)
  401434:	48 83 c0 04          	add    $0x4,%rax
  401438:	48 3d 80 50 40 00    	cmp    $0x405080,%rax
  40143e:	75 f0                	jne    401430 <cond_esc+0xb0>
  printf("%f \n", sum);
  401440:	bf 10 20 40 00       	mov    $0x402010,%edi
  401445:	b8 01 00 00 00       	mov    $0x1,%eax
  40144a:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40144e:	e8 ed fb ff ff       	call   401040 <printf@plt>
}
  401453:	48 83 c4 10          	add    $0x10,%rsp
  401457:	31 c0                	xor    %eax,%eax
  401459:	5b                   	pop    %rbx
  40145a:	c3                   	ret    
  40145b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401460:	c5 fa 11 80 80 40 40 	vmovss %xmm0,0x404080(%rax)
  401467:	00 
    for (unsigned int i = 0; i < LEN; i++)
  401468:	48 83 c0 04          	add    $0x4,%rax
  40146c:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  401472:	0f 85 40 ff ff ff    	jne    4013b8 <cond_esc+0x38>
  401478:	e9 69 ff ff ff       	jmp    4013e6 <cond_esc+0x66>
  40147d:	0f 1f 00             	nopl   (%rax)

0000000000401480 <cond_vec>:
{
  401480:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  401485:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  401489:	31 c0                	xor    %eax,%eax
{
  40148b:	41 ff 72 f8          	push   -0x8(%r10)
  40148f:	55                   	push   %rbp
  401490:	48 89 e5             	mov    %rsp,%rbp
  401493:	41 52                	push   %r10
  401495:	53                   	push   %rbx
  start_t = get_wall_time();
  401496:	bb 00 00 a0 00       	mov    $0xa00000,%ebx
{
  40149b:	48 83 ec 20          	sub    $0x20,%rsp
  init();
  40149f:	e8 8c fe ff ff       	call   401330 <init>
  start_t = get_wall_time();
  4014a4:	31 c0                	xor    %eax,%eax
  4014a6:	e8 55 fd ff ff       	call   401200 <get_wall_time>
  4014ab:	c4 e2 7d 18 0d 2c 0c 	vbroadcastss 0xc2c(%rip),%ymm1        # 4020e0 <__dso_handle+0xd8>
  4014b2:	00 00 
  4014b4:	c5 fb 11 45 e8       	vmovsd %xmm0,-0x18(%rbp)
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4014b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  start_t = get_wall_time();
  4014c0:	31 c0                	xor    %eax,%eax
  4014c2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
         z[i] = x[i];
  4014c8:	c5 fc 28 90 80 50 40 	vmovaps 0x405080(%rax),%ymm2
  4014cf:	00 
  4014d0:	c5 fc 28 98 80 60 40 	vmovaps 0x406080(%rax),%ymm3
  4014d7:	00 
  4014d8:	48 83 c0 20          	add    $0x20,%rax
  4014dc:	c5 ec c2 c1 01       	vcmpltps %ymm1,%ymm2,%ymm0
  4014e1:	c4 e3 65 4a c2 00    	vblendvps %ymm0,%ymm2,%ymm3,%ymm0
  4014e7:	c5 fc 29 80 60 40 40 	vmovaps %ymm0,0x404060(%rax)
  4014ee:	00 
    for (unsigned int i = 0; i < LEN; i++)
  4014ef:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  4014f5:	75 d1                	jne    4014c8 <cond_vec+0x48>
    dummy(x, y, z, scalar);
  4014f7:	ba 80 40 40 00       	mov    $0x404080,%edx
  4014fc:	be 80 50 40 00       	mov    $0x405080,%esi
  401501:	bf 80 60 40 00       	mov    $0x406080,%edi
  401506:	c5 fa 10 05 9a 0b 00 	vmovss 0xb9a(%rip),%xmm0        # 4020a8 <__dso_handle+0xa0>
  40150d:	00 
  40150e:	c5 f8 77             	vzeroupper 
  401511:	e8 70 fc ff ff       	call   401186 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  401516:	83 eb 01             	sub    $0x1,%ebx
  401519:	c5 fc 28 0d bf 0b 00 	vmovaps 0xbbf(%rip),%ymm1        # 4020e0 <__dso_handle+0xd8>
  401520:	00 
  401521:	75 9d                	jne    4014c0 <cond_vec+0x40>
  end_t = get_wall_time();
  401523:	31 c0                	xor    %eax,%eax
  401525:	c5 f8 77             	vzeroupper 
  401528:	e8 d3 fc ff ff       	call   401200 <get_wall_time>
  results(end_t - start_t, "cond_vec");
  40152d:	c5 fb 5c 45 e8       	vsubsd -0x18(%rbp),%xmm0,%xmm0
  401532:	bf 38 20 40 00       	mov    $0x402038,%edi
  401537:	e8 14 fe ff ff       	call   401350 <results>
  check(z);
  40153c:	bf 80 40 40 00       	mov    $0x404080,%edi
  401541:	e8 ba fd ff ff       	call   401300 <check>
}
  401546:	48 83 c4 20          	add    $0x20,%rsp
  40154a:	31 c0                	xor    %eax,%eax
  40154c:	5b                   	pop    %rbx
  40154d:	41 5a                	pop    %r10
  40154f:	5d                   	pop    %rbp
  401550:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  401554:	c3                   	ret    
  401555:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  40155c:	00 00 00 
  40155f:	90                   	nop

0000000000401560 <__libc_csu_init>:
  401560:	f3 0f 1e fa          	endbr64 
  401564:	41 57                	push   %r15
  401566:	49 89 d7             	mov    %rdx,%r15
  401569:	41 56                	push   %r14
  40156b:	49 89 f6             	mov    %rsi,%r14
  40156e:	41 55                	push   %r13
  401570:	41 89 fd             	mov    %edi,%r13d
  401573:	41 54                	push   %r12
  401575:	4c 8d 25 84 28 00 00 	lea    0x2884(%rip),%r12        # 403e00 <__frame_dummy_init_array_entry>
  40157c:	55                   	push   %rbp
  40157d:	48 8d 2d 84 28 00 00 	lea    0x2884(%rip),%rbp        # 403e08 <__do_global_dtors_aux_fini_array_entry>
  401584:	53                   	push   %rbx
  401585:	4c 29 e5             	sub    %r12,%rbp
  401588:	48 83 ec 08          	sub    $0x8,%rsp
  40158c:	e8 6f fa ff ff       	call   401000 <_init>
  401591:	48 c1 fd 03          	sar    $0x3,%rbp
  401595:	74 1f                	je     4015b6 <__libc_csu_init+0x56>
  401597:	31 db                	xor    %ebx,%ebx
  401599:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  4015a0:	4c 89 fa             	mov    %r15,%rdx
  4015a3:	4c 89 f6             	mov    %r14,%rsi
  4015a6:	44 89 ef             	mov    %r13d,%edi
  4015a9:	41 ff 14 dc          	call   *(%r12,%rbx,8)
  4015ad:	48 83 c3 01          	add    $0x1,%rbx
  4015b1:	48 39 dd             	cmp    %rbx,%rbp
  4015b4:	75 ea                	jne    4015a0 <__libc_csu_init+0x40>
  4015b6:	48 83 c4 08          	add    $0x8,%rsp
  4015ba:	5b                   	pop    %rbx
  4015bb:	5d                   	pop    %rbp
  4015bc:	41 5c                	pop    %r12
  4015be:	41 5d                	pop    %r13
  4015c0:	41 5e                	pop    %r14
  4015c2:	41 5f                	pop    %r15
  4015c4:	c3                   	ret    

00000000004015c5 <.annobin___libc_csu_fini.start>:
  4015c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4015cc:	00 00 00 00 

00000000004015d0 <__libc_csu_fini>:
  4015d0:	f3 0f 1e fa          	endbr64 
  4015d4:	c3                   	ret    

Disassembly of section .fini:

00000000004015d8 <_fini>:
  4015d8:	f3 0f 1e fa          	endbr64 
  4015dc:	48 83 ec 08          	sub    $0x8,%rsp
  4015e0:	48 83 c4 08          	add    $0x8,%rsp
  4015e4:	c3                   	ret    
