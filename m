Return-Path: <linux-edac+bounces-4990-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF15BBE730
	for <lists+linux-edac@lfdr.de>; Mon, 06 Oct 2025 17:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 621BC3496EB
	for <lists+linux-edac@lfdr.de>; Mon,  6 Oct 2025 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4912D73A4;
	Mon,  6 Oct 2025 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f28DRxdK"
X-Original-To: linux-edac@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596A52D738E;
	Mon,  6 Oct 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763459; cv=fail; b=rjz2Jyuhit9tFK32mPfbB25inJRRDIl0e0ka22xSsi3gYpMW28w57TtPTNkLCb6t1N0IVETelELruDASXdN4ZmT0J0Kjwn1PHsCCHpAmBbTNnArK+m72Sw+Kni60RdsmdYXYdFRfhV+0LUH5WtEtAM/2VTnBV1n2hFJPxHGxOA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763459; c=relaxed/simple;
	bh=pnAA4xvwlM5KlXVodbdqwQRfDnUNjhLhqZPUWwUDQu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BicVKLyn2vDPhPU8wgtQZX8KL2eI5D7TNQqy5+U4jyvtcUn89fcFjk4Y0I8ZcS6AXgXZdBrZEYc93VCpRLy6/6oG3uRlDXyyZBZRsok8GfMjgNPogu+GyOwuqpSyuU5o07yUTPPUP6i7Y+MueSpv3Uf0P1j9dJHhWBmUQJ+zzR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f28DRxdK; arc=fail smtp.client-ip=52.101.56.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8gpjDaxxch5X0mf/lIrDhEnfhLf1SM8yX+y/TTTx2jymdq/CshKfs4j6kX5by7kjZRSzeQkG+JJePRrtGp24EBbOzSNYhGnRnWDtMfvIDzlfmuQ40CPDC0i9RhRsdNC1zMGCBc2KxKo+sw60T4UYihCG0q8QYke/GPdiQ/gtQ8VLGAj3syXhsdxnv2A1PBBop7ht6axcP7qEIOgFv/OwK8iPmqaWNu93cchm0uI6ZmDVcnegWcQ3mLZO091EhE/uNOh7igZ/4Gas01G2uqtWzLfXAwSm9EAQeM3uAkdqGAZzN9EeGxgvSRJXsKhemdkNKPKbpcOSUDqLkhnMGl/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BagU1TH1yPnxVp52SESIrfzrI5LCvXvceaZkyMmkrnY=;
 b=GA4AO5i/eO0WCRLZrptxXeWLpP/KTHnpF8I4reVXTxodP+rjr+1dKtX04LNXuADC7QKw+3Gn67gusPxTtQrJm52gPFeF1LwotJ4T+XYBw2GTSh0uzzabFnLO/UEuFPpyYY21QNzyQZzfX9Ht7Kg09BAULuQdLTp6bfzw9SBJgvOUkN6kKKO+XA3z5HN9zGmQuTynTN6Koc96Oa/iL+V1ev469+tCkGrLckOnoZMDYl2gRkK0hpFeme5KA+uR6NNkUiUQP57HPC5KjFUoeeqmInyZ3cnfMjc+obwxRkeH75swHctL7IVwJSFL1fKiLnqkh8/3loFzRePdrDb3UD59og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BagU1TH1yPnxVp52SESIrfzrI5LCvXvceaZkyMmkrnY=;
 b=f28DRxdKCeaGv5tKmTFpF0A4HLlf3w8Zj2CzhJWCtjgrlsVtgUSa+OSsNitg9Dnu0/7A2p5GhtyUFcaOpqqtlEUHJOKwD1SFb4bkMbIcBD+GlvYvn1GRDAm6UvBA0nl9knebSgKUmVocs1JuvKE3HBVsJ4oA5BEKG4E4hd4UbBg=
