Return-Path: <linux-edac+bounces-2178-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E559AA227
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 14:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B196B1F230FE
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 12:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D3119CC21;
	Tue, 22 Oct 2024 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FS8RM5Tm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EBF19CC0A;
	Tue, 22 Oct 2024 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600383; cv=none; b=dhV/LlZ0AMUR6zqJs63Dtp2lzr31+zx55boMUU8Eb7LAb0bcXkP9qDJaxU9c1KSMZAbGGz2qZ5G33i6kcG6IUg9Tjz+G5kTXvHSIkaC0kkQADl2BnlAEFACUlAAFCO4dWDxq1v0WuI05n9E2hK2J3G5LkKYtYjXPVpVLWm2hSVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600383; c=relaxed/simple;
	bh=kHt3cV2WqLQdIzNs9Ys4unZsTki57cMHnJVN6iEj/v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRIcQbzwI1fKqFDpY/WIJAr0Fg6FuFRNjgkkMM7WfUqtlr3XDCms0Zwt/SdI/txCBjtp/rabU5ugdbcWvKYizC7smnm7us8XwX5pEx9c8t6hGC8d5kZUkwaNOOk3hw3p8nH4GHEU2JwUY5GtYKeHASmBORnRA4NkMvgiavMi9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FS8RM5Tm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9E55840E0263;
	Tue, 22 Oct 2024 12:32:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MNtk12J5kIPF; Tue, 22 Oct 2024 12:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729600374; bh=Z5edvg9DeUaky1j2eJnv4m6KOWF6eAnEWvX5wYAyLdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FS8RM5Tm1L0aw4EouK+utOpJEvMd4aOXkqBzYRp1y+x7XgyOlQQXTE0tGnWGX2gqM
	 ZNbb7OtzIG/xw5D6zbAR5CVxtqmsedLQ1mjPo9Hc92ywvj8zKJ+i6D0j8lzM5XrWAM
	 qIigmvhqGquc94Xp1JbiomBxxoWNaDlX2z86DNfOm/ro+lcy/oBvnrJvYBUljGLrk4
	 VBXtjGdptFuUY5ozh/LHPNHNebNBLEOw0O9m3XBhDc3JQjKmawFdegGC0ujAW+6P1b
	 mH0N9YnUM1jVYs/Po85b8LBy+51Gdqy9XTAe0cG38nND1xpFz86V6kE2S85eQEKebR
	 +Zg5R0vUpwE66lSYIK+9aw2P3nTsOHRiv4ygtcQLNbGP04lBZ2MFdKdESbMOLLAtnb
	 cjzfAW8MVrBUWMPaPf+eQ97JuPgPMCW5mBgyPGRQTiUbV7MdoUYWvRfpGukKZXx4Vc
	 jUULXx3reQS3IyLyoMesssz6zPsAOGGWGucjI38ZdzRW0xPVckGL45I/ZMZwZ8rByU
	 cVfRGyal8LWLtLNAZlUx/d1ck9Z3FAPnVeIQUcrrdO/5u7uHWtcEsqM00UqdlaVWth
	 j0IvwcGU3OWNILW/lZeNT11jO9RoiQt5SKvbullqs82i092zNkNKsvOXWHIhIBaBtO
	 aVEx6vu4sETu9e7oCKdxNRDw=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4937140E0184;
	Tue, 22 Oct 2024 12:32:46 +0000 (UTC)
Date: Tue, 22 Oct 2024 14:32:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Thompson <davthompson@nvidia.com>
Cc: shravankr@nvidia.com, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] EDAC/bluefield: Use Arm SMC for EMI access on
 BlueField-2
Message-ID: <20241022123240.GGZxebaKRONhSThUCC@fat_crate.local>
References: <20241021233013.18405-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021233013.18405-1-davthompson@nvidia.com>

On Mon, Oct 21, 2024 at 07:30:13PM -0400, David Thompson wrote:
>  drivers/edac/bluefield_edac.c | 169 ++++++++++++++++++++++++++++++----
>  1 file changed, 150 insertions(+), 19 deletions(-)

Some trivial simplifications ontop along with moving the struct member
comments above them (not sideways) as requested.

I'll queue it with them ontop unless you see issues.

---
diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index 126efb96deee..739132e5ed8a 100644
--- a/drivers/edac/bluefield_edac.c
+++ b/drivers/edac/bluefield_edac.c
@@ -89,7 +89,7 @@ struct bluefield_edac_priv {
 	/* access to secure regs supported */
 	bool svc_sreg_support;
 	/* SMC table# for secure regs access */
-	u32 sreg_tbl_edac;
+	u32 sreg_tbl;
 };
 
 static u64 smc_call1(u64 smc_op, u64 smc_arg)
@@ -138,15 +138,13 @@ static int secure_writel(void __iomem *addr, u32 data, u32 sreg_tbl)
 
 static int bluefield_edac_readl(struct bluefield_edac_priv *priv, u32 offset, u32 *result)
 {
-	bool sreg_support = priv->svc_sreg_support;
-	u32 sreg_tbl = priv->sreg_tbl_edac;
 	void __iomem *addr;
 	int err = 0;
 
 	addr = priv->emi_base + offset;
 
-	if (sreg_support)
-		err = secure_readl(addr, result, sreg_tbl);
+	if (priv->svc_sreg_support)
+		err = secure_readl(addr, result, priv->sreg_tbl);
 	else
 		*result = readl(addr);
 
@@ -155,15 +153,13 @@ static int bluefield_edac_readl(struct bluefield_edac_priv *priv, u32 offset, u3
 
 static int bluefield_edac_writel(struct bluefield_edac_priv *priv, u32 offset, u32 data)
 {
-	bool sreg_support = priv->svc_sreg_support;
-	u32 sreg_tbl = priv->sreg_tbl_edac;
 	void __iomem *addr;
 	int err = 0;
 
 	addr = priv->emi_base + offset;
 
-	if (sreg_support)
-		err = secure_writel(addr, data, sreg_tbl);
+	if (priv->svc_sreg_support)
+		err = secure_writel(addr, data, priv->sreg_tbl);
 	else
 		writel(data, addr);
 
@@ -393,7 +389,7 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 	 * b) property is present - indirectly access registers via SMC calls
 	 *    (assuming required Silicon Provider service version found)
 	 */
-	if (device_property_read_u32(dev, "sec_reg_block", &priv->sreg_tbl_edac)) {
+	if (device_property_read_u32(dev, "sec_reg_block", &priv->sreg_tbl)) {
 		priv->svc_sreg_support = false;
 	} else {
 		/*

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

