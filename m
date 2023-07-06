Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679CA74A2EE
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jul 2023 19:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjGFRO1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jul 2023 13:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjGFROZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jul 2023 13:14:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9536B1FF5;
        Thu,  6 Jul 2023 10:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eyk6uU/bzkrqlMDJv4TSJ/Pn7tcH7m56XVDdEkwl+2LRGoZrYsktj9HP5JUHcEow5DT4aWDjWwsoMPsOSdUgTGiczBqJ/vdCG+OpDimy3/KCEVLFo+/DHo9F4sHNu7hRS00w7VY+Kqi6G600YhmT4yjpmeeKJtefGc31ia82kpUIkcg56/5fpq6qjEsMjlqGRWynmjIV4fbzCdk/N/3pmHL0Anatik+jnk5v9CrALdn50YZk3/eItHRkzDflxlYJD+9Q/7/6XBY4yf25ZmPLLNJ2+TRxc/rETYNqjssq+8mfWO/6/uyy5ws+E+Nbho2+BuboXu+7IlURWLXYCmTdfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI33U8UPa/z717YTkblxNZ6VCf/mgkOtNULadtG5VYc=;
 b=inmUGP2+KZJQxiBDI3cqcYnnxFP1DLHeSz3hJk7aEdGBB3r7cPFAmY+PwUqiAN5Vlgr1sly7r4B5F1BBoepKSdHRGmpPuZB+wwif6/vRZeuo9KAeZquW7FLEYz6Fx08S4HO8Spr/ThDjyD+KVRVfgmfC/m9NqYls2RA/Vtfu9aPoLfOtjuE1LaMOoPUB2v7tN1Rv/zOteacMJPPdv+WGt7AnyI1lcd3zBDsZDSv0iVMtQ7X+VLx9ny9iiScClnG1ouZOVOvVSF5VRtdTPyhri30CiipQqmbJImJvEg9s/br0Hxh6v60Nc/AgkoJ4v8G5S8rL1MYUieJE0s2fOdI2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI33U8UPa/z717YTkblxNZ6VCf/mgkOtNULadtG5VYc=;
 b=xE+6cPCiOTG483QQ5NON4DPWBF4fKg6uL1K7mWJI38lZp+PP/vyKLhrHmRgaYx/rVWnDMfUcKwUP7RzKt04WiW2g7WfTHn36+y9xCwOAW6lReKR0I9L5kwvSTGnnKyQecAHehVLSopcCAR5JWFY4Qn3gEEGfzL4iCEvWqvh9m7g=
Received: from MW4PR03CA0024.namprd03.prod.outlook.com (2603:10b6:303:8f::29)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Thu, 6 Jul
 2023 17:14:12 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::7) by MW4PR03CA0024.outlook.office365.com
 (2603:10b6:303:8f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 17:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 17:14:11 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 12:14:07 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <bp@alien8.de>, <linux@roeck-us.net>, <x86@kernel.org>,
        <linux-hwmon@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mario.limonciello@amd.com>,
        <yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v1 3/3] EDAC/amd64: Add support for AMD Family 1Ah Models 00h-1Fh and 40h-4Fh
Date:   Thu, 6 Jul 2023 17:13:23 +0000
Message-ID: <20230706171323.3722900-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706171323.3722900-1-avadhut.naik@amd.com>
References: <20230706171323.3722900-1-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT021:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1a821f-87b2-4000-14c4-08db7e446ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdNbGywjka7fDY+BiWr5AC2Ko+n4RCEJqRGjHZ8rW7H4xoYlL34xJrFBh0vwpPkDKYcolhfZICwYp8xFa6ix/8wIKbWG54j0+wjzZ5CSKLpK2VjzVd1ptOfOdcNAN1Ag0wBMw4mG+Q7V+LfG7k7SyiZsPveXGAVZ3d9W3I6ch9lqLekUui/WvL/BQf44yyTMLJe4Lfan1yfiNpeiXvfs2yVQNrCSWYGszvDPHHRaOw8rsDSwIqcDGMh7xPjoBTEAueBwZJ5DZvcouwfMpfigx1g5CtPdQmmhiR9fXdpiKDQ+2DKRcigv9I/BrhIsvC2V5mo1rrO1daWhmY0A4pSTEQ9AySmCARP8adaXH67oNEd7xM9f1KbueoFHtCanpfjqoxVs0d4nWMxJGCaUe5npbW2t26YkfzDM3wGiSIuatXJp+1X6x8WV2wjJ2k29wW1kB7VaW4eBOYPH8GNcQGmBu3JIRsRdpFzRUzFayfgIzrilxsD7XEIQZE2uvAbWfTSeZt/dD1liqURNV1Nt0oxlQl7fZ/UzbgocjglQp4yXDjjpm5yMyy0BWTxwiuCTwdmH+IwBSU7xiCbb0nI2LHkUaZl3kmRceAoGDxoaedHpGmzZ1xvqeqRl1VeuuCknRvEkR4EEHnxqoD7abAG8N9P56oU3fJtugpA35rM+d3IBNUY/Ie0F1kGwZ0KOFx5yUF9me0Jg6gKV8Dcuc83ybfOR58kbtOksU2livM9tgMKrtXiBxWmMSVn1gfOcbVinSHb48KMGwHS2NZahQTtER5IRsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(4326008)(81166007)(478600001)(316002)(36756003)(47076005)(40480700001)(110136005)(54906003)(40460700003)(82740400003)(70586007)(70206006)(356005)(36860700001)(2616005)(336012)(426003)(6666004)(8676002)(8936002)(16526019)(186003)(86362001)(26005)(44832011)(1076003)(5660300002)(7696005)(2906002)(82310400005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 17:14:11.5827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1a821f-87b2-4000-14c4-08db7e446ac5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Avadhut Naik <Avadhut.Naik@amd.com>

Add the necessary support in the module for AMD's new Family 1Ah-based
models 00h-1Fh and 40h-4Fh.

Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
---
 drivers/edac/amd64_edac.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 597dae7692b1..e3b59c488ed1 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4150,6 +4150,20 @@ static int per_family_init(struct amd64_pvt *pvt)
 		}
 		break;
 
+	case 0x1A:
+		switch (pvt->model) {
+		case 0x00 ... 0x1f:
+			pvt->ctl_name           = "F1Ah";
+			pvt->max_mcs            = 12;
+			pvt->flags.zn_regs_v2   = 1;
+			break;
+		case 0x40 ... 0x4f:
+			pvt->ctl_name           = "F1Ah_M40h";
+			pvt->flags.zn_regs_v2   = 1;
+			break;
+		}
+		break;
+
 	default:
 		amd64_err("Unsupported family!\n");
 		return -ENODEV;
@@ -4344,6 +4358,7 @@ static const struct x86_cpu_id amd64_cpuids[] = {
 	X86_MATCH_VENDOR_FAM(AMD,	0x17, NULL),
 	X86_MATCH_VENDOR_FAM(HYGON,	0x18, NULL),
 	X86_MATCH_VENDOR_FAM(AMD,	0x19, NULL),
+	X86_MATCH_VENDOR_FAM(AMD,   0x1A, NULL),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, amd64_cpuids);
-- 
2.34.1

