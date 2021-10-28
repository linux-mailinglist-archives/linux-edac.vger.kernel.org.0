Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AEB43E7A0
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhJ1SAg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:00:36 -0400
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:13088
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230350AbhJ1SA1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXn9zxWsXc/y2BHJCBd1kuOdjvPj7ad9RVgtE3wb5yCRpo7pXkLqXuZ57uYjfTNYeStddJxzCi3fGkAPRD/Y9gOElA5aZfzciwEd6yV+Bh3zu8u08sWOKdnfIbhbGmW9gJ9fjzICUqzPNwdE1BJYq1glEf2z+0OgBbi7jiuMNQckAhpkF+1z9CdH0+g6Pqqbq50XM8hCNrUHSRi1ItOnSkrJxZlOgxsQQZQYPdinRk2KjvMYKj0X/YUBnK5vmyWnmDckANYzJ/nJXH7wjOOWkVqgMBd4/qIn76XiCL+syFXn/SczXX+hV/2bCbN9IudHLQoJhE8Q7c+nnavawm1sSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gt+kNkjYKki1WHInWJf+7mNmXVUOwpcLqrCe1mL04RA=;
 b=XEc/AsqCy5GrIb2eu7pLTCyizyKdMxTNX4xMa6PgXjZ2qtrpYb7RuiTkTabhR6iTfvwXXqFnxR7KOpOQpNmtVSnk5fBVNfXpHA4Es0gnYATldlj8G6xxd0PEghdeZcnoJqkjwEMoKHGYwS/m8cVPOcg8JIS4NpdbZ27TdZCIsuZrE5Fw2MkX72uXqji7mNeUA5JZgs0eBog5el4JSaFHbJJCHPHovFtB29HU1kfcK6MR/1hRqXhL8IbNJO9Wx0Ptx2d+XOE4t1+6yvtO5qGmqkB9os+IhwyEjrOLUivd9Vmgc6cUQrN9o/GAqq6eBvG/zpdWTqMzSMXxK4M7latpjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt+kNkjYKki1WHInWJf+7mNmXVUOwpcLqrCe1mL04RA=;
 b=L2TCDCOVyHZnQ9KZiFFIDs0hphou2wFsY87ATZl6L4Df3G/quCWHIhvblv2YT4p4rlLVoV8zUZceRFwEMYok8c9zXl6w5AMzYk3bPLLxiSqJ5QXV/ZjL9oEv/WmvcldSopYylpeSzaKMQHQZqq9BZQ2rGzGByLLqx3OOsJ/DPJs=
