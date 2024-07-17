Return-Path: <linux-edac+bounces-1537-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6F5933E28
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 16:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07841F21D67
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 14:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B68180A8E;
	Wed, 17 Jul 2024 14:07:31 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E0717E911;
	Wed, 17 Jul 2024 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721225251; cv=none; b=JEc+b8yq/dVk45BSEOsxNoauG16xgVr2Aekcy7IwVDpdFrNdxKdsJJJHrHIT/qK1bqQUWUbntdkHSY/LbdJCdQH2JrsVr6D4s875zJGxjgq+hp1p6acbWp3RqoDLdkDMBMG1cNW0mMME7+w/kPQXFjErkW5aqVakiMjbOA+XSMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721225251; c=relaxed/simple;
	bh=V7cy78k7KeOXFbggPP7dPeLu5wFandjrvC6gu/zOGss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p6158oh6FzK/pyLidJKQ5jvyC7ZW84g2YZbcyfBjlURsfU6g871HJ09wMoxehmQZW+Z+etzwSKSkTl+bZAL/zMkuEuCbZPXjTG2rrWmJq3prDKkbPHMVMcJ/SpzRV4u5iaPSb5lX5Pl4bjQ0+Slpg9qp9cIOkUopzmTtzgQd5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPHkY04YLz6DB7F;
	Wed, 17 Jul 2024 22:04:53 +0800 (CST)
Received: from lhrpeml100001.china.huawei.com (unknown [7.191.160.183])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DB74140CB9;
	Wed, 17 Jul 2024 22:07:07 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100001.china.huawei.com (7.191.160.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 15:07:05 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.039;
 Wed, 17 Jul 2024 15:07:05 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH v9 02/11] EDAC: Add EDAC scrub control driver
Thread-Topic: [RFC PATCH v9 02/11] EDAC: Add EDAC scrub control driver
Thread-Index: AQHa15FzxBoF3WxYI026PkKugXi7mbH60ZgAgAAUPxA=
Date: Wed, 17 Jul 2024 14:07:05 +0000
Message-ID: <ff37e3dd6f804964b7d15d1f917359fb@huawei.com>
References: <20240716150336.2042-1-shiju.jose@huawei.com>
	<20240716150336.2042-3-shiju.jose@huawei.com>
 <20240717145632.436a0cb0@foz.lan>
In-Reply-To: <20240717145632.436a0cb0@foz.lan>
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
>From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>Sent: 17 July 2024 13:57
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
>Subject: Re: [RFC PATCH v9 02/11] EDAC: Add EDAC scrub control driver
>
>Em Tue, 16 Jul 2024 16:03:26 +0100
><shiju.jose@huawei.com> escreveu:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add generic EDAC scrub control driver supports configuring the memory
>> scrubbers in the system. The device with scrub feature, get the scrub
>> descriptor from the EDAC scrub and registers with the EDAC RAS feature
>> driver, which adds the sysfs scrub control interface. The scrub
>> control attributes are available to the userspace in
>/sys/bus/edac/devices/<dev-name>/scrub/.
>>
>> Generic EDAC scrub driver and the common sysfs scrub interface
>> promotes unambiguous access from the userspace irrespective of the
>> underlying scrub devices.
>>
>> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  Documentation/ABI/testing/sysfs-edac-scrub |  64 +++++
>>  drivers/edac/Makefile                      |   2 +-
>>  drivers/edac/edac_ras_feature.c            |   1 +
>>  drivers/edac/edac_scrub.c                  | 312 +++++++++++++++++++++
>>  include/linux/edac_ras_feature.h           |  28 ++
>>  5 files changed, 406 insertions(+), 1 deletion(-)  create mode 100644
>> Documentation/ABI/testing/sysfs-edac-scrub
>>  create mode 100755 drivers/edac/edac_scrub.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-edac-scrub
>> b/Documentation/ABI/testing/sysfs-edac-scrub
>> new file mode 100644
>> index 000000000000..dd19afd5e165
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-edac-scrub
>> @@ -0,0 +1,64 @@
>> +What:		/sys/bus/edac/devices/<dev-name>/scrub
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		The sysfs edac bus devices /<dev-name>/scrub subdirectory
>> +		belongs to the memory scrub control feature, where <dev-
>name>
>> +		directory corresponds to a device/memory region registered
>> +		with the edac scrub driver and thus registered with the
>> +		generic edac ras driver too.
>> +
>> +What:		/sys/bus/edac/devices/<dev-
>name>/scrub/addr_range_base
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RW) The base of the address range of the memory region
>> +		to be scrubbed (on-demand scrubbing).
>> +
>> +What:		/sys/bus/edac/devices/<dev-
>name>/scrub/addr_range_size
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RW) The size of the address range of the memory region
>> +		to be scrubbed (on-demand scrubbing).
>> +
>> +What:		/sys/bus/edac/devices/<dev-
>name>/scrub/enable_background
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RW) Start/Stop background(patrol) scrubbing if supported.
>> +
>> +What:		/sys/bus/edac/devices/<dev-
>name>/scrub/enable_on_demand
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RW) Start/Stop on-demand scrubbing the memory region
>> +		if supported.
>
>This is a generic comment for all sysfs calls: what happens if not support=
ed?
>
>There are a couple of ways to implement it, like:
>
>1. Don't create the attribute;
>2. return an error code (-ENOENT? -EINVAL?) if trying to read or
>   write to the devnode - please detail the used error code(s);
>
>In any case, please define the behavior and document it.
>
>From what I see, you're setting 0x444 on RW nodes when write is not enable=
d,
>but still it is possible to not have RO supported. This is specially true =
as
>technology evolves, as memory controllers and different types of memories =
may
>have very different ways to control it[1].

