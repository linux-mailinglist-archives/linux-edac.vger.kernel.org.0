Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C001657EA3E
	for <lists+linux-edac@lfdr.de>; Sat, 23 Jul 2022 01:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiGVXd4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 22 Jul 2022 19:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiGVXdx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 22 Jul 2022 19:33:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE8788CE4;
        Fri, 22 Jul 2022 16:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658532832; x=1690068832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ACBsVgaIHSROQvLoRtjDYJcRX0cG75oSZD+GPyW61TM=;
  b=ChgBrtXik6vAHv75cWvF6WWfJnmnNh8+lxRL6ng3CtTYpoo4KYv/DamH
   8q7RS60x53bmwu98hfe5cRotH54x0ZrA/AVFNi3TCyfqy48TXxeZ4MAtR
   hz+9lqhXvuM/t1xdd7BQuVgYaek2dM12Ekzbnvoeo71jHdMhnNWAPTLSO
   b7xDg7OOlUyN3F/MvLR0e4qIdjasCWjkmKNwxowczNDHOxSte2ZpdCRLB
   YopPDRfX1L3sAIA+kjpTRHl37eJsJzJrYREwsW4tZuoAAD8NV3+k8ubxA
   vC1ewwfmvjjfFw8hTAwx7S6RE/WLcPHqUOmXqC5UNJIWslGxtfeMQbdOf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="286185334"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="286185334"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 16:33:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="574346071"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 16:33:48 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     linux-edac@vger.kernel.org
Cc:     Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: [PATCH 4/4] x86/sb_edac: Add row column translation for Broadwell
Date:   Fri, 22 Jul 2022 16:33:38 -0700
Message-Id: <20220722233338.341567-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220722233338.341567-1-tony.luck@intel.com>
References: <20220722233338.341567-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Youquan Song <youquan.song@intel.com>

The sb_edac driver lacks translation for DIMM internal address.

