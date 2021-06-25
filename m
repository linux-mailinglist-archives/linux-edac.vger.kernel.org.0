Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0889F3B3A79
	for <lists+linux-edac@lfdr.de>; Fri, 25 Jun 2021 03:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhFYBgh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Jun 2021 21:36:37 -0400
Received: from mail-dm6nam10on2086.outbound.protection.outlook.com ([40.107.93.86]:4705
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232992AbhFYBgg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 24 Jun 2021 21:36:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3W7GS00SH5PVqNQupCxOl4MHQntl5rvhbQZGp9/uzPT3KHczxCuR5pODtRhDHgvNdiMdoyI1CHdweaCE74JT70E4T2puYPv9uiPHtrOOq0ZeREiCCnDTeGhRHvqTm8sHbYO8JpZMgz6IPECAzOd7hKYTQ628sjf0pmA/QmglOavLGJh6CFyoKrMLNY9KnyOUh6IKL3hWUM728BVcCzra2sz/HJrkK3DnRYJ76IGLHGgYfK21yJlpnYXJlTqUP3V0VxTaHjz141bg6tiZIf54XtC+o0oo3DytCQ6tOszI87E9qm+CB7ACTXXWfAeA7v3rZWqfXW7Zf6Pcwpm5X2xYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2si7xkqj/f28aGrL5T6NRsDFLcq3BrKVOPvIfsl/1I=;
 b=iHjnOedK7+H5PVrtGya2fpdRL66fosdkSlkGMJ2pl12ki5Dk5uvupETOfUHfQsahVk8V61AKtD9HhKfMQOK89rYvMThXKmU7qYOksmZ8YLPZujhXYkUe5bpP4y0TQztM61COZJTdCg6JE/G4KAvlhTRBFHJXJnov+h1/E2gxEMuwROVQTt/24eoxfxXtcnQ0WpR0ekiMOOguCizXYyL6KcchiXOfOgm0aQIVcaCtnr3gReUUyHBiLtb8slABEwb9snM6zVzOaX5MYqqs1k2AGed6oamLJDA24HwNb8/4xbdoVzaQt/il5I5dsNxljo/+soN3JxCkde4sgZpQcy0c2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2si7xkqj/f28aGrL5T6NRsDFLcq3BrKVOPvIfsl/1I=;
 b=PW2D+LYENGF6FoXySjguBe+oLmCwDUTg/rA010BN1QZ71l6iC8fb0CcGuj6qY+eUaG7HR+OKUrIuEOecGYErNbFyaC7hr3eTb4W+CCUeUrttaxukhwbE+IyarYaJ3tnr43EgV7FF7TWWB4vK2Bc4fZNbdsQLHhL1BVM18U++65Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 01:34:12 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c8f:eff7:df51:c837]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c8f:eff7:df51:c837%6]) with mapi id 15.20.4242.024; Fri, 25 Jun 2021
 01:34:12 +0000
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
Subject: [PATCH 2/2] x86/mce: Add support for Extended Physical Address MCA changes
Date:   Thu, 24 Jun 2021 20:33:41 -0500
Message-Id: <20210625013341.231442-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210625013341.231442-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20210625013341.231442-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BLAPR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:208:32e::23) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx50f7host.amd.com (165.204.184.1) by BLAPR03CA0138.namprd03.prod.outlook.com (2603:10b6:208:32e::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 01:34:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab43ff13-ea39-450d-8a79-08d9377955d7
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4525FF7919D7D015EA768C3090069@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cIgWbAJ7DqIx9herR15On3Dg5LkeE3/1948LYizfaTBdi00d0+W37gHmk6ls0IJQ3r1alK+eFlpApkP9AMq3YlM2Sl7Wcg5AvJloyOtuli3yo7F+63CmUTnp5HUMHoTFX3Rvz4v8NzeWclsyzTHRXVho0AlvBChDOCUEGrdrgg8sCmYNMS0/F2iqBGcKKoa+zgadmd5QWRCWmHjEZQ4JZNAt52frz2+raAPPjeNouv4G31mEG2TM83YJNNwuZN9KhCtfQ6m5NeHWT9VafjeamxFIcGmFwmFPHoWErYFLi4AGdObp2mYbXWDWpWl7YdGF3KcTRVad2/wbjaaD8uIAuvNtWoHkGtQH7xFdk/KZSCBgE3YdZVVdgSnDCqzfp/TQBF6tUwPQs3va9T/011U5YsC5ziEMFA97v6C1N1PlDFDyXnQ4nSccU4SRd+uSt/B0IIfoKP9qcdpxqCpACu3nxAeCSYNvhcoUORG8uV97VofpLTjRk3fk1lekiSkhXkmqJeyDFrRFjUBXIet/I4YaH1/VcNM0luCChU+nxyxrLM/+CvixnFlOAD6YN5tJPpqO8AYR3NfgYM7b0dvS6UYTeLOAkX7eE8nKTqHuBThTN07Y+7WCvuHlRUQU1BodX9JoJTjrvoDj75gQT93vWxtfDYHpNHMiqtjZ6Z8y9L3jZpA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(478600001)(2616005)(956004)(8676002)(86362001)(8936002)(4326008)(38350700002)(38100700002)(36756003)(2906002)(52116002)(66556008)(66476007)(66946007)(7696005)(83380400001)(5660300002)(6666004)(1076003)(26005)(54906003)(6486002)(316002)(16526019)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VPwaemszXcqrq2f0nE7rS/lqe+x3s/AWO162OEK8XD5FiCeaTph2fKH87PFn?=
 =?us-ascii?Q?3O26wHs7f+r602/PW685gbSIGE5UVuXYLFxfjpniW2aU+8GEfuSYKK6NCJWC?=
 =?us-ascii?Q?eqFKGGumgd2x4TauWEy1q3TaANqFjdhaIHy5TBQpeF7MLsm+NpkPG0hg7pfu?=
 =?us-ascii?Q?mw9BA4oKthonKXKlEGpW6W54umNM8zcHdyw6GkQpgmHrvFd1x326HYCpeUiR?=
 =?us-ascii?Q?jxshqoFQxI0c3HjXbSzxdX5UJm3IdYzUhkJ7prOX/PBzv4IJpFaB4b/BKc42?=
 =?us-ascii?Q?eG+g+f72DJ7wSX0ldoAtTSvb8I87VXNbJnUMP+YNsJR+Bw/G3Vi8USASfR9C?=
 =?us-ascii?Q?kkjlmVCROk8AmPhuJ4zYzc1DDuzLEwkBNg888NRnEBgg8/N1wC1z+YVEZSnn?=
 =?us-ascii?Q?VoPbOjRX6ToqgWoCeRLRCwCsaWvE1O7GEuo8aGjFzdgANdYcRt1f44w7FVNt?=
 =?us-ascii?Q?PXKUd62CJlVE8yyBtCNGvJJNGHlC7tQr7o/mWQ7ECH+PZd2iudTy6MCtBmom?=
 =?us-ascii?Q?vbzsBRl1GMDQRCyqygfrx+A78pLHOdSK74FEEmYgAWi/V3gCItlpvW4kAx8l?=
 =?us-ascii?Q?eOXyA7lyZw8SIfSsEmGidd7EXaZIxJwW0d+cxlfuyumWbZJaL17doKLZ+6Yp?=
 =?us-ascii?Q?fax7mFCpod7fIyTJ/QHLsOTU8yJzpYYunb3rVIXlC6PA1lhvEvhczPDa+J0Q?=
 =?us-ascii?Q?347hwNIU28HGjkbzR+q+eoJrB3EUOlzjAlHD3mpwAcvCC896CNFK2M5TnrYm?=
 =?us-ascii?Q?BXe2BSCERqeQRde+L2lKk1MUHT2MDYJ7yYKqXCsW9qrFA6Drq84wdFa1BmuU?=
 =?us-ascii?Q?+iT2GVHLEaR08H48TaW5Q84h8WpK0hFkDnGFMQWVy3p2JsAXbjXnCCbr2CdJ?=
 =?us-ascii?Q?AOenZ2qOW71xavVe5/aE9OiNPzyIt/AitMzIq2xtMYDhnj37zrJJTLmTTTJY?=
 =?us-ascii?Q?ZO47M2jdT+YQdylQyttHYCKCPoHmo6txPVdgUJSMpFgsTmMICpUtr3lgPxvn?=
 =?us-ascii?Q?KRV6xrWXG6SE5MF8TuzA8+5Zg8XATCdU/IxCgeMAxjck/q0ApZCc2kn9wyne?=
 =?us-ascii?Q?qL6U775ur4BtjUo5U65Tt/BrSb0sEWqKMsHDuT9zeQcBGmgxx1e+qi1hPN5O?=
 =?us-ascii?Q?Vh6DWGmhfFg8Vzs4uRzIHI81BvXLYK38bQ91BeBbllZtEdGCWsvMkar4Y6SD?=
 =?us-ascii?Q?hjgXGJsnpP7OCmMGS2gTJnIGa17HWJHvi8J9/jfOZMRPGh9LAU7HWZySs4gj?=
 =?us-ascii?Q?f52O8ieffadcPqJf+QrenmOnowFxyyOCPVogWgPVmcOD7vprF2fZ4ZvPSlsY?=
 =?us-ascii?Q?AZmgAgFMtFdk/PdKlCIkv3zj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab43ff13-ea39-450d-8a79-08d9377955d7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 01:34:12.4008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QngRc45tif1/epu/mFBaXZ/WuPw8PsbvZE8wjUe+OviV5TC31kRs+2Gca+TwOyDAwJuyTAMkU/D/4tQBosirw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Newer AMD processors such as AMD 'Milan' support more physical address
bits.

That is the MCA_ADDR registers on Scalable MCA systems contain the
ErrorAddr in bits [56:0] instead of [55:0]. Hence the existing LSB field
from bits [61:56] in MCA_ADDR must be moved around to accommodate the
larger ErrorAddr size.

MCA_CONFIG[McaLsbInStatusSupported] indicates this change. If set, the
LSB field will be found in MCA_STATUS rather than MCA_ADDR.

Each logical CPU has unique MCA bank in hardware and is not shared with
other logical CPUs. Additionally on SMCA systems, each feature bit may be
different for each bank within same logical CPU.

Check for MCA_CONFIG[McaLsbInStatusSupported] for each MCA bank and for
each CPU.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	Declared lsb_in_status in existing mce_banks[] struct.
	Moved struct mce_banks[] declaration from core.c -> internal.h
---
 arch/x86/include/asm/mce.h         |  2 ++
 arch/x86/kernel/cpu/mce/amd.c      | 25 +++++++++++++++++++------
 arch/x86/kernel/cpu/mce/core.c     | 12 +++---------
 arch/x86/kernel/cpu/mce/internal.h | 14 ++++++++++++++
 4 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 0a1c7224a582..33c5e77cf924 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -358,6 +358,7 @@ extern int mce_threshold_remove_device(unsigned int cpu);
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
 int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr);
 void smca_extract_err_addr(struct mce *m);
