Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31370105429
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2019 15:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKUOPf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Nov 2019 09:15:35 -0500
Received: from mail-eopbgr750073.outbound.protection.outlook.com ([40.107.75.73]:61446
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727123AbfKUOPf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 21 Nov 2019 09:15:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeSR8li1m/TztpIzpONH40pGE+Qg/pspvqq7pkVmFMdvM6N5BcMj+B4pvChBYUsvDgFNUJQyoNEmUDkbcbLexmMD2/+9NC3KZK244qpEP1ZXb3DIKkOeyuLOhop3HWzkPjIMngBbxRzG2Rd65gkfNn8sES5TOLGcx+Yd7YAR7OeGF+llTzIb0FDKBeqW3gcOWBaLTMF4c0eTr0oqe1gXOnMaP27JjHMq9lOJlzh7/XqrysLyIM0cMOuMxEl3lD3j5+AWjqUQh9pTF/WLP8uE7984V3aY7PYy+0V82mWgC5nF7AW7auDJ1AaxJlxUTQ88eacKDgx/KTHkCt+bJSr0ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWXcJKmNEFFO5Exy+OMvTQBC6sXZDBNOgtQfRPH6BhE=;
 b=Zy8+sr4SN3kKY8G2whz8F5fLnJbboZALq7PIB399ohlbtsuThLmiCDkLZsN80A4WrPKTSQGoprE0xzD8WWgppy3ZT0ooSyncNd17MBzm1RO2Jz7O4skKPIxiTT16zjko6JeqvMt99+wm0WRDQw+KAgMPoXyOJNPIFCeKyaNJJokTGctNfF3NfXD8n34GxBUjvBWh19PtcGXV7alqMVoCCu4V28oMOKiRsIZMQJCQCXdHfy+th+S1pptHhJNNh+5RrWyvPrX6l7bqCUH4+qJjw54Sm3mLsCrxjwv9OGJ7/BObtWOGUpeSiXDF74MYzAbhHDxnZGsr1Bvc3EoCeHxU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWXcJKmNEFFO5Exy+OMvTQBC6sXZDBNOgtQfRPH6BhE=;
 b=zj/H5Hgh7pWInkK87Sdcb1gbfrFSB5xSpUDlDCzeSEKlEYmE3weXW5pL3TJc5OOYRy293Iq0P4RCppGVrefQphyLz7n7t5ioqoIeYS6NMLxL/dpVp4hPlhB5R4CzgTULHqI021meINU4h4f+6Uo4kfWgIR+1E9my8POqlQzKTe0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2816.namprd12.prod.outlook.com (52.135.107.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Thu, 21 Nov 2019 14:15:19 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba%3]) with mapi id 15.20.2451.031; Thu, 21 Nov 2019
 14:15:19 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        x86@kernel.org
Subject: [PATCH] x86/mce/AMD: Allow Reserved types to be overwritten in smca_banks[]
Date:   Thu, 21 Nov 2019 08:15:08 -0600
Message-Id: <20191121141508.141273-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0056.namprd12.prod.outlook.com
 (2603:10b6:802:20::27) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b10f590d-5d6a-453f-452c-08d76e8d3d30
