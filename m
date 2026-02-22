Return-Path: <linux-edac+bounces-5732-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD1dHvLcmmktlgMAu9opvQ
	(envelope-from <linux-edac+bounces-5732-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sun, 22 Feb 2026 11:39:46 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F39EA16ED8A
	for <lists+linux-edac@lfdr.de>; Sun, 22 Feb 2026 11:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B79D5300DA5A
	for <lists+linux-edac@lfdr.de>; Sun, 22 Feb 2026 10:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8BD207A20;
	Sun, 22 Feb 2026 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA+dptU2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD581E9B3F
	for <linux-edac@vger.kernel.org>; Sun, 22 Feb 2026 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771756781; cv=none; b=P9ZZa0AOr08f8MZwaTJMDIdmWWLlWWnueu7EN0LC8YMOCNQdyT+5rI/RZBLfoPseWp00TKAurXE5LM7ZO/zpdSHIswMWsLO8XU7tfgD/z7f4zmUfBJPJX7dUQ0aKdvOAd4iIJpYBovqzXaHjp50Q1f7th+AXtyvkkjn5MjRNBzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771756781; c=relaxed/simple;
	bh=W+7Qsa/Lh0jdzmKUHX9cb0JmmlkBMOieCJJPShHBkHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iup31yVKsPdmzYhgm26rk1HUxFEQf3639M0aCSfpl0LCF1ylol9h0DKB5MP6O65JbyCE1fEDRvmX7wfVfrs8JtIvdmqPbEppEl/QiVk5nWg9Qz/lXqtFeCPQuxnFQjj/DK8i1pUw8/nZFP5T3I5vBhlllbzygZs8tyoT6lpjPJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UA+dptU2; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82418b0178cso1963584b3a.1
        for <linux-edac@vger.kernel.org>; Sun, 22 Feb 2026 02:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771756780; x=1772361580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucnEK+kZwADdpx/qPON0X4zBnuyxsdkRSGD1x8ApXJo=;
        b=UA+dptU2GprLL1yrfK5Jcn/CyjPb6eJm195l/kRH0/dlxCgrSBawarLj60PjdzTlOH
         xMX5Cfkk7dPQ3UWeSPbLKvWxFBk0CaEGF4uq+s2g2il+DOXB0Ic/8x1aPZtDtRph4UzN
         u8Mm/6HCGgGm9iKiBTPBSw254ajGR0SiWvG+2o1Z9qJGwxckhYcZ7soxoi0Mz//tUgkj
         tEOqC+oLjz56uc/6BJo8mPmw/Uu1n2/O8w/wEm2pyLTyJCKgBujocF36WUHF3vPC7Q0n
         +ZtboSb3ptxiy/iMA6GuVCFEh2VAHfEr3YK7FBew7pCexpN3iIuTIWuBoNnQ97JAp1lO
         XF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771756780; x=1772361580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ucnEK+kZwADdpx/qPON0X4zBnuyxsdkRSGD1x8ApXJo=;
        b=QnxFAgQpWTIV/AKyjRp0yB+W+t+VVNhdrocTSl2tfekHu5AfsFtWz7oTku45RcG5Ok
         zUpaW9Tx0TIIwVKu90ZTLRCFYG6E27Vg/vewS3j7ZF60MwP3FskS0gEHvYD8hgO8/csh
         RF7pdgyDqzkQAUb0VBp+rXANY3ps7T8XN7mETWfquVNn54yJOPu1BHPo8a/r5eqoTona
         y6sU77sBABZVYR0d0oYauaelrm3SCCSbqGb9g/DqB30KZw3bP1cG2DmaUC6zBwCO48Wq
         LslTX7ctb4YhWfN5lIt+rwEXBFUexgWw3qAbq8W0C9kczRUuaJplQ/hpFZblqzATXXYk
         0+8A==
X-Forwarded-Encrypted: i=1; AJvYcCXi6PEGs1zjzput/uyAdNxJd34r/8h34PbYi1W8V8dz/acDOyum1rm3dhEj5F3lQMmabYpulIxT86+R@vger.kernel.org
X-Gm-Message-State: AOJu0YzqbHWwv0dVhvW8WNiIY7+qDEnuCV5c+MZAdnqNOxpoLMnoegrI
	ghVqb/SoS41mLd5i0DR5Uzj7cMIq+C/la0EW+TNgJvfKq9+Gi74TEh6i
X-Gm-Gg: AZuq6aJxlwgmldUjfv+6nYkcUclc8xNYMVjmIbOau8dbmNUxIfEL61Ul/JKbAUu/WvY
	EEh2KxOdET0VF5Yh1UosPnmQRKlJbVORosY38pl36Hrn7o6uiX6RT5/sPRAxlVOWfOdPddIzvi9
	8hbRLOJeEr/+0bIrL9WxCM4zkTQigKXRxNTtwqzfoFqC3knBCIsjIoWIBQfieaez9JdB7k0qHSA
	4wsu7D0MIdrDAFxMYNEAyAekP2NVj89FdLfuMpdKafqLnwU802Iv2mQbpYDwjup1s/fP42lupSm
	NotD0Fp7r2lwSM6WSg8SaH4E98UTmQp4avQq4uXzAeQ6ShuAj9kVvQvlFhx8D0sgLtzjbGm+U4v
	9LEDPyMJHsQOtNDuApDWhA0L2k1Os/uIAm11XJNPZEHAFLtYki1pwGZVCPcUhOqiXZtg+FnpBHg
	3KNkd0W76sZavBdMXVSobqMVmALc6N8yYQZl2XpUHbUwJn/sXQSUtAgt7dTGRt1+WNrF8mavnsU
	l7cQldc
X-Received: by 2002:a05:6a00:f07:b0:81e:5d52:53b8 with SMTP id d2e1a72fcca58-826daa5e019mr3859299b3a.50.1771756779879;
        Sun, 22 Feb 2026 02:39:39 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd688aa7sm4628979b3a.14.2026.02.22.02.39.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Feb 2026 02:39:39 -0800 (PST)
From: Eric-Terminal <ericterminal@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH] EDAC/versalnet: Fix resource leaks and NULL derefs in init_versalnet()
Date: Sun, 22 Feb 2026 18:39:18 +0800
Message-ID: <20260222103918.90670-1-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <FE3C5380-E82B-4EC8-B1C0-16026CEEF8A2@alien8.de>
References: <FE3C5380-E82B-4EC8-B1C0-16026CEEF8A2@alien8.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2855; i=ericterminal@gmail.com; h=from:subject; bh=MqqYjtzX5p/PyN2Ymk/AdFx5hYQIvxPUZ1JbGwSv05w=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWTOuq3PKLQier7r5P3Wb1wqOF6l6MQc23Rzk4Dp9JqyB Z43FwRN7ihlYRDjYpAVU2S5+3/f3FyvW3Oucx/OhZnDygQyhIGLUwAmIvuHkaG77WXf5a1/MjQd /n+bw35s4UzpKRv+fK8oTtmktSxvz8EzDP/z37RKTb7E6p0ZJZjBGDLrwyf3r7JLTof8WqE8dWG 8FzMLAA==
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amd.com,intel.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-5732-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,linux-edac@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F39EA16ED8A
X-Rspamd-Action: no action

