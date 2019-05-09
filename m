Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F3118FE8
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 20:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfEISJk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 May 2019 14:09:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36996 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbfEISJj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 May 2019 14:09:39 -0400
Received: from zn.tnic (p200300EC2F0F5F0071783F241746291C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:7178:3f24:1746:291c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D41991EC0AD6;
        Thu,  9 May 2019 20:09:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557425378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6NBEV9BeF0WJjeYV/KCbq9/oLFy7kPe37cf7ajjJg0Q=;
        b=qHLCLB8EAY9A2RIjB2OvgoZHvniqocd5v2O/3C7m8483GKNwAHSrVNNbA3nlbm9k+g09zn
        KJMaifWmZTyTy7Hp2XTpAra4/OBjADwXfiwIzx3NOd476Ux5OnnR694PZsq2p0pxdBNivt
        FYpIxrgzYynWoBZMBYIn8BrfeHjT9Sw=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/11] RAS/CEC: Sanity-check array on every insertion
Date:   Thu,  9 May 2019 20:09:22 +0200
Message-Id: <20190509180926.31932-8-bp@alien8.de>
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

Check the elements order in the array after every insertion.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---
 drivers/ras/cec.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 8a04b9864192..2c92a70fa2f0 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -276,11 +276,39 @@ static u64 __maybe_unused del_lru_elem(void)
 	return pfn;
 }
 
+static bool sanity_check(struct ce_array *ca)
+{
+	bool ret = false;
+	u64 prev = 0;
+	int i;
+
+	for (i = 0; i < ca->n; i++) {
+		u64 this = PFN(ca->array[i]);
+
+		if (WARN(prev > this, "prev: 0x%016llx <-> this: 0x%016llx\n", prev, this))
+			ret = true;
+
+		prev = this;
+	}
+
+	if (!ret)
+		return ret;
+
+	pr_info("Sanity check dump:\n{ n: %d\n", ca->n);
+	for (i = 0; i < ca->n; i++) {
+		u64 this = PFN(ca->array[i]);
+
+		pr_info(" %03d: [%016llx|%03llx]\n", i, this, FULL_COUNT(ca->array[i]));
+	}
+	pr_info("}\n");
+
+	return ret;
+}
 
 int cec_add_elem(u64 pfn)
 {
 	struct ce_array *ca = &ce_arr;
-	unsigned int to;
+	unsigned int to = 0;
 	int count, ret = 0;
 
 	/*
@@ -345,6 +373,8 @@ int cec_add_elem(u64 pfn)
 	if (ca->decay_count >= CLEAN_ELEMS)
 		do_spring_cleaning(ca);
 
+	WARN_ON_ONCE(sanity_check(ca));
+
 unlock:
 	mutex_unlock(&ce_mutex);
 
@@ -402,7 +432,6 @@ DEFINE_DEBUGFS_ATTRIBUTE(count_threshold_ops, pfn_get, count_threshold_set, "%ll
 static int array_dump(struct seq_file *m, void *v)
 {
 	struct ce_array *ca = &ce_arr;
-	u64 prev = 0;
 	int i;
 
 	mutex_lock(&ce_mutex);
@@ -412,10 +441,6 @@ static int array_dump(struct seq_file *m, void *v)
 		u64 this = PFN(ca->array[i]);
 
 		seq_printf(m, " %03d: [%016llx|%03llx]\n", i, this, FULL_COUNT(ca->array[i]));
-
-		WARN_ON(prev > this);
-
-		prev = this;
 	}
 
 	seq_printf(m, "}\n");
-- 
2.21.0

