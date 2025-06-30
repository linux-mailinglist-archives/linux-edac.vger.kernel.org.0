Return-Path: <linux-edac+bounces-4292-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DCCAEE569
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 19:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4015C7AA762
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B13B28DF40;
	Mon, 30 Jun 2025 17:11:38 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C712571C7
	for <linux-edac@vger.kernel.org>; Mon, 30 Jun 2025 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303498; cv=none; b=FoC5xe2DOxbOGhW0hg2qrfaN/Skptth5SFemnj0SYH5y7GTvICyzAEtRaAfvc7ZbRjqy/LKtTgYLecQEfrR90H3UcP9tiCAWFz6M1aR+r1g9BMJ8bZGqIfkB7SaIqcQTpJn2DNLKTT8M0wY6hcxpX3LAf2eIVy2mybuC4fAfHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303498; c=relaxed/simple;
	bh=eeRuroM8rF0qg95CF/rA58wQpwOz/EJZDj6OJRRkvoE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5SUA6ejrMVGIdIp/WAWr7w1ag41umk57R3yuZyO/2PjGV6B/nyWnkL3n4kRSBq9B9G0VASDug4ZcReG5H0k8WAis0nPlCOt5Gi0cfwQoMaAPtAdVzg3kk9+/IhxMNgGMVdfcMDuU63DheC9kiguuRKuvLmqwVyQ5yAWdr9kjNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWCNw45l7z6L5fG;
	Tue,  1 Jul 2025 01:11:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 95FB31400CA;
	Tue,  1 Jul 2025 01:11:32 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Jun
 2025 19:11:31 +0200
Date: Mon, 30 Jun 2025 18:11:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<arnd@kernel.org>, <mchehab@kernel.org>, <rric@kernel.org>,
	<dave.jiang@intel.com>, <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: Re: [PATCH 1/2] EDAC/scrub: Reduce stack usage in
 scrub_create_desc()
Message-ID: <20250630181130.000011c9@huawei.com>
In-Reply-To: <20250630162034.1788-2-shiju.jose@huawei.com>
References: <20250630162034.1788-1-shiju.jose@huawei.com>
	<20250630162034.1788-2-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 30 Jun 2025 17:20:33 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Constructing an array on the stack can exceed the warning limit
> for per-function stack usage.
> 
> Change this to have the actual attribute array allocated statically and
> then add the instance number on the per-instance copy.
> 
> Fixes: f90b738166fe ("EDAC: Add scrub control feature")
> Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/edac/scrub.c | 31 +++++++++++--------------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/edac/scrub.c b/drivers/edac/scrub.c
> index f9d02af2fc3a..850347d274e8 100755
> --- a/drivers/edac/scrub.c
> +++ b/drivers/edac/scrub.c
> @@ -142,17 +142,14 @@ static umode_t scrub_attr_visible(struct kobject *kobj, struct attribute *a, int
>  	return 0;
>  }
>  
> -#define EDAC_SCRUB_ATTR_RO(_name, _instance)       \
> -	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_RO(_name), \
> -					.instance = _instance })
> -
> -#define EDAC_SCRUB_ATTR_WO(_name, _instance)       \
> -	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_WO(_name), \
> -					.instance = _instance })
> -
> -#define EDAC_SCRUB_ATTR_RW(_name, _instance)       \
> -	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_RW(_name), \
> -					.instance = _instance })
> +static const struct device_attribute scrub_dev_attr[] = {
> +	[SCRUB_ADDRESS]		    = __ATTR_RW(addr),
> +	[SCRUB_SIZE]		    = __ATTR_RW(size),
> +	[SCRUB_ENABLE_BACKGROUND]   = __ATTR_RW(enable_background),
> +	[SCRUB_MIN_CYCLE_DURATION]  = __ATTR_RO(min_cycle_duration),
> +	[SCRUB_MAX_CYCLE_DURATION]  = __ATTR_RO(max_cycle_duration),
> +	[SCRUB_CUR_CYCLE_DURATION]  = __ATTR_RW(current_cycle_duration)
> +};
>  
>  static int scrub_create_desc(struct device *scrub_dev,
>  			     const struct attribute_group **attr_groups, u8 instance)
> @@ -160,14 +157,6 @@ static int scrub_create_desc(struct device *scrub_dev,
>  	struct edac_scrub_context *scrub_ctx;
>  	struct attribute_group *group;
>  	int i;
> -	struct edac_scrub_dev_attr dev_attr[] = {
> -		[SCRUB_ADDRESS] = EDAC_SCRUB_ATTR_RW(addr, instance),
> -		[SCRUB_SIZE] = EDAC_SCRUB_ATTR_RW(size, instance),
> -		[SCRUB_ENABLE_BACKGROUND] = EDAC_SCRUB_ATTR_RW(enable_background, instance),
> -		[SCRUB_MIN_CYCLE_DURATION] = EDAC_SCRUB_ATTR_RO(min_cycle_duration, instance),
> -		[SCRUB_MAX_CYCLE_DURATION] = EDAC_SCRUB_ATTR_RO(max_cycle_duration, instance),
> -		[SCRUB_CUR_CYCLE_DURATION] = EDAC_SCRUB_ATTR_RW(current_cycle_duration, instance)
> -	};
>  
>  	scrub_ctx = devm_kzalloc(scrub_dev, sizeof(*scrub_ctx), GFP_KERNEL);
>  	if (!scrub_ctx)
> @@ -175,7 +164,9 @@ static int scrub_create_desc(struct device *scrub_dev,
>  
>  	group = &scrub_ctx->group;
>  	for (i = 0; i < SCRUB_MAX_ATTRS; i++) {
> -		memcpy(&scrub_ctx->scrub_dev_attr[i], &dev_attr[i], sizeof(dev_attr[i]));
> +		scrub_ctx->scrub_dev_attr[i].dev_attr = scrub_dev_attr[i];
> +		scrub_ctx->scrub_dev_attr[i].instance = instance;
> +
>  		sysfs_attr_init(&scrub_ctx->scrub_dev_attr[i].dev_attr.attr);
>  		scrub_ctx->scrub_attrs[i] = &scrub_ctx->scrub_dev_attr[i].dev_attr.attr;
>  	}


