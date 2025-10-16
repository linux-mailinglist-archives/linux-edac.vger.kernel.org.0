Return-Path: <linux-edac+bounces-5069-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB55BE4A01
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 18:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2075E1FB0
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D01033A031;
	Thu, 16 Oct 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BFLkcwe/"
X-Original-To: linux-edac@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627BA32AAC2;
	Thu, 16 Oct 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632688; cv=fail; b=iW8DcZ8WGw558VR8K8ZYnSgkbWXBPyxGc9w2oud//Nokbw/J5OKZLUQuIaShRTw+H8ikBPzcMlteNYzYLfzBNZfC7wg8E3ODy8G0mJhFdybDGP0O6yO7bPjXzOiFhuWpy8TInp9hinNSllQmiv2FWmzDqTdph+FAQ5Wde/NQ2uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632688; c=relaxed/simple;
	bh=KLvtPEUfsxP06mlslzVz/8RZkIVZyf3GOGzeUYM7giY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=N45khpLdEWpsxgkrY/O996ohfqv56bBl/UFO2clsgtDmxHhCn75xNFTPHDHgMZ5zYFGNmuHXkLp1i0hLrepNE/7O0e8t0IsZiwOPO03v1E2PI85nTBlT1aSZoYR1UMF6lERLFpMX3Rk2GIgXiMsnb8Miq8KJEsck4UAqhFaM2IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BFLkcwe/; arc=fail smtp.client-ip=52.101.85.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrGOpF+rJS0PAPT3BtHlw4uPeKndNXwjEthyRHZ4c2bydgFRn91ZsJ0+26Tot/KlVcC5UV+MjUFxN1bB/Wot8J9boJ2CTCd1lN0PDPs2eXmM1nHvuUIz16zwGMZ+bcvP3+o0bkKKHUZbhFkmuggwS+iWsf9qTlZ/hi6It6msYy8uM9vkdmNrJyenHeLOdDR5tnKkxcKc2ddDpOhTHb+T6KdBrOmU7rxZvZS+NVR8TbxcHsE3FUColoMELpjMj++FGyoYHOQwkK1hUCZx1kUKg37GHB7GHZCNmBgxpOqb54yPnGCYozp7zBNWCtVC0udPi3d8ojBgFrocfWEHhiYSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1fQbv0v7C6w08aG1aZJGuvZeNkVQOFZVCIHG5Vc63I=;
 b=G9C4JkvZst6qSys1kCncA/GySTGJKAWeh6wykwU33Ur9R3x9GP/18JjEkh0PXbix7R5ce1x8jh1IBbo3mvr/Jny0nBw0JSO2B/xHokORzjt7ib85RurHUB+YhiZThNUEFxL0pLG8lCJLkyluLK6yaLda6MQllaZ8aogcp8J0liTUWiNMZK9SP0ij9ONmd8rZ8FbumMDjKoGRUhqAJrhr3gvMd5uO2djFjK2I5iozGfq8m5/KIHO5W0kZfJzukio9bORS3TfqQl8UjqpqnAocy1ymDOv9w/Xz3L2dFnW69VxRexNDh7U9PHfx4elFYHsjznJmvzXZSpJ9drXr7ODtgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1fQbv0v7C6w08aG1aZJGuvZeNkVQOFZVCIHG5Vc63I=;
 b=BFLkcwe/dUm6Opc/G55dAPE9+chS0pANvAl1oO7ap0FVJtC6HuZdDZ8h+5qASWn8X8wrHb5dMjprvxGcpftOzkJBwAUhM03Vz0ezepYu+ZHIwEDHJ8P71lk32VkkWD155XHRzC8iLmRck8RN/+pI8iFN1u2hhbEGHepg5q3RYYs=