From: Yufan Chen <ericterminal@gmail.com>

init_versalnet() has several bugs in its error handling:

 - kzalloc() and kmalloc() return values are used without NULL checks,
   causing a NULL pointer dereference when allocation fails.

 - The cleanup loop uses while (i--) which skips the current failing
   index, leaking the resources already allocated for that slot.

 - edac_mc_del_mc() is called unconditionally during unwind, even for
   controllers that were never registered with edac_mc_add_mc().

 - sprintf() is used instead of snprintf() on a fixed-size buffer.

Fix by adding NULL checks for dev and name allocations, replacing
while (i--) with for (j = i; j >= 0; j--) to include the failing
index, tracking successful edac_mc_add_mc() calls with a bool array,
and switching to snprintf().

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
 drivers/edac/versalnet_edac.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 1a1092793..128e9cd5f 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -764,11 +764,12 @@ static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 {
 	u32 num_chans, rank, dwidth, config;
 	struct edac_mc_layer layers[2];
+	bool mc_added[NUM_CONTROLLERS] = { };
 	struct mem_ctl_info *mci;
 	struct device *dev;
 	enum dev_type dt;
 	char *name;
-	int rc, i;
+	int rc, i, j;
 
 	for (i = 0; i < NUM_CONTROLLERS; i++) {
 		config = priv->adec[CONF + i * ADEC_NUM];
@@ -813,11 +814,25 @@ static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 		priv->dwidth = dt;
 
 		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+		if (!dev) {
+			rc = -ENOMEM;
+			goto err_alloc;
+		}
+
 		dev->release = versal_edac_release;
 		name = kmalloc(32, GFP_KERNEL);
-		sprintf(name, "versal-net-ddrmc5-edac-%d", i);
+		if (!name) {
+			kfree(dev);
+			rc = -ENOMEM;
+			goto err_alloc;
+		}
+
+		snprintf(name, 32, "versal-net-ddrmc5-edac-%d", i);
 		dev->init_name = name;
 		rc = device_register(dev);
+		kfree(name);
+		if (rc)
+			put_device(dev);
 		if (rc)
 			goto err_alloc;
 
@@ -831,21 +846,25 @@ static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 			edac_printk(KERN_ERR, EDAC_MC, "Failed to register MC%d with EDAC core\n", i);
 			goto err_alloc;
 		}
+
+		mc_added[i] = true;
 	}
 	return 0;
 
 err_alloc:
-	while (i--) {
-		mci = priv->mci[i];
+	for (j = i; j >= 0; j--) {
+		mci = priv->mci[j];
 		if (!mci)
 			continue;
 
 		if (mci->pdev) {
 			device_unregister(mci->pdev);
-			edac_mc_del_mc(mci->pdev);
+			if (mc_added[j])
+				edac_mc_del_mc(mci->pdev);
 		}
 
 		edac_mc_free(mci);
+		priv->mci[j] = NULL;
 	}
 
 	return rc;
-- 
2.47.3


