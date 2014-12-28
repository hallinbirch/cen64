//
// arch/x86_64/rsp/vge.s
//
// CEN64: Cycle-Accurate Nintendo 64 Simulator.
// Copyright (C) 2014, Tyler J. Stachecki.
//
// This file is subject to the terms and conditions defined in
// 'LICENSE', which is part of this source code package.
//

#
# xmm1 = vs
# xmm0 = vt
# xmm5 = acc_lo
# xmm11 = vcc_lo
# xmm12 = vcc_hi
# xmm13 = vco_lo
# xmm14 = vco_hi
#

.ifdef __MINGW32__
.globl RSP_VGE
.def RSP_VGE; .scl 2; .type 32; .endef
.seh_proc RSP_VGE
RSP_VGE:
.else
.global RSP_VGE
.type	RSP_VGE, @function
RSP_VGE:
.endif

.ifdef __AVX__
  vpand %xmm13, %xmm14, %xmm2
  vpcmpeqw %xmm1, %xmm0, %xmm3
  vpcmpgtw %xmm0, %xmm1, %xmm4
  pxor %xmm14, %xmm14
  vpandn %xmm3, %xmm2, %xmm3
  pxor %xmm13, %xmm13
  vpor %xmm3, %xmm4, %xmm11
  pxor %xmm12, %xmm12
  vpblendvb %xmm11, %xmm1, %xmm0, %xmm0
  movdqa %xmm0, %xmm5
  retq

.elseif __SSE4_1__ == 1
  movdqa %xmm0, %xmm5
  movdqa %xmm0, %xmm2
  movdqa %xmm1, %xmm0
  pand %xmm13, %xmm14
  pcmpgtw %xmm2, %xmm0
  pxor %xmm12, %xmm12
  pcmpeqw %xmm1, %xmm2
  pandn %xmm2, %xmm14
  pxor %xmm13, %xmm13
  por %xmm14, %xmm0
  pxor %xmm14, %xmm14
  pblendvb %xmm0, %xmm1, %xmm5
  movdqa %xmm0, %xmm11
  movdqa %xmm5, %xmm0
  retq

.else
  movdqa %xmm1, %xmm5
  movdqa %xmm1, %xmm2
  pand %xmm13, %xmm14
  pcmpgtw %xmm0, %xmm1
  pcmpeqw %xmm0, %xmm2
  pxor %xmm12, %xmm12
  pandn %xmm2, %xmm14
  pxor %xmm13, %xmm13
  por %xmm14, %xmm1
  movdqa %xmm1,%xmm11
  pand %xmm1, %xmm5
  pandn %xmm0, %xmm1
  por %xmm1, %xmm5
  movdqa %xmm5, %xmm0
  pxor %xmm14, %xmm14
  retq
.endif

.ifdef __MINGW32__
.seh_endproc
.else
.size RSP_VGE,.-RSP_VGE
.endif

