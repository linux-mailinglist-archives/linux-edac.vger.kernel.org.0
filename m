Return-Path: <linux-edac+bounces-1097-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365A48CD7F4
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 17:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5971A1C21B10
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 15:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A2B482DE;
	Thu, 23 May 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LHB/h9GY"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D337147;
	Thu, 23 May 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479829; cv=fail; b=apXlB9OZyaj9K+ipt6WjSkCjAZrqIQHJWiThtr07PjInmoNR2J1359X6MB1qjSMEMJxzyEJ+vEXJNL2frvZ0CTFjwHDjU38WB2Fgk5jLkedUtLmRWpLwsY+HAu2xLgoDZK21Ko6zvL1ifOYzadupdMekwzi4V24cluY0vw9b89s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479829; c=relaxed/simple;
	bh=TrWRfqeAkosw7t80MER9MMwITHRIUTuewFVH0HO2yEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4TCQE/4Y5CyiYknBNSXWLb56yee3MHdUIgQ9b/enIFZEz/9XIQEAtiL60iKj2EWkfMyJpTHrU4E4LJg7a/FhKtzsVO9n4LoeL0nu5JiB6l4PVsOWIyFrksSQtZdQBU0ROVZPPrH3Vn3BzxB9IjebAtgX2pXUULY0qM6WiJaje0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LHB/h9GY; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+T863wJat3NCy+6IHx6dJnwn8LoebhXgINl/ESTP+yLz2DOzp5xO00+alwJ7p/80xFQ2jFJa/emuea0Tr6dFUl7iXw2MfHjEfRhAjvH7DEpakIXxVQFXbIlnrak6ChrjV2hRnirO0RBLAKGi+/lAHXfuEJTrLQDkeSLXwRN7ugz8GUTviSoKs8mj3u1iC5Abm/4OzY1VRTQbNLDMStXfTvYohIATABxz0EPZozEz8s5JlhOrHZnqX+iH/FCtlPkZ7vZr3zYUpD9Brml0vbW23LSuaqEBCXVlTStjPNG+u8dvryB7VR6jvZbshU/hAplrLQTUjfBrJWXfSNILiRiMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E99Jngr6l2Cs9FPXt8JbpY+WN/rUS2JEUerlJVEEGX0=;
 b=QP6nyScHamH+4xNcsKKhTk0G7fWhmvfRao7sC5Zk3CPj/Iqjh2lcw4+iww2sa6CZP5koyMtGpN2x/EF70/zCWrK12MBU7YUwANUMTnJfMln8tunTX5c9FKJ/bhqZcefScOTA/ZWDCrzeW8YU4cPG+Vvxx4AoqwkYqsoeQmCnA3KHagHiMRACODxAmiO/hnlHImIHLJBFvnZZk6LplCPIM05PwA0ZQHH4jwfIyfZAsPCoEE/3WsB5lbZXq6ok8BsTNEA87zUOZz2hEDXuTeeNZ9O7qi9afYfmB1T2JSnMBoQcvc2ti4FlVjInmkX5QtfP+vm+WkCzzBCP/OYfcuo5GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E99Jngr6l2Cs9FPXt8JbpY+WN/rUS2JEUerlJVEEGX0=;
 b=LHB/h9GYShXHJ1P7K0AOawRiunyTDAgAXl5+h56l/6MvZ3T1weeMUpSJGhO8yh6PzmPOd95MuArvPwiEE9Du4fizktmhvAl7cGiL/MjCzYil0WqFkMYYBY2qrgzxYUMOpDgqOGZ+3IXrDcsWxGaC7P1jXDvFBS8y1DbvA9u8T88=
Received: from BN0PR08CA0012.namprd08.prod.outlook.com (2603:10b6:408:142::34)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 15:57:04 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::3) by BN0PR08CA0012.outlook.office365.com
 (2603:10b6:408:142::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Thu, 23 May 2024 15:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 15:57:04 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 10:56:59 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 9/9] x86/mce/amd: Support SMCA Corrected Error Interrupt
