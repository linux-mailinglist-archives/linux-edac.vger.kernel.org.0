Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A1E46C3B0
	for <lists+linux-edac@lfdr.de>; Tue,  7 Dec 2021 20:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhLGTeZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Dec 2021 14:34:25 -0500
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com ([40.107.237.82]:53537
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231401AbhLGTeY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 7 Dec 2021 14:34:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzUoPrPeoqJDMtSmjYhI8yKjuYMcvNkdtRtY605tYAcccVicffs2Gl5r7fVcEnE5RXOmOR2Foulmmz43Yglh2mjOD1wEmNo9DzceeQ52Eua+XskY/ote8XAMV+4ZNGLAEnUHTiasGXv1JU4ckqk49RgbW7pkifgyv4ZC2D1kou6EogjDSYJ+B0TeE88n8pFZWUUUrE9LkipVHms2IRd6ppjmA8+JdOZK9pTAt/0zrjKB2kRtTHNUV6ML8wP7T37FfL5hkZH3EvsmUrp3BpTinzJ+JZ0rKevCEah974FWQ9E9nPwNDRWtSrCWy9hgqQwndJWnUvuUPjASy2CB4ab8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noW4VoAT82my1P0k5I6H3N3qozkL9+XT5ZYfvfb2gvM=;
 b=hv9wfS+dUg8EtDpwiaCUNfJ0iMCql8oUB1xLuH4xdZugRiv4OPLTSVeBevLZxJSEYkphPkye36YKDK3Oz2FFCZkIsB1pnOf1s2lMff4XXY51DtGfoBZOAju9gvzExOOTWumj9Pb7iEUNBc9Xn7X4ArILz2KiX5ax8+BDFj5f8GvV4AHIPeS5InUgna6GIH0MgJxz7wtMyKvpvFlxa3LvLkhRPjZQtQfrF1WPNaIXtbHMOStFdnnxmJy6pw/n9ZTmFopC4VyeOWunnoIU6/LbLqO53jbD2q2ESLwZ9XzjsmMY3gbKHnGhjJj+klMAPQc0l+0GnTXtso/XqzhwEsLQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noW4VoAT82my1P0k5I6H3N3qozkL9+XT5ZYfvfb2gvM=;
 b=jPNA0StHAr8VltKK+esbWU9Tf6GLrGx/phtzAfziNYVYI1I1BOGs3P0T4FVIWsUJx6kvhWgHz2iDEIozvoX7tdil44oEvM7a9Yx1TEHW2iypkteALcnKW6elndO8tf83/VMsuMvgjxQFQB6DOfRyDkvc+MX84SIxWGWoLk4aIqM=
Received: from MWHPR07CA0022.namprd07.prod.outlook.com (2603:10b6:300:116::32)
 by MWHPR12MB1455.namprd12.prod.outlook.com (2603:10b6:301:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Tue, 7 Dec
 2021 19:30:51 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::c9) by MWHPR07CA0022.outlook.office365.com
 (2603:10b6:300:116::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Tue, 7 Dec 2021 19:30:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 19:30:50 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 13:30:49 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] x86/MCE/AMD: Allow thresholding interface updates after init
Date:   Tue, 7 Dec 2021 19:30:28 +0000
Message-ID: <20211207193028.9389-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d67eb8eb-40d9-476c-8a6a-08d9b9b8140c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1455:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1455777C06E36F2A4A421D57F86E9@MWHPR12MB1455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UNO3EAEvjpZiaViVouSLazPHFXSR7k6Dz8kYnVTKccupGId+tYQyp8r4/ynUZ3TpVigl0Mp4OHWycfdRqJP+pnozOPPstcir0oVooc+Rgdnd/AzMcFiQCCbY0YzTE+5zdd+R7fGPxz2pwFJqZStO6Z41e5z1D/FBdFXRHagUjIBFDq64uzdAs1UwtKp5x09eKDw53er9tggYQ+LYiF3n5ya7CD8G5VET22Z8XKh03vKAWHT6O1xeAN2e4b3ZSGoX3huq5fTklstAJrephGiQM0vRLS2AqHhu8jIsnGOPr29WsneDYgzZc1ne5tYW7kYC6s/jXK6f4UnmzzGyrJF72z12vUlEcJKaN+XeoqTuOnIcfFDiOCq/LBJsoCVbzhNX+1E+MC06LSmVppobwzSp/m+wD1b2EetF0+TLM4g1lG8vg2PF8neN4aB3GD2U102mvFdxsaS6T+Pro6TwH2daxuwV9zBoCl6VlZEasALiEYJDofsomuGsrfRkC9M9PJTCTvTtGhymSpObfKR/kXzV8u/nq5bQVNILAopWszvc37EtrZLhsvKriXNoEdPytJB013DR0RPeFQZcoITthpRT4UUxqFpUEXefoBRG9faZMAjsF1aGnLcs/aRGMtEjLzUUtvNlcAEZEyTJk0bovZJ2bEaeXYsoe/2enx3R5DzPJk6Cb9IM+l53lCVyx5k+MSnDvDVCvH5BpZAEM8I+mu4DG9BK+vMYAxgKKRr8buyGBX4Pu3Axi6e3jzq/QaF79MYCqKucrxKZWmImL8O17NEzCX7juaV2VaMhlDPyu8f+kG8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(4326008)(508600001)(83380400001)(2906002)(356005)(81166007)(186003)(16526019)(426003)(316002)(7696005)(26005)(2616005)(44832011)(336012)(54906003)(82310400004)(40460700001)(15650500001)(6666004)(1076003)(47076005)(86362001)(36756003)(8936002)(5660300002)(8676002)(70206006)(6916009)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:30:50.9560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d67eb8eb-40d9-476c-8a6a-08d9b9b8140c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1455
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Changes to the AMD Thresholding sysfs code prevents sysfs writes from
updating the underlying registers once CPU init is completed, i.e.
"threshold_banks" is set.

Allow the registers to be updated if the thresholding interface is
already initialized or if in the init path. Use the "set_lvt_off" value
to indicate if running in the init path, since this value is only set
during init.

Fixes: a037f3ca0ea0 ("x86/mce/amd: Make threshold bank setting hotplug robust")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 2eadc7c4c902..408c9546ea0b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -400,8 +400,12 @@ static void threshold_restart_bank(void *_tr)
 	struct thresh_restart *tr = _tr;
 	u32 hi, lo;
 
-	/* sysfs write might race against an offline operation */
-	if (this_cpu_read(threshold_banks))
+	/*
+	 * sysfs write might race against an offline operation.
+	 * Prevent register writes if threshold_banks are not set and this is
+	 * not called from the init path as indicated by "set_lvt_off".
+	 */
+	if (!(this_cpu_read(threshold_banks) || tr->set_lvt_off))
 		return;
 
 	rdmsr(tr->b->address, lo, hi);
-- 
2.25.1

