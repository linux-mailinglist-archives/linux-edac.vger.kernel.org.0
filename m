Return-Path: <linux-edac+bounces-2459-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DC79BE5CE
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 12:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496CAB244E7
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 11:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058DB1DED74;
	Wed,  6 Nov 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="cYLRzsPs"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FCB1DED6F
	for <linux-edac@vger.kernel.org>; Wed,  6 Nov 2024 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893294; cv=none; b=Tim+wDpsWb3bv9E0npHbjW0lV6fDK6qWtX4Jr9h0tsGS1vbS+3l/a1AjjDwYkl2dvz2M6Hjl9ROdrkTBEoOnPSH7Yo1qoGLPaP0qCzPBUa4e0rvIp8For3IdYPOWW8lnIlcm7ruEJTQ8BM1GlKwEwoXTtkmKwadKog7EuuM9mtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893294; c=relaxed/simple;
	bh=apl7e3mJoFn2XbWQpbe8pkRROPdUrvxhPgFBzUrah94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgWgIag1WFparcyk5QfUbO8UvC8E8MilhI8ZWBoba4CAnHaFJR+wPVkHPymQebreW22jNKw3pUdY1pf3B6P7cG6bdH/6vYUbRsIPTx1GdXS3NdrrGWzUhNRbwx3XhfjKTXVQwIDD3E8FahM5bMdmBoMEpBL9jQowrPmRlcOnjxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=cYLRzsPs; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539fe76e802so7619775e87.1
        for <linux-edac@vger.kernel.org>; Wed, 06 Nov 2024 03:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730893291; x=1731498091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlN7JzcdEbavKyAODal4cf94DP35W34jit6g8RCrNoE=;
        b=cYLRzsPsXW75lEl3wtVLFvPNfhpzXtKnO/Mgr+Ydlb3mRZfNCl7Duk30lLE1lVuO/k
         pW7tYJojDIX3l8q0FqFSyN4fhKNS25pBhzyLpNDdcEgoYMuNbG3fdhhA6XtBdE/3s3xw
         hJ76Easc1lmXtNxwa/9FV7G9nkgbrakABYuVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730893291; x=1731498091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlN7JzcdEbavKyAODal4cf94DP35W34jit6g8RCrNoE=;
        b=ffayoeOVvCQ28QSUTIhMF6JQ3B6oL2qxU+UTzcCmZL85s+X3NOLMhMbhxHtVfPkUUF
         51iUCLm2q27ef+oImg1AuZN7S1nsxeglyI8Jllkeg/r5MY6C1LQu/j41PuZJ1KM0YmkR
         q1fFDNs/vF4jGMmEAWfT6lvsDnFR0NcHiFk6+wI74eRk7mrzFJe6hiwsD9tdU5Z/41DY
         QzRk9o91DVSD61cqcBaRWjYlCXQqyZa/DBAEjzsSzpabz30uO+OuaxIR5wI3BEWH/4VW
         yEIiRGFqxqtlQjANXRdl7EbtxQfXYQFsyP5q5CZHsqkxeA4t4tv7wUs8j/jXUuf6S0Mg
         li/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjEx06AVWGk4ss9O9FpV3kwJWT7v8BGjT6rtM+aY21Idup2F9EtHND5wtTuduYQRDH64HcSvJH+818@vger.kernel.org
X-Gm-Message-State: AOJu0YxIVyMFvaX8X8nOMg53Db+sL7oJhyNgq+u82HAv0CI14ADcUUGC
	abKLn7BXTAeeImouSXl6z8po2vwEg2Dq27te7NO979PKz967M4K8vSK1N04JcJ0=
X-Google-Smtp-Source: AGHT+IE5w1XpLWuVJXxnO8FGFsIqJic4Uxz8A2R8dhYAwHn/+iZlhlvJaC749E3qkfkw1T8G4ufSDg==
X-Received: by 2002:a05:6512:401a:b0:536:a4e1:5fa2 with SMTP id 2adb3069b0e04-53d65df2818mr10182825e87.26.1730893290939;
        Wed, 06 Nov 2024 03:41:30 -0800 (PST)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d3f87sm93796755ad.249.2024.11.06.03.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 03:41:30 -0800 (PST)
