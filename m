Return-Path: <linux-edac+bounces-5442-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1550C5F380
	for <lists+linux-edac@lfdr.de>; Fri, 14 Nov 2025 21:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E75A3B9132
	for <lists+linux-edac@lfdr.de>; Fri, 14 Nov 2025 20:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600992DAFBB;
	Fri, 14 Nov 2025 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="saNzL9Re"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08BD2D47FE;
	Fri, 14 Nov 2025 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151656; cv=fail; b=ae1mORnQ5QTMXa6moEXknO9xcvxgwnkU1IX5kAVgVgbHAE+r36t05fCbNYd7rdpqPTK2Ms/sLYWlvRD6ZoaxfmkeWCaMOE0ottg/NlWQ70PQLwSPi2kBZSdKpbZrzLboCrJqqIrboJTFf6ZfhA2qYhiwQAQEB5SK9FFdMt4yOZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151656; c=relaxed/simple;
	bh=tc0vPFlo579oD05rR0bKlLSYYPNV9a1P1s3MZngx6d4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNuOaf364MjbfjnFVytf7vG+VPz6seVmymMULMPPywdloXJv8uuARpTC+ggUPYtj3/IrG2CSBTtK+Ro/3gfQHEwG5U5Bgcisv2xCnGNqXMNJlL8WtPlC8kxYfEM0oICCBHvRi2ty0o+Yeq1NhnYgMR9V6ywBAIBP9dRlx0z45tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=saNzL9Re; arc=fail smtp.client-ip=52.101.52.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8xjrGuKJP+uj7MZnQp29UoIR4tiwlrVFFCgw5gFdlCvN7MtrZSht0mQtMBxy/Yzy+aVQQO3yLUFc75hsNoCiypBH5HUq3zDO5aZdBZ+Ic88HmBRWPx9Kucune5V7AocFiOTtSQRQDdDOGDq3wO9JwGEoXD+yXYTmUejIKmbH+Sz5ehaN2hq3S/c/sVWTwxWuBXk7yvrsdO6yDw+sV7sc3V/gFk6UwYmrGPIPnpBTfFv7JhP/+l6kKoQbfXXlelUscS6OgYfefqRqGLQPi0Mxwu4uneP78OraOydjdCo65HHwz9usWKGPMb1rk6QrL6ci4hYBK2qE1Uap7Toefk4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCYfFJFin+HyQgMzwI/HGTbyqezrKUj4eMhT42xUOso=;
 b=WasIlY7dOdzR5FEhCssgHGkPrSh4gLDs4nAYP2qxcqDEmZvrAZ4x/Sy9mYfrHKVyPVy702CgQTXMAtFLymvEPG7xRQ/zFCnTzzHlHWYbnUiKJ+XWofHBDSLB1HoH+Mz05wBaFHEpGEkwXth8I40hro/mUvjnEYhxzj7mL8EnIQ/Qd9+55w80GpHZmHDEcelgOzaSbkaiudRfi9cmrmGyTzixfdOBsn3dfrMscP53T/DL3vkFgrw5Nu3HDfRXkua4z+QetKDVBYvYnl9D8nkOQ3cBqoIIc/gLyNvL9wNxXRyqIfEaGwSU6pxRtr7uxgQRG24wTkQM+tpkra6YKvW5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCYfFJFin+HyQgMzwI/HGTbyqezrKUj4eMhT42xUOso=;
 b=saNzL9ReYX3Fp1jVsKcrOhemBo1TS9Y7FBbrET/4l/9eylFm6O4uvU4nfJi0twPLB6MO1kfuUAS5IYoLEbx7TnmSOC4/X/P/U2G/KWrwSRIt8E2ZWL7Q9BIkxyXBHjWRX65jqx5zvjk41ERTLTaGls3sMzLrv9geo3eme2DODuc=
