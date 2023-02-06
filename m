Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9162768B3AA
	for <lists+linux-edac@lfdr.de>; Mon,  6 Feb 2023 02:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjBFBOy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 5 Feb 2023 20:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFBOx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 5 Feb 2023 20:14:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69531166D6;
        Sun,  5 Feb 2023 17:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675646092; x=1707182092;
  h=from:to:cc:subject:date:message-id;
  bh=NnZ0DjAoK3VKE8oYmo9VgC6ZUrWIdd+pJwpV0fpDuLo=;
  b=MZibL9Gcj2c1Hzzd/j0Wwng7q0Nb02p9aSQafYQp+24XKa7LbqLb7bpD
   wcw58+3S2HUYLT9Mt1Cjhdvay2gcpkGZ/uHYW3h6ZGu/IVwu0bRY8Zp87
   HcR4k88nupIWQRT4P1NBSR2b1MNAKtso76iwBSJDYl5nQafzeRPhFNuRj
   ohn89UCDHR9cJg+x7CbgSgRQFSKnhOQP4kx/Z0UfChzI+a4QCSaboeGjU
   sAK0Mh+JgHNFyg083G7c3alejyTNhW0bhIoSsgxc07H8JpT+lZkG8yxFD
   0qXeK9QIsCLg6xJTKkSm87GmB8J9J2OU0KUsIe44tfWcgblXVE2/yuY6k
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="356465156"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="356465156"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:14:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="995117311"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="995117311"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.105])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:14:50 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Youquan Song <youquan.song@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/i10nm: Add driver decoder for Sapphire Rapids server
Date:   Mon,  6 Feb 2023 09:14:23 +0800
Message-Id: <20230206011423.50559-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Youquan Song <youquan.song@intel.com>