It is not true. If the parent device does not support and define callbacks =
for both read and write,
then return 0 as you can see in the scrub_attr_visible() and the attribute
would not be present for that device in the sysfs.
For e.g. attributes addr_range_base and addr_range_size does not support by=
 CXL patrol
scrub feature, but supported by ACPI RAS2 scrub feature. =20
>
>[1] If you're curious enough, one legacy example of memories
>    implemented on a very different way was Fully Buffered DIMMs
>    where each DIMM had its own internal chipset to offload
>    certain tasks, including scrubbing and ECC implementation.
>    It ended not being succeeded long term, as it required
>    special DIMMs for server's market, reducing the production
>    scale, but it is an interesting example about how hardware
>    designs could be innovative breaking existing paradigms.
>    The FB-DIMM design actually forced a redesign at the EDAC
>    subsystem, as it was too centered on how an specific type
>    of memory controllers.
>
>> +
>> +What:		/sys/bus/edac/devices/<dev-name>/scrub/name
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RO) name of the memory scrubber
>> +
>
>
>> +What:		/sys/bus/edac/devices/<dev-
>name>/scrub/cycle_in_hours_available
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RO) Supported range for the scrub cycle in hours by the
>> +		memory scrubber.
>> +
>> +What:		/sys/bus/edac/devices/<dev-
>name>/scrub/cycle_in_hours
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RW) The scrub cycle in hours specified and it must be with in
>the
>> +		supported range by the memory scrubber.
>
>Why specifying it in hours? I would use seconds, as it is easy to represen=
t one
>hour as 3600 seconds, but you can't specify a cycle of, let's say, 30min, =
if the
>minimum range value is one hour.
For the CXL patrol scrub, scrub cycle defined in hours(CXL spec 3.1 Table 8=
-208. Device Patrol Scrub
Control Feature Writable Attributes), but ACPI RAS2 does not define the uni=
t for the scrub cycle.
Thus proposed  represent scrub cycle in hours in common.
Not sure how convenient to set the scrub cycle in seconds from the user per=
spective and
also is it require to finish the background scrubbing in such short time?

