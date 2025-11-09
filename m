Return-Path: <linux-edac+bounces-5420-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91033C441B0
	for <lists+linux-edac@lfdr.de>; Sun, 09 Nov 2025 16:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0B4F5347210
	for <lists+linux-edac@lfdr.de>; Sun,  9 Nov 2025 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E7F2FF666;
	Sun,  9 Nov 2025 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kNdSXslp"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6613B7A3;
	Sun,  9 Nov 2025 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762703957; cv=none; b=Y72q2VBWkKuYj/YHGMSM7jc/hnpAyppP1PdyGA4ut/t/eU4vO0Y4tsjClefTQbq2vhETUXbfUfdv0bq8brnEzodE87z1VmrP76UL/nwKnHgWs671pu75W2ZDyzaX1S9JQasFkAZNWiRX+0/LBN5rcm6p58/aL0QtlYowNadriQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762703957; c=relaxed/simple;
	bh=Wsps+M+gpBE9HPyCWhJl/eWXuzyP+Sx7rqtiTL9h5/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/2RyAGC8lLoJojt26dehBfIACp0DpFAfTQu1TBgK8i0dELtZx8AF5loN6EpqsUTv2CvkjUFnJnGZCCcvezefyY1mtNkM8AsTOktYzoziMNFizLEq18fH0D6aAqZgOapMF0EowXd+aZVjd9HObss6wZp2pZDZiaHog69IA1DOng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kNdSXslp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 691B840E015B;
	Sun,  9 Nov 2025 15:59:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pYniRIudtC41; Sun,  9 Nov 2025 15:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762703940; bh=Fi2L9tIXjKPF7bzU3m0DT5VHg/8bIUD2kgP9SL/z2mY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNdSXslpwmaEe/e+3bzG8Kjosd8qso3FCGYAFn4aK+G7oMNmJL7IYZM6yVr2ULopH
	 TXQiZjs2xpCFowoQSs2EBAJcQwhgufS3neRQrAcIiCEC6fd5hpg9bAPyvPX67ggGNC
	 hvm7akIXhLzG5lp6Cv+k4Zz5hjU98pjn38y5j0Ieo5ukyCZVxGZnT+m/w+V9fNA/Yo
	 9+lYNwUI/Y+U4/m5XgkpO4ZpNasp0TA6NGln/OcRbYdNaswvOemJ5inS4nJuonDwur
	 oyZtNAJBFXKQWIH+xdZlpNi2SHrW4DY6J2AhyAal9GqAae0r0zlM5btFAho3SwHXTG
	 46r2qCa1TMvPR8P2rSuSP0tL0vJnaMxzTAQ95HBiYkGeUK3ddNSOfvbN6TrmBRXuaQ
	 KBIIdG2FngYrw6zqrKW9TU0wi/uLRpxFA1c+GBtytvDqF48d0hzgcWJJQvhKNBEy6H
	 XDOxw/SCGgGdzDTf5v5PfDcD+g4M6udxdoaA8ch1EEwDlJSkmUSZ7fy1cfZ93g9sDt
	 yK0aJlWsvVgPCD+obBmGtGIUaD9Vszoltp0elXTw294muuhW6NePPSxT4Yp8s5hldJ
	 pYPZvrzmzleSm0+PTvsr791HmFR5WK6v1FctYExSB48wPjLBLtzHgZgAbGUHwIKkvZ
	 wXZy4Z3UPjrhWlzbykfy+TKU=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B833A40E015A;
	Sun,  9 Nov 2025 15:58:52 +0000 (UTC)
Date: Sun, 9 Nov 2025 16:58:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	shubhrajyoti.datta@gmail.com, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v2] EDAC/versalnet: Refactor memory controller
 initialization and cleanup
Message-ID: <20251109155844.GUaRC6NHP2x4oO2Dk0@fat_crate.local>
References: <20251104093932.3838876-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104093932.3838876-1-shubhrajyoti.datta@amd.com>

On Tue, Nov 04, 2025 at 03:09:20PM +0530, Shubhrajyoti Datta wrote:
> Simplify the initialization and cleanup flow for Versal Net DDRMC
> controllers in the EDAC driver.
> 
> Introduce `init_single_versalnet()` for per-controller setup and
>   `init_versalnet()` for looping through NUM_CONTROLLERS, also add
> rollback logic to handle  partial init failures.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
> Changes in v2:
> - Rename init_single_versalnet() to init_mc() for clarity.
> - Rename remove_single_versalnet() to remove_mc() to match naming convention.
> - Simplify error handling in init_versalnet() by replacing goto with a rollback loop.
> - Reduce indentation and consolidate cleanup logic.

