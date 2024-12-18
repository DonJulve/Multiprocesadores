 GNU assembler version 2.38 (x86_64-redhat-linux)
	 using BFD version version 2.38-16.el8.
 options passed	: --64 -adghln=assembler/misc.gcc.s 
 input file    	: /tmp/ccT38WIp.s
 output file   	: misc.o
 target        	: x86_64-redhat-linux-gnu
 time stamp    	: 2024-03-14T14:24:41.000+0100

   1              		.file	"misc.c"
   2              		.text
   3              	.Ltext0:
   4              		.file 1 "misc.c"
   5              		.p2align 4
   6              		.globl	get_wall_time
   8              	get_wall_time:
   9              	.LFB22:
   1:misc.c        **** /* Adaptado: Jesús Alastruey Benedé
   2:misc.c        ****  * v1.0, 28-abril-2016
   3:misc.c        ****  * v1.1, 24-marzo-2017
   4:misc.c        ****  * v1.2, 15-marzo-2018 */
   5:misc.c        **** 
   6:misc.c        **** #include <stdio.h>
   7:misc.c        **** #include <stdlib.h>
   8:misc.c        **** #include <time.h>
   9:misc.c        **** #include <sys/time.h>
  10:misc.c        **** #include <sys/times.h>
  11:misc.c        **** #include <malloc.h>
  12:misc.c        **** 
  13:misc.c        **** #include "jpeg_handler.h"
  14:misc.c        **** #include "include/jpeglib.h"
  15:misc.c        **** #include "misc.h"
  16:misc.c        **** 
  17:misc.c        **** //----------------------------------------------------------------------------
  18:misc.c        **** 
  19:misc.c        **** int dummy(image_t *im1, image_t *im2);
  20:misc.c        **** 
  21:misc.c        **** //----------------------------------------------------------------------------
  22:misc.c        **** 
  23:misc.c        **** /* inhibimos el inlining
  24:misc.c        ****  * para que el ensamblador sea más cómodo de leer */
  25:misc.c        **** 
  26:misc.c        **** /* return wall time in seconds */
  27:misc.c        **** __attribute__ ((noinline))
  28:misc.c        **** double
  29:misc.c        **** get_wall_time()
  30:misc.c        **** {
  10              		.loc 1 30 1 view -0
  11              		.cfi_startproc
  31:misc.c        ****     struct timeval time;
  12              		.loc 1 31 5 view .LVU1
  32:misc.c        ****     if (gettimeofday(&time,NULL)) {
  13              		.loc 1 32 5 view .LVU2
  30:misc.c        ****     struct timeval time;
  14              		.loc 1 30 1 is_stmt 0 view .LVU3
  15 0000 4883EC18 		subq	$24, %rsp
  16              		.cfi_def_cfa_offset 32
  17              		.loc 1 32 9 view .LVU4
  18 0004 31F6     		xorl	%esi, %esi
  19 0006 4889E7   		movq	%rsp, %rdi
  20 0009 E8000000 		call	gettimeofday
  20      00
  21              	.LVL0:
  22              		.loc 1 32 8 view .LVU5
  23 000e 85C0     		testl	%eax, %eax
  24 0010 751F     		jne	.L5
  33:misc.c        ****         exit(-1); // return 0;
  34:misc.c        ****     }
  35:misc.c        ****     return (double)time.tv_sec + (double)time.tv_usec * .000001;
  25              		.loc 1 35 5 is_stmt 1 view .LVU6
  26 0012 C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
  27              		.loc 1 35 34 is_stmt 0 view .LVU7
  28 0016 C4E1F32A 		vcvtsi2sdq	8(%rsp), %xmm1, %xmm0
  28      442408
  29              		.loc 1 35 12 view .LVU8
  30 001d C4E1F32A 		vcvtsi2sdq	(%rsp), %xmm1, %xmm1
  30      0C24
  31              		.loc 1 35 32 view .LVU9
  32 0023 C4E2F199 		vfmadd132sd	.LC0(%rip), %xmm1, %xmm0
  32      05000000 
  32      00
  36:misc.c        **** }
  33              		.loc 1 36 1 view .LVU10
  34 002c 4883C418 		addq	$24, %rsp
  35              		.cfi_remember_state
  36              		.cfi_def_cfa_offset 8
  37 0030 C3       		ret
  38              	.L5:
  39              		.cfi_restore_state
  33:misc.c        ****         exit(-1); // return 0;
  40              		.loc 1 33 9 is_stmt 1 view .LVU11
  41 0031 83CFFF   		orl	$-1, %edi
  42 0034 E8000000 		call	exit
  42      00
  43              	.LVL1:
  44              		.cfi_endproc
  45              	.LFE22:
  47 0039 0F1F8000 		.p2align 4
  47      000000
  48              		.globl	get_cpu_time
  50              	get_cpu_time:
  51              	.LFB23:
  37:misc.c        **** //----------------------------------------------------------------------------
  38:misc.c        **** 
  39:misc.c        **** /* return cpu time in seconds */
  40:misc.c        **** __attribute__ ((noinline))
  41:misc.c        **** double
  42:misc.c        **** get_cpu_time()
  43:misc.c        **** {
  52              		.loc 1 43 1 view -0
  53              		.cfi_startproc
  44:misc.c        ****     return (double) clock() / CLOCKS_PER_SEC;
  54              		.loc 1 44 5 view .LVU13
  43:misc.c        ****     return (double) clock() / CLOCKS_PER_SEC;
  55              		.loc 1 43 1 is_stmt 0 view .LVU14
  56 0040 4883EC08 		subq	$8, %rsp
  57              		.cfi_def_cfa_offset 16
  58              		.loc 1 44 21 view .LVU15
  59 0044 E8000000 		call	clock
  59      00
  60              	.LVL2:
  61              		.loc 1 44 12 view .LVU16
  62 0049 C5F857C0 		vxorps	%xmm0, %xmm0, %xmm0
  63 004d C4E1FB2A 		vcvtsi2sdq	%rax, %xmm0, %xmm0
  63      C0
  64              		.loc 1 44 29 view .LVU17
  65 0052 C5FB5905 		vmulsd	.LC0(%rip), %xmm0, %xmm0
  65      00000000 
  45:misc.c        **** }
  66              		.loc 1 45 1 view .LVU18
  67 005a 4883C408 		addq	$8, %rsp
  68              		.cfi_def_cfa_offset 8
  69 005e C3       		ret
  70              		.cfi_endproc
  71              	.LFE23:
  73              		.section	.rodata.str1.8,"aMS",@progbits,1
  74              		.align 8
  75              	.LC4:
  76 0000 25313873 		.string	"%18s  %5.1f    %4.1f       %4.2f \n"
  76      20202535 
  76      2E316620 
  76      20202025 
  76      342E3166 
  77              		.text
  78 005f 90       		.p2align 4
  79              		.globl	results
  81              	results:
  82              	.LVL3:
  83              	.LFB24:
  46:misc.c        **** //----------------------------------------------------------------------------
  47:misc.c        **** 
  48:misc.c        **** /* inhibimos el inlining de algunas funciones
  49:misc.c        ****  * para que el ensamblador sea más cómodo de leer */
  50:misc.c        **** __attribute__ ((noinline))
  51:misc.c        **** void results(double wall_time, int npixels, char *loop)
  52:misc.c        **** {
  84              		.loc 1 52 1 is_stmt 1 view -0
  85              		.cfi_startproc
  53:misc.c        ****   // printf("                  Time\n");
  54:misc.c        ****   // printf("función            (s)    ns/pix  Gpixels/s\n");
  55:misc.c        **** 
  56:misc.c        ****   printf("%18s  %5.1f    %4.1f       %4.2f \n",
  86              		.loc 1 56 3 view .LVU20
  57:misc.c        ****           loop /* nombre del bucle */,
  58:misc.c        ****           (1e3)*wall_time/NITER,
  59:misc.c        ****           (1e9)*wall_time/(NITER*npixels)  /* ns/pixel */,
  60:misc.c        ****           (NITER*npixels)/(wall_time*(1e9)) /* Gpixels por segundo */);
  87              		.loc 1 60 17 is_stmt 0 view .LVU21
  88 0060 8D04BF   		leal	(%rdi,%rdi,4), %eax
  89 0063 01C0     		addl	%eax, %eax
  90              		.loc 1 60 26 view .LVU22
  91 0065 C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
  92 0069 C5F32AC8 		vcvtsi2sdl	%eax, %xmm1, %xmm1
  59:misc.c        ****           (NITER*npixels)/(wall_time*(1e9)) /* Gpixels por segundo */);
  93              		.loc 1 59 16 view .LVU23
  94 006d C5FB5925 		vmulsd	.LC2(%rip), %xmm0, %xmm4
  94      00000000 
  56:misc.c        ****           loop /* nombre del bucle */,
  95              		.loc 1 56 3 view .LVU24
  96 0075 C5FB591D 		vmulsd	.LC3(%rip), %xmm0, %xmm3
  96      00000000 
  97 007d BF000000 		movl	$.LC4, %edi
  97      00
  98              	.LVL4:
  99              		.loc 1 60 26 view .LVU25
 100 0082 C5F35915 		vmulsd	.LC1(%rip), %xmm1, %xmm2
 100      00000000 
  56:misc.c        ****           loop /* nombre del bucle */,
 101              		.loc 1 56 3 view .LVU26
 102 008a B8030000 		movl	$3, %eax
 102      00
 103 008f C5DB5EC9 		vdivsd	%xmm1, %xmm4, %xmm1
 104 0093 C5EB5ED0 		vdivsd	%xmm0, %xmm2, %xmm2
 105 0097 C5E310C3 		vmovsd	%xmm3, %xmm3, %xmm0
 106              	.LVL5:
  56:misc.c        ****           loop /* nombre del bucle */,
 107              		.loc 1 56 3 view .LVU27
 108 009b E9000000 		jmp	printf
 108      00
 109              	.LVL6:
  56:misc.c        ****           loop /* nombre del bucle */,
 110              		.loc 1 56 3 view .LVU28
 111              		.cfi_endproc
 112              	.LFE24:
 114              		.section	.rodata.str1.1,"aMS",@progbits,1
 115              	.LC5:
 116 0000 4F4B00   		.string	"OK"
 117              	.LC6:
 118 0003 4552524F 		.string	"ERROR"
 118      5200
 119              		.section	.rodata.str1.8
 120 0023 00000000 		.align 8
 120      00
 121              	.LC8:
 122 0028 4552524F 		.string	"ERROR: input image has to be RGB or YCbCr"
 122      523A2069 
 122      6E707574 
 122      20696D61 
 122      67652068 
 123              		.section	.rodata.str1.1
 124              	.LC9:
 125 0009 636D7043 		.string	"cmpColor"
 125      6F6C6F72 
 125      00
 126              		.section	.rodata.str1.8
 127 0052 00000000 		.align 8
 127      0000
 128              	.LC10:
 129 0058 25313873 		.string	"%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n"
 129      20202535 
 129      2E316620 
 129      20202025 
 129      342E3166 
 130 009b 00000000 		.align 8
 130      00
 131              	.LC11:
 132 00a0 20202020 		.string	"        funci\303\263n      Time    ns/px    Gpixels/s  %%diff  max_dif  (max_idx)\n"
 132      20202020 
 132      66756E63 
 132      69C3B36E 
 132      20202020 
 133              		.section	.rodata.str1.1
 134              	.LC12:
 135 0012 20202020 		.string	"                     (ms)"
 135      20202020 
 135      20202020 
 135      20202020 
 135      20202020 
 136              		.text
 137              		.p2align 4
 138              		.globl	cmpColor
 140              	cmpColor:
 141              	.LVL7:
 142              	.LFB25:
  61:misc.c        **** }
  62:misc.c        **** //----------------------------------------------------------------------------
  63:misc.c        **** 
  64:misc.c        **** int
  65:misc.c        **** cmpColor(image_t * image_in1, image_t * image_in2, image_t * image_out)
  66:misc.c        **** {
 143              		.loc 1 66 1 is_stmt 1 view -0
 144              		.cfi_startproc
  67:misc.c        ****     double start_t, end_t, wall_dif;
 145              		.loc 1 67 5 view .LVU30
  68:misc.c        ****     const int height = image_in1->height;
 146              		.loc 1 68 5 view .LVU31
  66:misc.c        ****     double start_t, end_t, wall_dif;
 147              		.loc 1 66 1 is_stmt 0 view .LVU32
 148 00a0 4157     		pushq	%r15
 149              		.cfi_def_cfa_offset 16
 150              		.cfi_offset 15, -16
 151 00a2 4889F1   		movq	%rsi, %rcx
 152 00a5 4889D6   		movq	%rdx, %rsi
 153              	.LVL8:
  66:misc.c        ****     double start_t, end_t, wall_dif;
 154              		.loc 1 66 1 view .LVU33
 155 00a8 4156     		pushq	%r14
 156              		.cfi_def_cfa_offset 24
 157              		.cfi_offset 14, -24
 158 00aa 4155     		pushq	%r13
 159              		.cfi_def_cfa_offset 32
 160              		.cfi_offset 13, -32
 161 00ac 4154     		pushq	%r12
 162              		.cfi_def_cfa_offset 40
 163              		.cfi_offset 12, -40
 164 00ae 55       		pushq	%rbp
 165              		.cfi_def_cfa_offset 48
 166              		.cfi_offset 6, -48
 167 00af 53       		pushq	%rbx
 168              		.cfi_def_cfa_offset 56
 169              		.cfi_offset 3, -56
 170 00b0 4883EC28 		subq	$40, %rsp
 171              		.cfi_def_cfa_offset 96
  69:misc.c        ****     const int width =  image_in1->width;
 172              		.loc 1 69 15 view .LVU34
 173 00b4 C5FA7E47 		vmovq	8(%rdi), %xmm0
 173      08
  70:misc.c        ****     const int color_space =  image_in1->color_space;
  71:misc.c        ****     unsigned char * pixels_in1 = image_in1->pixels;
  72:misc.c        ****     unsigned char * pixels_in2 = image_in2->pixels;
  73:misc.c        ****     unsigned char * pixels_out = image_out->pixels;
  74:misc.c        ****     int max_idx, diff;
  75:misc.c        ****     char max_diff; /* can be negative */
  76:misc.c        **** 
  77:misc.c        ****     if (image_in1->bytes_per_pixel != 3)
 174              		.loc 1 77 8 view .LVU35
 175 00b9 837F1003 		cmpl	$3, 16(%rdi)
  70:misc.c        ****     const int color_space =  image_in1->color_space;
 176              		.loc 1 70 15 view .LVU36
 177 00bd 8B4714   		movl	20(%rdi), %eax
  71:misc.c        ****     unsigned char * pixels_in2 = image_in2->pixels;
 178              		.loc 1 71 21 view .LVU37
 179 00c0 4C8B37   		movq	(%rdi), %r14
  72:misc.c        ****     unsigned char * pixels_out = image_out->pixels;
 180              		.loc 1 72 21 view .LVU38
 181 00c3 4C8B39   		movq	(%rcx), %r15
  73:misc.c        ****     int max_idx, diff;
 182              		.loc 1 73 21 view .LVU39
 183 00c6 488B12   		movq	(%rdx), %rdx
 184              	.LVL9:
  73:misc.c        ****     int max_idx, diff;
 185              		.loc 1 73 21 view .LVU40
 186 00c9 C4E37916 		vpextrd	$1, %xmm0, %ebx
 186      C301
 187              	.LVL10:
  69:misc.c        ****     const int color_space =  image_in1->color_space;
 188              		.loc 1 69 5 is_stmt 1 view .LVU41
  70:misc.c        ****     unsigned char * pixels_in1 = image_in1->pixels;
 189              		.loc 1 70 5 view .LVU42
  71:misc.c        ****     unsigned char * pixels_in2 = image_in2->pixels;
 190              		.loc 1 71 5 view .LVU43
  72:misc.c        ****     unsigned char * pixels_out = image_out->pixels;
 191              		.loc 1 72 5 view .LVU44
  73:misc.c        ****     int max_idx, diff;
 192              		.loc 1 73 5 view .LVU45
  74:misc.c        ****     char max_diff; /* can be negative */
 193              		.loc 1 74 5 view .LVU46
  75:misc.c        **** 
 194              		.loc 1 75 5 view .LVU47
 195              		.loc 1 77 5 view .LVU48
 196              		.loc 1 77 8 is_stmt 0 view .LVU49
 197 00cf 0F858301 		jne	.L19
 197      0000
  78:misc.c        ****     {
  79:misc.c        ****         printf("ERROR: input image has to be RGB or YCbCr\n");
  80:misc.c        ****         exit(-1);
  81:misc.c        ****     }
  82:misc.c        **** 
  83:misc.c        ****     /* fill struct fields */
  84:misc.c        ****     image_out->width  = width;
  85:misc.c        ****     image_out->height = height;
  86:misc.c        ****     image_out->bytes_per_pixel = 3;
  87:misc.c        ****     image_out->color_space = color_space;
 198              		.loc 1 87 28 view .LVU50
 199 00d5 894614   		movl	%eax, 20(%rsi)
  86:misc.c        ****     image_out->color_space = color_space;
 200              		.loc 1 86 32 view .LVU51
 201 00d8 C7461003 		movl	$3, 16(%rsi)
 201      000000
 202 00df C5F97EC5 		vmovd	%xmm0, %ebp
  84:misc.c        ****     image_out->height = height;
 203              		.loc 1 84 23 view .LVU52
 204 00e3 C5F9D646 		vmovq	%xmm0, 8(%rsi)
 204      08
 205              	.LVL11:
  88:misc.c        ****     // image_out->color_space = JCS_RGB;
  89:misc.c        **** 
  90:misc.c        ****     start_t = get_wall_time();
 206              		.loc 1 90 15 view .LVU53
 207 00e8 31C0     		xorl	%eax, %eax
 208              	.LVL12:
 209              		.loc 1 90 15 view .LVU54
 210 00ea 48897C24 		movq	%rdi, 8(%rsp)
 210      08
  87:misc.c        ****     // image_out->color_space = JCS_RGB;
 211              		.loc 1 87 28 view .LVU55
 212 00ef 48893424 		movq	%rsi, (%rsp)
 213 00f3 48895424 		movq	%rdx, 24(%rsp)
 213      18
  84:misc.c        ****     image_out->height = height;
 214              		.loc 1 84 5 is_stmt 1 view .LVU56
  85:misc.c        ****     image_out->bytes_per_pixel = 3;
 215              		.loc 1 85 5 view .LVU57
  86:misc.c        ****     image_out->color_space = color_space;
 216              		.loc 1 86 5 view .LVU58
  87:misc.c        ****     // image_out->color_space = JCS_RGB;
 217              		.loc 1 87 5 view .LVU59
 218              		.loc 1 90 5 view .LVU60
 219              		.loc 1 90 15 is_stmt 0 view .LVU61
 220 00f8 E8000000 		call	get_wall_time
 220      00
 221              	.LVL13:
 222              	.LBB2:
 223              	.LBB3:
  91:misc.c        ****     for (int it = 0; it < NITER/10; it++)
  92:misc.c        ****     {
  93:misc.c        ****         max_diff = 0; max_idx = -1; diff = 0;
  94:misc.c        ****         for (int i = 0; i < 3*height*width; i++)
 224              		.loc 1 94 37 view .LVU62
 225 00fd 4189E9   		movl	%ebp, %r9d
 226 0100 440FAFCB 		imull	%ebx, %r9d
 227              		.loc 1 94 27 view .LVU63
 228 0104 488B3424 		movq	(%rsp), %rsi
 229 0108 488B7C24 		movq	8(%rsp), %rdi
 229      08
 230 010d 4585C9   		testl	%r9d, %r9d
 231              	.LBE3:
 232              	.LBE2:
  90:misc.c        ****     for (int it = 0; it < NITER/10; it++)
 233              		.loc 1 90 15 view .LVU64
 234 0110 C5FB1144 		vmovsd	%xmm0, 16(%rsp)
 234      2410
 235              	.LVL14:
  91:misc.c        ****     for (int it = 0; it < NITER/10; it++)
 236              		.loc 1 91 5 is_stmt 1 view .LVU65
 237              	.LBB8:
  91:misc.c        ****     for (int it = 0; it < NITER/10; it++)
 238              		.loc 1 91 10 view .LVU66
  91:misc.c        ****     for (int it = 0; it < NITER/10; it++)
 239              		.loc 1 91 25 view .LVU67
 240              	.LBB4:
 241              		.loc 1 94 27 view .LVU68
 242              		.loc 1 94 37 is_stmt 0 view .LVU69
 243 0116 478D2449 		leal	(%r9,%r9,2), %r12d
 244              		.loc 1 94 27 view .LVU70
 245 011a 0F8E0801 		jle	.L11
 245      0000
 246              	.LBE4:
  93:misc.c        ****         for (int i = 0; i < 3*height*width; i++)
 247              		.loc 1 93 31 view .LVU71
 248 0120 488B5424 		movq	24(%rsp), %rdx
 248      18
 249              	.LBB5:
 250              		.loc 1 94 27 view .LVU72
 251 0125 4531C0   		xorl	%r8d, %r8d
 252              	.LBE5:
  93:misc.c        ****         for (int i = 0; i < 3*height*width; i++)
 253              		.loc 1 93 18 view .LVU73
 254 0128 31ED     		xorl	%ebp, %ebp
  93:misc.c        ****         for (int i = 0; i < 3*height*width; i++)
 255              		.loc 1 93 42 view .LVU74
 256 012a 4531ED   		xorl	%r13d, %r13d
  93:misc.c        ****         for (int i = 0; i < 3*height*width; i++)
 257              		.loc 1 93 31 view .LVU75
 258 012d B9FFFFFF 		movl	$-1, %ecx
 258      FF
 259              	.LVL15:
 260              		.p2align 4,,10
 261 0132 660F1F44 		.p2align 3
 261      0000
 262              	.L13:
 263              	.LBB6:
  95:misc.c        ****         {
  96:misc.c        ****             pixels_out[i] = abs(pixels_in1[i] - pixels_in2[i]);
 264              		.loc 1 96 13 is_stmt 1 view .LVU76
 265              		.loc 1 96 59 is_stmt 0 view .LVU77
 266 0138 430FB61C 		movzbl	(%r15,%r8), %ebx
 266      07
 267              		.loc 1 96 43 view .LVU78
 268 013d 430FB604 		movzbl	(%r14,%r8), %eax
 268      06
 269              		.loc 1 96 59 view .LVU79
 270 0142 4189DB   		movl	%ebx, %r11d
 271              		.loc 1 96 43 view .LVU80
 272 0145 4189C2   		movl	%eax, %r10d
 273              		.loc 1 96 47 view .LVU81
 274 0148 29D8     		subl	%ebx, %eax
 275              		.loc 1 96 29 view .LVU82
 276 014a 89C3     		movl	%eax, %ebx
 277 014c C1FB1F   		sarl	$31, %ebx
 278 014f 31D8     		xorl	%ebx, %eax
 279 0151 29D8     		subl	%ebx, %eax
 280              		.loc 1 96 27 view .LVU83
 281 0153 42880402 		movb	%al, (%rdx,%r8)
  97:misc.c        ****             if (pixels_out[i] != 0)
 282              		.loc 1 97 13 is_stmt 1 view .LVU84
  98:misc.c        ****             {
  99:misc.c        ****                 diff++;
 100:misc.c        ****                 if (pixels_out[i] > max_diff)
 283              		.loc 1 100 35 is_stmt 0 view .LVU85
 284 0157 400FBEDD 		movsbl	%bpl, %ebx
  97:misc.c        ****             if (pixels_out[i] != 0)
 285              		.loc 1 97 16 view .LVU86
 286 015b 4538D3   		cmpb	%r10b, %r11b
 287 015e 740F     		je	.L12
  99:misc.c        ****                 if (pixels_out[i] > max_diff)
 288              		.loc 1 99 17 is_stmt 1 view .LVU87
  99:misc.c        ****                 if (pixels_out[i] > max_diff)
 289              		.loc 1 99 21 is_stmt 0 view .LVU88
 290 0160 41FFC5   		incl	%r13d
 291              	.LVL16:
 292              		.loc 1 100 17 is_stmt 1 view .LVU89
 293              		.loc 1 100 20 is_stmt 0 view .LVU90
 294 0163 39D8     		cmpl	%ebx, %eax
 295 0165 7E08     		jle	.L12
 296 0167 4489C1   		movl	%r8d, %ecx
 297              	.LVL17:
 101:misc.c        ****                 {
 102:misc.c        ****                     max_diff = pixels_out[i];
 298              		.loc 1 102 21 is_stmt 1 view .LVU91
 299              		.loc 1 102 30 is_stmt 0 view .LVU92
 300 016a 89C5     		movl	%eax, %ebp
 301              	.LVL18:
 103:misc.c        ****                     max_idx = i;
 302              		.loc 1 103 21 is_stmt 1 view .LVU93
 303              		.loc 1 103 21 is_stmt 0 view .LVU94
 304              	.LBE6:
 305              	.LBE8:
 104:misc.c        ****                 }
 105:misc.c        ****             }
 106:misc.c        ****         }
 107:misc.c        ****         dummy(image_in1, image_out);
 108:misc.c        ****     }
 109:misc.c        ****     end_t = get_wall_time(); wall_dif = end_t - start_t;
 110:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 306              		.loc 1 110 5 view .LVU95
 307 016c 0FBED8   		movsbl	%al, %ebx
 308              	.LVL19:
 309              	.L12:
 310              	.LBB9:
 311              	.LBB7:
  94:misc.c        ****         {
 312              		.loc 1 94 46 is_stmt 1 view .LVU96
  94:misc.c        ****         {
 313              		.loc 1 94 27 view .LVU97
 314 016f 49FFC0   		incq	%r8
 315              	.LVL20:
  94:misc.c        ****         {
 316              		.loc 1 94 27 is_stmt 0 view .LVU98
 317 0172 4539C4   		cmpl	%r8d, %r12d
 318 0175 7FC1     		jg	.L13
  94:misc.c        ****         {
 319              		.loc 1 94 27 view .LVU99
 320              	.LBE7:
 107:misc.c        ****     }
 321              		.loc 1 107 9 discriminator 2 view .LVU100
 322 0177 44894C24 		movl	%r9d, 8(%rsp)
 322      08
 323              	.LVL21:
 107:misc.c        ****     }
 324              		.loc 1 107 9 discriminator 2 view .LVU101
 325 017c 890C24   		movl	%ecx, (%rsp)
 326              	.LVL22:
 107:misc.c        ****     }
 327              		.loc 1 107 9 is_stmt 1 discriminator 2 view .LVU102
 328 017f E8000000 		call	dummy
 328      00
 329              	.LVL23:
  91:misc.c        ****     {
 330              		.loc 1 91 39 discriminator 2 view .LVU103
  91:misc.c        ****     {
 331              		.loc 1 91 25 discriminator 2 view .LVU104
 332              	.LBE9:
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 333              		.loc 1 109 5 discriminator 2 view .LVU105
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 334              		.loc 1 109 13 is_stmt 0 discriminator 2 view .LVU106
 335 0184 31C0     		xorl	%eax, %eax
 336 0186 E8000000 		call	get_wall_time
 336      00
 337              	.LVL24:
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 338              		.loc 1 109 30 is_stmt 1 discriminator 2 view .LVU107
 111:misc.c        ****            "cmpColor",
 112:misc.c        ****            wall_dif, wall_dif*1e9/(NITER/10*height*width),
 113:misc.c        ****            (NITER/10*height*width)/(1e9*wall_dif), (double) 100.0*diff/(3*height*width),
 339              		.loc 1 113 66 is_stmt 0 discriminator 2 view .LVU108
 340 018b C5C157FF 		vxorpd	%xmm7, %xmm7, %xmm7
 341 018f C4C1432A 		vcvtsi2sdl	%r13d, %xmm7, %xmm4
 341      E5
 110:misc.c        ****            "cmpColor",
 342              		.loc 1 110 5 discriminator 2 view .LVU109
 343 0194 4084ED   		testb	%bpl, %bpl
 344 0197 41B80000 		movl	$.LC5, %r8d
 344      0000
 345 019d B8000000 		movl	$.LC6, %eax
 345      00
 346              		.loc 1 113 66 discriminator 2 view .LVU110
 347 01a2 C5DB5925 		vmulsd	.LC3(%rip), %xmm4, %xmm4
 347      00000000 
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 348              		.loc 1 109 39 discriminator 2 view .LVU111
 349 01aa C5FB5C44 		vsubsd	16(%rsp), %xmm0, %xmm0
 349      2410
 350              	.LVL25:
 110:misc.c        ****            "cmpColor",
 351              		.loc 1 110 5 is_stmt 1 discriminator 2 view .LVU112
 352 01b0 4C0F45C0 		cmovne	%rax, %r8
 353 01b4 448B4C24 		movl	8(%rsp), %r9d
 353      08
 354 01b9 8B0C24   		movl	(%rsp), %ecx
 355              	.LVL26:
 356              	.L14:
 357              		.loc 1 113 35 is_stmt 0 discriminator 4 view .LVU113
 358 01bc C5C957F6 		vxorpd	%xmm6, %xmm6, %xmm6
 359 01c0 C4C14B2A 		vcvtsi2sdl	%r9d, %xmm6, %xmm1
 359      C9
 112:misc.c        ****            (NITER/10*height*width)/(1e9*wall_dif), (double) 100.0*diff/(3*height*width),
 360              		.loc 1 112 30 discriminator 4 view .LVU114
 361 01c5 C5FB592D 		vmulsd	.LC2(%rip), %xmm0, %xmm5
 361      00000000 
 110:misc.c        ****            "cmpColor",
 362              		.loc 1 110 5 discriminator 4 view .LVU115
 363 01cd C4C14B2A 		vcvtsi2sdl	%r12d, %xmm6, %xmm3
 363      DC
 364 01d2 89DA     		movl	%ebx, %edx
 365              		.loc 1 113 35 discriminator 4 view .LVU116
 366 01d4 C5F35915 		vmulsd	.LC1(%rip), %xmm1, %xmm2
 366      00000000 
 110:misc.c        ****            "cmpColor",
 367              		.loc 1 110 5 discriminator 4 view .LVU117
 368 01dc BE000000 		movl	$.LC9, %esi
 368      00
 369 01e1 C5DB5EDB 		vdivsd	%xmm3, %xmm4, %xmm3
 370 01e5 BF000000 		movl	$.LC10, %edi
 370      00
 371 01ea B8040000 		movl	$4, %eax
 371      00
 372 01ef C5EB5ED0 		vdivsd	%xmm0, %xmm2, %xmm2
 373 01f3 C5D35EC9 		vdivsd	%xmm1, %xmm5, %xmm1
 374 01f7 E8000000 		call	printf
 374      00
 375              	.LVL27:
 114:misc.c        ****            max_diff, max_idx, max_diff == 0? "OK":"ERROR");
 115:misc.c        ****     printf("        función      Time    ns/px    Gpixels/s  %%diff  max_dif  (max_idx)\n");
 376              		.loc 1 115 5 is_stmt 1 discriminator 4 view .LVU118
 377 01fc BF000000 		movl	$.LC11, %edi
 377      00
 378 0201 31C0     		xorl	%eax, %eax
 379 0203 E8000000 		call	printf
 379      00
 380              	.LVL28:
 116:misc.c        ****     printf("                     (ms)\n");
 381              		.loc 1 116 5 discriminator 4 view .LVU119
 382 0208 BF000000 		movl	$.LC12, %edi
 382      00
 383 020d E8000000 		call	puts
 383      00
 384              	.LVL29:
 117:misc.c        ****     return(max_diff);
 385              		.loc 1 117 5 discriminator 4 view .LVU120
 118:misc.c        **** }
 386              		.loc 1 118 1 is_stmt 0 discriminator 4 view .LVU121
 387 0212 4883C428 		addq	$40, %rsp
 388              		.cfi_remember_state
 389              		.cfi_def_cfa_offset 56
 390 0216 89D8     		movl	%ebx, %eax
 391 0218 5B       		popq	%rbx
 392              		.cfi_def_cfa_offset 48
 393 0219 5D       		popq	%rbp
 394              		.cfi_def_cfa_offset 40
 395 021a 415C     		popq	%r12
 396              		.cfi_def_cfa_offset 32
 397 021c 415D     		popq	%r13
 398              		.cfi_def_cfa_offset 24
 399 021e 415E     		popq	%r14
 400              		.cfi_def_cfa_offset 16
 401              	.LVL30:
 402              		.loc 1 118 1 discriminator 4 view .LVU122
 403 0220 415F     		popq	%r15
 404              		.cfi_def_cfa_offset 8
 405              	.LVL31:
 406              		.loc 1 118 1 discriminator 4 view .LVU123
 407 0222 C3       		ret
 408              	.LVL32:
 409              		.p2align 4,,10
 410 0223 0F1F4400 		.p2align 3
 410      00
 411              	.L11:
 412              		.cfi_restore_state
 413              		.loc 1 118 1 discriminator 4 view .LVU124
 414 0228 44890C24 		movl	%r9d, (%rsp)
 415              	.LVL33:
 416              	.LBB10:
 107:misc.c        ****     }
 417              		.loc 1 107 9 is_stmt 1 view .LVU125
 418 022c E8000000 		call	dummy
 418      00
 419              	.LVL34:
  91:misc.c        ****     {
 420              		.loc 1 91 39 view .LVU126
  91:misc.c        ****     {
 421              		.loc 1 91 25 view .LVU127
 422              	.LBE10:
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 423              		.loc 1 109 5 view .LVU128
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 424              		.loc 1 109 13 is_stmt 0 view .LVU129
 425 0231 31C0     		xorl	%eax, %eax
 426 0233 E8000000 		call	get_wall_time
 426      00
 427              	.LVL35:
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 428              		.loc 1 109 30 is_stmt 1 view .LVU130
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 429              		.loc 1 109 39 is_stmt 0 view .LVU131
 430 0238 C5FB5C44 		vsubsd	16(%rsp), %xmm0, %xmm0
 430      2410
 431              	.LVL36:
 110:misc.c        ****            "cmpColor",
 432              		.loc 1 110 5 is_stmt 1 view .LVU132
 433 023e 448B0C24 		movl	(%rsp), %r9d
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 434              		.loc 1 109 39 is_stmt 0 view .LVU133
 435 0242 C5D957E4 		vxorpd	%xmm4, %xmm4, %xmm4
 436 0246 31DB     		xorl	%ebx, %ebx
 437              	.LBB11:
  93:misc.c        ****         for (int i = 0; i < 3*height*width; i++)
 438              		.loc 1 93 31 view .LVU134
 439 0248 B9FFFFFF 		movl	$-1, %ecx
 439      FF
 440              	.LBE11:
 110:misc.c        ****            "cmpColor",
 441              		.loc 1 110 5 view .LVU135
 442 024d 41B80000 		movl	$.LC5, %r8d
 442      0000
 443 0253 E964FFFF 		jmp	.L14
 443      FF
 444              	.LVL37:
 445              	.L19:
  79:misc.c        ****         exit(-1);
 446              		.loc 1 79 9 is_stmt 1 view .LVU136
 447 0258 BF000000 		movl	$.LC8, %edi
 447      00
 448              	.LVL38:
  79:misc.c        ****         exit(-1);
 449              		.loc 1 79 9 is_stmt 0 view .LVU137
 450 025d E8000000 		call	puts
 450      00
 451              	.LVL39:
  80:misc.c        ****     }
 452              		.loc 1 80 9 is_stmt 1 view .LVU138
 453 0262 83CFFF   		orl	$-1, %edi
 454 0265 E8000000 		call	exit
 454      00
 455              	.LVL40:
 456              		.cfi_endproc
 457              	.LFE25:
 459              		.section	.rodata.str1.8
 460 00ee 0000     		.align 8
 461              	.LC13:
 462 00f0 4552524F 		.string	"ERROR: input image has to be GRAY"
 462      523A2069 
 462      6E707574 
 462      20696D61 
 462      67652068 
 463              		.section	.rodata.str1.1
 464              	.LC15:
 465 002c 636D7047 		.string	"cmpGray"
 465      72617900 
 466              		.section	.rodata.str1.8
 467 0112 00000000 		.align 8
 467      0000
 468              	.LC16:
 469 0118 25313873 		.string	"%18s  %5.1f    %4.1f       %4.2f    %5.1f%%  %4hhd (%7d)\n"
 469      20202535 
 469      2E316620 
 469      20202025 
 469      342E3166 
 470 0152 00000000 		.align 8
 470      0000
 471              	.LC17:
 472 0158 20202020 		.string	"        funci\303\263n      Time    ns/px    Gpixels/s  %%diff  max_dif (max_idx)\n"
 472      20202020 
 472      66756E63 
 472      69C3B36E 
 472      20202020 
 473              		.text
 474 026a 660F1F44 		.p2align 4
 474      0000
 475              		.globl	cmpGray
 477              	cmpGray:
 478              	.LVL41:
 479              	.LFB26:
 119:misc.c        **** //----------------------------------------------------------------------------
 120:misc.c        **** 
 121:misc.c        **** int
 122:misc.c        **** cmpGray(image_t * image_in1, image_t * image_in2, image_t * image_out)
 123:misc.c        **** {
 480              		.loc 1 123 1 view -0
 481              		.cfi_startproc
 124:misc.c        ****     double start_t, end_t, wall_dif;
 482              		.loc 1 124 5 view .LVU140
 125:misc.c        ****     const int height = image_in1->height;
 483              		.loc 1 125 5 view .LVU141
 123:misc.c        ****     double start_t, end_t, wall_dif;
 484              		.loc 1 123 1 is_stmt 0 view .LVU142
 485 0270 4157     		pushq	%r15
 486              		.cfi_def_cfa_offset 16
 487              		.cfi_offset 15, -16
 488 0272 4156     		pushq	%r14
 489              		.cfi_def_cfa_offset 24
 490              		.cfi_offset 14, -24
 491 0274 4155     		pushq	%r13
 492              		.cfi_def_cfa_offset 32
 493              		.cfi_offset 13, -32
 494 0276 4154     		pushq	%r12
 495              		.cfi_def_cfa_offset 40
 496              		.cfi_offset 12, -40
 497 0278 55       		pushq	%rbp
 498              		.cfi_def_cfa_offset 48
 499              		.cfi_offset 6, -48
 500 0279 53       		pushq	%rbx
 501              		.cfi_def_cfa_offset 56
 502              		.cfi_offset 3, -56
 503 027a 4883EC18 		subq	$24, %rsp
 504              		.cfi_def_cfa_offset 80
 126:misc.c        ****     const int width =  image_in1->width;
 505              		.loc 1 126 15 view .LVU143
 506 027e C5FA7E47 		vmovq	8(%rdi), %xmm0
 506      08
 127:misc.c        ****     unsigned char * pixels_in1 = image_in1->pixels;
 128:misc.c        ****     unsigned char * pixels_in2 = image_in2->pixels;
 129:misc.c        ****     unsigned char * pixels_out = image_out->pixels;
 130:misc.c        ****     int max_idx, diff;
 131:misc.c        ****     char max_gray_diff; /* can be negative */
 132:misc.c        **** 
 133:misc.c        ****     if (image_in1->bytes_per_pixel != 1)
 507              		.loc 1 133 8 view .LVU144
 508 0283 837F1001 		cmpl	$1, 16(%rdi)
 127:misc.c        ****     unsigned char * pixels_in1 = image_in1->pixels;
 509              		.loc 1 127 21 view .LVU145
 510 0287 488B2F   		movq	(%rdi), %rbp
 128:misc.c        ****     unsigned char * pixels_out = image_out->pixels;
 511              		.loc 1 128 21 view .LVU146
 512 028a 4C8B26   		movq	(%rsi), %r12
 129:misc.c        ****     int max_idx, diff;
 513              		.loc 1 129 21 view .LVU147
 514 028d 4C8B2A   		movq	(%rdx), %r13
 515 0290 C4C37916 		vpextrd	$1, %xmm0, %r15d
 515      C701
 516              	.LVL42:
 126:misc.c        ****     unsigned char * pixels_in1 = image_in1->pixels;
 517              		.loc 1 126 5 is_stmt 1 view .LVU148
 127:misc.c        ****     unsigned char * pixels_in2 = image_in2->pixels;
 518              		.loc 1 127 5 view .LVU149
 128:misc.c        ****     unsigned char * pixels_out = image_out->pixels;
 519              		.loc 1 128 5 view .LVU150
 129:misc.c        ****     int max_idx, diff;
 520              		.loc 1 129 5 view .LVU151
 130:misc.c        ****     char max_gray_diff; /* can be negative */
 521              		.loc 1 130 5 view .LVU152
 131:misc.c        **** 
 522              		.loc 1 131 5 view .LVU153
 523              		.loc 1 133 5 view .LVU154
 524              		.loc 1 133 8 is_stmt 0 view .LVU155
 525 0296 0F855301 		jne	.L28
 525      0000
 526 029c C5F97EC3 		vmovd	%xmm0, %ebx
 134:misc.c        ****     {
 135:misc.c        ****         printf("ERROR: input image has to be GRAY\n");
 136:misc.c        ****         exit(-1);
 137:misc.c        ****     }
 138:misc.c        ****     
 139:misc.c        ****     /* fill struct fields */
 140:misc.c        ****     image_out->width  = width;
 527              		.loc 1 140 5 is_stmt 1 view .LVU156
 141:misc.c        ****     image_out->height = height;
 528              		.loc 1 141 5 view .LVU157
 142:misc.c        ****     image_out->bytes_per_pixel = 1;
 529              		.loc 1 142 32 is_stmt 0 view .LVU158
 530 02a0 48B80100 		movabsq	$4294967297, %rax
 530      00000100 
 530      0000
 531 02aa 48894210 		movq	%rax, 16(%rdx)
 532              	.LVL43:
 533              	.LBB12:
 534              	.LBB13:
 143:misc.c        ****     image_out->color_space = JCS_GRAYSCALE;
 144:misc.c        **** 
 145:misc.c        ****     start_t = get_wall_time();
 146:misc.c        **** 
 147:misc.c        ****     for (int it = 0; it < NITER/10; it++)
 148:misc.c        ****     {
 149:misc.c        ****         max_gray_diff = 0; max_idx = -1; diff = 0;
 150:misc.c        **** 
 151:misc.c        ****         for (int i = 0; i < height*width; i++)
 535              		.loc 1 151 35 view .LVU159
 536 02ae 440FAFFB 		imull	%ebx, %r15d
 537              	.LBE13:
 538              	.LBE12:
 145:misc.c        **** 
 539              		.loc 1 145 15 view .LVU160
 540 02b2 31C0     		xorl	%eax, %eax
 140:misc.c        ****     image_out->height = height;
 541              		.loc 1 140 23 view .LVU161
 542 02b4 C5F9D642 		vmovq	%xmm0, 8(%rdx)
 542      08
 142:misc.c        ****     image_out->color_space = JCS_GRAYSCALE;
 543              		.loc 1 142 5 is_stmt 1 view .LVU162
 143:misc.c        **** 
 544              		.loc 1 143 5 view .LVU163
 142:misc.c        ****     image_out->color_space = JCS_GRAYSCALE;
 545              		.loc 1 142 32 is_stmt 0 view .LVU164
 546 02b9 48895424 		movq	%rdx, 8(%rsp)
 546      08
 145:misc.c        **** 
 547              		.loc 1 145 5 is_stmt 1 view .LVU165
 548 02be 4989FE   		movq	%rdi, %r14
 145:misc.c        **** 
 549              		.loc 1 145 15 is_stmt 0 view .LVU166
 550 02c1 E8000000 		call	get_wall_time
 550      00
 551              	.LVL44:
 552              	.LBB19:
 553              	.LBB14:
 554              		.loc 1 151 27 view .LVU167
 555 02c6 4585FF   		testl	%r15d, %r15d
 556 02c9 488B7424 		movq	8(%rsp), %rsi
 556      08
 557              	.LBE14:
 558              	.LBE19:
 145:misc.c        **** 
 559              		.loc 1 145 15 view .LVU168
 560 02ce C5FB1104 		vmovsd	%xmm0, (%rsp)
 560      24
 561              	.LVL45:
 147:misc.c        ****     {
 562              		.loc 1 147 5 is_stmt 1 view .LVU169
 563              	.LBB20:
 147:misc.c        ****     {
 564              		.loc 1 147 10 view .LVU170
 147:misc.c        ****     {
 565              		.loc 1 147 25 view .LVU171
 566              	.LBB15:
 567              		.loc 1 151 27 view .LVU172
 568 02d3 0F8E0701 		jle	.L25
 568      0000
 569 02d9 4D63D7   		movslq	%r15d, %r10
 570 02dc 31D2     		xorl	%edx, %edx
 571              	.LBE15:
 149:misc.c        **** 
 572              		.loc 1 149 23 is_stmt 0 view .LVU173
 573 02de 31FF     		xorl	%edi, %edi
 149:misc.c        **** 
 574              		.loc 1 149 47 view .LVU174
 575 02e0 4531C9   		xorl	%r9d, %r9d
 149:misc.c        **** 
 576              		.loc 1 149 36 view .LVU175
 577 02e3 41B8FFFF 		movl	$-1, %r8d
 577      FFFF
 578              	.LVL46:
 579 02e9 0F1F8000 		.p2align 4,,10
 579      000000
 580              		.p2align 3
 581              	.L24:
 582              	.LBB16:
 152:misc.c        ****         {
 153:misc.c        ****             pixels_out[i] = abs(pixels_in1[i] - pixels_in2[i]);
 583              		.loc 1 153 13 is_stmt 1 view .LVU176
 584              		.loc 1 153 59 is_stmt 0 view .LVU177
 585 02f0 410FB61C 		movzbl	(%r12,%rdx), %ebx
 585      14
 586              		.loc 1 153 43 view .LVU178
 587 02f5 0FB64415 		movzbl	0(%rbp,%rdx), %eax
 587      00
 588              		.loc 1 153 59 view .LVU179
 589 02fa 4189DB   		movl	%ebx, %r11d
 590              		.loc 1 153 43 view .LVU180
 591 02fd 89C1     		movl	%eax, %ecx
 592              		.loc 1 153 47 view .LVU181
 593 02ff 29D8     		subl	%ebx, %eax
 594              		.loc 1 153 29 view .LVU182
 595 0301 89C3     		movl	%eax, %ebx
 596 0303 C1FB1F   		sarl	$31, %ebx
 597 0306 31D8     		xorl	%ebx, %eax
 598 0308 29D8     		subl	%ebx, %eax
 599              		.loc 1 153 27 view .LVU183
 600 030a 41884415 		movb	%al, 0(%r13,%rdx)
 600      00
 154:misc.c        ****             if (pixels_out[i] != 0)
 601              		.loc 1 154 13 is_stmt 1 view .LVU184
 155:misc.c        ****             {
 156:misc.c        ****                 diff++;
 157:misc.c        ****                 if (pixels_out[i] > max_gray_diff)
 602              		.loc 1 157 35 is_stmt 0 view .LVU185
 603 030f 400FBEDF 		movsbl	%dil, %ebx
 154:misc.c        ****             if (pixels_out[i] != 0)
 604              		.loc 1 154 16 view .LVU186
 605 0313 4138CB   		cmpb	%cl, %r11b
 606 0316 740F     		je	.L23
 156:misc.c        ****                 if (pixels_out[i] > max_gray_diff)
 607              		.loc 1 156 17 is_stmt 1 view .LVU187
 156:misc.c        ****                 if (pixels_out[i] > max_gray_diff)
 608              		.loc 1 156 21 is_stmt 0 view .LVU188
 609 0318 41FFC1   		incl	%r9d
 610              	.LVL47:
 611              		.loc 1 157 17 is_stmt 1 view .LVU189
 612              		.loc 1 157 20 is_stmt 0 view .LVU190
 613 031b 39D8     		cmpl	%ebx, %eax
 614 031d 7E08     		jle	.L23
 615 031f 4189D0   		movl	%edx, %r8d
 616              	.LVL48:
 158:misc.c        ****                 {
 159:misc.c        ****                     max_gray_diff = pixels_out[i];
 617              		.loc 1 159 21 is_stmt 1 view .LVU191
 618              		.loc 1 159 35 is_stmt 0 view .LVU192
 619 0322 89C7     		movl	%eax, %edi
 620              	.LVL49:
 160:misc.c        ****                     max_idx = i;
 621              		.loc 1 160 21 is_stmt 1 view .LVU193
 622              		.loc 1 160 21 is_stmt 0 view .LVU194
 623              	.LBE16:
 624              	.LBE20:
 161:misc.c        ****                 }
 162:misc.c        ****             }
 163:misc.c        ****         }
 164:misc.c        ****         dummy(image_in1, image_out);
 165:misc.c        ****     }
 166:misc.c        ****     end_t = get_wall_time(); wall_dif = end_t - start_t;
 167:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f    %5.1f%%  %4hhd (%7d)\n",
 625              		.loc 1 167 5 view .LVU195
 626 0324 0FBED8   		movsbl	%al, %ebx
 627              	.LVL50:
 628              	.L23:
 629              	.LBB21:
 630              	.LBB17:
 151:misc.c        ****         {
 631              		.loc 1 151 44 is_stmt 1 view .LVU196
 151:misc.c        ****         {
 632              		.loc 1 151 27 view .LVU197
 633 0327 48FFC2   		incq	%rdx
 634              	.LVL51:
 151:misc.c        ****         {
 635              		.loc 1 151 27 is_stmt 0 view .LVU198
 636 032a 4939D2   		cmpq	%rdx, %r10
 637 032d 75C1     		jne	.L24
 151:misc.c        ****         {
 638              		.loc 1 151 27 view .LVU199
 639              	.LBE17:
 640              	.LBE21:
 168:misc.c        ****            "cmpGray", 1e4*wall_dif/NITER, 1e9*wall_dif/(NITER/10*height*width),
 169:misc.c        ****            (NITER*height*width)/(1e9*wall_dif), (double) 100.0*diff/(height*width), max_gray_diff, 
 641              		.loc 1 169 63 view .LVU200
 642 032f C5D157ED 		vxorpd	%xmm5, %xmm5, %xmm5
 643 0333 C4C1532A 		vcvtsi2sdl	%r9d, %xmm5, %xmm0
 643      C1
 644              	.LVL52:
 645              		.loc 1 169 63 view .LVU201
 646 0338 C5FB590D 		vmulsd	.LC3(%rip), %xmm0, %xmm1
 646      00000000 
 647 0340 C4E1F97E 		vmovq	%xmm1, %rbp
 647      CD
 648              	.LVL53:
 649              	.L22:
 650              	.LBB22:
 164:misc.c        ****     }
 651              		.loc 1 164 9 discriminator 2 view .LVU202
 652 0345 4C89F7   		movq	%r14, %rdi
 653 0348 44894424 		movl	%r8d, 8(%rsp)
 653      08
 654              	.LVL54:
 164:misc.c        ****     }
 655              		.loc 1 164 9 is_stmt 1 discriminator 2 view .LVU203
 656 034d E8000000 		call	dummy
 656      00
 657              	.LVL55:
 147:misc.c        ****     {
 658              		.loc 1 147 39 discriminator 2 view .LVU204
 147:misc.c        ****     {
 659              		.loc 1 147 25 discriminator 2 view .LVU205
 660              	.LBE22:
 166:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f    %5.1f%%  %4hhd (%7d)\n",
 661              		.loc 1 166 5 discriminator 2 view .LVU206
 166:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f    %5.1f%%  %4hhd (%7d)\n",
 662              		.loc 1 166 13 is_stmt 0 discriminator 2 view .LVU207
 663 0352 31C0     		xorl	%eax, %eax
 664 0354 E8000000 		call	get_wall_time
 664      00
 665              	.LVL56:
 166:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f    %5.1f%%  %4hhd (%7d)\n",
 666              		.loc 1 166 30 is_stmt 1 discriminator 2 view .LVU208
 667              		.loc 1 169 25 is_stmt 0 discriminator 2 view .LVU209
 668 0359 438D04BF 		leal	(%r15,%r15,4), %eax
 167:misc.c        ****            "cmpGray", 1e4*wall_dif/NITER, 1e9*wall_dif/(NITER/10*height*width),
 669              		.loc 1 167 5 discriminator 2 view .LVU210
 670 035d C5C957F6 		vxorpd	%xmm6, %xmm6, %xmm6
 671              		.loc 1 169 25 discriminator 2 view .LVU211
 672 0361 01C0     		addl	%eax, %eax
 673              		.loc 1 169 32 discriminator 2 view .LVU212
 674 0363 C5CB2AD8 		vcvtsi2sdl	%eax, %xmm6, %xmm3
 166:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f    %5.1f%%  %4hhd (%7d)\n",
 675              		.loc 1 166 39 discriminator 2 view .LVU213
 676 0367 C5FB5C04 		vsubsd	(%rsp), %xmm0, %xmm0
 676      24
 677              	.LVL57:
 167:misc.c        ****            "cmpGray", 1e4*wall_dif/NITER, 1e9*wall_dif/(NITER/10*height*width),
 678              		.loc 1 167 5 is_stmt 1 discriminator 2 view .LVU214
 679 036c C4C14B2A 		vcvtsi2sdl	%r15d, %xmm6, %xmm4
 679      E7
 680 0371 C4E1F96E 		vmovq	%rbp, %xmm7
 680      FD
 681              		.loc 1 169 32 is_stmt 0 discriminator 2 view .LVU215
 682 0376 C5E35915 		vmulsd	.LC1(%rip), %xmm3, %xmm2
 682      00000000 
 168:misc.c        ****            (NITER*height*width)/(1e9*wall_dif), (double) 100.0*diff/(height*width), max_gray_diff, 
 683              		.loc 1 168 46 discriminator 2 view .LVU216
 684 037e C5FB590D 		vmulsd	.LC2(%rip), %xmm0, %xmm1
 684      00000000 
 167:misc.c        ****            "cmpGray", 1e4*wall_dif/NITER, 1e9*wall_dif/(NITER/10*height*width),
 685              		.loc 1 167 5 discriminator 2 view .LVU217
 686 0386 C5C35EDC 		vdivsd	%xmm4, %xmm7, %xmm3
 687 038a C5FB592D 		vmulsd	.LC14(%rip), %xmm0, %xmm5
 687      00000000 
 688 0392 8B4C2408 		movl	8(%rsp), %ecx
 689 0396 89DA     		movl	%ebx, %edx
 690 0398 BE000000 		movl	$.LC15, %esi
 690      00
 691 039d BF000000 		movl	$.LC16, %edi
 691      00
 692 03a2 B8040000 		movl	$4, %eax
 692      00
 693 03a7 C5EB5ED0 		vdivsd	%xmm0, %xmm2, %xmm2
 694 03ab C5D310C5 		vmovsd	%xmm5, %xmm5, %xmm0
 695              	.LVL58:
 167:misc.c        ****            "cmpGray", 1e4*wall_dif/NITER, 1e9*wall_dif/(NITER/10*height*width),
 696              		.loc 1 167 5 discriminator 2 view .LVU218
 697 03af C5F35ECC 		vdivsd	%xmm4, %xmm1, %xmm1
 698 03b3 E8000000 		call	printf
 698      00
 699              	.LVL59:
 170:misc.c        ****     printf("        función      Time    ns/px    Gpixels/s  %%diff  max_dif (max_idx)\n");
 700              		.loc 1 170 5 is_stmt 1 discriminator 2 view .LVU219
 701 03b8 BF000000 		movl	$.LC17, %edi
 701      00
 702 03bd 31C0     		xorl	%eax, %eax
 703 03bf E8000000 		call	printf
 703      00
 704              	.LVL60:
 171:misc.c        ****     printf("                     (ms)\n");
 705              		.loc 1 171 5 discriminator 2 view .LVU220
 706 03c4 BF000000 		movl	$.LC12, %edi
 706      00
 707 03c9 E8000000 		call	puts
 707      00
 708              	.LVL61:
 172:misc.c        ****     return(max_gray_diff);
 709              		.loc 1 172 5 discriminator 2 view .LVU221
 173:misc.c        **** }
 710              		.loc 1 173 1 is_stmt 0 discriminator 2 view .LVU222
 711 03ce 4883C418 		addq	$24, %rsp
 712              		.cfi_remember_state
 713              		.cfi_def_cfa_offset 56
 714 03d2 89D8     		movl	%ebx, %eax
 715 03d4 5B       		popq	%rbx
 716              		.cfi_def_cfa_offset 48
 717 03d5 5D       		popq	%rbp
 718              		.cfi_def_cfa_offset 40
 719 03d6 415C     		popq	%r12
 720              		.cfi_def_cfa_offset 32
 721              	.LVL62:
 722              		.loc 1 173 1 discriminator 2 view .LVU223
 723 03d8 415D     		popq	%r13
 724              		.cfi_def_cfa_offset 24
 725              	.LVL63:
 726              		.loc 1 173 1 discriminator 2 view .LVU224
 727 03da 415E     		popq	%r14
 728              		.cfi_def_cfa_offset 16
 729              	.LVL64:
 730              		.loc 1 173 1 discriminator 2 view .LVU225
 731 03dc 415F     		popq	%r15
 732              		.cfi_def_cfa_offset 8
 733 03de C3       		ret
 734              	.LVL65:
 735 03df 90       		.p2align 4,,10
 736              		.p2align 3
 737              	.L25:
 738              		.cfi_restore_state
 739              	.LBB23:
 740              	.LBB18:
 151:misc.c        ****         {
 741              		.loc 1 151 27 view .LVU226
 742 03e0 31ED     		xorl	%ebp, %ebp
 743              	.LVL66:
 151:misc.c        ****         {
 744              		.loc 1 151 27 view .LVU227
 745 03e2 31DB     		xorl	%ebx, %ebx
 746              	.LBE18:
 149:misc.c        **** 
 747              		.loc 1 149 36 view .LVU228
 748 03e4 41B8FFFF 		movl	$-1, %r8d
 748      FFFF
 749 03ea E956FFFF 		jmp	.L22
 749      FF
 750              	.LVL67:
 751              	.L28:
 149:misc.c        **** 
 752              		.loc 1 149 36 view .LVU229
 753              	.LBE23:
 135:misc.c        ****         exit(-1);
 754              		.loc 1 135 9 is_stmt 1 view .LVU230
 755 03ef BF000000 		movl	$.LC13, %edi
 755      00
 756              	.LVL68:
 135:misc.c        ****         exit(-1);
 757              		.loc 1 135 9 is_stmt 0 view .LVU231
 758 03f4 E8000000 		call	puts
 758      00
 759              	.LVL69:
 136:misc.c        ****     }
 760              		.loc 1 136 9 is_stmt 1 view .LVU232
 761 03f9 83CFFF   		orl	$-1, %edi
 762 03fc E8000000 		call	exit
 762      00
 763              	.LVL70:
 764              		.cfi_endproc
 765              	.LFE26:
 767              		.section	.rodata.str1.8
 768 01a5 000000   		.align 8
 769              	.LC18:
 770 01a8 4552524F 		.string	"ERROR: input image has to be gray"
 770      523A2069 
 770      6E707574 
 770      20696D61 
 770      67652068 
 771              		.section	.rodata.str1.1
 772              	.LC19:
 773 0034 7700     		.string	"w"
 774              		.section	.rodata.str1.8
 775 01ca 00000000 		.align 8
 775      0000
 776              	.LC20:
 777 01d0 4552524F 		.string	"ERROR: no se ha indicado fichero de salida"
 777      523A206E 
 777      6F207365 
 777      20686120 
 777      696E6469 
 778              		.section	.rodata.str1.1
 779              	.LC21:
 780 0036 50322025 		.string	"P2 %u %u 255\n"
 780      75202575 
 780      20323535 
 780      0A00
 781              	.LC22:
 782 0044 25750A00 		.string	"%u\n"
 783              	.LC23:
 784 0048 77726974 		.string	"write_PGM"
 784      655F5047 
 784      4D00
 785              		.text
 786 0401 66662E0F 		.p2align 4
 786      1F840000 
 786      0000000F 
 786      1F4000
 787              		.globl	write_PGM
 789              	write_PGM:
 790              	.LVL71:
 791              	.LFB27:
 174:misc.c        **** //----------------------------------------------------------------------------
 175:misc.c        **** 
 176:misc.c        **** int
 177:misc.c        **** write_PGM(char *filename, image_t * image)
 178:misc.c        **** {
 792              		.loc 1 178 1 view -0
 793              		.cfi_startproc
 179:misc.c        ****     double start_t, end_t;
 794              		.loc 1 179 5 view .LVU234
 180:misc.c        ****     const int height = image->height;
 795              		.loc 1 180 5 view .LVU235
 178:misc.c        ****     double start_t, end_t;
 796              		.loc 1 178 1 is_stmt 0 view .LVU236
 797 0410 4156     		pushq	%r14
 798              		.cfi_def_cfa_offset 16
 799              		.cfi_offset 14, -16
 800 0412 4155     		pushq	%r13
 801              		.cfi_def_cfa_offset 24
 802              		.cfi_offset 13, -24
 803 0414 4154     		pushq	%r12
 804              		.cfi_def_cfa_offset 32
 805              		.cfi_offset 12, -32
 806 0416 55       		pushq	%rbp
 807              		.cfi_def_cfa_offset 40
 808              		.cfi_offset 6, -40
 809 0417 53       		pushq	%rbx
 810              		.cfi_def_cfa_offset 48
 811              		.cfi_offset 3, -48
 181:misc.c        ****     const int width =  image->width;
 182:misc.c        ****     unsigned char * pixels  = image->pixels;
 183:misc.c        **** 
 184:misc.c        ****     if (image->bytes_per_pixel != 1)
 812              		.loc 1 184 8 view .LVU237
 813 0418 837E1001 		cmpl	$1, 16(%rsi)
 180:misc.c        ****     const int width =  image->width;
 814              		.loc 1 180 15 view .LVU238
 815 041c 448B660C 		movl	12(%rsi), %r12d
 816              	.LVL72:
 181:misc.c        ****     const int width =  image->width;
 817              		.loc 1 181 5 is_stmt 1 view .LVU239
 181:misc.c        ****     const int width =  image->width;
 818              		.loc 1 181 15 is_stmt 0 view .LVU240
 819 0420 448B6E08 		movl	8(%rsi), %r13d
 820              	.LVL73:
 182:misc.c        **** 
 821              		.loc 1 182 5 is_stmt 1 view .LVU241
 182:misc.c        **** 
 822              		.loc 1 182 21 is_stmt 0 view .LVU242
 823 0424 488B1E   		movq	(%rsi), %rbx
 824              	.LVL74:
 825              		.loc 1 184 5 is_stmt 1 view .LVU243
 826              		.loc 1 184 8 is_stmt 0 view .LVU244
 827 0427 0F85B000 		jne	.L37
 827      0000
 828 042d 4889FD   		movq	%rdi, %rbp
 185:misc.c        ****     {
 186:misc.c        ****         printf("ERROR: input image has to be gray\n");
 187:misc.c        ****         exit(-1);
 188:misc.c        ****     }
 189:misc.c        **** 
 190:misc.c        ****     start_t = get_wall_time();
 829              		.loc 1 190 5 is_stmt 1 view .LVU245
 830              		.loc 1 190 15 is_stmt 0 view .LVU246
 831 0430 31C0     		xorl	%eax, %eax
 832 0432 E8000000 		call	get_wall_time
 832      00
 833              	.LVL75:
 191:misc.c        **** 
 192:misc.c        ****     FILE *outfile = fopen(filename, "w");
 834              		.loc 1 192 21 view .LVU247
 835 0437 4889EF   		movq	%rbp, %rdi
 836 043a BE000000 		movl	$.LC19, %esi
 836      00
 190:misc.c        **** 
 837              		.loc 1 190 15 view .LVU248
 838 043f C4C1F97E 		vmovq	%xmm0, %r14
 838      C6
 839              	.LVL76:
 840              		.loc 1 192 5 is_stmt 1 view .LVU249
 841              		.loc 1 192 21 is_stmt 0 view .LVU250
 842 0444 E8000000 		call	fopen
 842      00
 843              	.LVL77:
 844              		.loc 1 192 21 view .LVU251
 845 0449 4889C5   		movq	%rax, %rbp
 846              	.LVL78:
 193:misc.c        ****     if (!outfile)
 847              		.loc 1 193 5 is_stmt 1 view .LVU252
 848              		.loc 1 193 8 is_stmt 0 view .LVU253
 849 044c 4885C0   		testq	%rax, %rax
 850 044f 747B     		je	.L38
 194:misc.c        ****     {
 195:misc.c        ****         printf("ERROR: no se ha indicado fichero de salida\n");
 196:misc.c        ****         return -1;
 197:misc.c        ****     }
 198:misc.c        **** 
 199:misc.c        ****     /* PGM header */
 200:misc.c        ****     fprintf(outfile, "P2 %u %u 255\n", width, height);
 851              		.loc 1 200 5 is_stmt 1 view .LVU254
 852 0451 4489E1   		movl	%r12d, %ecx
 853              	.LBB24:
 201:misc.c        **** 
 202:misc.c        ****     for (int i = 0; i < height*width; i++)
 854              		.loc 1 202 31 is_stmt 0 view .LVU255
 855 0454 450FAFE5 		imull	%r13d, %r12d
 856              	.LVL79:
 857              		.loc 1 202 31 view .LVU256
 858              	.LBE24:
 200:misc.c        **** 
 859              		.loc 1 200 5 view .LVU257
 860 0458 4889C7   		movq	%rax, %rdi
 861 045b 4489EA   		movl	%r13d, %edx
 862 045e BE000000 		movl	$.LC21, %esi
 862      00
 863 0463 31C0     		xorl	%eax, %eax
 864              	.LVL80:
 200:misc.c        **** 
 865              		.loc 1 200 5 view .LVU258
 866 0465 E8000000 		call	fprintf
 866      00
 867              	.LVL81:
 868              		.loc 1 202 5 is_stmt 1 view .LVU259
 869              	.LBB25:
 870              		.loc 1 202 10 view .LVU260
 871              		.loc 1 202 23 view .LVU261
 872 046a 4585E4   		testl	%r12d, %r12d
 873 046d 7E23     		jle	.L33
 874 046f 4D63EC   		movslq	%r12d, %r13
 875              	.LVL82:
 876              		.loc 1 202 23 is_stmt 0 view .LVU262
 877 0472 4901DD   		addq	%rbx, %r13
 878              	.LVL83:
 879              		.p2align 4,,10
 880 0475 0F1F00   		.p2align 3
 881              	.L34:
 203:misc.c        ****     {
 204:misc.c        ****         fprintf(outfile, "%u\n", pixels[i]);
 882              		.loc 1 204 9 is_stmt 1 discriminator 3 view .LVU263
 883 0478 0FB613   		movzbl	(%rbx), %edx
 884 047b BE000000 		movl	$.LC22, %esi
 884      00
 885 0480 4889EF   		movq	%rbp, %rdi
 886 0483 31C0     		xorl	%eax, %eax
 202:misc.c        ****     {
 887              		.loc 1 202 23 is_stmt 0 discriminator 3 view .LVU264
 888 0485 48FFC3   		incq	%rbx
 889              		.loc 1 204 9 discriminator 3 view .LVU265
 890 0488 E8000000 		call	fprintf
 890      00
 891              	.LVL84:
 202:misc.c        ****     {
 892              		.loc 1 202 40 is_stmt 1 discriminator 3 view .LVU266
 202:misc.c        ****     {
 893              		.loc 1 202 23 discriminator 3 view .LVU267
 894 048d 4939DD   		cmpq	%rbx, %r13
 895 0490 75E6     		jne	.L34
 896              	.L33:
 202:misc.c        ****     {
 897              		.loc 1 202 23 is_stmt 0 discriminator 3 view .LVU268
 898              	.LBE25:
 205:misc.c        ****     }
 206:misc.c        **** 
 207:misc.c        ****     fclose(outfile);
 899              		.loc 1 207 5 is_stmt 1 view .LVU269
 900 0492 4889EF   		movq	%rbp, %rdi
 901 0495 E8000000 		call	fclose
 901      00
 902              	.LVL85:
 208:misc.c        **** 
 209:misc.c        ****     end_t = get_wall_time();
 903              		.loc 1 209 5 view .LVU270
 904              		.loc 1 209 13 is_stmt 0 view .LVU271
 905 049a 31C0     		xorl	%eax, %eax
 906 049c E8000000 		call	get_wall_time
 906      00
 907              	.LVL86:
 210:misc.c        ****     results(end_t - start_t, height*width, "write_PGM");
 908              		.loc 1 210 5 is_stmt 1 view .LVU272
 909 04a1 C4C1F96E 		vmovq	%r14, %xmm1
 909      CE
 910 04a6 C5FB5CC1 		vsubsd	%xmm1, %xmm0, %xmm0
 911              	.LVL87:
 912              		.loc 1 210 5 is_stmt 0 view .LVU273
 913 04aa BE000000 		movl	$.LC23, %esi
 913      00
 914 04af 4489E7   		movl	%r12d, %edi
 915 04b2 E8000000 		call	results
 915      00
 916              	.LVL88:
 211:misc.c        ****     printf("\n");
 917              		.loc 1 211 5 is_stmt 1 view .LVU274
 918 04b7 BF0A0000 		movl	$10, %edi
 918      00
 919 04bc E8000000 		call	putchar
 919      00
 920              	.LVL89:
 212:misc.c        ****     return 0;
 921              		.loc 1 212 5 view .LVU275
 922              		.loc 1 212 12 is_stmt 0 view .LVU276
 923 04c1 31C0     		xorl	%eax, %eax
 924              	.LVL90:
 925              	.L29:
 213:misc.c        **** }
 926              		.loc 1 213 1 view .LVU277
 927 04c3 5B       		popq	%rbx
 928              		.cfi_remember_state
 929              		.cfi_def_cfa_offset 40
 930 04c4 5D       		popq	%rbp
 931              		.cfi_def_cfa_offset 32
 932              	.LVL91:
 933              		.loc 1 213 1 view .LVU278
 934 04c5 415C     		popq	%r12
 935              		.cfi_def_cfa_offset 24
 936 04c7 415D     		popq	%r13
 937              		.cfi_def_cfa_offset 16
 938 04c9 415E     		popq	%r14
 939              		.cfi_def_cfa_offset 8
 940              	.LVL92:
 941              		.loc 1 213 1 view .LVU279
 942 04cb C3       		ret
 943              	.LVL93:
 944              	.L38:
 945              		.cfi_restore_state
 195:misc.c        ****         return -1;
 946              		.loc 1 195 9 is_stmt 1 view .LVU280
 947 04cc BF000000 		movl	$.LC20, %edi
 947      00
 948 04d1 E8000000 		call	puts
 948      00
 949              	.LVL94:
 196:misc.c        ****     }
 950              		.loc 1 196 9 view .LVU281
 196:misc.c        ****     }
 951              		.loc 1 196 16 is_stmt 0 view .LVU282
 952 04d6 B8FFFFFF 		movl	$-1, %eax
 952      FF
 953 04db EBE6     		jmp	.L29
 954              	.LVL95:
 955              	.L37:
 186:misc.c        ****         exit(-1);
 956              		.loc 1 186 9 is_stmt 1 view .LVU283
 957 04dd BF000000 		movl	$.LC18, %edi
 957      00
 958              	.LVL96:
 186:misc.c        ****         exit(-1);
 959              		.loc 1 186 9 is_stmt 0 view .LVU284
 960 04e2 E8000000 		call	puts
 960      00
 961              	.LVL97:
 187:misc.c        ****     }
 962              		.loc 1 187 9 is_stmt 1 view .LVU285
 963 04e7 83CFFF   		orl	$-1, %edi
 964 04ea E8000000 		call	exit
 964      00
 965              	.LVL98:
 966              		.cfi_endproc
 967              	.LFE27:
 969              		.section	.rodata.str1.8
 970 01fb 00000000 		.align 8
 970      00
 971              	.LC24:
 972 0200 4552524F 		.string	"ERROR: bad format number (3 or 6)"
 972      523A2062 
 972      61642066 
 972      6F726D61 
 972      74206E75 
 973              		.section	.rodata.str1.1
 974              	.LC25:
 975 0052 50257520 		.string	"P%u %u %u 255\n"
 975      25752025 
 975      75203235 
 975      350A00
 976              	.LC26:
 977 0061 25752025 		.string	"%u %u %u\n"
 977      75202575 
 977      0A00
 978              	.LC27:
 979 006b 77726974 		.string	"write_PPM"
 979      655F5050 
 979      4D00
 980              		.text
 981 04ef 90       		.p2align 4
 982              		.globl	write_PPM
 984              	write_PPM:
 985              	.LVL99:
 986              	.LFB28:
 214:misc.c        **** //----------------------------------------------------------------------------
 215:misc.c        **** 
 216:misc.c        **** // format: 3 -> ascii  (P3 magic number)
 217:misc.c        **** // format: 6 -> binary (P6 magic number)
 218:misc.c        **** int
 219:misc.c        **** write_PPM(char *filename, image_t * image, int format)
 220:misc.c        **** {
 987              		.loc 1 220 1 view -0
 988              		.cfi_startproc
 221:misc.c        ****     double start_t, end_t;
 989              		.loc 1 221 5 view .LVU287
 222:misc.c        ****     const int height = image->height;
 990              		.loc 1 222 5 view .LVU288
 220:misc.c        ****     double start_t, end_t;
 991              		.loc 1 220 1 is_stmt 0 view .LVU289
 992 04f0 4157     		pushq	%r15
 993              		.cfi_def_cfa_offset 16
 994              		.cfi_offset 15, -16
 995 04f2 4156     		pushq	%r14
 996              		.cfi_def_cfa_offset 24
 997              		.cfi_offset 14, -24
 998 04f4 4155     		pushq	%r13
 999              		.cfi_def_cfa_offset 32
 1000              		.cfi_offset 13, -32
 1001 04f6 4154     		pushq	%r12
 1002              		.cfi_def_cfa_offset 40
 1003              		.cfi_offset 12, -40
 1004 04f8 55       		pushq	%rbp
 1005              		.cfi_def_cfa_offset 48
 1006              		.cfi_offset 6, -48
 1007 04f9 53       		pushq	%rbx
 1008              		.cfi_def_cfa_offset 56
 1009              		.cfi_offset 3, -56
 1010 04fa 4883EC08 		subq	$8, %rsp
 1011              		.cfi_def_cfa_offset 64
 223:misc.c        ****     const int width =  image->width;
 224:misc.c        ****     unsigned char * pixels  = image->pixels;
 225:misc.c        **** 
 226:misc.c        ****     if (image->bytes_per_pixel != 3)
 1012              		.loc 1 226 8 view .LVU290
 1013 04fe 837E1003 		cmpl	$3, 16(%rsi)
 222:misc.c        ****     const int width =  image->width;
 1014              		.loc 1 222 15 view .LVU291
 1015 0502 448B660C 		movl	12(%rsi), %r12d
 1016              	.LVL100:
 223:misc.c        ****     const int width =  image->width;
 1017              		.loc 1 223 5 is_stmt 1 view .LVU292
 223:misc.c        ****     const int width =  image->width;
 1018              		.loc 1 223 15 is_stmt 0 view .LVU293
 1019 0506 448B7608 		movl	8(%rsi), %r14d
 1020              	.LVL101:
 224:misc.c        **** 
 1021              		.loc 1 224 5 is_stmt 1 view .LVU294
 224:misc.c        **** 
 1022              		.loc 1 224 21 is_stmt 0 view .LVU295
 1023 050a 488B1E   		movq	(%rsi), %rbx
 1024              	.LVL102:
 1025              		.loc 1 226 5 is_stmt 1 view .LVU296
 1026              		.loc 1 226 8 is_stmt 0 view .LVU297
 1027 050d 0F851601 		jne	.L57
 1027      0000
 1028 0513 4889FD   		movq	%rdi, %rbp
 1029 0516 4189D5   		movl	%edx, %r13d
 227:misc.c        ****     {
 228:misc.c        ****         printf("ERROR: input image has to be RGB or YCbCr\n");
 229:misc.c        ****         exit(-1);
 230:misc.c        ****     }
 231:misc.c        ****     if ((format != 3) && (format != 6))
 1030              		.loc 1 231 5 is_stmt 1 view .LVU298
 1031              		.loc 1 231 8 is_stmt 0 view .LVU299
 1032 0519 83FA03   		cmpl	$3, %edx
 1033 051c 7409     		je	.L41
 1034 051e 83FA06   		cmpl	$6, %edx
 1035 0521 0F85DA00 		jne	.L58
 1035      0000
 1036              	.L41:
 232:misc.c        ****     {
 233:misc.c        ****         printf("ERROR: bad format number (3 or 6)\n");
 234:misc.c        ****         exit(-1);
 235:misc.c        ****     }
 236:misc.c        **** 
 237:misc.c        ****     start_t = get_wall_time();
 1037              		.loc 1 237 5 is_stmt 1 view .LVU300
 1038              		.loc 1 237 15 is_stmt 0 view .LVU301
 1039 0527 31C0     		xorl	%eax, %eax
 1040 0529 E8000000 		call	get_wall_time
 1040      00
 1041              	.LVL103:
 238:misc.c        **** 
 239:misc.c        ****     FILE *outfile = fopen(filename, "w");
 1042              		.loc 1 239 21 view .LVU302
 1043 052e 4889EF   		movq	%rbp, %rdi
 1044 0531 BE000000 		movl	$.LC19, %esi
 1044      00
 237:misc.c        **** 
 1045              		.loc 1 237 15 view .LVU303
 1046 0536 C4C1F97E 		vmovq	%xmm0, %r15
 1046      C7
 1047              	.LVL104:
 1048              		.loc 1 239 5 is_stmt 1 view .LVU304
 1049              		.loc 1 239 21 is_stmt 0 view .LVU305
 1050 053b E8000000 		call	fopen
 1050      00
 1051              	.LVL105:
 1052              		.loc 1 239 21 view .LVU306
 1053 0540 4889C5   		movq	%rax, %rbp
 1054              	.LVL106:
 240:misc.c        ****     if (!outfile)
 1055              		.loc 1 240 5 is_stmt 1 view .LVU307
 1056              		.loc 1 240 8 is_stmt 0 view .LVU308
 1057 0543 4885C0   		testq	%rax, %rax
 1058 0546 0F84CC00 		je	.L59
 1058      0000
 241:misc.c        ****     {
 242:misc.c        ****         printf("ERROR: no se ha indicado fichero de salida\n");
 243:misc.c        ****         return -1;
 244:misc.c        ****     }
 245:misc.c        **** 
 246:misc.c        ****     /* PPM header */
 247:misc.c        ****     fprintf(outfile, "P%u %u %u 255\n", format, width, height);
 1059              		.loc 1 247 5 is_stmt 1 view .LVU309
 1060 054c 4589E0   		movl	%r12d, %r8d
 1061 054f 4889C7   		movq	%rax, %rdi
 1062 0552 4489F1   		movl	%r14d, %ecx
 1063 0555 4489EA   		movl	%r13d, %edx
 1064 0558 BE000000 		movl	$.LC25, %esi
 1064      00
 1065 055d 31C0     		xorl	%eax, %eax
 1066              	.LVL107:
 1067              	.LBB26:
 248:misc.c        **** 
 249:misc.c        ****     if (format == 3)
 250:misc.c        ****     {
 251:misc.c        ****         for (int i = 0; i < height*width; i++)
 1068              		.loc 1 251 35 is_stmt 0 view .LVU310
 1069 055f 450FAFE6 		imull	%r14d, %r12d
 1070              	.LVL108:
 1071              		.loc 1 251 35 view .LVU311
 1072              	.LBE26:
 247:misc.c        **** 
 1073              		.loc 1 247 5 view .LVU312
 1074 0563 E8000000 		call	fprintf
 1074      00
 1075              	.LVL109:
 249:misc.c        ****     {
 1076              		.loc 1 249 5 is_stmt 1 view .LVU313
 249:misc.c        ****     {
 1077              		.loc 1 249 8 is_stmt 0 view .LVU314
 1078 0568 4183FD03 		cmpl	$3, %r13d
 1079 056c 757A     		jne	.L44
 1080              	.LVL110:
 1081              	.LBB27:
 1082              		.loc 1 251 27 is_stmt 1 view .LVU315
 1083 056e 4585E4   		testl	%r12d, %r12d
 1084 0571 7E31     		jle	.L46
 1085 0573 4963C4   		movslq	%r12d, %rax
 1086 0576 4C8D2C40 		leaq	(%rax,%rax,2), %r13
 1087              	.LVL111:
 1088              		.loc 1 251 27 is_stmt 0 view .LVU316
 1089 057a 4901DD   		addq	%rbx, %r13
 1090              	.LVL112:
 1091 057d 0F1F00   		.p2align 4,,10
 1092              		.p2align 3
 1093              	.L47:
 252:misc.c        ****         {
 253:misc.c        ****             fprintf(outfile, "%u %u %u\n",
 1094              		.loc 1 253 13 is_stmt 1 discriminator 3 view .LVU317
 1095 0580 0FB64B01 		movzbl	1(%rbx), %ecx
 1096 0584 0FB613   		movzbl	(%rbx), %edx
 1097 0587 440FB643 		movzbl	2(%rbx), %r8d
 1097      02
 1098 058c BE000000 		movl	$.LC26, %esi
 1098      00
 1099 0591 4889EF   		movq	%rbp, %rdi
 1100 0594 31C0     		xorl	%eax, %eax
 251:misc.c        ****         {
 1101              		.loc 1 251 27 is_stmt 0 discriminator 3 view .LVU318
 1102 0596 4883C303 		addq	$3, %rbx
 1103              		.loc 1 253 13 discriminator 3 view .LVU319
 1104 059a E8000000 		call	fprintf
 1104      00
 1105              	.LVL113:
 251:misc.c        ****         {
 1106              		.loc 1 251 44 is_stmt 1 discriminator 3 view .LVU320
 251:misc.c        ****         {
 1107              		.loc 1 251 27 discriminator 3 view .LVU321
 1108 059f 4939DD   		cmpq	%rbx, %r13
 1109 05a2 75DC     		jne	.L47
 1110              	.L46:
 251:misc.c        ****         {
 1111              		.loc 1 251 27 is_stmt 0 discriminator 3 view .LVU322
 1112              	.LBE27:
 254:misc.c        ****                         pixels[3*i+0],
 255:misc.c        ****                         pixels[3*i+1],
 256:misc.c        ****                         pixels[3*i+2]);
 257:misc.c        ****         }
 258:misc.c        ****     }
 259:misc.c        ****     else
 260:misc.c        ****     {
 261:misc.c        ****         fwrite(pixels, sizeof(unsigned char), 3*height*width, outfile);
 262:misc.c        ****     }
 263:misc.c        ****     fclose(outfile);
 1113              		.loc 1 263 5 is_stmt 1 view .LVU323
 1114 05a4 4889EF   		movq	%rbp, %rdi
 1115 05a7 E8000000 		call	fclose
 1115      00
 1116              	.LVL114:
 264:misc.c        **** 
 265:misc.c        ****     end_t = get_wall_time();
 1117              		.loc 1 265 5 view .LVU324
 1118              		.loc 1 265 13 is_stmt 0 view .LVU325
 1119 05ac 31C0     		xorl	%eax, %eax
 1120 05ae E8000000 		call	get_wall_time
 1120      00
 1121              	.LVL115:
 266:misc.c        ****     results(end_t - start_t, height*width, "write_PPM");
 1122              		.loc 1 266 5 is_stmt 1 view .LVU326
 1123 05b3 C4C1F96E 		vmovq	%r15, %xmm1
 1123      CF
 1124 05b8 C5FB5CC1 		vsubsd	%xmm1, %xmm0, %xmm0
 1125              	.LVL116:
 1126              		.loc 1 266 5 is_stmt 0 view .LVU327
 1127 05bc BE000000 		movl	$.LC27, %esi
 1127      00
 1128 05c1 4489E7   		movl	%r12d, %edi
 1129 05c4 E8000000 		call	results
 1129      00
 1130              	.LVL117:
 267:misc.c        ****     printf("\n");
 1131              		.loc 1 267 5 is_stmt 1 view .LVU328
 1132 05c9 BF0A0000 		movl	$10, %edi
 1132      00
 1133 05ce E8000000 		call	putchar
 1133      00
 1134              	.LVL118:
 268:misc.c        ****     return 0;
 1135              		.loc 1 268 5 view .LVU329
 1136              		.loc 1 268 12 is_stmt 0 view .LVU330
 1137 05d3 31C0     		xorl	%eax, %eax
 1138              	.LVL119:
 1139              	.L39:
 269:misc.c        **** }
 1140              		.loc 1 269 1 view .LVU331
 1141 05d5 4883C408 		addq	$8, %rsp
 1142              		.cfi_remember_state
 1143              		.cfi_def_cfa_offset 56
 1144 05d9 5B       		popq	%rbx
 1145              		.cfi_def_cfa_offset 48
 1146 05da 5D       		popq	%rbp
 1147              		.cfi_def_cfa_offset 40
 1148              	.LVL120:
 1149              		.loc 1 269 1 view .LVU332
 1150 05db 415C     		popq	%r12
 1151              		.cfi_def_cfa_offset 32
 1152 05dd 415D     		popq	%r13
 1153              		.cfi_def_cfa_offset 24
 1154 05df 415E     		popq	%r14
 1155              		.cfi_def_cfa_offset 16
 1156              	.LVL121:
 1157              		.loc 1 269 1 view .LVU333
 1158 05e1 415F     		popq	%r15
 1159              		.cfi_def_cfa_offset 8
 1160              	.LVL122:
 1161              		.loc 1 269 1 view .LVU334
 1162 05e3 C3       		ret
 1163              	.LVL123:
 1164              		.p2align 4,,10
 1165 05e4 0F1F4000 		.p2align 3
 1166              	.L44:
 1167              		.cfi_restore_state
 261:misc.c        ****     }
 1168              		.loc 1 261 9 is_stmt 1 view .LVU335
 261:misc.c        ****     }
 1169              		.loc 1 261 55 is_stmt 0 view .LVU336
 1170 05e8 438D1464 		leal	(%r12,%r12,2), %edx
 261:misc.c        ****     }
 1171              		.loc 1 261 9 view .LVU337
 1172 05ec 4863D2   		movslq	%edx, %rdx
 1173 05ef 4889E9   		movq	%rbp, %rcx
 1174 05f2 BE010000 		movl	$1, %esi
 1174      00
 1175 05f7 4889DF   		movq	%rbx, %rdi
 1176 05fa E8000000 		call	fwrite
 1176      00
 1177              	.LVL124:
 1178 05ff EBA3     		jmp	.L46
 1179              	.LVL125:
 1180              	.L58:
 233:misc.c        ****         exit(-1);
 1181              		.loc 1 233 9 is_stmt 1 view .LVU338
 1182 0601 BF000000 		movl	$.LC24, %edi
 1182      00
 1183              	.LVL126:
 233:misc.c        ****         exit(-1);
 1184              		.loc 1 233 9 is_stmt 0 view .LVU339
 1185 0606 E8000000 		call	puts
 1185      00
 1186              	.LVL127:
 234:misc.c        ****     }
 1187              		.loc 1 234 9 is_stmt 1 view .LVU340
 1188 060b 83CFFF   		orl	$-1, %edi
 1189 060e E8000000 		call	exit
 1189      00
 1190              	.LVL128:
 1191              		.p2align 4,,10
 1192 0613 0F1F4400 		.p2align 3
 1192      00
 1193              	.L59:
 242:misc.c        ****         return -1;
 1194              		.loc 1 242 9 view .LVU341
 1195 0618 BF000000 		movl	$.LC20, %edi
 1195      00
 1196 061d E8000000 		call	puts
 1196      00
 1197              	.LVL129:
 243:misc.c        ****     }
 1198              		.loc 1 243 9 view .LVU342
 243:misc.c        ****     }
 1199              		.loc 1 243 16 is_stmt 0 view .LVU343
 1200 0622 B8FFFFFF 		movl	$-1, %eax
 1200      FF
 1201 0627 EBAC     		jmp	.L39
 1202              	.LVL130:
 1203              	.L57:
 228:misc.c        ****         exit(-1);
 1204              		.loc 1 228 9 is_stmt 1 view .LVU344
 1205 0629 BF000000 		movl	$.LC8, %edi
 1205      00
 1206              	.LVL131:
 228:misc.c        ****         exit(-1);
 1207              		.loc 1 228 9 is_stmt 0 view .LVU345
 1208 062e E8000000 		call	puts
 1208      00
 1209              	.LVL132:
 229:misc.c        ****     }
 1210              		.loc 1 229 9 is_stmt 1 view .LVU346
 1211 0633 83CFFF   		orl	$-1, %edi
 1212 0636 E8000000 		call	exit
 1212      00
 1213              	.LVL133:
 1214              		.cfi_endproc
 1215              	.LFE28:
 1217              		.section	.rodata.str1.1
 1218              	.LC28:
 1219 0075 7200     		.string	"r"
 1220              		.section	.rodata.str1.8
 1221 0222 00000000 		.align 8
 1221      0000
 1222              	.LC29:
 1223 0228 4552524F 		.string	"ERROR: no se ha encontrado el fichero %s\n"
 1223      523A206E 
 1223      6F207365 
 1223      20686120 
 1223      656E636F 
 1224 0252 00000000 		.align 8
 1224      0000
 1225              	.LC30:
 1226 0258 4552524F 		.string	"ERROR: PGM image has no header"
 1226      523A2050 
 1226      474D2069 
 1226      6D616765 
 1226      20686173 
 1227 0277 00       		.align 8
 1228              	.LC31:
 1229 0278 4552524F 		.string	"ERROR: image has different size than expected: %u x %u instead of %u x %u\n"
 1229      523A2069 
 1229      6D616765 
 1229      20686173 
 1229      20646966 
 1230              		.section	.rodata.str1.1
 1231              	.LC32:
 1232 0077 4552524F 		.string	"ERROR: unexpected EOF"
 1232      523A2075 
 1232      6E657870 
 1232      65637465 
 1232      6420454F 
 1233              	.LC33:
 1234 008d 25686875 		.string	"%hhu\n"
 1234      0A00
 1235              	.LC34:
 1236 0093 72656164 		.string	"read_PGM"
 1236      5F50474D 
 1236      00
 1237              		.text
 1238 063b 0F1F4400 		.p2align 4
 1238      00
 1239              		.globl	read_PGM
 1241              	read_PGM:
 1242              	.LVL134:
 1243              	.LFB29:
 270:misc.c        **** //----------------------------------------------------------------------------
 271:misc.c        **** 
 272:misc.c        **** int
 273:misc.c        **** read_PGM(char *filename, image_t * image)
 274:misc.c        **** {
 1244              		.loc 1 274 1 view -0
 1245              		.cfi_startproc
 275:misc.c        ****     double start_t, end_t;
 1246              		.loc 1 275 5 view .LVU348
 276:misc.c        ****     int height = 0, width =  0;
 1247              		.loc 1 276 5 view .LVU349
 274:misc.c        ****     double start_t, end_t;
 1248              		.loc 1 274 1 is_stmt 0 view .LVU350
 1249 0640 4156     		pushq	%r14
 1250              		.cfi_def_cfa_offset 16
 1251              		.cfi_offset 14, -16
 277:misc.c        ****     unsigned char *pixels  = image->pixels;
 278:misc.c        ****     char buf[256] = { 0 };
 1252              		.loc 1 278 10 view .LVU351
 1253 0642 C5F9EFC0 		vpxor	%xmm0, %xmm0, %xmm0
 279:misc.c        **** 
 280:misc.c        ****     start_t = get_wall_time();
 1254              		.loc 1 280 15 view .LVU352
 1255 0646 31C0     		xorl	%eax, %eax
 274:misc.c        ****     double start_t, end_t;
 1256              		.loc 1 274 1 view .LVU353
 1257 0648 4155     		pushq	%r13
 1258              		.cfi_def_cfa_offset 24
 1259              		.cfi_offset 13, -24
 1260 064a 4989FD   		movq	%rdi, %r13
 1261 064d 4154     		pushq	%r12
 1262              		.cfi_def_cfa_offset 32
 1263              		.cfi_offset 12, -32
 1264 064f 55       		pushq	%rbp
 1265              		.cfi_def_cfa_offset 40
 1266              		.cfi_offset 6, -40
 1267 0650 53       		pushq	%rbx
 1268              		.cfi_def_cfa_offset 48
 1269              		.cfi_offset 3, -48
 1270 0651 4889F3   		movq	%rsi, %rbx
 1271 0654 4881EC10 		subq	$272, %rsp
 1271      010000
 1272              		.cfi_def_cfa_offset 320
 277:misc.c        ****     unsigned char *pixels  = image->pixels;
 1273              		.loc 1 277 20 view .LVU354
 1274 065b 4C8B26   		movq	(%rsi), %r12
 276:misc.c        ****     unsigned char *pixels  = image->pixels;
 1275              		.loc 1 276 9 view .LVU355
 1276 065e C7442408 		movl	$0, 8(%rsp)
 1276      00000000 
 276:misc.c        ****     unsigned char *pixels  = image->pixels;
 1277              		.loc 1 276 21 view .LVU356
 1278 0666 C744240C 		movl	$0, 12(%rsp)
 1278      00000000 
 277:misc.c        ****     char buf[256] = { 0 };
 1279              		.loc 1 277 5 is_stmt 1 view .LVU357
 1280              	.LVL135:
 278:misc.c        **** 
 1281              		.loc 1 278 5 view .LVU358
 278:misc.c        **** 
 1282              		.loc 1 278 10 is_stmt 0 view .LVU359
 1283 066e C5F97F44 		vmovdqa	%xmm0, 16(%rsp)
 1283      2410
 1284 0674 C5F97F44 		vmovdqa	%xmm0, 32(%rsp)
 1284      2420
 1285 067a C5F97F44 		vmovdqa	%xmm0, 48(%rsp)
 1285      2430
 1286 0680 C5F97F44 		vmovdqa	%xmm0, 64(%rsp)
 1286      2440
 1287 0686 C5F97F44 		vmovdqa	%xmm0, 80(%rsp)
 1287      2450
 1288 068c C5F97F44 		vmovdqa	%xmm0, 96(%rsp)
 1288      2460
 1289 0692 C5F97F44 		vmovdqa	%xmm0, 112(%rsp)
 1289      2470
 1290 0698 C5F97F84 		vmovdqa	%xmm0, 128(%rsp)
 1290      24800000 
 1290      00
 1291 06a1 C5F97F84 		vmovdqa	%xmm0, 144(%rsp)
 1291      24900000 
 1291      00
 1292 06aa C5F97F84 		vmovdqa	%xmm0, 160(%rsp)
 1292      24A00000 
 1292      00
 1293 06b3 C5F97F84 		vmovdqa	%xmm0, 176(%rsp)
 1293      24B00000 
 1293      00
 1294 06bc C5F97F84 		vmovdqa	%xmm0, 192(%rsp)
 1294      24C00000 
 1294      00
 1295 06c5 C5F97F84 		vmovdqa	%xmm0, 208(%rsp)
 1295      24D00000 
 1295      00
 1296 06ce C5F97F84 		vmovdqa	%xmm0, 224(%rsp)
 1296      24E00000 
 1296      00
 1297 06d7 C5F97F84 		vmovdqa	%xmm0, 240(%rsp)
 1297      24F00000 
 1297      00
 1298 06e0 C5F97F84 		vmovdqa	%xmm0, 256(%rsp)
 1298      24000100 
 1298      00
 1299              		.loc 1 280 5 is_stmt 1 view .LVU360
 1300              		.loc 1 280 15 is_stmt 0 view .LVU361
 1301 06e9 E8000000 		call	get_wall_time
 1301      00
 1302              	.LVL136:
 281:misc.c        **** 
 282:misc.c        ****     FILE *infile = fopen(filename, "r");
 1303              		.loc 1 282 20 view .LVU362
 1304 06ee BE000000 		movl	$.LC28, %esi
 1304      00
 1305 06f3 4C89EF   		movq	%r13, %rdi
 280:misc.c        **** 
 1306              		.loc 1 280 15 view .LVU363
 1307 06f6 C4C1F97E 		vmovq	%xmm0, %r14
 1307      C6
 1308              	.LVL137:
 1309              		.loc 1 282 5 is_stmt 1 view .LVU364
 1310              		.loc 1 282 20 is_stmt 0 view .LVU365
 1311 06fb E8000000 		call	fopen
 1311      00
 1312              	.LVL138:
 283:misc.c        ****     if (!infile)
 1313              		.loc 1 283 5 is_stmt 1 view .LVU366
 1314              		.loc 1 283 8 is_stmt 0 view .LVU367
 1315 0700 4885C0   		testq	%rax, %rax
 1316 0703 0F841E01 		je	.L73
 1316      0000
 284:misc.c        ****     {
 285:misc.c        ****         printf("ERROR: no se ha encontrado el fichero %s\n", filename);
 286:misc.c        ****         exit(-1);
 287:misc.c        ****     }
 288:misc.c        ****     
 289:misc.c        ****     /* PGM header */
 290:misc.c        ****     if (fgets(buf, sizeof(buf), infile) == NULL)
 1317              		.loc 1 290 9 view .LVU368
 1318 0709 4889C2   		movq	%rax, %rdx
 1319 070c BE000100 		movl	$256, %esi
 1319      00
 1320 0711 488D7C24 		leaq	16(%rsp), %rdi
 1320      10
 1321 0716 4889C5   		movq	%rax, %rbp
 1322              		.loc 1 290 5 is_stmt 1 view .LVU369
 1323              		.loc 1 290 9 is_stmt 0 view .LVU370
 1324 0719 E8000000 		call	fgets
 1324      00
 1325              	.LVL139:
 1326              		.loc 1 290 8 view .LVU371
 1327 071e 4885C0   		testq	%rax, %rax
 1328 0721 0F84EE00 		je	.L74
 1328      0000
 291:misc.c        ****     {
 292:misc.c        ****         printf("ERROR: PGM image has no header\n");
 293:misc.c        ****         exit(-1);
 294:misc.c        ****     }
 295:misc.c        ****     sscanf(buf, "P2 %u %u 255\n",  &width, &height);
 1329              		.loc 1 295 5 is_stmt 1 view .LVU372
 1330 0727 488D4C24 		leaq	8(%rsp), %rcx
 1330      08
 1331 072c 488D5424 		leaq	12(%rsp), %rdx
 1331      0C
 1332 0731 BE000000 		movl	$.LC21, %esi
 1332      00
 1333 0736 488D7C24 		leaq	16(%rsp), %rdi
 1333      10
 1334 073b 31C0     		xorl	%eax, %eax
 1335 073d E8000000 		call	__isoc99_sscanf
 1335      00
 1336              	.LVL140:
 296:misc.c        ****     if ((width != image->width) || (height != image->height))
 1337              		.loc 1 296 5 view .LVU373
 1338              		.loc 1 296 24 is_stmt 0 view .LVU374
 1339 0742 8B4B08   		movl	8(%rbx), %ecx
 1340              		.loc 1 296 16 view .LVU375
 1341 0745 8B74240C 		movl	12(%rsp), %esi
 1342 0749 8B542408 		movl	8(%rsp), %edx
 1343              		.loc 1 296 8 view .LVU376
 1344 074d 39F1     		cmpl	%esi, %ecx
 1345 074f 0F85A800 		jne	.L63
 1345      0000
 1346              		.loc 1 296 33 discriminator 1 view .LVU377
 1347 0755 39530C   		cmpl	%edx, 12(%rbx)
 1348 0758 0F859F00 		jne	.L63
 1348      0000
 1349              	.LVL141:
 1350              	.LBB28:
 297:misc.c        ****     {
 298:misc.c        ****         printf("ERROR: image has different size than expected: %u x %u instead of %u x %u\n", width
 299:misc.c        ****         exit(-1);
 300:misc.c        ****     }
 301:misc.c        ****     
 302:misc.c        ****     for (int i=0; i < height*width; i++)
 1351              		.loc 1 302 21 is_stmt 1 view .LVU378
 1352              		.loc 1 302 29 is_stmt 0 view .LVU379
 1353 075e 0FAFCA   		imull	%edx, %ecx
 1354              		.loc 1 302 21 view .LVU380
 1355 0761 31DB     		xorl	%ebx, %ebx
 1356              	.LVL142:
 1357              		.loc 1 302 21 view .LVU381
 1358 0763 85C9     		testl	%ecx, %ecx
 1359 0765 7E45     		jle	.L65
 1360              	.LVL143:
 1361 0767 660F1F84 		.p2align 4,,10
 1361      00000000 
 1361      00
 1362              		.p2align 3
 1363              	.L64:
 303:misc.c        ****     {
 304:misc.c        ****         if (fgets(buf, sizeof(buf), infile) == NULL)
 1364              		.loc 1 304 9 is_stmt 1 view .LVU382
 1365              		.loc 1 304 13 is_stmt 0 view .LVU383
 1366 0770 4889EA   		movq	%rbp, %rdx
 1367 0773 BE000100 		movl	$256, %esi
 1367      00
 1368 0778 488D7C24 		leaq	16(%rsp), %rdi
 1368      10
 1369 077d E8000000 		call	fgets
 1369      00
 1370              	.LVL144:
 1371              		.loc 1 304 12 view .LVU384
 1372 0782 4885C0   		testq	%rax, %rax
 1373 0785 7462     		je	.L75
 305:misc.c        ****         {
 306:misc.c        ****             printf("ERROR: unexpected EOF\n");
 307:misc.c        ****             exit(-1);
 308:misc.c        ****         }
 309:misc.c        ****         sscanf(buf, "%hhu\n", &pixels[i]);
 1374              		.loc 1 309 9 is_stmt 1 discriminator 2 view .LVU385
 1375 0787 498D141C 		leaq	(%r12,%rbx), %rdx
 1376 078b BE000000 		movl	$.LC33, %esi
 1376      00
 1377 0790 488D7C24 		leaq	16(%rsp), %rdi
 1377      10
 1378 0795 31C0     		xorl	%eax, %eax
 1379 0797 E8000000 		call	__isoc99_sscanf
 1379      00
 1380              	.LVL145:
 302:misc.c        ****     {
 1381              		.loc 1 302 38 discriminator 2 view .LVU386
 302:misc.c        ****     {
 1382              		.loc 1 302 21 discriminator 2 view .LVU387
 302:misc.c        ****     {
 1383              		.loc 1 302 29 is_stmt 0 discriminator 2 view .LVU388
 1384 079c 8B442408 		movl	8(%rsp), %eax
 302:misc.c        ****     {
 1385              		.loc 1 302 21 discriminator 2 view .LVU389
 1386 07a0 48FFC3   		incq	%rbx
 1387              	.LVL146:
 302:misc.c        ****     {
 1388              		.loc 1 302 29 discriminator 2 view .LVU390
 1389 07a3 0FAF4424 		imull	12(%rsp), %eax
 1389      0C
 302:misc.c        ****     {
 1390              		.loc 1 302 21 discriminator 2 view .LVU391
 1391 07a8 39D8     		cmpl	%ebx, %eax
 1392 07aa 7FC4     		jg	.L64
 1393              	.LVL147:
 1394              	.L65:
 302:misc.c        ****     {
 1395              		.loc 1 302 21 discriminator 2 view .LVU392
 1396              	.LBE28:
 310:misc.c        ****     }
 311:misc.c        **** 
 312:misc.c        ****     fclose(infile);
 1397              		.loc 1 312 5 is_stmt 1 view .LVU393
 1398 07ac 4889EF   		movq	%rbp, %rdi
 1399 07af E8000000 		call	fclose
 1399      00
 1400              	.LVL148:
 313:misc.c        **** 
 314:misc.c        ****     end_t = get_wall_time();
 1401              		.loc 1 314 5 view .LVU394
 1402              		.loc 1 314 13 is_stmt 0 view .LVU395
 1403 07b4 31C0     		xorl	%eax, %eax
 1404 07b6 E8000000 		call	get_wall_time
 1404      00
 1405              	.LVL149:
 315:misc.c        ****     results(end_t - start_t, height*width, "read_PGM");
 1406              		.loc 1 315 5 is_stmt 1 view .LVU396
 1407 07bb 8B7C2408 		movl	8(%rsp), %edi
 1408 07bf C4C1F96E 		vmovq	%r14, %xmm1
 1408      CE
 1409 07c4 0FAF7C24 		imull	12(%rsp), %edi
 1409      0C
 1410 07c9 C5FB5CC1 		vsubsd	%xmm1, %xmm0, %xmm0
 1411              	.LVL150:
 1412              		.loc 1 315 5 is_stmt 0 view .LVU397
 1413 07cd BE000000 		movl	$.LC34, %esi
 1413      00
 1414 07d2 E8000000 		call	results
 1414      00
 1415              	.LVL151:
 316:misc.c        ****     return 0;
 1416              		.loc 1 316 5 is_stmt 1 view .LVU398
 317:misc.c        **** }
 1417              		.loc 1 317 1 is_stmt 0 view .LVU399
 1418 07d7 4881C410 		addq	$272, %rsp
 1418      010000
 1419              		.cfi_remember_state
 1420              		.cfi_def_cfa_offset 48
 1421 07de 5B       		popq	%rbx
 1422              		.cfi_def_cfa_offset 40
 1423 07df 5D       		popq	%rbp
 1424              		.cfi_def_cfa_offset 32
 1425              	.LVL152:
 1426              		.loc 1 317 1 view .LVU400
 1427 07e0 415C     		popq	%r12
 1428              		.cfi_def_cfa_offset 24
 1429              	.LVL153:
 1430              		.loc 1 317 1 view .LVU401
 1431 07e2 415D     		popq	%r13
 1432              		.cfi_def_cfa_offset 16
 1433              	.LVL154:
 1434              		.loc 1 317 1 view .LVU402
 1435 07e4 31C0     		xorl	%eax, %eax
 1436 07e6 415E     		popq	%r14
 1437              		.cfi_def_cfa_offset 8
 1438              	.LVL155:
 1439              		.loc 1 317 1 view .LVU403
 1440 07e8 C3       		ret
 1441              	.LVL156:
 1442              	.L75:
 1443              		.cfi_restore_state
 1444              	.LBB29:
 306:misc.c        ****             exit(-1);
 1445              		.loc 1 306 13 is_stmt 1 view .LVU404
 1446 07e9 BF000000 		movl	$.LC32, %edi
 1446      00
 1447 07ee E8000000 		call	puts
 1447      00
 1448              	.LVL157:
 307:misc.c        ****         }
 1449              		.loc 1 307 13 view .LVU405
 1450 07f3 BFFFFFFF 		movl	$-1, %edi
 1450      FF
 1451 07f8 E8000000 		call	exit
 1451      00
 1452              	.LVL158:
 1453              	.L63:
 307:misc.c        ****         }
 1454              		.loc 1 307 13 is_stmt 0 view .LVU406
 1455              	.LBE29:
 298:misc.c        ****         exit(-1);
 1456              		.loc 1 298 9 is_stmt 1 view .LVU407
 1457 07fd 448B430C 		movl	12(%rbx), %r8d
 1458 0801 BF000000 		movl	$.LC31, %edi
 1458      00
 1459 0806 31C0     		xorl	%eax, %eax
 1460 0808 E8000000 		call	printf
 1460      00
 1461              	.LVL159:
 299:misc.c        ****     }
 1462              		.loc 1 299 9 view .LVU408
 1463 080d 83CFFF   		orl	$-1, %edi
 1464 0810 E8000000 		call	exit
 1464      00
 1465              	.LVL160:
 1466              	.L74:
 292:misc.c        ****         exit(-1);
 1467              		.loc 1 292 9 view .LVU409
 1468 0815 BF000000 		movl	$.LC30, %edi
 1468      00
 1469 081a E8000000 		call	puts
 1469      00
 1470              	.LVL161:
 293:misc.c        ****     }
 1471              		.loc 1 293 9 view .LVU410
 1472 081f 83CFFF   		orl	$-1, %edi
 1473 0822 E8000000 		call	exit
 1473      00
 1474              	.LVL162:
 1475              	.L73:
 285:misc.c        ****         exit(-1);
 1476              		.loc 1 285 9 view .LVU411
 1477 0827 BF000000 		movl	$.LC29, %edi
 1477      00
 1478 082c 4C89EE   		movq	%r13, %rsi
 1479 082f 31C0     		xorl	%eax, %eax
 1480              	.LVL163:
 285:misc.c        ****         exit(-1);
 1481              		.loc 1 285 9 is_stmt 0 view .LVU412
 1482 0831 E8000000 		call	printf
 1482      00
 1483              	.LVL164:
 286:misc.c        ****     }
 1484              		.loc 1 286 9 is_stmt 1 view .LVU413
 1485 0836 83CFFF   		orl	$-1, %edi
 1486 0839 E8000000 		call	exit
 1486      00
 1487              	.LVL165:
 1488              		.cfi_endproc
 1489              	.LFE29:
 1491              		.section	.rodata.str1.8
 1492 02c3 00000000 		.align 8
 1492      00
 1493              	.LC35:
 1494 02c8 4552524F 		.string	"ERROR: PPM image has no header"
 1494      523A2050 
 1494      504D2069 
 1494      6D616765 
 1494      20686173 
 1495 02e7 00       		.align 8
 1496              	.LC36:
 1497 02e8 4552524F 		.string	"ERROR: image has different format (%u) than expected (%u)\n"
 1497      523A2069 
 1497      6D616765 
 1497      20686173 
 1497      20646966 
 1498              		.section	.rodata.str1.1
 1499              	.LC37:
 1500 009c 72656164 		.string	"read_PPM"
 1500      5F50504D 
 1500      00
 1501              	.LC38:
 1502 00a5 25686875 		.string	"%hhu %hhu %hhu\n"
 1502      20256868 
 1502      75202568 
 1502      68750A00 
 1503              		.text
 1504 083e 6690     		.p2align 4
 1505              		.globl	read_PPM
 1507              	read_PPM:
 1508              	.LVL166:
 1509              	.LFB30:
 318:misc.c        **** //----------------------------------------------------------------------------
 319:misc.c        **** 
 320:misc.c        **** // format: 3 -> ascii  (P3 magic number)
 321:misc.c        **** // format: 6 -> binary (P6 magic number)
 322:misc.c        **** int
 323:misc.c        **** read_PPM(char *filename, image_t * image, int format)
 324:misc.c        **** {
 1510              		.loc 1 324 1 view -0
 1511              		.cfi_startproc
 325:misc.c        ****     double start_t, end_t;
 1512              		.loc 1 325 5 view .LVU415
 326:misc.c        ****     int n = 0, height = 0, width =  0;
 1513              		.loc 1 326 5 view .LVU416
 324:misc.c        ****     double start_t, end_t;
 1514              		.loc 1 324 1 is_stmt 0 view .LVU417
 1515 0840 4157     		pushq	%r15
 1516              		.cfi_def_cfa_offset 16
 1517              		.cfi_offset 15, -16
 327:misc.c        ****     int img_format = 0;
 328:misc.c        ****     unsigned char *pixels  = image->pixels;
 329:misc.c        ****     char buf[256] = { 0 };
 1518              		.loc 1 329 10 view .LVU418
 1519 0842 C5F9EFC0 		vpxor	%xmm0, %xmm0, %xmm0
 330:misc.c        **** 
 331:misc.c        ****     start_t = get_wall_time();
 1520              		.loc 1 331 15 view .LVU419
 1521 0846 31C0     		xorl	%eax, %eax
 324:misc.c        ****     double start_t, end_t;
 1522              		.loc 1 324 1 view .LVU420
 1523 0848 4156     		pushq	%r14
 1524              		.cfi_def_cfa_offset 24
 1525              		.cfi_offset 14, -24
 1526 084a 4989FE   		movq	%rdi, %r14
 1527 084d 4155     		pushq	%r13
 1528              		.cfi_def_cfa_offset 32
 1529              		.cfi_offset 13, -32
 1530 084f 4989F5   		movq	%rsi, %r13
 1531 0852 4154     		pushq	%r12
 1532              		.cfi_def_cfa_offset 40
 1533              		.cfi_offset 12, -40
 1534 0854 55       		pushq	%rbp
 1535              		.cfi_def_cfa_offset 48
 1536              		.cfi_offset 6, -48
 1537 0855 89D5     		movl	%edx, %ebp
 1538 0857 53       		pushq	%rbx
 1539              		.cfi_def_cfa_offset 56
 1540              		.cfi_offset 3, -56
 1541 0858 4881EC18 		subq	$280, %rsp
 1541      010000
 1542              		.cfi_def_cfa_offset 336
 328:misc.c        ****     char buf[256] = { 0 };
 1543              		.loc 1 328 20 view .LVU421
 1544 085f 488B1E   		movq	(%rsi), %rbx
 326:misc.c        ****     int img_format = 0;
 1545              		.loc 1 326 16 view .LVU422
 1546 0862 C7442404 		movl	$0, 4(%rsp)
 1546      00000000 
 326:misc.c        ****     int img_format = 0;
 1547              		.loc 1 326 28 view .LVU423
 1548 086a C7442408 		movl	$0, 8(%rsp)
 1548      00000000 
 327:misc.c        ****     unsigned char *pixels  = image->pixels;
 1549              		.loc 1 327 5 is_stmt 1 view .LVU424
 327:misc.c        ****     unsigned char *pixels  = image->pixels;
 1550              		.loc 1 327 9 is_stmt 0 view .LVU425
 1551 0872 C744240C 		movl	$0, 12(%rsp)
 1551      00000000 
 328:misc.c        ****     char buf[256] = { 0 };
 1552              		.loc 1 328 5 is_stmt 1 view .LVU426
 1553              	.LVL167:
 329:misc.c        **** 
 1554              		.loc 1 329 5 view .LVU427
 329:misc.c        **** 
 1555              		.loc 1 329 10 is_stmt 0 view .LVU428
 1556 087a C5F97F44 		vmovdqa	%xmm0, 16(%rsp)
 1556      2410
 1557 0880 C5F97F44 		vmovdqa	%xmm0, 32(%rsp)
 1557      2420
 1558 0886 C5F97F44 		vmovdqa	%xmm0, 48(%rsp)
 1558      2430
 1559 088c C5F97F44 		vmovdqa	%xmm0, 64(%rsp)
 1559      2440
 1560 0892 C5F97F44 		vmovdqa	%xmm0, 80(%rsp)
 1560      2450
 1561 0898 C5F97F44 		vmovdqa	%xmm0, 96(%rsp)
 1561      2460
 1562 089e C5F97F44 		vmovdqa	%xmm0, 112(%rsp)
 1562      2470
 1563 08a4 C5F97F84 		vmovdqa	%xmm0, 128(%rsp)
 1563      24800000 
 1563      00
 1564 08ad C5F97F84 		vmovdqa	%xmm0, 144(%rsp)
 1564      24900000 
 1564      00
 1565 08b6 C5F97F84 		vmovdqa	%xmm0, 160(%rsp)
 1565      24A00000 
 1565      00
 1566 08bf C5F97F84 		vmovdqa	%xmm0, 176(%rsp)
 1566      24B00000 
 1566      00
 1567 08c8 C5F97F84 		vmovdqa	%xmm0, 192(%rsp)
 1567      24C00000 
 1567      00
 1568 08d1 C5F97F84 		vmovdqa	%xmm0, 208(%rsp)
 1568      24D00000 
 1568      00
 1569 08da C5F97F84 		vmovdqa	%xmm0, 224(%rsp)
 1569      24E00000 
 1569      00
 1570 08e3 C5F97F84 		vmovdqa	%xmm0, 240(%rsp)
 1570      24F00000 
 1570      00
 1571 08ec C5F97F84 		vmovdqa	%xmm0, 256(%rsp)
 1571      24000100 
 1571      00
 1572              		.loc 1 331 5 is_stmt 1 view .LVU429
 1573              		.loc 1 331 15 is_stmt 0 view .LVU430
 1574 08f5 E8000000 		call	get_wall_time
 1574      00
 1575              	.LVL168:
 332:misc.c        **** 
 333:misc.c        ****     FILE *infile = fopen(filename, "r");
 1576              		.loc 1 333 20 view .LVU431
 1577 08fa BE000000 		movl	$.LC28, %esi
 1577      00
 1578 08ff 4C89F7   		movq	%r14, %rdi
 331:misc.c        **** 
 1579              		.loc 1 331 15 view .LVU432
 1580 0902 C4C1F97E 		vmovq	%xmm0, %r15
 1580      C7
 1581              	.LVL169:
 1582              		.loc 1 333 5 is_stmt 1 view .LVU433
 1583              		.loc 1 333 20 is_stmt 0 view .LVU434
 1584 0907 E8000000 		call	fopen
 1584      00
 1585              	.LVL170:
 334:misc.c        ****     if (!infile)
 1586              		.loc 1 334 5 is_stmt 1 view .LVU435
 1587              		.loc 1 334 8 is_stmt 0 view .LVU436
 1588 090c 4885C0   		testq	%rax, %rax
 1589 090f 0F846C01 		je	.L98
 1589      0000
 1590 0915 4989C4   		movq	%rax, %r12
 335:misc.c        ****     {
 336:misc.c        ****         printf("ERROR: no se ha encontrado el fichero %s\n", filename);
 337:misc.c        ****         exit(-1);
 338:misc.c        ****     }
 339:misc.c        ****     if ((format != 3) && (format != 6))
 1591              		.loc 1 339 5 is_stmt 1 view .LVU437
 1592              		.loc 1 339 8 is_stmt 0 view .LVU438
 1593 0918 83FD03   		cmpl	$3, %ebp
 1594 091b 7409     		je	.L78
 1595 091d 83FD06   		cmpl	$6, %ebp
 1596 0920 0F859A01 		jne	.L99
 1596      0000
 1597              	.L78:
 340:misc.c        ****     {
 341:misc.c        ****         printf("ERROR: bad format number (3 or 6)\n");
 342:misc.c        ****         exit(-1);
 343:misc.c        ****     }
 344:misc.c        ****     
 345:misc.c        ****     /* PPM header */
 346:misc.c        ****     if (fgets(buf, sizeof(buf), infile) == NULL)
 1598              		.loc 1 346 5 is_stmt 1 view .LVU439
 1599              		.loc 1 346 9 is_stmt 0 view .LVU440
 1600 0926 4C89E2   		movq	%r12, %rdx
 1601 0929 BE000100 		movl	$256, %esi
 1601      00
 1602 092e 488D7C24 		leaq	16(%rsp), %rdi
 1602      10
 1603 0933 E8000000 		call	fgets
 1603      00
 1604              	.LVL171:
 1605              		.loc 1 346 8 view .LVU441
 1606 0938 4885C0   		testq	%rax, %rax
 1607 093b 0F846D01 		je	.L100
 1607      0000
 347:misc.c        ****     {
 348:misc.c        ****         printf("ERROR: PPM image has no header\n");
 349:misc.c        ****         exit(-1);
 350:misc.c        ****     }
 351:misc.c        ****     sscanf(buf, "P%u %u %u 255\n", &img_format, &width, &height);
 1608              		.loc 1 351 5 is_stmt 1 view .LVU442
 1609 0941 BE000000 		movl	$.LC25, %esi
 1609      00
 1610 0946 4C8D4424 		leaq	4(%rsp), %r8
 1610      04
 1611 094b 488D4C24 		leaq	8(%rsp), %rcx
 1611      08
 1612 0950 488D5424 		leaq	12(%rsp), %rdx
 1612      0C
 1613 0955 488D7C24 		leaq	16(%rsp), %rdi
 1613      10
 1614 095a 31C0     		xorl	%eax, %eax
 1615 095c E8000000 		call	__isoc99_sscanf
 1615      00
 1616              	.LVL172:
 352:misc.c        ****     if (img_format != format)
 1617              		.loc 1 352 5 view .LVU443
 1618              		.loc 1 352 20 is_stmt 0 view .LVU444
 1619 0961 8B74240C 		movl	12(%rsp), %esi
 1620              		.loc 1 352 8 view .LVU445
 1621 0965 39EE     		cmpl	%ebp, %esi
 1622 0967 0F852B01 		jne	.L101
 1622      0000
 353:misc.c        ****     {
 354:misc.c        ****         printf("ERROR: image has different format (%u) than expected (%u)\n", img_format, format);
 355:misc.c        ****         exit(-1);
 356:misc.c        ****     }
 357:misc.c        ****     if ((width != image->width) || (height != image->height))
 1623              		.loc 1 357 5 is_stmt 1 view .LVU446
 1624              		.loc 1 357 24 is_stmt 0 view .LVU447
 1625 096d 418B4D08 		movl	8(%r13), %ecx
 1626              		.loc 1 357 16 view .LVU448
 1627 0971 8B742408 		movl	8(%rsp), %esi
 1628              		.loc 1 357 52 view .LVU449
 1629 0975 458B450C 		movl	12(%r13), %r8d
 1630              		.loc 1 357 44 view .LVU450
 1631 0979 8B542404 		movl	4(%rsp), %edx
 1632              		.loc 1 357 8 view .LVU451
 1633 097d 39F1     		cmpl	%esi, %ecx
 1634 097f 0F85E800 		jne	.L81
 1634      0000
 1635              		.loc 1 357 33 discriminator 1 view .LVU452
 1636 0985 4139D0   		cmpl	%edx, %r8d
 1637 0988 0F85DF00 		jne	.L81
 1637      0000
 358:misc.c        ****     {
 359:misc.c        ****         printf("ERROR: image has different size than expected: %u x %u instead of %u x %u\n", width
 360:misc.c        ****         exit(-1);
 361:misc.c        ****     }
 362:misc.c        ****     
 363:misc.c        ****     if (format == 3)
 1638              		.loc 1 363 5 is_stmt 1 view .LVU453
 1639              	.LBB30:
 364:misc.c        ****     {
 365:misc.c        ****         for (int i=0; i<height*width; i++)
 1640              		.loc 1 365 31 is_stmt 0 view .LVU454
 1641 098e 410FAFC8 		imull	%r8d, %ecx
 1642              	.LBE30:
 363:misc.c        ****     {
 1643              		.loc 1 363 8 view .LVU455
 1644 0992 83FD03   		cmpl	$3, %ebp
 1645 0995 0F859D00 		jne	.L83
 1645      0000
 1646              	.LVL173:
 1647              	.LBB31:
 1648              		.loc 1 365 24 is_stmt 1 view .LVU456
 1649              		.loc 1 365 18 is_stmt 0 view .LVU457
 1650 099b 31ED     		xorl	%ebp, %ebp
 1651              	.LVL174:
 1652              		.loc 1 365 24 view .LVU458
 1653 099d 85C9     		testl	%ecx, %ecx
 1654 099f 7E51     		jle	.L88
 1655              	.LVL175:
 1656              		.p2align 4,,10
 1657 09a1 0F1F8000 		.p2align 3
 1657      000000
 1658              	.L87:
 366:misc.c        ****         {
 367:misc.c        ****             if (fgets(buf, sizeof(buf), infile) == NULL)
 1659              		.loc 1 367 13 is_stmt 1 view .LVU459
 1660              		.loc 1 367 17 is_stmt 0 view .LVU460
 1661 09a8 4C89E2   		movq	%r12, %rdx
 1662 09ab BE000100 		movl	$256, %esi
 1662      00
 1663 09b0 488D7C24 		leaq	16(%rsp), %rdi
 1663      10
 1664 09b5 E8000000 		call	fgets
 1664      00
 1665              	.LVL176:
 1666              		.loc 1 367 16 view .LVU461
 1667 09ba 4885C0   		testq	%rax, %rax
 1668 09bd 0F849600 		je	.L102
 1668      0000
 368:misc.c        ****             {
 369:misc.c        ****                 printf("ERROR: unexpected EOF\n");
 370:misc.c        ****                 exit(-1);
 371:misc.c        ****             }
 372:misc.c        ****             sscanf(buf, "%hhu %hhu %hhu\n",
 1669              		.loc 1 372 13 is_stmt 1 discriminator 2 view .LVU462
 1670 09c3 488D4B01 		leaq	1(%rbx), %rcx
 1671 09c7 4C8D4302 		leaq	2(%rbx), %r8
 1672 09cb 4889DA   		movq	%rbx, %rdx
 1673 09ce BE000000 		movl	$.LC38, %esi
 1673      00
 1674 09d3 488D7C24 		leaq	16(%rsp), %rdi
 1674      10
 1675 09d8 31C0     		xorl	%eax, %eax
 1676 09da E8000000 		call	__isoc99_sscanf
 1676      00
 1677              	.LVL177:
 365:misc.c        ****         {
 1678              		.loc 1 365 40 discriminator 2 view .LVU463
 365:misc.c        ****         {
 1679              		.loc 1 365 31 is_stmt 0 discriminator 2 view .LVU464
 1680 09df 8B442404 		movl	4(%rsp), %eax
 365:misc.c        ****         {
 1681              		.loc 1 365 40 discriminator 2 view .LVU465
 1682 09e3 FFC5     		incl	%ebp
 1683              	.LVL178:
 365:misc.c        ****         {
 1684              		.loc 1 365 24 is_stmt 1 discriminator 2 view .LVU466
 365:misc.c        ****         {
 1685              		.loc 1 365 31 is_stmt 0 discriminator 2 view .LVU467
 1686 09e5 0FAF4424 		imull	8(%rsp), %eax
 1686      08
 365:misc.c        ****         {
 1687              		.loc 1 365 24 discriminator 2 view .LVU468
 1688 09ea 4883C303 		addq	$3, %rbx
 1689 09ee 39E8     		cmpl	%ebp, %eax
 1690 09f0 7FB6     		jg	.L87
 1691              	.LVL179:
 1692              	.L88:
 365:misc.c        ****         {
 1693              		.loc 1 365 24 discriminator 2 view .LVU469
 1694              	.LBE31:
 373:misc.c        ****                     &pixels[3*i+0],
 374:misc.c        ****                     &pixels[3*i+1],
 375:misc.c        ****                     &pixels[3*i+2]);
 376:misc.c        ****         }
 377:misc.c        ****     }
 378:misc.c        ****     else
 379:misc.c        ****     {
 380:misc.c        ****         n = fread(pixels, sizeof(unsigned char), 3*height*width, infile);
 381:misc.c        ****         if (n == 0) return -1;
 382:misc.c        ****     }
 383:misc.c        **** 
 384:misc.c        ****     fclose(infile);
 1695              		.loc 1 384 5 is_stmt 1 view .LVU470
 1696 09f2 4C89E7   		movq	%r12, %rdi
 1697 09f5 E8000000 		call	fclose
 1697      00
 1698              	.LVL180:
 385:misc.c        **** 
 386:misc.c        ****     end_t = get_wall_time();
 1699              		.loc 1 386 5 view .LVU471
 1700              		.loc 1 386 13 is_stmt 0 view .LVU472
 1701 09fa 31C0     		xorl	%eax, %eax
 1702 09fc E8000000 		call	get_wall_time
 1702      00
 1703              	.LVL181:
 387:misc.c        ****     results(end_t - start_t, height*width, "read_PPM");
 1704              		.loc 1 387 5 is_stmt 1 view .LVU473
 1705 0a01 8B7C2404 		movl	4(%rsp), %edi
 1706 0a05 C4C1F96E 		vmovq	%r15, %xmm1
 1706      CF
 1707 0a0a 0FAF7C24 		imull	8(%rsp), %edi
 1707      08
 1708 0a0f C5FB5CC1 		vsubsd	%xmm1, %xmm0, %xmm0
 1709              	.LVL182:
 1710              		.loc 1 387 5 is_stmt 0 view .LVU474
 1711 0a13 BE000000 		movl	$.LC37, %esi
 1711      00
 1712 0a18 E8000000 		call	results
 1712      00
 1713              	.LVL183:
 388:misc.c        ****     return 0;
 1714              		.loc 1 388 5 is_stmt 1 view .LVU475
 1715              		.loc 1 388 12 is_stmt 0 view .LVU476
 1716 0a1d 31C0     		xorl	%eax, %eax
 1717              	.LVL184:
 1718              	.L76:
 389:misc.c        **** }
 1719              		.loc 1 389 1 view .LVU477
 1720 0a1f 4881C418 		addq	$280, %rsp
 1720      010000
 1721              		.cfi_remember_state
 1722              		.cfi_def_cfa_offset 56
 1723 0a26 5B       		popq	%rbx
 1724              		.cfi_def_cfa_offset 48
 1725 0a27 5D       		popq	%rbp
 1726              		.cfi_def_cfa_offset 40
 1727 0a28 415C     		popq	%r12
 1728              		.cfi_def_cfa_offset 32
 1729              	.LVL185:
 1730              		.loc 1 389 1 view .LVU478
 1731 0a2a 415D     		popq	%r13
 1732              		.cfi_def_cfa_offset 24
 1733              	.LVL186:
 1734              		.loc 1 389 1 view .LVU479
 1735 0a2c 415E     		popq	%r14
 1736              		.cfi_def_cfa_offset 16
 1737              	.LVL187:
 1738              		.loc 1 389 1 view .LVU480
 1739 0a2e 415F     		popq	%r15
 1740              		.cfi_def_cfa_offset 8
 1741              	.LVL188:
 1742              		.loc 1 389 1 view .LVU481
 1743 0a30 C3       		ret
 1744              	.LVL189:
 1745              		.p2align 4,,10
 1746 0a31 0F1F8000 		.p2align 3
 1746      000000
 1747              	.L83:
 1748              		.cfi_restore_state
 380:misc.c        ****         if (n == 0) return -1;
 1749              		.loc 1 380 9 is_stmt 1 view .LVU482
 380:misc.c        ****         if (n == 0) return -1;
 1750              		.loc 1 380 58 is_stmt 0 view .LVU483
 1751 0a38 8D1449   		leal	(%rcx,%rcx,2), %edx
 380:misc.c        ****         if (n == 0) return -1;
 1752              		.loc 1 380 13 view .LVU484
 1753 0a3b 4863D2   		movslq	%edx, %rdx
 1754 0a3e 4C89E1   		movq	%r12, %rcx
 1755 0a41 BE010000 		movl	$1, %esi
 1755      00
 1756 0a46 4889DF   		movq	%rbx, %rdi
 1757 0a49 E8000000 		call	fread
 1757      00
 1758              	.LVL190:
 381:misc.c        ****     }
 1759              		.loc 1 381 9 is_stmt 1 view .LVU485
 381:misc.c        ****     }
 1760              		.loc 1 381 12 is_stmt 0 view .LVU486
 1761 0a4e 85C0     		testl	%eax, %eax
 1762 0a50 75A0     		jne	.L88
 381:misc.c        ****     }
 1763              		.loc 1 381 28 view .LVU487
 1764 0a52 B8FFFFFF 		movl	$-1, %eax
 1764      FF
 1765              	.LVL191:
 381:misc.c        ****     }
 1766              		.loc 1 381 28 view .LVU488
 1767 0a57 EBC6     		jmp	.L76
 1768              	.LVL192:
 1769              	.L102:
 1770              	.LBB32:
 369:misc.c        ****                 exit(-1);
 1771              		.loc 1 369 17 is_stmt 1 view .LVU489
 1772 0a59 BF000000 		movl	$.LC32, %edi
 1772      00
 1773 0a5e E8000000 		call	puts
 1773      00
 1774              	.LVL193:
 370:misc.c        ****             }
 1775              		.loc 1 370 17 view .LVU490
 1776 0a63 BFFFFFFF 		movl	$-1, %edi
 1776      FF
 1777 0a68 E8000000 		call	exit
 1777      00
 1778              	.LVL194:
 1779              	.L81:
 370:misc.c        ****             }
 1780              		.loc 1 370 17 is_stmt 0 view .LVU491
 1781              	.LBE32:
 359:misc.c        ****         exit(-1);
 1782              		.loc 1 359 9 is_stmt 1 view .LVU492
 1783 0a6d BF000000 		movl	$.LC31, %edi
 1783      00
 1784 0a72 31C0     		xorl	%eax, %eax
 1785 0a74 E8000000 		call	printf
 1785      00
 1786              	.LVL195:
 360:misc.c        ****     }
 1787              		.loc 1 360 9 view .LVU493
 1788 0a79 83CFFF   		orl	$-1, %edi
 1789 0a7c E8000000 		call	exit
 1789      00
 1790              	.LVL196:
 1791              	.L98:
 336:misc.c        ****         exit(-1);
 1792              		.loc 1 336 9 view .LVU494
 1793 0a81 BF000000 		movl	$.LC29, %edi
 1793      00
 1794 0a86 4C89F6   		movq	%r14, %rsi
 1795 0a89 31C0     		xorl	%eax, %eax
 1796              	.LVL197:
 336:misc.c        ****         exit(-1);
 1797              		.loc 1 336 9 is_stmt 0 view .LVU495
 1798 0a8b E8000000 		call	printf
 1798      00
 1799              	.LVL198:
 337:misc.c        ****     }
 1800              		.loc 1 337 9 is_stmt 1 view .LVU496
 1801 0a90 83CFFF   		orl	$-1, %edi
 1802 0a93 E8000000 		call	exit
 1802      00
 1803              	.LVL199:
 1804              	.L101:
 354:misc.c        ****         exit(-1);
 1805              		.loc 1 354 9 view .LVU497
 1806 0a98 BF000000 		movl	$.LC36, %edi
 1806      00
 1807 0a9d 89EA     		movl	%ebp, %edx
 1808 0a9f 31C0     		xorl	%eax, %eax
 1809 0aa1 E8000000 		call	printf
 1809      00
 1810              	.LVL200:
 355:misc.c        ****     }
 1811              		.loc 1 355 9 view .LVU498
 1812 0aa6 83CFFF   		orl	$-1, %edi
 1813 0aa9 E8000000 		call	exit
 1813      00
 1814              	.LVL201:
 1815              	.L100:
 348:misc.c        ****         exit(-1);
 1816              		.loc 1 348 9 view .LVU499
 1817 0aae BF000000 		movl	$.LC35, %edi
 1817      00
 1818 0ab3 E8000000 		call	puts
 1818      00
 1819              	.LVL202:
 349:misc.c        ****     }
 1820              		.loc 1 349 9 view .LVU500
 1821 0ab8 83CFFF   		orl	$-1, %edi
 1822 0abb E8000000 		call	exit
 1822      00
 1823              	.LVL203:
 1824              	.L99:
 341:misc.c        ****         exit(-1);
 1825              		.loc 1 341 9 view .LVU501
 1826 0ac0 BF000000 		movl	$.LC24, %edi
 1826      00
 1827 0ac5 E8000000 		call	puts
 1827      00
 1828              	.LVL204:
 342:misc.c        ****     }
 1829              		.loc 1 342 9 view .LVU502
 1830 0aca 83CFFF   		orl	$-1, %edi
 1831 0acd E8000000 		call	exit
 1831      00
 1832              	.LVL205:
 1833              		.cfi_endproc
 1834              	.LFE30:
 1836              		.section	.rodata.cst8,"aM",@progbits,8
 1837              		.align 8
 1838              	.LC0:
 1839 0000 8DEDB5A0 		.long	-1598689907
 1840 0004 F7C6B03E 		.long	1051772663
 1841              		.align 8
 1842              	.LC1:
 1843 0008 95D626E8 		.long	-400107883
 1844 000c 0B2E113E 		.long	1041313291
 1845              		.align 8
 1846              	.LC2:
 1847 0010 00000000 		.long	0
 1848 0014 65CDCD41 		.long	1104006501
 1849              		.align 8
 1850              	.LC3:
 1851 0018 00000000 		.long	0
 1852 001c 00005940 		.long	1079574528
 1853              		.align 8
 1854              	.LC14:
 1855 0020 00000000 		.long	0
 1856 0024 00408F40 		.long	1083129856
 1857              		.text
 1858              	.Letext0:
 1859              		.file 2 "/opt/rh/gcc-toolset-12/root/usr/lib/gcc/x86_64-redhat-linux/12/include/stddef.h"
 1860              		.file 3 "/usr/include/bits/types.h"
 1861              		.file 4 "/usr/include/bits/types/struct_FILE.h"
 1862              		.file 5 "/usr/include/bits/types/FILE.h"
 1863              		.file 6 "/usr/include/bits/types/clock_t.h"
 1864              		.file 7 "/usr/include/bits/types/struct_timeval.h"
 1865              		.file 8 "/usr/include/sys/time.h"
 1866              		.file 9 "jpeg_handler.h"
 1867              		.file 10 "/usr/include/stdio.h"
 1868              		.file 11 "/usr/include/stdlib.h"
 1869              		.file 12 "<built-in>"
 1870              		.file 13 "include/jpeglib.h"
 1871              		.file 14 "/usr/include/time.h"
