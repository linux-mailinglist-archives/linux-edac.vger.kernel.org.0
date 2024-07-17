Return-Path: <linux-edac+bounces-1535-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76487933D3F
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 14:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035AA1F24CBC
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D61E1802A3;
	Wed, 17 Jul 2024 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkufV36d"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C70838DC3;
	Wed, 17 Jul 2024 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721221004; cv=none; b=NJFTmPW/jufO5a+oyytW4Wq8TxmhCgdKDVdRqY7TEn+eD3Rdm61COx52G8Xi//csXGdiF6xQq82BodKdVfCCKk9ryhVAKL2SgD3HiHk8cizOLHQ0pUlrBI5xX/EsuNCXgY80kAYJVbjRXVPFPUAGm9hLdwkU865aiqnu/9MDZWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721221004; c=relaxed/simple;
	bh=zYQo7AQaEwgc+0r5WuoL1ye/X/iUVozRnPfwI3dPSO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OA97dZs7o3wuRnQgVbYXct2UeNLSUqQIWVz3+Wcc4Tg8/tANBwtGrsvVySHqdrF9UdE8h3yOUpqZBVD/APGfr6H1P6Ze+QN1EKCTf+6a+UCMmkD3ddiWMPq1iAXCczMQZKi8mxYDsi4Tifp98ElKU/yN68lSYTIayWFO38xpSgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkufV36d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC65C4AF0E;
	Wed, 17 Jul 2024 12:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721221003;
	bh=zYQo7AQaEwgc+0r5WuoL1ye/X/iUVozRnPfwI3dPSO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WkufV36d/dVTitelzXNk8NpZ81zyOALED3zod9r/vMkUYHxiYbtFCAZYesZL+Tiud
	 fK/kRQCNVypsRXvYccjgSG9EExc1d6F8gafFkJuS9IeVex79DhWqaakKaGKUuxaUiW
	 Ti0X9bEpb68NhbgxnEtRDAruDY53kczcsv9K4dn8AgkIYZ9hz4jmqytiN37ohxhfzy
	 mcBpS8NhuUsIRdXmtcU4quKyZB7+sDEuzAGzc28xmmWPF0WbvCO2sxpBztvTsqAScy
	 x8hnSkyrdqYeEiPjmUMnK/ML9G4DyJTVHpOBWYdfd2nEvp43G/FjVA+QXZvIfkKUMy
	 Cq2veskptN8QQ==
Date: Wed, 17 Jul 2024 14:56:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: <shiju.jose@huawei.com>
Cc: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
 <rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
 <dan.j.williams@intel.com>, <dave@stgolabs.net>,
 <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
 <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
 <ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
 <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
 <jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
 <naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
 <somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
 <duenwen@google.com>, <mike.malvestuto@intel.com>, <gthelen@google.com>,
 <wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
 <wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>,
 <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
 <roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
 <wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v9 02/11] EDAC: Add EDAC scrub control driver
Message-ID: <20240717145632.436a0cb0@foz.lan>
In-Reply-To: <20240716150336.2042-3-shiju.jose@huawei.com>
References: <20240716150336.2042-1-shiju.jose@huawei.com>
	<20240716150336.2042-3-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Tue, 16 Jul 2024 16:03:26 +0100
<shiju.jose@huawei.com> escreveu:

> From: Shiju Jose <shiju.jose@huawei.com>
>=20
> Add generic EDAC scrub control driver supports configuring the memory scr=
ubbers
> in the system. The device with scrub feature, get the scrub descriptor fr=
om the
> EDAC scrub and registers with the EDAC RAS feature driver, which adds the=
 sysfs
> scrub control interface. The scrub control attributes are available to the
> userspace in /sys/bus/edac/devices/<dev-name>/scrub/.
>=20
> Generic EDAC scrub driver and the common sysfs scrub interface promotes
> unambiguous access from the userspace irrespective of the underlying scrub
> devices.
>=20
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-edac-scrub |  64 +++++
>  drivers/edac/Makefile                      |   2 +-
>  drivers/edac/edac_ras_feature.c            |   1 +
>  drivers/edac/edac_scrub.c                  | 312 +++++++++++++++++++++
>  include/linux/edac_ras_feature.h           |  28 ++
>  5 files changed, 406 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-edac-scrub
>  create mode 100755 drivers/edac/edac_scrub.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-edac-scrub b/Documentation/A=
BI/testing/sysfs-edac-scrub
> new file mode 100644
> index 000000000000..dd19afd5e165
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-edac-scrub
> @@ -0,0 +1,64 @@
> +What:		/sys/bus/edac/devices/<dev-name>/scrub
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		The sysfs edac bus devices /<dev-name>/scrub subdirectory
> +		belongs to the memory scrub control feature, where <dev-name>
> +		directory corresponds to a device/memory region registered
> +		with the edac scrub driver and thus registered with the
> +		generic edac ras driver too.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrub/addr_range_base
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The base of the address range of the memory region
> +		to be scrubbed (on-demand scrubbing).
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrub/addr_range_size
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The size of the address range of the memory region
> +		to be scrubbed (on-demand scrubbing).
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrub/enable_background
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Start/Stop background(patrol) scrubbing if supported.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrub/enable_on_demand
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Start/Stop on-demand scrubbing the memory region
> +		if supported.

