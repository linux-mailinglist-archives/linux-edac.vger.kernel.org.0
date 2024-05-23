Return-Path: <linux-edac+bounces-1088-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 215DA8CD7E2
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 17:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1B4281868
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 15:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9920A12B7F;
	Thu, 23 May 2024 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vHLjVgG8"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA114A85;
	Thu, 23 May 2024 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479821; cv=fail; b=d4Y1s7R9lb5NJKohCIUM8CjX71tB4jfIfjwd47nQtyAxqyLr5fCrJWbYotzetPaAvLF89euq5Z7LVMIhYi3I3R7ey92ebmUNgLpzI8ZxIc3BbvGT3B1ByxzwEkC0e+1ljEOFGqY0brPVwRvmMEKqG4PFcLmj+CSLrMTJ20fYJTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479821; c=relaxed/simple;
	bh=SfI9ahpozqfZvoKbJsm89LSdfRjSwUOVJ7/jbbd31FU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxSkiBENed/PxvmETyK6UQQNR7QiaAorbGK3CE2Hdl92bf/1/W96ndok+K8aF+jUF+u1hT/Y2eMw7rZrXyphd72FB+eUhYltdrDyTEUQmS4aKYM9RSHSfUe+8D0u6XfvFtuE7MZT9XLgsrCwu6otCrW2gOhN940Sj07BwX1vaAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vHLjVgG8; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+CUwuhwkxWBRWHnLFlppUMwwCx36Rtlmq1s3zghvaBtYYq8Gvj9+r+eYRiSOQmXa05Dz8Hy2hd6pczXxNgrvvanjAu20WM7Wc4VBDLyTfbqDuKRPrMKuw/7bxDgWq8w2SuJCIfW9aT0Rsn1TvuPqTtQ9jzq1rd4dUmslFTl0Job9CvGZWaMQCR5+0gFZps7SZLjTgwYH5PHOGmOmEN28aRdgYPD8BUBcAO6oxKxPgcl5qK15ESZFfJaadgqgYSdMpFCRrM1oVlc78PxKqwZPSSuPsS4n8idlXvNscF9qILK1CVX42pkBCAtkb0LrdGl8vFQXn0R7WhtrUOTVptX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SuqSPxBfCfhdSh9juye0BO0nfCPJYvrUQ24NCb+DpE=;
 b=Cq4+T/E7sKVFRTfP3IISC2Z2t09FQyH4+EsI831dUy6H0LjjRHejGy5+j9mSKoJop9MXnik5YUu+xikP2t79ZghYWWF8SMtXceZq8dW/gURE0xvYvnPi4IyHi56sIBX9Oohj0GPOlNMFd8dgYmI43OtWJhGWFgDhc1NelPxmmI0qAP+kH3Yoi/pK3joQiuqtAv8F2Kf34X/XJghxG4z5FD1MCUDJwnpigylmNJlADC9C4txeoOace6nWDH4+2+z12TUGy+rsm3YRsrxx6jxKyQrmyYyLsUAfM0Uz9yC9sWdk2PlUHMVOCgC6m0j/NV9f+iNHtd8A/l9RZEHaxnfM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SuqSPxBfCfhdSh9juye0BO0nfCPJYvrUQ24NCb+DpE=;
 b=vHLjVgG8HnohUlvF85qUj8zuobzHXKCqNJKoTjbxKIpTUls/4QcFJWaEqK77tMgbdbzzOlKhJbtG9MQIOtrJ3JKLYo/DayljIDc4LExWMjYLURckt8FuRJZFtd94+8ac49z89WfNmucpR2x3lvhJhDhxhzZNTFYAXW2x8MTlwzE=
Received: from BN0PR08CA0016.namprd08.prod.outlook.com (2603:10b6:408:142::35)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 15:56:57 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::1) by BN0PR08CA0016.outlook.office365.com
 (2603:10b6:408:142::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 15:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 15:56:56 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 10:56:56 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 1/9] x86/mce/inject: Only write MCA_MISC with user-set value
