Return-Path: <linux-edac+bounces-1546-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F7B9347F4
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 08:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A964A282889
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 06:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D810B54F8C;
	Thu, 18 Jul 2024 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4nkZpUL"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC17282EE;
	Thu, 18 Jul 2024 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721283568; cv=none; b=VV4lBhw6Oqy7o7eFLkzpoMWDykFWZRdnDZ10GfJ4D+ptoZox8dvVtlXgw9d5f4vBmJEJhURMCOooM8Ha2tyyq/95C3cNWAAzBQL1A/wXqVWYTdShqi0mmcdTSBbqAm6JKdGWr3luySctfJAWI3CLdXbe09isyWzPy3OeRq4H5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721283568; c=relaxed/simple;
	bh=4Clifxq7cRdC7gqNNrtV/aDjuvKrcihIvqZOJQVZ0e8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAllKZJxury6IpLK8c/iKP6t/5YoHnfXfNjAmqS95BNFOuYrBpLOn+pGsNbhPlgD1Ox5liE3ePREOlYmhK9Q7KJqjXNT3TxhO7IX9sqztTzQAt37KDmnDtTVThmtUxZ2YhvBY+uPsyXDJ336F7Zz44semZlXo8eFzNidxHhbGBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4nkZpUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DC1C116B1;
	Thu, 18 Jul 2024 06:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721283568;
	bh=4Clifxq7cRdC7gqNNrtV/aDjuvKrcihIvqZOJQVZ0e8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r4nkZpULnd0Yq27Yj+TqpJXL7SxXakKd3FwPHLr7Mvjqm8N0/c15uzAL6f1S3VjsF
	 xVzfximTLc1KJzGEMgKitrknuk5Bhmav7qGcMALylhiHhxsxqfjycmfFbfHRhMbmLu
	 0pppvCMDjDTf7BSqn9ZEaRXTaZTcPyUyc20AQMMcf5liWz6SXX014hSfePRnswyxza
	 qWFc/D/Xkd0bKZAf1uMq3ezY+3dqlhjmaub8DX+SAFSRKzsTm7S3IJqdouuIWflYIH
	 JYKZ8GLL4i9cV58IqS+8+DfmWAYZAfyDlKROHRWcRMBRU6jwv3nG+HbQKlV0c01xKW
	 z1W1XMjeMA2Vw==
Date: Thu, 18 Jul 2024 08:19:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "Jonathan Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
 <dave.jiang@intel.com>, "alison.schofield@intel.com"
 <alison.schofield@intel.com>, "vishal.l.verma@intel.com"
 <vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
 <Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
 "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
 <rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
 "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
 <naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
 "jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
 <somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
 "pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
 <duenwen@google.com>, "mike.malvestuto@intel.com"
 <mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
 "wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
 "dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
 "wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
 "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
 <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
 <kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
 Linuxarm <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v9 01/11] EDAC: Add generic EDAC RAS feature driver
Message-ID: <20240718081916.3c9afb65@foz.lan>
In-Reply-To: <2cb0dde458bd4eb79b0a96cb99fe1ef5@huawei.com>
References: <20240716150336.2042-1-shiju.jose@huawei.com>
	<20240716150336.2042-2-shiju.jose@huawei.com>
	<20240717120027.7168536a@foz.lan>
	<2cb0dde458bd4eb79b0a96cb99fe1ef5@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 17 Jul 2024 11:01:58 +0000
Shiju Jose <shiju.jose@huawei.com> escreveu:

