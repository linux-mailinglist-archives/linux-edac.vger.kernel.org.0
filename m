Return-Path: <linux-edac+bounces-2162-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 198A19A63B8
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 12:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E511F22EFB
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 10:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE481E6DFE;
	Mon, 21 Oct 2024 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YmbcqTIq"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143221E3776
	for <linux-edac@vger.kernel.org>; Mon, 21 Oct 2024 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506901; cv=none; b=LFKd+ErqyEIK5OrpNeQ0dZfLnxH/G5tVrbK+YFhbHnarLCEG935vZowvFTOWcPU4jV66RSpSI/3yFmQhvmFk14V6NBX3h7oYdE49wZIbiGDxurEpXlnqHQGQ0jE/zl2Mzre70QJYaRzgSdFbkwB8d4SW3VcRFvYbIRVzpeG7kAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506901; c=relaxed/simple;
	bh=65E0ZewdJqwEsvmJz9YxgY3P5L7qxQRB+oE3SPgAYiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VQxSkJ2rHTcnSaSo91qeggvLaU5i+6zlZTNDY1HZBNXhuG79RKvokL2gbKJaCGBM2oTcmFJ/kkjyxM40sYZPT9pVF+qcuXW3GZq9aRtQ9xI/U3t/wkstZlcOlWHw2zMuumAsN6meKwIjC9GePcpGD94YHQZbXWQhmSHkQkrKU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YmbcqTIq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso11549a12.3
        for <linux-edac@vger.kernel.org>; Mon, 21 Oct 2024 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729506896; x=1730111696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NP/Dvav3hJyK2Si+NRH3ijMX51PBbJ+ScnVT/BCS2mk=;
        b=YmbcqTIqUcilL03J4RNe43BnwbDFwTplCq0JLZ3b2acpFfuAzgOb37NYy/R9H1iXhv
         iNe1RPuvEriuPSMQ2TayCGq5TuZZxmFmouyDP1naqwhwwPkvX3Zg12k+dPGxftlmx5hP
         4cxN76wAxeqiE7Obmhu7AZkICVZMdCwRvR1yocwte6A48CLf4WTej1M4k0EYHixiC4OK
         nsc9ziE4gpoEZG45e1CTNPP1cmKCh8vVmBBcNau623N+mspDL27kfN6MCQZb+6nv67IQ
         eqE3qKqBIO1BtVuyKY8cW4gTnXQAgSnvK2KEVObDbje0eULWISKdJHanSc7kpuES9wzY
         otiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729506896; x=1730111696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NP/Dvav3hJyK2Si+NRH3ijMX51PBbJ+ScnVT/BCS2mk=;
        b=auDTN/64xOkzTe8d/ePyI8N7MkTVxtNFzOzr4jgBUXv+N/3sMVpZt2vWn0ZJ+VEyZO
         RS/snBe7922BuDvUUJuEd7W//rxm9EAGSr/HBma/Lv0BFZKPeM8t7DRr2vcmt/KohpmB
         KHioTkPZExjGDi6izjqzRxmJwOPkAvWQ/CkihUTOGhPLpOP2Bm6k+thvL/K62ss7pLUw
         OIguRzs4xsG54ykvEef0TbNCgcZSRytF83U6fZrsg684c0RbGw+IqiY/HPloD2HEaEZq
         TsctaWqIBAa5VWHouhHETdDwgCjsQjbA1/1Zd4e9DGv4E3CIa0+RB5m+7FDIgmHYjusT
         yj1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLnjT9UtK4MEZDSNY7foMEGoz51H0U551vcH6CuHOkZhCc9otQ3J3ipVEF+Op09MKJJd7kmv/lVcFi@vger.kernel.org
X-Gm-Message-State: AOJu0YyG6m3NydW2IUkWWPRInLo9MJvd7InnAU/xekQPNaTVfIICQ+xb
	mPJ8Hz38ydKuT9tSnKGsY8YdCg8eOvZGZmmw+ydHKZf6x4I8WvfF8XK/LccQlik=
X-Google-Smtp-Source: AGHT+IGwXs/qFMGVGb361pl9aOEnuyFuPq1uxXTj6HPbewGwen+pdT0vcm3xa+5KgDjYsQXeClIGHg==
X-Received: by 2002:a17:906:4788:b0:a99:5cd5:5b9c with SMTP id a640c23a62f3a-a9a69baab1cmr989756766b.36.1729506896225;
        Mon, 21 Oct 2024 03:34:56 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91571ea5sm185545766b.160.2024.10.21.03.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:34:55 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org
