Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39AF95F51A
	for <lists+linux-edac@lfdr.de>; Thu,  4 Jul 2019 11:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfGDJFZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Jul 2019 05:05:25 -0400
Received: from foss.arm.com ([217.140.110.172]:37194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfGDJFZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 4 Jul 2019 05:05:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AACC1344;
        Thu,  4 Jul 2019 02:05:23 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0460C3F703;
        Thu,  4 Jul 2019 02:05:23 -0700 (PDT)
Date:   Thu, 4 Jul 2019 10:05:21 +0100
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
Message-ID: <20190704090520.GB7227@e119886-lin.cambridge.arm.com>
References: <1562086280-5351-1-git-send-email-baicar@os.amperecomputing.com>
 <1562086280-5351-2-git-send-email-baicar@os.amperecomputing.com>
 <20190703092549.GA51483@e119886-lin.cambridge.arm.com>
 <DM5PR0102MB33834E69835C641D7B167A82E3FB0@DM5PR0102MB3383.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM5PR0102MB33834E69835C641D7B167A82E3FB0@DM5PR0102MB3383.prod.exchangelabs.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jul 03, 2019 at 05:30:53PM +0000, Tyler Baicar OS wrote:
> Hello Andrew,
> 
> Thank you for the feedback!
> 
> On Wed, Jul 3, 2019 at 5:26 AM Andrew Murray <andrew.murray@arm.com> wrote:
> >
> > On Tue, Jul 02, 2019 at 04:51:38PM +0000, Tyler Baicar OS wrote:
> > > Add support for parsing the ARM Error Source Table and basic handling of
> > > errors reported through both memory mapped and system register interfaces.
> > >
> > > Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
> > > ---
> > >  arch/arm64/include/asm/ras.h |  41 +++++
> > >  arch/arm64/kernel/Makefile   |   2 +-
> > >  arch/arm64/kernel/ras.c      |  67 ++++++++
> > >  drivers/acpi/arm64/Kconfig   |   3 +
> > >  drivers/acpi/arm64/Makefile  |   1 +
> > >  drivers/acpi/arm64/aest.c    | 362 +++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/acpi_aest.h    |  94 +++++++++++
> > >  7 files changed, 569 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/arm64/include/asm/ras.h
> > >  create mode 100644 arch/arm64/kernel/ras.c
> > >  create mode 100644 drivers/acpi/arm64/aest.c
> > >  create mode 100644 include/linux/acpi_aest.h
> > >
> > > diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
> > > new file mode 100644
> > > index 0000000..36bfff4
> > > --- /dev/null
> > > +++ b/arch/arm64/include/asm/ras.h
> > > @@ -0,0 +1,41 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef __ASM_RAS_H
> > > +#define __ASM_RAS_H
> > > +
> > > +#define ERR_STATUS_AV                BIT(31)
> > > +#define ERR_STATUS_V         BIT(30)
> > > +#define ERR_STATUS_UE                BIT(29)
> > > +#define ERR_STATUS_ER                BIT(28)
> > > +#define ERR_STATUS_OF                BIT(27)
> > > +#define ERR_STATUS_MV                BIT(26)
> > > +#define ERR_STATUS_CE_SHIFT  24
> > > +#define ERR_STATUS_CE_MASK   0x3
> > > +#define ERR_STATUS_DE                BIT(23)
> > > +#define ERR_STATUS_PN                BIT(22)
> > > +#define ERR_STATUS_UET_SHIFT 20
> > > +#define ERR_STATUS_UET_MASK  0x3
> > > +#define ERR_STATUS_IERR_SHIFT        8
> > > +#define ERR_STATUS_IERR_MASK 0xff
> > > +#define ERR_STATUS_SERR_SHIFT        0
> > > +#define ERR_STATUS_SERR_MASK 0xff
> >
> > Some of these (_ER, _OF, _CE*, _PN, _UET*) are not used anywhere in the series,
> > I'd suggest you drop the unused ones.
> 
> Yes, I'll remove them in the next version.
> 
> > There may be some merit in renaming these to match the register names in the
> > spec, e.g. ERXSTATUS_EL1 instead of ERR_STATUS.
> 
> ERX* are the register names for the system registers, but these macros are used
> for both system registers and memory mapped registers. The memory mapped
> registers have prefix ERR<n>*. Also, the spec definition of the ERX* system
> registers is "accesses ERR<n>* for the error record selected by
> ERRSELR_EL1.SEL." So really, the registers being accessed in all cases are
> ERR<n>*. Either way, if folks think these names should be changed I can change
> them.

Sorry I hadn't considered the memory mapped registers. Your rationale seems
sound so no need to change them.

> 
> > > +
> > > +#define ERR_FR_CEC_SHIFT     12
> > > +#define ERR_FR_CEC_MASK              0x7
> > > +
> > > +#define ERR_FR_8B_CEC                BIT(1)
> > > +#define ERR_FR_16B_CEC               BIT(2)
> >
> > All of these ERR_FR_ defines aren't used anywhere either.
> 
> Will remove.
> 
> > > +
> > > +struct ras_ext_regs {
> > > +     u64 err_fr;
> > > +     u64 err_ctlr;
> > > +     u64 err_status;
> > > +     u64 err_addr;
> > > +     u64 err_misc0;
> > > +     u64 err_misc1;
> > > +     u64 err_misc2;
> > > +     u64 err_misc3;
> > > +};
> > > +
> > > +void arch_arm_ras_report_error(void);
> > > +
> > > +#endif       /* __ASM_RAS_H */
> > > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > > index 9e7dcb2..294f602 100644
> > > --- a/arch/arm64/kernel/Makefile
> > > +++ b/arch/arm64/kernel/Makefile
> > > @@ -19,7 +19,7 @@ obj-y                       := debug-monitors.o entry.o irq.o fpsimd.o              \
> > >                          return_address.o cpuinfo.o cpu_errata.o              \
> > >                          cpufeature.o alternative.o cacheinfo.o               \
> > >                          smp.o smp_spin_table.o topology.o smccc-call.o       \
> > > -                        syscall.o
> > > +                        syscall.o ras.o
> >
> > Given that arch_arm_ras_report_error depends on the ARM64_HAS_RAS_EXTN
> > capability, which in turn depends on CONFIG_ARM64_RAS_EXTN - you should
> > probably conditionally build ras.o only if CONFIG_ARM64_RAS_EXTN is defined
> > (and provide a stub in the header for when it isn't defined).
> 
> Yes, I can do that.
> 
> > > 
> > >  extra-$(CONFIG_EFI)                  := efi-entry.o
> > > 
> > > diff --git a/arch/arm64/kernel/ras.c b/arch/arm64/kernel/ras.c
> > > new file mode 100644
> > > index 0000000..ca47efa
> > > --- /dev/null
> > > +++ b/arch/arm64/kernel/ras.c
> > > @@ -0,0 +1,67 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/cpu.h>
> > > +#include <linux/smp.h>
> > > +
> > > +#include <asm/ras.h>
> > > +
> > > +void arch_arm_ras_report_error(void)
> > > +{
> > > +     u64 num_records;
> > > +     unsigned int i, cpu_num;
> > > +     bool fatal = false;
> > > +     struct ras_ext_regs regs;
> > > +
> > > +     if (!this_cpu_has_cap(ARM64_HAS_RAS_EXTN))
> > > +             return;
> > > +
> > > +     cpu_num = get_cpu();
> > > +     num_records = read_sysreg_s(SYS_ERRIDR_EL1);
> >
> > This value should be masked to exclude the reserved bits. This will
> > also prevent you writing to reserved bits in ERRSELR.
> 
> True, I'll add that in the next version.
> 
> > > +
> > > +     for (i = 0; i < num_records; i++) {
> > > +             write_sysreg_s(i, SYS_ERRSELR_EL1);
> >
> > There should be an isb here, this will ensure the record selection has
> > happened before reading the record.
> 
> I'll add that in the next version.
> 
> > > +             regs.err_status = read_sysreg_s(SYS_ERXSTATUS_EL1);
> > > +
> > > +             if (!(regs.err_status & ERR_STATUS_V))
> > > +                     continue;
> > > +
> > > +             pr_err("CPU%u: ERR%uSTATUS: 0x%llx\n", cpu_num, i,
> > > +                    regs.err_status);
> > > +
> > > +             if (regs.err_status & ERR_STATUS_AV) {
> > > +                     regs.err_addr = read_sysreg_s(SYS_ERXSTATUS_EL1);
> >
> > This should be SYS_ERXADDR_EL1 not SYS_ERXSTATUS_EL1!
> 
> Oops, good catch! I missed this in testing because none of the errors injected
> resulted in valid address info in the system registers.
> 
> > > +                     pr_err("CPU%u: ERR%uADDR: 0x%llx\n", cpu_num, i,
> > > +                            regs.err_addr);
> > > +             } else
> > > +                     regs.err_addr = 0;
> >
> > Or perhaps set "regs = { }" at the start of the function instead?
> 
> Yes, I could do that.
> 
> > > +
> > > +             regs.err_fr = read_sysreg_s(SYS_ERXFR_EL1);
> > > +             pr_err("CPU%u: ERR%uFR: 0x%llx\n", cpu_num, i, regs.err_fr);
> > > +             regs.err_ctlr = read_sysreg_s(SYS_ERXCTLR_EL1);
> > > +             pr_err("CPU%u: ERR%uCTLR: 0x%llx\n", cpu_num, i, regs.err_ctlr);
> > > +
> > > +             if (regs.err_status & ERR_STATUS_MV) {
> > > +                     regs.err_misc0 = read_sysreg_s(SYS_ERXMISC0_EL1);
> > > +                     pr_err("CPU%u: ERR%uMISC0: 0x%llx\n", cpu_num, i,
> > > +                            regs.err_misc0);
> > > +                     regs.err_misc1 = read_sysreg_s(SYS_ERXMISC1_EL1);
> > > +                     pr_err("CPU%u: ERR%uMISC1: 0x%llx\n", cpu_num, i,
> > > +                            regs.err_misc1);
> > > +             }
> > > +
> > > +             /*
> > > +              * In the future, we will treat UER conditions as potentially
> > > +              * recoverable.
> > > +              */
> > > +             if (regs.err_status & ERR_STATUS_UE)
> > > +                     fatal = true;
> > > +
> > > +             write_sysreg_s(regs.err_status, SYS_ERXSTATUS_EL1);
> > > +     }
> > > +
> > > +     if (fatal)
> > > +             panic("uncorrectable error encountered");
> >
> > On the do_serror path, we will already panic if arm64_is_fatal_ras_serror
> > indicates uncorrectable errors. Is this here for the other paths?
> 
> This same function is called for the SEA path and also from AEST for errors
> that are reported through the system register interface.
> 
> > > +
> > > +     put_cpu();
> > > +}
> >
> > Finally, should we clear the errors when we see them?
> 
> Each error is being cleared at the end of the loop above by writing the value
> read from the status register back to the status register. The status register
> bits are write 1 to clear and writing back the same value that was read
> guarantees that a higher priority error that occurs between the read and write
> isn't cleared.

Ah, I missed that.

When you write back the status to clear the bits, I think you ought to mask
off the bottom 16 bits (SERR, IERR) and arguably the top 32 bits to prevent
writing to res0 or fields that are not error write-1-to-clear bits.

Also the manual states "Software must also write ones to the { ER, PN, UET,
CI } fields when clearing these [valid bits] fields" - we achieve this
implicitly by writing back the value of status... however UET and CE take up
2 bits each and include this comment "Writing a value other than all-zeros or
all-ones sets this field to an UNKNOWN value". Thus we probably should do
the following (or similar) to be inline with the spec:

/* Write-one-to-clear the bits we've seen */
regs.err_status &= ~ERR_STATUS_ERR_MASK;

/* Correctly clear double bit fields */
if (regs.err_status & ERR_STATUS_CE_MASK)
    regs.err_status |= ERR_STATUS_CE_MASK;
if (regs.err_status & ERR_STATUS_UET_MASK)
    regs.err_status |= ERR_STATUS_UET_MASK

write_sysreg_s(regs.err_status, SYS_ERXSTATUS_EL1);
isb();

The isb may not be necessary but ensures we've cleared the errors before
leaving the function.

> 
> > > diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> > > index 6dba187..8d5cf99 100644
> > > --- a/drivers/acpi/arm64/Kconfig
> > > +++ b/drivers/acpi/arm64/Kconfig
> > > @@ -8,3 +8,6 @@ config ACPI_IORT
> > > 
> > >  config ACPI_GTDT
> > >       bool
> > > +
> > > +config ACPI_AEST
> > > +     bool "ARM Error Source Table Support"
> > > diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> > > index 6ff50f4..ea1ba28 100644
> > > --- a/drivers/acpi/arm64/Makefile
> > > +++ b/drivers/acpi/arm64/Makefile
> > > @@ -1,3 +1,4 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > >  obj-$(CONFIG_ACPI_IORT)      += iort.o
> > >  obj-$(CONFIG_ACPI_GTDT)      += gtdt.o
> > > +obj-$(CONFIG_ACPI_AEST)      += aest.o
> > > diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
> > > new file mode 100644
> > > index 0000000..fd4f3b5
> > > --- /dev/null
> > > +++ b/drivers/acpi/arm64/aest.c
> > > @@ -0,0 +1,362 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +/* ARM Error Source Table Support */
> > > +
> > > +#include <linux/acpi.h>
> > > +#include <linux/acpi_aest.h>
> > > +#include <linux/init.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/io.h>
> > > +#include <linux/irq.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/percpu.h>
> > > +#include <linux/ratelimit.h>
> > > +
> > > +#include <asm/ras.h>
> > > +
> > > +#undef pr_fmt
> > > +#define pr_fmt(fmt) "ACPI AEST: " fmt
> > > +
> > > +static struct acpi_table_header *aest_table;
> > > +
> > > +static struct aest_node_data __percpu **ppi_data;
> > > +static u8 num_ppi;
> > > +static u8 ppi_idx;
> > > +
> > > +static void aest_print(struct aest_node_data *data, struct ras_ext_regs regs,
> > > +                    int index)
> > > +{
> > > +     /* No more than 2 corrected messages every 5 seconds */
> > > +     static DEFINE_RATELIMIT_STATE(ratelimit_corrected, 5*HZ, 2);
> > > +
> > > +     if (regs.err_status & ERR_STATUS_UE ||
> > > +         regs.err_status & ERR_STATUS_DE ||
> > > +         __ratelimit(&ratelimit_corrected)) {
> > > +             switch (data->node_type) {
> > > +             case AEST_NODE_TYPE_PROC:
> > > +                     pr_err("error from processor 0x%x\n",
> > > +                            data->data.proc.id);
> > > +                     break;
> > > +             case AEST_NODE_TYPE_MEM:
> > > +                     pr_err("error from memory domain 0x%x\n",
> > > +                            data->data.mem.domain);
> > > +                     break;
> > > +             case AEST_NODE_TYPE_VENDOR:
> > > +                     pr_err("error from vendor specific source 0x%x\n",
> > > +                            data->data.vendor.id);
> > > +             }
> > > +
> > > +             pr_err("ERR%dSTATUS = 0x%llx\n", index, regs.err_status);
> > > +             if (regs.err_status & ERR_STATUS_AV)
> > > +                     pr_err("ERR%dADDR = 0x%llx\n", index, regs.err_addr);
> > > +
> > > +             pr_err("ERR%dFR = 0x%llx\n", index, regs.err_fr);
> > > +             pr_err("ERR%dCTLR = 0x%llx\n", index, regs.err_ctlr);
> > > +
> > > +             if (regs.err_status & ERR_STATUS_MV) {
> > > +                     pr_err("ERR%dMISC0 = 0x%llx\n", index, regs.err_misc0);
> > > +                     pr_err("ERR%dMISC1 = 0x%llx\n", index, regs.err_misc1);
> > > +             }
> >
> > Given that we have a ras_ext_regs struct, can't we use a single function to
> > print the error - rather than have duplicate pr_err's here and in
> > arch_arm_ras_report_error?
> 
> That was an option I had thought about, but I left it as is to get other
> opinions. Right now the system register reporting prefixes everything with the
> CPU number that the error occurred on...but now that I think about it more I
> could just have the print function take a prefix as a parameter. I'll unify the
> printing into a single function in the next version.

This is also helpful for times when you want to clear the error without
printing it. (E.g. to catch guest non-fatal errors and prevent a bad guest from
spaming the log buffer).

Thanks,

Andrew Murray

> 
> Thanks,
> Tyler
