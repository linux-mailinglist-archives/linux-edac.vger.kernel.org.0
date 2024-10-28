Return-Path: <linux-edac+bounces-2316-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 334519B2EBD
	for <lists+linux-edac@lfdr.de>; Mon, 28 Oct 2024 12:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8161C21C50
	for <lists+linux-edac@lfdr.de>; Mon, 28 Oct 2024 11:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CB51DE3DF;
	Mon, 28 Oct 2024 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CK3gJwuD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F61DE2B0;
	Mon, 28 Oct 2024 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114260; cv=none; b=CG3lAZDKUKh5w9dsKRZDqQttVZ49DJQd4bCVI1locKMxIiApmReVqsCeX9doS73y/2LymkBUkcnHnBsUBceoga32EJoSemLBihez15whaDzKlykzOER47Q8Ab4a9I9Ij6QUWESkv39eek6K9JrYUbSjNxXRNSYYhNuLDcu2uyAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114260; c=relaxed/simple;
	bh=nI0ZCe9B8XTcVwbcRJwTIt3xdf75VCwrbvkULJxMMy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGlz1TOAaclPqUvVpydguOySdHGpLLcc1tCqSuPH7sKQvqpkZSuJPjnfbfbCIQRHUiSGw/8e49pRw9gAazLQtp5yvCY95b6Mhidv5oU1ecMEYGE5d19vv9W0zEcdHtYkHoHOnuIIJw7bCAVxGacIO6BnYbeyDuX6irMdKKFBcgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CK3gJwuD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A16B940E0198;
	Mon, 28 Oct 2024 11:17:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YWBf7PxV-zBo; Mon, 28 Oct 2024 11:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730114249; bh=aQXjtMdPxcXQFLTjo1thwq4DHI1V42PctDkGBJnF/+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CK3gJwuDuQBnlCE3o4SDY3/5iCsHbLCzO+vHjzamHleWqt+WYcO69bJsAASLHJC2q
	 ti8RqEMlzOcv7Ux5ntYx8kAML4pLXzsvb1YxnYJuPspbRxqXKEl1mTguckHzn3Sl+G
	 AUHvfxed+jn0CulXbHZq8twP4W+uDZ5sleZ5pW0W1X7mnBjwyRtIIukyWwhovog2yS
	 CSNAQldYCihVxHRyGcn2WyWSLfnZEUdry5qSIp4KwlU141nOaW1S1/5p2g5/rYpXuf
	 GyS6fOrlsWBGJAtd2wyQaVU4d+ZpRSZhlR3VpvXPRYkDHtPqaSbydAaHh5lwxHgBXu
	 r9Xaf8d4tUDu7AyY54XoyTP/42bt7WCv1lgLY2pRdnCW2LNHfJeCVVMbeuqDOH3Nil
	 vwgVyFBnSnB30uEfmEnTPEfCKjeM5p1Hc25hHnxPxf3MumAXCK2HYpvFiT/dtI3CGf
	 Ij8WVjFgHfEicgmitayL1N2E4FueQgJWMU6bAq6j2QKwK8oSI4kpYM1c655qNxMpgS
	 M8MTk1nUUCYSigSBEV2G629H1aOll/cax7kFcWBvmw0wY6R+cdqyB5/RvI3OjlTFjF
	 uxPYhCQUrHlx2jzyO49OBSQGkvavl+8FNIhfdobnAPlb8WaRUPASwogUjvYM84LJf1
	 TbrkOTRm3H3ec7oEOYG7tTfw=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 26F0C40E01A5;
	Mon, 28 Oct 2024 11:16:43 +0000 (UTC)
Date: Mon, 28 Oct 2024 12:16:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, gregkh@linuxfoundation.org,
	sudeep.holla@arm.com, jassisinghbrar@gmail.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, david@redhat.com,
	Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	linuxarm@huawei.com
Subject: Re: [PATCH v14 03/14] EDAC: Add ECS control feature
Message-ID: <20241028111637.GSZx9yleFPOjTklIVr@fat_crate.local>
References: <20241025171356.1377-1-shiju.jose@huawei.com>
 <20241025171356.1377-4-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025171356.1377-4-shiju.jose@huawei.com>

On Fri, Oct 25, 2024 at 06:13:44PM +0100, shiju.jose@huawei.com wrote:
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/log_entry_type
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The log entry type of how the DDR5 ECS log is reported.
> +		00b - per DRAM.
> +		01b - per memory media FRU.

If the conversion function here is kstrtoul(), why are those values not "0"
and "1" but in binary format?

> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/log_entry_type_per_dram
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) True if current log entry type is per DRAM.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/log_entry_type_per_memory_media
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) True if current log entry type is per memory media FRU.

