Return-Path: <linux-edac+bounces-4791-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB8B520EC
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 21:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B34483933
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 19:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25F82D6636;
	Wed, 10 Sep 2025 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="F8/Xzr2g"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4C299947;
	Wed, 10 Sep 2025 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532485; cv=none; b=G9CWbKta8a74oJi3Jkhdc4DvDBpMLO5U/lJgoqM3fsJWBDukqyNfTHkZFqepSHmK7/lPYlkP7kEjVdyFyTMZGzd6CgioIxeS0VWWkElT63F4hBPa6dFayDkTmMzg04txJEaXpq87Lah3C+dei9Ni7hzbv1nj44Usd/kKfJ6cA+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532485; c=relaxed/simple;
	bh=CMoRl9qBK9VjNseYbEqPncSunQ1yz6xRJrRu4IylbjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az+t0ZkRPE//8jigpQ8Z9S7nRI8fm1BAX2+/KipKtQ03VmNlXBiYN4J+1vy4UuliweVLuhrPHnaaKkcrPLUNGTb2EefXscWqYN9W/gm6Njx+FR4Q2H59ajoGFnDcYSWo2qYP9BT2tdx0vhci0IEkFcBQgVPI/vHpGIhwPzsA3jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=F8/Xzr2g reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BB4CC40E01D6;
	Wed, 10 Sep 2025 19:27:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id benkXy8vpg1c; Wed, 10 Sep 2025 19:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757532472; bh=8dOKG58Q150M1DAoaebTg3phIbhBrVVcj+SNwCxuTU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8/Xzr2gP3gwFFoZMu4BNgJBRdxg+amuYt+i9PxEpZPKFKB2E8vVUcU5Wm4/w1xNa
	 EeuITtNJc/dUZ8vIrA/4KxRn+z33/GSEAyVZbPT4Ule8cqnA9QYTjtW7jRkBRxwvEE
	 CpRLEmtFnO8ASfGsgaiRSqpTxrtvbXk0yLxcPVATG59pvTQ5WhleCLHajVo+odSoyj
	 bjrt9HMyQgwah2SaYTrh6xf61UuUbMhtdA4pZiga3QVaj7sk7w+CoKyHI6xDYJcuTa
	 Az+5EF4aq6Ble54tP3bvJ+72zAiTd4yUS4CX3Bx7x5Uqz10swvYD5fTqqRMvW1GP1G
	 IhnJ2OUi/1npJrmh3o4dWpbkQIh7ymLFsGsLqDOH/JVJGGuI8Ua+oIMU44ENLTfHDE
	 dkawrSTfHsaQYgxyTtRgpvy1b8tsiCs1sBCTmhiQA9bb2ZGN9s8LCHKOYZlUSqZK7Y
	 fzJoCzJskQiJ2NFp2HszQ2sCZCgD1prwxrTXS20fOEq8J3aWIqNXgWim/nGauXQkFL
	 sS2l1iWSkqJoVb7s9a6NGgS6H2n0Qa05qalmzmXNZoz0pDgIQ8K79w9e/KMM8a1GOo
	 yZmpcyu6XH1HmWM2iPmkpx/vbEVOHby0wwg8GbuxW6OtnCNi7QZK2parE3zFC+Ha2Q
	 bdb30aLXOK71/3xm3ghI90Gg=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 97AD840E01CD;
	Wed, 10 Sep 2025 19:27:15 +0000 (UTC)
Date: Wed, 10 Sep 2025 21:27:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org,
	jonathan.cameron@huawei.com, linuxarm@huawei.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Message-ID: <20250910192707.GAaMHRCxWx37XitN3t@fat_crate.local>
References: <20250902173043.1796-1-shiju.jose@huawei.com>
 <20250902173043.1796-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902173043.1796-2-shiju.jose@huawei.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2025 at 06:30:39PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
>=20
> Add support for ACPI RAS2 feature table (RAS2) defined in the
> ACPI 6.5 Specification, section 5.2.21.
> Driver defines RAS2 Init, which extracts the RAS2 table and driver

What is "RAS2 Init"?

