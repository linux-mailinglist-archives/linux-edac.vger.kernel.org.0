Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0013B856F
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jun 2021 16:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbhF3Oxb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Jun 2021 10:53:31 -0400
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:40513
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235141AbhF3Ox3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 30 Jun 2021 10:53:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEeAHN0s/sMrpOKUOrKM4OboBe5hAMa+vGrz+JSiVOexPaInlxMkc46X0r94SUOSCDFQg0Tli4sVfgGG4jbiCBGQiHSuRwRbeKc69eb/s7JZXbUiJWNE1b3jXosV5aUyFEta8E5/N5bWPc4n8EB3EKTfsyCKdpih4yLtEo8r9UzHsvFccTqRLZzAmT1GZSnsOLKHmCGWtfcEcGz3Xa5Ay3NZmodRPxTyqzhftgpLGGcVV+5roXv+JBwhn1IizM5UfDhBTSXvDWim2gCUDE9gmkpv4Z8ai8HvrCGXay5Xcp9kK/oIcKgQ1YLhwEoocBDNvUWZKQSOa32YKJhmqX12Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUt2kdiN34r5XTw8skP8FGdTqvzZxGf6Hq0nTWByXII=;
 b=iS4/3rNjBE6VhUysfNquanT96Ploj/HBVWp3EOVICRgSki6ck4tHCw7evlaN/YpNCNFKRdfkJf8FwCTc1wFPTbWkhZQb5YaWVKMYXUk8j8Ng7UTtAYSp/9SM8Jqv6daTShz+jj6b4xnjWHx9c3F8JK4sThtig65lcZBw7S6fvOxhRMrNHqCuMiEHFTEZCwqtNWl80oxrDnSdD+C/+sfa4R0gCSAbhho6YtPnCcuH6cz89YZL+YEjrs93thZvHK29/gMXI0nKI2sZMHiJAxWJvP2gkQ/w3+PH2J25xLcuObcESOlalFyzB44CDa2c7QZNyfEyODj+A7eHdG3gwdxy6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUt2kdiN34r5XTw8skP8FGdTqvzZxGf6Hq0nTWByXII=;
 b=vkUA7J7H3ghC77cQR58TFhoQ2t4x0K4UOd+9LplfYi4ccJphxwB57Sqf/8IJrW4X23sHLQC1lEjaeS3RCdXHAkbHgNZbsIDklKQCG5xa/BETn4mSE+C6+NpIZCXH8CVlHny1+CflqRoJ+ckuNyGqFBm4+QKbHBuypCPlB0lsa6w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 14:50:58 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022%5]) with mapi id 15.20.4287.023; Wed, 30 Jun 2021
 14:50:58 +0000
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     linux-edac@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org
Subject: [PATCH 5/7] EDAC/amd64: Enumerate memory on noncpu nodes
Date:   Wed, 30 Jun 2021 20:58:26 +0530
Message-Id: <20210630152828.162659-6-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210630152828.162659-1-nchatrad@amd.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SLES15.amd.com (165.204.156.251) by MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 14:50:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5339eceb-daab-40f5-2109-08d93bd678a5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB504556D2C6AB9E49A37EC5A5E8019@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oq2JeRt3VMN/YTHe4Vcc5t2uKpv0xns43KQr5yh7+IWl8G7h9S+WvzIKLWjfQ2gPgylvJNIUkAquLo8xGTU0G7cYxDyGIGcC4046YQcX+4sCF+g3SPqxsPJyFMQje0KiE8hjaizocZPnBDdIqypmjREI+1QcK2/JnByfaoPyrwjAeFoOlB3Llvily3Sjh197GzZ63mF0hXdeKx4jCzOK5Tun5yYXoffiwtpNaW5IAaO3ywBBltpSmOYI22Q1nk74cz/SU0Osh79HFxDkcRUmJVxo/ix7bzDMkeYPTo8xhPtonG7h7WemYQnyOMZmD8g0XnQUofclx4BLJQjfa6TfL5CI1PbYBmGbEYXh89jPDP7GbCrduOtWycWJa9JVD6oT3ivt5mltInS2qypHI3nFS6wHVipqZvDbYtz2lZKX1+tR9WBBAq9RtvlKDCeBaGg10dMaRLAsY7SVsLEopxXty/VOW/XDnyDvi9YMIhrppFvaMcS1QAePjCcolw22QOiFts8GT3ad737VAfXSb5iRO71hj/8kYayfkDC5WEQxRCVvrgRAlmnW9zDnsNeeXFlFD2hNC+RyiinBDqNiTHhOHmUF4MOLWegxWNO8n0y8stLnide/SusVHUZOMkrRJKqjHTIXU5aw21ZUQpNj/IQ+lBQGiaet/mpsUmIVX6LXw1UHSuOoZfwyCBEnj56LmiLJA3VP+zfyl2nI7MoJnaTLxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(36756003)(478600001)(83380400001)(6666004)(52116002)(26005)(7696005)(2906002)(6486002)(30864003)(4326008)(66476007)(2616005)(956004)(8676002)(16526019)(186003)(5660300002)(66946007)(66556008)(38100700002)(38350700002)(316002)(8936002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UJy6klG1B0w2v5PBV4Q3yvYyvNGYTWBF2GNvtsO3rvbRJrVDSHmFhGsyLQNH?=
 =?us-ascii?Q?ZF3qmw3N4+mk4r82QyeYvhXJK4ClQBFTP1eeJVab/rusOWfqQcGzQlcKNpBH?=
 =?us-ascii?Q?GJbpPlseYsZ7pYS3xm8pfvpslengNlmz5JCCEyKNfDzvl4Sa9LzjwktGfnXI?=
 =?us-ascii?Q?bbFtTvwdbYlQVLlroMPJ2syPsLNeqx/7unmWcl4jPJySZdn637S7CaKPW8Op?=
 =?us-ascii?Q?1Oyk9Y6CEEdPL0UyTFFqw3jQ9cq4c0DyxSijrgURnsenjHBVUEvByQ/5OiZM?=
 =?us-ascii?Q?viZYxkzrHKeUg6Hr4fjQcIJNSmAdBwoHCfutFBASuAQlSJcryMUahSFm1SgL?=
 =?us-ascii?Q?zVeqRwwtBl/Wfcf3RjtIXnKKuIpqMzKl1oZatD4Xv1OFUNShJBTqZ4dT5DJ8?=
 =?us-ascii?Q?mP9oIHjvZcUq+/fwoTch4D3CSSIMxGRDonAiojkd7+sSdw5RVFSxXOnJExT0?=
 =?us-ascii?Q?pkUXFCkFoLaocsrkeOjoSeneTY97TbvNK7apoMt5Jr82aOmjayhyad9TfKuN?=
 =?us-ascii?Q?7yytVw65LrjkAbASxOVrUmi9iXWztr3yFpjbXtfJrfeA3cLMj6RTtdHZ9EUM?=
 =?us-ascii?Q?Sblsj27l6yHw9Mlvj2JgVJ9/sX6LyKTh6pyig+meNMQWADDAkeEwaOijUVMx?=
 =?us-ascii?Q?C2CK7GF1KKDVh5zcFHCzsZ3qsXt+zXNgAtg1MOu9BlisKZJzuhD3pJoLnVFo?=
 =?us-ascii?Q?HEQTxurfUf9IfpYbk6eAp7lC+BmWNLLATH74OEnuMDNpg/9NrpcU5PSyNMbh?=
 =?us-ascii?Q?+riM7RfFpGw50kgYELItSsDeKVCpPy+FB5LCq7edqjnRgTek5VFM8psDF+Df?=
 =?us-ascii?Q?dyCt2vOirNIjj6hSOldxjOxDbWvUMHmSasos3cSuFol55TWdmno6dlx1XJLw?=
 =?us-ascii?Q?0r9jIBPmVqFmvrZzqnn145y2NS3gTR2tdhOyZAgn3YqiJ/vfNtC6TwvBsj9Z?=
 =?us-ascii?Q?AUwLpASI6nzV+8ozK7HeT2YRM+DW5IVJdoHEd4g7LBcz1j6tczHkZ9iLmfxC?=
 =?us-ascii?Q?ZtmEoeVVDtF1ttIXxWq9iJsTLYuItvvpBPa1e9FrOTQHdMlSpoMpJdEF0Ayr?=
 =?us-ascii?Q?ecwVy2i8uNFyYwTKaJ8VmhBPyQHgZ+SrdPgzEBpPbstfrd3N76Ht0cO4oTDe?=
 =?us-ascii?Q?6vJk3JJOzAT7nhGLBjmsWVc1eCHca5Jev0oSOf2+12yDCB3M34E/caDO8Ci2?=
 =?us-ascii?Q?Dt0WDzxBNAgYr4foHMi9s9Z9LsOP80CJhVHNnKJWdrUm8vX3Xd6DB0Vzm2P0?=
 =?us-ascii?Q?1BqK1RNJwIuePpqzsDQhKZzIqrsTjFtbhzU8AgujkiD+FzztNOXma46hgYlG?=
 =?us-ascii?Q?5hfPZLtjDJLQCnDKhYd90FGS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5339eceb-daab-40f5-2109-08d93bd678a5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 14:50:58.5312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mh68rNrlvlI+IIgPeJ1qBDaowpa1pLvcw8m8fBxJ6TFSL4vuZWcVhwTSB2xA8Ij0Yvv7kG1dN2cyxz+0HJzSjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On newer heterogeneous systems from AMD with GPU nodes connected via
xGMI links to the CPUs, the GPU dies are interfaced with HBM2 memory.

This patch modifies the amd64_edac module to handle the HBM memory
enumeration leveraging the existing edac and the amd64 specific data
structures.

The UMC Phys on GPU nodes are enumerated as csrows
The UMC channels connected to HBMs are enumerated as ranks

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
 drivers/edac/amd64_edac.c | 300 +++++++++++++++++++++++++++++---------
 drivers/edac/amd64_edac.h |  27 ++++
 2 files changed, 259 insertions(+), 68 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 25c6362e414b..8fe0a5e3c8f2 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1741,6 +1741,9 @@ static unsigned long determine_edac_cap(struct amd64_pvt *pvt)
 
 		if (umc_en_mask == dimm_ecc_en_mask)
 			edac_cap = EDAC_FLAG_SECDED;
+
+		if (pvt->is_noncpu)
+			edac_cap	= EDAC_FLAG_EC;
 	} else {
 		bit = (pvt->fam > 0xf || pvt->ext_model >= K8_REV_F)
 			? 19
@@ -1799,6 +1802,9 @@ static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 {
 	int cs_mode = 0;
 
+	if (pvt->is_noncpu)
+		return CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
+
 	if (csrow_enabled(2 * dimm, ctrl, pvt))
 		cs_mode |= CS_EVEN_PRIMARY;
 
@@ -1818,6 +1824,15 @@ static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
 
 	edac_printk(KERN_DEBUG, EDAC_MC, "UMC%d chip selects:\n", ctrl);
 
+	if (pvt->is_noncpu) {
+		cs_mode = f17_get_cs_mode(cs0, ctrl, pvt);
+		for_each_chip_select(cs0, ctrl, pvt) {
+			size0 = pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs0);
+			amd64_info(EDAC_MC ": %d: %5dMB\n", cs0, size0);
+		}
+		return;
+	}
+
 	for (dimm = 0; dimm < 2; dimm++) {
 		cs0 = dimm * 2;
 		cs1 = dimm * 2 + 1;
@@ -1833,43 +1848,53 @@ static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
 	}
 }
 
