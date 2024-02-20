Return-Path: <linux-edac+bounces-625-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716FE85BDC5
	for <lists+linux-edac@lfdr.de>; Tue, 20 Feb 2024 14:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD059B21945
	for <lists+linux-edac@lfdr.de>; Tue, 20 Feb 2024 13:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BFD6EB42;
	Tue, 20 Feb 2024 13:53:25 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958AB6BB42;
	Tue, 20 Feb 2024 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437205; cv=none; b=k3Avu+jobY8+GrUIcsAyZjlZlfRjUYyuBMPAXW7+yMkF1nZIaNlIIaGz+4jb55lWE5iK/5QY8EZBZBgFCwp/S8mQDBbRpJWXbw69/iCes6juH00jWLKZ7pWxnzTdFJsfTXr5qw5ORp8ZNnE/88FbUWd1pGZXJPDLP1PvEfyCvIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437205; c=relaxed/simple;
	bh=mOcQ1ei2nx6VkXOx0kdlSVUlXssfZ1EaN5SX/ZmJuPE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBPO380Ij2wp06VFrJRzclFH8tUS30cHLL5gdUFjPVtqCPlQ139GM+WkcLMgBHIsFysIOWwn35Uw3Y0y+z0Mamk2zF72qiwYgcFIq/wd0HJZ8DdM5mi12Rul89IgyEYl43MY5AAicRnUTcQbpGYXDUoyxkwc76QP/Fje6ZWCSn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TfLNt5wz2z687Yd;
	Tue, 20 Feb 2024 21:49:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 88ADD140B30;
	Tue, 20 Feb 2024 21:53:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 13:53:17 +0000
Date: Tue, 20 Feb 2024 13:53:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>
Subject: Re: [RFC PATCH v6 09/12] ACPI:RASF: Add common library for RASF and
 RAS2 PCC interfaces
Message-ID: <20240220135316.00000874@Huawei.com>
In-Reply-To: <20240215111455.1462-10-shiju.jose@huawei.com>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
	<20240215111455.1462-10-shiju.jose@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 19:14:51 +0800
<shiju.jose@huawei.com> wrote:

> From: A Somasundaram <somasundaram.a@hpe.com>
> 
> The code contains PCC interfaces for RASF and RAS2 table, functions to send
> RASF commands as per ACPI 5.1 and RAS2 commands as per ACPI 6.5 & upwards
> revision.
> 
> References for this implementation,
> ACPI specification 6.5, section 5.2.20 for RASF table, section 5.2.21 for RAS2
> table and chapter 14 for PCC (Platform Communication Channel).
> 
> Driver uses PCC interfaces to communicate to the ACPI HW.
> This code implements PCC interfaces and the functions to send the RASF/RAS2
> commands to be used by OSPM.
> 
> Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
> Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

I looked at this in depth a while back so this time a quicker review. Just some
trivial stuff inline.

> diff --git a/drivers/acpi/rasf_acpi_common.c b/drivers/acpi/rasf_acpi_common.c
> new file mode 100755
> index 000000000000..3ee34f5d12d3
> --- /dev/null
> +++ b/drivers/acpi/rasf_acpi_common.c
> @@ -0,0 +1,272 @@

...

