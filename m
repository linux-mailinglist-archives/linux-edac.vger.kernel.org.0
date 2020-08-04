Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B3323BDF8
	for <lists+linux-edac@lfdr.de>; Tue,  4 Aug 2020 18:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgHDQSw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Aug 2020 12:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbgHDQSv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Aug 2020 12:18:51 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A595C06174A;
        Tue,  4 Aug 2020 09:18:51 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a14so13351002edx.7;
        Tue, 04 Aug 2020 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iw73O7zxTtWlECCxBVTbs3K0lH4NxmMjnyOEyQVNmnY=;
        b=VriJCAZkBFkRHCN582PoHkkOpqw/g6OLh9IQ1Sus5cSS8CSyYcwUCQw3kRurT34Tc/
         pA6moefJLXEIUuhKzPIFwbScJZZa3C4NGzkT7d0AbOATYC2ZF+IIC3e2Pkh+KGIep2nm
         vXQRBGj0OJkWBCs7EmVtjJvapBZ/KSWhHKWdxPmcsqdqfsHTkja+32tWE1mIgjNVTV6I
         zL1EworxqHJfFRuLSgG+QbyYpHL9lZU6wPx1aZuWWAS2tGtNpt0MMeccSdRFpLh6hWxm
         78oufE7OuWZ+CsTBTq3OPKh4h/lPTtYiIR3XWxTBCtLqWlW3xHYCgcgFblcFSaRNimJ/
         D3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iw73O7zxTtWlECCxBVTbs3K0lH4NxmMjnyOEyQVNmnY=;
        b=m1wHL06uqR6EGw+F/Khm+icn3izxPZWch/TnIvBOexKQ3F66pXLMoLO5Jb4mdgcMVo
         3f1dFsBxweYCMKg1jlBJw4QjrIKZ5kxK+2/OnxbsMnqIwI5oZ01Ra8ryTu63dHBPpLvx
         fUy0sD2ti0tPavHYTfAQuj0Vxr1L8xSpY1OQyWfpciWcb8tOI8W8sGfL/sTHEfmh60na
         nrbV+ZAUbABw1QGy8TEdJCX8AGfSA7IGor68NWoSFUjA/c88w/lz6Kn7QmBCXCmZi35r
         rJvJLj1NBRejztMlamuEbhVxMUG0P2uo+149kbnRUq6P91KH4PnXVU8jpYpieOtVtPLu
         CRBg==
X-Gm-Message-State: AOAM530eLTgTHKmHNdul2kxlGdRoH2IcKybUpanPsfKovAm9rAGpULoE
        xz1cidG5W6hRXPBkMjWYRfM=
X-Google-Smtp-Source: ABdhPJwzbzFpdu4i50fVtxewCe8ZmPJbN9uCHcWI6UYessAZzsIkeoX13JGdttLZ0pBoMFUATs7+Zw==
X-Received: by 2002:a05:6402:c81:: with SMTP id cm1mr20534593edb.256.1596557929841;
        Tue, 04 Aug 2020 09:18:49 -0700 (PDT)
Received: from luca020400-arch.lan ([2001:b07:5d33:19f:d537:6bdb:9442:dd28])
        by smtp.googlemail.com with ESMTPSA id sd8sm19224438ejb.58.2020.08.04.09.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 09:18:49 -0700 (PDT)
From:   Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     Luca Stefani <luca.stefani.ge1@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RAS/CEC: Fix cec_init prototype
Date:   Tue,  4 Aug 2020 18:18:47 +0200
Message-Id: <20200804161847.825391-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

* late_initcall expects a function to return an integer

Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 drivers/ras/cec.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 569d9ad2c594..e048e0e3949a 100644
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
+		return 0;
 
 	ce_arr.array = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!ce_arr.array) {
 		pr_err("Error allocating CE array page!\n");
-		return;
+		return 1;
 	}
 
 	if (create_debugfs_nodes()) {
 		free_page((unsigned long)ce_arr.array);
-		return;
+		return 1;
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

