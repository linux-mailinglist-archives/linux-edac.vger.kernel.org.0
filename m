Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C362F2A45
	for <lists+linux-edac@lfdr.de>; Tue, 12 Jan 2021 09:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbhALIqx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Jan 2021 03:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbhALIqx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 12 Jan 2021 03:46:53 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1500C061575;
        Tue, 12 Jan 2021 00:46:12 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id y8so1028392plp.8;
        Tue, 12 Jan 2021 00:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5MzOeP1zfz/WdP9lvNJMHITkRL1UiA/nK4tpRADtWd0=;
        b=CO7mLds4cDwR++yPvTUgvQYoT90YJA5KBGyjTSmX3XlPwSjocOmeR7TxT4pX/vcUhl
         MV0MWVE1ZbeSRp/YTfdRHiXBguILL1FzyyxUXRrck2oEqbdGfTJbQ6EOY4rKZl7WaoPo
         SuqiDHkznjDyMC3BeMP9NdVhZs//ZV2vWvcPZbNPizC+aIS2LnkvFk5korvBGBI8jLLe
         XYIOfRS2JUnxz5vhAZ4DavVpNffzdwxE1MS34y5DoCFyayi6044FzHFcqZWexqc4IsP6
         ML7LAj7zBMiglN7SqJOkGaNny7JkVHjpslT4tPaT00DQODdr0bdfhl0kwNvnpBvBQ/g6
         wzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5MzOeP1zfz/WdP9lvNJMHITkRL1UiA/nK4tpRADtWd0=;
        b=VkbH/KCSUrq7JLI5j7ONc3qqPI0mzI4cOTmHyJ2iYagZeGQ95Bt5tz/os73rS+qS/E
         V2oQtlbrhO1Yzahiy7oc8S7cXFb0PfowO99gKdIYjIMzkd2SvJPu1I8oDIFn9CXF3DIs
         Ym7Fxp4txLlkJwK2QaD4fvmiSt2TP274TJmDHK2CpxF8lP7GVhkr3QB7RRSbzUqZXHge
         /kbMX//3hvv36UbFCkyGDH1RARodRuH/NWbVi2tkGFr0uhZrJUpqdxTS8ibO1kU0Hcr5
         nrSZi+42YfwBBJyrNCUqT1jmfnliQcBZhUh9snA4BxNYApJhWyVX0/9MI0F1pjPA4Vyl
         7oEA==
X-Gm-Message-State: AOAM531p5Iz8706OpYfclEYRpCJif/Kc2evCAs7l0pOskRCSy7MvZu5a
        CwlC+Q83Jtde3n3xQ+/Dx18=
X-Google-Smtp-Source: ABdhPJyO9BUCAKi7M9PYXenkwfepNN65oJyGr2ShXUYjI9/mo4kChGAYl4eE3+4nHSWOPTzY1U4k8g==
X-Received: by 2002:a17:90a:a10e:: with SMTP id s14mr3359511pjp.133.1610441172441;
        Tue, 12 Jan 2021 00:46:12 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id n195sm2234734pfd.169.2021.01.12.00.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:46:11 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     khuong@os.amperecomputing.com
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: [PATCH] edac: remove redundant error print in xgene_edac_probe
Date:   Tue, 12 Jan 2021 00:46:05 -0800
Message-Id: <20210112084605.7110-1-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

Coccinelle reports a redundant error print in xgene_edac_probe.
As 'platform_get_irq' already prints the error message, error
print here is redundant and can be removed.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 drivers/edac/xgene_edac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 1d2c27a00a4a..1d583f0ea4dc 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -1918,7 +1918,6 @@ static int xgene_edac_probe(struct platform_device *pdev)
 		for (i = 0; i < 3; i++) {
 			irq = platform_get_irq(pdev, i);
 			if (irq < 0) {
-				dev_err(&pdev->dev, "No IRQ resource\n");
 				rc = -EINVAL;
 				goto out_err;
 			}
-- 
2.17.1

