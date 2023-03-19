Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1B6C0290
	for <lists+linux-edac@lfdr.de>; Sun, 19 Mar 2023 16:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjCSPCH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 19 Mar 2023 11:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjCSPCE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 19 Mar 2023 11:02:04 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D963D22100;
        Sun, 19 Mar 2023 08:01:48 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id l15so3796187ilv.4;
        Sun, 19 Mar 2023 08:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679238108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9RoQfRmP4GF9U1NfRinA4rTciPH5Jr0EXMy8qOud8Y=;
        b=FVn7C6NB2LVVbQRrI0BaXFRhOAyw07wTt6+KM/sqeYOIVzV8stsn+BBzqimbAkERMn
         vaLRvEQ6Nx9klWtDNGndjCkb04BRt5ZzLP5lygHJzYIiSb+DdMMT2vubYxmWMUgTnpO2
         BrBg8/wlbcsg+cA1SY0CLHT676I2VRurrWZ6bsb7TEm3DvLgvD8KsXqW2p1Bp8je10ZD
         DmrXX7XEJ1JDc0jv4WpN28AH4CecOFqKkk/ksM247mpuNaIjc0SeE+UqunGDuqIckEek
         sv5fEmLWZZG4YOVuJTM8ErYtkxjtdhfjlMJjes6ygi0OQ9jVD/98xpuSUTeX/wIUWuxY
         4oIg==
X-Gm-Message-State: AO0yUKWxhYt/P0LbqCdm0FKZZstGd5q9mSTvTeqo9zOKopRpBXKYKGHf
        jzODaykvBqZsSLwybmE00Q==
X-Google-Smtp-Source: AK7set+cVhBvDHtDGUm7InWYjtZhoIIh9y1fNxd9MscUJ3CpB+m35zGQ9u/8G8wNdd2ckt3KFS5eiQ==
X-Received: by 2002:a92:d903:0:b0:323:2468:ba20 with SMTP id s3-20020a92d903000000b003232468ba20mr3232316iln.10.1679238107977;
        Sun, 19 Mar 2023 08:01:47 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c4:7b93:58f2:478b:84fd:941e])
        by smtp.gmail.com with ESMTPSA id g10-20020a056e020d0a00b00313b281ecd2sm2154126ilj.70.2023.03.19.08.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 08:01:47 -0700 (PDT)
Received: (nullmailer pid 67920 invoked by uid 1000);
        Sun, 19 Mar 2023 15:01:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] edac: cpc925: Drop unused memory size DT parsing
Date:   Sun, 19 Mar 2023 10:01:40 -0500
Message-Id: <20230319150141.67824-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The 'total_mem' memory size is parsed from DT, but never used anywhere.
Just drop it as drivers shouldn't really do their own parsing of common
bindings, and memblock would be a better way to get memory size now
anyways.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/edac/cpc925_edac.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
index 9797e6d60dde..ee193aae8e14 100644
--- a/drivers/edac/cpc925_edac.c
+++ b/drivers/edac/cpc925_edac.c
@@ -263,7 +263,6 @@ enum brgctrl_bits {
 /* Private structure for edac memory controller */
 struct cpc925_mc_pdata {
 	void __iomem *vbase;
-	unsigned long total_mem;
 	const char *name;
 	int edac_idx;
 };
@@ -280,37 +279,6 @@ struct cpc925_dev_info {
 	void (*check)(struct edac_device_ctl_info *edac_dev);
 };
 
-/* Get total memory size from Open Firmware DTB */
-static void get_total_mem(struct cpc925_mc_pdata *pdata)
-{
-	struct device_node *np = NULL;
-	const unsigned int *reg, *reg_end;
-	int len, sw, aw;
-	unsigned long start, size;
-
-	np = of_find_node_by_type(NULL, "memory");
-	if (!np)
-		return;
-
-	aw = of_n_addr_cells(np);
-	sw = of_n_size_cells(np);
-	reg = (const unsigned int *)of_get_property(np, "reg", &len);
-	reg_end = reg + len/4;
-
-	pdata->total_mem = 0;
-	do {
-		start = of_read_number(reg, aw);
-		reg += aw;
-		size = of_read_number(reg, sw);
-		reg += sw;
-		edac_dbg(1, "start 0x%lx, size 0x%lx\n", start, size);
-		pdata->total_mem += size;
-	} while (reg < reg_end);
-
-	of_node_put(np);
-	edac_dbg(0, "total_mem 0x%lx\n", pdata->total_mem);
-}
-
 static void cpc925_init_csrows(struct mem_ctl_info *mci)
 {
 	struct cpc925_mc_pdata *pdata = mci->pvt_info;
@@ -321,8 +289,6 @@ static void cpc925_init_csrows(struct mem_ctl_info *mci)
 	u32 mbmr, mbbar, bba, grain;
 	unsigned long row_size, nr_pages, last_nr_pages = 0;
 
-	get_total_mem(pdata);
-
 	for (index = 0; index < mci->nr_csrows; index++) {
 		mbmr = __raw_readl(pdata->vbase + REG_MBMR_OFFSET +
 				   0x20 * index);
-- 
2.39.2

