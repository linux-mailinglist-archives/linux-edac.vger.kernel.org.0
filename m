Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A3A3B3A77
	for <lists+linux-edac@lfdr.de>; Fri, 25 Jun 2021 03:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhFYBgc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Jun 2021 21:36:32 -0400
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:64609
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232873AbhFYBga (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 24 Jun 2021 21:36:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITur0Ue1SzW/Xa2yCxBV7vtVXDPfIzwq81qoZFAZzVN+qULGKTzBSHnYyHCqDu8CrQodegoqhv13j9Gi+ZcKiHgtP7MPpXQcbsm+ZimprGahsMuKjl0C66/o0LHQ3dT4Av+J3nT0BU0Rn/qXC1/MoXfY2H8y1HhoQ+0X+R/au0NfPqpJlfHP4liaIPcUJ/Gawjxpa7UZ0cIaKgVUfwXP/mal7vPGmlPV31+wCPdIqlHTGsYpYqIbxsTZjtR4Vk5NEhjolG9azYCYGwkoYIQR49qkIdgIkLn+gVcSNNPkIvg5dhVXiocHAOpczoEy6GGnDxZgB8cPqNNXBEqj1f6s3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHq31s24uvdvx1wL2rphO01OIupDEV7F2nX+nFTLmQI=;
 b=ODXZaPlu8eEz5h5xom2zs5s+6h/WBz8QKdaI01Q1BBvXaKuPr6lbi+db6w4/eCqEoXLbkk9CL7F++hSsO9DVrDyjiegW2LjSay5CXOH/3+F4j2U+u/R8Wo00SHPvj8/xcd7XWxTV0mQsSA7gO2ldOFPmQ4+0Du1Rfr+xtYYMKgsy37NcJ5mNL+N8UkWcNZrHm8vXjik1JUO2twDdfVv6y4pG5Fy3yJ5F1IGAceVU4VSiuMLRda3R7jLFj4G0Sds3jyTbzll/UCpdWKaR/rTKv4WvhIFd+0FvRiH0WPoXkhrPfPMTixGGiIO+7I4iraplQQrdz1Q32J2fp6r48S0PMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHq31s24uvdvx1wL2rphO01OIupDEV7F2nX+nFTLmQI=;
 b=W0VrdH/smjrLoLW/BrQCAzOGl6lJMt+g1iST/IdBNDlfCE6MPh7jTSkV+jUVd2woxe7LQ4yLuuat88txpbmp4gC8IdkLhgEyJONsozHtAdKHN7c2GWJNeDzSNI1KFaFhK6Xhkces9GQh2txy7SyvqSZsplFp3Z0yud1Wpo7Hfyw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 01:34:09 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c8f:eff7:df51:c837]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c8f:eff7:df51:c837%6]) with mapi id 15.20.4242.024; Fri, 25 Jun 2021
 01:34:08 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        Youquan Song <youquan.song@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH 1/2] x86/mce: Define function to extract ErrorAddr from MCA_ADDR
