Return-Path: <linux-edac+bounces-4405-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4C3B0E132
	for <lists+linux-edac@lfdr.de>; Tue, 22 Jul 2025 18:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542A43B36AC
	for <lists+linux-edac@lfdr.de>; Tue, 22 Jul 2025 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1898E27AC2A;
	Tue, 22 Jul 2025 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o7dGmv1H"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B081277814;
	Tue, 22 Jul 2025 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200242; cv=fail; b=GlTeRSQdHJpmP/LahJJRfYR4QzxhlL76kYkd6QO0dst5ZckZUfmW5KXbb+huHePcCmKLFDsWyE420G1fDP4D+LqGbAUYa6VHoR8xoA+PuGax7vO6GgNVK7VESIA3mN8/PqYFrnN6+d+/XT+I5GXGlpyvdl4vXuatVe5Ck1pN/m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200242; c=relaxed/simple;
	bh=z4Tdef7pf+dgQ/f5I1TgAVt02zTbWxrZNO1xSK71zGs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPdyIPqBtZ4sGNvZniBUyoawq11FEHqRLdaVeFHN6KbIUOLLzEh2csaCBXNZhehiuIJQgISMW2Hyq2LgDMQZ0C0CrnlsQWc2i9OVciLrg4Zn5HA+scsKi4xuVRslD7Kz93+RjcNSR/ItU5c6hTHfZkrNgreFYPMRCWZM5Ihq9eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o7dGmv1H; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQNZ5n1Zb/hgntKfaBYHN4MkcI6p0RCzqU+9hk2btJvooDwwJYuYBGRIfCP0Th/9OPFtG68QQHOgTLzmjOPGkcPMzcYDYYdaeRJTQvrBp2ByNhQ1JTu0YEY7KVlmFBlgql2RioSWunM1ybTcgBuwMLe/tnuw2T0UpvLUGvYDtCSoxj5qdUfKypebSRml+vK49bSe5cKoHNTzVOd4kCW4bclp8Mc7PGR9cgTeUySSvM3L3bcTIk3TFBk1uBLXvShGeZNq+vISb4JpRMeKT1Uy3vdw+YXu0ShPswK7nAfJ71us+NNcIBk1Oe3k6bJ97qFkF+p9VSBxSjCnKz7Kqa7boQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+BJCG91KZg6DXzPRWa52JJKziME8nPIt88cmQe8EI8=;
 b=wZeMLO7ClPFeS3cb1eqgyPuGbT6aX5J3TDxX+qLt2di9E19NpYA47ZBhH2qEgqCdFJMbG9aj9lbXRFaPqBv4N4hQ4O5WFBHC5mO3TSI1mi5AKIJU/Jg1jibwpYiFQU0xDJE0IltDQrSxWiaPJq1V40UgY0/prUppjIjwoZl22fVZFwajVFoC/QoWrobL3Od+DXmZ9UWOFGzB+gIHv2QI9K/I+W5vpXV8fy6AWeDv/iqUESh1sMaDT3R0GBLizk+XtO4k6CcegIsfqLaLNv3f16NOMV1UJ9WPleHlJw+NPZx8wAd62c03XkR3EHAq0xEaI+gd3isFXfpertDVLPO9EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+BJCG91KZg6DXzPRWa52JJKziME8nPIt88cmQe8EI8=;
 b=o7dGmv1HqT/o+jwFksemr/qFgDVWUpc+otJFPsj9coTWoRdIWEVgcjt8g5Ou4KfA7DoQuMXwmc/Fon6TPWBgqdCh8a0KmC+ZdUu/tjzeyj4vIy/eNRQnFgoPYDsqetkufDkv6Tapadgi/M+XNhxcWfG/2ALTbftxPQSs96TR35E=
