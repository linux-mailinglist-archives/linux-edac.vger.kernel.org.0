Return-Path: <linux-edac+bounces-1531-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEFF932F97
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jul 2024 20:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A267B22BC3
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jul 2024 18:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0A91A00FC;
	Tue, 16 Jul 2024 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIcoFejX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25319DF50;
	Tue, 16 Jul 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152869; cv=none; b=gpfmeDxO3P5VGaUWluJTZdN15+JuqIPyO+XXcHVCYsPouVxWkbGMRyUURdqkU6vI+lFP7b79G7TdpJc1AHepS7+vn0AAOLWruphrVzmAhg5VCKXY80wbDvA4xxGuYtE80qcGv1uDKSSC6YVhccHReW36Gx1TecF73pXueM9qodo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152869; c=relaxed/simple;
	bh=KR/9+FSOLnHKUZvGl6uia0Q1acLO/mzhJgsAr7JoUoM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7z7gYwZsRnHttfMV04nOVo1au0gkKK6Wmfz/VRvlQeMSDvXknLZaqgdZfCKsTawxvoWFimUjGQpV1LzFsFc2A4WgyL+KIyE1FJS63L8qRCi/IzhWN2XkDBT8I8V41GRRtot+x+6U2+E+O3r8LdWDpOoJ5xARIHtLRU8+bScpvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIcoFejX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-71871d5e087so4313310a12.1;
        Tue, 16 Jul 2024 11:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721152867; x=1721757667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1C1Q6iQjSP7jJaIPmzSv+qHxYtW3M+ElpgX8xl2QsM=;
        b=XIcoFejXsus21r7IqF95bZlAqGz9vP8XwuS/eaJLAUUdYHcW0Ap56mzaYJywWmhEX1
         gyOVJnXx3pTrKD5pRl5P3ePhC15jLU/TGCwp5moASa+3BZNQ3T+JC0+ogkUE15fDS0XZ
         fJHOKmwxi6Yty9CuqMX48MBIJZ/OMrAMEHjz9tZTlXYhZvV7520+5RfDXxtZH31pi1JG
         KobUokUiP/cOBcvEpa+rdcdHrTSgpOGUCI337Sa/uuZ3vQtxoHGfZb/yPwi7tIHy6Blc
         kB0wB+vMO0V4o6HqWa5a1kGWDEV+cSF6lHC1pClXiin4th9w3ArKEMCnuIgnYkp+V2MU
         FEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721152867; x=1721757667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1C1Q6iQjSP7jJaIPmzSv+qHxYtW3M+ElpgX8xl2QsM=;
        b=N2b/jm8wNMOIajoapwEsNbtHgNe89bPg6z7CJuQiNswKC2wq5VXILaTcJSRayei/zS
         r/CK9HM210kYfnmpaRze9/cRkUxo0BT1jc0Cfmr2rfrGN9p/eo7CCkvnSRzFXLscCzpU
         hz1lZzsNNStIMk+73q2Zzb1YHo0bVBALdnkHyU03Kqgk5WtP+qRTqMgLQ6XqwbbxK1eJ
         qMlfKeK+ECpr8LeZQpPYBxBhpdocouvv2kqx/1G97uTe/fmmWxSXBn5B/wh4KgbTc26z
         co6UgbKc2AqejSfrXsuhrmxjaTka/ZywoDivTntg9KSb/OF+s54PypJpqP8crggjHtRO
         NY3w==
X-Forwarded-Encrypted: i=1; AJvYcCUf5iIdsIybEiuYBFxfnzCtW7hxPCNEfdIP4NhCqF+wrzJ0zqNJj6kbmm3qDu++BA42vvOhfNQFunFfORFQtXco3sT281XCHNPxEihKDL4HRYe96xETx2aC6Thx+sVlhK4bObsbxLgI55YjdA6XqOxSHj9CqsEni2Zxnm4LYcNTg09OtA==
X-Gm-Message-State: AOJu0YxNlEIhmCq93IWga9G4So5tvxN5fkfMg5W3VbFP7jnvif4nQRpg
	x+RhdqiF9kSfKxE3Ev50zHCwPGxEwTEhCYcWvtrxfc2N3y+dtBhH