Received: from MWHPR10CA0023.namprd10.prod.outlook.com (2603:10b6:301::33) by
 DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Thu, 28 Oct 2021 17:57:57 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::f6) by MWHPR10CA0023.outlook.office365.com
 (2603:10b6:301::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 17:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:57:56 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:57:53 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>, <x86@kernel.org>
Subject: [PATCH v3 01/33] x86/MCE/AMD, EDAC/amd64: Move address translation to AMD64 EDAC
Date:   Thu, 28 Oct 2021 17:56:56 +0000
Message-ID: <20211028175728.121452-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028175728.121452-1-yazen.ghannam@amd.com>
References: <20211028175728.121452-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ee62060-9e87-4152-8a20-08d99a3c7918
X-MS-TrafficTypeDiagnostic: DM6PR12MB4354:
X-Microsoft-Antispam-PRVS: <DM6PR12MB435412E14BA6E9C0761569D8F8869@DM6PR12MB4354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w5VT49ZZSMLISC0+IsAE8gcsc0M+0bmpDzPFx4vgEjEEKLxmTtYN/I2v5fDhSik9f2R3QASBWqEZvq/0nK3Bcp2mG7H7wi0mrodBNLP04SFQMMlLL6BS3iHU84Yqb89p7opkER+1lbhty6JQIimRttDsXkFVsu+YLnbD/TlewNsfOS3LDTW2CwFbeopLMW/TZ0JUFNcRab/6IpkRjSbciyElxQYjZbCS6DCroGdYbW2mdAni9rbn/vnkwcC27A4yIMCkEjVpNXttNivTVAkkXa41CHXSvz9ak24taNe1QbL/XwIJq+K87dL7LOtifliMHlFNgAUY2CUQUKzxl3Ng9BEESZl9coRIJn10vgAecSld7ajVcnLbymKGmcVff3G0YJ9g0b2EtN3FX8eXfL5D0qHyirvuk4Zp2OFXeR09teoZ0iLZtfED5Wl9BRM7PfNeMq2ECfAHFNyIp6yVg7rWMGQzD4EU9CnT/ufIb5OGok+zokdo4CnMIPTjbuH1puvAWNLZeP1IuUzYoF8SYwEDqKVdJdJeDyqD3TZULacxPfCBnymkQFkZeOrN1xNwvyB3rX3a0uvFH5zdhRr5ziabexKh5iBK+/pm7W+sePmXcP7sZ+fR12z6p3lMubJRWIP40QZbxbqF1pYxCUbismvl1eqJ/xL4SmzDlngQxwPBfKOVL4vr8AXSS3KijJjaQxS3Ws8KG6GA5NY+Ks1siMAmN+zyldZqTDpE4oe8HxdvgN33HjL0zl8RYEQTvIs6uqVQ2wKzssQe7t/K2Mxqs9XqVQo90JKE3xfuHdl+RaCQKIjs3w10R+L7eYbuePaZ6DzU
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(47076005)(83380400001)(36860700001)(356005)(1076003)(86362001)(82310400003)(81166007)(44832011)(4326008)(426003)(2616005)(70586007)(7696005)(6916009)(5660300002)(966005)(30864003)(508600001)(70206006)(336012)(2906002)(26005)(8936002)(8676002)(54906003)(36756003)(316002)(16526019)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:57:56.8353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee62060-9e87-4152-8a20-08d99a3c7918
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The address translation code used for current AMD systems is
non-architectural. So move it to EDAC.

Cc: <x86@kernel.org>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-2-yazen.ghannam@amd.com

v2->v3:
* No change.

v1->v2:
* New in v2.

 arch/x86/include/asm/mce.h    |   3 -
 arch/x86/kernel/cpu/mce/amd.c | 200 ----------------------------------
 drivers/edac/amd64_edac.c     | 199 +++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+), 203 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 813b4f5b0dd6..1d994b3d2419 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -345,7 +345,6 @@ extern int mce_threshold_create_device(unsigned int cpu);
 extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
-int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr);
 
 #else
 
@@ -353,8 +352,6 @@ static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
 static inline int mce_threshold_remove_device(unsigned int cpu)		{ return 0; };
 static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
-static inline int
-umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)	{ return -EINVAL; };
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 27cacf504663..1b436560a2ac 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -688,206 +688,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 		deferred_error_interrupt_enable(c);
 }
 
