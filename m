Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27FE644A6F
	for <lists+linux-edac@lfdr.de>; Tue,  6 Dec 2022 18:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiLFRhT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Dec 2022 12:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiLFRgo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 6 Dec 2022 12:36:44 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0D83B9FF;
        Tue,  6 Dec 2022 09:36:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQuS686Rmug8e8MGWOcwzDRE8g5ccuEjKIF45A9L/RVYPxe2C694J6d/kiJB/zKiFX1jPDEYf5rwB89wSKaBXIPns8/dZewxqhB9t75TNouPvn+2SXlxOASm3+7+sgTAT+OwdB4gkGB6Nfl3+Ra6FxNaoFNC+HVxDxrlKWdRda61i77geZ3J+H3W+s5GZ6kzVz1E5EHZ/cpcmQES+fMNMX+cYtMj/6+qR+RGu4dgUGnBOri6UO5emopaeQunKEVF/XWyU4tEZqxvlH0oEKovI2SSY6qK/0Jl1NifyMgFpzErk64ABqbKwZwZVxhQ2KBdBVjskqYSCUiog4dfIx1mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yk0Jk8r1FtwBQZ5YKXHBLBG4RsB3g/EpJ6h6R5nZ0g4=;
 b=QVNIIu6k9hYRoc9LiVsPVKp2ynPtywQPJrwMpLkpI+oGHRtoFLCBchKVgIw14j+Ojs2ELGCTIE3U4iRGIdVtV/B6fRkyaj3nwWRlIlCNRnz1pHQqb3bleq87O7yW0LHsdq6Dpwl7R4qKAjmhZb6KKWr0mft9r5zPEoBpVxEojB63ovMLm0bu8DBBM/qDJY2Z7al2W1Yx5sq3XPHvGqy6lDPmUuWKEZHW40Igm/c7Wk5U1uOpeBr2dY2jTh2Fio+a48fUAnHdib9qQkarYZZHp5LZwQtf2cpqasYIgb7D9ULVGm74co+10h5AXj6pRmsDBz+5Bl/57ajQBt/VK06pjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yk0Jk8r1FtwBQZ5YKXHBLBG4RsB3g/EpJ6h6R5nZ0g4=;
 b=OmBJbaeUkwlDOvSj1xpOd/1bgzO5aa9gZEhmDKoAtEBdXuYJ95KZsXBJI9h/CAN6bwfCteHqxAU3rSYAvbJmqLCFGw6qdSSLRK12m+9JNrG45o71JJVkZ/8wKdkztT4UM5dg/mntUNSCOcMJdYs8IpHahiQY3pcjC1bMZDfDRa8=