X-Google-Smtp-Source: AGHT+IFtDdCXzBbpOEOVaX0vdT2j/8BHFC/NJmlOuKch/r1HJV8JlFsde906AZeDoj+jcBOzp4et2Q==
X-Received: by 2002:a05:6a20:72a6:b0:1c0:e4d6:9bec with SMTP id adf61e73a8af0-1c3f11f31e9mr3823389637.7.1721152867104;
        Tue, 16 Jul 2024 11:01:07 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:9e58:7df9:6d36:6c31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b81972f56sm6398629b3a.84.2024.07.16.11.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:01:06 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 16 Jul 2024 11:00:48 -0700
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
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [RFC PATCH v9 01/11] EDAC: Add generic EDAC RAS feature driver
Message-ID: <Zpa1UNTOcJgcq2q5@debian>
References: <20240716150336.2042-1-shiju.jose@huawei.com>
 <20240716150336.2042-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716150336.2042-2-shiju.jose@huawei.com>

On Tue, Jul 16, 2024 at 04:03:25PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add generic EDAC driver supports registering RAS features supported
> in the system. The driver exposes feature's control attributes to the
> userspace in /sys/bus/edac/devices/<dev-name>/<ras-feature>/
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/edac/Makefile            |   1 +
>  drivers/edac/edac_ras_feature.c  | 155 +++++++++++++++++++++++++++++++
>  include/linux/edac_ras_feature.h |  66 +++++++++++++
>  3 files changed, 222 insertions(+)
>  create mode 100755 drivers/edac/edac_ras_feature.c
>  create mode 100755 include/linux/edac_ras_feature.h
> 
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 9c09893695b7..c532b57a6d8a 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
>  
>  edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
>  edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
> +edac_core-y	+= edac_ras_feature.o
>  
>  edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
>  
> diff --git a/drivers/edac/edac_ras_feature.c b/drivers/edac/edac_ras_feature.c
> new file mode 100755
> index 000000000000..24a729fea66f
> --- /dev/null
> +++ b/drivers/edac/edac_ras_feature.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * EDAC RAS control feature driver supports registering RAS
> + * features with the EDAC and exposes the feature's control
> + * attributes to the userspace in sysfs.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + */
> +
> +#define pr_fmt(fmt)     "EDAC RAS CONTROL FEAT: " fmt
> +
> +#include <linux/edac_ras_feature.h>
> +
> +static void edac_ras_dev_release(struct device *dev)
> +{
> +	struct edac_ras_feat_ctx *ctx =
> +		container_of(dev, struct edac_ras_feat_ctx, dev);
> +
> +	kfree(ctx);
> +}
> +
> +const struct device_type edac_ras_dev_type = {
> +	.name = "edac_ras_dev",
> +	.release = edac_ras_dev_release,
> +};
> +
> +static void edac_ras_dev_unreg(void *data)
> +{
> +	device_unregister(data);
> +}
> +
> +static int edac_ras_feat_scrub_init(struct device *parent,
> +				    struct edac_scrub_data *sdata,
> +				    const struct edac_ras_feature *sfeat,
> +				    const struct attribute_group **attr_groups)
> +{
> +	sdata->ops = sfeat->scrub_ops;
> +	sdata->private = sfeat->scrub_ctx;
> +
> +	return 1;
> +}
> +
> +static int edac_ras_feat_ecs_init(struct device *parent,
> +				  struct edac_ecs_data *edata,
> +				  const struct edac_ras_feature *efeat,
> +				  const struct attribute_group **attr_groups)
> +{
> +	int num = efeat->ecs_info.num_media_frus;
> +
> +	edata->ops = efeat->ecs_ops;
> +	edata->private = efeat->ecs_ctx;
> +
> +	return num;
> +}
> +
> +/**
> + * edac_ras_dev_register - register device for ras features with edac
> + * @parent: client device.
> + * @name: client device's name.
> + * @private: parent driver's data to store in the context if any.
> + * @num_features: number of ras features to register.
> + * @ras_features: list of ras features to register.
> + *
> + * Returns 0 on success, error otherwise.
> + * The new edac_ras_feat_ctx would be freed automatically.
> + */
> +int edac_ras_dev_register(struct device *parent, char *name,
> +			  void *private, int num_features,
> +			  const struct edac_ras_feature *ras_features)
> +{
> +	const struct attribute_group **ras_attr_groups;
> +	struct edac_ras_feat_ctx *ctx;
> +	int attr_gcnt = 0;
> +	int ret, feat;
> +
> +	if (!parent || !name || !num_features || !ras_features)
> +		return -EINVAL;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->dev.parent = parent;
> +	ctx->private = private;
> +
> +	/* Double parse so we can make space for attributes */
> +	for (feat = 0; feat < num_features; feat++) {
> +		switch (ras_features[feat].feat) {
> +		case ras_feat_scrub:
> +			attr_gcnt++;
> +			break;
> +		case ras_feat_ecs:
> +			attr_gcnt += ras_features[feat].ecs_info.num_media_frus;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			goto ctx_free;
> +		}
> +	}
> +
> +	ras_attr_groups = devm_kzalloc(parent,
> +				       (attr_gcnt + 1) * sizeof(*ras_attr_groups),
> +				       GFP_KERNEL);
> +	if (!ras_attr_groups) {
> +		ret = -ENOMEM;
> +		goto ctx_free;
> +	}
> +
> +	attr_gcnt = 0;
> +	for (feat = 0; feat < num_features; feat++, ras_features++) {
> +		if (ras_features->feat == ras_feat_scrub) {
> +			if (!ras_features->scrub_ops)
> +				continue;
> +			ret = edac_ras_feat_scrub_init(parent, &ctx->scrub,
> +						       ras_features, &ras_attr_groups[attr_gcnt]);
> +			if (ret < 0)
> +				goto ctx_free;
> +
> +			attr_gcnt += ret;
> +		} else if (ras_features->feat == ras_feat_ecs) {
> +			if (!ras_features->ecs_ops)
> +				continue;
> +			ret = edac_ras_feat_ecs_init(parent, &ctx->ecs,
> +						     ras_features, &ras_attr_groups[attr_gcnt]);
> +			if (ret < 0)
> +				goto ctx_free;
> +
> +			attr_gcnt += ret;
> +		} else {
> +			ret = -EINVAL;
> +			goto ctx_free;
We already check this in the first pass, cannot be reached in the second
pass.
> +		}
Why use if/else instead of using switch/case as above?
> +	}
> +	ras_attr_groups[attr_gcnt] = NULL;
> +	ctx->dev.bus = edac_get_sysfs_subsys();
> +	ctx->dev.type = &edac_ras_dev_type;
> +	ctx->dev.groups = ras_attr_groups;
> +	dev_set_drvdata(&ctx->dev, ctx);
> +	ret = dev_set_name(&ctx->dev, name);
> +	if (ret)
> +		goto ctx_free;
> +
> +	ret = device_register(&ctx->dev);
> +	if (ret) {
> +		put_device(&ctx->dev);
need to free ctx?
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(parent, edac_ras_dev_unreg, &ctx->dev);
> +
> +ctx_free:
> +	kfree(ctx);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(edac_ras_dev_register);
> diff --git a/include/linux/edac_ras_feature.h b/include/linux/edac_ras_feature.h
> new file mode 100755
> index 000000000000..000e99141023
> --- /dev/null
> +++ b/include/linux/edac_ras_feature.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * EDAC RAS control features.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + */
> +
> +#ifndef __EDAC_RAS_FEAT_H
> +#define __EDAC_RAS_FEAT_H
> +
> +#include <linux/types.h>
> +#include <linux/edac.h>
> +
> +#define EDAC_RAS_NAME_LEN	128
> +
> +enum edac_ras_feat {
> +	ras_feat_scrub,
> +	ras_feat_ecs,
> +	ras_feat_max
> +};
Use uppercase for the strings.

Fan
> +
> +struct edac_ecs_ex_info {
> +	u16 num_media_frus;
> +};
> +
> +/*
> + * EDAC RAS feature information structure
> + */
> +struct edac_scrub_data {
> +	const struct edac_scrub_ops *ops;
> +	void *private;
> +};
> +
> +struct edac_ecs_data {
> +	const struct edac_ecs_ops *ops;
> +	void *private;
> +};
> +
> +struct device;
> +
> +struct edac_ras_feat_ctx {
> +	struct device dev;
> +	void *private;
> +	struct edac_scrub_data scrub;
> +	struct edac_ecs_data ecs;
> +};
> +
> +struct edac_ras_feature {
> +	enum edac_ras_feat feat;
> +	union {
> +		const struct edac_scrub_ops *scrub_ops;
> +		const struct edac_ecs_ops *ecs_ops;
> +	};
> +	union {
> +		struct edac_ecs_ex_info ecs_info;
> +	};
> +	union {
> +		void *scrub_ctx;
> +		void *ecs_ctx;
> +	};
> +};
> +
> +int edac_ras_dev_register(struct device *parent, char *dev_name,
> +			  void *parent_pvt_data, int num_features,
> +			  const struct edac_ras_feature *ras_features);
> +#endif /* __EDAC_RAS_FEAT_H */
> -- 
> 2.34.1
> 

