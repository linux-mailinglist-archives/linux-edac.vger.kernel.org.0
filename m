Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCE84C4EE2
	for <lists+linux-edac@lfdr.de>; Fri, 25 Feb 2022 20:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiBYTen (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Feb 2022 14:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbiBYTem (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 25 Feb 2022 14:34:42 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75211AE65C;
        Fri, 25 Feb 2022 11:34:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb2JqrsUX/4GZ2FBZBHTVsaYTy7tLe4Sp9OujEdomx7K3xp8I4voAhethwuWnxypm0ltHgPRaRiFEOMKjYAkpECc5U2QDJtc9yqTaKFZf6q1273+8nwo8vSxVBndOj8a62UQSDJ+mh/TviPMl10Bwn2iKE5GymzZfEEpIgBj/hKWJhMJLKj20ub7Lk+RkoK62tmRqSnJL0/yoxsPDYBggXbmxZXI4vGWSniAn4LWToOBplPnUJj+UQDBgMdDWpWzNl1b9XmzB4B8Pp/ntLh6mO0XvWENU55Y/YtUIumKtP9PCiRnLifPavl4ue+TryagM5r/jq1dEtIThODqfEmxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvxSpxpGoJR1Uc5yf3at7Y/KQxMf0b3grYcKZwQkuII=;
 b=agrFFbpzhcVvoBQSgnuDHGZViAjr5DjREYxDw1xneNkw+uWqTcWdS9PhQf54DKg28y4kZE/jJOvyQyqvm3k+CJlTCXp6SPfyPRw9dcFjj7KA2g0fX8h/YPjleVBKmiRih/25fcnq8YPBoooJJwbN3xFkg0t6EOOkCYikMY8hovZ4j7JnwUrivJV5sxXQppJMsREiSfnK2vBmGn5nMmh8BEJP3Qr6h57Bt4li+6bwtI+6V+v9DhDnKxSso1WsRB0GonHcZ6fywk6DMRmNhUTHvEay9AH8ob+Sne+edqsP80YTYdOaumiU8Yqn00Ev73uGblTxtMfSsp9P8j8gk1wQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvxSpxpGoJR1Uc5yf3at7Y/KQxMf0b3grYcKZwQkuII=;
 b=hb+ZGikGVnKrG0Tkopci5KC2H9RB3Dqkd+fZo0XSvM7gWKcfaDOFxLZGN9a3pvGNCvPew0umweUmyJhEm8M++6zBaapXF4/eNkKijXvB3uV8nhT1fE8iY8pJZhwNWPMoLKstoObIzZZsFeVRycMhwY2Kj9p0uaUdfmiMFn6C3ok=
Received: from MWHPR13CA0046.namprd13.prod.outlook.com (2603:10b6:300:95::32)
 by BN6PR1201MB2545.namprd12.prod.outlook.com (2603:10b6:404:b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 19:34:05 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::59) by MWHPR13CA0046.outlook.office365.com
 (2603:10b6:300:95::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Fri, 25 Feb 2022 19:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 19:34:05 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 13:34:00 -0600
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 3/3] x86/mce: Add support for Extended Physical Address MCA changes
Date:   Fri, 25 Feb 2022 13:33:42 -0600
Message-ID: <20220225193342.215780-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ee05c38-941e-4533-e54a-08d9f895c8d5
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2545:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2545EFA2A886F976AF0F1755903E9@BN6PR1201MB2545.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7Su/6B69JMA9BYbU3whz7fBkGJxMpP/2MUTN9SCY20fo43yOW81MdRUc1AFSxwHXKp2KsoooSLbNH/upP/h8MF+YK0PQIG3JF1SdrIkCwrkxqI+mcVavo7zyExLElyytaIx9CivXMhJPLP2WIc1M3UocQaUc0qeCkS6B1zag/QexbuOaYC1IauC+nBCQXJ+0uZoQr4kqdi3/wVVC3PBdKU45GY6i3cxK/RWydagP1CDGWRtDEXmG+btmN+aA9oaQ5JZfOe3LK3XWS5ttvkdGrxOPQWYxdO+99Ad85CfXuUeVsTjDdfLOwW6Ghq1zc6NTKR2Mz4fWshqO17u13FCVyEf1DgDgnFtPvOZoWRT8SDARNZKKqyOvz2T7oBqOHF7NjP0lz4q4ZTlIIRaLVOsmYIVD01yCT+UdtT0Osj3zxBRLltd4Rf4xRKeOmMIS0pTUQ6Zp9gQPtj9pVtB2eabXJc8m+BqeVI49bGiFGHI0JbijJDY/k38urpjm48qPcQ61jgYwBzG3xND0JfpWryMmA6R4T6FVWHf8t8FuyNYWQ3YkNPIlNL1NUCNKm74mqzeKD4qAU9Syqd9dOihA699SLENmUtaS5X7gWCG0zxJ9c915nGmUBh0sau4O+Wdtfw8AkNeC31emMo5lk1Wq0jjr+VS+Nz6mUmPWIZ2zLZWpcTjT0JXHZvKVhlgr47b7ipNSdTQkCjTle8yqBKFmXE0jBY3vP2mZYB1YMlnqq8DHktZ5SDsS5qaT61sR8ZlRXuKwzeAvhkbJHx6R4YPTf7+8jerksSC6hFgDDXZlPhznNVYtxsJIbM1gI8kRfwBDsbJ0D0+PP//F7BwRciVwtAtNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8936002)(6666004)(7696005)(966005)(5660300002)(40460700003)(508600001)(26005)(1076003)(8676002)(4326008)(2616005)(82310400004)(70206006)(70586007)(16526019)(2906002)(186003)(86362001)(36860700001)(47076005)(356005)(81166007)(83380400001)(36756003)(54906003)(426003)(336012)(316002)(110136005)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 19:34:05.1037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee05c38-941e-4533-e54a-08d9f895c8d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2545
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20220211223442.254489-3-Smita.KoralahalliChannabasappa@amd.com

v2:
	Declared lsb_in_status in existing mce_bank[] struct.
	Moved struct mce_bank[] declaration from core.c -> internal.h
v3:
	Rebased on the latest tip tree. No functional changes.
v4:
	No change.
---
 arch/x86/include/asm/mce.h         |  2 ++
 arch/x86/kernel/cpu/mce/amd.c      | 25 +++++++++++++++++++------
 arch/x86/kernel/cpu/mce/core.c     | 15 ++++-----------
 arch/x86/kernel/cpu/mce/internal.h | 16 ++++++++++++++++
 4 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 99a4c32cbdfa..cc67c74e8b46 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -338,6 +338,7 @@ extern int mce_threshold_remove_device(unsigned int cpu);
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
 enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
 void smca_extract_err_addr(struct mce *m);
+void smca_feature_init(void);
 #else
 
 static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
@@ -345,6 +346,7 @@ static inline int mce_threshold_remove_device(unsigned int cpu)		{ return 0; };
 static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
 static inline void smca_extract_err_addr(struct mce *m) { }
+static inline void smca_feature_init(void) { }
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 981d718851a2..ed75d4bd2aff 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -724,9 +724,26 @@ bool amd_mce_is_memory_error(struct mce *m)
 
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
@@ -743,10 +760,6 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
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
index 313058dc129f..5cf753493d77 100644
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
@@ -641,10 +635,6 @@ static noinstr void mce_read_aux(struct mce *m, int i)
 			m->addr <<= shift;
 		}
 
-		/*
-		 * Extract [55:<lsb>] where lsb is the least significant
-		 * *valid* bit of the address bits.
-		 */
 		if (mce_flags.smca)
 			smca_extract_err_addr(m);
 	}
@@ -1948,6 +1938,9 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
 		mce_flags.amd_threshold	 = 1;
+
+		if (mce_flags.smca)
+			smca_feature_init();
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 3efb5037c364..0b12fe528e1b 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -178,6 +178,22 @@ struct mce_vendor_flags {
 
 extern struct mce_vendor_flags mce_flags;
 
+struct mce_bank {
+	u64			ctl;			/* subevents to enable */
+
+	__u64 init			: 1,		/* initialise bank? */
+
+	/*
+	 * (AMD) MCA_CONFIG[McaLsbInStatusSupported]: This bit indicates
+	 * the LSB field is found in MCA_STATUS, when set.
+	 */
+	      lsb_in_status		: 1,
+
+	      __reserved_1		: 62;
+};
+
+DECLARE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
+
 enum mca_msr {
 	MCA_CTL,
 	MCA_STATUS,
-- 
2.17.1

