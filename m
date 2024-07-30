Return-Path: <linux-edac+bounces-1589-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F34A8941F8A
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 20:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807B21F24C5F
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 18:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694D718B46D;
	Tue, 30 Jul 2024 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1ULHZuvL"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CB6167D98;
	Tue, 30 Jul 2024 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364218; cv=fail; b=MiPS0Xu9IVUTQxQE/JXgOZQGEVOyTRSTfWwthQvibxy1+h5NPM2LKi/tiVBi0Frd5Hl5U9n5FbRyteRIfdRu8RJZ+hVd1wtEHTOnimQTximGRbyoPSfkEJSSBQxayhrLLx2Cg0Bd2rwGxpHUnOjZgeAaz1o2iioX5jVEFGDcwmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364218; c=relaxed/simple;
	bh=nr+SnmkeYtFzmGo8CLk8Oh1B7Ch9zqH1n2SqOBAD9+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEjwjt8JT/thwQMLs4T1CmOvRaeeal6wwuYqW45L9uyTbgip3oZ4NSKEipF8ACvEtU2TKq9ZRmusP6eqhZDBUMs9tR5rinwMpIUUVlAnUdJ5tAdDCtWga6JvORWvh82tpV8DBPTqi/WZzMJcHwfRFNVaeFfCqSrvgFhATMZxItY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1ULHZuvL; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i91g5LPb5ib/MpND0hy86Far+jZcKhgPk/fwYt6LYr+YS4lKzgk9X4s0IJ2MUmM8URIo1lZWClBLzoA5xP2sLj6OW5m1nCwa21QQtWyK3sniLW4+kZcl7BUzCCi7PEg6L3NPrHcgs+NaG+TQ++LHJfzJ4ZI+UOoZocZn+AgRTcvjl0a1gUln2hqKchQyVsoCwIDg6Ir1vOlKqLEeKyv78BYoEa839aNW1IgZY2E0kEsBPxfOhLGwBRfrs4o6aSWftnj2X5OGIVgP3rtYW+SAouB824GB5r63rfCmdzACGAoep/aoYI3tH+pA2trj6+M8nd5Mgk3UBgS8AoBU4s8vMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkHH+fnoWUA/OotvOLz14CCnzJupFLA6QF7QMnoceT0=;
 b=ZOo6LCGowN5iH3lyws1/WVzkV2ihj7hEh8T787olrJDErskMxgzQI28xs3bwXwVzZqXXq3ANULq9Vjd7umL8ySdOaCn4AKBHS4fEKVR7ge73cHn3+BZuIcbt8s42F1vXk8MYO/Ri5ze4ZhRU5R1qSYHavdNn27bTdihvhU7uTwiLTDEDyh3VSTCF2x8OjJHljXjZAgKbIHuxDGsoLmmiTPJZhjuN2lVrSjyPlIegav7L6DVQMcpjoGVJqWzeUxS3BELFTPW4pYnqWWfyg+l8vbIGXo61wE8DfndEES0WnRBF2qsAqBha22rQlGW43/VkaRLkjC1bjB8tiO5B6tCpOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkHH+fnoWUA/OotvOLz14CCnzJupFLA6QF7QMnoceT0=;
 b=1ULHZuvLioVVVdkiCM/v6i7/ZtFTGl/J0DdsdUPueHKeJln205xKFqAjlG+VR5qho8Iy/izRF5QMZOcZxnHmhJ+LT33dS4yf/5eRVnoJKJ6lsm3wwBt+tyQkDqmG8f1FnWUKHYhXsI12P56jH5ykxPhTAv81E5LNV3aNs2lM200=
Received: from SA0PR11CA0003.namprd11.prod.outlook.com (2603:10b6:806:d3::8)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 18:30:14 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::75) by SA0PR11CA0003.outlook.office365.com
 (2603:10b6:806:d3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 18:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 18:30:14 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 13:30:10 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v3 3/3] x86/mce: Use mce_prep_record() helpers for apei_smca_report_x86_error()
