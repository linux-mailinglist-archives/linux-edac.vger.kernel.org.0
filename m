Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22061B228C
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2019 16:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbfIMOui (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Sep 2019 10:50:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388958AbfIMOuh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 13 Sep 2019 10:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y7A2GHw6cbpQyTsa/8f0KcgivnQo4Wrc1Cu3FDUvrdQ=; b=m0zY9Mu8Cl6UHzRkEAsFLPL/LA
        Wv3f2SdG5DoMaMsVlGpYbXGUKYiM4PKs3YbjgCoZOtXi7mTb4QJbp+tjIJUUsBwsdEpesRjyKshWg
        kFScSxXluBiT8Ziuv4Rt93IHa1pfDOerKtLHh8RxQ/9+G3vOPCnj8mn3uj15f9QTT2gVb0K9hvK0o
        iQ05s8q+0asXF5OaLqGn4HMBUqgx9Nz/lcc72OIxlBExg/Uq124K3/v8RvUgbkzx+xjRkyD+jX87Q
        /xi/l64jJl2QS+I43BNQlpUCD4Y2lBmw9nBt7n6AvLAbpvR0GS7oULF+phVc8gmQin8vp7xqorG54
        4Bl8eMZg==;
Received: from 177.96.232.144.dynamic.adsl.gvt.net.br ([177.96.232.144] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8muC-0002Ms-4Z; Fri, 13 Sep 2019 14:50:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.2)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1i8mu9-00043B-IL; Fri, 13 Sep 2019 11:50:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 6/7] EDAC: sb_edac: get rid of unused vars
Date:   Fri, 13 Sep 2019 11:50:31 -0300
Message-Id: <b2cfdfe224c4047b03c2b62fee4c9207e0908522.1568385816.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568385816.git.mchehab+samsung@kernel.org>
References: <cover.1568385816.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There are several vars unused on this driver, probably because
it was a modified copy of another driver. Get rid of them.

	drivers/edac/sb_edac.c: In function ‘knl_get_dimm_capacity’:
	drivers/edac/sb_edac.c:1343:16: warning: variable ‘sad_size’ set but not used [-Wunused-but-set-variable]
	 1343 |  u64 sad_base, sad_size, sad_limit = 0;
	      |                ^~~~~~~~
	drivers/edac/sb_edac.c: In function ‘sbridge_mce_output_error’:
	drivers/edac/sb_edac.c:2955:8: warning: variable ‘type’ set but not used [-Wunused-but-set-variable]
	 2955 |  char *type, *optype, msg[256];
	      |        ^~~~
	drivers/edac/sb_edac.c: In function ‘sbridge_unregister_mci’:
	drivers/edac/sb_edac.c:3203:22: warning: variable ‘pvt’ set but not used [-Wunused-but-set-variable]
	 3203 |  struct sbridge_pvt *pvt;
	      |                      ^~~
	At top level:
	drivers/edac/sb_edac.c:266:18: warning: ‘correrrthrsld’ defined but not used [-Wunused-const-variable=]
	  266 | static const u32 correrrthrsld[] = {
	      |                  ^~~~~~~~~~~~~
	drivers/edac/sb_edac.c:257:18: warning: ‘correrrcnt’ defined but not used [-Wunused-const-variable=]
	  257 | static const u32 correrrcnt[] = {
	      |                  ^~~~~~~~~~

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/sb_edac.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 37746b045e18..813f66ffc09a 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -254,18 +254,20 @@ static const u32 rir_offset[MAX_RIR_RANGES][MAX_RIR_WAY] = {
  * FIXME: Implement the error count reads directly
  */
 
-static const u32 correrrcnt[] = {
-	0x104, 0x108, 0x10c, 0x110,
-};
-
 #define RANK_ODD_OV(reg)		GET_BITFIELD(reg, 31, 31)
 #define RANK_ODD_ERR_CNT(reg)		GET_BITFIELD(reg, 16, 30)
 #define RANK_EVEN_OV(reg)		GET_BITFIELD(reg, 15, 15)
 #define RANK_EVEN_ERR_CNT(reg)		GET_BITFIELD(reg,  0, 14)
 
+#if 0 /* Currently unused*/
+static const u32 correrrcnt[] = {
+	0x104, 0x108, 0x10c, 0x110,
+};
+
 static const u32 correrrthrsld[] = {
 	0x11c, 0x120, 0x124, 0x128,
 };
+#endif
 
 #define RANK_ODD_ERR_THRSLD(reg)	GET_BITFIELD(reg, 16, 30)
 #define RANK_EVEN_ERR_THRSLD(reg)	GET_BITFIELD(reg,  0, 14)
@@ -1340,7 +1342,7 @@ static void knl_show_mc_route(u32 reg, char *s)
  */
 static int knl_get_dimm_capacity(struct sbridge_pvt *pvt, u64 *mc_sizes)
 {
-	u64 sad_base, sad_size, sad_limit = 0;
+	u64 sad_base, sad_limit = 0;
 	u64 tad_base, tad_size, tad_limit, tad_deadspace, tad_livespace;
 	int sad_rule = 0;
 	int tad_rule = 0;
@@ -1427,7 +1429,6 @@ static int knl_get_dimm_capacity(struct sbridge_pvt *pvt, u64 *mc_sizes)
 		edram_only = KNL_EDRAM_ONLY(dram_rule);
 
 		sad_limit = pvt->info.sad_limit(dram_rule)+1;
-		sad_size = sad_limit - sad_base;
 
 		pci_read_config_dword(pvt->pci_sad0,
 			pvt->info.interleave_list[sad_rule], &interleave_reg);
@@ -2952,7 +2953,7 @@ static void sbridge_mce_output_error(struct mem_ctl_info *mci,
 	struct mem_ctl_info *new_mci;
 	struct sbridge_pvt *pvt = mci->pvt_info;
 	enum hw_event_mc_err_type tp_event;
-	char *type, *optype, msg[256];
+	char *optype, msg[256];
 	bool ripv = GET_BITFIELD(m->mcgstatus, 0, 0);
 	bool overflow = GET_BITFIELD(m->status, 62, 62);
 	bool uncorrected_error = GET_BITFIELD(m->status, 61, 61);
@@ -2981,14 +2982,11 @@ static void sbridge_mce_output_error(struct mem_ctl_info *mci,
 	if (uncorrected_error) {
 		core_err_cnt = 1;
 		if (ripv) {
-			type = "FATAL";
 			tp_event = HW_EVENT_ERR_FATAL;
 		} else {
-			type = "NON_FATAL";
 			tp_event = HW_EVENT_ERR_UNCORRECTED;
 		}
 	} else {
-		type = "CORRECTED";
 		tp_event = HW_EVENT_ERR_CORRECTED;
 	}
 
@@ -3200,7 +3198,6 @@ static struct notifier_block sbridge_mce_dec = {
 static void sbridge_unregister_mci(struct sbridge_dev *sbridge_dev)
 {
 	struct mem_ctl_info *mci = sbridge_dev->mci;
-	struct sbridge_pvt *pvt;
 
 	if (unlikely(!mci || !mci->pvt_info)) {
 		edac_dbg(0, "MC: dev = %p\n", &sbridge_dev->pdev[0]->dev);
@@ -3209,8 +3206,6 @@ static void sbridge_unregister_mci(struct sbridge_dev *sbridge_dev)
 		return;
 	}
 
-	pvt = mci->pvt_info;
-
 	edac_dbg(0, "MC: mci = %p, dev = %p\n",
 		 mci, &sbridge_dev->pdev[0]->dev);
 
-- 
2.21.0

