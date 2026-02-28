Return-Path: <linux-edac+bounces-5755-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK2VEfywomkC5AQAu9opvQ
	(envelope-from <linux-edac+bounces-5755-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sat, 28 Feb 2026 10:10:20 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE511C19AA
	for <lists+linux-edac@lfdr.de>; Sat, 28 Feb 2026 10:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 291E53009B02
	for <lists+linux-edac@lfdr.de>; Sat, 28 Feb 2026 09:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCA83EF0DE;
	Sat, 28 Feb 2026 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NrC9+hu3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289223EF0D6;
	Sat, 28 Feb 2026 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772269817; cv=none; b=ZWvdo5Mkk3saxUeptdyZhEqzqx+wlutBwWAqXvxkUG5/ctNG90ZKM1sCnBDbuq8ju0sDuXRRA3nsiX9nsDF7KT/gy7utwOcqod5wGVAdY0SRV0taCUXwJQVK2MDWqzjpZPsaKfEeMktxIMKiEAFFNS/Y2GGuw+wzQL87MqZ07wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772269817; c=relaxed/simple;
	bh=fjVgb8VyLIV8Ku77+NBH3y61pNTKp44JY2Mf1hqSgZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/rGLdECt5M/w1PFiyKdDONyJ4Vqm7T8/B56q4MWUG3q3RejsnbXFE9rJgRCLjgwLh97Mtb2NWzKEVrRQ0GW6mQuex5fQ4bseKtQlLVfltGTnu+NtktC0EJSrcxODvfBfWNjEdfBwAtZ4qzN6z984SCvg7hGB7vWujGFYFecObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NrC9+hu3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 47C9640E0028;
	Sat, 28 Feb 2026 09:10:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dBByi4k2UFYF; Sat, 28 Feb 2026 09:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772269806; bh=fmv6w4uWYFduBvvSx3K5y1Je/l2pIqYdqZUpoX6pMlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrC9+hu3xIaoyQyQCepZsEyMBojGvmC4lkpplvvfLvLQQHMi4TNI0ubLQ1ZX1KzG5
	 NBfhu8xI1SMrpSe8vRjbZTXXMXb3qBWWLM2reSSUtLz2aEwe2G+wFwIboWpD48cKeg
	 g8eVtEUuokhuvC162Dax+fKwcQOADSM/pmBW5wSjqKRGHSTLwTvz0oZF2dCpRNT8mB
	 B5TP4dRi7K+dlSBji1WLAKJno68+QwQJfRWpXbvOUfteQizGMEaUJ/sjeH9n7nAmZa
	 gINIDBmk6xvzIFJxvGFh3ty8aR19q7cwerucO+w92afVdTH5+gmNATShoRHlHkPf78
	 3q0zAN2y0rzeU6ogyBTcEH4uya2NEzpBwpdxaXbM/BjmQ3/48F8Eh30AgYjJqnLH59
	 gDoztKdUA1L+Q8Fs6cobmrN3iio05XFQyOGEern2PtaZRjDOZmUQLTsWnVRXtC0ZkN
	 xAAQHJraUEcII6tO1guR3Fakmduwssmh2HHfjpdcZQc6xaWBl3igktiVIB/NUABoxK
	 WsM4n/C6jP7xYXGTDnEvz2ulUZyMXGxG51NdsPkXdbj4T+CRoyU4iQpVT7+UKzG4jG
	 Qshyg+ZLq5xczX7aBE9HjMJvQgPUDnhMRVqZpQU2krehaZF3mAcsjmBepV83qfB9wW
	 2hP3CGobMkkh1k6lvfnRP2Jw=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8155C40E00DA;
	Sat, 28 Feb 2026 09:09:58 +0000 (UTC)
Date: Sat, 28 Feb 2026 10:09:50 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"shubhrajyoti.datta@gmail.com" <shubhrajyoti.datta@gmail.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v2] EDAC/versalnet: Refactor memory controller
 initialization and cleanup
