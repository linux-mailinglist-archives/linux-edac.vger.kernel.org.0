Return-Path: <linux-edac+bounces-5784-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KIjI3FTrGkOowEAu9opvQ
	(envelope-from <linux-edac+bounces-5784-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sat, 07 Mar 2026 17:33:53 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C19E22CB0E
	for <lists+linux-edac@lfdr.de>; Sat, 07 Mar 2026 17:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0B04302F70D
	for <lists+linux-edac@lfdr.de>; Sat,  7 Mar 2026 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AB03A6413;
	Sat,  7 Mar 2026 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v3AYI6Vl"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF38371D03;
	Sat,  7 Mar 2026 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772901221; cv=fail; b=DJ2btlWvS11Hd81qZiQQUABKUxfJ4soYRI1pMRCvqmWIjPLteg4BwzQwzHhxNAw6M3WT0eGIgHDl43gOyEjNc5ERQbNLcE6DP9NgLQ3vcdb13XRicjTRLfPlH+Ee36IFsb3Bi5UQiA11va0La4DZLx9cURzumSTnllI424Q/TmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772901221; c=relaxed/simple;
	bh=e87hwHE1PaDlvak4MCZ4emXmoKtFFfIWGRQnwJFQuv4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3rQh5/Kwic+2agjyB911W+0aN5pohYCZGzC2OloKInwFSPTK72nvj/kvkUoS7jIY53eiv/I4ym+irgZ8bmCc63PVQbq9cG5AJHuQVT1gyk4NerOD2n1/rL4cE3TLxyoh/TFYZZWdwKGGvt1w+KMtJn9HO9tkRoM9FQpGhpClt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v3AYI6Vl; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cilLsPhgCtwdfR926n1uh142ET+OkVCY5uHe8/dsUuGR8eRt9c9PBnYR/8dBkDRxUJn2ux7VPHPPz5kuEddsT2iWBZxozPBn2iRGkYIQsjHyzUe8bjXVRp9cpaeqjpDoj4odN1y0zYTAEUtjnSJIC7HBKLTgSGyd0hP/M1FC+UBKmTVYVt0EPpuDN2ZMiszKiBEdExA9ZdX0FuA3frKfVCb5hWYQN2SWgYM+MwfXWksfDCfG2VQoBarThWPPk0w+5iE93039a+r17SUNH1DShYSEdTNMXPascGT0MmfCY0KXUJo2lG5W3U/RAKZTr2GehEbS4Y3jcxwEnlyoVAM3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiAyG3wK7FJ+dBISAERu7PCZ6NydOzZFBe+YR81zXMQ=;
 b=BT1caeLfUA6GKy1l9Wd+BC1g6yuIhcHdRoKv6iI6OO75SmsvlnJbvHWvQ/jS4qag61EUm6XRAtF37Pm/L/2AWldM3P3kp4GGZeVqBs2X6/V0hLMFdGOadGyTxwOyLgccoP2L52+c1go8HW6MyFxuqDMHk6y/Wpeve7w7Cu5+QlbQZnye256iCGLnrmwIn8yCx0FawsrqUPp/ukkYbjJXc+frty4HeLtmBcmF2MBIxpbFL6DPx1MSZK2emQ/5IAqWGohUhiAgx0WLmfk9a5OtBHe1XeSeYH/XYepOrn539PvFf4S4vd4PPHKh8Aqdk2pRZZRomeehGAIDM8Tl28yqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiAyG3wK7FJ+dBISAERu7PCZ6NydOzZFBe+YR81zXMQ=;
 b=v3AYI6Vl4G+X52kIYBtM5AwXbVJPZAvAvhYGEDkLtcQ54Xm99SRK5KDD9cRUDzpzsrNfnsHiMxO3q5BkOiVyHoEmSHZyXAJG19U7IBxhbEyIHpORZ17g5kBXoAyhGfXeJNYFSiqxLjEKLxDsZe4xaAQ3IEZJzEawIJWJ3yZlR2A=
Received: from SJ0PR03CA0180.namprd03.prod.outlook.com (2603:10b6:a03:338::35)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Sat, 7 Mar
 2026 16:33:37 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::70) by SJ0PR03CA0180.outlook.office365.com
 (2603:10b6:a03:338::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Sat,
 7 Mar 2026 16:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sat, 7 Mar 2026 16:33:37 +0000
Received: from yaz-khff2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 7 Mar
 2026 10:33:34 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 2/3] x86/mce, EDAC/mce_amd: Update CS bank type naming
