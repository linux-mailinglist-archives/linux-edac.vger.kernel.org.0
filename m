Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622BD2AC695
	for <lists+linux-edac@lfdr.de>; Mon,  9 Nov 2020 22:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbgKIVGh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Nov 2020 16:06:37 -0500
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63]:20800
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729831AbgKIVGg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 9 Nov 2020 16:06:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsZa2KnT0F7zsBddefRedcxJdAVE4TmsOMCwY1wImfPaXnD1jYQqtfLJyjcp/+Tg/x3yx1G8mBTTuG/XovwMBO1z81DoLmYqkjFAVZHUH7oD4nepLkqI+EYYwxpi/DCk4kQb+uh7PPDbNBHV+d00d/1X2vDfOcvuIbKqBsyyS5Sz1hXnZqn4YBMmL0eqqQW+YPQ2ZBW42Joc4DrGbUtSUb4UDoATEUPOGA68ZY/+o3vJdvSjXWN55xGaXyU/CCyDonaGix5PjO7PgJXODVcXSETioOvrE120+E24yLtfv888reiaWUx/fK9Q7ziACtn1aJjE2Hc2YQ5nSkZ+V/Y3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/izghzq9+XlcnxJMMh82NfStDWziwc9cHo5uheio5w=;
 b=nrheLTv11M8b68lRer0fTdMjk8026SHd8zbzobxowba44quySUv57fWLFDVg/TdfueYSx1qOappSAIfTkFJH6/kDDe4dKPwqyPqP5e+R3Z/3XvSCUpI3KfsKdKTyH+lMlPnGR8+Fynj3jLVgL0jM9pIcUx30HdLDwDRIk+2aJP/d0vWCurMeBg5tlzdGQU+Chk58nkpo863HLRSqd02fl3sCgEYk4kKFABWHJHc82o6MaoCsCrijBA/EJGLZ9RPjaxTeFfxbGJBNT8Qxque5M7litbCkhYk79mFoIH4+txB2N1vCpe05HsSma1J8phNFqyiEl6qY2+nWY4pPm6yyRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/izghzq9+XlcnxJMMh82NfStDWziwc9cHo5uheio5w=;
 b=zPRCxx1ABCISfadBME0tbPjicRsW7qKz98dG834EtOPcpnaQT9PZuEMbD3IaKdUa7wTuVF4j8q/9Ej0MJReqWnAxbr2hM8BGkDh+hs6Ci5Gos6grWKEPBal6H8SumfWe/Zhr7Giogl1mqcJNGtRPl7Bgc0lItSqhtfJtA1YORLs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2979.namprd12.prod.outlook.com (2603:10b6:408:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 21:06:30 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d%5]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 21:06:30 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     x86@kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, linux-edac@vger.kernel.org,
        puwen@hygon.cn, kim.phillips@amd.com, thomas.lendacky@amd.com,
        wei.huang2@amd.com
