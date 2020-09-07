Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5413725FD36
	for <lists+linux-edac@lfdr.de>; Mon,  7 Sep 2020 17:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgIGPcx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Sep 2020 11:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730102AbgIGPcq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Sep 2020 11:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599492754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Jx39sfWEMhw3yDr9IheMM4E9cWZEdDmaYIX39EHEZnM=;
        b=P335Irnowg6ZU1+11+HllhzpP/yQFSEpwnOzFRj6SIIyHFIpHrWpUyqCB4CQpUCLmDJyzx
        AmG3INjLLPN6IWkelYz74xk3kduDSnVa+JjAqcnVJAC0XUWsLYaTtL5jmTccPAB2c6vrrV
        ont3pi6PylfK9+5PO23kt4AibdPezg0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-hRd9uAcvPJyyq2wLGFv2uA-1; Mon, 07 Sep 2020 11:32:32 -0400
X-MC-Unique: hRd9uAcvPJyyq2wLGFv2uA-1
Received: by mail-qv1-f72.google.com with SMTP id v14so1773372qvq.10
        for <linux-edac@vger.kernel.org>; Mon, 07 Sep 2020 08:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jx39sfWEMhw3yDr9IheMM4E9cWZEdDmaYIX39EHEZnM=;
        b=FxCeiF1U8P6TCJp0Ssm68jueld7y7VNe6N/MYoWK/Jla0inte1h+ItkTkMjTzHEIyz
         GzG/BFveLkn6cIP6u/CmJLdYMOnkXqp2QeA9tA+QtRbI0S3GPtoCNTtsZIwApZgxu7Hk
         bVMfzKvGPngcbQ+B4v8gj4jAJjE0wHH0HQDCPncbQ17DCuJEbTu2v+C1RPVX+M+hjEnR
         GMZx+FbWc4BD54qBi5ybH57Ij+gfHkI8Suj3gNo3VSz/cqyLA7a8CEiuKFqs+eNCf7eD
         QWuMFGaTRtDB1KZkQsznRk3YZgEBiKtstF+Z+ABdzkQ2D/YH/J40JeZ9p6w7kTQSYgf7
         W3+w==
X-Gm-Message-State: AOAM533uZpo+1RGuOyYcB9f31tPZjJtA434KmrPklvPRLOeaoHp37jGr
        7zfVg8LwIKgscmOzigxZ/HPnoEVKcikKo370M4fpfoUE8tzXS8N2mIAdKA6eOzJkakgyjFQ0OaM
        xSmq1kAcwOEOU+in/yB6eQw==
X-Received: by 2002:a37:a781:: with SMTP id q123mr6664207qke.436.1599492752077;
        Mon, 07 Sep 2020 08:32:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4XiUG7xnXgoW2XaQyu6f4KI5pGyBUvtb6wBvY8JCHhQfwcTR364I8VsYStslp0NVZLAImiA==
X-Received: by 2002:a37:a781:: with SMTP id q123mr6664170qke.436.1599492751534;
        Mon, 07 Sep 2020 08:32:31 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m64sm10888198qkd.80.2020.09.07.08.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 08:32:31 -0700 (PDT)
From:   trix@redhat.com
To:     tony.luck@intel.com, qiuxu.zhuo@intel.com, bp@alien8.de,
        mchehab@kernel.org, james.morse@arm.com, rric@kernel.org,
        natechancellor@gmail.com, ndesaulniers@google.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>
Subject: [PATCH] EDAC: sb_edac: simplify switch statement
Date:   Mon,  7 Sep 2020 08:32:25 -0700
Message-Id: <20200907153225.7294-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analyzer reports this problem

sb_edac.c:959:2: warning: Undefined or garbage value
  returned to caller
        return type;
        ^~~~~~~~~~~

This is a false positive.

However by initializing the type to DEV_UNKNOWN the 3 case can be
removed from the switch, saving a comparison and jump.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/edac/sb_edac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 68f2fe4df333..93daa4297f2e 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -939,12 +939,9 @@ static enum dev_type sbridge_get_width(struct sbridge_pvt *pvt, u32 mtr)
 
 static enum dev_type __ibridge_get_width(u32 mtr)
 {
-	enum dev_type type;
+	enum dev_type type = DEV_UNKNOWN;
 
 	switch (mtr) {
-	case 3:
-		type = DEV_UNKNOWN;
-		break;
 	case 2:
 		type = DEV_X16;
 		break;
-- 
2.18.1

