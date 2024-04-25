Return-Path: <linux-edac+bounces-961-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3058B2185
	for <lists+linux-edac@lfdr.de>; Thu, 25 Apr 2024 14:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85451281E64
	for <lists+linux-edac@lfdr.de>; Thu, 25 Apr 2024 12:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F50612BF33;
	Thu, 25 Apr 2024 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OjmLnecI"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A25812BEA1
	for <linux-edac@vger.kernel.org>; Thu, 25 Apr 2024 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047600; cv=fail; b=JvYteieTYJ8qhWT3mRDJ2Km05zGd4we87pLnOIMpz0MVz2G5HG3P3SI8BFS55ym0hI410qVBbFd5VcBgw2PFoSHQak+woy6o3GMbH41fA7f7AGy8o/LREknSuEVRP1Ia8uamPV8iT1I4H3/LFstEWs7TdLsQOCNPm7ZHio2EOGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047600; c=relaxed/simple;
	bh=OWXV6BSXnOC+1KRUZzCRMOhv3uwRYq6lJGKIV6tW7Yg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFRMij7JSnzx3D7qYn542rtTUUckM2vBu5nvhYkhPTeUH0enaVcZawoYZGEITw/dXjF9vg2PbmCOvh9CzF1Ud4gTHkFxVKs12nudCRTHTEGcJwY9OR7RNGpEdn3pipLD2I9YjIAj08Q3gs5TRWybyIZYQ4T9SDaZUQOMTKPyAXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OjmLnecI; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obNdQYYsqHDtyFZ3oytPjHJFG8mD91dazDf/QdWCT0JvEPaXBwKy7M/KIEM8evDn6bN1prFTs5zwiHYjKhO7whhKUis8u182CGwl37X8jNkm7ytB/5PmvvJF8GUFIFPS/+9iwuZsKnMXmA7NHPK403Svc1LEOZZ9g+RJDYFLZ2/IDrDsgRRCwyRya8v45FQReuA14xEZtINXSQ/4ejU7kXyVmQSsocMY6bQz0y1pOHMQ6qSxuW8t3LYLUphIK8qPG2hX8A27puateMY2fDoZ3iy6niVQ1hameiqt2N0xq2Vmlkteu7UQ0SUTqQBRDYgpA4MP3WGYyT0/aqIFfW3T1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yx5WShIEA9v6c11TqVCRD5oeLQDSrTRrxF5dguiSfUM=;
 b=DkJLowcxqKuTequ/wAPsLQPT/kbZXmt+tEggEQB23c9yDeNXCvolt+zaP2RMtFZg3GvR6gt06ZS01Ot2zfLpA5IggDlX9vCGxg4YTZmM9pJqTwmye/6iiCgZZF85ua+s6FegaY6jfpR78B6/+k3AkgufqwbFjXKiPpV1Z6XQSpBwQEZx/NPtABm1KC8QkD9dACinBb3rnaKHHBAL22ZhuPUsug7DoPtMRTuG8d+AuCDYH+rwznh752+FPTAEuId3z/eTk91HqbVqDttk9Q7iDxF7dMr+LuEn+gL7rO/HYKa6laSYdxhaYDuSG4xgxg7iB/Hc+Zg55cJmOhdh0rkM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx5WShIEA9v6c11TqVCRD5oeLQDSrTRrxF5dguiSfUM=;
 b=OjmLnecIwGgplul9PIEGalP2qbO8/IB4L6EkM/xykKYUYOy++PVX4i2w6/hhUa+DooP/7xL9YfzjBfFXeurAh/UUFdh/kyPZ3Tfl8DXy5MRy4qKzd+dStl74ll92Ym5UUgNhkexPxuRJyptPefhBkeVxOq0MpWUiwqbBQCD2bzA=
