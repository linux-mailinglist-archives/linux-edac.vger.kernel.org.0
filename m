Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 451A7136523
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2020 02:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbgAJB5L (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jan 2020 20:57:11 -0500
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com ([40.107.243.62]:6198
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730359AbgAJB5K (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 Jan 2020 20:57:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uu0MCNLjKPnk9yaIVtdSMEWJ1ilK3mWlXxgsvaT7I/zxivP4dWEBtS+ZYrzv8EDp2LYamLL8ZgfFb5va0HI4G4FTWI4uWbu84b5oSfqJdT4KvRiUeJDMfkpaG19/7YhyV14KR18ESUYOzB+m/P87x8OtmlA+I1GvTKRtNe1dWHz2400ieG2yx2wMG58dmU543RdTeVHoADrtc9cPl6Sw2NqFVPugjuecsIgwVGFmIeHofm0pqZU7VfHBGhz9Z7NVnEWdCsOVz+wD58+nJHQZV+o73ts+QpYtFsiS+p8UneRbr10FWU7qCyJumSOgWo4Af4yOZ4wdwutZdpOJ4C7fJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWFO4DzIJUzRZzklO19ID7uWu2xiLjIiEAjBAt0+B1s=;
 b=iZXfRbFWQz5JTcRxQIL7OK8Fae27seih+aD641TAMRsROwycP5Rz59tryPYmMMdUnGTyKf01x57pQgljwQoD7NQoDHvBFpAqfQCoagQ46Siy8b+wnOA40pDF3NEhWsXlBHQwBP9t1QP7NFoav7HXPMMCqTD+QpPRIyTFB3BRDum8OLJ/75BA5mUOkqzbdRrXnbdHTnDgd2Yg7gpS+Lc48veBobl9nAQuMN6Ip9bDQwpjnqL04ZsDjdDh0RzG3LXhCelH0WwOrwPhMs1qMseBCB+YbPF04NtdudHd6L6A5EaE4fIROlts2Y+EoNan+EtHl2ywQxk0Z9nNm/zfOh3dNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWFO4DzIJUzRZzklO19ID7uWu2xiLjIiEAjBAt0+B1s=;
 b=vcWZMkTBdz40+vP9ToFo6laDqU1cydQINaPabnkBCmz+4UykQgNGFSr0OLVnBNUjnj8NdKw7bTf+4naB5oCk0G694YMvIqE9iJ93KZ6ZK8TJ1DB8L5e2wFjqJwauFmCjGrLwfdgEbeReLZDawQ+EI6kFrKFA9VpomlNqy6bhYKE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
Received: from BN6PR12MB1667.namprd12.prod.outlook.com (10.172.18.18) by
 BN6PR12MB1378.namprd12.prod.outlook.com (10.168.228.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Fri, 10 Jan 2020 01:57:06 +0000
Received: from BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe]) by BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe%12]) with mapi id 15.20.2602.017; Fri, 10 Jan 2020
 01:57:06 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        x86@kernel.org
Subject: [PATCH 2/5] EDAC/mce_amd: Always load on SMCA systems
Date:   Fri, 10 Jan 2020 01:56:48 +0000
Message-Id: <20200110015651.14887-3-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110015651.14887-1-Yazen.Ghannam@amd.com>
References: <20200110015651.14887-1-Yazen.Ghannam@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:805:66::49) To BN6PR12MB1667.namprd12.prod.outlook.com
 (2603:10b6:405:4::18)
MIME-Version: 1.0
Received: from ethanolx80b6host.amd.com (165.204.78.1) by SN6PR08CA0036.namprd08.prod.outlook.com (2603:10b6:805:66::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.12 via Frontend Transport; Fri, 10 Jan 2020 01:57:05 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64b86fb8-88e9-4d2d-3afd-08d7957064da
X-MS-TrafficTypeDiagnostic: BN6PR12MB1378:|BN6PR12MB1378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB137817ED1D3C932A0B55334FF8380@BN6PR12MB1378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(189003)(199004)(66556008)(2616005)(6916009)(5660300002)(8676002)(86362001)(66946007)(956004)(36756003)(4326008)(1076003)(81166006)(478600001)(26005)(316002)(186003)(8936002)(66476007)(52116002)(16526019)(2906002)(7696005)(6486002)(81156014)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1378;H:BN6PR12MB1667.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tv8lJgEvVRjm8Qv+xVuR9iV0rugfzgQQOwxU9IPbn4zdhNRXLBgfSIT5EgCJ/hpx6h9U6TRydbtHtAca70DMXWnVwmfVP41aCEw+znkuUCrU0nv1SOm+WhUiw6ztZcuN5DWHDwlBSVGlJbOemNODHN2PJC9/LyyRd2hbZ1UsN3WFkERU9szXQ9EmSD4melChVPLBcyrfHRgv83+NxGnM7/4UUktFCOlEzDl2bKGyhIgYFaB127lKqCmYi/doPQXolpB5M1/TDn1gQByAKhP9aUAaOCy8WQI3Ve5szxjoOajz/FJ5umoAU7XNVElJ6/m/YB+VTPuVPtWTCpnZB12hbumqAYGpkRKm5dyTRVl2Or/zDvw4LYeIpn+7iuzs0ooYu3IpATd3LcMMz7IFtKQA/rcweMlVnNgehq0K/yXbpDbWbKm/rkIumwwPv8kJToB1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b86fb8-88e9-4d2d-3afd-08d7957064da
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 01:57:05.9502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNNHfISfe/zq+mLX0CSFZjUWhvfrst34HIjf9BhbEWs5u3z8rDv14RyfIRQglpwhL0K82LRzpo+gZe2Aoi+GYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1378
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

MCA error decoding on SMCA systems is not dependent on family.

Return success early if the system supports the SMCA feature.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/mce_amd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index aa6ea53f7d14..524c63fdad42 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1189,6 +1189,11 @@ static int __init mce_amd_init(void)
 	if (!fam_ops)
 		return -ENOMEM;
 
+	if (boot_cpu_has(X86_FEATURE_SMCA)) {
+		xec_mask = 0x3f;
+		goto out;
+	}
+
 	switch (c->x86) {
 	case 0xf:
 		fam_ops->mc0_mce = k8_mc0_mce;
@@ -1237,11 +1242,8 @@ static int __init mce_amd_init(void)
 
 	case 0x17:
 	case 0x18:
-		xec_mask = 0x3f;
-		if (!boot_cpu_has(X86_FEATURE_SMCA)) {
-			printk(KERN_WARNING "Decoding supported only on Scalable MCA processors.\n");
-			goto err_out;
-		}
+		pr_warn("Decoding supported only on Scalable MCA processors.\n");
+		goto err_out;
 		break;
 
 	default:
@@ -1249,6 +1251,7 @@ static int __init mce_amd_init(void)
 		goto err_out;
 	}
 
+out:
 	pr_info("MCE: In-kernel MCE decoding enabled.\n");
 
 	mce_register_decode_chain(&amd_mce_dec_nb);
-- 
2.17.1

