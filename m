Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E780F43E7C7
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhJ1SBx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:01:53 -0400
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com ([40.107.237.82]:7904
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231455AbhJ1SBB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:01:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQ+velhbHiz6e+x5fljCVugW3AGdpvCyVlmKbIenMelnUDhI26vP6eF+ON/LdGo94Cgoe8RY+LcK5ljI5bi0LdsrCeplXXS6fgeb4j5GszHCxj0coWtNPia3jY4XmyGNokmNdf7CeaVq54wkB/hdbIHlRsUx/UFyFBdghQPijBF5HG+3liTfg37yi+pWIrpABHWxvzgID7V+MuhWMaef6j0j2eeB/JyJkbxG0TATRK87UpYtZf0/Fggn/PPe/915lod5f1ou/u86Wb9VifVFZ3DXbDHZC2tbYtU5DwxBF0hY/39aWwaa84oIJYrRDwMCdzJRJ/5rcmEPNm4c99q83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbvmkcdtVDsuS3zNN2+NB5mTBOArxRB1XqL4ORhUK7g=;
 b=NHNSmcV71Sj8mLqtu5ekCmUXT8L44iqChTRk5Tf7y9Itt7rfQK6AxCoHpf+kL3+IDCyDKXQO47iJL/PUu3p69r0gtXjGU94cvsNmeUY4lnIfXv+jb8kTxwrIApxdlRK5kPVh71QdDbvngUDPzrprOjRD4LwoMSpBKVdxmAz4gGmY5oLNPK/zW6dtTZqXlck1+Z/BVYSVu1m8Kqd7apcIUsRHCQngKNWjpuhT0XJvSPEuq/y6xePZWWgC0Hl4sR5YSMqDNw/zwIn7EVCYTLtZaIk5ympbf7hhOOaM45j73ldDeq5zL8vhIwCb/FAKJxDWnFTUbjSNBz3Cv7B2GS8/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbvmkcdtVDsuS3zNN2+NB5mTBOArxRB1XqL4ORhUK7g=;
 b=n8Pp+R+lVVzhGXx2JZCYVtHHux0p4dfI/GE+KAZSwvuy4co+enCPini3JKWRkZMBH/fIj0KZT8u3/QKppGVjBZhX1CzUPqHEPto9PXpJLWfDnz1Q2R6WMoo7Xs0bfupYNFJZzKm1tQKYH0W8CbeKV9qcBemTF8Gw+rbIKnja8iY=
Received: from CO1PR15CA0092.namprd15.prod.outlook.com (2603:10b6:101:21::12)
 by CH0PR12MB5172.namprd12.prod.outlook.com (2603:10b6:610:bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 17:58:32 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::d4) by CO1PR15CA0092.outlook.office365.com
 (2603:10b6:101:21::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:31 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:28 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 20/33] EDAC/amd64: Remove unnecessary assert
Date:   Thu, 28 Oct 2021 17:57:15 +0000
Message-ID: <20211028175728.121452-21-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028175728.121452-1-yazen.ghannam@amd.com>
References: <20211028175728.121452-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d231bc7c-55f0-41da-8c25-08d99a3c8da7
X-MS-TrafficTypeDiagnostic: CH0PR12MB5172:
X-Microsoft-Antispam-PRVS: <CH0PR12MB517228A3B2C74934D87F1E1FF8869@CH0PR12MB5172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaOZkeIDSwzd5ONyguEe54Bvlb0dyN+mvfsc0DDXivY2FHg62KLSNdNyUeV4FAASbw9uhRWFCSgR57j8HlwBQ3YY9ggXE6onAwjyGp3/ZEkajviuBle8yMo8IUOd2bb2NBHlPmC/UeVt+qEwN+26F0L9Mg88YIVe6ip7x+hfB+e/GZcwPSXapkczpWM8AUOo8rWOMSjLAE68EMY/IM6cvFPOsRkdYxmyEbOFFhkbd3TtnHU+7ebNHOh/dIWU4v8G/0WRSUwZ0FdzvqE2xuGL4T8ADEDeZFnnpAbWeGe57m3JztmENKbVsNvMkydtFjXfV10LmnrLw1tc9MUzhJ73q+w9KfjtiTRgYU/59/C9rOZA+W9+bB5EKsI3tpPKozn28bSFvBaUjYCuGjrPG/OeX2mc347cSksRgEYZc8hQ5aiaxU3RvtjZz3+4k4T1OUCbKSBDluXOp26SIU+IgbIfpgAeUrFPXqS7tONEBufDFFkO7418HupBmhaVlCAt66JNUMFvtKBJaBEI30cock90P/AEYo4lYVzUpelheQE1mxTg6g10jKvzAN6fnEQAI1YlB9OCA5Zxe6jGYkahWAN2/J7lTb44qVYZgnSUfVpCJXeL9hEHpiOkCnefPudmcAArTcSrfxKNlFCFcQAop8lzmCikOmC6YZPVAjE6SQV+7ZnERVe8xIHzCo60472H7fHXDJy9mXMb2bWgvBEoCBioozQdma1FThupHt42GF/tsUCBZBa7CKKJt91gA1Jge12q5RzMiiX0BB4zwAbkEBZ7GTkhm+D5zcJC9ifJaUPbPkVoVsHitZH07b8XhgqRz38X
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(47076005)(4744005)(70206006)(316002)(6666004)(186003)(54906003)(36860700001)(356005)(336012)(82310400003)(2616005)(81166007)(26005)(86362001)(36756003)(70586007)(16526019)(426003)(4326008)(1076003)(8676002)(2906002)(6916009)(508600001)(7696005)(8936002)(44832011)(83380400001)(966005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:31.3319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d231bc7c-55f0-41da-8c25-08d99a3c8da7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5172
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

It was removed in the reference code, so remove it here.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-22-yazen.ghannam@amd.com

v2->v3:
* Was patch 21 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 18e446c59baa..78b69406b775 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1241,13 +1241,6 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	num_intlv_bits += ctx->intlv_num_dies;
 	num_intlv_bits += ctx->intlv_num_sockets;
 
-	/* Assert num_intlv_bits <= 4 */
-	if (num_intlv_bits > 4) {
-		pr_err("%s: Invalid interleave bits %d.\n",
-			__func__, num_intlv_bits);
-		return -EINVAL;
-	}
-
 	if (num_intlv_bits > 0) {
 		u64 temp_addr_x, temp_addr_i, temp_addr_y;
 		u8 die_id_bit, sock_id_bit, cs_fabric_id;
-- 
2.25.1

