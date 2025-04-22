Return-Path: <linux-edac+bounces-3648-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 300ABA97292
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 18:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C94442CA4
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDEC28936D;
	Tue, 22 Apr 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="31IW4/J0"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B837F2957AF
	for <linux-edac@vger.kernel.org>; Tue, 22 Apr 2025 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339045; cv=fail; b=Xr6iXBJNUFrSMLFDR51exyRWsTA+X2PA88r5hiCjx/3K0aoBtrP8lNuQpBGWruZ6iUKeImk/RcumaVJL5MTWkvV+UGgpn2PQ960MiQ6IuqB/OT/pdjNXE29H3Xg2C+kLFnqEWZm60RgYV0F+285i8Xc9LRkhCU+uXmbwOKtAQwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339045; c=relaxed/simple;
	bh=NiTkSQdYVBzeEi6W1Ir3qzNgNz0BAdb2Vl/fvdavZVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEy44zHNKCB+LtYjyS8TbGd88iy3vNiDmVlMnIy7KofX/N8HMRj5Cj1gwyrfWpEf8S4PR+ohH+Paf+3dBcVloKfAEyuFq6SRdps/cc0CZkqmFzHDxGqpLq8OlXHFM9HEmk/jPZ+mf5ilhhRikxZQf49Ma3GJeJ4eCf9r6a9xheQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=31IW4/J0; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTSxIttgVkPYWujbk4JTyT8HAIdRWUgiUfi4SX5rtdBDnSXElyQRXNjkR74QjPoea0997SpTc82YoqEYyipo0EUcHYTLPxfo6evBlLISx3TxjwNLya5o0B2+y1JpkTK1JAPkAWANIaSuQDEpiRlAC6ZK3p4CboixPC7qHM8rvFxk8w3eV1QnKn2wMlsbYWnTyg38HwaN4YhkNQc2sVYAv7grfd6eqpgwx+qhkS4rl21ypddAkOGjmhjwZfUofL96R147eT+Fv9PWJJI5PyOffVL7CtNKin9jtTg8Fh1XA6Z7MbA3N+Lj+3mmu3RvlrIKZeKnbpY3k/LqsW+uVK12ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqhVINs3E8nWHbydgVGtci/OC5aJ0IR88OHgsQ8TLbU=;
 b=e8FLTkIJdXYLxwJ43s0sZt+LLUW2ZIQn96l7/bzDH3sto/JoxHHuUNK+C0BizqWkf8prmv2tSwCwx6ZXnB6htt+Bywgd+1QikkbACaH08KAhVxf1Nu4iQcRT76BecQrd66CmCmcyamJOXKGHnJIrBh/3GkA4WoaO/xjhOJJnHEePG8+SUvCQJz5e56J8t1ADjItPd0QZFsIjPmPotgYGX7t4FSDlphmjvB+V3aPHKbL6ITgq10h95h7XWFObvXaLrc6hZZcmYAgBCSYrRnwkRdsf5AVCV/79/6VWtM0ekrBNnv7OcJtKA1ru+DLoDj5XUrT47woYxrc2p4Fww67+fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqhVINs3E8nWHbydgVGtci/OC5aJ0IR88OHgsQ8TLbU=;
 b=31IW4/J0R2emClJWy7qG3/qkofFewx1KPIHUt9rZjOjF9cOpOCyQIkNP/308jOZYMNnf/JzcKj2F2ZgaB4oT8uk2JM6SEU+AiJI6LoZpbNMZmAJS3diBEpxrrfGaX8M5o4OoKaX/lyBBMEhJZryXMelkJU/VK4Mui1VjrwZqE+c=
