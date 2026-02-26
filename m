Return-Path: <linux-edac+bounces-5750-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO4FOa0uoGkXgAQAu9opvQ
	(envelope-from <linux-edac+bounces-5750-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 26 Feb 2026 12:29:49 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3131A50BB
	for <lists+linux-edac@lfdr.de>; Thu, 26 Feb 2026 12:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CC79307E58C
	for <lists+linux-edac@lfdr.de>; Thu, 26 Feb 2026 11:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0C136BCCE;
	Thu, 26 Feb 2026 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1xSMuwJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB333644DE
	for <linux-edac@vger.kernel.org>; Thu, 26 Feb 2026 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105364; cv=none; b=DD9isNJv1IXDMRp3NWwLH8hjCVyBhzv+KlfzJjiOwlbsSUqA/ZlmiySLMrzSOs3YlaVfPlLem5p6avbS+2Fj/OsF1IqGoadYADxDnCeB950Y98PP2zBHmyqVOt5JHiKA1m358lm4lvLWn/MrH/ST+puseYqamnotXlmCvkMjlas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105364; c=relaxed/simple;
	bh=DJ1knbSyVdyXH3Oha/SsIHld7JkMG33T8i6sZTYAcuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=os6MAVRHnEnkdGByvkk5juyihk0mU6CQouMLslMMfDRQrxCFpaT61dodtK4/gvXkPu0KYe+xLDabzH9vV9Mm6PK3bIev6tBCLkLwtKNDrPRZ4OPrug7RRNBQ4eNv9MNYKoV0VQWjXdrtv2zDMbji+jGP07miFI2kWqf38s6IZ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1xSMuwJ; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso492292b3a.0
        for <linux-edac@vger.kernel.org>; Thu, 26 Feb 2026 03:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772105362; x=1772710162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuLKbfj7Ral8dBvVs3O5RYWO8Xo5q7dDD99AsNljfd8=;
        b=D1xSMuwJhXvRyDVlcra1zbwnyZfgK/K9lLfIM87AO69ZbzuKBBPjZRXGoXjc6KGn7s
         s2K0uvQ2ho6N/i/0mypsI/F+oFVRHYRr4s9g78MGXldmdo+W+mSYeH+gTSe/WSy6Wvs8
         7j7it1VRHwPGlCT2OOyd1TDc1XEq4N8vSa/5WdbScFINju/iitTbA9RrN1LRkaY2ZKLW
         A2eaXq1R+VzwGZffBYpBX4wlMesTO3wxRtrCtAyCmW0hbvPM/CWM4Kfxaw/DyepV2W1I
         zvEJHAXPvMk/S34nStJtgc6GhEIJFpjmbgL0bdCI7rrpfo/WNfa4bc3TLcdZ2jVSNPiz
         PPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772105362; x=1772710162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UuLKbfj7Ral8dBvVs3O5RYWO8Xo5q7dDD99AsNljfd8=;
        b=HIPKBHNAWFXu7MScYXFzxz7/+wD1LifaqpNNhxNgdhylJwP+Lqm3xaD627dUuyNN3k
         kN+ID5hVptTHdun7KJRLpCC2sewpeEeFCNPpX6P6agCkx3edz01Vs7LVDl1OpJV0w2b/
         WSFM6AHavDPDGmj7a/nqvm0SKO5LANZSjIOE2tz7aOrj0lmd29VsBgGKhSznEYPh4gwL
         nNHDgMHM3Qx8sdk3Iht38k45uGm0cjAm2bZA/2CLVW45a4X5RezSk5zEqYgnevdGKgBJ
         li233R2IWKq21vmyBTihv0QnzU67GQ/j7GSJGjJzqfoC0IcKKc3ZWLhSfZ6DxER+rEWq
         4wKw==
X-Forwarded-Encrypted: i=1; AJvYcCWe+0fWwLqnZBUmCkQvXmSKzY1Z2DI7VaDvF5u52nIFRFOr0Mocg4hS/mOZ/z3ZD2fs+fgnXamoEof9@vger.kernel.org
X-Gm-Message-State: AOJu0YxkLWsdgWH7DKlRkFPh1uC/Mr84iE1ab1ejWO4GTzoIJi7DYidO
	upkMYm9yHCSjs7cc251fypXN9ZgHZ/pv7ox87Gi+sckOarO+r6X5UVhw
X-Gm-Gg: ATEYQzz5Z7txD5fHOa+Y6i3wTyjinRFamm2bcL+0qfGXZlgGLiKFXqSOaNhf+JQIO6a
	H9a3qzdbFbD2dM4LrF7On3Ns4nOJKt1s9wfZZNXLoCeIp2d9N8LvCqesd8y7WwG8HUk1MjvxKtK
	gf2CrjdDxWnKXvXI48HT/Kkk9ki1l93FTn4/46EreOOdaCN4dRxGwJIlGKb79e8j+0Qd5Y1MzTT
	bTUu1iX4Wyfl4viVO1VZeH7NgnhQzEw1Gdw1OC3hva4vv32YPSF80AVGjTijZ6uFQmONGog+o+H
	7hR2YfMexetowaNQaA2v253nhoM7QqC9fewRL9X9TgQ98ORJDWtR8s5qbHs1vRsqj1IQNrY4jI1
	g1tWy225d6z7/weGBGVsn0QI3MwnvECLOId6/+le+q/3xMnq1atv5Wm0jhTW1+4VLZoIIGkIKxm
	riazcGSXavsBLWRU66QNHeh6WXoPNs1v3hT8bPqmZd3c8Vp/XMJ9RAG/+er0sgV4OIBl0yug==
X-Received: by 2002:a05:6a20:d10e:b0:394:f972:43cc with SMTP id adf61e73a8af0-395ad277f52mr3514459637.71.1772105361557;
        Thu, 26 Feb 2026 03:29:21 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa8302absm2193518a12.29.2026.02.26.03.29.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Feb 2026 03:29:21 -0800 (PST)
From: Eric-Terminal <ericterminal@gmail.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v2] EDAC/versalnet: Fix resource leaks and NULL derefs in init_versalnet()
Date: Thu, 26 Feb 2026 19:29:07 +0800
Message-ID: <20260226112907.76971-1-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DS2PR12MB9821250527F466180B16ACE38172A@DS2PR12MB9821.namprd12.prod.outlook.com>
References: <DS2PR12MB9821250527F466180B16ACE38172A@DS2PR12MB9821.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2984; i=ericterminal@gmail.com; h=from:subject; bh=8FgW5uqMUE/4Z07mbkVQn/ocK95+obGpMaQ3908c4J8=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWQu0K5T4js6eW3Vo/s/d6fPnaX3161mAtueaOXcCTsN1 rTmpyoWd5SyMIhxMciKKbLc/b9vbq7XrTnXuQ/nwsxhZQIZwsDFKQATuVPPyLDmkzK7zoMNbAuK dI0tzJ4t6pDy4Z7/8WtIY/WZy7MWnC1jZFg8TzNQvu3m6u8JAfX1S1ftuF28d+79sl9iubfOlk/ 3ms4EAA==
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[alien8.de,intel.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-5750-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-edac];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 4D3131A50BB
X-Rspamd-Action: no action

From: Yufan Chen <ericterminal@gmail.com>

init_versalnet() has several bugs in its error handling. kzalloc() and
kmalloc() return values are used without NULL checks, causing a NULL
pointer dereference when allocation fails. The cleanup loop uses
while (i--) which skips the current failing index, leaking the
resources already allocated for that slot. edac_mc_del_mc() is called
unconditionally during unwind, even for controllers that were never
registered with edac_mc_add_mc(). Also, sprintf() is used instead of
snprintf() on a fixed-size buffer.

Fix by adding NULL checks for dev and name allocations, replacing
while (i--) with for (j = i; j >= 0; j--) to include the failing
index, tracking successful edac_mc_add_mc() calls with a bool array,
and switching to snprintf().

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
v2: Correct Signed-off-by name and add Reviewed-by tag. Fix commit message formatting.

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

