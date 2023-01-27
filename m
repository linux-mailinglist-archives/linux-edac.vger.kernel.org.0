Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26A667EC0A
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbjA0RGJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjA0RFs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:05:48 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC841C5B0;
        Fri, 27 Jan 2023 09:05:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJXRFUYd4vRIFfDh7a+UFVid4teuYZ/Zyool6JTc6CX1wN5y8fZHBHmdB320fdvuaCuyBk4Epp+tgSjMF1KLCQxvDJjV+h2rY0JlQsacDsoJrWNzMbhEZ8cshB6a+NOhLq5LZ0AXI+YjRVmK4K5HzDo4SCof/DdA5xKWZCpIJPaGRVsyfopcjBcBUepKs9Qv9sRQ0FzIfgQOgRb+BV8d9W5YIhXgk7szimn/zVrxkYX9R1SF3UrCk0oFakNuXdoqz1yJwMipZNfZzPIKGhtauTL9zoTgPghqGq1bglR4pdgx0CxSx4MnKNQFhUd1Ok8ONnZ9MWgKh7ZTTMEQFSdN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRoAFz9642bohYpHwQJoBh/9I5h0ghxbapmFQ5TGz+Y=;
 b=Dqk2TwLwfGHmH7hzBiGbLQXneKmE9Q8h1qSLJZdQAk21Tog9k1sVNB3moqUq7ABuCG3nPgN3CylFaz1CBmKly/+4Nccn8DIB+uxRS3pzSPeWhRXVJO3gJuNsSGVfKHD2Wh24JU5KxC6DlhEAif1soqe3MoFwCHzgmDKHquks0HI9sZ1KzqqlpLhxmeejhXhnZ6k2dY6bFUNdcqqRQL8zerl6ZKIZarOO9Pu8uycw8ai8O17vENSV6SbYZNLzd5e1FADIOOTK5uu1MkN4iQU1USPqOa83W9MLSfHGBm0utB7cKtunFrfRaGqT7ZFTfEedbROMmeI8eKihjiO6v1xtVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRoAFz9642bohYpHwQJoBh/9I5h0ghxbapmFQ5TGz+Y=;
 b=Qe9FKj+CYG6d/mVi8GNSN7ZwBxezybBIWlb+lPkr0pYASXMp/a0SFhG+r6ctQ5ab87IgsnxyRfufdBpgO8lRv0k8dd0WWf2Jc1mkUXgPNS/dyayFlmj/RugVC9bcjUcKaGK+XMvL06UD1dZS8oRBis2+EH+9z+B2/ClYGUv+2RY=
Received: from BN9PR03CA0459.namprd03.prod.outlook.com (2603:10b6:408:139::14)
 by SJ2PR12MB8157.namprd12.prod.outlook.com (2603:10b6:a03:4fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 17:04:39 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::69) by BN9PR03CA0459.outlook.office365.com
 (2603:10b6:408:139::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.23 via Frontend Transport; Fri, 27 Jan 2023 17:04:39 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:38 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 22/22] EDAC/amd64: Add get_err_info() to pvt->ops
