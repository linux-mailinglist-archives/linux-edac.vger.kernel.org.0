Return-Path: <linux-edac+bounces-1744-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A45AD964450
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 14:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA14E1C2226C
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B3B19047F;
	Thu, 29 Aug 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBiRwf3y"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7628618DF99;
	Thu, 29 Aug 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934259; cv=none; b=faEzlGseSSCRjerweuz3zn82GOxx0LGW/0jNF04TJ2x8FIXVA0CLxNthPinBNJqdkbqTW1YWhdVxybFLTS6h31LDX9qI2WExjw7AwC8sf/Z0QEokxj+62fhxoMKmw4z6m4/93gR5UvEOe/stGAXbrXjtRCWilT37gGzVK74/JWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934259; c=relaxed/simple;
	bh=uasQcdx7rxFNG5sGSQR1AXItx94ohSc5+2LDegn3S28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=W3kX/BisA6sHXttSPD44bZYyr9KJbzjg7Aza1EN145sMCnl92lgY0P2vT/SXsAaaTQY/yttRrIc2lQZQ18Xvt03c40WUiIPr2dDuMShBhLyRpTdRW/ed2Bfw+65WrA3d5L8mRf4TBGhsBs0SgQ4xrSC+0rwrJr4i56FaB7KnYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBiRwf3y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724934257; x=1756470257;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uasQcdx7rxFNG5sGSQR1AXItx94ohSc5+2LDegn3S28=;
  b=DBiRwf3y4FG/R8tFvs4PsGlGKZaYaBXdEkCWfG4J+L2XA82lVwOt2VDf
   +ANeKnRKdokOzmi/4p8IfrQ6MidXFfgR+yAOg7A3KpxcODTfsIqxeDNFI
   d84dWGl4xztDzDNNQ+O7KmXIbGB0050G5PACdZRP1ieSu0AFYNDLAq4QT
   j/V7nNgVaIYk6OKno8QPBXKjfXv89G2SrKV6a7oZ76X1o7KSwoU0XNn4/
   Wo3NgJ1srYrBYOpsZiaV/iLTGsSscztEjVglR3s2DFjjvD1+bmFriuqVM
   bNCdfMxq0fhEsWX9kbSjkjSL2GfBrvBSl6ZzZBmEPKGicK4li2qpGH77O
   Q==;
X-CSE-ConnectionGUID: U5r/V3v3RKi30qrapxMldw==
X-CSE-MsgGUID: EnX3rVwCTzWL3Dp8+qxdVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23038748"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23038748"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:24:16 -0700
X-CSE-ConnectionGUID: UiGiflH/SRm10kW3V5qPoA==
X-CSE-MsgGUID: hzWKf81rQnG2C0RvVf8qtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63511734"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:24:14 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/sb_edac: Fix the compile warning of large frame size
Date: Thu, 29 Aug 2024 20:09:03 +0800
Message-Id: <20240829120903.84152-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Compiling sb_edac driver with GCC 11.4.0 and the W=1 option reported
the following warning:

  drivers/edac/sb_edac.c: In function ‘sbridge_mce_output_error’:
  drivers/edac/sb_edac.c:3249:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]

As there is no concurrent invocation of sbridge_mce_output_error(),
fix this warning by moving the large-size variables 'msg' and 'msg_full'
from the stack to the pre-allocated data segment.

Reported-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/sb_edac.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index e5c05a876947..e1cb9918b5a4 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -29,6 +29,8 @@
 
 /* Static vars */
 static LIST_HEAD(sbridge_edac_list);
+static char sb_msg[256];
+static char sb_msg_full[512];
 
 /*
  * Alter this version for the module when modifications are made
@@ -3079,7 +3081,6 @@ static void sbridge_mce_output_error(struct mem_ctl_info *mci,
 	struct mem_ctl_info *new_mci;
 	struct sbridge_pvt *pvt = mci->pvt_info;
 	enum hw_event_mc_err_type tp_event;
-	char *optype, msg[256], msg_full[512];
 	bool ripv = GET_BITFIELD(m->mcgstatus, 0, 0);
 	bool overflow = GET_BITFIELD(m->status, 62, 62);
 	bool uncorrected_error = GET_BITFIELD(m->status, 61, 61);
@@ -3095,10 +3096,10 @@ static void sbridge_mce_output_error(struct mem_ctl_info *mci,
 	 * aligned address reported by patrol scrubber.
 	 */
 	u32 lsb = GET_BITFIELD(m->misc, 0, 5);
