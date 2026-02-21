Return-Path: <linux-edac+bounces-5730-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFWQLg9cmWkMTAMAu9opvQ
	(envelope-from <linux-edac+bounces-5730-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sat, 21 Feb 2026 08:17:35 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E9116C5CA
	for <lists+linux-edac@lfdr.de>; Sat, 21 Feb 2026 08:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FA54301AD05
	for <lists+linux-edac@lfdr.de>; Sat, 21 Feb 2026 07:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D69D342C98;
	Sat, 21 Feb 2026 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdhBG4kI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124AF27FB37
	for <linux-edac@vger.kernel.org>; Sat, 21 Feb 2026 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771658241; cv=none; b=qLvBAGDiD8Jgl9vA7yqCZEYj0wvwmsKznEDQsDtyB1Sh27CR1CP5s0B9XjSxbmM5AaTIzfaI8tEj224DV7tB9Q6VoU2miYZ+kPcsYjgca5tj7wmh4XI6Dj0+h0aGJ1TglcTFgLsmxyWEXKx3E2vNE/JUxAa4XoSAXqJHK8iwe/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771658241; c=relaxed/simple;
	bh=vnvnXNlkp2ND5qedAqYydF6OM9zLN7wJruh92arvpQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=taSAapfVupDcZ30X8R9sCWAlFHa00piV2PWiQVk7Mz2hQfs7KOOTGQuRwJJifbktBe48IqRLJc5gy0dnDLKZUajlE1w1sk7DgPBHaKul/F0uo1s4EAwyqAKyS4iG7zkFy3fgmf/UHEOHs2BeHtzuxumNwcgmBFcaRSmodu45mqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdhBG4kI; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c6e734ba92bso1422869a12.3
        for <linux-edac@vger.kernel.org>; Fri, 20 Feb 2026 23:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771658238; x=1772263038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gKXH8s7b9vKKEwOo/CqqRU+/qpnSAXb0kNTxWvX9bpI=;
        b=UdhBG4kIPIdOCX+mgtLiVxyjVikmZOruFry3Z+agD6fEB8zNRV2CT5/0OAobTGQZ6r
         90FXlDF0vAGKipad7v7qYCR2k+EnEC0KA2s7tjz+AM7ZCXGVpQhBbaxbWlcgRyvhMnmU
         DGjxnl5E47wvr5wYyV7IK15BPl2qXiYcdfhIAvCL3N0qxJQJxfvWoVHNCsHXXcq6hqni
         fi65y5NQ8UUAI0MAYcOOCun83yAB8zO/NtZlsk9ZsQiC6QodgXwJmBilvUuDrPNfFOvH
         Auq06hUfw0iY4DCcrJkS1Q74HXLNEe7VlKeZgal0icLO5Uab+VmlYLRZAcP9zrpz6l+G
         4PoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771658238; x=1772263038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKXH8s7b9vKKEwOo/CqqRU+/qpnSAXb0kNTxWvX9bpI=;
        b=EpjuKO7746Q3RL3LTUqiqtwJZTRQwp07Es2GSb41mq4o7WoLK4Jw5NBUd4ZupEYPkE
         E+4cljY9BDYyId+hiG+pkOaSeDbR9OMUlKCXZK1Xi1En2XKeA7SK9U0tMxeGa0bZsc3k
         vZ0rMa0QjwoyLVn29LYpZEiM6NnYi0YV9Uc9i1KedrRGqcKuwyf5gAqJiE65O7EoRY8d
         j/bZfor47BpFqwdxg8Z+xBQrM8QmPHXf1zlj9f4SyL2kQiIlld3Ei8GmwTUsUUdvR8mO
         n0Mc7l+eByB/AFObSwuqfZiZFzcFg2Fn3e5Dgf+Ob4OjhYdHG4yAgJnGVXjsGyezwndp
         1ASg==
X-Forwarded-Encrypted: i=1; AJvYcCXwj5NfsYI6EsD4ZjbZXVwWSArU7puUkdwZTkLwIlWEiGq9na228yKCVMBHKFeChXjLrPnQEzK3/JNi@vger.kernel.org
X-Gm-Message-State: AOJu0YwryqSuw6fcx9Ntdq5Z3viO/ZbIvl5JGgkp6ahGRGsZYNyG0dPI
	bGkke1WmoYJMjL4UuRAJKWM452lFMdetTvwBHM/qG8vl4YQbJ/tOPBYf
X-Gm-Gg: AZuq6aKmGY5Wkgqaw6tOoZjb1L25F9umVHQFoF/aolsyjkhlU/Yf3DM4SZ6dfo+oEGF
	9RAJnLFZHuhRV+PAsfS1nUjvzg2OJj09Zdxxn05/yZ+NILDe++0bmcm7H0jChxwRhcyNtdCDL66
	sfTqURYY0qGCwVVlOQF2AUcJfrKvvNMWNNGaCZzbMDuvPj5Y8rQo2m69lGWArplIBjCBD/p+gYS
	OlxlTkBpM4lbgvpEElH912zznwlST5cmN7AwbtISr3ul68wFMjYCoJb88iPXNTFw5txCRGRCOI3
	mEyW+496QJIrFd59kE7PtGC6nJ5d3xMvPVisWX8i3f9Ap5pz9W6Y3wsEMEleEMKU6AA2wcBxyCf
	4kZjRjVyvUDlusBbILbiQtvJ6r0/7RkPSv2h56AwPtvewQrqnueiTH0vy+vWvP2+9aFLN2Jra9a
	/biwYdgt/juNZyL2gJ2kDYtNhMofWmJ/kbt2EtDn+RoAgDHV78L+vQJVX+vIbpTWx/WNovrJNZ6
	f65hJlu
X-Received: by 2002:a17:902:da90:b0:2aa:d981:10e3 with SMTP id d9443c01a7336-2ad74567346mr23780345ad.40.1771658238307;
        Fri, 20 Feb 2026 23:17:18 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503d406sm13341145ad.75.2026.02.20.23.17.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Feb 2026 23:17:17 -0800 (PST)
From: Eric-Terminal <ericterminal@gmail.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric-Terminal <ericterminal@gmail.com>
Subject: [PATCH] EDAC/versalnet: Fix resource leaks and NULL derefs in init_versalnet()
Date: Sat, 21 Feb 2026 15:16:43 +0800
Message-ID: <20260221071643.23702-1-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2858; i=ericterminal@gmail.com; h=from:subject; bh=vnvnXNlkp2ND5qedAqYydF6OM9zLN7wJruh92arvpQw=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWTOjL4o+/i80LfsFx5rFT+Gip0Werv8oN3Ght9lx3crN eotinzN2FHKwiDGxSArpshy9/++ublet+Zc5z6cCzOHlQlkCAMXpwBM5OpKhv9RjR/OpE7/8O/C fhfF302POFkdApV9mBpeMBooWczZPkWXkeEqq19J3h+Fn9sYnOb5vJdlsXp6ed/WVRp9U2NmVXA Zp7AAAA==
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[alien8.de,intel.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-5730-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-edac];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25E9116C5CA
X-Rspamd-Action: no action

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

Signed-off-by: Eric-Terminal <ericterminal@gmail.com>
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


