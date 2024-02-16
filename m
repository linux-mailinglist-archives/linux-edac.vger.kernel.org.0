Return-Path: <linux-edac+bounces-610-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA5D85816E
	for <lists+linux-edac@lfdr.de>; Fri, 16 Feb 2024 16:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D7C284039
	for <lists+linux-edac@lfdr.de>; Fri, 16 Feb 2024 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0BB130AF0;
	Fri, 16 Feb 2024 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lY8z9P/b"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7AE130ADB
	for <linux-edac@vger.kernel.org>; Fri, 16 Feb 2024 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097728; cv=fail; b=ijamsmqi4NF6IdKx+aZrnz1Esruc3qBENwyWGzrTTb6eWXA3zXx8e6arXRzQP0txrCCYGziYMV7giKe0f3SQ21S17nbpvXYz4gp0ChYInOE/D+xVQ43Q96e5xMKCZp8gqtN7fZdbvq01zurgo8f43OosctuEeysTldmfumegXjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097728; c=relaxed/simple;
	bh=MeJpTSOlsLRLK51DUVmWZWvkOSd+Ha8aCxjkBP5mNWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfv8hl5xzsKV0R5UpmKHHtdIfAbmiTD3I5WK/QlegyZje74KUcf2LqlmEiKAUXApbnprmjdfh1lEH3tfKvkD0XSAkjjPChB2YAmIfBmitOnOcF1Kq6TZKdeJp3WsFMdSKh05WJI/TPI3LmqlmbpBwFMwOxKxY1MDcwUof/ZGs/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lY8z9P/b; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLQMshKsOcxX/Lsj9+kzxbba8a8+ZaSoANGjJp5hqtdbrWHGnmVwtuO2E4TokH5LHWrVkj24p6cvUlOXI1/2fPDSci0JWbYa+eAqrTY/eaTNESwzrrB0Yc+D3jx6/BO1JTqRVX/rCJButGx7ehZyrmYWGAVpc1Cy8oSti3LpYeO6rHz0eZa0UFSHKxRh26DZpAz4fhYc4biOX7he8jav8siCm410T6i9jExBMlEO+catuYForJ5mpZ/yOUyNbGIBHfVGu6nzDO0gWTyE+LJOkjBmOKDUTvAzX8EpUe6oxUkRbEEoqU+dzC5WsF+F9LHm4NMadg+D4GLgjlKJGhF/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGFmvzHkdJkIMOIrMrQhMkQaI3myOnwRfBEkRKwUmMI=;
 b=hBrBkGliREmOR7EYccoroRbvolvJzMtukAunNROCIfEEFIBGxIlZ+3OO9y2IwAxFx0JqjUCySLXqDAwIIGQ/Ru9iQdHQJziwfLQPL1mX7AkqcPhesnDoTLdKWcCvSE9dbAZWKhUpTEJEit4QTPl9afjz0lMMRVLFBGDPogyuK1x3kTVXcsWNNN0tlkQdrA9dOpnzva6Fe370uOiJHfaQc3Yk2idr7SDP9Aa9HbgGzRlyw25w2Q6KXaBWz25c1Pss9uXmUdmelLgxCsfp0YGODdJKRv3fxGyCiMFQ/+R1b4LHR/xoLILGoiTLCkpmdRqKFbYfdxlV7QYbrp2fMYtWoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGFmvzHkdJkIMOIrMrQhMkQaI3myOnwRfBEkRKwUmMI=;
 b=lY8z9P/bFit8IDz92XsEzfyc6cGZKzYPDnVCogoyWM9Tp4OwqYW25fRIAxdRCPBbrAIbR9CfJTxRD2hFNZOBcWr4LhnJX9jfUbJJrZon7/C9IYQpRKeCEtlx5OEgtyXMMQX6yUId7b7NHirpHMYiSA5ZcqZQuTZUs9HNG68zuWA=
