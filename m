Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A69505DA8
	for <lists+linux-edac@lfdr.de>; Mon, 18 Apr 2022 19:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbiDRRro (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Apr 2022 13:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347211AbiDRRrm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Apr 2022 13:47:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A190A194;
        Mon, 18 Apr 2022 10:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqLRNM57sR4OfCM8MU1LUy76EwpVKdC/OyS2KMl4p0IAaJDI0MIqYx+kwFd6oe2vUKqThFfeiyQLM0GsAJA47t9zCislJgncDW+5ZDJYmZfH9v22CYC3dqUxm3iER/doVYjOT7WKNoa4XdR74aFEKS/9MqCHY0bK56V1jxoSIBRFKzeZpaxR7c7ssuoorIEteoBmxgN2eT6KKjMwm01jI4EXDzBWBnwozCOFwmWp5NW0rkE3y8OHgoCCYVry9cQmcfIupiHU7TpGeRBB21McpBEryKkMhlH+Jk1OGhkfHxGprw49AqbiQmZ4NqyxxKVPw9muyWdls0m/tKtWkeFuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0C514Ip0boU0u3wzZz2Bzwj549Hn0f1JkKv5yvmAkk=;
 b=BGdFYrCioHQ8Os+2jEKreKzlL8lpTaiNVB0tehGgJYoF2BLb9pGRkrOv2dXMyQh4QhV4QNXamhY2+V1o6YCJKTtiiAgDPojPTjBGJa5BfFoD0WyjdU+lqrQRMFv3rZNcGwD/oHlKjWOw2D/AcfQb7u4vAkyz8XhAzEfbjVXc9NqR0KZni48600cgO1B5A5Ge1L9mDm/KRuMWszP4sN7ItNICxkmUevRvFKWrAf+iIO971EcnzVmb75fXeMPhFT7OCnCr6Uh0VRqHpfHkArOmT/QtDqW+tmfkBax1bmdJv+jnr+wzYiWzO1LaU9h74RdKQltkRqFI4PMK0wXBW820qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0C514Ip0boU0u3wzZz2Bzwj549Hn0f1JkKv5yvmAkk=;
 b=nZqoGEJ33YZzIGg24gvIOqmSsjDhAb0E3t9r/p96ozC4cvMsxdSdeugE8gzX03PyiBVZnyZNaSPjZ+yTD3vbCT5HlvmuXdzqWQiv4umI7irQW52LiTVTT4QKYngkxeVeuG7/tLF+VouGGgqoZc4WNXkA5sImI4LWbWLGYCT9cZA=
Received: from MW4PR03CA0047.namprd03.prod.outlook.com (2603:10b6:303:8e::22)
 by SA0PR12MB4574.namprd12.prod.outlook.com (2603:10b6:806:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 17:45:00 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::e) by MW4PR03CA0047.outlook.office365.com
 (2603:10b6:303:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.21 via Frontend
 Transport; Mon, 18 Apr 2022 17:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Mon, 18 Apr 2022 17:44:59 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 12:44:58 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 3/3] EDAC/mce_amd: Add support for FRU Text in MCA
Date:   Mon, 18 Apr 2022 17:44:40 +0000
Message-ID: <20220418174440.334336-4-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f57f0323-bd48-4e83-1e2d-08da216328f3
X-MS-TrafficTypeDiagnostic: SA0PR12MB4574:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4574685291ED64BA095713C6F8F39@SA0PR12MB4574.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/aHRqYYQzi5T4umomNSdlFeQ5GVdzTazPb55P/OYYx1yR9Uzj2N9nGtg57wiuV0ukTcuX12dgtk41zb3z1RODLr8lSyouhcT8+tN03f1MOyyKPMAgmHS005egevyO6xvDFeIB1We+zKNtXKtKdgvURj1EpuDcXZN4YyuFpjoSnWxAWqptLCCx+utud+bCoLrUqyr0alv4C/BTlfNToObyhMm+EmPglW6X38+ODsTKn1/2oZ3y5AXRknjXJjI1/ZYmkHtkF3pOEA6uefrpBma53asj/dqSS/Ga7tzpdMYLV7uermG6Tu7h1SN5yZ8hbK7yTUU14089qb3BhicsCp1nx3xgdvj005di/R020vr+keZvT9/S3qE5BoOB9Qa7KmL9dpmuCXlxZ62y1GuzMMxdZ3QiVoF1v6iZHVtB7jfBL5xSQK2+lmM95TAqhjlMMvvZ/wTmUoO0y9uF3HRTuWKeD9IkIQ+fUcowzTv8PrTK0ZFGWfilaGqzB38T1XkJHwM0vtkQHmpa6d6Lg9BBeywWHkPGSUt0pIBKbWcBDI+gyXLew3zaAcTo7tW3L3+j89+KFU7HOAUqjngHcmuAIrqwRY/ZQYbrsF/5ZBF3etCAcu84rbCTGY1TwDN3OP9+DmMY7gWv5nbLlVa5zY0jT9nKJ08x3+KDBzVqpkWuXrdMa3sJ9/FHp7Enfk0rCcg/Lc66+ye4/nGcpV0HEs0TWivA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8676002)(1076003)(70586007)(36860700001)(86362001)(40460700003)(82310400005)(36756003)(6916009)(54906003)(7696005)(6666004)(356005)(47076005)(508600001)(81166007)(336012)(70206006)(44832011)(4326008)(426003)(2616005)(5660300002)(2906002)(316002)(8936002)(83380400001)(26005)(16526019)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 17:44:59.6972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f57f0323-bd48-4e83-1e2d-08da216328f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4574
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

A new "FRU Text in MCA" feature is defined where the Field Replaceable
Unit (FRU) Text for a device is represented by a string in the new
MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).

The FRU Text is populated dynamically for each individual error state
(MCA_STATUS, MCA_ADDR, et al.). This handles the case where an MCA bank
covers multiple devices, for example, a Unified Memory Controller (UMC)
bank that manages two DIMMs.

Print the FRU Text string, if available, when decoding an MCA error.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/mce_amd.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 28b48c711fe0..3cacc3f22379 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1235,6 +1235,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 {
 	struct mce *m = (struct mce *)data;
 	unsigned int fam = x86_family(m->cpuid);
+	u64 mca_config = 0;
 	int ecc;
 
 	if (m->kflags & MCE_HANDLED_CEC)
@@ -1254,11 +1255,10 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
-		u32 low, high;
 		u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
 
-		if (!rdmsr_safe(addr, &low, &high) &&
-		    (low & MCI_CONFIG_MCAX))
+		if (!rdmsrl_safe_on_cpu(m->extcpu, addr, &mca_config) &&
+		    (mca_config & MCI_CONFIG_MCAX))
 			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
 
 		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
@@ -1300,6 +1300,17 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 		pr_cont("\n");
 
 		decode_smca_error(m);
+
+		if (mca_config & BIT(9)) {
+			char frutext[32];
+
+			memset(frutext, 0, sizeof(frutext));
+			memcpy(&frutext[0], &m->synd1, 8);
+			memcpy(&frutext[8], &m->synd2, 8);
+
+			pr_emerg(HW_ERR "FRU Text: %s\n", frutext);
+		}
+
 		goto err_code;
 	}
 
-- 
2.25.1

