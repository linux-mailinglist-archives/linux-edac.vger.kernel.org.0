Return-Path: <linux-edac+bounces-1799-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4AD96A498
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 18:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3D31C20DD3
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 16:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B015418BC30;
	Tue,  3 Sep 2024 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YMohtChu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9EE18BBB5;
	Tue,  3 Sep 2024 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381390; cv=none; b=FBn4NwzgABVL1JK/WojZ9iKmecEfxUDF5beXzs66k5EaAg6dg2XdKHGktV3n4vU4HXplmt5nfyUSNilN0udNvQHk6ioLOoFsGky910ay/m2dp+gZtRrkK4qPIVK/k/GOPkIIWmEfg9kJcdzHGTt3X85ZehMD2A3d5V3MUZEZpXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381390; c=relaxed/simple;
	bh=543N6+Pih3rc6ARRSx5VE6TXlXwfpZlMMtlOc6RbSP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxfIJ7ZhGVUZZiJAnu4G++SNZ+iv6s+zEQU06AXt+mZQOb2VoIp0YQMAOMruyhUpHcwAv1OvEqiQPOWwU1+EH/dunq5nYlbwLFn3b4/afBUzQWdtD33R0O6bhtv5gtEmz7SPvaOyk487Jue6qeGBXVW2caXGlj7vZEqoWzRJrw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YMohtChu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D6A1840E0285;
	Tue,  3 Sep 2024 16:36:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6vNpdbQEdZQc; Tue,  3 Sep 2024 16:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725381371; bh=utMPlXJeOSH8aOyxKwjMpiAJT4ZzqbftcxjJbD0c80k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMohtChuZaVO2ZjNLp29AnffBfHb9IXnvXbmSYw44RFu5R9IgKWZEKFMxTVSKQztj
	 bOfuWJnT7HjX9RfRDWUKtz0UZRmU9LEvM3KzMzPwhnYaUNThBiXM50sZXJFUzI2h1o
	 oYhTJo4Levk3Nk0P4EOzeqwfCNK0wCj7f9jTc4g2Fd3/IXctdPGqxCCu3zVn9ttdpO
	 VpbKm3xCQBGTYy976eQrGaayY/eBOR6lsxGSApdBVW4WdW7enT9VUVUaXNtMlR7Ptb
	 BvERUNJXAmAwTdu4fm1uAtgSinjyZGtr/QoQZz4UWN5G7KBnn33U0bmq+Z2fASLxKF
	 iT9L51BLDXlQwCbTgCDoQB8lc/WtoL6zoND0TtjL/3+A2AuB5oLTP2x6xlNGkVNIdo
	 oAgUsshxP9SwI5y+JmXbPYw/FAq/0OZyyCzHB9LZRFIKFWndIP6PebV5ETvj0bNYJr
	 4Q7DC/lISfhSv6SqZPI2CgzoHvvvWcHjDj58ChR4TAJsTIg46RGe+ciylbgNzM6dY8
	 59fJojBQZFf99F5TpuOrLblrgnYwdT9I3OJDpx2QK+xiCzuhFKJ8fpxkhBvsNoQzG1
	 Knzbo2fIC/FqMJZrJRDucMOG6tR8L2n/srkp0mpd45j+7kkExFY7m9Pwpg//jcz5TI
	 NzS/z2M3O73LXKWMMgeU/TM8=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5329940E0169;
	Tue,  3 Sep 2024 16:35:25 +0000 (UTC)
Date: Tue, 3 Sep 2024 18:35:19 +0200
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
Subject: Re: [PATCH v11 01/14] EDAC: Add support for EDAC device feature's
 control
Message-ID: <20240903163519.GAZtc6x7o9Cy1MQAsb@fat_crate.local>
References: <20240816164238.1902-1-shiju.jose@huawei.com>
 <20240816164238.1902-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240816164238.1902-2-shiju.jose@huawei.com>

On Fri, Aug 16, 2024 at 05:42:24PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add generic EDAC device feature's control supports registering

"features"

Check your whole set.

> RAS features supported in the system. Driver exposes feature's
> control attributes to the userspace in

s/the //

