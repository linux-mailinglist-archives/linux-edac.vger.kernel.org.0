Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22CC7136521
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2020 02:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgAJB5K (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jan 2020 20:57:10 -0500
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com ([40.107.243.62]:6198
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730604AbgAJB5J (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 Jan 2020 20:57:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0tMzRho8NBaFKFUGye9IiDtVVWo81djL4hVOAq6NfkeZnvIcsCRM7Z9NQWZdk05iwb++3mC3S/EkVVLex892skSWNERxMpq80VTvj9osT5nR5yeQABQnTqPTrG1BLk/RO13rsPmgrO6ejuhHHYueLWe/QYdnOw22nUMUynFY/53Uzw1fVXYgwheqqrTDvFg7RgBnE3sElaYJC6jXEQ3wE6jiksNlS5NtyXpC22YfLi4YC3DhFH5CvvR2utWbIDpaWOngfZ9ElRgizd/s0CWLXKZCUJlQU6adcL89kKwi0xnAqSOK4aEwLzJIzqpCTBT/Z2J3MFYOxzXhhCwXYslsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XWByoc/pPEyZrVa+QtxYjoyY9k4L7bQe6aMJwou4lQ=;
 b=HmfcfXJ4UrndKYv3xkPhxCJBf780+xYCvzFVA8hq9reLyLDk9ZaysU0Q3OG0vtScR9IuxkYcYfqQ2wNyTl39lghzT3gEz3nuFhuH2+JtyDI4EmJ+5hrbUswmLihw52jtBGBvvZoYKyUW1ONL/cmfe0ttqp4Km775eyFJ8g46PAMZy1uGyGQIBjKhdqoV07FctoUzfuAd8PaGZjLafeX/0q/DjD9fTijOLvSqn5soKPJtRhqUFfebYn8RK4WDM4bB7bEqBChOw3OpqXvZYUKo++k7Nt2kdCKAyYy0jjkCOx/dnZ2ZHd1LtBCrBEurH7Ag6fr52AkGdzHPTyIwYVDFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XWByoc/pPEyZrVa+QtxYjoyY9k4L7bQe6aMJwou4lQ=;
 b=ql3Rwssr6pQ1rMVxjbvqo4U4cq0Q1xFBamAV1wB7FwYPTDBub7zq+StZC23N4KC0E03a12/Pybt1vesebn3mvA4IJZjLTCLzuiSfmv58YLOLtZNyLyBAdvpBXWD3lSetztU1JVNDmkoJrL6ShVIzvL1RxLyvOPkMa1p/+3UIlOA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
Received: from BN6PR12MB1667.namprd12.prod.outlook.com (10.172.18.18) by
 BN6PR12MB1378.namprd12.prod.outlook.com (10.168.228.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Fri, 10 Jan 2020 01:57:05 +0000
Received: from BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe]) by BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe%12]) with mapi id 15.20.2602.017; Fri, 10 Jan 2020
 01:57:05 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        x86@kernel.org
Subject: [PATCH 1/5] x86/MCE/AMD, EDAC/mce_amd: Add new Load Store unit McaType
Date:   Fri, 10 Jan 2020 01:56:47 +0000
Message-Id: <20200110015651.14887-2-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110015651.14887-1-Yazen.Ghannam@amd.com>
References: <20200110015651.14887-1-Yazen.Ghannam@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:805:66::49) To BN6PR12MB1667.namprd12.prod.outlook.com
 (2603:10b6:405:4::18)
