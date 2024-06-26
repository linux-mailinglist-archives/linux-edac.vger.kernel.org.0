Return-Path: <linux-edac+bounces-1379-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A255918058
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 13:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446351F2119E
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 11:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8673B1802C2;
	Wed, 26 Jun 2024 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OlSDsUWb"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E28149E06;
	Wed, 26 Jun 2024 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403078; cv=none; b=puSIxl/4LIbgN2GVs/PMuWQNAkufIg3QVfxuXTOZViV1vnds/BuzEPBErXO7ivRPdoYKqoW0LbjhR1z8ENE3ojN+fiOrkNFvQZXMD4zMumWhAwmUhRm4Arl7LjVC7b0B87vRle/amVpqoOlB7MjP0pyP9EKbGsz7FGCRU/o1g+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403078; c=relaxed/simple;
	bh=N4l6MEM8Kb0sl/tgaxpPhxXwDu9KIcUXzbA5ENyc4Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHW3pfO1pxDEaYlkx7KKLtVLsnSY/Gk6w6NMYYp01XnFT146tnnGU4eszu59mdjb0PW6tBFtKJn5bJTxArpLxk4IG7h0rGKiHKH9ZsKo1RbOG1oKU6jjBP6rkT0+Yf+6n1vjh4qiJXJ6p2yK2CHQZk5L2JepRHKQUct7h+XwTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OlSDsUWb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E03D640E0219;
	Wed, 26 Jun 2024 11:57:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3BoJPFucZedR; Wed, 26 Jun 2024 11:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719403069; bh=r49OXr3owHtWkbfriGJWueL5gi1+VE3lZHu88Kq8SVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OlSDsUWbpR1ckeVIt9DRoVmraS5ScvD0SdcsdlzdJDyhdg+qnsStSjIEAoD+C0Bqt
	 MWKu6ac4ZOsK8bW8kry0XHTaFVqigwkPYBHsOlMBIIHB9EUGuayIEpe1alGG25NrEM
	 vb1CHn4yFj7a3/LGHPa38fa2UAgWXw5MZrGwCXR1EduRaRHppGdPqc5hZiyGGgkGjv
	 FlRL/hzLaJfaaVR1O2l0LrbnBMRQoo0NKnI6/1q36ss9Kbfz3FSFHYI6CsWuojyQJB
	 p9I4LtngJMrlZKfNPEADovMRU10VPAQKNIKYkDErbGQbU6We/CE6usih2z4EMA0AVJ
	 qhZt5ea3oQFVAdNVBQmHyZLvVoYBO46I3WNrH2FW669elDEtAE1yuZLP8Jgj3Lo/Hu
	 /PVR8tdPXpy0FU6eJ+RddI/kXUfN+Sh3xsmpW0D5KL3wI2Qt7PQpo1dpOBfLaxxYA+
	 cuKNB9JJWXgZMQNTr72gTIYg5H9VQsJIdHBvdiLpKcbAfyqPkM/+OPMfWdLR/W3Mnf
	 PJcV0mWKe6sEdmKP8R5b77OWNxwqht20t0AW75yt7PmtzYmheuEtssQ8arAPjuQ961
	 uHjYZ2P+HC5inOFoRfoM3H0YmfkUmeCEqFU7rM0qtvPscjOTPbow/UQTFH3RjsT9zp
	 Vcn287CjQbUSHqpSg3KMwbhQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E11340E0218;
	Wed, 26 Jun 2024 11:57:31 +0000 (UTC)
Date: Wed, 26 Jun 2024 13:57:24 +0200
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	rostedt@goodmis.org, lenb@kernel.org, mchehab@kernel.org,
	james.morse@arm.com, airlied@gmail.com, yazen.ghannam@amd.com,
	john.allen@amd.com, avadnaik@amd.com
Subject: Re: [PATCH v2 3/4] x86/mce/apei: Handle variable register array size
Message-ID: <20240626115641.GPZnwB-QEGYCoI_Fv3@fat_crate.local>
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
 <20240625195624.2565741-4-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240625195624.2565741-4-avadhut.naik@amd.com>

On Tue, Jun 25, 2024 at 02:56:23PM -0500, Avadhut Naik wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> ACPI Boot Error Record Table (BERT) is being used by the kernel to
> report errors that occurred in a previous boot. On some modern AMD
> systems, these very errors within the BERT are reported through the
> x86 Common Platform Error Record (CPER) format which consists of one
> or more Processor Context Information Structures. These context
> structures provide a starting address and represent an x86 MSR range
> in which the data constitutes a contiguous set of MSRs starting from,
> and including the starting address.
> 
> It's common, for AMD systems that implement this behavior, that the
> MSR range represents the MCAX register space used for the Scalable MCA
> feature. The apei_smca_report_x86_error() function decodes and passes
> this information through the MCE notifier chain. However, this function
> assumes a fixed register size based on the original HW/FW implementation.
> 
> This assumption breaks with the addition of two new MCAX registers viz.
> MCA_SYND1 and MCA_SYND2. These registers are added at the end of the
> MCAX register space, so they won't be included when decoding the CPER
> data.
> 
> Rework apei_smca_report_x86_error() to support a variable register array
> size. This covers any case where the MSR context information starts at
> the MCAX address for MCA_STATUS and ends at any other register within
> the MCAX register space.
> 
> Add code comments indicating the MCAX register at each offset.
> 
> [Yazen: Add Avadhut as co-developer for wrapper changes.]
> 
> Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

This needs Avadhut's SOB after Yazen's.

Touchups ontop:

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 7a15f0ca1bd1..6bbeb29125a9 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -69,7 +69,7 @@ EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
-	unsigned int cpu, num_registers;
+	unsigned int cpu, num_regs;
 	struct mce_hw_err err;
 	struct mce *m = &err.m;
 
@@ -93,10 +93,10 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	/*
 	 * The number of registers in the register array is determined by
 	 * Register Array Size/8 as defined in UEFI spec v2.8, sec N.2.4.2.2.
-	 * Ensure that the array size includes at least 1 register.
+	 * Sanity-check registers array size.
 	 */
-	num_registers = ctx_info->reg_arr_size >> 3;
-	if (!num_registers)
+	num_regs = ctx_info->reg_arr_size >> 3;
+	if (!num_regs)
 		return -EINVAL;
 
 	mce_setup(m);
@@ -118,13 +118,12 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	/*
 	 * The SMCA register layout is fixed and includes 16 registers.
 	 * The end of the array may be variable, but the beginning is known.
-	 * Switch on the number of registers. Cap the number of registers to
-	 * expected max (15).
+	 * Cap the number of registers to expected max (15).
 	 */
-	if (num_registers > 15)
-		num_registers = 15;
+	if (num_regs > 15)
+		num_regs = 15;
 
-	switch (num_registers) {
+	switch (num_regs) {
 	/* MCA_SYND2 */
 	case 15:
 		err.vi.amd.synd2 = *(i_mce + 14);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

