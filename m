Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA4D376A42
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhEGTC5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:02:57 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:61345
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229645AbhEGTC4 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:02:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ne5jMXGRjQDENk1jzsLMmeK80ASgLy5sQxCCnk8aWnjq0QP8hX0wUQZygfNdfhN8t8xTdvu8K5bYToYH+qBhZmG1uktpENm/QyrOWY4q2OSCXLO+JKBQ8r4b/52CZ4lbt1w3Y+LmsPi3or4XiU1/wbkZ/bXxrOQvhukjdtvq4TMiG+TVkt8IYUNwqEWxA2XcQML+bKo0NkNoaM6atWU76qCYea0sf19uIPH8t+mRl2/MBR1EJ7NHiKe+dWlNzYFPCQoxnOnYXKrkhxzTeJHaifi7QwtC7Lzw8LSpgrY04qD5giEGIwwctexUIwdGdNVlBXlylVKphMiZ+E0w6z2Rhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSGX2Rygmy40gWDJR73lDXcT3+k4+dSYRiP9R15XfrM=;
 b=YYpZO1uwN76JsPfD82iP1VMfDOlHGIf+FFjED7xWSmPBvBSbHKyNaVgHvMo9BSyS8nUNdFJ1CHvSaMMCMiabEXIFBhlkMRdI0YJ2G6NtonmcuqohpOgnnsG75anuYYSBM/bsWWcBx/H792bLSithnj9wR9fe5rXEzog93jMjZapeK/db+P9Rwq9ozSlr2wP0vaYt7EpA7kL7dNA20GRzVKLl/vsu8th7OEQ5w6TQKBEftEnqTmDeloJ1eUQIZWnKQhvZ1MtlBcDJI4cXfL9XM4XuyMj8HzwaJcM8I8UKpRgCH5lnAyOADWEAH7tpFizfymIZSzPnd7wH8lGwRIf+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSGX2Rygmy40gWDJR73lDXcT3+k4+dSYRiP9R15XfrM=;
 b=mZl0+K2mfb2REL0t3AxXx0WQzGdVTig4Q2mWMkgvsLiBElA50ooVpNYFEdjucZcqPfpaJQRqyqJSfw0vAH9In3QIfOXxD6enrvPhqx4VvG9/iAjaAC4lttYnBJC/Gy7DcQ6S3IBczVEo93rqOb4seNPl5aW1w/T31xEACnxe5PE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 19:01:53 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:01:53 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 01/25] x86/MCE/AMD: Don't use naked values for DF registers