$ grep -EriIn "ras2.*init" ras2.mbox=20
188:    - Rename ras2_acpi_init() to acpi_ras2_init() and modified to cal=
l acpi_ras2_init()
283:Driver defines RAS2 Init, which extracts the RAS2 table and driver
391:+   acpi_ras2_init();
410:+ * Driver contains ACPI RAS2 init, which extracts the ACPI RAS2 tabl=
e and
774:+void __init acpi_ras2_init(void)

...

I guess you mean acpi_ras2_init().

> adds auxiliary device for each memory feature which binds to the
> RAS2 memory driver.

But if you mean that, why would you explain what the patch does? That sho=
uld
be visible.

What you should explaining is the "why".

> Driver uses PCC mailbox to communicate with the ACPI HW and the
> driver adds OSPM interfaces to send RAS2 commands.

More useless "what".

> According to the ACPI specification rev 6.5, section 5.2.21.1.1
> RAS2 Platform Communication Channel Descriptor, =E2=80=9CRAS2 supports =
multiple
> PCC channels, where a channel is dedicated to a given component
> instance.=E2=80=9D Thus, RAS2 driver has been implemented to support on=
ly
> systems that comply with the specification, i.e. a dedicated PCC channe=
l
> per system component instance for communication.

Why is that paragraph here?

> ACPI specification rev 6.5, section 5.2.21.1.1 Table 5.80: RAS2 Platfor=
m
> Communication Channel Descriptor format, defines Field: Instance,
> Identifier for the system component instance that the RAS feature is
> associated with.

More word salad.
=20
> Section 5.2.21.2.1 Hardware-based Memory Scrubbing describes as
> The platform can use this feature to expose controls and capabilities
> associated with hardware-based memory scrub engines. Modern scalable
> platforms have complex memory systems with a multitude of memory
> controllers that are in turn associated with NUMA domains. It is also
> common for RAS errors related to memory to be associated with NUMA
> domains, where the NUMA domain functions as a FRU identifier. This
> feature thus provides memory scrubbing at a NUMA domain granularity.

More word salad. Why is this here at all?!

> The following are supported:
> 1. Independent memory scrubbing controls for each NUMA domain, identifi=
ed
> using its proximity domain.
> 2. Provision for background (patrol) scrubbing of the entire memory
> system, as well as on-demand scrubbing for a specific region of memory.
>=20
> Thus, the RAS2 driver requires the lowest contiguous physical memory ra=
nge
> of the memory associated with a NUMA domain when communicating with the
> firmware for memory-related features such as scrubbing. The driver uses
> the component instance ID, as defined in Table 5.80, to retrieve the
> lowest contiguous physical memory address range within the NUMA node
> and store it in the struct ras2_context to expose the address range to
> the userspace and for the communication with the firmware.

This commit message needs serious rewriting and I don't even know what it
should contain. It is a dump of random text which reads like it is trying=
 to
tell me something about this new driver but I'm failing to grok what
exactly...

> Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
> Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/acpi/Kconfig  |  12 ++
>  drivers/acpi/Makefile |   1 +
>  drivers/acpi/bus.c    |   3 +
>  drivers/acpi/ras2.c   | 389 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/ras2.h   |  63 +++++++
>  5 files changed, 468 insertions(+)
>  create mode 100644 drivers/acpi/ras2.c
>  create mode 100644 include/acpi/ras2.h
>=20
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index b594780a57d7..db21bf5a39c7 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -293,6 +293,18 @@ config ACPI_CPPC_LIB
>  	  If your platform does not support CPPC in firmware,
>  	  leave this option disabled.
> =20
> +config ACPI_RAS2
> +	bool "ACPI RAS2 driver"
> +	select AUXILIARY_BUS
> +	select MAILBOX
> +	select PCC
> +	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS

Why is this selecting crap instead of depending on the facilities it uses=
?

> +	help
> +	  The driver adds support for ACPI RAS2 feature table (extracts RAS2
> +	  table from OS system table) and OSPM interfaces to send RAS2
> +	  commands via PCC mailbox subspace. Driver adds platform device for
> +	  the RAS2 memory features which binds to the RAS2 memory driver.

