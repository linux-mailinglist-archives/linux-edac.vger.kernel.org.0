Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F53586272
	for <lists+linux-edac@lfdr.de>; Mon,  1 Aug 2022 04:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiHACQT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 31 Jul 2022 22:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbiHACQS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 31 Jul 2022 22:16:18 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC66958F;
        Sun, 31 Jul 2022 19:16:16 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 23so8499163pgc.8;
        Sun, 31 Jul 2022 19:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JIn2GWvM3WCNE9+dcOpFb//gXNdJoLXEzvj09Elf1xM=;
        b=KcxqRT09HbnROY9QUvt/VjDGKk5pYxPfAwG9O/F1v9VxtP9/4xE9sn9uVZFLdmuKEh
         VgQYPRgMu4qSL4nG3yhWoo6ogYjXnv0BBa82FWdSAbMYV5PrrXqOurFmslluEECLwtGn
         fGx69++8mkOGi9n0smXkiIv//9Z2YV0dSIYOze/QodYmuBPOOQMvGTJUIM+erMLamoll
         5MNXMJVd3HJ1RHNWxhoGSSbCOknYAq3tKHK74679lmgOrpCFs1WfIlqohkIhFS513qIV
         HwUf4H3lLYRqhN6Gwa6B9y/m5ULFBa02s/N0IkKnMmlwqRefe2j8g/Tqk35ztNj5R/6t
         DM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JIn2GWvM3WCNE9+dcOpFb//gXNdJoLXEzvj09Elf1xM=;
        b=Vk2bCWjcc12e2y4Vkw/9XP0MSJnTa/hALnxLlG/Na9K9uY/9oNkpbVi3aseEJbOobH
         BY0SGrVRJhqXKJdyQmthnkTvPBCb5spgFoDjhEXMZ8MZ8b6PjJC0qQeuHijk4Nr7xvmA
         +sbl3xsWHBKoqgblevNvcUGcnlpkWTNlL35+5qd3aBBMhqPn1l6IQWMZIDdewrV5LAiO
         zydcjo7kj3sXGTFj86PIHt91Xnb6PPgevSokYIpnnmNGCwB2rHDUdWFW/40nlx82AVjX
         6HIcw99Zi+v9hYYD1Z0fsh4b5o/mXQq0tyiRETaudrScH/IOVH5gEpEEr7isGwoRHrt9
         PBTQ==
X-Gm-Message-State: ACgBeo0YhBy4+MHFc1Cs1jMi2mbGoA1M8njfB9HTwfZCWDR+hvJ9uUHq
        uXzFkUWc4qWsrWBM5j6GLNWrjg8hUbU=
X-Google-Smtp-Source: AA6agR43VuJYy4NIipL8s4zZS4RqROxV+xdW2QRjGGdr21oIh3B2B+TQa/VZlgP+Z3x1WyyeX+rjXw==
X-Received: by 2002:a63:6406:0:b0:41b:f291:2cbf with SMTP id y6-20020a636406000000b0041bf2912cbfmr4445581pgb.96.1659320176052;
        Sun, 31 Jul 2022 19:16:16 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ik15-20020a170902ab0f00b00168dadc7354sm8114181plb.78.2022.07.31.19.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:16:15 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     linux-edac@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] EDAC:wq:Remove the redundant 'flush_workqueue()' calls
Date:   Mon,  1 Aug 2022 02:16:09 +0000
Message-Id: <20220801021609.1593880-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

calls 'destroy_workqueue()' already drains the queue 
before destroying it, so there is no need to flush it 
explicitly.So,remove the redundant  'flush_workqueue()'
calls.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/edac/wq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/wq.c b/drivers/edac/wq.c
index d021d287eaec..ad3f516627c5 100644
--- a/drivers/edac/wq.c
+++ b/drivers/edac/wq.c
@@ -37,7 +37,6 @@ int edac_workqueue_setup(void)
 
 void edac_workqueue_teardown(void)
 {
-	flush_workqueue(wq);
 	destroy_workqueue(wq);
 	wq = NULL;
 }
-- 
2.25.1