Date: Thu, 23 May 2024 10:56:33 -0500
Message-ID: <20240523155641.2805411-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523155641.2805411-1-yazen.ghannam@amd.com>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a0e361-48fc-40ba-0fe6-08dc7b40f93c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dOkjwkpt5wzuRVLhHTb5Z8pRN60+CPIdTL5kJ1snSjpo2dSPqXg1+8zPEuih?=
 =?us-ascii?Q?vpWIoHJBZsmAw/O/AUvC/oOT+xM4jNp5lCcE5s81s26qzBhfiRzBeOti3q3y?=
 =?us-ascii?Q?J8qvGHWYROSJOcPWA1rSS3bPi3/V8HKonoUNlEtLroUXWFNiNyfGur2FHOwO?=
 =?us-ascii?Q?1iStJksWYD4wqAstpYp2MmIMLre4n0VP1jwmr3UwdDDa7L1nImlTsLGfPtt4?=
 =?us-ascii?Q?AM/bMFVfSpAb/A3FkqOYEqpbdvP0lLzI0befjwGCYbLHek77djAf6zdQts71?=
 =?us-ascii?Q?M3JUpyjkz5loW+TfITxwCtWk46YXZMzoy6znXJcy38pOux18jOUdbyLS8BXU?=
 =?us-ascii?Q?rG8pQZ+pXtU/XVp3uSQ/FtHcsJqH9sQGPRWYzIRNhqc5NBdy+zkSxftm1Me9?=
 =?us-ascii?Q?mvcG1HcBKOMWPSFmDsMCdFtkAdjotg0LK9wkEepoBh1PK+y2klQoSS6dSWJM?=
 =?us-ascii?Q?4PJOrEa1pMiyG4LVxtM6KW/ybrvB+FcRWdg0KAYs1NbIpYhc1vmBnDD7CCae?=
 =?us-ascii?Q?GZViQr+ByFC6kouGMK4k0DyWtqzf1pFTGhz21DQX+cH+kkP8KVLDNsJkQjpo?=
 =?us-ascii?Q?IcFkTAo/4EXQ/FTkVYihreV9Jj7t+SVRXmu24ZSGgIqQefVNz49mBF/iL/aP?=
 =?us-ascii?Q?K9CrNCFbFlcN6CJjHx/Q25v45hUtpMoEN9cSfUmkuFDqnVItaXdNaRq3GGQp?=
 =?us-ascii?Q?OTD5MSDmbHrF8bmU38zZEcvz7obTDy3wvsgINbeExeonFLi0Y2GDW/cz+dp6?=
 =?us-ascii?Q?DCEz6AepElgDkRX7q4axWkpbOY2wvPzB+eHbOhvMIGjOhJtU/e71Jj4e/TIH?=
 =?us-ascii?Q?6Yi4npcMWkz9MmNThSEdyvLlfRxspxVZyJ1oHMUfAtjs/lBE3V94tbyxEj2R?=
 =?us-ascii?Q?6ESPoLHqHpux4gz9MCgAi91yyy4Y3EjCsGmbSd8eupMchCj70v5X55w769QE?=
 =?us-ascii?Q?Oqu4jFsL5bmbU35MSI1pdoDrXdgj/1W4VXOORt3R/xLteWbI6WjqEJZY3Opy?=
 =?us-ascii?Q?v8XWPlLPLbUIUEiRq6oMP2BJ4DGmVYBR+Cp+877NAG7qlZ7pJNXeppdRrIub?=
 =?us-ascii?Q?j6PJ62xMncrrI2Bj3F3vn33XaezejGNisqKUJcuJhh4T5hqvT/RgVCb9W0Tb?=
 =?us-ascii?Q?AGApz3D+bBmFw2b5uY94nDX31shQjdUSyaq9P2yKDa4fsiSRGw+UBVIYNjAO?=
 =?us-ascii?Q?xaGmEGzRgMH+aQnIoowJjutJHcLtl+LtfmDkeBqGlkJnsjxQCSVj0XzXGu7M?=
 =?us-ascii?Q?ZBtXD2hjEzVCqCTleSThjnoBbvK8294zCQIyufK9BErQFFNoFloXe+5yhfcn?=
 =?us-ascii?Q?zSHW+HmzmOnM5Fr3NjjKAG2oT7uXi8+AhnF5zMfUJwnffnuE3UV6ZDkeUcyC?=
 =?us-ascii?Q?L+vcawlNw+ksmVtjz7/CaA1PwU5F?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:56:56.9041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a0e361-48fc-40ba-0fe6-08dc7b40f93c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430

The MCA_MISC register is used to control the MCA thresholding feature on
AMD systems. Therefore, it is not generally part of the error state that
a user would adjust when testing non-thresholding cases.

However, MCA_MISC is unconditionally written even if a user does not
supply a value. The default value of '0' will be used and clobber the
register.

Write the MCA_MISC register only if the user has given a value for it.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/inject.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 94953d749475..8d18074534ff 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -487,12 +487,16 @@ static void prepare_msrs(void *info)
 			wrmsrl(MSR_AMD64_SMCA_MCx_ADDR(b), m.addr);
 		}
 
-		wrmsrl(MSR_AMD64_SMCA_MCx_MISC(b), m.misc);
 		wrmsrl(MSR_AMD64_SMCA_MCx_SYND(b), m.synd);
+
+		if (m.misc)
+			wrmsrl(MSR_AMD64_SMCA_MCx_MISC(b), m.misc);
 	} else {
 		wrmsrl(MSR_IA32_MCx_STATUS(b), m.status);
 		wrmsrl(MSR_IA32_MCx_ADDR(b), m.addr);
-		wrmsrl(MSR_IA32_MCx_MISC(b), m.misc);
+
+		if (m.misc)
+			wrmsrl(MSR_IA32_MCx_MISC(b), m.misc);
 	}
 }
 
-- 
2.34.1


