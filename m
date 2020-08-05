Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEAB23C9A7
	for <lists+linux-edac@lfdr.de>; Wed,  5 Aug 2020 11:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgHEJ5Q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Aug 2020 05:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgHEJ5L (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 Aug 2020 05:57:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A02C06174A;
        Wed,  5 Aug 2020 02:57:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so5253600wme.0;
        Wed, 05 Aug 2020 02:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1OAmVtSarOHcu5ZEW1PVzjCPTYGRQAmrkDItGjUPpX8=;
        b=fjUp4EAV1gNYJf5jNJEPHu/eTAq2ehsmSAeDsPHlO4hKzSThUSJ7U4GfIHYwQSX8b/
         DFajIrYJoNyhO21WVG2iZdLL8rDz4nCsADns0oGiWk8QIUE3SeenexMDCqOs4ANqa9N2
         72yWk7/SuyiaLZ7gz2A8rkQT3PQ/+40618j7P6tqA6Bast9aIc0e7RBLWurLhvHcVtHc
         zNRswRMhv5bBTWJZ7ws0oP06BwsbpzfE2qayfUuS8K+Mvdj44ZsywzcGWIBErUu10MHB
         WWLAPOapnMB1aHh73c/zgx6WvLgJ/hyAEuFP7V/Dod+6kjy4YfWxT5tlZHBPGYvb7CJn
         Ij5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1OAmVtSarOHcu5ZEW1PVzjCPTYGRQAmrkDItGjUPpX8=;
        b=RwKRHWtXlSE5ote94ipaFqHYoFDJlaKC/S8p1OTyTXyjGTyV1ElVlSps6Z9KTajcoQ
         I+Ok1VHBW2xTMgGXsHt3jgzTsvo6zKY/DdI1gWZVYKjj2fM6enl3LrRtDbbhRVYX0lgy
         LqWwNcI1pSPM6tt8bTtElzcgS9jVusrNSWjXL1Ft5KN1F1DbYWupOvqRO2D8oVHpkRJY
         pNiFtDA1SQB1IPjzkdPoA6XTETWfNtBG4/64TTX5/GB8LXnuT6OGX65H1OjGZoiK/9sJ
         4bK44bc5u1mTwpbpZ2SX0Ta5ANgeoeDx9xSGPmI3VQ+yca77CMd0D5E+ps2pAxfsvUnD
         keOA==
X-Gm-Message-State: AOAM531F/eJ24idcYBR4Nk/1eiOb90L9Eq9jS/BF85/wR40X4Fs/XTgX
        xkks+O4fcli5O87pL14nbQG7JE2DN/laqg==
X-Google-Smtp-Source: ABdhPJyr4pSazTF5B0tG/B7oKblc6I0+bG+S/lN546VhaOYAv89cbYuDXxavI76P0qEWi3Iaw5tRUg==
X-Received: by 2002:a1c:24d5:: with SMTP id k204mr2459529wmk.159.1596621429826;
        Wed, 05 Aug 2020 02:57:09 -0700 (PDT)
Received: from luca020400-arch.lan ([2001:b07:5d33:19f:d537:6bdb:9442:dd28])
        by smtp.googlemail.com with ESMTPSA id n24sm2164021wmi.36.2020.08.05.02.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 02:57:09 -0700 (PDT)
From:   Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     Luca Stefani <luca.stefani.ge1@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] RAS/CEC: Fix cec_init prototype
Date:   Wed,  5 Aug 2020 11:57:08 +0200
Message-Id: <20200805095708.83939-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200805045955.GB9127@nazgul.tnic>
References: <20200805045955.GB9127@nazgul.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

* late_initcall expects a function that returns an integer
  -> Update the function signature to match.

Fixes: 9554bfe403nd ("x86/mce: Convert the CEC to use the MCE notifier")
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 drivers/ras/cec.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 569d9ad2c594..6939aa5b3dc7 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -553,20 +553,20 @@ static struct notifier_block cec_nb = {
 	.priority	= MCE_PRIO_CEC,
 };
 
-static void __init cec_init(void)
+static int __init cec_init(void)
 {
 	if (ce_arr.disabled)
-		return;
+		return -ENODEV;
 
 	ce_arr.array = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!ce_arr.array) {
 		pr_err("Error allocating CE array page!\n");
-		return;
+		return -ENOMEM;
 	}
 
 	if (create_debugfs_nodes()) {
 		free_page((unsigned long)ce_arr.array);
-		return;
+		return -ENOMEM;
 	}
 
 	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
@@ -575,6 +575,7 @@ static void __init cec_init(void)
 	mce_register_decode_chain(&cec_nb);
 
 	pr_info("Correctable Errors collector initialized.\n");
+	return 0;
 }
 late_initcall(cec_init);
 
-- 
2.28.0