+void smca_feature_init(void);
 
 #else
 
@@ -368,6 +369,7 @@ static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
 static inline int
 umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)	{ return -EINVAL; };
 static inline void smca_extract_err_addr(struct mce *m)			{ }
+static inline void smca_feature_init(void)				{ }
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index f71435e53cdb..5e0819de641f 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -901,9 +901,26 @@ bool amd_mce_is_memory_error(struct mce *m)
 
 void smca_extract_err_addr(struct mce *m)
 {
-	u8 lsb = (m->addr >> 56) & 0x3f;
+	if (this_cpu_ptr(mce_banks_array)[m->bank].lsb_in_status) {
+		u8 lsb = (m->status >> 24) & 0x3f;
 
-	m->addr &= GENMASK_ULL(55, lsb);
+		m->addr &= GENMASK_ULL(56, lsb);
+	} else {
+		u8 lsb = (m->addr >> 56) & 0x3f;
+
+		m->addr &= GENMASK_ULL(55, lsb);
+	}
+}
+
+void smca_feature_init(void)
+{
+	unsigned int bank;
+	u64 mca_cfg;
+
+	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
+		rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), mca_cfg);
+		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(mca_cfg & BIT(8));
+	}
 }
 
 static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
@@ -920,10 +937,6 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	if (m.status & MCI_STATUS_ADDRV) {
 		m.addr = addr;
 
-		/*
-		 * Extract [55:<lsb>] where lsb is the least significant
-		 * *valid* bit of the address bits.
-		 */
 		if (mce_flags.smca)
 			smca_extract_err_addr(&m);
 	}
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c09c1eec50a..f3be82acce67 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -67,11 +67,7 @@ DEFINE_PER_CPU(unsigned, mce_exception_count);
 
 DEFINE_PER_CPU_READ_MOSTLY(unsigned int, mce_num_banks);
 
