Return-Path: <linux-edac+bounces-4498-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2930BB1867C
	for <lists+linux-edac@lfdr.de>; Fri,  1 Aug 2025 19:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA3617F601
	for <lists+linux-edac@lfdr.de>; Fri,  1 Aug 2025 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF681EB193;
	Fri,  1 Aug 2025 17:21:14 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2219C546;
	Fri,  1 Aug 2025 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068874; cv=none; b=LrFfNUhZouDMnmwXnAw6Md+K30jTe900EJUA/jOK4mK32kPsOkC1kpgvw3liYYJawymRfkTTW9vCQzav2S1btyHi0ek18y/KCXAvKlnGC33vVEWguSn+l1hrBdfYqg0xUXunc33nEZ6Iy4/7wHlfHTL4mAxA+9Cxen2mnTZgsb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068874; c=relaxed/simple;
	bh=U45fOg6pYxaO5Jy+B2Dt0ds5FIjKrCvZDzVnls3Y4bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1Ej6P8QZLJz8lI5cpnTLAkvGHbLWOEwRiy8TBl65GG1d+KPbFTK/FEVCXUiRZgRhTbHD+8M5i1Wy1ao8e/v3qo4/8knkydFfz2DEmFJsQUEjMYOhqeG5tfoTv6N+AE0NlAw8Dc2iHCTcFqNn12CPF2taPc89yPpJ6XXBeBk28g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4btt3j4L7cz67nbq;
	Sat,  2 Aug 2025 01:19:29 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id D611F1400D4;
	Sat,  2 Aug 2025 01:21:08 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.32.206) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Aug 2025 19:21:06 +0200
From: <shiju.jose@huawei.com>
To: <rafael@kernel.org>, <bp@alien8.de>, <akpm@linux-foundation.org>,
	<rppt@kernel.org>, <dferguson@amperecomputing.com>,
	<linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-doc@vger.kernel.org>, <tony.luck@intel.com>,
	<lenb@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>
CC: <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
	<rientjes@google.com>, <jiaqiyan@google.com>, <Jon.Grimm@amd.com>,
	<dave.hansen@linux.intel.com>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<shiju.jose@huawei.com>
Subject: [PATCH v10 2/3] ACPI:RAS2: Add ACPI RAS2 driver
Date: Fri, 1 Aug 2025 18:20:28 +0100
Message-ID: <20250801172040.2175-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250801172040.2175-1-shiju.jose@huawei.com>
References: <20250801172040.2175-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for ACPI RAS2 feature table (RAS2) defined in the
ACPI 6.5 Specification, section 5.2.21.
Driver defines RAS2 Init, which extracts the RAS2 table and driver
adds auxiliary device for each memory feature which binds to the
RAS2 memory driver.

Driver uses PCC mailbox to communicate with the ACPI HW and the
driver adds OSPM interfaces to send RAS2 commands.

According to the ACPI specification rev 6.5, section 5.2.21.1.1
RAS2 Platform Communication Channel Descriptor, “RAS2 supports multiple
PCC channels, where a channel is dedicated to a given component
instance.” However, a customer system was built non-compliant with the
specification and uses a single PCC channel for RAS2 scrubbers across
all NUMA domains. Workarounds have been implemented in the RAS2 drivers
to support systems that do not comply with the specification.

ACPI specification rev 6.5, section 5.2.21.1.1 Table 5.80: RAS2 Platform
Communication Channel Descriptor format, defines Field: Instance,
Identifier for the system component instance that the RAS feature is
associated with.

Section 5.2.21.2.1 Hardware-based Memory Scrubbing describes as
The platform can use this feature to expose controls and capabilities
associated with hardware-based memory scrub engines. Modern scalable
platforms have complex memory systems with a multitude of memory
controllers that are in turn associated with NUMA domains. It is also
common for RAS errors related to memory to be associated with NUMA
domains, where the NUMA domain functions as a FRU identifier. This
feature thus provides memory scrubbing at a NUMA domain granularity.
The following are supported:
1. Independent memory scrubbing controls for each NUMA domain, identified
using its proximity domain.
2. Provision for background (patrol) scrubbing of the entire memory
system, as well as on-demand scrubbing for a specific region of memory.

