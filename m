Return-Path: <linux-edac+bounces-2421-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E3A9BB4E0
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 13:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBBDA1F23704
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E851B6D00;
	Mon,  4 Nov 2024 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="ex9uBBY5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04FE1B0F33
	for <linux-edac@vger.kernel.org>; Mon,  4 Nov 2024 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724219; cv=none; b=otQQRNbZ/FLN12DuzAoDN04Yo8gHcNZ0Wza8u9yXHhbm4LVIr7KfzBXHbvF56y1C4kaT6MIpkR1qQaUugn6Hmbchpo6O6vrXiYVg7jaoYiFrT24xuPT4Q0LXA6QiPH/jtrC5jbR11tb2w3NFUQ/ciqkNMesGCfkp4NlSBlVVZGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724219; c=relaxed/simple;
	bh=cKR4mIuxU+pZHomU02/B0JOA4nMGY2eIkkwjNLsRKNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecHxtX4rztw2qiDegfn56J7037dMbBLG9G0bUoj9KenkmUeEN+UIES1Dp9kqY+gAE7IhvQtjp2giusatE7yUnqXROp9llybtCDcceBLUqF/vkG1POkoefa6F2Syt29f/sSOo8v8PCrNlW+0sF/vjUJRcwIYasV8Y7vs8y1WetFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=ex9uBBY5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f58c68c5so7462539e87.3
        for <linux-edac@vger.kernel.org>; Mon, 04 Nov 2024 04:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730724216; x=1731329016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QxRN4fIUmMgqqmSgoGjRQ84Tw++DtIiEKSH0O+MnK4=;
        b=ex9uBBY5BoPmeZEYOkkqs5MmvLHPMHBW4wU5ueDB21fohSdWEnDsubzQe5oKZ4iP1S
         UeaoWNDwqPcucHQ/J1DoRwOZfk4J/1EUJKrAxyG4Vu3cCWvplxIGnwmwizXycFLGc0IC
         Z48WS0SXvsB5RJn4B+/aa0Ij/GIiJjj0djWGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730724216; x=1731329016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QxRN4fIUmMgqqmSgoGjRQ84Tw++DtIiEKSH0O+MnK4=;
        b=BNfNW+dZwPmc173B2C9A2I3QCscuq011IkyLjS6YukPlBnRwfVJvZjg87mwZ+lmBSc
         CRJs3FUd4ZfVGTKlWvZ9tRSZWmqSKLHJBkb+Mu7KLISc8G5dztqDXs0YB3Er55UGt7cN
         6h5pfURrqreLVZ2MBqX/KmtiDWptlWY2W8tc84yrAx9oSrmbseduBRkmmeB2x3dUpXCe
         2s96UjuSt/zhld2+fYtiFs7FWU5xonemnAi7Tr8RgJ1frv786vbal4uTKS7RZ9Te6SQD
         NqKjX4rMkAth18AJzpaNLk2XSfYKPvirPbw1YODsZZFkTF+8xf67vvRNFUnjaB+VuXcE
         sUqg==
X-Forwarded-Encrypted: i=1; AJvYcCWzaevyXP4u8sn78Chw/uDfV9fDflG9cB942T9hKe+nT0v8J9jWBchksbM4Bmwn9Y9hx5zNBfvAGQez@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYTJ35PaLW8oyu61pcPYPETfDQqIOJyJKGW4OK7QMW9tqASj5
	GE4RmMShfST+URqmvwvFOvlVBze+obJQcXtPVcn+awqWCCBSzDwybw6W970+VWE=
X-Google-Smtp-Source: AGHT+IGgBMF58yJeGdFQky+NLdR4fiA6k5ZEPcqTxWYN7oXWvE3Y7NIIuc+Tgxb0I33E3BFKHU/hWQ==
X-Received: by 2002:a05:6512:2350:b0:53b:7ecc:5ddf with SMTP id 2adb3069b0e04-53d65df1a08mr7897714e87.26.1730724215737;
        Mon, 04 Nov 2024 04:43:35 -0800 (PST)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057071fasm60567525ad.84.2024.11.04.04.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:43:35 -0800 (PST)
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
Subject: [PATCH 3/3] EDAC/igen6: Add polling support
Date: Mon,  4 Nov 2024 12:40:54 +0000
Message-ID: <20241104124237.124109-4-orange@aiven.io>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104124237.124109-1-orange@aiven.io>
References: <20241104124237.124109-1-orange@aiven.io>
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
 drivers/edac/igen6_edac.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index fa488ba15059..eb783c6b77f1 100644
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
@@ -1352,6 +1368,10 @@ static void unregister_err_handler(void)
 
 static void opstate_set(struct res_config *cfg)
 {
+	/* Only the polling mode can be set via the module parameter. */
+	if (edac_op_state == EDAC_OPSTATE_POLL)
+		return;
+
 	/* Set the mode according to the configuration data. */
 	if (cfg->machine_check)
 		edac_op_state = EDAC_OPSTATE_INT;
@@ -1483,3 +1503,6 @@ module_exit(igen6_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Qiuxu Zhuo");
 MODULE_DESCRIPTION("MC Driver for Intel client SoC using In-Band ECC");
+
+module_param(edac_op_state, int, 0444);
+MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=Poll, Others or default=Auto detect");
-- 
2.47.0


