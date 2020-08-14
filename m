Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7DE244EB8
	for <lists+linux-edac@lfdr.de>; Fri, 14 Aug 2020 21:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgHNTPN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Aug 2020 15:15:13 -0400
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com ([40.107.236.81]:57313
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727871AbgHNTPK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Aug 2020 15:15:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5+xAKrMyHdzlbsoLJjFAbZa9fKAMMzyaW1glIl3e+V74DhyKszja7nW/jJPZlfNY18HAQcObf1IaQR3UN0USYmNJ//DdwEwracEsl7Ss3TiwhU0L5TiHo7eU7Bp+gXRWkkobvZODZB78+itvjuEhyKeULCCWYhowC+5x/zXHMOP93LmEo//IUe2iXyZORFfuR87Rf+vu8sC6IrPlAXGSXBlx0EEpdqaAwza99qEFlidK0ryhux7SSVxHpMTpnQbcJEpY2PY07f7dMC8dEg2cDD9QT3Ck/CIp28qYCFxHFgAob9lVI0MRplbt/nt7UlRVoO83qIRcp/mjZxswtvILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ksrH+qY+v7yR870Fxhlr3xNw3HnX59a71lSXGeOddY=;
 b=MtSALSz9eTJCmv/1TUIeMnS2nZRkHfXP+USBIQbUoqqsAjfoIeVF48Cqkk7V7S9Gdc7uy64FsihzvxrLTAdiwWTxwNNFJOhm5b3jrCAaFZBvxiHWbtOo1GuHCWDRpuYmsJqOb2lmcAAwPdb9Yyy8kah1SpZ1tzMyMr3+cui7BXVr0nSx70YEaF2D4J9RW+4mExNSTYJGTjdkuHmAVRJOlvWVMKvN9ubTh0LriC+wXqJMny8JR9c1I+ffzS5vVUe4rMcenxElbW6oOjIh69bgB+6FwusBD6RzHRDohB3qsJfh0+6txpZzaKWBICeK3QV2PrH0fIYH/UsdDLNknXHxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ksrH+qY+v7yR870Fxhlr3xNw3HnX59a71lSXGeOddY=;
 b=vnH2u5EKV7Hk7PKy/BEZGH/d9XRU5nFpxs3kHbT4Ip8MsiiAUBaBsXWgYQ1HKbPjt2v8jmfbahOguOYWeBpQCmdN/JPN6+QBDN8UgR2T2E52NeyZwqdzmWOBYswK5WERHt6tJKIK44mg2fJZsplX5zk9ev81WyMPkuXi9lItLPY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1700.namprd12.prod.outlook.com (2603:10b6:404:108::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Fri, 14 Aug
 2020 19:15:01 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0%4]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 19:15:01 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        x86@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 1/2] x86/MCE/AMD, EDAC/mce_amd: Use AMD NodeId for Family17h+ DRAM Decode
