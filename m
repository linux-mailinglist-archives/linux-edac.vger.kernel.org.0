Return-Path: <linux-edac+bounces-2305-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F6A9B1313
	for <lists+linux-edac@lfdr.de>; Sat, 26 Oct 2024 01:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33C3B21B95
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 23:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5050C1DE2AC;
	Fri, 25 Oct 2024 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Q9cmzzpg"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D31217F2C;
	Fri, 25 Oct 2024 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729898012; cv=none; b=sZX9yVziZBgSvOg418709NNZTTby4RNDtNX+FwYRWe1di6Es25wXpp1cnWTnp/nWQRvyzPfPOO1E4VXWdaII8852S6XjwK6a48q3bqi8FX5pAdyhXDEzk2i19bTjWLiAfY/gQlan6GK68FRMLnyc0qAlVR0ldIibxY9kQJRhEr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729898012; c=relaxed/simple;
	bh=gtJlAddndmd/4ZutUXPUp23tBUavCcBIZHXWBTvsy5U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rKUJNZnE3PAfkbYVayY5I/Zsvg8Q0mrJH1FRUQWID7fHXhSvhLSlPJLIUGjxvRFj5ZN/DPBbodlX3vEF8koFnrHqBIw/oc2JoSMcVJNlJqsbxQimQU1n/kiMmOERRLnE20Jq4FBkKDTs6QbaC4sOItJeo8HJgExCbsHADnhfjl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Q9cmzzpg; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729898009; x=1761434009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iEneAqKTZ3Xv2tJZavyIel5bzddHvy7/jEFA9lznCds=;
  b=Q9cmzzpgU9GJ1X4yDZFDYaKTAsZ/5LgDDEXzMWi0OllgxLhaqMl3HueH
   hStjv7z35gjuNaXrU0jqlxK8zCEAkTDt6GloRTWQ0aMjGTrtKznHY8/IS
   FN1EtiG1Q0avucq3Fj9sIIU8lktFKyMC+4aK7DO7RfWdl7/m7jVtBLvjU
   s=;
X-IronPort-AV: E=Sophos;i="6.11,233,1725321600"; 
   d="scan'208";a="346864134"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 23:13:27 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:45881]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.125:2525] with esmtp (Farcaster)
 id 68ba6d59-4651-44b6-8e27-f8b5e8ba96fb; Fri, 25 Oct 2024 23:13:27 +0000 (UTC)
X-Farcaster-Flow-ID: 68ba6d59-4651-44b6-8e27-f8b5e8ba96fb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 25 Oct 2024 23:13:26 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 25 Oct 2024 23:13:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Benjamin
 Herrenschmidt" <benh@amazon.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: WARNING in lmce_supported() during reboot.
Date: Fri, 25 Oct 2024 16:13:20 -0700
Message-ID: <20241025231320.45417-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Hello x86 maintainers,

We have seen the splat below few times when just rebooting hosts.

It rarely happens and seems a timing related, so we don't have a
reproducer.

Our kernel source in the splat is here,
https://github.com/amazonlinux/linux/tree/kernel-6.1.61-85.141.amzn2023

and the triggered WARN_ON_ONCE() in lmce_supported() is here.
https://github.com/amazonlinux/linux/blob/kernel-6.1.61-85.141.amzn2023/arch/x86/kernel/cpu/mce/intel.c#L124

Do you have any hint ?

Thanks in advance.


