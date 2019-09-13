Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF1DEB282A
	for <lists+linux-edac@lfdr.de>; Sat, 14 Sep 2019 00:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390378AbfIMWNq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Sep 2019 18:13:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:24050 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390255AbfIMWNq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 13 Sep 2019 18:13:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 15:13:45 -0700
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="337033395"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 15:13:45 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: [PATCH 1/2] EDAC, skx_common: Refactor so that we initialize "dev" in result of adxl decode.
Date:   Fri, 13 Sep 2019 15:13:43 -0700
Message-Id: <20190913221344.13055-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913221344.13055-1-tony.luck@intel.com>
References: <20190913221344.13055-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Simplifies the code a little.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/skx_common.c | 48 +++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index d8ff63d91b86..58b8348d0f71 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -100,6 +100,7 @@ void __exit skx_adxl_put(void)
 
 static bool skx_adxl_decode(struct decoded_addr *res)
 {
+	struct skx_dev *d;
 	int i, len = 0;
 
 	if (res->addr >= skx_tohm || (res->addr >= skx_tolm &&
@@ -118,6 +119,24 @@ static bool skx_adxl_decode(struct decoded_addr *res)
 	res->channel = (int)adxl_values[component_indices[INDEX_CHANNEL]];
 	res->dimm    = (int)adxl_values[component_indices[INDEX_DIMM]];
 
+	if (res->imc > NUM_IMC - 1) {
+		skx_printk(KERN_ERR, "Bad imc %d\n", res->imc);
+		return false;
+	}
+
+	list_for_each_entry(d, &dev_edac_list, list) {
+		if (d->imc[0].src_id == res->socket) {
+			res->dev = d;
+			break;
+		}
+	}
+
+	if (!res->dev) {
+		skx_printk(KERN_ERR, "No device for src_id %d imc %d\n",
+			   res->socket, res->imc);
+		return false;
+	}
+
 	for (i = 0; i < adxl_component_count; i++) {
 		if (adxl_values[i] == ~0x0ull)
 			continue;
@@ -452,24 +471,6 @@ static void skx_unregister_mci(struct skx_imc *imc)
 	edac_mc_free(mci);
 }
 
-static struct mem_ctl_info *get_mci(int src_id, int lmc)
-{
-	struct skx_dev *d;
-
-	if (lmc > NUM_IMC - 1) {
-		skx_printk(KERN_ERR, "Bad lmc %d\n", lmc);
-		return NULL;
-	}
-
-	list_for_each_entry(d, &dev_edac_list, list) {
-		if (d->imc[0].src_id == src_id)
-			return d->imc[lmc].mci;
-	}
-
-	skx_printk(KERN_ERR, "No mci for src_id %d lmc %d\n", src_id, lmc);
-	return NULL;
-}
-
 static void skx_mce_output_error(struct mem_ctl_info *mci,
 				 const struct mce *m,
 				 struct decoded_addr *res)
@@ -583,15 +584,12 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 	if (adxl_component_count) {
 		if (!skx_adxl_decode(&res))
 			return NOTIFY_DONE;
-
-		mci = get_mci(res.socket, res.imc);
-	} else {
-		if (!skx_decode || !skx_decode(&res))
-			return NOTIFY_DONE;
-
-		mci = res.dev->imc[res.imc].mci;
+	} else if (!skx_decode || !skx_decode(&res)) {
+		return NOTIFY_DONE;
 	}
 
+	mci = res.dev->imc[res.imc].mci;
+
 	if (!mci)
 		return NOTIFY_DONE;
 
-- 
2.20.1

