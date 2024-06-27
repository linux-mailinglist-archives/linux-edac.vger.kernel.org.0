Return-Path: <linux-edac+bounces-1416-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA65491AE32
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 19:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E277B23615
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 17:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05241A2577;
	Thu, 27 Jun 2024 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FObr6e/B"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23AA1A254A;
	Thu, 27 Jun 2024 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509610; cv=none; b=CutZuTCc5SCKCc9DFU6F+M0+GSzZHTeF8Hu85fIEqOuEBdSSyQJ0Uw5Xi1pjt1yGdWAFDe/2ZJku9I3QqRKSQvCK+wuLt5Xn48DzkaCS0G8ZxljHfq/aOiIvIY7kGXl8H4uA9rZySbC3SEmA4fIb7/z3lYCjKrmdV+ztu4Rx6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509610; c=relaxed/simple;
	bh=mt9UynXI2+qgvIzJYiFKClBsAzOssYbzQ3BkuR7uDn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LH5qKVIeTFiPnmsOJZ1YcIw0fQ5xZd0fyuMa3irWkwhlDT3W1xHyStFDIPwrXOn5CHQztN8jSIfetwSixJHWtDFmXrQ4Jyr36zVZWi9wsaVd9M1xolTi1QwMl1lBpS0P/ZNfp/atJwXazIjGegRy08uSLGEVVKxoGyiOSrSfMjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FObr6e/B; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ee4ae13aabso10271011fa.2;
        Thu, 27 Jun 2024 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509607; x=1720114407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nAXuUIOjmGqCty40Smyp4CQdr7UcxvXuJwOvkK+QNc=;
        b=FObr6e/BsBxPhwxrkMj3B5n80EKWqcwxSqVlpBVjNhzhOgYK7qvwy8K5r31o6L92QB
         JbzxngIP0NYbENw4PcOy2/+EAg+QqLEWcsnN3vnUGi+25IHbt+w2UEybJIHuuExAweB4
         nHzxo2CsrzOgL5egiGwcXDlZcNJ5t+lOVVRStagWqVE/4jefcur7Uas13lzvM26t4KCr
         nzDuCmqarNjdyGH08EvH8Z6jAh4xWcO9if94nbqBNUq1HT/dCtcsO5sz5L/XDIW4ZrXw
         yZoPt24EThPPhNtVM1H3sioYLpj3ePUdsUwr2yPVne7ghW60ZRUXtw3yDyIgXGEYAEAu
         Z7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509607; x=1720114407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nAXuUIOjmGqCty40Smyp4CQdr7UcxvXuJwOvkK+QNc=;
        b=rslUB6UGCV//oQQzcSdnB+RTlxtBPrccvOmSSWIe2OBPBhd1jCgWc99zVyF2ZxKVuB
         NgwGFXF1EYwn2bzPp3hXxNWmtVfbTWTcRqQqyk7AFnd614LnK7CEpJKegZ71OktSZ3Rx
         qILfoAxPEUvFd/dTFfRy8gE4lOSb1B9uM53V92UNLUyOE8fYSCk9mxhUuYzB5Jzy3GlM
         An4ktiw0GKVE3PL9LrRfjZiUKCY/LMPbvwHpwdYC47tLX/UgVt9ycS3iJJhqxztvEwLu
         JtOa3t9Z+g3GN5+JuKPfElQ9r9u+Gs/u93U362sVDPDzgxurabs3aEuu+XbtIJSY3xzM
         ESIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR4ykjIrLioRBxIOzZdrGCnKSV7zrmNYhg7s36QDBUnkQvN60O/0rMIYuzE3RG60fTmjdv+xKxWvZB3QZQQYKN9K9FDBWYwU1i/gVVLy4d8iJOBbW/6pyzPb+nCA6q3hoixd4o3IcNmQ==
X-Gm-Message-State: AOJu0YwfYpZI6xbFyHZs93QesPQHdzIg1GZdNAdurnd/ivWbUAynD2lc
	j0k0QKOU9el/8Nfqty8bTpdL6Bcdafn8H5aR1cHlvef84JtUvFo9eLUWHI+1
