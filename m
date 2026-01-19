Return-Path: <linux-edac+bounces-5653-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE900D3A6A3
	for <lists+linux-edac@lfdr.de>; Mon, 19 Jan 2026 12:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ECA3301D0C7
	for <lists+linux-edac@lfdr.de>; Mon, 19 Jan 2026 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58A62DA77E;
	Mon, 19 Jan 2026 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UI6BANsZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AA22D1916;
	Mon, 19 Jan 2026 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821482; cv=none; b=YKNoaz5Nkj96Arj50nMR7UNPk8TSUsxb9UZoj8ZVxz2CD6OV1wfQNpIbIMvcn9xCLJxeTBWXcGMftbndy7OJUM7lttMbgQeqmWDot6rEmXsjkItyfnWKwixIDaOM5uMK2BlfcxgVb/MulZhvgEZXPi/59x4tACoZB2smmAr4V1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821482; c=relaxed/simple;
	bh=XPLMKJ0mPRa+3xpcMU7T9MlRs9O0Q34i6inAof+61m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCV0L5yeCuNDgQE6PLckcJcJd8zbRKVO+urMtqSybJEUEUzbyNX7dLB+J/9lCDjuayjrtMBnsuZpC8xJ9FfO7gVGgSYsEpgIrshAQOdvGOcZDU4UCAlbN0OxxcvNTzB6ZrbJ/khyDTyqSyMwaf33UK268ankmXabbVtDKyNFkQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UI6BANsZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B103240E019B;
	Mon, 19 Jan 2026 11:17:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hzHadV7cM7xx; Mon, 19 Jan 2026 11:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768821466; bh=TAX0hP36wyQvHEnz9i/MFLh0hu4HHRH7RkC1l5jU0s4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UI6BANsZJms/cMsQyx9NI0WajdfSiKOsXcvVS8AdbyQxwHurE1TnCzdtYtPha8Q1J
	 NMiIZdUfX7gmnPpCM30UwyL1kGlYxq5AgSjTA+dIeJGflAkuFOOPw37cfMUD5aH2a/
	 zSMKMnJOTSOcWUEfwCiO/F6iB5P5khgSCCaYrt+dpnZCR9CZnlBA3W2fBzu2zHf9h7
	 EIwhJxC2/vPPeJOYqeiAOHFJP93C2Xr0Dsvp6iASvtQ/kt3uOqxwmK7ne60A/ViqYR
	 mktEibnHEE7OefjMLILpo26O4abbErxLwKKY6yk/Nj4d1zf2N/Ut7PlGyNl/aVO1Y2
	 CgctK4pHRdvWvxcO1v2TvUYtgU2urGxJDbTavLgCsEd7GnGS9ecZ7jC86UyXrD0Kia
	 19VFNH3KoGE7Am3YFoPwvAkEECKYIorWwDH4FsxFpBIBwBm+rAGyZ0aa6UAeDGP6vi
	 pUuKljxcPVvMaq0Ao0w32gKjwElLwRblDhgPQ8InU3Kw6Gj/zrUh1t5iHLBlrL1y9K
	 kaIpTS6RwNDv5tdeHLmayCMJGbpQ9oYlqA1j8qACBBzdYceFOsAMo4g9XfU5YU9N85
	 JzbKFz0bVZNsYlwctUpoWE5/RgYZvEWkIwQsfwBSUDcrOc5FzMCBi9o47ZGa/jsSGo
	 bol7Lf4Gh4l1k2KL44R7ScSI=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B933C40E0028;
	Mon, 19 Jan 2026 11:17:08 +0000 (UTC)