Date:   Thu, 24 Jun 2021 20:33:40 -0500
Message-Id: <20210625013341.231442-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BLAPR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:208:32e::23) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx50f7host.amd.com (165.204.184.1) by BLAPR03CA0138.namprd03.prod.outlook.com (2603:10b6:208:32e::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 01:34:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b8f7ad1-259e-4e27-0173-08d9377953cb
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4525B8E11D809F5E625B1D9A90069@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7L0fimJqSzIzNQKo4LhN0Vye8Q3L4gHknUssJUTLrjhwDwEBoKAVfs0D7au2VcKZy0wLnrAkc02HFeEfTyO+2+oxO6UqUS0YHZ/AYhAg+CoNOeVBbjQyXw5mnjtczEy4vV3tRIQ46+fPUUvOR69MWS5LGGvYpInvUwFI++DdVbw8J5vhajKYd9kEnJlM4LDy6sX8+aj3XBcxHFwmWwTGpb5cisoV4XCmY6M8QLzMqYHnoLY51dHYan++/zokOwL6KZSiwEGljeCJcX2NtWnYrGMjUG/mf1QorWtxQyOhr2qT1tNc0SKSucX76oprxnbLiOEawGtLEjhZRPbxIkKIKhxQe5MEdTeRAJ3szTtWhWPEh2TSFmRPQdl+m2nXdpBntJ5/Xu9Eir0tfgllnO14jDK+5JDn88H5cEPtlXpMS7u15gNI3EzeOueqry5S5yhmfXLeNCCLcfJBJRxxStdq+nBHAtZqHwThNkS7RyVifz7V30G/0qcZb0+ubsOf+YLtFNsrudRkEbQnGhvQ9Or8nFY+8EVy2a38wQpcWYHPJt+FLJv9FcGRsc6LkhPhl/oyPr60yrmSnDqYe+QahLDy2w3IiTRm0LS0EQxmsQpdISaaCAYRPfkbbIj8qrqum3/K+R61HVKogM7KKB6o8x9WDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(478600001)(2616005)(956004)(8676002)(86362001)(8936002)(4326008)(38350700002)(38100700002)(36756003)(2906002)(52116002)(66556008)(66476007)(66946007)(7696005)(83380400001)(5660300002)(6666004)(1076003)(26005)(54906003)(6486002)(316002)(16526019)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2/gRi5Hmb1560ajglTt62VtOJvntFgb6q6fYhElJ0HJ/mbwUd8t/cROTdbq4?=
 =?us-ascii?Q?QtVTO+MDV7nMUOCIG6dKfWWw/76HBgwnCm9N8+rTORpwD9AznU/Y/6EKR5mB?=
 =?us-ascii?Q?K+hMdVudIrKvZPbz/t6O7Tm3ZRpZFCCw0DEuzy298yXVvzFmlgS7L7RCK9oX?=
 =?us-ascii?Q?aGjlPetsdbPERggutXp5Jr7Q6ARdOAr6Wp4p0jRgNRPponcFV8p+A3g94UgM?=
 =?us-ascii?Q?UY1KZl1ckfk5ffUR4s/y0l8lmaPAlAZP5UV28fuWG9Cw3jakax0Xpvhji4ge?=
 =?us-ascii?Q?sIF0qsYhji7FkAHtcaNQ9yQ2po3SL7a68fT+dxcninLEnT8tlAGNIUGmLloT?=
 =?us-ascii?Q?TUUtrvVLS1BVoI8th2VhhjKV/qgbDBpAeHXxri+rO3zhv4WM4QvRtm68sxHO?=
 =?us-ascii?Q?SB2224R0hs9B/64cvWW2xN5dSOed/882GbBz+fEtk0ltDdqs27aFciRspsaK?=
 =?us-ascii?Q?dx8d25A2IXt5rQTK8vkkcLkCXdNLYmlNVIGxXykbFA5alaOB6QC6Lr4aPUJO?=
 =?us-ascii?Q?fM4L4h5vkSNfe1ei154kq4tLy/rIS73QO/z5pRUI6Sg/cIQeRuPQHk3VZiP3?=
 =?us-ascii?Q?CMp5wzj2RhMqtTuZUZq27xy5pjSe0sHD/7c3hFBp1/46DjE7NGCXO2giBsUt?=
 =?us-ascii?Q?KEGIMdkP9NTjYa7ZVpn/HzV3WhflviK3jspDIhnF6T6V5kUV+KNZt2rKtekh?=
 =?us-ascii?Q?GamcG6QH/Fqi6QpQbp5OklZQVq+n1SQzXPU4SSqJkjdcBD9DpYYa0x2to5Mq?=
 =?us-ascii?Q?HdlxqNRpOvwK0OOXH1hjuUs7Ba2v2c4bTIcAqCoDGiqim14/XVl1Jo3yGXo6?=
 =?us-ascii?Q?0SIgDpIVIpSljIuUhlpAuLGpJfwW6mk4AumUatxfOhQ6wUnAVxv7LO88IJHK?=
 =?us-ascii?Q?w6HIsHev99lx2o/X+EnTEXPrDleP0QZM9veVNermrwCFEN5GFt7a3IIf494e?=
 =?us-ascii?Q?FBi6fFWrjfF2FSSzOUEQJMmOzGUWdN/ABpPWbYdP9dNCTc3VaPRdoSNS9wm4?=
 =?us-ascii?Q?moB0d6NBmELUGeTzsaPzlNuDpHo4fr1Hwj7SWLA+FI/6aHjXTYw/gFk4LPNH?=
 =?us-ascii?Q?QDB9wC5SYcwxzVEzAUE3RsaE23+DGbsy5XoUaC73fNEu8/hAEuqvxyAf+5h5?=
 =?us-ascii?Q?eiQvuoimOR3IrMAfhLgoNZsU1FzLX4NWgWfk+xO1OhHufI4lAPc8j3fF1js2?=
 =?us-ascii?Q?WQXddnvTQFbOrJdoNwxxbHDxTisCcZKvg8/JFu/NfevrGWBLLPRXzXzUgVaH?=
 =?us-ascii?Q?oDBxi/eCZIh48TaiVlJ66vSxqn/Nbhmc7hxUDOS89Ts5xHbNObkbOtR7gX47?=
 =?us-ascii?Q?Ia5q30l5tvhlV3OQRa0Nxv/O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8f7ad1-259e-4e27-0173-08d9377953cb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 01:34:08.9133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07PcyVsT5j8YH7ZhCSvRfKISYPqPtssFvVibziisjWbET3cydtFbOrgzpBUAkUdPPLqVUiJPV/Y/+CirVAr5uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move MCA_ADDR[ErrorAddr] extraction into a separate helper function. This
will be further refactored in the next patch.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	- No change.
---
 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/amd.c  | 14 +++++++++-----
 arch/x86/kernel/cpu/mce/core.c |  7 ++-----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 0607ec4f5091..0a1c7224a582 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -357,6 +357,7 @@ extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
 int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr);