X-Google-Smtp-Source: AGHT+IHGoGY2n1QfAG6JTwUNGhhCZzy4UmpenhlHuzy1RroDnkwx5LnD4lEgqD3Y8VeOD4uJVKvTsQ==
X-Received: by 2002:a2e:9907:0:b0:2eb:dabb:f2b2 with SMTP id 38308e7fff4ca-2ec5b38b74amr84977561fa.30.1719509607182;
        Thu, 27 Jun 2024 10:33:27 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a4bef32sm3213471fa.120.2024.06.27.10.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:33:26 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Lei Wang <lewan@microsoft.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Egor Martovetsky <egor@pasemi.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RESEND v6 13/18] EDAC/mc: Re-use generic unique MC index allocation procedure
Date: Thu, 27 Jun 2024 20:32:20 +0300
Message-ID: <20240627173251.25718-14-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627173251.25718-1-fancer.lancer@gmail.com>
References: <20240627173251.25718-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EDAC drivers locally maintaining a statically defined
memory-controllers counter don't care much about the MC index assigned as
long as it's unique so the EDAC core perceives it. Convert these drivers
to be using the generic MC index allocation procedure recently added to
the EDAC core.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v4:
- Initial patch introduction.
---
 drivers/edac/dmc520_edac.c | 4 +---
 drivers/edac/pasemi_edac.c | 5 +----
 drivers/edac/ppc4xx_edac.c | 5 +----
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
index 4e30b989a1a4..93734a97a67b 100644
--- a/drivers/edac/dmc520_edac.c
+++ b/drivers/edac/dmc520_edac.c
@@ -173,8 +173,6 @@ struct dmc520_edac {
 	int masks[NUMBER_OF_IRQS];
 };
 
-static int dmc520_mc_idx;
-
 static u32 dmc520_read_reg(struct dmc520_edac *pvt, u32 offset)
 {
 	return readl(pvt->reg_base + offset);
@@ -517,7 +515,7 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 	layers[0].size = dmc520_get_rank_count(reg_base);
 	layers[0].is_virt_csrow = true;
 
-	mci = edac_mc_alloc(dmc520_mc_idx++, ARRAY_SIZE(layers), layers, sizeof(*pvt));
+	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers, sizeof(*pvt));
 	if (!mci) {
 		edac_printk(KERN_ERR, EDAC_MOD_NAME,
 			    "Failed to allocate memory for mc instance\n");
diff --git a/drivers/edac/pasemi_edac.c b/drivers/edac/pasemi_edac.c
index 1a1c3296ccc8..afebfbda1ea0 100644
--- a/drivers/edac/pasemi_edac.c
+++ b/drivers/edac/pasemi_edac.c
@@ -57,8 +57,6 @@
 #define PASEMI_EDAC_ERROR_GRAIN			64
 
 static int last_page_in_mmc;
-static int system_mmc_id;
-
 
 static u32 pasemi_edac_get_error_info(struct mem_ctl_info *mci)
 {
@@ -203,8 +201,7 @@ static int pasemi_edac_probe(struct pci_dev *pdev,
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 	layers[1].size = PASEMI_EDAC_NR_CHANS;
 	layers[1].is_virt_csrow = false;
-	mci = edac_mc_alloc(system_mmc_id++, ARRAY_SIZE(layers), layers,
-			    0);
+	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers, 0);
 	if (mci == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
index 1eea3341a916..06d267d40a6a 100644
--- a/drivers/edac/ppc4xx_edac.c
+++ b/drivers/edac/ppc4xx_edac.c
@@ -1214,7 +1214,6 @@ static int ppc4xx_edac_probe(struct platform_device *op)
 	const struct device_node *np = op->dev.of_node;
 	struct mem_ctl_info *mci = NULL;
 	struct edac_mc_layer layers[2];
-	static int ppc4xx_edac_instance;
 
 	/*
 	 * At this point, we only support the controller realized on
@@ -1265,7 +1264,7 @@ static int ppc4xx_edac_probe(struct platform_device *op)
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 	layers[1].size = ppc4xx_edac_nr_chans;
 	layers[1].is_virt_csrow = false;
-	mci = edac_mc_alloc(ppc4xx_edac_instance, ARRAY_SIZE(layers), layers,
+	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers,
 			    sizeof(struct ppc4xx_edac_pdata));
 	if (mci == NULL) {
 		ppc4xx_edac_printk(KERN_ERR, "%pOF: "
@@ -1303,8 +1302,6 @@ static int ppc4xx_edac_probe(struct platform_device *op)
 			goto fail1;
 	}
 
-	ppc4xx_edac_instance++;
-
 	return 0;
 
  fail1:
-- 
2.43.0


