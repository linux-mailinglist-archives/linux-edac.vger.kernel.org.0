Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80157055FE
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 20:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjEPS3r (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 14:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEPS3q (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 14:29:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C4A115;
        Tue, 16 May 2023 11:29:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-24e015fcf3dso10730050a91.3;
        Tue, 16 May 2023 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684261785; x=1686853785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CTtiesp1UhLngJ6SgodNXDP6I2XmXvLMSs0QuXUrmTY=;
        b=BGdD73X2HIfLkupm8DBNIPxZFaW6K3WGu/hZr2NJEPK0X4x/KhCC7FnN+vgwynVpOA
         c/cSLpLIkLQRuWNXhgfQMve+wbIZIwyfWXLOQKszu35DNr32dEMUoUmZOMbetNw96B2g
         m8Y4X+DCMORj9NcW20Laoz1xvbTgskE8PmTAmXzhslgFSf8Qe2UwdXJ+UlR8oqdnb99b
         Nhef24kxkNskkK3RaqbUoltxPC+0NKQsg9XYxG8PpkV9cR+IBDtrSa78q3KltBhIETK1
         j7r6DIvziABbxQc7rWFr8j3ifnpVD6K09OJ1dyJQfmq/0ZHQ0R08CvwtuD7FptW03FlB
         KtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261785; x=1686853785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTtiesp1UhLngJ6SgodNXDP6I2XmXvLMSs0QuXUrmTY=;
        b=UegtNxq1P9FIF54V3yHNJFZSJfeaEJqJvcYVIQChtmsgoKLjEggctT1vxkeB1qtvfL
         5/mfKz4PmYD3At7q4pUAAVgn0zXEDr3mtnNohPOJZpFxIogX2DJObIuP4Vhs8S6tWtcc
         pamH+pnwG3VhEo2yITjHKBbHQuxMA2QAtMHhtjJw+YThHXleRG8xYpzi52gbjudlBGFp
         b1UztwHf1HX3DRz5ss16njKsi64xq1wWLwpirDv/NaJl5BdaaVKlfEfcToURdCB8bVgX
         sbieSIjC+EQC7DGLnhqC1OWI3R1WCngdgkx7K0RHOi93xAcMgbfuTqeBAieC1MC9CwYI
         Kc5w==
X-Gm-Message-State: AC+VfDwXrmOItU31sk7afWynvSWE5NiKLp3KcK4scx2QkuooQd5zc9Y0
        Hl9N3VcbyUpV7CofaqFLz3s5MX8CYCw=
X-Google-Smtp-Source: ACHHUZ4cy4D074wvNa0soFPKQMWSkGAO1cFCKieejGqbwZjXqahFRUNp7nY5BGpfggTSmN43pzYlVQ==
X-Received: by 2002:a17:90a:2a47:b0:253:3118:1ba0 with SMTP id d7-20020a17090a2a4700b0025331181ba0mr1697464pjg.11.1684261784782;
        Tue, 16 May 2023 11:29:44 -0700 (PDT)
Received: from Osmten.. ([103.84.150.77])
        by smtp.gmail.com with ESMTPSA id gj8-20020a17090b108800b00246b7b8b43asm1927663pjb.49.2023.05.16.11.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:29:44 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     tony.luck@intel.com, bp@alien8.de
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] ras:debugfs.c: Fix error checking for debugfs_create_dir
Date:   Tue, 16 May 2023 23:29:27 +0500
Message-Id: <20230516182927.9171-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch fixes the error checking in debugfs.c in debugfs_create_dir.
The correct way to check if an error occurred is 'IS_ERR' inline function.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/ras/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index f0a6391b1146..ffb973c328e3 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -46,7 +46,7 @@ int __init ras_add_daemon_trace(void)
 
 	fentry = debugfs_create_file("daemon_active", S_IRUSR, ras_debugfs_dir,
 				     NULL, &trace_fops);
-	if (!fentry)
+	if (IS_ERR(fentry))
 		return -ENODEV;
 
 	return 0;
-- 
2.34.1

