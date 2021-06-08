Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4640F3A0696
	for <lists+linux-edac@lfdr.de>; Wed,  9 Jun 2021 00:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhFHWMm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Jun 2021 18:12:42 -0400
Received: from mail-co1nam11on2078.outbound.protection.outlook.com ([40.107.220.78]:53217
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229526AbhFHWMl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 8 Jun 2021 18:12:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaYG2f7jp+e0NNmxm1Ie+644wifBIYpnwwDExZfwVvhxG0/ShO+RtMOUWBAsYXp7+Tjvfdzw4td1xgW6O2MzJ6b8WwzW9xKFOulkjuYLqOd/RhH96qBqS53Qz6C54GVOChMb2de+jBt7rzGycbd61lrUCdH1LYCz9vRQUDGmT9miOG50shboNCKji0JE7yMKhntjVnEBGosRCRhbTdOinjg8Mftww6r/5DdjNvApT/u+8XSO99ukdVIundVVCF0YLfZk+nORExQ828ceqtf+PW9jwOeDrHH7OMabb1GtXW3SV0p69zyKwPP3M+PTs14S9mFYEAcXYNv+5hvGmKvFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRXjNs3psDRqgYoh6Sg/AbTI5E/2hRk0jWhkZW/jfy8=;
 b=IEt6vi6cv3wWJ1QDremxI9WEeatTglwDx4QRVD8duJj3wS1DtTfiuzvlPxWhYvwcnJXmLsYa+WD594j2Gxymx/njOuuXzwBBAAgNJV9ckUNNPAbFKTkaWS1n/dlCjoYRP4X14a53DMMnEsi6Kxt+3t9wG5CWa9haWNi6Lxpck4nvRYU5ItbXl3KpNWTzhlX+XEFPL35bfKocNuwDsnLP+hgdELze4PQkJt7jXvjI33H/4IASdciM9+XskAj1RKtfEs/szwptOqy7bmGe3w4zxbEH3hQQVIh39YDypApK4Npc9MC2KfcAzTiMxG/vx2la6bVupsRiijNHOzFmxhciuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRXjNs3psDRqgYoh6Sg/AbTI5E/2hRk0jWhkZW/jfy8=;
 b=ADR/+XxN0lPewjRY9LIiqwlavCnsMuhPaCc5WaGjBDLyHOfrUV/n+g3zkUo92qe5+QCLml1P2fCFrRfj+lXCO7i6gwk1m5kRDLlVW8DCsQno194bCx5APEMYQVzmkjZ8WOi7PpqsKDHUx3XA5MMpG80U20SClOtiE69+VB75ekg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN1PR12MB2512.namprd12.prod.outlook.com (2603:10b6:802:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 22:10:45 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::b50a:9f23:d6f4:408d]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::b50a:9f23:d6f4:408d%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 22:10:45 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        Youquan Song <youquan.song@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH 2/2] x86/mce: Add support for Extended Physical Address MCA changes
