Return-Path: <linux-edac+bounces-608-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 354C885816A
	for <lists+linux-edac@lfdr.de>; Fri, 16 Feb 2024 16:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598B01C213B1
	for <lists+linux-edac@lfdr.de>; Fri, 16 Feb 2024 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3C812FF6D;
	Fri, 16 Feb 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3KUsrISx"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9254812F589
	for <linux-edac@vger.kernel.org>; Fri, 16 Feb 2024 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097721; cv=fail; b=KECrXZ3MGzX1hvo01vhjbFAg5SlwBYgGQ0G7cuySawe2UuYpcbFkRM6/oVvAmmhYR59Eb9/ITl0KjeIqlk8gHpufiF1SG23lN94247BW02xnWIYhqN6FFAk+1uJgSdu2+KbUc/ZrnHtmU6VmSGJc/+ASjNLcT9huyuq7GEIgRo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097721; c=relaxed/simple;
	bh=uXYWeyzQPrVeXCTry9d7P3/g5i77aasLCnZLkZYFh7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjaHPzCfrfB/prjX5wWmox1sHImo0zvh/hqdHEWEPik2qRgFnnVRDhwBB2ctAQmP0yi7KtQL+tKmz0OkHCWSVUqBdf7su2kBjnIgYhsQHY9KgpMUoXO9wE2GMiVP9OkLb9CAsT2gqLEnyqcn+JF+GpLCsoBsoo4t3WTaLlFJwNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3KUsrISx; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvdDhVWHpQVl8ohOOP8/FuNrPph5ALJYc/oOwttT3Cx+SmyVpLjdG0Rz1zFnmMxa9bcq+t7NtG+iliz2QAuBCefrsg1Z4nHm16CcWOdyFXnfFuaZukS0AeondF+bFBaI4vUNwep5JeTNkNn3HjgdazCRm5Cq0ohIDyGU/ZuShqiNly9P6Wh+W3x+sKqUEVy1WJTc7/SOZXe3xiTq3aknZp6YHcc7DhXGbJWURPciUxN4IMmFlYOFIb0lA2z9qU9MFoynEUi2US43+eBDjXZQo4k6tjgFgSocC+sM8u4jzAwbKqpzgQ7bpBBuUFuYWI3wbxQ/14479E/q8qOO24SzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pn0svHYDFIZX0eVg8UORAzsb/N+Umw6TFu0U+A9jiU=;
 b=jnhaH2NBAHPGd186UeyM60BVmYBwWphFtYLOA+5X6OZDMG6oxU2RCPKzWs560sOxJVSHUcDbdfCPQY5pOE+b2FRLfxn0+/HMiSJ1XS/ZXA/mVpgIAYaMncRjEzZQ/oo11dSYpjk2U1IGiDKKL9QJuqhsCVE8usHKU+rG/OaLbNwDzOhdsjdjyIFLH2DDYfZspjx9MuWX0xVhsLyohgRq10ModjewnXZgqmx0ZVTZAXZTJDfOsSwghmDy43t/UX20jBbyzmf8QdShHkmGuBUQmj8J+0vDuf15rPC3fjx/9Mk4P1TE9UZZ+7FGvWybHMCr3snCQjAiCpycM1Vjy3velw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pn0svHYDFIZX0eVg8UORAzsb/N+Umw6TFu0U+A9jiU=;
 b=3KUsrISxeqEnEwDZfqUEvCvecVHbISlUTXaqsiT1v6ruxXLX3/PokYXd2S1YAcZwNQusRIu4uN0vGfpbjdXzerZiiuvmaP/5pt2oBmYFgMomTZv6IGXDRiKjOkF7cxfMXDmIFb/GjBCfzPbJeYtEHket5tl3aPsiiOC53PlMjrI=