-struct mce_bank {
-	u64			ctl;			/* subevents to enable */
-	bool			init;			/* initialise bank? */
-};
-static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
+DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
 
 #define ATTR_LEN               16
 /* One object for each MCE bank, shared by all CPUs */
@@ -699,10 +695,6 @@ static void mce_read_aux(struct mce *m, int i)
 			m->addr <<= shift;
 		}
 
-		/*
-		 * Extract [55:<lsb>] where lsb is the least significant
-		 * *valid* bit of the address bits.
-		 */
 		if (mce_flags.smca)
 			smca_extract_err_addr(m);
 	}
@@ -1839,6 +1831,8 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 			msr_ops.status	= smca_status_reg;
 			msr_ops.addr	= smca_addr_reg;
 			msr_ops.misc	= smca_misc_reg;
+
+			smca_feature_init();
 		}
 	}
 }
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 88dcc79cfb07..37b76a726c29 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -168,6 +168,20 @@ struct mce_vendor_flags {
 
 extern struct mce_vendor_flags mce_flags;
 
+struct mce_bank {
+	u64			ctl;			/* subevents to enable */
+	bool			init;			/* initialise bank? */
+
+	/*
+	 * (AMD) MCA_CONFIG[McaLsbInStatusSupported]: This bit indicates
+	 * the LSB field is found in MCA_STATUS, when set.
+	 */
+	__u64 lsb_in_status		: 1,
+	      __reserved_1		: 63;
+};
+
+DECLARE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
+
 struct mca_msr_regs {
 	u32 (*ctl)	(int bank);
 	u32 (*status)	(int bank);
-- 
2.17.1

