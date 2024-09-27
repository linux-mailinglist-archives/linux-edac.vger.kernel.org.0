Return-Path: <linux-edac+bounces-1929-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAC398890D
	for <lists+linux-edac@lfdr.de>; Fri, 27 Sep 2024 18:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7DD1C20E1A
	for <lists+linux-edac@lfdr.de>; Fri, 27 Sep 2024 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2BF1BBBE3;
	Fri, 27 Sep 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReRKx0+/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D4C23B0;
	Fri, 27 Sep 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454535; cv=none; b=EOiPU53XlJ477oGkwNKl4hM+gGJBzuQH53kSlWjjc4it4jx45JltJ7maXg6L/gM2/E9JAEXwHb0qfYSQ3cmEYXdgS0kZNxaHjccBDBnyxtBnNBeSa7g2arHYeGsIgDZRhQAWW2KeOON4iBg7XQym+1CSmnM7/XfOFUqYT+ln3UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454535; c=relaxed/simple;
	bh=kyDtcizW7sNPzjSbDi5pQUXHDiCMp3l3pIMdroUU2Ks=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxU+jKUY6WLBcFzqZjpuBvwkZyveX38uy40TuS39btx0obTRHojK8bIjYauKpYr3p8NxQu7VwxLMUF/WG3zgN9aKglFuJ3gzWx4aCXTi/0cIH3H6DxWrOsCQECzD/ZIZnYBsVhQapvSN7QY1PCB+PfW5j+1GPPwHnaDAr5o4EnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReRKx0+/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71781f42f75so2093374b3a.1;
        Fri, 27 Sep 2024 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727454532; x=1728059332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XmIiCLkR/hkbzh0Ky2BJfmPZA/6tjepSUj176wg07uI=;
        b=ReRKx0+/XqrS0SP4NmsUJY29pKQ+wzpdhlulBAswJYCfINVgF4RCxHKBr/HAVDrFeT
         Ct1d/ARKAnF4PsP21oP74zv77Zh+QUxi0qXahdqvKS4tdn9YxkptCMSqeCtV0UHXHpbl
         i5k85UaXU5nDIrAa9evnNC2pj9l/jwjICwUGGv7LNBgwW6+HPUAFvFZEDomgrx8cPk44
         hKAXxJSxUD3Vgb7j4jFB4V+8dMqwbLdzLZjJilqf6rvRgAfuBTBNVGPdPbcMLyhpCdO9
         6Z5iXF2xwJXv+iEXrP5H4fqmQ6nfq/B08mjgbh0TPRR70soPTJS5Toe3GR7ZHQRZKIor
         0HPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727454532; x=1728059332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmIiCLkR/hkbzh0Ky2BJfmPZA/6tjepSUj176wg07uI=;
        b=dHuFwagFPqifEZQv2BZkcEDd59tATVaHiXVxXEcZZxdzntFbABgjS/obHeh6z3Sbia
         Dr4fmbIGGEDw/nXvgaL9gws0urqhkwKDAp2DYCkjSHdIPd03L7qPYUDbRh3dLbk8Nz6h
         CU4e5bsaNuzOHDnsZGx2GSc4cNfo411RtjqzqsoLZJf5kfzWsNlg9O3b9VM651WTHuFB
         pLczSN0fezT19jpaiEAGS3pCgKD3qC9h5LNckRC9YULWVL/D8N3dlDN0hcxYmHL6Lbak
         PrCiP6kJllrhsFETSP+KcUer4iUuLaQ4vHchBjlR7X4OvmY1VY/GRPWaAvdz9bE+5V/4
         RudA==
X-Forwarded-Encrypted: i=1; AJvYcCWlK2tljcGCfq76EY4IZlaXPQITotbAczenxP3sgeSfeWRto5ic/jDJYVBj8RClib4sZ+mQ1ppxXS/z@vger.kernel.org, AJvYcCWxG6L0wZnZzCVisLFlOpHP5IXlubj3izSquuDVsAdMwD3MYuCl5YruO2WI2C5257z2IyqaX3kJWwwEH9p+@vger.kernel.org, AJvYcCXqbd6sGrapJP6P1muN79ZN2RnySWzowB5+fkwMJWZ72B0n17YYxSPJ91bWSc5XNE95pIYcTy47PvYH@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ2C74Z1Mb8bIxK21l90RfWtExL3shqDkrQaDo/4i69CE65aBA
	4HcirehsqQ6pddv3vIoSYcsVV4Kp/PgIVUrDuBU/V6SqMPDidIek