This help text is useless and is throwing random abbreviations around lik=
e it
ain't no tomorrow.

Also, in all your text: use definite or indefinite articles because it re=
ads
weird otherwise.

> +
>  config ACPI_PROCESSOR
>  	tristate "Processor"
>  	depends on X86 || ARM64 || LOONGARCH || RISCV
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index d1b0affb844f..abfec6745724 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -105,6 +105,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+=3D ec_sys.o
>  obj-$(CONFIG_ACPI_BGRT)		+=3D bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)	+=3D cppc_acpi.o
>  obj-$(CONFIG_ACPI_SPCR_TABLE)	+=3D spcr.o
> +obj-$(CONFIG_ACPI_RAS2)		+=3D ras2.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) +=3D acpi_dbg.o
>  obj-$(CONFIG_ACPI_PPTT) 	+=3D pptt.o
>  obj-$(CONFIG_ACPI_PFRUT)	+=3D pfr_update.o pfr_telemetry.o
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index a984ccd4a2a0..b02ceb2837c6 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -31,6 +31,7 @@
>  #include <acpi/apei.h>
>  #include <linux/suspend.h>
>  #include <linux/prmt.h>
> +#include <acpi/ras2.h>
> =20
>  #include "internal.h"
> =20
> @@ -1474,6 +1475,8 @@ static int __init acpi_init(void)
>  	acpi_debugger_init();
>  	acpi_setup_sb_notify_handler();
>  	acpi_viot_init();
> +	acpi_ras2_init();
> +
>  	return 0;
>  }
> =20
> diff --git a/drivers/acpi/ras2.c b/drivers/acpi/ras2.c
> new file mode 100644
> index 000000000000..a17eab9eecf1
> --- /dev/null
> +++ b/drivers/acpi/ras2.c
> @@ -0,0 +1,389 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Implementation of ACPI RAS2 driver.
> + *
> + * Copyright (c) 2024-2025 HiSilicon Limited.
> + *
> + * Support for RAS2 - ACPI 6.5 Specification, section 5.2.21
> + *
> + * Driver contains ACPI RAS2 init, which extracts the ACPI RAS2 table =
and
> + * get the PCC channel subspace for communicating with the ACPI compli=
ant
> + * HW platform which supports ACPI RAS2. Driver adds auxiliary devices
> + * for each RAS2 memory feature which binds to the memory ACPI RAS2 dr=
iver.

For whom is this "text" here and what is its purpose?

It'd be more helpful if you at least explained what all those abbreviatio=
ns
meant at the top here, so that people can go find out about them if neede=
d.

> + */
> +
> +#define pr_fmt(fmt) "ACPI RAS2: " fmt
> +
> +#include <linux/delay.h>
> +#include <linux/export.h>
> +#include <linux/iopoll.h>
> +#include <linux/ktime.h>
> +#include <acpi/pcc.h>
> +#include <acpi/ras2.h>
> +
> +/**
> + * struct ras2_pcc_subspace - Data structure for PCC communication
> + * @mbox_client:	struct mbox_client object
> + * @pcc_chan:		Pointer to struct pcc_mbox_chan
> + * @comm_addr:		Pointer to RAS2 PCC shared memory region
> + * @elem:		List for registered RAS2 PCC channel subspaces
> + * @pcc_lock:		PCC lock to provide mutually exclusive access
> + *			to PCC channel subspace
> + * @deadline_us:	Poll PCC status register timeout in micro secs
> + *			for PCC command complete
> + * @pcc_mpar:		Maximum Periodic Access Rate(MPAR) for PCC channel
> + * @pcc_mrtt:		Minimum Request Turnaround Time(MRTT) in micro secs
> + *			OS must wait after completion of a PCC command before
> + *			issue next command
> + * @last_cmd_cmpl_time:	completion time of last PCC command
> + * @last_mpar_reset:	Time of last MPAR count reset
> + * @mpar_count:		MPAR count
> + * @pcc_id:		Identifier of the RAS2 platform communication channel
> + * @last_cmd:		Last PCC command
> + * @pcc_chnl_acq:	Status of PCC channel acquired
> + */
> +struct ras2_pcc_subspace {
> +	struct mbox_client		mbox_client;
> +	struct pcc_mbox_chan		*pcc_chan;
> +	struct acpi_ras2_shmem __iomem	*comm_addr;
> +	struct list_head		elem;
> +	struct mutex			pcc_lock;
> +	unsigned int			deadline_us;
> +	unsigned int			pcc_mpar;
> +	unsigned int			pcc_mrtt;
> +	ktime_t				last_cmd_cmpl_time;
> +	ktime_t				last_mpar_reset;
> +	int				mpar_count;
> +	int				pcc_id;
> +	u16				last_cmd;
> +	bool				pcc_chnl_acq;
> +};
> +
> +/*
> + * Arbitrary retries for PCC commands because the remote processor
> + * could be much slower to reply. Keeping it high enough to cover
> + * emulators where the processors run painfully slow.
> + */
> +#define RAS2_NUM_RETRIES 600ULL

