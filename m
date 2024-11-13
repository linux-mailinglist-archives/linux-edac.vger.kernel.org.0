Return-Path: <linux-edac+bounces-2524-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E639C6E80
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 13:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D6E28164C
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 12:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C00E201108;
	Wed, 13 Nov 2024 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLIzLkgU"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4411FF5E5;
	Wed, 13 Nov 2024 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498984; cv=none; b=TXMbgP7ujRSvUIbDtwDCr4b5V+I3Us+CwzsyxXKiOT6suZ12kqkD+bz34kvs5EKtXd1OmAw/Px81/Ed9OsbaN2D2CxfRci8HFqfnS8g4FM/bT+GUzURWI9eqYRENLPE2unIphgKe0x5iMAErCBzfcR9Cg3GuK7Ar0Cni9jhmxaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498984; c=relaxed/simple;
	bh=bj6Pq1JkxSQiYBVm6C/s64k31YTcj2EWBqFW0Nv0Lh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkciF//Os8J4D8IafpwgpFF26vvKDgaaWE656j80VlVUL/9wxBhoxK3JsntK72hFnqvL1Ebu1lgNxwllwCKvOVOxsCBs8fovSmS/fc0C/ilhusEsSPG+ZOuVyBSn7Aif2vhp3aPE5IuKm39erCHzS1RtnoI0fB3gSAIvrqUy5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLIzLkgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DB5C4CEE5;
	Wed, 13 Nov 2024 11:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731498983;
	bh=bj6Pq1JkxSQiYBVm6C/s64k31YTcj2EWBqFW0Nv0Lh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pLIzLkgUaVH5wq8sI/2lBHxo96NXw3HwMvL/ZYfO0C31X75VmgoTM6RPv9E54DKpM
	 CsNVCJlmHUk1hwkymZXuT0NMlfJxR97WVVUCtZrf+gDKYQc4BBNmKE5qkOM3yUuWxa
	 2kzc1Shq5/W7Pos/0sKvAubHNS8ld0gTaMjkGupbFbELLKY091HYexbMo2ItjOy+ZF
	 sGRozpcGYccc59IQRkN9OWgwlNMqu1bLr2ZHPNOKmQPDt85IMjwlc/08KtfMZqVWWt
	 vh0uhqmOUJO8JGz3z9KR3IJOOUD4HkcB2y0z49EjKY6prQUi9Es+C1bLE/inqb3fL/
	 LPU37mPJomSPA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ee1e04776cso3152788eaf.0;
        Wed, 13 Nov 2024 03:56:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOJ+ABXDl70/Bq112RXbqpfFIvRdnA//VkabNQbNQ0kv0+HAjRqZrmUJRe/pXS5zcBmIqF9C8+sTAh@vger.kernel.org, AJvYcCXZ7XftsQ8cRrSD/ypjaDQHWHEwsZOnNSsz2OtH13HKnILWzIg6Ixwvk9nPB6w7KuGqJ9+XJ3XNJXtsd6Py@vger.kernel.org, AJvYcCXaSnFj1sh6LlcwnX7+x5UQyN7Be6MGu/s87qfVZcKRpPu0c6DgzlMK8nwMYQMGOW60ZRXPMQ3pfgm7@vger.kernel.org
X-Gm-Message-State: AOJu0YzOaRuwC7N0EBrLmt4XBXdRQEOz9DcV6JXiZHWeVxLz6Nb1o/3t
	HaehQ6g9hkDgsl+IG0wiA18DxVi8KB8Dvwq7bgFpwfwtNEHJ0CqryOSzJaWA6di8UKRPeewiorD
	+oUdeuCPF8x5nYF6f9fa2w9PZwBs=
X-Google-Smtp-Source: AGHT+IFa/Q3ZQZXyx9X6wH4VllB04SA24i6k06h17l141Y3FNaDLgcwSS871b4aeE4fK4T/OD9oxNGKI7KBLt9E+ELA=
X-Received: by 2002:a05:6820:4b06:b0:5e8:35c:3401 with SMTP id
 006d021491bc7-5ee9224c074mr2067478eaf.6.1731498982630; Wed, 13 Nov 2024
 03:56:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101091735.1465-1-shiju.jose@huawei.com> <20241101091735.1465-10-shiju.jose@huawei.com>
