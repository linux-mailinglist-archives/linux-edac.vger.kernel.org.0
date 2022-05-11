Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB76D522DFA
	for <lists+linux-edac@lfdr.de>; Wed, 11 May 2022 10:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbiEKIOP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 May 2022 04:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbiEKIOO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 11 May 2022 04:14:14 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6352A3135F;
        Wed, 11 May 2022 01:14:13 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q76so1133604pgq.10;
        Wed, 11 May 2022 01:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FS66Oj11w6MDEI4rAEPsn2TlYuqzBpV411AM7ZB6FsQ=;
        b=YyNwaloW6KJqGPI4bLpuUOQnt1mWqMi58do3k/0z5ptZBG5OVdWJpWkjuT+TaAB/IF
         p67J09KqgHwDb0UpMPQkQpBz9czIZX79tFT+cCSEtUq2K9icud0z4/Zn8KgQkSRcPssP
         0FUb9URr4xMqiNiitafx7SASicr1eh64MCSLQBunZrHFaZnkRjPBFZ8iEkHyWRkywsKW
         cLHOz7TMRWxFpOoAXy3Sy3i5uWtgt/dimowvC/OugzsDWJdqris41O6HmmTVM2wOVk6V
         HLplzClSYY2pTpUAAC3ooixRoClys6VDaxSDbG0lBS6H6Ek3qFDwhLwGckIH9NqqiCWN
         DNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FS66Oj11w6MDEI4rAEPsn2TlYuqzBpV411AM7ZB6FsQ=;
        b=AoLr6ql0q0rT4Nc4O+2LGF/g2CEKJNDDs5Mjh1loV0Le7/RoCUuzd9EsiKcXmz+ZbZ
         Sed0sPgd5GLv+QkavhpYIGZ3UYkAJBoJiAvkOa42azmiTqcNyUCPv6EeOxvuNRRFuBgc
         SICgnVyCQDq7Rwt1V8zB1eGe/oIrY9IKb+X4sn6gYl8NX+SEFubwDcDF/sXDzrYIwyRM
         hwFfVWic/773NZOxgqdYPOVB0O9/088NzovYzklWSriKrcO1zOZNrV0QTEk7Wq0GtSRW
         kzJJ1MkqckmaCG0wxi5gDedvJsrrOjKP6WdvKAfSw2XQ4Kkb4cN9mIPjtdueAaZc2ss4
         u2ig==
X-Gm-Message-State: AOAM530WFxzwjQuFnIs+8ywAIuG0xQgCSaO4CntZ95u/5nZtx+K4+q/u
        A1sL+xja1BcnMbnU0SBX+uw=
X-Google-Smtp-Source: ABdhPJwW2EQ62mEqtFDiymJuZi3mPDxbIp6q6bPnVvC+2v/YBF/u42PcoVpZZg8JjJCZKRtWEWsG0A==
X-Received: by 2002:a63:1804:0:b0:3db:2d5:3efc with SMTP id y4-20020a631804000000b003db02d53efcmr4297364pgl.250.1652256851472;
        Wed, 11 May 2022 01:14:11 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id 12-20020a170902e9cc00b0015e8d4eb29esm1062763plk.232.2022.05.11.01.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:14:11 -0700 (PDT)
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
Subject: [PATCH] EDAC: Fix some refcount leaks
Date:   Wed, 11 May 2022 12:14:02 +0400
Message-Id: <20220511081402.19784-1-linmq006@gmail.com>
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
 drivers/edac/edac_device_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 9a61d92bdf42..08cba532ad48 100644
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
+		goto edac_device_create_instance;
 	}
 
 	edac_dbg(4, "now register '%d' blocks for instance %d\n",
-- 
2.25.1

