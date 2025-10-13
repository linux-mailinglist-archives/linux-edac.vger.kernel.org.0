Return-Path: <linux-edac+bounces-5033-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2984FBD587F
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 19:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB9818A5B36
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 17:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0111D3081C7;
	Mon, 13 Oct 2025 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U0MdMlX4"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABDA305062;
	Mon, 13 Oct 2025 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377048; cv=fail; b=CZ+zheZNdjfDYPmuE/ZWznXJ71nLStj0RVcu0eNH2ISedxaE7GpRii+3q/qXkfqX9k7jV9lYlnRvAeiEnSjG17DHl7d8F145MDl7DirdTyyNOWifv1H58DlmNEFJLxLSNzDHVMEONDafKd+0pJob7Ekd9ZqRaDWyHuMDIywesbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377048; c=relaxed/simple;
	bh=RolwOF54I5Q9OIpsFTVd3oZ/fd5rjkKC4hh8toaMLqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sU8mrQlMQ4PKG9VL+UTChzkle3tqn2dhN1oyB1wA/4lkNZabZ8fYtpB0+CQ+v5oU8RJ7S0h6lBI6DnlQjqh2hp8qDgYd13wLlkmuNrLtY4SVh4tnFjAy/5HJgYa1WlYvd4tRNtfX1SmII6O0XdUmCtTO51OXO2D9mNktIDY1PoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U0MdMlX4; arc=fail smtp.client-ip=40.93.195.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8xXPBqzPBANaCz3yfsQX6RLB+CL9sMhrjG3SJsCHlejCsDpzcENXzB9veA3TYMUbYhaejYbL7KoWXN/rT13pSRxeLUXFAQKhylVcXxVF3Zklb1zp3IDbAaI6to3qBI+Oyk6VIR1xoyIExBhKGI3R6PgSi4rVzhz0fSh9uNq91OnFtHryRx7LQgSRVblA2j4GzTGrg5rXsJiF/NQ0N9cFVo/5QmpzZ1bAXjkErh/wVDOz56SCAKepobiMYP1x2MLX+Y2fMuHOSqBQBQI06ZYEuc7qBEhGdeYTfkkiSnHwAvC/17Bii/wkw5DCsPcH34/wryTyM4J/uEQfoWVb1wWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnWJ+kb+rLaHvM7iTs/o5H/qks1N2kR/t1GjaZl796M=;
 b=CfsRJuDdJ6AIlqZxor24PZNA51WGFYgCYb4NLgso9YcVRiHxfveVER0yRqAjQKNVunLjGgK5ZHd7bgHnHdgaFaRqBPo/+swn87+Lv15skI+n6XzCasCyRJWzbe47i22PfAiOodaJdmRXMjNIFOJ8DeSyQvaI6kU6Eg1W40nUUu2zl+10H1UagEdX9/cgF2Q+C3rBsSrjh6223O5zTzm6tW6nAfpEftJkooh9e3nFh1uHAYl6L2O3rKDrT3E2Q/kiEzfeCdH0C92KeNTmluGNbvCWGZpBaX9jSI2LJ/O5PnENlkxUvYjUGabxb9S7F34Z1Ee3zJ1Rjq8iSqnfwUWdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnWJ+kb+rLaHvM7iTs/o5H/qks1N2kR/t1GjaZl796M=;
 b=U0MdMlX4ZqTHevivuLyRsWxKp02IQRg3GyOqmqZea9ncvGS9bTi4a2iV1LaIHXlc+flxxxdSoYn/KoShsqcREqfI8bFC6x4zLVzvzF49/TpfAlTkzaugJWRf8GxkWXbvGvudVfqq0d0gopU4osYbFCbyKxPPjau9/kS/UdGwXCQ=
Received: from CH2PR07CA0041.namprd07.prod.outlook.com (2603:10b6:610:5b::15)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Mon, 13 Oct
 2025 17:37:23 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::1f) by CH2PR07CA0041.outlook.office365.com
 (2603:10b6:610:5b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 17:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 17:37:22 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 13 Oct 2025 10:37:21 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH 3/4] EDAC/amd64: Set zn_regs_v2 flag for all AMD Family 1Ah-based SOCs
