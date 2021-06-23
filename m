Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C833B20EA
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFWTWx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:22:53 -0400
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com ([40.107.237.62]:18016
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229523AbhFWTWw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:22:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdhGTb1ND+1bqk6Tb3k3eaMzLQVU6PBEEDslOAHQ3itIq7Irf1vK9+SiVI1vJbffMIhO5rrYzWqvid4RnwwI5UcZpdijZ1LyG2CbiaBjvRLPYCoEg8aM5ixTil402VSQHBcKeHmMoUDs82fKiO5FtZGDDpwerYLtO+IjZyjBEdQZjmcfvdRaPMtY7VXEHx4QhsQCjDVqPQZC7/62yrXKw3GRxCpb1OYjkHTlRg8sZ87sByP6sSTiKZeXLgLoUfvoANgF6bFPGcQpNhrdYtLKXJlQZS1B3Ytrpw+AMhs/MC0MrUz5YPozEFWlLgOh7vphtoYuLQrY9tfnDc5BxpmqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDZyZTa0FLanaBiFM8rnJsKfNkAbrT9bRmbv4v3q8jY=;
 b=j7joBIwic+VUrbyTpA45Dpb9SICzO5fP12QR0EkFG1KNU1VJ0m40pxKSnxtJd4eTGU9Tk1p9T8/dlvcE84DOnwYIvREgDHhCuf1qmV8gBmgBrFaNRyXJ6pKdl0UWSvcQ8h4CgfgRgxkobneNcWfcikOXvquRQIun/uLgVhLhpTe6yggvZsHpBlfMAol7qqmsyPVRy08TmlEEq1heVkubvZzFJ/dS0r1QCIWnE4YuOPURy6WZsh6ToFdzxiNJ7e/E0fgDqqL647amaxkBhRMisUs3wjrCo6e7JZ4WtXjehKeu76+w4GpXXm3dv3EU7UvA+LO7FCNd6YqXULdWVbCvVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDZyZTa0FLanaBiFM8rnJsKfNkAbrT9bRmbv4v3q8jY=;
 b=gIYzAMbK7rOHg0ocjBQsdRf2Hs/fEAV4r+RkMjrjV/4ontTqLxD2yupdbDl0rMrRgZwrKMvy76WIEz8T11BayioJ77S1mfhLcnIiovhxNH9asfs48GI7L3CgJBMZzNcUxpgwAdWJPssDGxSaq1XnXvsyneCnc5Q5U4e/isMfZn8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:32 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:32 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org
Subject: [PATCH v2 01/31] x86/MCE/AMD, EDAC/amd64: Move address translation to AMD64 EDAC
Date:   Wed, 23 Jun 2021 19:19:32 +0000
Message-Id: <20210623192002.3671647-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210623192002.3671647-1-yazen.ghannam@amd.com>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BLAPR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:208:32a::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ae6e1ff-c512-4a1b-c9e9-08d9367bf868
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1187028A8471C23DFDDF4C90F8089@BN6PR12MB1187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jTrLC5YJJzx1hImcklrC0zTWEdG7EMwc0RB1N+4gADv3EY+VqqWZjz5Whm8rUrS6skV2lQM2O+9bocc/VmHEYIS1g64+nTFdHxHqTbpK/3lGNMsdLyRZzYBJei+xOGB9+RbZezsMNbTAaUw2s0VvEbSObTevrxrGCr6cI9hUgXSfXYen+PqVYZBmC0ddzc34inXEcKOsUpanI+tjkTm9L8C6PpUX2aEES5gYbMmKZVXri+Su39nW92gY38nzF3VITmyQHSPT5VDuW+Ei5aL3fco/VAJ5r9U0KF1j4dNP4dP8YIYzX9i5DLVH0PYvynqgnqPjXzTQquhRHSWQOHH7HK/MVb0sY+JRyJguO2A9qVCqnMcKDUsd+GKui90WLosKld7b/nLOCSCwYBxutOsINBo5k0R+KiQjljfGiElWQuiltRPFmgdNi2KYUK5KNU08bMjudwP4PENoyc02uVXpENB70eK5CUAkN0o6gNBPeKznloy8GgEQCIUveFjZWhEkjzCBlYSQ7BBN66c3srFc1Zotf2OFnl7k2wxIZNfTIs4UQT/Sn+FcriYYFC5cq8lQW2E9MH49p2gmwHwpirrHbOlJi/4eBnieGsjDPX2KcP5xfvt5isqdF4Xz1pgucuzKnrdVNsi4Y+jWgCNwD66377BNYpaR3KPdo5jJc5YC23Vx47XNWT0mCAwrlBkYKkPF92HVuDTLuEox++NU07E46llxqZsbuh65lgI/AKrA+GXnDEL2xaGt0QSJQUIxAbQNAEm/laqXe3FH1nIMPp637hYHoKJX48Xs3wN4gxPfM948O6dtbCGSSBiW3niDXHmarUOosvhGlrazCVipJOyTCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(966005)(36756003)(38350700002)(30864003)(38100700002)(44832011)(83380400001)(6916009)(26005)(7696005)(5660300002)(186003)(16526019)(66946007)(6486002)(4326008)(52116002)(8676002)(478600001)(1076003)(2906002)(86362001)(66476007)(2616005)(66556008)(8936002)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pfpuL45o/4SEVRto372l4mKULEny7CwmqYpJCEhhPI/LGml3iOw0OTO0xQjd?=
 =?us-ascii?Q?R9DgKpFkln5hEVrinZuyBE9hNmwj2ecBmA9fQqrQYQq44rKu/vUwZVxcKz7k?=
 =?us-ascii?Q?APPxsMzOzNJmn9V9U6WwCJZIDAqzU8Lh0hUA9BzW9urPmy5sERrgqTBy+Y40?=
 =?us-ascii?Q?GboYwS1tcOOdEV5y6aIMgiSYSDeV6BEXan9/sI2pBpgfKOSPpVaj3iG6WbdF?=
 =?us-ascii?Q?1i2SONWpXWVNu6p4PF0A4LaRTxNXj8s0ixU/rYJXr+TsABV5l405Iy82r/Ap?=
 =?us-ascii?Q?XKtDHwxLDt62wWBsdRB9Xs2GMJqXfYrVNXjOcUttExQ1/v5/UWoiJSifSsQn?=
 =?us-ascii?Q?lVviOAAkNx7flcq8Hmzl9xuZb+hf73GqZXI3ITM0AvuUHkNrCFKVqmtTZfoS?=
 =?us-ascii?Q?fylmeO8sfvjj9eEVQ+Xe+74UZaMQBkU5e08tYwgfpc026rrZAMA2Y+KgWu3L?=
 =?us-ascii?Q?SDoBT3S68+YcnZ7JR0iQqtzffs6sm8eOwNKHPda46saHVllVJW/cTpi0cp2V?=
 =?us-ascii?Q?4uV+bJTDga0VypjdgDVmdlxmDJixHIilHSaezutpwFKYkcRxglAtVN+2H550?=
 =?us-ascii?Q?bcElXY/hR5OXve3+8deWasxuLLWW/YNlRLQ2uO6bSrkPDrD41aY+dz0HYOXL?=
 =?us-ascii?Q?5v+zIiM/PrDsZDn7wcSt6kYGdFMGXs5bHe0vVVsF/3XstApT9iqKae4zhBM/?=
 =?us-ascii?Q?eiPxNf5r1YOuLeApwRPn9W8k0vI6tlgBuFrBEhsbgJ/7/qv0xZfkZIJG+4no?=
 =?us-ascii?Q?kaytqgGvK7aM1UHSjajVTc+gv2JSWAD2QLTz+95PDj56XBVrgkUFQKZXoQCh?=
 =?us-ascii?Q?RGGW8Ee1OeXggynqyaRFCKCHun32miAW33tW4j8/FEg/756t43tvcSHA9fZH?=
 =?us-ascii?Q?KlUclgLoV8v763nFjAs6vZoc4NV28YCB3B6vyJp7TuIzEhaDVw9QdIcTjnp9?=
 =?us-ascii?Q?QHHSkRL9pdq7uoC69/o1rRkEiGUYfiatE4rd+kVxLAF5c2vSdp00ZpbGBAxP?=
 =?us-ascii?Q?NXVEo1VedEfypQ3js68MlLkXNURqGlitSGO0fNSpPmPpe2082R7voEimj/Br?=
 =?us-ascii?Q?L80HglHKpa9tbQFL0ZFsF20y3/gjlrkGOdOihHngkqgFmMD+JbmMoq/eBZg1?=
 =?us-ascii?Q?CP1eOJ/8zqjkd7GdxahJXqHCrX7q1Ew68tIywdocEwQRi5zsj4dp2ougGqZy?=
 =?us-ascii?Q?5kPKEDCGjQEj3dRWETJ5HBFiltwckjGe2ZKlNNJ9VJpf+RBR8KUs8o4nlIi7?=
 =?us-ascii?Q?IY/lnaM90ZxF9kvSUdz70lTqP6Fm2AlV63zu5zXiTEAKl0hgnmcIKzjon4IX?=
 =?us-ascii?Q?8tBDbYITpVUOeXRtSJ59QDt7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae6e1ff-c512-4a1b-c9e9-08d9367bf868
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:32.7759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tEHvDuFz2tpqy5Iit0VGNN9AiLw7UccZ5R7LFhp5WQBkdqf0G/zE023BXfattJrCbr9NvyFlLtov6HJKyrryA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The address translation code used for current AMD systems is
non-architectural. So move it to EDAC.

Cc: <x86@kernel.org>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/YKJoICQzD/o7ZPBp@zn.tnic

v1->v2:
* New in v2.

 arch/x86/include/asm/mce.h    |   3 -
 arch/x86/kernel/cpu/mce/amd.c | 200 ----------------------------------
 drivers/edac/amd64_edac.c     | 199 +++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+), 203 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 2ac265e832de..a547ab5b0532 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -357,7 +357,6 @@ extern int mce_threshold_create_device(unsigned int cpu);
 extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
-int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr);
 
 #else
 
@@ -365,8 +364,6 @@ static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
 static inline int mce_threshold_remove_device(unsigned int cpu)		{ return 0; };
 static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
-static inline int
-umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)	{ return -EINVAL; };
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1a2a90bd29e7..ce881f32ca41 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -689,206 +689,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
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
index f0d8f60acee1..046b98fcc4fe 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -993,6 +993,205 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
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