Message-ID: <20260228090950.GAaaKw3oLZpmWxoa5T@fat_crate.local>
References: <20251104093932.3838876-1-shubhrajyoti.datta@amd.com>
 <20251109155844.GUaRC6NHP2x4oO2Dk0@fat_crate.local>
 <LV5PR12MB9828F14FA3E06001BB0878E78172A@LV5PR12MB9828.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV5PR12MB9828F14FA3E06001BB0878E78172A@LV5PR12MB9828.namprd12.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5755-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,arm.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	DKIM_TRACE(0.00)[alien8.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-edac];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fat_crate.local:mid,alien8.de:email,alien8.de:dkim]
X-Rspamd-Queue-Id: 9DE511C19AA
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 04:50:22PM +0000, Datta, Shubhrajyoti wrote:
> Tested on the hardware.

I don't know what is going on with the communication between you and me.
Somehow there's a misunderstanding.

I asked you:

"just take your patch + my changes and do a one patch, test it and send it out
so that I can apply it"

Which part of that above is not clear?

Tell me so that I can communicate my thoughts better to you in the future.

Anyway, I did it myself again, because, oh well... :-(

Please review and test that properly and lemme know.

I hope at least this request is clear now... lemme know if not.

Thx.

---
From 103298da3e376e471b0165f006c554c93f6aee64 Mon Sep 17 00:00:00 2001
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Date: Tue, 4 Nov 2025 15:09:20 +0530
Subject: [PATCH] EDAC/versalnet: Refactor memory controller initialization and
 cleanup

Simplify the initialization and cleanup flow for Versal Net DDRMC
controllers in the EDAC driver by carving out the single controller init
into a separate function which allows for a much better and more
readable error handling and unwinding.

  [ bp:
	- do the kzalloc allocations first
	- "publish" the structures only after they've been initialized
	  properly so that you don't need to unwind unnecessarily when
	  it fails later
	- remove_versalnet() is now trivial
   ]

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251104093932.3838876-1-shubhrajyoti.datta@amd.com
---
 drivers/edac/versalnet_edac.c | 174 +++++++++++++++++++---------------
 1 file changed, 97 insertions(+), 77 deletions(-)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 2cbc13d9bd00..0b47ed7fed63 100644
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
@@ -760,7 +762,17 @@ static void versal_edac_release(struct device *dev)
 	kfree(dev);
 }
 
-static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
+static void remove_one_mc(struct mc_priv *priv, int i)
+{
+	struct mem_ctl_info *mci;
+
+	mci = priv->mci[i];
+	device_unregister(mci->pdev);
+	edac_mc_del_mc(mci->pdev);
+	edac_mc_free(mci);
+}
+
+static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i)
 {
 	u32 num_chans, rank, dwidth, config;
 	struct edac_mc_layer layers[2];
@@ -768,102 +780,110 @@ static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 	struct device *dev;
 	enum dev_type dt;
 	char *name;
-	int rc, i;
-
-	for (i = 0; i < NUM_CONTROLLERS; i++) {
-		config = priv->adec[CONF + i * ADEC_NUM];
-		num_chans = FIELD_GET(MC5_NUM_CHANS_MASK, config);
-		rank = 1 << FIELD_GET(MC5_RANK_MASK, config);
-		dwidth = FIELD_GET(MC5_BUS_WIDTH_MASK, config);
-
-		switch (dwidth) {
-		case XDDR5_BUS_WIDTH_16:
-			dt = DEV_X16;
-			break;
-		case XDDR5_BUS_WIDTH_32:
-			dt = DEV_X32;
-			break;
-		case XDDR5_BUS_WIDTH_64:
-			dt = DEV_X64;
-			break;
-		default:
-			dt = DEV_UNKNOWN;
-		}
+	int rc;
 
-		if (dt == DEV_UNKNOWN)
-			continue;
+	config = priv->adec[CONF + i * ADEC_NUM];
+	num_chans = FIELD_GET(MC5_NUM_CHANS_MASK, config);
+	rank = 1 << FIELD_GET(MC5_RANK_MASK, config);
+	dwidth = FIELD_GET(MC5_BUS_WIDTH_MASK, config);
+
+	switch (dwidth) {
+	case XDDR5_BUS_WIDTH_16:
+		dt = DEV_X16;
+		break;
+	case XDDR5_BUS_WIDTH_32:
+		dt = DEV_X32;
+		break;
+	case XDDR5_BUS_WIDTH_64:
+		dt = DEV_X64;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
 
-		/* Find the first enabled device and register that one. */
-		layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-		layers[0].size = rank;
-		layers[0].is_virt_csrow = true;
-		layers[1].type = EDAC_MC_LAYER_CHANNEL;
-		layers[1].size = num_chans;
-		layers[1].is_virt_csrow = false;
+	if (dt == DEV_UNKNOWN)
+		return 0;
 
-		rc = -ENOMEM;
-		mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers,
-				    sizeof(struct mc_priv));
-		if (!mci) {
-			edac_printk(KERN_ERR, EDAC_MC, "Failed memory allocation for MC%d\n", i);
-			goto err_alloc;
-		}
+	/* Find the first enabled device and register that one. */
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = rank;
+	layers[0].is_virt_csrow = true;
+	layers[1].type = EDAC_MC_LAYER_CHANNEL;
+	layers[1].size = num_chans;
+	layers[1].is_virt_csrow = false;
+
+	rc = -ENOMEM;
+	name = kzalloc(MC_NAME_LEN, GFP_KERNEL);
+	if (!name)
+		return rc;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		goto err_name_free;
+
+	mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers, sizeof(struct mc_priv));
+	if (!mci) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed memory allocation for MC%d\n", i);
+		goto err_dev_free;
+	}
 
