Return-Path: <linux-edac+bounces-1879-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 616F8979E5D
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2024 11:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 716CDB22DDA
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2024 09:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114D314A635;
	Mon, 16 Sep 2024 09:22:23 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3637B14A4F5;
	Mon, 16 Sep 2024 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478543; cv=none; b=RHIIkMn5vIYREIk/GZIfrbUPy7ZaE1Wc1CzWGbu6bnH15w3EIeUwZIu/JVS2ZqHoxj2wWKKhCQhZcXuIiXYzKfQAtO4sf6QW6I7Wm8+Ti2qeGJzxy1cEnru/36UesSvYNmsLOIImS/gqA5ZCJyEoDS2vBrrS0mC+OhL7tqff3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478543; c=relaxed/simple;
	bh=MN2SymGpDTGPEttnNalBIMddYBAEZnHau3raj7SLnXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LiKicCoArV1cWyhpd14l9fUQParXZ+4jadR8eSIv0hqDSvhFSPzw6SsjxMxF84gM14fVJbiAg3Nb9Jn3tL0P8U9CBMD5WOpfw7zoMLrJCNrPRgIBp1ELoBgYlj13LFna0Qbj2MKEpl/Au6zwAl/heE+0qbCRvbZxGOghq+rVIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6fZF6G1kz67Lm9;
	Mon, 16 Sep 2024 17:22:13 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 78F5B140A90;
	Mon, 16 Sep 2024 17:22:17 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 11:22:17 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 16 Sep 2024 11:22:17 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
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
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "jgroves@micron.com"
	<jgroves@micron.com>, "vsalve@micron.com" <vsalve@micron.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v12 02/17] EDAC: Add EDAC scrub control driver
Thread-Topic: [PATCH v12 02/17] EDAC: Add EDAC scrub control driver
Thread-Index: AQHbBCn4HKdgWv6WRUSg+JAQdJepo7JV2d6AgARJjKA=
Date: Mon, 16 Sep 2024 09:22:17 +0000
Message-ID: <78c387a7074a4146b34dc853a6798883@huawei.com>
References: <20240911090447.751-1-shiju.jose@huawei.com>
	<20240911090447.751-3-shiju.jose@huawei.com>
 <20240913172501.GLZuR1bWp0aYXaYfw7@fat_crate.local>
In-Reply-To: <20240913172501.GLZuR1bWp0aYXaYfw7@fat_crate.local>
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

Thanks for reviewing.

>-----Original Message-----
>From: Borislav Petkov <bp@alien8.de>
>Sent: 13 September 2024 18:25
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
>acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
>tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
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
>> scrubbers
>
>s/supports configuring the/in order to configure/
Will change.

>
>> in the system. The device with scrub feature, get the scrub descriptor
>> from the EDAC scrub and registers with the EDAC RAS feature driver,
>> which adds the sysfs scrub control interface.
>
>That sentence reads wrong.
You are right.  Will update.
>
>> The scrub control attributes for a scrub instance are available to
>> userspace in /sys/bus/edac/devices/<dev-name>/scrub*/.
>>
>> Generic EDAC scrub driver and the common sysfs scrub interface
>> promotes unambiguous access from the userspace irrespective of the
>> underlying scrub devices.
>
>Huh?
>
>Do you wanna say something along the lines that the common sysfs scrub
>interface abstracts the control of an arbitrary scrubbing functionality in=
to a
>common set of functions or so?
Sure. Will change.
>
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
>
>...
>
>> +What:		/sys/bus/edac/devices/<dev-
>name>/scrub*/current_cycle_duration
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RW) The current scrub cycle duration in seconds and must be
>> +		within the supported range by the memory scrubber.
>
>So in reading about that interface, where is the user doc explaining how o=
ne
>should use scrubbers?
User doc for scrub feature is part of the patches for=20
CXL patrol scrub, https://lore.kernel.org/linux-mm/20240911090447.751-11-sh=
iju.jose@huawei.com/
RAS2 scrub, https://lore.kernel.org/linux-mm/20240911090447.751-15-shiju.jo=
se@huawei.com/=20
>
>> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile index
>> 4edfb83ffbee..fbf0e39ec678 100644
>> --- a/drivers/edac/Makefile
>> +++ b/drivers/edac/Makefile
>> @@ -10,6 +10,7 @@ obj-$(CONFIG_EDAC)			:=3D edac_core.o
>>
>>  edac_core-y	:=3D edac_mc.o edac_device.o edac_mc_sysfs.o
>>  edac_core-y	+=3D edac_module.o edac_device_sysfs.o wq.o
>> +edac_core-y	+=3D edac_scrub.o
>
>Just scrub.[co]. The file is already in drivers/edac/. Too many "edac"
>strings. :)
Ok. Will change the file names.
>
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
>
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
>
>Can all that repetitive code be abstracted away in macros pls?
>
>Below too.
Sure.  Will do.
>
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
>
>No silly linebreaks like that pls. Check your whole patchset.
Will change.
>
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
>
>		if (...read_range) {
>			if (...write_range)
>				return a->mode;
>			else
>				return 0444:
>		}
>		break;
>
>and now put a single "return 0;" at the end of the function.
Will do, if  increase in  lines of code is ok?=20
>
>Below too.
>
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
>
>		if (ops->min_cycle_read)
>			return a->mode;
>
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
>> +EDAC_SCRUB_ATTR_RW(current_cycle_duration, instance);
>
>Why use the naked numbers when you have enum edac_scrub_attributes?
Sure.=20
>
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
>
>+ * @attr_groups: pointer to attrribute group container
>Unknown word [attrribute] in comment.
>Suggestions: ['attribute', 'attributed', 'attributes', "attribute's", 'att=
ributive',
>'tribute']
>
>Please introduce a spellchecker into your patch creation workflow.
Sure.
>
>--
>Regards/Gruss,
>    Boris.
>
>https://people.kernel.org/tglx/notes-about-netiquette
>

Thanks,
Shiju