+	char *optype, *area_type = "DRAM";
 	long channel_mask, first_channel;
 	u8  rank = 0xff, socket, ha;
 	int rc, dimm;
-	char *area_type = "DRAM";
 
 	if (pvt->info.type != SANDY_BRIDGE)
 		recoverable = true;
@@ -3168,7 +3169,7 @@ static void sbridge_mce_output_error(struct mem_ctl_info *mci,
 			channel = knl_channel_remap(m->bank == 16, channel);
 			channel_mask = 1 << channel;
 
-			snprintf(msg, sizeof(msg),
+			snprintf(sb_msg, sizeof(sb_msg),
 				"%s%s err_code:%04x:%04x channel:%d (DIMM_%c)",
 				overflow ? " OVERFLOW" : "",
 				(uncorrected_error && recoverable)
@@ -3177,23 +3178,23 @@ static void sbridge_mce_output_error(struct mem_ctl_info *mci,
 			edac_mc_handle_error(tp_event, mci, core_err_cnt,
 				m->addr >> PAGE_SHIFT, m->addr & ~PAGE_MASK, 0,
 				channel, 0, -1,
-				optype, msg);
+				optype, sb_msg);
 		}
 		return;
 	} else if (lsb < 12) {
 		rc = get_memory_error_data(mci, m->addr, &socket, &ha,
 					   &channel_mask, &rank,
-					   &area_type, msg);
+					   &area_type, sb_msg);
 	} else {
 		rc = get_memory_error_data_from_mce(mci, m, &socket, &ha,
-						    &channel_mask, msg);
+						    &channel_mask, sb_msg);
 	}
 
 	if (rc < 0)
 		goto err_parsing;
 	new_mci = get_mci_for_node_id(socket, ha);
 	if (!new_mci) {
-		strcpy(msg, "Error: socket got corrupted!");
+		strcpy(sb_msg, "Error: socket got corrupted!");
 		goto err_parsing;
 	}
 	mci = new_mci;
@@ -3218,7 +3219,7 @@ static void sbridge_mce_output_error(struct mem_ctl_info *mci,
 	 */
 	if (!pvt->is_lockstep && !pvt->is_cur_addr_mirrored && !pvt->is_close_pg)
 		channel = first_channel;
-	snprintf(msg_full, sizeof(msg_full),
+	snprintf(sb_msg_full, sizeof(sb_msg_full),
 		 "%s%s area:%s err_code:%04x:%04x socket:%d ha:%d channel_mask:%ld rank:%d %s",
 		 overflow ? " OVERFLOW" : "",
 		 (uncorrected_error && recoverable) ? " recoverable" : "",
@@ -3226,9 +3227,9 @@ static void sbridge_mce_output_error(struct mem_ctl_info *mci,
 		 mscod, errcode,
 		 socket, ha,
 		 channel_mask,
-		 rank, msg);
+		 rank, sb_msg);
 
-	edac_dbg(0, "%s\n", msg_full);
+	edac_dbg(0, "%s\n", sb_msg_full);
 
 	/* FIXME: need support for channel mask */
 
@@ -3239,12 +3240,12 @@ static void sbridge_mce_output_error(struct mem_ctl_info *mci,
 	edac_mc_handle_error(tp_event, mci, core_err_cnt,
 			     m->addr >> PAGE_SHIFT, m->addr & ~PAGE_MASK, 0,
 			     channel, dimm, -1,
-			     optype, msg_full);
+			     optype, sb_msg_full);
 	return;
 err_parsing:
 	edac_mc_handle_error(tp_event, mci, core_err_cnt, 0, 0, 0,
 			     -1, -1, -1,
-			     msg, "");
+			     sb_msg, "");
 
 }
 
-- 
2.17.1