Subject: [PATCH 1/4] x86/CPU/AMD: Save AMD NodeId as cpu_die_id
Date:   Mon,  9 Nov 2020 21:06:56 +0000
Message-Id: <20201109210659.754018-2-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109210659.754018-1-Yazen.Ghannam@amd.com>
References: <20201109210659.754018-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: DM5PR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:3:103::26) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.78.2) by DM5PR12CA0064.namprd12.prod.outlook.com (2603:10b6:3:103::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 21:06:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d583eb7-cd92-4806-0431-08d884f35211
X-MS-TrafficTypeDiagnostic: BN8PR12MB2979:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB29799920033022DAE397B348F8EA0@BN8PR12MB2979.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XpaHyyprFOzdnin63qr+OJ43JvWnGINsIqgLcy7Fp/XmmnCfggWz1H5dYloHCgEqmAwUYP4/DiI355vcUTRjGHkuKQtVSdZJjbFFMKAgaZ8nqR/21mf7+wKIlDzFi9KYs709RO2i6RVJbP0mJSgIUWPRIEMWTeFNyQ8Qe1njdsJUCy5SzT8+T/iCbK/7xUeTQUbP/AexMZXtyMSf2guxx5DcyaplIfD2X5q30whXBt5DwtqRqsTJFFYM3KcQvyiIEufsWRvC8j4A2Qc6bxhj+Q3RSYnODpaA1DjEdteqaqT38kqnKdAT4HIk5Abdrc/Mr3C1vYDEH+Vaqt03pUcb7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(6486002)(26005)(66946007)(5660300002)(186003)(16526019)(4326008)(1076003)(8936002)(2906002)(83380400001)(66556008)(66476007)(6666004)(36756003)(478600001)(86362001)(316002)(6916009)(2616005)(8676002)(956004)(52116002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qRagvZtKTgwCdOh2ZEUleJRARjUSmsP3COz2L1pmn/o4i4EVgX4yk3TMY5pRdaBmeQKqCiNYFOLyd3soKhU1+N+tltB7CicLlp9KbHEo3A1MuAJm7dcJ8U9Ti5LM1vrRThNPnsIcz6k2idlFMQ6aWgHaSsPO7nubdx6YaBjtosImi2dKDfh3GuyAf9LrbcPt/0zIZREg8VD8VBdbnKHo4V39vdtpl0GveZsld44tdWaYafaVN2nVLf4bN1V5YqQlug7frt+5tOcmfVGL3QyzjT5d4O4BwvRpx2PVP4i477WdK/acwGCnkPq8/pDOCPEK6QTsHXdAeL6MftxapKaxLA7NHtd6ATb5gmjy8/BgPHE9RG1M2C2gOMB2JyVhxQG12hsPOX4GD2gsV0CDNt4YcO+YGB1hO1gAKDx4+/p/M7uAr7K+9lIVu9S5/+J8z8mzv8unzvqRYQAhB/9d4n3YFXIVfYt45pY4I2MiaaAnHLfffUx62/6kyvPeVwzhITBpb+iH6sPbQds+PBXCmS4vDOppsN1djkyZhJLlVq/YGohe3nb7F9eBTHOsJ05R238xdeY0XDt+jSdaMyXl5ummWvTUkqkh9UZEya1MQura4cAhjcVFm/4fCIl7vejwXxaB4cfoG6XFWbZdz4wymS3HXg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d583eb7-cd92-4806-0431-08d884f35211
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 21:06:29.7410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaC/PyfjlMxZ7raYderZUxWuEh8bSSb/8tc4g4YBxAC+K0NtrxXOwdbXw/hnKfnRNzpBiZ5MnDe/hYt0LdYN0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2979
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

AMD systems provide a "NodeId" value that represents a global ID
indicating to which "Node" a logical CPU belongs. The "Node" is a
physical structure equivalent to a Die, and it should not be confused
with logical structures like NUMA nodes. Logical nodes can be adjusted
based on firmware or other settings whereas the physical nodes/dies are
fixed based on hardware topology.

The NodeId value can be used when a physical ID is needed by software.

Save the AMD NodeId to struct cpuinfo_x86.cpu_die_id. Use the value
from CPUID or MSR as appropriate. Default to phys_proc_id otherwise.
Do so for both AMD and Hygon systems.

Drop the node_id parameter from cacheinfo_*_init_llc_id() as it is no
longer needed.

Update the x86 topology documentation.

[ Use cpu_die_id. ]
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 Documentation/x86/topology.rst   |  9 +++++++++
 arch/x86/include/asm/cacheinfo.h |  4 ++--
 arch/x86/kernel/cpu/amd.c        | 11 +++++------
 arch/x86/kernel/cpu/cacheinfo.c  |  6 +++---
 arch/x86/kernel/cpu/hygon.c      | 11 +++++------
 5 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
index e29739904e37..7f58010ea86a 100644
--- a/Documentation/x86/topology.rst
+++ b/Documentation/x86/topology.rst
@@ -41,6 +41,8 @@ Package
 Packages contain a number of cores plus shared resources, e.g. DRAM
 controller, shared caches etc.
 
+Modern systems may also use the term 'Die' for package.
+
 AMD nomenclature for package is 'Node'.
 
 Package-related topology information in the kernel:
@@ -53,11 +55,18 @@ Package-related topology information in the kernel:
 
     The number of dies in a package. This information is retrieved via CPUID.
 
+  - cpuinfo_x86.cpu_die_id:
+
+    The physical ID of the die. This information is retrieved via CPUID.
+
   - cpuinfo_x86.phys_proc_id:
 
     The physical ID of the package. This information is retrieved via CPUID
     and deduced from the APIC IDs of the cores in the package.
 
+    Modern systems use this value for the socket. There may be multiple
+    packages within a socket. This value may differ from cpu_die_id.
+
   - cpuinfo_x86.logical_proc_id:
 
     The logical ID of the package. As we do not trust BIOSes to enumerate the
diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index 86b63c7feab7..86b2e0dcc4bf 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_CACHEINFO_H
 #define _ASM_X86_CACHEINFO_H
 
-void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
-void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu);
+void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 
 #endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 6062ce586b95..2f1fbd8150af 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -330,7 +330,6 @@ static void legacy_fixup_core_id(struct cpuinfo_x86 *c)
  */
 static void amd_get_topology(struct cpuinfo_x86 *c)
 {
-	u8 node_id;
 	int cpu = smp_processor_id();
 
 	/* get information required for multi-node processors */
@@ -340,7 +339,7 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 
 		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
 
-		node_id  = ecx & 0xff;
+		c->cpu_die_id  = ecx & 0xff;
 
 		if (c->x86 == 0x15)
 			c->cu_id = ebx & 0xff;
@@ -360,15 +359,15 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
-		cacheinfo_amd_init_llc_id(c, cpu, node_id);
+		cacheinfo_amd_init_llc_id(c, cpu);
 
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		node_id = value & 7;
+		c->cpu_die_id = value & 7;
 
-		per_cpu(cpu_llc_id, cpu) = node_id;
+		per_cpu(cpu_llc_id, cpu) = c->cpu_die_id;
 	} else
 		return;
 
@@ -393,7 +392,7 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 	/* Convert the initial APIC ID into the socket ID */
 	c->phys_proc_id = c->initial_apicid >> bits;
 	/* use socket ID also for last level cache */
-	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
+	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->phys_proc_id;
 }
 
 static void amd_detect_ppin(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 57074cf3ad7c..f9ac682e75e7 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -646,7 +646,7 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	return i;
 }
 
