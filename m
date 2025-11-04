Return-Path: <linux-edac+bounces-5329-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 565B5C31AB2
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 16:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0EBA3B4711
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 14:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88332330B2E;
	Tue,  4 Nov 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5UetMOGZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F732E73A;
	Tue,  4 Nov 2025 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268163; cv=fail; b=scG5cgCqQPJ2TLNHxo4Zbd3gk2KOHIvNNQQKcVS0taR5ndXvD0ZgO+fnYw81DYFhEF3rQOWN4dHBIBBQ02kbjpl28I+nWw1OiT+znEJ0zfqWr2irlpT1CaYKf2Uz/xAqrmR1SkciSCKuL9bJCrPSFZe8eucP5SY7IZ1KTXyoqa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268163; c=relaxed/simple;
	bh=hTWpumJFsUqB1Jfr3KBfXEpmKLe17uM6UWTPQrRjqLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jDFHfBskmwC0lwc0aVJgp+OAeOSJiVTCGG94zJ3pT/2iR3vSLBO8br5zcGJwzVcLNpwCy6CkGeEmjE8I8VerfdOKPHLoc7Cxl8bol0PfexYqIg4l4Klka6zjUkE7IGKzibDufibphzXsQt+WLRskswlQJ6ltm7irnhbSlN7NBFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5UetMOGZ; arc=fail smtp.client-ip=40.93.195.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwF/O+6oa2EOZPVHcxZMCgKMk1EScWtnLdD9gACXBP7nFDvkqPP58Sis9yVscmNFoK1RlgC3+2d1LaGR8gO1xtiqmnwRAnWQMj25qkCcPNIpgMiJCiRcAbNZlAMi+Kkoj1qWEj77oMQfYLwQGqNYq9ET7acoNY1O+esbRHm/hJisQV1ElfTFOHz1dkfN+NtlUAHixQvW0vep7VCAiLRqGZ7/S7lfkP17SxQGm6vukzgW9ws02GNP5b84Dk2OQwECOK37CwFZTR6un8nEJ3aM2ox5c2tMYm3WN0wD3WCEv8Qklq/9hjemoyakK2iUDgUfU8wV96ujFiJJHRuMvpC8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8uDr4k/B7M10ZgLnJu9RXiehL+lC+7PazjkNrO4toM=;
 b=FRaLj07349LDXKI6pHONhoyc2kunhSPVFyL6Mw4tlsmnvzu+Ls8ETYVeS8vQfUXDlC9Pj7q9qjMq9oiiyDHgZBKP81pV+jbykxCwF/yQ9g4IGRDNQqEaMORkQ3hyJwb9w3w3FGrypDKSY/AmbZ4Skv0g0KoTz36DaZ5KL3U/iGskLHR6Dd5qQVjszUB3KjyaCyr0tbpe/YHn2mHEKYy15bt/DV9LYc756iI1lB8S5AgngGjImOyoXUBUBor92Uh1iYprMEPo+wlalqosP3YpS/RYazG4dVOIszSDkXmo8TwgDrbnfSpBrWnolBJQ5gG+tGzegOrhBOtgT13TVxZM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8uDr4k/B7M10ZgLnJu9RXiehL+lC+7PazjkNrO4toM=;
 b=5UetMOGZE5ngNAjD/7t9WdSSHJgPRh+yic05rZcT74H45f5qrzFZ7Z8FIRKQODHqW1kSOrwsal9123ZWMNfoUjKNd4EmfLWKpMTs1epdjq9uxntF1aQed59iHoyGVeM8AQssSyfvl8wFskYup8futauDudM8jPVHDaT+JlKIc5I=
