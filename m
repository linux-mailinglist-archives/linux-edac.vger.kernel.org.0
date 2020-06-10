Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251131F4E7F
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jun 2020 08:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgFJG7E (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Jun 2020 02:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFJG7D (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Jun 2020 02:59:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F001EC03E96B;
        Tue,  9 Jun 2020 23:59:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so608760plr.0;
        Tue, 09 Jun 2020 23:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vRsVZdxVChzNJb9Z5j+bcaBi3tL1n0C5lCdP2Lf/NZ8=;
        b=O5iZC/alEUVKVGDA0/rkEARQFAsb5kuo0Mv7VbbMmm6GYEWg/dKJv3A7sQrCxjhqiE
         QRFwBGqU5dzXyCchqLg787rMvWCGTzDgqW9wz9LLiRx8Qm/QDlDz6RE2lcYGNZwLKGhH
         vnS5nEucUHZmU80fXNNBsloivojYbJQmeeaOhMu+rZL1+h4ltWGGQZrWpov6Ehwdipw5
         H1QSb7xf4AEPERDMeBzo8X8pKsSDewH3ltR2mr8P82N48RrHtEgO+W+At8ZGdsBe49OC
         cuwLzpUO008Uf9dwCFgZD/bte5Q104NmSfDtQAsy4V8/jvjqm84bN5+kcPtLkTrXeoJk
         xCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vRsVZdxVChzNJb9Z5j+bcaBi3tL1n0C5lCdP2Lf/NZ8=;
        b=pXSWa78GADa1X2NeHD9InFKzG6CRmdrkhDb0QBVDBH2utc1+82mDSbfJ6HWvpTtmyy
         Gtp1dTjxM/7pEuqir+X/c5FgwlmeIp/76eU4A10BLsNDUzI+nnrqCmeSOhivQPN4Bb3Z
         cteJ9phDE2JQlymGgQyNodS3zVw+RMsRET1/VH1JRtgVTHBDK8QR6cqsLhEtHedFud8/
         4L34HX31GU3DmRtXc+qavA8UuhiqB39kSHzxqnmwArEFkXi8BbP0mvfRupLVVfA0rFsI
         ZVCB/arIas3L7sZ7T2LSQqw1AWdsV3jNpNqs5jcz+EmczteJNlgFkdK578tvqrdpIb8A
         l2GA==
X-Gm-Message-State: AOAM533rRf0CMSeB5JrJ3Dlzc4Lh4K1+mez62ecvRn+/j5dfSnOjrz6W
        KjmDPlsK1QkMMhUOXU7CJEuhL8Ex
X-Google-Smtp-Source: ABdhPJxZdcu8bXlQbSphOj5gIIoIsWc/lIo7+f6XUAxq1qltZ1/3LieeMJX/Oi2YUYI3BTL839wmVg==
X-Received: by 2002:a17:90a:a005:: with SMTP id q5mr1641452pjp.219.1591772341211;
        Tue, 09 Jun 2020 23:59:01 -0700 (PDT)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id v9sm11948108pfe.198.2020.06.09.23.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 23:59:00 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Cc:     tony.luck@intel.com, bp@alien8.de, mchehab@kernel.org,
        james.morse@arm.com, rrichter@marvell.com,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH] EDAC/mc: call edac_inc_ue_error() before panic
Date:   Wed, 10 Jun 2020 14:58:46 +0800
Message-Id: <20200610065846.3626-2-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200610065846.3626-1-zhenzhong.duan@gmail.com>
References: <20200610065846.3626-1-zhenzhong.duan@gmail.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

By calling edac_inc_ue_error() before panic, we get a correct UE error
count for core dump analysis.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 drivers/edac/edac_mc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 75ede27..c1f23c2 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1011,6 +1011,8 @@ static void edac_ue_error(struct edac_raw_error_desc *e)
 			e->other_detail);
 	}
 
+	edac_inc_ue_error(e);
+
 	if (edac_mc_get_panic_on_ue()) {
 		panic("UE %s%son %s (%s page:0x%lx offset:0x%lx grain:%ld%s%s)\n",
 			e->msg,
@@ -1020,8 +1022,6 @@ static void edac_ue_error(struct edac_raw_error_desc *e)
 			*e->other_detail ? " - " : "",
 			e->other_detail);
 	}
-
-	edac_inc_ue_error(e);
 }
 
 static void edac_inc_csrow(struct edac_raw_error_desc *e, int row, int chan)
-- 
1.8.3.1