-static void __dump_misc_regs_df(struct amd64_pvt *pvt)
+static void dump_umcch_regs(struct amd64_pvt *pvt, int i)
 {
-	struct amd64_umc *umc;
-	u32 i, tmp, umc_base;
-
-	for_each_umc(i) {
-		umc_base = get_umc_base(i);
-		umc = &pvt->umc[i];
+	struct amd64_umc *umc = &pvt->umc[i];
+	u32 tmp, umc_base;
 
-		edac_dbg(1, "UMC%d DIMM cfg: 0x%x\n", i, umc->dimm_cfg);
+	if (pvt->is_noncpu) {
 		edac_dbg(1, "UMC%d UMC cfg: 0x%x\n", i, umc->umc_cfg);
 		edac_dbg(1, "UMC%d SDP ctrl: 0x%x\n", i, umc->sdp_ctrl);
 		edac_dbg(1, "UMC%d ECC ctrl: 0x%x\n", i, umc->ecc_ctrl);
+		edac_dbg(1, "UMC%d All HBMs support ECC: yes\n", i);
+		return;
+	}
 
-		amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ECC_BAD_SYMBOL, &tmp);
-		edac_dbg(1, "UMC%d ECC bad symbol: 0x%x\n", i, tmp);
-
-		amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_UMC_CAP, &tmp);
-		edac_dbg(1, "UMC%d UMC cap: 0x%x\n", i, tmp);
-		edac_dbg(1, "UMC%d UMC cap high: 0x%x\n", i, umc->umc_cap_hi);
-
-		edac_dbg(1, "UMC%d ECC capable: %s, ChipKill ECC capable: %s\n",
-				i, (umc->umc_cap_hi & BIT(30)) ? "yes" : "no",
-				    (umc->umc_cap_hi & BIT(31)) ? "yes" : "no");
-		edac_dbg(1, "UMC%d All DIMMs support ECC: %s\n",
-				i, (umc->umc_cfg & BIT(12)) ? "yes" : "no");
-		edac_dbg(1, "UMC%d x4 DIMMs present: %s\n",
-				i, (umc->dimm_cfg & BIT(6)) ? "yes" : "no");
-		edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
-				i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
-
-		if (pvt->dram_type == MEM_LRDDR4) {
-			amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ADDR_CFG, &tmp);
-			edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
-					i, 1 << ((tmp >> 4) & 0x3));
-		}
+	umc_base = get_umc_base(i);
+
+	edac_dbg(1, "UMC%d DIMM cfg: 0x%x\n", i, umc->dimm_cfg);
+
+	amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ECC_BAD_SYMBOL, &tmp);
+	edac_dbg(1, "UMC%d ECC bad symbol: 0x%x\n", i, tmp);
+
+	amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_UMC_CAP, &tmp);
+	edac_dbg(1, "UMC%d UMC cap: 0x%x\n", i, tmp);
+	edac_dbg(1, "UMC%d UMC cap high: 0x%x\n", i, umc->umc_cap_hi);
 
