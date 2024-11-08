Return-Path: <linux-edac+bounces-2469-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 093C69C12EF
	for <lists+linux-edac@lfdr.de>; Fri,  8 Nov 2024 01:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175581C226B2
	for <lists+linux-edac@lfdr.de>; Fri,  8 Nov 2024 00:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9CB1FDD;
	Fri,  8 Nov 2024 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFgtzVMD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6903964A;
	Fri,  8 Nov 2024 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731025031; cv=none; b=A9PX9vytHG7Q4uAbKvCJwrx3kt9N5a0dOzt5/PKUXPZdHB65ZUfFEtkhViWQS/H3BIqVvhq96maKWMktm2DW/0tMBU8pvMNEWzEFXRJPQdoWLbhYkJbZpbUwcTwXj+nxXNa41UpPuXpqwT0OXmH1u03yNBYL5APCtDPBJxtaBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731025031; c=relaxed/simple;
	bh=SqWgJ4hm51ed+f1/VfQjX/x/DJppAZXyr0Z0K9vD9fU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnepCBG3F5niQn/p5A04cx/wTl8Vvetky9T4WdiY2h/0+IL1V0qPfFaRnnn0oTp+au1z+8gTr3VHW//xyB3OeLfgbp6MkUvo9M0WTWGN+8T26MP0OCDf+AUM6YCu7i9DRqhf/d7P+4+n622vosB+GQ03McXOKVV33jQLqyV6Cdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFgtzVMD; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea9739647bso1209580a12.0;
        Thu, 07 Nov 2024 16:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731025028; x=1731629828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F+Do7zzo+KFbLuMYOM1790nmyhHrHI1nMAaNQb+68y4=;
        b=KFgtzVMDkWzQvjqxuU1JCv6Hd/2K3hskJPnbnKW+4whQrDZXz6SjrgwujPEAvIt7GG
         cqtu0+GDYiINl05TQQLkKTauvcmOw/8X/HrzXq8y/yc7lzuB43T2MImm6TAkoJxz5Azn
         tc0Htcg+Xpt+54S3AUto4RPJ3Iew561Yp5EX4QqXrLrIK1ROktjt1FUaDkm/xezhZGE7
         zKdXW5McUslWcMaMH/9Ld5nHqEKjIHXATQ12ivT5UHcLH+i+z+10eAJomwcFzZANO4pM
         9hXLkPEHytEl2xOv3Uh1emDMmCJ1OsAd/PGpdJ4y4i6aKSuLZN5zEFwM1dJblg68p7ef
         hvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731025028; x=1731629828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+Do7zzo+KFbLuMYOM1790nmyhHrHI1nMAaNQb+68y4=;
        b=b8rNXrhqiGlF7WpYQpAboDGOQdmupPougV5+ec9ZlQuLkco0ABt9naWNwq60TBwcX+
         TKMvn1bT9+YZjIRnU7E4fWHYDyz7wYIFlwoUcHB3O3oz/JbiG2Guo7xjHvG3LZgvhZjU
         xffNK3PaOXbVwGb2vrFpLJ/LTu68zhyO7rT/tXDNB8ImyolnI39e2Gtp6R6LTaNGeZ6f
         qY2o252Ok+371GjAyH9s+0QQ+fYAboWNcIe5vaFG1MXUvkz+Biqnj4az+qbE8bjUWP/f
         fy9/HRtaHz8+eCOmdXC0BxZaBthFsy3zAhKw1TO/3LIR0ZLiQu/Dl+mDej7Fkse5VwTC
         J4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCV2SoIfjnI1caxnKEOHvMQw2c13USuDRDhP1c7rRIMG1KKsvDGKiRf/fLDTu7IWzcOz1sQpDH09LSgP+qWp@vger.kernel.org, AJvYcCWt5SpYowoeQMJUH3Cw3mUbmbpOrt5s/+paoDngY0Vqj1MoDcxpt28zNZQMjyg8puTK9w+N9e4JTznA@vger.kernel.org, AJvYcCXqdN6nNOMWfIh1Wen/NKl73ekDR7ZlZeUmZJ2rXEL2WD6yjI/47PqblgMIEpfs0vS8Hyki5amEH3KO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0jKSx5U0FE146ZvwbtFKoDXiC+ujI5OwIJ1vKXHrHn774WhNh
	Mt1iKuA0EYRMgHASZiy8SrzsC6mEqvEcFk2vfkUX7QsDoT7RAnvq
X-Google-Smtp-Source: AGHT+IHx1CO0T4w9TtTYGzXOtCQnF3M6HiVi4INvxoMblwadJozIaZRzoVFV6fbzFBdcXMIqlR4KGA==
X-Received: by 2002:a17:90b:1f8e:b0:2e0:d957:1b9d with SMTP id 98e67ed59e1d1-2e9b17163cbmr1575389a91.13.1731025028446;
        Thu, 07 Nov 2024 16:17:08 -0800 (PST)