Received: from BL1PR13CA0134.namprd13.prod.outlook.com (2603:10b6:208:2bb::19)
 by LV8PR12MB9716.namprd12.prod.outlook.com (2603:10b6:408:2a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 16:38:02 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::83) by BL1PR13CA0134.outlook.office365.com
 (2603:10b6:208:2bb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.5 via Frontend Transport; Thu,
 16 Oct 2025 16:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 16:38:01 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 09:38:00 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 16 Oct 2025 16:37:48 +0000
Subject: [PATCH v7 3/8] x86/mce/amd: Enable interrupt vectors once per-CPU
 on SMCA systems
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251016-wip-mca-updates-v7-3-5c139a4062cb@amd.com>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
In-Reply-To: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|LV8PR12MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e714a80-3fd7-45d5-97eb-08de0cd25f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dllUN015elMvUzdmamtXeVQwWUUvcXZpb2JBZWtOMnF2WHFGT2Q4OGlpRmUw?=
 =?utf-8?B?VW4vZnZXVmhCZXJQY0FVUzZCcmZZN0k5T0sySmI2WHozcXZ5cnJBOElZb21S?=
 =?utf-8?B?dllTNUlOV08yS3JpVERvajJFejJHcjZRVTE5VUM1enFYcUU1UDZZV3RJS3l3?=
 =?utf-8?B?ZU56NWN0TDlsekNFRE1GZmc4eWhOSWJIdWFMZWkveWtkVHM2dncrWkxEVDVK?=
 =?utf-8?B?T0xZU0ZXVjVPTDBIRHZGWWxuK2NubDh0cGlpZm95TFhoV2tXMFk4WGVvenQ2?=
 =?utf-8?B?MUM3KzNkb0tsYkVJZ1NGTzJnK1NBNEdOa2FqbEVDSlhUdWVoNlp3Z3ZDaHEz?=
 =?utf-8?B?dkdMZXVsajl5RXJhelBYOG03QWs0Y0dEMmo0ZWM2c0gyY1RTeTl6UEJwM0pZ?=
 =?utf-8?B?N0prTTZJQnpjSkw3SVFVMDhaOG9oeUNFOW8zUUpoaWd1a1hrNnpZU3ZITVR4?=
 =?utf-8?B?QldwNDlTUWIvdlhjOXowVEFmbG9HYmVaZGJTd1FJa0E2c2ZrRlZEaUZHRVdi?=
 =?utf-8?B?Sm9BOElIc2xValBQQ0dxei93SW5memhQKy9LQmVzamp4cFpHZ0Jkdy9nRy9y?=
 =?utf-8?B?QTFFN3pkUGpnV0R6TGhaN3FjSGJaL1J0MHRVb2pSWmEwN3hZY256amxLd3gz?=
 =?utf-8?B?Qm1XWDRWNnJYOTNoZXh2UDNUYmUwNlRpZE1FV0FZZzNpdVJMbzUxaG9CNVJO?=
 =?utf-8?B?bitaZDRDUzBCOS9GVGdhOEZ1d2lDbFE2anhaRGJNUFVWdHZNS1ljNDhNRk5z?=
 =?utf-8?B?ejdHRTNQb2hWUkQrM3AwVVpOMzNONHJycW13ZnNBSmVrL3IwZU9BSWpaQ3F2?=
 =?utf-8?B?N2wrQVlGdDkzL3FmZnlXV3ZIczRtcHA1MDFvdDFtWU1JaS9qZUpkblkvcDNu?=
 =?utf-8?B?SUtFeWFwNGh6V29TTFFZMWxnMk9MUHgrLzlxNlBCb2swVjlZQ0dFOGJKMUFM?=
 =?utf-8?B?MTFpUnpCaVN1R1U1WUF3S09jU2lEQWlMRUszWHpYL3huTm8xdzF6SVRSQzVC?=
 =?utf-8?B?NU91TDhnNmRRR0lCNklpeUgvOGJqSmd5bVlEMVNQRDNSYzlGSWZLQnc5My9r?=
 =?utf-8?B?dk1Bc3c0MEpRVk5oSm9sdExvdUlJT1FlcGJrS3BIWWx5eS9jd01sRnluQTBG?=
 =?utf-8?B?WFVzTWpXK2lZS05WMDlsY1hiRXdlU0VOMzdhY1VHcWxSWDM0ekx2Tng4MXd1?=
 =?utf-8?B?T1dQQU9qOVZhQ0ExWU5KWTRrVnQ0akw1TE5NR1l1QUllUVVyRXpkS0JIK0Fm?=
 =?utf-8?B?NlBPUXRXZ3EwTE1MSHB1S3RJVDZOU0N6ekxwQnZ3UVNTd3NSQ3dUMGlPdWF3?=
 =?utf-8?B?d0lJSExlWHZrYzlMT0wyVjQ3ekVmMEJZaW80bndrWmZLK0k0ZVBsMUI4UUtU?=
 =?utf-8?B?ZTA5QktEbm4zNGpFZnczMGdSOG9oZjk1OVpoSms4REJUZG5zY29meElCa1lH?=
 =?utf-8?B?djVaUXR5WTViRVcxNkFqT05pSlZxQTRaZ0g5elhDQXNrbjQvNWozTDUrUWtS?=
 =?utf-8?B?WmRja3RqU2R0eHk4ZU1LK0NHS0piRkczSEdBY1BKcDcwMGFIWnE4Wjc4V2xE?=
 =?utf-8?B?YkdSNDJZTmZoWmpBUDE1TGNmdkprT29pdkVBbTdKaC96d2JWTFpwc2Zrc1J1?=
 =?utf-8?B?dXY4b05RMXY1eWtKMFlmN1Uxc1NPLy9nMWovR2JpR3hnT0lXK2w5NjRyamdy?=
 =?utf-8?B?bUZ6aTkvUXo4R0ZEUWZNWVZocnJNcEtMZmdjVkwwSTA5ZldpTnJDOXluRUVP?=
 =?utf-8?B?OUt0d1ZEUnVkY28wTzkyUFdETW9abnpBcm8xWVBFWmNacmFGNGxraTFHVEVJ?=
 =?utf-8?B?RWVkblllOFU2dVdnb2lDNWZVSnd5T2JPdlIzVHRtQjN4eDNaR2JxMHFpYzlU?=
 =?utf-8?B?TGw3ZExtN1pERDFOSEhMdERPWTQ0ZzBRVm5uMGJJOXB2U2ZlWjdQMXZFUExG?=
 =?utf-8?B?WVU0L243bk04aXhqOVRScW9QWEpZdG1oSG4wNEdNdkFvNjVWWEpHc2xXT0VH?=
 =?utf-8?B?V1A1OE1iV1V0RUpwcnFEMm40NGxjV0JSVE1icFV3Q3JzOW9VUnJUa3FmT1JN?=
 =?utf-8?B?c1phUGVMMVdDRHpZcG54MXhuMDVVaVJmTmdHRkFiVDhsVFpLc01zeTI4NXZE?=
 =?utf-8?Q?wU7c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:38:01.7285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e714a80-3fd7-45d5-97eb-08de0cd25f7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9716

Scalable MCA systems have a per-CPU register that gives the APIC LVT
offset for the thresholding and deferred error interrupts.

Currently, this register is read once to set up the deferred error
interrupt and then read again for each thresholding block. Furthermore,
the APIC LVT registers are configured each time, but they only need to
be configured once per-CPU.

Move the APIC LVT setup to the early part of CPU init, so that the
registers are set up once. Also, this ensures that the kernel is ready
to service the interrupts before the individual error sources (each MCA
bank) are enabled.

Apply this change only to SMCA systems to avoid breaking any legacy
behavior. The deferred error interrupt is technically advertised by the
SUCCOR feature. However, this was first made available on SMCA systems.
Therefore, only set up the deferred error interrupt on SMCA systems and
simplify the code.

Guidance from hardware designers is that the LVT offsets provided from
the platform should be used. The kernel should not try to enforce
specific values. However, the kernel should check that an LVT offset is
not reused for multiple sources.

Therefore, remove the extra checking and value enforcement from the MCE
code. The "reuse/conflict" case is already handled in
setup_APIC_eilvt().

Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250908-wip-mca-updates-v6-10-eef5d6c74b9c@amd.com
    
    v6->v7:
    * No change.
    
    v5->v6:
    * Applied "bools to flags" and other fixups from Boris.
    
    v4->v5:
    * Added back to set.
    * Updated commit message with more details.
    
    v3->v4:
    * Dropped from set.
    
    v2->v3:
    * Add tags from Tony.
    
    v1->v2:
    * Use new per-CPU struct.
    * Don't set up interrupt vectors.

 arch/x86/kernel/cpu/mce/amd.c | 121 ++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 68 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 64aa7ecfd332..3bbf2ecf71b6 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -43,9 +43,6 @@
 /* Deferred error settings */
 #define MSR_CU_DEF_ERR		0xC0000410
 #define MASK_DEF_LVTOFF		0x000000F0
-#define MASK_DEF_INT_TYPE	0x00000006
-#define DEF_LVT_OFF		0x2
-#define DEF_INT_TYPE_APIC	0x2
 
 /* Scalable MCA: */
 
@@ -57,6 +54,10 @@ static bool thresholding_irq_en;
 struct mce_amd_cpu_data {
 	mce_banks_t     thr_intr_banks;
 	mce_banks_t     dfr_intr_banks;
+
+	u32		thr_intr_en: 1,
+			dfr_intr_en: 1,
+			__resv: 30;
 };
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct mce_amd_cpu_data, mce_amd_data);
@@ -271,6 +272,7 @@ void (*deferred_error_int_vector)(void) = default_deferred_error_interrupt;
 
 static void smca_configure(unsigned int bank, unsigned int cpu)
 {
+	struct mce_amd_cpu_data *data = this_cpu_ptr(&mce_amd_data);
 	u8 *bank_counts = this_cpu_ptr(smca_bank_counts);
 	const struct smca_hwid *s_hwid;
 	unsigned int i, hwid_mcatype;
@@ -301,8 +303,8 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		 * APIC based interrupt. First, check that no interrupt has been
 		 * set.
 		 */
-		if ((low & BIT(5)) && !((high >> 5) & 0x3)) {
-			__set_bit(bank, this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
+		if ((low & BIT(5)) && !((high >> 5) & 0x3) && data->dfr_intr_en) {
+			__set_bit(bank, data->dfr_intr_banks);
 			high |= BIT(5);
 		}
 
@@ -377,6 +379,14 @@ static bool lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 {
 	int msr = (hi & MASK_LVTOFF_HI) >> 20;
 
+	/*
+	 * On SMCA CPUs, LVT offset is programmed at a different MSR, and
+	 * the BIOS provides the value. The original field where LVT offset
+	 * was set is reserved. Return early here:
+	 */
+	if (mce_flags.smca)
+		return false;
+
 	if (apic < 0) {
 		pr_err(FW_BUG "cpu %d, failed to setup threshold interrupt "
 		       "for bank %d, block %d (MSR%08X=0x%x%08x)\n", b->cpu,
@@ -385,14 +395,6 @@ static bool lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 	}
 
 	if (apic != msr) {
-		/*
-		 * On SMCA CPUs, LVT offset is programmed at a different MSR, and
-		 * the BIOS provides the value. The original field where LVT offset
-		 * was set is reserved. Return early here:
-		 */
-		if (mce_flags.smca)
-			return false;
-
 		pr_err(FW_BUG "cpu %d, invalid threshold interrupt offset %d "
 		       "for bank %d, block %d (MSR%08X=0x%x%08x)\n",
 		       b->cpu, apic, b->bank, b->block, b->address, hi, lo);
@@ -473,41 +475,6 @@ static int setup_APIC_mce_threshold(int reserved, int new)
 	return reserved;
 }
 
-static int setup_APIC_deferred_error(int reserved, int new)
-{
-	if (reserved < 0 && !setup_APIC_eilvt(new, DEFERRED_ERROR_VECTOR,
-					      APIC_EILVT_MSG_FIX, 0))
-		return new;
-
-	return reserved;
-}
-
-static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
-{
-	u32 low = 0, high = 0;
-	int def_offset = -1, def_new;
-
-	if (rdmsr_safe(MSR_CU_DEF_ERR, &low, &high))
-		return;
-
-	def_new = (low & MASK_DEF_LVTOFF) >> 4;
-	if (!(low & MASK_DEF_LVTOFF)) {
-		pr_err(FW_BUG "Your BIOS is not setting up LVT offset 0x2 for deferred error IRQs correctly.\n");
-		def_new = DEF_LVT_OFF;
-		low = (low & ~MASK_DEF_LVTOFF) | (DEF_LVT_OFF << 4);
-	}
-
-	def_offset = setup_APIC_deferred_error(def_offset, def_new);
-	if ((def_offset == def_new) &&
-	    (deferred_error_int_vector != amd_deferred_error_interrupt))
-		deferred_error_int_vector = amd_deferred_error_interrupt;
-
-	if (!mce_flags.smca)
-		low = (low & ~MASK_DEF_INT_TYPE) | DEF_INT_TYPE_APIC;
-
-	wrmsr(MSR_CU_DEF_ERR, low, high);
-}
-
 static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 			     unsigned int bank, unsigned int block,
 			     unsigned int cpu)
@@ -543,12 +510,10 @@ static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 	return addr;
 }
 
-static int
-prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
-			int offset, u32 misc_high)
+static int prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
+				   int offset, u32 misc_high)
 {
 	unsigned int cpu = smp_processor_id();
-	u32 smca_low, smca_high;
 	struct threshold_block b;
 	int new;
 
@@ -568,18 +533,10 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 	__set_bit(bank, this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
 	b.interrupt_enable = 1;
 
-	if (!mce_flags.smca) {
-		new = (misc_high & MASK_LVTOFF_HI) >> 20;
-		goto set_offset;
-	}
-
-	/* Gather LVT offset for thresholding: */
-	if (rdmsr_safe(MSR_CU_DEF_ERR, &smca_low, &smca_high))
-		goto out;
-
-	new = (smca_low & SMCA_THR_LVT_OFF) >> 12;
+	if (mce_flags.smca)
+		goto done;
 
-set_offset:
+	new = (misc_high & MASK_LVTOFF_HI) >> 20;
 	offset = setup_APIC_mce_threshold(offset, new);
 	if (offset == new)
 		thresholding_irq_en = true;
@@ -587,7 +544,6 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 done:
 	mce_threshold_block_init(&b, offset);
 
-out:
 	return offset;
 }
 
@@ -678,6 +634,32 @@ static void amd_apply_cpu_quirks(struct cpuinfo_x86 *c)
 		mce_banks[0].ctl = 0;
 }
 
+/*
+ * Enable the APIC LVT interrupt vectors once per-CPU. This should be done before hardware is
+ * ready to send interrupts.
+ *
+ * Individual error sources are enabled later during per-bank init.
+ */
+static void smca_enable_interrupt_vectors(void)
+{
+	struct mce_amd_cpu_data *data = this_cpu_ptr(&mce_amd_data);
+	u64 mca_intr_cfg, offset;
+
+	if (!mce_flags.smca || !mce_flags.succor)
+		return;
+
+	if (rdmsrq_safe(MSR_CU_DEF_ERR, &mca_intr_cfg))
+		return;
+
+	offset = (mca_intr_cfg & SMCA_THR_LVT_OFF) >> 12;
+	if (!setup_APIC_eilvt(offset, THRESHOLD_APIC_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		data->thr_intr_en = 1;
+
+	offset = (mca_intr_cfg & MASK_DEF_LVTOFF) >> 4;
+	if (!setup_APIC_eilvt(offset, DEFERRED_ERROR_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		data->dfr_intr_en = 1;
+}
+
 /* cpu init entry point, called from mce.c with preempt off */
 void mce_amd_feature_init(struct cpuinfo_x86 *c)
 {
@@ -689,10 +671,16 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 
 	mce_flags.amd_threshold	 = 1;
 
+	smca_enable_interrupt_vectors();
+
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
-		if (mce_flags.smca)
+		if (mce_flags.smca) {
 			smca_configure(bank, cpu);
 
+			if (!this_cpu_ptr(&mce_amd_data)->thr_intr_en)
+				continue;
+		}
+
 		disable_err_thresholding(c, bank);
 
 		for (block = 0; block < NR_BLOCKS; ++block) {
@@ -713,9 +701,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 			offset = prepare_threshold_block(bank, block, address, offset, high);
 		}
 	}
-
-	if (mce_flags.succor)
-		deferred_error_interrupt_enable(c);
 }
 
 void smca_bsp_init(void)

-- 
2.51.0


