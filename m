Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8D97033B3
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241879AbjEOQkl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 12:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242881AbjEOQkg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 12:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBBF170C;
        Mon, 15 May 2023 09:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C6566287A;
        Mon, 15 May 2023 16:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EFBC433D2;
        Mon, 15 May 2023 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168834;
        bh=CcNRIHoQon4UbB5J5qZeKiIBNv/kTAdr7r1q7AaNHDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YT0k6a06o6HwLYyAJKvm7S4Vk+PdiPHveJjdpSbUgej2lMh2ftXh0N+zzug7Lp/Vj
         mZd3bTq4ZbJiDywN+xE5kI7ofJ903tAOIGyPmvnuQ72a9udJLoAs1E39pIbROZAPSY
         r2tmV98IB7orSdwpuKi+dWo91RQdAr5nt+ks55og=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        arozansk@redhat.com, linux-edac <linux-edac@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 4.19 028/191] EDAC, skx: Move debugfs node under EDACs hierarchy
Date:   Mon, 15 May 2023 18:24:25 +0200
Message-Id: <20230515161708.196893993@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

[ Upstream commit 85b9c8bfee67ed151c44861c71adc816fc1b46a9 ]

The debugfs node is /sys/kernel/debug/skx_edac_test. Rename it and move
under EDAC debugfs root directory. Remove the unused 'skx_fake_addr' and
remove the 'skx_test' on error.

Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: arozansk@redhat.com
CC: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/1542353684-13496-1-git-send-email-qiuxu.zhuo@intel.com
Stable-dep-of: 71b1e3ba3fed ("EDAC/skx: Fix overflows on the DRAM row address mapping arrays")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/skx_edac.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/skx_edac.c b/drivers/edac/skx_edac.c
index dd209e0dd9abb..b97803580d70f 100644
--- a/drivers/edac/skx_edac.c
+++ b/drivers/edac/skx_edac.c
@@ -896,12 +896,11 @@ static bool skx_decode(struct decoded_addr *res)
 
 #ifdef CONFIG_EDAC_DEBUG
 /*
- * Debug feature. Make /sys/kernel/debug/skx_edac_test/addr.
- * Write an address to this file to exercise the address decode
- * logic in this driver.
+ * Debug feature.
+ * Exercise the address decode logic by writing an address to
+ * /sys/kernel/debug/edac/skx_test/addr.
  */
 static struct dentry *skx_test;
-static u64 skx_fake_addr;
 
 static int debugfs_u64_set(void *data, u64 val)
 {
@@ -912,19 +911,19 @@ static int debugfs_u64_set(void *data, u64 val)
 
 	return 0;
 }
-
 DEFINE_SIMPLE_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
 
-static struct dentry *mydebugfs_create(const char *name, umode_t mode,
-				       struct dentry *parent, u64 *value)
-{
-	return debugfs_create_file(name, mode, parent, value, &fops_u64_wo);
-}
-
 static void setup_skx_debug(void)
 {
-	skx_test = debugfs_create_dir("skx_edac_test", NULL);
-	mydebugfs_create("addr", S_IWUSR, skx_test, &skx_fake_addr);
+	skx_test = edac_debugfs_create_dir("skx_test");
+	if (!skx_test)
+		return;
+
+	if (!edac_debugfs_create_file("addr", 0200, skx_test,
+				      NULL, &fops_u64_wo)) {
+		debugfs_remove(skx_test);
+		skx_test = NULL;
+	}
 }
 
 static void teardown_skx_debug(void)
-- 
2.39.2



