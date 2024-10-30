Return-Path: <linux-edac+bounces-2352-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4939B68F6
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 17:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DB8282362
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 16:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505101F4702;
	Wed, 30 Oct 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RzK4E9Fk"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A74F201;
	Wed, 30 Oct 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304983; cv=none; b=i2Epb48XITH/pToKhysRFxZWqTYLRITKevb0W7dsibNN5QtZn9nzR6Y5g8hTGReaajj117XecCg1tNYJPitsC6d8n6sdaAd0x3Oe5bFSIYD/AkfUzfgGQJjjWgcBZPQ2DTpc64cUcebNLXkkD0cJEswmBM4QlwE8rweFpwQ65aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304983; c=relaxed/simple;
	bh=kqCYoGOPb0YkuFw/4jiFAO2c1fO8Kfah7tW6EIFl+E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6wg9BOfuSQ1XNOXGb+FLKjhw+Las/JuzlUAoz5P1xZyNT1k3D9Kr+HDIEOdgPNGel1clflh2eBB0y3ayS6PKK07EcPkyGE52HYanS/sVYmkAaziVfjmfTDSh01LANGpQxp37Kd1QFd6nHoyKUHs4VOqdTrIfTG9uULRQ0Dej9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RzK4E9Fk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6D2D440E0191;
	Wed, 30 Oct 2024 16:16:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LQYbWhqkUNXV; Wed, 30 Oct 2024 16:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730304970; bh=kK0G6UpigM860xak7Fb6jcTGR0SUbx7e9Lbw6tELyXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RzK4E9FkoJAHYi4oa5lDFEDTjEFxfTY8R9eilasnCUOsWGKtgL+rdHUhNnMqCCqbh
	 6CvPW0FA/A1x4jpOfcOkS8ZGQW51Zaxs6BRKHK2SfVobGdIXTi4V8V13K1Gv4cfTrR
	 HGMAQak0MNafE+mF0N8SMYFrXFbe7ibl3cdy4FMoLp4+oef0HXkInqXePt9PATl0I8
	 WYzQdfcCg6FPdP32UU3rIg7MvFSrFVNoG0lFycoHb9A+mpsha4m4Zx9pF3AxJhCBiR
	 ZZ1qSKMrBVxgF8SzBnMfZV03TyQpzS3tdcM5MUFnehuO2P1VFLtCB5ol9g2wSM6iet
	 2+rHHU6mvFknfwXdntpCPgx3AJ5TuaCbXf85V94Me85U23B0Ajdgbkpk98aUkBw0kc
	 wKN2hgs37ehD5F5FB1jFgBTGTSkQhIvWEATUO5Ftj5ZPIEliTVilhHoPDgHnAxJeiq
	 KyrzDo7PxvdEhvESLaMiSt2OMUjaqA72B2q3Cj7EBgs8ce9wT9mgfyDFW8Yq9KxEdl
	 yg12N1CAk+JVxOADzv3KGBOm3Anyskt+t+x8wtHxGMM88hO54XW3CXUrs5GHu873D1
	 4s6ef8tWbsh/sdYDk5QvhKm1a3DU8aXphclcmVyPbBwiPY0gpuX83LYKrT04dEU3CC
	 VZKuwHcPaDsCj1E3vh0SMjIE=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 38C7B40E0028;
	Wed, 30 Oct 2024 16:15:57 +0000 (UTC)
Date: Wed, 30 Oct 2024 17:15:50 +0100
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, qiuxu.zhuo@intel.com, tglx@linutronix.de,
	mingo@redhat.com, rostedt@goodmis.org, mchehab@kernel.org,
	yazen.ghannam@amd.com, john.allen@amd.com
Subject: Re: [PATCH v7 5/5] EDAC/mce_amd: Add support for FRU Text in MCA
Message-ID: <20241030161550.GFZyJbthMO_2Wxe3bV@fat_crate.local>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-6-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022194158.110073-6-avadhut.naik@amd.com>