Received: from SJ0PR05CA0210.namprd05.prod.outlook.com (2603:10b6:a03:330::35)
 by CH1PPFDA9B3771F.namprd12.prod.outlook.com (2603:10b6:61f:fc00::626) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 16:03:57 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::bc) by SJ0PR05CA0210.outlook.office365.com
 (2603:10b6:a03:330::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.17 via Frontend Transport; Tue,
 22 Jul 2025 16:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 16:03:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 11:03:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 11:03:49 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 11:03:46 -0500
From: Rama devi Veggalam <rama.devi.veggalam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <james.morse@arm.com>, <mchehab@kernel.org>,
	<rric@kernel.org>, <git@amd.com>, Rama devi Veggalam
	<rama.devi.veggalam@amd.com>
Subject: [PATCH v2 2/4] Documentation: ABI: Add ABI doc for xilsem edac sysfs
Date: Tue, 22 Jul 2025 21:33:13 +0530
Message-ID: <20250722160315.2979294-3-rama.devi.veggalam@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20250722160315.2979294-1-rama.devi.veggalam@amd.com>
References: <20250722160315.2979294-1-rama.devi.veggalam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CH1PPFDA9B3771F:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb71abc-5801-4918-9dd5-08ddc9395cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6aD6pbPG6VVVw63q9eTrP7P9TsEA9xSkyiUd4jUN/t0si6imQq2e1ThQFJfR?=
 =?us-ascii?Q?wXrE1U6kRs6dBJKEzhospWKojXvyJr8RQx051eGcqlAb/GU8xraMWUldhQLe?=
 =?us-ascii?Q?/9yE2FG2bHvQOUnOFD1AkJsTvHg+stowVikhWVkr/ruLnFfRrKDu/npPbd3U?=
 =?us-ascii?Q?QsCrNZ7fnF1Pstzws6ZgfkRpwRQv1qjYuZFAgxGuB7OfklI51Ger5PS0ljCa?=
 =?us-ascii?Q?4m6ys3uBqmG5xVnsCxBC3EJY9rb6bxKzdxt9NSdYpITf48+5FGNU+5X54q3b?=
 =?us-ascii?Q?Bb1hjMQEJYZe350PQzh4o4tMLrww/eCrjMGHFIjDL9g0gXHE8BNC2rLy86hf?=
 =?us-ascii?Q?hnBmfDyEIToBjGVqfIzhe3EEmbfKxdwphOhvcMne2aVW4tlvT2cF80KqGNtx?=
 =?us-ascii?Q?4OTumHDHX1E/OciZX8B1PzpTkTAkx3VILeCZx1kap0KEcQJXCSVNw8M4i/I7?=
 =?us-ascii?Q?2W3gyhMtrfueOX0F9wIA9h5dbmq6fwbMBXdPeHw3yPMKxn8AuFBHRXBjX9yu?=
 =?us-ascii?Q?Xn0uWJdAxZr34bvwEjfd6+e3jf07x4rSO4/rPOFwCeiP9F41EtEMwKFqbfIO?=
 =?us-ascii?Q?KinGFQn/p/giQul8NctN6oyFydWXQw2jOPluNXGCuOsB06LaffmmuCbbQLvI?=
 =?us-ascii?Q?q3CTgpVAw2t2fTFhGXwCT2XRQe+wyfuf2h7CTFVX79DUPylw0u+1qkJvoIqa?=
 =?us-ascii?Q?GaR6aqa844QimeW+lHM78UQiGNIEj3+f1Mq5DDOgLzmWcrnfN6qND/swabdr?=
 =?us-ascii?Q?FYlB/a268LJDG5zbFnkqLcHKT/3hZxDkprnXQkKxZG+1bk5azjhpDDBJnbrb?=
 =?us-ascii?Q?2sSFk3oADntvCqYgZehxhcByM+3I3pY3y280VlkWAtTow/e0xv8/qc+2I78Z?=
 =?us-ascii?Q?ulYQIAIBUP0TdD4cCVTuA3ZvXOYPIn6KkXsIKhBpgFzsN6TxQITfMXD3iyQr?=
 =?us-ascii?Q?++S5NYAKtWITCKpR6NpW2zAmNOsre4BjUNlsd7nQrqwWW9aI5vznX/pfDomL?=
 =?us-ascii?Q?sTtN9RATJ3hcG+jYYRaiKIiOmZpqyCtJLhsIHrFte1BOHtwYIPthUQ8ZGsn7?=
 =?us-ascii?Q?j84tlck1SstSBaMTfxIsl+JjWb7JjgnAcJ2W10XPmSb0uF2YhrLGuYK2LFxJ?=
 =?us-ascii?Q?j7ZVrb2gSHw3PlJ+mrGe2q5zIpX8TULDetrHXXJE5ZZnGA0O3w2QkT37PWjF?=
 =?us-ascii?Q?irAYTgWKrDSPSlbycLY5k7HXvjrJBF8Gi4KWnybt9ALTVLL8EiGZKA8g7muP?=
 =?us-ascii?Q?TJN3Vpzka3UUMPrb3JXt8N6EchmjyeE4x7RXorQN16qONOVsrG3icRcPGJHw?=
 =?us-ascii?Q?kiVLJskGQ82tvDUpekKSoruuk2L/ZL7CJGRwlcl2uLIKbcU5wqhbGe5Dltxi?=
 =?us-ascii?Q?E028B5uRqeEDdrZDXEc8TbiAF47+1aLM6s1coaYKGmfBEr3RVrwhQHD8H/0a?=
 =?us-ascii?Q?WQZoLEIEq/jZM1tqYF8svEaPhZCAWOg6o9raGL3cUngxOUcxWExgaYe4JMNm?=
 =?us-ascii?Q?4AFv3vMRXHHb6xpkxFq+t5PBvKnY1e01C1p9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 16:03:56.2587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb71abc-5801-4918-9dd5-08ddc9395cc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA9B3771F

Add documentation for the sysfs entries created for
versal xilsem edac.

Signed-off-by: Rama devi Veggalam <rama.devi.veggalam@amd.com>
---
Changes in v2:
- Updated Date field in sysfs file
---
 .../ABI/testing/sysfs-driver-xilsem-edac      | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilsem-edac

diff --git a/Documentation/ABI/testing/sysfs-driver-xilsem-edac b/Documentation/ABI/testing/sysfs-driver-xilsem-edac
new file mode 100644
index 000000000000..80180a7b16fb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-xilsem-edac
@@ -0,0 +1,104 @@
+What:		/sys/devices/system/edac/versal_xilsem/xsem_scan_control
+Date:		July 2025
+Contact:	rama.devi.veggalam@amd.com
+Description:
+		It is a read/write file.
+		Writing to this file causes the software to initiate a
+		request to the firmware for doing requested scan operation in
+		Configuration RAM (CRAM) or NPI of Versal devices. User needs
+		to provide scan operation id (init, start, stop) details.
+		The scan operation id values are as given below:
+		1 - Initialize the scan
+		2 - Start CRAM scan
+		3 - Stop CRAM scan
+		5 - Start NPI scan
+		6 - Stop NPI scan
+		7 - Inject NPI error in first descriptor
+
+		When read, it shows the current scan status with error code.
+		The format is <0x1030 | operation Id> <error code>.
+		The different error codes are as given below:
+		==========	=====
+		Error Code	Cause
+		==========	=====
+		0x0			Scan operation success
+		0x1			Failure in NPI scan
+		0x80		Calibration timeout
+		0x2000		Internal error
+		0x500000	CRAM initialization not yet done
+		0x600000	Start scan failed
+		0x700000	Stop scan failed
+		0xF00000	Active CRC/UE error
+		0x1000000	ECC/CRC error detected during calibration
+		==========	=====
+
+What:		/sys/devices/system/edac/versal_xilsem/xsem_cram_injecterr
+Date:		July 2025
+Contact:	rama.devi.veggalam@amd.com
+Description:
+		It is a read/write file.
+		Writing to this file causes the software to initiate a
+		request to the firmware for doing error injection in
+		Configuration RAM (CRAM) of Versal devices. User needs
+		to provide the location details of CRAM
+		(frame, qword, bit number, row number) to inject the error.
+		When read, it shows the current error injection status. The
+		format is <header> <error code>.
+		Example: 0x10304 0
+		The different error codes are as given below:
+		==========	=====
+		Error Code	Cause
+		==========	=====
+		0x0			Error injection success
+		0x2000		Internal NULL pointer error
+		0x500000	CRAM initialization not yet done
+		0x800000	Invalid row
+		0x900000	Invalid qword
+		0xA00000	Invalid bit
+		0xB00000	Invalid frame address
+		0xC00000	Unexpected bits flipped
+		0xD00000	Masked bit
+		0xE00000	Invalid block type
+		0xF00000	Active CRC/UE error in CRAM
+		==========	=====
+
+What:		/sys/devices/system/edac/versal_xilsem/xsem_cram_framecc_read
+Date:		July 2025
+Contact:	rama.devi.veggalam@amd.com
+Description:
+		It is a read/write file.
+		Writing to this file causes the software to initiate a
+		request to the firmware for reading frame ECC values in
+		Configuration RAM (CRAM) of Versal devices. User needs
+		to provide the location details of CRAM
+		(frame, row number) to read the ECC values.
+		When read, it shows the ECC values for the requested frame.
+		The format is <status> <header> <ECC_0> <ECC_1>
+		Example: 0 0x1030A 0x363B1A 0x8A0200
+
+What:		/sys/devices/system/edac/versal_xilsem/xsem_read_config
+Date:		July 2025
+Contact:	rama.devi.veggalam@amd.com
+Description:
+		It is a read/write file.
+		Writing to this file causes the software to initiate a
+		request to the firmware for reading Xilsem configuration.
+		When read, it shows the CRAM and NPI scan configuration.
+		The format is <status> <header> <CRAM config> <NPI config>
+		Example: 0 0x1030A 0x26 0x5016
+
+What:		/sys/devices/system/edac/versal_xilsem/xsem_read_status
+Date:		July 2025
+Contact:	rama.devi.veggalam@amd.com
+Description:
+		It is a read/write file.
+		Writing to this file causes the software to initiate a
+		request read the Xilsem status. User needs to provide
+		the module id for status. The module id values are as given below:
+		1 - CRAM scan
+		2 - NPI scan
+		When read, it shows the status of the requested module.
+		For CRAM: <status> <CE count>
+		Example: 0x10005 0
+		For NPI: <status> <scan count> <heartbeat count>
+		Example: 0xA01 0x10 0x1
-- 
2.23.0