-		priv->mci[i] = mci;
-		priv->dwidth = dt;
+	sprintf(name, "versal-net-ddrmc5-edac-%d", i);
 
-		dev = kzalloc_obj(*dev);
-		dev->release = versal_edac_release;
-		name = kmalloc(32, GFP_KERNEL);
-		sprintf(name, "versal-net-ddrmc5-edac-%d", i);
-		dev->init_name = name;
-		rc = device_register(dev);
-		if (rc)
-			goto err_alloc;
+	dev->init_name = name;
+	dev->release = versal_edac_release;
 
-		mci->pdev = dev;
+	rc = device_register(dev);
+	if (rc)
+		goto err_mc_free;
 
-		platform_set_drvdata(pdev, priv);
+	mci->pdev = dev;
+	mc_init(mci, dev);
 
-		mc_init(mci, dev);
-		rc = edac_mc_add_mc(mci);
-		if (rc) {
-			edac_printk(KERN_ERR, EDAC_MC, "Failed to register MC%d with EDAC core\n", i);
-			goto err_alloc;
-		}
+	rc = edac_mc_add_mc(mci);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed to register MC%d with EDAC core\n", i);
+		goto err_unreg;
 	}
-	return 0;
 
-err_alloc:
-	while (i--) {
-		mci = priv->mci[i];
-		if (!mci)
-			continue;
-
-		if (mci->pdev) {
-			device_unregister(mci->pdev);
-			edac_mc_del_mc(mci->pdev);
-		}
+	priv->mci[i] = mci;
+	priv->dwidth = dt;
 
-		edac_mc_free(mci);
-	}
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+err_unreg:
+	device_unregister(mci->pdev);
+err_mc_free:
+	edac_mc_free(mci);
+err_dev_free:
+	kfree(dev);
+err_name_free:
+	kfree(name);
 
 	return rc;
 }
 
-static void remove_versalnet(struct mc_priv *priv)
+static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 {
-	struct mem_ctl_info *mci;
-	int i;
+	int rc, i;
 
 	for (i = 0; i < NUM_CONTROLLERS; i++) {
-		device_unregister(priv->mci[i]->pdev);
-		mci = edac_mc_del_mc(priv->mci[i]->pdev);
-		if (!mci)
-			return;
+		rc = init_one_mc(priv, pdev, i);
+		if (rc) {
+			while (i--)
+				remove_one_mc(priv, i);
 
-		edac_mc_free(mci);
+			return rc;
+		}
 	}
+	return 0;
+}
+
+static void remove_versalnet(struct mc_priv *priv)
+{
+	for (int i = 0; i < NUM_CONTROLLERS; i++)
+		remove_one_mc(priv, i);
 }
 
 static int mc_probe(struct platform_device *pdev)
-- 
2.51.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

