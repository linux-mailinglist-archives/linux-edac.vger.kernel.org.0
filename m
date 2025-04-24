Return-Path: <linux-edac+bounces-3703-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A126A9AED7
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 15:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B824442EA
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 13:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8948A27CB21;
	Thu, 24 Apr 2025 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LTAeIcli"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E027C866;
	Thu, 24 Apr 2025 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500908; cv=fail; b=Z343cseqsGkSVOfilFoVzp0ommEUPsRridAjhLO/ZGjUFd7ofy27ZiPZ9CzzfQ7PxlVPz+aQ2q/2WGO7hvkBhnzOWC3nWhXRi+mrvVwo929HGJbnnHavB/9LchG3WqYu9Emf2qiw6Rwx6og42UezBoWFL7I6AJ1tMsr6I4Lhl7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500908; c=relaxed/simple;
	bh=Ir/NiN8ZY1/QVsRUqCmifba2LHV0u2NUun2KIhnSQDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjTEhho/MjG4Pcc3Lt+CO285yRKd3o75cxyldTbArPBASkBFBhFjFKMRxHeGW7DlrbCDKPUPIlF5aSq/ZLqrjyM/86VTHnghpMIB4RZH2mqPPbAOL/6swPKTDw7cepc0KW3SomK9cneBygTHtsd6qvVPO6JTIfc9aovTQXH/7Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LTAeIcli; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prkRUkGJHhmUmZO3fse3OvjyGRroPu9rinBIgz1YygNjXpQVsUBketW8ja0snh6Fw8QxEKj8t67wgnCJ6oH8daocQGmM//HCElw6QfKjFCTGbdjGVxeSf8NGakUITE2u1WiY1XftSqC3kYw80U/pdWe1u05zDa1DSuKhNoBvQCd5pNRvV4sSk6+ghdZ463gbbWbEm7izTHGxiOpcQVbVTE2vzo14y8GtbifO3Vi1a8O9bvDGjj+ffatYt0Mdwj/nlLuMHzdD969TZg1/kDGWmgLRBRJ0oTv2rgAc5ceTMyPR70mGayNam5B/5wi63Pwzgjf8frPw3uK7Eqz9sAf6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFgpbrTb9CAOPMLirvHZN6X2rBzECsN70S7XoCxZ1/c=;
 b=iq+z4uvfcDopjqF2QlkC+7BmJTGCd/jzC6VFkObrzkf2eT2Qh0d2VL7Ly8jtlQ8wZCqaYfy83aOlpJgrV3aupy9Sc7/86M7mP7svF72Qpk05LE5YeQx5q10gDMQobSFi2rAWoSAvOckv/9ZXHrT6M2OE1GLTyDAegPVW4tWqDpd/PL1uT4RiQCsnP+LL3qloq4LFtvWyzODB8ac/Q9GJTvAwhP7Jn9x/hClccaOGRj9bNYa1yMU8qBeS+75b8KN8V49DZEDDaE/YOSzj/Qnf4lGiMlnuUN81pG8Zobo7i9Mm6ZRFcr9IPmFHHegdOMUGhGIugVjsWBWiAFKMJlUwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFgpbrTb9CAOPMLirvHZN6X2rBzECsN70S7XoCxZ1/c=;
 b=LTAeIcli5VPfqkm4qGQ3dvyfmybV/0aw+cJ7SeQCbJ+N0jMQ+q37evvTNP5hWohXpZuUC63WIxiHeVxewCeM+pISvi9szs/BSBWrQCROlkyNKj+XcE6WnbmvfdwmPrY6PbwmHr6RIxtKAvWqRqilh++zqxsU6Q1CnrqX9Nc7prU=
Received: from SJ2PR07CA0018.namprd07.prod.outlook.com (2603:10b6:a03:505::22)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.24; Thu, 24 Apr
 2025 13:21:42 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::b3) by SJ2PR07CA0018.outlook.office365.com
 (2603:10b6:a03:505::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 24 Apr 2025 13:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 13:21:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:21:35 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 24 Apr 2025 08:21:32 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, <ptsm@linux.microsoft.com>, <srivatsa@csail.mit.edu>,
	<shubhrajyoti.datta@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH v6 3/6] cdx: Export Symbols for MCDI RPC and Initialization