Received: from PH8PR02CA0028.namprd02.prod.outlook.com (2603:10b6:510:2da::29)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 16 Feb
 2024 15:35:22 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::48) by PH8PR02CA0028.outlook.office365.com
 (2603:10b6:510:2da::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.41 via Frontend
 Transport; Fri, 16 Feb 2024 15:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 15:35:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 09:35:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 09:35:19 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 16 Feb 2024 09:35:17 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <shubhrajyoti.datta@amd.com>,
	<sai.krishna.potthuri@amd.com>, <bp@alien8.de>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>
Subject: [PATCH 3/3] EDAC/versal: Do not send the cumulative values
Date: Fri, 16 Feb 2024 21:05:08 +0530
Message-ID: <20240216153508.26569-4-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240216153508.26569-1-shubhrajyoti.datta@amd.com>
References: <20240216153508.26569-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 40dee27f-bc35-43f5-a500-08dc2f04e30b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0L9Rmw9yqXB/T2AejP1oUDWWCMXX5dfXVE/mLNavBdDNZCYaaNNLZHClPdsPxrJ486hmi7vQwvYsigXrrgeAVjtE1Nxh9KOlPfkZxC1sZnWnfb++reHnQrh+LOaXegBPBCxoqN7+yikBXM09sKcAuyRJLHNKlSekGBAD+dfXTUJKHMsOv8eNvtmoJKtiBerlBgPOBJHBx5zaq1pg/u8ytc4A8EQ2LS+NxYf6nGxILtKqcFs+7qv74+ufvrGO7dF22dO9PpmLzqAePl9tF3209dtyTo68x6EP8pi+MeapDC1HO/1nyd7FtuJ3Isp6Mqr/IdVpItpVEXoJxF4CVY6vk2btLAvvzhjlf/LfDu+3tYrecJRUH7EhBOTG4m7wvuFvrk7xkG0bfLIiP6oNtRFDj9/32GMpI7Wv31AuaJr2IEa2El6R+UjEkFMCJCqPlCyEwzG+dxsKKI9F/kP8qkBKXaSssNOEKBTBctdy0O7IYHfEYIp4SLpdx8oqfAm2WYSw+/oYNaFB86vhai34G0FpJVxih0BHqImLBqrO+1Qmdn8ccOWmA6kWGm0Jz6Dato6YkwXTEjNYUIaejw9qSTtMfU7zdM7fTJe+V+ovWPwNhyWjBJXmpwui1BfUFF9UZK2UIzOrSc/2AxH5GeT41zKmSw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(36860700004)(64100799003)(40470700004)(46966006)(83380400001)(356005)(81166007)(82740400003)(70586007)(70206006)(8936002)(8676002)(6916009)(4326008)(2906002)(44832011)(5660300002)(426003)(336012)(26005)(2616005)(1076003)(41300700001)(316002)(54906003)(6666004)(478600001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:35:21.4708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dee27f-bc35-43f5-a500-08dc2f04e30b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931

Currently collective errors are reported. Change it to
intantaneous values. The cumulative values can be got from the
debug prints.

Fixes: 6f15b178cd63 ("EDAC/versal: Add a Xilinx Versal memory controller driver")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 drivers/edac/versal_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index e776d8d79ae4..8ada7a960dfc 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -425,7 +425,7 @@ static void handle_error(struct mem_ctl_info *mci, struct ecc_status *stat)
 			 convert_to_physical(priv, pinf), pinf.burstpos);
 
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
-				     priv->ce_cnt, 0, 0, 0, 0, 0, -1,
+				     1, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
 	}
 
@@ -438,7 +438,7 @@ static void handle_error(struct mem_ctl_info *mci, struct ecc_status *stat)
 			 convert_to_physical(priv, pinf), pinf.burstpos);
 
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
-				     priv->ue_cnt, 0, 0, 0, 0, 0, -1,
+				     1, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
 	}
 
-- 
2.17.1


