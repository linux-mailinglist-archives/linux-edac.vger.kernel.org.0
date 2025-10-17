Return-Path: <linux-edac+bounces-5116-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 957ACBE8D55
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 15:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1BA11AA201B
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CFB350D69;
	Fri, 17 Oct 2025 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EIi+9JZ0"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012067.outbound.protection.outlook.com [40.93.195.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DE7254841;
	Fri, 17 Oct 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707622; cv=fail; b=kI6jh7J2AqHabS2ulmzTI/QyRCXbisddce3JyZ0QY00mM7IhBpxJcT/1M2A/CFmN76HoFXaDRfJyJo0KuQaIjy/cV0WHSoJ5EQea7phbI+PlNIH3X4nNP6Ykmcu6caloPeA2QAl7QCJ57fkcGjHiL9tBHk8Xjfzdod/P3JjjgtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707622; c=relaxed/simple;
	bh=tK5OpUrArRn44QAunY2fm6HiSEWcNmoyjy2ILWx9MC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=A20bwueL/HeLLa2O26pjgiwlWgHUKVgCSDIzdz35R0HzY4Y52IpgMspu41Gh0x+sdkwew7LTmOy9Uj1+ko6Ph4Ix2TI7jszIe/vX8vOZHtr4OnKJr1MEU9Ane3XjzP6zsFhnPpzNEYYl+VRm6Z/xWT3pA1My9H9PExMcK37ylX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EIi+9JZ0; arc=fail smtp.client-ip=40.93.195.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUzEE6mq+FA4OXpL05oBu0CPSTBdlqvX4VYKePaUhDGAhpEene6691JyC1My0ek5hzWnYjp278EXz09u+SxWYFOPYDqZntQ1TUHIYyGGcI8TxV/zkB0KNOtZ4sCmN8BZqsDBD7kM9V32yTJ7Xeh21Qaj/SE3pRhhjDz1HvgsbuNQyqchsTn/ifeq3HeOeCFfEROOqFjy6JkTzGusf1TAAofLXlR7pWWv7ioWabi3TVXv/UPHO51pDiLV7BiVHels2yF1SVi9tZq8sjmV4fGRFBIy3nyfCyf6YSZcM9tAWAxTIygFJ8RDRYwq7RWkxgrDpCF9K1K6zM0JgDG/x4Ot1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeljhxdqjAUtDwscjCsZ3aMPAy3bVTlzuYikRbtZO5I=;
 b=civ1QZBkL3AgWMZnchdoHtpgLKXEvXGg9JG/DRgVf6H4ZLekJEzz/Hen7ymCUoVigvUifo+rAq9UBT2f3PAJ4LdBSnfOzDnTO7YelKUmFF2Cd4DW4OFbee/CTQ015Y+U0QvFPysCSSPcqQfaL85by58WF+gg4QGTFw2JH/TUe/1u/UcGzyOfy0Ti5fbj+57vMfTGKtEADJw45AG+dWBQZQJxvw9kLtVCklA7kf1VmCOYdGo9pZjlWiJwW7fL7CgH5LOx22qx4+i06zuwEkDfOxNMRHaGrqvgslk/IRQWzDsulfrzIGzhuEWPJwHORFeCr11weC0wt7ba/CcIayej1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeljhxdqjAUtDwscjCsZ3aMPAy3bVTlzuYikRbtZO5I=;
 b=EIi+9JZ0kF6qNb2vgg4lpuSARG9WE8mdxD1B8VAqZSXwdZqGmluxhdkA6clNxiN9BEICbnFJGO5a/AuJHO2OXPrRnWKcNyLElERTMH+lkqAdzO2ow4N8q9Soqbv0Z1HW9xdt10b/XeY5udK2L6KdU0+5Q9SEgBnGeSMmFNOSZ9E=
