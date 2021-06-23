Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400633B20ED
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhFWTXA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:00 -0400
Received: from mail-bn8nam12on2069.outbound.protection.outlook.com ([40.107.237.69]:51744
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229523AbhFWTXA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFyXwfypaalLArSSKrvCFURYLZlWJZRNQ/dMes2TjKLp+Fe1YCQKEz6JeRM4ufL8E7Ai+XXcuYd2zWrpPlfv57WyWG/+xs8pB+JqkH2pkdKnyOFqUdvC9tx+DwwT9ZOPLvIyruraQoUOpKxG4aqozF3ei3D9PAmffcStbZSAn1JsuIZoGow3i+GQHh2++PZcYgTDN0wWVgDU7TiiJjJBxMWWEHM2BG1Bw8K7MxbDzmVGa1gyKGdhgZLrr+B9R/+WA5EWilWCafvhpbs4FPJUph746NKlO6I4PfswfJBCkiA6quiTMg2xCRxw5G5uLnLtkXQYGAhroaryOhGy4au90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hviOaPm2UJKJLDJjTvQmRyHMNLGdiLIiDkeM7hNg4EU=;
 b=EqKm2OAIthY5Pa7/2hK7GBuVAIvWauKmQUefkuSPtGOFlCoqlKvrqqZSa9n/UA9scEqakeo0Z/76RpAUHxXGLm4UkOeHmWoTlk68aKE8Zdad3Ol8ZPe7gcYTzggwtyqHzpHw8u/FlUusMv9bj+wO9SZ7wp8GOzEApBwXzdeFGtpuTYw8TD/LrSS4B51BxRr9Sz+JjXVxZUvymkMZFNYwkL6Yqg7gOFfi+4e8/Cm2LlpZT6b4Cii6K4m16o75fIOQYUBZhuvnivfQ/w09Dj1IC70eEgNLSLuslJ4RkAqyDy7NKRpO2RCkeslDqOcH5OivB2Nc6YXyeJwfFOsTKeINuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hviOaPm2UJKJLDJjTvQmRyHMNLGdiLIiDkeM7hNg4EU=;
 b=X02tvSJ9mKS/CAo9TVBUeB2Be41bD5BQpXzRV8akIJ6eB91slGIo295t0GwICoUQUCWKkvZj1yaaVjPMU3ccYS5WbW4GKUEwZ5n5wK7wPT79be4RkybZWdPMsYvRlahvNS3uk6J98/HjkMr1fpfmfkg8OM37W6bSfWrIE1M0zpM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:40 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:40 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 03/31] EDAC/amd64: Don't use naked values for DF registers
