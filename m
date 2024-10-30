Return-Path: <linux-edac+bounces-2361-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0B39B6B8B
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 19:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B71281520
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080FE19E83C;
	Wed, 30 Oct 2024 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WH3g1CY6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF5E1BD9F6;
	Wed, 30 Oct 2024 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730311339; cv=none; b=AhNY6nwRO1ypENCTRLCUWTdry2AWwu+GTXeivvfrUyQfU8+Hf0JJnp8zub05Kmlh+O5kwGJHz5hT/oN9k0hC+LPF6neloPNEEZOFH7gkxGJ4u9KqYqyJyVyPGHkhwpeGy1BaBEf6NMkvdvV1r4UJLbHhFliOeibxp9/BDP0jIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730311339; c=relaxed/simple;
	bh=UgvI6PkVlyajgEM1Xfd2/p1Zgl3QqjNh0Iv301xCL9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pjn7JM8uzbpV8ktVOEGHguam+pVSEzPeADExrzRAeRhtJg8pkPL6C4ugRaBvBGW0Ii0bGy8+j5i01LSLfuVS+8Se2igZccGKKoXbZx3eZoE9359GpmtZoQyT5lxtpfuO9lH7OdYrS9X6aG9Dm1fLXsvcUqGd9VnhzUG8wDZVnHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WH3g1CY6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C665440E0219;
	Wed, 30 Oct 2024 18:02:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 97m6go7JPOmf; Wed, 30 Oct 2024 18:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730311329; bh=A7UlbAoEKkZqN3GUK0ves5JmgrAolNP4OucBH/HsqMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WH3g1CY6437MS55xSg+EqZ1TlG5bwB3WRUYxZyAETKqze9ZQYJY7m2imSd8Qt/B7L
	 7kb/gYAejO09Y5vr04r1PM81yDQqtXZtSQV2UUMmQ1a9QKaiZzu0I6RFWD+a+Sjull
	 9lw7J7MEeYd4KlPMTzcb/UdaGH4YNG4aOxr50jXD286JxkmKivDqzLw8H/hSgEWJG+
	 DdqJzWzTqdzp1OQXVULQXQI3XK4kt725b/ZqBkMrMus15QaYbYdPW1jY+StLocCs6t
	 8HGvCkWe1mHuDYjlaMYnnW384UqoB6QU5Bnkbp1XNU51VCiC1VZX1+FZ44VBexITa9
	 oneICy2gmjEJr8eHuOiiaLMNutylKJ4hH/wA/SspgzMgoLPl6qsAaWzmwJZZ7xZfdY
	 kP/I6xpkeODuhE2A1vBj5GHnxV6WKqUNM0O629L3cs/OQR0tR6p+y7Gk9OYgbHInio
	 XiJhPBe6N/f1Qpyx3B3/kY/ppM72fjRmWdiAoxBOViANOcT1UtLpaI06bcupTbgrIR
	 aL86KrF75hqsU37TnoUo8L91tCHgSQfpafC8MukPhKy94gfc4uKV+nAxUcYvi7zViW
	 5bZETd3yWpbHZ9QWHyVHYSbHF2CV0cqwv0SZMRJaJ/Nh1RlVadkKMY5AOAhQyoG+qF
	 EEtzk7rjat4jAj6qQ6NM0U1Y=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6577840E019C;
	Wed, 30 Oct 2024 18:01:56 +0000 (UTC)
Date: Wed, 30 Oct 2024 19:01:50 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	qiuxu.zhuo@intel.com, tglx@linutronix.de, mingo@redhat.com,
	rostedt@goodmis.org, mchehab@kernel.org, john.allen@amd.com
Subject: Re: [PATCH v7 5/5] EDAC/mce_amd: Add support for FRU Text in MCA
Message-ID: <20241030180041.GGZyJ0SXfa73Q7NmwF@fat_crate.local>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-6-avadhut.naik@amd.com>
 <20241030161550.GFZyJbthMO_2Wxe3bV@fat_crate.local>
 <20241030163147.GA1379143@yaz-khff2.amd.com>
 <20241030165002.GFZyJjuifxBLUDKyL6@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241030165002.GFZyJjuifxBLUDKyL6@fat_crate.local>

On Wed, Oct 30, 2024 at 05:50:02PM +0100, Borislav Petkov wrote:
> Bah, crap. Lemme go back and take a second stab at this.

Second try.

The reason why I don't want to expose MCA_CONFIG to userspace is, well,
userspace doesn't need to know any "management" information the hw gives. It
either gets FRU text in that tracepoint or it doesn't. But it doesn't need to
know what MCA_CONFIG said or didn't say.

Ok?

Author: Yazen Ghannam <yazen.ghannam@amd.com>
Date:   Tue Oct 22 19:36:31 2024 +0000

    EDAC/mce_amd: Add support for FRU text in MCA
    
    A new "FRU Text in MCA" feature is defined where the Field Replaceable
    Unit (FRU) Text for a device is represented by a string in the new
    MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
    bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).
    
    The FRU Text is populated dynamically for each individual error state
    (MCA_STATUS, MCA_ADDR, et al.). Handle the case where an MCA bank covers
    multiple devices, for example, a Unified Memory Controller (UMC) bank
    that manages two DIMMs.
    
      [ Yazen: Add Avadhut as co-developer for wrapper changes. ]
      [ bp: Do not expose MCA_CONFIG to userspace yet. ]
    
    Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
    Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
    Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
    Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
    Link: https://lore.kernel.org/r/20241022194158.110073-6-avadhut.naik@amd.com

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4d936ee20e24..4543cf2eb5e8 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -61,6 +61,7 @@
  *  - TCC bit is present in MCx_STATUS.
  */
 #define MCI_CONFIG_MCAX		0x1
+#define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
 #define MCI_IPID_MCATYPE	0xFFFF0000
 #define MCI_IPID_HWID		0xFFF
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 194d9fd47d20..50d74d3bf0f5 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -795,6 +795,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	struct mce *m = (struct mce *)data;
 	struct mce_hw_err *err = to_mce_hw_err(m);
 	unsigned int fam = x86_family(m->cpuid);
+	u32 mca_config_lo = 0, dummy;
 	int ecc;
 
 	if (m->kflags & MCE_HANDLED_CEC)
@@ -814,11 +815,9 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
-		u32 low, high;
-		u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
+		rdmsr_safe(MSR_AMD64_SMCA_MCx_CONFIG(m->bank), &mca_config_lo, &dummy);
 
-		if (!rdmsr_safe(addr, &low, &high) &&
-		    (low & MCI_CONFIG_MCAX))
+		if (mca_config_lo & MCI_CONFIG_MCAX)
 			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
 
 		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
@@ -853,8 +852,15 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
-			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
-				 err->vendor.amd.synd1, err->vendor.amd.synd2);
+			if (mca_config_lo & MCI_CONFIG_FRUTEXT) {
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

