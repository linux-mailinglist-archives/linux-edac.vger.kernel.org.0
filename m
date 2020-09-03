Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6708C25C9E9
	for <lists+linux-edac@lfdr.de>; Thu,  3 Sep 2020 22:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgICUCA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Sep 2020 16:02:00 -0400
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com ([40.107.243.60]:48609
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727065AbgICUB5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Sep 2020 16:01:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoRiqYRxRVEqzjkXgZ6gdxKNE5kvj4DRNiSb6MTNBSZHQRJcp+sbblMS2Ji2fwO5FdqL5XmebC17cd37DqXPTWh2J6FEl5pWYiZw8CTl2x2OExw4u25w/B5Jjp4bNSw/b0PQuRlTsNycbLB+iSTFVN14J5ey6XZKvl29k2SAmWcvkc+027TsOQfikKOrgfGY2x6ulZBs2eCug7hOfhiSDr4by/3OSwKCMFEDDkEp2vzmW3tszZEixY9FI6KNPxcwnG1S1rvodD55e0ZF0D3m7i/tqatjMs5b7sPEpg7srSZfRjrLe9nw8pM/hH/JBOVSVFDe0eCe5tJ8Hxi0g7oNpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMyI6yr1Xi1rcdCWVJgzkvAXWBKmS8Bh6UO9qC6m10Y=;
 b=fDCMLsGWLwyK7/bnPjHTO/BkEmEAjRJEl3d33Gi1pB/MM4C+jvn9/oz3IVerZQe8vfU9GvIUdSIVl7fPKtI0lnhj13I4NzK70U5OQPVDN2VNCVntsWubctgWOAjWB/vcjNd5e9+eWzNI4DOhgdjxMgRGikJBeNacxv6QeRV8usZ0R1NyKl7yT0j83S+lycjJ1KmkaPQJlQO4PRWVu3aHbB2nqSYjt4deg3l0v2lDkJ73HLkFyr0B7OF768bBWWvgxR0NWo89BDuwLIJhKPhuqSjUkgTa6Rvv+kA5ubpi4xMuJB7zneX1OnfZVhz/YnuNzop9OxP0q9a18LbVCie0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMyI6yr1Xi1rcdCWVJgzkvAXWBKmS8Bh6UO9qC6m10Y=;
 b=4cn1w9I/Nt/NoiXm1cRsqtbeurYJVuh4nNN6orcBYeTRdgNJn/Nynt3JStBGCPyL9SC8X2sjXNELAt+w7pVXXO8UWGJ8tLoW31nif43EOiUHSxukfW+gS9ZtV8hEZ4kVC6YXOvP5ITVdk0Es96lhUiWgT1Ef+P76Vz3Z7TLjpiQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3171.namprd12.prod.outlook.com (2603:10b6:408:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 20:01:51 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e%4]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 20:01:51 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH v2 4/8] x86/MCE/AMD: Use defines for register addresses in translation code
Date:   Thu,  3 Sep 2020 20:01:40 +0000
Message-Id: <20200903200144.310991-5-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0075.namprd05.prod.outlook.com
 (2603:10b6:803:22::13) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0501CA0075.namprd05.prod.outlook.com (2603:10b6:803:22::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7 via Frontend Transport; Thu, 3 Sep 2020 20:01:51 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6668c0bc-95ba-4a4c-438e-08d8504432e4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3171:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3171122F822CEAE7D05188B6F82C0@BN8PR12MB3171.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIPsMqB/1Yz/dPniPMM6HHNucPj2QSqO4ewc0HTiP3fNtlXdaL1PmpSWeffV9awXQXWAg9sMKwjp7tydhy3tfpo5T5/zcFZnW+u+tSkczAB12iQwIgiDXuqJ8B7IIrJpls7mk5o+evwwVp9fDAHdnW+blC2h1pl+Fn1s8XaIVFaByu2OO/vBtcrIxgeIm9rYdxX+hcxlxjFgPki5bTE1+S800mOkuvFqXwmGp40QK2vGN8kdeys0ph6hMPRHOMByOYjMcKJsuBBu8oaAf8CfsGxFnbbXvDvWbDjkfvQdlb6Sg64JaHH7i+katfwMRXc+hyhgcx4ugW+ikY4rczDuuxeOj9RPmEbagQD+DVv1MTDgDJ9VeBeLV4kKRz7an/AAfcFa3ceSE3NfURzDvu6Ifw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(8936002)(36756003)(6666004)(478600001)(186003)(316002)(6486002)(966005)(26005)(8676002)(52116002)(16576012)(5660300002)(66476007)(86362001)(4326008)(6916009)(66556008)(2616005)(956004)(66946007)(2906002)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qUz4I+ol8y9+F47XdJ9Nm8YYQj8k4vmwO7tjF8mjkcnJ4vD1xJ5EW3rgv1xTZr+KF2h/+BzL3k1UVIBr5R4PIsj3iMIhVrCCXA2Jvi4rp9EBhtSER97Tnc5nFyTdo4kYZ3yZBkHzi65Qym/QghxcNrdU7+MfveUQIGJdScMfiQgAXLv5+KHVwPdk9VbmnoEx8I75HiT9DknL1MnjLR9XA/QEOomKagPcMeFjjtA9Wpk5rWuiyWbs9j0B8xNysQqBQjZw19P3lxOdmswQosMtqijBCVuZmDp0KXoJ3AphQzE1WW/nNsCYYd1M07VLNwnb99I7oGUjKj0grlkpa7CihDQ61j5n8MPTXZsJOsekUUaBJpVH8Z16jLrt6X0J+M5jP6NqIbqGzRaxPil8stwwUxbgSzQCcxG2gTOv065aGUV4TioPwuyCP1HswOP1jVERZhom22y26e99RKqvUlzFi9yiy0exfQ7APY5Bu/VZxlhX89AeuIAAGrU09vz2X4GWQBU6N3j+8UmfbwOrF2Sntr9R2sfWIUhRQ746NxOD8cv+wYHSV+o7Ik1KVP0RnAXecQLytstakoJ6dbi2EepgB0cMYPd0s2GwGl2qRLJjHOJEpDrcEvTAXyl9oB3dm68lvhyZ47ArZDIuZMUPWwiafA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6668c0bc-95ba-4a4c-438e-08d8504432e4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 20:01:51.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIGfosB4gwR2axoXz4wk1HAt7zXW5gPSyw0mK49iChcK1G3w0H7Dkw7kruSu4OF8Hy4aGZl2hYx/ISJ7XChu0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3171
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Replace raw register offset values in the AMD address translation code
with named definitions.

Also, drop comments that only note the register names.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20200814191449.183998-3-Yazen.Ghannam@amd.com

v1 -> v2:
* New patch based on comments for v1 Patch 2.

 arch/x86/kernel/cpu/mce/amd.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index be96f77004ad..1e0510fd5afc 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -675,6 +675,14 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 		deferred_error_interrupt_enable(c);
 }
 