Date:   Fri,  7 May 2021 15:01:16 -0400
Message-Id: <20210507190140.18854-2-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
References: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN6PR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:404:8e::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:01:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26732031-a034-4768-f03b-08d9118a93d7
X-MS-TrafficTypeDiagnostic: BN8PR12MB3073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3073B66EA2351BA8342A1B14F8579@BN8PR12MB3073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWCa9BQ6GDk+exYV00vphKqbacchnAH2xzNCtADvwBq97YRUJQwb2c0n3I9ozohwinvidu5fN1xqS3LdjAOiclZZzouLWVpBoP5qlpKx78nKpkP8z1/XXI0ASsOvtTuqGRK0pN8wKLV0CLCy/f2MDqn/xpTXIOvlG5SKF/lhpeTjsDdEGjljlKUP6p77JmqMMe9nNlBO1kewJTtqXp2wPUfBjtpRcN8CgggwTFSm7UcccuwlbbwVJINW/Zp4o/qw36jh+TJVx9ABpT7a2ugrqQSPRT/8icdGZaNA1JbsR5jPC+ZVqDPRwTRiFf7rTlZD3U9AWrB7YAEbT7WcVEPEP1BMewigzpgYJsASVRcDCRkTR7obSgBftNwrZ58cEb1fZoAcR9vbwYo2XMSGNNRx58KfdWKsbp2bUP9gTcTpc+Ak3KVBxcsXdoUhzNBbN9tgC5Endo7P2XFGo1FfW4gkBUPFCdbg3fIiV3fOnLXbP95PZ7f9EYyr5iOFiat3ypkxZqJdeBhDfM8ToOLEdiMVnc2NJyYdhBSvJYEyaUKL9DI/SJevXdz5/2Yw73+h3QPz5wctbVtvse/Y4kp1xaQS9iTRgPG19rF6xpaeRAzTXDutwQ351PHPNiD9x1JVn6CaZesM90p52fP2y9eW4Zm2vKWRxiVfe6uRi4KdCLRwJs3W0WdOw2ULPektkbjFXaPu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(316002)(6486002)(8936002)(8676002)(16526019)(2906002)(6666004)(186003)(83380400001)(26005)(6916009)(36756003)(52116002)(86362001)(66556008)(38100700002)(38350700002)(66476007)(66946007)(4326008)(5660300002)(1076003)(7696005)(2616005)(956004)(478600001)(41403002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FjLxsSq+jAjobZ2R9aYRi8w0WkAb9ntUNqpXxaOfpTQO2yfIO5I/ThoJGhm8?=
 =?us-ascii?Q?cucK3uFugcFcl2Q0tRIdsrj8JcbuzYXvSd2JJ5ZSS+os9YIKMq0/vNlmrFO5?=
 =?us-ascii?Q?MSsHH43VbQ1KpHmN54pMlAGc5OueZ4SsnknLI//WF+yi/f/LASbSA4Odr2er?=
 =?us-ascii?Q?ZdvjS+D0/FVT/cUCcOTed7epnmB04pH2KO2PdSOY5jzQiYX31/jQABbgWvLQ?=
 =?us-ascii?Q?qdJrJZ3WUVFoAulyiaSPINGy5kMD5+oQceYYSACAS0YuWs37ZRl4uVDNWQLD?=
 =?us-ascii?Q?QdED2hOLSdESAwE1l+tfC2B+WR6UnjYmjzeDeyM45GCt5PaBW/L4BxVqcmv3?=
 =?us-ascii?Q?IxGlpdI2CqBOeldaprk/Ce9eJjM8y93HhylNf2ey6wsBWTH63pve2uZFtmpU?=
 =?us-ascii?Q?04ps7qNdcestcAZvJaiSSLyVzhcckU+qFSyU7WG2d6OmFkw9QpdUfE+pBbpD?=
 =?us-ascii?Q?0kYAQP1trbIze0srGI4LNSdq7c+dIDgHe6LU89RrytC4TTJFa7Rn33n92dax?=
 =?us-ascii?Q?mkSXNW31l3rQyvd8vAPRK6uvhb568sCUYdd+LQjjAZ1nkFrHO8Ko/uWI1UsW?=
 =?us-ascii?Q?whi4I7cZny50LrszTu/l6cCxyx6rF2+yi5wNe7TqpYioZaRp83zcffBxFpMC?=
 =?us-ascii?Q?YV2jJd4oEWXHVWNKl8n2KRqtvfUGhFKSvhuC13WwLc2xMCKH3COkhNHlp5/7?=
 =?us-ascii?Q?XwFP6ZuPreJybOyloC606hfkhUvAt32dAgCTLZz8IFKvZPhCxULuTMLwMHBf?=
 =?us-ascii?Q?RVFNyjgWDdfYwTxSgaXXrJUrbDQVo2Tvf8A+Tg4oik6zie817UiVNWkhDxrc?=
 =?us-ascii?Q?Axcwlh5bj8sQQaLxLQ04RMsadDV4XeVw761Y155IXNG0nVQqE5X6MiK95e/r?=
 =?us-ascii?Q?GnlH1Dt2H2zHGBEv96aAGvpfWcwEFX8himkM69Hpp90QIs+BVzVczAq990jh?=
 =?us-ascii?Q?NwIEa6ApO1jvQw6tiJlarrm5NBtwcNlPApEhHrPApBC7U0NyYQ6xSMdPHe0C?=
 =?us-ascii?Q?q3gjJwcYKQJbkW2eIDz2o4rAG6rFJl3YmA4Q8O4dDIIFF4n2miFb2jk1BXD8?=
 =?us-ascii?Q?PgaATEsuYZlzenWRePKPkda16iF4XJzbCclr+4reRMcjSJ66znm67jMG31ur?=
 =?us-ascii?Q?Oc9GrzHtfDHS0Ft1mYH1gIVGhwMQv6nyzuNcULj9sxv2kk4ciNwnY2o+unv0?=
 =?us-ascii?Q?kMAoSHDIVroO1JJ2CJ2OB9Z02RHcrT/EXLJ7/z1OLusGOPf0g7mk5QFiaMv5?=
 =?us-ascii?Q?igTospzeTuo8Jd/UZue0hVdzVcerv3noivKufgCETh+c/KnrkgPPSAw3+5uw?=
 =?us-ascii?Q?KA5DyY/dp5oRPKYmdX/TyYde?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26732031-a034-4768-f03b-08d9118a93d7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:01:53.6395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j70QGUmgy7UIgQlKK4ShPfLLau4xXufbngPxldop9tieDA+oQnF83l7UoF+9/MYqfOBjhlDZWDxVIyhxhZ8mfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

AMD Data Fabric registers are defined using a combination of PCI
function number and offset. Define a struct to hold these values, and
update the DF Indirect Access function to accept a struct of this type.

Update the address translation code to include a list of the needed DF
registers using this new format. Define an enumeration to give the
registers more human-readable names.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/amd_nb.h |  7 ++++-
 arch/x86/kernel/amd_nb.c      |  6 ++---
 arch/x86/kernel/cpu/mce/amd.c | 51 ++++++++++++++++++++++++++++-------
 3 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 455066a06f60..a5644c119317 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -22,9 +22,14 @@ extern int amd_numa_init(void);
 extern int amd_get_subcaches(int);
 extern int amd_set_subcaches(int, unsigned long);
 
+struct df_reg {
+	u8  func;
+	u16 offset;
+};
+
 extern int amd_smn_read(u16 node, u32 address, u32 *value);
 extern int amd_smn_write(u16 node, u32 address, u32 value);
-extern int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo);
+extern int amd_df_indirect_read(u16 node, struct df_reg reg, u8 instance_id, u32 *lo);
 
 struct amd_l3_cache {
 	unsigned indices;
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 09083094eb57..f06924093ae4 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -184,7 +184,7 @@ EXPORT_SYMBOL_GPL(amd_smn_write);
  * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
  * and FICAD HI registers but so far we only need the LO register.
  */
-int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
+int amd_df_indirect_read(u16 node, struct df_reg reg, u8 instance_id, u32 *lo)
 {
 	struct pci_dev *F4;
 	u32 ficaa;
@@ -198,8 +198,8 @@ int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
 		goto out;
 
 	ficaa  = 1;
-	ficaa |= reg & 0x3FC;
-	ficaa |= (func & 0x7) << 11;
+	ficaa |= reg.offset & 0x3FC;
+	ficaa |= (reg.func & 0x7) << 11;
 	ficaa |= instance_id << 16;
 
 	mutex_lock(&smn_mutex);
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index e486f96b3cb3..1b459c143886 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -675,6 +675,37 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 		deferred_error_interrupt_enable(c);
 }
 
+enum df_reg_names {
+	/* Function 0 */
+	FAB_BLK_INST_INFO_3,
+	DRAM_HOLE_CTL,
+	DRAM_BASE_ADDR_0,
+	DRAM_LIMIT_ADDR_0,
+	DRAM_BASE_ADDR_1,
+	DRAM_LIMIT_ADDR_1,
+	DRAM_OFFSET,
+
+	/* Function 1 */
+	SYS_FAB_ID_MASK,
+};
+
+static struct df_reg df_regs[] = {
+	/* D18F0x50 (FabricBlockInstanceInformation3_CS) */
+	[FAB_BLK_INST_INFO_3]	=	{0, 0x50},
+	/* D18F0x104 (DramHoleControl) */
+	[DRAM_HOLE_CTL]		=	{0, 0x104},
+	/* D18F0x110 (DramBaseAddress) */
+	[DRAM_BASE_ADDR_0]	=	{0, 0x110},
+	/* D18F0x114 (DramLimitAddress) */
+	[DRAM_LIMIT_ADDR_0]	=	{0, 0x114},
+	[DRAM_BASE_ADDR_1]	=	{0, 0x118},
+	[DRAM_LIMIT_ADDR_1]	=	{0, 0x11C},
+	/* D18F0x1B4 (DramOffset) */
+	[DRAM_OFFSET]		=	{0, 0x1B4},
+	/* D18F1x208 (SystemFabricIdMask) */
+	[SYS_FAB_ID_MASK]	=	{1, 0x208},
+};
+
 int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
@@ -691,8 +722,9 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	u8 cs_mask, cs_id = 0;
 	bool hash_enabled = false;
 
-	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
-	if (amd_df_indirect_read(nid, 0, 0x1B4, umc, &tmp))
+	struct df_reg reg;
+
+	if (amd_df_indirect_read(nid, df_regs[DRAM_OFFSET], umc, &tmp))
 		goto out_err;
 
 	/* Remove HiAddrOffset from normalized address, if enabled: */
@@ -705,8 +737,8 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		}
 	}
 