This is a generic comment for all sysfs calls: what happens if not
supported?

There are a couple of ways to implement it, like:

1. Don't create the attribute;
2. return an error code (-ENOENT? -EINVAL?) if trying to read or
   write to the devnode - please detail the used error code(s);

In any case, please define the behavior and document it.

=46rom what I see, you're setting 0x444 on RW nodes when write
is not enabled, but still it is possible to not have RO
supported. This is specially true as technology evolves, as
memory controllers and different types of memories may have
very different ways to control it[1].

[1] If you're curious enough, one legacy example of memories
    implemented on a very different way was Fully Buffered DIMMs
    where each DIMM had its own internal chipset to offload
    certain tasks, including scrubbing and ECC implementation.
    It ended not being succeeded long term, as it required
    special DIMMs for server's market, reducing the production
    scale, but it is an interesting example about how hardware
    designs could be innovative breaking existing paradigms.
    The FB-DIMM design actually forced a redesign at the EDAC
    subsystem, as it was too centered on how an specific type
    of memory controllers.

> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrub/name
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) name of the memory scrubber
> +


> +What:		/sys/bus/edac/devices/<dev-name>/scrub/cycle_in_hours_available
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) Supported range for the scrub cycle in hours by the
> +		memory scrubber.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrub/cycle_in_hours
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The scrub cycle in hours specified and it must be with in the
> +		supported range by the memory scrubber.

Why specifying it in hours? I would use seconds, as it is easy to
represent one hour as 3600 seconds, but you can't specify a cycle of,
let's say, 30min, if the minimum range value is one hour.

I mean, we never know how technology will evolve nor how manufacturers will
implement support for scrubbing cycle on their chipsets.

> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index c532b57a6d8a..de56cbd039eb 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_EDAC)			:=3D edac_core.o
> =20
>  edac_core-y	:=3D edac_mc.o edac_device.o edac_mc_sysfs.o
>  edac_core-y	+=3D edac_module.o edac_device_sysfs.o wq.o
> -edac_core-y	+=3D edac_ras_feature.o
> +edac_core-y	+=3D edac_ras_feature.o edac_scrub.o
> =20
>  edac_core-$(CONFIG_EDAC_DEBUG)		+=3D debugfs.o
> =20
> diff --git a/drivers/edac/edac_ras_feature.c b/drivers/edac/edac_ras_feat=
ure.c
> index 24a729fea66f..48927f868372 100755
> --- a/drivers/edac/edac_ras_feature.c
> +++ b/drivers/edac/edac_ras_feature.c
> @@ -36,6 +36,7 @@ static int edac_ras_feat_scrub_init(struct device *pare=
nt,
>  {
>  	sdata->ops =3D sfeat->scrub_ops;
>  	sdata->private =3D sfeat->scrub_ctx;
> +	attr_groups[0] =3D edac_scrub_get_desc();
> =20
>  	return 1;
>  }
> diff --git a/drivers/edac/edac_scrub.c b/drivers/edac/edac_scrub.c
> new file mode 100755
> index 000000000000..0b07eafd3551
> --- /dev/null
> +++ b/drivers/edac/edac_scrub.c
> @@ -0,0 +1,312 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic EDAC scrub driver supports controlling the memory
> + * scrubbers in the system and the common sysfs scrub interface
> + * promotes unambiguous access from the userspace.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + */
> +
> +#define pr_fmt(fmt)     "EDAC SCRUB: " fmt
> +
> +#include <linux/edac_ras_feature.h>
> +
> +static ssize_t addr_range_base_show(struct device *ras_feat_dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> +	u64 base, size;
> +	int ret;
> +
> +	ret =3D ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &base=
, &size);
> +	if (ret)
> +		return ret;

Also a generic comment applied to all devnodes: what if ops->read_range
is NULL? Shouldn't it be checked? Btw, you could use read_range =3D=3D NULL=
=20
if to implement error handling for unsupported features.

> +
> +	return sysfs_emit(buf, "0x%llx\n", base);
> +}
> +
> +static ssize_t addr_range_size_show(struct device *ras_feat_dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> +	u64 base, size;
> +	int ret;
> +
> +	ret =3D ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &base=
, &size);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%llx\n", size);
> +}
> +
> +static ssize_t addr_range_base_store(struct device *ras_feat_dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> +	u64 base, size;
> +	int ret;
> +
> +	ret =3D ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &base=
, &size);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D kstrtou64(buf, 16, &base);

