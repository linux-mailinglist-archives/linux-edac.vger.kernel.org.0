Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E8625C9DB
	for <lists+linux-edac@lfdr.de>; Thu,  3 Sep 2020 22:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgICUCQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Sep 2020 16:02:16 -0400
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com ([40.107.243.76]:37025
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729189AbgICUCP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Sep 2020 16:02:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdSSHwygiS2GvfQOr6Gb5OzmDU98OnSUmIaqW6owagHoECXjjuWy8RRWy57FStiH5Zz1qAsQ3gyn3GGehqoMF91G+dAC2MGAh/HIoqVuSUUBMwblCYJfnXQ+t4Alj8Rrmf6bZpy9MNbkhbnxTK5WpT2YWh2Jd0lxQ/Og6wS6226bMm7+S19kvHsQYmKpWr5iPzeK12H6tkDV58IIJ+HyG/gCZYTdLmP0JUElzcHJB8pdKEK/wYTkY+aOdvL6ZY2ywNzxC1/uatVo+X/U8bppEP0AYrKWE1ltHj7pSvamRZ6llOFg2+bFxAGiOrSW0IrGVQhnApVqK1n5LLqYM+G1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wL+K0+35jp+5RBcZ8g55IvLtLCO2fGs245DbjqqmBU=;
 b=PBoPYxgcn8B38M7fRPwTPcdQSjDS/8hITNj2XLCPxnFpNMS68+z9aB/0q6v5oVOak92kGccGxcPR16eTPufrq+DmL2Vxqkyrpxm9Z2aBWWQTYsjf2sla2bK+Qp4n2t33QSHTAcGz07RDPq023N+9l4w3NLAzCddshFgmijW8v/sJLDBsPXUEV/LNKeyLpN62Zo+YMZIspBPFaz1/6tGrqoWh9//G+ussJXI0VOtfqYyOTgBPljs1HSOI20AIO9soCoohinZcHIy6Hj8/wb/VM/3oTifNDuHqK6GkNth0+PL0ClrPf0jpm9fOCyB1oHreGowBmbLzyslno2CoKAjV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wL+K0+35jp+5RBcZ8g55IvLtLCO2fGs245DbjqqmBU=;
 b=hPrGTq6EH2fVgp3r6DPjcPuQ/Xiw9GIxCnTHcA2ez4mQ3v3sRmJmV6CCOGoUwuv7M36UiDoe1XTm3jmwYQ1CeVEAX0KuMS/5fe0RX6BHLqvpAXVhku/1Zek4yr/+bD5DvqLdNP3G3PdWkevD9hecQkrvBPimnuIpeVshQxNiHKw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3171.namprd12.prod.outlook.com (2603:10b6:408:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 20:01:55 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e%4]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 20:01:55 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH v2 8/8] x86/MCE/AMD Support new memory interleaving modes during address translation