What's the point of those two if log_entry_type already gives you the same
info?

And the filename length is a bit too much...

> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/mode
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The mode of how the DDR5 ECS counts the errors.
> +		0 - ECS counts rows with errors.
> +		1 - ECS counts codewords with errors.

Now we have "0" and "1"s. Oh well.

What are "rows", what are "codewords"? Explain them here pls for the user.

> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/mode_counts_rows
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) True if current mode is ECS counts rows with errors.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/mode_counts_codewords
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) True if current mode is ECS counts codewords with errors.

Same question as above - redundant files.

> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/reset
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(WO) ECS reset ECC counter.
> +		1 - reset ECC counter to the default value.

1 or any value?

Looks like any to me...

You should restrict it to "1" in case you want to extend this interface with
"2" in the future, for example, doing something a bit different.

> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/threshold
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) ECS threshold count per gigabits of memory cells.

That definitely needs more explanation.

> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 188501e676c7..b24c2c112d9c 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
>  
>  edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
>  edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
> -edac_core-y	+= scrub.o
> +edac_core-y	+= scrub.o ecs.o
>  
>  edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
>  
> diff --git a/drivers/edac/ecs.c b/drivers/edac/ecs.c
> new file mode 100755
> index 000000000000..a2b64d7bf6b6
> --- /dev/null
> +++ b/drivers/edac/ecs.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic ECS driver in order to support control the on die
> + * error check scrub (e.g. DDR5 ECS).

This sentence needs grammar check.

> The common sysfs ECS
> + * interface abstracts the control of an arbitrary ECS
> + * functionality to a common set of functions.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + */
> +

#undef pr_fmt

> +#define pr_fmt(fmt)     "EDAC ECS: " fmt

Grep the tree for examples how to do that properly.

Also, this pr_fmt looks unused.