Received: from MN2PR01CA0060.prod.exchangelabs.com (2603:10b6:208:23f::29) by
 PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.23; Tue, 22 Apr 2025 16:24:00 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::6c) by MN2PR01CA0060.outlook.office365.com
 (2603:10b6:208:23f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 16:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 16:23:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 11:23:55 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Apr 2025 11:23:54 -0500
From: Rama devi Veggalam <rama.devi.veggalam@amd.com>
To: <linux-edac@vger.kernel.org>, <git-dev@amd.com>, <michal.simek@amd.com>
CC: <radhey.shyam.pandey@amd.com>, Rama devi Veggalam
	<rama.devi.veggalam@amd.com>
Subject: [PATCH 2/6] Documentation: ABI: Add ABI doc for xilsem edac sysfs
Date: Tue, 22 Apr 2025 21:53:43 +0530
Message-ID: <20250422162347.3217007-3-rama.devi.veggalam@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20250422162347.3217007-1-rama.devi.veggalam@amd.com>
References: <20250422162347.3217007-1-rama.devi.veggalam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: rama.devi.veggalam@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ef54a6-3984-4292-8387-08dd81ba1624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iH5rob042uYrxKeNu3R0S+SC45Idr4D2Y90neEBeVsLShnjXOa+Cq5smPDqR?=
 =?us-ascii?Q?OdPX5qA3qNeL9jC+PZTSs1zeRUwtdImJYWbpg9piMi3dvq5AFeV2y/0l2F4D?=
 =?us-ascii?Q?m0C0WGbr/Blgs3PlwA3eAcc0od6rYyPT9c8hMgvmh9vL395672GX9DfCSAWF?=
 =?us-ascii?Q?UL57pK9JnmHq8VQmVnKInJPkf7OZo2zuzR7FGiXbU9CX4qtnRvK8rFaA5+gE?=
 =?us-ascii?Q?V8Ulxcg1lviaWrlozAGu70+gQKn7wW571Z+2HyA52WvwJEIk+moONHk1FQhg?=
 =?us-ascii?Q?FzYLxGLm0gJfWkTSvzwmLPavqkLAk35P/BCx4GxhekH+uSvrdI/gUgp+4OE4?=
 =?us-ascii?Q?8jxg+3S2OseT880/+4ik6DxmoOBqEJSfParg7NM1f5rQGjKirE44ODVU1U0w?=
 =?us-ascii?Q?m6F++rZGAyblpiFtow/JiYce7i1wxRORKMo7ZerUjqpfiyf5v2+H4vW3HupD?=
 =?us-ascii?Q?XlurgRvN+NKrY8EAj1nOYCnr+SQisqcHG9aG6du4fDQRQIZpbqrKMoejZsTz?=
 =?us-ascii?Q?oDHlg3setSL0sa1Qvr6PP/swU+xpCo6DU7vDmtmQaNCt9ZcFwt7OKTWHlwEE?=
 =?us-ascii?Q?ixjJou31kb5bv7+bSL2PyXph5SkqNgFrZ/aep9nD0d+ARqn9RvItUdIrlyKm?=
 =?us-ascii?Q?zIWDjdyEsc22qdqj2QjBlUOjaNMSw4xMp+5hxbwzCws25kIIGRjEg0f641fY?=
 =?us-ascii?Q?SFEovrJwG0PCCT3Yq7UhHjQsmnANTgvfvpP45QErHoC0PmTZha7Y58BvWTWV?=
 =?us-ascii?Q?G/356rEp8dQrvxo48d6JONG3WAcefxO06UQo9ZKsCnWl38Q1a9ZDBdt09uVi?=
 =?us-ascii?Q?F7Y5NuYWLSb/M/0sHdZNmBiRPMk6t+AhpBl8p1fTRbH6ttQUIv5Y1igxOfWu?=
 =?us-ascii?Q?XETCyxAMkjjBqOEzG8uEUcQYjknTzauaHC30gGS9dai/KaeE+jQYlECjtB67?=
 =?us-ascii?Q?i0++pHZk/CkFs7VY76Fqbhs4vC9Mr5/atTfCeGW5uoU8vtyKg5eL4mZAM4lg?=
 =?us-ascii?Q?rWYKKV4ehzKf2BGSxiu9zhtm+6Juu0c5xwdSIs60/S9PPQss9gVxGBlzALP0?=
 =?us-ascii?Q?9q05X3Dx4zRBoAGIjS/VhFbrG9P/IfxkJUP9iBURfhDu/mR3nBWv9TngemgD?=
 =?us-ascii?Q?GsY3zRT3tZXyN3L7pOqsvJmR+FdTjOAr7xtglZHHseXpRs7o2EEcidDP3Kcg?=
 =?us-ascii?Q?SAnF5fpHyFjmJcjfri5eQPueAd/0QY4r0rRnv/zJdLj4kuY8KypHJUNp/oXo?=
 =?us-ascii?Q?6/sgCnPoIRDmvGrQ9OFDf4//o3BKRfD9H2GbXT4q3ZhB4PIzswzAFd6xRt7Q?=
 =?us-ascii?Q?y/k4WceYhmYH2w03d39ytmjKoaBo0GuhIhhF0zPBjin7LJeIRQ3K+pC1P53B?=
 =?us-ascii?Q?miR0HL0nHPdpWfyiG0Xvowv1oJ/9woeGG5GGhlO8AXaDsWeFXDQAysc8ZUmC?=
 =?us-ascii?Q?ezPlocFs6GvoZmbGQQAl7ZC/9xG3wudgTbNt0GSvad4IEIJUjd68XQZKdzTk?=
 =?us-ascii?Q?/2KAMpPHzIk059R1vi09WE22Jdf8+YFUPWRw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 16:23:59.1401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ef54a6-3984-4292-8387-08dd81ba1624
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863

Add documentation for the sysfs entries created for
versal xilsem edac.

Signed-off-by: Rama devi Veggalam <rama.devi.veggalam@amd.com>
---
 .../ABI/testing/sysfs-driver-xilsem-edac      | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilsem-edac

diff --git a/Documentation/ABI/testing/sysfs-driver-xilsem-edac b/Documentation/ABI/testing/sysfs-driver-xilsem-edac
new file mode 100644
index 000000000000..de11e0b433b4
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-xilsem-edac
@@ -0,0 +1,104 @@
+What:		/sys/devices/system/edac/versal_xilsem/xsem_scan_control
+Date:		Jan, 2023
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
+Date:		Jan, 2023
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
+Date:		Jan, 2023
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
+Date:		Jan, 2023
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
+Date:		Jan, 2023
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


