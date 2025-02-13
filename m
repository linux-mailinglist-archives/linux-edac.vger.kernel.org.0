Return-Path: <linux-edac+bounces-3069-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C48CDA34AA5
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 17:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F277A51EA
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43C24A06E;
	Thu, 13 Feb 2025 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2OVVCgm8"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B6A245B05;
	Thu, 13 Feb 2025 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465203; cv=fail; b=ip9gsyxpms5IjlaRPuD3vM3GEul/JyeS/TZTnF3VBdC1XJkpztcM/oGszja+/yF9wxhdgYKg4t2iRILUjTOtD2voKPSURjb1YL7FiCpQ+iQOoHytPDigS0BYe9IkpFyKRT/j6KT4Y4mE6tJbpI+wc74ZBoUHCLymLWFP/twtrrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465203; c=relaxed/simple;
	bh=Vw9NCVreTe5f7CSFCshLqlWZfNbu0ItFZAgIAi0Tgd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=td7pn5CFTiJe/U1SfF/GfqddOGp17Jra0wHAch7A083NbXtVel+ZIVcK0UvwT36EsYi4eZGNUtfdgVNNmNvpJLZCKYkILCMgbqY4SMPAkbdiWVfOozSPDjRpr3pkIk6TZFyfhAiz5oRoVSjz9q7D5qEGrgZ4YjqZAUUl/w9JXFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2OVVCgm8; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pB51tdo8FHlac2XD2NvuFlFpJKWSB5NZ//OVtDg1Udbl0inQZEAdzGSko0p3/EtcKVhev8f+7FFvKV0ajh1q5Ek+AgqQih7mzh5CFm3UXXS5iAWd8tBCOjkgR0gDTgUFEyyVTHpn+4tKQJiZAS863DhRlASocOfkouNX1SPWT+I8KIiTwtogvBU9WRwr5jTm+kEzZrWJ41hmH/zP1vHmzbZmCzuHr2qBFkFXInkGo+xRYk1VjRTuoyqVyswBJdEWHWJAJP0w4tp13x9eL0GzM/sloIetJqTUpXJmquE01GZoWrqbFf3/E2+9Of+utnS3Sq3PoCjQTnYTCMcP4U4lyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzOhbNyWBk7/sc36uNI8oAi1QRQV0PfIpBrbjKNwzCM=;
 b=tVq0pQSfA3pUrneVOuQ9xTExznxlO/+2Ne9BDGTQ6yf+7cU5sNwX2uuI2MnDq6fPyJTa9AlN066tYICIoi8P37cVvUXn3ulRa3jIlBk1cTaoJVxYqKOWdBPRzVTtMsgl8PHXgRbXsAbpj3les5TuK7yiR4pkfUniyfV7fyRb0B3oprMawNppaMeoG0Ob+cgHylfYUQ9uDEecmAgeuftJ7ofZMIbDGJ1H0Agr12Nz7wrx8Cvs+9ezfeezB1G+FJcf2cREZ57OHJilRFxPpEEqLRG4HI0u3Ljk+fqedkzpKnRvEh2Lfwbj3TGFxyUmUOap8qbVudKjpGaFYdI9hdVdDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzOhbNyWBk7/sc36uNI8oAi1QRQV0PfIpBrbjKNwzCM=;
 b=2OVVCgm8jdxZpq6MggojuvPP/zBiGcThPyZ+mVIb816adw0F8p7DIQSJuIPSTASF1k9jvoMRIW2oCsYL3L9/inqLKMXt+oQft5qo1mt1UeTwQ/ZxOAIyW8FE7OOVV/7rFmu66NG2gcSkSzm+CPv/mTsk7f7Hzcoy65IcVWr+GIw=
