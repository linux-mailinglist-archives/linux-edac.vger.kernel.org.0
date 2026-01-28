Return-Path: <linux-edac+bounces-5682-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCvCBDffeWm50gEAu9opvQ
	(envelope-from <linux-edac+bounces-5682-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Wed, 28 Jan 2026 11:04:39 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED679F32C
	for <lists+linux-edac@lfdr.de>; Wed, 28 Jan 2026 11:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D5C30500C6
	for <lists+linux-edac@lfdr.de>; Wed, 28 Jan 2026 09:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BC134F466;
	Wed, 28 Jan 2026 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KMRIrF+S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HFhEHKSA"
X-Original-To: linux-edac@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E134E75D;
	Wed, 28 Jan 2026 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594165; cv=none; b=AWU9SsV1mE62M+2JCMRozDcBCsbeTi03AvzVBkPhywK/GDuiWFe1lBMmukl2enUimxmH6p6vYskNKYfvt5mA/Gh0K3VK3U/OdEjowkjrB0QG9ARxG5Tjufzlbe7tPCytNuxepcP7ocVa5ytYHYhWmqMJsOxqDdQ+nxaypXliBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594165; c=relaxed/simple;
	bh=+dmA6tjuDu9OMuyzVE/wA3893pFIfNi5oQusiuwyL2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAsVYs+rdlzemkaFyqJ5FRrAbhioyOwNCR3H9vIOZcWX6Jbhx4DRQwcH1xY7ez4MqjV/cZe2FdW57qaAeM/6JlNq9fVp3Q6QcYqeIsb8LGzIAShef2Ni26eA7ZDNA1Wsy4IwKyLiSAPcNl5liTd39DqO6HNIFNmo6qsBbxf8asc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KMRIrF+S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HFhEHKSA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769594161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWVHZIGCYNx3Kr7sCnWB+l/A1gDUo1+sunucnDVnC1c=;
	b=KMRIrF+SKvojWAjYY8KrsVcmzcb+V7/3ETTTLrSA1Wu5CG8TSepe1ZzCPRTqoi0VQ6wkyo
	22QibW5MBWc1/TMwWAdXXwe6uAYMqKB/0Uz8MtCJ4oSCl7N2XN/t/W5XiB1D6oit+mOc4H
	vk2v16GfUYOzBPLzEVsLCZgzal9+8qk/Lp/XXDD11KeFGQOWiK70bXCardoY+Yd2FmaG9l
	9wEumIfRRUPXh51sMlOdCjIgQXHoLL9CtiQuV6aHjdc2bP4sU28CBTRrYw6d1++fBjhm8G
	hptIG1SyYm0qjv2tPSQSgXxnj8WH5x//P2tzwvaXlZmV2qGm352GQoxT9FozJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769594161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWVHZIGCYNx3Kr7sCnWB+l/A1gDUo1+sunucnDVnC1c=;
	b=HFhEHKSAI/WM6TuTRKlUvEqL8k/eBky+TVDDYsuPc33f4B5Gif9lMHfXON6sh7FCgXq2y8
	1+vinG5I8vEAA7Bw==
To: linux-kernel@vger.kernel.org
Cc: "Thomas Gleixner" <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org
Subject: [PATCH v2 10/20] EDAC/altera: Remove IRQF_ONESHOT
Date: Wed, 28 Jan 2026 10:55:30 +0100
Message-ID: <20260128095540.863589-11-bigeasy@linutronix.de>
In-Reply-To: <20260128095540.863589-1-bigeasy@linutronix.de>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5682-lists,linux-edac=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-edac];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email,linutronix.de:dkim,linutronix.de:mid,alien8.de:email,intel.com:email]
X-Rspamd-Queue-Id: 5ED679F32C
X-Rspamd-Action: no action

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.
The flag also disallows force-threading of the primary handler and the
irq-core will warn about this.

Remove IRQF_ONESHOT from irqflags.

Fixes: a29d64a45eed1 ("EDAC, altera: Add IRQ Flags to disable IRQ while han=
dling")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/altera_edac.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 0c5b94e64ea15..4edd2088c2db6 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1563,8 +1563,7 @@ static int altr_portb_setup(struct altr_edac_device_d=
ev *device)
 		goto err_release_group_1;
 	}
 	rc =3D devm_request_irq(&altdev->ddev, altdev->sb_irq,
-			      prv->ecc_irq_handler,
-			      IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+			      prv->ecc_irq_handler, IRQF_TRIGGER_HIGH,
 			      ecc_name, altdev);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_DEVICE, "PortB SBERR IRQ error\n");
@@ -1587,8 +1586,7 @@ static int altr_portb_setup(struct altr_edac_device_d=
ev *device)
 		goto err_release_group_1;
 	}
 	rc =3D devm_request_irq(&altdev->ddev, altdev->db_irq,
-			      prv->ecc_irq_handler,
-			      IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+			      prv->ecc_irq_handler, IRQF_TRIGGER_HIGH,
 			      ecc_name, altdev);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_DEVICE, "PortB DBERR IRQ error\n");
@@ -1970,8 +1968,7 @@ static int altr_edac_a10_device_add(struct altr_arria=
10_edac *edac,
 		goto err_release_group1;
 	}
 	rc =3D devm_request_irq(edac->dev, altdev->sb_irq, prv->ecc_irq_handler,
-			      IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
-			      ecc_name, altdev);
+			      IRQF_TRIGGER_HIGH, ecc_name, altdev);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_DEVICE, "No SBERR IRQ resource\n");
 		goto err_release_group1;
@@ -1993,7 +1990,7 @@ static int altr_edac_a10_device_add(struct altr_arria=
10_edac *edac,
 		goto err_release_group1;
 	}
 	rc =3D devm_request_irq(edac->dev, altdev->db_irq, prv->ecc_irq_handler,
-			      IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+			      IRQF_TRIGGER_HIGH,
 			      ecc_name, altdev);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_DEVICE, "No DBERR IRQ resource\n");
--=20
2.51.0


