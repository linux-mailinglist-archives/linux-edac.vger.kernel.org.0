Return-Path: <linux-edac+bounces-28-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21B77EC7A6
	for <lists+linux-edac@lfdr.de>; Wed, 15 Nov 2023 16:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C37A2814AC
	for <lists+linux-edac@lfdr.de>; Wed, 15 Nov 2023 15:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A533FE2D;
	Wed, 15 Nov 2023 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5zDHRun"
X-Original-To: linux-edac@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDA33BB2A
	for <linux-edac@vger.kernel.org>; Wed, 15 Nov 2023 15:50:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D49D1B5;
	Wed, 15 Nov 2023 07:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700063405; x=1731599405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=myjq+7KxMJZnX+WBGnUmAQI9BOIywt/la8xGPe4hCgA=;
  b=g5zDHRunNOrpYbDYyKx2zMrzMctyVFok1JcH2X4hpBo7GY0uYtK+JZnE
   gbd4n9OQR9IlASIxiiKsu2vqZ9xSxTIMVTcn/xOB+p7+qvJSl6IcQi9qQ
   hoalGyX64Jp6+iySJelJ7K4fTJmrEaVqHgPBgOV754brMNtjKBPnIoLRJ
   SH9bf0/59AjnpoGB8Zy7GO+yYjTop1w//608b0CAu/OygabQkVYDS7z4v
   2TFsclo8fTlO1GOrCqfDKYjfgrbfEcKANr5bP1WsO7kNk4vsc0oQU3LFT
   vH9uLws6FlLfqZppKlGfcIdo1MMnNDO7XzqBd13d0RFl7wumACFrZbG3W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="477119136"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="477119136"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 07:50:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="741469102"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="741469102"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2023 07:49:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0C498241; Wed, 15 Nov 2023 17:49:58 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Subject: [PATCH v1 2/3] EDAC, pnd2: Apply bit macros and helpers where it makes sense
Date: Wed, 15 Nov 2023 17:49:39 +0200
Message-ID: <20231115154940.664664-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231115154940.664664-1-andriy.shevchenko@linux.intel.com>
References: <20231115154940.664664-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apply bit macros (BIT()/BIT_ULL()/GENMASK()/etc) and helpers
(is_power_of_2()/for_each_set_bit()/etc) where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/edac/pnd2_edac.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 45e3c2913d51..676e02c8dc43 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -183,7 +183,7 @@ static int _apl_rd_reg(int port, int off, int op, u32 *data)
 	}
 
 	P2SB_READ(dword, P2SB_DATA_OFF, data);
-	ret = (status >> 1) & 0x3;
+	ret = (status >> 1) & GENMASK(1, 0);
 out:
 	/* Hide the P2SB device, if it was hidden before */
 	if (hidden)
@@ -307,7 +307,7 @@ static bool two_channels; /* Both PMI channels in one slice enabled */
 
 static u8 sym_chan_mask;
 static u8 asym_chan_mask;
-static u8 chan_mask;
+static unsigned long chan_mask;
 
 static int slice_selector = -1;
 static int chan_selector = -1;
@@ -328,7 +328,7 @@ static void mk_region_mask(char *name, struct region *rp, u64 base, u64 mask)
 		pr_info(FW_BUG "MOT mask cannot be zero\n");
 		return;
 	}
-	if (mask != GENMASK_ULL(PND_MAX_PHYS_BIT, __ffs(mask))) {
+	if (is_power_of_2(mask)) {
 		pr_info(FW_BUG "MOT mask not power of two\n");
 		return;
 	}
@@ -598,7 +598,7 @@ static void remove_addr_bit(u64 *addr, int bitidx)
 	if (bitidx == -1)
 		return;
 
-	mask = (1ull << bitidx) - 1;
+	mask = BIT_ULL(bitidx) - 1;
 	*addr = ((*addr >> 1) & ~mask) | (*addr & mask);
 }
 
