Return-Path: <linux-edac+bounces-1927-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3072A987B7A
	for <lists+linux-edac@lfdr.de>; Fri, 27 Sep 2024 01:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89AB3B2460F
	for <lists+linux-edac@lfdr.de>; Thu, 26 Sep 2024 23:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D541B0100;
	Thu, 26 Sep 2024 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bka9ql2A"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41842143C4C;
	Thu, 26 Sep 2024 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727391901; cv=none; b=vDNNZBtf24C8sUnXw/6XZ7DU4trrFKLmtxyiLFNIJQWVGyjt9KFgqlCqske+7uk4bqXjHRZ/rWi88pFjDIlKpEoYzAtWyVFr0e4vvw8JxOvSKggCbNV4ePc8zY1M8JUWrT1/f+vHmx2/mL+UJVxtVv9dzDdwG0B6oD/sfWwtoOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727391901; c=relaxed/simple;
	bh=Z2l+gcJewtaZGcQ8Bt7cX61r8ZpFy0rWccy06WX3iMI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NB3oC2zpbyPw/OmHqAjll28DtH2+rQZEO4z1DBmNz0D+tIFqI7HVSGNghlg/zPE7Yv01MRxlANxNPgwtZ3sRqFjpWFpZYx3O95PtYNMF6vJeRZoqrE/MOvfLHqGORty1k+4APJynfF5Tz/MnN0Q92iqfCUn/eSDdbxlpo4lJwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bka9ql2A; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71798a15ce5so1992890b3a.0;
        Thu, 26 Sep 2024 16:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727391898; x=1727996698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GMsIDMK1DDrg0Yyv1jX8w4F76evTMg1B64TtXPFTWOQ=;
        b=bka9ql2AwuGz+wQUx2OU3HT9lm3+ZANd0637Gy6Yu7b/ZAfqT4/+ZxQ0Dyg9JjGE9n
         SBFA/2WDFRdEd/c4hr4M6wk2nRGiAbjJmcSiNrAf0G8+WcUcW5+ptdXdDhGCvqdvfU+/
         YtN/xZO7e/D2sQ8xxnvzDRP4kgudAoFn0EVmBCJzt/WcU5OFvjfp36/rdmCL5M7VOsix
         CIsRUqWSaTB5lgFfuGxQeKrSyo1ZbX1LVXEpDjGIqo6h8PBBxOUquFrkk/58rBYpreLV
         bsiORCYQN5ybVCn4IpqquLI8n/V8/og4202Er2304WNgf6uURAEBfHNCMRhAJENhYL8K
         ZfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727391898; x=1727996698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMsIDMK1DDrg0Yyv1jX8w4F76evTMg1B64TtXPFTWOQ=;
        b=rv/clO1w3ca6XIuzZ3zhms7m2Sc7WK43RGFIfOS3YTiAEDcsViiK+yT0CqqP6er1n/
         JgSYhgJUXYH9IV3d6Kn8HCOY5W3gq6ye2+fatRZQgrl7s6HUwknsl0Wbo2HPbISsj1RY
         qxH2Jdtwuf+JVdtEvSAh2901FWkQOVBUjIaKoBLP85N++d01LR9ubD83vKJG05nSH3me
         X1f+WnwHzWLHkRfrciTtaWneZeHf3zDfy7Lqk4LcP61bAKB115IZqouSdOmLNaPGPBtE
         YQyGi9m2nAooToWDQCkcu6qaoPG13hP9nGwT9UkJ/iJMUilfv2jqWldbBd7HkwtDsX8y
         ZiHA==
X-Forwarded-Encrypted: i=1; AJvYcCVCgCO+hwm0S1Nyc0jCSAW8GViLGJhp5n5dBLATeBe8372M46OeDg7/owII4Rt11BngajCdIMj3LlMTiXNk@vger.kernel.org, AJvYcCVeMbubK+bPgTlqRUdYNQXU8adACFsy5pXCr5Q+ujvtcj2IJM18IeKk1eI52I67p6rrOsqBpsAFIHaO@vger.kernel.org, AJvYcCXOPjcKCrcUHlUN5+RRHNXHZ5FNRnBu320DHWTAEyA0ZpEml/UjO9Ikrx3jXMsdDpIiQ3oKilmT0C2M@vger.kernel.org
X-Gm-Message-State: AOJu0YxW+6FJc/88aiLass6gvZXtNtfGkYTt/IeVRvNYRdKPlR1UZr0D
	d4HDiFp7/nNNxiQaaZRChdFVl4m2AENlXMffo0gLNzqRvDqoRcaz
