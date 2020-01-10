Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39C8D13651B
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2020 02:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbgAJB5N (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jan 2020 20:57:13 -0500
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com ([40.107.243.62]:6198
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730743AbgAJB5M (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 Jan 2020 20:57:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hd2MxZAog37rcT/yuU2rACkmQWKVBJRRZf0aLn0tc0GGpTjvynXgCwzVBUic1csMHH5YAfEvd3/M1Gb9EYfRhQ9sBisk9mWo1qtSxEVBgA+3qAwVS1ZDhiJT9eZMvMt2TJIlgXu5OJ0c3DI4WEXeHU1bMQF0ZlrgphaeVds/vhM0h7DgYI9GChMvAxE2R9LMjgvnsC5k7zvFw6wMFjH2mcvk2+Crgz0ilJypLiEOiSzTcmWUOjcpv+VL0PDTTzkA84WFKR3ws2VMXKPAr8DzgqUnCdWFoRSDIODRA3JAzog250YY9vtjZepkdpF7Rfg48kYaSmpaDu/uUApPE0Tqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Plcx6nqLX7HuMFPuQZygL3agoNMGUUbSYhRStH8Lw0=;
 b=lros7VVh+/6KuAvUXoGG4uYKxhqTmHHPE+i1zCL07Bd/D2DOC5zuPmxiLC0N/FMNiF4B5wfkTdTtry05Frt5PL7FarHU8p5ojuGrALzXKl37P00sisgrVKlreMCPH66Uu3fgSbThtI6x2sz19wQnE0oqk0IptEEbDGkuDVjs1JXenrnNtwg3oquz1BlpczNIoo/Vp5I+8cEiZEaS2ETV2EtrYdDCP8gW6Po92Krgk/NQWe0PA1MzTdm/jsVIO464LGSO6GCoOIPY8GKeoFTtZt1VGrKX4bb4XjHFoqocfxlgwV1yIpzdBEI32NFzx5kScRfT4xOmbi5i4Qh9qxlrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Plcx6nqLX7HuMFPuQZygL3agoNMGUUbSYhRStH8Lw0=;
 b=3plsIiD/UoZAtTjcKqPfB+O/gVTI9HFC/UGuSLa0jrmAO6Jei+YvTsSQrskLWkWJiFx9KABxHqjx55WatY1R9sh4n3VlKMagc3pPulKTQEql6Ln+kQHN+dNw1lwQNTj9WIaI8z/Cgp6ATLhnXzVQYuQekCJ+yIZbJbzBNeu0bxg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
Received: from BN6PR12MB1667.namprd12.prod.outlook.com (10.172.18.18) by
 BN6PR12MB1378.namprd12.prod.outlook.com (10.168.228.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Fri, 10 Jan 2020 01:57:07 +0000
Received: from BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe]) by BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe%12]) with mapi id 15.20.2602.017; Fri, 10 Jan 2020
 01:57:07 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        x86@kernel.org
Subject: [PATCH 4/5] EDAC/amd64: Add family ops for Family 19h Models 00h-0Fh
Date:   Fri, 10 Jan 2020 01:56:50 +0000
Message-Id: <20200110015651.14887-5-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110015651.14887-1-Yazen.Ghannam@amd.com>
References: <20200110015651.14887-1-Yazen.Ghannam@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:805:66::49) To BN6PR12MB1667.namprd12.prod.outlook.com
 (2603:10b6:405:4::18)
