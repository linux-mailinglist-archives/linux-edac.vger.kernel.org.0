Return-Path: <linux-edac+bounces-4033-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B8EAC7952
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 09:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0731C06D3F
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 07:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6E72566E7;
	Thu, 29 May 2025 07:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GaXwFQV8"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5107483;
	Thu, 29 May 2025 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748502037; cv=fail; b=X5QNtGfCue5CfpoGlCRACBUSO1IkwrlWxigeCTV0dydLd3rShYP6AquJCuOrC775JiUmJDP3Or++132RlFZi4W+cnvXT/Kwq+pXnvloeu+jMb4nRot0ZdqRikKt8k2YyCguqQ9XXITLzE6EcnMS5oeuzY/Y9pU1YlAxMUj7wZpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748502037; c=relaxed/simple;
	bh=nVIF0CkYdk6JoFtwf0LQRby53RRu6IiYOUlFtdwtCok=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dic+4iksZ2II+ZR9wWJEaDYZU6w8zdX28fDHBtl1DmjEnNO3xCoookH8OV63xD7NwMiUPOjgA73Jgt4BAL56JxtZ/IMA9pH9UhVIYweKhTLv5oTPzWvav74TSjTZMH3nxa/eBY/wnBYRAk89AsAx/uAUrEW7TR0mkSqXzA1OgH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GaXwFQV8; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mb35FEMgzZCgZOFOtFi6l2EAf6pVVn34eXcx/78saRIAs9FqtItm6/yFDeVsWUuIf+2NaWEVpHrKMfEuphfk4PFvDQDiF+uJUpRvtulhux8kVdcMQE7aPgcmgEzNgaccKfjzPWMs1GmIX5hYlyd8UN0PGHVHl6UxFGktjV4NDtipt4wbWfU90OR9KlQQMifhDSap0eANiIRwU6ZTjrkq9FsavnmmIqx/HiRuaGWRdP2QJmGnOuXMPW5XBilIWQxymDTnjlVh+0DeGNPuJBqnvi9NDuU5lsPs8kqgWHwleKmKXdD69xs+we3J03d+uRsdeI3tVG/aF0ymhoQZb09PKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF+G9NSA0M+wvl4dnCjETwaxnGba04x8xmd7S2zuG18=;
 b=nJSa+sxfBl37IQpymPW5W1LPwnk3OmFoMIHliFDYx9UvocPYpbN5QOb8KlMXqzQFxR64IrS6vSvUGyg8jr4ilaWVsTykMxWf/ga5biznZS7JNom3zlqYqDRP31GDDwaxiOZHlP9y5kYC2FMAQBQ+aRP4CYtRUzVRhzz2zskUhM4FsIBfMBFIgFiULRRkM0vagiO8X2et/noFbd2VTc6rL/nJPfmQt0nB4nHA5c0nCusqJ+MU1A5wAUtNIwXHhuQ10LrBPD2+G7Bl9X+9FMfWUYd10iKxgmaq7qnzVo80gpxuQTPLNr6u61Q5Kv09XFRVet6O6rGJ05bYrzBtOIjR5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF+G9NSA0M+wvl4dnCjETwaxnGba04x8xmd7S2zuG18=;
 b=GaXwFQV82JMCi2G9OpLWU1+v3n6NKTJZ5vsGOvEwiwUUPlrLE+v2BKePLPdkuTD1yPo3JT1Vftou/DlofAq/cLrcFEctX82tOItP7F8+Ne/bNN1uNGxGLYZjqwjpoDgCpbkLjEZt3hQpRZx1GKwKfAHkfILuuF9ZjQmQWRSwqf8=
Received: from MN2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:208:134::14)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 29 May
 2025 07:00:28 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:134:cafe::15) by MN2PR16CA0001.outlook.office365.com
 (2603:10b6:208:134::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Thu,
 29 May 2025 07:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8813.0 via Frontend Transport; Thu, 29 May 2025 07:00:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 02:00:26 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 29 May 2025 02:00:22 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Borislav Petkov
	<bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
	<nikhil.agarwal@amd.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH v7 1/5] cdx: add the headers to include/linux