+	edac_dbg(1, "UMC%d ECC capable: %s, ChipKill ECC capable: %s\n",
+		 i, (umc->umc_cap_hi & BIT(30)) ? "yes" : "no",
+		    (umc->umc_cap_hi & BIT(31)) ? "yes" : "no");
+	edac_dbg(1, "UMC%d All DIMMs support ECC: %s\n",
+		 i, (umc->umc_cfg & BIT(12)) ? "yes" : "no");
+	edac_dbg(1, "UMC%d x4 DIMMs present: %s\n",
+		 i, (umc->dimm_cfg & BIT(6)) ? "yes" : "no");
+	edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
+		 i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
+
+	if (pvt->dram_type == MEM_LRDDR4) {
+		amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ADDR_CFG, &tmp);
+		edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
+			 i, 1 << ((tmp >> 4) & 0x3));
+	}
+}
+
+static void __dump_misc_regs_df(struct amd64_pvt *pvt)
+{
+	int i;
+
+	for_each_umc(i) {
+		dump_umcch_regs(pvt, i);
 		debug_display_dimm_sizes_df(pvt, i);
 	}
 
@@ -1937,10 +1962,14 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
 		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
 	} else if (pvt->fam >= 0x17) {
 		int umc;
-
 		for_each_umc(umc) {
-			pvt->csels[umc].b_cnt = 4;
-			pvt->csels[umc].m_cnt = 2;
+			if (pvt->is_noncpu) {
+				pvt->csels[umc].b_cnt = 8;
+				pvt->csels[umc].m_cnt = 8;
+			} else {
+				pvt->csels[umc].b_cnt = 4;
+				pvt->csels[umc].m_cnt = 2;
+			}
 		}
 
 	} else {
@@ -1949,6 +1978,31 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
 	}
 }
 
