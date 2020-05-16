Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E781D628F
	for <lists+linux-edac@lfdr.de>; Sat, 16 May 2020 18:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgEPQVa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 16 May 2020 12:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgEPQVa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 16 May 2020 12:21:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F3AC061A0C
        for <linux-edac@vger.kernel.org>; Sat, 16 May 2020 09:21:30 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r10so2515959pgv.8
        for <linux-edac@vger.kernel.org>; Sat, 16 May 2020 09:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Cg0ycuIrMHsEZQFx/mNctoPUaSFNFnjiuqv1mZpAwt8=;
        b=EZTaR9K0R6l6MbzS2QBzzeWEwpjni9oRinDMbhPpA2dvtD33+EN0YbsEXbOkPyy8dx
         pEBJmXQWjEYqRFt7aqSPIq0T/7iD4E5SZ57B5WofFlICK4xlfaQAg9ouVY/uqKENZlHo
         DKKoB+F0m7ab/wQo0OTA23q2d5VYK2r0ikCcTxuahVKusaD4UKBcjFZGFme10mmvLrJ4
         NhDphXQ7PSLXDluuzaxFNSqyXFvn4A31u+OfmEs3TVB9RUGaPerobwo6FTjoPREbmLKY
         PJyoRCd/9TFJRyOp7jpgUcRGNHYIzpgMOeOm7kKk2RHMgYWOaIuNt6O1EuJMjTy7qXrU
         4LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cg0ycuIrMHsEZQFx/mNctoPUaSFNFnjiuqv1mZpAwt8=;
        b=VdznOsyhiuSYH5/jDjDs7FGLzabRvqYl9ZYux+uQS52JWGwF0PI/akTOEwlCHtLCMe
         LNT8+TBbN4z+hehd8Mh3gm6jzYCIaSc/AWC56qQKEdvB7A2+Q6iiTx0tCfcwmeZ5KonJ
         ZFhullE+esa6JtbC+oGsajT+ByJTUwLVtoUbzsucXvlT1cguTo1S7RekGI36qIC7hVbm
         rUlRX2F6irNj5IxulOXo2xz6ow5gUZ7zbKGAwqJLPXrqCxH38B407aEK/DFHsQEgki9X
         ZTN0a0se4+VTlcwxUGAsCf9LkFFLxeKpeBu8ON1TUzz56m8eDoaflz6OBT0KfOXWrOGN
         KpRQ==
X-Gm-Message-State: AOAM530K7tswrCbLfyf2UaWhtlRoUIyECI433HiBiOubjM2e0G0a1ATV
        b/nysvb4SVWsHz5cQHhRImAVxMq//yyrmA==
X-Google-Smtp-Source: ABdhPJwTuIOVuwoP2uFG8nVX6hovN/KOFAZhdDF3DQzHVW4nsYrQGoIyW5AGZOOAKAHMOzPEiOWnZg==
X-Received: by 2002:a65:6718:: with SMTP id u24mr7797300pgf.451.1589646089501;
        Sat, 16 May 2020 09:21:29 -0700 (PDT)
Received: from localhost.localdomain (p2438235-ipngn200604tokaisakaetozai.aichi.ocn.ne.jp. [221.113.241.235])
        by smtp.gmail.com with ESMTPSA id t5sm4020364pgp.80.2020.05.16.09.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 09:21:29 -0700 (PDT)
From:   wata2ki <wata2ki@gmail.com>
To:     linux-edac@vger.kernel.org
Cc:     Naoto Yamaguchi <i33399_YAMAGUCHI@aisin-aw.co.jp>
Subject: [PATCH] EDAC/mc: Fix memory alignment calculation formula
Date:   Sun, 17 May 2020 01:21:15 +0900
Message-Id: <20200516162115.16545-1-wata2ki@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Naoto Yamaguchi <i33399_YAMAGUCHI@aisin-aw.co.jp>

During the development of the off-tree driver, we found a bug that
causes alignment fault exception in mutex_lock.

Line of the code:
ffffffc010536ce4: c85ffe62 ldaxr x2, [x19]

Register value:
x19: ffffff800e90f6c4

This problem was caused by the alignment error of pvt_info
in struct mem_ctl_info.  It is caused by a calculation formula
error in edac_align_ptr.

Existing calculation formula is using variable p, but this
variable is address of the pointer variable not memory offset.
In this calculation formula should use *p.

Signed-off-by: Naoto Yamaguchi <i33399_YAMAGUCHI@aisin-aw.co.jp>
---
 drivers/edac/edac_mc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 drivers/edac/edac_mc.c

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
old mode 100644
new mode 100755
index 75ede27bdf6a..70929f136dd7
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -271,7 +271,7 @@ void *edac_align_ptr(void **p, unsigned int size, int n_elems)
 	else
 		return (char *)ptr;
 
-	r = (unsigned long)p % align;
+	r = (unsigned long)(*p) % align;
 
 	if (r == 0)
 		return (char *)ptr;
-- 
2.17.1

