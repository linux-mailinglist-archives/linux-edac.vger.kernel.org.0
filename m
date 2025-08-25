Return-Path: <linux-edac+bounces-4678-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5F0B34A3A
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 20:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CDF16B701
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 18:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B8B317704;
	Mon, 25 Aug 2025 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KL+4v/W3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246793176F2;
	Mon, 25 Aug 2025 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146005; cv=none; b=qsPE2cQfB8uL7lUg2Y29sIKEvAjSpIpLfreeaIB0rWWNouP5d43m2+Trstyf53noJe3hS7Hgm7ixZAlWZyLdfyFgLWPp/W/SgKmGWOwlfS24EIGvZr5jIqWvnwKOz1Jis7qPffa8FCsrVrBXdyyaAdH+yhnnnb8kIF++13/EFY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146005; c=relaxed/simple;
	bh=aAwTPXQh1nuJcufA98Iwnj6MWRHsIh4AZ9nakBeRnao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRf+LfYsRYEM3yyI7WaITkW9dcthcen+Aydr5nay0fBGtaM0CHJVzFoAyz9zhkPCutiudxj6MphxoNoHfsSooW62KpNg2VMzYeUvHqtCFFaDDn/YMAmFxp1HiPnopb2z/k8aDTS1Jtp40gcWkTQ++45dOrJl+uvGn4Cr3OylkEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KL+4v/W3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A2BC940E0217;
	Mon, 25 Aug 2025 18:19:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KubZ5abhUqSV; Mon, 25 Aug 2025 18:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756145994; bh=b5wthSsJUK1RqCaVz6R6zihnJQ15f+w0dowfb9yRFp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KL+4v/W32RXUE0kCq3La2X43xpi7U2ujA1zDiFUEeulKlmfRe41co4Ic5u/bn2SF2
	 rfctD840oVnK34nmZgRsEORlmx3Lhyywt23tYxeGWwjlx4NBwapwRQJWZZFqeMLPg5
	 bfaTUvz0UC09uQT8vs5D2px96b2OS/yMePybRN0HsrlW3C8YtxAUIcs6Tp2ZV5sN/m
	 qv+e0+BsJwVgEdSyTCCK/3TTZy/JAPWojUiSl1r0mcUl215Co/AWnmsKDtCuh+nxuy
	 qCUQR0x9oWBt74yqkdGxSzMvHqMdcX3zcaEelSsXhQpb83OIehUffoC2zPuF0QPpo1
	 IQMeE3L7Y/Qv+C31Ws8rhgB5x3soWZubGHVpDorudtdEYljJ/zejg4jfr5XOA114ZG
	 54p0+mNbd4/0cuAZZ8yG+JpXQdpYQuhujPD7CzWRRcCWY7Vnna5LoIyq5wwK9QrpfT
	 eB+DpAaGZilHi7Aa6XxO7JwDEBcDg2ZibwTkydmvn4ozm2EucRX0tiAlt/faAFuki9
	 DO8TDGABCLCQA+cAp6cto9fbSiMAYhqaB/zpvJC+69TkQq5aktpZ4G8WOhq3bZl3Vi
	 Fj8LXX/WSquewk4pL5AsO3XHFOVNDt/3bWKniX1nSVPvhh73vXlZyJehLB5DaT/PMx
	 ec6TLwHAiwUexzC3jqABkV4k=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 39CD640E016C;
	Mon, 25 Aug 2025 18:19:44 +0000 (UTC)
Date: Mon, 25 Aug 2025 20:19:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 03/20] x86/mce/amd: Remove smca_banks_map
Message-ID: <20250825181938.GEaKypOt7t1p8G-YkI@fat_crate.local>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-3-865768a2eef8@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825-wip-mca-updates-v5-3-865768a2eef8@amd.com>

On Mon, Aug 25, 2025 at 05:33:00PM +0000, Yazen Ghannam wrote:
> The MCx_MISC0[BlkPtr] field was used on legacy systems to hold a
> register offset for the next MCx_MISC* register. In this way, an
> implementation-specific number of registers can be discovered at
> runtime.
> 
> The MCAX/SMCA register space simplifies this by always including
> the MCx_MISC[1-4] registers. The MCx_MISC0[BlkPtr] field is used to
> indicate (true/false) whether any MCx_MISC[1-4] registers are present.
> 
> Currently, MCx_MISC0[BlkPtr] is checked early and cached to be used
> during sysfs init later. This is unnecessary as the MCx_MISC0 register
> is read again later anyway.
> 
> Remove the smca_banks_map variable as it is effectively redundant, and
> use a direct register/bit check instead.
> 
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> 
> Notes:
>     Link:
>     https://lore.kernel.org/r/20250624-wip-mca-updates-v4-7-236dd74f645f@amd.com
>     
>     v4->v5:
>     * Keep MCx_MISC0[BlkPtr] check to be compliant with uarch.

I'm not sure I understand what that means...?

Anyway, some more cleanup ontop:

---
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 580682af432d..7e36bc0d0e6c 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -498,17 +498,6 @@ static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
 	wrmsr(MSR_CU_DEF_ERR, low, high);
 }
 
-static u32 smca_get_block_address(unsigned int bank, unsigned int block, u32 low)
-{
-	if (!block)
-		return MSR_AMD64_SMCA_MCx_MISC(bank);
-
-	if (!(low & MASK_BLKPTR_LO))
-		return 0;
-
-	return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
-}
-
 static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 			     unsigned int bank, unsigned int block,
 			     unsigned int cpu)
@@ -518,8 +507,15 @@ static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 	if ((bank >= per_cpu(mce_num_banks, cpu)) || (block >= NR_BLOCKS))
 		return addr;
 
-	if (mce_flags.smca)
-		return smca_get_block_address(bank, block, low);
+	if (mce_flags.smca) {
+		if (!block)
+			return MSR_AMD64_SMCA_MCx_MISC(bank);
+
+		if (!(low & MASK_BLKPTR_LO))
+			return 0;
+
+		return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
+	}
 
 	/* Fall back to method we used for older processors: */
 	switch (block) {


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

