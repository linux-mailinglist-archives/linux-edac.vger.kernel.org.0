Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F09105E0F9
	for <lists+linux-edac@lfdr.de>; Wed,  3 Jul 2019 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfGCJZz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 3 Jul 2019 05:25:55 -0400
Received: from foss.arm.com ([217.140.110.172]:42394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfGCJZz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 3 Jul 2019 05:25:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 264D5344;
        Wed,  3 Jul 2019 02:25:53 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F1CA3F246;
        Wed,  3 Jul 2019 02:25:52 -0700 (PDT)
Date:   Wed, 3 Jul 2019 10:25:50 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Tyler Baicar OS <baicar@os.amperecomputing.com>
Cc:     Open Source Submission <patches@amperecomputing.com>,
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
        "Matteo.Carlini@arm.com" <Matteo.Carlini@arm.com>
Subject: Re: [PATCH RFC 1/4] ACPI/AEST: Initial AEST driver
Message-ID: <20190703092549.GA51483@e119886-lin.cambridge.arm.com>
References: <1562086280-5351-1-git-send-email-baicar@os.amperecomputing.com>
 <1562086280-5351-2-git-send-email-baicar@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562086280-5351-2-git-send-email-baicar@os.amperecomputing.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jul 02, 2019 at 04:51:38PM +0000, Tyler Baicar OS wrote:
> Add support for parsing the ARM Error Source Table and basic handling of
> errors reported through both memory mapped and system register interfaces.
> 
> Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
> ---
>  arch/arm64/include/asm/ras.h |  41 +++++
>  arch/arm64/kernel/Makefile   |   2 +-
>  arch/arm64/kernel/ras.c      |  67 ++++++++
>  drivers/acpi/arm64/Kconfig   |   3 +
>  drivers/acpi/arm64/Makefile  |   1 +
>  drivers/acpi/arm64/aest.c    | 362 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi_aest.h    |  94 +++++++++++
>  7 files changed, 569 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/ras.h
>  create mode 100644 arch/arm64/kernel/ras.c
>  create mode 100644 drivers/acpi/arm64/aest.c
>  create mode 100644 include/linux/acpi_aest.h
> 
> diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
> new file mode 100644
> index 0000000..36bfff4
> --- /dev/null
> +++ b/arch/arm64/include/asm/ras.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_RAS_H
> +#define __ASM_RAS_H
> +
> +#define ERR_STATUS_AV		BIT(31)
> +#define ERR_STATUS_V		BIT(30)
> +#define ERR_STATUS_UE		BIT(29)
> +#define ERR_STATUS_ER		BIT(28)
> +#define ERR_STATUS_OF		BIT(27)
> +#define ERR_STATUS_MV		BIT(26)
> +#define ERR_STATUS_CE_SHIFT	24
> +#define ERR_STATUS_CE_MASK	0x3
> +#define ERR_STATUS_DE		BIT(23)
> +#define ERR_STATUS_PN		BIT(22)
> +#define ERR_STATUS_UET_SHIFT	20
> +#define ERR_STATUS_UET_MASK	0x3
> +#define ERR_STATUS_IERR_SHIFT	8
> +#define ERR_STATUS_IERR_MASK	0xff
> +#define ERR_STATUS_SERR_SHIFT	0
> +#define ERR_STATUS_SERR_MASK	0xff

Some of these (_ER, _OF, _CE*, _PN, _UET*) are not used anywhere in the series,
I'd suggest you drop the unused ones.

There may be some merit in renaming these to match the register names in the
spec, e.g. ERXSTATUS_EL1 instead of ERR_STATUS.

> +
> +#define ERR_FR_CEC_SHIFT	12
> +#define ERR_FR_CEC_MASK		0x7
> +
> +#define ERR_FR_8B_CEC		BIT(1)
> +#define ERR_FR_16B_CEC		BIT(2)

All of these ERR_FR_ defines aren't used anywhere either.

> +
> +struct ras_ext_regs {
> +	u64 err_fr;
> +	u64 err_ctlr;
> +	u64 err_status;
> +	u64 err_addr;
> +	u64 err_misc0;
> +	u64 err_misc1;
> +	u64 err_misc2;
> +	u64 err_misc3;
> +};
> +
> +void arch_arm_ras_report_error(void);
> +
> +#endif	/* __ASM_RAS_H */
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 9e7dcb2..294f602 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -19,7 +19,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
>  			   return_address.o cpuinfo.o cpu_errata.o		\
>  			   cpufeature.o alternative.o cacheinfo.o		\
>  			   smp.o smp_spin_table.o topology.o smccc-call.o	\
> -			   syscall.o
> +			   syscall.o ras.o

Given that arch_arm_ras_report_error depends on the ARM64_HAS_RAS_EXTN
capability, which in turn depends on CONFIG_ARM64_RAS_EXTN - you should
probably conditionally build ras.o only if CONFIG_ARM64_RAS_EXTN is defined
(and provide a stub in the header for when it isn't defined).

>  
>  extra-$(CONFIG_EFI)			:= efi-entry.o
>  
> diff --git a/arch/arm64/kernel/ras.c b/arch/arm64/kernel/ras.c
> new file mode 100644
> index 0000000..ca47efa
> --- /dev/null
> +++ b/arch/arm64/kernel/ras.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/kernel.h>
> +#include <linux/cpu.h>
> +#include <linux/smp.h>
> +
> +#include <asm/ras.h>
> +
> +void arch_arm_ras_report_error(void)
> +{
> +	u64 num_records;
> +	unsigned int i, cpu_num;
> +	bool fatal = false;
> +	struct ras_ext_regs regs;
> +
> +	if (!this_cpu_has_cap(ARM64_HAS_RAS_EXTN))
> +		return;
> +
> +	cpu_num = get_cpu();
> +	num_records = read_sysreg_s(SYS_ERRIDR_EL1);

This value should be masked to exclude the reserved bits. This will
also prevent you writing to reserved bits in ERRSELR.

> +
> +	for (i = 0; i < num_records; i++) {
> +		write_sysreg_s(i, SYS_ERRSELR_EL1);

There should be an isb here, this will ensure the record selection has
happened before reading the record.

> +		regs.err_status = read_sysreg_s(SYS_ERXSTATUS_EL1);
> +
> +		if (!(regs.err_status & ERR_STATUS_V))
> +			continue;
> +
> +		pr_err("CPU%u: ERR%uSTATUS: 0x%llx\n", cpu_num, i,
> +		       regs.err_status);
> +
> +		if (regs.err_status & ERR_STATUS_AV) {
> +			regs.err_addr = read_sysreg_s(SYS_ERXSTATUS_EL1);

This should be SYS_ERXADDR_EL1 not SYS_ERXSTATUS_EL1!

> +			pr_err("CPU%u: ERR%uADDR: 0x%llx\n", cpu_num, i,
> +			       regs.err_addr);
> +		} else
> +			regs.err_addr = 0;

Or perhaps set "regs = { }" at the start of the function instead?

> +
> +		regs.err_fr = read_sysreg_s(SYS_ERXFR_EL1);
> +		pr_err("CPU%u: ERR%uFR: 0x%llx\n", cpu_num, i, regs.err_fr);
> +		regs.err_ctlr = read_sysreg_s(SYS_ERXCTLR_EL1);
> +		pr_err("CPU%u: ERR%uCTLR: 0x%llx\n", cpu_num, i, regs.err_ctlr);
> +
> +		if (regs.err_status & ERR_STATUS_MV) {
> +			regs.err_misc0 = read_sysreg_s(SYS_ERXMISC0_EL1);
> +			pr_err("CPU%u: ERR%uMISC0: 0x%llx\n", cpu_num, i,
> +			       regs.err_misc0);
> +			regs.err_misc1 = read_sysreg_s(SYS_ERXMISC1_EL1);
> +			pr_err("CPU%u: ERR%uMISC1: 0x%llx\n", cpu_num, i,
> +			       regs.err_misc1);
> +		}
> +
> +		/*
> +		 * In the future, we will treat UER conditions as potentially
> +		 * recoverable.
> +		 */
> +		if (regs.err_status & ERR_STATUS_UE)
> +			fatal = true;
> +
> +		write_sysreg_s(regs.err_status, SYS_ERXSTATUS_EL1);
> +	}
> +
> +	if (fatal)
> +		panic("uncorrectable error encountered");

On the do_serror path, we will already panic if arm64_is_fatal_ras_serror
indicates uncorrectable errors. Is this here for the other paths?

> +
> +	put_cpu();
> +}

Finally, should we clear the errors when we see them?

> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index 6dba187..8d5cf99 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -8,3 +8,6 @@ config ACPI_IORT
>  
>  config ACPI_GTDT
>  	bool
> +
> +config ACPI_AEST
> +	bool "ARM Error Source Table Support"
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 6ff50f4..ea1ba28 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>  obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
> +obj-$(CONFIG_ACPI_AEST) 	+= aest.o
> diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
> new file mode 100644
> index 0000000..fd4f3b5
> --- /dev/null
> +++ b/drivers/acpi/arm64/aest.c
> @@ -0,0 +1,362 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* ARM Error Source Table Support */
> +
> +#include <linux/acpi.h>
> +#include <linux/acpi_aest.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/percpu.h>
> +#include <linux/ratelimit.h>
> +
> +#include <asm/ras.h>
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "ACPI AEST: " fmt
> +
> +static struct acpi_table_header *aest_table;
> +
> +static struct aest_node_data __percpu **ppi_data;
> +static u8 num_ppi;
> +static u8 ppi_idx;
> +
> +static void aest_print(struct aest_node_data *data, struct ras_ext_regs regs,
> +		       int index)
> +{
> +	/* No more than 2 corrected messages every 5 seconds */
> +	static DEFINE_RATELIMIT_STATE(ratelimit_corrected, 5*HZ, 2);
> +
> +	if (regs.err_status & ERR_STATUS_UE ||
> +	    regs.err_status & ERR_STATUS_DE ||
> +	    __ratelimit(&ratelimit_corrected)) {
> +		switch (data->node_type) {
> +		case AEST_NODE_TYPE_PROC:
> +			pr_err("error from processor 0x%x\n",
> +			       data->data.proc.id);
> +			break;
> +		case AEST_NODE_TYPE_MEM:
> +			pr_err("error from memory domain 0x%x\n",
> +			       data->data.mem.domain);
> +			break;
> +		case AEST_NODE_TYPE_VENDOR:
> +			pr_err("error from vendor specific source 0x%x\n",
> +			       data->data.vendor.id);
> +		}
> +
> +		pr_err("ERR%dSTATUS = 0x%llx\n", index, regs.err_status);
> +		if (regs.err_status & ERR_STATUS_AV)
> +			pr_err("ERR%dADDR = 0x%llx\n", index, regs.err_addr);
> +
> +		pr_err("ERR%dFR = 0x%llx\n", index, regs.err_fr);
> +		pr_err("ERR%dCTLR = 0x%llx\n", index, regs.err_ctlr);
> +
> +		if (regs.err_status & ERR_STATUS_MV) {
> +			pr_err("ERR%dMISC0 = 0x%llx\n", index, regs.err_misc0);
> +			pr_err("ERR%dMISC1 = 0x%llx\n", index, regs.err_misc1);
> +		}

Given that we have a ras_ext_regs struct, can't we use a single function to
print the error - rather than have duplicate pr_err's here and in
arch_arm_ras_report_error?

Thanks,

Andrew Murray

> +	}
> +}
> +
> +static void aest_proc(struct aest_node_data *data)
> +{
> +	struct ras_ext_regs *regs_p, regs;
> +	int i;
> +	bool fatal = false;
> +
> +	/*
> +	 * Currently SR based handling is done through the architected
> +	 * discovery exposed through SRs. That may change in the future
> +	 * if there is supplemental information in the AEST that is
> +	 * needed.
> +	 */
> +	if (data->interface.type == AEST_SYSTEM_REG_INTERFACE) {
> +		arch_arm_ras_report_error();
> +		return;
> +	}
> +
> +	regs_p = data->interface.regs;
> +
> +	for (i = data->interface.start; i < data->interface.end; i++) {
> +		regs.err_status = readq(&regs_p[i].err_status);
> +		if (!(regs.err_status & ERR_STATUS_V))
> +			continue;
> +
> +		if (regs.err_status & ERR_STATUS_AV)
> +			regs.err_addr = readq(&regs_p[i].err_addr);
> +		else
> +			regs.err_addr = 0;
> +
> +		regs.err_fr = readq(&regs_p[i].err_fr);
> +		regs.err_ctlr = readq(&regs_p[i].err_ctlr);
> +
> +		if (regs.err_status & ERR_STATUS_MV) {
> +			regs.err_misc0 = readq(&regs_p[i].err_misc0);
> +			regs.err_misc1 = readq(&regs_p[i].err_misc1);
> +		} else {
> +			regs.err_misc0 = 0;
> +			regs.err_misc1 = 0;
> +		}
> +
> +		aest_print(data, regs, i);
> +
> +		if (regs.err_status & ERR_STATUS_UE)
> +			fatal = true;
> +
> +		writeq(regs.err_status, &regs_p[i].err_status);
> +	}
> +
> +	if (fatal)
> +		panic("AEST: uncorrectable error encountered");
> +
> +}
> +
> +static irqreturn_t aest_irq_func(int irq, void *input)
> +{
> +	struct aest_node_data *data = input;
> +
> +	aest_proc(data);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init aest_register_gsi(u32 gsi, int trigger, void *data)
> +{
> +	int cpu, irq;
> +
> +	irq = acpi_register_gsi(NULL, gsi, trigger, ACPI_ACTIVE_HIGH);
> +
> +	if (irq == -EINVAL) {
> +		pr_err("failed to map AEST GSI %d\n", gsi);
> +		return -EINVAL;
> +	}
> +
> +	if (gsi < 16) {
> +		pr_err("invalid GSI %d\n", gsi);
> +		return -EINVAL;
> +	} else if (gsi < 32) {
> +		if (ppi_idx >= AEST_MAX_PPI) {
> +			pr_err("Unable to register PPI %d\n", gsi);
> +			return -EINVAL;
> +		}
> +		enable_percpu_irq(irq, IRQ_TYPE_NONE);
> +		for_each_possible_cpu(cpu) {
> +			memcpy(per_cpu_ptr(ppi_data[ppi_idx], cpu), data,
> +			       sizeof(struct aest_node_data));
> +		}
> +		if (request_percpu_irq(irq, aest_irq_func, "AEST",
> +				       ppi_data[ppi_idx++])) {
> +			pr_err("failed to register AEST IRQ %d\n", irq);
> +			return -EINVAL;
> +		}
> +	} else if (gsi < 1020) {
> +		if (request_irq(irq, aest_irq_func, IRQF_SHARED, "AEST",
> +				data)) {
> +			pr_err("failed to register AEST IRQ %d\n", irq);
> +			return -EINVAL;
> +		}
> +	} else {
> +		pr_err("invalid GSI %d\n", gsi);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init aest_init_interrupts(struct aest_type_header *node,
> +				       struct aest_node_data *data)
> +{
> +	struct aest_interrupt *interrupt;
> +	int i, trigger, ret = 0;
> +
> +	interrupt = ACPI_ADD_PTR(struct aest_interrupt, node,
> +				 node->interrupt_offset);
> +
> +	for (i = 0; i < node->interrupt_size; i++, interrupt++) {
> +		trigger = (interrupt->flags & AEST_INTERRUPT_MODE) ?
> +			  ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
> +		if (aest_register_gsi(interrupt->gsiv, trigger, data))
> +			ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int __init aest_init_interface(struct aest_type_header *node,
> +				       struct aest_node_data *data)
> +{
> +	struct aest_interface *interface;
> +	struct resource *res;
> +	int size;
> +
> +	interface = ACPI_ADD_PTR(struct aest_interface, node,
> +				 node->interface_offset);
> +
> +	if (interface->type > AEST_MEMORY_MAPPED_INTERFACE) {
> +		pr_err("invalid interface type: %d\n", interface->type);
> +		return -EINVAL;
> +	}
> +
> +	data->interface.type = interface->type;
> +
> +	/*
> +	 * Currently SR based handling is done through the architected
> +	 * discovery exposed through SRs. That may change in the future
> +	 * if there is supplemental information in the AEST that is
> +	 * needed.
> +	 */
> +	if (interface->type == AEST_SYSTEM_REG_INTERFACE)
> +		return 0;
> +
> +	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	size = interface->num_records * sizeof(struct ras_ext_regs);
> +	res->name = "AEST";
> +	res->start = interface->address;
> +	res->end = res->start + size;
> +	res->flags = IORESOURCE_MEM;
> +	if (request_resource_conflict(&iomem_resource, res)) {
> +		pr_err("unable to request region starting at 0x%llx\n",
> +			res->start);
> +		kfree(res);
> +		return -EEXIST;
> +	}
> +
> +	data->interface.start = interface->start_index;
> +	data->interface.end = interface->start_index + interface->num_records;
> +
> +	data->interface.regs = ioremap(interface->address, size);
> +	if (data->interface.regs == NULL)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int __init aest_init_node(struct aest_type_header *node)
> +{
> +	struct aest_node_data *data;
> +	union aest_node_spec *node_spec;
> +	int ret;
> +
> +	data = kzalloc(sizeof(struct aest_node_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->node_type = node->type;
> +
> +	node_spec = ACPI_ADD_PTR(union aest_node_spec, node, node->data_offset);
> +
> +	switch (node->type) {
> +	case AEST_NODE_TYPE_PROC:
> +		memcpy(&data->data, node_spec, sizeof(struct aest_proc_data));
> +		break;
> +	case AEST_NODE_TYPE_MEM:
> +		memcpy(&data->data, node_spec, sizeof(struct aest_mem_data));
> +		break;
> +	case AEST_NODE_TYPE_VENDOR:
> +		memcpy(&data->data, node_spec, sizeof(struct aest_vendor_data));
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = aest_init_interface(node, data);
> +	if (ret) {
> +		kfree(data);
> +		return ret;
> +	}
> +
> +	return aest_init_interrupts(node, data);
> +}
> +
> +static void aest_count_ppi(struct aest_type_header *node)
> +{
> +	struct aest_interrupt *interrupt;
> +	int i;
> +
> +	interrupt = ACPI_ADD_PTR(struct aest_interrupt, node,
> +				 node->interrupt_offset);
> +
> +	for (i = 0; i < node->interrupt_size; i++, interrupt++) {
> +		if (interrupt->gsiv >= 16 && interrupt->gsiv < 32)
> +			num_ppi++;
> +	}
> +
> +}
> +
> +int __init acpi_aest_init(void)
> +{
> +	struct acpi_table_aest *aest;
> +	struct aest_type_header *aest_node, *aest_end;
> +	int i, ret = 0;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_AEST, 0, &aest_table)))
> +		return -EINVAL;
> +
> +	aest = (struct acpi_table_aest *)aest_table;
> +
> +	/* Get the first AEST node */
> +	aest_node = ACPI_ADD_PTR(struct aest_type_header, aest,
> +				 sizeof(struct acpi_table_aest));
> +	/* Pointer to the end of the AEST table */
> +	aest_end = ACPI_ADD_PTR(struct aest_type_header, aest,
> +				aest_table->length);
> +
> +	while (aest_node < aest_end) {
> +		if (((u64)aest_node + aest_node->length) > (u64)aest_end) {
> +			pr_err("AEST node pointer overflow, bad table\n");
> +			return -EINVAL;
> +		}
> +
> +		aest_count_ppi(aest_node);
> +
> +		aest_node = ACPI_ADD_PTR(struct aest_type_header, aest_node,
> +					 aest_node->length);
> +	}
> +
> +	if (num_ppi > AEST_MAX_PPI) {
> +		pr_err("Limiting PPI support to %d PPIs\n", AEST_MAX_PPI);
> +		num_ppi = AEST_MAX_PPI;
> +	}
> +
> +	ppi_data = kcalloc(num_ppi, sizeof(struct aest_node_data *),
> +			   GFP_KERNEL);
> +
> +	for (i = 0; i < num_ppi; i++) {
> +		ppi_data[i] = alloc_percpu(struct aest_node_data);
> +		if (!ppi_data[i]) {
> +			ret = -ENOMEM;
> +			break;
> +		}
> +	}
> +
> +	if (ret) {
> +		pr_err("Failed percpu allocation\n");
> +		for (i = 0; i < num_ppi; i++)
> +			free_percpu(ppi_data[i]);
> +		return ret;
> +	}
> +
> +	aest_node = ACPI_ADD_PTR(struct aest_type_header, aest,
> +				 sizeof(struct acpi_table_aest));
> +
> +	while (aest_node < aest_end) {
> +		ret = aest_init_node(aest_node);
> +		if (ret)
> +			pr_err("failed to init node: %d", ret);
> +
> +		aest_node = ACPI_ADD_PTR(struct aest_type_header, aest_node,
> +					 aest_node->length);
> +	}
> +
> +	return 0;
> +}
> +
> +early_initcall(acpi_aest_init);
> diff --git a/include/linux/acpi_aest.h b/include/linux/acpi_aest.h
> new file mode 100644
> index 0000000..376122b
> --- /dev/null
> +++ b/include/linux/acpi_aest.h
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef AEST_H
> +#define AEST_H
> +
> +#include <acpi/actbl.h>
> +
> +#define ACPI_SIG_AEST			"AEST"	/* ARM Error Source Table */
> +
> +#define AEST_NODE_TYPE_PROC		0
> +#define AEST_NODE_TYPE_MEM		1
> +#define AEST_NODE_TYPE_VENDOR		2
> +
> +#define AEST_SYSTEM_REG_INTERFACE	0x0
> +#define AEST_MEMORY_MAPPED_INTERFACE	0x1
> +
> +#define AEST_INTERRUPT_MODE		BIT(0)
> +
> +#define AEST_MAX_PPI			4
> +
> +#pragma pack(1)
> +
> +struct acpi_table_aest {
> +	struct acpi_table_header header;
> +};
> +
> +struct aest_type_header {
> +	u8 type;
> +	u16 length;
> +	u8 reserved;
> +	u32 revision;
> +	u32 data_offset;
> +	u32 interface_offset;
> +	u32 interface_size;
> +	u32 interrupt_offset;
> +	u32 interrupt_size;
> +	u64 timestamp_rate;
> +	u64 timestamp_start;
> +	u64 countdown_rate;
> +};
> +
> +struct aest_proc_data {
> +	u32 id;
> +	u32 level;
> +	u32 cache_type;
> +};
> +
> +struct aest_mem_data {
> +	u32 domain;
> +};
> +
> +struct aest_vendor_data {
> +	u32 id;
> +	u32 data;
> +};
> +
> +struct aest_interface {
> +	u8 type;
> +	u8 reserved[3];
> +	u32 flags;
> +	u64 address;
> +	u16 start_index;
> +	u16 num_records;
> +};
> +
> +struct aest_interrupt {
> +	u8 type;
> +	u16 reserved;
> +	u8 flags;
> +	u32 gsiv;
> +	u8 iort_id[20];
> +};
> +
> +#pragma pack()
> +
> +struct aest_interface_data {
> +	u8 type;
> +	u16 start;
> +	u16 end;
> +	struct ras_ext_regs *regs;
> +};
> +
> +union aest_node_spec {
> +	struct aest_proc_data proc;
> +	struct aest_mem_data mem;
> +	struct aest_vendor_data vendor;
> +};
> +
> +struct aest_node_data {
> +	u8 node_type;
> +	struct aest_interface_data interface;
> +	union aest_node_spec data;
> +};
> +
> +#endif /* AEST_H */
> -- 
> 1.8.3.1
> 
