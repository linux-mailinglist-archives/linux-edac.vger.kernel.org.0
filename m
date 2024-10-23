Return-Path: <linux-edac+bounces-2202-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A77889AC27B
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 10:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 351DDB22B59
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 08:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F88170A2E;
	Wed, 23 Oct 2024 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD42hZsk"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A915B551;
	Wed, 23 Oct 2024 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673989; cv=none; b=eeoxObP0Dkj234ylhKtdSCdMReoJAbsYjDMtwIsdF0EtQ2IvxLpYUotQlUWT2rUgYCoHaBiFFD37AUGT/U3Ejjzm75QEqJEOLPIvefdoglwlBGANJWv6anFHQ6zcCEHi9gRHLpVCbUfHvvFBIybpW2OCYuqDfSxg1TCU2oR00RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673989; c=relaxed/simple;
	bh=z/UnCm00sQYYejFTd7Li58E5oX/YxjQixYcLoNcfaDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tjFHeiMYN97Ceoj7FCK9VW2AGbYpQVo3XvzXa4kJZYWjv3Ib5DEKtQRyQlrnJHRHG/cpvZp++yj1ND3sQvIY5NURyK1qE7oiADh54WAyoAiH+Dt+uoE7OnG04tJ4NaU8UlsnTlkZvWMqjhghCQwpKsZRFijD/7pi2PODm+bQhtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bD42hZsk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so4475496f8f.3;
        Wed, 23 Oct 2024 01:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729673986; x=1730278786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fz6ovL9+aadxdXmjVdlymUjj7eBeEayfscSFgOS2SI0=;
        b=bD42hZskpxUT36IEy5BtMqiPSoRpiRRRKlsRFy6K5y8g6In8yCTNkBOclcHwT0E4IV
         rVAURmAmwI+pUUpnS/H2/xhTkzFyBTG9bpgF+sJbsPL/NI/nuthO6vPU0FTxzPVnfChk
         foeSfhkxYILjNF2gC3xWgDR6UmW7dr8xPfAIhVPchzlCKadkn4h3wTdbmpgEThlLfylA
         I1XlOtIBNxVm9OSeEROTtCkbSVx6AinrBoPpciEVI5I+LGf263sa3Y7jp99w8rinZxA3
         YtQt9pwpnfPFiw9I5/s9MON+paqvw9HIYn2Iyrgoba1BWeLVgmr403OM32zLqRWL7GPs
         b8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729673986; x=1730278786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fz6ovL9+aadxdXmjVdlymUjj7eBeEayfscSFgOS2SI0=;
        b=ivxvEEYg6ff6kkAhAXGQAEYLtWFCjXreHtuRg/TtlZniowF7bc3t7j4NBUIQVc0s1p
         TERGZ0ZVR+TsBQMe5TvFemaw6VrDCpKHXI59St2VwJMDOzPIUstX4W/Se81PD9Cc0yi8
         KHJshVBOhu/BCJ7T3Tf/KAzViziQvYzjxWBBrrslsIQ3SW1IINWMz6vO0AuDYSHVQLcW
         uN340L6afSrTKoQLozOJyyfpbTO0R4zclfJiGXMu8sguNh+/ua70PxxdCz7yn8zMGwQd
         WrBqHfSHZdzvE24hSCUbu5pc7z1V3maZ9eaVaRwIZXHwS1JuSslS7scKxyHLHnWaIRN7
         2fJA==
X-Forwarded-Encrypted: i=1; AJvYcCUbV4KlTd4KP+lTdfMWMJpuW8il93pA7Ayl/7h2HFjmFwY1WULaBBSnrDNooqJSDIyJSG7feFdx8Zoe@vger.kernel.org, AJvYcCWLlRwIy8Ww79fvXR85ngj2s+8THlvRsn16nI1AE+h8PN9qiPllfo+JSOWqGcETyGrTDNWx1t07kU5VmOVN@vger.kernel.org
X-Gm-Message-State: AOJu0YzhoCMjouBxkz60JWjn/Buw0ovE8iYYr+BJYxbyqjcMakLatwB5
	VMVU653IfjSbqWrAf3ocN8fKfQerhcjCuGD+btkVItbu1xYY26WF
X-Google-Smtp-Source: AGHT+IHRfBDFt7Qayq7axijtnZYferW2DmTAPbqrRlGXGjubJy6WUUwjyf3bsP2HOLIw1QfYRVkYnA==
X-Received: by 2002:adf:e2cd:0:b0:37d:633a:b361 with SMTP id ffacd0b85a97d-37efcf92befmr1326458f8f.51.1729673985977;
        Wed, 23 Oct 2024 01:59:45 -0700 (PDT)
Received: from localhost ([194.120.133.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a584f7sm8412521f8f.53.2024.10.23.01.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:59:45 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Shravan Kumar Ramani <shravankr@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] EDAC/bluefield: Fix spelling mistake "syndrom" -> "syndrome"
Date: Wed, 23 Oct 2024 09:59:45 +0100
Message-Id: <20241023085945.1391366-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are a couple of variables and a edac_mc_handle_error message
that contain spelling mistakes. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/edac/bluefield_edac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index 739132e5ed8a..82586e90cacf 100644
--- a/drivers/edac/bluefield_edac.c
+++ b/drivers/edac/bluefield_edac.c
@@ -176,7 +176,7 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 {
 	struct bluefield_edac_priv *priv = mci->pvt_info;
 	u32 dram_additional_info, err_prank, edea0, edea1;
-	u32 ecc_latch_select, dram_syndrom, serr, derr, syndrom;
+	u32 ecc_latch_select, dram_syndrome, serr, derr, syndrome;
 	enum hw_event_mc_err_type ecc_type;
 	u64 ecc_dimm_addr;
 	int ecc_dimm, err;
@@ -198,13 +198,13 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 	 * same type as the one asked to report. If not, just report the
 	 * error without the detailed information.
 	 */
-	err = bluefield_edac_readl(priv, MLXBF_SYNDROM, &dram_syndrom);
+	err = bluefield_edac_readl(priv, MLXBF_SYNDROM, &dram_syndrome);
 	if (err)
-		dev_err(priv->dev, "DRAM syndrom read failed.\n");
+		dev_err(priv->dev, "DRAM syndrome read failed.\n");
 
-	serr = FIELD_GET(MLXBF_SYNDROM__SERR, dram_syndrom);
-	derr = FIELD_GET(MLXBF_SYNDROM__DERR, dram_syndrom);
-	syndrom = FIELD_GET(MLXBF_SYNDROM__SYN, dram_syndrom);
+	serr = FIELD_GET(MLXBF_SYNDROM__SERR, dram_syndrome);
+	derr = FIELD_GET(MLXBF_SYNDROM__DERR, dram_syndrome);
+	syndrome = FIELD_GET(MLXBF_SYNDROM__SYN, dram_syndrome);
 
 	if ((is_single_ecc && !serr) || (!is_single_ecc && !derr)) {
 		edac_mc_handle_error(ecc_type, mci, error_cnt, 0, 0, 0,
@@ -233,7 +233,7 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 	edac_mc_handle_error(ecc_type, mci, error_cnt,
 			     PFN_DOWN(ecc_dimm_addr),
 			     offset_in_page(ecc_dimm_addr),
-			     syndrom, ecc_dimm, 0, 0, mci->ctl_name, "");
+			     syndrome, ecc_dimm, 0, 0, mci->ctl_name, "");
 }
 
 static void bluefield_edac_check(struct mem_ctl_info *mci)
-- 
2.39.5