Date: Mon, 19 Jan 2026 12:17:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org,
	rdunlap@infradead.org, jonathan.cameron@huawei.com,
	linuxarm@huawei.com, rientjes@google.com, jiaqiyan@google.com,
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
Subject: Re: [PATCH v15 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Message-ID: <20260119111701.GBaW4Sres045xnfkpz@fat_crate.local>
References: <20260115143101.876-1-shiju.jose@huawei.com>
 <20260115143101.876-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115143101.876-2-shiju.jose@huawei.com>

On Thu, Jan 15, 2026 at 02:30:58PM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> ACPI 6.5 Specification, section 5.2.21, defined RAS2 feature table (RAS2).
> Driver adds support for RAS2 feature table, which provides interfaces for
> platform RAS features, e.g., for HW-based memory scrubbing, and logical to
> PA translation service. RAS2 uses PCC channel subspace for communicating
> with the ACPI compliant HW platform.
> 
> Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
> Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/acpi/Kconfig  |  10 +
>  drivers/acpi/Makefile |   1 +
>  drivers/acpi/bus.c    |   3 +
>  drivers/acpi/ras2.c   | 414 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/ras2.h   |  57 ++++++
>  5 files changed, 485 insertions(+)
>  create mode 100644 drivers/acpi/ras2.c
>  create mode 100644 include/acpi/ras2.h
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ca00a5dbcf75..7f846c22fc30 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -293,6 +293,16 @@ config ACPI_CPPC_LIB
>  	  If your platform does not support CPPC in firmware,
>  	  leave this option disabled.
>  
> +config ACPI_RAS2
> +	bool "ACPI RAS2 driver"
> +	select AUXILIARY_BUS
> +	depends on MAILBOX
> +	depends on PCC
> +	help
> +	  This driver adds support for RAS2 feature table provides interfaces
> +	  for platform RAS features, e.g., for HW-based memory scrubbing.
> +	  Say 'y/n' to enable/disable ACPI RAS2 support.
> +
>  config ACPI_PROCESSOR
>  	tristate "Processor"
>  	depends on X86 || ARM64 || LOONGARCH || RISCV
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index d1b0affb844f..abfec6745724 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -105,6 +105,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
>  obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>  obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
> +obj-$(CONFIG_ACPI_RAS2)		+= ras2.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>  obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
>  obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index a984ccd4a2a0..b02ceb2837c6 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -31,6 +31,7 @@
>  #include <acpi/apei.h>
>  #include <linux/suspend.h>
>  #include <linux/prmt.h>
> +#include <acpi/ras2.h>
>  
>  #include "internal.h"
>  
> @@ -1474,6 +1475,8 @@ static int __init acpi_init(void)
>  	acpi_debugger_init();
>  	acpi_setup_sb_notify_handler();
>  	acpi_viot_init();
> +	acpi_ras2_init();
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/acpi/ras2.c b/drivers/acpi/ras2.c
> new file mode 100644
> index 000000000000..f27676e61a9c
> --- /dev/null
> +++ b/drivers/acpi/ras2.c
> @@ -0,0 +1,414 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ACPI RAS2 feature table driver.
> + *
> + * Copyright (c) 2024-2025 HiSilicon Limited.
> + *
> + * Support for RAS2 table - ACPI 6.5 Specification, section 5.2.21, which
> + * provides interfaces for platform RAS features, e.g., for HW-based memory
> + * scrubbing, and logical to PA translation service. RAS2 uses PCC channel
> + * subspace for communicating with the ACPI compliant HW platform.
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
> + * struct ras2_sspcc - Data structure for PCC communication
> + * @mbox_client:	struct mbox_client object
> + * @pcc_chan:		Pointer to struct pcc_mbox_chan
> + * @comm_addr:		Pointer to RAS2 PCC shared memory region
> + * @pcc_lock:		PCC lock to provide mutually exclusive access
> + *			to PCC channel subspace
> + * @deadline_us:	Poll PCC status register timeout in micro secs
> + *			for PCC command complete
> + * @pcc_mpar:		Maximum Periodic Access Rate (MPAR) for PCC channel
> + * @pcc_mrtt:		Minimum Request Turnaround Time (MRTT) in micro secs
> + *			OS must wait after completion of a PCC command before
> + *			issue next command
> + * @last_cmd_cmpl_time:	completion time of last PCC command
> + * @last_mpar_reset:	Time of last MPAR count reset
> + * @mpar_count:		MPAR count
> + * @pcc_id:		Identifier of the RAS2 platform communication channel
> + * @last_cmd:		Last PCC command
> + * @pcc_chnl_acq:	Status of PCC channel acquired
> + */
> +struct ras2_sspcc {
> +	struct mbox_client		mbox_client;
> +	struct pcc_mbox_chan		*pcc_chan;
> +	struct acpi_ras2_shmem __iomem	*comm_addr;
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
> +#define PCC_NUM_RETRIES 600ULL
> +
> +#define RAS2_MAX_NUM_PCC_DESCS 100
> +#define RAS2_FEAT_TYPE_MEMORY 0x00
> +
> +static int decode_cap_error(u32 cap_status)
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
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int check_pcc_chan(struct ras2_sspcc *sspcc)
> +{
> +	struct acpi_ras2_shmem __iomem *gen_comm_base = sspcc->comm_addr;
> +	u16 status;
> +	int rc;
> +
> +	/*
> +	 * As per ACPI spec, the PCC space will be initialized by
> +	 * platform and should have set the command completion bit when
> +	 * PCC can be used by OSPM.
> +	 *
> +	 * Poll PCC status register every 3us for maximum of 600ULL * PCC
> +	 * channel latency until PCC command complete bit is set.
> +	 */
> +	rc = readw_relaxed_poll_timeout(&gen_comm_base->status, status,
> +					status & PCC_STATUS_CMD_COMPLETE, 3,
> +					sspcc->deadline_us);
> +	if (rc) {
> +		pr_warn("PCC check channel timeout for pcc_id=%d rc=%d\n",
> +			sspcc->pcc_id, rc);

I'll stop here. This version still doesn't address comments from here:

https://lore.kernel.org/r/20251125073627.GLaSVce7hBqGH1a3ni@fat_crate.local

so I'll wait for a new one which has everything addressed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

