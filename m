Return-Path: <linux-edac+bounces-3558-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8119BA8A21D
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 641A77A628F
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D1E29A3C7;
	Tue, 15 Apr 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="agIQPEmh"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F962BE100;
	Tue, 15 Apr 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728927; cv=fail; b=JsgiYyz+Uj43OWDX91KBKhF4sEi8NzWOSD4M4RpufDWknN5Qb5MfLCS44KRp7dNeBZ1S7rw8MXIbb7aTGCyQQwFTjx01UWkWuSJiri79AmROOYyVTaRVyOvl7CwDKAe8pF7VGZy4pSBibkBEjiLj6cCvIpzhVtajXRG7mwZfCYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728927; c=relaxed/simple;
	bh=L/anwRCfCfrELaqxg7atVEgFPjKr9gZjMpYZp8d4Y0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nKyVkb017E3LYKC3w1xeO+xV4uwwPkmYmb7Fyhrhd53fGVnGTinFIMOy+xXQpGQBNsbgRqDJO+yWVoKq3CuwK6g4shwDXh2VAgP8GPfwWgjuCpTEDq/JiVc/TE0wXCfhCqrCISjWMvPx2NEm4QFQLnLrcD/Zk6tus/h4hxb63gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=agIQPEmh; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVwHtzLYUU81eRgm1U4UbZ06KlQiPEFKDTX5ljCZ7K0mAM9ZmR+sQi6uwriQC4+6dp+pYCnNio9CdPcl7fEOdP/GgqkcIU0ZB0PZTLbnwlEAlRl02qmNYhluqYHLhGe6AW4I5FxaTZdvL99Vrs922bfLhpM6DFK1baWP9zZDZ+wfjO7hG4siyjDPaciCoueKF3UHXxdPAGjQ7f+g3y6kzcpgSukSKruDggVZuSZzN9XbPimyvmDBojmmIWMCkGprmlf8+EkTtNtsYH/M7A840bZyoxx0ATAOxvE4XaOsC95gVnb9Dz5AfubzS6nPxN6DwDe3GRsLsKuauVTpYKUYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+cpppyYpnTvdK+ggJ6vO1wQF7T3eURTWnd9LaUiAO0=;
 b=d1+AQm4JDOZ6H7mivLmSuwVLwLMeHaxZZ0nOrCiKeuYVS5/XRDXuX/2BPKoswkAhfQjdk9+p6q65DhrCNT8pPKAN2gGOEeLB2jorJFkwdc90kJl6/2/NHd3EyWuWtYTaXrK+4vbYMQWEX1roEC8fqhHSPPFMl7TkhCqxcbvJBoh8FDYSmbK9MOmVSIwIJFn8P5xlHK9Z+XqChIpDTMikMR81CAFsQHVEDxn2fseOExSQAWP/6zTOlKXrf6aKqe5PvahSFZe/O61KApj0VSIsmh1zL7l7YeIZef9yI21JQJelNcGONW+cIzNYMt8NQ9wKxXfxfLydzEyan9fOlT2tnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+cpppyYpnTvdK+ggJ6vO1wQF7T3eURTWnd9LaUiAO0=;
 b=agIQPEmhodZthI32YPsAlRCR0NygHiXSgx9nUxIPeryNXJBdhfbzDb1naR5tDQ2xJLAr6SpvUmFvd3tsX5RGOqMTv4R52Kz3bvLy3maOLeCMYSnq158fcLUtQWIr9n6ZtBqCtFLXUfbrE18V1YUSu9DXmWLeufQn7+cU1Z7ZGNA=