MIME-Version: 1.0
Received: from ethanolx80b6host.amd.com (165.204.78.1) by SN6PR08CA0036.namprd08.prod.outlook.com (2603:10b6:805:66::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.12 via Frontend Transport; Fri, 10 Jan 2020 01:57:04 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d3c103c5-eb9a-499c-372e-08d795706457
X-MS-TrafficTypeDiagnostic: BN6PR12MB1378:|BN6PR12MB1378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1378F02A351146589B78E6A4F8380@BN6PR12MB1378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(189003)(199004)(66556008)(2616005)(6916009)(5660300002)(8676002)(86362001)(66946007)(956004)(36756003)(4326008)(1076003)(81166006)(478600001)(26005)(316002)(186003)(8936002)(66476007)(52116002)(16526019)(2906002)(7696005)(6486002)(81156014)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1378;H:BN6PR12MB1667.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qisul9dwzGV+H4S5lG1lG3ciHmnmoVDJZr5hXQHPlYj1TLAxuj8bo3QjqsPucgHUIecFGHfGtt5CEjjEnn6WujAHma8KcgkMXTf2d/Nq82YMhJrG6ICgsCrYhrBOShFj9Ap6gjnq0KQ4Gj0XgfaFnKAFlhqv0c1+2n/eUzG8i1knTAMfuPCAPxwr+3bjTn0W/gnCMTwJysXNn7gu0A20C32OfWm9tKiIqmtMwmKqa2C1B5nmfFpGK1EZL/JtdMTDzpo+hlUEuQCCyIBklw93tgWYKFGMHPWMGaW4KpdGusJmeM2E4puQ/YZS2yZJkFMW2AfPuhNpp8jToPafBevZQNpKpOqRpDSomUxQP6BtYaUu5QrfgYCdoYcTELRi9w/O4YdJod4eRpxd7sN0IkNNI+r1/HZKTAAxqsn6u32t06LbH8P1vsqKUgK/YSGsUcY1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c103c5-eb9a-499c-372e-08d795706457
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 01:57:05.1026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAW696sYjSZMOA6NxcSg/uXB2jzEjFb2kvL7ahouSV+ozRpDIkItxjdu8E/binZXqyekK11x/W0zL/ZPxCYw7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1378
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Future SMCA systems may see a new version of the Load Store unit bank
type as indicated by its McaType value.

Add the new (HWID, MCATYPE) tuple. Reuse the same name, since this is
logically the same to the user.

Also, add the new error descriptions to edac_mce_amd.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    |  1 +
 arch/x86/kernel/cpu/mce/amd.c |  2 ++
 drivers/edac/mce_amd.c        | 28 ++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index dc2d4b206ab7..0f84c20c5429 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -290,6 +290,7 @@ extern void apei_mce_report_mem_error(int corrected,
 /* These may be used by multiple smca_hwid_mcatypes */
 enum smca_bank_types {
 	SMCA_LS = 0,	/* Load Store */
+	SMCA_LS_V2,	/* Load Store */
 	SMCA_IF,	/* Instruction Fetch */
 	SMCA_L2_CACHE,	/* L2 Cache */
 	SMCA_DE,	/* Decoder Unit */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d6cf5c18a7e0..b3a50d962851 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -78,6 +78,7 @@ struct smca_bank_name {
 
 static struct smca_bank_name smca_names[] = {
 	[SMCA_LS]	= { "load_store",	"Load Store Unit" },
+	[SMCA_LS_V2]	= { "load_store",	"Load Store Unit" },
 	[SMCA_IF]	= { "insn_fetch",	"Instruction Fetch Unit" },
 	[SMCA_L2_CACHE]	= { "l2_cache",		"L2 Cache" },
 	[SMCA_DE]	= { "decode_unit",	"Decode Unit" },
@@ -138,6 +139,7 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 
 	/* ZN Core (HWID=0xB0) MCA types */
 	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0), 0x1FFFFF },
+	{ SMCA_LS_V2,	 HWID_MCATYPE(0xB0, 0x10), 0xFFFFFF },
 	{ SMCA_IF,	 HWID_MCATYPE(0xB0, 0x1), 0x3FFF },
 	{ SMCA_L2_CACHE, HWID_MCATYPE(0xB0, 0x2), 0xF },
 	{ SMCA_DE,	 HWID_MCATYPE(0xB0, 0x3), 0x1FF },
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index ea622c6f3a39..aa6ea53f7d14 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -175,6 +175,33 @@ static const char * const smca_ls_mce_desc[] = {
 	"L2 Fill Data error",
 };
 
+static const char * const smca_ls2_mce_desc[] = {
+	"An ECC error was detected on a data cache read by a probe or victimization",
+	"An ECC error or L2 poison was detected on a data cache read by a load",
+	"An ECC error was detected on a data cache read-modify-write by a store",
+	"An ECC error or poison bit mismatch was detected on a tag read by a probe or victimization",
+	"An ECC error or poison bit mismatch was detected on a tag read by a load",
+	"An ECC error or poison bit mismatch was detected on a tag read by a store",
+	"An ECC error was detected on an EMEM read by a load",
+	"An ECC error was detected on an EMEM read-modify-write by a store",
+	"A parity error was detected in an L1 TLB entry by any access",
+	"A parity error was detected in an L2 TLB entry by any access",
+	"A parity error was detected in a PWC entry by any access",
+	"A parity error was detected in an STQ entry by any access",
+	"A parity error was detected in an LDQ entry by any access",
+	"A parity error was detected in a MAB entry by any access",
+	"A parity error was detected in an SCB entry state field by any access",
+	"A parity error was detected in an SCB entry address field by any access",
+	"A parity error was detected in an SCB entry data field by any access",
+	"A parity error was detected in a WCB entry by any access",
+	"A poisoned line was detected in an SCB entry by any access",
+	"A SystemReadDataError error was reported on read data returned from L2 for a load",
+	"A SystemReadDataError error was reported on read data returned from L2 for an SCB store",
+	"A SystemReadDataError error was reported on read data returned from L2 for a WCB store",
+	"A hardware assertion error was reported",
+	"A parity error was detected in an STLF, SCB EMEM entry or SRB store data by any access",
+};
+
 static const char * const smca_if_mce_desc[] = {
 	"Op Cache Microtag Probe Port Parity Error",
 	"IC Microtag or Full Tag Multi-hit Error",
@@ -378,6 +405,7 @@ struct smca_mce_desc {
 
 static struct smca_mce_desc smca_mce_descs[] = {
 	[SMCA_LS]	= { smca_ls_mce_desc,	ARRAY_SIZE(smca_ls_mce_desc)	},
+	[SMCA_LS_V2]	= { smca_ls2_mce_desc,	ARRAY_SIZE(smca_ls2_mce_desc)	},
 	[SMCA_IF]	= { smca_if_mce_desc,	ARRAY_SIZE(smca_if_mce_desc)	},
 	[SMCA_L2_CACHE]	= { smca_l2_mce_desc,	ARRAY_SIZE(smca_l2_mce_desc)	},
 	[SMCA_DE]	= { smca_de_mce_desc,	ARRAY_SIZE(smca_de_mce_desc)	},
-- 
2.17.1

