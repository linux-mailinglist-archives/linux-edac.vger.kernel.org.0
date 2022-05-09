Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA4E520069
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbiEIPAQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 11:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237914AbiEIPAA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 11:00:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D3524BB29;
        Mon,  9 May 2022 07:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXmH2EH9fAxP2jAOPpQn5FSbLCm73Q7RGWddalGMsSN7VYJ91WumVEol4qyUTIK/YfiVZZ3LWxDB24I7wKoRPSZ6VFjR5Ijz2yP2DkWGasGv9kWm8GOGt6AJRR4NSeiZlh+d/ak0OD88qY5ilEvr+wfiVcmdwzk8RYda0ewU+jBMqmRT+iY0sUvcWnfj8zJXkPkl/stj52MxMXg26w1XxzsyhO0eZWcmGQo57CRxxN71vgsYZ+8CfE6uzc+IYmxr5QOFtQKuhI+9i0RuiIQnhoyKSTn9hAqdNw4dWzzVHC+aChjIWKQUNTtSnSn+pbnYJzTc6Aajou+xyGwWNz74Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOP6sdubyHv8i9LkxrD85AO2qRI7kXMvNjTNtlJkwNg=;
 b=DNQSDPy2AVdvakfGWnU4TPE5MvpV7hVucNmpp2I92U2UwTK/0bENlfa7GlashBcaSzskkMVsFNWT3NQAVLeE5hjau9LIatiJ9Th5ubjBoOj7C6cBwdKOmgJjXO2JJ2lH4GTeJQecODR8nBd4FOn9u+cAAo4bICUaWmktG7Sl4kfUwWtJ+214jN30xLYJdmHkT0wutQJW7gCsnpSgwVwg/UlbboanPlo7Nvsq265cyZofAUW/7o2rqFvp9+HlyvBJeulwaqo4Y+n0szMg6nQHua9AvAinifAUPH3pEJ/KtWjry+R1lAW7H3UEyDJMgxfMXOcRpZuzZYzK+Rq2O970GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOP6sdubyHv8i9LkxrD85AO2qRI7kXMvNjTNtlJkwNg=;
 b=bXKj9wqHSdkRk3evdlcOMQAjy58iQhUAMf7cuuP/slXIUL6J/yXIBGyrmIddNeaDRpXh4wlEkFDqEj6GJiOwrvAxnqR3jGDIRGGoV8mDmCF1bQJRbv6xx//g+eaQmFE1Gesg9+WZ5OG/a/ISqRTMfzGj968JLAk54AWBNfWKxvA=
Received: from MW4PR03CA0215.namprd03.prod.outlook.com (2603:10b6:303:b9::10)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 14:55:59 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::17) by MW4PR03CA0215.outlook.office365.com
 (2603:10b6:303:b9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Mon, 9 May 2022 14:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:59 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:52 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 18/18] EDAC/amd64: Add get_err_info() into pvt->ops
