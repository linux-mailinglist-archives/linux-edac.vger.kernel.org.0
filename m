Return-Path: <linux-edac+bounces-1534-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF59F933BC8
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 13:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E819B1C22ACE
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8651A17F39A;
	Wed, 17 Jul 2024 11:06:49 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EFD17E8FD;
	Wed, 17 Jul 2024 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214409; cv=none; b=T3ShlXMEgr+sw+pJpIWJAuZry+5pfeQ5RVV7OzIYbWBsIMjjDGMQbXF4Ds2D+EoykOgCPcz5RbkfH8T4RRUsAR2vh97Ott/AexwA9A1Wbt1iNguy+R0gEsPtAngY2Bg0E5xe1H4jp/rAz/rROQrzn9vLp38eNq+lSp7Ro3L+620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214409; c=relaxed/simple;
	bh=rKjsm66nd2Yy3GanOS6mfhnJt810rHEaDxggUXYZgSY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gJELqHrHeVOkFtfnPvRLyRqjOhD9EktNYcYd2rrsjz6Tc/sy7lMdnY+RtmiHZ11q3wPXe/X9kokNw58naGs9zA88bmzdePje7VTjdFAs+bppwzSBGoq0YdcG+GuZfjTq2N+PT0m66xbd2CEHXrG2aL4o4HtQpDTCHo5sAj9hYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPClS6rvBz6JB8C;
	Wed, 17 Jul 2024 19:05:24 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 21799140A08;
	Wed, 17 Jul 2024 19:06:43 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 12:06:42 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.039;
 Wed, 17 Jul 2024 12:06:42 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
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
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH v9 01/11] EDAC: Add generic EDAC RAS feature driver
Thread-Topic: [RFC PATCH v9 01/11] EDAC: Add generic EDAC RAS feature driver
Thread-Index: AQHa15FyV2KoSGHoUUqpwpmK3mdCjbH5lEYAgAEuFlA=
Date: Wed, 17 Jul 2024 11:06:42 +0000
Message-ID: <f271f9a257e64b398783717237e63186@huawei.com>
References: <20240716150336.2042-1-shiju.jose@huawei.com>
 <20240716150336.2042-2-shiju.jose@huawei.com> <Zpa1UNTOcJgcq2q5@debian>
In-Reply-To: <Zpa1UNTOcJgcq2q5@debian>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Fan,

Thanks for the feedback.

