Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712E8321CBC
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 17:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhBVQVX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 11:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhBVQVI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Feb 2021 11:21:08 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F15C06178C;
        Mon, 22 Feb 2021 08:20:13 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id n20so4386462ejb.5;
        Mon, 22 Feb 2021 08:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XZM02Qjnqqn9qJFAUKB25dGoRRDf53l7ATxy6Z9Woso=;
        b=R8k9FZItQ1mBUVjy9LxAWXhyIoj0naDvVWAktpGylajzQv9gy5KIPbWu+PplCLcgrN
         ZQw3bUelRCr2klfem4rjdCYyDRbl0p41Awk0gh4By7Ca3zRN0HiuSeFS4xArDiZ8u7+p
         SRNf997VXgkFFoTeowUY7P9jcoNS+rHickSaY/uB/J98qbZONi3MdrxxRFQTEdJSNRVj
         +EHTrCKksElXfIiDodnnsKyme+S+BPA1vJ3DOuu+4w9+qt/vaUHMq9OqeOlcE+TUHmBc
         v0wcuMrw2YxXHxN7GgF7SpSCLrGUpuJnDEDeq0J7MEMRQ7o0BZ7gg8OFTU/WbG2cVAAs
         gt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XZM02Qjnqqn9qJFAUKB25dGoRRDf53l7ATxy6Z9Woso=;
        b=aaMzzVRYS+LGNgZOgu+X3ym8rtbQWX9h1GNRuaWxCstAWHb12+dlGRjYfCsK2GjRo6
         BS5wRKbcajiZYoX2iVGkDJHdSr0gQlBOO21cz/HLTHTaiUWFY7fp5QUuFwDaF2dVFTPV
         d0iPvlmzH5By1lPEd2qUgDbIzOGcqn7yM0qb9pvTG/TU6NwuduI9LWtiyeDDAw6r6KJA
         ArUD/gMNQlZZZG50tF0bvPXn9a9f19NAhilbfoV+A5eZN/4lwnMBNC1mgK6ppIgPqwnj
         ke+hPUGQzeIwbLBw8pwoknwV5dLj7CrLIrqBk22X7RCX5sBpOvXS7mtZdIqBe+TTTh2X
         fWzg==
X-Gm-Message-State: AOAM533q+OhQor5RzQV4m2DWCpff90EOBXT9nCqw+G2ohPbl2MglcCc7
        SDz+k5tQlAat27Ii+D1Rd2E=
X-Google-Smtp-Source: ABdhPJxGDDSvMvOqmBDgE63DsNxIiNRSbDKEg5+ACbKT7OTbVFh8nbVLuFjMko9bmmTCdvcAbgoXdw==
X-Received: by 2002:a17:906:240c:: with SMTP id z12mr21457009eja.314.1614010812421;
        Mon, 22 Feb 2021 08:20:12 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d6b:2000:6504:2c93:2a67:f7e2])
        by smtp.gmail.com with ESMTPSA id i7sm67876ejf.59.2021.02.22.08.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:20:12 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 5/5] MIPS: SGI-IP27: fix spelling in Copyright
Date:   Mon, 22 Feb 2021 17:19:05 +0100
Message-Id: <20210222161905.1153-6-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This is a Copyright line, and just a typo slipped through.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/mips/sgi-ip27/ip27-timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 79c434fece52..444b5e0e935f 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copytight (C) 1999, 2000, 05, 06 Ralf Baechle (ralf@linux-mips.org)
- * Copytight (C) 1999, 2000 Silicon Graphics, Inc.
+ * Copyright (C) 1999, 2000, 05, 06 Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  */
 #include <linux/bcd.h>
 #include <linux/clockchips.h>
-- 
2.17.1

