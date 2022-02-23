Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6164C1D64
	for <lists+linux-edac@lfdr.de>; Wed, 23 Feb 2022 21:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241960AbiBWUzk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Feb 2022 15:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241838AbiBWUzj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Feb 2022 15:55:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370B74E385;
        Wed, 23 Feb 2022 12:55:10 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 71B9F1EC0529;
        Wed, 23 Feb 2022 21:55:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645649704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=N6N5XoeBdI2SPhXjlDMWW+LUffHCmtwa3SProti1gmQ=;
        b=rdhLUZUMKoFoPvUhuQRnHvTKp559XBy1DmZzpWwLYLIVTSvBdozQijH9j3KFDpdUnodgym
        jSGVae1tAfqe36LuV/GqeAOdgW0Qvi3qV9Qid0DlSGG0K5hN6tI0WkK9176LFr/ZiqFdiK
        ILzq0nZzyjjucNijFzrAnSGvtRsJknE=
Date:   Wed, 23 Feb 2022 21:55:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH v4 1/2] EDAC/amd64: Set memory type per DIMM
Message-ID: <YhafLB7Jw1Bul7YP@zn.tnic>
References: <20220202144307.2678405-1-yazen.ghannam@amd.com>
 <20220202144307.2678405-2-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220202144307.2678405-2-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Feb 02, 2022 at 02:43:06PM +0000, Yazen Ghannam wrote:
> +static void _determine_memory_type_df(struct amd64_umc *umc)

You don't need this function, right?

IOW, here's what I've applied:

---
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Wed, 2 Feb 2022 14:43:06 +0000
Subject: [PATCH] EDAC/amd64: Set memory type per DIMM

Current AMD systems allow mixing of DIMM types within a system. However,
DIMMs within a channel, i.e. managed by a single Unified Memory
Controller (UMC), must be of the same type.

Handle this possible configuration by checking and setting the memory
type for each individual "UMC" structure.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: William Roche <william.roche@oracle.com>
Link: https://lore.kernel.org/r/20220202144307.2678405-2-yazen.ghannam@amd.com
---
 drivers/edac/amd64_edac.c | 43 ++++++++++++++++++++++++++++-----------
 drivers/edac/amd64_edac.h | 10 ++++++++-
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index fba609ada0e6..388b072daa94 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1429,7 +1429,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 		edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
 				i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
 
-		if (pvt->dram_type == MEM_LRDDR4) {
+		if (umc->dram_type == MEM_LRDDR4) {
 			amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ADDR_CFG, &tmp);
 			edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
 					i, 1 << ((tmp >> 4) & 0x3));
@@ -1616,19 +1616,36 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
 	}
 }
 
-static void determine_memory_type(struct amd64_pvt *pvt)
+static void determine_memory_type_df(struct amd64_pvt *pvt)
 {
-	u32 dram_ctrl, dcsm;
+	struct amd64_umc *umc;
+	u32 i;
 
-	if (pvt->umc) {
-		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
-			pvt->dram_type = MEM_LRDDR4;
-		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
-			pvt->dram_type = MEM_RDDR4;
+	for_each_umc(i) {
+		umc = &pvt->umc[i];
+
+		if (!(umc->sdp_ctrl & UMC_SDP_INIT)) {
+			umc->dram_type = MEM_EMPTY;
+			continue;
+		}
+
+		if (umc->dimm_cfg & BIT(5))
+			umc->dram_type = MEM_LRDDR4;
+		else if (umc->dimm_cfg & BIT(4))
+			umc->dram_type = MEM_RDDR4;
 		else
-			pvt->dram_type = MEM_DDR4;
-		return;
+			umc->dram_type = MEM_DDR4;
+
+		edac_dbg(1, "  UMC%d DIMM type: %s\n", i, edac_mem_types[umc->dram_type]);
 	}
+}
+
+static void determine_memory_type(struct amd64_pvt *pvt)
+{
+	u32 dram_ctrl, dcsm;
+
+	if (pvt->umc)
+		return determine_memory_type_df(pvt);
 
 	switch (pvt->fam) {
 	case 0xf:
@@ -3452,7 +3469,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 	read_dct_base_mask(pvt);
 
 	determine_memory_type(pvt);
-	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
+
+	if (!pvt->umc)
+		edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
 
 	determine_ecc_sym_sz(pvt);
 }
@@ -3548,7 +3567,7 @@ static int init_csrows_df(struct mem_ctl_info *mci)
 					pvt->mc_node_id, cs);
 
 			dimm->nr_pages = get_csrow_nr_pages(pvt, umc, cs);
-			dimm->mtype = pvt->dram_type;
+			dimm->mtype = pvt->umc[umc].dram_type;
 			dimm->edac_mode = edac_mode;
 			dimm->dtype = dev_type;
 			dimm->grain = 64;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 352bda9803f6..6b8742369f9d 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -344,6 +344,9 @@ struct amd64_umc {
 	u32 sdp_ctrl;		/* SDP Control reg */
 	u32 ecc_ctrl;		/* DRAM ECC Control reg */
 	u32 umc_cap_hi;		/* Capabilities High reg */
+
+	/* cache the dram_type */
+	enum mem_type dram_type;
 };
 
 struct amd64_pvt {
@@ -391,7 +394,12 @@ struct amd64_pvt {
 	/* place to store error injection parameters prior to issue */
 	struct error_injection injection;
 
-	/* cache the dram_type */
+	/*
+	 * cache the dram_type
+	 *
+	 * NOTE: Don't use this for Family 17h and later.
+	 *	 Use dram_type in struct amd64_umc instead.
+	 */
 	enum mem_type dram_type;
 
 	struct amd64_umc *umc;	/* UMC registers */
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
