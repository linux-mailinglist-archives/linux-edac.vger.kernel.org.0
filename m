Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E7313651D
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2020 02:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbgAJB5Q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jan 2020 20:57:16 -0500
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com ([40.107.243.62]:6198
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730753AbgAJB5N (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 Jan 2020 20:57:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1Ubj/0BQsYZUV9wK055gwS5Scr4r0t/iC5dJHvnWTAQe+kmYSBgQwRGziJQBMUwXPFSqf+RF62czaDkVW1WAkswUoaUHzKK/3HqSF6qwxI8GdWD2Gs92r7g40LE7INOgpQJumOsrcjHJNlZAX+3j9BJ6fL27bFUjZkpW6JP3GwzO1hZour72aFYvHmPCE9odMTNnnOrH3bWyCqLZeoDm+lVXgN4VaUMY5WbpB+K+Mbh6jawhYUrAJut2InHeu9NZfe31H2KIwKP/JWTzfCHg0jRAtI88MKJt1eWvdX5W7xGmAj4M+z6YRAhoLzSQf/PDF8Ftwv+vF2gGcQrWPL3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrHvHsssIXykmfWcnm9rjiu0DpdwjrnbKsU3ThyPYpA=;
 b=jc+s7l1NBkE8bY6Oi+b3ajtV4TKGlL1wb0Plxb/HYMZAzCFOETjEFoCC14cAd1Vc5FElBZyQ470hyCSGzAzoCUlD6BQhxvVniC+DR4ukWfSJKiUtvGAdRDM3DiorbgzSEe6NZqVJ0bBTdJrDxr7pN6E4WsyXx/A6Pa4JB6nq81puQR2bYzibGvXt3z+fh0IjuRIOBAzRlrp1NP2+0rong5wYIq/6UFh6vudumqXXebP9YHTMS0f4pUr5Zd5LUdv1isYPHEWw6qnwiWbwH0T1kwX0fDLqvtu2g+EMz7f9krHfhPdZ7lxh1t7D6YGr4sSlObdNXL+yoEH10l1rbuzoqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrHvHsssIXykmfWcnm9rjiu0DpdwjrnbKsU3ThyPYpA=;
 b=Y4b0HtrA0e46y2g2gzpXoASYL/FIkf5pWlh5xHM1pvDuKXEJADEojQ+twHCNEX9mR/xzWZ1OeeHpoehEPqHDO2f39ihh6jiQvWEbNN6GCWOlQsp7EhEjj85ID5xUhWO3QPrVZ4boGn4Cj38G2Q1TCmBRvF46bUTIGU3u3CIRouU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
Received: from BN6PR12MB1667.namprd12.prod.outlook.com (10.172.18.18) by
 BN6PR12MB1378.namprd12.prod.outlook.com (10.168.228.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Fri, 10 Jan 2020 01:57:08 +0000
Received: from BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe]) by BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe%12]) with mapi id 15.20.2602.017; Fri, 10 Jan 2020
 01:57:08 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        x86@kernel.org
Subject: [PATCH 5/5] EDAC/amd64: Drop some family checks for newer systems
Date:   Fri, 10 Jan 2020 01:56:51 +0000
Message-Id: <20200110015651.14887-6-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110015651.14887-1-Yazen.Ghannam@amd.com>
References: <20200110015651.14887-1-Yazen.Ghannam@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:805:66::49) To BN6PR12MB1667.namprd12.prod.outlook.com
 (2603:10b6:405:4::18)
