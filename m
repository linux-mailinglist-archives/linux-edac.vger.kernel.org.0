Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36E025C9D7
	for <lists+linux-edac@lfdr.de>; Thu,  3 Sep 2020 22:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgICUCL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Sep 2020 16:02:11 -0400
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com ([40.107.243.60]:48609
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729096AbgICUCD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Sep 2020 16:02:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TC0N9E8yBQIf3RgikKs5D4tUyWdtuGKv7ayaf85+K6jz48xkQarlun1ZDbbYIwoUeXJSAph3YFkuUc0RA64KNP6ekLwvYxLITbE2JwXjP6Q0vapzPl4ynWVK/+7ilXBeSCjLOTVgPXbngWd+gynbw59hh99GPFnS3nDch69xNRE4PeOQFRQB86qqp353VAnMLmfvrdXFgYBBqb0fW+LN5fYZu+NGwN399FFQU9b1PmmsZ8m+MEDLQY1jf3MhdFUCQjcUf/2Sr81tvrb1f8eszlNmjNwDKKHurKOCERHCD3ul5shrT5jb6fLq/kUWWcdGdp7G18C8hbs++yfmadA9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSl9pFA2jll63vYbOwxcBuFJu8dLY1JxZsTMKQrGYoU=;
 b=CzPVsrqs2g+KISSwuWScbEynPKE9Y1QBxUX4xNA3JLMxc6Oh8v6cuIDk/KdLM0/yCuVl9tLD2qyOmcWZ6tSgFFynGIUbZQfYLfE4ngcgbL6QK/KH5I3P06ButnW5duI0AOiL43ULqNVf1Ciyl3N2xCcRQ6Unr5E5gsXqhd6R3olGHfCUGp4NbIOUOcLt8pLamfDUDp1kIoZtKbvDyumHwbF6JCgiqX/NOd0kvnAHaiKKxDZ/OSo3Eb7C/t7H8nm1Vp979FBT6YLsFRZehqnpxmqGXsG47X95SQpmCyA4MJ7d/LxtiI/hx/8g5Aacv39RuN/jgVczNHa8Ci6ybLrROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSl9pFA2jll63vYbOwxcBuFJu8dLY1JxZsTMKQrGYoU=;
 b=tj4AkQC6HHLFDql8FI7i/izaiiHlBS5Fqb8gvmBvewPq2WvAjt5fbGz+fGYVy494Bi8G98SQfn6X2LSwdB6vknf0Yg3uwCLKROnD5QVJEW5AtdvOelab7tNyQDTefpduPVfRR38qlRi1f8gt/+Zh0HHJz0Qtu8nRt/OGJKr2/d0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3171.namprd12.prod.outlook.com (2603:10b6:408:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 20:01:52 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e%4]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 20:01:52 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH v2 5/8] x86/MCE/AMD: Use macros to get bitfields in translation code