In-Reply-To: <20241101091735.1465-10-shiju.jose@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Nov 2024 12:56:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jEPS5tSznrN-NfRJG+z9sXPcZVLiArkVvw2apScdLkEQ@mail.gmail.com>
Message-ID: <CAJZ5v0jEPS5tSznrN-NfRJG+z9sXPcZVLiArkVvw2apScdLkEQ@mail.gmail.com>
Subject: Re: [PATCH v15 09/15] ACPI:RAS2: Add ACPI RAS2 driver
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bp@alien8.de, tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org, 
	mchehab@kernel.org, dan.j.williams@intel.com, dave@stgolabs.net, 
	jonathan.cameron@huawei.com, gregkh@linuxfoundation.org, sudeep.holla@arm.com, 
	jassisinghbrar@gmail.com, dave.jiang@intel.com, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, david@redhat.com, 
	Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com, 
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com, 
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, james.morse@arm.com, 
	jthoughton@google.com, somasundaram.a@hpe.com, erdemaktas@google.com, 
	pgonda@google.com, duenwen@google.com, gthelen@google.com, 
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com, 
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com, tanxiaofei@huawei.com, 
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com, 
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 10:18=E2=80=AFAM <shiju.jose@huawei.com> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>
> Add support for ACPI RAS2 feature table (RAS2) defined in the
> ACPI 6.5 Specification, section 5.2.21.
> Driver contains RAS2 Init, which extracts the RAS2 table and driver
> adds auxiliary device for each memory feature which binds to the
> RAS2 memory driver.
>
> Driver uses PCC mailbox to communicate with the ACPI HW and the
> driver adds OSPM interfaces to send RAS2 commands.
>
> Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
> Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

In case my ACK on this is needed

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and please route this along with the rest of the series.

Thanks!


