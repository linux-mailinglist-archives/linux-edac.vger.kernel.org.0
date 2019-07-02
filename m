Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517C45D4C2
	for <lists+linux-edac@lfdr.de>; Tue,  2 Jul 2019 18:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfGBQvs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Jul 2019 12:51:48 -0400
Received: from mail-eopbgr760109.outbound.protection.outlook.com ([40.107.76.109]:20740
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726486AbfGBQvr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 2 Jul 2019 12:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4N2qhyEzGGFHc9EEY1MXEWhsNsW06LoDtjyqali3r8=;
 b=R8s4vvEfmg6BOdhgxclAD1l0owm2OeAf5lLGN0bUYKBnPsUy0lJjM56Z1LOaDvwYGjKcpgtvkUlCtMmZvSet3yzFlwr2fLT+G+hQ6s/sssTb/GJw45ftUEU4wGSbQHk3e8XiV7jifA1TzpWUQ/AO1WJcIqXlCwxnjNPzTlk+AKU=
Received: from DM5PR0102MB3383.prod.exchangelabs.com (52.132.128.150) by
 DM5PR0102MB3512.prod.exchangelabs.com (52.132.130.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 16:51:38 +0000
Received: from DM5PR0102MB3383.prod.exchangelabs.com
 ([fe80::2560:7ba6:c491:dcce]) by DM5PR0102MB3383.prod.exchangelabs.com
 ([fe80::2560:7ba6:c491:dcce%7]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 16:51:38 +0000
From:   Tyler Baicar OS <baicar@os.amperecomputing.com>
To:     Open Source Submission <patches@amperecomputing.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Matteo.Carlini@arm.com" <Matteo.Carlini@arm.com>,
        "Andrew.Murray@arm.com" <Andrew.Murray@arm.com>
CC:     Tyler Baicar OS <baicar@os.amperecomputing.com>
Subject: [PATCH RFC 1/4] ACPI/AEST: Initial AEST driver
Thread-Topic: [PATCH RFC 1/4] ACPI/AEST: Initial AEST driver
Thread-Index: AQHVMPZqphfhRm1STkOzQdqBSPqI3Q==
Date:   Tue, 2 Jul 2019 16:51:38 +0000
Message-ID: <1562086280-5351-2-git-send-email-baicar@os.amperecomputing.com>
References: <1562086280-5351-1-git-send-email-baicar@os.amperecomputing.com>
In-Reply-To: <1562086280-5351-1-git-send-email-baicar@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:910:60::27) To DM5PR0102MB3383.prod.exchangelabs.com
 (2603:10b6:4:9f::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=baicar@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [4.28.12.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 920356d1-35e0-44c0-6d86-08d6ff0d8c60
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR0102MB3512;
x-ms-traffictypediagnostic: DM5PR0102MB3512:
x-microsoft-antispam-prvs: <DM5PR0102MB351278782331688E312E9057E3F80@DM5PR0102MB3512.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:265;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39850400004)(396003)(366004)(376002)(346002)(199004)(189003)(66066001)(7736002)(4326008)(305945005)(5660300002)(4720700003)(50226002)(2501003)(68736007)(8936002)(71200400001)(316002)(478600001)(110136005)(71190400001)(25786009)(8676002)(81156014)(81166006)(52116002)(446003)(76176011)(476003)(2616005)(7416002)(102836004)(2906002)(6506007)(386003)(11346002)(6116002)(26005)(66556008)(64756008)(14454004)(66476007)(73956011)(99286004)(66946007)(30864003)(86362001)(186003)(256004)(14444005)(3846002)(66446008)(6512007)(107886003)(6486002)(53936002)(53946003)(2201001)(486006)(6436002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR0102MB3512;H:DM5PR0102MB3383.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wDyXFr0R5F3Mcl43FcbkxdaNt45ZGzgkqz0MXwqDf9TP0aC0dwAVaSKWJx+ibNrU/J5BLIP4ZiONtcJSAlmwGqwmfOm0agBrPMHPs7rWoxaL7JX4lHxcrOnEcCH5JDPVHoo9qcqfK/GYFFfw+g+QeFgwWmR/nHhEKC3BPyu9izMTlpm+rmxNOscJGb2KILJ3CDqup55LctVVU32Z1fJ6UNgOJD0wGMvHmWhzyjQUS6CkAE742bn9wil4t3IkevY5H/jD/thDBoD39/Jou5lSM4UcwM6UpU2qAArZR+rGNF3I8RNpbRWW/ionp3LipAgSe4CD7bfVskeBAghHVXTSnBrNHwgY3Q8fMCdrpDvIUy88aHPejhOIzM5jUesdaiFbdtqX/QQjut52kwrKqe9hUk8lZFXm/Px9AiSB0UR8EHI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920356d1-35e0-44c0-6d86-08d6ff0d8c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 16:51:38.1787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Baicar@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0102MB3512
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add support for parsing the ARM Error Source Table and basic handling of
errors reported through both memory mapped and system register interfaces.

Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
---
 arch/arm64/include/asm/ras.h |  41 +++++
 arch/arm64/kernel/Makefile   |   2 +-
 arch/arm64/kernel/ras.c      |  67 ++++++++
 drivers/acpi/arm64/Kconfig   |   3 +
 drivers/acpi/arm64/Makefile  |   1 +
 drivers/acpi/arm64/aest.c    | 362 +++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/acpi_aest.h    |  94 +++++++++++
 7 files changed, 569 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 arch/arm64/kernel/ras.c
 create mode 100644 drivers/acpi/arm64/aest.c
 create mode 100644 include/linux/acpi_aest.h

diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
new file mode 100644
index 0000000..36bfff4
--- /dev/null
+++ b/arch/arm64/include/asm/ras.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_RAS_H
+#define __ASM_RAS_H
+
+#define ERR_STATUS_AV		BIT(31)
+#define ERR_STATUS_V		BIT(30)
+#define ERR_STATUS_UE		BIT(29)
+#define ERR_STATUS_ER		BIT(28)
+#define ERR_STATUS_OF		BIT(27)
+#define ERR_STATUS_MV		BIT(26)
+#define ERR_STATUS_CE_SHIFT	24
+#define ERR_STATUS_CE_MASK	0x3
+#define ERR_STATUS_DE		BIT(23)
+#define ERR_STATUS_PN		BIT(22)
+#define ERR_STATUS_UET_SHIFT	20
+#define ERR_STATUS_UET_MASK	0x3
+#define ERR_STATUS_IERR_SHIFT	8
+#define ERR_STATUS_IERR_MASK	0xff
+#define ERR_STATUS_SERR_SHIFT	0
+#define ERR_STATUS_SERR_MASK	0xff
+
+#define ERR_FR_CEC_SHIFT	12
+#define ERR_FR_CEC_MASK		0x7
+
+#define ERR_FR_8B_CEC		BIT(1)
+#define ERR_FR_16B_CEC		BIT(2)
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
+void arch_arm_ras_report_error(void);
+
+#endif	/* __ASM_RAS_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 9e7dcb2..294f602 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -19,7 +19,7 @@ obj-y			:=3D debug-monitors.o entry.o irq.o fpsimd.o		\
 			   return_address.o cpuinfo.o cpu_errata.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
-			   syscall.o
+			   syscall.o ras.o
=20
 extra-$(CONFIG_EFI)			:=3D efi-entry.o
=20
diff --git a/arch/arm64/kernel/ras.c b/arch/arm64/kernel/ras.c
new file mode 100644
index 0000000..ca47efa
--- /dev/null
+++ b/arch/arm64/kernel/ras.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/cpu.h>
+#include <linux/smp.h>
+
+#include <asm/ras.h>
+
+void arch_arm_ras_report_error(void)
+{
+	u64 num_records;
+	unsigned int i, cpu_num;
+	bool fatal =3D false;
+	struct ras_ext_regs regs;
+
+	if (!this_cpu_has_cap(ARM64_HAS_RAS_EXTN))
+		return;
+
+	cpu_num =3D get_cpu();
+	num_records =3D read_sysreg_s(SYS_ERRIDR_EL1);
+
+	for (i =3D 0; i < num_records; i++) {
+		write_sysreg_s(i, SYS_ERRSELR_EL1);
+		regs.err_status =3D read_sysreg_s(SYS_ERXSTATUS_EL1);
+
+		if (!(regs.err_status & ERR_STATUS_V))
+			continue;
+
+		pr_err("CPU%u: ERR%uSTATUS: 0x%llx\n", cpu_num, i,
+		       regs.err_status);
+
+		if (regs.err_status & ERR_STATUS_AV) {
+			regs.err_addr =3D read_sysreg_s(SYS_ERXSTATUS_EL1);
+			pr_err("CPU%u: ERR%uADDR: 0x%llx\n", cpu_num, i,
+			       regs.err_addr);
+		} else
+			regs.err_addr =3D 0;
+
+		regs.err_fr =3D read_sysreg_s(SYS_ERXFR_EL1);
+		pr_err("CPU%u: ERR%uFR: 0x%llx\n", cpu_num, i, regs.err_fr);
+		regs.err_ctlr =3D read_sysreg_s(SYS_ERXCTLR_EL1);
+		pr_err("CPU%u: ERR%uCTLR: 0x%llx\n", cpu_num, i, regs.err_ctlr);
+
+		if (regs.err_status & ERR_STATUS_MV) {
+			regs.err_misc0 =3D read_sysreg_s(SYS_ERXMISC0_EL1);
+			pr_err("CPU%u: ERR%uMISC0: 0x%llx\n", cpu_num, i,
+			       regs.err_misc0);
+			regs.err_misc1 =3D read_sysreg_s(SYS_ERXMISC1_EL1);
+			pr_err("CPU%u: ERR%uMISC1: 0x%llx\n", cpu_num, i,
+			       regs.err_misc1);
+		}
+
+		/*
+		 * In the future, we will treat UER conditions as potentially
+		 * recoverable.
+		 */
+		if (regs.err_status & ERR_STATUS_UE)
+			fatal =3D true;
+
+		write_sysreg_s(regs.err_status, SYS_ERXSTATUS_EL1);
+	}
+
+	if (fatal)
+		panic("uncorrectable error encountered");
+
+	put_cpu();
+}
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index 6dba187..8d5cf99 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -8,3 +8,6 @@ config ACPI_IORT
=20
 config ACPI_GTDT
 	bool
+
+config ACPI_AEST
+	bool "ARM Error Source Table Support"
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 6ff50f4..ea1ba28 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_ACPI_IORT) 	+=3D iort.o
 obj-$(CONFIG_ACPI_GTDT) 	+=3D gtdt.o
+obj-$(CONFIG_ACPI_AEST) 	+=3D aest.o
diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
new file mode 100644
index 0000000..fd4f3b5
--- /dev/null
+++ b/drivers/acpi/arm64/aest.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* ARM Error Source Table Support */
+
+#include <linux/acpi.h>
+#include <linux/acpi_aest.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/percpu.h>
+#include <linux/ratelimit.h>
+
+#include <asm/ras.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "ACPI AEST: " fmt
+
+static struct acpi_table_header *aest_table;
+
+static struct aest_node_data __percpu **ppi_data;
+static u8 num_ppi;
+static u8 ppi_idx;
+
+static void aest_print(struct aest_node_data *data, struct ras_ext_regs re=
gs,
+		       int index)
+{
+	/* No more than 2 corrected messages every 5 seconds */
+	static DEFINE_RATELIMIT_STATE(ratelimit_corrected, 5*HZ, 2);
+
+	if (regs.err_status & ERR_STATUS_UE ||
+	    regs.err_status & ERR_STATUS_DE ||
+	    __ratelimit(&ratelimit_corrected)) {
+		switch (data->node_type) {
+		case AEST_NODE_TYPE_PROC:
+			pr_err("error from processor 0x%x\n",
+			       data->data.proc.id);
+			break;
+		case AEST_NODE_TYPE_MEM:
+			pr_err("error from memory domain 0x%x\n",
+			       data->data.mem.domain);
+			break;
+		case AEST_NODE_TYPE_VENDOR:
+			pr_err("error from vendor specific source 0x%x\n",
+			       data->data.vendor.id);
+		}
+
+		pr_err("ERR%dSTATUS =3D 0x%llx\n", index, regs.err_status);
+		if (regs.err_status & ERR_STATUS_AV)
+			pr_err("ERR%dADDR =3D 0x%llx\n", index, regs.err_addr);
+
+		pr_err("ERR%dFR =3D 0x%llx\n", index, regs.err_fr);
+		pr_err("ERR%dCTLR =3D 0x%llx\n", index, regs.err_ctlr);
+
+		if (regs.err_status & ERR_STATUS_MV) {
+			pr_err("ERR%dMISC0 =3D 0x%llx\n", index, regs.err_misc0);
+			pr_err("ERR%dMISC1 =3D 0x%llx\n", index, regs.err_misc1);
+		}
+	}
+}
+
+static void aest_proc(struct aest_node_data *data)
+{
+	struct ras_ext_regs *regs_p, regs;
+	int i;
+	bool fatal =3D false;
+
+	/*
+	 * Currently SR based handling is done through the architected
+	 * discovery exposed through SRs. That may change in the future
+	 * if there is supplemental information in the AEST that is
+	 * needed.
+	 */
+	if (data->interface.type =3D=3D AEST_SYSTEM_REG_INTERFACE) {
+		arch_arm_ras_report_error();
+		return;
+	}
+
+	regs_p =3D data->interface.regs;
+
+	for (i =3D data->interface.start; i < data->interface.end; i++) {
+		regs.err_status =3D readq(&regs_p[i].err_status);
+		if (!(regs.err_status & ERR_STATUS_V))
+			continue;
+
+		if (regs.err_status & ERR_STATUS_AV)
+			regs.err_addr =3D readq(&regs_p[i].err_addr);
+		else
+			regs.err_addr =3D 0;
+
+		regs.err_fr =3D readq(&regs_p[i].err_fr);
+		regs.err_ctlr =3D readq(&regs_p[i].err_ctlr);
+
+		if (regs.err_status & ERR_STATUS_MV) {
+			regs.err_misc0 =3D readq(&regs_p[i].err_misc0);
+			regs.err_misc1 =3D readq(&regs_p[i].err_misc1);
+		} else {
+			regs.err_misc0 =3D 0;
+			regs.err_misc1 =3D 0;
+		}
+
+		aest_print(data, regs, i);
+
+		if (regs.err_status & ERR_STATUS_UE)
+			fatal =3D true;
+
+		writeq(regs.err_status, &regs_p[i].err_status);
+	}
+
+	if (fatal)
+		panic("AEST: uncorrectable error encountered");
+
+}
+
+static irqreturn_t aest_irq_func(int irq, void *input)
+{
+	struct aest_node_data *data =3D input;
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
+	irq =3D acpi_register_gsi(NULL, gsi, trigger, ACPI_ACTIVE_HIGH);
+
+	if (irq =3D=3D -EINVAL) {
+		pr_err("failed to map AEST GSI %d\n", gsi);
+		return -EINVAL;
+	}
+
+	if (gsi < 16) {
+		pr_err("invalid GSI %d\n", gsi);
+		return -EINVAL;
+	} else if (gsi < 32) {
+		if (ppi_idx >=3D AEST_MAX_PPI) {
+			pr_err("Unable to register PPI %d\n", gsi);
+			return -EINVAL;
+		}
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
+static int __init aest_init_interrupts(struct aest_type_header *node,
+				       struct aest_node_data *data)
+{
+	struct aest_interrupt *interrupt;
+	int i, trigger, ret =3D 0;
+
+	interrupt =3D ACPI_ADD_PTR(struct aest_interrupt, node,
+				 node->interrupt_offset);
+
+	for (i =3D 0; i < node->interrupt_size; i++, interrupt++) {
+		trigger =3D (interrupt->flags & AEST_INTERRUPT_MODE) ?
+			  ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
+		if (aest_register_gsi(interrupt->gsiv, trigger, data))
+			ret =3D -EINVAL;
+	}
+
+	return ret;
+}
+
+static int __init aest_init_interface(struct aest_type_header *node,
+				       struct aest_node_data *data)
+{
+	struct aest_interface *interface;
+	struct resource *res;
+	int size;
+
+	interface =3D ACPI_ADD_PTR(struct aest_interface, node,
+				 node->interface_offset);
+
+	if (interface->type > AEST_MEMORY_MAPPED_INTERFACE) {
+		pr_err("invalid interface type: %d\n", interface->type);
+		return -EINVAL;
+	}
+
+	data->interface.type =3D interface->type;
+
+	/*
+	 * Currently SR based handling is done through the architected
+	 * discovery exposed through SRs. That may change in the future
+	 * if there is supplemental information in the AEST that is
+	 * needed.
+	 */
+	if (interface->type =3D=3D AEST_SYSTEM_REG_INTERFACE)
+		return 0;
+
+	res =3D kzalloc(sizeof(struct resource), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	size =3D interface->num_records * sizeof(struct ras_ext_regs);
+	res->name =3D "AEST";
+	res->start =3D interface->address;
+	res->end =3D res->start + size;
+	res->flags =3D IORESOURCE_MEM;
+	if (request_resource_conflict(&iomem_resource, res)) {
+		pr_err("unable to request region starting at 0x%llx\n",
+			res->start);
+		kfree(res);
+		return -EEXIST;
+	}
+
+	data->interface.start =3D interface->start_index;
+	data->interface.end =3D interface->start_index + interface->num_records;
+
+	data->interface.regs =3D ioremap(interface->address, size);
+	if (data->interface.regs =3D=3D NULL)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int __init aest_init_node(struct aest_type_header *node)
+{
+	struct aest_node_data *data;
+	union aest_node_spec *node_spec;
+	int ret;
+
+	data =3D kzalloc(sizeof(struct aest_node_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->node_type =3D node->type;
+
+	node_spec =3D ACPI_ADD_PTR(union aest_node_spec, node, node->data_offset)=
;
+
+	switch (node->type) {
+	case AEST_NODE_TYPE_PROC:
+		memcpy(&data->data, node_spec, sizeof(struct aest_proc_data));
+		break;
+	case AEST_NODE_TYPE_MEM:
+		memcpy(&data->data, node_spec, sizeof(struct aest_mem_data));
+		break;
+	case AEST_NODE_TYPE_VENDOR:
+		memcpy(&data->data, node_spec, sizeof(struct aest_vendor_data));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret =3D aest_init_interface(node, data);
+	if (ret) {
+		kfree(data);
+		return ret;
+	}
+
+	return aest_init_interrupts(node, data);
+}
+
+static void aest_count_ppi(struct aest_type_header *node)
+{
+	struct aest_interrupt *interrupt;
+	int i;
+
+	interrupt =3D ACPI_ADD_PTR(struct aest_interrupt, node,
+				 node->interrupt_offset);
+
+	for (i =3D 0; i < node->interrupt_size; i++, interrupt++) {
+		if (interrupt->gsiv >=3D 16 && interrupt->gsiv < 32)
+			num_ppi++;
+	}
+
+}
+
+int __init acpi_aest_init(void)
+{
+	struct acpi_table_aest *aest;
+	struct aest_type_header *aest_node, *aest_end;
+	int i, ret =3D 0;
+
+	if (acpi_disabled)
+		return 0;
+
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_AEST, 0, &aest_table)))
+		return -EINVAL;
+
+	aest =3D (struct acpi_table_aest *)aest_table;
+
+	/* Get the first AEST node */
+	aest_node =3D ACPI_ADD_PTR(struct aest_type_header, aest,
+				 sizeof(struct acpi_table_aest));
+	/* Pointer to the end of the AEST table */
+	aest_end =3D ACPI_ADD_PTR(struct aest_type_header, aest,
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
+		aest_node =3D ACPI_ADD_PTR(struct aest_type_header, aest_node,
+					 aest_node->length);
+	}
+
+	if (num_ppi > AEST_MAX_PPI) {
+		pr_err("Limiting PPI support to %d PPIs\n", AEST_MAX_PPI);
+		num_ppi =3D AEST_MAX_PPI;
+	}
+
+	ppi_data =3D kcalloc(num_ppi, sizeof(struct aest_node_data *),
+			   GFP_KERNEL);
+
+	for (i =3D 0; i < num_ppi; i++) {
+		ppi_data[i] =3D alloc_percpu(struct aest_node_data);
+		if (!ppi_data[i]) {
+			ret =3D -ENOMEM;
+			break;
+		}
+	}
+
+	if (ret) {
+		pr_err("Failed percpu allocation\n");
+		for (i =3D 0; i < num_ppi; i++)
+			free_percpu(ppi_data[i]);
+		return ret;
+	}
+
+	aest_node =3D ACPI_ADD_PTR(struct aest_type_header, aest,
+				 sizeof(struct acpi_table_aest));
+
+	while (aest_node < aest_end) {
+		ret =3D aest_init_node(aest_node);
+		if (ret)
+			pr_err("failed to init node: %d", ret);
+
+		aest_node =3D ACPI_ADD_PTR(struct aest_type_header, aest_node,
+					 aest_node->length);
+	}
+
+	return 0;
+}
+
+early_initcall(acpi_aest_init);
diff --git a/include/linux/acpi_aest.h b/include/linux/acpi_aest.h
new file mode 100644
index 0000000..376122b
--- /dev/null
+++ b/include/linux/acpi_aest.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef AEST_H
+#define AEST_H
+
+#include <acpi/actbl.h>
+
+#define ACPI_SIG_AEST			"AEST"	/* ARM Error Source Table */
+
+#define AEST_NODE_TYPE_PROC		0
+#define AEST_NODE_TYPE_MEM		1
+#define AEST_NODE_TYPE_VENDOR		2
+
+#define AEST_SYSTEM_REG_INTERFACE	0x0
+#define AEST_MEMORY_MAPPED_INTERFACE	0x1
+
+#define AEST_INTERRUPT_MODE		BIT(0)
+
+#define AEST_MAX_PPI			4
+
+#pragma pack(1)
+
+struct acpi_table_aest {
+	struct acpi_table_header header;
+};
+
+struct aest_type_header {
+	u8 type;
+	u16 length;
+	u8 reserved;
+	u32 revision;
+	u32 data_offset;
+	u32 interface_offset;
+	u32 interface_size;
+	u32 interrupt_offset;
+	u32 interrupt_size;
+	u64 timestamp_rate;
+	u64 timestamp_start;
+	u64 countdown_rate;
+};
+
+struct aest_proc_data {
+	u32 id;
+	u32 level;
+	u32 cache_type;
+};
+
+struct aest_mem_data {
+	u32 domain;
+};
+
+struct aest_vendor_data {
+	u32 id;
+	u32 data;
+};
+
+struct aest_interface {
+	u8 type;
+	u8 reserved[3];
+	u32 flags;
+	u64 address;
+	u16 start_index;
+	u16 num_records;
+};
+
+struct aest_interrupt {
+	u8 type;
+	u16 reserved;
+	u8 flags;
+	u32 gsiv;
+	u8 iort_id[20];
+};
+
+#pragma pack()
+
+struct aest_interface_data {
+	u8 type;
+	u16 start;
+	u16 end;
+	struct ras_ext_regs *regs;
+};
+
+union aest_node_spec {
+	struct aest_proc_data proc;
+	struct aest_mem_data mem;
+	struct aest_vendor_data vendor;
+};
+
+struct aest_node_data {
+	u8 node_type;
+	struct aest_interface_data interface;
+	union aest_node_spec data;
+};
+
+#endif /* AEST_H */
--=20
1.8.3.1

