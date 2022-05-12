Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747EA524782
	for <lists+linux-edac@lfdr.de>; Thu, 12 May 2022 09:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351274AbiELH7e (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 May 2022 03:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351277AbiELH7Y (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 12 May 2022 03:59:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3817A692B7;
        Thu, 12 May 2022 00:59:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j10-20020a17090a94ca00b001dd2131159aso7155897pjw.0;
        Thu, 12 May 2022 00:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AgL3ZArZDW3DlZE6X+7yZEwAq78dH0rZAiV72ri9RP4=;
        b=jG7XO84WMzHZK2+O4uPlgAr7MloxutAYbxZXdDQchIfUbC15hDP4QL2DtWQ/BBSm3e
         OThDS2tfurLf/4IYog4eKNBwVSo75LHSbRJlfR3FdDskhUPec2D/n0KjeW6aSRkcdnsM
         v81jmRye2PZ3t3crVHPf3vpeinS5PbXabQ2KGHweXuTRBvYBZ0Nb5JvS0x3tVvYvTXlW
         YvHlbPdHW7MSRUaGdNbWBz3T8BIXoS5iW+JTJJRPbIL7W+DNEBltBr297F9QrxLKPbT7
         ykHYYtwf1+jBoEG/7D5Wy8Vw13MXPHCzoOU8cmV+SvuJjxincKU1GwNBF3v3um/bZcwF
         p0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AgL3ZArZDW3DlZE6X+7yZEwAq78dH0rZAiV72ri9RP4=;
        b=PSEg8KkzwEuaxZgnP1Cti/tsYLhHajGwZrmmkQiF9F0iWJ9RoqCZ7+TC2fHleQPcO7
         tPweNgyLOIPLQrDuHsLZGvFzixy3FDKQCIQth1xVb7NgYiY4LBTTv9c6ANqmcEp88Dkb
         2cDHpyddbnRgwEBdjNYACIAxuO7pvSriGscZu13CcWhC1viBE9P2v3ZDoBYFE4UNJ8R9
         rTb1G213cJD0/if40upuJKSiMLhNbRGilqa7tcMvDXxZVDFaeKpdL6AGgxFxz5NBDRba
         SkVVeO4Fm8LE5xgwZMVgZY26ySzY/gJrEZeXQ6gEni0quDMFkwovGh2tWb8/6/z4ATrm
         EbCA==
X-Gm-Message-State: AOAM5305alk9OKULRlT3rvGD8roSsaVEO+xdzhrySoZyCu7mkv3Gfu2+
        dUznFQitTQACgK3rQV/5MjY=
X-Google-Smtp-Source: ABdhPJz+auQAeW7PbC0uH/FzOYlbd/4Ga6ed6ya6hGyePOn2GrU0h+fvEDbGHogXVfVd9eqp1jK/oQ==
X-Received: by 2002:a17:902:8203:b0:15f:4423:6e9c with SMTP id x3-20020a170902820300b0015f44236e9cmr1867189pln.25.1652342361778;
        Thu, 12 May 2022 00:59:21 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id i7-20020a17090adc0700b001cd4c118b07sm1217708pjv.16.2022.05.12.00.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:59:21 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Doug Thompson <dougthompson@xmission.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] EDAC: Fix some refcount leaks
Date:   Thu, 12 May 2022 11:59:06 +0400
Message-Id: <20220512075906.21915-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

kobject_init_and_add() takes reference even when it fails.
According to the doc of kobject_init_and_add()

   If this function returns an error, kobject_put() must be called to
   properly clean up the memory associated with the object.

Fix this by calling kobject_put() when kobject_init_and_add() fails.

Fixes: b2ed215a3338 ("Kobject: change drivers/edac to use kobject_init_and_add")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes on v2:
- fix wrong label
v1 link: https://lore.kernel.org/all/20220511081402.19784-1-linmq006@gmail.com/
---
 drivers/edac/edac_device_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 9a61d92bdf42..a48142a8ea6f 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -542,7 +542,7 @@ static int edac_device_create_block(struct edac_device_ctl_info *edac_dev,
 		edac_dbg(1, "Failed to register instance '%s'\n", block->name);
 		kobject_put(main_kobj);
 		err = -ENODEV;
-		goto err_out;
+		goto err_on_attrib;
 	}
 
 	/* If there are driver level block attributes, then added them
@@ -640,7 +640,7 @@ static int edac_device_create_instance(struct edac_device_ctl_info *edac_dev,
 		edac_dbg(2, "Failed to register instance '%s'\n",
 			 instance->name);
 		kobject_put(main_kobj);
-		goto err_out;
+		goto err_release_instance_kobj;
 	}
 
 	edac_dbg(4, "now register '%d' blocks for instance %d\n",
-- 
2.25.1