-void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu)
 {
 	/*
 	 * We may have multiple LLCs if L3 caches exist, so check if we
@@ -657,7 +657,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
 
 	if (c->x86 < 0x17) {
 		/* LLC is at the node level. */
-		per_cpu(cpu_llc_id, cpu) = node_id;
+		per_cpu(cpu_llc_id, cpu) = c->cpu_die_id;
 	} else if (c->x86 == 0x17 && c->x86_model <= 0x1F) {
 		/*
 		 * LLC is at the core complex level.
@@ -684,7 +684,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
 	}
 }
 
-void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
+void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu)
 {
 	/*
 	 * We may have multiple LLCs if L3 caches exist, so check if we
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index ac6c30e5801d..dc0840aae26c 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -65,7 +65,6 @@ static void hygon_get_topology_early(struct cpuinfo_x86 *c)
  */
 static void hygon_get_topology(struct cpuinfo_x86 *c)
 {
-	u8 node_id;
 	int cpu = smp_processor_id();
 
 	/* get information required for multi-node processors */
@@ -75,7 +74,7 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 
 		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
 
-		node_id  = ecx & 0xff;
+		c->cpu_die_id  = ecx & 0xff;
 
 		c->cpu_core_id = ebx & 0xff;
 
@@ -93,14 +92,14 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 		/* Socket ID is ApicId[6] for these processors. */
 		c->phys_proc_id = c->apicid >> APICID_SOCKET_ID_BIT;
 
-		cacheinfo_hygon_init_llc_id(c, cpu, node_id);
+		cacheinfo_hygon_init_llc_id(c, cpu);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		node_id = value & 7;
+		c->cpu_die_id = value & 7;
 
-		per_cpu(cpu_llc_id, cpu) = node_id;
+		per_cpu(cpu_llc_id, cpu) = c->cpu_die_id;
 	} else
 		return;
 
@@ -123,7 +122,7 @@ static void hygon_detect_cmp(struct cpuinfo_x86 *c)
 	/* Convert the initial APIC ID into the socket ID */
 	c->phys_proc_id = c->initial_apicid >> bits;
 	/* use socket ID also for last level cache */
-	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
+	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->phys_proc_id;
 }
 
 static void srat_detect_node(struct cpuinfo_x86 *c)
-- 
2.25.1