@@ -642,7 +642,7 @@ static int sys2pmi(const u64 addr, u32 *pmiidx, u64 *pmiaddr, char *msg)
 	int sym_chan_shift = sym_channels >> 1;
 
 	/* Give up if address is out of range, or in MMIO gap */
-	if (addr >= (1ul << PND_MAX_PHYS_BIT) ||
+	if (addr >= BIT(PND_MAX_PHYS_BIT) ||
 	   (addr >= top_lm && addr < SZ_4G) || addr >= top_hm) {
 		snprintf(msg, PND2_MSG_SIZE, "Error address 0x%llx is not DRAM", addr);
 		return -EINVAL;
@@ -727,10 +727,10 @@ static int sys2pmi(const u64 addr, u32 *pmiidx, u64 *pmiaddr, char *msg)
 }
 
 /* Translate PMI address to memory (rank, row, bank, column) */
-#define C(n) (0x10 | (n))	/* column */
-#define B(n) (0x20 | (n))	/* bank */
-#define R(n) (0x40 | (n))	/* row */
-#define RS   (0x80)			/* rank */
+#define C(n) (BIT(4) | (n))	/* column */
+#define B(n) (BIT(5) | (n))	/* bank */
+#define R(n) (BIT(6) | (n))	/* row */
+#define RS   (BIT(7))		/* rank */
 
 /* addrdec values */
 #define AMAP_1KB	0
@@ -1061,12 +1061,13 @@ static int check_channel(int ch)
 
 static int apl_check_ecc_active(void)
 {
-	int	i, ret = 0;
+	unsigned int i;
+	int ret;
 
 	/* Check dramtype and ECC mode for each present DIMM */
-	for (i = 0; i < APL_NUM_CHANNELS; i++)
-		if (chan_mask & BIT(i))
-			ret += check_channel(i);
+	for_each_set_bit(i, &chan_mask, APL_NUM_CHANNELS)
+		ret += check_channel(i);
+
 	return ret ? -EINVAL : 0;
 }
 
@@ -1203,12 +1204,9 @@ static void apl_get_dimm_config(struct mem_ctl_info *mci)
 	struct dimm_info *dimm;
 	struct d_cr_drp0 *d;
 	u64	capacity;
-	int	i, g;
-
-	for (i = 0; i < APL_NUM_CHANNELS; i++) {
-		if (!(chan_mask & BIT(i)))
-			continue;
+	unsigned int i, g;
 
+	for_each_set_bit(i, &chan_mask, APL_NUM_CHANNELS) {
 		dimm = edac_get_dimm(mci, i, 0, 0);
 		if (!dimm) {
 			edac_dbg(0, "No allocated DIMM for channel %d\n", i);
@@ -1228,8 +1226,7 @@ static void apl_get_dimm_config(struct mem_ctl_info *mci)
 		}
 
 		pvt->dimm_geom[i] = g;
-		capacity = (d->rken0 + d->rken1) * 8 * (1ul << dimms[g].rowbits) *
-				   (1ul << dimms[g].colbits);
+		capacity = (d->rken0 + d->rken1) * 8 * BIT(dimms[g].rowbits + dimms[g].colbits);
 		edac_dbg(0, "Channel %d: %lld MByte DIMM\n", i, capacity >> (20 - 3));
 		dimm->nr_pages = MiB_TO_PAGES(capacity >> (20 - 3));
 		dimm->grain = 32;
@@ -1295,7 +1292,7 @@ static void dnv_get_dimm_config(struct mem_ctl_info *mci)
 				continue;
 			}
 
-			capacity = ranks_of_dimm[j] * banks * (1ul << rowbits) * (1ul << colbits);
+			capacity = ranks_of_dimm[j] * banks * BIT(rowbits + colbits);
 			edac_dbg(0, "Channel %d DIMM %d: %lld MByte DIMM\n", i, j, capacity >> (20 - 3));
 			dimm->nr_pages = MiB_TO_PAGES(capacity >> (20 - 3));
 			dimm->grain = 32;
-- 
2.43.0.rc1.1.gbec44491f096