Received: from DM6PR11CA0002.namprd11.prod.outlook.com (2603:10b6:5:190::15)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 16:46:37 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::43) by DM6PR11CA0002.outlook.office365.com
 (2603:10b6:5:190::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Thu,
 13 Feb 2025 16:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:46:37 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 10:46:31 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 13 Feb 2025 16:46:04 +0000
Subject: [PATCH v2 15/16] x86/mce/amd: Support SMCA Corrected Error
 Interrupt
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-wip-mca-updates-v2-15-3636547fe05f@amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-e27d6
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 57dedf80-8d35-44a7-ae96-08dd4c4dfbdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFpCZXlRTXVubDRZdzIyREluem1xSE9peHpob3k3Zkk4NWhxVUVVWFh3RXRm?=
 =?utf-8?B?OVlZY2RuLzVDT0dOVDBPYitqZ1NnWUFxbzVOVUxhYXNiUld5QUF4MGlTdEh0?=
 =?utf-8?B?NXJSTVN1SFJ3YzdRb3dVVUYyNmFWUmVUTXQzK0d0UUtQbU1xQWpDbkNocVVs?=
 =?utf-8?B?b2ZhUG83OFVSM09IbFBFTWo5bFBKY3pnVzFFNENuVVNNZm5TRjU0d0lHU0h6?=
 =?utf-8?B?K3VQRGpSa2pKRzlUakxwQTUzeE1DemJjL3RwQjN6NDViYWFXRUV5aDllOFpW?=
 =?utf-8?B?QUdUOW94SG1oalU3MG1vZ1ZiVmdtTEt5Nnl6STRnbXFaamFSNDdGQVczcFhv?=
 =?utf-8?B?MHFaSGs1TjROZGxNaTUrTVNaaFhNVWY4dDlqdU8vL0xNMmdzbmlCbTFoaW5r?=
 =?utf-8?B?Nzh3YlRWQkpaQ01XQXNzdTBBaEtIWS9ESG84RU1HVFE5NlE0cXZsajZFcHVh?=
 =?utf-8?B?YzlzWkZnMmpDckFQdzdtUGRsSWVuY25OMEVWZmhwcTNmVFRDZlZBYzI2dzV6?=
 =?utf-8?B?YTdCRlQ3b2Y3eEh3SG1XWEt6bXZtek5BMzVqbmFBSjUwbDkzTnY1VW5MYVZw?=
 =?utf-8?B?MlFla0Z1aWtqcTRWajZJVlNVN05oREllNXhIbWNSWC85MWEwcmdOSm1tcnY4?=
 =?utf-8?B?bTNCUnE2U3VrRk1KZVNhTXBQSjNFTnRmMU5DS3Q0Ymk4cGNsNWdQYk1YOHpL?=
 =?utf-8?B?c2F5eHV2Wit4MlZNY2VkaTdiMWFJQjZLZmdvNUdNU1RhcE1kVGtYZUQ0aHNB?=
 =?utf-8?B?MVpiaVdwVWVGUXFIK01QU3N3SkJpRFowNlhRQ1o5VkNXSUhPdFo3MmRDNEZQ?=
 =?utf-8?B?ZTd4anBmdXBPeDE4by9nNjhkZndJVDJid1BVbUdrWEFWdm9YWHRLWm9rWHNJ?=
 =?utf-8?B?WWRyc1R3SnMxTzA0Rk15L28wYU5DZHJBOXY0NEYzTUpGRDRObXFNU1hvZ2hX?=
 =?utf-8?B?WGw3Zm1nbXlNQno3TnNlbE01NkwxV1MzRWl4QnRTako2TFRaQmM0TzBSbXlV?=
 =?utf-8?B?ano1NG9pK2t6YVQzT0hLaFBwdkRjRzFjL0dIQVp2c0RqLzJBay80cjdNNThH?=
 =?utf-8?B?WXVOK2pvR3NkdFU1dHJQS1RrQjdReXRId1B1Zkt0U01FU2R5ZnF2bWdTMzl0?=
 =?utf-8?B?a0s0L2J4TjdVRTBQaGNnTStWWkZvZUxaL0lLc3FNOEdIRkJCOUtvVWN6NG0z?=
 =?utf-8?B?YnpmMmZYMjJJRzlmWGlGNExWdzk1eFR3ZDdoczhUTVFWdlZvd3JrYlZUdDVz?=
 =?utf-8?B?dCsxdHVTZTlyRGpkNXZ1OGJmdXl3QnhvL0F3dEd1bWJlYWRqU3hyVDluckM0?=
 =?utf-8?B?aTd3RStnU2dRSkRlYUJsQTdudGNMUUtCcjFtWVVDWlRGcFhlMXlTcUE2QWht?=
 =?utf-8?B?MEE1NzBDZGd2NlRBdGQyN0FzT3lJT2U4ekI5NHlaTmF5b09wYTAvUlNGQU1E?=
 =?utf-8?B?b3VUWGFXc1VPWlhIVHJTZWlkYWp6THhNWE9jbStDNFdGQUF6NDlDNnZKMlFB?=
 =?utf-8?B?ZGRJOGtDTDdCdmE2T3RaN3pRcVVuc1UvdVdkaEdqbzdJb254eklVelNSMjQ3?=
 =?utf-8?B?VlpJTlZNTmo4NGMySUEyUGF2RnZPVkYyeVdjNDIwRDhqaDZzSW92MUtsS24x?=
 =?utf-8?B?c1Y0Ym5BcHJRM2M2dGU1aFpJdnlEZ0ZuUnRmeVhYbHovUlRFdCtkdFNPcG10?=
 =?utf-8?B?NU9UOWVTZEMxdTJKd3laLzNMTlNLRVBsMWpDeHdOSHdzZW1Wb2hncVpUVS9z?=
 =?utf-8?B?eXpWbnN4MXViOUNMczRIK1dzTUZhVXV1YThGdWtQT3FFVHBDRVdEczduVlBu?=
 =?utf-8?B?akRocWpyL0tuRVpRRDJVMjhnNWMyS0lyeWhIVXh6VlRyN2oxNVd6cng5RTVm?=
 =?utf-8?B?THBVb3JZVEY4RnZPOVZ5U1Vpc09HV1IxcEtkTTNRMElEbVJDUGRpSkJYZC9Z?=
 =?utf-8?B?RFREa3RkY3pZOXBxT1F2Z2w4eXZ1Zjk4aWRLRnZsRWNzWlRUOURRSTJFYk14?=
 =?utf-8?Q?ONcTqlRigcrwL2k90AKIcJsoD7uEGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:37.7161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dedf80-8d35-44a7-ae96-08dd4c4dfbdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

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

Notes:
    Link:
    https://lore.kernel.org/r/20240523155641.2805411-10-yazen.ghannam@amd.com
    
    v1->v2:
    * Use new per-CPU struct.

 arch/x86/kernel/cpu/mce/amd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 75a48f484815..404e0c38f9d8 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -306,6 +306,11 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 			high |= BIT(5);
 		}
 
+		if ((low & BIT(10)) && data->thr_intr_en) {
+			__set_bit(bank, data->thr_intr_banks);
+			high |= BIT(8);
+		}
+
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
 
 		wrmsr(smca_config, low, high);

-- 
2.43.0


