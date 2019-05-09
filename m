Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98CE18FFC
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 20:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEISK0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 May 2019 14:10:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36986 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfEISJf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 May 2019 14:09:35 -0400
Received: from zn.tnic (p200300EC2F0F5F0071783F241746291C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:7178:3f24:1746:291c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0AA5E1EC0AB1;
        Thu,  9 May 2019 20:09:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557425374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQIw58k+eEPmTVMVyeW+llFdInLpPxrAvnDisAsfgsM=;
        b=dV8VBoqbv/fffXxyP+w7pMlz5cf/6yFSRqzGbOdIpKZNu/BTMg6PbQPmeK28I4i+rAv2gP
        IhZAd38eUJRqOH0plBA31zPPQ2j0aqj3rnlCPsYl2Hl3BGiTyAVMiCfsQMB2qKbSqeSjyL
        wh2lHU6HUU8mCKAruyLSEFsAvQCCsKY=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/11] RAS/CEC: Fix pfn insertion
Date:   Thu,  9 May 2019 20:09:18 +0200
Message-Id: <20190509180926.31932-4-bp@alien8.de>
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

When inserting random PFNs for debugging the CEC through
(debugfs)/ras/cec/pfn, depending on the return value of pfn_set(),
multiple values get inserted per a single write.

That is because simple_attr_write() interprets a retval of 0 as
success and claims the whole input. However, pfn_set() returns the
cec_add_elem() value, which, if > 0 and smaller than the whole input
length, makes glibc continue issuing the write syscall until there's
input left:

  pfn_set
  simple_attr_write
  debugfs_attr_write
  full_proxy_write
  vfs_write
  ksys_write
  do_syscall_64
  entry_SYSCALL_64_after_hwframe

leading to those repeated calls.

Return 0 to fix that.

Rename u64_get() to pfn_get() while at it.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---
 drivers/ras/cec.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 673f8a128397..1275907ff21c 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -358,7 +358,7 @@ int cec_add_elem(u64 pfn)
 	return ret;
 }
 
-static int u64_get(void *data, u64 *val)
+static int pfn_get(void *data, u64 *val)
 {
 	*val = *(u64 *)data;
 
@@ -369,10 +369,12 @@ static int pfn_set(void *data, u64 val)
 {
 	*(u64 *)data = val;
 
-	return cec_add_elem(val);
+	cec_add_elem(val);
+
+	return 0;
 }
 
-DEFINE_DEBUGFS_ATTRIBUTE(pfn_ops, u64_get, pfn_set, "0x%llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(pfn_ops, pfn_get, pfn_set, "0x%llx\n");
 
 static int decay_interval_set(void *data, u64 val)
 {
@@ -389,7 +391,7 @@ static int decay_interval_set(void *data, u64 val)
 	cec_mod_work(decay_interval);
 	return 0;
 }
-DEFINE_DEBUGFS_ATTRIBUTE(decay_interval_ops, u64_get, decay_interval_set, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(decay_interval_ops, pfn_get, decay_interval_set, "%lld\n");
 
 static int count_threshold_set(void *data, u64 val)
 {
@@ -402,7 +404,7 @@ static int count_threshold_set(void *data, u64 val)
 
 	return 0;
 }
-DEFINE_DEBUGFS_ATTRIBUTE(count_threshold_ops, u64_get, count_threshold_set, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(count_threshold_ops, pfn_get, count_threshold_set, "%lld\n");
 
 static int array_dump(struct seq_file *m, void *v)
 {
-- 
2.21.0

