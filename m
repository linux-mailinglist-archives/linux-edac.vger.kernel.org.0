Return-Path: <linux-edac+bounces-2040-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D699CC9C
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 16:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7BD1F20F12
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 14:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B731A0BDB;
	Mon, 14 Oct 2024 14:18:38 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE78E571;
	Mon, 14 Oct 2024 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915518; cv=none; b=KF3bz9khoBXR3hJNFWL19ODef6ZYMEUVQFSNOYmd89k7zkoGoA9wD+QllvgBPOdwoAbZhgd3HBfw4wn4J1XZ4nQJpKq/xzsa25SAJNCvKCP7q/+Yx2arFzcZuOJjtsByR6dP8ghYdvqEUcZtz8IG+ykm+DqMn5Hj9JFxPRAGEmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915518; c=relaxed/simple;
	bh=4097PcwXhyCabDSzBoH2+3WktTBaJqGbxkJjbO/T67o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtT95Q78IviWur8N5CghpUiIVTAwhHidAncTVHXQlb9Rmv+cFNT0EjcOxNiYlz9MuwhXmDan3Oq3lW5khKJN0G9laocOBR/iK7H2zjvaksAvDJCj6pj7J3sozSRPLxIJ6JQgyQDUczeSDpN+E8XP2HBfYoYlkxf8O1ATQTGL76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRzpc5lRtz6HJnN;
	Mon, 14 Oct 2024 22:18:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AFBE0140AB8;
	Mon, 14 Oct 2024 22:18:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 16:18:31 +0200
Date: Mon, 14 Oct 2024 15:18:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v13 01/18] EDAC: Add support for EDAC device features
 control
Message-ID: <20241014151829.00000e7f@Huawei.com>
In-Reply-To: <20241009124120.1124-2-shiju.jose@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-2-shiju.jose@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 9 Oct 2024 13:41:02 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add generic EDAC device features control supports registering
> RAS features supported in the system. Driver exposes features
> control attributes to userspace in
> /sys/bus/edac/devices/<dev-name>/<ras-feature>/
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Hi Shiju,

Spotted a few minor bugs in here that I'd missed in internal
review :( See below.

Jonathan

> ---
>  drivers/edac/edac_device.c | 105 +++++++++++++++++++++++++++++++++++++
>  include/linux/edac.h       |  32 +++++++++++
>  2 files changed, 137 insertions(+)
> 
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 621dc2a5d034..0b8aa8150239 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c


> +
> +/**
> + * edac_dev_register - register device for RAS features with EDAC
> + * @parent: client device.
> + * @name: client device's name.
> + * @private: parent driver's data to store in the context if any.
> + * @num_features: number of RAS features to register.
> + * @ras_features: list of RAS features to register.
> + *
> + * Return:
> + *  * %0       - Success.
> + *  * %-EINVAL - Invalid parameters passed.
> + *  * %-ENOMEM - Dynamic memory allocation failed.
> + *
> + * The new edac_dev_feat_ctx would be freed automatically.
> + */
> +int edac_dev_register(struct device *parent, char *name,
> +		      void *private, int num_features,
> +		      const struct edac_dev_feature *ras_features)
> +{

...

> +	ret = device_register(&ctx->dev);
> +	if (ret) {
> +		put_device(&ctx->dev);
> +		goto groups_free;
> +		return ret;

Unreachable line. However, shouldn't have the goto here
as put_device() should result in the release being called
in which case this is a double free. So drop the goto and keep
the return.


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
> index b4ee8961e623..1db008a82690 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -661,4 +661,36 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,


> +/* EDAC device feature information structure */
> +struct edac_dev_data {
> +	u8 instance;
> +	void *private;
> +};
> +
> +struct device;

That forwards def doesn't work as this header needs to include
enough information to establish layout of struct edac_dev_feat_ctx.
Header already includes linux/device.h so just drop this.


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


