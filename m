Return-Path: <linux-edac+bounces-2458-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6E99BE5CB
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 12:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D84A280CA6
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 11:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7787F1DED71;
	Wed,  6 Nov 2024 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="Tz2FZ4yH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF32C1DE3B4
	for <linux-edac@vger.kernel.org>; Wed,  6 Nov 2024 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893278; cv=none; b=do3PNhM5cqfz3EvKxsxVXQxVCU056rU/+tmk6245WYixnbjy+qd3FxV43EDYm+mm9xi+hFF5RAlMyHwJhkEwsr/m7/iGpcBUz9EOak4rPaXl0405ws3Ags2n8lDE/zzzyER7bk0N02iJKE4nZ21gPOKBhgh6aGDhrbF093sxxyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893278; c=relaxed/simple;
	bh=avSNu0jxcOX+JToYoKPOxXqXoAKAFU2u/PiZkiumz/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kw8NYrj6Vip9A8tzcH8aXLB7x+/hEIVwseZm6xDBvbK9gQAxU6J9Bq0J7lE2xJ50P/FDa8nSBRd5hGB4tmSpeTbmnEmwKgDppDnPmAdyBFibpFt+FcJ0g8CBc+hghK25+8LKczl9HCbdfIAuvXu/i/CowckRe+7lA8iuGNZFzto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=Tz2FZ4yH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d41894a32so443211f8f.1
        for <linux-edac@vger.kernel.org>; Wed, 06 Nov 2024 03:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730893275; x=1731498075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2T1FnuxuOLfXTEuPhFAXlYWlJnV3S7rPr9KDCR50D/U=;
        b=Tz2FZ4yHRYG4lmV/Gysq6ZLh8Iv9j3DYs79i1STYg4GKsPcPSIFAY5O9rS0TTxSoh7
         zrRHk906GFjYpKfVGSDQkcP+rANVRugbrNGqs85ISRMqDWtVjpSZlq3P2ooWl+71fQ8V
         KfDNmkU1UcxsGwdDuzHknyiy3l1lyjtft/MUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730893275; x=1731498075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2T1FnuxuOLfXTEuPhFAXlYWlJnV3S7rPr9KDCR50D/U=;
        b=PN4oRoIjz0vMcrNUYTv3vgHUQXnoBUCer8XXxaRHVb6OFUBjuifCMTmk2E8Ik/q5jJ
         7pTQBPgK9LcMPT+t8ahZI8MH+sHmXmRf/zKs9O16I8Ij2pMeoZePPjHN3N9v4aTZPzg4
         ziE6uNwG2QwoxxzBfq/r7MlJqXYUi62AbB9g+0ymb3ntMm9GMO4u23LyHYSaQ2CISfUJ
         iddMh/ZqJWSZhnMMoIgg6cPIjVEd+SnarCCLrjB4EMx+FAMCJ1V6jiqj+56pEl/x8fHQ
         J+JlDyxmxEpMiCjAh/NXwZYCNGqvGLt1q4ecHbANjRHAnUg+vtAGh6HeiIVPYtq5uGJt
         Aljw==
X-Forwarded-Encrypted: i=1; AJvYcCUElMvb6TbXws55pLYqRJpzTEITngLPjGhlyhTck/FH4USl3xRQNyQUbwbzzD74OWeO0U0bOcWln3cW@vger.kernel.org
X-Gm-Message-State: AOJu0YzlGlMlpVe4zAB6WBmarHXKTUJRHmEVTMwV6srsfH0NhegIQr9G
	QPM13mbdVb9giV+ud4NwS0HUNmVumrt0pKw9DZPw14AAlf4hYxxhcPq0hAfTh7U=
X-Google-Smtp-Source: AGHT+IGs7rtq/82Gf4X8l5DLzpbnfcApHai1n4nlgCsS52D3NRA4jUVMSqr7KG3kWQvNyUORpNBznw==
X-Received: by 2002:a5d:588d:0:b0:374:b6e4:16a7 with SMTP id ffacd0b85a97d-381e81ca8d5mr1811747f8f.8.1730893275055;
        Wed, 06 Nov 2024 03:41:15 -0800 (PST)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d3f87sm93796755ad.249.2024.11.06.03.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 03:41:14 -0800 (PST)
From: Orange Kao <orange@aiven.io>
To: tony.luck@intel.com,
	qiuxu.zhuo@intel.com
Cc: bp@alien8.de,
	james.morse@arm.com,
	orange@kaosy.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	rric@kernel.org
Subject: [PATCH 1/3] EDAC/igen6: Initialize edac_op_state according to the configuration data
Date: Wed,  6 Nov 2024 11:35:45 +0000
Message-ID: <20241106114024.941659-2-orange@aiven.io>
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

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Currently, igen6_edac sets edac_op_state to EDAC_OPSTATE_NMI, while the
driver also supports memory errors reported from Machine Check. Initialize
edac_op_state to the correct value according to the configuration data
that the driver probed.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 07dacf8c10be..fa488ba15059 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1350,6 +1350,15 @@ static void unregister_err_handler(void)
 	unregister_nmi_handler(NMI_SERR, IGEN6_NMI_NAME);
 }
 
+static void opstate_set(struct res_config *cfg)
+{
+	/* Set the mode according to the configuration data. */
+	if (cfg->machine_check)
+		edac_op_state = EDAC_OPSTATE_INT;
+	else
+		edac_op_state = EDAC_OPSTATE_NMI;
+}
+
 static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	u64 mchbar;
@@ -1367,6 +1376,8 @@ static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		goto fail;
 
+	opstate_set(res_cfg);
+
 	for (i = 0; i < res_cfg->num_imc; i++) {
 		rc = igen6_register_mci(i, mchbar, pdev);
 		if (rc)
@@ -1450,8 +1461,6 @@ static int __init igen6_init(void)
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
 
-	edac_op_state = EDAC_OPSTATE_NMI;
-
 	rc = pci_register_driver(&igen6_driver);
 	if (rc)
 		return rc;
-- 
2.47.0


