Return-Path: <linux-edac+bounces-4252-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D31DAE8C1E
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jun 2025 20:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F883B6B98
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jun 2025 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C945C2701D8;
	Wed, 25 Jun 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GjWucunt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6931DDC1E;
	Wed, 25 Jun 2025 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875314; cv=none; b=ky3YndlOAAJ22MSEXBpk5BO+ET79GelCRAQ0NHBXoDosPW6to57ExKt+U2fy0td0AZT3JLK51SPWDA9xncVCje0CLBs2B2Zu/m5jLcfU3CVY4qLvsWsVbbFu5NerA2/wy6WZraTDjxjW2vbjnGT0J19gzRmPYWPEsFmMePG18fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875314; c=relaxed/simple;
	bh=CxtBoFDG1a0gobPdzSr/uuDoJXqLk9bYZjbFWAhbBBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mn6BGRO6HYQNHffPoTlpwSDf1Ysd6tVZOBvpNjP2P/a6rYnFmNLXpQhz4aGNMHkVEf13Qh7dz+K3XZe/21+dDTOmH1+bTDRPxBKYA6lCXbvjSaicdSWzH3/zHCfcCXeYM5DzPjVRDcQPLgM1Tx6H/R3he8M2+muZk14bMndBnVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GjWucunt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750875313; x=1782411313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CxtBoFDG1a0gobPdzSr/uuDoJXqLk9bYZjbFWAhbBBg=;
  b=GjWucuntzDlCAsjVTOqCtn3XSaPD34QitzeFGh9ZRfrynr9bj66Gfx9z
   AEomu79lVc00ivkeAxa9J0cjUdUggp95AvSVqU4Jv+qE55rkjwvCDiptZ
   cUnunSiUv6FTUJ+5RLVsg0gKepoTOX/tMNQTPLw+qJvHLIBG4PdjTtlbg
   DzTjYxovG3YjFzgqnNr4ecB9c2oCyYM1iQ/BJ0XLAgC5k6TqnhZ4Opv1o
   hnWMFOepU24cnxF9blxZdPdEmXgsjV+B3k8PYGuN1DRqCoFX2aot+c62x
   m+gjdYbQga6Iz3MD2OjkjiW8Mv7lLUdyh0138ULpgiOSUrXhjaYsslTzo
   w==;
X-CSE-ConnectionGUID: NsGMuXHcT9So33Yjuvalsg==
X-CSE-MsgGUID: rNdYn1T9RY6D7QztHv+VIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="75695502"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="75695502"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 11:15:12 -0700
X-CSE-ConnectionGUID: SxgJoMYURoeM4rO5GTa72A==
X-CSE-MsgGUID: a9b+IyaeR3GAlzq0ei13Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="158050180"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 11:15:11 -0700
Date: Wed, 25 Jun 2025 11:15:09 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, aijay@meta.com,
	x86@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mce: include cmci during intel feature clearing
Message-ID: <aFw8rWwTVw85cavh@agluck-desk3>
References: <20250617214752.178263-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617214752.178263-1-inwardvessel@gmail.com>

On Tue, Jun 17, 2025 at 02:47:52PM -0700, JP Kobryn wrote:
> It was found that after a kexec on an intel CPU, MCE reporting was no
> longer active. The root cause has been found to be that ownership of CMCI
> banks is not cleared during the shutdown phase. As a result, when CPU's
> come back online, they are unable to rediscover these occupied banks. If we
> clear these CPU associations before booting into the new kernel, the CMCI
> banks can be reclaimed and MCE reporting will become functional once more.
> 
> The existing code does seem to have the intention of clearing MCE-related
> features via mcheck_cpu_clear(). During a kexec reboot, there are two
> sequences that reach a call to mcheck_cpu_clear(). They are:
> 
> 1) Stopping other (remote) CPU's via IPI:
> native_machine_shutdown()
> 	stop_other_cpus()
> 		smp_ops.stop_other_cpus(1)
> 		x86 smp: native_stop_other_cpus(1)
> 			apic_send_IPI_allbutself(REBOOT_VECTOR)
> 
> ...IPI is received on remote CPU's and IDT sysvec_reboot invoked:
> 	stop_this_cpu()
> 		mcheck_cpu_clear(this_ptr_cpu(&cpu_info))
> 
> 2) Seqence of stopping the active CPU (the one performing the kexec):
> native_machine_shutdown()
> 	stop_other_cpus()
> 		smp_ops.stop_other_cpus(1)
> 		x86 smp: native_stop_other_cpus(1)
> 			mcheck_cpu_clear(this_ptr_cpu(&cpu_info))
> 
> In both cases, the call to mcheck_cpu_clear() leads to the vendor specific
> call to intel_feature_clear():
> 
> mcheck_cpu_clear(this_ptr_cpu(&cpu_info))
> 	__mcheck_cpu_clear_vendor(c)
> 		switch (c->x86_vendor)
> 		case X86_VENDOR_INTEL:
> 			mce_intel_feature_clear(c)
> 
> Now looking at the pair of functions mce_intel_feature_{init,clear}, there
> are 3 MCE features setup on the init side:
> 
> mce_intel_feature_init(c)
> 	intel_init_cmci()
> 	intel_init_lmce()
> 	intel_imc_init(c)
> 
> On the other side in the clear function, only one of these features is
> actually cleared:
> 
> mce_intel_feature_clear(c)
> 	intel_clear_lmce()
> 
> Just focusing on the feature pertaining to the root cause of the kexec
> issue, there would be a benefit if we additionally cleared the CMCI feature
> within this routine - the banks would be free for acquisition on the boot
> up side of a kexec. This patch adds the call to clear CMCI to this intel
> routine.
> 
> Reported-by: Aijay Adams <aijay@meta.com>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

LGTM

Reviewed-by: Tony Luck <tony.luck@intel.com>

> ---
>  arch/x86/kernel/cpu/mce/intel.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> index efcf21e9552e..9b149b9c4109 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -478,6 +478,7 @@ void mce_intel_feature_init(struct cpuinfo_x86 *c)
>  void mce_intel_feature_clear(struct cpuinfo_x86 *c)
>  {
>  	intel_clear_lmce();
> +	cmci_clear();

I particularly like that you found a one-line fix!

>  }
>  
>  bool intel_filter_mce(struct mce *m)
> -- 
> 2.47.1
> 