> +
> +#include <linux/export.h>
> +#include <linux/delay.h>
> +#include <linux/ktime.h>
> +#include <linux/platform_device.h>
> +#include <acpi/rasf_acpi.h>
> +#include <acpi/acpixf.h>
> +
> +static int rasf_check_pcc_chan(struct rasf_context *rasf_ctx)
> +{
> +	int ret = -EIO;
> +	struct acpi_rasf_shared_memory  __iomem *generic_comm_base = rasf_ctx->pcc_comm_addr;
> +	ktime_t next_deadline = ktime_add(ktime_get(), rasf_ctx->deadline);
> +
> +	while (!ktime_after(ktime_get(), next_deadline)) {
> +		/*
> +		 * As per ACPI spec, the PCC space wil be initialized by
> +		 * platform and should have set the command completion bit when
> +		 * PCC can be used by OSPM
> +		 */
> +		if (readw_relaxed(&generic_comm_base->status) & RASF_PCC_CMD_COMPLETE) {
> +			ret = 0;

			return 0;

> +			break;
> +		}
> +		/*
> +		 * Reducing the bus traffic in case this loop takes longer than
> +		 * a few retries.
> +		 */
> +		udelay(10);
> +	}
> +
> +	return ret;

return -EIO;

> +}
> +
> +/**
> + * rasf_send_pcc_cmd() - Send RASF command via PCC channel
> + * @rasf_ctx:	pointer to the rasf context structure
> + * @cmd:	command to send
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +int rasf_send_pcc_cmd(struct rasf_context *rasf_ctx, u16 cmd)
> +{
> +	int ret = -EIO;

Looks like it's overwritten in all paths where ret is used.

> +	struct acpi_rasf_shared_memory  *generic_comm_base =
> +		(struct acpi_rasf_shared_memory *)rasf_ctx->pcc_comm_addr;
> +	static ktime_t last_cmd_cmpl_time, last_mpar_reset;
> +	static int mpar_count;
> +	unsigned int time_delta;
> +
> +	if (cmd == RASF_PCC_CMD_EXEC) {
> +		ret = rasf_check_pcc_chan(rasf_ctx);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Handle the Minimum Request Turnaround Time(MRTT)
> +	 * "The minimum amount of time that OSPM must wait after the completion
> +	 * of a command before issuing the next command, in microseconds"
> +	 */
> +	if (rasf_ctx->pcc_mrtt) {
> +		time_delta = ktime_us_delta(ktime_get(), last_cmd_cmpl_time);
> +		if (rasf_ctx->pcc_mrtt > time_delta)
> +			udelay(rasf_ctx->pcc_mrtt - time_delta);
> +	}
> +
> +	/*
> +	 * Handle the non-zero Maximum Periodic Access Rate(MPAR)
> +	 * "The maximum number of periodic requests that the subspace channel can
> +	 * support, reported in commands per minute. 0 indicates no limitation."
> +	 *
> +	 * This parameter should be ideally zero or large enough so that it can
> +	 * handle maximum number of requests that all the cores in the system can
> +	 * collectively generate. If it is not, we will follow the spec and just
> +	 * not send the request to the platform after hitting the MPAR limit in
> +	 * any 60s window
> +	 */
> +	if (rasf_ctx->pcc_mpar) {
> +		if (mpar_count == 0) {
> +			time_delta = ktime_ms_delta(ktime_get(), last_mpar_reset);
> +			if (time_delta < 60 * MSEC_PER_SEC) {
> +				pr_debug("PCC cmd not sent due to MPAR limit");
> +				return -EIO;
> +			}
> +			last_mpar_reset = ktime_get();
> +			mpar_count = rasf_ctx->pcc_mpar;
> +		}
> +		mpar_count--;
> +	}
> +
> +	/* Write to the shared comm region. */
> +	writew_relaxed(cmd, &generic_comm_base->command);
> +
> +	/* Flip CMD COMPLETE bit */
> +	writew_relaxed(0, &generic_comm_base->status);
> +
> +	/* Ring doorbell */
> +	ret = mbox_send_message(rasf_ctx->pcc_channel, &cmd);
> +	if (ret < 0) {
> +		pr_err("Err sending PCC mbox message. cmd:%d, ret:%d\n",
> +				cmd, ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * For READs we need to ensure the cmd completed to ensure
> +	 * the ensuing read()s can proceed. For WRITEs we dont care
> +	 * because the actual write()s are done before coming here
> +	 * and the next READ or WRITE will check if the channel
> +	 * is busy/free at the entry of this call.
> +	 *
> +	 * If Minimum Request Turnaround Time is non-zero, we need
> +	 * to record the completion time of both READ and WRITE
> +	 * command for proper handling of MRTT, so we need to check
> +	 * for pcc_mrtt in addition to CMD_READ
> +	 */
> +	if (cmd == RASF_PCC_CMD_EXEC || rasf_ctx->pcc_mrtt) {
> +		ret = rasf_check_pcc_chan(rasf_ctx);
> +		if (rasf_ctx->pcc_mrtt)
> +			last_cmd_cmpl_time = ktime_get();
> +	}
> +
> +	if (rasf_ctx->pcc_channel->mbox->txdone_irq)
> +		mbox_chan_txdone(rasf_ctx->pcc_channel, ret);
> +	else
> +		mbox_client_txdone(rasf_ctx->pcc_channel, ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rasf_send_pcc_cmd);
> +
> +/**
> + * rasf_register_pcc_channel() - Register PCC channel
> + * @rasf_ctx:	pointer to the rasf context structure
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +int rasf_register_pcc_channel(struct rasf_context *rasf_ctx)
> +{
> +	u64 usecs_lat;
> +	unsigned int len;
> +	struct pcc_mbox_chan *pcc_chan;
> +	struct mbox_client *rasf_mbox_cl;
> +	struct acpi_pcct_hw_reduced *rasf_ss;
> +
> +	rasf_mbox_cl = &rasf_ctx->mbox_client;
> +	if (!rasf_mbox_cl || rasf_ctx->pcc_subspace_idx < 0)
> +		return -EINVAL;
> +
> +	pcc_chan = pcc_mbox_request_channel(rasf_mbox_cl,
> +				rasf_ctx->pcc_subspace_idx);
> +
> +	if (IS_ERR(pcc_chan)) {
> +		pr_err("Failed to find PCC channel for subspace %d\n",
> +		       rasf_ctx->pcc_subspace_idx);
> +		return -ENODEV;
> +	}
> +	rasf_ctx->pcc_chan = pcc_chan;

If you are storing the chan, why do we need to sparately
store mchan?

> +	rasf_ctx->pcc_channel = pcc_chan->mchan;
> +	/*
> +	 * The PCC mailbox controller driver should
> +	 * have parsed the PCCT (global table of all
> +	 * PCC channels) and stored pointers to the
> +	 * subspace communication region in con_priv.
> +	 */
> +	rasf_ss = rasf_ctx->pcc_channel->con_priv;
> +
> +	if (!rasf_ss) {
> +		pr_err("No PCC subspace found for RASF\n");
> +		pcc_mbox_free_channel(rasf_ctx->pcc_chan);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * This is the shared communication region
> +	 * for the OS and Platform to communicate over.
> +	 */
> +	rasf_ctx->comm_base_addr = rasf_ss->base_address;
> +	len = rasf_ss->length;
> +	pr_debug("PCC subspace for RASF=0x%llx len=%d\n",
> +		  rasf_ctx->comm_base_addr, len);

dev_dbg(rasf_ctx->dev ...

throughout probably better.

> +
> +	/*
> +	 * rasf_ss->latency is just a Nominal value. In reality
> +	 * the remote processor could be much slower to reply.
> +	 * So add an arbitrary amount of wait on top of Nominal.
> +	 */
> +	usecs_lat = RASF_NUM_RETRIES * rasf_ss->latency;
> +	rasf_ctx->deadline = ns_to_ktime(usecs_lat * NSEC_PER_USEC);
> +	rasf_ctx->pcc_mrtt = rasf_ss->min_turnaround_time;
> +	rasf_ctx->pcc_mpar = rasf_ss->max_access_rate;
> +	rasf_ctx->pcc_comm_addr = acpi_os_ioremap(rasf_ctx->comm_base_addr, len);
> +	pr_debug("pcc_comm_addr=%p\n", rasf_ctx->pcc_comm_addr);
> +
> +	/* Set flag so that we dont come here for each CPU. */
> +	rasf_ctx->pcc_channel_acquired = true;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(rasf_register_pcc_channel);

> +/**
> + * rasf_add_platform_device() - Add a platform device for RASF
> + * @name:	name of the device we're adding
> + * @data:	platform specific data for this platform device
> + * @size:	size of platform specific data
> + *
> + * Returns: pointer to platform device on success, an error otherwise

I wonder if we should just rename this to ras2 and ignore the fact
it came form rasf?

> + */
> +struct platform_device *rasf_add_platform_device(char *name, const void *data,
> +						 size_t size)
> +{
> +	int ret;
> +	struct platform_device *pdev;
> +
> +	pdev = platform_device_alloc(name, PLATFORM_DEVID_AUTO);
> +	if (!pdev)
> +		return NULL;
> +
> +	ret = platform_device_add_data(pdev, data, size);
> +	if (ret)
> +		goto dev_put;
> +
> +	ret = platform_device_add(pdev);
> +	if (ret)
> +		goto dev_put;
> +
> +	return pdev;
> +
> +dev_put:
> +	platform_device_put(pdev);
> +
> +	return NULL;
Could return an error pointer to provide more info from ret?

> +}
> diff --git a/include/acpi/rasf_acpi.h b/include/acpi/rasf_acpi.h
> new file mode 100644
> index 000000000000..aa4f935b28cf
> --- /dev/null
> +++ b/include/acpi/rasf_acpi.h
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * RASF driver header file
> + *
> + * (C) Copyright 2014, 2015 Hewlett-Packard Enterprises
> + *
> + * Copyright (c) 2023 HiSilicon Limited
> + */
> +
> +#ifndef _RASF_ACPI_H
> +#define _RASF_ACPI_H
> +
> +#include <linux/acpi.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/types.h>
> +#include <acpi/pcc.h>
> +
> +#define RASF_PCC_CMD_COMPLETE 1
> +
> +/* RASF specific PCC commands */
> +#define RASF_PCC_CMD_EXEC 0x01
> +
> +#define RASF_FAILURE 0
> +#define RASF_SUCCESS 1
> +
> +/*
> + * Arbitrary Retries for PCC commands.

Perhaps a comment on why PCC retry might be needed?

> + */
> +#define RASF_NUM_RETRIES 600
> +
> +/*
> + * Data structures for PCC communication and RASF table
> + */
> +struct rasf_context {
> +	struct device *dev;
> +	int id;
> +	struct mbox_client mbox_client;
> +	struct mbox_chan *pcc_channel;
> +	struct pcc_mbox_chan *pcc_chan;
> +	void __iomem *pcc_comm_addr;
> +	u64 comm_base_addr;
> +	int pcc_subspace_idx;
> +	bool pcc_channel_acquired;
> +	ktime_t deadline;
Perhaps move all the pcc channel specific stuff to a named struct

	struct {
		unsigned int mpar;
		unsigned int mrtt;
	} pcc;

> +	unsigned int pcc_mpar;
> +	unsigned int pcc_mrtt;
> +	spinlock_t spinlock; /* Lock to provide mutually exclusive access to PCC channel */

Move comment to line above. Saves on long line without loss of readability.

> +	struct device *scrub_dev;
> +	const struct rasf_hw_scrub_ops *ops;
> +};