+static void read_noncpu_umc_base_mask(struct amd64_pvt *pvt)
+{
+	u32 base_reg, mask_reg;
+	u32 *base, *mask;
+	int umc, cs;
+
+	for_each_umc(umc) {
+		for_each_chip_select(cs, umc, pvt) {
+			base_reg = get_noncpu_umc_base(umc, cs) + UMCCH_BASE_ADDR;
+			base = &pvt->csels[umc].csbases[cs];
+
+			if (!amd_smn_read(pvt->mc_node_id, base_reg, base))
+				edac_dbg(0, "  DCSB%d[%d]=0x%08x reg: 0x%x\n",
+					 umc, cs, *base, base_reg);
+
+			mask_reg = get_noncpu_umc_base(umc, cs) + UMCCH_ADDR_MASK;
+			mask = &pvt->csels[umc].csmasks[cs];
+
+			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask))
+				edac_dbg(0, "  DCSM%d[%d]=0x%08x reg: 0x%x\n",
+					 umc, cs, *mask, mask_reg);
+		}
+	}
+}
+
 static void read_umc_base_mask(struct amd64_pvt *pvt)
 {
 	u32 umc_base_reg, umc_base_reg_sec;
@@ -2009,8 +2063,12 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
 
 	prep_chip_selects(pvt);
 
-	if (pvt->umc)
-		return read_umc_base_mask(pvt);
+	if (pvt->umc) {
+		if (pvt->is_noncpu)
+			return read_noncpu_umc_base_mask(pvt);
+		else
+			return read_umc_base_mask(pvt);
+	}
 
 	for_each_chip_select(cs, 0, pvt) {
 		int reg0   = DCSB0 + (cs * 4);
@@ -2056,6 +2114,10 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 	u32 dram_ctrl, dcsm;
 
 	if (pvt->umc) {
+		if (pvt->is_noncpu) {
+			pvt->dram_type = MEM_HBM2;
+			return;
+		}
 		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
 			pvt->dram_type = MEM_LRDDR4;
 		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
@@ -2445,7 +2507,10 @@ static int f17_early_channel_count(struct amd64_pvt *pvt)
 
 	/* SDP Control bit 31 (SdpInit) is clear for unused UMC channels */
 	for_each_umc(i)
-		channels += !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
+		if (pvt->is_noncpu)
+			channels += pvt->csels[i].b_cnt;
+		else
+			channels += !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
 
 	amd64_info("MCT channel count: %d\n", channels);
 
@@ -2586,6 +2651,12 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	u32 msb, weight, num_zero_bits;
 	int dimm, size = 0;
 
+	if (pvt->is_noncpu) {
+		addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
+		/* The memory channels in case of GPUs are fully populated */
+		goto skip_noncpu;
+	}
+
 	/* No Chip Selects are enabled. */
 	if (!cs_mode)
 		return size;
@@ -2611,6 +2682,7 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	else
 		addr_mask_orig = pvt->csels[umc].csmasks[dimm];
 
+ skip_noncpu:
 	/*
 	 * The number of zero bits in the mask is equal to the number of bits
 	 * in a full mask minus the number of bits in the current mask.
@@ -3356,6 +3428,16 @@ static struct amd64_family_type family_types[] = {
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
+	[ALDEBARAN_GPUS] = {
+		.ctl_name = "ALDEBARAN",
+		.f0_id = PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F0,
+		.f6_id = PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F6,
+		.max_mcs = 4,
+		.ops = {
+			.early_channel_count	= f17_early_channel_count,
+			.dbam_to_cs		= f17_addr_mask_to_cs_size,
+		}
+	},
 };
 
 /*
@@ -3611,6 +3693,19 @@ static int find_umc_channel(struct mce *m)
 	return (m->ipid & GENMASK(31, 0)) >> 20;
 }
 
+/*
+ * The HBM memory managed by the UMCCH of the noncpu node
+ * can be calculated based on the [15:12]bits of IPID as follows
+ */
+static int find_umc_channel_noncpu(struct mce *m)
+{
+	u8 umc, ch;
+
+	umc = find_umc_channel(m);
+	ch = ((m->ipid >> 12) & 0xf);
+	return umc % 2 ? (ch + 4) : ch;
+}
+
 static void decode_umc_error(int node_id, struct mce *m)
 {
 	u8 ecc_type = (m->status >> 45) & 0x3;
@@ -3618,6 +3713,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 	struct amd64_pvt *pvt;
 	struct err_info err;
 	u64 sys_addr = m->addr;
+	u8 umc_num;
 
 	mci = edac_mc_find(node_id);
 	if (!mci)
@@ -3630,7 +3726,16 @@ static void decode_umc_error(int node_id, struct mce *m)
 	if (m->status & MCI_STATUS_DEFERRED)
 		ecc_type = 3;
 
-	err.channel = find_umc_channel(m);
+	if (pvt->is_noncpu) {
+		err.csrow = find_umc_channel(m) / 2;
+		/* The UMC channel is reported as the csrow in case of the noncpu nodes */
+		err.channel = find_umc_channel_noncpu(m);
+		umc_num = err.csrow * 8 + err.channel;
+	} else {
+		err.channel = find_umc_channel(m);
+		err.csrow = m->synd & 0x7;
+		umc_num = err.channel;
+	}
 
 	if (!(m->status & MCI_STATUS_SYNDV)) {
 		err.err_code = ERR_SYND;
@@ -3646,9 +3751,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 			err.err_code = ERR_CHANNEL;
 	}
 
-	err.csrow = m->synd & 0x7;
-
-	if (umc_normaddr_to_sysaddr(&sys_addr, pvt->mc_node_id, err.channel)) {
+	if (umc_normaddr_to_sysaddr(&sys_addr, pvt->mc_node_id, umc_num)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
 	}
@@ -3775,15 +3878,20 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 
 	/* Read registers from each UMC */
 	for_each_umc(i) {
+		if (pvt->is_noncpu)
+			umc_base = get_noncpu_umc_base(i, 0);
+		else
+			umc_base = get_umc_base(i);
 
-		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
-
-		amd_smn_read(nid, umc_base + UMCCH_DIMM_CFG, &umc->dimm_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
 		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
-		amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
+
+		if (!pvt->is_noncpu) {
+			amd_smn_read(nid, umc_base + UMCCH_DIMM_CFG, &umc->dimm_cfg);
+			amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
+		}
 	}
 }
 
@@ -3865,7 +3973,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 	determine_memory_type(pvt);
 	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
 
-	determine_ecc_sym_sz(pvt);
+	/* ECC symbol size is not available on NONCPU nodes */
+	if (!pvt->is_noncpu)
+		determine_ecc_sym_sz(pvt);
 }
 
 /*
@@ -3953,15 +4063,21 @@ static int init_csrows_df(struct mem_ctl_info *mci)
 				continue;
 
 			empty = 0;
-			dimm = mci->csrows[cs]->channels[umc]->dimm;
+			if (pvt->is_noncpu) {
+				dimm = mci->csrows[umc]->channels[cs]->dimm;
+				dimm->edac_mode = EDAC_SECDED;
+				dimm->dtype = DEV_X16;
+			} else {
+				dimm->edac_mode = edac_mode;
+				dimm->dtype = dev_type;
+				dimm = mci->csrows[cs]->channels[umc]->dimm;
+			}
 
 			edac_dbg(1, "MC node: %d, csrow: %d\n",
 					pvt->mc_node_id, cs);
 
 			dimm->nr_pages = get_csrow_nr_pages(pvt, umc, cs);
 			dimm->mtype = pvt->dram_type;
-			dimm->edac_mode = edac_mode;
-			dimm->dtype = dev_type;
 			dimm->grain = 64;
 		}
 	}
@@ -4226,7 +4342,9 @@ static bool ecc_enabled(struct amd64_pvt *pvt)
 
 			umc_en_mask |= BIT(i);
 
-			if (umc->umc_cap_hi & UMC_ECC_ENABLED)
+			/* ECC is enabled by default on NONCPU nodes */
+			if (pvt->is_noncpu ||
+			    (umc->umc_cap_hi & UMC_ECC_ENABLED))
 				ecc_en_mask |= BIT(i);
 		}
 
@@ -4262,6 +4380,11 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
 {
 	u8 i, ecc_en = 1, cpk_en = 1, dev_x4 = 1, dev_x16 = 1;
 
+	if (pvt->is_noncpu) {
+		mci->edac_ctl_cap |= EDAC_SECDED;
+		return;
+	}
+
 	for_each_umc(i) {
 		if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
 			ecc_en &= !!(pvt->umc[i].umc_cap_hi & UMC_ECC_ENABLED);
@@ -4292,7 +4415,11 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 {
 	struct amd64_pvt *pvt = mci->pvt_info;
 
-	mci->mtype_cap		= MEM_FLAG_DDR2 | MEM_FLAG_RDDR2;
+	if (pvt->is_noncpu)
+		mci->mtype_cap = MEM_FLAG_HBM2;
+	else
+		mci->mtype_cap = MEM_FLAG_DDR2 | MEM_FLAG_RDDR2;
+
 	mci->edac_ctl_cap	= EDAC_FLAG_NONE;
 
 	if (pvt->umc) {
@@ -4397,11 +4524,25 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 			fam_type = &family_types[F17_M70H_CPUS];
 			pvt->ops = &family_types[F17_M70H_CPUS].ops;
 			fam_type->ctl_name = "F19h_M20h";
-			break;
+		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
+			if (pvt->is_noncpu) {
+				int tmp = 0;
+
+				fam_type = &family_types[ALDEBARAN_GPUS];
+				pvt->ops = &family_types[ALDEBARAN_GPUS].ops;
+				tmp = pvt->mc_node_id - NONCPU_NODE_INDEX;
+				sprintf(pvt->buf, "Aldebaran#%ddie#%d", tmp / 2, tmp % 2);
+				fam_type->ctl_name = pvt->buf;
+			} else {
+				fam_type = &family_types[F19_CPUS];
+				pvt->ops = &family_types[F19_CPUS].ops;
+				fam_type->ctl_name = "F19h_M30h";
+			}
+		} else {
+			fam_type = &family_types[F19_CPUS];
+			pvt->ops = &family_types[F19_CPUS].ops;
+			family_types[F19_CPUS].ctl_name = "F19h";
 		}
-		fam_type	= &family_types[F19_CPUS];
-		pvt->ops	= &family_types[F19_CPUS].ops;
-		family_types[F19_CPUS].ctl_name = "F19h";
 		break;
 
 	default:
@@ -4454,6 +4595,30 @@ static void hw_info_put(struct amd64_pvt *pvt)
 	kfree(pvt->umc);
 }
 
+static void populate_layers(struct amd64_pvt *pvt, struct edac_mc_layer *layers)
+{
+	if (pvt->is_noncpu) {
+		layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+		layers[0].size = fam_type->max_mcs;
+		layers[0].is_virt_csrow = true;
+		layers[1].type = EDAC_MC_LAYER_CHANNEL;
+		layers[1].size = pvt->csels[0].b_cnt;
+		layers[1].is_virt_csrow = false;
+	} else {
+		layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+		layers[0].size = pvt->csels[0].b_cnt;
+		layers[0].is_virt_csrow = true;
+		layers[1].type = EDAC_MC_LAYER_CHANNEL;
+		/*
+		 * Always allocate two channels since we can have setups with
+		 * DIMMs on only one channel. Also, this simplifies handling
+		 * later for the price of a couple of KBs tops.
+		 */
+		layers[1].size = fam_type->max_mcs;
+		layers[1].is_virt_csrow = false;
+	}
+}
+
 static int init_one_instance(struct amd64_pvt *pvt)
 {
 	struct mem_ctl_info *mci = NULL;
@@ -4469,19 +4634,8 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	if (pvt->channel_count < 0)
 		return ret;
 
-	ret = -ENOMEM;
-	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = pvt->csels[0].b_cnt;
-	layers[0].is_virt_csrow = true;
-	layers[1].type = EDAC_MC_LAYER_CHANNEL;
-
-	/*
-	 * Always allocate two channels since we can have setups with DIMMs on
-	 * only one channel. Also, this simplifies handling later for the price
-	 * of a couple of KBs tops.
-	 */
-	layers[1].size = fam_type->max_mcs;
-	layers[1].is_virt_csrow = false;
+	/* Define layers for CPU and NONCPU nodes */
+	populate_layers(pvt, layers);
 
 	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
 	if (!mci)
@@ -4525,6 +4679,9 @@ static int probe_one_instance(unsigned int nid)
 	struct ecc_settings *s;
 	int ret;
 
+	if (!F3)
+		return -EINVAL;
+
 	ret = -ENOMEM;
 	s = kzalloc(sizeof(struct ecc_settings), GFP_KERNEL);
 	if (!s)
@@ -4536,6 +4693,9 @@ static int probe_one_instance(unsigned int nid)
 	if (!pvt)
 		goto err_settings;
 
+	if (nid >= NONCPU_NODE_INDEX)
+		pvt->is_noncpu = true;
+
 	pvt->mc_node_id	= nid;
 	pvt->F3 = F3;
 
@@ -4609,6 +4769,10 @@ static void remove_one_instance(unsigned int nid)
 	struct mem_ctl_info *mci;
 	struct amd64_pvt *pvt;
 
+	/* Nothing to remove for the space holder entries */
+	if (!F3)
+		return;
+
 	/* Remove from EDAC CORE tracking list */
 	mci = edac_mc_del_mc(&F3->dev);
 	if (!mci)
@@ -4682,7 +4846,7 @@ static int __init amd64_edac_init(void)
 
 	for (i = 0; i < amd_nb_num(); i++) {
 		err = probe_one_instance(i);
-		if (err) {
+		if (err && (err != -EINVAL)) {
 			/* unwind properly */
 			while (--i >= 0)
 				remove_one_instance(i);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 85aa820bc165..6d5f7b3afc83 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -126,6 +126,8 @@
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
 #define PCI_DEVICE_ID_AMD_19H_DF_F0	0x1650
 #define PCI_DEVICE_ID_AMD_19H_DF_F6	0x1656
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F0	0x14D0
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F6	0x14D6
 
 /*
  * Function 1 - Address Map
@@ -298,6 +300,7 @@ enum amd_families {
 	F17_M60H_CPUS,
 	F17_M70H_CPUS,
 	F19_CPUS,
+	ALDEBARAN_GPUS,
 	NUM_FAMILIES,
 };
 
@@ -389,6 +392,9 @@ struct amd64_pvt {
 	enum mem_type dram_type;
 
 	struct amd64_umc *umc;	/* UMC registers */
+	char buf[20];
+
+	u8 is_noncpu;
 };
 
 enum err_codes {
@@ -410,6 +416,27 @@ struct err_info {
 	u32 offset;
 };
 
+static inline u32 get_noncpu_umc_base(u8 umc, u8 channel)
+{
+	/*
+	 * On the NONCPU nodes, base address is calculated based on
+	 * UMC channel and the HBM channel.
+	 *
+	 * UMC channels are selected in 6th nibble
+	 * UMC chY[3:0]= [(chY*2 + 1) : (chY*2)]50000;
+	 *
+	 * HBM channels are selected in 3rd nibble
+	 * HBM chX[3:0]= [Y  ]5X[3:0]000;
+	 * HBM chX[7:4]= [Y+1]5X[3:0]000
+	 */
+	umc *= 2;
+
+	if (channel / 4)
+		umc++;
+
+	return 0x50000 + (umc << 20) + ((channel % 4) << 12);
+}
+
 static inline u32 get_umc_base(u8 channel)
 {
 	/* chY: 0xY50000 */
-- 
2.25.1

