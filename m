Return-Path: <linux-edac+bounces-4365-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1FCB05B24
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jul 2025 15:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F44556553E
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jul 2025 13:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502D32E1C69;
	Tue, 15 Jul 2025 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI8Oi+Fj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7601192D8A;
	Tue, 15 Jul 2025 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585442; cv=none; b=ET8Fu0NMW9sI7VrQlrUDTLdND3L4E+fWuu+tEM+uEyaH2bOEX/pNyMm4xpcrbSnhVU59Yoag++43McJ0wgdyez+/HD7CZpSL0ixHYr0qHnJXZclyDGUPjhFcWVzHt0dtjb4pc5Tkvd4EynI8T1JVSBYR/rV+VJN1+0VDifaIvyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585442; c=relaxed/simple;
	bh=1eesZ8FRGx3yBdLRXxEsKLP7sz2b7ZRsqVIaZRq93Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCd7tAr0pu80MaDuJg8cQqYd4H/cNcePh6gKlkA07pbKPTJVzacahfiMjWtQ0nxlMyrClQlf4tzODcaMKX6RV/e/KEROCuYhU/8n3Pf6pUtgL9/2cJakJRHS/ytq5xtbbfTXR5vcU8jxL6fKlYnWkybvHwDrM2KOYzoWpYXCilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI8Oi+Fj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23649faf69fso44467235ad.0;
        Tue, 15 Jul 2025 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752585440; x=1753190240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RPUohILp+ewieHf18DLvEo/uV8xKyb2IZtbl0JlgMRo=;
        b=XI8Oi+FjK9bwGZegOX14KAiH0vm03C2dfFV4F/wRbkmua98uctnhylm14pofeCZb2+
         JdpPISTDjiWyMepvUMdvL8oV3CaC8etsc3HnYKZMN9DflKOuMiaHZBe0s6fjEqGb0nc3
         3G6bDER62GJDmxCIk+HphK+6uzv9kBZFR/LK45NtPUbcBk0X9cu6GV6vHwhObWOk4Y6V
         JwSNsJoWrE+LcAp8Oh43ljIVR2hoO5GTAE35Ke6eguJv4yDunMx89s26cnwskVZJ0p0w
         6wyOgpQl3yUAfuYAHce7Kpu7d582DMsBE2seOVPe6PU8VBs4dyU5567kantJtRa9WvCR
         H/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585440; x=1753190240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPUohILp+ewieHf18DLvEo/uV8xKyb2IZtbl0JlgMRo=;
        b=D4Xss5brS/0uAWmDwMwFPaQdCfn6UfcSNAFOXphdqHMr1evWWUTiLDfu907Xn+d5HC
         GFYh/qlnZ9/nhGpK2a2Ec5i5oAqkyVmCuQOqRxs1Q2ok0Z4RZ+H00tEdUwiryaPZIgWl
         h4TzxopcZfuBk4w/kzMv4+yh/N6OXlBz8aieZ6sP91fl346J8n1UOWQj6F/jJllHaY+w
         pZC+JRGphng6E7bdNXXc2V9yko7WNoSesLT3o/+AkfzHWRePxArqbi+QypxW8fwj8aqK
         9t05+qAG10hCy0fiTFUP31LMisKLccBPyyyD9avZVBtCjXMV+sne+BW0VaFWFdl3znx4
         2TUg==
X-Forwarded-Encrypted: i=1; AJvYcCUkeaNs1Po3iV6c//6qDJEuBPnFf0vk8oppzuy/9MhDnxcghlfJwPHFLdQo8om8+ZhSpFVMeUlZfHdZ@vger.kernel.org, AJvYcCVDqKw6VcUu+crH3ZyqmTdmYDMRKbgn9YI3V6jWiiYCahx57cDplE4LZLPMXRCNwL6CrlkyCGs43pVgFQZX@vger.kernel.org
X-Gm-Message-State: AOJu0YzwKaEpK3JClrO9643NNvVcLqVHhG/Za5H3+IlBxxz5L5aHACVu
	x5A18EM5sB/wV3vj9GyajFws+3BGtz64Is1yAZ2batL4jYu0/6e3Uyfr00C3/uKt
X-Gm-Gg: ASbGncs6QZXq2dRwJSzJ3WP3CxVIqzPXtC6rhWwDrrkmRaIQ/mF6Brr7/pX2GZOD1C/
	0/68P8RnNMS1jteS5embQInGhw6QzM2/qkavu6vLI47XO1Wpm4ULtVXbWqmiCOrrDU9KapatG/n
	kUeGbIfICFLZUi4ZOiXDqxxAANs4m6XJeiGKCy2QcHJz+duABm6T1lZtj5cUTt9ywyO1/mQlI3y
	JLud7BMV3F+KBcTuvw9zsu/jPK2sTyn/k/yUeo7Xi71wktosvg5vYWH47GmFItDQycFwS6NFwh7
	eOqKH/FIaPp/mRX0aqyc/M/PQ5nJkqWZLpRcrUa2oApsBBU38cPnQ+g4yQns7Z4bCLZgRUnD+gw
	x3T59JbkcnfcV7lqCdJrEbK8s
