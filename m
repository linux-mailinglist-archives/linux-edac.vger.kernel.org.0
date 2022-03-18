Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56F24DD8DB
	for <lists+linux-edac@lfdr.de>; Fri, 18 Mar 2022 12:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiCRLV6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Mar 2022 07:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiCRLV5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 18 Mar 2022 07:21:57 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140045.outbound.protection.outlook.com [40.107.14.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645931F977F;
        Fri, 18 Mar 2022 04:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY571SHpXd9jN86bX/JdEWW7UPKyzCc9LkrxeO2/RtwBYjyhZoLHza+V3dpZ1GxyynXsaZvVSHQWSW/nBiafWwidS0C8o2cmUSakQRnGgmYRAFbZ91sY+vnpImrKGTJWFAzuTRprByV2zIXhhiNvV6J+tVZZ+tzNleFg8LohIlVpS5DEAOrR/NjXndnDo700dbvlybI5iEeui/lGKUml/PW6Ki9mc1lbJHXZKQshiIvoKAIVHJ7J9leWrhTBv/SfrZCu5dCXiQgohj3V2HFHCRoddmJ7P7J5quwzwyVCTMedRWSBSzK/5dguNEXde2mRhXAU6E5UOSNDxhhWdY3tqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv9pWvDFcj0DiuD5mXdM3dLUCtqvlx59ezLfhJEp8nA=;
 b=jcXXoYXUjtX68QGxI76r9ahe22JlSnE1fCWaCzPATPtOIPCf4uZ5pjsWokliQwiOWvYr8JWO9FBsFMEoLsaU3m7iBtBBL/Rppj1tPoy4lHW0tEV2sZpgkVQ6XUA2kMNjPsib38D35SSWurO6QVGwTphOeWHHjZYAHkStE9xnEGvP9X60Juwq9C8947ijpaomdPpNuWE1XfUuHqjdOF/XbxAd89hzRlVcbZJkIRVr8XXLvP0UMKSnsBmcSJ7Qy7+Bdac9Cyz/0o2yYgJphdu1+E0Hi6DrjCuH1QgF/umQkpMpxboUMKhwyfy9SMCfi/77sdTDZNa33+CNNal2unZHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv9pWvDFcj0DiuD5mXdM3dLUCtqvlx59ezLfhJEp8nA=;
 b=r+1N6720B4tQoGfEGm0QCQ7gVkV5xS6cp9lnomMX0ODYgSei2r3VCUQvFPyNK+cxxvYfT5/Y++3VWNrRESLq1jvCMYTa+TV6UJxZuwZCzelN8OTVyETxari7x0qNydf1USi8krhyeTH9Ll3eGSzzv1vESL7xK+pbKbnGbSjeKM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM0PR04MB7108.eurprd04.prod.outlook.com (2603:10a6:208:19e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 11:20:36 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 11:20:36 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, michal.simek@xilinx.com,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH 2/2] EDAC: synopsys: re-enable the interrupts in intr_handler for V3.X Synopsys EDAC DDR
Date:   Fri, 18 Mar 2022 19:17:42 +0800
Message-Id: <20220318111742.15730-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220318111742.15730-1-sherry.sun@nxp.com>
References: <20220318111742.15730-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0088.apcprd06.prod.outlook.com
 (2603:1096:3:14::14) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e160cf6-235c-4dbc-62be-08da08d152de
X-MS-TrafficTypeDiagnostic: AM0PR04MB7108:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB710877FB129C2EB731913F4192139@AM0PR04MB7108.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9cCF+xA6q+mbP+Za2GjTXJ3pydnTkDPUWCKMew4cNK66ZvlQ8p+mvtB43+/nsyPng6rUQ30tdXu6ulASx1RmEQxNpxkDZrQ24/YAny7WJbKmOaqFft9kL7Z052IS2kBgRfhLeO0IDWBadmcBQtY5ms5POdm4RpRxsDvhQrZH6JItdL0gXNl3KPU2vt8/y5OHcIw7N0yiqeZpD0mJHsisJI2aIaIrEtLCgHCBkbZYQI/U3chqPeGKrvXTtcHBimjNOvbZQ5zL7b31v+dyWjMcyugW3L2nnnos/H38BBBYJs7ZTbBvfB5UupiKUiYJQ2zU0iBecnu4UmpVwM6X8M7fK50KuQbD/iPiq1CY5ETRJStOcmvmUPw3zQq91DHnXWWoPnBwg2BeNL/tRpxq8Aljq/4f4FqNUnOAjb9roE+yQU4jvTJtcutOtL/Grmprye2KahTRA3KFLaHa+9JiMrq5+VEP5tX81hByTSPa43Ac1kJ3DL7EJ4sJ8UfPPMlHD3zbT7VDSLJ12ptczDcDqLUoezH6HYwH4DGXZLgLlIHzlj9W6WJDUpjOlYyvLGV1T44K1BnLuwOL2qD/UGEMFDdk92FQP/m/4Bdge1vo9uevwh4PGyiq2tyOWJlJT6SJH4s2OmjOEnzFDE54TRMROWQW5Mwsf7ezmmcyT+HWZIgrMN2V7uhUM/J/7oqxXBdB1BY2o8R1UUxpaMP2pWFHl4Xuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(4326008)(8676002)(66476007)(66556008)(66946007)(6666004)(6512007)(44832011)(316002)(2906002)(83380400001)(36756003)(2616005)(26005)(186003)(1076003)(38100700002)(38350700002)(86362001)(508600001)(5660300002)(52116002)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YGCxf/iuIgrCt681isTM6dydTqmLM4lVPJjGDON9L9Al+5HZVSn1mStzoITm?=
 =?us-ascii?Q?CUCOX8YhFgt5SMZ9KrpE8YCLhEy0b/WdwTOxRHzimDOU+e3SAJbgLpUlDR9+?=
 =?us-ascii?Q?+8NtBftEPTiIyYx3wdsKRs98M65IgmgLOXGT6s+Ho53iG6fB22Cpx1XOnAtP?=
 =?us-ascii?Q?Wi4K8/Xx0l1WGNeDS3Fb02cnoso9rVNEERT5BEbW89SbJ+9uinqA//llv2+V?=
 =?us-ascii?Q?XQBlIs7xc3Gc7iZ7qsr7RsF3DmiN082jNE10XQ90xGIimaQaxKaeNSL84VYn?=
 =?us-ascii?Q?+jMHl4ZNRlLkns4+px4MPDLN76+Rl/gFcvCg7j8VU6hzuMlTPnzUPgZj+5Ff?=
 =?us-ascii?Q?ruhQbNeez7EOpiON+/mzy63AbtUc9WwoCquOHMJNiUdgKzt+DpWIFQEThcNp?=
 =?us-ascii?Q?WQ1XxEtc8yD9hAJFxYekFooBm4pw7u0SRh4ox0hnaMKoxfRWv+xb/Rsno9dw?=
 =?us-ascii?Q?vyXc533COoel8kZDGUceI9AyAnoI2pYAspdDkAjg+0UeKt76mSlHBeYIWTuI?=
 =?us-ascii?Q?CyiatFP95o7JKgFd3Wqg1QeXWSmLoEKKKxmnDFbo2EYT9RnbGplfUjqU+gBt?=
 =?us-ascii?Q?aTvDksiCOQpFounlmwuT5zHMitz69XCL9OWMub9gj1+m8IL8fryNn0bSi5ko?=
 =?us-ascii?Q?RbeZkk6Nbtq2nfw7NScuI0CJrGMV+VI4Qa324J82HGc043PSnnoMBWfO4TA5?=
 =?us-ascii?Q?tjZHRY2essyGCoaQOFLTY9BrFf8OuLFJ8qPCdF5i2Uy1IPlen8nvYC4sAM9S?=
 =?us-ascii?Q?tlZivy50Yqx8RHQQklyX+FwtQPkOLUYPVE2DfD9APIu152MZFzDKTT9A75cp?=
 =?us-ascii?Q?ZBkEOdafAooVGwKJa+nECEaDmxQBO6pgTO/EeaY6mctZEkl+pF+OUz4hNtyE?=
 =?us-ascii?Q?VeR7mez9wsS5YKbj5BhT6tre9Hm1qJ6Pk0+FJcscKUdQ4gL4y1t3F0IXT3sN?=
 =?us-ascii?Q?18fv+8mLKKr9Lr2qqMHvy3F5YyjJE5uG5dPr4u79/P+yOmj1LGiTpPDTrATg?=
 =?us-ascii?Q?wM6YaLYPAUhGWLIv0BuaadZQvU9jLn7IJx7HE5txEysOLGVLcmF07oka26kf?=
 =?us-ascii?Q?ZforkIbx4pIPYktysTNcVbYa5UJhH8FUHjpu7WXd7ysxKKPBdoBLbd8CA0oE?=
 =?us-ascii?Q?4LEKH2fnzJ254+gtaYR8YW70NHcFm0VPZMwY6hW+c7idKnnyJUkbfs0y++Sl?=
 =?us-ascii?Q?JSTipBscT74xvh7Srk++UENpBn88mB/gVRSFAVTf4B2sMo2d3jQjK6j7o1ue?=
 =?us-ascii?Q?9IusfAkvOKNoycX5QqPsHMreey6QTCr9WYxnCdc/VQ5JjaKKzcL2YuqhPvnm?=
 =?us-ascii?Q?X6MIuLFHcfzOsLSIuNKNZscDXMH1fZGYUpI/3ayt/zYlmxEyljfoVbVUpY8O?=
 =?us-ascii?Q?HdfRb+ctiFkTz4X6X1q7kB03pi8jC5LtkDad47mfFDw/L4AvlZgSFn5+Js0m?=
 =?us-ascii?Q?T/zpQPQL28rq9COE6ivGN3qWUmZJH5Ej?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e160cf6-235c-4dbc-62be-08da08d152de
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 11:20:36.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kMDucH8+g8YwD5hdz+HZe9L1iLuFLLOlJW/LtD4hOx2oRE44tTfoAA1r1TU4Wr88/tj6wi3LBvc8LGEvUBIIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since zynqmp_get_error_info() is called during CE/UE interrupt, at the
end of zynqmp_get_error_info(), it wirtes 0 to ECC_CLR_OFST, which cause
the CE/UE interrupts of V3.X Synopsys EDAC DDR been disabled, then the
interrupt handler will be called only once, so need to re-enable the
interrupts at the end of intr_handler for V3.X Synopsys EDAC DDR.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/edac/synopsys_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 1b630f0be119..3a1db34a8546 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -521,6 +521,8 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 	memset(p, 0, sizeof(*p));
 }
 
+static void enable_intr(struct synps_edac_priv *priv);
+
 /**
  * intr_handler - Interrupt Handler for ECC interrupts.
  * @irq:        IRQ number.
@@ -562,6 +564,8 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	/* v3.0 of the controller does not have this register */
 	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR))
 		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	else
+		enable_intr(priv);
 	return IRQ_HANDLED;
 }
 
-- 
2.17.1

