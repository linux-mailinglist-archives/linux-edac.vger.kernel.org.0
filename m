Return-Path: <linux-edac+bounces-1928-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD2998830D
	for <lists+linux-edac@lfdr.de>; Fri, 27 Sep 2024 13:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5DC21F22DC3
	for <lists+linux-edac@lfdr.de>; Fri, 27 Sep 2024 11:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD41188732;
	Fri, 27 Sep 2024 11:17:33 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1C185628;
	Fri, 27 Sep 2024 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727435852; cv=none; b=bpGMhUglC6m1OuPsgJFeUhQQNSnGthCxUQuxYeDyp8AiOTGhOFfg+LUFHgu9/McaDsjQfS7yrLTb38+BdUMEbHQoVGyFLJxm+O+DW/JpTTE3+5hSQG3IDs5EBur9weGRPBeig/ECUP9FqtSmj3p2YseIZRol/gTKMQR6EPKRpkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727435852; c=relaxed/simple;
	bh=ppZ4ZwAZibc6+vY9ekn8xrpmKLdxdDwqbqp1GCfSZAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Txl1/UpvMwbauoqo2OG5y7OXrifogHOWXnQwIfElgNEGNz8tEUprxfybXgVw7zeuOjxUdHmlLmTtTLwhPbzduktMnX8LinMo9ZhuNrYYUGjDmVrtRixcfOt543Lu+b3qfXWdN7b6h9Yc4FYkOgh5FOVvI84j8WgpqSxCpYrwKSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XFSbM4jMPz6K6fS;
	Fri, 27 Sep 2024 19:16:47 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id C6CAA140DE5;
	Fri, 27 Sep 2024 19:17:25 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 13:17:25 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 27 Sep 2024 13:17:25 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
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
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"jgroves@micron.com" <jgroves@micron.com>, "vsalve@micron.com"
	<vsalve@micron.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)"
	<prime.zeng@hisilicon.com>, Roberto Sassu <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v12 02/17] EDAC: Add EDAC scrub control driver
Thread-Topic: [PATCH v12 02/17] EDAC: Add EDAC scrub control driver
Thread-Index: AQHbBCn4HKdgWv6WRUSg+JAQdJepo7JqpxUAgADtoXA=
Date: Fri, 27 Sep 2024 11:17:25 +0000
Message-ID: <0a815781611a4e0480380a54875eaa65@huawei.com>
References: <20240911090447.751-1-shiju.jose@huawei.com>
 <20240911090447.751-3-shiju.jose@huawei.com> <ZvXoiiOB330Kv-2Q@fan>
In-Reply-To: <ZvXoiiOB330Kv-2Q@fan>
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



>-----Original Message-----
>From: Fan Ni <nifan.cxl@gmail.com>
>Sent: 27 September 2024 00:05
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
>wbs@os.amperecomputing.com; nifan.cxl@gmail.com; jgroves@micron.com;
>vsalve@micron.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
><prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
>kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>Linuxarm <linuxarm@huawei.com>
>Subject: Re: [PATCH v12 02/17] EDAC: Add EDAC scrub control driver
>
>On Wed, Sep 11, 2024 at 10:04:31AM +0100, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add generic EDAC scrub control driver supports configuring the memory
>> scrubbers in the system. The device with scrub feature, get the scrub
>> descriptor from the EDAC scrub and registers with the EDAC RAS feature
>> driver, which adds the sysfs scrub control interface. The scrub
>> control attributes for a scrub instance are available to userspace in
>/sys/bus/edac/devices/<dev-name>/scrub*/.
>>
>> Generic EDAC scrub driver and the common sysfs scrub interface
>> promotes unambiguous access from the userspace irrespective of the
>> underlying scrub devices.
>>
>> The sysfs scrub attribute nodes would be present only if the client
>> driver has implemented the corresponding attribute callback function
>> and pass in ops to the EDAC RAS feature driver during registration.
>>
>> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  Documentation/ABI/testing/sysfs-edac-scrub |  69 ++++
>>  drivers/edac/Makefile                      |   1 +
>>  drivers/edac/edac_device.c                 |   6 +-
>>  drivers/edac/edac_scrub.c                  | 377 +++++++++++++++++++++
>>  include/linux/edac.h                       |  30 ++
>>  5 files changed, 482 insertions(+), 1 deletion(-)  create mode 100644
>> Documentation/ABI/testing/sysfs-edac-scrub
>>  create mode 100755 drivers/edac/edac_scrub.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-edac-scrub
>> b/Documentation/ABI/testing/sysfs-edac-scrub
>> new file mode 100644
>> index 000000000000..f465cc91423f
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-edac-scrub
>> @@ -0,0 +1,69 @@
>> +What:		/sys/bus/edac/devices/<dev-name>/scrub*
>
>Based on the code below, we can only have scrub0, scrub1, etc.
>So should we use scrubX instead of scrub* here.
>
>The same for below.
>
Thanks . Changed, in other patches as well.

