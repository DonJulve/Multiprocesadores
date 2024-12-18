 GNU assembler version 2.38 (x86_64-redhat-linux)
	 using BFD version version 2.38-16.el8.
 options passed	: --64 -adghln=assembler/sepia_filter.gcc.s 
 input file    	: /tmp/ccajxmNK.s
 output file   	: sepia_filter.o
 target        	: x86_64-redhat-linux-gnu
 time stamp    	: 2024-03-21T22:34:30.000+0100

   1              		.file	"sepia_filter.c"
   2              		.text
   3              	.Ltext0:
   4              		.file 1 "sepia_filter.c"
   5              		.section	.rodata.str1.8,"aMS",@progbits,1
   6              		.align 8
   7              	.LC0:
   8 0000 4552524F 		.string	"ERROR: input image has to be RGB"
   8      523A2069 
   8      6E707574 
   8      20696D61 
   8      67652068 
   9              		.section	.rodata.str1.1,"aMS",@progbits,1
  10              	.LC13:
  11 0000 73657069 		.string	"sepiaf_roundf0"
  11      61665F72 
  11      6F756E64 
  11      663000
  12              		.text
  13              		.p2align 4
  14              		.globl	sepia_filter_roundf0
  16              	sepia_filter_roundf0:
  17              	.LVL0:
  18              	.LFB18:
   1:sepia_filter.c **** /* Conversión de imagen RGB a tonos sepia
   2:sepia_filter.c ****  * (implementaciones varias para evaluar su rendimiento) */
   3:sepia_filter.c **** 
   4:sepia_filter.c **** /* Jesús Alastruey Benedé
   5:sepia_filter.c ****  * v2.0, 2-marzo-2021
   6:sepia_filter.c ****  */
   7:sepia_filter.c **** 
   8:sepia_filter.c **** #define _POSIX_C_SOURCE 200112L     /* para evitar el aviso al compilar
   9:sepia_filter.c ****                                        con la función posix_memalign() */
  10:sepia_filter.c **** #include <stdio.h>
  11:sepia_filter.c **** #include <stdlib.h>
  12:sepia_filter.c **** #include <time.h>
  13:sepia_filter.c **** #include <sys/time.h>
  14:sepia_filter.c **** #include <sys/times.h>
  15:sepia_filter.c **** #include <malloc.h>
  16:sepia_filter.c **** #include <math.h>
  17:sepia_filter.c **** #include "jpeg_handler.h"
  18:sepia_filter.c **** #include "include/jpeglib.h"
  19:sepia_filter.c **** #include "sepia_filter.h"
  20:sepia_filter.c **** #include "misc.h"
  21:sepia_filter.c **** 
  22:sepia_filter.c **** 
  23:sepia_filter.c **** int dummy(image_t *im1, image_t *im2);
  24:sepia_filter.c **** //----------------------------------------------------------------------------
  25:sepia_filter.c **** 
  26:sepia_filter.c **** /* factores y desplazamientos para conversión a sepia */
  27:sepia_filter.c **** static const float
  28:sepia_filter.c **** sepia[3][3] = {
  29:sepia_filter.c ****    { 0.393, 0.769, 0.189 },
  30:sepia_filter.c ****    { 0.349, 0.686, 0.168 },
  31:sepia_filter.c ****    { 0.272, 0.534, 0.131 }
  32:sepia_filter.c **** };
  33:sepia_filter.c **** //----------------------------------------------------------------------------
  34:sepia_filter.c **** 
  35:sepia_filter.c **** #define MAXPIXV  255.0f
  36:sepia_filter.c **** //----------------------------------------------------------------------------
  37:sepia_filter.c **** 
  38:sepia_filter.c **** void
  39:sepia_filter.c **** sepia_filter_roundf0(image_t * image_in, image_t * image_out)
  40:sepia_filter.c **** {
  19              		.loc 1 40 1 view -0
  20              		.cfi_startproc
  41:sepia_filter.c ****     double start_t, end_t;
  21              		.loc 1 41 5 view .LVU1
  42:sepia_filter.c ****     const int height = image_in->height;
  22              		.loc 1 42 5 view .LVU2
  40:sepia_filter.c ****     double start_t, end_t;
  23              		.loc 1 40 1 is_stmt 0 view .LVU3
  24 0000 4157     		pushq	%r15
  25              		.cfi_def_cfa_offset 16
  26              		.cfi_offset 15, -16
  27 0002 4156     		pushq	%r14
  28              		.cfi_def_cfa_offset 24
  29              		.cfi_offset 14, -24
  30 0004 4155     		pushq	%r13
  31              		.cfi_def_cfa_offset 32
  32              		.cfi_offset 13, -32
  33 0006 4154     		pushq	%r12
  34              		.cfi_def_cfa_offset 40
  35              		.cfi_offset 12, -40
  36 0008 55       		pushq	%rbp
  37              		.cfi_def_cfa_offset 48
  38              		.cfi_offset 6, -48
  39 0009 53       		pushq	%rbx
  40              		.cfi_def_cfa_offset 56
  41              		.cfi_offset 3, -56
  42 000a 4883EC08 		subq	$8, %rsp
  43              		.cfi_def_cfa_offset 64
  43:sepia_filter.c ****     const int width =  image_in->width;
  44              		.loc 1 43 15 view .LVU4
  45 000e C5FA7E47 		vmovq	8(%rdi), %xmm0
  45      08
  44:sepia_filter.c **** 
  45:sepia_filter.c ****     if (image_in->bytes_per_pixel != 3)
  46              		.loc 1 45 8 view .LVU5
  47 0013 837F1003 		cmpl	$3, 16(%rdi)
  48 0017 C4E37916 		vpextrd	$1, %xmm0, %ebx
  48      C301
  49              	.LVL1:
  43:sepia_filter.c ****     const int width =  image_in->width;
  50              		.loc 1 43 5 is_stmt 1 view .LVU6
  51              		.loc 1 45 5 view .LVU7
  52              		.loc 1 45 8 is_stmt 0 view .LVU8
  53 001d 0F85F901 		jne	.L11
  53      0000
  54 0023 C5F97EC5 		vmovd	%xmm0, %ebp
  46:sepia_filter.c ****     {
  47:sepia_filter.c ****         printf("ERROR: input image has to be RGB\n");
  48:sepia_filter.c ****         exit(-1);
  49:sepia_filter.c ****     }
  50:sepia_filter.c ****     
  51:sepia_filter.c ****     /* fill struct fields */
  52:sepia_filter.c ****     image_out->width  = width;
  55              		.loc 1 52 5 is_stmt 1 view .LVU9
  53:sepia_filter.c ****     image_out->height = height;
  56              		.loc 1 53 5 view .LVU10
  54:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
  57              		.loc 1 54 32 is_stmt 0 view .LVU11
  58 0027 48B80300 		movabsq	$8589934595, %rax
  58      00000200 
  58      0000
  59 0031 48894610 		movq	%rax, 16(%rsi)
  60              	.LVL2:
  61              	.LBB2:
  62              	.LBB3:
  55:sepia_filter.c ****     image_out->color_space = JCS_RGB;
  56:sepia_filter.c **** 
  57:sepia_filter.c ****     start_t = get_wall_time();
  58:sepia_filter.c ****     for (int it = 0; it < NITER; it++)
  59:sepia_filter.c ****     {
  60:sepia_filter.c ****         for (int i = 0; i < height*width; i++)
  63              		.loc 1 60 35 view .LVU12
  64 0035 0FAFEB   		imull	%ebx, %ebp
  65              	.LBE3:
  66              	.LBE2:
  57:sepia_filter.c ****     for (int it = 0; it < NITER; it++)
  67              		.loc 1 57 15 view .LVU13
  68 0038 31C0     		xorl	%eax, %eax
  52:sepia_filter.c ****     image_out->height = height;
  69              		.loc 1 52 23 view .LVU14
  70 003a C5F9D646 		vmovq	%xmm0, 8(%rsi)
  70      08
  54:sepia_filter.c ****     image_out->color_space = JCS_RGB;
  71              		.loc 1 54 5 is_stmt 1 view .LVU15
  55:sepia_filter.c **** 
  72              		.loc 1 55 5 view .LVU16
  57:sepia_filter.c ****     for (int it = 0; it < NITER; it++)
  73              		.loc 1 57 5 view .LVU17
  74 003f 4989FE   		movq	%rdi, %r14
  75 0042 4989F4   		movq	%rsi, %r12
  57:sepia_filter.c ****     for (int it = 0; it < NITER; it++)
  76              		.loc 1 57 15 is_stmt 0 view .LVU18
  77 0045 E8000000 		call	get_wall_time
  77      00
  78              	.LVL3:
  57:sepia_filter.c ****     for (int it = 0; it < NITER; it++)
  79              		.loc 1 57 15 view .LVU19
  80 004a 4863C5   		movslq	%ebp, %rax
  81 004d C57A1025 		vmovss	.LC1(%rip), %xmm12
  81      00000000 
  82              	.LBB6:
  83              	.LBB4:
  61:sepia_filter.c ****         {
  62:sepia_filter.c ****             /* R */
  63:sepia_filter.c ****             image_out->pixels[3*i + 0] = roundf(
  64:sepia_filter.c ****                 fminf(MAXPIXV,
  65:sepia_filter.c ****                           sepia[0][0]*image_in->pixels[3*i + 0] + 
  66:sepia_filter.c ****                           sepia[0][1]*image_in->pixels[3*i + 1] + 
  67:sepia_filter.c ****                           sepia[0][2]*image_in->pixels[3*i + 2]));
  68:sepia_filter.c ****             /* G */
  69:sepia_filter.c ****             image_out->pixels[3*i + 1] = roundf(
  70:sepia_filter.c ****                 fminf(MAXPIXV,
  71:sepia_filter.c ****                           sepia[1][0]*image_in->pixels[3*i + 0] + 
  72:sepia_filter.c ****                           sepia[1][1]*image_in->pixels[3*i + 1] + 
  73:sepia_filter.c ****                           sepia[1][2]*image_in->pixels[3*i + 2]));
  74:sepia_filter.c ****             /* B */
  75:sepia_filter.c ****             image_out->pixels[3*i + 2] = roundf(
  84              		.loc 1 75 40 view .LVU20
  85 0055 C5FA101D 		vmovss	.LC5(%rip), %xmm3
  85      00000000 
  86              	.LBE4:
  87              	.LBE6:
  57:sepia_filter.c ****     for (int it = 0; it < NITER; it++)
  88              		.loc 1 57 15 view .LVU21
  89 005d C4C1F97E 		vmovq	%xmm0, %r15
  89      C7
  90              	.LVL4:
  58:sepia_filter.c ****     {
  91              		.loc 1 58 5 is_stmt 1 view .LVU22
  92              	.LBB7:
  58:sepia_filter.c ****     {
  93              		.loc 1 58 10 view .LVU23
  58:sepia_filter.c ****     {
  94              		.loc 1 58 25 view .LVU24
  95 0062 4C8D2C40 		leaq	(%rax,%rax,2), %r13
  96              	.LBB5:
  60:sepia_filter.c ****         {
  97              		.loc 1 60 35 is_stmt 0 view .LVU25
  98 0066 BB0A0000 		movl	$10, %ebx
  98      00
  99 006b C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
 100              	.LVL5:
 101 006f 90       		.p2align 4,,10
 102              		.p2align 3
 103              	.L3:
  60:sepia_filter.c ****         {
 104              		.loc 1 60 27 is_stmt 1 view .LVU26
 105 0070 85ED     		testl	%ebp, %ebp
 106 0072 0F8E5301 		jle	.L6
 106      0000
 107 0078 C57A101D 		vmovss	.LC2(%rip), %xmm11
 107      00000000 
 108 0080 C57A1015 		vmovss	.LC3(%rip), %xmm10
 108      00000000 
 109 0088 C5FA1015 		vmovss	.LC4(%rip), %xmm2
 109      00000000 
 110 0090 C57A103D 		vmovss	.LC5(%rip), %xmm15
 110      00000000 
 111 0098 C57A100D 		vmovss	.LC7(%rip), %xmm9
 111      00000000 
 112 00a0 C57A1005 		vmovss	.LC8(%rip), %xmm8
 112      00000000 
 113 00a8 C5FA103D 		vmovss	.LC9(%rip), %xmm7
 113      00000000 
 114 00b0 C5FA1035 		vmovss	.LC10(%rip), %xmm6
 114      00000000 
 115 00b8 C5FA102D 		vmovss	.LC11(%rip), %xmm5
 115      00000000 
 116 00c0 C5FA1025 		vmovss	.LC12(%rip), %xmm4
 116      00000000 
  63:sepia_filter.c ****                 fminf(MAXPIXV,
 117              		.loc 1 63 40 is_stmt 0 view .LVU27
 118 00c8 C57A102D 		vmovss	.LC6(%rip), %xmm13
 118      00000000 
  60:sepia_filter.c ****         {
 119              		.loc 1 60 27 view .LVU28
 120 00d0 31C0     		xorl	%eax, %eax
 121              	.LVL6:
 122              		.p2align 4,,10
 123 00d2 660F1F44 		.p2align 3
 123      0000
 124              	.L4:
  63:sepia_filter.c ****                 fminf(MAXPIXV,
 125              		.loc 1 63 13 is_stmt 1 discriminator 3 view .LVU29
  65:sepia_filter.c ****                           sepia[0][1]*image_in->pixels[3*i + 1] + 
 126              		.loc 1 65 27 is_stmt 0 discriminator 3 view .LVU30
 127 00d8 498B16   		movq	(%r14), %rdx
  65:sepia_filter.c ****                           sepia[0][1]*image_in->pixels[3*i + 1] + 
 128              		.loc 1 65 55 discriminator 3 view .LVU31
 129 00db 0FB60C02 		movzbl	(%rdx,%rax), %ecx
  65:sepia_filter.c ****                           sepia[0][1]*image_in->pixels[3*i + 1] + 
 130              		.loc 1 65 38 discriminator 3 view .LVU32
 131 00df C5F22AC1 		vcvtsi2ssl	%ecx, %xmm1, %xmm0
  66:sepia_filter.c ****                           sepia[0][2]*image_in->pixels[3*i + 2]));
 132              		.loc 1 66 55 discriminator 3 view .LVU33
 133 00e3 0FB64C02 		movzbl	1(%rdx,%rax), %ecx
 133      01
  67:sepia_filter.c ****             /* G */
 134              		.loc 1 67 55 discriminator 3 view .LVU34
 135 00e8 0FB65402 		movzbl	2(%rdx,%rax), %edx
 135      02
  66:sepia_filter.c ****                           sepia[0][2]*image_in->pixels[3*i + 2]));
 136              		.loc 1 66 38 discriminator 3 view .LVU35
 137 00ed C5722AF1 		vcvtsi2ssl	%ecx, %xmm1, %xmm14
 138 00f1 C4410A59 		vmulss	%xmm12, %xmm14, %xmm14
 138      F4
 139 00f6 C44279B9 		vfmadd231ss	%xmm11, %xmm0, %xmm14
 139      F3
  67:sepia_filter.c ****             /* G */
 140              		.loc 1 67 38 discriminator 3 view .LVU36
 141 00fb C5F22AC2 		vcvtsi2ssl	%edx, %xmm1, %xmm0
  63:sepia_filter.c ****                 fminf(MAXPIXV,
 142              		.loc 1 63 40 discriminator 3 view .LVU37
 143 00ff 498B1424 		movq	(%r12), %rdx
 144 0103 C4C20999 		vfmadd132ss	%xmm10, %xmm14, %xmm0
 144      C2
 145 0108 C5FA5DC2 		vminss	%xmm2, %xmm0, %xmm0
 146 010c C51054F0 		vandps	%xmm0, %xmm13, %xmm14
 147 0110 C4410056 		vorps	%xmm14, %xmm15, %xmm14
 147      F6
 148 0115 C58A58C0 		vaddss	%xmm0, %xmm14, %xmm0
 149 0119 C5FA2CC8 		vcvttss2sil	%xmm0, %ecx
 150 011d 880C02   		movb	%cl, (%rdx,%rax)
  69:sepia_filter.c ****                 fminf(MAXPIXV,
 151              		.loc 1 69 13 is_stmt 1 discriminator 3 view .LVU38
  71:sepia_filter.c ****                           sepia[1][1]*image_in->pixels[3*i + 1] + 
 152              		.loc 1 71 27 is_stmt 0 discriminator 3 view .LVU39
 153 0120 498B16   		movq	(%r14), %rdx
  71:sepia_filter.c ****                           sepia[1][1]*image_in->pixels[3*i + 1] + 
 154              		.loc 1 71 55 discriminator 3 view .LVU40
 155 0123 0FB60C02 		movzbl	(%rdx,%rax), %ecx
  71:sepia_filter.c ****                           sepia[1][1]*image_in->pixels[3*i + 1] + 
 156              		.loc 1 71 38 discriminator 3 view .LVU41
 157 0127 C5F22AC1 		vcvtsi2ssl	%ecx, %xmm1, %xmm0
  72:sepia_filter.c ****                           sepia[1][2]*image_in->pixels[3*i + 2]));
 158              		.loc 1 72 55 discriminator 3 view .LVU42
 159 012b 0FB64C02 		movzbl	1(%rdx,%rax), %ecx
 159      01
  73:sepia_filter.c ****             /* B */
 160              		.loc 1 73 55 discriminator 3 view .LVU43
 161 0130 0FB65402 		movzbl	2(%rdx,%rax), %edx
 161      02
  72:sepia_filter.c ****                           sepia[1][2]*image_in->pixels[3*i + 2]));
 162              		.loc 1 72 38 discriminator 3 view .LVU44
 163 0135 C5722AF1 		vcvtsi2ssl	%ecx, %xmm1, %xmm14
 164 0139 C4410A59 		vmulss	%xmm9, %xmm14, %xmm14
 164      F1
 165 013e C44279B9 		vfmadd231ss	%xmm8, %xmm0, %xmm14
 165      F0
  73:sepia_filter.c ****             /* B */
 166              		.loc 1 73 38 discriminator 3 view .LVU45
 167 0143 C5F22AC2 		vcvtsi2ssl	%edx, %xmm1, %xmm0
  69:sepia_filter.c ****                 fminf(MAXPIXV,
 168              		.loc 1 69 40 discriminator 3 view .LVU46
 169 0147 498B1424 		movq	(%r12), %rdx
 170 014b C4E20999 		vfmadd132ss	%xmm7, %xmm14, %xmm0
 170      C7
 171 0150 C57A1035 		vmovss	.LC5(%rip), %xmm14
 171      00000000 
 172 0158 C5FA5DC2 		vminss	%xmm2, %xmm0, %xmm0
 173 015c C51054F8 		vandps	%xmm0, %xmm13, %xmm15
 174 0160 C4410856 		vorps	%xmm15, %xmm14, %xmm14
 174      F7
 175 0165 C50A58F0 		vaddss	%xmm0, %xmm14, %xmm14
 176              		.loc 1 75 40 discriminator 3 view .LVU47
 177 0169 C57828FB 		vmovaps	%xmm3, %xmm15
  69:sepia_filter.c ****                 fminf(MAXPIXV,
 178              		.loc 1 69 40 discriminator 3 view .LVU48
 179 016d C4C17A2C 		vcvttss2sil	%xmm14, %ecx
 179      CE
 180 0172 884C0201 		movb	%cl, 1(%rdx,%rax)
 181              		.loc 1 75 13 is_stmt 1 discriminator 3 view .LVU49
  76:sepia_filter.c ****                 fminf(MAXPIXV,
  77:sepia_filter.c ****                           sepia[2][0]*image_in->pixels[3*i + 0] + 
 182              		.loc 1 77 27 is_stmt 0 discriminator 3 view .LVU50
 183 0176 498B16   		movq	(%r14), %rdx
 184              		.loc 1 77 55 discriminator 3 view .LVU51
 185 0179 0FB60C02 		movzbl	(%rdx,%rax), %ecx
 186              		.loc 1 77 38 discriminator 3 view .LVU52
 187 017d C5F22AC1 		vcvtsi2ssl	%ecx, %xmm1, %xmm0
  78:sepia_filter.c ****                           sepia[2][1]*image_in->pixels[3*i + 1] + 
 188              		.loc 1 78 55 discriminator 3 view .LVU53
 189 0181 0FB64C02 		movzbl	1(%rdx,%rax), %ecx
 189      01
  79:sepia_filter.c ****                           sepia[2][2]*image_in->pixels[3*i + 2]));
 190              		.loc 1 79 55 discriminator 3 view .LVU54
 191 0186 0FB65402 		movzbl	2(%rdx,%rax), %edx
 191      02
  78:sepia_filter.c ****                           sepia[2][1]*image_in->pixels[3*i + 1] + 
 192              		.loc 1 78 38 discriminator 3 view .LVU55
 193 018b C5722AF1 		vcvtsi2ssl	%ecx, %xmm1, %xmm14
 194 018f C50A59F6 		vmulss	%xmm6, %xmm14, %xmm14
 195 0193 C46279B9 		vfmadd231ss	%xmm5, %xmm0, %xmm14
 195      F5
 196              		.loc 1 79 38 discriminator 3 view .LVU56
 197 0198 C5F22AC2 		vcvtsi2ssl	%edx, %xmm1, %xmm0
  75:sepia_filter.c ****                 fminf(MAXPIXV,
 198              		.loc 1 75 40 discriminator 3 view .LVU57
 199 019c 498B1424 		movq	(%r12), %rdx
 200 01a0 C4E20999 		vfmadd132ss	%xmm4, %xmm14, %xmm0
 200      C4
 201 01a5 C5FA5DC2 		vminss	%xmm2, %xmm0, %xmm0
 202 01a9 C51054F0 		vandps	%xmm0, %xmm13, %xmm14
 203 01ad C4416056 		vorps	%xmm14, %xmm3, %xmm14
 203      F6
 204 01b2 C58A58C0 		vaddss	%xmm0, %xmm14, %xmm0
 205 01b6 C5FA2CC8 		vcvttss2sil	%xmm0, %ecx
 206 01ba 884C0202 		movb	%cl, 2(%rdx,%rax)
  60:sepia_filter.c ****         {
 207              		.loc 1 60 44 is_stmt 1 discriminator 3 view .LVU58
 208              	.LVL7:
  60:sepia_filter.c ****         {
 209              		.loc 1 60 27 discriminator 3 view .LVU59
 210 01be 4883C003 		addq	$3, %rax
 211              	.LVL8:
  60:sepia_filter.c ****         {
 212              		.loc 1 60 27 is_stmt 0 discriminator 3 view .LVU60
 213 01c2 4C39E8   		cmpq	%r13, %rax
 214 01c5 0F850DFF 		jne	.L4
 214      FFFF
 215              	.LVL9:
 216              	.L6:
  60:sepia_filter.c ****         {
 217              		.loc 1 60 27 discriminator 3 view .LVU61
 218              	.LBE5:
  80:sepia_filter.c ****         }
  81:sepia_filter.c ****         dummy(image_in, image_out);
 219              		.loc 1 81 9 is_stmt 1 view .LVU62
 220 01cb 4C89E6   		movq	%r12, %rsi
 221 01ce 4C89F7   		movq	%r14, %rdi
 222 01d1 E8000000 		call	dummy
 222      00
 223              	.LVL10:
  58:sepia_filter.c ****     {
 224              		.loc 1 58 36 view .LVU63
  58:sepia_filter.c ****     {
 225              		.loc 1 58 25 view .LVU64
 226 01d6 FFCB     		decl	%ebx
 227 01d8 C57A1025 		vmovss	.LC1(%rip), %xmm12
 227      00000000 
 228 01e0 C5FA101D 		vmovss	.LC5(%rip), %xmm3
 228      00000000 
 229 01e8 C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
 230 01ec 0F857EFE 		jne	.L3
 230      FFFF
 231              	.LBE7:
  82:sepia_filter.c ****     }
  83:sepia_filter.c ****     end_t = get_wall_time();
 232              		.loc 1 83 5 view .LVU65
 233              		.loc 1 83 13 is_stmt 0 view .LVU66
 234 01f2 31C0     		xorl	%eax, %eax
 235 01f4 E8000000 		call	get_wall_time
 235      00
 236              	.LVL11:
  84:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_roundf0");
 237              		.loc 1 84 5 is_stmt 1 view .LVU67
  85:sepia_filter.c **** }
 238              		.loc 1 85 1 is_stmt 0 view .LVU68
 239 01f9 4883C408 		addq	$8, %rsp
 240              		.cfi_remember_state
 241              		.cfi_def_cfa_offset 56
 242 01fd 5B       		popq	%rbx
 243              		.cfi_def_cfa_offset 48
  84:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_roundf0");
 244              		.loc 1 84 5 view .LVU69
 245 01fe 89EF     		movl	%ebp, %edi
 246              		.loc 1 85 1 view .LVU70
 247 0200 5D       		popq	%rbp
 248              		.cfi_def_cfa_offset 40
 249 0201 415C     		popq	%r12
 250              		.cfi_def_cfa_offset 32
 251              	.LVL12:
  84:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_roundf0");
 252              		.loc 1 84 5 view .LVU71
 253 0203 C4C1F96E 		vmovq	%r15, %xmm4
 253      E7
 254              		.loc 1 85 1 view .LVU72
 255 0208 415D     		popq	%r13
 256              		.cfi_def_cfa_offset 24
  84:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_roundf0");
 257              		.loc 1 84 5 view .LVU73
 258 020a C5FB5CC4 		vsubsd	%xmm4, %xmm0, %xmm0
 259              	.LVL13:
 260              		.loc 1 85 1 view .LVU74
 261 020e 415E     		popq	%r14
 262              		.cfi_def_cfa_offset 16
 263              	.LVL14:
  84:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_roundf0");
 264              		.loc 1 84 5 view .LVU75
 265 0210 BE000000 		movl	$.LC13, %esi
 265      00
 266              		.loc 1 85 1 view .LVU76
 267 0215 415F     		popq	%r15
 268              		.cfi_def_cfa_offset 8
 269              	.LVL15:
  84:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_roundf0");
 270              		.loc 1 84 5 view .LVU77
 271 0217 E9000000 		jmp	results
 271      00
 272              	.LVL16:
 273              	.L11:
 274              		.cfi_restore_state
  47:sepia_filter.c ****         exit(-1);
 275              		.loc 1 47 9 is_stmt 1 view .LVU78
 276 021c BF000000 		movl	$.LC0, %edi
 276      00
 277              	.LVL17:
  47:sepia_filter.c ****         exit(-1);
 278              		.loc 1 47 9 is_stmt 0 view .LVU79
 279 0221 E8000000 		call	puts
 279      00
 280              	.LVL18:
  48:sepia_filter.c ****     }
 281              		.loc 1 48 9 is_stmt 1 view .LVU80
 282 0226 83CFFF   		orl	$-1, %edi
 283 0229 E8000000 		call	exit
 283      00
 284              	.LVL19:
 285              		.cfi_endproc
 286              	.LFE18:
 288              		.section	.rodata.str1.1
 289              	.LC100:
 290 000f 73657069 		.string	"sepiaf_roundf1"
 290      61665F72 
 290      6F756E64 
 290      663100
 291              		.text
 292 022e 6690     		.p2align 4
 293              		.globl	sepia_filter_roundf1
 295              	sepia_filter_roundf1:
 296              	.LVL20:
 297              	.LFB19:
  86:sepia_filter.c **** //----------------------------------------------------------------------------
  87:sepia_filter.c **** 
  88:sepia_filter.c **** /* cambios respecto sepia_filter_roundf_0(): restricts, #pragma GCC ivdep */
  89:sepia_filter.c **** void
  90:sepia_filter.c **** sepia_filter_roundf1(image_t * restrict image_in, image_t * restrict image_out)
  91:sepia_filter.c **** {
 298              		.loc 1 91 1 view -0
 299              		.cfi_startproc
  92:sepia_filter.c ****     double start_t, end_t;
 300              		.loc 1 92 5 view .LVU82
  93:sepia_filter.c ****     const int height = image_in->height;
 301              		.loc 1 93 5 view .LVU83
  91:sepia_filter.c ****     double start_t, end_t;
 302              		.loc 1 91 1 is_stmt 0 view .LVU84
 303 0230 4155     		pushq	%r13
 304              		.cfi_def_cfa_offset 16
 305              		.cfi_offset 13, -16
 306 0232 4C8D6C24 		leaq	16(%rsp), %r13
 306      10
 307              		.cfi_def_cfa 13, 0
 308 0237 4883E4E0 		andq	$-32, %rsp
 309 023b 41FF75F8 		pushq	-8(%r13)
 310 023f 55       		pushq	%rbp
 311 0240 4889E5   		movq	%rsp, %rbp
 312              		.cfi_escape 0x10,0x6,0x2,0x76,0
 313 0243 4157     		pushq	%r15
 314 0245 4156     		pushq	%r14
 315 0247 4155     		pushq	%r13
 316              		.cfi_escape 0xf,0x3,0x76,0x68,0x6
 317              		.cfi_escape 0x10,0xf,0x2,0x76,0x78
 318              		.cfi_escape 0x10,0xe,0x2,0x76,0x70
 319 0249 4154     		pushq	%r12
 320 024b 53       		pushq	%rbx
 321 024c 4881EC08 		subq	$264, %rsp
 321      010000
 322              		.cfi_escape 0x10,0xc,0x2,0x76,0x60
 323              		.cfi_escape 0x10,0x3,0x2,0x76,0x58
  94:sepia_filter.c ****     const int width =  image_in->width;
 324              		.loc 1 94 15 view .LVU85
 325 0253 C5FA7E47 		vmovq	8(%rdi), %xmm0
 325      08
  95:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
  96:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
  97:sepia_filter.c **** 
  98:sepia_filter.c ****     if (image_in->bytes_per_pixel != 3)
 326              		.loc 1 98 8 view .LVU86
 327 0258 837F1003 		cmpl	$3, 16(%rdi)
  91:sepia_filter.c ****     double start_t, end_t;
 328              		.loc 1 91 1 view .LVU87
 329 025c 4889BDF0 		movq	%rdi, -272(%rbp)
 329      FEFFFF
 330 0263 4889B5F8 		movq	%rsi, -264(%rbp)
 330      FEFFFF
  95:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 331              		.loc 1 95 30 view .LVU88
 332 026a 4C8B2F   		movq	(%rdi), %r13
  96:sepia_filter.c **** 
 333              		.loc 1 96 30 view .LVU89
 334 026d 4C8B36   		movq	(%rsi), %r14
 335 0270 C4C37916 		vpextrd	$1, %xmm0, %r15d
 335      C701
 336              	.LVL21:
  94:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 337              		.loc 1 94 5 is_stmt 1 view .LVU90
  95:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
 338              		.loc 1 95 5 view .LVU91
  96:sepia_filter.c **** 
 339              		.loc 1 96 5 view .LVU92
 340              		.loc 1 98 5 view .LVU93
 341              		.loc 1 98 8 is_stmt 0 view .LVU94
 342 0276 0F85DF0E 		jne	.L38
 342      0000
 343 027c C4C1797E 		vmovd	%xmm0, %r12d
 343      C4
  99:sepia_filter.c ****     {
 100:sepia_filter.c ****         printf("ERROR: input image has to be RGB\n");
 101:sepia_filter.c ****         exit(-1);
 102:sepia_filter.c ****     }
 103:sepia_filter.c ****     
 104:sepia_filter.c ****     /* fill struct fields */
 105:sepia_filter.c ****     image_out->width  = width;
 344              		.loc 1 105 5 is_stmt 1 view .LVU95
 106:sepia_filter.c ****     image_out->height = height;
 345              		.loc 1 106 5 view .LVU96
 107:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
 346              		.loc 1 107 32 is_stmt 0 view .LVU97
 347 0281 48BB0300 		movabsq	$8589934595, %rbx
 347      00000200 
 347      0000
 348              	.LBB8:
 349              	.LBB9:
 108:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 109:sepia_filter.c **** 
 110:sepia_filter.c ****     start_t = get_wall_time();
 111:sepia_filter.c ****     for (int it=0; it < NITER; it++)
 112:sepia_filter.c ****     {
 113:sepia_filter.c ****         #pragma GCC ivdep
 114:sepia_filter.c ****         for (int i = 0; i < height*width; i++)
 350              		.loc 1 114 35 view .LVU98
 351 028b 450FAFFC 		imull	%r12d, %r15d
 352              	.LBE9:
 353              	.LBE8:
 107:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
 354              		.loc 1 107 32 view .LVU99
 355 028f 48895E10 		movq	%rbx, 16(%rsi)
 110:sepia_filter.c ****     for (int it=0; it < NITER; it++)
 356              		.loc 1 110 15 view .LVU100
 357 0293 31C0     		xorl	%eax, %eax
 105:sepia_filter.c ****     image_out->height = height;
 358              		.loc 1 105 23 view .LVU101
 359 0295 C5F9D646 		vmovq	%xmm0, 8(%rsi)
 359      08
 107:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 360              		.loc 1 107 5 is_stmt 1 view .LVU102
 108:sepia_filter.c **** 
 361              		.loc 1 108 5 view .LVU103
 110:sepia_filter.c ****     for (int it=0; it < NITER; it++)
 362              		.loc 1 110 5 view .LVU104
 110:sepia_filter.c ****     for (int it=0; it < NITER; it++)
 363              		.loc 1 110 15 is_stmt 0 view .LVU105
 364 029a E8000000 		call	get_wall_time
 364      00
 365              	.LVL22:
 110:sepia_filter.c ****     for (int it=0; it < NITER; it++)
 366              		.loc 1 110 15 view .LVU106
 367 029f 418D47FF 		leal	-1(%r15), %eax
 368 02a3 8985ECFE 		movl	%eax, -276(%rbp)
 368      FFFF
 369 02a9 4489F8   		movl	%r15d, %eax
 370 02ac C1E805   		shrl	$5, %eax
 371 02af 488D0C40 		leaq	(%rax,%rax,2), %rcx
 372 02b3 4489F8   		movl	%r15d, %eax
 373 02b6 83E0E0   		andl	$-32, %eax
 374 02b9 8985E8FE 		movl	%eax, -280(%rbp)
 374      FFFF
 375 02bf 48C1E105 		salq	$5, %rcx
 376 02c3 C5FB1185 		vmovsd	%xmm0, -288(%rbp)
 376      E0FEFFFF 
 377              	.LVL23:
 111:sepia_filter.c ****     {
 378              		.loc 1 111 5 is_stmt 1 view .LVU107
 379              	.LBB13:
 111:sepia_filter.c ****     {
 380              		.loc 1 111 10 view .LVU108
 111:sepia_filter.c ****     {
 381              		.loc 1 111 23 view .LVU109
 382 02cb 4E8D2429 		leaq	(%rcx,%r13), %r12
 383              	.LBB10:
 384              		.loc 1 114 35 is_stmt 0 view .LVU110
 385 02cf BB0A0000 		movl	$10, %ebx
 385      00
 386              	.LVL24:
 387              	.L14:
 388              		.loc 1 114 9 is_stmt 1 view .LVU111
 389 02d4 4585FF   		testl	%r15d, %r15d
 390 02d7 0F8E380E 		jle	.L35
 390      0000
 391              	.LVL25:
 392 02dd 0F1F00   		.p2align 4,,10
 393              		.p2align 3
 394              	.L23:
 395              		.loc 1 114 9 is_stmt 0 view .LVU112
 396 02e0 83BDECFE 		cmpl	$30, -276(%rbp)
 396      FFFF1E
 397 02e7 0F86450E 		jbe	.L25
 397      0000
 115:sepia_filter.c ****         {
 116:sepia_filter.c ****             /* R */
 117:sepia_filter.c ****             pixels_out[3*i + 0] = roundf(fminf(MAXPIXV,
 398              		.loc 1 117 33 view .LVU113
 399 02ed BEFFFF00 		movl	$65535, %esi
 399      00
 400 02f2 C5796ED6 		vmovd	%esi, %xmm10
 401 02f6 BEFF0000 		movl	$255, %esi
 401      00
 402 02fb C5F96EEE 		vmovd	%esi, %xmm5
 403 02ff C4E27D79 		vpbroadcastw	%xmm5, %ymm5
 403      ED
 404 0304 C4627D18 		vbroadcastss	.LC5(%rip), %ymm12
 404      25000000 
 404      00
 405 030d C4627D18 		vbroadcastss	.LC14(%rip), %ymm11
 405      1D000000 
 405      00
 406 0316 4C89F1   		movq	%r14, %rcx
 407              	.LBE10:
 408              	.LBE13:
  91:sepia_filter.c ****     double start_t, end_t;
 409              		.loc 1 91 1 view .LVU114
 410 0319 4C89E8   		movq	%r13, %rax
 411              	.LBB14:
 412              	.LBB11:
 413              		.loc 1 117 33 view .LVU115
 414 031c C4427D58 		vpbroadcastd	%xmm10, %ymm10
 414      D2
 415 0321 C5FD7F6D 		vmovdqa	%ymm5, -112(%rbp)
 415      90
 416 0326 662E0F1F 		.p2align 4,,10
 416      84000000 
 416      0000
 417              		.p2align 3
 418              	.L16:
 419              		.loc 1 117 13 is_stmt 1 discriminator 3 view .LVU116
 118:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 420              		.loc 1 118 48 is_stmt 0 discriminator 3 view .LVU117
 421 0330 C5FE6F00 		vmovdqu	(%rax), %ymm0
 422 0334 C5FE6F58 		vmovdqu	32(%rax), %ymm3
 422      20
 423 0339 C4E27D00 		vpshufb	.LC15(%rip), %ymm0, %ymm4
 423      25000000 
 423      00
 424 0342 C5FE6F50 		vmovdqu	64(%rax), %ymm2
 424      40
 425 0347 C4E27D00 		vpshufb	.LC16(%rip), %ymm0, %ymm1
 425      0D000000 
 425      00
 426 0350 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 426      E44E
 427 0356 C4E26500 		vpshufb	.LC17(%rip), %ymm3, %ymm5
 427      2D000000 
 427      00
 428 035f C5F5EBCC 		vpor	%ymm4, %ymm1, %ymm1
 429 0363 C5F5EBCD 		vpor	%ymm5, %ymm1, %ymm1
 430 0367 C4E26D00 		vpshufb	.LC18(%rip), %ymm2, %ymm5
 430      2D000000 
 430      00
 431 0370 C4E26D00 		vpshufb	.LC20(%rip), %ymm2, %ymm4
 431      25000000 
 431      00
 432 0379 C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 432      ED4E
 433 037f C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 434 0383 C4E27500 		vpshufb	.LC19(%rip), %ymm1, %ymm1
 434      0D000000 
 434      00
 435 038c C5F5EBCC 		vpor	%ymm4, %ymm1, %ymm1
 436 0390 C4E27D00 		vpshufb	.LC21(%rip), %ymm0, %ymm4
 436      25000000 
 436      00
 437 0399 C4E27D00 		vpshufb	.LC22(%rip), %ymm0, %ymm6
 437      35000000 
 437      00
 438 03a2 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 438      E44E
 439 03a8 C4E26500 		vpshufb	.LC23(%rip), %ymm3, %ymm5
 439      2D000000 
 439      00
 440 03b1 C5CDEBF4 		vpor	%ymm4, %ymm6, %ymm6
 441 03b5 C5CDEBF5 		vpor	%ymm5, %ymm6, %ymm6
 442 03b9 C4E26D00 		vpshufb	.LC24(%rip), %ymm2, %ymm5
 442      2D000000 
 442      00
 443 03c2 C4E26D00 		vpshufb	.LC26(%rip), %ymm2, %ymm4
 443      25000000 
 443      00
 444 03cb C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 444      ED4E
 445 03d1 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 446 03d5 C4E24D00 		vpshufb	.LC25(%rip), %ymm6, %ymm6
 446      35000000 
 446      00
 447 03de C5CDEBF4 		vpor	%ymm4, %ymm6, %ymm6
 448 03e2 C4E27D00 		vpshufb	.LC27(%rip), %ymm0, %ymm4
 448      25000000 
 448      00
 449 03eb C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 449      E44E
 450 03f1 C4E27D00 		vpshufb	.LC28(%rip), %ymm0, %ymm0
 450      05000000 
 450      00
 451 03fa C4E26500 		vpshufb	.LC29(%rip), %ymm3, %ymm3
 451      1D000000 
 451      00
 452 0403 C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 453 0407 C5FDEBC3 		vpor	%ymm3, %ymm0, %ymm0
 454 040b C4E26D00 		vpshufb	.LC30(%rip), %ymm2, %ymm3
 454      1D000000 
 454      00
 455 0414 C4E3FD00 		vpermq	$78, %ymm3, %ymm3
 455      DB4E
 456 041a C4E26D00 		vpshufb	.LC31(%rip), %ymm2, %ymm2
 456      15000000 
 456      00
 457 0423 C5EDEBD3 		vpor	%ymm3, %ymm2, %ymm2
 458 0427 C4E27D00 		vpshufb	.LC25(%rip), %ymm0, %ymm0
 458      05000000 
 458      00
 459 0430 C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 460 0434 C4E27D30 		vpmovzxbw	%xmm1, %ymm2
 460      D1
 461 0439 C4E27D33 		vpmovzxwd	%xmm2, %ymm3
 461      DA
 462 043e C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 462      C901
 463 0444 C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 463      D201
 464 044a C4E27D30 		vpmovzxbw	%xmm1, %ymm1
 464      C9
 465 044f C4E27D33 		vpmovzxwd	%xmm2, %ymm2
 465      D2
 466              		.loc 1 118 38 discriminator 3 view .LVU118
 467 0454 C5FC5BFB 		vcvtdq2ps	%ymm3, %ymm7
 468 0458 C5FC5BDA 		vcvtdq2ps	%ymm2, %ymm3
 469              		.loc 1 118 48 discriminator 3 view .LVU119
 470 045c C4E27D33 		vpmovzxwd	%xmm1, %ymm2
 470      D1
 471 0461 C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 471      C901
 472 0467 C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 472      C9
 473              		.loc 1 118 38 discriminator 3 view .LVU120
 474 046c C57C5BF9 		vcvtdq2ps	%ymm1, %ymm15
 119:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 475              		.loc 1 119 48 discriminator 3 view .LVU121
 476 0470 C4E27D30 		vpmovzxbw	%xmm6, %ymm1
 476      CE
 477 0475 C4627D33 		vpmovzxwd	%xmm1, %ymm13
 477      E9
 478 047a C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 478      C901
 120:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 479              		.loc 1 120 48 discriminator 3 view .LVU122
 480 0480 C4627D30 		vpmovzxbw	%xmm0, %ymm9
 480      C8
 119:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 481              		.loc 1 119 48 discriminator 3 view .LVU123
 482 0485 C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 482      C9
 483              		.loc 1 120 48 discriminator 3 view .LVU124
 484 048a C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 484      C001
 485 0490 C4E27D30 		vpmovzxbw	%xmm0, %ymm0
 485      C0
 119:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 486              		.loc 1 119 38 discriminator 3 view .LVU125
 487 0495 C5FC5BE9 		vcvtdq2ps	%ymm1, %ymm5
 488 0499 C5FC296D 		vmovaps	%ymm5, -80(%rbp)
 488      B0
 489              		.loc 1 120 48 discriminator 3 view .LVU126
 490 049e C4627D33 		vpmovzxwd	%xmm0, %ymm14
 490      F0
 491 04a3 C4E37D39 		vextracti128	$0x1, %ymm0, %xmm5
 491      C501
 119:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 492              		.loc 1 119 38 discriminator 3 view .LVU127
 493 04a9 C5FC2845 		vmovaps	-80(%rbp), %ymm0
 493      B0
 119:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 494              		.loc 1 119 48 discriminator 3 view .LVU128
 495 04ae C4E37D39 		vextracti128	$0x1, %ymm6, %xmm6
 495      F601
 119:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 496              		.loc 1 119 38 discriminator 3 view .LVU129
 497 04b4 C5FC5905 		vmulps	.LC32(%rip), %ymm0, %ymm0
 497      00000000 
 119:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 498              		.loc 1 119 48 discriminator 3 view .LVU130
 499 04bc C4E27D30 		vpmovzxbw	%xmm6, %ymm6
 499      F6
 119:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 500              		.loc 1 119 38 discriminator 3 view .LVU131
 501 04c1 C4417C5B 		vcvtdq2ps	%ymm13, %ymm13
 501      ED
 119:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 502              		.loc 1 119 48 discriminator 3 view .LVU132
 503 04c6 C4E27D33 		vpmovzxwd	%xmm6, %ymm4
 503      E6
 119:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 504              		.loc 1 119 38 discriminator 3 view .LVU133
 505 04cb C594590D 		vmulps	.LC32(%rip), %ymm13, %ymm1
 505      00000000 
 506 04d3 C4E265B8 		vfmadd231ps	.LC33(%rip), %ymm3, %ymm0
 506      05000000 
 506      00
 507 04dc C5FC5BE4 		vcvtdq2ps	%ymm4, %ymm4
 508 04e0 C5FC299D 		vmovaps	%ymm3, -176(%rbp)
 508      50FFFFFF 
 509 04e8 C5DC591D 		vmulps	.LC32(%rip), %ymm4, %ymm3
 509      00000000 
 119:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 510              		.loc 1 119 48 discriminator 3 view .LVU134
 511 04f0 C4E37D39 		vextracti128	$0x1, %ymm6, %xmm6
 511      F601
 512 04f6 C4E245B8 		vfmadd231ps	.LC33(%rip), %ymm7, %ymm1
 512      0D000000 
 512      00
 513 04ff C4E27D33 		vpmovzxwd	%xmm6, %ymm6
 513      F6
 118:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 514              		.loc 1 118 38 discriminator 3 view .LVU135
 515 0504 C57C5BC2 		vcvtdq2ps	%ymm2, %ymm8
 119:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 516              		.loc 1 119 38 discriminator 3 view .LVU136
 517 0508 C5FC5BF6 		vcvtdq2ps	%ymm6, %ymm6
 518 050c C4E23DB8 		vfmadd231ps	.LC33(%rip), %ymm8, %ymm3
 518      1D000000 
 518      00
 519 0515 C57C2985 		vmovaps	%ymm8, -208(%rbp)
 519      30FFFFFF 
 520 051d C5FC29BD 		vmovaps	%ymm7, -144(%rbp)
 520      70FFFFFF 
 521 0525 C5CC593D 		vmulps	.LC32(%rip), %ymm6, %ymm7
 521      00000000 
 522              		.loc 1 120 48 discriminator 3 view .LVU137
 523 052d C4C27D33 		vpmovzxwd	%xmm9, %ymm2
 523      D1
 524              		.loc 1 120 38 discriminator 3 view .LVU138
 525 0532 C5FC5BD2 		vcvtdq2ps	%ymm2, %ymm2
 526              		.loc 1 120 48 discriminator 3 view .LVU139
 527 0536 C4437D39 		vextracti128	$0x1, %ymm9, %xmm9
 527      C901
 117:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 528              		.loc 1 117 33 discriminator 3 view .LVU140
 529 053c C4E26DB8 		vfmadd231ps	.LC34(%rip), %ymm2, %ymm1
 529      0D000000 
 529      00
 530 0545 C4E205B8 		vfmadd231ps	.LC33(%rip), %ymm15, %ymm7
 530      3D000000 
 530      00
 531              		.loc 1 120 48 discriminator 3 view .LVU141
 532 054e C4427D33 		vpmovzxwd	%xmm9, %ymm9
 532      C9
 533              		.loc 1 120 38 discriminator 3 view .LVU142
 534 0553 C4417C5B 		vcvtdq2ps	%ymm9, %ymm9
 534      C9
 117:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 535              		.loc 1 117 33 discriminator 3 view .LVU143
 536 0558 C4E235B8 		vfmadd231ps	.LC34(%rip), %ymm9, %ymm0
 536      05000000 
 536      00
 537              		.loc 1 120 38 discriminator 3 view .LVU144
 538 0561 C4417C5B 		vcvtdq2ps	%ymm14, %ymm14
 538      F6
 117:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 539              		.loc 1 117 33 discriminator 3 view .LVU145
 540 0566 C4E20DB8 		vfmadd231ps	.LC34(%rip), %ymm14, %ymm3
 540      1D000000 
 540      00
 541 056f C5F45D0D 		vminps	.LC35(%rip), %ymm1, %ymm1
 541      00000000 
 542              		.loc 1 120 48 discriminator 3 view .LVU146
 543 0577 C4E27D33 		vpmovzxwd	%xmm5, %ymm5
 543      ED
 544              		.loc 1 120 38 discriminator 3 view .LVU147
 545 057c C5FC5BED 		vcvtdq2ps	%ymm5, %ymm5
 117:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 546              		.loc 1 117 33 discriminator 3 view .LVU148
 547 0580 C4E255B8 		vfmadd231ps	.LC34(%rip), %ymm5, %ymm7
 547      3D000000 
 547      00
 548 0589 C5FC5D05 		vminps	.LC35(%rip), %ymm0, %ymm0
 548      00000000 
 549 0591 C52454C1 		vandps	%ymm1, %ymm11, %ymm8
 550 0595 C5E45D1D 		vminps	.LC35(%rip), %ymm3, %ymm3
 550      00000000 
 551 059d C4411C56 		vorps	%ymm8, %ymm12, %ymm8
 551      C0
 552 05a2 C4C17458 		vaddps	%ymm8, %ymm1, %ymm1
 552      C8
 553 05a7 C52454C0 		vandps	%ymm0, %ymm11, %ymm8
 554 05ab C5C45D3D 		vminps	.LC35(%rip), %ymm7, %ymm7
 554      00000000 
 555 05b3 C4411C56 		vorps	%ymm8, %ymm12, %ymm8
 555      C0
 556 05b8 C4C17C58 		vaddps	%ymm8, %ymm0, %ymm0
 556      C0
 557 05bd C52454C3 		vandps	%ymm3, %ymm11, %ymm8
 558 05c1 C4411C56 		vorps	%ymm8, %ymm12, %ymm8
 558      C0
 559 05c6 C4C16458 		vaddps	%ymm8, %ymm3, %ymm3
 559      D8
 560 05cb C52454C7 		vandps	%ymm7, %ymm11, %ymm8
 561 05cf C4411C56 		vorps	%ymm8, %ymm12, %ymm8
 561      C0
 562 05d4 C4C14458 		vaddps	%ymm8, %ymm7, %ymm7
 562      F8
 563 05d9 C4E37D08 		vroundps	$3, %ymm1, %ymm1
 563      C903
 564 05df C4E37D08 		vroundps	$3, %ymm0, %ymm0
 564      C003
 565 05e5 C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 566 05e9 C5FE5BC0 		vcvttps2dq	%ymm0, %ymm0
 567 05ed C5ADDBC9 		vpand	%ymm1, %ymm10, %ymm1
 568 05f1 C5ADDBC0 		vpand	%ymm0, %ymm10, %ymm0
 569 05f5 C4E37D08 		vroundps	$3, %ymm3, %ymm3
 569      DB03
 570 05fb C4E37D08 		vroundps	$3, %ymm7, %ymm7
 570      FF03
 571 0601 C5FE5BDB 		vcvttps2dq	%ymm3, %ymm3
 572 0605 C5FE5BFF 		vcvttps2dq	%ymm7, %ymm7
 573 0609 C5ADDBDB 		vpand	%ymm3, %ymm10, %ymm3
 574 060d C5ADDBFF 		vpand	%ymm7, %ymm10, %ymm7
 575 0611 C57D6F45 		vmovdqa	-112(%rbp), %ymm8
 575      90
 576 0616 C4E2752B 		vpackusdw	%ymm0, %ymm1, %ymm1
 576      C8
 577 061b C4E2652B 		vpackusdw	%ymm7, %ymm3, %ymm3
 577      DF
 578 0620 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 578      C9D8
 579 0626 C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 579      DBD8
 580 062c C4C165DB 		vpand	%ymm8, %ymm3, %ymm3
 580      D8
 581 0631 C4C175DB 		vpand	%ymm8, %ymm1, %ymm1
 581      C8
 582 0636 C5F567CB 		vpackuswb	%ymm3, %ymm1, %ymm1
 583 063a C4E3FD00 		vpermq	$216, %ymm1, %ymm3
 583      D9D8
 121:sepia_filter.c ****             /* G */
 122:sepia_filter.c ****             pixels_out[3*i + 1] = roundf(fminf(MAXPIXV,
 584              		.loc 1 122 13 is_stmt 1 discriminator 3 view .LVU149
 123:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 124:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 585              		.loc 1 124 38 is_stmt 0 discriminator 3 view .LVU150
 586 0640 C5FC2845 		vmovaps	-80(%rbp), %ymm0
 586      B0
 587 0645 C594590D 		vmulps	.LC40(%rip), %ymm13, %ymm1
 587      00000000 
 588 064d C5FC5905 		vmulps	.LC40(%rip), %ymm0, %ymm0
 588      00000000 
 589 0655 C5FC28BD 		vmovaps	-144(%rbp), %ymm7
 589      70FFFFFF 
 590 065d C57C2885 		vmovaps	-208(%rbp), %ymm8
 590      30FFFFFF 
 591 0665 C57C29BD 		vmovaps	%ymm15, -240(%rbp)
 591      10FFFFFF 
 592 066d C4E245B8 		vfmadd231ps	.LC41(%rip), %ymm7, %ymm1
 592      0D000000 
 592      00
 593 0676 C5FC28BD 		vmovaps	-176(%rbp), %ymm7
 593      50FFFFFF 
 594 067e 4883C060 		addq	$96, %rax
 595 0682 C4E245B8 		vfmadd231ps	.LC41(%rip), %ymm7, %ymm0
 595      05000000 
 595      00
 596 068b C5DC593D 		vmulps	.LC40(%rip), %ymm4, %ymm7
 596      00000000 
 122:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 597              		.loc 1 122 33 discriminator 3 view .LVU151
 598 0693 C4E26DB8 		vfmadd231ps	.LC42(%rip), %ymm2, %ymm1
 598      0D000000 
 598      00
 599 069c 4883C160 		addq	$96, %rcx
 600 06a0 C4E235B8 		vfmadd231ps	.LC42(%rip), %ymm9, %ymm0
 600      05000000 
 600      00
 601 06a9 C4E23DB8 		vfmadd231ps	.LC41(%rip), %ymm8, %ymm7
 601      3D000000 
 601      00
 602              		.loc 1 124 38 discriminator 3 view .LVU152
 603 06b2 C54C5905 		vmulps	.LC40(%rip), %ymm6, %ymm8
 603      00000000 
 122:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 604              		.loc 1 122 33 discriminator 3 view .LVU153
 605 06ba C5F45D0D 		vminps	.LC35(%rip), %ymm1, %ymm1
 605      00000000 
 606 06c2 C5FC5D05 		vminps	.LC35(%rip), %ymm0, %ymm0
 606      00000000 
 607 06ca C4E20DB8 		vfmadd231ps	.LC42(%rip), %ymm14, %ymm7
 607      3D000000 
 607      00
 608 06d3 C46205B8 		vfmadd231ps	.LC41(%rip), %ymm15, %ymm8
 608      05000000 
 608      00
 609 06dc C52454F9 		vandps	%ymm1, %ymm11, %ymm15
 610 06e0 C4411C56 		vorps	%ymm15, %ymm12, %ymm15
 610      FF
 611 06e5 C4C17458 		vaddps	%ymm15, %ymm1, %ymm1
 611      CF
 612 06ea C5C45D3D 		vminps	.LC35(%rip), %ymm7, %ymm7
 612      00000000 
 613 06f2 C46255B8 		vfmadd231ps	.LC42(%rip), %ymm5, %ymm8
 613      05000000 
 613      00
 614 06fb C52454F8 		vandps	%ymm0, %ymm11, %ymm15
 615 06ff C4411C56 		vorps	%ymm15, %ymm12, %ymm15
 615      FF
 616 0704 C4C17C58 		vaddps	%ymm15, %ymm0, %ymm0
 616      C7
 617 0709 C52454FF 		vandps	%ymm7, %ymm11, %ymm15
 618 070d C53C5D05 		vminps	.LC35(%rip), %ymm8, %ymm8
 618      00000000 
 619 0715 C4411C56 		vorps	%ymm15, %ymm12, %ymm15
 619      FF
 620 071a C4C14458 		vaddps	%ymm15, %ymm7, %ymm7
 620      FF
 621 071f C4412454 		vandps	%ymm8, %ymm11, %ymm15
 621      F8
 622 0724 C4411C56 		vorps	%ymm15, %ymm12, %ymm15
 622      FF
 623 0729 C4413C58 		vaddps	%ymm15, %ymm8, %ymm8
 623      C7
 624 072e C4E37D08 		vroundps	$3, %ymm1, %ymm1
 624      C903
 625 0734 C4E37D08 		vroundps	$3, %ymm0, %ymm0
 625      C003
 626 073a C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 627 073e C5FE5BC0 		vcvttps2dq	%ymm0, %ymm0
 628 0742 C5ADDBC9 		vpand	%ymm1, %ymm10, %ymm1
 629 0746 C5ADDBC0 		vpand	%ymm0, %ymm10, %ymm0
 630 074a C4E37D08 		vroundps	$3, %ymm7, %ymm7
 630      FF03
 631 0750 C4437D08 		vroundps	$3, %ymm8, %ymm8
 631      C003
 632 0756 C5FE5BFF 		vcvttps2dq	%ymm7, %ymm7
 633 075a C4417E5B 		vcvttps2dq	%ymm8, %ymm8
 633      C0
 634 075f C5ADDBFF 		vpand	%ymm7, %ymm10, %ymm7
 635 0763 C4412DDB 		vpand	%ymm8, %ymm10, %ymm8
 635      C0
 636 0768 C4E2752B 		vpackusdw	%ymm0, %ymm1, %ymm1
 636      C8
 637 076d C4C2452B 		vpackusdw	%ymm8, %ymm7, %ymm7
 637      F8
 638 0772 C57D6F45 		vmovdqa	-112(%rbp), %ymm8
 638      90
 125:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 126:sepia_filter.c ****             /* B */
 127:sepia_filter.c ****             pixels_out[3*i + 2] = roundf(fminf(MAXPIXV,
 128:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 129:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 639              		.loc 1 129 38 discriminator 3 view .LVU154
 640 0777 C514592D 		vmulps	.LC43(%rip), %ymm13, %ymm13
 640      00000000 
 122:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 641              		.loc 1 122 33 discriminator 3 view .LVU155
 642 077f C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 642      C9D8
 643 0785 C4E3FD00 		vpermq	$216, %ymm7, %ymm7
 643      FFD8
 644 078b C4C145DB 		vpand	%ymm8, %ymm7, %ymm7
 644      F8
 645 0790 C4C175DB 		vpand	%ymm8, %ymm1, %ymm1
 645      C8
 646 0795 C5F567CF 		vpackuswb	%ymm7, %ymm1, %ymm1
 647 0799 C5FC28BD 		vmovaps	-144(%rbp), %ymm7
 647      70FFFFFF 
 648              		.loc 1 129 38 discriminator 3 view .LVU156
 649 07a1 C5DC5925 		vmulps	.LC43(%rip), %ymm4, %ymm4
 649      00000000 
 650 07a9 C46245B8 		vfmadd231ps	.LC44(%rip), %ymm7, %ymm13
 650      2D000000 
 650      00
 651 07b2 C5FC287D 		vmovaps	-80(%rbp), %ymm7
 651      B0
 652 07b7 C5FC2885 		vmovaps	-176(%rbp), %ymm0
 652      50FFFFFF 
 653 07bf C5C4593D 		vmulps	.LC43(%rip), %ymm7, %ymm7
 653      00000000 
 654 07c7 C5CC5935 		vmulps	.LC43(%rip), %ymm6, %ymm6
 654      00000000 
 127:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 655              		.loc 1 127 33 discriminator 3 view .LVU157
 656 07cf C4E21598 		vfmadd132ps	.LC45(%rip), %ymm13, %ymm2
 656      15000000 
 656      00
 122:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 657              		.loc 1 122 33 discriminator 3 view .LVU158
 658 07d8 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 658      C9D8
 127:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 659              		.loc 1 127 13 is_stmt 1 discriminator 3 view .LVU159
 660 07de C4E27DB8 		vfmadd231ps	.LC44(%rip), %ymm0, %ymm7
 660      3D000000 
 660      00
 661 07e7 C5FC2885 		vmovaps	-208(%rbp), %ymm0
 661      30FFFFFF 
 127:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 662              		.loc 1 127 33 is_stmt 0 discriminator 3 view .LVU160
 663 07ef C5EC5D15 		vminps	.LC35(%rip), %ymm2, %ymm2
 663      00000000 
 664 07f7 C4E27DB8 		vfmadd231ps	.LC44(%rip), %ymm0, %ymm4
 664      25000000 
 664      00
 665 0800 C5FC2885 		vmovaps	-240(%rbp), %ymm0
 665      10FFFFFF 
 666 0808 C4E24D98 		vfmadd132ps	.LC44(%rip), %ymm6, %ymm0
 666      05000000 
 666      00
 667 0811 C57C29CE 		vmovaps	%ymm9, %ymm6
 668 0815 C4E24598 		vfmadd132ps	.LC45(%rip), %ymm7, %ymm6
 668      35000000 
 668      00
 669 081e C4E20DB8 		vfmadd231ps	.LC45(%rip), %ymm14, %ymm4
 669      25000000 
 669      00
 670 0827 C4E255B8 		vfmadd231ps	.LC45(%rip), %ymm5, %ymm0
 670      05000000 
 670      00
 671 0830 C5A454EA 		vandps	%ymm2, %ymm11, %ymm5
 672 0834 C59C56ED 		vorps	%ymm5, %ymm12, %ymm5
 673 0838 C5CC5D35 		vminps	.LC35(%rip), %ymm6, %ymm6
 673      00000000 
 674 0840 C5EC58D5 		vaddps	%ymm5, %ymm2, %ymm2
 675 0844 C5DC5D25 		vminps	.LC35(%rip), %ymm4, %ymm4
 675      00000000 
 676 084c C5FC5D05 		vminps	.LC35(%rip), %ymm0, %ymm0
 676      00000000 
 677 0854 C4E37D08 		vroundps	$3, %ymm2, %ymm2
 677      D203
 678 085a C5FE5BEA 		vcvttps2dq	%ymm2, %ymm5
 679 085e C5A454D6 		vandps	%ymm6, %ymm11, %ymm2
 680 0862 C59C56D2 		vorps	%ymm2, %ymm12, %ymm2
 681 0866 C5CC58F2 		vaddps	%ymm2, %ymm6, %ymm6
 682 086a C5A454D4 		vandps	%ymm4, %ymm11, %ymm2
 683 086e C59C56D2 		vorps	%ymm2, %ymm12, %ymm2
 684 0872 C5DC58E2 		vaddps	%ymm2, %ymm4, %ymm4
 685 0876 C5A454D0 		vandps	%ymm0, %ymm11, %ymm2
 686 087a C59C56D2 		vorps	%ymm2, %ymm12, %ymm2
 687 087e C5FC58D2 		vaddps	%ymm2, %ymm0, %ymm2
 688 0882 C4E37D08 		vroundps	$3, %ymm6, %ymm6
 688      F603
 689 0888 C5ADDBC5 		vpand	%ymm5, %ymm10, %ymm0
 690 088c C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 691 0890 C4E37D08 		vroundps	$3, %ymm4, %ymm4
 691      E403
 692 0896 C5ADDBF6 		vpand	%ymm6, %ymm10, %ymm6
 693 089a C5FE5BE4 		vcvttps2dq	%ymm4, %ymm4
 694 089e C4E37D08 		vroundps	$3, %ymm2, %ymm2
 694      D203
 695 08a4 C5ADDBE4 		vpand	%ymm4, %ymm10, %ymm4
 696 08a8 C5FE5BD2 		vcvttps2dq	%ymm2, %ymm2
 697 08ac C5ADDBD2 		vpand	%ymm2, %ymm10, %ymm2
 698 08b0 C4E27D2B 		vpackusdw	%ymm6, %ymm0, %ymm0
 698      C6
 699 08b5 C4E25D2B 		vpackusdw	%ymm2, %ymm4, %ymm2
 699      D2
 700 08ba C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 700      C0D8
 701 08c0 C4E3FD00 		vpermq	$216, %ymm2, %ymm2
 701      D2D8
 702 08c6 C4C16DDB 		vpand	%ymm8, %ymm2, %ymm2
 702      D0
 703 08cb C4C17DDB 		vpand	%ymm8, %ymm0, %ymm0
 703      C0
 704 08d0 C4E26500 		vpshufb	.LC46(%rip), %ymm3, %ymm6
 704      35000000 
 704      00
 705 08d9 C4E27500 		vpshufb	.LC47(%rip), %ymm1, %ymm5
 705      2D000000 
 705      00
 706 08e2 C5FD67C2 		vpackuswb	%ymm2, %ymm0, %ymm0
 707 08e6 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 707      C0D8
 708 08ec C4E26500 		vpshufb	.LC48(%rip), %ymm3, %ymm2
 708      15000000 
 708      00
 709 08f5 C4E27500 		vpshufb	.LC49(%rip), %ymm1, %ymm4
 709      25000000 
 709      00
 710 08fe C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 710      ED4E
 711 0904 C4E3FD00 		vpermq	$78, %ymm6, %ymm6
 711      F64E
 712 090a C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 713 090e C5EDEBD6 		vpor	%ymm6, %ymm2, %ymm2
 714 0912 C4E27D00 		vpshufb	.LC50(%rip), %ymm0, %ymm5
 714      2D000000 
 714      00
 715 091b C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 716 091f C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 716      ED4E
 717 0925 C4E27D00 		vpshufb	.LC52(%rip), %ymm0, %ymm4
 717      25000000 
 717      00
 718 092e C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 719 0932 C4E26D00 		vpshufb	.LC51(%rip), %ymm2, %ymm2
 719      15000000 
 719      00
 720 093b C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 721 093f C4E26500 		vpshufb	.LC53(%rip), %ymm3, %ymm4
 721      25000000 
 721      00
 722 0948 C5FE7F51 		vmovdqu	%ymm2, -96(%rcx)
 722      A0
 723 094d C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 723      E44E
 724 0953 C4E26500 		vpshufb	.LC54(%rip), %ymm3, %ymm2
 724      15000000 
 724      00
 725 095c C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 726 0960 C4E27500 		vpshufb	.LC55(%rip), %ymm1, %ymm5
 726      2D000000 
 726      00
 727 0969 C5EDEBD5 		vpor	%ymm5, %ymm2, %ymm2
 728 096d C5FD6F2D 		vmovdqa	.LC57(%rip), %ymm5
 728      00000000 
 729 0975 C4E27D00 		vpshufb	.LC56(%rip), %ymm0, %ymm4
 729      25000000 
 729      00
 730 097e C4E35D4C 		vpblendvb	%ymm5, %ymm2, %ymm4, %ymm2
 730      D250
 731 0984 C5FE7F51 		vmovdqu	%ymm2, -64(%rcx)
 731      C0
 732 0989 C4E27500 		vpshufb	.LC58(%rip), %ymm1, %ymm4
 732      25000000 
 732      00
 733 0992 C4E26500 		vpshufb	.LC59(%rip), %ymm3, %ymm2
 733      15000000 
 733      00
 734 099b C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 734      D24E
 735 09a1 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 735      E44E
 736 09a7 C4E27500 		vpshufb	.LC60(%rip), %ymm1, %ymm1
 736      0D000000 
 736      00
 737 09b0 C4E26500 		vpshufb	.LC61(%rip), %ymm3, %ymm3
 737      1D000000 
 737      00
 738 09b9 C5E5EBDA 		vpor	%ymm2, %ymm3, %ymm3
 739 09bd C5F5EBCC 		vpor	%ymm4, %ymm1, %ymm1
 740 09c1 C4E27D00 		vpshufb	.LC62(%rip), %ymm0, %ymm2
 740      15000000 
 740      00
 741 09ca C5F5EBCB 		vpor	%ymm3, %ymm1, %ymm1
 742 09ce C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 742      D24E
 743 09d4 C4E27D00 		vpshufb	.LC64(%rip), %ymm0, %ymm0
 743      05000000 
 743      00
 744 09dd C4E27500 		vpshufb	.LC63(%rip), %ymm1, %ymm1
 744      0D000000 
 744      00
 745 09e6 C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 746 09ea C5F5EBC0 		vpor	%ymm0, %ymm1, %ymm0
 747 09ee C5FE7F41 		vmovdqu	%ymm0, -32(%rcx)
 747      E0
 114:sepia_filter.c ****         {
 748              		.loc 1 114 44 is_stmt 1 discriminator 3 view .LVU161
 114:sepia_filter.c ****         {
 749              		.loc 1 114 9 discriminator 3 view .LVU162
 750 09f3 4C39E0   		cmpq	%r12, %rax
 751 09f6 0F8534F9 		jne	.L16
 751      FFFF
 752 09fc 8BB5E8FE 		movl	-280(%rbp), %esi
 752      FFFF
 753 0a02 89F0     		movl	%esi, %eax
 754 0a04 4439F8   		cmpl	%r15d, %eax
 755 0a07 0F842E07 		je	.L17
 755      0000
 756 0a0d C5F877   		vzeroupper
 757              	.LVL26:
 758              	.L15:
 114:sepia_filter.c ****         {
 759              		.loc 1 114 9 is_stmt 0 discriminator 3 view .LVU163
 760 0a10 4489FF   		movl	%r15d, %edi
 761 0a13 29C7     		subl	%eax, %edi
 762 0a15 8D4FFF   		leal	-1(%rdi), %ecx
 763 0a18 83F90E   		cmpl	$14, %ecx
 764 0a1b 0F863D05 		jbe	.L18
 764      0000
 765 0a21 488D0440 		leaq	(%rax,%rax,2), %rax
 766 0a25 498D4C05 		leaq	0(%r13,%rax), %rcx
 766      00
 118:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 767              		.loc 1 118 48 view .LVU164
 768 0a2a C5FA6F09 		vmovdqu	(%rcx), %xmm1
 769 0a2e C5FA6F61 		vmovdqu	16(%rcx), %xmm4
 769      10
 770 0a33 C5FA6F51 		vmovdqu	32(%rcx), %xmm2
 770      20
 771 0a38 C5F96F2D 		vmovdqa	.LC68(%rip), %xmm5
 771      00000000 
 772 0a40 C4E25900 		vpshufb	.LC66(%rip), %xmm4, %xmm3
 772      1D000000 
 772      00
 773 0a49 C4E27100 		vpshufb	.LC65(%rip), %xmm1, %xmm0
 773      05000000 
 773      00
 774 0a52 C5F9EBC3 		vpor	%xmm3, %xmm0, %xmm0
 775 0a56 C4E26900 		vpshufb	.LC67(%rip), %xmm2, %xmm3
 775      1D000000 
 775      00
 776 0a5f C4E3794C 		vpblendvb	%xmm5, %xmm3, %xmm0, %xmm0
 776      C350
 777 0a65 C4E25900 		vpshufb	.LC70(%rip), %xmm4, %xmm6
 777      35000000 
 777      00
 778 0a6e C4E27100 		vpshufb	.LC69(%rip), %xmm1, %xmm3
 778      1D000000 
 778      00
 779 0a77 C4E25900 		vpshufb	.LC73(%rip), %xmm4, %xmm4
 779      25000000 
 779      00
 780 0a80 C4627930 		vpmovzxbw	%xmm0, %xmm12
 780      E0
 781 0a85 C4E27100 		vpshufb	.LC72(%rip), %xmm1, %xmm1
 781      0D000000 
 781      00
 782 0a8e C5F973D8 		vpsrldq	$8, %xmm0, %xmm0
 782      08
 783 0a93 C5E1EBDE 		vpor	%xmm6, %xmm3, %xmm3
 784 0a97 C5F1EBCC 		vpor	%xmm4, %xmm1, %xmm1
 785 0a9b C4E26900 		vpshufb	.LC71(%rip), %xmm2, %xmm6
 785      35000000 
 785      00
 786 0aa4 C4E27930 		vpmovzxbw	%xmm0, %xmm0
 786      C0
 787 0aa9 C4E26900 		vpshufb	.LC74(%rip), %xmm2, %xmm2
 787      15000000 
 787      00
 788 0ab2 C4E3614C 		vpblendvb	%xmm5, %xmm6, %xmm3, %xmm3
 788      DE50
 789 0ab8 C4E3710E 		vpblendw	$224, %xmm2, %xmm1, %xmm1
 789      CAE0
 790 0abe C4E27933 		vpmovzxwd	%xmm0, %xmm2
 790      D0
 118:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 791              		.loc 1 118 38 view .LVU165
 792 0ac3 C5F85BFA 		vcvtdq2ps	%xmm2, %xmm7
 119:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 793              		.loc 1 119 48 view .LVU166
 794 0ac7 C4E27930 		vpmovzxbw	%xmm3, %xmm2
 794      D3
 795 0acc C5E173DB 		vpsrldq	$8, %xmm3, %xmm3
 795      08
 796 0ad1 C4E27930 		vpmovzxbw	%xmm3, %xmm3
 796      DB
 797 0ad6 C4627933 		vpmovzxwd	%xmm3, %xmm13
 797      EB
 798 0adb C5E173DB 		vpsrldq	$8, %xmm3, %xmm3
 798      08
 799 0ae0 C4E27933 		vpmovzxwd	%xmm3, %xmm3
 799      DB
 119:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 800              		.loc 1 119 38 view .LVU167
 801 0ae5 C5785BD3 		vcvtdq2ps	%xmm3, %xmm10
 120:sepia_filter.c ****             /* G */
 802              		.loc 1 120 48 view .LVU168
 803 0ae9 C4E27930 		vpmovzxbw	%xmm1, %xmm3
 803      D9
 804 0aee C4E27933 		vpmovzxwd	%xmm3, %xmm4
 804      E3
 805 0af3 C5F173D9 		vpsrldq	$8, %xmm1, %xmm1
 805      08
 806 0af8 C5E173DB 		vpsrldq	$8, %xmm3, %xmm3
 806      08
 807 0afd C4E27930 		vpmovzxbw	%xmm1, %xmm1
 807      C9
 808 0b02 C4E27933 		vpmovzxwd	%xmm3, %xmm3
 808      DB
 120:sepia_filter.c ****             /* G */
 809              		.loc 1 120 38 view .LVU169
 810 0b07 C5785BC3 		vcvtdq2ps	%xmm3, %xmm8
 120:sepia_filter.c ****             /* G */
 811              		.loc 1 120 48 view .LVU170
 812 0b0b C4E27933 		vpmovzxwd	%xmm1, %xmm3
 812      D9
 813 0b10 C5F173D9 		vpsrldq	$8, %xmm1, %xmm1
 813      08
 814 0b15 C4E27933 		vpmovzxwd	%xmm1, %xmm1
 814      C9
 118:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 815              		.loc 1 118 48 view .LVU171
 816 0b1a C5F973D8 		vpsrldq	$8, %xmm0, %xmm0
 816      08
 120:sepia_filter.c ****             /* G */
 817              		.loc 1 120 38 view .LVU172
 818 0b1f C5F85BE9 		vcvtdq2ps	%xmm1, %xmm5
 118:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 819              		.loc 1 118 48 view .LVU173
 820 0b23 C4E27933 		vpmovzxwd	%xmm0, %xmm0
 820      C0
 120:sepia_filter.c ****             /* G */
 821              		.loc 1 120 38 view .LVU174
 822 0b28 C5F8296D 		vmovaps	%xmm5, -80(%rbp)
 822      B0
 119:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 823              		.loc 1 119 38 view .LVU175
 824 0b2d C4E27918 		vbroadcastss	.LC1(%rip), %xmm5
 824      2D000000 
 824      00
 118:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 825              		.loc 1 118 38 view .LVU176
 826 0b36 C5785BD8 		vcvtdq2ps	%xmm0, %xmm11
 119:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 827              		.loc 1 119 48 view .LVU177
 828 0b3a C4E27933 		vpmovzxwd	%xmm2, %xmm0
 828      C2
 119:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 829              		.loc 1 119 38 view .LVU178
 830 0b3f C5F85BC0 		vcvtdq2ps	%xmm0, %xmm0
 119:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 831              		.loc 1 119 48 view .LVU179
 832 0b43 C5E973DA 		vpsrldq	$8, %xmm2, %xmm2
 832      08
 119:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 833              		.loc 1 119 38 view .LVU180
 834 0b48 C5F859F5 		vmulps	%xmm5, %xmm0, %xmm6
 119:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 835              		.loc 1 119 48 view .LVU181
 836 0b4c C4E27933 		vpmovzxwd	%xmm2, %xmm2
 836      D2
 120:sepia_filter.c ****             /* G */
 837              		.loc 1 120 38 view .LVU182
 838 0b51 C5785BCC 		vcvtdq2ps	%xmm4, %xmm9
 119:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 839              		.loc 1 119 38 view .LVU183
 840 0b55 C5F85BD2 		vcvtdq2ps	%xmm2, %xmm2
 841 0b59 C5E859E5 		vmulps	%xmm5, %xmm2, %xmm4
 120:sepia_filter.c ****             /* G */
 842              		.loc 1 120 38 view .LVU184
 843 0b5d C5785BFB 		vcvtdq2ps	%xmm3, %xmm15
 119:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 844              		.loc 1 119 38 view .LVU185
 845 0b61 C441785B 		vcvtdq2ps	%xmm13, %xmm13
 845      ED
 846 0b66 C4E27918 		vbroadcastss	.LC2(%rip), %xmm3
 846      1D000000 
 846      00
 847 0b6f C59059CD 		vmulps	%xmm5, %xmm13, %xmm1
 848 0b73 C4C15059 		vmulps	%xmm10, %xmm5, %xmm5
 848      EA
 118:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 849              		.loc 1 118 48 view .LVU186
 850 0b78 C4427933 		vpmovzxwd	%xmm12, %xmm14
 850      F4
 118:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 851              		.loc 1 118 38 view .LVU187
 852 0b7d C441785B 		vcvtdq2ps	%xmm14, %xmm14
 852      F6
 118:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 853              		.loc 1 118 48 view .LVU188
 854 0b82 C4C11973 		vpsrldq	$8, %xmm12, %xmm12
 854      DC08
 855 0b88 C4E209B8 		vfmadd231ps	%xmm3, %xmm14, %xmm6
 855      F3
 856 0b8d C4427933 		vpmovzxwd	%xmm12, %xmm12
 856      E4
 118:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 857              		.loc 1 118 38 view .LVU189
 858 0b92 C441785B 		vcvtdq2ps	%xmm12, %xmm12
 858      E4
 859 0b97 C4E219B8 		vfmadd231ps	%xmm3, %xmm12, %xmm4
 859      E3
 860 0b9c C4E261B8 		vfmadd231ps	%xmm7, %xmm3, %xmm1
 860      CF
 861 0ba1 C4C25198 		vfmadd132ps	%xmm11, %xmm5, %xmm3
 861      DB
 117:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 862              		.loc 1 117 33 view .LVU190
 863 0ba6 C4E27918 		vbroadcastss	.LC3(%rip), %xmm5
 863      2D000000 
 863      00
 119:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 864              		.loc 1 119 38 view .LVU191
 865 0baf C5782995 		vmovaps	%xmm10, -176(%rbp)
 865      50FFFFFF 
 117:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 866              		.loc 1 117 33 view .LVU192
 867 0bb7 C4C251B8 		vfmadd231ps	%xmm9, %xmm5, %xmm6
 867      F1
 868 0bbc C4C251B8 		vfmadd231ps	%xmm8, %xmm5, %xmm4
 868      E0
 869 0bc1 C4627918 		vbroadcastss	.LC4(%rip), %xmm10
 869      15000000 
 869      00
 870 0bca C4C251B8 		vfmadd231ps	%xmm15, %xmm5, %xmm1
 870      CF
 871 0bcf C578298D 		vmovaps	%xmm9, -208(%rbp)
 871      30FFFFFF 
 872 0bd7 C4C1485D 		vminps	%xmm10, %xmm6, %xmm6
 872      F2
 873 0bdc C4627918 		vbroadcastss	.LC14(%rip), %xmm9
 873      0D000000 
 873      00
 874 0be5 C4C1585D 		vminps	%xmm10, %xmm4, %xmm4
 874      E2
 875 0bea C5782985 		vmovaps	%xmm8, -240(%rbp)
 875      10FFFFFF 
 876 0bf2 C4627918 		vbroadcastss	.LC5(%rip), %xmm8
 876      05000000 
 876      00
 877 0bfb C4E26198 		vfmadd132ps	-80(%rbp), %xmm3, %xmm5
 877      6DB0
 878 0c01 C5B054DE 		vandps	%xmm6, %xmm9, %xmm3
 879 0c05 C5B856DB 		vorps	%xmm3, %xmm8, %xmm3
 880 0c09 C4C1705D 		vminps	%xmm10, %xmm1, %xmm1
 880      CA
 881 0c0e C5C858F3 		vaddps	%xmm3, %xmm6, %xmm6
 882 0c12 C5B054DC 		vandps	%xmm4, %xmm9, %xmm3
 883 0c16 C5B856DB 		vorps	%xmm3, %xmm8, %xmm3
 884 0c1a C5D858E3 		vaddps	%xmm3, %xmm4, %xmm4
 885 0c1e C5B054D9 		vandps	%xmm1, %xmm9, %xmm3
 886 0c22 C5B856DB 		vorps	%xmm3, %xmm8, %xmm3
 887 0c26 C5F058CB 		vaddps	%xmm3, %xmm1, %xmm1
 888 0c2a C4C1505D 		vminps	%xmm10, %xmm5, %xmm5
 888      EA
 889 0c2f B9FFFF00 		movl	$65535, %ecx
 889      00
 890 0c34 C4E37908 		vroundps	$3, %xmm1, %xmm3
 890      D903
 891 0c3a C5B054CD 		vandps	%xmm5, %xmm9, %xmm1
 892 0c3e C5B856C9 		vorps	%xmm1, %xmm8, %xmm1
 893 0c42 C5D058E9 		vaddps	%xmm1, %xmm5, %xmm5
 894 0c46 C5F8297D 		vmovaps	%xmm7, -112(%rbp)
 894      90
 895 0c4b C4E37908 		vroundps	$3, %xmm4, %xmm4
 895      E403
 896 0c51 C4E37908 		vroundps	$3, %xmm5, %xmm7
 896      FD03
 897 0c57 C5F96EE9 		vmovd	%ecx, %xmm5
 898 0c5b C5F970ED 		vpshufd	$0, %xmm5, %xmm5
 898      00
 899 0c60 C5FA5BE4 		vcvttps2dq	%xmm4, %xmm4
 900 0c64 B9FF0000 		movl	$255, %ecx
 900      00
 901 0c69 C5D1DBCC 		vpand	%xmm4, %xmm5, %xmm1
 124:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 902              		.loc 1 124 38 view .LVU193
 903 0c6d C4E27918 		vbroadcastss	.LC7(%rip), %xmm4
 903      25000000 
 903      00
 904 0c76 C578299D 		vmovaps	%xmm11, -144(%rbp)
 904      70FFFFFF 
 117:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 905              		.loc 1 117 33 view .LVU194
 906 0c7e C4E37908 		vroundps	$3, %xmm6, %xmm6
 906      F603
 907 0c84 C5796ED9 		vmovd	%ecx, %xmm11
 908 0c88 C5FA5BF6 		vcvttps2dq	%xmm6, %xmm6
 909 0c8c C5FA5BDB 		vcvttps2dq	%xmm3, %xmm3
 910 0c90 C5D1DBF6 		vpand	%xmm6, %xmm5, %xmm6
 911 0c94 C5D1DBDB 		vpand	%xmm3, %xmm5, %xmm3
 912 0c98 C5FA5BFF 		vcvttps2dq	%xmm7, %xmm7
 913 0c9c C5D1DBFF 		vpand	%xmm7, %xmm5, %xmm7
 914 0ca0 C4427979 		vpbroadcastw	%xmm11, %xmm11
 914      DB
 915 0ca5 C4E2492B 		vpackusdw	%xmm1, %xmm6, %xmm1
 915      C9
 916 0caa C4E2612B 		vpackusdw	%xmm7, %xmm3, %xmm3
 916      DF
 124:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 917              		.loc 1 124 38 view .LVU195
 918 0caf C5F859FC 		vmulps	%xmm4, %xmm0, %xmm7
 117:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 919              		.loc 1 117 33 view .LVU196
 920 0cb3 C5A1DBDB 		vpand	%xmm3, %xmm11, %xmm3
 921 0cb7 C5A1DBC9 		vpand	%xmm1, %xmm11, %xmm1
 922 0cbb C5F167CB 		vpackuswb	%xmm3, %xmm1, %xmm1
 124:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 923              		.loc 1 124 38 view .LVU197
 924 0cbf C5E859DC 		vmulps	%xmm4, %xmm2, %xmm3
 925 0cc3 C59059F4 		vmulps	%xmm4, %xmm13, %xmm6
 117:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 926              		.loc 1 117 33 view .LVU198
 927 0cc7 C57829BD 		vmovaps	%xmm15, -256(%rbp)
 927      00FFFFFF 
 124:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 928              		.loc 1 124 38 view .LVU199
 929 0ccf C5D859A5 		vmulps	-176(%rbp), %xmm4, %xmm4
 929      50FFFFFF 
 930 0cd7 C4627918 		vbroadcastss	.LC8(%rip), %xmm15
 930      3D000000 
 930      00
 931 0ce0 4C01F0   		addq	%r14, %rax
 117:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 932              		.loc 1 117 13 is_stmt 1 view .LVU200
 122:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 933              		.loc 1 122 13 view .LVU201
 934 0ce3 C4C209B8 		vfmadd231ps	%xmm15, %xmm14, %xmm7
 934      FF
 935 0ce8 C4C219B8 		vfmadd231ps	%xmm15, %xmm12, %xmm3
 935      DF
 936 0ced C4E201B8 		vfmadd231ps	-112(%rbp), %xmm15, %xmm6
 936      7590
 937 0cf3 C4625998 		vfmadd132ps	-144(%rbp), %xmm4, %xmm15
 937      BD70FFFF 
 937      FF
 122:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 938              		.loc 1 122 33 is_stmt 0 view .LVU202
 939 0cfc C4E27918 		vbroadcastss	.LC9(%rip), %xmm4
 939      25000000 
 939      00
 940 0d05 C4E259B8 		vfmadd231ps	-208(%rbp), %xmm4, %xmm7
 940      BD30FFFF 
 940      FF
 941 0d0e C4E259B8 		vfmadd231ps	-240(%rbp), %xmm4, %xmm3
 941      9D10FFFF 
 941      FF
 942 0d17 C4E259B8 		vfmadd231ps	-256(%rbp), %xmm4, %xmm6
 942      B500FFFF 
 942      FF
 943 0d20 C4E20198 		vfmadd132ps	-80(%rbp), %xmm15, %xmm4
 943      65B0
 944 0d26 C4C1405D 		vminps	%xmm10, %xmm7, %xmm7
 944      FA
 945 0d2b C4C1605D 		vminps	%xmm10, %xmm3, %xmm3
 945      DA
 946 0d30 C4C1485D 		vminps	%xmm10, %xmm6, %xmm6
 946      F2
 947 0d35 C53054FF 		vandps	%xmm7, %xmm9, %xmm15
 948 0d39 C4413856 		vorps	%xmm15, %xmm8, %xmm15
 948      FF
 949 0d3e C4C14058 		vaddps	%xmm15, %xmm7, %xmm7
 949      FF
 950 0d43 C53054FB 		vandps	%xmm3, %xmm9, %xmm15
 951 0d47 C4413856 		vorps	%xmm15, %xmm8, %xmm15
 951      FF
 952 0d4c C4C1585D 		vminps	%xmm10, %xmm4, %xmm4
 952      E2
 953 0d51 C4C16058 		vaddps	%xmm15, %xmm3, %xmm3
 953      DF
 954 0d56 C53054FE 		vandps	%xmm6, %xmm9, %xmm15
 955 0d5a C4413856 		vorps	%xmm15, %xmm8, %xmm15
 955      FF
 956 0d5f C4C14858 		vaddps	%xmm15, %xmm6, %xmm6
 956      F7
 957 0d64 C53054FC 		vandps	%xmm4, %xmm9, %xmm15
 958 0d68 C4413856 		vorps	%xmm15, %xmm8, %xmm15
 958      FF
 959 0d6d C4C15858 		vaddps	%xmm15, %xmm4, %xmm4
 959      E7
 960 0d72 C4E37908 		vroundps	$3, %xmm7, %xmm7
 960      FF03
 961 0d78 C4E37908 		vroundps	$3, %xmm3, %xmm3
 961      DB03
 962 0d7e C5FA5BFF 		vcvttps2dq	%xmm7, %xmm7
 963 0d82 C5FA5BDB 		vcvttps2dq	%xmm3, %xmm3
 964 0d86 C5D1DBFF 		vpand	%xmm7, %xmm5, %xmm7
 965 0d8a C5D1DBDB 		vpand	%xmm3, %xmm5, %xmm3
 966 0d8e C4E37908 		vroundps	$3, %xmm6, %xmm6
 966      F603
 967 0d94 C4E37908 		vroundps	$3, %xmm4, %xmm4
 967      E403
 968 0d9a C5FA5BF6 		vcvttps2dq	%xmm6, %xmm6
 969 0d9e C5FA5BE4 		vcvttps2dq	%xmm4, %xmm4
 970 0da2 C5D1DBF6 		vpand	%xmm6, %xmm5, %xmm6
 971 0da6 C5D1DBE4 		vpand	%xmm4, %xmm5, %xmm4
 972 0daa C4E2412B 		vpackusdw	%xmm3, %xmm7, %xmm3
 972      DB
 973 0daf C4E2492B 		vpackusdw	%xmm4, %xmm6, %xmm4
 973      E4
 974 0db4 C5A1DBE4 		vpand	%xmm4, %xmm11, %xmm4
 975 0db8 C5A1DBDB 		vpand	%xmm3, %xmm11, %xmm3
 976 0dbc C5E167DC 		vpackuswb	%xmm4, %xmm3, %xmm3
 127:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 977              		.loc 1 127 13 is_stmt 1 view .LVU203
 978              		.loc 1 129 38 is_stmt 0 view .LVU204
 979 0dc0 C4E27918 		vbroadcastss	.LC10(%rip), %xmm4
 979      25000000 
 979      00
 980 0dc9 C4E27918 		vbroadcastss	.LC11(%rip), %xmm6
 980      35000000 
 980      00
 981 0dd2 C5F859C4 		vmulps	%xmm4, %xmm0, %xmm0
 982 0dd6 C5E859D4 		vmulps	%xmm4, %xmm2, %xmm2
 983 0dda C51059EC 		vmulps	%xmm4, %xmm13, %xmm13
 984 0dde C5D859A5 		vmulps	-176(%rbp), %xmm4, %xmm4
 984      50FFFFFF 
 985 0de6 C5F8287D 		vmovaps	-112(%rbp), %xmm7
 985      90
 986 0deb C4E209B8 		vfmadd231ps	%xmm6, %xmm14, %xmm0
 986      C6
 987 0df0 C4E219B8 		vfmadd231ps	%xmm6, %xmm12, %xmm2
 987      D6
 988 0df5 C4E21198 		vfmadd132ps	%xmm6, %xmm13, %xmm7
 988      FE
 989 0dfa C4E249B8 		vfmadd231ps	-144(%rbp), %xmm6, %xmm4
 989      A570FFFF 
 989      FF
 127:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 990              		.loc 1 127 33 view .LVU205
 991 0e03 C4E27918 		vbroadcastss	.LC12(%rip), %xmm6
 991      35000000 
 991      00
 992 0e0c C4E249B8 		vfmadd231ps	-208(%rbp), %xmm6, %xmm0
 992      8530FFFF 
 992      FF
 993 0e15 C4E249B8 		vfmadd231ps	-240(%rbp), %xmm6, %xmm2
 993      9510FFFF 
 993      FF
 994 0e1e C4E249B8 		vfmadd231ps	-256(%rbp), %xmm6, %xmm7
 994      BD00FFFF 
 994      FF
 995 0e27 C4E249B8 		vfmadd231ps	-80(%rbp), %xmm6, %xmm4
 995      65B0
 996 0e2d C4C1785D 		vminps	%xmm10, %xmm0, %xmm0
 996      C2
 997 0e32 C4C1685D 		vminps	%xmm10, %xmm2, %xmm2
 997      D2
 998 0e37 C4C1405D 		vminps	%xmm10, %xmm7, %xmm7
 998      FA
 999 0e3c C5B054F0 		vandps	%xmm0, %xmm9, %xmm6
 1000 0e40 C5B856F6 		vorps	%xmm6, %xmm8, %xmm6
 1001 0e44 C5F858C6 		vaddps	%xmm6, %xmm0, %xmm0
 1002 0e48 C5B054F2 		vandps	%xmm2, %xmm9, %xmm6
 1003 0e4c C5B856F6 		vorps	%xmm6, %xmm8, %xmm6
 1004 0e50 C5E858D6 		vaddps	%xmm6, %xmm2, %xmm2
 1005 0e54 C4C1585D 		vminps	%xmm10, %xmm4, %xmm4
 1005      E2
 1006 0e59 C4E37908 		vroundps	$3, %xmm0, %xmm0
 1006      C003
 1007 0e5f C4E37908 		vroundps	$3, %xmm2, %xmm6
 1007      F203
 1008 0e65 C5B054D7 		vandps	%xmm7, %xmm9, %xmm2
 1009 0e69 C53054CC 		vandps	%xmm4, %xmm9, %xmm9
 1010 0e6d C5B856D2 		vorps	%xmm2, %xmm8, %xmm2
 1011 0e71 C4413856 		vorps	%xmm9, %xmm8, %xmm8
 1011      C1
 1012 0e76 C5C058D2 		vaddps	%xmm2, %xmm7, %xmm2
 1013 0e7a C4C15858 		vaddps	%xmm8, %xmm4, %xmm4
 1013      E0
 1014 0e7f C5FA5BC0 		vcvttps2dq	%xmm0, %xmm0
 1015 0e83 C5FA5BF6 		vcvttps2dq	%xmm6, %xmm6
 1016 0e87 C5D1DBC0 		vpand	%xmm0, %xmm5, %xmm0
 1017 0e8b C5D1DBF6 		vpand	%xmm6, %xmm5, %xmm6
 1018 0e8f C4E37908 		vroundps	$3, %xmm2, %xmm2
 1018      D203
 1019 0e95 C4E37908 		vroundps	$3, %xmm4, %xmm4
 1019      E403
 1020 0e9b C5FA5BD2 		vcvttps2dq	%xmm2, %xmm2
 1021 0e9f C5FA5BE4 		vcvttps2dq	%xmm4, %xmm4
 1022 0ea3 C5D1DBD2 		vpand	%xmm2, %xmm5, %xmm2
 1023 0ea7 C5D1DBEC 		vpand	%xmm4, %xmm5, %xmm5
 1024 0eab C4E2692B 		vpackusdw	%xmm5, %xmm2, %xmm2
 1024      D5
 1025 0eb0 C4E2792B 		vpackusdw	%xmm6, %xmm0, %xmm0
 1025      C6
 1026 0eb5 C5A1DBC0 		vpand	%xmm0, %xmm11, %xmm0
 1027 0eb9 C521DBDA 		vpand	%xmm2, %xmm11, %xmm11
 1028 0ebd C4C17967 		vpackuswb	%xmm11, %xmm0, %xmm0
 1028      C3
 1029 0ec2 C5F160D3 		vpunpcklbw	%xmm3, %xmm1, %xmm2
 1030 0ec6 C5F96F2D 		vmovdqa	.LC91(%rip), %xmm5
 1030      00000000 
 1031 0ece C4E27900 		vpshufb	.LC90(%rip), %xmm0, %xmm4
 1031      25000000 
 1031      00
 1032 0ed7 C4E26900 		vpshufb	.LC89(%rip), %xmm2, %xmm2
 1032      15000000 
 1032      00
 1033 0ee0 C4E3694C 		vpblendvb	%xmm5, %xmm4, %xmm2, %xmm2
 1033      D450
 1034 0ee6 C5FA7F10 		vmovdqu	%xmm2, (%rax)
 1035 0eea C4E27100 		vpshufb	.LC93(%rip), %xmm1, %xmm4
 1035      25000000 
 1035      00
 1036 0ef3 C4E26100 		vpshufb	.LC92(%rip), %xmm3, %xmm2
 1036      15000000 
 1036      00
 1037 0efc C5F96F2D 		vmovdqa	.LC95(%rip), %xmm5
 1037      00000000 
 1038 0f04 C5E9EBD4 		vpor	%xmm4, %xmm2, %xmm2
 1039 0f08 C4E27900 		vpshufb	.LC94(%rip), %xmm0, %xmm4
 1039      25000000 
 1039      00
 1040 0f11 C4E3694C 		vpblendvb	%xmm5, %xmm4, %xmm2, %xmm2
 1040      D450
 1041 0f17 C5FA7F50 		vmovdqu	%xmm2, 16(%rax)
 1041      10
 1042 0f1c C4E27100 		vpshufb	.LC96(%rip), %xmm1, %xmm1
 1042      0D000000 
 1042      00
 1043 0f25 C5F96F15 		vmovdqa	.LC99(%rip), %xmm2
 1043      00000000 
 1044 0f2d C4E26100 		vpshufb	.LC97(%rip), %xmm3, %xmm3
 1044      1D000000 
 1044      00
 1045 0f36 C5F1EBCB 		vpor	%xmm3, %xmm1, %xmm1
 1046 0f3a C4E27900 		vpshufb	.LC98(%rip), %xmm0, %xmm0
 1046      05000000 
 1046      00
 1047 0f43 C4E3794C 		vpblendvb	%xmm2, %xmm1, %xmm0, %xmm0
 1047      C120
 1048 0f49 C5FA7F40 		vmovdqu	%xmm0, 32(%rax)
 1048      20
 114:sepia_filter.c ****         {
 1049              		.loc 1 114 44 is_stmt 1 view .LVU206
 114:sepia_filter.c ****         {
 1050              		.loc 1 114 9 view .LVU207
 1051 0f4e 89F8     		movl	%edi, %eax
 1052 0f50 83E0F0   		andl	$-16, %eax
 1053 0f53 01C6     		addl	%eax, %esi
 1054 0f55 83E70F   		andl	$15, %edi
 1055 0f58 0F846901 		je	.L19
 1055      0000
 1056              	.L18:
 114:sepia_filter.c ****         {
 1057              		.loc 1 114 9 is_stmt 0 view .LVU208
 1058 0f5e C57A102D 		vmovss	.LC5(%rip), %xmm13
 1058      00000000 
 1059 0f66 8D0C76   		leal	(%rsi,%rsi,2), %ecx
 1060 0f69 4863C9   		movslq	%ecx, %rcx
 1061 0f6c C57A101D 		vmovss	.LC1(%rip), %xmm11
 1061      00000000 
 1062 0f74 C57A1015 		vmovss	.LC2(%rip), %xmm10
 1062      00000000 
 1063 0f7c C57A100D 		vmovss	.LC3(%rip), %xmm9
 1063      00000000 
 1064 0f84 C5FA1015 		vmovss	.LC4(%rip), %xmm2
 1064      00000000 
 1065 0f8c C57A1005 		vmovss	.LC7(%rip), %xmm8
 1065      00000000 
 1066 0f94 C5FA103D 		vmovss	.LC8(%rip), %xmm7
 1066      00000000 
 1067 0f9c C5FA1035 		vmovss	.LC9(%rip), %xmm6
 1067      00000000 
 1068 0fa4 C5FA102D 		vmovss	.LC10(%rip), %xmm5
 1068      00000000 
 1069 0fac C5FA1025 		vmovss	.LC11(%rip), %xmm4
 1069      00000000 
 1070 0fb4 C5FA101D 		vmovss	.LC12(%rip), %xmm3
 1070      00000000 
 117:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 1071              		.loc 1 117 33 view .LVU209
 1072 0fbc C5FA100D 		vmovss	.LC14(%rip), %xmm1
 1072      00000000 
 1073 0fc4 498D440D 		leaq	0(%r13,%rcx), %rax
 1073      00
 127:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 1074              		.loc 1 127 33 view .LVU210
 1075 0fc9 C4417828 		vmovaps	%xmm13, %xmm12
 1075      E5
 1076 0fce 4C01F1   		addq	%r14, %rcx
 1077 0fd1 C4417828 		vmovaps	%xmm13, %xmm15
 1077      FD
 1078 0fd6 662E0F1F 		.p2align 4,,10
 1078      84000000 
 1078      0000
 1079              		.p2align 3
 1080              	.L20:
 1081              	.LVL27:
 117:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 1082              		.loc 1 117 13 is_stmt 1 view .LVU211
 118:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1083              		.loc 1 118 48 is_stmt 0 view .LVU212
 1084 0fe0 0FB610   		movzbl	(%rax), %edx
 118:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1085              		.loc 1 118 38 view .LVU213
 1086 0fe3 C4410857 		vxorps	%xmm14, %xmm14, %xmm14
 1086      F6
 1087 0fe8 C58A2AC2 		vcvtsi2ssl	%edx, %xmm14, %xmm0
 119:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1088              		.loc 1 119 48 view .LVU214
 1089 0fec 0FB65001 		movzbl	1(%rax), %edx
 114:sepia_filter.c ****         {
 1090              		.loc 1 114 44 view .LVU215
 1091 0ff0 FFC6     		incl	%esi
 1092              	.LVL28:
 119:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1093              		.loc 1 119 38 view .LVU216
 1094 0ff2 C50A2AEA 		vcvtsi2ssl	%edx, %xmm14, %xmm13
 120:sepia_filter.c ****             /* G */
 1095              		.loc 1 120 48 view .LVU217
 1096 0ff6 0FB65002 		movzbl	2(%rax), %edx
 114:sepia_filter.c ****         {
 1097              		.loc 1 114 9 view .LVU218
 1098 0ffa 4883C103 		addq	$3, %rcx
 1099 0ffe 4883C003 		addq	$3, %rax
 119:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1100              		.loc 1 119 38 view .LVU219
 1101 1002 C4411259 		vmulss	%xmm11, %xmm13, %xmm13
 1101      EB
 1102 1007 C44279B9 		vfmadd231ss	%xmm10, %xmm0, %xmm13
 1102      EA
 120:sepia_filter.c ****             /* G */
 1103              		.loc 1 120 38 view .LVU220
 1104 100c C58A2AC2 		vcvtsi2ssl	%edx, %xmm14, %xmm0
 117:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 1105              		.loc 1 117 33 view .LVU221
 1106 1010 C4C21199 		vfmadd132ss	%xmm9, %xmm13, %xmm0
 1106      C1
 1107 1015 C5FA5DC2 		vminss	%xmm2, %xmm0, %xmm0
 1108 1019 C57054E8 		vandps	%xmm0, %xmm1, %xmm13
 1109 101d C4410056 		vorps	%xmm13, %xmm15, %xmm13
 1109      ED
 1110 1022 C51258E8 		vaddss	%xmm0, %xmm13, %xmm13
 123:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 1111              		.loc 1 123 38 view .LVU222
 1112 1026 C4417828 		vmovaps	%xmm14, %xmm15
 1112      FE
 117:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 1113              		.loc 1 117 33 view .LVU223
 1114 102b C4C17A2C 		vcvttss2sil	%xmm13, %edx
 1114      D5
 1115 1030 8851FD   		movb	%dl, -3(%rcx)
 122:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 1116              		.loc 1 122 13 is_stmt 1 view .LVU224
 123:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 1117              		.loc 1 123 48 is_stmt 0 view .LVU225
 1118 1033 0FB650FD 		movzbl	-3(%rax), %edx
 123:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 1119              		.loc 1 123 38 view .LVU226
 1120 1037 C58A2AC2 		vcvtsi2ssl	%edx, %xmm14, %xmm0
 124:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1121              		.loc 1 124 48 view .LVU227
 1122 103b 0FB650FE 		movzbl	-2(%rax), %edx
 124:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1123              		.loc 1 124 38 view .LVU228
 1124 103f C50A2AEA 		vcvtsi2ssl	%edx, %xmm14, %xmm13
 125:sepia_filter.c ****             /* B */
 1125              		.loc 1 125 48 view .LVU229
 1126 1043 0FB650FF 		movzbl	-1(%rax), %edx
 124:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1127              		.loc 1 124 38 view .LVU230
 1128 1047 C4411259 		vmulss	%xmm8, %xmm13, %xmm13
 1128      E8
 1129 104c C46279B9 		vfmadd231ss	%xmm7, %xmm0, %xmm13
 1129      EF
 125:sepia_filter.c ****             /* B */
 1130              		.loc 1 125 38 view .LVU231
 1131 1051 C58A2AC2 		vcvtsi2ssl	%edx, %xmm14, %xmm0
 122:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 1132              		.loc 1 122 33 view .LVU232
 1133 1055 C4E21199 		vfmadd132ss	%xmm6, %xmm13, %xmm0
 1133      C6
 1134 105a C57A102D 		vmovss	.LC5(%rip), %xmm13
 1134      00000000 
 1135 1062 C5FA5DC2 		vminss	%xmm2, %xmm0, %xmm0
 1136 1066 C57054F0 		vandps	%xmm0, %xmm1, %xmm14
 1137 106a C4411056 		vorps	%xmm14, %xmm13, %xmm13
 1137      EE
 1138 106f C51258E8 		vaddss	%xmm0, %xmm13, %xmm13
 1139 1073 C4C17A2C 		vcvttss2sil	%xmm13, %edx
 1139      D5
 1140 1078 8851FE   		movb	%dl, -2(%rcx)
 127:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 1141              		.loc 1 127 13 is_stmt 1 view .LVU233
 128:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1142              		.loc 1 128 48 is_stmt 0 view .LVU234
 1143 107b 0FB650FD 		movzbl	-3(%rax), %edx
 128:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1144              		.loc 1 128 38 view .LVU235
 1145 107f C5822AC2 		vcvtsi2ssl	%edx, %xmm15, %xmm0
 1146              		.loc 1 129 48 view .LVU236
 1147 1083 0FB650FE 		movzbl	-2(%rax), %edx
 1148              		.loc 1 129 38 view .LVU237
 1149 1087 C5022AEA 		vcvtsi2ssl	%edx, %xmm15, %xmm13
 130:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 1150              		.loc 1 130 48 view .LVU238
 1151 108b 0FB650FF 		movzbl	-1(%rax), %edx
 129:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 1152              		.loc 1 129 38 view .LVU239
 1153 108f C51259ED 		vmulss	%xmm5, %xmm13, %xmm13
 1154 1093 C46279B9 		vfmadd231ss	%xmm4, %xmm0, %xmm13
 1154      EC
 1155              		.loc 1 130 38 view .LVU240
 1156 1098 C5822AC2 		vcvtsi2ssl	%edx, %xmm15, %xmm0
 127:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 1157              		.loc 1 127 33 view .LVU241
 1158 109c C4417828 		vmovaps	%xmm12, %xmm15
 1158      FC
 1159 10a1 C4E21199 		vfmadd132ss	%xmm3, %xmm13, %xmm0
 1159      C3
 1160 10a6 C5FA5DC2 		vminss	%xmm2, %xmm0, %xmm0
 1161 10aa C57054F0 		vandps	%xmm0, %xmm1, %xmm14
 1162 10ae C4411856 		vorps	%xmm14, %xmm12, %xmm14
 1162      F6
 1163 10b3 C58A58C0 		vaddss	%xmm0, %xmm14, %xmm0
 1164 10b7 C5FA2CD0 		vcvttss2sil	%xmm0, %edx
 1165 10bb 8851FF   		movb	%dl, -1(%rcx)
 114:sepia_filter.c ****         {
 1166              		.loc 1 114 44 is_stmt 1 view .LVU242
 1167              	.LVL29:
 114:sepia_filter.c ****         {
 1168              		.loc 1 114 9 view .LVU243
 1169 10be 4139F7   		cmpl	%esi, %r15d
 1170 10c1 0F8F19FF 		jg	.L20
 1170      FFFF
 1171              	.LVL30:
 1172              	.L19:
 114:sepia_filter.c ****         {
 1173              		.loc 1 114 9 is_stmt 0 view .LVU244
 1174              	.LBE11:
 131:sepia_filter.c ****         }
 132:sepia_filter.c ****         dummy(image_in, image_out);
 1175              		.loc 1 132 9 is_stmt 1 view .LVU245
 1176 10c7 488BB5F8 		movq	-264(%rbp), %rsi
 1176      FEFFFF
 1177 10ce 488BBDF0 		movq	-272(%rbp), %rdi
 1177      FEFFFF
 1178 10d5 E8000000 		call	dummy
 1178      00
 1179              	.LVL31:
 111:sepia_filter.c ****     {
 1180              		.loc 1 111 34 view .LVU246
 111:sepia_filter.c ****     {
 1181              		.loc 1 111 23 view .LVU247
 1182 10da FFCB     		decl	%ebx
 1183 10dc 0F85FEF1 		jne	.L23
 1183      FFFF
 1184              	.L22:
 111:sepia_filter.c ****     {
 1185              		.loc 1 111 23 is_stmt 0 view .LVU248
 1186              	.LBE14:
 133:sepia_filter.c ****     }
 134:sepia_filter.c ****     end_t = get_wall_time();
 1187              		.loc 1 134 5 is_stmt 1 view .LVU249
 1188              		.loc 1 134 13 is_stmt 0 view .LVU250
 1189 10e2 31C0     		xorl	%eax, %eax
 1190 10e4 E8000000 		call	get_wall_time
 1190      00
 1191              	.LVL32:
 135:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_roundf1");
 1192              		.loc 1 135 5 is_stmt 1 view .LVU251
 1193 10e9 C5FB5C85 		vsubsd	-288(%rbp), %xmm0, %xmm0
 1193      E0FEFFFF 
 1194              	.LVL33:
 136:sepia_filter.c **** }
 1195              		.loc 1 136 1 is_stmt 0 view .LVU252
 1196 10f1 4881C408 		addq	$264, %rsp
 1196      010000
 1197 10f8 5B       		popq	%rbx
 1198 10f9 415C     		popq	%r12
 1199 10fb 415D     		popq	%r13
 1200              		.cfi_remember_state
 1201              		.cfi_def_cfa 13, 0
 1202              	.LVL34:
 1203              		.loc 1 136 1 view .LVU253
 1204 10fd 415E     		popq	%r14
 1205              	.LVL35:
 135:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_roundf1");
 1206              		.loc 1 135 5 view .LVU254
 1207 10ff 4489FF   		movl	%r15d, %edi
 1208              		.loc 1 136 1 view .LVU255
 1209 1102 415F     		popq	%r15
 1210 1104 5D       		popq	%rbp
 1211              	.LVL36:
 1212              		.loc 1 136 1 view .LVU256
 1213 1105 498D65F0 		leaq	-16(%r13), %rsp
 1214              		.cfi_def_cfa 7, 16
 135:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_roundf1");
 1215              		.loc 1 135 5 view .LVU257
 1216 1109 BE000000 		movl	$.LC100, %esi
 1216      00
 1217              		.loc 1 136 1 view .LVU258
 1218 110e 415D     		popq	%r13
 1219              		.cfi_def_cfa_offset 8
 135:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_roundf1");
 1220              		.loc 1 135 5 view .LVU259
 1221 1110 E9000000 		jmp	results
 1221      00
 1222              	.LVL37:
 1223              	.L35:
 1224              		.cfi_restore_state
 1225              	.LBB15:
 132:sepia_filter.c ****     }
 1226              		.loc 1 132 9 is_stmt 1 view .LVU260
 1227 1115 488BB5F8 		movq	-264(%rbp), %rsi
 1227      FEFFFF
 1228 111c 488BBDF0 		movq	-272(%rbp), %rdi
 1228      FEFFFF
 1229 1123 E8000000 		call	dummy
 1229      00
 1230              	.LVL38:
 111:sepia_filter.c ****     {
 1231              		.loc 1 111 34 view .LVU261
 111:sepia_filter.c ****     {
 1232              		.loc 1 111 23 view .LVU262
 1233 1128 FFCB     		decl	%ebx
 1234 112a 0F85A4F1 		jne	.L14
 1234      FFFF
 1235 1130 EBB0     		jmp	.L22
 1236              	.LVL39:
 1237              	.L25:
 1238              	.LBB12:
 114:sepia_filter.c ****         {
 1239              		.loc 1 114 18 is_stmt 0 view .LVU263
 1240 1132 31C0     		xorl	%eax, %eax
 1241 1134 31F6     		xorl	%esi, %esi
 1242 1136 E9D5F8FF 		jmp	.L15
 1242      FF
 1243              	.L17:
 114:sepia_filter.c ****         {
 1244              		.loc 1 114 18 view .LVU264
 1245              	.LBE12:
 132:sepia_filter.c ****     }
 1246              		.loc 1 132 9 is_stmt 1 view .LVU265
 1247 113b 488BB5F8 		movq	-264(%rbp), %rsi
 1247      FEFFFF
 1248 1142 488BBDF0 		movq	-272(%rbp), %rdi
 1248      FEFFFF
 1249 1149 C5F877   		vzeroupper
 1250              	.LVL40:
 1251 114c E8000000 		call	dummy
 1251      00
 1252              	.LVL41:
 111:sepia_filter.c ****     {
 1253              		.loc 1 111 34 view .LVU266
 111:sepia_filter.c ****     {
 1254              		.loc 1 111 23 view .LVU267
 1255 1151 FFCB     		decl	%ebx
 1256 1153 0F8587F1 		jne	.L23
 1256      FFFF
 1257 1159 EB87     		jmp	.L22
 1258              	.LVL42:
 1259              	.L38:
 111:sepia_filter.c ****     {
 1260              		.loc 1 111 23 is_stmt 0 view .LVU268
 1261              	.LBE15:
 100:sepia_filter.c ****         exit(-1);
 1262              		.loc 1 100 9 is_stmt 1 view .LVU269
 1263 115b BF000000 		movl	$.LC0, %edi
 1263      00
 1264              	.LVL43:
 100:sepia_filter.c ****         exit(-1);
 1265              		.loc 1 100 9 is_stmt 0 view .LVU270
 1266 1160 E8000000 		call	puts
 1266      00
 1267              	.LVL44:
 101:sepia_filter.c ****     }
 1268              		.loc 1 101 9 is_stmt 1 view .LVU271
 1269 1165 83CFFF   		orl	$-1, %edi
 1270 1168 E8000000 		call	exit
 1270      00
 1271              	.LVL45:
 1272              		.cfi_endproc
 1273              	.LFE19:
 1275              		.section	.rodata.str1.1
 1276              	.LC104:
 1277 001e 73657069 		.string	"sepiaf_cast0"
 1277      61665F63 
 1277      61737430 
 1277      00
 1278              		.text
 1279 116d 0F1F00   		.p2align 4
 1280              		.globl	sepia_filter_cast0
 1282              	sepia_filter_cast0:
 1283              	.LVL46:
 1284              	.LFB20:
 137:sepia_filter.c **** //----------------------------------------------------------------------------
 138:sepia_filter.c **** 
 139:sepia_filter.c **** /* cambios respecto sepia_filter_roundf2(): cast en lugar de roundf() */
 140:sepia_filter.c **** /* https://www.cs.tut.fi/~jkorpela/round.html */
 141:sepia_filter.c **** void
 142:sepia_filter.c **** sepia_filter_cast0(image_t * restrict image_in, image_t * restrict image_out)
 143:sepia_filter.c **** {
 1285              		.loc 1 143 1 view -0
 1286              		.cfi_startproc
 144:sepia_filter.c ****     double start_t, end_t;
 1287              		.loc 1 144 5 view .LVU273
 145:sepia_filter.c ****     const int height = image_in->height;
 1288              		.loc 1 145 5 view .LVU274
 143:sepia_filter.c ****     double start_t, end_t;
 1289              		.loc 1 143 1 is_stmt 0 view .LVU275
 1290 1170 4155     		pushq	%r13
 1291              		.cfi_def_cfa_offset 16
 1292              		.cfi_offset 13, -16
 1293 1172 4C8D6C24 		leaq	16(%rsp), %r13
 1293      10
 1294              		.cfi_def_cfa 13, 0
 1295 1177 4883E4E0 		andq	$-32, %rsp
 1296 117b 41FF75F8 		pushq	-8(%r13)
 1297 117f 55       		pushq	%rbp
 1298 1180 4889E5   		movq	%rsp, %rbp
 1299              		.cfi_escape 0x10,0x6,0x2,0x76,0
 1300 1183 4157     		pushq	%r15
 1301 1185 4156     		pushq	%r14
 1302 1187 4155     		pushq	%r13
 1303              		.cfi_escape 0xf,0x3,0x76,0x68,0x6
 1304              		.cfi_escape 0x10,0xf,0x2,0x76,0x78
 1305              		.cfi_escape 0x10,0xe,0x2,0x76,0x70
 1306 1189 4154     		pushq	%r12
 1307 118b 53       		pushq	%rbx
 1308 118c 4881EC68 		subq	$1128, %rsp
 1308      040000
 1309              		.cfi_escape 0x10,0xc,0x2,0x76,0x60
 1310              		.cfi_escape 0x10,0x3,0x2,0x76,0x58
 146:sepia_filter.c ****     const int width =  image_in->width;
 1311              		.loc 1 146 15 view .LVU276
 1312 1193 C5FA7E47 		vmovq	8(%rdi), %xmm0
 1312      08
 147:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 148:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
 149:sepia_filter.c **** 
 150:sepia_filter.c ****     if (image_in->bytes_per_pixel != 3)
 1313              		.loc 1 150 8 view .LVU277
 1314 1198 837F1003 		cmpl	$3, 16(%rdi)
 143:sepia_filter.c ****     double start_t, end_t;
 1315              		.loc 1 143 1 view .LVU278
 1316 119c 4889BD90 		movq	%rdi, -1136(%rbp)
 1316      FBFFFF
 1317 11a3 4889B598 		movq	%rsi, -1128(%rbp)
 1317      FBFFFF
 147:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 1318              		.loc 1 147 30 view .LVU279
 1319 11aa 4C8B2F   		movq	(%rdi), %r13
 148:sepia_filter.c **** 
 1320              		.loc 1 148 30 view .LVU280
 1321 11ad 4C8B36   		movq	(%rsi), %r14
 1322 11b0 C4C37916 		vpextrd	$1, %xmm0, %r15d
 1322      C701
 1323              	.LVL47:
 146:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 1324              		.loc 1 146 5 is_stmt 1 view .LVU281
 147:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
 1325              		.loc 1 147 5 view .LVU282
 148:sepia_filter.c **** 
 1326              		.loc 1 148 5 view .LVU283
 1327              		.loc 1 150 5 view .LVU284
 1328              		.loc 1 150 8 is_stmt 0 view .LVU285
 1329 11b6 0F851017 		jne	.L65
 1329      0000
 1330 11bc C4C1797E 		vmovd	%xmm0, %r12d
 1330      C4
 151:sepia_filter.c ****     {
 152:sepia_filter.c ****         printf("ERROR: input image has to be RGB\n");
 153:sepia_filter.c ****         exit(-1);
 154:sepia_filter.c ****     }
 155:sepia_filter.c ****     
 156:sepia_filter.c ****     /* fill struct fields */
 157:sepia_filter.c ****     image_out->width  = width;
 1331              		.loc 1 157 5 is_stmt 1 view .LVU286
 158:sepia_filter.c ****     image_out->height = height;
 1332              		.loc 1 158 5 view .LVU287
 159:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
 1333              		.loc 1 159 32 is_stmt 0 view .LVU288
 1334 11c1 48B90300 		movabsq	$8589934595, %rcx
 1334      00000200 
 1334      0000
 1335              	.LBB16:
 1336              	.LBB17:
 160:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 161:sepia_filter.c **** 
 162:sepia_filter.c ****     start_t = get_wall_time();
 163:sepia_filter.c **** 
 164:sepia_filter.c ****     for (int it = 0; it < NITER; it++)
 165:sepia_filter.c ****     {
 166:sepia_filter.c ****         #pragma GCC ivdep
 167:sepia_filter.c ****         for (int i = 0; i < height*width; i++)
 1337              		.loc 1 167 35 view .LVU289
 1338 11cb 450FAFFC 		imull	%r12d, %r15d
 1339              	.LBE17:
 1340              	.LBE16:
 159:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
 1341              		.loc 1 159 32 view .LVU290
 1342 11cf 48894E10 		movq	%rcx, 16(%rsi)
 162:sepia_filter.c **** 
 1343              		.loc 1 162 15 view .LVU291
 1344 11d3 31C0     		xorl	%eax, %eax
 157:sepia_filter.c ****     image_out->height = height;
 1345              		.loc 1 157 23 view .LVU292
 1346 11d5 C5F9D646 		vmovq	%xmm0, 8(%rsi)
 1346      08
 159:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 1347              		.loc 1 159 5 is_stmt 1 view .LVU293
 160:sepia_filter.c **** 
 1348              		.loc 1 160 5 view .LVU294
 162:sepia_filter.c **** 
 1349              		.loc 1 162 5 view .LVU295
 162:sepia_filter.c **** 
 1350              		.loc 1 162 15 is_stmt 0 view .LVU296
 1351 11da E8000000 		call	get_wall_time
 1351      00
 1352              	.LVL48:
 162:sepia_filter.c **** 
 1353              		.loc 1 162 15 view .LVU297
 1354 11df 418D47FF 		leal	-1(%r15), %eax
 1355 11e3 89858CFB 		movl	%eax, -1140(%rbp)
 1355      FFFF
 1356 11e9 4489F8   		movl	%r15d, %eax
 1357 11ec C1E805   		shrl	$5, %eax
 1358 11ef 488D0C40 		leaq	(%rax,%rax,2), %rcx
 1359 11f3 4489F8   		movl	%r15d, %eax
 1360 11f6 83E0E0   		andl	$-32, %eax
 1361 11f9 898588FB 		movl	%eax, -1144(%rbp)
 1361      FFFF
 1362 11ff 48C1E105 		salq	$5, %rcx
 1363 1203 C5FB1185 		vmovsd	%xmm0, -1152(%rbp)
 1363      80FBFFFF 
 1364              	.LVL49:
 164:sepia_filter.c ****     {
 1365              		.loc 1 164 5 is_stmt 1 view .LVU298
 1366              	.LBB21:
 164:sepia_filter.c ****     {
 1367              		.loc 1 164 10 view .LVU299
 164:sepia_filter.c ****     {
 1368              		.loc 1 164 25 view .LVU300
 1369 120b 4E8D2429 		leaq	(%rcx,%r13), %r12
 1370              	.LBB18:
 1371              		.loc 1 167 35 is_stmt 0 view .LVU301
 1372 120f BB0A0000 		movl	$10, %ebx
 1372      00
 1373              	.LVL50:
 1374              	.L41:
 1375              		.loc 1 167 9 is_stmt 1 view .LVU302
 1376 1214 4585FF   		testl	%r15d, %r15d
 1377 1217 0F8E8916 		jle	.L62
 1377      0000
 1378 121d C4411057 		vxorps	%xmm13, %xmm13, %xmm13
 1378      ED
 1379              	.LVL51:
 1380              		.p2align 4,,10
 1381 1222 660F1F44 		.p2align 3
 1381      0000
 1382              	.L50:
 1383              		.loc 1 167 9 is_stmt 0 view .LVU303
 1384 1228 83BD8CFB 		cmpl	$30, -1140(%rbp)
 1384      FFFF1E
 1385 122f 0F868E16 		jbe	.L52
 1385      0000
 168:sepia_filter.c ****         {
 169:sepia_filter.c ****             /* R */
 170:sepia_filter.c ****             pixels_out[3*i + 0] = (unsigned char) (fminf(MAXPIXV,
 1386              		.loc 1 170 35 view .LVU304
 1387 1235 BFFFFF00 		movl	$65535, %edi
 1387      00
 1388 123a C5F96EF7 		vmovd	%edi, %xmm6
 1389 123e C4E27D58 		vpbroadcastd	%xmm6, %ymm6
 1389      F6
 1390 1243 BFFF0000 		movl	$255, %edi
 1390      00
 1391 1248 C5FD7F75 		vmovdqa	%ymm6, -80(%rbp)
 1391      B0
 1392 124d C5F96EF7 		vmovd	%edi, %xmm6
 1393 1251 C4E27D79 		vpbroadcastw	%xmm6, %ymm6
 1393      F6
 1394 1256 C4627D19 		vbroadcastsd	.LC102(%rip), %ymm9
 1394      0D000000 
 1394      00
 1395 125f 4C89F6   		movq	%r14, %rsi
 1396              	.LBE18:
 1397              	.LBE21:
 143:sepia_filter.c ****     double start_t, end_t;
 1398              		.loc 1 143 1 view .LVU305
 1399 1262 4C89E8   		movq	%r13, %rax
 1400              	.LBB22:
 1401              	.LBB19:
 1402              		.loc 1 170 35 view .LVU306
 1403 1265 C5FD7F75 		vmovdqa	%ymm6, -112(%rbp)
 1403      90
 1404 126a 660F1F44 		.p2align 4,,10
 1404      0000
 1405              		.p2align 3
 1406              	.L43:
 1407              		.loc 1 170 13 is_stmt 1 discriminator 3 view .LVU307
 171:sepia_filter.c ****                           0.5 + 
 172:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 1408              		.loc 1 172 48 is_stmt 0 discriminator 3 view .LVU308
 1409 1270 C5FE6F00 		vmovdqu	(%rax), %ymm0
 1410 1274 C5FE6F60 		vmovdqu	32(%rax), %ymm4
 1410      20
 1411 1279 C4E27D00 		vpshufb	.LC15(%rip), %ymm0, %ymm1
 1411      0D000000 
 1411      00
 1412 1282 C5FE6F58 		vmovdqu	64(%rax), %ymm3
 1412      40
 1413 1287 C4E27D00 		vpshufb	.LC16(%rip), %ymm0, %ymm2
 1413      15000000 
 1413      00
 1414 1290 C4E3FD00 		vpermq	$78, %ymm1, %ymm1
 1414      C94E
 1415 1296 C4E25D00 		vpshufb	.LC17(%rip), %ymm4, %ymm5
 1415      2D000000 
 1415      00
 1416 129f C5EDEBD1 		vpor	%ymm1, %ymm2, %ymm2
 1417 12a3 C5EDEBD5 		vpor	%ymm5, %ymm2, %ymm2
 1418 12a7 C4E26500 		vpshufb	.LC18(%rip), %ymm3, %ymm5
 1418      2D000000 
 1418      00
 1419 12b0 C4E26500 		vpshufb	.LC20(%rip), %ymm3, %ymm1
 1419      0D000000 
 1419      00
 1420 12b9 C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 1420      ED4E
 1421 12bf C5F5EBCD 		vpor	%ymm5, %ymm1, %ymm1
 1422 12c3 C4E26D00 		vpshufb	.LC19(%rip), %ymm2, %ymm2
 1422      15000000 
 1422      00
 1423 12cc C4E27D00 		vpshufb	.LC21(%rip), %ymm0, %ymm5
 1423      2D000000 
 1423      00
 1424 12d5 C5EDEBD1 		vpor	%ymm1, %ymm2, %ymm2
 1425 12d9 C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 1425      ED4E
 1426 12df C4E27D00 		vpshufb	.LC22(%rip), %ymm0, %ymm1
 1426      0D000000 
 1426      00
 1427 12e8 C4E25D00 		vpshufb	.LC23(%rip), %ymm4, %ymm6
 1427      35000000 
 1427      00
 1428 12f1 C5F5EBCD 		vpor	%ymm5, %ymm1, %ymm1
 1429 12f5 C5F5EBCE 		vpor	%ymm6, %ymm1, %ymm1
 1430 12f9 C4E26500 		vpshufb	.LC24(%rip), %ymm3, %ymm6
 1430      35000000 
 1430      00
 1431 1302 C4E26500 		vpshufb	.LC26(%rip), %ymm3, %ymm5
 1431      2D000000 
 1431      00
 1432 130b C4E3FD00 		vpermq	$78, %ymm6, %ymm6
 1432      F64E
 1433 1311 C5D5EBEE 		vpor	%ymm6, %ymm5, %ymm5
 1434 1315 C4E27500 		vpshufb	.LC25(%rip), %ymm1, %ymm1
 1434      0D000000 
 1434      00
 1435 131e C5F5EBCD 		vpor	%ymm5, %ymm1, %ymm1
 1436 1322 C4E27D00 		vpshufb	.LC27(%rip), %ymm0, %ymm5
 1436      2D000000 
 1436      00
 1437 132b C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 1437      ED4E
 1438 1331 C4E27D00 		vpshufb	.LC28(%rip), %ymm0, %ymm0
 1438      05000000 
 1438      00
 1439 133a C4E25D00 		vpshufb	.LC29(%rip), %ymm4, %ymm4
 1439      25000000 
 1439      00
 1440 1343 C5FDEBC5 		vpor	%ymm5, %ymm0, %ymm0
 1441 1347 C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 1442 134b C4E26500 		vpshufb	.LC30(%rip), %ymm3, %ymm4
 1442      25000000 
 1442      00
 1443 1354 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 1443      E44E
 1444 135a C4E26500 		vpshufb	.LC31(%rip), %ymm3, %ymm3
 1444      1D000000 
 1444      00
 1445 1363 C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 1446 1367 C4E27D00 		vpshufb	.LC25(%rip), %ymm0, %ymm0
 1446      05000000 
 1446      00
 1447 1370 C5FDEBC3 		vpor	%ymm3, %ymm0, %ymm0
 1448 1374 C4E27D30 		vpmovzxbw	%xmm2, %ymm3
 1448      DA
 1449 1379 C4E27D33 		vpmovzxwd	%xmm3, %ymm4
 1449      E3
 1450 137e C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 1450      D201
 1451 1384 C4E37D39 		vextracti128	$0x1, %ymm3, %xmm3
 1451      DB01
 1452 138a C4E27D30 		vpmovzxbw	%xmm2, %ymm2
 1452      D2
 1453 138f C4E27D33 		vpmovzxwd	%xmm3, %ymm3
 1453      DB
 1454              		.loc 1 172 38 discriminator 3 view .LVU309
 1455 1394 C5FC5BF3 		vcvtdq2ps	%ymm3, %ymm6
 1456              		.loc 1 172 48 discriminator 3 view .LVU310
 1457 1398 C4E27D33 		vpmovzxwd	%xmm2, %ymm3
 1457      DA
 1458 139d C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 1458      D201
 1459 13a3 C4E27D33 		vpmovzxwd	%xmm2, %ymm2
 1459      D2
 1460              		.loc 1 172 38 discriminator 3 view .LVU311
 1461 13a8 C5FC5BD2 		vcvtdq2ps	%ymm2, %ymm2
 1462 13ac C56C5915 		vmulps	.LC33(%rip), %ymm2, %ymm10
 1462      00000000 
 1463 13b4 C5FC2995 		vmovaps	%ymm2, -240(%rbp)
 1463      10FFFFFF 
 173:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1464              		.loc 1 173 48 discriminator 3 view .LVU312
 1465 13bc C4E27D30 		vpmovzxbw	%xmm1, %ymm2
 1465      D1
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1466              		.loc 1 172 38 discriminator 3 view .LVU313
 1467 13c1 C5FC5BFB 		vcvtdq2ps	%ymm3, %ymm7
 1468              		.loc 1 173 48 discriminator 3 view .LVU314
 1469 13c5 C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 1469      C901
 1470 13cb C4E27D33 		vpmovzxwd	%xmm2, %ymm3
 1470      DA
 1471 13d0 C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 1471      D201
 1472 13d6 C4E27D30 		vpmovzxbw	%xmm1, %ymm1
 1472      C9
 1473 13db C4E27D33 		vpmovzxwd	%xmm2, %ymm2
 1473      D2
 1474              		.loc 1 173 38 discriminator 3 view .LVU315
 1475 13e0 C57C5BFB 		vcvtdq2ps	%ymm3, %ymm15
 1476 13e4 C5FC5BDA 		vcvtdq2ps	%ymm2, %ymm3
 1477              		.loc 1 173 48 discriminator 3 view .LVU316
 1478 13e8 C4E27D33 		vpmovzxwd	%xmm1, %ymm2
 1478      D1
 1479 13ed C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 1479      C901
 1480 13f3 C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 1480      C9
 1481              		.loc 1 173 38 discriminator 3 view .LVU317
 1482 13f8 C57C5BC1 		vcvtdq2ps	%ymm1, %ymm8
 1483 13fc C57C29C1 		vmovaps	%ymm8, %ymm1
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1484              		.loc 1 172 38 discriminator 3 view .LVU318
 1485 1400 C54C5925 		vmulps	.LC33(%rip), %ymm6, %ymm12
 1485      00000000 
 1486              		.loc 1 173 38 discriminator 3 view .LVU319
 1487 1408 C5045905 		vmulps	.LC32(%rip), %ymm15, %ymm8
 1487      00000000 
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1488              		.loc 1 172 38 discriminator 3 view .LVU320
 1489 1410 C5FC5BEC 		vcvtdq2ps	%ymm4, %ymm5
 1490 1414 C544591D 		vmulps	.LC33(%rip), %ymm7, %ymm11
 1490      00000000 
 1491 141c C5545935 		vmulps	.LC33(%rip), %ymm5, %ymm14
 1491      00000000 
 1492 1424 C5FC29AD 		vmovaps	%ymm5, -144(%rbp)
 1492      70FFFFFF 
 1493 142c C5FC29B5 		vmovaps	%ymm6, -176(%rbp)
 1493      50FFFFFF 
 1494              		.loc 1 173 38 discriminator 3 view .LVU321
 1495 1434 C57C29BD 		vmovaps	%ymm15, -272(%rbp)
 1495      F0FEFFFF 
 1496 143c C5FC299D 		vmovaps	%ymm3, -304(%rbp)
 1496      D0FEFFFF 
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1497              		.loc 1 172 38 discriminator 3 view .LVU322
 1498 1444 C5FC29BD 		vmovaps	%ymm7, -208(%rbp)
 1498      30FFFFFF 
 1499              		.loc 1 173 38 discriminator 3 view .LVU323
 1500 144c C5E4593D 		vmulps	.LC32(%rip), %ymm3, %ymm7
 1500      00000000 
 174:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 175:sepia_filter.c ****             /* G */
 176:sepia_filter.c ****             pixels_out[3*i + 1] = (unsigned char) (fminf(MAXPIXV,
 1501              		.loc 1 176 13 is_stmt 1 discriminator 3 view .LVU324
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1502              		.loc 1 173 38 is_stmt 0 discriminator 3 view .LVU325
 1503 1454 C5F4592D 		vmulps	.LC32(%rip), %ymm1, %ymm5
 1503      00000000 
 1504 145c C5FC298D 		vmovaps	%ymm1, -368(%rbp)
 1504      90FEFFFF 
 174:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1505              		.loc 1 174 48 discriminator 3 view .LVU326
 1506 1464 C4E27D30 		vpmovzxbw	%xmm0, %ymm1
 1506      C8
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1507              		.loc 1 173 38 discriminator 3 view .LVU327
 1508 1469 C5FC5BE2 		vcvtdq2ps	%ymm2, %ymm4
 174:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1509              		.loc 1 174 48 discriminator 3 view .LVU328
 1510 146d C4E27D33 		vpmovzxwd	%xmm1, %ymm2
 1510      D1
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1511              		.loc 1 173 38 discriminator 3 view .LVU329
 1512 1472 C5DC5935 		vmulps	.LC32(%rip), %ymm4, %ymm6
 1512      00000000 
 174:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1513              		.loc 1 174 38 discriminator 3 view .LVU330
 1514 147a C5FC5BD2 		vcvtdq2ps	%ymm2, %ymm2
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1515              		.loc 1 173 38 discriminator 3 view .LVU331
 1516 147e C5FC29A5 		vmovaps	%ymm4, -336(%rbp)
 1516      B0FEFFFF 
 174:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1517              		.loc 1 174 38 discriminator 3 view .LVU332
 1518 1486 C5EC5925 		vmulps	.LC34(%rip), %ymm2, %ymm4
 1518      00000000 
 174:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1519              		.loc 1 174 48 discriminator 3 view .LVU333
 1520 148e C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 1520      C001
 1521 1494 C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 1521      C901
 1522 149a C4E27D30 		vpmovzxbw	%xmm0, %ymm0
 1522      C0
 1523 149f C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 1523      C9
 174:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1524              		.loc 1 174 38 discriminator 3 view .LVU334
 1525 14a4 C5FC5BD9 		vcvtdq2ps	%ymm1, %ymm3
 174:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1526              		.loc 1 174 48 discriminator 3 view .LVU335
 1527 14a8 C4E27D33 		vpmovzxwd	%xmm0, %ymm1
 1527      C8
 1528 14ad C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 1528      C001
 1529 14b3 C4E27D33 		vpmovzxwd	%xmm0, %ymm0
 1529      C0
 174:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1530              		.loc 1 174 38 discriminator 3 view .LVU336
 1531 14b8 C57C5BF9 		vcvtdq2ps	%ymm1, %ymm15
 1532 14bc C5FC5BC0 		vcvtdq2ps	%ymm0, %ymm0
 1533 14c0 C5FC2995 		vmovaps	%ymm2, -400(%rbp)
 1533      70FEFFFF 
 1534 14c8 C5FC590D 		vmulps	.LC34(%rip), %ymm0, %ymm1
 1534      00000000 
 1535 14d0 C5845915 		vmulps	.LC34(%rip), %ymm15, %ymm2
 1535      00000000 
 1536 14d8 C57C29BD 		vmovaps	%ymm15, -464(%rbp)
 1536      30FEFFFF 
 1537 14e0 C5FC2985 		vmovaps	%ymm0, -496(%rbp)
 1537      10FEFFFF 
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1538              		.loc 1 172 38 discriminator 3 view .LVU337
 1539 14e8 C4417C5A 		vcvtps2pd	%xmm14, %ymm15
 1539      FE
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1540              		.loc 1 173 38 discriminator 3 view .LVU338
 1541 14ed C4C17C5A 		vcvtps2pd	%xmm8, %ymm0
 1541      C0
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1542              		.loc 1 172 38 discriminator 3 view .LVU339
 1543 14f2 C4437D19 		vextractf128	$0x1, %ymm14, %xmm14
 1543      F601
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1544              		.loc 1 173 58 discriminator 3 view .LVU340
 1545 14f8 C50558F8 		vaddpd	%ymm0, %ymm15, %ymm15
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1546              		.loc 1 173 38 discriminator 3 view .LVU341
 1547 14fc C4437D19 		vextractf128	$0x1, %ymm8, %xmm8
 1547      C001
 174:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1548              		.loc 1 174 38 discriminator 3 view .LVU342
 1549 1502 C5FC5AC4 		vcvtps2pd	%xmm4, %ymm0
 1550 1506 C4E37D19 		vextractf128	$0x1, %ymm4, %xmm4
 1550      E401
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1551              		.loc 1 172 38 discriminator 3 view .LVU343
 1552 150c C4417C5A 		vcvtps2pd	%xmm14, %ymm14
 1552      F6
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1553              		.loc 1 173 58 discriminator 3 view .LVU344
 1554 1511 C4C17D58 		vaddpd	%ymm9, %ymm0, %ymm0
 1554      C1
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1555              		.loc 1 173 38 discriminator 3 view .LVU345
 1556 1516 C4417C5A 		vcvtps2pd	%xmm8, %ymm8
 1556      C0
 174:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1557              		.loc 1 174 38 discriminator 3 view .LVU346
 1558 151b C5FC5AE4 		vcvtps2pd	%xmm4, %ymm4
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1559              		.loc 1 173 58 discriminator 3 view .LVU347
 1560 151f C4410D58 		vaddpd	%ymm8, %ymm14, %ymm8
 1560      C0
 1561 1524 C4C15D58 		vaddpd	%ymm9, %ymm4, %ymm4
 1561      E1
 174:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1562              		.loc 1 174 38 discriminator 3 view .LVU348
 1563 1529 C5FC299D 		vmovaps	%ymm3, -432(%rbp)
 1563      50FEFFFF 
 1564 1531 C5E4591D 		vmulps	.LC34(%rip), %ymm3, %ymm3
 1564      00000000 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1565              		.loc 1 173 58 discriminator 3 view .LVU349
 1566 1539 C58558C0 		vaddpd	%ymm0, %ymm15, %ymm0
 1567 153d C5BD58E4 		vaddpd	%ymm4, %ymm8, %ymm4
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1568              		.loc 1 172 38 discriminator 3 view .LVU350
 1569 1541 C4417C5A 		vcvtps2pd	%xmm12, %ymm8
 1569      C4
 170:sepia_filter.c ****                           0.5 + 
 1570              		.loc 1 170 52 discriminator 3 view .LVU351
 1571 1546 C5FD5AC0 		vcvtpd2psy	%ymm0, %xmm0
 1572 154a C5FD5AE4 		vcvtpd2psy	%ymm4, %xmm4
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1573              		.loc 1 172 38 discriminator 3 view .LVU352
 1574 154e C4437D19 		vextractf128	$0x1, %ymm12, %xmm12
 1574      E401
 170:sepia_filter.c ****                           0.5 + 
 1575              		.loc 1 170 52 discriminator 3 view .LVU353
 1576 1554 C4E37D18 		vinsertf128	$0x1, %xmm4, %ymm0, %ymm0
 1576      C401
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1577              		.loc 1 173 38 discriminator 3 view .LVU354
 1578 155a C5FC5AE7 		vcvtps2pd	%xmm7, %ymm4
 1579 155e C4E37D19 		vextractf128	$0x1, %ymm7, %xmm7
 1579      FF01
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1580              		.loc 1 173 58 discriminator 3 view .LVU355
 1581 1564 C53D58C4 		vaddpd	%ymm4, %ymm8, %ymm8
 174:sepia_filter.c ****             /* G */
 1582              		.loc 1 174 38 discriminator 3 view .LVU356
 1583 1568 C5FC5AE3 		vcvtps2pd	%xmm3, %ymm4
 1584 156c C4E37D19 		vextractf128	$0x1, %ymm3, %xmm3
 1584      DB01
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1585              		.loc 1 172 38 discriminator 3 view .LVU357
 1586 1572 C4417C5A 		vcvtps2pd	%xmm12, %ymm12
 1586      E4
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1587              		.loc 1 173 58 discriminator 3 view .LVU358
 1588 1577 C4C15D58 		vaddpd	%ymm9, %ymm4, %ymm4
 1588      E1
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1589              		.loc 1 173 38 discriminator 3 view .LVU359
 1590 157c C5FC5AFF 		vcvtps2pd	%xmm7, %ymm7
 174:sepia_filter.c ****             /* G */
 1591              		.loc 1 174 38 discriminator 3 view .LVU360
 1592 1580 C5FC5ADB 		vcvtps2pd	%xmm3, %ymm3
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1593              		.loc 1 173 58 discriminator 3 view .LVU361
 1594 1584 C59D58FF 		vaddpd	%ymm7, %ymm12, %ymm7
 1595 1588 C4C16558 		vaddpd	%ymm9, %ymm3, %ymm3
 1595      D9
 1596 158d C5BD58E4 		vaddpd	%ymm4, %ymm8, %ymm4
 170:sepia_filter.c ****                           0.5 + 
 1597              		.loc 1 170 52 discriminator 3 view .LVU362
 1598 1591 C5FC5D05 		vminps	.LC35(%rip), %ymm0, %ymm0
 1598      00000000 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1599              		.loc 1 173 58 discriminator 3 view .LVU363
 1600 1599 C5C558DB 		vaddpd	%ymm3, %ymm7, %ymm3
 170:sepia_filter.c ****                           0.5 + 
 1601              		.loc 1 170 52 discriminator 3 view .LVU364
 1602 159d C5FD5AE4 		vcvtpd2psy	%ymm4, %xmm4
 170:sepia_filter.c ****                           0.5 + 
 1603              		.loc 1 170 35 discriminator 3 view .LVU365
 1604 15a1 C5FD6F7D 		vmovdqa	-80(%rbp), %ymm7
 1604      B0
 170:sepia_filter.c ****                           0.5 + 
 1605              		.loc 1 170 52 discriminator 3 view .LVU366
 1606 15a6 C5FD5ADB 		vcvtpd2psy	%ymm3, %xmm3
 1607 15aa C4E35D18 		vinsertf128	$0x1, %xmm3, %ymm4, %ymm4
 1607      E301
 1608 15b0 C5DC5D25 		vminps	.LC35(%rip), %ymm4, %ymm4
 1608      00000000 
 170:sepia_filter.c ****                           0.5 + 
 1609              		.loc 1 170 35 discriminator 3 view .LVU367
 1610 15b8 C5FE5BC0 		vcvttps2dq	%ymm0, %ymm0
 1611 15bc C5FDDBC7 		vpand	%ymm7, %ymm0, %ymm0
 1612 15c0 C5FE5BE4 		vcvttps2dq	%ymm4, %ymm4
 1613 15c4 C5DDDBE7 		vpand	%ymm7, %ymm4, %ymm4
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1614              		.loc 1 173 38 discriminator 3 view .LVU368
 1615 15c8 C5FC5ADE 		vcvtps2pd	%xmm6, %ymm3
 170:sepia_filter.c ****                           0.5 + 
 1616              		.loc 1 170 35 discriminator 3 view .LVU369
 1617 15cc C4E27D2B 		vpackusdw	%ymm4, %ymm0, %ymm0
 1617      C4
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1618              		.loc 1 173 38 discriminator 3 view .LVU370
 1619 15d1 C4E37D19 		vextractf128	$0x1, %ymm6, %xmm6
 1619      F601
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1620              		.loc 1 172 38 discriminator 3 view .LVU371
 1621 15d7 C4C17C5A 		vcvtps2pd	%xmm11, %ymm4
 1621      E3
 1622 15dc C4437D19 		vextractf128	$0x1, %ymm11, %xmm11
 1622      DB01
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1623              		.loc 1 173 58 discriminator 3 view .LVU372
 1624 15e2 C5DD58E3 		vaddpd	%ymm3, %ymm4, %ymm4
 174:sepia_filter.c ****             /* G */
 1625              		.loc 1 174 38 discriminator 3 view .LVU373
 1626 15e6 C5FC5ADA 		vcvtps2pd	%xmm2, %ymm3
 1627 15ea C4E37D19 		vextractf128	$0x1, %ymm2, %xmm2
 1627      D201
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1628              		.loc 1 172 38 discriminator 3 view .LVU374
 1629 15f0 C4417C5A 		vcvtps2pd	%xmm11, %ymm11
 1629      DB
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1630              		.loc 1 173 58 discriminator 3 view .LVU375
 1631 15f5 C4C16558 		vaddpd	%ymm9, %ymm3, %ymm3
 1631      D9
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1632              		.loc 1 173 38 discriminator 3 view .LVU376
 1633 15fa C5FC5AF6 		vcvtps2pd	%xmm6, %ymm6
 174:sepia_filter.c ****             /* G */
 1634              		.loc 1 174 38 discriminator 3 view .LVU377
 1635 15fe C5FC5AD2 		vcvtps2pd	%xmm2, %ymm2
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1636              		.loc 1 173 58 discriminator 3 view .LVU378
 1637 1602 C5A558F6 		vaddpd	%ymm6, %ymm11, %ymm6
 1638 1606 C4C16D58 		vaddpd	%ymm9, %ymm2, %ymm2
 1638      D1
 1639 160b C5DD58DB 		vaddpd	%ymm3, %ymm4, %ymm3
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1640              		.loc 1 172 38 discriminator 3 view .LVU379
 1641 160f C4C17C5A 		vcvtps2pd	%xmm10, %ymm4
 1641      E2
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1642              		.loc 1 173 58 discriminator 3 view .LVU380
 1643 1614 C5CD58D2 		vaddpd	%ymm2, %ymm6, %ymm2
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1644              		.loc 1 172 38 discriminator 3 view .LVU381
 1645 1618 C4437D19 		vextractf128	$0x1, %ymm10, %xmm10
 1645      D201
 170:sepia_filter.c ****                           0.5 + 
 1646              		.loc 1 170 52 discriminator 3 view .LVU382
 1647 161e C5FD5ADB 		vcvtpd2psy	%ymm3, %xmm3
 1648 1622 C5FD5AD2 		vcvtpd2psy	%ymm2, %xmm2
 1649 1626 C4E36518 		vinsertf128	$0x1, %xmm2, %ymm3, %ymm3
 1649      DA01
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1650              		.loc 1 173 38 discriminator 3 view .LVU383
 1651 162c C5FC5AD5 		vcvtps2pd	%xmm5, %ymm2
 1652 1630 C4E37D19 		vextractf128	$0x1, %ymm5, %xmm5
 1652      ED01
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1653              		.loc 1 173 58 discriminator 3 view .LVU384
 1654 1636 C5DD58E2 		vaddpd	%ymm2, %ymm4, %ymm4
 174:sepia_filter.c ****             /* G */
 1655              		.loc 1 174 38 discriminator 3 view .LVU385
 1656 163a C5FC5AD1 		vcvtps2pd	%xmm1, %ymm2
 1657 163e C4E37D19 		vextractf128	$0x1, %ymm1, %xmm1
 1657      C901
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 1658              		.loc 1 172 38 discriminator 3 view .LVU386
 1659 1644 C4417C5A 		vcvtps2pd	%xmm10, %ymm10
 1659      D2
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1660              		.loc 1 173 58 discriminator 3 view .LVU387
 1661 1649 C4C16D58 		vaddpd	%ymm9, %ymm2, %ymm2
 1661      D1
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1662              		.loc 1 173 38 discriminator 3 view .LVU388
 1663 164e C5FC5AED 		vcvtps2pd	%xmm5, %ymm5
 174:sepia_filter.c ****             /* G */
 1664              		.loc 1 174 38 discriminator 3 view .LVU389
 1665 1652 C5FC5AC9 		vcvtps2pd	%xmm1, %ymm1
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1666              		.loc 1 173 58 discriminator 3 view .LVU390
 1667 1656 C5AD58ED 		vaddpd	%ymm5, %ymm10, %ymm5
 1668 165a C4C17558 		vaddpd	%ymm9, %ymm1, %ymm1
 1668      C9
 1669 165f C5DD58D2 		vaddpd	%ymm2, %ymm4, %ymm2
 170:sepia_filter.c ****                           0.5 + 
 1670              		.loc 1 170 52 discriminator 3 view .LVU391
 1671 1663 C5E45D1D 		vminps	.LC35(%rip), %ymm3, %ymm3
 1671      00000000 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 1672              		.loc 1 173 58 discriminator 3 view .LVU392
 1673 166b C5D558C9 		vaddpd	%ymm1, %ymm5, %ymm1
 170:sepia_filter.c ****                           0.5 + 
 1674              		.loc 1 170 52 discriminator 3 view .LVU393
 1675 166f C5FD5AD2 		vcvtpd2psy	%ymm2, %xmm2
 170:sepia_filter.c ****                           0.5 + 
 1676              		.loc 1 170 35 discriminator 3 view .LVU394
 1677 1673 C5FE5BDB 		vcvttps2dq	%ymm3, %ymm3
 170:sepia_filter.c ****                           0.5 + 
 1678              		.loc 1 170 52 discriminator 3 view .LVU395
 1679 1677 C5FD5AC9 		vcvtpd2psy	%ymm1, %xmm1
 1680 167b C4E36D18 		vinsertf128	$0x1, %xmm1, %ymm2, %ymm2
 1680      D101
 1681 1681 C5EC5D15 		vminps	.LC35(%rip), %ymm2, %ymm2
 1681      00000000 
 170:sepia_filter.c ****                           0.5 + 
 1682              		.loc 1 170 35 discriminator 3 view .LVU396
 1683 1689 C5E5DBDF 		vpand	%ymm7, %ymm3, %ymm3
 1684 168d C5FD6F75 		vmovdqa	-112(%rbp), %ymm6
 1684      90
 1685 1692 C5FE5BD2 		vcvttps2dq	%ymm2, %ymm2
 1686 1696 C5EDDBD7 		vpand	%ymm7, %ymm2, %ymm2
 1687 169a C4E2652B 		vpackusdw	%ymm2, %ymm3, %ymm3
 1687      DA
 1688 169f C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 1688      C0D8
 1689 16a5 C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 1689      DBD8
 1690 16ab C5E5DBDE 		vpand	%ymm6, %ymm3, %ymm3
 1691 16af C5FDDBC6 		vpand	%ymm6, %ymm0, %ymm0
 1692 16b3 C5FD67C3 		vpackuswb	%ymm3, %ymm0, %ymm0
 177:sepia_filter.c ****                           0.5 +
 178:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 1693              		.loc 1 178 38 discriminator 3 view .LVU397
 1694 16b7 C5FC288D 		vmovaps	-176(%rbp), %ymm1
 1694      50FFFFFF 
 1695 16bf C5FC289D 		vmovaps	-144(%rbp), %ymm3
 1695      70FFFFFF 
 1696 16c7 C5FC28A5 		vmovaps	-208(%rbp), %ymm4
 1696      30FFFFFF 
 1697 16cf C5FC2895 		vmovaps	-240(%rbp), %ymm2
 1697      10FFFFFF 
 179:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 1698              		.loc 1 179 38 discriminator 3 view .LVU398
 1699 16d7 C57C28BD 		vmovaps	-272(%rbp), %ymm15
 1699      F0FEFFFF 
 170:sepia_filter.c ****                           0.5 + 
 1700              		.loc 1 170 35 discriminator 3 view .LVU399
 1701 16df C4E3FD00 		vpermq	$216, %ymm0, %ymm5
 1701      E8D8
 1702              		.loc 1 179 38 discriminator 3 view .LVU400
 1703 16e5 C5FC2885 		vmovaps	-304(%rbp), %ymm0
 1703      D0FEFFFF 
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 1704              		.loc 1 178 38 discriminator 3 view .LVU401
 1705 16ed C5645935 		vmulps	.LC41(%rip), %ymm3, %ymm14
 1705      00000000 
 1706 16f5 C5745925 		vmulps	.LC41(%rip), %ymm1, %ymm12
 1706      00000000 
 1707 16fd C55C591D 		vmulps	.LC41(%rip), %ymm4, %ymm11
 1707      00000000 
 1708 1705 C56C5915 		vmulps	.LC41(%rip), %ymm2, %ymm10
 1708      00000000 
 1709              		.loc 1 179 38 discriminator 3 view .LVU402
 1710 170d C5045905 		vmulps	.LC40(%rip), %ymm15, %ymm8
 1710      00000000 
 1711 1715 C5FC593D 		vmulps	.LC40(%rip), %ymm0, %ymm7
 1711      00000000 
 170:sepia_filter.c ****                           0.5 + 
 1712              		.loc 1 170 35 discriminator 3 view .LVU403
 1713 171d C5FD7FAD 		vmovdqa	%ymm5, -528(%rbp)
 1713      F0FDFFFF 
 1714              		.loc 1 179 38 discriminator 3 view .LVU404
 1715 1725 C5FC2885 		vmovaps	-336(%rbp), %ymm0
 1715      B0FEFFFF 
 180:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1716              		.loc 1 180 38 discriminator 3 view .LVU405
 1717 172d C5FC2895 		vmovaps	-432(%rbp), %ymm2
 1717      50FEFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1718              		.loc 1 179 38 discriminator 3 view .LVU406
 1719 1735 C5FC5935 		vmulps	.LC40(%rip), %ymm0, %ymm6
 1719      00000000 
 1720              		.loc 1 180 38 discriminator 3 view .LVU407
 1721 173d C5FC2885 		vmovaps	-400(%rbp), %ymm0
 1721      70FEFFFF 
 1722 1745 C57C28BD 		vmovaps	-464(%rbp), %ymm15
 1722      30FEFFFF 
 1723 174d C5FC5925 		vmulps	.LC42(%rip), %ymm0, %ymm4
 1723      00000000 
 1724 1755 C5FC2885 		vmovaps	-496(%rbp), %ymm0
 1724      10FEFFFF 
 1725 175d C5EC591D 		vmulps	.LC42(%rip), %ymm2, %ymm3
 1725      00000000 
 1726 1765 C5FC590D 		vmulps	.LC42(%rip), %ymm0, %ymm1
 1726      00000000 
 1727 176d C5845915 		vmulps	.LC42(%rip), %ymm15, %ymm2
 1727      00000000 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1728              		.loc 1 179 38 discriminator 3 view .LVU408
 1729 1775 C4C17C5A 		vcvtps2pd	%xmm8, %ymm0
 1729      C0
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 1730              		.loc 1 178 38 discriminator 3 view .LVU409
 1731 177a C4417C5A 		vcvtps2pd	%xmm14, %ymm15
 1731      FE
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1732              		.loc 1 179 38 discriminator 3 view .LVU410
 1733 177f C4437D19 		vextractf128	$0x1, %ymm8, %xmm8
 1733      C001
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1734              		.loc 1 179 58 discriminator 3 view .LVU411
 1735 1785 C50558F8 		vaddpd	%ymm0, %ymm15, %ymm15
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 1736              		.loc 1 178 38 discriminator 3 view .LVU412
 1737 1789 C4437D19 		vextractf128	$0x1, %ymm14, %xmm14
 1737      F601
 1738              		.loc 1 180 38 discriminator 3 view .LVU413
 1739 178f C5FC5AC4 		vcvtps2pd	%xmm4, %ymm0
 1740 1793 C4E37D19 		vextractf128	$0x1, %ymm4, %xmm4
 1740      E401
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 1741              		.loc 1 178 38 discriminator 3 view .LVU414
 1742 1799 C4417C5A 		vcvtps2pd	%xmm14, %ymm14
 1742      F6
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1743              		.loc 1 179 58 discriminator 3 view .LVU415
 1744 179e C4C17D58 		vaddpd	%ymm9, %ymm0, %ymm0
 1744      C1
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1745              		.loc 1 179 38 discriminator 3 view .LVU416
 1746 17a3 C4417C5A 		vcvtps2pd	%xmm8, %ymm8
 1746      C0
 1747              		.loc 1 180 38 discriminator 3 view .LVU417
 1748 17a8 C5FC5AE4 		vcvtps2pd	%xmm4, %ymm4
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1749              		.loc 1 179 58 discriminator 3 view .LVU418
 1750 17ac C4410D58 		vaddpd	%ymm8, %ymm14, %ymm8
 1750      C0
 1751 17b1 C4C15D58 		vaddpd	%ymm9, %ymm4, %ymm4
 1751      E1
 1752 17b6 C58558C0 		vaddpd	%ymm0, %ymm15, %ymm0
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1753              		.loc 1 179 38 discriminator 3 view .LVU419
 1754 17ba C5FC28AD 		vmovaps	-368(%rbp), %ymm5
 1754      90FEFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1755              		.loc 1 179 58 discriminator 3 view .LVU420
 1756 17c2 C5BD58E4 		vaddpd	%ymm4, %ymm8, %ymm4
 176:sepia_filter.c ****                           0.5 +
 1757              		.loc 1 176 52 discriminator 3 view .LVU421
 1758 17c6 C5FD5AC0 		vcvtpd2psy	%ymm0, %xmm0
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 1759              		.loc 1 178 38 discriminator 3 view .LVU422
 1760 17ca C4417C5A 		vcvtps2pd	%xmm12, %ymm8
 1760      C4
 176:sepia_filter.c ****                           0.5 +
 1761              		.loc 1 176 52 discriminator 3 view .LVU423
 1762 17cf C5FD5AE4 		vcvtpd2psy	%ymm4, %xmm4
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 1763              		.loc 1 178 38 discriminator 3 view .LVU424
 1764 17d3 C4437D19 		vextractf128	$0x1, %ymm12, %xmm12
 1764      E401
 176:sepia_filter.c ****                           0.5 +
 1765              		.loc 1 176 52 discriminator 3 view .LVU425
 1766 17d9 C4E37D18 		vinsertf128	$0x1, %xmm4, %ymm0, %ymm0
 1766      C401
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1767              		.loc 1 179 38 discriminator 3 view .LVU426
 1768 17df C5FC5AE7 		vcvtps2pd	%xmm7, %ymm4
 1769 17e3 C4E37D19 		vextractf128	$0x1, %ymm7, %xmm7
 1769      FF01
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1770              		.loc 1 179 58 discriminator 3 view .LVU427
 1771 17e9 C53D58C4 		vaddpd	%ymm4, %ymm8, %ymm8
 1772              		.loc 1 180 38 discriminator 3 view .LVU428
 1773 17ed C5FC5AE3 		vcvtps2pd	%xmm3, %ymm4
 1774 17f1 C4E37D19 		vextractf128	$0x1, %ymm3, %xmm3
 1774      DB01
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 1775              		.loc 1 178 38 discriminator 3 view .LVU429
 1776 17f7 C4417C5A 		vcvtps2pd	%xmm12, %ymm12
 1776      E4
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1777              		.loc 1 179 58 discriminator 3 view .LVU430
 1778 17fc C4C15D58 		vaddpd	%ymm9, %ymm4, %ymm4
 1778      E1
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1779              		.loc 1 179 38 discriminator 3 view .LVU431
 1780 1801 C5FC5AFF 		vcvtps2pd	%xmm7, %ymm7
 1781              		.loc 1 180 38 discriminator 3 view .LVU432
 1782 1805 C5FC5ADB 		vcvtps2pd	%xmm3, %ymm3
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1783              		.loc 1 179 58 discriminator 3 view .LVU433
 1784 1809 C59D58FF 		vaddpd	%ymm7, %ymm12, %ymm7
 1785 180d C4C16558 		vaddpd	%ymm9, %ymm3, %ymm3
 1785      D9
 1786 1812 C5BD58E4 		vaddpd	%ymm4, %ymm8, %ymm4
 176:sepia_filter.c ****                           0.5 +
 1787              		.loc 1 176 52 discriminator 3 view .LVU434
 1788 1816 C5FC5D05 		vminps	.LC35(%rip), %ymm0, %ymm0
 1788      00000000 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1789              		.loc 1 179 58 discriminator 3 view .LVU435
 1790 181e C5C558DB 		vaddpd	%ymm3, %ymm7, %ymm3
 176:sepia_filter.c ****                           0.5 +
 1791              		.loc 1 176 52 discriminator 3 view .LVU436
 1792 1822 C5FD5AE4 		vcvtpd2psy	%ymm4, %xmm4
 176:sepia_filter.c ****                           0.5 +
 1793              		.loc 1 176 35 discriminator 3 view .LVU437
 1794 1826 C5FD6F7D 		vmovdqa	-80(%rbp), %ymm7
 1794      B0
 176:sepia_filter.c ****                           0.5 +
 1795              		.loc 1 176 52 discriminator 3 view .LVU438
 1796 182b C5FD5ADB 		vcvtpd2psy	%ymm3, %xmm3
 1797 182f C4E35D18 		vinsertf128	$0x1, %xmm3, %ymm4, %ymm4
 1797      E301
 1798 1835 C5DC5D25 		vminps	.LC35(%rip), %ymm4, %ymm4
 1798      00000000 
 176:sepia_filter.c ****                           0.5 +
 1799              		.loc 1 176 35 discriminator 3 view .LVU439
 1800 183d C5FE5BC0 		vcvttps2dq	%ymm0, %ymm0
 1801 1841 C5FDDBC7 		vpand	%ymm7, %ymm0, %ymm0
 1802 1845 C5FE5BE4 		vcvttps2dq	%ymm4, %ymm4
 1803 1849 C5DDDBE7 		vpand	%ymm7, %ymm4, %ymm4
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1804              		.loc 1 179 38 discriminator 3 view .LVU440
 1805 184d C5FC5ADE 		vcvtps2pd	%xmm6, %ymm3
 176:sepia_filter.c ****                           0.5 +
 1806              		.loc 1 176 35 discriminator 3 view .LVU441
 1807 1851 C4E27D2B 		vpackusdw	%ymm4, %ymm0, %ymm0
 1807      C4
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1808              		.loc 1 179 38 discriminator 3 view .LVU442
 1809 1856 C4E37D19 		vextractf128	$0x1, %ymm6, %xmm6
 1809      F601
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 1810              		.loc 1 178 38 discriminator 3 view .LVU443
 1811 185c C4C17C5A 		vcvtps2pd	%xmm11, %ymm4
 1811      E3
 1812 1861 C4437D19 		vextractf128	$0x1, %ymm11, %xmm11
 1812      DB01
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1813              		.loc 1 179 58 discriminator 3 view .LVU444
 1814 1867 C5DD58E3 		vaddpd	%ymm3, %ymm4, %ymm4
 1815              		.loc 1 180 38 discriminator 3 view .LVU445
 1816 186b C5FC5ADA 		vcvtps2pd	%xmm2, %ymm3
 1817 186f C4E37D19 		vextractf128	$0x1, %ymm2, %xmm2
 1817      D201
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 1818              		.loc 1 178 38 discriminator 3 view .LVU446
 1819 1875 C4417C5A 		vcvtps2pd	%xmm11, %ymm11
 1819      DB
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1820              		.loc 1 179 58 discriminator 3 view .LVU447
 1821 187a C4C16558 		vaddpd	%ymm9, %ymm3, %ymm3
 1821      D9
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1822              		.loc 1 179 38 discriminator 3 view .LVU448
 1823 187f C5FC5AF6 		vcvtps2pd	%xmm6, %ymm6
 1824              		.loc 1 180 38 discriminator 3 view .LVU449
 1825 1883 C5FC5AD2 		vcvtps2pd	%xmm2, %ymm2
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1826              		.loc 1 179 58 discriminator 3 view .LVU450
 1827 1887 C5A558F6 		vaddpd	%ymm6, %ymm11, %ymm6
 1828 188b C4C16D58 		vaddpd	%ymm9, %ymm2, %ymm2
 1828      D1
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1829              		.loc 1 179 38 discriminator 3 view .LVU451
 1830 1890 C5D4592D 		vmulps	.LC40(%rip), %ymm5, %ymm5
 1830      00000000 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1831              		.loc 1 179 58 discriminator 3 view .LVU452
 1832 1898 C5DD58DB 		vaddpd	%ymm3, %ymm4, %ymm3
 1833 189c C5CD58D2 		vaddpd	%ymm2, %ymm6, %ymm2
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 1834              		.loc 1 178 38 discriminator 3 view .LVU453
 1835 18a0 C4C17C5A 		vcvtps2pd	%xmm10, %ymm4
 1835      E2
 176:sepia_filter.c ****                           0.5 +
 1836              		.loc 1 176 52 discriminator 3 view .LVU454
 1837 18a5 C5FD5ADB 		vcvtpd2psy	%ymm3, %xmm3
 1838 18a9 C5FD5AD2 		vcvtpd2psy	%ymm2, %xmm2
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 1839              		.loc 1 178 38 discriminator 3 view .LVU455
 1840 18ad C4437D19 		vextractf128	$0x1, %ymm10, %xmm10
 1840      D201
 176:sepia_filter.c ****                           0.5 +
 1841              		.loc 1 176 52 discriminator 3 view .LVU456
 1842 18b3 C4E36518 		vinsertf128	$0x1, %xmm2, %ymm3, %ymm3
 1842      DA01
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1843              		.loc 1 179 38 discriminator 3 view .LVU457
 1844 18b9 C5FC5AD5 		vcvtps2pd	%xmm5, %ymm2
 1845 18bd C4E37D19 		vextractf128	$0x1, %ymm5, %xmm5
 1845      ED01
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1846              		.loc 1 179 58 discriminator 3 view .LVU458
 1847 18c3 C5DD58E2 		vaddpd	%ymm2, %ymm4, %ymm4
 1848              		.loc 1 180 38 discriminator 3 view .LVU459
 1849 18c7 C5FC5AD1 		vcvtps2pd	%xmm1, %ymm2
 1850 18cb C4E37D19 		vextractf128	$0x1, %ymm1, %xmm1
 1850      C901
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 1851              		.loc 1 178 38 discriminator 3 view .LVU460
 1852 18d1 C4417C5A 		vcvtps2pd	%xmm10, %ymm10
 1852      D2
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1853              		.loc 1 179 58 discriminator 3 view .LVU461
 1854 18d6 C4C16D58 		vaddpd	%ymm9, %ymm2, %ymm2
 1854      D1
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1855              		.loc 1 179 38 discriminator 3 view .LVU462
 1856 18db C5FC5AED 		vcvtps2pd	%xmm5, %ymm5
 1857              		.loc 1 180 38 discriminator 3 view .LVU463
 1858 18df C5FC5AC9 		vcvtps2pd	%xmm1, %ymm1
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1859              		.loc 1 179 58 discriminator 3 view .LVU464
 1860 18e3 C5AD58ED 		vaddpd	%ymm5, %ymm10, %ymm5
 1861 18e7 C4C17558 		vaddpd	%ymm9, %ymm1, %ymm1
 1861      C9
 1862 18ec C5DD58D2 		vaddpd	%ymm2, %ymm4, %ymm2
 176:sepia_filter.c ****                           0.5 +
 1863              		.loc 1 176 52 discriminator 3 view .LVU465
 1864 18f0 C5E45D1D 		vminps	.LC35(%rip), %ymm3, %ymm3
 1864      00000000 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 1865              		.loc 1 179 58 discriminator 3 view .LVU466
 1866 18f8 C5D558C9 		vaddpd	%ymm1, %ymm5, %ymm1
 176:sepia_filter.c ****                           0.5 +
 1867              		.loc 1 176 52 discriminator 3 view .LVU467
 1868 18fc C5FD5AD2 		vcvtpd2psy	%ymm2, %xmm2
 176:sepia_filter.c ****                           0.5 +
 1869              		.loc 1 176 35 discriminator 3 view .LVU468
 1870 1900 C5FE5BDB 		vcvttps2dq	%ymm3, %ymm3
 176:sepia_filter.c ****                           0.5 +
 1871              		.loc 1 176 52 discriminator 3 view .LVU469
 1872 1904 C5FD5AC9 		vcvtpd2psy	%ymm1, %xmm1
 1873 1908 C4E36D18 		vinsertf128	$0x1, %xmm1, %ymm2, %ymm2
 1873      D101
 1874 190e C5EC5D15 		vminps	.LC35(%rip), %ymm2, %ymm2
 1874      00000000 
 176:sepia_filter.c ****                           0.5 +
 1875              		.loc 1 176 35 discriminator 3 view .LVU470
 1876 1916 C5E5DBDF 		vpand	%ymm7, %ymm3, %ymm3
 1877 191a C5FD6F75 		vmovdqa	-112(%rbp), %ymm6
 1877      90
 1878 191f C5FE5BD2 		vcvttps2dq	%ymm2, %ymm2
 1879 1923 C5EDDBD7 		vpand	%ymm7, %ymm2, %ymm2
 1880 1927 C4E2652B 		vpackusdw	%ymm2, %ymm3, %ymm3
 1880      DA
 1881 192c C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 1881      C0D8
 1882 1932 C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 1882      DBD8
 1883 1938 C5E5DBDE 		vpand	%ymm6, %ymm3, %ymm3
 1884 193c C5FDDBC6 		vpand	%ymm6, %ymm0, %ymm0
 181:sepia_filter.c ****             /* B */
 182:sepia_filter.c ****             pixels_out[3*i + 2] = (unsigned char) (fminf(MAXPIXV,
 183:sepia_filter.c ****                           0.5 +
 184:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 1885              		.loc 1 184 38 discriminator 3 view .LVU471
 1886 1940 C5FC288D 		vmovaps	-176(%rbp), %ymm1
 1886      50FFFFFF 
 176:sepia_filter.c ****                           0.5 +
 1887              		.loc 1 176 35 discriminator 3 view .LVU472
 1888 1948 C5FD67C3 		vpackuswb	%ymm3, %ymm0, %ymm0
 1889              		.loc 1 184 38 discriminator 3 view .LVU473
 1890 194c C5FC289D 		vmovaps	-144(%rbp), %ymm3
 1890      70FFFFFF 
 1891 1954 C5FC28A5 		vmovaps	-208(%rbp), %ymm4
 1891      30FFFFFF 
 1892 195c C5645935 		vmulps	.LC44(%rip), %ymm3, %ymm14
 1892      00000000 
 1893 1964 C5F4591D 		vmulps	.LC44(%rip), %ymm1, %ymm3
 1893      00000000 
 1894 196c C5FC288D 		vmovaps	-240(%rbp), %ymm1
 1894      10FFFFFF 
 185:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1895              		.loc 1 185 38 discriminator 3 view .LVU474
 1896 1974 C57C28BD 		vmovaps	-272(%rbp), %ymm15
 1896      F0FEFFFF 
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1897              		.loc 1 184 38 discriminator 3 view .LVU475
 1898 197c C574591D 		vmulps	.LC44(%rip), %ymm1, %ymm11
 1898      00000000 
 1899              		.loc 1 185 38 discriminator 3 view .LVU476
 1900 1984 C5FC288D 		vmovaps	-304(%rbp), %ymm1
 1900      D0FEFFFF 
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1901              		.loc 1 184 38 discriminator 3 view .LVU477
 1902 198c C5DC5915 		vmulps	.LC44(%rip), %ymm4, %ymm2
 1902      00000000 
 1903              		.loc 1 185 38 discriminator 3 view .LVU478
 1904 1994 C5745925 		vmulps	.LC43(%rip), %ymm1, %ymm12
 1904      00000000 
 1905 199c C5FC288D 		vmovaps	-336(%rbp), %ymm1
 1905      B0FEFFFF 
 1906 19a4 C5845925 		vmulps	.LC43(%rip), %ymm15, %ymm4
 1906      00000000 
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1907              		.loc 1 184 38 discriminator 3 view .LVU479
 1908 19ac C57C299D 		vmovaps	%ymm11, -144(%rbp)
 1908      70FFFFFF 
 1909              		.loc 1 185 38 discriminator 3 view .LVU480
 1910 19b4 C574591D 		vmulps	.LC43(%rip), %ymm1, %ymm11
 1910      00000000 
 1911 19bc C5FC288D 		vmovaps	-368(%rbp), %ymm1
 1911      90FEFFFF 
 186:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 1912              		.loc 1 186 38 discriminator 3 view .LVU481
 1913 19c4 C57C28BD 		vmovaps	-464(%rbp), %ymm15
 1913      30FEFFFF 
 185:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1914              		.loc 1 185 38 discriminator 3 view .LVU482
 1915 19cc C5745915 		vmulps	.LC43(%rip), %ymm1, %ymm10
 1915      00000000 
 1916              		.loc 1 186 38 discriminator 3 view .LVU483
 1917 19d4 C5FC288D 		vmovaps	-400(%rbp), %ymm1
 1917      70FEFFFF 
 1918 19dc C5845935 		vmulps	.LC45(%rip), %ymm15, %ymm6
 1918      00000000 
 1919 19e4 C5745905 		vmulps	.LC45(%rip), %ymm1, %ymm8
 1919      00000000 
 1920 19ec C5FC288D 		vmovaps	-432(%rbp), %ymm1
 1920      50FEFFFF 
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1921              		.loc 1 184 38 discriminator 3 view .LVU484
 1922 19f4 C4417C5A 		vcvtps2pd	%xmm14, %ymm15
 1922      FE
 1923              		.loc 1 186 38 discriminator 3 view .LVU485
 1924 19f9 C5F4593D 		vmulps	.LC45(%rip), %ymm1, %ymm7
 1924      00000000 
 1925 1a01 C5FC288D 		vmovaps	-496(%rbp), %ymm1
 1925      10FEFFFF 
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1926              		.loc 1 184 38 discriminator 3 view .LVU486
 1927 1a09 C4437D19 		vextractf128	$0x1, %ymm14, %xmm14
 1927      F601
 1928              		.loc 1 186 38 discriminator 3 view .LVU487
 1929 1a0f C5F4592D 		vmulps	.LC45(%rip), %ymm1, %ymm5
 1929      00000000 
 185:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1930              		.loc 1 185 38 discriminator 3 view .LVU488
 1931 1a17 C5FC5ACC 		vcvtps2pd	%xmm4, %ymm1
 1932 1a1b C4E37D19 		vextractf128	$0x1, %ymm4, %xmm4
 1932      E401
 185:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1933              		.loc 1 185 58 discriminator 3 view .LVU489
 1934 1a21 C50558F9 		vaddpd	%ymm1, %ymm15, %ymm15
 1935              		.loc 1 186 38 discriminator 3 view .LVU490
 1936 1a25 C4C17C5A 		vcvtps2pd	%xmm8, %ymm1
 1936      C8
 1937 1a2a C4437D19 		vextractf128	$0x1, %ymm8, %xmm8
 1937      C001
 185:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1938              		.loc 1 185 58 discriminator 3 view .LVU491
 1939 1a30 C4C17558 		vaddpd	%ymm9, %ymm1, %ymm1
 1939      C9
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1940              		.loc 1 184 38 discriminator 3 view .LVU492
 1941 1a35 C4417C5A 		vcvtps2pd	%xmm14, %ymm14
 1941      F6
 185:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1942              		.loc 1 185 38 discriminator 3 view .LVU493
 1943 1a3a C5FC5AE4 		vcvtps2pd	%xmm4, %ymm4
 1944              		.loc 1 186 38 discriminator 3 view .LVU494
 1945 1a3e C4417C5A 		vcvtps2pd	%xmm8, %ymm8
 1945      C0
 185:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1946              		.loc 1 185 58 discriminator 3 view .LVU495
 1947 1a43 C58D58E4 		vaddpd	%ymm4, %ymm14, %ymm4
 1948 1a47 C4413D58 		vaddpd	%ymm9, %ymm8, %ymm8
 1948      C1
 1949 1a4c C58558C9 		vaddpd	%ymm1, %ymm15, %ymm1
 176:sepia_filter.c ****                           0.5 +
 1950              		.loc 1 176 35 discriminator 3 view .LVU496
 1951 1a50 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 1951      C0D8
 182:sepia_filter.c ****                           0.5 +
 1952              		.loc 1 182 13 is_stmt 1 discriminator 3 view .LVU497
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 1953              		.loc 1 185 58 is_stmt 0 discriminator 3 view .LVU498
 1954 1a56 C4C15D58 		vaddpd	%ymm8, %ymm4, %ymm4
 1954      E0
 182:sepia_filter.c ****                           0.5 +
 1955              		.loc 1 182 52 discriminator 3 view .LVU499
 1956 1a5b C5FD5AC9 		vcvtpd2psy	%ymm1, %xmm1
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 1957              		.loc 1 185 38 discriminator 3 view .LVU500
 1958 1a5f C4417C5A 		vcvtps2pd	%xmm12, %ymm8
 1958      C4
 182:sepia_filter.c ****                           0.5 +
 1959              		.loc 1 182 52 discriminator 3 view .LVU501
 1960 1a64 C5FD5AE4 		vcvtpd2psy	%ymm4, %xmm4
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 1961              		.loc 1 185 38 discriminator 3 view .LVU502
 1962 1a68 C4437D19 		vextractf128	$0x1, %ymm12, %xmm12
 1962      E401
 182:sepia_filter.c ****                           0.5 +
 1963              		.loc 1 182 52 discriminator 3 view .LVU503
 1964 1a6e C4E37518 		vinsertf128	$0x1, %xmm4, %ymm1, %ymm1
 1964      CC01
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1965              		.loc 1 184 38 discriminator 3 view .LVU504
 1966 1a74 C5FC5AE3 		vcvtps2pd	%xmm3, %ymm4
 1967 1a78 C4E37D19 		vextractf128	$0x1, %ymm3, %xmm3
 1967      DB01
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 1968              		.loc 1 185 58 discriminator 3 view .LVU505
 1969 1a7e C4C15D58 		vaddpd	%ymm8, %ymm4, %ymm4
 1969      E0
 1970              		.loc 1 186 38 discriminator 3 view .LVU506
 1971 1a83 C57C5AC7 		vcvtps2pd	%xmm7, %ymm8
 1972 1a87 C4E37D19 		vextractf128	$0x1, %ymm7, %xmm7
 1972      FF01
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 1973              		.loc 1 185 58 discriminator 3 view .LVU507
 1974 1a8d C4413D58 		vaddpd	%ymm9, %ymm8, %ymm8
 1974      C1
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 1975              		.loc 1 184 38 discriminator 3 view .LVU508
 1976 1a92 C5FC5ADB 		vcvtps2pd	%xmm3, %ymm3
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 1977              		.loc 1 185 38 discriminator 3 view .LVU509
 1978 1a96 C4417C5A 		vcvtps2pd	%xmm12, %ymm12
 1978      E4
 1979              		.loc 1 186 38 discriminator 3 view .LVU510
 1980 1a9b C5FC5AFF 		vcvtps2pd	%xmm7, %ymm7
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 1981              		.loc 1 185 58 discriminator 3 view .LVU511
 1982 1a9f C4C16558 		vaddpd	%ymm12, %ymm3, %ymm3
 1982      DC
 1983 1aa4 C4C14558 		vaddpd	%ymm9, %ymm7, %ymm7
 1983      F9
 1984 1aa9 C4C15D58 		vaddpd	%ymm8, %ymm4, %ymm4
 1984      E0
 182:sepia_filter.c ****                           0.5 +
 1985              		.loc 1 182 52 discriminator 3 view .LVU512
 1986 1aae C5F45D0D 		vminps	.LC35(%rip), %ymm1, %ymm1
 1986      00000000 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 1987              		.loc 1 185 58 discriminator 3 view .LVU513
 1988 1ab6 C5E558DF 		vaddpd	%ymm7, %ymm3, %ymm3
 182:sepia_filter.c ****                           0.5 +
 1989              		.loc 1 182 52 discriminator 3 view .LVU514
 1990 1aba C5FD5AE4 		vcvtpd2psy	%ymm4, %xmm4
 182:sepia_filter.c ****                           0.5 +
 1991              		.loc 1 182 35 discriminator 3 view .LVU515
 1992 1abe C5FD6F7D 		vmovdqa	-80(%rbp), %ymm7
 1992      B0
 182:sepia_filter.c ****                           0.5 +
 1993              		.loc 1 182 52 discriminator 3 view .LVU516
 1994 1ac3 C5FD5ADB 		vcvtpd2psy	%ymm3, %xmm3
 1995 1ac7 C4E35D18 		vinsertf128	$0x1, %xmm3, %ymm4, %ymm4
 1995      E301
 1996 1acd C5DC5D25 		vminps	.LC35(%rip), %ymm4, %ymm4
 1996      00000000 
 182:sepia_filter.c ****                           0.5 +
 1997              		.loc 1 182 35 discriminator 3 view .LVU517
 1998 1ad5 C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 1999 1ad9 C5F5DBDF 		vpand	%ymm7, %ymm1, %ymm3
 2000 1add C5FE5BE4 		vcvttps2dq	%ymm4, %ymm4
 2001 1ae1 C5DDDBE7 		vpand	%ymm7, %ymm4, %ymm4
 2002 1ae5 C4E2652B 		vpackusdw	%ymm4, %ymm3, %ymm3
 2002      DC
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2003              		.loc 1 184 38 discriminator 3 view .LVU518
 2004 1aea C5FC5ACA 		vcvtps2pd	%xmm2, %ymm1
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2005              		.loc 1 185 38 discriminator 3 view .LVU519
 2006 1aee C4C17C5A 		vcvtps2pd	%xmm11, %ymm4
 2006      E3
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2007              		.loc 1 184 38 discriminator 3 view .LVU520
 2008 1af3 C4E37D19 		vextractf128	$0x1, %ymm2, %xmm2
 2008      D201
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2009              		.loc 1 185 58 discriminator 3 view .LVU521
 2010 1af9 C5F558CC 		vaddpd	%ymm4, %ymm1, %ymm1
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2011              		.loc 1 185 38 discriminator 3 view .LVU522
 2012 1afd C4437D19 		vextractf128	$0x1, %ymm11, %xmm11
 2012      DB01
 2013              		.loc 1 186 38 discriminator 3 view .LVU523
 2014 1b03 C5FC5AE6 		vcvtps2pd	%xmm6, %ymm4
 2015 1b07 C4E37D19 		vextractf128	$0x1, %ymm6, %xmm6
 2015      F601
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2016              		.loc 1 185 58 discriminator 3 view .LVU524
 2017 1b0d C4C15D58 		vaddpd	%ymm9, %ymm4, %ymm4
 2017      E1
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2018              		.loc 1 185 38 discriminator 3 view .LVU525
 2019 1b12 C4417C5A 		vcvtps2pd	%xmm11, %ymm11
 2019      DB
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2020              		.loc 1 184 38 discriminator 3 view .LVU526
 2021 1b17 C5FC5AD2 		vcvtps2pd	%xmm2, %ymm2
 2022              		.loc 1 186 38 discriminator 3 view .LVU527
 2023 1b1b C5FC5AF6 		vcvtps2pd	%xmm6, %ymm6
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2024              		.loc 1 185 58 discriminator 3 view .LVU528
 2025 1b1f C4C16D58 		vaddpd	%ymm11, %ymm2, %ymm2
 2025      D3
 2026 1b24 C4C14D58 		vaddpd	%ymm9, %ymm6, %ymm6
 2026      F1
 2027 1b29 C5F558CC 		vaddpd	%ymm4, %ymm1, %ymm1
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2028              		.loc 1 184 38 discriminator 3 view .LVU529
 2029 1b2d C57C289D 		vmovaps	-144(%rbp), %ymm11
 2029      70FFFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2030              		.loc 1 185 58 discriminator 3 view .LVU530
 2031 1b35 C5ED58D6 		vaddpd	%ymm6, %ymm2, %ymm2
 182:sepia_filter.c ****                           0.5 +
 2032              		.loc 1 182 52 discriminator 3 view .LVU531
 2033 1b39 C5FD5AC9 		vcvtpd2psy	%ymm1, %xmm1
 2034              		.loc 1 186 38 discriminator 3 view .LVU532
 2035 1b3d C5FC5AF5 		vcvtps2pd	%xmm5, %ymm6
 182:sepia_filter.c ****                           0.5 +
 2036              		.loc 1 182 52 discriminator 3 view .LVU533
 2037 1b41 C5FD5AD2 		vcvtpd2psy	%ymm2, %xmm2
 2038              		.loc 1 186 38 discriminator 3 view .LVU534
 2039 1b45 C4E37D19 		vextractf128	$0x1, %ymm5, %xmm5
 2039      ED01
 182:sepia_filter.c ****                           0.5 +
 2040              		.loc 1 182 52 discriminator 3 view .LVU535
 2041 1b4b C4E37518 		vinsertf128	$0x1, %xmm2, %ymm1, %ymm1
 2041      CA01
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2042              		.loc 1 184 38 discriminator 3 view .LVU536
 2043 1b51 C4C17C5A 		vcvtps2pd	%xmm11, %ymm4
 2043      E3
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2044              		.loc 1 185 38 discriminator 3 view .LVU537
 2045 1b56 C4C17C5A 		vcvtps2pd	%xmm10, %ymm2
 2045      D2
 2046 1b5b C4437D19 		vextractf128	$0x1, %ymm10, %xmm10
 2046      D201
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2047              		.loc 1 185 58 discriminator 3 view .LVU538
 2048 1b61 C5DD58E2 		vaddpd	%ymm2, %ymm4, %ymm4
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2049              		.loc 1 184 38 discriminator 3 view .LVU539
 2050 1b65 C4637D19 		vextractf128	$0x1, %ymm11, %xmm2
 2050      DA01
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2051              		.loc 1 185 58 discriminator 3 view .LVU540
 2052 1b6b C4C14D58 		vaddpd	%ymm9, %ymm6, %ymm6
 2052      F1
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2053              		.loc 1 184 38 discriminator 3 view .LVU541
 2054 1b70 C5FC5AD2 		vcvtps2pd	%xmm2, %ymm2
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2055              		.loc 1 185 38 discriminator 3 view .LVU542
 2056 1b74 C4417C5A 		vcvtps2pd	%xmm10, %ymm10
 2056      D2
 2057              		.loc 1 186 38 discriminator 3 view .LVU543
 2058 1b79 C5FC5AED 		vcvtps2pd	%xmm5, %ymm5
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2059              		.loc 1 185 58 discriminator 3 view .LVU544
 2060 1b7d C4C16D58 		vaddpd	%ymm10, %ymm2, %ymm2
 2060      D2
 2061 1b82 C4C15558 		vaddpd	%ymm9, %ymm5, %ymm5
 2061      E9
 2062 1b87 C5DD58E6 		vaddpd	%ymm6, %ymm4, %ymm4
 182:sepia_filter.c ****                           0.5 +
 2063              		.loc 1 182 52 discriminator 3 view .LVU545
 2064 1b8b C5F45D0D 		vminps	.LC35(%rip), %ymm1, %ymm1
 2064      00000000 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2065              		.loc 1 185 58 discriminator 3 view .LVU546
 2066 1b93 C5ED58D5 		vaddpd	%ymm5, %ymm2, %ymm2
 182:sepia_filter.c ****                           0.5 +
 2067              		.loc 1 182 52 discriminator 3 view .LVU547
 2068 1b97 C5FD5AE4 		vcvtpd2psy	%ymm4, %xmm4
 182:sepia_filter.c ****                           0.5 +
 2069              		.loc 1 182 35 discriminator 3 view .LVU548
 2070 1b9b C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 182:sepia_filter.c ****                           0.5 +
 2071              		.loc 1 182 52 discriminator 3 view .LVU549
 2072 1b9f C5FD5AD2 		vcvtpd2psy	%ymm2, %xmm2
 2073 1ba3 C4E35D18 		vinsertf128	$0x1, %xmm2, %ymm4, %ymm2
 2073      D201
 2074 1ba9 C5EC5D15 		vminps	.LC35(%rip), %ymm2, %ymm2
 2074      00000000 
 182:sepia_filter.c ****                           0.5 +
 2075              		.loc 1 182 35 discriminator 3 view .LVU550
 2076 1bb1 C5F5DBCF 		vpand	%ymm7, %ymm1, %ymm1
 2077 1bb5 C5FD6F75 		vmovdqa	-112(%rbp), %ymm6
 2077      90
 2078 1bba C5FE5BD2 		vcvttps2dq	%ymm2, %ymm2
 2079 1bbe C5EDDBD7 		vpand	%ymm7, %ymm2, %ymm2
 2080 1bc2 C4E2752B 		vpackusdw	%ymm2, %ymm1, %ymm2
 2080      D2
 2081 1bc7 C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 2081      DBD8
 2082 1bcd C4E3FD00 		vpermq	$216, %ymm2, %ymm2
 2082      D2D8
 2083 1bd3 C5E5DBCE 		vpand	%ymm6, %ymm3, %ymm1
 2084 1bd7 C5EDDBD6 		vpand	%ymm6, %ymm2, %ymm2
 182:sepia_filter.c ****                           0.5 +
 2085              		.loc 1 182 33 discriminator 3 view .LVU551
 2086 1bdb C5FD6FB5 		vmovdqa	-528(%rbp), %ymm6
 2086      F0FDFFFF 
 2087 1be3 C4E27D00 		vpshufb	.LC47(%rip), %ymm0, %ymm4
 2087      25000000 
 2087      00
 182:sepia_filter.c ****                           0.5 +
 2088              		.loc 1 182 35 discriminator 3 view .LVU552
 2089 1bec C5F567CA 		vpackuswb	%ymm2, %ymm1, %ymm1
 182:sepia_filter.c ****                           0.5 +
 2090              		.loc 1 182 33 discriminator 3 view .LVU553
 2091 1bf0 C4E24D00 		vpshufb	.LC46(%rip), %ymm6, %ymm5
 2091      2D000000 
 2091      00
 182:sepia_filter.c ****                           0.5 +
 2092              		.loc 1 182 35 discriminator 3 view .LVU554
 2093 1bf9 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 2093      C9D8
 182:sepia_filter.c ****                           0.5 +
 2094              		.loc 1 182 33 discriminator 3 view .LVU555
 2095 1bff C4E27D00 		vpshufb	.LC49(%rip), %ymm0, %ymm3
 2095      1D000000 
 2095      00
 2096 1c08 C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 2096      ED4E
 2097 1c0e C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 2097      E44E
 2098 1c14 C4E24D00 		vpshufb	.LC48(%rip), %ymm6, %ymm2
 2098      15000000 
 2098      00
 2099 1c1d C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 2100 1c21 C5EDEBD5 		vpor	%ymm5, %ymm2, %ymm2
 2101 1c25 C4E27500 		vpshufb	.LC50(%rip), %ymm1, %ymm4
 2101      25000000 
 2101      00
 2102 1c2e C5EDEBD3 		vpor	%ymm3, %ymm2, %ymm2
 2103 1c32 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 2103      E44E
 2104 1c38 C4E27500 		vpshufb	.LC52(%rip), %ymm1, %ymm3
 2104      1D000000 
 2104      00
 2105 1c41 C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 2106 1c45 C4E26D00 		vpshufb	.LC51(%rip), %ymm2, %ymm2
 2106      15000000 
 2106      00
 2107 1c4e C5EDEBD3 		vpor	%ymm3, %ymm2, %ymm2
 2108 1c52 C4E24D00 		vpshufb	.LC53(%rip), %ymm6, %ymm3
 2108      1D000000 
 2108      00
 2109 1c5b C5FE7F16 		vmovdqu	%ymm2, (%rsi)
 2110 1c5f C4E3FD00 		vpermq	$78, %ymm3, %ymm3
 2110      DB4E
 2111 1c65 C4E24D00 		vpshufb	.LC54(%rip), %ymm6, %ymm2
 2111      15000000 
 2111      00
 2112 1c6e C4E27D00 		vpshufb	.LC55(%rip), %ymm0, %ymm4
 2112      25000000 
 2112      00
 2113 1c77 C5FD6F2D 		vmovdqa	.LC57(%rip), %ymm5
 2113      00000000 
 2114 1c7f C5EDEBD3 		vpor	%ymm3, %ymm2, %ymm2
 2115 1c83 C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 2116 1c87 C4E27500 		vpshufb	.LC56(%rip), %ymm1, %ymm3
 2116      1D000000 
 2116      00
 2117 1c90 C4E3654C 		vpblendvb	%ymm5, %ymm2, %ymm3, %ymm2
 2117      D250
 2118 1c96 C5FE7F56 		vmovdqu	%ymm2, 32(%rsi)
 2118      20
 2119 1c9b C4E27D00 		vpshufb	.LC58(%rip), %ymm0, %ymm4
 2119      25000000 
 2119      00
 2120 1ca4 C4E24D00 		vpshufb	.LC59(%rip), %ymm6, %ymm3
 2120      1D000000 
 2120      00
 2121 1cad C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 2121      E44E
 2122 1cb3 C4E3FD00 		vpermq	$78, %ymm3, %ymm3
 2122      DB4E
 2123 1cb9 C4E27D00 		vpshufb	.LC60(%rip), %ymm0, %ymm0
 2123      05000000 
 2123      00
 2124 1cc2 C4E24D00 		vpshufb	.LC61(%rip), %ymm6, %ymm2
 2124      15000000 
 2124      00
 2125 1ccb C5EDEBD3 		vpor	%ymm3, %ymm2, %ymm2
 2126 1ccf C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 2127 1cd3 C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 2128 1cd7 C4E27500 		vpshufb	.LC62(%rip), %ymm1, %ymm2
 2128      15000000 
 2128      00
 2129 1ce0 C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 2129      D24E
 2130 1ce6 C4E27500 		vpshufb	.LC64(%rip), %ymm1, %ymm1
 2130      0D000000 
 2130      00
 2131 1cef C4E27D00 		vpshufb	.LC63(%rip), %ymm0, %ymm0
 2131      05000000 
 2131      00
 2132 1cf8 C5F5EBCA 		vpor	%ymm2, %ymm1, %ymm1
 2133 1cfc C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 2134 1d00 4883C060 		addq	$96, %rax
 2135 1d04 C5FE7F46 		vmovdqu	%ymm0, 64(%rsi)
 2135      40
 167:sepia_filter.c ****         {
 2136              		.loc 1 167 44 is_stmt 1 discriminator 3 view .LVU556
 167:sepia_filter.c ****         {
 2137              		.loc 1 167 9 discriminator 3 view .LVU557
 2138 1d09 4883C660 		addq	$96, %rsi
 2139 1d0d 4C39E0   		cmpq	%r12, %rax
 2140 1d10 0F855AF5 		jne	.L43
 2140      FFFF
 2141 1d16 8BBD88FB 		movl	-1144(%rbp), %edi
 2141      FFFF
 2142 1d1c 89F8     		movl	%edi, %eax
 2143 1d1e 4439F8   		cmpl	%r15d, %eax
 2144 1d21 0F84290B 		je	.L44
 2144      0000
 2145              	.L42:
 167:sepia_filter.c ****         {
 2146              		.loc 1 167 9 is_stmt 0 discriminator 3 view .LVU558
 2147 1d27 4489FE   		movl	%r15d, %esi
 2148 1d2a 29C6     		subl	%eax, %esi
 2149 1d2c 448D56FF 		leal	-1(%rsi), %r10d
 2150 1d30 4183FA0E 		cmpl	$14, %r10d
 2151 1d34 0F869409 		jbe	.L45
 2151      0000
 2152 1d3a 488D0440 		leaq	(%rax,%rax,2), %rax
 2153 1d3e 4D8D5405 		leaq	0(%r13,%rax), %r10
 2153      00
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2154              		.loc 1 172 48 view .LVU559
 2155 1d43 C4C17A6F 		vmovdqu	(%r10), %xmm4
 2155      22
 2156 1d48 C4C17A6F 		vmovdqu	16(%r10), %xmm0
 2156      4210
 2157 1d4e C4C17A6F 		vmovdqu	32(%r10), %xmm3
 2157      5A20
 2158 1d54 C5F96F2D 		vmovdqa	.LC68(%rip), %xmm5
 2158      00000000 
 2159 1d5c C4E27900 		vpshufb	.LC66(%rip), %xmm0, %xmm1
 2159      0D000000 
 2159      00
 2160 1d65 C4E25900 		vpshufb	.LC65(%rip), %xmm4, %xmm2
 2160      15000000 
 2160      00
 2161 1d6e C5E9EBD1 		vpor	%xmm1, %xmm2, %xmm2
 2162 1d72 C4E26100 		vpshufb	.LC67(%rip), %xmm3, %xmm1
 2162      0D000000 
 2162      00
 2163 1d7b C4E3694C 		vpblendvb	%xmm5, %xmm1, %xmm2, %xmm2
 2163      D150
 2164 1d81 C4E25900 		vpshufb	.LC69(%rip), %xmm4, %xmm6
 2164      35000000 
 2164      00
 2165 1d8a C4E27900 		vpshufb	.LC70(%rip), %xmm0, %xmm1
 2165      0D000000 
 2165      00
 2166 1d93 C4E25900 		vpshufb	.LC72(%rip), %xmm4, %xmm4
 2166      25000000 
 2166      00
 2167 1d9c C4E27900 		vpshufb	.LC73(%rip), %xmm0, %xmm0
 2167      05000000 
 2167      00
 2168 1da5 C5C9EBC9 		vpor	%xmm1, %xmm6, %xmm1
 2169 1da9 C5D9EBC0 		vpor	%xmm0, %xmm4, %xmm0
 2170 1dad C4E26100 		vpshufb	.LC71(%rip), %xmm3, %xmm6
 2170      35000000 
 2170      00
 2171 1db6 C4E26100 		vpshufb	.LC74(%rip), %xmm3, %xmm3
 2171      1D000000 
 2171      00
 2172 1dbf C4E3790E 		vpblendw	$224, %xmm3, %xmm0, %xmm0
 2172      C3E0
 2173 1dc5 C4E27930 		vpmovzxbw	%xmm2, %xmm3
 2173      DA
 2174 1dca C4E27933 		vpmovzxwd	%xmm3, %xmm4
 2174      E3
 2175 1dcf C5E973DA 		vpsrldq	$8, %xmm2, %xmm2
 2175      08
 2176 1dd4 C5E173DB 		vpsrldq	$8, %xmm3, %xmm3
 2176      08
 2177 1dd9 C4E27930 		vpmovzxbw	%xmm2, %xmm2
 2177      D2
 2178 1dde C4E27933 		vpmovzxwd	%xmm3, %xmm3
 2178      DB
 2179 1de3 C4E3714C 		vpblendvb	%xmm5, %xmm6, %xmm1, %xmm1
 2179      CE50
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2180              		.loc 1 172 38 view .LVU560
 2181 1de9 C5F85BFB 		vcvtdq2ps	%xmm3, %xmm7
 2182 1ded C4E27918 		vbroadcastss	.LC2(%rip), %xmm6
 2182      35000000 
 2182      00
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2183              		.loc 1 172 48 view .LVU561
 2184 1df6 C4E27933 		vpmovzxwd	%xmm2, %xmm3
 2184      DA
 2185 1dfb C5E973DA 		vpsrldq	$8, %xmm2, %xmm2
 2185      08
 2186 1e00 C4E27933 		vpmovzxwd	%xmm2, %xmm2
 2186      D2
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2187              		.loc 1 172 38 view .LVU562
 2188 1e05 C54859DF 		vmulps	%xmm7, %xmm6, %xmm11
 2189 1e09 C5F85BEC 		vcvtdq2ps	%xmm4, %xmm5
 2190 1e0d C5F85BDB 		vcvtdq2ps	%xmm3, %xmm3
 2191 1e11 C54859FD 		vmulps	%xmm5, %xmm6, %xmm15
 2192 1e15 C54859CB 		vmulps	%xmm3, %xmm6, %xmm9
 2193 1e19 C5F85BD2 		vcvtdq2ps	%xmm2, %xmm2
 2194 1e1d C5C859F2 		vmulps	%xmm2, %xmm6, %xmm6
 2195 1e21 C5F82995 		vmovaps	%xmm2, -240(%rbp)
 2195      10FFFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2196              		.loc 1 173 48 view .LVU563
 2197 1e29 C4E27930 		vpmovzxbw	%xmm1, %xmm2
 2197      D1
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2198              		.loc 1 172 38 view .LVU564
 2199 1e2e C5F8299D 		vmovaps	%xmm3, -208(%rbp)
 2199      30FFFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2200              		.loc 1 173 48 view .LVU565
 2201 1e36 C5F173D9 		vpsrldq	$8, %xmm1, %xmm1
 2201      08
 2202 1e3b C4E27933 		vpmovzxwd	%xmm2, %xmm3
 2202      DA
 2203 1e40 C5E973DA 		vpsrldq	$8, %xmm2, %xmm2
 2203      08
 2204 1e45 C4E27930 		vpmovzxbw	%xmm1, %xmm1
 2204      C9
 2205 1e4a C4E27933 		vpmovzxwd	%xmm2, %xmm2
 2205      D2
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2206              		.loc 1 173 38 view .LVU566
 2207 1e4f C5785BC2 		vcvtdq2ps	%xmm2, %xmm8
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2208              		.loc 1 172 38 view .LVU567
 2209 1e53 C5F829AD 		vmovaps	%xmm5, -144(%rbp)
 2209      70FFFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2210              		.loc 1 173 48 view .LVU568
 2211 1e5b C4E27933 		vpmovzxwd	%xmm1, %xmm2
 2211      D1
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2212              		.loc 1 173 38 view .LVU569
 2213 1e60 C4E27918 		vbroadcastss	.LC1(%rip), %xmm5
 2213      2D000000 
 2213      00
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2214              		.loc 1 173 48 view .LVU570
 2215 1e69 C5F173D9 		vpsrldq	$8, %xmm1, %xmm1
 2215      08
 2216 1e6e C4E27933 		vpmovzxwd	%xmm1, %xmm1
 2216      C9
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2217              		.loc 1 173 38 view .LVU571
 2218 1e73 C5785BD3 		vcvtdq2ps	%xmm3, %xmm10
 2219 1e77 C5785BE2 		vcvtdq2ps	%xmm2, %xmm12
 2220 1e7b C4415059 		vmulps	%xmm10, %xmm5, %xmm14
 2220      F2
 2221 1e80 C5F85BC9 		vcvtdq2ps	%xmm1, %xmm1
 2222 1e84 C5782995 		vmovaps	%xmm10, -272(%rbp)
 2222      F0FEFFFF 
 2223 1e8c C5782985 		vmovaps	%xmm8, -304(%rbp)
 2223      D0FEFFFF 
 2224 1e94 C4415059 		vmulps	%xmm8, %xmm5, %xmm10
 2224      D0
 2225 1e99 C5F8298D 		vmovaps	%xmm1, -368(%rbp)
 2225      90FEFFFF 
 2226 1ea1 C4415059 		vmulps	%xmm12, %xmm5, %xmm8
 2226      C4
 2227 1ea6 C5D059E9 		vmulps	%xmm1, %xmm5, %xmm5
 174:sepia_filter.c ****             /* G */
 2228              		.loc 1 174 48 view .LVU572
 2229 1eaa C4E27930 		vpmovzxbw	%xmm0, %xmm1
 2229      C8
 2230 1eaf C4E27933 		vpmovzxwd	%xmm1, %xmm2
 2230      D1
 2231 1eb4 C5F973D8 		vpsrldq	$8, %xmm0, %xmm0
 2231      08
 2232 1eb9 C5F173D9 		vpsrldq	$8, %xmm1, %xmm1
 2232      08
 2233 1ebe C4E27930 		vpmovzxbw	%xmm0, %xmm0
 2233      C0
 2234 1ec3 C4E27933 		vpmovzxwd	%xmm1, %xmm1
 2234      C9
 174:sepia_filter.c ****             /* G */
 2235              		.loc 1 174 38 view .LVU573
 2236 1ec8 C5F85BE2 		vcvtdq2ps	%xmm2, %xmm4
 2237 1ecc C5F828DC 		vmovaps	%xmm4, %xmm3
 2238 1ed0 C5F85BE1 		vcvtdq2ps	%xmm1, %xmm4
 174:sepia_filter.c ****             /* G */
 2239              		.loc 1 174 48 view .LVU574
 2240 1ed4 C4E27933 		vpmovzxwd	%xmm0, %xmm1
 2240      C8
 174:sepia_filter.c ****             /* G */
 2241              		.loc 1 174 38 view .LVU575
 2242 1ed9 C5F828D4 		vmovaps	%xmm4, %xmm2
 2243 1edd C5F85BE1 		vcvtdq2ps	%xmm1, %xmm4
 2244 1ee1 C5F828CC 		vmovaps	%xmm4, %xmm1
 2245 1ee5 C4E27918 		vbroadcastss	.LC3(%rip), %xmm4
 2245      25000000 
 2245      00
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2246              		.loc 1 173 38 view .LVU576
 2247 1eee C57829A5 		vmovaps	%xmm12, -336(%rbp)
 2247      B0FEFFFF 
 174:sepia_filter.c ****             /* G */
 2248              		.loc 1 174 38 view .LVU577
 2249 1ef6 C55859E3 		vmulps	%xmm3, %xmm4, %xmm12
 174:sepia_filter.c ****             /* G */
 2250              		.loc 1 174 48 view .LVU578
 2251 1efa C5F973D8 		vpsrldq	$8, %xmm0, %xmm0
 2251      08
 2252 1eff C4E27933 		vpmovzxwd	%xmm0, %xmm0
 2252      C0
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2253              		.loc 1 172 38 view .LVU579
 2254 1f04 C5F829BD 		vmovaps	%xmm7, -176(%rbp)
 2254      50FFFFFF 
 174:sepia_filter.c ****             /* G */
 2255              		.loc 1 174 38 view .LVU580
 2256 1f0c C5F8299D 		vmovaps	%xmm3, -400(%rbp)
 2256      70FEFFFF 
 2257 1f14 C5D859F9 		vmulps	%xmm1, %xmm4, %xmm7
 2258 1f18 C5D859DA 		vmulps	%xmm2, %xmm4, %xmm3
 2259 1f1c C5F82995 		vmovaps	%xmm2, -432(%rbp)
 2259      50FEFFFF 
 2260 1f24 C5F8298D 		vmovaps	%xmm1, -464(%rbp)
 2260      30FEFFFF 
 2261 1f2c C5F85BC0 		vcvtdq2ps	%xmm0, %xmm0
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2262              		.loc 1 172 38 view .LVU581
 2263 1f30 C4C1785A 		vcvtps2pd	%xmm15, %xmm2
 2263      D7
 174:sepia_filter.c ****             /* G */
 2264              		.loc 1 174 38 view .LVU582
 2265 1f35 C5F82945 		vmovaps	%xmm0, -80(%rbp)
 2265      B0
 2266 1f3a C4C1785A 		vcvtps2pd	%xmm12, %xmm1
 2266      CC
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2267              		.loc 1 173 38 view .LVU583
 2268 1f3f C4C1785A 		vcvtps2pd	%xmm14, %xmm0
 2268      C6
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2269              		.loc 1 173 58 view .LVU584
 2270 1f44 C5E958D0 		vaddpd	%xmm0, %xmm2, %xmm2
 2271 1f48 C5FB1205 		vmovddup	.LC102(%rip), %xmm0
 2271      00000000 
 2272 1f50 C5F158C8 		vaddpd	%xmm0, %xmm1, %xmm1
 174:sepia_filter.c ****             /* G */
 2273              		.loc 1 174 38 view .LVU585
 2274 1f54 C5D85965 		vmulps	-80(%rbp), %xmm4, %xmm4
 2274      B0
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2275              		.loc 1 172 38 view .LVU586
 2276 1f59 C57817BD 		vmovhps	%xmm15, -560(%rbp)
 2276      D0FDFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2277              		.loc 1 173 58 view .LVU587
 2278 1f61 C5E958C9 		vaddpd	%xmm1, %xmm2, %xmm1
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2279              		.loc 1 172 38 view .LVU588
 2280 1f65 C5F85A95 		vcvtps2pd	-560(%rbp), %xmm2
 2280      D0FDFFFF 
 174:sepia_filter.c ****             /* G */
 2281              		.loc 1 174 38 view .LVU589
 2282 1f6d C57817A5 		vmovhps	%xmm12, -592(%rbp)
 2282      B0FDFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2283              		.loc 1 173 38 view .LVU590
 2284 1f75 C57817B5 		vmovhps	%xmm14, -576(%rbp)
 2284      C0FDFFFF 
 2285 1f7d C5785AB5 		vcvtps2pd	-576(%rbp), %xmm14
 2285      C0FDFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2286              		.loc 1 173 58 view .LVU591
 2287 1f85 C4416958 		vaddpd	%xmm14, %xmm2, %xmm14
 2287      F6
 174:sepia_filter.c ****             /* G */
 2288              		.loc 1 174 38 view .LVU592
 2289 1f8a C5F85A95 		vcvtps2pd	-592(%rbp), %xmm2
 2289      B0FDFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2290              		.loc 1 173 58 view .LVU593
 2291 1f92 C5E958D0 		vaddpd	%xmm0, %xmm2, %xmm2
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2292              		.loc 1 173 38 view .LVU594
 2293 1f96 C441785A 		vcvtps2pd	%xmm10, %xmm12
 2293      E2
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2294              		.loc 1 172 38 view .LVU595
 2295 1f9b C578179D 		vmovhps	%xmm11, -608(%rbp)
 2295      A0FDFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2296              		.loc 1 173 58 view .LVU596
 2297 1fa3 C50958F2 		vaddpd	%xmm2, %xmm14, %xmm14
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2298              		.loc 1 173 38 view .LVU597
 2299 1fa7 C5781795 		vmovhps	%xmm10, -624(%rbp)
 2299      90FDFFFF 
 174:sepia_filter.c ****             /* G */
 2300              		.loc 1 174 38 view .LVU598
 2301 1faf C5F8179D 		vmovhps	%xmm3, -640(%rbp)
 2301      80FDFFFF 
 170:sepia_filter.c ****                           0.5 + 
 2302              		.loc 1 170 52 view .LVU599
 2303 1fb7 C4C37518 		vinsertf128	$0x1, %xmm14, %ymm1, %ymm1
 2303      CE01
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2304              		.loc 1 173 38 view .LVU600
 2305 1fbd C5785A95 		vcvtps2pd	-624(%rbp), %xmm10
 2305      90FDFFFF 
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2306              		.loc 1 172 38 view .LVU601
 2307 1fc5 C441785A 		vcvtps2pd	%xmm11, %xmm14
 2307      F3
 2308 1fca C5785A9D 		vcvtps2pd	-608(%rbp), %xmm11
 2308      A0FDFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2309              		.loc 1 173 58 view .LVU602
 2310 1fd2 C4410958 		vaddpd	%xmm12, %xmm14, %xmm14
 2310      F4
 2311 1fd7 C4412158 		vaddpd	%xmm10, %xmm11, %xmm10
 2311      D2
 174:sepia_filter.c ****             /* G */
 2312              		.loc 1 174 38 view .LVU603
 2313 1fdc C5785AE3 		vcvtps2pd	%xmm3, %xmm12
 2314 1fe0 C5F85A9D 		vcvtps2pd	-640(%rbp), %xmm3
 2314      80FDFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2315              		.loc 1 173 58 view .LVU604
 2316 1fe8 C51958E0 		vaddpd	%xmm0, %xmm12, %xmm12
 2317 1fec C5E158D8 		vaddpd	%xmm0, %xmm3, %xmm3
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2318              		.loc 1 172 38 view .LVU605
 2319 1ff0 C441785A 		vcvtps2pd	%xmm9, %xmm11
 2319      D9
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2320              		.loc 1 173 58 view .LVU606
 2321 1ff5 C4410958 		vaddpd	%xmm12, %xmm14, %xmm12
 2321      E4
 2322 1ffa C52958D3 		vaddpd	%xmm3, %xmm10, %xmm10
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2323              		.loc 1 172 38 view .LVU607
 2324 1ffe C578178D 		vmovhps	%xmm9, -656(%rbp)
 2324      70FDFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2325              		.loc 1 173 38 view .LVU608
 2326 2006 C5781785 		vmovhps	%xmm8, -672(%rbp)
 2326      60FDFFFF 
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2327              		.loc 1 172 38 view .LVU609
 2328 200e C5785A8D 		vcvtps2pd	-656(%rbp), %xmm9
 2328      70FDFFFF 
 170:sepia_filter.c ****                           0.5 + 
 2329              		.loc 1 170 52 view .LVU610
 2330 2016 C4431D18 		vinsertf128	$0x1, %xmm10, %ymm12, %ymm12
 2330      E201
 174:sepia_filter.c ****             /* G */
 2331              		.loc 1 174 38 view .LVU611
 2332 201c C5F817BD 		vmovhps	%xmm7, -688(%rbp)
 2332      50FDFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2333              		.loc 1 173 38 view .LVU612
 2334 2024 C441785A 		vcvtps2pd	%xmm8, %xmm10
 2334      D0
 2335 2029 C5785A85 		vcvtps2pd	-672(%rbp), %xmm8
 2335      60FDFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2336              		.loc 1 173 58 view .LVU613
 2337 2031 C4412158 		vaddpd	%xmm10, %xmm11, %xmm11
 2337      DA
 2338 2036 C4413158 		vaddpd	%xmm8, %xmm9, %xmm8
 2338      C0
 174:sepia_filter.c ****             /* G */
 2339              		.loc 1 174 38 view .LVU614
 2340 203b C5785AD7 		vcvtps2pd	%xmm7, %xmm10
 2341 203f C5F85ABD 		vcvtps2pd	-688(%rbp), %xmm7
 2341      50FDFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2342              		.loc 1 173 58 view .LVU615
 2343 2047 C52958D0 		vaddpd	%xmm0, %xmm10, %xmm10
 2344 204b C5C158F8 		vaddpd	%xmm0, %xmm7, %xmm7
 170:sepia_filter.c ****                           0.5 + 
 2345              		.loc 1 170 52 view .LVU616
 2346 204f C4E27918 		vbroadcastss	.LC4(%rip), %xmm2
 2346      15000000 
 2346      00
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2347              		.loc 1 173 58 view .LVU617
 2348 2058 C4412158 		vaddpd	%xmm10, %xmm11, %xmm10
 2348      D2
 2349 205d C53958C7 		vaddpd	%xmm7, %xmm8, %xmm8
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2350              		.loc 1 172 38 view .LVU618
 2351 2061 C5F817B5 		vmovhps	%xmm6, -704(%rbp)
 2351      40FDFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2352              		.loc 1 173 38 view .LVU619
 2353 2069 C5F85AFD 		vcvtps2pd	%xmm5, %xmm7
 170:sepia_filter.c ****                           0.5 + 
 2354              		.loc 1 170 52 view .LVU620
 2355 206d C4432D18 		vinsertf128	$0x1, %xmm8, %ymm10, %ymm10
 2355      D001
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2356              		.loc 1 173 38 view .LVU621
 2357 2073 C5F817AD 		vmovhps	%xmm5, -720(%rbp)
 2357      30FDFFFF 
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2358              		.loc 1 172 38 view .LVU622
 2359 207b C5785AC6 		vcvtps2pd	%xmm6, %xmm8
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2360              		.loc 1 173 38 view .LVU623
 2361 207f C5F85AAD 		vcvtps2pd	-720(%rbp), %xmm5
 2361      30FDFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2362              		.loc 1 173 58 view .LVU624
 2363 2087 C53958C7 		vaddpd	%xmm7, %xmm8, %xmm8
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2364              		.loc 1 172 38 view .LVU625
 2365 208b C5F85AB5 		vcvtps2pd	-704(%rbp), %xmm6
 2365      40FDFFFF 
 174:sepia_filter.c ****             /* G */
 2366              		.loc 1 174 38 view .LVU626
 2367 2093 C5F85AFC 		vcvtps2pd	%xmm4, %xmm7
 2368 2097 C5F817A5 		vmovhps	%xmm4, -736(%rbp)
 2368      20FDFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2369              		.loc 1 173 58 view .LVU627
 2370 209f C5C158F8 		vaddpd	%xmm0, %xmm7, %xmm7
 2371 20a3 C5C958ED 		vaddpd	%xmm5, %xmm6, %xmm5
 174:sepia_filter.c ****             /* G */
 2372              		.loc 1 174 38 view .LVU628
 2373 20a7 C5F85AA5 		vcvtps2pd	-736(%rbp), %xmm4
 2373      20FDFFFF 
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2374              		.loc 1 173 58 view .LVU629
 2375 20af C5D958E0 		vaddpd	%xmm0, %xmm4, %xmm4
 2376 20b3 C5B958FF 		vaddpd	%xmm7, %xmm8, %xmm7
 170:sepia_filter.c ****                           0.5 + 
 2377              		.loc 1 170 35 view .LVU630
 2378 20b7 BAFFFF00 		movl	$65535, %edx
 2378      00
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2379              		.loc 1 173 58 view .LVU631
 2380 20bc C5D158EC 		vaddpd	%xmm4, %xmm5, %xmm5
 170:sepia_filter.c ****                           0.5 + 
 2381              		.loc 1 170 52 view .LVU632
 2382 20c0 C5FD5AC9 		vcvtpd2psy	%ymm1, %xmm1
 2383 20c4 C4417D5A 		vcvtpd2psy	%ymm12, %xmm12
 2383      E4
 2384 20c9 C4E34518 		vinsertf128	$0x1, %xmm5, %ymm7, %ymm7
 2384      FD01
 2385 20cf C5F05DCA 		vminps	%xmm2, %xmm1, %xmm1
 2386 20d3 C5185DE2 		vminps	%xmm2, %xmm12, %xmm12
 2387 20d7 C4417D5A 		vcvtpd2psy	%ymm10, %xmm10
 2387      D2
 2388 20dc C5FD5AFF 		vcvtpd2psy	%ymm7, %xmm7
 2389 20e0 C5285DD2 		vminps	%xmm2, %xmm10, %xmm10
 2390 20e4 C5C05DFA 		vminps	%xmm2, %xmm7, %xmm7
 170:sepia_filter.c ****                           0.5 + 
 2391              		.loc 1 170 35 view .LVU633
 2392 20e8 C5F96EDA 		vmovd	%edx, %xmm3
 2393 20ec C5F970DB 		vpshufd	$0, %xmm3, %xmm3
 2393      00
 2394 20f1 41BAFF00 		movl	$255, %r10d
 2394      0000
 2395 20f7 C4C1796E 		vmovd	%r10d, %xmm5
 2395      EA
 2396 20fc C5FA5BC9 		vcvttps2dq	%xmm1, %xmm1
 2397 2100 C4417A5B 		vcvttps2dq	%xmm12, %xmm12
 2397      E4
 2398 2105 C5E1DBC9 		vpand	%xmm1, %xmm3, %xmm1
 2399 2109 C44161DB 		vpand	%xmm12, %xmm3, %xmm12
 2399      E4
 2400 210e C4417A5B 		vcvttps2dq	%xmm10, %xmm10
 2400      D2
 2401 2113 C5FA5BFF 		vcvttps2dq	%xmm7, %xmm7
 2402 2117 C44161DB 		vpand	%xmm10, %xmm3, %xmm10
 2402      D2
 2403 211c C5E1DBFF 		vpand	%xmm7, %xmm3, %xmm7
 2404 2120 C4E27979 		vpbroadcastw	%xmm5, %xmm5
 2404      ED
 2405 2125 C4C2712B 		vpackusdw	%xmm12, %xmm1, %xmm1
 2405      CC
 2406 212a C462292B 		vpackusdw	%xmm7, %xmm10, %xmm10
 2406      D7
 2407 212f C5F1DBCD 		vpand	%xmm5, %xmm1, %xmm1
 2408 2133 C529DBD5 		vpand	%xmm5, %xmm10, %xmm10
 2409 2137 C4417167 		vpackuswb	%xmm10, %xmm1, %xmm15
 2409      FA
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2410              		.loc 1 178 38 view .LVU634
 2411 213c C4E27918 		vbroadcastss	.LC8(%rip), %xmm1
 2411      0D000000 
 2411      00
 170:sepia_filter.c ****                           0.5 + 
 2412              		.loc 1 170 35 view .LVU635
 2413 2145 C5797FBD 		vmovdqa	%xmm15, -496(%rbp)
 2413      10FEFFFF 
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2414              		.loc 1 178 38 view .LVU636
 2415 214d C5705985 		vmulps	-208(%rbp), %xmm1, %xmm8
 2415      30FFFFFF 
 2416 2155 C57059BD 		vmulps	-144(%rbp), %xmm1, %xmm15
 2416      70FFFFFF 
 2417 215d C570599D 		vmulps	-176(%rbp), %xmm1, %xmm11
 2417      50FFFFFF 
 2418 2165 C570598D 		vmulps	-240(%rbp), %xmm1, %xmm9
 2418      10FFFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2419              		.loc 1 179 38 view .LVU637
 2420 216d C4E27918 		vbroadcastss	.LC7(%rip), %xmm1
 2420      0D000000 
 2420      00
 170:sepia_filter.c ****                           0.5 + 
 2421              		.loc 1 170 35 view .LVU638
 2422 2176 C5F97F6D 		vmovdqa	%xmm5, -112(%rbp)
 2422      90
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2423              		.loc 1 179 38 view .LVU639
 2424 217b C5F059A5 		vmulps	-368(%rbp), %xmm1, %xmm4
 2424      90FEFFFF 
 2425 2183 C57059B5 		vmulps	-272(%rbp), %xmm1, %xmm14
 2425      F0FEFFFF 
 2426 218b C5705995 		vmulps	-304(%rbp), %xmm1, %xmm10
 2426      D0FEFFFF 
 2427 2193 C5F059BD 		vmulps	-336(%rbp), %xmm1, %xmm7
 2427      B0FEFFFF 
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2428              		.loc 1 178 38 view .LVU640
 2429 219b C4C1785A 		vcvtps2pd	%xmm15, %xmm5
 2429      EF
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2430              		.loc 1 179 38 view .LVU641
 2431 21a0 C5F829A5 		vmovaps	%xmm4, -544(%rbp)
 2431      E0FDFFFF 
 180:sepia_filter.c ****             /* B */
 2432              		.loc 1 180 38 view .LVU642
 2433 21a8 C4E27918 		vbroadcastss	.LC9(%rip), %xmm4
 2433      25000000 
 2433      00
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2434              		.loc 1 179 38 view .LVU643
 2435 21b1 C4C1785A 		vcvtps2pd	%xmm14, %xmm1
 2435      CE
 180:sepia_filter.c ****             /* B */
 2436              		.loc 1 180 38 view .LVU644
 2437 21b6 C55859A5 		vmulps	-400(%rbp), %xmm4, %xmm12
 2437      70FEFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2438              		.loc 1 179 58 view .LVU645
 2439 21be C5D158E9 		vaddpd	%xmm1, %xmm5, %xmm5
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2440              		.loc 1 178 38 view .LVU646
 2441 21c2 C578298D 		vmovaps	%xmm9, -528(%rbp)
 2441      F0FDFFFF 
 180:sepia_filter.c ****             /* B */
 2442              		.loc 1 180 38 view .LVU647
 2443 21ca C558598D 		vmulps	-432(%rbp), %xmm4, %xmm9
 2443      50FEFFFF 
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2444              		.loc 1 178 38 view .LVU648
 2445 21d2 C57817BD 		vmovhps	%xmm15, -752(%rbp)
 2445      10FDFFFF 
 180:sepia_filter.c ****             /* B */
 2446              		.loc 1 180 38 view .LVU649
 2447 21da C4C1785A 		vcvtps2pd	%xmm12, %xmm1
 2447      CC
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2448              		.loc 1 179 58 view .LVU650
 2449 21df C5F158C8 		vaddpd	%xmm0, %xmm1, %xmm1
 180:sepia_filter.c ****             /* B */
 2450              		.loc 1 180 38 view .LVU651
 2451 21e3 C57817A5 		vmovhps	%xmm12, -784(%rbp)
 2451      F0FCFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2452              		.loc 1 179 38 view .LVU652
 2453 21eb C57817B5 		vmovhps	%xmm14, -768(%rbp)
 2453      00FDFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2454              		.loc 1 179 58 view .LVU653
 2455 21f3 C5D158C9 		vaddpd	%xmm1, %xmm5, %xmm1
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2456              		.loc 1 179 38 view .LVU654
 2457 21f7 C5785AB5 		vcvtps2pd	-768(%rbp), %xmm14
 2457      00FDFFFF 
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2458              		.loc 1 178 38 view .LVU655
 2459 21ff C5F85AAD 		vcvtps2pd	-752(%rbp), %xmm5
 2459      10FDFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2460              		.loc 1 179 58 view .LVU656
 2461 2207 C4415158 		vaddpd	%xmm14, %xmm5, %xmm14
 2461      F6
 180:sepia_filter.c ****             /* B */
 2462              		.loc 1 180 38 view .LVU657
 2463 220c C5F85AAD 		vcvtps2pd	-784(%rbp), %xmm5
 2463      F0FCFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2464              		.loc 1 179 58 view .LVU658
 2465 2214 C5D158E8 		vaddpd	%xmm0, %xmm5, %xmm5
 180:sepia_filter.c ****             /* B */
 2466              		.loc 1 180 38 view .LVU659
 2467 2218 C5D859B5 		vmulps	-464(%rbp), %xmm4, %xmm6
 2467      30FEFFFF 
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2468              		.loc 1 178 38 view .LVU660
 2469 2220 C441785A 		vcvtps2pd	%xmm11, %xmm12
 2469      E3
 180:sepia_filter.c ****             /* B */
 2470              		.loc 1 180 38 view .LVU661
 2471 2225 C5D85965 		vmulps	-80(%rbp), %xmm4, %xmm4
 2471      B0
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2472              		.loc 1 179 58 view .LVU662
 2473 222a C50958F5 		vaddpd	%xmm5, %xmm14, %xmm14
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2474              		.loc 1 178 38 view .LVU663
 2475 222e C578179D 		vmovhps	%xmm11, -800(%rbp)
 2475      E0FCFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2476              		.loc 1 179 38 view .LVU664
 2477 2236 C4C1785A 		vcvtps2pd	%xmm10, %xmm5
 2477      EA
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2478              		.loc 1 178 38 view .LVU665
 2479 223b C5785A9D 		vcvtps2pd	-800(%rbp), %xmm11
 2479      E0FCFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2480              		.loc 1 179 58 view .LVU666
 2481 2243 C51958E5 		vaddpd	%xmm5, %xmm12, %xmm12
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2482              		.loc 1 179 38 view .LVU667
 2483 2247 C5781795 		vmovhps	%xmm10, -816(%rbp)
 2483      D0FCFFFF 
 180:sepia_filter.c ****             /* B */
 2484              		.loc 1 180 38 view .LVU668
 2485 224f C4C1785A 		vcvtps2pd	%xmm9, %xmm5
 2485      E9
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2486              		.loc 1 179 38 view .LVU669
 2487 2254 C5785A95 		vcvtps2pd	-816(%rbp), %xmm10
 2487      D0FCFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2488              		.loc 1 179 58 view .LVU670
 2489 225c C5D158E8 		vaddpd	%xmm0, %xmm5, %xmm5
 2490 2260 C4412158 		vaddpd	%xmm10, %xmm11, %xmm10
 2490      D2
 180:sepia_filter.c ****             /* B */
 2491              		.loc 1 180 38 view .LVU671
 2492 2265 C578178D 		vmovhps	%xmm9, -832(%rbp)
 2492      C0FCFFFF 
 2493 226d C5785A8D 		vcvtps2pd	-832(%rbp), %xmm9
 2493      C0FCFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2494              		.loc 1 179 58 view .LVU672
 2495 2275 C53158C8 		vaddpd	%xmm0, %xmm9, %xmm9
 2496 2279 C59958ED 		vaddpd	%xmm5, %xmm12, %xmm5
 176:sepia_filter.c ****                           0.5 +
 2497              		.loc 1 176 52 view .LVU673
 2498 227d C4C37518 		vinsertf128	$0x1, %xmm14, %ymm1, %ymm1
 2498      CE01
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2499              		.loc 1 179 58 view .LVU674
 2500 2283 C4412958 		vaddpd	%xmm9, %xmm10, %xmm10
 2500      D1
 176:sepia_filter.c ****                           0.5 +
 2501              		.loc 1 176 52 view .LVU675
 2502 2288 C5FD5AC9 		vcvtpd2psy	%ymm1, %xmm1
 2503 228c C5F05DCA 		vminps	%xmm2, %xmm1, %xmm1
 2504 2290 C4C35518 		vinsertf128	$0x1, %xmm10, %ymm5, %ymm5
 2504      EA01
 2505 2296 C5FD5AED 		vcvtpd2psy	%ymm5, %xmm5
 2506 229a C5D05DEA 		vminps	%xmm2, %xmm5, %xmm5
 176:sepia_filter.c ****                           0.5 +
 2507              		.loc 1 176 35 view .LVU676
 2508 229e C5FA5BC9 		vcvttps2dq	%xmm1, %xmm1
 2509 22a2 C5E1DBC9 		vpand	%xmm1, %xmm3, %xmm1
 2510 22a6 C5FA5BED 		vcvttps2dq	%xmm5, %xmm5
 2511 22aa C5E1DBED 		vpand	%xmm5, %xmm3, %xmm5
 2512 22ae C4E2712B 		vpackusdw	%xmm5, %xmm1, %xmm1
 2512      CD
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2513              		.loc 1 178 38 view .LVU677
 2514 22b3 C441785A 		vcvtps2pd	%xmm8, %xmm9
 2514      C8
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2515              		.loc 1 179 38 view .LVU678
 2516 22b8 C5F85AEF 		vcvtps2pd	%xmm7, %xmm5
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2517              		.loc 1 178 38 view .LVU679
 2518 22bc C5781785 		vmovhps	%xmm8, -848(%rbp)
 2518      B0FCFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2519              		.loc 1 179 58 view .LVU680
 2520 22c4 C53158CD 		vaddpd	%xmm5, %xmm9, %xmm9
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2521              		.loc 1 178 38 view .LVU681
 2522 22c8 C5785A85 		vcvtps2pd	-848(%rbp), %xmm8
 2522      B0FCFFFF 
 180:sepia_filter.c ****             /* B */
 2523              		.loc 1 180 38 view .LVU682
 2524 22d0 C5F85AEE 		vcvtps2pd	%xmm6, %xmm5
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2525              		.loc 1 179 38 view .LVU683
 2526 22d4 C5F817BD 		vmovhps	%xmm7, -864(%rbp)
 2526      A0FCFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2527              		.loc 1 179 58 view .LVU684
 2528 22dc C5D158E8 		vaddpd	%xmm0, %xmm5, %xmm5
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2529              		.loc 1 179 38 view .LVU685
 2530 22e0 C5F85ABD 		vcvtps2pd	-864(%rbp), %xmm7
 2530      A0FCFFFF 
 180:sepia_filter.c ****             /* B */
 2531              		.loc 1 180 38 view .LVU686
 2532 22e8 C5F817B5 		vmovhps	%xmm6, -880(%rbp)
 2532      90FCFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2533              		.loc 1 179 58 view .LVU687
 2534 22f0 C5B958FF 		vaddpd	%xmm7, %xmm8, %xmm7
 180:sepia_filter.c ****             /* B */
 2535              		.loc 1 180 38 view .LVU688
 2536 22f4 C5F85AB5 		vcvtps2pd	-880(%rbp), %xmm6
 2536      90FCFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2537              		.loc 1 179 58 view .LVU689
 2538 22fc C5C958F0 		vaddpd	%xmm0, %xmm6, %xmm6
 2539 2300 C5B158ED 		vaddpd	%xmm5, %xmm9, %xmm5
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2540              		.loc 1 178 38 view .LVU690
 2541 2304 C578289D 		vmovaps	-528(%rbp), %xmm11
 2541      F0FDFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2542              		.loc 1 179 58 view .LVU691
 2543 230c C5C158FE 		vaddpd	%xmm6, %xmm7, %xmm7
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2544              		.loc 1 179 38 view .LVU692
 2545 2310 C5782885 		vmovaps	-544(%rbp), %xmm8
 2545      E0FDFFFF 
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2546              		.loc 1 178 38 view .LVU693
 2547 2318 C578179D 		vmovhps	%xmm11, -896(%rbp)
 2547      80FCFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2548              		.loc 1 179 38 view .LVU694
 2549 2320 C4C1785A 		vcvtps2pd	%xmm8, %xmm6
 2549      F0
 176:sepia_filter.c ****                           0.5 +
 2550              		.loc 1 176 52 view .LVU695
 2551 2325 C4E35518 		vinsertf128	$0x1, %xmm7, %ymm5, %ymm5
 2551      EF01
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2552              		.loc 1 178 38 view .LVU696
 2553 232b C4C1785A 		vcvtps2pd	%xmm11, %xmm7
 2553      FB
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2554              		.loc 1 179 58 view .LVU697
 2555 2330 C5C158FE 		vaddpd	%xmm6, %xmm7, %xmm7
 180:sepia_filter.c ****             /* B */
 2556              		.loc 1 180 38 view .LVU698
 2557 2334 C5F85AF4 		vcvtps2pd	%xmm4, %xmm6
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2558              		.loc 1 179 58 view .LVU699
 2559 2338 C5C958F0 		vaddpd	%xmm0, %xmm6, %xmm6
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2560              		.loc 1 179 38 view .LVU700
 2561 233c C5781785 		vmovhps	%xmm8, -912(%rbp)
 2561      70FCFFFF 
 180:sepia_filter.c ****             /* B */
 2562              		.loc 1 180 38 view .LVU701
 2563 2344 C5F817A5 		vmovhps	%xmm4, -928(%rbp)
 2563      60FCFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2564              		.loc 1 179 58 view .LVU702
 2565 234c C5C158F6 		vaddpd	%xmm6, %xmm7, %xmm6
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2566              		.loc 1 179 38 view .LVU703
 2567 2350 C5785A85 		vcvtps2pd	-912(%rbp), %xmm8
 2567      70FCFFFF 
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2568              		.loc 1 178 38 view .LVU704
 2569 2358 C5F85ABD 		vcvtps2pd	-896(%rbp), %xmm7
 2569      80FCFFFF 
 180:sepia_filter.c ****             /* B */
 2570              		.loc 1 180 38 view .LVU705
 2571 2360 C5F85AA5 		vcvtps2pd	-928(%rbp), %xmm4
 2571      60FCFFFF 
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2572              		.loc 1 179 58 view .LVU706
 2573 2368 C4414158 		vaddpd	%xmm8, %xmm7, %xmm8
 2573      C0
 2574 236d C5D958E0 		vaddpd	%xmm0, %xmm4, %xmm4
 176:sepia_filter.c ****                           0.5 +
 2575              		.loc 1 176 52 view .LVU707
 2576 2371 C5FD5AED 		vcvtpd2psy	%ymm5, %xmm5
 2577 2375 C5D05DEA 		vminps	%xmm2, %xmm5, %xmm5
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2578              		.loc 1 179 58 view .LVU708
 2579 2379 C53958C4 		vaddpd	%xmm4, %xmm8, %xmm8
 2580 237d 4C01F0   		addq	%r14, %rax
 170:sepia_filter.c ****                           0.5 + 
 2581              		.loc 1 170 13 is_stmt 1 view .LVU709
 176:sepia_filter.c ****                           0.5 +
 2582              		.loc 1 176 13 view .LVU710
 176:sepia_filter.c ****                           0.5 +
 2583              		.loc 1 176 35 is_stmt 0 view .LVU711
 2584 2380 C5FA5BED 		vcvttps2dq	%xmm5, %xmm5
 176:sepia_filter.c ****                           0.5 +
 2585              		.loc 1 176 52 view .LVU712
 2586 2384 C4C34D18 		vinsertf128	$0x1, %xmm8, %ymm6, %ymm6
 2586      F001
 2587 238a C5FD5AF6 		vcvtpd2psy	%ymm6, %xmm6
 2588 238e C5C85DF2 		vminps	%xmm2, %xmm6, %xmm6
 176:sepia_filter.c ****                           0.5 +
 2589              		.loc 1 176 35 view .LVU713
 2590 2392 C5E1DBED 		vpand	%xmm5, %xmm3, %xmm5
 2591 2396 C5FA5BF6 		vcvttps2dq	%xmm6, %xmm6
 2592 239a C5E1DBF6 		vpand	%xmm6, %xmm3, %xmm6
 2593 239e C4E2512B 		vpackusdw	%xmm6, %xmm5, %xmm6
 2593      F6
 2594 23a3 C5F96F6D 		vmovdqa	-112(%rbp), %xmm5
 2594      90
 2595 23a8 C5F1DBCD 		vpand	%xmm5, %xmm1, %xmm1
 2596 23ac C5C9DBF5 		vpand	%xmm5, %xmm6, %xmm6
 2597 23b0 C57167FE 		vpackuswb	%xmm6, %xmm1, %xmm15
 182:sepia_filter.c ****                           0.5 +
 2598              		.loc 1 182 13 is_stmt 1 view .LVU714
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2599              		.loc 1 184 38 is_stmt 0 view .LVU715
 2600 23b4 C4E27918 		vbroadcastss	.LC11(%rip), %xmm1
 2600      0D000000 
 2600      00
 2601 23bd C570599D 		vmulps	-144(%rbp), %xmm1, %xmm11
 2601      70FFFFFF 
 2602 23c5 C5705985 		vmulps	-208(%rbp), %xmm1, %xmm8
 2602      30FFFFFF 
 2603 23cd C57829DD 		vmovaps	%xmm11, %xmm5
 2604 23d1 C570599D 		vmulps	-176(%rbp), %xmm1, %xmm11
 2604      50FFFFFF 
 2605 23d9 C57059B5 		vmulps	-240(%rbp), %xmm1, %xmm14
 2605      10FFFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2606              		.loc 1 185 38 view .LVU716
 2607 23e1 C4E27918 		vbroadcastss	.LC10(%rip), %xmm1
 2607      0D000000 
 2607      00
 2608 23ea C5F059A5 		vmulps	-368(%rbp), %xmm1, %xmm4
 2608      90FEFFFF 
 2609 23f2 C5705995 		vmulps	-304(%rbp), %xmm1, %xmm10
 2609      D0FEFFFF 
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2610              		.loc 1 184 38 view .LVU717
 2611 23fa C57829B5 		vmovaps	%xmm14, -144(%rbp)
 2611      70FFFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2612              		.loc 1 185 38 view .LVU718
 2613 2402 C57059B5 		vmulps	-272(%rbp), %xmm1, %xmm14
 2613      F0FEFFFF 
 2614 240a C5F059BD 		vmulps	-336(%rbp), %xmm1, %xmm7
 2614      B0FEFFFF 
 2615 2412 C5F829A5 		vmovaps	%xmm4, -176(%rbp)
 2615      50FFFFFF 
 2616              		.loc 1 186 38 view .LVU719
 2617 241a C4E27918 		vbroadcastss	.LC12(%rip), %xmm4
 2617      25000000 
 2617      00
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2618              		.loc 1 184 38 view .LVU720
 2619 2423 C578179D 		vmovhps	%xmm11, -992(%rbp)
 2619      20FCFFFF 
 2620              		.loc 1 186 38 view .LVU721
 2621 242b C55859A5 		vmulps	-400(%rbp), %xmm4, %xmm12
 2621      70FEFFFF 
 2622 2433 C5D859B5 		vmulps	-464(%rbp), %xmm4, %xmm6
 2622      30FEFFFF 
 2623 243b C558598D 		vmulps	-432(%rbp), %xmm4, %xmm9
 2623      50FEFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2624              		.loc 1 185 38 view .LVU722
 2625 2443 C4C1785A 		vcvtps2pd	%xmm14, %xmm1
 2625      CE
 2626              		.loc 1 186 38 view .LVU723
 2627 2448 C5D85965 		vmulps	-80(%rbp), %xmm4, %xmm4
 2627      B0
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2628              		.loc 1 184 38 view .LVU724
 2629 244d C5F8296D 		vmovaps	%xmm5, -80(%rbp)
 2629      B0
 2630 2452 C5F85AED 		vcvtps2pd	%xmm5, %xmm5
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2631              		.loc 1 185 58 view .LVU725
 2632 2456 C5D158E9 		vaddpd	%xmm1, %xmm5, %xmm5
 2633              		.loc 1 186 38 view .LVU726
 2634 245a C4C1785A 		vcvtps2pd	%xmm12, %xmm1
 2634      CC
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2635              		.loc 1 185 58 view .LVU727
 2636 245f C5F158C8 		vaddpd	%xmm0, %xmm1, %xmm1
 2637              		.loc 1 186 38 view .LVU728
 2638 2463 C57817A5 		vmovhps	%xmm12, -976(%rbp)
 2638      30FCFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2639              		.loc 1 185 38 view .LVU729
 2640 246b C57817B5 		vmovhps	%xmm14, -960(%rbp)
 2640      40FCFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2641              		.loc 1 185 58 view .LVU730
 2642 2473 C5D158C9 		vaddpd	%xmm1, %xmm5, %xmm1
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2643              		.loc 1 184 38 view .LVU731
 2644 2477 C5F8286D 		vmovaps	-80(%rbp), %xmm5
 2644      B0
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2645              		.loc 1 185 38 view .LVU732
 2646 247c C5785AB5 		vcvtps2pd	-960(%rbp), %xmm14
 2646      40FCFFFF 
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2647              		.loc 1 184 38 view .LVU733
 2648 2484 C5F817AD 		vmovhps	%xmm5, -944(%rbp)
 2648      50FCFFFF 
 2649 248c C5F85AAD 		vcvtps2pd	-944(%rbp), %xmm5
 2649      50FCFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2650              		.loc 1 185 58 view .LVU734
 2651 2494 C4415158 		vaddpd	%xmm14, %xmm5, %xmm14
 2651      F6
 2652              		.loc 1 186 38 view .LVU735
 2653 2499 C5F85AAD 		vcvtps2pd	-976(%rbp), %xmm5
 2653      30FCFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2654              		.loc 1 185 58 view .LVU736
 2655 24a1 C5D158E8 		vaddpd	%xmm0, %xmm5, %xmm5
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2656              		.loc 1 184 38 view .LVU737
 2657 24a5 C441785A 		vcvtps2pd	%xmm11, %xmm12
 2657      E3
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2658              		.loc 1 185 38 view .LVU738
 2659 24aa C5781795 		vmovhps	%xmm10, -1008(%rbp)
 2659      10FCFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2660              		.loc 1 185 58 view .LVU739
 2661 24b2 C50958F5 		vaddpd	%xmm5, %xmm14, %xmm14
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2662              		.loc 1 184 38 view .LVU740
 2663 24b6 C5785A9D 		vcvtps2pd	-992(%rbp), %xmm11
 2663      20FCFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2664              		.loc 1 185 38 view .LVU741
 2665 24be C4C1785A 		vcvtps2pd	%xmm10, %xmm5
 2665      EA
 2666              		.loc 1 186 38 view .LVU742
 2667 24c3 C578178D 		vmovhps	%xmm9, -1024(%rbp)
 2667      00FCFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2668              		.loc 1 185 58 view .LVU743
 2669 24cb C51958E5 		vaddpd	%xmm5, %xmm12, %xmm12
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2670              		.loc 1 185 38 view .LVU744
 2671 24cf C5785A95 		vcvtps2pd	-1008(%rbp), %xmm10
 2671      10FCFFFF 
 2672              		.loc 1 186 38 view .LVU745
 2673 24d7 C4C1785A 		vcvtps2pd	%xmm9, %xmm5
 2673      E9
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2674              		.loc 1 185 58 view .LVU746
 2675 24dc C4412158 		vaddpd	%xmm10, %xmm11, %xmm10
 2675      D2
 2676              		.loc 1 186 38 view .LVU747
 2677 24e1 C5785A8D 		vcvtps2pd	-1024(%rbp), %xmm9
 2677      00FCFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2678              		.loc 1 185 58 view .LVU748
 2679 24e9 C5D158E8 		vaddpd	%xmm0, %xmm5, %xmm5
 2680 24ed C53158C8 		vaddpd	%xmm0, %xmm9, %xmm9
 182:sepia_filter.c ****                           0.5 +
 2681              		.loc 1 182 52 view .LVU749
 2682 24f1 C4C37518 		vinsertf128	$0x1, %xmm14, %ymm1, %ymm1
 2682      CE01
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2683              		.loc 1 185 58 view .LVU750
 2684 24f7 C59958ED 		vaddpd	%xmm5, %xmm12, %xmm5
 2685 24fb C4412958 		vaddpd	%xmm9, %xmm10, %xmm10
 2685      D1
 182:sepia_filter.c ****                           0.5 +
 2686              		.loc 1 182 52 view .LVU751
 2687 2500 C5FD5AC9 		vcvtpd2psy	%ymm1, %xmm1
 2688 2504 C5F05DCA 		vminps	%xmm2, %xmm1, %xmm1
 2689 2508 C4C35518 		vinsertf128	$0x1, %xmm10, %ymm5, %ymm5
 2689      EA01
 2690 250e C5FD5AED 		vcvtpd2psy	%ymm5, %xmm5
 2691 2512 C5D05DEA 		vminps	%xmm2, %xmm5, %xmm5
 182:sepia_filter.c ****                           0.5 +
 2692              		.loc 1 182 35 view .LVU752
 2693 2516 C5FA5BC9 		vcvttps2dq	%xmm1, %xmm1
 2694 251a C5E1DBC9 		vpand	%xmm1, %xmm3, %xmm1
 2695 251e C5FA5BED 		vcvttps2dq	%xmm5, %xmm5
 2696 2522 C5E1DBED 		vpand	%xmm5, %xmm3, %xmm5
 2697 2526 C4E2712B 		vpackusdw	%xmm5, %xmm1, %xmm1
 2697      CD
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2698              		.loc 1 184 38 view .LVU753
 2699 252b C441785A 		vcvtps2pd	%xmm8, %xmm9
 2699      C8
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2700              		.loc 1 185 38 view .LVU754
 2701 2530 C5F85AEF 		vcvtps2pd	%xmm7, %xmm5
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2702              		.loc 1 184 38 view .LVU755
 2703 2534 C5781785 		vmovhps	%xmm8, -1040(%rbp)
 2703      F0FBFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2704              		.loc 1 185 58 view .LVU756
 2705 253c C53158CD 		vaddpd	%xmm5, %xmm9, %xmm9
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2706              		.loc 1 184 38 view .LVU757
 2707 2540 C5785A85 		vcvtps2pd	-1040(%rbp), %xmm8
 2707      F0FBFFFF 
 2708              		.loc 1 186 38 view .LVU758
 2709 2548 C5F85AEE 		vcvtps2pd	%xmm6, %xmm5
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2710              		.loc 1 185 38 view .LVU759
 2711 254c C5F817BD 		vmovhps	%xmm7, -1056(%rbp)
 2711      E0FBFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2712              		.loc 1 185 58 view .LVU760
 2713 2554 C5D158E8 		vaddpd	%xmm0, %xmm5, %xmm5
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2714              		.loc 1 185 38 view .LVU761
 2715 2558 C5F85ABD 		vcvtps2pd	-1056(%rbp), %xmm7
 2715      E0FBFFFF 
 2716              		.loc 1 186 38 view .LVU762
 2717 2560 C5F817B5 		vmovhps	%xmm6, -1072(%rbp)
 2717      D0FBFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2718              		.loc 1 185 58 view .LVU763
 2719 2568 C5B958FF 		vaddpd	%xmm7, %xmm8, %xmm7
 2720              		.loc 1 186 38 view .LVU764
 2721 256c C5F85AB5 		vcvtps2pd	-1072(%rbp), %xmm6
 2721      D0FBFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2722              		.loc 1 185 58 view .LVU765
 2723 2574 C5C958F0 		vaddpd	%xmm0, %xmm6, %xmm6
 2724 2578 C5B158ED 		vaddpd	%xmm5, %xmm9, %xmm5
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2725              		.loc 1 184 38 view .LVU766
 2726 257c C57828B5 		vmovaps	-144(%rbp), %xmm14
 2726      70FFFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2727              		.loc 1 185 58 view .LVU767
 2728 2584 C5C158FE 		vaddpd	%xmm6, %xmm7, %xmm7
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2729              		.loc 1 185 38 view .LVU768
 2730 2588 C578288D 		vmovaps	-176(%rbp), %xmm9
 2730      50FFFFFF 
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2731              		.loc 1 184 38 view .LVU769
 2732 2590 C57817B5 		vmovhps	%xmm14, -1088(%rbp)
 2732      C0FBFFFF 
 182:sepia_filter.c ****                           0.5 +
 2733              		.loc 1 182 52 view .LVU770
 2734 2598 C4E35518 		vinsertf128	$0x1, %xmm7, %ymm5, %ymm5
 2734      EF01
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2735              		.loc 1 185 38 view .LVU771
 2736 259e C4C1785A 		vcvtps2pd	%xmm9, %xmm6
 2736      F1
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2737              		.loc 1 184 38 view .LVU772
 2738 25a3 C4C1785A 		vcvtps2pd	%xmm14, %xmm7
 2738      FE
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2739              		.loc 1 185 58 view .LVU773
 2740 25a8 C5C158FE 		vaddpd	%xmm6, %xmm7, %xmm7
 2741              		.loc 1 186 38 view .LVU774
 2742 25ac C5F85AF4 		vcvtps2pd	%xmm4, %xmm6
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2743              		.loc 1 185 58 view .LVU775
 2744 25b0 C5C958F0 		vaddpd	%xmm0, %xmm6, %xmm6
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2745              		.loc 1 185 38 view .LVU776
 2746 25b4 C578178D 		vmovhps	%xmm9, -1104(%rbp)
 2746      B0FBFFFF 
 2747              		.loc 1 186 38 view .LVU777
 2748 25bc C5F817A5 		vmovhps	%xmm4, -1120(%rbp)
 2748      A0FBFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2749              		.loc 1 185 58 view .LVU778
 2750 25c4 C5C158F6 		vaddpd	%xmm6, %xmm7, %xmm6
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2751              		.loc 1 185 38 view .LVU779
 2752 25c8 C5785A85 		vcvtps2pd	-1104(%rbp), %xmm8
 2752      B0FBFFFF 
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2753              		.loc 1 184 38 view .LVU780
 2754 25d0 C5F85ABD 		vcvtps2pd	-1088(%rbp), %xmm7
 2754      C0FBFFFF 
 2755              		.loc 1 186 38 view .LVU781
 2756 25d8 C5F85AA5 		vcvtps2pd	-1120(%rbp), %xmm4
 2756      A0FBFFFF 
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2757              		.loc 1 185 58 view .LVU782
 2758 25e0 C4414158 		vaddpd	%xmm8, %xmm7, %xmm8
 2758      C0
 2759 25e5 C5D958E0 		vaddpd	%xmm0, %xmm4, %xmm4
 182:sepia_filter.c ****                           0.5 +
 2760              		.loc 1 182 52 view .LVU783
 2761 25e9 C5FD5AED 		vcvtpd2psy	%ymm5, %xmm5
 2762 25ed C5D05DEA 		vminps	%xmm2, %xmm5, %xmm5
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2763              		.loc 1 185 58 view .LVU784
 2764 25f1 C53958C4 		vaddpd	%xmm4, %xmm8, %xmm8
 182:sepia_filter.c ****                           0.5 +
 2765              		.loc 1 182 35 view .LVU785
 2766 25f5 C5FA5BED 		vcvttps2dq	%xmm5, %xmm5
 182:sepia_filter.c ****                           0.5 +
 2767              		.loc 1 182 52 view .LVU786
 2768 25f9 C4C34D18 		vinsertf128	$0x1, %xmm8, %ymm6, %ymm6
 2768      F001
 2769 25ff C5FD5AF6 		vcvtpd2psy	%ymm6, %xmm6
 2770 2603 C5C85DF2 		vminps	%xmm2, %xmm6, %xmm6
 182:sepia_filter.c ****                           0.5 +
 2771              		.loc 1 182 35 view .LVU787
 2772 2607 C5E1DBED 		vpand	%xmm5, %xmm3, %xmm5
 2773 260b C5FA5BF6 		vcvttps2dq	%xmm6, %xmm6
 2774 260f C5E1DBDE 		vpand	%xmm6, %xmm3, %xmm3
 2775 2613 C4E2512B 		vpackusdw	%xmm3, %xmm5, %xmm3
 2775      DB
 2776 2618 C5F96F6D 		vmovdqa	-112(%rbp), %xmm5
 2776      90
 182:sepia_filter.c ****                           0.5 +
 2777              		.loc 1 182 33 view .LVU788
 2778 261d C5F96FB5 		vmovdqa	-496(%rbp), %xmm6
 2778      10FEFFFF 
 182:sepia_filter.c ****                           0.5 +
 2779              		.loc 1 182 35 view .LVU789
 2780 2625 C5E1DBC5 		vpand	%xmm5, %xmm3, %xmm0
 2781 2629 C5F1DBCD 		vpand	%xmm5, %xmm1, %xmm1
 2782 262d C5F167C8 		vpackuswb	%xmm0, %xmm1, %xmm1
 182:sepia_filter.c ****                           0.5 +
 2783              		.loc 1 182 33 view .LVU790
 2784 2631 C5F96F1D 		vmovdqa	.LC91(%rip), %xmm3
 2784      00000000 
 2785 2639 C4C14960 		vpunpcklbw	%xmm15, %xmm6, %xmm0
 2785      C7
 2786 263e C4E27100 		vpshufb	.LC90(%rip), %xmm1, %xmm2
 2786      15000000 
 2786      00
 2787 2647 C4E27900 		vpshufb	.LC89(%rip), %xmm0, %xmm0
 2787      05000000 
 2787      00
 2788 2650 C4E3794C 		vpblendvb	%xmm3, %xmm2, %xmm0, %xmm0
 2788      C230
 2789 2656 C5FA7F00 		vmovdqu	%xmm0, (%rax)
 2790 265a C4E24900 		vpshufb	.LC93(%rip), %xmm6, %xmm2
 2790      15000000 
 2790      00
 2791 2663 C5F96F1D 		vmovdqa	.LC95(%rip), %xmm3
 2791      00000000 
 2792 266b C4E20100 		vpshufb	.LC92(%rip), %xmm15, %xmm0
 2792      05000000 
 2792      00
 2793 2674 C5F9EBC2 		vpor	%xmm2, %xmm0, %xmm0
 2794 2678 C4E27100 		vpshufb	.LC94(%rip), %xmm1, %xmm2
 2794      15000000 
 2794      00
 2795 2681 C4E3794C 		vpblendvb	%xmm3, %xmm2, %xmm0, %xmm0
 2795      C230
 2796 2687 C5FA7F40 		vmovdqu	%xmm0, 16(%rax)
 2796      10
 2797 268c C4E24900 		vpshufb	.LC96(%rip), %xmm6, %xmm2
 2797      15000000 
 2797      00
 2798 2695 C4E20100 		vpshufb	.LC97(%rip), %xmm15, %xmm0
 2798      05000000 
 2798      00
 2799 269e C5E9EBC0 		vpor	%xmm0, %xmm2, %xmm0
 2800 26a2 C5F96F15 		vmovdqa	.LC99(%rip), %xmm2
 2800      00000000 
 2801 26aa C4E27100 		vpshufb	.LC98(%rip), %xmm1, %xmm1
 2801      0D000000 
 2801      00
 2802 26b3 C4E3714C 		vpblendvb	%xmm2, %xmm0, %xmm1, %xmm1
 2802      C820
 2803 26b9 C5FA7F48 		vmovdqu	%xmm1, 32(%rax)
 2803      20
 167:sepia_filter.c ****         {
 2804              		.loc 1 167 44 is_stmt 1 view .LVU791
 167:sepia_filter.c ****         {
 2805              		.loc 1 167 9 view .LVU792
 2806 26be 89F0     		movl	%esi, %eax
 2807 26c0 83E0F0   		andl	$-16, %eax
 2808 26c3 01C7     		addl	%eax, %edi
 2809 26c5 83E60F   		andl	$15, %esi
 2810 26c8 0F848201 		je	.L44
 2810      0000
 2811              	.L45:
 167:sepia_filter.c ****         {
 2812              		.loc 1 167 9 is_stmt 0 view .LVU793
 2813 26ce 8D347F   		leal	(%rdi,%rdi,2), %esi
 2814 26d1 4863F6   		movslq	%esi, %rsi
 2815 26d4 C57A101D 		vmovss	.LC2(%rip), %xmm11
 2815      00000000 
 2816 26dc C57A1015 		vmovss	.LC1(%rip), %xmm10
 2816      00000000 
 2817 26e4 C57A100D 		vmovss	.LC3(%rip), %xmm9
 2817      00000000 
 2818 26ec C5FB1015 		vmovsd	.LC102(%rip), %xmm2
 2818      00000000 
 2819 26f4 C5FA100D 		vmovss	.LC4(%rip), %xmm1
 2819      00000000 
 2820 26fc C57A1005 		vmovss	.LC8(%rip), %xmm8
 2820      00000000 
 2821 2704 C5FA103D 		vmovss	.LC7(%rip), %xmm7
 2821      00000000 
 2822 270c C5FA1035 		vmovss	.LC9(%rip), %xmm6
 2822      00000000 
 2823 2714 C5FA102D 		vmovss	.LC11(%rip), %xmm5
 2823      00000000 
 2824 271c C5FA1025 		vmovss	.LC10(%rip), %xmm4
 2824      00000000 
 2825 2724 C5FA101D 		vmovss	.LC12(%rip), %xmm3
 2825      00000000 
 2826 272c 498D4435 		leaq	0(%r13,%rsi), %rax
 2826      00
 2827 2731 4C01F6   		addq	%r14, %rsi
 2828              		.p2align 4,,10
 2829 2734 0F1F4000 		.p2align 3
 2830              	.L47:
 2831              	.LVL52:
 170:sepia_filter.c ****                           0.5 + 
 2832              		.loc 1 170 13 is_stmt 1 view .LVU794
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2833              		.loc 1 172 48 is_stmt 0 view .LVU795
 2834 2738 440FB610 		movzbl	(%rax), %r10d
 167:sepia_filter.c ****         {
 2835              		.loc 1 167 44 view .LVU796
 2836 273c FFC7     		incl	%edi
 2837              	.LVL53:
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2838              		.loc 1 172 38 view .LVU797
 2839 273e C4C1122A 		vcvtsi2ssl	%r10d, %xmm13, %xmm0
 2839      C2
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2840              		.loc 1 173 48 view .LVU798
 2841 2743 440FB650 		movzbl	1(%rax), %r10d
 2841      01
 167:sepia_filter.c ****         {
 2842              		.loc 1 167 9 view .LVU799
 2843 2748 4883C603 		addq	$3, %rsi
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2844              		.loc 1 173 38 view .LVU800
 2845 274c C441122A 		vcvtsi2ssl	%r10d, %xmm13, %xmm12
 2845      E2
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2846              		.loc 1 172 38 view .LVU801
 2847 2751 C4C17A59 		vmulss	%xmm11, %xmm0, %xmm0
 2847      C3
 174:sepia_filter.c ****             /* G */
 2848              		.loc 1 174 48 view .LVU802
 2849 2756 440FB650 		movzbl	2(%rax), %r10d
 2849      02
 167:sepia_filter.c ****         {
 2850              		.loc 1 167 9 view .LVU803
 2851 275b 4883C003 		addq	$3, %rax
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2852              		.loc 1 173 38 view .LVU804
 2853 275f C4411A59 		vmulss	%xmm10, %xmm12, %xmm12
 2853      E2
 172:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 2854              		.loc 1 172 38 view .LVU805
 2855 2764 C5FA5AC0 		vcvtss2sd	%xmm0, %xmm0, %xmm0
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2856              		.loc 1 173 38 view .LVU806
 2857 2768 C4411A5A 		vcvtss2sd	%xmm12, %xmm12, %xmm12
 2857      E4
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2858              		.loc 1 173 58 view .LVU807
 2859 276d C4C17B58 		vaddsd	%xmm12, %xmm0, %xmm0
 2859      C4
 174:sepia_filter.c ****             /* G */
 2860              		.loc 1 174 38 view .LVU808
 2861 2772 C441122A 		vcvtsi2ssl	%r10d, %xmm13, %xmm12
 2861      E2
 2862 2777 C4411A59 		vmulss	%xmm9, %xmm12, %xmm12
 2862      E1
 2863 277c C4411A5A 		vcvtss2sd	%xmm12, %xmm12, %xmm12
 2863      E4
 173:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 2864              		.loc 1 173 58 view .LVU809
 2865 2781 C51B58E2 		vaddsd	%xmm2, %xmm12, %xmm12
 2866 2785 C4C17B58 		vaddsd	%xmm12, %xmm0, %xmm0
 2866      C4
 170:sepia_filter.c ****                           0.5 + 
 2867              		.loc 1 170 52 view .LVU810
 2868 278a C5FB5AC0 		vcvtsd2ss	%xmm0, %xmm0, %xmm0
 2869 278e C5FA5DC1 		vminss	%xmm1, %xmm0, %xmm0
 170:sepia_filter.c ****                           0.5 + 
 2870              		.loc 1 170 35 view .LVU811
 2871 2792 C57A2CD0 		vcvttss2sil	%xmm0, %r10d
 2872 2796 448856FD 		movb	%r10b, -3(%rsi)
 176:sepia_filter.c ****                           0.5 +
 2873              		.loc 1 176 13 is_stmt 1 view .LVU812
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2874              		.loc 1 178 48 is_stmt 0 view .LVU813
 2875 279a 440FB650 		movzbl	-3(%rax), %r10d
 2875      FD
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2876              		.loc 1 178 38 view .LVU814
 2877 279f C4C1122A 		vcvtsi2ssl	%r10d, %xmm13, %xmm0
 2877      C2
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2878              		.loc 1 179 48 view .LVU815
 2879 27a4 440FB650 		movzbl	-2(%rax), %r10d
 2879      FE
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2880              		.loc 1 179 38 view .LVU816
 2881 27a9 C441122A 		vcvtsi2ssl	%r10d, %xmm13, %xmm12
 2881      E2
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2882              		.loc 1 178 38 view .LVU817
 2883 27ae C4C17A59 		vmulss	%xmm8, %xmm0, %xmm0
 2883      C0
 180:sepia_filter.c ****             /* B */
 2884              		.loc 1 180 48 view .LVU818
 2885 27b3 440FB650 		movzbl	-1(%rax), %r10d
 2885      FF
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2886              		.loc 1 179 38 view .LVU819
 2887 27b8 C51A59E7 		vmulss	%xmm7, %xmm12, %xmm12
 178:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 2888              		.loc 1 178 38 view .LVU820
 2889 27bc C5FA5AC0 		vcvtss2sd	%xmm0, %xmm0, %xmm0
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2890              		.loc 1 179 38 view .LVU821
 2891 27c0 C4411A5A 		vcvtss2sd	%xmm12, %xmm12, %xmm12
 2891      E4
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2892              		.loc 1 179 58 view .LVU822
 2893 27c5 C4C17B58 		vaddsd	%xmm12, %xmm0, %xmm0
 2893      C4
 180:sepia_filter.c ****             /* B */
 2894              		.loc 1 180 38 view .LVU823
 2895 27ca C441122A 		vcvtsi2ssl	%r10d, %xmm13, %xmm12
 2895      E2
 2896 27cf C51A59E6 		vmulss	%xmm6, %xmm12, %xmm12
 2897 27d3 C4411A5A 		vcvtss2sd	%xmm12, %xmm12, %xmm12
 2897      E4
 179:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 2898              		.loc 1 179 58 view .LVU824
 2899 27d8 C51B58E2 		vaddsd	%xmm2, %xmm12, %xmm12
 2900 27dc C4C17B58 		vaddsd	%xmm12, %xmm0, %xmm0
 2900      C4
 176:sepia_filter.c ****                           0.5 +
 2901              		.loc 1 176 52 view .LVU825
 2902 27e1 C5FB5AC0 		vcvtsd2ss	%xmm0, %xmm0, %xmm0
 2903 27e5 C5FA5DC1 		vminss	%xmm1, %xmm0, %xmm0
 176:sepia_filter.c ****                           0.5 +
 2904              		.loc 1 176 35 view .LVU826
 2905 27e9 C57A2CD0 		vcvttss2sil	%xmm0, %r10d
 2906 27ed 448856FE 		movb	%r10b, -2(%rsi)
 182:sepia_filter.c ****                           0.5 +
 2907              		.loc 1 182 13 is_stmt 1 view .LVU827
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2908              		.loc 1 184 48 is_stmt 0 view .LVU828
 2909 27f1 440FB650 		movzbl	-3(%rax), %r10d
 2909      FD
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2910              		.loc 1 184 38 view .LVU829
 2911 27f6 C4C1122A 		vcvtsi2ssl	%r10d, %xmm13, %xmm0
 2911      C2
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2912              		.loc 1 185 48 view .LVU830
 2913 27fb 440FB650 		movzbl	-2(%rax), %r10d
 2913      FE
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2914              		.loc 1 185 38 view .LVU831
 2915 2800 C441122A 		vcvtsi2ssl	%r10d, %xmm13, %xmm12
 2915      E2
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2916              		.loc 1 184 38 view .LVU832
 2917 2805 C5FA59C5 		vmulss	%xmm5, %xmm0, %xmm0
 2918              		.loc 1 186 48 view .LVU833
 2919 2809 440FB650 		movzbl	-1(%rax), %r10d
 2919      FF
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2920              		.loc 1 185 38 view .LVU834
 2921 280e C51A59E4 		vmulss	%xmm4, %xmm12, %xmm12
 184:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 2922              		.loc 1 184 38 view .LVU835
 2923 2812 C5FA5AC0 		vcvtss2sd	%xmm0, %xmm0, %xmm0
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2924              		.loc 1 185 38 view .LVU836
 2925 2816 C4411A5A 		vcvtss2sd	%xmm12, %xmm12, %xmm12
 2925      E4
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2926              		.loc 1 185 58 view .LVU837
 2927 281b C4C17B58 		vaddsd	%xmm12, %xmm0, %xmm0
 2927      C4
 2928              		.loc 1 186 38 view .LVU838
 2929 2820 C441122A 		vcvtsi2ssl	%r10d, %xmm13, %xmm12
 2929      E2
 2930 2825 C51A59E3 		vmulss	%xmm3, %xmm12, %xmm12
 2931 2829 C4411A5A 		vcvtss2sd	%xmm12, %xmm12, %xmm12
 2931      E4
 185:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 2932              		.loc 1 185 58 view .LVU839
 2933 282e C51B58E2 		vaddsd	%xmm2, %xmm12, %xmm12
 2934 2832 C4C17B58 		vaddsd	%xmm12, %xmm0, %xmm0
 2934      C4
 182:sepia_filter.c ****                           0.5 +
 2935              		.loc 1 182 52 view .LVU840
 2936 2837 C5FB5AC0 		vcvtsd2ss	%xmm0, %xmm0, %xmm0
 2937 283b C5FA5DC1 		vminss	%xmm1, %xmm0, %xmm0
 182:sepia_filter.c ****                           0.5 +
 2938              		.loc 1 182 35 view .LVU841
 2939 283f C57A2CD0 		vcvttss2sil	%xmm0, %r10d
 2940 2843 448856FF 		movb	%r10b, -1(%rsi)
 167:sepia_filter.c ****         {
 2941              		.loc 1 167 44 is_stmt 1 view .LVU842
 2942              	.LVL54:
 167:sepia_filter.c ****         {
 2943              		.loc 1 167 9 view .LVU843
 2944 2847 4139FF   		cmpl	%edi, %r15d
 2945 284a 0F8FE8FE 		jg	.L47
 2945      FFFF
 2946              	.LVL55:
 2947              	.L44:
 167:sepia_filter.c ****         {
 2948              		.loc 1 167 9 is_stmt 0 view .LVU844
 2949              	.LBE19:
 187:sepia_filter.c ****         }
 188:sepia_filter.c ****         dummy(image_in, image_out);
 2950              		.loc 1 188 9 is_stmt 1 view .LVU845
 2951 2850 488BB598 		movq	-1128(%rbp), %rsi
 2951      FBFFFF
 2952 2857 488BBD90 		movq	-1136(%rbp), %rdi
 2952      FBFFFF
 2953 285e C5F877   		vzeroupper
 2954              	.LVL56:
 2955 2861 E8000000 		call	dummy
 2955      00
 2956              	.LVL57:
 164:sepia_filter.c ****     {
 2957              		.loc 1 164 36 view .LVU846
 164:sepia_filter.c ****     {
 2958              		.loc 1 164 25 view .LVU847
 2959 2866 FFCB     		decl	%ebx
 2960 2868 C4411057 		vxorps	%xmm13, %xmm13, %xmm13
 2960      ED
 2961 286d 0F85B5E9 		jne	.L50
 2961      FFFF
 2962              	.L49:
 164:sepia_filter.c ****     {
 2963              		.loc 1 164 25 is_stmt 0 view .LVU848
 2964              	.LBE22:
 189:sepia_filter.c ****     }
 190:sepia_filter.c ****     end_t = get_wall_time();
 2965              		.loc 1 190 5 is_stmt 1 view .LVU849
 2966              		.loc 1 190 13 is_stmt 0 view .LVU850
 2967 2873 31C0     		xorl	%eax, %eax
 2968 2875 E8000000 		call	get_wall_time
 2968      00
 2969              	.LVL58:
 191:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_cast0");
 2970              		.loc 1 191 5 is_stmt 1 view .LVU851
 2971 287a C5FB5C85 		vsubsd	-1152(%rbp), %xmm0, %xmm0
 2971      80FBFFFF 
 2972              	.LVL59:
 192:sepia_filter.c **** }
 2973              		.loc 1 192 1 is_stmt 0 view .LVU852
 2974 2882 4881C468 		addq	$1128, %rsp
 2974      040000
 2975 2889 5B       		popq	%rbx
 2976 288a 415C     		popq	%r12
 2977 288c 415D     		popq	%r13
 2978              		.cfi_remember_state
 2979              		.cfi_def_cfa 13, 0
 2980              	.LVL60:
 2981              		.loc 1 192 1 view .LVU853
 2982 288e 415E     		popq	%r14
 2983              	.LVL61:
 191:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_cast0");
 2984              		.loc 1 191 5 view .LVU854
 2985 2890 4489FF   		movl	%r15d, %edi
 2986              		.loc 1 192 1 view .LVU855
 2987 2893 415F     		popq	%r15
 2988 2895 5D       		popq	%rbp
 2989              	.LVL62:
 2990              		.loc 1 192 1 view .LVU856
 2991 2896 498D65F0 		leaq	-16(%r13), %rsp
 2992              		.cfi_def_cfa 7, 16
 191:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_cast0");
 2993              		.loc 1 191 5 view .LVU857
 2994 289a BE000000 		movl	$.LC104, %esi
 2994      00
 2995              		.loc 1 192 1 view .LVU858
 2996 289f 415D     		popq	%r13
 2997              		.cfi_def_cfa_offset 8
 191:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_cast0");
 2998              		.loc 1 191 5 view .LVU859
 2999 28a1 E9000000 		jmp	results
 2999      00
 3000              	.LVL63:
 3001              	.L62:
 3002              		.cfi_restore_state
 3003              	.LBB23:
 188:sepia_filter.c ****     }
 3004              		.loc 1 188 9 is_stmt 1 view .LVU860
 3005 28a6 488BB598 		movq	-1128(%rbp), %rsi
 3005      FBFFFF
 3006 28ad 488BBD90 		movq	-1136(%rbp), %rdi
 3006      FBFFFF
 3007 28b4 E8000000 		call	dummy
 3007      00
 3008              	.LVL64:
 164:sepia_filter.c ****     {
 3009              		.loc 1 164 36 view .LVU861
 164:sepia_filter.c ****     {
 3010              		.loc 1 164 25 view .LVU862
 3011 28b9 FFCB     		decl	%ebx
 3012 28bb 0F8553E9 		jne	.L41
 3012      FFFF
 3013 28c1 EBB0     		jmp	.L49
 3014              	.LVL65:
 3015              	.L52:
 3016              	.LBB20:
 167:sepia_filter.c ****         {
 3017              		.loc 1 167 18 is_stmt 0 view .LVU863
 3018 28c3 31C0     		xorl	%eax, %eax
 3019 28c5 31FF     		xorl	%edi, %edi
 3020 28c7 E95BF4FF 		jmp	.L42
 3020      FF
 3021              	.LVL66:
 3022              	.L65:
 167:sepia_filter.c ****         {
 3023              		.loc 1 167 18 view .LVU864
 3024              	.LBE20:
 3025              	.LBE23:
 152:sepia_filter.c ****         exit(-1);
 3026              		.loc 1 152 9 is_stmt 1 view .LVU865
 3027 28cc BF000000 		movl	$.LC0, %edi
 3027      00
 3028              	.LVL67:
 152:sepia_filter.c ****         exit(-1);
 3029              		.loc 1 152 9 is_stmt 0 view .LVU866
 3030 28d1 E8000000 		call	puts
 3030      00
 3031              	.LVL68:
 153:sepia_filter.c ****     }
 3032              		.loc 1 153 9 is_stmt 1 view .LVU867
 3033 28d6 83CFFF   		orl	$-1, %edi
 3034 28d9 E8000000 		call	exit
 3034      00
 3035              	.LVL69:
 3036              		.cfi_endproc
 3037              	.LFE20:
 3039              		.section	.rodata.str1.1
 3040              	.LC108:
 3041 002b 73657069 		.string	"sepiaf_cast1"
 3041      61665F63 
 3041      61737431 
 3041      00
 3042              		.text
 3043 28de 6690     		.p2align 4
 3044              		.globl	sepia_filter_cast1
 3046              	sepia_filter_cast1:
 3047              	.LVL70:
 3048              	.LFB21:
 193:sepia_filter.c **** //----------------------------------------------------------------------------
 194:sepia_filter.c **** 
 195:sepia_filter.c **** /* cambios respecto sepia_filter_cast0(): cast de la constante 0.5 a float */
 196:sepia_filter.c **** void
 197:sepia_filter.c **** sepia_filter_cast1(image_t * restrict image_in, image_t * restrict image_out)
 198:sepia_filter.c **** {
 3049              		.loc 1 198 1 view -0
 3050              		.cfi_startproc
 199:sepia_filter.c ****     double start_t, end_t;
 3051              		.loc 1 199 5 view .LVU869
 200:sepia_filter.c ****     const int height = image_in->height;
 3052              		.loc 1 200 5 view .LVU870
 198:sepia_filter.c ****     double start_t, end_t;
 3053              		.loc 1 198 1 is_stmt 0 view .LVU871
 3054 28e0 4155     		pushq	%r13
 3055              		.cfi_def_cfa_offset 16
 3056              		.cfi_offset 13, -16
 3057 28e2 4C8D6C24 		leaq	16(%rsp), %r13
 3057      10
 3058              		.cfi_def_cfa 13, 0
 3059 28e7 4883E4E0 		andq	$-32, %rsp
 3060 28eb 41FF75F8 		pushq	-8(%r13)
 3061 28ef 55       		pushq	%rbp
 3062 28f0 4889E5   		movq	%rsp, %rbp
 3063              		.cfi_escape 0x10,0x6,0x2,0x76,0
 3064 28f3 4157     		pushq	%r15
 3065 28f5 4156     		pushq	%r14
 3066 28f7 4155     		pushq	%r13
 3067              		.cfi_escape 0xf,0x3,0x76,0x68,0x6
 3068              		.cfi_escape 0x10,0xf,0x2,0x76,0x78
 3069              		.cfi_escape 0x10,0xe,0x2,0x76,0x70
 3070 28f9 4154     		pushq	%r12
 3071 28fb 53       		pushq	%rbx
 3072 28fc 4881EC68 		subq	$360, %rsp
 3072      010000
 3073              		.cfi_escape 0x10,0xc,0x2,0x76,0x60
 3074              		.cfi_escape 0x10,0x3,0x2,0x76,0x58
 201:sepia_filter.c ****     const int width =  image_in->width;
 3075              		.loc 1 201 15 view .LVU872
 3076 2903 C5FA7E47 		vmovq	8(%rdi), %xmm0
 3076      08
 202:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 203:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
 204:sepia_filter.c **** 
 205:sepia_filter.c ****     if (image_in->bytes_per_pixel != 3)
 3077              		.loc 1 205 8 view .LVU873
 3078 2908 837F1003 		cmpl	$3, 16(%rdi)
 198:sepia_filter.c ****     double start_t, end_t;
 3079              		.loc 1 198 1 view .LVU874
 3080 290c 4889BD90 		movq	%rdi, -368(%rbp)
 3080      FEFFFF
 3081 2913 4889B598 		movq	%rsi, -360(%rbp)
 3081      FEFFFF
 202:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 3082              		.loc 1 202 30 view .LVU875
 3083 291a 4C8B2F   		movq	(%rdi), %r13
 203:sepia_filter.c **** 
 3084              		.loc 1 203 30 view .LVU876
 3085 291d 4C8B36   		movq	(%rsi), %r14
 3086 2920 C4C37916 		vpextrd	$1, %xmm0, %r15d
 3086      C701
 3087              	.LVL71:
 201:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 3088              		.loc 1 201 5 is_stmt 1 view .LVU877
 202:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
 3089              		.loc 1 202 5 view .LVU878
 203:sepia_filter.c **** 
 3090              		.loc 1 203 5 view .LVU879
 3091              		.loc 1 205 5 view .LVU880
 3092              		.loc 1 205 8 is_stmt 0 view .LVU881
 3093 2926 0F85C00D 		jne	.L92
 3093      0000
 3094 292c C4C1797E 		vmovd	%xmm0, %r12d
 3094      C4
 206:sepia_filter.c ****     {
 207:sepia_filter.c ****         printf("ERROR: input image has to be RGB\n");
 208:sepia_filter.c ****         exit(-1);
 209:sepia_filter.c ****     }
 210:sepia_filter.c ****     
 211:sepia_filter.c ****     /* fill struct fields */
 212:sepia_filter.c ****     image_out->width  = width;
 3095              		.loc 1 212 5 is_stmt 1 view .LVU882
 213:sepia_filter.c ****     image_out->height = height;
 3096              		.loc 1 213 5 view .LVU883
 214:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
 3097              		.loc 1 214 32 is_stmt 0 view .LVU884
 3098 2931 48B90300 		movabsq	$8589934595, %rcx
 3098      00000200 
 3098      0000
 3099              	.LBB24:
 3100              	.LBB25:
 215:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 216:sepia_filter.c **** 
 217:sepia_filter.c ****     start_t = get_wall_time();
 218:sepia_filter.c **** 
 219:sepia_filter.c ****     for (int it = 0; it < NITER; it++)
 220:sepia_filter.c ****     {
 221:sepia_filter.c ****         #pragma GCC ivdep
 222:sepia_filter.c ****         for (int i = 0; i < height*width; i++)
 3101              		.loc 1 222 35 view .LVU885
 3102 293b 450FAFFC 		imull	%r12d, %r15d
 3103              	.LBE25:
 3104              	.LBE24:
 214:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
 3105              		.loc 1 214 32 view .LVU886
 3106 293f 48894E10 		movq	%rcx, 16(%rsi)
 217:sepia_filter.c **** 
 3107              		.loc 1 217 15 view .LVU887
 3108 2943 31C0     		xorl	%eax, %eax
 212:sepia_filter.c ****     image_out->height = height;
 3109              		.loc 1 212 23 view .LVU888
 3110 2945 C5F9D646 		vmovq	%xmm0, 8(%rsi)
 3110      08
 214:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 3111              		.loc 1 214 5 is_stmt 1 view .LVU889
 215:sepia_filter.c **** 
 3112              		.loc 1 215 5 view .LVU890
 217:sepia_filter.c **** 
 3113              		.loc 1 217 5 view .LVU891
 217:sepia_filter.c **** 
 3114              		.loc 1 217 15 is_stmt 0 view .LVU892
 3115 294a E8000000 		call	get_wall_time
 3115      00
 3116              	.LVL72:
 217:sepia_filter.c **** 
 3117              		.loc 1 217 15 view .LVU893
 3118 294f 418D47FF 		leal	-1(%r15), %eax
 3119 2953 89858CFE 		movl	%eax, -372(%rbp)
 3119      FFFF
 3120 2959 4489F8   		movl	%r15d, %eax
 3121 295c C1E805   		shrl	$5, %eax
 3122 295f 488D0C40 		leaq	(%rax,%rax,2), %rcx
 3123 2963 4489F8   		movl	%r15d, %eax
 3124 2966 83E0E0   		andl	$-32, %eax
 3125 2969 898588FE 		movl	%eax, -376(%rbp)
 3125      FFFF
 3126 296f 48C1E105 		salq	$5, %rcx
 3127 2973 C5FB1185 		vmovsd	%xmm0, -384(%rbp)
 3127      80FEFFFF 
 3128              	.LVL73:
 219:sepia_filter.c ****     {
 3129              		.loc 1 219 5 is_stmt 1 view .LVU894
 3130              	.LBB29:
 219:sepia_filter.c ****     {
 3131              		.loc 1 219 10 view .LVU895
 219:sepia_filter.c ****     {
 3132              		.loc 1 219 25 view .LVU896
 3133 297b 4E8D2429 		leaq	(%rcx,%r13), %r12
 3134              	.LBB26:
 3135              		.loc 1 222 35 is_stmt 0 view .LVU897
 3136 297f BB0A0000 		movl	$10, %ebx
 3136      00
 3137              	.LVL74:
 3138              	.L68:
 3139              		.loc 1 222 9 is_stmt 1 view .LVU898
 3140 2984 4585FF   		testl	%r15d, %r15d
 3141 2987 0F8E190D 		jle	.L89
 3141      0000
 3142              	.LVL75:
 3143 298d 0F1F00   		.p2align 4,,10
 3144              		.p2align 3
 3145              	.L77:
 3146              		.loc 1 222 9 is_stmt 0 view .LVU899
 3147 2990 83BD8CFE 		cmpl	$30, -372(%rbp)
 3147      FFFF1E
 3148 2997 0F86260D 		jbe	.L79
 3148      0000
 223:sepia_filter.c ****         {
 224:sepia_filter.c ****             /* el cast float mejora las prestaciones!! */
 225:sepia_filter.c ****             /* R */
 226:sepia_filter.c ****             pixels_out[3*i + 0] = (unsigned char) (fminf(MAXPIXV,
 3149              		.loc 1 226 35 view .LVU900
 3150 299d BFFFFF00 		movl	$65535, %edi
 3150      00
 3151 29a2 C5796EE7 		vmovd	%edi, %xmm12
 3152 29a6 BFFF0000 		movl	$255, %edi
 3152      00
 3153 29ab C5F96EFF 		vmovd	%edi, %xmm7
 3154 29af C4E27D79 		vpbroadcastw	%xmm7, %ymm7
 3154      FF
 3155 29b4 C4627D18 		vbroadcastss	.LC106(%rip), %ymm10
 3155      15000000 
 3155      00
 3156 29bd C4627D18 		vbroadcastss	.LC4(%rip), %ymm13
 3156      2D000000 
 3156      00
 3157 29c6 4C89F6   		movq	%r14, %rsi
 3158              	.LBE26:
 3159              	.LBE29:
 198:sepia_filter.c ****     double start_t, end_t;
 3160              		.loc 1 198 1 view .LVU901
 3161 29c9 4C89E8   		movq	%r13, %rax
 3162              	.LBB30:
 3163              	.LBB27:
 3164              		.loc 1 226 35 view .LVU902
 3165 29cc C4427D58 		vpbroadcastd	%xmm12, %ymm12
 3165      E4
 3166 29d1 C5FD7F7D 		vmovdqa	%ymm7, -80(%rbp)
 3166      B0
 3167 29d6 662E0F1F 		.p2align 4,,10
 3167      84000000 
 3167      0000
 3168              		.p2align 3
 3169              	.L70:
 3170              		.loc 1 226 13 is_stmt 1 discriminator 3 view .LVU903
 227:sepia_filter.c ****                           0.5f +
 228:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 3171              		.loc 1 228 48 is_stmt 0 discriminator 3 view .LVU904
 3172 29e0 C5FE6F00 		vmovdqu	(%rax), %ymm0
 3173 29e4 C5FE6F68 		vmovdqu	32(%rax), %ymm5
 3173      20
 3174 29e9 C4E27D00 		vpshufb	.LC15(%rip), %ymm0, %ymm1
 3174      0D000000 
 3174      00
 3175 29f2 C5FE6F60 		vmovdqu	64(%rax), %ymm4
 3175      40
 3176 29f7 C4E27D00 		vpshufb	.LC16(%rip), %ymm0, %ymm3
 3176      1D000000 
 3176      00
 3177 2a00 C4E3FD00 		vpermq	$78, %ymm1, %ymm1
 3177      C94E
 3178 2a06 C4E25500 		vpshufb	.LC17(%rip), %ymm5, %ymm2
 3178      15000000 
 3178      00
 3179 2a0f C5E5EBD9 		vpor	%ymm1, %ymm3, %ymm3
 3180 2a13 C5E5EBDA 		vpor	%ymm2, %ymm3, %ymm3
 3181 2a17 C4E25D00 		vpshufb	.LC18(%rip), %ymm4, %ymm2
 3181      15000000 
 3181      00
 3182 2a20 C4E25D00 		vpshufb	.LC20(%rip), %ymm4, %ymm1
 3182      0D000000 
 3182      00
 3183 2a29 C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 3183      D24E
 3184 2a2f C5F5EBCA 		vpor	%ymm2, %ymm1, %ymm1
 3185 2a33 C4E26500 		vpshufb	.LC19(%rip), %ymm3, %ymm3
 3185      1D000000 
 3185      00
 3186 2a3c C5E5EBD9 		vpor	%ymm1, %ymm3, %ymm3
 3187 2a40 C4E27D00 		vpshufb	.LC21(%rip), %ymm0, %ymm1
 3187      0D000000 
 3187      00
 3188 2a49 C4E27D00 		vpshufb	.LC22(%rip), %ymm0, %ymm2
 3188      15000000 
 3188      00
 3189 2a52 C4E3FD00 		vpermq	$78, %ymm1, %ymm1
 3189      C94E
 3190 2a58 C4E25500 		vpshufb	.LC23(%rip), %ymm5, %ymm6
 3190      35000000 
 3190      00
 3191 2a61 C5EDEBD1 		vpor	%ymm1, %ymm2, %ymm2
 3192 2a65 C5EDEBD6 		vpor	%ymm6, %ymm2, %ymm2
 3193 2a69 C4E25D00 		vpshufb	.LC24(%rip), %ymm4, %ymm6
 3193      35000000 
 3193      00
 3194 2a72 C4E25D00 		vpshufb	.LC26(%rip), %ymm4, %ymm1
 3194      0D000000 
 3194      00
 3195 2a7b C4E3FD00 		vpermq	$78, %ymm6, %ymm6
 3195      F64E
 3196 2a81 C5F5EBCE 		vpor	%ymm6, %ymm1, %ymm1
 3197 2a85 C4E26D00 		vpshufb	.LC25(%rip), %ymm2, %ymm2
 3197      15000000 
 3197      00
 3198 2a8e C4E27D00 		vpshufb	.LC27(%rip), %ymm0, %ymm6
 3198      35000000 
 3198      00
 3199 2a97 C5EDEBD1 		vpor	%ymm1, %ymm2, %ymm2
 3200 2a9b C4E3FD00 		vpermq	$78, %ymm6, %ymm6
 3200      F64E
 3201 2aa1 C4E27D00 		vpshufb	.LC28(%rip), %ymm0, %ymm1
 3201      0D000000 
 3201      00
 3202 2aaa C4E25500 		vpshufb	.LC29(%rip), %ymm5, %ymm5
 3202      2D000000 
 3202      00
 3203 2ab3 C4E25D00 		vpshufb	.LC30(%rip), %ymm4, %ymm0
 3203      05000000 
 3203      00
 3204 2abc C5F5EBCE 		vpor	%ymm6, %ymm1, %ymm1
 3205 2ac0 C5F5EBCD 		vpor	%ymm5, %ymm1, %ymm1
 3206 2ac4 C4E3FD00 		vpermq	$78, %ymm0, %ymm0
 3206      C04E
 3207 2aca C4E25D00 		vpshufb	.LC31(%rip), %ymm4, %ymm4
 3207      25000000 
 3207      00
 3208 2ad3 C5DDEBE0 		vpor	%ymm0, %ymm4, %ymm4
 3209 2ad7 C4E27500 		vpshufb	.LC25(%rip), %ymm1, %ymm1
 3209      0D000000 
 3209      00
 3210 2ae0 C5F5EBCC 		vpor	%ymm4, %ymm1, %ymm1
 3211 2ae4 C4E37D39 		vextracti128	$0x1, %ymm3, %xmm0
 3211      D801
 3212 2aea C4E27D30 		vpmovzxbw	%xmm3, %ymm4
 3212      E3
 3213 2aef C4E27D33 		vpmovzxwd	%xmm4, %ymm3
 3213      DC
 3214 2af4 C4E27D30 		vpmovzxbw	%xmm0, %ymm0
 3214      C0
 3215              		.loc 1 228 38 discriminator 3 view .LVU905
 3216 2af9 C5FC5BFB 		vcvtdq2ps	%ymm3, %ymm7
 3217              		.loc 1 228 48 discriminator 3 view .LVU906
 3218 2afd C4E37D39 		vextracti128	$0x1, %ymm4, %xmm4
 3218      E401
 3219 2b03 C4E27D33 		vpmovzxwd	%xmm0, %ymm3
 3219      D8
 3220 2b08 C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 3220      C001
 3221 2b0e C4E27D33 		vpmovzxwd	%xmm4, %ymm4
 3221      E4
 3222 2b13 C4E27D33 		vpmovzxwd	%xmm0, %ymm0
 3222      C0
 3223              		.loc 1 228 38 discriminator 3 view .LVU907
 3224 2b18 C5FC5BEC 		vcvtdq2ps	%ymm4, %ymm5
 3225 2b1c C57C5BF8 		vcvtdq2ps	%ymm0, %ymm15
 3226 2b20 C5FC5BE3 		vcvtdq2ps	%ymm3, %ymm4
 229:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 3227              		.loc 1 229 48 discriminator 3 view .LVU908
 3228 2b24 C4E37D39 		vextracti128	$0x1, %ymm2, %xmm0
 3228      D001
 3229 2b2a C4E27D30 		vpmovzxbw	%xmm2, %ymm3
 3229      DA
 3230 2b2f C4E27D33 		vpmovzxwd	%xmm3, %ymm2
 3230      D3
 3231 2b34 C4E27D30 		vpmovzxbw	%xmm0, %ymm0
 3231      C0
 3232              		.loc 1 229 38 discriminator 3 view .LVU909
 3233 2b39 C5FC5BF2 		vcvtdq2ps	%ymm2, %ymm6
 3234              		.loc 1 229 48 discriminator 3 view .LVU910
 3235 2b3d C4E37D39 		vextracti128	$0x1, %ymm3, %xmm3
 3235      DB01
 3236 2b43 C4E27D33 		vpmovzxwd	%xmm0, %ymm2
 3236      D0
 3237 2b48 C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 3237      C001
 3238 2b4e C4E27D33 		vpmovzxwd	%xmm3, %ymm3
 3238      DB
 3239 2b53 C4E27D33 		vpmovzxwd	%xmm0, %ymm0
 3239      C0
 3240              		.loc 1 229 38 discriminator 3 view .LVU911
 3241 2b58 C57C5BC3 		vcvtdq2ps	%ymm3, %ymm8
 3242 2b5c C57C5BCA 		vcvtdq2ps	%ymm2, %ymm9
 3243 2b60 C57C5BD8 		vcvtdq2ps	%ymm0, %ymm11
 3244 2b64 C5BC5915 		vmulps	.LC32(%rip), %ymm8, %ymm2
 3244      00000000 
 3245 2b6c C5CC5905 		vmulps	.LC32(%rip), %ymm6, %ymm0
 3245      00000000 
 3246 2b74 C5B4591D 		vmulps	.LC32(%rip), %ymm9, %ymm3
 3246      00000000 
 3247 2b7c C5FC29B5 		vmovaps	%ymm6, -208(%rbp)
 3247      30FFFFFF 
 3248 2b84 C5FC297D 		vmovaps	%ymm7, -112(%rbp)
 3248      90
 3249 2b89 C4E255B8 		vfmadd231ps	.LC33(%rip), %ymm5, %ymm2
 3249      15000000 
 3249      00
 3250 2b92 C4E245B8 		vfmadd231ps	.LC33(%rip), %ymm7, %ymm0
 3250      05000000 
 3250      00
 3251 2b9b C57C2985 		vmovaps	%ymm8, -240(%rbp)
 3251      10FFFFFF 
 3252 2ba3 C5FC29AD 		vmovaps	%ymm5, -144(%rbp)
 3252      70FFFFFF 
 3253 2bab C57C298D 		vmovaps	%ymm9, -272(%rbp)
 3253      F0FEFFFF 
 3254 2bb3 C5FC29A5 		vmovaps	%ymm4, -176(%rbp)
 3254      50FFFFFF 
 3255 2bbb C4E25DB8 		vfmadd231ps	.LC33(%rip), %ymm4, %ymm3
 3255      1D000000 
 3255      00
 3256 2bc4 C5A4592D 		vmulps	.LC32(%rip), %ymm11, %ymm5
 3256      00000000 
 230:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 3257              		.loc 1 230 48 discriminator 3 view .LVU912
 3258 2bcc C4E27D30 		vpmovzxbw	%xmm1, %ymm4
 3258      E1
 3259 2bd1 C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 3259      C901
 3260 2bd7 C4E27D30 		vpmovzxbw	%xmm1, %ymm1
 3260      C9
 3261 2bdc C4627D33 		vpmovzxwd	%xmm4, %ymm8
 3261      C4
 3262 2be1 C4E27D33 		vpmovzxwd	%xmm1, %ymm7
 3262      F9
 3263 2be6 C4E37D39 		vextracti128	$0x1, %ymm4, %xmm4
 3263      E401
 3264 2bec C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 3264      C901
 3265 2bf2 C4E27D33 		vpmovzxwd	%xmm4, %ymm4
 3265      E4
 3266 2bf7 C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 3266      C9
 229:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 3267              		.loc 1 229 38 discriminator 3 view .LVU913
 3268 2bfc C57C299D 		vmovaps	%ymm11, -304(%rbp)
 3268      D0FEFFFF 
 3269              		.loc 1 230 38 discriminator 3 view .LVU914
 3270 2c04 C4417C5B 		vcvtdq2ps	%ymm8, %ymm8
 3270      C0
 3271 2c09 C5FC5BE4 		vcvtdq2ps	%ymm4, %ymm4
 3272 2c0d C5FC5BFF 		vcvtdq2ps	%ymm7, %ymm7
 3273 2c11 C5FC5BC9 		vcvtdq2ps	%ymm1, %ymm1
 3274 2c15 C4417C28 		vmovaps	%ymm8, %ymm14
 3274      F0
 3275 2c1a C57C28DC 		vmovaps	%ymm4, %ymm11
 3276 2c1e C57C28CF 		vmovaps	%ymm7, %ymm9
 3277 2c22 C5FC28F1 		vmovaps	%ymm1, %ymm6
 3278 2c26 C4622D98 		vfmadd132ps	.LC34(%rip), %ymm10, %ymm14
 3278      35000000 
 3278      00
 3279 2c2f C4622D98 		vfmadd132ps	.LC34(%rip), %ymm10, %ymm11
 3279      1D000000 
 3279      00
 3280 2c38 C4622D98 		vfmadd132ps	.LC34(%rip), %ymm10, %ymm9
 3280      0D000000 
 3280      00
 3281 2c41 C4E22D98 		vfmadd132ps	.LC34(%rip), %ymm10, %ymm6
 3281      35000000 
 3281      00
 3282 2c4a C4E205B8 		vfmadd231ps	.LC33(%rip), %ymm15, %ymm5
 3282      2D000000 
 3282      00
 226:sepia_filter.c ****                           0.5f +
 3283              		.loc 1 226 52 discriminator 3 view .LVU915
 3284 2c53 C4C17C58 		vaddps	%ymm14, %ymm0, %ymm0
 3284      C6
 3285 2c58 C4C16C58 		vaddps	%ymm11, %ymm2, %ymm2
 3285      D3
 3286 2c5d C4C16458 		vaddps	%ymm9, %ymm3, %ymm3
 3286      D9
 3287 2c62 C4C17C5D 		vminps	%ymm13, %ymm0, %ymm0
 3287      C5
 3288 2c67 C5D458EE 		vaddps	%ymm6, %ymm5, %ymm5
 3289 2c6b C4C16C5D 		vminps	%ymm13, %ymm2, %ymm2
 3289      D5
 3290 2c70 C4C1645D 		vminps	%ymm13, %ymm3, %ymm3
 3290      DD
 3291 2c75 C4C1545D 		vminps	%ymm13, %ymm5, %ymm5
 3291      ED
 226:sepia_filter.c ****                           0.5f +
 3292              		.loc 1 226 35 discriminator 3 view .LVU916
 3293 2c7a C5FE5BC0 		vcvttps2dq	%ymm0, %ymm0
 3294 2c7e C5FE5BD2 		vcvttps2dq	%ymm2, %ymm2
 3295 2c82 C59DDBC0 		vpand	%ymm0, %ymm12, %ymm0
 3296 2c86 C59DDBD2 		vpand	%ymm2, %ymm12, %ymm2
 3297 2c8a C5FE5BDB 		vcvttps2dq	%ymm3, %ymm3
 3298 2c8e C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 3299 2c92 C59DDBDB 		vpand	%ymm3, %ymm12, %ymm3
 3300 2c96 C59DDBED 		vpand	%ymm5, %ymm12, %ymm5
 3301 2c9a C57D6F5D 		vmovdqa	-80(%rbp), %ymm11
 3301      B0
 3302 2c9f C4E27D2B 		vpackusdw	%ymm2, %ymm0, %ymm0
 3302      C2
 3303 2ca4 C4E2652B 		vpackusdw	%ymm5, %ymm3, %ymm3
 3303      DD
 3304 2ca9 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 3304      C0D8
 3305 2caf C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 3305      DBD8
 3306 2cb5 C4C165DB 		vpand	%ymm11, %ymm3, %ymm3
 3306      DB
 3307 2cba C4C17DDB 		vpand	%ymm11, %ymm0, %ymm0
 3307      C3
 3308 2cbf C5FD67C3 		vpackuswb	%ymm3, %ymm0, %ymm0
 231:sepia_filter.c ****             /* G */
 232:sepia_filter.c ****             pixels_out[3*i + 1] = (unsigned char) (fminf(MAXPIXV,
 233:sepia_filter.c ****                           0.5f +
 234:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 235:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 3309              		.loc 1 235 38 discriminator 3 view .LVU917
 3310 2cc3 C5FC289D 		vmovaps	-208(%rbp), %ymm3
 3310      30FFFFFF 
 226:sepia_filter.c ****                           0.5f +
 3311              		.loc 1 226 35 discriminator 3 view .LVU918
 3312 2ccb C4E3FD00 		vpermq	$216, %ymm0, %ymm2
 3312      D0D8
 232:sepia_filter.c ****                           0.5f +
 3313              		.loc 1 232 13 is_stmt 1 discriminator 3 view .LVU919
 3314              		.loc 1 235 38 is_stmt 0 discriminator 3 view .LVU920
 3315 2cd1 C5E45905 		vmulps	.LC40(%rip), %ymm3, %ymm0
 3315      00000000 
 3316 2cd9 C5FC2875 		vmovaps	-112(%rbp), %ymm6
 3316      90
 3317 2cde C57C28B5 		vmovaps	-240(%rbp), %ymm14
 3317      10FFFFFF 
 3318 2ce6 C5FC28AD 		vmovaps	-144(%rbp), %ymm5
 3318      70FFFFFF 
 3319 2cee C57C288D 		vmovaps	-272(%rbp), %ymm9
 3319      F0FEFFFF 
 3320 2cf6 C4E24DB8 		vfmadd231ps	.LC41(%rip), %ymm6, %ymm0
 3320      05000000 
 3320      00
 3321 2cff C58C5935 		vmulps	.LC40(%rip), %ymm14, %ymm6
 3321      00000000 
 3322 2d07 C4417C28 		vmovaps	%ymm8, %ymm14
 3322      F0
 3323 2d0c C5B4591D 		vmulps	.LC40(%rip), %ymm9, %ymm3
 3323      00000000 
 3324 2d14 C4622D98 		vfmadd132ps	.LC42(%rip), %ymm10, %ymm14
 3324      35000000 
 3324      00
 3325 2d1d C57C288D 		vmovaps	-176(%rbp), %ymm9
 3325      50FFFFFF 
 3326 2d25 C4E255B8 		vfmadd231ps	.LC41(%rip), %ymm5, %ymm6
 3326      35000000 
 3326      00
 3327 2d2e C5FC28AD 		vmovaps	-304(%rbp), %ymm5
 3327      D0FEFFFF 
 3328 2d36 C4E235B8 		vfmadd231ps	.LC41(%rip), %ymm9, %ymm3
 3328      1D000000 
 3328      00
 3329 2d3f C5D4592D 		vmulps	.LC40(%rip), %ymm5, %ymm5
 3329      00000000 
 3330 2d47 C57C29B5 		vmovaps	%ymm14, -336(%rbp)
 3330      B0FEFFFF 
 3331 2d4f C57C28DF 		vmovaps	%ymm7, %ymm11
 3332 2d53 C57C28F4 		vmovaps	%ymm4, %ymm14
 3333 2d57 C57C28C9 		vmovaps	%ymm1, %ymm9
 3334 2d5b C4622D98 		vfmadd132ps	.LC42(%rip), %ymm10, %ymm14
 3334      35000000 
 3334      00
 3335 2d64 C4622D98 		vfmadd132ps	.LC42(%rip), %ymm10, %ymm11
 3335      1D000000 
 3335      00
 3336 2d6d C4622D98 		vfmadd132ps	.LC42(%rip), %ymm10, %ymm9
 3336      0D000000 
 3336      00
 3337 2d76 C4E205B8 		vfmadd231ps	.LC41(%rip), %ymm15, %ymm5
 3337      2D000000 
 3337      00
 232:sepia_filter.c ****                           0.5f +
 3338              		.loc 1 232 52 discriminator 3 view .LVU921
 3339 2d7f C5FC5885 		vaddps	-336(%rbp), %ymm0, %ymm0
 3339      B0FEFFFF 
 3340 2d87 C4C14C58 		vaddps	%ymm14, %ymm6, %ymm6
 3340      F6
 3341 2d8c C4C16458 		vaddps	%ymm11, %ymm3, %ymm3
 3341      DB
 3342 2d91 C4C17C5D 		vminps	%ymm13, %ymm0, %ymm0
 3342      C5
 3343 2d96 C4C15458 		vaddps	%ymm9, %ymm5, %ymm5
 3343      E9
 3344 2d9b C4C14C5D 		vminps	%ymm13, %ymm6, %ymm6
 3344      F5
 3345 2da0 C4C1645D 		vminps	%ymm13, %ymm3, %ymm3
 3345      DD
 3346 2da5 C4C1545D 		vminps	%ymm13, %ymm5, %ymm5
 3346      ED
 232:sepia_filter.c ****                           0.5f +
 3347              		.loc 1 232 35 discriminator 3 view .LVU922
 3348 2daa C5FE5BC0 		vcvttps2dq	%ymm0, %ymm0
 3349 2dae C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 3350 2db2 C59DDBC0 		vpand	%ymm0, %ymm12, %ymm0
 3351 2db6 C59DDBF6 		vpand	%ymm6, %ymm12, %ymm6
 3352 2dba C5FE5BDB 		vcvttps2dq	%ymm3, %ymm3
 3353 2dbe C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 3354 2dc2 C59DDBDB 		vpand	%ymm3, %ymm12, %ymm3
 3355 2dc6 C59DDBED 		vpand	%ymm5, %ymm12, %ymm5
 3356 2dca C57D6F5D 		vmovdqa	-80(%rbp), %ymm11
 3356      B0
 3357 2dcf C4E27D2B 		vpackusdw	%ymm6, %ymm0, %ymm0
 3357      C6
 3358 2dd4 C4E2652B 		vpackusdw	%ymm5, %ymm3, %ymm3
 3358      DD
 3359 2dd9 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 3359      C0D8
 3360 2ddf C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 3360      DBD8
 3361 2de5 C4C165DB 		vpand	%ymm11, %ymm3, %ymm3
 3361      DB
 3362 2dea C4C17DDB 		vpand	%ymm11, %ymm0, %ymm0
 3362      C3
 3363 2def C5FD67C3 		vpackuswb	%ymm3, %ymm0, %ymm0
 236:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 237:sepia_filter.c ****             /* B */
 238:sepia_filter.c ****             pixels_out[3*i + 2] = (unsigned char) (fminf(MAXPIXV,
 239:sepia_filter.c ****                           0.5f +
 240:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 241:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 3364              		.loc 1 241 38 discriminator 3 view .LVU923
 3365 2df3 C5FC289D 		vmovaps	-208(%rbp), %ymm3
 3365      30FFFFFF 
 232:sepia_filter.c ****                           0.5f +
 3366              		.loc 1 232 35 discriminator 3 view .LVU924
 3367 2dfb C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 3367      C0D8
 238:sepia_filter.c ****                           0.5f +
 3368              		.loc 1 238 13 is_stmt 1 discriminator 3 view .LVU925
 3369              		.loc 1 241 38 is_stmt 0 discriminator 3 view .LVU926
 3370 2e01 C5E4591D 		vmulps	.LC43(%rip), %ymm3, %ymm3
 3370      00000000 
 3371 2e09 C57C28B5 		vmovaps	-240(%rbp), %ymm14
 3371      10FFFFFF 
 3372 2e11 C5FC2875 		vmovaps	-112(%rbp), %ymm6
 3372      90
 3373 2e16 C58C592D 		vmulps	.LC43(%rip), %ymm14, %ymm5
 3373      00000000 
 3374 2e1e C57C288D 		vmovaps	-176(%rbp), %ymm9
 3374      50FFFFFF 
 3375 2e26 C4E24DB8 		vfmadd231ps	.LC44(%rip), %ymm6, %ymm3
 3375      1D000000 
 3375      00
 3376 2e2f C5FC28B5 		vmovaps	-144(%rbp), %ymm6
 3376      70FFFFFF 
 3377 2e37 C4E22D98 		vfmadd132ps	.LC45(%rip), %ymm10, %ymm4
 3377      25000000 
 3377      00
 3378 2e40 C4E24DB8 		vfmadd231ps	.LC44(%rip), %ymm6, %ymm5
 3378      2D000000 
 3378      00
 3379 2e49 C5FC28B5 		vmovaps	-272(%rbp), %ymm6
 3379      F0FEFFFF 
 3380 2e51 C4622D98 		vfmadd132ps	.LC45(%rip), %ymm10, %ymm8
 3380      05000000 
 3380      00
 3381 2e5a C5CC5935 		vmulps	.LC43(%rip), %ymm6, %ymm6
 3381      00000000 
 3382 2e62 C4E22D98 		vfmadd132ps	.LC45(%rip), %ymm10, %ymm1
 3382      0D000000 
 3382      00
 3383 2e6b C4E22D98 		vfmadd132ps	.LC45(%rip), %ymm10, %ymm7
 3383      3D000000 
 3383      00
 238:sepia_filter.c ****                           0.5f +
 3384              		.loc 1 238 52 discriminator 3 view .LVU927
 3385 2e74 C5D458EC 		vaddps	%ymm4, %ymm5, %ymm5
 3386 2e78 C4C16458 		vaddps	%ymm8, %ymm3, %ymm3
 3386      D8
 3387 2e7d C4E235B8 		vfmadd231ps	.LC44(%rip), %ymm9, %ymm6
 3387      35000000 
 3387      00
 3388              		.loc 1 241 38 discriminator 3 view .LVU928
 3389 2e86 C57C288D 		vmovaps	-304(%rbp), %ymm9
 3389      D0FEFFFF 
 238:sepia_filter.c ****                           0.5f +
 3390              		.loc 1 238 52 discriminator 3 view .LVU929
 3391 2e8e C4C1645D 		vminps	%ymm13, %ymm3, %ymm3
 3391      DD
 3392              		.loc 1 241 38 discriminator 3 view .LVU930
 3393 2e93 C534590D 		vmulps	.LC43(%rip), %ymm9, %ymm9
 3393      00000000 
 238:sepia_filter.c ****                           0.5f +
 3394              		.loc 1 238 52 discriminator 3 view .LVU931
 3395 2e9b C4C1545D 		vminps	%ymm13, %ymm5, %ymm5
 3395      ED
 3396 2ea0 C5CC58FF 		vaddps	%ymm7, %ymm6, %ymm7
 238:sepia_filter.c ****                           0.5f +
 3397              		.loc 1 238 35 discriminator 3 view .LVU932
 3398 2ea4 C5FE5BDB 		vcvttps2dq	%ymm3, %ymm3
 3399 2ea8 C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 3400 2eac C46205B8 		vfmadd231ps	.LC44(%rip), %ymm15, %ymm9
 3400      0D000000 
 3400      00
 238:sepia_filter.c ****                           0.5f +
 3401              		.loc 1 238 52 discriminator 3 view .LVU933
 3402 2eb5 C4C1445D 		vminps	%ymm13, %ymm7, %ymm7
 3402      FD
 238:sepia_filter.c ****                           0.5f +
 3403              		.loc 1 238 35 discriminator 3 view .LVU934
 3404 2eba C59DDBED 		vpand	%ymm5, %ymm12, %ymm5
 3405 2ebe C59DDBDB 		vpand	%ymm3, %ymm12, %ymm3
 3406 2ec2 C4E2652B 		vpackusdw	%ymm5, %ymm3, %ymm3
 3406      DD
 238:sepia_filter.c ****                           0.5f +
 3407              		.loc 1 238 52 discriminator 3 view .LVU935
 3408 2ec7 C53458C9 		vaddps	%ymm1, %ymm9, %ymm9
 238:sepia_filter.c ****                           0.5f +
 3409              		.loc 1 238 35 discriminator 3 view .LVU936
 3410 2ecb C4E3FD00 		vpermq	$216, %ymm3, %ymm4
 3410      E3D8
 3411 2ed1 C5FE5BDF 		vcvttps2dq	%ymm7, %ymm3
 238:sepia_filter.c ****                           0.5f +
 3412              		.loc 1 238 52 discriminator 3 view .LVU937
 3413 2ed5 C441345D 		vminps	%ymm13, %ymm9, %ymm9
 3413      CD
 238:sepia_filter.c ****                           0.5f +
 3414              		.loc 1 238 35 discriminator 3 view .LVU938
 3415 2eda C59DDBDB 		vpand	%ymm3, %ymm12, %ymm3
 3416 2ede C4C15DDB 		vpand	%ymm11, %ymm4, %ymm1
 3416      CB
 3417 2ee3 C4417E5B 		vcvttps2dq	%ymm9, %ymm9
 3417      C9
 3418 2ee8 C4411DDB 		vpand	%ymm9, %ymm12, %ymm9
 3418      C9
 3419 2eed C4C2652B 		vpackusdw	%ymm9, %ymm3, %ymm3
 3419      D9
 3420 2ef2 C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 3420      DBD8
 3421 2ef8 C4C165DB 		vpand	%ymm11, %ymm3, %ymm3
 3421      DB
 238:sepia_filter.c ****                           0.5f +
 3422              		.loc 1 238 33 discriminator 3 view .LVU939
 3423 2efd C4E26D00 		vpshufb	.LC46(%rip), %ymm2, %ymm6
 3423      35000000 
 3423      00
 3424 2f06 C4E27D00 		vpshufb	.LC47(%rip), %ymm0, %ymm5
 3424      2D000000 
 3424      00
 238:sepia_filter.c ****                           0.5f +
 3425              		.loc 1 238 35 discriminator 3 view .LVU940
 3426 2f0f C5F567CB 		vpackuswb	%ymm3, %ymm1, %ymm1
 3427 2f13 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 3427      C9D8
 238:sepia_filter.c ****                           0.5f +
 3428              		.loc 1 238 33 discriminator 3 view .LVU941
 3429 2f19 C4E26D00 		vpshufb	.LC48(%rip), %ymm2, %ymm3
 3429      1D000000 
 3429      00
 3430 2f22 C4E27D00 		vpshufb	.LC49(%rip), %ymm0, %ymm4
 3430      25000000 
 3430      00
 3431 2f2b C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 3431      ED4E
 3432 2f31 C4E3FD00 		vpermq	$78, %ymm6, %ymm6
 3432      F64E
 3433 2f37 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 3434 2f3b C5E5EBDE 		vpor	%ymm6, %ymm3, %ymm3
 3435 2f3f C4E27500 		vpshufb	.LC50(%rip), %ymm1, %ymm5
 3435      2D000000 
 3435      00
 3436 2f48 C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 3437 2f4c C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 3437      ED4E
 3438 2f52 C4E27500 		vpshufb	.LC52(%rip), %ymm1, %ymm4
 3438      25000000 
 3438      00
 3439 2f5b C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 3440 2f5f C4E26500 		vpshufb	.LC51(%rip), %ymm3, %ymm3
 3440      1D000000 
 3440      00
 3441 2f68 C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 3442 2f6c C4E26D00 		vpshufb	.LC53(%rip), %ymm2, %ymm4
 3442      25000000 
 3442      00
 3443 2f75 C5FE7F1E 		vmovdqu	%ymm3, (%rsi)
 3444 2f79 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 3444      E44E
 3445 2f7f C4E26D00 		vpshufb	.LC54(%rip), %ymm2, %ymm3
 3445      1D000000 
 3445      00
 3446 2f88 C4E27D00 		vpshufb	.LC55(%rip), %ymm0, %ymm5
 3446      2D000000 
 3446      00
 3447 2f91 C5FD6F3D 		vmovdqa	.LC57(%rip), %ymm7
 3447      00000000 
 3448 2f99 C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 3449 2f9d C5E5EBDD 		vpor	%ymm5, %ymm3, %ymm3
 3450 2fa1 C4E27500 		vpshufb	.LC56(%rip), %ymm1, %ymm4
 3450      25000000 
 3450      00
 3451 2faa C4E35D4C 		vpblendvb	%ymm7, %ymm3, %ymm4, %ymm3
 3451      DB70
 3452 2fb0 C5FE7F5E 		vmovdqu	%ymm3, 32(%rsi)
 3452      20
 3453 2fb5 C4E27D00 		vpshufb	.LC58(%rip), %ymm0, %ymm4
 3453      25000000 
 3453      00
 3454 2fbe C4E26D00 		vpshufb	.LC59(%rip), %ymm2, %ymm3
 3454      1D000000 
 3454      00
 3455 2fc7 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 3455      E44E
 3456 2fcd C4E3FD00 		vpermq	$78, %ymm3, %ymm3
 3456      DB4E
 3457 2fd3 C4E27D00 		vpshufb	.LC60(%rip), %ymm0, %ymm0
 3457      05000000 
 3457      00
 3458 2fdc C4E26D00 		vpshufb	.LC61(%rip), %ymm2, %ymm2
 3458      15000000 
 3458      00
 3459 2fe5 C5EDEBD3 		vpor	%ymm3, %ymm2, %ymm2
 3460 2fe9 C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 3461 2fed C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 3462 2ff1 C4E27500 		vpshufb	.LC62(%rip), %ymm1, %ymm2
 3462      15000000 
 3462      00
 3463 2ffa C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 3463      D24E
 3464 3000 C4E27500 		vpshufb	.LC64(%rip), %ymm1, %ymm1
 3464      0D000000 
 3464      00
 3465 3009 C4E27D00 		vpshufb	.LC63(%rip), %ymm0, %ymm0
 3465      05000000 
 3465      00
 3466 3012 C5F5EBCA 		vpor	%ymm2, %ymm1, %ymm1
 3467 3016 C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 3468 301a 4883C060 		addq	$96, %rax
 3469 301e C5FE7F46 		vmovdqu	%ymm0, 64(%rsi)
 3469      40
 222:sepia_filter.c ****         {
 3470              		.loc 1 222 44 is_stmt 1 discriminator 3 view .LVU942
 222:sepia_filter.c ****         {
 3471              		.loc 1 222 9 discriminator 3 view .LVU943
 3472 3023 4883C660 		addq	$96, %rsi
 3473 3027 4C39E0   		cmpq	%r12, %rax
 3474 302a 0F85B0F9 		jne	.L70
 3474      FFFF
 3475 3030 8BBD88FE 		movl	-376(%rbp), %edi
 3475      FFFF
 3476 3036 89F8     		movl	%edi, %eax
 3477 3038 4439F8   		cmpl	%r15d, %eax
 3478 303b 0F848B06 		je	.L71
 3478      0000
 3479 3041 C5F877   		vzeroupper
 3480              	.LVL76:
 3481              	.L69:
 222:sepia_filter.c ****         {
 3482              		.loc 1 222 9 is_stmt 0 discriminator 3 view .LVU944
 3483 3044 4489FE   		movl	%r15d, %esi
 3484 3047 29C6     		subl	%eax, %esi
 3485 3049 448D56FF 		leal	-1(%rsi), %r10d
 3486 304d 4183FA0E 		cmpl	$14, %r10d
 3487 3051 0F86C804 		jbe	.L72
 3487      0000
 3488 3057 488D0440 		leaq	(%rax,%rax,2), %rax
 3489 305b 4D8D5405 		leaq	0(%r13,%rax), %r10
 3489      00
 228:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 3490              		.loc 1 228 48 view .LVU945
 3491 3060 C4C17A6F 		vmovdqu	(%r10), %xmm0
 3491      02
 3492 3065 C4C17A6F 		vmovdqu	16(%r10), %xmm4
 3492      6210
 3493 306b C4C17A6F 		vmovdqu	32(%r10), %xmm3
 3493      5A20
 3494 3071 C5F96F2D 		vmovdqa	.LC68(%rip), %xmm5
 3494      00000000 
 3495 3079 C4E25900 		vpshufb	.LC66(%rip), %xmm4, %xmm2
 3495      15000000 
 3495      00
 3496 3082 C4E27900 		vpshufb	.LC65(%rip), %xmm0, %xmm1
 3496      0D000000 
 3496      00
 3497 308b C5F1EBCA 		vpor	%xmm2, %xmm1, %xmm1
 3498 308f C4E26100 		vpshufb	.LC67(%rip), %xmm3, %xmm2
 3498      15000000 
 3498      00
 3499 3098 C4E3714C 		vpblendvb	%xmm5, %xmm2, %xmm1, %xmm1
 3499      CA50
 3500 309e C4E25900 		vpshufb	.LC70(%rip), %xmm4, %xmm6
 3500      35000000 
 3500      00
 3501 30a7 C4E27900 		vpshufb	.LC69(%rip), %xmm0, %xmm2
 3501      15000000 
 3501      00
 3502 30b0 C4E25900 		vpshufb	.LC73(%rip), %xmm4, %xmm4
 3502      25000000 
 3502      00
 3503 30b9 C4E27900 		vpshufb	.LC72(%rip), %xmm0, %xmm0
 3503      05000000 
 3503      00
 3504 30c2 C5E9EBD6 		vpor	%xmm6, %xmm2, %xmm2
 3505 30c6 C5F9EBC4 		vpor	%xmm4, %xmm0, %xmm0
 3506 30ca C4E26100 		vpshufb	.LC71(%rip), %xmm3, %xmm6
 3506      35000000 
 3506      00
 3507 30d3 C4E26100 		vpshufb	.LC74(%rip), %xmm3, %xmm3
 3507      1D000000 
 3507      00
 3508 30dc C4E3790E 		vpblendw	$224, %xmm3, %xmm0, %xmm0
 3508      C3E0
 3509 30e2 C4E27930 		vpmovzxbw	%xmm1, %xmm3
 3509      D9
 3510 30e7 C4E27933 		vpmovzxwd	%xmm3, %xmm4
 3510      E3
 3511 30ec C5F173D9 		vpsrldq	$8, %xmm1, %xmm1
 3511      08
 3512 30f1 C5E173DB 		vpsrldq	$8, %xmm3, %xmm3
 3512      08
 3513 30f6 C4E27930 		vpmovzxbw	%xmm1, %xmm1
 3513      C9
 3514 30fb C4E27933 		vpmovzxwd	%xmm3, %xmm3
 3514      DB
 3515 3100 C4E3694C 		vpblendvb	%xmm5, %xmm6, %xmm2, %xmm2
 3515      D650
 228:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 3516              		.loc 1 228 38 view .LVU946
 3517 3106 C5F85BEB 		vcvtdq2ps	%xmm3, %xmm5
 228:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 3518              		.loc 1 228 48 view .LVU947
 3519 310a C4E27933 		vpmovzxwd	%xmm1, %xmm3
 3519      D9
 3520 310f C5F173D9 		vpsrldq	$8, %xmm1, %xmm1
 3520      08
 3521 3114 C4E27933 		vpmovzxwd	%xmm1, %xmm1
 3521      C9
 228:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 3522              		.loc 1 228 38 view .LVU948
 3523 3119 C5785BD3 		vcvtdq2ps	%xmm3, %xmm10
 3524 311d C5785BF9 		vcvtdq2ps	%xmm1, %xmm15
 229:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 3525              		.loc 1 229 48 view .LVU949
 3526 3121 C4E27930 		vpmovzxbw	%xmm2, %xmm3
 3526      DA
 3527 3126 C5F173DA 		vpsrldq	$8, %xmm2, %xmm1
 3527      08
 3528 312b C4E27930 		vpmovzxbw	%xmm1, %xmm1
 3528      C9
 3529 3130 C4E27933 		vpmovzxwd	%xmm3, %xmm2
 3529      D3
 228:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 3530              		.loc 1 228 38 view .LVU950
 3531 3135 C5F85BF4 		vcvtdq2ps	%xmm4, %xmm6
 229:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 3532              		.loc 1 229 38 view .LVU951
 3533 3139 C5F85BFA 		vcvtdq2ps	%xmm2, %xmm7
 3534 313d C4E27918 		vbroadcastss	.LC1(%rip), %xmm4
 3534      25000000 
 3534      00
 229:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 3535              		.loc 1 229 48 view .LVU952
 3536 3146 C4E27933 		vpmovzxwd	%xmm1, %xmm2
 3536      D1
 3537 314b C5E173DB 		vpsrldq	$8, %xmm3, %xmm3
 3537      08
 3538 3150 C5F173D9 		vpsrldq	$8, %xmm1, %xmm1
 3538      08
 3539 3155 C4E27933 		vpmovzxwd	%xmm3, %xmm3
 3539      DB
 3540 315a C4E27933 		vpmovzxwd	%xmm1, %xmm1
 3540      C9
 229:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 3541              		.loc 1 229 38 view .LVU953
 3542 315f C5785BC3 		vcvtdq2ps	%xmm3, %xmm8
 3543 3163 C5785BC9 		vcvtdq2ps	%xmm1, %xmm9
 3544 3167 C4C15859 		vmulps	%xmm8, %xmm4, %xmm1
 3544      C8
 3545 316c C5785BEA 		vcvtdq2ps	%xmm2, %xmm13
 3546 3170 C59059D4 		vmulps	%xmm4, %xmm13, %xmm2
 3547 3174 C4E27918 		vbroadcastss	.LC2(%rip), %xmm3
 3547      1D000000 
 3547      00
 3548 317d C5F829BD 		vmovaps	%xmm7, -176(%rbp)
 3548      50FFFFFF 
 3549 3185 C5D859FF 		vmulps	%xmm7, %xmm4, %xmm7
 3550 3189 C4C15859 		vmulps	%xmm9, %xmm4, %xmm4
 3550      E1
 3551 318e C4E261B8 		vfmadd231ps	%xmm5, %xmm3, %xmm1
 3551      CD
 3552 3193 C5F8296D 		vmovaps	%xmm5, -112(%rbp)
 3552      90
 230:sepia_filter.c ****             /* G */
 3553              		.loc 1 230 48 view .LVU954
 3554 3198 C4E27930 		vpmovzxbw	%xmm0, %xmm5
 3554      E8
 3555 319d C5F973D8 		vpsrldq	$8, %xmm0, %xmm0
 3555      08
 3556 31a2 C4E27930 		vpmovzxbw	%xmm0, %xmm0
 3556      C0
 3557 31a7 C4C261B8 		vfmadd231ps	%xmm10, %xmm3, %xmm2
 3557      D2
 3558 31ac C5782995 		vmovaps	%xmm10, -144(%rbp)
 3558      70FFFFFF 
 3559 31b4 C4627933 		vpmovzxwd	%xmm5, %xmm11
 3559      DD
 3560 31b9 C4627933 		vpmovzxwd	%xmm0, %xmm10
 3560      D0
 3561 31be C5D173DD 		vpsrldq	$8, %xmm5, %xmm5
 3561      08
 3562 31c3 C5F973D8 		vpsrldq	$8, %xmm0, %xmm0
 3562      08
 3563 31c8 C4E261B8 		vfmadd231ps	%xmm6, %xmm3, %xmm7
 3563      FE
 3564 31cd C5F82975 		vmovaps	%xmm6, -80(%rbp)
 3564      B0
 229:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 3565              		.loc 1 229 38 view .LVU955
 3566 31d2 C5782985 		vmovaps	%xmm8, -208(%rbp)
 3566      30FFFFFF 
 3567 31da C4E27918 		vbroadcastss	.LC106(%rip), %xmm6
 3567      35000000 
 3567      00
 3568 31e3 C4627918 		vbroadcastss	.LC3(%rip), %xmm8
 3568      05000000 
 3568      00
 230:sepia_filter.c ****             /* G */
 3569              		.loc 1 230 48 view .LVU956
 3570 31ec C4E27933 		vpmovzxwd	%xmm0, %xmm0
 3570      C0
 3571 31f1 C4E27933 		vpmovzxwd	%xmm5, %xmm5
 3571      ED
 230:sepia_filter.c ****             /* G */
 3572              		.loc 1 230 38 view .LVU957
 3573 31f6 C441785B 		vcvtdq2ps	%xmm11, %xmm11
 3573      DB
 3574 31fb C5F85BED 		vcvtdq2ps	%xmm5, %xmm5
 3575 31ff C441785B 		vcvtdq2ps	%xmm10, %xmm10
 3575      D2
 3576 3204 C5785BE0 		vcvtdq2ps	%xmm0, %xmm12
 3577 3208 C4C25998 		vfmadd132ps	%xmm15, %xmm4, %xmm3
 3577      DF
 3578 320d C57829A5 		vmovaps	%xmm12, -240(%rbp)
 3578      10FFFFFF 
 3579 3215 C57829DC 		vmovaps	%xmm11, %xmm4
 3580 3219 C5F828C5 		vmovaps	%xmm5, %xmm0
 3581 321d C4417828 		vmovaps	%xmm10, %xmm12
 3581      E2
 3582 3222 C4C24998 		vfmadd132ps	%xmm8, %xmm6, %xmm4
 3582      E0
 3583 3227 C4C24998 		vfmadd132ps	%xmm8, %xmm6, %xmm0
 3583      C0
 3584 322c C4424998 		vfmadd132ps	%xmm8, %xmm6, %xmm12
 3584      E0
 3585 3231 C4624998 		vfmadd132ps	-240(%rbp), %xmm6, %xmm8
 3585      8510FFFF 
 3585      FF
 226:sepia_filter.c ****                           0.5f +
 3586              		.loc 1 226 35 view .LVU958
 3587 323a BAFFFF00 		movl	$65535, %edx
 3587      00
 226:sepia_filter.c ****                           0.5f +
 3588              		.loc 1 226 52 view .LVU959
 3589 323f C5C058FC 		vaddps	%xmm4, %xmm7, %xmm7
 3590 3243 C5F058C8 		vaddps	%xmm0, %xmm1, %xmm1
 3591 3247 C4C16858 		vaddps	%xmm12, %xmm2, %xmm2
 3591      D4
 3592 324c C4C16058 		vaddps	%xmm8, %xmm3, %xmm3
 3592      D8
 3593 3251 C4E27918 		vbroadcastss	.LC4(%rip), %xmm4
 3593      25000000 
 3593      00
 226:sepia_filter.c ****                           0.5f +
 3594              		.loc 1 226 35 view .LVU960
 3595 325a C5F96EC2 		vmovd	%edx, %xmm0
 226:sepia_filter.c ****                           0.5f +
 3596              		.loc 1 226 52 view .LVU961
 3597 325e C5C05DFC 		vminps	%xmm4, %xmm7, %xmm7
 3598 3262 C5F05DCC 		vminps	%xmm4, %xmm1, %xmm1
 3599 3266 C5E85DD4 		vminps	%xmm4, %xmm2, %xmm2
 3600 326a C5E05DDC 		vminps	%xmm4, %xmm3, %xmm3
 226:sepia_filter.c ****                           0.5f +
 3601              		.loc 1 226 35 view .LVU962
 3602 326e C5F970C0 		vpshufd	$0, %xmm0, %xmm0
 3602      00
 3603 3273 41BAFF00 		movl	$255, %r10d
 3603      0000
 229:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 3604              		.loc 1 229 38 view .LVU963
 3605 3279 C4417828 		vmovaps	%xmm9, %xmm14
 3605      F1
 226:sepia_filter.c ****                           0.5f +
 3606              		.loc 1 226 35 view .LVU964
 3607 327e C5FA5BFF 		vcvttps2dq	%xmm7, %xmm7
 3608 3282 C441796E 		vmovd	%r10d, %xmm9
 3608      CA
 3609 3287 C5F9DBFF 		vpand	%xmm7, %xmm0, %xmm7
 3610 328b C5FA5BC9 		vcvttps2dq	%xmm1, %xmm1
 3611 328f C5FA5BD2 		vcvttps2dq	%xmm2, %xmm2
 3612 3293 C5F9DBC9 		vpand	%xmm1, %xmm0, %xmm1
 3613 3297 C5F9DBD2 		vpand	%xmm2, %xmm0, %xmm2
 3614 329b C5FA5BDB 		vcvttps2dq	%xmm3, %xmm3
 3615 329f C5F9DBDB 		vpand	%xmm3, %xmm0, %xmm3
 3616 32a3 C4427979 		vpbroadcastw	%xmm9, %xmm9
 3616      C9
 235:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 3617              		.loc 1 235 38 view .LVU965
 3618 32a8 C4627918 		vbroadcastss	.LC7(%rip), %xmm12
 3618      25000000 
 3618      00
 226:sepia_filter.c ****                           0.5f +
 3619              		.loc 1 226 35 view .LVU966
 3620 32b1 C4E2412B 		vpackusdw	%xmm1, %xmm7, %xmm1
 3620      C9
 3621 32b6 C4E2692B 		vpackusdw	%xmm3, %xmm2, %xmm2
 3621      D3
 3622 32bb C5B1DBD2 		vpand	%xmm2, %xmm9, %xmm2
 3623 32bf C5B1DBC9 		vpand	%xmm1, %xmm9, %xmm1
 3624 32c3 C5F167CA 		vpackuswb	%xmm2, %xmm1, %xmm1
 235:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 3625              		.loc 1 235 38 view .LVU967
 3626 32c7 C5185985 		vmulps	-208(%rbp), %xmm12, %xmm8
 3626      30FFFFFF 
 3627 32cf C5985995 		vmulps	-176(%rbp), %xmm12, %xmm2
 3627      50FFFFFF 
 3628 32d7 C4C11059 		vmulps	%xmm12, %xmm13, %xmm7
 3628      FC
 3629 32dc C4411859 		vmulps	%xmm14, %xmm12, %xmm12
 3629      E6
 3630 32e1 C4E27918 		vbroadcastss	.LC8(%rip), %xmm3
 3630      1D000000 
 3630      00
 3631 32ea 4C01F0   		addq	%r14, %rax
 226:sepia_filter.c ****                           0.5f +
 3632              		.loc 1 226 13 is_stmt 1 view .LVU968
 232:sepia_filter.c ****                           0.5f +
 3633              		.loc 1 232 13 view .LVU969
 3634 32ed C4E261B8 		vfmadd231ps	-80(%rbp), %xmm3, %xmm2
 3634      55B0
 3635 32f3 C46261B8 		vfmadd231ps	-112(%rbp), %xmm3, %xmm8
 3635      4590
 3636 32f9 C4E261B8 		vfmadd231ps	-144(%rbp), %xmm3, %xmm7
 3636      BD70FFFF 
 3636      FF
 235:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 3637              		.loc 1 235 38 is_stmt 0 view .LVU970
 3638 3302 C57829B5 		vmovaps	%xmm14, -352(%rbp)
 3638      A0FEFFFF 
 3639 330a C4C21998 		vfmadd132ps	%xmm15, %xmm12, %xmm3
 3639      DF
 3640 330f C4627918 		vbroadcastss	.LC9(%rip), %xmm12
 3640      25000000 
 3640      00
 3641 3318 C4417828 		vmovaps	%xmm11, %xmm14
 3641      F3
 3642 331d C4424998 		vfmadd132ps	%xmm12, %xmm6, %xmm14
 3642      F4
 3643 3322 C57829B5 		vmovaps	%xmm14, -336(%rbp)
 3643      B0FEFFFF 
 3644 332a C57828F5 		vmovaps	%xmm5, %xmm14
 3645 332e C4424998 		vfmadd132ps	%xmm12, %xmm6, %xmm14
 3645      F4
 232:sepia_filter.c ****                           0.5f +
 3646              		.loc 1 232 52 view .LVU971
 3647 3333 C5E85895 		vaddps	-336(%rbp), %xmm2, %xmm2
 3647      B0FEFFFF 
 3648 333b C5E85DD4 		vminps	%xmm4, %xmm2, %xmm2
 3649 333f C57829B5 		vmovaps	%xmm14, -304(%rbp)
 3649      D0FEFFFF 
 3650 3347 C4417828 		vmovaps	%xmm10, %xmm14
 3650      F2
 3651 334c C4424998 		vfmadd132ps	%xmm12, %xmm6, %xmm14
 3651      F4
 3652 3351 C5385885 		vaddps	-304(%rbp), %xmm8, %xmm8
 3652      D0FEFFFF 
 232:sepia_filter.c ****                           0.5f +
 3653              		.loc 1 232 35 view .LVU972
 3654 3359 C5FA5BD2 		vcvttps2dq	%xmm2, %xmm2
 3655 335d C5F9DBD2 		vpand	%xmm2, %xmm0, %xmm2
 232:sepia_filter.c ****                           0.5f +
 3656              		.loc 1 232 52 view .LVU973
 3657 3361 C5385DC4 		vminps	%xmm4, %xmm8, %xmm8
 3658 3365 C57829B5 		vmovaps	%xmm14, -272(%rbp)
 3658      F0FEFFFF 
 3659 336d C57828B5 		vmovaps	-240(%rbp), %xmm14
 3659      10FFFFFF 
 3660 3375 C5C058BD 		vaddps	-272(%rbp), %xmm7, %xmm7
 3660      F0FEFFFF 
 3661 337d C4424998 		vfmadd132ps	%xmm14, %xmm6, %xmm12
 3661      E6
 232:sepia_filter.c ****                           0.5f +
 3662              		.loc 1 232 35 view .LVU974
 3663 3382 C4417A5B 		vcvttps2dq	%xmm8, %xmm8
 3663      C0
 232:sepia_filter.c ****                           0.5f +
 3664              		.loc 1 232 52 view .LVU975
 3665 3387 C5C05DFC 		vminps	%xmm4, %xmm7, %xmm7
 232:sepia_filter.c ****                           0.5f +
 3666              		.loc 1 232 35 view .LVU976
 3667 338b C44179DB 		vpand	%xmm8, %xmm0, %xmm8
 3667      C0
 3668 3390 C4C2692B 		vpackusdw	%xmm8, %xmm2, %xmm2
 3668      D0
 232:sepia_filter.c ****                           0.5f +
 3669              		.loc 1 232 52 view .LVU977
 3670 3395 C4C16058 		vaddps	%xmm12, %xmm3, %xmm3
 3670      DC
 232:sepia_filter.c ****                           0.5f +
 3671              		.loc 1 232 35 view .LVU978
 3672 339a C5FA5BFF 		vcvttps2dq	%xmm7, %xmm7
 3673 339e C5F9DBFF 		vpand	%xmm7, %xmm0, %xmm7
 232:sepia_filter.c ****                           0.5f +
 3674              		.loc 1 232 52 view .LVU979
 3675 33a2 C5E05DDC 		vminps	%xmm4, %xmm3, %xmm3
 232:sepia_filter.c ****                           0.5f +
 3676              		.loc 1 232 35 view .LVU980
 3677 33a6 C5B1DBD2 		vpand	%xmm2, %xmm9, %xmm2
 3678 33aa C4627918 		vbroadcastss	.LC11(%rip), %xmm8
 3678      05000000 
 3678      00
 3679 33b3 C5FA5BDB 		vcvttps2dq	%xmm3, %xmm3
 3680 33b7 C5F9DBDB 		vpand	%xmm3, %xmm0, %xmm3
 3681 33bb C4E2412B 		vpackusdw	%xmm3, %xmm7, %xmm3
 3681      DB
 3682              		.loc 1 241 38 view .LVU981
 3683 33c0 C4E27918 		vbroadcastss	.LC10(%rip), %xmm7
 3683      3D000000 
 3683      00
 232:sepia_filter.c ****                           0.5f +
 3684              		.loc 1 232 35 view .LVU982
 3685 33c9 C5B1DBDB 		vpand	%xmm3, %xmm9, %xmm3
 3686 33cd C5E967D3 		vpackuswb	%xmm3, %xmm2, %xmm2
 238:sepia_filter.c ****                           0.5f +
 3687              		.loc 1 238 13 is_stmt 1 view .LVU983
 3688              		.loc 1 241 38 is_stmt 0 view .LVU984
 3689 33d1 C54059A5 		vmulps	-208(%rbp), %xmm7, %xmm12
 3689      30FFFFFF 
 3690 33d9 C5C0599D 		vmulps	-176(%rbp), %xmm7, %xmm3
 3690      50FFFFFF 
 3691 33e1 C51059EF 		vmulps	%xmm7, %xmm13, %xmm13
 3692 33e5 C5C059BD 		vmulps	-352(%rbp), %xmm7, %xmm7
 3692      A0FEFFFF 
 3693 33ed C46239B8 		vfmadd231ps	-112(%rbp), %xmm8, %xmm12
 3693      6590
 3694 33f3 C4E239B8 		vfmadd231ps	-80(%rbp), %xmm8, %xmm3
 3694      5DB0
 3695 33f9 C46239B8 		vfmadd231ps	-144(%rbp), %xmm8, %xmm13
 3695      AD70FFFF 
 3695      FF
 3696 3402 C4C201B8 		vfmadd231ps	%xmm8, %xmm15, %xmm7
 3696      F8
 3697 3407 C4627918 		vbroadcastss	.LC12(%rip), %xmm8
 3697      05000000 
 3697      00
 3698 3410 C4C24998 		vfmadd132ps	%xmm8, %xmm6, %xmm5
 3698      E8
 3699 3415 C4424998 		vfmadd132ps	%xmm8, %xmm6, %xmm11
 3699      D8
 3700 341a C4424998 		vfmadd132ps	%xmm8, %xmm6, %xmm10
 3700      D0
 3701 341f C4424998 		vfmadd132ps	%xmm14, %xmm6, %xmm8
 3701      C6
 238:sepia_filter.c ****                           0.5f +
 3702              		.loc 1 238 52 view .LVU985
 3703 3424 C51858E5 		vaddps	%xmm5, %xmm12, %xmm12
 3704 3428 C4C16058 		vaddps	%xmm11, %xmm3, %xmm3
 3704      DB
 3705 342d C4411058 		vaddps	%xmm10, %xmm13, %xmm13
 3705      EA
 3706 3432 C4C14058 		vaddps	%xmm8, %xmm7, %xmm7
 3706      F8
 3707 3437 C5E05DDC 		vminps	%xmm4, %xmm3, %xmm3
 3708 343b C5185DE4 		vminps	%xmm4, %xmm12, %xmm12
 3709 343f C5105DEC 		vminps	%xmm4, %xmm13, %xmm13
 3710 3443 C5C05DFC 		vminps	%xmm4, %xmm7, %xmm7
 238:sepia_filter.c ****                           0.5f +
 3711              		.loc 1 238 35 view .LVU986
 3712 3447 C5FA5BDB 		vcvttps2dq	%xmm3, %xmm3
 3713 344b C4417A5B 		vcvttps2dq	%xmm12, %xmm12
 3713      E4
 3714 3450 C5F9DBDB 		vpand	%xmm3, %xmm0, %xmm3
 3715 3454 C44179DB 		vpand	%xmm12, %xmm0, %xmm12
 3715      E4
 3716 3459 C4417A5B 		vcvttps2dq	%xmm13, %xmm13
 3716      ED
 3717 345e C5FA5BFF 		vcvttps2dq	%xmm7, %xmm7
 3718 3462 C44179DB 		vpand	%xmm13, %xmm0, %xmm13
 3718      ED
 3719 3467 C5F9DBC7 		vpand	%xmm7, %xmm0, %xmm0
 3720 346b C462112B 		vpackusdw	%xmm0, %xmm13, %xmm13
 3720      E8
 3721 3470 C4C2612B 		vpackusdw	%xmm12, %xmm3, %xmm3
 3721      DC
 3722 3475 C5B1DBDB 		vpand	%xmm3, %xmm9, %xmm3
 3723 3479 C44131DB 		vpand	%xmm13, %xmm9, %xmm9
 3723      CD
 3724 347e C4C16167 		vpackuswb	%xmm9, %xmm3, %xmm0
 3724      C1
 238:sepia_filter.c ****                           0.5f +
 3725              		.loc 1 238 33 view .LVU987
 3726 3483 C5F96F2D 		vmovdqa	.LC91(%rip), %xmm5
 3726      00000000 
 3727 348b C5F160DA 		vpunpcklbw	%xmm2, %xmm1, %xmm3
 3728 348f C4E27900 		vpshufb	.LC90(%rip), %xmm0, %xmm4
 3728      25000000 
 3728      00
 3729 3498 C4E26100 		vpshufb	.LC89(%rip), %xmm3, %xmm3
 3729      1D000000 
 3729      00
 3730 34a1 C4E3614C 		vpblendvb	%xmm5, %xmm4, %xmm3, %xmm3
 3730      DC50
 3731 34a7 C5FA7F18 		vmovdqu	%xmm3, (%rax)
 3732 34ab C4E27100 		vpshufb	.LC93(%rip), %xmm1, %xmm4
 3732      25000000 
 3732      00
 3733 34b4 C4E26900 		vpshufb	.LC92(%rip), %xmm2, %xmm3
 3733      1D000000 
 3733      00
 3734 34bd C4E27100 		vpshufb	.LC96(%rip), %xmm1, %xmm1
 3734      0D000000 
 3734      00
 3735 34c6 C4E26900 		vpshufb	.LC97(%rip), %xmm2, %xmm2
 3735      15000000 
 3735      00
 3736 34cf C5F1EBCA 		vpor	%xmm2, %xmm1, %xmm1
 3737 34d3 C5F96F2D 		vmovdqa	.LC95(%rip), %xmm5
 3737      00000000 
 3738 34db C5F96F15 		vmovdqa	.LC99(%rip), %xmm2
 3738      00000000 
 3739 34e3 C5E1EBDC 		vpor	%xmm4, %xmm3, %xmm3
 3740 34e7 C4E27900 		vpshufb	.LC94(%rip), %xmm0, %xmm4
 3740      25000000 
 3740      00
 3741 34f0 C4E27900 		vpshufb	.LC98(%rip), %xmm0, %xmm0
 3741      05000000 
 3741      00
 3742 34f9 C4E3614C 		vpblendvb	%xmm5, %xmm4, %xmm3, %xmm3
 3742      DC50
 3743 34ff C4E3794C 		vpblendvb	%xmm2, %xmm1, %xmm0, %xmm0
 3743      C120
 3744 3505 C5FA7F58 		vmovdqu	%xmm3, 16(%rax)
 3744      10
 3745 350a C5FA7F40 		vmovdqu	%xmm0, 32(%rax)
 3745      20
 222:sepia_filter.c ****         {
 3746              		.loc 1 222 44 is_stmt 1 view .LVU988
 222:sepia_filter.c ****         {
 3747              		.loc 1 222 9 view .LVU989
 3748 350f 89F0     		movl	%esi, %eax
 3749 3511 83E0F0   		andl	$-16, %eax
 3750 3514 01C7     		addl	%eax, %edi
 3751 3516 83E60F   		andl	$15, %esi
 3752 3519 0F843901 		je	.L73
 3752      0000
 3753              	.L72:
 222:sepia_filter.c ****         {
 3754              		.loc 1 222 9 is_stmt 0 view .LVU990
 3755 351f 8D347F   		leal	(%rdi,%rdi,2), %esi
 3756 3522 4863F6   		movslq	%esi, %rsi
 3757 3525 C57A101D 		vmovss	.LC1(%rip), %xmm11
 3757      00000000 
 3758 352d C57A1015 		vmovss	.LC2(%rip), %xmm10
 3758      00000000 
 3759 3535 C57A100D 		vmovss	.LC3(%rip), %xmm9
 3759      00000000 
 3760 353d C5FA1015 		vmovss	.LC106(%rip), %xmm2
 3760      00000000 
 3761 3545 C5FA100D 		vmovss	.LC4(%rip), %xmm1
 3761      00000000 
 3762 354d C57A1005 		vmovss	.LC7(%rip), %xmm8
 3762      00000000 
 3763 3555 C5FA103D 		vmovss	.LC8(%rip), %xmm7
 3763      00000000 
 3764 355d C5FA1035 		vmovss	.LC9(%rip), %xmm6
 3764      00000000 
 3765 3565 C5FA102D 		vmovss	.LC10(%rip), %xmm5
 3765      00000000 
 3766 356d C5FA1025 		vmovss	.LC11(%rip), %xmm4
 3766      00000000 
 3767 3575 C5FA101D 		vmovss	.LC12(%rip), %xmm3
 3767      00000000 
 3768 357d 498D4435 		leaq	0(%r13,%rsi), %rax
 3768      00
 3769 3582 4C01F6   		addq	%r14, %rsi
 3770              		.p2align 4,,10
 3771 3585 0F1F00   		.p2align 3
 3772              	.L74:
 3773              	.LVL77:
 226:sepia_filter.c ****                           0.5f +
 3774              		.loc 1 226 13 is_stmt 1 view .LVU991
 228:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 3775              		.loc 1 228 48 is_stmt 0 view .LVU992
 3776 3588 440FB610 		movzbl	(%rax), %r10d
 228:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 3777              		.loc 1 228 38 view .LVU993
 3778 358c C4410857 		vxorps	%xmm14, %xmm14, %xmm14
 3778      F6
 3779 3591 C4C10A2A 		vcvtsi2ssl	%r10d, %xmm14, %xmm0
 3779      C2
 229:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 3780              		.loc 1 229 48 view .LVU994
 3781 3596 440FB650 		movzbl	1(%rax), %r10d
 3781      01
 222:sepia_filter.c ****         {
 3782              		.loc 1 222 44 view .LVU995
 3783 359b FFC7     		incl	%edi
 3784              	.LVL78:
 229:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 3785              		.loc 1 229 38 view .LVU996
 3786 359d C4410A2A 		vcvtsi2ssl	%r10d, %xmm14, %xmm12
 3786      E2
 230:sepia_filter.c ****             /* G */
 3787              		.loc 1 230 48 view .LVU997
 3788 35a2 440FB650 		movzbl	2(%rax), %r10d
 3788      02
 222:sepia_filter.c ****         {
 3789              		.loc 1 222 9 view .LVU998
 3790 35a7 4883C603 		addq	$3, %rsi
 3791 35ab 4883C003 		addq	$3, %rax
 229:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 3792              		.loc 1 229 38 view .LVU999
 3793 35af C4411A59 		vmulss	%xmm11, %xmm12, %xmm12
 3793      E3
 3794 35b4 C4C21999 		vfmadd132ss	%xmm10, %xmm12, %xmm0
 3794      C2
 230:sepia_filter.c ****             /* G */
 3795              		.loc 1 230 38 view .LVU1000
 3796 35b9 C4410A2A 		vcvtsi2ssl	%r10d, %xmm14, %xmm12
 3796      E2
 3797 35be C4426999 		vfmadd132ss	%xmm9, %xmm2, %xmm12
 3797      E1
 226:sepia_filter.c ****                           0.5f +
 3798              		.loc 1 226 52 view .LVU1001
 3799 35c3 C4C17A58 		vaddss	%xmm12, %xmm0, %xmm0
 3799      C4
 3800 35c8 C5FA5DC1 		vminss	%xmm1, %xmm0, %xmm0
 226:sepia_filter.c ****                           0.5f +
 3801              		.loc 1 226 35 view .LVU1002
 3802 35cc C57A2CD0 		vcvttss2sil	%xmm0, %r10d
 3803 35d0 448856FD 		movb	%r10b, -3(%rsi)
 232:sepia_filter.c ****                           0.5f +
 3804              		.loc 1 232 13 is_stmt 1 view .LVU1003
 234:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 3805              		.loc 1 234 48 is_stmt 0 view .LVU1004
 3806 35d4 440FB650 		movzbl	-3(%rax), %r10d
 3806      FD
 234:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 3807              		.loc 1 234 38 view .LVU1005
 3808 35d9 C4C10A2A 		vcvtsi2ssl	%r10d, %xmm14, %xmm0
 3808      C2
 235:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 3809              		.loc 1 235 48 view .LVU1006
 3810 35de 440FB650 		movzbl	-2(%rax), %r10d
 3810      FE
 235:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 3811              		.loc 1 235 38 view .LVU1007
 3812 35e3 C4410A2A 		vcvtsi2ssl	%r10d, %xmm14, %xmm12
 3812      E2
 236:sepia_filter.c ****             /* B */
 3813              		.loc 1 236 48 view .LVU1008
 3814 35e8 440FB650 		movzbl	-1(%rax), %r10d
 3814      FF
 235:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 3815              		.loc 1 235 38 view .LVU1009
 3816 35ed C4411A59 		vmulss	%xmm8, %xmm12, %xmm12
 3816      E0
 3817 35f2 C4E21999 		vfmadd132ss	%xmm7, %xmm12, %xmm0
 3817      C7
 236:sepia_filter.c ****             /* B */
 3818              		.loc 1 236 38 view .LVU1010
 3819 35f7 C4410A2A 		vcvtsi2ssl	%r10d, %xmm14, %xmm12
 3819      E2
 3820 35fc C4626999 		vfmadd132ss	%xmm6, %xmm2, %xmm12
 3820      E6
 232:sepia_filter.c ****                           0.5f +
 3821              		.loc 1 232 52 view .LVU1011
 3822 3601 C4C17A58 		vaddss	%xmm12, %xmm0, %xmm0
 3822      C4
 3823 3606 C5FA5DC1 		vminss	%xmm1, %xmm0, %xmm0
 232:sepia_filter.c ****                           0.5f +
 3824              		.loc 1 232 35 view .LVU1012
 3825 360a C57A2CD0 		vcvttss2sil	%xmm0, %r10d
 3826 360e 448856FE 		movb	%r10b, -2(%rsi)
 238:sepia_filter.c ****                           0.5f +
 3827              		.loc 1 238 13 is_stmt 1 view .LVU1013
 240:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 3828              		.loc 1 240 48 is_stmt 0 view .LVU1014
 3829 3612 440FB650 		movzbl	-3(%rax), %r10d
 3829      FD
 240:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 3830              		.loc 1 240 38 view .LVU1015
 3831 3617 C4C10A2A 		vcvtsi2ssl	%r10d, %xmm14, %xmm0
 3831      C2
 3832              		.loc 1 241 48 view .LVU1016
 3833 361c 440FB650 		movzbl	-2(%rax), %r10d
 3833      FE
 3834              		.loc 1 241 38 view .LVU1017
 3835 3621 C4410A2A 		vcvtsi2ssl	%r10d, %xmm14, %xmm12
 3835      E2
 242:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 3836              		.loc 1 242 48 view .LVU1018
 3837 3626 440FB650 		movzbl	-1(%rax), %r10d
 3837      FF
 241:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 3838              		.loc 1 241 38 view .LVU1019
 3839 362b C51A59E5 		vmulss	%xmm5, %xmm12, %xmm12
 3840 362f C4E21999 		vfmadd132ss	%xmm4, %xmm12, %xmm0
 3840      C4
 3841              		.loc 1 242 38 view .LVU1020
 3842 3634 C4410A2A 		vcvtsi2ssl	%r10d, %xmm14, %xmm12
 3842      E2
 3843 3639 C4626999 		vfmadd132ss	%xmm3, %xmm2, %xmm12
 3843      E3
 238:sepia_filter.c ****                           0.5f +
 3844              		.loc 1 238 52 view .LVU1021
 3845 363e C4C17A58 		vaddss	%xmm12, %xmm0, %xmm0
 3845      C4
 3846 3643 C5FA5DC1 		vminss	%xmm1, %xmm0, %xmm0
 238:sepia_filter.c ****                           0.5f +
 3847              		.loc 1 238 35 view .LVU1022
 3848 3647 C57A2CD0 		vcvttss2sil	%xmm0, %r10d
 3849 364b 448856FF 		movb	%r10b, -1(%rsi)
 222:sepia_filter.c ****         {
 3850              		.loc 1 222 44 is_stmt 1 view .LVU1023
 3851              	.LVL79:
 222:sepia_filter.c ****         {
 3852              		.loc 1 222 9 view .LVU1024
 3853 364f 4139FF   		cmpl	%edi, %r15d
 3854 3652 0F8F30FF 		jg	.L74
 3854      FFFF
 3855              	.LVL80:
 3856              	.L73:
 222:sepia_filter.c ****         {
 3857              		.loc 1 222 9 is_stmt 0 view .LVU1025
 3858              	.LBE27:
 243:sepia_filter.c ****         }
 244:sepia_filter.c ****         dummy(image_in, image_out);
 3859              		.loc 1 244 9 is_stmt 1 view .LVU1026
 3860 3658 488BB598 		movq	-360(%rbp), %rsi
 3860      FEFFFF
 3861 365f 488BBD90 		movq	-368(%rbp), %rdi
 3861      FEFFFF
 3862 3666 E8000000 		call	dummy
 3862      00
 3863              	.LVL81:
 219:sepia_filter.c ****     {
 3864              		.loc 1 219 36 view .LVU1027
 219:sepia_filter.c ****     {
 3865              		.loc 1 219 25 view .LVU1028
 3866 366b FFCB     		decl	%ebx
 3867 366d 0F851DF3 		jne	.L77
 3867      FFFF
 3868              	.L76:
 219:sepia_filter.c ****     {
 3869              		.loc 1 219 25 is_stmt 0 view .LVU1029
 3870              	.LBE30:
 245:sepia_filter.c ****     }
 246:sepia_filter.c ****     end_t = get_wall_time();
 3871              		.loc 1 246 5 is_stmt 1 view .LVU1030
 3872              		.loc 1 246 13 is_stmt 0 view .LVU1031
 3873 3673 31C0     		xorl	%eax, %eax
 3874 3675 E8000000 		call	get_wall_time
 3874      00
 3875              	.LVL82:
 247:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_cast1");
 3876              		.loc 1 247 5 is_stmt 1 view .LVU1032
 3877 367a C5FB5C85 		vsubsd	-384(%rbp), %xmm0, %xmm0
 3877      80FEFFFF 
 3878              	.LVL83:
 248:sepia_filter.c **** }
 3879              		.loc 1 248 1 is_stmt 0 view .LVU1033
 3880 3682 4881C468 		addq	$360, %rsp
 3880      010000
 3881 3689 5B       		popq	%rbx
 3882 368a 415C     		popq	%r12
 3883 368c 415D     		popq	%r13
 3884              		.cfi_remember_state
 3885              		.cfi_def_cfa 13, 0
 3886              	.LVL84:
 3887              		.loc 1 248 1 view .LVU1034
 3888 368e 415E     		popq	%r14
 3889              	.LVL85:
 247:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_cast1");
 3890              		.loc 1 247 5 view .LVU1035
 3891 3690 4489FF   		movl	%r15d, %edi
 3892              		.loc 1 248 1 view .LVU1036
 3893 3693 415F     		popq	%r15
 3894 3695 5D       		popq	%rbp
 3895              	.LVL86:
 3896              		.loc 1 248 1 view .LVU1037
 3897 3696 498D65F0 		leaq	-16(%r13), %rsp
 3898              		.cfi_def_cfa 7, 16
 247:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_cast1");
 3899              		.loc 1 247 5 view .LVU1038
 3900 369a BE000000 		movl	$.LC108, %esi
 3900      00
 3901              		.loc 1 248 1 view .LVU1039
 3902 369f 415D     		popq	%r13
 3903              		.cfi_def_cfa_offset 8
 247:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_cast1");
 3904              		.loc 1 247 5 view .LVU1040
 3905 36a1 E9000000 		jmp	results
 3905      00
 3906              	.LVL87:
 3907              	.L89:
 3908              		.cfi_restore_state
 3909              	.LBB31:
 244:sepia_filter.c ****     }
 3910              		.loc 1 244 9 is_stmt 1 view .LVU1041
 3911 36a6 488BB598 		movq	-360(%rbp), %rsi
 3911      FEFFFF
 3912 36ad 488BBD90 		movq	-368(%rbp), %rdi
 3912      FEFFFF
 3913 36b4 E8000000 		call	dummy
 3913      00
 3914              	.LVL88:
 219:sepia_filter.c ****     {
 3915              		.loc 1 219 36 view .LVU1042
 219:sepia_filter.c ****     {
 3916              		.loc 1 219 25 view .LVU1043
 3917 36b9 FFCB     		decl	%ebx
 3918 36bb 0F85C3F2 		jne	.L68
 3918      FFFF
 3919 36c1 EBB0     		jmp	.L76
 3920              	.LVL89:
 3921              	.L79:
 3922              	.LBB28:
 222:sepia_filter.c ****         {
 3923              		.loc 1 222 18 is_stmt 0 view .LVU1044
 3924 36c3 31C0     		xorl	%eax, %eax
 3925 36c5 31FF     		xorl	%edi, %edi
 3926 36c7 E978F9FF 		jmp	.L69
 3926      FF
 3927              	.L71:
 222:sepia_filter.c ****         {
 3928              		.loc 1 222 18 view .LVU1045
 3929              	.LBE28:
 244:sepia_filter.c ****     }
 3930              		.loc 1 244 9 is_stmt 1 view .LVU1046
 3931 36cc 488BB598 		movq	-360(%rbp), %rsi
 3931      FEFFFF
 3932 36d3 488BBD90 		movq	-368(%rbp), %rdi
 3932      FEFFFF
 3933 36da C5F877   		vzeroupper
 3934              	.LVL90:
 3935 36dd E8000000 		call	dummy
 3935      00
 3936              	.LVL91:
 219:sepia_filter.c ****     {
 3937              		.loc 1 219 36 view .LVU1047
 219:sepia_filter.c ****     {
 3938              		.loc 1 219 25 view .LVU1048
 3939 36e2 FFCB     		decl	%ebx
 3940 36e4 0F85A6F2 		jne	.L77
 3940      FFFF
 3941 36ea EB87     		jmp	.L76
 3942              	.LVL92:
 3943              	.L92:
 219:sepia_filter.c ****     {
 3944              		.loc 1 219 25 is_stmt 0 view .LVU1049
 3945              	.LBE31:
 207:sepia_filter.c ****         exit(-1);
 3946              		.loc 1 207 9 is_stmt 1 view .LVU1050
 3947 36ec BF000000 		movl	$.LC0, %edi
 3947      00
 3948              	.LVL93:
 207:sepia_filter.c ****         exit(-1);
 3949              		.loc 1 207 9 is_stmt 0 view .LVU1051
 3950 36f1 E8000000 		call	puts
 3950      00
 3951              	.LVL94:
 208:sepia_filter.c ****     }
 3952              		.loc 1 208 9 is_stmt 1 view .LVU1052
 3953 36f6 83CFFF   		orl	$-1, %edi
 3954 36f9 E8000000 		call	exit
 3954      00
 3955              	.LVL95:
 3956              		.cfi_endproc
 3957              	.LFE21:
 3959              		.section	.rodata.str1.1
 3960              	.LC109:
 3961 0038 73657069 		.string	"sepiaf_cast2"
 3961      61665F63 
 3961      61737432 
 3961      00
 3962              		.text
 3963 36fe 6690     		.p2align 4
 3964              		.globl	sepia_filter_cast2
 3966              	sepia_filter_cast2:
 3967              	.LVL96:
 3968              	.LFB22:
 249:sepia_filter.c **** //----------------------------------------------------------------------------
 250:sepia_filter.c **** 
 251:sepia_filter.c **** /* cambios respecto sepia_filter_cast1(): no suma 0.5f a los valores RGB calculados */
 252:sepia_filter.c **** void
 253:sepia_filter.c **** sepia_filter_cast2(image_t * restrict image_in, image_t * restrict image_out)
 254:sepia_filter.c **** {
 3969              		.loc 1 254 1 view -0
 3970              		.cfi_startproc
 255:sepia_filter.c ****     double start_t, end_t;
 3971              		.loc 1 255 5 view .LVU1054
 256:sepia_filter.c ****     const int height = image_in->height;
 3972              		.loc 1 256 5 view .LVU1055
 254:sepia_filter.c ****     double start_t, end_t;
 3973              		.loc 1 254 1 is_stmt 0 view .LVU1056
 3974 3700 4155     		pushq	%r13
 3975              		.cfi_def_cfa_offset 16
 3976              		.cfi_offset 13, -16
 3977 3702 4C8D6C24 		leaq	16(%rsp), %r13
 3977      10
 3978              		.cfi_def_cfa 13, 0
 3979 3707 4883E4E0 		andq	$-32, %rsp
 3980 370b 41FF75F8 		pushq	-8(%r13)
 3981 370f 55       		pushq	%rbp
 3982 3710 4889E5   		movq	%rsp, %rbp
 3983              		.cfi_escape 0x10,0x6,0x2,0x76,0
 3984 3713 4157     		pushq	%r15
 3985 3715 4156     		pushq	%r14
 3986 3717 4155     		pushq	%r13
 3987              		.cfi_escape 0xf,0x3,0x76,0x68,0x6
 3988              		.cfi_escape 0x10,0xf,0x2,0x76,0x78
 3989              		.cfi_escape 0x10,0xe,0x2,0x76,0x70
 3990 3719 4154     		pushq	%r12
 3991 371b 53       		pushq	%rbx
 3992 371c 4881ECC8 		subq	$200, %rsp
 3992      000000
 3993              		.cfi_escape 0x10,0xc,0x2,0x76,0x60
 3994              		.cfi_escape 0x10,0x3,0x2,0x76,0x58
 257:sepia_filter.c ****     const int width =  image_in->width;
 3995              		.loc 1 257 15 view .LVU1057
 3996 3723 C5FA7E47 		vmovq	8(%rdi), %xmm0
 3996      08
 258:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 259:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
 260:sepia_filter.c **** 
 261:sepia_filter.c ****     if (image_in->bytes_per_pixel != 3)
 3997              		.loc 1 261 8 view .LVU1058
 3998 3728 837F1003 		cmpl	$3, 16(%rdi)
 254:sepia_filter.c ****     double start_t, end_t;
 3999              		.loc 1 254 1 view .LVU1059
 4000 372c 4889BD30 		movq	%rdi, -208(%rbp)
 4000      FFFFFF
 4001 3733 4889B538 		movq	%rsi, -200(%rbp)
 4001      FFFFFF
 258:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 4002              		.loc 1 258 30 view .LVU1060
 4003 373a 4C8B2F   		movq	(%rdi), %r13
 259:sepia_filter.c **** 
 4004              		.loc 1 259 30 view .LVU1061
 4005 373d 4C8B36   		movq	(%rsi), %r14
 4006 3740 C4C37916 		vpextrd	$1, %xmm0, %r15d
 4006      C701
 4007              	.LVL97:
 257:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 4008              		.loc 1 257 5 is_stmt 1 view .LVU1062
 258:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
 4009              		.loc 1 258 5 view .LVU1063
 259:sepia_filter.c **** 
 4010              		.loc 1 259 5 view .LVU1064
 4011              		.loc 1 261 5 view .LVU1065
 4012              		.loc 1 261 8 is_stmt 0 view .LVU1066
 4013 3746 0F85480C 		jne	.L119
 4013      0000
 4014 374c C4C1797E 		vmovd	%xmm0, %r12d
 4014      C4
 262:sepia_filter.c ****     {
 263:sepia_filter.c ****         printf("ERROR: input image has to be RGB\n");
 264:sepia_filter.c ****         exit(-1);
 265:sepia_filter.c ****     }
 266:sepia_filter.c ****     
 267:sepia_filter.c ****     /* fill struct fields */
 268:sepia_filter.c ****     image_out->width  = width;
 4015              		.loc 1 268 5 is_stmt 1 view .LVU1067
 269:sepia_filter.c ****     image_out->height = height;
 4016              		.loc 1 269 5 view .LVU1068
 270:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
 4017              		.loc 1 270 32 is_stmt 0 view .LVU1069
 4018 3751 48B90300 		movabsq	$8589934595, %rcx
 4018      00000200 
 4018      0000
 4019              	.LBB32:
 4020              	.LBB33:
 271:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 272:sepia_filter.c **** 
 273:sepia_filter.c ****     start_t = get_wall_time();
 274:sepia_filter.c **** 
 275:sepia_filter.c ****     for (int it = 0; it < NITER; it++)
 276:sepia_filter.c ****     {
 277:sepia_filter.c ****         #pragma GCC ivdep
 278:sepia_filter.c ****         for (int i = 0; i < height*width; i++)
 4021              		.loc 1 278 35 view .LVU1070
 4022 375b 450FAFFC 		imull	%r12d, %r15d
 4023              	.LBE33:
 4024              	.LBE32:
 270:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
 4025              		.loc 1 270 32 view .LVU1071
 4026 375f 48894E10 		movq	%rcx, 16(%rsi)
 273:sepia_filter.c **** 
 4027              		.loc 1 273 15 view .LVU1072
 4028 3763 31C0     		xorl	%eax, %eax
 268:sepia_filter.c ****     image_out->height = height;
 4029              		.loc 1 268 23 view .LVU1073
 4030 3765 C5F9D646 		vmovq	%xmm0, 8(%rsi)
 4030      08
 270:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 4031              		.loc 1 270 5 is_stmt 1 view .LVU1074
 271:sepia_filter.c **** 
 4032              		.loc 1 271 5 view .LVU1075
 273:sepia_filter.c **** 
 4033              		.loc 1 273 5 view .LVU1076
 273:sepia_filter.c **** 
 4034              		.loc 1 273 15 is_stmt 0 view .LVU1077
 4035 376a E8000000 		call	get_wall_time
 4035      00
 4036              	.LVL98:
 273:sepia_filter.c **** 
 4037              		.loc 1 273 15 view .LVU1078
 4038 376f 418D47FF 		leal	-1(%r15), %eax
 4039 3773 89852CFF 		movl	%eax, -212(%rbp)
 4039      FFFF
 4040 3779 4489F8   		movl	%r15d, %eax
 4041 377c C1E805   		shrl	$5, %eax
 4042 377f 488D0C40 		leaq	(%rax,%rax,2), %rcx
 4043 3783 4489F8   		movl	%r15d, %eax
 4044 3786 83E0E0   		andl	$-32, %eax
 4045 3789 898528FF 		movl	%eax, -216(%rbp)
 4045      FFFF
 4046 378f 48C1E105 		salq	$5, %rcx
 4047 3793 C5FB1185 		vmovsd	%xmm0, -224(%rbp)
 4047      20FFFFFF 
 4048              	.LVL99:
 275:sepia_filter.c ****     {
 4049              		.loc 1 275 5 is_stmt 1 view .LVU1079
 4050              	.LBB37:
 275:sepia_filter.c ****     {
 4051              		.loc 1 275 10 view .LVU1080
 275:sepia_filter.c ****     {
 4052              		.loc 1 275 25 view .LVU1081
 4053 379b 4E8D2429 		leaq	(%rcx,%r13), %r12
 4054              	.LBB34:
 4055              		.loc 1 278 35 is_stmt 0 view .LVU1082
 4056 379f BB0A0000 		movl	$10, %ebx
 4056      00
 4057              	.LVL100:
 4058              	.L95:
 4059              		.loc 1 278 9 is_stmt 1 view .LVU1083
 4060 37a4 4585FF   		testl	%r15d, %r15d
 4061 37a7 0F8EA10B 		jle	.L116
 4061      0000
 4062              	.LVL101:
 4063 37ad 0F1F00   		.p2align 4,,10
 4064              		.p2align 3
 4065              	.L104:
 4066              		.loc 1 278 9 is_stmt 0 view .LVU1084
 4067 37b0 83BD2CFF 		cmpl	$30, -212(%rbp)
 4067      FFFF1E
 4068 37b7 0F86AE0B 		jbe	.L106
 4068      0000
 279:sepia_filter.c ****         {
 280:sepia_filter.c ****             /* R */
 281:sepia_filter.c ****             pixels_out[3*i + 0] = (unsigned char) (fminf(MAXPIXV,
 4069              		.loc 1 281 35 view .LVU1085
 4070 37bd BFFFFF00 		movl	$65535, %edi
 4070      00
 4071 37c2 C5796EDF 		vmovd	%edi, %xmm11
 4072 37c6 BFFF0000 		movl	$255, %edi
 4072      00
 4073 37cb C5F96EFF 		vmovd	%edi, %xmm7
 4074 37cf C4E27D79 		vpbroadcastw	%xmm7, %ymm7
 4074      FF
 4075 37d4 C4627D18 		vbroadcastss	.LC4(%rip), %ymm12
 4075      25000000 
 4075      00
 4076 37dd 4C89F6   		movq	%r14, %rsi
 4077              	.LBE34:
 4078              	.LBE37:
 254:sepia_filter.c ****     double start_t, end_t;
 4079              		.loc 1 254 1 view .LVU1086
 4080 37e0 4C89E8   		movq	%r13, %rax
 4081              	.LBB38:
 4082              	.LBB35:
 4083              		.loc 1 281 35 view .LVU1087
 4084 37e3 C4427D58 		vpbroadcastd	%xmm11, %ymm11
 4084      DB
 4085 37e8 C5FD7F7D 		vmovdqa	%ymm7, -80(%rbp)
 4085      B0
 4086 37ed 0F1F00   		.p2align 4,,10
 4087              		.p2align 3
 4088              	.L97:
 4089              		.loc 1 281 13 is_stmt 1 discriminator 3 view .LVU1088
 282:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4090              		.loc 1 282 48 is_stmt 0 discriminator 3 view .LVU1089
 4091 37f0 C5FE6F00 		vmovdqu	(%rax), %ymm0
 4092 37f4 C5FE6F58 		vmovdqu	32(%rax), %ymm3
 4092      20
 4093 37f9 C4E27D00 		vpshufb	.LC15(%rip), %ymm0, %ymm4
 4093      25000000 
 4093      00
 4094 3802 C5FE6F48 		vmovdqu	64(%rax), %ymm1
 4094      40
 4095 3807 C4E27D00 		vpshufb	.LC16(%rip), %ymm0, %ymm2
 4095      15000000 
 4095      00
 4096 3810 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 4096      E44E
 4097 3816 C4E26500 		vpshufb	.LC17(%rip), %ymm3, %ymm5
 4097      2D000000 
 4097      00
 4098 381f C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 4099 3823 C5EDEBD5 		vpor	%ymm5, %ymm2, %ymm2
 4100 3827 C4E27500 		vpshufb	.LC18(%rip), %ymm1, %ymm5
 4100      2D000000 
 4100      00
 4101 3830 C4E27500 		vpshufb	.LC20(%rip), %ymm1, %ymm4
 4101      25000000 
 4101      00
 4102 3839 C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 4102      ED4E
 4103 383f C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 4104 3843 C4E26D00 		vpshufb	.LC19(%rip), %ymm2, %ymm2
 4104      15000000 
 4104      00
 4105 384c C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 4106 3850 C4E27D00 		vpshufb	.LC21(%rip), %ymm0, %ymm4
 4106      25000000 
 4106      00
 4107 3859 C4E27D00 		vpshufb	.LC22(%rip), %ymm0, %ymm6
 4107      35000000 
 4107      00
 4108 3862 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 4108      E44E
 4109 3868 C4E26500 		vpshufb	.LC23(%rip), %ymm3, %ymm5
 4109      2D000000 
 4109      00
 4110 3871 C5CDEBF4 		vpor	%ymm4, %ymm6, %ymm6
 4111 3875 C5CDEBF5 		vpor	%ymm5, %ymm6, %ymm6
 4112 3879 C4E27500 		vpshufb	.LC24(%rip), %ymm1, %ymm5
 4112      2D000000 
 4112      00
 4113 3882 C4E27500 		vpshufb	.LC26(%rip), %ymm1, %ymm4
 4113      25000000 
 4113      00
 4114 388b C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 4114      ED4E
 4115 3891 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 4116 3895 C4E24D00 		vpshufb	.LC25(%rip), %ymm6, %ymm6
 4116      35000000 
 4116      00
 4117 389e C5CDEBF4 		vpor	%ymm4, %ymm6, %ymm6
 4118 38a2 C4E27D00 		vpshufb	.LC27(%rip), %ymm0, %ymm4
 4118      25000000 
 4118      00
 4119 38ab C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 4119      E44E
 4120 38b1 C4E27D00 		vpshufb	.LC28(%rip), %ymm0, %ymm0
 4120      05000000 
 4120      00
 4121 38ba C4E26500 		vpshufb	.LC29(%rip), %ymm3, %ymm3
 4121      1D000000 
 4121      00
 4122 38c3 C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 4123 38c7 C5FDEBC3 		vpor	%ymm3, %ymm0, %ymm0
 4124 38cb C4E27500 		vpshufb	.LC30(%rip), %ymm1, %ymm3
 4124      1D000000 
 4124      00
 4125 38d4 C4E3FD00 		vpermq	$78, %ymm3, %ymm3
 4125      DB4E
 4126 38da C4E27500 		vpshufb	.LC31(%rip), %ymm1, %ymm1
 4126      0D000000 
 4126      00
 4127 38e3 C5F5EBCB 		vpor	%ymm3, %ymm1, %ymm1
 4128 38e7 C4E27D00 		vpshufb	.LC25(%rip), %ymm0, %ymm0
 4128      05000000 
 4128      00
 4129 38f0 C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 283:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4130              		.loc 1 283 48 discriminator 3 view .LVU1090
 4131 38f4 C4627D30 		vpmovzxbw	%xmm6, %ymm9
 4131      CE
 4132 38f9 C4E37D39 		vextracti128	$0x1, %ymm6, %xmm6
 4132      F601
 284:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 4133              		.loc 1 284 48 discriminator 3 view .LVU1091
 4134 38ff C4E27D30 		vpmovzxbw	%xmm0, %ymm7
 4134      F8
 283:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4135              		.loc 1 283 48 discriminator 3 view .LVU1092
 4136 3904 C4E27D30 		vpmovzxbw	%xmm6, %ymm6
 4136      F6
 4137              		.loc 1 284 48 discriminator 3 view .LVU1093
 4138 3909 C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 4138      C001
 4139 390f C4E27D30 		vpmovzxbw	%xmm0, %ymm0
 4139      C0
 283:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4140              		.loc 1 283 48 discriminator 3 view .LVU1094
 4141 3914 C4427D33 		vpmovzxwd	%xmm9, %ymm10
 4141      D1
 4142 3919 C4E27D33 		vpmovzxwd	%xmm6, %ymm5
 4142      EE
 283:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4143              		.loc 1 283 38 discriminator 3 view .LVU1095
 4144 391e C4417C5B 		vcvtdq2ps	%ymm10, %ymm10
 4144      D2
 4145 3923 C5FC5BED 		vcvtdq2ps	%ymm5, %ymm5
 4146              		.loc 1 284 48 discriminator 3 view .LVU1096
 4147 3927 C4627D33 		vpmovzxwd	%xmm0, %ymm15
 4147      F8
 283:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4148              		.loc 1 283 38 discriminator 3 view .LVU1097
 4149 392c C5545905 		vmulps	.LC32(%rip), %ymm5, %ymm8
 4149      00000000 
 4150              		.loc 1 284 48 discriminator 3 view .LVU1098
 4151 3934 C4E37D39 		vextracti128	$0x1, %ymm0, %xmm4
 4151      C401
 283:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4152              		.loc 1 283 38 discriminator 3 view .LVU1099
 4153 393a C5AC5905 		vmulps	.LC32(%rip), %ymm10, %ymm0
 4153      00000000 
 282:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4154              		.loc 1 282 48 discriminator 3 view .LVU1100
 4155 3942 C4E27D30 		vpmovzxbw	%xmm2, %ymm1
 4155      CA
 4156 3947 C4E27D33 		vpmovzxwd	%xmm1, %ymm3
 4156      D9
 4157 394c C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 4157      D201
 4158 3952 C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 4158      C901
 4159 3958 C4E27D30 		vpmovzxbw	%xmm2, %ymm2
 4159      D2
 4160 395d C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 4160      C9
 283:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4161              		.loc 1 283 48 discriminator 3 view .LVU1101
 4162 3962 C4437D39 		vextracti128	$0x1, %ymm9, %xmm9
 4162      C901
 4163 3968 C4E37D39 		vextracti128	$0x1, %ymm6, %xmm6
 4163      F601
 282:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4164              		.loc 1 282 38 discriminator 3 view .LVU1102
 4165 396e C57C5BF1 		vcvtdq2ps	%ymm1, %ymm14
 283:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4166              		.loc 1 283 48 discriminator 3 view .LVU1103
 4167 3972 C4427D33 		vpmovzxwd	%xmm9, %ymm9
 4167      C9
 282:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4168              		.loc 1 282 48 discriminator 3 view .LVU1104
 4169 3977 C4E27D33 		vpmovzxwd	%xmm2, %ymm1
 4169      CA
 283:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4170              		.loc 1 283 48 discriminator 3 view .LVU1105
 4171 397c C4E27D33 		vpmovzxwd	%xmm6, %ymm6
 4171      F6
 282:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4172              		.loc 1 282 38 discriminator 3 view .LVU1106
 4173 3981 C57C5BE9 		vcvtdq2ps	%ymm1, %ymm13
 4174 3985 C5FC5BDB 		vcvtdq2ps	%ymm3, %ymm3
 4175 3989 C46215B8 		vfmadd231ps	.LC33(%rip), %ymm13, %ymm8
 4175      05000000 
 4175      00
 283:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4176              		.loc 1 283 38 discriminator 3 view .LVU1107
 4177 3992 C4417C5B 		vcvtdq2ps	%ymm9, %ymm9
 4177      C9
 4178 3997 C5FC5BF6 		vcvtdq2ps	%ymm6, %ymm6
 4179 399b C4E265B8 		vfmadd231ps	.LC33(%rip), %ymm3, %ymm0
 4179      05000000 
 4179      00
 4180 39a4 C5FC295D 		vmovaps	%ymm3, -112(%rbp)
 4180      90
 4181 39a9 C57C29AD 		vmovaps	%ymm13, -176(%rbp)
 4181      50FFFFFF 
 4182 39b1 C5B4591D 		vmulps	.LC32(%rip), %ymm9, %ymm3
 4182      00000000 
 4183 39b9 C54C592D 		vmulps	.LC32(%rip), %ymm6, %ymm13
 4183      00000000 
 282:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4184              		.loc 1 282 48 discriminator 3 view .LVU1108
 4185 39c1 C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 4185      D201
 4186 39c7 C4E27D33 		vpmovzxwd	%xmm2, %ymm2
 4186      D2
 282:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4187              		.loc 1 282 38 discriminator 3 view .LVU1109
 4188 39cc C5FC5BD2 		vcvtdq2ps	%ymm2, %ymm2
 4189 39d0 C4E20DB8 		vfmadd231ps	.LC33(%rip), %ymm14, %ymm3
 4189      1D000000 
 4189      00
 4190 39d9 C4626DB8 		vfmadd231ps	.LC33(%rip), %ymm2, %ymm13
 4190      2D000000 
 4190      00
 4191              		.loc 1 284 48 discriminator 3 view .LVU1110
 4192 39e2 C4E27D33 		vpmovzxwd	%xmm7, %ymm1
 4192      CF
 4193 39e7 C4E37D39 		vextracti128	$0x1, %ymm7, %xmm7
 4193      FF01
 4194 39ed C4E27D33 		vpmovzxwd	%xmm7, %ymm7
 4194      FF
 4195 39f2 C4E27D33 		vpmovzxwd	%xmm4, %ymm4
 4195      E4
 4196              		.loc 1 284 38 discriminator 3 view .LVU1111
 4197 39f7 C5FC5BC9 		vcvtdq2ps	%ymm1, %ymm1
 4198 39fb C5FC5BFF 		vcvtdq2ps	%ymm7, %ymm7
 4199 39ff C4417C5B 		vcvtdq2ps	%ymm15, %ymm15
 4199      FF
 4200 3a04 C5FC5BE4 		vcvtdq2ps	%ymm4, %ymm4
 4201 3a08 C57C29B5 		vmovaps	%ymm14, -144(%rbp)
 4201      70FFFFFF 
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4202              		.loc 1 281 52 discriminator 3 view .LVU1112
 4203 3a10 C4E275B8 		vfmadd231ps	.LC34(%rip), %ymm1, %ymm0
 4203      05000000 
 4203      00
 4204 3a19 C4E245B8 		vfmadd231ps	.LC34(%rip), %ymm7, %ymm3
 4204      1D000000 
 4204      00
 4205 3a22 C4625DB8 		vfmadd231ps	.LC34(%rip), %ymm4, %ymm13
 4205      2D000000 
 4205      00
 4206 3a2b C46205B8 		vfmadd231ps	.LC34(%rip), %ymm15, %ymm8
 4206      05000000 
 4206      00
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4207              		.loc 1 281 35 discriminator 3 view .LVU1113
 4208 3a34 C57D6F75 		vmovdqa	-80(%rbp), %ymm14
 4208      B0
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4209              		.loc 1 281 52 discriminator 3 view .LVU1114
 4210 3a39 C4C17C5D 		vminps	%ymm12, %ymm0, %ymm0
 4210      C4
 4211 3a3e C4C1645D 		vminps	%ymm12, %ymm3, %ymm3
 4211      DC
 4212 3a43 C441145D 		vminps	%ymm12, %ymm13, %ymm13
 4212      EC
 4213 3a48 C4413C5D 		vminps	%ymm12, %ymm8, %ymm8
 4213      C4
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4214              		.loc 1 281 35 discriminator 3 view .LVU1115
 4215 3a4d C5FE5BC0 		vcvttps2dq	%ymm0, %ymm0
 4216 3a51 C5FE5BDB 		vcvttps2dq	%ymm3, %ymm3
 4217 3a55 C5A5DBC0 		vpand	%ymm0, %ymm11, %ymm0
 4218 3a59 C5A5DBDB 		vpand	%ymm3, %ymm11, %ymm3
 4219 3a5d C4417E5B 		vcvttps2dq	%ymm8, %ymm8
 4219      C0
 4220 3a62 C4417E5B 		vcvttps2dq	%ymm13, %ymm13
 4220      ED
 4221 3a67 C44125DB 		vpand	%ymm8, %ymm11, %ymm8
 4221      C0
 4222 3a6c C44125DB 		vpand	%ymm13, %ymm11, %ymm13
 4222      ED
 4223 3a71 C4E27D2B 		vpackusdw	%ymm3, %ymm0, %ymm0
 4223      C3
 4224 3a76 C4423D2B 		vpackusdw	%ymm13, %ymm8, %ymm8
 4224      C5
 4225 3a7b C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 4225      C0D8
 4226 3a81 C443FD00 		vpermq	$216, %ymm8, %ymm8
 4226      C0D8
 4227 3a87 C4C17DDB 		vpand	%ymm14, %ymm0, %ymm3
 4227      DE
 4228 3a8c C4413DDB 		vpand	%ymm14, %ymm8, %ymm8
 4228      C6
 285:sepia_filter.c ****             /* G */
 286:sepia_filter.c ****             pixels_out[3*i + 1] = (unsigned char) (fminf(MAXPIXV,
 287:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 288:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 4229              		.loc 1 288 38 discriminator 3 view .LVU1116
 4230 3a91 C5345935 		vmulps	.LC40(%rip), %ymm9, %ymm14
 4230      00000000 
 4231 3a99 C5AC5905 		vmulps	.LC40(%rip), %ymm10, %ymm0
 4231      00000000 
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4232              		.loc 1 281 35 discriminator 3 view .LVU1117
 4233 3aa1 C4C16567 		vpackuswb	%ymm8, %ymm3, %ymm3
 4233      D8
 4234 3aa6 C57C2885 		vmovaps	-144(%rbp), %ymm8
 4234      70FFFFFF 
 4235 3aae C57C286D 		vmovaps	-112(%rbp), %ymm13
 4235      90
 4236 3ab3 C4623DB8 		vfmadd231ps	.LC41(%rip), %ymm8, %ymm14
 4236      35000000 
 4236      00
 4237              		.loc 1 288 38 discriminator 3 view .LVU1118
 4238 3abc C5545905 		vmulps	.LC40(%rip), %ymm5, %ymm8
 4238      00000000 
 4239 3ac4 C4E215B8 		vfmadd231ps	.LC41(%rip), %ymm13, %ymm0
 4239      05000000 
 4239      00
 4240 3acd C57C28AD 		vmovaps	-176(%rbp), %ymm13
 4240      50FFFFFF 
 289:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 290:sepia_filter.c ****             /* B */
 291:sepia_filter.c ****             pixels_out[3*i + 2] = (unsigned char) (fminf(MAXPIXV,
 292:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 293:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 4241              		.loc 1 293 38 discriminator 3 view .LVU1119
 4242 3ad5 C52C5915 		vmulps	.LC43(%rip), %ymm10, %ymm10
 4242      00000000 
 286:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4243              		.loc 1 286 52 discriminator 3 view .LVU1120
 4244 3add C46245B8 		vfmadd231ps	.LC42(%rip), %ymm7, %ymm14
 4244      35000000 
 4244      00
 4245 3ae6 C46215B8 		vfmadd231ps	.LC41(%rip), %ymm13, %ymm8
 4245      05000000 
 4245      00
 288:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 4246              		.loc 1 288 38 discriminator 3 view .LVU1121
 4247 3aef C54C592D 		vmulps	.LC40(%rip), %ymm6, %ymm13
 4247      00000000 
 286:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4248              		.loc 1 286 52 discriminator 3 view .LVU1122
 4249 3af7 C4E275B8 		vfmadd231ps	.LC42(%rip), %ymm1, %ymm0
 4249      05000000 
 4249      00
 4250              		.loc 1 293 38 discriminator 3 view .LVU1123
 4251 3b00 C534590D 		vmulps	.LC43(%rip), %ymm9, %ymm9
 4251      00000000 
 286:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4252              		.loc 1 286 52 discriminator 3 view .LVU1124
 4253 3b08 C4410C5D 		vminps	%ymm12, %ymm14, %ymm14
 4253      F4
 4254 3b0d C46205B8 		vfmadd231ps	.LC42(%rip), %ymm15, %ymm8
 4254      05000000 
 4254      00
 4255 3b16 C4626DB8 		vfmadd231ps	.LC41(%rip), %ymm2, %ymm13
 4255      2D000000 
 4255      00
 4256 3b1f C4C17C5D 		vminps	%ymm12, %ymm0, %ymm0
 4256      C4
 286:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4257              		.loc 1 286 35 discriminator 3 view .LVU1125
 4258 3b24 C4417E5B 		vcvttps2dq	%ymm14, %ymm14
 4258      F6
 4259 3b29 C44125DB 		vpand	%ymm14, %ymm11, %ymm14
 4259      F6
 286:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4260              		.loc 1 286 52 discriminator 3 view .LVU1126
 4261 3b2e C4413C5D 		vminps	%ymm12, %ymm8, %ymm8
 4261      C4
 4262 3b33 C4625DB8 		vfmadd231ps	.LC42(%rip), %ymm4, %ymm13
 4262      2D000000 
 4262      00
 286:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4263              		.loc 1 286 35 discriminator 3 view .LVU1127
 4264 3b3c C5FE5BC0 		vcvttps2dq	%ymm0, %ymm0
 4265 3b40 C4417E5B 		vcvttps2dq	%ymm8, %ymm8
 4265      C0
 4266 3b45 C5A5DBC0 		vpand	%ymm0, %ymm11, %ymm0
 4267 3b49 C44125DB 		vpand	%ymm8, %ymm11, %ymm8
 4267      C0
 286:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4268              		.loc 1 286 52 discriminator 3 view .LVU1128
 4269 3b4e C441145D 		vminps	%ymm12, %ymm13, %ymm13
 4269      EC
 4270              		.loc 1 293 38 discriminator 3 view .LVU1129
 4271 3b53 C5D4592D 		vmulps	.LC43(%rip), %ymm5, %ymm5
 4271      00000000 
 4272 3b5b C5CC5935 		vmulps	.LC43(%rip), %ymm6, %ymm6
 4272      00000000 
 286:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4273              		.loc 1 286 35 discriminator 3 view .LVU1130
 4274 3b63 C4417E5B 		vcvttps2dq	%ymm13, %ymm13
 4274      ED
 4275 3b68 C44125DB 		vpand	%ymm13, %ymm11, %ymm13
 4275      ED
 4276 3b6d C4C27D2B 		vpackusdw	%ymm14, %ymm0, %ymm0
 4276      C6
 4277 3b72 C4423D2B 		vpackusdw	%ymm13, %ymm8, %ymm8
 4277      C5
 4278 3b77 C57D6F75 		vmovdqa	-80(%rbp), %ymm14
 4278      B0
 4279 3b7c C57C286D 		vmovaps	-112(%rbp), %ymm13
 4279      90
 4280 3b81 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 4280      C0D8
 4281 3b87 C443FD00 		vpermq	$216, %ymm8, %ymm8
 4281      C0D8
 4282 3b8d C4413DDB 		vpand	%ymm14, %ymm8, %ymm8
 4282      C6
 4283 3b92 C4C17DDB 		vpand	%ymm14, %ymm0, %ymm0
 4283      C6
 4284 3b97 C46215B8 		vfmadd231ps	.LC44(%rip), %ymm13, %ymm10
 4284      15000000 
 4284      00
 4285 3ba0 C4C17D67 		vpackuswb	%ymm8, %ymm0, %ymm0
 4285      C0
 4286 3ba5 C57C28AD 		vmovaps	-176(%rbp), %ymm13
 4286      50FFFFFF 
 4287 3bad C57C2885 		vmovaps	-144(%rbp), %ymm8
 4287      70FFFFFF 
 4288 3bb5 C4E26DB8 		vfmadd231ps	.LC44(%rip), %ymm2, %ymm6
 4288      35000000 
 4288      00
 4289 3bbe C4E215B8 		vfmadd231ps	.LC44(%rip), %ymm13, %ymm5
 4289      2D000000 
 4289      00
 4290 3bc7 C4623DB8 		vfmadd231ps	.LC44(%rip), %ymm8, %ymm9
 4290      0D000000 
 4290      00
 291:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 4291              		.loc 1 291 52 discriminator 3 view .LVU1131
 4292 3bd0 C57C29FA 		vmovaps	%ymm15, %ymm2
 4293 3bd4 C4E22D98 		vfmadd132ps	.LC45(%rip), %ymm10, %ymm1
 4293      0D000000 
 4293      00
 4294 3bdd C4E24D98 		vfmadd132ps	.LC45(%rip), %ymm6, %ymm4
 4294      25000000 
 4294      00
 4295 3be6 C4E25598 		vfmadd132ps	.LC45(%rip), %ymm5, %ymm2
 4295      15000000 
 4295      00
 4296 3bef C4E23598 		vfmadd132ps	.LC45(%rip), %ymm9, %ymm7
 4296      3D000000 
 4296      00
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4297              		.loc 1 281 35 discriminator 3 view .LVU1132
 4298 3bf8 C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 4298      DBD8
 286:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4299              		.loc 1 286 13 is_stmt 1 discriminator 3 view .LVU1133
 291:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 4300              		.loc 1 291 52 is_stmt 0 discriminator 3 view .LVU1134
 4301 3bfe C4C1745D 		vminps	%ymm12, %ymm1, %ymm1
 4301      CC
 4302 3c03 C4C15C5D 		vminps	%ymm12, %ymm4, %ymm4
 4302      E4
 4303 3c08 C4C16C5D 		vminps	%ymm12, %ymm2, %ymm2
 4303      D4
 4304 3c0d C4C1445D 		vminps	%ymm12, %ymm7, %ymm7
 4304      FC
 291:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 4305              		.loc 1 291 35 discriminator 3 view .LVU1135
 4306 3c12 C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 4307 3c16 C5FE5BD2 		vcvttps2dq	%ymm2, %ymm2
 4308 3c1a C5A5DBC9 		vpand	%ymm1, %ymm11, %ymm1
 4309 3c1e C5A5DBD2 		vpand	%ymm2, %ymm11, %ymm2
 4310 3c22 C5FE5BFF 		vcvttps2dq	%ymm7, %ymm7
 4311 3c26 C5FE5BE4 		vcvttps2dq	%ymm4, %ymm4
 4312 3c2a C5A5DBFF 		vpand	%ymm7, %ymm11, %ymm7
 4313 3c2e C5A5DBE4 		vpand	%ymm4, %ymm11, %ymm4
 4314 3c32 C4E2752B 		vpackusdw	%ymm7, %ymm1, %ymm1
 4314      CF
 4315 3c37 C4E26D2B 		vpackusdw	%ymm4, %ymm2, %ymm2
 4315      D4
 4316 3c3c C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 4316      C9D8
 4317 3c42 C4E3FD00 		vpermq	$216, %ymm2, %ymm2
 4317      D2D8
 286:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4318              		.loc 1 286 35 discriminator 3 view .LVU1136
 4319 3c48 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 4319      C0D8
 291:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 4320              		.loc 1 291 13 is_stmt 1 discriminator 3 view .LVU1137
 291:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 4321              		.loc 1 291 35 is_stmt 0 discriminator 3 view .LVU1138
 4322 3c4e C4C16DDB 		vpand	%ymm14, %ymm2, %ymm2
 4322      D6
 4323 3c53 C4C175DB 		vpand	%ymm14, %ymm1, %ymm1
 4323      CE
 4324 3c58 C5F567CA 		vpackuswb	%ymm2, %ymm1, %ymm1
 291:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 4325              		.loc 1 291 33 discriminator 3 view .LVU1139
 4326 3c5c C4E26500 		vpshufb	.LC46(%rip), %ymm3, %ymm6
 4326      35000000 
 4326      00
 4327 3c65 C4E27D00 		vpshufb	.LC47(%rip), %ymm0, %ymm5
 4327      2D000000 
 4327      00
 291:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 4328              		.loc 1 291 35 discriminator 3 view .LVU1140
 4329 3c6e C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 4329      C9D8
 291:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 4330              		.loc 1 291 33 discriminator 3 view .LVU1141
 4331 3c74 C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 4331      ED4E
 4332 3c7a C4E26500 		vpshufb	.LC48(%rip), %ymm3, %ymm2
 4332      15000000 
 4332      00
 4333 3c83 C4E27D00 		vpshufb	.LC49(%rip), %ymm0, %ymm4
 4333      25000000 
 4333      00
 4334 3c8c C4E3FD00 		vpermq	$78, %ymm6, %ymm6
 4334      F64E
 4335 3c92 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 4336 3c96 C5EDEBD6 		vpor	%ymm6, %ymm2, %ymm2
 4337 3c9a C4E27500 		vpshufb	.LC50(%rip), %ymm1, %ymm5
 4337      2D000000 
 4337      00
 4338 3ca3 C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 4339 3ca7 C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 4339      ED4E
 4340 3cad C4E27500 		vpshufb	.LC52(%rip), %ymm1, %ymm4
 4340      25000000 
 4340      00
 4341 3cb6 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 4342 3cba C4E26D00 		vpshufb	.LC51(%rip), %ymm2, %ymm2
 4342      15000000 
 4342      00
 4343 3cc3 C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 4344 3cc7 C4E26500 		vpshufb	.LC53(%rip), %ymm3, %ymm4
 4344      25000000 
 4344      00
 4345 3cd0 C5FE7F16 		vmovdqu	%ymm2, (%rsi)
 4346 3cd4 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 4346      E44E
 4347 3cda C4E26500 		vpshufb	.LC54(%rip), %ymm3, %ymm2
 4347      15000000 
 4347      00
 4348 3ce3 C4E27D00 		vpshufb	.LC55(%rip), %ymm0, %ymm5
 4348      2D000000 
 4348      00
 4349 3cec C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 4350 3cf0 C5FD6F3D 		vmovdqa	.LC57(%rip), %ymm7
 4350      00000000 
 4351 3cf8 C4E27500 		vpshufb	.LC56(%rip), %ymm1, %ymm4
 4351      25000000 
 4351      00
 4352 3d01 C5EDEBD5 		vpor	%ymm5, %ymm2, %ymm2
 4353 3d05 C4E35D4C 		vpblendvb	%ymm7, %ymm2, %ymm4, %ymm2
 4353      D270
 4354 3d0b C5FE7F56 		vmovdqu	%ymm2, 32(%rsi)
 4354      20
 4355 3d10 C4E27D00 		vpshufb	.LC58(%rip), %ymm0, %ymm4
 4355      25000000 
 4355      00
 4356 3d19 C4E26500 		vpshufb	.LC59(%rip), %ymm3, %ymm2
 4356      15000000 
 4356      00
 4357 3d22 C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 4357      D24E
 4358 3d28 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 4358      E44E
 4359 3d2e C4E27D00 		vpshufb	.LC60(%rip), %ymm0, %ymm0
 4359      05000000 
 4359      00
 4360 3d37 C4E26500 		vpshufb	.LC61(%rip), %ymm3, %ymm3
 4360      1D000000 
 4360      00
 4361 3d40 C5E5EBDA 		vpor	%ymm2, %ymm3, %ymm3
 4362 3d44 C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 4363 3d48 C4E27500 		vpshufb	.LC62(%rip), %ymm1, %ymm2
 4363      15000000 
 4363      00
 4364 3d51 C5FDEBC3 		vpor	%ymm3, %ymm0, %ymm0
 4365 3d55 C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 4365      D24E
 4366 3d5b C4E27500 		vpshufb	.LC64(%rip), %ymm1, %ymm1
 4366      0D000000 
 4366      00
 4367 3d64 C4E27D00 		vpshufb	.LC63(%rip), %ymm0, %ymm0
 4367      05000000 
 4367      00
 4368 3d6d C5F5EBCA 		vpor	%ymm2, %ymm1, %ymm1
 4369 3d71 C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 4370 3d75 4883C060 		addq	$96, %rax
 4371 3d79 C5FE7F46 		vmovdqu	%ymm0, 64(%rsi)
 4371      40
 278:sepia_filter.c ****         {
 4372              		.loc 1 278 44 is_stmt 1 discriminator 3 view .LVU1142
 278:sepia_filter.c ****         {
 4373              		.loc 1 278 9 discriminator 3 view .LVU1143
 4374 3d7e 4883C660 		addq	$96, %rsi
 4375 3d82 4C39E0   		cmpq	%r12, %rax
 4376 3d85 0F8565FA 		jne	.L97
 4376      FFFF
 4377 3d8b 8BBD28FF 		movl	-216(%rbp), %edi
 4377      FFFF
 4378 3d91 89F8     		movl	%edi, %eax
 4379 3d93 4439F8   		cmpl	%r15d, %eax
 4380 3d96 0F84D805 		je	.L98
 4380      0000
 4381 3d9c C5F877   		vzeroupper
 4382              	.LVL102:
 4383              	.L96:
 278:sepia_filter.c ****         {
 4384              		.loc 1 278 9 is_stmt 0 discriminator 3 view .LVU1144
 4385 3d9f 4489FE   		movl	%r15d, %esi
 4386 3da2 29C6     		subl	%eax, %esi
 4387 3da4 448D56FF 		leal	-1(%rsi), %r10d
 4388 3da8 4183FA0E 		cmpl	$14, %r10d
 4389 3dac 0F863004 		jbe	.L99
 4389      0000
 4390 3db2 488D0440 		leaq	(%rax,%rax,2), %rax
 4391 3db6 4D8D5405 		leaq	0(%r13,%rax), %r10
 4391      00
 282:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4392              		.loc 1 282 48 view .LVU1145
 4393 3dbb C4C17A6F 		vmovdqu	(%r10), %xmm1
 4393      0A
 4394 3dc0 C4C17A6F 		vmovdqu	16(%r10), %xmm4
 4394      6210
 4395 3dc6 C4C17A6F 		vmovdqu	32(%r10), %xmm3
 4395      5A20
 4396 3dcc C5F96F2D 		vmovdqa	.LC68(%rip), %xmm5
 4396      00000000 
 4397 3dd4 C4E25900 		vpshufb	.LC66(%rip), %xmm4, %xmm2
 4397      15000000 
 4397      00
 4398 3ddd C4E27100 		vpshufb	.LC65(%rip), %xmm1, %xmm0
 4398      05000000 
 4398      00
 4399 3de6 C5F9EBC2 		vpor	%xmm2, %xmm0, %xmm0
 4400 3dea C4E26100 		vpshufb	.LC67(%rip), %xmm3, %xmm2
 4400      15000000 
 4400      00
 4401 3df3 C4E3794C 		vpblendvb	%xmm5, %xmm2, %xmm0, %xmm0
 4401      C250
 4402 3df9 C4627930 		vpmovzxbw	%xmm0, %xmm11
 4402      D8
 4403 3dfe C5F973D8 		vpsrldq	$8, %xmm0, %xmm0
 4403      08
 4404 3e03 C4E25900 		vpshufb	.LC70(%rip), %xmm4, %xmm6
 4404      35000000 
 4404      00
 4405 3e0c C4E27100 		vpshufb	.LC69(%rip), %xmm1, %xmm2
 4405      15000000 
 4405      00
 4406 3e15 C4E25900 		vpshufb	.LC73(%rip), %xmm4, %xmm4
 4406      25000000 
 4406      00
 4407 3e1e C4E27100 		vpshufb	.LC72(%rip), %xmm1, %xmm1
 4407      0D000000 
 4407      00
 4408 3e27 C4E27930 		vpmovzxbw	%xmm0, %xmm0
 4408      C0
 4409 3e2c C5E9EBD6 		vpor	%xmm6, %xmm2, %xmm2
 4410 3e30 C5F1EBCC 		vpor	%xmm4, %xmm1, %xmm1
 4411 3e34 C4E26100 		vpshufb	.LC71(%rip), %xmm3, %xmm6
 4411      35000000 
 4411      00
 4412 3e3d C4627933 		vpmovzxwd	%xmm0, %xmm13
 4412      E8
 4413 3e42 C4E26100 		vpshufb	.LC74(%rip), %xmm3, %xmm3
 4413      1D000000 
 4413      00
 4414 3e4b C5F973D8 		vpsrldq	$8, %xmm0, %xmm0
 4414      08
 4415 3e50 C4E3694C 		vpblendvb	%xmm5, %xmm6, %xmm2, %xmm2
 4415      D650
 4416 3e56 C4E3710E 		vpblendw	$224, %xmm3, %xmm1, %xmm1
 4416      CBE0
 4417 3e5c C4E27933 		vpmovzxwd	%xmm0, %xmm0
 4417      C0
 282:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4418              		.loc 1 282 38 view .LVU1146
 4419 3e61 C5F85BF8 		vcvtdq2ps	%xmm0, %xmm7
 283:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 4420              		.loc 1 283 48 view .LVU1147
 4421 3e65 C4E27930 		vpmovzxbw	%xmm2, %xmm6
 4421      F2
 4422 3e6a C5F973DA 		vpsrldq	$8, %xmm2, %xmm0
 4422      08
 284:sepia_filter.c ****             /* G */
 4423              		.loc 1 284 48 view .LVU1148
 4424 3e6f C4E27930 		vpmovzxbw	%xmm1, %xmm2
 4424      D1
 4425 3e74 C4E27933 		vpmovzxwd	%xmm2, %xmm4
 4425      E2
 4426 3e79 C5F173D9 		vpsrldq	$8, %xmm1, %xmm1
 4426      08
 4427 3e7e C5E973DA 		vpsrldq	$8, %xmm2, %xmm2
 4427      08
 4428 3e83 C4E27930 		vpmovzxbw	%xmm1, %xmm1
 4428      C9
 4429 3e88 C4E27933 		vpmovzxwd	%xmm2, %xmm2
 4429      D2
 284:sepia_filter.c ****             /* G */
 4430              		.loc 1 284 38 view .LVU1149
 4431 3e8d C5785BCA 		vcvtdq2ps	%xmm2, %xmm9
 284:sepia_filter.c ****             /* G */
 4432              		.loc 1 284 48 view .LVU1150
 4433 3e91 C4E27933 		vpmovzxwd	%xmm1, %xmm2
 4433      D1
 4434 3e96 C5F173D9 		vpsrldq	$8, %xmm1, %xmm1
 4434      08
 283:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 4435              		.loc 1 283 48 view .LVU1151
 4436 3e9b C4E27930 		vpmovzxbw	%xmm0, %xmm0
 4436      C0
 284:sepia_filter.c ****             /* G */
 4437              		.loc 1 284 48 view .LVU1152
 4438 3ea0 C4E27933 		vpmovzxwd	%xmm1, %xmm1
 4438      C9
 284:sepia_filter.c ****             /* G */
 4439              		.loc 1 284 38 view .LVU1153
 4440 3ea5 C5F85BE9 		vcvtdq2ps	%xmm1, %xmm5
 283:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 4441              		.loc 1 283 48 view .LVU1154
 4442 3ea9 C4627933 		vpmovzxwd	%xmm6, %xmm12
 4442      E6
 284:sepia_filter.c ****             /* G */
 4443              		.loc 1 284 38 view .LVU1155
 4444 3eae C5F8296D 		vmovaps	%xmm5, -80(%rbp)
 4444      B0
 283:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 4445              		.loc 1 283 48 view .LVU1156
 4446 3eb3 C4E27933 		vpmovzxwd	%xmm0, %xmm3
 4446      D8
 283:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 4447              		.loc 1 283 38 view .LVU1157
 4448 3eb8 C4E27918 		vbroadcastss	.LC1(%rip), %xmm5
 4448      2D000000 
 4448      00
 283:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 4449              		.loc 1 283 48 view .LVU1158
 4450 3ec1 C5C973DE 		vpsrldq	$8, %xmm6, %xmm6
 4450      08
 4451 3ec6 C5F973D8 		vpsrldq	$8, %xmm0, %xmm0
 4451      08
 4452 3ecb C4E27933 		vpmovzxwd	%xmm6, %xmm6
 4452      F6
 4453 3ed0 C4E27933 		vpmovzxwd	%xmm0, %xmm0
 4453      C0
 284:sepia_filter.c ****             /* G */
 4454              		.loc 1 284 38 view .LVU1159
 4455 3ed5 C5785BFA 		vcvtdq2ps	%xmm2, %xmm15
 283:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 4456              		.loc 1 283 38 view .LVU1160
 4457 3ed9 C441785B 		vcvtdq2ps	%xmm12, %xmm12
 4457      E4
 4458 3ede C5F85BF6 		vcvtdq2ps	%xmm6, %xmm6
 4459 3ee2 C51859C5 		vmulps	%xmm5, %xmm12, %xmm8
 4460 3ee6 C5C859CD 		vmulps	%xmm5, %xmm6, %xmm1
 4461 3eea C5F85BDB 		vcvtdq2ps	%xmm3, %xmm3
 4462 3eee C5F85BC0 		vcvtdq2ps	%xmm0, %xmm0
 4463 3ef2 C5E059D5 		vmulps	%xmm5, %xmm3, %xmm2
 4464 3ef6 C5F859ED 		vmulps	%xmm5, %xmm0, %xmm5
 284:sepia_filter.c ****             /* G */
 4465              		.loc 1 284 38 view .LVU1161
 4466 3efa C5785BD4 		vcvtdq2ps	%xmm4, %xmm10
 282:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4467              		.loc 1 282 48 view .LVU1162
 4468 3efe C4427933 		vpmovzxwd	%xmm11, %xmm14
 4468      F3
 4469 3f03 C4E27918 		vbroadcastss	.LC2(%rip), %xmm4
 4469      25000000 
 4469      00
 4470 3f0c C4C12173 		vpsrldq	$8, %xmm11, %xmm11
 4470      DB08
 4471 3f12 C4427933 		vpmovzxwd	%xmm11, %xmm11
 4471      DB
 282:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4472              		.loc 1 282 38 view .LVU1163
 4473 3f17 C441785B 		vcvtdq2ps	%xmm14, %xmm14
 4473      F6
 4474 3f1c C441785B 		vcvtdq2ps	%xmm11, %xmm11
 4474      DB
 4475 3f21 C441785B 		vcvtdq2ps	%xmm13, %xmm13
 4475      ED
 4476 3f26 C46209B8 		vfmadd231ps	%xmm4, %xmm14, %xmm8
 4476      C4
 4477 3f2b C4E221B8 		vfmadd231ps	%xmm4, %xmm11, %xmm1
 4477      CC
 4478 3f30 C4E211B8 		vfmadd231ps	%xmm4, %xmm13, %xmm2
 4478      D4
 4479 3f35 C4E25198 		vfmadd132ps	%xmm7, %xmm5, %xmm4
 4479      E7
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4480              		.loc 1 281 52 view .LVU1164
 4481 3f3a C4E27918 		vbroadcastss	.LC3(%rip), %xmm5
 4481      2D000000 
 4481      00
 4482 3f43 C5F8297D 		vmovaps	%xmm7, -112(%rbp)
 4482      90
 4483 3f48 C44251B8 		vfmadd231ps	%xmm10, %xmm5, %xmm8
 4483      C2
 4484 3f4d C4C251B8 		vfmadd231ps	%xmm9, %xmm5, %xmm1
 4484      C9
 4485 3f52 C4C251B8 		vfmadd231ps	%xmm15, %xmm5, %xmm2
 4485      D7
 4486 3f57 C4E25998 		vfmadd132ps	-80(%rbp), %xmm4, %xmm5
 4486      6DB0
 4487 3f5d C4E27918 		vbroadcastss	.LC4(%rip), %xmm7
 4487      3D000000 
 4487      00
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4488              		.loc 1 281 35 view .LVU1165
 4489 3f66 BAFFFF00 		movl	$65535, %edx
 4489      00
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4490              		.loc 1 281 52 view .LVU1166
 4491 3f6b C5385DC7 		vminps	%xmm7, %xmm8, %xmm8
 4492 3f6f C5F05DCF 		vminps	%xmm7, %xmm1, %xmm1
 4493 3f73 C5E85DD7 		vminps	%xmm7, %xmm2, %xmm2
 4494 3f77 C5D05DEF 		vminps	%xmm7, %xmm5, %xmm5
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4495              		.loc 1 281 35 view .LVU1167
 4496 3f7b C5F96EE2 		vmovd	%edx, %xmm4
 4497 3f7f C5F970E4 		vpshufd	$0, %xmm4, %xmm4
 4497      00
 4498 3f84 41BAFF00 		movl	$255, %r10d
 4498      0000
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4499              		.loc 1 281 52 view .LVU1168
 4500 3f8a C5782995 		vmovaps	%xmm10, -144(%rbp)
 4500      70FFFFFF 
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4501              		.loc 1 281 35 view .LVU1169
 4502 3f92 C4417A5B 		vcvttps2dq	%xmm8, %xmm8
 4502      C0
 4503 3f97 C441796E 		vmovd	%r10d, %xmm10
 4503      D2
 4504 3f9c C44159DB 		vpand	%xmm8, %xmm4, %xmm8
 4504      C0
 4505 3fa1 C5FA5BC9 		vcvttps2dq	%xmm1, %xmm1
 4506 3fa5 C5FA5BD2 		vcvttps2dq	%xmm2, %xmm2
 4507 3fa9 C5D9DBC9 		vpand	%xmm1, %xmm4, %xmm1
 4508 3fad C5D9DBD2 		vpand	%xmm2, %xmm4, %xmm2
 4509 3fb1 C5FA5BED 		vcvttps2dq	%xmm5, %xmm5
 4510 3fb5 C5D9DBED 		vpand	%xmm5, %xmm4, %xmm5
 4511 3fb9 C4427979 		vpbroadcastw	%xmm10, %xmm10
 4511      D2
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4512              		.loc 1 281 52 view .LVU1170
 4513 3fbe C57829BD 		vmovaps	%xmm15, -192(%rbp)
 4513      40FFFFFF 
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4514              		.loc 1 281 35 view .LVU1171
 4515 3fc6 C4E2392B 		vpackusdw	%xmm1, %xmm8, %xmm1
 4515      C9
 288:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 4516              		.loc 1 288 38 view .LVU1172
 4517 3fcb C4627918 		vbroadcastss	.LC7(%rip), %xmm15
 4517      3D000000 
 4517      00
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4518              		.loc 1 281 35 view .LVU1173
 4519 3fd4 C4E2692B 		vpackusdw	%xmm5, %xmm2, %xmm2
 4519      D5
 4520 3fd9 C5A9DBD2 		vpand	%xmm2, %xmm10, %xmm2
 4521 3fdd C5A9DBC9 		vpand	%xmm1, %xmm10, %xmm1
 4522 3fe1 C5F167CA 		vpackuswb	%xmm2, %xmm1, %xmm1
 288:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 4523              		.loc 1 288 38 view .LVU1174
 4524 3fe5 C4416059 		vmulps	%xmm15, %xmm3, %xmm8
 4524      C7
 4525 3fea C4C14859 		vmulps	%xmm15, %xmm6, %xmm2
 4525      D7
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4526              		.loc 1 281 52 view .LVU1175
 4527 3fef C578298D 		vmovaps	%xmm9, -176(%rbp)
 4527      50FFFFFF 
 288:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 4528              		.loc 1 288 38 view .LVU1176
 4529 3ff7 C4411859 		vmulps	%xmm15, %xmm12, %xmm9
 4529      CF
 4530 3ffc C4417859 		vmulps	%xmm15, %xmm0, %xmm15
 4530      FF
 4531 4001 C4E27918 		vbroadcastss	.LC8(%rip), %xmm5
 4531      2D000000 
 4531      00
 4532 400a 4C01F0   		addq	%r14, %rax
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4533              		.loc 1 281 13 is_stmt 1 view .LVU1177
 286:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4534              		.loc 1 286 13 view .LVU1178
 4535 400d C4E221B8 		vfmadd231ps	%xmm5, %xmm11, %xmm2
 4535      D5
 4536 4012 C46209B8 		vfmadd231ps	%xmm5, %xmm14, %xmm9
 4536      CD
 4537 4017 C46211B8 		vfmadd231ps	%xmm5, %xmm13, %xmm8
 4537      C5
 4538 401c C4E20198 		vfmadd132ps	-112(%rbp), %xmm15, %xmm5
 4538      6D90
 286:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4539              		.loc 1 286 52 is_stmt 0 view .LVU1179
 4540 4022 C4627918 		vbroadcastss	.LC9(%rip), %xmm15
 4540      3D000000 
 4540      00
 4541 402b C46201B8 		vfmadd231ps	-144(%rbp), %xmm15, %xmm9
 4541      8D70FFFF 
 4541      FF
 4542 4034 C4E201B8 		vfmadd231ps	-176(%rbp), %xmm15, %xmm2
 4542      9550FFFF 
 4542      FF
 4543 403d C46201B8 		vfmadd231ps	-192(%rbp), %xmm15, %xmm8
 4543      8540FFFF 
 4543      FF
 4544 4046 C4E201B8 		vfmadd231ps	-80(%rbp), %xmm15, %xmm5
 4544      6DB0
 4545 404c C5305DCF 		vminps	%xmm7, %xmm9, %xmm9
 4546 4050 C5E85DD7 		vminps	%xmm7, %xmm2, %xmm2
 4547 4054 C5385DC7 		vminps	%xmm7, %xmm8, %xmm8
 4548 4058 C5D05DEF 		vminps	%xmm7, %xmm5, %xmm5
 286:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4549              		.loc 1 286 35 view .LVU1180
 4550 405c C4417A5B 		vcvttps2dq	%xmm9, %xmm9
 4550      C9
 4551 4061 C5FA5BD2 		vcvttps2dq	%xmm2, %xmm2
 4552 4065 C44159DB 		vpand	%xmm9, %xmm4, %xmm9
 4552      C9
 4553 406a C5D9DBD2 		vpand	%xmm2, %xmm4, %xmm2
 4554 406e C4417A5B 		vcvttps2dq	%xmm8, %xmm8
 4554      C0
 4555 4073 C5FA5BED 		vcvttps2dq	%xmm5, %xmm5
 4556 4077 C44159DB 		vpand	%xmm8, %xmm4, %xmm8
 4556      C0
 4557 407c C5D9DBED 		vpand	%xmm5, %xmm4, %xmm5
 4558 4080 C4E2392B 		vpackusdw	%xmm5, %xmm8, %xmm5
 4558      ED
 4559 4085 C4E2312B 		vpackusdw	%xmm2, %xmm9, %xmm2
 4559      D2
 4560 408a C5A9DBED 		vpand	%xmm5, %xmm10, %xmm5
 4561 408e C5A9DBD2 		vpand	%xmm2, %xmm10, %xmm2
 4562 4092 C5E967D5 		vpackuswb	%xmm5, %xmm2, %xmm2
 291:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 4563              		.loc 1 291 13 is_stmt 1 view .LVU1181
 4564              		.loc 1 293 38 is_stmt 0 view .LVU1182
 4565 4096 C4E27918 		vbroadcastss	.LC10(%rip), %xmm5
 4565      2D000000 
 4565      00
 4566 409f C4627918 		vbroadcastss	.LC11(%rip), %xmm8
 4566      05000000 
 4566      00
 4567 40a8 C5F859C5 		vmulps	%xmm5, %xmm0, %xmm0
 4568 40ac C51859E5 		vmulps	%xmm5, %xmm12, %xmm12
 4569 40b0 C5C859F5 		vmulps	%xmm5, %xmm6, %xmm6
 4570 40b4 C5E059DD 		vmulps	%xmm5, %xmm3, %xmm3
 4571 40b8 C5F8286D 		vmovaps	-112(%rbp), %xmm5
 4571      90
 4572 40bd C44209B8 		vfmadd231ps	%xmm8, %xmm14, %xmm12
 4572      E0
 4573 40c2 C4C27998 		vfmadd132ps	%xmm8, %xmm0, %xmm5
 4573      E8
 4574 40c7 C4C221B8 		vfmadd231ps	%xmm8, %xmm11, %xmm6
 4574      F0
 4575 40cc C4C211B8 		vfmadd231ps	%xmm8, %xmm13, %xmm3
 4575      D8
 291:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 4576              		.loc 1 291 52 view .LVU1183
 4577 40d1 C5F82885 		vmovaps	-144(%rbp), %xmm0
 4577      70FFFFFF 
 4578 40d9 C4627918 		vbroadcastss	.LC12(%rip), %xmm8
 4578      05000000 
 4578      00
 4579 40e2 C4C21998 		vfmadd132ps	%xmm8, %xmm12, %xmm0
 4579      C0
 4580 40e7 C4E239B8 		vfmadd231ps	-176(%rbp), %xmm8, %xmm6
 4580      B550FFFF 
 4580      FF
 4581 40f0 C4E239B8 		vfmadd231ps	-192(%rbp), %xmm8, %xmm3
 4581      9D40FFFF 
 4581      FF
 4582 40f9 C4E239B8 		vfmadd231ps	-80(%rbp), %xmm8, %xmm5
 4582      6DB0
 4583 40ff C5F85DC7 		vminps	%xmm7, %xmm0, %xmm0
 4584 4103 C5C85DF7 		vminps	%xmm7, %xmm6, %xmm6
 4585 4107 C5E05DDF 		vminps	%xmm7, %xmm3, %xmm3
 4586 410b C5D05DEF 		vminps	%xmm7, %xmm5, %xmm5
 291:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 4587              		.loc 1 291 35 view .LVU1184
 4588 410f C5FA5BC0 		vcvttps2dq	%xmm0, %xmm0
 4589 4113 C5FA5BF6 		vcvttps2dq	%xmm6, %xmm6
 4590 4117 C5D9DBC0 		vpand	%xmm0, %xmm4, %xmm0
 4591 411b C5D9DBF6 		vpand	%xmm6, %xmm4, %xmm6
 4592 411f C5FA5BED 		vcvttps2dq	%xmm5, %xmm5
 4593 4123 C5FA5BDB 		vcvttps2dq	%xmm3, %xmm3
 4594 4127 C5D9DBDB 		vpand	%xmm3, %xmm4, %xmm3
 4595 412b C5D9DBE5 		vpand	%xmm5, %xmm4, %xmm4
 4596 412f C4E2612B 		vpackusdw	%xmm4, %xmm3, %xmm4
 4596      E4
 4597 4134 C4E2792B 		vpackusdw	%xmm6, %xmm0, %xmm0
 4597      C6
 4598 4139 C5A9DBC0 		vpand	%xmm0, %xmm10, %xmm0
 4599 413d C529DBD4 		vpand	%xmm4, %xmm10, %xmm10
 4600 4141 C4C17967 		vpackuswb	%xmm10, %xmm0, %xmm0
 4600      C2
 291:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 4601              		.loc 1 291 33 view .LVU1185
 4602 4146 C5F160DA 		vpunpcklbw	%xmm2, %xmm1, %xmm3
 4603 414a C5F96F2D 		vmovdqa	.LC91(%rip), %xmm5
 4603      00000000 
 4604 4152 C4E27900 		vpshufb	.LC90(%rip), %xmm0, %xmm4
 4604      25000000 
 4604      00
 4605 415b C4E26100 		vpshufb	.LC89(%rip), %xmm3, %xmm3
 4605      1D000000 
 4605      00
 4606 4164 C4E3614C 		vpblendvb	%xmm5, %xmm4, %xmm3, %xmm3
 4606      DC50
 4607 416a C5FA7F18 		vmovdqu	%xmm3, (%rax)
 4608 416e C4E27100 		vpshufb	.LC93(%rip), %xmm1, %xmm4
 4608      25000000 
 4608      00
 4609 4177 C4E26900 		vpshufb	.LC92(%rip), %xmm2, %xmm3
 4609      1D000000 
 4609      00
 4610 4180 C4E27100 		vpshufb	.LC96(%rip), %xmm1, %xmm1
 4610      0D000000 
 4610      00
 4611 4189 C4E26900 		vpshufb	.LC97(%rip), %xmm2, %xmm2
 4611      15000000 
 4611      00
 4612 4192 C5F1EBCA 		vpor	%xmm2, %xmm1, %xmm1
 4613 4196 C5F96F2D 		vmovdqa	.LC95(%rip), %xmm5
 4613      00000000 
 4614 419e C5F96F15 		vmovdqa	.LC99(%rip), %xmm2
 4614      00000000 
 4615 41a6 C5E1EBDC 		vpor	%xmm4, %xmm3, %xmm3
 4616 41aa C4E27900 		vpshufb	.LC94(%rip), %xmm0, %xmm4
 4616      25000000 
 4616      00
 4617 41b3 C4E27900 		vpshufb	.LC98(%rip), %xmm0, %xmm0
 4617      05000000 
 4617      00
 4618 41bc C4E3614C 		vpblendvb	%xmm5, %xmm4, %xmm3, %xmm3
 4618      DC50
 4619 41c2 C4E3794C 		vpblendvb	%xmm2, %xmm1, %xmm0, %xmm0
 4619      C120
 4620 41c8 C5FA7F58 		vmovdqu	%xmm3, 16(%rax)
 4620      10
 4621 41cd C5FA7F40 		vmovdqu	%xmm0, 32(%rax)
 4621      20
 278:sepia_filter.c ****         {
 4622              		.loc 1 278 44 is_stmt 1 view .LVU1186
 278:sepia_filter.c ****         {
 4623              		.loc 1 278 9 view .LVU1187
 4624 41d2 89F0     		movl	%esi, %eax
 4625 41d4 83E0F0   		andl	$-16, %eax
 4626 41d7 01C7     		addl	%eax, %edi
 4627 41d9 83E60F   		andl	$15, %esi
 4628 41dc 0F841E01 		je	.L100
 4628      0000
 4629              	.L99:
 278:sepia_filter.c ****         {
 4630              		.loc 1 278 9 is_stmt 0 view .LVU1188
 4631 41e2 8D347F   		leal	(%rdi,%rdi,2), %esi
 4632 41e5 4863F6   		movslq	%esi, %rsi
 4633 41e8 C57A1015 		vmovss	.LC1(%rip), %xmm10
 4633      00000000 
 4634 41f0 C57A100D 		vmovss	.LC2(%rip), %xmm9
 4634      00000000 
 4635 41f8 C57A1005 		vmovss	.LC3(%rip), %xmm8
 4635      00000000 
 4636 4200 C5FA100D 		vmovss	.LC4(%rip), %xmm1
 4636      00000000 
 4637 4208 C5FA103D 		vmovss	.LC7(%rip), %xmm7
 4637      00000000 
 4638 4210 C5FA1035 		vmovss	.LC8(%rip), %xmm6
 4638      00000000 
 4639 4218 C5FA102D 		vmovss	.LC9(%rip), %xmm5
 4639      00000000 
 4640 4220 C5FA1025 		vmovss	.LC10(%rip), %xmm4
 4640      00000000 
 4641 4228 C5FA101D 		vmovss	.LC11(%rip), %xmm3
 4641      00000000 
 4642 4230 C5FA1015 		vmovss	.LC12(%rip), %xmm2
 4642      00000000 
 4643 4238 498D4435 		leaq	0(%r13,%rsi), %rax
 4643      00
 4644 423d 4C01F6   		addq	%r14, %rsi
 4645              		.p2align 4,,10
 4646              		.p2align 3
 4647              	.L101:
 4648              	.LVL103:
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4649              		.loc 1 281 13 is_stmt 1 view .LVU1189
 282:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4650              		.loc 1 282 48 is_stmt 0 view .LVU1190
 4651 4240 440FB610 		movzbl	(%rax), %r10d
 282:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4652              		.loc 1 282 38 view .LVU1191
 4653 4244 C4410057 		vxorps	%xmm15, %xmm15, %xmm15
 4653      FF
 4654 4249 C4C1022A 		vcvtsi2ssl	%r10d, %xmm15, %xmm0
 4654      C2
 283:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 4655              		.loc 1 283 48 view .LVU1192
 4656 424e 440FB650 		movzbl	1(%rax), %r10d
 4656      01
 278:sepia_filter.c ****         {
 4657              		.loc 1 278 44 view .LVU1193
 4658 4253 FFC7     		incl	%edi
 4659              	.LVL104:
 283:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 4660              		.loc 1 283 38 view .LVU1194
 4661 4255 C441022A 		vcvtsi2ssl	%r10d, %xmm15, %xmm11
 4661      DA
 284:sepia_filter.c ****             /* G */
 4662              		.loc 1 284 48 view .LVU1195
 4663 425a 440FB650 		movzbl	2(%rax), %r10d
 4663      02
 278:sepia_filter.c ****         {
 4664              		.loc 1 278 9 view .LVU1196
 4665 425f 4883C603 		addq	$3, %rsi
 4666 4263 4883C003 		addq	$3, %rax
 283:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 4667              		.loc 1 283 38 view .LVU1197
 4668 4267 C4412259 		vmulss	%xmm10, %xmm11, %xmm11
 4668      DA
 4669 426c C44279B9 		vfmadd231ss	%xmm9, %xmm0, %xmm11
 4669      D9
 284:sepia_filter.c ****             /* G */
 4670              		.loc 1 284 38 view .LVU1198
 4671 4271 C4C1022A 		vcvtsi2ssl	%r10d, %xmm15, %xmm0
 4671      C2
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4672              		.loc 1 281 52 view .LVU1199
 4673 4276 C4C22199 		vfmadd132ss	%xmm8, %xmm11, %xmm0
 4673      C0
 4674 427b C5FA5DC1 		vminss	%xmm1, %xmm0, %xmm0
 281:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4675              		.loc 1 281 35 view .LVU1200
 4676 427f C57A2CD0 		vcvttss2sil	%xmm0, %r10d
 4677 4283 448856FD 		movb	%r10b, -3(%rsi)
 286:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4678              		.loc 1 286 13 is_stmt 1 view .LVU1201
 287:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 4679              		.loc 1 287 48 is_stmt 0 view .LVU1202
 4680 4287 440FB650 		movzbl	-3(%rax), %r10d
 4680      FD
 287:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 4681              		.loc 1 287 38 view .LVU1203
 4682 428c C4C1022A 		vcvtsi2ssl	%r10d, %xmm15, %xmm0
 4682      C2
 288:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 4683              		.loc 1 288 48 view .LVU1204
 4684 4291 440FB650 		movzbl	-2(%rax), %r10d
 4684      FE
 288:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 4685              		.loc 1 288 38 view .LVU1205
 4686 4296 C441022A 		vcvtsi2ssl	%r10d, %xmm15, %xmm11
 4686      DA
 289:sepia_filter.c ****             /* B */
 4687              		.loc 1 289 48 view .LVU1206
 4688 429b 440FB650 		movzbl	-1(%rax), %r10d
 4688      FF
 288:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 4689              		.loc 1 288 38 view .LVU1207
 4690 42a0 C52259DF 		vmulss	%xmm7, %xmm11, %xmm11
 4691 42a4 C46279B9 		vfmadd231ss	%xmm6, %xmm0, %xmm11
 4691      DE
 289:sepia_filter.c ****             /* B */
 4692              		.loc 1 289 38 view .LVU1208
 4693 42a9 C4C1022A 		vcvtsi2ssl	%r10d, %xmm15, %xmm0
 4693      C2
 286:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4694              		.loc 1 286 52 view .LVU1209
 4695 42ae C4E22199 		vfmadd132ss	%xmm5, %xmm11, %xmm0
 4695      C5
 4696 42b3 C5FA5DC1 		vminss	%xmm1, %xmm0, %xmm0
 286:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4697              		.loc 1 286 35 view .LVU1210
 4698 42b7 C57A2CD0 		vcvttss2sil	%xmm0, %r10d
 4699 42bb 448856FE 		movb	%r10b, -2(%rsi)
 291:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 4700              		.loc 1 291 13 is_stmt 1 view .LVU1211
 292:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 4701              		.loc 1 292 48 is_stmt 0 view .LVU1212
 4702 42bf 440FB650 		movzbl	-3(%rax), %r10d
 4702      FD
 292:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 4703              		.loc 1 292 38 view .LVU1213
 4704 42c4 C441022A 		vcvtsi2ssl	%r10d, %xmm15, %xmm12
 4704      E2
 4705              		.loc 1 293 48 view .LVU1214
 4706 42c9 440FB650 		movzbl	-2(%rax), %r10d
 4706      FE
 4707              		.loc 1 293 38 view .LVU1215
 4708 42ce C4C1022A 		vcvtsi2ssl	%r10d, %xmm15, %xmm0
 4708      C2
 294:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 4709              		.loc 1 294 48 view .LVU1216
 4710 42d3 440FB650 		movzbl	-1(%rax), %r10d
 4710      FF
 293:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 4711              		.loc 1 293 38 view .LVU1217
 4712 42d8 C57A59DC 		vmulss	%xmm4, %xmm0, %xmm11
 4713              		.loc 1 294 38 view .LVU1218
 4714 42dc C4C1022A 		vcvtsi2ssl	%r10d, %xmm15, %xmm0
 4714      C2
 4715 42e1 C46219B9 		vfmadd231ss	%xmm3, %xmm12, %xmm11
 4715      DB
 291:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 4716              		.loc 1 291 52 view .LVU1219
 4717 42e6 C4E22199 		vfmadd132ss	%xmm2, %xmm11, %xmm0
 4717      C2
 4718 42eb C5FA5DC1 		vminss	%xmm1, %xmm0, %xmm0
 291:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 4719              		.loc 1 291 35 view .LVU1220
 4720 42ef C57A2CD0 		vcvttss2sil	%xmm0, %r10d
 4721 42f3 448856FF 		movb	%r10b, -1(%rsi)
 278:sepia_filter.c ****         {
 4722              		.loc 1 278 44 is_stmt 1 view .LVU1221
 4723              	.LVL105:
 278:sepia_filter.c ****         {
 4724              		.loc 1 278 9 view .LVU1222
 4725 42f7 4139FF   		cmpl	%edi, %r15d
 4726 42fa 0F8F40FF 		jg	.L101
 4726      FFFF
 4727              	.LVL106:
 4728              	.L100:
 278:sepia_filter.c ****         {
 4729              		.loc 1 278 9 is_stmt 0 view .LVU1223
 4730              	.LBE35:
 295:sepia_filter.c ****         }
 296:sepia_filter.c ****         dummy(image_in, image_out);
 4731              		.loc 1 296 9 is_stmt 1 view .LVU1224
 4732 4300 488BB538 		movq	-200(%rbp), %rsi
 4732      FFFFFF
 4733 4307 488BBD30 		movq	-208(%rbp), %rdi
 4733      FFFFFF
 4734 430e E8000000 		call	dummy
 4734      00
 4735              	.LVL107:
 275:sepia_filter.c ****     {
 4736              		.loc 1 275 36 view .LVU1225
 275:sepia_filter.c ****     {
 4737              		.loc 1 275 25 view .LVU1226
 4738 4313 FFCB     		decl	%ebx
 4739 4315 0F8595F4 		jne	.L104
 4739      FFFF
 4740              	.L103:
 275:sepia_filter.c ****     {
 4741              		.loc 1 275 25 is_stmt 0 view .LVU1227
 4742              	.LBE38:
 297:sepia_filter.c ****     }
 298:sepia_filter.c ****     end_t = get_wall_time();
 4743              		.loc 1 298 5 is_stmt 1 view .LVU1228
 4744              		.loc 1 298 13 is_stmt 0 view .LVU1229
 4745 431b 31C0     		xorl	%eax, %eax
 4746 431d E8000000 		call	get_wall_time
 4746      00
 4747              	.LVL108:
 299:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_cast2");
 4748              		.loc 1 299 5 is_stmt 1 view .LVU1230
 4749 4322 C5FB5C85 		vsubsd	-224(%rbp), %xmm0, %xmm0
 4749      20FFFFFF 
 4750              	.LVL109:
 300:sepia_filter.c **** }
 4751              		.loc 1 300 1 is_stmt 0 view .LVU1231
 4752 432a 4881C4C8 		addq	$200, %rsp
 4752      000000
 4753 4331 5B       		popq	%rbx
 4754 4332 415C     		popq	%r12
 4755 4334 415D     		popq	%r13
 4756              		.cfi_remember_state
 4757              		.cfi_def_cfa 13, 0
 4758              	.LVL110:
 4759              		.loc 1 300 1 view .LVU1232
 4760 4336 415E     		popq	%r14
 4761              	.LVL111:
 299:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_cast2");
 4762              		.loc 1 299 5 view .LVU1233
 4763 4338 4489FF   		movl	%r15d, %edi
 4764              		.loc 1 300 1 view .LVU1234
 4765 433b 415F     		popq	%r15
 4766 433d 5D       		popq	%rbp
 4767              	.LVL112:
 4768              		.loc 1 300 1 view .LVU1235
 4769 433e 498D65F0 		leaq	-16(%r13), %rsp
 4770              		.cfi_def_cfa 7, 16
 299:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_cast2");
 4771              		.loc 1 299 5 view .LVU1236
 4772 4342 BE000000 		movl	$.LC109, %esi
 4772      00
 4773              		.loc 1 300 1 view .LVU1237
 4774 4347 415D     		popq	%r13
 4775              		.cfi_def_cfa_offset 8
 299:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_cast2");
 4776              		.loc 1 299 5 view .LVU1238
 4777 4349 E9000000 		jmp	results
 4777      00
 4778              	.LVL113:
 4779              	.L116:
 4780              		.cfi_restore_state
 4781              	.LBB39:
 296:sepia_filter.c ****     }
 4782              		.loc 1 296 9 is_stmt 1 view .LVU1239
 4783 434e 488BB538 		movq	-200(%rbp), %rsi
 4783      FFFFFF
 4784 4355 488BBD30 		movq	-208(%rbp), %rdi
 4784      FFFFFF
 4785 435c E8000000 		call	dummy
 4785      00
 4786              	.LVL114:
 275:sepia_filter.c ****     {
 4787              		.loc 1 275 36 view .LVU1240
 275:sepia_filter.c ****     {
 4788              		.loc 1 275 25 view .LVU1241
 4789 4361 FFCB     		decl	%ebx
 4790 4363 0F853BF4 		jne	.L95
 4790      FFFF
 4791 4369 EBB0     		jmp	.L103
 4792              	.LVL115:
 4793              	.L106:
 4794              	.LBB36:
 278:sepia_filter.c ****         {
 4795              		.loc 1 278 18 is_stmt 0 view .LVU1242
 4796 436b 31C0     		xorl	%eax, %eax
 4797 436d 31FF     		xorl	%edi, %edi
 4798 436f E92BFAFF 		jmp	.L96
 4798      FF
 4799              	.L98:
 278:sepia_filter.c ****         {
 4800              		.loc 1 278 18 view .LVU1243
 4801              	.LBE36:
 296:sepia_filter.c ****     }
 4802              		.loc 1 296 9 is_stmt 1 view .LVU1244
 4803 4374 488BB538 		movq	-200(%rbp), %rsi
 4803      FFFFFF
 4804 437b 488BBD30 		movq	-208(%rbp), %rdi
 4804      FFFFFF
 4805 4382 C5F877   		vzeroupper
 4806              	.LVL116:
 4807 4385 E8000000 		call	dummy
 4807      00
 4808              	.LVL117:
 275:sepia_filter.c ****     {
 4809              		.loc 1 275 36 view .LVU1245
 275:sepia_filter.c ****     {
 4810              		.loc 1 275 25 view .LVU1246
 4811 438a FFCB     		decl	%ebx
 4812 438c 0F851EF4 		jne	.L104
 4812      FFFF
 4813 4392 EB87     		jmp	.L103
 4814              	.LVL118:
 4815              	.L119:
 275:sepia_filter.c ****     {
 4816              		.loc 1 275 25 is_stmt 0 view .LVU1247
 4817              	.LBE39:
 263:sepia_filter.c ****         exit(-1);
 4818              		.loc 1 263 9 is_stmt 1 view .LVU1248
 4819 4394 BF000000 		movl	$.LC0, %edi
 4819      00
 4820              	.LVL119:
 263:sepia_filter.c ****         exit(-1);
 4821              		.loc 1 263 9 is_stmt 0 view .LVU1249
 4822 4399 E8000000 		call	puts
 4822      00
 4823              	.LVL120:
 264:sepia_filter.c ****     }
 4824              		.loc 1 264 9 is_stmt 1 view .LVU1250
 4825 439e 83CFFF   		orl	$-1, %edi
 4826 43a1 E8000000 		call	exit
 4826      00
 4827              	.LVL121:
 4828              		.cfi_endproc
 4829              	.LFE22:
 4831              		.section	.rodata.str1.1
 4832              	.LC110:
 4833 0045 73657069 		.string	"sepiaf_cast_esc"
 4833      61665F63 
 4833      6173745F 
 4833      65736300 
 4834              		.text
 4835 43a6 662E0F1F 		.p2align 4
 4835      84000000 
 4835      0000
 4836              		.globl	sepia_filter_cast_esc
 4838              	sepia_filter_cast_esc:
 4839              	.LVL122:
 4840              	.LFB23:
 301:sepia_filter.c **** //----------------------------------------------------------------------------
 302:sepia_filter.c **** 
 303:sepia_filter.c **** /* cambios respecto sepia_filter_cast1(): atributo para no vectorizar */
 304:sepia_filter.c **** __attribute__((optimize("no-tree-vectorize")))
 305:sepia_filter.c **** void
 306:sepia_filter.c **** sepia_filter_cast_esc(image_t * restrict image_in, image_t * restrict image_out)
 307:sepia_filter.c **** {
 4841              		.loc 1 307 1 view -0
 4842              		.cfi_startproc
 308:sepia_filter.c ****     double start_t, end_t;
 4843              		.loc 1 308 5 view .LVU1252
 309:sepia_filter.c ****     const int height = image_in->height;
 4844              		.loc 1 309 5 view .LVU1253
 307:sepia_filter.c ****     double start_t, end_t;
 4845              		.loc 1 307 1 is_stmt 0 view .LVU1254
 4846 43b0 4157     		pushq	%r15
 4847              		.cfi_def_cfa_offset 16
 4848              		.cfi_offset 15, -16
 4849 43b2 4156     		pushq	%r14
 4850              		.cfi_def_cfa_offset 24
 4851              		.cfi_offset 14, -24
 4852 43b4 4155     		pushq	%r13
 4853              		.cfi_def_cfa_offset 32
 4854              		.cfi_offset 13, -32
 4855 43b6 4154     		pushq	%r12
 4856              		.cfi_def_cfa_offset 40
 4857              		.cfi_offset 12, -40
 4858 43b8 55       		pushq	%rbp
 4859              		.cfi_def_cfa_offset 48
 4860              		.cfi_offset 6, -48
 4861 43b9 53       		pushq	%rbx
 4862              		.cfi_def_cfa_offset 56
 4863              		.cfi_offset 3, -56
 4864 43ba 4883EC18 		subq	$24, %rsp
 4865              		.cfi_def_cfa_offset 80
 310:sepia_filter.c ****     const int width =  image_in->width;
 311:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 312:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
 4866              		.loc 1 312 30 view .LVU1255
 4867 43be 488B06   		movq	(%rsi), %rax
 313:sepia_filter.c **** 
 314:sepia_filter.c ****     if (image_in->bytes_per_pixel != 3)
 4868              		.loc 1 314 8 view .LVU1256
 4869 43c1 837F1003 		cmpl	$3, 16(%rdi)
 312:sepia_filter.c **** 
 4870              		.loc 1 312 30 view .LVU1257
 4871 43c5 48890424 		movq	%rax, (%rsp)
 309:sepia_filter.c ****     const int width =  image_in->width;
 4872              		.loc 1 309 15 view .LVU1258
 4873 43c9 448B6F0C 		movl	12(%rdi), %r13d
 4874              	.LVL123:
 310:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 4875              		.loc 1 310 5 is_stmt 1 view .LVU1259
 310:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 4876              		.loc 1 310 15 is_stmt 0 view .LVU1260
 4877 43cd 8B5F08   		movl	8(%rdi), %ebx
 4878              	.LVL124:
 311:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
 4879              		.loc 1 311 5 is_stmt 1 view .LVU1261
 311:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
 4880              		.loc 1 311 30 is_stmt 0 view .LVU1262
 4881 43d0 4C8B37   		movq	(%rdi), %r14
 4882              	.LVL125:
 312:sepia_filter.c **** 
 4883              		.loc 1 312 5 is_stmt 1 view .LVU1263
 4884              		.loc 1 314 5 view .LVU1264
 4885              		.loc 1 314 8 is_stmt 0 view .LVU1265
 4886 43d3 0F85CD01 		jne	.L129
 4886      0000
 315:sepia_filter.c ****     {
 316:sepia_filter.c ****         printf("ERROR: input image has to be RGB\n");
 317:sepia_filter.c ****         exit(-1);
 318:sepia_filter.c ****     }
 319:sepia_filter.c ****     
 320:sepia_filter.c ****     /* fill struct fields */
 321:sepia_filter.c ****     image_out->width  = width;
 322:sepia_filter.c ****     image_out->height = height;
 323:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
 4887              		.loc 1 323 32 view .LVU1266
 4888 43d9 48B80300 		movabsq	$8589934595, %rax
 4888      00000200 
 4888      0000
 4889              	.LVL126:
 321:sepia_filter.c ****     image_out->height = height;
 4890              		.loc 1 321 23 view .LVU1267
 4891 43e3 895E08   		movl	%ebx, 8(%rsi)
 322:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
 4892              		.loc 1 322 23 view .LVU1268
 4893 43e6 44896E0C 		movl	%r13d, 12(%rsi)
 4894              		.loc 1 323 32 view .LVU1269
 4895 43ea 48894610 		movq	%rax, 16(%rsi)
 4896              	.LBB40:
 4897              	.LBB41:
 324:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 325:sepia_filter.c **** 
 326:sepia_filter.c ****     start_t = get_wall_time();
 327:sepia_filter.c **** 
 328:sepia_filter.c ****     for (int it = 0; it < NITER; it++)
 329:sepia_filter.c ****     {
 330:sepia_filter.c ****         for (int i = 0; i < height*width; i++)
 4898              		.loc 1 330 35 view .LVU1270
 4899 43ee 440FAFEB 		imull	%ebx, %r13d
 4900              	.LVL127:
 4901              		.loc 1 330 35 view .LVU1271
 4902              	.LBE41:
 4903              	.LBE40:
 326:sepia_filter.c **** 
 4904              		.loc 1 326 15 view .LVU1272
 4905 43f2 31C0     		xorl	%eax, %eax
 4906 43f4 4989FC   		movq	%rdi, %r12
 4907 43f7 4889F5   		movq	%rsi, %rbp
 321:sepia_filter.c ****     image_out->height = height;
 4908              		.loc 1 321 5 is_stmt 1 view .LVU1273
 322:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
 4909              		.loc 1 322 5 view .LVU1274
 323:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 4910              		.loc 1 323 5 view .LVU1275
 324:sepia_filter.c **** 
 4911              		.loc 1 324 5 view .LVU1276
 326:sepia_filter.c **** 
 4912              		.loc 1 326 5 view .LVU1277
 326:sepia_filter.c **** 
 4913              		.loc 1 326 15 is_stmt 0 view .LVU1278
 4914 43fa E8000000 		call	get_wall_time
 4914      00
 4915              	.LVL128:
 326:sepia_filter.c **** 
 4916              		.loc 1 326 15 view .LVU1279
 4917 43ff 4963C5   		movslq	%r13d, %rax
 4918 4402 488D1440 		leaq	(%rax,%rax,2), %rdx
 4919 4406 C57A1025 		vmovss	.LC1(%rip), %xmm12
 4919      00000000 
 4920 440e C57A101D 		vmovss	.LC2(%rip), %xmm11
 4920      00000000 
 4921 4416 C57A1015 		vmovss	.LC3(%rip), %xmm10
 4921      00000000 
 4922 441e C5FA101D 		vmovss	.LC106(%rip), %xmm3
 4922      00000000 
 4923 4426 C5FB1144 		vmovsd	%xmm0, 8(%rsp)
 4923      2408
 4924              	.LVL129:
 328:sepia_filter.c ****     {
 4925              		.loc 1 328 5 is_stmt 1 view .LVU1280
 4926              	.LBB43:
 328:sepia_filter.c ****     {
 4927              		.loc 1 328 10 view .LVU1281
 328:sepia_filter.c ****     {
 4928              		.loc 1 328 25 view .LVU1282
 4929 442c 4D8D3C16 		leaq	(%r14,%rdx), %r15
 4930              	.LBB42:
 4931              		.loc 1 330 35 is_stmt 0 view .LVU1283
 4932 4430 BB0A0000 		movl	$10, %ebx
 4932      00
 4933              	.LVL130:
 4934              		.loc 1 330 35 view .LVU1284
 4935 4435 C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
 4936              	.LVL131:
 4937 4439 0F1F8000 		.p2align 4,,10
 4937      000000
 4938              		.p2align 3
 4939              	.L122:
 4940              		.loc 1 330 27 is_stmt 1 view .LVU1285
 4941 4440 4585ED   		testl	%r13d, %r13d
 4942 4443 0F8EFE00 		jle	.L126
 4942      0000
 4943 4449 488B0C24 		movq	(%rsp), %rcx
 4944 444d C5FA1015 		vmovss	.LC4(%rip), %xmm2
 4944      00000000 
 4945 4455 C57A100D 		vmovss	.LC7(%rip), %xmm9
 4945      00000000 
 4946 445d C57A1005 		vmovss	.LC8(%rip), %xmm8
 4946      00000000 
 4947 4465 C5FA103D 		vmovss	.LC9(%rip), %xmm7
 4947      00000000 
 4948 446d C5FA1035 		vmovss	.LC10(%rip), %xmm6
 4948      00000000 
 4949 4475 C5FA102D 		vmovss	.LC11(%rip), %xmm5
 4949      00000000 
 4950 447d C5FA1025 		vmovss	.LC12(%rip), %xmm4
 4950      00000000 
 4951 4485 4C89F0   		movq	%r14, %rax
 4952              	.LVL132:
 4953 4488 0F1F8400 		.p2align 4,,10
 4953      00000000 
 4954              		.p2align 3
 4955              	.L123:
 331:sepia_filter.c ****         {
 332:sepia_filter.c ****             /* el cast float mejora las prestaciones!! */
 333:sepia_filter.c ****             /* R */
 334:sepia_filter.c ****             pixels_out[3*i + 0] = (unsigned char) (fminf(MAXPIXV,
 4956              		.loc 1 334 13 discriminator 3 view .LVU1286
 335:sepia_filter.c ****                           0.5f +
 336:sepia_filter.c ****                           sepia[0][0]*pixels_in[3*i + 0] + 
 4957              		.loc 1 336 48 is_stmt 0 discriminator 3 view .LVU1287
 4958 4490 0FB630   		movzbl	(%rax), %esi
 330:sepia_filter.c ****         {
 4959              		.loc 1 330 27 discriminator 3 view .LVU1288
 4960 4493 4883C003 		addq	$3, %rax
 4961              		.loc 1 336 38 discriminator 3 view .LVU1289
 4962 4497 C5F22AC6 		vcvtsi2ssl	%esi, %xmm1, %xmm0
 337:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4963              		.loc 1 337 48 discriminator 3 view .LVU1290
 4964 449b 0FB670FE 		movzbl	-2(%rax), %esi
 330:sepia_filter.c ****         {
 4965              		.loc 1 330 27 discriminator 3 view .LVU1291
 4966 449f 4883C103 		addq	$3, %rcx
 4967              		.loc 1 337 38 discriminator 3 view .LVU1292
 4968 44a3 C5722AEE 		vcvtsi2ssl	%esi, %xmm1, %xmm13
 338:sepia_filter.c ****                           sepia[0][2]*pixels_in[3*i + 2]));
 4969              		.loc 1 338 48 discriminator 3 view .LVU1293
 4970 44a7 0FB670FF 		movzbl	-1(%rax), %esi
 337:sepia_filter.c ****                           sepia[0][1]*pixels_in[3*i + 1] + 
 4971              		.loc 1 337 38 discriminator 3 view .LVU1294
 4972 44ab C4411259 		vmulss	%xmm12, %xmm13, %xmm13
 4972      EC
 4973 44b0 C4C21199 		vfmadd132ss	%xmm11, %xmm13, %xmm0
 4973      C3
 4974              		.loc 1 338 38 discriminator 3 view .LVU1295
 4975 44b5 C5722AEE 		vcvtsi2ssl	%esi, %xmm1, %xmm13
 4976 44b9 C4426199 		vfmadd132ss	%xmm10, %xmm3, %xmm13
 4976      EA
 334:sepia_filter.c ****                           0.5f +
 4977              		.loc 1 334 52 discriminator 3 view .LVU1296
 4978 44be C4C17A58 		vaddss	%xmm13, %xmm0, %xmm0
 4978      C5
 4979 44c3 C5FA5DC2 		vminss	%xmm2, %xmm0, %xmm0
 334:sepia_filter.c ****                           0.5f +
 4980              		.loc 1 334 35 discriminator 3 view .LVU1297
 4981 44c7 C5FA2CF0 		vcvttss2sil	%xmm0, %esi
 4982 44cb 408871FD 		movb	%sil, -3(%rcx)
 339:sepia_filter.c ****             /* G */
 340:sepia_filter.c ****             pixels_out[3*i + 1] = (unsigned char) (fminf(MAXPIXV,
 4983              		.loc 1 340 13 is_stmt 1 discriminator 3 view .LVU1298
 341:sepia_filter.c ****                           0.5f +
 342:sepia_filter.c ****                           sepia[1][0]*pixels_in[3*i + 0] + 
 4984              		.loc 1 342 48 is_stmt 0 discriminator 3 view .LVU1299
 4985 44cf 0FB670FD 		movzbl	-3(%rax), %esi
 4986              		.loc 1 342 38 discriminator 3 view .LVU1300
 4987 44d3 C5F22AC6 		vcvtsi2ssl	%esi, %xmm1, %xmm0
 343:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 4988              		.loc 1 343 48 discriminator 3 view .LVU1301
 4989 44d7 0FB670FE 		movzbl	-2(%rax), %esi
 4990              		.loc 1 343 38 discriminator 3 view .LVU1302
 4991 44db C5722AEE 		vcvtsi2ssl	%esi, %xmm1, %xmm13
 344:sepia_filter.c ****                           sepia[1][2]*pixels_in[3*i + 2]));
 4992              		.loc 1 344 48 discriminator 3 view .LVU1303
 4993 44df 0FB670FF 		movzbl	-1(%rax), %esi
 343:sepia_filter.c ****                           sepia[1][1]*pixels_in[3*i + 1] + 
 4994              		.loc 1 343 38 discriminator 3 view .LVU1304
 4995 44e3 C4411259 		vmulss	%xmm9, %xmm13, %xmm13
 4995      E9
 4996 44e8 C4C21199 		vfmadd132ss	%xmm8, %xmm13, %xmm0
 4996      C0
 4997              		.loc 1 344 38 discriminator 3 view .LVU1305
 4998 44ed C5722AEE 		vcvtsi2ssl	%esi, %xmm1, %xmm13
 4999 44f1 C4626199 		vfmadd132ss	%xmm7, %xmm3, %xmm13
 4999      EF
 340:sepia_filter.c ****                           0.5f +
 5000              		.loc 1 340 52 discriminator 3 view .LVU1306
 5001 44f6 C4C17A58 		vaddss	%xmm13, %xmm0, %xmm0
 5001      C5
 5002 44fb C5FA5DC2 		vminss	%xmm2, %xmm0, %xmm0
 340:sepia_filter.c ****                           0.5f +
 5003              		.loc 1 340 35 discriminator 3 view .LVU1307
 5004 44ff C5FA2CF0 		vcvttss2sil	%xmm0, %esi
 5005 4503 408871FE 		movb	%sil, -2(%rcx)
 345:sepia_filter.c ****             /* B */
 346:sepia_filter.c ****             pixels_out[3*i + 2] = (unsigned char) (fminf(MAXPIXV,
 5006              		.loc 1 346 13 is_stmt 1 discriminator 3 view .LVU1308
 347:sepia_filter.c ****                           0.5f +
 348:sepia_filter.c ****                           sepia[2][0]*pixels_in[3*i + 0] + 
 5007              		.loc 1 348 48 is_stmt 0 discriminator 3 view .LVU1309
 5008 4507 0FB670FD 		movzbl	-3(%rax), %esi
 5009              		.loc 1 348 38 discriminator 3 view .LVU1310
 5010 450b C5F22AC6 		vcvtsi2ssl	%esi, %xmm1, %xmm0
 349:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 5011              		.loc 1 349 48 discriminator 3 view .LVU1311
 5012 450f 0FB670FE 		movzbl	-2(%rax), %esi
 5013              		.loc 1 349 38 discriminator 3 view .LVU1312
 5014 4513 C5722AEE 		vcvtsi2ssl	%esi, %xmm1, %xmm13
 350:sepia_filter.c ****                           sepia[2][2]*pixels_in[3*i + 2]));
 5015              		.loc 1 350 48 discriminator 3 view .LVU1313
 5016 4517 0FB670FF 		movzbl	-1(%rax), %esi
 349:sepia_filter.c ****                           sepia[2][1]*pixels_in[3*i + 1] + 
 5017              		.loc 1 349 38 discriminator 3 view .LVU1314
 5018 451b C51259EE 		vmulss	%xmm6, %xmm13, %xmm13
 5019 451f C4E21199 		vfmadd132ss	%xmm5, %xmm13, %xmm0
 5019      C5
 5020              		.loc 1 350 38 discriminator 3 view .LVU1315
 5021 4524 C5722AEE 		vcvtsi2ssl	%esi, %xmm1, %xmm13
 5022 4528 C4626199 		vfmadd132ss	%xmm4, %xmm3, %xmm13
 5022      EC
 346:sepia_filter.c ****                           0.5f +
 5023              		.loc 1 346 52 discriminator 3 view .LVU1316
 5024 452d C4C17A58 		vaddss	%xmm13, %xmm0, %xmm0
 5024      C5
 5025 4532 C5FA5DC2 		vminss	%xmm2, %xmm0, %xmm0
 346:sepia_filter.c ****                           0.5f +
 5026              		.loc 1 346 35 discriminator 3 view .LVU1317
 5027 4536 C5FA2CF0 		vcvttss2sil	%xmm0, %esi
 5028 453a 408871FF 		movb	%sil, -1(%rcx)
 330:sepia_filter.c ****         {
 5029              		.loc 1 330 44 is_stmt 1 discriminator 3 view .LVU1318
 5030              	.LVL133:
 330:sepia_filter.c ****         {
 5031              		.loc 1 330 27 discriminator 3 view .LVU1319
 5032 453e 4939C7   		cmpq	%rax, %r15
 5033 4541 0F8549FF 		jne	.L123
 5033      FFFF
 5034              	.L126:
 5035              	.LBE42:
 351:sepia_filter.c ****         }
 352:sepia_filter.c ****         dummy(image_in, image_out);
 5036              		.loc 1 352 9 view .LVU1320
 5037 4547 4889EE   		movq	%rbp, %rsi
 5038 454a 4C89E7   		movq	%r12, %rdi
 5039 454d E8000000 		call	dummy
 5039      00
 5040              	.LVL134:
 328:sepia_filter.c ****     {
 5041              		.loc 1 328 36 view .LVU1321
 328:sepia_filter.c ****     {
 5042              		.loc 1 328 25 view .LVU1322
 5043 4552 FFCB     		decl	%ebx
 5044              	.LVL135:
 328:sepia_filter.c ****     {
 5045              		.loc 1 328 25 is_stmt 0 view .LVU1323
 5046 4554 C57A1025 		vmovss	.LC1(%rip), %xmm12
 5046      00000000 
 5047 455c C57A101D 		vmovss	.LC2(%rip), %xmm11
 5047      00000000 
 5048 4564 C57A1015 		vmovss	.LC3(%rip), %xmm10
 5048      00000000 
 5049 456c C5FA101D 		vmovss	.LC106(%rip), %xmm3
 5049      00000000 
 5050 4574 C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
 5051 4578 0F85C2FE 		jne	.L122
 5051      FFFF
 5052              	.LBE43:
 353:sepia_filter.c ****     }
 354:sepia_filter.c ****     end_t = get_wall_time();
 5053              		.loc 1 354 5 is_stmt 1 view .LVU1324
 5054              		.loc 1 354 13 is_stmt 0 view .LVU1325
 5055 457e 31C0     		xorl	%eax, %eax
 5056 4580 E8000000 		call	get_wall_time
 5056      00
 5057              	.LVL136:
 355:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_cast_esc");
 5058              		.loc 1 355 5 is_stmt 1 view .LVU1326
 5059 4585 C5FB5C44 		vsubsd	8(%rsp), %xmm0, %xmm0
 5059      2408
 5060              	.LVL137:
 356:sepia_filter.c **** }
 5061              		.loc 1 356 1 is_stmt 0 view .LVU1327
 5062 458b 4883C418 		addq	$24, %rsp
 5063              		.cfi_remember_state
 5064              		.cfi_def_cfa_offset 56
 5065 458f 5B       		popq	%rbx
 5066              		.cfi_def_cfa_offset 48
 5067              	.LVL138:
 5068              		.loc 1 356 1 view .LVU1328
 5069 4590 5D       		popq	%rbp
 5070              		.cfi_def_cfa_offset 40
 5071              	.LVL139:
 5072              		.loc 1 356 1 view .LVU1329
 5073 4591 415C     		popq	%r12
 5074              		.cfi_def_cfa_offset 32
 5075              	.LVL140:
 355:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_cast_esc");
 5076              		.loc 1 355 5 view .LVU1330
 5077 4593 4489EF   		movl	%r13d, %edi
 5078              		.loc 1 356 1 view .LVU1331
 5079 4596 415D     		popq	%r13
 5080              		.cfi_def_cfa_offset 24
 5081 4598 415E     		popq	%r14
 5082              		.cfi_def_cfa_offset 16
 355:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_cast_esc");
 5083              		.loc 1 355 5 view .LVU1332
 5084 459a BE000000 		movl	$.LC110, %esi
 5084      00
 5085              		.loc 1 356 1 view .LVU1333
 5086 459f 415F     		popq	%r15
 5087              		.cfi_def_cfa_offset 8
 355:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_cast_esc");
 5088              		.loc 1 355 5 view .LVU1334
 5089 45a1 E9000000 		jmp	results
 5089      00
 5090              	.LVL141:
 5091              	.L129:
 5092              		.cfi_restore_state
 316:sepia_filter.c ****         exit(-1);
 5093              		.loc 1 316 9 is_stmt 1 view .LVU1335
 5094 45a6 BF000000 		movl	$.LC0, %edi
 5094      00
 5095              	.LVL142:
 316:sepia_filter.c ****         exit(-1);
 5096              		.loc 1 316 9 is_stmt 0 view .LVU1336
 5097 45ab E8000000 		call	puts
 5097      00
 5098              	.LVL143:
 317:sepia_filter.c ****     }
 5099              		.loc 1 317 9 is_stmt 1 view .LVU1337
 5100 45b0 83CFFF   		orl	$-1, %edi
 5101 45b3 E8000000 		call	exit
 5101      00
 5102              	.LVL144:
 5103              		.cfi_endproc
 5104              	.LFE23:
 5106              		.section	.rodata.str1.1
 5107              	.LC111:
 5108 0055 73657069 		.string	"sepiaf_SOA0"
 5108      61665F53 
 5108      4F413000 
 5109              		.text
 5110 45b8 0F1F8400 		.p2align 4
 5110      00000000 
 5111              		.globl	sepia_filter_SOA0
 5113              	sepia_filter_SOA0:
 5114              	.LVL145:
 5115              	.LFB24:
 357:sepia_filter.c **** //----------------------------------------------------------------------------
 358:sepia_filter.c **** 
 359:sepia_filter.c **** /* transformación de datos de entrada y salida de formato vector de estructuras (Array of Structs,
 360:sepia_filter.c ****  * (R0 G0 B0 R1 G1 B1 ... Rn-1 Gn-1 Bn-1)
 361:sepia_filter.c ****  * a estructura de vectores (Struct of Arrays, SoA)
 362:sepia_filter.c ****  * (R0 R1 ... Rn-1 G0 G1 ... Gn-1 B0 B1 ... Bn-1) */
 363:sepia_filter.c **** void
 364:sepia_filter.c **** sepia_filter_SOA0(image_t * restrict image_in, image_t * restrict image_out)
 365:sepia_filter.c **** {
 5116              		.loc 1 365 1 view -0
 5117              		.cfi_startproc
 366:sepia_filter.c ****     double start_t, end_t;
 5118              		.loc 1 366 5 view .LVU1339
 367:sepia_filter.c ****     const int height = image_in->height;
 5119              		.loc 1 367 5 view .LVU1340
 365:sepia_filter.c ****     double start_t, end_t;
 5120              		.loc 1 365 1 is_stmt 0 view .LVU1341
 5121 45c0 4155     		pushq	%r13
 5122              		.cfi_def_cfa_offset 16
 5123              		.cfi_offset 13, -16
 5124 45c2 4889F9   		movq	%rdi, %rcx
 5125 45c5 4C8D6C24 		leaq	16(%rsp), %r13
 5125      10
 5126              		.cfi_def_cfa 13, 0
 5127 45ca 4883E4E0 		andq	$-32, %rsp
 5128 45ce 41FF75F8 		pushq	-8(%r13)
 5129 45d2 55       		pushq	%rbp
 5130 45d3 4889E5   		movq	%rsp, %rbp
 5131              		.cfi_escape 0x10,0x6,0x2,0x76,0
 5132 45d6 4157     		pushq	%r15
 5133 45d8 4156     		pushq	%r14
 5134 45da 4155     		pushq	%r13
 5135              		.cfi_escape 0xf,0x3,0x76,0x68,0x6
 5136              		.cfi_escape 0x10,0xf,0x2,0x76,0x78
 5137              		.cfi_escape 0x10,0xe,0x2,0x76,0x70
 5138 45dc 4154     		pushq	%r12
 5139 45de 53       		pushq	%rbx
 5140 45df 4881EC68 		subq	$360, %rsp
 5140      010000
 5141              		.cfi_escape 0x10,0xc,0x2,0x76,0x60
 5142              		.cfi_escape 0x10,0x3,0x2,0x76,0x58
 368:sepia_filter.c ****     const int width =  image_in->width;
 5143              		.loc 1 368 15 view .LVU1342
 5144 45e6 C5FA7E47 		vmovq	8(%rdi), %xmm0
 5144      08
 365:sepia_filter.c ****     double start_t, end_t;
 5145              		.loc 1 365 1 view .LVU1343
 5146 45eb 4889BDB0 		movq	%rdi, -336(%rbp)
 5146      FEFFFF
 369:sepia_filter.c ****     unsigned char *R_in, *G_in, *B_in, *R_out, *G_out, *B_out;
 370:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 5147              		.loc 1 370 30 view .LVU1344
 5148 45f2 488B17   		movq	(%rdi), %rdx
 371:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
 5149              		.loc 1 371 30 view .LVU1345
 5150 45f5 488B3E   		movq	(%rsi), %rdi
 5151              	.LVL146:
 372:sepia_filter.c **** 
 373:sepia_filter.c ****     if (image_in->bytes_per_pixel != 3)
 5152              		.loc 1 373 8 view .LVU1346
 5153 45f8 83791003 		cmpl	$3, 16(%rcx)
 365:sepia_filter.c ****     double start_t, end_t;
 5154              		.loc 1 365 1 view .LVU1347
 5155 45fc 4889B5B8 		movq	%rsi, -328(%rbp)
 5155      FEFFFF
 371:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
 5156              		.loc 1 371 30 view .LVU1348
 5157 4603 4889BD90 		movq	%rdi, -368(%rbp)
 5157      FEFFFF
 5158 460a C4C37916 		vpextrd	$1, %xmm0, %r15d
 5158      C701
 5159              	.LVL147:
 368:sepia_filter.c ****     unsigned char *R_in, *G_in, *B_in, *R_out, *G_out, *B_out;
 5160              		.loc 1 368 5 is_stmt 1 view .LVU1349
 369:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 5161              		.loc 1 369 5 view .LVU1350
 370:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
 5162              		.loc 1 370 5 view .LVU1351
 371:sepia_filter.c **** 
 5163              		.loc 1 371 5 view .LVU1352
 5164              		.loc 1 373 5 view .LVU1353
 5165              		.loc 1 373 8 is_stmt 0 view .LVU1354
 5166 4610 0F85D716 		jne	.L185
 5166      0000
 5167 4616 C5F97EC0 		vmovd	%xmm0, %eax
 374:sepia_filter.c ****     {
 375:sepia_filter.c ****         printf("ERROR: input image has to be RGB\n");
 376:sepia_filter.c ****         exit(-1);
 377:sepia_filter.c ****     }
 378:sepia_filter.c ****     
 379:sepia_filter.c ****     /* fill struct fields */
 380:sepia_filter.c ****     image_out->width  = width;
 381:sepia_filter.c ****     image_out->height = height;
 382:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
 383:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 384:sepia_filter.c **** 
 385:sepia_filter.c ****     /* transform data layout */
 386:sepia_filter.c ****     R_in = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
 5168              		.loc 1 386 63 view .LVU1355
 5169 461a 440FAFF8 		imull	%eax, %r15d
 382:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 5170              		.loc 1 382 32 view .LVU1356
 5171 461e 48B90300 		movabsq	$8589934595, %rcx
 5171      00000200 
 5171      0000
 5172              	.LVL148:
 382:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 5173              		.loc 1 382 32 view .LVU1357
 5174 4628 48894E10 		movq	%rcx, 16(%rsi)
 5175              		.loc 1 386 63 view .LVU1358
 5176 462c 478D2C3F 		leal	(%r15,%r15), %r13d
 5177 4630 438D5C3D 		leal	0(%r13,%r15), %ebx
 5177      00
 5178              		.loc 1 386 30 view .LVU1359
 5179 4635 4863DB   		movslq	%ebx, %rbx
 380:sepia_filter.c ****     image_out->height = height;
 5180              		.loc 1 380 23 view .LVU1360
 5181 4638 C5F9D646 		vmovq	%xmm0, 8(%rsi)
 5181      08
 5182              		.loc 1 386 30 view .LVU1361
 5183 463d BF200000 		movl	$32, %edi
 5183      00
 5184              	.LVL149:
 5185              		.loc 1 386 30 view .LVU1362
 5186 4642 4889DE   		movq	%rbx, %rsi
 5187              	.LVL150:
 5188              		.loc 1 386 30 view .LVU1363
 5189 4645 48899570 		movq	%rdx, -144(%rbp)
 5189      FFFFFF
 380:sepia_filter.c ****     image_out->height = height;
 5190              		.loc 1 380 5 is_stmt 1 view .LVU1364
 381:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
 5191              		.loc 1 381 5 view .LVU1365
 382:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 5192              		.loc 1 382 5 view .LVU1366
 383:sepia_filter.c **** 
 5193              		.loc 1 383 5 view .LVU1367
 5194              		.loc 1 386 5 view .LVU1368
 5195              		.loc 1 386 30 is_stmt 0 view .LVU1369
 5196 464c E8000000 		call	aligned_alloc
 5196      00
 5197              	.LVL151:
 5198              		.loc 1 386 30 view .LVU1370
 5199 4651 4989C4   		movq	%rax, %r12
 5200              	.LVL152:
 387:sepia_filter.c ****     G_in = R_in + 1*width*height;
 5201              		.loc 1 387 5 is_stmt 1 view .LVU1371
 388:sepia_filter.c ****     B_in = R_in + 2*width*height;
 5202              		.loc 1 388 26 is_stmt 0 view .LVU1372
 5203 4654 4963CD   		movslq	%r13d, %rcx
 5204              		.loc 1 388 10 view .LVU1373
 5205 4657 4D8D040C 		leaq	(%r12,%rcx), %r8
 387:sepia_filter.c ****     G_in = R_in + 1*width*height;
 5206              		.loc 1 387 26 view .LVU1374
 5207 465b 4963C7   		movslq	%r15d, %rax
 5208              	.LVL153:
 389:sepia_filter.c **** 
 390:sepia_filter.c ****     R_out = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
 5209              		.loc 1 390 31 view .LVU1375
 5210 465e 4889DE   		movq	%rbx, %rsi
 5211 4661 BF200000 		movl	$32, %edi
 5211      00
 388:sepia_filter.c ****     B_in = R_in + 2*width*height;
 5212              		.loc 1 388 10 view .LVU1376
 5213 4666 48894DB0 		movq	%rcx, -80(%rbp)
 5214 466a 4C894590 		movq	%r8, -112(%rbp)
 387:sepia_filter.c ****     B_in = R_in + 2*width*height;
 5215              		.loc 1 387 10 view .LVU1377
 5216 466e 488985C8 		movq	%rax, -312(%rbp)
 5216      FEFFFF
 5217 4675 4D8D3404 		leaq	(%r12,%rax), %r14
 5218              	.LVL154:
 388:sepia_filter.c ****     B_in = R_in + 2*width*height;
 5219              		.loc 1 388 5 is_stmt 1 view .LVU1378
 5220              		.loc 1 390 5 view .LVU1379
 5221              		.loc 1 390 31 is_stmt 0 view .LVU1380
 5222 4679 E8000000 		call	aligned_alloc
 5222      00
 5223              	.LVL155:
 5224              		.loc 1 390 31 view .LVU1381
 5225 467e 4889C3   		movq	%rax, %rbx
 5226              	.LVL156:
 391:sepia_filter.c ****     G_out = R_out + 1*width*height;
 5227              		.loc 1 391 5 is_stmt 1 view .LVU1382
 392:sepia_filter.c ****     B_out = R_out + 2*width*height;
 5228              		.loc 1 392 11 is_stmt 0 view .LVU1383
 5229 4681 488B4DB0 		movq	-80(%rbp), %rcx
 391:sepia_filter.c ****     G_out = R_out + 1*width*height;
 5230              		.loc 1 391 11 view .LVU1384
 5231 4685 488B85C8 		movq	-312(%rbp), %rax
 5231      FEFFFF
 5232              	.LVL157:
 5233              	.LBB44:
 393:sepia_filter.c **** 
 394:sepia_filter.c ****     /* transformación AoS -> SoA */
 395:sepia_filter.c ****     /* COMPLETAR ... */
 396:sepia_filter.c ****     #pragma GCC ivdep
 397:sepia_filter.c ****     for (int i = 0; i < height*width; i++)
 5234              		.loc 1 397 5 view .LVU1385
 5235 468c 4585FF   		testl	%r15d, %r15d
 5236              	.LBE44:
 391:sepia_filter.c ****     B_out = R_out + 2*width*height;
 5237              		.loc 1 391 11 view .LVU1386
 5238 468f 4C8D2C03 		leaq	(%rbx,%rax), %r13
 5239              	.LVL158:
 392:sepia_filter.c ****     B_out = R_out + 2*width*height;
 5240              		.loc 1 392 5 is_stmt 1 view .LVU1387
 392:sepia_filter.c ****     B_out = R_out + 2*width*height;
 5241              		.loc 1 392 11 is_stmt 0 view .LVU1388
 5242 4693 488D0419 		leaq	(%rcx,%rbx), %rax
 5243 4697 488945B0 		movq	%rax, -80(%rbp)
 5244              	.LVL159:
 5245              	.LBB45:
 5246              		.loc 1 397 10 is_stmt 1 view .LVU1389
 5247              		.loc 1 397 5 view .LVU1390
 5248 469b 418D47FF 		leal	-1(%r15), %eax
 5249              	.LVL160:
 5250              		.loc 1 397 5 is_stmt 0 view .LVU1391
 5251 469f 8985ACFE 		movl	%eax, -340(%rbp)
 5251      FFFF
 5252 46a5 4C8B4590 		movq	-112(%rbp), %r8
 5253 46a9 488B9570 		movq	-144(%rbp), %rdx
 5253      FFFFFF
 5254 46b0 0F8EEA15 		jle	.L186
 5254      0000
 5255 46b6 83F81E   		cmpl	$30, %eax
 5256 46b9 0F860A16 		jbe	.L155
 5256      0000
 5257 46bf 488BBDC8 		movq	-312(%rbp), %rdi
 5257      FEFFFF
 5258 46c6 4589FB   		movl	%r15d, %r11d
 5259 46c9 41C1EB05 		shrl	$5, %r11d
 5260 46cd 4D8D0C3E 		leaq	(%r14,%rdi), %r9
 5261 46d1 49C1E305 		salq	$5, %r11
 5262 46d5 C57D6F2D 		vmovdqa	.LC15(%rip), %ymm13
 5262      00000000 
 5263 46dd C57D6F25 		vmovdqa	.LC16(%rip), %ymm12
 5263      00000000 
 5264 46e5 C57D6F1D 		vmovdqa	.LC17(%rip), %ymm11
 5264      00000000 
 5265 46ed C57D6F15 		vmovdqa	.LC18(%rip), %ymm10
 5265      00000000 
 5266 46f5 C57D6F0D 		vmovdqa	.LC19(%rip), %ymm9
 5266      00000000 
 5267 46fd C57D6F05 		vmovdqa	.LC20(%rip), %ymm8
 5267      00000000 
 5268 4705 C5FD6F3D 		vmovdqa	.LC21(%rip), %ymm7
 5268      00000000 
 5269 470d C5FD6F35 		vmovdqa	.LC22(%rip), %ymm6
 5269      00000000 
 5270 4715 C5FD6F2D 		vmovdqa	.LC23(%rip), %ymm5
 5270      00000000 
 5271 471d C5FD6F25 		vmovdqa	.LC25(%rip), %ymm4
 5271      00000000 
 5272 4725 488B4DB0 		movq	-80(%rbp), %rcx
 5273 4729 4889D0   		movq	%rdx, %rax
 5274 472c 4C89E6   		movq	%r12, %rsi
 5275 472f 4D89F2   		movq	%r14, %r10
 5276 4732 4C89CF   		movq	%r9, %rdi
 5277 4735 4D01E3   		addq	%r12, %r11
 5278              	.LVL161:
 5279 4738 0F1F8400 		.p2align 4,,10
 5279      00000000 
 5280              		.p2align 3
 5281              	.L134:
 398:sepia_filter.c ****     {
 399:sepia_filter.c ****         R_in[i] = pixels_in[3*i + 0];
 5282              		.loc 1 399 9 is_stmt 1 discriminator 3 view .LVU1392
 5283              		.loc 1 399 28 is_stmt 0 discriminator 3 view .LVU1393
 5284 4740 C5FE6F00 		vmovdqu	(%rax), %ymm0
 5285 4744 C5FE6F48 		vmovdqu	64(%rax), %ymm1
 5285      40
 5286 4749 C5FE6F50 		vmovdqu	32(%rax), %ymm2
 5286      20
 5287 474e C4427D00 		vpshufb	%ymm13, %ymm0, %ymm15
 5287      FD
 5288 4753 C443FD00 		vpermq	$78, %ymm15, %ymm15
 5288      FF4E
 5289 4759 C4C27D00 		vpshufb	%ymm12, %ymm0, %ymm3
 5289      DC
 5290 475e C4426D00 		vpshufb	%ymm11, %ymm2, %ymm14
 5290      F3
 5291 4763 C4C165EB 		vpor	%ymm15, %ymm3, %ymm3
 5291      DF
 5292 4768 C4427500 		vpshufb	%ymm10, %ymm1, %ymm15
 5292      FA
 5293 476d C4C165EB 		vpor	%ymm14, %ymm3, %ymm3
 5293      DE
 5294 4772 C443FD00 		vpermq	$78, %ymm15, %ymm15
 5294      FF4E
 5295 4778 C4427500 		vpshufb	%ymm8, %ymm1, %ymm14
 5295      F0
 5296 477d C4410DEB 		vpor	%ymm15, %ymm14, %ymm14
 5296      F7
 5297 4782 C4C26500 		vpshufb	%ymm9, %ymm3, %ymm3
 5297      D9
 5298 4787 C4C165EB 		vpor	%ymm14, %ymm3, %ymm3
 5298      DE
 5299 478c C4627D00 		vpshufb	%ymm7, %ymm0, %ymm15
 5299      FF
 5300              		.loc 1 399 17 discriminator 3 view .LVU1394
 5301 4791 C5FD7F1E 		vmovdqa	%ymm3, (%rsi)
 400:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5302              		.loc 1 400 9 is_stmt 1 discriminator 3 view .LVU1395
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5303              		.loc 1 399 28 is_stmt 0 discriminator 3 view .LVU1396
 5304 4795 C443FD00 		vpermq	$78, %ymm15, %ymm15
 5304      FF4E
 5305 479b C4E27D00 		vpshufb	%ymm6, %ymm0, %ymm3
 5305      DE
 5306 47a0 C4626D00 		vpshufb	%ymm5, %ymm2, %ymm14
 5306      F5
 5307 47a5 C4C165EB 		vpor	%ymm15, %ymm3, %ymm3
 5307      DF
 5308 47aa C4627500 		vpshufb	.LC24(%rip), %ymm1, %ymm15
 5308      3D000000 
 5308      00
 5309 47b3 C4C165EB 		vpor	%ymm14, %ymm3, %ymm3
 5309      DE
 5310 47b8 C443FD00 		vpermq	$78, %ymm15, %ymm15
 5310      FF4E
 5311 47be C4627500 		vpshufb	.LC26(%rip), %ymm1, %ymm14
 5311      35000000 
 5311      00
 5312 47c7 C4E26500 		vpshufb	%ymm4, %ymm3, %ymm3
 5312      DC
 5313 47cc C4410DEB 		vpor	%ymm15, %ymm14, %ymm14
 5313      F7
 5314 47d1 C4C165EB 		vpor	%ymm14, %ymm3, %ymm3
 5314      DE
 5315              		.loc 1 400 17 discriminator 3 view .LVU1397
 5316 47d6 C4C17E7F 		vmovdqu	%ymm3, (%r10)
 5316      1A
 401:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5317              		.loc 1 401 9 is_stmt 1 discriminator 3 view .LVU1398
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5318              		.loc 1 399 28 is_stmt 0 discriminator 3 view .LVU1399
 5319 47db C4E27D00 		vpshufb	.LC27(%rip), %ymm0, %ymm3
 5319      1D000000 
 5319      00
 5320 47e4 C4E3FD00 		vpermq	$78, %ymm3, %ymm3
 5320      DB4E
 5321 47ea C4E27D00 		vpshufb	.LC28(%rip), %ymm0, %ymm0
 5321      05000000 
 5321      00
 5322 47f3 C4E26D00 		vpshufb	.LC29(%rip), %ymm2, %ymm2
 5322      15000000 
 5322      00
 5323 47fc C5FDEBC3 		vpor	%ymm3, %ymm0, %ymm0
 5324 4800 C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 5325 4804 C4E27500 		vpshufb	.LC30(%rip), %ymm1, %ymm2
 5325      15000000 
 5325      00
 5326 480d C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 5326      D24E
 5327 4813 C4E27500 		vpshufb	.LC31(%rip), %ymm1, %ymm1
 5327      0D000000 
 5327      00
 5328 481c C4E27D00 		vpshufb	%ymm4, %ymm0, %ymm0
 5328      C4
 5329 4821 C5F5EBCA 		vpor	%ymm2, %ymm1, %ymm1
 5330 4825 C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 5331 4829 4883C620 		addq	$32, %rsi
 5332              		.loc 1 401 17 discriminator 3 view .LVU1400
 5333 482d C5FE7F07 		vmovdqu	%ymm0, (%rdi)
 397:sepia_filter.c ****     {
 5334              		.loc 1 397 40 is_stmt 1 discriminator 3 view .LVU1401
 397:sepia_filter.c ****     {
 5335              		.loc 1 397 5 discriminator 3 view .LVU1402
 5336 4831 4883C060 		addq	$96, %rax
 5337 4835 4983C220 		addq	$32, %r10
 5338 4839 4883C720 		addq	$32, %rdi
 5339 483d 4939F3   		cmpq	%rsi, %r11
 5340 4840 0F85FAFE 		jne	.L134
 5340      FFFF
 5341 4846 4489F8   		movl	%r15d, %eax
 5342 4849 83E0E0   		andl	$-32, %eax
 5343 484c 48894DB0 		movq	%rcx, -80(%rbp)
 5344              	.LVL162:
 397:sepia_filter.c ****     {
 5345              		.loc 1 397 5 is_stmt 0 discriminator 3 view .LVU1403
 5346 4850 89C6     		movl	%eax, %esi
 5347 4852 4139C7   		cmpl	%eax, %r15d
 5348 4855 0F848214 		je	.L187
 5348      0000
 397:sepia_filter.c ****     {
 5349              		.loc 1 397 5 discriminator 3 view .LVU1404
 5350 485b C5F877   		vzeroupper
 5351              	.LVL163:
 5352              	.L133:
 397:sepia_filter.c ****     {
 5353              		.loc 1 397 5 discriminator 3 view .LVU1405
 5354 485e 4589FA   		movl	%r15d, %r10d
 5355 4861 4129F2   		subl	%esi, %r10d
 5356 4864 418D7AFF 		leal	-1(%r10), %edi
 5357 4868 83FF0E   		cmpl	$14, %edi
 5358 486b 0F86BB00 		jbe	.L136
 5358      0000
 5359 4871 488D3C76 		leaq	(%rsi,%rsi,2), %rdi
 5360 4875 4801D7   		addq	%rdx, %rdi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5361              		.loc 1 399 28 view .LVU1406
 5362 4878 C5FA6F07 		vmovdqu	(%rdi), %xmm0
 5363 487c C5FA6F57 		vmovdqu	16(%rdi), %xmm2
 5363      10
 5364 4881 C5FA6F4F 		vmovdqu	32(%rdi), %xmm1
 5364      20
 5365 4886 C4E26900 		vpshufb	.LC66(%rip), %xmm2, %xmm4
 5365      25000000 
 5365      00
 5366 488f C4E27900 		vpshufb	.LC65(%rip), %xmm0, %xmm3
 5366      1D000000 
 5366      00
 5367 4898 C5E1EBDC 		vpor	%xmm4, %xmm3, %xmm3
 5368 489c C5F96F25 		vmovdqa	.LC68(%rip), %xmm4
 5368      00000000 
 5369 48a4 C4E27100 		vpshufb	.LC67(%rip), %xmm1, %xmm5
 5369      2D000000 
 5369      00
 5370 48ad 488B8DC8 		movq	-312(%rbp), %rcx
 5370      FEFFFF
 5371 48b4 C4E3614C 		vpblendvb	%xmm4, %xmm5, %xmm3, %xmm3
 5371      DD40
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5372              		.loc 1 399 17 view .LVU1407
 5373 48ba C4C1797F 		vmovdqa	%xmm3, (%r12,%rsi)
 5373      1C34
 5374 48c0 4C8D1C31 		leaq	(%rcx,%rsi), %r11
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5375              		.loc 1 399 9 is_stmt 1 view .LVU1408
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5376              		.loc 1 400 9 view .LVU1409
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5377              		.loc 1 399 28 is_stmt 0 view .LVU1410
 5378 48c4 C4E26900 		vpshufb	.LC70(%rip), %xmm2, %xmm5
 5378      2D000000 
 5378      00
 5379 48cd C4E27900 		vpshufb	.LC69(%rip), %xmm0, %xmm3
 5379      1D000000 
 5379      00
 5380 48d6 4489D6   		movl	%r10d, %esi
 5381 48d9 C4E27900 		vpshufb	.LC72(%rip), %xmm0, %xmm0
 5381      05000000 
 5381      00
 5382 48e2 C4E26900 		vpshufb	.LC73(%rip), %xmm2, %xmm2
 5382      15000000 
 5382      00
 5383 48eb C5E1EBDD 		vpor	%xmm5, %xmm3, %xmm3
 5384 48ef 83E6F0   		andl	$-16, %esi
 5385 48f2 C4E27100 		vpshufb	.LC71(%rip), %xmm1, %xmm5
 5385      2D000000 
 5385      00
 5386 48fb C5F9EBC2 		vpor	%xmm2, %xmm0, %xmm0
 5387 48ff C4E27100 		vpshufb	.LC74(%rip), %xmm1, %xmm1
 5387      0D000000 
 5387      00
 5388 4908 C4E3614C 		vpblendvb	%xmm4, %xmm5, %xmm3, %xmm3
 5388      DD40
 5389 490e C4E3790E 		vpblendw	$224, %xmm1, %xmm0, %xmm0
 5389      C1E0
 5390 4914 01F0     		addl	%esi, %eax
 5391 4916 4183E20F 		andl	$15, %r10d
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5392              		.loc 1 400 17 view .LVU1411
 5393 491a C4817A7F 		vmovdqu	%xmm3, (%r12,%r11)
 5393      1C1C
 5394              		.loc 1 401 9 is_stmt 1 view .LVU1412
 5395              		.loc 1 401 17 is_stmt 0 view .LVU1413
 5396 4920 C4817A7F 		vmovdqu	%xmm0, (%r14,%r11)
 5396      041E
 397:sepia_filter.c ****     {
 5397              		.loc 1 397 40 is_stmt 1 view .LVU1414
 397:sepia_filter.c ****     {
 5398              		.loc 1 397 5 view .LVU1415
 5399 4926 0F84DC02 		je	.L132
 5399      0000
 5400              	.L136:
 5401              	.LVL164:
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5402              		.loc 1 399 9 view .LVU1416
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5403              		.loc 1 399 30 is_stmt 0 view .LVU1417
 5404 492c 448D1440 		leal	(%rax,%rax,2), %r10d
 5405 4930 4963FA   		movslq	%r10d, %rdi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5406              		.loc 1 399 17 view .LVU1418
 5407 4933 440FB61C 		movzbl	(%rdx,%rdi), %r11d
 5407      3A
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5408              		.loc 1 399 13 view .LVU1419
 5409 4938 4863F0   		movslq	%eax, %rsi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5410              		.loc 1 399 17 view .LVU1420
 5411 493b 45881C34 		movb	%r11b, (%r12,%rsi)
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5412              		.loc 1 400 9 is_stmt 1 view .LVU1421
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5413              		.loc 1 400 17 is_stmt 0 view .LVU1422
 5414 493f 440FB65C 		movzbl	1(%rdx,%rdi), %r11d
 5414      3A01
 5415              		.loc 1 401 17 view .LVU1423
 5416 4945 0FB67C3A 		movzbl	2(%rdx,%rdi), %edi
 5416      02
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5417              		.loc 1 400 17 view .LVU1424
 5418 494a 45881C36 		movb	%r11b, (%r14,%rsi)
 5419              		.loc 1 401 9 is_stmt 1 view .LVU1425
 5420              		.loc 1 401 17 is_stmt 0 view .LVU1426
 5421 494e 41883C30 		movb	%dil, (%r8,%rsi)
 397:sepia_filter.c ****     {
 5422              		.loc 1 397 40 is_stmt 1 view .LVU1427
 5423 4952 8D7001   		leal	1(%rax), %esi
 5424              	.LVL165:
 397:sepia_filter.c ****     {
 5425              		.loc 1 397 5 view .LVU1428
 5426 4955 4139F7   		cmpl	%esi, %r15d
 5427 4958 0F8EAA02 		jle	.L132
 5427      0000
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5428              		.loc 1 399 9 view .LVU1429
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5429              		.loc 1 399 30 is_stmt 0 view .LVU1430
 5430 495e 418D7A03 		leal	3(%r10), %edi
 5431 4962 4863FF   		movslq	%edi, %rdi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5432              		.loc 1 399 17 view .LVU1431
 5433 4965 440FB61C 		movzbl	(%rdx,%rdi), %r11d
 5433      3A
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5434              		.loc 1 399 13 view .LVU1432
 5435 496a 4863F6   		movslq	%esi, %rsi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5436              		.loc 1 399 17 view .LVU1433
 5437 496d 45881C34 		movb	%r11b, (%r12,%rsi)
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5438              		.loc 1 400 9 is_stmt 1 view .LVU1434
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5439              		.loc 1 400 17 is_stmt 0 view .LVU1435
 5440 4971 440FB65C 		movzbl	1(%rdx,%rdi), %r11d
 5440      3A01
 5441              		.loc 1 401 17 view .LVU1436
 5442 4977 0FB67C3A 		movzbl	2(%rdx,%rdi), %edi
 5442      02
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5443              		.loc 1 400 17 view .LVU1437
 5444 497c 45881C36 		movb	%r11b, (%r14,%rsi)
 5445              		.loc 1 401 9 is_stmt 1 view .LVU1438
 5446              		.loc 1 401 17 is_stmt 0 view .LVU1439
 5447 4980 41883C30 		movb	%dil, (%r8,%rsi)
 397:sepia_filter.c ****     {
 5448              		.loc 1 397 40 is_stmt 1 view .LVU1440
 5449 4984 8D7002   		leal	2(%rax), %esi
 5450              	.LVL166:
 397:sepia_filter.c ****     {
 5451              		.loc 1 397 5 view .LVU1441
 5452 4987 4139F7   		cmpl	%esi, %r15d
 5453 498a 0F8E7802 		jle	.L132
 5453      0000
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5454              		.loc 1 399 9 view .LVU1442
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5455              		.loc 1 399 30 is_stmt 0 view .LVU1443
 5456 4990 418D7A06 		leal	6(%r10), %edi
 5457 4994 4863FF   		movslq	%edi, %rdi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5458              		.loc 1 399 17 view .LVU1444
 5459 4997 440FB61C 		movzbl	(%rdx,%rdi), %r11d
 5459      3A
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5460              		.loc 1 399 13 view .LVU1445
 5461 499c 4863F6   		movslq	%esi, %rsi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5462              		.loc 1 399 17 view .LVU1446
 5463 499f 45881C34 		movb	%r11b, (%r12,%rsi)
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5464              		.loc 1 400 9 is_stmt 1 view .LVU1447
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5465              		.loc 1 400 17 is_stmt 0 view .LVU1448
 5466 49a3 440FB65C 		movzbl	1(%rdx,%rdi), %r11d
 5466      3A01
 5467              		.loc 1 401 17 view .LVU1449
 5468 49a9 0FB67C3A 		movzbl	2(%rdx,%rdi), %edi
 5468      02
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5469              		.loc 1 400 17 view .LVU1450
 5470 49ae 45881C36 		movb	%r11b, (%r14,%rsi)
 5471              		.loc 1 401 9 is_stmt 1 view .LVU1451
 5472              		.loc 1 401 17 is_stmt 0 view .LVU1452
 5473 49b2 41883C30 		movb	%dil, (%r8,%rsi)
 397:sepia_filter.c ****     {
 5474              		.loc 1 397 40 is_stmt 1 view .LVU1453
 5475 49b6 8D7003   		leal	3(%rax), %esi
 5476              	.LVL167:
 397:sepia_filter.c ****     {
 5477              		.loc 1 397 5 view .LVU1454
 5478 49b9 4139F7   		cmpl	%esi, %r15d
 5479 49bc 0F8E4602 		jle	.L132
 5479      0000
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5480              		.loc 1 399 9 view .LVU1455
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5481              		.loc 1 399 30 is_stmt 0 view .LVU1456
 5482 49c2 418D7A09 		leal	9(%r10), %edi
 5483 49c6 4863FF   		movslq	%edi, %rdi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5484              		.loc 1 399 17 view .LVU1457
 5485 49c9 440FB61C 		movzbl	(%rdx,%rdi), %r11d
 5485      3A
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5486              		.loc 1 399 13 view .LVU1458
 5487 49ce 4863F6   		movslq	%esi, %rsi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5488              		.loc 1 399 17 view .LVU1459
 5489 49d1 45881C34 		movb	%r11b, (%r12,%rsi)
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5490              		.loc 1 400 9 is_stmt 1 view .LVU1460
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5491              		.loc 1 400 17 is_stmt 0 view .LVU1461
 5492 49d5 440FB65C 		movzbl	1(%rdx,%rdi), %r11d
 5492      3A01
 5493              		.loc 1 401 17 view .LVU1462
 5494 49db 0FB67C3A 		movzbl	2(%rdx,%rdi), %edi
 5494      02
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5495              		.loc 1 400 17 view .LVU1463
 5496 49e0 45881C36 		movb	%r11b, (%r14,%rsi)
 5497              		.loc 1 401 9 is_stmt 1 view .LVU1464
 5498              		.loc 1 401 17 is_stmt 0 view .LVU1465
 5499 49e4 41883C30 		movb	%dil, (%r8,%rsi)
 397:sepia_filter.c ****     {
 5500              		.loc 1 397 40 is_stmt 1 view .LVU1466
 5501 49e8 8D7004   		leal	4(%rax), %esi
 5502              	.LVL168:
 397:sepia_filter.c ****     {
 5503              		.loc 1 397 5 view .LVU1467
 5504 49eb 4139F7   		cmpl	%esi, %r15d
 5505 49ee 0F8E1402 		jle	.L132
 5505      0000
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5506              		.loc 1 399 9 view .LVU1468
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5507              		.loc 1 399 30 is_stmt 0 view .LVU1469
 5508 49f4 418D7A0C 		leal	12(%r10), %edi
 5509 49f8 4863FF   		movslq	%edi, %rdi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5510              		.loc 1 399 17 view .LVU1470
 5511 49fb 440FB61C 		movzbl	(%rdx,%rdi), %r11d
 5511      3A
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5512              		.loc 1 399 13 view .LVU1471
 5513 4a00 4863F6   		movslq	%esi, %rsi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5514              		.loc 1 399 17 view .LVU1472
 5515 4a03 45881C34 		movb	%r11b, (%r12,%rsi)
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5516              		.loc 1 400 9 is_stmt 1 view .LVU1473
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5517              		.loc 1 400 17 is_stmt 0 view .LVU1474
 5518 4a07 440FB65C 		movzbl	1(%rdx,%rdi), %r11d
 5518      3A01
 5519              		.loc 1 401 17 view .LVU1475
 5520 4a0d 0FB67C3A 		movzbl	2(%rdx,%rdi), %edi
 5520      02
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5521              		.loc 1 400 17 view .LVU1476
 5522 4a12 45881C36 		movb	%r11b, (%r14,%rsi)
 5523              		.loc 1 401 9 is_stmt 1 view .LVU1477
 5524              		.loc 1 401 17 is_stmt 0 view .LVU1478
 5525 4a16 41883C30 		movb	%dil, (%r8,%rsi)
 397:sepia_filter.c ****     {
 5526              		.loc 1 397 40 is_stmt 1 view .LVU1479
 5527 4a1a 8D7005   		leal	5(%rax), %esi
 5528              	.LVL169:
 397:sepia_filter.c ****     {
 5529              		.loc 1 397 5 view .LVU1480
 5530 4a1d 4139F7   		cmpl	%esi, %r15d
 5531 4a20 0F8EE201 		jle	.L132
 5531      0000
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5532              		.loc 1 399 9 view .LVU1481
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5533              		.loc 1 399 30 is_stmt 0 view .LVU1482
 5534 4a26 418D7A0F 		leal	15(%r10), %edi
 5535 4a2a 4863FF   		movslq	%edi, %rdi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5536              		.loc 1 399 17 view .LVU1483
 5537 4a2d 440FB61C 		movzbl	(%rdx,%rdi), %r11d
 5537      3A
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5538              		.loc 1 399 13 view .LVU1484
 5539 4a32 4863F6   		movslq	%esi, %rsi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5540              		.loc 1 399 17 view .LVU1485
 5541 4a35 45881C34 		movb	%r11b, (%r12,%rsi)
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5542              		.loc 1 400 9 is_stmt 1 view .LVU1486
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5543              		.loc 1 400 17 is_stmt 0 view .LVU1487
 5544 4a39 440FB65C 		movzbl	1(%rdx,%rdi), %r11d
 5544      3A01
 5545              		.loc 1 401 17 view .LVU1488
 5546 4a3f 0FB67C3A 		movzbl	2(%rdx,%rdi), %edi
 5546      02
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5547              		.loc 1 400 17 view .LVU1489
 5548 4a44 45881C36 		movb	%r11b, (%r14,%rsi)
 5549              		.loc 1 401 9 is_stmt 1 view .LVU1490
 5550              		.loc 1 401 17 is_stmt 0 view .LVU1491
 5551 4a48 41883C30 		movb	%dil, (%r8,%rsi)
 397:sepia_filter.c ****     {
 5552              		.loc 1 397 40 is_stmt 1 view .LVU1492
 5553 4a4c 8D7006   		leal	6(%rax), %esi
 5554              	.LVL170:
 397:sepia_filter.c ****     {
 5555              		.loc 1 397 5 view .LVU1493
 5556 4a4f 4139F7   		cmpl	%esi, %r15d
 5557 4a52 0F8EB001 		jle	.L132
 5557      0000
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5558              		.loc 1 399 9 view .LVU1494
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5559              		.loc 1 399 30 is_stmt 0 view .LVU1495
 5560 4a58 418D7A12 		leal	18(%r10), %edi
 5561 4a5c 4863FF   		movslq	%edi, %rdi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5562              		.loc 1 399 17 view .LVU1496
 5563 4a5f 440FB61C 		movzbl	(%rdx,%rdi), %r11d
 5563      3A
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5564              		.loc 1 399 13 view .LVU1497
 5565 4a64 4863F6   		movslq	%esi, %rsi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5566              		.loc 1 399 17 view .LVU1498
 5567 4a67 45881C34 		movb	%r11b, (%r12,%rsi)
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5568              		.loc 1 400 9 is_stmt 1 view .LVU1499
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5569              		.loc 1 400 17 is_stmt 0 view .LVU1500
 5570 4a6b 440FB65C 		movzbl	1(%rdx,%rdi), %r11d
 5570      3A01
 5571              		.loc 1 401 17 view .LVU1501
 5572 4a71 0FB67C3A 		movzbl	2(%rdx,%rdi), %edi
 5572      02
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5573              		.loc 1 400 17 view .LVU1502
 5574 4a76 45881C36 		movb	%r11b, (%r14,%rsi)
 5575              		.loc 1 401 9 is_stmt 1 view .LVU1503
 5576              		.loc 1 401 17 is_stmt 0 view .LVU1504
 5577 4a7a 41883C30 		movb	%dil, (%r8,%rsi)
 397:sepia_filter.c ****     {
 5578              		.loc 1 397 40 is_stmt 1 view .LVU1505
 5579 4a7e 8D7007   		leal	7(%rax), %esi
 5580              	.LVL171:
 397:sepia_filter.c ****     {
 5581              		.loc 1 397 5 view .LVU1506
 5582 4a81 4139F7   		cmpl	%esi, %r15d
 5583 4a84 0F8E7E01 		jle	.L132
 5583      0000
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5584              		.loc 1 399 9 view .LVU1507
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5585              		.loc 1 399 30 is_stmt 0 view .LVU1508
 5586 4a8a 418D7A15 		leal	21(%r10), %edi
 5587 4a8e 4863FF   		movslq	%edi, %rdi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5588              		.loc 1 399 17 view .LVU1509
 5589 4a91 440FB61C 		movzbl	(%rdx,%rdi), %r11d
 5589      3A
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5590              		.loc 1 399 13 view .LVU1510
 5591 4a96 4863F6   		movslq	%esi, %rsi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5592              		.loc 1 399 17 view .LVU1511
 5593 4a99 45881C34 		movb	%r11b, (%r12,%rsi)
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5594              		.loc 1 400 9 is_stmt 1 view .LVU1512
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5595              		.loc 1 400 17 is_stmt 0 view .LVU1513
 5596 4a9d 440FB65C 		movzbl	1(%rdx,%rdi), %r11d
 5596      3A01
 5597              		.loc 1 401 17 view .LVU1514
 5598 4aa3 0FB67C3A 		movzbl	2(%rdx,%rdi), %edi
 5598      02
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5599              		.loc 1 400 17 view .LVU1515
 5600 4aa8 45881C36 		movb	%r11b, (%r14,%rsi)
 5601              		.loc 1 401 9 is_stmt 1 view .LVU1516
 5602              		.loc 1 401 17 is_stmt 0 view .LVU1517
 5603 4aac 41883C30 		movb	%dil, (%r8,%rsi)
 397:sepia_filter.c ****     {
 5604              		.loc 1 397 40 is_stmt 1 view .LVU1518
 5605 4ab0 8D7008   		leal	8(%rax), %esi
 5606              	.LVL172:
 397:sepia_filter.c ****     {
 5607              		.loc 1 397 5 view .LVU1519
 5608 4ab3 4139F7   		cmpl	%esi, %r15d
 5609 4ab6 0F8E4C01 		jle	.L132
 5609      0000
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5610              		.loc 1 399 9 view .LVU1520
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5611              		.loc 1 399 30 is_stmt 0 view .LVU1521
 5612 4abc 418D7A18 		leal	24(%r10), %edi
 5613 4ac0 4863FF   		movslq	%edi, %rdi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5614              		.loc 1 399 17 view .LVU1522
 5615 4ac3 440FB61C 		movzbl	(%rdx,%rdi), %r11d
 5615      3A
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5616              		.loc 1 399 13 view .LVU1523
 5617 4ac8 4863F6   		movslq	%esi, %rsi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5618              		.loc 1 399 17 view .LVU1524
 5619 4acb 45881C34 		movb	%r11b, (%r12,%rsi)
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5620              		.loc 1 400 9 is_stmt 1 view .LVU1525
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5621              		.loc 1 400 17 is_stmt 0 view .LVU1526
 5622 4acf 440FB65C 		movzbl	1(%rdx,%rdi), %r11d
 5622      3A01
 5623              		.loc 1 401 17 view .LVU1527
 5624 4ad5 0FB67C3A 		movzbl	2(%rdx,%rdi), %edi
 5624      02
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5625              		.loc 1 400 17 view .LVU1528
 5626 4ada 45881C36 		movb	%r11b, (%r14,%rsi)
 5627              		.loc 1 401 9 is_stmt 1 view .LVU1529
 5628              		.loc 1 401 17 is_stmt 0 view .LVU1530
 5629 4ade 41883C30 		movb	%dil, (%r8,%rsi)
 397:sepia_filter.c ****     {
 5630              		.loc 1 397 40 is_stmt 1 view .LVU1531
 5631 4ae2 8D7009   		leal	9(%rax), %esi
 5632              	.LVL173:
 397:sepia_filter.c ****     {
 5633              		.loc 1 397 5 view .LVU1532
 5634 4ae5 4139F7   		cmpl	%esi, %r15d
 5635 4ae8 0F8E1A01 		jle	.L132
 5635      0000
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5636              		.loc 1 399 9 view .LVU1533
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5637              		.loc 1 399 30 is_stmt 0 view .LVU1534
 5638 4aee 418D7A1B 		leal	27(%r10), %edi
 5639 4af2 4863FF   		movslq	%edi, %rdi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5640              		.loc 1 399 17 view .LVU1535
 5641 4af5 440FB61C 		movzbl	(%rdx,%rdi), %r11d
 5641      3A
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5642              		.loc 1 399 13 view .LVU1536
 5643 4afa 4863F6   		movslq	%esi, %rsi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5644              		.loc 1 399 17 view .LVU1537
 5645 4afd 45881C34 		movb	%r11b, (%r12,%rsi)
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5646              		.loc 1 400 9 is_stmt 1 view .LVU1538
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5647              		.loc 1 400 17 is_stmt 0 view .LVU1539
 5648 4b01 440FB65C 		movzbl	1(%rdx,%rdi), %r11d
 5648      3A01
 5649              		.loc 1 401 17 view .LVU1540
 5650 4b07 0FB67C3A 		movzbl	2(%rdx,%rdi), %edi
 5650      02
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5651              		.loc 1 400 17 view .LVU1541
 5652 4b0c 45881C36 		movb	%r11b, (%r14,%rsi)
 5653              		.loc 1 401 9 is_stmt 1 view .LVU1542
 5654              		.loc 1 401 17 is_stmt 0 view .LVU1543
 5655 4b10 41883C30 		movb	%dil, (%r8,%rsi)
 397:sepia_filter.c ****     {
 5656              		.loc 1 397 40 is_stmt 1 view .LVU1544
 5657 4b14 8D700A   		leal	10(%rax), %esi
 5658              	.LVL174:
 397:sepia_filter.c ****     {
 5659              		.loc 1 397 5 view .LVU1545
 5660 4b17 4139F7   		cmpl	%esi, %r15d
 5661 4b1a 0F8EE800 		jle	.L132
 5661      0000
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5662              		.loc 1 399 9 view .LVU1546
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5663              		.loc 1 399 30 is_stmt 0 view .LVU1547
 5664 4b20 418D7A1E 		leal	30(%r10), %edi
 5665 4b24 4863FF   		movslq	%edi, %rdi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5666              		.loc 1 399 17 view .LVU1548
 5667 4b27 440FB61C 		movzbl	(%rdx,%rdi), %r11d
 5667      3A
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5668              		.loc 1 399 13 view .LVU1549
 5669 4b2c 4863F6   		movslq	%esi, %rsi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5670              		.loc 1 399 17 view .LVU1550
 5671 4b2f 45881C34 		movb	%r11b, (%r12,%rsi)
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5672              		.loc 1 400 9 is_stmt 1 view .LVU1551
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5673              		.loc 1 400 17 is_stmt 0 view .LVU1552
 5674 4b33 440FB65C 		movzbl	1(%rdx,%rdi), %r11d
 5674      3A01
 5675              		.loc 1 401 17 view .LVU1553
 5676 4b39 0FB67C3A 		movzbl	2(%rdx,%rdi), %edi
 5676      02
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5677              		.loc 1 400 17 view .LVU1554
 5678 4b3e 45881C36 		movb	%r11b, (%r14,%rsi)
 5679              		.loc 1 401 9 is_stmt 1 view .LVU1555
 5680              		.loc 1 401 17 is_stmt 0 view .LVU1556
 5681 4b42 41883C30 		movb	%dil, (%r8,%rsi)
 397:sepia_filter.c ****     {
 5682              		.loc 1 397 40 is_stmt 1 view .LVU1557
 5683 4b46 8D700B   		leal	11(%rax), %esi
 5684              	.LVL175:
 397:sepia_filter.c ****     {
 5685              		.loc 1 397 5 view .LVU1558
 5686 4b49 4139F7   		cmpl	%esi, %r15d
 5687 4b4c 0F8EB600 		jle	.L132
 5687      0000
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5688              		.loc 1 399 9 view .LVU1559
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5689              		.loc 1 399 30 is_stmt 0 view .LVU1560
 5690 4b52 418D7A21 		leal	33(%r10), %edi
 5691 4b56 4863FF   		movslq	%edi, %rdi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5692              		.loc 1 399 17 view .LVU1561
 5693 4b59 440FB61C 		movzbl	(%rdx,%rdi), %r11d
 5693      3A
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5694              		.loc 1 399 13 view .LVU1562
 5695 4b5e 4863F6   		movslq	%esi, %rsi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5696              		.loc 1 399 17 view .LVU1563
 5697 4b61 45881C34 		movb	%r11b, (%r12,%rsi)
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5698              		.loc 1 400 9 is_stmt 1 view .LVU1564
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5699              		.loc 1 400 17 is_stmt 0 view .LVU1565
 5700 4b65 440FB65C 		movzbl	1(%rdx,%rdi), %r11d
 5700      3A01
 5701              		.loc 1 401 17 view .LVU1566
 5702 4b6b 0FB67C3A 		movzbl	2(%rdx,%rdi), %edi
 5702      02
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5703              		.loc 1 400 17 view .LVU1567
 5704 4b70 45881C36 		movb	%r11b, (%r14,%rsi)
 5705              		.loc 1 401 9 is_stmt 1 view .LVU1568
 5706              		.loc 1 401 17 is_stmt 0 view .LVU1569
 5707 4b74 41883C30 		movb	%dil, (%r8,%rsi)
 397:sepia_filter.c ****     {
 5708              		.loc 1 397 40 is_stmt 1 view .LVU1570
 5709 4b78 8D700C   		leal	12(%rax), %esi
 5710              	.LVL176:
 397:sepia_filter.c ****     {
 5711              		.loc 1 397 5 view .LVU1571
 5712 4b7b 4139F7   		cmpl	%esi, %r15d
 5713 4b7e 0F8E8400 		jle	.L132
 5713      0000
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5714              		.loc 1 399 9 view .LVU1572
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5715              		.loc 1 399 30 is_stmt 0 view .LVU1573
 5716 4b84 418D7A24 		leal	36(%r10), %edi
 5717 4b88 4863FF   		movslq	%edi, %rdi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5718              		.loc 1 399 17 view .LVU1574
 5719 4b8b 440FB61C 		movzbl	(%rdx,%rdi), %r11d
 5719      3A
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5720              		.loc 1 399 13 view .LVU1575
 5721 4b90 4863F6   		movslq	%esi, %rsi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5722              		.loc 1 399 17 view .LVU1576
 5723 4b93 45881C34 		movb	%r11b, (%r12,%rsi)
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5724              		.loc 1 400 9 is_stmt 1 view .LVU1577
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5725              		.loc 1 400 17 is_stmt 0 view .LVU1578
 5726 4b97 440FB65C 		movzbl	1(%rdx,%rdi), %r11d
 5726      3A01
 5727              		.loc 1 401 17 view .LVU1579
 5728 4b9d 0FB67C3A 		movzbl	2(%rdx,%rdi), %edi
 5728      02
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5729              		.loc 1 400 17 view .LVU1580
 5730 4ba2 45881C36 		movb	%r11b, (%r14,%rsi)
 5731              		.loc 1 401 9 is_stmt 1 view .LVU1581
 5732              		.loc 1 401 17 is_stmt 0 view .LVU1582
 5733 4ba6 41883C30 		movb	%dil, (%r8,%rsi)
 397:sepia_filter.c ****     {
 5734              		.loc 1 397 40 is_stmt 1 view .LVU1583
 5735 4baa 8D700D   		leal	13(%rax), %esi
 5736              	.LVL177:
 397:sepia_filter.c ****     {
 5737              		.loc 1 397 5 view .LVU1584
 5738 4bad 4139F7   		cmpl	%esi, %r15d
 5739 4bb0 7E56     		jle	.L132
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5740              		.loc 1 399 9 view .LVU1585
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5741              		.loc 1 399 30 is_stmt 0 view .LVU1586
 5742 4bb2 418D7A27 		leal	39(%r10), %edi
 5743 4bb6 4863FF   		movslq	%edi, %rdi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5744              		.loc 1 399 17 view .LVU1587
 5745 4bb9 440FB61C 		movzbl	(%rdx,%rdi), %r11d
 5745      3A
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5746              		.loc 1 399 13 view .LVU1588
 5747 4bbe 4863F6   		movslq	%esi, %rsi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5748              		.loc 1 399 17 view .LVU1589
 5749 4bc1 45881C34 		movb	%r11b, (%r12,%rsi)
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5750              		.loc 1 400 9 is_stmt 1 view .LVU1590
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5751              		.loc 1 400 17 is_stmt 0 view .LVU1591
 5752 4bc5 440FB65C 		movzbl	1(%rdx,%rdi), %r11d
 5752      3A01
 5753              		.loc 1 401 17 view .LVU1592
 5754 4bcb 0FB67C3A 		movzbl	2(%rdx,%rdi), %edi
 5754      02
 397:sepia_filter.c ****     {
 5755              		.loc 1 397 40 view .LVU1593
 5756 4bd0 83C00E   		addl	$14, %eax
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5757              		.loc 1 400 17 view .LVU1594
 5758 4bd3 45881C36 		movb	%r11b, (%r14,%rsi)
 5759              		.loc 1 401 9 is_stmt 1 view .LVU1595
 5760              		.loc 1 401 17 is_stmt 0 view .LVU1596
 5761 4bd7 41883C30 		movb	%dil, (%r8,%rsi)
 397:sepia_filter.c ****     {
 5762              		.loc 1 397 40 is_stmt 1 view .LVU1597
 5763              	.LVL178:
 397:sepia_filter.c ****     {
 5764              		.loc 1 397 5 view .LVU1598
 5765 4bdb 4139C7   		cmpl	%eax, %r15d
 5766 4bde 7E28     		jle	.L132
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5767              		.loc 1 399 9 view .LVU1599
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5768              		.loc 1 399 30 is_stmt 0 view .LVU1600
 5769 4be0 418D722A 		leal	42(%r10), %esi
 5770 4be4 4863F6   		movslq	%esi, %rsi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5771              		.loc 1 399 17 view .LVU1601
 5772 4be7 0FB63C32 		movzbl	(%rdx,%rsi), %edi
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5773              		.loc 1 399 13 view .LVU1602
 5774 4beb 4898     		cltq
 399:sepia_filter.c ****         G_in[i] = pixels_in[3*i + 1]; 
 5775              		.loc 1 399 17 view .LVU1603
 5776 4bed 41883C04 		movb	%dil, (%r12,%rax)
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5777              		.loc 1 400 9 is_stmt 1 view .LVU1604
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5778              		.loc 1 400 17 is_stmt 0 view .LVU1605
 5779 4bf1 0FB67C32 		movzbl	1(%rdx,%rsi), %edi
 5779      01
 5780              		.loc 1 401 17 view .LVU1606
 5781 4bf6 0FB65432 		movzbl	2(%rdx,%rsi), %edx
 5781      02
 400:sepia_filter.c ****         B_in[i] = pixels_in[3*i + 2];
 5782              		.loc 1 400 17 view .LVU1607
 5783 4bfb 41883C06 		movb	%dil, (%r14,%rax)
 5784              		.loc 1 401 9 is_stmt 1 view .LVU1608
 5785              		.loc 1 401 17 is_stmt 0 view .LVU1609
 5786 4bff 41881400 		movb	%dl, (%r8,%rax)
 397:sepia_filter.c ****     {
 5787              		.loc 1 397 40 is_stmt 1 view .LVU1610
 5788              	.LVL179:
 397:sepia_filter.c ****     {
 5789              		.loc 1 397 5 view .LVU1611
 5790              		.p2align 4,,10
 5791 4c03 0F1F4400 		.p2align 3
 5791      00
 5792              	.L132:
 397:sepia_filter.c ****     {
 5793              		.loc 1 397 5 is_stmt 0 view .LVU1612
 5794              	.LBE45:
 402:sepia_filter.c ****     }
 403:sepia_filter.c **** 
 404:sepia_filter.c ****     start_t = get_wall_time();
 5795              		.loc 1 404 15 view .LVU1613
 5796 4c08 31C0     		xorl	%eax, %eax
 5797 4c0a 4C898D50 		movq	%r9, -176(%rbp)
 5797      FFFFFF
 5798 4c11 4C898570 		movq	%r8, -144(%rbp)
 5798      FFFFFF
 5799              	.LVL180:
 5800              		.loc 1 404 5 is_stmt 1 view .LVU1614
 5801              		.loc 1 404 15 is_stmt 0 view .LVU1615
 5802 4c18 E8000000 		call	get_wall_time
 5802      00
 5803              	.LVL181:
 5804 4c1d 488B85C8 		movq	-312(%rbp), %rax
 5804      FEFFFF
 5805 4c24 4C8B8D50 		movq	-176(%rbp), %r9
 5805      FFFFFF
 5806 4c2b 4C01E8   		addq	%r13, %rax
 5807 4c2e 488985A0 		movq	%rax, -352(%rbp)
 5807      FEFFFF
 5808 4c35 4489F8   		movl	%r15d, %eax
 5809 4c38 C1E805   		shrl	$5, %eax
 5810 4c3b 48C1E005 		salq	$5, %rax
 5811 4c3f 48898598 		movq	%rax, -360(%rbp)
 5811      FEFFFF
 5812 4c46 4489F8   		movl	%r15d, %eax
 5813 4c49 83E0E0   		andl	$-32, %eax
 5814 4c4c 4C897590 		movq	%r14, -112(%rbp)
 5815              	.LVL182:
 5816              		.loc 1 404 15 view .LVU1616
 5817 4c50 8985C4FE 		movl	%eax, -316(%rbp)
 5817      FFFF
 5818 4c56 4C8BB570 		movq	-144(%rbp), %r14
 5818      FFFFFF
 5819              	.LVL183:
 5820              		.loc 1 404 15 view .LVU1617
 5821 4c5d 8985A8FE 		movl	%eax, -344(%rbp)
 5821      FFFF
 5822 4c63 C785C0FE 		movl	$10, -320(%rbp)
 5822      FFFF0A00 
 5822      0000
 5823 4c6d 4C898D70 		movq	%r9, -144(%rbp)
 5823      FFFFFF
 5824 4c74 C5FB1185 		vmovsd	%xmm0, -376(%rbp)
 5824      88FEFFFF 
 5825              	.LVL184:
 405:sepia_filter.c ****     for (int it=0; it < NITER; it++)
 5826              		.loc 1 405 5 is_stmt 1 view .LVU1618
 5827              	.LBB46:
 5828              		.loc 1 405 10 view .LVU1619
 5829              		.loc 1 405 23 view .LVU1620
 5830              	.L138:
 5831              	.LBB47:
 406:sepia_filter.c ****     {
 407:sepia_filter.c ****         /* COMPLETAR ... */
 408:sepia_filter.c ****         #pragma GCC ivdep
 409:sepia_filter.c ****         for (int i = 0; i < height*width; i++)
 5832              		.loc 1 409 9 view .LVU1621
 5833 4c7c 4585FF   		testl	%r15d, %r15d
 5834 4c7f 0F8EC90F 		jle	.L177
 5834      0000
 5835 4c85 4D89F0   		movq	%r14, %r8
 5836 4c88 4C8B8D70 		movq	-144(%rbp), %r9
 5836      FFFFFF
 5837 4c8f 4C8B7590 		movq	-112(%rbp), %r14
 5838 4c93 488B4DB0 		movq	-80(%rbp), %rcx
 5839              	.LVL185:
 5840 4c97 660F1F84 		.p2align 4,,10
 5840      00000000 
 5840      00
 5841              		.p2align 3
 5842              	.L147:
 5843              		.loc 1 409 9 is_stmt 0 view .LVU1622
 5844 4ca0 83BDACFE 		cmpl	$30, -340(%rbp)
 5844      FFFF1E
 5845 4ca7 0F86C50F 		jbe	.L156
 5845      0000
 410:sepia_filter.c ****         {
 411:sepia_filter.c ****             R_out[i] = (unsigned char) (fminf(MAXPIXV,
 5846              		.loc 1 411 24 view .LVU1623
 5847 4cad BAFF0000 		movl	$255, %edx
 5847      00
 5848 4cb2 C5F96EFA 		vmovd	%edx, %xmm7
 5849 4cb6 C4E27D79 		vpbroadcastw	%xmm7, %ymm7
 5849      FF
 5850 4cbb C4627D18 		vbroadcastss	.LC106(%rip), %ymm13
 5850      2D000000 
 5850      00
 5851 4cc4 C4627D18 		vbroadcastss	.LC4(%rip), %ymm12
 5851      25000000 
 5851      00
 5852 4ccd C4627D58 		vpbroadcastd	.LC112(%rip), %ymm15
 5852      3D000000 
 5852      00
 5853 4cd6 488B95A0 		movq	-352(%rbp), %rdx
 5853      FEFFFF
 5854 4cdd 488BB598 		movq	-360(%rbp), %rsi
 5854      FEFFFF
 5855              	.LBE47:
 5856              	.LBE46:
 5857              	.LBB50:
 397:sepia_filter.c ****     {
 5858              		.loc 1 397 14 view .LVU1624
 5859 4ce4 31C0     		xorl	%eax, %eax
 5860              	.LBE50:
 5861              	.LBB51:
 5862              	.LBB48:
 5863              		.loc 1 411 24 view .LVU1625
 5864 4ce6 C5FD7F7D 		vmovdqa	%ymm7, -80(%rbp)
 5864      B0
 5865 4ceb 0F1F4400 		.p2align 4,,10
 5865      00
 5866              		.p2align 3
 5867              	.L140:
 5868              		.loc 1 411 13 is_stmt 1 discriminator 3 view .LVU1626
 412:sepia_filter.c ****                           0.5f +
 413:sepia_filter.c ****                           sepia[0][0]*R_in[i] + 
 5869              		.loc 1 413 43 is_stmt 0 discriminator 3 view .LVU1627
 5870 4cf0 C4C17D6F 		vmovdqa	(%r12,%rax), %ymm0
 5870      0404
 5871 4cf6 C4E27D30 		vpmovzxbw	%xmm0, %ymm1
 5871      C8
 5872 4cfb C4E27D33 		vpmovzxwd	%xmm1, %ymm2
 5872      D1
 5873 4d00 C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 5873      C001
 5874 4d06 C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 5874      C901
 5875 4d0c C4E27D30 		vpmovzxbw	%xmm0, %ymm0
 5875      C0
 5876 4d11 C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 5876      C9
 5877              		.loc 1 413 38 discriminator 3 view .LVU1628
 5878 4d16 C5FC5BD9 		vcvtdq2ps	%ymm1, %ymm3
 5879              		.loc 1 413 43 discriminator 3 view .LVU1629
 5880 4d1a C4E27D33 		vpmovzxwd	%xmm0, %ymm1
 5880      C8
 5881 4d1f C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 5881      C001
 5882 4d25 C4E27D33 		vpmovzxwd	%xmm0, %ymm0
 5882      C0
 5883              		.loc 1 413 38 discriminator 3 view .LVU1630
 5884 4d2a C5FC5BF8 		vcvtdq2ps	%ymm0, %ymm7
 414:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 5885              		.loc 1 414 43 discriminator 3 view .LVU1631
 5886 4d2e C4C17E6F 		vmovdqu	(%r14,%rax), %ymm0
 5886      0406
 413:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 5887              		.loc 1 413 38 discriminator 3 view .LVU1632
 5888 4d34 C57C5BD9 		vcvtdq2ps	%ymm1, %ymm11
 5889              		.loc 1 414 43 discriminator 3 view .LVU1633
 5890 4d38 C4E27D30 		vpmovzxbw	%xmm0, %ymm1
 5890      C8
 413:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 5891              		.loc 1 413 38 discriminator 3 view .LVU1634
 5892 4d3d C5FC5BE2 		vcvtdq2ps	%ymm2, %ymm4
 5893              		.loc 1 414 43 discriminator 3 view .LVU1635
 5894 4d41 C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 5894      C001
 5895 4d47 C4E27D33 		vpmovzxwd	%xmm1, %ymm2
 5895      D1
 5896 4d4c C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 5896      C901
 5897 4d52 C4E27D30 		vpmovzxbw	%xmm0, %ymm0
 5897      C0
 5898 4d57 C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 5898      C9
 5899              		.loc 1 414 38 discriminator 3 view .LVU1636
 5900 4d5c C5FC5BE9 		vcvtdq2ps	%ymm1, %ymm5
 5901              		.loc 1 414 43 discriminator 3 view .LVU1637
 5902 4d60 C4E27D33 		vpmovzxwd	%xmm0, %ymm1
 5902      C8
 5903              		.loc 1 414 38 discriminator 3 view .LVU1638
 5904 4d65 C5FC5BF2 		vcvtdq2ps	%ymm2, %ymm6
 5905              		.loc 1 414 43 discriminator 3 view .LVU1639
 5906 4d69 C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 5906      C001
 5907              		.loc 1 414 38 discriminator 3 view .LVU1640
 5908 4d6f C5FC5BD1 		vcvtdq2ps	%ymm1, %ymm2
 5909 4d73 C5CC590D 		vmulps	.LC32(%rip), %ymm6, %ymm1
 5909      00000000 
 5910              		.loc 1 414 43 discriminator 3 view .LVU1641
 5911 4d7b C4E27D33 		vpmovzxwd	%xmm0, %ymm0
 5911      C0
 5912              		.loc 1 414 38 discriminator 3 view .LVU1642
 5913 4d80 C5FC5BC0 		vcvtdq2ps	%ymm0, %ymm0
 5914 4d84 C57C590D 		vmulps	.LC32(%rip), %ymm0, %ymm9
 5914      00000000 
 5915 4d8c C56C5915 		vmulps	.LC32(%rip), %ymm2, %ymm10
 5915      00000000 
 5916 4d94 C5FC2995 		vmovaps	%ymm2, -304(%rbp)
 5916      D0FEFFFF 
 415:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 5917              		.loc 1 415 43 discriminator 3 view .LVU1643
 5918 4d9c C4C17E6F 		vmovdqu	(%r9,%rax), %ymm2
 5918      1401
 414:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 5919              		.loc 1 414 38 discriminator 3 view .LVU1644
 5920 4da2 C5FC29AD 		vmovaps	%ymm5, -272(%rbp)
 5920      F0FEFFFF 
 5921 4daa C5D4592D 		vmulps	.LC32(%rip), %ymm5, %ymm5
 5921      00000000 
 5922 4db2 C4E25DB8 		vfmadd231ps	.LC33(%rip), %ymm4, %ymm1
 5922      0D000000 
 5922      00
 5923 4dbb C5FC2965 		vmovaps	%ymm4, -112(%rbp)
 5923      90
 5924              		.loc 1 415 43 discriminator 3 view .LVU1645
 5925 4dc0 C4E27D30 		vpmovzxbw	%xmm2, %ymm4
 5925      E2
 5926 4dc5 C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 5926      D201
 5927 4dcb C4E27D30 		vpmovzxbw	%xmm2, %ymm2
 5927      D2
 5928 4dd0 C46245B8 		vfmadd231ps	.LC33(%rip), %ymm7, %ymm9
 5928      0D000000 
 5928      00
 5929 4dd9 C5FC29BD 		vmovaps	%ymm7, -208(%rbp)
 5929      30FFFFFF 
 5930 4de1 C4627D33 		vpmovzxwd	%xmm4, %ymm8
 5930      C4
 5931 4de6 C4E27D33 		vpmovzxwd	%xmm2, %ymm7
 5931      FA
 5932 4deb C4E37D39 		vextracti128	$0x1, %ymm4, %xmm4
 5932      E401
 5933 4df1 C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 5933      D201
 5934 4df7 C4E27D33 		vpmovzxwd	%xmm4, %ymm4
 5934      E4
 5935 4dfc C4E27D33 		vpmovzxwd	%xmm2, %ymm2
 5935      D2
 5936 4e01 C4E265B8 		vfmadd231ps	.LC33(%rip), %ymm3, %ymm5
 5936      2D000000 
 5936      00
 5937 4e0a C46225B8 		vfmadd231ps	.LC33(%rip), %ymm11, %ymm10
 5937      15000000 
 5937      00
 414:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 5938              		.loc 1 414 38 discriminator 3 view .LVU1646
 5939 4e13 C5FC29B5 		vmovaps	%ymm6, -240(%rbp)
 5939      10FFFFFF 
 5940 4e1b C5FC299D 		vmovaps	%ymm3, -144(%rbp)
 5940      70FFFFFF 
 5941              		.loc 1 415 38 discriminator 3 view .LVU1647
 5942 4e23 C4417C5B 		vcvtdq2ps	%ymm8, %ymm8
 5942      C0
 5943 4e28 C5FC5BE4 		vcvtdq2ps	%ymm4, %ymm4
 5944 4e2c C5FC5BFF 		vcvtdq2ps	%ymm7, %ymm7
 5945 4e30 C5FC5BD2 		vcvtdq2ps	%ymm2, %ymm2
 5946 4e34 C57C299D 		vmovaps	%ymm11, -176(%rbp)
 5946      50FFFFFF 
 5947 4e3c C4417C28 		vmovaps	%ymm8, %ymm14
 5947      F0
 5948 4e41 C57C28DC 		vmovaps	%ymm4, %ymm11
 5949 4e45 C5FC28DF 		vmovaps	%ymm7, %ymm3
 5950 4e49 C5FC28F2 		vmovaps	%ymm2, %ymm6
 5951 4e4d C4621598 		vfmadd132ps	.LC34(%rip), %ymm13, %ymm14
 5951      35000000 
 5951      00
 5952 4e56 C4621598 		vfmadd132ps	.LC34(%rip), %ymm13, %ymm11
 5952      1D000000 
 5952      00
 5953 4e5f C4E21598 		vfmadd132ps	.LC34(%rip), %ymm13, %ymm3
 5953      1D000000 
 5953      00
 5954 4e68 C4E21598 		vfmadd132ps	.LC34(%rip), %ymm13, %ymm6
 5954      35000000 
 5954      00
 411:sepia_filter.c ****                           0.5f +
 5955              		.loc 1 411 41 discriminator 3 view .LVU1648
 5956 4e71 C4C17458 		vaddps	%ymm14, %ymm1, %ymm1
 5956      CE
 5957 4e76 C4C15458 		vaddps	%ymm11, %ymm5, %ymm5
 5957      EB
 5958 4e7b C4C16458 		vaddps	%ymm10, %ymm3, %ymm3
 5958      DA
 5959 4e80 C4C14C58 		vaddps	%ymm9, %ymm6, %ymm6
 5959      F1
 5960 4e85 C4C1745D 		vminps	%ymm12, %ymm1, %ymm1
 5960      CC
 5961 4e8a C4C1545D 		vminps	%ymm12, %ymm5, %ymm5
 5961      EC
 5962 4e8f C4C1645D 		vminps	%ymm12, %ymm3, %ymm3
 5962      DC
 5963 4e94 C4C14C5D 		vminps	%ymm12, %ymm6, %ymm6
 5963      F4
 411:sepia_filter.c ****                           0.5f +
 5964              		.loc 1 411 24 discriminator 3 view .LVU1649
 5965 4e99 C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 5966 4e9d C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 5967 4ea1 C585DBC9 		vpand	%ymm1, %ymm15, %ymm1
 5968 4ea5 C585DBED 		vpand	%ymm5, %ymm15, %ymm5
 5969 4ea9 C5FE5BDB 		vcvttps2dq	%ymm3, %ymm3
 5970 4ead C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 5971 4eb1 C585DBDB 		vpand	%ymm3, %ymm15, %ymm3
 5972 4eb5 C585DBF6 		vpand	%ymm6, %ymm15, %ymm6
 5973 4eb9 C57D6F75 		vmovdqa	-80(%rbp), %ymm14
 5973      B0
 5974 4ebe C4E2752B 		vpackusdw	%ymm5, %ymm1, %ymm1
 5974      CD
 5975 4ec3 C4E2652B 		vpackusdw	%ymm6, %ymm3, %ymm3
 5975      DE
 5976 4ec8 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 5976      C9D8
 5977 4ece C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 5977      DBD8
 5978 4ed4 C4C165DB 		vpand	%ymm14, %ymm3, %ymm3
 5978      DE
 5979 4ed9 C4C175DB 		vpand	%ymm14, %ymm1, %ymm1
 5979      CE
 5980 4ede C5F567CB 		vpackuswb	%ymm3, %ymm1, %ymm1
 5981 4ee2 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 5981      C9D8
 411:sepia_filter.c ****                           0.5f +
 5982              		.loc 1 411 22 discriminator 3 view .LVU1650
 5983 4ee8 C5FD7F0C 		vmovdqa	%ymm1, (%rbx,%rax)
 5983      03
 416:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 5984              		.loc 1 416 13 is_stmt 1 discriminator 3 view .LVU1651
 417:sepia_filter.c ****                           0.5f +
 418:sepia_filter.c ****                           sepia[1][0]*R_in[i] + 
 419:sepia_filter.c ****                           sepia[1][1]*G_in[i] + 
 5985              		.loc 1 419 38 is_stmt 0 discriminator 3 view .LVU1652
 5986 4eed C5FC288D 		vmovaps	-240(%rbp), %ymm1
 5986      10FFFFFF 
 5987 4ef5 C5FC2875 		vmovaps	-112(%rbp), %ymm6
 5987      90
 5988 4efa C5F4590D 		vmulps	.LC40(%rip), %ymm1, %ymm1
 5988      00000000 
 5989 4f02 C5FC28AD 		vmovaps	-272(%rbp), %ymm5
 5989      F0FEFFFF 
 5990 4f0a C5FC289D 		vmovaps	-144(%rbp), %ymm3
 5990      70FFFFFF 
 5991 4f12 C4417C28 		vmovaps	%ymm8, %ymm9
 5991      C8
 5992 4f17 C4E24DB8 		vfmadd231ps	.LC41(%rip), %ymm6, %ymm1
 5992      0D000000 
 5992      00
 5993 4f20 C5D45935 		vmulps	.LC40(%rip), %ymm5, %ymm6
 5993      00000000 
 5994 4f28 C4E265B8 		vfmadd231ps	.LC41(%rip), %ymm3, %ymm6
 5994      35000000 
 5994      00
 5995 4f31 C57C2895 		vmovaps	-304(%rbp), %ymm10
 5995      D0FEFFFF 
 5996 4f39 C4621598 		vfmadd132ps	.LC42(%rip), %ymm13, %ymm9
 5996      0D000000 
 5996      00
 5997 4f42 C5AC591D 		vmulps	.LC40(%rip), %ymm10, %ymm3
 5997      00000000 
 5998 4f4a C5FC28AD 		vmovaps	-176(%rbp), %ymm5
 5998      50FFFFFF 
 5999 4f52 C57C289D 		vmovaps	-208(%rbp), %ymm11
 5999      30FFFFFF 
 6000 4f5a C4621598 		vfmadd132ps	.LC45(%rip), %ymm13, %ymm8
 6000      05000000 
 6000      00
 6001 4f63 C4417C28 		vmovaps	%ymm9, %ymm14
 6001      F1
 6002 4f68 C57C28CC 		vmovaps	%ymm4, %ymm9
 6003 4f6c C4E255B8 		vfmadd231ps	.LC41(%rip), %ymm5, %ymm3
 6003      1D000000 
 6003      00
 6004 4f75 C4621598 		vfmadd132ps	.LC42(%rip), %ymm13, %ymm9
 6004      0D000000 
 6004      00
 6005 4f7e C5FC592D 		vmulps	.LC40(%rip), %ymm0, %ymm5
 6005      00000000 
 416:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 6006              		.loc 1 416 41 discriminator 3 view .LVU1653
 6007 4f86 C4C17458 		vaddps	%ymm14, %ymm1, %ymm1
 6007      CE
 416:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 6008              		.loc 1 416 24 discriminator 3 view .LVU1654
 6009 4f8b C57D6F75 		vmovdqa	-80(%rbp), %ymm14
 6009      B0
 420:sepia_filter.c ****                           sepia[1][2]*B_in[i]));
 421:sepia_filter.c ****             B_out[i] = (unsigned char) (fminf(MAXPIXV,
 422:sepia_filter.c ****                           0.5f +
 423:sepia_filter.c ****                           sepia[2][0]*R_in[i] + 
 424:sepia_filter.c ****                           sepia[2][1]*G_in[i] + 
 6010              		.loc 1 424 38 discriminator 3 view .LVU1655
 6011 4f90 C5FC5905 		vmulps	.LC43(%rip), %ymm0, %ymm0
 6011      00000000 
 416:sepia_filter.c ****                           0.5f +
 6012              		.loc 1 416 41 discriminator 3 view .LVU1656
 6013 4f98 C4C1745D 		vminps	%ymm12, %ymm1, %ymm1
 6013      CC
 6014 4f9d C4E225B8 		vfmadd231ps	.LC41(%rip), %ymm11, %ymm5
 6014      2D000000 
 6014      00
 6015 4fa6 C4417C28 		vmovaps	%ymm9, %ymm11
 6015      D9
 6016 4fab C57C28CF 		vmovaps	%ymm7, %ymm9
 6017 4faf C4621598 		vfmadd132ps	.LC42(%rip), %ymm13, %ymm9
 6017      0D000000 
 6017      00
 6018 4fb8 C4C14C58 		vaddps	%ymm11, %ymm6, %ymm6
 6018      F3
 416:sepia_filter.c ****                           0.5f +
 6019              		.loc 1 416 24 discriminator 3 view .LVU1657
 6020 4fbd C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 6021 4fc1 C585DBC9 		vpand	%ymm1, %ymm15, %ymm1
 416:sepia_filter.c ****                           0.5f +
 6022              		.loc 1 416 41 discriminator 3 view .LVU1658
 6023 4fc5 C4C14C5D 		vminps	%ymm12, %ymm6, %ymm6
 6023      F4
 6024 4fca C4417C28 		vmovaps	%ymm9, %ymm10
 6024      D1
 6025 4fcf C57C28CA 		vmovaps	%ymm2, %ymm9
 6026 4fd3 C4621598 		vfmadd132ps	.LC42(%rip), %ymm13, %ymm9
 6026      0D000000 
 6026      00
 6027 4fdc C4C16458 		vaddps	%ymm10, %ymm3, %ymm3
 6027      DA
 416:sepia_filter.c ****                           0.5f +
 6028              		.loc 1 416 24 discriminator 3 view .LVU1659
 6029 4fe1 C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 6030 4fe5 C585DBF6 		vpand	%ymm6, %ymm15, %ymm6
 416:sepia_filter.c ****                           0.5f +
 6031              		.loc 1 416 41 discriminator 3 view .LVU1660
 6032 4fe9 C4C1645D 		vminps	%ymm12, %ymm3, %ymm3
 6032      DC
 6033 4fee C4C15458 		vaddps	%ymm9, %ymm5, %ymm5
 6033      E9
 416:sepia_filter.c ****                           0.5f +
 6034              		.loc 1 416 24 discriminator 3 view .LVU1661
 6035 4ff3 C4E2752B 		vpackusdw	%ymm6, %ymm1, %ymm1
 6035      CE
 6036 4ff8 C5FE5BDB 		vcvttps2dq	%ymm3, %ymm3
 416:sepia_filter.c ****                           0.5f +
 6037              		.loc 1 416 41 discriminator 3 view .LVU1662
 6038 4ffc C4C1545D 		vminps	%ymm12, %ymm5, %ymm5
 6038      EC
 416:sepia_filter.c ****                           0.5f +
 6039              		.loc 1 416 24 discriminator 3 view .LVU1663
 6040 5001 C585DBDB 		vpand	%ymm3, %ymm15, %ymm3
 6041 5005 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 6041      C9D8
 6042 500b C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 6043 500f C585DBED 		vpand	%ymm5, %ymm15, %ymm5
 6044 5013 C4E2652B 		vpackusdw	%ymm5, %ymm3, %ymm3
 6044      DD
 6045 5018 C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 6045      DBD8
 6046 501e C4C165DB 		vpand	%ymm14, %ymm3, %ymm3
 6046      DE
 6047 5023 C4C175DB 		vpand	%ymm14, %ymm1, %ymm1
 6047      CE
 6048 5028 C5F567CB 		vpackuswb	%ymm3, %ymm1, %ymm1
 6049 502c C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 6049      C9D8
 416:sepia_filter.c ****                           0.5f +
 6050              		.loc 1 416 22 discriminator 3 view .LVU1664
 6051 5032 C4C17E7F 		vmovdqu	%ymm1, 0(%r13,%rax)
 6051      4C0500
 421:sepia_filter.c ****                           0.5f +
 6052              		.loc 1 421 13 is_stmt 1 discriminator 3 view .LVU1665
 6053              		.loc 1 424 38 is_stmt 0 discriminator 3 view .LVU1666
 6054 5039 C5FC288D 		vmovaps	-240(%rbp), %ymm1
 6054      10FFFFFF 
 6055 5041 C5FC2875 		vmovaps	-112(%rbp), %ymm6
 6055      90
 6056 5046 C5F4590D 		vmulps	.LC43(%rip), %ymm1, %ymm1
 6056      00000000 
 6057 504e C5FC289D 		vmovaps	-144(%rbp), %ymm3
 6057      70FFFFFF 
 6058 5056 C57C2895 		vmovaps	-304(%rbp), %ymm10
 6058      D0FEFFFF 
 6059 505e C4E21598 		vfmadd132ps	.LC45(%rip), %ymm13, %ymm4
 6059      25000000 
 6059      00
 6060 5067 C4E21598 		vfmadd132ps	.LC45(%rip), %ymm13, %ymm7
 6060      3D000000 
 6060      00
 6061 5070 C4E24DB8 		vfmadd231ps	.LC44(%rip), %ymm6, %ymm1
 6061      0D000000 
 6061      00
 6062 5079 C5FC28B5 		vmovaps	-272(%rbp), %ymm6
 6062      F0FEFFFF 
 6063 5081 C4E21598 		vfmadd132ps	.LC45(%rip), %ymm13, %ymm2
 6063      15000000 
 6063      00
 6064 508a C5CC592D 		vmulps	.LC43(%rip), %ymm6, %ymm5
 6064      00000000 
 6065 5092 C5FC28B5 		vmovaps	-176(%rbp), %ymm6
 6065      50FFFFFF 
 421:sepia_filter.c ****                           0.5f +
 6066              		.loc 1 421 41 discriminator 3 view .LVU1667
 6067 509a C4417458 		vaddps	%ymm8, %ymm1, %ymm8
 6067      C0
 6068 509f C4E265B8 		vfmadd231ps	.LC44(%rip), %ymm3, %ymm5
 6068      2D000000 
 6068      00
 6069              		.loc 1 424 38 discriminator 3 view .LVU1668
 6070 50a8 C5AC591D 		vmulps	.LC43(%rip), %ymm10, %ymm3
 6070      00000000 
 421:sepia_filter.c ****                           0.5f +
 6071              		.loc 1 421 41 discriminator 3 view .LVU1669
 6072 50b0 C4413C5D 		vminps	%ymm12, %ymm8, %ymm8
 6072      C4
 6073 50b5 C5D458EC 		vaddps	%ymm4, %ymm5, %ymm5
 6074 50b9 C4E24DB8 		vfmadd231ps	.LC44(%rip), %ymm6, %ymm3
 6074      1D000000 
 6074      00
 6075 50c2 C5FC28B5 		vmovaps	-208(%rbp), %ymm6
 6075      30FFFFFF 
 6076 50ca C4C1545D 		vminps	%ymm12, %ymm5, %ymm5
 6076      EC
 6077 50cf C4E27D98 		vfmadd132ps	.LC44(%rip), %ymm0, %ymm6
 6077      35000000 
 6077      00
 421:sepia_filter.c ****                           0.5f +
 6078              		.loc 1 421 24 discriminator 3 view .LVU1670
 6079 50d8 C4C17E5B 		vcvttps2dq	%ymm8, %ymm0
 6079      C0
 421:sepia_filter.c ****                           0.5f +
 6080              		.loc 1 421 41 discriminator 3 view .LVU1671
 6081 50dd C5E458DF 		vaddps	%ymm7, %ymm3, %ymm3
 421:sepia_filter.c ****                           0.5f +
 6082              		.loc 1 421 24 discriminator 3 view .LVU1672
 6083 50e1 C585DBC0 		vpand	%ymm0, %ymm15, %ymm0
 6084 50e5 C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 421:sepia_filter.c ****                           0.5f +
 6085              		.loc 1 421 41 discriminator 3 view .LVU1673
 6086 50e9 C5CC58F2 		vaddps	%ymm2, %ymm6, %ymm6
 6087 50ed C4C1645D 		vminps	%ymm12, %ymm3, %ymm3
 6087      DC
 421:sepia_filter.c ****                           0.5f +
 6088              		.loc 1 421 24 discriminator 3 view .LVU1674
 6089 50f2 C585DBED 		vpand	%ymm5, %ymm15, %ymm5
 421:sepia_filter.c ****                           0.5f +
 6090              		.loc 1 421 41 discriminator 3 view .LVU1675
 6091 50f6 C4C14C5D 		vminps	%ymm12, %ymm6, %ymm6
 6091      F4
 421:sepia_filter.c ****                           0.5f +
 6092              		.loc 1 421 24 discriminator 3 view .LVU1676
 6093 50fb C5FE5BCB 		vcvttps2dq	%ymm3, %ymm1
 6094 50ff C585DBC9 		vpand	%ymm1, %ymm15, %ymm1
 6095 5103 C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 6096 5107 C585DBF6 		vpand	%ymm6, %ymm15, %ymm6
 6097 510b C4E27D2B 		vpackusdw	%ymm5, %ymm0, %ymm0
 6097      C5
 6098 5110 C4E2752B 		vpackusdw	%ymm6, %ymm1, %ymm1
 6098      CE
 6099 5115 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 6099      C0D8
 6100 511b C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 6100      C9D8
 6101 5121 C4C17DDB 		vpand	%ymm14, %ymm0, %ymm0
 6101      C6
 6102 5126 C4C175DB 		vpand	%ymm14, %ymm1, %ymm1
 6102      CE
 6103 512b C5FD67C1 		vpackuswb	%ymm1, %ymm0, %ymm0
 6104 512f C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 6104      C0D8
 421:sepia_filter.c ****                           0.5f +
 6105              		.loc 1 421 22 discriminator 3 view .LVU1677
 6106 5135 C5FE7F04 		vmovdqu	%ymm0, (%rdx,%rax)
 6106      02
 409:sepia_filter.c ****         {
 6107              		.loc 1 409 44 is_stmt 1 discriminator 3 view .LVU1678
 409:sepia_filter.c ****         {
 6108              		.loc 1 409 9 discriminator 3 view .LVU1679
 6109 513a 4883C020 		addq	$32, %rax
 6110 513e 4839F0   		cmpq	%rsi, %rax
 6111 5141 0F85A9FB 		jne	.L140
 6111      FFFF
 6112 5147 8B85C4FE 		movl	-316(%rbp), %eax
 6112      FFFF
 6113 514d 4139C7   		cmpl	%eax, %r15d
 6114 5150 0F84250B 		je	.L141
 6114      0000
 421:sepia_filter.c ****                           0.5f +
 6115              		.loc 1 421 22 is_stmt 0 view .LVU1680
 6116 5156 89C2     		movl	%eax, %edx
 6117 5158 C5F877   		vzeroupper
 6118              	.LVL186:
 6119              	.L139:
 421:sepia_filter.c ****                           0.5f +
 6120              		.loc 1 421 22 view .LVU1681
 6121 515b 4489FF   		movl	%r15d, %edi
 6122 515e 29D7     		subl	%edx, %edi
 6123 5160 8D77FF   		leal	-1(%rdi), %esi
 6124 5163 83FE0E   		cmpl	$14, %esi
 6125 5166 0F86F003 		jbe	.L142
 6125      0000
 411:sepia_filter.c ****                           0.5f +
 6126              		.loc 1 411 13 is_stmt 1 view .LVU1682
 413:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 6127              		.loc 1 413 43 is_stmt 0 view .LVU1683
 6128 516c C4C1796F 		vmovdqa	(%r12,%rdx), %xmm1
 6128      0C14
 6129 5172 4C8B95C8 		movq	-312(%rbp), %r10
 6129      FEFFFF
 6130 5179 C4E27930 		vpmovzxbw	%xmm1, %xmm2
 6130      D1
 6131 517e C4E27933 		vpmovzxwd	%xmm2, %xmm0
 6131      C2
 6132 5183 C5F173D9 		vpsrldq	$8, %xmm1, %xmm1
 6132      08
 6133 5188 C5E973DA 		vpsrldq	$8, %xmm2, %xmm2
 6133      08
 6134 518d C4E27930 		vpmovzxbw	%xmm1, %xmm1
 6134      C9
 6135 5192 C4E27933 		vpmovzxwd	%xmm2, %xmm2
 6135      D2
 413:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 6136              		.loc 1 413 38 view .LVU1684
 6137 5197 C5785BFA 		vcvtdq2ps	%xmm2, %xmm15
 6138 519b 498D3412 		leaq	(%r10,%rdx), %rsi
 413:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 6139              		.loc 1 413 43 view .LVU1685
 6140 519f C4E27933 		vpmovzxwd	%xmm1, %xmm2
 6140      D1
 6141 51a4 C5F173D9 		vpsrldq	$8, %xmm1, %xmm1
 6141      08
 6142 51a9 C4E27918 		vbroadcastss	.LC106(%rip), %xmm5
 6142      2D000000 
 6142      00
 413:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 6143              		.loc 1 413 38 view .LVU1686
 6144 51b2 C5785BF2 		vcvtdq2ps	%xmm2, %xmm14
 414:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 6145              		.loc 1 414 43 view .LVU1687
 6146 51b6 C4C17A6F 		vmovdqu	(%r12,%rsi), %xmm3
 6146      1C34
 6147 51bc C4E27918 		vbroadcastss	.LC2(%rip), %xmm2
 6147      15000000 
 6147      00
 413:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 6148              		.loc 1 413 43 view .LVU1688
 6149 51c5 C4E27933 		vpmovzxwd	%xmm1, %xmm1
 6149      C9
 413:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 6150              		.loc 1 413 38 view .LVU1689
 6151 51ca C5F85BF9 		vcvtdq2ps	%xmm1, %xmm7
 6152 51ce C5F85BC0 		vcvtdq2ps	%xmm0, %xmm0
 6153 51d2 C57829F9 		vmovaps	%xmm15, %xmm1
 6154 51d6 C5F828E0 		vmovaps	%xmm0, %xmm4
 6155 51da C57829F6 		vmovaps	%xmm14, %xmm6
 6156 51de C4E25198 		vfmadd132ps	%xmm2, %xmm5, %xmm4
 6156      E2
 6157 51e3 C4E25198 		vfmadd132ps	%xmm2, %xmm5, %xmm1
 6157      CA
 6158 51e8 C4E25198 		vfmadd132ps	%xmm2, %xmm5, %xmm6
 6158      F2
 6159 51ed C5F829BD 		vmovaps	%xmm7, -208(%rbp)
 6159      30FFFFFF 
 6160 51f5 C4E25198 		vfmadd132ps	%xmm7, %xmm5, %xmm2
 6160      D7
 414:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 6161              		.loc 1 414 43 view .LVU1690
 6162 51fa C4E27930 		vpmovzxbw	%xmm3, %xmm7
 6162      FB
 6163 51ff C4627933 		vpmovzxwd	%xmm7, %xmm8
 6163      C7
 6164 5204 C5E173DB 		vpsrldq	$8, %xmm3, %xmm3
 6164      08
 6165 5209 C5C173DF 		vpsrldq	$8, %xmm7, %xmm7
 6165      08
 6166 520e 4901F2   		addq	%rsi, %r10
 6167 5211 C4E27930 		vpmovzxbw	%xmm3, %xmm3
 6167      DB
 6168 5216 C4E27933 		vpmovzxwd	%xmm7, %xmm7
 6168      FF
 414:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 6169              		.loc 1 414 38 view .LVU1691
 6170 521b C441785B 		vcvtdq2ps	%xmm8, %xmm10
 6170      D0
 415:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 6171              		.loc 1 415 43 view .LVU1692
 6172 5220 C4017A6F 		vmovdqu	(%r12,%r10), %xmm9
 6172      0C14
 414:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 6173              		.loc 1 414 38 view .LVU1693
 6174 5226 C5785BC7 		vcvtdq2ps	%xmm7, %xmm8
 414:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 6175              		.loc 1 414 43 view .LVU1694
 6176 522a C4E27933 		vpmovzxwd	%xmm3, %xmm7
 6176      FB
 6177 522f C5E173DB 		vpsrldq	$8, %xmm3, %xmm3
 6177      08
 6178 5234 C4E27933 		vpmovzxwd	%xmm3, %xmm3
 6178      DB
 414:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 6179              		.loc 1 414 38 view .LVU1695
 6180 5239 C5F85BDB 		vcvtdq2ps	%xmm3, %xmm3
 6181 523d C5F8299D 		vmovaps	%xmm3, -144(%rbp)
 6181      70FFFFFF 
 415:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 6182              		.loc 1 415 43 view .LVU1696
 6183 5245 C4C27930 		vpmovzxbw	%xmm9, %xmm3
 6183      D9
 6184 524a C4C13173 		vpsrldq	$8, %xmm9, %xmm9
 6184      D908
 6185 5250 C4427930 		vpmovzxbw	%xmm9, %xmm9
 6185      C9
 414:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 6186              		.loc 1 414 38 view .LVU1697
 6187 5255 C5785BE7 		vcvtdq2ps	%xmm7, %xmm12
 415:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 6188              		.loc 1 415 43 view .LVU1698
 6189 5259 C4C27933 		vpmovzxwd	%xmm9, %xmm7
 6189      F9
 6190 525e C4C13173 		vpsrldq	$8, %xmm9, %xmm9
 6190      D908
 6191 5264 C4427933 		vpmovzxwd	%xmm9, %xmm9
 6191      C9
 415:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 6192              		.loc 1 415 38 view .LVU1699
 6193 5269 C441785B 		vcvtdq2ps	%xmm9, %xmm13
 6193      E9
 6194 526e C4627918 		vbroadcastss	.LC3(%rip), %xmm9
 6194      0D000000 
 6194      00
 414:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 6195              		.loc 1 414 38 view .LVU1700
 6196 5277 C5782945 		vmovaps	%xmm8, -80(%rbp)
 6196      B0
 415:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 6197              		.loc 1 415 43 view .LVU1701
 6198 527c C4627933 		vpmovzxwd	%xmm3, %xmm8
 6198      C3
 414:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 6199              		.loc 1 414 38 view .LVU1702
 6200 5281 C5782965 		vmovaps	%xmm12, -112(%rbp)
 6200      90
 415:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 6201              		.loc 1 415 38 view .LVU1703
 6202 5286 C441785B 		vcvtdq2ps	%xmm8, %xmm8
 6202      C0
 6203 528b C4413859 		vmulps	%xmm9, %xmm8, %xmm12
 6203      E1
 6204 5290 C57829AD 		vmovaps	%xmm13, -176(%rbp)
 6204      50FFFFFF 
 415:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 6205              		.loc 1 415 43 view .LVU1704
 6206 5298 C5E173DB 		vpsrldq	$8, %xmm3, %xmm3
 6206      08
 6207 529d C4627918 		vbroadcastss	.LC1(%rip), %xmm13
 6207      2D000000 
 6207      00
 6208 52a6 C4E27933 		vpmovzxwd	%xmm3, %xmm3
 6208      DB
 6209 52ab C44211B8 		vfmadd231ps	%xmm10, %xmm13, %xmm12
 6209      E2
 6210 52b0 C5782995 		vmovaps	%xmm10, -240(%rbp)
 6210      10FFFFFF 
 415:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 6211              		.loc 1 415 38 view .LVU1705
 6212 52b8 C5F85BDB 		vcvtdq2ps	%xmm3, %xmm3
 6213 52bc C5F85BFF 		vcvtdq2ps	%xmm7, %xmm7
 6214 52c0 C4416059 		vmulps	%xmm9, %xmm3, %xmm11
 6214      D9
 6215 52c5 C4414059 		vmulps	%xmm9, %xmm7, %xmm10
 6215      D1
 6216 52ca C530598D 		vmulps	-176(%rbp), %xmm9, %xmm9
 6216      50FFFFFF 
 411:sepia_filter.c ****                           0.5f +
 6217              		.loc 1 411 41 view .LVU1706
 6218 52d2 C4415858 		vaddps	%xmm12, %xmm4, %xmm12
 6218      E4
 6219 52d7 C4E27918 		vbroadcastss	.LC4(%rip), %xmm4
 6219      25000000 
 6219      00
 6220 52e0 C46211B8 		vfmadd231ps	-80(%rbp), %xmm13, %xmm11
 6220      5DB0
 6221 52e6 C46211B8 		vfmadd231ps	-112(%rbp), %xmm13, %xmm10
 6221      5590
 6222 52ec C46211B8 		vfmadd231ps	-144(%rbp), %xmm13, %xmm9
 6222      8D70FFFF 
 6222      FF
 6223 52f5 C5185DE4 		vminps	%xmm4, %xmm12, %xmm12
 411:sepia_filter.c ****                           0.5f +
 6224              		.loc 1 411 24 view .LVU1707
 6225 52f9 41BBFF00 		movl	$255, %r11d
 6225      0000
 411:sepia_filter.c ****                           0.5f +
 6226              		.loc 1 411 41 view .LVU1708
 6227 52ff C4C17058 		vaddps	%xmm11, %xmm1, %xmm1
 6227      CB
 6228 5304 C4C14858 		vaddps	%xmm10, %xmm6, %xmm6
 6228      F2
 6229 5309 C4C16858 		vaddps	%xmm9, %xmm2, %xmm2
 6229      D1
 6230 530e C5F05DCC 		vminps	%xmm4, %xmm1, %xmm1
 6231 5312 C5C85DF4 		vminps	%xmm4, %xmm6, %xmm6
 6232 5316 C5E85DD4 		vminps	%xmm4, %xmm2, %xmm2
 411:sepia_filter.c ****                           0.5f +
 6233              		.loc 1 411 24 view .LVU1709
 6234 531a C4417A5B 		vcvttps2dq	%xmm12, %xmm12
 6234      E4
 6235 531f C5FA5BF6 		vcvttps2dq	%xmm6, %xmm6
 6236 5323 C5FA5BD2 		vcvttps2dq	%xmm2, %xmm2
 6237 5327 C5C9DB35 		vpand	.LC81(%rip), %xmm6, %xmm6
 6237      00000000 
 6238 532f C5E9DB15 		vpand	.LC81(%rip), %xmm2, %xmm2
 6238      00000000 
 6239 5337 C519DB25 		vpand	.LC81(%rip), %xmm12, %xmm12
 6239      00000000 
 6240 533f C5FA5BC9 		vcvttps2dq	%xmm1, %xmm1
 6241 5343 C5F1DB0D 		vpand	.LC81(%rip), %xmm1, %xmm1
 6241      00000000 
 6242 534b C4E2492B 		vpackusdw	%xmm2, %xmm6, %xmm2
 6242      D2
 6243 5350 C4C1796E 		vmovd	%r11d, %xmm6
 6243      F3
 6244 5355 C4E27979 		vpbroadcastw	%xmm6, %xmm6
 6244      F6
 6245 535a C462192B 		vpackusdw	%xmm1, %xmm12, %xmm12
 6245      E1
 6246 535f C5C9DBD2 		vpand	%xmm2, %xmm6, %xmm2
 6247 5363 C44149DB 		vpand	%xmm12, %xmm6, %xmm12
 6247      E4
 6248 5368 C51967E2 		vpackuswb	%xmm2, %xmm12, %xmm12
 411:sepia_filter.c ****                           0.5f +
 6249              		.loc 1 411 22 view .LVU1710
 6250 536c C5797F24 		vmovdqa	%xmm12, (%rbx,%rdx)
 6250      13
 416:sepia_filter.c ****                           0.5f +
 6251              		.loc 1 416 13 is_stmt 1 view .LVU1711
 420:sepia_filter.c ****             B_out[i] = (unsigned char) (fminf(MAXPIXV,
 6252              		.loc 1 420 38 is_stmt 0 view .LVU1712
 6253 5371 C4627918 		vbroadcastss	.LC9(%rip), %xmm12
 6253      25000000 
 6253      00
 6254 537a C57829BD 		vmovaps	%xmm15, -272(%rbp)
 6254      F0FEFFFF 
 6255 5382 C4414059 		vmulps	%xmm12, %xmm7, %xmm13
 6255      EC
 6256 5387 C4417828 		vmovaps	%xmm15, %xmm10
 6256      D7
 6257 538c C57829B5 		vmovaps	%xmm14, -304(%rbp)
 6257      D0FEFFFF 
 6258 5394 C4413859 		vmulps	%xmm12, %xmm8, %xmm15
 6258      FC
 6259 5399 C4417828 		vmovaps	%xmm14, %xmm9
 6259      CE
 6260 539e C4416059 		vmulps	%xmm12, %xmm3, %xmm14
 6260      F4
 6261 53a3 C4E27918 		vbroadcastss	.LC8(%rip), %xmm1
 6261      0D000000 
 6261      00
 6262 53ac C4627918 		vbroadcastss	.LC7(%rip), %xmm11
 6262      1D000000 
 6262      00
 6263 53b5 C5F828D0 		vmovaps	%xmm0, %xmm2
 6264 53b9 C4E25198 		vfmadd132ps	%xmm1, %xmm5, %xmm2
 6264      D1
 6265 53be C4625198 		vfmadd132ps	%xmm1, %xmm5, %xmm10
 6265      D1
 6266 53c3 C4625198 		vfmadd132ps	%xmm1, %xmm5, %xmm9
 6266      C9
 6267 53c8 C46221B8 		vfmadd231ps	-240(%rbp), %xmm11, %xmm15
 6267      BD10FFFF 
 6267      FF
 6268 53d1 C4E25198 		vfmadd132ps	-208(%rbp), %xmm5, %xmm1
 6268      8D30FFFF 
 6268      FF
 6269 53da C46221B8 		vfmadd231ps	-80(%rbp), %xmm11, %xmm14
 6269      75B0
 6270 53e0 C46221B8 		vfmadd231ps	-112(%rbp), %xmm11, %xmm13
 6270      6D90
 6271 53e6 C51859A5 		vmulps	-176(%rbp), %xmm12, %xmm12
 6271      50FFFFFF 
 416:sepia_filter.c ****                           0.5f +
 6272              		.loc 1 416 41 view .LVU1713
 6273 53ee C4C16858 		vaddps	%xmm15, %xmm2, %xmm2
 6273      D7
 6274 53f3 89FA     		movl	%edi, %edx
 6275 53f5 C4412858 		vaddps	%xmm14, %xmm10, %xmm10
 6275      D6
 6276 53fa C4413058 		vaddps	%xmm13, %xmm9, %xmm9
 6276      CD
 6277 53ff C4621998 		vfmadd132ps	-144(%rbp), %xmm12, %xmm11
 6277      9D70FFFF 
 6277      FF
 6278 5408 C5E85DD4 		vminps	%xmm4, %xmm2, %xmm2
 6279 540c C5285DD4 		vminps	%xmm4, %xmm10, %xmm10
 6280 5410 C5305DCC 		vminps	%xmm4, %xmm9, %xmm9
 416:sepia_filter.c ****                           0.5f +
 6281              		.loc 1 416 24 view .LVU1714
 6282 5414 C5FA5BD2 		vcvttps2dq	%xmm2, %xmm2
 416:sepia_filter.c ****                           0.5f +
 6283              		.loc 1 416 41 view .LVU1715
 6284 5418 C4C17058 		vaddps	%xmm11, %xmm1, %xmm1
 6284      CB
 416:sepia_filter.c ****                           0.5f +
 6285              		.loc 1 416 24 view .LVU1716
 6286 541d C5E9DB15 		vpand	.LC81(%rip), %xmm2, %xmm2
 6286      00000000 
 6287 5425 C4417A5B 		vcvttps2dq	%xmm10, %xmm10
 6287      D2
 416:sepia_filter.c ****                           0.5f +
 6288              		.loc 1 416 41 view .LVU1717
 6289 542a C5F05DCC 		vminps	%xmm4, %xmm1, %xmm1
 416:sepia_filter.c ****                           0.5f +
 6290              		.loc 1 416 24 view .LVU1718
 6291 542e C529DB15 		vpand	.LC81(%rip), %xmm10, %xmm10
 6291      00000000 
 6292 5436 C4417A5B 		vcvttps2dq	%xmm9, %xmm9
 6292      C9
 6293 543b C5FA5BC9 		vcvttps2dq	%xmm1, %xmm1
 6294 543f C531DB0D 		vpand	.LC81(%rip), %xmm9, %xmm9
 6294      00000000 
 6295 5447 C5F1DB0D 		vpand	.LC81(%rip), %xmm1, %xmm1
 6295      00000000 
 6296 544f C4C2692B 		vpackusdw	%xmm10, %xmm2, %xmm2
 6296      D2
 6297 5454 C4E2312B 		vpackusdw	%xmm1, %xmm9, %xmm1
 6297      C9
 6298 5459 C5C9DBC9 		vpand	%xmm1, %xmm6, %xmm1
 6299 545d C5C9DBD2 		vpand	%xmm2, %xmm6, %xmm2
 6300 5461 C5E967D1 		vpackuswb	%xmm1, %xmm2, %xmm2
 416:sepia_filter.c ****                           0.5f +
 6301              		.loc 1 416 22 view .LVU1719
 6302 5465 C5FA7F14 		vmovdqu	%xmm2, (%rbx,%rsi)
 6302      33
 421:sepia_filter.c ****                           0.5f +
 6303              		.loc 1 421 13 is_stmt 1 view .LVU1720
 6304 546a C4E27918 		vbroadcastss	.LC11(%rip), %xmm1
 6304      0D000000 
 6304      00
 6305 5473 C5F82895 		vmovaps	-272(%rbp), %xmm2
 6305      F0FEFFFF 
 6306 547b C578288D 		vmovaps	-304(%rbp), %xmm9
 6306      D0FEFFFF 
 6307 5483 C4E25198 		vfmadd132ps	%xmm1, %xmm5, %xmm0
 6307      C1
 6308 5488 C4E25198 		vfmadd132ps	%xmm1, %xmm5, %xmm2
 6308      D1
 6309 548d C4625198 		vfmadd132ps	%xmm1, %xmm5, %xmm9
 6309      C9
 6310 5492 C4E25198 		vfmadd132ps	-208(%rbp), %xmm5, %xmm1
 6310      8D30FFFF 
 6310      FF
 425:sepia_filter.c ****                           sepia[2][2]*B_in[i]));
 6311              		.loc 1 425 38 is_stmt 0 view .LVU1721
 6312 549b C4E27918 		vbroadcastss	.LC12(%rip), %xmm5
 6312      2D000000 
 6312      00
 6313 54a4 C4627918 		vbroadcastss	.LC10(%rip), %xmm10
 6313      15000000 
 6313      00
 6314 54ad C53859C5 		vmulps	%xmm5, %xmm8, %xmm8
 6315 54b1 C5E059DD 		vmulps	%xmm5, %xmm3, %xmm3
 6316 54b5 C5C059FD 		vmulps	%xmm5, %xmm7, %xmm7
 6317 54b9 C5D059AD 		vmulps	-176(%rbp), %xmm5, %xmm5
 6317      50FFFFFF 
 6318 54c1 83E2F0   		andl	$-16, %edx
 6319 54c4 C46229B8 		vfmadd231ps	-240(%rbp), %xmm10, %xmm8
 6319      8510FFFF 
 6319      FF
 6320 54cd C4E229B8 		vfmadd231ps	-80(%rbp), %xmm10, %xmm3
 6320      5DB0
 6321 54d3 C4E229B8 		vfmadd231ps	-112(%rbp), %xmm10, %xmm7
 6321      7D90
 6322 54d9 C4E229B8 		vfmadd231ps	-144(%rbp), %xmm10, %xmm5
 6322      AD70FFFF 
 6322      FF
 6323 54e2 01D0     		addl	%edx, %eax
 421:sepia_filter.c ****                           0.5f +
 6324              		.loc 1 421 41 view .LVU1722
 6325 54e4 C4C17858 		vaddps	%xmm8, %xmm0, %xmm0
 6325      C0
 6326 54e9 C5E858D3 		vaddps	%xmm3, %xmm2, %xmm2
 6327 54ed C53058CF 		vaddps	%xmm7, %xmm9, %xmm9
 6328 54f1 C5D058C9 		vaddps	%xmm1, %xmm5, %xmm1
 6329 54f5 C5F85DC4 		vminps	%xmm4, %xmm0, %xmm0
 6330 54f9 C5E85DD4 		vminps	%xmm4, %xmm2, %xmm2
 6331 54fd C5305DCC 		vminps	%xmm4, %xmm9, %xmm9
 6332 5501 C5F05DCC 		vminps	%xmm4, %xmm1, %xmm1
 421:sepia_filter.c ****                           0.5f +
 6333              		.loc 1 421 24 view .LVU1723
 6334 5505 C5FA5BC0 		vcvttps2dq	%xmm0, %xmm0
 6335 5509 C5FA5BD2 		vcvttps2dq	%xmm2, %xmm2
 6336 550d C5F9DB05 		vpand	.LC81(%rip), %xmm0, %xmm0
 6336      00000000 
 6337 5515 C5E9DB15 		vpand	.LC81(%rip), %xmm2, %xmm2
 6337      00000000 
 6338 551d C4417A5B 		vcvttps2dq	%xmm9, %xmm9
 6338      C9
 6339 5522 C5FA5BC9 		vcvttps2dq	%xmm1, %xmm1
 6340 5526 C531DB0D 		vpand	.LC81(%rip), %xmm9, %xmm9
 6340      00000000 
 6341 552e C5F1DB0D 		vpand	.LC81(%rip), %xmm1, %xmm1
 6341      00000000 
 6342 5536 C4E2792B 		vpackusdw	%xmm2, %xmm0, %xmm0
 6342      C2
 6343 553b C462312B 		vpackusdw	%xmm1, %xmm9, %xmm9
 6343      C9
 6344 5540 C5C9DBC0 		vpand	%xmm0, %xmm6, %xmm0
 6345 5544 C4C149DB 		vpand	%xmm9, %xmm6, %xmm6
 6345      F1
 6346 5549 C5F967C6 		vpackuswb	%xmm6, %xmm0, %xmm0
 6347 554d 83E70F   		andl	$15, %edi
 421:sepia_filter.c ****                           0.5f +
 6348              		.loc 1 421 22 view .LVU1724
 6349 5550 C4A17A7F 		vmovdqu	%xmm0, (%rbx,%r10)
 6349      0413
 409:sepia_filter.c ****         {
 6350              		.loc 1 409 44 is_stmt 1 view .LVU1725
 409:sepia_filter.c ****         {
 6351              		.loc 1 409 9 view .LVU1726
 6352 5556 0F84EC00 		je	.L143
 6352      0000
 6353              	.L142:
 409:sepia_filter.c ****         {
 6354              		.loc 1 409 9 is_stmt 0 view .LVU1727
 6355 555c C57A1025 		vmovss	.LC3(%rip), %xmm12
 6355      00000000 
 6356 5564 C5FA102D 		vmovss	.LC106(%rip), %xmm5
 6356      00000000 
 6357 556c C5FA1025 		vmovss	.LC4(%rip), %xmm4
 6357      00000000 
 6358 5574 C57A101D 		vmovss	.LC7(%rip), %xmm11
 6358      00000000 
 6359 557c C57A1015 		vmovss	.LC8(%rip), %xmm10
 6359      00000000 
 6360 5584 C57A100D 		vmovss	.LC9(%rip), %xmm9
 6360      00000000 
 6361 558c C57A1005 		vmovss	.LC10(%rip), %xmm8
 6361      00000000 
 6362 5594 C5FA103D 		vmovss	.LC11(%rip), %xmm7
 6362      00000000 
 6363 559c C5FA1035 		vmovss	.LC12(%rip), %xmm6
 6363      00000000 
 6364 55a4 4898     		cltq
 6365 55a6 662E0F1F 		.p2align 4,,10
 6365      84000000 
 6365      0000
 6366              		.p2align 3
 6367              	.L144:
 6368              	.LVL187:
 411:sepia_filter.c ****                           0.5f +
 6369              		.loc 1 411 13 is_stmt 1 view .LVU1728
 413:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 6370              		.loc 1 413 43 is_stmt 0 view .LVU1729
 6371 55b0 410FB614 		movzbl	(%r12,%rax), %edx
 6371      04
 413:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 6372              		.loc 1 413 38 view .LVU1730
 6373 55b5 C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
 6374 55b9 C5F22AC2 		vcvtsi2ssl	%edx, %xmm1, %xmm0
 414:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 6375              		.loc 1 414 43 view .LVU1731
 6376 55bd 410FB614 		movzbl	(%r14,%rax), %edx
 6376      06
 414:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 6377              		.loc 1 414 38 view .LVU1732
 6378 55c2 C5F22AD2 		vcvtsi2ssl	%edx, %xmm1, %xmm2
 415:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 6379              		.loc 1 415 43 view .LVU1733
 6380 55c6 410FB614 		movzbl	(%r8,%rax), %edx
 6380      00
 415:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 6381              		.loc 1 415 38 view .LVU1734
 6382 55cb C5F22ACA 		vcvtsi2ssl	%edx, %xmm1, %xmm1
 414:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 6383              		.loc 1 414 38 view .LVU1735
 6384 55cf C5EA591D 		vmulss	.LC1(%rip), %xmm2, %xmm3
 6384      00000000 
 6385 55d7 C57828E9 		vmovaps	%xmm1, %xmm13
 6386 55db C4425199 		vfmadd132ss	%xmm12, %xmm5, %xmm13
 6386      EC
 6387 55e0 C4E279B9 		vfmadd231ss	.LC2(%rip), %xmm0, %xmm3
 6387      1D000000 
 6387      00
 411:sepia_filter.c ****                           0.5f +
 6388              		.loc 1 411 41 view .LVU1736
 6389 55e9 C4C16258 		vaddss	%xmm13, %xmm3, %xmm3
 6389      DD
 6390 55ee C57828E9 		vmovaps	%xmm1, %xmm13
 6391 55f2 C4425199 		vfmadd132ss	%xmm9, %xmm5, %xmm13
 6391      E9
 6392 55f7 C5E25DDC 		vminss	%xmm4, %xmm3, %xmm3
 6393 55fb C4E25199 		vfmadd132ss	%xmm6, %xmm5, %xmm1
 6393      CE
 411:sepia_filter.c ****                           0.5f +
 6394              		.loc 1 411 24 view .LVU1737
 6395 5600 C5FA2CD3 		vcvttss2sil	%xmm3, %edx
 419:sepia_filter.c ****                           sepia[1][2]*B_in[i]));
 6396              		.loc 1 419 38 view .LVU1738
 6397 5604 C4C16A59 		vmulss	%xmm11, %xmm2, %xmm3
 6397      DB
 424:sepia_filter.c ****                           sepia[2][2]*B_in[i]));
 6398              		.loc 1 424 38 view .LVU1739
 6399 5609 C4C16A59 		vmulss	%xmm8, %xmm2, %xmm2
 6399      D0
 411:sepia_filter.c ****                           0.5f +
 6400              		.loc 1 411 24 view .LVU1740
 6401 560e 881403   		movb	%dl, (%rbx,%rax)
 416:sepia_filter.c ****                           0.5f +
 6402              		.loc 1 416 13 is_stmt 1 view .LVU1741
 6403 5611 C4C279B9 		vfmadd231ss	%xmm10, %xmm0, %xmm3
 6403      DA
 6404 5616 C4E26999 		vfmadd132ss	%xmm7, %xmm2, %xmm0
 6404      C7
 416:sepia_filter.c ****                           0.5f +
 6405              		.loc 1 416 41 is_stmt 0 view .LVU1742
 6406 561b C4C16258 		vaddss	%xmm13, %xmm3, %xmm3
 6406      DD
 421:sepia_filter.c ****                           0.5f +
 6407              		.loc 1 421 41 view .LVU1743
 6408 5620 C5FA58C1 		vaddss	%xmm1, %xmm0, %xmm0
 416:sepia_filter.c ****                           0.5f +
 6409              		.loc 1 416 41 view .LVU1744
 6410 5624 C5E25DDC 		vminss	%xmm4, %xmm3, %xmm3
 421:sepia_filter.c ****                           0.5f +
 6411              		.loc 1 421 41 view .LVU1745
 6412 5628 C5FA5DC4 		vminss	%xmm4, %xmm0, %xmm0
 416:sepia_filter.c ****                           0.5f +
 6413              		.loc 1 416 24 view .LVU1746
 6414 562c C5FA2CD3 		vcvttss2sil	%xmm3, %edx
 6415 5630 41885405 		movb	%dl, 0(%r13,%rax)
 6415      00
 421:sepia_filter.c ****                           0.5f +
 6416              		.loc 1 421 13 is_stmt 1 view .LVU1747
 421:sepia_filter.c ****                           0.5f +
 6417              		.loc 1 421 24 is_stmt 0 view .LVU1748
 6418 5635 C5FA2CD0 		vcvttss2sil	%xmm0, %edx
 6419 5639 881401   		movb	%dl, (%rcx,%rax)
 409:sepia_filter.c ****         {
 6420              		.loc 1 409 44 is_stmt 1 view .LVU1749
 6421              	.LVL188:
 409:sepia_filter.c ****         {
 6422              		.loc 1 409 9 view .LVU1750
 6423 563c 48FFC0   		incq	%rax
 6424              	.LVL189:
 409:sepia_filter.c ****         {
 6425              		.loc 1 409 9 is_stmt 0 view .LVU1751
 6426 563f 4139C7   		cmpl	%eax, %r15d
 6427 5642 0F8F68FF 		jg	.L144
 6427      FFFF
 6428              	.LVL190:
 6429              	.L143:
 409:sepia_filter.c ****         {
 6430              		.loc 1 409 9 view .LVU1752
 6431 5648 4C898D70 		movq	%r9, -144(%rbp)
 6431      FFFFFF
 6432 564f 48894D90 		movq	%rcx, -112(%rbp)
 6433 5653 4C8945B0 		movq	%r8, -80(%rbp)
 6434              	.LBE48:
 426:sepia_filter.c ****         }
 427:sepia_filter.c ****         dummy(image_in, image_out);
 6435              		.loc 1 427 9 is_stmt 1 view .LVU1753
 6436 5657 488BB5B8 		movq	-328(%rbp), %rsi
 6436      FEFFFF
 6437 565e 488BBDB0 		movq	-336(%rbp), %rdi
 6437      FEFFFF
 6438              	.L184:
 6439              		.loc 1 427 9 is_stmt 0 view .LVU1754
 6440 5665 E8000000 		call	dummy
 6440      00
 6441              	.LVL191:
 405:sepia_filter.c ****     {
 6442              		.loc 1 405 34 is_stmt 1 view .LVU1755
 405:sepia_filter.c ****     {
 6443              		.loc 1 405 23 view .LVU1756
 6444 566a FF8DC0FE 		decl	-320(%rbp)
 6444      FFFF
 6445 5670 4C8B45B0 		movq	-80(%rbp), %r8
 6446 5674 488B4D90 		movq	-112(%rbp), %rcx
 6447 5678 4C8B8D70 		movq	-144(%rbp), %r9
 6447      FFFFFF
 6448 567f 0F851BF6 		jne	.L147
 6448      FFFF
 6449 5685 48894DB0 		movq	%rcx, -80(%rbp)
 6450              	.L146:
 405:sepia_filter.c ****     {
 6451              		.loc 1 405 23 is_stmt 0 view .LVU1757
 6452              	.LBE51:
 428:sepia_filter.c ****     }
 429:sepia_filter.c ****     end_t = get_wall_time();
 6453              		.loc 1 429 5 is_stmt 1 view .LVU1758
 6454              		.loc 1 429 13 is_stmt 0 view .LVU1759
 6455 5689 31C0     		xorl	%eax, %eax
 6456 568b E8000000 		call	get_wall_time
 6456      00
 6457              	.LVL192:
 430:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_SOA0");
 6458              		.loc 1 430 5 is_stmt 1 view .LVU1760
 6459 5690 C5FB5C85 		vsubsd	-376(%rbp), %xmm0, %xmm0
 6459      88FEFFFF 
 6460              	.LVL193:
 6461              		.loc 1 430 5 is_stmt 0 view .LVU1761
 6462 5698 BE000000 		movl	$.LC111, %esi
 6462      00
 6463 569d 4489FF   		movl	%r15d, %edi
 6464 56a0 E8000000 		call	results
 6464      00
 6465              	.LVL194:
 6466              	.LBB52:
 431:sepia_filter.c **** 
 432:sepia_filter.c ****     /* transformación SoA -> AoS */
 433:sepia_filter.c ****     /* COMPLETAR ... */
 434:sepia_filter.c ****     #pragma GCC ivdep
 435:sepia_filter.c ****     for (int i=0; i < height*width; i++)
 6467              		.loc 1 435 10 is_stmt 1 view .LVU1762
 6468              		.loc 1 435 5 view .LVU1763
 6469 56a5 4585FF   		testl	%r15d, %r15d
 6470 56a8 0F8E7905 		jle	.L149
 6470      0000
 6471              		.loc 1 435 5 is_stmt 0 view .LVU1764
 6472 56ae 83BDACFE 		cmpl	$30, -340(%rbp)
 6472      FFFF1E
 6473 56b5 0F86F505 		jbe	.L157
 6473      0000
 6474 56bb 488B9590 		movq	-368(%rbp), %rdx
 6474      FEFFFF
 6475 56c2 C57D6F3D 		vmovdqa	.LC46(%rip), %ymm15
 6475      00000000 
 6476 56ca C57D6F35 		vmovdqa	.LC47(%rip), %ymm14
 6476      00000000 
 6477 56d2 C57D6F2D 		vmovdqa	.LC48(%rip), %ymm13
 6477      00000000 
 6478 56da C57D6F25 		vmovdqa	.LC49(%rip), %ymm12
 6478      00000000 
 6479 56e2 C57D6F1D 		vmovdqa	.LC50(%rip), %ymm11
 6479      00000000 
 6480 56ea C57D6F15 		vmovdqa	.LC51(%rip), %ymm10
 6480      00000000 
 6481 56f2 C57D6F0D 		vmovdqa	.LC52(%rip), %ymm9
 6481      00000000 
 6482 56fa C57D6F05 		vmovdqa	.LC53(%rip), %ymm8
 6482      00000000 
 6483 5702 C5FD6F3D 		vmovdqa	.LC57(%rip), %ymm7
 6483      00000000 
 6484 570a 488B4DB0 		movq	-80(%rbp), %rcx
 6485 570e 488BB5A0 		movq	-352(%rbp), %rsi
 6485      FEFFFF
 6486 5715 488BBD98 		movq	-360(%rbp), %rdi
 6486      FEFFFF
 6487 571c 31C0     		xorl	%eax, %eax
 6488              	.LVL195:
 6489 571e 6690     		.p2align 4,,10
 6490              		.p2align 3
 6491              	.L151:
 436:sepia_filter.c ****     {
 437:sepia_filter.c ****         pixels_out[3*i + 0] = R_out[i];
 6492              		.loc 1 437 9 is_stmt 1 discriminator 3 view .LVU1765
 6493              		.loc 1 437 36 is_stmt 0 discriminator 3 view .LVU1766
 6494 5720 C5FD6F0C 		vmovdqa	(%rbx,%rax), %ymm1
 6494      03
 438:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6495              		.loc 1 438 9 is_stmt 1 discriminator 3 view .LVU1767
 6496              		.loc 1 438 36 is_stmt 0 discriminator 3 view .LVU1768
 6497 5725 C4C17E6F 		vmovdqu	0(%r13,%rax), %ymm0
 6497      440500
 439:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 6498              		.loc 1 439 9 is_stmt 1 discriminator 3 view .LVU1769
 6499              		.loc 1 439 36 is_stmt 0 discriminator 3 view .LVU1770
 6500 572c C5FE6F14 		vmovdqu	(%rsi,%rax), %ymm2
 6500      06
 6501              		.loc 1 439 29 discriminator 3 view .LVU1771
 6502 5731 C4C27500 		vpshufb	%ymm15, %ymm1, %ymm6
 6502      F7
 6503 5736 C4C27D00 		vpshufb	%ymm14, %ymm0, %ymm5
 6503      EE
 6504 573b C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 6504      ED4E
 6505 5741 C4C27500 		vpshufb	%ymm13, %ymm1, %ymm3
 6505      DD
 6506 5746 C4C27D00 		vpshufb	%ymm12, %ymm0, %ymm4
 6506      E4
 6507 574b C4E3FD00 		vpermq	$78, %ymm6, %ymm6
 6507      F64E
 6508 5751 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 6509 5755 C5E5EBDE 		vpor	%ymm6, %ymm3, %ymm3
 6510 5759 C4C26D00 		vpshufb	%ymm11, %ymm2, %ymm5
 6510      EB
 6511 575e C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 6512 5762 C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 6512      ED4E
 6513 5768 C4C26D00 		vpshufb	%ymm9, %ymm2, %ymm4
 6513      E1
 6514 576d C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 6515 5771 C4C26500 		vpshufb	%ymm10, %ymm3, %ymm3
 6515      DA
 6516 5776 C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 6517 577a C4C27500 		vpshufb	%ymm8, %ymm1, %ymm4
 6517      E0
 6518 577f C5FE7F1A 		vmovdqu	%ymm3, (%rdx)
 6519 5783 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 6519      E44E
 6520 5789 C4E27500 		vpshufb	.LC54(%rip), %ymm1, %ymm3
 6520      1D000000 
 6520      00
 6521 5792 C4E27D00 		vpshufb	.LC55(%rip), %ymm0, %ymm5
 6521      2D000000 
 6521      00
 6522 579b C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 6523 579f C5E5EBDD 		vpor	%ymm5, %ymm3, %ymm3
 6524 57a3 C4E26D00 		vpshufb	.LC56(%rip), %ymm2, %ymm4
 6524      25000000 
 6524      00
 6525 57ac C4E35D4C 		vpblendvb	%ymm7, %ymm3, %ymm4, %ymm3
 6525      DB70
 6526 57b2 C5FE7F5A 		vmovdqu	%ymm3, 32(%rdx)
 6526      20
 6527 57b7 C4E27D00 		vpshufb	.LC58(%rip), %ymm0, %ymm4
 6527      25000000 
 6527      00
 6528 57c0 C4E27500 		vpshufb	.LC59(%rip), %ymm1, %ymm3
 6528      1D000000 
 6528      00
 6529 57c9 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 6529      E44E
 6530 57cf C4E3FD00 		vpermq	$78, %ymm3, %ymm3
 6530      DB4E
 6531 57d5 C4E27D00 		vpshufb	.LC60(%rip), %ymm0, %ymm0
 6531      05000000 
 6531      00
 6532 57de C4E27500 		vpshufb	.LC61(%rip), %ymm1, %ymm1
 6532      0D000000 
 6532      00
 6533 57e7 C5F5EBCB 		vpor	%ymm3, %ymm1, %ymm1
 6534 57eb C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 6535 57ef C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 6536 57f3 C4E26D00 		vpshufb	.LC62(%rip), %ymm2, %ymm1
 6536      0D000000 
 6536      00
 6537 57fc C4E3FD00 		vpermq	$78, %ymm1, %ymm1
 6537      C94E
 6538 5802 C4E26D00 		vpshufb	.LC64(%rip), %ymm2, %ymm2
 6538      15000000 
 6538      00
 6539 580b C4E27D00 		vpshufb	.LC63(%rip), %ymm0, %ymm0
 6539      05000000 
 6539      00
 6540 5814 C5EDEBD1 		vpor	%ymm1, %ymm2, %ymm2
 6541 5818 C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 6542 581c 4883C020 		addq	$32, %rax
 6543 5820 C5FE7F42 		vmovdqu	%ymm0, 64(%rdx)
 6543      40
 435:sepia_filter.c ****     {
 6544              		.loc 1 435 38 is_stmt 1 discriminator 3 view .LVU1772
 435:sepia_filter.c ****     {
 6545              		.loc 1 435 5 discriminator 3 view .LVU1773
 6546 5825 4883C260 		addq	$96, %rdx
 6547 5829 4839F8   		cmpq	%rdi, %rax
 6548 582c 0F85EEFE 		jne	.L151
 6548      FFFF
 6549 5832 8B85C4FE 		movl	-316(%rbp), %eax
 6549      FFFF
 6550 5838 48894DB0 		movq	%rcx, -80(%rbp)
 6551 583c 4139C7   		cmpl	%eax, %r15d
 6552 583f 0F84A004 		je	.L188
 6552      0000
 6553 5845 C5F877   		vzeroupper
 6554              	.LVL196:
 6555              	.L150:
 435:sepia_filter.c ****     {
 6556              		.loc 1 435 5 is_stmt 0 discriminator 3 view .LVU1774
 6557 5848 8B8DA8FE 		movl	-344(%rbp), %ecx
 6557      FFFF
 6558 584e 4489FF   		movl	%r15d, %edi
 6559 5851 29CF     		subl	%ecx, %edi
 6560 5853 8D47FF   		leal	-1(%rdi), %eax
 6561 5856 83F80E   		cmpl	$14, %eax
 6562 5859 0F86CB00 		jbe	.L153
 6562      0000
 6563 585f 488B85C8 		movq	-312(%rbp), %rax
 6563      FEFFFF
 6564 5866 89CA     		movl	%ecx, %edx
 6565 5868 4801D0   		addq	%rdx, %rax
 438:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6566              		.loc 1 438 36 view .LVU1775
 6567 586b C5FA6F14 		vmovdqu	(%rbx,%rax), %xmm2
 6567      03
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6568              		.loc 1 437 36 view .LVU1776
 6569 5870 C5F96F0C 		vmovdqa	(%rbx,%rdx), %xmm1
 6569      13
 6570              		.loc 1 439 36 view .LVU1777
 6571 5875 C4C17A6F 		vmovdqu	0(%r13,%rax), %xmm0
 6571      440500
 6572              		.loc 1 439 29 view .LVU1778
 6573 587c C5F160DA 		vpunpcklbw	%xmm2, %xmm1, %xmm3
 6574 5880 C5F96F2D 		vmovdqa	.LC91(%rip), %xmm5
 6574      00000000 
 6575 5888 488B8D90 		movq	-368(%rbp), %rcx
 6575      FEFFFF
 6576 588f C4E27900 		vpshufb	.LC90(%rip), %xmm0, %xmm4
 6576      25000000 
 6576      00
 6577 5898 488D3452 		leaq	(%rdx,%rdx,2), %rsi
 6578 589c C4E26100 		vpshufb	.LC89(%rip), %xmm3, %xmm3
 6578      1D000000 
 6578      00
 6579 58a5 4801CE   		addq	%rcx, %rsi
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6580              		.loc 1 437 9 is_stmt 1 view .LVU1779
 438:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 6581              		.loc 1 438 9 view .LVU1780
 6582              		.loc 1 439 9 view .LVU1781
 6583              		.loc 1 439 29 is_stmt 0 view .LVU1782
 6584 58a8 C4E3614C 		vpblendvb	%xmm5, %xmm4, %xmm3, %xmm3
 6584      DC50
 6585 58ae C5FA7F1E 		vmovdqu	%xmm3, (%rsi)
 6586 58b2 C4E27100 		vpshufb	.LC93(%rip), %xmm1, %xmm4
 6586      25000000 
 6586      00
 6587 58bb C4E26900 		vpshufb	.LC92(%rip), %xmm2, %xmm3
 6587      1D000000 
 6587      00
 6588 58c4 C4E27100 		vpshufb	.LC96(%rip), %xmm1, %xmm1
 6588      0D000000 
 6588      00
 6589 58cd C4E26900 		vpshufb	.LC97(%rip), %xmm2, %xmm2
 6589      15000000 
 6589      00
 6590 58d6 C5F1EBCA 		vpor	%xmm2, %xmm1, %xmm1
 6591 58da 89F8     		movl	%edi, %eax
 6592 58dc C5F96F2D 		vmovdqa	.LC95(%rip), %xmm5
 6592      00000000 
 6593 58e4 C5F96F15 		vmovdqa	.LC99(%rip), %xmm2
 6593      00000000 
 6594 58ec C5E1EBDC 		vpor	%xmm4, %xmm3, %xmm3
 6595 58f0 83E0F0   		andl	$-16, %eax
 6596 58f3 C4E27900 		vpshufb	.LC94(%rip), %xmm0, %xmm4
 6596      25000000 
 6596      00
 6597 58fc C4E27900 		vpshufb	.LC98(%rip), %xmm0, %xmm0
 6597      05000000 
 6597      00
 6598 5905 0185C4FE 		addl	%eax, -316(%rbp)
 6598      FFFF
 6599 590b C4E3614C 		vpblendvb	%xmm5, %xmm4, %xmm3, %xmm3
 6599      DC50
 6600 5911 C4E3794C 		vpblendvb	%xmm2, %xmm1, %xmm0, %xmm0
 6600      C120
 6601 5917 83E70F   		andl	$15, %edi
 6602 591a C5FA7F5E 		vmovdqu	%xmm3, 16(%rsi)
 6602      10
 6603 591f C5FA7F46 		vmovdqu	%xmm0, 32(%rsi)
 6603      20
 435:sepia_filter.c ****     {
 6604              		.loc 1 435 38 is_stmt 1 view .LVU1783
 435:sepia_filter.c ****     {
 6605              		.loc 1 435 5 view .LVU1784
 6606 5924 0F84FD02 		je	.L149
 6606      0000
 6607              	.L153:
 6608              	.LVL197:
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6609              		.loc 1 437 9 view .LVU1785
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6610              		.loc 1 437 36 is_stmt 0 view .LVU1786
 6611 592a 486385C4 		movslq	-316(%rbp), %rax
 6611      FEFFFF
 6612              		.loc 1 439 29 view .LVU1787
 6613 5931 4C8B55B0 		movq	-80(%rbp), %r10
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6614              		.loc 1 437 29 view .LVU1788
 6615 5935 0FB63403 		movzbl	(%rbx,%rax), %esi
 6616 5939 410FB64C 		movzbl	0(%r13,%rax), %ecx
 6616      0500
 6617 593f 4C8B9D90 		movq	-368(%rbp), %r11
 6617      FEFFFF
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6618              		.loc 1 437 36 view .LVU1789
 6619 5946 4989C1   		movq	%rax, %r9
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6620              		.loc 1 437 21 view .LVU1790
 6621 5949 448D0440 		leal	(%rax,%rax,2), %r8d
 6622              		.loc 1 439 29 view .LVU1791
 6623 594d 410FB604 		movzbl	(%r10,%rax), %eax
 6623      02
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6624              		.loc 1 437 21 view .LVU1792
 6625 5952 4963F8   		movslq	%r8d, %rdi
 438:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 6626              		.loc 1 438 9 is_stmt 1 view .LVU1793
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6627              		.loc 1 437 29 is_stmt 0 view .LVU1794
 6628 5955 89F2     		movl	%esi, %edx
 6629              		.loc 1 439 29 view .LVU1795
 6630 5957 4188443B 		movb	%al, 2(%r11,%rdi)
 6630      02
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6631              		.loc 1 437 29 view .LVU1796
 6632 595c 88CE     		movb	%cl, %dh
 435:sepia_filter.c ****     {
 6633              		.loc 1 435 38 view .LVU1797
 6634 595e 418D4101 		leal	1(%r9), %eax
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6635              		.loc 1 437 29 view .LVU1798
 6636 5962 66418914 		movw	%dx, (%r11,%rdi)
 6636      3B
 6637              		.loc 1 439 9 is_stmt 1 view .LVU1799
 435:sepia_filter.c ****     {
 6638              		.loc 1 435 38 view .LVU1800
 6639              	.LVL198:
 435:sepia_filter.c ****     {
 6640              		.loc 1 435 5 view .LVU1801
 6641 5967 4139C7   		cmpl	%eax, %r15d
 6642 596a 0F8EB702 		jle	.L149
 6642      0000
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6643              		.loc 1 437 9 view .LVU1802
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6644              		.loc 1 437 36 is_stmt 0 view .LVU1803
 6645 5970 4898     		cltq
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6646              		.loc 1 437 29 view .LVU1804
 6647 5972 0FB63C03 		movzbl	(%rbx,%rax), %edi
 6648 5976 410FB64C 		movzbl	0(%r13,%rax), %ecx
 6648      0500
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6649              		.loc 1 437 21 view .LVU1805
 6650 597c 418D7003 		leal	3(%r8), %esi
 6651              		.loc 1 439 29 view .LVU1806
 6652 5980 410FB604 		movzbl	(%r10,%rax), %eax
 6652      02
 6653              	.LVL199:
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6654              		.loc 1 437 21 view .LVU1807
 6655 5985 4863F6   		movslq	%esi, %rsi
 438:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 6656              		.loc 1 438 9 is_stmt 1 view .LVU1808
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6657              		.loc 1 437 29 is_stmt 0 view .LVU1809
 6658 5988 89FA     		movl	%edi, %edx
 6659              		.loc 1 439 29 view .LVU1810
 6660 598a 41884433 		movb	%al, 2(%r11,%rsi)
 6660      02
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6661              		.loc 1 437 29 view .LVU1811
 6662 598f 88CE     		movb	%cl, %dh
 435:sepia_filter.c ****     {
 6663              		.loc 1 435 38 view .LVU1812
 6664 5991 418D4102 		leal	2(%r9), %eax
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6665              		.loc 1 437 29 view .LVU1813
 6666 5995 66418914 		movw	%dx, (%r11,%rsi)
 6666      33
 6667              		.loc 1 439 9 is_stmt 1 view .LVU1814
 435:sepia_filter.c ****     {
 6668              		.loc 1 435 38 view .LVU1815
 6669              	.LVL200:
 435:sepia_filter.c ****     {
 6670              		.loc 1 435 5 view .LVU1816
 6671 599a 4139C7   		cmpl	%eax, %r15d
 6672 599d 0F8E8402 		jle	.L149
 6672      0000
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6673              		.loc 1 437 9 view .LVU1817
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6674              		.loc 1 437 36 is_stmt 0 view .LVU1818
 6675 59a3 4898     		cltq
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6676              		.loc 1 437 29 view .LVU1819
 6677 59a5 0FB63C03 		movzbl	(%rbx,%rax), %edi
 6678 59a9 410FB64C 		movzbl	0(%r13,%rax), %ecx
 6678      0500
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6679              		.loc 1 437 21 view .LVU1820
 6680 59af 418D7006 		leal	6(%r8), %esi
 6681              		.loc 1 439 29 view .LVU1821
 6682 59b3 410FB604 		movzbl	(%r10,%rax), %eax
 6682      02
 6683              	.LVL201:
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6684              		.loc 1 437 21 view .LVU1822
 6685 59b8 4863F6   		movslq	%esi, %rsi
 438:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 6686              		.loc 1 438 9 is_stmt 1 view .LVU1823
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6687              		.loc 1 437 29 is_stmt 0 view .LVU1824
 6688 59bb 89FA     		movl	%edi, %edx
 6689              		.loc 1 439 29 view .LVU1825
 6690 59bd 41884433 		movb	%al, 2(%r11,%rsi)
 6690      02
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6691              		.loc 1 437 29 view .LVU1826
 6692 59c2 88CE     		movb	%cl, %dh
 435:sepia_filter.c ****     {
 6693              		.loc 1 435 38 view .LVU1827
 6694 59c4 418D4103 		leal	3(%r9), %eax
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6695              		.loc 1 437 29 view .LVU1828
 6696 59c8 66418914 		movw	%dx, (%r11,%rsi)
 6696      33
 6697              		.loc 1 439 9 is_stmt 1 view .LVU1829
 435:sepia_filter.c ****     {
 6698              		.loc 1 435 38 view .LVU1830
 6699              	.LVL202:
 435:sepia_filter.c ****     {
 6700              		.loc 1 435 5 view .LVU1831
 6701 59cd 4139C7   		cmpl	%eax, %r15d
 6702 59d0 0F8E5102 		jle	.L149
 6702      0000
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6703              		.loc 1 437 9 view .LVU1832
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6704              		.loc 1 437 36 is_stmt 0 view .LVU1833
 6705 59d6 4898     		cltq
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6706              		.loc 1 437 29 view .LVU1834
 6707 59d8 0FB63C03 		movzbl	(%rbx,%rax), %edi
 6708 59dc 410FB654 		movzbl	0(%r13,%rax), %edx
 6708      0500
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6709              		.loc 1 437 21 view .LVU1835
 6710 59e2 418D7009 		leal	9(%r8), %esi
 6711              		.loc 1 439 29 view .LVU1836
 6712 59e6 410FB604 		movzbl	(%r10,%rax), %eax
 6712      02
 6713              	.LVL203:
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6714              		.loc 1 437 21 view .LVU1837
 6715 59eb 4863F6   		movslq	%esi, %rsi
 438:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 6716              		.loc 1 438 9 is_stmt 1 view .LVU1838
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6717              		.loc 1 437 29 is_stmt 0 view .LVU1839
 6718 59ee 89F9     		movl	%edi, %ecx
 6719              		.loc 1 439 29 view .LVU1840
 6720 59f0 41884433 		movb	%al, 2(%r11,%rsi)
 6720      02
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6721              		.loc 1 437 29 view .LVU1841
 6722 59f5 88D5     		movb	%dl, %ch
 435:sepia_filter.c ****     {
 6723              		.loc 1 435 38 view .LVU1842
 6724 59f7 418D4104 		leal	4(%r9), %eax
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6725              		.loc 1 437 29 view .LVU1843
 6726 59fb 6641890C 		movw	%cx, (%r11,%rsi)
 6726      33
 6727              		.loc 1 439 9 is_stmt 1 view .LVU1844
 435:sepia_filter.c ****     {
 6728              		.loc 1 435 38 view .LVU1845
 6729              	.LVL204:
 435:sepia_filter.c ****     {
 6730              		.loc 1 435 5 view .LVU1846
 6731 5a00 4139C7   		cmpl	%eax, %r15d
 6732 5a03 0F8E1E02 		jle	.L149
 6732      0000
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6733              		.loc 1 437 9 view .LVU1847
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6734              		.loc 1 437 36 is_stmt 0 view .LVU1848
 6735 5a09 4898     		cltq
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6736              		.loc 1 437 29 view .LVU1849
 6737 5a0b 0FB63C03 		movzbl	(%rbx,%rax), %edi
 6738 5a0f 410FB654 		movzbl	0(%r13,%rax), %edx
 6738      0500
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6739              		.loc 1 437 21 view .LVU1850
 6740 5a15 418D700C 		leal	12(%r8), %esi
 6741              		.loc 1 439 29 view .LVU1851
 6742 5a19 410FB604 		movzbl	(%r10,%rax), %eax
 6742      02
 6743              	.LVL205:
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6744              		.loc 1 437 21 view .LVU1852
 6745 5a1e 4863F6   		movslq	%esi, %rsi
 438:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 6746              		.loc 1 438 9 is_stmt 1 view .LVU1853
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6747              		.loc 1 437 29 is_stmt 0 view .LVU1854
 6748 5a21 89F9     		movl	%edi, %ecx
 6749              		.loc 1 439 29 view .LVU1855
 6750 5a23 41884433 		movb	%al, 2(%r11,%rsi)
 6750      02
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6751              		.loc 1 437 29 view .LVU1856
 6752 5a28 88D5     		movb	%dl, %ch
 435:sepia_filter.c ****     {
 6753              		.loc 1 435 38 view .LVU1857
 6754 5a2a 418D4105 		leal	5(%r9), %eax
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6755              		.loc 1 437 29 view .LVU1858
 6756 5a2e 6641890C 		movw	%cx, (%r11,%rsi)
 6756      33
 6757              		.loc 1 439 9 is_stmt 1 view .LVU1859
 435:sepia_filter.c ****     {
 6758              		.loc 1 435 38 view .LVU1860
 6759              	.LVL206:
 435:sepia_filter.c ****     {
 6760              		.loc 1 435 5 view .LVU1861
 6761 5a33 4139C7   		cmpl	%eax, %r15d
 6762 5a36 0F8EEB01 		jle	.L149
 6762      0000
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6763              		.loc 1 437 9 view .LVU1862
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6764              		.loc 1 437 36 is_stmt 0 view .LVU1863
 6765 5a3c 4898     		cltq
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6766              		.loc 1 437 29 view .LVU1864
 6767 5a3e 0FB63C03 		movzbl	(%rbx,%rax), %edi
 6768 5a42 410FB654 		movzbl	0(%r13,%rax), %edx
 6768      0500
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6769              		.loc 1 437 21 view .LVU1865
 6770 5a48 418D700F 		leal	15(%r8), %esi
 6771              		.loc 1 439 29 view .LVU1866
 6772 5a4c 410FB604 		movzbl	(%r10,%rax), %eax
 6772      02
 6773              	.LVL207:
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6774              		.loc 1 437 21 view .LVU1867
 6775 5a51 4863F6   		movslq	%esi, %rsi
 438:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 6776              		.loc 1 438 9 is_stmt 1 view .LVU1868
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6777              		.loc 1 437 29 is_stmt 0 view .LVU1869
 6778 5a54 89F9     		movl	%edi, %ecx
 6779              		.loc 1 439 29 view .LVU1870
 6780 5a56 41884433 		movb	%al, 2(%r11,%rsi)
 6780      02
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6781              		.loc 1 437 29 view .LVU1871
 6782 5a5b 88D5     		movb	%dl, %ch
 435:sepia_filter.c ****     {
 6783              		.loc 1 435 38 view .LVU1872
 6784 5a5d 418D4106 		leal	6(%r9), %eax
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6785              		.loc 1 437 29 view .LVU1873
 6786 5a61 6641890C 		movw	%cx, (%r11,%rsi)
 6786      33
 6787              		.loc 1 439 9 is_stmt 1 view .LVU1874
 435:sepia_filter.c ****     {
 6788              		.loc 1 435 38 view .LVU1875
 6789              	.LVL208:
 435:sepia_filter.c ****     {
 6790              		.loc 1 435 5 view .LVU1876
 6791 5a66 4139C7   		cmpl	%eax, %r15d
 6792 5a69 0F8EB801 		jle	.L149
 6792      0000
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6793              		.loc 1 437 9 view .LVU1877
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6794              		.loc 1 437 36 is_stmt 0 view .LVU1878
 6795 5a6f 4898     		cltq
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6796              		.loc 1 437 29 view .LVU1879
 6797 5a71 0FB63C03 		movzbl	(%rbx,%rax), %edi
 6798 5a75 410FB654 		movzbl	0(%r13,%rax), %edx
 6798      0500
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6799              		.loc 1 437 21 view .LVU1880
 6800 5a7b 418D7012 		leal	18(%r8), %esi
 6801              		.loc 1 439 29 view .LVU1881
 6802 5a7f 410FB604 		movzbl	(%r10,%rax), %eax
 6802      02
 6803              	.LVL209:
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6804              		.loc 1 437 21 view .LVU1882
 6805 5a84 4863F6   		movslq	%esi, %rsi
 438:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 6806              		.loc 1 438 9 is_stmt 1 view .LVU1883
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6807              		.loc 1 437 29 is_stmt 0 view .LVU1884
 6808 5a87 89F9     		movl	%edi, %ecx
 6809              		.loc 1 439 29 view .LVU1885
 6810 5a89 41884433 		movb	%al, 2(%r11,%rsi)
 6810      02
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6811              		.loc 1 437 29 view .LVU1886
 6812 5a8e 88D5     		movb	%dl, %ch
 435:sepia_filter.c ****     {
 6813              		.loc 1 435 38 view .LVU1887
 6814 5a90 418D4107 		leal	7(%r9), %eax
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6815              		.loc 1 437 29 view .LVU1888
 6816 5a94 6641890C 		movw	%cx, (%r11,%rsi)
 6816      33
 6817              		.loc 1 439 9 is_stmt 1 view .LVU1889
 435:sepia_filter.c ****     {
 6818              		.loc 1 435 38 view .LVU1890
 6819              	.LVL210:
 435:sepia_filter.c ****     {
 6820              		.loc 1 435 5 view .LVU1891
 6821 5a99 4139C7   		cmpl	%eax, %r15d
 6822 5a9c 0F8E8501 		jle	.L149
 6822      0000
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6823              		.loc 1 437 9 view .LVU1892
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6824              		.loc 1 437 36 is_stmt 0 view .LVU1893
 6825 5aa2 4898     		cltq
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6826              		.loc 1 437 29 view .LVU1894
 6827 5aa4 0FB63C03 		movzbl	(%rbx,%rax), %edi
 6828 5aa8 410FB654 		movzbl	0(%r13,%rax), %edx
 6828      0500
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6829              		.loc 1 437 21 view .LVU1895
 6830 5aae 418D7015 		leal	21(%r8), %esi
 6831              		.loc 1 439 29 view .LVU1896
 6832 5ab2 410FB604 		movzbl	(%r10,%rax), %eax
 6832      02
 6833              	.LVL211:
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6834              		.loc 1 437 21 view .LVU1897
 6835 5ab7 4863F6   		movslq	%esi, %rsi
 438:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 6836              		.loc 1 438 9 is_stmt 1 view .LVU1898
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6837              		.loc 1 437 29 is_stmt 0 view .LVU1899
 6838 5aba 89F9     		movl	%edi, %ecx
 6839              		.loc 1 439 29 view .LVU1900
 6840 5abc 41884433 		movb	%al, 2(%r11,%rsi)
 6840      02
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6841              		.loc 1 437 29 view .LVU1901
 6842 5ac1 88D5     		movb	%dl, %ch
 435:sepia_filter.c ****     {
 6843              		.loc 1 435 38 view .LVU1902
 6844 5ac3 418D4108 		leal	8(%r9), %eax
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6845              		.loc 1 437 29 view .LVU1903
 6846 5ac7 6641890C 		movw	%cx, (%r11,%rsi)
 6846      33
 6847              		.loc 1 439 9 is_stmt 1 view .LVU1904
 435:sepia_filter.c ****     {
 6848              		.loc 1 435 38 view .LVU1905
 6849              	.LVL212:
 435:sepia_filter.c ****     {
 6850              		.loc 1 435 5 view .LVU1906
 6851 5acc 4139C7   		cmpl	%eax, %r15d
 6852 5acf 0F8E5201 		jle	.L149
 6852      0000
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6853              		.loc 1 437 9 view .LVU1907
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6854              		.loc 1 437 36 is_stmt 0 view .LVU1908
 6855 5ad5 4898     		cltq
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6856              		.loc 1 437 29 view .LVU1909
 6857 5ad7 0FB63C03 		movzbl	(%rbx,%rax), %edi
 6858 5adb 410FB654 		movzbl	0(%r13,%rax), %edx
 6858      0500
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6859              		.loc 1 437 21 view .LVU1910
 6860 5ae1 418D7018 		leal	24(%r8), %esi
 6861              		.loc 1 439 29 view .LVU1911
 6862 5ae5 410FB604 		movzbl	(%r10,%rax), %eax
 6862      02
 6863              	.LVL213:
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6864              		.loc 1 437 21 view .LVU1912
 6865 5aea 4863F6   		movslq	%esi, %rsi
 438:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 6866              		.loc 1 438 9 is_stmt 1 view .LVU1913
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6867              		.loc 1 437 29 is_stmt 0 view .LVU1914
 6868 5aed 89F9     		movl	%edi, %ecx
 6869              		.loc 1 439 29 view .LVU1915
 6870 5aef 41884433 		movb	%al, 2(%r11,%rsi)
 6870      02
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6871              		.loc 1 437 29 view .LVU1916
 6872 5af4 88D5     		movb	%dl, %ch
 435:sepia_filter.c ****     {
 6873              		.loc 1 435 38 view .LVU1917
 6874 5af6 418D4109 		leal	9(%r9), %eax
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6875              		.loc 1 437 29 view .LVU1918
 6876 5afa 6641890C 		movw	%cx, (%r11,%rsi)
 6876      33
 6877              		.loc 1 439 9 is_stmt 1 view .LVU1919
 435:sepia_filter.c ****     {
 6878              		.loc 1 435 38 view .LVU1920
 6879              	.LVL214:
 435:sepia_filter.c ****     {
 6880              		.loc 1 435 5 view .LVU1921
 6881 5aff 4139C7   		cmpl	%eax, %r15d
 6882 5b02 0F8E1F01 		jle	.L149
 6882      0000
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6883              		.loc 1 437 9 view .LVU1922
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6884              		.loc 1 437 36 is_stmt 0 view .LVU1923
 6885 5b08 4898     		cltq
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6886              		.loc 1 437 29 view .LVU1924
 6887 5b0a 0FB63C03 		movzbl	(%rbx,%rax), %edi
 6888 5b0e 410FB654 		movzbl	0(%r13,%rax), %edx
 6888      0500
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6889              		.loc 1 437 21 view .LVU1925
 6890 5b14 418D701B 		leal	27(%r8), %esi
 6891              		.loc 1 439 29 view .LVU1926
 6892 5b18 410FB604 		movzbl	(%r10,%rax), %eax
 6892      02
 6893              	.LVL215:
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6894              		.loc 1 437 21 view .LVU1927
 6895 5b1d 4863F6   		movslq	%esi, %rsi
 438:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 6896              		.loc 1 438 9 is_stmt 1 view .LVU1928
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6897              		.loc 1 437 29 is_stmt 0 view .LVU1929
 6898 5b20 89F9     		movl	%edi, %ecx
 6899              		.loc 1 439 29 view .LVU1930
 6900 5b22 41884433 		movb	%al, 2(%r11,%rsi)
 6900      02
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6901              		.loc 1 437 29 view .LVU1931
 6902 5b27 88D5     		movb	%dl, %ch
 435:sepia_filter.c ****     {
 6903              		.loc 1 435 38 view .LVU1932
 6904 5b29 418D410A 		leal	10(%r9), %eax
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6905              		.loc 1 437 29 view .LVU1933
 6906 5b2d 6641890C 		movw	%cx, (%r11,%rsi)
 6906      33
 6907              		.loc 1 439 9 is_stmt 1 view .LVU1934
 435:sepia_filter.c ****     {
 6908              		.loc 1 435 38 view .LVU1935
 6909              	.LVL216:
 435:sepia_filter.c ****     {
 6910              		.loc 1 435 5 view .LVU1936
 6911 5b32 4139C7   		cmpl	%eax, %r15d
 6912 5b35 0F8EEC00 		jle	.L149
 6912      0000
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6913              		.loc 1 437 9 view .LVU1937
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6914              		.loc 1 437 36 is_stmt 0 view .LVU1938
 6915 5b3b 4898     		cltq
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6916              		.loc 1 437 29 view .LVU1939
 6917 5b3d 0FB63C03 		movzbl	(%rbx,%rax), %edi
 6918 5b41 410FB654 		movzbl	0(%r13,%rax), %edx
 6918      0500
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6919              		.loc 1 437 21 view .LVU1940
 6920 5b47 418D701E 		leal	30(%r8), %esi
 6921              		.loc 1 439 29 view .LVU1941
 6922 5b4b 410FB604 		movzbl	(%r10,%rax), %eax
 6922      02
 6923              	.LVL217:
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6924              		.loc 1 437 21 view .LVU1942
 6925 5b50 4863F6   		movslq	%esi, %rsi
 438:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 6926              		.loc 1 438 9 is_stmt 1 view .LVU1943
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6927              		.loc 1 437 29 is_stmt 0 view .LVU1944
 6928 5b53 89F9     		movl	%edi, %ecx
 6929              		.loc 1 439 29 view .LVU1945
 6930 5b55 41884433 		movb	%al, 2(%r11,%rsi)
 6930      02
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6931              		.loc 1 437 29 view .LVU1946
 6932 5b5a 88D5     		movb	%dl, %ch
 435:sepia_filter.c ****     {
 6933              		.loc 1 435 38 view .LVU1947
 6934 5b5c 418D410B 		leal	11(%r9), %eax
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6935              		.loc 1 437 29 view .LVU1948
 6936 5b60 6641890C 		movw	%cx, (%r11,%rsi)
 6936      33
 6937              		.loc 1 439 9 is_stmt 1 view .LVU1949
 435:sepia_filter.c ****     {
 6938              		.loc 1 435 38 view .LVU1950
 6939              	.LVL218:
 435:sepia_filter.c ****     {
 6940              		.loc 1 435 5 view .LVU1951
 6941 5b65 4139C7   		cmpl	%eax, %r15d
 6942 5b68 0F8EB900 		jle	.L149
 6942      0000
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6943              		.loc 1 437 9 view .LVU1952
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6944              		.loc 1 437 36 is_stmt 0 view .LVU1953
 6945 5b6e 4898     		cltq
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6946              		.loc 1 437 29 view .LVU1954
 6947 5b70 0FB63C03 		movzbl	(%rbx,%rax), %edi
 6948 5b74 410FB654 		movzbl	0(%r13,%rax), %edx
 6948      0500
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6949              		.loc 1 437 21 view .LVU1955
 6950 5b7a 418D7021 		leal	33(%r8), %esi
 6951              		.loc 1 439 29 view .LVU1956
 6952 5b7e 410FB604 		movzbl	(%r10,%rax), %eax
 6952      02
 6953              	.LVL219:
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6954              		.loc 1 437 21 view .LVU1957
 6955 5b83 4863F6   		movslq	%esi, %rsi
 438:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 6956              		.loc 1 438 9 is_stmt 1 view .LVU1958
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6957              		.loc 1 437 29 is_stmt 0 view .LVU1959
 6958 5b86 89F9     		movl	%edi, %ecx
 6959              		.loc 1 439 29 view .LVU1960
 6960 5b88 41884433 		movb	%al, 2(%r11,%rsi)
 6960      02
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6961              		.loc 1 437 29 view .LVU1961
 6962 5b8d 88D5     		movb	%dl, %ch
 435:sepia_filter.c ****     {
 6963              		.loc 1 435 38 view .LVU1962
 6964 5b8f 418D410C 		leal	12(%r9), %eax
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6965              		.loc 1 437 29 view .LVU1963
 6966 5b93 6641890C 		movw	%cx, (%r11,%rsi)
 6966      33
 6967              		.loc 1 439 9 is_stmt 1 view .LVU1964
 435:sepia_filter.c ****     {
 6968              		.loc 1 435 38 view .LVU1965
 6969              	.LVL220:
 435:sepia_filter.c ****     {
 6970              		.loc 1 435 5 view .LVU1966
 6971 5b98 4139C7   		cmpl	%eax, %r15d
 6972 5b9b 0F8E8600 		jle	.L149
 6972      0000
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6973              		.loc 1 437 9 view .LVU1967
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6974              		.loc 1 437 36 is_stmt 0 view .LVU1968
 6975 5ba1 4898     		cltq
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6976              		.loc 1 437 29 view .LVU1969
 6977 5ba3 0FB63C03 		movzbl	(%rbx,%rax), %edi
 6978 5ba7 410FB654 		movzbl	0(%r13,%rax), %edx
 6978      0500
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6979              		.loc 1 437 21 view .LVU1970
 6980 5bad 418D7024 		leal	36(%r8), %esi
 6981              		.loc 1 439 29 view .LVU1971
 6982 5bb1 410FB604 		movzbl	(%r10,%rax), %eax
 6982      02
 6983              	.LVL221:
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6984              		.loc 1 437 21 view .LVU1972
 6985 5bb6 4863F6   		movslq	%esi, %rsi
 438:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 6986              		.loc 1 438 9 is_stmt 1 view .LVU1973
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6987              		.loc 1 437 29 is_stmt 0 view .LVU1974
 6988 5bb9 89F9     		movl	%edi, %ecx
 6989              		.loc 1 439 29 view .LVU1975
 6990 5bbb 41884433 		movb	%al, 2(%r11,%rsi)
 6990      02
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6991              		.loc 1 437 29 view .LVU1976
 6992 5bc0 88D5     		movb	%dl, %ch
 435:sepia_filter.c ****     {
 6993              		.loc 1 435 38 view .LVU1977
 6994 5bc2 418D410D 		leal	13(%r9), %eax
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 6995              		.loc 1 437 29 view .LVU1978
 6996 5bc6 6641890C 		movw	%cx, (%r11,%rsi)
 6996      33
 6997              		.loc 1 439 9 is_stmt 1 view .LVU1979
 435:sepia_filter.c ****     {
 6998              		.loc 1 435 38 view .LVU1980
 6999              	.LVL222:
 435:sepia_filter.c ****     {
 7000              		.loc 1 435 5 view .LVU1981
 7001 5bcb 4139C7   		cmpl	%eax, %r15d
 7002 5bce 7E57     		jle	.L149
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 7003              		.loc 1 437 9 view .LVU1982
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 7004              		.loc 1 437 36 is_stmt 0 view .LVU1983
 7005 5bd0 4898     		cltq
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 7006              		.loc 1 437 29 view .LVU1984
 7007 5bd2 0FB63C03 		movzbl	(%rbx,%rax), %edi
 7008 5bd6 410FB654 		movzbl	0(%r13,%rax), %edx
 7008      0500
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 7009              		.loc 1 437 21 view .LVU1985
 7010 5bdc 418D7027 		leal	39(%r8), %esi
 7011              		.loc 1 439 29 view .LVU1986
 7012 5be0 410FB604 		movzbl	(%r10,%rax), %eax
 7012      02
 7013              	.LVL223:
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 7014              		.loc 1 437 21 view .LVU1987
 7015 5be5 4863F6   		movslq	%esi, %rsi
 438:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 7016              		.loc 1 438 9 is_stmt 1 view .LVU1988
 7017              		.loc 1 439 29 is_stmt 0 view .LVU1989
 7018 5be8 41884433 		movb	%al, 2(%r11,%rsi)
 7018      02
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 7019              		.loc 1 437 29 view .LVU1990
 7020 5bed 89F9     		movl	%edi, %ecx
 435:sepia_filter.c ****     {
 7021              		.loc 1 435 38 view .LVU1991
 7022 5bef 4489C8   		movl	%r9d, %eax
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 7023              		.loc 1 437 29 view .LVU1992
 7024 5bf2 88D5     		movb	%dl, %ch
 435:sepia_filter.c ****     {
 7025              		.loc 1 435 38 view .LVU1993
 7026 5bf4 83C00E   		addl	$14, %eax
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 7027              		.loc 1 437 29 view .LVU1994
 7028 5bf7 6641890C 		movw	%cx, (%r11,%rsi)
 7028      33
 7029              		.loc 1 439 9 is_stmt 1 view .LVU1995
 435:sepia_filter.c ****     {
 7030              		.loc 1 435 38 view .LVU1996
 7031              	.LVL224:
 435:sepia_filter.c ****     {
 7032              		.loc 1 435 5 view .LVU1997
 7033 5bfc 4139C7   		cmpl	%eax, %r15d
 7034 5bff 7E26     		jle	.L149
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 7035              		.loc 1 437 9 view .LVU1998
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 7036              		.loc 1 437 36 is_stmt 0 view .LVU1999
 7037 5c01 4898     		cltq
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 7038              		.loc 1 437 29 view .LVU2000
 7039 5c03 0FB63403 		movzbl	(%rbx,%rax), %esi
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 7040              		.loc 1 437 21 view .LVU2001
 7041 5c07 418D502A 		leal	42(%r8), %edx
 7042 5c0b 4C63CA   		movslq	%edx, %r9
 438:sepia_filter.c ****         pixels_out[3*i + 2] = B_out[i];
 7043              		.loc 1 438 9 is_stmt 1 view .LVU2002
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 7044              		.loc 1 437 29 is_stmt 0 view .LVU2003
 7045 5c0e 410FB654 		movzbl	0(%r13,%rax), %edx
 7045      0500
 7046 5c14 89F1     		movl	%esi, %ecx
 7047              		.loc 1 439 29 view .LVU2004
 7048 5c16 410FB604 		movzbl	(%r10,%rax), %eax
 7048      02
 7049              	.LVL225:
 437:sepia_filter.c ****         pixels_out[3*i + 1] = G_out[i]; 
 7050              		.loc 1 437 29 view .LVU2005
 7051 5c1b 88D5     		movb	%dl, %ch
 7052 5c1d 6643890C 		movw	%cx, (%r11,%r9)
 7052      0B
 7053              		.loc 1 439 9 is_stmt 1 view .LVU2006
 7054              		.loc 1 439 29 is_stmt 0 view .LVU2007
 7055 5c22 4388440B 		movb	%al, 2(%r11,%r9)
 7055      02
 435:sepia_filter.c ****     {
 7056              		.loc 1 435 38 is_stmt 1 view .LVU2008
 7057              	.LVL226:
 435:sepia_filter.c ****     {
 7058              		.loc 1 435 5 view .LVU2009
 7059              	.L149:
 435:sepia_filter.c ****     {
 7060              		.loc 1 435 5 is_stmt 0 view .LVU2010
 7061              	.LBE52:
 440:sepia_filter.c ****     }
 441:sepia_filter.c **** 
 442:sepia_filter.c ****     free(R_in); free(R_out);
 7062              		.loc 1 442 5 is_stmt 1 view .LVU2011
 7063 5c27 4C89E7   		movq	%r12, %rdi
 7064 5c2a E8000000 		call	free
 7064      00
 7065              	.LVL227:
 7066              		.loc 1 442 17 view .LVU2012
 443:sepia_filter.c **** }
 7067              		.loc 1 443 1 is_stmt 0 view .LVU2013
 7068 5c2f 4881C468 		addq	$360, %rsp
 7068      010000
 442:sepia_filter.c **** }
 7069              		.loc 1 442 17 view .LVU2014
 7070 5c36 4889DF   		movq	%rbx, %rdi
 7071              		.loc 1 443 1 view .LVU2015
 7072 5c39 5B       		popq	%rbx
 7073              	.LVL228:
 7074              		.loc 1 443 1 view .LVU2016
 7075 5c3a 415C     		popq	%r12
 7076              	.LVL229:
 7077              		.loc 1 443 1 view .LVU2017
 7078 5c3c 415D     		popq	%r13
 7079              		.cfi_remember_state
 7080              		.cfi_def_cfa 13, 0
 7081              	.LVL230:
 7082              		.loc 1 443 1 view .LVU2018
 7083 5c3e 415E     		popq	%r14
 7084 5c40 415F     		popq	%r15
 7085 5c42 5D       		popq	%rbp
 7086              	.LVL231:
 7087              		.loc 1 443 1 view .LVU2019
 7088 5c43 498D65F0 		leaq	-16(%r13), %rsp
 7089              		.cfi_def_cfa 7, 16
 7090 5c47 415D     		popq	%r13
 7091              		.cfi_def_cfa_offset 8
 442:sepia_filter.c **** }
 7092              		.loc 1 442 17 view .LVU2020
 7093 5c49 E9000000 		jmp	free
 7093      00
 7094              	.LVL232:
 7095              	.L177:
 7096              		.cfi_restore_state
 7097              	.LBB53:
 427:sepia_filter.c ****     }
 7098              		.loc 1 427 9 is_stmt 1 view .LVU2021
 7099 5c4e 488BB5B8 		movq	-328(%rbp), %rsi
 7099      FEFFFF
 7100 5c55 488BBDB0 		movq	-336(%rbp), %rdi
 7100      FEFFFF
 7101 5c5c E8000000 		call	dummy
 7101      00
 7102              	.LVL233:
 405:sepia_filter.c ****     {
 7103              		.loc 1 405 34 view .LVU2022
 405:sepia_filter.c ****     {
 7104              		.loc 1 405 23 view .LVU2023
 7105 5c61 FF8DC0FE 		decl	-320(%rbp)
 7105      FFFF
 7106 5c67 0F850FF0 		jne	.L138
 7106      FFFF
 7107 5c6d E917FAFF 		jmp	.L146
 7107      FF
 7108              	.LVL234:
 7109              	.L156:
 7110              	.LBB49:
 409:sepia_filter.c ****         {
 7111              		.loc 1 409 18 is_stmt 0 view .LVU2024
 7112 5c72 31D2     		xorl	%edx, %edx
 7113 5c74 31C0     		xorl	%eax, %eax
 7114 5c76 E9E0F4FF 		jmp	.L139
 7114      FF
 7115              	.L141:
 409:sepia_filter.c ****         {
 7116              		.loc 1 409 18 view .LVU2025
 7117 5c7b 4C898D70 		movq	%r9, -144(%rbp)
 7117      FFFFFF
 7118 5c82 48894D90 		movq	%rcx, -112(%rbp)
 7119 5c86 4C8945B0 		movq	%r8, -80(%rbp)
 7120              	.LBE49:
 427:sepia_filter.c ****     }
 7121              		.loc 1 427 9 is_stmt 1 view .LVU2026
 7122 5c8a 488BB5B8 		movq	-328(%rbp), %rsi
 7122      FEFFFF
 7123 5c91 488BBDB0 		movq	-336(%rbp), %rdi
 7123      FEFFFF
 7124 5c98 C5F877   		vzeroupper
 7125              	.LVL235:
 7126 5c9b E9C5F9FF 		jmp	.L184
 7126      FF
 7127              	.LVL236:
 7128              	.L186:
 427:sepia_filter.c ****     }
 7129              		.loc 1 427 9 is_stmt 0 view .LVU2027
 7130 5ca0 488B85C8 		movq	-312(%rbp), %rax
 7130      FEFFFF
 7131 5ca7 4D8D0C06 		leaq	(%r14,%rax), %r9
 7132 5cab E958EFFF 		jmp	.L132
 7132      FF
 7133              	.LVL237:
 7134              	.L157:
 427:sepia_filter.c ****     }
 7135              		.loc 1 427 9 view .LVU2028
 7136              	.LBE53:
 7137              	.LBB54:
 435:sepia_filter.c ****     {
 7138              		.loc 1 435 5 view .LVU2029
 7139 5cb0 C785A8FE 		movl	$0, -344(%rbp)
 7139      FFFF0000 
 7139      0000
 435:sepia_filter.c ****     {
 7140              		.loc 1 435 14 view .LVU2030
 7141 5cba C785C4FE 		movl	$0, -316(%rbp)
 7141      FFFF0000 
 7141      0000
 7142 5cc4 E97FFBFF 		jmp	.L150
 7142      FF
 7143              	.LVL238:
 7144              	.L155:
 435:sepia_filter.c ****     {
 7145              		.loc 1 435 14 view .LVU2031
 7146 5cc9 488BBDC8 		movq	-312(%rbp), %rdi
 7146      FEFFFF
 7147              	.LBE54:
 7148              	.LBB55:
 397:sepia_filter.c ****     {
 7149              		.loc 1 397 5 view .LVU2032
 7150 5cd0 31F6     		xorl	%esi, %esi
 397:sepia_filter.c ****     {
 7151              		.loc 1 397 14 view .LVU2033
 7152 5cd2 31C0     		xorl	%eax, %eax
 7153 5cd4 4D8D0C3E 		leaq	(%r14,%rdi), %r9
 7154 5cd8 E981EBFF 		jmp	.L133
 7154      FF
 7155              	.LVL239:
 7156              	.L187:
 397:sepia_filter.c ****     {
 7157              		.loc 1 397 14 view .LVU2034
 7158 5cdd C5F877   		vzeroupper
 7159              	.LVL240:
 7160 5ce0 E923EFFF 		jmp	.L132
 7160      FF
 7161              	.LVL241:
 7162              	.L188:
 397:sepia_filter.c ****     {
 7163              		.loc 1 397 14 view .LVU2035
 7164 5ce5 C5F877   		vzeroupper
 7165              	.LVL242:
 7166 5ce8 E93AFFFF 		jmp	.L149
 7166      FF
 7167              	.LVL243:
 7168              	.L185:
 397:sepia_filter.c ****     {
 7169              		.loc 1 397 14 view .LVU2036
 7170              	.LBE55:
 375:sepia_filter.c ****         exit(-1);
 7171              		.loc 1 375 9 is_stmt 1 view .LVU2037
 7172 5ced BF000000 		movl	$.LC0, %edi
 7172      00
 7173              	.LVL244:
 375:sepia_filter.c ****         exit(-1);
 7174              		.loc 1 375 9 is_stmt 0 view .LVU2038
 7175 5cf2 E8000000 		call	puts
 7175      00
 7176              	.LVL245:
 376:sepia_filter.c ****     }
 7177              		.loc 1 376 9 is_stmt 1 view .LVU2039
 7178 5cf7 83CFFF   		orl	$-1, %edi
 7179 5cfa E8000000 		call	exit
 7179      00
 7180              	.LVL246:
 7181              		.cfi_endproc
 7182              	.LFE24:
 7184              		.section	.rodata.str1.1
 7185              	.LC113:
 7186 0061 73657069 		.string	"sepiaf_SOA1"
 7186      61665F53 
 7186      4F413100 
 7187              		.text
 7188 5cff 90       		.p2align 4
 7189              		.globl	sepia_filter_SOA1
 7191              	sepia_filter_SOA1:
 7192              	.LVL247:
 7193              	.LFB25:
 444:sepia_filter.c **** //----------------------------------------------------------------------------
 445:sepia_filter.c **** 
 446:sepia_filter.c **** /* como SOA0 pero contando el tiempo de la transformacion de datos */
 447:sepia_filter.c **** void
 448:sepia_filter.c **** sepia_filter_SOA1(image_t * restrict image_in, image_t * restrict image_out)
 449:sepia_filter.c **** {
 7194              		.loc 1 449 1 view -0
 7195              		.cfi_startproc
 450:sepia_filter.c ****     double start_t, end_t;
 7196              		.loc 1 450 5 view .LVU2041
 451:sepia_filter.c ****     const int height = image_in->height;
 7197              		.loc 1 451 5 view .LVU2042
 449:sepia_filter.c ****     double start_t, end_t;
 7198              		.loc 1 449 1 is_stmt 0 view .LVU2043
 7199 5d00 4155     		pushq	%r13
 7200              		.cfi_def_cfa_offset 16
 7201              		.cfi_offset 13, -16
 7202 5d02 4C8D6C24 		leaq	16(%rsp), %r13
 7202      10
 7203              		.cfi_def_cfa 13, 0
 7204 5d07 4883E4E0 		andq	$-32, %rsp
 7205 5d0b 41FF75F8 		pushq	-8(%r13)
 7206 5d0f 55       		pushq	%rbp
 7207 5d10 4889E5   		movq	%rsp, %rbp
 7208              		.cfi_escape 0x10,0x6,0x2,0x76,0
 7209 5d13 4157     		pushq	%r15
 7210 5d15 4156     		pushq	%r14
 7211 5d17 4155     		pushq	%r13
 7212              		.cfi_escape 0xf,0x3,0x76,0x68,0x6
 7213              		.cfi_escape 0x10,0xf,0x2,0x76,0x78
 7214              		.cfi_escape 0x10,0xe,0x2,0x76,0x70
 7215 5d19 4154     		pushq	%r12
 7216 5d1b 53       		pushq	%rbx
 7217 5d1c 4881EC88 		subq	$392, %rsp
 7217      010000
 7218              		.cfi_escape 0x10,0xc,0x2,0x76,0x60
 7219              		.cfi_escape 0x10,0x3,0x2,0x76,0x58
 452:sepia_filter.c ****     const int width =  image_in->width;
 7220              		.loc 1 452 15 view .LVU2044
 7221 5d23 C5FA7E47 		vmovq	8(%rdi), %xmm0
 7221      08
 453:sepia_filter.c ****     unsigned char *R_in, *G_in, *B_in, *R_out, *G_out, *B_out;
 454:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 455:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
 456:sepia_filter.c **** 
 457:sepia_filter.c ****     if (image_in->bytes_per_pixel != 3)
 7222              		.loc 1 457 8 view .LVU2045
 7223 5d28 837F1003 		cmpl	$3, 16(%rdi)
 449:sepia_filter.c ****     double start_t, end_t;
 7224              		.loc 1 449 1 view .LVU2046
 7225 5d2c 4889BD60 		movq	%rdi, -416(%rbp)
 7225      FEFFFF
 7226 5d33 4889B570 		movq	%rsi, -400(%rbp)
 7226      FEFFFF
 454:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
 7227              		.loc 1 454 30 view .LVU2047
 7228 5d3a 488B17   		movq	(%rdi), %rdx
 455:sepia_filter.c **** 
 7229              		.loc 1 455 30 view .LVU2048
 7230 5d3d 4C8B1E   		movq	(%rsi), %r11
 7231 5d40 C4E37916 		vpextrd	$1, %xmm0, %eax
 7231      C001
 7232              	.LVL248:
 452:sepia_filter.c ****     unsigned char *R_in, *G_in, *B_in, *R_out, *G_out, *B_out;
 7233              		.loc 1 452 5 is_stmt 1 view .LVU2049
 453:sepia_filter.c ****     unsigned char * restrict pixels_in  = image_in->pixels;
 7234              		.loc 1 453 5 view .LVU2050
 454:sepia_filter.c ****     unsigned char * restrict pixels_out = image_out->pixels;
 7235              		.loc 1 454 5 view .LVU2051
 455:sepia_filter.c **** 
 7236              		.loc 1 455 5 view .LVU2052
 7237              		.loc 1 457 5 view .LVU2053
 7238              		.loc 1 457 8 is_stmt 0 view .LVU2054
 7239 5d46 0F859817 		jne	.L237
 7239      0000
 7240 5d4c C4C1797E 		vmovd	%xmm0, %r13d
 7240      C5
 458:sepia_filter.c ****     {
 459:sepia_filter.c ****         printf("ERROR: input image has to be RGB\n");
 460:sepia_filter.c ****         exit(-1);
 461:sepia_filter.c ****     }
 462:sepia_filter.c ****     
 463:sepia_filter.c ****     /* fill struct fields */
 464:sepia_filter.c ****     image_out->width  = width;
 465:sepia_filter.c ****     image_out->height = height;
 466:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
 467:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 468:sepia_filter.c **** 
 469:sepia_filter.c ****     /* transform data layout */
 470:sepia_filter.c ****     R_in = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
 7241              		.loc 1 470 63 view .LVU2055
 7242 5d51 440FAFE8 		imull	%eax, %r13d
 7243 5d55 48899550 		movq	%rdx, -176(%rbp)
 7243      FFFFFF
 464:sepia_filter.c ****     image_out->height = height;
 7244              		.loc 1 464 5 is_stmt 1 view .LVU2056
 465:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
 7245              		.loc 1 465 5 view .LVU2057
 464:sepia_filter.c ****     image_out->height = height;
 7246              		.loc 1 464 23 is_stmt 0 view .LVU2058
 7247 5d5c 488B9570 		movq	-400(%rbp), %rdx
 7247      FEFFFF
 7248              	.LVL249:
 7249              		.loc 1 470 63 view .LVU2059
 7250 5d63 478D742D 		leal	(%r13,%r13), %r14d
 7250      00
 466:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 7251              		.loc 1 466 32 view .LVU2060
 7252 5d68 48B90300 		movabsq	$8589934595, %rcx
 7252      00000200 
 7252      0000
 7253 5d72 48894A10 		movq	%rcx, 16(%rdx)
 7254              		.loc 1 470 63 view .LVU2061
 7255 5d76 438D1C2E 		leal	(%r14,%r13), %ebx
 7256              		.loc 1 470 30 view .LVU2062
 7257 5d7a 4863DB   		movslq	%ebx, %rbx
 464:sepia_filter.c ****     image_out->height = height;
 7258              		.loc 1 464 23 view .LVU2063
 7259 5d7d C5F9D642 		vmovq	%xmm0, 8(%rdx)
 7259      08
 466:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 7260              		.loc 1 466 5 is_stmt 1 view .LVU2064
 467:sepia_filter.c **** 
 7261              		.loc 1 467 5 view .LVU2065
 7262              		.loc 1 470 5 view .LVU2066
 7263              		.loc 1 470 30 is_stmt 0 view .LVU2067
 7264 5d82 4889DE   		movq	%rbx, %rsi
 7265              	.LVL250:
 7266              		.loc 1 470 30 view .LVU2068
 7267 5d85 BF200000 		movl	$32, %edi
 7267      00
 7268              	.LVL251:
 7269              		.loc 1 470 30 view .LVU2069
 7270 5d8a 4C899D30 		movq	%r11, -208(%rbp)
 7270      FFFFFF
 7271 5d91 E8000000 		call	aligned_alloc
 7271      00
 7272              	.LVL252:
 7273              		.loc 1 470 30 view .LVU2070
 7274 5d96 4989C4   		movq	%rax, %r12
 7275              	.LVL253:
 471:sepia_filter.c ****     G_in = R_in + 1*width*height;
 7276              		.loc 1 471 5 is_stmt 1 view .LVU2071
 472:sepia_filter.c ****     B_in = R_in + 2*width*height;
 7277              		.loc 1 472 26 is_stmt 0 view .LVU2072
 7278 5d99 4963CE   		movslq	%r14d, %rcx
 7279              		.loc 1 472 10 view .LVU2073
 7280 5d9c 498D140C 		leaq	(%r12,%rcx), %rdx
 471:sepia_filter.c ****     G_in = R_in + 1*width*height;
 7281              		.loc 1 471 26 view .LVU2074
 7282 5da0 4963C5   		movslq	%r13d, %rax
 7283              	.LVL254:
 473:sepia_filter.c **** 
 474:sepia_filter.c ****     R_out = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
 7284              		.loc 1 474 31 view .LVU2075
 7285 5da3 4889DE   		movq	%rbx, %rsi
 7286 5da6 BF200000 		movl	$32, %edi
 7286      00
 471:sepia_filter.c ****     B_in = R_in + 2*width*height;
 7287              		.loc 1 471 10 view .LVU2076
 7288 5dab 4D8D3C04 		leaq	(%r12,%rax), %r15
 7289              	.LVL255:
 472:sepia_filter.c ****     B_in = R_in + 2*width*height;
 7290              		.loc 1 472 5 is_stmt 1 view .LVU2077
 472:sepia_filter.c ****     B_in = R_in + 2*width*height;
 7291              		.loc 1 472 10 is_stmt 0 view .LVU2078
 7292 5daf 48899588 		movq	%rdx, -376(%rbp)
 7292      FEFFFF
 7293              	.LVL256:
 7294              		.loc 1 474 5 is_stmt 1 view .LVU2079
 472:sepia_filter.c ****     B_in = R_in + 2*width*height;
 7295              		.loc 1 472 10 is_stmt 0 view .LVU2080
 7296 5db6 48894DB0 		movq	%rcx, -80(%rbp)
 471:sepia_filter.c ****     B_in = R_in + 2*width*height;
 7297              		.loc 1 471 10 view .LVU2081
 7298 5dba 488985C8 		movq	%rax, -312(%rbp)
 7298      FEFFFF
 7299              		.loc 1 474 31 view .LVU2082
 7300 5dc1 E8000000 		call	aligned_alloc
 7300      00
 7301              	.LVL257:
 7302              		.loc 1 474 31 view .LVU2083
 7303 5dc6 4889C3   		movq	%rax, %rbx
 7304              	.LVL258:
 475:sepia_filter.c ****     G_out = R_out + 1*width*height;
 7305              		.loc 1 475 5 is_stmt 1 view .LVU2084
 476:sepia_filter.c ****     B_out = R_out + 2*width*height;
 7306              		.loc 1 476 11 is_stmt 0 view .LVU2085
 7307 5dc9 488B4DB0 		movq	-80(%rbp), %rcx
 475:sepia_filter.c ****     G_out = R_out + 1*width*height;
 7308              		.loc 1 475 11 view .LVU2086
 7309 5dcd 488B85C8 		movq	-312(%rbp), %rax
 7309      FEFFFF
 7310              	.LVL259:
 7311              		.loc 1 476 11 view .LVU2087
 7312 5dd4 4801D9   		addq	%rbx, %rcx
 475:sepia_filter.c ****     G_out = R_out + 1*width*height;
 7313              		.loc 1 475 11 view .LVU2088
 7314 5dd7 4C8D3403 		leaq	(%rbx,%rax), %r14
 7315              	.LVL260:
 7316              		.loc 1 476 5 is_stmt 1 view .LVU2089
 477:sepia_filter.c **** 
 478:sepia_filter.c ****     start_t = get_wall_time();
 7317              		.loc 1 478 15 is_stmt 0 view .LVU2090
 7318 5ddb 31C0     		xorl	%eax, %eax
 476:sepia_filter.c ****     B_out = R_out + 2*width*height;
 7319              		.loc 1 476 11 view .LVU2091
 7320 5ddd 48894DB0 		movq	%rcx, -80(%rbp)
 7321              	.LVL261:
 7322              		.loc 1 478 5 is_stmt 1 view .LVU2092
 7323              		.loc 1 478 15 is_stmt 0 view .LVU2093
 7324 5de1 E8000000 		call	get_wall_time
 7324      00
 7325              	.LVL262:
 7326              		.loc 1 478 15 view .LVU2094
 7327 5de6 488B85C8 		movq	-312(%rbp), %rax
 7327      FEFFFF
 7328 5ded 418D55FF 		leal	-1(%r13), %edx
 7329 5df1 4C8D0400 		leaq	(%rax,%rax), %r8
 7330 5df5 4B8D0404 		leaq	(%r12,%r8), %rax
 7331 5df9 48898578 		movq	%rax, -392(%rbp)
 7331      FEFFFF
 7332 5e00 4489E8   		movl	%r13d, %eax
 7333 5e03 C1E805   		shrl	$5, %eax
 7334 5e06 48C1E005 		salq	$5, %rax
 7335 5e0a 48898580 		movq	%rax, -384(%rbp)
 7335      FEFFFF
 7336 5e11 4C01E0   		addq	%r12, %rax
 7337 5e14 48898558 		movq	%rax, -424(%rbp)
 7337      FEFFFF
 7338 5e1b 4489E8   		movl	%r13d, %eax
 7339 5e1e 4901D8   		addq	%rbx, %r8
 7340 5e21 83E0E0   		andl	$-32, %eax
 7341 5e24 8995C4FE 		movl	%edx, -316(%rbp)
 7341      FFFF
 7342 5e2a C7856CFE 		movl	$10, -404(%rbp)
 7342      FFFF0A00 
 7342      0000
 7343 5e34 8985C0FE 		movl	%eax, -320(%rbp)
 7343      FFFF
 7344 5e3a 4C894590 		movq	%r8, -112(%rbp)
 7345 5e3e 4889D8   		movq	%rbx, %rax
 7346 5e41 4C89BD70 		movq	%r15, -144(%rbp)
 7346      FFFFFF
 7347 5e48 4589E8   		movl	%r13d, %r8d
 7348 5e4b 4C8BBD30 		movq	-208(%rbp), %r15
 7348      FFFFFF
 7349              	.LVL263:
 7350              		.loc 1 478 15 view .LVU2095
 7351 5e52 4D89F5   		movq	%r14, %r13
 7352 5e55 4C8BB550 		movq	-176(%rbp), %r14
 7352      FFFFFF
 7353              	.LVL264:
 7354              		.loc 1 478 15 view .LVU2096
 7355 5e5c 4C89E3   		movq	%r12, %rbx
 7356              	.LVL265:
 7357              		.loc 1 478 15 view .LVU2097
 7358 5e5f C5FB1185 		vmovsd	%xmm0, -432(%rbp)
 7358      50FEFFFF 
 7359              	.LVL266:
 479:sepia_filter.c ****     for (int it=0; it < NITER; it++)
 7360              		.loc 1 479 5 is_stmt 1 view .LVU2098
 7361              	.LBB56:
 7362              		.loc 1 479 10 view .LVU2099
 7363              		.loc 1 479 23 view .LVU2100
 7364 5e67 4989C4   		movq	%rax, %r12
 7365              	.LVL267:
 7366              	.L191:
 7367              	.LBB57:
 480:sepia_filter.c ****     {
 481:sepia_filter.c ****         /* transformación AoS -> SoA */
 482:sepia_filter.c ****         /* COMPLETAR ... */
 483:sepia_filter.c ****         #pragma GCC ivdep
 484:sepia_filter.c ****         for (int i = 0; i < height*width; i++)
 7368              		.loc 1 484 9 view .LVU2101
 7369 5e6a 4585C0   		testl	%r8d, %r8d
 7370 5e6d 0F8E1A16 		jle	.L232
 7370      0000
 7371 5e73 488B4DB0 		movq	-80(%rbp), %rcx
 7372 5e77 4C89E0   		movq	%r12, %rax
 7373 5e7a 4D89FB   		movq	%r15, %r11
 7374 5e7d 488945B0 		movq	%rax, -80(%rbp)
 7375              	.LVL268:
 7376              		.loc 1 484 9 is_stmt 0 view .LVU2102
 7377 5e81 4C8BBD70 		movq	-144(%rbp), %r15
 7377      FFFFFF
 7378 5e88 48898D70 		movq	%rcx, -144(%rbp)
 7378      FFFFFF
 7379              	.LVL269:
 7380              		.loc 1 484 9 view .LVU2103
 7381 5e8f 4C89F2   		movq	%r14, %rdx
 7382 5e92 4D89EE   		movq	%r13, %r14
 7383 5e95 4589C5   		movl	%r8d, %r13d
 7384              	.LVL270:
 7385              		.loc 1 484 9 view .LVU2104
 7386 5e98 4C8B4590 		movq	-112(%rbp), %r8
 7387 5e9c 4989DC   		movq	%rbx, %r12
 7388              	.LVL271:
 7389 5e9f 90       		.p2align 4,,10
 7390              		.p2align 3
 7391              	.L210:
 7392              		.loc 1 484 9 view .LVU2105
 7393 5ea0 83BDC4FE 		cmpl	$30, -316(%rbp)
 7393      FFFF1E
 7394 5ea7 0F861B16 		jbe	.L212
 7394      0000
 7395              	.LBE57:
 7396              	.LBE56:
 449:sepia_filter.c ****     double start_t, end_t;
 7397              		.loc 1 449 1 view .LVU2106
 7398 5ead 488BBD78 		movq	-392(%rbp), %rdi
 7398      FEFFFF
 7399 5eb4 C57D6F2D 		vmovdqa	.LC15(%rip), %ymm13
 7399      00000000 
 7400 5ebc C57D6F25 		vmovdqa	.LC16(%rip), %ymm12
 7400      00000000 
 7401 5ec4 C57D6F1D 		vmovdqa	.LC17(%rip), %ymm11
 7401      00000000 
 7402 5ecc C57D6F15 		vmovdqa	.LC18(%rip), %ymm10
 7402      00000000 
 7403 5ed4 C5FD6F25 		vmovdqa	.LC25(%rip), %ymm4
 7403      00000000 
 7404 5edc C57D6F0D 		vmovdqa	.LC27(%rip), %ymm9
 7404      00000000 
 7405 5ee4 C57D6F05 		vmovdqa	.LC28(%rip), %ymm8
 7405      00000000 
 7406 5eec C5FD6F3D 		vmovdqa	.LC29(%rip), %ymm7
 7406      00000000 
 7407 5ef4 C5FD6F35 		vmovdqa	.LC30(%rip), %ymm6
 7407      00000000 
 7408 5efc C5FD6F2D 		vmovdqa	.LC31(%rip), %ymm5
 7408      00000000 
 7409 5f04 4C8B9558 		movq	-424(%rbp), %r10
 7409      FEFFFF
 7410 5f0b 488B5DB0 		movq	-80(%rbp), %rbx
 7411 5f0f 488B8D70 		movq	-144(%rbp), %rcx
 7411      FFFFFF
 7412 5f16 4889D0   		movq	%rdx, %rax
 7413 5f19 4D89F9   		movq	%r15, %r9
 7414 5f1c 4C89E6   		movq	%r12, %rsi
 7415 5f1f 90       		.p2align 4,,10
 7416              		.p2align 3
 7417              	.L193:
 7418              	.LBB66:
 7419              	.LBB58:
 485:sepia_filter.c ****         {
 486:sepia_filter.c ****             R_in[i] = pixels_in[3*i + 0];
 7420              		.loc 1 486 13 is_stmt 1 discriminator 3 view .LVU2107
 7421              		.loc 1 486 32 is_stmt 0 discriminator 3 view .LVU2108
 7422 5f20 C5FE6F00 		vmovdqu	(%rax), %ymm0
 7423 5f24 C5FE6F48 		vmovdqu	64(%rax), %ymm1
 7423      40
 7424 5f29 C5FE6F50 		vmovdqu	32(%rax), %ymm2
 7424      20
 7425 5f2e C4427D00 		vpshufb	%ymm13, %ymm0, %ymm15
 7425      FD
 7426 5f33 C443FD00 		vpermq	$78, %ymm15, %ymm15
 7426      FF4E
 7427 5f39 C4C27D00 		vpshufb	%ymm12, %ymm0, %ymm3
 7427      DC
 7428 5f3e C4426D00 		vpshufb	%ymm11, %ymm2, %ymm14
 7428      F3
 7429 5f43 C4C165EB 		vpor	%ymm15, %ymm3, %ymm3
 7429      DF
 7430 5f48 C4427500 		vpshufb	%ymm10, %ymm1, %ymm15
 7430      FA
 7431 5f4d C4C165EB 		vpor	%ymm14, %ymm3, %ymm3
 7431      DE
 7432 5f52 C443FD00 		vpermq	$78, %ymm15, %ymm15
 7432      FF4E
 7433 5f58 C4627500 		vpshufb	.LC20(%rip), %ymm1, %ymm14
 7433      35000000 
 7433      00
 7434 5f61 C4410DEB 		vpor	%ymm15, %ymm14, %ymm14
 7434      F7
 7435 5f66 C4E26500 		vpshufb	.LC19(%rip), %ymm3, %ymm3
 7435      1D000000 
 7435      00
 7436 5f6f C4C165EB 		vpor	%ymm14, %ymm3, %ymm3
 7436      DE
 7437 5f74 C4627D00 		vpshufb	.LC21(%rip), %ymm0, %ymm15
 7437      3D000000 
 7437      00
 7438              		.loc 1 486 21 discriminator 3 view .LVU2109
 7439 5f7d C5FD7F1E 		vmovdqa	%ymm3, (%rsi)
 487:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7440              		.loc 1 487 13 is_stmt 1 discriminator 3 view .LVU2110
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7441              		.loc 1 486 32 is_stmt 0 discriminator 3 view .LVU2111
 7442 5f81 C443FD00 		vpermq	$78, %ymm15, %ymm15
 7442      FF4E
 7443 5f87 C4E27D00 		vpshufb	.LC22(%rip), %ymm0, %ymm3
 7443      1D000000 
 7443      00
 7444 5f90 C4626D00 		vpshufb	.LC23(%rip), %ymm2, %ymm14
 7444      35000000 
 7444      00
 7445 5f99 C4C165EB 		vpor	%ymm15, %ymm3, %ymm3
 7445      DF
 7446 5f9e C4627500 		vpshufb	.LC24(%rip), %ymm1, %ymm15
 7446      3D000000 
 7446      00
 7447 5fa7 C4C165EB 		vpor	%ymm14, %ymm3, %ymm3
 7447      DE
 7448 5fac C443FD00 		vpermq	$78, %ymm15, %ymm15
 7448      FF4E
 7449 5fb2 C4627500 		vpshufb	.LC26(%rip), %ymm1, %ymm14
 7449      35000000 
 7449      00
 7450 5fbb C4E26500 		vpshufb	%ymm4, %ymm3, %ymm3
 7450      DC
 7451 5fc0 C4410DEB 		vpor	%ymm15, %ymm14, %ymm14
 7451      F7
 7452 5fc5 C4C165EB 		vpor	%ymm14, %ymm3, %ymm3
 7452      DE
 7453              		.loc 1 487 21 discriminator 3 view .LVU2112
 7454 5fca C4C17E7F 		vmovdqu	%ymm3, (%r9)
 7454      19
 488:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7455              		.loc 1 488 13 is_stmt 1 discriminator 3 view .LVU2113
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7456              		.loc 1 486 32 is_stmt 0 discriminator 3 view .LVU2114
 7457 5fcf C4C27D00 		vpshufb	%ymm9, %ymm0, %ymm3
 7457      D9
 7458 5fd4 C4E3FD00 		vpermq	$78, %ymm3, %ymm3
 7458      DB4E
 7459 5fda C4C27D00 		vpshufb	%ymm8, %ymm0, %ymm0
 7459      C0
 7460 5fdf C4E26D00 		vpshufb	%ymm7, %ymm2, %ymm2
 7460      D7
 7461 5fe4 C5FDEBC3 		vpor	%ymm3, %ymm0, %ymm0
 7462 5fe8 C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 7463 5fec C4E27500 		vpshufb	%ymm6, %ymm1, %ymm2
 7463      D6
 7464 5ff1 C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 7464      D24E
 7465 5ff7 C4E27500 		vpshufb	%ymm5, %ymm1, %ymm1
 7465      CD
 7466 5ffc C4E27D00 		vpshufb	%ymm4, %ymm0, %ymm0
 7466      C4
 7467 6001 C5F5EBCA 		vpor	%ymm2, %ymm1, %ymm1
 7468 6005 C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 7469 6009 4883C620 		addq	$32, %rsi
 7470              		.loc 1 488 21 discriminator 3 view .LVU2115
 7471 600d C5FE7F07 		vmovdqu	%ymm0, (%rdi)
 484:sepia_filter.c ****         {
 7472              		.loc 1 484 44 is_stmt 1 discriminator 3 view .LVU2116
 484:sepia_filter.c ****         {
 7473              		.loc 1 484 9 discriminator 3 view .LVU2117
 7474 6011 4883C060 		addq	$96, %rax
 7475 6015 4983C120 		addq	$32, %r9
 7476 6019 4883C720 		addq	$32, %rdi
 7477 601d 4939F2   		cmpq	%rsi, %r10
 7478 6020 0F85FAFE 		jne	.L193
 7478      FFFF
 7479 6026 8B85C0FE 		movl	-320(%rbp), %eax
 7479      FFFF
 7480 602c 48895DB0 		movq	%rbx, -80(%rbp)
 7481 6030 48898D70 		movq	%rcx, -144(%rbp)
 7481      FFFFFF
 7482              		.loc 1 488 21 is_stmt 0 view .LVU2118
 7483 6037 89C6     		movl	%eax, %esi
 7484 6039 4139C5   		cmpl	%eax, %r13d
 7485 603c 0F84CB03 		je	.L194
 7485      0000
 7486              	.L192:
 7487              		.loc 1 488 21 view .LVU2119
 7488 6042 4589E9   		movl	%r13d, %r9d
 7489 6045 4129F1   		subl	%esi, %r9d
 7490 6048 418D79FF 		leal	-1(%r9), %edi
 7491 604c 83FF0E   		cmpl	$14, %edi
 7492 604f 0F86BB00 		jbe	.L195
 7492      0000
 7493 6055 488D3C76 		leaq	(%rsi,%rsi,2), %rdi
 7494 6059 4801D7   		addq	%rdx, %rdi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7495              		.loc 1 486 32 view .LVU2120
 7496 605c C5FA6F07 		vmovdqu	(%rdi), %xmm0
 7497 6060 C5FA6F57 		vmovdqu	16(%rdi), %xmm2
 7497      10
 7498 6065 C5FA6F4F 		vmovdqu	32(%rdi), %xmm1
 7498      20
 7499 606a C4E26900 		vpshufb	.LC66(%rip), %xmm2, %xmm4
 7499      25000000 
 7499      00
 7500 6073 C4E27900 		vpshufb	.LC65(%rip), %xmm0, %xmm3
 7500      1D000000 
 7500      00
 7501 607c C5E1EBDC 		vpor	%xmm4, %xmm3, %xmm3
 7502 6080 C5F96F25 		vmovdqa	.LC68(%rip), %xmm4
 7502      00000000 
 7503 6088 C4E27100 		vpshufb	.LC67(%rip), %xmm1, %xmm5
 7503      2D000000 
 7503      00
 7504 6091 488B8DC8 		movq	-312(%rbp), %rcx
 7504      FEFFFF
 7505 6098 C4E3614C 		vpblendvb	%xmm4, %xmm5, %xmm3, %xmm3
 7505      DD40
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7506              		.loc 1 486 21 view .LVU2121
 7507 609e C4C1797F 		vmovdqa	%xmm3, (%r12,%rsi)
 7507      1C34
 7508 60a4 4C8D1431 		leaq	(%rcx,%rsi), %r10
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7509              		.loc 1 486 13 is_stmt 1 view .LVU2122
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7510              		.loc 1 487 13 view .LVU2123
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7511              		.loc 1 486 32 is_stmt 0 view .LVU2124
 7512 60a8 C4E26900 		vpshufb	.LC70(%rip), %xmm2, %xmm5
 7512      2D000000 
 7512      00
 7513 60b1 C4E27900 		vpshufb	.LC69(%rip), %xmm0, %xmm3
 7513      1D000000 
 7513      00
 7514 60ba 4489CE   		movl	%r9d, %esi
 7515 60bd C4E27900 		vpshufb	.LC72(%rip), %xmm0, %xmm0
 7515      05000000 
 7515      00
 7516 60c6 C4E26900 		vpshufb	.LC73(%rip), %xmm2, %xmm2
 7516      15000000 
 7516      00
 7517 60cf C5E1EBDD 		vpor	%xmm5, %xmm3, %xmm3
 7518 60d3 83E6F0   		andl	$-16, %esi
 7519 60d6 C4E27100 		vpshufb	.LC71(%rip), %xmm1, %xmm5
 7519      2D000000 
 7519      00
 7520 60df C5F9EBC2 		vpor	%xmm2, %xmm0, %xmm0
 7521 60e3 C4E27100 		vpshufb	.LC74(%rip), %xmm1, %xmm1
 7521      0D000000 
 7521      00
 7522 60ec C4E3614C 		vpblendvb	%xmm4, %xmm5, %xmm3, %xmm3
 7522      DD40
 7523 60f2 C4E3790E 		vpblendw	$224, %xmm1, %xmm0, %xmm0
 7523      C1E0
 7524 60f8 01F0     		addl	%esi, %eax
 7525 60fa 4183E10F 		andl	$15, %r9d
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7526              		.loc 1 487 21 view .LVU2125
 7527 60fe C4817A7F 		vmovdqu	%xmm3, (%r12,%r10)
 7527      1C14
 7528              		.loc 1 488 13 is_stmt 1 view .LVU2126
 7529              		.loc 1 488 21 is_stmt 0 view .LVU2127
 7530 6104 C4817A7F 		vmovdqu	%xmm0, (%r15,%r10)
 7530      0417
 484:sepia_filter.c ****         {
 7531              		.loc 1 484 44 is_stmt 1 view .LVU2128
 484:sepia_filter.c ****         {
 7532              		.loc 1 484 9 view .LVU2129
 7533 610a 0F84F002 		je	.L196
 7533      0000
 7534              	.L195:
 7535              	.LVL272:
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7536              		.loc 1 486 13 view .LVU2130
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7537              		.loc 1 486 34 is_stmt 0 view .LVU2131
 7538 6110 8D3440   		leal	(%rax,%rax,2), %esi
 7539 6113 4C63CE   		movslq	%esi, %r9
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7540              		.loc 1 486 21 view .LVU2132
 7541 6116 460FB614 		movzbl	(%rdx,%r9), %r10d
 7541      0A
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7542              		.loc 1 486 17 view .LVU2133
 7543 611b 4863F8   		movslq	%eax, %rdi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7544              		.loc 1 486 21 view .LVU2134
 7545 611e 4588143C 		movb	%r10b, (%r12,%rdi)
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7546              		.loc 1 487 13 is_stmt 1 view .LVU2135
 7547              		.loc 1 488 21 is_stmt 0 view .LVU2136
 7548 6122 488B9D88 		movq	-376(%rbp), %rbx
 7548      FEFFFF
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7549              		.loc 1 487 21 view .LVU2137
 7550 6129 460FB654 		movzbl	1(%rdx,%r9), %r10d
 7550      0A01
 7551              		.loc 1 488 21 view .LVU2138
 7552 612f 460FB64C 		movzbl	2(%rdx,%r9), %r9d
 7552      0A02
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7553              		.loc 1 487 21 view .LVU2139
 7554 6135 4588143F 		movb	%r10b, (%r15,%rdi)
 7555              		.loc 1 488 13 is_stmt 1 view .LVU2140
 7556              		.loc 1 488 21 is_stmt 0 view .LVU2141
 7557 6139 44880C3B 		movb	%r9b, (%rbx,%rdi)
 484:sepia_filter.c ****         {
 7558              		.loc 1 484 44 is_stmt 1 view .LVU2142
 7559 613d 8D7801   		leal	1(%rax), %edi
 7560              	.LVL273:
 484:sepia_filter.c ****         {
 7561              		.loc 1 484 9 view .LVU2143
 7562 6140 4139FD   		cmpl	%edi, %r13d
 7563 6143 0F8EB702 		jle	.L196
 7563      0000
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7564              		.loc 1 486 13 view .LVU2144
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7565              		.loc 1 486 34 is_stmt 0 view .LVU2145
 7566 6149 448D4E03 		leal	3(%rsi), %r9d
 7567 614d 4D63C9   		movslq	%r9d, %r9
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7568              		.loc 1 486 21 view .LVU2146
 7569 6150 460FB614 		movzbl	(%rdx,%r9), %r10d
 7569      0A
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7570              		.loc 1 486 17 view .LVU2147
 7571 6155 4863FF   		movslq	%edi, %rdi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7572              		.loc 1 486 21 view .LVU2148
 7573 6158 4588143C 		movb	%r10b, (%r12,%rdi)
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7574              		.loc 1 487 13 is_stmt 1 view .LVU2149
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7575              		.loc 1 487 21 is_stmt 0 view .LVU2150
 7576 615c 460FB654 		movzbl	1(%rdx,%r9), %r10d
 7576      0A01
 7577              		.loc 1 488 21 view .LVU2151
 7578 6162 460FB64C 		movzbl	2(%rdx,%r9), %r9d
 7578      0A02
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7579              		.loc 1 487 21 view .LVU2152
 7580 6168 4588143F 		movb	%r10b, (%r15,%rdi)
 7581              		.loc 1 488 13 is_stmt 1 view .LVU2153
 7582              		.loc 1 488 21 is_stmt 0 view .LVU2154
 7583 616c 44880C3B 		movb	%r9b, (%rbx,%rdi)
 484:sepia_filter.c ****         {
 7584              		.loc 1 484 44 is_stmt 1 view .LVU2155
 7585 6170 8D7802   		leal	2(%rax), %edi
 7586              	.LVL274:
 484:sepia_filter.c ****         {
 7587              		.loc 1 484 9 view .LVU2156
 7588 6173 4139FD   		cmpl	%edi, %r13d
 7589 6176 0F8E8402 		jle	.L196
 7589      0000
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7590              		.loc 1 486 13 view .LVU2157
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7591              		.loc 1 486 34 is_stmt 0 view .LVU2158
 7592 617c 448D4E06 		leal	6(%rsi), %r9d
 7593 6180 4D63C9   		movslq	%r9d, %r9
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7594              		.loc 1 486 21 view .LVU2159
 7595 6183 460FB614 		movzbl	(%rdx,%r9), %r10d
 7595      0A
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7596              		.loc 1 486 17 view .LVU2160
 7597 6188 4863FF   		movslq	%edi, %rdi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7598              		.loc 1 486 21 view .LVU2161
 7599 618b 4588143C 		movb	%r10b, (%r12,%rdi)
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7600              		.loc 1 487 13 is_stmt 1 view .LVU2162
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7601              		.loc 1 487 21 is_stmt 0 view .LVU2163
 7602 618f 460FB654 		movzbl	1(%rdx,%r9), %r10d
 7602      0A01
 7603              		.loc 1 488 21 view .LVU2164
 7604 6195 460FB64C 		movzbl	2(%rdx,%r9), %r9d
 7604      0A02
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7605              		.loc 1 487 21 view .LVU2165
 7606 619b 4588143F 		movb	%r10b, (%r15,%rdi)
 7607              		.loc 1 488 13 is_stmt 1 view .LVU2166
 7608              		.loc 1 488 21 is_stmt 0 view .LVU2167
 7609 619f 44880C3B 		movb	%r9b, (%rbx,%rdi)
 484:sepia_filter.c ****         {
 7610              		.loc 1 484 44 is_stmt 1 view .LVU2168
 7611 61a3 8D7803   		leal	3(%rax), %edi
 7612              	.LVL275:
 484:sepia_filter.c ****         {
 7613              		.loc 1 484 9 view .LVU2169
 7614 61a6 4139FD   		cmpl	%edi, %r13d
 7615 61a9 0F8E5102 		jle	.L196
 7615      0000
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7616              		.loc 1 486 13 view .LVU2170
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7617              		.loc 1 486 34 is_stmt 0 view .LVU2171
 7618 61af 448D4E09 		leal	9(%rsi), %r9d
 7619 61b3 4D63C9   		movslq	%r9d, %r9
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7620              		.loc 1 486 21 view .LVU2172
 7621 61b6 460FB614 		movzbl	(%rdx,%r9), %r10d
 7621      0A
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7622              		.loc 1 486 17 view .LVU2173
 7623 61bb 4863FF   		movslq	%edi, %rdi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7624              		.loc 1 486 21 view .LVU2174
 7625 61be 4588143C 		movb	%r10b, (%r12,%rdi)
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7626              		.loc 1 487 13 is_stmt 1 view .LVU2175
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7627              		.loc 1 487 21 is_stmt 0 view .LVU2176
 7628 61c2 460FB654 		movzbl	1(%rdx,%r9), %r10d
 7628      0A01
 7629              		.loc 1 488 21 view .LVU2177
 7630 61c8 460FB64C 		movzbl	2(%rdx,%r9), %r9d
 7630      0A02
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7631              		.loc 1 487 21 view .LVU2178
 7632 61ce 4588143F 		movb	%r10b, (%r15,%rdi)
 7633              		.loc 1 488 13 is_stmt 1 view .LVU2179
 7634              		.loc 1 488 21 is_stmt 0 view .LVU2180
 7635 61d2 44880C3B 		movb	%r9b, (%rbx,%rdi)
 484:sepia_filter.c ****         {
 7636              		.loc 1 484 44 is_stmt 1 view .LVU2181
 7637 61d6 8D7804   		leal	4(%rax), %edi
 7638              	.LVL276:
 484:sepia_filter.c ****         {
 7639              		.loc 1 484 9 view .LVU2182
 7640 61d9 4139FD   		cmpl	%edi, %r13d
 7641 61dc 0F8E1E02 		jle	.L196
 7641      0000
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7642              		.loc 1 486 13 view .LVU2183
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7643              		.loc 1 486 34 is_stmt 0 view .LVU2184
 7644 61e2 448D4E0C 		leal	12(%rsi), %r9d
 7645 61e6 4D63C9   		movslq	%r9d, %r9
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7646              		.loc 1 486 21 view .LVU2185
 7647 61e9 460FB614 		movzbl	(%rdx,%r9), %r10d
 7647      0A
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7648              		.loc 1 486 17 view .LVU2186
 7649 61ee 4863FF   		movslq	%edi, %rdi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7650              		.loc 1 486 21 view .LVU2187
 7651 61f1 4588143C 		movb	%r10b, (%r12,%rdi)
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7652              		.loc 1 487 13 is_stmt 1 view .LVU2188
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7653              		.loc 1 487 21 is_stmt 0 view .LVU2189
 7654 61f5 460FB654 		movzbl	1(%rdx,%r9), %r10d
 7654      0A01
 7655              		.loc 1 488 21 view .LVU2190
 7656 61fb 460FB64C 		movzbl	2(%rdx,%r9), %r9d
 7656      0A02
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7657              		.loc 1 487 21 view .LVU2191
 7658 6201 4588143F 		movb	%r10b, (%r15,%rdi)
 7659              		.loc 1 488 13 is_stmt 1 view .LVU2192
 7660              		.loc 1 488 21 is_stmt 0 view .LVU2193
 7661 6205 44880C3B 		movb	%r9b, (%rbx,%rdi)
 484:sepia_filter.c ****         {
 7662              		.loc 1 484 44 is_stmt 1 view .LVU2194
 7663 6209 8D7805   		leal	5(%rax), %edi
 7664              	.LVL277:
 484:sepia_filter.c ****         {
 7665              		.loc 1 484 9 view .LVU2195
 7666 620c 4139FD   		cmpl	%edi, %r13d
 7667 620f 0F8EEB01 		jle	.L196
 7667      0000
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7668              		.loc 1 486 13 view .LVU2196
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7669              		.loc 1 486 34 is_stmt 0 view .LVU2197
 7670 6215 448D4E0F 		leal	15(%rsi), %r9d
 7671 6219 4D63C9   		movslq	%r9d, %r9
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7672              		.loc 1 486 21 view .LVU2198
 7673 621c 460FB614 		movzbl	(%rdx,%r9), %r10d
 7673      0A
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7674              		.loc 1 486 17 view .LVU2199
 7675 6221 4863FF   		movslq	%edi, %rdi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7676              		.loc 1 486 21 view .LVU2200
 7677 6224 4588143C 		movb	%r10b, (%r12,%rdi)
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7678              		.loc 1 487 13 is_stmt 1 view .LVU2201
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7679              		.loc 1 487 21 is_stmt 0 view .LVU2202
 7680 6228 460FB654 		movzbl	1(%rdx,%r9), %r10d
 7680      0A01
 7681              		.loc 1 488 21 view .LVU2203
 7682 622e 460FB64C 		movzbl	2(%rdx,%r9), %r9d
 7682      0A02
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7683              		.loc 1 487 21 view .LVU2204
 7684 6234 4588143F 		movb	%r10b, (%r15,%rdi)
 7685              		.loc 1 488 13 is_stmt 1 view .LVU2205
 7686              		.loc 1 488 21 is_stmt 0 view .LVU2206
 7687 6238 44880C3B 		movb	%r9b, (%rbx,%rdi)
 484:sepia_filter.c ****         {
 7688              		.loc 1 484 44 is_stmt 1 view .LVU2207
 7689 623c 8D7806   		leal	6(%rax), %edi
 7690              	.LVL278:
 484:sepia_filter.c ****         {
 7691              		.loc 1 484 9 view .LVU2208
 7692 623f 4139FD   		cmpl	%edi, %r13d
 7693 6242 0F8EB801 		jle	.L196
 7693      0000
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7694              		.loc 1 486 13 view .LVU2209
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7695              		.loc 1 486 34 is_stmt 0 view .LVU2210
 7696 6248 448D4E12 		leal	18(%rsi), %r9d
 7697 624c 4D63C9   		movslq	%r9d, %r9
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7698              		.loc 1 486 21 view .LVU2211
 7699 624f 460FB614 		movzbl	(%rdx,%r9), %r10d
 7699      0A
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7700              		.loc 1 486 17 view .LVU2212
 7701 6254 4863FF   		movslq	%edi, %rdi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7702              		.loc 1 486 21 view .LVU2213
 7703 6257 4588143C 		movb	%r10b, (%r12,%rdi)
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7704              		.loc 1 487 13 is_stmt 1 view .LVU2214
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7705              		.loc 1 487 21 is_stmt 0 view .LVU2215
 7706 625b 460FB654 		movzbl	1(%rdx,%r9), %r10d
 7706      0A01
 7707              		.loc 1 488 21 view .LVU2216
 7708 6261 460FB64C 		movzbl	2(%rdx,%r9), %r9d
 7708      0A02
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7709              		.loc 1 487 21 view .LVU2217
 7710 6267 4588143F 		movb	%r10b, (%r15,%rdi)
 7711              		.loc 1 488 13 is_stmt 1 view .LVU2218
 7712              		.loc 1 488 21 is_stmt 0 view .LVU2219
 7713 626b 44880C3B 		movb	%r9b, (%rbx,%rdi)
 484:sepia_filter.c ****         {
 7714              		.loc 1 484 44 is_stmt 1 view .LVU2220
 7715 626f 8D7807   		leal	7(%rax), %edi
 7716              	.LVL279:
 484:sepia_filter.c ****         {
 7717              		.loc 1 484 9 view .LVU2221
 7718 6272 4139FD   		cmpl	%edi, %r13d
 7719 6275 0F8E8501 		jle	.L196
 7719      0000
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7720              		.loc 1 486 13 view .LVU2222
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7721              		.loc 1 486 34 is_stmt 0 view .LVU2223
 7722 627b 448D4E15 		leal	21(%rsi), %r9d
 7723 627f 4D63C9   		movslq	%r9d, %r9
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7724              		.loc 1 486 21 view .LVU2224
 7725 6282 460FB614 		movzbl	(%rdx,%r9), %r10d
 7725      0A
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7726              		.loc 1 486 17 view .LVU2225
 7727 6287 4863FF   		movslq	%edi, %rdi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7728              		.loc 1 486 21 view .LVU2226
 7729 628a 4588143C 		movb	%r10b, (%r12,%rdi)
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7730              		.loc 1 487 13 is_stmt 1 view .LVU2227
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7731              		.loc 1 487 21 is_stmt 0 view .LVU2228
 7732 628e 460FB654 		movzbl	1(%rdx,%r9), %r10d
 7732      0A01
 7733              		.loc 1 488 21 view .LVU2229
 7734 6294 460FB64C 		movzbl	2(%rdx,%r9), %r9d
 7734      0A02
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7735              		.loc 1 487 21 view .LVU2230
 7736 629a 4588143F 		movb	%r10b, (%r15,%rdi)
 7737              		.loc 1 488 13 is_stmt 1 view .LVU2231
 7738              		.loc 1 488 21 is_stmt 0 view .LVU2232
 7739 629e 44880C3B 		movb	%r9b, (%rbx,%rdi)
 484:sepia_filter.c ****         {
 7740              		.loc 1 484 44 is_stmt 1 view .LVU2233
 7741 62a2 8D7808   		leal	8(%rax), %edi
 7742              	.LVL280:
 484:sepia_filter.c ****         {
 7743              		.loc 1 484 9 view .LVU2234
 7744 62a5 4139FD   		cmpl	%edi, %r13d
 7745 62a8 0F8E5201 		jle	.L196
 7745      0000
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7746              		.loc 1 486 13 view .LVU2235
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7747              		.loc 1 486 34 is_stmt 0 view .LVU2236
 7748 62ae 448D4E18 		leal	24(%rsi), %r9d
 7749 62b2 4D63C9   		movslq	%r9d, %r9
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7750              		.loc 1 486 21 view .LVU2237
 7751 62b5 460FB614 		movzbl	(%rdx,%r9), %r10d
 7751      0A
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7752              		.loc 1 486 17 view .LVU2238
 7753 62ba 4863FF   		movslq	%edi, %rdi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7754              		.loc 1 486 21 view .LVU2239
 7755 62bd 4588143C 		movb	%r10b, (%r12,%rdi)
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7756              		.loc 1 487 13 is_stmt 1 view .LVU2240
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7757              		.loc 1 487 21 is_stmt 0 view .LVU2241
 7758 62c1 460FB654 		movzbl	1(%rdx,%r9), %r10d
 7758      0A01
 7759              		.loc 1 488 21 view .LVU2242
 7760 62c7 460FB64C 		movzbl	2(%rdx,%r9), %r9d
 7760      0A02
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7761              		.loc 1 487 21 view .LVU2243
 7762 62cd 4588143F 		movb	%r10b, (%r15,%rdi)
 7763              		.loc 1 488 13 is_stmt 1 view .LVU2244
 7764              		.loc 1 488 21 is_stmt 0 view .LVU2245
 7765 62d1 44880C3B 		movb	%r9b, (%rbx,%rdi)
 484:sepia_filter.c ****         {
 7766              		.loc 1 484 44 is_stmt 1 view .LVU2246
 7767 62d5 8D7809   		leal	9(%rax), %edi
 7768              	.LVL281:
 484:sepia_filter.c ****         {
 7769              		.loc 1 484 9 view .LVU2247
 7770 62d8 4139FD   		cmpl	%edi, %r13d
 7771 62db 0F8E1F01 		jle	.L196
 7771      0000
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7772              		.loc 1 486 13 view .LVU2248
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7773              		.loc 1 486 34 is_stmt 0 view .LVU2249
 7774 62e1 448D4E1B 		leal	27(%rsi), %r9d
 7775 62e5 4D63C9   		movslq	%r9d, %r9
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7776              		.loc 1 486 21 view .LVU2250
 7777 62e8 460FB614 		movzbl	(%rdx,%r9), %r10d
 7777      0A
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7778              		.loc 1 486 17 view .LVU2251
 7779 62ed 4863FF   		movslq	%edi, %rdi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7780              		.loc 1 486 21 view .LVU2252
 7781 62f0 4588143C 		movb	%r10b, (%r12,%rdi)
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7782              		.loc 1 487 13 is_stmt 1 view .LVU2253
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7783              		.loc 1 487 21 is_stmt 0 view .LVU2254
 7784 62f4 460FB654 		movzbl	1(%rdx,%r9), %r10d
 7784      0A01
 7785              		.loc 1 488 21 view .LVU2255
 7786 62fa 460FB64C 		movzbl	2(%rdx,%r9), %r9d
 7786      0A02
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7787              		.loc 1 487 21 view .LVU2256
 7788 6300 4588143F 		movb	%r10b, (%r15,%rdi)
 7789              		.loc 1 488 13 is_stmt 1 view .LVU2257
 7790              		.loc 1 488 21 is_stmt 0 view .LVU2258
 7791 6304 44880C3B 		movb	%r9b, (%rbx,%rdi)
 484:sepia_filter.c ****         {
 7792              		.loc 1 484 44 is_stmt 1 view .LVU2259
 7793 6308 8D780A   		leal	10(%rax), %edi
 7794              	.LVL282:
 484:sepia_filter.c ****         {
 7795              		.loc 1 484 9 view .LVU2260
 7796 630b 4139FD   		cmpl	%edi, %r13d
 7797 630e 0F8EEC00 		jle	.L196
 7797      0000
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7798              		.loc 1 486 13 view .LVU2261
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7799              		.loc 1 486 34 is_stmt 0 view .LVU2262
 7800 6314 448D4E1E 		leal	30(%rsi), %r9d
 7801 6318 4D63C9   		movslq	%r9d, %r9
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7802              		.loc 1 486 21 view .LVU2263
 7803 631b 460FB614 		movzbl	(%rdx,%r9), %r10d
 7803      0A
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7804              		.loc 1 486 17 view .LVU2264
 7805 6320 4863FF   		movslq	%edi, %rdi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7806              		.loc 1 486 21 view .LVU2265
 7807 6323 4588143C 		movb	%r10b, (%r12,%rdi)
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7808              		.loc 1 487 13 is_stmt 1 view .LVU2266
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7809              		.loc 1 487 21 is_stmt 0 view .LVU2267
 7810 6327 460FB654 		movzbl	1(%rdx,%r9), %r10d
 7810      0A01
 7811              		.loc 1 488 21 view .LVU2268
 7812 632d 460FB64C 		movzbl	2(%rdx,%r9), %r9d
 7812      0A02
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7813              		.loc 1 487 21 view .LVU2269
 7814 6333 4588143F 		movb	%r10b, (%r15,%rdi)
 7815              		.loc 1 488 13 is_stmt 1 view .LVU2270
 7816              		.loc 1 488 21 is_stmt 0 view .LVU2271
 7817 6337 44880C3B 		movb	%r9b, (%rbx,%rdi)
 484:sepia_filter.c ****         {
 7818              		.loc 1 484 44 is_stmt 1 view .LVU2272
 7819 633b 8D780B   		leal	11(%rax), %edi
 7820              	.LVL283:
 484:sepia_filter.c ****         {
 7821              		.loc 1 484 9 view .LVU2273
 7822 633e 4139FD   		cmpl	%edi, %r13d
 7823 6341 0F8EB900 		jle	.L196
 7823      0000
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7824              		.loc 1 486 13 view .LVU2274
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7825              		.loc 1 486 34 is_stmt 0 view .LVU2275
 7826 6347 448D4E21 		leal	33(%rsi), %r9d
 7827 634b 4D63C9   		movslq	%r9d, %r9
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7828              		.loc 1 486 21 view .LVU2276
 7829 634e 460FB614 		movzbl	(%rdx,%r9), %r10d
 7829      0A
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7830              		.loc 1 486 17 view .LVU2277
 7831 6353 4863FF   		movslq	%edi, %rdi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7832              		.loc 1 486 21 view .LVU2278
 7833 6356 4588143C 		movb	%r10b, (%r12,%rdi)
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7834              		.loc 1 487 13 is_stmt 1 view .LVU2279
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7835              		.loc 1 487 21 is_stmt 0 view .LVU2280
 7836 635a 460FB654 		movzbl	1(%rdx,%r9), %r10d
 7836      0A01
 7837              		.loc 1 488 21 view .LVU2281
 7838 6360 460FB64C 		movzbl	2(%rdx,%r9), %r9d
 7838      0A02
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7839              		.loc 1 487 21 view .LVU2282
 7840 6366 4588143F 		movb	%r10b, (%r15,%rdi)
 7841              		.loc 1 488 13 is_stmt 1 view .LVU2283
 7842              		.loc 1 488 21 is_stmt 0 view .LVU2284
 7843 636a 44880C3B 		movb	%r9b, (%rbx,%rdi)
 484:sepia_filter.c ****         {
 7844              		.loc 1 484 44 is_stmt 1 view .LVU2285
 7845 636e 8D780C   		leal	12(%rax), %edi
 7846              	.LVL284:
 484:sepia_filter.c ****         {
 7847              		.loc 1 484 9 view .LVU2286
 7848 6371 4139FD   		cmpl	%edi, %r13d
 7849 6374 0F8E8600 		jle	.L196
 7849      0000
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7850              		.loc 1 486 13 view .LVU2287
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7851              		.loc 1 486 34 is_stmt 0 view .LVU2288
 7852 637a 448D4E24 		leal	36(%rsi), %r9d
 7853 637e 4D63C9   		movslq	%r9d, %r9
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7854              		.loc 1 486 21 view .LVU2289
 7855 6381 460FB614 		movzbl	(%rdx,%r9), %r10d
 7855      0A
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7856              		.loc 1 486 17 view .LVU2290
 7857 6386 4863FF   		movslq	%edi, %rdi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7858              		.loc 1 486 21 view .LVU2291
 7859 6389 4588143C 		movb	%r10b, (%r12,%rdi)
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7860              		.loc 1 487 13 is_stmt 1 view .LVU2292
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7861              		.loc 1 487 21 is_stmt 0 view .LVU2293
 7862 638d 460FB654 		movzbl	1(%rdx,%r9), %r10d
 7862      0A01
 7863              		.loc 1 488 21 view .LVU2294
 7864 6393 460FB64C 		movzbl	2(%rdx,%r9), %r9d
 7864      0A02
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7865              		.loc 1 487 21 view .LVU2295
 7866 6399 4588143F 		movb	%r10b, (%r15,%rdi)
 7867              		.loc 1 488 13 is_stmt 1 view .LVU2296
 7868              		.loc 1 488 21 is_stmt 0 view .LVU2297
 7869 639d 44880C3B 		movb	%r9b, (%rbx,%rdi)
 484:sepia_filter.c ****         {
 7870              		.loc 1 484 44 is_stmt 1 view .LVU2298
 7871 63a1 8D780D   		leal	13(%rax), %edi
 7872              	.LVL285:
 484:sepia_filter.c ****         {
 7873              		.loc 1 484 9 view .LVU2299
 7874 63a4 4139FD   		cmpl	%edi, %r13d
 7875 63a7 7E57     		jle	.L196
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7876              		.loc 1 486 13 view .LVU2300
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7877              		.loc 1 486 34 is_stmt 0 view .LVU2301
 7878 63a9 448D4E27 		leal	39(%rsi), %r9d
 7879 63ad 4D63C9   		movslq	%r9d, %r9
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7880              		.loc 1 486 21 view .LVU2302
 7881 63b0 460FB614 		movzbl	(%rdx,%r9), %r10d
 7881      0A
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7882              		.loc 1 486 17 view .LVU2303
 7883 63b5 4863FF   		movslq	%edi, %rdi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7884              		.loc 1 486 21 view .LVU2304
 7885 63b8 4588143C 		movb	%r10b, (%r12,%rdi)
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7886              		.loc 1 487 13 is_stmt 1 view .LVU2305
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7887              		.loc 1 487 21 is_stmt 0 view .LVU2306
 7888 63bc 460FB654 		movzbl	1(%rdx,%r9), %r10d
 7888      0A01
 7889              		.loc 1 488 21 view .LVU2307
 7890 63c2 460FB64C 		movzbl	2(%rdx,%r9), %r9d
 7890      0A02
 484:sepia_filter.c ****         {
 7891              		.loc 1 484 44 view .LVU2308
 7892 63c8 83C00E   		addl	$14, %eax
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7893              		.loc 1 487 21 view .LVU2309
 7894 63cb 4588143F 		movb	%r10b, (%r15,%rdi)
 7895              		.loc 1 488 13 is_stmt 1 view .LVU2310
 7896              		.loc 1 488 21 is_stmt 0 view .LVU2311
 7897 63cf 44880C3B 		movb	%r9b, (%rbx,%rdi)
 484:sepia_filter.c ****         {
 7898              		.loc 1 484 44 is_stmt 1 view .LVU2312
 7899              	.LVL286:
 484:sepia_filter.c ****         {
 7900              		.loc 1 484 9 view .LVU2313
 7901 63d3 4139C5   		cmpl	%eax, %r13d
 7902 63d6 7E28     		jle	.L196
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7903              		.loc 1 486 13 view .LVU2314
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7904              		.loc 1 486 34 is_stmt 0 view .LVU2315
 7905 63d8 83C62A   		addl	$42, %esi
 7906 63db 4863F6   		movslq	%esi, %rsi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7907              		.loc 1 486 21 view .LVU2316
 7908 63de 0FB63C32 		movzbl	(%rdx,%rsi), %edi
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7909              		.loc 1 486 17 view .LVU2317
 7910 63e2 4898     		cltq
 486:sepia_filter.c ****             G_in[i] = pixels_in[3*i + 1]; 
 7911              		.loc 1 486 21 view .LVU2318
 7912 63e4 41883C04 		movb	%dil, (%r12,%rax)
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7913              		.loc 1 487 13 is_stmt 1 view .LVU2319
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7914              		.loc 1 487 21 is_stmt 0 view .LVU2320
 7915 63e8 0FB67C32 		movzbl	1(%rdx,%rsi), %edi
 7915      01
 7916              		.loc 1 488 21 view .LVU2321
 7917 63ed 0FB67432 		movzbl	2(%rdx,%rsi), %esi
 7917      02
 487:sepia_filter.c ****             B_in[i] = pixels_in[3*i + 2];
 7918              		.loc 1 487 21 view .LVU2322
 7919 63f2 41883C07 		movb	%dil, (%r15,%rax)
 7920              		.loc 1 488 13 is_stmt 1 view .LVU2323
 7921              		.loc 1 488 21 is_stmt 0 view .LVU2324
 7922 63f6 40883403 		movb	%sil, (%rbx,%rax)
 484:sepia_filter.c ****         {
 7923              		.loc 1 484 44 is_stmt 1 view .LVU2325
 7924              	.LVL287:
 484:sepia_filter.c ****         {
 7925              		.loc 1 484 9 view .LVU2326
 7926 63fa 660F1F44 		.p2align 4,,10
 7926      0000
 7927              		.p2align 3
 7928              	.L196:
 484:sepia_filter.c ****         {
 7929              		.loc 1 484 9 is_stmt 0 view .LVU2327
 7930 6400 83BDC4FE 		cmpl	$30, -316(%rbp)
 7930      FFFF1E
 7931 6407 0F86C410 		jbe	.L213
 7931      0000
 7932              	.L194:
 484:sepia_filter.c ****         {
 7933              		.loc 1 484 9 view .LVU2328
 7934              	.LBE58:
 7935              	.LBB59:
 489:sepia_filter.c ****         }
 490:sepia_filter.c **** 
 491:sepia_filter.c ****         /* COMPLETAR ... */
 492:sepia_filter.c ****         #pragma GCC ivdep
 493:sepia_filter.c ****         for (int i = 0; i < height*width; i++)
 494:sepia_filter.c ****         {
 495:sepia_filter.c ****             R_out[i] = (unsigned char) (fminf(MAXPIXV,
 7936              		.loc 1 495 24 discriminator 3 view .LVU2329
 7937 640d BEFFFF00 		movl	$65535, %esi
 7937      00
 7938 6412 C5796EFE 		vmovd	%esi, %xmm15
 7939 6416 BEFF0000 		movl	$255, %esi
 7939      00
 7940 641b C5F96EFE 		vmovd	%esi, %xmm7
 7941 641f C4E27D79 		vpbroadcastw	%xmm7, %ymm7
 7941      FF
 7942 6424 C4627D18 		vbroadcastss	.LC106(%rip), %ymm13
 7942      2D000000 
 7942      00
 7943 642d C4627D18 		vbroadcastss	.LC4(%rip), %ymm12
 7943      25000000 
 7943      00
 7944 6436 488B5DB0 		movq	-80(%rbp), %rbx
 7945 643a 488B8D70 		movq	-144(%rbp), %rcx
 7945      FFFFFF
 7946 6441 488BB580 		movq	-384(%rbp), %rsi
 7946      FEFFFF
 7947 6448 488BBD78 		movq	-392(%rbp), %rdi
 7947      FEFFFF
 7948              	.LBE59:
 7949              	.LBB60:
 484:sepia_filter.c ****         {
 7950              		.loc 1 484 18 discriminator 3 view .LVU2330
 7951 644f 31C0     		xorl	%eax, %eax
 7952              	.LBE60:
 7953              	.LBB61:
 7954              		.loc 1 495 24 discriminator 3 view .LVU2331
 7955 6451 C4427D58 		vpbroadcastd	%xmm15, %ymm15
 7955      FF
 7956 6456 C5FD7F7D 		vmovdqa	%ymm7, -112(%rbp)
 7956      90
 7957 645b 0F1F4400 		.p2align 4,,10
 7957      00
 7958              		.p2align 3
 7959              	.L198:
 7960              		.loc 1 495 13 is_stmt 1 discriminator 3 view .LVU2332
 496:sepia_filter.c ****                           0.5f +
 497:sepia_filter.c ****                           sepia[0][0]*R_in[i] + 
 7961              		.loc 1 497 43 is_stmt 0 discriminator 3 view .LVU2333
 7962 6460 C4C17D6F 		vmovdqa	(%r12,%rax), %ymm0
 7962      0404
 7963 6466 C4E27D30 		vpmovzxbw	%xmm0, %ymm1
 7963      C8
 7964 646b C4E27D33 		vpmovzxwd	%xmm1, %ymm2
 7964      D1
 7965 6470 C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 7965      C001
 7966 6476 C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 7966      C901
 7967 647c C4E27D30 		vpmovzxbw	%xmm0, %ymm0
 7967      C0
 7968 6481 C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 7968      C9
 7969              		.loc 1 497 38 discriminator 3 view .LVU2334
 7970 6486 C5FC5BE1 		vcvtdq2ps	%ymm1, %ymm4
 7971              		.loc 1 497 43 discriminator 3 view .LVU2335
 7972 648a C4E27D33 		vpmovzxwd	%xmm0, %ymm1
 7972      C8
 7973 648f C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 7973      C001
 7974 6495 C4E27D33 		vpmovzxwd	%xmm0, %ymm0
 7974      C0
 7975              		.loc 1 497 38 discriminator 3 view .LVU2336
 7976 649a C5FC5BF8 		vcvtdq2ps	%ymm0, %ymm7
 498:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 7977              		.loc 1 498 43 discriminator 3 view .LVU2337
 7978 649e C4C17E6F 		vmovdqu	(%r15,%rax), %ymm0
 7978      0407
 497:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 7979              		.loc 1 497 38 discriminator 3 view .LVU2338
 7980 64a4 C5FC5BD9 		vcvtdq2ps	%ymm1, %ymm3
 7981              		.loc 1 498 43 discriminator 3 view .LVU2339
 7982 64a8 C4E27D30 		vpmovzxbw	%xmm0, %ymm1
 7982      C8
 497:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 7983              		.loc 1 497 38 discriminator 3 view .LVU2340
 7984 64ad C5FC5BF2 		vcvtdq2ps	%ymm2, %ymm6
 7985              		.loc 1 498 43 discriminator 3 view .LVU2341
 7986 64b1 C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 7986      C001
 7987 64b7 C4E27D33 		vpmovzxwd	%xmm1, %ymm2
 7987      D1
 7988 64bc C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 7988      C901
 7989 64c2 C4E27D30 		vpmovzxbw	%xmm0, %ymm0
 7989      C0
 7990 64c7 C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 7990      C9
 7991              		.loc 1 498 38 discriminator 3 view .LVU2342
 7992 64cc C5FC5BEA 		vcvtdq2ps	%ymm2, %ymm5
 7993 64d0 C5FC5BD1 		vcvtdq2ps	%ymm1, %ymm2
 7994 64d4 C554591D 		vmulps	.LC32(%rip), %ymm5, %ymm11
 7994      00000000 
 7995 64dc C5FC29AD 		vmovaps	%ymm5, -240(%rbp)
 7995      10FFFFFF 
 7996              		.loc 1 498 43 discriminator 3 view .LVU2343
 7997 64e4 C4E27D33 		vpmovzxwd	%xmm0, %ymm1
 7997      C8
 7998              		.loc 1 498 38 discriminator 3 view .LVU2344
 7999 64e9 C5EC592D 		vmulps	.LC32(%rip), %ymm2, %ymm5
 7999      00000000 
 8000              		.loc 1 498 43 discriminator 3 view .LVU2345
 8001 64f1 C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 8001      C001
 8002 64f7 C4E27D33 		vpmovzxwd	%xmm0, %ymm0
 8002      C0
 8003              		.loc 1 498 38 discriminator 3 view .LVU2346
 8004 64fc C5FC5BC0 		vcvtdq2ps	%ymm0, %ymm0
 8005 6500 C57C590D 		vmulps	.LC32(%rip), %ymm0, %ymm9
 8005      00000000 
 8006 6508 C5FC2995 		vmovaps	%ymm2, -272(%rbp)
 8006      F0FEFFFF 
 499:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 8007              		.loc 1 499 43 discriminator 3 view .LVU2347
 8008 6510 C5FE6F14 		vmovdqu	(%rdi,%rax), %ymm2
 8008      07
 498:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 8009              		.loc 1 498 38 discriminator 3 view .LVU2348
 8010 6515 C5FC5BC9 		vcvtdq2ps	%ymm1, %ymm1
 8011 6519 C5745915 		vmulps	.LC32(%rip), %ymm1, %ymm10
 8011      00000000 
 8012 6521 C4E25DB8 		vfmadd231ps	.LC33(%rip), %ymm4, %ymm5
 8012      2D000000 
 8012      00
 8013 652a C5FC29A5 		vmovaps	%ymm4, -144(%rbp)
 8013      70FFFFFF 
 8014              		.loc 1 499 43 discriminator 3 view .LVU2349
 8015 6532 C4E27D30 		vpmovzxbw	%xmm2, %ymm4
 8015      E2
 8016 6537 C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 8016      D201
 8017 653d C4E27D30 		vpmovzxbw	%xmm2, %ymm2
 8017      D2
 8018 6542 C46245B8 		vfmadd231ps	.LC33(%rip), %ymm7, %ymm9
 8018      0D000000 
 8018      00
 8019 654b C5FC29BD 		vmovaps	%ymm7, -208(%rbp)
 8019      30FFFFFF 
 8020 6553 C4627D33 		vpmovzxwd	%xmm4, %ymm8
 8020      C4
 8021 6558 C4E27D33 		vpmovzxwd	%xmm2, %ymm7
 8021      FA
 8022 655d C4E37D39 		vextracti128	$0x1, %ymm4, %xmm4
 8022      E401
 8023 6563 C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 8023      D201
 8024 6569 C4E27D33 		vpmovzxwd	%xmm4, %ymm4
 8024      E4
 8025 656e C4E27D33 		vpmovzxwd	%xmm2, %ymm2
 8025      D2
 8026 6573 C4624DB8 		vfmadd231ps	.LC33(%rip), %ymm6, %ymm11
 8026      1D000000 
 8026      00
 8027 657c C46265B8 		vfmadd231ps	.LC33(%rip), %ymm3, %ymm10
 8027      15000000 
 8027      00
 8028 6585 C5FC2975 		vmovaps	%ymm6, -80(%rbp)
 8028      B0
 8029              		.loc 1 499 38 discriminator 3 view .LVU2350
 8030 658a C4417C5B 		vcvtdq2ps	%ymm8, %ymm8
 8030      C0
 8031 658f C5FC5BE4 		vcvtdq2ps	%ymm4, %ymm4
 8032 6593 C5FC5BFF 		vcvtdq2ps	%ymm7, %ymm7
 8033 6597 C5FC5BD2 		vcvtdq2ps	%ymm2, %ymm2
 498:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 8034              		.loc 1 498 38 discriminator 3 view .LVU2351
 8035 659b C5FC298D 		vmovaps	%ymm1, -304(%rbp)
 8035      D0FEFFFF 
 8036 65a3 C5FC299D 		vmovaps	%ymm3, -176(%rbp)
 8036      50FFFFFF 
 8037 65ab C57C29C1 		vmovaps	%ymm8, %ymm1
 8038 65af C57C28F4 		vmovaps	%ymm4, %ymm14
 8039 65b3 C5FC28DF 		vmovaps	%ymm7, %ymm3
 8040 65b7 C5FC28F2 		vmovaps	%ymm2, %ymm6
 8041 65bb C4621598 		vfmadd132ps	.LC34(%rip), %ymm13, %ymm14
 8041      35000000 
 8041      00
 8042 65c4 C4E21598 		vfmadd132ps	.LC34(%rip), %ymm13, %ymm1
 8042      0D000000 
 8042      00
 8043 65cd C4E21598 		vfmadd132ps	.LC34(%rip), %ymm13, %ymm3
 8043      1D000000 
 8043      00
 8044 65d6 C4E21598 		vfmadd132ps	.LC34(%rip), %ymm13, %ymm6
 8044      35000000 
 8044      00
 495:sepia_filter.c ****                           0.5f +
 8045              		.loc 1 495 41 discriminator 3 view .LVU2352
 8046 65df C4C15458 		vaddps	%ymm14, %ymm5, %ymm5
 8046      EE
 8047 65e4 C4C17458 		vaddps	%ymm11, %ymm1, %ymm1
 8047      CB
 8048 65e9 C4C16458 		vaddps	%ymm10, %ymm3, %ymm3
 8048      DA
 8049 65ee C4C14C58 		vaddps	%ymm9, %ymm6, %ymm6
 8049      F1
 8050 65f3 C4C1745D 		vminps	%ymm12, %ymm1, %ymm1
 8050      CC
 8051 65f8 C4C1545D 		vminps	%ymm12, %ymm5, %ymm5
 8051      EC
 8052 65fd C4C1645D 		vminps	%ymm12, %ymm3, %ymm3
 8052      DC
 8053 6602 C4C14C5D 		vminps	%ymm12, %ymm6, %ymm6
 8053      F4
 495:sepia_filter.c ****                           0.5f +
 8054              		.loc 1 495 24 discriminator 3 view .LVU2353
 8055 6607 C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 8056 660b C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 8057 660f C585DBC9 		vpand	%ymm1, %ymm15, %ymm1
 8058 6613 C585DBED 		vpand	%ymm5, %ymm15, %ymm5
 8059 6617 C5FE5BDB 		vcvttps2dq	%ymm3, %ymm3
 8060 661b C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 8061 661f C585DBDB 		vpand	%ymm3, %ymm15, %ymm3
 8062 6623 C585DBF6 		vpand	%ymm6, %ymm15, %ymm6
 8063 6627 C57D6F5D 		vmovdqa	-112(%rbp), %ymm11
 8063      90
 8064 662c C4E2752B 		vpackusdw	%ymm5, %ymm1, %ymm1
 8064      CD
 8065 6631 C4E2652B 		vpackusdw	%ymm6, %ymm3, %ymm3
 8065      DE
 8066 6636 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 8066      C9D8
 8067 663c C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 8067      DBD8
 8068 6642 C4C165DB 		vpand	%ymm11, %ymm3, %ymm3
 8068      DB
 8069 6647 C4C175DB 		vpand	%ymm11, %ymm1, %ymm1
 8069      CB
 500:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 501:sepia_filter.c ****                           0.5f +
 502:sepia_filter.c ****                           sepia[1][0]*R_in[i] + 
 503:sepia_filter.c ****                           sepia[1][1]*G_in[i] + 
 8070              		.loc 1 503 38 discriminator 3 view .LVU2354
 8071 664c C5FC28AD 		vmovaps	-240(%rbp), %ymm5
 8071      10FFFFFF 
 495:sepia_filter.c ****                           0.5f +
 8072              		.loc 1 495 24 discriminator 3 view .LVU2355
 8073 6654 C5F567CB 		vpackuswb	%ymm3, %ymm1, %ymm1
 8074 6658 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 8074      C9D8
 495:sepia_filter.c ****                           0.5f +
 8075              		.loc 1 495 22 discriminator 3 view .LVU2356
 8076 665e C5FD7F0C 		vmovdqa	%ymm1, (%rbx,%rax)
 8076      03
 500:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8077              		.loc 1 500 13 is_stmt 1 discriminator 3 view .LVU2357
 8078              		.loc 1 503 38 is_stmt 0 discriminator 3 view .LVU2358
 8079 6663 C5D4590D 		vmulps	.LC40(%rip), %ymm5, %ymm1
 8079      00000000 
 8080 666b C5FC2875 		vmovaps	-80(%rbp), %ymm6
 8080      B0
 8081 6670 C57C28B5 		vmovaps	-272(%rbp), %ymm14
 8081      F0FEFFFF 
 8082 6678 C5FC28AD 		vmovaps	-144(%rbp), %ymm5
 8082      70FFFFFF 
 8083 6680 C4E24DB8 		vfmadd231ps	.LC41(%rip), %ymm6, %ymm1
 8083      0D000000 
 8083      00
 8084 6689 C58C5935 		vmulps	.LC40(%rip), %ymm14, %ymm6
 8084      00000000 
 8085 6691 C4417C28 		vmovaps	%ymm8, %ymm14
 8085      F0
 8086 6696 C4E255B8 		vfmadd231ps	.LC41(%rip), %ymm5, %ymm6
 8086      35000000 
 8086      00
 8087 669f C57C288D 		vmovaps	-304(%rbp), %ymm9
 8087      D0FEFFFF 
 8088 66a7 C5FC592D 		vmulps	.LC40(%rip), %ymm0, %ymm5
 8088      00000000 
 8089 66af C5B4591D 		vmulps	.LC40(%rip), %ymm9, %ymm3
 8089      00000000 
 8090 66b7 C57C288D 		vmovaps	-208(%rbp), %ymm9
 8090      30FFFFFF 
 8091 66bf C57C2895 		vmovaps	-176(%rbp), %ymm10
 8091      50FFFFFF 
 8092 66c7 C4621598 		vfmadd132ps	.LC42(%rip), %ymm13, %ymm14
 8092      35000000 
 8092      00
 8093 66d0 C4E235B8 		vfmadd231ps	.LC41(%rip), %ymm9, %ymm5
 8093      2D000000 
 8093      00
 8094 66d9 C57C28CC 		vmovaps	%ymm4, %ymm9
 8095 66dd C4621598 		vfmadd132ps	.LC42(%rip), %ymm13, %ymm9
 8095      0D000000 
 8095      00
 8096 66e6 C4E22DB8 		vfmadd231ps	.LC41(%rip), %ymm10, %ymm3
 8096      1D000000 
 8096      00
 8097 66ef C57C28D7 		vmovaps	%ymm7, %ymm10
 8098 66f3 C4621598 		vfmadd132ps	.LC42(%rip), %ymm13, %ymm10
 8098      15000000 
 8098      00
 500:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8099              		.loc 1 500 41 discriminator 3 view .LVU2359
 8100 66fc C4C17458 		vaddps	%ymm14, %ymm1, %ymm1
 8100      CE
 8101 6701 C4417C28 		vmovaps	%ymm9, %ymm11
 8101      D9
 8102 6706 C57C28CA 		vmovaps	%ymm2, %ymm9
 8103 670a C4621598 		vfmadd132ps	.LC42(%rip), %ymm13, %ymm9
 8103      0D000000 
 8103      00
 8104 6713 C4C14C58 		vaddps	%ymm11, %ymm6, %ymm6
 8104      F3
 8105 6718 C4C16458 		vaddps	%ymm10, %ymm3, %ymm3
 8105      DA
 8106 671d C4C1745D 		vminps	%ymm12, %ymm1, %ymm1
 8106      CC
 8107 6722 C4C14C5D 		vminps	%ymm12, %ymm6, %ymm6
 8107      F4
 8108 6727 C4C15458 		vaddps	%ymm9, %ymm5, %ymm5
 8108      E9
 8109 672c C4C1645D 		vminps	%ymm12, %ymm3, %ymm3
 8109      DC
 500:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8110              		.loc 1 500 24 discriminator 3 view .LVU2360
 8111 6731 C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 500:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8112              		.loc 1 500 41 discriminator 3 view .LVU2361
 8113 6735 C4C1545D 		vminps	%ymm12, %ymm5, %ymm5
 8113      EC
 500:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8114              		.loc 1 500 24 discriminator 3 view .LVU2362
 8115 673a C585DBC9 		vpand	%ymm1, %ymm15, %ymm1
 8116 673e C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 8117 6742 C5FE5BDB 		vcvttps2dq	%ymm3, %ymm3
 8118 6746 C585DBF6 		vpand	%ymm6, %ymm15, %ymm6
 8119 674a C585DBDB 		vpand	%ymm3, %ymm15, %ymm3
 8120 674e C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 8121 6752 C585DBED 		vpand	%ymm5, %ymm15, %ymm5
 8122 6756 C57D6F5D 		vmovdqa	-112(%rbp), %ymm11
 8122      90
 8123 675b C4E2752B 		vpackusdw	%ymm6, %ymm1, %ymm1
 8123      CE
 8124 6760 C4E2652B 		vpackusdw	%ymm5, %ymm3, %ymm3
 8124      DD
 8125 6765 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 8125      C9D8
 8126 676b C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 8126      DBD8
 8127 6771 C4C165DB 		vpand	%ymm11, %ymm3, %ymm3
 8127      DB
 8128 6776 C4C175DB 		vpand	%ymm11, %ymm1, %ymm1
 8128      CB
 504:sepia_filter.c ****                           sepia[1][2]*B_in[i]));
 505:sepia_filter.c ****             B_out[i] = (unsigned char) (fminf(MAXPIXV,
 506:sepia_filter.c ****                           0.5f +
 507:sepia_filter.c ****                           sepia[2][0]*R_in[i] + 
 508:sepia_filter.c ****                           sepia[2][1]*G_in[i] + 
 8129              		.loc 1 508 38 discriminator 3 view .LVU2363
 8130 677b C5FC28AD 		vmovaps	-240(%rbp), %ymm5
 8130      10FFFFFF 
 500:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8131              		.loc 1 500 24 discriminator 3 view .LVU2364
 8132 6783 C5F567CB 		vpackuswb	%ymm3, %ymm1, %ymm1
 8133 6787 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 8133      C9D8
 500:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8134              		.loc 1 500 22 discriminator 3 view .LVU2365
 8135 678d C4C17E7F 		vmovdqu	%ymm1, (%r14,%rax)
 8135      0C06
 505:sepia_filter.c ****                           0.5f +
 8136              		.loc 1 505 13 is_stmt 1 discriminator 3 view .LVU2366
 8137              		.loc 1 508 38 is_stmt 0 discriminator 3 view .LVU2367
 8138 6793 C57C28B5 		vmovaps	-272(%rbp), %ymm14
 8138      F0FEFFFF 
 8139 679b C5D4590D 		vmulps	.LC43(%rip), %ymm5, %ymm1
 8139      00000000 
 8140 67a3 C58C592D 		vmulps	.LC43(%rip), %ymm14, %ymm5
 8140      00000000 
 8141 67ab C5FC2875 		vmovaps	-80(%rbp), %ymm6
 8141      B0
 8142 67b0 C5FC5905 		vmulps	.LC43(%rip), %ymm0, %ymm0
 8142      00000000 
 8143 67b8 C57C2895 		vmovaps	-176(%rbp), %ymm10
 8143      50FFFFFF 
 8144 67c0 C4E24DB8 		vfmadd231ps	.LC44(%rip), %ymm6, %ymm1
 8144      0D000000 
 8144      00
 8145 67c9 C5FC28B5 		vmovaps	-144(%rbp), %ymm6
 8145      70FFFFFF 
 8146 67d1 C4621598 		vfmadd132ps	.LC45(%rip), %ymm13, %ymm8
 8146      05000000 
 8146      00
 8147 67da C4E24DB8 		vfmadd231ps	.LC44(%rip), %ymm6, %ymm5
 8147      2D000000 
 8147      00
 8148 67e3 C5FC28B5 		vmovaps	-304(%rbp), %ymm6
 8148      D0FEFFFF 
 8149 67eb C4E21598 		vfmadd132ps	.LC45(%rip), %ymm13, %ymm4
 8149      25000000 
 8149      00
 8150 67f4 C5CC591D 		vmulps	.LC43(%rip), %ymm6, %ymm3
 8150      00000000 
 8151 67fc C5FC28B5 		vmovaps	-208(%rbp), %ymm6
 8151      30FFFFFF 
 8152 6804 C4E21598 		vfmadd132ps	.LC45(%rip), %ymm13, %ymm7
 8152      3D000000 
 8152      00
 8153 680d C4E27D98 		vfmadd132ps	.LC44(%rip), %ymm0, %ymm6
 8153      35000000 
 8153      00
 8154 6816 C4E21598 		vfmadd132ps	.LC45(%rip), %ymm13, %ymm2
 8154      15000000 
 8154      00
 8155 681f C4E22DB8 		vfmadd231ps	.LC44(%rip), %ymm10, %ymm3
 8155      1D000000 
 8155      00
 505:sepia_filter.c ****                           0.5f +
 8156              		.loc 1 505 41 discriminator 3 view .LVU2368
 8157 6828 C4417458 		vaddps	%ymm8, %ymm1, %ymm8
 8157      C0
 8158 682d C5D458EC 		vaddps	%ymm4, %ymm5, %ymm5
 8159 6831 C5CC58F2 		vaddps	%ymm2, %ymm6, %ymm6
 8160 6835 C5E458DF 		vaddps	%ymm7, %ymm3, %ymm3
 8161 6839 C4413C5D 		vminps	%ymm12, %ymm8, %ymm8
 8161      C4
 8162 683e C4C1545D 		vminps	%ymm12, %ymm5, %ymm5
 8162      EC
 8163 6843 C4C1645D 		vminps	%ymm12, %ymm3, %ymm3
 8163      DC
 8164 6848 C4C14C5D 		vminps	%ymm12, %ymm6, %ymm6
 8164      F4
 505:sepia_filter.c ****                           0.5f +
 8165              		.loc 1 505 24 discriminator 3 view .LVU2369
 8166 684d C4C17E5B 		vcvttps2dq	%ymm8, %ymm0
 8166      C0
 8167 6852 C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 8168 6856 C585DBC0 		vpand	%ymm0, %ymm15, %ymm0
 8169 685a C585DBED 		vpand	%ymm5, %ymm15, %ymm5
 8170 685e C5FE5BCB 		vcvttps2dq	%ymm3, %ymm1
 8171 6862 C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 8172 6866 C585DBC9 		vpand	%ymm1, %ymm15, %ymm1
 8173 686a C585DBF6 		vpand	%ymm6, %ymm15, %ymm6
 8174 686e C4E27D2B 		vpackusdw	%ymm5, %ymm0, %ymm0
 8174      C5
 8175 6873 C4E2752B 		vpackusdw	%ymm6, %ymm1, %ymm1
 8175      CE
 8176 6878 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 8176      C0D8
 8177 687e C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 8177      C9D8
 8178 6884 C4C17DDB 		vpand	%ymm11, %ymm0, %ymm0
 8178      C3
 8179 6889 C4C175DB 		vpand	%ymm11, %ymm1, %ymm1
 8179      CB
 8180 688e C5FD67C1 		vpackuswb	%ymm1, %ymm0, %ymm0
 8181 6892 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 8181      C0D8
 505:sepia_filter.c ****                           0.5f +
 8182              		.loc 1 505 22 discriminator 3 view .LVU2370
 8183 6898 C4C17E7F 		vmovdqu	%ymm0, (%r8,%rax)
 8183      0400
 493:sepia_filter.c ****         {
 8184              		.loc 1 493 44 is_stmt 1 discriminator 3 view .LVU2371
 493:sepia_filter.c ****         {
 8185              		.loc 1 493 9 discriminator 3 view .LVU2372
 8186 689e 4883C020 		addq	$32, %rax
 8187 68a2 4839C6   		cmpq	%rax, %rsi
 8188 68a5 0F85B5FB 		jne	.L198
 8188      FFFF
 8189 68ab 448B95C0 		movl	-320(%rbp), %r10d
 8189      FEFFFF
 8190 68b2 48895DB0 		movq	%rbx, -80(%rbp)
 8191 68b6 4489D0   		movl	%r10d, %eax
 8192 68b9 48898D70 		movq	%rcx, -144(%rbp)
 8192      FFFFFF
 8193 68c0 4139C5   		cmpl	%eax, %r13d
 8194 68c3 0F841905 		je	.L199
 8194      0000
 8195              	.L197:
 493:sepia_filter.c ****         {
 8196              		.loc 1 493 9 is_stmt 0 discriminator 3 view .LVU2373
 8197 68c9 4489EF   		movl	%r13d, %edi
 8198 68cc 29C7     		subl	%eax, %edi
 8199 68ce 8D77FF   		leal	-1(%rdi), %esi
 8200 68d1 83FE0E   		cmpl	$14, %esi
 8201 68d4 0F86EC03 		jbe	.L200
 8201      0000
 495:sepia_filter.c ****                           0.5f +
 8202              		.loc 1 495 13 is_stmt 1 view .LVU2374
 497:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 8203              		.loc 1 497 43 is_stmt 0 view .LVU2375
 8204 68da C4C1796F 		vmovdqa	(%r12,%rax), %xmm0
 8204      0404
 8205 68e0 488B8DC8 		movq	-312(%rbp), %rcx
 8205      FEFFFF
 8206 68e7 C4E27930 		vpmovzxbw	%xmm0, %xmm1
 8206      C8
 8207 68ec C4E27933 		vpmovzxwd	%xmm1, %xmm2
 8207      D1
 8208 68f1 C5F973D8 		vpsrldq	$8, %xmm0, %xmm0
 8208      08
 8209 68f6 C5F173D9 		vpsrldq	$8, %xmm1, %xmm1
 8209      08
 8210 68fb C4E27930 		vpmovzxbw	%xmm0, %xmm0
 8210      C0
 8211 6900 C4E27933 		vpmovzxwd	%xmm1, %xmm1
 8211      C9
 497:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 8212              		.loc 1 497 38 view .LVU2376
 8213 6905 C5785BF9 		vcvtdq2ps	%xmm1, %xmm15
 497:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 8214              		.loc 1 497 43 view .LVU2377
 8215 6909 C4E27933 		vpmovzxwd	%xmm0, %xmm1
 8215      C8
 8216 690e C5F973D8 		vpsrldq	$8, %xmm0, %xmm0
 8216      08
 8217 6913 488D3401 		leaq	(%rcx,%rax), %rsi
 8218 6917 C4E27933 		vpmovzxwd	%xmm0, %xmm0
 8218      C0
 497:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 8219              		.loc 1 497 38 view .LVU2378
 8220 691c C5F85BE0 		vcvtdq2ps	%xmm0, %xmm4
 498:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 8221              		.loc 1 498 43 view .LVU2379
 8222 6920 C4C17A6F 		vmovdqu	(%r12,%rsi), %xmm0
 8222      0434
 8223 6926 C4E27918 		vbroadcastss	.LC106(%rip), %xmm6
 8223      35000000 
 8223      00
 8224 692f C4E27918 		vbroadcastss	.LC2(%rip), %xmm3
 8224      1D000000 
 8224      00
 497:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 8225              		.loc 1 497 38 view .LVU2380
 8226 6938 C5785BEA 		vcvtdq2ps	%xmm2, %xmm13
 8227 693c C5785BF1 		vcvtdq2ps	%xmm1, %xmm14
 498:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 8228              		.loc 1 498 43 view .LVU2381
 8229 6940 C4E27930 		vpmovzxbw	%xmm0, %xmm2
 8229      D0
 8230 6945 C4417828 		vmovaps	%xmm13, %xmm9
 8230      CD
 8231 694a C57829F9 		vmovaps	%xmm15, %xmm1
 8232 694e C57829F7 		vmovaps	%xmm14, %xmm7
 8233 6952 C4624998 		vfmadd132ps	%xmm3, %xmm6, %xmm9
 8233      CB
 8234 6957 C4E24998 		vfmadd132ps	%xmm3, %xmm6, %xmm1
 8234      CB
 8235 695c C4E24998 		vfmadd132ps	%xmm3, %xmm6, %xmm7
 8235      FB
 8236 6961 C5F829A5 		vmovaps	%xmm4, -272(%rbp)
 8236      F0FEFFFF 
 8237 6969 C4E24998 		vfmadd132ps	%xmm4, %xmm6, %xmm3
 8237      DC
 8238 696e C5F973D8 		vpsrldq	$8, %xmm0, %xmm0
 8238      08
 8239 6973 C4E27933 		vpmovzxwd	%xmm2, %xmm4
 8239      E2
 8240 6978 C5E973DA 		vpsrldq	$8, %xmm2, %xmm2
 8240      08
 8241 697d C4E27930 		vpmovzxbw	%xmm0, %xmm0
 8241      C0
 8242 6982 C4E27933 		vpmovzxwd	%xmm2, %xmm2
 8242      D2
 498:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 8243              		.loc 1 498 38 view .LVU2382
 8244 6987 C5F85BEA 		vcvtdq2ps	%xmm2, %xmm5
 498:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 8245              		.loc 1 498 43 view .LVU2383
 8246 698b C4E27933 		vpmovzxwd	%xmm0, %xmm2
 8246      D0
 8247 6990 C5F973D8 		vpsrldq	$8, %xmm0, %xmm0
 8247      08
 8248 6995 4C8D0C31 		leaq	(%rcx,%rsi), %r9
 8249 6999 C4E27933 		vpmovzxwd	%xmm0, %xmm0
 8249      C0
 498:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 8250              		.loc 1 498 38 view .LVU2384
 8251 699e C5785BDC 		vcvtdq2ps	%xmm4, %xmm11
 8252 69a2 C5F85BE0 		vcvtdq2ps	%xmm0, %xmm4
 499:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8253              		.loc 1 499 43 view .LVU2385
 8254 69a6 C4817A6F 		vmovdqu	(%r12,%r9), %xmm0
 8254      040C
 498:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 8255              		.loc 1 498 38 view .LVU2386
 8256 69ac C5F8296D 		vmovaps	%xmm5, -112(%rbp)
 8256      90
 8257 69b1 C5F829A5 		vmovaps	%xmm4, -208(%rbp)
 8257      30FFFFFF 
 499:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8258              		.loc 1 499 38 view .LVU2387
 8259 69b9 C4E27918 		vbroadcastss	.LC3(%rip), %xmm5
 8259      2D000000 
 8259      00
 499:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8260              		.loc 1 499 43 view .LVU2388
 8261 69c2 C4E27930 		vpmovzxbw	%xmm0, %xmm4
 8261      E0
 8262 69c7 C4627933 		vpmovzxwd	%xmm4, %xmm8
 8262      C4
 499:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8263              		.loc 1 499 38 view .LVU2389
 8264 69cc C441785B 		vcvtdq2ps	%xmm8, %xmm8
 8264      C0
 499:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8265              		.loc 1 499 43 view .LVU2390
 8266 69d1 C5F973D8 		vpsrldq	$8, %xmm0, %xmm0
 8266      08
 499:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8267              		.loc 1 499 38 view .LVU2391
 8268 69d6 C53859E5 		vmulps	%xmm5, %xmm8, %xmm12
 499:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8269              		.loc 1 499 43 view .LVU2392
 8270 69da C4E27930 		vpmovzxbw	%xmm0, %xmm0
 8270      C0
 498:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 8271              		.loc 1 498 38 view .LVU2393
 8272 69df C5F85BD2 		vcvtdq2ps	%xmm2, %xmm2
 8273 69e3 C5F82995 		vmovaps	%xmm2, -176(%rbp)
 8273      50FFFFFF 
 499:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8274              		.loc 1 499 43 view .LVU2394
 8275 69eb C4E27933 		vpmovzxwd	%xmm0, %xmm2
 8275      D0
 499:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8276              		.loc 1 499 38 view .LVU2395
 8277 69f0 C5785BD2 		vcvtdq2ps	%xmm2, %xmm10
 499:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8278              		.loc 1 499 43 view .LVU2396
 8279 69f4 C5D973DC 		vpsrldq	$8, %xmm4, %xmm4
 8279      08
 499:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8280              		.loc 1 499 38 view .LVU2397
 8281 69f9 C5782995 		vmovaps	%xmm10, -240(%rbp)
 8281      10FFFFFF 
 499:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8282              		.loc 1 499 43 view .LVU2398
 8283 6a01 C5F973D8 		vpsrldq	$8, %xmm0, %xmm0
 8283      08
 8284 6a06 C4627918 		vbroadcastss	.LC1(%rip), %xmm10
 8284      15000000 
 8284      00
 8285 6a0f C4E27933 		vpmovzxwd	%xmm4, %xmm4
 8285      E4
 8286 6a14 C4E27933 		vpmovzxwd	%xmm0, %xmm0
 8286      C0
 8287 6a19 C44229B8 		vfmadd231ps	%xmm11, %xmm10, %xmm12
 8287      E3
 8288 6a1e C578299D 		vmovaps	%xmm11, -304(%rbp)
 8288      D0FEFFFF 
 499:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8289              		.loc 1 499 38 view .LVU2399
 8290 6a26 C5F85BE4 		vcvtdq2ps	%xmm4, %xmm4
 8291 6a2a C550599D 		vmulps	-240(%rbp), %xmm5, %xmm11
 8291      10FFFFFF 
 8292 6a32 C5D859D5 		vmulps	%xmm5, %xmm4, %xmm2
 8293 6a36 C5F85BC0 		vcvtdq2ps	%xmm0, %xmm0
 8294 6a3a C5F859ED 		vmulps	%xmm5, %xmm0, %xmm5
 495:sepia_filter.c ****                           0.5f +
 8295              		.loc 1 495 41 view .LVU2400
 8296 6a3e C4413058 		vaddps	%xmm12, %xmm9, %xmm9
 8296      CC
 8297 6a43 C46229B8 		vfmadd231ps	-176(%rbp), %xmm10, %xmm11
 8297      9D50FFFF 
 8297      FF
 8298 6a4c C4E229B8 		vfmadd231ps	-112(%rbp), %xmm10, %xmm2
 8298      5590
 495:sepia_filter.c ****                           0.5f +
 8299              		.loc 1 495 24 view .LVU2401
 8300 6a52 B9FFFF00 		movl	$65535, %ecx
 8300      00
 8301 6a57 C4625198 		vfmadd132ps	-208(%rbp), %xmm5, %xmm10
 8301      9530FFFF 
 8301      FF
 495:sepia_filter.c ****                           0.5f +
 8302              		.loc 1 495 41 view .LVU2402
 8303 6a60 C4E27918 		vbroadcastss	.LC4(%rip), %xmm5
 8303      2D000000 
 8303      00
 8304 6a69 C4C14058 		vaddps	%xmm11, %xmm7, %xmm7
 8304      FB
 8305 6a6e C5F058CA 		vaddps	%xmm2, %xmm1, %xmm1
 8306 6a72 C5305DCD 		vminps	%xmm5, %xmm9, %xmm9
 8307 6a76 C4C16058 		vaddps	%xmm10, %xmm3, %xmm3
 8307      DA
 8308 6a7b C5C05DFD 		vminps	%xmm5, %xmm7, %xmm7
 495:sepia_filter.c ****                           0.5f +
 8309              		.loc 1 495 24 view .LVU2403
 8310 6a7f C5F96ED1 		vmovd	%ecx, %xmm2
 495:sepia_filter.c ****                           0.5f +
 8311              		.loc 1 495 41 view .LVU2404
 8312 6a83 C5E05DDD 		vminps	%xmm5, %xmm3, %xmm3
 8313 6a87 C5F05DCD 		vminps	%xmm5, %xmm1, %xmm1
 495:sepia_filter.c ****                           0.5f +
 8314              		.loc 1 495 24 view .LVU2405
 8315 6a8b C5F970D2 		vpshufd	$0, %xmm2, %xmm2
 8315      00
 8316 6a90 C5FA5BFF 		vcvttps2dq	%xmm7, %xmm7
 8317 6a94 C5FA5BDB 		vcvttps2dq	%xmm3, %xmm3
 8318 6a98 C5E9DBFF 		vpand	%xmm7, %xmm2, %xmm7
 8319 6a9c C5E9DBDB 		vpand	%xmm3, %xmm2, %xmm3
 8320 6aa0 C4E2412B 		vpackusdw	%xmm3, %xmm7, %xmm3
 8320      DB
 8321 6aa5 C4417A5B 		vcvttps2dq	%xmm9, %xmm9
 8321      C9
 8322 6aaa C4E27979 		vpbroadcastw	.LC114(%rip), %xmm7
 8322      3D000000 
 8322      00
 8323 6ab3 C44169DB 		vpand	%xmm9, %xmm2, %xmm9
 8323      C9
 8324 6ab8 C5FA5BC9 		vcvttps2dq	%xmm1, %xmm1
 8325 6abc C5E9DBC9 		vpand	%xmm1, %xmm2, %xmm1
 504:sepia_filter.c ****             B_out[i] = (unsigned char) (fminf(MAXPIXV,
 8326              		.loc 1 504 38 view .LVU2406
 8327 6ac0 C4627918 		vbroadcastss	.LC9(%rip), %xmm12
 8327      25000000 
 8327      00
 495:sepia_filter.c ****                           0.5f +
 8328              		.loc 1 495 24 view .LVU2407
 8329 6ac9 C4E2312B 		vpackusdw	%xmm1, %xmm9, %xmm1
 8329      C9
 8330 6ace C5C1DBDB 		vpand	%xmm3, %xmm7, %xmm3
 8331 6ad2 C5C1DBC9 		vpand	%xmm1, %xmm7, %xmm1
 8332 6ad6 C5F167CB 		vpackuswb	%xmm3, %xmm1, %xmm1
 8333 6ada C57829AD 		vmovaps	%xmm13, -336(%rbp)
 8333      B0FEFFFF 
 8334 6ae2 C57829EB 		vmovaps	%xmm13, %xmm3
 8335 6ae6 C57829BD 		vmovaps	%xmm15, -352(%rbp)
 8335      A0FEFFFF 
 504:sepia_filter.c ****             B_out[i] = (unsigned char) (fminf(MAXPIXV,
 8336              		.loc 1 504 38 view .LVU2408
 8337 6aee C51859AD 		vmulps	-240(%rbp), %xmm12, %xmm13
 8337      10FFFFFF 
 8338 6af6 C4417828 		vmovaps	%xmm15, %xmm10
 8338      D7
 8339 6afb C57829B5 		vmovaps	%xmm14, -368(%rbp)
 8339      90FEFFFF 
 8340 6b03 C4413859 		vmulps	%xmm12, %xmm8, %xmm15
 8340      FC
 8341 6b08 C4417828 		vmovaps	%xmm14, %xmm9
 8341      CE
 8342 6b0d C4415859 		vmulps	%xmm12, %xmm4, %xmm14
 8342      F4
 8343 6b12 C4417859 		vmulps	%xmm12, %xmm0, %xmm12
 8343      E4
 495:sepia_filter.c ****                           0.5f +
 8344              		.loc 1 495 22 view .LVU2409
 8345 6b17 488B4DB0 		movq	-80(%rbp), %rcx
 8346 6b1b C4627918 		vbroadcastss	.LC7(%rip), %xmm11
 8346      1D000000 
 8346      00
 8347 6b24 C5F97F0C 		vmovdqa	%xmm1, (%rcx,%rax)
 8347      01
 500:sepia_filter.c ****                           0.5f +
 8348              		.loc 1 500 13 is_stmt 1 view .LVU2410
 8349 6b29 C4E27918 		vbroadcastss	.LC8(%rip), %xmm1
 8349      0D000000 
 8349      00
 8350 6b32 C46221B8 		vfmadd231ps	-304(%rbp), %xmm11, %xmm15
 8350      BDD0FEFF 
 8350      FF
 8351 6b3b C4E24998 		vfmadd132ps	%xmm1, %xmm6, %xmm3
 8351      D9
 8352 6b40 C4624998 		vfmadd132ps	%xmm1, %xmm6, %xmm10
 8352      D1
 8353 6b45 C4624998 		vfmadd132ps	%xmm1, %xmm6, %xmm9
 8353      C9
 8354 6b4a C46221B8 		vfmadd231ps	-112(%rbp), %xmm11, %xmm14
 8354      7590
 8355 6b50 C4E24998 		vfmadd132ps	-272(%rbp), %xmm6, %xmm1
 8355      8DF0FEFF 
 8355      FF
 8356 6b59 C46221B8 		vfmadd231ps	-176(%rbp), %xmm11, %xmm13
 8356      AD50FFFF 
 8356      FF
 8357 6b62 C4621998 		vfmadd132ps	-208(%rbp), %xmm12, %xmm11
 8357      9D30FFFF 
 8357      FF
 500:sepia_filter.c ****                           0.5f +
 8358              		.loc 1 500 41 is_stmt 0 view .LVU2411
 8359 6b6b C4C16058 		vaddps	%xmm15, %xmm3, %xmm3
 8359      DF
 8360 6b70 C4412858 		vaddps	%xmm14, %xmm10, %xmm10
 8360      D6
 8361 6b75 89F8     		movl	%edi, %eax
 8362 6b77 C4413058 		vaddps	%xmm13, %xmm9, %xmm9
 8362      CD
 8363 6b7c C4C17058 		vaddps	%xmm11, %xmm1, %xmm1
 8363      CB
 8364 6b81 C5E05DDD 		vminps	%xmm5, %xmm3, %xmm3
 8365 6b85 C5285DD5 		vminps	%xmm5, %xmm10, %xmm10
 8366 6b89 C5305DCD 		vminps	%xmm5, %xmm9, %xmm9
 8367 6b8d C5F05DCD 		vminps	%xmm5, %xmm1, %xmm1
 500:sepia_filter.c ****                           0.5f +
 8368              		.loc 1 500 24 view .LVU2412
 8369 6b91 C5FA5BDB 		vcvttps2dq	%xmm3, %xmm3
 8370 6b95 C4417A5B 		vcvttps2dq	%xmm10, %xmm10
 8370      D2
 8371 6b9a C5E9DBDB 		vpand	%xmm3, %xmm2, %xmm3
 8372 6b9e C44169DB 		vpand	%xmm10, %xmm2, %xmm10
 8372      D2
 8373 6ba3 C4417A5B 		vcvttps2dq	%xmm9, %xmm9
 8373      C9
 8374 6ba8 C5FA5BC9 		vcvttps2dq	%xmm1, %xmm1
 8375 6bac C44169DB 		vpand	%xmm9, %xmm2, %xmm9
 8375      C9
 8376 6bb1 C5E9DBC9 		vpand	%xmm1, %xmm2, %xmm1
 8377 6bb5 C4C2612B 		vpackusdw	%xmm10, %xmm3, %xmm3
 8377      DA
 8378 6bba C4E2312B 		vpackusdw	%xmm1, %xmm9, %xmm1
 8378      C9
 8379 6bbf C5C1DBC9 		vpand	%xmm1, %xmm7, %xmm1
 8380 6bc3 C5C1DBDB 		vpand	%xmm3, %xmm7, %xmm3
 8381 6bc7 C5E167D9 		vpackuswb	%xmm1, %xmm3, %xmm3
 500:sepia_filter.c ****                           0.5f +
 8382              		.loc 1 500 22 view .LVU2413
 8383 6bcb C5FA7F1C 		vmovdqu	%xmm3, (%rcx,%rsi)
 8383      31
 505:sepia_filter.c ****                           0.5f +
 8384              		.loc 1 505 13 is_stmt 1 view .LVU2414
 8385 6bd0 C4E27918 		vbroadcastss	.LC11(%rip), %xmm1
 8385      0D000000 
 8385      00
 8386 6bd9 C5F8289D 		vmovaps	-336(%rbp), %xmm3
 8386      B0FEFFFF 
 8387 6be1 C578288D 		vmovaps	-352(%rbp), %xmm9
 8387      A0FEFFFF 
 8388 6be9 C5782895 		vmovaps	-368(%rbp), %xmm10
 8388      90FEFFFF 
 8389 6bf1 C4E24998 		vfmadd132ps	%xmm1, %xmm6, %xmm3
 8389      D9
 8390 6bf6 C4624998 		vfmadd132ps	%xmm1, %xmm6, %xmm9
 8390      C9
 8391 6bfb C4624998 		vfmadd132ps	%xmm1, %xmm6, %xmm10
 8391      D1
 8392 6c00 C4E24998 		vfmadd132ps	-272(%rbp), %xmm6, %xmm1
 8392      8DF0FEFF 
 8392      FF
 509:sepia_filter.c ****                           sepia[2][2]*B_in[i]));
 8393              		.loc 1 509 38 is_stmt 0 view .LVU2415
 8394 6c09 C4E27918 		vbroadcastss	.LC12(%rip), %xmm6
 8394      35000000 
 8394      00
 8395 6c12 C4627918 		vbroadcastss	.LC10(%rip), %xmm11
 8395      1D000000 
 8395      00
 8396 6c1b C5F859C6 		vmulps	%xmm6, %xmm0, %xmm0
 8397 6c1f C53859C6 		vmulps	%xmm6, %xmm8, %xmm8
 8398 6c23 C5D859E6 		vmulps	%xmm6, %xmm4, %xmm4
 8399 6c27 C54859A5 		vmulps	-240(%rbp), %xmm6, %xmm12
 8399      10FFFFFF 
 8400 6c2f C5F828B5 		vmovaps	-208(%rbp), %xmm6
 8400      30FFFFFF 
 8401 6c37 83E0F0   		andl	$-16, %eax
 8402 6c3a C4C27998 		vfmadd132ps	%xmm11, %xmm0, %xmm6
 8402      F3
 8403 6c3f C46221B8 		vfmadd231ps	-304(%rbp), %xmm11, %xmm8
 8403      85D0FEFF 
 8403      FF
 8404 6c48 C4E221B8 		vfmadd231ps	-112(%rbp), %xmm11, %xmm4
 8404      6590
 8405 6c4e C46221B8 		vfmadd231ps	-176(%rbp), %xmm11, %xmm12
 8405      A550FFFF 
 8405      FF
 8406 6c57 4101C2   		addl	%eax, %r10d
 505:sepia_filter.c ****                           0.5f +
 8407              		.loc 1 505 41 view .LVU2416
 8408 6c5a C5C858F1 		vaddps	%xmm1, %xmm6, %xmm6
 8409 6c5e C4C16058 		vaddps	%xmm8, %xmm3, %xmm3
 8409      D8
 8410 6c63 C53058CC 		vaddps	%xmm4, %xmm9, %xmm9
 8411 6c67 C4412858 		vaddps	%xmm12, %xmm10, %xmm10
 8411      D4
 8412 6c6c C5E05DDD 		vminps	%xmm5, %xmm3, %xmm3
 8413 6c70 C5305DCD 		vminps	%xmm5, %xmm9, %xmm9
 8414 6c74 C5285DD5 		vminps	%xmm5, %xmm10, %xmm10
 8415 6c78 C5C85DF5 		vminps	%xmm5, %xmm6, %xmm6
 505:sepia_filter.c ****                           0.5f +
 8416              		.loc 1 505 24 view .LVU2417
 8417 6c7c C5FA5BC3 		vcvttps2dq	%xmm3, %xmm0
 8418 6c80 C4417A5B 		vcvttps2dq	%xmm9, %xmm9
 8418      C9
 8419 6c85 C5E9DBC0 		vpand	%xmm0, %xmm2, %xmm0
 8420 6c89 C44169DB 		vpand	%xmm9, %xmm2, %xmm9
 8420      C9
 8421 6c8e C4417A5B 		vcvttps2dq	%xmm10, %xmm10
 8421      D2
 8422 6c93 C5FA5BF6 		vcvttps2dq	%xmm6, %xmm6
 8423 6c97 C44169DB 		vpand	%xmm10, %xmm2, %xmm10
 8423      D2
 8424 6c9c C5E9DBD6 		vpand	%xmm6, %xmm2, %xmm2
 8425 6ca0 C4C2792B 		vpackusdw	%xmm9, %xmm0, %xmm0
 8425      C1
 8426 6ca5 C462292B 		vpackusdw	%xmm2, %xmm10, %xmm10
 8426      D2
 8427 6caa C5C1DBC0 		vpand	%xmm0, %xmm7, %xmm0
 8428 6cae C4C141DB 		vpand	%xmm10, %xmm7, %xmm7
 8428      FA
 8429 6cb3 C5F967C7 		vpackuswb	%xmm7, %xmm0, %xmm0
 8430 6cb7 83E70F   		andl	$15, %edi
 505:sepia_filter.c ****                           0.5f +
 8431              		.loc 1 505 22 view .LVU2418
 8432 6cba C4A17A7F 		vmovdqu	%xmm0, (%rcx,%r9)
 8432      0409
 493:sepia_filter.c ****         {
 8433              		.loc 1 493 44 is_stmt 1 view .LVU2419
 493:sepia_filter.c ****         {
 8434              		.loc 1 493 9 view .LVU2420
 8435 6cc0 0F840F01 		je	.L201
 8435      0000
 8436              	.L200:
 493:sepia_filter.c ****         {
 8437              		.loc 1 493 9 is_stmt 0 view .LVU2421
 8438 6cc6 C57A102D 		vmovss	.LC1(%rip), %xmm13
 8438      00000000 
 8439 6cce C57A1025 		vmovss	.LC2(%rip), %xmm12
 8439      00000000 
 8440 6cd6 C57A101D 		vmovss	.LC3(%rip), %xmm11
 8440      00000000 
 8441 6cde C5FA1025 		vmovss	.LC106(%rip), %xmm4
 8441      00000000 
 8442 6ce6 C5FA101D 		vmovss	.LC4(%rip), %xmm3
 8442      00000000 
 8443 6cee C57A1015 		vmovss	.LC7(%rip), %xmm10
 8443      00000000 
 8444 6cf6 C57A100D 		vmovss	.LC8(%rip), %xmm9
 8444      00000000 
 8445 6cfe C57A1005 		vmovss	.LC9(%rip), %xmm8
 8445      00000000 
 8446 6d06 C5FA103D 		vmovss	.LC10(%rip), %xmm7
 8446      00000000 
 8447 6d0e C5FA1035 		vmovss	.LC11(%rip), %xmm6
 8447      00000000 
 8448 6d16 C5FA102D 		vmovss	.LC12(%rip), %xmm5
 8448      00000000 
 8449 6d1e 488BB588 		movq	-376(%rbp), %rsi
 8449      FEFFFF
 8450 6d25 488B5DB0 		movq	-80(%rbp), %rbx
 8451 6d29 488B8D70 		movq	-144(%rbp), %rcx
 8451      FFFFFF
 8452 6d30 4963C2   		movslq	%r10d, %rax
 8453              		.p2align 4,,10
 8454 6d33 0F1F4400 		.p2align 3
 8454      00
 8455              	.L202:
 8456              	.LVL288:
 495:sepia_filter.c ****                           0.5f +
 8457              		.loc 1 495 13 is_stmt 1 view .LVU2422
 497:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 8458              		.loc 1 497 43 is_stmt 0 view .LVU2423
 8459 6d38 410FB63C 		movzbl	(%r12,%rax), %edi
 8459      04
 497:sepia_filter.c ****                           sepia[0][1]*G_in[i] + 
 8460              		.loc 1 497 38 view .LVU2424
 8461 6d3d C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
 8462 6d41 C5F22AC7 		vcvtsi2ssl	%edi, %xmm1, %xmm0
 498:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 8463              		.loc 1 498 43 view .LVU2425
 8464 6d45 410FB63C 		movzbl	(%r15,%rax), %edi
 8464      07
 498:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 8465              		.loc 1 498 38 view .LVU2426
 8466 6d4a C5F22AD7 		vcvtsi2ssl	%edi, %xmm1, %xmm2
 499:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8467              		.loc 1 499 43 view .LVU2427
 8468 6d4e 0FB63C06 		movzbl	(%rsi,%rax), %edi
 499:sepia_filter.c ****             G_out[i] = (unsigned char) (fminf(MAXPIXV,
 8469              		.loc 1 499 38 view .LVU2428
 8470 6d52 C5F22ACF 		vcvtsi2ssl	%edi, %xmm1, %xmm1
 498:sepia_filter.c ****                           sepia[0][2]*B_in[i]));
 8471              		.loc 1 498 38 view .LVU2429
 8472 6d56 C4416A59 		vmulss	%xmm13, %xmm2, %xmm14
 8472      F5
 8473 6d5b C57828F9 		vmovaps	%xmm1, %xmm15
 8474 6d5f C4425999 		vfmadd132ss	%xmm11, %xmm4, %xmm15
 8474      FB
 8475 6d64 C44279B9 		vfmadd231ss	%xmm12, %xmm0, %xmm14
 8475      F4
 495:sepia_filter.c ****                           0.5f +
 8476              		.loc 1 495 41 view .LVU2430
 8477 6d69 C4410A58 		vaddss	%xmm15, %xmm14, %xmm14
 8477      F7
 8478 6d6e C57828F9 		vmovaps	%xmm1, %xmm15
 8479 6d72 C4425999 		vfmadd132ss	%xmm8, %xmm4, %xmm15
 8479      F8
 8480 6d77 C50A5DF3 		vminss	%xmm3, %xmm14, %xmm14
 8481 6d7b C4E25999 		vfmadd132ss	%xmm5, %xmm4, %xmm1
 8481      CD
 495:sepia_filter.c ****                           0.5f +
 8482              		.loc 1 495 24 view .LVU2431
 8483 6d80 C4C17A2C 		vcvttss2sil	%xmm14, %edi
 8483      FE
 503:sepia_filter.c ****                           sepia[1][2]*B_in[i]));
 8484              		.loc 1 503 38 view .LVU2432
 8485 6d85 C4416A59 		vmulss	%xmm10, %xmm2, %xmm14
 8485      F2
 508:sepia_filter.c ****                           sepia[2][2]*B_in[i]));
 8486              		.loc 1 508 38 view .LVU2433
 8487 6d8a C5EA59D7 		vmulss	%xmm7, %xmm2, %xmm2
 495:sepia_filter.c ****                           0.5f +
 8488              		.loc 1 495 24 view .LVU2434
 8489 6d8e 40883C03 		movb	%dil, (%rbx,%rax)
 500:sepia_filter.c ****                           0.5f +
 8490              		.loc 1 500 13 is_stmt 1 view .LVU2435
 8491 6d92 C44279B9 		vfmadd231ss	%xmm9, %xmm0, %xmm14
 8491      F1
 8492 6d97 C4E26999 		vfmadd132ss	%xmm6, %xmm2, %xmm0
 8492      C6
 500:sepia_filter.c ****                           0.5f +
 8493              		.loc 1 500 41 is_stmt 0 view .LVU2436
 8494 6d9c C4410A58 		vaddss	%xmm15, %xmm14, %xmm14
 8494      F7
 505:sepia_filter.c ****                           0.5f +
 8495              		.loc 1 505 41 view .LVU2437
 8496 6da1 C5FA58C1 		vaddss	%xmm1, %xmm0, %xmm0
 500:sepia_filter.c ****                           0.5f +
 8497              		.loc 1 500 41 view .LVU2438
 8498 6da5 C50A5DF3 		vminss	%xmm3, %xmm14, %xmm14
 505:sepia_filter.c ****                           0.5f +
 8499              		.loc 1 505 41 view .LVU2439
 8500 6da9 C5FA5DC3 		vminss	%xmm3, %xmm0, %xmm0
 500:sepia_filter.c ****                           0.5f +
 8501              		.loc 1 500 24 view .LVU2440
 8502 6dad C4C17A2C 		vcvttss2sil	%xmm14, %edi
 8502      FE
 8503 6db2 41883C06 		movb	%dil, (%r14,%rax)
 505:sepia_filter.c ****                           0.5f +
 8504              		.loc 1 505 13 is_stmt 1 view .LVU2441
 505:sepia_filter.c ****                           0.5f +
 8505              		.loc 1 505 24 is_stmt 0 view .LVU2442
 8506 6db6 C5FA2CF8 		vcvttss2sil	%xmm0, %edi
 8507 6dba 40883C01 		movb	%dil, (%rcx,%rax)
 493:sepia_filter.c ****         {
 8508              		.loc 1 493 44 is_stmt 1 view .LVU2443
 8509              	.LVL289:
 493:sepia_filter.c ****         {
 8510              		.loc 1 493 9 view .LVU2444
 8511 6dbe 48FFC0   		incq	%rax
 8512              	.LVL290:
 493:sepia_filter.c ****         {
 8513              		.loc 1 493 9 is_stmt 0 view .LVU2445
 8514 6dc1 4139C5   		cmpl	%eax, %r13d
 8515 6dc4 0F8F6EFF 		jg	.L202
 8515      FFFF
 8516 6dca 48895DB0 		movq	%rbx, -80(%rbp)
 8517 6dce 48898D70 		movq	%rcx, -144(%rbp)
 8517      FFFFFF
 8518              	.LVL291:
 8519              	.L201:
 493:sepia_filter.c ****         {
 8520              		.loc 1 493 9 view .LVU2446
 8521 6dd5 83BDC4FE 		cmpl	$30, -316(%rbp)
 8521      FFFF1E
 8522 6ddc 0F86F906 		jbe	.L214
 8522      0000
 8523              	.L199:
 493:sepia_filter.c ****         {
 8524              		.loc 1 493 9 view .LVU2447
 8525 6de2 C57D6F3D 		vmovdqa	.LC50(%rip), %ymm15
 8525      00000000 
 8526 6dea C57D6F35 		vmovdqa	.LC51(%rip), %ymm14
 8526      00000000 
 8527 6df2 C57D6F2D 		vmovdqa	.LC52(%rip), %ymm13
 8527      00000000 
 8528 6dfa C57D6F25 		vmovdqa	.LC53(%rip), %ymm12
 8528      00000000 
 8529 6e02 C57D6F1D 		vmovdqa	.LC54(%rip), %ymm11
 8529      00000000 
 8530 6e0a C57D6F15 		vmovdqa	.LC57(%rip), %ymm10
 8530      00000000 
 8531 6e12 C57D6F0D 		vmovdqa	.LC62(%rip), %ymm9
 8531      00000000 
 8532 6e1a C57D6F05 		vmovdqa	.LC63(%rip), %ymm8
 8532      00000000 
 8533 6e22 C5FD6F3D 		vmovdqa	.LC64(%rip), %ymm7
 8533      00000000 
 8534 6e2a 488B5DB0 		movq	-80(%rbp), %rbx
 8535 6e2e 488B8D70 		movq	-144(%rbp), %rcx
 8535      FFFFFF
 8536 6e35 488BBD80 		movq	-384(%rbp), %rdi
 8536      FEFFFF
 8537 6e3c 4C89DE   		movq	%r11, %rsi
 493:sepia_filter.c ****         {
 8538              		.loc 1 493 18 view .LVU2448
 8539 6e3f 31C0     		xorl	%eax, %eax
 8540              		.p2align 4,,10
 8541 6e41 0F1F8000 		.p2align 3
 8541      000000
 8542              	.L204:
 8543              	.LBE61:
 8544              	.LBB62:
 510:sepia_filter.c ****         }
 511:sepia_filter.c **** 
 512:sepia_filter.c ****         /* transformación SoA -> AoS */
 513:sepia_filter.c ****         /* COMPLETAR ... */
 514:sepia_filter.c ****         #pragma GCC ivdep
 515:sepia_filter.c ****         for (int i = 0; i < height*width; i++)
 516:sepia_filter.c ****         {
 517:sepia_filter.c ****             pixels_out[3*i + 0] = R_out[i];
 8545              		.loc 1 517 13 is_stmt 1 discriminator 3 view .LVU2449
 8546              		.loc 1 517 40 is_stmt 0 discriminator 3 view .LVU2450
 8547 6e48 C5FD6F0C 		vmovdqa	(%rbx,%rax), %ymm1
 8547      03
 518:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8548              		.loc 1 518 13 is_stmt 1 discriminator 3 view .LVU2451
 8549              		.loc 1 518 40 is_stmt 0 discriminator 3 view .LVU2452
 8550 6e4d C4C17E6F 		vmovdqu	(%r14,%rax), %ymm0
 8550      0406
 519:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 8551              		.loc 1 519 13 is_stmt 1 discriminator 3 view .LVU2453
 8552              		.loc 1 519 40 is_stmt 0 discriminator 3 view .LVU2454
 8553 6e53 C4C17E6F 		vmovdqu	(%r8,%rax), %ymm2
 8553      1400
 8554              		.loc 1 519 33 discriminator 3 view .LVU2455
 8555 6e59 C4E27500 		vpshufb	.LC46(%rip), %ymm1, %ymm6
 8555      35000000 
 8555      00
 8556 6e62 C4E27D00 		vpshufb	.LC47(%rip), %ymm0, %ymm5
 8556      2D000000 
 8556      00
 8557 6e6b C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 8557      ED4E
 8558 6e71 C4E27500 		vpshufb	.LC48(%rip), %ymm1, %ymm3
 8558      1D000000 
 8558      00
 8559 6e7a C4E27D00 		vpshufb	.LC49(%rip), %ymm0, %ymm4
 8559      25000000 
 8559      00
 8560 6e83 C4E3FD00 		vpermq	$78, %ymm6, %ymm6
 8560      F64E
 8561 6e89 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 8562 6e8d C5E5EBDE 		vpor	%ymm6, %ymm3, %ymm3
 8563 6e91 C4C26D00 		vpshufb	%ymm15, %ymm2, %ymm5
 8563      EF
 8564 6e96 C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 8565 6e9a C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 8565      ED4E
 8566 6ea0 C4C26D00 		vpshufb	%ymm13, %ymm2, %ymm4
 8566      E5
 8567 6ea5 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 8568 6ea9 C4C26500 		vpshufb	%ymm14, %ymm3, %ymm3
 8568      DE
 8569 6eae C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 8570 6eb2 C4C27500 		vpshufb	%ymm12, %ymm1, %ymm4
 8570      E4
 8571 6eb7 C5FE7F1E 		vmovdqu	%ymm3, (%rsi)
 8572 6ebb C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 8572      E44E
 8573 6ec1 C4C27500 		vpshufb	%ymm11, %ymm1, %ymm3
 8573      DB
 8574 6ec6 C4E27D00 		vpshufb	.LC55(%rip), %ymm0, %ymm5
 8574      2D000000 
 8574      00
 8575 6ecf C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 8576 6ed3 C5E5EBDD 		vpor	%ymm5, %ymm3, %ymm3
 8577 6ed7 C4E26D00 		vpshufb	.LC56(%rip), %ymm2, %ymm4
 8577      25000000 
 8577      00
 8578 6ee0 C4E35D4C 		vpblendvb	%ymm10, %ymm3, %ymm4, %ymm3
 8578      DBA0
 8579 6ee6 C5FE7F5E 		vmovdqu	%ymm3, 32(%rsi)
 8579      20
 8580 6eeb C4E27D00 		vpshufb	.LC58(%rip), %ymm0, %ymm4
 8580      25000000 
 8580      00
 8581 6ef4 C4E27500 		vpshufb	.LC59(%rip), %ymm1, %ymm3
 8581      1D000000 
 8581      00
 8582 6efd C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 8582      E44E
 8583 6f03 C4E3FD00 		vpermq	$78, %ymm3, %ymm3
 8583      DB4E
 8584 6f09 C4E27D00 		vpshufb	.LC60(%rip), %ymm0, %ymm0
 8584      05000000 
 8584      00
 8585 6f12 C4E27500 		vpshufb	.LC61(%rip), %ymm1, %ymm1
 8585      0D000000 
 8585      00
 8586 6f1b C5F5EBCB 		vpor	%ymm3, %ymm1, %ymm1
 8587 6f1f C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 8588 6f23 C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 8589 6f27 C4C26D00 		vpshufb	%ymm9, %ymm2, %ymm1
 8589      C9
 8590 6f2c C4E3FD00 		vpermq	$78, %ymm1, %ymm1
 8590      C94E
 8591 6f32 C4E26D00 		vpshufb	%ymm7, %ymm2, %ymm2
 8591      D7
 8592 6f37 C4C27D00 		vpshufb	%ymm8, %ymm0, %ymm0
 8592      C0
 8593 6f3c C5EDEBD1 		vpor	%ymm1, %ymm2, %ymm2
 8594 6f40 C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 8595 6f44 4883C020 		addq	$32, %rax
 8596 6f48 C5FE7F46 		vmovdqu	%ymm0, 64(%rsi)
 8596      40
 515:sepia_filter.c ****         {
 8597              		.loc 1 515 44 is_stmt 1 discriminator 3 view .LVU2456
 515:sepia_filter.c ****         {
 8598              		.loc 1 515 9 discriminator 3 view .LVU2457
 8599 6f4d 4883C660 		addq	$96, %rsi
 8600 6f51 4839C7   		cmpq	%rax, %rdi
 8601 6f54 0F85EEFE 		jne	.L204
 8601      FFFF
 8602 6f5a 8B85C0FE 		movl	-320(%rbp), %eax
 8602      FFFF
 8603 6f60 48895DB0 		movq	%rbx, -80(%rbp)
 8604 6f64 48898D70 		movq	%rcx, -144(%rbp)
 8604      FFFFFF
 8605 6f6b 4139C5   		cmpl	%eax, %r13d
 8606 6f6e 0F848C04 		je	.L205
 8606      0000
 8607              		.loc 1 519 33 is_stmt 0 view .LVU2458
 8608 6f74 89C6     		movl	%eax, %esi
 515:sepia_filter.c ****         {
 8609              		.loc 1 515 18 view .LVU2459
 8610 6f76 89C3     		movl	%eax, %ebx
 8611              	.L203:
 515:sepia_filter.c ****         {
 8612              		.loc 1 515 18 view .LVU2460
 8613 6f78 4589E9   		movl	%r13d, %r9d
 8614 6f7b 4129F1   		subl	%esi, %r9d
 8615 6f7e 418D79FF 		leal	-1(%r9), %edi
 8616 6f82 83FF0E   		cmpl	$14, %edi
 8617 6f85 0F86C500 		jbe	.L206
 8617      0000
 8618 6f8b 488B85C8 		movq	-312(%rbp), %rax
 8618      FEFFFF
 8619              		.loc 1 519 33 view .LVU2461
 8620 6f92 C5F96F2D 		vmovdqa	.LC91(%rip), %xmm5
 8620      00000000 
 8621 6f9a 4C8D1430 		leaq	(%rax,%rsi), %r10
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8622              		.loc 1 517 40 view .LVU2462
 8623 6f9e 488B45B0 		movq	-80(%rbp), %rax
 8624              		.loc 1 519 40 view .LVU2463
 8625 6fa2 C4817A6F 		vmovdqu	(%r14,%r10), %xmm0
 8625      0416
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8626              		.loc 1 517 40 view .LVU2464
 8627 6fa8 C5F96F0C 		vmovdqa	(%rax,%rsi), %xmm1
 8627      30
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 8628              		.loc 1 518 40 view .LVU2465
 8629 6fad C4A17A6F 		vmovdqu	(%rax,%r10), %xmm2
 8629      1410
 8630              		.loc 1 519 33 view .LVU2466
 8631 6fb3 C4E27900 		vpshufb	.LC90(%rip), %xmm0, %xmm4
 8631      25000000 
 8631      00
 8632 6fbc C5F160DA 		vpunpcklbw	%xmm2, %xmm1, %xmm3
 8633 6fc0 488D3C76 		leaq	(%rsi,%rsi,2), %rdi
 8634 6fc4 C4E26100 		vpshufb	.LC89(%rip), %xmm3, %xmm3
 8634      1D000000 
 8634      00
 8635 6fcd 4C01DF   		addq	%r11, %rdi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8636              		.loc 1 517 13 is_stmt 1 view .LVU2467
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 8637              		.loc 1 518 13 view .LVU2468
 8638              		.loc 1 519 13 view .LVU2469
 8639              		.loc 1 519 33 is_stmt 0 view .LVU2470
 8640 6fd0 C4E3614C 		vpblendvb	%xmm5, %xmm4, %xmm3, %xmm3
 8640      DC50
 8641 6fd6 C5FA7F1F 		vmovdqu	%xmm3, (%rdi)
 8642 6fda C4E27100 		vpshufb	.LC93(%rip), %xmm1, %xmm4
 8642      25000000 
 8642      00
 8643 6fe3 C4E26900 		vpshufb	.LC92(%rip), %xmm2, %xmm3
 8643      1D000000 
 8643      00
 8644 6fec C4E27100 		vpshufb	.LC96(%rip), %xmm1, %xmm1
 8644      0D000000 
 8644      00
 8645 6ff5 C4E26900 		vpshufb	.LC97(%rip), %xmm2, %xmm2
 8645      15000000 
 8645      00
 8646 6ffe C5F1EBCA 		vpor	%xmm2, %xmm1, %xmm1
 8647 7002 4489CE   		movl	%r9d, %esi
 8648 7005 C5F96F2D 		vmovdqa	.LC95(%rip), %xmm5
 8648      00000000 
 8649 700d C5F96F15 		vmovdqa	.LC99(%rip), %xmm2
 8649      00000000 
 8650 7015 C5E1EBDC 		vpor	%xmm4, %xmm3, %xmm3
 8651 7019 83E6F0   		andl	$-16, %esi
 8652 701c C4E27900 		vpshufb	.LC94(%rip), %xmm0, %xmm4
 8652      25000000 
 8652      00
 8653 7025 C4E27900 		vpshufb	.LC98(%rip), %xmm0, %xmm0
 8653      05000000 
 8653      00
 8654 702e C4E3614C 		vpblendvb	%xmm5, %xmm4, %xmm3, %xmm3
 8654      DC50
 8655 7034 C4E3794C 		vpblendvb	%xmm2, %xmm1, %xmm0, %xmm0
 8655      C120
 8656 703a 01F3     		addl	%esi, %ebx
 8657 703c 4183E10F 		andl	$15, %r9d
 8658 7040 C5FA7F5F 		vmovdqu	%xmm3, 16(%rdi)
 8658      10
 8659 7045 C5FA7F47 		vmovdqu	%xmm0, 32(%rdi)
 8659      20
 515:sepia_filter.c ****         {
 8660              		.loc 1 515 44 is_stmt 1 view .LVU2471
 515:sepia_filter.c ****         {
 8661              		.loc 1 515 9 view .LVU2472
 8662 704a 0F84B003 		je	.L205
 8662      0000
 8663              	.L206:
 8664              	.LVL292:
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8665              		.loc 1 517 13 view .LVU2473
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8666              		.loc 1 517 33 is_stmt 0 view .LVU2474
 8667 7050 488B4DB0 		movq	-80(%rbp), %rcx
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8668              		.loc 1 517 40 view .LVU2475
 8669 7054 4863FB   		movslq	%ebx, %rdi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8670              		.loc 1 517 33 view .LVU2476
 8671 7057 4531C9   		xorl	%r9d, %r9d
 8672 705a 448A0C39 		movb	(%rcx,%rdi), %r9b
 8673 705e 410FB604 		movzbl	(%r14,%rdi), %eax
 8673      3E
 8674 7063 4489C9   		movl	%r9d, %ecx
 8675 7066 88C5     		movb	%al, %ch
 8676              		.loc 1 519 33 view .LVU2477
 8677 7068 488B8570 		movq	-144(%rbp), %rax
 8677      FFFFFF
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8678              		.loc 1 517 25 view .LVU2478
 8679 706f 8D345B   		leal	(%rbx,%rbx,2), %esi
 8680              		.loc 1 519 33 view .LVU2479
 8681 7072 0FB63C38 		movzbl	(%rax,%rdi), %edi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8682              		.loc 1 517 25 view .LVU2480
 8683 7076 4C63D6   		movslq	%esi, %r10
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 8684              		.loc 1 518 13 is_stmt 1 view .LVU2481
 8685              		.loc 1 519 33 is_stmt 0 view .LVU2482
 8686 7079 43887C13 		movb	%dil, 2(%r11,%r10)
 8686      02
 515:sepia_filter.c ****         {
 8687              		.loc 1 515 44 view .LVU2483
 8688 707e 8D7B01   		leal	1(%rbx), %edi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8689              		.loc 1 517 33 view .LVU2484
 8690 7081 6643890C 		movw	%cx, (%r11,%r10)
 8690      13
 8691              		.loc 1 519 13 is_stmt 1 view .LVU2485
 515:sepia_filter.c ****         {
 8692              		.loc 1 515 44 view .LVU2486
 8693              	.LVL293:
 515:sepia_filter.c ****         {
 8694              		.loc 1 515 9 view .LVU2487
 8695 7086 4139FD   		cmpl	%edi, %r13d
 8696 7089 0F8E7103 		jle	.L205
 8696      0000
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8697              		.loc 1 517 13 view .LVU2488
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8698              		.loc 1 517 33 is_stmt 0 view .LVU2489
 8699 708f 488B4DB0 		movq	-80(%rbp), %rcx
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8700              		.loc 1 517 40 view .LVU2490
 8701 7093 4863FF   		movslq	%edi, %rdi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8702              		.loc 1 517 33 view .LVU2491
 8703 7096 4531D2   		xorl	%r10d, %r10d
 8704 7099 448A1439 		movb	(%rcx,%rdi), %r10b
 8705 709d 410FB604 		movzbl	(%r14,%rdi), %eax
 8705      3E
 8706 70a2 4489D1   		movl	%r10d, %ecx
 8707              		.loc 1 519 33 view .LVU2492
 8708 70a5 4C8B9570 		movq	-144(%rbp), %r10
 8708      FFFFFF
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8709              		.loc 1 517 25 view .LVU2493
 8710 70ac 448D4E03 		leal	3(%rsi), %r9d
 8711              		.loc 1 519 33 view .LVU2494
 8712 70b0 410FB63C 		movzbl	(%r10,%rdi), %edi
 8712      3A
 8713              	.LVL294:
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8714              		.loc 1 517 25 view .LVU2495
 8715 70b5 4D63C9   		movslq	%r9d, %r9
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 8716              		.loc 1 518 13 is_stmt 1 view .LVU2496
 8717              		.loc 1 519 33 is_stmt 0 view .LVU2497
 8718 70b8 43887C0B 		movb	%dil, 2(%r11,%r9)
 8718      02
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8719              		.loc 1 517 33 view .LVU2498
 8720 70bd 88C5     		movb	%al, %ch
 515:sepia_filter.c ****         {
 8721              		.loc 1 515 44 view .LVU2499
 8722 70bf 8D7B02   		leal	2(%rbx), %edi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8723              		.loc 1 517 33 view .LVU2500
 8724 70c2 6643890C 		movw	%cx, (%r11,%r9)
 8724      0B
 8725              		.loc 1 519 13 is_stmt 1 view .LVU2501
 515:sepia_filter.c ****         {
 8726              		.loc 1 515 44 view .LVU2502
 8727              	.LVL295:
 515:sepia_filter.c ****         {
 8728              		.loc 1 515 9 view .LVU2503
 8729 70c7 4139FD   		cmpl	%edi, %r13d
 8730 70ca 0F8E3003 		jle	.L205
 8730      0000
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8731              		.loc 1 517 13 view .LVU2504
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8732              		.loc 1 517 33 is_stmt 0 view .LVU2505
 8733 70d0 488B4DB0 		movq	-80(%rbp), %rcx
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8734              		.loc 1 517 40 view .LVU2506
 8735 70d4 4863FF   		movslq	%edi, %rdi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8736              		.loc 1 517 33 view .LVU2507
 8737 70d7 4531D2   		xorl	%r10d, %r10d
 8738 70da 448A1439 		movb	(%rcx,%rdi), %r10b
 8739 70de 410FB604 		movzbl	(%r14,%rdi), %eax
 8739      3E
 8740 70e3 4489D1   		movl	%r10d, %ecx
 8741              		.loc 1 519 33 view .LVU2508
 8742 70e6 4C8B9570 		movq	-144(%rbp), %r10
 8742      FFFFFF
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8743              		.loc 1 517 25 view .LVU2509
 8744 70ed 448D4E06 		leal	6(%rsi), %r9d
 8745              		.loc 1 519 33 view .LVU2510
 8746 70f1 410FB63C 		movzbl	(%r10,%rdi), %edi
 8746      3A
 8747              	.LVL296:
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8748              		.loc 1 517 25 view .LVU2511
 8749 70f6 4D63C9   		movslq	%r9d, %r9
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 8750              		.loc 1 518 13 is_stmt 1 view .LVU2512
 8751              		.loc 1 519 33 is_stmt 0 view .LVU2513
 8752 70f9 43887C0B 		movb	%dil, 2(%r11,%r9)
 8752      02
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8753              		.loc 1 517 33 view .LVU2514
 8754 70fe 88C5     		movb	%al, %ch
 515:sepia_filter.c ****         {
 8755              		.loc 1 515 44 view .LVU2515
 8756 7100 8D7B03   		leal	3(%rbx), %edi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8757              		.loc 1 517 33 view .LVU2516
 8758 7103 6643890C 		movw	%cx, (%r11,%r9)
 8758      0B
 8759              		.loc 1 519 13 is_stmt 1 view .LVU2517
 515:sepia_filter.c ****         {
 8760              		.loc 1 515 44 view .LVU2518
 8761              	.LVL297:
 515:sepia_filter.c ****         {
 8762              		.loc 1 515 9 view .LVU2519
 8763 7108 4139FD   		cmpl	%edi, %r13d
 8764 710b 0F8EEF02 		jle	.L205
 8764      0000
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8765              		.loc 1 517 13 view .LVU2520
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8766              		.loc 1 517 33 is_stmt 0 view .LVU2521
 8767 7111 488B4DB0 		movq	-80(%rbp), %rcx
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8768              		.loc 1 517 40 view .LVU2522
 8769 7115 4863FF   		movslq	%edi, %rdi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8770              		.loc 1 517 33 view .LVU2523
 8771 7118 4531D2   		xorl	%r10d, %r10d
 8772 711b 448A1439 		movb	(%rcx,%rdi), %r10b
 8773 711f 410FB604 		movzbl	(%r14,%rdi), %eax
 8773      3E
 8774 7124 4489D1   		movl	%r10d, %ecx
 8775              		.loc 1 519 33 view .LVU2524
 8776 7127 4C8B9570 		movq	-144(%rbp), %r10
 8776      FFFFFF
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8777              		.loc 1 517 25 view .LVU2525
 8778 712e 448D4E09 		leal	9(%rsi), %r9d
 8779              		.loc 1 519 33 view .LVU2526
 8780 7132 410FB63C 		movzbl	(%r10,%rdi), %edi
 8780      3A
 8781              	.LVL298:
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8782              		.loc 1 517 25 view .LVU2527
 8783 7137 4D63C9   		movslq	%r9d, %r9
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 8784              		.loc 1 518 13 is_stmt 1 view .LVU2528
 8785              		.loc 1 519 33 is_stmt 0 view .LVU2529
 8786 713a 43887C0B 		movb	%dil, 2(%r11,%r9)
 8786      02
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8787              		.loc 1 517 33 view .LVU2530
 8788 713f 88C5     		movb	%al, %ch
 515:sepia_filter.c ****         {
 8789              		.loc 1 515 44 view .LVU2531
 8790 7141 8D7B04   		leal	4(%rbx), %edi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8791              		.loc 1 517 33 view .LVU2532
 8792 7144 6643890C 		movw	%cx, (%r11,%r9)
 8792      0B
 8793              		.loc 1 519 13 is_stmt 1 view .LVU2533
 515:sepia_filter.c ****         {
 8794              		.loc 1 515 44 view .LVU2534
 8795              	.LVL299:
 515:sepia_filter.c ****         {
 8796              		.loc 1 515 9 view .LVU2535
 8797 7149 4139FD   		cmpl	%edi, %r13d
 8798 714c 0F8EAE02 		jle	.L205
 8798      0000
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8799              		.loc 1 517 13 view .LVU2536
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8800              		.loc 1 517 33 is_stmt 0 view .LVU2537
 8801 7152 488B4DB0 		movq	-80(%rbp), %rcx
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8802              		.loc 1 517 40 view .LVU2538
 8803 7156 4863FF   		movslq	%edi, %rdi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8804              		.loc 1 517 33 view .LVU2539
 8805 7159 4531D2   		xorl	%r10d, %r10d
 8806 715c 448A1439 		movb	(%rcx,%rdi), %r10b
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8807              		.loc 1 517 25 view .LVU2540
 8808 7160 448D4E0C 		leal	12(%rsi), %r9d
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8809              		.loc 1 517 33 view .LVU2541
 8810 7164 4489D0   		movl	%r10d, %eax
 8811              		.loc 1 519 33 view .LVU2542
 8812 7167 4C8B9570 		movq	-144(%rbp), %r10
 8812      FFFFFF
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8813              		.loc 1 517 33 view .LVU2543
 8814 716e 410FB60C 		movzbl	(%r14,%rdi), %ecx
 8814      3E
 8815              		.loc 1 519 33 view .LVU2544
 8816 7173 410FB63C 		movzbl	(%r10,%rdi), %edi
 8816      3A
 8817              	.LVL300:
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8818              		.loc 1 517 25 view .LVU2545
 8819 7178 4D63C9   		movslq	%r9d, %r9
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 8820              		.loc 1 518 13 is_stmt 1 view .LVU2546
 8821              		.loc 1 519 33 is_stmt 0 view .LVU2547
 8822 717b 43887C0B 		movb	%dil, 2(%r11,%r9)
 8822      02
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8823              		.loc 1 517 33 view .LVU2548
 8824 7180 88CC     		movb	%cl, %ah
 515:sepia_filter.c ****         {
 8825              		.loc 1 515 44 view .LVU2549
 8826 7182 8D7B05   		leal	5(%rbx), %edi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8827              		.loc 1 517 33 view .LVU2550
 8828 7185 66438904 		movw	%ax, (%r11,%r9)
 8828      0B
 8829              		.loc 1 519 13 is_stmt 1 view .LVU2551
 515:sepia_filter.c ****         {
 8830              		.loc 1 515 44 view .LVU2552
 8831              	.LVL301:
 515:sepia_filter.c ****         {
 8832              		.loc 1 515 9 view .LVU2553
 8833 718a 4139FD   		cmpl	%edi, %r13d
 8834 718d 0F8E6D02 		jle	.L205
 8834      0000
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8835              		.loc 1 517 13 view .LVU2554
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8836              		.loc 1 517 33 is_stmt 0 view .LVU2555
 8837 7193 488B4DB0 		movq	-80(%rbp), %rcx
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8838              		.loc 1 517 40 view .LVU2556
 8839 7197 4863FF   		movslq	%edi, %rdi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8840              		.loc 1 517 33 view .LVU2557
 8841 719a 4531D2   		xorl	%r10d, %r10d
 8842 719d 448A1439 		movb	(%rcx,%rdi), %r10b
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8843              		.loc 1 517 25 view .LVU2558
 8844 71a1 448D4E0F 		leal	15(%rsi), %r9d
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8845              		.loc 1 517 33 view .LVU2559
 8846 71a5 4489D0   		movl	%r10d, %eax
 8847              		.loc 1 519 33 view .LVU2560
 8848 71a8 4C8B9570 		movq	-144(%rbp), %r10
 8848      FFFFFF
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8849              		.loc 1 517 33 view .LVU2561
 8850 71af 410FB60C 		movzbl	(%r14,%rdi), %ecx
 8850      3E
 8851              		.loc 1 519 33 view .LVU2562
 8852 71b4 410FB63C 		movzbl	(%r10,%rdi), %edi
 8852      3A
 8853              	.LVL302:
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8854              		.loc 1 517 25 view .LVU2563
 8855 71b9 4D63C9   		movslq	%r9d, %r9
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 8856              		.loc 1 518 13 is_stmt 1 view .LVU2564
 8857              		.loc 1 519 33 is_stmt 0 view .LVU2565
 8858 71bc 43887C0B 		movb	%dil, 2(%r11,%r9)
 8858      02
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8859              		.loc 1 517 33 view .LVU2566
 8860 71c1 88CC     		movb	%cl, %ah
 515:sepia_filter.c ****         {
 8861              		.loc 1 515 44 view .LVU2567
 8862 71c3 8D7B06   		leal	6(%rbx), %edi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8863              		.loc 1 517 33 view .LVU2568
 8864 71c6 66438904 		movw	%ax, (%r11,%r9)
 8864      0B
 8865              		.loc 1 519 13 is_stmt 1 view .LVU2569
 515:sepia_filter.c ****         {
 8866              		.loc 1 515 44 view .LVU2570
 8867              	.LVL303:
 515:sepia_filter.c ****         {
 8868              		.loc 1 515 9 view .LVU2571
 8869 71cb 4139FD   		cmpl	%edi, %r13d
 8870 71ce 0F8E2C02 		jle	.L205
 8870      0000
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8871              		.loc 1 517 13 view .LVU2572
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8872              		.loc 1 517 33 is_stmt 0 view .LVU2573
 8873 71d4 488B4DB0 		movq	-80(%rbp), %rcx
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8874              		.loc 1 517 40 view .LVU2574
 8875 71d8 4863FF   		movslq	%edi, %rdi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8876              		.loc 1 517 33 view .LVU2575
 8877 71db 4531D2   		xorl	%r10d, %r10d
 8878 71de 448A1439 		movb	(%rcx,%rdi), %r10b
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8879              		.loc 1 517 25 view .LVU2576
 8880 71e2 448D4E12 		leal	18(%rsi), %r9d
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8881              		.loc 1 517 33 view .LVU2577
 8882 71e6 4489D0   		movl	%r10d, %eax
 8883              		.loc 1 519 33 view .LVU2578
 8884 71e9 4C8B9570 		movq	-144(%rbp), %r10
 8884      FFFFFF
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8885              		.loc 1 517 33 view .LVU2579
 8886 71f0 410FB60C 		movzbl	(%r14,%rdi), %ecx
 8886      3E
 8887              		.loc 1 519 33 view .LVU2580
 8888 71f5 410FB63C 		movzbl	(%r10,%rdi), %edi
 8888      3A
 8889              	.LVL304:
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8890              		.loc 1 517 25 view .LVU2581
 8891 71fa 4D63C9   		movslq	%r9d, %r9
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 8892              		.loc 1 518 13 is_stmt 1 view .LVU2582
 8893              		.loc 1 519 33 is_stmt 0 view .LVU2583
 8894 71fd 43887C0B 		movb	%dil, 2(%r11,%r9)
 8894      02
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8895              		.loc 1 517 33 view .LVU2584
 8896 7202 88CC     		movb	%cl, %ah
 515:sepia_filter.c ****         {
 8897              		.loc 1 515 44 view .LVU2585
 8898 7204 8D7B07   		leal	7(%rbx), %edi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8899              		.loc 1 517 33 view .LVU2586
 8900 7207 66438904 		movw	%ax, (%r11,%r9)
 8900      0B
 8901              		.loc 1 519 13 is_stmt 1 view .LVU2587
 515:sepia_filter.c ****         {
 8902              		.loc 1 515 44 view .LVU2588
 8903              	.LVL305:
 515:sepia_filter.c ****         {
 8904              		.loc 1 515 9 view .LVU2589
 8905 720c 4139FD   		cmpl	%edi, %r13d
 8906 720f 0F8EEB01 		jle	.L205
 8906      0000
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8907              		.loc 1 517 13 view .LVU2590
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8908              		.loc 1 517 33 is_stmt 0 view .LVU2591
 8909 7215 488B4DB0 		movq	-80(%rbp), %rcx
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8910              		.loc 1 517 40 view .LVU2592
 8911 7219 4863FF   		movslq	%edi, %rdi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8912              		.loc 1 517 33 view .LVU2593
 8913 721c 4531D2   		xorl	%r10d, %r10d
 8914 721f 448A1439 		movb	(%rcx,%rdi), %r10b
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8915              		.loc 1 517 25 view .LVU2594
 8916 7223 448D4E15 		leal	21(%rsi), %r9d
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8917              		.loc 1 517 33 view .LVU2595
 8918 7227 4489D0   		movl	%r10d, %eax
 8919              		.loc 1 519 33 view .LVU2596
 8920 722a 4C8B9570 		movq	-144(%rbp), %r10
 8920      FFFFFF
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8921              		.loc 1 517 33 view .LVU2597
 8922 7231 410FB60C 		movzbl	(%r14,%rdi), %ecx
 8922      3E
 8923              		.loc 1 519 33 view .LVU2598
 8924 7236 410FB63C 		movzbl	(%r10,%rdi), %edi
 8924      3A
 8925              	.LVL306:
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8926              		.loc 1 517 25 view .LVU2599
 8927 723b 4D63C9   		movslq	%r9d, %r9
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 8928              		.loc 1 518 13 is_stmt 1 view .LVU2600
 8929              		.loc 1 519 33 is_stmt 0 view .LVU2601
 8930 723e 43887C0B 		movb	%dil, 2(%r11,%r9)
 8930      02
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8931              		.loc 1 517 33 view .LVU2602
 8932 7243 88CC     		movb	%cl, %ah
 515:sepia_filter.c ****         {
 8933              		.loc 1 515 44 view .LVU2603
 8934 7245 8D7B08   		leal	8(%rbx), %edi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8935              		.loc 1 517 33 view .LVU2604
 8936 7248 66438904 		movw	%ax, (%r11,%r9)
 8936      0B
 8937              		.loc 1 519 13 is_stmt 1 view .LVU2605
 515:sepia_filter.c ****         {
 8938              		.loc 1 515 44 view .LVU2606
 8939              	.LVL307:
 515:sepia_filter.c ****         {
 8940              		.loc 1 515 9 view .LVU2607
 8941 724d 4139FD   		cmpl	%edi, %r13d
 8942 7250 0F8EAA01 		jle	.L205
 8942      0000
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8943              		.loc 1 517 13 view .LVU2608
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8944              		.loc 1 517 33 is_stmt 0 view .LVU2609
 8945 7256 488B4DB0 		movq	-80(%rbp), %rcx
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8946              		.loc 1 517 40 view .LVU2610
 8947 725a 4863FF   		movslq	%edi, %rdi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8948              		.loc 1 517 33 view .LVU2611
 8949 725d 4531D2   		xorl	%r10d, %r10d
 8950 7260 448A1439 		movb	(%rcx,%rdi), %r10b
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8951              		.loc 1 517 25 view .LVU2612
 8952 7264 448D4E18 		leal	24(%rsi), %r9d
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8953              		.loc 1 517 33 view .LVU2613
 8954 7268 4489D0   		movl	%r10d, %eax
 8955              		.loc 1 519 33 view .LVU2614
 8956 726b 4C8B9570 		movq	-144(%rbp), %r10
 8956      FFFFFF
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8957              		.loc 1 517 33 view .LVU2615
 8958 7272 410FB60C 		movzbl	(%r14,%rdi), %ecx
 8958      3E
 8959              		.loc 1 519 33 view .LVU2616
 8960 7277 410FB63C 		movzbl	(%r10,%rdi), %edi
 8960      3A
 8961              	.LVL308:
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8962              		.loc 1 517 25 view .LVU2617
 8963 727c 4D63C9   		movslq	%r9d, %r9
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 8964              		.loc 1 518 13 is_stmt 1 view .LVU2618
 8965              		.loc 1 519 33 is_stmt 0 view .LVU2619
 8966 727f 43887C0B 		movb	%dil, 2(%r11,%r9)
 8966      02
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8967              		.loc 1 517 33 view .LVU2620
 8968 7284 88CC     		movb	%cl, %ah
 515:sepia_filter.c ****         {
 8969              		.loc 1 515 44 view .LVU2621
 8970 7286 8D7B09   		leal	9(%rbx), %edi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8971              		.loc 1 517 33 view .LVU2622
 8972 7289 66438904 		movw	%ax, (%r11,%r9)
 8972      0B
 8973              		.loc 1 519 13 is_stmt 1 view .LVU2623
 515:sepia_filter.c ****         {
 8974              		.loc 1 515 44 view .LVU2624
 8975              	.LVL309:
 515:sepia_filter.c ****         {
 8976              		.loc 1 515 9 view .LVU2625
 8977 728e 4139FD   		cmpl	%edi, %r13d
 8978 7291 0F8E6901 		jle	.L205
 8978      0000
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8979              		.loc 1 517 13 view .LVU2626
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8980              		.loc 1 517 33 is_stmt 0 view .LVU2627
 8981 7297 488B4DB0 		movq	-80(%rbp), %rcx
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8982              		.loc 1 517 40 view .LVU2628
 8983 729b 4863FF   		movslq	%edi, %rdi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8984              		.loc 1 517 33 view .LVU2629
 8985 729e 4531D2   		xorl	%r10d, %r10d
 8986 72a1 448A1439 		movb	(%rcx,%rdi), %r10b
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8987              		.loc 1 517 25 view .LVU2630
 8988 72a5 448D4E1B 		leal	27(%rsi), %r9d
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8989              		.loc 1 517 33 view .LVU2631
 8990 72a9 4489D0   		movl	%r10d, %eax
 8991              		.loc 1 519 33 view .LVU2632
 8992 72ac 4C8B9570 		movq	-144(%rbp), %r10
 8992      FFFFFF
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8993              		.loc 1 517 33 view .LVU2633
 8994 72b3 410FB60C 		movzbl	(%r14,%rdi), %ecx
 8994      3E
 8995              		.loc 1 519 33 view .LVU2634
 8996 72b8 410FB63C 		movzbl	(%r10,%rdi), %edi
 8996      3A
 8997              	.LVL310:
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 8998              		.loc 1 517 25 view .LVU2635
 8999 72bd 4D63C9   		movslq	%r9d, %r9
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 9000              		.loc 1 518 13 is_stmt 1 view .LVU2636
 9001              		.loc 1 519 33 is_stmt 0 view .LVU2637
 9002 72c0 43887C0B 		movb	%dil, 2(%r11,%r9)
 9002      02
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9003              		.loc 1 517 33 view .LVU2638
 9004 72c5 88CC     		movb	%cl, %ah
 515:sepia_filter.c ****         {
 9005              		.loc 1 515 44 view .LVU2639
 9006 72c7 8D7B0A   		leal	10(%rbx), %edi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9007              		.loc 1 517 33 view .LVU2640
 9008 72ca 66438904 		movw	%ax, (%r11,%r9)
 9008      0B
 9009              		.loc 1 519 13 is_stmt 1 view .LVU2641
 515:sepia_filter.c ****         {
 9010              		.loc 1 515 44 view .LVU2642
 9011              	.LVL311:
 515:sepia_filter.c ****         {
 9012              		.loc 1 515 9 view .LVU2643
 9013 72cf 4139FD   		cmpl	%edi, %r13d
 9014 72d2 0F8E2801 		jle	.L205
 9014      0000
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9015              		.loc 1 517 13 view .LVU2644
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9016              		.loc 1 517 33 is_stmt 0 view .LVU2645
 9017 72d8 488B4DB0 		movq	-80(%rbp), %rcx
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9018              		.loc 1 517 40 view .LVU2646
 9019 72dc 4863FF   		movslq	%edi, %rdi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9020              		.loc 1 517 33 view .LVU2647
 9021 72df 4531D2   		xorl	%r10d, %r10d
 9022 72e2 448A1439 		movb	(%rcx,%rdi), %r10b
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9023              		.loc 1 517 25 view .LVU2648
 9024 72e6 448D4E1E 		leal	30(%rsi), %r9d
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9025              		.loc 1 517 33 view .LVU2649
 9026 72ea 4489D0   		movl	%r10d, %eax
 9027              		.loc 1 519 33 view .LVU2650
 9028 72ed 4C8B9570 		movq	-144(%rbp), %r10
 9028      FFFFFF
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9029              		.loc 1 517 33 view .LVU2651
 9030 72f4 410FB60C 		movzbl	(%r14,%rdi), %ecx
 9030      3E
 9031              		.loc 1 519 33 view .LVU2652
 9032 72f9 410FB63C 		movzbl	(%r10,%rdi), %edi
 9032      3A
 9033              	.LVL312:
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9034              		.loc 1 517 25 view .LVU2653
 9035 72fe 4D63C9   		movslq	%r9d, %r9
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 9036              		.loc 1 518 13 is_stmt 1 view .LVU2654
 9037              		.loc 1 519 33 is_stmt 0 view .LVU2655
 9038 7301 43887C0B 		movb	%dil, 2(%r11,%r9)
 9038      02
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9039              		.loc 1 517 33 view .LVU2656
 9040 7306 88CC     		movb	%cl, %ah
 515:sepia_filter.c ****         {
 9041              		.loc 1 515 44 view .LVU2657
 9042 7308 8D7B0B   		leal	11(%rbx), %edi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9043              		.loc 1 517 33 view .LVU2658
 9044 730b 66438904 		movw	%ax, (%r11,%r9)
 9044      0B
 9045              		.loc 1 519 13 is_stmt 1 view .LVU2659
 515:sepia_filter.c ****         {
 9046              		.loc 1 515 44 view .LVU2660
 9047              	.LVL313:
 515:sepia_filter.c ****         {
 9048              		.loc 1 515 9 view .LVU2661
 9049 7310 4139FD   		cmpl	%edi, %r13d
 9050 7313 0F8EE700 		jle	.L205
 9050      0000
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9051              		.loc 1 517 13 view .LVU2662
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9052              		.loc 1 517 33 is_stmt 0 view .LVU2663
 9053 7319 488B4DB0 		movq	-80(%rbp), %rcx
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9054              		.loc 1 517 40 view .LVU2664
 9055 731d 4863FF   		movslq	%edi, %rdi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9056              		.loc 1 517 33 view .LVU2665
 9057 7320 4531D2   		xorl	%r10d, %r10d
 9058 7323 448A1439 		movb	(%rcx,%rdi), %r10b
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9059              		.loc 1 517 25 view .LVU2666
 9060 7327 448D4E21 		leal	33(%rsi), %r9d
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9061              		.loc 1 517 33 view .LVU2667
 9062 732b 4489D0   		movl	%r10d, %eax
 9063              		.loc 1 519 33 view .LVU2668
 9064 732e 4C8B9570 		movq	-144(%rbp), %r10
 9064      FFFFFF
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9065              		.loc 1 517 33 view .LVU2669
 9066 7335 410FB60C 		movzbl	(%r14,%rdi), %ecx
 9066      3E
 9067              		.loc 1 519 33 view .LVU2670
 9068 733a 410FB63C 		movzbl	(%r10,%rdi), %edi
 9068      3A
 9069              	.LVL314:
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9070              		.loc 1 517 25 view .LVU2671
 9071 733f 4D63C9   		movslq	%r9d, %r9
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 9072              		.loc 1 518 13 is_stmt 1 view .LVU2672
 9073              		.loc 1 519 33 is_stmt 0 view .LVU2673
 9074 7342 43887C0B 		movb	%dil, 2(%r11,%r9)
 9074      02
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9075              		.loc 1 517 33 view .LVU2674
 9076 7347 88CC     		movb	%cl, %ah
 515:sepia_filter.c ****         {
 9077              		.loc 1 515 44 view .LVU2675
 9078 7349 8D7B0C   		leal	12(%rbx), %edi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9079              		.loc 1 517 33 view .LVU2676
 9080 734c 66438904 		movw	%ax, (%r11,%r9)
 9080      0B
 9081              		.loc 1 519 13 is_stmt 1 view .LVU2677
 515:sepia_filter.c ****         {
 9082              		.loc 1 515 44 view .LVU2678
 9083              	.LVL315:
 515:sepia_filter.c ****         {
 9084              		.loc 1 515 9 view .LVU2679
 9085 7351 4139FD   		cmpl	%edi, %r13d
 9086 7354 0F8EA600 		jle	.L205
 9086      0000
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9087              		.loc 1 517 13 view .LVU2680
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9088              		.loc 1 517 33 is_stmt 0 view .LVU2681
 9089 735a 488B4DB0 		movq	-80(%rbp), %rcx
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9090              		.loc 1 517 40 view .LVU2682
 9091 735e 4863FF   		movslq	%edi, %rdi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9092              		.loc 1 517 33 view .LVU2683
 9093 7361 4531D2   		xorl	%r10d, %r10d
 9094 7364 448A1439 		movb	(%rcx,%rdi), %r10b
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9095              		.loc 1 517 25 view .LVU2684
 9096 7368 448D4E24 		leal	36(%rsi), %r9d
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9097              		.loc 1 517 33 view .LVU2685
 9098 736c 4489D0   		movl	%r10d, %eax
 9099              		.loc 1 519 33 view .LVU2686
 9100 736f 4C8B9570 		movq	-144(%rbp), %r10
 9100      FFFFFF
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9101              		.loc 1 517 33 view .LVU2687
 9102 7376 410FB60C 		movzbl	(%r14,%rdi), %ecx
 9102      3E
 9103              		.loc 1 519 33 view .LVU2688
 9104 737b 410FB63C 		movzbl	(%r10,%rdi), %edi
 9104      3A
 9105              	.LVL316:
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9106              		.loc 1 517 25 view .LVU2689
 9107 7380 4D63C9   		movslq	%r9d, %r9
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 9108              		.loc 1 518 13 is_stmt 1 view .LVU2690
 9109              		.loc 1 519 33 is_stmt 0 view .LVU2691
 9110 7383 43887C0B 		movb	%dil, 2(%r11,%r9)
 9110      02
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9111              		.loc 1 517 33 view .LVU2692
 9112 7388 88CC     		movb	%cl, %ah
 515:sepia_filter.c ****         {
 9113              		.loc 1 515 44 view .LVU2693
 9114 738a 8D7B0D   		leal	13(%rbx), %edi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9115              		.loc 1 517 33 view .LVU2694
 9116 738d 66438904 		movw	%ax, (%r11,%r9)
 9116      0B
 9117              		.loc 1 519 13 is_stmt 1 view .LVU2695
 515:sepia_filter.c ****         {
 9118              		.loc 1 515 44 view .LVU2696
 9119              	.LVL317:
 515:sepia_filter.c ****         {
 9120              		.loc 1 515 9 view .LVU2697
 9121 7392 4139FD   		cmpl	%edi, %r13d
 9122 7395 7E69     		jle	.L205
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9123              		.loc 1 517 13 view .LVU2698
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9124              		.loc 1 517 33 is_stmt 0 view .LVU2699
 9125 7397 488B4DB0 		movq	-80(%rbp), %rcx
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9126              		.loc 1 517 40 view .LVU2700
 9127 739b 4863FF   		movslq	%edi, %rdi
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9128              		.loc 1 517 33 view .LVU2701
 9129 739e 4531D2   		xorl	%r10d, %r10d
 9130 73a1 448A1439 		movb	(%rcx,%rdi), %r10b
 9131 73a5 410FB60C 		movzbl	(%r14,%rdi), %ecx
 9131      3E
 9132 73aa 4489D0   		movl	%r10d, %eax
 9133              		.loc 1 519 33 view .LVU2702
 9134 73ad 4C8B9570 		movq	-144(%rbp), %r10
 9134      FFFFFF
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9135              		.loc 1 517 25 view .LVU2703
 9136 73b4 448D4E27 		leal	39(%rsi), %r9d
 9137 73b8 4D63C9   		movslq	%r9d, %r9
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 9138              		.loc 1 518 13 is_stmt 1 view .LVU2704
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9139              		.loc 1 517 33 is_stmt 0 view .LVU2705
 9140 73bb 88CC     		movb	%cl, %ah
 9141              		.loc 1 519 33 view .LVU2706
 9142 73bd 410FB63C 		movzbl	(%r10,%rdi), %edi
 9142      3A
 9143              	.LVL318:
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9144              		.loc 1 517 33 view .LVU2707
 9145 73c2 66438904 		movw	%ax, (%r11,%r9)
 9145      0B
 9146              		.loc 1 519 13 is_stmt 1 view .LVU2708
 515:sepia_filter.c ****         {
 9147              		.loc 1 515 44 is_stmt 0 view .LVU2709
 9148 73c7 8D430E   		leal	14(%rbx), %eax
 9149              		.loc 1 519 33 view .LVU2710
 9150 73ca 43887C0B 		movb	%dil, 2(%r11,%r9)
 9150      02
 515:sepia_filter.c ****         {
 9151              		.loc 1 515 44 is_stmt 1 view .LVU2711
 9152              	.LVL319:
 515:sepia_filter.c ****         {
 9153              		.loc 1 515 9 view .LVU2712
 9154 73cf 4139C5   		cmpl	%eax, %r13d
 9155 73d2 7E2C     		jle	.L205
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9156              		.loc 1 517 13 view .LVU2713
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9157              		.loc 1 517 33 is_stmt 0 view .LVU2714
 9158 73d4 488B4DB0 		movq	-80(%rbp), %rcx
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9159              		.loc 1 517 40 view .LVU2715
 9160 73d8 4898     		cltq
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9161              		.loc 1 517 33 view .LVU2716
 9162 73da 31FF     		xorl	%edi, %edi
 9163 73dc 408A3C01 		movb	(%rcx,%rax), %dil
 9164 73e0 410FB61C 		movzbl	(%r14,%rax), %ebx
 9164      06
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9165              		.loc 1 517 25 view .LVU2717
 9166 73e5 83C62A   		addl	$42, %esi
 9167              		.loc 1 519 33 view .LVU2718
 9168 73e8 410FB604 		movzbl	(%r10,%rax), %eax
 9168      02
 9169              	.LVL320:
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9170              		.loc 1 517 33 view .LVU2719
 9171 73ed 89F9     		movl	%edi, %ecx
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9172              		.loc 1 517 25 view .LVU2720
 9173 73ef 4863F6   		movslq	%esi, %rsi
 518:sepia_filter.c ****             pixels_out[3*i + 2] = B_out[i];
 9174              		.loc 1 518 13 is_stmt 1 view .LVU2721
 517:sepia_filter.c ****             pixels_out[3*i + 1] = G_out[i]; 
 9175              		.loc 1 517 33 is_stmt 0 view .LVU2722
 9176 73f2 88DD     		movb	%bl, %ch
 9177 73f4 6641890C 		movw	%cx, (%r11,%rsi)
 9177      33
 9178              		.loc 1 519 13 is_stmt 1 view .LVU2723
 9179              		.loc 1 519 33 is_stmt 0 view .LVU2724
 9180 73f9 41884433 		movb	%al, 2(%r11,%rsi)
 9180      02
 515:sepia_filter.c ****         {
 9181              		.loc 1 515 44 is_stmt 1 view .LVU2725
 515:sepia_filter.c ****         {
 9182              		.loc 1 515 9 view .LVU2726
 9183              	.LVL321:
 9184 73fe 6690     		.p2align 4,,10
 9185              		.p2align 3
 9186              	.L205:
 515:sepia_filter.c ****         {
 9187              		.loc 1 515 9 is_stmt 0 view .LVU2727
 9188 7400 4C898530 		movq	%r8, -208(%rbp)
 9188      FFFFFF
 9189 7407 4C899D50 		movq	%r11, -176(%rbp)
 9189      FFFFFF
 9190 740e 48895590 		movq	%rdx, -112(%rbp)
 9191              	.LBE62:
 520:sepia_filter.c ****         }
 521:sepia_filter.c **** 
 522:sepia_filter.c ****         dummy(image_in, image_out);
 9192              		.loc 1 522 9 is_stmt 1 view .LVU2728
 9193 7412 488BB570 		movq	-400(%rbp), %rsi
 9193      FEFFFF
 9194 7419 488BBD60 		movq	-416(%rbp), %rdi
 9194      FEFFFF
 9195 7420 C5F877   		vzeroupper
 9196              	.LVL322:
 9197 7423 E8000000 		call	dummy
 9197      00
 9198              	.LVL323:
 479:sepia_filter.c ****     {
 9199              		.loc 1 479 34 view .LVU2729
 479:sepia_filter.c ****     {
 9200              		.loc 1 479 23 view .LVU2730
 9201 7428 FF8D6CFE 		decl	-404(%rbp)
 9201      FFFF
 9202 742e 488B5590 		movq	-112(%rbp), %rdx
 9203 7432 4C8B9D50 		movq	-176(%rbp), %r11
 9203      FFFFFF
 9204 7439 4C8B8530 		movq	-208(%rbp), %r8
 9204      FFFFFF
 9205 7440 0F855AEA 		jne	.L210
 9205      FFFF
 9206 7446 488B5DB0 		movq	-80(%rbp), %rbx
 9207              	.LVL324:
 9208              	.L209:
 479:sepia_filter.c ****     {
 9209              		.loc 1 479 23 is_stmt 0 view .LVU2731
 9210              	.LBE66:
 523:sepia_filter.c ****     }
 524:sepia_filter.c **** 
 525:sepia_filter.c ****     end_t = get_wall_time();
 9211              		.loc 1 525 5 is_stmt 1 view .LVU2732
 9212              		.loc 1 525 13 is_stmt 0 view .LVU2733
 9213 744a 31C0     		xorl	%eax, %eax
 9214 744c E8000000 		call	get_wall_time
 9214      00
 9215              	.LVL325:
 526:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_SOA1");
 9216              		.loc 1 526 5 is_stmt 1 view .LVU2734
 9217 7451 C5FB5C85 		vsubsd	-432(%rbp), %xmm0, %xmm0
 9217      50FEFFFF 
 9218              	.LVL326:
 9219              		.loc 1 526 5 is_stmt 0 view .LVU2735
 9220 7459 4489EF   		movl	%r13d, %edi
 9221 745c BE000000 		movl	$.LC113, %esi
 9221      00
 9222 7461 E8000000 		call	results
 9222      00
 9223              	.LVL327:
 527:sepia_filter.c **** 
 528:sepia_filter.c ****     free(R_in); free(R_out);
 9224              		.loc 1 528 5 is_stmt 1 view .LVU2736
 9225 7466 4C89E7   		movq	%r12, %rdi
 9226 7469 E8000000 		call	free
 9226      00
 9227              	.LVL328:
 9228              		.loc 1 528 17 view .LVU2737
 529:sepia_filter.c **** }
 9229              		.loc 1 529 1 is_stmt 0 view .LVU2738
 9230 746e 4881C488 		addq	$392, %rsp
 9230      010000
 528:sepia_filter.c **** }
 9231              		.loc 1 528 17 view .LVU2739
 9232 7475 4889DF   		movq	%rbx, %rdi
 9233              		.loc 1 529 1 view .LVU2740
 9234 7478 5B       		popq	%rbx
 9235 7479 415C     		popq	%r12
 9236              	.LVL329:
 9237              		.loc 1 529 1 view .LVU2741
 9238 747b 415D     		popq	%r13
 9239              		.cfi_remember_state
 9240              		.cfi_def_cfa 13, 0
 9241 747d 415E     		popq	%r14
 9242 747f 415F     		popq	%r15
 9243 7481 5D       		popq	%rbp
 9244              	.LVL330:
 9245              		.loc 1 529 1 view .LVU2742
 9246 7482 498D65F0 		leaq	-16(%r13), %rsp
 9247              		.cfi_def_cfa 7, 16
 9248 7486 415D     		popq	%r13
 9249              		.cfi_def_cfa_offset 8
 528:sepia_filter.c **** }
 9250              		.loc 1 528 17 view .LVU2743
 9251 7488 E9000000 		jmp	free
 9251      00
 9252              	.LVL331:
 9253              	.L232:
 9254              		.cfi_restore_state
 9255              	.LBB67:
 522:sepia_filter.c ****     }
 9256              		.loc 1 522 9 view .LVU2744
 9257 748d 488BB570 		movq	-400(%rbp), %rsi
 9257      FEFFFF
 9258 7494 488BBD60 		movq	-416(%rbp), %rdi
 9258      FEFFFF
 9259 749b 44898550 		movl	%r8d, -176(%rbp)
 9259      FFFFFF
 522:sepia_filter.c ****     }
 9260              		.loc 1 522 9 is_stmt 1 view .LVU2745
 9261 74a2 E8000000 		call	dummy
 9261      00
 9262              	.LVL332:
 479:sepia_filter.c ****     {
 9263              		.loc 1 479 34 view .LVU2746
 479:sepia_filter.c ****     {
 9264              		.loc 1 479 23 view .LVU2747
 9265 74a7 FF8D6CFE 		decl	-404(%rbp)
 9265      FFFF
 9266 74ad 448B8550 		movl	-176(%rbp), %r8d
 9266      FFFFFF
 9267 74b4 0F85B0E9 		jne	.L191
 9267      FFFF
 9268 74ba 4C89E0   		movq	%r12, %rax
 9269 74bd 4589C5   		movl	%r8d, %r13d
 9270              	.LVL333:
 479:sepia_filter.c ****     {
 9271              		.loc 1 479 23 is_stmt 0 view .LVU2748
 9272 74c0 4989DC   		movq	%rbx, %r12
 9273              	.LVL334:
 479:sepia_filter.c ****     {
 9274              		.loc 1 479 23 view .LVU2749
 9275 74c3 4889C3   		movq	%rax, %rbx
 9276              	.LVL335:
 479:sepia_filter.c ****     {
 9277              		.loc 1 479 23 view .LVU2750
 9278 74c6 EB82     		jmp	.L209
 9279              	.LVL336:
 9280              	.L212:
 9281              	.LBB63:
 484:sepia_filter.c ****         {
 9282              		.loc 1 484 18 view .LVU2751
 9283 74c8 31F6     		xorl	%esi, %esi
 9284 74ca 31C0     		xorl	%eax, %eax
 9285 74cc E971EBFF 		jmp	.L192
 9285      FF
 9286              	.L213:
 484:sepia_filter.c ****         {
 9287              		.loc 1 484 18 view .LVU2752
 9288              	.LBE63:
 9289              	.LBB64:
 493:sepia_filter.c ****         {
 9290              		.loc 1 493 18 view .LVU2753
 9291 74d1 31C0     		xorl	%eax, %eax
 9292 74d3 4531D2   		xorl	%r10d, %r10d
 9293 74d6 E9EEF3FF 		jmp	.L197
 9293      FF
 9294              	.L214:
 493:sepia_filter.c ****         {
 9295              		.loc 1 493 18 view .LVU2754
 9296              	.LBE64:
 9297              	.LBB65:
 515:sepia_filter.c ****         {
 9298              		.loc 1 515 18 view .LVU2755
 9299 74db 31F6     		xorl	%esi, %esi
 9300 74dd 31DB     		xorl	%ebx, %ebx
 9301 74df E994FAFF 		jmp	.L203
 9301      FF
 9302              	.LVL337:
 9303              	.L237:
 515:sepia_filter.c ****         {
 9304              		.loc 1 515 18 view .LVU2756
 9305              	.LBE65:
 9306              	.LBE67:
 459:sepia_filter.c ****         exit(-1);
 9307              		.loc 1 459 9 is_stmt 1 view .LVU2757
 9308 74e4 BF000000 		movl	$.LC0, %edi
 9308      00
 9309              	.LVL338:
 459:sepia_filter.c ****         exit(-1);
 9310              		.loc 1 459 9 is_stmt 0 view .LVU2758
 9311 74e9 E8000000 		call	puts
 9311      00
 9312              	.LVL339:
 460:sepia_filter.c ****     }
 9313              		.loc 1 460 9 is_stmt 1 view .LVU2759
 9314 74ee 83CFFF   		orl	$-1, %edi
 9315 74f1 E8000000 		call	exit
 9315      00
 9316              	.LVL340:
 9317              		.cfi_endproc
 9318              	.LFE25:
 9320              		.section	.rodata.str1.1
 9321              	.LC115:
 9322 006d 73657069 		.string	"sepiaf_block"
 9322      61665F62 
 9322      6C6F636B 
 9322      00
 9323              		.text
 9324 74f6 662E0F1F 		.p2align 4
 9324      84000000 
 9324      0000
 9325              		.globl	sepia_filter_block
 9327              	sepia_filter_block:
 9328              	.LVL341:
 9329              	.LFB26:
 530:sepia_filter.c **** 
 531:sepia_filter.c **** 
 532:sepia_filter.c **** /* Cuidado, el tamaño de la imagen debería ser múltiplo de BLOCK */
 533:sepia_filter.c **** #define BLOCK 64
 534:sepia_filter.c **** 
 535:sepia_filter.c ****  /* función que entrelaza la transformación de los datos con los cálculos a realizar.
 536:sepia_filter.c ****     De esta forma, en lugar de necesitar nuevas variables
 537:sepia_filter.c ****     con **todos** los valores RGB de la imagen en formato SOA,
 538:sepia_filter.c ****     solamente son necesarias variables que almacenen **parte** de los valores RGB */
 539:sepia_filter.c **** void
 540:sepia_filter.c **** sepia_filter_block(image_t * restrict image_in, image_t * restrict image_out)
 541:sepia_filter.c **** {
 9330              		.loc 1 541 1 view -0
 9331              		.cfi_startproc
 542:sepia_filter.c ****     double start_t, end_t;
 9332              		.loc 1 542 5 view .LVU2761
 543:sepia_filter.c ****     const int height = image_in->height;
 9333              		.loc 1 543 5 view .LVU2762
 541:sepia_filter.c ****     double start_t, end_t;
 9334              		.loc 1 541 1 is_stmt 0 view .LVU2763
 9335 7500 4155     		pushq	%r13
 9336              		.cfi_def_cfa_offset 16
 9337              		.cfi_offset 13, -16
 9338 7502 4C8D6C24 		leaq	16(%rsp), %r13
 9338      10
 9339              		.cfi_def_cfa 13, 0
 9340 7507 4883E4E0 		andq	$-32, %rsp
 9341 750b 41FF75F8 		pushq	-8(%r13)
 9342 750f 55       		pushq	%rbp
 9343 7510 4889E5   		movq	%rsp, %rbp
 9344              		.cfi_escape 0x10,0x6,0x2,0x76,0
 9345 7513 4157     		pushq	%r15
 9346 7515 4156     		pushq	%r14
 9347 7517 4155     		pushq	%r13
 9348              		.cfi_escape 0xf,0x3,0x76,0x68,0x6
 9349              		.cfi_escape 0x10,0xf,0x2,0x76,0x78
 9350              		.cfi_escape 0x10,0xe,0x2,0x76,0x70
 9351 7519 4154     		pushq	%r12
 9352 751b 53       		pushq	%rbx
 9353 751c 4881ECA8 		subq	$680, %rsp
 9353      020000
 9354              		.cfi_escape 0x10,0xc,0x2,0x76,0x60
 9355              		.cfi_escape 0x10,0x3,0x2,0x76,0x58
 544:sepia_filter.c ****     const int width =  image_in->width;
 9356              		.loc 1 544 15 view .LVU2764
 9357 7523 C5FA7E47 		vmovq	8(%rdi), %xmm0
 9357      08
 545:sepia_filter.c ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) R_in[BLOCK];
 546:sepia_filter.c ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) G_in[BLOCK];
 547:sepia_filter.c ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) B_in[BLOCK];
 548:sepia_filter.c ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) R_out[BLOCK];
 549:sepia_filter.c ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) G_out[BLOCK];
 550:sepia_filter.c ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) B_out[BLOCK];
 551:sepia_filter.c ****     unsigned char * restrict pixels_in;
 552:sepia_filter.c ****     unsigned char * restrict pixels_out;
 553:sepia_filter.c **** 
 554:sepia_filter.c ****     if (image_in->bytes_per_pixel != 3)
 9358              		.loc 1 554 8 view .LVU2765
 9359 7528 837F1003 		cmpl	$3, 16(%rdi)
 9360 752c C4C37916 		vpextrd	$1, %xmm0, %r14d
 9360      C601
 9361              	.LVL342:
 544:sepia_filter.c ****     const int width =  image_in->width;
 9362              		.loc 1 544 5 is_stmt 1 view .LVU2766
 545:sepia_filter.c ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) R_in[BLOCK];
 9363              		.loc 1 545 5 view .LVU2767
 546:sepia_filter.c ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) B_in[BLOCK];
 9364              		.loc 1 546 5 view .LVU2768
 547:sepia_filter.c ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) R_out[BLOCK];
 9365              		.loc 1 547 5 view .LVU2769
 548:sepia_filter.c ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) G_out[BLOCK];
 9366              		.loc 1 548 5 view .LVU2770
 549:sepia_filter.c ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) B_out[BLOCK];
 9367              		.loc 1 549 5 view .LVU2771
 550:sepia_filter.c ****     unsigned char * restrict pixels_in;
 9368              		.loc 1 550 5 view .LVU2772
 551:sepia_filter.c ****     unsigned char * restrict pixels_out;
 9369              		.loc 1 551 5 view .LVU2773
 552:sepia_filter.c **** 
 9370              		.loc 1 552 5 view .LVU2774
 9371              		.loc 1 554 5 view .LVU2775
 9372              		.loc 1 554 8 is_stmt 0 view .LVU2776
 9373 7532 0F85010A 		jne	.L249
 9373      0000
 9374 7538 C5F97EC3 		vmovd	%xmm0, %ebx
 555:sepia_filter.c ****     {
 556:sepia_filter.c ****         printf("ERROR: input image has to be RGB\n");
 557:sepia_filter.c ****         exit(-1);
 558:sepia_filter.c ****     }
 559:sepia_filter.c ****     
 560:sepia_filter.c ****     /* fill struct fields */
 561:sepia_filter.c ****     image_out->width  = width;
 9375              		.loc 1 561 5 is_stmt 1 view .LVU2777
 562:sepia_filter.c ****     image_out->height = height;
 9376              		.loc 1 562 5 view .LVU2778
 563:sepia_filter.c ****     image_out->bytes_per_pixel = 3;
 9377              		.loc 1 563 32 is_stmt 0 view .LVU2779
 9378 753c 48B80300 		movabsq	$8589934595, %rax
 9378      00000200 
 9378      0000
 9379 7546 48894610 		movq	%rax, 16(%rsi)
 9380              	.LBB68:
 9381              	.LBB69:
 564:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 565:sepia_filter.c **** 
 566:sepia_filter.c ****     start_t = get_wall_time();
 567:sepia_filter.c ****     for (int it = 0; it < NITER; it++)
 568:sepia_filter.c ****     {
 569:sepia_filter.c ****         for (int i = 0; i < height*width; i+= BLOCK)
 9382              		.loc 1 569 35 view .LVU2780
 9383 754a 410FAFDE 		imull	%r14d, %ebx
 9384              	.LBE69:
 9385              	.LBE68:
 566:sepia_filter.c ****     for (int it = 0; it < NITER; it++)
 9386              		.loc 1 566 15 view .LVU2781
 9387 754e 31C0     		xorl	%eax, %eax
 561:sepia_filter.c ****     image_out->height = height;
 9388              		.loc 1 561 23 view .LVU2782
 9389 7550 C5F9D646 		vmovq	%xmm0, 8(%rsi)
 9389      08
 563:sepia_filter.c ****     image_out->color_space = JCS_RGB;
 9390              		.loc 1 563 5 is_stmt 1 view .LVU2783
 564:sepia_filter.c **** 
 9391              		.loc 1 564 5 view .LVU2784
 566:sepia_filter.c ****     for (int it = 0; it < NITER; it++)
 9392              		.loc 1 566 5 view .LVU2785
 9393 7555 4989FD   		movq	%rdi, %r13
 9394 7558 4989F4   		movq	%rsi, %r12
 566:sepia_filter.c ****     for (int it = 0; it < NITER; it++)
 9395              		.loc 1 566 15 is_stmt 0 view .LVU2786
 9396 755b E8000000 		call	get_wall_time
 9396      00
 9397              	.LVL343:
 566:sepia_filter.c ****     for (int it = 0; it < NITER; it++)
 9398              		.loc 1 566 15 view .LVU2787
 9399 7560 8D43FF   		leal	-1(%rbx), %eax
 9400 7563 C1E806   		shrl	$6, %eax
 9401 7566 FFC0     		incl	%eax
 9402 7568 4C8D3440 		leaq	(%rax,%rax,2), %r14
 9403 756c C5FB1185 		vmovsd	%xmm0, -696(%rbp)
 9403      48FDFFFF 
 9404              	.LVL344:
 567:sepia_filter.c ****     {
 9405              		.loc 1 567 5 is_stmt 1 view .LVU2788
 9406              	.LBB77:
 567:sepia_filter.c ****     {
 9407              		.loc 1 567 10 view .LVU2789
 567:sepia_filter.c ****     {
 9408              		.loc 1 567 25 view .LVU2790
 9409 7574 49C1E606 		salq	$6, %r14
 9410              	.LBB76:
 9411              		.loc 1 569 35 is_stmt 0 view .LVU2791
 9412 7578 41BF0A00 		movl	$10, %r15d
 9412      0000
 9413              	.LVL345:
 9414              	.L240:
 9415              		.loc 1 569 27 is_stmt 1 view .LVU2792
 9416 757e 85DB     		testl	%ebx, %ebx
 9417 7580 0F8E6D09 		jle	.L244
 9417      0000
 9418              	.LBB70:
 570:sepia_filter.c ****         {
 571:sepia_filter.c ****             /* transformación AoS -> SoA */
 572:sepia_filter.c ****             pixels_in = &image_in->pixels[3*i];
 573:sepia_filter.c ****             pixels_out = &image_out->pixels[3*i];
 574:sepia_filter.c **** 
 575:sepia_filter.c ****             #pragma GCC ivdep
 576:sepia_filter.c ****             for (int j = 0; j < BLOCK; j++)
 577:sepia_filter.c ****             {
 578:sepia_filter.c ****                 R_in[j] = pixels_in[3*j + 0];
 579:sepia_filter.c ****                 G_in[j] = pixels_in[3*j + 1]; 
 580:sepia_filter.c ****                 B_in[j] = pixels_in[3*j + 2];
 581:sepia_filter.c ****             }
 582:sepia_filter.c ****             /* conversión RGB -> sepia */
 583:sepia_filter.c ****             #pragma GCC ivdep
 584:sepia_filter.c ****             for (int j = 0; j < BLOCK; j++)
 585:sepia_filter.c ****             {
 586:sepia_filter.c ****             R_out[j] = (unsigned char) (fminf(MAXPIXV,
 9419              		.loc 1 586 24 is_stmt 0 view .LVU2793
 9420 7586 B8FFFF00 		movl	$65535, %eax
 9420      00
 9421 758b C5796EF8 		vmovd	%eax, %xmm15
 9422 758f B8FF0000 		movl	$255, %eax
 9422      00
 9423 7594 C5F96ED8 		vmovd	%eax, %xmm3
 9424 7598 C4E27D79 		vpbroadcastw	%xmm3, %ymm3
 9424      DB
 9425 759d C4627D18 		vbroadcastss	.LC106(%rip), %ymm12
 9425      25000000 
 9425      00
 9426 75a6 C4E27D18 		vbroadcastss	.LC4(%rip), %ymm7
 9426      3D000000 
 9426      00
 9427              	.LBE70:
 569:sepia_filter.c ****         {
 9428              		.loc 1 569 27 view .LVU2794
 9429 75af 31C9     		xorl	%ecx, %ecx
 9430              	.LBB71:
 9431              		.loc 1 586 24 view .LVU2795
 9432 75b1 C4427D58 		vpbroadcastd	%xmm15, %ymm15
 9432      FF
 9433 75b6 C5FD7F9D 		vmovdqa	%ymm3, -464(%rbp)
 9433      30FEFFFF 
 9434 75be E97A0200 		jmp	.L242
 9434      00
 9435              	.LVL346:
 9436              		.p2align 4,,10
 9437 75c3 0F1F4400 		.p2align 3
 9437      00
 9438              	.L251:
 9439              		.loc 1 586 24 view .LVU2796
 9440              	.LBE71:
 9441              	.LBB72:
 587:sepia_filter.c ****                           0.5f +
 588:sepia_filter.c ****                           sepia[0][0]*R_in[j] + 
 589:sepia_filter.c ****                           sepia[0][1]*G_in[j] + 
 590:sepia_filter.c ****                           sepia[0][2]*B_in[j]));
 591:sepia_filter.c ****             G_out[j] = (unsigned char) (fminf(MAXPIXV,
 592:sepia_filter.c ****                           0.5f +
 593:sepia_filter.c ****                           sepia[1][0]*R_in[j] + 
 594:sepia_filter.c ****                           sepia[1][1]*G_in[j] + 
 595:sepia_filter.c ****                           sepia[1][2]*B_in[j]));
 596:sepia_filter.c ****             B_out[j] = (unsigned char) (fminf(MAXPIXV,
 597:sepia_filter.c ****                           0.5f +
 598:sepia_filter.c ****                           sepia[2][0]*R_in[j] + 
 599:sepia_filter.c ****                           sepia[2][1]*G_in[j] + 
 600:sepia_filter.c ****                           sepia[2][2]*B_in[j]));
 601:sepia_filter.c ****             }
 602:sepia_filter.c ****             /* transformación SoA -> AoS */
 603:sepia_filter.c ****             #pragma GCC ivdep
 604:sepia_filter.c ****             for (int j = 0; j < BLOCK; j++)
 605:sepia_filter.c ****             {
 606:sepia_filter.c ****                 pixels_out[3*j + 0] = R_out[j];
 9442              		.loc 1 606 44 view .LVU2797
 9443 75c8 C5FD6F8D 		vmovdqa	-240(%rbp), %ymm1
 9443      10FFFFFF 
 607:sepia_filter.c ****                 pixels_out[3*j + 1] = G_out[j]; 
 9444              		.loc 1 607 44 view .LVU2798
 9445 75d0 C5FD6F85 		vmovdqa	-176(%rbp), %ymm0
 9445      50FFFFFF 
 608:sepia_filter.c ****                 pixels_out[3*j + 2] = B_out[j];
 9446              		.loc 1 608 44 view .LVU2799
 9447 75d8 C5FD6F55 		vmovdqa	-112(%rbp), %ymm2
 9447      90
 9448              		.loc 1 608 37 view .LVU2800
 9449 75dd C4E27500 		vpshufb	.LC46(%rip), %ymm1, %ymm6
 9449      35000000 
 9449      00
 9450 75e6 C4E27D00 		vpshufb	.LC47(%rip), %ymm0, %ymm5
 9450      2D000000 
 9450      00
 9451 75ef C4E27500 		vpshufb	.LC48(%rip), %ymm1, %ymm3
 9451      1D000000 
 9451      00
 9452 75f8 C4E27D00 		vpshufb	.LC49(%rip), %ymm0, %ymm4
 9452      25000000 
 9452      00
 9453 7601 C4E3FD00 		vpermq	$78, %ymm6, %ymm6
 9453      F64E
 9454 7607 C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 9454      ED4E
 9455 760d C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 9456 7611 C5E5EBDE 		vpor	%ymm6, %ymm3, %ymm3
 9457 7615 C4E26D00 		vpshufb	.LC50(%rip), %ymm2, %ymm5
 9457      2D000000 
 9457      00
 9458 761e C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 9459 7622 C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 9459      ED4E
 9460 7628 C4E26D00 		vpshufb	.LC52(%rip), %ymm2, %ymm4
 9460      25000000 
 9460      00
 9461 7631 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 9462 7635 C4E26500 		vpshufb	.LC51(%rip), %ymm3, %ymm3
 9462      1D000000 
 9462      00
 9463 763e 488D040A 		leaq	(%rdx,%rcx), %rax
 606:sepia_filter.c ****                 pixels_out[3*j + 1] = G_out[j]; 
 9464              		.loc 1 606 17 is_stmt 1 view .LVU2801
 607:sepia_filter.c ****                 pixels_out[3*j + 1] = G_out[j]; 
 9465              		.loc 1 607 17 view .LVU2802
 9466              		.loc 1 608 17 view .LVU2803
 9467              		.loc 1 608 37 is_stmt 0 view .LVU2804
 9468 7642 C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 9469 7646 C4E27500 		vpshufb	.LC53(%rip), %ymm1, %ymm4
 9469      25000000 
 9469      00
 9470 764f C5FE7F18 		vmovdqu	%ymm3, (%rax)
 9471              	.LVL347:
 9472              		.loc 1 608 37 view .LVU2805
 9473 7653 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 9473      E44E
 9474 7659 C4E27500 		vpshufb	.LC54(%rip), %ymm1, %ymm3
 9474      1D000000 
 9474      00
 9475 7662 C4E27D00 		vpshufb	.LC55(%rip), %ymm0, %ymm5
 9475      2D000000 
 9475      00
 9476 766b C5FD6F35 		vmovdqa	.LC57(%rip), %ymm6
 9476      00000000 
 9477 7673 C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 9478 7677 C5E5EBDD 		vpor	%ymm5, %ymm3, %ymm3
 9479 767b C4E26D00 		vpshufb	.LC56(%rip), %ymm2, %ymm4
 9479      25000000 
 9479      00
 9480 7684 C4E35D4C 		vpblendvb	%ymm6, %ymm3, %ymm4, %ymm3
 9480      DB60
 9481 768a C5FE7F58 		vmovdqu	%ymm3, 32(%rax)
 9481      20
 9482 768f C4E27D00 		vpshufb	.LC58(%rip), %ymm0, %ymm4
 9482      25000000 
 9482      00
 9483 7698 C4E27500 		vpshufb	.LC59(%rip), %ymm1, %ymm3
 9483      1D000000 
 9483      00
 9484 76a1 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 9484      E44E
 9485 76a7 C4E3FD00 		vpermq	$78, %ymm3, %ymm3
 9485      DB4E
 9486 76ad C4E27D00 		vpshufb	.LC60(%rip), %ymm0, %ymm0
 9486      05000000 
 9486      00
 9487 76b6 C4E27500 		vpshufb	.LC61(%rip), %ymm1, %ymm1
 9487      0D000000 
 9487      00
 9488 76bf C5F5EBCB 		vpor	%ymm3, %ymm1, %ymm1
 9489 76c3 C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 9490 76c7 C4E26D00 		vpshufb	.LC62(%rip), %ymm2, %ymm3
 9490      1D000000 
 9490      00
 9491 76d0 C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 9492 76d4 C4E3FD00 		vpermq	$78, %ymm3, %ymm3
 9492      DB4E
 9493 76da C4E26D00 		vpshufb	.LC64(%rip), %ymm2, %ymm1
 9493      0D000000 
 9493      00
 9494 76e3 C5F5EBCB 		vpor	%ymm3, %ymm1, %ymm1
 9495 76e7 C4E27D00 		vpshufb	.LC63(%rip), %ymm0, %ymm0
 9495      05000000 
 9495      00
 9496 76f0 C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 9497 76f4 C5FE7F40 		vmovdqu	%ymm0, 64(%rax)
 9497      40
 604:sepia_filter.c ****             {
 9498              		.loc 1 604 41 is_stmt 1 view .LVU2806
 604:sepia_filter.c ****             {
 9499              		.loc 1 604 13 view .LVU2807
 606:sepia_filter.c ****                 pixels_out[3*j + 1] = G_out[j]; 
 9500              		.loc 1 606 17 view .LVU2808
 606:sepia_filter.c ****                 pixels_out[3*j + 1] = G_out[j]; 
 9501              		.loc 1 606 44 is_stmt 0 view .LVU2809
 9502 76f9 C5FD6F8D 		vmovdqa	-208(%rbp), %ymm1
 9502      30FFFFFF 
 607:sepia_filter.c ****                 pixels_out[3*j + 2] = B_out[j];
 9503              		.loc 1 607 17 is_stmt 1 view .LVU2810
 607:sepia_filter.c ****                 pixels_out[3*j + 2] = B_out[j];
 9504              		.loc 1 607 44 is_stmt 0 view .LVU2811
 9505 7701 C5FD6F85 		vmovdqa	-144(%rbp), %ymm0
 9505      70FFFFFF 
 9506              		.loc 1 608 17 is_stmt 1 view .LVU2812
 9507              		.loc 1 608 44 is_stmt 0 view .LVU2813
 9508 7709 C5FD6F55 		vmovdqa	-80(%rbp), %ymm2
 9508      B0
 9509              		.loc 1 608 37 view .LVU2814
 9510 770e C4E27500 		vpshufb	.LC46(%rip), %ymm1, %ymm6
 9510      35000000 
 9510      00
 9511 7717 C4E27D00 		vpshufb	.LC47(%rip), %ymm0, %ymm5
 9511      2D000000 
 9511      00
 9512 7720 C4E27500 		vpshufb	.LC48(%rip), %ymm1, %ymm3
 9512      1D000000 
 9512      00
 9513 7729 C4E27D00 		vpshufb	.LC49(%rip), %ymm0, %ymm4
 9513      25000000 
 9513      00
 9514 7732 C4E3FD00 		vpermq	$78, %ymm6, %ymm6
 9514      F64E
 9515 7738 C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 9515      ED4E
 9516 773e C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 9517 7742 C5E5EBDE 		vpor	%ymm6, %ymm3, %ymm3
 9518 7746 C4E26D00 		vpshufb	.LC50(%rip), %ymm2, %ymm5
 9518      2D000000 
 9518      00
 9519 774f C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 9520 7753 C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 9520      ED4E
 9521 7759 C4E26D00 		vpshufb	.LC52(%rip), %ymm2, %ymm4
 9521      25000000 
 9521      00
 9522 7762 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 9523 7766 C4E26500 		vpshufb	.LC51(%rip), %ymm3, %ymm3
 9523      1D000000 
 9523      00
 9524 776f C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 9525 7773 C4E27500 		vpshufb	.LC53(%rip), %ymm1, %ymm4
 9525      25000000 
 9525      00
 9526 777c C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 9526      E44E
 9527 7782 C5FE7F58 		vmovdqu	%ymm3, 96(%rax)
 9527      60
 9528 7787 C4E27500 		vpshufb	.LC54(%rip), %ymm1, %ymm3
 9528      1D000000 
 9528      00
 9529 7790 C4E27D00 		vpshufb	.LC55(%rip), %ymm0, %ymm5
 9529      2D000000 
 9529      00
 9530 7799 C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 9531 779d C5FD6F35 		vmovdqa	.LC57(%rip), %ymm6
 9531      00000000 
 9532 77a5 C4E26D00 		vpshufb	.LC56(%rip), %ymm2, %ymm4
 9532      25000000 
 9532      00
 9533 77ae C5E5EBDD 		vpor	%ymm5, %ymm3, %ymm3
 9534 77b2 C4E35D4C 		vpblendvb	%ymm6, %ymm3, %ymm4, %ymm3
 9534      DB60
 9535 77b8 C5FE7F98 		vmovdqu	%ymm3, 128(%rax)
 9535      80000000 
 9536 77c0 C4E27D00 		vpshufb	.LC58(%rip), %ymm0, %ymm4
 9536      25000000 
 9536      00
 9537 77c9 C4E27500 		vpshufb	.LC59(%rip), %ymm1, %ymm3
 9537      1D000000 
 9537      00
 9538 77d2 C4E3FD00 		vpermq	$78, %ymm3, %ymm3
 9538      DB4E
 9539 77d8 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 9539      E44E
 9540 77de C4E27D00 		vpshufb	.LC60(%rip), %ymm0, %ymm0
 9540      05000000 
 9540      00
 9541 77e7 C4E27500 		vpshufb	.LC61(%rip), %ymm1, %ymm1
 9541      0D000000 
 9541      00
 9542 77f0 C5F5EBCB 		vpor	%ymm3, %ymm1, %ymm1
 9543 77f4 C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 9544 77f8 C4E26D00 		vpshufb	.LC62(%rip), %ymm2, %ymm3
 9544      1D000000 
 9544      00
 9545 7801 C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 9546 7805 C4E3FD00 		vpermq	$78, %ymm3, %ymm3
 9546      DB4E
 9547 780b C4E26D00 		vpshufb	.LC64(%rip), %ymm2, %ymm1
 9547      0D000000 
 9547      00
 9548 7814 C4E27D00 		vpshufb	.LC63(%rip), %ymm0, %ymm0
 9548      05000000 
 9548      00
 9549 781d C5F5EBCB 		vpor	%ymm3, %ymm1, %ymm1
 9550 7821 C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 9551              	.LBE72:
 569:sepia_filter.c ****         {
 9552              		.loc 1 569 27 view .LVU2815
 9553 7825 4881C1C0 		addq	$192, %rcx
 9553      000000
 9554              	.LVL348:
 9555              	.LBB73:
 9556              		.loc 1 608 37 view .LVU2816
 9557 782c C5FE7F80 		vmovdqu	%ymm0, 160(%rax)
 9557      A0000000 
 604:sepia_filter.c ****             {
 9558              		.loc 1 604 41 is_stmt 1 view .LVU2817
 604:sepia_filter.c ****             {
 9559              		.loc 1 604 13 view .LVU2818
 9560              	.LBE73:
 569:sepia_filter.c ****         {
 9561              		.loc 1 569 44 view .LVU2819
 9562              	.LVL349:
 569:sepia_filter.c ****         {
 9563              		.loc 1 569 27 view .LVU2820
 9564 7834 4C39F1   		cmpq	%r14, %rcx
 9565 7837 0F84B306 		je	.L250
 9565      0000
 9566              	.LVL350:
 9567              	.L242:
 572:sepia_filter.c ****             pixels_out = &image_out->pixels[3*i];
 9568              		.loc 1 572 13 view .LVU2821
 573:sepia_filter.c **** 
 9569              		.loc 1 573 13 view .LVU2822
 9570 783d 498B4500 		movq	0(%r13), %rax
 573:sepia_filter.c **** 
 9571              		.loc 1 573 36 is_stmt 0 view .LVU2823
 9572 7841 498B1424 		movq	(%r12), %rdx
 9573              	.LVL351:
 9574              	.LBB74:
 576:sepia_filter.c ****             {
 9575              		.loc 1 576 18 is_stmt 1 view .LVU2824
 576:sepia_filter.c ****             {
 9576              		.loc 1 576 13 view .LVU2825
 9577 7845 4801C8   		addq	%rcx, %rax
 9578              	.LVL352:
 578:sepia_filter.c ****                 G_in[j] = pixels_in[3*j + 1]; 
 9579              		.loc 1 578 17 view .LVU2826
 578:sepia_filter.c ****                 G_in[j] = pixels_in[3*j + 1]; 
 9580              		.loc 1 578 36 is_stmt 0 view .LVU2827
 9581 7848 C5FE6F00 		vmovdqu	(%rax), %ymm0
 9582 784c C5FE6F58 		vmovdqu	32(%rax), %ymm3
 9582      20
 9583 7851 C4E27D00 		vpshufb	.LC15(%rip), %ymm0, %ymm4
 9583      25000000 
 9583      00
 9584 785a C5FE6F48 		vmovdqu	64(%rax), %ymm1
 9584      40
 9585 785f C4E27D00 		vpshufb	.LC16(%rip), %ymm0, %ymm2
 9585      15000000 
 9585      00
 9586 7868 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 9586      E44E
 9587 786e C4E26500 		vpshufb	.LC17(%rip), %ymm3, %ymm5
 9587      2D000000 
 9587      00
 9588 7877 C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 9589 787b C5EDEBD5 		vpor	%ymm5, %ymm2, %ymm2
 9590 787f C4E27500 		vpshufb	.LC18(%rip), %ymm1, %ymm5
 9590      2D000000 
 9590      00
 9591 7888 C4E27500 		vpshufb	.LC20(%rip), %ymm1, %ymm4
 9591      25000000 
 9591      00
 9592 7891 C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 9592      ED4E
 9593 7897 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 9594 789b C4E26D00 		vpshufb	.LC19(%rip), %ymm2, %ymm2
 9594      15000000 
 9594      00
 9595 78a4 C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 9596 78a8 C4E27D00 		vpshufb	.LC21(%rip), %ymm0, %ymm4
 9596      25000000 
 9596      00
 578:sepia_filter.c ****                 G_in[j] = pixels_in[3*j + 1]; 
 9597              		.loc 1 578 25 view .LVU2828
 9598 78b1 C5FD7F95 		vmovdqa	%ymm2, -432(%rbp)
 9598      50FEFFFF 
 579:sepia_filter.c ****                 B_in[j] = pixels_in[3*j + 2];
 9599              		.loc 1 579 17 is_stmt 1 view .LVU2829
 578:sepia_filter.c ****                 G_in[j] = pixels_in[3*j + 1]; 
 9600              		.loc 1 578 36 is_stmt 0 view .LVU2830
 9601 78b9 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 9601      E44E
 9602 78bf C4E27D00 		vpshufb	.LC22(%rip), %ymm0, %ymm2
 9602      15000000 
 9602      00
 9603 78c8 C4E26500 		vpshufb	.LC23(%rip), %ymm3, %ymm5
 9603      2D000000 
 9603      00
 9604 78d1 C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 9605 78d5 C5EDEBD5 		vpor	%ymm5, %ymm2, %ymm2
 9606 78d9 C4E27500 		vpshufb	.LC24(%rip), %ymm1, %ymm5
 9606      2D000000 
 9606      00
 9607 78e2 C4E27500 		vpshufb	.LC26(%rip), %ymm1, %ymm4
 9607      25000000 
 9607      00
 9608 78eb C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 9608      ED4E
 9609 78f1 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 9610 78f5 C4E26D00 		vpshufb	.LC25(%rip), %ymm2, %ymm2
 9610      15000000 
 9610      00
 9611 78fe C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 579:sepia_filter.c ****                 B_in[j] = pixels_in[3*j + 2];
 9612              		.loc 1 579 25 view .LVU2831
 9613 7902 C5FD7F95 		vmovdqa	%ymm2, -368(%rbp)
 9613      90FEFFFF 
 580:sepia_filter.c ****             }
 9614              		.loc 1 580 17 is_stmt 1 view .LVU2832
 578:sepia_filter.c ****                 G_in[j] = pixels_in[3*j + 1]; 
 9615              		.loc 1 578 36 is_stmt 0 view .LVU2833
 9616 790a C4E27D00 		vpshufb	.LC27(%rip), %ymm0, %ymm2
 9616      15000000 
 9616      00
 9617 7913 C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 9617      D24E
 9618 7919 C4E27D00 		vpshufb	.LC28(%rip), %ymm0, %ymm0
 9618      05000000 
 9618      00
 9619 7922 C4E26500 		vpshufb	.LC29(%rip), %ymm3, %ymm3
 9619      1D000000 
 9619      00
 9620 792b C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 9621 792f C4E27500 		vpshufb	.LC30(%rip), %ymm1, %ymm2
 9621      15000000 
 9621      00
 9622 7938 C5FDEBC3 		vpor	%ymm3, %ymm0, %ymm0
 9623 793c C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 9623      D24E
 9624 7942 C4E27500 		vpshufb	.LC31(%rip), %ymm1, %ymm1
 9624      0D000000 
 9624      00
 9625 794b C5F5EBCA 		vpor	%ymm2, %ymm1, %ymm1
 9626 794f C4E27D00 		vpshufb	.LC25(%rip), %ymm0, %ymm0
 9626      05000000 
 9626      00
 9627 7958 C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 580:sepia_filter.c ****             }
 9628              		.loc 1 580 25 view .LVU2834
 9629 795c C5FD7F85 		vmovdqa	%ymm0, -304(%rbp)
 9629      D0FEFFFF 
 576:sepia_filter.c ****             {
 9630              		.loc 1 576 41 is_stmt 1 view .LVU2835
 576:sepia_filter.c ****             {
 9631              		.loc 1 576 13 view .LVU2836
 578:sepia_filter.c ****                 G_in[j] = pixels_in[3*j + 1]; 
 9632              		.loc 1 578 17 view .LVU2837
 578:sepia_filter.c ****                 G_in[j] = pixels_in[3*j + 1]; 
 9633              		.loc 1 578 36 is_stmt 0 view .LVU2838
 9634 7964 C5FE6F40 		vmovdqu	96(%rax), %ymm0
 9634      60
 9635 7969 C5FE6F98 		vmovdqu	128(%rax), %ymm3
 9635      80000000 
 9636 7971 C4E27D00 		vpshufb	.LC15(%rip), %ymm0, %ymm4
 9636      25000000 
 9636      00
 9637 797a C5FE6F88 		vmovdqu	160(%rax), %ymm1
 9637      A0000000 
 9638 7982 C4E27D00 		vpshufb	.LC16(%rip), %ymm0, %ymm2
 9638      15000000 
 9638      00
 9639 798b C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 9639      E44E
 9640 7991 C4E26500 		vpshufb	.LC17(%rip), %ymm3, %ymm5
 9640      2D000000 
 9640      00
 9641 799a C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 9642 799e C5EDEBD5 		vpor	%ymm5, %ymm2, %ymm2
 9643 79a2 C4E27500 		vpshufb	.LC18(%rip), %ymm1, %ymm5
 9643      2D000000 
 9643      00
 9644 79ab C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 9644      ED4E
 9645 79b1 C4E27500 		vpshufb	.LC20(%rip), %ymm1, %ymm4
 9645      25000000 
 9645      00
 9646 79ba C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 9647 79be C4E26D00 		vpshufb	.LC19(%rip), %ymm2, %ymm2
 9647      15000000 
 9647      00
 9648 79c7 C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 9649 79cb C4E27D00 		vpshufb	.LC21(%rip), %ymm0, %ymm4
 9649      25000000 
 9649      00
 9650 79d4 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 9650      E44E
 578:sepia_filter.c ****                 G_in[j] = pixels_in[3*j + 1]; 
 9651              		.loc 1 578 25 view .LVU2839
 9652 79da C5FD7F95 		vmovdqa	%ymm2, -400(%rbp)
 9652      70FEFFFF 
 579:sepia_filter.c ****                 B_in[j] = pixels_in[3*j + 2];
 9653              		.loc 1 579 17 is_stmt 1 view .LVU2840
 578:sepia_filter.c ****                 G_in[j] = pixels_in[3*j + 1]; 
 9654              		.loc 1 578 36 is_stmt 0 view .LVU2841
 9655 79e2 C4E27D00 		vpshufb	.LC22(%rip), %ymm0, %ymm2
 9655      15000000 
 9655      00
 9656 79eb C4E26500 		vpshufb	.LC23(%rip), %ymm3, %ymm5
 9656      2D000000 
 9656      00
 9657 79f4 C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 9658 79f8 C5EDEBD5 		vpor	%ymm5, %ymm2, %ymm2
 9659 79fc C4E27500 		vpshufb	.LC24(%rip), %ymm1, %ymm5
 9659      2D000000 
 9659      00
 9660 7a05 C4E27500 		vpshufb	.LC26(%rip), %ymm1, %ymm4
 9660      25000000 
 9660      00
 9661 7a0e C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 9661      ED4E
 9662 7a14 C4E26D00 		vpshufb	.LC25(%rip), %ymm2, %ymm2
 9662      15000000 
 9662      00
 9663 7a1d C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 9664 7a21 C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 579:sepia_filter.c ****                 B_in[j] = pixels_in[3*j + 2];
 9665              		.loc 1 579 25 view .LVU2842
 9666 7a25 C5FD7F95 		vmovdqa	%ymm2, -336(%rbp)
 9666      B0FEFFFF 
 580:sepia_filter.c ****             }
 9667              		.loc 1 580 17 is_stmt 1 view .LVU2843
 578:sepia_filter.c ****                 G_in[j] = pixels_in[3*j + 1]; 
 9668              		.loc 1 578 36 is_stmt 0 view .LVU2844
 9669 7a2d C4E27D00 		vpshufb	.LC27(%rip), %ymm0, %ymm2
 9669      15000000 
 9669      00
 9670 7a36 C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 9670      D24E
 9671 7a3c C4E27D00 		vpshufb	.LC28(%rip), %ymm0, %ymm0
 9671      05000000 
 9671      00
 9672 7a45 C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 9673 7a49 C4E26500 		vpshufb	.LC29(%rip), %ymm3, %ymm3
 9673      1D000000 
 9673      00
 9674 7a52 C4E27500 		vpshufb	.LC30(%rip), %ymm1, %ymm2
 9674      15000000 
 9674      00
 9675 7a5b C5FDEBC3 		vpor	%ymm3, %ymm0, %ymm0
 9676 7a5f C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 9676      D24E
 9677 7a65 C4E27500 		vpshufb	.LC31(%rip), %ymm1, %ymm1
 9677      0D000000 
 9677      00
 9678 7a6e C4E27D00 		vpshufb	.LC25(%rip), %ymm0, %ymm0
 9678      05000000 
 9678      00
 9679 7a77 C5F5EBCA 		vpor	%ymm2, %ymm1, %ymm1
 9680 7a7b C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 580:sepia_filter.c ****             }
 9681              		.loc 1 580 25 view .LVU2845
 9682 7a7f C5FD7F85 		vmovdqa	%ymm0, -272(%rbp)
 9682      F0FEFFFF 
 576:sepia_filter.c ****             {
 9683              		.loc 1 576 41 is_stmt 1 view .LVU2846
 576:sepia_filter.c ****             {
 9684              		.loc 1 576 13 view .LVU2847
 580:sepia_filter.c ****             }
 9685              		.loc 1 580 25 is_stmt 0 view .LVU2848
 9686 7a87 31C0     		xorl	%eax, %eax
 9687              	.L241:
 9688              	.LBE74:
 9689              	.LBB75:
 586:sepia_filter.c ****                           0.5f +
 9690              		.loc 1 586 13 is_stmt 1 discriminator 3 view .LVU2849
 588:sepia_filter.c ****                           sepia[0][1]*G_in[j] + 
 9691              		.loc 1 588 43 is_stmt 0 discriminator 3 view .LVU2850
 9692 7a89 C5FD6F84 		vmovdqa	-432(%rbp,%rax), %ymm0
 9692      0550FEFF 
 9692      FF
 9693 7a92 C4E27D30 		vpmovzxbw	%xmm0, %ymm1
 9693      C8
 9694 7a97 C4E27D33 		vpmovzxwd	%xmm1, %ymm2
 9694      D1
 9695 7a9c C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 9695      C001
 9696 7aa2 C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 9696      C901
 9697 7aa8 C4E27D30 		vpmovzxbw	%xmm0, %ymm0
 9697      C0
 9698 7aad C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 9698      C9
 588:sepia_filter.c ****                           sepia[0][1]*G_in[j] + 
 9699              		.loc 1 588 38 discriminator 3 view .LVU2851
 9700 7ab2 C5FC5BE1 		vcvtdq2ps	%ymm1, %ymm4
 588:sepia_filter.c ****                           sepia[0][1]*G_in[j] + 
 9701              		.loc 1 588 43 discriminator 3 view .LVU2852
 9702 7ab6 C4E27D33 		vpmovzxwd	%xmm0, %ymm1
 9702      C8
 588:sepia_filter.c ****                           sepia[0][1]*G_in[j] + 
 9703              		.loc 1 588 38 discriminator 3 view .LVU2853
 9704 7abb C57C5BE9 		vcvtdq2ps	%ymm1, %ymm13
 589:sepia_filter.c ****                           sepia[0][2]*B_in[j]));
 9705              		.loc 1 589 43 discriminator 3 view .LVU2854
 9706 7abf C5FD6F8C 		vmovdqa	-368(%rbp,%rax), %ymm1
 9706      0590FEFF 
 9706      FF
 588:sepia_filter.c ****                           sepia[0][1]*G_in[j] + 
 9707              		.loc 1 588 43 discriminator 3 view .LVU2855
 9708 7ac8 C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 9708      C001
 588:sepia_filter.c ****                           sepia[0][1]*G_in[j] + 
 9709              		.loc 1 588 38 discriminator 3 view .LVU2856
 9710 7ace C5FC5BDA 		vcvtdq2ps	%ymm2, %ymm3
 588:sepia_filter.c ****                           sepia[0][1]*G_in[j] + 
 9711              		.loc 1 588 43 discriminator 3 view .LVU2857
 9712 7ad2 C4E27D33 		vpmovzxwd	%xmm0, %ymm0
 9712      C0
 589:sepia_filter.c ****                           sepia[0][2]*B_in[j]));
 9713              		.loc 1 589 43 discriminator 3 view .LVU2858
 9714 7ad7 C4E27D30 		vpmovzxbw	%xmm1, %ymm2
 9714      D1
 588:sepia_filter.c ****                           sepia[0][1]*G_in[j] + 
 9715              		.loc 1 588 38 discriminator 3 view .LVU2859
 9716 7adc C57C5BF0 		vcvtdq2ps	%ymm0, %ymm14
 589:sepia_filter.c ****                           sepia[0][2]*B_in[j]));
 9717              		.loc 1 589 43 discriminator 3 view .LVU2860
 9718 7ae0 C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 9718      C901
 9719 7ae6 C4E27D33 		vpmovzxwd	%xmm2, %ymm0
 9719      C2
 9720 7aeb C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 9720      D201
 9721 7af1 C4E27D30 		vpmovzxbw	%xmm1, %ymm1
 9721      C9
 9722 7af6 C4E27D33 		vpmovzxwd	%xmm2, %ymm2
 9722      D2
 589:sepia_filter.c ****                           sepia[0][2]*B_in[j]));
 9723              		.loc 1 589 38 discriminator 3 view .LVU2861
 9724 7afb C5FC5BC0 		vcvtdq2ps	%ymm0, %ymm0
 9725 7aff C5FC5BF2 		vcvtdq2ps	%ymm2, %ymm6
 9726 7b03 C57C591D 		vmulps	.LC32(%rip), %ymm0, %ymm11
 9726      00000000 
 589:sepia_filter.c ****                           sepia[0][2]*B_in[j]));
 9727              		.loc 1 589 43 discriminator 3 view .LVU2862
 9728 7b0b C4E27D33 		vpmovzxwd	%xmm1, %ymm2
 9728      D1
 9729 7b10 C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 9729      C901
 589:sepia_filter.c ****                           sepia[0][2]*B_in[j]));
 9730              		.loc 1 589 38 discriminator 3 view .LVU2863
 9731 7b16 C5FC5BD2 		vcvtdq2ps	%ymm2, %ymm2
 589:sepia_filter.c ****                           sepia[0][2]*B_in[j]));
 9732              		.loc 1 589 43 discriminator 3 view .LVU2864
 9733 7b1a C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 9733      C9
 589:sepia_filter.c ****                           sepia[0][2]*B_in[j]));
 9734              		.loc 1 589 38 discriminator 3 view .LVU2865
 9735 7b1f C56C5915 		vmulps	.LC32(%rip), %ymm2, %ymm10
 9735      00000000 
 9736 7b27 C5FC2995 		vmovaps	%ymm2, -528(%rbp)
 9736      F0FDFFFF 
 590:sepia_filter.c ****             G_out[j] = (unsigned char) (fminf(MAXPIXV,
 9737              		.loc 1 590 43 discriminator 3 view .LVU2866
 9738 7b2f C5FD6F94 		vmovdqa	-304(%rbp,%rax), %ymm2
 9738      05D0FEFF 
 9738      FF
 589:sepia_filter.c ****                           sepia[0][2]*B_in[j]));
 9739              		.loc 1 589 38 discriminator 3 view .LVU2867
 9740 7b38 C5FC29B5 		vmovaps	%ymm6, -560(%rbp)
 9740      D0FDFFFF 
 9741 7b40 C5FC5BC9 		vcvtdq2ps	%ymm1, %ymm1
 9742 7b44 C5CC5935 		vmulps	.LC32(%rip), %ymm6, %ymm6
 9742      00000000 
 9743 7b4c C5F4592D 		vmulps	.LC32(%rip), %ymm1, %ymm5
 9743      00000000 
 9744 7b54 C5FC298D 		vmovaps	%ymm1, -496(%rbp)
 9744      10FEFFFF 
 590:sepia_filter.c ****             G_out[j] = (unsigned char) (fminf(MAXPIXV,
 9745              		.loc 1 590 43 discriminator 3 view .LVU2868
 9746 7b5c C4E27D30 		vpmovzxbw	%xmm2, %ymm1
 9746      CA
 9747 7b61 C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 9747      D201
 9748 7b67 C4E27D30 		vpmovzxbw	%xmm2, %ymm2
 9748      D2
 9749 7b6c C46265B8 		vfmadd231ps	.LC33(%rip), %ymm3, %ymm11
 9749      1D000000 
 9749      00
 9750 7b75 C5FC299D 		vmovaps	%ymm3, -688(%rbp)
 9750      50FDFFFF 
 9751 7b7d C4627D33 		vpmovzxwd	%xmm1, %ymm9
 9751      C9
 9752 7b82 C4E37D39 		vextracti128	$0x1, %ymm2, %xmm3
 9752      D301
 9753 7b88 C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 9753      C901
 9754 7b8e C4627D33 		vpmovzxwd	%xmm2, %ymm8
 9754      C2
 9755 7b93 C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 9755      C9
 9756 7b98 C4E27D33 		vpmovzxwd	%xmm3, %ymm3
 9756      DB
 9757 7b9d C46215B8 		vfmadd231ps	.LC33(%rip), %ymm13, %ymm10
 9757      15000000 
 9757      00
 9758 7ba6 C4E25DB8 		vfmadd231ps	.LC33(%rip), %ymm4, %ymm6
 9758      35000000 
 9758      00
 9759 7baf C4E20DB8 		vfmadd231ps	.LC33(%rip), %ymm14, %ymm5
 9759      2D000000 
 9759      00
 9760 7bb8 C5FC29A5 		vmovaps	%ymm4, -656(%rbp)
 9760      70FDFFFF 
 590:sepia_filter.c ****             G_out[j] = (unsigned char) (fminf(MAXPIXV,
 9761              		.loc 1 590 38 discriminator 3 view .LVU2869
 9762 7bc0 C4417C5B 		vcvtdq2ps	%ymm9, %ymm9
 9762      C9
 9763 7bc5 C5FC5BC9 		vcvtdq2ps	%ymm1, %ymm1
 9764 7bc9 C4417C5B 		vcvtdq2ps	%ymm8, %ymm8
 9764      C0
 9765 7bce C5FC5BDB 		vcvtdq2ps	%ymm3, %ymm3
 9766 7bd2 C57C29AD 		vmovaps	%ymm13, -624(%rbp)
 9766      90FDFFFF 
 9767 7bda C57C29B5 		vmovaps	%ymm14, -592(%rbp)
 9767      B0FDFFFF 
 9768 7be2 C57C29CA 		vmovaps	%ymm9, %ymm2
 9769 7be6 C57C28F1 		vmovaps	%ymm1, %ymm14
 9770 7bea C57C29C4 		vmovaps	%ymm8, %ymm4
 9771 7bee C57C28EB 		vmovaps	%ymm3, %ymm13
 9772 7bf2 C4621D98 		vfmadd132ps	.LC34(%rip), %ymm12, %ymm14
 9772      35000000 
 9772      00
 9773 7bfb C4621D98 		vfmadd132ps	.LC34(%rip), %ymm12, %ymm13
 9773      2D000000 
 9773      00
 9774 7c04 C4E21D98 		vfmadd132ps	.LC34(%rip), %ymm12, %ymm2
 9774      15000000 
 9774      00
 9775 7c0d C4E21D98 		vfmadd132ps	.LC34(%rip), %ymm12, %ymm4
 9775      25000000 
 9775      00
 586:sepia_filter.c ****                           0.5f +
 9776              		.loc 1 586 41 discriminator 3 view .LVU2870
 9777 7c16 C4C14C58 		vaddps	%ymm14, %ymm6, %ymm6
 9777      F6
 9778 7c1b C4C15458 		vaddps	%ymm13, %ymm5, %ymm5
 9778      ED
 9779 7c20 C4C16C58 		vaddps	%ymm11, %ymm2, %ymm2
 9779      D3
 9780 7c25 C4C15C58 		vaddps	%ymm10, %ymm4, %ymm4
 9780      E2
 9781 7c2a C5CC5DF7 		vminps	%ymm7, %ymm6, %ymm6
 9782 7c2e C5EC5DD7 		vminps	%ymm7, %ymm2, %ymm2
 9783 7c32 C5DC5DE7 		vminps	%ymm7, %ymm4, %ymm4
 9784 7c36 C5D45DEF 		vminps	%ymm7, %ymm5, %ymm5
 586:sepia_filter.c ****                           0.5f +
 9785              		.loc 1 586 24 discriminator 3 view .LVU2871
 9786 7c3a C5FE5BD2 		vcvttps2dq	%ymm2, %ymm2
 9787 7c3e C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 9788 7c42 C585DBD2 		vpand	%ymm2, %ymm15, %ymm2
 9789 7c46 C585DBF6 		vpand	%ymm6, %ymm15, %ymm6
 9790 7c4a C5FE5BE4 		vcvttps2dq	%ymm4, %ymm4
 9791 7c4e C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 9792 7c52 C585DBE4 		vpand	%ymm4, %ymm15, %ymm4
 9793 7c56 C585DBED 		vpand	%ymm5, %ymm15, %ymm5
 9794 7c5a C4E26D2B 		vpackusdw	%ymm6, %ymm2, %ymm2
 9794      D6
 9795 7c5f C4E25D2B 		vpackusdw	%ymm5, %ymm4, %ymm4
 9795      E5
 9796 7c64 C5FD6FB5 		vmovdqa	-464(%rbp), %ymm6
 9796      30FEFFFF 
 9797 7c6c C4E3FD00 		vpermq	$216, %ymm2, %ymm2
 9797      D2D8
 9798 7c72 C4E3FD00 		vpermq	$216, %ymm4, %ymm4
 9798      E4D8
 9799 7c78 C5DDDBE6 		vpand	%ymm6, %ymm4, %ymm4
 9800 7c7c C5EDDBD6 		vpand	%ymm6, %ymm2, %ymm2
 594:sepia_filter.c ****                           sepia[1][2]*B_in[j]));
 9801              		.loc 1 594 38 discriminator 3 view .LVU2872
 9802 7c80 C57C2895 		vmovaps	-560(%rbp), %ymm10
 9802      D0FDFFFF 
 586:sepia_filter.c ****                           0.5f +
 9803              		.loc 1 586 24 discriminator 3 view .LVU2873
 9804 7c88 C5ED67D4 		vpackuswb	%ymm4, %ymm2, %ymm2
 9805 7c8c C4E3FD00 		vpermq	$216, %ymm2, %ymm2
 9805      D2D8
 594:sepia_filter.c ****                           sepia[1][2]*B_in[j]));
 9806              		.loc 1 594 38 discriminator 3 view .LVU2874
 9807 7c92 C5AC5935 		vmulps	.LC40(%rip), %ymm10, %ymm6
 9807      00000000 
 586:sepia_filter.c ****                           0.5f +
 9808              		.loc 1 586 22 discriminator 3 view .LVU2875
 9809 7c9a C5FD7F94 		vmovdqa	%ymm2, -240(%rbp,%rax)
 9809      0510FFFF 
 9809      FF
 591:sepia_filter.c ****                           0.5f +
 9810              		.loc 1 591 13 is_stmt 1 discriminator 3 view .LVU2876
 594:sepia_filter.c ****                           sepia[1][2]*B_in[j]));
 9811              		.loc 1 594 38 is_stmt 0 discriminator 3 view .LVU2877
 9812 7ca3 C5FC5915 		vmulps	.LC40(%rip), %ymm0, %ymm2
 9812      00000000 
 9813 7cab C5FC28AD 		vmovaps	-688(%rbp), %ymm5
 9813      50FDFFFF 
 9814 7cb3 C5FC28A5 		vmovaps	-656(%rbp), %ymm4
 9814      70FDFFFF 
 9815 7cbb C57C289D 		vmovaps	-528(%rbp), %ymm11
 9815      F0FDFFFF 
 9816 7cc3 C4E25DB8 		vfmadd231ps	.LC41(%rip), %ymm4, %ymm6
 9816      35000000 
 9816      00
 9817 7ccc C4E255B8 		vfmadd231ps	.LC41(%rip), %ymm5, %ymm2
 9817      15000000 
 9817      00
 9818 7cd5 C5A45925 		vmulps	.LC40(%rip), %ymm11, %ymm4
 9818      00000000 
 9819 7cdd C57C2895 		vmovaps	-496(%rbp), %ymm10
 9819      10FEFFFF 
 9820 7ce5 C4417C28 		vmovaps	%ymm9, %ymm11
 9820      D9
 9821 7cea C5AC592D 		vmulps	.LC40(%rip), %ymm10, %ymm5
 9821      00000000 
 9822 7cf2 C4621D98 		vfmadd132ps	.LC42(%rip), %ymm12, %ymm11
 9822      1D000000 
 9822      00
 9823 7cfb C57C28B5 		vmovaps	-592(%rbp), %ymm14
 9823      B0FDFFFF 
 9824 7d03 C57C28AD 		vmovaps	-624(%rbp), %ymm13
 9824      90FDFFFF 
 9825 7d0b C57C28D3 		vmovaps	%ymm3, %ymm10
 9826 7d0f C4E20DB8 		vfmadd231ps	.LC41(%rip), %ymm14, %ymm5
 9826      2D000000 
 9826      00
 9827 7d18 C4417C28 		vmovaps	%ymm11, %ymm14
 9827      F3
 9828 7d1d C57C28D9 		vmovaps	%ymm1, %ymm11
 9829 7d21 C4621D98 		vfmadd132ps	.LC42(%rip), %ymm12, %ymm11
 9829      1D000000 
 9829      00
 9830 7d2a C4E215B8 		vfmadd231ps	.LC41(%rip), %ymm13, %ymm4
 9830      25000000 
 9830      00
 9831 7d33 C4621D98 		vfmadd132ps	.LC42(%rip), %ymm12, %ymm10
 9831      15000000 
 9831      00
 591:sepia_filter.c ****                           0.5f +
 9832              		.loc 1 591 41 discriminator 3 view .LVU2878
 9833 7d3c C4C16C58 		vaddps	%ymm14, %ymm2, %ymm2
 9833      D6
 599:sepia_filter.c ****                           sepia[2][2]*B_in[j]));
 9834              		.loc 1 599 38 discriminator 3 view .LVU2879
 9835 7d41 C5FC5905 		vmulps	.LC43(%rip), %ymm0, %ymm0
 9835      00000000 
 9836 7d49 C4417C28 		vmovaps	%ymm11, %ymm13
 9836      EB
 9837 7d4e C4417C28 		vmovaps	%ymm8, %ymm11
 9837      D8
 9838 7d53 C4621D98 		vfmadd132ps	.LC42(%rip), %ymm12, %ymm11
 9838      1D000000 
 9838      00
 591:sepia_filter.c ****                           0.5f +
 9839              		.loc 1 591 41 discriminator 3 view .LVU2880
 9840 7d5c C4C14C58 		vaddps	%ymm13, %ymm6, %ymm6
 9840      F5
 9841 7d61 C4C15458 		vaddps	%ymm10, %ymm5, %ymm5
 9841      EA
 9842 7d66 C5EC5DD7 		vminps	%ymm7, %ymm2, %ymm2
 9843 7d6a C5CC5DF7 		vminps	%ymm7, %ymm6, %ymm6
 9844 7d6e C4C15C58 		vaddps	%ymm11, %ymm4, %ymm4
 9844      E3
 9845 7d73 C5D45DEF 		vminps	%ymm7, %ymm5, %ymm5
 591:sepia_filter.c ****                           0.5f +
 9846              		.loc 1 591 24 discriminator 3 view .LVU2881
 9847 7d77 C5FE5BD2 		vcvttps2dq	%ymm2, %ymm2
 591:sepia_filter.c ****                           0.5f +
 9848              		.loc 1 591 41 discriminator 3 view .LVU2882
 9849 7d7b C5DC5DE7 		vminps	%ymm7, %ymm4, %ymm4
 591:sepia_filter.c ****                           0.5f +
 9850              		.loc 1 591 24 discriminator 3 view .LVU2883
 9851 7d7f C585DBD2 		vpand	%ymm2, %ymm15, %ymm2
 9852 7d83 C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 9853 7d87 C5FE5BE4 		vcvttps2dq	%ymm4, %ymm4
 9854 7d8b C585DBF6 		vpand	%ymm6, %ymm15, %ymm6
 9855 7d8f C585DBE4 		vpand	%ymm4, %ymm15, %ymm4
 9856 7d93 C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 9857 7d97 C585DBED 		vpand	%ymm5, %ymm15, %ymm5
 9858 7d9b C4E26D2B 		vpackusdw	%ymm6, %ymm2, %ymm2
 9858      D6
 9859 7da0 C4E25D2B 		vpackusdw	%ymm5, %ymm4, %ymm4
 9859      E5
 9860 7da5 C5FD6FB5 		vmovdqa	-464(%rbp), %ymm6
 9860      30FEFFFF 
 599:sepia_filter.c ****                           sepia[2][2]*B_in[j]));
 9861              		.loc 1 599 38 discriminator 3 view .LVU2884
 9862 7dad C57C2895 		vmovaps	-560(%rbp), %ymm10
 9862      D0FDFFFF 
 591:sepia_filter.c ****                           0.5f +
 9863              		.loc 1 591 24 discriminator 3 view .LVU2885
 9864 7db5 C4E3FD00 		vpermq	$216, %ymm2, %ymm2
 9864      D2D8
 9865 7dbb C4E3FD00 		vpermq	$216, %ymm4, %ymm4
 9865      E4D8
 9866 7dc1 C5DDDBE6 		vpand	%ymm6, %ymm4, %ymm4
 9867 7dc5 C5EDDBD6 		vpand	%ymm6, %ymm2, %ymm2
 9868 7dc9 C5ED67D4 		vpackuswb	%ymm4, %ymm2, %ymm2
 599:sepia_filter.c ****                           sepia[2][2]*B_in[j]));
 9869              		.loc 1 599 38 discriminator 3 view .LVU2886
 9870 7dcd C5AC5925 		vmulps	.LC43(%rip), %ymm10, %ymm4
 9870      00000000 
 9871 7dd5 C5FC28AD 		vmovaps	-688(%rbp), %ymm5
 9871      50FDFFFF 
 9872 7ddd C57C289D 		vmovaps	-528(%rbp), %ymm11
 9872      F0FDFFFF 
 9873 7de5 C4E255B8 		vfmadd231ps	.LC44(%rip), %ymm5, %ymm0
 9873      05000000 
 9873      00
 9874 7dee C57C2895 		vmovaps	-496(%rbp), %ymm10
 9874      10FEFFFF 
 9875 7df6 C5FC28AD 		vmovaps	-656(%rbp), %ymm5
 9875      70FDFFFF 
 591:sepia_filter.c ****                           0.5f +
 9876              		.loc 1 591 24 discriminator 3 view .LVU2887
 9877 7dfe C4E3FD00 		vpermq	$216, %ymm2, %ymm2
 9877      D2D8
 9878 7e04 C4E255B8 		vfmadd231ps	.LC44(%rip), %ymm5, %ymm4
 9878      25000000 
 9878      00
 591:sepia_filter.c ****                           0.5f +
 9879              		.loc 1 591 22 discriminator 3 view .LVU2888
 9880 7e0d C5FD7F94 		vmovdqa	%ymm2, -176(%rbp,%rax)
 9880      0550FFFF 
 9880      FF
 596:sepia_filter.c ****                           0.5f +
 9881              		.loc 1 596 13 is_stmt 1 discriminator 3 view .LVU2889
 599:sepia_filter.c ****                           sepia[2][2]*B_in[j]));
 9882              		.loc 1 599 38 is_stmt 0 discriminator 3 view .LVU2890
 9883 7e16 C5AC592D 		vmulps	.LC43(%rip), %ymm10, %ymm5
 9883      00000000 
 9884 7e1e C5A45915 		vmulps	.LC43(%rip), %ymm11, %ymm2
 9884      00000000 
 9885 7e26 C57C28AD 		vmovaps	-624(%rbp), %ymm13
 9885      90FDFFFF 
 9886 7e2e C57C28B5 		vmovaps	-592(%rbp), %ymm14
 9886      B0FDFFFF 
 9887 7e36 C4621D98 		vfmadd132ps	.LC45(%rip), %ymm12, %ymm9
 9887      0D000000 
 9887      00
 9888 7e3f C4E21D98 		vfmadd132ps	.LC45(%rip), %ymm12, %ymm1
 9888      0D000000 
 9888      00
 9889 7e48 C4E215B8 		vfmadd231ps	.LC44(%rip), %ymm13, %ymm2
 9889      15000000 
 9889      00
 9890 7e51 C4E20DB8 		vfmadd231ps	.LC44(%rip), %ymm14, %ymm5
 9890      2D000000 
 9890      00
 9891 7e5a C4621D98 		vfmadd132ps	.LC45(%rip), %ymm12, %ymm8
 9891      05000000 
 9891      00
 9892 7e63 C4E21D98 		vfmadd132ps	.LC45(%rip), %ymm12, %ymm3
 9892      1D000000 
 9892      00
 596:sepia_filter.c ****                           0.5f +
 9893              		.loc 1 596 41 discriminator 3 view .LVU2891
 9894 7e6c C4C17C58 		vaddps	%ymm9, %ymm0, %ymm0
 9894      C1
 9895 7e71 C5F458CC 		vaddps	%ymm4, %ymm1, %ymm1
 9896 7e75 C4C16C58 		vaddps	%ymm8, %ymm2, %ymm2
 9896      D0
 9897 7e7a C5D458EB 		vaddps	%ymm3, %ymm5, %ymm5
 9898 7e7e C5FC5DC7 		vminps	%ymm7, %ymm0, %ymm0
 9899 7e82 C5F45DCF 		vminps	%ymm7, %ymm1, %ymm1
 9900 7e86 C5EC5DD7 		vminps	%ymm7, %ymm2, %ymm2
 9901 7e8a C5D45DEF 		vminps	%ymm7, %ymm5, %ymm5
 596:sepia_filter.c ****                           0.5f +
 9902              		.loc 1 596 24 discriminator 3 view .LVU2892
 9903 7e8e C5FE5BC0 		vcvttps2dq	%ymm0, %ymm0
 9904 7e92 C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 9905 7e96 C585DBC0 		vpand	%ymm0, %ymm15, %ymm0
 9906 7e9a C585DBC9 		vpand	%ymm1, %ymm15, %ymm1
 9907 7e9e C4E27D2B 		vpackusdw	%ymm1, %ymm0, %ymm0
 9907      C1
 9908 7ea3 C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 9909 7ea7 C5FE5BCA 		vcvttps2dq	%ymm2, %ymm1
 9910 7eab C585DBED 		vpand	%ymm5, %ymm15, %ymm5
 9911 7eaf C585DBC9 		vpand	%ymm1, %ymm15, %ymm1
 9912 7eb3 C4E2752B 		vpackusdw	%ymm5, %ymm1, %ymm1
 9912      CD
 9913 7eb8 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 9913      C0D8
 9914 7ebe C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 9914      C9D8
 9915 7ec4 C5FDDBC6 		vpand	%ymm6, %ymm0, %ymm0
 9916 7ec8 C5F5DBCE 		vpand	%ymm6, %ymm1, %ymm1
 9917 7ecc C5FD67C1 		vpackuswb	%ymm1, %ymm0, %ymm0
 9918 7ed0 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 9918      C0D8
 596:sepia_filter.c ****                           0.5f +
 9919              		.loc 1 596 22 discriminator 3 view .LVU2893
 9920 7ed6 C5FD7F44 		vmovdqa	%ymm0, -112(%rbp,%rax)
 9920      0590
 584:sepia_filter.c ****             {
 9921              		.loc 1 584 41 is_stmt 1 discriminator 3 view .LVU2894
 584:sepia_filter.c ****             {
 9922              		.loc 1 584 13 discriminator 3 view .LVU2895
 9923 7edc 4883F820 		cmpq	$32, %rax
 9924 7ee0 0F84E2F6 		je	.L251
 9924      FFFF
 9925 7ee6 B8200000 		movl	$32, %eax
 9925      00
 9926 7eeb E999FBFF 		jmp	.L241
 9926      FF
 9927              	.LVL353:
 9928              	.L250:
 584:sepia_filter.c ****             {
 9929              		.loc 1 584 13 is_stmt 0 discriminator 3 view .LVU2896
 9930 7ef0 C5F877   		vzeroupper
 9931              	.LVL354:
 9932              	.L244:
 584:sepia_filter.c ****             {
 9933              		.loc 1 584 13 discriminator 3 view .LVU2897
 9934              	.LBE75:
 9935              	.LBE76:
 609:sepia_filter.c ****             }
 610:sepia_filter.c ****         }
 611:sepia_filter.c ****         dummy(image_in, image_out);
 9936              		.loc 1 611 9 is_stmt 1 view .LVU2898
 9937 7ef3 4C89E6   		movq	%r12, %rsi
 9938 7ef6 4C89EF   		movq	%r13, %rdi
 9939 7ef9 E8000000 		call	dummy
 9939      00
 9940              	.LVL355:
 567:sepia_filter.c ****     {
 9941              		.loc 1 567 36 view .LVU2899
 567:sepia_filter.c ****     {
 9942              		.loc 1 567 25 view .LVU2900
 9943 7efe 41FFCF   		decl	%r15d
 9944 7f01 0F8577F6 		jne	.L240
 9944      FFFF
 9945              	.LBE77:
 612:sepia_filter.c ****     }
 613:sepia_filter.c ****     end_t = get_wall_time();
 9946              		.loc 1 613 5 view .LVU2901
 9947              		.loc 1 613 13 is_stmt 0 view .LVU2902
 9948 7f07 31C0     		xorl	%eax, %eax
 9949 7f09 E8000000 		call	get_wall_time
 9949      00
 9950              	.LVL356:
 614:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_block");
 9951              		.loc 1 614 5 is_stmt 1 view .LVU2903
 9952 7f0e C5FB5C85 		vsubsd	-696(%rbp), %xmm0, %xmm0
 9952      48FDFFFF 
 9953              	.LVL357:
 615:sepia_filter.c **** }
 9954              		.loc 1 615 1 is_stmt 0 view .LVU2904
 9955 7f16 4881C4A8 		addq	$680, %rsp
 9955      020000
 614:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_block");
 9956              		.loc 1 614 5 view .LVU2905
 9957 7f1d 89DF     		movl	%ebx, %edi
 9958              		.loc 1 615 1 view .LVU2906
 9959 7f1f 5B       		popq	%rbx
 9960 7f20 415C     		popq	%r12
 9961              	.LVL358:
 9962              		.loc 1 615 1 view .LVU2907
 9963 7f22 415D     		popq	%r13
 9964              		.cfi_remember_state
 9965              		.cfi_def_cfa 13, 0
 9966              	.LVL359:
 9967              		.loc 1 615 1 view .LVU2908
 9968 7f24 415E     		popq	%r14
 9969 7f26 415F     		popq	%r15
 9970 7f28 5D       		popq	%rbp
 9971              	.LVL360:
 9972              		.loc 1 615 1 view .LVU2909
 9973 7f29 498D65F0 		leaq	-16(%r13), %rsp
 9974              		.cfi_def_cfa 7, 16
 614:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_block");
 9975              		.loc 1 614 5 view .LVU2910
 9976 7f2d BE000000 		movl	$.LC115, %esi
 9976      00
 9977              		.loc 1 615 1 view .LVU2911
 9978 7f32 415D     		popq	%r13
 9979              		.cfi_def_cfa_offset 8
 614:sepia_filter.c ****     results(end_t - start_t, height*width, "sepiaf_block");
 9980              		.loc 1 614 5 view .LVU2912
 9981 7f34 E9000000 		jmp	results
 9981      00
 9982              	.LVL361:
 9983              	.L249:
 9984              		.cfi_restore_state
 556:sepia_filter.c ****         exit(-1);
 9985              		.loc 1 556 9 is_stmt 1 view .LVU2913
 9986 7f39 BF000000 		movl	$.LC0, %edi
 9986      00
 9987              	.LVL362:
 556:sepia_filter.c ****         exit(-1);
 9988              		.loc 1 556 9 is_stmt 0 view .LVU2914
 9989 7f3e E8000000 		call	puts
 9989      00
 9990              	.LVL363:
 557:sepia_filter.c ****     }
 9991              		.loc 1 557 9 is_stmt 1 view .LVU2915
 9992 7f43 83CFFF   		orl	$-1, %edi
 9993 7f46 E8000000 		call	exit
 9993      00
 9994              	.LVL364:
 9995              		.cfi_endproc
 9996              	.LFE26:
 9998              		.set	.LC1,.LC32
 9999              		.set	.LC2,.LC33
 10000              		.set	.LC3,.LC34
 10001              		.set	.LC4,.LC35
 10002              		.section	.rodata.cst4,"aM",@progbits,4
 10003              		.align 4
 10004              	.LC5:
 10005 0000 FFFFFF3E 		.long	1056964607
 10006              		.section	.rodata.cst16,"aM",@progbits,16
 10007              		.align 16
 10008              	.LC6:
 10009 0000 00000080 		.long	-2147483648
 10010 0004 00000000 		.long	0
 10011 0008 00000000 		.long	0
 10012 000c 00000000 		.long	0
 10013              		.set	.LC7,.LC40
 10014              		.set	.LC8,.LC41
 10015              		.set	.LC9,.LC42
 10016              		.set	.LC10,.LC43
 10017              		.set	.LC11,.LC44
 10018              		.set	.LC12,.LC45
 10019              		.set	.LC14,.LC6
 10020              		.section	.rodata.cst32,"aM",@progbits,32
 10021              		.align 32
 10022              	.LC15:
 10023 0000 80       		.byte	-128
 10024 0001 80       		.byte	-128
 10025 0002 80       		.byte	-128
 10026 0003 80       		.byte	-128
 10027 0004 80       		.byte	-128
 10028 0005 80       		.byte	-128
 10029 0006 00       		.byte	0
 10030 0007 00       		.byte	0
 10031 0008 00       		.byte	0
 10032 0009 00       		.byte	0
 10033 000a 00       		.byte	0
 10034 000b 00       		.byte	0
 10035 000c 00       		.byte	0
 10036 000d 00       		.byte	0
 10037 000e 00       		.byte	0
 10038 000f 00       		.byte	0
 10039 0010 80       		.byte	-128
 10040 0011 80       		.byte	-128
 10041 0012 80       		.byte	-128
 10042 0013 80       		.byte	-128
 10043 0014 80       		.byte	-128
 10044 0015 80       		.byte	-128
 10045 0016 02       		.byte	2
 10046 0017 05       		.byte	5
 10047 0018 08       		.byte	8
 10048 0019 0B       		.byte	11
 10049 001a 0E       		.byte	14
 10050 001b 80       		.byte	-128
 10051 001c 80       		.byte	-128
 10052 001d 80       		.byte	-128
 10053 001e 80       		.byte	-128
 10054 001f 80       		.byte	-128
 10055              		.align 32
 10056              	.LC16:
 10057 0020 00       		.byte	0
 10058 0021 03       		.byte	3
 10059 0022 06       		.byte	6
 10060 0023 09       		.byte	9
 10061 0024 0C       		.byte	12
 10062 0025 0F       		.byte	15
 10063 0026 80       		.byte	-128
 10064 0027 80       		.byte	-128
 10065 0028 80       		.byte	-128
 10066 0029 80       		.byte	-128
 10067 002a 80       		.byte	-128
 10068 002b 80       		.byte	-128
 10069 002c 80       		.byte	-128
 10070 002d 80       		.byte	-128
 10071 002e 80       		.byte	-128
 10072 002f 80       		.byte	-128
 10073 0030 80       		.byte	-128
 10074 0031 80       		.byte	-128
 10075 0032 80       		.byte	-128
 10076 0033 80       		.byte	-128
 10077 0034 80       		.byte	-128
 10078 0035 80       		.byte	-128
 10079 0036 80       		.byte	-128
 10080 0037 80       		.byte	-128
 10081 0038 80       		.byte	-128
 10082 0039 80       		.byte	-128
 10083 003a 80       		.byte	-128
 10084 003b 80       		.byte	-128
 10085 003c 80       		.byte	-128
 10086 003d 80       		.byte	-128
 10087 003e 80       		.byte	-128
 10088 003f 80       		.byte	-128
 10089              		.align 32
 10090              	.LC17:
 10091 0040 80       		.byte	-128
 10092 0041 80       		.byte	-128
 10093 0042 80       		.byte	-128
 10094 0043 80       		.byte	-128
 10095 0044 80       		.byte	-128
 10096 0045 80       		.byte	-128
 10097 0046 80       		.byte	-128
 10098 0047 80       		.byte	-128
 10099 0048 80       		.byte	-128
 10100 0049 80       		.byte	-128
 10101 004a 80       		.byte	-128
 10102 004b 01       		.byte	1
 10103 004c 04       		.byte	4
 10104 004d 07       		.byte	7
 10105 004e 0A       		.byte	10
 10106 004f 0D       		.byte	13
 10107 0050 00       		.byte	0
 10108 0051 03       		.byte	3
 10109 0052 06       		.byte	6
 10110 0053 09       		.byte	9
 10111 0054 0C       		.byte	12
 10112 0055 0F       		.byte	15
 10113 0056 80       		.byte	-128
 10114 0057 80       		.byte	-128
 10115 0058 80       		.byte	-128
 10116 0059 80       		.byte	-128
 10117 005a 80       		.byte	-128
 10118 005b 80       		.byte	-128
 10119 005c 80       		.byte	-128
 10120 005d 80       		.byte	-128
 10121 005e 80       		.byte	-128
 10122 005f 80       		.byte	-128
 10123              		.align 32
 10124              	.LC18:
 10125 0060 80       		.byte	-128
 10126 0061 80       		.byte	-128
 10127 0062 80       		.byte	-128
 10128 0063 80       		.byte	-128
 10129 0064 80       		.byte	-128
 10130 0065 80       		.byte	-128
 10131 0066 02       		.byte	2
 10132 0067 05       		.byte	5
 10133 0068 08       		.byte	8
 10134 0069 0B       		.byte	11
 10135 006a 0E       		.byte	14
 10136 006b 80       		.byte	-128
 10137 006c 80       		.byte	-128
 10138 006d 80       		.byte	-128
 10139 006e 80       		.byte	-128
 10140 006f 80       		.byte	-128
 10141 0070 80       		.byte	-128
 10142 0071 80       		.byte	-128
 10143 0072 80       		.byte	-128
 10144 0073 80       		.byte	-128
 10145 0074 80       		.byte	-128
 10146 0075 80       		.byte	-128
 10147 0076 80       		.byte	-128
 10148 0077 80       		.byte	-128
 10149 0078 80       		.byte	-128
 10150 0079 80       		.byte	-128
 10151 007a 80       		.byte	-128
 10152 007b 80       		.byte	-128
 10153 007c 80       		.byte	-128
 10154 007d 80       		.byte	-128
 10155 007e 80       		.byte	-128
 10156 007f 80       		.byte	-128
 10157              		.align 32
 10158              	.LC19:
 10159 0080 00       		.byte	0
 10160 0081 01       		.byte	1
 10161 0082 02       		.byte	2
 10162 0083 03       		.byte	3
 10163 0084 04       		.byte	4
 10164 0085 05       		.byte	5
 10165 0086 06       		.byte	6
 10166 0087 07       		.byte	7
 10167 0088 08       		.byte	8
 10168 0089 09       		.byte	9
 10169 008a 0A       		.byte	10
 10170 008b 0B       		.byte	11
 10171 008c 0C       		.byte	12
 10172 008d 0D       		.byte	13
 10173 008e 0E       		.byte	14
 10174 008f 0F       		.byte	15
 10175 0090 00       		.byte	0
 10176 0091 01       		.byte	1
 10177 0092 02       		.byte	2
 10178 0093 03       		.byte	3
 10179 0094 04       		.byte	4
 10180 0095 05       		.byte	5
 10181 0096 80       		.byte	-128
 10182 0097 80       		.byte	-128
 10183 0098 80       		.byte	-128
 10184 0099 80       		.byte	-128
 10185 009a 80       		.byte	-128
 10186 009b 80       		.byte	-128
 10187 009c 80       		.byte	-128
 10188 009d 80       		.byte	-128
 10189 009e 80       		.byte	-128
 10190 009f 80       		.byte	-128
 10191              		.align 32
 10192              	.LC20:
 10193 00a0 80       		.byte	-128
 10194 00a1 80       		.byte	-128
 10195 00a2 80       		.byte	-128
 10196 00a3 80       		.byte	-128
 10197 00a4 80       		.byte	-128
 10198 00a5 80       		.byte	-128
 10199 00a6 80       		.byte	-128
 10200 00a7 80       		.byte	-128
 10201 00a8 80       		.byte	-128
 10202 00a9 80       		.byte	-128
 10203 00aa 80       		.byte	-128
 10204 00ab 80       		.byte	-128
 10205 00ac 80       		.byte	-128
 10206 00ad 80       		.byte	-128
 10207 00ae 80       		.byte	-128
 10208 00af 80       		.byte	-128
 10209 00b0 80       		.byte	-128
 10210 00b1 80       		.byte	-128
 10211 00b2 80       		.byte	-128
 10212 00b3 80       		.byte	-128
 10213 00b4 80       		.byte	-128
 10214 00b5 80       		.byte	-128
 10215 00b6 80       		.byte	-128
 10216 00b7 80       		.byte	-128
 10217 00b8 80       		.byte	-128
 10218 00b9 80       		.byte	-128
 10219 00ba 80       		.byte	-128
 10220 00bb 01       		.byte	1
 10221 00bc 04       		.byte	4
 10222 00bd 07       		.byte	7
 10223 00be 0A       		.byte	10
 10224 00bf 0D       		.byte	13
 10225              		.align 32
 10226              	.LC21:
 10227 00c0 80       		.byte	-128
 10228 00c1 80       		.byte	-128
 10229 00c2 80       		.byte	-128
 10230 00c3 80       		.byte	-128
 10231 00c4 80       		.byte	-128
 10232 00c5 00       		.byte	0
 10233 00c6 00       		.byte	0
 10234 00c7 00       		.byte	0
 10235 00c8 00       		.byte	0
 10236 00c9 00       		.byte	0
 10237 00ca 00       		.byte	0
 10238 00cb 00       		.byte	0
 10239 00cc 00       		.byte	0
 10240 00cd 00       		.byte	0
 10241 00ce 00       		.byte	0
 10242 00cf 00       		.byte	0
 10243 00d0 80       		.byte	-128
 10244 00d1 80       		.byte	-128
 10245 00d2 80       		.byte	-128
 10246 00d3 80       		.byte	-128
 10247 00d4 80       		.byte	-128
 10248 00d5 00       		.byte	0
 10249 00d6 03       		.byte	3
 10250 00d7 06       		.byte	6
 10251 00d8 09       		.byte	9
 10252 00d9 0C       		.byte	12
 10253 00da 0F       		.byte	15
 10254 00db 80       		.byte	-128
 10255 00dc 80       		.byte	-128
 10256 00dd 80       		.byte	-128
 10257 00de 80       		.byte	-128
 10258 00df 80       		.byte	-128
 10259              		.align 32
 10260              	.LC22:
 10261 00e0 01       		.byte	1
 10262 00e1 04       		.byte	4
 10263 00e2 07       		.byte	7
 10264 00e3 0A       		.byte	10
 10265 00e4 0D       		.byte	13
 10266 00e5 80       		.byte	-128
 10267 00e6 80       		.byte	-128
 10268 00e7 80       		.byte	-128
 10269 00e8 80       		.byte	-128
 10270 00e9 80       		.byte	-128
 10271 00ea 80       		.byte	-128
 10272 00eb 80       		.byte	-128
 10273 00ec 80       		.byte	-128
 10274 00ed 80       		.byte	-128
 10275 00ee 80       		.byte	-128
 10276 00ef 80       		.byte	-128
 10277 00f0 80       		.byte	-128
 10278 00f1 80       		.byte	-128
 10279 00f2 80       		.byte	-128
 10280 00f3 80       		.byte	-128
 10281 00f4 80       		.byte	-128
 10282 00f5 80       		.byte	-128
 10283 00f6 80       		.byte	-128
 10284 00f7 80       		.byte	-128
 10285 00f8 80       		.byte	-128
 10286 00f9 80       		.byte	-128
 10287 00fa 80       		.byte	-128
 10288 00fb 80       		.byte	-128
 10289 00fc 80       		.byte	-128
 10290 00fd 80       		.byte	-128
 10291 00fe 80       		.byte	-128
 10292 00ff 80       		.byte	-128
 10293              		.align 32
 10294              	.LC23:
 10295 0100 80       		.byte	-128
 10296 0101 80       		.byte	-128
 10297 0102 80       		.byte	-128
 10298 0103 80       		.byte	-128
 10299 0104 80       		.byte	-128
 10300 0105 80       		.byte	-128
 10301 0106 80       		.byte	-128
 10302 0107 80       		.byte	-128
 10303 0108 80       		.byte	-128
 10304 0109 80       		.byte	-128
 10305 010a 80       		.byte	-128
 10306 010b 02       		.byte	2
 10307 010c 05       		.byte	5
 10308 010d 08       		.byte	8
 10309 010e 0B       		.byte	11
 10310 010f 0E       		.byte	14
 10311 0110 01       		.byte	1
 10312 0111 04       		.byte	4
 10313 0112 07       		.byte	7
 10314 0113 0A       		.byte	10
 10315 0114 0D       		.byte	13
 10316 0115 80       		.byte	-128
 10317 0116 80       		.byte	-128
 10318 0117 80       		.byte	-128
 10319 0118 80       		.byte	-128
 10320 0119 80       		.byte	-128
 10321 011a 80       		.byte	-128
 10322 011b 80       		.byte	-128
 10323 011c 80       		.byte	-128
 10324 011d 80       		.byte	-128
 10325 011e 80       		.byte	-128
 10326 011f 80       		.byte	-128
 10327              		.align 32
 10328              	.LC24:
 10329 0120 80       		.byte	-128
 10330 0121 80       		.byte	-128
 10331 0122 80       		.byte	-128
 10332 0123 80       		.byte	-128
 10333 0124 80       		.byte	-128
 10334 0125 00       		.byte	0
 10335 0126 03       		.byte	3
 10336 0127 06       		.byte	6
 10337 0128 09       		.byte	9
 10338 0129 0C       		.byte	12
 10339 012a 0F       		.byte	15
 10340 012b 80       		.byte	-128
 10341 012c 80       		.byte	-128
 10342 012d 80       		.byte	-128
 10343 012e 80       		.byte	-128
 10344 012f 80       		.byte	-128
 10345 0130 80       		.byte	-128
 10346 0131 80       		.byte	-128
 10347 0132 80       		.byte	-128
 10348 0133 80       		.byte	-128
 10349 0134 80       		.byte	-128
 10350 0135 80       		.byte	-128
 10351 0136 80       		.byte	-128
 10352 0137 80       		.byte	-128
 10353 0138 80       		.byte	-128
 10354 0139 80       		.byte	-128
 10355 013a 80       		.byte	-128
 10356 013b 80       		.byte	-128
 10357 013c 80       		.byte	-128
 10358 013d 80       		.byte	-128
 10359 013e 80       		.byte	-128
 10360 013f 80       		.byte	-128
 10361              		.align 32
 10362              	.LC25:
 10363 0140 00       		.byte	0
 10364 0141 01       		.byte	1
 10365 0142 02       		.byte	2
 10366 0143 03       		.byte	3
 10367 0144 04       		.byte	4
 10368 0145 05       		.byte	5
 10369 0146 06       		.byte	6
 10370 0147 07       		.byte	7
 10371 0148 08       		.byte	8
 10372 0149 09       		.byte	9
 10373 014a 0A       		.byte	10
 10374 014b 0B       		.byte	11
 10375 014c 0C       		.byte	12
 10376 014d 0D       		.byte	13
 10377 014e 0E       		.byte	14
 10378 014f 0F       		.byte	15
 10379 0150 00       		.byte	0
 10380 0151 01       		.byte	1
 10381 0152 02       		.byte	2
 10382 0153 03       		.byte	3
 10383 0154 04       		.byte	4
 10384 0155 80       		.byte	-128
 10385 0156 80       		.byte	-128
 10386 0157 80       		.byte	-128
 10387 0158 80       		.byte	-128
 10388 0159 80       		.byte	-128
 10389 015a 80       		.byte	-128
 10390 015b 80       		.byte	-128
 10391 015c 80       		.byte	-128
 10392 015d 80       		.byte	-128
 10393 015e 80       		.byte	-128
 10394 015f 80       		.byte	-128
 10395              		.align 32
 10396              	.LC26:
 10397 0160 80       		.byte	-128
 10398 0161 80       		.byte	-128
 10399 0162 80       		.byte	-128
 10400 0163 80       		.byte	-128
 10401 0164 80       		.byte	-128
 10402 0165 80       		.byte	-128
 10403 0166 80       		.byte	-128
 10404 0167 80       		.byte	-128
 10405 0168 80       		.byte	-128
 10406 0169 80       		.byte	-128
 10407 016a 80       		.byte	-128
 10408 016b 80       		.byte	-128
 10409 016c 80       		.byte	-128
 10410 016d 80       		.byte	-128
 10411 016e 80       		.byte	-128
 10412 016f 80       		.byte	-128
 10413 0170 80       		.byte	-128
 10414 0171 80       		.byte	-128
 10415 0172 80       		.byte	-128
 10416 0173 80       		.byte	-128
 10417 0174 80       		.byte	-128
 10418 0175 80       		.byte	-128
 10419 0176 80       		.byte	-128
 10420 0177 80       		.byte	-128
 10421 0178 80       		.byte	-128
 10422 0179 80       		.byte	-128
 10423 017a 80       		.byte	-128
 10424 017b 02       		.byte	2
 10425 017c 05       		.byte	5
 10426 017d 08       		.byte	8
 10427 017e 0B       		.byte	11
 10428 017f 0E       		.byte	14
 10429              		.align 32
 10430              	.LC27:
 10431 0180 80       		.byte	-128
 10432 0181 80       		.byte	-128
 10433 0182 80       		.byte	-128
 10434 0183 80       		.byte	-128
 10435 0184 80       		.byte	-128
 10436 0185 00       		.byte	0
 10437 0186 00       		.byte	0
 10438 0187 00       		.byte	0
 10439 0188 00       		.byte	0
 10440 0189 00       		.byte	0
 10441 018a 00       		.byte	0
 10442 018b 00       		.byte	0
 10443 018c 00       		.byte	0
 10444 018d 00       		.byte	0
 10445 018e 00       		.byte	0
 10446 018f 00       		.byte	0
 10447 0190 80       		.byte	-128
 10448 0191 80       		.byte	-128
 10449 0192 80       		.byte	-128
 10450 0193 80       		.byte	-128
 10451 0194 80       		.byte	-128
 10452 0195 01       		.byte	1
 10453 0196 04       		.byte	4
 10454 0197 07       		.byte	7
 10455 0198 0A       		.byte	10
 10456 0199 0D       		.byte	13
 10457 019a 80       		.byte	-128
 10458 019b 80       		.byte	-128
 10459 019c 80       		.byte	-128
 10460 019d 80       		.byte	-128
 10461 019e 80       		.byte	-128
 10462 019f 80       		.byte	-128
 10463              		.align 32
 10464              	.LC28:
 10465 01a0 02       		.byte	2
 10466 01a1 05       		.byte	5
 10467 01a2 08       		.byte	8
 10468 01a3 0B       		.byte	11
 10469 01a4 0E       		.byte	14
 10470 01a5 80       		.byte	-128
 10471 01a6 80       		.byte	-128
 10472 01a7 80       		.byte	-128
 10473 01a8 80       		.byte	-128
 10474 01a9 80       		.byte	-128
 10475 01aa 80       		.byte	-128
 10476 01ab 80       		.byte	-128
 10477 01ac 80       		.byte	-128
 10478 01ad 80       		.byte	-128
 10479 01ae 80       		.byte	-128
 10480 01af 80       		.byte	-128
 10481 01b0 80       		.byte	-128
 10482 01b1 80       		.byte	-128
 10483 01b2 80       		.byte	-128
 10484 01b3 80       		.byte	-128
 10485 01b4 80       		.byte	-128
 10486 01b5 80       		.byte	-128
 10487 01b6 80       		.byte	-128
 10488 01b7 80       		.byte	-128
 10489 01b8 80       		.byte	-128
 10490 01b9 80       		.byte	-128
 10491 01ba 80       		.byte	-128
 10492 01bb 80       		.byte	-128
 10493 01bc 80       		.byte	-128
 10494 01bd 80       		.byte	-128
 10495 01be 80       		.byte	-128
 10496 01bf 80       		.byte	-128
 10497              		.align 32
 10498              	.LC29:
 10499 01c0 80       		.byte	-128
 10500 01c1 80       		.byte	-128
 10501 01c2 80       		.byte	-128
 10502 01c3 80       		.byte	-128
 10503 01c4 80       		.byte	-128
 10504 01c5 80       		.byte	-128
 10505 01c6 80       		.byte	-128
 10506 01c7 80       		.byte	-128
 10507 01c8 80       		.byte	-128
 10508 01c9 80       		.byte	-128
 10509 01ca 00       		.byte	0
 10510 01cb 03       		.byte	3
 10511 01cc 06       		.byte	6
 10512 01cd 09       		.byte	9
 10513 01ce 0C       		.byte	12
 10514 01cf 0F       		.byte	15
 10515 01d0 02       		.byte	2
 10516 01d1 05       		.byte	5
 10517 01d2 08       		.byte	8
 10518 01d3 0B       		.byte	11
 10519 01d4 0E       		.byte	14
 10520 01d5 80       		.byte	-128
 10521 01d6 80       		.byte	-128
 10522 01d7 80       		.byte	-128
 10523 01d8 80       		.byte	-128
 10524 01d9 80       		.byte	-128
 10525 01da 80       		.byte	-128
 10526 01db 80       		.byte	-128
 10527 01dc 80       		.byte	-128
 10528 01dd 80       		.byte	-128
 10529 01de 80       		.byte	-128
 10530 01df 80       		.byte	-128
 10531              		.align 32
 10532              	.LC30:
 10533 01e0 80       		.byte	-128
 10534 01e1 80       		.byte	-128
 10535 01e2 80       		.byte	-128
 10536 01e3 80       		.byte	-128
 10537 01e4 80       		.byte	-128
 10538 01e5 01       		.byte	1
 10539 01e6 04       		.byte	4
 10540 01e7 07       		.byte	7
 10541 01e8 0A       		.byte	10
 10542 01e9 0D       		.byte	13
 10543 01ea 80       		.byte	-128
 10544 01eb 80       		.byte	-128
 10545 01ec 80       		.byte	-128
 10546 01ed 80       		.byte	-128
 10547 01ee 80       		.byte	-128
 10548 01ef 80       		.byte	-128
 10549 01f0 80       		.byte	-128
 10550 01f1 80       		.byte	-128
 10551 01f2 80       		.byte	-128
 10552 01f3 80       		.byte	-128
 10553 01f4 80       		.byte	-128
 10554 01f5 80       		.byte	-128
 10555 01f6 80       		.byte	-128
 10556 01f7 80       		.byte	-128
 10557 01f8 80       		.byte	-128
 10558 01f9 80       		.byte	-128
 10559 01fa 80       		.byte	-128
 10560 01fb 80       		.byte	-128
 10561 01fc 80       		.byte	-128
 10562 01fd 80       		.byte	-128
 10563 01fe 80       		.byte	-128
 10564 01ff 80       		.byte	-128
 10565              		.align 32
 10566              	.LC31:
 10567 0200 80       		.byte	-128
 10568 0201 80       		.byte	-128
 10569 0202 80       		.byte	-128
 10570 0203 80       		.byte	-128
 10571 0204 80       		.byte	-128
 10572 0205 80       		.byte	-128
 10573 0206 80       		.byte	-128
 10574 0207 80       		.byte	-128
 10575 0208 80       		.byte	-128
 10576 0209 80       		.byte	-128
 10577 020a 80       		.byte	-128
 10578 020b 80       		.byte	-128
 10579 020c 80       		.byte	-128
 10580 020d 80       		.byte	-128
 10581 020e 80       		.byte	-128
 10582 020f 80       		.byte	-128
 10583 0210 80       		.byte	-128
 10584 0211 80       		.byte	-128
 10585 0212 80       		.byte	-128
 10586 0213 80       		.byte	-128
 10587 0214 80       		.byte	-128
 10588 0215 80       		.byte	-128
 10589 0216 80       		.byte	-128
 10590 0217 80       		.byte	-128
 10591 0218 80       		.byte	-128
 10592 0219 80       		.byte	-128
 10593 021a 00       		.byte	0
 10594 021b 03       		.byte	3
 10595 021c 06       		.byte	6
 10596 021d 09       		.byte	9
 10597 021e 0C       		.byte	12
 10598 021f 0F       		.byte	15
 10599              		.align 32
 10600              	.LC32:
 10601 0220 2FDD443F 		.long	1061477679
 10602 0224 2FDD443F 		.long	1061477679
 10603 0228 2FDD443F 		.long	1061477679
 10604 022c 2FDD443F 		.long	1061477679
 10605 0230 2FDD443F 		.long	1061477679
 10606 0234 2FDD443F 		.long	1061477679
 10607 0238 2FDD443F 		.long	1061477679
 10608 023c 2FDD443F 		.long	1061477679
 10609              		.align 32
 10610              	.LC33:
 10611 0240 4C37C93E 		.long	1053374284
 10612 0244 4C37C93E 		.long	1053374284
 10613 0248 4C37C93E 		.long	1053374284
 10614 024c 4C37C93E 		.long	1053374284
 10615 0250 4C37C93E 		.long	1053374284
 10616 0254 4C37C93E 		.long	1053374284
 10617 0258 4C37C93E 		.long	1053374284
 10618 025c 4C37C93E 		.long	1053374284
 10619              		.align 32
 10620              	.LC34:
 10621 0260 3789413E 		.long	1044482359
 10622 0264 3789413E 		.long	1044482359
 10623 0268 3789413E 		.long	1044482359
 10624 026c 3789413E 		.long	1044482359
 10625 0270 3789413E 		.long	1044482359
 10626 0274 3789413E 		.long	1044482359
 10627 0278 3789413E 		.long	1044482359
 10628 027c 3789413E 		.long	1044482359
 10629              		.align 32
 10630              	.LC35:
 10631 0280 00007F43 		.long	1132396544
 10632 0284 00007F43 		.long	1132396544
 10633 0288 00007F43 		.long	1132396544
 10634 028c 00007F43 		.long	1132396544
 10635 0290 00007F43 		.long	1132396544
 10636 0294 00007F43 		.long	1132396544
 10637 0298 00007F43 		.long	1132396544
 10638 029c 00007F43 		.long	1132396544
 10639              		.align 32
 10640              	.LC40:
 10641 02a0 B29D2F3F 		.long	1060085170
 10642 02a4 B29D2F3F 		.long	1060085170
 10643 02a8 B29D2F3F 		.long	1060085170
 10644 02ac B29D2F3F 		.long	1060085170
 10645 02b0 B29D2F3F 		.long	1060085170
 10646 02b4 B29D2F3F 		.long	1060085170
 10647 02b8 B29D2F3F 		.long	1060085170
 10648 02bc B29D2F3F 		.long	1060085170
 10649              		.align 32
 10650              	.LC41:
 10651 02c0 21B0B23E 		.long	1051897889
 10652 02c4 21B0B23E 		.long	1051897889
 10653 02c8 21B0B23E 		.long	1051897889
 10654 02cc 21B0B23E 		.long	1051897889
 10655 02d0 21B0B23E 		.long	1051897889
 10656 02d4 21B0B23E 		.long	1051897889
 10657 02d8 21B0B23E 		.long	1051897889
 10658 02dc 21B0B23E 		.long	1051897889
 10659              		.align 32
 10660              	.LC42:
 10661 02e0 31082C3E 		.long	1043073073
 10662 02e4 31082C3E 		.long	1043073073
 10663 02e8 31082C3E 		.long	1043073073
 10664 02ec 31082C3E 		.long	1043073073
 10665 02f0 31082C3E 		.long	1043073073
 10666 02f4 31082C3E 		.long	1043073073
 10667 02f8 31082C3E 		.long	1043073073
 10668 02fc 31082C3E 		.long	1043073073
 10669              		.align 32
 10670              	.LC43:
 10671 0300 39B4083F 		.long	1057535033
 10672 0304 39B4083F 		.long	1057535033
 10673 0308 39B4083F 		.long	1057535033
 10674 030c 39B4083F 		.long	1057535033
 10675 0310 39B4083F 		.long	1057535033
 10676 0314 39B4083F 		.long	1057535033
 10677 0318 39B4083F 		.long	1057535033
 10678 031c 39B4083F 		.long	1057535033
 10679              		.align 32
 10680              	.LC44:
 10681 0320 96438B3E 		.long	1049314198
 10682 0324 96438B3E 		.long	1049314198
 10683 0328 96438B3E 		.long	1049314198
 10684 032c 96438B3E 		.long	1049314198
 10685 0330 96438B3E 		.long	1049314198
 10686 0334 96438B3E 		.long	1049314198
 10687 0338 96438B3E 		.long	1049314198
 10688 033c 96438B3E 		.long	1049314198
 10689              		.align 32
 10690              	.LC45:
 10691 0340 DD24063E 		.long	1040590045
 10692 0344 DD24063E 		.long	1040590045
 10693 0348 DD24063E 		.long	1040590045
 10694 034c DD24063E 		.long	1040590045
 10695 0350 DD24063E 		.long	1040590045
 10696 0354 DD24063E 		.long	1040590045
 10697 0358 DD24063E 		.long	1040590045
 10698 035c DD24063E 		.long	1040590045
 10699              		.align 32
 10700              	.LC46:
 10701 0360 80       		.byte	-128
 10702 0361 00       		.byte	0
 10703 0362 06       		.byte	6
 10704 0363 80       		.byte	-128
 10705 0364 00       		.byte	0
 10706 0365 07       		.byte	7
 10707 0366 80       		.byte	-128
 10708 0367 00       		.byte	0
 10709 0368 08       		.byte	8
 10710 0369 80       		.byte	-128
 10711 036a 00       		.byte	0
 10712 036b 09       		.byte	9
 10713 036c 80       		.byte	-128
 10714 036d 00       		.byte	0
 10715 036e 0A       		.byte	10
 10716 036f 80       		.byte	-128
 10717 0370 80       		.byte	-128
 10718 0371 80       		.byte	-128
 10719 0372 80       		.byte	-128
 10720 0373 80       		.byte	-128
 10721 0374 80       		.byte	-128
 10722 0375 80       		.byte	-128
 10723 0376 80       		.byte	-128
 10724 0377 80       		.byte	-128
 10725 0378 80       		.byte	-128
 10726 0379 80       		.byte	-128
 10727 037a 80       		.byte	-128
 10728 037b 80       		.byte	-128
 10729 037c 80       		.byte	-128
 10730 037d 80       		.byte	-128
 10731 037e 80       		.byte	-128
 10732 037f 80       		.byte	-128
 10733              		.align 32
 10734              	.LC47:
 10735 0380 05       		.byte	5
 10736 0381 80       		.byte	-128
 10737 0382 80       		.byte	-128
 10738 0383 06       		.byte	6
 10739 0384 80       		.byte	-128
 10740 0385 80       		.byte	-128
 10741 0386 07       		.byte	7
 10742 0387 80       		.byte	-128
 10743 0388 80       		.byte	-128
 10744 0389 08       		.byte	8
 10745 038a 80       		.byte	-128
 10746 038b 80       		.byte	-128
 10747 038c 09       		.byte	9
 10748 038d 80       		.byte	-128
 10749 038e 80       		.byte	-128
 10750 038f 0A       		.byte	10
 10751 0390 80       		.byte	-128
 10752 0391 80       		.byte	-128
 10753 0392 80       		.byte	-128
 10754 0393 80       		.byte	-128
 10755 0394 80       		.byte	-128
 10756 0395 80       		.byte	-128
 10757 0396 80       		.byte	-128
 10758 0397 80       		.byte	-128
 10759 0398 80       		.byte	-128
 10760 0399 80       		.byte	-128
 10761 039a 80       		.byte	-128
 10762 039b 80       		.byte	-128
 10763 039c 80       		.byte	-128
 10764 039d 80       		.byte	-128
 10765 039e 80       		.byte	-128
 10766 039f 80       		.byte	-128
 10767              		.align 32
 10768              	.LC48:
 10769 03a0 00       		.byte	0
 10770 03a1 80       		.byte	-128
 10771 03a2 00       		.byte	0
 10772 03a3 01       		.byte	1
 10773 03a4 80       		.byte	-128
 10774 03a5 00       		.byte	0
 10775 03a6 02       		.byte	2
 10776 03a7 80       		.byte	-128
 10777 03a8 00       		.byte	0
 10778 03a9 03       		.byte	3
 10779 03aa 80       		.byte	-128
 10780 03ab 00       		.byte	0
 10781 03ac 04       		.byte	4
 10782 03ad 80       		.byte	-128
 10783 03ae 00       		.byte	0
 10784 03af 05       		.byte	5
 10785 03b0 80       		.byte	-128
 10786 03b1 80       		.byte	-128
 10787 03b2 80       		.byte	-128
 10788 03b3 80       		.byte	-128
 10789 03b4 80       		.byte	-128
 10790 03b5 80       		.byte	-128
 10791 03b6 80       		.byte	-128
 10792 03b7 80       		.byte	-128
 10793 03b8 80       		.byte	-128
 10794 03b9 80       		.byte	-128
 10795 03ba 80       		.byte	-128
 10796 03bb 80       		.byte	-128
 10797 03bc 80       		.byte	-128
 10798 03bd 80       		.byte	-128
 10799 03be 80       		.byte	-128
 10800 03bf 80       		.byte	-128
 10801              		.align 32
 10802              	.LC49:
 10803 03c0 80       		.byte	-128
 10804 03c1 00       		.byte	0
 10805 03c2 80       		.byte	-128
 10806 03c3 80       		.byte	-128
 10807 03c4 01       		.byte	1
 10808 03c5 80       		.byte	-128
 10809 03c6 80       		.byte	-128
 10810 03c7 02       		.byte	2
 10811 03c8 80       		.byte	-128
 10812 03c9 80       		.byte	-128
 10813 03ca 03       		.byte	3
 10814 03cb 80       		.byte	-128
 10815 03cc 80       		.byte	-128
 10816 03cd 04       		.byte	4
 10817 03ce 80       		.byte	-128
 10818 03cf 80       		.byte	-128
 10819 03d0 80       		.byte	-128
 10820 03d1 80       		.byte	-128
 10821 03d2 80       		.byte	-128
 10822 03d3 80       		.byte	-128
 10823 03d4 80       		.byte	-128
 10824 03d5 80       		.byte	-128
 10825 03d6 80       		.byte	-128
 10826 03d7 80       		.byte	-128
 10827 03d8 80       		.byte	-128
 10828 03d9 80       		.byte	-128
 10829 03da 80       		.byte	-128
 10830 03db 80       		.byte	-128
 10831 03dc 80       		.byte	-128
 10832 03dd 80       		.byte	-128
 10833 03de 80       		.byte	-128
 10834 03df 80       		.byte	-128
 10835              		.align 32
 10836              	.LC50:
 10837 03e0 80       		.byte	-128
 10838 03e1 05       		.byte	5
 10839 03e2 80       		.byte	-128
 10840 03e3 80       		.byte	-128
 10841 03e4 06       		.byte	6
 10842 03e5 80       		.byte	-128
 10843 03e6 80       		.byte	-128
 10844 03e7 07       		.byte	7
 10845 03e8 80       		.byte	-128
 10846 03e9 80       		.byte	-128
 10847 03ea 08       		.byte	8
 10848 03eb 80       		.byte	-128
 10849 03ec 80       		.byte	-128
 10850 03ed 09       		.byte	9
 10851 03ee 80       		.byte	-128
 10852 03ef 80       		.byte	-128
 10853 03f0 80       		.byte	-128
 10854 03f1 80       		.byte	-128
 10855 03f2 80       		.byte	-128
 10856 03f3 80       		.byte	-128
 10857 03f4 80       		.byte	-128
 10858 03f5 80       		.byte	-128
 10859 03f6 80       		.byte	-128
 10860 03f7 80       		.byte	-128
 10861 03f8 80       		.byte	-128
 10862 03f9 80       		.byte	-128
 10863 03fa 80       		.byte	-128
 10864 03fb 80       		.byte	-128
 10865 03fc 80       		.byte	-128
 10866 03fd 80       		.byte	-128
 10867 03fe 80       		.byte	-128
 10868 03ff 80       		.byte	-128
 10869              		.align 32
 10870              	.LC51:
 10871 0400 00       		.byte	0
 10872 0401 01       		.byte	1
 10873 0402 80       		.byte	-128
 10874 0403 03       		.byte	3
 10875 0404 04       		.byte	4
 10876 0405 80       		.byte	-128
 10877 0406 06       		.byte	6
 10878 0407 07       		.byte	7
 10879 0408 80       		.byte	-128
 10880 0409 09       		.byte	9
 10881 040a 0A       		.byte	10
 10882 040b 80       		.byte	-128
 10883 040c 0C       		.byte	12
 10884 040d 0D       		.byte	13
 10885 040e 80       		.byte	-128
 10886 040f 0F       		.byte	15
 10887 0410 00       		.byte	0
 10888 0411 80       		.byte	-128
 10889 0412 02       		.byte	2
 10890 0413 03       		.byte	3
 10891 0414 80       		.byte	-128
 10892 0415 05       		.byte	5
 10893 0416 06       		.byte	6
 10894 0417 80       		.byte	-128
 10895 0418 08       		.byte	8
 10896 0419 09       		.byte	9
 10897 041a 80       		.byte	-128
 10898 041b 0B       		.byte	11
 10899 041c 0C       		.byte	12
 10900 041d 80       		.byte	-128
 10901 041e 0E       		.byte	14
 10902 041f 0F       		.byte	15
 10903              		.align 32
 10904              	.LC52:
 10905 0420 80       		.byte	-128
 10906 0421 80       		.byte	-128
 10907 0422 00       		.byte	0
 10908 0423 80       		.byte	-128
 10909 0424 80       		.byte	-128
 10910 0425 01       		.byte	1
 10911 0426 80       		.byte	-128
 10912 0427 80       		.byte	-128
 10913 0428 02       		.byte	2
 10914 0429 80       		.byte	-128
 10915 042a 80       		.byte	-128
 10916 042b 03       		.byte	3
 10917 042c 80       		.byte	-128
 10918 042d 80       		.byte	-128
 10919 042e 04       		.byte	4
 10920 042f 80       		.byte	-128
 10921 0430 80       		.byte	-128
 10922 0431 80       		.byte	-128
 10923 0432 80       		.byte	-128
 10924 0433 80       		.byte	-128
 10925 0434 80       		.byte	-128
 10926 0435 80       		.byte	-128
 10927 0436 80       		.byte	-128
 10928 0437 80       		.byte	-128
 10929 0438 80       		.byte	-128
 10930 0439 80       		.byte	-128
 10931 043a 80       		.byte	-128
 10932 043b 80       		.byte	-128
 10933 043c 80       		.byte	-128
 10934 043d 80       		.byte	-128
 10935 043e 80       		.byte	-128
 10936 043f 80       		.byte	-128
 10937              		.align 32
 10938              	.LC53:
 10939 0440 80       		.byte	-128
 10940 0441 80       		.byte	-128
 10941 0442 00       		.byte	0
 10942 0443 80       		.byte	-128
 10943 0444 80       		.byte	-128
 10944 0445 00       		.byte	0
 10945 0446 80       		.byte	-128
 10946 0447 80       		.byte	-128
 10947 0448 00       		.byte	0
 10948 0449 80       		.byte	-128
 10949 044a 80       		.byte	-128
 10950 044b 00       		.byte	0
 10951 044c 80       		.byte	-128
 10952 044d 80       		.byte	-128
 10953 044e 00       		.byte	0
 10954 044f 80       		.byte	-128
 10955 0450 80       		.byte	-128
 10956 0451 80       		.byte	-128
 10957 0452 80       		.byte	-128
 10958 0453 80       		.byte	-128
 10959 0454 80       		.byte	-128
 10960 0455 80       		.byte	-128
 10961 0456 80       		.byte	-128
 10962 0457 80       		.byte	-128
 10963 0458 80       		.byte	-128
 10964 0459 80       		.byte	-128
 10965 045a 80       		.byte	-128
 10966 045b 80       		.byte	-128
 10967 045c 80       		.byte	-128
 10968 045d 80       		.byte	-128
 10969 045e 80       		.byte	-128
 10970 045f 80       		.byte	-128
 10971              		.align 32
 10972              	.LC54:
 10973 0460 00       		.byte	0
 10974 0461 0B       		.byte	11
 10975 0462 80       		.byte	-128
 10976 0463 00       		.byte	0
 10977 0464 0C       		.byte	12
 10978 0465 80       		.byte	-128
 10979 0466 00       		.byte	0
 10980 0467 0D       		.byte	13
 10981 0468 80       		.byte	-128
 10982 0469 00       		.byte	0
 10983 046a 0E       		.byte	14
 10984 046b 80       		.byte	-128
 10985 046c 00       		.byte	0
 10986 046d 0F       		.byte	15
 10987 046e 80       		.byte	-128
 10988 046f 00       		.byte	0
 10989 0470 00       		.byte	0
 10990 0471 80       		.byte	-128
 10991 0472 80       		.byte	-128
 10992 0473 01       		.byte	1
 10993 0474 80       		.byte	-128
 10994 0475 80       		.byte	-128
 10995 0476 02       		.byte	2
 10996 0477 80       		.byte	-128
 10997 0478 80       		.byte	-128
 10998 0479 03       		.byte	3
 10999 047a 80       		.byte	-128
 11000 047b 80       		.byte	-128
 11001 047c 04       		.byte	4
 11002 047d 80       		.byte	-128
 11003 047e 80       		.byte	-128
 11004 047f 05       		.byte	5
 11005              		.align 32
 11006              	.LC55:
 11007 0480 80       		.byte	-128
 11008 0481 80       		.byte	-128
 11009 0482 0B       		.byte	11
 11010 0483 80       		.byte	-128
 11011 0484 80       		.byte	-128
 11012 0485 0C       		.byte	12
 11013 0486 80       		.byte	-128
 11014 0487 80       		.byte	-128
 11015 0488 0D       		.byte	13
 11016 0489 80       		.byte	-128
 11017 048a 80       		.byte	-128
 11018 048b 0E       		.byte	14
 11019 048c 80       		.byte	-128
 11020 048d 80       		.byte	-128
 11021 048e 0F       		.byte	15
 11022 048f 80       		.byte	-128
 11023 0490 80       		.byte	-128
 11024 0491 00       		.byte	0
 11025 0492 80       		.byte	-128
 11026 0493 80       		.byte	-128
 11027 0494 01       		.byte	1
 11028 0495 80       		.byte	-128
 11029 0496 80       		.byte	-128
 11030 0497 02       		.byte	2
 11031 0498 80       		.byte	-128
 11032 0499 80       		.byte	-128
 11033 049a 03       		.byte	3
 11034 049b 80       		.byte	-128
 11035 049c 80       		.byte	-128
 11036 049d 04       		.byte	4
 11037 049e 80       		.byte	-128
 11038 049f 80       		.byte	-128
 11039              		.align 32
 11040              	.LC56:
 11041 04a0 0A       		.byte	10
 11042 04a1 01       		.byte	1
 11043 04a2 00       		.byte	0
 11044 04a3 0B       		.byte	11
 11045 04a4 04       		.byte	4
 11046 04a5 01       		.byte	1
 11047 04a6 0C       		.byte	12
 11048 04a7 07       		.byte	7
 11049 04a8 02       		.byte	2
 11050 04a9 0D       		.byte	13
 11051 04aa 0A       		.byte	10
 11052 04ab 03       		.byte	3
 11053 04ac 0E       		.byte	14
 11054 04ad 0D       		.byte	13
 11055 04ae 04       		.byte	4
 11056 04af 0F       		.byte	15
 11057 04b0 0A       		.byte	10
 11058 04b1 01       		.byte	1
 11059 04b2 00       		.byte	0
 11060 04b3 0B       		.byte	11
 11061 04b4 04       		.byte	4
 11062 04b5 01       		.byte	1
 11063 04b6 0C       		.byte	12
 11064 04b7 07       		.byte	7
 11065 04b8 02       		.byte	2
 11066 04b9 0D       		.byte	13
 11067 04ba 0A       		.byte	10
 11068 04bb 03       		.byte	3
 11069 04bc 0E       		.byte	14
 11070 04bd 0D       		.byte	13
 11071 04be 04       		.byte	4
 11072 04bf 0F       		.byte	15
 11073              		.align 32
 11074              	.LC57:
 11075 04c0 00       		.byte	0
 11076 04c1 FF       		.byte	-1
 11077 04c2 FF       		.byte	-1
 11078 04c3 00       		.byte	0
 11079 04c4 FF       		.byte	-1
 11080 04c5 FF       		.byte	-1
 11081 04c6 00       		.byte	0
 11082 04c7 FF       		.byte	-1
 11083 04c8 FF       		.byte	-1
 11084 04c9 00       		.byte	0
 11085 04ca FF       		.byte	-1
 11086 04cb FF       		.byte	-1
 11087 04cc 00       		.byte	0
 11088 04cd FF       		.byte	-1
 11089 04ce FF       		.byte	-1
 11090 04cf 00       		.byte	0
 11091 04d0 FF       		.byte	-1
 11092 04d1 FF       		.byte	-1
 11093 04d2 00       		.byte	0
 11094 04d3 FF       		.byte	-1
 11095 04d4 FF       		.byte	-1
 11096 04d5 00       		.byte	0
 11097 04d6 FF       		.byte	-1
 11098 04d7 FF       		.byte	-1
 11099 04d8 00       		.byte	0
 11100 04d9 FF       		.byte	-1
 11101 04da FF       		.byte	-1
 11102 04db 00       		.byte	0
 11103 04dc FF       		.byte	-1
 11104 04dd FF       		.byte	-1
 11105 04de 00       		.byte	0
 11106 04df FF       		.byte	-1
 11107              		.align 32
 11108              	.LC58:
 11109 04e0 80       		.byte	-128
 11110 04e1 80       		.byte	-128
 11111 04e2 80       		.byte	-128
 11112 04e3 80       		.byte	-128
 11113 04e4 80       		.byte	-128
 11114 04e5 80       		.byte	-128
 11115 04e6 80       		.byte	-128
 11116 04e7 80       		.byte	-128
 11117 04e8 80       		.byte	-128
 11118 04e9 80       		.byte	-128
 11119 04ea 80       		.byte	-128
 11120 04eb 80       		.byte	-128
 11121 04ec 80       		.byte	-128
 11122 04ed 80       		.byte	-128
 11123 04ee 80       		.byte	-128
 11124 04ef 80       		.byte	-128
 11125 04f0 05       		.byte	5
 11126 04f1 80       		.byte	-128
 11127 04f2 80       		.byte	-128
 11128 04f3 06       		.byte	6
 11129 04f4 80       		.byte	-128
 11130 04f5 80       		.byte	-128
 11131 04f6 07       		.byte	7
 11132 04f7 80       		.byte	-128
 11133 04f8 80       		.byte	-128
 11134 04f9 08       		.byte	8
 11135 04fa 80       		.byte	-128
 11136 04fb 80       		.byte	-128
 11137 04fc 09       		.byte	9
 11138 04fd 80       		.byte	-128
 11139 04fe 80       		.byte	-128
 11140 04ff 0A       		.byte	10
 11141              		.align 32
 11142              	.LC59:
 11143 0500 00       		.byte	0
 11144 0501 80       		.byte	-128
 11145 0502 80       		.byte	-128
 11146 0503 00       		.byte	0
 11147 0504 80       		.byte	-128
 11148 0505 80       		.byte	-128
 11149 0506 00       		.byte	0
 11150 0507 80       		.byte	-128
 11151 0508 80       		.byte	-128
 11152 0509 00       		.byte	0
 11153 050a 80       		.byte	-128
 11154 050b 80       		.byte	-128
 11155 050c 00       		.byte	0
 11156 050d 80       		.byte	-128
 11157 050e 80       		.byte	-128
 11158 050f 00       		.byte	0
 11159 0510 80       		.byte	-128
 11160 0511 80       		.byte	-128
 11161 0512 06       		.byte	6
 11162 0513 80       		.byte	-128
 11163 0514 80       		.byte	-128
 11164 0515 07       		.byte	7
 11165 0516 80       		.byte	-128
 11166 0517 80       		.byte	-128
 11167 0518 08       		.byte	8
 11168 0519 80       		.byte	-128
 11169 051a 80       		.byte	-128
 11170 051b 09       		.byte	9
 11171 051c 80       		.byte	-128
 11172 051d 80       		.byte	-128
 11173 051e 0A       		.byte	10
 11174 051f 80       		.byte	-128
 11175              		.align 32
 11176              	.LC60:
 11177 0520 80       		.byte	-128
 11178 0521 80       		.byte	-128
 11179 0522 80       		.byte	-128
 11180 0523 80       		.byte	-128
 11181 0524 80       		.byte	-128
 11182 0525 80       		.byte	-128
 11183 0526 80       		.byte	-128
 11184 0527 80       		.byte	-128
 11185 0528 80       		.byte	-128
 11186 0529 80       		.byte	-128
 11187 052a 80       		.byte	-128
 11188 052b 80       		.byte	-128
 11189 052c 80       		.byte	-128
 11190 052d 80       		.byte	-128
 11191 052e 80       		.byte	-128
 11192 052f 80       		.byte	-128
 11193 0530 80       		.byte	-128
 11194 0531 80       		.byte	-128
 11195 0532 0B       		.byte	11
 11196 0533 80       		.byte	-128
 11197 0534 80       		.byte	-128
 11198 0535 0C       		.byte	12
 11199 0536 80       		.byte	-128
 11200 0537 80       		.byte	-128
 11201 0538 0D       		.byte	13
 11202 0539 80       		.byte	-128
 11203 053a 80       		.byte	-128
 11204 053b 0E       		.byte	14
 11205 053c 80       		.byte	-128
 11206 053d 80       		.byte	-128
 11207 053e 0F       		.byte	15
 11208 053f 80       		.byte	-128
 11209              		.align 32
 11210              	.LC61:
 11211 0540 80       		.byte	-128
 11212 0541 00       		.byte	0
 11213 0542 80       		.byte	-128
 11214 0543 80       		.byte	-128
 11215 0544 00       		.byte	0
 11216 0545 80       		.byte	-128
 11217 0546 80       		.byte	-128
 11218 0547 00       		.byte	0
 11219 0548 80       		.byte	-128
 11220 0549 80       		.byte	-128
 11221 054a 00       		.byte	0
 11222 054b 80       		.byte	-128
 11223 054c 80       		.byte	-128
 11224 054d 00       		.byte	0
 11225 054e 80       		.byte	-128
 11226 054f 80       		.byte	-128
 11227 0550 80       		.byte	-128
 11228 0551 0B       		.byte	11
 11229 0552 80       		.byte	-128
 11230 0553 80       		.byte	-128
 11231 0554 0C       		.byte	12
 11232 0555 80       		.byte	-128
 11233 0556 80       		.byte	-128
 11234 0557 0D       		.byte	13
 11235 0558 80       		.byte	-128
 11236 0559 80       		.byte	-128
 11237 055a 0E       		.byte	14
 11238 055b 80       		.byte	-128
 11239 055c 80       		.byte	-128
 11240 055d 0F       		.byte	15
 11241 055e 80       		.byte	-128
 11242 055f 80       		.byte	-128
 11243              		.align 32
 11244              	.LC62:
 11245 0560 80       		.byte	-128
 11246 0561 80       		.byte	-128
 11247 0562 80       		.byte	-128
 11248 0563 80       		.byte	-128
 11249 0564 80       		.byte	-128
 11250 0565 80       		.byte	-128
 11251 0566 80       		.byte	-128
 11252 0567 80       		.byte	-128
 11253 0568 80       		.byte	-128
 11254 0569 80       		.byte	-128
 11255 056a 80       		.byte	-128
 11256 056b 80       		.byte	-128
 11257 056c 80       		.byte	-128
 11258 056d 80       		.byte	-128
 11259 056e 80       		.byte	-128
 11260 056f 80       		.byte	-128
 11261 0570 80       		.byte	-128
 11262 0571 05       		.byte	5
 11263 0572 80       		.byte	-128
 11264 0573 80       		.byte	-128
 11265 0574 06       		.byte	6
 11266 0575 80       		.byte	-128
 11267 0576 80       		.byte	-128
 11268 0577 07       		.byte	7
 11269 0578 80       		.byte	-128
 11270 0579 80       		.byte	-128
 11271 057a 08       		.byte	8
 11272 057b 80       		.byte	-128
 11273 057c 80       		.byte	-128
 11274 057d 09       		.byte	9
 11275 057e 80       		.byte	-128
 11276 057f 80       		.byte	-128
 11277              		.align 32
 11278              	.LC63:
 11279 0580 00       		.byte	0
 11280 0581 80       		.byte	-128
 11281 0582 02       		.byte	2
 11282 0583 03       		.byte	3
 11283 0584 80       		.byte	-128
 11284 0585 05       		.byte	5
 11285 0586 06       		.byte	6
 11286 0587 80       		.byte	-128
 11287 0588 08       		.byte	8
 11288 0589 09       		.byte	9
 11289 058a 80       		.byte	-128
 11290 058b 0B       		.byte	11
 11291 058c 0C       		.byte	12
 11292 058d 80       		.byte	-128
 11293 058e 0E       		.byte	14
 11294 058f 0F       		.byte	15
 11295 0590 80       		.byte	-128
 11296 0591 01       		.byte	1
 11297 0592 02       		.byte	2
 11298 0593 80       		.byte	-128
 11299 0594 04       		.byte	4
 11300 0595 05       		.byte	5
 11301 0596 80       		.byte	-128
 11302 0597 07       		.byte	7
 11303 0598 08       		.byte	8
 11304 0599 80       		.byte	-128
 11305 059a 0A       		.byte	10
 11306 059b 0B       		.byte	11
 11307 059c 80       		.byte	-128
 11308 059d 0D       		.byte	13
 11309 059e 0E       		.byte	14
 11310 059f 80       		.byte	-128
 11311              		.align 32
 11312              	.LC64:
 11313 05a0 80       		.byte	-128
 11314 05a1 80       		.byte	-128
 11315 05a2 80       		.byte	-128
 11316 05a3 80       		.byte	-128
 11317 05a4 80       		.byte	-128
 11318 05a5 80       		.byte	-128
 11319 05a6 80       		.byte	-128
 11320 05a7 80       		.byte	-128
 11321 05a8 80       		.byte	-128
 11322 05a9 80       		.byte	-128
 11323 05aa 80       		.byte	-128
 11324 05ab 80       		.byte	-128
 11325 05ac 80       		.byte	-128
 11326 05ad 80       		.byte	-128
 11327 05ae 80       		.byte	-128
 11328 05af 80       		.byte	-128
 11329 05b0 0A       		.byte	10
 11330 05b1 80       		.byte	-128
 11331 05b2 80       		.byte	-128
 11332 05b3 0B       		.byte	11
 11333 05b4 80       		.byte	-128
 11334 05b5 80       		.byte	-128
 11335 05b6 0C       		.byte	12
 11336 05b7 80       		.byte	-128
 11337 05b8 80       		.byte	-128
 11338 05b9 0D       		.byte	13
 11339 05ba 80       		.byte	-128
 11340 05bb 80       		.byte	-128
 11341 05bc 0E       		.byte	14
 11342 05bd 80       		.byte	-128
 11343 05be 80       		.byte	-128
 11344 05bf 0F       		.byte	15
 11345              		.section	.rodata.cst16
 11346              		.align 16
 11347              	.LC65:
 11348 0010 00       		.byte	0
 11349 0011 03       		.byte	3
 11350 0012 06       		.byte	6
 11351 0013 09       		.byte	9
 11352 0014 0C       		.byte	12
 11353 0015 0F       		.byte	15
 11354 0016 80       		.byte	-128
 11355 0017 80       		.byte	-128
 11356 0018 80       		.byte	-128
 11357 0019 80       		.byte	-128
 11358 001a 80       		.byte	-128
 11359 001b 00       		.byte	0
 11360 001c 00       		.byte	0
 11361 001d 00       		.byte	0
 11362 001e 00       		.byte	0
 11363 001f 00       		.byte	0
 11364              		.set	.LC66,.LC18
 11365              		.align 16
 11366              	.LC67:
 11367 0020 00       		.byte	0
 11368 0021 01       		.byte	1
 11369 0022 02       		.byte	2
 11370 0023 03       		.byte	3
 11371 0024 04       		.byte	4
 11372 0025 05       		.byte	5
 11373 0026 06       		.byte	6
 11374 0027 07       		.byte	7
 11375 0028 08       		.byte	8
 11376 0029 09       		.byte	9
 11377 002a 0A       		.byte	10
 11378 002b 01       		.byte	1
 11379 002c 04       		.byte	4
 11380 002d 07       		.byte	7
 11381 002e 0A       		.byte	10
 11382 002f 0D       		.byte	13
 11383              		.align 16
 11384              	.LC68:
 11385 0030 00       		.byte	0
 11386 0031 00       		.byte	0
 11387 0032 00       		.byte	0
 11388 0033 00       		.byte	0
 11389 0034 00       		.byte	0
 11390 0035 00       		.byte	0
 11391 0036 00       		.byte	0
 11392 0037 00       		.byte	0
 11393 0038 00       		.byte	0
 11394 0039 00       		.byte	0
 11395 003a 00       		.byte	0
 11396 003b FF       		.byte	-1
 11397 003c FF       		.byte	-1
 11398 003d FF       		.byte	-1
 11399 003e FF       		.byte	-1
 11400 003f FF       		.byte	-1
 11401              		.align 16
 11402              	.LC69:
 11403 0040 01       		.byte	1
 11404 0041 04       		.byte	4
 11405 0042 07       		.byte	7
 11406 0043 0A       		.byte	10
 11407 0044 0D       		.byte	13
 11408 0045 80       		.byte	-128
 11409 0046 80       		.byte	-128
 11410 0047 80       		.byte	-128
 11411 0048 80       		.byte	-128
 11412 0049 80       		.byte	-128
 11413 004a 80       		.byte	-128
 11414 004b 00       		.byte	0
 11415 004c 00       		.byte	0
 11416 004d 00       		.byte	0
 11417 004e 00       		.byte	0
 11418 004f 00       		.byte	0
 11419              		.set	.LC70,.LC21+16
 11420              		.align 16
 11421              	.LC71:
 11422 0050 00       		.byte	0
 11423 0051 01       		.byte	1
 11424 0052 02       		.byte	2
 11425 0053 03       		.byte	3
 11426 0054 04       		.byte	4
 11427 0055 05       		.byte	5
 11428 0056 06       		.byte	6
 11429 0057 07       		.byte	7
 11430 0058 08       		.byte	8
 11431 0059 09       		.byte	9
 11432 005a 0A       		.byte	10
 11433 005b 02       		.byte	2
 11434 005c 05       		.byte	5
 11435 005d 08       		.byte	8
 11436 005e 0B       		.byte	11
 11437 005f 0E       		.byte	14
 11438              		.align 16
 11439              	.LC72:
 11440 0060 02       		.byte	2
 11441 0061 05       		.byte	5
 11442 0062 08       		.byte	8
 11443 0063 0B       		.byte	11
 11444 0064 0E       		.byte	14
 11445 0065 80       		.byte	-128
 11446 0066 80       		.byte	-128
 11447 0067 80       		.byte	-128
 11448 0068 80       		.byte	-128
 11449 0069 80       		.byte	-128
 11450 006a 00       		.byte	0
 11451 006b 00       		.byte	0
 11452 006c 00       		.byte	0
 11453 006d 00       		.byte	0
 11454 006e 00       		.byte	0
 11455 006f 00       		.byte	0
 11456              		.set	.LC73,.LC30
 11457              		.align 16
 11458              	.LC74:
 11459 0070 00       		.byte	0
 11460 0071 01       		.byte	1
 11461 0072 02       		.byte	2
 11462 0073 03       		.byte	3
 11463 0074 04       		.byte	4
 11464 0075 05       		.byte	5
 11465 0076 06       		.byte	6
 11466 0077 07       		.byte	7
 11467 0078 08       		.byte	8
 11468 0079 09       		.byte	9
 11469 007a 00       		.byte	0
 11470 007b 03       		.byte	3
 11471 007c 06       		.byte	6
 11472 007d 09       		.byte	9
 11473 007e 0C       		.byte	12
 11474 007f 0F       		.byte	15
 11475              		.align 16
 11476              	.LC81:
 11477 0080 FFFF0000 		.long	65535
 11478 0084 FFFF0000 		.long	65535
 11479 0088 FFFF0000 		.long	65535
 11480 008c FFFF0000 		.long	65535
 11481              		.align 16
 11482              	.LC89:
 11483 0090 00       		.byte	0
 11484 0091 01       		.byte	1
 11485 0092 00       		.byte	0
 11486 0093 02       		.byte	2
 11487 0094 03       		.byte	3
 11488 0095 00       		.byte	0
 11489 0096 04       		.byte	4
 11490 0097 05       		.byte	5
 11491 0098 00       		.byte	0
 11492 0099 06       		.byte	6
 11493 009a 07       		.byte	7
 11494 009b 00       		.byte	0
 11495 009c 08       		.byte	8
 11496 009d 09       		.byte	9
 11497 009e 00       		.byte	0
 11498 009f 0A       		.byte	10
 11499              		.align 16
 11500              	.LC90:
 11501 00a0 00       		.byte	0
 11502 00a1 01       		.byte	1
 11503 00a2 00       		.byte	0
 11504 00a3 03       		.byte	3
 11505 00a4 04       		.byte	4
 11506 00a5 01       		.byte	1
 11507 00a6 06       		.byte	6
 11508 00a7 07       		.byte	7
 11509 00a8 02       		.byte	2
 11510 00a9 09       		.byte	9
 11511 00aa 0A       		.byte	10
 11512 00ab 03       		.byte	3
 11513 00ac 0C       		.byte	12
 11514 00ad 0D       		.byte	13
 11515 00ae 04       		.byte	4
 11516 00af 0F       		.byte	15
 11517              		.align 16
 11518              	.LC91:
 11519 00b0 00       		.byte	0
 11520 00b1 00       		.byte	0
 11521 00b2 FF       		.byte	-1
 11522 00b3 00       		.byte	0
 11523 00b4 00       		.byte	0
 11524 00b5 FF       		.byte	-1
 11525 00b6 00       		.byte	0
 11526 00b7 00       		.byte	0
 11527 00b8 FF       		.byte	-1
 11528 00b9 00       		.byte	0
 11529 00ba 00       		.byte	0
 11530 00bb FF       		.byte	-1
 11531 00bc 00       		.byte	0
 11532 00bd 00       		.byte	0
 11533 00be FF       		.byte	-1
 11534 00bf 00       		.byte	0
 11535              		.set	.LC92,.LC47
 11536              		.set	.LC93,.LC46
 11537              		.align 16
 11538              	.LC94:
 11539 00c0 00       		.byte	0
 11540 00c1 05       		.byte	5
 11541 00c2 02       		.byte	2
 11542 00c3 03       		.byte	3
 11543 00c4 06       		.byte	6
 11544 00c5 05       		.byte	5
 11545 00c6 06       		.byte	6
 11546 00c7 07       		.byte	7
 11547 00c8 08       		.byte	8
 11548 00c9 09       		.byte	9
 11549 00ca 08       		.byte	8
 11550 00cb 0B       		.byte	11
 11551 00cc 0C       		.byte	12
 11552 00cd 09       		.byte	9
 11553 00ce 0E       		.byte	14
 11554 00cf 0F       		.byte	15
 11555              		.align 16
 11556              	.LC95:
 11557 00d0 00       		.byte	0
 11558 00d1 FF       		.byte	-1
 11559 00d2 00       		.byte	0
 11560 00d3 00       		.byte	0
 11561 00d4 FF       		.byte	-1
 11562 00d5 00       		.byte	0
 11563 00d6 00       		.byte	0
 11564 00d7 FF       		.byte	-1
 11565 00d8 00       		.byte	0
 11566 00d9 00       		.byte	0
 11567 00da FF       		.byte	-1
 11568 00db 00       		.byte	0
 11569 00dc 00       		.byte	0
 11570 00dd FF       		.byte	-1
 11571 00de 00       		.byte	0
 11572 00df 00       		.byte	0
 11573              		.set	.LC96,.LC54
 11574              		.set	.LC97,.LC55
 11575              		.align 16
 11576              	.LC98:
 11577 00e0 0A       		.byte	10
 11578 00e1 01       		.byte	1
 11579 00e2 02       		.byte	2
 11580 00e3 0B       		.byte	11
 11581 00e4 04       		.byte	4
 11582 00e5 05       		.byte	5
 11583 00e6 0C       		.byte	12
 11584 00e7 07       		.byte	7
 11585 00e8 08       		.byte	8
 11586 00e9 0D       		.byte	13
 11587 00ea 0A       		.byte	10
 11588 00eb 0B       		.byte	11
 11589 00ec 0E       		.byte	14
 11590 00ed 0D       		.byte	13
 11591 00ee 0E       		.byte	14
 11592 00ef 0F       		.byte	15
 11593              		.set	.LC99,.LC57
 11594              		.section	.rodata.cst8,"aM",@progbits,8
 11595              		.align 8
 11596              	.LC102:
 11597 0000 00000000 		.long	0
 11598 0004 0000E03F 		.long	1071644672
 11599              		.section	.rodata.cst4
 11600              		.align 4
 11601              	.LC106:
 11602 0004 0000003F 		.long	1056964608
 11603              		.set	.LC112,.LC81
 11604              		.set	.LC114,.LC57+2
 11605              		.text
 11606              	.Letext0:
 11607              		.file 2 "jpeg_handler.h"
 11608              		.file 3 "/opt/rh/gcc-toolset-12/root/usr/lib/gcc/x86_64-redhat-linux/12/include/stddef.h"
 11609              		.file 4 "/usr/include/malloc.h"
 11610              		.file 5 "misc.h"
 11611              		.file 6 "/usr/include/stdlib.h"
 11612              		.file 7 "include/jpeglib.h"
 11613              		.file 8 "<built-in>"
