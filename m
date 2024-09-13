Return-Path: <linux-edac+bounces-1872-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 373A99786AA
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2024 19:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF68281FBE
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2024 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787CB839F4;
	Fri, 13 Sep 2024 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ATd/QGnl"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EE46F31E;
	Fri, 13 Sep 2024 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248368; cv=none; b=MqW4q16Ugxga6+cIwhdSm8EKGaxSAf1UGppD9HqxSzFfZVHDVRl8DBR+niRfLO2AC8Q79qUm0oxZ6VptDdQM9HfzWmSo08RSEoHCw3J0v1wuv75E2PPIXEgEp56+qn4CawDGkOd+XDWdsFYV2Ya3ejWKWQXBCiQNdsTDTdnSZiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248368; c=relaxed/simple;
	bh=8oTPHCz2KorxwV9IC+fDv1wLQHsGwNgw2t8CJlbhXc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApsTeb6QnmkXQ8YK7s4sf991LJflz/x9Z4etF0Idg49h3wUmG1FnyVYt/bcDy/dmBr0lrGzDMZbH18AWRR1cogvy1jPJ0WoHQMerhD3eC7KTf0iPCJ48yl98lWgvQJjcsRIt1IZSxgSaIs4iizvD0DAS5+NQMqcdjmsD+Ibl2lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ATd/QGnl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 94C3940E0198;
	Fri, 13 Sep 2024 17:26:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id w9MX5iGtQunN; Fri, 13 Sep 2024 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1726248355; bh=VeexcbgWqgsh6CYjHWJYIUKpU55fAG+lFWK0MCUu4c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATd/QGnlin1yLFMughNTsVwf2cz5756cAwjGMWvRGwi+6moj7tDp8Fw6IZ6HQc1uy
	 bu/YNMqPZ6fYoIdc8TvKV0mUt060ajCs3pJAuX6d97d2Btz3cIr+Cq6O3D68M478f9
	 gC9z2oY0E2kg0NyGQGf7ymxnukZzJhwRh14V8QKvhlmBU8Se1cjSF8gmLNAcBd5+kK
	 +cZ15HQnsAQDET8bzrnazXo/wE0dmbLF5x2uDOW7Lcl+lqOxHZqyHxqUlmhZ2oyg+G
	 PlBF2W6Qrfe5Jr7pH/o5sYJjwHKOhIEu7PX9y3quk24eojT38Zo0h7aeY1MJbBzRLJ
	 l7xs3AlgKnEKy2e7SYBMr8v/tQ0a8tFD4zyWRTUxyCI8YJ5T4QsHxGeAePkEAxVl90
	 LgmsCrGhbD5yBqXz4DbCJVNrI9u92Dt25NO6K8QoUcLiMrgosf90PU6dD8+gtgKHCV
	 bX+mCXiuDu5BJZvfhEbvijxjlVcuHyG5bjkQ2CfQEUpEKKaei+yTyGr2mioodIJa/6
	 ClUSncjq3WFeJoxCMQ9yuTKU8k7MGowU13kw05uBrGcM6v90+AXzG4tswPU8uvbILd
	 fhkrQub2lulvHCkqcQDgIk35vVv20/iUPA0yNhDCoLUMllX0CqidYkOiSB1j/9liCR
	 qcR2SXubjD0PfG3JQ/J0M970=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A150140E0289;
	Fri, 13 Sep 2024 17:25:08 +0000 (UTC)
Date: Fri, 13 Sep 2024 19:25:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
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
Message-ID: <20240913172501.GLZuR1bWp0aYXaYfw7@fat_crate.local>
References: <20240911090447.751-1-shiju.jose@huawei.com>
 <20240911090447.751-3-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911090447.751-3-shiju.jose@huawei.com>

On Wed, Sep 11, 2024 at 10:04:31AM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add generic EDAC scrub control driver supports configuring the memory scrubbers

s/supports configuring the/in order to configure/

> in the system. The device with scrub feature, get the scrub descriptor from the
> EDAC scrub and registers with the EDAC RAS feature driver, which adds the sysfs
> scrub control interface.

That sentence reads wrong.

> The scrub control attributes for a scrub instance are
> available to userspace in /sys/bus/edac/devices/<dev-name>/scrub*/.
> 
> Generic EDAC scrub driver and the common sysfs scrub interface promotes
> unambiguous access from the userspace irrespective of the underlying scrub
> devices.

Huh?

Do you wanna say something along the lines that the common sysfs scrub
interface abstracts the control of an arbitrary scrubbing functionality into
a common set of functions or so?

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

...

> +What:		/sys/bus/edac/devices/<dev-name>/scrub*/current_cycle_duration
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The current scrub cycle duration in seconds and must be
> +		within the supported range by the memory scrubber.

So in reading about that interface, where is the user doc explaining how one
should use scrubbers?

> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 4edfb83ffbee..fbf0e39ec678 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
>  
>  edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
>  edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
> +edac_core-y	+= edac_scrub.o

Just scrub.[co]. The file is already in drivers/edac/. Too many "edac"
strings. :)

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

Can all that repetitive code be abstracted away in macros pls?

Below too.

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

No silly linebreaks like that pls. Check your whole patchset.

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

		if (...read_range) {
			if (...write_range)
				return a->mode;
			else
				return 0444:
		}
		break;

and now put a single "return 0;" at the end of the function.

Below too.

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

		if (ops->min_cycle_read)
			return a->mode;

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

Why use the naked numbers when you have enum edac_scrub_attributes?

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

+ * @attr_groups: pointer to attrribute group container
Unknown word [attrribute] in comment.
Suggestions: ['attribute', 'attributed', 'attributes', "attribute's", 'attributive', 'tribute']

Please introduce a spellchecker into your patch creation workflow.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