Better, here's some more improvements and cleanups ontop. You probably should
apply the diff to better see what I mean:

- do the kzalloc allocations first
- publish the structures only after they've been initialized properly so that
  you don't need to unwind unnecessarily when it fails later
- remove_versalnet() is now trivial

Do run it on the hw and have the code fail at certain places on purpose to
make sure the unwinding happens properly.

HTH.

---

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 01edc7408a5c..dc6108f7cee3 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -70,6 +70,8 @@
 #define XDDR5_BUS_WIDTH_32		1
 #define XDDR5_BUS_WIDTH_16		2
 
+#define MC_NAME_LEN			32
+
 /**
  * struct ecc_error_info - ECC error log information.
  * @burstpos:		Burst position.
@@ -758,7 +760,7 @@ static void versal_edac_release(struct device *dev)
 	kfree(dev);
 }
 
-static void remove_mc(struct mc_priv *priv, int i)
+static void remove_one_mc(struct mc_priv *priv, int i)
 {
 	struct mem_ctl_info *mci;
 
@@ -768,7 +770,7 @@ static void remove_mc(struct mc_priv *priv, int i)
 	edac_mc_free(mci);
 }
 
-static int init_mc(struct mc_priv *priv, struct platform_device *pdev, int i)
+static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i)
 {
 	u32 num_chans, rank, dwidth, config;
 	struct edac_mc_layer layers[2];
@@ -809,41 +811,54 @@ static int init_mc(struct mc_priv *priv, struct platform_device *pdev, int i)
 	layers[1].is_virt_csrow = false;
 
 	rc = -ENOMEM;
-	mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers,
-			    sizeof(struct mc_priv));
-	if (!mci) {
-		edac_printk(KERN_ERR, EDAC_MC, "Failed memory allocation for MC%d\n", i);
+	name = kzalloc(MC_NAME_LEN, GFP_KERNEL);
+	if (!name)
 		return rc;
-	}
-	priv->mci[i] = mci;
-	priv->dwidth = dt;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
-		goto err_mc_free;
-	dev->release = versal_edac_release;
-	name = kmalloc(32, GFP_KERNEL);
+		goto err_name_free;
+
+	mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers, sizeof(struct mc_priv));
+	if (!mci) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed memory allocation for MC%d\n", i);
+		goto err_dev_free;
+	}
+
 	sprintf(name, "versal-net-ddrmc5-edac-%d", i);
+
 	dev->init_name = name;
+	dev->release = versal_edac_release;
+
 	rc = device_register(dev);
 	if (rc)
 		goto err_mc_free;
 
 	mci->pdev = dev;
-
-	platform_set_drvdata(pdev, priv);
-
 	mc_init(mci, dev);
+
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC, "Failed to register MC%d with EDAC core\n", i);
 		goto err_unreg;
 	}
+
+	priv->mci[i] = mci;
+	priv->dwidth = dt;
+
+	platform_set_drvdata(pdev, priv);
+
 	return 0;
+
 err_unreg:
 	device_unregister(mci->pdev);
 err_mc_free:
 	edac_mc_free(mci);
+err_dev_free:
+	kfree(dev);
+err_name_free:
+	kfree(name);
+
 	return rc;
 }
 
@@ -852,10 +867,10 @@ static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 	int rc, i;
 
 	for (i = 0; i < NUM_CONTROLLERS; i++) {
-		rc = init_mc(priv, pdev, i);
+		rc = init_one_mc(priv, pdev, i);
 		if (rc) {
 			while (i--)
-				remove_mc(priv, i);
+				remove_one_mc(priv, i);
 			return rc;
 		}
 	}
@@ -864,14 +879,8 @@ static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 
 static void remove_versalnet(struct mc_priv *priv)
 {
-	struct mem_ctl_info *mci;
-	int i;
-
-	for (i = 0; i < NUM_CONTROLLERS; i++) {
-		device_unregister(priv->mci[i]->pdev);
-		mci = edac_mc_del_mc(priv->mci[i]->pdev);
-		edac_mc_free(mci);
-	}
+	for (int i = 0; i < NUM_CONTROLLERS; i++)
+		remove_one_mc(priv, i);
 }
 
 static int mc_probe(struct platform_device *pdev)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