Date:   Fri, 27 Jan 2023 17:04:19 +0000
Message-ID: <20230127170419.1824692-23-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127170419.1824692-1-yazen.ghannam@amd.com>
References: <20230127170419.1824692-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|SJ2PR12MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd5d219-7633-4f49-bf3a-08db00889361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPPp72A+hQe20wkZipafRebmOshnK+c/jKRfOvyEpezoi+i3YHp0lQ4sJWYnrVrInfxnPfyY2nySl1HcvV8rybdKvli0BBEcg39dBBZmnmQaz6Tt+AVcDPwHprrDjU7ns85dPhfIPuJUaSIDCY2F8LcPgKFBy2ggvPDpvjBT9S2FBMOc0D2GJ2snzoMZaaZokNz1VW8a+bKSdM+FcwLfc1quNLqs7Xdwk+vLEyBokxCoLSOds6pyNnlVrBURvzAgoEkVY8tEx6ObhdKkLFYXrIV0IQ0DrGRuFpSZr72g/JHHu2FHcjrT5X5WrH16gO7f83NaDqfM2+qLHMAfQ1p6JqRQlsgWT4tzPMF0wKUwIYw6w4A6D/7vBCR9inFf4ccZBiqCsww3q2KIq0WecKq7/OOS9+uHbsm3GyKANya6nqxgPb5mU8O48Xc9lj3wKmBuFSIhs/ui/zlDPLN5SHxaLed7+MMqJcahZrPZvLqNLOxpLKAFOHYNVI1UXhDxV5S8sOkOE+71TmnVtixaLrcXlJ+wt/PIZqSvZ155dVavB3omZ/eOgPo3B9D+7fjRMseBjzmPAxizl4L+q+qKkJTPtCUaTUrIXrimAa7MkBJNLggZPGDiO9xYLuG0Xx6ll1wWy3X3j/pRQSxMLlS3ahpCacUj+S24NdR2YmatRXREvt6bw6CeZQQvLWfCvtafMj1UUtvLd6/RJS1Vefja48OovSk01iRFcjQfOzRJs9wbmQsTG7/FZun9uoZQA70yRZD/fr32Cz9KhUOJQA9HjmdxFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199018)(40470700004)(46966006)(36840700001)(356005)(44832011)(2906002)(5660300002)(81166007)(8936002)(41300700001)(86362001)(6666004)(966005)(478600001)(40460700003)(83380400001)(36756003)(110136005)(36860700001)(54906003)(82740400003)(316002)(47076005)(426003)(336012)(2616005)(7696005)(40480700001)(8676002)(4326008)(70586007)(70206006)(82310400005)(1076003)(26005)(16526019)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:39.0953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd5d219-7633-4f49-bf3a-08db00889361
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8157
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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

Make sure to call this after MCA_STATUS[SyndV] is checked, since the
csrow value is found in MCA_SYND.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-19-yazen.ghannam@amd.com

v1->v2:
* Drop a redundant line in code comment.

 drivers/edac/amd64_edac.c | 13 ++++++++-----
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 6b450544a892..ee291859cee3 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2974,10 +2974,14 @@ static inline void decode_bus_error(int node_id, struct mce *m)
  * Currently, we can derive the channel number by looking at the 6th nibble in
  * the instance_id. For example, instance_id=0xYXXXXX where Y is the channel
  * number.
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
@@ -2999,8 +3003,6 @@ static void decode_umc_error(int node_id, struct mce *m)
 	if (m->status & MCI_STATUS_DEFERRED)
 		ecc_type = 3;
 
-	err.channel = find_umc_channel(m);
-
 	if (!(m->status & MCI_STATUS_SYNDV)) {
 		err.err_code = ERR_SYND;
 		goto log_error;
@@ -3015,7 +3017,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 			err.err_code = ERR_CHANNEL;
 	}
 
-	err.csrow = m->synd & 0x7;
+	pvt->ops->get_err_info(m, &err);
 
 	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
@@ -3685,6 +3687,7 @@ static struct low_ops umc_ops = {
 	.ecc_enabled			= umc_ecc_enabled,
 	.setup_mci_misc_attrs		= umc_setup_mci_misc_attrs,
 	.dump_misc_regs			= umc_dump_misc_regs,
+	.get_err_info			= umc_get_err_info,
 };
 
 /* Use Family 16h versions for defaults and adjust as needed below. */
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 1c64fd4a14b1..e84fe0d4120a 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -470,6 +470,7 @@ struct low_ops {
 	bool (*ecc_enabled)(struct amd64_pvt *pvt);
 	void (*setup_mci_misc_attrs)(struct mem_ctl_info *mci);
 	void (*dump_misc_regs)(struct amd64_pvt *pvt);
+	void (*get_err_info)(struct mce *m, struct err_info *err);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

