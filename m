Return-Path: <linux-edac+bounces-364-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F0083A208
	for <lists+linux-edac@lfdr.de>; Wed, 24 Jan 2024 07:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CB628508A
	for <lists+linux-edac@lfdr.de>; Wed, 24 Jan 2024 06:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52729F517;
	Wed, 24 Jan 2024 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p9F6zn7J"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A38F9C1
	for <linux-edac@vger.kernel.org>; Wed, 24 Jan 2024 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706077794; cv=fail; b=T/S3ZCQ9wADYonv9/N3xBHqE2XBkevzlWhnniw47xOzGHfJ1UGNhrv9ORw1CzzGgn6bneu9xZ7Xrmz5FWuuHBFvk4S7zei0PgXJCg33pis7l+bL2C8hgAIWZfjbh5WFviEJuX1J17hmTVArA6CVpnGdH8zHlCV6vH4uxBvf68Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706077794; c=relaxed/simple;
	bh=le+CyLlPtf9+EgQWkXqa7DHD5ZpggDa2ZJsJLl2A0bg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EqOJPP6Xpf1mXSCtD6Z8b0zLbi3Yr36P+j8dVSSs79Iy4mOFVUIh//ZNNz3ejvTCFiGT0uibm0fTEq8vIkoblGXgPj/gm1VGraBdNJ6mqM0IYqwEJerMDUewDBzUShhJX8O6cG+HKWmapPQ2V//USbqQ71aNS+7QVI8jlEilZXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p9F6zn7J; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLYCJsZ/gJllYN2JcN1ppD0IOB2mJ7kYuhZecbMMHubtk0zIxeKp2FkllMMsjJypcuKw04J2uIdNBiMNSnwITqSTtD4+wLAGJU4UPEDz9TdtsttgE6zxtuW27yo3L4AlW1x5JCXTF6Ygs5Tw+VPvVe/6w+eh2YEZVoB99IieStNccTSkPxPY4GRAbEQ1vLZWvzZDPIF/Ng75WvITo6xXILEsUD9cd1TWR02s9qL0biW1RI/xpEPpwEBS0BdYKrG0EgRRwiiv2NiIJ2TRv5awjWKIdbhyLVEyGlR876dLk8r/dWRKvyZdHs5nRFVJblDwDZ6rEKrIf2Vp+x8Jz8ExNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Irl9kmDCRadE03cwcdfMrrwDDexyGclXH7zBGLWkbs=;
 b=b+eapoaRXWWkxjsMz1tJqfUzA2qln4C1Z8JuKhAnfhUtP62uQULhuvTOfP9TnU845ZFugm8C7IrblAbJ+7T22g5LnZcHF1wDjlXka3ZQC25lYfJTmGOex9E0oktOHeRLNGLi3HubWnhgn6vrNkmjzcblukZTFPDLewq3W00SGOf7qmxDEUMIyuva2RFWNm8IZ2GccqOKCsJyvcLF1DKFVQrJGCVUH3lVzVMhmH/42KXFbw+yJRemjVhAAX/z25GHzOZe940xYyp6ezs72pZgSKUzy92lcC1vOQ2Q6ajGacoKkrAANlOtjayiWvny1teVZs6DzjCjVKm0zIG/S8UkkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Irl9kmDCRadE03cwcdfMrrwDDexyGclXH7zBGLWkbs=;
 b=p9F6zn7JyEctTB3zYC0Tt7COudJscUTZDrHRSrp4XApCwgUFVRPl+gOaSdLR6qK913ptaRvgHiLD1qb5N6aCGe81X4f/pBakOBDw/Le89xAberIxNL/P51sjPDptQ1ViBmylejDFGMfaCbwjiWTteGWOalYJVgZBTVzeZU+GH58=