Date: Thu, 23 May 2024 10:56:41 -0500
Message-ID: <20240523155641.2805411-10-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: a117dfb4-6b72-4545-58cf-08dc7b40fd8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/JslQUYhkV8M6PK+vPMSHGCQGluNiigNWEvm/uI+FO8VXcmPHu/vUyLfqz1V?=
 =?us-ascii?Q?XJIiu+Eujm88e9BLyuoeBTR+gM5OKXe9/xsAZp6Z1oVVz+1s35tOD7Ka7xRW?=
 =?us-ascii?Q?Uz3TK71TH+7ENJUYUCOIScjGLIS+Kyjdq71RTqoF0s0sw0IF40DUWoi6JuGL?=
 =?us-ascii?Q?jLBZ8kBM9OnbBfFgP+wKzOSJq6z2OWYjR2i4tT0oE3Vvmx6p4J83ZzjKSQgl?=
 =?us-ascii?Q?a42Ci7a0xcQvj5BwaBkc72cdwLoQUMH0rbMGpO77KxIhlDNswezlRRBX+aSC?=
 =?us-ascii?Q?4OqlpfMGBpVWDrilbEyxKvSeY0KduB2M6dgBlmqHDpW6HDLoKAPqZ8DtyB61?=
 =?us-ascii?Q?VjHS/dntGT+Q1c7/jsDJL7S2/0BjNOULhb2Od8S7ZDXycFkfSZu55WEmNXX9?=
 =?us-ascii?Q?UGDoevNNlgRuwQkXRoiedjLlC2N2cY2V0DtfDztRkLcuCe476w79KwTpiqbH?=
 =?us-ascii?Q?DKymO37yXjD5Gkfz/7tQrcQ1Lyvems8JdAC3jKB6slMO78WtfEYR6/OX4MYp?=
 =?us-ascii?Q?czYXbpA/5uJG+UinFjng5EXiaDMvO6HJ94WitMBlXUbeVcpX0uI50+bGOS4p?=
 =?us-ascii?Q?ZGCfEvu4HmHUzsf/Hd0wn7B7n5tj0jLwS6sa1Sk3swYCIxSdrQkPCwGjeUg1?=
 =?us-ascii?Q?1RpwwJqJuLPgjOSunz/9+Egi7LCU/tREOsELEyXdhn+vTz75vo194IAEsCdm?=
 =?us-ascii?Q?6K8AjzpOd0UZ20yaO0UtvUl5Tun5Q66TCxkivvTtc5YgA8ACrlLjuL/dhdXl?=
 =?us-ascii?Q?Z/qk8HELtDDNfDr2MFmaObvrghFJ/3eBoMSP2TeB3VdBH3LHei7zFAJD4a9k?=
 =?us-ascii?Q?Lv5gQr+gf6IwObi9jJtGsaV4zuYJ4xHrMVW3LR8rs+33DiWpIh2PAqkF1OLM?=
 =?us-ascii?Q?RpLexgC1rPhM/mllmBFR526zK7+DnZIiKC5C1oPbHP58KKQk6HpZVMgXELM6?=
 =?us-ascii?Q?hpL8eyEevttzlO0DC3Nbgz/9VPqDXtEBEexbohmrphsaTW0AfmRySe7gvL29?=
 =?us-ascii?Q?orcx2wjXO2djDF0TF76flQyqq5cf+SI3frz1q6fxtl9lNXCvh8EScg0JhkH0?=
 =?us-ascii?Q?GuM1ONPk0IQQ93FNYieoA0YDdL5LbIqIReTw/Qjc36yaJ1/HUcP1TPOQoXlc?=
 =?us-ascii?Q?oCQ7LLAoVbgaJRBgBMwPYEIJefvS7fq0xQUi7+gRt9XQLSUQ5Po4pX8pk5ze?=
 =?us-ascii?Q?5sHOWuW3li7f51FWysI0Yp0ZMp5OnntRzJtmn/cJAroDnAwGM5DRuvWPAlXu?=
 =?us-ascii?Q?PoVgvlmfMSJzWVMxOTGdVNoyN05nMAOGwH7AP7GaexSWPlTZrbF11yMYnfUa?=
 =?us-ascii?Q?Yuv3h2yUztLqjMjMdwueHcIg0CJuAANu3MfoYpDdTvglR5kU58L9+qJeELsQ?=
 =?us-ascii?Q?HRYkmrSRn+xgXV41WBfrfr35dkyR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:57:04.1386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a117dfb4-6b72-4545-58cf-08dc7b40fd8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785

AMD systems optionally support MCA thresholding which provides the
ability for hardware to send an interrupt when a set error threshold is
reached. This feature counts errors of all severities, but it is
commonly used to report correctable errors with an interrupt rather than
polling.

Scalable MCA systems allow the Platform to take control of this feature.
In this case, the OS will not see the feature configuration and control
bits in the MCA_MISC* registers. The OS will not receive the MCA
thresholding interrupt, and it will need to poll for correctable errors.

A "corrected error interrupt" will be available on Scalable MCA systems.
This will be used in the same configuration where the Platform controls
MCA thresholding. However, the Platform will now be able to send the
MCA thresholding interrupt to the OS.

Check for the feature bit in the MCA_CONFIG register and confirm that
the MCA thresholding interrupt handler is already enabled. If successful,
set the feature enable bit in the MCA_CONFIG register to indicate to the
Platform that the OS is ready for the interrupt.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 7acaa21e11e1..cc1527ff76fc 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -302,6 +302,11 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 			high |= BIT(5);
 		}
 
+		if ((low & BIT(10)) && this_cpu_read(smca_thr_intr_enabled)) {
+			__set_bit(bank, this_cpu_ptr(mce_thr_intr_banks));
+			high |= BIT(8);
+		}
+
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
 
 		wrmsr(smca_config, low, high);
-- 
2.34.1