+#define DF_F0_FABRICINSTINFO3	0x50
+#define DF_F0_MMIOHOLE		0x104
+#define DF_F0_DRAMBASEADDR	0x110
+#define DF_F0_DRAMLIMITADDR	0x114
+#define DF_F0_DRAMOFFSET	0x1B4
+
+#define DF_F1_SYSFABRICID	0x208
+
 int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
@@ -691,22 +699,21 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	u8 cs_mask, cs_id = 0;
 	bool hash_enabled = false;
 
-	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
-	if (amd_df_indirect_read(nid, 0, 0x1B4, umc, &tmp))
+	if (amd_df_indirect_read(nid, 0, DF_F0_DRAMOFFSET, umc, &tmp))
 		goto out_err;
 
 	/* Remove HiAddrOffset from normalized address, if enabled: */
 	if (tmp & BIT(0)) {
 		u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;
 
+		/* Check if base 1 is used. */
 		if (norm_addr >= hi_addr_offset) {
 			ret_addr -= hi_addr_offset;
 			base = 1;
 		}
 	}
 
-	/* Read D18F0x110 (DramBaseAddress). */
-	if (amd_df_indirect_read(nid, 0, 0x110 + (8 * base), umc, &tmp))
+	if (amd_df_indirect_read(nid, 0, DF_F0_DRAMBASEADDR + (8 * base), umc, &tmp))
 		goto out_err;
 
 	/* Check if address range is valid. */
@@ -728,8 +735,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		goto out_err;
 	}
 
-	/* Read D18F0x114 (DramLimitAddress). */
-	if (amd_df_indirect_read(nid, 0, 0x114 + (8 * base), umc, &tmp))
+	if (amd_df_indirect_read(nid, 0, DF_F0_DRAMLIMITADDR + (8 * base), umc, &tmp))
 		goto out_err;
 
 	intlv_num_sockets = (tmp >> 8) & 0x1;
@@ -780,12 +786,11 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		u8 die_id_bit, sock_id_bit, cs_fabric_id;
 
 		/*
-		 * Read FabricBlockInstanceInformation3_CS[BlockFabricID].
 		 * This is the fabric id for this coherent slave. Use
 		 * umc/channel# as instance id of the coherent slave
 		 * for FICAA.
 		 */
-		if (amd_df_indirect_read(nid, 0, 0x50, umc, &tmp))
+		if (amd_df_indirect_read(nid, 0, DF_F0_FABRICINSTINFO3, umc, &tmp))
 			goto out_err;
 
 		cs_fabric_id = (tmp >> 8) & 0xFF;
@@ -800,9 +805,8 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 
 		sock_id_bit = die_id_bit;
 
-		/* Read D18F1x208 (SystemFabricIdMask). */
 		if (intlv_num_dies || intlv_num_sockets)
-			if (amd_df_indirect_read(nid, 1, 0x208, umc, &tmp))
+			if (amd_df_indirect_read(nid, 1, DF_F1_SYSFABRICID, umc, &tmp))
 				goto out_err;
 
 		/* If interleaved over more than 1 die. */
@@ -841,7 +845,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 
 	/* If legacy MMIO hole enabled */
 	if (lgcy_mmio_hole_en) {
-		if (amd_df_indirect_read(nid, 0, 0x104, umc, &tmp))
+		if (amd_df_indirect_read(nid, 0, DF_F0_MMIOHOLE, umc, &tmp))
 			goto out_err;
 
 		dram_hole_base = tmp & GENMASK(31, 24);
-- 
2.25.1