From: Orange Kao <orange@aiven.io>
To: tony.luck@intel.com,
	qiuxu.zhuo@intel.com
Cc: bp@alien8.de,
	james.morse@arm.com,
	orange@kaosy.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	rric@kernel.org,
	Orange Kao <orange@aiven.io>
Subject: [PATCH 2/3] EDAC/igen6: Add polling support
Date: Wed,  6 Nov 2024 11:35:46 +0000
Message-ID: <20241106114024.941659-3-orange@aiven.io>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106114024.941659-1-orange@aiven.io>
References: <20241106114024.941659-1-orange@aiven.io>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PCs with Intel N100 (with PCI device 8086:461c, DID_ADL_N_SKU4)
experienced issues with error interrupts not working, even with the
following configuration in the BIOS.

    In-Band ECC Support: Enabled
    In-Band ECC Operation Mode: 2 (make all requests protected and
                                   ignore range checks)
    IBECC Error Injection Control: Inject Correctable Error on insertion
                                   counter
    Error Injection Insertion Count: 251658240 (0xf000000)

Add polling mode support for these machines to ensure that memory error
events are handled.

Signed-off-by: Orange Kao <orange@aiven.io>
---
 drivers/edac/igen6_edac.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index fa488ba15059..dd62aa1ea9c3 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1170,6 +1170,20 @@ static int igen6_pci_setup(struct pci_dev *pdev, u64 *mchbar)
 	return -ENODEV;
 }
 
+static void igen6_check(struct mem_ctl_info *mci)
+{
+	struct igen6_imc *imc = mci->pvt_info;
+	u64 ecclog;
+
+	/* errsts_clear() isn't NMI-safe. Delay it in the IRQ context */
+	ecclog = ecclog_read_and_clear(imc);
+	if (!ecclog)
+		return;
+
+	if (!ecclog_gen_pool_add(imc->mc, ecclog))
+		irq_work_queue(&ecclog_irq_work);
+}
+
 static int igen6_register_mci(int mc, u64 mchbar, struct pci_dev *pdev)
 {
 	struct edac_mc_layer layers[2];
@@ -1211,6 +1225,8 @@ static int igen6_register_mci(int mc, u64 mchbar, struct pci_dev *pdev)
 	mci->edac_cap = EDAC_FLAG_SECDED;
 	mci->mod_name = EDAC_MOD_STR;
 	mci->dev_name = pci_name(pdev);
+	if (edac_op_state == EDAC_OPSTATE_POLL)
+		mci->edac_check = igen6_check;
 	mci->pvt_info = &igen6_pvt->imc[mc];
 
 	imc = mci->pvt_info;
@@ -1350,8 +1366,18 @@ static void unregister_err_handler(void)
 	unregister_nmi_handler(NMI_SERR, IGEN6_NMI_NAME);
 }
 
-static void opstate_set(struct res_config *cfg)
+static void opstate_set(struct res_config *cfg, const struct pci_device_id *ent)
 {
+	/*
+	 * Quirk: Certain SoCs' error reporting interrupts don't work.
+	 *        Force polling mode for them to ensure that memory error
+	 *        events can be handled.
+	 */
+	if (ent->device == DID_ADL_N_SKU4) {
+		edac_op_state = EDAC_OPSTATE_POLL;
+		return;
+	}
+
 	/* Set the mode according to the configuration data. */
 	if (cfg->machine_check)
 		edac_op_state = EDAC_OPSTATE_INT;
@@ -1376,7 +1402,7 @@ static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		goto fail;
 
-	opstate_set(res_cfg);
+	opstate_set(res_cfg, ent);
 
 	for (i = 0; i < res_cfg->num_imc; i++) {
 		rc = igen6_register_mci(i, mchbar, pdev);
-- 
2.47.0