Date:   Wed, 23 Jun 2021 19:19:34 +0000
Message-Id: <20210623192002.3671647-4-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0e7ce57-58c4-404e-ff1d-08d9367bfcd7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1187CC63B4A4927938A3D010F8089@BN6PR12MB1187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +G0rsCESyDkr0zXmmhXtlSJdfFowaUOPCHxQMC6p8tlsIJ8CY/ozvqjhDiHnWLb67Cw8Vpy9aFaBEhOAZTjxL8aUBnauXBkzxheGAnnNHToOgvi9mhinFXMNHSg9cv16QXSBSb4rTNC+f3A9i8HhAIZYFbmKitvoWUwAeubWursOJ0HZJWSHQaqEripZrRCRa6MAMsA0DdSfzoz+D4mtsQvkJuf4/MOs+CO59A9miV5iUAHwcWBiMvGNeLAjcIBFLpTH0Qcmn3qisMalNP7BclYYpdGkeYJcGRJZOer4EVuYdwcyzwF4RHY+I+atfFAQV0tRZWw6SBKAEUGhm7VxNgtrrvisSrYfI/7bWRacWJBt4VlPt7aJUbjzpG7I6zMnJzmn7pc5COmCCBPQ3ep9IQgFDgrememkmgEwmNO6z6U6jSIJWFxaryX0Acg5H/5jU3D/aRymLh79MFPXdbMLDRSBTQx9PYTJz+DzNx/2PvUFKUqkDgmxxgOxIGwt+EN72BEyWUR2p7Q/3he/+MWNvDgIzBCcv7b2syXaeIFsIkR889vYUWsp+sJXZtELGySznIRQkXY51as4f5RgkEkXqKJUc6tzB1EJd7BAoBt/kLX/Nu8UBDB2b/P8xl7GEBdqkUD4vUqmqoZ++LCagsfAGsonRhaktFLuDAeZ1e3RmkRMpslS4LzajX5O8fguyUFZmT7N9TVO7F+hQSHXc+Av1LcJnKoVugfyWkLe+uGb0S7dmGG8mJe84zMx1dxm8nh+TtdFsne+RJ+p78PFt2A31LeBr6nVvAcJKoFEaupEAOSQqQuF9eXYHZqxYQN7OLBW9MIIqaRRfAiu/fcLFSjRuuTeLqvnIo7Pu//fl1xmq20=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(966005)(36756003)(38350700002)(38100700002)(44832011)(83380400001)(6916009)(26005)(7696005)(5660300002)(186003)(16526019)(66946007)(6486002)(4326008)(52116002)(8676002)(478600001)(6666004)(1076003)(2906002)(86362001)(66476007)(2616005)(66556008)(8936002)(316002)(956004)(41403002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K0aiUdBaZgjvE1yxJQxyWpGX50Qs3KIj63NXvmeleIgPdKze6/ZTrEmfFZLs?=
 =?us-ascii?Q?+RTs2mSeaBtqjgtjMAEWe02FQaqdvXkKPnrKxOSorlqUE+Aaom9fsPkLztVe?=
 =?us-ascii?Q?aueJracZ4+3an1x9hY1cStfrcHeKjShrrrIFvOnH7hMli8LuhBdKdJjEiBfQ?=
 =?us-ascii?Q?9Kr4++uwR2dZ9ZiJvKW28oAmk67eXQTiFsW9gMcKTso7+IyHPUIs6Gc4CNd8?=
 =?us-ascii?Q?cWykU0s4fXF46VV1neXU5Lnpm55i2hO6lM8bki2qOC2K0W1k7HCcJ8YlbXeJ?=
 =?us-ascii?Q?ofO01cTCm8cAeOEPVo+An/D4lTujzeczkMrug17X6KywfSJAoC7eS56Epe9G?=
 =?us-ascii?Q?GuUBVDWJMK8fFhZMAoLRf+XqueTmXYPTARIzH5i+Klop4XgXk2bfFXjdY5ZD?=
 =?us-ascii?Q?wpyVNxDTWgqoNx5IMu/LGUw9PVzD9d84INIgMSnsH/SI9O3jGDZ27NHxQtDk?=
 =?us-ascii?Q?4GKf2yL4/0of4227a6fVZr1xayFZkWMOT3LyTN9Lib4mSPl6Buvw0Beh/8EU?=
 =?us-ascii?Q?1oD7/r6dm3J8bYQ0A89QSJwxM1Y6bXjoTXuHHft7xaBzEwIYwz4PUoTeH5Ey?=
 =?us-ascii?Q?MdyNMj+Ov6WglBd8Ak+Ws6823kC4DE/++mbmByWh8eImb4m38pKZPcDG4LDq?=
 =?us-ascii?Q?RA2Y5NTUIsXvPfVqMeTTu8BizofYvklh3f9bDSS3Z19ktN3iml7teXrCR48V?=
 =?us-ascii?Q?/Nwm3L0TQKDSbMdqpSGDPO3h64+pr1pEdRX+l4oUyrFPg6dVzcloappH7QsD?=
 =?us-ascii?Q?a1iFdg/qFooznqE+/XpW0e67JuChHnc1txeKF9zigNu+pcKsmuO+OyBHo600?=
 =?us-ascii?Q?j+elZU5vVy/nwvohDXV4NmkDYTaYwTRyP4YVAwxF4kjboOyfEVmHnvR7FDJN?=
 =?us-ascii?Q?Fu1uv1xaf9+RaWkXyreQpIRV8S9FJgbiBr23Sh2fg/OVUBPRNmWEHufKpuIp?=
 =?us-ascii?Q?hntlq7JDe6t/xdDybvkiNI30wrefAMkpvbAf2P/a/UPOk5eR1hyA4xmd9Z1n?=
 =?us-ascii?Q?KABG4AYEDfYx7uTFIdyzWtCjDN2yQ136CGIavj4fkabWBm1FGeDiJeLO4yLL?=
 =?us-ascii?Q?KgSPuf5VaF7PYiuJxPHOJG66yU1iG+DGDAGHctEbvqLPa3og99jLS06178fo?=
 =?us-ascii?Q?Tyeeflt35Wlt4pbxb8xfoKXb+0psXq/pb+0R3RGTO5s662gP+jbBpb6SYKl5?=
 =?us-ascii?Q?6R2MKqHuEUH56tXuEvG3BLFm99C3wuW7nS3+bzrENG6jddFWml5Ry681ub0h?=
 =?us-ascii?Q?5oUZ9pILEc2L/jZyxIjjcPFtpt6TJrDwdCJ6qJ6wNRjMsVr5at1h5mMoDDRl?=
 =?us-ascii?Q?UTpDZh82BBowvZHGe7SbcECZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e7ce57-58c4-404e-ff1d-08d9367bfcd7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:40.1966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvfExIq6L1CvoDDA7ZJAAVCoONXwByLDFTL6e2tmb9tMLpYyqDvcgqJG2/m9p5nsKUMVgQsahitbbEhGu7qI0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

AMD Data Fabric registers are defined using a combination of PCI
function number and offset. Define a struct to hold these values, and
update the DF Indirect Access function to accept a struct of this type.