X-Google-Smtp-Source: AGHT+IHb1NNRiOBodIjXa9IvzFu91s61XeKSSkuBPxxkKT7q3AU55A4W3UF4agdToNiW2HG5x44trg==
X-Received: by 2002:a17:902:dace:b0:23c:7b65:9b08 with SMTP id d9443c01a7336-23dee1aba47mr342084525ad.1.1752585439816;
        Tue, 15 Jul 2025 06:17:19 -0700 (PDT)
Received: from shamiko.dns.podman ([2a09:bac5:398e:16c8::245:d5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7b652sm12730962a91.43.2025.07.15.06.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:17:19 -0700 (PDT)
From: Wang Haoran <haoranwangsec@gmail.com>
To: tony.luck@intel.com,
	bp@alien8.de
Cc: james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Haoran <haoranwangsec@gmail.com>
Subject: [PATCH] EDAC/{skx_common,i10nm}: Use scnprintf() for safer buffer handling
Date: Tue, 15 Jul 2025 21:17:00 +0800
Message-ID: <20250715131700.1092720-1-haoranwangsec@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snprintf() is fragile when its return value
will be used to append additional data to a
buffer. Use scnprintf() instead.

Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
---
 drivers/edac/i10nm_base.c | 18 +++++++++---------
 drivers/edac/skx_common.c |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index a3fca2567752..679d34c097c0 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -343,7 +343,7 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 
 	status_mask = rrl->over_mask | rrl->uc_mask | rrl->v_mask;
 
-	n = snprintf(msg, len, " retry_rd_err_log[");
+	n = scnprintf(msg, len, " retry_rd_err_log[");
 	for (i = 0; i < rrl->set_num; i++) {
 		scrub = (rrl->modes[i] == FRE_SCRUB || rrl->modes[i] == LRE_SCRUB);
 		if (scrub_err != scrub)
@@ -355,9 +355,9 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 			log = read_imc_reg(imc, ch, offset, width);
 
 			if (width == 4)
-				n += snprintf(msg + n, len - n, "%.8llx ", log);
+				n += scnprintf(msg + n, len - n, "%.8llx ", log);
 			else
-				n += snprintf(msg + n, len - n, "%.16llx ", log);
+				n += scnprintf(msg + n, len - n, "%.16llx ", log);
 
 			/* Clear RRL status if RRL in Linux control mode. */
 			if (retry_rd_err_log == 2 && !j && (log & status_mask))
@@ -367,10 +367,10 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 
 	/* Move back one space. */
 	n--;
-	n += snprintf(msg + n, len - n, "]");
+	n += scnprintf(msg + n, len - n, "]");
 
 	if (len - n > 0) {
-		n += snprintf(msg + n, len - n, " correrrcnt[");
+		n += scnprintf(msg + n, len - n, " correrrcnt[");
 		for (i = 0; i < rrl->cecnt_num && len - n > 0; i++) {
 			offset = rrl->cecnt_offsets[i];
 			width = rrl->cecnt_widths[i];
@@ -378,20 +378,20 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 
 			/* CPUs {ICX,SPR} encode two counters per 4-byte CORRERRCNT register. */
 			if (res_cfg->type <= SPR) {
-				n += snprintf(msg + n, len - n, "%.4llx %.4llx ",
+				n += scnprintf(msg + n, len - n, "%.4llx %.4llx ",
 					      corr & 0xffff, corr >> 16);
 			} else {
 			/* CPUs {GNR} encode one counter per CORRERRCNT register. */
 				if (width == 4)
-					n += snprintf(msg + n, len - n, "%.8llx ", corr);
+					n += scnprintf(msg + n, len - n, "%.8llx ", corr);
 				else
-					n += snprintf(msg + n, len - n, "%.16llx ", corr);
+					n += scnprintf(msg + n, len - n, "%.16llx ", corr);
 			}
 		}
 
 		/* Move back one space. */
 		n--;
-		n += snprintf(msg + n, len - n, "]");
+		n += scnprintf(msg + n, len - n, "]");
 	}
 }
 
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index c9ade45c1a99..39c733dbc5b9 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -670,12 +670,12 @@ static void skx_mce_output_error(struct mem_ctl_info *mci,
 	}
 
 	if (res->decoded_by_adxl) {
-		len = snprintf(skx_msg, MSG_SIZE, "%s%s err_code:0x%04x:0x%04x %s",
+		len = scnprintf(skx_msg, MSG_SIZE, "%s%s err_code:0x%04x:0x%04x %s",
 			 overflow ? " OVERFLOW" : "",
 			 (uncorrected_error && recoverable) ? " recoverable" : "",
 			 mscod, errcode, adxl_msg);
 	} else {
-		len = snprintf(skx_msg, MSG_SIZE,
+		len = scnprintf(skx_msg, MSG_SIZE,
 			 "%s%s err_code:0x%04x:0x%04x ProcessorSocketId:0x%x MemoryControllerId:0x%x PhysicalRankId:0x%x Row:0x%x Column:0x%x Bank:0x%x BankGroup:0x%x",
 			 overflow ? " OVERFLOW" : "",
 			 (uncorrected_error && recoverable) ? " recoverable" : "",
-- 
2.43.0


