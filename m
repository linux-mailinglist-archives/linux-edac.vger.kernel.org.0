Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BFF25C9E1
	for <lists+linux-edac@lfdr.de>; Thu,  3 Sep 2020 22:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgICUCd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Sep 2020 16:02:33 -0400
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com ([40.107.243.76]:37025
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729167AbgICUCG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Sep 2020 16:02:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzW45zftCfQ2MKXwtqSTDXL6sHaNmYtoa3MUbmOvA4aO6fHYuLbr0/2o7Z87HXBvb0Rvz0kSZ2xijQvYtu6RZ0c+kxkbG6GymKNB+iPHb6GbdN2I4ua92B8Pb76Yp3O53zc2Z2muKNgiyIGYtoxoSV/cXoj95phRL8BZqXvn3gJLZxyH+1tFyEAejmWfyOzdcbn7upYVielWBOZt7L3D3vEi+hjMyXzCtjOmvlFkCJImxAqWG6zejdTV69rtF8BYqjyA2vIhVMua6y8ikaUwJeuc4T64nRG4CxkfW235XuFwR4Zm0tTr1VTIxacW7KHDDR1wK3c15kSKMsqoEPQeJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucPeJWZvU4VeeCP69obVhfXzhw8HJU8SmiF0vmCrvNQ=;
 b=i+AX3Tx29TI5RinyKTx4I/8cfce7i92NRU45ju86jdjN0sFV3CzB3XDI8rsdyZbpBxkMa2Lt3XZ6yZrZg1gPlIqFWOcL+aDuY0jmt9EEwhOCa335+1i+j6ZLsLFSYhBbMS6Zi5Er9UR9f3tIDf899115st3Xn4eG8tviZRR8J3iwmVo2HgxyYOyLvqpEU5QSVSqN3Uh9bqoF8wqo4Qs8mu+69p7Ug93MX+mvXizCIK0lGey9OM0Nlct0bOmk3GPNHj/a6+UysB8zvo7RCR9TxLMUUpgDMSlanhLnygndOBB3a30HuRv2DrQ9WY3tkFGCtoixnYqH4hn58NNKmBHBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucPeJWZvU4VeeCP69obVhfXzhw8HJU8SmiF0vmCrvNQ=;
 b=lsyIBTosugRpWH96fJ8A+cMFOSiGxS/UdzRrhR1UVe0dUk+r4RwXsFSr7aI0D513mZHSjlDD5dSaK2clNh0nYiOnkP+a6fLoH8i6f9nlt2ss19Etr0481mR2YBNOf3DQOyGgxFkDggvKkT1kZp8+F5HcBD3b5wP0JZBTTmlwSfk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3171.namprd12.prod.outlook.com (2603:10b6:408:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 20:01:53 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e%4]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 20:01:53 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH v2 6/8] x86/MCE/AMD: Drop tmp variable in translation code