Subject: [PATCH] edac: Switch back to struct platform_driver::remove()
Date: Mon, 21 Oct 2024 12:34:50 +0200
Message-ID: <20241021103449.402453-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=13983; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=65E0ZewdJqwEsvmJz9YxgY3P5L7qxQRB+oE3SPgAYiQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnFi5J8khCiOKe95de6UkgDVUxVaNwUvg/O9b4m M1g+qCFUZyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZxYuSQAKCRCPgPtYfRL+ TrvZCACzR5GPfFGZJKb1DWJRDIjY2i93nF6xWUvq694jY0X0pOWDxwOCV2SgCF4wtyeChAc7fsy JU7h5omL8uMtnMoYwyX0WhJEvuy7RT6n9c7BgYDf0X2QjOcpBYO53lzw1lX1w8PV3kj2omdOvIr VFF/oNh6yToJ165EXHXPujYADjmpDwye7P73W3/tsYmahMipCtZYYAAaVjGook/GAiImr7NNaix 5uYRgKje+3IWOqbIDN2sJlzjhiMnhY+pwVEdQMVudQY5W1r0HpirhaCnXz2Cyrn9wuZfVOIn1wS aDJy6Dt98MFB4IGHgbyxcHDRUx+XKRd1x/tNqygAJw0iNcIK
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/edac to use .remove(),
with the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

given the simplicity of the individual changes I do this all in a single
patch. I you don't agree, please tell and I will happily split it.

It's based on today's next, feel free to drop changes that result in a
conflict when you come around to apply this. I'll care for the fallout
at a later time then. (Having said that, if you use b4 am -3 and git am
-3, there should be hardly any conflict.)

Note I didn't Cc: all the individual driver maintainers to not trigger
sending limits and spam filters.