Intel SDM (December 2022) vol3B 17.13.2 contains IMC MC error codes
for Sapphire Rapids. Current i10nm_edac only supports firmware decoder
(ACPI DSM methods) for Sapphire Rapids. So add the driver decoder
(decoding DDR memory errors via extracting error information from the
IMC MC error codes) for Sapphire Rapids for better decoding performance.

Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
---
On top of the branch 'edac-for-next' of RAS git tree

 drivers/edac/i10nm_base.c | 102 ++++++++++++++++++++++++++------------
 1 file changed, 69 insertions(+), 33 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 46034310b78e..0a4691792801 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -434,20 +434,39 @@ static bool i10nm_check_2lm(struct res_config *cfg)
 }
 
 /*
- * Check whether the error comes from DDRT by ICX/Tremont model specific error code.
- * Refer to SDM vol3B 16.11.3 Intel IMC MC error codes for IA32_MCi_STATUS.
+ * Check whether the error comes from DDRT by ICX/Tremont/SPR model specific error code.
+ * Refer to SDM vol3B 17.11.3/17.13.2 Intel IMC MC error codes for IA32_MCi_STATUS.
  */
 static bool i10nm_mscod_is_ddrt(u32 mscod)
 {
-	switch (mscod) {
-	case 0x0106: case 0x0107:
-	case 0x0800: case 0x0804:
-	case 0x0806 ... 0x0808:
-	case 0x080a ... 0x080e:
-	case 0x0810: case 0x0811:
-	case 0x0816: case 0x081e:
-	case 0x081f:
-		return true;
+	switch (res_cfg->type) {
+	case I10NM:
+		switch (mscod) {
+		case 0x0106: case 0x0107:
+		case 0x0800: case 0x0804:
+		case 0x0806 ... 0x0808:
+		case 0x080a ... 0x080e:
+		case 0x0810: case 0x0811:
+		case 0x0816: case 0x081e:
+		case 0x081f:
+			return true;
+		}
+
+		break;
+	case SPR:
+		switch (mscod) {
+		case 0x0800: case 0x0804:
+		case 0x0806 ... 0x0808:
+		case 0x080a ... 0x080e:
+		case 0x0810: case 0x0811:
+		case 0x0816: case 0x081e:
+		case 0x081f:
+			return true;
+		}
+
+		break;
+	default:
+		return false;
 	}
 
 	return false;
@@ -455,6 +474,7 @@ static bool i10nm_mscod_is_ddrt(u32 mscod)
 
 static bool i10nm_mc_decode_available(struct mce *mce)
 {
+#define ICX_IMCx_CHy		0x06666000
 	u8 bank;
 
 	if (!decoding_via_mca || mem_cfg_2lm)
@@ -468,21 +488,26 @@ static bool i10nm_mc_decode_available(struct mce *mce)
 
 	switch (res_cfg->type) {
 	case I10NM:
-		if (bank < 13 || bank > 26)
-			return false;
-
-		/* DDRT errors can't be decoded from MCA bank registers */
-		if (MCI_MISC_ECC_MODE(mce->misc) == MCI_MISC_ECC_DDRT)
+		/* Check whether the bank is one of {13,14,17,18,21,22,25,26} */
+		if (!(ICX_IMCx_CHy & (1 << bank)))
 			return false;
-
-		if (i10nm_mscod_is_ddrt(MCI_STATUS_MSCOD(mce->status)))
+		break;
+	case SPR:
+		if (bank < 13 || bank > 20)
 			return false;
-
-		/* Check whether one of {13,14,17,18,21,22,25,26} */
-		return ((bank - 13) & BIT(1)) == 0;
+		break;
 	default:
 		return false;
 	}
+
+	/* DDRT errors can't be decoded from MCA bank registers */
+	if (MCI_MISC_ECC_MODE(mce->misc) == MCI_MISC_ECC_DDRT)
+		return false;
+
+	if (i10nm_mscod_is_ddrt(MCI_STATUS_MSCOD(mce->status)))
+		return false;
+
+	return true;
 }
 
 static bool i10nm_mc_decode(struct decoded_addr *res)
@@ -504,9 +529,29 @@ static bool i10nm_mc_decode(struct decoded_addr *res)
 
 	switch (res_cfg->type) {
 	case I10NM:
-		bank = m->bank - 13;
-		res->imc = bank / 4;
-		res->channel = bank % 2;
+		bank              = m->bank - 13;
+		res->imc          = bank / 4;
+		res->channel      = bank % 2;
+		res->column       = GET_BITFIELD(m->misc, 9, 18) << 2;
+		res->row          = GET_BITFIELD(m->misc, 19, 39);
+		res->bank_group   = GET_BITFIELD(m->misc, 40, 41);
+		res->bank_address = GET_BITFIELD(m->misc, 42, 43);
+		res->bank_group  |= GET_BITFIELD(m->misc, 44, 44) << 2;
+		res->rank         = GET_BITFIELD(m->misc, 56, 58);
+		res->dimm         = res->rank >> 2;
+		res->rank         = res->rank % 4;
+		break;
+	case SPR:
+		bank              = m->bank - 13;
+		res->imc          = bank / 2;
+		res->channel      = bank % 2;
+		res->column       = GET_BITFIELD(m->misc, 9, 18) << 2;
+		res->row          = GET_BITFIELD(m->misc, 19, 36);
+		res->bank_group   = GET_BITFIELD(m->misc, 37, 38);
+		res->bank_address = GET_BITFIELD(m->misc, 39, 40);
+		res->bank_group  |= GET_BITFIELD(m->misc, 41, 41) << 2;
+		res->rank         = GET_BITFIELD(m->misc, 57, 57);
+		res->dimm         = GET_BITFIELD(m->misc, 58, 58);
 		break;
 	default:
 		return false;
@@ -518,15 +563,6 @@ static bool i10nm_mc_decode(struct decoded_addr *res)
 		return false;
 	}
 
-	res->column       = GET_BITFIELD(m->misc, 9, 18) << 2;
-	res->row          = GET_BITFIELD(m->misc, 19, 39);
-	res->bank_group   = GET_BITFIELD(m->misc, 40, 41);
-	res->bank_address = GET_BITFIELD(m->misc, 42, 43);
-	res->bank_group  |= GET_BITFIELD(m->misc, 44, 44) << 2;
-	res->rank         = GET_BITFIELD(m->misc, 56, 58);
-	res->dimm         = res->rank >> 2;
-	res->rank         = res->rank % 4;
-
 	return true;
 }
 

base-commit: 4c5be17ae44513686885ad939471cc2bd758237e
-- 
2.17.1

