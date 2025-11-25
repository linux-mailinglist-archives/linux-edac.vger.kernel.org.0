Return-Path: <linux-edac+bounces-5528-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F257C83BCE
	for <lists+linux-edac@lfdr.de>; Tue, 25 Nov 2025 08:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4DE3A2133
	for <lists+linux-edac@lfdr.de>; Tue, 25 Nov 2025 07:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0B5286881;
	Tue, 25 Nov 2025 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cqS43dkb"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF3A2701D9;
	Tue, 25 Nov 2025 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056244; cv=none; b=SN2y/hzVx5PxKpn9rbm37zc9v71ojOME7CjhSSQReK0SFEbbOa5eZN8ec8rZjSrTOW979mfoagXc+cG2nde4mTkFBhKcUX0/nIXk/+w45oZHhvY16EvktxcbSIKAh8uWLkQcebDkWYI5fmhka9bRvZ8nq7jHEeZ0saHheY5LtGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056244; c=relaxed/simple;
	bh=BbmoSIykQfh52dMldlfQwveAGykFJ3zwaRK16pZP2mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4XLxwif8Q7WaqjZNEcPdaMqDuTmlPJgMza/Bpql5xp7vW7ESYHqfepl0zT/Cn1G9vT4Jj8fNZJX2ai+AsBe7HDF3KbodUf4N+B5tf6nBzz50iyzQO+u4ZfY9c3WAwjsW6s03lWKNFtftHeMC4sdfZcAY3cTALcMdvHqZasgwvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cqS43dkb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8D24340E0250;
	Tue, 25 Nov 2025 07:37:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yiwnpniwkHOp; Tue, 25 Nov 2025 07:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764056231; bh=U22VP4aqLatUWICSOnWOpVGgcJsVU0MJP+wCufIXQRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqS43dkbN6f6s0VuhYKRlN9bzEfiDsdIHHkJGzy2t4Ui95DVS1FS6I7k3qtqdde07
	 00L/X0FllewF3qptWpwdjjdhmyladN72ma9SPjw9ztuck15+xsyMCEd5nx6DhURn3H
	 kwY+AFtUZYNd/lhPkrd3BvcOC1t9ruo2bFr7TyKl2dRya5Z8/h8/WtQOV+/GSNQ5TL
	 fnwNFR31CJED2eKe1TW3/PkNRIKrK3u8RKCA2v12sg3+HcXXRbC6q/wuwaYi//5IuV
	 kVf/MKcJMOqu4rVYcDA+hIl27vjPkbOVEecgiqrAsTX4WG5hpCP0HXOqtIYAnef7Na
	 Z1oIXAtIVSJmmC8/JhfrBp9y979DBLmkRToXUH4MBhmzaOxKgPSxSITRsee2ufUvU4
	 G3+Bah+mjZ0GkVsbt/HJeGB/i/F0MqBa9NA3lFg8k35+kmoHTr9ESdvX94P3qgWwNc
	 gcoZqWlRlLjrfkUXzoO3kxSC0/sfsj0v73vFF7w+opcqCUBciCxOlMTAoxwDwKmqcz
	 tbNxbwUBgxOzQeCiCTLFtk/m/qBYD4EEFOF+U5h68acP+oDOFb8O3YU24oD3h2AP8C
	 bxKSlvdcfcfI2mzlazc7HCiPOM1XAfuRsfluj4ushL8UoDbla39Dp4HyvPFbo27b2s
	 j8eWc+r+IzEOvUDmrSiNfhY0=
