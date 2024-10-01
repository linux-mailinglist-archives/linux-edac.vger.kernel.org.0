Return-Path: <linux-edac+bounces-1947-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 990BA98C52B
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2024 20:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44761C20A98
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2024 18:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0B11CCB51;
	Tue,  1 Oct 2024 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F0cno36v"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9DF1CCB3D;
	Tue,  1 Oct 2024 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806612; cv=fail; b=axMB4QlYp4EjoCpPXUG9bhTHqMMo5caTMOZbsVgdN/NCqOw6TDXfdMm1jMGkJ+iV/A2Dp9wet07PHwPGz7BL7cFKsKtMzD2rvq2wIZ9EbeGMgVhkBvTBMNNDPD8tNKAug1DE7TKqsAu1c6rPrGPOt+gvCNWrWkXVsUv+AjwAb+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806612; c=relaxed/simple;
	bh=kL1W1GkI9hMR4EvgYw3PXgNRBd4am3X5QynMz1wOlO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWWDcgUHV4HV4plEThfR0CG/2oCNri41ler/40QxKDr2iL6sOTks2CZ6FDS2SD+wu1wqxRcQotplV+lHUmQ+CZkP7zwI12/Qk2fe5cOjKdeJU70KdZEC+v9f3prgd7azd6WUD1pXG5iItv7hRb/aiuHoiJFkQFQwJOXVGU903Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F0cno36v; arc=fail smtp.client-ip=40.107.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRNlw2w7tgJAugFdJbalqKJ0WSONCtTmr70sLFCMKICOJyijYdli8lHVQS5D51x7jfv2nPwwvSWSo6LCvCkOBp6jqViKuTLwiyTktNv+iMbgg1VQMpsZ5+xODT39850g+8bc+kR9FLhicH68SKVnpPs+oeNN1uktKioLBqjvJqA7gxNuIGkMfoooAboOYc3hLZAwLd99Qppxwg9bJ6vPugT0FdOdepyyYDN1vYovlPE/V2xt1Md06bcmXgUocn7rkmcpir99APaaOQbI8pPTaC8iA1d1BbPYj8gUz6A+EzCAB8jWBHt04MI3kevvGILyTkYV7RmsoxP0qAfLq9LOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hYvGfV+H9sVVIdEOro4jVu4xlYBzOPsZAp0+fokTEk=;
 b=lbnmUS/7EcZAwVYHH+7PaY2qUKXP7btsGJ9M9Eln8MtltJzlG7Z84ddMhtDfRUMu2E+JnhEBraqL6JYtYgHjBsChDj+npNTbZiDGFnDFVyNJgAgxQkQRLy+lYUmfQoMLyBT30VMedUHpaghpdYA/G1ZsyE1PfsEqK2avdRlWA+X4Zc+IXQ8KgdVPnS0Zen3gn6TsA5MEVmVBOzdxz5YIgaU02oEbCXvWkRR89V0Gq+qD2LLaPmRpnYpe0ZtHDFpr9hGOQ78OhhN9r65/wxpvfPg5+KnbDcJNFLHd4eEWVIMuvjsil4HoeEVll5oyxm/Xyj+Sw0n4TEe0sHeNTBbfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hYvGfV+H9sVVIdEOro4jVu4xlYBzOPsZAp0+fokTEk=;
 b=F0cno36vziM7jHrIrbJM/HlaxbPNLJjeT6aczmb7vBSBZqe2oW8zBspj2vpDinL4xn7IVp3WKB8vmAN/WGVk6kAguWqsBT9LyH2h+8RnT1npRnDHCjt0L3AhOnOgRfbHHFe3sf3nGif62SQUj2mb+39Slj4edlrLWIKEoojpwAQ=
Received: from MN2PR07CA0027.namprd07.prod.outlook.com (2603:10b6:208:1a0::37)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 18:16:48 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::e2) by MN2PR07CA0027.outlook.office365.com
 (2603:10b6:208:1a0::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 18:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 18:16:48 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 13:16:46 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v5 2/5] tracing: Add __print_dynamic_array() helper
