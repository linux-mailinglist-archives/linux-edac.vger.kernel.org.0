Return-Path: <linux-edac+bounces-4226-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D70AAE6869
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C474E0D29
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6835B2E0B64;
	Tue, 24 Jun 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ueppRq2O"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBCC2DFA3A;
	Tue, 24 Jun 2025 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774603; cv=fail; b=inAx5dq9LcmebaxitqMBXP6/lsB8Cq6QMGCF7PyGp7llIDEz7BIDTrE17m/WHM3BO6LFBBxogKso9CK30eZD+fXLN7CQpBZWDFQC7D7iGM3yl+hU4y++Op+ZXMhlirpZaLftLJeQM+07ygG6UpEfVw+9G0qTjifdcMQaWqRqF4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774603; c=relaxed/simple;
	bh=VfPze2bFvBbsr8FO65d6FE72elyK8dVOApORNfGzUwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PiWvSbawFk+pVsiuDOtCCEpcLpd9LJp+tjDmmlMlWQ1cVA9XuPv5S9phCmBsbMQb3leiq/gfrlscNRUgYM2mM3o30cwa3pshQ4ZXSPQeh8UfOrw7+bHXXMNz828UFqtLOvPYOBBc+4bYDkIgS63K3xFp2Jg1Z9tl5KH9ZSCrEOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ueppRq2O; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8yDRlwMY6iykblSY+Yg+BaSJnogEVoOddNt9pmfSub8rDjZokfVZaXc3EIyqD8E3N0LmU8KNMGblhZFFz+DLbQbVCrfNcfTAtQN+sZeWOJkMsecDP1LXvioirw5+/O69lVTI661nheiZA+3AFGB/hmML/IyAcD/3jXx2i9gOae4T7hsig2T+/40EmV4F+pGwmTrY+R6o6qkK1IcwE/l/VpAP6F8NcNFhHgjGzsYXo/Ozsq4/M6MkwoSDrTijO/ierRffmJzP6YHLMHJxCeCbn9uWKwZ84x7b+UB4jV46JwZnCgwNB9qI8C7M0OfsvePajAixgHPhwhMsBFpGA/CmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZmSYLPbebC70FoWmyxn3ZrM8SL0yz3NJUV6QklgzVk=;
 b=MNT1EMABpUD5cdtQ0X9Fdgy5qfvCzoLv1/4PbDJqydV+Vmes6xzWITjocM6HgO89gzlMHPDzL135F0gwFWFeF793QPgjvI5QbfAS7P1qwQlOEAZKffjs7MspONZ/klXHiOiGt4u0xRMtVxwEvfcUYxNMj7BVxWXSLSzawXxBOCyXfDkgC+57Yow/dMaojJTHV3kV6GUPcvOdhxZ+2ZdyrOW6njN7NUyWnWRcLN8Aoux4fHhN0aG9HpbYXOJYdtliv6H++9LJDidLfItp5CdfhaKUxs9oXJW5IQZ3WFARB1LkXsniEDwN+VC4RZ3Gom/PCbwvQkgkdNM8/WqY9H6UAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZmSYLPbebC70FoWmyxn3ZrM8SL0yz3NJUV6QklgzVk=;
 b=ueppRq2O6DtHzTwfY6CT3wXRcY7B0lZQM/iOGngIF74KrCJITB8TczRkOVOCwP7LugJkaEp3Gue3bsF/pdOXH+t0ocXTn/MOURClG0eXxyBM6UDcYIuEQApzZtP4v0TQMPyefDQs6z89g/ROgk+PY5oF7m36ptIKPC9IIf/5/hc=