Date:   Fri, 14 Aug 2020 19:14:48 +0000
Message-Id: <20200814191449.183998-2-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814191449.183998-1-Yazen.Ghannam@amd.com>
References: <20200814191449.183998-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0087.namprd12.prod.outlook.com
 (2603:10b6:802:21::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.78.2) by SN1PR12CA0087.namprd12.prod.outlook.com (2603:10b6:802:21::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Fri, 14 Aug 2020 19:15:00 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8170d77-cb51-405d-ecf2-08d840865772
X-MS-TrafficTypeDiagnostic: BN6PR12MB1700:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1700968D9B3F62F9C86890E3F8400@BN6PR12MB1700.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tIiX3MEOzFklclvBvS+EpREss9iTd75PV75z2vLgu74IquVQvxK9N0oAr+nFMjpdQPcydIMphbXw3lOgORIdDRXubEyl+VgppCpLNDgoin3z3+Kt2NhFYnBHVlIZa4pwvarNIm2O+jEyMR/bOlviHofsQTOE8l4XbJuw2nwNo+h3xsJQngwy2m5HVdgZ6sBDU2kuepYsKhKOzzcTnXMuMdoeAQJ3sSjncGQs/Lw9C0U0bF+lmzm2GWzzsb3YLBZ5WkZWUb6vfZita019dXcBRRCNLlot9jHrjDA0J4AqaWT8zp+2nLP6FeYB2LwvdZyjie4DArQbgNLnRFNHTMtrSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(66556008)(36756003)(5660300002)(83380400001)(66476007)(66946007)(1076003)(2906002)(316002)(478600001)(16526019)(26005)(186003)(956004)(4326008)(6486002)(8676002)(52116002)(7696005)(8936002)(2616005)(6666004)(86362001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HJsOUluZy6nJQHlb05UiOgzpFrjGVLNRJ9l8kAfGWQuIjCtS9S2mFwP88EDuemxZGXH10qhiZ2WlDyTr6h+tS3ApmI81UgyTHZUZ+SZ28L+L5q3XhAiTfLR6liMxB/6noF4AsBL7CbGo5tzhOHzGzzDfcbI4Z7mcRrnfrEO51W9/DGW8WnU8h2z9shZBN0GGV1vgMpChH4ljkixKU/zuBU2XSRHEoTr13JPnCm4wZTNvNbiErqVEaXvBe3OmHUmc81oUexLSyRFapl0Ux503G78HLGlLk+g/6pthBTM0wrRLQVjcen0QqNpOsBl5f9aGv7K03gvKrZ8l5P1eEaW/49A+kVERmza4xpOcj/J8bItkmFJSUWPjqR/qmYI1dT4b27srp5ijbOoGlNQzCsctQ0itB36tju+wGy3Gbg/X2Ih0c6sLe5x+OC5UJihByfg7AkTIUi1+OFqqucfdOuX1SIV4qJ4Cm6+5N30iP7XphgfCWuTVz9/ZmyJkusyetwfbB8ehMYQeMvGvK6qWMSu918iJn/kf+arX7eoE/n+GX7R00CMa9PZOuQ6rl28vKLUwyv5w4tWRp0LcgtOeKMsUTpxEb/+wMrBPDB36c44GR/3LGIDcZE8PiVGC+iQpNtq7w+wxe9eLCsMjxCZ9PXKCeA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8170d77-cb51-405d-ecf2-08d840865772
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 19:15:01.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dye6mU9tkvqVKwB12HkGbvv8wovxYvxh3LARCSdTcejJ4fKFzHWwRiLBebzCz3MsNW6GD4rgXX3vO3fTtpDFdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1700
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The edac_mce_amd module calls decode_dram_ecc() on AMD Family17h and
later systems. This function is used in amd64_edac_mod to do
system-specific decoding for DRAM ECC errors. The function takes a
"NodeId" as a parameter.

In AMD documentation, NodeId is used to identify a physical die in a
system. This can be used to identify a node in the AMD_NB code and also
it is used with umc_normaddr_to_sysaddr().

However, the input used for decode_dram_ecc() is currently the NUMA node
of a logical CPU. In the default configuration, the NUMA node and
physical die will be equivalent, so this doesn't have an impact. But the
NUMA node configuration can be adjusted with optional memory
interleaving schemes. This will cause the NUMA node enumeration to not
match the physical die enumeration. The mismatch will cause the address
translation function to fail or report incorrect results.

Save the "NodeId" as a percpu value during init in AMD MCE code. Export
a function to return the value which can be used from modules like
edac_mce_amd.

Fixes: fbe63acf62f5 ("EDAC, mce_amd: Use cpu_to_node() to find the node ID")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    |  2 ++
 arch/x86/kernel/cpu/mce/amd.c | 11 +++++++++++
 drivers/edac/mce_amd.c        |  2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cf503824529c..92527cc9ed06 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -343,6 +343,8 @@ extern struct smca_bank smca_banks[MAX_NR_BANKS];
 extern const char *smca_get_long_name(enum smca_bank_types t);
 extern bool amd_mce_is_memory_error(struct mce *m);
 
+extern u8 amd_cpu_to_node(unsigned int cpu);
+
 extern int mce_threshold_create_device(unsigned int cpu);
 extern int mce_threshold_remove_device(unsigned int cpu);
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 99be063fcb1b..524edf81e287 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -202,6 +202,9 @@ static DEFINE_PER_CPU(unsigned int, bank_map);
 /* Map of banks that have more than MCA_MISC0 available. */
 static DEFINE_PER_CPU(u32, smca_misc_banks_map);
 
+/* CPUID_Fn8000001E_ECX[NodeId] used to identify a physical node/die. */
+static DEFINE_PER_CPU(u8, node_id);
+
 static void amd_threshold_interrupt(void);
 static void amd_deferred_error_interrupt(void);
 
@@ -233,6 +236,12 @@ static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
 
 }
 
+u8 amd_cpu_to_node(unsigned int cpu)
+{
+	return per_cpu(node_id, cpu);
+}
+EXPORT_SYMBOL_GPL(amd_cpu_to_node);
+
 static void smca_configure(unsigned int bank, unsigned int cpu)
 {
 	unsigned int i, hwid_mcatype;
@@ -240,6 +249,8 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 	u32 high, low;
 	u32 smca_config = MSR_AMD64_SMCA_MCx_CONFIG(bank);
 
+	this_cpu_write(node_id, cpuid_ecx(0x8000001e) & 0xFF);
+
 	/* Set appropriate bits in MCA_CONFIG */
 	if (!rdmsr_safe(smca_config, &low, &high)) {
 		/*
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 325aedf46ff2..9476097d0fdb 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -996,7 +996,7 @@ static void decode_smca_error(struct mce *m)
 	}
 
 	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
-		decode_dram_ecc(cpu_to_node(m->extcpu), m);
+		decode_dram_ecc(amd_cpu_to_node(m->extcpu), m);
 }
 
 static inline void amd_decode_err_code(u16 ec)
-- 
2.25.1

