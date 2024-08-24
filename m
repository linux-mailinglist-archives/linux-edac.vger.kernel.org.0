Return-Path: <linux-edac+bounces-1731-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF0F95DDB8
	for <lists+linux-edac@lfdr.de>; Sat, 24 Aug 2024 14:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49D11F22377
	for <lists+linux-edac@lfdr.de>; Sat, 24 Aug 2024 12:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FEA16A395;
	Sat, 24 Aug 2024 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBP1AqNT"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA7C15DBB3;
	Sat, 24 Aug 2024 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724501214; cv=none; b=BPWBYSkPkO/NbLre9SXIQhhfTZZ5tF4SG7FJN5hTG2knyDwKYevjc118WHQGPXE4ENXwLqLwEMMSMmaiKYc7asQSGr2SJtkenfAMMRGaswr4tXV3GNGh4nJJPGSop6M8t310oe8zpuOyicHH/DXGBEFz9Zdq2s7ms7CGCwPUG/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724501214; c=relaxed/simple;
	bh=r43VCUvNDaKp0y3o7Z5fkEs8MRH/MaVYeIrhoY2jENk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTEOIIPQlp3g8oB+Uuel7B+AMrIWvZijG6wPTBo5s1dzZhn5ginWZAM2DjnWk+RYX0NOXv+7/imkiNotBYmA9E10i4i9VhzEhw+YtXPP/cO6BPmFo7H93Lb2brfNIUggOaeLWqVHy4wo3YxSGKsp1rGJ1uzRFYYRXy+LEytCgoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBP1AqNT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-202376301e6so21739625ad.0;
        Sat, 24 Aug 2024 05:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724501212; x=1725106012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YZd6D/gFTHMIgmRUEna4QDfgeX78q/R9BSaRxcnB8c8=;
        b=DBP1AqNTFzvb9BIDn++AXO1JJ3qc8FpPvVIJSpyu24NN0kQmPqPUNIcX1mhKzP9NIY
         rdvbM13uMQqV8614myrYUAC4/ExU43XXa5j3lTY6djHeTVPAGB9IdhV3BlULgcd6Sbq3
         nHbUJNCrW2JaB8bZtzEIchZZRNfe4v0rYOabj5TGUKz3EYlEbMd/CooTNS9kC5Vy87R3
         fn/fjHZnI9um2l3ZIdH0omajnwtuAAL0w7KvLcNFK1QAdIScnlD8s/8V2NNXNJsdc2Z7
         uvUYQSdBdVsd5jxcJoG8trq45f6kxzczizH44Ra0OwKCeEH00E6HAvb8PZvcvZvej1y6
         eLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724501212; x=1725106012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZd6D/gFTHMIgmRUEna4QDfgeX78q/R9BSaRxcnB8c8=;
        b=tRWOpF329YqaAfkEomV2Beawt+qpu2I4jxCNrfWkjlL3+C1uSP2WfOrNi718epXAcs
         ThWcuXEaHBuiNzyHfCRcjQKSGaIm9c0MHI/1mNszPCAVRhP+hsT3bb5mbS2fPEZ8mFJY
         mkcCS8DZUET3nsABJLFT5sjxORp72R9cH3IIwsipbgr+NPoz/Ea8uFVWH6MStxhgOQt/
         F1ZaUli/ewSt3wyggn+s/ZhMHTEz4jFNUGxCr8FZ2v96+sErd6ZLZAkacymV4PXzaOW5
         JhadTcUyXvL37/hmlK7o+SvPkTtrkgwN2jXnpmK2qeZb+toLMW8B4AZeRLO4PFFjW4Hr
         w9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfc2sJZkAOJ/GFeEgGZKxcEhwYGNWZL0cHf6G95gsbjGYUz5r6aa3Yxv46NNK8Fo2hpj7m/f9SCl30hXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWaxgjXOVIRrBbHFE6qQzJHnBJrZNgGm7CX99U3LVCqWCBqaup
	gaYI8wNmKoBjA1UsA+jgcNqXJRNDHXP0vVg+wpsn4uplpBikPlip+qsxSi1W
X-Google-Smtp-Source: AGHT+IEx+fG3jTLsFmXS8a048Fd0T0EMydUzhcKE0pjdvYbFGPBjrpuySvH9TifwArk6pA50odZmtA==
X-Received: by 2002:a17:902:d488:b0:203:a152:7448 with SMTP id d9443c01a7336-203a1527638mr40103375ad.4.1724501211806;
        Sat, 24 Aug 2024 05:06:51 -0700 (PDT)
Received: from tranquility.wa.lan (7hw977nsj3rng0spcmqd.ip6.superloop.au. [2401:d002:e05:b402:51d4:ab24:2f89:d277])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038558089csm41680765ad.87.2024.08.24.05.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 05:06:51 -0700 (PDT)
From: James Ye <jye836@gmail.com>
To: jbaron@akamai.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Ye <jye836@gmail.com>
Subject: [PATCH] EDAC/ie31200: Add Kaby Lake-S dual-core host bridge ID
Date: Sat, 24 Aug 2024 22:06:22 +1000
Message-ID: <20240824120622.46226-1-jye836@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device ID for dual-core Kaby Lake-S processors e.g. i3-7100.

Signed-off-by: James Ye <jye836@gmail.com>
---
 drivers/edac/ie31200_edac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 9ef13570f2e5..4fc16922dc1a 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -19,7 +19,8 @@
  * 0c04: Xeon E3-1200 v3/4th Gen Core Processor DRAM Controller
  * 0c08: Xeon E3-1200 v3 Processor DRAM Controller
  * 1918: Xeon E3-1200 v5 Skylake Host Bridge/DRAM Registers
- * 5918: Xeon E3-1200 Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
+ * 590f: Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
+ * 5918: Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
  * 190f: 6th Gen Core Dual-Core Processor Host Bridge/DRAM Registers
  * 191f: 6th Gen Core Quad-Core Processor Host Bridge/DRAM Registers
  * 3e..: 8th/9th Gen Core Processor Host Bridge/DRAM Registers
@@ -67,7 +68,8 @@
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_8  0x190F
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_9  0x1918
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_10 0x191F
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_11 0x5918
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_11 0x590f
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_12 0x5918
 
 /* Coffee Lake-S */
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK 0x3e00
@@ -88,6 +90,7 @@
 	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_9) ||                        \
 	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_10) ||                       \
 	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_11) ||                       \
+	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_12) ||                       \
 	 (((did) & PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                 \
 	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))
 
@@ -587,6 +590,7 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_9),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_10),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_11),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_12),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_2),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_3),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
-- 
2.46.0


