Return-Path: <linux-edac+bounces-1616-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5326A946A5C
	for <lists+linux-edac@lfdr.de>; Sat,  3 Aug 2024 17:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAD41F216F3
	for <lists+linux-edac@lfdr.de>; Sat,  3 Aug 2024 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C8A1547EC;
	Sat,  3 Aug 2024 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1xlVHjg"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB19153BC7;
	Sat,  3 Aug 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722698759; cv=none; b=V+yaFBJaHLdO8wYdHdbBshwcgyzrQuBcs5cAJJjcTlkZA2Fs0B2yOTZ3pLDONC5OjsmhfmM/2/CNmFSHzbIKos02z1G7uxrA2ivjc2VW/GV8TxNDVl8gma5ezYdhn3eX0NXG4943wP42BXGAP3hAhQB7nd8ANOpLJaFAoDegkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722698759; c=relaxed/simple;
	bh=Y60hIK6ydkqTyKIrzkDS33+PlxszsMbIrT5BtV6l9Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0D2dfpN2l4e1QQRBy4aYE3gp5mH3+NtiyMglY9tX6USxK85FvdTf//9IuK2UeHjCiAixBl7YGiWcxJzQRiEFaj23LV23Hbdv+991/f6VE4dEPoSzjKXOEMTuI85GDbAAemA39Dp5q5vKwwm3/Wr7BJe9a8fbWQu5mgCgBuXikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1xlVHjg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722698757; x=1754234757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y60hIK6ydkqTyKIrzkDS33+PlxszsMbIrT5BtV6l9Og=;
  b=I1xlVHjgsS9MHf3wyT5Q7eJI2v1F1xXw3WuDXpClILEIvXm9wc4a0o5p
   IJdb6ywkQ86AyZcow1k/euIgd7hHlDfG93EYswFXivOg9zC/SK8cEnHKY
   QXJ3DlqkBRYZ8TY0lRoURs8e0G6vLxFmBE0j92v+G/3E3fzWLBGCEfgOz
   Pr+FVR1Bh+IrUafJAKL+ZtbCZZcKYcrUqAidPb2/tmggzPgzzgXEOHO/B
   fP17+aGMd21WeeMb9iijBYhJ0l6jzwdPIYBkhZRO5fhHnbKEcqspqBK/U
   DbuRBdXDbN5CteEhjANs/vbeXnY2oSMX7ZVtAuiFOVRSQLHz7XBUG0wG9
   w==;
X-CSE-ConnectionGUID: fRjTNZgJRs2BOGsIQ9x7Ng==
X-CSE-MsgGUID: S7pdJcRMSreRbEXxeibgrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11153"; a="31859582"
X-IronPort-AV: E=Sophos;i="6.09,260,1716274800"; 
   d="scan'208";a="31859582"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2024 08:25:56 -0700
X-CSE-ConnectionGUID: 0uW1jveXQpK2dELiVnN5Ng==
X-CSE-MsgGUID: PwIH/2etTE+LS25CYP0zBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,260,1716274800"; 
   d="scan'208";a="60367208"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 03 Aug 2024 08:25:50 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1saGdg-0000cO-2G;
	Sat, 03 Aug 2024 15:25:48 +0000
Date: Sat, 3 Aug 2024 23:24:56 +0800
From: kernel test robot <lkp@intel.com>
To: Avadhut Naik <avadhut.naik@amd.com>, x86@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	bp@alien8.de, tony.luck@intel.com, rafael@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, rostedt@goodmis.org,
	lenb@kernel.org, mchehab@kernel.org, james.morse@arm.com,
	airlied@gmail.com, yazen.ghannam@amd.com, john.allen@amd.com,
	avadnaik@amd.com
Subject: Re: [PATCH v3 1/4] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Message-ID: <202408032312.5lkzepQe-lkp@intel.com>
References: <20240730185406.3709876-2-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730185406.3709876-2-avadhut.naik@amd.com>

Hi Avadhut,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dee974604f7870167161cbe51e8f3b9c2858de34]

