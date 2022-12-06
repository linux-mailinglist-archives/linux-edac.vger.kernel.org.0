Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D94644A70
	for <lists+linux-edac@lfdr.de>; Tue,  6 Dec 2022 18:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiLFRhV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Dec 2022 12:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbiLFRgp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 6 Dec 2022 12:36:45 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C562C3C6D7;
        Tue,  6 Dec 2022 09:36:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbuDN7r5zgL2zWxcQHFahtriwqxVT9xCISP2nTi29WPqe9CEja1Dz4VyflJg1L89c8bV6B46F0Et4aLTYnE1/fHWBxQaO0ogSyUtPsYPCiF1TkgqSTDahyUOdds72oH7GLIAPh9hx1ZqmAUAIvhwVNAUSWODCINwrsnoP4fkRka5fLzvHCRzgoVdl+UtjF1JoxyJLMuqltZ9ek9aVKVHMjhYS4EPg/Cx7069XNwZhc+1xVITm8cXfMM/C4AnhEk+HCZBACeaSQ6A35C/QWyxcCWsChO+zcbWke8On7nnqAh/ZgfyF8gWR8rV1Jt0rwElfJLWzbKZnvP5iXHcPu9dLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peZArhzZiIuSW/W7Oskw9Y9ta5KlclwJewQT4DBQuF8=;
 b=FVHuznbgwCWI26hwFcXvUrpdph8IG/lPxLVKyo1x6zEBda0x9Y9L5qzsTYsPNRBcHBIjYiIEC5o9vqPD1KL6pIhj1Svcrl1r4K0YSLysyFhaDmAqUoKTTXorbXjp+O2QmL7aoNNlKqEuxMfAjbdsqlR4Rq2phPQWPscTRkWicpE6IMevEq2geW8z+yJO3to5UMiwMHxzQMcYFpFGWPFWH7VLoAEMryOn3M1NQrCF9uFBU0I/mFzH+8Y7Ma4aGCCkT64X2eIMchSGFhs5JHsGDU/kWlha7SkLnu7PraPY4n+PQdAfbh9uFSYsZ5hIelhNjFSs2Kz3n8rPihybNpo4QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peZArhzZiIuSW/W7Oskw9Y9ta5KlclwJewQT4DBQuF8=;
 b=t7kILgLzs6ycEbCgCnGSPmC46cUjDoiB6Kndo4G8MugdJ6sAT4Nhw9H7uA27efQxBKApu/1laqm5Ght95vtr1H0clePfLsqKCMm5MdNeO2RvyH+ITw+a0h7StPj5s15CnBB653DwsueyUdudcacfWdb8xCLmaEnSnv1E2QGDPe8=
Received: from MW4PR04CA0233.namprd04.prod.outlook.com (2603:10b6:303:87::28)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 6 Dec
 2022 17:36:24 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::50) by MW4PR04CA0233.outlook.office365.com
 (2603:10b6:303:87::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 17:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Tue, 6 Dec 2022 17:36:23 +0000
Received: from titanite-35bahost.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 11:36:19 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v6 4/4] x86/mce: Add support for Extended Physical Address MCA changes
Date:   Tue, 6 Dec 2022 11:36:07 -0600
Message-ID: <20221206173607.1185907-5-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206173607.1185907-1-yazen.ghannam@amd.com>
References: <20221206173607.1185907-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b3b745-d666-4c11-1289-08dad7b06510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTdhXGNawvjZ4sknIYZR0JEnLDS1TIfclmmZ5d6JxXuCxlZHMePSt44pSbMp/mq2Qu9Z19pXhYksfqHFpkno538j0T4SYHGFw1DHeeUJedh5+nz7Vx9NzOGFaRSSnBqjKx4nNOiNbr7ou9U6taw7nRXGI5KTHJqxeGtBlT3D9qwcG57uWO3otTQ12CLOV+4f6bAgI3OvTYgzFKgUjp4G+zvkhJw+5Y2vKDd0ekaPcNit09Gr7rc+0PCUciA+X0TcGr7eS9JkQJq+QufwNW5FOhzJG3vbWYL8v3zAUPjaXJYw0oPoPSd2TTX08IcKupQJcsBUExPK6mpjDtFthKgwHic0aqVkyoDVhW/7reryPgmhjG3y2oK5xtUShkdpvTHJIOAH87RZyGn+bSYXfhjK7ZOXBbOdBHxdNwzHrfZ53o9/4rbbjM8gbTDgnPUY+L0nU832HhSWifamD5CHXwaPhLVeOtJalg7jUrgjoH0/547KnQmC6zzGTD+Edy3DWB63Gn9ELQ29Z9l+MssAP38MhcYGKNDBApj9j+kkihk2uqpGtqCL9QFM2NUHZw1LXZg+d0T471oWiHBSAFMGPO32pbGDQjoxrCJITjsJKbc7zqVCW8BWaTDox2aqsJFlvOQT6xDfhSo80hvpizTnX7Qfws6BJZI2ljHMCouMQ2Ao3t/635net9VaRiKJeMiooMe33kDDPd1+9B5IWVbYFbxxfq57FBoZQYW/sqjrv72z2d4Xhn8YAN7F0hnFP2abgjxR0ntqE+tv8cOqorPG42ffsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(83380400001)(86362001)(36756003)(44832011)(47076005)(426003)(966005)(82740400003)(41300700001)(40460700003)(2906002)(54906003)(186003)(16526019)(5660300002)(40480700001)(4326008)(7696005)(1076003)(336012)(6666004)(26005)(82310400005)(8936002)(316002)(478600001)(2616005)(6916009)(8676002)(70586007)(70206006)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 17:36:23.4552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b3b745-d666-4c11-1289-08dad7b06510
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Newer AMD CPUs support more physical address bits.

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

