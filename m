Return-Path: <linux-edac+bounces-2885-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAED7A0BCF0
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2025 17:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A792C3A770D
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2025 16:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E4B20AF78;
	Mon, 13 Jan 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhRuLy+e"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925901C5D77;
	Mon, 13 Jan 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784567; cv=none; b=ZSlma7/EZ5+ZnVUPxFRxyMmHtvk2S950ly3iApml1YQ1xSRRTXhcu62M4Q0UXvsTCkgh7GZqh22W1XLthsR3ENwthY4y7iR9rYPdNSJDekNHN63aJLrpiCMQ3T8gHdtHzoiPZU0VxlLT6OLjXAIR56WrkA65nkFzeRWp1+SIksM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784567; c=relaxed/simple;
	bh=uCpbeZrOPACnClDrIepT6/MwVADSkxgnONV2Y/9ztxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Im0OwhXaTV/fLXKy0woLge3tnqWj841WQiEJAEbwXW4BoZ5EmR26NgY+6EtydF8Rpljp9cSEkIwU2zRSgTljyqYXk01O5W2ZrPC5/sPQZbbN4TEynk5WSuYu/TdoNPUwhzupVINPSbUL8j3WujjJwnVJ+cQWnI8sN/7XSeRp07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhRuLy+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8630C4CED6;
	Mon, 13 Jan 2025 16:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736784567;
	bh=uCpbeZrOPACnClDrIepT6/MwVADSkxgnONV2Y/9ztxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UhRuLy+eRqY84pPwgd+vB2nl37v6/ErmrtDFv7vcyF7gICkbi3dINuc1kIeqZwkuT
	 DqvWPk+FpVOfKcKNHKpL2+4hP9cQ1OxNV7ZElrdJ6pMPS90wwkhWHC0z0o30IpQD9H
	 gIVEFYMXEBAxei7FOT+Pvu0WTblbSvdU8NHmsh2rsqOxkzLvh4wMIXr6++F786fyDS
	 rxjD4o0rrsjoZ1jFWUInfud+mcFTf3wIDF/QMgQBA387wnvSUg2fZiZRirKl0f5jAZ
	 7371cKYXeXwqLXT6p0mfHKENRK0U2qCkjyWKoGKpaurUjrJizaORswq5S3EHTNXedO
	 7xEbqKBWeBTMQ==
Date: Mon, 13 Jan 2025 17:09:15 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: <shiju.jose@huawei.com>
Cc: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
 <rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
 <dan.j.williams@intel.com>, <dave@stgolabs.net>,
 <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
 <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
 <ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
 <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
 <jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
 <naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
 <somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
 <duenwen@google.com>, <gthelen@google.com>,
 <wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
 <wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>,
 <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
 <roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
 <wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v18 03/19] EDAC: Add ECS control feature
Message-ID: <20250113170915.0b752c99@foz.lan>
In-Reply-To: <20250106121017.1620-4-shiju.jose@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-4-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 6 Jan 2025 12:09:59 +0000
<shiju.jose@huawei.com> escreveu:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add EDAC ECS (Error Check Scrub) control to manage a memory device's
> ECS feature.
> 
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts.
> 
> The DDR5 device contains number of memory media FRUs per device. The
> DDR5 ECS feature and thus the ECS control driver supports configuring
> the ECS parameters per FRU.
> 
> Memory devices support the ECS feature register with the EDAC device
> driver, which retrieves the ECS descriptor from the EDAC ECS driver.
> This driver exposes sysfs ECS control attributes to userspace via
> /sys/bus/edac/devices/<dev-name>/ecs_fruX/.
> 
> The common sysfs ECS control interface abstracts the control of an
> arbitrary ECS functionality to a common set of functions.
> 
> Support for the ECS feature is added separately because the control
> attributes of the DDR5 ECS feature differ from those of the scrub
> feature.
> 
> The sysfs ECS attribute nodes are only present if the client driver
> has implemented the corresponding attribute callback function and
> passed the necessary operations to the EDAC RAS feature driver during
> registration.
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Patch LGTM, although I intend to do a more careful look on this series
checking it against the specs before sending my R-B.