ACPI: PM: Preparing to enter system sleep state S5
reboot: Restarting system
reboot: machine restart
------------[ cut here ]------------
WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/mce/intel.c:124 lmce_supported (arch/x86/kernel/cpu/mce/intel.c:124 arch/x86/kernel/cpu/mce/intel.c:99) 
Modules linked in: ib_core binfmt_misc ext4 crc16 mbcache jbd2 sunrpc mousedev atkbd psmouse ghash_clmulni_intel vivaldi_fmap libps2 aesni_intel crypto_simd cryptd i8042 serio ena button sch_fq_codel dm_mod fuse configfs dax loop dmi_sysfs simpledrm drm_shmem_helper drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea drm i2c_core drm_panel_orientation_quirks backlight fb crc32_pclmul crc32c_intel fbdev efivarfs
Hardware name: Amazon EC2 c6i.4xlarge/, BIOS 1.0 10/16/2017
RIP: 0010:lmce_supported (arch/x86/kernel/cpu/mce/intel.c:124 arch/x86/kernel/cpu/mce/intel.c:99) 
Code: 81 fb 00 00 00 09 75 da b9 3a 00 00 00 0f 32 48 c1 e2 20 48 09 c2 48 89 d3 66 90 48 89 d8 48 c1 e8 14 83 e0 01 83 e3 01 75 ba <0f> 0b 31 c0 eb b4 31 d2 48 89 de bf 3a 00 00 00 e8 6b e6 57 00 eb
All code
========
   0:	81 fb 00 00 00 09    	cmp    $0x9000000,%ebx
   6:	75 da                	jne    0xffffffffffffffe2
   8:	b9 3a 00 00 00       	mov    $0x3a,%ecx
   d:	0f 32                	rdmsr
   f:	48 c1 e2 20          	shl    $0x20,%rdx
  13:	48 09 c2             	or     %rax,%rdx
  16:	48 89 d3             	mov    %rdx,%rbx
  19:	66 90                	xchg   %ax,%ax
  1b:	48 89 d8             	mov    %rbx,%rax
  1e:	48 c1 e8 14          	shr    $0x14,%rax
  22:	83 e0 01             	and    $0x1,%eax
  25:	83 e3 01             	and    $0x1,%ebx
  28:	75 ba                	jne    0xffffffffffffffe4
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	31 c0                	xor    %eax,%eax
  2e:	eb b4                	jmp    0xffffffffffffffe4
  30:	31 d2                	xor    %edx,%edx
  32:	48 89 de             	mov    %rbx,%rsi
  35:	bf 3a 00 00 00       	mov    $0x3a,%edi
  3a:	e8 6b e6 57 00       	call   0x57e6aa
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	31 c0                	xor    %eax,%eax
   4:	eb b4                	jmp    0xffffffffffffffba
   6:	31 d2                	xor    %edx,%edx
   8:	48 89 de             	mov    %rbx,%rsi
   b:	bf 3a 00 00 00       	mov    $0x3a,%edi
  10:	e8 6b e6 57 00       	call   0x57e680
  15:	eb                   	.byte 0xeb
