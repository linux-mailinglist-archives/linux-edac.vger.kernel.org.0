Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E01649ECB2
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbiA0Ul5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:57 -0500
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71]:59360
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344185AbiA0Ulw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmYvGOk/myLOaCQ2eKR9AW9p4hMFn7KgzmyQZHnyjobmmrceb/cDJSFp6aE5f7y6TnhqjGsPCeq2oetSP/tcBt3bLcZKsi4TlwCqIJEhooMQhBdlvHQJNEyAOfn9/h9URPZYUqhiFaN5PEDqxVBRQB7J/ZH9wHua3EqIc5Rdl+NwBO5p1IV+THw2BLQdwqmavU9Dj670ftn4fseDUyUIqhD9mbK1SC3Yod5q3Fmv6bmGelbXiBedaBnuYvd6mAbglMT8Thjf2FEh9UCgmPt1AVIRZQIP4mR9Y59LX1I0kHcz++ncvlrLcx8LBBjtiONgIGkxJobYBssnDWJsj1mh5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1urEYCI+qsQvgCx4ebOJ1X6FBDJxM1yLkviCB6AQro=;
 b=e7WjLYOy0kfcDEtwDWg2qSySvhWpnru6O5fX8SkWjGfNBTNDRVgJGIF5UV7iSYg7jEnHN7oUcha/Ya5CrYmVo0SixV/fTKVTBl2R8DjnPrJeNUdYfWfISO7PFYKFVLVBNlrgnrRaTt8SjHTuAPE6iy0Cn2oqKsQC1b3CLoAVoTr1r+7dBuAzpjC1kLtQswJX2a9N8vy+WqVXT8C/3aHtuNdMH+R/PfPv+zO0Sbih0iTWb6nz1ZvLSzSTXhqTr5xIROBqIXNxHaSm1++EbpqnH9ukN81bfc1xrwFtRg3u3XTSAtq6SSxmWbxR4700lBXUuFPvH6UTO8uob1fcNJdoWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1urEYCI+qsQvgCx4ebOJ1X6FBDJxM1yLkviCB6AQro=;
 b=QTqKnCjs8CEXgCn57daFiFuKyB8MJ1bvvoqJSG4bhV9hfrW36ZCVpR94KacYdkZpJyj4bTodbZ361TYB2Ro4CG/cG5HIw083wOaXstPQlUC7baZnXDFq45Dn+80R0NIPVRn591V2NwKIrMJN6k3RBolt4tOsfz14CO1tdXlG1xk=
Received: from MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::19)
 by MW2PR12MB2346.namprd12.prod.outlook.com (2603:10b6:907:4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 20:41:47 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::4) by MW4P221CA0014.outlook.office365.com
 (2603:10b6:303:8b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:47 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:43 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 15/24] EDAC/amd64: Remove unnecessary assert
Date:   Thu, 27 Jan 2022 20:41:06 +0000
Message-ID: <20220127204115.384161-16-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127204115.384161-1-yazen.ghannam@amd.com>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4016249b-1289-4850-05fc-08d9e1d57045
X-MS-TrafficTypeDiagnostic: MW2PR12MB2346:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB234618C21691D9740348196AF8219@MW2PR12MB2346.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8afZxvSocMRHloDSuZr2pjNxMZH6kIXRSOIwIQ1O/mLNZ1Z1QdtHOUVADDca5wYJzBSKGKI5HMEXUEon5XH5EMg0UFztalfVUuTkuRBfDGtDsUsHFxIL4xwsl+woCk5BEA+6UvBU/IovNQ8EvXvmIU0QesUvZXAIi7hgn5tXR/m6Dk+qOtyazHrEaXyQpZDr9Ek2j/ydurvr2HHRlYjE4It9XLjXx2BQ1BD/7kive6R1KMjuMMWedNE6XG3TsZsc0zqcSCOVxQZsohZSyFYdMu+VZ8OXy30Q+bp2BXB8mUBp0irDaqKjVkflcjhRET9LrGD1ynmRjN3GkYUCTD3+ZjJSv2VQUNw7A0mEkUjvvcVjVy01UN0fqr4EYKk5zW68/gY/GWGa9y+mY92FlmBHO6FomYIYxPqjvnbD8/wnc94SMCwfAXuuTZm3HDt0JqDdrhfgFiML4OUWsQxko/Gk6+R6TAYt3rGKnt0TE06HYlbXTEBv1r+z6gZEQ55Bex8ptjJHbEyxZDTmMgW+m+pWTc3yaV1pbs8GSM1i+VrE3BCU9vf/+9weUjVVtW2vJO6GPFLB8hbKmf9zKkUyi1dHGV+6bctniCaZiKcDfy5x1FHfl3LVzWi/f8Y7vDzJB9YYLMKvrXrxvseuzxGkG4yaATzTRSK6RX3ffy47z3u/nnLlm/O/UApfEEzbNhUjtFe8bEAZSAG4ivmaKOzpJyu6rz3owIHYNZOleu9ul0Z3ibH8EmyVUJb7a41xgFvm/mL1gS4vmgeqryP5xRHxq5S7yQLL7oUnmngGS7/h4pBkGQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(86362001)(336012)(2906002)(54906003)(40460700003)(6666004)(6916009)(426003)(47076005)(7696005)(5660300002)(36756003)(4326008)(82310400004)(508600001)(8936002)(966005)(8676002)(36860700001)(186003)(16526019)(44832011)(356005)(81166007)(70586007)(26005)(4744005)(1076003)(2616005)(70206006)(316002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:47.5616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4016249b-1289-4850-05fc-08d9e1d57045
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2346
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

It was removed in the reference code, so remove it here.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-21-yazen.ghannam@amd.com

v3->v4:
* No change.

v2->v3:
* Was patch 21 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 898f53eaaff3..c3342f0bec45 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1251,13 +1251,6 @@ static int denormalize_addr(struct addr_ctx *ctx)
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

