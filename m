Return-Path: <linux-edac+bounces-2931-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA81AA17D93
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jan 2025 13:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720DF1886AC5
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jan 2025 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625D71F193A;
	Tue, 21 Jan 2025 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bVykcsH+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF431F1937;
	Tue, 21 Jan 2025 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737461418; cv=none; b=Ul21UdVE8tEHWkOInFlnlALzgdXb+4tFmwH/v6DRngMkseNLcl0CW4jjU6vzwsoIGv/UB+lftPCWiy9sO7RRCZyRijv1uAoLpVrtC+uHsJy/XlCTY3H+E3lBLJqBgi/j2f4JEZqb56rbSzxPwZRkbMoAoZdErzUaysertlj/Q8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737461418; c=relaxed/simple;
	bh=44q6sFQz8ZmQ3fFlicqaNkdf0vzc2ihTMsQHJeGl2iw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oPgOpZl7boKe9rli5BUXtQCQoV/zvfB3MbcxA8gBoL+XlsTNCrxL8TrlDPVBPgyhhkvpEzuy6ippaidMop+cLiFc3zla4gZaBZicEyQxiWqMsvS6V4KZzVu1eo+QZnLtoS+nvUxFDhXgaKC0Dv62umGzGP/D4jlc2q81+XmGTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bVykcsH+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B2F3040E0277;
	Tue, 21 Jan 2025 12:10:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yjZmrFpyJ91a; Tue, 21 Jan 2025 12:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1737461410; bh=0ZfNZtIHiPyGCQVriAAeNl0ZGjU7zhvpggmQhUwCxl4=;
	h=Date:From:To:Cc:Subject:From;
	b=bVykcsH+e4UMJycanWSIFdG/9nMOwaSvP8KCSeUHkK9pkUhVrcQfVJTNdcqlcK80y
	 0c/6Wkxz6N1DSaputL+3Tuan86qQ9s37lwJlX/K9bfuk42IeM3/1mqHestBrnmS7bB
	 GdYaqAvEwjBEv8WZGMnf4Bkk4ZJxe1s6j3sLHFBnNaopxBhyHIHRWRXyTZ5ea+ksb3
	 thzF9IxleNd2I2US+yj0jSw7ExigGXK4feKppMB8U8vh+/auyV8+mRat2i1kytJBWb
	 VCWNKPGwA/5+g/hguQRt5D561fWBkJ28gk3WRIQ+srEYSbbzC/pld34KNm/e7llJqh
	 iVRTQDWHnfU1i/0XX170wxI8F0o5ke/ZqqgHUzHQ9euegduFbk79TR3lKXY5PQC6/L
	 zodoz/4rHSMvJElG5o/Cnp2RRDDBAp/E2WEnIdED+PH8wN8aXvfkWmW8THuMqkK1J/
	 xunrGsOlrNeguiXOL3u6vEHA+Cf1Qo0qYAn1x/4PTh820Kn2scQir/u/g3d7ax7hFz
	 T2rdYcBAHuH6wUJEdiWNyfBaf2e5xkCb6oJBW9dJW5AOQA4+T7DVIBgb3UmjVNyXBI
	 EU7SZXLxJkwASqThTvZb5gNJxjz7PiBlppquVSKRJeV8nJTNLhfE3LXKFs8Ln9qTIK
	 08c59qFVpiXx24XAES/BcARw=
