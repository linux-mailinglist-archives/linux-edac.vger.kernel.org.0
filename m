Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5607245CA9F
	for <lists+linux-edac@lfdr.de>; Wed, 24 Nov 2021 18:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349439AbhKXRKx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 24 Nov 2021 12:10:53 -0500
Received: from mail-bn8nam11on2138.outbound.protection.outlook.com ([40.107.236.138]:19424
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242518AbhKXRKw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 24 Nov 2021 12:10:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHryZG8KRHC9joaMytWI3PT6t/q2mAM9kviN2kFj/S2aga/fv7DMvi2/ujptlmvVs4LKL2Vayu+g/l5Ov1mPeHTyNaKxAcAFB8xkkXMgepaO3qLueEg1fZaDnc8IwmHIfgrKPBC5hgLwbvkijWhoh6b/eONosFZ6/B5/ays9/kqU3TQue6x1s4knfd7lK9CZTMItOk4chA35n95pvHQtx1sla51Mg2NFMUEhp8Fl3T4qla1oIUt6BcdR5iIous9jgm5n7/YRVasTXfe79O4mUqa9wKhYI3ln9+KLIHJw8OjfBfJgHgQ94FfK3nlpsg62evEL+MuqJyPJC/BQn9o44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l24kfZl0HCTkF6yvCTSBsKJZhFrIIS8vdxMvWOO+jYo=;
 b=WBszIrjFl0nntCPjiHnJLW03Lrotk+3kPPekM5ZFcae9qDhxlfQJbIXmUiufcKtjAA/JsJSjF2VS+hJXb3SWl2S0rH4HOyfx3ZO3b8h7jYROlJLRBrtsGpLCWleKnGahYEpSgXoUtZ+4Gi3nmJrvnX+6vPT1Lgg/In+jpf/gtB7hswkickQD4aiiAF+rvPCQhERyhfrsrjo/+MmlDVRysRcRaeip9vdTswLYSNoa1sVrUygdhsBDHD4qN//miXslhBPJ0+cls9pIkTLcHkW2rC4b0ZdaBybeAIxNOGPMZWMCGkHF85nVu0knojNR5V8//VfqCZ4yiVG+Ms7zqdEEmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l24kfZl0HCTkF6yvCTSBsKJZhFrIIS8vdxMvWOO+jYo=;
 b=DpFTiPx0HdrTHRUk8WvCxkUiHKE9t+eKzI956V/IwiSZdQPDiXfAW/na5Jj4o1mwYXsJ11PnWPOf9PlqlS6RgUTzfjrmdstcMaI4V7Bv0kBuFV6r+bxzyAF0OiWJ2v73x0tDlYg5Yd1s1jdTdngJS1jE/R66TYZhJWgengQPNFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB7033.prod.exchangelabs.com (2603:10b6:610:107::16) by
 CH2PR01MB5654.prod.exchangelabs.com (2603:10b6:610:2f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22; Wed, 24 Nov 2021 17:07:38 +0000
Received: from CH0PR01MB7033.prod.exchangelabs.com
 ([fe80::1dc1:27e5:9fb6:f13d]) by CH0PR01MB7033.prod.exchangelabs.com
 ([fe80::1dc1:27e5:9fb6:f13d%9]) with mapi id 15.20.4734.022; Wed, 24 Nov 2021
 17:07:38 +0000
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
Subject: [PATCH 1/2] ACPI/AEST: Initial AEST driver
Date:   Wed, 24 Nov 2021 12:07:07 -0500
Message-Id: <20211124170708.3874-2-baicar@os.amperecomputing.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211124170708.3874-1-baicar@os.amperecomputing.com>
References: <20211124170708.3874-1-baicar@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:610:38::36) To CH0PR01MB7033.prod.exchangelabs.com
 (2603:10b6:610:107::16)
MIME-Version: 1.0
Received: from sut04sys-r242-0330002bj0sa.scc-lab.amperecomputing.com (4.28.12.214) by CH2PR05CA0059.namprd05.prod.outlook.com (2603:10b6:610:38::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.6 via Frontend Transport; Wed, 24 Nov 2021 17:07:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a36418a-7641-4d2f-c460-08d9af6ceaf8
X-MS-TrafficTypeDiagnostic: CH2PR01MB5654:
X-Microsoft-Antispam-PRVS: <CH2PR01MB5654A06D70E8F8312250DAC3E3619@CH2PR01MB5654.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28XXiKR6qPSVFmu7IzfK2Yc89W9v1p+qAZu9J6L6niYPouBpxprHoIh0Ul709RWXOoURESmGOy47bqZWcRCf+Pf0iqve3zmqUn8JXFqEeeSWstgWcPerQFwohtay8aJ/GFvNgQsLHK1oy2sOHxR4j9pis9iuKbFdg8G3GIZSjynRwGWYrIHbixVL18Ub4pB3/PFus8OrxuxJMRNu0kopqS9ZI8OsV+SFgP2ZwMo/NV4obHrZXSL/MHsstD8IP/b8p8+wGbGCM2+HmpxXK/yu5J6zUQQCN8sVCozJMWcf1aa4aqSfJMQi6KapO4k4Ek7xoMhf9vTALqbZKcJLiISN4BwoQMwkhApPqQB4uTtMUqQPU65M9m9bn+Lyh8zYp4i6Hvv4syJnioPEUcExUsBCQeBczW1xsDwmwKx7k6tyFyMyH2Ft/liT8nEpqwqqrcv6qSgKI2itmjQFs+iI2QHJrINUaW1XoF4W8ODMggZihsPwhzNUKtPtLRajaGHQWCTnV+uHn7TivcLG8UoWDZdAxq4oCuudzgQDwgojB4t+8Krm6QasETwrcfEDfmbovfag+1DDarNwL+eui2Vc2S2a1U2pqbTCv5Rpa6zGGYC+m5gu8LW+x04esrZfRzr+ZCEIPEnTwrKGoKzbxyCRSAobhIUXD1C2fdqAqOlys7zJEYFJBBXDLP363W599r/pNPIsg1nIUpRmLm4S548P/lTXyZ6B/mqc5y7UsAjHLz7TOOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7033.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(186003)(38100700002)(1076003)(38350700002)(5660300002)(316002)(66476007)(83380400001)(66556008)(921005)(52116002)(4326008)(7406005)(508600001)(86362001)(66946007)(26005)(6486002)(6666004)(956004)(7416002)(2906002)(30864003)(107886003)(2616005)(6512007)(6506007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9U82MKDndTXzaH3LRAXdvVpGlV+fXgpBzhd+oVJa8rKWqgnUxsAlrxe923Gc?=
 =?us-ascii?Q?1VaLo91zmY0JxtNEcjAqhH4/EbbUg6NKckIBt8pa8H6Qxng+9roR1kkx3cXp?=
 =?us-ascii?Q?rvy6OL+G3PDoCmQmPLOEXXjXzzbyUQV9P/NVRHexAGfRVVjI9oOPsSI78lLN?=
 =?us-ascii?Q?rgwpp9w6rteAEXqH6nUZNqgPd8C4nTgoKcXrfYda4hsrH+f/+cGlzER/CIcD?=
 =?us-ascii?Q?AL/BZgAbbhpP9x/YMwi9HiHE8sampimRBZYUzuP56dHQXjO59NEFTkLQth6W?=
 =?us-ascii?Q?vq9lfDvFQfyBmMsBbiC8Xqx+zuoeSzj0TN0Mgp1ZyggsXO1iYgXwYvufEAnw?=
 =?us-ascii?Q?drtV7NybTH7ihFvzOgXMAmpCAcEvFGt4CvaZhBR42httk4hCeCUJGl41CocY?=
 =?us-ascii?Q?5np6HT2cxrL4zGjG1VBGM4Oo/XSZqYCzzUMp3xn0lzejVBhpAHECHfEZT1hA?=
 =?us-ascii?Q?LCr1IhPoouU4xx5uNm/5IJAa7Jq5+F3I1pTfW7hmwB0Q1/OeVf5bHqMLoOnH?=
 =?us-ascii?Q?oxpDkIsfa4BTni9Htw022prTKWCg6YBmljJZFbMxekyiOxW4AaV2adG2MSAU?=
 =?us-ascii?Q?aSv7Fi0AJ7ZvjsymkIZ64uiKnI+3Y27plQarZr8pixmK1GD+A4mDF7n8hlru?=
 =?us-ascii?Q?60ZelbWfkKmtz8IecD3t6JN+DwjNx1DbQCoYB96QUq5ZaK2fjIU3S7KPuser?=
 =?us-ascii?Q?ZsRRSIO9k+/y8sh/utMxh6urLTEAaLFckSAxf572aGi1zEojQawQaedcNoRW?=
 =?us-ascii?Q?gPzl/MSiYDk8rq1EMxocCNY90pBOcEy2UDWuyu1dUcWNvNCsB78VTLB4kcYb?=
 =?us-ascii?Q?yZS5OwWcuM76CLfdJw7E2yp8asKSiROcbk1os3Gf2bpwq+5Grx1fBWXyn9KN?=
 =?us-ascii?Q?gMcKLEYQNMW+XIkQw9NVgwl7AGtMz+x8AyMF26/M4XUKC1jBWK8H8i9rc9ei?=
 =?us-ascii?Q?cgxqnKs89OqqVNH2u/anX5lEHQrKNXHZMQqnPZeEwT+obdAS82hgop4K9BYu?=
 =?us-ascii?Q?C1bddK3H6+v9lzqxwMkJ+sW4qgVrOJBOKUuLidXT0Qzh6zaUdLKaEjCJjR+T?=
 =?us-ascii?Q?z934Ao06ZykB2z8xrGDwlT2YWyyubnTQFJ4Hsrlg2XWXn2W5cDz3DpWSAN4/?=
 =?us-ascii?Q?2HJOxxLM/tTJabyknpU3T5csZnYLd34DCsetbrykZjpWFFG/XaKU5og432nt?=
 =?us-ascii?Q?AgikCIQFldhZQjK/4+eCU0/u79XxYNKmzQ6b5pDaF5dmvQuPq/g5V4jxWcba?=
 =?us-ascii?Q?kufGRQ3UTe/TC9hC8QHqBCYEfsRXg47Dsh17MJlvq8ICgOY6gvKQ1SegAu1w?=
 =?us-ascii?Q?tTInqDZmymo3NJUUnQKlp7UMYSE+spxKsAx5g2vx71n+vtKqP7wfZQ2JTG8j?=
 =?us-ascii?Q?CRiUlw9F8STJ0DV1UvjCDf2vvkeSY0FQ5BPPn4zxtL0ekTxp3x7BEl2b1uaW?=
 =?us-ascii?Q?6XUnFLlvRmgzh5N0KWhr59HUfOrCcDP49MdiAY0OAGhFQdjnimNEO9LxIOa7?=
 =?us-ascii?Q?i+udi1yszgSfS/QnqLhVhrRg0HgExJ/BMt+zFTkFzYVQIHZNfjtKzhGmSUTW?=
 =?us-ascii?Q?58lN2K3h2lgNPC2g2QGOP1Vc9gg+YoSJExmycGKitXrCtrlVTV+h/prRyTyP?=
 =?us-ascii?Q?WzBhJU/MZ552H01yvy1PViFGVkTso+tBevK8hwRqDVYwvTup9QQsa5aTswW7?=
 =?us-ascii?Q?EVc9MO/t4GAb/ZqLPB75k3tG+rHseXn/nHbpfcvot2MK0gqBA7SlXHTQed05?=
 =?us-ascii?Q?Smz3UDgiJw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a36418a-7641-4d2f-c460-08d9af6ceaf8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7033.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 17:07:38.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+y/VCRNqr5hNBW4THPi2dDIpFXwEefj6QVYcCmKyRqTYdVS39kQCG7tK4vswSecx10UgUJ05TI5rsgfuxd/Pk7DsXc748xPmBEtMpjHSRfPemy1/y2pLgDpYDvIt+R1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5654
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add support for parsing the ARM Error Source Table and basic handling of
errors reported through both memory mapped and system register interfaces.

Assume system register interfaces are only registered with private
peripheral interrupts (PPIs); otherwise there is no guarantee the
core handling the error is the core which took the error and has the
syndrome info in its system registers.

Add logging for all detected errors and trigger a kernel panic if there is
any uncorrected error present.

Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
---
 MAINTAINERS                     |   1 +
 arch/arm64/include/asm/ras.h    |  52 ++++
 arch/arm64/include/asm/sysreg.h |   2 +
 arch/arm64/kernel/Makefile      |   1 +
 arch/arm64/kernel/ras.c         | 125 +++++++++
 arch/arm64/kvm/sys_regs.c       |   2 +
 drivers/acpi/arm64/Kconfig      |   3 +
 drivers/acpi/arm64/Makefile     |   1 +
 drivers/acpi/arm64/aest.c       | 450 ++++++++++++++++++++++++++++++++
 include/linux/acpi_aest.h       |  50 ++++
 include/linux/cpuhotplug.h      |   1 +
 11 files changed, 688 insertions(+)
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 arch/arm64/kernel/ras.c
 create mode 100644 drivers/acpi/arm64/aest.c
 create mode 100644 include/linux/acpi_aest.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5250298d2817..aa0483726606 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -382,6 +382,7 @@ ACPI FOR ARM64 (ACPI/arm64)
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 M:	Hanjun Guo <guohanjun@huawei.com>
 M:	Sudeep Holla <sudeep.holla@arm.com>
+R:	Tyler Baicar <baicar@os.amperecomputing.com>
 L:	linux-acpi@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
new file mode 100644
index 000000000000..e88fa93e5f1c
--- /dev/null
+++ b/arch/arm64/include/asm/ras.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_RAS_H
+#define __ASM_RAS_H
+
+#include <linux/types.h>
+#include <linux/bits.h>
+
+#define ERR_STATUS_AV		BIT(31)
+#define ERR_STATUS_V		BIT(30)
+#define ERR_STATUS_UE		BIT(29)
+#define ERR_STATUS_MV		BIT(26)
+#define ERR_STATUS_CE_MASK	(BIT(25) | BIT(24))
+#define ERR_STATUS_DE		BIT(23)
+#define ERR_STATUS_UET_MASK	(BIT(21) | BIT(20))
+#define ERR_STATUS_IERR_SHIFT	8
+#define ERR_STATUS_IERR_MASK	0xff
+#define ERR_STATUS_SERR_SHIFT	0
+#define ERR_STATUS_SERR_MASK	0xff
+#define ERR_STATUS_W1TC_MASK	0xfff80000
+
+#define ERRIDR_NUM_MASK		0xffff
+
+#define ERRGSR_OFFSET		0xe00
+#define ERRDEVARCH_OFFSET	0xfbc
+
+#define ERRDEVARCH_REV_SHIFT	0x16
+#define ERRDEVARCH_REV_MASK	0xf
+
+#define RAS_REV_v1_1		0x1
+
+struct ras_ext_regs {
+	u64 err_fr;
+	u64 err_ctlr;
+	u64 err_status;
+	u64 err_addr;
+	u64 err_misc0;
+	u64 err_misc1;
+	u64 err_misc2;
+	u64 err_misc3;
+};
+
+#ifdef CONFIG_ARM64_RAS_EXTN
+void arch_arm_ras_print_error(struct ras_ext_regs *regs, unsigned int i, bool misc23_present);
+u64 arch_arm_ras_get_status_clear_value(u64 err_status);
+void arch_arm_ras_report_error(u64 implemented, bool clear_misc);
+#else
+void arch_arm_ras_print_error(struct ras_ext_regs *regs, unsigned int i, bool misc23_present) { }
+u64 arch_arm_ras_get_status_clear_value(u64 err_status) { return 0; }
+void arch_arm_ras_report_error(u64 implemented, bool clear_misc) { }
+#endif
+
+#endif	/* __ASM_RAS_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 16b3f1a1d468..6bbed061d835 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -230,6 +230,8 @@
 #define SYS_ERXADDR_EL1			sys_reg(3, 0, 5, 4, 3)
 #define SYS_ERXMISC0_EL1		sys_reg(3, 0, 5, 5, 0)
 #define SYS_ERXMISC1_EL1		sys_reg(3, 0, 5, 5, 1)
+#define SYS_ERXMISC2_EL1		sys_reg(3, 0, 5, 5, 2)
+#define SYS_ERXMISC3_EL1		sys_reg(3, 0, 5, 5, 3)
 #define SYS_TFSR_EL1			sys_reg(3, 0, 5, 6, 0)
 #define SYS_TFSRE0_EL1			sys_reg(3, 0, 5, 6, 1)
 
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 88b3e2a21408..fe73844494ba 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 obj-$(CONFIG_ARM64_MTE)			+= mte.o
 obj-y					+= vdso-wrap.o
 obj-$(CONFIG_COMPAT_VDSO)		+= vdso32-wrap.o
+obj-$(CONFIG_ARM64_RAS_EXTN)		+= ras.o
 
 obj-y					+= probes/
 head-y					:= head.o
diff --git a/arch/arm64/kernel/ras.c b/arch/arm64/kernel/ras.c
new file mode 100644
index 000000000000..31e2036a4c70
--- /dev/null
+++ b/arch/arm64/kernel/ras.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/cpu.h>
+
+#include <asm/cpufeature.h>
+#include <asm/ras.h>
+
+static bool ras_extn_v1p1(void)
+{
+	unsigned long fld, reg = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+
+	fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64PFR0_RAS_SHIFT);
+
+	return fld >= ID_AA64PFR0_RAS_V1P1;
+}
+
+u64 arch_arm_ras_get_status_clear_value(u64 err_status)
+{
+	/* Write-one-to-clear the bits we've seen */
+	err_status &= ERR_STATUS_W1TC_MASK;
+
+	/* If CE field is non-zero, all bits must be written to properly clear */
+	if (err_status & ERR_STATUS_CE_MASK)
+		err_status |= ERR_STATUS_CE_MASK;
+
+	/* If UET field is non-zero, all bits must be written to properly clear */
+	if (err_status & ERR_STATUS_UET_MASK)
+		err_status |= ERR_STATUS_UET_MASK;
+
+	return err_status;
+}
+
+void arch_arm_ras_print_error(struct ras_ext_regs *regs, unsigned int i, bool misc23_present)
+{
+	pr_err(" ERR%uSTATUS: 0x%llx\n", i, regs->err_status);
+	if (regs->err_status & ERR_STATUS_AV)
+		pr_err(" ERR%uADDR: 0x%llx\n", i, regs->err_addr);
+
+	if (regs->err_status & ERR_STATUS_MV) {
+		pr_err(" ERR%uMISC0: 0x%llx\n", i, regs->err_misc0);
+		pr_err(" ERR%uMISC1: 0x%llx\n", i, regs->err_misc1);
+
+		if (misc23_present) {
+			pr_err(" ERR%uMISC2: 0x%llx\n", i, regs->err_misc2);
+			pr_err(" ERR%uMISC3: 0x%llx\n", i, regs->err_misc3);
+		}
+	}
+}
+
+#undef pr_fmt
+#define pr_fmt(fmt) "ARM RAS: " fmt
+
+void arch_arm_ras_report_error(u64 implemented, bool clear_misc)
+{
+	struct ras_ext_regs regs = {0};
+	unsigned int i, cpu_num;
+	bool misc23_present;
+	bool fatal = false;
+	u64 num_records;
+
+	if (!this_cpu_has_cap(ARM64_HAS_RAS_EXTN))
+		return;
+
+	cpu_num = get_cpu();
+	num_records = read_sysreg_s(SYS_ERRIDR_EL1) & ERRIDR_NUM_MASK;
+
+	for (i = 0; i < num_records; i++) {
+		if (!(implemented & BIT(i)))
+			continue;
+
+		write_sysreg_s(i, SYS_ERRSELR_EL1);
+		isb();
+		regs.err_status = read_sysreg_s(SYS_ERXSTATUS_EL1);
+
+		if (!(regs.err_status & ERR_STATUS_V))
+			continue;
+
+		pr_err("error from processor 0x%x\n", cpu_num);
+
+		if (regs.err_status & ERR_STATUS_AV)
+			regs.err_addr = read_sysreg_s(SYS_ERXADDR_EL1);
+
+		misc23_present = ras_extn_v1p1();
+
+		if (regs.err_status & ERR_STATUS_MV) {
+			regs.err_misc0 = read_sysreg_s(SYS_ERXMISC0_EL1);
+			regs.err_misc1 = read_sysreg_s(SYS_ERXMISC1_EL1);
+
+			if (misc23_present) {
+				regs.err_misc2 = read_sysreg_s(SYS_ERXMISC2_EL1);
+				regs.err_misc3 = read_sysreg_s(SYS_ERXMISC3_EL1);
+			}
+		}
+
+		arch_arm_ras_print_error(&regs, i, misc23_present);
+
+		/*
+		 * In the future, we will treat UER conditions as potentially
+		 * recoverable.
+		 */
+		if (regs.err_status & ERR_STATUS_UE)
+			fatal = true;
+
+		regs.err_status = arch_arm_ras_get_status_clear_value(regs.err_status);
+		write_sysreg_s(regs.err_status, SYS_ERXSTATUS_EL1);
+
+		if (clear_misc) {
+			write_sysreg_s(0x0, SYS_ERXMISC0_EL1);
+			write_sysreg_s(0x0, SYS_ERXMISC1_EL1);
+
+			if (misc23_present) {
+				write_sysreg_s(0x0, SYS_ERXMISC2_EL1);
+				write_sysreg_s(0x0, SYS_ERXMISC3_EL1);
+			}
+		}
+
+		isb();
+	}
+
+	if (fatal)
+		panic("ARM RAS: uncorrectable error encountered");
+
+	put_cpu();
+}
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index e3ec1a44f94d..dc15e9896db4 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1573,6 +1573,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_ERXADDR_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_ERXMISC0_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_ERXMISC1_EL1), trap_raz_wi },
+	{ SYS_DESC(SYS_ERXMISC2_EL1), trap_raz_wi },
+	{ SYS_DESC(SYS_ERXMISC3_EL1), trap_raz_wi },
 
 	MTE_REG(TFSR_EL1),
 	MTE_REG(TFSRE0_EL1),
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index 6dba187f4f2e..8d5cf99976c8 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -8,3 +8,6 @@ config ACPI_IORT
 
 config ACPI_GTDT
 	bool
