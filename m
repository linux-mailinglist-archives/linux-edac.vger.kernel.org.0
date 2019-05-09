Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40C4118FFD
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 20:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfEISJf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 May 2019 14:09:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36934 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbfEISJe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 May 2019 14:09:34 -0400
Received: from zn.tnic (p200300EC2F0F5F0071783F241746291C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:7178:3f24:1746:291c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0E02F1EC0AD6;
        Thu,  9 May 2019 20:09:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557425372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CTSWferuopSTk+5bTEvUe/yp4XGUgbHDYYkqAF/AO24=;
        b=GOaoKn77S673U0thLhtlvQe99BzeJQkI2AyvIcdiOlj/iUi86lXVi9Tmw6hcK9tyHEVCL6
        7SXUUpPeqF4dd/DliDgQkzNrMUFBKqG0B41eHVaLbrmotYri3SryWH20sgJqi37wf4MKUr
        kLw8p/MS4CU0ruKns+nLD7bkEZ2HD8M=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/11] RAS/CEC: Fix binary search function
Date:   Thu,  9 May 2019 20:09:16 +0200
Message-Id: <20190509180926.31932-2-bp@alien8.de>
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

Switch to using Donald Knuth's binary search algorithm (The Art of
Computer Programming, vol. 3, section 6.2.1). This should've been done
from the very beginning but the author must've been smoking something
very potent at the time.

The problem with the current one was that it would return the wrong
element index in certain situations:

  https://lkml.kernel.org/r/CAM_iQpVd02zkVJ846cj-Fg1yUNuz6tY5q1Vpj4LrXmE06dPYYg@mail.gmail.com

and the noodling code after the loop was fishy at best.

So switch to using Knuth's binary search. The final result is much
cleaner and straightforward.

Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: <stable@vger.kernel.org>
---
 drivers/ras/cec.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 88e4f3ff0cb8..dbfe3e61d2c2 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -183,32 +183,38 @@ static void cec_timer_fn(struct timer_list *unused)
  */
 static int __find_elem(struct ce_array *ca, u64 pfn, unsigned int *to)
 {
+	int min = 0, max = ca->n - 1;
 	u64 this_pfn;
-	int min = 0, max = ca->n;
 
-	while (min < max) {
-		int tmp = (max + min) >> 1;
+	while (min <= max) {
+		int i = (min + max) >> 1;
 
-		this_pfn = PFN(ca->array[tmp]);
+		this_pfn = PFN(ca->array[i]);
 
 		if (this_pfn < pfn)
-			min = tmp + 1;
+			min = i + 1;
 		else if (this_pfn > pfn)
-			max = tmp;
-		else {
-			min = tmp;
-			break;
+			max = i - 1;
+		else if (this_pfn == pfn) {
+			if (to)
+				*to = i;
+
+			return i;
 		}
 	}
 
+	/*
+	 * When the loop terminates without finding @pfn, min has the index of
+	 * the element slot where the new @pfn should be inserted. The loop
+	 * terminates when min > max, which means the min index points to the
+	 * bigger element while the max index to the smaller element, in-between
+	 * which the new @pfn belongs to.
+	 *
+	 * For more details, see exercise 1, Section 6.2.1 in TAOCP, vol. 3.
+	 */
 	if (to)
 		*to = min;
 
-	this_pfn = PFN(ca->array[min]);
-
-	if (this_pfn == pfn)
-		return min;
-
 	return -ENOKEY;
 }
 
-- 
2.21.0