Thus, the RAS2 driver requires the lowest physical continuous memory range
of the memory associated with a NUMA domain when communicating with the
firmware for memory-related features such as scrubbing. The driver uses
the component instance ID, as defined in Table 5.80, to look up the
corresponding entry in numa_memblks. This allows it to retrieve the lowest
physical continuous memory range for the NUMA node associated with the
memory and store it in the component specific struct ras2_pxm_domain.

Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/Kconfig  |  12 +
 drivers/acpi/Makefile |   1 +
 drivers/acpi/bus.c    |   3 +
 drivers/acpi/ras2.c   | 493 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/ras2.h   |  85 ++++++++
 5 files changed, 594 insertions(+)
 create mode 100644 drivers/acpi/ras2.c
 create mode 100644 include/acpi/ras2.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7bc40c2735ac..a87b1ddb6d9f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -293,6 +293,18 @@ config ACPI_CPPC_LIB
 	  If your platform does not support CPPC in firmware,
 	  leave this option disabled.
 
+config ACPI_RAS2
+	bool "ACPI RAS2 driver"
+	select AUXILIARY_BUS
+	select MAILBOX
+	select PCC
+	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
+	help
+	  The driver adds support for ACPI RAS2 feature table (extracts RAS2
+	  table from OS system table) and OSPM interfaces to send RAS2
+	  commands via PCC mailbox subspace. Driver adds platform device for
+	  the RAS2 memory features which binds to the RAS2 memory driver.
+
 config ACPI_PROCESSOR
 	tristate "Processor"
 	depends on X86 || ARM64 || LOONGARCH || RISCV
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d1b0affb844f..abfec6745724 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
+obj-$(CONFIG_ACPI_RAS2)		+= ras2.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index c2ab2783303f..5b4f04a4611c 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -31,6 +31,7 @@
 #include <acpi/apei.h>
 #include <linux/suspend.h>
 #include <linux/prmt.h>
+#include <acpi/ras2.h>
 
 #include "internal.h"
 
@@ -1474,6 +1475,8 @@ static int __init acpi_init(void)
 	acpi_debugger_init();
 	acpi_setup_sb_notify_handler();
 	acpi_viot_init();
+	acpi_ras2_init();
+
 	return 0;
 }
 
