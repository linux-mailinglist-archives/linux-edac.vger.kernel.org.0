Return-Path: <linux-edac+bounces-3556-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03836A8A216
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43E3189FEBF
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39242BEC43;
	Tue, 15 Apr 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MW1l22+q"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300132BCF57;
	Tue, 15 Apr 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728925; cv=fail; b=T5VKSTpt3SogSSABXvdMvm8tJIoEhCwcvZKkUdbu91Zo+05hw8a4cqXBCV4b0dzCQfJiucqmjmzqXpyHb8ab3yRf7zqSNYZymA5MRlGWjEEpbBgmBNTmEi+x6mRkpW9ySDyh1Y97sA8VEpe5eh32WuDdMmwWnapyBoHu5iVYCoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728925; c=relaxed/simple;
	bh=TB+7xFvJSGEj9GAnfL5PU2SQpxWIZzAj0SdJ4HZ+2N0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c5ckvsp95er/7+RAyQutU4w9AnNfMp2JDkcVagQRS1xyNnfiR1fjhILYkb5zbNwsNmADn1eSNFG7pBMTeo5wcr0PiqtiiRulrbgHMtNx7indre7wwcd08uymIu9S7yn/+/JvL2JUKrK2ewZ2HIVeFTkMNkVtkRWyz5rT9LIqKKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MW1l22+q; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRrVJ96t39AJQOlJvGdJSq22g2b2wGo1DFHNbs9RhqzJYZj+mxa1U68hhTP4IyvaA94WZq2Q8DII6B96yaW3AhwyiYdjr9tShE5mtSGlIb7RclaDxydqHm+ywEdlBLL+DnIjfwxsX//b8+SBA2H/w80JljJZK5dYJIV2e7lsFyCfQQ+/ZypKN5Fq0JnFPRelrT3U9bZPsaMFvcBPwfxvoIQJjNb/GNzAg9mEyBzy3j4/KLhk9G8NxuVhmVx88b4FODZSS8fBx95pctl46CuDcanWQSdjFbIxsjASk4xg9ukV/hlp7qrFjeFC9iOlPT6g3TQ3nJp5oWwrZOZKkKZBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh8r7vTI+We4qhHkcFJ1x1pyLz8R7QWvzB5xrzGa6f8=;
 b=MdV1QN3cDrsakYYbISdW7Ez6D5oi6RYAqfVAT3mw7auy5DuEPLN1rrS6JcGrxRK9FTLTXZNsWKxV/UOjIWPPvMtTqoWEwUznkGTcnX9EYj1Hcd/xoZLNj40SCq8nX4KcfVtiHEwuh06z82VK3T73SU6LXIE/ihzjxx2NrdXfuZMsQ7cMPYLWm7DFM0UR9fPaWWp4E3Fvjbl8AcTHEYd5JpIoQUjEtL/CtUa2udSwwCyPjy+7M/wxoSXoeJUc/qp1iGSWdBMJsJTlhubXEwV78zGR4aM+x/48/kDfM/GlHlGAnLSREa8ItyOqJTPvenXX8wkPtmUTtLpklDs3tshkBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fh8r7vTI+We4qhHkcFJ1x1pyLz8R7QWvzB5xrzGa6f8=;
 b=MW1l22+qlfK6vLEpRtT191+f07aPuTseO2xg0ylzsY3OY2LxbRCJTQezh//Xr73rQ2ncKJZZX3Z8b69GsqUn6XB8a4eEKUs95rMHZbwkcBrv0UrlMsjX85ZEV9u8YjSxFjrmDqhKfZnFTei0AGXv5t+DBCLLV8YCxx6idMgMBU4=
