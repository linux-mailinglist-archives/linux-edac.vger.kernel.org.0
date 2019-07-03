Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 859415EA7B
	for <lists+linux-edac@lfdr.de>; Wed,  3 Jul 2019 19:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGCRbB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 3 Jul 2019 13:31:01 -0400
Received: from mail-eopbgr730110.outbound.protection.outlook.com ([40.107.73.110]:2135
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726430AbfGCRbB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 3 Jul 2019 13:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRrUeuOpZfh+jwPjUR9o3dRGkv9uGaOzk48zS0qaGAo=;
 b=HNkwqEJ5rHHMge66sYMc7Ke4kAa1KM8JRsTtW9kQoSQvYNkihEMt3BwA/t+rXd8a0Bkvq0JQLAFEbpH25RPKQO0T4DtzdfJpFGnUCJh6yFJOyXyg+WlNvM8Yf4KGuwbJ2G+Ydn9oj25bScANU6Jh18jVWpwJIYUTviKWo4eQ2cw=
Received: from DM5PR0102MB3383.prod.exchangelabs.com (52.132.128.150) by
 DM5PR0102MB3445.prod.exchangelabs.com (52.132.129.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 17:30:54 +0000
Received: from DM5PR0102MB3383.prod.exchangelabs.com
 ([fe80::2560:7ba6:c491:dcce]) by DM5PR0102MB3383.prod.exchangelabs.com
 ([fe80::2560:7ba6:c491:dcce%7]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 17:30:53 +0000
From:   Tyler Baicar OS <baicar@os.amperecomputing.com>
To:     Andrew Murray <andrew.murray@arm.com>
CC:     Open Source Submission <patches@amperecomputing.com>,
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
Thread-Topic: [PATCH RFC 1/4] ACPI/AEST: Initial AEST driver
Thread-Index: AQHVMPZqphfhRm1STkOzQdqBSPqI3aa4oK4AgABm5Mc=
Date:   Wed, 3 Jul 2019 17:30:53 +0000
Message-ID: <DM5PR0102MB33834E69835C641D7B167A82E3FB0@DM5PR0102MB3383.prod.exchangelabs.com>
References: <1562086280-5351-1-git-send-email-baicar@os.amperecomputing.com>
 <1562086280-5351-2-git-send-email-baicar@os.amperecomputing.com>,<20190703092549.GA51483@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190703092549.GA51483@e119886-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=baicar@os.amperecomputing.com; 
x-originating-ip: [174.109.142.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35e4bc7c-22a1-44fe-54e0-08d6ffdc336c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR0102MB3445;
x-ms-traffictypediagnostic: DM5PR0102MB3445:
x-microsoft-antispam-prvs: <DM5PR0102MB344593F8FE0B7B72DCC09014E3FB0@DM5PR0102MB3445.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(366004)(39840400004)(136003)(189003)(199004)(256004)(30864003)(81166006)(81156014)(33656002)(3846002)(8936002)(53936002)(102836004)(14444005)(74316002)(7736002)(76176011)(55016002)(86362001)(7696005)(6436002)(186003)(9686003)(229853002)(11346002)(2906002)(446003)(26005)(6246003)(53546011)(8676002)(6506007)(305945005)(6116002)(486006)(68736007)(91956017)(66476007)(66556008)(64756008)(66446008)(73956011)(25786009)(14454004)(76116006)(66946007)(71190400001)(52536014)(6916009)(5660300002)(316002)(4326008)(54906003)(478600001)(476003)(66066001)(99286004)(71200400001)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR0102MB3445;H:DM5PR0102MB3383.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9K/71CZQpauB/pvhbyFC3ny0DYjMLrl6shGbzPxl8hlfwWPoC6MWftI2OuwmJH+PDFEFvuWDih7QkCjk7w9nkopKn3JX5iKs8ZCI9WGLKJ16WQPyYKbMQhHpSYf88pByI6Vx5WIGsT60Dn/d6erqNHe+j+PKJDKw27X3EpVqHvG0SOqrA1Q6Z+3tXR1xYpcPKrJrKM9PXONW3J+mtuU2Mw8b39ISHAt3oLRsN3LXIckVcO4gH6cTV4GhU670Eo9HljDWBY33hBZtITouTU5hNebS9WpWE8XTwYKzVnGAxtZo8xWjKDbiBLq0xDkd12FQeUJXYz2j57Cf7F23uAPSHCwVh2VIjtKm+pVkRIe8Vj4ARP87soeqQu4Z7iSAhixPyqIjni4WVC1kZJeWefMtbGwuZsSHUmIIGWvyNJomQnQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e4bc7c-22a1-44fe-54e0-08d6ffdc336c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 17:30:53.7650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Baicar@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0102MB3445
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello Andrew,

Thank you for the=A0feedback!

On Wed, Jul 3, 2019 at 5:26 AM Andrew Murray <andrew.murray@arm.com> wrote:
>
> On Tue, Jul 02, 2019 at 04:51:38PM +0000, Tyler Baicar OS wrote:
> > Add support for parsing the ARM Error Source Table and basic handling o=
f
> > errors reported through both memory mapped and system register interfac=
es.
> >
> > Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
> > ---
> >  arch/arm64/include/asm/ras.h |  41 +++++
> >  arch/arm64/kernel/Makefile   |   2 +-
> >  arch/arm64/kernel/ras.c      |  67 ++++++++
> >  drivers/acpi/arm64/Kconfig   |   3 +
> >  drivers/acpi/arm64/Makefile  |   1 +
> >  drivers/acpi/arm64/aest.c    | 362 +++++++++++++++++++++++++++++++++++=
++++++++
> >  include/linux/acpi_aest.h    |  94 +++++++++++
> >  7 files changed, 569 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/include/asm/ras.h
> >  create mode 100644 arch/arm64/kernel/ras.c
> >  create mode 100644 drivers/acpi/arm64/aest.c
> >  create mode 100644 include/linux/acpi_aest.h
> >
> > diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.=
h
> > new file mode 100644
> > index 0000000..36bfff4
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/ras.h
> > @@ -0,0 +1,41 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __ASM_RAS_H
> > +#define __ASM_RAS_H
> > +
> > +#define ERR_STATUS_AV                BIT(31)
> > +#define ERR_STATUS_V         BIT(30)
> > +#define ERR_STATUS_UE                BIT(29)
> > +#define ERR_STATUS_ER                BIT(28)
> > +#define ERR_STATUS_OF                BIT(27)
> > +#define ERR_STATUS_MV                BIT(26)
> > +#define ERR_STATUS_CE_SHIFT  24
> > +#define ERR_STATUS_CE_MASK   0x3
> > +#define ERR_STATUS_DE                BIT(23)
> > +#define ERR_STATUS_PN                BIT(22)
> > +#define ERR_STATUS_UET_SHIFT 20
> > +#define ERR_STATUS_UET_MASK  0x3
> > +#define ERR_STATUS_IERR_SHIFT        8
> > +#define ERR_STATUS_IERR_MASK 0xff
> > +#define ERR_STATUS_SERR_SHIFT        0
> > +#define ERR_STATUS_SERR_MASK 0xff
>
> Some of these (_ER, _OF, _CE*, _PN, _UET*) are not used anywhere in the s=
eries,
> I'd suggest you drop the unused ones.

Yes, I'll remove them in the next version.

> There may be some merit in renaming these to match the register names in =
the
> spec, e.g. ERXSTATUS_EL1 instead of ERR_STATUS.

ERX* are the register names for the system registers, but these macros are =
used
for both system registers and memory mapped registers. The memory mapped
registers have prefix ERR<n>*. Also, the spec definition of the ERX* system
registers is "accesses ERR<n>* for the error record selected by
ERRSELR_EL1.SEL." So really, the registers being accessed in all cases are
ERR<n>*. Either way, if folks think these names should be changed I can cha=
nge
them.

> > +
> > +#define ERR_FR_CEC_SHIFT     12
> > +#define ERR_FR_CEC_MASK              0x7
> > +
> > +#define ERR_FR_8B_CEC                BIT(1)
> > +#define ERR_FR_16B_CEC               BIT(2)
>
> All of these ERR_FR_ defines aren't used anywhere either.

Will remove.

> > +
> > +struct ras_ext_regs {
> > +     u64 err_fr;
> > +     u64 err_ctlr;
> > +     u64 err_status;
> > +     u64 err_addr;
> > +     u64 err_misc0;
> > +     u64 err_misc1;
> > +     u64 err_misc2;
> > +     u64 err_misc3;
> > +};
> > +
> > +void arch_arm_ras_report_error(void);
> > +
> > +#endif       /* __ASM_RAS_H */
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index 9e7dcb2..294f602 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -19,7 +19,7 @@ obj-y                       :=3D debug-monitors.o ent=
ry.o irq.o fpsimd.o              \
> >                          return_address.o cpuinfo.o cpu_errata.o       =
       \
> >                          cpufeature.o alternative.o cacheinfo.o        =
       \
> >                          smp.o smp_spin_table.o topology.o smccc-call.o=
       \
> > -                        syscall.o
> > +                        syscall.o ras.o
>
> Given that arch_arm_ras_report_error depends on the ARM64_HAS_RAS_EXTN
> capability, which in turn depends on CONFIG_ARM64_RAS_EXTN - you should
> probably conditionally build ras.o only if CONFIG_ARM64_RAS_EXTN is defin=
ed
> (and provide a stub in the header for when it isn't defined).

Yes, I can do that.

> >=20
> >  extra-$(CONFIG_EFI)                  :=3D efi-entry.o
> >=20
> > diff --git a/arch/arm64/kernel/ras.c b/arch/arm64/kernel/ras.c
> > new file mode 100644
> > index 0000000..ca47efa
> > --- /dev/null
> > +++ b/arch/arm64/kernel/ras.c
> > @@ -0,0 +1,67 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/cpu.h>
> > +#include <linux/smp.h>
> > +
> > +#include <asm/ras.h>
> > +
> > +void arch_arm_ras_report_error(void)
> > +{
> > +     u64 num_records;
> > +     unsigned int i, cpu_num;
> > +     bool fatal =3D false;
> > +     struct ras_ext_regs regs;
> > +
> > +     if (!this_cpu_has_cap(ARM64_HAS_RAS_EXTN))
> > +             return;
> > +
> > +     cpu_num =3D get_cpu();
> > +     num_records =3D read_sysreg_s(SYS_ERRIDR_EL1);
>
> This value should be masked to exclude the reserved bits. This will
> also prevent you writing to reserved bits in ERRSELR.

True, I'll add that in the next version.

> > +
> > +     for (i =3D 0; i < num_records; i++) {
> > +             write_sysreg_s(i, SYS_ERRSELR_EL1);
>
> There should be an isb here, this will ensure the record selection has
> happened before reading the record.

I'll add that in the next version.

> > +             regs.err_status =3D read_sysreg_s(SYS_ERXSTATUS_EL1);
> > +
> > +             if (!(regs.err_status & ERR_STATUS_V))
> > +                     continue;
> > +
> > +             pr_err("CPU%u: ERR%uSTATUS: 0x%llx\n", cpu_num, i,
> > +                    regs.err_status);
> > +
> > +             if (regs.err_status & ERR_STATUS_AV) {
> > +                     regs.err_addr =3D read_sysreg_s(SYS_ERXSTATUS_EL1=
);
>
> This should be SYS_ERXADDR_EL1 not SYS_ERXSTATUS_EL1!

Oops, good catch! I missed this in testing because none=A0of the errors inj=
ected
resulted in valid address info in the system registers.

> > +                     pr_err("CPU%u: ERR%uADDR: 0x%llx\n", cpu_num, i,
> > +                            regs.err_addr);
> > +             } else
> > +                     regs.err_addr =3D 0;
>
> Or perhaps set "regs =3D { }" at the start of the function instead?

Yes, I could do that.

> > +
> > +             regs.err_fr =3D read_sysreg_s(SYS_ERXFR_EL1);
> > +             pr_err("CPU%u: ERR%uFR: 0x%llx\n", cpu_num, i, regs.err_f=
r);
> > +             regs.err_ctlr =3D read_sysreg_s(SYS_ERXCTLR_EL1);
> > +             pr_err("CPU%u: ERR%uCTLR: 0x%llx\n", cpu_num, i, regs.err=
_ctlr);
> > +
> > +             if (regs.err_status & ERR_STATUS_MV) {
> > +                     regs.err_misc0 =3D read_sysreg_s(SYS_ERXMISC0_EL1=
);
> > +                     pr_err("CPU%u: ERR%uMISC0: 0x%llx\n", cpu_num, i,
> > +                            regs.err_misc0);
> > +                     regs.err_misc1 =3D read_sysreg_s(SYS_ERXMISC1_EL1=
);
> > +                     pr_err("CPU%u: ERR%uMISC1: 0x%llx\n", cpu_num, i,
> > +                            regs.err_misc1);
> > +             }
> > +
> > +             /*
> > +              * In the future, we will treat UER conditions as potenti=
ally
> > +              * recoverable.
> > +              */
> > +             if (regs.err_status & ERR_STATUS_UE)
> > +                     fatal =3D true;
> > +
> > +             write_sysreg_s(regs.err_status, SYS_ERXSTATUS_EL1);
> > +     }
> > +
> > +     if (fatal)
> > +             panic("uncorrectable error encountered");
>
> On the do_serror path, we will already panic if arm64_is_fatal_ras_serror
> indicates uncorrectable errors. Is this here for the other paths?

This same function is called for the SEA path and also from AEST for errors
that are reported through the system register interface.

> > +
> > +     put_cpu();
> > +}
>
> Finally, should we clear the errors when we see them?

Each error is being cleared at the end of the loop above by writing the val=
ue
read from the status register back to the status register. The status regis=
ter
bits are write 1 to clear and writing back the same value that was read
guarantees that a higher priority error that occurs between the read and wr=
ite
isn't cleared.

> > diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> > index 6dba187..8d5cf99 100644
> > --- a/drivers/acpi/arm64/Kconfig
> > +++ b/drivers/acpi/arm64/Kconfig
> > @@ -8,3 +8,6 @@ config ACPI_IORT
> >=20
> >  config ACPI_GTDT
> >       bool
> > +
> > +config ACPI_AEST
> > +     bool "ARM Error Source Table Support"
> > diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> > index 6ff50f4..ea1ba28 100644
> > --- a/drivers/acpi/arm64/Makefile
> > +++ b/drivers/acpi/arm64/Makefile
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  obj-$(CONFIG_ACPI_IORT)      +=3D iort.o
> >  obj-$(CONFIG_ACPI_GTDT)      +=3D gtdt.o
> > +obj-$(CONFIG_ACPI_AEST)      +=3D aest.o
> > diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
> > new file mode 100644
> > index 0000000..fd4f3b5
> > --- /dev/null
> > +++ b/drivers/acpi/arm64/aest.c
> > @@ -0,0 +1,362 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/* ARM Error Source Table Support */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/acpi_aest.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/irq.h>
> > +#include <linux/kernel.h>
> > +#include <linux/percpu.h>
> > +#include <linux/ratelimit.h>
> > +
> > +#include <asm/ras.h>
> > +
> > +#undef pr_fmt
> > +#define pr_fmt(fmt) "ACPI AEST: " fmt
> > +
> > +static struct acpi_table_header *aest_table;
> > +
> > +static struct aest_node_data __percpu **ppi_data;
> > +static u8 num_ppi;
> > +static u8 ppi_idx;
> > +
> > +static void aest_print(struct aest_node_data *data, struct ras_ext_reg=
s regs,
> > +                    int index)
> > +{
> > +     /* No more than 2 corrected messages every 5 seconds */
> > +     static DEFINE_RATELIMIT_STATE(ratelimit_corrected, 5*HZ, 2);
> > +
> > +     if (regs.err_status & ERR_STATUS_UE ||
> > +         regs.err_status & ERR_STATUS_DE ||
> > +         __ratelimit(&ratelimit_corrected)) {
> > +             switch (data->node_type) {
> > +             case AEST_NODE_TYPE_PROC:
> > +                     pr_err("error from processor 0x%x\n",
> > +                            data->data.proc.id);
> > +                     break;
> > +             case AEST_NODE_TYPE_MEM:
> > +                     pr_err("error from memory domain 0x%x\n",
> > +                            data->data.mem.domain);
> > +                     break;
> > +             case AEST_NODE_TYPE_VENDOR:
> > +                     pr_err("error from vendor specific source 0x%x\n"=
,
> > +                            data->data.vendor.id);
> > +             }
> > +
> > +             pr_err("ERR%dSTATUS =3D 0x%llx\n", index, regs.err_status=
);
> > +             if (regs.err_status & ERR_STATUS_AV)
> > +                     pr_err("ERR%dADDR =3D 0x%llx\n", index, regs.err_=
addr);
> > +
> > +             pr_err("ERR%dFR =3D 0x%llx\n", index, regs.err_fr);
> > +             pr_err("ERR%dCTLR =3D 0x%llx\n", index, regs.err_ctlr);
> > +
> > +             if (regs.err_status & ERR_STATUS_MV) {
> > +                     pr_err("ERR%dMISC0 =3D 0x%llx\n", index, regs.err=
_misc0);
> > +                     pr_err("ERR%dMISC1 =3D 0x%llx\n", index, regs.err=
_misc1);
> > +             }
>
> Given that we have a ras_ext_regs struct, can't we use a single function =
to
> print the error - rather than have duplicate pr_err's here and in
> arch_arm_ras_report_error?

That was an option I had thought about, but I left it as is to get other
opinions. Right now the system register reporting prefixes everything with =
the
CPU number that the error occurred on...but now that I think about it more=
=A0I
could just have the print function take a prefix as a parameter. I'll unify=
 the
printing into a single function in the next version.

Thanks,
Tyler