url:    https://github.com/intel-lab-lkp/linux/commits/Avadhut-Naik/x86-mce-Add-wrapper-for-struct-mce-to-export-vendor-specific-info/20240801-192550
base:   dee974604f7870167161cbe51e8f3b9c2858de34
patch link:    https://lore.kernel.org/r/20240730185406.3709876-2-avadhut.naik%40amd.com
patch subject: [PATCH v3 1/4] x86/mce: Add wrapper for struct mce to export vendor specific info
config: x86_64-randconfig-071-20240803 (https://download.01.org/0day-ci/archive/20240803/202408032312.5lkzepQe-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240803/202408032312.5lkzepQe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408032312.5lkzepQe-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: do_machine_check+0x6e: call to __asan_memset() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_ibrs+0x11: call to sched_smt_active() leaves .noinstr.text section


objdump-func vmlinux.o do_machine_check:
0000 00000000000025a0 <do_machine_check>:
0000     25a0:	f3 0f 1e fa          	endbr64
0004     25a4:	41 57                	push   %r15
0006     25a6:	b9 10 00 00 00       	mov    $0x10,%ecx
000b     25ab:	31 f6                	xor    %esi,%esi
000d     25ad:	ba 80 00 00 00       	mov    $0x80,%edx
0012     25b2:	41 56                	push   %r14
0014     25b4:	41 55                	push   %r13
0016     25b6:	41 54                	push   %r12
0018     25b8:	55                   	push   %rbp
0019     25b9:	48 89 fd             	mov    %rdi,%rbp
001c     25bc:	53                   	push   %rbx
001d     25bd:	48 81 ec c8 00 00 00 	sub    $0xc8,%rsp
0024     25c4:	65 48 8b 04 25 28 00 00 00 	mov    %gs:0x28,%rax
002d     25cd:	48 89 84 24 c0 00 00 00 	mov    %rax,0xc0(%rsp)
0035     25d5:	31 c0                	xor    %eax,%eax
0037     25d7:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
003c     25dc:	c7 44 24 1c 00 00 00 00 	movl   $0x0,0x1c(%rsp)
0044     25e4:	48 c7 84 24 b0 00 00 00 00 00 00 00 	movq   $0x0,0xb0(%rsp)
0050     25f0:	48 89 df             	mov    %rbx,%rdi
0053     25f3:	48 c7 84 24 b8 00 00 00 00 00 00 00 	movq   $0x0,0xb8(%rsp)
005f     25ff:	48 c7 44 24 20 00 00 00 00 	movq   $0x0,0x20(%rsp)
0068     2608:	f3 48 ab             	rep stos %rax,%es:(%rdi)
006b     260b:	48 89 df             	mov    %rbx,%rdi
006e     260e:	e8 00 00 00 00       	call   2613 <do_machine_check+0x73>	260f: R_X86_64_PLT32	__asan_memset-0x4
0073     2613:	f6 05 00 00 00 00 60 	testb  $0x60,0x0(%rip)        # 261a <do_machine_check+0x7a>	2615: R_X86_64_PC32	mce_flags-0x5
007a     261a:	0f 85 de 04 00 00    	jne    2afe <do_machine_check+0x55e>
0080     2620:	f6 05 00 00 00 00 20 	testb  $0x20,0x0(%rip)        # 2627 <do_machine_check+0x87>	2622: R_X86_64_PC32	mca_cfg-0x5
0087     2627:	0f 84 20 08 00 00    	je     2e4d <do_machine_check+0x8ad>
008d     262d:	f6 05 00 00 00 00 01 	testb  $0x1,0x0(%rip)        # 2634 <do_machine_check+0x94>	262f: R_X86_64_PC32	mce_flags-0x4
0094     2634:	0f 85 f1 04 00 00    	jne    2b2b <do_machine_check+0x58b>
009a     263a:	c7 44 24 1c 00 00 00 00 	movl   $0x0,0x1c(%rsp)
00a2     2642:	ff 05 00 00 00 00    	incl   0x0(%rip)        # 2648 <do_machine_check+0xa8>	2644: R_X86_64_PC32	mce_exception_count-0x4
00a8     2648:	48 89 ee             	mov    %rbp,%rsi
00ab     264b:	48 89 df             	mov    %rbx,%rdi
00ae     264e:	e8 dd fe ff ff       	call   2530 <mce_gather_info>
00b3     2653:	0f 31                	rdtsc
00b5     2655:	48 c1 e2 20          	shl    $0x20,%rdx
00b9     2659:	48 09 d0             	or     %rdx,%rax
00bc     265c:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
00c1     2661:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
00c6     2666:	48 89 05 00 00 00 00 	mov    %rax,0x0(%rip)        # 266d <do_machine_check+0xcd>	2669: R_X86_64_PC32	.data+0xb2884
00cd     266d:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
00d2     2672:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2679 <do_machine_check+0xd9>	2675: R_X86_64_PC32	.data+0xb285c
00d9     2679:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
00de     267e:	48 89 05 00 00 00 00 	mov    %rax,0x0(%rip)        # 2685 <do_machine_check+0xe5>	2681: R_X86_64_PC32	.data+0xb288c
00e5     2685:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
00ea     268a:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2691 <do_machine_check+0xf1>	268d: R_X86_64_PC32	.data+0xb2864
00f1     2691:	48 8b 54 24 40       	mov    0x40(%rsp),%rdx
00f6     2696:	48 89 05 00 00 00 00 	mov    %rax,0x0(%rip)        # 269d <do_machine_check+0xfd>	2699: R_X86_64_PC32	.data+0xb2894
00fd     269d:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
0102     26a2:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 26a9 <do_machine_check+0x109>	26a5: R_X86_64_PC32	.data+0xb286c
0109     26a9:	48 8b 54 24 48       	mov    0x48(%rsp),%rdx
010e     26ae:	48 89 05 00 00 00 00 	mov    %rax,0x0(%rip)        # 26b5 <do_machine_check+0x115>	26b1: R_X86_64_PC32	.data+0xb289c
0115     26b5:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
011a     26ba:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 26c1 <do_machine_check+0x121>	26bd: R_X86_64_PC32	.data+0xb2874
0121     26c1:	48 8b 54 24 50       	mov    0x50(%rsp),%rdx
0126     26c6:	48 89 05 00 00 00 00 	mov    %rax,0x0(%rip)        # 26cd <do_machine_check+0x12d>	26c9: R_X86_64_PC32	.data+0xb28a4
012d     26cd:	48 8b 84 24 80 00 00 00 	mov    0x80(%rsp),%rax
0135     26d5:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 26dc <do_machine_check+0x13c>	26d8: R_X86_64_PC32	.data+0xb287c
013c     26dc:	48 89 05 00 00 00 00 	mov    %rax,0x0(%rip)        # 26e3 <do_machine_check+0x143>	26df: R_X86_64_PC32	.data+0xb28ac
0143     26e3:	48 8b 84 24 88 00 00 00 	mov    0x88(%rsp),%rax
014b     26eb:	48 89 05 00 00 00 00 	mov    %rax,0x0(%rip)        # 26f2 <do_machine_check+0x152>	26ee: R_X86_64_PC32	.data+0xb28b4
0152     26f2:	48 8b 84 24 90 00 00 00 	mov    0x90(%rsp),%rax
015a     26fa:	48 89 05 00 00 00 00 	mov    %rax,0x0(%rip)        # 2701 <do_machine_check+0x161>	26fd: R_X86_64_PC32	.data+0xb28bc
0161     2701:	48 8b 84 24 98 00 00 00 	mov    0x98(%rsp),%rax
0169     2709:	48 89 05 00 00 00 00 	mov    %rax,0x0(%rip)        # 2710 <do_machine_check+0x170>	270c: R_X86_64_PC32	.data+0xb28c4
0170     2710:	48 8b 84 24 a0 00 00 00 	mov    0xa0(%rsp),%rax
0178     2718:	48 89 05 00 00 00 00 	mov    %rax,0x0(%rip)        # 271f <do_machine_check+0x17f>	271b: R_X86_64_PC32	.data+0xb28cc
017f     271f:	48 8b 84 24 a8 00 00 00 	mov    0xa8(%rsp),%rax
0187     2727:	48 89 05 00 00 00 00 	mov    %rax,0x0(%rip)        # 272e <do_machine_check+0x18e>	272a: R_X86_64_PC32	.data+0xb28d4
018e     272e:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
0193     2733:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
0198     2738:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 273e <do_machine_check+0x19e>	273a: R_X86_64_PC32	mce_num_banks-0x4
019e     273e:	49 be ff ef 00 00 00 00 80 7f 	movabs $0x7f8000000000efff,%r14
01a8     2748:	45 31 e4             	xor    %r12d,%r12d
01ab     274b:	49 bd 50 01 00 00 00 00 80 3d 	movabs $0x3d80000000000150,%r13
01b5     2755:	85 c0                	test   %eax,%eax
01b7     2757:	75 57                	jne    27b0 <do_machine_check+0x210>
01b9     2759:	e9 e3 00 00 00       	jmp    2841 <do_machine_check+0x2a1>
01be     275e:	a8 08                	test   $0x8,%al
01c0     2760:	74 18                	je     277a <do_machine_check+0x1da>
01c2     2762:	41 83 fc 01          	cmp    $0x1,%r12d
01c6     2766:	75 12                	jne    277a <do_machine_check+0x1da>
01c8     2768:	f6 44 24 35 08       	testb  $0x8,0x35(%rsp)
01cd     276d:	74 0b                	je     277a <do_machine_check+0x1da>
01cf     276f:	0f b7 85 88 00 00 00 	movzwl 0x88(%rbp),%eax
01d6     2776:	88 44 24 70          	mov    %al,0x70(%rsp)
01da     277a:	b9 01 00 00 00       	mov    $0x1,%ecx
01df     277f:	48 8d 54 24 28       	lea    0x28(%rsp),%rdx
01e4     2784:	48 89 ee             	mov    %rbp,%rsi
01e7     2787:	48 89 df             	mov    %rbx,%rdi
01ea     278a:	44 88 64 24 71       	mov    %r12b,0x71(%rsp)
01ef     278f:	e8 00 00 00 00       	call   2794 <do_machine_check+0x1f4>	2790: R_X86_64_PLT32	mce_severity-0x4
01f4     2794:	83 f8 06             	cmp    $0x6,%eax
01f7     2797:	0f 8f 08 05 00 00    	jg     2ca5 <do_machine_check+0x705>
01fd     279d:	41 83 c4 01          	add    $0x1,%r12d
0201     27a1:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 27a7 <do_machine_check+0x207>	27a3: R_X86_64_PC32	mce_num_banks-0x4
0207     27a7:	41 39 c4             	cmp    %eax,%r12d
020a     27aa:	0f 83 91 00 00 00    	jae    2841 <do_machine_check+0x2a1>
0210     27b0:	e9 00 00 00 00       	jmp    27b5 <do_machine_check+0x215>	27b1: R_X86_64_PC32	.altinstr_aux+0xe66
0215     27b5:	44 89 e7             	mov    %r12d,%edi
0218     27b8:	c1 e7 04             	shl    $0x4,%edi
021b     27bb:	81 ef ff df ff 3f    	sub    $0x3fffdfff,%edi
0221     27c1:	e8 00 00 00 00       	call   27c6 <do_machine_check+0x226>	27c2: R_X86_64_PLT32	mce_rdmsrl-0x4
0226     27c6:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
022b     27cb:	48 85 c0             	test   %rax,%rax
022e     27ce:	79 cd                	jns    279d <do_machine_check+0x1fd>
0230     27d0:	49 63 c4             	movslq %r12d,%rax
0233     27d3:	48 0f ab 84 24 b0 00 00 00 	bts    %rax,0xb0(%rsp)
023c     27dc:	0f b6 05 00 00 00 00 	movzbl 0x0(%rip),%eax        # 27e3 <do_machine_check+0x243>	27df: R_X86_64_PC32	mce_flags-0x4
0243     27e3:	45 85 e4             	test   %r12d,%r12d
0246     27e6:	0f 85 72 ff ff ff    	jne    275e <do_machine_check+0x1be>
024c     27ec:	84 c0                	test   %al,%al
024e     27ee:	0f 89 6a ff ff ff    	jns    275e <do_machine_check+0x1be>
0254     27f4:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
0259     27f9:	a8 03                	test   $0x3,%al
025b     27fb:	0f 85 79 ff ff ff    	jne    277a <do_machine_check+0x1da>
0261     2801:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
0266     2806:	4c 21 f2             	and    %r14,%rdx
0269     2809:	4c 39 ea             	cmp    %r13,%rdx
026c     280c:	0f 85 68 ff ff ff    	jne    277a <do_machine_check+0x1da>
0272     2812:	48 83 c8 02          	or     $0x2,%rax
0276     2816:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
027b     281b:	48 8b 85 80 00 00 00 	mov    0x80(%rbp),%rax
0282     2822:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
0287     2827:	0f b7 85 88 00 00 00 	movzwl 0x88(%rbp),%eax
028e     282e:	88 44 24 70          	mov    %al,0x70(%rsp)
0292     2832:	e9 43 ff ff ff       	jmp    277a <do_machine_check+0x1da>
0297     2837:	42 8d 3c a5 01 04 00 00 	lea    0x401(,%r12,4),%edi
029f     283f:	eb 80                	jmp    27c1 <do_machine_check+0x221>
02a1     2841:	31 c0                	xor    %eax,%eax
02a3     2843:	89 44 24 1c          	mov    %eax,0x1c(%rsp)
02a7     2847:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
02ac     284c:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
02b1     2851:	0f b6 44 24 68       	movzbl 0x68(%rsp),%eax
02b6     2856:	84 c0                	test   %al,%al
02b8     2858:	0f 84 1e 04 00 00    	je     2c7c <do_machine_check+0x6dc>
02be     285e:	c7 44 24 04 01 00 00 00 	movl   $0x1,0x4(%rsp)
02c6     2866:	3c 0a                	cmp    $0xa,%al
02c8     2868:	0f 84 0e 04 00 00    	je     2c7c <do_machine_check+0x6dc>
02ce     286e:	44 8b 7c 24 1c       	mov    0x1c(%rsp),%r15d
02d3     2873:	c7 44 24 14 ff ff ff ff 	movl   $0xffffffff,0x14(%rsp)
02db     287b:	45 85 ff             	test   %r15d,%r15d
02de     287e:	0f 85 c4 04 00 00    	jne    2d48 <do_machine_check+0x7a8>
02e4     2884:	8b 15 00 00 00 00    	mov    0x0(%rip),%edx        # 288a <do_machine_check+0x2ea>	2886: R_X86_64_PC32	mce_num_banks-0x4
02ea     288a:	45 31 e4             	xor    %r12d,%r12d
02ed     288d:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
02f4     2894:	85 d2                	test   %edx,%edx
02f6     2896:	0f 84 de 00 00 00    	je     297a <do_machine_check+0x3da>
02fc     289c:	45 31 f6             	xor    %r14d,%r14d
02ff     289f:	4d 63 ee             	movslq %r14d,%r13
0302     28a2:	4c 0f b3 ac 24 b8 00 00 00 	btr    %r13,0xb8(%rsp)
030b     28ab:	4c 0f a3 ac 24 b0 00 00 00 	bt     %r13,0xb0(%rsp)
0314     28b4:	0f 83 a8 00 00 00    	jae    2962 <do_machine_check+0x3c2>
031a     28ba:	4c 89 e8             	mov    %r13,%rax
031d     28bd:	48 c1 e0 04          	shl    $0x4,%rax
0321     28c1:	48 83 b8 00 00 00 00 00 	cmpq   $0x0,0x0(%rax)	28c4: R_X86_64_32S	mce_banks_array
0329     28c9:	0f 84 93 00 00 00    	je     2962 <do_machine_check+0x3c2>
032f     28cf:	48 c7 44 24 38 00 00 00 00 	movq   $0x0,0x38(%rsp)
0338     28d8:	48 c7 44 24 40 00 00 00 00 	movq   $0x0,0x40(%rsp)
0341     28e1:	44 88 74 24 71       	mov    %r14b,0x71(%rsp)
0346     28e6:	e9 00 00 00 00       	jmp    28eb <do_machine_check+0x34b>	28e7: R_X86_64_PC32	.altinstr_aux+0xe78
034b     28eb:	44 89 f7             	mov    %r14d,%edi
034e     28ee:	c1 e7 04             	shl    $0x4,%edi
0351     28f1:	81 ef ff df ff 3f    	sub    $0x3fffdfff,%edi
0357     28f7:	e8 00 00 00 00       	call   28fc <do_machine_check+0x35c>	28f8: R_X86_64_PLT32	mce_rdmsrl-0x4
035c     28fc:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
0361     2901:	48 85 c0             	test   %rax,%rax
0364     2904:	79 5c                	jns    2962 <do_machine_check+0x3c2>
0366     2906:	f6 05 00 00 00 00 04 	testb  $0x4,0x0(%rip)        # 290d <do_machine_check+0x36d>	2908: R_X86_64_PC32	mca_cfg-0x5
036d     290d:	48 ba 00 00 00 00 00 00 00 01 	movabs $0x100000000000000,%rdx
0377     2917:	48 b9 00 00 00 00 00 00 00 20 	movabs $0x2000000000000000,%rcx
0381     2921:	48 0f 44 d1          	cmove  %rcx,%rdx
0385     2925:	48 85 d0             	test   %rdx,%rax
0388     2928:	75 05                	jne    292f <do_machine_check+0x38f>
038a     292a:	45 85 ff             	test   %r15d,%r15d
038d     292d:	74 33                	je     2962 <do_machine_check+0x3c2>
038f     292f:	31 d2                	xor    %edx,%edx
0391     2931:	b9 01 00 00 00       	mov    $0x1,%ecx
0396     2936:	48 89 ee             	mov    %rbp,%rsi
0399     2939:	48 89 df             	mov    %rbx,%rdi
039c     293c:	e8 00 00 00 00       	call   2941 <do_machine_check+0x3a1>	293d: R_X86_64_PLT32	mce_severity-0x4
03a1     2941:	41 83 c4 01          	add    $0x1,%r12d
03a5     2945:	8d 50 ff             	lea    -0x1(%rax),%edx
03a8     2948:	83 fa 01             	cmp    $0x1,%edx
03ab     294b:	0f 86 0f 02 00 00    	jbe    2b60 <do_machine_check+0x5c0>
03b1     2951:	4c 0f ab ac 24 b8 00 00 00 	bts    %r13,0xb8(%rsp)
03ba     295a:	85 c0                	test   %eax,%eax
03bc     295c:	0f 85 10 02 00 00    	jne    2b72 <do_machine_check+0x5d2>
03c2     2962:	41 83 c6 01          	add    $0x1,%r14d
03c6     2966:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 296c <do_machine_check+0x3cc>	2968: R_X86_64_PC32	mce_num_banks-0x4
03cc     296c:	41 39 c6             	cmp    %eax,%r14d
03cf     296f:	0f 82 2a ff ff ff    	jb     289f <do_machine_check+0x2ff>
03d5     2975:	44 8b 7c 24 1c       	mov    0x1c(%rsp),%r15d
03da     297a:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 2981 <do_machine_check+0x3e1>	297d: R_X86_64_PC32	.data+0xb285c
03e1     2981:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
03e6     2986:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 298d <do_machine_check+0x3ed>	2989: R_X86_64_PC32	.data+0xb2864
03ed     298d:	48 89 54 24 38       	mov    %rdx,0x38(%rsp)
03f2     2992:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 2999 <do_machine_check+0x3f9>	2995: R_X86_64_PC32	.data+0xb286c
03f9     2999:	48 89 54 24 40       	mov    %rdx,0x40(%rsp)
03fe     299e:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 29a5 <do_machine_check+0x405>	29a1: R_X86_64_PC32	.data+0xb2874
0405     29a5:	48 89 54 24 48       	mov    %rdx,0x48(%rsp)
040a     29aa:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 29b1 <do_machine_check+0x411>	29ad: R_X86_64_PC32	.data+0xb287c
0411     29b1:	48 89 54 24 50       	mov    %rdx,0x50(%rsp)
0416     29b6:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 29bd <do_machine_check+0x41d>	29b9: R_X86_64_PC32	.data+0xb2884
041d     29bd:	48 89 54 24 58       	mov    %rdx,0x58(%rsp)
0422     29c2:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 29c9 <do_machine_check+0x429>	29c5: R_X86_64_PC32	.data+0xb288c
0429     29c9:	48 89 54 24 60       	mov    %rdx,0x60(%rsp)
042e     29ce:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 29d5 <do_machine_check+0x435>	29d1: R_X86_64_PC32	.data+0xb2894
0435     29d5:	48 89 54 24 68       	mov    %rdx,0x68(%rsp)
043a     29da:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 29e1 <do_machine_check+0x441>	29dd: R_X86_64_PC32	.data+0xb289c
0441     29e1:	48 89 54 24 70       	mov    %rdx,0x70(%rsp)
0446     29e6:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 29ed <do_machine_check+0x44d>	29e9: R_X86_64_PC32	.data+0xb28a4
044d     29ed:	48 89 54 24 78       	mov    %rdx,0x78(%rsp)
0452     29f2:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 29f9 <do_machine_check+0x459>	29f5: R_X86_64_PC32	.data+0xb28ac
0459     29f9:	48 89 94 24 80 00 00 00 	mov    %rdx,0x80(%rsp)
0461     2a01:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 2a08 <do_machine_check+0x468>	2a04: R_X86_64_PC32	.data+0xb28b4
0468     2a08:	48 89 94 24 88 00 00 00 	mov    %rdx,0x88(%rsp)
0470     2a10:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 2a17 <do_machine_check+0x477>	2a13: R_X86_64_PC32	.data+0xb28bc
0477     2a17:	48 89 94 24 90 00 00 00 	mov    %rdx,0x90(%rsp)
047f     2a1f:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 2a26 <do_machine_check+0x486>	2a22: R_X86_64_PC32	.data+0xb28c4
0486     2a26:	48 89 94 24 98 00 00 00 	mov    %rdx,0x98(%rsp)
048e     2a2e:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 2a35 <do_machine_check+0x495>	2a31: R_X86_64_PC32	.data+0xb28cc
0495     2a35:	48 89 94 24 a0 00 00 00 	mov    %rdx,0xa0(%rsp)
049d     2a3d:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 2a44 <do_machine_check+0x4a4>	2a40: R_X86_64_PC32	.data+0xb28d4
04a4     2a44:	48 89 94 24 a8 00 00 00 	mov    %rdx,0xa8(%rsp)
04ac     2a4c:	45 85 ff             	test   %r15d,%r15d
04af     2a4f:	75 40                	jne    2a91 <do_machine_check+0x4f1>
04b1     2a51:	8b 15 00 00 00 00    	mov    0x0(%rip),%edx        # 2a57 <do_machine_check+0x4b7>	2a53: R_X86_64_PC32	mce_num_banks-0x4
04b7     2a57:	85 d2                	test   %edx,%edx
04b9     2a59:	74 36                	je     2a91 <do_machine_check+0x4f1>
04bb     2a5b:	41 be 01 20 00 c0    	mov    $0xc0002001,%r14d
04c1     2a61:	49 63 c7             	movslq %r15d,%rax
04c4     2a64:	48 0f a3 84 24 b8 00 00 00 	bt     %rax,0xb8(%rsp)
04cd     2a6d:	73 0f                	jae    2a7e <do_machine_check+0x4de>
04cf     2a6f:	e9 00 00 00 00       	jmp    2a74 <do_machine_check+0x4d4>	2a70: R_X86_64_PC32	.altinstr_aux+0xe8a
04d4     2a74:	44 89 f7             	mov    %r14d,%edi
04d7     2a77:	31 f6                	xor    %esi,%esi
04d9     2a79:	e8 52 f2 ff ff       	call   1cd0 <mce_wrmsrl>
04de     2a7e:	41 83 c7 01          	add    $0x1,%r15d
04e2     2a82:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 2a88 <do_machine_check+0x4e8>	2a84: R_X86_64_PC32	mce_num_banks-0x4
04e8     2a88:	41 83 c6 10          	add    $0x10,%r14d
04ec     2a8c:	41 39 c7             	cmp    %eax,%r15d
04ef     2a8f:	72 d0                	jb     2a61 <do_machine_check+0x4c1>
04f1     2a91:	8b 54 24 04          	mov    0x4(%rsp),%edx
04f5     2a95:	85 d2                	test   %edx,%edx
04f7     2a97:	0f 84 66 02 00 00    	je     2d03 <do_machine_check+0x763>
04fd     2a9d:	83 3c 24 06          	cmpl   $0x6,(%rsp)
0501     2aa1:	0f 8f 1f 03 00 00    	jg     2dc6 <do_machine_check+0x826>
0507     2aa7:	90                   	nop
0508     2aa8:	45 85 e4             	test   %r12d,%r12d
050b     2aab:	0f 85 01 03 00 00    	jne    2db2 <do_machine_check+0x812>
0511     2ab1:	83 3c 24 06          	cmpl   $0x6,(%rsp)
0515     2ab5:	74 07                	je     2abe <do_machine_check+0x51e>
0517     2ab7:	f6 44 24 08 01       	testb  $0x1,0x8(%rsp)
051c     2abc:	75 33                	jne    2af1 <do_machine_check+0x551>
051e     2abe:	0f b6 44 24 70       	movzbl 0x70(%rsp),%eax
0523     2ac3:	83 e0 03             	and    $0x3,%eax
0526     2ac6:	3c 03                	cmp    $0x3,%al
0528     2ac8:	0f 84 98 02 00 00    	je     2d66 <do_machine_check+0x7c6>
052e     2ace:	f6 44 24 49 10       	testb  $0x10,0x49(%rsp)
0533     2ad3:	0f 85 34 03 00 00    	jne    2e0d <do_machine_check+0x86d>
0539     2ad9:	48 8b 84 24 a8 00 00 00 	mov    0xa8(%rsp),%rax
0541     2ae1:	a8 40                	test   $0x40,%al
0543     2ae3:	0f 85 f4 01 00 00    	jne    2cdd <do_machine_check+0x73d>
0549     2ae9:	a8 80                	test   $0x80,%al
054b     2aeb:	0f 85 d3 01 00 00    	jne    2cc4 <do_machine_check+0x724>
0551     2af1:	90                   	nop
0552     2af2:	31 f6                	xor    %esi,%esi
0554     2af4:	bf 7a 01 00 00       	mov    $0x17a,%edi
0559     2af9:	e8 d2 f1 ff ff       	call   1cd0 <mce_wrmsrl>
055e     2afe:	48 8b 84 24 c0 00 00 00 	mov    0xc0(%rsp),%rax
0566     2b06:	65 48 2b 04 25 28 00 00 00 	sub    %gs:0x28,%rax
056f     2b0f:	0f 85 77 03 00 00    	jne    2e8c <do_machine_check+0x8ec>
0575     2b15:	48 81 c4 c8 00 00 00 	add    $0xc8,%rsp
057c     2b1c:	5b                   	pop    %rbx
057d     2b1d:	5d                   	pop    %rbp
057e     2b1e:	41 5c                	pop    %r12
0580     2b20:	41 5d                	pop    %r13
0582     2b22:	41 5e                	pop    %r14
0584     2b24:	41 5f                	pop    %r15
0586     2b26:	e9 00 00 00 00       	jmp    2b2b <do_machine_check+0x58b>	2b27: R_X86_64_PLT32	__x86_return_thunk-0x4
058b     2b2b:	e8 50 f9 ff ff       	call   2480 <quirk_skylake_repmov>
0590     2b30:	84 c0                	test   %al,%al
0592     2b32:	0f 84 02 fb ff ff    	je     263a <do_machine_check+0x9a>
0598     2b38:	31 f6                	xor    %esi,%esi
059a     2b3a:	bf 7a 01 00 00       	mov    $0x17a,%edi
059f     2b3f:	e8 8c f1 ff ff       	call   1cd0 <mce_wrmsrl>
05a4     2b44:	eb b8                	jmp    2afe <do_machine_check+0x55e>
05a6     2b46:	42 8d 3c b5 01 04 00 00 	lea    0x401(,%r14,4),%edi
05ae     2b4e:	e9 a4 fd ff ff       	jmp    28f7 <do_machine_check+0x357>
05b3     2b53:	42 8d 3c bd 01 04 00 00 	lea    0x401(,%r15,4),%edi
05bb     2b5b:	e9 17 ff ff ff       	jmp    2a77 <do_machine_check+0x4d7>
05c0     2b60:	45 85 ff             	test   %r15d,%r15d
05c3     2b63:	0f 84 f9 fd ff ff    	je     2962 <do_machine_check+0x3c2>
05c9     2b69:	4c 0f ab ac 24 b8 00 00 00 	bts    %r13,0xb8(%rsp)
05d2     2b72:	44 89 f6             	mov    %r14d,%esi
05d5     2b75:	48 89 df             	mov    %rbx,%rdi
05d8     2b78:	89 44 24 10          	mov    %eax,0x10(%rsp)
05dc     2b7c:	e8 8f f7 ff ff       	call   2310 <mce_read_aux>
05e1     2b81:	8b 44 24 10          	mov    0x10(%rsp),%eax
05e5     2b85:	88 44 24 6a          	mov    %al,0x6a(%rsp)
05e9     2b89:	90                   	nop
05ea     2b8a:	48 89 df             	mov    %rbx,%rdi
05ed     2b8d:	e8 00 00 00 00       	call   2b92 <do_machine_check+0x5f2>	2b8e: R_X86_64_PLT32	mce_log-0x4
05f2     2b92:	90                   	nop
05f3     2b93:	8b 0c 24             	mov    (%rsp),%ecx
05f6     2b96:	8b 44 24 10          	mov    0x10(%rsp),%eax
05fa     2b9a:	39 c8                	cmp    %ecx,%eax
05fc     2b9c:	0f 8e c0 fd ff ff    	jle    2962 <do_machine_check+0x3c2>
0602     2ba2:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
0607     2ba7:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2bae <do_machine_check+0x60e>	2baa: R_X86_64_PC32	.data+0xb285c
060e     2bae:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
0613     2bb3:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2bba <do_machine_check+0x61a>	2bb6: R_X86_64_PC32	.data+0xb2864
061a     2bba:	48 8b 54 24 40       	mov    0x40(%rsp),%rdx
061f     2bbf:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2bc6 <do_machine_check+0x626>	2bc2: R_X86_64_PC32	.data+0xb286c
0626     2bc6:	48 8b 54 24 48       	mov    0x48(%rsp),%rdx
062b     2bcb:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2bd2 <do_machine_check+0x632>	2bce: R_X86_64_PC32	.data+0xb2874
0632     2bd2:	48 8b 54 24 50       	mov    0x50(%rsp),%rdx
0637     2bd7:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2bde <do_machine_check+0x63e>	2bda: R_X86_64_PC32	.data+0xb287c
063e     2bde:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
0643     2be3:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2bea <do_machine_check+0x64a>	2be6: R_X86_64_PC32	.data+0xb2884
064a     2bea:	48 8b 54 24 60       	mov    0x60(%rsp),%rdx
064f     2bef:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2bf6 <do_machine_check+0x656>	2bf2: R_X86_64_PC32	.data+0xb288c
0656     2bf6:	48 8b 54 24 68       	mov    0x68(%rsp),%rdx
065b     2bfb:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2c02 <do_machine_check+0x662>	2bfe: R_X86_64_PC32	.data+0xb2894
0662     2c02:	48 8b 54 24 70       	mov    0x70(%rsp),%rdx
0667     2c07:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2c0e <do_machine_check+0x66e>	2c0a: R_X86_64_PC32	.data+0xb289c
066e     2c0e:	48 8b 54 24 78       	mov    0x78(%rsp),%rdx
0673     2c13:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2c1a <do_machine_check+0x67a>	2c16: R_X86_64_PC32	.data+0xb28a4
067a     2c1a:	48 8b 94 24 80 00 00 00 	mov    0x80(%rsp),%rdx
0682     2c22:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2c29 <do_machine_check+0x689>	2c25: R_X86_64_PC32	.data+0xb28ac
0689     2c29:	48 8b 94 24 88 00 00 00 	mov    0x88(%rsp),%rdx
0691     2c31:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2c38 <do_machine_check+0x698>	2c34: R_X86_64_PC32	.data+0xb28b4
0698     2c38:	48 8b 94 24 90 00 00 00 	mov    0x90(%rsp),%rdx
06a0     2c40:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2c47 <do_machine_check+0x6a7>	2c43: R_X86_64_PC32	.data+0xb28bc
06a7     2c47:	48 8b 94 24 98 00 00 00 	mov    0x98(%rsp),%rdx
06af     2c4f:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2c56 <do_machine_check+0x6b6>	2c52: R_X86_64_PC32	.data+0xb28c4
06b6     2c56:	48 8b 94 24 a0 00 00 00 	mov    0xa0(%rsp),%rdx
06be     2c5e:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2c65 <do_machine_check+0x6c5>	2c61: R_X86_64_PC32	.data+0xb28cc
06c5     2c65:	48 8b 94 24 a8 00 00 00 	mov    0xa8(%rsp),%rdx
06cd     2c6d:	48 89 15 00 00 00 00 	mov    %rdx,0x0(%rip)        # 2c74 <do_machine_check+0x6d4>	2c70: R_X86_64_PC32	.data+0xb28d4
06d4     2c74:	89 04 24             	mov    %eax,(%rsp)
06d7     2c77:	e9 e6 fc ff ff       	jmp    2962 <do_machine_check+0x3c2>
06dc     2c7c:	8b 44 24 08          	mov    0x8(%rsp),%eax
06e0     2c80:	83 e0 08             	and    $0x8,%eax
06e3     2c83:	89 44 24 04          	mov    %eax,0x4(%rsp)
06e7     2c87:	0f 85 e1 fb ff ff    	jne    286e <do_machine_check+0x2ce>
06ed     2c8d:	48 8d 7c 24 1c       	lea    0x1c(%rsp),%rdi
06f2     2c92:	e8 89 f3 ff ff       	call   2020 <mce_start>
06f7     2c97:	44 8b 7c 24 1c       	mov    0x1c(%rsp),%r15d
06fc     2c9c:	89 44 24 14          	mov    %eax,0x14(%rsp)
0700     2ca0:	e9 df fb ff ff       	jmp    2884 <do_machine_check+0x2e4>
0705     2ca5:	44 89 e6             	mov    %r12d,%esi
0708     2ca8:	48 89 df             	mov    %rbx,%rdi
070b     2cab:	e8 60 f6 ff ff       	call   2310 <mce_read_aux>
0710     2cb0:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
0715     2cb5:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
071a     2cba:	b8 01 00 00 00       	mov    $0x1,%eax
071f     2cbf:	e9 7f fb ff ff       	jmp    2843 <do_machine_check+0x2a3>
0724     2cc4:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
0729     2cc9:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx	2ccc: R_X86_64_32S	.text+0xc5300
0730     2cd0:	48 89 df             	mov    %rbx,%rdi
0733     2cd3:	e8 00 00 00 00       	call   2cd8 <do_machine_check+0x738>	2cd4: R_X86_64_PC32	.text+0xc6bdc
0738     2cd8:	e9 14 fe ff ff       	jmp    2af1 <do_machine_check+0x551>
073d     2cdd:	31 c9                	xor    %ecx,%ecx
073f     2cdf:	31 d2                	xor    %edx,%edx
0741     2ce1:	be 12 00 00 00       	mov    $0x12,%esi
0746     2ce6:	48 89 ef             	mov    %rbp,%rdi
0749     2ce9:	e8 00 00 00 00       	call   2cee <do_machine_check+0x74e>	2cea: R_X86_64_PLT32	fixup_exception-0x4
074e     2cee:	85 c0                	test   %eax,%eax
0750     2cf0:	0f 84 7a 01 00 00    	je     2e70 <do_machine_check+0x8d0>
0756     2cf6:	48 8b 84 24 a8 00 00 00 	mov    0xa8(%rsp),%rax
075e     2cfe:	e9 e6 fd ff ff       	jmp    2ae9 <do_machine_check+0x549>
0763     2d03:	8b 7c 24 14          	mov    0x14(%rsp),%edi
0767     2d07:	e8 44 f4 ff ff       	call   2150 <mce_end>
076c     2d0c:	85 c0                	test   %eax,%eax
076e     2d0e:	0f 89 93 fd ff ff    	jns    2aa7 <do_machine_check+0x507>
0774     2d14:	8b 44 24 1c          	mov    0x1c(%rsp),%eax
0778     2d18:	85 c0                	test   %eax,%eax
077a     2d1a:	75 13                	jne    2d2f <do_machine_check+0x78f>
077c     2d1c:	31 c0                	xor    %eax,%eax
077e     2d1e:	83 3c 24 06          	cmpl   $0x6,(%rsp)
0782     2d22:	0f 9f c0             	setg   %al
0785     2d25:	89 44 24 1c          	mov    %eax,0x1c(%rsp)
0789     2d29:	0f 8e 78 fd ff ff    	jle    2aa7 <do_machine_check+0x507>
078f     2d2f:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
0794     2d34:	48 89 de             	mov    %rbx,%rsi
0797     2d37:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	2d3a: R_X86_64_32S	.rodata+0x3ac80
079e     2d3e:	e8 6d f0 ff ff       	call   1db0 <mce_panic>
07a3     2d43:	e9 5f fd ff ff       	jmp    2aa7 <do_machine_check+0x507>
07a8     2d48:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
07ad     2d4d:	48 89 de             	mov    %rbx,%rsi
07b0     2d50:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	2d53: R_X86_64_32S	.rodata+0x3ac40
07b7     2d57:	e8 54 f0 ff ff       	call   1db0 <mce_panic>
07bc     2d5c:	44 8b 7c 24 1c       	mov    0x1c(%rsp),%r15d
07c1     2d61:	e9 1e fb ff ff       	jmp    2884 <do_machine_check+0x2e4>
07c6     2d66:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 2d6d <do_machine_check+0x7cd>	2d69: R_X86_64_PC32	pcpu_hot+0x14
07cd     2d6d:	48 29 e0             	sub    %rsp,%rax
07d0     2d70:	48 3d ff 7f 00 00    	cmp    $0x7fff,%rax
07d6     2d76:	0f 87 0d 01 00 00    	ja     2e89 <do_machine_check+0x8e9>
07dc     2d7c:	f6 85 88 00 00 00 03 	testb  $0x3,0x88(%rbp)
07e3     2d83:	0f 84 00 01 00 00    	je     2e89 <do_machine_check+0x8e9>
07e9     2d89:	48 89 df             	mov    %rbx,%rdi
07ec     2d8c:	e8 00 00 00 00       	call   2d91 <do_machine_check+0x7f1>	2d8d: R_X86_64_PLT32	mce_usable_address-0x4
07f1     2d91:	84 c0                	test   %al,%al
07f3     2d93:	0f 85 be 00 00 00    	jne    2e57 <do_machine_check+0x8b7>
07f9     2d99:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
07fe     2d9e:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx	2da1: R_X86_64_32S	.text+0xc5450
0805     2da5:	48 89 df             	mov    %rbx,%rdi
0808     2da8:	e8 00 00 00 00       	call   2dad <do_machine_check+0x80d>	2da9: R_X86_64_PC32	.text+0xc6bdc
080d     2dad:	e9 3f fd ff ff       	jmp    2af1 <do_machine_check+0x551>
0812     2db2:	be 01 00 00 00       	mov    $0x1,%esi
0817     2db7:	bf 04 00 00 00       	mov    $0x4,%edi
081c     2dbc:	e8 00 00 00 00       	call   2dc1 <do_machine_check+0x821>	2dbd: R_X86_64_PLT32	add_taint-0x4
0821     2dc1:	e9 eb fc ff ff       	jmp    2ab1 <do_machine_check+0x511>
0826     2dc6:	b9 01 00 00 00       	mov    $0x1,%ecx
082b     2dcb:	48 89 ee             	mov    %rbp,%rsi
082e     2dce:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
0833     2dd3:	48 89 df             	mov    %rbx,%rdi
0836     2dd6:	e8 00 00 00 00       	call   2ddb <do_machine_check+0x83b>	2dd7: R_X86_64_PLT32	mce_severity-0x4
083b     2ddb:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
0840     2de0:	48 89 de             	mov    %rbx,%rsi
0843     2de3:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	2de6: R_X86_64_32S	.rodata+0x3ace0
084a     2dea:	e8 c1 ef ff ff       	call   1db0 <mce_panic>
084f     2def:	90                   	nop
0850     2df0:	45 85 e4             	test   %r12d,%r12d
0853     2df3:	0f 84 be fc ff ff    	je     2ab7 <do_machine_check+0x517>
0859     2df9:	be 01 00 00 00       	mov    $0x1,%esi
085e     2dfe:	bf 04 00 00 00       	mov    $0x4,%edi
0863     2e03:	e8 00 00 00 00       	call   2e08 <do_machine_check+0x868>	2e04: R_X86_64_PLT32	add_taint-0x4
0868     2e08:	e9 aa fc ff ff       	jmp    2ab7 <do_machine_check+0x517>
086d     2e0d:	48 89 df             	mov    %rbx,%rdi
0870     2e10:	e8 00 00 00 00       	call   2e15 <do_machine_check+0x875>	2e11: R_X86_64_PLT32	mce_usable_address-0x4
0875     2e15:	84 c0                	test   %al,%al
0877     2e17:	0f 84 d4 fc ff ff    	je     2af1 <do_machine_check+0x551>
087d     2e1d:	48 8b 7c 24 40       	mov    0x40(%rsp),%rdi
0882     2e22:	48 c1 ef 0c          	shr    $0xc,%rdi
0886     2e26:	e8 00 00 00 00       	call   2e2b <do_machine_check+0x88b>	2e27: R_X86_64_PLT32	pfn_to_online_page-0x4
088b     2e2b:	48 89 c3             	mov    %rax,%rbx
088e     2e2e:	48 85 c0             	test   %rax,%rax
0891     2e31:	0f 84 ba fc ff ff    	je     2af1 <do_machine_check+0x551>
0897     2e37:	be 08 00 00 00       	mov    $0x8,%esi
089c     2e3c:	48 89 c7             	mov    %rax,%rdi
089f     2e3f:	e8 00 00 00 00       	call   2e44 <do_machine_check+0x8a4>	2e40: R_X86_64_PLT32	__kasan_check_write-0x4
08a4     2e44:	80 4b 02 20          	orb    $0x20,0x2(%rbx)
08a8     2e48:	e9 a4 fc ff ff       	jmp    2af1 <do_machine_check+0x551>
08ad     2e4d:	e8 2e ef ff ff       	call   1d80 <unexpected_machine_check.constprop.0>
08b2     2e52:	e9 a7 fc ff ff       	jmp    2afe <do_machine_check+0x55e>
08b7     2e57:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
08bc     2e5c:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx	2e5f: R_X86_64_32S	.text+0xc54b0
08c3     2e63:	48 89 df             	mov    %rbx,%rdi
08c6     2e66:	e8 00 00 00 00       	call   2e6b <do_machine_check+0x8cb>	2e67: R_X86_64_PC32	.text+0xc6bdc
08cb     2e6b:	e9 81 fc ff ff       	jmp    2af1 <do_machine_check+0x551>
08d0     2e70:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
08d5     2e75:	48 89 de             	mov    %rbx,%rsi
08d8     2e78:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	2e7b: R_X86_64_32S	.rodata+0x3ad20
08df     2e7f:	e8 2c ef ff ff       	call   1db0 <mce_panic>
08e4     2e84:	e9 6d fe ff ff       	jmp    2cf6 <do_machine_check+0x756>
08e9     2e89:	90                   	nop
08ea     2e8a:	0f 0b                	ud2
08ec     2e8c:	e8 00 00 00 00       	call   2e91 <do_machine_check+0x8f1>	2e8d: R_X86_64_PLT32	__stack_chk_fail-0x4
08f1     2e91:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
08fc     2e9c:	0f 1f 40 00          	nopl   0x0(%rax)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