Received: from CH2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:610:50::36)
 by CY5PR12MB6178.namprd12.prod.outlook.com (2603:10b6:930:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 20:20:50 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::14) by CH2PR16CA0026.outlook.office365.com
 (2603:10b6:610:50::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 20:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 20:20:49 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 14 Nov 2025 12:20:48 -0800
From: Avadhut Naik <avadhut.naik@amd.com>
To: <bp@alien8.de>
CC: <x86@kernel.org>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH] x86/mce: Add support for PHYSADDRV and PHYSADDRVALIDSUPPORTED bits
Date: Fri, 14 Nov 2025 20:20:20 +0000
Message-ID: <20251114202042.2899644-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113165256.GEaRYM6KyP299yO2Pi@fat_crate.local>
References: <20251113165256.GEaRYM6KyP299yO2Pi@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c4ef99-0936-4386-8a38-08de23bb4d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LZlvejUEIg3B4Lcy9ciY5mVN4y+aDGPX0/wqdN3KKLGB6Yx5NCZPycPhLIDh?=
 =?us-ascii?Q?j54LTUltHacwpjciRRlsWMPdRM+fIomCpYBeX/8RZH19YY68U1ZlNP/uVUxC?=
 =?us-ascii?Q?1TTe707JZKiAnxvoBVDL99sIY5jaKxIv6lQ1aXux7KLRtyAEnvmZ0caFgRVF?=
 =?us-ascii?Q?boUysvtmLDLPtd+uUeMIzMlvxxZPuzhw1bXJWpDaUzKEHD0sfD9uYXlnnbVf?=
 =?us-ascii?Q?97uj0yFa6IsgXbGqUU0U0EXldU5Lzf2uSeKDKGYmF8Yf/Bnerj9+q8VGxc0N?=
 =?us-ascii?Q?cLFF8cyKSNG0iFG7vNPPg6qeSRGI05lcB+cv/xyxmNCcHyHzbpofBIi6IWcA?=
 =?us-ascii?Q?H2nC+7AkDIjhbr2NKt8FbRpHe+AQv/zwar0SJM6Nv8zP1bvOrK8SiOADry9Q?=
 =?us-ascii?Q?e6jqHde1apBcaxLoRDjGZWaGemPIuzcCjstJCEGXB1d7/F/DJ/44n9R3t3s6?=
 =?us-ascii?Q?gOqw7MHmk05IJFal9qIPqFshW7VynaJEilIT/H+CER+7wnIBvR2nVtSnL9Bg?=
 =?us-ascii?Q?0s+ay2o2Zhwte9qfBDT1rmQz0oREcN/1xoLDKeF2ARJV1SSBMkr2JLuJDaYI?=
 =?us-ascii?Q?cFJJXRlR2q+mWOS5xvReJCPz7EV2/LXzJeJNTosow8ol1/dlJK0qTMisnACf?=
 =?us-ascii?Q?2BnWwABdGfApjD1lF1UhhqybjJoAVeIg536YItoSiy7GzYRZpzzViJJBKXs4?=
 =?us-ascii?Q?AHwS3vLYXinURDbsHaMQTbLLHd27VUflcO3IY3n8E4XqxxdSCM/Ti5nSpks/?=
 =?us-ascii?Q?RfE6sT+GVjh396oDiOgjpOF3ohGJGOYWLLt/N8yr0fw2Mp3bxl/aHYoRh1wi?=
 =?us-ascii?Q?MbOa29W/ZlnOEMYUyEZ4UmO8IrxvYLjL1Le0wU4NN0SnaU/QUDPxPZwk8n+g?=
 =?us-ascii?Q?uZ1XYy32zYlbT0VS6UWg//e8qTiC/asNtTkB1QpmcdIqqCGyiJ8gTp0kX5IP?=
 =?us-ascii?Q?vNsIKYkP35DMPrx8ubzNJiVphnFbmfa5qWKS63B192OtLm7toE2KgX41zV4I?=
 =?us-ascii?Q?YS1xuz6GH1y1qyXjjpnCVWqrPKz2FqSlt7kdwYfxq5mhAq1wxLl/A4afntCS?=
 =?us-ascii?Q?UQErO8I1XRxTw14f1Iwr+MG+2/0PJ9E24SOvzKUdWEHNz3wRxcmsDHXQPO1N?=
 =?us-ascii?Q?5RzaAFu0M6BKQEmTpXwOCLeibGy49rzP/Fr3qimdRdUOcAPrAzDKZ3KCyYT9?=
 =?us-ascii?Q?K2X6QqrXKsACmBuLj9SQI+aZ1ahGO1tCCdjuHExCIT9aS9SX3g6HcLaq54gO?=
 =?us-ascii?Q?PcRsASIpSPZirT/dDtsm6ml4S+k6XiTwH/6hGnOniZqXrn29NdGuD8DTGJM4?=
 =?us-ascii?Q?eTbhzc19J4fNbABS2ApQSEVlQYb13Nd3B7efYt4haFkfFjtl5zjKZDtM7F/U?=
 =?us-ascii?Q?tk0fY8hjOH6jmvJ4nLkbIgdolLnhcQu5GvNnwOTJ0MVCFFBeIs18rWn7+9uD?=
 =?us-ascii?Q?Deu606CjZLXdYsPt/IwaCYD2/OD3zH4MtNbLT0IyJqDJ7NMXAVSb8p6mPkTm?=
 =?us-ascii?Q?aHo3MMjtNh3iQLapb5BB23Im2uGAv7ztZ5jzfd4VAeg3tD1l3jHP8heAA1OP?=
 =?us-ascii?Q?mEdlEzajmnIUHrysHuY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 20:20:49.3613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c4ef99-0936-4386-8a38-08de23bb4d35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178