Date:   Tue,  8 Jun 2021 17:10:12 -0500
Message-Id: <20210608221012.223696-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608221012.223696-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20210608221012.223696-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BN6PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:404:65::31) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx50f7host.amd.com (165.204.184.1) by BN6PR17CA0021.namprd17.prod.outlook.com (2603:10b6:404:65::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend Transport; Tue, 8 Jun 2021 22:10:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4c67bba-daa6-4059-a68a-08d92aca43a3
X-MS-TrafficTypeDiagnostic: SN1PR12MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB251262F928B3513F45374A5A90379@SN1PR12MB2512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gj23xWLodfS1mLdZ4XiIiPVNSrnZ6np4QJoOrwp0jNQ3IS2os35DXUXnW3Yz+YA9hCnOLusBnwb7qBsbt2wwGLxr4Qmxiu4GTexJP0T0IhxvUo8ZWZgyz6oi/JixJFhpcqUBj/XMje+u4lu4kvj1NarFfsj4w2v8zHML1cZIjmXVV5VvOtii9opyv48kVP//F+XAXvrHrx8FbJnZNRgOn5govMeJ7realTjnPLgQnQZpJjcdfoxLUZUBs/VpNNMGl6r5kbQX3ttsIYJLshL5638H1Y8ina0Elyae+mviD4hfTo3iAJVzB4k13Aw5zMAzwAzyy4xpgu/v/MZDakBoIJdj26eMcYVPCxFh10uT3XmusJU4HAqyc/VtA6olMZA8y9+WXHvd4l4QVgbQb8e+H2HWwRi7OSmpq/rn8BUTXCM/xldC7AGhieRRDB0vpU0jn/ZVL6Z7kccph2iw9QvLOTl6d1VcPGITa90iqUonLj/9ndS0FkjpWaazlGSe5PG6rtwVO1vjgK+XA0166ZdVEZt6W8Kg4SKQYlaNPF39jUgHN3GKg28lvn2Y8ZGqqYPHLZQaiswu02F/Psir405uhSmFVxP9o9FhYED9ZtAju7H/qXtPrK63UtDZTfRoUvjLF0WSBcgYTnovdiA9TkvgRu3mmU382gwmuNxkZu5YLCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(186003)(16526019)(956004)(7416002)(6486002)(26005)(36756003)(4326008)(2906002)(478600001)(316002)(83380400001)(38100700002)(38350700002)(7696005)(66556008)(66946007)(66476007)(5660300002)(8676002)(52116002)(86362001)(1076003)(54906003)(6666004)(8936002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wHsrPUkJ6XYKg5z1QtMaQlEiJL/o5GghbWWkMkt8c1E3vRfVI449C9z8A4Tr?=
 =?us-ascii?Q?30owKiy+apprB14u3leo08JQEfu/px0QgVai3aWg3q1v/jLzrNfL3RbP9sYO?=
 =?us-ascii?Q?+cTv028vK2uYBViwg2MkuaoLczqjNSPwa8+aPjgOLvBiaK/fTGWH0TlCIyUY?=
 =?us-ascii?Q?GNkmYLETszVXN8Et4m8aZr9jILnD/rlJUinPNlaNbQbFdDAogVDs1xd6kFj8?=
 =?us-ascii?Q?+WNnHTJf/qv7gZvIdFG2Qe54w0hoFofeqUMKNRp6c8TxGQ5cqp5luOxlR6O/?=
 =?us-ascii?Q?/Eca5jMc/g0VNg9oyXrs3M5u1vebGgiBuxyJJsrDKS5ewAOgIPHFzau5CkL1?=
 =?us-ascii?Q?CahCdkds3/dbsr2lZx/Fg110xPQlG3ZDIwHoydUjdelMrknL+rsadMdKsrJ6?=
 =?us-ascii?Q?9hlOCh5eiEfCxyljtzoLrW48waZj6d+j/4PL2HObIuU9SiY1xbMWnLKLl3z0?=
 =?us-ascii?Q?feY6KNckQZa0qc428EC389C+asbmAqMkKsEQaC/QAtERcKMYr/t1z7iy8Qho?=
 =?us-ascii?Q?hXLxTBo4q6dxS9XUktMopRdXCwv1gB+aOCiRywuAcqITms+5o3yDhYZXO1Z+?=
 =?us-ascii?Q?J0nl0Rl+vWOwFsvhnD2DcgcgwJlSbxNHS9N5c9mQZEi8gG2D9DmzXcK0e3wm?=
 =?us-ascii?Q?NYrAopHlUt750hbP8BlHp4EZLf1k5RDBrPPykOhb5GetuZ2u9rAFKmlsGZCs?=
 =?us-ascii?Q?diBMssNWUjpTSTiJB6D8asddVm3N/IviG2VM0XTSiC0DtUl88zDLpzH+msEB?=
 =?us-ascii?Q?AX21e3nkzdl8e7wJ7EP7D3jyulyFd5qQ7HbcmxFRCkdoupbNoss2dBZnjvm+?=
 =?us-ascii?Q?UEb5TCBvRQQouvyueownol3SaTAJ489Z0fGKzifpJla/gkbgI3GjDwaWlkVd?=
 =?us-ascii?Q?eMPBtDCiS4MukqkaKkLD23rqOXKzmpiCwdwrKE64R7E3XHTvc7hz5FFbkhIh?=
 =?us-ascii?Q?BqWsT+c3yHq3aa7jcJgFKGpcSTld6sBJRac8nf4M8RSCPunktXYy3hrIAEk8?=
 =?us-ascii?Q?sn2AH5M0mco2ioAr71kGOXOelskWBsBRrtVRyX5atsiwPfCnldup5p3uQ4+A?=
 =?us-ascii?Q?GBjUbaf32gxnfE/XIl+qQYXb29KmycCNBBhxeh1fP2O4ntuk3OrJaEWdfOhU?=
 =?us-ascii?Q?13ItmJsnSDYe7HQv9tqoFZEcbgT8tGIfTq1kfbF9hDHXCnXvnewFG1Re9IrK?=
 =?us-ascii?Q?kAiJykSvAxSisKygZQZkxI7iWqdsLa1oakRFtKj8/xuaGME5Gy3Bg+3lWcZv?=
 =?us-ascii?Q?U0rPY2rFfPq0AyoVm7TLYbeIa5fp7TYr/zTDlnbGge6X2Ww/t79kFPFX35Jp?=
 =?us-ascii?Q?jVYJjiaPmcEE203lmi4WkmS5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c67bba-daa6-4059-a68a-08d92aca43a3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 22:10:45.8693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNcsEKRMdE8kvtC+Pe1RixhJEFXT147nBHfyKrPeXBRUq9gS/8JlZEpREDM1QbSNU0txN6U9erS0k7j4c2uIKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2512
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
 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/amd.c  | 31 +++++++++++++++++++++++++------
 arch/x86/kernel/cpu/mce/core.c |  6 ++----
 3 files changed, 29 insertions(+), 10 deletions(-)

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
index f71435e53cdb..480a497877e2 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -204,6 +204,12 @@ EXPORT_SYMBOL_GPL(smca_banks);
 #define MAX_MCATYPE_NAME_LEN	30
 static char buf_mcatype[MAX_MCATYPE_NAME_LEN];
 
+struct smca_config {
+	__u64 lsb_in_status     :  1,
+	__reserved_0            : 63;
+};
+static DEFINE_PER_CPU_READ_MOSTLY(struct smca_config[MAX_NR_BANKS], smca_cfg);
+
 static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
 
 /*
@@ -901,9 +907,26 @@ bool amd_mce_is_memory_error(struct mce *m)
 
 void smca_extract_err_addr(struct mce *m)
 {
-	u8 lsb = (m->addr >> 56) & 0x3f;
+	if (this_cpu_ptr(smca_cfg)[m->bank].lsb_in_status) {
+		u8 lsb = (m->status >> 24) & 0x3f;
+
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
 
-	m->addr &= GENMASK_ULL(55, lsb);
+	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
+		rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), mca_cfg);
+		this_cpu_ptr(smca_cfg)[bank].lsb_in_status = !!(mca_cfg & BIT(8));
+	}
 }
 
 static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
@@ -920,10 +943,6 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
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
index 2c09c1eec50a..ce33006e42f8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -699,10 +699,6 @@ static void mce_read_aux(struct mce *m, int i)
 			m->addr <<= shift;
 		}
 
-		/*
-		 * Extract [55:<lsb>] where lsb is the least significant
-		 * *valid* bit of the address bits.
-		 */
 		if (mce_flags.smca)
 			smca_extract_err_addr(m);
 	}
@@ -1839,6 +1835,8 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 			msr_ops.status	= smca_status_reg;
 			msr_ops.addr	= smca_addr_reg;
 			msr_ops.misc	= smca_misc_reg;
+
+			smca_feature_init();
 		}
 	}
 }
-- 
2.17.1

