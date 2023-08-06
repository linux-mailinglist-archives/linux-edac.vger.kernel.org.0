Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A118E77151E
	for <lists+linux-edac@lfdr.de>; Sun,  6 Aug 2023 15:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjHFNF0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 6 Aug 2023 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFNFZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 6 Aug 2023 09:05:25 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA36B19A7
        for <linux-edac@vger.kernel.org>; Sun,  6 Aug 2023 06:05:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bb8a89b975so22255935ad.1
        for <linux-edac@vger.kernel.org>; Sun, 06 Aug 2023 06:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691327124; x=1691931924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EvTReqZSJkc02HzacPqVscfNFgT5VLe0HhEZsYvR07E=;
        b=KJNEXom/9DpXIOQPuYilti5TYkD4xBePA3M3UWwHcxKjv+F8d0HKbmOSZMlkwzivjr
         4sUYrFh5jJgrhwCiqHcWtg0ZScaWbN9MfKDlBnweW5eLD30bQtkSVsKVpE457DXO/i1m
         pBJSyNaQmkoXvcqAIU4bcfQfCcbCH/apRco5xQ4qArA4vSu1r+7NG8VH1P963qm2Alql
         +abm0bLXnsM9LjOu0X/ZYzGiU1bmHSzZnhc4gDpha+cpl1W6YX/CTwNRF3uwDrMmaBTL
         QIq4jwe27p1DPSA5gDS1ElO+RyFaKjEqpoR7pE/q3dFv9tCRhrJX9jgdUTMAO+Xfudys
         nldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691327124; x=1691931924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvTReqZSJkc02HzacPqVscfNFgT5VLe0HhEZsYvR07E=;
        b=i7VppDNDD/HmtjRL3g/cnsBXLB9VTqQTvhNfAgZaFY+j3jPAWmSEdqqzbjMJds0WtD
         VAPO5U/9a3bhSC3ivutCHTsUYZsYy5KCUzxIS48SbwWyetejV1DciEEslkAH5ftiKw5+
         gOv0GL2u+YKD4PgDoF9G3ONQkMfhj9KvGz95pz8dPvEXkihZD2FghU0N9XTnfVF/MNRf
         TuTtk4bb4mFwppnCB7WsmzAAoZ4uB28gTItkiRtNVkOxni9BLOK2W0IvxDJ3wHCAEAqC
         sQzegzDrjPCgqTbc7qX7NW6zeSeaEy4ntxJaOWCHXSNhOMkp1nsTmZy7yPkG3fGHsXSk
         OuKQ==
X-Gm-Message-State: AOJu0YzHlPXpUHfbJWiU9VK/xzJrKdjfDWO4Ac18DK7h4wRYbbshXCNy
        /WvRb2RwMNjGBjpwYd6BFyw=
X-Google-Smtp-Source: AGHT+IGz61GEXpe5dVF3GTw1ZmWbo2a6fJ2/cStkVKPUCxobTRaLVTD9qceSLuAB+BTCdMCbnfaSfQ==
X-Received: by 2002:a17:902:c20c:b0:1b8:a277:4b5b with SMTP id 12-20020a170902c20c00b001b8a2774b5bmr5484026pll.7.1691327124306;
        Sun, 06 Aug 2023 06:05:24 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58e9:3a2a:ee75:10eb:7534])
        by smtp.gmail.com with ESMTPSA id jd9-20020a170903260900b001bb54abfc07sm4886383plb.252.2023.08.06.06.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 06:05:23 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     shubhrajyoti.datta@amd.com, sai.krishna.potthuri@amd.com,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        bp@alien8.de, tony.luck@intel.com, michal.simek@amd.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>,
        linux-edac@vger.kernel.org, shuah@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v1] drivers: edac: zynqmp_edac: Updates return value check
Date:   Sun,  6 Aug 2023 18:35:14 +0530
Message-Id: <20230806130514.159102-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Updating the check of return value from edac_debugfs_create_dir
to use IS_ERR.

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 drivers/edac/zynqmp_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
index ac7d1e0b324c..cefbbafb945e 100644
--- a/drivers/edac/zynqmp_edac.c
+++ b/drivers/edac/zynqmp_edac.c
@@ -351,7 +351,7 @@ static void setup_debugfs(struct edac_device_ctl_info *edac_dev)
 	struct edac_priv *priv = edac_dev->pvt_info;
 
 	priv->debugfs_dir = edac_debugfs_create_dir("ocm");
-	if (!priv->debugfs_dir)
+	if (IS_ERR(priv->debugfs_dir))
 		return;
 
 	edac_debugfs_create_x32("inject_fault_count", 0644, priv->debugfs_dir,
-- 
2.25.1