>
>I mean, we never know how technology will evolve nor how manufacturers wil=
l
>implement support for scrubbing cycle on their chipsets.
>
>> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile index
>> c532b57a6d8a..de56cbd039eb 100644
>> --- a/drivers/edac/Makefile
>> +++ b/drivers/edac/Makefile
>> @@ -10,7 +10,7 @@ obj-$(CONFIG_EDAC)			:=3D edac_core.o
>>
>>  edac_core-y	:=3D edac_mc.o edac_device.o edac_mc_sysfs.o
>>  edac_core-y	+=3D edac_module.o edac_device_sysfs.o wq.o
>> -edac_core-y	+=3D edac_ras_feature.o
>> +edac_core-y	+=3D edac_ras_feature.o edac_scrub.o
>>
>>  edac_core-$(CONFIG_EDAC_DEBUG)		+=3D debugfs.o
>>
>> diff --git a/drivers/edac/edac_ras_feature.c
>> b/drivers/edac/edac_ras_feature.c index 24a729fea66f..48927f868372
>> 100755
>> --- a/drivers/edac/edac_ras_feature.c
>> +++ b/drivers/edac/edac_ras_feature.c
>> @@ -36,6 +36,7 @@ static int edac_ras_feat_scrub_init(struct device
>> *parent,  {
>>  	sdata->ops =3D sfeat->scrub_ops;
>>  	sdata->private =3D sfeat->scrub_ctx;
>> +	attr_groups[0] =3D edac_scrub_get_desc();
>>
>>  	return 1;
>>  }
>> diff --git a/drivers/edac/edac_scrub.c b/drivers/edac/edac_scrub.c new
>> file mode 100755 index 000000000000..0b07eafd3551
>> --- /dev/null
>> +++ b/drivers/edac/edac_scrub.c
>> @@ -0,0 +1,312 @@
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
>> +#include <linux/edac_ras_feature.h>
>> +
>> +static ssize_t addr_range_base_show(struct device *ras_feat_dev,
>> +				    struct device_attribute *attr,
>> +				    char *buf)
>> +{
>> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
>> +	u64 base, size;
>> +	int ret;
>> +
>> +	ret =3D ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &bas=
e,
>&size);
>> +	if (ret)
>> +		return ret;
>
>Also a generic comment applied to all devnodes: what if ops->read_range is
>NULL? Shouldn't it be checked? Btw, you could use read_range =3D=3D NULL i=
f to
>implement error handling for unsupported features.
If ops->read_range is NULL, scrub_attr_visible() return 0 and then the corr=
esponding attributes
addr_range_base and addr_range_size  would not be added in the sysfs.
Same for other attributes.
>
>> +
>> +	return sysfs_emit(buf, "0x%llx\n", base); }
>> +
>> +static ssize_t addr_range_size_show(struct device *ras_feat_dev,
>> +				    struct device_attribute *attr,
>> +				    char *buf)
>> +{
>> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
>> +	u64 base, size;
>> +	int ret;
>> +
>> +	ret =3D ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &bas=
e,
>&size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "0x%llx\n", size); }
>> +
>> +static ssize_t addr_range_base_store(struct device *ras_feat_dev,
>> +				     struct device_attribute *attr,
>> +				     const char *buf, size_t len) {
>> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
>> +	u64 base, size;
>> +	int ret;
>> +
>> +	ret =3D ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &bas=
e,
>&size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D kstrtou64(buf, 16, &base);
>
>I would use base 0, letting the parser expect "0x" for hexadecimal values.
>Same for other *_store methods.
Will check.

>
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D ops->write_range(ras_feat_dev->parent, ctx->scrub.private, bas=
e,
>size);
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
>> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
>> +	u64 base, size;
>> +	int ret;
>> +
>> +	ret =3D ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &bas=
e,
>&size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D kstrtou64(buf, 16, &size);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D ops->write_range(ras_feat_dev->parent, ctx->scrub.private, bas=
e,
>size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return len;
>> +}
>> +
>> +static ssize_t enable_background_store(struct device *ras_feat_dev,
>> +				       struct device_attribute *attr,
>> +				       const char *buf, size_t len) {
>> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
>> +	bool enable;
>> +	int ret;
>> +
>> +	ret =3D kstrtobool(buf, &enable);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D ops->set_enabled_bg(ras_feat_dev->parent, ctx->scrub.private,
>enable);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return len;
>> +}
>> +
>> +static ssize_t enable_background_show(struct device *ras_feat_dev,
>> +				      struct device_attribute *attr, char *buf) {
>> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
>> +	bool enable;
>> +	int ret;
>> +
>> +	ret =3D ops->get_enabled_bg(ras_feat_dev->parent, ctx->scrub.private,
>&enable);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "%d\n", enable); }
>> +
>> +static ssize_t enable_on_demand_show(struct device *ras_feat_dev,
>> +				     struct device_attribute *attr, char *buf) {
>> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
>> +	bool enable;
>> +	int ret;
>> +
>> +	ret =3D ops->get_enabled_od(ras_feat_dev->parent, ctx->scrub.private,
>&enable);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "%d\n", enable); }
>> +
>> +static ssize_t enable_on_demand_store(struct device *ras_feat_dev,
>> +				      struct device_attribute *attr,
>> +				      const char *buf, size_t len) {
>> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
>> +	bool enable;
>> +	int ret;
>> +
>> +	ret =3D kstrtobool(buf, &enable);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D ops->set_enabled_od(ras_feat_dev->parent, ctx->scrub.private,
>enable);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return len;
>> +}
>> +
>> +static ssize_t name_show(struct device *ras_feat_dev,
>> +			 struct device_attribute *attr, char *buf) {
>> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
>> +	int ret;
>> +
>> +	ret =3D ops->get_name(ras_feat_dev->parent, ctx->scrub.private, buf);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return strlen(buf);
>> +}
>> +
>> +static ssize_t cycle_in_hours_show(struct device *ras_feat_dev, struct
>device_attribute *attr,
>> +				   char *buf)
>> +{
>> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
>> +	u64 val;
>> +	int ret;
>> +
>> +	ret =3D ops->cycle_in_hours_read(ras_feat_dev->parent, ctx-
>>scrub.private, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "0x%llx\n", val); }
>> +
>> +static ssize_t cycle_in_hours_store(struct device *ras_feat_dev, struct
>device_attribute *attr,
>> +				    const char *buf, size_t len)
>> +{
>> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
>> +	long val;
>> +	int ret;
>> +
>> +	ret =3D kstrtol(buf, 10, &val);
>
>Even here, I would be using base=3D0, but if you only want to support base=
 10,
>please document it at the sysfs ABI.
Will do.
>
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D ops->cycle_in_hours_write(ras_feat_dev->parent, ctx-
>>scrub.private, val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return len;
>> +}
>> +
>> +static ssize_t cycle_in_hours_range_show(struct device *ras_feat_dev,
>> +					 struct device_attribute *attr,
>> +					 char *buf)
>> +{
>> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
>> +	u64 min_schrs, max_schrs;
>> +	int ret;
>> +
>> +	ret =3D ops->cycle_in_hours_range(ras_feat_dev->parent, ctx-
>>scrub.private,
>> +					&min_schrs, &max_schrs);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "0x%llx-0x%llx\n", min_schrs, max_schrs);
>
>Hmm... you added the store in decimal, but here you're showing in hexa...
Will check for store and show decimal.
>
>Btw, don't group multiple values on a single sysfs node. Instead, implemen=
t two
>separate devnodes:
Here we are showing the supported range for the scrub cycle.=20
I am wondering any opinion on this from others?
>
>	min-scrub-cycle
>	max-scrub-cycle
>
>(see the note above about "hours")
>
>
>> +}
>> +
>> +static DEVICE_ATTR_RW(addr_range_base); static
>> +DEVICE_ATTR_RW(addr_range_size); static
>> +DEVICE_ATTR_RW(enable_background);
>> +static DEVICE_ATTR_RW(enable_on_demand); static
>DEVICE_ATTR_RO(name);
>> +static DEVICE_ATTR_RW(cycle_in_hours); static
>> +DEVICE_ATTR_RO(cycle_in_hours_range);
>> +
>> +static struct attribute *scrub_attrs[] =3D {
>> +	&dev_attr_addr_range_base.attr,
>> +	&dev_attr_addr_range_size.attr,
>> +	&dev_attr_enable_background.attr,
>> +	&dev_attr_enable_on_demand.attr,
>> +	&dev_attr_name.attr,
>> +	&dev_attr_cycle_in_hours.attr,
>> +	&dev_attr_cycle_in_hours_range.attr,
>> +	NULL
>> +};
>> +
>> +static umode_t scrub_attr_visible(struct kobject *kobj,
>> +				  struct attribute *a, int attr_id) {
>> +	struct device *ras_feat_dev =3D kobj_to_dev(kobj);
>> +	struct edac_ras_feat_ctx *ctx;
>> +	const struct edac_scrub_ops *ops;
>> +
>> +	ctx =3D dev_get_drvdata(ras_feat_dev);
>> +	if (!ctx)
>> +		return 0;
>> +
>> +	ops =3D ctx->scrub.ops;
>> +	if (a =3D=3D &dev_attr_addr_range_base.attr ||
>> +	    a =3D=3D &dev_attr_addr_range_size.attr) {
>> +		if (ops->read_range && ops->write_range)
>> +			return a->mode;
>> +		if (ops->read_range)
>> +			return 0444;
>> +		return 0;
>> +	}
>> +	if (a =3D=3D &dev_attr_enable_background.attr) {
>> +		if (ops->set_enabled_bg && ops->get_enabled_bg)
>> +			return a->mode;
>> +		if (ops->get_enabled_bg)
>> +			return 0444;
>> +		return 0;
>> +	}
>> +	if (a =3D=3D &dev_attr_enable_on_demand.attr) {
>> +		if (ops->set_enabled_od && ops->get_enabled_od)
>> +			return a->mode;
>> +		if (ops->get_enabled_od)
>> +			return 0444;
>> +		return 0;
>> +	}
>> +	if (a =3D=3D &dev_attr_name.attr)
>> +		return ops->get_name ? a->mode : 0;
>> +	if (a =3D=3D &dev_attr_cycle_in_hours_range.attr)
>> +		return ops->cycle_in_hours_range ? a->mode : 0;
>> +	if (a =3D=3D &dev_attr_cycle_in_hours.attr) { /* Write only makes litt=
le sense
>*/
>> +		if (ops->cycle_in_hours_read && ops->cycle_in_hours_write)
>> +			return a->mode;
>> +		if (ops->cycle_in_hours_read)
>> +			return 0444;
>> +		return 0;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct attribute_group scrub_attr_group =3D {
>> +	.name		=3D "scrub",
>> +	.attrs		=3D scrub_attrs,
>> +	.is_visible	=3D scrub_attr_visible,
>> +};
>> +
>> +/**
>> + * edac_scrub_get_desc - get edac scrub's attr descriptor
>> + *
>> + * Returns attribute_group for the scrub feature.
>> + */
>> +const struct attribute_group *edac_scrub_get_desc(void) {
>> +	return &scrub_attr_group;
>> +}
>> diff --git a/include/linux/edac_ras_feature.h
>> b/include/linux/edac_ras_feature.h
>> index 000e99141023..462f9ecbf9d4 100755
>> --- a/include/linux/edac_ras_feature.h
>> +++ b/include/linux/edac_ras_feature.h
>> @@ -19,6 +19,34 @@ enum edac_ras_feat {
>>  	ras_feat_max
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
>> + * @cycle_in_hours_range: retrieve limits on supported cycle in hours.
>> + * @cycle_in_hours_read: read the scrub cycle in hours.
>> + * @cycle_in_hours_write: set the scrub cycle in hours.
>> + * @get_name: get the memory scrubber's name.
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
>> +	int (*cycle_in_hours_range)(struct device *dev, void *drv_data,  u64
>*min, u64 *max);
>> +	int (*cycle_in_hours_read)(struct device *dev, void *drv_data, u64
>*schrs);
>> +	int (*cycle_in_hours_write)(struct device *dev, void *drv_data, u64
>schrs);
>> +	int (*get_name)(struct device *dev, void *drv_data, char *buf); };
>> +
>> +const struct attribute_group *edac_scrub_get_desc(void);
>> +
>>  struct edac_ecs_ex_info {
>>  	u16 num_media_frus;
>>  };
>
>
>
>Thanks,
>Mauro

Thanks,
Shiju


