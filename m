Return-Path: <linux-edac+bounces-609-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B71D385816B
	for <lists+linux-edac@lfdr.de>; Fri, 16 Feb 2024 16:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B52B2825EF
	for <lists+linux-edac@lfdr.de>; Fri, 16 Feb 2024 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C49512F369;
	Fri, 16 Feb 2024 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F7ulFDD0"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5912FF6C
	for <linux-edac@vger.kernel.org>; Fri, 16 Feb 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097723; cv=fail; b=e1EslB9k9gHMJg8BwYjfgWv82Zarx4iCCVw9LD17Die5cuc2K2ruy/vQx4u0VdUjQCMLd1DzQRzcVPQb6M0eXe7nf8F3vZnttMsndrXy9qUqxurQ/BerUsr8yK74dLgImeoQf2fqG0sweW6pC1uaaOxumyEe3rxpXfuOt9CXmKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097723; c=relaxed/simple;
	bh=Fbl644dynOkySPCnwmk9vFbdITbSyT/K5XjYPBpzq48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5N7NSD72JYq3FdNTkBb089UWJ3SfKtaxvU8Uh2fFzFnrbpe/eHK+O2Z4iiJKkzsCO0m3yLMztYDrOvssAV/4hCscL6hLWLa61UPNAGtm6H/8AOVEaIVLdgzuv9PcFOMijEc6qJppyPOjwi49n7aBaUMHbWsjaWKxcyqfsZCUQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F7ulFDD0; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSg+ObNhOQnBMzzhol3oiDg6N0W+/EkHgpYbs+A+rfU8opZ9acrLK+d2i32EaXC9e7ZdT2q3VGTMQMa2TmKZn05Wz2+fwnWSv97OK5Q6EWjeE3gmbfQ1wHsnrwfzc5vrHXcedPOz5tEVcuvb9N+Hdj93R0P8uvjDmqHks/JqgJ2bpzf3dwXXZrAe2A2E9AGPP4Cw/Vbg8vzeITbT6zuObTkJbj4CXnkIrRPtASOs68iTp+XrwGQQY7kwFBij1ay2IqELGA1aSLyHKhCrt7VCfrQPQ3HPai59UrbbMclN8hV06gKmBpRlawDIx7QFy4V4ILBn+fVJMI63nARl5cwNzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xI5UZIwFMKhJHNiliJQysNcK7YNpiiAbGi6ZHY1hZvY=;
 b=YLxIopdziQwWeMcKNhRNwl42xs2mYIbrcWJVqwgX8TeMzTxE89xwc9ewe74XnC1gGMRrr9/GyfpNUzuldtPpxj0HemcvdESsf0vc8SijUOtUnGIfAIQtSB5QA+1UKOmVwdXXzo6tQ+ezTaqNdKjs7RIc/vvuVE6HaO9VV+MCWU/CH3o55NNpuZVqBvMppLj6i/OsMncYu/dFnWdc8LJW9YvtSDMMCGU4g7jRzVZURv10feCoAVhnyFz61sDQ7PY6JWsotn4XARLiGa4XxKo9BtAe9Ic3kNAfZuf3GEAlgjiT6AqZgdlT+ZpqmvdIZeqLnocAd+tvRk5cs97s9TLv6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI5UZIwFMKhJHNiliJQysNcK7YNpiiAbGi6ZHY1hZvY=;
 b=F7ulFDD02fwrHG575+GXyfPLXlthnvoJDUVK4w1DKVpzfYfuvsngwwHeX1yBm36CYF6NQoOlbxrr90pAFIyy7wT2K7OU1oi1V8RrntImgUxwFXKS5XBR7qhPAW7kdGKUwh/9ZGnUi4Dp1hTbzZ8dSGAZ9oytfk3rJreQ/vluzaM=
