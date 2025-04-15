Return-Path: <linux-edac+bounces-3557-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238ABA8A218
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFDB188FDFC
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5427A2BF3D0;
	Tue, 15 Apr 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2wXvromW"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D872E2BCF76;
	Tue, 15 Apr 2025 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728926; cv=fail; b=Rls2PmGcwUCbrTXtBvCsZ9g7h3vBqFrkNBrzq1Md2gnqRG+mCp5dFqmLT6D8ZkCXBB4zcJJWo/bpBPWFH4M7jiMHmmTjyZ3MrLXLd9L12pfsdSkfNp+0hmdq8mt8DfNQFzWpNS+kDmKR5IZkkcolakgPHMT5BzWHVkYmt/A/Zmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728926; c=relaxed/simple;
	bh=HH+HieUGphtXOKMxLaDvnZM6uV9tZ9+zsJgOjgAwT1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CSUW3KcE3dYjlZfs1OF16ZZuW8MAUq6R7Zg4hAojeJHGh03xZQnmZYQwok8v18XQwZxI4YzlHyldC9TBJfGXAIU9LhwFv2eGOx9SLw88o+LR3lEiEJT3Mr363up7FEkNlCLs8M2GJyk0kTSspgOmaMJV5HSWEbm+XvTtkp2171E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2wXvromW; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPeAt2MA8CBdDLT87Vud97tK+XXMSPRlJyFmpq8Mr2su1n4lNu2vuG8XCWcm6nBwDlzZUN3eOEet7VE9rvCDg/UwnN0hT+TZ9q3NrNEkzpwUNM5TT1653ILkpZz/DuGucFTaPeVdLF2WoVZwnVZpDT306eADjovpH+IxVTAJPXE+Vq9bK9e+qUYjuR/o/PqRJcYjy0ih57cxlatmA2arRDkz2rptBKpq86KUfWpFrmbBLzz2TMpFGdhXWetBkqPrnYduDf/y8FczteflzVjbO5hh+TqXifkSYbHybexiyhbpqAvzpr6zfCzLOkIpf6bXGp8VGRK7I1dadL9MCi1M6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6RdGLIc5gGkKXVgXueNVPgAJrV0DH9s7oAtFW4oa3E=;
 b=H4BkilEbyPrwcZL/BMpztM+fKQKQUK4J+b2PSkYf+CG6czOeRScfBjhMKMutEi6O/MalkmOdK2kJDCzn6iV8Yru9EECX4KEayox3gCPABzZ6HA0FR0Xtr9vNgNR2U974C0bBamJfdq6A86M36G/v6uCHTaaX2/nUbIEUf0ycPcc4aB49SqzDCtkDQLrj1GkCYy3pwqnsns9m0lwhlCEXSkZ7KvH0f233dhnkBG5XxYAMN9YWsKXw/BtR2+vr9UmAAEjcb9AItjr45KheDtvmPWQSmiV0TQrtf5scn5u06KwW5nO4gT6VkJ0LUAD8DR2lFecEdiueFZGBYqooxhdgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6RdGLIc5gGkKXVgXueNVPgAJrV0DH9s7oAtFW4oa3E=;
 b=2wXvromWvvBzyx89F9FbhK1GZKFxxa0OI1z+j0zF1NMIRfLb18EvUCWZ0vbQ4BL/YsM9A3Gbaz74+rk6J4yJWp7Q6mJB2HkZhMiJ3GN3wrOBTnWj2OPBOfPQPTnPz0bzXC6vEux5alAnAhVZJTx1khZTgwWVesN3RLHxr3BJ7I4=