Update the address translation code to include a list of the needed DF
registers using this new format. Define an enumeration to give the
registers more human-readable names.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-2-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 60 ++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index e9342d7d693f..b94067e3952b 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -996,6 +996,11 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 /* Protect the PCI config register pairs used for DF indirect access. */
 static DEFINE_MUTEX(df_indirect_mutex);
 
+struct df_reg {
+	u8 func;
+	u16 offset;
+};
+
 /*
  * Data Fabric Indirect Access uses FICAA/FICAD.
  *
@@ -1006,7 +1011,7 @@ static DEFINE_MUTEX(df_indirect_mutex);
  * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
  * and FICAD HI registers but so far we only need the LO register.
  */
-static int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
+static int amd_df_indirect_read(u16 node, struct df_reg reg, u8 instance_id, u32 *lo)
 {
 	struct pci_dev *F4;
 	u32 ficaa;
@@ -1020,8 +1025,8 @@ static int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32
 		goto out;
 
 	ficaa  = 1;
-	ficaa |= reg & 0x3FC;
-	ficaa |= (func & 0x7) << 11;
+	ficaa |= reg.offset & 0x3FC;
+	ficaa |= (reg.func & 0x7) << 11;
 	ficaa |= instance_id << 16;
 
 	mutex_lock(&df_indirect_mutex);
@@ -1043,6 +1048,33 @@ static int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32
 	return err;
 }
 
+enum df_reg_names {
+	/* Function 0 */
+	FAB_BLK_INST_INFO_3,
+	DRAM_HOLE_CTL,
+	DRAM_BASE_ADDR,
+	DRAM_LIMIT_ADDR,
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
+	[DRAM_BASE_ADDR]	=	{0, 0x110},
+	/* D18F0x114 (DramLimitAddress) */
+	[DRAM_LIMIT_ADDR]	=	{0, 0x114},
+	/* D18F0x1B4 (DramOffset) */
+	[DRAM_OFFSET]		=	{0, 0x1B4},
+	/* D18F1x208 (SystemFabricIdMask) */
+	[SYS_FAB_ID_MASK]	=	{1, 0x208},
+};
+
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
@@ -1059,8 +1091,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	u8 cs_mask, cs_id = 0;
 	bool hash_enabled = false;
 
-	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
-	if (amd_df_indirect_read(nid, 0, 0x1B4, umc, &tmp))
+	struct df_reg reg;
+
+	if (amd_df_indirect_read(nid, df_regs[DRAM_OFFSET], umc, &tmp))
 		goto out_err;
 
 	/* Remove HiAddrOffset from normalized address, if enabled: */
@@ -1073,8 +1106,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		}
 	}
 
-	/* Read D18F0x110 (DramBaseAddress). */
-	if (amd_df_indirect_read(nid, 0, 0x110 + (8 * base), umc, &tmp))
+	reg = df_regs[DRAM_BASE_ADDR];
+	reg.offset += base * 8;
+	if (amd_df_indirect_read(nid, reg, umc, &tmp))
 		goto out_err;
 
 	/* Check if address range is valid. */
@@ -1096,8 +1130,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		goto out_err;
 	}
 
-	/* Read D18F0x114 (DramLimitAddress). */
-	if (amd_df_indirect_read(nid, 0, 0x114 + (8 * base), umc, &tmp))
+	reg = df_regs[DRAM_LIMIT_ADDR];
+	reg.offset += base * 8;
+	if (amd_df_indirect_read(nid, reg, umc, &tmp))
 		goto out_err;
 
 	intlv_num_sockets = (tmp >> 8) & 0x1;
@@ -1153,7 +1188,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		 * umc/channel# as instance id of the coherent slave
 		 * for FICAA.
 		 */
-		if (amd_df_indirect_read(nid, 0, 0x50, umc, &tmp))
+		if (amd_df_indirect_read(nid, df_regs[FAB_BLK_INST_INFO_3], umc, &tmp))
 			goto out_err;
 
 		cs_fabric_id = (tmp >> 8) & 0xFF;
@@ -1168,9 +1203,8 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 
 		sock_id_bit = die_id_bit;
 
-		/* Read D18F1x208 (SystemFabricIdMask). */
 		if (intlv_num_dies || intlv_num_sockets)
-			if (amd_df_indirect_read(nid, 1, 0x208, umc, &tmp))
+			if (amd_df_indirect_read(nid, df_regs[SYS_FAB_ID_MASK], umc, &tmp))
 				goto out_err;
 
 		/* If interleaved over more than 1 die. */
@@ -1209,7 +1243,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 
 	/* If legacy MMIO hole enabled */
 	if (lgcy_mmio_hole_en) {
-		if (amd_df_indirect_read(nid, 0, 0x104, umc, &tmp))
+		if (amd_df_indirect_read(nid, df_regs[DRAM_HOLE_CTL], umc, &tmp))
 			goto out_err;
 
 		dram_hole_base = tmp & GENMASK(31, 24);
-- 
2.25.1