diff --git a/drivers/acpi/ras2.c b/drivers/acpi/ras2.c
new file mode 100644
index 000000000000..d819d7b5236c
--- /dev/null
+++ b/drivers/acpi/ras2.c
@@ -0,0 +1,493 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Implementation of ACPI RAS2 driver.
+ *
+ * Copyright (c) 2024-2025 HiSilicon Limited.
+ *
+ * Support for RAS2 - ACPI 6.5 Specification, section 5.2.21
+ *
+ * Driver contains ACPI RAS2 init, which extracts the ACPI RAS2 table and
+ * get the PCC channel subspace for communicating with the ACPI compliant
+ * HW platform which supports ACPI RAS2. Driver adds auxiliary devices
+ * for each RAS2 memory feature which binds to the memory ACPI RAS2 driver.
+ */
+
+#define pr_fmt(fmt) "ACPI RAS2: " fmt
+
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <linux/iopoll.h>
+#include <linux/ktime.h>
+#include <acpi/pcc.h>
+#include <acpi/ras2.h>
+
+/**
+ * struct ras2_pcc_subspace - Data structure for PCC communication
+ * @mbox_client:	struct mbox_client object
+ * @pcc_chan:		Pointer to struct pcc_mbox_chan
+ * @comm_addr:		Pointer to RAS2 PCC shared memory region
+ * @elem:		List for registered RAS2 PCC channel subspaces
+ * @pcc_lock:		PCC lock to provide mutually exclusive access
+ *			to PCC channel subspace
+ * @deadline_us:	Poll PCC status register timeout in micro secs
+ *			for PCC command complete
+ * @pcc_mpar:		Maximum Periodic Access Rate(MPAR) for PCC channel
+ * @pcc_mrtt:		Minimum Request Turnaround Time(MRTT) in micro secs
+ *			OS must wait after completion of a PCC command before
+ *			issue next command
+ * @last_cmd_cmpl_time:	completion time of last PCC command
+ * @last_mpar_reset:	Time of last MPAR count reset
+ * @mpar_count:		MPAR count
+ * @pcc_id:		Identifier of the RAS2 platform communication channel
+ * @last_cmd:		Last PCC command
+ * @pcc_chnl_acq:	Status of PCC channel acquired
+ * @kref:		kref object
+ */
+struct ras2_pcc_subspace {
+	struct mbox_client		mbox_client;
+	struct pcc_mbox_chan		*pcc_chan;
+	struct acpi_ras2_shmem __iomem	*comm_addr;
+	struct list_head		elem;
+	struct mutex			pcc_lock;
+	unsigned int			deadline_us;
+	unsigned int			pcc_mpar;
+	unsigned int			pcc_mrtt;
+	ktime_t				last_cmd_cmpl_time;
+	ktime_t				last_mpar_reset;
+	int				mpar_count;
+	int				pcc_id;
+	u16				last_cmd;
+	bool				pcc_chnl_acq;
+	struct kref			kref;
+};
+
+/*
+ * Arbitrary retries for PCC commands because the remote processor
+ * could be much slower to reply. Keeping it high enough to cover
+ * emulators where the processors run painfully slow.
+ */
+#define RAS2_NUM_RETRIES 600ULL
+
+#define RAS2_FEAT_TYPE_MEMORY 0x00
+
+/* Static variables for the RAS2 PCC subspaces */
+static DEFINE_MUTEX(ras2_pcc_list_lock);
+static LIST_HEAD(ras2_pcc_subspaces);
+
+static int ras2_report_cap_error(u32 cap_status)
+{
+	switch (cap_status) {
+	case ACPI_RAS2_NOT_VALID:
+	case ACPI_RAS2_NOT_SUPPORTED:
+		return -EPERM;
+	case ACPI_RAS2_BUSY:
+		return -EBUSY;
+	case ACPI_RAS2_FAILED:
+	case ACPI_RAS2_ABORTED:
+	case ACPI_RAS2_INVALID_DATA:
+		return -EINVAL;
+	default: /* 0 or other, Success */
+		return 0;
+	}
+}
+
+static int ras2_check_pcc_chan(struct ras2_pcc_subspace *pcc_subspace)
+{
+	struct acpi_ras2_shmem __iomem *gen_comm_base = pcc_subspace->comm_addr;
+	u32 cap_status, rc;
+	u16 status;
+
+	/*
+	 * As per ACPI spec, the PCC space will be initialized by
+	 * platform and should have set the command completion bit when
+	 * PCC can be used by OSPM.
+	 *
+	 * Poll PCC status register every 3us(delay_us) for maximum of
+	 * deadline_us(timeout_us) until PCC command complete bit is set(cond).
+	 */
+	rc = readw_relaxed_poll_timeout(&gen_comm_base->status, status,
+					status & PCC_STATUS_CMD_COMPLETE, 3,
+					pcc_subspace->deadline_us);
+	if (rc) {
+		pr_warn("PCC check channel timeout for pcc_id=%d rc=%d\n",
+			pcc_subspace->pcc_id, rc);
+		return rc;
+	}
+
+	if (status & PCC_STATUS_ERROR) {
+		pr_warn("Error in executing last command=%d for pcc_id=%d\n",
+			pcc_subspace->last_cmd, pcc_subspace->pcc_id);
+		status &= ~PCC_STATUS_ERROR;
+		writew_relaxed(status, &gen_comm_base->status);
+		return -EIO;
+	}
+
+	cap_status = readw_relaxed(&gen_comm_base->set_caps_status);
+	writew_relaxed(0x0, &gen_comm_base->set_caps_status);
+	return ras2_report_cap_error(cap_status);
+}
+
+/**
+ * ras2_send_pcc_cmd() - Send RAS2 command via PCC channel
+ * @ras2_ctx:	pointer to the RAS2 context structure
+ * @cmd:	command to send
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd)
+{
+	struct ras2_pcc_subspace *pcc_subspace = ras2_ctx->hdr.pcc_subspace;
+	struct acpi_ras2_shmem __iomem *gen_comm_base = pcc_subspace->comm_addr;
+	struct mbox_chan *pcc_channel;
+	unsigned int time_delta;
+	int rc;
+
+	rc = ras2_check_pcc_chan(pcc_subspace);
+	if (rc < 0)
+		return rc;
+
+	pcc_channel = pcc_subspace->pcc_chan->mchan;
+
+	/*
+	 * Handle the Minimum Request Turnaround Time(MRTT).
+	 * "The minimum amount of time that OSPM must wait after the completion
+	 * of a command before issuing the next command, in microseconds."
+	 */
+	if (pcc_subspace->pcc_mrtt) {
+		time_delta = ktime_us_delta(ktime_get(),
+					    pcc_subspace->last_cmd_cmpl_time);
+		if (pcc_subspace->pcc_mrtt > time_delta)
+			udelay(pcc_subspace->pcc_mrtt - time_delta);
+	}
+
+	/*
+	 * Handle the non-zero Maximum Periodic Access Rate(MPAR).
+	 * "The maximum number of periodic requests that the subspace channel can
+	 * support, reported in commands per minute. 0 indicates no limitation."
+	 *
+	 * This parameter should be ideally zero or large enough so that it can
+	 * handle maximum number of requests that all the cores in the system can
+	 * collectively generate. If it is not, we will follow the spec and just
+	 * not send the request to the platform after hitting the MPAR limit in
+	 * any 60s window.
+	 */
+	if (pcc_subspace->pcc_mpar) {
+		if (pcc_subspace->mpar_count == 0) {
+			time_delta = ktime_ms_delta(ktime_get(),
+						    pcc_subspace->last_mpar_reset);
+			if (time_delta < 60 * MSEC_PER_SEC) {
+				dev_dbg(ras2_ctx->hdr.dev,
+					"PCC cmd not sent due to MPAR limit");
+				return -EIO;
+			}
+			pcc_subspace->last_mpar_reset = ktime_get();
+			pcc_subspace->mpar_count = pcc_subspace->pcc_mpar;
+		}
+		pcc_subspace->mpar_count--;
+	}
+
+	/* Write to the shared comm region */
+	writew_relaxed(cmd, &gen_comm_base->command);
+
+	/* Flip CMD COMPLETE bit */
+	writew_relaxed(0, &gen_comm_base->status);
+
+	/* Ring doorbell */
+	rc = mbox_send_message(pcc_channel, &cmd);
+	if (rc < 0) {
+		dev_warn(ras2_ctx->hdr.dev,
+			 "Err sending PCC mbox message. cmd:%d, rc:%d\n",
+			 cmd, rc);
+		return rc;
+	}
+
+	pcc_subspace->last_cmd = cmd;
+
+	/*
+	 * If Minimum Request Turnaround Time is non-zero, we need
+	 * to record the completion time of both READ and WRITE
+	 * command for proper handling of MRTT, so we need to check
+	 * for pcc_mrtt in addition to CMD_READ.
+	 */
+	if (cmd == PCC_CMD_EXEC_RAS2 || pcc_subspace->pcc_mrtt) {
+		rc = ras2_check_pcc_chan(pcc_subspace);
+		if (pcc_subspace->pcc_mrtt)
+			pcc_subspace->last_cmd_cmpl_time = ktime_get();
+	}
+
+	if (pcc_channel->mbox->txdone_irq)
+		mbox_chan_txdone(pcc_channel, rc);
+	else
+		mbox_client_txdone(pcc_channel, rc);
+
+	return rc >= 0 ? 0 : rc;
+}
+EXPORT_SYMBOL_GPL(ras2_send_pcc_cmd);
+
+static void ras2_list_pcc_release(struct kref *kref)
+{
+	struct ras2_pcc_subspace *pcc_subspace =
+		container_of(kref, struct ras2_pcc_subspace, kref);
+
+	guard(mutex)(&ras2_pcc_list_lock);
+	list_del(&pcc_subspace->elem);
+	pcc_mbox_free_channel(pcc_subspace->pcc_chan);
+	kfree(pcc_subspace);
+}
+
+static void ras2_pcc_get(struct ras2_pcc_subspace *pcc_subspace)
+{
+	kref_get(&pcc_subspace->kref);
+}
+
+static void ras2_pcc_put(struct ras2_pcc_subspace *pcc_subspace)
+{
+	kref_put(&pcc_subspace->kref,  &ras2_list_pcc_release);
+}
+
+static struct ras2_pcc_subspace *ras2_get_pcc_subspace(int pcc_id)
+{
+	struct ras2_pcc_subspace *pcc_subspace;
+
+	guard(mutex)(&ras2_pcc_list_lock);
+	list_for_each_entry(pcc_subspace, &ras2_pcc_subspaces, elem) {
+		if (pcc_subspace->pcc_id != pcc_id)
+			continue;
+		ras2_pcc_get(pcc_subspace);
+		return pcc_subspace;
+	}
+
+	return NULL;
+}
+
+static int ras2_register_pcc_channel(struct ras2_mem_ctx_hdr *ras2_ctx_hdr,
+				     int pcc_id)
+{
+	struct ras2_pcc_subspace *pcc_subspace;
+	struct pcc_mbox_chan *pcc_chan;
+	struct mbox_client *mbox_cl;
+
+	if (pcc_id < 0)
+		return -EINVAL;
+
+	pcc_subspace = ras2_get_pcc_subspace(pcc_id);
+	if (pcc_subspace) {
+		ras2_ctx_hdr->pcc_subspace	= pcc_subspace;
+		ras2_ctx_hdr->comm_addr		= pcc_subspace->comm_addr;
+		ras2_ctx_hdr->dev		=
+			pcc_subspace->pcc_chan->mchan->mbox->dev;
+		ras2_ctx_hdr->pcc_lock		= &pcc_subspace->pcc_lock;
+		return 0;
+	}
+
+	pcc_subspace = kzalloc(sizeof(*pcc_subspace), GFP_KERNEL);
+	if (!pcc_subspace)
+		return -ENOMEM;
+
+	mbox_cl			= &pcc_subspace->mbox_client;
+	mbox_cl->knows_txdone	= true;
+
+	pcc_chan = pcc_mbox_request_channel(mbox_cl, pcc_id);
+	if (IS_ERR(pcc_chan)) {
+		kfree(pcc_subspace);
+		return PTR_ERR(pcc_chan);
+	}
+
+	pcc_subspace->pcc_id		= pcc_id;
+	pcc_subspace->pcc_chan		= pcc_chan;
+	pcc_subspace->comm_addr		= pcc_chan->shmem;
+	pcc_subspace->deadline_us	= RAS2_NUM_RETRIES * pcc_chan->latency;
+	pcc_subspace->pcc_mrtt		= pcc_chan->min_turnaround_time;
+	pcc_subspace->pcc_mpar		= pcc_chan->max_access_rate;
+	pcc_subspace->mbox_client.knows_txdone	= true;
+	pcc_subspace->pcc_chnl_acq	= true;
+
+	kref_init(&pcc_subspace->kref);
+
+	mutex_lock(&ras2_pcc_list_lock);
+	list_add(&pcc_subspace->elem, &ras2_pcc_subspaces);
+	ras2_pcc_get(pcc_subspace);
+	mutex_unlock(&ras2_pcc_list_lock);
+
+	ras2_ctx_hdr->pcc_subspace	= pcc_subspace;
+	ras2_ctx_hdr->comm_addr		= pcc_subspace->comm_addr;
+	ras2_ctx_hdr->dev		= pcc_chan->mchan->mbox->dev;
+
+	mutex_init(&pcc_subspace->pcc_lock);
+	ras2_ctx_hdr->pcc_lock	= &pcc_subspace->pcc_lock;
+
+	return 0;
+}
+
+static DEFINE_IDA(ras2_ida);
+static void ras2_release(struct device *device)
+{
+	struct auxiliary_device *auxdev = to_auxiliary_dev(device);
+	struct ras2_mem_ctx_hdr *ras2_ctx_hdr =
+		container_of(auxdev, struct ras2_mem_ctx_hdr, adev);
+	struct ras2_mem_ctx *ras2_ctx =
+		container_of(ras2_ctx_hdr, struct ras2_mem_ctx, hdr);
+
+	ida_free(&ras2_ida, auxdev->id);
+	ras2_pcc_put(ras2_ctx_hdr->pcc_subspace);
+	kfree(ras2_ctx);
+}
+
+static int ras2_add_aux_device(char *name, int channel,
+			       struct acpi_ras2_pcc_desc *pcc_desc_list,
+			       u16 num_pcc_descs, u16 num_pxm_domains)
+{
+	struct ras2_mem_ctx_hdr *ras2_ctx_hdr;
+	struct ras2_pxm_domain *pxm_domain;
+	struct ras2_mem_ctx *ras2_ctx;
+	u64 start, end;
+	u32 i, count;
+	int id, rc;
+
+	ras2_ctx = kzalloc(struct_size(ras2_ctx, pxm_domains, num_pxm_domains),
+			   GFP_KERNEL);
+	if (!ras2_ctx)
+		return -ENOMEM;
+
+	ras2_ctx_hdr = &ras2_ctx->hdr;
+	ras2_ctx_hdr->num_pxm_domains = num_pxm_domains;
+
+	for (i = 0, count = 0; i < num_pcc_descs; i++, pcc_desc_list++) {
+		if (pcc_desc_list->feature_type != RAS2_FEAT_TYPE_MEMORY)
+			continue;
+
+		start = 0;
+		end = 0;
+		pxm_domain = &ras2_ctx->pxm_domains[count];
+		pxm_domain->sys_comp_nid = pxm_to_node(pcc_desc_list->instance);
+		rc = node_to_phys_lowest_continuous_range(pxm_domain->sys_comp_nid,
+							  &start, &end);
+		if (rc < 0 || (!start && !end)) {
+			pr_warn("Failed to find phy addr range for NUMA node(%u) rc=%d\n",
+				pcc_desc_list->instance, rc);
+			goto ctx_free;
+		}
+		pxm_domain->feat_instance = count;
+		pxm_domain->mem_base_addr = start;
+		pxm_domain->mem_size = end - start;
+		count++;
+	}
+
+	rc = ras2_register_pcc_channel(ras2_ctx_hdr, channel);
+	if (rc < 0) {
+		pr_debug("Failed to register pcc channel rc=%d\n", rc);
+		goto ctx_free;
+	}
+
+	id = ida_alloc(&ras2_ida, GFP_KERNEL);
+	if (id < 0) {
+		rc = id;
+		goto pcc_free;
+	}
+
+	ras2_ctx_hdr->id		= id;
+	ras2_ctx_hdr->adev.id		= id;
+	ras2_ctx_hdr->adev.name		= RAS2_MEM_DEV_ID_NAME;
+	ras2_ctx_hdr->adev.dev.release	= ras2_release;
+	ras2_ctx_hdr->adev.dev.parent	= ras2_ctx_hdr->dev;
+
+	rc = auxiliary_device_init(&ras2_ctx_hdr->adev);
+	if (rc)
+		goto ida_free;
+
+	rc = auxiliary_device_add(&ras2_ctx_hdr->adev);
+	if (rc) {
+		auxiliary_device_uninit(&ras2_ctx_hdr->adev);
+		return rc;
+	}
+
+	return 0;
+
+ida_free:
+	ida_free(&ras2_ida, id);
+pcc_free:
+	ras2_pcc_put(ras2_ctx_hdr->pcc_subspace);
+ctx_free:
+	kfree(ras2_ctx);
+
+	return rc;
+}
+
+static int acpi_ras2_parse(struct acpi_table_ras2 * const ras2_tab)
+{
+	struct acpi_ras2_pcc_desc *pcc_desc_list;
+	u16 num_pxm_domains;
+	u16 i, count;
+	int pcc_id;
+	int rc;
+
+	if (ras2_tab->header.length < sizeof(*ras2_tab)) {
+		pr_warn(FW_WARN "ACPI RAS2 table present but broken (too short #1)\n");
+		return -EINVAL;
+	}
+
+	if (!ras2_tab->num_pcc_descs) {
+		pr_warn(FW_WARN "No PCC descs in ACPI RAS2 table\n");
+		return -EINVAL;
+	}
+
+	pcc_desc_list = (struct acpi_ras2_pcc_desc *)(ras2_tab + 1);
+	/* Double scan for the case of only one actual controller */
+	pcc_id = -1;
+	for (i = 0, count = 0; i < ras2_tab->num_pcc_descs; i++, pcc_desc_list++) {
+		if (pcc_desc_list->feature_type != RAS2_FEAT_TYPE_MEMORY)
+			continue;
+		if (pcc_id == -1) {
+			pcc_id = pcc_desc_list->channel_id;
+			count++;
+		}
+		if (pcc_desc_list->channel_id != pcc_id)
+			count++;
+		num_pxm_domains++;
+	}
+
+	/*
+	 * Workaround for the client platform with multiple scrub devices
+	 * but uses single PCC subspace for communication.
+	 */
+	if (count == 1) {
+		pcc_desc_list = (struct acpi_ras2_pcc_desc *)(ras2_tab + 1);
+		/* Add auxiliary device and bind ACPI RAS2 memory driver */
+		return ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME, pcc_id,
+					   pcc_desc_list,
+					   ras2_tab->num_pcc_descs,
+					   num_pxm_domains);
+	}
+
+	pcc_desc_list = (struct acpi_ras2_pcc_desc *)(ras2_tab + 1);
+	for (i = 0; i < ras2_tab->num_pcc_descs; i++, pcc_desc_list++) {
+		if (pcc_desc_list->feature_type != RAS2_FEAT_TYPE_MEMORY)
+			continue;
+
+		rc = ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME,
+					 pcc_desc_list->channel_id,
+					 pcc_desc_list, 1, 1);
+		if (rc)
+			pr_warn("Failed to add RAS2 auxiliary device rc=%d\n", rc);
+	}
+
+	return 0;
+}
+
+void __init acpi_ras2_init(void)
+{
+	struct acpi_table_ras2 * const ras2_tab;
+	acpi_status status;
+
+	status = acpi_get_table(ACPI_SIG_RAS2, 0,
+				(struct acpi_table_header **)&ras2_tab);
+	if (ACPI_FAILURE(status)) {
+		pr_err("Failed to get table, %s\n", acpi_format_exception(status));
+		return;
+	}
+
+	if (acpi_ras2_parse(ras2_tab))
+		pr_err("Failed to parse RAS2 table\n");
+
+	acpi_put_table((struct acpi_table_header *)ras2_tab);
+}
diff --git a/include/acpi/ras2.h b/include/acpi/ras2.h
new file mode 100644
index 000000000000..fc4d5ee64dad
--- /dev/null
+++ b/include/acpi/ras2.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ACPI RAS2 driver header file
+ *
+ * Copyright (c) 2024-2025 HiSilicon Limited
+ */
+
+#ifndef _ACPI_RAS2_H
+#define _ACPI_RAS2_H
+
+#include <linux/acpi.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/mailbox_client.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+struct device;
+
+/*
+ * ACPI spec 6.5 Table 5.82: PCC command codes used by
+ * RAS2 platform communication channel.
+ */
+#define PCC_CMD_EXEC_RAS2 0x01
+
+#define RAS2_AUX_DEV_NAME "ras2"
+#define RAS2_MEM_DEV_ID_NAME "acpi_ras2_mem"
+
+/**
+ * struct ras2_pxm_domain - RAS2 memory structure per NUMA pxm domain
+ * @sys_comp_nid:	Node ID of the system component that the RAS feature
+ *			is associated with. See ACPI spec 6.5 Table 5.80: RAS2
+ *			Platform Communication Channel Descriptor format,
+ *			Field: Instance
+ * @feat_instance:	Feature instance
+ * @mem_base_addr:	Base of the lowest physical continuous memory range
+ *			of the memory associated with the NUMA domain
+ * @mem_size		Size of the lowest physical continuous memory range
+ *			of the memory associated with the NUMA domain
+ */
+struct ras2_pxm_domain {
+	u32	sys_comp_nid;
+	u8	feat_instance;
+	u64	mem_base_addr;
+	u64	mem_size;
+};
+
+/**
+ * struct ras2_mem_ctx_hdr - Context header for RAS2 memory features
+ * @id:			Unique identifier for the RAS2 feature
+ * @adev:		Auxiliary device object
+ * @comm_addr:		Pointer to RAS2 PCC shared memory region
+ * @dev:		Pointer to device backing struct mbox_controller for PCC
+ * @pcc_subspace:	Pointer to local data structure for PCC communication
+ * @pcc_lock:		Pointer to PCC lock to provide mutually exclusive access
+ *			to PCC channel subspace
+ * @num_pxm_domains:	Number of memory PXM domains
+ */
+struct ras2_mem_ctx_hdr {
+	int				id;
+	struct auxiliary_device		adev;
+	struct acpi_ras2_shmem __iomem	*comm_addr;
+	struct device			*dev;
+	void				*pcc_subspace;
+	struct mutex			*pcc_lock;
+	u16				num_pxm_domains;
+};
+
+/**
+ * struct ras2_mem_ctx - Context for RAS2 memory features
+ * @hdr:		RAS2 context header
+ * @pxm_domains:	List of struct ras2_pxm_domain
+ */
+struct ras2_mem_ctx {
+	struct ras2_mem_ctx_hdr		hdr;
+	struct ras2_pxm_domain		pxm_domains[];
+};
+
+#ifdef CONFIG_ACPI_RAS2
+void __init acpi_ras2_init(void);
+int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd);
+#else
+static inline void acpi_ras2_init(void) { }
+#endif
+
+#endif /* _ACPI_RAS2_H */
-- 
2.43.0


