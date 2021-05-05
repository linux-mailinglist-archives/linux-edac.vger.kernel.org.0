Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1A2374789
	for <lists+linux-edac@lfdr.de>; Wed,  5 May 2021 20:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhEER6d (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 May 2021 13:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhEER6X (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 May 2021 13:58:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C83CC06174A;
        Wed,  5 May 2021 10:30:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i13so2631766pfu.2;
        Wed, 05 May 2021 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tbVzzI+JYsOP18EDnbNk6QkiQHYj/dX0kpKb8Xi/8Mg=;
        b=JTz659KlMS1gxHXsEL7yjATHSOj8H02DXZf2jO3KKOvxaldRLwmrGpUcaAeKrIq2vw
         x257TVGnSYAJHJSTachu1UZ5w3xOL7PoIoZYAeI8NPwsGSsJ+bbf9qfnF5kztSkRc8Sk
         +/hxw3rn7jqSHTYneesg4zozdnF3/21iHI7btnp1tzFu6mbFqv3jhLW8k4/8piwhkVy+
         ak4YtcvZsMydkNd3viM/XTpp/BSRMCkP2cZhF1Xpaw56V9e81OVZit0MRQ7ybPFkDgYq
         ibiPEY8n34LiDKTXS5DjhWwagBLAkBkTwl0OBiz5tX8E/tU/68/rgpGB8+1HuR/XEMZf
         CDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tbVzzI+JYsOP18EDnbNk6QkiQHYj/dX0kpKb8Xi/8Mg=;
        b=iwwMLe5qEuJVpX2hXzdTNoVAiFpXDVda81FgeUrxuJUpTFuHkXIo9NcquLHdm9+E69
         V60elpFc2YuKbheKVGMkIeYarErhp75lD5ZlJdBTXuE4Yi3HaVs7EK4xaIFe+QO90f1F
         GFY48KjDzGx3s5fS8KzZahPXOpyBD3N3KHjiTpO+B+gNLB2Q4KCsPRe7malXxxNpWMx4
         K8IHFpiE0Jug7AEYgSKuxSCKrZqRQvlFkYAfCRyQAgW0kokqf3u90DsfR5XwRIWQgvcH
         ZjrDaEhCQxHKtv/Rp8O/jskeIMVpyhbA6OSNFEpFyrdAvnJ664nJznxSQ8EPpTkRcGMv
         KePQ==
X-Gm-Message-State: AOAM532lp4VAuOP5XteUoo3C/KTxRaBjuHH3Lo6ZGq0CB9qe6+kwt22L
        35Sv63kXvsoh2OXNnsJJlro=
X-Google-Smtp-Source: ABdhPJzflfhtVuYqljkr14JbqCQvhLDW9gKT3LHq/7+w29euYPXl6mRLWeiT/AAwHtUm+1EivklQyg==
X-Received: by 2002:aa7:9190:0:b029:22d:6789:cc83 with SMTP id x16-20020aa791900000b029022d6789cc83mr30544123pfa.9.1620235836904;
        Wed, 05 May 2021 10:30:36 -0700 (PDT)
Received: from dplat-lab.corp.microsoft.com ([131.107.159.159])
        by smtp.gmail.com with ESMTPSA id p36sm2234192pgm.74.2021.05.05.10.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 10:30:36 -0700 (PDT)
From:   Lei Wang <wangglei@gmail.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        lewan@microsoft.com, hangl@microsoft.com,
        tyhicks@linux.microsoft.com, bwaller@microsoft.com,
        Lei Wang <wangglei@gmail.com>
Subject: [PATCH] EDAC: update edac printk wrappers to use printk_ratelimited.
Date:   Wed,  5 May 2021 10:30:27 -0700
Message-Id: <20210505173027.78428-1-wangglei@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Update printk to the ratelimited version, so that in some corner cases when
vast of CE errors show up, the kernel logging can be suppressed.

Signed-off-by: Lei Wang <wangglei@gmail.com>
---
 drivers/edac/edac_mc.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 881b00eadf7a..355529317980 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -46,19 +46,19 @@
 #endif
 
 #define edac_printk(level, prefix, fmt, arg...) \
-	printk(level "EDAC " prefix ": " fmt, ##arg)
+	printk_ratelimited(level "EDAC " prefix ": " fmt, ##arg)
 
 #define edac_mc_printk(mci, level, fmt, arg...) \
-	printk(level "EDAC MC%d: " fmt, mci->mc_idx, ##arg)
+	printk_ratelimited(level "EDAC MC%d: " fmt, mci->mc_idx, ##arg)
 
 #define edac_mc_chipset_printk(mci, level, prefix, fmt, arg...) \
-	printk(level "EDAC " prefix " MC%d: " fmt, mci->mc_idx, ##arg)
+	printk_ratelimited(level "EDAC " prefix " MC%d: " fmt, mci->mc_idx, ##arg)
 
 #define edac_device_printk(ctl, level, fmt, arg...) \
-	printk(level "EDAC DEVICE%d: " fmt, ctl->dev_idx, ##arg)
+	printk_ratelimited(level "EDAC DEVICE%d: " fmt, ctl->dev_idx, ##arg)
 
 #define edac_pci_printk(ctl, level, fmt, arg...) \
-	printk(level "EDAC PCI%d: " fmt, ctl->pci_idx, ##arg)
+	printk_ratelimited(level "EDAC PCI%d: " fmt, ctl->pci_idx, ##arg)
 
 /* prefixes for edac_printk() and edac_mc_printk() */
 #define EDAC_MC "MC"
-- 
2.17.1