X-MS-TrafficTypeDiagnostic: SN6PR12MB2816:|SN6PR12MB2816:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2816DC09940271B80A846AD8F84E0@SN6PR12MB2816.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0228DDDDD7
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(189003)(199004)(50226002)(6666004)(6916009)(2351001)(47776003)(48376002)(8936002)(6512007)(81156014)(8676002)(81166006)(316002)(2361001)(50466002)(5660300002)(478600001)(52116002)(6486002)(186003)(305945005)(51416003)(86362001)(7736002)(4326008)(6506007)(26005)(386003)(6436002)(99286004)(14444005)(66476007)(25786009)(14454004)(16586007)(1076003)(66946007)(2616005)(66556008)(6116002)(2906002)(66066001)(36756003)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2816;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAZKgfjS6qAoxcbUAB9x0gjgotVr6ThwXk4BWAJ9TL9XIM/ByQE8akrF3upf6zDVm5mfMiDD6ecOwh3cD8JdqhN1hp4G6fXcXb56bYk6yoaRmf7+Qu6Bu/EszkoZHhLCcRQdVzxC7Ax7LSO6brAJOgMFAd0rxbc6LZwaDhWWEOSq4fbcX2CF4jtuOr4zdv2NtlG7FMJTLROeMr3zlylpaVLeXqrEEqQR6Hf7JZa/xbooHxMXr4qb+TjwUk/Do7F3fWfx0GrQStWFPeJ0TSUg6PmQYdHfCcZ7ckNiUcyJeDv+8lN/OAmK1wbt7DMEkfvo2AHC2sKP4opyZBoz1VeMOqzwcyNxgt0YGdBx9b1iANpakdQRv6t7QLHDE4dLTi2Qwpkm1Km+CU9cMDUmx9y6aL7u0SNBM3LUtt82JZE6ZOqd62LOPhFQvIND9EWot0+v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10f590d-5d6a-453f-452c-08d76e8d3d30
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 14:15:19.3761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xfCp1dDb4EFb64TLKlwss99YlXWCPRlOX1pbw5xYO47FHCODVuUx8Ne6ffOspGe5J2KUvab9Yxe+4nDb5Tppg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2816
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Each logical CPU in Scalable MCA systems controls a unique set of MCA
banks in the system. These banks are not shared between CPUs. The bank
types and ordering will be the same across CPUs on currently available
systems.

However, some CPUs may see a bank as Reserved/Read-as-Zero (RAZ) while
other CPUs do not. In this case, the bank seen as Reserved on one CPU is
assumed to be the same type as the bank seen as a known type on another
CPU. In general, this occurs when the hardware represented by the MCA
bank is disabled, e.g. disabled memory controllers on certain models,
etc. The MCA bank is disabled in the hardware, so there is no
possibility of getting an MCA/MCE from it even if it is assumed to have
a known type.

For example:

Full system:
	Bank  |  Type seen on CPU0  |  Type seen on CPU1
	------------------------------------------------
	 0    |         LS          |          LS
	 1    |         UMC         |          UMC
	 2    |         CS          |          CS

System with hardware disabled:
	Bank  |  Type seen on CPU0  |  Type seen on CPU1
	------------------------------------------------
	 0    |         LS          |          LS
	 1    |         UMC         |          RAZ
	 2    |         CS          |          CS

For this reason, there is a single, global struct smca_banks[] that is
initialized at boot time. This array is initialized on each CPU as it
comes online. However, the array will not be updated if an entry already
exists.

This works as expected when the first CPU (usually CPU0) has all
possible MCA banks enabled. But if the first CPU has a subset, then it
will save a "Reserved" type in smca_banks[]. Successive CPUs will then
not be able to update smca_banks[] even if they encounter a known bank
type.

This may result in unexpected behavior. Depending on the system
configuration, a user may observe issues enumerating the MCA
thresholding sysfs interface. The issues may be as trivial as sysfs
entries not being available, or as severe as system hangs.

For example:

	Bank  |  Type seen on CPU0  |  Type seen on CPU1
	------------------------------------------------
	 0    |         LS          |          LS
	 1    |         RAZ         |          UMC
	 2    |         CS          |          CS

Extend the smca_banks[] entry check to return if the entry is a
non-reserved type. Otherwise, continue so that CPUs that encounter a
known bank type can update smca_banks[].

Fixes: 68627a697c19 ("x86/mce/AMD, EDAC/mce_amd: Enumerate Reserved SMCA bank type")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 4f790c375580..ee0f211b5074 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -266,7 +266,7 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 	smca_set_misc_banks_map(bank, cpu);
 
 	/* Return early if this bank was already initialized. */
-	if (smca_banks[bank].hwid)
+	if (smca_banks[bank].hwid && smca_banks[bank].hwid->hwid_mcatype != 0)
 		return;
 
 	if (rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_IPID(bank), &low, &high)) {
-- 
2.17.1

