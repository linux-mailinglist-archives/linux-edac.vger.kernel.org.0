Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C9B43E7BE
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhJ1SB2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:01:28 -0400
Received: from mail-dm6nam08on2077.outbound.protection.outlook.com ([40.107.102.77]:9088
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231396AbhJ1SA4 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzpkpzJXSVyv4CbwGo0X4qQACoUIpesrd80jgOEQqhDTPHyp1hhzQvtANSlU52i++ZyhFzlSl/ERpElF5D6GjqQynUUccf266cWGrWQI1YzeC6/6GhNM19k87m+WxLsHlNwaI6gEZ3OFxV7cTD7+KQBht7Gi7axGZMvFIVyeYWI4Caz4/ye6SMEXAB1+Nl7xDP/GV6c1pGoljDkGbGY9ujzIzVbF6P4cARhwT3Gl2tOHm57BD6T7QnC8EiHNRewwUiuzt/ilKCD0G+lu8bhRiY/5HWexUmGX8vLaoDG4PXYDL2b2/EmSFWKwUx/V8GcnOH29WPd+V7qyppW1Ng+5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jsaft5lkQQb0ufbPPve/e9tPrfsLTtd1rlw5TdHGjrY=;
 b=azJuuDK/Lgnp7JKF7Z6K2jf+2Y9G8vzTcH/EZT2uzx/pV30b4EuaVc94GscNqYFNTOJ9xet9CHOE1EhVoczeDZ0tHdTDHerzeXAs4LuVwuDuNNklGRvT0KY1fYUajXb5uPyKQHTeCfEABgfNM7WSRS0N+2EpilmT1K3kcnPbiC9evVFcIkKOxe3MYlmcgMsCi7y2CrhslBTuFjW76b3LbJ860pCpVkb/3yY8T0c7co1SuVbl+YvGqGH8vQKJPbYCp3paXHqmvld2/a8FRydo5uvwLi4NQbQuGNCKCVNit9kFnD6+F7IfoUmbyjYV0KPRG+CwDH8VJf72zlJaGemTSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jsaft5lkQQb0ufbPPve/e9tPrfsLTtd1rlw5TdHGjrY=;
 b=WCOw8PB0pgdLey6n8sXZeDPHQCySv+7wM9OGybvOaZh9/b4SpKdOQq2daPdI6ijiMdX6M+IWW/RN1BQU+zjV71X3gzaabsQcElEqaxVFRCNMY+xDRUBcr0tSoncUDzTKJAJ3UFil29JnzMaUrRTbfnqEcatzH9tDqWIVxaiKUTk=
Received: from CO1PR15CA0102.namprd15.prod.outlook.com (2603:10b6:101:21::22)
 by MWHPR12MB1280.namprd12.prod.outlook.com (2603:10b6:300:12::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 17:58:26 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::15) by CO1PR15CA0102.outlook.office365.com
 (2603:10b6:101:21::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:25 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:22 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 16/33] EDAC/amd64: Skip denormalization if no interleaving
Date:   Thu, 28 Oct 2021 17:57:11 +0000
Message-ID: <20211028175728.121452-17-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 68a3896a-b0f4-4b8b-ec50-08d99a3c8a6b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1280:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1280628C471072FBACF57ADAF8869@MWHPR12MB1280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bkONTvEQBSjw7/0x4cBolMvSU0Nm1Jwsvq2U4GICgpwtnlBQqd4BmUK6fAOiZ2jtYyp8IYLOzW1ivnjQcM29cS8g7uz4knNBZHgceXQ6+FNXGbSRt5OsanbvaM5oohRMDYpgrUkDEhIhBApFhiGcdvigYd3/eksCE4/gli34N46UhN/39BaP7slgOMxGG6IVTAMQWY6JPqrN81a7Oznd7UqsV1DdciU7tIiPM++F1jtpnG/EAo/NRNybFpdnVMYT7f0IwzmcY4mu70YrQ6WzuJ2Q+HFvZnpUkK9Z6iDiIQVLRLUVj+4HKcVJSh9NnMnviD842iM+4S4WhNnKJbQxJd/dRgFbnJiIy07CCx1+CCLCi8bP77MeWQTy0oV3cjs1t/LOuebmUt2fBlOKcZ27RJteQOSriWwG47NkQr4m1WGyWnUS0Oc8cRF85a/4Y5pGMq3PUjaxf1sAiHjXj5aZDuHctxbd4z1qCbUHIlnuHOikJ13ybZZz5Qx8/KxfUCRJD5i5HAXA00Gv7/UUEfVfMxKQ6PEWCnH19w8mscG8MgvHPpMTX+4mq08wm0AiBSr3WyT6k27k0hkg55tWZZbUt6of6xUBNYRCrH9gEQ16ATQqMILLwWuYpBWvG4KUY+k1MyixPS3BoS23MT682zerrzlM4HYrX2YrnqGUVW7PigjKWQdFzw8ISmcc3uFgZlIoSUekXfodhZjTvkXtDEcj7iznBYNzDSFtWQmEcdwtSF6ld7iPJYapCeSI0G9Da7CjxmEd+OUdSlPQ0m+qH5M3ueMOa++7n9j9PvqHTkaCAcfE6ubjvxBMMSxaUeVdmTDG
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(47076005)(36860700001)(356005)(86362001)(1076003)(82310400003)(81166007)(44832011)(426003)(2616005)(6666004)(4326008)(70206006)(6916009)(508600001)(5660300002)(4744005)(2906002)(336012)(7696005)(26005)(70586007)(8936002)(186003)(8676002)(54906003)(966005)(316002)(36756003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:25.9090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a3896a-b0f4-4b8b-ec50-08d99a3c8a6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1280
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Denormalization doesn't apply to the "no interleaving" mode, so return
early without error in this case.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-18-yazen.ghannam@amd.com

v2->v3:
* Was patch 17 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 6b19fc5cf340..b6a8366e40ba 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1193,6 +1193,10 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
 	u8 num_intlv_bits, cs_mask = 0;
 
+	/* Return early if no interleaving. */
+	if (ctx->intlv_mode == NONE)
+		return 0;
+
 	if (get_intlv_addr_bit(ctx))
 		return -EINVAL;
 
-- 
2.25.1

