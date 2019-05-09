Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B44118FF4
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 20:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfEISJi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 May 2019 14:09:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37022 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfEISJi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 May 2019 14:09:38 -0400
Received: from zn.tnic (p200300EC2F0F5F0071783F241746291C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:7178:3f24:1746:291c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E785F1EC0AB1;
        Thu,  9 May 2019 20:09:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557425377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5ByDPOBUc0dGUEPi3YpmHRs/lKsu+JOUCNfM/P9QXY=;
        b=KyhbofNLq+QPJLHJqM42+Grx6fk4bIVHKYHsRkpDcXQlwosmBYJ4QX0tpoQzZR/1lNBvuG
        ocLsXpoonVVH1vtwlXOpeDUvTbtTJJ6fAODwjHRG/98uyTLMJ3T/7a6VosrIqh0b8iKEZu
        wswWkwYLavbb54oMYw82MmfjZtTDKBk=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/11] RAS/CEC: Fix potential memory leak
Date:   Thu,  9 May 2019 20:09:21 +0200
Message-Id: <20190509180926.31932-7-bp@alien8.de>
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

Free the array page if a failure is encountered while creating the
debugfs nodes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---
 drivers/ras/cec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 667a126f39f1..8a04b9864192 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -504,8 +504,10 @@ void __init cec_init(void)
 		return;
 	}
 
-	if (create_debugfs_nodes())
+	if (create_debugfs_nodes()) {
+		free_page((unsigned long)ce_arr.array);
 		return;
+	}
 
 	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
 	schedule_delayed_work(&cec_work, CEC_DECAY_DEFAULT_INTERVAL);
-- 
2.21.0