Received: from BN9PR03CA0305.namprd03.prod.outlook.com (2603:10b6:408:112::10)
 by DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 13:26:58 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::c3) by BN9PR03CA0305.outlook.office365.com
 (2603:10b6:408:112::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Fri,
 17 Oct 2025 13:26:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 13:26:56 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 06:26:54 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Fri, 17 Oct 2025 13:26:28 +0000
Subject: [PATCH v2 1/2] ACPI: PRM: Add acpi_prm_handler_available()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251017-wip-atl-prm-v2-1-7ab1df4a5fbc@amd.com>
References: <20251017-wip-atl-prm-v2-0-7ab1df4a5fbc@amd.com>
In-Reply-To: <20251017-wip-atl-prm-v2-0-7ab1df4a5fbc@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Avadhut Naik <avadhut.naik@amd.com>, John Allen
	<john.allen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Mario
 Limonciello (AMD)" <superm1@kernel.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee33128-f9da-406f-8790-08de0d80d83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDU0OHhmYTd4SERkMnpkWlAwc0FERlVEUVY0bG1URGNCUFd6WEJqNUJlaXg1?=
 =?utf-8?B?RWNIU004SGtvQUh4Zk5pQWZnTWpDM3VOTE5pUzRJVFl6a3dyTHJNZ3ZULzh4?=
 =?utf-8?B?WTRmL29jY3gyTEQ5azZxbVVvUmlJNWdkUGtqMHV4dHVSWHpML0c2NGF3OFdU?=
 =?utf-8?B?bGtzWU1FbWNtUnNxSXRNdGdUUjhjNXBSdWRvSzVmTG5DeEUvaktML25YZy9i?=
 =?utf-8?B?MlFKcXFQSFR1Z0VNUitjUDVDR3pPR0pzTnE3OTBqdEdkVFVsSTAxT1hPd1pt?=
 =?utf-8?B?MWt2Z0pzUThhMDNRMXhjeThGdkFMaTFaakl4TzdGOHVvV0ZsRGh3MTU4d1RQ?=
 =?utf-8?B?am1LSEQ5Y3o0TVFHRTNCd1llRk41cHNzNHpMdlRpMmk5OUFqQ2c4ZzlJU0dV?=
 =?utf-8?B?WDYwTDRNeWxHTHZJLy9mSzJ0L0JUZnBKTU5NVGNjdEFZM3phaDNuQVg4dkxi?=
 =?utf-8?B?K2xGUTVKL1BoRTh4WnRROEJycGpGaXI1dXBEQWdrZ2EzZEwvbUZzeXhLRkJn?=
 =?utf-8?B?VFl3enI2NE1nOVBsVld5WVM2MEZhUFBSQ1lpbHJVdmd5NDMrNWc4Sk1zZDNB?=
 =?utf-8?B?Um0zc1FvYzJkY1BaRkdSWFh5VmtGREdVa3orK1FDYWp4TU1VZDNraFphU1M5?=
 =?utf-8?B?YXRkWFQ5MVRZR0JUbWZpVi9Xbkp5bzRYa0p1SXREK3piL2pERnh2R0tvUjZs?=
 =?utf-8?B?MWRwaGxjSlVWS2hMbWk5ZHBIRVh2aHdnUXM5UmVBdzNKMldLTFpkc3YzU3lG?=
 =?utf-8?B?QjNlR2ZZVVJCUDhRbnp2Rmh4RWZHMU1Pc3ozdEFPdi8weXdWeXBYUkIwRDNZ?=
 =?utf-8?B?WDM2SVJDdHM4MEt1U3lGRkFnbEVxc0VmZ2NoeGtGcDZtUUdKdU5YM1lGcnRI?=
 =?utf-8?B?KzNlZ3RVRU1zbDRSN2ppZnpGcU9RT0dzY0o3d2R2Zit1RTJLajB3Q1dhN1lx?=
 =?utf-8?B?cFRXUExZblpoOXREQWFUaGdGa2RvM3lBQkVpc3FEYkd5Y0JBV1RKMmN4VFRG?=
 =?utf-8?B?SjlmcHBic1hMTE5Iai8ybjJLU0ZJWTZ1bGZHZnpNMER3emlYTWR4Q2JtbE45?=
 =?utf-8?B?R3dkbHN4bjBmbHM4a1I0Q0RKUEhORlF1OFdRNEw5WmsvWXk1eW5FTTF5R2Q0?=
 =?utf-8?B?SXZsSE5Vc0NoaUFmTzhVeGNWOUlvODZsU2xqOFNyVjVqT0RSbWVKSlJ1V0tv?=
 =?utf-8?B?L1FQdUsyVVh6WkFMSFBIV25ZeUZiTyt4OC9PaWFYek9TK1lYbWl0S0FzajRj?=
 =?utf-8?B?UHZqWHdwRFRoYW1oazJDQldKWm5BRnJTSzErSzkvNS9rN3U5SHdobmFlamFM?=
 =?utf-8?B?QXQ4UlowaGZObklvR1J0Si96eDcwYXAzb1BwWmpONTBZM04vaHBPcDdvOGJz?=
 =?utf-8?B?N25YbnkwcGI4VjNOZ3NEcXFVNlc0NU9IRFpUOFdGOStQcmhlZWRsSWdDaUYx?=
 =?utf-8?B?bnpHWEdTcnpwUDRYQVEvZnA2RHcya2V3OXg4V0wyRUNoRTFDa1ZyV1hoSmRI?=
 =?utf-8?B?SmZwQ1NzbnFPa3ZHYWh1Tjdsd2V0SDFmNEZIcDRWb1V2VnFlSjZyZ2hHOTBR?=
 =?utf-8?B?WFRHRnlwYXZyRWJvLzd3Ni9KVjFINjM5UnpTQXBYdFY5T0w0VnBuT255UTNH?=
 =?utf-8?B?WCs4Y1AySnoxTXlTV2ZvU1BqdVRFSFJ0QzB2dHJ0MmJKOE5XdGRjVjZIb1ZY?=
 =?utf-8?B?ZkQ0YjdWUEJOVjRyRm9ONVkvNDlzRndubElBT3lRS1V2WXQ2dHNLR3g3QVhT?=
 =?utf-8?B?NXd6MkliM1I5bVJGK2N4R1hSLzdyWG0xcGNSYzRDWk50SUs5Qjk5NThVZ3ZT?=
 =?utf-8?B?bmlLMXFOcGc2aGluQnlUR0FwZVptRC9COXJmR3VqMW9qSW5qaDJjK3QrT3RG?=
 =?utf-8?B?UGdZNUxCL2pxaWtwTW9YVXhMQzdzRDliUzgyaWNjOVNqb3RaZjBuYWN0dHRv?=
 =?utf-8?B?UStremVYSUg4ZmkwSHdNMTJMbThpTDh0MnJuTWo0VWhCaHV4MERnbkRlVUNL?=
 =?utf-8?B?eXQ0ZGFvUk4vV054NTJydExkM1VTWXB5NWdjR2hLaHFhU0tnSnZhS0ZQbC9t?=
 =?utf-8?B?V3JCSWpmUjhkWldHZWZQZGdYTGdwNEc1N0wwUkxnQzVNcXZBcTBXSTFuUUNR?=
 =?utf-8?Q?3sbU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:26:56.7630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee33128-f9da-406f-8790-08de0d80d83d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291

Add a helper function to check if a PRM handler/module is present.

This can be used during init time by code that depends on a particular
handler. If the handler is not present, then the code does not need to
be loaded.

Acked-by: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Reviewed-by: "Mario Limonciello (AMD)" <superm1@kernel.org>
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


