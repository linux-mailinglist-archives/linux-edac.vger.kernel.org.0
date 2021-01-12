Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940542F2CFC
	for <lists+linux-edac@lfdr.de>; Tue, 12 Jan 2021 11:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbhALKg3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Jan 2021 05:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbhALKg3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 12 Jan 2021 05:36:29 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33861C061575;
        Tue, 12 Jan 2021 02:35:49 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id t6so1195208plq.1;
        Tue, 12 Jan 2021 02:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2vW7UjS91mUgSCmEG/Sz0t6o0pp75oxqfzBwWXt7f2M=;
        b=SoH6pHGywNFf1A75/U8DCT2+4S3tWgBipSZUuoZ8HN2wMzlblTOqu6efEOVH90Sg+q
         G8tUmBR+DB8Ld5P5uby0QFProZjpocZ1kOvbncU6ZhJwlJceW5gcwDg97VTrOOCd/H2r
         0t31CBwifLGiNgePteRCJ/9O5nel1iW0S8D1/NQY8qCybV5wN85W8Rhid8gEumQWmx5x
         35tdH74ZVL+LXLCGjUHgjdvNd1wfjtUqR0liyvv/vhV3hDJlgWDGwKCKxAaFLalXiubU
         cVxTiBMr3QI2gwoIuZs7xhfzld60kPvsePUYYME4K3cVyfjCDK279ytsHFMZq3jloTkS
         GgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2vW7UjS91mUgSCmEG/Sz0t6o0pp75oxqfzBwWXt7f2M=;
        b=KAfrES6z9MsXWqr938FB5pqGfHojrj2+DbB538Ah2TDNDfWAiYEgBaCoy9WWak34iY
         GCRDfilY0/y/Yeo3HwVSvG4f5C1wNeeqAAFmFBu/YgjRAsj/kWmDK0JBsCdvZSLdnijA
         Up7h7DTjitCCt44KIe8/h45rmd4RkBDl1tftL3eK1gKwH1ck/sG4hXISaZmue9kmvw61
         tv5EZxKzHEwFZjNDX1YaVtgA78BI8cXdWxvqrICGwvKnaMigspLdwwft+S8CdS2QwFA2
         3MHBnW5Ejo3n+YDNza0Nqjj7kI3tIbe+9U9Xfv2hInkr9ySkx5Qc3NAwcs1Ye/a5kvuF
         77iQ==
X-Gm-Message-State: AOAM530aksEWXUu2K6K5hPS8CUlMPkrJOpqO7SJLlFZwMGP5vABBfyaG
        nfFSHG5iuPAXUYI3NFmbaNa+m5cJ/E4=
X-Google-Smtp-Source: ABdhPJzG8gTKskYQqV+qLikrI+rH8uIAciJ00vTZ9eOqaSRZRIEJD9MP5zlltbbjHvlAxC6vgb7DDA==
X-Received: by 2002:a17:902:aa84:b029:da:f114:6022 with SMTP id d4-20020a170902aa84b02900daf1146022mr4081933plr.46.1610447748703;
        Tue, 12 Jan 2021 02:35:48 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id y21sm2952435pfr.90.2021.01.12.02.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 02:35:48 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     rric@kernel.org
Cc:     khuong@os.amperecomputing.com, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: [PATCH v2] edac: remove redundant error print in xgene_edac_probe
Date:   Tue, 12 Jan 2021 02:35:40 -0800
Message-Id: <20210112103540.7818-1-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

Coccinelle reports a redundant error print in xgene_edac_probe.
As 'platform_get_irq' already prints the error message, error
print here is redundant.

Fix it by using 'platform_get_irq_optional' in place of
'platform_get_irq', as Robert suggested.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
v2:
- use 'platform_get_irq_optional' instead of 'platform_get_irq'
---
 drivers/edac/xgene_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 1d2c27a00a4a..2ccd1db5e98f 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -1916,7 +1916,7 @@ static int xgene_edac_probe(struct platform_device *pdev)
 		int i;
 
 		for (i = 0; i < 3; i++) {
-			irq = platform_get_irq(pdev, i);
+			irq = platform_get_irq_optional(pdev, i);
 			if (irq < 0) {
 				dev_err(&pdev->dev, "No IRQ resource\n");
 				rc = -EINVAL;
-- 
2.17.1