Date: Thu, 29 May 2025 12:30:13 +0530
Message-ID: <20250529070017.7288-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529070017.7288-1-shubhrajyoti.datta@amd.com>
References: <20250529070017.7288-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: f3dc4ea7-6e0c-43c5-c7f5-08dd9e7e7e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?em09IyzFRdkwTer/sqAQnLEPfNH8oqHJFoML+EHwjR5AvYDFl4kblIc5w8Bg?=
 =?us-ascii?Q?yHJcMPTlHycHukz3OZsmUH0zHZ2uvPAobBOUKWzA1VpQVmPeL1CVLQC5hfhS?=
 =?us-ascii?Q?kkEBT6aixQQU18yQ4099HbtNZ5wazuRo97yKm+ODrq78UrDrIInp8TpCcZJ2?=
 =?us-ascii?Q?pr/pJGBugWKbifYOK7muzKuycP+p/cLQ1LT+f0b0xB1R/RwXN8IYrLxA/cVx?=
 =?us-ascii?Q?5Z7E2/GA/WjzLB+IejAzV0eEfp6C+9Oz2vyeMMgTKu54sMP+ehjxTwJ+xyyH?=
 =?us-ascii?Q?M3MtEU8uJRH8KfoGBWRNoR0NW4xqAadxKdIaZM3987DK/lxwiyfSTh1v+dZZ?=
 =?us-ascii?Q?TD977LU1aZd7eqYTlJ/ThARVpzA0P8S5StOzkGi0hdjLGqSS/qIvro65C0wp?=
 =?us-ascii?Q?4sSOb6uX6e1O8XUi1BDXzDfDhe8XsU2W2O5z1U3lllsil9jHv1z4Lz6BlTVh?=
 =?us-ascii?Q?zF+YkhZJu38E6gRsFo7Z+TeYcuLUEybE/FmzmmNuZELYQVNH1HkfK6e/xgDK?=
 =?us-ascii?Q?4lMwYmPglH1a5+Id6G2sYB34vKIeBhUc6DSPhVN+Ox/QEGfMqpaYBGmonp/1?=
 =?us-ascii?Q?GZxfo/Rsim9F5T6EOfcEDhc44hpCgFxI4bxXIOafD98BDdhNns95wa3Mt+6c?=
 =?us-ascii?Q?jLQuzLmbUYbMue6v4lsbaFxxAb8Fdts5oH4+iFTaFE1MfXpRt24Bdw4IChJa?=
 =?us-ascii?Q?Y/mQxe5Txdpkm3TTSV+3nFC5Tq6MqG+aGLqTDz4E0Osh6v2tZSZZigFobD3o?=
 =?us-ascii?Q?I2oHm362gVwZbK1gNxAiu9xalR7Ci0h7xe1QYizvcWvArWq8ldzCMQikmGcx?=
 =?us-ascii?Q?7k2ygsOQ2a4mZoWjVFOvzc3U5UmD54dpIT4ZzQLl1HiaB7FtdvC+PfrWG7I3?=
 =?us-ascii?Q?/DmmPPCDKGAR4GcNPs2Bc1gYYh+GeGjGLYFUGqa4RbzaTLhiqMaqUtywHzIS?=
 =?us-ascii?Q?vdFlbfdlrSxvuri092ooL2/ygNBzSeYT0TSq/MAjDVZsJKeVnHtebVY1exil?=
 =?us-ascii?Q?41mUAHSK5PujUxZnB9Wx6HFubdrKx3ECwt3sjML/Ndw/Zu5pXA28irgbswXd?=
 =?us-ascii?Q?JVJtboPw5KojTsqnhWbzpviDHxicz7AHUesw1bQfgVtGHkgu4Dv7o9S7eLNh?=
 =?us-ascii?Q?pQrer4Nhobn2Du54XS3JbianAz+CwfuD5tY/aB5+PMagRslURxEMfU6YphbW?=
 =?us-ascii?Q?2gEGfa4zZHg2PG/wrXmgGAJk+/FLYNu57PFZpsmctPTeZpJRL8/5x34c4OZZ?=
 =?us-ascii?Q?4+ou0dy+YBxDHSWx6fG7/88mo/kqfKqwruMF0lUTmfdIyg4+zAD7TPG4mnrB?=
 =?us-ascii?Q?yAkEA5AXHzpHin4n4jSpdO2LmZmyrRlU68Jg8yrgtJrAjr4Tt7GJn0rB4wUx?=
 =?us-ascii?Q?AbNW9spo9ggt3TI8F9/Q6SpjqKDkQo69BpRjionvcmWkUSN5l2rEQwrdMKys?=
 =?us-ascii?Q?iX7y6R7NIU8tcytVvcMY2/9GXvxQFJn61kWk3xTjd2goESM3VtvpVD+Q6FKJ?=
 =?us-ascii?Q?0/CB6VslRwPgcuStznGyHqVIMzViNaM9HFQB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 07:00:27.8409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3dc4ea7-6e0c-43c5-c7f5-08dd9e7e7e51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111