Date:   Thu,  3 Sep 2020 20:01:44 +0000
Message-Id: <20200903200144.310991-9-Yazen.Ghannam@amd.com>
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
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0501CA0075.namprd05.prod.outlook.com (2603:10b6:803:22::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7 via Frontend Transport; Thu, 3 Sep 2020 20:01:54 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7a837af-958e-4336-c4c6-08d8504434d8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3171:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3171BE4125EDB6FCA5FABBEBF82C0@BN8PR12MB3171.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:194;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aojnKdFL8ywx8klVNbA5NHKUFJWVm3W1+9jAYPKC3ekJQKrKdTGJijixX/nU+a8uFuXNAc+qk/wC3AAMKgRwNzLoWj292AWls+zmQaYMMB5PGoCU0RG+2bULq414qccohS9B1EGIefehBq3u5Fn9CTAt+c58ojSgcZLi6HtfiODjgEaj8kQmKsqHlIRvm0f6qL6ayq5pwL9XKSTQep0AKWX42xHn09zJYMsr7A5QBwCVP+8TWOZMBpBGxXfprt85mhHFLNLGeRXHc1HThSXuDnBZ35TlI+MiI3tzYiBCJEszdfTB9IwT9xhi/k05apj7UNvxVE4cr1oETc1fPeLjDK80RMlSozXJz1nZpr4mcd6R4hRCLIuKRxh2Wcd3ocui0QtjcB2O2uX2NRTfWUHTAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(30864003)(8936002)(36756003)(6666004)(478600001)(186003)(316002)(6486002)(966005)(26005)(8676002)(52116002)(16576012)(5660300002)(66476007)(86362001)(4326008)(6916009)(66556008)(2616005)(956004)(66946007)(2906002)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: r8R024xZ/R0eSP9S7EqLMVWAL5jGNtJsFEVJq70bYesiyskqi6hw8rS2pdR6it4R+lfwLM3OXIEgSi7eZCPs5rCTCD863ERlwn3o0IqGd/dkO0ku4yqUeMjxXU3R7UlhJM7Gu7VJ9R4XqBs+HZFCfs97+GFX3R7x5sH1yu4WhJhGOE6G8DU8MMrLTdHihYyFcO1SR/YPw5t8UtoF7nWnskxt3hIFegMnJtdHuNLC4P+AFmdkzifLX1qyWAHlKFJ4BuNjGLdtGOlot8PaILb0Ua0HnZtLY33d26d75AR3gX9jmzlbtQ9eStqDdtC6aBArgFS/QXxF/MrULegJDHAWcRzj8fH+zMFIqt+uJh4uCHtgpWwvDThaX957axpZElF9aeM0X1mqzR3O9zooOFPkddXHo39V7cChXAUThwD9lRyhYNoxZ9XXtpcCaL3OBpAlBZd5zJjgXtTOpVg9XQBsqLSeFT46SJmbwjivI7jdJadGQd2JXruwZGyrUI69e9KKqpjppsKnIPASDccHKeJIh1iJBCMv2NcNMVUFGtUvM21qun31mK3hLFH0bTrP7SrB+hWhrmeKBclXCmHqpaNMcGxaDvrMg2FyDoxq88pm4IWMFVG+IEUQGAnJTyPr4cVeKvvFImONyAYEcF202rLF6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a837af-958e-4336-c4c6-08d8504434d8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 20:01:54.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E55mOxhbkDEoaOTclYYQNHwbz4kYv5OoKYP6ykbkzp/yCtfTADzlapfw8hbIMzNavNclA5MmLTBXrn6U8gQz+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3171
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Add support for new memory interleaving modes used in current AMD systems.

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
Rome systems. The module may report an incorrect system addresses on
Rome systems depending on the interleaving option used.

Fixes: 6e846239e548 ("EDAC/amd64: Add Family 17h Model 30h PCI IDs")
Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chtradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chtradhi <naveenkrishna.chatradhi@amd.com>
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20200814191449.183998-3-Yazen.Ghannam@amd.com

v1 -> v2:
* Rebased on cleanup patches.
* Save and use the Data Fabric version.
* Reorder code to execute non-legacy flows first. This change wasn't
  made to the section with the "hashed_bit" calculation, since the
  current flow reads easier IMHO.

 arch/x86/kernel/cpu/mce/amd.c | 222 ++++++++++++++++++++++++++--------
 1 file changed, 172 insertions(+), 50 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index f5440f8000e9..c14076bcabf2 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -683,8 +683,10 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 #define DF_F0_DRAMBASEADDR	0x110
 #define DF_F0_DRAMLIMITADDR	0x114
 #define DF_F0_DRAMOFFSET	0x1B4
+#define DF_F0_DFGLOBALCTRL	0x3F8
 
 #define DF_F1_SYSFABRICID	0x208
+#define DF_F1_SYSFABRICID1	0x20C
 
 int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
@@ -695,22 +697,30 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	u32 dram_hole_base;
 
 	u32 reg_dram_base_addr, reg_dram_limit_addr;
-	u32 reg_dram_offset;
+	u32 reg_dram_offset, reg_sys_fabric_id;
+
+	bool hash_enabled = false, split_normalized = false;
 
-	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
 	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
-	u8 intlv_addr_sel, intlv_addr_bit;
-	u8 num_intlv_bits, hashed_bit;
+	u8 intlv_addr_sel, intlv_addr_bit, num_intlv_bits;
+	u8 cs_mask, cs_id = 0, dst_fabric_id = 0;
 	u8 lgcy_mmio_hole_en, base = 0;
-	u8 cs_mask, cs_id = 0;
-	bool hash_enabled = false;
+	u8 df_version;
+
+	if (amd_df_indirect_read(nid, 1, DF_F1_SYSFABRICID, umc, &reg_sys_fabric_id))
+		goto out_err;
+
+	df_version = (reg_sys_fabric_id & 0xFF) ? 3 : 2;
 
 	if (amd_df_indirect_read(nid, 0, DF_F0_DRAMOFFSET, umc, &reg_dram_offset))
 		goto out_err;
 
 	/* Remove HiAddrOffset from normalized address, if enabled: */
 	if (reg_dram_offset & BIT(0)) {
-		u64 hi_addr_offset = get_bits(reg_dram_offset, 31, 20) << 28;
+		u8 hi_addr_offset_lsb = (df_version >= 3) ? 12 : 20;
+		u64 hi_addr_offset = get_bits(reg_dram_offset, 31, hi_addr_offset_lsb);
+
+		hi_addr_offset <<= 28;
 
 		/* Check if base 1 is used. */
 		if (norm_addr >= hi_addr_offset) {
@@ -733,19 +743,23 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		goto out_err;
 
 	lgcy_mmio_hole_en = get_bit(reg_dram_base_addr, 1);
-	intlv_num_chan	  = get_bits(reg_dram_base_addr, 7, 4);
-	intlv_addr_sel	  = get_bits(reg_dram_base_addr, 10, 8);
 	dram_base_addr	  = get_bits(reg_dram_base_addr, 31, 12) << 28;
-
-	intlv_num_sockets = get_bit(reg_dram_limit_addr, 8);
-	intlv_num_dies	  = get_bits(reg_dram_limit_addr, 11, 10);
 	dram_limit_addr	  = (get_bits(reg_dram_limit_addr, 31, 12) << 28) | GENMASK_ULL(27, 0);
 
-	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
-	if (intlv_addr_sel > 3) {
-		pr_err("%s: Invalid interleave address select %d.\n",
-			__func__, intlv_addr_sel);
-		goto out_err;
+	if (df_version >= 3) {
+		intlv_num_chan    = get_bits(reg_dram_base_addr, 5, 2);
+		intlv_num_dies    = get_bits(reg_dram_base_addr, 7, 6);
+		intlv_num_sockets = get_bit(reg_dram_base_addr, 8);
+		intlv_addr_sel    = get_bits(reg_dram_base_addr, 11, 9);
+
+		dst_fabric_id	  = get_bits(reg_dram_limit_addr, 9, 0);
+	} else {
+		intlv_num_chan	  = get_bits(reg_dram_base_addr, 7, 4);
+		intlv_addr_sel	  = get_bits(reg_dram_base_addr, 10, 8);
+
+		dst_fabric_id	  = get_bits(reg_dram_limit_addr, 7, 0);
+		intlv_num_sockets = get_bit(reg_dram_limit_addr, 8);
+		intlv_num_dies	  = get_bits(reg_dram_limit_addr, 11, 10);
 	}
 
 	intlv_addr_bit = intlv_addr_sel + 8;
@@ -758,27 +772,42 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	case 5:	intlv_num_chan = 3; break;
 	case 7:	intlv_num_chan = 4; break;
 
-	case 8: intlv_num_chan = 1;
+	case 8:
+		if (df_version >= 3) {
+			intlv_num_chan = 5;
+		} else {
+			intlv_num_chan = 1;
+			hash_enabled = true;
+		}
+		break;
+	case 12:
+		intlv_num_chan = 1;
 		hash_enabled = true;
 		break;
+	case 13:
+		intlv_num_chan = 2;
+		hash_enabled = true;
+		split_normalized = true;
+		break;
+	case 14:
+		intlv_num_chan = 3;
+		hash_enabled = true;
+		split_normalized = true;
+		break;
 	default:
 		pr_err("%s: Invalid number of interleaved channels %d.\n",
 			__func__, intlv_num_chan);
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
@@ -788,9 +817,11 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	}
 
 	if (num_intlv_bits > 0) {
-		u64 temp_addr_x, temp_addr_i, temp_addr_y;
-		u32 reg_sys_fabric_id, cs_fabric_id;
+		u8 cs_fabric_id_msb = (df_version >= 3) ? 13 : 15;
 		u8 die_id_bit, sock_id_bit;
+		u64 addr_x, addr_y, addr_z;
+		u8 node_id_shift = 0;
+		u32 cs_fabric_id;
 
 		/*
 		 * This is the fabric id for this coherent slave. Use
@@ -800,7 +831,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		if (amd_df_indirect_read(nid, 0, DF_F0_FABRICINSTINFO3, umc, &cs_fabric_id))
 			goto out_err;
 
-		cs_fabric_id = get_bits(cs_fabric_id, 15, 8);
+		cs_fabric_id = get_bits(cs_fabric_id, cs_fabric_id_msb, 8);
 		die_id_bit   = 0;
 
 		/* If interleaved over more than 1 channel: */
@@ -808,43 +839,83 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 			die_id_bit = intlv_num_chan;
 			cs_mask	   = (1 << die_id_bit) - 1;
 			cs_id	   = cs_fabric_id & cs_mask;
+			cs_id	  -= dst_fabric_id & cs_mask;
 		}
 
 		sock_id_bit = die_id_bit;
 
-		if (intlv_num_dies || intlv_num_sockets)
-			if (amd_df_indirect_read(nid, 1, DF_F1_SYSFABRICID, umc, &reg_sys_fabric_id))
+		if ((intlv_num_dies || intlv_num_sockets) && df_version >= 3) {
+			if (amd_df_indirect_read(nid, 1, DF_F1_SYSFABRICID1, umc, &reg_sys_fabric_id))
 				goto out_err;
 
+			node_id_shift = get_bits(reg_sys_fabric_id, 3, 0);
+		}
+
 		/* If interleaved over more than 1 die. */
 		if (intlv_num_dies) {
+			u8 die_id_shift, die_id_mask;
+
 			sock_id_bit  = die_id_bit + intlv_num_dies;
-			die_id_shift = get_bits(reg_sys_fabric_id, 27, 24);
-			die_id_mask  = get_bits(reg_sys_fabric_id, 15, 8);
+
+			if (df_version >= 3) {
+				die_id_shift = get_bits(reg_sys_fabric_id, 3, 0) + node_id_shift;
+
+				die_id_mask  = get_bits(reg_sys_fabric_id, 18, 16);
+				die_id_mask <<= node_id_shift;
+			} else {
+				die_id_shift = get_bits(reg_sys_fabric_id, 27, 24);
+				die_id_mask  = get_bits(reg_sys_fabric_id, 15, 8);
+			}
 
 			cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
 		}
 
 		/* If interleaved over more than 1 socket. */
 		if (intlv_num_sockets) {
-			socket_id_shift	= get_bits(reg_sys_fabric_id, 31, 28);
-			socket_id_mask	= get_bits(reg_sys_fabric_id, 23, 16);
+			u8 socket_id_shift, socket_id_mask;
+
+			if (df_version >= 3) {
+				socket_id_shift	= get_bits(reg_sys_fabric_id, 10, 8);
+				socket_id_shift += node_id_shift;
+
+				socket_id_mask	= get_bits(reg_sys_fabric_id, 26, 24);
+				socket_id_mask <<= node_id_shift;
+			} else {
+				socket_id_shift	= get_bits(reg_sys_fabric_id, 31, 28);
+				socket_id_mask	= get_bits(reg_sys_fabric_id, 23, 16);
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
-		temp_addr_y = get_bits(ret_addr, intlv_addr_bit-1, 0);
-		temp_addr_i = (cs_id << intlv_addr_bit);
-		temp_addr_x = (ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
-		ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
+		addr_y = get_bits(ret_addr, intlv_addr_bit - 1, 0);
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
@@ -860,18 +931,69 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 			ret_addr += (BIT_ULL(32) - dram_hole_base);
 	}
 
-	if (hash_enabled) {
-		hashed_bit =	get_bit(ret_addr, 12) ^
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
+	} else if (df_version == 2) {
+		/* Legacy 2ch hash. */
+		u8 hashed_bit =	get_bit(ret_addr, 12) ^
 				get_bit(ret_addr, 18) ^
 				get_bit(ret_addr, 21) ^
 				get_bit(ret_addr, 30) ^
 				get_bit(cs_id, 0);
 
-		if (hashed_bit != get_bit(ret_addr, intlv_addr_bit))
-			ret_addr ^= BIT(intlv_addr_bit);
+		ret_addr ^= hashed_bit << intlv_addr_bit;
+	} else {
+		u8 hashed_bit, hash_ctl_64K, hash_ctl_2M, hash_ctl_1G;
+		u32 reg_df_global_ctrl;
+
+		if (amd_df_indirect_read(nid, 0, DF_F0_DFGLOBALCTRL, umc, &reg_df_global_ctrl))
+			goto out_err;
+
+		hash_ctl_64K = get_bit(reg_df_global_ctrl, 20);
+		hash_ctl_2M  = get_bit(reg_df_global_ctrl, 21);
+		hash_ctl_1G  = get_bit(reg_df_global_ctrl, 22);
+
+		/* COD with 2ch, 4ch, or 8ch hash. */
+		hashed_bit =	get_bit(ret_addr, 14) ^
+				(get_bit(ret_addr, 18) & hash_ctl_64K) ^
+				(get_bit(ret_addr, 23) & hash_ctl_2M) ^
+				(get_bit(ret_addr, 32) & hash_ctl_1G) ^
+				get_bit(cs_id, 0);
+
+		ret_addr ^= hashed_bit << intlv_addr_bit;
+
+		/* COD with 4ch or 8ch hash. */
+		if ((intlv_num_chan == 2) || (intlv_num_chan == 3)) {
+			hashed_bit =	get_bit(ret_addr, 12) ^
+					(get_bit(ret_addr, 16) & hash_ctl_64K) ^
+					(get_bit(ret_addr, 21) & hash_ctl_2M) ^
+					(get_bit(ret_addr, 30) & hash_ctl_1G) ^
+					get_bit(cs_id, 1);
+
+			ret_addr ^= hashed_bit << 12;
+		}
+
+		/* COD with 8ch hash. */
+		if (intlv_num_chan == 3) {
+			hashed_bit =	get_bit(ret_addr, 13) ^
+					(get_bit(ret_addr, 17) & hash_ctl_64K) ^
+					(get_bit(ret_addr, 22) & hash_ctl_2M) ^
+					(get_bit(ret_addr, 31) & hash_ctl_1G) ^
+					get_bit(cs_id, 2);
+
+			ret_addr ^= hashed_bit << 13;
+		}
 	}
 
-	/* Is calculated system address is above DRAM limit address? */
+	/* Is calculated system address above DRAM limit address? */
 	if (ret_addr > dram_limit_addr)
 		goto out_err;
 
-- 
2.25.1