Date: Mon, 13 Oct 2025 17:30:42 +0000
Message-ID: <20251013173632.1449366-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013173632.1449366-1-avadhut.naik@amd.com>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 01586a4e-b33e-4cd2-4117-08de0a7f2ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZWiP1TRN8gooU/t2TRtbcWA3GZxRbiTK5sxXAjcQG8HQuWE0NMwNVj/YjjTK?=
 =?us-ascii?Q?QSkjXPi3cMpvJFz3HdeeeFSa+LW5gkn+67onlHV9Sp4EpC1ui8s9Gpkx8x2e?=
 =?us-ascii?Q?Gpz3+bUbCiAC2sjWFUV7/BRlV1unkoIH6FGPnMc1C+eZ2KJ0+SoWQONk7Efi?=
 =?us-ascii?Q?ytoa8zGnAXLd9pwFb1PHAnka329zZZyzCq5TLnTSFAZWUSP2PEpnSeDfKbR3?=
 =?us-ascii?Q?oqVoVDZQ3vzFhAK2dQ9OrfBp7VlAGs9iwEOIC7lFAqlmmztgVqQ2ynD11HxV?=
 =?us-ascii?Q?cFcB2DGWdgaQc0TaIvZcMaIHp33LSlkXKGl7t74lsEx7Jt89cPOwTxaeO78O?=
 =?us-ascii?Q?w+tQ08M5YzDZ+9yQwa5u1j6QPXXEmgaZYNUe3UKqasQXHBj0FlwtPPTEYJOq?=
 =?us-ascii?Q?EmdXrP27kFTgaRwKGJcZf4pcwB3tW+Y3mT/6F4gekwIfMNK4R7xy6qolFTIX?=
 =?us-ascii?Q?Djp6RBwwsx6dXCh+PviC7GAnPsPCdJzY2J7DzffYwlcQ42yxIPi+p3ggz9XL?=
 =?us-ascii?Q?+Bz33FIn2Kau5pqDs/qVe0p/SLnMyp3cVKMKf0/SnKss9DcKeX7RXtCxVOss?=
 =?us-ascii?Q?uSoigrt2J2PQpq73XECvB6JJzEktDIif7fdbUkHi2jXyRHxBCFjXswBWN3db?=
 =?us-ascii?Q?k9Bffct8VvrIU/X4+RJNf0M8d9fq8ol33KRdo5bhshuppEaD86kAIFa9Xobb?=
 =?us-ascii?Q?UOy57N2N9JUgUbbbkZtx+gPwzN2H2dphM/3gtu/1Yqafo1YuoPgDmRMThncF?=
 =?us-ascii?Q?O8sfQEVDoqC8ME6LPIiDP7qJ4eI9/KiWq7uuvzh+Cx/pL4MZAlnbMkWMy5e0?=
 =?us-ascii?Q?Kcrzp2lRLeE5Ijk+NWEveVZPFZ/if5GL0XZD0QQNFDqSNjlPSUlni6NKirix?=
 =?us-ascii?Q?5M1AnaForM8ovwDEB+zqeW65YmjVpCFpxUt/MtoEBGXHjLMg7dLtTa5nOCoP?=
 =?us-ascii?Q?3DrbWe0BG1mgL8zNIf5RfOr3FNBljtLF72j5wyWH6MoOB8ff9HMqYHqwVHaL?=
 =?us-ascii?Q?75Q5Ny/uDFw1S3ke6uMyFA0AfoJeyiJV8l5F8B+OMdjSrnKANw89xqK8PMUY?=
 =?us-ascii?Q?EJpNmQCIxZiQ7g1k36e9kW1WkQeZfmrueHSfqZW9TrsLlLgBlno+5dSaaAjt?=
 =?us-ascii?Q?rl1DIL1qJH0Nfw66ihDgL7Et/98HutYBYsTWyofSmZzdPgv7Ij5Sl1vEOzHy?=
 =?us-ascii?Q?5UXDBxLORRY0ACMfyxKKxtwf00Zv50/XN5Z0H3bleSFXIW7IBEplJyu4A2iA?=
 =?us-ascii?Q?0X33aYc+cA8ml1eForRAAkKwWsVkSsCqS32jHUfi4GNZprA6+a2wc6wAlrj3?=
 =?us-ascii?Q?/jSWNHx25C53IgRzBNIkR9Iz5W4bJmngQa0j7FFg6UCX+y9oc1bjPeITf7wR?=
 =?us-ascii?Q?Eh3ktr717Andm9iUV9SQCxlbPPJpfT2UiHXv/9QXnBvv+TBoigPMwmrfGZ0h?=
 =?us-ascii?Q?E+u4TXcywB6zu78kI98RftNnPPUaXHIAGjWJlax1EOYGlmc2YqJqq78/pWFn?=
 =?us-ascii?Q?m08/QAvxZkXDqJGrDnMo9TIr3uWfB5/J3+Jmi5DeHgFlZL9qL6W/GZV3Kgnr?=
 =?us-ascii?Q?L3RjuIGc2Mvfs7Wu7ro=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:37:22.7130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01586a4e-b33e-4cd2-4117-08de0a7f2ac3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800

The zn_regs_v2 flag should be set for all AMD Family 1Ah-based SOCs.

Set the flag once for all 1Ah-based SOCs and avoid repetetive assignment.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 drivers/edac/amd64_edac.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2391f3469961..832f9675e7b0 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3779,6 +3779,8 @@ static int per_family_init(struct amd64_pvt *pvt)
 	else
 		pvt->ops = &dct_ops;
 
+	pvt->flags.zn_regs_v2 = (pvt->fam >= 0x1A) ? 1 : 0;
+
 	switch (pvt->fam) {
 	case 0xf:
 		tmp_name				= (pvt->ext_model >= K8_REV_F) ?
@@ -3887,20 +3889,14 @@ static int per_family_init(struct amd64_pvt *pvt)
 		switch (pvt->model) {
 		case 0x00 ... 0x1f:
 			pvt->max_mcs            = 12;
-			pvt->flags.zn_regs_v2   = 1;
-			break;
-		case 0x40 ... 0x4f:
-			pvt->flags.zn_regs_v2   = 1;
 			break;
 		case 0x50 ... 0x57:
 		case 0xc0 ... 0xc7:
 			pvt->max_mcs            = 16;
-			pvt->flags.zn_regs_v2   = 1;
 			break;
 		case 0x90 ... 0x9f:
 		case 0xa0 ... 0xaf:
 			pvt->max_mcs            = 8;
-			pvt->flags.zn_regs_v2   = 1;
 			break;
 		}
 		break;
-- 
2.43.0


