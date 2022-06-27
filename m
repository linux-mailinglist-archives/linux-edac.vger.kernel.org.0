Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6A55D386
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jun 2022 15:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiF0U5N (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jun 2022 16:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiF0U5M (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Jun 2022 16:57:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A085F46;
        Mon, 27 Jun 2022 13:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2mwUJhk47zp7yt1tEKNg8Idy/vLlk1INZBUMJFtfvojDpTUz7uw5gUuu86TjXl9drgOggLng/6mYzScTCnhT0IrA041mZEOrPUqntPeiKdrZ7xorq9Er1SO28R+9qokJqwbGa8TD/ldP5IBrv4E90SYr3140z3gbRUMXYI5mY5AmZpNasqcyxCZYetEZzwWDQgvFrlWlPPJWv9bJafquROEzYh9IR9Ypk2I7BrLs5RH8IXvu+EKQfO2C+vO68MWYolfOraBTQXNa3TlV/vrVubBzJ0y3KJcAP42TQvqHvm4Wjvasd1YhpWmMgl4DIoeLXKpta4y1U5vBob05D4dMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXUDY8ZtlrgSI59xfsS7SFji4sZ85KjOGuBN9S46eWA=;
 b=FgIuoiEfy8ZSYG4rRwzIYKDQcApbxENl9O/hSmPTB6uzOZNOp2FQOT8edSkUV3IUhl0vaZdbtsJ9vhkGUR0ZDaZO4S5ZdfHnoNGdAjdFcCx8AYhJWDiF5EAeqk7Mcn8wNrq4LWLkptLn0c9c8XHHAlMKlr2PWKijNz2d+m/Uq7fZmX7CzY9oeXXfphR72MAMj+5hYH9cFf7KAGbEmskKRE2EnKPyN+5PL683pocbx8PfDQMf8LSz6ZcIyiZhIE3loHndBuqdNRbWnmGyR8unwWfTIIls+s0lpqvfoQbLD9Bp+PJ0wqpPIiFIjcW9LCOeW1CcihT35fUmfAtTzQn5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXUDY8ZtlrgSI59xfsS7SFji4sZ85KjOGuBN9S46eWA=;
 b=g3ixWagmfwMa0AdNEca524w7DowIJjMcD1B9kFEP0Jcsxf3QBg8WmwmIM8YMaDaT8IJm7Cx6C97JcTaeYZv0enY2q7Gn5dftlKvyng4IGQTF2mayGET5Lz3StcUBnZtqN7Ea+CeeNAfQWKuFIGMXp290xyHGSioHPVibdQh7s5g=
Received: from BN8PR12CA0023.namprd12.prod.outlook.com (2603:10b6:408:60::36)
 by BY5PR12MB3649.namprd12.prod.outlook.com (2603:10b6:a03:1ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 20:57:08 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::92) by BN8PR12CA0023.outlook.office365.com
 (2603:10b6:408:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Mon, 27 Jun 2022 20:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 20:57:07 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 15:57:03 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Smita Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH] x86/mce: Check whether writes to MCA_STATUS are getting ignored
Date:   Mon, 27 Jun 2022 20:56:46 +0000
Message-ID: <20220627205646.4692-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b72edb1-1096-49e4-f368-08da587f992e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3649:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yq5hRQKpY/pbbnx/3IykDOaqS4ejURHC7ke1wBAkmpMecJHywoqA1jJCmeucXwBbK+/c7mbLuiOlEvPUhfWnQny9kzu39H9xwyjzSMmvXPt8SEpOZSQJ1IqFC81/Kf/WRX+D98jstrPTk2IjBqlI76mYHX9igK2RhY0uAv4iO6XVcnlHlfO5p2lN5EQhZahmdlL0vt/JmMASfKZtO4m4NDwSBWpHGnnVyZYIq5ZnbQDlP7C4pvm+hdZBsGCo+Esx1pNDbrEOhLaQOsSOEWbfZzmnmBjMNg+XgGIzIcdzFwXnPMYUl4rsmkL0wjbLlqKiJAH6mKkM2A/ovOMF9Xn1OqDsrccW6qdc/T7oIvFMBei+phnNWGHyNHngRYhUTrzKcy0vV0i4bBDvFFxCkwUUfQrgKlKmpHraX8E1czZ5xmafGO4t2mhSVBfdqYpApu9TtGTEDaOYJ8x1RQI+myoL47qdpK9Luq9mygHgRcoc/t86bjcl7TvLSHEN8nJjj26dh3bkgc9/AZ5KI9FDTy/eZ/Ec50/CljceTbvXIl2RWnuIbTLHIWP9fV9AsfhFavbbsfEWHbRzjJvj2dW/5EvONVxEyn3mPj0pm/zKaUCP20WeHfXRXatD7wIvburofRe9EuHeQbXQOXL/55eb50aLfC+fQ/WQaUpIrRvrQtim17/NNI3geKjd5tBn0gdE0ZoM4ed+o3WAnj1dWcThjxTojZ6oNLXzQNjOt2m9oHLl7r+Bc4GIIUPLcHNHCZNGHZrBlowVwK/eEzONXP5VH0YQ/nqeeLpONb7sPXMvxcGuEEut8BWC+QdS5+VR2z2EiLW9awBamOSxsKQRam7urA0GJ3fK6S9Vog3NHWxrzv6nlQ1LpJ1JLBb2/xNNKB38eD6oUSVgVuw4rRW+TvHycudee0UR7qYuL8gy53aS+8g4Ito=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(36840700001)(40470700004)(46966006)(40460700003)(47076005)(426003)(6666004)(81166007)(336012)(82740400003)(2616005)(316002)(40480700001)(186003)(1076003)(16526019)(70586007)(5660300002)(36756003)(6916009)(8676002)(54906003)(7696005)(2906002)(70206006)(356005)(82310400005)(966005)(8936002)(4326008)(478600001)(36860700001)(26005)(83380400001)(41300700001)(86362001)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 20:57:07.9803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b72edb1-1096-49e4-f368-08da587f992e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3649
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The platform can sometimes - depending on its settings - cause writes
to MCA_STATUS MSRs to get ignored, regardless of HWCR[McStatusWrEn]'s
value.

For further info see

  PPR for AMD Family 19h, Model 01h, Revision B1 Processors, doc ID 55898

at https://bugzilla.kernel.org/show_bug.cgi?id=206537.

Therefore, probe for ignored writes to MCA_STATUS to determine if hardware
error injection is at all possible.

  [ bp: Heavily massage commit message and patch. ]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com
---
 arch/x86/kernel/cpu/mce/inject.c   | 47 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h |  2 +-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 5fbd7ffb3233..12cf2e7ca33c 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -33,6 +33,8 @@
 
 #include "internal.h"
 
+static bool hw_injection_possible = true;
+
 /*
  * Collect all the MCi_XXX settings
  */
@@ -339,6 +341,8 @@ static int __set_inj(const char *buf)
 
 	for (i = 0; i < N_INJ_TYPES; i++) {
 		if (!strncmp(flags_options[i], buf, strlen(flags_options[i]))) {
+			if (i > SW_INJ && !hw_injection_possible)
+				continue;
 			inj_type = i;
 			return 0;
 		}
@@ -717,11 +721,54 @@ static void __init debugfs_init(void)
 				    &i_mce, dfs_fls[i].fops);
 }
 
+static void check_hw_inj_possible(void)
+{
+	int cpu;
+	u8 bank;
+
+	/*
+	 * This behavior exists only on SMCA systems though its not directly
+	 * related to SMCA.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_SMCA))
+		return;
+
+	cpu = get_cpu();
+
+	for (bank = 0; bank < MAX_NR_BANKS; ++bank) {
+		u64 status = MCI_STATUS_VAL, ipid;
+
+		/* Check whether bank is populated */
+		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), ipid);
+		if (!ipid)
+			continue;
+
+		toggle_hw_mce_inject(cpu, true);
+
+		wrmsrl_safe(mca_msr_reg(bank, MCA_STATUS), status);
+		rdmsrl_safe(mca_msr_reg(bank, MCA_STATUS), &status);
+
+		if (!status) {
+			hw_injection_possible = false;
+			pr_warn("Platform does not allow *hardware* error injection."
+				"Try using APEI EINJ instead.\n");
+		}
+
+		toggle_hw_mce_inject(cpu, false);
+
+		break;
+	}
+
+	put_cpu();
+}
+
 static int __init inject_init(void)
 {
 	if (!alloc_cpumask_var(&mce_inject_cpumask, GFP_KERNEL))
 		return -ENOMEM;
 
+	check_hw_inj_possible();
+
 	debugfs_init();
 
 	register_nmi_handler(NMI_LOCAL, mce_raise_notify, 0, "mce_notify");
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 4ae0e603f7fa..7e03f5b7f6bd 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -211,7 +211,7 @@ noinstr u64 mce_rdmsrl(u32 msr);
 
 static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
 {
-	if (mce_flags.smca) {
+	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
 		switch (reg) {
 		case MCA_CTL:	 return MSR_AMD64_SMCA_MCx_CTL(bank);
 		case MCA_ADDR:	 return MSR_AMD64_SMCA_MCx_ADDR(bank);
-- 
2.17.1

