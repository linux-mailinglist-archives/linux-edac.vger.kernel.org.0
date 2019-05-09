Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2015818FEB
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 20:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfEISJq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 May 2019 14:09:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37022 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfEISJm (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 May 2019 14:09:42 -0400
Received: from zn.tnic (p200300EC2F0F5F0071783F241746291C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:7178:3f24:1746:291c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C22721EC0AD6;
        Thu,  9 May 2019 20:09:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557425381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JwMkRTxoiqlJn/7FvK5jsS5V1iZPLhP9HooS4we8rVc=;
        b=H3BgNEcufOU9knusaQcZ4uo8g8JcO1pasAp30J9koyZdIng4RKPotKwDG3yZ07Ky0kPNgm
        vwatmlb6ySsaf1P+s4UeikDM9eMf/aRJKOjIo7YWq0Z++K6UR/TIUlPykRgFaB1JWEe/BI
        LK8KSB3giBWi/pRQXCggJSL96OTvJBc=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/11] RAS/CEC: Add copyright
Date:   Thu,  9 May 2019 20:09:26 +0200
Message-Id: <20190509180926.31932-12-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509180926.31932-1-bp@alien8.de>
References: <20190509180926.31932-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/ras/cec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index c4505c0893a7..5402e907ae7a 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017- Borislav Petkov, SUSE Labs.
+ */
 #include <linux/mm.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
-- 
2.21.0