-int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
-{
-	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
-	/* We start from the normalized address */
-	u64 ret_addr = norm_addr;
-
-	u32 tmp;
-
-	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
-	u8 intlv_addr_sel, intlv_addr_bit;
-	u8 num_intlv_bits, hashed_bit;
-	u8 lgcy_mmio_hole_en, base = 0;
-	u8 cs_mask, cs_id = 0;
-	bool hash_enabled = false;
-
-	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
-	if (amd_df_indirect_read(nid, 0, 0x1B4, umc, &tmp))
-		goto out_err;
-
-	/* Remove HiAddrOffset from normalized address, if enabled: */
-	if (tmp & BIT(0)) {
-		u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;
-
-		if (norm_addr >= hi_addr_offset) {
-			ret_addr -= hi_addr_offset;
-			base = 1;
-		}
-	}
-
-	/* Read D18F0x110 (DramBaseAddress). */
-	if (amd_df_indirect_read(nid, 0, 0x110 + (8 * base), umc, &tmp))
-		goto out_err;
-
-	/* Check if address range is valid. */
-	if (!(tmp & BIT(0))) {
-		pr_err("%s: Invalid DramBaseAddress range: 0x%x.\n",
-			__func__, tmp);
-		goto out_err;
-	}
-
-	lgcy_mmio_hole_en = tmp & BIT(1);
-	intlv_num_chan	  = (tmp >> 4) & 0xF;
-	intlv_addr_sel	  = (tmp >> 8) & 0x7;
-	dram_base_addr	  = (tmp & GENMASK_ULL(31, 12)) << 16;
-
-	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
-	if (intlv_addr_sel > 3) {
-		pr_err("%s: Invalid interleave address select %d.\n",
-			__func__, intlv_addr_sel);
-		goto out_err;
-	}
-
-	/* Read D18F0x114 (DramLimitAddress). */
-	if (amd_df_indirect_read(nid, 0, 0x114 + (8 * base), umc, &tmp))
-		goto out_err;
-
-	intlv_num_sockets = (tmp >> 8) & 0x1;
-	intlv_num_dies	  = (tmp >> 10) & 0x3;
-	dram_limit_addr	  = ((tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
-
-	intlv_addr_bit = intlv_addr_sel + 8;
-
-	/* Re-use intlv_num_chan by setting it equal to log2(#channels) */
-	switch (intlv_num_chan) {
-	case 0:	intlv_num_chan = 0; break;
-	case 1: intlv_num_chan = 1; break;
-	case 3: intlv_num_chan = 2; break;
-	case 5:	intlv_num_chan = 3; break;
-	case 7:	intlv_num_chan = 4; break;
-
-	case 8: intlv_num_chan = 1;
-		hash_enabled = true;
-		break;
-	default:
-		pr_err("%s: Invalid number of interleaved channels %d.\n",
-			__func__, intlv_num_chan);
-		goto out_err;
-	}
-
-	num_intlv_bits = intlv_num_chan;
-
-	if (intlv_num_dies > 2) {
-		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
-			__func__, intlv_num_dies);
-		goto out_err;
-	}
-
-	num_intlv_bits += intlv_num_dies;
-
-	/* Add a bit if sockets are interleaved. */
-	num_intlv_bits += intlv_num_sockets;
-
-	/* Assert num_intlv_bits <= 4 */
-	if (num_intlv_bits > 4) {
-		pr_err("%s: Invalid interleave bits %d.\n",
-			__func__, num_intlv_bits);
-		goto out_err;
-	}
-
-	if (num_intlv_bits > 0) {
-		u64 temp_addr_x, temp_addr_i, temp_addr_y;
-		u8 die_id_bit, sock_id_bit, cs_fabric_id;
-
-		/*
-		 * Read FabricBlockInstanceInformation3_CS[BlockFabricID].
-		 * This is the fabric id for this coherent slave. Use
-		 * umc/channel# as instance id of the coherent slave
-		 * for FICAA.
-		 */
-		if (amd_df_indirect_read(nid, 0, 0x50, umc, &tmp))
-			goto out_err;
-
-		cs_fabric_id = (tmp >> 8) & 0xFF;
-		die_id_bit   = 0;
-
-		/* If interleaved over more than 1 channel: */
-		if (intlv_num_chan) {
-			die_id_bit = intlv_num_chan;
-			cs_mask	   = (1 << die_id_bit) - 1;
-			cs_id	   = cs_fabric_id & cs_mask;
-		}
-
-		sock_id_bit = die_id_bit;
-
-		/* Read D18F1x208 (SystemFabricIdMask). */
-		if (intlv_num_dies || intlv_num_sockets)
-			if (amd_df_indirect_read(nid, 1, 0x208, umc, &tmp))
-				goto out_err;
-
-		/* If interleaved over more than 1 die. */
-		if (intlv_num_dies) {
-			sock_id_bit  = die_id_bit + intlv_num_dies;
-			die_id_shift = (tmp >> 24) & 0xF;
-			die_id_mask  = (tmp >> 8) & 0xFF;
-
-			cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
-		}
-
-		/* If interleaved over more than 1 socket. */
-		if (intlv_num_sockets) {
-			socket_id_shift	= (tmp >> 28) & 0xF;
-			socket_id_mask	= (tmp >> 16) & 0xFF;
-
-			cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
-		}
-
-		/*
-		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
-		 * where III is the ID for this CS, and XXXXXXYYYYY are the
-		 * address bits from the post-interleaved address.
-		 * "num_intlv_bits" has been calculated to tell us how many "I"
-		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
-		 * there are (where "I" starts).
-		 */
-		temp_addr_y = ret_addr & GENMASK_ULL(intlv_addr_bit-1, 0);
-		temp_addr_i = (cs_id << intlv_addr_bit);
-		temp_addr_x = (ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
-		ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
-	}
-
-	/* Add dram base address */
-	ret_addr += dram_base_addr;
-
-	/* If legacy MMIO hole enabled */
-	if (lgcy_mmio_hole_en) {
-		if (amd_df_indirect_read(nid, 0, 0x104, umc, &tmp))
-			goto out_err;
-
-		dram_hole_base = tmp & GENMASK(31, 24);
-		if (ret_addr >= dram_hole_base)
-			ret_addr += (BIT_ULL(32) - dram_hole_base);
-	}
-
-	if (hash_enabled) {
-		/* Save some parentheses and grab ls-bit at the end. */
-		hashed_bit =	(ret_addr >> 12) ^
-				(ret_addr >> 18) ^
-				(ret_addr >> 21) ^
-				(ret_addr >> 30) ^
-				cs_id;
-
-		hashed_bit &= BIT(0);
-
-		if (hashed_bit != ((ret_addr >> intlv_addr_bit) & BIT(0)))
-			ret_addr ^= BIT(intlv_addr_bit);
-	}
-
-	/* Is calculated system address is above DRAM limit address? */
-	if (ret_addr > dram_limit_addr)
-		goto out_err;
-
-	*sys_addr = ret_addr;
-	return 0;
-
-out_err:
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(umc_normaddr_to_sysaddr);
-
 bool amd_mce_is_memory_error(struct mce *m)
 {
 	/* ErrCodeExt[20:16] */
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index a0dc7ffe63d6..9b87aa38803d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -986,6 +986,205 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 	return csrow;
 }
 
+static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+{
+	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
+	/* We start from the normalized address */
+	u64 ret_addr = norm_addr;
+
+	u32 tmp;
+
+	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
+	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
+	u8 intlv_addr_sel, intlv_addr_bit;
+	u8 num_intlv_bits, hashed_bit;
+	u8 lgcy_mmio_hole_en, base = 0;
+	u8 cs_mask, cs_id = 0;
+	bool hash_enabled = false;
+
+	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
+	if (amd_df_indirect_read(nid, 0, 0x1B4, umc, &tmp))
+		goto out_err;
+
+	/* Remove HiAddrOffset from normalized address, if enabled: */
+	if (tmp & BIT(0)) {
+		u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;
+
+		if (norm_addr >= hi_addr_offset) {
+			ret_addr -= hi_addr_offset;
+			base = 1;
+		}
+	}
+
+	/* Read D18F0x110 (DramBaseAddress). */
+	if (amd_df_indirect_read(nid, 0, 0x110 + (8 * base), umc, &tmp))
+		goto out_err;
+
+	/* Check if address range is valid. */
+	if (!(tmp & BIT(0))) {
+		pr_err("%s: Invalid DramBaseAddress range: 0x%x.\n",
+			__func__, tmp);
+		goto out_err;
+	}
+
+	lgcy_mmio_hole_en = tmp & BIT(1);
+	intlv_num_chan	  = (tmp >> 4) & 0xF;
+	intlv_addr_sel	  = (tmp >> 8) & 0x7;
+	dram_base_addr	  = (tmp & GENMASK_ULL(31, 12)) << 16;
+
+	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
+	if (intlv_addr_sel > 3) {
+		pr_err("%s: Invalid interleave address select %d.\n",
+			__func__, intlv_addr_sel);
+		goto out_err;
+	}
+
+	/* Read D18F0x114 (DramLimitAddress). */
+	if (amd_df_indirect_read(nid, 0, 0x114 + (8 * base), umc, &tmp))
+		goto out_err;
+
+	intlv_num_sockets = (tmp >> 8) & 0x1;
+	intlv_num_dies	  = (tmp >> 10) & 0x3;
+	dram_limit_addr	  = ((tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
+
+	intlv_addr_bit = intlv_addr_sel + 8;
+
+	/* Re-use intlv_num_chan by setting it equal to log2(#channels) */
+	switch (intlv_num_chan) {
+	case 0:	intlv_num_chan = 0; break;
+	case 1: intlv_num_chan = 1; break;
+	case 3: intlv_num_chan = 2; break;
+	case 5:	intlv_num_chan = 3; break;
+	case 7:	intlv_num_chan = 4; break;
+
+	case 8: intlv_num_chan = 1;
+		hash_enabled = true;
+		break;
+	default:
+		pr_err("%s: Invalid number of interleaved channels %d.\n",
+			__func__, intlv_num_chan);
+		goto out_err;
+	}
+
+	num_intlv_bits = intlv_num_chan;
+
+	if (intlv_num_dies > 2) {
+		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
+			__func__, intlv_num_dies);
+		goto out_err;
+	}
+
+	num_intlv_bits += intlv_num_dies;
+
+	/* Add a bit if sockets are interleaved. */
+	num_intlv_bits += intlv_num_sockets;
+
+	/* Assert num_intlv_bits <= 4 */
+	if (num_intlv_bits > 4) {
+		pr_err("%s: Invalid interleave bits %d.\n",
+			__func__, num_intlv_bits);
+		goto out_err;
+	}
+
+	if (num_intlv_bits > 0) {
+		u64 temp_addr_x, temp_addr_i, temp_addr_y;
+		u8 die_id_bit, sock_id_bit, cs_fabric_id;
+
+		/*
+		 * Read FabricBlockInstanceInformation3_CS[BlockFabricID].
+		 * This is the fabric id for this coherent slave. Use
+		 * umc/channel# as instance id of the coherent slave
+		 * for FICAA.
+		 */
+		if (amd_df_indirect_read(nid, 0, 0x50, umc, &tmp))
+			goto out_err;
+
+		cs_fabric_id = (tmp >> 8) & 0xFF;
+		die_id_bit   = 0;
+
+		/* If interleaved over more than 1 channel: */
+		if (intlv_num_chan) {
+			die_id_bit = intlv_num_chan;
+			cs_mask	   = (1 << die_id_bit) - 1;
+			cs_id	   = cs_fabric_id & cs_mask;
+		}
+
+		sock_id_bit = die_id_bit;
+
+		/* Read D18F1x208 (SystemFabricIdMask). */
+		if (intlv_num_dies || intlv_num_sockets)
+			if (amd_df_indirect_read(nid, 1, 0x208, umc, &tmp))
+				goto out_err;
+
+		/* If interleaved over more than 1 die. */
+		if (intlv_num_dies) {
+			sock_id_bit  = die_id_bit + intlv_num_dies;
+			die_id_shift = (tmp >> 24) & 0xF;
+			die_id_mask  = (tmp >> 8) & 0xFF;
+
+			cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
+		}
+
+		/* If interleaved over more than 1 socket. */
+		if (intlv_num_sockets) {
+			socket_id_shift	= (tmp >> 28) & 0xF;
+			socket_id_mask	= (tmp >> 16) & 0xFF;
+
+			cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
+		}
+
+		/*
+		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
+		 * where III is the ID for this CS, and XXXXXXYYYYY are the
+		 * address bits from the post-interleaved address.
+		 * "num_intlv_bits" has been calculated to tell us how many "I"
+		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
+		 * there are (where "I" starts).
+		 */
+		temp_addr_y = ret_addr & GENMASK_ULL(intlv_addr_bit-1, 0);
+		temp_addr_i = (cs_id << intlv_addr_bit);
+		temp_addr_x = (ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
+		ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
+	}
+
+	/* Add dram base address */
+	ret_addr += dram_base_addr;
+
+	/* If legacy MMIO hole enabled */
+	if (lgcy_mmio_hole_en) {
+		if (amd_df_indirect_read(nid, 0, 0x104, umc, &tmp))
+			goto out_err;
+
+		dram_hole_base = tmp & GENMASK(31, 24);
+		if (ret_addr >= dram_hole_base)
+			ret_addr += (BIT_ULL(32) - dram_hole_base);
+	}
+
+	if (hash_enabled) {
+		/* Save some parentheses and grab ls-bit at the end. */
+		hashed_bit =	(ret_addr >> 12) ^
+				(ret_addr >> 18) ^
+				(ret_addr >> 21) ^
+				(ret_addr >> 30) ^
+				cs_id;
+
+		hashed_bit &= BIT(0);
+
+		if (hashed_bit != ((ret_addr >> intlv_addr_bit) & BIT(0)))
+			ret_addr ^= BIT(intlv_addr_bit);
+	}
+
+	/* Is calculated system address is above DRAM limit address? */
+	if (ret_addr > dram_limit_addr)
+		goto out_err;
+
+	*sys_addr = ret_addr;
+	return 0;
+
+out_err:
+	return -EINVAL;
+}
+
 static int get_channel_from_ecc_syndrome(struct mem_ctl_info *, u16);
 
 /*
-- 
2.25.1