> /sys/bus/edac/devices/<dev-name>/<ras-feature>/
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/edac/edac_device.c | 178 +++++++++++++++++++++++++++++++++++++
>  include/linux/edac.h       |  60 +++++++++++++
>  2 files changed, 238 insertions(+)
> 
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 621dc2a5d034..635a41db8b5a 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -570,3 +570,181 @@ void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
>  		      block ? block->name : "N/A", count, msg);
>  }
>  EXPORT_SYMBOL_GPL(edac_device_handle_ue_count);
> +
> +/* EDAC device feature */
> +static void edac_dev_release(struct device *dev)
> +{
> +	struct edac_dev_feat_ctx *ctx =
> +		container_of(dev, struct edac_dev_feat_ctx, dev);

Ew, no, don't do such silly linebreaks pls.

> +	kfree(ctx->dev.groups);
> +	kfree(ctx);
> +}
> +
> +const struct device_type edac_dev_type = {
> +	.name = "edac_dev",
> +	.release = edac_dev_release,
> +};
> +
> +static void edac_dev_unreg(void *data)
> +{
> +	device_unregister(data);
> +}
> +
> +/**
> + * edac_dev_feature_init - Init a ras feature

s/ras/RAS/g

Check your whole set.

> + * @parent: client device.
> + * @dev_data: pointer to struct edac_dev_data.

I can see it is a pointer. What it is used for?

> + * @feat: pointer to struct edac_dev_feature.
> + * @attr_groups: pointer to attribute group's container.
> + *
> + * Returns number of scrub feature's attribute groups on success,
> + * error otherwise.
> + */
> +static int edac_dev_feat_init(struct device *parent,
> +			      struct edac_dev_data *dev_data,
> +			      const struct edac_dev_feature *ras_feat,
> +			      const struct attribute_group **attr_groups)
> +{
> +	int num;
> +
> +	switch (ras_feat->feat) {
> +	case RAS_FEAT_SCRUB:
> +		dev_data->scrub_ops = ras_feat->scrub_ops;
> +		dev_data->private = ras_feat->scrub_ctx;
> +		return 1;
> +	case RAS_FEAT_ECS:
> +		num = ras_feat->ecs_info.num_media_frus;
> +		dev_data->ecs_ops = ras_feat->ecs_ops;
> +		dev_data->private = ras_feat->ecs_ctx;
> +		return num;
> +	case RAS_FEAT_PPR:
> +		dev_data->ppr_ops = ras_feat->ppr_ops;
> +		dev_data->private = ras_feat->ppr_ctx;
> +		return 1;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * edac_dev_register - register device for ras features with edac

s/edac/EDAC/g

Check your whole set.

> + * @parent: client device.
> + * @name: client device's name.
> + * @private: parent driver's data to store in the context if any.
> + * @num_features: number of ras features to register.
> + * @ras_features: list of ras features to register.
> + *
> + * Returns 0 on success, error otherwise.
> + * The new edac_dev_feat_ctx would be freed automatically.
> + */
> +int edac_dev_register(struct device *parent, char *name,
> +		      void *private, int num_features,
> +		      const struct edac_dev_feature *ras_features)
> +{
> +	const struct attribute_group **ras_attr_groups;
> +	struct edac_dev_data *dev_data;
> +	struct edac_dev_feat_ctx *ctx;
> +	int ppr_cnt = 0, ppr_inst = 0;
> +	int attr_gcnt = 0;
> +	int ret, feat;
> +
> +	if (!parent || !name || !num_features || !ras_features)
> +		return -EINVAL;
> +
> +	/* Double parse so we can make space for attributes */

Who's "we"?

Please use passive voice in your comments: no "we" or "I", etc.

Personal pronouns are ambiguous in text, especially with so many
parties/companies/etc developing the kernel so let's avoid them please.

> +	for (feat = 0; feat < num_features; feat++) {
> +		switch (ras_features[feat].feat) {
> +		case RAS_FEAT_SCRUB:

Does this need "fallthrough;" or somesuch?

> +		case RAS_FEAT_PPR:
> +			attr_gcnt++;
> +			ppr_cnt++;
> +			break;
> +		case RAS_FEAT_ECS:
> +			attr_gcnt += ras_features[feat].ecs_info.num_media_frus;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->dev.parent = parent;
> +	ctx->private = private;
> +
> +	ras_attr_groups = kcalloc(attr_gcnt + 1, sizeof(*ras_attr_groups), GFP_KERNEL);
> +	if (!ras_attr_groups) {
> +		ret = -ENOMEM;
> +		goto ctx_free;
> +	}
> +
> +	if (ppr_cnt) {
> +		ctx->ppr = kcalloc(ppr_cnt, sizeof(*(ctx->ppr)), GFP_KERNEL);
> +		if (!ctx->ppr) {
> +			ret = -ENOMEM;
> +			goto groups_free;
> +		}
> +	}
> +
> +	attr_gcnt = 0;
> +	for (feat = 0; feat < num_features; feat++, ras_features++) {
> +		switch (ras_features->feat) {
> +		case RAS_FEAT_SCRUB:
> +			if (!ras_features->scrub_ops)
> +				continue;
> +			dev_data = &ctx->scrub;
> +			break;
> +		case RAS_FEAT_ECS:
> +			if (!ras_features->ecs_ops)
> +				continue;
> +			dev_data = &ctx->ecs;
> +			break;
> +		case RAS_FEAT_PPR:
> +			if (!ras_features->ppr_ops)
> +				continue;
> +			dev_data = &ctx->ppr[ppr_inst];
> +			dev_data->instance = ppr_inst;
> +			ppr_inst++;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			goto data_mem_free;
> +		}
> +		ret = edac_dev_feat_init(parent, dev_data, ras_features,
> +					 &ras_attr_groups[attr_gcnt]);
> +		if (ret < 0)
> +			goto data_mem_free;
> +
> +		attr_gcnt += ret;
> +	}

Newline.

> +	ras_attr_groups[attr_gcnt] = NULL;
> +	ctx->dev.bus = edac_get_sysfs_subsys();
> +	ctx->dev.type = &edac_dev_type;
> +	ctx->dev.groups = ras_attr_groups;
> +	dev_set_drvdata(&ctx->dev, ctx);

Ditto.

> +	ret = dev_set_name(&ctx->dev, name);
> +	if (ret)
> +		goto data_mem_free;
> +
> +	ret = device_register(&ctx->dev);
> +	if (ret) {
> +		put_device(&ctx->dev);
> +		goto data_mem_free;
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(parent, edac_dev_unreg, &ctx->dev);
> +
> +data_mem_free:
> +	if (ppr_cnt)
> +		kfree(ctx->ppr);
> +groups_free:
> +	kfree(ras_attr_groups);
> +ctx_free:
> +	kfree(ctx);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(edac_dev_register);
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index b4ee8961e623..cc96f55ac714 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -661,4 +661,64 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
>  
>  	return mci->dimms[index];
>  }
> +
> +/* EDAC device features */
> +
> +#define EDAC_FEAT_NAME_LEN	128
> +
> +enum edac_dev_feat {
> +	RAS_FEAT_SCRUB,
> +	RAS_FEAT_ECS,
> +	RAS_FEAT_PPR,

What are those? Comments ontop explaining pls.

> +	RAS_FEAT_MAX
> +};
> +
> +struct edac_ecs_ex_info {
> +	u16 num_media_frus;
> +};
> +
> +/*
> + * EDAC device feature information structure
> + */
> +struct edac_dev_data {
> +	union {
> +		const struct edac_scrub_ops *scrub_ops;
> +		const struct edac_ecs_ops *ecs_ops;
> +		const struct edac_ppr_ops *ppr_ops;
> +	};
> +	u8 instance;
> +	void *private;
> +};
> +
> +struct device;
> +
> +struct edac_dev_feat_ctx {
> +	struct device dev;
> +	void *private;
> +	struct edac_dev_data scrub;
> +	struct edac_dev_data ecs;
> +	struct edac_dev_data *ppr;
> +};
> +
> +struct edac_dev_feature {
> +	enum edac_dev_feat feat;

			ft_type;

> +	u8 instance;
> +	union {
> +		const struct edac_scrub_ops *scrub_ops;
> +		const struct edac_ecs_ops *ecs_ops;
> +		const struct edac_ppr_ops *ppr_ops;
> +	};
> +	union {
> +		void *scrub_ctx;
> +		void *ecs_ctx;
> +		void *ppr_ctx;
> +	};

Or drop the silly union and simply do

	void *ctx;

> +	union {
> +		struct edac_ecs_ex_info ecs_info;
> +	};

Union with a single member?!

> +};
> +
> +int edac_dev_register(struct device *parent, char *dev_name,
> +		      void *parent_pvt_data, int num_features,
> +		      const struct edac_dev_feature *ras_features);
>  #endif /* _LINUX_EDAC_H_ */
> -- 
> 2.34.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

