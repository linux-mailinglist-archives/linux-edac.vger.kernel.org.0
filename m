Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4173C6AC7
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jul 2021 08:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhGMGzF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Jul 2021 02:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhGMGzE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Jul 2021 02:55:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EA6C0613DD;
        Mon, 12 Jul 2021 23:52:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d1so5379399plg.0;
        Mon, 12 Jul 2021 23:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kx4B7JnocdaZxZ/7Wnor5/9TVce+G1JuF4QpJFpf+/Q=;
        b=sUNBV7guZ+jJXMPm2pb4MmWtY1bdReKPAwku6Rx1OlKUbTwCscArqeL/swg3V3RFky
         UnwA8AgB8A7RykOfh7bWHDN2SAxI1QQyEmazr2N2a7i4NROrS0LCuksiivCgOT1W+U6M
         b+chHgAJARDloge++oeFFHyp1g1GZbh5Ahx1rA7SeT6oj7dJTz515PIX2gFiTRCdG7Y7
         zot8kOHZA+/Bdg23D8ADhej1xx/CE5nNUn4uhzq5lrTpO1E/YcWrCTyNzIfKeG7Pg5Xo
         IGWVdI6fET/43oBeuFR74I5bU1DCwjgnjqsgNuFPc5w4GlJM05sNwkZZyNSSG58KqEM5
         30cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kx4B7JnocdaZxZ/7Wnor5/9TVce+G1JuF4QpJFpf+/Q=;
        b=pdLTdaaTxXVOy5Y7XUCJBBaWOcyG/CxI2bkbt8S2ud7RGhD5XrDHUeexOvJOvVIPWO
         uskZv1V9qpUpVXp55H09b9EKSOE5OPMqu7dD0LrPdBVHCux5/6wFkGnQ4OzFPb/fD8nr
         WXnh270b7uzkOlVGCxwJGqOS2589m55A3xsUeooQRpd8Nc9feY5qQAw753hqUkeOsZ9F
         m72yTXz8Uo/IUR/9y9PAaFJEhwit4+czMHU4xfsMj+PshjzxpFA+FuPvkgsgYtQA5w1q
         ApEcQRoUMyKbPZ/V5yU6iolLuHCjQn2jgFQtSKnOaA4Cg7AqJ5B7ODB9ygYTIDrqVKpT
         yneQ==
X-Gm-Message-State: AOAM5304PI3xinq+p9Ok9QL7M+XnykXgpwE8T61y+ulhUnAAw21Y9bPV
        EtrYBuvb+XZ6aC6GE5kg01E=
X-Google-Smtp-Source: ABdhPJz+oghtLgbKWbEJYLUpG9FElmkoYgaZBeeGAV96Zt9M3nwctzD5m9z5PjdPETb0GtWGXM3W9w==
X-Received: by 2002:a17:90b:1484:: with SMTP id js4mr2897770pjb.155.1626159134806;
        Mon, 12 Jul 2021 23:52:14 -0700 (PDT)
Received: from localhost.localdomain ([49.37.52.150])
        by smtp.gmail.com with ESMTPSA id l8sm1194780pjc.17.2021.07.12.23.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 23:52:14 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     yazen.ghannam@amd.com, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     lukas.bulwahn@gmail.com, kbuild-all@lists.01.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v3] EDAC/amd64: Use DEVICE_ATTR helper macros
Date:   Tue, 13 Jul 2021 12:21:30 +0530
Message-Id: <20210713065130.2151-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Instead of "open coding" DEVICE_ATTR, use the corresponding
helper macros DEVICE_ATTR_{RW,RO,WO} in amd64_edac.c

Some function names needed to be changed to match the device
conventions <foo>_show and <foo>_store, but the functionality
itself is unchanged.

The devices using EDAC_DCT_ATTR_SHOW() are left unchanged.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---

Changes in v3:
- Reword patch subject as suggested by Yazen and fix a typo.
  https://lore.kernel.org/lkml/20210712194433.GA1002@aus-x-yghannam.amd.com/

Changes in v2:
- Revert back the device name changes which broke
  the kernel. These were using the macro EDAC_DCT_ATTR_SHOW()
  to construct the show methods based on device name.
  Reported by Kernel test bot.

 drivers/edac/amd64_edac.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f0d8f60acee1..99b06a3e8fb1 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -571,8 +571,8 @@ EDAC_DCT_ATTR_SHOW(dbam0);
 EDAC_DCT_ATTR_SHOW(top_mem);
 EDAC_DCT_ATTR_SHOW(top_mem2);
 
-static ssize_t hole_show(struct device *dev, struct device_attribute *mattr,
-			 char *data)
+static ssize_t dram_hole_show(struct device *dev, struct device_attribute *mattr,
+			      char *data)
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
@@ -593,7 +593,7 @@ static DEVICE_ATTR(dhar, S_IRUGO, dhar_show, NULL);
 static DEVICE_ATTR(dbam, S_IRUGO, dbam0_show, NULL);
 static DEVICE_ATTR(topmem, S_IRUGO, top_mem_show, NULL);
 static DEVICE_ATTR(topmem2, S_IRUGO, top_mem2_show, NULL);
-static DEVICE_ATTR(dram_hole, S_IRUGO, hole_show, NULL);
+static DEVICE_ATTR_RO(dram_hole);
 
 static struct attribute *dbg_attrs[] = {
 	&dev_attr_dhar.attr,
@@ -802,16 +802,11 @@ static ssize_t inject_write_store(struct device *dev,
  * update NUM_INJ_ATTRS in case you add new members
  */
 
-static DEVICE_ATTR(inject_section, S_IRUGO | S_IWUSR,
-		   inject_section_show, inject_section_store);
-static DEVICE_ATTR(inject_word, S_IRUGO | S_IWUSR,
-		   inject_word_show, inject_word_store);
-static DEVICE_ATTR(inject_ecc_vector, S_IRUGO | S_IWUSR,
-		   inject_ecc_vector_show, inject_ecc_vector_store);
-static DEVICE_ATTR(inject_write, S_IWUSR,
-		   NULL, inject_write_store);
-static DEVICE_ATTR(inject_read,  S_IWUSR,
-		   NULL, inject_read_store);
+static DEVICE_ATTR_RW(inject_section);
+static DEVICE_ATTR_RW(inject_word);
+static DEVICE_ATTR_RW(inject_ecc_vector);
+static DEVICE_ATTR_WO(inject_write);
+static DEVICE_ATTR_WO(inject_read);
 
 static struct attribute *inj_attrs[] = {
 	&dev_attr_inject_section.attr,
-- 
2.28.0