Received: from fan ([2601:646:8f03:9fee:6ed1:b454:5fd2:3850])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd180fsm2187666a91.33.2024.11.07.16.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 16:17:07 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 7 Nov 2024 16:17:03 -0800
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
Subject: Re: [PATCH v15 01/15] EDAC: Add support for EDAC device features
 control
Message-ID: <Zy1Yf5wfc9aYVGwA@fan>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
 <20241101091735.1465-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101091735.1465-2-shiju.jose@huawei.com>

On Fri, Nov 01, 2024 at 09:17:19AM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add generic EDAC device feature controls supporting the registration
> of RAS features available in the system. The driver exposes control
> attributes for these features to userspace in
> /sys/bus/edac/devices/<dev-name>/<ras-feature>/
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/edac/edac_device.c | 101 +++++++++++++++++++++++++++++++++++++
>  include/linux/edac.h       |  30 +++++++++++
>  2 files changed, 131 insertions(+)
> 
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 621dc2a5d034..e9229b5f8afe 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -570,3 +570,104 @@ void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
>  		      block ? block->name : "N/A", count, msg);
>  }
>  EXPORT_SYMBOL_GPL(edac_device_handle_ue_count);
> +
> +/* EDAC device feature */

The comment is not very helpful to me, seems not quite relevant to what
the function below does.

Fan
> +static void edac_dev_release(struct device *dev)
> +{
> +	struct edac_dev_feat_ctx *ctx = container_of(dev, struct edac_dev_feat_ctx, dev);
> +
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
> + * edac_dev_register - register device for RAS features with EDAC
> + * @parent: parent device.
> + * @name: parent device's name.
> + * @private: parent driver's data to store in the context if any.
> + * @num_features: number of RAS features to register.
> + * @ras_features: list of RAS features to register.
> + *
> + * Return:
> + *  * %0       - Success.
> + *  * %-EINVAL - Invalid parameters passed.
> + *  * %-ENOMEM - Dynamic memory allocation failed.
> + *
> + */
> +int edac_dev_register(struct device *parent, char *name,
> +		      void *private, int num_features,
> +		      const struct edac_dev_feature *ras_features)
> +{
> +	const struct attribute_group **ras_attr_groups;
> +	struct edac_dev_feat_ctx *ctx;
> +	int attr_gcnt = 0;
> +	int ret, feat;
> +
> +	if (!parent || !name || !num_features || !ras_features)
> +		return -EINVAL;
> +
> +	/* Double parse to make space for attributes */
> +	for (feat = 0; feat < num_features; feat++) {
> +		switch (ras_features[feat].ft_type) {
> +		/* Add feature specific code */
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ras_attr_groups = kcalloc(attr_gcnt + 1, sizeof(*ras_attr_groups), GFP_KERNEL);
> +	if (!ras_attr_groups) {
> +		ret = -ENOMEM;
> +		goto ctx_free;
> +	}
> +
> +	attr_gcnt = 0;
> +	for (feat = 0; feat < num_features; feat++, ras_features++) {
> +		switch (ras_features->ft_type) {
> +		/* Add feature specific code */
> +		default:
> +			ret = -EINVAL;
> +			goto groups_free;
> +		}
> +	}
> +
> +	ctx->dev.parent = parent;
> +	ctx->dev.bus = edac_get_sysfs_subsys();
> +	ctx->dev.type = &edac_dev_type;
> +	ctx->dev.groups = ras_attr_groups;
> +	ctx->private = private;
> +	dev_set_drvdata(&ctx->dev, ctx);
> +
> +	ret = dev_set_name(&ctx->dev, name);
> +	if (ret)
> +		goto groups_free;
> +
> +	ret = device_register(&ctx->dev);
> +	if (ret) {
> +		put_device(&ctx->dev);
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(parent, edac_dev_unreg, &ctx->dev);
> +
> +groups_free:
> +	kfree(ras_attr_groups);
> +ctx_free:
> +	kfree(ctx);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(edac_dev_register);
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index b4ee8961e623..e19706311ec0 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -661,4 +661,34 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
>  
>  	return mci->dimms[index];
>  }
> +
> +/* EDAC device features */
> +
> +#define EDAC_FEAT_NAME_LEN	128
> +
> +/* RAS feature type */
> +enum edac_dev_feat {
> +	RAS_FEAT_MAX
> +};
> +
> +/* EDAC device feature information structure */
> +struct edac_dev_data {
> +	u8 instance;
> +	void *private;
> +};
> +
> +struct edac_dev_feat_ctx {
> +	struct device dev;
> +	void *private;
> +};
> +
> +struct edac_dev_feature {
> +	enum edac_dev_feat ft_type;
> +	u8 instance;
> +	void *ctx;
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
Fan Ni

