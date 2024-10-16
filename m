Return-Path: <linux-edac+bounces-2089-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A57079A018A
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 08:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D4F1C22EF1
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 06:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23D918FDBB;
	Wed, 16 Oct 2024 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N7lqM6hc"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD918E772;
	Wed, 16 Oct 2024 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060861; cv=fail; b=p5q5xI33W3TjCypcTIKIPQrvSTP7J/iqJjdiGuFmtHAqhRSZqFCYMZ3LSOlIN/9vrn3uptNn92nQNBJKdWM2xIL5NhYAseaC6Zj25DHdDeTlBZoR54UJeRtIfXr6bOtv0O2MgglTBHOMhZf9z90xyO0qW0k/wcs2c/XRkt1Yqzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060861; c=relaxed/simple;
	bh=DTfb0uGQayCvWjqEt4i31wuQGtxzu0I08PRjt09FOMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFN/4DQdd79k2HCZCL1OtGnGg7b80Lr/HLUvLQkcU6eDp4z3Nf6bPVs+59ccEfKx4MiTZ8mbLd4R/qArSM39YumiskkfO2pzq/IHCUH63f7CG+rszlfxS4S3AtyjexS21OsYTFGSlxmbLvDcsuYrzCxUTaLF0/yltF/JyJJxefc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N7lqM6hc; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5cbQ4O7s+V9B1E+ZVsnszukNmJSFcENDDp5gnDsp/MtgFhJq0rV8u6F9pOvZziLpMSwtgSllTKE5OnDsvBBSArWmmrgl2si4Y5PElL02JuwLBd1HRxf1Jg/0uxh+MeATEJelccx8PtC4kR/0adHb/V8PB/24dZUGme1bRRzJOF1PQpyWrHcR5jbsD9rD4R8NkOgLWZcBPjcUsoVOh5V/2dfMN9IjGdZiRekqnCQCUOc9W6AHV/vqldr3t6x75UH7DV450CKSB1be+vzAdcAeNXGEzvlTjexswR9VmNwJ4t5c2Dp8bh0kFHv11Wtjss2R/u5LBcTWGE46uH/3zk5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nz1Xoj/I0knZANwUAIsJGVl0XaNhR5UKK2csbKTeHsg=;
 b=Dz0FdF3C2JElo7IZIhcQ2/0/fnqPf2ewvtH+ML1qwbfnigOqCCOO7NWiPm5VSFTDLA7ukg+tYBgOOG/i8UFbuWkxnCGA8az7CVrtaV0UO3bYeq/EdOoDV6aZxmSMllIUvPPXy4t+Ui9ZaA6TdWUXw1gGRlLP3Up62m52FlQ0OaMKMDf8d2vGZ7dYOQqwCYu72jOckdvlfxH/uTFOIs/ZF/qLHaANSkn/WOudC3UdeeUVaxpdy3unKBP8sGi31fOQy8mZ6ijYxZRSl+xpMW5M0Wwjj7mUkkpVMeInBpTHHfUE4C7emuP2WhJlyGOkIssq6nbY+83xafm1V8GT1uKpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nz1Xoj/I0knZANwUAIsJGVl0XaNhR5UKK2csbKTeHsg=;
 b=N7lqM6hcoXjXRnOumrbSzxOxJbKUiRpjtALMFOQpwlNx6Et/LVu61KXf26TB1ujXRYhMgFYcLlInU8Ek4qwv5y2PtpRdaEjqKXbq7Xq4cnsiOc8k2dWOyoMl6AuHG6DM6+/WncHcBGeCYdPVhTixlEdDLLFc3nSovkdkfSV7fFA=