X-Google-Smtp-Source: AGHT+IH0hXfvwUyP4i0u5tkGuAWbw7RYFw/5d1PvH6bNcpziaUfRFT1Jvu57c3dC0xoCKi8oEEFghw==
X-Received: by 2002:a05:6a00:2e95:b0:717:8ee0:4ea1 with SMTP id d2e1a72fcca58-71b25daa3bamr7374367b3a.0.1727454532160;
        Fri, 27 Sep 2024 09:28:52 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:e914:22c1:3fcb:d442])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26538728sm1778511b3a.214.2024.09.27.09.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 09:28:51 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 27 Sep 2024 09:28:23 -0700
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, mike.malvestuto@intel.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com, jgroves@micron.com,
	vsalve@micron.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v12 03/17] EDAC: Add EDAC ECS control driver
Message-ID: <ZvbdJ-srtqxynefn@fan>
References: <20240911090447.751-1-shiju.jose@huawei.com>
 <20240911090447.751-4-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911090447.751-4-shiju.jose@huawei.com>

On Wed, Sep 11, 2024 at 10:04:32AM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add EDAC ECS (Error Check Scrub) control driver supports configuring
s/supports/to support/
> the memory device's ECS feature.
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
> The memory devices support ECS feature register with the EDAC ECS driver
> and thus with the generic EDAC RAS feature driver, which adds the sysfs
> ECS control interface. The ECS control attributes are exposed to
> userspace in /sys/bus/edac/devices/<dev-name>/ecs_fruX/.
> 
> Generic EDAC ECS driver and the common sysfs ECS interface promotes
> unambiguous control from the userspace irrespective of the underlying
> devices, support ECS feature.
s/, support/which support/   ???
> 
> The support for ECS feature is added separately because the DDR5 ECS
> features control attributes are dissimilar from those of the scrub
> feature.
> 
> The sysfs ECS attr nodes would be present only if the client driver
> has implemented the corresponding attr callback function and pass
s/pass/passed/
> in ops to the EDAC RAS feature driver during registration.
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-edac-ecs |  78 +++++
>  drivers/edac/Makefile                    |   2 +-
>  drivers/edac/edac_device.c               |   3 +
>  drivers/edac/edac_ecs.c                  | 376 +++++++++++++++++++++++
>  include/linux/edac.h                     |  33 ++
>  5 files changed, 491 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-edac-ecs
>  create mode 100755 drivers/edac/edac_ecs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-edac-ecs b/Documentation/ABI/testing/sysfs-edac-ecs
> new file mode 100644
> index 000000000000..1eb35acd4e5e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-edac-ecs
> @@ -0,0 +1,78 @@
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*

Maybe s/ecs_fru*/ecs_fruX/?? 

The same for below.

> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		The sysfs EDAC bus devices /<dev-name>/ecs_fru* subdirectory
> +		belongs to the memory media ECS (Error Check Scrub) control
> +		feature, where <dev-name> directory corresponds to a device
> +		registered with the EDAC ECS driver and thus registered with
> +		the generic EDAC RAS driver too.
> +		/ecs_fru* belongs to the media FRUs (Field replaceable unit)
> +		under the memory device.
> +		The sysfs ECS attr nodes would be present only if the client
> +		driver has implemented the corresponding attr callback
> +		function and pass in ops to the EDAC RAS feature driver
s/pass/passed/