> +static umode_t ecs_attr_visible(struct kobject *kobj, struct attribute *a, int attr_id)
> +{
> +	struct device *ras_feat_dev = kobj_to_dev(kobj);
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;
> +
> +	switch (attr_id) {
> +	case ECS_LOG_ENTRY_TYPE:
> +		if (ops->get_log_entry_type)  {
> +			if (ops->set_log_entry_type)
> +				return a->mode;
> +			else
> +				return 0444;

What is the goal for the access mode of all those sysfs entries? I sure hope
it is going to be root-only no-matter what. I don't want normal users to cause
scrub activity. Please make sure your whole set does that.

> +		}
> +		break;
> +	case ECS_LOG_ENTRY_TYPE_PER_DRAM:
> +		if (ops->get_log_entry_type_per_dram)
> +			return a->mode;
> +		break;
> +	case ECS_LOG_ENTRY_TYPE_PER_MEMORY_MEDIA:
> +		if (ops->get_log_entry_type_per_memory_media)
> +			return a->mode;
> +		break;
> +	case ECS_MODE:
> +		if (ops->get_mode) {
> +			if (ops->set_mode)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case ECS_MODE_COUNTS_ROWS:
> +		if (ops->get_mode_counts_rows)
> +			return a->mode;
> +		break;
> +	case ECS_MODE_COUNTS_CODEWORDS:
> +		if (ops->get_mode_counts_codewords)
> +			return a->mode;
> +		break;
> +	case ECS_RESET:
> +		if (ops->reset)
> +			return a->mode;
> +		break;
> +	case ECS_THRESHOLD:
> +		if (ops->get_threshold) {
> +			if (ops->set_threshold)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +#define EDAC_ECS_ATTR_RO(_name, _fru_id)       \
> +	((struct edac_ecs_dev_attr) { .dev_attr = __ATTR_RO(_name), \
> +				     .fru_id = _fru_id })
> +
> +#define EDAC_ECS_ATTR_WO(_name, _fru_id)       \
> +	((struct edac_ecs_dev_attr) { .dev_attr = __ATTR_WO(_name), \
> +				     .fru_id = _fru_id })
> +
> +#define EDAC_ECS_ATTR_RW(_name, _fru_id)       \
> +	((struct edac_ecs_dev_attr) { .dev_attr = __ATTR_RW(_name), \
> +				     .fru_id = _fru_id })
> +
> +static int ecs_create_desc(struct device *ecs_dev,
> +			   const struct attribute_group **attr_groups, u16 num_media_frus)
> +{
> +	struct edac_ecs_context *ecs_ctx;
> +	u32 fru;
> +
> +	ecs_ctx = devm_kzalloc(ecs_dev, sizeof(*ecs_ctx), GFP_KERNEL);
> +	if (!ecs_ctx)
> +		return -ENOMEM;
> +
> +	ecs_ctx->num_media_frus = num_media_frus;
> +	ecs_ctx->fru_ctxs = devm_kcalloc(ecs_dev, num_media_frus,
> +					 sizeof(*ecs_ctx->fru_ctxs),
> +					 GFP_KERNEL);
> +	if (!ecs_ctx->fru_ctxs)
> +		return -ENOMEM;
> +
> +	for (fru = 0; fru < num_media_frus; fru++) {
> +		struct edac_ecs_fru_context *fru_ctx = &ecs_ctx->fru_ctxs[fru];
> +		struct attribute_group *group = &fru_ctx->group;
> +		int i;
> +
> +		fru_ctx->ecs_dev_attr[ECS_LOG_ENTRY_TYPE] = EDAC_ECS_ATTR_RW(log_entry_type, fru);
> +		fru_ctx->ecs_dev_attr[ECS_LOG_ENTRY_TYPE_PER_DRAM] =
> +					EDAC_ECS_ATTR_RO(log_entry_type_per_dram, fru);
> +		fru_ctx->ecs_dev_attr[ECS_LOG_ENTRY_TYPE_PER_MEMORY_MEDIA] =
> +					EDAC_ECS_ATTR_RO(log_entry_type_per_memory_media, fru);
> +		fru_ctx->ecs_dev_attr[ECS_MODE] = EDAC_ECS_ATTR_RW(mode, fru);
> +		fru_ctx->ecs_dev_attr[ECS_MODE_COUNTS_ROWS] =
> +					EDAC_ECS_ATTR_RO(mode_counts_rows, fru);
> +		fru_ctx->ecs_dev_attr[ECS_MODE_COUNTS_CODEWORDS] =
> +					EDAC_ECS_ATTR_RO(mode_counts_codewords, fru);
> +		fru_ctx->ecs_dev_attr[ECS_RESET] = EDAC_ECS_ATTR_WO(reset, fru);
> +		fru_ctx->ecs_dev_attr[ECS_THRESHOLD] = EDAC_ECS_ATTR_RW(threshold, fru);

Clearly too long variable and define names. Shorten pls.

Also, a new line here:

<---


> +		for (i = 0; i < ECS_MAX_ATTRS; i++)
> +			fru_ctx->ecs_attrs[i] = &fru_ctx->ecs_dev_attr[i].dev_attr.attr;
> +
> +		sprintf(fru_ctx->name, "%s%d", EDAC_ECS_FRU_NAME, fru);
> +		group->name = fru_ctx->name;
> +		group->attrs = fru_ctx->ecs_attrs;
> +		group->is_visible  = ecs_attr_visible;
> +
> +		attr_groups[fru] = group;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * edac_ecs_get_desc - get EDAC ECS descriptors
> + * @ecs_dev: client device, supports ECS feature
> + * @attr_groups: pointer to attribute group container
> + * @num_media_frus: number of media FRUs in the device
> + *
> + * Return:
> + *  * %0	- Success.
> + *  * %-EINVAL	- Invalid parameters passed.
> + *  * %-ENOMEM	- Dynamic memory allocation failed.
> + */
> +int edac_ecs_get_desc(struct device *ecs_dev,
> +		      const struct attribute_group **attr_groups, u16 num_media_frus)
> +{
> +	if (!ecs_dev || !attr_groups || !num_media_frus)
> +		return -EINVAL;
> +
> +	return ecs_create_desc(ecs_dev, attr_groups, num_media_frus);
> +}
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 91552271b34a..5fc3ec7f25eb 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -626,6 +626,9 @@ int edac_dev_register(struct device *parent, char *name,
>  			attr_gcnt++;
>  			scrub_cnt++;
>  			break;
> +		case RAS_FEAT_ECS:
> +			attr_gcnt += ras_features[feat].ecs_info.num_media_frus;
> +			break;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -667,6 +670,18 @@ int edac_dev_register(struct device *parent, char *name,
>  			scrub_inst++;
>  			attr_gcnt++;
>  			break;
> +		case RAS_FEAT_ECS:
> +			if (!ras_features->ecs_ops)
> +				goto data_mem_free;

<---- newline here.

> +			dev_data = &ctx->ecs;
> +			dev_data->ecs_ops = ras_features->ecs_ops;
> +			dev_data->private = ras_features->ctx;
> +			ret = edac_ecs_get_desc(parent, &ras_attr_groups[attr_gcnt],
> +						ras_features->ecs_info.num_media_frus);
> +			if (ret)
> +				goto data_mem_free;

Ditto.

> +			attr_gcnt += ras_features->ecs_info.num_media_frus;
> +			break;
>  		default:
>  			ret = -EINVAL;
>  			goto data_mem_free;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