Date:   Thu,  3 Sep 2020 20:01:41 +0000
Message-Id: <20200903200144.310991-6-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0075.namprd05.prod.outlook.com
 (2603:10b6:803:22::13) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0501CA0075.namprd05.prod.outlook.com (2603:10b6:803:22::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7 via Frontend Transport; Thu, 3 Sep 2020 20:01:51 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a482f4b-4254-4469-b805-08d850443367
X-MS-TrafficTypeDiagnostic: BN8PR12MB3171:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3171E3784852FE024D8E7728F82C0@BN8PR12MB3171.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6umtiRzQLhnecUh46oEMzxoVj4dWiA7i/A+/fZpdbiT6Om+2T5oD2NYoV+Ge4nV5G7yuhStxNruViyhKvqRclJPYpdaNuwlrtUAkwhrYkbLO2qnGo8vzpFgTlIho/Q5n7g0ntg3zQRCXMJkmRuWXfICPVQcg95hUsNcPtd7BhxKaumTpExSw9rH8Scl2YBnT/iZFjzZCyuL7bQMR7qrE45UGHw11b3amTeRIkRD6JNZnCKQZ0rl9Idsf493FaQwSMxmTxIr4gkyP5KxEW6VJT0EGUUNX/ptxqQnS4hsdq63RgXUcKLsrnW7czGeOMt04F4DD9+uxF/eF+hyOmzN5lnQ4JZIy2oDRUnLswDAKNRc/zu/CZFkTggpWG95qP7sYM+TvGIBpQY59aB5D39v2Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(8936002)(36756003)(6666004)(478600001)(186003)(316002)(6486002)(966005)(26005)(8676002)(52116002)(16576012)(5660300002)(66476007)(86362001)(4326008)(6916009)(66556008)(2616005)(956004)(66946007)(2906002)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: P/y4R5G2tLswz9YvZoS1CgNB8V3bdma67R+dugWDfW12yfzIIlBPaYOiP8k9K5c+QqAa25ls9iBOTQ6oO9gua85bF11FnUQxQWK3UL5s9JWJCcHJMcZVwojqFvBrAADJOAphAVt78Hxbrw/tckMiNq2fk4VsX42tEq1SGVh5VkFPDJ/a9DBmmW/OwME8qstQ2WcrPEG3xGf1r/eI0dcX8ugIVVxJ2bpw8rJs6EHOpI+tE7TT/K5RTC0JQfXm0zqreGVIzT6BpFA9Dj7mxnA07HEkcoBgL1bou3jHcS7wyumu5fxO8t2WFWS7yCVA/sMKIA+ewDP1kASjjoQP4UtUil10jbibYn0iT7Vtvub+4A51JBrCXcz412Z2j0pwzEEY9bYWNY7QWGtXVVSq0FqmwJXYZe+gPDvXABjulYtq4NtBCiZs2ByoZul/TRiLJaUs8UxJgkVZKFoqesxxUz2U6BL0EEMQWqqK/1LDJRT2nS+BfvOKw73wgADj0J4NCD74xVSaeT74dTHCM5hMQA+h+QjzYnnOjc/pT3/EkbP/HSKarMbAOtf5nCc1wmGpqmstU9GwKZwxyYTErWRBhDSNf4uzILlH8eTJ17rfmOA4nPznG1lDE3UDi8aLt2e0YzzmB8DRtCYWqs6EVtLWgd3P1w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a482f4b-4254-4469-b805-08d850443367
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 20:01:52.4508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rCBVejiK91usBg5M4aWA90Bm0Ybfk48fjcJq7KMgtEIGzfMFpFZZYqA6EjjX9+F1XlihjarRMds6tIS6fPDhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3171
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Define macros to get individual bits and bitfields. Use these to make
the code more readable.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20200814191449.183998-3-Yazen.Ghannam@amd.com

v1 -> v2:
* New patch based on comments for v1 Patch 2.

 arch/x86/kernel/cpu/mce/amd.c | 46 +++++++++++++++++------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1e0510fd5afc..90c3ad61ae19 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -675,6 +675,9 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 		deferred_error_interrupt_enable(c);
 }
 
+#define get_bits(x, msb, lsb)	((x & GENMASK_ULL(msb, lsb)) >> lsb)
+#define get_bit(x, bit)		((x >> bit) & BIT(0))
+
 #define DF_F0_FABRICINSTINFO3	0x50
 #define DF_F0_MMIOHOLE		0x104
 #define DF_F0_DRAMBASEADDR	0x110
