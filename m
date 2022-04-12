Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7534FE4FF
	for <lists+linux-edac@lfdr.de>; Tue, 12 Apr 2022 17:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357201AbiDLPnj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Apr 2022 11:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357193AbiDLPnf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 12 Apr 2022 11:43:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028A95FF04;
        Tue, 12 Apr 2022 08:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEjMyejZ70m06D5cWEv4eFRGdfQPPWocRA/lWlDzpq/mE5L2Ix8rV3q8ENNrdRvPI+7zpXqlLyXmYPdzYg6H2B+6X+PXi+zc+RmnIqeftL+7uz1maOHtgE88qyvhVkbs3biEwtBn3GefUHlL3vVJu1aDlS4C9jqCqbP2MiExwW9lZwiVr4ltpLkRNObpiCQU58zlhMuRAOlXsQFO/Pd3b5audmR4Kz7hedVFE61I/rcrw57/Vwj8xfvODoDxffPXt7x88/B5h+iMOyzuxIQyEddszFxq54nyEoMFUPoCaw78vbzNO226s8JqzOF7iDzjM/HeET7LbID208bKwvTH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bptFFi8iUmgDZBG1ZuTcPbI+ZXweWm79vVr7677tibo=;
 b=OQkV4URVq6KgJEvTO767VEYoyvFcUqrsDi9xD6tn83nS9fk1w20I1mOFAvr7rHbrrlAbvJ9Cmn76mwRdr+Y4aNG6SioebZlFQHmNN8TlHqNQ23dcXo+NDbCQ46IntDbJ2SoP6hQFc6dpg706Atl3BWqB9i9GRBPFHn0/kYOiyoFDE3LnJvdEAlpnmgW3N5GJMdjy7klQtpU6P/vWf+x1bcO1lC9Bx8Nov1UraqgFTAuWM4Znu7q/tGB84AyCTS8zrhLkp1FXnHYnfgHmu/Ts3ZD/1eNKv0Q3KqnfiOpY6dIzw27vZMqnY9vcW6feKdHbtfSmc4dmZhLyf/0q92T0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bptFFi8iUmgDZBG1ZuTcPbI+ZXweWm79vVr7677tibo=;
 b=2L75fkHLB092+VUt9Gh3OalNE7quqsGO/HDp8JqWiiMtRyvrUfXNvJI5YzaN/ChQqn8/9ocgBEV/OcMh2Q62bVt4+0oYP7HpQogGLBAghu1841Q9IKl69IQevN26QdkzJLoRB4QyiImVZMo1tTdOd01CEFjTcnAaVS3xoM4IA50=
Received: from MW4PR03CA0214.namprd03.prod.outlook.com (2603:10b6:303:b9::9)
 by SN6PR12MB2830.namprd12.prod.outlook.com (2603:10b6:805:e0::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 15:41:02 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::d2) by MW4PR03CA0214.outlook.office365.com
 (2603:10b6:303:b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Tue, 12 Apr 2022 15:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 15:41:01 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 10:41:00 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <hpa@zytor.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov" <bp@suse.de>
Subject: [PATCH v5 1/2] x86/mce: Define function to extract ErrorAddr from MCA_ADDR
Date:   Tue, 12 Apr 2022 10:40:37 -0500
Message-ID: <20220412154038.261750-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220412154038.261750-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20220412154038.261750-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f2f6218-3654-4d21-b87d-08da1c9ad931
X-MS-TrafficTypeDiagnostic: SN6PR12MB2830:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB28304FFBA56BE3765F6E01EA90ED9@SN6PR12MB2830.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OofetUrzvia9c/4GFH6wgjC96o2I7ueHAZspaJ4d85gBXxR6rM5579avNH6KxpzG8BLO0cVQeuOFrc2s8+FwHqM5h9lNpy5pDq5vORh2rd3mYba2E6oqDmFIPnSdPHzc2GDDUPzPXxCeCsU3oma2Lk+UzlNJc7mT/atsaIH5hyMGsqLOthAG559ayI/hlv1ElGu9szjyZX5oEpTuRqOTXVrRA1nAsSoyU9VOHA5CmJrmnF+AT7N3kjaJ+kgPF4HUcwVf+nezmLiWMk8WZN3/8GgYiK14t5bK0fr7GLzDXp6/OK/yzJRsWCCrFC9ywP7iEQBVXodTN3FoYuU9pEF/1xorSJMm8Lm6BUA4B2WPLGHPUpJwNxecK4RofdpekE2pO91ZdZ4XXfdr64xkg/7yOZj0mU2RuVMrsz21j+zmBIJ29lWpQDEcpt1PFPTFeXtw8R8kuJZY1oUae7zWApEy8f/SvVYv+BbP3D9mbAwsQEGRmWSJZIsPjwKh+4DQSzHaEjgTdAF5gTFb2pDgJMQ3l9vdVnUIcxtzBvPUU5Bb3kZH1OTHEvO7jpv+Kn/krDwGvNZpUP5rQKVRqf2/aIRxawWdAnf5Dx9t7chPAxCUsLacwZgp2m8e0X+4LAJBQxLMHgKlwOAR0wmBigY+cTyC4167eCgQ68Hw1B8hM1wR8wdnELyPxCF0JJxwv6602cop3A/cCFrCmajdxg4e6lIB6HrN8HPJH95iZ4E6IwWIkcs20sNE4yWEKiUxK1skABDngqV5+VtTgG/0BzkNMU0ebSyt+f58zT1eGSL1IcN/kaE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70586007)(70206006)(316002)(54906003)(356005)(110136005)(86362001)(8936002)(186003)(26005)(83380400001)(1076003)(2616005)(81166007)(36756003)(16526019)(426003)(508600001)(336012)(6666004)(8676002)(36860700001)(966005)(40460700003)(2906002)(7696005)(4326008)(5660300002)(47076005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 15:41:01.9083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2f6218-3654-4d21-b87d-08da1c9ad931
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2830
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move MCA_ADDR[ErrorAddr] extraction into a separate helper function. This
will be further refactored to support extended ErrorAddr bits in MCA_ADDR
in newer AMD CPUs.

  [ bp: Massage. ]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20220225193342.215780-3-Smita.KoralahalliChannabasappa@amd.com
---
v2:
	No change.
v3:
	Rebased on the latest tip tree. No functional changes.
v4:
	Commit description change to be void of the patch linearity.
v5:
	Extract entire function including comments.
	Define smca_extract_err_addr() in mce/internal.h
---
 arch/x86/kernel/cpu/mce/amd.c      | 10 +---------
 arch/x86/kernel/cpu/mce/core.c     | 10 +---------
 arch/x86/kernel/cpu/mce/internal.h | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1c87501e0fa3..f809eacac523 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -736,15 +736,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
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
index d775fcd74e98..39614c19da25 100644
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
index 4ae0e603f7fa..64dbae6b8a09 100644
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
2.17.1

