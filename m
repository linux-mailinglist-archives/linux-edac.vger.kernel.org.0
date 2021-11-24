Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC51045CAA1
	for <lists+linux-edac@lfdr.de>; Wed, 24 Nov 2021 18:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349581AbhKXRK7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 24 Nov 2021 12:10:59 -0500
Received: from mail-bn8nam11on2138.outbound.protection.outlook.com ([40.107.236.138]:19424
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243736AbhKXRKx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 24 Nov 2021 12:10:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nq50gnd2po+tQXFWzq3ochY1LmCgjynmeZRjIn+is97XP8ts1UFktAAL9E79CRkLo2CEnTeiKZ0OAfOdLA+417yHywZbkKyhfWkhtnJB3Bt8h1DUBlidJPnCaeDAM0/tC+7adtY9QhOJEriBFy9XbZd1a/RV7eq4MD+uWs5rsC73urzsOd74E9ct7ZzrJHorABbmNy51pLQftxJb2EPB6DlbdjiEape+DZGGraZ2IiFeJok2hdmC1Gw5+tVaY3qZJF6J+miVQJyc9E4PVO+2Gffjj+eiDqYnaIpaa+PKahEC96Z07+ie1i3zQJCtQ3uCJJpQ0NZnKay4hoTgsnESxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YCVELxkKYYFXEFdWfYu2TIPOub5t6l3xA3DgPdBk6Q=;
 b=aIPoShhbA1HabeCzwIsC9jiXJfWDjhMkkkvJrQJuvCbZsI57cWDQxq/LVgYvEDs+POmIc30REPclFeEFLgoETrHomUwqEnEradyRABAM6tvUaGPKpKNACTLnMIkVv6JHRXc23dayvrMtZqsXRbm8kyaKJn89cQ7bazdwY18SZNC3qxAHGcMo6GjO1o1NBUfYHGbLktbXO1q+3KlbVLRJJQkMef0ngHb24ZLZ+tFl57JsuGSB1mRzn/Apb0ffGUZ2OXhyZkSlyPlj0uBcfK19nadAivQbKiOtnk1MMkUX9suVNvUCzRIB733ZgjRsS1YtNCeLcdz6tbnuL6chSmpiwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YCVELxkKYYFXEFdWfYu2TIPOub5t6l3xA3DgPdBk6Q=;
 b=Jfz7G5Jz0fsoYihisaKa+z5LnhXIi+c1IS4mkeVFueRwhkzAf5aDXZl9TYyu0MckGF1JXcUm8ouV9qmZzm2310H8kB9EROGPGB7m0p8xmdda8ZEp17vrbr6W1P9EOdDk++5U1kGmhye3FzV4jt0WNQgP7TRUYk/F6PToSSKchNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB7033.prod.exchangelabs.com (2603:10b6:610:107::16) by
 CH2PR01MB5654.prod.exchangelabs.com (2603:10b6:610:2f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22; Wed, 24 Nov 2021 17:07:41 +0000
Received: from CH0PR01MB7033.prod.exchangelabs.com
 ([fe80::1dc1:27e5:9fb6:f13d]) by CH0PR01MB7033.prod.exchangelabs.com
 ([fe80::1dc1:27e5:9fb6:f13d%9]) with mapi id 15.20.4734.022; Wed, 24 Nov 2021
 17:07:41 +0000
From:   Tyler Baicar <baicar@os.amperecomputing.com>
To:     patches@amperecomputing.com, abdulhamid@os.amperecomputing.com,
        darren@os.amperecomputing.com, catalin.marinas@arm.com,
        will@kernel.org, maz@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mark.rutland@arm.com,
        anshuman.khandual@arm.com, vincenzo.frascino@arm.com,
        tabba@google.com, marcan@marcan.st, keescook@chromium.org,
        jthierry@redhat.com, masahiroy@kernel.org, samitolvanen@google.com,
        john.garry@huawei.com, daniel.lezcano@linaro.org,
        gor@linux.ibm.com, zhangshaokun@hisilicon.com,
        tmricht@linux.ibm.com, dchinner@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, ishii.shuuichir@fujitsu.com,
        Vineeth.Pillai@microsoft.com
Cc:     Tyler Baicar <baicar@os.amperecomputing.com>
Subject: [PATCH 2/2] trace, ras: add ARM RAS extension trace event
Date:   Wed, 24 Nov 2021 12:07:08 -0500
Message-Id: <20211124170708.3874-3-baicar@os.amperecomputing.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211124170708.3874-1-baicar@os.amperecomputing.com>
References: <20211124170708.3874-1-baicar@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:610:38::36) To CH0PR01MB7033.prod.exchangelabs.com
 (2603:10b6:610:107::16)
MIME-Version: 1.0
Received: from sut04sys-r242-0330002bj0sa.scc-lab.amperecomputing.com (4.28.12.214) by CH2PR05CA0059.namprd05.prod.outlook.com (2603:10b6:610:38::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.6 via Frontend Transport; Wed, 24 Nov 2021 17:07:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b534dea-95d7-47db-fbdb-08d9af6cecc0
X-MS-TrafficTypeDiagnostic: CH2PR01MB5654:
X-Microsoft-Antispam-PRVS: <CH2PR01MB5654FA3FAA3CC50F0476C1DEE3619@CH2PR01MB5654.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHI0uLFSQ84aJLH6YELxyIrsWCfZ5iffWbWJZowSgVPeCGq0sJg49n7UqoXT2wFxFpMe+B9a5NOBUJx0P9i4sAZvZ3HX1iRdnEQDtuiIUCA9F1y3Ohc+PuISh9vVSH1Y/E/eGtWeg0TE7ZW9tpax/QeXul9fiiuQetgEsDDzM5yDOLyfIa+nKmcY4iLgytjr6HXfP/0aCeWlB4yR39NP2NfvkT5WzYiGGG/kUJD4JqkrkIf/CplMeylYNxmDjiefcxhpUmgBxT64XYVHtJ+G2kUg4Pnlrd7X3NccDziM6/SC3z0GQr5oSTJRibgwFSMUrJEFQfRaZX9DSMwEERxJeUwcPWIcIFQzRue3zISYDlGsd+FyghPLXoY+3cH3EnmDSsFj/rwr2x2wj/FnHDOysCkm/OrPTmZeT74UEDzafdQsIFuNN/LzNNzypV+h15dZOa9fhr9DiaRYZn0F8PIAoLjK1+9julT+PKJFX6ANIKxjwAgymu46bTMlww1fCLgKFqxOdSNzq42T4NiBXe1sxlHEdzm9W5mm5ACKjnS5VnhPqN1k95ObHlcK9PbuF9ZLfrhyR6qTaGD19aJtFAVDSIgp4Jz9pwtblxI9NktMpMsvfbRTQsNz9wGnq/IVHn01NCDg3xMMxWCmxkjORR5dJqsuPlxbsRQDjiL2ndocJnzM7Y0HEUkfV2TYzCOVOFoImDCX/vtPoEw1kuZmwJTgG233YUnjqrOPlJUE3xx7EnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7033.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(186003)(38100700002)(1076003)(38350700002)(5660300002)(316002)(66476007)(83380400001)(66556008)(921005)(52116002)(4326008)(7406005)(508600001)(86362001)(66946007)(26005)(6486002)(6666004)(956004)(7416002)(2906002)(107886003)(2616005)(6512007)(6506007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PBDN04zL2AMGX2PtCwjO0W0xqqBcnICjMJsiP2G3XDzCA/93YQmFmrNCGaxI?=
 =?us-ascii?Q?U6jVt/mujP0YPHIN34aeOUou9tm0vGH4W16FSB/I5ABG2f+cjOMj98nIJAbD?=
 =?us-ascii?Q?9gSaPeLNLnT1m7qPXVlhylOyMAoHQckMGCmLg5i+MhW0h9h2eSwP9HcwxpOi?=
 =?us-ascii?Q?kQYCkqavq1vAguhTjF8p4Xu05n3JkdGiRIzO0elT86yfyC1VRRQI1zzzd5qW?=
 =?us-ascii?Q?OX3+WMVAg6J6g1FQCzTRcdWRjLkDSwvlxlHTRPQxEOSW2k/qHl6fv3HCfpo6?=
 =?us-ascii?Q?xNfXRVuKStuShZyTYJLG0sGQxLNrJvG447Cy9tNWlPjsxUJO0yZkzvzf9EVV?=
 =?us-ascii?Q?KYIigZGybksZTFHkibi9mBXfKTOEnJP/xMX/YILv5RkP84PC7d/iUy3+omur?=
 =?us-ascii?Q?4+Gq6Q1hjltN5wCo446+NAnI3B6kZNyHzSSDy85mCmhuNSsY3ALl2ihvGA0C?=
 =?us-ascii?Q?pbbqXFPI6xjcOOUZLhSargKHUmyEZ6TV1JPYHU/V/mOUkGXkgpTYrI2PVlQs?=
 =?us-ascii?Q?ytgM6fkYKC7muT2k8mfjk79wyifF/+XR8LBowaPdgm+fUi3MyIfCO2t2X5Nx?=
 =?us-ascii?Q?N4ScsLTujhqxt17JdS5TuKgX4ZHAWFsClb6+rnf81AIJzX//Yy+JN16kKkaA?=
 =?us-ascii?Q?4AHgPGbzDu61yczjvC1GDbxskPjhO3jFTjxC9WRrA18xP+WptOYgJj/UkwvA?=
 =?us-ascii?Q?/wR8zkjMO2vXqOSYZfETqcE1DDT9n0lMzFhgizjlcKEP/sfOxD8FvhH8APv+?=
 =?us-ascii?Q?QUaD4uLb2vnyNv6M4tp6cWmpKBJR6DvZdCOGTM1T0ozHyvRz9KNnwyuDu1qn?=
 =?us-ascii?Q?tgjYRws08bkYMZqblf2Lu99AiOqydil16ovUkLd9N3S1Q1fSJhu9nT73KVyc?=
 =?us-ascii?Q?J1Z3VUYYNCE729P/2Jqxt1+YnccZ3yPQ6OAQrgl5UY7k3gL1zIEJlAhtyORV?=
 =?us-ascii?Q?V611n3YVjHZH19R5PECjbdwMoofGYIf4P1Rx7GR7EVgsefL/49dMf4EGrL3C?=
 =?us-ascii?Q?DAX7kVjfyJ6si0QzZW1VXT6Nl5yGFhE/z/zSOFkwXB/Zbb/xzGEvcqe3JB3U?=
 =?us-ascii?Q?UYAEiEcVEjpssX2dovQb54H9AgVfMjrX4U72ESaC9+8A4WVi4qC0Uqf3Le8l?=
 =?us-ascii?Q?PNsIvLfvL/wtZ+wnbSVGNzVOkG88J4fH1oDmf5eYaRMfwYfmcltE9hh2KEhq?=
 =?us-ascii?Q?/fYnCoQSSUpncRJdWJThOZP8cXmFPDvEI8avJEfXCh/hbCJ+4EoyUo5ijatg?=
 =?us-ascii?Q?uSImtIcd4dgiTk0jRcugskHPoq+/kn0J/Knq1Q4LLGpNUyd4arEeFd00Xu1O?=
 =?us-ascii?Q?VGLEhJ58wbtc3URBRV04n67GCNJLsokW7egmjWQXCs7NWzc2A0ypN6uJQiSl?=
 =?us-ascii?Q?sO/tdUNY50ymHmthghQleksKg4+rY/Wcx+AGcNHrO6i5fA6RxeG/cCOmsWg6?=
 =?us-ascii?Q?B/xjkZlvLwYhhNozyMvZ2o6Ri7EicvrjzN4MIpqwYzDsT6jMUhlCVoN3RzlS?=
 =?us-ascii?Q?WD4lDhdM3OdHE30KwyWoUdWoQfpVOwIYfvrNUltOnbZ5mmxGr6BrxmrZieOm?=
 =?us-ascii?Q?YGveRWIaNmJv1F3z3Enq8K6MZiktaomtUcJFe34e3xwxq0i936CnIo7kMCr2?=
 =?us-ascii?Q?UsSoIkjWoW88DvQpHK6fBhoMACYnZ6TKzxs9KzkRqjVXKYlavjKSdBiL0s0i?=
 =?us-ascii?Q?U0TuHvnHznQBrpjezupIGkGl26NavO7EEWq6od26ZlzTmT8dxRVZuyehgYnJ?=
 =?us-ascii?Q?E+gAqHnlSQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b534dea-95d7-47db-fbdb-08d9af6cecc0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7033.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 17:07:41.5972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWLYZ76EDX2/qzbiNZRc1rRVzOkjd81GousT+NeRY6p+NTSenwAzsEuenqcESNkM1mp6JiWKzPwhK6X8jSswAWMjmqkvdEEhfZt1rGxMDUyVrsA3ymAA9H8EQXNie8zc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5654
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add a trace event for hardware errors reported by the ARMv8
RAS extension registers.

Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
---
 arch/arm64/kernel/ras.c   |  4 +++
 drivers/acpi/arm64/aest.c |  5 ++++
 include/ras/ras_event.h   | 55 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/arch/arm64/kernel/ras.c b/arch/arm64/kernel/ras.c
index 31e2036a4c70..18071790b2a3 100644
--- a/arch/arm64/kernel/ras.c
+++ b/arch/arm64/kernel/ras.c
@@ -6,6 +6,8 @@
 #include <asm/cpufeature.h>
 #include <asm/ras.h>
 
+#include <ras/ras_event.h>
+
 static bool ras_extn_v1p1(void)
 {
 	unsigned long fld, reg = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
@@ -95,6 +97,8 @@ void arch_arm_ras_report_error(u64 implemented, bool clear_misc)
 
 		arch_arm_ras_print_error(&regs, i, misc23_present);
 
+		trace_arm_ras_ext_event(0, cpu_num, 0, i, &regs);
+
 		/*
 		 * In the future, we will treat UER conditions as potentially
 		 * recoverable.
diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
index 2df4f2377e51..7ef1750f91b3 100644
--- a/drivers/acpi/arm64/aest.c
+++ b/drivers/acpi/arm64/aest.c
@@ -14,6 +14,8 @@
 
 #include <asm/ras.h>
 
+#include <ras/ras_event.h>
+
 #undef pr_fmt
 #define pr_fmt(fmt) "ACPI AEST: " fmt
 
@@ -126,6 +128,9 @@ static void aest_proc(struct aest_node_data *data)
 
 		aest_print(data, regs, i, misc23_present);
 
+		trace_arm_ras_ext_event(data->node_type, data->data.vendor.acpi_hid,
+					data->data.vendor.acpi_uid, i, &regs);
+
 		if (regs.err_status & ERR_STATUS_UE)
 			fatal = true;
 
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 0bdbc0d17d2f..27b2be9f950d 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -338,6 +338,61 @@ TRACE_EVENT(aer_event,
 			"Not available")
 );
 
+/*
+ * ARM RAS Extension Events Report
+ *
+ * This event is generated when an error reported by the ARM RAS extension
+ * hardware is detected.
+ */
+
+#ifdef CONFIG_ARM64_RAS_EXTN
+#include <asm/ras.h>
+TRACE_EVENT(arm_ras_ext_event,
+
+	TP_PROTO(u8 type, u32 id0, u32 id1, u32 index, struct ras_ext_regs *regs),
+
+	TP_ARGS(type, id0, id1, index, regs),
+
+	TP_STRUCT__entry(
+		__field(u8,  type)
+		__field(u32, id0)
+		__field(u32, id1)
+		__field(u32, index)
+		__field(u64, err_fr)
+		__field(u64, err_ctlr)
+		__field(u64, err_status)
+		__field(u64, err_addr)
+		__field(u64, err_misc0)
+		__field(u64, err_misc1)
+		__field(u64, err_misc2)
+		__field(u64, err_misc3)
+	),
+
+	TP_fast_assign(
+		__entry->type = type;
+		__entry->id0 = id0;
+		__entry->id1 = id1;
+		__entry->index = index;
+		__entry->err_fr = regs->err_fr;
+		__entry->err_ctlr = regs->err_ctlr;
+		__entry->err_status = regs->err_status;
+		__entry->err_addr = regs->err_addr;
+		__entry->err_misc0 = regs->err_misc0;
+		__entry->err_misc1 = regs->err_misc1;
+		__entry->err_misc2 = regs->err_misc2;
+		__entry->err_misc3 = regs->err_misc3;
+	),
+
+	TP_printk("type: %d; id0: %d; id1: %d; index: %d; ERR_FR: %llx; ERR_CTLR: %llx; "
+		  "ERR_STATUS: %llx; ERR_ADDR: %llx; ERR_MISC0: %llx; ERR_MISC1: %llx; "
+		  "ERR_MISC2: %llx; ERR_MISC3: %llx",
+		  __entry->type, __entry->id0, __entry->id1, __entry->index, __entry->err_fr,
+		  __entry->err_ctlr, __entry->err_status, __entry->err_addr,
+		  __entry->err_misc0, __entry->err_misc1, __entry->err_misc2,
+		  __entry->err_misc3)
+);
+#endif
+
 /*
  * memory-failure recovery action result event
  *
-- 
2.33.1