Date: Thu, 24 Apr 2025 18:51:15 +0530
Message-ID: <20250424132118.17074-4-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250424132118.17074-1-shubhrajyoti.datta@amd.com>
References: <20250424132118.17074-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: a74298dc-0925-4999-8444-08dd8332f358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pfan0AVgQrNFXB+U19kgPkAk9MnSvCapXB0zZWSMcKI9ffuGThcs7tbcBlqT?=
 =?us-ascii?Q?b5a/RjbMIUHUiC+UJW6xPseRaMm62bzV0l59sqhHgDag2Hdid4dLAZo9jGed?=
 =?us-ascii?Q?RJJgDty+LlPnMr7bS/xbEg0a+AVpDuWWUdAyvktbjADHO1UkFWBEula/8ryv?=
 =?us-ascii?Q?tX/ru2P4uDIp1m7YQvP5Lwlad62yyBuIVnCM4cg8eZe5JIFi7MmVgV5GaMi/?=
 =?us-ascii?Q?JejkEErlRmP6WCMc7hCmkDbtD95fkdiq4d0JLg5dMNlx/4uz3whWBROGalIb?=
 =?us-ascii?Q?OZG7diwdjPi7rce98gYLW/uH/4RtKLU1L7U49nE52d6LDAt8fgjMts+bUNAe?=
 =?us-ascii?Q?CSPerhhYu8W7W7UWNn00WmI0HFwjfOVJNXmMkvnbZaPEg0iM4vIIuWczJk3d?=
 =?us-ascii?Q?NUDUDDLhmrsoqzDNBKFPkR4i8dKnUTZdN2rXtesVGLfg3RR/5m+yaSMCU4XT?=
 =?us-ascii?Q?rU+uDLJhElkjOjaEhAdyqUuVkFYLGkzYwmkxx9oNVOFwSYJtAs5SetH9AwJf?=
 =?us-ascii?Q?ePtXXaIafhk5S0M033MeggAKyTXLXPDnvEovtQg9tQ1mxa0ibVnYdAL7dJ22?=
 =?us-ascii?Q?zpY1QXMtM5cJG52z73iEunV5jp8cH5hqpicRuStPhUyD4YSMvbNyuckGzvcS?=
 =?us-ascii?Q?plCo/BMTHWL3rtDAywVO0U/ZziWd3cIfx6DgYNvcR262W/2adem/XdTe/inv?=
 =?us-ascii?Q?VQxonLQMDG+j+AfLi/VM36jGGf2cnKEGMW+kNIxwnKeOIBrUtiO2zafc6gWW?=
 =?us-ascii?Q?rjTkqIeYRYB1Tohz81JxGGq98t+gJl904YEbRt/bIDG6OxYOedqLOuPcXxoy?=
 =?us-ascii?Q?NsorMb0mcykg21phX/YwxtTopn1JmSHBTOj/W18ikjx1vvLrPxOPy3U+CTa+?=
 =?us-ascii?Q?/r/yJfKpAY7YxyN/hF1oIgEHfBPPsTCNCaIg4UR0YVzBrUrgiw/zZcxg+3p9?=
 =?us-ascii?Q?Ug6MP+sjBSbEhpIrqSV4m2u7woQltm8EwpHupcaEc2QYWUjMA726qUbM1+X9?=
 =?us-ascii?Q?qq1meb999EfXJxebpkmg901epnXzzYEsaqd9Pt/yYFCh7Ngau7/95/TCHGZB?=
 =?us-ascii?Q?LVzp0ozkDkvM4dRXF1hYECD2OulsY4SzkAuIGIL2WSR08nHulNYJu1t9gwCJ?=
 =?us-ascii?Q?hs5jVX7KESYeb+eKIBL86uA2S+TPdPoWnE3oUlfS3y21zkmyV7bX2LW+4Rhw?=
 =?us-ascii?Q?G3zdA7sZm9wP8cq6VR5XapT0xEB8j6PnvjDaao9ENq6NcNG57hizAsR9efPS?=
 =?us-ascii?Q?rDFK8V+S0yv6v+t/fCzntP543dF47AvfM+/rtz4ehmyvIPBZSMquqcC8V5Ex?=
 =?us-ascii?Q?1iTnKgKy+8NFtfFoJpHq6sexJKstS1VaV/IK4a0CgANDDIQ2NRrOPSNkuDTB?=
 =?us-ascii?Q?OS6Gc/DbX4aHA/madRlQXJJIrhPmMeQVHVoIKklqjoFxFf0f0IpTo4dcVJHn?=
 =?us-ascii?Q?NVPtOc2QJGtZvh5Xc3PAthnETXzBYyp0nFRjZN3g0gJmqzEB/Lz54oeudeMf?=
 =?us-ascii?Q?p+Aa6Jqt3dN5zZ7gFa3m9Z43B4AmmuZk6fBb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 13:21:40.9183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a74298dc-0925-4999-8444-08dd8332f358
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039

The cdx_mcdi_init, cdx_mcdi_process_cmd, and cdx_mcdi_rpc functions are
needed by VersalNET EDAC modules that interact with the MCDI (Management
Controller Direct Interface) framework. These functions facilitate
communication between different hardware components by enabling command
execution and status management.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v6:
- Update commit description

Changes in v2:
- Export the symbols for module compilation

 drivers/cdx/controller/mcdi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
index 600084e81a86..632d3e7666ba 100644
--- a/drivers/cdx/controller/mcdi.c
+++ b/drivers/cdx/controller/mcdi.c
@@ -126,6 +126,7 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
 fail:
 	return rc;
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_init);
 
 void cdx_mcdi_finish(struct cdx_mcdi *cdx)
 {
@@ -588,6 +589,7 @@ void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int le
 
 	cdx_mcdi_process_cleanup_list(mcdi->cdx, &cleanup_list);
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_process_cmd);
 
 static void cdx_mcdi_cmd_work(struct work_struct *context)
 {
@@ -755,6 +757,7 @@ int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int cmd,
 	return cdx_mcdi_rpc_sync(cdx, cmd, inbuf, inlen, outbuf, outlen,
 				 outlen_actual, false);
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_rpc);
 
 /**
  * cdx_mcdi_rpc_async - Schedule an MCDI command to run asynchronously
-- 
2.17.1


