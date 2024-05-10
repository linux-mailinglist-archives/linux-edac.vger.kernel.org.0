Return-Path: <linux-edac+bounces-1032-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A4B8C2029
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 11:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B909B281BCF
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 09:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C674161306;
	Fri, 10 May 2024 09:03:19 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3461607A3;
	Fri, 10 May 2024 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715331799; cv=none; b=uJOC1Buw+H/JVFVrFL+CkTB6Xe67HwgoYjwzsNXzPnWNglAqqeeCZ5vv09SxWgVpRTxzUmzhqfqe7+YXuCuegoNH8tvQG0dXSkhT266j/WCBXKqy4Chve6LAeHZtZMZ2N4Sbj9i2p6Ngu6pGmh7Sgi/jRDDSElIgMA9aDgvKAAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715331799; c=relaxed/simple;
	bh=glmPpNnjWxfvpn59tClr8Pv6XgRUAHoo+HWFtiSoBv8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmHUeWSvylNOt8z17V6/g9zn/X11laM/nX72fKfK0spASS05PyQaTmPjXN25rXUTeFLIpVHaWymv21BcLHtH1tm53zWBAraN1kizMZQ0t1CoycyoUxH6VGElmNg+WVAVvw9Kg61e80FNyOi81wt6LpUbPper8YvY68lRME3+NDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VbNBB6ypqz6JBH0;
	Fri, 10 May 2024 17:00:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B46771400D4;
	Fri, 10 May 2024 17:03:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 10 May
 2024 10:03:06 +0100
Date: Fri, 10 May 2024 10:03:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <20240510100305.00000a2b@Huawei.com>
In-Reply-To: <663d448c2ef3_1c0a1929453@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
	<20240419164720.1765-2-shiju.jose@huawei.com>
	<663d448c2ef3_1c0a1929453@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 9 May 2024 14:47:56 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> shiju.jose@ wrote:
> > From: Shiju Jose <shiju.jose@huawei.com>
> >=20
> > Add scrub subsystem supports configuring the memory scrubbers
> > in the system. The scrub subsystem provides the interface for
> > registering the scrub devices. The scrub control attributes
> > are provided to the user in /sys/class/ras/rasX/scrub
> >=20
> > Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > ---
> >  .../ABI/testing/sysfs-class-scrub-configure   |  47 +++
> >  drivers/ras/Kconfig                           |   7 +
> >  drivers/ras/Makefile                          |   1 +
> >  drivers/ras/memory_scrub.c                    | 271 ++++++++++++++++++
> >  include/linux/memory_scrub.h                  |  37 +++
> >  5 files changed, 363 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configu=
re
> >  create mode 100755 drivers/ras/memory_scrub.c
> >  create mode 100755 include/linux/memory_scrub.h
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-class-scrub-configure b/Do=
cumentation/ABI/testing/sysfs-class-scrub-configure
> > new file mode 100644
> > index 000000000000..3ed77dbb00ad
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-scrub-configure
> > @@ -0,0 +1,47 @@
> > +What:		/sys/class/ras/
> > +Date:		March 2024
> > +KernelVersion:	6.9
> > +Contact:	linux-kernel@vger.kernel.org
> > +Description:
> > +		The ras/ class subdirectory belongs to the
> > +		common ras features such as scrub subsystem.=20

Hi Dan,
=20
>=20
> Why create "ras" class versus just a "srcub" class? I am otherwise not
> aware of a precedent for class device hierarchy. For example, on my
> system there is:

I think that's miss described - aim is on subsystem, the first feature
supported is scrub.  Intent here is to group RAS features of a given
device / interface etc into one place. This was a request in an review
of an earlier version on basis these interfaces tend to get grouped together
in a device.
So options are

/sys/class/ras/cxl_mem0/scrub/rate etc.
/sys/class/ras/cxl_mem0/ecs/rate etc
(maybe separate for ECS because it annoyingly looks nothing like scrub desp=
ite name
 and there are multiple impelmentations)

vs
/sys/class/ras/cxl_mem0_scrub
/sys/class/ras/cxl_mem0_ecs
etc
Note that generic naming not including what the source was got
negative reviews in favor of making that the device instance name here.
So that rulled out simply
/sys/class/ras/scrubX/
/sys/class/ras/ecsX/

I don't mind which way we go; both are extensible.

>=20
> /sys/class/
> =E2=94=9C=E2=94=80=E2=94=80 scsi_device
> =E2=94=9C=E2=94=80=E2=94=80 scsi_disk
> =E2=94=9C=E2=94=80=E2=94=80 scsi_generic
> =E2=94=94=E2=94=80=E2=94=80 scsi_host
>=20
> ...not:
>=20
> /sys/class/scsi/
> =E2=94=9C=E2=94=80=E2=94=80 device
> =E2=94=9C=E2=94=80=E2=94=80 disk
> =E2=94=9C=E2=94=80=E2=94=80 generic
> =E2=94=94=E2=94=80=E2=94=80 host

That's a docs problem - this was never the intent.

>=20
>=20
> > +
> > +What:		/sys/class/ras/rasX/scrub/
> > +Date:		March 2024
> > +KernelVersion:	6.9
> > +Contact:	linux-kernel@vger.kernel.org
> > +Description:
> > +		The /sys/class/ras/ras{0,1,2,3,...}/scrub directories
> > +		correspond to each scrub device registered with the
> > +		scrub subsystem. =20
>=20
> I notice there are some visibility rules in the code, but those
> expectations are not documented here.
>=20
> This documentation would also help developers writing new users of
> scrub_device_register().
Agreed. One to improve.