Date:   Thu,  3 Sep 2020 20:01:42 +0000
Message-Id: <20200903200144.310991-7-Yazen.Ghannam@amd.com>
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
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0501CA0075.namprd05.prod.outlook.com (2603:10b6:803:22::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7 via Frontend Transport; Thu, 3 Sep 2020 20:01:52 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b2d4382-5466-48a4-f807-08d8504433f0
X-MS-TrafficTypeDiagnostic: BN8PR12MB3171:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB31718595330745FAD24852FFF82C0@BN8PR12MB3171.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYDcXg1kFC9OY0oQeid9RZuD4blF9452qN3H3lkMZ0aBYJG6ZH6vVRFpL7MVMPw4El2nWoNjyT1tTOeA8ltBWSW1cjUGgqMRBNm+sfBBlO274MR+iF5Sd1pMOxK3ZARZ6m+YjtL8mW24uqfmQ+fdS7qIcsMY0ZcmAxBgDB4OPGmS/LfzzCcgZjAG+YOgWg1jNHAi5c9XgU9Y2GA7odk41keJUA3W+25ump8omJ4Cman+BEHHQRAbQWISzIMR3wsmrwv/Phj79/C8qqUiMUqHRb5s30d2OOaQFJjXy5c8+yVcV20ARQFi0baTRGhkQHQTrtlE/sb9VkSdO03dDKOaBYzB6fHjz6CNaEflbHMxT9fWwY9MIXcT1kwbGsn9PbqyHIyu4gnsgZ0MqHQXR7iQ2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(8936002)(36756003)(6666004)(478600001)(186003)(316002)(6486002)(966005)(26005)(8676002)(52116002)(16576012)(5660300002)(66476007)(86362001)(4326008)(6916009)(66556008)(2616005)(956004)(66946007)(2906002)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4pIoAnThfi6zUnRc96deIGmmkajYRMOjLqQSkgAq8kRlJwqqc5hJ4y1kDC033/eK+YSQq/SE67rsBBp+KfTpOns2y8KtWlQitemdgSatcgfC+lkvVjyaHZyNS5/1OS0JF4lZPXh2htvrsOKKOtOR/odgn96T8a6P5jtU61Tx/jupbOEARQp20Pk/d+KQvmZVJbRjBpXaghJyy7Jc4B460SHDRRMutvbaDLjEZ+Est/Z9b8m8Ilx0gwrPiycxdA/wAnFO7r/HRiN2Kbi7g3hifj6ZBQOQdUmDplzVu0LoOuwyOfPhgvG6Bu0aeXRBNMOeNkDf/XSazEsDdAdkkjKBzcp4yTc8ZfnT7TnkxkwvgW3bnLdVKm+oIOo/+bN0MOs6iKllGonof+k2ldA7FXrn79PfTq+DI15tCQxjJkoApPezfzrkNehDlUHwBkscVdaVgYL3LrHU5soB7+HI/4siGxYy8kRCFRFIL2DYvh/1uLEVIhQsLUvV14vCTa7ZqSrgv5ZsefE9adBs4QNPb/Ndl8BCfghIzbuNKukTLZPm9NZDDaawkVKV0dFHnOFzNJCwc0cenPzeCuP7iWU4tL514kS0BTCUj9iP0HHwJHP15K8vRJ1Cqtjecfdae0gwV4RKZBSTo8kJ5xOaPRyfFam6yw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2d4382-5466-48a4-f807-08d8504433f0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 20:01:53.3722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K52AgbZlo17s00eajW6zVP5O5/2wUekfKToIJqb6N6yVoMc7MOFBJvggg9XgtdR3tTRswmnQFU1nolEXy6IQXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3171
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Remove the "tmp" variable used to save register values. Save the values
in existing variables, if possible.

The register values are 32 bits. Use separate "reg_" variables to hold
the register values if the existing variable sizes doesn't match, or if
no bitfields in a register share the same name as the register.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20200814191449.183998-3-Yazen.Ghannam@amd.com

v1 -> v2:
* New patch based on comments for v1 Patch 2.

 arch/x86/kernel/cpu/mce/amd.c | 56 +++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 90c3ad61ae19..5a18937ff7cd 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -688,11 +688,14 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 
 int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
-	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
 	/* We start from the normalized address */
 	u64 ret_addr = norm_addr;
 
-	u32 tmp;
+	u64 dram_base_addr, dram_limit_addr;
+	u32 dram_hole_base;
+
+	u32 reg_dram_base_addr, reg_dram_limit_addr;
+	u32 reg_dram_offset;
 
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
 	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
@@ -702,12 +705,12 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	u8 cs_mask, cs_id = 0;
 	bool hash_enabled = false;
 
-	if (amd_df_indirect_read(nid, 0, DF_F0_DRAMOFFSET, umc, &tmp))
+	if (amd_df_indirect_read(nid, 0, DF_F0_DRAMOFFSET, umc, &reg_dram_offset))
 		goto out_err;
 
 	/* Remove HiAddrOffset from normalized address, if enabled: */
-	if (tmp & BIT(0)) {
-		u64 hi_addr_offset = get_bits(tmp, 31, 20) << 28;
+	if (reg_dram_offset & BIT(0)) {
+		u64 hi_addr_offset = get_bits(reg_dram_offset, 31, 20) << 28;
 
 		/* Check if base 1 is used. */
 		if (norm_addr >= hi_addr_offset) {
@@ -716,20 +719,20 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		}
 	}
 
-	if (amd_df_indirect_read(nid, 0, DF_F0_DRAMBASEADDR + (8 * base), umc, &tmp))
+	if (amd_df_indirect_read(nid, 0, DF_F0_DRAMBASEADDR + (8 * base), umc, &reg_dram_base_addr))
 		goto out_err;
 
 	/* Check if address range is valid. */
-	if (!(tmp & BIT(0))) {
+	if (!(reg_dram_base_addr & BIT(0))) {
 		pr_err("%s: Invalid DramBaseAddress range: 0x%x.\n",
-			__func__, tmp);
+			__func__, reg_dram_base_addr);
 		goto out_err;
 	}
 
-	lgcy_mmio_hole_en = get_bit(tmp, 1);
-	intlv_num_chan	  = get_bits(tmp, 7, 4);
-	intlv_addr_sel	  = get_bits(tmp, 10, 8);
-	dram_base_addr	  = get_bits(tmp, 31, 12) << 28;
+	lgcy_mmio_hole_en = get_bit(reg_dram_base_addr, 1);
+	intlv_num_chan	  = get_bits(reg_dram_base_addr, 7, 4);
+	intlv_addr_sel	  = get_bits(reg_dram_base_addr, 10, 8);
+	dram_base_addr	  = get_bits(reg_dram_base_addr, 31, 12) << 28;
 
 	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
 	if (intlv_addr_sel > 3) {
@@ -738,12 +741,12 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		goto out_err;
 	}
 
-	if (amd_df_indirect_read(nid, 0, DF_F0_DRAMLIMITADDR + (8 * base), umc, &tmp))
+	if (amd_df_indirect_read(nid, 0, DF_F0_DRAMLIMITADDR + (8 * base), umc, &reg_dram_limit_addr))
 		goto out_err;
 
-	intlv_num_sockets = get_bit(tmp, 8);
-	intlv_num_dies	  = get_bits(tmp, 11, 10);
-	dram_limit_addr	  = (get_bits(tmp, 31, 12) << 28) | GENMASK_ULL(27, 0);
+	intlv_num_sockets = get_bit(reg_dram_limit_addr, 8);
+	intlv_num_dies	  = get_bits(reg_dram_limit_addr, 11, 10);
+	dram_limit_addr	  = (get_bits(reg_dram_limit_addr, 31, 12) << 28) | GENMASK_ULL(27, 0);
 
 	intlv_addr_bit = intlv_addr_sel + 8;
 
@@ -786,17 +789,18 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 
 	if (num_intlv_bits > 0) {
 		u64 temp_addr_x, temp_addr_i, temp_addr_y;
-		u8 die_id_bit, sock_id_bit, cs_fabric_id;
+		u32 reg_sys_fabric_id, cs_fabric_id;
+		u8 die_id_bit, sock_id_bit;
 
 		/*
 		 * This is the fabric id for this coherent slave. Use
 		 * umc/channel# as instance id of the coherent slave
 		 * for FICAA.
 		 */
-		if (amd_df_indirect_read(nid, 0, DF_F0_FABRICINSTINFO3, umc, &tmp))
+		if (amd_df_indirect_read(nid, 0, DF_F0_FABRICINSTINFO3, umc, &cs_fabric_id))
 			goto out_err;
 
-		cs_fabric_id = get_bits(tmp, 15, 8);
+		cs_fabric_id = get_bits(cs_fabric_id, 15, 8);
 		die_id_bit   = 0;
 
 		/* If interleaved over more than 1 channel: */
@@ -809,22 +813,22 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		sock_id_bit = die_id_bit;
 
 		if (intlv_num_dies || intlv_num_sockets)
-			if (amd_df_indirect_read(nid, 1, DF_F1_SYSFABRICID, umc, &tmp))
+			if (amd_df_indirect_read(nid, 1, DF_F1_SYSFABRICID, umc, &reg_sys_fabric_id))
 				goto out_err;
 
 		/* If interleaved over more than 1 die. */
 		if (intlv_num_dies) {
 			sock_id_bit  = die_id_bit + intlv_num_dies;
-			die_id_shift = get_bits(tmp, 27, 24);
-			die_id_mask  = get_bits(tmp, 15, 8);
+			die_id_shift = get_bits(reg_sys_fabric_id, 27, 24);
+			die_id_mask  = get_bits(reg_sys_fabric_id, 15, 8);
 
 			cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
 		}
 
 		/* If interleaved over more than 1 socket. */
 		if (intlv_num_sockets) {
-			socket_id_shift	= get_bits(tmp, 31, 28);
-			socket_id_mask	= get_bits(tmp, 23, 16);
+			socket_id_shift	= get_bits(reg_sys_fabric_id, 31, 28);
+			socket_id_mask	= get_bits(reg_sys_fabric_id, 23, 16);
 
 			cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
 		}
@@ -848,10 +852,10 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 
 	/* If legacy MMIO hole enabled */
 	if (lgcy_mmio_hole_en) {
-		if (amd_df_indirect_read(nid, 0, DF_F0_MMIOHOLE, umc, &tmp))
+		if (amd_df_indirect_read(nid, 0, DF_F0_MMIOHOLE, umc, &dram_hole_base))
 			goto out_err;
 
-		dram_hole_base = tmp & GENMASK(31, 24);
+		dram_hole_base &= GENMASK(31, 24);
 		if (ret_addr >= dram_hole_base)
 			ret_addr += (BIT_ULL(32) - dram_hole_base);
 	}
-- 
2.25.1

