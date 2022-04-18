Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2513D505DA6
	for <lists+linux-edac@lfdr.de>; Mon, 18 Apr 2022 19:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347213AbiDRRrn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Apr 2022 13:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347206AbiDRRrj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Apr 2022 13:47:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C428E63A0;
        Mon, 18 Apr 2022 10:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zff83eCd9t8h7dqmga4PnMskS32ZR7+A5DBb5KO52I7kHURC1CfIkra5XLu8SNWcboxu3qX+IZtCGtDwG4UgLfO8rf9Bw58Y7kg/RoIhGlF1wm/sIlYhZ/RmOoaNS/xRZ8ISH7/8WR8/5pH056Ud/0r77EE3HGEDMeYgGuozCNJFrVQz6BE7CP78kjpSGmEieWvhijzWxaUUqBnivWhcGACg75KV2CGw5qymDsPgvt7iHExNHTkyEhZlmrHeXUgCsgRRPXXrjSExjoDHJkNImbyHjgiUZTeRjfOxUxYQy6tK+zFd1W8qhLWMHF8CuvDW4dCRR98yRn4dKtBz8YqMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TGEbumOgxkG9lgn+8WRgHmcJsgJp5d1EL1MC4FwZAc=;
 b=T1zEHrFTnSyQguJr8E8Os2WifITgC/53fTzEtN8p/zytKg59bX4g8eAf0/oPxmN0XhYj4fN7PP29tzkREPVMVJ8Jo1aRJQWor2XQIz5rb0DmTI7vvL4TeNgCi0AwEqCIfC/0KIeZCQNVRvMz9GrfmtUP3jINHQOCDYT5weDrC+8CScQMEK2BaooZg6dCsNeJy1WfqB8Gd26V/GPg62lEguRPCOikn8Z+1BBx4Tb0LgA4NBclsjikThP00onOG5k+JvJMi+U7vIgGhERbi0700wd6o78S7E+vb7F9SKUL/VhMm5P+f686mIza5nIqxSTFjKFiciYp3xejPZzy/Cusnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TGEbumOgxkG9lgn+8WRgHmcJsgJp5d1EL1MC4FwZAc=;
 b=d11f3qGMSXxPd7lS1rq02+/Yho06PzXzgOmn9vkZoYFYHnX3kgT5mJZCtM1tcjq2gnudjB361LtaxgE7lidZ79A4YombksvUUPp0QXtHj8AXXy+qkJYMVrMk6PUm6mbj08qh0G0E9p06Le7oY13Nb7qObo5tWtsYgPS9rPUnoQE=
Received: from MW4PR03CA0045.namprd03.prod.outlook.com (2603:10b6:303:8e::20)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 17:44:58 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::c4) by MW4PR03CA0045.outlook.office365.com
 (2603:10b6:303:8e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Mon, 18 Apr 2022 17:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Mon, 18 Apr 2022 17:44:56 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 12:44:55 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers
Date:   Mon, 18 Apr 2022 17:44:38 +0000
Message-ID: <20220418174440.334336-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418174440.334336-1-yazen.ghannam@amd.com>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eb86b02-ade5-4a8c-aecb-08da21632756
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4501B1372C6321FA364EEE65F8F39@MN2PR12MB4501.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rHTpKtLvUZEtRIFD8SRZFhgtDi+8N8emPKpYjHpeB4xVTz96MHOjMSD6CgPOPxGodi5LGDDrf2WMKtF5iv1FEdpmX4j+yde/o57FBzIpGv1iZhSKwJlmoIaMv3RvjXzbWXPYKidS685mEicADYdXn5kb3ywb3iLG45lozi7fm8tg09lzpehAt6MjjKd4BUqeIQd+98F3nMES6pQ4pI9vBQEM+CapZyqt/bY1ie9pkrrVnXFSWlY0mX21UUZjyBRhsdxkXqlPHUAlmMVKk/Dv0ZHYUHCuinw8RMmy5RKyjKij3GXat/Yp0F8T5vjTyH6Pls1NkdEGrySAhV+rKqlfYY4S4VwMiutnmuXerHqApcvNgFnz4E0D3sORIL+vlyZULpgwHyTB4LFT2nRW4zW8sPckYSN5XvdCc25IsLz9eMbvGAV7gov3AIDSvJDTMR/z9JVGsAcFvAtxmTzZasMnVrdWSZj6ZdlCO03Lm0pLfpmTHyo0LiR8MJdf4rJG/x+KaC99RSRgU5yGqYuwu+4awf7agvHuHMR6UZuWA34hWj2C18ejPY62UwvElcr2XEjhcVzb++9yoGV79+dqkUgehOpLB87adluTIsVyPPH+y1kXmdpkcBcjL62rsWyxosO1DHNMottMmRwivWP1o5+6KYLCgTbkKU2lo3ed4a3c/KiB9lwIRb+3545SQt0a9gp/xoPKf/IIE8wIEQ2TidT+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(44832011)(36860700001)(426003)(316002)(26005)(186003)(2616005)(1076003)(6666004)(8936002)(54906003)(6916009)(4326008)(70206006)(5660300002)(70586007)(8676002)(2906002)(336012)(83380400001)(82310400005)(36756003)(16526019)(508600001)(40460700003)(86362001)(7696005)(356005)(81166007)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 17:44:56.9630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb86b02-ade5-4a8c-aecb-08da21632756
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Future Scalable MCA systems will include two new registers: MCA_SYND1
and MCA_SYND2.

These registers will include supplemental error information in addition
to the existing MCA_SYND register. The data within the registers is
considered valid if MCA_STATUS[SyndV] is set.

Add fields for these registers in struct mce. Save and print these
registers wherever MCA_STATUS[SyndV]/MCA_SYND is currently used.

Note: Checkpatch warnings/errors are ignored to maintain coding style.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h      | 5 +++++
 arch/x86/include/uapi/asm/mce.h | 2 ++
 arch/x86/kernel/cpu/mce/amd.c   | 5 ++++-
 arch/x86/kernel/cpu/mce/core.c  | 9 ++++++++-
 drivers/edac/mce_amd.c          | 7 +++++--
 include/trace/events/mce.h      | 7 ++++++-
 6 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cc73061e7255..25e3e2bc8c0a 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -116,6 +116,9 @@
 #define MSR_AMD64_SMCA_MC0_DESTAT	0xc0002008
 #define MSR_AMD64_SMCA_MC0_DEADDR	0xc0002009
 #define MSR_AMD64_SMCA_MC0_MISC1	0xc000200a
+/* Registers MISC2 to MISC4 are at offsets B to D. */
+#define MSR_AMD64_SMCA_MC0_SYND1	0xc000200e
+#define MSR_AMD64_SMCA_MC0_SYND2	0xc000200f
 #define MSR_AMD64_SMCA_MCx_CTL(x)	(MSR_AMD64_SMCA_MC0_CTL + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_STATUS(x)	(MSR_AMD64_SMCA_MC0_STATUS + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_ADDR(x)	(MSR_AMD64_SMCA_MC0_ADDR + 0x10*(x))
@@ -126,6 +129,8 @@
 #define MSR_AMD64_SMCA_MCx_DESTAT(x)	(MSR_AMD64_SMCA_MC0_DESTAT + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_DEADDR(x)	(MSR_AMD64_SMCA_MC0_DEADDR + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_MISCy(x, y)	((MSR_AMD64_SMCA_MC0_MISC1 + y) + (0x10*(x)))
+#define MSR_AMD64_SMCA_MCx_SYND1(x)	(MSR_AMD64_SMCA_MC0_SYND1 + 0x10*(x))
+#define MSR_AMD64_SMCA_MCx_SYND2(x)	(MSR_AMD64_SMCA_MC0_SYND2 + 0x10*(x))
 
 #define XEC(x, mask)			(((x) >> 16) & mask)
 
diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index db9adc081c5a..e77663a4abfa 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -36,6 +36,8 @@ struct mce {
 	__u64 ppin;		/* Protected Processor Inventory Number */
 	__u32 microcode;	/* Microcode revision */
 	__u64 kflags;		/* Internal kernel use */
+	__u64 synd1;		/* MCA_SYND1 MSR: only valid on SMCA systems */
+	__u64 synd2;		/* MCA_SYND2 MSR: only valid on SMCA systems */
 };
 
 #define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1c87501e0fa3..23e34e5be7ed 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -750,8 +750,11 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	if (mce_flags.smca) {
 		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m.ipid);
 