MIME-Version: 1.0
Received: from ethanolx80b6host.amd.com (165.204.78.1) by SN6PR08CA0036.namprd08.prod.outlook.com (2603:10b6:805:66::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.12 via Frontend Transport; Fri, 10 Jan 2020 01:57:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 00a8ceae-69cd-4707-c916-08d7957065e1
X-MS-TrafficTypeDiagnostic: BN6PR12MB1378:|BN6PR12MB1378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB137883A5412119B056E90E01F8380@BN6PR12MB1378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(189003)(199004)(66556008)(2616005)(6916009)(5660300002)(8676002)(86362001)(66946007)(956004)(36756003)(4326008)(1076003)(81166006)(478600001)(26005)(316002)(186003)(8936002)(66476007)(52116002)(16526019)(2906002)(7696005)(6486002)(81156014)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1378;H:BN6PR12MB1667.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8oTVPBodhLehBsB7vjfPwKZp2dw3fcV9w0WT+VIy/kWRu0vdHzxJj4Bkti+iSgzPOEBNVk/btZQiFMVCU7CJKnkucoUpvyhsEVx6xMaPvGlkrnsRr3p7joA01w/GurAAb5MAUZJ3aKbIEUVrcz4galRvb9lKSzko7KN9S9CBs6sLv/NW4yyTBz05B4y5eb5phgsb3MfQogj2e5z2LUn9oagQY086xtP0k7IsKCzMRxxCjmrNa6y0WdtD/e+Wzun0+ASG+8BvLBYHJ0eUvcQmCDsHBPfS1UDVqaI9SzS9r+ZwZKG/cOM+DmnlVfQ4Rrrm8UxfL6T77aUozEhoZFnTW+777BZpnvSsIOssVx6i2hdsVV65kwZqE7ZVq5QLl06i3KPp276KeN3myMZiEX4JQBIZ56anKWqo8bgORog0dFac/GkJS91MSMz66a5jl6Hc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a8ceae-69cd-4707-c916-08d7957065e1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 01:57:07.6585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEJBcb8DC8C60WUy4qUoePdB4asO2lBg0CqMpmZDOrM/sJdOb7J8eIj3Sz4kKzhuimLa/ml2cmUoYOm5XuKQYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1378
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Add family ops to support AMD Family 19h systems. Existing Family 17h
functions can be used.

Also, add Family 19h to the list of families to automatically load the
module.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 17 +++++++++++++++++
 drivers/edac/amd64_edac.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 428ce98f6776..2488cbf76814 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2336,6 +2336,16 @@ static struct amd64_family_type family_types[] = {
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
+	[F19_CPUS] = {
+		.ctl_name = "F19h",
+		.f0_id = PCI_DEVICE_ID_AMD_19H_DF_F0,
+		.f6_id = PCI_DEVICE_ID_AMD_19H_DF_F6,
+		.max_mcs = 8,
+		.ops = {
+			.early_channel_count	= f17_early_channel_count,
+			.dbam_to_cs		= f17_addr_mask_to_cs_size,
+		}
+	},
 };
 
 /*
@@ -3368,6 +3378,12 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 			family_types[F17_CPUS].ctl_name = "F18h";
 		break;
 
+	case 0x19:
+		fam_type	= &family_types[F19_CPUS];
+		pvt->ops	= &family_types[F19_CPUS].ops;
+		family_types[F19_CPUS].ctl_name = "F19h";
+		break;
+
 	default:
 		amd64_err("Unsupported family!\n");
 		return NULL;
@@ -3626,6 +3642,7 @@ static const struct x86_cpu_id amd64_cpuids[] = {
 	{ X86_VENDOR_AMD, 0x16, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
 	{ X86_VENDOR_AMD, 0x17, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
 	{ X86_VENDOR_HYGON, 0x18, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
+	{ X86_VENDOR_AMD, 0x19, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, amd64_cpuids);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 9be31688110b..abbf3c274d74 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -122,6 +122,8 @@
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F6 0x1496
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F0 0x1440
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
+#define PCI_DEVICE_ID_AMD_19H_DF_F0	0x1650
+#define PCI_DEVICE_ID_AMD_19H_DF_F6	0x1656
 
 /*
  * Function 1 - Address Map
@@ -292,6 +294,7 @@ enum amd_families {
 	F17_M10H_CPUS,
 	F17_M30H_CPUS,
 	F17_M70H_CPUS,
+	F19_CPUS,
 	NUM_FAMILIES,
 };
 
-- 
2.17.1