Received: from MW4PR04CA0222.namprd04.prod.outlook.com (2603:10b6:303:87::17)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Tue, 6 Dec
 2022 17:36:23 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::35) by MW4PR04CA0222.outlook.office365.com
 (2603:10b6:303:87::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 17:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Tue, 6 Dec 2022 17:36:22 +0000
Received: from titanite-35bahost.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 11:36:18 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v6 3/4] x86/mce: Define function to extract ErrorAddr from MCA_ADDR
Date:   Tue, 6 Dec 2022 11:36:06 -0600
Message-ID: <20221206173607.1185907-4-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f632c0-fff9-46cc-f577-08dad7b0646d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Atcz1p2CJgJQzHTXI8ejEX6EBj0J+7uUkzriPYewjp29mbDe/HEjnC4DI+oFVmdNMRfURHe2dwt9e581A0XbIGuxcgH5Te7pzYmMqS64nKNDEJHdeTHjR3jNilzdT1fhRH+ZnXdqs/G9l+9DZRmCktE7SNXDsKWOqPgqqOd5xocmrFQGFTuk+4RnLcPkj6VTOFn13sEcjwefvP9JWIUV5+xxRdP72VhwY3iotCzlbBwnRTr8PzMH0WmnTIuFJGTSoESaqhQkX2Oxey1XnTnfBB86rYOcQ4DyfF4SDFfiP1P8BT2iH+PjZPDu/J+O2YCGrzg/Ag4Pdwgcomh+PjLBk1Ja7sP+vxqt3p10c3lUtOHe0jefQZ+vQ9n24Bv8wHuQVPl2FupMIif8mBaa72/uElbz+M054nOUFiaQrpVg1O2LCpSBVPFLdKoNNWc5lm+qsZv7munywIf8t1qZ4HB+P0rAe2Dy76uNDW15lSTEIZ7j6fI/L0KczGMJnQC/J1+ciMuU5kqQJ35dw4gZLkAIzibdsH1gybIPsICiWbe1Unr+Hgmu6qLzgh7RiCbV8RM2LratgRNNDBA1F/AYSyyjQNaCUi/685SB5RllDIss6aLi+6K/K52DNnFM8R00k78P8gxlSgUFrQw0HQGQoFxKRbUJNARdok0rnBjFxbjWvolbvG4KfkggyjDruBSNvo0SniMHDmDFm3RrEpXO+YVrvjlBor8He4Dcc5+4WjQTOeZYRUni/VDitOaSfd0j/TX3qD5aWm66N3BQe8a2XQDKMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(5660300002)(316002)(40460700003)(36756003)(6916009)(54906003)(81166007)(966005)(336012)(356005)(426003)(2616005)(41300700001)(83380400001)(82310400005)(36860700001)(82740400003)(7696005)(186003)(6666004)(40480700001)(47076005)(86362001)(8936002)(8676002)(478600001)(26005)(2906002)(4326008)(70586007)(70206006)(16526019)(1076003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 17:36:22.3927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f632c0-fff9-46cc-f577-08dad7b0646d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805
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

Move MCA_ADDR[ErrorAddr] extraction into a separate helper function. This
will be further refactored to support extended ErrorAddr bits in MCA_ADDR
in newer AMD CPUs.

  [ bp: Massage. ]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Link:
https://lore.kernel.org/r/20220412154038.261750-2-Smita.KoralahalliChannabasappa@amd.com

v2:
	No change.
v3:
	Rebased on the latest tip tree. No functional changes.
v4:
	Commit description change to be void of the patch linearity.
v5:
	Extract entire function including comments.
	Define smca_extract_err_addr() in mce/internal.h
v6:
	No functional change. Removed old link.

 arch/x86/kernel/cpu/mce/amd.c      | 10 +---------
 arch/x86/kernel/cpu/mce/core.c     | 10 +---------
 arch/x86/kernel/cpu/mce/internal.h | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index b80472a52ad8..85977ca07825 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -740,15 +740,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	if (m.status & MCI_STATUS_ADDRV) {
 		m.addr = addr;
 
-		/*
-		 * Extract [55:<lsb>] where lsb is the least significant
-		 * *valid* bit of the address bits.
-		 */
-		if (mce_flags.smca) {
-			u8 lsb = (m.addr >> 56) & 0x3f;
-
-			m.addr &= GENMASK_ULL(55, lsb);
-		}
+		smca_extract_err_addr(&m);
 	}
 
 	if (mce_flags.smca) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 9efd6d010e2d..757cc46298d3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -633,15 +633,7 @@ static noinstr void mce_read_aux(struct mce *m, int i)
 			m->addr <<= shift;
 		}
 
-		/*
-		 * Extract [55:<lsb>] where lsb is the least significant
-		 * *valid* bit of the address bits.
-		 */
-		if (mce_flags.smca) {
-			u8 lsb = (m->addr >> 56) & 0x3f;
-
-			m->addr &= GENMASK_ULL(55, lsb);
-		}
+		smca_extract_err_addr(m);
 	}
 
 	if (mce_flags.smca) {
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 7e03f5b7f6bd..6dcb94fe0f65 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -189,8 +189,23 @@ extern bool filter_mce(struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
+
+/* Extract [55:<lsb>] where lsb is the LS-*valid* bit of the address bits. */
+static __always_inline void smca_extract_err_addr(struct mce *m)
+{
+	u8 lsb;
+
+	if (!mce_flags.smca)
+		return;
+
+	lsb = (m->addr >> 56) & 0x3f;
+
+	m->addr &= GENMASK_ULL(55, lsb);
+}
+
 #else
 static inline bool amd_filter_mce(struct mce *m) { return false; }
+static inline void smca_extract_err_addr(struct mce *m) { }
 #endif
 
 #ifdef CONFIG_X86_ANCIENT_MCE
-- 
2.34.1