> ---
>  Documentation/ABI/testing/sysfs-edac-ecs |  63 +++++++
>  Documentation/edac/scrub.rst             |   2 +
>  drivers/edac/Makefile                    |   2 +-
>  drivers/edac/ecs.c                       | 207 +++++++++++++++++++++++
>  drivers/edac/edac_device.c               |  17 ++
>  include/linux/edac.h                     |  41 ++++-
>  6 files changed, 329 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-edac-ecs
>  create mode 100755 drivers/edac/ecs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-edac-ecs b/Documentation/ABI/testing/sysfs-edac-ecs
> new file mode 100644
> index 000000000000..1160bec0603f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-edac-ecs
> @@ -0,0 +1,63 @@
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX
> +Date:		Jan 2025
> +KernelVersion:	6.14
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		The sysfs EDAC bus devices /<dev-name>/ecs_fruX subdirectory
> +		pertains to the memory media ECS (Error Check Scrub) control
> +		feature, where <dev-name> directory corresponds to a device
> +		registered with the EDAC device driver for the ECS feature.
> +		/ecs_fruX belongs to the media FRUs (Field Replaceable Unit)
> +		under the memory device.
> +		The sysfs ECS attr nodes are only present if the parent
> +		driver has implemented the corresponding attr callback
> +		function and provided the necessary operations to the EDAC
> +		device driver during registration.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/log_entry_type
> +Date:		Jan 2025
> +KernelVersion:	6.14
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The log entry type of how the DDR5 ECS log is reported.
> +		0 - per DRAM.
> +		1 - per memory media FRU.
> +		All other values are reserved.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/mode
> +Date:		Jan 2025
> +KernelVersion:	6.14
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The mode of how the DDR5 ECS counts the errors.
> +		Error count is tracked based on two different modes
> +		selected by DDR5 ECS Control Feature - Codeword mode and
> +		Row Count mode. If the ECS is under Codeword mode, then
> +		the error count increments each time a codeword with check
> +		bit errors is detected. If the ECS is under Row Count mode,
> +		then the error counter increments each time a row with
> +		check bit errors is detected.
> +		0 - ECS counts rows in the memory media that have ECC errors.
> +		1 - ECS counts codewords with errors, specifically, it counts
> +		the number of ECC-detected errors in the memory media.
> +		All other values are reserved.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/reset
> +Date:		Jan 2025
> +KernelVersion:	6.14
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(WO) ECS reset ECC counter.
> +		1 - reset ECC counter to the default value.
> +		All other values are reserved.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/threshold
> +Date:		Jan 2025
> +KernelVersion:	6.14
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) DDR5 ECS threshold count per gigabits of memory cells.
> +		The ECS error count is subject to the ECS Threshold count
> +		per Gbit, which masks error counts less than the Threshold.
> +		Supported values are 256, 1024 and 4096.
> +		All other values are reserved.
> diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
> index 5a5108b744a4..5640f9aeee38 100644
> --- a/Documentation/edac/scrub.rst
> +++ b/Documentation/edac/scrub.rst
> @@ -242,3 +242,5 @@ sysfs
>  Sysfs files are documented in
>  
>  `Documentation/ABI/testing/sysfs-edac-scrub`.
> +
> +`Documentation/ABI/testing/sysfs-edac-ecs`.
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index a162726cc6b9..3a49304860f0 100644
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
> index 000000000000..dae8e5ae881b
> --- /dev/null
> +++ b/drivers/edac/ecs.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The generic ECS driver is designed to support control of on-die error
> + * check scrub (e.g., DDR5 ECS). The common sysfs ECS interface abstracts
> + * the control of various ECS functionalities into a unified set of functions.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + */
> +
> +#include <linux/edac.h>
> +
> +#define EDAC_ECS_FRU_NAME "ecs_fru"
> +
> +enum edac_ecs_attributes {
> +	ECS_LOG_ENTRY_TYPE,
> +	ECS_MODE,
> +	ECS_RESET,
> +	ECS_THRESHOLD,
> +	ECS_MAX_ATTRS
> +};
> +
> +struct edac_ecs_dev_attr {
> +	struct device_attribute dev_attr;
> +	int fru_id;
> +};
> +
> +struct edac_ecs_fru_context {
> +	char name[EDAC_FEAT_NAME_LEN];
> +	struct edac_ecs_dev_attr dev_attr[ECS_MAX_ATTRS];
> +	struct attribute *ecs_attrs[ECS_MAX_ATTRS + 1];
> +	struct attribute_group group;
> +};
> +
> +struct edac_ecs_context {
> +	u16 num_media_frus;
> +	struct edac_ecs_fru_context *fru_ctxs;
> +};
> +
> +#define TO_ECS_DEV_ATTR(_dev_attr)	\
> +	container_of(_dev_attr, struct edac_ecs_dev_attr, dev_attr)
> +
> +#define EDAC_ECS_ATTR_SHOW(attrib, cb, type, format)				\
> +static ssize_t attrib##_show(struct device *ras_feat_dev,			\
> +			     struct device_attribute *attr, char *buf)		\
> +{										\
> +	struct edac_ecs_dev_attr *dev_attr = TO_ECS_DEV_ATTR(attr);		\
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;			\
> +	type data;								\
> +	int ret;								\
> +										\
> +	ret = ops->cb(ras_feat_dev->parent, ctx->ecs.private,			\
> +		      dev_attr->fru_id, &data);					\
> +	if (ret)								\
> +		return ret;							\
> +										\
> +	return sysfs_emit(buf, format, data);					\
> +}
> +
> +EDAC_ECS_ATTR_SHOW(log_entry_type, get_log_entry_type, u32, "%u\n")
> +EDAC_ECS_ATTR_SHOW(mode, get_mode, u32, "%u\n")
> +EDAC_ECS_ATTR_SHOW(threshold, get_threshold, u32, "%u\n")
> +
> +#define EDAC_ECS_ATTR_STORE(attrib, cb, type, conv_func)			\
> +static ssize_t attrib##_store(struct device *ras_feat_dev,			\
> +			      struct device_attribute *attr,			\
> +			      const char *buf, size_t len)			\
> +{										\
> +	struct edac_ecs_dev_attr *dev_attr = TO_ECS_DEV_ATTR(attr);		\
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;			\
> +	type data;								\
> +	int ret;								\
> +										\
> +	ret = conv_func(buf, 0, &data);						\
> +	if (ret < 0)								\
> +		return ret;							\
> +										\
> +	ret = ops->cb(ras_feat_dev->parent, ctx->ecs.private,			\
> +		      dev_attr->fru_id, data);					\
> +	if (ret)								\
> +		return ret;							\
> +										\
> +	return len;								\
> +}
> +
> +EDAC_ECS_ATTR_STORE(log_entry_type, set_log_entry_type, unsigned long, kstrtoul)
> +EDAC_ECS_ATTR_STORE(mode, set_mode, unsigned long, kstrtoul)
> +EDAC_ECS_ATTR_STORE(reset, reset, unsigned long, kstrtoul)
> +EDAC_ECS_ATTR_STORE(threshold, set_threshold, unsigned long, kstrtoul)
> +
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
> +		}
> +		break;
> +	case ECS_MODE:
> +		if (ops->get_mode) {
> +			if (ops->set_mode)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
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
> +		fru_ctx->dev_attr[ECS_LOG_ENTRY_TYPE] =
> +					EDAC_ECS_ATTR_RW(log_entry_type, fru);
> +		fru_ctx->dev_attr[ECS_MODE] = EDAC_ECS_ATTR_RW(mode, fru);
> +		fru_ctx->dev_attr[ECS_RESET] = EDAC_ECS_ATTR_WO(reset, fru);
> +		fru_ctx->dev_attr[ECS_THRESHOLD] =
> +					EDAC_ECS_ATTR_RW(threshold, fru);
> +
> +		for (i = 0; i < ECS_MAX_ATTRS; i++)
> +			fru_ctx->ecs_attrs[i] = &fru_ctx->dev_attr[i].dev_attr.attr;
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
> index 60b20eae01e8..1c1142a2e4e4 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -625,6 +625,9 @@ int edac_dev_register(struct device *parent, char *name,
>  			attr_gcnt++;
>  			scrub_cnt++;
>  			break;
> +		case RAS_FEAT_ECS:
> +			attr_gcnt += ras_features[feat].ecs_info.num_media_frus;
> +			break;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -669,6 +672,20 @@ int edac_dev_register(struct device *parent, char *name,
>  			scrub_cnt++;
>  			attr_gcnt++;
>  			break;
> +		case RAS_FEAT_ECS:
> +			if (!ras_features->ecs_ops)
> +				goto data_mem_free;
> +
> +			dev_data = &ctx->ecs;
> +			dev_data->ecs_ops = ras_features->ecs_ops;
> +			dev_data->private = ras_features->ctx;
> +			ret = edac_ecs_get_desc(parent, &ras_attr_groups[attr_gcnt],
> +						ras_features->ecs_info.num_media_frus);
> +			if (ret)
> +				goto data_mem_free;
> +
> +			attr_gcnt += ras_features->ecs_info.num_media_frus;
> +			break;
>  		default:
>  			ret = -EINVAL;
>  			goto data_mem_free;
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index ace8b10bb028..979e91426701 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -667,6 +667,7 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
>  /* RAS feature type */
>  enum edac_dev_feat {
>  	RAS_FEAT_SCRUB,
> +	RAS_FEAT_ECS,
>  	RAS_FEAT_MAX
>  };
>  
> @@ -700,9 +701,40 @@ int edac_scrub_get_desc(struct device *scrub_dev,
>  			const struct attribute_group **attr_groups,
>  			u8 instance);
>  
> +/**
> + * struct edac_ecs_ops - ECS device operations (all elements optional)
> + * @get_log_entry_type: read the log entry type value.
> + * @set_log_entry_type: set the log entry type value.
> + * @get_mode: read the mode value.
> + * @set_mode: set the mode value.
> + * @reset: reset the ECS counter.
> + * @get_threshold: read the threshold count per gigabits of memory cells.
> + * @set_threshold: set the threshold count per gigabits of memory cells.
> + */
> +struct edac_ecs_ops {
> +	int (*get_log_entry_type)(struct device *dev, void *drv_data, int fru_id, u32 *val);
> +	int (*set_log_entry_type)(struct device *dev, void *drv_data, int fru_id, u32 val);
> +	int (*get_mode)(struct device *dev, void *drv_data, int fru_id, u32 *val);
> +	int (*set_mode)(struct device *dev, void *drv_data, int fru_id, u32 val);
> +	int (*reset)(struct device *dev, void *drv_data, int fru_id, u32 val);
> +	int (*get_threshold)(struct device *dev, void *drv_data, int fru_id, u32 *threshold);
> +	int (*set_threshold)(struct device *dev, void *drv_data, int fru_id, u32 threshold);
> +};
> +
> +struct edac_ecs_ex_info {
> +	u16 num_media_frus;
> +};
> +
> +int edac_ecs_get_desc(struct device *ecs_dev,
> +		      const struct attribute_group **attr_groups,
> +		      u16 num_media_frus);
> +
>  /* EDAC device feature information structure */
>  struct edac_dev_data {
> -	const struct edac_scrub_ops *scrub_ops;
> +	union {
> +		const struct edac_scrub_ops *scrub_ops;
> +		const struct edac_ecs_ops *ecs_ops;
> +	};
>  	u8 instance;
>  	void *private;
>  };
> @@ -711,13 +743,18 @@ struct edac_dev_feat_ctx {
>  	struct device dev;
>  	void *private;
>  	struct edac_dev_data *scrub;
> +	struct edac_dev_data ecs;
>  };
>  
>  struct edac_dev_feature {
>  	enum edac_dev_feat ft_type;
>  	u8 instance;
> -	const struct edac_scrub_ops *scrub_ops;
> +	union {
> +		const struct edac_scrub_ops *scrub_ops;
> +		const struct edac_ecs_ops *ecs_ops;
> +	};
>  	void *ctx;
> +	struct edac_ecs_ex_info ecs_info;
>  };
>  
>  int edac_dev_register(struct device *parent, char *dev_name,



Thanks,
Mauro