-	/* Read D18F0x110 (DramBaseAddress). */
-	if (amd_df_indirect_read(nid, 0, 0x110 + (8 * base), umc, &tmp))
+	reg = base ? df_regs[DRAM_BASE_ADDR_1] : df_regs[DRAM_BASE_ADDR_0];
+	if (amd_df_indirect_read(nid, reg, umc, &tmp))
 		goto out_err;
 
 	/* Check if address range is valid. */
@@ -728,8 +760,8 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		goto out_err;
 	}
 
-	/* Read D18F0x114 (DramLimitAddress). */
-	if (amd_df_indirect_read(nid, 0, 0x114 + (8 * base), umc, &tmp))
+	reg = base ? df_regs[DRAM_LIMIT_ADDR_1] : df_regs[DRAM_LIMIT_ADDR_0];
+	if (amd_df_indirect_read(nid, reg, umc, &tmp))
 		goto out_err;
 
 	intlv_num_sockets = (tmp >> 8) & 0x1;
@@ -785,7 +817,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		 * umc/channel# as instance id of the coherent slave
 		 * for FICAA.
 		 */
-		if (amd_df_indirect_read(nid, 0, 0x50, umc, &tmp))
+		if (amd_df_indirect_read(nid, df_regs[FAB_BLK_INST_INFO_3], umc, &tmp))
 			goto out_err;
 
 		cs_fabric_id = (tmp >> 8) & 0xFF;
@@ -800,9 +832,8 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 
 		sock_id_bit = die_id_bit;
 
-		/* Read D18F1x208 (SystemFabricIdMask). */
 		if (intlv_num_dies || intlv_num_sockets)
-			if (amd_df_indirect_read(nid, 1, 0x208, umc, &tmp))
+			if (amd_df_indirect_read(nid, df_regs[SYS_FAB_ID_MASK], umc, &tmp))
 				goto out_err;
 
 		/* If interleaved over more than 1 die. */
@@ -841,7 +872,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 
 	/* If legacy MMIO hole enabled */
 	if (lgcy_mmio_hole_en) {
-		if (amd_df_indirect_read(nid, 0, 0x104, umc, &tmp))
+		if (amd_df_indirect_read(nid, df_regs[DRAM_HOLE_CTL], umc, &tmp))
 			goto out_err;
 
 		dram_hole_base = tmp & GENMASK(31, 24);
-- 
2.25.1