>-----Original Message-----
>From: fan <nifan.cxl@gmail.com>
>Sent: 16 July 2024 19:01
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
>acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
>bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
>mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
>Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
>Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
>Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
>naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
>duenwen@google.com; mike.malvestuto@intel.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
>Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
>wanghuiqiang <wanghuiqiang@huawei.com>; Linuxarm
><linuxarm@huawei.com>
>Subject: Re: [RFC PATCH v9 01/11] EDAC: Add generic EDAC RAS feature drive=
r
>
>On Tue, Jul 16, 2024 at 04:03:25PM +0100, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add generic EDAC driver supports registering RAS features supported in
>> the system. The driver exposes feature's control attributes to the
>> userspace in /sys/bus/edac/devices/<dev-name>/<ras-feature>/
>>
>> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/edac/Makefile            |   1 +
>>  drivers/edac/edac_ras_feature.c  | 155
>> +++++++++++++++++++++++++++++++  include/linux/edac_ras_feature.h |
>> 66 +++++++++++++
>>  3 files changed, 222 insertions(+)
>>  create mode 100755 drivers/edac/edac_ras_feature.c  create mode
>> 100755 include/linux/edac_ras_feature.h
>>
>> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile index
>> 9c09893695b7..c532b57a6d8a 100644
>> --- a/drivers/edac/Makefile
>> +++ b/drivers/edac/Makefile
>> @@ -10,6 +10,7 @@ obj-$(CONFIG_EDAC)			:=3D edac_core.o
>>
>>  edac_core-y	:=3D edac_mc.o edac_device.o edac_mc_sysfs.o
>>  edac_core-y	+=3D edac_module.o edac_device_sysfs.o wq.o
>> +edac_core-y	+=3D edac_ras_feature.o
>>
>>  edac_core-$(CONFIG_EDAC_DEBUG)		+=3D debugfs.o
>>
>> diff --git a/drivers/edac/edac_ras_feature.c
>> b/drivers/edac/edac_ras_feature.c new file mode 100755 index
>> 000000000000..24a729fea66f
>> --- /dev/null
>> +++ b/drivers/edac/edac_ras_feature.c
>> @@ -0,0 +1,155 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * EDAC RAS control feature driver supports registering RAS
>> + * features with the EDAC and exposes the feature's control
>> + * attributes to the userspace in sysfs.
>> + *
>> + * Copyright (c) 2024 HiSilicon Limited.
>> + */
>> +
>> +#define pr_fmt(fmt)     "EDAC RAS CONTROL FEAT: " fmt
>> +
>> +#include <linux/edac_ras_feature.h>
>> +
>> +static void edac_ras_dev_release(struct device *dev) {
>> +	struct edac_ras_feat_ctx *ctx =3D
>> +		container_of(dev, struct edac_ras_feat_ctx, dev);
>> +
>> +	kfree(ctx);
>> +}
>> +
>> +const struct device_type edac_ras_dev_type =3D {
>> +	.name =3D "edac_ras_dev",
>> +	.release =3D edac_ras_dev_release,
>> +};
>> +
>> +static void edac_ras_dev_unreg(void *data) {
>> +	device_unregister(data);
>> +}
>> +
>> +static int edac_ras_feat_scrub_init(struct device *parent,
>> +				    struct edac_scrub_data *sdata,
>> +				    const struct edac_ras_feature *sfeat,
>> +				    const struct attribute_group **attr_groups) {
>> +	sdata->ops =3D sfeat->scrub_ops;
>> +	sdata->private =3D sfeat->scrub_ctx;
>> +
>> +	return 1;
>> +}
>> +
>> +static int edac_ras_feat_ecs_init(struct device *parent,
>> +				  struct edac_ecs_data *edata,
>> +				  const struct edac_ras_feature *efeat,
>> +				  const struct attribute_group **attr_groups) {
>> +	int num =3D efeat->ecs_info.num_media_frus;
>> +
>> +	edata->ops =3D efeat->ecs_ops;
>> +	edata->private =3D efeat->ecs_ctx;
>> +
>> +	return num;
>> +}
>> +
>> +/**
>> + * edac_ras_dev_register - register device for ras features with edac
>> + * @parent: client device.
>> + * @name: client device's name.
>> + * @private: parent driver's data to store in the context if any.
>> + * @num_features: number of ras features to register.
>> + * @ras_features: list of ras features to register.
>> + *
>> + * Returns 0 on success, error otherwise.
>> + * The new edac_ras_feat_ctx would be freed automatically.
>> + */
>> +int edac_ras_dev_register(struct device *parent, char *name,
>> +			  void *private, int num_features,
>> +			  const struct edac_ras_feature *ras_features) {
>> +	const struct attribute_group **ras_attr_groups;
>> +	struct edac_ras_feat_ctx *ctx;
>> +	int attr_gcnt =3D 0;
>> +	int ret, feat;
>> +
>> +	if (!parent || !name || !num_features || !ras_features)
>> +		return -EINVAL;
>> +
>> +	ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
>> +	if (!ctx)
>> +		return -ENOMEM;
>> +
>> +	ctx->dev.parent =3D parent;
>> +	ctx->private =3D private;
>> +
>> +	/* Double parse so we can make space for attributes */
>> +	for (feat =3D 0; feat < num_features; feat++) {
>> +		switch (ras_features[feat].feat) {
>> +		case ras_feat_scrub:
>> +			attr_gcnt++;
>> +			break;
>> +		case ras_feat_ecs:
>> +			attr_gcnt +=3D
>ras_features[feat].ecs_info.num_media_frus;
>> +			break;
>> +		default:
>> +			ret =3D -EINVAL;
>> +			goto ctx_free;
>> +		}
>> +	}
>> +
>> +	ras_attr_groups =3D devm_kzalloc(parent,
>> +				       (attr_gcnt + 1) * sizeof(*ras_attr_groups),
>> +				       GFP_KERNEL);
>> +	if (!ras_attr_groups) {
>> +		ret =3D -ENOMEM;
>> +		goto ctx_free;
>> +	}
>> +
>> +	attr_gcnt =3D 0;
>> +	for (feat =3D 0; feat < num_features; feat++, ras_features++) {
>> +		if (ras_features->feat =3D=3D ras_feat_scrub) {
>> +			if (!ras_features->scrub_ops)
>> +				continue;
>> +			ret =3D edac_ras_feat_scrub_init(parent, &ctx->scrub,
>> +						       ras_features,
>&ras_attr_groups[attr_gcnt]);
>> +			if (ret < 0)
>> +				goto ctx_free;
>> +
>> +			attr_gcnt +=3D ret;
>> +		} else if (ras_features->feat =3D=3D ras_feat_ecs) {
>> +			if (!ras_features->ecs_ops)
>> +				continue;
>> +			ret =3D edac_ras_feat_ecs_init(parent, &ctx->ecs,
>> +						     ras_features,
>&ras_attr_groups[attr_gcnt]);
>> +			if (ret < 0)
>> +				goto ctx_free;
>> +
>> +			attr_gcnt +=3D ret;
>> +		} else {
>> +			ret =3D -EINVAL;
>> +			goto ctx_free;
>We already check this in the first pass, cannot be reached in the second p=
ass.
Will change.

>> +		}
>Why use if/else instead of using switch/case as above?
Will do.

>> +	}
>> +	ras_attr_groups[attr_gcnt] =3D NULL;
>> +	ctx->dev.bus =3D edac_get_sysfs_subsys();
>> +	ctx->dev.type =3D &edac_ras_dev_type;
>> +	ctx->dev.groups =3D ras_attr_groups;
>> +	dev_set_drvdata(&ctx->dev, ctx);
>> +	ret =3D dev_set_name(&ctx->dev, name);
>> +	if (ret)
>> +		goto ctx_free;
>> +
>> +	ret =3D device_register(&ctx->dev);
>> +	if (ret) {
>> +		put_device(&ctx->dev);
>need to free ctx?
Will fix.

>> +		return ret;
>> +	}
>> +
>> +	return devm_add_action_or_reset(parent, edac_ras_dev_unreg,
>> +&ctx->dev);
>> +
>> +ctx_free:
>> +	kfree(ctx);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(edac_ras_dev_register);
>> diff --git a/include/linux/edac_ras_feature.h
>> b/include/linux/edac_ras_feature.h
>> new file mode 100755
>> index 000000000000..000e99141023
>> --- /dev/null
>> +++ b/include/linux/edac_ras_feature.h
>> @@ -0,0 +1,66 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * EDAC RAS control features.
>> + *
>> + * Copyright (c) 2024 HiSilicon Limited.
>> + */
>> +
>> +#ifndef __EDAC_RAS_FEAT_H
>> +#define __EDAC_RAS_FEAT_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/edac.h>
>> +
>> +#define EDAC_RAS_NAME_LEN	128
>> +
>> +enum edac_ras_feat {
>> +	ras_feat_scrub,
>> +	ras_feat_ecs,
>> +	ras_feat_max
>> +};
>Use uppercase for the strings.
Will do.

>
>Fan
>> +
>> +struct edac_ecs_ex_info {
>> +	u16 num_media_frus;
>> +};
>> +
>> +/*
>> + * EDAC RAS feature information structure  */ struct edac_scrub_data
>> +{
>> +	const struct edac_scrub_ops *ops;
>> +	void *private;
>> +};
>> +
>> +struct edac_ecs_data {
>> +	const struct edac_ecs_ops *ops;
>> +	void *private;
>> +};
>> +
>> +struct device;
>> +
>> +struct edac_ras_feat_ctx {
>> +	struct device dev;
>> +	void *private;
>> +	struct edac_scrub_data scrub;
>> +	struct edac_ecs_data ecs;
>> +};
>> +
>> +struct edac_ras_feature {
>> +	enum edac_ras_feat feat;
>> +	union {
>> +		const struct edac_scrub_ops *scrub_ops;
>> +		const struct edac_ecs_ops *ecs_ops;
>> +	};
>> +	union {
>> +		struct edac_ecs_ex_info ecs_info;
>> +	};
>> +	union {
>> +		void *scrub_ctx;
>> +		void *ecs_ctx;
>> +	};
>> +};
>> +
>> +int edac_ras_dev_register(struct device *parent, char *dev_name,
>> +			  void *parent_pvt_data, int num_features,
>> +			  const struct edac_ras_feature *ras_features); #endif
>/*
>> +__EDAC_RAS_FEAT_H */
>> --
>> 2.34.1
>>

Thanks,
Shiju

