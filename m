Return-Path: <linux-edac+bounces-1869-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0A8978601
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2024 18:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6DC1C22AA7
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2024 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71BA78276;
	Fri, 13 Sep 2024 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="G6IFee2U"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AF76F2E2;
	Fri, 13 Sep 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245705; cv=none; b=k4KswJ/VJMyJjH/lFTeIpff4Rgg1b/yUGfNtaWN7oxM1hdwNVwsdCf1FfUL8fraEWTckSPfWbm0pl2EmZeg61uJhwywIzOsWRHl3CJS0xKReXaQHHOLzVix6Q9fPjIgOR3BUO4Q3fShjCcz73OAw3ZxDY6VfFmS1+53wU0MDyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245705; c=relaxed/simple;
	bh=GuXnRVBwQ7RoyRSwOf9yJFuJaoCPCYl2Wz7OPchOJU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igVIgSowZdGCU2lBQTemMAT6wRydEW8hXxAgAQf6dg8x8tgiG2ZzA7dmdkw6JNHPBX/ZcPDfXbwRW2zUCPzi2+GmYGJdhhesIPgk41pGUcC6sNtdGNM8yOKapT0AY6Z5r0PMCDf3VezFWM1BcCmbl4NY4p216PnnhS4eTnOrbI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=G6IFee2U; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4004A40E0191;
	Fri, 13 Sep 2024 16:41:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TQ8_o6yyL2dF; Fri, 13 Sep 2024 16:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1726245694; bh=7Dg3Ylc2He7FCFRo4RKK39b1kxUf9gVymcWyf4XGQS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6IFee2UkMMI9gdLH6zlIgoVyztRuscsINHBnL4AzKQngx4n2l8xWmksx0E4E6lSv
	 PqUUrhTwr8ClfsKmERZs8I7Xo3N3n+bWMD9tJDk4ex9DPeuCZn0p0diP7E3D48703/
	 ALMnKaKUIwSozfCX0MwhgxZ1n5q70AUm1H0BgyycI61JUrPHyNgmiJ1CHKfeXt6T0n
	 Jv8GjHuEyRHfWBXNutLb+92iSgiaBUON+kWd0EUdbLxanATdjNiDTKsnCg+hMisveS
	 mE3wTVbFsdGzLD7c3goAebISngPklPt012brCYGm9rM+gynhjwLWOTfC1Z2H6HXhN+
	 2t9Cdz2+CKs7glxYh4vPjsZs+fGqj2UIh5V2cBbOw9RFRaKMpku096ws3s+3NyJwCw
	 Zrpyktl6OqsxTO+lkZdNb02KSgB8t5reuFJuX3xM4O82XvzbtYIpSagddWn8mslsuK
	 fHgE8X2Wv6CzuzfJF6nYj758oFRS4bSikMi/jrmlsHannUOaAov3csmbt97epXp+Xr
	 JmE9z99pMQUvdeyWkOlTUa8/GrvgjiU4osg4Fx0vjcdhI5NZEVe6OCSBciAq+kLo2Q
	 /Kh2BUGpj81g2XXF9dEfHIabwXCNaUz/Wmx3JPmw38mpAgX1p7MJzbZoNYZmN8LYKU
	 m8nNaXiHsqNYuqXQqPXGgQjc=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC2A140E0198;
	Fri, 13 Sep 2024 16:40:47 +0000 (UTC)
Date: Fri, 13 Sep 2024 18:40:41 +0200
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
Subject: Re: [PATCH v12 01/17] EDAC: Add support for EDAC device features
 control
Message-ID: <20240913164041.GKZuRrCeoFZBapVYaU@fat_crate.local>
References: <20240911090447.751-1-shiju.jose@huawei.com>
 <20240911090447.751-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911090447.751-2-shiju.jose@huawei.com>

On Wed, Sep 11, 2024 at 10:04:30AM +0100, shiju.jose@huawei.com wrote:
> +/**
> + * edac_dev_feature_init - Init a RAS feature
> + * @parent: client device.
> + * @dev_data: pointer to the edac_dev_data structure, which contains
> + * client device specific info.
> + * @feat: pointer to struct edac_dev_feature.
> + * @attr_groups: pointer to attribute group's container.
> + *
> + * Returns number of scrub features attribute groups on success,

Not "scrub" - this is an interface initializing a generic feature.

> + * error otherwise.
> + */
> +static int edac_dev_feat_init(struct device *parent,
> +			      struct edac_dev_data *dev_data,
> +			      const struct edac_dev_feature *ras_feat,
> +			      const struct attribute_group **attr_groups)
> +{
> +	int num;
> +
> +	switch (ras_feat->ft_type) {
> +	case RAS_FEAT_SCRUB:
> +		dev_data->scrub_ops = ras_feat->scrub_ops;
> +		dev_data->private = ras_feat->ctx;
> +		return 1;
> +	case RAS_FEAT_ECS:
> +		num = ras_feat->ecs_info.num_media_frus;
> +		dev_data->ecs_ops = ras_feat->ecs_ops;
> +		dev_data->private = ras_feat->ctx;
> +		return num;
> +	case RAS_FEAT_PPR:
> +		dev_data->ppr_ops = ras_feat->ppr_ops;
> +		dev_data->private = ras_feat->ctx;
> +		return 1;
> +	default:
> +		return -EINVAL;
> +	}
> +}

And why does this function even exist and has kernel-doc comments when all it
does is assign a couple of values? And it gets called exactly once?

Just merge its body into the call site. There you can reuse the switch-case
there too. No need for too much noodling around.

> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index b4ee8961e623..b337254cf5b8 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -661,4 +661,59 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
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
> +	RAS_FEAT_SCRUB,
> +	RAS_FEAT_ECS,
> +	RAS_FEAT_PPR,
> +	RAS_FEAT_MAX

I still don't know what ECS or PPR is.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