+
+config ACPI_AEST
+	bool "ARM Error Source Table Support"
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 66acbe77f46e..8f60a9fb6ab1 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
 obj-y				+= dma.o
+obj-$(CONFIG_ACPI_AEST) 	+= aest.o
diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
new file mode 100644
index 000000000000..2df4f2377e51
--- /dev/null
+++ b/drivers/acpi/arm64/aest.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM Error Source Table Support
+ *
+ * Copyright (c) 2021, Ampere Computing LLC
+ */
+
+#include <linux/acpi.h>
+#include <linux/acpi_aest.h>
+#include <linux/cpuhotplug.h>
+#include <linux/kernel.h>
+
+#include <acpi/actbl.h>
+
+#include <asm/ras.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "ACPI AEST: " fmt
+
+static struct acpi_table_header *aest_table;
+
+static struct aest_node_data __percpu **ppi_data;
+static int ppi_irqs[AEST_MAX_PPI];
+static u8 num_ppi;
+static u8 ppi_idx;
+
+static bool aest_mmio_ras_misc23_present(u64 base_addr)
+{
+	u32 val;
+
+	val = readl((void *) (base_addr + ERRDEVARCH_OFFSET));
+	val <<= ERRDEVARCH_REV_SHIFT;
+	val &= ERRDEVARCH_REV_MASK;
+
+	return val >= RAS_REV_v1_1;
+}
+
+static void aest_print(struct aest_node_data *data, struct ras_ext_regs regs,
+		       int index, bool misc23_present)
+{
+	/* No more than 2 corrected messages every 5 seconds */
+	static DEFINE_RATELIMIT_STATE(ratelimit_corrected, 5*HZ, 2);
+
+	if (regs.err_status & ERR_STATUS_UE ||
+	    regs.err_status & ERR_STATUS_DE ||
+	    __ratelimit(&ratelimit_corrected)) {
+		switch (data->node_type) {
+		case ACPI_AEST_PROCESSOR_ERROR_NODE:
+			if (!(data->data.processor.flags & AEST_PROC_GLOBAL) &&
+			    !(data->data.processor.flags & AEST_PROC_SHARED))
+				pr_err("error from processor 0x%x\n",
+				       data->data.processor.processor_id);
+			break;
+		case ACPI_AEST_MEMORY_ERROR_NODE:
+			pr_err("error from memory at SRAT proximity domain 0x%x\n",
+			       data->data.memory.srat_proximity_domain);
+			break;
+		case ACPI_AEST_SMMU_ERROR_NODE:
+			pr_err("error from SMMU IORT node 0x%x subcomponent 0x%x\n",
+			       data->data.smmu.iort_node_reference,
+			       data->data.smmu.subcomponent_reference);
+			break;
+		case ACPI_AEST_VENDOR_ERROR_NODE:
+			pr_err("error from vendor hid 0x%x uid 0x%x\n",
+			       data->data.vendor.acpi_hid, data->data.vendor.acpi_uid);
+			break;
+		case ACPI_AEST_GIC_ERROR_NODE:
+			pr_err("error from GIC type 0x%x instance 0x%x\n",
+			       data->data.gic.interface_type, data->data.gic.instance_id);
+		}
+
+		arch_arm_ras_print_error(&regs, index, misc23_present);
+	}
+}
+
+static void aest_proc(struct aest_node_data *data)
+{
+	struct ras_ext_regs *regs_p, regs = {0};
+	bool misc23_present;
+	bool fatal = false;
+	u64 errgsr = 0;
+	int i;
+
+	/*
+	 * Currently SR based handling is done through the architected
+	 * discovery exposed through SRs. That may change in the future
+	 * if there is supplemental information in the AEST that is
+	 * needed.
+	 */
+	if (data->interface.type == ACPI_AEST_NODE_SYSTEM_REGISTER) {
+		arch_arm_ras_report_error(data->interface.implemented,
+					  data->interface.flags & AEST_INTERFACE_CLEAR_MISC);
+		return;
+	}
+
+	regs_p = data->interface.regs;
+	errgsr = readq((void *) (((u64) regs_p) + ERRGSR_OFFSET));
+
+	for (i = data->interface.start; i < data->interface.end; i++) {
+		if (!(data->interface.implemented & BIT(i)))
+			continue;
+
+		if (!(data->interface.status_reporting & BIT(i)) && !(errgsr & BIT(i)))
+			continue;
+
+		regs.err_status = readq(&regs_p[i].err_status);
+		if (!(regs.err_status & ERR_STATUS_V))
+			continue;
+
+		if (regs.err_status & ERR_STATUS_AV)
+			regs.err_addr = readq(&regs_p[i].err_addr);
+
+		regs.err_fr = readq(&regs_p[i].err_fr);
+		regs.err_ctlr = readq(&regs_p[i].err_ctlr);
+
+		if (regs.err_status & ERR_STATUS_MV) {
+			misc23_present = aest_mmio_ras_misc23_present((u64) regs_p);
+			regs.err_misc0 = readq(&regs_p[i].err_misc0);
+			regs.err_misc1 = readq(&regs_p[i].err_misc1);
+
+			if (misc23_present) {
+				regs.err_misc2 = readq(&regs_p[i].err_misc2);
+				regs.err_misc3 = readq(&regs_p[i].err_misc3);
+			}
+		}
+
+		aest_print(data, regs, i, misc23_present);
+
+		if (regs.err_status & ERR_STATUS_UE)
+			fatal = true;
+
+		regs.err_status = arch_arm_ras_get_status_clear_value(regs.err_status);
+		writeq(regs.err_status, &regs_p[i].err_status);
+
+		if (data->interface.flags & AEST_INTERFACE_CLEAR_MISC) {
+			writeq(0x0, &regs_p[i].err_misc0);
+			writeq(0x0, &regs_p[i].err_misc1);
+
+			if (misc23_present) {
+				writeq(0x0, &regs_p[i].err_misc2);
+				writeq(0x0, &regs_p[i].err_misc3);
+			}
+		}
+	}
+
+	if (fatal)
+		panic("AEST: uncorrectable error encountered");
+}
+
+static irqreturn_t aest_irq_func(int irq, void *input)
+{
+	struct aest_node_data *data = input;
+
+	aest_proc(data);
+
+	return IRQ_HANDLED;
+}
+
+static int __init aest_register_gsi(u32 gsi, int trigger, void *data)
+{
+	int cpu, irq;
+
+	irq = acpi_register_gsi(NULL, gsi, trigger, ACPI_ACTIVE_HIGH);
+
+	if (irq == -EINVAL) {
+		pr_err("failed to map AEST GSI %d\n", gsi);
+		return -EINVAL;
+	}
+
+	if (gsi < 16) {
+		pr_err("invalid GSI %d\n", gsi);
+		return -EINVAL;
+	} else if (gsi < 32) {
+		if (ppi_idx >= AEST_MAX_PPI) {
+			pr_err("Unable to register PPI %d\n", gsi);
+			return -EINVAL;
+		}
+		ppi_irqs[ppi_idx] = irq;
+		enable_percpu_irq(irq, IRQ_TYPE_NONE);
+		for_each_possible_cpu(cpu) {
+			memcpy(per_cpu_ptr(ppi_data[ppi_idx], cpu), data,
+			       sizeof(struct aest_node_data));
+		}
+		if (request_percpu_irq(irq, aest_irq_func, "AEST",
+				       ppi_data[ppi_idx++])) {
+			pr_err("failed to register AEST IRQ %d\n", irq);
+			return -EINVAL;
+		}
+	} else if (gsi < 1020) {
+		if (request_irq(irq, aest_irq_func, IRQF_SHARED, "AEST",
+				data)) {
+			pr_err("failed to register AEST IRQ %d\n", irq);
+			return -EINVAL;
+		}
+	} else {
+		pr_err("invalid GSI %d\n", gsi);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __init aest_init_interrupts(struct acpi_aest_hdr *node,
+				       struct aest_node_data *data)
+{
+	struct acpi_aest_node_interrupt *interrupt;
+	int i, trigger, ret = 0;
+
+	interrupt = ACPI_ADD_PTR(struct acpi_aest_node_interrupt, node,
+				 node->node_interrupt_offset);
+
+	for (i = 0; i < node->node_interrupt_count; i++, interrupt++) {
+		trigger = (interrupt->flags & AEST_INTERRUPT_MODE) ?
+			  ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
+		if (aest_register_gsi(interrupt->gsiv, trigger, data))
+			ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int __init aest_init_interface(struct acpi_aest_hdr *node,
+				       struct aest_node_data *data)
+{
+	struct acpi_aest_node_interface *interface;
+	struct resource *res;
+	int size;
+
+	interface = ACPI_ADD_PTR(struct acpi_aest_node_interface, node,
+				 node->node_interface_offset);
+
+	if (interface->type >= ACPI_AEST_XFACE_RESERVED) {
+		pr_err("invalid interface type: %d\n", interface->type);
+		return -EINVAL;
+	}
+
+	data->interface.type = interface->type;
+	data->interface.start = interface->error_record_index;
+	data->interface.end = interface->error_record_index + interface->error_record_count;
+	data->interface.flags = interface->flags;
+	data->interface.implemented = interface->error_record_implemented;
+	data->interface.status_reporting = interface->error_status_reporting;
+
+	/*
+	 * Currently SR based handling is done through the architected
+	 * discovery exposed through SRs. That may change in the future
+	 * if there is supplemental information in the AEST that is
+	 * needed.
+	 */
+	if (interface->type == ACPI_AEST_NODE_SYSTEM_REGISTER)
+		return 0;
+
+	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	size = interface->error_record_count * sizeof(struct ras_ext_regs);
+	res->name = "AEST";
+	res->start = interface->address;
+	res->end = res->start + size;
+	res->flags = IORESOURCE_MEM;
+	if (request_resource_conflict(&iomem_resource, res)) {
+		pr_err("unable to request region starting at 0x%llx\n",
+			res->start);
+		kfree(res);
+		return -EEXIST;
+	}
+
+	data->interface.regs = ioremap(interface->address, size);
+	if (data->interface.regs == NULL) {
+		kfree(res);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __init aest_init_node(struct acpi_aest_hdr *node)
+{
+	union acpi_aest_processor_data *proc_data;
+	union aest_node_spec *node_spec;
+	struct aest_node_data *data;
+	int ret;
+
+	data = kzalloc(sizeof(struct aest_node_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->node_type = node->type;
+
+	node_spec = ACPI_ADD_PTR(union aest_node_spec, node, node->node_specific_offset);
+
+	switch (node->type) {
+	case ACPI_AEST_PROCESSOR_ERROR_NODE:
+		memcpy(&data->data, node_spec, sizeof(struct acpi_aest_processor));
+		break;
+	case ACPI_AEST_MEMORY_ERROR_NODE:
+		memcpy(&data->data, node_spec, sizeof(struct acpi_aest_memory));
+		break;
+	case ACPI_AEST_SMMU_ERROR_NODE:
+		memcpy(&data->data, node_spec, sizeof(struct acpi_aest_smmu));
+		break;
+	case ACPI_AEST_VENDOR_ERROR_NODE:
+		memcpy(&data->data, node_spec, sizeof(struct acpi_aest_vendor));
+		break;
+	case ACPI_AEST_GIC_ERROR_NODE:
+		memcpy(&data->data, node_spec, sizeof(struct acpi_aest_gic));
+		break;
+	default:
+		kfree(data);
+		return -EINVAL;
+	}
+
+	if (node->type == ACPI_AEST_PROCESSOR_ERROR_NODE) {
+		proc_data = ACPI_ADD_PTR(union acpi_aest_processor_data, node_spec,
+					 sizeof(acpi_aest_processor));
+
+		switch (data->data.processor.resource_type) {
+		case ACPI_AEST_CACHE_RESOURCE:
+			memcpy(&data->proc_data, proc_data,
+			       sizeof(struct acpi_aest_processor_cache));
+			break;
+		case ACPI_AEST_TLB_RESOURCE:
+			memcpy(&data->proc_data, proc_data,
+			       sizeof(struct acpi_aest_processor_tlb));
+			break;
+		case ACPI_AEST_GENERIC_RESOURCE:
+			memcpy(&data->proc_data, proc_data,
+			       sizeof(struct acpi_aest_processor_generic));
+			break;
+		}
+	}
+
+	ret = aest_init_interface(node, data);
+	if (ret) {
+		kfree(data);
+		return ret;
+	}
+
+	return aest_init_interrupts(node, data);
+}
+
+static void aest_count_ppi(struct acpi_aest_hdr *node)
+{
+	struct acpi_aest_node_interrupt *interrupt;
+	int i;
+
+	interrupt = ACPI_ADD_PTR(struct acpi_aest_node_interrupt, node,
+				 node->node_interrupt_offset);
+
+	for (i = 0; i < node->node_interrupt_count; i++, interrupt++) {
+		if (interrupt->gsiv >= 16 && interrupt->gsiv < 32)
+			num_ppi++;
+	}
+}
+
+static int aest_starting_cpu(unsigned int cpu)
+{
+	int i;
+
+	for (i = 0; i < num_ppi; i++)
+		enable_percpu_irq(ppi_irqs[i], IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int aest_dying_cpu(unsigned int cpu)
+{
+	return 0;
+}
+
+int __init acpi_aest_init(void)
+{
+	struct acpi_aest_hdr *aest_node, *aest_end;
+	struct acpi_table_aest *aest;
+	int i, ret = 0;
+
+	if (acpi_disabled)
+		return 0;
+
+	if (!IS_ENABLED(CONFIG_ARM64_RAS_EXTN))
+		return 0;
+
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_AEST, 0, &aest_table)))
+		return -EINVAL;
+
+	aest = (struct acpi_table_aest *)aest_table;
+
+	/* Get the first AEST node */
+	aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
+				 sizeof(struct acpi_table_header));
+	/* Pointer to the end of the AEST table */
+	aest_end = ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
+				aest_table->length);
+
+	while (aest_node < aest_end) {
+		if (((u64)aest_node + aest_node->length) > (u64)aest_end) {
+			pr_err("AEST node pointer overflow, bad table\n");
+			return -EINVAL;
+		}
+
+		aest_count_ppi(aest_node);
+
+		aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest_node,
+					 aest_node->length);
+	}
+
+	if (num_ppi > AEST_MAX_PPI) {
+		pr_err("Limiting PPI support to %d PPIs\n", AEST_MAX_PPI);
+		num_ppi = AEST_MAX_PPI;
+	}
+
+	ppi_data = kcalloc(num_ppi, sizeof(struct aest_node_data *),
+			   GFP_KERNEL);
+
+	for (i = 0; i < num_ppi; i++) {
+		ppi_data[i] = alloc_percpu(struct aest_node_data);
+		if (!ppi_data[i]) {
+			pr_err("Failed percpu allocation\n");
+			ret = -ENOMEM;
+			goto fail;
+		}
+	}
+
+	aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
+				 sizeof(struct acpi_table_header));
+
+	while (aest_node < aest_end) {
+		ret = aest_init_node(aest_node);
+		if (ret)
+			pr_err("failed to init node: %d", ret);
+
+		aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest_node,
+					 aest_node->length);
+	}
+
+	cpuhp_setup_state(CPUHP_AP_ARM_AEST_STARTING,
+			  "drivers/acpi/arm64/aest:starting",
+			  aest_starting_cpu, aest_dying_cpu);
+
+	return 0;
+
+fail:
+	for (i = 0; i < num_ppi; i++)
+		free_percpu(ppi_data[i]);
+	kfree(ppi_data);
+	return ret;
+}
+
+early_initcall(acpi_aest_init);
diff --git a/include/linux/acpi_aest.h b/include/linux/acpi_aest.h
new file mode 100644
index 000000000000..492503f54ebc
--- /dev/null
+++ b/include/linux/acpi_aest.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef AEST_H
+#define AEST_H
+
+#include <acpi/actbl.h>
+
+#define ACPI_SIG_AEST			"AEST"	/* ARM Error Source Table */
+
+#define AEST_INTERRUPT_MODE		BIT(0)
+
+#define AEST_MAX_PPI			4
+
+#define AEST_PROC_GLOBAL		BIT(0)
+#define AEST_PROC_SHARED		BIT(1)
+
+#define AEST_INTERFACE_SHARED		BIT(0)
+#define AEST_INTERFACE_CLEAR_MISC	BIT(1)
+
+struct aest_interface_data {
+	u8 type;
+	u16 start;
+	u16 end;
+	u32 flags;
+	u64 implemented;
+	u64 status_reporting;
+	struct ras_ext_regs *regs;
+};
+
+union acpi_aest_processor_data {
+	struct acpi_aest_processor_cache cache_data;
+	struct acpi_aest_processor_tlb tlb_data;
+	struct acpi_aest_processor_generic generic_data;
+};
+
+union aest_node_spec {
+	struct acpi_aest_processor processor;
+	struct acpi_aest_memory memory;
+	struct acpi_aest_smmu smmu;
+	struct acpi_aest_vendor vendor;
+	struct acpi_aest_gic gic;
+};
+
+struct aest_node_data {
+	u8 node_type;
+	struct aest_interface_data interface;
+	union aest_node_spec data;
+	union acpi_aest_processor_data proc_data;
+};
+
+#endif /* AEST_H */
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 773c83730906..9d30e4c00a52 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -186,6 +186,7 @@ enum cpuhp_state {
 	CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_STARTING,
 	CPUHP_AP_KVM_ARM_TIMER_STARTING,
+	CPUHP_AP_ARM_AEST_STARTING,
 	/* Must be the last timer callback */
 	CPUHP_AP_DUMMY_TIMER_STARTING,
 	CPUHP_AP_ARM_XEN_STARTING,
-- 
2.33.1

