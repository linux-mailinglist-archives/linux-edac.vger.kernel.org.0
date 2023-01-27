Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F9B67EC14
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjA0RGh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjA0RGI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:06:08 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D262E87582;
        Fri, 27 Jan 2023 09:05:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A19N7I/XcdqSfslUlZsMtkyAqzSDm3KNoA8BOq+g67p6OfXgHkyCgBLIp3g1ENSig+NF6nIeSilFZxM9TvP+6Wg08LMn23L6ej2IvX6he1t8dpLFmvtRWCXTwZnG2aqiYWA7J0gxtCPJaagEwiPZsgxu//HJUJ3t4lMrBIl4T+NubkUXmbVN23HTHBQGWg9G6M8H1WMxPky2eI9gWnYlCOssvdDntIuJu20iEaDmnj9OO9KkG93jPweC8KyYWOdwQgN9CvnooSxHgGZDHZ5USI/IlCUgbBUPLsgX64kQsKALU2wqMk2YOOWModpZLkMoQqwx1msgPQiZt0kRT9GAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyQcYouHdbkYxVmnWVf4bfpZyxggGJAnG8xab3mJHmU=;
 b=ZYrDvi0QzKmxUU3bVx731bL4zUiZ1jNQ5XIxksWltO7ItpRDa7HStcE5KdVNVodFbDOwsKfCAtG4CMevwV9TpnGez+Ik6F/RDYb4wmngxWa7o3f1YNPLVY73aTv/69aWlRghVGYpLTGDxpEKLwR68dWyfvmcBTXWqs9M8zwH0yyOQJgZhiEYRynLfSlUg5XpVFS4G+DGZMuRGt+S6aa+EBXzJVgr0ZiqU3SMV4Cwi6EovzXybbEP+Zc62h7WhGoyCQ9j828AEKScuCIw0+8r0kgC+aakm1vUIb/uJsNEcWx7r9R+XC7wXnLfNAFePw7SruyjeLtjbD/IGPagFds4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyQcYouHdbkYxVmnWVf4bfpZyxggGJAnG8xab3mJHmU=;
 b=N2e9fOK8C3srb/L/RPYOHId8Jw44kSgsNIIj9sg8Oj6h0V0r6wrM9mZxQAh9f5gJrn3GH+xzQNKbJTFIxUBwK97JOf8xoeBAl/CjLRNn7mdl3CuNMSzCUknbYoOhLVAESoJrSIwyH000ptzfzvAhvIf70rcp8RFk/qF98cmhSt8=
Received: from BN8PR04CA0052.namprd04.prod.outlook.com (2603:10b6:408:d4::26)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Fri, 27 Jan
 2023 17:04:35 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::88) by BN8PR04CA0052.outlook.office365.com
 (2603:10b6:408:d4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 27 Jan 2023 17:04:34 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:33 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 08/22] EDAC/amd64: Drop dbam_to_cs() for Family 17h and later
Date:   Fri, 27 Jan 2023 17:04:05 +0000
Message-ID: <20230127170419.1824692-9-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127170419.1824692-1-yazen.ghannam@amd.com>
References: <20230127170419.1824692-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 256547a2-4cb3-4fbf-9950-08db008890ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6I2sXXdmMSbJOdnezU0BMG0ON7EwK3a6Xmpy7vm9kt62MGcnON3utmrd16kyaM7Qv/Bk60O4WUhz5b2h6rJ+VEnC60720I3+mKldO6ORMKAyrxkAtDZVef976L5ZrVhx/SheXEzEb82CznTTaGFZpP+elQxaBySBMmITc8oisJ0TsDoIvBrKnvFMe8P1034MtdJA3Dqg3Ubk7N9CW34IZEP9fFuMGqkVGeBIYwpry2/mBpNVqQUEDoXPGjBrUcdRk4fdU1XQZudQtoyOMLN+Bmqs5pPBh6wAKFMYZofEdy8BFnx90gPPvjF26ffgQhih+W8++r/F8/VEzmd0Z2n3Lwv0XTrgKsiXMyjqBCKtFGM5Ok8tVx1BBiBlzlajlxT2FHhRcy1nXRLfw4G3xN7WRbgkononKG0dFUktEXeD1+pyvjQgF8UaL0Gq7ltIF4bIiRAYxWiYRMW7x/u6kM1rDYxWRA3YXrFn06g3TmN72gZdq3JfIgQ+mujC8H+oAkd63hF0glVCPkzFgY5isyjTwZ2U8oUHRVVVmKB/xcUR+g/DpSJpUVEytexEXaMVR6nii2Q9QW8keS7hYJ8+E3dijyu7qZIKqeN1L5F3gZOD3TAvP5bYNrK7v6W4d9rfY4NzF5K+BgArpcauD8adFYvYFt1MHeXCi+dAycbGpgXmSU+klEQr/y+m21y1C9D61LrxTwvziVFHzLk955T62imMdyrb0zjIX+iRc1ImJyCvdY8MNzmrKPZVmwQ2D3IgN5MQOtMh6ViU95lq3yRpvvMudg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199018)(46966006)(36840700001)(40470700004)(426003)(47076005)(336012)(2906002)(44832011)(36756003)(966005)(7696005)(316002)(478600001)(110136005)(54906003)(40460700003)(26005)(81166007)(70206006)(1076003)(356005)(8676002)(6666004)(70586007)(2616005)(83380400001)(4326008)(8936002)(40480700001)(5660300002)(41300700001)(86362001)(36860700001)(16526019)(186003)(82740400003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:34.7337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 256547a2-4cb3-4fbf-9950-08db008890ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The same function is used to calculate chip select size for all Zen-based
family/models. Therefore, a family/model function pointer is not necessary.

Drop the dbam_to_cs() function pointer for Family 17h and later systems.
Also, move the Family 17h function to avoid a forward declaration. Rename
it to indicate that the UMC Address Mask is used rather than the legacy
DBAM value.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-1-yazen.ghannam@amd.com

v1->v2:
* New in v2.

 drivers/edac/amd64_edac.c | 186 +++++++++++++++++---------------------
 1 file changed, 81 insertions(+), 105 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 5559d05fb15d..e13fe400bad5 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1424,6 +1424,84 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 	return cs_mode;
 }
 