Received: from SN1PR12CA0067.namprd12.prod.outlook.com (2603:10b6:802:20::38)
 by CH0PR12MB5332.namprd12.prod.outlook.com (2603:10b6:610:d7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Fri, 16 Feb
 2024 15:35:18 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::31) by SN1PR12CA0067.outlook.office365.com
 (2603:10b6:802:20::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Fri, 16 Feb 2024 15:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 15:35:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 09:35:17 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 09:35:17 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 16 Feb 2024 09:35:14 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <shubhrajyoti.datta@amd.com>,
	<sai.krishna.potthuri@amd.com>, <bp@alien8.de>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>
Subject: [PATCH 2/3] EDAC/versal: Add a NULL check for the user passed values
Date: Fri, 16 Feb 2024 21:05:07 +0530
Message-ID: <20240216153508.26569-3-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|CH0PR12MB5332:EE_
X-MS-Office365-Filtering-Correlation-Id: 54455dc7-ac31-4e1e-69b0-08dc2f04e118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kv2R8g8fRvFEMuwRHtCwZzWzN3xVLlHot4D4BJBke1aZQxyqmQWf67WNUuQc/F3ErKbpX/AludfSEsFD+KhL8a7cts9XxXy0tW1xdtA3jp5xIVe1ZDELtPlH0jjYnUf8q41la1/ffOLdFEIOngR1v99Ol9R79AwLk2t5KdIfOEv9Li2lcawCb46UxaQhNAuYPWLjgcU9dseGtqFi8ctEYz2ZXtw32cRxLsBNJm5uJCLDDlHFW9Jw2rAkyCha7+TI1eo+7YWvXxqAkdJ3DSUb+F7UlEJnDsDn3eMshI8o8znugj+8y27sxV7v/qIDDtCjsaI2Jp6p9k8kEjj+0ioHT1xKBURnPmpVZ5hAcT1FMm8Bdt7PJs6O37uPuezAXzYRVjEv3cTQWUPRBaVKZNeu4M/nW1ecRGt47WKzlV06yZoIXV+5PuXpVD7lucEnxZP4gnSwAdmOSDfSAwmoxG1HaizvyznJs1EjA/viUGFLz0pkA1zh/AkI5mP03c0aV3pvacG0aXKHje0vnS1VoMo/jNbguhfLCP99TTrFC6V0DHd+JxCp3AfqqNYqom1wcmTQ/UjSEFO9srosoqMg/vweGRLEvd35UBHkF8xNm0xSj7gzJeculCrh4+6h0RdoQnxj65ZQE/GIrFujCfcJVj7IOFAkfjiTJrjCmohJ/QRkeCY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(1800799012)(36860700004)(82310400011)(64100799003)(186009)(46966006)(40470700004)(4326008)(6916009)(336012)(41300700001)(26005)(1076003)(8936002)(2616005)(426003)(70206006)(8676002)(70586007)(81166007)(478600001)(6666004)(316002)(356005)(82740400003)(36756003)(54906003)(86362001)(44832011)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:35:18.1991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54455dc7-ac31-4e1e-69b0-08dc2f04e118
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5332

The function inject_data_ue_store() lacks a NULL check for the
user passed values. To prevent below kernel crash include a NULL check.

Call trace:

kstrtoull+0xc/0x28
kstrtou8+0x2c/0x7c
inject_data_ue_store+0x10c/0x24c
full_proxy_write+0x60/0xb4
vfs_write+0xb0/0x374
ksys_write+0x6c/0x100
__arm64_sys_write+0x1c/0x28
invoke_syscall+0x54/0x124
el0_svc_common.constprop.0+0xc0/0xe0
do_el0_svc+0x1c/0x28
el0_svc+0x34/0xb8
el0t_64_sync_handler+0x100/0x12c
el0t_64_sync+0x190/0x194

Fixes: 83bf24051a60 ("EDAC/versal: Make the bit position of injected errors configurable")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 drivers/edac/versal_edac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 26142852dd87..e776d8d79ae4 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -865,6 +865,9 @@ static ssize_t inject_data_ue_store(struct file *file, const char __user *data,
 	for (i = 0; i < NUM_UE_BITPOS; i++)
 		token[i] = strsep(&pbuf, ",");
 
+	if (!token[0] || !token[1])
+		return -EFAULT;
+
 	ret = kstrtou8(token[0], 0, &ue0);
 	if (ret)
 		return ret;
-- 
2.17.1