Date:   Mon, 9 May 2022 14:55:34 +0000
Message-ID: <20220509145534.44912-19-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509145534.44912-1-yazen.ghannam@amd.com>
References: <20220509145534.44912-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66ea85d1-2c1c-4a13-e817-08da31cc07a2
X-MS-TrafficTypeDiagnostic: CH2PR12MB4181:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4181052444433A81010D88BEF8C69@CH2PR12MB4181.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8gOzJOPJPQ1jDZabKcjg220uNJCwrvkRMkyCOXWPBtrjIFSsD+nlGmGo9fotyQDCUHY3y2Sqx+B4qYV0VETVy+pD6HiWEj1lp6fu5pmqctXreqKcE/TDys43XKrArPFJhhJwtzbknPwul4dEm5EwgUaGNRp6mO5xbi3Qx4dGw56ujoqs5HkyB/mfDdN3UB1A2Ek0Bs2jSswYS7Tj6EiQk8IWTv74vDSoYlZcPCK5bk4NkKpTx8Q6O9hkg0JttZi80HnNFsItRHSjdIt+nxW5rl54RnMrKlQCninLYzLOMb/V9XvysCVF6zv+7uMLLlrXj4KnbxmGiBzsQUUKNNjUi03VSFyy0m268BdEn2X1nu6YDqgUHNhbalgit+DnDSHbgyfuzo3qee6YuDogm99yFMlePtxqRA6N7k5n6YI71cej6/KR6TliCe9dGzXGk/L2ZEmzCxrG7R+EBrsVCQQA6OK7+1+XF6SAMTNpW9RIu6tPIa1O7BuHgsW/rvUuqkwVAKXEmOhKyv0b3rLBnkVIh392MiakGv9lWRpDZDOlZWSWJ9D1wUBSAuDtqdY6dCF7A7pYmWECiFoO/9yjJrZhQc5GpmgJjUisr7PxC1VpUgQ9KPpMLBHp6ZXPmC3w0CJw0bhTUpeAUBuySF3N7pZn/9yjf+I21wJD1d55FHzmo0ZTyiulfpP2B6ft4Fb2NHFkpruSRDoeXB2+68kVMKEEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(44832011)(2906002)(36756003)(356005)(40460700003)(36860700001)(16526019)(8936002)(81166007)(5660300002)(110136005)(4326008)(1076003)(186003)(83380400001)(70206006)(47076005)(426003)(336012)(508600001)(70586007)(8676002)(2616005)(82310400005)(54906003)(316002)(7696005)(6666004)(86362001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:59.5677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ea85d1-2c1c-4a13-e817-08da31cc07a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

GPU Nodes will use a different method to determine the chip select
and channel of an error. A function pointer should be used rather
than introduce another branching condition.

Prepare for this by adding get_err_info() to pvt->ops. This function is
only called from the modern code path, so a legacy function is not
defined.

Use a "umc" prefix for modern systems, since these use Unified Memory
Controllers (UMCs).

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 15 ++++++++++-----
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 248d1082736e..81d165bcd252 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3067,10 +3067,16 @@ static inline void decode_bus_error(int node_id, struct mce *m)
  * Currently, we can derive the channel number by looking at the 6th nibble in
  * the instance_id. For example, instance_id=0xYXXXXX where Y is the channel
  * number.
+ *
+ * csrow can be derived from the lower 3 bits of MCA_SYND value.
+ *
+ * For DRAM ECC errors, the Chip Select number is given in bits [2:0] of
+ * the MCA_SYND[ErrorInformation] field.
  */
-static int find_umc_channel(struct mce *m)
+static void umc_get_err_info(struct mce *m, struct err_info *err)
 {
-	return (m->ipid & GENMASK(31, 0)) >> 20;
+	err->channel = (m->ipid & GENMASK(31, 0)) >> 20;
+	err->csrow = m->synd & 0x7;
 }
 
 static void decode_umc_error(int node_id, struct mce *m)
@@ -3092,8 +3098,6 @@ static void decode_umc_error(int node_id, struct mce *m)
 	if (m->status & MCI_STATUS_DEFERRED)
 		ecc_type = 3;
 
-	err.channel = find_umc_channel(m);
-
 	if (!(m->status & MCI_STATUS_SYNDV)) {
 		err.err_code = ERR_SYND;
 		goto log_error;
@@ -3108,7 +3112,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 			err.err_code = ERR_CHANNEL;
 	}
 
-	err.csrow = m->synd & 0x7;
+	pvt->ops->get_err_info(m, &err);
 
 	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
@@ -3757,6 +3761,7 @@ static struct low_ops umc_ops = {
 	.init_csrows			= umc_init_csrows,
 	.dump_misc_regs			= umc_dump_misc_regs,
 	.get_cs_mode			= umc_get_cs_mode,
+	.get_err_info			= umc_get_err_info,
 	.setup_mci_misc_attrs		= setup_mci_misc_attrs,
 };
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 1f64c08ae0ce..d5a64b0639bb 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -480,6 +480,7 @@ struct low_ops {
 	int  (*init_csrows)(struct mem_ctl_info *mci);
 	void (*dump_misc_regs)(struct amd64_pvt *pvt);
 	int  (*get_cs_mode)(int dimm, u8 ctrl, struct amd64_pvt *pvt);
+	void (*get_err_info)(struct mce *m, struct err_info *err);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