Do you mean something like this?
---
 arch/x86/include/asm/mce.h    |  2 ++
 arch/x86/kernel/cpu/mce/amd.c | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 1cfbfff0be3f..2d98886de09a 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -48,6 +48,7 @@
 
 /* AMD-specific bits */
 #define MCI_STATUS_TCC		BIT_ULL(55)  /* Task context corrupt */
+#define MCI_STATUS_PADDRV	BIT_ULL(54)  /* Valid System Physical Address */
 #define MCI_STATUS_SYNDV	BIT_ULL(53)  /* synd reg. valid */
 #define MCI_STATUS_DEFERRED	BIT_ULL(44)  /* uncorrected error, deferred exception */
 #define MCI_STATUS_POISON	BIT_ULL(43)  /* access poisonous data */
@@ -62,6 +63,7 @@
  */
 #define MCI_CONFIG_MCAX		0x1
 #define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
+#define MCI_CONFIG_PADDRV	BIT_ULL(11)
 #define MCI_IPID_MCATYPE	0xFFFF0000
 #define MCI_IPID_HWID		0xFFF
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 53385e6aa230..c6be2f520476 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -87,6 +87,7 @@ struct smca_bank {
 	const struct smca_hwid *hwid;
 	u32 id;			/* Value of MCA_IPID[InstanceId]. */
 	u8 sysfs_id;		/* Value used for sysfs name. */
+	bool paddrv_support;	/* Physical Address Valid bit in MCA_CONFIG */
 };
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct smca_bank[MAX_NR_BANKS], smca_banks);
@@ -327,6 +328,9 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
 
+		if (low & MCI_CONFIG_PADDRV)
+			this_cpu_ptr(smca_banks)[bank].paddrv_support = true;
+
 		wrmsr(smca_config, low, high);
 	}
 
@@ -790,9 +794,9 @@ bool amd_mce_is_memory_error(struct mce *m)
 }
 
 /*
- * AMD systems do not have an explicit indicator that the value in MCA_ADDR is
- * a system physical address. Therefore, individual cases need to be detected.
- * Future cases and checks will be added as needed.
+ * Some AMD systems have an explicit indicator that the value in MCA_ADDR is a
+ * system physical address. Individual cases though, need to be detected for
+ * other systems. Future cases will be added as needed.
  *
  * 1) General case
  *	a) Assume address is not usable.
@@ -806,6 +810,8 @@ bool amd_mce_is_memory_error(struct mce *m)
  *	a) Reported in legacy bank 4 with extended error code (XEC) 8.
  *	b) MCA_STATUS[43] is *not* defined as poison in legacy bank 4. Therefore,
  *	   this bit should not be checked.
+ * 4) MCI_STATUS_PADDRVAL is set
+ *	a) Will provide a valid system physical address.
  *
  * NOTE: SMCA UMC memory errors fall into case #1.
  */
@@ -819,6 +825,9 @@ bool amd_mce_usable_address(struct mce *m)
 			return false;
 	}
 
+	if (this_cpu_ptr(smca_banks)[m->bank].paddrv_support)
+		return m->status & MCI_STATUS_PADDRV;
+
 	/* Check poison bit for all other bank types. */
 	if (m->status & MCI_STATUS_POISON)
 		return true;

base-commit: 438be5bb46f4be6e78cef7c3400f20d77f03c734
-- 
2.43.0


