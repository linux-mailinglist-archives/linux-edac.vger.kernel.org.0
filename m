Return-Path: <linux-edac+bounces-2185-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C7D9AB666
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 21:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A34B2141C
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 19:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BDC1C9ECC;
	Tue, 22 Oct 2024 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QCuIUCEj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2401C9DD3;
	Tue, 22 Oct 2024 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623956; cv=none; b=FancA4/vNEsrsx3Rt/w7v76m0JfpKVAFM71pMG1GRAT9/ARYYhoH0yMwBJRAUBk+ROTP4Ic7sJpJKdf0qCxg8/YAqAIsyODWasIYnfwAfBmrW6tr+udf+1i5SUHNQde4Q4dx4/DQqeATDUhljvgOnzz+N+gW1gh2s0JH0FuMq7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623956; c=relaxed/simple;
	bh=Wn0mViEOFlicqTJRkmLe1dsuAo5+z2xIhCVNhEWGFyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od+ViT9bcIusMTSGfnMASxGaE35Bd5g7Lly2eUchywWtj/VOJgFMxp49NzAJW11O2cGzALabmtoT/88lVKzcPw7rLDDC6T9/f1owSCcY1b/7pmH75WsHz7ke6FBu84QYglbzttB+7t6ix+u3RstJT4CNjFIwthkTAOVKM51mayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QCuIUCEj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B99F240E0198;
	Tue, 22 Oct 2024 19:05:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q3aQ9N_t_KX4; Tue, 22 Oct 2024 19:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729623944; bh=ppGZ1xT0ZqqGN7Q64cHQWTKY4xHYzn5soCR639b+QDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCuIUCEjsFCP18Md2JNqMqIn1FwuwkZ2vZnBwxxUmRu0qMG2llbF1LFHGb1ZpD46G
	 vFcAVNROerVPlayap1OFa/NFoym1ZlY5A0idJcdPJk9XwpuedUSimvD2v4FzEVjU2C
	 vF40FFj6uOHNBfH04Vn6nAfHNURxDBwssmQ9T+EYn498FqZpIrXoMMSsGH9t5X5WgH
	 +i50AsUiLvbjF5vnDfaA/zDFtSkVp0rxR5wi2Peg8BfO4e05snsr4FzG1idjIHBuYx
	 VueK1zwtMdEVkS3scEeGe3EnUa2ri4iQjyGrw2HifTOOkh5lUmr8HxFAJhR5LW2hTb
	 o/6MnHpPXXGcNo4KwuZQVUK958nSPa0WKU6BB6DvTCEel7TJ+hcfWtzrzkD6oLN/OA
	 IdR1y/BguKgE40mGAssz3hq1PrAk8bKPPSd7f44TetrU4yKX3K+oeKQA05VsjqHZo9
	 3tnheR6/o515Bu7XeH4kS2YPnqCuZmKrxyfKWkLjTfnn82P+Cncm3GtT6lj40yuTRy
	 0ZVLrjzGSM+LvUUFuYH/ooTeYOE9pf/zXqe5On30mJistYc+EC7ZDEluVHdvRkdoYr
	 +2Lu8jmdp+go0EE3FBx6MP1E/DDbq7Bf6UfFPW3TXe1hkDIKDCM12gbXNEveoqV1xa
	 oWAJYSJeKVcKHM9Y32+NwBN0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 29F7340E015F;
	Tue, 22 Oct 2024 19:05:01 +0000 (UTC)
Date: Tue, 22 Oct 2024 21:04:54 +0200
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
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v13 02/18] EDAC: Add scrub control feature
Message-ID: <20241022190454.GIZxf3VkmLVR-JLeUc@fat_crate.local>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
 <20241009124120.1124-3-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009124120.1124-3-shiju.jose@huawei.com>

On Wed, Oct 09, 2024 at 01:41:03PM +0100, shiju.jose@huawei.com wrote:
> diff --git a/Documentation/ABI/testing/sysfs-edac-scrub b/Documentation/ABI/testing/sysfs-edac-scrub
> new file mode 100644
> index 000000000000..b4f8f0bba17b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-edac-scrub
> @@ -0,0 +1,69 @@
> +What:		/sys/bus/edac/devices/<dev-name>/scrubX
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		The sysfs EDAC bus devices /<dev-name>/scrubX subdirectory
> +		belongs to an instance of memory scrub control feature,
> +		where <dev-name> directory corresponds to a device/memory
> +		region registered with the EDAC device driver for the
> +		scrub control feature.
> +		The sysfs scrub attr nodes would be present only if the
> +		client driver has implemented the corresponding attr
> +		callback function and passed in ops to the EDAC RAS feature
> +		driver during registration.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrubX/addr_range_base
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The base of the address range of the memory region
> +		to be scrubbed (on-demand scrubbing).

Why does this sound more complicated than it is?

Why isn't this simply "addr" and the next one "size"?

On-demand scrubbing should scrub at address "addr" and "size" bytes. Can't get
any simpler than that.

> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrubX/addr_range_size
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The size of the address range of the memory region
> +		to be scrubbed (on-demand scrubbing).
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrubX/enable_background
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Start/Stop background(patrol) scrubbing if supported.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrubX/enable_on_demand
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Start/Stop on-demand scrubbing the memory region
> +		if supported.

Why do you need a separate "enable" flag?

Why can't it be: "writing into "addr" starts the on-demand scrubbing"?

> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrubX/min_cycle_duration
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) Supported minimum scrub cycle duration in seconds
> +		by the memory scrubber.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrubX/max_cycle_duration
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) Supported maximum scrub cycle duration in seconds
> +		by the memory scrubber.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrubX/current_cycle_duration
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The current scrub cycle duration in seconds and must be
> +		within the supported range by the memory scrubber.

What are those three good for and why are they exposed?

> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 4edfb83ffbee..a96a74de8b9e 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
>  
>  edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
>  edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
> +edac_core-y	+= scrub.o
>  
>  edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
>  
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 0b8aa8150239..0c9da55d18bc 100644
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
> @@ -610,7 +611,9 @@ int edac_dev_register(struct device *parent, char *name,
>  		      const struct edac_dev_feature *ras_features)
>  {
>  	const struct attribute_group **ras_attr_groups;
> +	struct edac_dev_data *dev_data;
>  	struct edac_dev_feat_ctx *ctx;
> +	int scrub_cnt = 0, scrub_inst = 0;
>  	int attr_gcnt = 0;
>  	int ret, feat;

The EDAC tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

>  
> @@ -620,7 +623,10 @@ int edac_dev_register(struct device *parent, char *name,
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
> @@ -639,13 +645,36 @@ int edac_dev_register(struct device *parent, char *name,
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
>  	for (feat = 0; feat < num_features; feat++, ras_features++) {
>  		switch (ras_features->ft_type) {
> -		/* Add feature specific code */
> +		case RAS_FEAT_SCRUB:
> +			if (!ras_features->scrub_ops)
> +				continue;

Continue?

I think fail. What is a scrub feature good for if it doesn't have ops?

> +			if (scrub_inst != ras_features->instance)
> +				goto data_mem_free;
> +			dev_data = &ctx->scrub[scrub_inst];
> +			dev_data->instance = scrub_inst;
> +			dev_data->scrub_ops = ras_features->scrub_ops;
> +			dev_data->private = ras_features->ctx;
> +			ret = edac_scrub_get_desc(parent, &ras_attr_groups[attr_gcnt],
> +						  ras_features->instance);
> +			if (ret)
> +				goto data_mem_free;
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

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