Fan
> +		during registration.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/log_entry_type
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The log entry type of how the DDR5 ECS log is reported.
> +		00b - per DRAM.
> +		01b - per memory media FRU.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/log_entry_type_per_dram
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) True if current log entry type is per DRAM.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/log_entry_type_per_memory_media
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) True if current log entry type is per memory media FRU.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/mode
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The mode of how the DDR5 ECS counts the errors.
> +		0 - ECS counts rows with errors.
> +		1 - ECS counts codewords with errors.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/mode_counts_rows
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) True if current mode is ECS counts rows with errors.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/mode_counts_codewords
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) True if current mode is ECS counts codewords with errors.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/reset
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(WO) ECS reset ECC counter.
> +		0 - normal, ECC counter running actively.
> +		1 - reset ECC counter to the default value.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fru*/threshold
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) ECS threshold count per GB of memory cells.
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index fbf0e39ec678..62115eff6a9a 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
>  
>  edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
>  edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
> -edac_core-y	+= edac_scrub.o
> +edac_core-y	+= edac_scrub.o edac_ecs.o
>  
>  edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
>  
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 6381896b6424..9cac9ae75080 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -623,6 +623,9 @@ static int edac_dev_feat_init(struct device *parent,
>  		num = ras_feat->ecs_info.num_media_frus;
>  		dev_data->ecs_ops = ras_feat->ecs_ops;
>  		dev_data->private = ras_feat->ctx;
> +		ret = edac_ecs_get_desc(parent, attr_groups, num);
> +		if (ret)
> +			return ret;
>  		return num;
>  	case RAS_FEAT_PPR:
>  		dev_data->ppr_ops = ras_feat->ppr_ops;
> diff --git a/drivers/edac/edac_ecs.c b/drivers/edac/edac_ecs.c
> new file mode 100755
> index 000000000000..50915ab1e769
> --- /dev/null
> +++ b/drivers/edac/edac_ecs.c
> @@ -0,0 +1,376 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ECS driver supporting controlling on die error check scrub
> + * (e.g. DDR5 ECS). The common sysfs ECS interface promotes
> + * unambiguous access from the userspace.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + */
> +
> +#define pr_fmt(fmt)     "EDAC ECS: " fmt
> +
> +#include <linux/edac.h>
> +
> +#define EDAC_ECS_FRU_NAME "ecs_fru"
> +
> +enum edac_ecs_attributes {
> +	ECS_LOG_ENTRY_TYPE,
> +	ECS_LOG_ENTRY_TYPE_PER_DRAM,
> +	ECS_LOG_ENTRY_TYPE_PER_MEMORY_MEDIA,
> +	ECS_MODE,
> +	ECS_MODE_COUNTS_ROWS,
> +	ECS_MODE_COUNTS_CODEWORDS,
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
> +	struct edac_ecs_dev_attr ecs_dev_attr[ECS_MAX_ATTRS];
> +	struct attribute *ecs_attrs[ECS_MAX_ATTRS + 1];
> +	struct attribute_group group;
> +};
> +
> +struct edac_ecs_context {
> +	u16 num_media_frus;
> +	struct edac_ecs_fru_context *fru_ctxs;
> +};
> +
> +#define to_ecs_dev_attr(_dev_attr)	\
> +	container_of(_dev_attr, struct edac_ecs_dev_attr, dev_attr)
> +
> +static ssize_t log_entry_type_show(struct device *ras_feat_dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;
> +	u32 val;
> +	int ret;
> +
> +	ret = ops->get_log_entry_type(ras_feat_dev->parent, ctx->ecs.private,
> +				      ecs_dev_attr->fru_id, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t log_entry_type_store(struct device *ras_feat_dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t len)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;
> +	long val;
> +	int ret;
> +
> +	ret = kstrtol(buf, 0, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->set_log_entry_type(ras_feat_dev->parent, ctx->ecs.private,
> +				      ecs_dev_attr->fru_id, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t log_entry_type_per_dram_show(struct device *ras_feat_dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;
> +	u32 val;
> +	int ret;
> +
> +	ret = ops->get_log_entry_type_per_dram(ras_feat_dev->parent, ctx->ecs.private,
> +					       ecs_dev_attr->fru_id, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t log_entry_type_per_memory_media_show(struct device *ras_feat_dev,
> +						    struct device_attribute *attr,
> +						    char *buf)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;
> +	u32 val;
> +	int ret;
> +
> +	ret = ops->get_log_entry_type_per_memory_media(ras_feat_dev->parent,
> +						       ctx->ecs.private,
> +						       ecs_dev_attr->fru_id, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t mode_show(struct device *ras_feat_dev,
> +			 struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;
> +	u32 val;
> +	int ret;
> +
> +	ret = ops->get_mode(ras_feat_dev->parent, ctx->ecs.private,
> +			    ecs_dev_attr->fru_id, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t mode_store(struct device *ras_feat_dev,
> +			  struct device_attribute *attr,
> +			  const char *buf, size_t len)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;
> +	long val;
> +	int ret;
> +
> +	ret = kstrtol(buf, 0, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->set_mode(ras_feat_dev->parent, ctx->ecs.private,
> +			    ecs_dev_attr->fru_id, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t mode_counts_rows_show(struct device *ras_feat_dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;
> +	u32 val;
> +	int ret;
> +
> +	ret = ops->get_mode_counts_rows(ras_feat_dev->parent, ctx->ecs.private,
> +					ecs_dev_attr->fru_id, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t mode_counts_codewords_show(struct device *ras_feat_dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;
> +	u32 val;
> +	int ret;
> +
> +	ret = ops->get_mode_counts_codewords(ras_feat_dev->parent, ctx->ecs.private,
> +					     ecs_dev_attr->fru_id, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t reset_store(struct device *ras_feat_dev,
> +			   struct device_attribute *attr,
> +			   const char *buf, size_t len)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;
> +	long val;
> +	int ret;
> +
> +	ret = kstrtol(buf, 0, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->reset(ras_feat_dev->parent, ctx->ecs.private,
> +			 ecs_dev_attr->fru_id, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t threshold_show(struct device *ras_feat_dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;
> +	int ret;
> +	u32 val;
> +
> +	ret = ops->get_threshold(ras_feat_dev->parent, ctx->ecs.private,
> +				 ecs_dev_attr->fru_id, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t threshold_store(struct device *ras_feat_dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t len)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;
> +	long val;
> +	int ret;
> +
> +	ret = kstrtol(buf, 0, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->set_threshold(ras_feat_dev->parent, ctx->ecs.private,
> +				 ecs_dev_attr->fru_id, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static umode_t ecs_attr_visible(struct kobject *kobj,
> +				struct attribute *a, int attr_id)
> +{
> +	struct device *ras_feat_dev = kobj_to_dev(kobj);
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;
> +
> +	switch (attr_id) {
> +	case ECS_LOG_ENTRY_TYPE:
> +		if (ops->get_log_entry_type && ops->set_log_entry_type)
> +			return a->mode;
> +		if (ops->get_log_entry_type)
> +			return 0444;
> +		return 0;
> +	case ECS_LOG_ENTRY_TYPE_PER_DRAM:
> +		return ops->get_log_entry_type_per_dram ? a->mode : 0;
> +	case ECS_LOG_ENTRY_TYPE_PER_MEMORY_MEDIA:
> +		return ops->get_log_entry_type_per_memory_media ? a->mode : 0;
> +	case ECS_MODE:
> +		if (ops->get_mode && ops->set_mode)
> +			return a->mode;
> +		if (ops->get_mode)
> +			return 0444;
> +		return 0;
> +	case ECS_MODE_COUNTS_ROWS:
> +		return ops->get_mode_counts_rows ? a->mode : 0;
> +	case ECS_MODE_COUNTS_CODEWORDS:
> +		return ops->get_mode_counts_codewords ? a->mode : 0;
> +	case ECS_RESET:
> +		return ops->reset ? a->mode : 0;
> +	case ECS_THRESHOLD:
> +		if (ops->get_threshold && ops->set_threshold)
> +			return a->mode;
> +		if (ops->get_threshold)
> +			return 0444;
> +		return 0;
> +	default:
> +		return 0;
> +	}
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
> +			   const struct attribute_group **attr_groups,
> +			   u16 num_media_frus)
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
> +		fru_ctx->ecs_dev_attr[0] = EDAC_ECS_ATTR_RW(log_entry_type, fru);
> +		fru_ctx->ecs_dev_attr[1] = EDAC_ECS_ATTR_RO(log_entry_type_per_dram, fru);
> +		fru_ctx->ecs_dev_attr[2] = EDAC_ECS_ATTR_RO(log_entry_type_per_memory_media, fru);
> +		fru_ctx->ecs_dev_attr[3] = EDAC_ECS_ATTR_RW(mode, fru);
> +		fru_ctx->ecs_dev_attr[4] = EDAC_ECS_ATTR_RO(mode_counts_rows, fru);
> +		fru_ctx->ecs_dev_attr[5] = EDAC_ECS_ATTR_RO(mode_counts_codewords, fru);
> +		fru_ctx->ecs_dev_attr[6] = EDAC_ECS_ATTR_WO(reset, fru);
> +		fru_ctx->ecs_dev_attr[7] = EDAC_ECS_ATTR_RW(threshold, fru);
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
> + * @attr_groups: pointer to attrribute group container
> + * @num_media_frus: number of media FRUs in the device
> + *
> + * Returns 0 on success, error otherwise.
> + */
> +int edac_ecs_get_desc(struct device *ecs_dev,
> +		      const struct attribute_group **attr_groups,
> +		      u16 num_media_frus)
> +{
> +	if (!ecs_dev || !attr_groups || !num_media_frus)
> +		return -EINVAL;
> +
> +	return ecs_create_desc(ecs_dev, attr_groups, num_media_frus);
> +}
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index aae8262b9863..90cb90cf5272 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -704,10 +704,43 @@ int edac_scrub_get_desc(struct device *scrub_dev,
>  			const struct attribute_group **attr_groups,
>  			u8 instance);
>  
> +/**
> + * struct ecs_ops - ECS device operations (all elements optional)
> + * @get_log_entry_type: read the log entry type value.
> + * @set_log_entry_type: set the log entry type value.
> + * @get_log_entry_type_per_dram: read the log entry type per dram value.
> + * @get_log_entry_type_memory_media: read the log entry type per memory media value.
> + * @get_mode: read the mode value.
> + * @set_mode: set the mode value.
> + * @get_mode_counts_rows: read the mode counts rows value.
> + * @get_mode_counts_codewords: read the mode counts codewords value.
> + * @reset: reset the ECS counter.
> + * @get_threshold: read the threshold value.
> + * @set_threshold: set the threshold value.
> + */
> +struct edac_ecs_ops {
> +	int (*get_log_entry_type)(struct device *dev, void *drv_data, int fru_id, u32 *val);
> +	int (*set_log_entry_type)(struct device *dev, void *drv_data, int fru_id, u32 val);
> +	int (*get_log_entry_type_per_dram)(struct device *dev, void *drv_data,
> +					   int fru_id, u32 *val);
> +	int (*get_log_entry_type_per_memory_media)(struct device *dev, void *drv_data,
> +						   int fru_id, u32 *val);
> +	int (*get_mode)(struct device *dev, void *drv_data, int fru_id, u32 *val);
> +	int (*set_mode)(struct device *dev, void *drv_data, int fru_id, u32 val);
> +	int (*get_mode_counts_rows)(struct device *dev, void *drv_data, int fru_id, u32 *val);
> +	int (*get_mode_counts_codewords)(struct device *dev, void *drv_data, int fru_id, u32 *val);
> +	int (*reset)(struct device *dev, void *drv_data, int fru_id, u32 val);
> +	int (*get_threshold)(struct device *dev, void *drv_data, int fru_id, u32 *threshold);
> +	int (*set_threshold)(struct device *dev, void *drv_data, int fru_id, u32 threshold);
> +};
> +
>  struct edac_ecs_ex_info {
>  	u16 num_media_frus;
>  };
>  
> +int edac_ecs_get_desc(struct device *ecs_dev,
> +		      const struct attribute_group **attr_groups,
> +		      u16 num_media_frus);
>  /*
>   * EDAC device feature information structure
>   */
> -- 
> 2.34.1
> 

-- 
Fan Ni

