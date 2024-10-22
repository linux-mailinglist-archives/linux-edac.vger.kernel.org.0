Return-Path: <linux-edac+bounces-2188-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3086D9AB716
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 21:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8291F24182
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 19:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75FA1CC14A;
	Tue, 22 Oct 2024 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zk6OIsjB"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D4C1CBEBE;
	Tue, 22 Oct 2024 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626160; cv=fail; b=ownPH8c/swUO4Ao8l+ndJYcT+z8gG4RUWLg/KZTIRQfjYtPh2SYHvnRC5QOD4Zzc78vli1uGvSdsjUlgLOfuITE74Rr7KyCsgDG3ASnY8+K+qEFD7iX8J3RdL8NBfCDWIKyBuw3RNtQMxqM5mv0yv3mk379hrtTgyEBAJ0GnEG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626160; c=relaxed/simple;
	bh=+p3FZ9tuqUwudT2pgTVSrmLaB5UvxyZoUapZxDNJQbs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUWFSuRbeKPIMtW2EYxu7fRZ9gqv7NXceCi7zDPQV4BrQ6mrPdipciKbw8pXNHttT6Fl44kNk05uwOPzi9RVWS4eQh/v/IZEZ4LYQjDM3+TYdBdfAf/iZlfLUN264Zl5/xMcKhRKV+OB+w53QoqbWaRQVuKtPonuE4JREQpxPfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zk6OIsjB; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRIzZahdLGXggE8ZiNj1FdEuBxe50kBPuRMZGjDy8VbUSYT+cWTI5XRZ/bGxoEzlBM2zr0szlVkfs5SEIwurnaw75SJX5YxpFTtXTd8ZAPIVXtQFQOqXXxrP+iHxsr3pfYwxB3XSHrX4mCPiF0sHwBprvh4EIjn2tXYEEsGlpCVvmKxDfn8PlNTp4TOZgBQi4n+UugmhZOkS91On+P4hcMRWiZkVkimdmkyViJxgl9LBgcJiAbBoPBprJInoWvYAU23gB+9/0WZPrJQl/FWmHHpHo3JOB0GHYiMC7P7S7nZl+xxpg0WS7LZ4+6PbJjYglT4iVlgKaOx0+i+SQ7uwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pu8AQQlOesqy8qCKYnE5LpKyJKGVwMXwnPedQzvGqYc=;
 b=wh6H4SYiIUxLCx6HSegPzYIchN2jAE6FX8nzFN4Z+Ti9Y0aCvcST1nsJqJNdK20DbjFOziWM35fWWKlUbptTmGO/SWD2ka4Bvy43s/VKo/zPjCy0wIcWC+jXqMhxXWCWNIPLGYCBG0rm9QlhImZH6keo7EUtO2EJjrkBwaCTWJPfilgZr2jA1wzSGp215LIo5X9OUZwNYHxlyf6o4A0iBlPjmM+El4XR1/Gui+MJn5cvDaqfAA2ZJ3auTZUAM4yLIx1XT5K2YTWhKgUyQDZQ6gYaR4/NyLlLVN6hzOUNIbV+F+B5ApuMzwK8fNWcSiH6a4mECeZ4hWQL366hYznB0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pu8AQQlOesqy8qCKYnE5LpKyJKGVwMXwnPedQzvGqYc=;
 b=zk6OIsjBWIgfeGKlczM+SGW2RMhx4QmiSRCRQct0LtPn2nKLr/a//zW7gfPEC9gSPpJzPGBCZ/sGLfNBerKfuvvr+GSc5rVFk4dm1YvCxmC+WkH5S8e+qp3zBrjhsxcWpoax3BIi8njvhOwB3/SmFfYcRv6ZT+u1mA28KvrRM+E=
