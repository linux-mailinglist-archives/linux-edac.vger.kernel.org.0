Return-Path: <linux-edac+bounces-2470-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB659C133C
	for <lists+linux-edac@lfdr.de>; Fri,  8 Nov 2024 01:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F8A1C222D8
	for <lists+linux-edac@lfdr.de>; Fri,  8 Nov 2024 00:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3935023AD;
	Fri,  8 Nov 2024 00:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo0axgXJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C0BA27;
	Fri,  8 Nov 2024 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731026185; cv=none; b=l+Rhg5fjabG7/hlP0owz3U+HcUQWH4de8IIlFAZrBlNQG7D89s6+6l+iqfHhotigDGDIW+pi8yQfeZ8LSaLnTCugWW176S7j3+f9ULwEcK2/aOpp2gQNx0kDV3C2iPNVGNrn4mT4K8bLKRiktPi4lVUKQzfEkJNmNHD8kN7UkgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731026185; c=relaxed/simple;
	bh=mxe6s/Gxf58O5Bv1Uja9mwxgeNp5mq6+g11SngRjXnA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ic7juJECtRCyilFn4Uyiuw5qDIR7eyu3cNfYoN5lUS57jmoj41svP5FTHYn+9lfpuTd2p4VUmD19HDt/3WRKazWJMBZYGI/jU2WV9xBAqIsABk6TNg4fiR4IVQvfzS3lHNcfKj4m5SXQcJ10isIW7T5WKcPxH41J3icUnF4jXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo0axgXJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-720c2db824eso1619838b3a.0;
        Thu, 07 Nov 2024 16:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731026182; x=1731630982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CjUJNAqUSD0fpIJN7hsUnikhrlQCt4BCY1mQOMqITlo=;
        b=Oo0axgXJPLcRa1GqH4WuiQToa0RxKTStTFSqcqhIOgoEryj0/H93cbMnP9RFLtoSLO
         Fc44zgbkPgNw2YqKT6BZC9xo/wr+VHT2P8dJd5CMYzzG8DW0cAASZO9m85T/Qe32bSV9
         WVZ67Gqsk+eI/xWoF8lMFDcG5uZKw9P43jlwJ+av80S9BVZgSGSbax66cEK6BknPsQO4
         59KJILT/hCTaNHMGrkSfTvBo1Rgw6Dj+rw1iFMX4ftcZl79ArtN4OzfX6md84mGQlnAA
         XfLTIMuOx5TgBy5qbw9akYeFqAhJlVuL+irZ7pCWwO9m5b+Xgg4pZTP0LXWojWJpQ9DE
         cqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731026182; x=1731630982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjUJNAqUSD0fpIJN7hsUnikhrlQCt4BCY1mQOMqITlo=;
        b=Z5tSpzgj//uRWhTb2BDRdEw+Z0NefwXMzpL7/YSDiWMkWZ6EW1lLu3mjP8/LPEs3K3
         2TcLwZtf945dbhdFkTQ8zMs2ntw5tceP1V0UPlHhsG292mFXLD2uTAyu5Mr0QGqEQ08B
         lGCNvbCQLf2OBPSg9b6+mxD+R5AypVNGcsN7c21iMuu13hmBY2Qa5VH9FRKhNugnE2zk
         lhMK74BQ8BueOBGytshMtkqf8Daa+CJe2MWM15xCsVzEcoQxDsyTxSE6L26RKZHdA26t
         ZNfWMVU1b3UHjc2uYY08IZOhI21Nd2iVpmKzruz3ACoRH5K2chnkPjjc5/hmb8rivhjY
         JraQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE8JYIATFqUZXlhIOFqMTVXOo1gQXHvqfXDZKKRWlDPrwywkXWo9yF5oNIXwHhJXXuZsj+zkdvsthL@vger.kernel.org, AJvYcCVPBHh5Bih0YwM4Pn5VOJBBVjB4DVYoiGGZk5TOHM90ARG7yex+jjzJXb1KtYuxLs9wMq95MRZCg0yFTGsV@vger.kernel.org, AJvYcCXBQ1yYHR2JJtNONwVbT8ymURDuGORiX/d6w91O4xAKxbN9ctCQ0YMXHBNWODf08PCbp+67okT2cY4j@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMgb66fKpOJof024dxtNeDWp3el9VmAtKzSPqdIZL8MZ21hm0
	/r2jcRESQU/FyqQMIFLoWURA/xs+6B9uc8jeHEgLjiARmeV69eOd