Received: from DM6PR06CA0099.namprd06.prod.outlook.com (2603:10b6:5:336::32)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:55:58 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::55) by DM6PR06CA0099.outlook.office365.com
 (2603:10b6:5:336::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 14:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:55:58 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 06:55:52 -0800
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 4 Nov 2025 14:55:41 +0000
Subject: [PATCH v8 4/8] x86/mce/amd: Support SMCA Corrected Error Interrupt
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251104-wip-mca-updates-v8-4-66c8eacf67b9@amd.com>
References: <20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com>
In-Reply-To: <20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, Bert Karwatzki <spasswolf@web.de>,
	<linux-acpi@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 914e873c-421a-45e9-725b-08de1bb243b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXN4UGZybU1YejlqSCsvbWJBVHR3Qk5LNnQwV05LOUthZ2daTTl3R20xMkhj?=
 =?utf-8?B?M3NGeVZaY1ZtYVB1dFZ5Y2hyRXRiTGJVaTJzVUdVYzlPNENDU3NvQUIvck1X?=
 =?utf-8?B?bktmaXJJdjNVb0dnUm1QKytwckhqNC9sZ0RMWGFmTmk4TThKMkF3bUc2Y2pk?=
 =?utf-8?B?ZXBLb3N0TVJzeGYxZUxNamcvWXdsU1BpQmJJK016cVNqYkZZbWtGRHNGR1NX?=
 =?utf-8?B?VzF2ZGU5QTkwbmlZRnVqNzZGZ3hsU3Q3VjFpd2FDckNxeGNpSHhPMUNMNHN1?=
 =?utf-8?B?TlZvQjNrNVR3M2xCZktka3pmTU5lQU9GcVQ4RFcwbkRmbjhxZi9uR0ZoMW9K?=
 =?utf-8?B?dnlDWlpSQzlQMkxrVjVwM29hNXV3UEk2c3NvVFdTSnZBNkJpYWhhT0dNQzdZ?=
 =?utf-8?B?UXM4ME9mbWc3WWs4NFMyNHR1NDdSWFFOM2I5aytNQkEyZlI2TDZVYmpGdDJu?=
 =?utf-8?B?RWxIV3YwTEJZZ2JEWGxGUzdyV2EzQnpJVnJ4aDBnVzVFUjZ5SzF3Q0sza3R3?=
 =?utf-8?B?T3J3N0oyWUEyYmljQk9YeSttd05BVlg0a005cFY4RXplanlteFVBRkprUStX?=
 =?utf-8?B?N2hjQVdRRnlmcTYyMDk4cVVyVm5KNXlsT2pGNVlXdUJRSVMxdi8rTjh5RVk0?=
 =?utf-8?B?WFZ0STdlWWEwU2F3ZDlydklNZ0J0eUJNcjNubUl2M1dmdE5leU5IeW1pQXFn?=
 =?utf-8?B?NWxZOFVuYXdWaVUzRS9Ba0FZaTAwRUsyT3dwU2tNZUFodDljTlRpTWliZDRE?=
 =?utf-8?B?ZTF5YzNuSVZKdEMyZUxsU0NKU3FyVktyYmdGRzlzWjJIVXlFaGsrUHZaOUtn?=
 =?utf-8?B?VUttcGVuS1pEc25hcmtBakMxMXpGcVlQdFM1c28xVDJoL1dPR2RVRExWNEZl?=
 =?utf-8?B?eDViZ3pCZ3dWS1lGcXYwWGtQRHhtc1F1QXNJNE4yQlpFM1MxYWdGS2tITnhT?=
 =?utf-8?B?dGp6SThSdUFSOW5iZE9IWGNndVpWb0c1eGtBbzB2R1BUU3RiOXVEd1o2eTlS?=
 =?utf-8?B?dFRsYm9yazlvVFIwbGQ1ODBGbDVDVGVKVVlWTUw2VFhaUUhNUUU4bEVad2Nk?=
 =?utf-8?B?YS9RNlV5NWx4ajNZVnNadHdTa29ESjJrY1FzZEYveUFoOS9RcUFRRkxuK293?=
 =?utf-8?B?VWVZMFFYTWlDRjhMVEFSS1QrVzEwM2FrU0srY0RBRGRyWitLZEtqT0l5SWxC?=
 =?utf-8?B?U2daRnVTdkpiOVd0ajV0RWJHZDh1U25NUU1UNXZKOUZqTkVuTmlxaTA1bk5o?=
 =?utf-8?B?ZXdONlphQ28rTW5UUml6UXBMODFydFlHeGE5K2VBdEtkejJuWE5ielFybzAz?=
 =?utf-8?B?RG90SEN0WFBaNFpDKzNFakJGaVJ1UmJuZjd4Y3FORDIrcENrM2gzYlZhOFcz?=
 =?utf-8?B?cEZ5M0llTnk4WFo0M1VrT2Q2R3dPU3hnUE8wZGpBOE5VUkxaa1J4WmFnOFBM?=
 =?utf-8?B?QTNSVkxESGN3T05FK2NXRk9aWjUyNFJZV2pPc0QzY2FBSk0weGJrLzNqOXhp?=
 =?utf-8?B?M0ZqODNTNnpld0swU04yZWFpWjZtZzdKa1E2VjFaNVI0dzh0RXNmampWZ3lq?=
 =?utf-8?B?OW13emFLZ3NDdTQ3WldjejRPR0thOTc4M1Bpa2I0SENLYmFaU0J5cFU2N1Jk?=
 =?utf-8?B?RzQxTEJZVWRieWVIaWN2dWtMcGNSKzlxMFBYbEJuYkFHV0w5YmJLemhrWDZ6?=
 =?utf-8?B?MmVMZEJoZ2ptZVhnRzBwbitxSUozTXgzdXNLcXVGYXJOcnE0bkU4Z1hYeTNx?=
 =?utf-8?B?UkZ3VUlTWXFscVFYM2xjYkRQV2QzdVhrejNWMUl2Q2VHVTVXN0lQN1ExUUJu?=
 =?utf-8?B?VG5iSWU3eVpCRkhROE0wcnJOKzcwcXZvMGI1MnJsczJWNUZ6cWZKQWdzbVpV?=
 =?utf-8?B?ZytvUVFzU01rSGllSnl6U1dqdzBsSk8xdDJWSjRUdmR3QVpISk5kT25JazBi?=
 =?utf-8?B?Zm04bERUQk4rWW50RllJSXRZWW9BWUdPR3pFWm53WWpSeEdNYUd5RTJ0cThT?=
 =?utf-8?B?VllnL0hQakxrbmQycHpiMTh6cjNONU52L2tKNzZzb1FOQWlXVFkweDJGK0lW?=
 =?utf-8?B?WnpkdGFvQUduQjZ1MVBKWWM0T2Zobit6ZjhDMUE2RGJNKzIvdDlabUZsRkxT?=
 =?utf-8?Q?xRUg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:55:58.6621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 914e873c-421a-45e9-725b-08de1bb243b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697

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

Check for, and enable, this feature during per-CPU SMCA init.

Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20251016-wip-mca-updates-v7-4-5c139a4062cb@amd.com
    
    v7->v8:
    * No change.
    
    v6->v7:
    * No change.
    
    v5->v6:
    * No change.
    
    v4->v5:
    * No change.
    
    v3->v4:
    * Add code comment describing bits.
    
    v2->v3:
    * Add tags from Tony.
    
    v1->v2:
    * Use new per-CPU struct.

 arch/x86/kernel/cpu/mce/amd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 117165c357b7..6d16b4589eef 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -308,6 +308,23 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 			high |= BIT(5);
 		}
 
+		/*
+		 * SMCA Corrected Error Interrupt
+		 *
+		 * MCA_CONFIG[IntPresent] is bit 10, and tells us if the bank can
+		 * send an MCA Thresholding interrupt without the OS initializing
+		 * this feature. This can be used if the threshold limit is managed
+		 * by the platform.
+		 *
+		 * MCA_CONFIG[IntEn] is bit 40 (8 in the high portion of the MSR).
+		 * The OS should set this to inform the platform that the OS is ready
+		 * to handle the MCA Thresholding interrupt.
+		 */
+		if ((low & BIT(10)) && data->thr_intr_en) {
+			__set_bit(bank, data->thr_intr_banks);
+			high |= BIT(8);
+		}
+
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
 
 		wrmsr(smca_config, low, high);

-- 
2.51.2