Why doesn't it have "PCC" in the name then?

> +#define RAS2_FEAT_TYPE_MEMORY 0x00
> +
> +static int ras2_report_cap_error(u32 cap_status)

All static functions do not need a "ras2_" namespace.

Also, this function is not reporting anything. Function naming *is* impor=
tant.

> +{
> +	switch (cap_status) {
> +	case ACPI_RAS2_NOT_VALID:
> +	case ACPI_RAS2_NOT_SUPPORTED:
> +		return -EPERM;
> +	case ACPI_RAS2_BUSY:
> +		return -EBUSY;
> +	case ACPI_RAS2_FAILED:
> +	case ACPI_RAS2_ABORTED:
> +	case ACPI_RAS2_INVALID_DATA:
> +		return -EINVAL;
> +	default: /* 0 or other, Success */

Comments go ontop, not sideways.

And this comment is useless too.

> +		return 0;
> +	}
> +}
> +
> +static int ras2_check_pcc_chan(struct ras2_pcc_subspace *pcc_subspace)

struct ras2_pcc_subspace *sspc

or so, so that you don't have insane long lines.

> +{
> +	struct acpi_ras2_shmem __iomem *gen_comm_base =3D pcc_subspace->comm_=
addr;
> +	u32 cap_status, rc;
> +	u16 status;
> +
> +	/*
> +	 * As per ACPI spec, the PCC space will be initialized by
> +	 * platform and should have set the command completion bit when
> +	 * PCC can be used by OSPM.
> +	 *
> +	 * Poll PCC status register every 3us(delay_us) for maximum of

delay_us?

> +	 * deadline_us(timeout_us)

timeout_us?

> until PCC command complete bit is set(cond).

cond?

> +	 */
> +	rc =3D readw_relaxed_poll_timeout(&gen_comm_base->status, status,
> +					status & PCC_STATUS_CMD_COMPLETE, 3,
> +					pcc_subspace->deadline_us);
> +	if (rc) {

This function returns an int, you store it into a u32, caller checks for =
rc
< 0...

What a mess. :-(

> +		pr_warn("PCC check channel timeout for pcc_id=3D%d rc=3D%d\n",
> +			pcc_subspace->pcc_id, rc);
> +		return rc;
> +	}
> +
> +	if (status & PCC_STATUS_ERROR) {
> +		pr_warn("Error in executing last command=3D%d for pcc_id=3D%d\n",
> +			pcc_subspace->last_cmd, pcc_subspace->pcc_id);
> +		status &=3D ~PCC_STATUS_ERROR;
> +		writew_relaxed(status, &gen_comm_base->status);
> +		return -EIO;
> +	}
> +
> +	cap_status =3D readw_relaxed(&gen_comm_base->set_caps_status);
> +	writew_relaxed(0x0, &gen_comm_base->set_caps_status);
> +	return ras2_report_cap_error(cap_status);
> +}
> +
> +/**
> + * ras2_send_pcc_cmd() - Send RAS2 command via PCC channel
> + * @ras2_ctx:	pointer to the RAS2 context structure
> + * @cmd:	command to send
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd)
> +{
> +	struct ras2_pcc_subspace *pcc_subspace =3D ras2_ctx->pcc_subspace;
> +	struct acpi_ras2_shmem __iomem *gen_comm_base =3D pcc_subspace->comm_=
addr;
> +	struct mbox_chan *pcc_channel;
> +	unsigned int time_delta;
> +	int rc;
> +
> +	rc =3D ras2_check_pcc_chan(pcc_subspace);
> +	if (rc < 0)
> +		return rc;
> +
> +	pcc_channel =3D pcc_subspace->pcc_chan->mchan;
> +
> +	/*
> +	 * Handle the Minimum Request Turnaround Time(MRTT).
						     ^

In all your text: put a space before the abbreviation in brackets.


> +	 * "The minimum amount of time that OSPM must wait after the completi=
on
> +	 * of a command before issuing the next command, in microseconds."
> +	 */
> +	if (pcc_subspace->pcc_mrtt) {
> +		time_delta =3D ktime_us_delta(ktime_get(),
> +					    pcc_subspace->last_cmd_cmpl_time);
> +		if (pcc_subspace->pcc_mrtt > time_delta)
> +			udelay(pcc_subspace->pcc_mrtt - time_delta);
> +	}
> +
> +	/*
> +	 * Handle the non-zero Maximum Periodic Access Rate(MPAR).
> +	 * "The maximum number of periodic requests that the subspace channel=
 can
> +	 * support, reported in commands per minute. 0 indicates no limitatio=
n."
> +	 *
> +	 * This parameter should be ideally zero or large enough so that it c=
an
> +	 * handle maximum number of requests that all the cores in the system=
 can
> +	 * collectively generate. If it is not, we will follow the spec and j=
ust

s/we will//

> +	 * not send the request to the platform after hitting the MPAR limit =
in
> +	 * any 60s window.
> +	 */
> +	if (pcc_subspace->pcc_mpar) {
> +		if (pcc_subspace->mpar_count =3D=3D 0) {
> +			time_delta =3D ktime_ms_delta(ktime_get(),
> +						    pcc_subspace->last_mpar_reset);
> +			if (time_delta < 60 * MSEC_PER_SEC) {
> +				dev_dbg(ras2_ctx->dev,
> +					"PCC cmd not sent due to MPAR limit");

you can dump which cmd here.

> +				return -EIO;
> +			}
> +			pcc_subspace->last_mpar_reset =3D ktime_get();
> +			pcc_subspace->mpar_count =3D pcc_subspace->pcc_mpar;
> +		}
> +		pcc_subspace->mpar_count--;
> +	}
> +
> +	/* Write to the shared comm region */
> +	writew_relaxed(cmd, &gen_comm_base->command);
> +
> +	/* Flip CMD COMPLETE bit */
> +	writew_relaxed(0, &gen_comm_base->status);
> +
> +	/* Ring doorbell */
> +	rc =3D mbox_send_message(pcc_channel, &cmd);
> +	if (rc < 0) {
> +		dev_warn(ras2_ctx->dev,
> +			 "Err sending PCC mbox message. cmd:%d, rc:%d\n",
> +			 cmd, rc);
> +		return rc;
> +	}
> +
> +	pcc_subspace->last_cmd =3D cmd;
> +
> +	/*
> +	 * If Minimum Request Turnaround Time is non-zero, we need
> +	 * to record the completion time of both READ and WRITE

s/we need to//

You get the idea...

> +	 * command for proper handling of MRTT, so we need to check

s/we need to//

> +	 * for pcc_mrtt in addition to CMD_READ.
> +	 */
> +	if (cmd =3D=3D PCC_CMD_EXEC_RAS2 || pcc_subspace->pcc_mrtt) {
> +		rc =3D ras2_check_pcc_chan(pcc_subspace);
> +		if (pcc_subspace->pcc_mrtt)
> +			pcc_subspace->last_cmd_cmpl_time =3D ktime_get();
> +	}
> +
> +	if (pcc_channel->mbox->txdone_irq)
> +		mbox_chan_txdone(pcc_channel, rc);
> +	else
> +		mbox_client_txdone(pcc_channel, rc);
> +
> +	return rc < 0 ? rc : 0;
> +}
> +EXPORT_SYMBOL_GPL(ras2_send_pcc_cmd);
> +
> +static void ras2_list_pcc_release(struct ras2_pcc_subspace *pcc_subspa=
ce)
> +{
> +	pcc_mbox_free_channel(pcc_subspace->pcc_chan);
> +	kfree(pcc_subspace);
> +}
> +
> +static int ras2_register_pcc_channel(struct ras2_mem_ctx *ras2_ctx, in=
t pcc_id)
> +{
> +	struct ras2_pcc_subspace *pcc_subspace;
> +	struct pcc_mbox_chan *pcc_chan;
> +	struct mbox_client *mbox_cl;
> +
> +	if (pcc_id < 0)
> +		return -EINVAL;
> +
> +	pcc_subspace =3D kzalloc(sizeof(*pcc_subspace), GFP_KERNEL);
> +	if (!pcc_subspace)
> +		return -ENOMEM;
> +
> +	mbox_cl			=3D &pcc_subspace->mbox_client;
> +	mbox_cl->knows_txdone	=3D true;
> +
> +	pcc_chan =3D pcc_mbox_request_channel(mbox_cl, pcc_id);
> +	if (IS_ERR(pcc_chan)) {
> +		kfree(pcc_subspace);
> +		return PTR_ERR(pcc_chan);
> +	}
> +
> +	pcc_subspace->pcc_id		=3D pcc_id;
> +	pcc_subspace->pcc_chan		=3D pcc_chan;
> +	pcc_subspace->comm_addr		=3D pcc_chan->shmem;
> +	pcc_subspace->deadline_us	=3D RAS2_NUM_RETRIES * pcc_chan->latency;
> +	pcc_subspace->pcc_mrtt		=3D pcc_chan->min_turnaround_time;
> +	pcc_subspace->pcc_mpar		=3D pcc_chan->max_access_rate;
> +	pcc_subspace->mbox_client.knows_txdone	=3D true;
> +	pcc_subspace->pcc_chnl_acq	=3D true;
> +
> +	ras2_ctx->pcc_subspace	=3D pcc_subspace;
> +	ras2_ctx->comm_addr	=3D pcc_subspace->comm_addr;
> +	ras2_ctx->dev		=3D pcc_chan->mchan->mbox->dev;
> +
> +	mutex_init(&pcc_subspace->pcc_lock);
> +	ras2_ctx->pcc_lock	=3D &pcc_subspace->pcc_lock;
> +
> +	return 0;
> +}
> +
> +static DEFINE_IDA(ras2_ida);
> +static void ras2_release(struct device *device)
> +{
> +	struct auxiliary_device *auxdev =3D to_auxiliary_dev(device);
> +	struct ras2_mem_ctx *ras2_ctx =3D
> +		container_of(auxdev, struct ras2_mem_ctx, adev);
> +
> +	ida_free(&ras2_ida, auxdev->id);
> +	ras2_list_pcc_release(ras2_ctx->pcc_subspace);
> +	kfree(ras2_ctx);
> +}
> +
> +static int ras2_add_aux_device(char *name, int channel, u32 pxm_inst)
> +{
> +	unsigned long start_pfn, size_pfn;
> +	struct ras2_mem_ctx *ras2_ctx;
> +	int id, rc;
> +
> +	ras2_ctx =3D kzalloc(sizeof(*ras2_ctx), GFP_KERNEL);
> +	if (!ras2_ctx)
> +		return -ENOMEM;
> +
> +	ras2_ctx->sys_comp_nid =3D pxm_to_node(pxm_inst);

<---- newline here.

> +	/*
> +	 * Retrieve the lowest contiguous physical memory address range withi=
n
> +	 * the NUMA node.
> +	 */

Why is this requirement here?

The commit message is trying to explain it but I'm still none the wiser.

> +	start_pfn =3D node_start_pfn(ras2_ctx->sys_comp_nid);
> +	size_pfn =3D node_spanned_pages(ras2_ctx->sys_comp_nid);
> +	if (!size_pfn) {
> +		pr_debug("Failed to find phy addr range for NUMA node(%u)\n",
> +			 pxm_inst);
> +		goto ctx_free;
> +	}
> +	ras2_ctx->mem_base_addr =3D __pfn_to_phys(start_pfn);
> +	ras2_ctx->mem_size =3D __pfn_to_phys(size_pfn);
> +
> +	rc =3D ras2_register_pcc_channel(ras2_ctx, channel);
> +	if (rc < 0) {
> +		pr_debug("Failed to register pcc channel rc=3D%d\n", rc);
> +		goto ctx_free;
> +	}
> +
> +	id =3D ida_alloc(&ras2_ida, GFP_KERNEL);
> +	if (id < 0) {
> +		rc =3D id;
> +		goto ctx_free;

You just leaked pcc_subspace which ras2_register_pcc_channel() allocated.

> +	}
> +
> +	ras2_ctx->adev.id		=3D id;
> +	ras2_ctx->adev.name		=3D RAS2_MEM_DEV_ID_NAME;
> +	ras2_ctx->adev.dev.release	=3D ras2_release;
> +	ras2_ctx->adev.dev.parent	=3D ras2_ctx->dev;
> +
> +	rc =3D auxiliary_device_init(&ras2_ctx->adev);
> +	if (rc)
> +		goto ida_free;
> +
> +	rc =3D auxiliary_device_add(&ras2_ctx->adev);
> +	if (rc) {
> +		auxiliary_device_uninit(&ras2_ctx->adev);
> +		return rc;

And this leaked everything you allocated above.

> +	}
> +
> +	return 0;
> +
> +ida_free:
> +	ida_free(&ras2_ida, id);
> +ctx_free:
> +	kfree(ras2_ctx);
> +
> +	return rc;
> +}
> +
> +static int acpi_ras2_parse(struct acpi_table_ras2 *ras2_tab)
> +{
> +	struct acpi_ras2_pcc_desc *pcc_desc_list;
> +	int rc;
> +	u16 i;
> +
> +	if (ras2_tab->header.length < sizeof(*ras2_tab)) {
> +		pr_warn(FW_WARN "ACPI RAS2 table present but broken (too short #1)\n=
");

So dump the sizes to make the error message more helpful.

> +		return -EINVAL;
> +	}
> +
> +	if (!ras2_tab->num_pcc_descs) {
> +		pr_warn(FW_WARN "No PCC descs in ACPI RAS2 table\n");
> +		return -EINVAL;
> +	}
> +
> +	pcc_desc_list =3D (struct acpi_ras2_pcc_desc *)(ras2_tab + 1);
> +	for (i =3D 0; i < ras2_tab->num_pcc_descs; i++, pcc_desc_list++) {
> +		if (pcc_desc_list->feature_type !=3D RAS2_FEAT_TYPE_MEMORY)
> +			continue;
> +
> +		rc =3D ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME,
> +					 pcc_desc_list->channel_id,
> +					 pcc_desc_list->instance);
> +		if (rc)
> +			pr_warn("Failed to add RAS2 auxiliary device rc=3D%d\n", rc);

What happens with the aux devices you created successfully here? Unwind?

> +	}
> +
> +	return 0;
> +}
> +
> +void __init acpi_ras2_init(void)
> +{
> +	struct acpi_table_ras2 *ras2_tab;
> +	acpi_status status;
> +
> +	status =3D acpi_get_table(ACPI_SIG_RAS2, 0,
> +				(struct acpi_table_header **)&ras2_tab);
> +	if (ACPI_FAILURE(status)) {
> +		pr_err("Failed to get table, %s\n", acpi_format_exception(status));
> +		return;
> +	}
> +
> +	if (acpi_ras2_parse(ras2_tab))
> +		pr_err("Failed to parse RAS2 table\n");

No need for that print if you issue warns above.

> +
> +	acpi_put_table((struct acpi_table_header *)ras2_tab);
> +}

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