Date: Sat, 7 Mar 2026 11:33:15 -0500
Message-ID: <20260307163316.345923-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307163316.345923-1-yazen.ghannam@amd.com>
References: <20260307163316.345923-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c48d4e1-51c1-46d3-91cd-08de7c674876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	IIiFKvC5gckT8tP706AS11f7gkg9mW5B8RMpwYLM5c3Ka5rqLUdZKmfQHRtg9okBlnlpcXU9z8GRdkpmyrPRPTkvCbTOKh2gvjjkodQpu3c9z/rXlnV46BXhi97EV3pFoOGaXQUnzkt5IDws8X+SJpvoSPWLkLjvH17u+UcJ4t2jC6hWUF9t2Gybx9dG/GNBVQqI9+bpc82jI4L2Yn7/7yPR3rlRXsiR4yATM86IDh75PYa5OdOZc7R2PKiN9dbCZwwgmnqWv51ZavojhAnXwMrd3Xaj+Ocs+7mI8ikzR5/WzhJHB08Ya7UNkd8HxnKNOhErvQTsdHcTf+T//jlolJ+8PglZq7HCYneb8TFuWGjHjlsIeeQ4Zoxt/WYTKO5ykXFYx47ECttbN0vkarYFTlo8ZV0JW141RPhBgkwz48TYEI+xQKDgWhRiWgBICPh4OxnyGXSPpVxsBRL2PVtf9W06/PRIKH5OgVQtOCbJUGOrcKwC7c2LTN+wdvKVY8BYoysmUOt5j21Z1pp9Sxv/7cCc11ilo4gbpN5dkUTFZ/NAiU2no7NpJIVVd14JepwGFcdJf/LZoAeA0LydbaYXPzjaZnZhFAPIg8noLfKaLdH/Zjk/1VGwr65lQ9ohtJsDGYTJ9y4gCcEe8qtWQ53r/6yVoj4xvPZAcZcttoW50pDgPRVMDI9dUjG9QeB3KK+VpmPCIwSeQAo1utW72HXr95acHEYbqM+5NfsElQE1pyYGFXa9fYZHHink/a23mj2d7Lzy90j5Kh/TM4GvyeJV6g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SatMQiY2HIxLy1XGqyFa67zlYkamvOzBaasIHOVh8+ZtTQvwKFJ5EwIbT03EqBLqOzVDM/TT2qJwmaAB/w04C96TgXgKDrPuyOEATNHwNpk4rK/IfnuDO2PcaBN+yAVpP3m0dPGCbC1cc7B50zBiHXHaJladzOUyUsAS3iT0jqP3Che3w/oEXK12TdPU45cyeFWqar6iZM9+9JtFnKGiPCTc7rM1Do/Ev6JE/62hwRLQ2uO0aFY+AyFHYpX6e6oINSPpMNUwCZ8UqOcVT0FppBGEee+2UQi5uHtvRDJcK3OsgEbRM6noGUY6/7DI9iNUHWdPMHYdjH8gue4uMWxfrO+WUTDoFm1UBYLqRikvC0FKxdzQ+LKHceJ4MBJCbJAaOFBzsMoXxUsSXWwl/l/cwM4r6sTv8wZHFIudiBv7dsr7KysdQKvFnHmYFv1ww8Ym
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 16:33:37.1057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c48d4e1-51c1-46d3-91cd-08de7c674876
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
X-Rspamd-Queue-Id: 2C19E22CB0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5784-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-edac];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Recent documentation updated the "CS" bank type name from "Coherent
Slave" to "Coherent Station".

Apply this change in the kernel also.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    | 2 +-
 arch/x86/kernel/cpu/mce/amd.c | 2 +-
 drivers/edac/mce_amd.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 83899711da4e..576a4b6e83ea 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -349,7 +349,7 @@ enum smca_bank_types {
 	 * Keep in alphanumeric order, numerals before letters.
 	 * Exception: Keep "V2, etc." with their originals.
 	 */
-	SMCA_CS,	/* Coherent Slave */
+	SMCA_CS,	/* Coherent Station */
 	SMCA_CS_V2,
 	SMCA_DE,	/* Decoder Unit */
 	SMCA_EX,	/* Execution Unit */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 44e490119b89..86f51415283c 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -95,7 +95,7 @@ static DEFINE_PER_CPU_READ_MOSTLY(struct smca_bank[MAX_NR_BANKS], smca_banks);
 static DEFINE_PER_CPU_READ_MOSTLY(u8[N_SMCA_BANK_TYPES], smca_bank_counts);
 
 static const char * const smca_names[] = {
-	[SMCA_CS ... SMCA_CS_V2]	= "coherent_slave",
+	[SMCA_CS ... SMCA_CS_V2]	= "coherent_station",
 	[SMCA_DE]			= "decode_unit",
 	[SMCA_EX]			= "execution_unit",
 	[SMCA_FP]			= "floating_point",
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 7fba230cb9e1..54ad56f2a9e0 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -689,7 +689,7 @@ static void decode_mc6_mce(struct mce *m)
 }
 
 static const char * const smca_long_names[] = {
-	[SMCA_CS ... SMCA_CS_V2]	= "Coherent Slave",
+	[SMCA_CS ... SMCA_CS_V2]	= "Coherent Station",
 	[SMCA_DE]			= "Decode Unit",
 	[SMCA_EX]			= "Execution Unit",
 	[SMCA_FP]			= "Floating Point Unit",
-- 
2.53.0