Received: from BN8PR07CA0023.namprd07.prod.outlook.com (2603:10b6:408:ac::36)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.48; Thu, 25 Apr
 2024 12:19:54 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:ac:cafe::35) by BN8PR07CA0023.outlook.office365.com
 (2603:10b6:408:ac::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Thu, 25 Apr 2024 12:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 25 Apr 2024 12:19:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 07:19:53 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 07:19:51 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <rric@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<sai.krishna.potthuri@amd.com>
Subject: [RESEND PATCH 3/3] EDAC/versal: Do not send the cumulative values
Date: Thu, 25 Apr 2024 17:49:42 +0530
Message-ID: <20240425121942.26378-4-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240425121942.26378-1-shubhrajyoti.datta@amd.com>
References: <20240425121942.26378-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c1a2df-2b1e-4426-d9e3-08dc65220392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UaiHyXlXcLw48fw85IuwE3G9F8IdCzr7mLKJhs5jr/quSZd0iTZwVpmXVXrF?=
 =?us-ascii?Q?zqActwuBDQSzGV4s9U8m1FbTTzGJMaAowPFT4AfKNwfGM+8rZpEDyYpGdgoH?=
 =?us-ascii?Q?Xu9vhUTKGOF3u0T3xSiiRQmiEK95KV6hL+vDAA2y5y+tROvr69ppnY+9c8sM?=
 =?us-ascii?Q?Wn/KP6hckQ6b4LQVLYM8xYCKHuabEYkbw4gcWg1ARPKYFItbpp/0V/ach8gt?=
 =?us-ascii?Q?Xno/9fH/OwJF61qJ5urXzXVcXQM5cYU3i5pPemGND17fJgIoYhRqCpXVzJx8?=
 =?us-ascii?Q?e1wVTYMd4NWXSd1DtzemZ3l3/xWjdG5FqjWn8hZSKkYEXrjzFJCxrGTsMPCM?=
 =?us-ascii?Q?pzL8U2sCKmzcIEuMQFn8BZjJ2Xa9jEq59o5YRCpKI7LRCAf6hUtpJxq9FHr7?=
 =?us-ascii?Q?Qa0XaOHQU5/rQ/yfNZiZNwY5798yGiCw5rDIOLT6G10DpHMrrYKHxUSsRYGK?=
 =?us-ascii?Q?bPvD+toYX2Om4hXoyYtVLSta3HcIm2gLhLCGQHEAg507rvaivo4zVEQS/zba?=
 =?us-ascii?Q?OmTOo2dlBhc7y06DgrV342TZm6W7muarugdVr1HIyX6Onwq41wfCWhOBLUAk?=
 =?us-ascii?Q?tc9fiDZg+0P3nGTAR4fp76m2xn3VgbhUalyaXnnm7k0ri8EYrBYhak8ujA62?=
 =?us-ascii?Q?UNLKMivYqHVEbTtozeeuG0kPK/ruYHiLKT6qzJFpuHCxxPYsBe8j+IYBKZKC?=
 =?us-ascii?Q?70v6Z++Mo7UXn2oQQzMVeEUT9lWEVodL+33/rc8tF79YrODmDM3zvuJSZ/mp?=
 =?us-ascii?Q?abytsSrlwQiVhuP7nJSougjOQd513X8yzMwN3JwFIjV3YzDuh9fbNwNzIXp9?=
 =?us-ascii?Q?EdhNji+RxpuXhvtVlpoSUWpDkFJGC74E4gL+SPV0QK9fG2ddkhNoEhaYdU+5?=
 =?us-ascii?Q?R838bhBeM7esZdlkNYqsDf5tiLCxcoHNDRykNdcSjK8XlyxRYFqfXmbi9dg0?=
 =?us-ascii?Q?2WObAZdeSRBHWYq3vopzSBGCwhR7QmdHB1z3l0xJo8Nx4jugNB2HAMLuim0H?=
 =?us-ascii?Q?3unwkixuo7TCg/F1DaB9eGCqPBNPMrETzAuY3SNPBNhiOCe19dIEJlSfdpkp?=
 =?us-ascii?Q?rTLevqZmIdVtkdPTkMZTYLkENXcbfyWUeFfqvAFyzz+iSpUMEwF9Ot4gOOld?=
 =?us-ascii?Q?4gCFjPfcEB/9bXH7XxvQlxwNeUtAEJw4GhL2G954m/rgc3PPp4avuNojl0Ef?=
 =?us-ascii?Q?KeH0LPkgZJbjubRKYkiuDp1R2D/e9xeHXL+XDZ1bJ326N/iJyI6LbzX33u3o?=
 =?us-ascii?Q?7ib5qTzpZmVq7LvSlJCXdMcb9Zcwnq+8gf6mHtzNRTkzHZxuFQA1V0AayrnJ?=
 =?us-ascii?Q?F18gdAgyTNUNc3d/nIccB3jFp4GcldiEIKGeDzH54Jj8cG7iKXYL5igCuMO1?=
 =?us-ascii?Q?CR+lXmE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 12:19:54.2704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c1a2df-2b1e-4426-d9e3-08dc65220392
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515

Currently collective errors are reported. Change it to
intantaneous values. The cumulative values can be got from the
debug prints.

Fixes: 6f15b178cd63 ("EDAC/versal: Add a Xilinx Versal memory controller driver")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

---

 drivers/edac/versal_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index a1407a399ed9..08e9f155d7e3 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -506,7 +506,7 @@ static void handle_error(struct mem_ctl_info *mci, struct ecc_status *stat)
 		e->type = HW_EVENT_ERR_CORRECTED;
 		
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
-				     priv->ce_cnt, 0, 0, 0, 0, 0, -1,
+				     1, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
 	}
 
@@ -520,7 +520,7 @@ static void handle_error(struct mem_ctl_info *mci, struct ecc_status *stat)
 		e->type = HW_EVENT_ERR_UNCORRECTED;
 
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
-				     priv->ue_cnt, 0, 0, 0, 0, 0, -1,
+				     1, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
 	}
 
-- 
2.17.1