Received: from BYAPR02CA0006.namprd02.prod.outlook.com (2603:10b6:a02:ee::19)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Tue, 22 Oct
 2024 19:42:34 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a02:ee:cafe::80) by BYAPR02CA0006.outlook.office365.com
 (2603:10b6:a02:ee::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 19:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 19:42:33 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 14:42:32 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<qiuxu.zhuo@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadhut.naik@amd.com>
Subject: [PATCH v7 2/5] tracing: Add __print_dynamic_array() helper
Date: Tue, 22 Oct 2024 19:36:28 +0000
Message-ID: <20241022194158.110073-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022194158.110073-1-avadhut.naik@amd.com>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 507c4a33-8f90-4066-f703-08dcf2d1ac96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WIBdB9AbH28Kso6UwvaLh1UyhkZ8wyALygAa9GNwCQtdG0k858MAW8L/Ac8p?=
 =?us-ascii?Q?cbxeCiI6hWX0AQmBcYUm9+Gp2qWdtG6jskFczyqxiFN1crH9fl9Zj0X+e/HU?=
 =?us-ascii?Q?/XWoY/p0fyv+7UzPmZ6/PWeSjHO9rTZ2O7BkN4gBcualT3GyRQ5sF9+ME9DG?=
 =?us-ascii?Q?dFdZSxdorOWo/L42vFSD1H/tHSH3OtkyrPZYhKgV5f3soKw3OfZz35/JCP+X?=
 =?us-ascii?Q?ypXq7A7nmNgNuSy0Dy5nLee0d2qG2untW8+J5uQFMm6Qox9Jhx0M+GYIYxP/?=
 =?us-ascii?Q?wkneeueZKf2YPlgJ7H7+6inTh3WNFHMWik71u9s1N770yDE/9ygqRQTTVC9a?=
 =?us-ascii?Q?+dVYAoMUfvlKKaPhW5mOzGNnEqv249zwInp+5GEyh1QJeqms0zIm30WIGlYM?=
 =?us-ascii?Q?ziLJsrGAh2+vETPnr2wN5vFPcXgMjTpH4YzUJBfeI82q3belGU4ObzyIWS65?=
 =?us-ascii?Q?0x3vUr1AsPR3gRjfODFRyUrgmCULJTDUq4SIQtcOE3NUZ5m2tjiX18XUkMVJ?=
 =?us-ascii?Q?oALJVKgsKWQXBHPzg5JUcob0rpKOL0FP/g/LYGeDkphaUL+PBMuF/JnTWAkX?=
 =?us-ascii?Q?Gt30vj3E8OoiYqSaKS1sNXwfOWSCv3TIRbD84Ws/ZNeIF04UW7KjyeI7a89K?=
 =?us-ascii?Q?gG3cmZnxCS9qFVqm1vAu2oIyXD1KpOdgB28o81vdiB6otcUEyQG2IqrZuZCR?=
 =?us-ascii?Q?Jroz3Kz1Zn4uCcXs6DrCCD0w6QNOA8qRXHkHBJfN3QcnfD8HYuLXvbOV09Vq?=
 =?us-ascii?Q?ZchNVKBVHzOHI6gIaYlxgBLV3XzJjhtDtUrKhfXpuFnJ1ZTicxbyndd/5sif?=
 =?us-ascii?Q?6Hdry7AUj9jvVTfNcZE50d8b/QGmcXkZlm35amD+N5+h0PR72iaJ8vZv+EHv?=
 =?us-ascii?Q?QYQQdS2fwyBsQd9pSWRd4lT3Lk3BRznSG05UmuK6bSN43/skt0T+4YE0XR98?=
 =?us-ascii?Q?p4m1Zc3Nr+pTcTG4+MeYWSO9yoXcvXuJmeLkR7BhwtgOk4gLZt5XGyz5peAm?=
 =?us-ascii?Q?iqF48z9KOsQL+QCLAfrA5cJzSzdbcdLFIu1sC65diwDT32wjyo9fuUzG/mnW?=
 =?us-ascii?Q?xRWafCoalUA6ET/BRdudWpg+qWcK7oKFP7bybrBvNVIOmRqbARhIjAt6VAj9?=
 =?us-ascii?Q?lFgT7Guv2LPhZljs8Hfju55vfGtNeMJrkTgSoLjkGqQgTnKvbSqIjLkbYA19?=
 =?us-ascii?Q?nJ6QZ7tERQ9plfSJxBliO+NqKWcAuFXUCK90vt85fQwNC+lkxMkDR8xRYG5r?=
 =?us-ascii?Q?n9CFyO9caEuPjOHK63x82L98kbLUfmio2wju4JZ4I+H4xmNseC6KvlrFOMIO?=
 =?us-ascii?Q?ExqLDj5V5s04nU9UOLanux9I/HK8qWYZLfFIsENDsXOe6APIryWjmJ2SR2zw?=
 =?us-ascii?Q?taV3zTDYETQWMRWRPd80j/oz1ZtPwL5gxZffENwmQjFCaHK6Hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 19:42:33.5866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 507c4a33-8f90-4066-f703-08dcf2d1ac96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786

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
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
Changes in v5:
Patch introduced in the series.

Changes in v6:
No changes other than rebasing on top of tip/master.

Changes in v7:
1. Rebase on top of tip/master.
2. Added parenthesis around el_size parameter in macro.
3. Remove Cc (to Avadhut Naik) tag.
4. Add Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com> tag.
---
 include/trace/stages/stage3_trace_output.h | 8 ++++++++
 include/trace/stages/stage7_class_define.h | 1 +
 samples/trace_events/trace-events-sample.h | 7 ++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index c1fb1355d309..1e7b0bef95f5 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -119,6 +119,14 @@
 		trace_print_array_seq(p, array, count, el_size);	\
 	})
 
+#undef __print_dynamic_array
+#define __print_dynamic_array(array, el_size)				\
+	({								\
+		__print_array(__get_dynamic_array(array),		\
+			      __get_dynamic_array_len(array) / (el_size), \
+			      (el_size));				\
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


