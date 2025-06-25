Return-Path: <linux-edac+bounces-4253-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C10AE8EE5
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jun 2025 21:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A2E4A46EF
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jun 2025 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06DF2D5C81;
	Wed, 25 Jun 2025 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EK2gprrP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FEF3074BC;
	Wed, 25 Jun 2025 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750880629; cv=none; b=RpAq3BzXH/VcUYcts0kckHSVpv59ltGwijCdBqcG/vtdRR1vCQOwz4SwR5tGVuEnoMd3oNcKJgaP/14r6w584TePRVpo+BeKXI+R8nRwx3BsxEulbGDjL+ki7+c+4PjPGA7BQahrX88AKVjAQ7YiQDQZH8ATTv/7JIV0dTnlKqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750880629; c=relaxed/simple;
	bh=85TBiF9vWpEzOiyWOW6FnwMDFFQ0OHyo9F1KYkZHRJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmTIHUCPtpH1zDx3+ue3QLzOCIhAwXtzMqt8qm+UoLm5hxqA39q42CjOnVLCTLG5dYyKqf9JNSP7hQsF7ZynclgODYwb4bR0EAtgHYEurJPAT4ojN0YM3kknd/6ZRBlu0yVcDCaTaWfwNpT1HlJ0gkrlS3xGVFZHKV8LBbTfN58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EK2gprrP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A55C340E019C;
	Wed, 25 Jun 2025 19:43:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QCoBZ2S8itpe; Wed, 25 Jun 2025 19:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750880620; bh=j8KXOyVlrTz3WrmUUDKu9Dp2Ys4WOvLarIGmlHJOLtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EK2gprrPUlw0WCgeibzeftf5aMmtKn86GN7kpnQYc1ptMpjshm+ZlDneG5x7fnSuQ
	 BKQfs+vz48302ygD44ATw0R6lmWZgXcXeGi7ck4de76kjvMoTKz8g2YuiTX2599fIB
	 T9DoJjcfSQ35YPX327YyrcmZqaUGYROiq8nvNgQqRuwGshfxdTpXCV1QeQhcHVwAYZ
	 aM6xeCEMgJgqdkIaAujlmhoYJ+EP2DItCoAhZA/ORoIQbOzKZ/kEKd2qsxlT1XSaU8
	 VYcOMrjmG173BRJlZpvtkVxAKl7+wMc1jMwy+hSnOvF3mpPyTTEJI8CH7ugaCRqWM8
	 cW1qXHLXFPXtg19moqoF+jmtBIZdG0V8YXzN2419VXkr1VqqhB7sVake6Em9nYq/VB
	 /TqPOKCdfDwZ9XRqG/NLTzwD/o0ITkyGFGYofSfHE770ibtvK+uNUaun9TkFxS7+7T
	 lKmvUg3YMtwXd3w+ep5v9picR0zzkUzzgAEpzM0sPinCEmebW3gr5U83vc3/WHqmUE
	 vzohUnybJu9ggJx5vFVwOJtPUU57rjbaUxJzjb7EKqJg7ZBfbpP6cCjk3GybclD7Bq
	 ISs0Nm8gXv96Wj9iL1re7kyvNaiyJTxajcWHzQA9SIzRySfe4pQx1ETqlOhWCSFKcT
	 cZjLfwYRHP5AgNfcW2oi+HY8=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D466440E00DE;
	Wed, 25 Jun 2025 19:43:28 +0000 (UTC)
Date: Wed, 25 Jun 2025 21:43:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, aijay@meta.com,
	x86@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mce: include cmci during intel feature clearing
Message-ID: <20250625194322.GGaFxRWqx0WbE90k6N@fat_crate.local>
References: <20250617214752.178263-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Please:

 - shorten this commit message - there really is no need to explain in such
   detail that mcheck_cpu_clear() has simply forgotten to clear CMCI banks
   too.

 - run it through a spellchecker

 - drop all personal pronouns

 - write it in imperative tone

Some hints:

Section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

Also, see section "Changelog" in
Documentation/process/maintainer-tip.rst

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