On Tue, Oct 22, 2024 at 07:36:31PM +0000, Avadhut Naik wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> A new "FRU Text in MCA" feature is defined where the Field Replaceable
> Unit (FRU) Text for a device is represented by a string in the new
> MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
> bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).
> 
> The FRU Text is populated dynamically for each individual error state
> (MCA_STATUS, MCA_ADDR, et al.). This handles the case where an MCA bank
> covers multiple devices, for example, a Unified Memory Controller (UMC)
> bank that manages two DIMMs.
> 
> Since MCA_CONFIG[9] is instrumental in decoding FRU Text, it has to be
> exported through the mce_record tracepoint so that userspace tools like
> the rasdaemon can determine if FRU Text has been reported through the
> MCA_SYND1 and MCA_SYND2 registers and output it.

IOW:

Author: Yazen Ghannam <yazen.ghannam@amd.com>
Date:   Tue Oct 22 19:36:31 2024 +0000

    EDAC/mce_amd: Add support for FRU text in MCA
    
    A new "FRU Text in MCA" feature is defined where the Field Replaceable
    Unit (FRU) Text for a device is represented by a string in the new
    MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
    bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).
    
    The FRU Text is populated dynamically for each individual error state
    (MCA_STATUS, MCA_ADDR, et al.). This handles the case where an MCA bank
    covers multiple devices, for example, a Unified Memory Controller (UMC)
    bank that manages two DIMMs.
    
    If SYND1 and SYND2 are !NULL, then userspace can assume that they
    contain FRU text information. If they will report other information in
    the future, then a way of communicating the info type contained must be
    devised.
    
      [ Yazen: Add Avadhut as co-developer for wrapper changes. ]
      [ bp: Do not expose MCA_CONFIG to userspace yet. ]
    
    Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
    Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
    Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
    Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
    Link: https://lore.kernel.org/r/20241022194158.110073-6-avadhut.naik@amd.com

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4d936ee20e24..649a901ad563 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -61,6 +61,7 @@
  *  - TCC bit is present in MCx_STATUS.
  */
 #define MCI_CONFIG_MCAX		0x1
+#define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
 #define MCI_IPID_MCATYPE	0xFFFF0000
 #define MCI_IPID_HWID		0xFFF
 
@@ -212,6 +213,7 @@ struct mce_hw_err {
 		struct {
 			u64 synd1;		/* MCA_SYND1 MSR */
 			u64 synd2;		/* MCA_SYND2 MSR */
+			u64 config;		/* MCA_CONFIG MSR */
 		} amd;
 	} vendor;
 };
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6ca80fff1fea..65ace034af08 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -796,6 +796,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 
 	if (mce_flags.smca) {
 		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
+		rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), err.vendor.amd.config);
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 0a89947e47bc..19a1c72fc2bf 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -155,6 +155,8 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 		fallthrough;
 	/* MCA_CONFIG */
 	case 4:
+		err.vendor.amd.config = *(i_mce + 3);
+		fallthrough;
 	/* MCA_MISC0 */
 	case 3:
 		m->misc = *(i_mce + 2);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index fca23fe16abe..edc2c8033de8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -681,6 +681,7 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
+		err->vendor.amd.config = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(i));
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 194d9fd47d20..62fcd92bf9d2 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -795,6 +795,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	struct mce *m = (struct mce *)data;
 	struct mce_hw_err *err = to_mce_hw_err(m);
 	unsigned int fam = x86_family(m->cpuid);
+	u64 mca_config = err->vendor.amd.config;
 	int ecc;
 
 	if (m->kflags & MCE_HANDLED_CEC)
@@ -814,11 +815,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
-		u32 low, high;
-		u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
-
-		if (!rdmsr_safe(addr, &low, &high) &&
-		    (low & MCI_CONFIG_MCAX))
+		if (mca_config & MCI_CONFIG_MCAX)
 			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
 
 		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
@@ -853,8 +850,15 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
-			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
-				 err->vendor.amd.synd1, err->vendor.amd.synd2);
+			if (mca_config & MCI_CONFIG_FRUTEXT) {
+				char frutext[17];
+
+				frutext[16] = '\0';
+				memcpy(&frutext[0], &err->vendor.amd.synd1, 8);
+				memcpy(&frutext[8], &err->vendor.amd.synd2, 8);
+
+				pr_emerg(HW_ERR "FRU Text: %s", frutext);
+			}
 		}
 
 		pr_cont("\n");


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