+void smca_extract_err_addr(struct mce *m);
 
 #else
 
@@ -366,6 +367,7 @@ static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
 static inline int
 umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)	{ return -EINVAL; };
+static inline void smca_extract_err_addr(struct mce *m)			{ }
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 08831acc1d03..f71435e53cdb 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -899,6 +899,13 @@ bool amd_mce_is_memory_error(struct mce *m)
 	return m->bank == 4 && xec == 0x8;
 }
 
+void smca_extract_err_addr(struct mce *m)
+{
+	u8 lsb = (m->addr >> 56) & 0x3f;
+
+	m->addr &= GENMASK_ULL(55, lsb);
+}
+
 static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 {
 	struct mce m;
@@ -917,11 +924,8 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 		 * Extract [55:<lsb>] where lsb is the least significant
 		 * *valid* bit of the address bits.
 		 */
-		if (mce_flags.smca) {
-			u8 lsb = (m.addr >> 56) & 0x3f;
-
-			m.addr &= GENMASK_ULL(55, lsb);
-		}
+		if (mce_flags.smca)
+			smca_extract_err_addr(&m);
 	}
 
 	if (mce_flags.smca) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index bf7fe87a7e88..2c09c1eec50a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -703,11 +703,8 @@ static void mce_read_aux(struct mce *m, int i)
 		 * Extract [55:<lsb>] where lsb is the least significant
 		 * *valid* bit of the address bits.
 		 */
-		if (mce_flags.smca) {
-			u8 lsb = (m->addr >> 56) & 0x3f;
-
-			m->addr &= GENMASK_ULL(55, lsb);
-		}
+		if (mce_flags.smca)
+			smca_extract_err_addr(m);
 	}
 
 	if (mce_flags.smca) {
-- 
2.17.1