@@ -704,7 +707,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 
 	/* Remove HiAddrOffset from normalized address, if enabled: */
 	if (tmp & BIT(0)) {
-		u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;
+		u64 hi_addr_offset = get_bits(tmp, 31, 20) << 28;
 
 		/* Check if base 1 is used. */
 		if (norm_addr >= hi_addr_offset) {
@@ -723,10 +726,10 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		goto out_err;
 	}
 
-	lgcy_mmio_hole_en = tmp & BIT(1);
-	intlv_num_chan	  = (tmp >> 4) & 0xF;
-	intlv_addr_sel	  = (tmp >> 8) & 0x7;
-	dram_base_addr	  = (tmp & GENMASK_ULL(31, 12)) << 16;
+	lgcy_mmio_hole_en = get_bit(tmp, 1);
+	intlv_num_chan	  = get_bits(tmp, 7, 4);
+	intlv_addr_sel	  = get_bits(tmp, 10, 8);
+	dram_base_addr	  = get_bits(tmp, 31, 12) << 28;
 
 	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
 	if (intlv_addr_sel > 3) {
@@ -738,9 +741,9 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	if (amd_df_indirect_read(nid, 0, DF_F0_DRAMLIMITADDR + (8 * base), umc, &tmp))
 		goto out_err;
 
-	intlv_num_sockets = (tmp >> 8) & 0x1;
-	intlv_num_dies	  = (tmp >> 10) & 0x3;
-	dram_limit_addr	  = ((tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
+	intlv_num_sockets = get_bit(tmp, 8);
+	intlv_num_dies	  = get_bits(tmp, 11, 10);
+	dram_limit_addr	  = (get_bits(tmp, 31, 12) << 28) | GENMASK_ULL(27, 0);
 
 	intlv_addr_bit = intlv_addr_sel + 8;
 
@@ -793,7 +796,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		if (amd_df_indirect_read(nid, 0, DF_F0_FABRICINSTINFO3, umc, &tmp))
 			goto out_err;
 
-		cs_fabric_id = (tmp >> 8) & 0xFF;
+		cs_fabric_id = get_bits(tmp, 15, 8);
 		die_id_bit   = 0;
 
 		/* If interleaved over more than 1 channel: */
@@ -812,16 +815,16 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		/* If interleaved over more than 1 die. */
 		if (intlv_num_dies) {
 			sock_id_bit  = die_id_bit + intlv_num_dies;
-			die_id_shift = (tmp >> 24) & 0xF;
-			die_id_mask  = (tmp >> 8) & 0xFF;
+			die_id_shift = get_bits(tmp, 27, 24);
+			die_id_mask  = get_bits(tmp, 15, 8);
 
 			cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
 		}
 
 		/* If interleaved over more than 1 socket. */
 		if (intlv_num_sockets) {
-			socket_id_shift	= (tmp >> 28) & 0xF;
-			socket_id_mask	= (tmp >> 16) & 0xFF;
+			socket_id_shift	= get_bits(tmp, 31, 28);
+			socket_id_mask	= get_bits(tmp, 23, 16);
 
 			cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
 		}
@@ -834,7 +837,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
 		 * there are (where "I" starts).
 		 */
-		temp_addr_y = ret_addr & GENMASK_ULL(intlv_addr_bit-1, 0);
+		temp_addr_y = get_bits(ret_addr, intlv_addr_bit-1, 0);
 		temp_addr_i = (cs_id << intlv_addr_bit);
 		temp_addr_x = (ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
 		ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
@@ -854,16 +857,13 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	}
 
 	if (hash_enabled) {
-		/* Save some parentheses and grab ls-bit at the end. */
-		hashed_bit =	(ret_addr >> 12) ^
-				(ret_addr >> 18) ^
-				(ret_addr >> 21) ^
-				(ret_addr >> 30) ^
-				cs_id;
-
-		hashed_bit &= BIT(0);
+		hashed_bit =	get_bit(ret_addr, 12) ^
+				get_bit(ret_addr, 18) ^
+				get_bit(ret_addr, 21) ^
+				get_bit(ret_addr, 30) ^
+				get_bit(cs_id, 0);
 
-		if (hashed_bit != ((ret_addr >> intlv_addr_bit) & BIT(0)))
+		if (hashed_bit != get_bit(ret_addr, intlv_addr_bit))
 			ret_addr ^= BIT(intlv_addr_bit);
 	}
 
-- 
2.25.1