I would use base 0, letting the parser expect "0x" for hexadecimal values.
Same for other *_store methods.

> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ops->write_range(ras_feat_dev->parent, ctx->scrub.private, base=
, size);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t addr_range_size_store(struct device *ras_feat_dev,
> +				     struct device_attribute *attr,
> +				     const char *buf,
> +				     size_t len)
> +{
> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> +	u64 base, size;
> +	int ret;
> +
> +	ret =3D ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &base=
, &size);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D kstrtou64(buf, 16, &size);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ops->write_range(ras_feat_dev->parent, ctx->scrub.private, base=
, size);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t enable_background_store(struct device *ras_feat_dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> +	bool enable;
> +	int ret;
> +
> +	ret =3D kstrtobool(buf, &enable);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ops->set_enabled_bg(ras_feat_dev->parent, ctx->scrub.private, e=
nable);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t enable_background_show(struct device *ras_feat_dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> +	bool enable;
> +	int ret;
> +
> +	ret =3D ops->get_enabled_bg(ras_feat_dev->parent, ctx->scrub.private, &=
enable);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", enable);
> +}
> +
> +static ssize_t enable_on_demand_show(struct device *ras_feat_dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> +	bool enable;
> +	int ret;
> +
> +	ret =3D ops->get_enabled_od(ras_feat_dev->parent, ctx->scrub.private, &=
enable);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", enable);
> +}
> +
> +static ssize_t enable_on_demand_store(struct device *ras_feat_dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> +	bool enable;
> +	int ret;
> +
> +	ret =3D kstrtobool(buf, &enable);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ops->set_enabled_od(ras_feat_dev->parent, ctx->scrub.private, e=
nable);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t name_show(struct device *ras_feat_dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> +	int ret;
> +
> +	ret =3D ops->get_name(ras_feat_dev->parent, ctx->scrub.private, buf);
> +	if (ret)
> +		return ret;
> +
> +	return strlen(buf);
> +}
> +
> +static ssize_t cycle_in_hours_show(struct device *ras_feat_dev, struct d=
evice_attribute *attr,
> +				   char *buf)
> +{
> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> +	u64 val;
> +	int ret;
> +
> +	ret =3D ops->cycle_in_hours_read(ras_feat_dev->parent, ctx->scrub.priva=
te, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%llx\n", val);
> +}
> +
> +static ssize_t cycle_in_hours_store(struct device *ras_feat_dev, struct =
device_attribute *attr,
> +				    const char *buf, size_t len)
> +{
> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> +	long val;
> +	int ret;
> +
> +	ret =3D kstrtol(buf, 10, &val);

Even here, I would be using base=3D0, but if you only want to support base
10, please document it at the sysfs ABI.

> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ops->cycle_in_hours_write(ras_feat_dev->parent, ctx->scrub.priv=
ate, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t cycle_in_hours_range_show(struct device *ras_feat_dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> +	u64 min_schrs, max_schrs;
> +	int ret;
> +
> +	ret =3D ops->cycle_in_hours_range(ras_feat_dev->parent, ctx->scrub.priv=
ate,
> +					&min_schrs, &max_schrs);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%llx-0x%llx\n", min_schrs, max_schrs);

Hmm... you added the store in decimal, but here you're showing in
hexa...=20

Btw, don't group multiple values on a single sysfs node. Instead,=20
implement two separate devnodes:

	min-scrub-cycle
	max-scrub-cycle

(see the note above about "hours")


> +}
> +
> +static DEVICE_ATTR_RW(addr_range_base);
> +static DEVICE_ATTR_RW(addr_range_size);
> +static DEVICE_ATTR_RW(enable_background);
> +static DEVICE_ATTR_RW(enable_on_demand);
> +static DEVICE_ATTR_RO(name);
> +static DEVICE_ATTR_RW(cycle_in_hours);
> +static DEVICE_ATTR_RO(cycle_in_hours_range);
> +
> +static struct attribute *scrub_attrs[] =3D {
> +	&dev_attr_addr_range_base.attr,
> +	&dev_attr_addr_range_size.attr,
> +	&dev_attr_enable_background.attr,
> +	&dev_attr_enable_on_demand.attr,
> +	&dev_attr_name.attr,
> +	&dev_attr_cycle_in_hours.attr,
> +	&dev_attr_cycle_in_hours_range.attr,
> +	NULL
> +};
> +
> +static umode_t scrub_attr_visible(struct kobject *kobj,
> +				  struct attribute *a, int attr_id)
> +{
> +	struct device *ras_feat_dev =3D kobj_to_dev(kobj);
> +	struct edac_ras_feat_ctx *ctx;
> +	const struct edac_scrub_ops *ops;
> +
> +	ctx =3D dev_get_drvdata(ras_feat_dev);
> +	if (!ctx)
> +		return 0;
> +
> +	ops =3D ctx->scrub.ops;
> +	if (a =3D=3D &dev_attr_addr_range_base.attr ||
> +	    a =3D=3D &dev_attr_addr_range_size.attr) {
> +		if (ops->read_range && ops->write_range)
> +			return a->mode;
> +		if (ops->read_range)
> +			return 0444;
> +		return 0;
> +	}
> +	if (a =3D=3D &dev_attr_enable_background.attr) {
> +		if (ops->set_enabled_bg && ops->get_enabled_bg)
> +			return a->mode;
> +		if (ops->get_enabled_bg)
> +			return 0444;
> +		return 0;
> +	}
> +	if (a =3D=3D &dev_attr_enable_on_demand.attr) {
> +		if (ops->set_enabled_od && ops->get_enabled_od)
> +			return a->mode;
> +		if (ops->get_enabled_od)
> +			return 0444;
> +		return 0;
> +	}
> +	if (a =3D=3D &dev_attr_name.attr)
> +		return ops->get_name ? a->mode : 0;
> +	if (a =3D=3D &dev_attr_cycle_in_hours_range.attr)
> +		return ops->cycle_in_hours_range ? a->mode : 0;
> +	if (a =3D=3D &dev_attr_cycle_in_hours.attr) { /* Write only makes littl=
e sense */
> +		if (ops->cycle_in_hours_read && ops->cycle_in_hours_write)
> +			return a->mode;
> +		if (ops->cycle_in_hours_read)
> +			return 0444;
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct attribute_group scrub_attr_group =3D {
> +	.name		=3D "scrub",
> +	.attrs		=3D scrub_attrs,
> +	.is_visible	=3D scrub_attr_visible,
> +};
> +
> +/**
> + * edac_scrub_get_desc - get edac scrub's attr descriptor
> + *
> + * Returns attribute_group for the scrub feature.
> + */
> +const struct attribute_group *edac_scrub_get_desc(void)
> +{
> +	return &scrub_attr_group;
> +}
> diff --git a/include/linux/edac_ras_feature.h b/include/linux/edac_ras_fe=
ature.h
> index 000e99141023..462f9ecbf9d4 100755
> --- a/include/linux/edac_ras_feature.h
> +++ b/include/linux/edac_ras_feature.h
> @@ -19,6 +19,34 @@ enum edac_ras_feat {
>  	ras_feat_max
>  };
> =20
> +/**
> + * struct scrub_ops - scrub device operations (all elements optional)
> + * @read_range: read base and offset of scrubbing range.
> + * @write_range: set the base and offset of the scrubbing range.
> + * @get_enabled_bg: check if currently performing background scrub.
> + * @set_enabled_bg: start or stop a bg-scrub.
> + * @get_enabled_od: check if currently performing on-demand scrub.
> + * @set_enabled_od: start or stop an on-demand scrub.
> + * @cycle_in_hours_range: retrieve limits on supported cycle in hours.
> + * @cycle_in_hours_read: read the scrub cycle in hours.
> + * @cycle_in_hours_write: set the scrub cycle in hours.
> + * @get_name: get the memory scrubber's name.
> + */
> +struct edac_scrub_ops {
> +	int (*read_range)(struct device *dev, void *drv_data, u64 *base, u64 *s=
ize);
> +	int (*write_range)(struct device *dev, void *drv_data, u64 base, u64 si=
ze);
> +	int (*get_enabled_bg)(struct device *dev, void *drv_data, bool *enable);
> +	int (*set_enabled_bg)(struct device *dev, void *drv_data, bool enable);
> +	int (*get_enabled_od)(struct device *dev, void *drv_data, bool *enable);
> +	int (*set_enabled_od)(struct device *dev, void *drv_data, bool enable);
> +	int (*cycle_in_hours_range)(struct device *dev, void *drv_data,  u64 *m=
in, u64 *max);
> +	int (*cycle_in_hours_read)(struct device *dev, void *drv_data, u64 *sch=
rs);
> +	int (*cycle_in_hours_write)(struct device *dev, void *drv_data, u64 sch=
rs);
> +	int (*get_name)(struct device *dev, void *drv_data, char *buf);
> +};
> +
> +const struct attribute_group *edac_scrub_get_desc(void);
> +
>  struct edac_ecs_ex_info {
>  	u16 num_media_frus;
>  };



Thanks,
Mauro