Date: Tue, 30 Jul 2024 13:29:58 -0500
Message-ID: <20240730182958.4117158-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730182958.4117158-1-yazen.ghannam@amd.com>
References: <20240730182958.4117158-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 423d9cbc-4017-4f15-3ab0-08dcb0c5a741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iuLpXye8L7vITzn4CageqxOJSPKcXg3pgFfaSAyHBZTl7yS55wDAJ0a9gsAP?=
 =?us-ascii?Q?NMChhDwOhp8Zn16YlLFBonxkFu9TSTiY7XtrFXoroYY7yzx+rjCbpaaQuwu6?=
 =?us-ascii?Q?pmDzDrDZ2twAlQl70fnsegd1X+v1AYlXWeM+omcCwWbnQDPIxkMCkMf4dAXy?=
 =?us-ascii?Q?pqLESfrNJTzZlFKO7ynZTkmHP+e0pubH5qBuSY9TneBpPKzGy1YzJ0ZuHZWZ?=
 =?us-ascii?Q?WWfTLru9eFFmOjdMLgHB4UVV0qRNG/8MQZYqASpLePxGXjJhTM7DJ70mtKu1?=
 =?us-ascii?Q?lQdXX8tzA7qpE2VTgqR5tdCQoOEyHY3y/qE5rAG/wKGv1giOWBiDg1brKi/K?=
 =?us-ascii?Q?JvjSoIJg7qvt7bsHHwhv/wEJt6p60NOD9eeBBWXjgDXogMOzV6CSkcPBCuy1?=
 =?us-ascii?Q?IGMR76/2BkiL+BPCUzCjBa7UtDZIMX0Mi4BGTg11UfRr19s08reBhlBMnlO5?=
 =?us-ascii?Q?ncr7i7VlxWSER2WUo/7D8Rkr2NEjWPF+9XNOXtIE/3sDgh+NM+Bt+lde29Rg?=
 =?us-ascii?Q?mHBP/D9bFVwSeEPJQSa+o3/opEJsk+DEkhltI/fWQNPNkebbaxpUZALKVC+1?=
 =?us-ascii?Q?nhrBLNC2xkIrhi/k6DX7eRWMZ+ycqDDr9RCiLf2dhlJwsOCNcfmLI0Lf1tCX?=
 =?us-ascii?Q?n9RJ3peAIlk9go3puf8zbqZaI0I3C9ZKoz7aTaLvdhiHHgyMz0TzmhZhicfX?=
 =?us-ascii?Q?t0pN9jP+u2A0N0aPOftOp/+loT06SefXD3jH947q4v9SbgvaYPEv6M+qT4Qm?=
 =?us-ascii?Q?4x06XnQtvhgmFkc5nRbDGNowQwiCRZYOl+4G5mUXlHBmsQVZjDhpQMejZrhC?=
 =?us-ascii?Q?+tC6Wt++X5y4DCvl2Bb2j8Z1fWwsOgaLm/Hcxct7+j3LMg8qPp9jsBU+5Ti2?=
 =?us-ascii?Q?T8ITqkEi8rllMDpXVYyzOado4OylF1Ekn1UJu0eMhJnB6/jka4JVUZAmai20?=
 =?us-ascii?Q?nxmtJvgF54q8RhjckNHavOZdXGiR0Q5a7mFvt9F1+boqc5HV8ZGEOaaRSQwF?=
 =?us-ascii?Q?2FrSK28kJQLETwMC5LooxgsiSjxKmaPJTryucV10s38wu82GzGNe/7QxiFrN?=
 =?us-ascii?Q?jbIMDHSIQami8EoR+QSpbKZBg3M7VTmKROephmFpradNpa8IKEiodso2Ch/l?=
 =?us-ascii?Q?e36ZNQp2MPW63/ADnJe1mltxtI/OaEwKnOxl7D7mnSvSZ3jMjZc/sYzNT5os?=
 =?us-ascii?Q?RvuJmCgf+EcgK8IASgourLNyUnmyoxOqLVP1Be9Y5Rk9+6iRCOr4Sg7pj7pA?=
 =?us-ascii?Q?s0FjEo+lH4wilIjHoBlKc+Cn6Ki1SFj5MGjX+pfcVXbxdQridICK8ImbtL4x?=
 =?us-ascii?Q?fuTfq7MIy/rniH4x39tVgB3M9wVnTg9PZ/FixQAfwPmEPln/AZvCsCek7c8n?=
 =?us-ascii?Q?4QjspLbdcbfIOE+hLmvzkmQU4SgG52EAHjOJ/N26Gc0uGBeRNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 18:30:14.0102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 423d9cbc-4017-4f15-3ab0-08dcb0c5a741
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383

Current AMD systems can report MCA errors using the ACPI Boot Error
Record Table (BERT). The BERT entries for MCA errors will be an x86
Common Platform Error Record (CPER) with an MSR register context that
matches the MCAX/SMCA register space.

However, the BERT will not necessarily be processed on the CPU that
reported the MCA errors. Therefore, the correct CPU number needs to be
determined and the information saved in struct mce.

Use the newly defined mce_prep_record_*() helpers to get the correct
data.

Also, add an explicit check to verify that a valid CPU number was found
from the APIC ID search.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20240624212008.663832-6-yazen.ghannam@amd.com

v2->v3:
* Drop topology export changes from v2.
* Use boolean for match search (Boris).

v1->v2:
* Rebased on topology export changes from patches 1 and 2.

 arch/x86/kernel/cpu/mce/apei.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 8f509c8a4e98..3885fe05f01e 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -66,6 +66,7 @@ EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
+	bool apicid_found = false;
 	unsigned int cpu;
 	struct mce m;
 
@@ -97,20 +98,19 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (ctx_info->reg_arr_size < 48)
 		return -EINVAL;
 
-	mce_prep_record(&m);
-
-	m.extcpu = -1;
-	m.socketid = -1;
-
 	for_each_possible_cpu(cpu) {
 		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
-			m.extcpu = cpu;
-			m.socketid = cpu_data(m.extcpu).topo.pkg_id;
+			apicid_found = true;
 			break;
 		}
 	}
 
-	m.apicid = lapic_id;
+	if (!apicid_found)
+		return -EINVAL;
+
+	mce_prep_record_common(&m);
+	mce_prep_record_per_cpu(cpu, &m);
+
 	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
 	m.status = *i_mce;
 	m.addr = *(i_mce + 1);
-- 
2.34.1