Add a the bitfield.h and mcdi.h headers.
This is in preparation for VersalNET EDAC
driver that relies on it.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v7:
- add a minimal header instead moving them

Changes in v6:
 - Patch added

 include/linux/cdx/bitfield.h |  78 ++++++++++++++
 include/linux/cdx/mcdi.h     | 192 +++++++++++++++++++++++++++++++++++
 2 files changed, 270 insertions(+)
 create mode 100644 include/linux/cdx/bitfield.h
 create mode 100644 include/linux/cdx/mcdi.h

diff --git a/include/linux/cdx/bitfield.h b/include/linux/cdx/bitfield.h
new file mode 100644
index 000000000000..3f0bf2dbb2c7
--- /dev/null
+++ b/include/linux/cdx/bitfield.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2005-2006 Fen Systems Ltd.
+ * Copyright 2006-2013 Solarflare Communications Inc.
+ * Copyright (C) 2022-2025, Advanced Micro Devices, Inc.
+ */
+
+#ifndef CDX_BITFIELD_H
+#define CDX_BITFIELD_H
+
+#include <linux/bitfield.h>
+
+/* Lowest bit numbers and widths */
+#define CDX_DWORD_LBN 0
+#define CDX_DWORD_WIDTH 32
+
+/* Specified attribute (e.g. LBN) of the specified field */
+#define CDX_VAL(field, attribute) field ## _ ## attribute
+/* Low bit number of the specified field */
+#define CDX_LOW_BIT(field) CDX_VAL(field, LBN)
+/* Bit width of the specified field */
+#define CDX_WIDTH(field) CDX_VAL(field, WIDTH)
+/* High bit number of the specified field */
+#define CDX_HIGH_BIT(field) (CDX_LOW_BIT(field) + CDX_WIDTH(field) - 1)
+
+/* A doubleword (i.e. 4 byte) datatype - little-endian in HW */
+struct cdx_dword {
+	__le32 cdx_u32;
+};
+
+/*
+ * Creates the portion of the named bit field that lies within the
+ * range [min,max).
+ */
+#define CDX_INSERT_FIELD(field, value)				\
+	(FIELD_PREP(GENMASK(CDX_HIGH_BIT(field),		\
+			    CDX_LOW_BIT(field)), value))
+
+/*
+ * Creates the portion of the named bit fields that lie within the
+ * range [min,max).
+ */
+#define CDX_INSERT_FIELDS(field1, value1,		\
+			  field2, value2,		\
+			  field3, value3,		\
+			  field4, value4,		\
+			  field5, value5,		\
+			  field6, value6,		\
+			  field7, value7)		\
+	(CDX_INSERT_FIELD(field1, (value1)) |		\
+	 CDX_INSERT_FIELD(field2, (value2)) |		\
+	 CDX_INSERT_FIELD(field3, (value3)) |		\
+	 CDX_INSERT_FIELD(field4, (value4)) |		\
+	 CDX_INSERT_FIELD(field5, (value5)) |		\
+	 CDX_INSERT_FIELD(field6, (value6)) |		\
+	 CDX_INSERT_FIELD(field7, (value7)))
+
+#define CDX_POPULATE_DWORD(dword, ...)					\
+	(dword).cdx_u32 = cpu_to_le32(CDX_INSERT_FIELDS(__VA_ARGS__))
+
+/* Populate a dword field with various numbers of arguments */
+#define CDX_POPULATE_DWORD_7 CDX_POPULATE_DWORD
+#define CDX_POPULATE_DWORD_6(dword, ...) \
+	CDX_POPULATE_DWORD_7(dword, CDX_DWORD, 0, __VA_ARGS__)
+#define CDX_POPULATE_DWORD_5(dword, ...) \
+	CDX_POPULATE_DWORD_6(dword, CDX_DWORD, 0, __VA_ARGS__)
+#define CDX_POPULATE_DWORD_4(dword, ...) \
+	CDX_POPULATE_DWORD_5(dword, CDX_DWORD, 0, __VA_ARGS__)
+#define CDX_POPULATE_DWORD_3(dword, ...) \
+	CDX_POPULATE_DWORD_4(dword, CDX_DWORD, 0, __VA_ARGS__)
+#define CDX_POPULATE_DWORD_2(dword, ...) \
+	CDX_POPULATE_DWORD_3(dword, CDX_DWORD, 0, __VA_ARGS__)
+#define CDX_POPULATE_DWORD_1(dword, ...) \
+	CDX_POPULATE_DWORD_2(dword, CDX_DWORD, 0, __VA_ARGS__)
+#define CDX_SET_DWORD(dword) \
+	CDX_POPULATE_DWORD_1(dword, CDX_DWORD, 0xffffffff)
+
+#endif /* CDX_BITFIELD_H */
diff --git a/include/linux/cdx/mcdi.h b/include/linux/cdx/mcdi.h
new file mode 100644
index 000000000000..46e3f63b062a
--- /dev/null
+++ b/include/linux/cdx/mcdi.h
@@ -0,0 +1,192 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2008-2013 Solarflare Communications Inc.
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#ifndef CDX_MCDI_H
+#define CDX_MCDI_H
+
+#include <linux/mutex.h>
+#include <linux/kref.h>
+#include <linux/rpmsg.h>
+
+#include "linux/cdx/bitfield.h"
+
+/**
+ * enum cdx_mcdi_mode - MCDI transaction mode
+ * @MCDI_MODE_EVENTS: wait for an mcdi response callback.
+ * @MCDI_MODE_FAIL: we think MCDI is dead, so fail-fast all calls
+ */
+enum cdx_mcdi_mode {
+	MCDI_MODE_EVENTS,
+	MCDI_MODE_FAIL,
+};
+
+#define MCDI_RPC_TIMEOUT	(10 * HZ)
+#define MCDI_RPC_LONG_TIMEOU	(60 * HZ)
+#define MCDI_RPC_POST_RST_TIME	(10 * HZ)
+
+/**
+ * enum cdx_mcdi_cmd_state - State for an individual MCDI command
+ * @MCDI_STATE_QUEUED: Command not started and is waiting to run.
+ * @MCDI_STATE_RETRY: Command was submitted and MC rejected with no resources,
+ *	as MC have too many outstanding commands. Command will be retried once
+ *	another command returns.
+ * @MCDI_STATE_RUNNING: Command was accepted and is running.
+ * @MCDI_STATE_RUNNING_CANCELLED: Command is running but the issuer cancelled
+ *	the command.
+ * @MCDI_STATE_FINISHED: Processing of this command has completed.
+ */
+
+enum cdx_mcdi_cmd_state {
+	MCDI_STATE_QUEUED,
+	MCDI_STATE_RETRY,
+	MCDI_STATE_RUNNING,
+	MCDI_STATE_RUNNING_CANCELLED,
+	MCDI_STATE_FINISHED,
+};
+
+/**
+ * struct cdx_mcdi - CDX MCDI Firmware interface, to interact
+ *	with CDX controller.
+ * @mcdi: MCDI interface
+ * @mcdi_ops: MCDI operations
+ * @r5_rproc : R5 Remoteproc device handle
+ * @rpdev: RPMsg device
+ * @ept: RPMsg endpoint
+ * @work: Post probe work
+ */
+struct cdx_mcdi {
+	/* MCDI interface */
+	struct cdx_mcdi_data *mcdi;
+	const struct cdx_mcdi_ops *mcdi_ops;
+
+	struct rproc *r5_rproc;
+	struct rpmsg_device *rpdev;
+	struct rpmsg_endpoint *ept;
+	struct work_struct work;
+};
+
+struct cdx_mcdi_ops {
+	void (*mcdi_request)(struct cdx_mcdi *cdx,
+			     const struct cdx_dword *hdr, size_t hdr_len,
+			     const struct cdx_dword *sdu, size_t sdu_len);
+	unsigned int (*mcdi_rpc_timeout)(struct cdx_mcdi *cdx, unsigned int cmd);
+};
+
+typedef void cdx_mcdi_async_completer(struct cdx_mcdi *cdx,
+				      unsigned long cookie, int rc,
+				      struct cdx_dword *outbuf,
+				      size_t outlen_actual);
+
+/**
+ * struct cdx_mcdi_cmd - An outstanding MCDI command
+ * @ref: Reference count. There will be one reference if the command is
+ *	in the mcdi_iface cmd_list, another if it's on a cleanup list,
+ *	and a third if it's queued in the work queue.
+ * @list: The data for this entry in mcdi->cmd_list
+ * @cleanup_list: The data for this entry in a cleanup list
+ * @work: The work item for this command, queued in mcdi->workqueue
+ * @mcdi: The mcdi_iface for this command
+ * @state: The state of this command
+ * @inlen: inbuf length
+ * @inbuf: Input buffer
+ * @quiet: Whether to silence errors
+ * @reboot_seen: Whether a reboot has been seen during this command,
+ *	to prevent duplicates
+ * @seq: Sequence number
+ * @started: Jiffies this command was started at
+ * @cookie: Context for completion function
+ * @completer: Completion function
+ * @handle: Command handle
+ * @cmd: Command number
+ * @rc: Return code
+ * @outlen: Length of output buffer
+ * @outbuf: Output buffer
+ */
+struct cdx_mcdi_cmd {
+	struct kref ref;
+	struct list_head list;
+	struct list_head cleanup_list;
+	struct work_struct work;
+	struct cdx_mcdi_iface *mcdi;
+	enum cdx_mcdi_cmd_state state;
+	size_t inlen;
+	const struct cdx_dword *inbuf;
+	bool quiet;
+	bool reboot_seen;
+	u8 seq;
+	unsigned long started;
+	unsigned long cookie;
+	cdx_mcdi_async_completer *completer;
+	unsigned int handle;
+	unsigned int cmd;
+	int rc;
+	size_t outlen;
+	struct cdx_dword *outbuf;
+	/* followed by inbuf data if necessary */
+};
+
+/**
+ * struct cdx_mcdi_iface - MCDI protocol context
+ * @cdx: The associated NIC
+ * @iface_lock: Serialise access to this structure
+ * @outstanding_cleanups: Count of cleanups
+ * @cmd_list: List of outstanding and running commands
+ * @workqueue: Workqueue used for delayed processing
+ * @cmd_complete_wq: Waitqueue for command completion
+ * @db_held_by: Command the MC doorbell is in use by
+ * @seq_held_by: Command each sequence number is in use by
+ * @prev_handle: The last used command handle
+ * @mode: Poll for mcdi completion, or wait for an mcdi_event
+ * @prev_seq: The last used sequence number
+ * @new_epoch: Indicates start of day or start of MC reboot recovery
+ */
+struct cdx_mcdi_iface {
+	struct cdx_mcdi *cdx;
+	/* Serialise access */
+	struct mutex iface_lock;
+	unsigned int outstanding_cleanups;
+	struct list_head cmd_list;
+	struct workqueue_struct *workqueue;
+	wait_queue_head_t cmd_complete_wq;
+	struct cdx_mcdi_cmd *db_held_by;
+	struct cdx_mcdi_cmd *seq_held_by[16];
+	unsigned int prev_handle;
+	enum cdx_mcdi_mode mode;
+	u8 prev_seq;
+	bool new_epoch;
+};
+
+/**
+ * struct cdx_mcdi_data - extra state for NICs that implement MCDI
+ * @iface: Interface/protocol state
+ * @fn_flags: Flags for this function, as returned by %MC_CMD_DRV_ATTACH.
+ */
+struct cdx_mcdi_data {
+	struct cdx_mcdi_iface iface;
+	u32 fn_flags;
+};
+
+/*
+ * We expect that 16- and 32-bit fields in MCDI requests and responses
+ * are appropriately aligned, but 64-bit fields are only
+ * 32-bit-aligned.
+ */
+#define MCDI_DECLARE_BUF(_name, _len) struct cdx_dword _name[DIV_ROUND_UP(_len, 4)] = {{0}}
+#define _MCDI_PTR(_buf, _offset)					\
+	((u8 *)(_buf) + (_offset))
+#define MCDI_PTR(_buf, _field)						\
+	_MCDI_PTR(_buf, MC_CMD_ ## _field ## _OFST)
+#define _MCDI_CHECK_ALIGN(_ofst, _align)				\
+	((void)BUILD_BUG_ON_ZERO((_ofst) & ((_align) - 1)),		\
+	 (_ofst))
+#define _MCDI_DWORD(_buf, _field)					\
+	((_buf) + (_MCDI_CHECK_ALIGN(MC_CMD_ ## _field ## _OFST, 4) >> 2))
+
+#define MCDI_SET_DWORD(_buf, _field, _value)				\
+	CDX_POPULATE_DWORD_1(*_MCDI_DWORD(_buf, _field), CDX_DWORD, _value)
+#define MCDI_DWORD(_buf, _field)					\
+	CDX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), CDX_DWORD)
+#endif /* CDX_MCDI_H */
-- 
2.34.1