Additionally, all MCA banks do not support maximum ErrorAddr bits in
MCA_ADDR. Some banks might support fewer bits but the remaining bits are
marked as reserved.

[Yazen: Rebased and fixed up formatting.]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Link:
https://lore.kernel.org/r/20220412154038.261750-3-Smita.KoralahalliChannabasappa@amd.com

v2:
	Declared lsb_in_status in existing mce_bank[] struct.
	Moved struct mce_bank[] declaration from core.c -> internal.h
v3:
	Rebased on the latest tip tree. No functional changes.
v4:
	No change.
v5:
	Extend comment for smca_extract_err_addr if AddrLsb is found in
	MCA_STATUS registers.
v6:
	Rebase and fix up formatting.

 arch/x86/kernel/cpu/mce/amd.c      |  2 ++
 arch/x86/kernel/cpu/mce/core.c     |  8 +-------
 arch/x86/kernel/cpu/mce/internal.h | 31 +++++++++++++++++++++++++++++-
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 85977ca07825..d4ec9b3481b8 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -306,6 +306,8 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		if ((low & BIT(5)) && !((high >> 5) & 0x3))
 			high |= BIT(5);
 
+		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
+
 		wrmsr(smca_config, low, high);
 	}
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 757cc46298d3..8b67e0284564 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -67,13 +67,7 @@ DEFINE_PER_CPU(unsigned, mce_exception_count);
 
 DEFINE_PER_CPU_READ_MOSTLY(unsigned int, mce_num_banks);
 
-struct mce_bank {
-	u64			ctl;			/* subevents to enable */
-
-	__u64 init			: 1,		/* initialise bank? */
-	      __reserved_1		: 63;
-};
-static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
+DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
 
 #define ATTR_LEN               16
 /* One object for each MCE bank, shared by all CPUs */
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 6dcb94fe0f65..867bcf9ee424 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -177,6 +177,24 @@ struct mce_vendor_flags {
 
 extern struct mce_vendor_flags mce_flags;
 
+struct mce_bank {
+	/* subevents to enable */
+	u64			ctl;
+
+	/* initialise bank? */
+	__u64 init		: 1,
+
+	/*
+	 * (AMD) MCA_CONFIG[McaLsbInStatusSupported]: This bit indicates
+	 * the LSB field is found in MCA_STATUS, when set.
+	 */
+	lsb_in_status		: 1,
+
+	__reserved_1		: 62;
+};
+
+DECLARE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
+
 enum mca_msr {
 	MCA_CTL,
 	MCA_STATUS,
@@ -190,7 +208,10 @@ extern bool filter_mce(struct mce *m);
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
 
-/* Extract [55:<lsb>] where lsb is the LS-*valid* bit of the address bits. */
+/*
+ * If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits
+ * [56:0], else in bits [55:0] of MCA_ADDR.
+ */
 static __always_inline void smca_extract_err_addr(struct mce *m)
 {
 	u8 lsb;
@@ -198,6 +219,14 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 	if (!mce_flags.smca)
 		return;
 
+	if (this_cpu_ptr(mce_banks_array)[m->bank].lsb_in_status) {
+		lsb = (m->status >> 24) & 0x3f;
+
+		m->addr &= GENMASK_ULL(56, lsb);
+
+		return;
+	}
+
 	lsb = (m->addr >> 56) & 0x3f;
 
 	m->addr &= GENMASK_ULL(55, lsb);
-- 
2.34.1

