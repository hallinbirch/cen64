//
// arch/x86_64/rsp/vor.s
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
#

.ifdef __MINGW32__
.globl RSP_VOR
.def RSP_VOR; .scl 2; .type 32; .endef
.seh_proc RSP_VOR
RSP_VOR:
.else
.global RSP_VOR
.type	RSP_VOR, @function
RSP_VOR:
.endif

RSP_VOR:
  por %xmm1, %xmm0
  movdqa %xmm0, %xmm5
  retq

.ifdef __MINGW32__
.seh_endproc
.else
.size RSP_VOR,.-RSP_VOR
.endif

