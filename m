Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038D3702BAB
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 13:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbjEOLkO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 07:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbjEOLiL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 07:38:11 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5FA1FED;
        Mon, 15 May 2023 04:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+kdIOZHg2w8eEdZs20PYoxL69xalMwPq+wCXuxF/XAkfZOS2HsPk3x4OPF2zFy4ucdeD5+UinHTT1Rr4sMuMA+i/skRBv75VLnwHx1qMeZ2LW6I4CKSeAt9MP6lddelyTiWkmx2gueyw4oQ4ANUPiPyWDGh6b5L9P56nbsUJNoW59eRTJ+J6aVfijxsRVYYBeINJXrLOcqN+4igLIShyI551+x5msJoCytFYFPSVWTXG8SzLY6z1ESrOJfbPhZ2xmwBAG4DSoWP+2d5FI4YlD93NPrMEuvSS42K1f5kWvJQrBTECsfyFllcIv8mb5ghDkQQIl+u/GQNm3PcjjytXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxo+4t2JTZ3v8Vol6QECHiP0JqOkA6QErxaO9nzbiHc=;
 b=Nhx1NqdGilKDDfPAvOyqgN66SL95utvfPDb1zL6lYYf6A2FS4Qcs8vHlddTwoB71tvfdgCX6NVpIY6sz/bacLDZyKBr4W4ZOpMysk+rsKl19cFxcTWvq4UvjBPIdd1Y3xEU6pyBdTzjjC8wfwE00zR1Fo053tvwpb8k8aGr5pZzsmM4iKM2jZYw+ZNcCPaWi+avLCBKCeOZV9BH21gadrdS03XQNGs75PGCQyIaBW9Fopq3IqyvdqHOoNDKn282W1R830brSKcJLgBcG4K+0UJG+yL0jrLixSdWhHey5ujA3nA8fpbMXnfPvXDXUulGXBwv44d/O8t75sADmfX0t5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxo+4t2JTZ3v8Vol6QECHiP0JqOkA6QErxaO9nzbiHc=;
 b=k63xtQyLTBEy1h+Al3YvPV6HFgYdhPOUy2t4HWNoAIPBuPEDdTQRUR0EG/l/4cS8EHN3r/gsp6hZBKzJRU4oeVBBin00bPyMSTPrzNuMg4h7tVEVr7Vm9haQpneBHbyU6c8nR2BTCe920flMZFBOXCcLONLGpzu0GtRrb0qvqPI=
Received: from DM6PR21CA0009.namprd21.prod.outlook.com (2603:10b6:5:174::19)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 11:36:02 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::a6) by DM6PR21CA0009.outlook.office365.com
 (2603:10b6:5:174::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.3 via Frontend
 Transport; Mon, 15 May 2023 11:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 11:36:02 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 06:35:59 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>, <nchatrad@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 2/5] x86/MCE/AMD, EDAC/mce_amd: Decode UMC_V2 ECC errors
Date:   Mon, 15 May 2023 11:35:34 +0000
Message-ID: <20230515113537.1052146-3-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515113537.1052146-1-muralimk@amd.com>
References: <20230515113537.1052146-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f0b32f-dcea-4dd1-4a88-08db55388fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9SO781xg+iISbAMAbV1PjUCO1Q/cy9Nt9W5aodseYC2+E43x6+fQKtdP+i55tWl17UbJNoeKE5WXE4r7fuCTBTc7NGPqIoxjYW26cqTQR/MagIAot7eQPBuY0sHG03IRG8RP8R5VOsdAV/bi/Llt6I/DkIEtC0DxLllM50CXKSJAstxDAwn9kOaIRcA6o502x49VOdenGJKqCD1L+/SKnGZYtFxnKg7cX0+CPaBpLUdv5XcuqqcoC66gdpSp4c2OO6wuDia+HKpgrfGibL3g1J722U8RQmvO7Fv+si1RtigNCreFfuescNFtH26DdtFgOSNgIeet7/N4jo79+74jN2NSdB0AVAjE1zVhWwqLkF+z8Y8lJmztTX9sbhl+vwfGbGLjrn1gUl3oQED42uQ+y59SELGHKrdiAps409l7SkvCvUfD2NKilwHdyDqdNY/WtPYNfqinxTY+rhT4ZHAAMFqEFAsAd9UsSvjixftDNRkrd456doZ5x2cK/lRnoLgUGgUvfuBfefwWxmOtC8l5gPe17/3+Ey2l+CMfNKLAB1ys0025TdVZFvSkoeLQSybsbMTaGpicc9oN3QPdiNGtdSybRIOrQbn2AwLHotW1MYQs6Z3Hv28yPYmWeNoYYPpv3/do1TD1MQEhA/tuylnmbO93Uu3lWKqjm3araGZLAInEHAxEIz4NaL6wMy2N/KiArAJnHOoB7OEDLesXRo529+RfqECcBohnBTEPePR3OLnXBpEaunr+xs0r5GfMFmxS6YImlE/dLcQ43A0LBjc6jQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(54906003)(110136005)(316002)(4326008)(70206006)(70586007)(478600001)(7696005)(82310400005)(40480700001)(5660300002)(8676002)(8936002)(6666004)(2906002)(81166007)(356005)(82740400003)(41300700001)(16526019)(2616005)(1076003)(186003)(26005)(336012)(36860700001)(83380400001)(426003)(47076005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 11:36:02.2384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f0b32f-dcea-4dd1-4a88-08db55388fdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The MI200 (Aldebaran) series of devices introduced a new SMCA bank type
for Unified Memory Controllers. The MCE subsystem already has support
for this new type. The MCE decoder module will decode the common MCA
error information for the new bank type, but it will not pass the
information to the AMD64 EDAC module for detailed memory error decoding.

Have the MCE decoder module recognize the new bank type as an SMCA UMC
memory error and pass the MCA information to AMD64 EDAC.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Co-developed-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 6 ++++--
 drivers/edac/mce_amd.c        | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 0b971f974096..5e74610b39e7 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -715,11 +715,13 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 
 bool amd_mce_is_memory_error(struct mce *m)
 {
+	enum smca_bank_types bank_type;
 	/* ErrCodeExt[20:16] */
 	u8 xec = (m->status >> 16) & 0x1f;
 
+	bank_type = smca_get_bank_type(m->extcpu, m->bank);
 	if (mce_flags.smca)
-		return smca_get_bank_type(m->extcpu, m->bank) == SMCA_UMC && xec == 0x0;
+		return (bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) && xec == 0x0;
 
 	return m->bank == 4 && xec == 0x8;
 }
@@ -1050,7 +1052,7 @@ static const char *get_name(unsigned int cpu, unsigned int bank, struct threshol
 	if (bank_type >= N_SMCA_BANK_TYPES)
 		return NULL;
 
-	if (b && bank_type == SMCA_UMC) {
+	if (b && (bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2)) {
 		if (b->block < ARRAY_SIZE(smca_umc_block_names))
 			return smca_umc_block_names[b->block];
 		return NULL;
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index cc5c63feb26a..9215c06783df 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1186,7 +1186,8 @@ static void decode_smca_error(struct mce *m)
 	if (xec < smca_mce_descs[bank_type].num_descs)
 		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
 
-	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
+	if ((bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) &&
+	    xec == 0 && decode_dram_ecc)
 		decode_dram_ecc(topology_die_id(m->extcpu), m);
 }
 
-- 
2.25.1