Received: from CH5PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:1f4::24)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 15:10:50 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::c6) by CH5PR04CA0016.outlook.office365.com
 (2603:10b6:610:1f4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 15:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 15:10:49 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 08:10:49 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 6 Oct 2025 15:10:25 +0000
Subject: [PATCH 1/3] ACPI: PRM: Add acpi_prm_handler_available()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251006-wip-atl-prm-v1-1-4a62967fb2b0@amd.com>
References: <20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com>
In-Reply-To: <20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Avadhut Naik <avadhut.naik@amd.com>, John Allen
	<john.allen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7cd84d-005e-4cc9-707b-08de04ea88ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wno4NlI4cXMzWW1TVnlCd2VQYjB1ZHdnUmZ5T2IweGFwYTBOUkZQd29FR3ox?=
 =?utf-8?B?b1JXVHZGMkdUaWRVVUN3Mnhhc0ZJbkpmcnBiL1NNTEdnNHJCVUZhTDkrdk1B?=
 =?utf-8?B?WGNHWE5GY3JQMkxvUVBXS0J2azlEcy9IRDRZazh4THpkUm56ZjRZWFJGdi9B?=
 =?utf-8?B?cFFTbXRHcGZrMUc4cVZtZENlYjQyTVJ3M1lUbC9UM1p5WnJ6S2Nza2thZXpm?=
 =?utf-8?B?U3JSV08welRwVkhMazdzZkllaVZURGVVQUxYVE9lbENXTVNlMm5RcVRPZzBk?=
 =?utf-8?B?YVBIOFNaUXJNRGxReU5DVjZvaFFzekZlL3VwdWlzTjhkNngrSC9XaFVNbTlB?=
 =?utf-8?B?bVdtWEovT1hBOFUzVlRpL2dUc2JaQ0wweVFZRG5nV29ieklKbzNCSkpKMGJw?=
 =?utf-8?B?L0c2RUw3bmhkRGx1NHdXS20xaUUxZG5SQUsrc0JSRjdQazlKalNTS1lWOUI0?=
 =?utf-8?B?RVBVaXZhSER0dldMcStuWE9KYUNvRUtpNk01aWNPSndHcnZEUnQ3UnA5RTJQ?=
 =?utf-8?B?cVRXbStMeGs2NWJucjQzOHhGYUlXNWhyUWdoQWhGZ3p6aDRVa2dQemtuS0NC?=
 =?utf-8?B?cHNCaGhhY0xFa2VweUhuaWxGUEJiNW9UZXlSRDg5WmpodC9jSUNmaktpbkk3?=
 =?utf-8?B?S0tCc0dHVHZGdDJTaXVmbko5SU4vTEFmT2EwUVF0V0xYNFVHaExxb0o4b1Vv?=
 =?utf-8?B?ekg2S1lJSlpiTlJ3eE1OdUE0ZTdsMTN6SVdiNC9CQWJsSEdRQktmTENqN3d2?=
 =?utf-8?B?SnpmdmJhYU8rSmVxZWFKMm9UMGNMYmxmbS9HaVhPdC83VVlLNHR3SHpTVUFz?=
 =?utf-8?B?Tk5LVGpNUTlLMW9jN0RzdzlWb1p1bDB5QnFTVUlNVmJHMFRNbUtlUGMram1K?=
 =?utf-8?B?UlhEMEFReEh0aDJVR3RlK0ViU1VrVzBOTEF4N0FoRTAwWnl0NWRBM0ZuaVgy?=
 =?utf-8?B?Z3hRWExBMWdidGVwVmRaN25HOXg1eHU5eWVSQUNDVzljdUo3UDcwYWo2blVC?=
 =?utf-8?B?bHZ2QUtJT3VPRmdrQUN5bDk0SWx5QjBnV1JkYTZwNUY2SjJodjlWaWx5dUZy?=
 =?utf-8?B?aFNWQi82RnN5RlZFYndvUWFBeEU3aTdadnBnN01DRy94TDNCWmk5ZkZKdmNr?=
 =?utf-8?B?R2RzNnpBSnQwbXBWWStObUprSDdUN1JieHRUSno2NXJYY1RyTVd3ZHdoZHRM?=
 =?utf-8?B?cHlUN3FDdFdKQ2RKTVp3Nm1Bb0QyaG9EZHBQVENMU3YyL1d1d1FBVkJSVHlC?=
 =?utf-8?B?M244aThRVUNac1RmU29sVjhLMTRNZUpZbG1rQmVFU04yN2N5dzRBaW5jaTlh?=
 =?utf-8?B?S2dFS01QbTVpb1dUVWp5azZGcGJNbmh2MjF4ZGtucUlJQUJWaS9CbGYwQVhD?=
 =?utf-8?B?cXhIVFpIWXliZVN1L29WQ0hwclBwMHVJbGdkNFJoaW1aaG42b1UxTVcvS1Nr?=
 =?utf-8?B?dWJtbkxuZTMvbFJFL3UvZ3ZyQnowMkZCYktadTcvbElMMUg0b0N0WEt2dFZp?=
 =?utf-8?B?TDF0YjR3M1hhcnF5bU04TGVwSGpxUjYvQmJmc1pXbDI1elFpMjZqU1IzaHNn?=
 =?utf-8?B?RXdxMFNIc3FVVmdHdnZraTlJc1N5b3hyNnJEZkFGMUVFUFhzRkgwNDNGd1Bl?=
 =?utf-8?B?NUNSaTR1RkZVVzVXcU9panlJa0l4Z2p4STI0SGgweXB0b0xReHlRY3FOUXg4?=
 =?utf-8?B?enh3WWc2WlZyTVRxMU85OWJmaFdkTnVjZVhwY2pmZzgzd0dQaUI3STUvaWpx?=
 =?utf-8?B?ZW12S2VuYjQrM2JkdDh6ZmdqYUJ3TmFGdXI3a1drcktpZzkweGhVeGRHdHZ2?=
 =?utf-8?B?a1JzMFF0MWFvZVNtWTFIZ29Wa2htRDMreXgvTDlxU0kyc05aMk1HV1VmNFRK?=
 =?utf-8?B?QnRlN2FwdHJzUC9hOXp2dndaVEJuUWJJcjUvY095dHhtYjNZN0QwM2NLSUdr?=
 =?utf-8?B?dmdxU3FBb1d1WWpHWUJZZ2FId3R2Wm1UaHpEWWhkY1RrZXFOaUM5T1ZaLzJz?=
 =?utf-8?B?WTMxOEVxQ1NXSjJ6MmxvTzQ2N2xPSFZLRm4ybUV5YzJoYU1KRHBnc1BBNVJu?=
 =?utf-8?B?OFFXV3lMREFDcGJuNHRQY2M4VitLNjJnVjVvVE8vTUQ4eEE0NllTWGlWbERB?=
 =?utf-8?Q?kC9w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 15:10:49.9942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7cd84d-005e-4cc9-707b-08de04ea88ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037

Add a helper function to check if a PRM handler/module is present.

This can be used during init time by code that depends on a particular
handler. If the handler is not present, then the code does not need to
be loaded.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/acpi/prmt.c  | 6 ++++++
 include/linux/prmt.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 6792d4385eee..7b8b5d2015ec 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -244,6 +244,12 @@ static struct prm_handler_info *find_prm_handler(const guid_t *guid)
 	return (struct prm_handler_info *) find_guid_info(guid, GET_HANDLER);
 }
 
+bool acpi_prm_handler_available(const guid_t *guid)
+{
+	return find_prm_handler(guid) && find_prm_module(guid);
+}
+EXPORT_SYMBOL_GPL(acpi_prm_handler_available);
+
 /* In-coming PRM commands */
 
 #define PRM_CMD_RUN_SERVICE		0
diff --git a/include/linux/prmt.h b/include/linux/prmt.h
index c53ab287e932..8cdc987de963 100644
--- a/include/linux/prmt.h
+++ b/include/linux/prmt.h
@@ -4,9 +4,11 @@
 
 #ifdef CONFIG_ACPI_PRMT
 void init_prmt(void);
+bool acpi_prm_handler_available(const guid_t *handler_guid);
 int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
 #else
 static inline void init_prmt(void) { }
+static inline bool acpi_prm_handler_available(const guid_t *handler_guid) { return false; }
 static inline int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer)
 {
 	return -EOPNOTSUPP;

-- 
2.51.0