>=20
> > +
> > +What:		/sys/class/ras/rasX/scrub/name
> > +Date:		March 2024
> > +KernelVersion:	6.9
> > +Contact:	linux-kernel@vger.kernel.org
> > +Description:
> > +		(RO) name of the memory scrubber
> > +
> > +What:		/sys/class/ras/rasX/scrub/enable_background
> > +Date:		March 2024
> > +KernelVersion:	6.9
> > +Contact:	linux-kernel@vger.kernel.org
> > +Description:
> > +		(RW) Enable/Disable background(patrol) scrubbing if supported.
> > +
> > +What:		/sys/class/ras/rasX/scrub/rate_available
> > +Date:		March 2024
> > +KernelVersion:	6.9
> > +Contact:	linux-kernel@vger.kernel.org
> > +Description:
> > +		(RO) Supported range for the scrub rate by the scrubber.
> > +		The scrub rate represents in hours.
> > +
> > +What:		/sys/class/ras/rasX/scrub/rate
> > +Date:		March 2024
> > +KernelVersion:	6.9
> > +Contact:	linux-kernel@vger.kernel.org
> > +Description:
> > +		(RW) The scrub rate specified and it must be with in the
> > +		supported range by the scrubber.
> > +		The scrub rate represents in hours.
> > diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
> > index fc4f4bb94a4c..181701479564 100644
> > --- a/drivers/ras/Kconfig
> > +++ b/drivers/ras/Kconfig
> > @@ -46,4 +46,11 @@ config RAS_FMPM
> >  	  Memory will be retired during boot time and run time depending on
> >  	  platform-specific policies.
> > =20
> > +config SCRUB
> > +	tristate "Memory scrub driver"
> > +	help
> > +	  This option selects the memory scrub subsystem, supports
> > +	  configuring the parameters of underlying scrubbers in the
> > +	  system for the DRAM memories.
> > +
> >  endif
> > diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
> > index 11f95d59d397..89bcf0d84355 100644
> > --- a/drivers/ras/Makefile
> > +++ b/drivers/ras/Makefile
> > @@ -2,6 +2,7 @@
> >  obj-$(CONFIG_RAS)	+=3D ras.o
> >  obj-$(CONFIG_DEBUG_FS)	+=3D debugfs.o
> >  obj-$(CONFIG_RAS_CEC)	+=3D cec.o
> > +obj-$(CONFIG_SCRUB)	+=3D memory_scrub.o
> > =20
> >  obj-$(CONFIG_RAS_FMPM)	+=3D amd/fmpm.o
> >  obj-y			+=3D amd/atl/
> > diff --git a/drivers/ras/memory_scrub.c b/drivers/ras/memory_scrub.c
> > new file mode 100755
> > index 000000000000..7e995380ec3a
> > --- /dev/null
> > +++ b/drivers/ras/memory_scrub.c
> > @@ -0,0 +1,271 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Memory scrub subsystem supports configuring the registered
> > + * memory scrubbers.
> > + *
> > + * Copyright (c) 2024 HiSilicon Limited.
> > + */
> > +
> > +#define pr_fmt(fmt)     "MEM SCRUB: " fmt
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/kfifo.h>
> > +#include <linux/memory_scrub.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/spinlock.h>
> > +
> > +/* memory scrubber config definitions */
> > +#define SCRUB_ID_PREFIX "ras"
> > +#define SCRUB_ID_FORMAT SCRUB_ID_PREFIX "%d"
> > +
> > +static DEFINE_IDA(scrub_ida);
> > +
> > +struct scrub_device {
> > +	int id;
> > +	struct device dev;
> > +	const struct scrub_ops *ops;
> > +};
> > +
> > +#define to_scrub_device(d) container_of(d, struct scrub_device, dev)
> > +static ssize_t enable_background_store(struct device *dev,
> > +				       struct device_attribute *attr,
> > +				       const char *buf, size_t len)
> > +{
> > +	struct scrub_device *scrub_dev =3D to_scrub_device(dev);
> > +	bool enable;
> > +	int ret;
> > +
> > +	ret =3D kstrtobool(buf, &enable);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D scrub_dev->ops->set_enabled_bg(dev, enable);
> > +	if (ret)
> > +		return ret; =20
>=20
> It strikes me as somewhat pointless to have such a thin sysfs
> implementation whose only job is to call down into a callback to do the
> work. Unless there are other consumers of 'struct scrub_ops' outside of
> these sysfs files why not just have the low-level drivers register their
> corresponding attributes themselves?
>=20
> Unless the functionality is truly generic just let the low-level driver
> be responsible for conforming to the sysfs ABI expectations, and, for
> example, each register their own "enable_background" attribute if they
> support that semantic.

This was me pushing for this based on that approach having been a pain
in subystems I've been involved with in the past. so I'll answer.

Maybe if we think the number of scrub drivers remains very low we can
rely on ABI review. However, it's painful.  Everyone wants to add
their own custom ABI, so every review consists of 'no that is
isn't consistent' reviews.  The callback schemes reduce that considerably.
As someone with their name next to one of the largest sysfs ABIs in the
kernel, maybe I'm projecting my pain points on this one.

Note that this approach has failed for multiple similar simple subsystems
in the past and they have migrated to a (mostly) tighter description for
ABI simply because those constraints are useful.  A fairly recent one
maybe 8 years ago? Was hwmon. There are other advantages that may not
yet apply here (in kernel interfaces are much easier, even if they are
only occasionally used for a given subsystem), but my motivation in=20
pushing Shiju this way was to lock down the userspace interface.

>=20
> So scrub_device_register() would grow a 'const struct attribute_group
> **groups' argument, or something along those lines.

Sure. Shiju had that in an earlier version.  Personally I think it's
an approach that may bite in the long run, but meh, maybe this will
only ever have half a dozen drivers so it might remain manageable.
If not, I love say 'I told you so' :)

Jonathan