> Hi Mauro,
> 
> Thanks for the feedbacks.
> 
> >-----Original Message-----
> >From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >Sent: 17 July 2024 11:00
> >To: Shiju Jose <shiju.jose@huawei.com>
> >Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
> >acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> >bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
> >mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
> >Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
> >alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
> >david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
> >Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
> >Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
> >naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
> >somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
> >duenwen@google.com; mike.malvestuto@intel.com; gthelen@google.com;
> >wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
> >wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
> ><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
> >Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
> >wanghuiqiang <wanghuiqiang@huawei.com>; Linuxarm
> ><linuxarm@huawei.com>
> >Subject: Re: [RFC PATCH v9 01/11] EDAC: Add generic EDAC RAS feature driver
> >
> >Em Tue, 16 Jul 2024 16:03:25 +0100
> ><shiju.jose@huawei.com> escreveu:
> >  
> >> From: Shiju Jose <shiju.jose@huawei.com>
> >>
> >> Add generic EDAC driver supports registering RAS features supported in
> >> the system. The driver exposes feature's control attributes to the
> >> userspace in /sys/bus/edac/devices/<dev-name>/<ras-feature>/
> >>
> >> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> >> ---
> >>  drivers/edac/Makefile            |   1 +
> >>  drivers/edac/edac_ras_feature.c  | 155
> >> +++++++++++++++++++++++++++++++  include/linux/edac_ras_feature.h |
> >> 66 +++++++++++++
> >>  3 files changed, 222 insertions(+)
> >>  create mode 100755 drivers/edac/edac_ras_feature.c  create mode
> >> 100755 include/linux/edac_ras_feature.h
> >>
> >> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile index
> >> 9c09893695b7..c532b57a6d8a 100644
> >> --- a/drivers/edac/Makefile
> >> +++ b/drivers/edac/Makefile
> >> @@ -10,6 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
> >>
> >>  edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
> >>  edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
> >> +edac_core-y	+= edac_ras_feature.o
> >>
> >>  edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
> >>
> >> diff --git a/drivers/edac/edac_ras_feature.c
> >> b/drivers/edac/edac_ras_feature.c new file mode 100755 index
> >> 000000000000..24a729fea66f
> >> --- /dev/null
> >> +++ b/drivers/edac/edac_ras_feature.c
> >> @@ -0,0 +1,155 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * EDAC RAS control feature driver supports registering RAS
> >> + * features with the EDAC and exposes the feature's control
> >> + * attributes to the userspace in sysfs.
> >> + *
> >> + * Copyright (c) 2024 HiSilicon Limited.
> >> + */
> >> +  
> >  
> >> +#define pr_fmt(fmt)     "EDAC RAS CONTROL FEAT: " fmt  
> >
> >Sounds a too long prefix for my taste.  
> Will do. Previously it was "EDAC RAS FEAT"
> 
> >  
> >> +
> >> +#include <linux/edac_ras_feature.h>
> >> +
> >> +static void edac_ras_dev_release(struct device *dev) {
> >> +	struct edac_ras_feat_ctx *ctx =
> >> +		container_of(dev, struct edac_ras_feat_ctx, dev);
> >> +
> >> +	kfree(ctx);
> >> +}
> >> +
> >> +const struct device_type edac_ras_dev_type = {
> >> +	.name = "edac_ras_dev",
> >> +	.release = edac_ras_dev_release,
> >> +};
> >> +
> >> +static void edac_ras_dev_unreg(void *data) {
> >> +	device_unregister(data);
> >> +}
> >> +
> >> +static int edac_ras_feat_scrub_init(struct device *parent,
> >> +				    struct edac_scrub_data *sdata,
> >> +				    const struct edac_ras_feature *sfeat,
> >> +				    const struct attribute_group **attr_groups) {
> >> +	sdata->ops = sfeat->scrub_ops;
> >> +	sdata->private = sfeat->scrub_ctx;
> >> +
> >> +	return 1;
> >> +}
> >> +
> >> +static int edac_ras_feat_ecs_init(struct device *parent,
> >> +				  struct edac_ecs_data *edata,
> >> +				  const struct edac_ras_feature *efeat,
> >> +				  const struct attribute_group **attr_groups) {
> >> +	int num = efeat->ecs_info.num_media_frus;
> >> +
> >> +	edata->ops = efeat->ecs_ops;
> >> +	edata->private = efeat->ecs_ctx;
> >> +
> >> +	return num;
> >> +}  
> >
> >I would place this function earlier and/or add some documentation for the above
> >two functions.  
> Will do. I guess you want place these functions above edac_ras_dev_release() right? 

I mean placing edac_ras_feat_ecs_ini() before edac_ras_feat_scrub_init(),
as it helps reviewers to understand that the return code is the number
of attr groups. Another option would be to document the arguments and
the return value for such functions.