Received: from CH0PR04CA0093.namprd04.prod.outlook.com (2603:10b6:610:75::8)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 14:55:17 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::91) by CH0PR04CA0093.outlook.office365.com
 (2603:10b6:610:75::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 14:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:55:17 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:55:15 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 15 Apr 2025 14:55:06 +0000
Subject: [PATCH v3 11/17] x86/mce: Move machine_check_poll() status checks
 to helper functions
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-11-8ffd9eb4aa56@amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
In-Reply-To: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 445c9528-b5c9-411b-7eba-08dd7c2d8950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVVLdUFTc3N0UWZ1ay80RnZaVDJudjc3a0twZHQ1MlY5ZXlwckNBZGJWN21l?=
 =?utf-8?B?MHpndnEvRkI2QlZUeHQvNHJNOEZUWHdxblhrUVFIa2dQNzRHWWZhVWd4T2tm?=
 =?utf-8?B?NGx6Qis4NHAwbmpiditKVm5wV1NEWGliN2F6SGVodHhDRlMxbko3Y0cycDcw?=
 =?utf-8?B?RERVbTNvbitHSGJMblNzcFBMZU9VUEthNGZlR0ZLVFBEaWgrZjNudXorR3Vu?=
 =?utf-8?B?MjNzb09QcGNFQkpaU3dVTHRNbHZ6TjIwNUJmK2tTS1YyT1BuNnBqTXEzMWVt?=
 =?utf-8?B?WmhkbEE0OWRNeDR4Ynl2NFB4a25tQ2wwWHF1aEJ1SG1iU1pyLzRlRWFXM3Fu?=
 =?utf-8?B?cFFsZVI4M1Z2REVRWHZxYi9WSDF1WnJTcE1MKyszek5HKzZTNldWb2RUblFk?=
 =?utf-8?B?bUYyRE1NWXBmMmxFdkhld3N5V2c5TG1VdUtlRkUrUWxzcnpEcnJsYjN4TkhE?=
 =?utf-8?B?RzVua2thcFdHK2QwaDRpSHMxY2xzdHpNaUl5QkZFcVNtVDhDUm5Nc1BpYXd0?=
 =?utf-8?B?dEdjUEFkNWpyakJ3QVBOYThRYTNxanduMUFXU0M3eUdvUXc1NUdkZzN6RVBB?=
 =?utf-8?B?S2V3Vm1oMVpYT0VCNkZyVEhJN2FZaktwUUNXTFFaeHF5V2QrZzR4b0k1cHRK?=
 =?utf-8?B?T3AxZ2o4VmZYdktBZ3ZQQUFCNDdZTjFRRkY4cUZMQ3hoeStCYmZndVVUb3h6?=
 =?utf-8?B?TTN1TGoraUNucG5KWjJWOExWMjNZanJIVnpzY1JtRWNzTGpodk52NmxaN2Z1?=
 =?utf-8?B?ZzBhUytoSS8reWtWSkFsWlJPYVFJWlloRzhDTHZYR2tpQ1VSc0hqbGxaY2ZE?=
 =?utf-8?B?TFFkYmZTbjI0MERiZWJZVURaclVLZTVQTC9mWHl0WXN5UUVqOVMzdHpWektt?=
 =?utf-8?B?ZDFqclppeXltaVlwZE95MWtlMVoyZDVadUV4WitEcEhmNHBleG9ZMzVyODhO?=
 =?utf-8?B?aEs5RTVQR1dSSENkd3BwSnJJK2F4WjVwd2dUMTE1dGNrVnY0OUVCelAyN0VN?=
 =?utf-8?B?cnBqNXc2Q3dGZmgxZGs0dEVneGJUQ2xXNGc5VzhhN1pCMXMrQlpqWmp0WkI4?=
 =?utf-8?B?eVpRaUVMMm9rUUE0S1ZnMjQrTWRQYWhHY0FKWUhtZGxrd1cyYXdnNk9oSXdH?=
 =?utf-8?B?azBWVGhBRS9FZDNtVmFzVyt3MW5sdGFiT3Rlb005VjlPUGFxL3U1elpxWHNn?=
 =?utf-8?B?Z2FGVFV6UGZXb3JjQTZ6MzhNcmNaZXRNcU9ybnJNZ2JHZ3pCRHpJclFBNk5o?=
 =?utf-8?B?MzkwaXJ3WFJOSURBZXNPVzlOMGw5QSsrM2dvdk5UdGVoWGdaTUs0WnhjNXN2?=
 =?utf-8?B?MjBxMXd6NFNlNDBNUklmb0RUdmVqN2c0bDRUVXMyNFo1bUZ2U0JkSW5ha2dm?=
 =?utf-8?B?eEJseHZ5T1hkMDNLZ2RMeC9hWlhGOW1oOVoramdlNE5IL3dkM0pkWFE1NDRq?=
 =?utf-8?B?L3l0RVdtdWVhNUZ6ekhsa0ZMemJKcHBuRlF2djFlY2FaUE9sVEhLK0Zuem9G?=
 =?utf-8?B?OGxYblA5Mzd0MEYyNTJXaldYZmR0cWU0S0hIS2dHL05EZ3hJZHBaUkMxOUtk?=
 =?utf-8?B?S2tpOURMOTZwcWQ2OWlwZWFuZlQ3T3AyekIwaEJTVGtMY1FZNHZSTlRBdjNU?=
 =?utf-8?B?QkxXRzFlZFRSL0kybFhraTIyU1lHNU12cjcvcm5aZ2hDaGVrUmhSMHg3OTI4?=
 =?utf-8?B?VWQzUk1NU3JTUWRqSkptVUd5NXdwRnJOUS81eHhmTk9XMWl3MThRSHd1R1Js?=
 =?utf-8?B?WlI1c2t4anB6ck5SQjNOZFZSajI4V29ydDNOVmxIeHZ6dWFCQUhqWUhyczF2?=
 =?utf-8?B?czFpT2F4QjNIYmFjMlhBUERvSnEvUDlSTFBhTUpzQ3IxZzdkejhobTd5RG00?=
 =?utf-8?B?TmNVKzVXakxGQU1NYnBQY211NGZRRDNHVmZOTEVXREpIMG16eWd1cUdxdEtK?=
 =?utf-8?B?VXc3L3RlaGNzU2o3SmthYlEvS1g1YTUwOXZ4eWd6WXJ6VUlkUkNRckJzbGdv?=
 =?utf-8?B?aE9HZE11UGxPblBLTHdhdEE4aXhFZnJ5M3BDYitXOVRwN2xXYTV0V2JtaE9Q?=
 =?utf-8?B?czZnaHBWaVlubERBS0ErU3lNc3FPSlY1RkNNUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:17.4511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 445c9528-b5c9-411b-7eba-08dd7c2d8950
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343

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
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-11-3636547fe05f@amd.com
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * Change log_poll_error() to should_log_poll_error().
    * Keep code comment.

 arch/x86/kernel/cpu/mce/core.c | 88 +++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 413c68f18084..c82c9e435066 100644
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