> ---
>  drivers/acpi/Kconfig     |  11 ++
>  drivers/acpi/Makefile    |   1 +
>  drivers/acpi/ras2.c      | 409 +++++++++++++++++++++++++++++++++++++++
>  include/acpi/ras2_acpi.h |  45 +++++
>  4 files changed, 466 insertions(+)
>  create mode 100755 drivers/acpi/ras2.c
>  create mode 100644 include/acpi/ras2_acpi.h
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index d67f63d93b2a..ceae55704a14 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -284,6 +284,17 @@ config ACPI_CPPC_LIB
>           If your platform does not support CPPC in firmware,
>           leave this option disabled.
>
> +config ACPI_RAS2
> +       bool "ACPI RAS2 driver"
> +       select AUXILIARY_BUS
> +       select MAILBOX
> +       select PCC
> +       help
> +         The driver adds support for ACPI RAS2 feature table(extracts RA=
S2
> +         table from OS system table) and OSPM interfaces to send RAS2
> +         commands via PCC mailbox subspace. Driver adds platform device =
for
> +         the RAS2 memory features which binds to the RAS2 memory driver.
> +
>  config ACPI_PROCESSOR
>         tristate "Processor"
>         depends on X86 || ARM64 || LOONGARCH || RISCV
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 61ca4afe83dc..84e2a2519bae 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -100,6 +100,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)       +=3D ec_sys.o
>  obj-$(CONFIG_ACPI_BGRT)                +=3D bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)    +=3D cppc_acpi.o
>  obj-$(CONFIG_ACPI_SPCR_TABLE)  +=3D spcr.o
> +obj-$(CONFIG_ACPI_RAS2)                +=3D ras2.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) +=3D acpi_dbg.o
>  obj-$(CONFIG_ACPI_PPTT)        +=3D pptt.o
>  obj-$(CONFIG_ACPI_PFRUT)       +=3D pfr_update.o pfr_telemetry.o
> diff --git a/drivers/acpi/ras2.c b/drivers/acpi/ras2.c
> new file mode 100755
> index 000000000000..56ad7667ce81
> --- /dev/null
> +++ b/drivers/acpi/ras2.c
> @@ -0,0 +1,409 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Implementation of ACPI RAS2 driver.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + *
> + * Support for RAS2 - ACPI 6.5 Specification, section 5.2.21
> + *
> + * Driver contains ACPI RAS2 init, which extracts the ACPI RAS2 table an=
d
> + * get the PCC channel subspace for communicating with the ACPI complian=
t
> + * HW platform which supports ACPI RAS2. Driver adds platform devices
> + * for each RAS2 memory feature which binds to the memory ACPI RAS2 driv=
er.
> + */
> +
> +#define pr_fmt(fmt)    "ACPI RAS2: " fmt
> +
> +#include <linux/delay.h>
> +#include <linux/export.h>
> +#include <linux/ktime.h>
> +#include <linux/platform_device.h>
> +#include <acpi/pcc.h>
> +#include <acpi/ras2_acpi.h>
> +
> +/* Data structure for PCC communication */
> +struct ras2_pcc_subspace {
> +       int pcc_subspace_id;
> +       struct mbox_client mbox_client;
> +       struct pcc_mbox_chan *pcc_chan;
> +       struct acpi_ras2_shared_memory __iomem *pcc_comm_addr;
> +       bool pcc_channel_acquired;
> +       ktime_t deadline;
> +       unsigned int pcc_mpar;
> +       unsigned int pcc_mrtt;
> +       struct list_head elem;
> +       u16 ref_count;
> +};
> +
> +/*
> + * Arbitrary Retries for PCC commands because the
> + * remote processor could be much slower to reply.
> + */
> +#define RAS2_NUM_RETRIES 600
> +
> +#define RAS2_FEATURE_TYPE_MEMORY        0x00
> +
> +/* global variables for the RAS2 PCC subspaces */
> +static DEFINE_MUTEX(ras2_pcc_subspace_lock);
> +static LIST_HEAD(ras2_pcc_subspaces);
> +
> +static int ras2_report_cap_error(u32 cap_status)
> +{
> +       switch (cap_status) {
> +       case ACPI_RAS2_NOT_VALID:
> +       case ACPI_RAS2_NOT_SUPPORTED:
> +               return -EPERM;
> +       case ACPI_RAS2_BUSY:
> +               return -EBUSY;
> +       case ACPI_RAS2_FAILED:
> +       case ACPI_RAS2_ABORTED:
> +       case ACPI_RAS2_INVALID_DATA:
> +               return -EINVAL;
> +       default: /* 0 or other, Success */
> +               return 0;
> +       }
> +}
> +
> +static int ras2_check_pcc_chan(struct ras2_pcc_subspace *pcc_subspace)
> +{
> +       struct acpi_ras2_shared_memory __iomem *generic_comm_base =3D pcc=
_subspace->pcc_comm_addr;
> +       ktime_t next_deadline =3D ktime_add(ktime_get(), pcc_subspace->de=
adline);
> +       u32 cap_status;
> +       u16 status;
> +       u32 ret;
> +
> +       while (!ktime_after(ktime_get(), next_deadline)) {
> +               /*
> +                * As per ACPI spec, the PCC space will be initialized by
> +                * platform and should have set the command completion bi=
t when
> +                * PCC can be used by OSPM
> +                */
> +               status =3D readw_relaxed(&generic_comm_base->status);
> +               if (status & RAS2_PCC_CMD_ERROR) {
> +                       cap_status =3D readw_relaxed(&generic_comm_base->=
set_capabilities_status);
> +                       ret =3D ras2_report_cap_error(cap_status);
> +
> +                       status &=3D ~RAS2_PCC_CMD_ERROR;
> +                       writew_relaxed(status, &generic_comm_base->status=
);
> +                       return ret;
> +               }
> +               if (status & RAS2_PCC_CMD_COMPLETE)
> +                       return 0;
> +               /*
> +                * Reducing the bus traffic in case this loop takes longe=
r than
> +                * a few retries.
> +                */
> +               msleep(10);
> +       }
> +
> +       return -EIO;
> +}
> +
> +/**
> + * ras2_send_pcc_cmd() - Send RAS2 command via PCC channel
> + * @ras2_ctx:  pointer to the RAS2 context structure
> + * @cmd:       command to send
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd)
> +{
> +       struct ras2_pcc_subspace *pcc_subspace =3D ras2_ctx->pcc_subspace=
;
> +       struct acpi_ras2_shared_memory *generic_comm_base =3D pcc_subspac=
e->pcc_comm_addr;
> +       static ktime_t last_cmd_cmpl_time, last_mpar_reset;
> +       struct mbox_chan *pcc_channel;
> +       unsigned int time_delta;
> +       static int mpar_count;
> +       int ret;
> +
> +       guard(mutex)(&ras2_pcc_subspace_lock);
> +       ret =3D ras2_check_pcc_chan(pcc_subspace);
> +       if (ret < 0)
> +               return ret;
> +       pcc_channel =3D pcc_subspace->pcc_chan->mchan;
> +
> +       /*
> +        * Handle the Minimum Request Turnaround Time(MRTT)
> +        * "The minimum amount of time that OSPM must wait after the comp=
letion
> +        * of a command before issuing the next command, in microseconds"
> +        */
> +       if (pcc_subspace->pcc_mrtt) {
> +               time_delta =3D ktime_us_delta(ktime_get(), last_cmd_cmpl_=
time);
> +               if (pcc_subspace->pcc_mrtt > time_delta)
> +                       udelay(pcc_subspace->pcc_mrtt - time_delta);
> +       }
> +
> +       /*
> +        * Handle the non-zero Maximum Periodic Access Rate(MPAR)
> +        * "The maximum number of periodic requests that the subspace cha=
nnel can
> +        * support, reported in commands per minute. 0 indicates no limit=
ation."
> +        *
> +        * This parameter should be ideally zero or large enough so that =
it can
> +        * handle maximum number of requests that all the cores in the sy=
stem can
> +        * collectively generate. If it is not, we will follow the spec a=
nd just
> +        * not send the request to the platform after hitting the MPAR li=
mit in
> +        * any 60s window
> +        */
> +       if (pcc_subspace->pcc_mpar) {
> +               if (mpar_count =3D=3D 0) {
> +                       time_delta =3D ktime_ms_delta(ktime_get(), last_m=
par_reset);
> +                       if (time_delta < 60 * MSEC_PER_SEC) {
> +                               dev_dbg(ras2_ctx->dev,
> +                                       "PCC cmd not sent due to MPAR lim=
it");
> +                               return -EIO;
> +                       }
> +                       last_mpar_reset =3D ktime_get();
> +                       mpar_count =3D pcc_subspace->pcc_mpar;
> +               }
> +               mpar_count--;
> +       }
> +
> +       /* Write to the shared comm region. */
> +       writew_relaxed(cmd, &generic_comm_base->command);
> +
> +       /* Flip CMD COMPLETE bit */
> +       writew_relaxed(0, &generic_comm_base->status);
> +
> +       /* Ring doorbell */
> +       ret =3D mbox_send_message(pcc_channel, &cmd);
> +       if (ret < 0) {
> +               dev_err(ras2_ctx->dev,
> +                       "Err sending PCC mbox message. cmd:%d, ret:%d\n",
> +                       cmd, ret);
> +               return ret;
> +       }
> +
> +       /*
> +        * If Minimum Request Turnaround Time is non-zero, we need
> +        * to record the completion time of both READ and WRITE
> +        * command for proper handling of MRTT, so we need to check
> +        * for pcc_mrtt in addition to CMD_READ
> +        */
> +       if (cmd =3D=3D RAS2_PCC_CMD_EXEC || pcc_subspace->pcc_mrtt) {
> +               ret =3D ras2_check_pcc_chan(pcc_subspace);
> +               if (pcc_subspace->pcc_mrtt)
> +                       last_cmd_cmpl_time =3D ktime_get();
> +       }
> +
> +       if (pcc_channel->mbox->txdone_irq)
> +               mbox_chan_txdone(pcc_channel, ret);
> +       else
> +               mbox_client_txdone(pcc_channel, ret);
> +
> +       return ret >=3D 0 ? 0 : ret;
> +}
> +EXPORT_SYMBOL_GPL(ras2_send_pcc_cmd);
> +
> +static int ras2_register_pcc_channel(struct ras2_mem_ctx *ras2_ctx, int =
pcc_subspace_id)
> +{
> +       struct ras2_pcc_subspace *pcc_subspace;
> +       struct acpi_pcct_hw_reduced *ras2_ss;
> +       struct pcc_mbox_chan *pcc_chan;
> +       struct mbox_client *mbox_cl;
> +
> +       if (pcc_subspace_id < 0)
> +               return -EINVAL;
> +
> +       mutex_lock(&ras2_pcc_subspace_lock);
> +       list_for_each_entry(pcc_subspace, &ras2_pcc_subspaces, elem) {
> +               if (pcc_subspace->pcc_subspace_id =3D=3D pcc_subspace_id)=
 {
> +                       ras2_ctx->pcc_subspace =3D pcc_subspace;
> +                       pcc_subspace->ref_count++;
> +                       mutex_unlock(&ras2_pcc_subspace_lock);
> +                       return 0;
> +               }
> +       }
> +       mutex_unlock(&ras2_pcc_subspace_lock);
> +
> +       pcc_subspace =3D kcalloc(1, sizeof(*pcc_subspace), GFP_KERNEL);
> +       if (!pcc_subspace)
> +               return -ENOMEM;
> +       mbox_cl =3D &pcc_subspace->mbox_client;
> +       mbox_cl->knows_txdone =3D true;
> +
> +       pcc_chan =3D pcc_mbox_request_channel(mbox_cl, pcc_subspace_id);
> +       if (IS_ERR(pcc_chan)) {
> +               kfree(pcc_subspace);
> +               return PTR_ERR(pcc_chan);
> +       }
> +       ras2_ss =3D pcc_chan->mchan->con_priv;
> +       *pcc_subspace =3D (struct ras2_pcc_subspace) {
> +               .pcc_subspace_id =3D pcc_subspace_id,
> +               .pcc_chan =3D pcc_chan,
> +               .pcc_comm_addr =3D acpi_os_ioremap(ras2_ss->base_address,
> +                                                ras2_ss->length),
> +               .deadline =3D ns_to_ktime(RAS2_NUM_RETRIES *
> +                                       ras2_ss->latency *
> +                                       NSEC_PER_USEC),
> +               .pcc_mrtt =3D ras2_ss->min_turnaround_time,
> +               .pcc_mpar =3D ras2_ss->max_access_rate,
> +               .mbox_client =3D {
> +                       .knows_txdone =3D true,
> +               },
> +               .pcc_channel_acquired =3D true,
> +       };
> +       mutex_lock(&ras2_pcc_subspace_lock);
> +       list_add(&pcc_subspace->elem, &ras2_pcc_subspaces);
> +       pcc_subspace->ref_count++;
> +       mutex_unlock(&ras2_pcc_subspace_lock);
> +       ras2_ctx->pcc_subspace =3D pcc_subspace;
> +       ras2_ctx->pcc_comm_addr =3D pcc_subspace->pcc_comm_addr;
> +       ras2_ctx->dev =3D pcc_chan->mchan->mbox->dev;
> +
> +       return 0;
> +}
> +
> +static DEFINE_IDA(ras2_ida);
> +static void ras2_remove_pcc(struct ras2_mem_ctx *ras2_ctx)
> +{
> +       struct ras2_pcc_subspace *pcc_subspace =3D ras2_ctx->pcc_subspace=
;
> +
> +       guard(mutex)(&ras2_pcc_subspace_lock);
> +       if (pcc_subspace->ref_count > 0)
> +               pcc_subspace->ref_count--;
> +       if (!pcc_subspace->ref_count) {
> +               list_del(&pcc_subspace->elem);
> +               pcc_mbox_free_channel(pcc_subspace->pcc_chan);
> +               kfree(pcc_subspace);
> +       }
> +}
> +
> +static void ras2_release(struct device *device)
> +{
> +       struct auxiliary_device *auxdev =3D container_of(device, struct a=
uxiliary_device, dev);
> +       struct ras2_mem_ctx *ras2_ctx =3D container_of(auxdev, struct ras=
2_mem_ctx, adev);
> +
> +       ida_free(&ras2_ida, auxdev->id);
> +       ras2_remove_pcc(ras2_ctx);
> +       kfree(ras2_ctx);
> +}
> +
> +static struct ras2_mem_ctx *ras2_add_aux_device(char *name, int channel)
> +{
> +       struct ras2_mem_ctx *ras2_ctx;
> +       int id, ret;
> +
> +       ras2_ctx =3D kzalloc(sizeof(*ras2_ctx), GFP_KERNEL);
> +       if (!ras2_ctx)
> +               return ERR_PTR(-ENOMEM);
> +
> +       mutex_init(&ras2_ctx->lock);
> +
> +       ret =3D ras2_register_pcc_channel(ras2_ctx, channel);
> +       if (ret < 0) {
> +               pr_debug("failed to register pcc channel ret=3D%d\n", ret=
);
> +               goto ctx_free;
> +       }
> +
> +       id =3D ida_alloc(&ras2_ida, GFP_KERNEL);
> +       if (id < 0) {
> +               ret =3D id;
> +               goto pcc_free;
> +       }
> +       ras2_ctx->id =3D id;
> +       ras2_ctx->adev.id =3D id;
> +       ras2_ctx->adev.name =3D RAS2_MEM_DEV_ID_NAME;
> +       ras2_ctx->adev.dev.release =3D ras2_release;
> +       ras2_ctx->adev.dev.parent =3D ras2_ctx->dev;
> +
> +       ret =3D auxiliary_device_init(&ras2_ctx->adev);
> +       if (ret)
> +               goto ida_free;
> +
> +       ret =3D auxiliary_device_add(&ras2_ctx->adev);
> +       if (ret) {
> +               auxiliary_device_uninit(&ras2_ctx->adev);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return ras2_ctx;
> +
> +ida_free:
> +       ida_free(&ras2_ida, id);
> +pcc_free:
> +       ras2_remove_pcc(ras2_ctx);
> +ctx_free:
> +       kfree(ras2_ctx);
> +       return ERR_PTR(ret);
> +}
> +
> +static int __init ras2_acpi_init(void)
> +{
> +       struct acpi_table_header *pAcpiTable =3D NULL;
> +       struct acpi_ras2_pcc_desc *pcc_desc_list;
> +       struct acpi_table_ras2 *pRas2Table;
> +       struct ras2_mem_ctx *ras2_ctx;
> +       int pcc_subspace_id;
> +       acpi_size ras2_size;
> +       acpi_status status;
> +       u8 count =3D 0, i;
> +       int ret =3D 0;
> +
> +       status =3D acpi_get_table("RAS2", 0, &pAcpiTable);
> +       if (ACPI_FAILURE(status) || !pAcpiTable) {
> +               pr_err("ACPI RAS2 driver failed to initialize, get table =
failed\n");
> +               return -EINVAL;
> +       }
> +
> +       ras2_size =3D pAcpiTable->length;
> +       if (ras2_size < sizeof(struct acpi_table_ras2)) {
> +               pr_err("ACPI RAS2 table present but broken (too short #1)=
\n");
> +               ret =3D -EINVAL;
> +               goto free_ras2_table;
> +       }
> +
> +       pRas2Table =3D (struct acpi_table_ras2 *)pAcpiTable;
> +       if (pRas2Table->num_pcc_descs <=3D 0) {
> +               pr_err("ACPI RAS2 table does not contain PCC descriptors\=
n");
> +               ret =3D -EINVAL;
> +               goto free_ras2_table;
> +       }
> +
> +       pcc_desc_list =3D (struct acpi_ras2_pcc_desc *)(pRas2Table + 1);
> +       /* Double scan for the case of only one actual controller */
> +       pcc_subspace_id =3D -1;
> +       count =3D 0;
> +       for (i =3D 0; i < pRas2Table->num_pcc_descs; i++, pcc_desc_list++=
) {
> +               if (pcc_desc_list->feature_type !=3D RAS2_FEATURE_TYPE_ME=
MORY)
> +                       continue;
> +               if (pcc_subspace_id =3D=3D -1) {
> +                       pcc_subspace_id =3D pcc_desc_list->channel_id;
> +                       count++;
> +               }
> +               if (pcc_desc_list->channel_id !=3D pcc_subspace_id)
> +                       count++;
> +       }
> +       /*
> +        * Workaround for the client platform with multiple scrub devices
> +        * but uses single PCC subspace for communication.
> +        */
> +       if (count =3D=3D 1) {
> +               /* Add auxiliary device and bind ACPI RAS2 memory driver =
*/
> +               ras2_ctx =3D ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME, pc=
c_subspace_id);
> +               if (IS_ERR(ras2_ctx)) {
> +                       ret =3D PTR_ERR(ras2_ctx);
> +                       goto free_ras2_table;
> +               }
> +               acpi_put_table(pAcpiTable);
> +               return 0;
> +       }
> +
> +       pcc_desc_list =3D (struct acpi_ras2_pcc_desc *)(pRas2Table + 1);
> +       count =3D 0;
> +       for (i =3D 0; i < pRas2Table->num_pcc_descs; i++, pcc_desc_list++=
) {
> +               if (pcc_desc_list->feature_type !=3D RAS2_FEATURE_TYPE_ME=
MORY)
> +                       continue;
> +               pcc_subspace_id =3D pcc_desc_list->channel_id;
> +               /* Add auxiliary device and bind ACPI RAS2 memory driver =
*/
> +               ras2_ctx =3D ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME, pc=
c_subspace_id);
> +               if (IS_ERR(ras2_ctx)) {
> +                       ret =3D PTR_ERR(ras2_ctx);
> +                       goto free_ras2_table;
> +               }
> +       }
> +
> +free_ras2_table:
> +       acpi_put_table(pAcpiTable);
> +       return ret;
> +}
> +late_initcall(ras2_acpi_init)
> diff --git a/include/acpi/ras2_acpi.h b/include/acpi/ras2_acpi.h
> new file mode 100644
> index 000000000000..7b32407ae2af
> --- /dev/null
> +++ b/include/acpi/ras2_acpi.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * RAS2 ACPI driver header file
> + *
> + * (C) Copyright 2014, 2015 Hewlett-Packard Enterprises
> + *
> + * Copyright (c) 2024 HiSilicon Limited
> + */
> +
> +#ifndef _RAS2_ACPI_H
> +#define _RAS2_ACPI_H
> +
> +#include <linux/acpi.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +#define RAS2_PCC_CMD_COMPLETE  BIT(0)
> +#define RAS2_PCC_CMD_ERROR     BIT(2)
> +
> +/* RAS2 specific PCC commands */
> +#define RAS2_PCC_CMD_EXEC 0x01
> +
> +#define RAS2_AUX_DEV_NAME "ras2"
> +#define RAS2_MEM_DEV_ID_NAME "acpi_ras2_mem"
> +
> +/* Data structure RAS2 table */
> +struct ras2_mem_ctx {
> +       struct auxiliary_device adev;
> +       /* Lock to provide mutually exclusive access to PCC channel */
> +       struct mutex lock;
> +       int id;
> +       u8 instance;
> +       bool bg;
> +       u64 base, size;
> +       u8 scrub_cycle_hrs, min_scrub_cycle, max_scrub_cycle;
> +       struct device *dev;
> +       struct device *scrub_dev;
> +       void *pcc_subspace;
> +       struct acpi_ras2_shared_memory __iomem *pcc_comm_addr;
> +};
> +
> +int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd);
> +#endif /* _RAS2_ACPI_H */
> --
> 2.34.1
>