Received: from zn.tnic (p57969402.dip0.t-ipconnect.de [87.150.148.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B9F0840E015B;
	Tue, 25 Nov 2025 07:36:34 +0000 (UTC)
Date: Tue, 25 Nov 2025 08:36:27 +0100
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
Subject: Re: [PATCH v13 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Message-ID: <20251125073627.GLaSVce7hBqGH1a3ni@fat_crate.local>
References: <20251121182825.237-1-shiju.jose@huawei.com>
 <20251121182825.237-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251121182825.237-2-shiju.jose@huawei.com>

On Fri, Nov 21, 2025 at 06:28:20PM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> ACPI 6.5 Specification, section 5.2.21, defined RAS2 feature table (RAS2).
> Driver adds support for RAS2 feature table, which provides interfaces for
> platform RAS features, for eg. HW-based memory scrubbing, and logical to
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
>  drivers/acpi/Kconfig  |  12 ++
>  drivers/acpi/Makefile |   1 +
>  drivers/acpi/bus.c    |   3 +
>  drivers/acpi/ras2.c   | 398 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/ras2.h   |  57 ++++++
>  5 files changed, 471 insertions(+)
>  create mode 100644 drivers/acpi/ras2.c
>  create mode 100644 include/acpi/ras2.h
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ca00a5dbcf75..bfa9f3f4def5 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -293,6 +293,18 @@ config ACPI_CPPC_LIB
>  	  If your platform does not support CPPC in firmware,
>  	  leave this option disabled.
>  
> +config ACPI_RAS2
> +	bool "ACPI RAS2 driver"
> +	select AUXILIARY_BUS
> +	select MAILBOX
> +	select PCC

Why are those select instead of depend?

> +	depends on NUMA_KEEP_MEMINFO
> +	help
> +	  This driver adds support for RAS2 feature table provides interfaces
> +	  for platform RAS features, for eg. HW-based memory scrubbing.
> +	  If your platform does not support RAS2 in firmware, leave this
> +	  option disabled.

So this driver is so niche that the majority of users want to leave it
disabled. Pls explain that in the help.

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

...

> +static int check_pcc_chan(struct ras2_sspcc *sspcc)
> +{
> +	struct acpi_ras2_shmem __iomem *gen_comm_base = sspcc->comm_addr;
> +	u32 cap_status;
> +	u16 status;
> +	int rc;
> +
> +	/*
> +	 * As per ACPI spec, the PCC space will be initialized by
								  ^
								 the

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
> +		return rc;
> +	}
> +
> +	if (status & PCC_STATUS_ERROR) {
> +		pr_warn("Error in executing last command=%d for pcc_id=%d\n",

Commands are better printed in hex, no?

IOW, "... command: 0x%x for ..."

> +			sspcc->last_cmd, sspcc->pcc_id);
> +		status &= ~PCC_STATUS_ERROR;
> +		writew_relaxed(status, &gen_comm_base->status);
> +		return -EIO;
> +	}
> +
> +	cap_status = readw_relaxed(&gen_comm_base->set_caps_status);

Is that register read always successful or you need to handle errors here too?

> +	writew_relaxed(0x0, &gen_comm_base->set_caps_status);
> +	return decode_cap_error(cap_status);
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
> +	struct ras2_sspcc *sspcc = ras2_ctx->sspcc;

No check for ras2_ctx before dereffing it? Especially if this is an exported
function.

> +	struct acpi_ras2_shmem __iomem *gen_comm_base = sspcc->comm_addr;
> +	struct mbox_chan *pcc_channel;
> +	unsigned int time_delta;
> +	int rc;
> +
> +	rc = check_pcc_chan(sspcc);
> +	if (rc < 0)
> +		return rc;
> +
> +	pcc_channel = sspcc->pcc_chan->mchan;
> +
> +	/*
> +	 * Handle the Minimum Request Turnaround Time (MRTT).
> +	 * "The minimum amount of time that OSPM must wait after the completion
> +	 * of a command before issuing the next command, in microseconds."
> +	 */
> +	if (sspcc->pcc_mrtt) {
> +		time_delta = ktime_us_delta(ktime_get(),

Remove that linebreak pls. Audit your whole code for those pls.

> +					    sspcc->last_cmd_cmpl_time);
> +		if (sspcc->pcc_mrtt > time_delta)
> +			udelay(sspcc->pcc_mrtt - time_delta);
> +	}
> +
> +	/*
> +	 * Handle the non-zero Maximum Periodic Access Rate (MPAR).
> +	 * "The maximum number of periodic requests that the subspace channel can
> +	 * support, reported in commands per minute. 0 indicates no limitation."
> +	 *
> +	 * This parameter should be ideally zero or large enough so that it can
> +	 * handle maximum number of requests that all the cores in the system can
> +	 * collectively generate. If it is not, follow the spec and just not
> +	 * send the request to the platform after hitting the MPAR limit in
> +	 * any 60s window.
> +	 */
> +	if (sspcc->pcc_mpar) {
> +		if (sspcc->mpar_count == 0) {

		if (!sspcc->mpar_count) {


> +			time_delta = ktime_ms_delta(ktime_get(),
> +						    sspcc->last_mpar_reset);
> +			if (time_delta < 60 * MSEC_PER_SEC) {
> +				dev_dbg(ras2_ctx->dev,
> +					"PCC cmd(%u) not sent due to MPAR limit",
> +					cmd);
> +				return -EIO;
> +			}
> +			sspcc->last_mpar_reset = ktime_get();
> +			sspcc->mpar_count = sspcc->pcc_mpar;
> +		}
> +		sspcc->mpar_count--;
> +	}
> +
> +	/* Write to the shared comm region */
> +	writew_relaxed(cmd, &gen_comm_base->command);
> +
> +	/* Flip CMD COMPLETE bit */
> +	writew_relaxed(0, &gen_comm_base->status);
> +
> +	/* Ring doorbell */
> +	rc = mbox_send_message(pcc_channel, &cmd);
> +	if (rc < 0) {
> +		dev_warn(ras2_ctx->dev,
> +			 "Err sending PCC mbox message. cmd:%d, rc:%d\n",

Yeah, you can say "Error". It is easier for all those dmesg greppers :)

> +			 cmd, rc);
> +		return rc;
> +	}
> +
> +	sspcc->last_cmd = cmd;
> +
> +	/*
> +	 * If Minimum Request Turnaround Time is non-zero, need
> +	 * to record the completion time of both READ and WRITE
> +	 * command for proper handling of MRTT, so need to check
> +	 * for pcc_mrtt in addition to PCC_CMD_EXEC_RAS2.

	 * If Minimum Request Turnaround Time is non-zero, need to record the
	 * completion time of both READ and WRITE command for proper handling
	 * of MRTT, so need to check for pcc_mrtt in addition to
	 * PCC_CMD_EXEC_RAS2.

Looks properly formatted to me.

> +	 */
> +	if (cmd == PCC_CMD_EXEC_RAS2 || sspcc->pcc_mrtt) {
> +		rc = check_pcc_chan(sspcc);
> +		if (sspcc->pcc_mrtt)
> +			sspcc->last_cmd_cmpl_time = ktime_get();
> +	}
> +
> +	if (pcc_channel->mbox->txdone_irq)
> +		mbox_chan_txdone(pcc_channel, rc);
> +	else
> +		mbox_client_txdone(pcc_channel, rc);
> +
> +	return rc < 0 ? rc : 0;

So you mean simply
	
	return rc;

no? rc can be 0 too so what's the point of the ternary expression?

And what's the logic here? You'd capture rc above from check_pcc_chan() and
even if it is != 0, you'd pass it into the mbox* functions? I guess that
weirdness deserves a comment...

> +}
> +EXPORT_SYMBOL_GPL(ras2_send_pcc_cmd);
> +
> +static int register_pcc_channel(struct ras2_mem_ctx *ras2_ctx, int pcc_id)
> +{
> +	struct ras2_sspcc *sspcc;
> +	struct pcc_mbox_chan *pcc_chan;
> +	struct mbox_client *mbox_cl;
> +
> +	if (pcc_id < 0)
> +		return -EINVAL;
> +
> +	sspcc = kzalloc(sizeof(*sspcc), GFP_KERNEL);
> +	if (!sspcc)
> +		return -ENOMEM;
> +
> +	mbox_cl			= &sspcc->mbox_client;
> +	mbox_cl->knows_txdone	= true;
> +
> +	pcc_chan = pcc_mbox_request_channel(mbox_cl, pcc_id);
> +	if (IS_ERR(pcc_chan)) {
> +		kfree(sspcc);
> +		return PTR_ERR(pcc_chan);
> +	}
> +
> +	sspcc->pcc_id		= pcc_id;
> +	sspcc->pcc_chan		= pcc_chan;
> +	sspcc->comm_addr	= pcc_chan->shmem;
> +	sspcc->deadline_us	= PCC_NUM_RETRIES * pcc_chan->latency;
> +	sspcc->pcc_mrtt		= pcc_chan->min_turnaround_time;
> +	sspcc->pcc_mpar		= pcc_chan->max_access_rate;
> +	sspcc->mbox_client.knows_txdone	= true;
> +	sspcc->pcc_chnl_acq	= true;
> +
> +	ras2_ctx->sspcc		= sspcc;
> +	ras2_ctx->comm_addr	= sspcc->comm_addr;
> +	ras2_ctx->dev		= pcc_chan->mchan->mbox->dev;
> +
> +	mutex_init(&sspcc->pcc_lock);
> +	ras2_ctx->pcc_lock	= &sspcc->pcc_lock;
> +
> +	return 0;
> +}
> +
> +static DEFINE_IDA(ras2_ida);
> +static void ras2_release(struct device *device)
> +{
> +	struct auxiliary_device *auxdev = to_auxiliary_dev(device);
> +	struct ras2_sspcc *sspcc;
> +	struct ras2_mem_ctx *ras2_ctx =

No ugly linebreaks like that pls.

> +		container_of(auxdev, struct ras2_mem_ctx, adev);
> +
> +	ida_free(&ras2_ida, auxdev->id);
> +	sspcc = ras2_ctx->sspcc;
> +	pcc_mbox_free_channel(sspcc->pcc_chan);
> +	kfree(sspcc);
> +	kfree(ras2_ctx);
> +}
> +
> +static struct ras2_mem_ctx *

No ugly linebreaks like that pls.

> +add_aux_device(char *name, int channel, u32 pxm_inst)
> +{
> +	struct ras2_mem_ctx *ras2_ctx;
> +	struct ras2_sspcc *sspcc;
> +	int id, rc;
> +
> +	ras2_ctx = kzalloc(sizeof(*ras2_ctx), GFP_KERNEL);
> +	if (!ras2_ctx)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ras2_ctx->sys_comp_nid = pxm_to_node(pxm_inst);

This needs to handle NUMA_NO_NODE retval.

> +	rc = register_pcc_channel(ras2_ctx, channel);
> +	if (rc < 0) {
> +		pr_debug("Failed to register pcc channel rc=%d\n", rc);

Make that error message more informative by dumping pxm_inst, channel and
whatever else would be helpful in error debugging.

> +		goto ctx_free;
> +	}
> +
> +	id = ida_alloc(&ras2_ida, GFP_KERNEL);
> +	if (id < 0) {
> +		rc = id;
> +		goto pcc_free;
> +	}
> +
> +	ras2_ctx->adev.id		= id;
> +	ras2_ctx->adev.name		= RAS2_MEM_DEV_ID_NAME;

Wouldn't it make sense to have id be part of the name? I.e.,
"acpi_ras2_mem%d" with id at the %d?


> +	ras2_ctx->adev.dev.release	= ras2_release;
> +	ras2_ctx->adev.dev.parent	= ras2_ctx->dev;
> +
> +	rc = auxiliary_device_init(&ras2_ctx->adev);
> +	if (rc)
> +		goto ida_free;
> +
> +	rc = auxiliary_device_add(&ras2_ctx->adev);
> +	if (rc) {
> +		auxiliary_device_uninit(&ras2_ctx->adev);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return ras2_ctx;
> +
> +ida_free:
> +	ida_free(&ras2_ida, id);
> +pcc_free:
> +	sspcc = ras2_ctx->sspcc;
> +	pcc_mbox_free_channel(sspcc->pcc_chan);
> +	kfree(sspcc);
> +ctx_free:
> +	kfree(ras2_ctx);
> +
> +	return ERR_PTR(rc);
> +}
> +
> +static void acpi_ras2_parse(struct acpi_table_ras2 *ras2_tab)

"parse_ras2_table"

> +{
> +	struct acpi_ras2_pcc_desc *pcc_desc_list;
> +	struct ras2_mem_ctx *ras2_ctx;
> +	u16 i, count;
> +
> +	if (ras2_tab->header.length < sizeof(*ras2_tab)) {
> +		pr_warn(FW_WARN "ACPI RAS2 table present but broken (too short, size=%u)\n",
> +			ras2_tab->header.length);
> +		return;
> +	}
> +
> +	if (!ras2_tab->num_pcc_descs) {
> +		pr_warn(FW_WARN "No PCC descs in ACPI RAS2 table\n");
> +		return;
> +	}

You need to sanity-check the number of descs so that the below allocation
doesn't go nuts.

> +
> +	struct ras2_mem_ctx **pctx_list __free(kfree) = kzalloc(ras2_tab->num_pcc_descs * sizeof(*pctx_list), GFP_KERNEL);

Function member declarations at the beginning of the function, pls, and then
you can remove this ugly linebreak too.

> +	if (!pctx_list)
> +		return;
> +
> +	count = 0;
> +	pcc_desc_list = (struct acpi_ras2_pcc_desc *)(ras2_tab + 1);
> +	for (i = 0; i < ras2_tab->num_pcc_descs; i++, pcc_desc_list++) {
> +		if (pcc_desc_list->feature_type != RAS2_FEAT_TYPE_MEMORY)
> +			continue;
> +
> +		ras2_ctx = add_aux_device(RAS2_MEM_DEV_ID_NAME,
> +					  pcc_desc_list->channel_id,
> +					  pcc_desc_list->instance);
> +		if (IS_ERR(ras2_ctx)) {
> +			pr_warn("Failed to add RAS2 auxiliary device rc=%ld\n",
> +				PTR_ERR(ras2_ctx));
> +			for (i = count; i > 0; i--)

You don't need that count var - can use i directly.

> +				auxiliary_device_uninit(&pctx_list[i - 1]->adev);
> +			return;

When you return here you have dangling pointers in that pctx_list array.

> +		}
> +		pctx_list[count++] = ras2_ctx;


Also, what's the point of that pctx_list array at all? So that you can do
uninit on the ->adev in case you encounter a failure?

> +	}
> +}
> +
> +/**
> + * acpi_ras2_init - RAS2 driver initialization function.
> + *
> + * Extracts the ACPI RAS2 table and retrieves ID for the PCC channel subspace
> + * for communicating with the ACPI compliant HW platform. Driver adds an
> + * auxiliary device, which binds to the memory ACPI RAS2 driver, for each RAS2
> + * memory feature.
> + *
> + * Returns: none.
> + */
> +void __init acpi_ras2_init(void)
> +{
> +	struct acpi_table_ras2 *ras2_tab;
> +	acpi_status status;
> +
> +	status = acpi_get_table(ACPI_SIG_RAS2, 0,
> +				(struct acpi_table_header **)&ras2_tab);
> +	if (ACPI_FAILURE(status)) {
> +		pr_err("Failed to get table, %s\n", acpi_format_exception(status));

Looks like pr_debug to me.

> +		return;
> +	}
> +
> +	acpi_ras2_parse(ras2_tab);

This function does some table sanity checking and warns. What it should do is
fail the driver load if the table is broken.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

