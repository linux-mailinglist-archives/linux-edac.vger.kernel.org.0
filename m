Return-Path: <linux-edac+bounces-2420-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D8A9BB4DD
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 13:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6EB1C21608
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 12:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C090E1B0F33;
	Mon,  4 Nov 2024 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="JSZMFep2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0556D18C025
	for <linux-edac@vger.kernel.org>; Mon,  4 Nov 2024 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724206; cv=none; b=gD8e1qrLKUmFwzI8qTCFUsdeNvbdSBsY9hiYWTCZNWiR/cQPaFGYO+3V1q+iPBzMi4bKDN0nBt0oVYr8+ifRuM/vRkAbkvDE/tRBEwNTD6AamfkDMRTPIc+hb3F3XlCX8IZYx2CDrnmVpq6vwqCUVzQsUbNAkQo9xOwxWZUGm0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724206; c=relaxed/simple;
	bh=avSNu0jxcOX+JToYoKPOxXqXoAKAFU2u/PiZkiumz/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kspQVOcT+IiHHnxF2wVLTDDrLhxdBijkCNwITc+s8KBXpqHDK/zlbRpxOfOqzUFsp8lXbJbOSrW3Uwkv0PFYrYuHNW0t5mle/0ej0zdHzaxFVBkX2BNvjmVKXL1hhDFg4RYFMP0yorb8PQ31jCOkCiar9fM0FFw7E4XSrX7LSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=JSZMFep2; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso4248484e87.2
        for <linux-edac@vger.kernel.org>; Mon, 04 Nov 2024 04:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730724203; x=1731329003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2T1FnuxuOLfXTEuPhFAXlYWlJnV3S7rPr9KDCR50D/U=;
        b=JSZMFep2+hq9DcSVHC7sstW9ORzuhIYb/WjoZ2cCJ6lrxt6rYifb3rsYg5GkpApBKD
         MQ90KTEbs5TJ56mIECQxnd0PbegVvOibrVfP5LNQeCQvkS6k7sm8T6al34jEzBbiffeD
         263ZDS7JSIOqADj6fbWImvjU8e8B5HhJE7YpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730724203; x=1731329003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2T1FnuxuOLfXTEuPhFAXlYWlJnV3S7rPr9KDCR50D/U=;
        b=o1qtr/hDsOWCCAn0PQ7Uos1XnHQxAdm4/m5xIAaXa6PgKRGODXXGPkdaY2anmOGW2t
         qL4UNk2+UimfSpRSX2CBzBWP8Db2/MypKuTKnUJpqCR6thSkIhhrVYnkKVUHOxQOsGuZ
         WWPKlJ8whpBO54WkXXLIEwbFiXsfFlRSERL8l5or21un3jLPZGDF5avDBwoHjGOSH2Gu
         CqFLeL+UhOdBDwp2JO8RUCeHcngb84ZIrcrpxonA/zan7ppNKBgpbOtU3KLhVJsfitHv
         VRXu6y35+JUfxJm48loHTsXIgMPjpi4beIcyAdhZV7X6f8NcBtI1NklvKEuEUyRZl2Ac
         3mqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1bJLk9DuIx99wxK6qMaCGgRYPxJNI5apQE1Hhd9f1eihxnk9kU+mPXuAZFceJ77Kv/klC/jR9vngX@vger.kernel.org
X-Gm-Message-State: AOJu0YyWHupvV/rDBHzAC4IhTO2IR9lXEPZD4q1dyopi8dju2Jwph7RD
	QrcMkbRuuPnsntTT1XLO8GiOi1KoruzK0S3RYuDQP4BmtpHmc41VdaLWsrclPoA=
X-Google-Smtp-Source: AGHT+IHy1cqxEDldE+jOPeivOL7psrHsxOIdD/UD+h/Dzy5pOzG/4GiogDeZsSMbjYh7bZiqKhM2FQ==
X-Received: by 2002:a05:6512:1089:b0:539:959e:f0e8 with SMTP id 2adb3069b0e04-53d65de8ba0mr5390339e87.21.1730724203018;
        Mon, 04 Nov 2024 04:43:23 -0800 (PST)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057071fasm60567525ad.84.2024.11.04.04.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:43:22 -0800 (PST)
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
Subject: [PATCH 2/3] EDAC/igen6: Initialize edac_op_state according to the configuration data
Date: Mon,  4 Nov 2024 12:40:53 +0000
Message-ID: <20241104124237.124109-3-orange@aiven.io>
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


