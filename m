Return-Path: <linux-edac+bounces-258-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A6681412B
	for <lists+linux-edac@lfdr.de>; Fri, 15 Dec 2023 06:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415CB1C2209B
	for <lists+linux-edac@lfdr.de>; Fri, 15 Dec 2023 05:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590D42F34;
	Fri, 15 Dec 2023 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cD5kxb1l"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90711C31
	for <linux-edac@vger.kernel.org>; Fri, 15 Dec 2023 05:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5faLg3HeGH3wh9m/4LHYj5JfNikGvUalpCU53A+omAPO/Oo8KPvXOJLsgeYb8Bs24VzRdpNo8iCrlkvTAgH/7O0LMO1+51fqEi/zIdpwYHNL4KohmfAPt+dRzHnNoiZw3tdh12HQJLif9Him2WDFKEK38EN/T+8YAOpuO8FYZGru45EwUxmh84JgQ2Q1Q3t9Qx9jdvMzjejlQQ1m+V0I7MR2yiI2hLyQlYsbfnYRcrFV5fxCJhTHnhnC66pVHBh4T+CefGDAfIwcxlbNTg1fePe9qSSpC3VB9o7rOX7cCJR8htybArH6naoxRPtJzoIndHVzReQfk5atARFHI/rRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsJR8Uw7iLsDtBYx2TTpYChejBJysV7Gv1sEtvdPbCI=;
 b=Ao5N20mMjumafl/R19bpow7QBqltkM06J9xoDW+i2oI3reRhxIZoTmtWnZn1Sv0QV05WPuZH917QiJSN5BEPPIZMWEG33L16VQQMOUuzXylN8ABtrELTx2Il98aiVwq15S+nEKemLn06WWPtjPKXiblg8pK7uIx4Rs9V4YWGJ5yzd/903HQWE3n5kLyPaVKMik0nliGf9DUgp0ba0O/LnaS55Zk33sByl/KSQSDyjdBLDPBtMg2ZNoVmMCr6+JFL9qn4WMCaoOBRKDM2xKYYf1JMi7cn05uDMFQNho7/VzhB2zkmXyRtbD0JvTaaNtIJ0VmSE7HURB4Nd3DR+Nr7tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsJR8Uw7iLsDtBYx2TTpYChejBJysV7Gv1sEtvdPbCI=;
 b=cD5kxb1lmH10EQllXpT3HLwUWrL2072/MNZVS3D+j+ppC516/7HN3GHKLVv0oiXvwHXIhMh7XhVeI+1sZUL94tS5yNlHXM/2B0LEsn22hqFSWMdf4/nBIf1MVXjPRMoQdQIOarq/5qxVds4+9Ub6U1ueB/SKTkpsWK5eVA1EyAU=
Received: from SA1P222CA0132.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::15)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 05:17:53 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::92) by SA1P222CA0132.outlook.office365.com
 (2603:10b6:806:3c2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.29 via Frontend
 Transport; Fri, 15 Dec 2023 05:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Fri, 15 Dec 2023 05:17:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 23:17:51 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 14 Dec 2023 23:17:49 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>, <shubhrajyoti.datta@gmail.com>
Subject: [PATCH] EDAC/versal: Fix the read of the num_csrows and num_chans
Date: Fri, 15 Dec 2023 10:47:49 +0530
Message-ID: <20231215051749.6969-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: c7251e75-1c6e-446f-5a63-08dbfd2d3019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BoTLPjbab5psHm5nZInyTTH5SWnJGtWLWEYKc1b3GrGev3Kn7d4r7xwpEBRd3draN3Y6maOGs4yAFlgrlLtkehdldA4cDxZnlpqaA6I5+pXnGOKm5MNNVQnSAiHRN5RsWXyCONndBayYcWbFhbvkB5pTZQ/3dKdgqKjc9UIDBQa8TaVrQcf1dQ2NNarMKk5mDhwCcS9bgSR4RFFVnwXJupu5nuIpgwuteP4dqSXWzeR1gRs1eq7wbyvaPP2yHRND/5Foi7g9Hxzn/khRL+gcFuzSqokjArzBjrqfCl0S7kSMwGjGaxVPw2leGJsMrPJ3PP4YkyRSCYZyo717vmYZ6Wce9RTQzRIbB/O+aBNZjrhRC4/fwaiia1wo+0uR579W88k1dAKs7zWjH7TIqE2iZ4XUjqzdlEqWttCfpQqKwD24zktnd0ds40Y89F/aWDXGrL8b4pHJL81ECQ20NKkW4G2vbSZ5o46iP8lodtMjh327s8ijnbsWnNTPKUzJCfg0+F7gohhrcqNMxD9UY5zOFKH/4Wxh5DBBRLVlQgjFCHdnU8tdsAYGQX80U0W7WsspkYU849x7/g65oVlQ1jxIR5GyFD+lx+LGOTXUdPDOjIFFRXjvBawSp2FXtJHuDONegA/kAtk+V3729dPa4Mxs6lkbt/EV6zJnGeK86zgYWh8eSURjBj/9O6lyh+AfKW3zwyGAA/skmJl/kqaIRhVvnPto8YniX5Pu9NswUPjkm3BngfOUxhFcwMfW48bqxaFD7Czm79bHtrVYYihQiR59xw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(336012)(1076003)(26005)(2616005)(426003)(83380400001)(36860700001)(44832011)(2906002)(5660300002)(41300700001)(4326008)(966005)(316002)(47076005)(8676002)(8936002)(70206006)(70586007)(6916009)(478600001)(54906003)(82740400003)(86362001)(81166007)(36756003)(356005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 05:17:52.4755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7251e75-1c6e-446f-5a63-08dbfd2d3019
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661

Fix the extraction of the num_csrows and num_chans.
The extraction of the num_rows is wrong. Instead of extracting
using the FIELD_GET it is calling FIELD_PREP.

The issue was masked as the default design has the rows as 0.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/60ca157e-6eff-d12c-9dc0-8aeab125edda@linux-m68k.org/
Fixes: 6f15b178cd63 ("EDAC/versal: Add a Xilinx Versal memory controller driver")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 drivers/edac/versal_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 87e20f39f999..f0d8702802a1 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -1038,10 +1038,10 @@ static int mc_probe(struct platform_device *pdev)
 	edac_mc_id = emif_get_id(pdev->dev.of_node);
 
 	regval = readl(ddrmc_baseaddr + XDDR_REG_CONFIG0_OFFSET);
-	num_chans = FIELD_PREP(XDDR_REG_CONFIG0_NUM_CHANS_MASK, regval);
+	num_chans = FIELD_GET(XDDR_REG_CONFIG0_NUM_CHANS_MASK, regval);
 	num_chans++;
 
-	num_csrows = FIELD_PREP(XDDR_REG_CONFIG0_NUM_RANKS_MASK, regval);
+	num_csrows = FIELD_GET(XDDR_REG_CONFIG0_NUM_RANKS_MASK, regval);
 	num_csrows *= 2;
 	if (!num_csrows)
 		num_csrows = 1;
-- 
2.17.1