Received: from BYAPR05CA0048.namprd05.prod.outlook.com (2603:10b6:a03:74::25)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 14:16:39 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::e4) by BYAPR05CA0048.outlook.office365.com
 (2603:10b6:a03:74::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 14:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:39 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:34 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:10 +0000
Subject: [PATCH v4 15/22] x86/mce: Move machine_check_poll() status checks
 to helper functions
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-15-236dd74f645f@amd.com>
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
In-Reply-To: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	<linux-acpi@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: b85b8bae-df60-4f0f-5951-08ddb329bc6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlRtZkVNbGN2SkwxNTFHZm5FRmU0RXk2Zi9FOHNJQVpSTWVadlY5cU9Eeklw?=
 =?utf-8?B?QnRadUd0UU5YTVhPTUM5TUgzZUlmS25WUjI4QlV2OXZwWEFNTHBESlJjM1Jm?=
 =?utf-8?B?SExCL3AydEVORm5GRmJ1RUxBTHpQY1paN1RnUm55ajJMNk5Dc3Zzc3pPVDVD?=
 =?utf-8?B?WElzUmVaWnVnUEJ6cnFHckJsdVhiSzByS252enhQREVxRld0L05ySlAvL2R0?=
 =?utf-8?B?UitremhDbzhyZWtMVUxVd2JwTGpLMU9zS0dKQkp4dmE2ODFDMjZiSjI1OXRO?=
 =?utf-8?B?amh2aCtMNWVYaWdkK2tMczZoL0MxMnJGZVU4K3B4YXRjYTlPb1l0RDk5amV1?=
 =?utf-8?B?V01EeTZpTlNOVUFYaGxsSFlKdDR2YnJwOTlSbit2MmhGU29TdDg4ZHRkeGxF?=
 =?utf-8?B?U1V4ZFE3Y2Q2eWpUYitZQ1YwWlVLKzRiS3FpaTdYSTlFUmtNZmlZZ0ZMd2lQ?=
 =?utf-8?B?MTNYME10cFBRb0NDd1VxMjMyNGJBalIrZEQ2dUJiK1pqVVZKNi9YN2JyOG04?=
 =?utf-8?B?UzJtWEJRVFNHVGxaZ21zd2dYdWtTeUNCWkxGZmxqN2tnZW9VNHVrWkRsVzc5?=
 =?utf-8?B?aHUxa1NILzN4d1ByZnJPaHRtc3VTQ2h4QzJhOGM2T2ZMZTdzdUNlQjhMbkJn?=
 =?utf-8?B?VjM1c2MvbmFEWDhOZm0zdVpQUjNkNXBNMzRObXF1TVFOOG92YklLNWR3V3Zo?=
 =?utf-8?B?RmxvVjJHSFZDODhjVHVxVTBlc1dzOS92TXBVTkVyQ1AvdGNZSFMrWUhsT3NE?=
 =?utf-8?B?ajZsSElpd21oTmcxTXBFcXFJZkZYQmUzWFFJTjJzK1BiTXRuVzhpL0NVZ0oy?=
 =?utf-8?B?TFpjZjNpbzhaREFkeEFVZklzd3loU0pMaXVSblRQbHF5YjhGUXd5VUgxelJZ?=
 =?utf-8?B?VE1Mdm1PQWFjZGZhU3lBYUE0UDR5dWxNdHRZekNjOHNaaHBYS2hXYWh4NjZE?=
 =?utf-8?B?U2J6eG9nNkJuRXRVL0loTXZjT2VmajhyU3hjYS9lampUa1VScTRodEVSOVRC?=
 =?utf-8?B?ak90YW9Oejlwa2NYelN6eUgzanZHZ1dEVVgrWWZ5QmpCMlE0d2N6MmFSTEtT?=
 =?utf-8?B?Yi9Ud0lLMWZzMFBPOExGcnFhUzVUUk5FbU9xejVrYmR0MFkrRFREU0o2YUg2?=
 =?utf-8?B?Qkg2QXhkSnBkRFZ2a3BraHpIUTRuaGlFbE1GNlNZR0FhZVhXRzJFVW1YZ09D?=
 =?utf-8?B?OHoxZFFqMWRRM2pCODVDSnlRTnFCWi8rZUtzc2Y5bnlzL2lMOTg3ckhVTm8x?=
 =?utf-8?B?NUx1LzBCaWt4Szk2MGFzUjlacGUrT2xWVzJUY2F6bVZIeXdPbTExRVdqTktq?=
 =?utf-8?B?Q3RLOUVEcXptU1lTZHpYQ2RHYVhBd2txTTZTMmxkdy9kVFE3WlRXVTBNc3lZ?=
 =?utf-8?B?RVc1dWxaMXdJYUYxcGFHUGF0eTZWckd4Q1ZLNjdSMTZZbWNIT3lCOEtjS3VT?=
 =?utf-8?B?ZlcvZGdkSWpFT3JKSE5aMWRXNFJ3Skp0dE9WbDhkZ0I4SXp1TEt3Vm1TMTUy?=
 =?utf-8?B?Ukx6dEZzWlcvMkg3R2RWWkhXdE9FeGhWbWFReTg2RXBOV3pucWJRMUE2dFlW?=
 =?utf-8?B?MURuQjh6dk1veGZHSjRoSDVhdG14NmdreFlTT0FNRmcxemJZNjJOZWx4d1NG?=
 =?utf-8?B?Q210UWRtbXNUTWFOS2ZQTXBsUlBJKy9iQXhhbkY5b0xKMzFWb1BrUTJZVXN2?=
 =?utf-8?B?VFBwV3RuNytlWWh6Q0lpVmxITnhqcGVBR1VyZ09YR2ZNbzJXV2xTS1RkaU1q?=
 =?utf-8?B?NVFScC9ST2FEMkFmNTdCbTFXdW5GUlFyZ1lwTmtlRkFPbzltWmRaU1RaSERJ?=
 =?utf-8?B?R3JFTWx0YmM4WFIxVkhxUnJoajhjSVByNnlacDNSdkNtZUIvTUo5SHM1Y2da?=
 =?utf-8?B?ODVXY1ZwZG9iOHNBQTdTRzk0eTIvandzeFBSWXRzK1R1cGNEbzh1UlVzQ29H?=
 =?utf-8?B?T0hLT291VC9MM1FJRUtZdDdtajlBOUpFWnNlSVJVUm9QWXVYVDdLMWdUamtq?=
 =?utf-8?B?T1ZLRHg0dTlScmRvelloVXpLL3FENGd3WkZWVStNWWdoQUwwY2JKR3BQS1c1?=
 =?utf-8?Q?7g+FXF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:39.1599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b85b8bae-df60-4f0f-5951-08ddb329bc6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913

There are a number of generic and vendor-specific status checks in
machine_check_poll(). These are used to determine if an error should be
skipped.

Move these into helper functions. Future vendor-specific checks will be
added to the helpers.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-11-8ffd9eb4aa56@amd.com
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * Change log_poll_error() to should_log_poll_error().
    * Keep code comment.

 arch/x86/kernel/cpu/mce/core.c | 88 +++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4f6af060a395..bed059c6c808 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -714,6 +714,52 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
 DEFINE_PER_CPU(unsigned, mce_poll_count);
 
+/*
+ * Newer Intel systems that support software error
+ * recovery need to make additional checks. Other
+ * CPUs should skip over uncorrected errors, but log
+ * everything else.
+ */
+static bool ser_should_log_poll_error(struct mce *m)
+{
+	/* Log "not enabled" (speculative) errors */
+	if (!(m->status & MCI_STATUS_EN))
+		return true;
+
+	/*
+	 * Log UCNA (SDM: 15.6.3 "UCR Error Classification")
+	 * UC == 1 && PCC == 0 && S == 0
+	 */
+	if (!(m->status & MCI_STATUS_PCC) && !(m->status & MCI_STATUS_S))
+		return true;
+
+	return false;
+}
+
+static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
+{
+	struct mce *m = &err->m;
+
+	/* If this entry is not valid, ignore it. */
+	if (!(m->status & MCI_STATUS_VAL))
+		return false;
+
+	/*
+	 * If we are logging everything (at CPU online) or this
+	 * is a corrected error, then we must log it.
+	 */
+	if ((flags & MCP_UC) || !(m->status & MCI_STATUS_UC))
+		return true;
+
+	if (mca_cfg.ser)
+		return ser_should_log_poll_error(m);
+
+	if (m->status & MCI_STATUS_UC)
+		return false;
+
+	return true;
+}
+
 /*
  * Poll for corrected events or events that happened before reset.
  * Those are just logged through /dev/mcelog.
@@ -765,48 +811,10 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (!mca_cfg.cmci_disabled)
 			mce_track_storm(m);
 
-		/* If this entry is not valid, ignore it */
-		if (!(m->status & MCI_STATUS_VAL))
+		/* Verify that the error should be logged based on hardware conditions. */
+		if (!should_log_poll_error(flags, &err))
 			continue;
 
-		/*
-		 * If we are logging everything (at CPU online) or this
-		 * is a corrected error, then we must log it.
-		 */
-		if ((flags & MCP_UC) || !(m->status & MCI_STATUS_UC))
-			goto log_it;
-
-		/*
-		 * Newer Intel systems that support software error
-		 * recovery need to make additional checks. Other
-		 * CPUs should skip over uncorrected errors, but log
-		 * everything else.
-		 */
-		if (!mca_cfg.ser) {
-			if (m->status & MCI_STATUS_UC)
-				continue;
-			goto log_it;
-		}
-
-		/* Log "not enabled" (speculative) errors */
-		if (!(m->status & MCI_STATUS_EN))
-			goto log_it;
-
-		/*
-		 * Log UCNA (SDM: 15.6.3 "UCR Error Classification")
-		 * UC == 1 && PCC == 0 && S == 0
-		 */
-		if (!(m->status & MCI_STATUS_PCC) && !(m->status & MCI_STATUS_S))
-			goto log_it;
-
-		/*
-		 * Skip anything else. Presumption is that our read of this
-		 * bank is racing with a machine check. Leave the log alone
-		 * for do_machine_check() to deal with it.
-		 */
-		continue;
-
-log_it:
 		mce_read_aux(&err, i);
 		m->severity = mce_severity(m, NULL, NULL, false);
 		/*

-- 
2.49.0


