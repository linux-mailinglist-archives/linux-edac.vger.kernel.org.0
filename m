Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAA01F4E7B
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jun 2020 08:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgFJG6O (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Jun 2020 02:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgFJG6O (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Jun 2020 02:58:14 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFEEC03E96B;
        Tue,  9 Jun 2020 23:58:13 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 23so685337pfw.10;
        Tue, 09 Jun 2020 23:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=r3H+L43taGseRC/CurkGgYqQKiqJEfVk1rlaC8npJIE=;
        b=RX4Ntyl+nZEuVvGjjAr4FIViMs4J9FPW+jdx7fgnPo2qVWsBxBLuqfMeZIdTAvHlBn
         pi6d7xlIRVXre+iRxUrEkwaWJUYmUvvsScijGMQgnrQPA5vcWpMZpb92h2cJGq96+QaU
         hWr/he/D4o6n0dUZ2leMlPQZvXdrKDY5MN65RgCWZmsZnzLnLf9rXsSuq62mKCIRDjcf
         Mo1zElwb6Xp4Wfve+PhS3akCU/YK/WGRKFgBZ0wFnajXaDNn8XyTLhKZ+PKDjgag2bDA
         kNKflag5LdDTVpzDe869ZzlTRRibOqmTYMQFQ9tE6gbqpbYr61KA4Y3s1ZipXkdTRno1
         E2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r3H+L43taGseRC/CurkGgYqQKiqJEfVk1rlaC8npJIE=;
        b=MiM5k7dMg4IhELrUrvUkVoRqcd3NF3kYCcyPNj6lY34eW2sjX5Bd8alfvnkTR2D00B
         UVoQ8lm9Abfst8ktMRa1ne1K8+lX0getjAJLZ4MY6PvV81L94/eiV4ILurXhNORSXcNY
         bFwiWeAivkQLNhK3vnR4b4DpUeTZfhOBLeX87dEDynGtao41hLOZ50b5pcB4wRhbcaNd
         a0lwIS1r146zF8HHY6FkUvQ/pfy1oKdh6m3euxRZwPkarTX+siiQKSyKqBbD7xwncx4T
         Z6gtAAZLseoqd0PgcBk6DzPNI8lIClYnujxUNefpWEXDMIOnWr5hizGQFJG9ekGmE5GL
         SV+g==
X-Gm-Message-State: AOAM533rs6VdZfAWSE/FzI4rETV6M2VRMpVEDqXSjQmN/KVu2qtE/sjs
        4aCIxptmv5dwlkz1agrS6DroILIf
X-Google-Smtp-Source: ABdhPJxT2FVLyk+BQOCYdJDSGVCvd0yMzwzZ4tM7rdRRGEsWlzFtuY8Wt8VlMA1nw4LWZOB1IdARKw==
X-Received: by 2002:a63:f00d:: with SMTP id k13mr1529198pgh.263.1591772292847;
        Tue, 09 Jun 2020 23:58:12 -0700 (PDT)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id z186sm11803481pfb.131.2020.06.09.23.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 23:58:11 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Cc:     tony.luck@intel.com, bp@alien8.de, mchehab@kernel.org,
        james.morse@arm.com, rrichter@marvell.com,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH] EDAC, {skx,i10nm}: Advice mcelog that the error were handled
Date:   Wed, 10 Jun 2020 14:58:01 +0800
Message-Id: <20200610065801.3579-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

If one MCE error has been processed in kernel, it's not necessory
to pass it to user level mcelog.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 drivers/edac/skx_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 46be1a7..8c0165b 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -615,7 +615,8 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 
 	skx_mce_output_error(mci, mce, &res);
 
-	return NOTIFY_DONE;
+	/* Advice mcelog that the error were handled */
+	return NOTIFY_STOP;
 }
 
 void skx_remove(void)
-- 
1.8.3.1