Add memory address translation for row/column/bank/bank_group
on Broadwell.

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/sb_edac.c | 148 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 138 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 9678ab97c7ac..8e39370fdb5c 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -335,6 +335,12 @@ struct sbridge_info {
 struct sbridge_channel {
 	u32		ranks;
 	u32		dimms;
+	struct dimm {
+		u32 rowbits;
+		u32 colbits;
+		u32 bank_xor_enable;
+		u32 amap_fine;
+	} dimm[MAX_DIMMS];
 };
 
 struct pci_id_descr {
@@ -1603,7 +1609,7 @@ static int __populate_dimms(struct mem_ctl_info *mci,
 		banks = 8;
 
 	for (i = 0; i < channels; i++) {
-		u32 mtr;
+		u32 mtr, amap = 0;
 
 		int max_dimms_per_channel;
 
@@ -1615,6 +1621,7 @@ static int __populate_dimms(struct mem_ctl_info *mci,
 			max_dimms_per_channel = ARRAY_SIZE(mtr_regs);
 			if (!pvt->pci_tad[i])
 				continue;
+			pci_read_config_dword(pvt->pci_tad[i], 0x8c, &amap);
 		}
 
 		for (j = 0; j < max_dimms_per_channel; j++) {
@@ -1627,6 +1634,7 @@ static int __populate_dimms(struct mem_ctl_info *mci,
 					mtr_regs[j], &mtr);
 			}
 			edac_dbg(4, "Channel #%d  MTR%d = %x\n", i, j, mtr);
+
 			if (IS_DIMM_PRESENT(mtr)) {
 				if (!IS_ECC_ENABLED(pvt->info.mcmtr)) {
 					sbridge_printk(KERN_ERR, "CPU SrcID #%d, Ha #%d, Channel #%d has DIMMs, but ECC is disabled\n",
@@ -1661,6 +1669,11 @@ static int __populate_dimms(struct mem_ctl_info *mci,
 				dimm->dtype = pvt->info.get_width(pvt, mtr);
 				dimm->mtype = mtype;
 				dimm->edac_mode = mode;
+				pvt->channel[i].dimm[j].rowbits = order_base_2(rows);
+				pvt->channel[i].dimm[j].colbits = order_base_2(cols);
+				pvt->channel[i].dimm[j].bank_xor_enable =
+						GET_BITFIELD(pvt->info.mcmtr, 9, 9);
+				pvt->channel[i].dimm[j].amap_fine = GET_BITFIELD(amap, 0, 0);
 				snprintf(dimm->label, sizeof(dimm->label),
 						 "CPU_SrcID#%u_Ha#%u_Chan#%u_DIMM#%u",
 						 pvt->sbridge_dev->source_id, pvt->sbridge_dev->dom, i, j);
@@ -1922,6 +1935,99 @@ static struct mem_ctl_info *get_mci_for_node_id(u8 node_id, u8 ha)
 	return NULL;
 }
 
+static u8 sb_close_row[] = {
+	15, 16, 17, 18, 20, 21, 22, 28, 10, 11, 12, 13, 29, 30, 31, 32, 33
+};
+
+static u8 sb_close_column[] = {
+	3, 4, 5, 14, 19, 23, 24, 25, 26, 27
+};
+
+static u8 sb_open_row[] = {
+	14, 15, 16, 20, 28, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32, 33
+};
+
+static u8 sb_open_column[] = {
+	3, 4, 5, 6, 7, 8, 9, 10, 11, 12
+};
+
+static u8 sb_open_fine_column[] = {
+	3, 4, 5, 7, 8, 9, 10, 11, 12, 13
+};
+
+static int sb_bits(u64 addr, int nbits, u8 *bits)
+{
+	int i, res = 0;
+
+	for (i = 0; i < nbits; i++)
+		res |= ((addr >> bits[i]) & 1) << i;
+	return res;
+}
+
+static int sb_bank_bits(u64 addr, int b0, int b1, int do_xor, int x0, int x1)
+{
+	int ret = GET_BITFIELD(addr, b0, b0) | (GET_BITFIELD(addr, b1, b1) << 1);
+
+	if (do_xor)
+		ret ^= GET_BITFIELD(addr, x0, x0) | (GET_BITFIELD(addr, x1, x1) << 1);
+
+	return ret;
+}
+
+static bool sb_decode_ddr4(struct mem_ctl_info *mci, int ch, u8 rank,
+			   u64 rank_addr, char *msg)
+{
+	int dimmno = 0;
+	int row, col, bank_address, bank_group;
+	struct sbridge_pvt *pvt;
+	u32 bg0 = 0, rowbits = 0, colbits = 0;
+	u32 amap_fine = 0, bank_xor_enable = 0;
+
+	dimmno = (rank < 12) ? rank / 4 : 2;
+	pvt = mci->pvt_info;
+	amap_fine =  pvt->channel[ch].dimm[dimmno].amap_fine;
+	bg0 = amap_fine ? 6 : 13;
+	rowbits = pvt->channel[ch].dimm[dimmno].rowbits;
+	colbits = pvt->channel[ch].dimm[dimmno].colbits;
+	bank_xor_enable = pvt->channel[ch].dimm[dimmno].bank_xor_enable;
+
+	if (pvt->is_lockstep) {
+		pr_warn_once("LockStep row/column decode is not supported yet!\n");
+		msg[0] = '\0';
+		return false;
+	}
+
+	if (pvt->is_close_pg) {
+		row = sb_bits(rank_addr, rowbits, sb_close_row);
+		col = sb_bits(rank_addr, colbits, sb_close_column);
+		col |= 0x400; /* C10 is autoprecharge, always set */
+		bank_address = sb_bank_bits(rank_addr, 8, 9, bank_xor_enable, 22, 28);
+		bank_group = sb_bank_bits(rank_addr, 6, 7, bank_xor_enable, 20, 21);
+	} else {
+		row = sb_bits(rank_addr, rowbits, sb_open_row);
+		if (amap_fine)
+			col = sb_bits(rank_addr, colbits, sb_open_fine_column);
+		else
+			col = sb_bits(rank_addr, colbits, sb_open_column);
+		bank_address = sb_bank_bits(rank_addr, 18, 19, bank_xor_enable, 22, 23);
+		bank_group = sb_bank_bits(rank_addr, bg0, 17, bank_xor_enable, 20, 21);
+	}
+
+	row &= (1u << rowbits) - 1;
+
+	sprintf(msg, "row:0x%x col:0x%x bank_addr:%d bank_group:%d",
+		row, col, bank_address, bank_group);
+	return true;
+}
+
+static bool sb_decode_ddr3(struct mem_ctl_info *mci, int ch, u8 rank,
+			   u64 rank_addr, char *msg)
+{
+	pr_warn_once("DDR3 row/column decode not support yet!\n");
+	msg[0] = '\0';
+	return false;
+}
+
 static int get_memory_error_data(struct mem_ctl_info *mci,
 				 u64 addr,
 				 u8 *socket, u8 *ha,
@@ -1937,12 +2043,13 @@ static int get_memory_error_data(struct mem_ctl_info *mci,
 	int			interleave_mode, shiftup = 0;
 	unsigned int		sad_interleave[MAX_INTERLEAVE];
 	u32			reg, dram_rule;
-	u8			ch_way, sck_way, pkg, sad_ha = 0;
+	u8			ch_way, sck_way, pkg, sad_ha = 0, rankid = 0;
 	u32			tad_offset;
 	u32			rir_way;
 	u32			mb, gb;
 	u64			ch_addr, offset, limit = 0, prv = 0;
-
+	u64			rank_addr;
+	enum mem_type		mtype;
 
 	/*
 	 * Step 0) Check if the address is at special memory ranges
@@ -2226,6 +2333,28 @@ static int get_memory_error_data(struct mem_ctl_info *mci,
 	pci_read_config_dword(pvt->pci_tad[base_ch], rir_offset[n_rir][idx], &reg);
 	*rank = RIR_RNK_TGT(pvt->info.type, reg);
 
+	if (pvt->info.type == BROADWELL) {
+		if (pvt->is_close_pg)
+			shiftup = 6;
+		else
+			shiftup = 13;
+
+		rank_addr = ch_addr >> shiftup;
+		rank_addr /= (1 << rir_way);
+		rank_addr <<= shiftup;
+		rank_addr |= ch_addr & GENMASK_ULL(shiftup - 1, 0);
+		rank_addr -= RIR_OFFSET(pvt->info.type, reg);
+
+		mtype = pvt->info.get_memory_type(pvt);
+		rankid = *rank;
+		if (mtype == MEM_DDR4 || mtype == MEM_RDDR4)
+			sb_decode_ddr4(mci, base_ch, rankid, rank_addr, msg);
+		else
+			sb_decode_ddr3(mci, base_ch, rankid, rank_addr, msg);
+	} else {
+		msg[0] = '\0';
+	}
+
 	edac_dbg(0, "RIR#%d: channel address 0x%08Lx < 0x%08Lx, RIR interleave %d, index %d\n",
 		 n_rir,
 		 ch_addr,
@@ -2950,7 +3079,7 @@ static void sbridge_mce_output_error(struct mem_ctl_info *mci,
 	struct mem_ctl_info *new_mci;
 	struct sbridge_pvt *pvt = mci->pvt_info;
 	enum hw_event_mc_err_type tp_event;
-	char *optype, msg[256];
+	char *optype, msg[256], msg_full[512];
 	bool ripv = GET_BITFIELD(m->mcgstatus, 0, 0);
 	bool overflow = GET_BITFIELD(m->status, 62, 62);
 	bool uncorrected_error = GET_BITFIELD(m->status, 61, 61);
@@ -3089,18 +3218,17 @@ static void sbridge_mce_output_error(struct mem_ctl_info *mci,
 	 */
 	if (!pvt->is_lockstep && !pvt->is_cur_addr_mirrored && !pvt->is_close_pg)
 		channel = first_channel;
-
-	snprintf(msg, sizeof(msg),
-		 "%s%s area:%s err_code:%04x:%04x socket:%d ha:%d channel_mask:%ld rank:%d",
+	snprintf(msg_full, sizeof(msg_full),
+		 "%s%s area:%s err_code:%04x:%04x socket:%d ha:%d channel_mask:%ld rank:%d %s",
 		 overflow ? " OVERFLOW" : "",
 		 (uncorrected_error && recoverable) ? " recoverable" : "",
 		 area_type,
 		 mscod, errcode,
 		 socket, ha,
 		 channel_mask,
-		 rank);
+		 rank, msg);
 
-	edac_dbg(0, "%s\n", msg);
+	edac_dbg(0, "%s\n", msg_full);
 
 	/* FIXME: need support for channel mask */
 
@@ -3111,7 +3239,7 @@ static void sbridge_mce_output_error(struct mem_ctl_info *mci,
 	edac_mc_handle_error(tp_event, mci, core_err_cnt,
 			     m->addr >> PAGE_SHIFT, m->addr & ~PAGE_MASK, 0,
 			     channel, dimm, -1,
-			     optype, msg);
+			     optype, msg_full);
 	return;
 err_parsing:
 	edac_mc_handle_error(tp_event, mci, core_err_cnt, 0, 0, 0,
-- 
2.35.3