+static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
+				    unsigned int cs_mode, int csrow_nr)
+{
+	u32 addr_mask_orig, addr_mask_deinterleaved;
+	u32 msb, weight, num_zero_bits;
+	int cs_mask_nr = csrow_nr;
+	int dimm, size = 0;
+
+	/* No Chip Selects are enabled. */
+	if (!cs_mode)
+		return size;
+
+	/* Requested size of an even CS but none are enabled. */
+	if (!(cs_mode & CS_EVEN) && !(csrow_nr & 1))
+		return size;
+
+	/* Requested size of an odd CS but none are enabled. */
+	if (!(cs_mode & CS_ODD) && (csrow_nr & 1))
+		return size;
+
+	/*
+	 * Family 17h introduced systems with one mask per DIMM,
+	 * and two Chip Selects per DIMM.
+	 *
+	 *	CS0 and CS1 -> MASK0 / DIMM0
+	 *	CS2 and CS3 -> MASK1 / DIMM1
+	 *
+	 * Family 19h Model 10h introduced systems with one mask per Chip Select,
+	 * and two Chip Selects per DIMM.
+	 *
+	 *	CS0 -> MASK0 -> DIMM0
+	 *	CS1 -> MASK1 -> DIMM0
+	 *	CS2 -> MASK2 -> DIMM1
+	 *	CS3 -> MASK3 -> DIMM1
+	 *
+	 * Keep the mask number equal to the Chip Select number for newer systems,
+	 * and shift the mask number for older systems.
+	 */
+	dimm = csrow_nr >> 1;
+
+	if (!fam_type->flags.zn_regs_v2)
+		cs_mask_nr >>= 1;
+
+	/* Asymmetric dual-rank DIMM support. */
+	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
+		addr_mask_orig = pvt->csels[umc].csmasks_sec[cs_mask_nr];
+	else
+		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
+
+	/*
+	 * The number of zero bits in the mask is equal to the number of bits
+	 * in a full mask minus the number of bits in the current mask.
+	 *
+	 * The MSB is the number of bits in the full mask because BIT[0] is
+	 * always 0.
+	 *
+	 * In the special 3 Rank interleaving case, a single bit is flipped
+	 * without swapping with the most significant bit. This can be handled
+	 * by keeping the MSB where it is and ignoring the single zero bit.
+	 */
+	msb = fls(addr_mask_orig) - 1;
+	weight = hweight_long(addr_mask_orig);
+	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
+
+	/* Take the number of zero bits off from the top of the mask. */
+	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
+
+	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
+	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
+	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
+
+	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
+	size = (addr_mask_deinterleaved >> 2) + 1;
+
+	/* Return size in MBs. */
+	return size >> 10;
+}
+
 static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
 {
 	int dimm, size0, size1, cs0, cs1, cs_mode;
@@ -1436,8 +1514,8 @@ static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
 
 		cs_mode = umc_get_cs_mode(dimm, ctrl, pvt);
 
-		size0 = pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs0);
-		size1 = pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs1);
+		size0 = umc_addr_mask_to_cs_size(pvt, ctrl, cs_mode, cs0);
+		size1 = umc_addr_mask_to_cs_size(pvt, ctrl, cs_mode, cs1);
 
 		amd64_info(EDAC_MC ": %d: %5dMB %d: %5dMB\n",
 				cs0,	size0,
@@ -2139,84 +2217,6 @@ static int f16_dbam_to_chip_select(struct amd64_pvt *pvt, u8 dct,
 		return ddr3_cs_size(cs_mode, false);
 }
 
-static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
-				    unsigned int cs_mode, int csrow_nr)
-{
-	u32 addr_mask_orig, addr_mask_deinterleaved;
-	u32 msb, weight, num_zero_bits;
-	int cs_mask_nr = csrow_nr;
-	int dimm, size = 0;
-
-	/* No Chip Selects are enabled. */
-	if (!cs_mode)
-		return size;
-
-	/* Requested size of an even CS but none are enabled. */
-	if (!(cs_mode & CS_EVEN) && !(csrow_nr & 1))
-		return size;
-
-	/* Requested size of an odd CS but none are enabled. */
-	if (!(cs_mode & CS_ODD) && (csrow_nr & 1))
-		return size;
-
-	/*
-	 * Family 17h introduced systems with one mask per DIMM,
-	 * and two Chip Selects per DIMM.
-	 *
-	 *	CS0 and CS1 -> MASK0 / DIMM0
-	 *	CS2 and CS3 -> MASK1 / DIMM1
-	 *
-	 * Family 19h Model 10h introduced systems with one mask per Chip Select,
-	 * and two Chip Selects per DIMM.
-	 *
-	 *	CS0 -> MASK0 -> DIMM0
-	 *	CS1 -> MASK1 -> DIMM0
-	 *	CS2 -> MASK2 -> DIMM1
-	 *	CS3 -> MASK3 -> DIMM1
-	 *
-	 * Keep the mask number equal to the Chip Select number for newer systems,
-	 * and shift the mask number for older systems.
-	 */
-	dimm = csrow_nr >> 1;
-
-	if (!fam_type->flags.zn_regs_v2)
-		cs_mask_nr >>= 1;
-
-	/* Asymmetric dual-rank DIMM support. */
-	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
-		addr_mask_orig = pvt->csels[umc].csmasks_sec[cs_mask_nr];
-	else
-		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
-
-	/*
-	 * The number of zero bits in the mask is equal to the number of bits
-	 * in a full mask minus the number of bits in the current mask.
-	 *
-	 * The MSB is the number of bits in the full mask because BIT[0] is
-	 * always 0.
-	 *
-	 * In the special 3 Rank interleaving case, a single bit is flipped
-	 * without swapping with the most significant bit. This can be handled
-	 * by keeping the MSB where it is and ignoring the single zero bit.
-	 */
-	msb = fls(addr_mask_orig) - 1;
-	weight = hweight_long(addr_mask_orig);
-	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
-
-	/* Take the number of zero bits off from the top of the mask. */
-	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
-
-	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
-	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
-	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
-
-	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
-	size = (addr_mask_deinterleaved >> 2) + 1;
-
-	/* Return size in MBs. */
-	return size >> 10;
-}
-
 static void read_dram_ctl_register(struct amd64_pvt *pvt)
 {
 
@@ -2813,59 +2813,35 @@ static struct amd64_family_type family_types[] = {
 	[F17_CPUS] = {
 		.ctl_name = "F17h",
 		.max_mcs = 2,
-		.ops = {
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
 	},
 	[F17_M10H_CPUS] = {
 		.ctl_name = "F17h_M10h",
 		.max_mcs = 2,
-		.ops = {
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
 	},
 	[F17_M30H_CPUS] = {
 		.ctl_name = "F17h_M30h",
 		.max_mcs = 8,
-		.ops = {
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
 	},
 	[F17_M60H_CPUS] = {
 		.ctl_name = "F17h_M60h",
 		.max_mcs = 2,
-		.ops = {
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
 	},
 	[F17_M70H_CPUS] = {
 		.ctl_name = "F17h_M70h",
 		.max_mcs = 2,
-		.ops = {
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
 	},
 	[F19_CPUS] = {
 		.ctl_name = "F19h",
 		.max_mcs = 8,
-		.ops = {
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
 	},
 	[F19_M10H_CPUS] = {
 		.ctl_name = "F19h_M10h",
 		.max_mcs = 12,
 		.flags.zn_regs_v2 = 1,
-		.ops = {
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
 	},
 	[F19_M50H_CPUS] = {
 		.ctl_name = "F19h_M50h",
 		.max_mcs = 2,
-		.ops = {
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
 	},
 };
 
@@ -3414,7 +3390,7 @@ static u32 umc_get_csrow_nr_pages(struct amd64_pvt *pvt, u8 dct, int csrow_nr_or
 
 	cs_mode = umc_get_cs_mode(csrow_nr >> 1, dct, pvt);
 
-	nr_pages   = pvt->ops->dbam_to_cs(pvt, dct, cs_mode, csrow_nr);
+	nr_pages   = umc_addr_mask_to_cs_size(pvt, dct, cs_mode, csrow_nr);
 	nr_pages <<= 20 - PAGE_SHIFT;
 
 	edac_dbg(0, "csrow: %d, channel: %d, cs_mode %d\n",
-- 
2.25.1