>Fan
>
Thanks,
Shiju

>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		The sysfs EDAC bus devices /<dev-name>/scrub* subdirectory
>> +		belongs to an instance of memory scrub control feature,
>> +		where <dev-name> directory corresponds to a device/memory
>> +		region registered with the EDAC scrub driver and thus
>> +		registered with the generic EDAC RAS driver.
>> +		The sysfs scrub attr nodes would be present only if the
>> +		client driver has implemented the corresponding attr
>> +		callback function and pass in ops to the EDAC RAS feature
>> +		driver during registration.
>> +
>> +What:		/sys/bus/edac/devices/<dev-
>name>/scrub*/addr_range_base
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RW) The base of the address range of the memory region
>> +		to be scrubbed (on-demand scrubbing).
>> +
>> +What:		/sys/bus/edac/devices/<dev-
>name>/scrub*/addr_range_size
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RW) The size of the address range of the memory region
>> +		to be scrubbed (on-demand scrubbing).
>> +
>> +What:		/sys/bus/edac/devices/<dev-
>name>/scrub*/enable_background
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RW) Start/Stop background(patrol) scrubbing if supported.
>> +
>> +What:		/sys/bus/edac/devices/<dev-
>name>/scrub*/enable_on_demand
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RW) Start/Stop on-demand scrubbing the memory region
>> +		if supported.
>> +
>> +What:		/sys/bus/edac/devices/<dev-
>name>/scrub*/min_cycle_duration
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RO) Supported minimum scrub cycle duration in seconds
>> +		by the memory scrubber.
>> +
>> +What:		/sys/bus/edac/devices/<dev-
>name>/scrub*/max_cycle_duration
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RO) Supported maximum scrub cycle duration in seconds
>> +		by the memory scrubber.
>> +
>> +What:		/sys/bus/edac/devices/<dev-
>name>/scrub*/current_cycle_duration
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RW) The current scrub cycle duration in seconds and must be
>> +		within the supported range by the memory scrubber.
>> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile index
>> 4edfb83ffbee..fbf0e39ec678 100644
>> --- a/drivers/edac/Makefile
>> +++ b/drivers/edac/Makefile
>> @@ -10,6 +10,7 @@ obj-$(CONFIG_EDAC)			:=3D edac_core.o
>>
>>  edac_core-y	:=3D edac_mc.o edac_device.o edac_mc_sysfs.o
>>  edac_core-y	+=3D edac_module.o edac_device_sysfs.o wq.o
>> +edac_core-y	+=3D edac_scrub.o
>>
>>  edac_core-$(CONFIG_EDAC_DEBUG)		+=3D debugfs.o
>>
>> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
>> index e4a5d010ea2d..6381896b6424 100644
>> --- a/drivers/edac/edac_device.c
>> +++ b/drivers/edac/edac_device.c
>> @@ -608,12 +608,16 @@ static int edac_dev_feat_init(struct device *paren=
t,
>>  			      const struct edac_dev_feature *ras_feat,
>>  			      const struct attribute_group **attr_groups)  {
>> -	int num;
>> +	int num, ret;
>>
>>  	switch (ras_feat->ft_type) {
>>  	case RAS_FEAT_SCRUB:
>>  		dev_data->scrub_ops =3D ras_feat->scrub_ops;
>>  		dev_data->private =3D ras_feat->ctx;
>> +		ret =3D edac_scrub_get_desc(parent, attr_groups,
>> +					  ras_feat->instance);
>> +		if (ret)
>> +			return ret;
>>  		return 1;
>>  	case RAS_FEAT_ECS:
>>  		num =3D ras_feat->ecs_info.num_media_frus;
>> diff --git a/drivers/edac/edac_scrub.c b/drivers/edac/edac_scrub.c new
>> file mode 100755 index 000000000000..3f8f37629acf
>> --- /dev/null
>> +++ b/drivers/edac/edac_scrub.c
>> @@ -0,0 +1,377 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Generic EDAC scrub driver supports controlling the memory
>> + * scrubbers in the system and the common sysfs scrub interface
>> + * promotes unambiguous access from the userspace.
>> + *
>> + * Copyright (c) 2024 HiSilicon Limited.
>> + */
>> +
>> +#define pr_fmt(fmt)     "EDAC SCRUB: " fmt
>> +
>> +#include <linux/edac.h>
>> +
>> +enum edac_scrub_attributes {
>> +	SCRUB_ADDR_RANGE_BASE,
>> +	SCRUB_ADDR_RANGE_SIZE,
>> +	SCRUB_ENABLE_BACKGROUND,
>> +	SCRUB_ENABLE_ON_DEMAND,
>> +	SCRUB_MIN_CYCLE_DURATION,
>> +	SCRUB_MAX_CYCLE_DURATION,
>> +	SCRUB_CURRENT_CYCLE_DURATION,
>> +	SCRUB_MAX_ATTRS
>> +};
>> +
>> +struct edac_scrub_dev_attr {
>> +	struct device_attribute dev_attr;
>> +	u8 instance;
>> +};
>> +
>> +struct edac_scrub_context {
>> +	char name[EDAC_FEAT_NAME_LEN];
>> +	struct edac_scrub_dev_attr scrub_dev_attr[SCRUB_MAX_ATTRS];
>> +	struct attribute *scrub_attrs[SCRUB_MAX_ATTRS + 1];
>> +	struct attribute_group group;
>> +};
>> +
>> +#define to_scrub_dev_attr(_dev_attr)      \
>> +		container_of(_dev_attr, struct edac_scrub_dev_attr, dev_attr)
>> +
>> +static ssize_t addr_range_base_show(struct device *ras_feat_dev,
>> +				    struct device_attribute *attr,
>> +				    char *buf)
>> +{
>> +	u8 inst =3D ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))-
>>instance;
>> +	struct edac_dev_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub[inst].scrub_ops;
>> +	u64 base, size;
>> +	int ret;
>> +
>> +	ret =3D ops->read_range(ras_feat_dev->parent, ctx->scrub[inst].private=
,
>&base, &size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "0x%llx\n", base); }
>> +
>> +static ssize_t addr_range_size_show(struct device *ras_feat_dev,
>> +				    struct device_attribute *attr,
>> +				    char *buf)
>> +{
>> +	u8 inst =3D ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))-
>>instance;
>> +	struct edac_dev_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub[inst].scrub_ops;
>> +	u64 base, size;
>> +	int ret;
>> +
>> +	ret =3D ops->read_range(ras_feat_dev->parent, ctx->scrub[inst].private=
,
>&base, &size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "0x%llx\n", size); }
>> +
>> +static ssize_t addr_range_base_store(struct device *ras_feat_dev,
>> +				     struct device_attribute *attr,
>> +				     const char *buf, size_t len) {
>> +	u8 inst =3D ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))-
>>instance;
>> +	struct edac_dev_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub[inst].scrub_ops;
>> +	u64 base, size;
>> +	int ret;
>> +
>> +	ret =3D ops->read_range(ras_feat_dev->parent, ctx->scrub[inst].private=
,
>&base, &size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D kstrtou64(buf, 0, &base);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D ops->write_range(ras_feat_dev->parent, ctx->scrub[inst].privat=
e,
>base, size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return len;
>> +}
>> +
>> +static ssize_t addr_range_size_store(struct device *ras_feat_dev,
>> +				     struct device_attribute *attr,
>> +				     const char *buf,
>> +				     size_t len)
>> +{
>> +	u8 inst =3D ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))-
>>instance;
>> +	struct edac_dev_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub[inst].scrub_ops;
>> +	u64 base, size;
>> +	int ret;
>> +
>> +	ret =3D ops->read_range(ras_feat_dev->parent, ctx->scrub[inst].private=
,
>&base, &size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D kstrtou64(buf, 0, &size);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D ops->write_range(ras_feat_dev->parent, ctx->scrub[inst].privat=
e,
>base, size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return len;
>> +}
>> +
>> +static ssize_t enable_background_store(struct device *ras_feat_dev,
>> +				       struct device_attribute *attr,
>> +				       const char *buf, size_t len) {
>> +	u8 inst =3D ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))-
>>instance;
>> +	struct edac_dev_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub[inst].scrub_ops;
>> +	bool enable;
>> +	int ret;
>> +
>> +	ret =3D kstrtobool(buf, &enable);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D ops->set_enabled_bg(ras_feat_dev->parent, ctx-
>>scrub[inst].private, enable);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return len;
>> +}
>> +
>> +static ssize_t enable_background_show(struct device *ras_feat_dev,
>> +				      struct device_attribute *attr, char *buf) {
>> +	u8 inst =3D ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))-
>>instance;
>> +	struct edac_dev_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub[inst].scrub_ops;
>> +	bool enable;
>> +	int ret;
>> +
>> +	ret =3D ops->get_enabled_bg(ras_feat_dev->parent, ctx-
>>scrub[inst].private, &enable);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "%d\n", enable); }
>> +
>> +static ssize_t enable_on_demand_show(struct device *ras_feat_dev,
>> +				     struct device_attribute *attr, char *buf) {
>> +	u8 inst =3D ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))-
>>instance;
>> +	struct edac_dev_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub[inst].scrub_ops;
>> +	bool enable;
>> +	int ret;
>> +
>> +	ret =3D ops->get_enabled_od(ras_feat_dev->parent, ctx-
>>scrub[inst].private, &enable);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "%d\n", enable); }
>> +
>> +static ssize_t enable_on_demand_store(struct device *ras_feat_dev,
>> +				      struct device_attribute *attr,
>> +				      const char *buf, size_t len) {
>> +	u8 inst =3D ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))-
>>instance;
>> +	struct edac_dev_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub[inst].scrub_ops;
>> +	bool enable;
>> +	int ret;
>> +
>> +	ret =3D kstrtobool(buf, &enable);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D ops->set_enabled_od(ras_feat_dev->parent, ctx-
>>scrub[inst].private, enable);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return len;
>> +}
>> +
>> +static ssize_t min_cycle_duration_show(struct device *ras_feat_dev,
>> +				       struct device_attribute *attr,
>> +				       char *buf)
>> +{
>> +	u8 inst =3D ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))-
>>instance;
>> +	struct edac_dev_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub[inst].scrub_ops;
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret =3D ops->min_cycle_read(ras_feat_dev->parent, ctx-
>>scrub[inst].private, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "%u\n", val); }
>> +
>> +static ssize_t max_cycle_duration_show(struct device *ras_feat_dev,
>> +				       struct device_attribute *attr,
>> +				       char *buf)
>> +{
>> +	u8 inst =3D ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))-
>>instance;
>> +	struct edac_dev_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub[inst].scrub_ops;
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret =3D ops->max_cycle_read(ras_feat_dev->parent, ctx-
>>scrub[inst].private, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "%u\n", val); }
>> +
>> +static ssize_t current_cycle_duration_show(struct device *ras_feat_dev,
>> +					   struct device_attribute *attr,
>> +					   char *buf)
>> +{
>> +	u8 inst =3D ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))-
>>instance;
>> +	struct edac_dev_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub[inst].scrub_ops;
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret =3D ops->cycle_duration_read(ras_feat_dev->parent, ctx-
>>scrub[inst].private, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "%u\n", val); }
>> +
>> +static ssize_t current_cycle_duration_store(struct device *ras_feat_dev=
,
>> +					    struct device_attribute *attr,
>> +					    const char *buf, size_t len) {
>> +	u8 inst =3D ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(attr))-
>>instance;
>> +	struct edac_dev_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub[inst].scrub_ops;
>> +	long val;
>> +	int ret;
>> +
>> +	ret =3D kstrtol(buf, 0, &val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D ops->cycle_duration_write(ras_feat_dev->parent, ctx-
>>scrub[inst].private, val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return len;
>> +}
>> +
>> +static umode_t scrub_attr_visible(struct kobject *kobj,
>> +				  struct attribute *a, int attr_id) {
>> +	struct device *ras_feat_dev =3D kobj_to_dev(kobj);
>> +	struct device_attribute *dev_attr =3D
>> +				container_of(a, struct device_attribute, attr);
>> +	u8 inst =3D ((struct edac_scrub_dev_attr *)to_scrub_dev_attr(dev_attr)=
)-
>>instance;
>> +	struct edac_dev_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub[inst].scrub_ops;
>> +
>> +	switch (attr_id) {
>> +	case SCRUB_ADDR_RANGE_BASE:
>> +	case SCRUB_ADDR_RANGE_SIZE:
>> +		if (ops->read_range && ops->write_range)
>> +			return a->mode;
>> +		if (ops->read_range)
>> +			return 0444;
>> +		return 0;
>> +	case SCRUB_ENABLE_BACKGROUND:
>> +		if (ops->get_enabled_bg && ops->set_enabled_bg)
>> +			return a->mode;
>> +		if (ops->get_enabled_bg)
>> +			return 0444;
>> +		return 0;
>> +	case SCRUB_ENABLE_ON_DEMAND:
>> +		if (ops->get_enabled_od && ops->set_enabled_od)
>> +			return a->mode;
>> +		if (ops->get_enabled_od)
>> +			return 0444;
>> +		return 0;
>> +	case SCRUB_MIN_CYCLE_DURATION:
>> +		return ops->min_cycle_read ? a->mode : 0;
>> +	case SCRUB_MAX_CYCLE_DURATION:
>> +		return ops->max_cycle_read ? a->mode : 0;
>> +	case SCRUB_CURRENT_CYCLE_DURATION:
>> +		if (ops->cycle_duration_read && ops->cycle_duration_write)
>> +			return a->mode;
>> +		if (ops->cycle_duration_read)
>> +			return 0444;
>> +		return 0;
>> +	default:
>> +		return 0;
>> +	}
>> +}
>> +
>> +#define EDAC_SCRUB_ATTR_RO(_name, _instance)       \
>> +	((struct edac_scrub_dev_attr) { .dev_attr =3D __ATTR_RO(_name), \
>> +				     .instance =3D _instance })
>> +
>> +#define EDAC_SCRUB_ATTR_WO(_name, _instance)       \
>> +	((struct edac_scrub_dev_attr) { .dev_attr =3D __ATTR_WO(_name), \
>> +				     .instance =3D _instance })
>> +
>> +#define EDAC_SCRUB_ATTR_RW(_name, _instance)       \
>> +	((struct edac_scrub_dev_attr) { .dev_attr =3D __ATTR_RW(_name), \
>> +				     .instance =3D _instance })
>> +
>> +static int scrub_create_desc(struct device *scrub_dev,
>> +			     const struct attribute_group **attr_groups,
>> +			     u8 instance)
>> +{
>> +	struct edac_scrub_context *scrub_ctx;
>> +	struct attribute_group *group;
>> +	int i;
>> +
>> +	scrub_ctx =3D devm_kzalloc(scrub_dev, sizeof(*scrub_ctx), GFP_KERNEL);
>> +	if (!scrub_ctx)
>> +		return -ENOMEM;
>> +
>> +	group =3D &scrub_ctx->group;
>> +	scrub_ctx->scrub_dev_attr[0] =3D
>EDAC_SCRUB_ATTR_RW(addr_range_base, instance);
>> +	scrub_ctx->scrub_dev_attr[1] =3D
>EDAC_SCRUB_ATTR_RW(addr_range_size, instance);
>> +	scrub_ctx->scrub_dev_attr[2] =3D
>EDAC_SCRUB_ATTR_RW(enable_background, instance);
>> +	scrub_ctx->scrub_dev_attr[3] =3D
>EDAC_SCRUB_ATTR_RW(enable_on_demand, instance);
>> +	scrub_ctx->scrub_dev_attr[4] =3D
>EDAC_SCRUB_ATTR_RO(min_cycle_duration, instance);
>> +	scrub_ctx->scrub_dev_attr[5] =3D
>EDAC_SCRUB_ATTR_RO(max_cycle_duration, instance);
>> +	scrub_ctx->scrub_dev_attr[6] =3D
>EDAC_SCRUB_ATTR_RW(current_cycle_duration, instance);
>> +	for (i =3D 0; i < SCRUB_MAX_ATTRS; i++)
>> +		scrub_ctx->scrub_attrs[i] =3D
>> +&scrub_ctx->scrub_dev_attr[i].dev_attr.attr;
>> +
>> +	sprintf(scrub_ctx->name, "%s%d", "scrub", instance);
>> +	group->name =3D scrub_ctx->name;
>> +	group->attrs =3D scrub_ctx->scrub_attrs;
>> +	group->is_visible  =3D scrub_attr_visible;
>> +
>> +	attr_groups[0] =3D group;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * edac_scrub_get_desc - get EDAC scrub descriptors
>> + * @scrub_dev: client device, with scrub support
>> + * @attr_groups: pointer to attrribute group container
>> + * @instance: device's scrub instance number.
>> + *
>> + * Returns 0 on success, error otherwise.
>> + */
>> +int edac_scrub_get_desc(struct device *scrub_dev,
>> +			const struct attribute_group **attr_groups,
>> +			u8 instance)
>> +{
>> +	if (!scrub_dev || !attr_groups)
>> +		return -EINVAL;
>> +
>> +	return scrub_create_desc(scrub_dev, attr_groups, instance); }
>> diff --git a/include/linux/edac.h b/include/linux/edac.h index
>> b337254cf5b8..aae8262b9863 100644
>> --- a/include/linux/edac.h
>> +++ b/include/linux/edac.h
>> @@ -674,6 +674,36 @@ enum edac_dev_feat {
>>  	RAS_FEAT_MAX
>>  };
>>
>> +/**
>> + * struct scrub_ops - scrub device operations (all elements optional)
>> + * @read_range: read base and offset of scrubbing range.
>> + * @write_range: set the base and offset of the scrubbing range.
>> + * @get_enabled_bg: check if currently performing background scrub.
>> + * @set_enabled_bg: start or stop a bg-scrub.
>> + * @get_enabled_od: check if currently performing on-demand scrub.
>> + * @set_enabled_od: start or stop an on-demand scrub.
>> + * @min_cycle_read: minimum supported scrub cycle duration in seconds.
>> + * @max_cycle_read: maximum supported scrub cycle duration in seconds.
>> + * @cycle_duration_read: get the scrub cycle duration in seconds.
>> + * @cycle_duration_write: set the scrub cycle duration in seconds.
>> + */
>> +struct edac_scrub_ops {
>> +	int (*read_range)(struct device *dev, void *drv_data, u64 *base, u64
>*size);
>> +	int (*write_range)(struct device *dev, void *drv_data, u64 base, u64
>size);
>> +	int (*get_enabled_bg)(struct device *dev, void *drv_data, bool *enable=
);
>> +	int (*set_enabled_bg)(struct device *dev, void *drv_data, bool enable)=
;
>> +	int (*get_enabled_od)(struct device *dev, void *drv_data, bool *enable=
);
>> +	int (*set_enabled_od)(struct device *dev, void *drv_data, bool enable)=
;
>> +	int (*min_cycle_read)(struct device *dev, void *drv_data,  u32 *min);
>> +	int (*max_cycle_read)(struct device *dev, void *drv_data,  u32 *max);
>> +	int (*cycle_duration_read)(struct device *dev, void *drv_data, u32
>*cycle);
>> +	int (*cycle_duration_write)(struct device *dev, void *drv_data, u32
>> +cycle); };
>> +
>> +int edac_scrub_get_desc(struct device *scrub_dev,
>> +			const struct attribute_group **attr_groups,
>> +			u8 instance);
>> +
>>  struct edac_ecs_ex_info {
>>  	u16 num_media_frus;
>>  };
>> --
>> 2.34.1
>>
>
>--
>Fan Ni