Received: from zn.tnic (pd953008e.dip0.t-ipconnect.de [217.83.0.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7049040E015F;
	Tue, 21 Jan 2025 12:10:06 +0000 (UTC)
Date: Tue, 21 Jan 2025 13:09:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	linux-edac <linux-edac@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for v6.14-rc1
Message-ID: <20250121120957.GAZ4-Old2JOsTkUGf4@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/cpu lineup for v6.14-rc1.

If you've pulled in the order we're sending you the pull requests and you have
pulled the EDAC tree from me first, you will encounter a merge conflict in
drivers/edac/i10nm_base.c due to the addition of INTEL_ATOM_DARKMONT_X there.

I've included the resolution at the end of this mail.

Thx.

---

The following changes since commit b8f52214c61a5b99a54168145378e91b40d10c90:

  Merge tag 'audit-pr-20241205' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit (2024-12-05 15:11:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cpu_for_v6.14_rc1

for you to fetch changes up to e5d3a57891ba500503df075b99b78d6e61f2694e:

  x86/cpu: Make all all CPUID leaf names consistent (2024-12-18 06:17:46 -0800)

----------------------------------------------------------------
- Remove the less generic CPU matching infra around struct x86_cpu_desc and
  use the generic struct x86_cpu_id thing

- Remove magic naked numbers for CPUID functions and use proper defines of the
  prefix CPUID_LEAF_*. Consolidate some of the crazy use around the tree

- Smaller cleanups and improvements

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/cpufeature: Document cpu_feature_enabled() as the default to use

Dave Hansen (15):
      x86/cpu: Introduce new microcode matching helper
      x86/cpu: Expose only stepping min/max interface
      x86/cpu: Replace PEBS use of 'x86_cpu_desc' use with 'x86_cpu_id'
      x86/cpu: Move AMD erratum 1386 table over to 'x86_cpu_id'
      x86/cpu: Remove 'x86_cpu_desc' infrastructure
      x86/cpu: Move MWAIT leaf definition to common header
      x86/cpu: Use MWAIT leaf definition
      x86/cpu: Remove unnecessary MwAIT leaf checks
      x86/cpu: Refresh DCA leaf reading code
      x86/cpu: Move TSC CPUID leaf definition
      x86/tsc: Move away from TSC leaf magic numbers
      x86/tsc: Remove CPUID "frequency" leaf magic numbers.
      x86/fpu: Move CPUID leaf definitions to common code
      x86/fpu: Remove unnecessary CPUID level check
      x86/cpu: Make all all CPUID leaf names consistent

Juergen Gross (1):
      x86/paravirt: Remove the WBINVD callback

Sohil Mehta (1):
      x86/cpufeatures: Free up unused feature bits

 arch/x86/events/intel/core.c              | 62 ++++++++++------------
 arch/x86/events/intel/pt.c                |  5 +-
 arch/x86/events/intel/pt.h                |  3 --
 arch/x86/include/asm/cpu_device_id.h      | 51 ++++---------------
 arch/x86/include/asm/cpufeature.h         | 18 +++----
 arch/x86/include/asm/cpufeatures.h        |  4 +-
 arch/x86/include/asm/cpuid.h              |  7 +++
 arch/x86/include/asm/fpu/xstate.h         |  4 --
 arch/x86/include/asm/mwait.h              |  1 -
 arch/x86/include/asm/paravirt.h           |  7 ---
 arch/x86/include/asm/paravirt_types.h     |  2 -
 arch/x86/include/asm/special_insns.h      |  8 +--
 arch/x86/kernel/acpi/cstate.c             |  5 +-
 arch/x86/kernel/apic/apic.c               | 18 +++----
 arch/x86/kernel/cpu/amd.c                 |  9 ++--
 arch/x86/kernel/cpu/common.c              | 85 ++++++++++++++++---------------
 arch/x86/kernel/cpu/intel.c               |  5 --
 arch/x86/kernel/cpu/match.c               | 28 ++--------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
 arch/x86/kernel/fpu/xstate.c              | 26 ++++------
 arch/x86/kernel/hpet.c                    |  6 +--
 arch/x86/kernel/paravirt.c                |  6 ---
 arch/x86/kernel/process.c                 |  7 +--
 arch/x86/kernel/smpboot.c                 |  5 +-
 arch/x86/kernel/tsc.c                     | 23 ++++-----
 arch/x86/xen/enlighten_pv.c               |  7 ++-
 drivers/acpi/acpi_pad.c                   |  5 +-
 drivers/dma/ioat/dca.c                    |  8 +--
 drivers/edac/i10nm_base.c                 | 21 ++++----
 drivers/edac/skx_base.c                   |  2 +-
 drivers/idle/intel_idle.c                 |  6 +--
 drivers/platform/x86/intel/pmc/core.c     |  7 +--
 include/linux/mod_devicetable.h           |  2 +
 33 files changed, 178 insertions(+), 277 deletions(-)

merge resolution:

index 70dff342c1b9,09bf5a3f06bf..f45d849d3f15
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@@ -938,17 -938,17 +938,18 @@@ static struct res_config gnr_cfg = 
  };
  
  static const struct x86_cpu_id i10nm_cpuids[] = {
- 	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_TREMONT_D,	X86_STEPPINGS(0x0, 0x3), &i10nm_cfg0),
- 	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_TREMONT_D,	X86_STEPPINGS(0x4, 0xf), &i10nm_cfg1),
- 	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_X,	X86_STEPPINGS(0x0, 0x3), &i10nm_cfg0),
- 	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_X,	X86_STEPPINGS(0x4, 0xf), &i10nm_cfg1),
- 	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_D,	X86_STEPPINGS(0x0, 0xf), &i10nm_cfg1),
- 	X86_MATCH_VFM_STEPPINGS(INTEL_SAPPHIRERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
- 	X86_MATCH_VFM_STEPPINGS(INTEL_EMERALDRAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
- 	X86_MATCH_VFM_STEPPINGS(INTEL_GRANITERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
- 	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
- 	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
- 	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_DARKMONT_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
+ 	X86_MATCH_VFM_STEPS(INTEL_ATOM_TREMONT_D, X86_STEP_MIN,		 0x3, &i10nm_cfg0),
+ 	X86_MATCH_VFM_STEPS(INTEL_ATOM_TREMONT_D,	   0x4,	X86_STEP_MAX, &i10nm_cfg1),
+ 	X86_MATCH_VFM_STEPS(INTEL_ICELAKE_X,	  X86_STEP_MIN,		 0x3, &i10nm_cfg0),
+ 	X86_MATCH_VFM_STEPS(INTEL_ICELAKE_X,		   0x4, X86_STEP_MAX, &i10nm_cfg1),
+ 	X86_MATCH_VFM(	    INTEL_ICELAKE_D,				      &i10nm_cfg1),
+ 
+ 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, &spr_cfg),
+ 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,  &spr_cfg),
+ 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,  &gnr_cfg),
+ 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X, &gnr_cfg),
+ 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,   &gnr_cfg),
++	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,  &gnr_cfg),
  	{}
  };
  MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