MIME-Version: 1.0
Received: from ethanolx80b6host.amd.com (165.204.78.1) by SN6PR08CA0036.namprd08.prod.outlook.com (2603:10b6:805:66::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.12 via Frontend Transport; Fri, 10 Jan 2020 01:57:07 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bb66563d-a833-4b01-e2a2-08d795706663
X-MS-TrafficTypeDiagnostic: BN6PR12MB1378:|BN6PR12MB1378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB137866D919658A5DBE92E430F8380@BN6PR12MB1378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(189003)(199004)(66556008)(2616005)(6916009)(5660300002)(8676002)(86362001)(66946007)(956004)(36756003)(4326008)(1076003)(81166006)(478600001)(26005)(316002)(186003)(8936002)(66476007)(52116002)(16526019)(2906002)(7696005)(6486002)(81156014)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1378;H:BN6PR12MB1667.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5YijJ0PymsxPVbXCXtORA3IbosJaIqKQAm5h5iVOWPwdpmHRQLsx1cp90UH4oayun1RPn1lAWI931Y2vONWNCMaWiQPQAWEmHbOwwvCS5FoeOlGidn0duYUK7SIPGQvGJ9Va0VGZKBgIOj+/sE1/StxibVh7E5QywZjMMPJJ1d36+Wha+Fg1MQsOJQ9FIwmO+BkAqbxBRusZ4oem1Hu78On/oiSqtkJ98d7gVDfTFmvGv9ufznU/aAFwmTVCsAEMEZSo0QwkPZndJ0FQGZuvmDpxi6n0HaagQ6G2+sq2S4ypLFZ5U+j0WlUxExS2c3aMJk0mVQUbfM0cYjRc7ILYm+yttxGm8SAZM9LzRu3ySPkzrmurbvQZngXLSZujg4K6tkyFzApG38mHQd9fp4WoGFC+GWpqe6accM7BLc/5YIzwfe3nbQrrnemcmsgu+BBs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb66563d-a833-4b01-e2a2-08d795706663
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 01:57:08.5141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RU6Wv9eT5CMtkWVP7dwbWAxRc80/KQJu6el0VwbQ+Iwsv+mk5MgpC2CNeiyYE9l66T28txBIqZ4QjWoOuGpBrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1378
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

In general, "pvt->umc != NULL" is used to check if the system is Family
17h+. However, there are a few places that are using direct family
checks.

Replace the remaining family checks with a check for "pvt->umc != NULL".

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 45 +++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2488cbf76814..4fc9f0b06ed7 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -214,7 +214,7 @@ static int __set_scrub_rate(struct amd64_pvt *pvt, u32 new_bw, u32 min_rate)
 
 	scrubval = scrubrates[i].scrubval;
 
-	if (pvt->fam == 0x17 || pvt->fam == 0x18) {
+	if (pvt->umc) {
 		__f17h_set_scrubval(pvt, scrubval);
 	} else if (pvt->fam == 0x15 && pvt->model == 0x60) {
 		f15h_select_dct(pvt, 0);
@@ -256,18 +256,7 @@ static int get_scrub_rate(struct mem_ctl_info *mci)
 	int i, retval = -EINVAL;
 	u32 scrubval = 0;
 
-	switch (pvt->fam) {
-	case 0x15:
-		/* Erratum #505 */
-		if (pvt->model < 0x10)
-			f15h_select_dct(pvt, 0);
-
-		if (pvt->model == 0x60)
-			amd64_read_pci_cfg(pvt->F2, F15H_M60H_SCRCTRL, &scrubval);
-		break;
-
-	case 0x17:
-	case 0x18:
+	if (pvt->umc) {
 		amd64_read_pci_cfg(pvt->F6, F17H_SCR_BASE_ADDR, &scrubval);
 		if (scrubval & BIT(0)) {
 			amd64_read_pci_cfg(pvt->F6, F17H_SCR_LIMIT_ADDR, &scrubval);
@@ -276,11 +265,15 @@ static int get_scrub_rate(struct mem_ctl_info *mci)
 		} else {
 			scrubval = 0;
 		}
-		break;
+	} else if (pvt->fam == 0x15) {
+		/* Erratum #505 */
+		if (pvt->model < 0x10)
+			f15h_select_dct(pvt, 0);
 
-	default:
+		if (pvt->model == 0x60)
+			amd64_read_pci_cfg(pvt->F2, F15H_M60H_SCRCTRL, &scrubval);
+	} else {
 		amd64_read_pci_cfg(pvt->F3, SCRCTRL, &scrubval);
-		break;
 	}
 
 	scrubval = scrubval & 0x001F;
@@ -1055,6 +1048,16 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 {
 	u32 dram_ctrl, dcsm;
 
+	if (pvt->umc) {
+		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
+			pvt->dram_type = MEM_LRDDR4;
+		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
+			pvt->dram_type = MEM_RDDR4;
+		else
+			pvt->dram_type = MEM_DDR4;
+		return;
+	}
+
 	switch (pvt->fam) {
 	case 0xf:
 		if (pvt->ext_model >= K8_REV_F)
@@ -1100,16 +1103,6 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 	case 0x16:
 		goto ddr3;
 
-	case 0x17:
-	case 0x18:
-		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
-			pvt->dram_type = MEM_LRDDR4;
-		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
-			pvt->dram_type = MEM_RDDR4;
-		else
-			pvt->dram_type = MEM_DDR4;
-		return;
-
 	default:
 		WARN(1, KERN_ERR "%s: Family??? 0x%x\n", __func__, pvt->fam);
 		pvt->dram_type = MEM_EMPTY;
-- 
2.17.1