Date: Tue, 1 Oct 2024 18:12:26 +0000
Message-ID: <20241001181617.604573-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241001181617.604573-1-avadhut.naik@amd.com>
References: <20241001181617.604573-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b0ab2d-db46-4361-7eae-08dce24536de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zUyQXn1jb5kFu1gIuDd8JrSndGREu/ljChJ5e4DHtUp+8B1C4/Q0DqBHv4YG?=
 =?us-ascii?Q?03smNwyjnECMyyYJAmV5AVJRfRc3jJuVWtPjAHXhdRyHqLu6qroi8S7/rnmc?=
 =?us-ascii?Q?Rgu+CI/XRLnfIbVz+T/+/H987Y+BmKpt3gV/Cr4jOfm0qtI2nkQzNO47iEzT?=
 =?us-ascii?Q?OIoyuvTk9nS5asJEOYCM3w6rMylP/cn8oo/DQC7uTI8sLxAZi/4Q2VIfmUc6?=
 =?us-ascii?Q?/mz0Wfqew/Jh3vwrJfxnjYWBkl/2CwXSLHNNFTi0SQWYWZDT9b4oTAQq1AOn?=
 =?us-ascii?Q?wwcWuLmMA0ndz0DXbQt+QUBw17JYiAqkvso/BzOjEsxnkHZn0A6OMyT+j9Ph?=
 =?us-ascii?Q?9qv6pJfcQuWtpNAsFYFFEiQ2J5LQ95sXM3RdPx9BrhxJ4RA4vdDOrtdD0E/I?=
 =?us-ascii?Q?5u4p3zqD/YN7L2JmTPSBlKQkRAucxuJwLiLyC0DOIzLnLjTcVBYG1rEQN+3J?=
 =?us-ascii?Q?1K+L5UJ5EQPpTF1EXCC18T5CujqwXq4sQnE1N4VK8oqj/3wrXJa16MJqpQ0j?=
 =?us-ascii?Q?Lg6AkBG69+nIj+s3tQcfw5taPxx+4de4GgRBUGYzuQey4/DRtQGiHarjOI1H?=
 =?us-ascii?Q?S4Mog9y8bqEu7QmiUPK/NpvrkJFkI/4N0nAD1vHY2bm30jztO87xhrh1V7xK?=
 =?us-ascii?Q?9wfRBm1mR6uh5hb77uWVML5YgJZ79R//Wdn3xUiBnTWQrVwbkyihqfxaPyZ4?=
 =?us-ascii?Q?Cq+tk73OZlshpJCp8OXKV3Z2mIi6g57DMQ71D/kKxCnehAcU1x+Hz3rGtNR2?=
 =?us-ascii?Q?7S/s+sQeQu+1nCbG/WCq78VcoWEvAwKvBdZQiYF0ZFTyxFFKe2s2TlEmZePZ?=
 =?us-ascii?Q?900aG2SGkrg6a86AdcfL8ThWWUW1Yv7V8LbJ0104SD0ylfJjYeROuklzjrdq?=
 =?us-ascii?Q?yNTPBpzg+bUO9GuBWm46WHu9Bu8Y4SFWhqcEUrnJY5OlKEKkkVETrdtn/B/k?=
 =?us-ascii?Q?l0D+TvS3BfE1Bcjg4I5jJ5qh2WxAZopJwHzykFxyz/WgJSrGnF9rZV2boQx9?=
 =?us-ascii?Q?W7MniN9msR7PdwYO5ro3E99MTnpIqxNuMvQ0X1CPhla7PNel0d4YcAOQdX0r?=
 =?us-ascii?Q?tgPORx/qGbzvx1bg23zEZAH3Wol5FQL4Uju7sixLXA6jUWl9LJrcCYdJfRNp?=
 =?us-ascii?Q?XYQ1/VUILBHaqSUZwWJiTqZWInpDsSgGKCL/G4UaVtcQ4853GTQv6Oeszi/w?=
 =?us-ascii?Q?d08ii5vZchK2565geLs2UU0T72l2m8V4/y3qs2IBN80u9RcaD0BPouVU31rA?=
 =?us-ascii?Q?dSd7UkYy3/1720JLevwzvZRBzXXazDuyfTPzsUqQzxUBGlKZJfofn8+I7O/+?=
 =?us-ascii?Q?f9IjzCBtzjtzHvTzElxDRLo7MeQdcSypZz5Yndwx+cFJ/nE6WlhTDIuSfwM7?=
 =?us-ascii?Q?A03K1vw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:16:48.0314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b0ab2d-db46-4361-7eae-08dce24536de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451

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