Received: from CH0PR13CA0058.namprd13.prod.outlook.com (2603:10b6:610:b2::33)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 14:55:18 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::d6) by CH0PR13CA0058.outlook.office365.com
 (2603:10b6:610:b2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.14 via Frontend Transport; Tue,
 15 Apr 2025 14:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:55:18 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:55:17 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 15 Apr 2025 14:55:10 +0000
Subject: [PATCH v3 15/17] x86/mce/amd: Support SMCA Corrected Error
 Interrupt
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-15-8ffd9eb4aa56@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|BY5PR12MB4099:EE_
X-MS-Office365-Filtering-Correlation-Id: db9c5556-9b29-4b72-ae2d-08dd7c2d8a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0VkTExIZE00NWwzaDJBeURldzhNT3hhakw3K1VXWXlNdGVTdDQ3SW5xR2s1?=
 =?utf-8?B?NEMyQlBraGdZcjlHQnFzN0VIVXJFdG01akdzSDh1VmlFM2ErdEpEUHpTOTVG?=
 =?utf-8?B?VDhralVOTFQ1VFRLNXJ2Q1lKR0dEcXkvTjBURmgxTHFJTUN6M2Z6eVVXcWlr?=
 =?utf-8?B?cTVjYlp1Y2MrSjQ4VGZJOXVaQXhYTjBCbVlJL0gxdHBlN1dTMGIrUzAwY3Bx?=
 =?utf-8?B?S3hDSUxBaS80aFBHMTFRbUQ0OWZZK3lhdTRaVXZtMHlMblRxTVlqMktpekU1?=
 =?utf-8?B?UTNrRlczRVhvcmVBOUV2VUY3TW42eEtBQXNGQ21ta09Fa1FmRGNoN0ZDelB4?=
 =?utf-8?B?amNYaUZZdGFVUHE4aE40WjVhMnZYQnBvdWRyNXZPUG1ndXNrNFhWOGJlSTBu?=
 =?utf-8?B?Q0c2a0hSaVhRVWVMTTRoekVLTzV5aUwyR3lJUS9QYUZGV01QdFVMa3FLb3dU?=
 =?utf-8?B?aXBqVWNiNjdjZTR0Vkt2cFFqbUZETTU2ZGVCWlpnUzM1b1pQQWRoemtZSVJw?=
 =?utf-8?B?d3Z2b1VhY1k2Nmdhd2pXSmNGaG9NM216VUNWQ3pwWXpJaU9WWEJSYXgwVlFv?=
 =?utf-8?B?SkFjRk9mRVVqN2hWU0JLdHlEWTJNR1JIbG9oVmlRM0F6V3BCa3ZZZjFvQTl2?=
 =?utf-8?B?UThRTUs3dlpCMHhxdUNoc09UQjJKMkttNTU5cUJkalIrVFhLSHYrSHJNdFpX?=
 =?utf-8?B?ZTlnYkNicFZ1bnlrNlRiVUhnMkFEZllrb3hHWGNnV0dOT1ZtaWY5NFV0dDNU?=
 =?utf-8?B?bUhreDN1ME5Hd1FheEpLRGZuejlERG55OFQ3ODh0UzNXampCeS9pWFdibG1J?=
 =?utf-8?B?OTRpUkQzNncwTzNCalBoajViRWVMNm90MVV2cFJ5alpmV2tWaHBRWFVnaGRo?=
 =?utf-8?B?TmtTdVpiZFNjdVAzWjlvZ2dnMGRheWZ5UDNQL2dmZ3NCZmNpWUY4bWpzNWNM?=
 =?utf-8?B?UTk3Z1NFb3p5MDBDbWxrNitvQlYzeHZLQjdkMG9obzJ0ZnI0ekI5aFp5dlBz?=
 =?utf-8?B?SnoyeDBTOXBneTJ4Z29uVi9QNXc2YmNHbnRmYXU5YWJBcHRiSXVZc1FrMmZw?=
 =?utf-8?B?UFZpRitjd2lXSFRoaFZqZkJHenVCL1NvWG5oaFlUekIxR1Yva1BPN3dpcWd1?=
 =?utf-8?B?djVjKys5KzdUeE5rOXRPSlptT0QxR05McTBqL2hrdm5XT1RoWkFyOHE4VS9k?=
 =?utf-8?B?NisrQndoVE41K0VoUUxqdHI3RTE2Y1FXQlNTNW5aZndtdTRFYWdSb0U2K3cr?=
 =?utf-8?B?bklsYkVRZFZ2MnNwSjRlMWppU1g5cnV2QkR5KzZwd2R5NWVrVlNaRHpjVjVN?=
 =?utf-8?B?cUNaV2NOa2o5anRveFc2R0lUeTczYUlmYlNFdngxZnFpUEZvOU1OL1RUV2Y3?=
 =?utf-8?B?MXZteVliYUhtU29xaWFDS2JHd05rT3NVQmhtd0FpZGRSL09mdXFGY0Q2TlZZ?=
 =?utf-8?B?OVM2ZUJEUENwWEhtSVMybXpULzhkckNSOEpJVUlRclkrQlZBbVNLa2d3NmF6?=
 =?utf-8?B?TFBOS05NMXNhWVpqckZFZXNRdjA2TXpIaktySTN2eXdORkxnS3NUcUYvcmRM?=
 =?utf-8?B?Skd4U1FkRXVtNW9ncVJFNFZ3Sk1ENU1PMjBtYmMvTXFzNWt5L2EwYVV4UDA5?=
 =?utf-8?B?dTdCSnNWQ09GVzBuVlFlVGc1bVFkSnFqbHA0MVpiWDAvUG12MnFLUmoxZWRG?=
 =?utf-8?B?Zy9tVUVTeno5M3FVdVZ2TkFPVjZPL3d6OEFEZmsxa00vb0NVU3JGZ3V0Qldr?=
 =?utf-8?B?RndqOUE0YkVBa0hTallCVFppT0JFczYwanRldjhFU2xwbFlQRzQrdzUwZjM0?=
 =?utf-8?B?UWdveU1NckpBK0YrQXZXb0JkNG9Idzh2K2J6Mzg3SlF5RFkxRFFaU3hXZlhS?=
 =?utf-8?B?OUZ4NmZ2UFNMYzBNb1FEYy95bms2VGcwRG5KVDJNTmVpWkc0SnlZdWpPUjFT?=
 =?utf-8?B?Q2hCeEpOZ3ZBdVFXcGdWcXVkanJIWlRGYi96a28zWkhOeW9oaEs4a3NmMWgw?=
 =?utf-8?B?dWVYN2tjT0lLbExSOTlpdDF0Sy9mcjR5OHBHT0cyZWR3cFFYdmpRZCt1cmdu?=
 =?utf-8?B?VEJkcjdkNVJ6UFk0dytUd3BPN3JIVXhpOXYzZz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:18.6788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db9c5556-9b29-4b72-ae2d-08dd7c2d8a04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099

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

Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-15-3636547fe05f@amd.com
    
    v2->v3:
    * Add tags from Tony.
    
    v1->v2:
    * Use new per-CPU struct.

 arch/x86/kernel/cpu/mce/amd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9e226bdbdc40..d76a64c47a6d 100644
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
2.49.0