X-Google-Smtp-Source: AGHT+IGSNyH5XzLu6nhj/EOmVCetKhN54ggz5hDC7V0Mbx8kGXnmU8chmzVyuRxDOUtddvysNrWqxQ==
X-Received: by 2002:aa7:8882:0:b0:71e:6c67:2ebf with SMTP id d2e1a72fcca58-724132bff58mr1393036b3a.11.1731026182280;
        Thu, 07 Nov 2024 16:36:22 -0800 (PST)
Received: from fan ([2601:646:8f03:9fee:6ed1:b454:5fd2:3850])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a3d38sm2429530b3a.122.2024.11.07.16.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 16:36:21 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 7 Nov 2024 16:36:17 -0800
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
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
Subject: Re: [PATCH v15 02/15] EDAC: Add scrub control feature
Message-ID: <Zy1dAazN9OPR0POI@fan>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
 <20241101091735.1465-3-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101091735.1465-3-shiju.jose@huawei.com>

On Fri, Nov 01, 2024 at 09:17:20AM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add a generic EDAC scrub control to manage memory scrubbers in the system.
> Devices with a scrub feature register with the EDAC device driver, which
> retrieves the scrub descriptor from the EDAC scrub driver and exposes the
> sysfs scrub control attributes for a scrub instance to userspace at
> /sys/bus/edac/devices/<dev-name>/scrubX/.
> 
> The common sysfs scrub control interface abstracts the control of
> arbitrary scrubbing functionality into a common set of functions. The
> sysfs scrub attribute nodes are only present if the client driver has
> implemented the corresponding attribute callback function and passed the
> operations(ops) to the EDAC device driver during registration.
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---

Minor comments inline.

>  Documentation/ABI/testing/sysfs-edac-scrub |  74 ++++++++
>  drivers/edac/Makefile                      |   1 +
>  drivers/edac/edac_device.c                 |  40 +++-
>  drivers/edac/scrub.c                       | 209 +++++++++++++++++++++
>  include/linux/edac.h                       |  34 ++++
>  5 files changed, 354 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-edac-scrub
>  create mode 100755 drivers/edac/scrub.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-edac-scrub b/Documentation/ABI/testing/sysfs-edac-scrub
> new file mode 100644
> index 000000000000..d8d11165ff2a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-edac-scrub
  
...

> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index e9229b5f8afe..cd700a64406e 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -576,6 +576,7 @@ static void edac_dev_release(struct device *dev)
>  {
>  	struct edac_dev_feat_ctx *ctx = container_of(dev, struct edac_dev_feat_ctx, dev);
>  
> +	kfree(ctx->scrub);
>  	kfree(ctx->dev.groups);
>  	kfree(ctx);
>  }
> @@ -609,6 +610,8 @@ int edac_dev_register(struct device *parent, char *name,
>  		      const struct edac_dev_feature *ras_features)
>  {
>  	const struct attribute_group **ras_attr_groups;
> +	int scrub_cnt = 0, scrub_inst = 0;
> +	struct edac_dev_data *dev_data;
>  	struct edac_dev_feat_ctx *ctx;
>  	int attr_gcnt = 0;
>  	int ret, feat;
> @@ -619,7 +622,10 @@ int edac_dev_register(struct device *parent, char *name,
>  	/* Double parse to make space for attributes */
>  	for (feat = 0; feat < num_features; feat++) {
>  		switch (ras_features[feat].ft_type) {
> -		/* Add feature specific code */
> +		case RAS_FEAT_SCRUB:
> +			attr_gcnt++;
> +			scrub_cnt++;
> +			break;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -635,13 +641,37 @@ int edac_dev_register(struct device *parent, char *name,
>  		goto ctx_free;
>  	}
>  
> +	if (scrub_cnt) {
> +		ctx->scrub = kcalloc(scrub_cnt, sizeof(*ctx->scrub), GFP_KERNEL);
> +		if (!ctx->scrub) {
> +			ret = -ENOMEM;
> +			goto groups_free;
> +		}
> +	}
> +
>  	attr_gcnt = 0;

If we use scrub_cnt the same way as we use attr_gcnt, we do not need
scrub_inst.

Fan
>  	for (feat = 0; feat < num_features; feat++, ras_features++) {
>  		switch (ras_features->ft_type) {
> -		/* Add feature specific code */
> +		case RAS_FEAT_SCRUB:
> +			if (!ras_features->scrub_ops ||
> +			    scrub_inst != ras_features->instance)
> +				goto data_mem_free;
> +
> +			dev_data = &ctx->scrub[scrub_inst];
> +			dev_data->instance = scrub_inst;
> +			dev_data->scrub_ops = ras_features->scrub_ops;
> +			dev_data->private = ras_features->ctx;
> +			ret = edac_scrub_get_desc(parent, &ras_attr_groups[attr_gcnt],
> +						  ras_features->instance);
> +			if (ret)
> +				goto data_mem_free;
> +
> +			scrub_inst++;
> +			attr_gcnt++;
> +			break;
>  		default:
>  			ret = -EINVAL;
> -			goto groups_free;
> +			goto data_mem_free;
>  		}
>  	}
>  
> @@ -654,7 +684,7 @@ int edac_dev_register(struct device *parent, char *name,
>  
>  	ret = dev_set_name(&ctx->dev, name);
>  	if (ret)
> -		goto groups_free;
> +		goto data_mem_free;
>  
>  	ret = device_register(&ctx->dev);
>  	if (ret) {
> @@ -664,6 +694,8 @@ int edac_dev_register(struct device *parent, char *name,
>  
>  	return devm_add_action_or_reset(parent, edac_dev_unreg, &ctx->dev);
>  
> +data_mem_free:
> +	kfree(ctx->scrub);
>  groups_free:
>  	kfree(ras_attr_groups);
>  ctx_free:
> diff --git a/drivers/edac/scrub.c b/drivers/edac/scrub.c
> new file mode 100755
> index 000000000000..3978201c4bfc
> --- /dev/null
> +++ b/drivers/edac/scrub.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The generic EDAC scrub driver controls the memory scrubbers in the
> + * system. The common sysfs scrub interface abstracts the control of
> + * various arbitrary scrubbing functionalities into a unified set of
> + * functions.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + */
> +
> +#include <linux/edac.h>
> +
> +enum edac_scrub_attributes {
> +	SCRUB_ADDRESS,
> +	SCRUB_SIZE,
> +	SCRUB_ENABLE_BACKGROUND,
> +	SCRUB_MIN_CYCLE_DURATION,
> +	SCRUB_MAX_CYCLE_DURATION,
> +	SCRUB_CUR_CYCLE_DURATION,
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
> +#define TO_SCRUB_DEV_ATTR(_dev_attr)      \
> +		container_of(_dev_attr, struct edac_scrub_dev_attr, dev_attr)
> +
> +#define EDAC_SCRUB_ATTR_SHOW(attrib, cb, type, format)				\
> +static ssize_t attrib##_show(struct device *ras_feat_dev,			\
> +			     struct device_attribute *attr, char *buf)		\
> +{										\
> +	u8 inst = TO_SCRUB_DEV_ATTR(attr)->instance;				\
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;		\
> +	type data;								\
> +	int ret;								\
> +										\
> +	ret = ops->cb(ras_feat_dev->parent, ctx->scrub[inst].private, &data);	\
> +	if (ret)								\
> +		return ret;							\
> +										\
> +	return sysfs_emit(buf, format, data);					\
> +}
> +
> +EDAC_SCRUB_ATTR_SHOW(addr, read_addr, u64, "0x%llx\n")
> +EDAC_SCRUB_ATTR_SHOW(size, read_size, u64, "0x%llx\n")
> +EDAC_SCRUB_ATTR_SHOW(enable_background, get_enabled_bg, bool, "%u\n")
> +EDAC_SCRUB_ATTR_SHOW(min_cycle_duration, get_min_cycle, u32, "%u\n")
> +EDAC_SCRUB_ATTR_SHOW(max_cycle_duration, get_max_cycle, u32, "%u\n")
> +EDAC_SCRUB_ATTR_SHOW(current_cycle_duration, get_cycle_duration, u32, "%u\n")
> +
> +#define EDAC_SCRUB_ATTR_STORE(attrib, cb, type, conv_func)			\
> +static ssize_t attrib##_store(struct device *ras_feat_dev,			\
> +			      struct device_attribute *attr,			\
> +			      const char *buf, size_t len)			\
> +{										\
> +	u8 inst = TO_SCRUB_DEV_ATTR(attr)->instance;				\
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;		\
> +	type data;								\
> +	int ret;								\
> +										\
> +	ret = conv_func(buf, 0, &data);						\
> +	if (ret < 0)								\
> +		return ret;							\
> +										\
> +	ret = ops->cb(ras_feat_dev->parent, ctx->scrub[inst].private, data);	\
> +	if (ret)								\
> +		return ret;							\
> +										\
> +	return len;								\
> +}
> +
> +EDAC_SCRUB_ATTR_STORE(addr, write_addr, u64, kstrtou64)
> +EDAC_SCRUB_ATTR_STORE(size, write_size, u64, kstrtou64)
> +EDAC_SCRUB_ATTR_STORE(enable_background, set_enabled_bg, unsigned long, kstrtoul)
> +EDAC_SCRUB_ATTR_STORE(current_cycle_duration, set_cycle_duration, unsigned long, kstrtoul)
> +
> +static umode_t scrub_attr_visible(struct kobject *kobj, struct attribute *a, int attr_id)
> +{
> +	struct device *ras_feat_dev = kobj_to_dev(kobj);
> +	struct device_attribute *dev_attr = container_of(a, struct device_attribute, attr);
> +	u8 inst = TO_SCRUB_DEV_ATTR(dev_attr)->instance;
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
> +
> +	switch (attr_id) {
> +	case SCRUB_ADDRESS:
> +		if (ops->read_addr) {
> +			if (ops->write_addr)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case SCRUB_SIZE:
> +		if (ops->read_size) {
> +			if (ops->write_size)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case SCRUB_ENABLE_BACKGROUND:
> +		if (ops->get_enabled_bg) {
> +			if (ops->set_enabled_bg)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case SCRUB_MIN_CYCLE_DURATION:
> +		if (ops->get_min_cycle)
> +			return a->mode;
> +		break;
> +	case SCRUB_MAX_CYCLE_DURATION:
> +		if (ops->get_max_cycle)
> +			return a->mode;
> +		break;
> +	case SCRUB_CUR_CYCLE_DURATION:
> +		if (ops->get_cycle_duration) {
> +			if (ops->set_cycle_duration)
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
> +#define EDAC_SCRUB_ATTR_RO(_name, _instance)       \
> +	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_RO(_name), \
> +					.instance = _instance })
> +
> +#define EDAC_SCRUB_ATTR_WO(_name, _instance)       \
> +	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_WO(_name), \
> +					.instance = _instance })
> +
> +#define EDAC_SCRUB_ATTR_RW(_name, _instance)       \
> +	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_RW(_name), \
> +					.instance = _instance })
> +
> +static int scrub_create_desc(struct device *scrub_dev,
> +			     const struct attribute_group **attr_groups, u8 instance)
> +{
> +	struct edac_scrub_context *scrub_ctx;
> +	struct attribute_group *group;
> +	int i;
> +	struct edac_scrub_dev_attr dev_attr[] = {
> +		[SCRUB_ADDRESS] = EDAC_SCRUB_ATTR_RW(addr, instance),
> +		[SCRUB_SIZE] = EDAC_SCRUB_ATTR_RW(size, instance),
> +		[SCRUB_ENABLE_BACKGROUND] = EDAC_SCRUB_ATTR_RW(enable_background, instance),
> +		[SCRUB_MIN_CYCLE_DURATION] = EDAC_SCRUB_ATTR_RO(min_cycle_duration, instance),
> +		[SCRUB_MAX_CYCLE_DURATION] = EDAC_SCRUB_ATTR_RO(max_cycle_duration, instance),
> +		[SCRUB_CUR_CYCLE_DURATION] = EDAC_SCRUB_ATTR_RW(current_cycle_duration, instance)
> +	};
> +
> +	scrub_ctx = devm_kzalloc(scrub_dev, sizeof(*scrub_ctx), GFP_KERNEL);
> +	if (!scrub_ctx)
> +		return -ENOMEM;
> +
> +	group = &scrub_ctx->group;
> +	for (i = 0; i < SCRUB_MAX_ATTRS; i++) {
> +		memcpy(&scrub_ctx->scrub_dev_attr[i], &dev_attr[i], sizeof(dev_attr[i]));
> +		scrub_ctx->scrub_attrs[i] = &scrub_ctx->scrub_dev_attr[i].dev_attr.attr;
> +	}
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
> + * @attr_groups: pointer to attribute group container
> + * @instance: device's scrub instance number.
> + *
> + * Return:
> + *  * %0	- Success.
> + *  * %-EINVAL	- Invalid parameters passed.
> + *  * %-ENOMEM	- Dynamic memory allocation failed.
> + */
> +int edac_scrub_get_desc(struct device *scrub_dev,
> +			const struct attribute_group **attr_groups, u8 instance)
> +{
> +	if (!scrub_dev || !attr_groups)
> +		return -EINVAL;
> +
> +	return scrub_create_desc(scrub_dev, attr_groups, instance);
> +}
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index e19706311ec0..3620a09c0476 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -668,11 +668,43 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
>  
>  /* RAS feature type */
>  enum edac_dev_feat {
> +	RAS_FEAT_SCRUB,
>  	RAS_FEAT_MAX
>  };
>  
> +/**
> + * struct edac_scrub_ops - scrub device operations (all elements optional)
> + * @read_addr: read base address of scrubbing range.
> + * @read_size: read offset of scrubbing range.
> + * @write_addr: set base address of the scrubbing range.
> + * @write_size: set offset of the scrubbing range.
> + * @get_enabled_bg: check if currently performing background scrub.
> + * @set_enabled_bg: start or stop a bg-scrub.
> + * @get_min_cycle: get minimum supported scrub cycle duration in seconds.
> + * @get_max_cycle: get maximum supported scrub cycle duration in seconds.
> + * @get_cycle_duration: get current scrub cycle duration in seconds.
> + * @set_cycle_duration: set current scrub cycle duration in seconds.
> + */
> +struct edac_scrub_ops {
> +	int (*read_addr)(struct device *dev, void *drv_data, u64 *base);
> +	int (*read_size)(struct device *dev, void *drv_data, u64 *size);
> +	int (*write_addr)(struct device *dev, void *drv_data, u64 base);
> +	int (*write_size)(struct device *dev, void *drv_data, u64 size);
> +	int (*get_enabled_bg)(struct device *dev, void *drv_data, bool *enable);
> +	int (*set_enabled_bg)(struct device *dev, void *drv_data, bool enable);
> +	int (*get_min_cycle)(struct device *dev, void *drv_data,  u32 *min);
> +	int (*get_max_cycle)(struct device *dev, void *drv_data,  u32 *max);
> +	int (*get_cycle_duration)(struct device *dev, void *drv_data, u32 *cycle);
> +	int (*set_cycle_duration)(struct device *dev, void *drv_data, u32 cycle);
> +};
> +
> +int edac_scrub_get_desc(struct device *scrub_dev,
> +			const struct attribute_group **attr_groups,
> +			u8 instance);
> +
>  /* EDAC device feature information structure */
>  struct edac_dev_data {
> +	const struct edac_scrub_ops *scrub_ops;
>  	u8 instance;
>  	void *private;
>  };
> @@ -680,11 +712,13 @@ struct edac_dev_data {
>  struct edac_dev_feat_ctx {
>  	struct device dev;
>  	void *private;
> +	struct edac_dev_data *scrub;
>  };
>  
>  struct edac_dev_feature {
>  	enum edac_dev_feat ft_type;
>  	u8 instance;
> +	const struct edac_scrub_ops *scrub_ops;
>  	void *ctx;
>  };
>  
> -- 
> 2.34.1
> 

-- 
Fan Ni