Received: from CH0PR13CA0031.namprd13.prod.outlook.com (2603:10b6:610:b2::6)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 14:55:19 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::34) by CH0PR13CA0031.outlook.office365.com
 (2603:10b6:610:b2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 14:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:55:19 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:55:18 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 15 Apr 2025 14:55:12 +0000
Subject: [PATCH v3 17/17] x86/mce: Restore poll settings after storm
 subsides
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-17-8ffd9eb4aa56@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: f42f6581-8ae0-4500-0c8d-08dd7c2d8a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3ozbnlxSUZtS0JxaHhGWmU1MHBYaVo1K2lZTWJac21lbjMwaVQ5RlB1b2FS?=
 =?utf-8?B?RUN5T3dMK2FqVnFmQllhZzVrMURVZWFOa1dNSk9HOUxCWkRqS3AvZm1IbXAz?=
 =?utf-8?B?VTBEaUpLUDd6STNsam1ZWGdmbVQ0NGZKL2VSemxSOUFwbnIzZG5FZGNFN2hP?=
 =?utf-8?B?cnJLOEducFVyc21tcG9tVGd2OUlrNzNDLytXZVV3aFE0T0RSVFVBaG1tSkt4?=
 =?utf-8?B?QnNxRW5yTW1qYjNuZWJXODhNSDFzRXZGYVMzbFRkZitZdXpjRHkwTUYvS1pt?=
 =?utf-8?B?SUVZOGRkbHQyckF1TjFUWlNnMDU5enU3NzFRdE9vSURWejRpcnBpNzBYZjlD?=
 =?utf-8?B?UXNGWjBkdG1nQ1NaMUdVU01iRjFxaXk1T3FLWEFBL2FEaVJVL0xKYzN5YURk?=
 =?utf-8?B?Ukg5eTNmbVVXTUEvS254aXFtYlBPSGtBeEFhMnpBUENoamhJYmE5bmVxaWpn?=
 =?utf-8?B?aTdNbXFpWGtPQ3FpT1dpMHdwVHJNei9RT1J5TUVYVXVaVmpRUmJNV2xCVm9u?=
 =?utf-8?B?QzJlUCtNeDZxU0MyZ0w3UEsrOG5nNzlLSkkxSnMyRi8wL29yRzdHQ2F5OEY0?=
 =?utf-8?B?UEQrWTgvb2pEVnY3Um1ndXBpNnAvdUxXSnNnSWMrNUxCOWw1eVVUOTJMUFpB?=
 =?utf-8?B?SzFrZzM3eWVIWU1tMjJ1UnRteEd2SjhPVDNQWG9WVmtRbFV6MEh2Qng4dGFa?=
 =?utf-8?B?bmdLVEhET1cvSjM2akFyQTdkMUdRMHpWVzV6elJFSWYwZEUydmR4RXp6cEM2?=
 =?utf-8?B?ekNYMG9KUXNiM2swZldLbjVlM1lTMFpDaUo0NTZBWm53TTJ5bnUrUzdFL3FL?=
 =?utf-8?B?U05hbVdVQnVCRTgvMU1ML3MvWGkycWJhZ0dIaGhtenJsem8zL3dTeUxsZWdK?=
 =?utf-8?B?YWlwTzRIL2Uxd2JFNDNucWlqSVJkczJHZm1iZWo5N2gvUWptVDdqUi9LaVIx?=
 =?utf-8?B?Q0w1Rmx4TXl4WlRLWDZmVTk1Y2NwdVJTb1lxSXdEYi9oL0Nyc3p1VjhBWE5V?=
 =?utf-8?B?MGg3MWlSc0psOHlVTWxyZE4yaFUrY0E0aWxWYnBPeHBHa2xveWpXU052QkVD?=
 =?utf-8?B?VGNBN1BwSitWNDRuUGZybmQ4NUJJOVFuNjZjczBLOHUrblcwNk1JTjE4MTc4?=
 =?utf-8?B?Q3FOQ3NrL3plc0dFQUR5WUdIY2pPUDBZTHRQZTEvTWFYTXpGSmpPRFFBT2ZZ?=
 =?utf-8?B?V2FuVlVtbkozeU1WcCsxVUNwbGMxMHZDdWVCQnNDK25nZjZMTVZDamdGWkd0?=
 =?utf-8?B?RXlDWE55UWdUZ3phek1HWVBlZkNQMEdZM2xZS3RqSlFNL1d0c2xkNm11VXRP?=
 =?utf-8?B?dTlTakI0MTlQZlVqMU41Smdwa01uUUxta21OWW9MYlY2eUFkNFVVOW8rRDdO?=
 =?utf-8?B?MlB0Zk9sOGFHV1A4aHpTb2pBVkRob3JTTnBXQkU2Q09Qdktmc2F2dWtJR3R5?=
 =?utf-8?B?VUEwbzJsTWlkMlJHeG15bU5rOE9yb0cvVFZ2NEJyK1hlS0M2aXlvLzBkbWJm?=
 =?utf-8?B?LzVyNmZSa1NGbm02eEZkZUNPcGp2ZHFVcnlqTGlzeEZGcWxsR2ZIb1F0RWZP?=
 =?utf-8?B?UEx2VTh1WERVUnU2U2dBejROOG5QQm5tRjdYTDl3dG5GQm90dkY4K3VpZWZm?=
 =?utf-8?B?a1FOeldqbHpSWm5nT2RJdDh5bTkyZ3c2My8vRzFaQkdpdlpFc1VhOTRpTDRV?=
 =?utf-8?B?alhJTGx3U2NHTC9mMXRleFRPaVZiYUx4eVhQQWsya0VaQkFMNTZxTmY1N3kz?=
 =?utf-8?B?VjdwYkEyYnN6NGJXVk5peTlEYUNZZUMwR01LOWdNcXpiTnNZSDBRRDI2Q1J1?=
 =?utf-8?B?Q24vbC9MRXBLcGFhaGhGWTFoQ0QrSGxzbnhPNmRCdUtaVDBIdzJBK3JQdFc2?=
 =?utf-8?B?Yk9UOUJvU3BLczBKWStHNVNBNXdIRHY4OFdwcTFidGQxMVhPOE5SRk5OUHVv?=
 =?utf-8?B?Y1JkY1lmSnJZM1QvL3dsQkpORmxnN1NCUlR5NlRtQ1dnbThCa0VRVy9ZTTRr?=
 =?utf-8?B?cm9KcmNOVGNkZS9qNXhjeHZYRFdLTTdWa2RJVUgzT05aejFCTENCUDFVNnFM?=
 =?utf-8?Q?H5ZGly?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:19.3039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f42f6581-8ae0-4500-0c8d-08dd7c2d8a64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142

Users can disable MCA polling by setting the "ignore_ce" parameter or by
setting "check_interval=0". This tells the kernel to *not* start the MCE
timer on a CPU.

During a CMCI storm, the MCE timer will be started with a fixed
interval. After the storm subsides, the timer's next interval is set to
check_interval.

This disregards the user's input through "ignore_ce" and
"check_interval". Furthermore, if "check_interval=0", then the new timer
will run faster than expected.

Create a new helper to check these conditions and use it when a CMCI
storm ends.

Fixes: 7eae17c4add5 ("x86/mce: Add per-bank CMCI storm mitigation")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---

Notes:
    v2->v3:
    * New in v3.

 arch/x86/kernel/cpu/mce/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0a2a97681266..131015f5eadc 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1806,6 +1806,11 @@ static void mc_poll_banks_default(void)
 
 void (*mc_poll_banks)(void) = mc_poll_banks_default;
 
+static bool should_enable_timer(unsigned long iv)
+{
+	return !mca_cfg.ignore_ce && iv;
+}
+
 static void mce_timer_fn(struct timer_list *t)
 {
 	struct timer_list *cpu_t = this_cpu_ptr(&mce_timer);
@@ -1829,7 +1834,7 @@ static void mce_timer_fn(struct timer_list *t)
 
 	if (mce_get_storm_mode()) {
 		__start_timer(t, HZ);
-	} else {
+	} else if (should_enable_timer(iv)) {
 		__this_cpu_write(mce_next_interval, iv);
 		__start_timer(t, iv);
 	}
@@ -2142,7 +2147,7 @@ static void mce_start_timer(struct timer_list *t)
 {
 	unsigned long iv = check_interval * HZ;
 
-	if (mca_cfg.ignore_ce || !iv)
+	if (!should_enable_timer(iv))
 		return;
 
 	this_cpu_write(mce_next_interval, iv);

-- 
2.49.0


