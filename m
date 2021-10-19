Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0611434229
	for <lists+linux-edac@lfdr.de>; Wed, 20 Oct 2021 01:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJSXj3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Oct 2021 19:39:29 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:63072
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229987AbhJSXj1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 Oct 2021 19:39:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0e1UkiA5fmc4N1Vvr+Ia5f+uVi19AYglR03LrlxgkRuoR2OyEsAp99PcPNbLFb0hF2p28NlPuHy3zqMvje56FV8a9N5D2l3kORFzADBWgmo1pbe8iNmWn7Jw1fhLb4SLM0IxCaAni1Gl+pbVWGRua9WbkzyD/3kuEWQlk8samgfp8ByxMpMEPCuerdUQ/q7FhsTMBXmv1naEXi5q+d2TAWIWdKP7TXuv9bOGKFgyYZXRdTvvj/7wmJq1JmfqrkKeAVoOYH55zohSFvmenyfHs6/gtkYpuzlCuAJJ/0DzlSkghS4lc2CZ4kXLiMCy8oIEWSYPX+02Nn3GP9KXWSqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=573rEltmh+XVPiNULiPpaeAm3mWPH5l8jGUtKzx4bLg=;
 b=Gw7vk3CrBP+hee9AEDlZ+NQTvwL+nxmxu0a6fyDXXEHajLkW7IDjbMZK8ZwGrAK6NT72se3YzKt4o34rfPm+BqoU/HFG74eTuiMtZLVjw/l0DT6J1latzeg0AGbm3KGapg5J1ijGJT0l9AL7zul6Y4YLdT11P0Ui5PVyHSe+gSSoccnIe6+l9uEdJd2OgKwBq6da5J83tCFzUZJSbff3j/bOZOeI4Khj3ZxcVvG6WTmunAnSPdKS1nP9UFlnZwVozkh7dGEOEZ2WatWgr6+05LyVuXkzhUmQdEVkIOfoqqwy7F7LS3V5vYctvMgsmT0TJoLWWeSmezODUsbFgUleig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=573rEltmh+XVPiNULiPpaeAm3mWPH5l8jGUtKzx4bLg=;
 b=mhjU6YivkMGUBYLnDQ99LNMmCOe66WLamDWotiikxH4cSAHZCfeIHIQ3DcvGjpRN3NeKRqaSoz+dNNNHZ3BPxZmAnsDU7sEFudwLzm7SwuZXPdAO8piGYyW5OiLswT9zpvovx2g8DAT+sgzs6V7/AUg4sEn8Jv0hSWZHrN+9LtU=
Received: from DM5PR16CA0012.namprd16.prod.outlook.com (2603:10b6:3:c0::22) by
 MN2PR12MB2928.namprd12.prod.outlook.com (2603:10b6:208:105::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 23:37:12 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::42) by DM5PR16CA0012.outlook.office365.com
 (2603:10b6:3:c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 23:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 23:37:12 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 18:37:10 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        <yazen.ghannam@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 5/5] x86/mce/mce-inject: Return error code to userspace from mce-inject module
Date:   Tue, 19 Oct 2021 18:36:41 -0500
Message-ID: <20211019233641.140275-6-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2546310-daf5-4c13-6fdd-08d99359600d
X-MS-TrafficTypeDiagnostic: MN2PR12MB2928:
X-Microsoft-Antispam-PRVS: <MN2PR12MB29288F609C504C0ECA53C63B90BD9@MN2PR12MB2928.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTArHuiI0X6kSfPqaN9IebuAI6zIJRM+tFtf7YkcaCcmxX0UZwmeUh7ApOluWk663WWNOKmTP3PxH/+NjtK/tLtS2X/UUEXIWImxEqzCaRQbXKYIZXmu0fPaY6lslxtho+QTjwsIguvItQGrFwHP6bzfROEhP+W/S4qdm+kO/TY6cYL5hMmkrOdLx6vafWjB2uGDtNy4L/UE3sMSWk2FfL9VJQaixztqRlzA6oEj8ShAbH4S7TWgI0as19a/RDNCzz647QbE6t3zIqFgifQPAdh1FKLclR/CONgLzaiDDkBCSMAWL9G5JQH7aQDKxe2T/UI8TUzmCg1cZQRHY5RfIdZOWix6Qqlrz+LPb37GhlZHOXSmVWhcP0cxPdPvme999Ei7/C/N+wSpV3hViCiKQ01MZRIYmo1OR9FcTnJTNDCfWkWBeF2k8CS9d7HdM1o1fKwGvw+ZuzCRbr9OUAnQR64rFefW7DY8C/eOpECy2FtQ1E9L1Oap8f0lz6uzgnqTHWmGt8FhRa2KQy8nDktMyk75ScfeWKEWJmJ1kqRp9lswL1r6geQ70BQb/7qpJAA/wSyShmFH0OxYp02G/DEp0p0JMXIwfHGn1tencLMLJqslN8SPCKoddnm3SgMEKzGAB/e0vM5dgL3+PlvcWPnLNFpKdfW4gY2/dfBu/bSRQbiX+Wk01MQn5VLlevsZ6tzKh3CGkMGoqMlxqxIUtFru+P/kJFaY/1ORfm7uORmMXsQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36756003)(316002)(8936002)(2906002)(426003)(7696005)(5660300002)(1076003)(81166007)(47076005)(508600001)(70586007)(83380400001)(4326008)(2616005)(26005)(8676002)(86362001)(54906003)(110136005)(336012)(82310400003)(356005)(36860700001)(16526019)(70206006)(6666004)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 23:37:12.0722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2546310-daf5-4c13-6fdd-08d99359600d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2928
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Currently, the mce-inject module fails silently and user must look for
kernel logs to determine if the injection has succeeded.

Save time for the user and return error code from the module with
appropriate error statements if error injection fails.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	Added pr_err() along with error code.
---
 arch/x86/kernel/cpu/mce/inject.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 72d29d26e033..a1c3c1e0425f 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -547,8 +547,11 @@ static void do_inject(void)
 	}
 
 	cpus_read_lock();
-	if (!cpu_online(cpu))
+	if (!cpu_online(cpu)) {
+		pr_err("No online CPUs available for error injection\n");
+		mce_err.err = -ENODEV;
 		goto err;
+	}
 
 	toggle_hw_mce_inject(cpu, true);
 
@@ -621,7 +624,7 @@ static int inj_bank_set(void *data, u64 val)
 	/* Reset injection struct */
 	setup_inj_struct(&i_mce);
 
-	return 0;
+	return mce_err.err;
 }
 
 MCE_INJECT_GET(bank);
-- 
2.17.1

