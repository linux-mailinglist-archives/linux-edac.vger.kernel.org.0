Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDFD7429EC
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jun 2023 17:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjF2Pwv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Jun 2023 11:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjF2Pwu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 29 Jun 2023 11:52:50 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C6C10FB
        for <linux-edac@vger.kernel.org>; Thu, 29 Jun 2023 08:52:49 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7658430eb5dso83543085a.2
        for <linux-edac@vger.kernel.org>; Thu, 29 Jun 2023 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688053968; x=1690645968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KbOAeIQ6DXucGSUgDE02AQfyCTSVZzRN2eZjgr9alc=;
        b=VZ9vuDew2thoO3pg0sQbv+qjBrAnUl8sTU3F4n2UcjJ90jcVeoqf27QV3Wq8JMQeC8
         s+Fxm5/zrDR58zCCKfvVI9WFHlnPQ4yV6icpANPI9G0LhEmJVcXpNxL9IjDtXMtUzq7A
         ffHx4oNV2P2AoP7gKqFbVisx03RekIvuG9lPIBhIOGiJ+guHpRQmx5Rv7DbFJfOmvbnB
         fQkQp3tr7VmhfEI0ReSAs6xFKWbhBij4WSUImHDenl0+29ffhXs2Wp8DJQ1njoopULQG
         ypzyffCWH3kXrHG5sZqYUX2ZwNsUTqUo46wi3vC+yOx62GgdWolfjpUGd2xcoaEuuWWW
         BbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688053968; x=1690645968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KbOAeIQ6DXucGSUgDE02AQfyCTSVZzRN2eZjgr9alc=;
        b=bq+bmt2hWhDz+Shg3AGd53zzFc0Mt27IG1b6GfLglayQT7jW3+3syLK18QsGfPsayX
         HZ7gx6AmTgeNL7sygST4S4GwhC+f4TIODIiJJJCL9EBjoyMZwM0BRhubxKNkh4JLcfWw
         2RV07aii2tkm/L77j5wbVUr7ZUKJUpTfNNl8dYUkTC95Pt233glfVs6m/opZoJtm9z8a
         HOfDUmiZCtv2iA2vjzbAR93lyABZTmI7S2ffzHCG0WwCrPuT2g7aR7xBLENgcAXfT0V4
         14VCS2B60pNFbqApDkF6F09LxGilqEoTQe/5AZgGj75ciF7BpaPHxvH/Lc5nGTHzuYq1
         KJTQ==
X-Gm-Message-State: AC+VfDxsFSvYh+801POmIk/Y4qmyty4lCIlN0M0gvPHEKPyNnP6ugH05
        CkfQ7zhUEHLZRZBLLNOTirE=
X-Google-Smtp-Source: ACHHUZ64yHqGZcX1w2aeFDan9RmSDbueE26E9ptPozMTdo9XalR5fq6kJUI2MxVFZyszXGw9PkFx6Q==
X-Received: by 2002:a05:620a:3950:b0:767:3cfa:dbee with SMTP id qs16-20020a05620a395000b007673cfadbeemr1381455qkn.19.1688053968032;
        Thu, 29 Jun 2023 08:52:48 -0700 (PDT)
Received: from chcpu17.cse.ust.hk (fc3kcs10.cse.ust.hk. [143.89.191.124])
        by smtp.googlemail.com with ESMTPSA id dy7-20020a05620a60c700b0076741e4b3fbsm11208qkb.25.2023.06.29.08.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:52:47 -0700 (PDT)
From:   Yiyuan Guo <yguoaz@gmail.com>
To:     shubhrajyoti.datta@amd.com, sai.krishna.potthuri@amd.com
Cc:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, michal.simek@amd.com,
        linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        yguoaz@gmail.com
Subject: [PATCH v2] EDAC/zynqmp: Fix an off-by-one buffer overrun in inject_ue_write
Date:   Thu, 29 Jun 2023 23:51:22 +0800
Message-Id: <20230629155122.539186-1-yguoaz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230629113933.4112456-1-yguoaz@gmail.com>
References: <20230629113933.4112456-1-yguoaz@gmail.com>
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

inject_ue_write() may access a local buffer `buf` at index
`len = sizeof(buf)`. Fix the length value to avoid buffer overrun.

Signed-off-by: Yiyuan Guo <yguoaz@gmail.com>
---
 drivers/edac/zynqmp_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
index ac7d1e0b324c..bd9c1ff4b5e9 100644
--- a/drivers/edac/zynqmp_edac.c
+++ b/drivers/edac/zynqmp_edac.c
@@ -304,7 +304,7 @@ static ssize_t inject_ue_write(struct file *file, const char __user *data,
 	if (!data)
 		return -EFAULT;
 
-	len = min_t(size_t, count, sizeof(buf));
+	len = min_t(size_t, count, sizeof(buf) - 1);
 	if (copy_from_user(buf, data, len))
 		return -EFAULT;
 
-- 
2.25.1

