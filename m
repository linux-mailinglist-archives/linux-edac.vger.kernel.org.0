Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748E6244EBA
	for <lists+linux-edac@lfdr.de>; Fri, 14 Aug 2020 21:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgHNTPS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Aug 2020 15:15:18 -0400
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com ([40.107.236.81]:57313
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbgHNTPR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Aug 2020 15:15:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsdN9bAZHQ2YCxx9ViiOolA8UNkOR98Cn7KnC1BhTN9zUy6G6LNXcGrgEwf9kSeRI9c828vQBOVZwr1r4NiiY8Ivnp3i87vAPXn6VNFW2MP8hKqoOBNvCAux7f5ZsrtKaRjRzeSokk66g3nfvwaoTUZ4G1T9UyPXrxKdEZggN8HJtDUWajmL/pkFp93MQ02Ta9d2PdQYpbBKJhbJNpxMlZeeXslVO2/vLnn/zHmPUedCp4cTGlHBKp5BLmatCJz0krwcMIsoAdmAlodUaxm7Xq3cJRZZFOr8WfugREZkSHNGWhpQLJabMAHQYUp+jxkbCIjusAEtiyEjKe3cLNrcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmaskd4xjiGmx9bMh2hwtW+v0R+TImpeqHnUFqBFfn4=;
 b=XoCYyL9LSv8T5tpoaM0hIHFC0SjWFHis+szs5b8Eo06rmaSgJtHILJvln7drs16+0+RvVGCx/DzQ5QfI6wY5tN/CAofOfRD07k/RLgPee8dAD+Eu4DXjYvfiDAgdWolvhjfSFiHXuzknDTYivjwtaDnhRWXTvhEyyXfEjm2cQJcMxCXsPTQgPSFSlzrzG0FXg2PauBodLmeCDoMzyQr+GeyRwerw2M8ZUxCN6DUEIN4YWm9Sco3l+WEgpVQLeOmmWqn2eOFia5g29eSkvQyHApvojOnq3XRtmgKHWy9ktbH2yVOklxrEJbIjKe9mTIFcnYyjWxOoJU1oEif4Xx9GXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmaskd4xjiGmx9bMh2hwtW+v0R+TImpeqHnUFqBFfn4=;
 b=ml+HPTtv/OdB6jp+qABGmqQwjynHt4XZZNDSUNraOKTMeMAXeXmTEbc5Q1p+opWd7EJu5aUBlA5tPxziMng7k/E4gix77HHr1wC6Oy095Te0veVyJJa9IecLrorVsgg3dAHo/0RER9nyVveJqS1kKGskPlJedQPNXZN8CEo+wTg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1700.namprd12.prod.outlook.com (2603:10b6:404:108::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Fri, 14 Aug
 2020 19:15:05 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0%4]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 19:15:04 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        x86@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 2/2] x86/MCE/AMD Support new memory interleaving schemes during address translation