Received: from CH2PR20CA0022.namprd20.prod.outlook.com (2603:10b6:610:58::32)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Wed, 16 Oct
 2024 06:40:56 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::e2) by CH2PR20CA0022.outlook.office365.com
 (2603:10b6:610:58::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 06:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 06:40:56 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 01:40:55 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<qiuxu.zhuo@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadhut.naik@amd.com>
Subject: [PATCH v6 2/5] tracing: Add __print_dynamic_array() helper
Date: Wed, 16 Oct 2024 06:36:28 +0000
Message-ID: <20241016064021.2773618-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016064021.2773618-1-avadhut.naik@amd.com>
References: <20241016064021.2773618-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 4606fadd-36b1-4d01-2a68-08dcedad7d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aP2RTGnzTbGeA6KOFhhpOZlzF4vumJg+5DADq5FeLu4ufOM8Tc72q61uksx0?=
 =?us-ascii?Q?tOhh0JdzIz4dTLQgCNJuP325CGna/Up++wu5sQOVPkZg/bcsCsUTjm++gcxN?=
 =?us-ascii?Q?XpF6wr9/0dBYbjDO3RCzK57PEId9oGzO+P1N1pR7vlshWxM5Wik0doETMnMQ?=
 =?us-ascii?Q?ph3TZrrwNaxrg/HfxtuPnhaGqg1DoZqkPiHTJ4cSvWiSfpahck4AQGyCh2+K?=
 =?us-ascii?Q?VyFBXwW8wm3PsHnlAFLWlS1alUIQsmmjTvpSmvAStoIAmUcxjFtagS0WtSdg?=
 =?us-ascii?Q?HBnMWAB66mJ7eyj890H8y61GSRsWNalIYxx+hNHu3Cess9jhm/BVrTvt+04V?=
 =?us-ascii?Q?uvrrsqVyRDR5mhpB/m5eq5b8TXkGcQSteKjZzIzp2VfNZp28RELFzzlvjf8F?=
 =?us-ascii?Q?BWtQtqb9QryUgar1LDnh0zQgf6f8N9Qul421zp+t9HRbpjV2JHOupwGBF+JU?=
 =?us-ascii?Q?ExpzLxGAW3EdGX/xAuog2GSW/ZtDxG4IsmL77uXCDCoiAKsmZs9XwVAYyW6y?=
 =?us-ascii?Q?vgtX+x5XmdmtjfJfziaJjfXbS+VZYLI8qFXhUl2JzpFw6BO9VVDQ8ceEHP71?=
 =?us-ascii?Q?Se4RH1gbDS6evT0f8q6GLXbIW7i6cIyIPeob5yO/npvfIKg/iaP/1cQfotwF?=
 =?us-ascii?Q?tErwx+F9ETmaDRYZsJBone+5A7xPcD6qdFUz3nxFMj+poi01zsza26iGdYya?=
 =?us-ascii?Q?I2u/SCazAZ72vl6aKggSKdPCHMxMrgS7dmyvTZm4QbX6J0x+jMYUUPpYx33R?=
 =?us-ascii?Q?RkC3W74zmGAVvjiLO9pnTsMFb5c+LwaPiNbKuSyHuETpcQrGhqHnc3EJEEkM?=
 =?us-ascii?Q?OCo1nUrEpFuSuPV9aBJ3PW79MJRQHdwSym/3ezVKeP83yxtEfDy/LElqVgdJ?=
 =?us-ascii?Q?VVNRWSr4uTeR5JMU58b/zr5uwymskyeB6yBAKdzHqVa3vMJKZ3g2z6kgOURU?=
 =?us-ascii?Q?9amuPGaOxHF5qO9yxRckZq9z1fG0wKlTMRJvS2ihOnuMpHZang6Q6oDFxOwT?=
 =?us-ascii?Q?Gf7IsW5PrZsrfUMFCKouh75T6zcddK5qtn8I1QEu6gkKmhoDNKa+IedPVYFL?=
 =?us-ascii?Q?lwOlQGt9aFOEqk/iVa+krnitZ9syMxfYqr/zS40KGp2FudHb7LDfjJJbZhR3?=
 =?us-ascii?Q?OjmBMrvrwGxODd7kKfFuTNdjJbANYZfCIhzo6oYoSCidBXT84p8Cjhdq9BJK?=
 =?us-ascii?Q?yZIC2QV6xcJLuGQB1p5f++Ew5o/4znjhY2MKszMPCbVOxAvUdJl9SGkvvmMT?=
 =?us-ascii?Q?a1w/7fR/LUWGCT03f+cuyDchfUOMgC1V1nugsk8XrdMJIHWgfkdPwyyTU/Cu?=
 =?us-ascii?Q?TICkgTrlaiwNpthLzkSHpFvaEJmW1kn8zMSvLLghBf6EcDXszgf8Pzgw10e0?=
 =?us-ascii?Q?bbX1E5w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:40:56.1602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4606fadd-36b1-4d01-2a68-08dcedad7d05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963

From: Steven Rostedt <rostedt@goodmis.org>

When printing a dynamic array in a trace event, the method is rather ugly.
It has the format of:

  __print_array(__get_dynamic_array(array),
            __get_dynmaic_array_len(array) / el_size, el_size)

Since dynamic arrays are known to the tracing infrastructure, create a
helper macro that does the above for you.

  __print_dynamic_array(array, el_size)

Which would expand to the same output.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
Changes in v5:
Patch introduced in the series.

Changes in v6:
No changes other than rebasing on top of tip/master.
---
 include/trace/stages/stage3_trace_output.h | 8 ++++++++
 include/trace/stages/stage7_class_define.h | 1 +
 samples/trace_events/trace-events-sample.h | 7 ++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index c1fb1355d309..8e3215093e1f 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -119,6 +119,14 @@
 		trace_print_array_seq(p, array, count, el_size);	\
 	})
 
+#undef __print_dynamic_array
+#define __print_dynamic_array(array, el_size)				\
+	({								\
+		__print_array(__get_dynamic_array(array),		\
+			      __get_dynamic_array_len(array) / el_size,	\
+			      el_size);					\
+	})
+
 #undef __print_hex_dump
 #define __print_hex_dump(prefix_str, prefix_type,			\
 			 rowsize, groupsize, buf, len, ascii)		\
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index bcb960d16fc0..fcd564a590f4 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -22,6 +22,7 @@
 #undef __get_rel_cpumask
 #undef __get_rel_sockaddr
 #undef __print_array
+#undef __print_dynamic_array
 #undef __print_hex_dump
 #undef __get_buf
 
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 55f9a3da92d5..999f78d380ae 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -319,7 +319,7 @@ TRACE_EVENT(foo_bar,
 		__assign_cpumask(cpum, cpumask_bits(mask));
 	),
 
-	TP_printk("foo %s %d %s %s %s %s %s (%s) (%s) %s", __entry->foo, __entry->bar,
+	TP_printk("foo %s %d %s %s %s %s %s %s (%s) (%s) %s", __entry->foo, __entry->bar,
 
 /*
  * Notice here the use of some helper functions. This includes:
@@ -363,6 +363,11 @@ TRACE_EVENT(foo_bar,
 		  __print_array(__get_dynamic_array(list),
 				__get_dynamic_array_len(list) / sizeof(int),
 				sizeof(int)),
+
+/*     A shortcut is to use __print_dynamic_array for dynamic arrays */
+
+		  __print_dynamic_array(list, sizeof(int)),
+
 		  __get_str(str), __get_str(lstr),
 		  __get_bitmask(cpus), __get_cpumask(cpum),
 		  __get_str(vstr))
-- 
2.43.0


