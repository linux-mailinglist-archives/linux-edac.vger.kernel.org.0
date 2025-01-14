Return-Path: <linux-edac+bounces-2888-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AB7A1036A
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 10:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9403A0476
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 09:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D8B28EC8C;
	Tue, 14 Jan 2025 09:55:50 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C624022A;
	Tue, 14 Jan 2025 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736848549; cv=none; b=npsR9s4TnBW2lHtTlvzPSZE8J5zKpKQufgfO0sWkRU/nQqD1Y2XVtXrebHGR0Z12Bv0PcINv11UflH1sNSqtYyTcRWvSXAQM6Yrwvtv9KBab8Y+8BjkVZ77NIYnINFiQjx8kEfEmUfMmXxScRvVeDZew9bV5D3yQ9ES/hDT4nus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736848549; c=relaxed/simple;
	bh=dsLh30IhvkvphPhjqjdBvsc5bfCeMYtIGH3mBHUzOY0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OL47NjTPal6XVd89ucq3V9AdbPBnO+1CKUQR+3P8TtDX4Gzu+ctFnB2T7FPEO9QKe2cLADkZlAyc2hCBHgHRZ8shdTFf7k8BtjupFCQIlWXqklGOyf7trCrMpj97PIsoBktc3FZRfRRZ0fPc1bsy/v/d9mep5VZ2Us26Sx8R7P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YXPbY1PMRz6LDKg;
	Tue, 14 Jan 2025 17:54:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D0DE140B3C;
	Tue, 14 Jan 2025 17:55:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 14 Jan
 2025 10:55:42 +0100
Date: Tue, 14 Jan 2025 09:55:41 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: <shiju.jose@huawei.com>, <linux-edac@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<mchehab@kernel.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <david@redhat.com>,
	<Vilas.Sridharan@amd.com>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<rientjes@google.com>, <jiaqiyan@google.com>, <Jon.Grimm@amd.com>,
	<dave.hansen@linux.intel.com>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v18 01/19] EDAC: Add support for EDAC device features
 control
Message-ID: <20250114095541.000000a1@huawei.com>
In-Reply-To: <20250113160611.39bdf3b3@foz.lan>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-2-shiju.jose@huawei.com>
	<20250113160611.39bdf3b3@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)


> > +int edac_dev_register(struct device *parent, char *name,
> > +		      void *private, int num_features,
> > +		      const struct edac_dev_feature *ras_features)
> > +{
> > +	const struct attribute_group **ras_attr_groups;
> > +	struct edac_dev_feat_ctx *ctx;
> > +	int attr_gcnt = 0;
> > +	int ret, feat;
> > +
> > +	if (!parent || !name || !num_features || !ras_features)
> > +		return -EINVAL;
> > +
> > +	/* Double parse to make space for attributes */
> > +	for (feat = 0; feat < num_features; feat++) {
> > +		switch (ras_features[feat].ft_type) {
> > +		/* Add feature specific code */
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx)
> > +		return -ENOMEM;
> > +
> > +	ras_attr_groups = kcalloc(attr_gcnt + 1, sizeof(*ras_attr_groups), GFP_KERNEL);
> > +	if (!ras_attr_groups) {
> > +		ret = -ENOMEM;
> > +		goto ctx_free;
> > +	}
> > +
> > +	attr_gcnt = 0;
> > +	for (feat = 0; feat < num_features; feat++, ras_features++) {
> > +		switch (ras_features->ft_type) {
> > +		/* Add feature specific code */
> > +		default:
> > +			ret = -EINVAL;
> > +			goto groups_free;
> > +		}
> > +	}
> > +
> > +	ctx->dev.parent = parent;
> > +	ctx->dev.bus = edac_get_sysfs_subsys();
> > +	ctx->dev.type = &edac_dev_type;
> > +	ctx->dev.groups = ras_attr_groups;
> > +	ctx->private = private;
> > +	dev_set_drvdata(&ctx->dev, ctx);
> > +
> > +	ret = dev_set_name(&ctx->dev, name);
> > +	if (ret)
> > +		goto groups_free;
> > +
> > +	ret = device_register(&ctx->dev);
> > +	if (ret) {
> > +		put_device(&ctx->dev);  
> 
> > +		return ret;  
> 
> As register failed, you need to change it to a goto groups_free,
> as edac_dev_release() won't be called.

Boris called this one out as well, so seems it is not that well understood.
I've also tripped over this in the past and it's one of the most common
things I catch in reviews of code calling this stuff.

As discussed offline, it will be called. The device_register() docs
make it clear that whether or not that call succeeds reference counting
is enabled and put_device() is the correct way to free resources.

The actual depends on the fact that device_register() is just a helper
defined as

device_initialize();
return device_add();

So for reasons lost to history (I guess there are cases where other cleanup
needs to happen before the release) it does not handle side effects
of device_initialize() on an error in device_add().  

device_initialize() has called
-> kobject_init(&dev->kobj, &device_type);
 -> kref_init_internal(kobj) + sets ktype (which has the release callback)

kref_init_internal() sets the reference counter to 1

Hence when we do a device_put() in the error path, the reference counter drops
to 0 and the release from the ktype is called.  Here that is edac_dev_release();

If you want to verify replace device_register() with device_initialize() then
call put_device().

If we were going back in history, I'd suggest device_register() should be side
effect free and call put_device() on error and any driver that needs to handle
other stuff before the release should just not use it. I guess that ship
long sailed and maybe there are other reasons I've not thought of.

I took a quick look and seems to go back into at least the 2.5 era.

Jonathan