Best regards
Uwe

 drivers/edac/altera_edac.c      | 6 +++---
 drivers/edac/armada_xp_edac.c   | 4 ++--
 drivers/edac/aspeed_edac.c      | 2 +-
 drivers/edac/bluefield_edac.c   | 2 +-
 drivers/edac/cell_edac.c        | 2 +-
 drivers/edac/cpc925_edac.c      | 2 +-
 drivers/edac/dmc520_edac.c      | 2 +-
 drivers/edac/highbank_l2_edac.c | 2 +-
 drivers/edac/highbank_mc_edac.c | 2 +-
 drivers/edac/layerscape_edac.c  | 2 +-
 drivers/edac/mpc85xx_edac.c     | 6 +++---
 drivers/edac/npcm_edac.c        | 2 +-
 drivers/edac/octeon_edac-l2c.c  | 2 +-
 drivers/edac/octeon_edac-lmc.c  | 2 +-
 drivers/edac/octeon_edac-pc.c   | 2 +-
 drivers/edac/octeon_edac-pci.c  | 2 +-
 drivers/edac/qcom_edac.c        | 2 +-
 drivers/edac/synopsys_edac.c    | 2 +-
 drivers/edac/ti_edac.c          | 2 +-
 drivers/edac/versal_edac.c      | 2 +-
 drivers/edac/xgene_edac.c       | 2 +-
 drivers/edac/zynqmp_edac.c      | 2 +-
 22 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index fe89f5c4837f..4394918a809a 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -482,7 +482,7 @@ static const struct dev_pm_ops altr_sdram_pm_ops = {
 
 static struct platform_driver altr_sdram_edac_driver = {
 	.probe = altr_sdram_probe,
-	.remove_new = altr_sdram_remove,
+	.remove = altr_sdram_remove,
 	.driver = {
 		.name = "altr_sdram_edac",
 #ifdef CONFIG_PM
@@ -815,8 +815,8 @@ static void altr_edac_device_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver altr_edac_device_driver = {
-	.probe =  altr_edac_device_probe,
-	.remove_new = altr_edac_device_remove,
+	.probe = altr_edac_device_probe,
+	.remove = altr_edac_device_remove,
 	.driver = {
 		.name = "altr_edac_device",
 		.of_match_table = altr_edac_device_of_match,
diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
index 589bc81f1249..d64248fcf4c0 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -364,7 +364,7 @@ static void axp_mc_remove(struct platform_device *pdev)
 
 static struct platform_driver axp_mc_driver = {
 	.probe = axp_mc_probe,
-	.remove_new = axp_mc_remove,
+	.remove = axp_mc_remove,
 	.driver = {
 		.name = "armada_xp_mc_edac",
 		.of_match_table = of_match_ptr(axp_mc_of_match),
@@ -579,7 +579,7 @@ static void aurora_l2_remove(struct platform_device *pdev)
 
 static struct platform_driver aurora_l2_driver = {
 	.probe = aurora_l2_probe,
-	.remove_new = aurora_l2_remove,
+	.remove = aurora_l2_remove,
 	.driver = {
 		.name = "aurora_l2_edac",
 		.of_match_table = of_match_ptr(aurora_l2_of_match),
diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index 157a480eb761..dadb8acbee3d 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -387,7 +387,7 @@ static struct platform_driver aspeed_driver = {
 		.of_match_table = aspeed_of_match
 	},
 	.probe		= aspeed_probe,
-	.remove_new	= aspeed_remove
+	.remove		= aspeed_remove
 };
 module_platform_driver(aspeed_driver);
 
diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index 0e539c107351..b4f2e30317cb 100644
--- a/drivers/edac/bluefield_edac.c
+++ b/drivers/edac/bluefield_edac.c
@@ -344,7 +344,7 @@ static struct platform_driver bluefield_edac_mc_driver = {
 		.acpi_match_table = bluefield_mc_acpi_ids,
 	},
 	.probe = bluefield_edac_mc_probe,
-	.remove_new = bluefield_edac_mc_remove,
+	.remove = bluefield_edac_mc_remove,
 };
 
 module_platform_driver(bluefield_edac_mc_driver);
diff --git a/drivers/edac/cell_edac.c b/drivers/edac/cell_edac.c
index 2000f66fbf5c..c2420e2287ff 100644
--- a/drivers/edac/cell_edac.c
+++ b/drivers/edac/cell_edac.c
@@ -246,7 +246,7 @@ static struct platform_driver cell_edac_driver = {
 		.name	= "cbe-mic",
 	},
 	.probe		= cell_edac_probe,
-	.remove_new	= cell_edac_remove,
+	.remove		= cell_edac_remove,
 };
 
 static int __init cell_edac_init(void)
diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
index eb702bc3aa29..9c9e4369c041 100644
--- a/drivers/edac/cpc925_edac.c
+++ b/drivers/edac/cpc925_edac.c
@@ -1027,7 +1027,7 @@ static void cpc925_remove(struct platform_device *pdev)
 
 static struct platform_driver cpc925_edac_driver = {
 	.probe = cpc925_probe,
-	.remove_new = cpc925_remove,
+	.remove = cpc925_remove,
 	.driver = {
 		   .name = "cpc925_edac",
 	}
diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
index 5e52d31db3b8..64a4d0a07032 100644
--- a/drivers/edac/dmc520_edac.c
+++ b/drivers/edac/dmc520_edac.c
@@ -640,7 +640,7 @@ static struct platform_driver dmc520_edac_driver = {
 	},
 
 	.probe = dmc520_edac_probe,
-	.remove_new = dmc520_edac_remove
+	.remove = dmc520_edac_remove
 };
 
 module_platform_driver(dmc520_edac_driver);
diff --git a/drivers/edac/highbank_l2_edac.c b/drivers/edac/highbank_l2_edac.c
index 282ca6535f8f..24f163ff323f 100644
--- a/drivers/edac/highbank_l2_edac.c
+++ b/drivers/edac/highbank_l2_edac.c
@@ -128,7 +128,7 @@ static void highbank_l2_err_remove(struct platform_device *pdev)
 
 static struct platform_driver highbank_l2_edac_driver = {
 	.probe = highbank_l2_err_probe,
-	.remove_new = highbank_l2_err_remove,
+	.remove = highbank_l2_err_remove,
 	.driver = {
 		.name = "hb_l2_edac",
 		.of_match_table = hb_l2_err_of_match,
diff --git a/drivers/edac/highbank_mc_edac.c b/drivers/edac/highbank_mc_edac.c
index 1c5b888ab11d..a8879d72d064 100644
--- a/drivers/edac/highbank_mc_edac.c
+++ b/drivers/edac/highbank_mc_edac.c
@@ -261,7 +261,7 @@ static void highbank_mc_remove(struct platform_device *pdev)
 
 static struct platform_driver highbank_mc_edac_driver = {
 	.probe = highbank_mc_probe,
-	.remove_new = highbank_mc_remove,
+	.remove = highbank_mc_remove,
 	.driver = {
 		.name = "hb_mc_edac",
 		.of_match_table = hb_ddr_ctrl_of_match,
diff --git a/drivers/edac/layerscape_edac.c b/drivers/edac/layerscape_edac.c
index 0d42c1238908..1d2e17576ded 100644
--- a/drivers/edac/layerscape_edac.c
+++ b/drivers/edac/layerscape_edac.c
@@ -27,7 +27,7 @@ MODULE_DEVICE_TABLE(of, fsl_ddr_mc_err_of_match);
 
 static struct platform_driver fsl_ddr_mc_err_driver = {
 	.probe = fsl_mc_err_probe,
-	.remove_new = fsl_mc_err_remove,
+	.remove = fsl_mc_err_remove,
 	.driver = {
 		.name = "fsl_ddr_mc_err",
 		.of_match_table = fsl_ddr_mc_err_of_match,
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index d0266cbcbeda..a45dc6b35ede 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -323,7 +323,7 @@ static const struct platform_device_id mpc85xx_pci_err_match[] = {
 
 static struct platform_driver mpc85xx_pci_err_driver = {
 	.probe = mpc85xx_pci_err_probe,
-	.remove_new = mpc85xx_pci_err_remove,
+	.remove = mpc85xx_pci_err_remove,
 	.id_table = mpc85xx_pci_err_match,
 	.driver = {
 		.name = "mpc85xx_pci_err",
@@ -627,7 +627,7 @@ MODULE_DEVICE_TABLE(of, mpc85xx_l2_err_of_match);
 
 static struct platform_driver mpc85xx_l2_err_driver = {
 	.probe = mpc85xx_l2_err_probe,
-	.remove_new = mpc85xx_l2_err_remove,
+	.remove = mpc85xx_l2_err_remove,
 	.driver = {
 		.name = "mpc85xx_l2_err",
 		.of_match_table = mpc85xx_l2_err_of_match,
@@ -656,7 +656,7 @@ MODULE_DEVICE_TABLE(of, mpc85xx_mc_err_of_match);
 
 static struct platform_driver mpc85xx_mc_err_driver = {
 	.probe = fsl_mc_err_probe,
-	.remove_new = fsl_mc_err_remove,
+	.remove = fsl_mc_err_remove,
 	.driver = {
 		.name = "mpc85xx_mc_err",
 		.of_match_table = mpc85xx_mc_err_of_match,
diff --git a/drivers/edac/npcm_edac.c b/drivers/edac/npcm_edac.c
index 2e2133b784e9..e60a99eb8cfb 100644
--- a/drivers/edac/npcm_edac.c
+++ b/drivers/edac/npcm_edac.c
@@ -531,7 +531,7 @@ static struct platform_driver npcm_edac_driver = {
 		.of_match_table = npcm_edac_of_match,
 	},
 	.probe = edac_probe,
-	.remove_new = edac_remove,
+	.remove = edac_remove,
 };
 
 module_platform_driver(npcm_edac_driver);
diff --git a/drivers/edac/octeon_edac-l2c.c b/drivers/edac/octeon_edac-l2c.c
index 2adb9c8093f8..e6b1595a3cb5 100644
--- a/drivers/edac/octeon_edac-l2c.c
+++ b/drivers/edac/octeon_edac-l2c.c
@@ -194,7 +194,7 @@ static void octeon_l2c_remove(struct platform_device *pdev)
 
 static struct platform_driver octeon_l2c_driver = {
 	.probe = octeon_l2c_probe,
-	.remove_new = octeon_l2c_remove,
+	.remove = octeon_l2c_remove,
 	.driver = {
 		   .name = "octeon_l2c_edac",
 	}
diff --git a/drivers/edac/octeon_edac-lmc.c b/drivers/edac/octeon_edac-lmc.c
index 4112c2ee34b8..f7176b95b4fe 100644
--- a/drivers/edac/octeon_edac-lmc.c
+++ b/drivers/edac/octeon_edac-lmc.c
@@ -312,7 +312,7 @@ static void octeon_lmc_edac_remove(struct platform_device *pdev)
 
 static struct platform_driver octeon_lmc_edac_driver = {
 	.probe = octeon_lmc_edac_probe,
-	.remove_new = octeon_lmc_edac_remove,
+	.remove = octeon_lmc_edac_remove,
 	.driver = {
 		   .name = "octeon_lmc_edac",
 	}
diff --git a/drivers/edac/octeon_edac-pc.c b/drivers/edac/octeon_edac-pc.c
index d9eeb40d2784..aa1219db0b17 100644
--- a/drivers/edac/octeon_edac-pc.c
+++ b/drivers/edac/octeon_edac-pc.c
@@ -130,7 +130,7 @@ static void co_cache_error_remove(struct platform_device *pdev)
 
 static struct platform_driver co_cache_error_driver = {
 	.probe = co_cache_error_probe,
-	.remove_new = co_cache_error_remove,
+	.remove = co_cache_error_remove,
 	.driver = {
 		   .name = "octeon_pc_edac",
 	}
diff --git a/drivers/edac/octeon_edac-pci.c b/drivers/edac/octeon_edac-pci.c
index 4d368af2c5f0..c4f3bc33a971 100644
--- a/drivers/edac/octeon_edac-pci.c
+++ b/drivers/edac/octeon_edac-pci.c
@@ -97,7 +97,7 @@ static void octeon_pci_remove(struct platform_device *pdev)
 
 static struct platform_driver octeon_pci_driver = {
 	.probe = octeon_pci_probe,
-	.remove_new = octeon_pci_remove,
+	.remove = octeon_pci_remove,
 	.driver = {
 		   .name = "octeon_pci_edac",
 	}
diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index a9a8ba067007..04c42c83a2ba 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -407,7 +407,7 @@ MODULE_DEVICE_TABLE(platform, qcom_llcc_edac_id_table);
 
 static struct platform_driver qcom_llcc_edac_driver = {
 	.probe = qcom_llcc_edac_probe,
-	.remove_new = qcom_llcc_edac_remove,
+	.remove = qcom_llcc_edac_remove,
 	.driver = {
 		.name = "qcom_llcc_edac",
 	},
diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index d7416166fd8a..5ed32a3299c4 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1488,7 +1488,7 @@ static struct platform_driver synps_edac_mc_driver = {
 		   .of_match_table = synps_edac_match,
 		   },
 	.probe = mc_probe,
-	.remove_new = mc_remove,
+	.remove = mc_remove,
 };
 
 module_platform_driver(synps_edac_mc_driver);
diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
index 29723c9592f7..39cc2ef9cac4 100644
--- a/drivers/edac/ti_edac.c
+++ b/drivers/edac/ti_edac.c
@@ -322,7 +322,7 @@ static void ti_edac_remove(struct platform_device *pdev)
 
 static struct platform_driver ti_edac_driver = {
 	.probe = ti_edac_probe,
-	.remove_new = ti_edac_remove,
+	.remove = ti_edac_remove,
 	.driver = {
 		   .name = EDAC_MOD_NAME,
 		   .of_match_table = ti_edac_of_match,
diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index a556d23e8261..5a43b5d43ca2 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -1186,7 +1186,7 @@ static struct platform_driver xilinx_ddr_edac_mc_driver = {
 		.of_match_table = xlnx_edac_match,
 	},
 	.probe = mc_probe,
-	.remove_new = mc_remove,
+	.remove = mc_remove,
 };
 
 module_platform_driver(xilinx_ddr_edac_mc_driver);
diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index fd87f1b2c145..699c7d29d80c 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -1989,7 +1989,7 @@ MODULE_DEVICE_TABLE(of, xgene_edac_of_match);
 
 static struct platform_driver xgene_edac_driver = {
 	.probe = xgene_edac_probe,
-	.remove_new = xgene_edac_remove,
+	.remove = xgene_edac_remove,
 	.driver = {
 		.name = "xgene-edac",
 		.of_match_table = xgene_edac_of_match,
diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
index c9dc78d8c824..cdffc9e4194d 100644
--- a/drivers/edac/zynqmp_edac.c
+++ b/drivers/edac/zynqmp_edac.c
@@ -455,7 +455,7 @@ static struct platform_driver zynqmp_ocm_edac_driver = {
 		   .of_match_table = zynqmp_ocm_edac_match,
 		   },
 	.probe = edac_probe,
-	.remove_new = edac_remove,
+	.remove = edac_remove,
 };
 
 module_platform_driver(zynqmp_ocm_edac_driver);

base-commit: 63b3ff03d91ae8f875fe8747c781a521f78cde17
-- 
2.45.2