RSP: 0018:ffffa18f00154fb8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000003a
RDX: 0000000000000000 RSI: 00000000000000ff RDI: ffff965cfe2599c0
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffa18f00154ff8 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff965cfe240000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8485dfba30 CR3: 0000000389a10003 CR4: 00000000007706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
<IRQ>
? show_trace_log_lvl (arch/x86/kernel/dumpstack.c:259) 
? show_trace_log_lvl (arch/x86/kernel/dumpstack.c:259) 
? mce_intel_feature_clear (arch/x86/kernel/cpu/mce/intel.c:465 arch/x86/kernel/cpu/mce/intel.c:502) 
? lmce_supported (arch/x86/kernel/cpu/mce/intel.c:124 arch/x86/kernel/cpu/mce/intel.c:99) 
? __warn (kernel/panic.c:672) 
? lmce_supported (arch/x86/kernel/cpu/mce/intel.c:124 arch/x86/kernel/cpu/mce/intel.c:99) 
? report_bug (lib/bug.c:201 lib/bug.c:219) 
? handle_bug (arch/x86/kernel/traps.c:324) 
? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator 1)) 
? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568) 
? lmce_supported (arch/x86/kernel/cpu/mce/intel.c:124 arch/x86/kernel/cpu/mce/intel.c:99) 
? clear_local_APIC (./arch/x86/include/asm/apic.h:393 arch/x86/kernel/apic/apic.c:1192) 
mce_intel_feature_clear (arch/x86/kernel/cpu/mce/intel.c:465 arch/x86/kernel/cpu/mce/intel.c:502) 
stop_this_cpu (arch/x86/kernel/process.c:780) 
__sysvec_reboot (arch/x86/kernel/smp.c:140) 
sysvec_reboot (arch/x86/kernel/smp.c:136 (discriminator 14)) 
</IRQ>
<TASK>
asm_sysvec_reboot (./arch/x86/include/asm/idtentry.h:656) 
RIP: 0010:acpi_idle_do_entry (./arch/x86/include/asm/irqflags.h:40 ./arch/x86/include/asm/irqflags.h:75 drivers/acpi/processor_idle.c:113 drivers/acpi/processor_idle.c:572) 
Code: 75 08 48 8b 15 b1 81 df 02 ed c3 cc cc cc cc 65 48 8b 04 25 00 ff 01 00 48 8b 00 a8 08 75 eb 66 90 0f 00 2d 58 c8 6a 00 fb f4 <fa> c3 cc cc cc cc e9 01 fc ff ff 90 0f 1f 44 00 00 41 56 41 55 41
All code
========
   0:	75 08                	jne    0xa
   2:	48 8b 15 b1 81 df 02 	mov    0x2df81b1(%rip),%rdx        # 0x2df81ba
   9:	ed                   	in     (%dx),%eax
   a:	c3                   	ret
   b:	cc                   	int3
   c:	cc                   	int3
   d:	cc                   	int3
   e:	cc                   	int3
   f:	65 48 8b 04 25 00 ff 	mov    %gs:0x1ff00,%rax
  16:	01 00 
  18:	48 8b 00             	mov    (%rax),%rax
  1b:	a8 08                	test   $0x8,%al
  1d:	75 eb                	jne    0xa
  1f:	66 90                	xchg   %ax,%ax
  21:	0f 00 2d 58 c8 6a 00 	verw   0x6ac858(%rip)        # 0x6ac880
  28:	fb                   	sti
  29:	f4                   	hlt
  2a:*	fa                   	cli		<-- trapping instruction
  2b:	c3                   	ret
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	e9 01 fc ff ff       	jmp    0xfffffffffffffc36
  35:	90                   	nop
  36:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  3b:	41 56                	push   %r14
  3d:	41 55                	push   %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
===========================================
   0:	fa                   	cli
   1:	c3                   	ret
   2:	cc                   	int3
   3:	cc                   	int3
   4:	cc                   	int3
   5:	cc                   	int3
   6:	e9 01 fc ff ff       	jmp    0xfffffffffffffc0c
   b:	90                   	nop
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	41 56                	push   %r14
  13:	41 55                	push   %r13
  15:	41                   	rex.B
RSP: 0018:ffffa18f000afe70 EFLAGS: 00000246
RAX: 0000000000004000 RBX: ffff965603d92400 RCX: 4000000000000000
RDX: ffff965cfe240000 RSI: ffff965601478800 RDI: ffff965601478864
RBP: 0000000000000001 R08: ffffffffb62182c0 R09: 0000000000000000
R10: 0000000000002703 R11: 000000000001993d R12: 0000000000000001
R13: ffffffffb6218340 R14: 0000000000000001 R15: 0000000000000000
acpi_idle_enter (drivers/acpi/processor_idle.c:711 (discriminator 3)) 
cpuidle_enter_state (drivers/cpuidle/cpuidle.c:239) 
cpuidle_enter (drivers/cpuidle/cpuidle.c:358) 
cpuidle_idle_call (kernel/sched/idle.c:240) 
do_idle (kernel/sched/idle.c:305) 
cpu_startup_entry (kernel/sched/idle.c:400 (discriminator 1)) 
start_secondary (arch/x86/kernel/smpboot.c:215 arch/x86/kernel/smpboot.c:249) 
secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:358) 
</TASK>
---[ end trace 0000000000000000 ]---