> >
> >I got confused when reviewed the first function and saw there an
> >unconditional:  
> The call  for the feature specific init functions  are added  here in the next feature specific patches
> of this series.  
> >
> >	return 1;
> >
> >Now, I guess the goal is to return the number of initialized features, right?  
> Return the number of attr groups added for a feature as the instances for a feature is dynamic,
> for e.g.  the number of FRUs in ECS feature.
>   
> >  
> >> +
> >> +/**
> >> + * edac_ras_dev_register - register device for ras features with edac
> >> + * @parent: client device.
> >> + * @name: client device's name.
> >> + * @private: parent driver's data to store in the context if any.
> >> + * @num_features: number of ras features to register.
> >> + * @ras_features: list of ras features to register.
> >> + *
> >> + * Returns 0 on success, error otherwise.
> >> + * The new edac_ras_feat_ctx would be freed automatically.
> >> + */
> >> +int edac_ras_dev_register(struct device *parent, char *name,
> >> +			  void *private, int num_features,
> >> +			  const struct edac_ras_feature *ras_features) {
> >> +	const struct attribute_group **ras_attr_groups;
> >> +	struct edac_ras_feat_ctx *ctx;
> >> +	int attr_gcnt = 0;
> >> +	int ret, feat;
> >> +
> >> +	if (!parent || !name || !num_features || !ras_features)
> >> +		return -EINVAL;
> >> +
> >> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> >> +	if (!ctx)
> >> +		return -ENOMEM;
> >> +
> >> +	ctx->dev.parent = parent;
> >> +	ctx->private = private;
> >> +
> >> +	/* Double parse so we can make space for attributes */
> >> +	for (feat = 0; feat < num_features; feat++) {
> >> +		switch (ras_features[feat].feat) {
> >> +		case ras_feat_scrub:
> >> +			attr_gcnt++;
> >> +			break;
> >> +		case ras_feat_ecs:
> >> +			attr_gcnt +=  
> >ras_features[feat].ecs_info.num_media_frus;  
> >> +			break;  
> >
> >As already suggested, the enum names shall be in uppercase.
> >Having a lowercase one here looks really weird.  
> Agree.
> >  
> >> +		default:
> >> +			ret = -EINVAL;
> >> +			goto ctx_free;
> >> +		}
> >> +	}  
> >
> >I would place this logic earlier, before allocating ctx, as, in case of errors, the
> >function can just call "return -EINVAL".  
> Ok.
> 
> >  
> >> +
> >> +	ras_attr_groups = devm_kzalloc(parent,
> >> +				       (attr_gcnt + 1) * sizeof(*ras_attr_groups),
> >> +				       GFP_KERNEL);  
> >
> >Hmm... why are you using devm variant here, and non-devm one for cxt?
> >
> >My personal preference is to avoid devm variants, as memory is only freed
> >when the device refcount becomes zero (which, depending on the driver, may
> >never happen in practice, as driver core may keep a refcount, depending on how
> >the device was probed).  
> Can use Kzalloc and need to add free for ras_attr_groups on error etc. 

Ok. While here, please also use the kcalloc/kmalloc_array variants, as
doing num * sizeof(foo) should be avoided.

Btw, there are some checks inside checkpatch meant to identify it like
ALLOC_WITH_MULTIPLY. Not sure why it didn't trigger it here.

Hint: while the number of false positive hits increase, I'm always running
checkpatch with --strict, as it detects some additional potential problems.

> >> +	if (!ras_attr_groups) {
> >> +		ret = -ENOMEM;
> >> +		goto ctx_free;
> >> +	}
> >> +
> >> +	attr_gcnt = 0;
> >> +	for (feat = 0; feat < num_features; feat++, ras_features++) {
> >> +		if (ras_features->feat == ras_feat_scrub) {  
> >
> >I would use a switch here as well, just like the previous feature type check.  
> Will do.
> >  
> >> +			if (!ras_features->scrub_ops)
> >> +				continue;
> >> +			ret = edac_ras_feat_scrub_init(parent, &ctx->scrub,
> >> +						       ras_features,  
> >&ras_attr_groups[attr_gcnt]);
> >
> >I don't think it is worth having those ancillary functions here...
> >  
> >> +			if (ret < 0)
> >> +				goto ctx_free;
> >> +
> >> +			attr_gcnt += ret;
> >> +		} else if (ras_features->feat == ras_feat_ecs) {
> >> +			if (!ras_features->ecs_ops)
> >> +				continue;
> >> +			ret = edac_ras_feat_ecs_init(parent, &ctx->ecs,
> >> +						     ras_features,  
> >&ras_attr_groups[attr_gcnt]);
> >
> >and here, as most of the current functions are very simple:
> >
> >both just sets two arguments:
> >
> >	edata->ops
> >	edata->private
> >
> >and returned vaules are always a positive counter...
> >  
> >> +			if (ret < 0)
> >> +				goto ctx_free;  
> >
> >So, this check for instance, doesn't make sense.  
> The call  for the feature specific init functions  are added  in the next feature specific patches
> of this series and which could return error.  

Ok.

> >  
> >> +
> >> +			attr_gcnt += ret;
> >> +		} else {
> >> +			ret = -EINVAL;
> >> +			goto ctx_free;
> >> +		}
> >> +	}
> >> +	ras_attr_groups[attr_gcnt] = NULL;
> >> +	ctx->dev.bus = edac_get_sysfs_subsys();
> >> +	ctx->dev.type = &edac_ras_dev_type;
> >> +	ctx->dev.groups = ras_attr_groups;
> >> +	dev_set_drvdata(&ctx->dev, ctx);
> >> +	ret = dev_set_name(&ctx->dev, name);
> >> +	if (ret)
> >> +		goto ctx_free;
> >> +
> >> +	ret = device_register(&ctx->dev);
> >> +	if (ret) {
> >> +		put_device(&ctx->dev);
> >> +		return ret;
> >> +	}
> >> +
> >> +	return devm_add_action_or_reset(parent, edac_ras_dev_unreg,
> >> +&ctx->dev);
> >> +
> >> +ctx_free:
> >> +	kfree(ctx);
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(edac_ras_dev_register);
> >> diff --git a/include/linux/edac_ras_feature.h
> >> b/include/linux/edac_ras_feature.h
> >> new file mode 100755
> >> index 000000000000..000e99141023
> >> --- /dev/null
> >> +++ b/include/linux/edac_ras_feature.h
> >> @@ -0,0 +1,66 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * EDAC RAS control features.
> >> + *
> >> + * Copyright (c) 2024 HiSilicon Limited.
> >> + */
> >> +
> >> +#ifndef __EDAC_RAS_FEAT_H
> >> +#define __EDAC_RAS_FEAT_H
> >> +
> >> +#include <linux/types.h>
> >> +#include <linux/edac.h>
> >> +
> >> +#define EDAC_RAS_NAME_LEN	128
> >> +
> >> +enum edac_ras_feat {
> >> +	ras_feat_scrub,
> >> +	ras_feat_ecs,
> >> +	ras_feat_max
> >> +};  
> >
> >Enum values in uppercase, please.  
> Will do.
> >  
> >> +
> >> +struct edac_ecs_ex_info {
> >> +	u16 num_media_frus;
> >> +};
> >> +
> >> +/*
> >> + * EDAC RAS feature information structure  */ struct edac_scrub_data
> >> +{
> >> +	const struct edac_scrub_ops *ops;
> >> +	void *private;
> >> +};
> >> +
> >> +struct edac_ecs_data {
> >> +	const struct edac_ecs_ops *ops;
> >> +	void *private;
> >> +};
> >> +
> >> +struct device;
> >> +
> >> +struct edac_ras_feat_ctx {
> >> +	struct device dev;
> >> +	void *private;
> >> +	struct edac_scrub_data scrub;
> >> +	struct edac_ecs_data ecs;
> >> +};
> >> +
> >> +struct edac_ras_feature {
> >> +	enum edac_ras_feat feat;
> >> +	union {
> >> +		const struct edac_scrub_ops *scrub_ops;
> >> +		const struct edac_ecs_ops *ecs_ops;
> >> +	};
> >> +	union {
> >> +		struct edac_ecs_ex_info ecs_info;
> >> +	};  
> >
> >I would place the variable structs union at the end. This may help with
> >alignments, if you place the pointers earlier.  
> Will do.
> 
> >  
> >> +	union {
> >> +		void *scrub_ctx;
> >> +		void *ecs_ctx;
> >> +	};
> >> +};
> >> +
> >> +int edac_ras_dev_register(struct device *parent, char *dev_name,
> >> +			  void *parent_pvt_data, int num_features,
> >> +			  const struct edac_ras_feature *ras_features); #endif  
> >/*  
> >> +__EDAC_RAS_FEAT_H */  
> >
> >
> >
> >Thanks,
> >Mauro
> >  
> 
> Thanks,
> Shiju

Thanks,
Mauro