Received: from PH8PR02CA0043.namprd02.prod.outlook.com (2603:10b6:510:2da::12)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 15:35:15 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::30) by PH8PR02CA0043.outlook.office365.com
 (2603:10b6:510:2da::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.41 via Frontend
 Transport; Fri, 16 Feb 2024 15:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 15:35:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 09:35:14 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 09:35:14 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 16 Feb 2024 09:35:12 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <shubhrajyoti.datta@amd.com>,
	<sai.krishna.potthuri@amd.com>, <bp@alien8.de>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>
Subject: [PATCH 1/3] EDAC/versal: Do not register for the NOC errors
Date: Fri, 16 Feb 2024 21:05:06 +0530
Message-ID: <20240216153508.26569-2-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c2e577-c7cf-4baa-03ec-08dc2f04df67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z1mji1AClYu3vJqVx0GMFlAvQgIPozniWGIqPINjZf78zCMJiRhDcCg9zMg2OFwouzRJe6Pr1wjCInkz96u3LUWuiJZU8EYZ+b/cA47IduLoTeroGAHfuVczkcHSRZ25VfKAQwn0hUdVv5qnDUouPZ9m1tYDfBq0WvV5a/+tKByf9nJnFv+pZIN+oRvtETnX3nvEnfLBYcEYn12SlNQlDhXBxrOMr2l4Lzju14Vw7UfYgVF7oKyF8/4vBgxI0KXEsh7fF4YilUFlhsBtzJEkqdVg//ZzcItkczCZLFDznfzc7mrCs1bheJOct98DIPIjaLHYu+wdSqh+JpzOSTMHWY4AHqYyetxdGVpC/wmzPFL4A1+NjEEQzqR+3Vgv+LOy3U8uwpw5U8V0Yv5687RNmNt4UFz8njyiAODwEPS6P4+NOt3kK0J2xoJzYxiU+Ds9Np8OWuogzvpNnI/VDbP1REan7yBlHH2z4owY1yTTCYhczRXpednGSiu+WfxOZHCo4SfO6t8mGlWfYDrYuv+C43bBfD1oxSShuIHGvmsXK8mSj0ChSSRS3ZaQ7ie0mjOj4InADEoN+H9wUq94eewDS6glHw0DZGhpI80GApzWPx5T/gORl7JPKeoQRN5+mKpeVC3IdL+3NbsbSziQb9U87ylj8/83jZ9YXOMGviUATaw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(36860700004)(46966006)(40470700004)(5660300002)(2906002)(44832011)(41300700001)(478600001)(26005)(426003)(336012)(6666004)(54906003)(2616005)(1076003)(8936002)(316002)(70206006)(70586007)(6916009)(8676002)(4326008)(83380400001)(86362001)(356005)(81166007)(36756003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:35:15.3587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c2e577-c7cf-4baa-03ec-08dc2f04df67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341

The NOC errors are not handled in the driver. Remove the request for
registration.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 drivers/edac/versal_edac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 3016870689f1..26142852dd87 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -1135,8 +1135,7 @@ static int mc_probe(struct platform_device *pdev)
 	}
 
 	rc = xlnx_register_event(PM_NOTIFY_CB, VERSAL_EVENT_ERROR_PMC_ERR1,
-				 XPM_EVENT_ERROR_MASK_DDRMC_CR | XPM_EVENT_ERROR_MASK_DDRMC_NCR |
-				 XPM_EVENT_ERROR_MASK_NOC_CR | XPM_EVENT_ERROR_MASK_NOC_NCR,
+				 XPM_EVENT_ERROR_MASK_DDRMC_CR | XPM_EVENT_ERROR_MASK_DDRMC_NCR,
 				 false, err_callback, mci);
 	if (rc) {
 		if (rc == -EACCES)
@@ -1173,8 +1172,6 @@ static int mc_remove(struct platform_device *pdev)
 
 	xlnx_unregister_event(PM_NOTIFY_CB, VERSAL_EVENT_ERROR_PMC_ERR1,
 			      XPM_EVENT_ERROR_MASK_DDRMC_CR |
-			      XPM_EVENT_ERROR_MASK_NOC_CR |
-			      XPM_EVENT_ERROR_MASK_NOC_NCR |
 			      XPM_EVENT_ERROR_MASK_DDRMC_NCR, err_callback, mci);
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
-- 
2.17.1