Received: from DS7PR07CA0005.namprd07.prod.outlook.com (2603:10b6:5:3af::15)
 by MW4PR12MB6973.namprd12.prod.outlook.com (2603:10b6:303:20a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 06:29:48 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::cb) by DS7PR07CA0005.outlook.office365.com
 (2603:10b6:5:3af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 06:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Wed, 24 Jan 2024 06:29:47 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 00:29:46 -0600
From: Muralidhara M K <muralimk@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <mchehab@kernel.org>, Sathya Priya Kumar <sathyapriya.k@amd.com>
Subject: [PATCH] rasdaemon: Add error decoding for MCA_CTL_SMU extended bits
Date: Wed, 24 Jan 2024 06:28:58 +0000
Message-ID: <20240124062858.612647-1-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MW4PR12MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: af8a24ac-886d-435f-8946-08dc1ca5dce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7MCTShUvbT1CGJVjXub5FhLonKanJakB7nbIfeTk8Mm0tRo0VZ1gx9xSfHNWun36AelnCue9Lk9zFkz0jL6o7pStHG7ote+Jgo9BgY2KNCqfoPWsG7AzsKREMM54u+7y6U4kdyDO8Gh2pHNlV+gH/45fgcn/GVLmu7e8UhRkaytdB61rUl073pBTVuGfr0WlSB9RUx1lLzxpFEoKVE7FVJItBIwx6+e749ieWRiqfwl6VDMg1K9A6zrgX0u47L2MBJ6NWBt0vTX7HAYcHfU+qfhrIYCIcH1V7HL3arbcE/0sNNUKXLjW7ATSZ4X1CHbNqBUthGd8k7bwC7R81CvnH0BM8awDFXARHQiH6pcPA+xoUWeCs299L2sLXCYdib2CjcNGO4pZaG4sYfaA3u1eJE7bha7BVlsqemM2Oq4L5fDszCffyhk9LErqFT0cD+wthAErWBa7hfEu4qNHSgbWX2+APGtlwmwIiCMyam/XljBocm/A9BzvjsIPDkYRQOiNeMoDAcgvkpNvDLt3FNu0lXQ14L5juzIoVRr01/gpmer3GZPZrnVEimfIcQb0wwb6rl7balR4ARkwzlBiF4gkQivcmMdhMy4PJIQW2TIJUwHF1vKeoyr1qyCSj6A4Epz2ZKHR5pMzXnwJu9Zxhq2LFPnZaVgTfHDXQuF030g6PI5qjysp8lOpSYDRNDgACnSMrrw0b48zFf+JaX/GaEQitmlyRKzSJzPU/JiFUTkUDAIg5QiRmdhPQtYaBAEnyWxdV2u/httYdZXjzee3p39MdQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(5660300002)(8676002)(4326008)(2906002)(41300700001)(16526019)(47076005)(83380400001)(7696005)(6666004)(40480700001)(1076003)(426003)(336012)(2616005)(40460700003)(26005)(478600001)(356005)(82740400003)(36756003)(81166007)(8936002)(36860700001)(6916009)(316002)(70586007)(70206006)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 06:29:47.9689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af8a24ac-886d-435f-8946-08dc1ca5dce2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6973

From: Sathya Priya Kumar <sathyapriya.k@amd.com>

Enable error decoding support for the newly added extended
error bit descriptions from MCA_CTL_SMU.
b'0:11 can be decoded from existing array smca_smu2_mce_desc.
Define a function to append the newly defined b'58:62 to the
smca_smu2_mce_desc. This reduces the maintaining Reserved bits
from b'12:57 in the code.

Signed-off-by: Sathya Priya Kumar <sathyapriya.k@amd.com>
---
 mce-amd-smca.c    | 33 ++++++++++++++++++++++++++++++++-
 ras-mce-handler.h |  1 +
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/mce-amd-smca.c b/mce-amd-smca.c
index 45cf67d..7521ff7 100644
--- a/mce-amd-smca.c
+++ b/mce-amd-smca.c
@@ -397,7 +397,7 @@ static const char * const smca_smu_mce_desc[] = {
 	"An ECC or parity error in an SMU RAM instance",
 };
 
-static const char * const smca_smu2_mce_desc[] = {
+static const char * smca_smu2_mce_desc[64] = {
 	"High SRAM ECC or parity error",
 	"Low SRAM ECC or parity error",
 	"Data Cache Bank A ECC or parity error",
@@ -409,6 +409,15 @@ static const char * const smca_smu2_mce_desc[] = {
 	"Instruction Tag Cache Bank A ECC or parity error",
 	"Instruction Tag Cache Bank B ECC or parity error",
 	"System Hub Read Buffer ECC or parity error",
+	"PHY RAS ECC Error",
+};
+
+static const char * smca_smu2_ext_mce_desc[] = {
+	"A correctable error from a GFX Sub-IP",
+	"A fatal error from a GFX Sub-IP",
+	"Reserved",
+	"Reserved",
+	"A poison error from a GFX Sub-IP",
 };
 
 static const char * const smca_mp5_mce_desc[] = {
@@ -815,6 +824,27 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_GMI_PHY]			= { "Global Memory Interconnect PHY Unit" },
 };
 
+void smca_smu2_ext_err_desc(void)
+{
+	int i, j;
+	int smu2_bits = 62;
+
+	/*
+	 * MCA_CTL_SMU error stings are defined for b'58:59 and b'62
+	 * in MI300A AMD systems. See AMD PPR MCA::SMU::MCA_CTL_SMU
+	 *
+	 * b'0:11 can be decoded from existing array smca_smu2_mce_desc.
+	 * b'12:57 are Reserved and b'58:62 are appended to the
+	 * smca_smu2_mce_desc.
+	 */
+	for (i = 12, j = 0; i < smu2_bits || j < 5; i++, j++) {
+		for ( ; i < 58; i++)
+			smca_smu2_mce_desc[i] = "Reserved";
+
+		smca_smu2_mce_desc[i] = smca_smu2_ext_mce_desc[j];
+	}
+}
+
 void amd_decode_errcode(struct mce_event *e)
 {
 	decode_amd_errcode(e);
@@ -905,6 +935,7 @@ void decode_smca_error(struct mce_event *e, struct mce_priv *m)
 	mcatype_hwid = HWID_MCATYPE(ipid_high & MCI_IPID_HWID,
 				    (ipid_high & MCI_IPID_MCATYPE) >> 16);
 
+	smca_smu2_ext_err_desc();
 	fixup_hwid(m, &mcatype_hwid);
 
 	for (i = 0; i < ARRAY_SIZE(smca_hwid_mcatypes); i++) {
diff --git a/ras-mce-handler.h b/ras-mce-handler.h
index 976fb4f..4f71dc8 100644
--- a/ras-mce-handler.h
+++ b/ras-mce-handler.h
@@ -125,6 +125,7 @@ int set_intel_imc_log(enum cputype cputype, unsigned ncpus);
 /* Undertake AMD SMCA Error Decoding */
 void decode_smca_error(struct mce_event *e, struct mce_priv *m);
 void amd_decode_errcode(struct mce_event *e);
+void smca_smu2_ext_err_desc(void);
 
 /* Per-CPU-type decoders for Intel CPUs */
 void p4_decode_model(struct mce_event *e);
-- 
2.25.1