X-Google-Smtp-Source: AGHT+IF+nGkS9O9uGxE47Gicx01cKZPi/PnmWJEq3myiiVA2CsWcjjHbKBQ7EqG99fOgC6cSl2Zi8g==
X-Received: by 2002:a05:6a20:b711:b0:1d4:fafb:845d with SMTP id adf61e73a8af0-1d4fafb8945mr1677142637.2.1727391898182;
        Thu, 26 Sep 2024 16:04:58 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:8795:a5ca:b1bf:1a39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bc88bsm421782b3a.71.2024.09.26.16.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 16:04:57 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 26 Sep 2024 16:04:42 -0700
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
Subject: Re: [PATCH v12 02/17] EDAC: Add EDAC scrub control driver
Message-ID: <ZvXoiiOB330Kv-2Q@fan>
References: <20240911090447.751-1-shiju.jose@huawei.com>
 <20240911090447.751-3-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911090447.751-3-shiju.jose@huawei.com>

On Wed, Sep 11, 2024 at 10:04:31AM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add generic EDAC scrub control driver supports configuring the memory scrubbers
> in the system. The device with scrub feature, get the scrub descriptor from the
> EDAC scrub and registers with the EDAC RAS feature driver, which adds the sysfs
> scrub control interface. The scrub control attributes for a scrub instance are
> available to userspace in /sys/bus/edac/devices/<dev-name>/scrub*/.
> 
> Generic EDAC scrub driver and the common sysfs scrub interface promotes
> unambiguous access from the userspace irrespective of the underlying scrub
> devices.
> 
> The sysfs scrub attribute nodes would be present only if the client driver
> has implemented the corresponding attribute callback function and pass in ops
> to the EDAC RAS feature driver during registration.
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-edac-scrub |  69 ++++
>  drivers/edac/Makefile                      |   1 +
>  drivers/edac/edac_device.c                 |   6 +-
>  drivers/edac/edac_scrub.c                  | 377 +++++++++++++++++++++
>  include/linux/edac.h                       |  30 ++
>  5 files changed, 482 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-edac-scrub
>  create mode 100755 drivers/edac/edac_scrub.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-edac-scrub b/Documentation/ABI/testing/sysfs-edac-scrub
> new file mode 100644
> index 000000000000..f465cc91423f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-edac-scrub
> @@ -0,0 +1,69 @@
> +What:		/sys/bus/edac/devices/<dev-name>/scrub*

Based on the code below, we can only have scrub0, scrub1, etc.
So should we use scrubX instead of scrub* here.

The same for below.

Fan

> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		The sysfs EDAC bus devices /<dev-name>/scrub* subdirectory
> +		belongs to an instance of memory scrub control feature,
> +		where <dev-name> directory corresponds to a device/memory
> +		region registered with the EDAC scrub driver and thus
> +		registered with the generic EDAC RAS driver.
> +		The sysfs scrub attr nodes would be present only if the
> +		client driver has implemented the corresponding attr
> +		callback function and pass in ops to the EDAC RAS feature
> +		driver during registration.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrub*/addr_range_base
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The base of the address range of the memory region
> +		to be scrubbed (on-demand scrubbing).
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrub*/addr_range_size
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The size of the address range of the memory region
> +		to be scrubbed (on-demand scrubbing).
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrub*/enable_background
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Start/Stop background(patrol) scrubbing if supported.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrub*/enable_on_demand
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Start/Stop on-demand scrubbing the memory region
> +		if supported.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrub*/min_cycle_duration
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) Supported minimum scrub cycle duration in seconds
> +		by the memory scrubber.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrub*/max_cycle_duration
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) Supported maximum scrub cycle duration in seconds
> +		by the memory scrubber.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrub*/current_cycle_duration
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The current scrub cycle duration in seconds and must be
> +		within the supported range by the memory scrubber.
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 4edfb83ffbee..fbf0e39ec678 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
>  
>  edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
>  edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
> +edac_core-y	+= edac_scrub.o
>  
>  edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
>  
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index e4a5d010ea2d..6381896b6424 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -608,12 +608,16 @@ static int edac_dev_feat_init(struct device *parent,
>  			      const struct edac_dev_feature *ras_feat,
>  			      const struct attribute_group **attr_groups)
>  {
> -	int num;
> +	int num, ret;
>  
>  	switch (ras_feat->ft_type) {
>  	case RAS_FEAT_SCRUB:
>  		dev_data->scrub_ops = ras_feat->scrub_ops;
>  		dev_data->private = ras_feat->ctx;
> +		ret = edac_scrub_get_desc(parent, attr_groups,
> +					  ras_feat->instance);
> +		if (ret)
> +			return ret;
>  		return 1;
>  	case RAS_FEAT_ECS:
>  		num = ras_feat->ecs_info.num_media_frus;
> diff --git a/drivers/edac/edac_scrub.c b/drivers/edac/edac_scrub.c
> new file mode 100755
> index 000000000000..3f8f37629acf
> --- /dev/null
> +++ b/drivers/edac/edac_scrub.c
> @@ -0,0 +1,377 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic EDAC scrub driver supports controlling the memory
> + * scrubbers in the system and the common sysfs scrub interface
> + * promotes unambiguous access from the userspace.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + */
> +
> +#define pr_fmt(fmt)     "EDAC SCRUB: " fmt
> +
> +#include <linux/edac.h>
> +
> +enum edac_scrub_attributes {
> +	SCRUB_ADDR_RANGE_BASE,
> +	SCRUB_ADDR_RANGE_SIZE,
> +	SCRUB_ENABLE_BACKGROUND,
> +	SCRUB_ENABLE_ON_DEMAND,
> +	SCRUB_MIN_CYCLE_DURATION,
> +	SCRUB_MAX_CYCLE_DURATION,
> +	SCRUB_CURRENT_CYCLE_DURATION,
> +	SCRUB_MAX_ATTRS
> +};
> +
> +struct edac_scrub_dev_attr {
> +	struct device_attribute dev_attr;
> +	u8 instance;
> +};
> +
> +struct edac_scrub_context {
> +	char name[EDAC_FEAT_NAME_LEN];
> +	struct edac_scrub_dev_attr scrub_dev_attr[SCRUB_MAX_ATTRS];
> +	struct attribute *scrub_attrs[SCRUB_MAX_ATTRS + 1];
> +	struct attribute_group group;
> +};
> +
> +#define to_scrub_dev_attr(_dev_attr)      \
> +		container_of(_dev_attr, struct edac_scrub_dev_attr, dev_attr)
> +
> +static ssize_t addr_range_base_show(struct device *ras_feat_dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
> +	u64 base, size;
> +	int ret;
> +
> +	ret = ops->read_range(ras_feat_dev->parent, ctx->scrub[inst].private, &base, &size);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%llx\n", base);
> +}
> +
> +static ssize_t addr_range_size_show(struct device *ras_feat_dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
> +	u64 base, size;
> +	int ret;
> +
> +	ret = ops->read_range(ras_feat_dev->parent, ctx->scrub[inst].private, &base, &size);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%llx\n", size);
> +}
> +
> +static ssize_t addr_range_base_store(struct device *ras_feat_dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
> +	u64 base, size;
> +	int ret;
> +
> +	ret = ops->read_range(ras_feat_dev->parent, ctx->scrub[inst].private, &base, &size);
> +	if (ret)
> +		return ret;
> +
> +	ret = kstrtou64(buf, 0, &base);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->write_range(ras_feat_dev->parent, ctx->scrub[inst].private, base, size);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t addr_range_size_store(struct device *ras_feat_dev,
> +				     struct device_attribute *attr,
> +				     const char *buf,
> +				     size_t len)
> +{
> +	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
> +	u64 base, size;
> +	int ret;
> +
> +	ret = ops->read_range(ras_feat_dev->parent, ctx->scrub[inst].private, &base, &size);
> +	if (ret)
> +		return ret;
> +
> +	ret = kstrtou64(buf, 0, &size);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->write_range(ras_feat_dev->parent, ctx->scrub[inst].private, base, size);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t enable_background_store(struct device *ras_feat_dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
> +	bool enable;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &enable);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->set_enabled_bg(ras_feat_dev->parent, ctx->scrub[inst].private, enable);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t enable_background_show(struct device *ras_feat_dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
> +	bool enable;
> +	int ret;
> +
> +	ret = ops->get_enabled_bg(ras_feat_dev->parent, ctx->scrub[inst].private, &enable);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", enable);
> +}
> +
> +static ssize_t enable_on_demand_show(struct device *ras_feat_dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
> +	bool enable;
> +	int ret;
> +
> +	ret = ops->get_enabled_od(ras_feat_dev->parent, ctx->scrub[inst].private, &enable);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", enable);
> +}
> +
> +static ssize_t enable_on_demand_store(struct device *ras_feat_dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
> +	bool enable;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &enable);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->set_enabled_od(ras_feat_dev->parent, ctx->scrub[inst].private, enable);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t min_cycle_duration_show(struct device *ras_feat_dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
> +	u32 val;
> +	int ret;
> +
> +	ret = ops->min_cycle_read(ras_feat_dev->parent, ctx->scrub[inst].private, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t max_cycle_duration_show(struct device *ras_feat_dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
> +	u32 val;
> +	int ret;
> +
> +	ret = ops->max_cycle_read(ras_feat_dev->parent, ctx->scrub[inst].private, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t current_cycle_duration_show(struct device *ras_feat_dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
> +	u32 val;
> +	int ret;
> +
> +	ret = ops->cycle_duration_read(ras_feat_dev->parent, ctx->scrub[inst].private, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t current_cycle_duration_store(struct device *ras_feat_dev,
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t len)
> +{
> +	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))->instance;
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
> +	long val;
> +	int ret;
> +
> +	ret = kstrtol(buf, 0, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->cycle_duration_write(ras_feat_dev->parent, ctx->scrub[inst].private, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static umode_t scrub_attr_visible(struct kobject *kobj,
> +				  struct attribute *a, int attr_id)
> +{
> +	struct device *ras_feat_dev = kobj_to_dev(kobj);
> +	struct device_attribute *dev_attr =
> +				container_of(a, struct device_attribute, attr);
> +	u8 inst = ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(dev_attr))->instance;
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
> +
> +	switch (attr_id) {
> +	case SCRUB_ADDR_RANGE_BASE:
> +	case SCRUB_ADDR_RANGE_SIZE:
> +		if (ops->read_range && ops->write_range)
> +			return a->mode;
> +		if (ops->read_range)
> +			return 0444;
> +		return 0;
> +	case SCRUB_ENABLE_BACKGROUND:
> +		if (ops->get_enabled_bg && ops->set_enabled_bg)
> +			return a->mode;
> +		if (ops->get_enabled_bg)
> +			return 0444;
> +		return 0;
> +	case SCRUB_ENABLE_ON_DEMAND:
> +		if (ops->get_enabled_od && ops->set_enabled_od)
> +			return a->mode;
> +		if (ops->get_enabled_od)
> +			return 0444;
> +		return 0;
> +	case SCRUB_MIN_CYCLE_DURATION:
> +		return ops->min_cycle_read ? a->mode : 0;
> +	case SCRUB_MAX_CYCLE_DURATION:
> +		return ops->max_cycle_read ? a->mode : 0;
> +	case SCRUB_CURRENT_CYCLE_DURATION:
> +		if (ops->cycle_duration_read && ops->cycle_duration_write)
> +			return a->mode;
> +		if (ops->cycle_duration_read)
> +			return 0444;
> +		return 0;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +#define EDAC_SCRUB_ATTR_RO(_name, _instance)       \
> +	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_RO(_name), \
> +				     .instance = _instance })
> +
> +#define EDAC_SCRUB_ATTR_WO(_name, _instance)       \
> +	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_WO(_name), \
> +				     .instance = _instance })
> +
> +#define EDAC_SCRUB_ATTR_RW(_name, _instance)       \
> +	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_RW(_name), \
> +				     .instance = _instance })
> +
> +static int scrub_create_desc(struct device *scrub_dev,
> +			     const struct attribute_group **attr_groups,
> +			     u8 instance)
> +{
> +	struct edac_scrub_context *scrub_ctx;
> +	struct attribute_group *group;
> +	int i;
> +
> +	scrub_ctx = devm_kzalloc(scrub_dev, sizeof(*scrub_ctx), GFP_KERNEL);
> +	if (!scrub_ctx)
> +		return -ENOMEM;
> +
> +	group = &scrub_ctx->group;
> +	scrub_ctx->scrub_dev_attr[0] = EDAC_SCRUB_ATTR_RW(addr_range_base, instance);
> +	scrub_ctx->scrub_dev_attr[1] = EDAC_SCRUB_ATTR_RW(addr_range_size, instance);
> +	scrub_ctx->scrub_dev_attr[2] = EDAC_SCRUB_ATTR_RW(enable_background, instance);
> +	scrub_ctx->scrub_dev_attr[3] = EDAC_SCRUB_ATTR_RW(enable_on_demand, instance);
> +	scrub_ctx->scrub_dev_attr[4] = EDAC_SCRUB_ATTR_RO(min_cycle_duration, instance);
> +	scrub_ctx->scrub_dev_attr[5] = EDAC_SCRUB_ATTR_RO(max_cycle_duration, instance);
> +	scrub_ctx->scrub_dev_attr[6] = EDAC_SCRUB_ATTR_RW(current_cycle_duration, instance);
> +	for (i = 0; i < SCRUB_MAX_ATTRS; i++)
> +		scrub_ctx->scrub_attrs[i] = &scrub_ctx->scrub_dev_attr[i].dev_attr.attr;
> +
> +	sprintf(scrub_ctx->name, "%s%d", "scrub", instance);
> +	group->name = scrub_ctx->name;
> +	group->attrs = scrub_ctx->scrub_attrs;
> +	group->is_visible  = scrub_attr_visible;
> +
> +	attr_groups[0] = group;
> +
> +	return 0;
> +}
> +
> +/**
> + * edac_scrub_get_desc - get EDAC scrub descriptors
> + * @scrub_dev: client device, with scrub support
> + * @attr_groups: pointer to attrribute group container
> + * @instance: device's scrub instance number.
> + *
> + * Returns 0 on success, error otherwise.
> + */
> +int edac_scrub_get_desc(struct device *scrub_dev,
> +			const struct attribute_group **attr_groups,
> +			u8 instance)
> +{
> +	if (!scrub_dev || !attr_groups)
> +		return -EINVAL;
> +
> +	return scrub_create_desc(scrub_dev, attr_groups, instance);
> +}
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index b337254cf5b8..aae8262b9863 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -674,6 +674,36 @@ enum edac_dev_feat {
>  	RAS_FEAT_MAX
>  };
>  
> +/**
> + * struct scrub_ops - scrub device operations (all elements optional)
> + * @read_range: read base and offset of scrubbing range.
> + * @write_range: set the base and offset of the scrubbing range.
> + * @get_enabled_bg: check if currently performing background scrub.
> + * @set_enabled_bg: start or stop a bg-scrub.
> + * @get_enabled_od: check if currently performing on-demand scrub.
> + * @set_enabled_od: start or stop an on-demand scrub.
> + * @min_cycle_read: minimum supported scrub cycle duration in seconds.
> + * @max_cycle_read: maximum supported scrub cycle duration in seconds.
> + * @cycle_duration_read: get the scrub cycle duration in seconds.
> + * @cycle_duration_write: set the scrub cycle duration in seconds.
> + */
> +struct edac_scrub_ops {
> +	int (*read_range)(struct device *dev, void *drv_data, u64 *base, u64 *size);
> +	int (*write_range)(struct device *dev, void *drv_data, u64 base, u64 size);
> +	int (*get_enabled_bg)(struct device *dev, void *drv_data, bool *enable);
> +	int (*set_enabled_bg)(struct device *dev, void *drv_data, bool enable);
> +	int (*get_enabled_od)(struct device *dev, void *drv_data, bool *enable);
> +	int (*set_enabled_od)(struct device *dev, void *drv_data, bool enable);
> +	int (*min_cycle_read)(struct device *dev, void *drv_data,  u32 *min);
> +	int (*max_cycle_read)(struct device *dev, void *drv_data,  u32 *max);
> +	int (*cycle_duration_read)(struct device *dev, void *drv_data, u32 *cycle);
> +	int (*cycle_duration_write)(struct device *dev, void *drv_data, u32 cycle);
> +};
> +
> +int edac_scrub_get_desc(struct device *scrub_dev,
> +			const struct attribute_group **attr_groups,
> +			u8 instance);
> +
>  struct edac_ecs_ex_info {
>  	u16 num_media_frus;
>  };
> -- 
> 2.34.1
> 

-- 
Fan Ni