Date:   Fri, 14 Aug 2020 19:14:49 +0000
Message-Id: <20200814191449.183998-3-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814191449.183998-1-Yazen.Ghannam@amd.com>
References: <20200814191449.183998-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0087.namprd12.prod.outlook.com
 (2603:10b6:802:21::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.78.2) by SN1PR12CA0087.namprd12.prod.outlook.com (2603:10b6:802:21::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Fri, 14 Aug 2020 19:15:02 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a046cc1-1bce-4274-3160-08d8408658ee
X-MS-TrafficTypeDiagnostic: BN6PR12MB1700:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB170016E547912D2337728D1CF8400@BN6PR12MB1700.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:194;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0aSXLrJSHeLDpzR8rDMMjPjlnTy6UGM/WiHc5kMF358i8tjHeO179JOHN6fH43fNBPnCgBicfaxDCN+Xiwtarr46N+uftuxdbMAFK1oomNq96jQ6m+6tknlzVyzbE7NPcYzP2BB0LfKBsCmAYA0kaEKhLtv3XbErTRZJym1Xyz5YeEP8N3TWWVHwVP6Pq2rmT3AtxJnIPS2oAOFPGy2sGnPeXP4tDDBCaR0JMRttK7o8DLW1tvxghZGfQIRWvdp93Pkw/7SEwZ3pMueZjxe4cDfmHr1J6vseJmtfY9IICeO4Kldn1ppnJd0C5hZtk3FHFuXDFoW6DMVChfJddP8Zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(30864003)(66556008)(36756003)(5660300002)(83380400001)(66476007)(66946007)(1076003)(2906002)(316002)(478600001)(16526019)(26005)(186003)(956004)(4326008)(6486002)(8676002)(52116002)(7696005)(8936002)(2616005)(6666004)(86362001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qvyYz7LmM6quSZwmgpiTJRKXXdb0nN046maHt35CFjnM/ek2+dBeL4aMr2Pc+YXeib+3B/kPJylJJIAkdQRd/4sRyY8CQYdRfwCAn7CcqsJAoUfA0VNL6dHVEX+jDgyBdqPwWfV0KMqQHRvKxzbFbnzgE7MIGMIety7fj93pShHk382s7xZL3tF8GjFRvvIdqYgOoeIGURvpt9hmzNtivOIBZI5hxutcdi6x6CEwK2+/oFdwyrUZMGTjjHos9Fq9B7feo7lzXKK//T1pb0qcLYasPQ1iMPFdRS0FDu9Ql5ITTgafFFtrLSIsyLjaM06M8fRfcI3/tYLpaf02UJTHqIJn4EE2wcGhGGHXd2lLab+tARuADfmVzKaJwi5cjc5MwLkh8w+DeCrEyhwdxD++/azScO83RFZkiVtSyZiaIUyKbe+f651wGuDUb4G1WiAMIPonQol7uTXisjVO+c3sDKUCus1Jjhj85173Gf+2P+MBeWiL0yhONX+m8PL+m70TqfGs/9vXqF8xaUJIdROy/DmNHBa/UwcHOi1GN1+LR9i1tlsBycShbraMZXGC488UYraAJQc58RAva+EYekJRoOBz93w0iwOvmxMhkzrDnmnLZk4yoQlYbSxMimkycV/MW7Wr0XA8BNzItQ1VeZpPcg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a046cc1-1bce-4274-3160-08d8408658ee
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 19:15:04.4420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAs5WfpWIGMFK/NolHSPaGetRAPDockHXqwFFWIWEUg6V9rzTsmOG8/LL/oYmiGn+knSwnYyFEWJCAHxgIq3Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1700
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Add support for new memory interleaving schemes used in current AMD
systems.

Check if the system is using a current Data Fabric version or a legacy
version as some bit and register definitions have changed.

Tested on AMD reference platforms with the following memory interleaving
options.

Naples
- None
- Channel
- Die
- Socket

Rome (NPS = Nodes per Socket)
- None
- NPS0
- NPS1
- NPS2
- NPS4

The fixes tag refers to the commit that allows amd64_edac_mod to load on
Rome systems. The module may report an incorrect system address on Rome
systems depending on the interleaving option used.

Fixes: 6e846239e548 ("EDAC/amd64: Add Family 17h Model 30h PCI IDs")
Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chtradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chtradhi <naveenkrishna.chatradhi@amd.com>
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 237 +++++++++++++++++++++++++++-------
 1 file changed, 188 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 524edf81e287..a687aa898fef 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -689,18 +689,25 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
+
 	/* We start from the normalized address */
 	u64 ret_addr = norm_addr;
 
 	u32 tmp;
 
-	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
+	bool hash_enabled = false, split_normalized = false, legacy_df = false;
+
 	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
-	u8 intlv_addr_sel, intlv_addr_bit;
-	u8 num_intlv_bits, hashed_bit;
+	u8 intlv_addr_sel, intlv_addr_bit, num_intlv_bits;
+	u8 cs_mask, cs_id = 0, dst_fabric_id = 0;
 	u8 lgcy_mmio_hole_en, base = 0;
-	u8 cs_mask, cs_id = 0;
-	bool hash_enabled = false;
+
+	/* Read D18F1x208 (System Fabric ID Mask 0). */
+	if (amd_df_indirect_read(nid, 1, 0x208, umc, &tmp))
+		goto out_err;
+
+	/* Determine if system is a legacy Data Fabric type. */
+	legacy_df = !(tmp & 0xFF);
 
 	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
 	if (amd_df_indirect_read(nid, 0, 0x1B4, umc, &tmp))
@@ -708,7 +715,12 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 
 	/* Remove HiAddrOffset from normalized address, if enabled: */
 	if (tmp & BIT(0)) {
-		u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;
+		u8 hi_addr_offset_lsb = legacy_df ? 20 : 12;
+		u64 hi_addr_offset = tmp & GENMASK_ULL(31, hi_addr_offset_lsb);
+
+		/* Align to bit 28 regardless of the LSB used. */
+		hi_addr_offset >>= hi_addr_offset_lsb;
+		hi_addr_offset <<= 28;
 
 		if (norm_addr >= hi_addr_offset) {
 			ret_addr -= hi_addr_offset;
@@ -728,23 +740,31 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	}
 
 	lgcy_mmio_hole_en = tmp & BIT(1);
-	intlv_num_chan	  = (tmp >> 4) & 0xF;
-	intlv_addr_sel	  = (tmp >> 8) & 0x7;
-	dram_base_addr	  = (tmp & GENMASK_ULL(31, 12)) << 16;
 
-	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
-	if (intlv_addr_sel > 3) {
-		pr_err("%s: Invalid interleave address select %d.\n",
-			__func__, intlv_addr_sel);
-		goto out_err;
+	if (legacy_df) {
+		intlv_num_chan	  = (tmp >> 4) & 0xF;
+		intlv_addr_sel	  = (tmp >> 8) & 0x7;
+	} else {
+		intlv_num_chan    = (tmp >> 2) & 0xF;
+		intlv_num_dies	  = (tmp >> 6) & 0x3;
+		intlv_num_sockets = (tmp >> 8) & 0x1;
+		intlv_addr_sel	  = (tmp >> 9) & 0x7;
 	}
 
+	dram_base_addr	  = (tmp & GENMASK_ULL(31, 12)) << 16;
+
 	/* Read D18F0x114 (DramLimitAddress). */
 	if (amd_df_indirect_read(nid, 0, 0x114 + (8 * base), umc, &tmp))
 		goto out_err;
 
-	intlv_num_sockets = (tmp >> 8) & 0x1;
-	intlv_num_dies	  = (tmp >> 10) & 0x3;
+	if (legacy_df) {
+		intlv_num_sockets = (tmp >> 8) & 0x1;
+		intlv_num_dies	  = (tmp >> 10) & 0x3;
+		dst_fabric_id	  = tmp & 0xFF;
+	} else {
+		dst_fabric_id	  = tmp & 0x3FF;
+	}
+
 	dram_limit_addr	  = ((tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
 
 	intlv_addr_bit = intlv_addr_sel + 8;
@@ -757,8 +777,27 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	case 5:	intlv_num_chan = 3; break;
 	case 7:	intlv_num_chan = 4; break;
 
-	case 8: intlv_num_chan = 1;
+	case 8:
+		if (legacy_df) {
+			intlv_num_chan = 1;
+			hash_enabled = true;
+		} else {
+			intlv_num_chan = 5;
+		}
+		break;
+	case 12:
+		intlv_num_chan = 1;
+		hash_enabled = true;
+		break;
+	case 13:
+		intlv_num_chan = 2;
+		hash_enabled = true;
+		split_normalized = true;
+		break;
+	case 14:
+		intlv_num_chan = 3;
 		hash_enabled = true;
+		split_normalized = true;
 		break;
 	default:
 		pr_err("%s: Invalid number of interleaved channels %d.\n",
@@ -766,18 +805,14 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		goto out_err;
 	}
 
-	num_intlv_bits = intlv_num_chan;
-
-	if (intlv_num_dies > 2) {
-		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
-			__func__, intlv_num_dies);
+	/* Assert interleave address bit is 8 or 9 for hashing cases. */
+	if (hash_enabled && intlv_addr_bit != 8 && intlv_addr_bit != 9) {
+		pr_err("%s: Invalid interleave address bit for hashing %d.\n",
+			__func__, intlv_addr_bit);
 		goto out_err;
 	}
 
-	num_intlv_bits += intlv_num_dies;
-
-	/* Add a bit if sockets are interleaved. */
-	num_intlv_bits += intlv_num_sockets;
+	num_intlv_bits = intlv_num_chan + intlv_num_dies + intlv_num_sockets;
 
 	/* Assert num_intlv_bits <= 4 */
 	if (num_intlv_bits > 4) {
@@ -787,8 +822,10 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	}
 
 	if (num_intlv_bits > 0) {
-		u64 temp_addr_x, temp_addr_i, temp_addr_y;
+		u8 cs_fabric_id_mask = legacy_df ? 0xFF : 0x3F;
 		u8 die_id_bit, sock_id_bit, cs_fabric_id;
+		u64 addr_x, addr_y, addr_z;
+		u8 node_id_shift = 0;
 
 		/*
 		 * Read FabricBlockInstanceInformation3_CS[BlockFabricID].
@@ -799,7 +836,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		if (amd_df_indirect_read(nid, 0, 0x50, umc, &tmp))
 			goto out_err;
 
-		cs_fabric_id = (tmp >> 8) & 0xFF;
+		cs_fabric_id = (tmp >> 8) & cs_fabric_id_mask;
 		die_id_bit   = 0;
 
 		/* If interleaved over more than 1 channel: */
@@ -807,44 +844,94 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 			die_id_bit = intlv_num_chan;
 			cs_mask	   = (1 << die_id_bit) - 1;
 			cs_id	   = cs_fabric_id & cs_mask;
+			cs_id	  -= dst_fabric_id & cs_mask;
 		}
 
 		sock_id_bit = die_id_bit;
 
-		/* Read D18F1x208 (SystemFabricIdMask). */
-		if (intlv_num_dies || intlv_num_sockets)
-			if (amd_df_indirect_read(nid, 1, 0x208, umc, &tmp))
+		if (intlv_num_dies || intlv_num_sockets) {
+			u16 offset = 0;
+
+			if (legacy_df) {
+				/* Read D18F1x208 (SystemFabricIdMask). */
+				offset = 0x208;
+			} else {
+				/* Read D18F1x20C (SystemFabricIdMask1). */
+				offset = 0x20C;
+			}
+
+			if (amd_df_indirect_read(nid, 1, offset, umc, &tmp))
 				goto out_err;
 
+			if (!legacy_df)
+				node_id_shift = tmp & 0xF;
+		}
+
 		/* If interleaved over more than 1 die. */
 		if (intlv_num_dies) {
+			u8 die_id_shift, die_id_mask;
+
 			sock_id_bit  = die_id_bit + intlv_num_dies;
-			die_id_shift = (tmp >> 24) & 0xF;
-			die_id_mask  = (tmp >> 8) & 0xFF;
+
+			if (legacy_df) {
+				die_id_shift = (tmp >> 24) & 0xF;
+				die_id_mask  = (tmp >> 8) & 0xFF;
+			} else {
+				die_id_shift = (tmp & 0xF) + node_id_shift;
+
+				die_id_mask  = (tmp >> 16) & 0x7;
+				die_id_mask <<= node_id_shift;
+			}
 
 			cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
 		}
 
 		/* If interleaved over more than 1 socket. */
 		if (intlv_num_sockets) {
-			socket_id_shift	= (tmp >> 28) & 0xF;
-			socket_id_mask	= (tmp >> 16) & 0xFF;
+			u8 socket_id_shift, socket_id_mask;
+
+			if (legacy_df) {
+				socket_id_shift	= (tmp >> 28) & 0xF;
+				socket_id_mask	= (tmp >> 16) & 0xFF;
+			} else {
+				socket_id_shift	= (tmp >> 8) & 0x3;
+				socket_id_shift += node_id_shift;
+
+				socket_id_mask	= (tmp >> 24) & 0x7;
+				socket_id_mask <<= node_id_shift;
+			}
 
 			cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
 		}
 
 		/*
 		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
-		 * where III is the ID for this CS, and XXXXXXYYYYY are the
-		 * address bits from the post-interleaved address.
-		 * "num_intlv_bits" has been calculated to tell us how many "I"
-		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
-		 * there are (where "I" starts).
+		 * or XXXXXXIIZZZIYYY where III is the ID for this CS, and
+		 * XXXXXXZZZYYYYY are the address bits from the post-interleaved
+		 * address. "num_intlv_bits" has been calculated to tell us how
+		 * many "I" bits there are. "intlv_addr_bit" tells us how many
+		 * "Y" bits there are (where "I" starts).
+		 *
+		 * The "split" III is only used in the COD modes, where there
+		 * is one bit I at "intlv_addr_bit", and the remaining CS bits
+		 * are higher up starting at bit 12.
 		 */
-		temp_addr_y = ret_addr & GENMASK_ULL(intlv_addr_bit-1, 0);
-		temp_addr_i = (cs_id << intlv_addr_bit);
-		temp_addr_x = (ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
-		ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
+		addr_y = ret_addr & GENMASK_ULL(intlv_addr_bit - 1, 0);
+
+		if (split_normalized) {
+			addr_x = ret_addr & GENMASK_ULL(63, 11);
+			addr_x <<= num_intlv_bits;
+
+			addr_z = ret_addr & GENMASK_ULL(10, intlv_addr_bit);
+			addr_z <<= 1;
+		} else {
+			addr_x = ret_addr & GENMASK_ULL(63, intlv_addr_bit);
+			addr_x <<= num_intlv_bits;
+
+			addr_z = 0;
+		}
+
+		ret_addr = addr_x | addr_z | addr_y;
 	}
 
 	/* Add dram base address */
@@ -860,18 +947,70 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 			ret_addr += (BIT_ULL(32) - dram_hole_base);
 	}
 
-	if (hash_enabled) {
-		/* Save some parentheses and grab ls-bit at the end. */
-		hashed_bit =	(ret_addr >> 12) ^
+	/*
+	 * There are three cases for hashing:
+	 * 1) No Hashing
+	 * 2) Legacy Hashing
+	 * 3) Cluster-on-Die (COD) Hashing
+	 */
+	if (!hash_enabled) {
+		/* Fill in the interleave bit. */
+		if (intlv_num_chan)
+			ret_addr |= (cs_id << intlv_addr_bit);
+	} else if (legacy_df) {
+		/* Legacy 2ch hash. */
+		u8 hashed_bit =	(ret_addr >> 12) ^
 				(ret_addr >> 18) ^
 				(ret_addr >> 21) ^
 				(ret_addr >> 30) ^
 				cs_id;
 
 		hashed_bit &= BIT(0);
+		ret_addr ^= hashed_bit << intlv_addr_bit;
+	} else {
+		u8 hashed_bit, hash_ctl_64K, hash_ctl_2M, hash_ctl_1G;
+
+		/* Read D18F0x3F8 (DfGlobalCtrl)). */
+		if (amd_df_indirect_read(nid, 0, 0x3F8, umc, &tmp))
+			goto out_err;
+
+		hash_ctl_64K = !!(tmp & BIT(20));
+		hash_ctl_2M  = !!(tmp & BIT(21));
+		hash_ctl_1G  = !!(tmp & BIT(22));
+
+		/* COD with 2ch, 4ch, or 8ch hash. */
+		hashed_bit =	(ret_addr >> 14) ^
+				((ret_addr >> 18) & hash_ctl_64K) ^
+				((ret_addr >> 23) & hash_ctl_2M) ^
+				((ret_addr >> 32) & hash_ctl_1G) ^
+				cs_id;
+
+		hashed_bit &= BIT(0);
+		ret_addr ^= hashed_bit << intlv_addr_bit;
+
+		/* COD with 4ch or 8ch hash. */
+		if ((intlv_num_chan == 2) || (intlv_num_chan == 3)) {
+			hashed_bit =	(ret_addr >> 12) ^
+					((ret_addr >> 16) & hash_ctl_64K) ^
+					((ret_addr >> 21) & hash_ctl_2M) ^
+					((ret_addr >> 30) & hash_ctl_1G) ^
+					(cs_id >> 1);
+
+			hashed_bit &= BIT(0);
+			ret_addr ^= hashed_bit << 12;
+		}
+
+		/* COD with 8ch hash. */
+		if (intlv_num_chan == 3) {
+			hashed_bit =	(ret_addr >> 13) ^
+					((ret_addr >> 17) & hash_ctl_64K) ^
+					((ret_addr >> 22) & hash_ctl_2M) ^
+					((ret_addr >> 31) & hash_ctl_1G) ^
+					(cs_id >> 2);
 
-		if (hashed_bit != ((ret_addr >> intlv_addr_bit) & BIT(0)))
-			ret_addr ^= BIT(intlv_addr_bit);
+			hashed_bit &= BIT(0);
+			ret_addr ^= hashed_bit << 13;
+		}
 	}
 
 	/* Is calculated system address is above DRAM limit address? */
-- 
2.25.1