-		if (m.status & MCI_STATUS_SYNDV)
+		if (m.status & MCI_STATUS_SYNDV) {
 			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m.synd);
+			rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(bank), m.synd1);
+			rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(bank), m.synd2);
+		}
 	}
 
 	mce_log(&m);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d775fcd74e98..28e7a3c9ecfe 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -190,6 +190,10 @@ static void __print_mce(struct mce *m)
 	if (mce_flags.smca) {
 		if (m->synd)
 			pr_cont("SYND %llx ", m->synd);
+		if (m->synd1)
+			pr_cont("SYND1 %llx ", m->synd1);
+		if (m->synd2)
+			pr_cont("SYND2 %llx ", m->synd2);
 		if (m->ipid)
 			pr_cont("IPID %llx ", m->ipid);
 	}
@@ -647,8 +651,11 @@ static noinstr void mce_read_aux(struct mce *m, int i)
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
 
-		if (m->status & MCI_STATUS_SYNDV)
+		if (m->status & MCI_STATUS_SYNDV) {
 			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
+			m->synd1 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(i));
+			m->synd2 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(i));
+		}
 	}
 }
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index cc5c63feb26a..28b48c711fe0 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1291,8 +1291,11 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		pr_emerg(HW_ERR "IPID: 0x%016llx", m->ipid);
 
-		if (m->status & MCI_STATUS_SYNDV)
-			pr_cont(", Syndrome: 0x%016llx", m->synd);
+		if (m->status & MCI_STATUS_SYNDV) {
+			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
+			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
+					m->synd1, m->synd2);
+		}
 
 		pr_cont("\n");
 
diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 1391ada0da3b..a6826c34a185 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -22,6 +22,8 @@ TRACE_EVENT(mce_record,
 		__field(	u64,		addr		)
 		__field(	u64,		misc		)
 		__field(	u64,		synd		)
+		__field(	u64,		synd1		)
+		__field(	u64,		synd2		)
 		__field(	u64,		ipid		)
 		__field(	u64,		ip		)
 		__field(	u64,		tsc		)
@@ -42,6 +44,8 @@ TRACE_EVENT(mce_record,
 		__entry->addr		= m->addr;
 		__entry->misc		= m->misc;
 		__entry->synd		= m->synd;
+		__entry->synd1		= m->synd1;
+		__entry->synd2		= m->synd2;
 		__entry->ipid		= m->ipid;
 		__entry->ip		= m->ip;
 		__entry->tsc		= m->tsc;
@@ -55,12 +59,13 @@ TRACE_EVENT(mce_record,
 		__entry->cpuvendor	= m->cpuvendor;
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, SYND1/SYND2: %016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
 		__entry->ipid,
 		__entry->addr, __entry->misc, __entry->synd,
+		__entry->synd1, __entry->synd2,
 		__entry->cs, __entry->ip,
 		__entry->tsc,
 		__entry->cpuvendor, __entry->cpuid,
-- 
2.25.1

