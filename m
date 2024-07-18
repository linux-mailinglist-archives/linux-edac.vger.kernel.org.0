Return-Path: <linux-edac+bounces-1547-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8178C93487B
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 09:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96518282AA6
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 07:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41417347E;
	Thu, 18 Jul 2024 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ahr4qWfS"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363CA8488;
	Thu, 18 Jul 2024 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721286231; cv=none; b=vDg2/CnL1KoleZCupMrn4hmTwjZxc+IXOsgLgHy5BG69Zk2Bu4ngBA0XAi3y0m5EBf7uV+0yJuck53JCicn+mFS3ofE5lwlfK5xjVYfXDWlmu+6Wvm6+eV6wJBdc0VJPRfNg44UVVW0r/sDR6So1Sd0gX1cw2mOvX8VYMo5t8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721286231; c=relaxed/simple;
	bh=kWPKzz3p73xr0LfUMEvbu383QRqZBQhsyF6zqshu1LY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tb/QG9oOV8jhhqg9OKNE9twzN8EfBXdRUzGnlZ+ukUeOfZ61sSMXxVAuxlD9pUidsVdT8X9cp618TTGOst1VVvFnI5SwOE+Dp31SouGDE5O2i7poP0JMM03dizVGvoJoNvxNNTBU4ueo4g8B8IgsqD5CH989rzHw1DOU6yoxOKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ahr4qWfS; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a79f9a72a99so292979966b.0;
        Thu, 18 Jul 2024 00:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721286227; x=1721891027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hge8610M0WbBaD4FfYHWgFbqCZWbS2MKcPSo7d+K8eI=;
        b=Ahr4qWfSdhyHGiERUeeO6trQUbSZj0GM3NiRBd30qUVFgpnNIcknaXomYyvGl9jXgJ
         O/aiIlPtbZS28T1kvFU+pr/L57ixw7mdv07p38jdh+nBSfqXr1Hbl3mtc1sXc6iQV+B3
         UDw8UvrcbV36cTMyTHXjmqMoEzqiNbEScd8fhx3cwwomH24s5R30rH9h+GgMi8Ku8ylu
         jt1bCaZXH43/oC9xeWMEwCb+8A39J65vKRb5sgzMP1Dy1FW/rTiFGVB3mWoFqHTu94Ds
         n7NW4dQXDQJYKyX32KX+4Ff0MyWeci+i90E01zzCEaLO88oP934NRzLGYfHiZBynN/jm
         WQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721286227; x=1721891027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hge8610M0WbBaD4FfYHWgFbqCZWbS2MKcPSo7d+K8eI=;
        b=Vkx+tX3ayqO/toMqIDW+Hb9dJLoCN1zMomoz8xGocTPEZM/GeRpCfAtL4OTIjeNlqf
         ueVmJ/6BW3SZRfCUMzIqZ+XzmUwZuTdvXpf26+skSt3V5QDr21DgvoFpXpNLHLaCarGs
         vP/LoJiskfBgyMlrOJ8Sp7QucyWCKI1eEdyb44tEKjL7nwkEpbKhB/s2dHKKb18ygf6P
         RbpdJs0oDQMi+0krPf1SBZ6gdPTOdYNpSxD+EueYA3URpoXDS2fiiznZkLApCDpepBu/
         ZwFcmL/42ewx0XKieaZKg/2B5PbhtxLyaZlBf/auNxbi+gF8NlDaeRrKELH3sv6bAHNn
         a0lg==
X-Forwarded-Encrypted: i=1; AJvYcCXXl5UNRmBZxGtOI6Tyrju9t4fh0xC7IScZurd+15cEy4ChkaDgiHll2Zwh6WkMkyKTVN3xyP39auDYoNasTL3NdMrsoHvhvlloXG096UgDuH8YW5E1apEHbfZYMeJMPlAklPLJwBRdPz+2J+vacxrGNJ0XrpSdEe/mvdPr371gx99V+A==
X-Gm-Message-State: AOJu0YxY42z0MkoTgcoRynqHgkru5DNXfUe0sFxe5MCr1aigJIzmN7gi
	E4xprrciru+Z0syKU6ZPor4CT7hfKh0tmvbymz7eZJ/UULcmxMFA
X-Google-Smtp-Source: AGHT+IEx3FN7buZRlIsdV7Gfu6sBaYYKtZaNP4w4Cn6eWsMfJ3ZPKSH42QYSXA/oliyxDCj9gu0y1A==
X-Received: by 2002:a17:906:aed3:b0:a6f:dd93:7ffb with SMTP id a640c23a62f3a-a7a0f0c6cdbmr190265766b.1.1721286226999;
        Thu, 18 Jul 2024 00:03:46 -0700 (PDT)
Received: from foz.lan ([178.24.78.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f21afsm520734166b.119.2024.07.18.00.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 00:03:46 -0700 (PDT)
Date: Thu, 18 Jul 2024 09:03:44 +0200
From: Mauro Carvalho Chehab <maurochehab@gmail.com>
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
Subject: Re: [RFC PATCH v9 02/11] EDAC: Add EDAC scrub control driver
Message-ID: <20240718090344.00050815@foz.lan>
In-Reply-To: <ff37e3dd6f804964b7d15d1f917359fb@huawei.com>
References: <20240716150336.2042-1-shiju.jose@huawei.com>
	<20240716150336.2042-3-shiju.jose@huawei.com>
	<20240717145632.436a0cb0@foz.lan>
	<ff37e3dd6f804964b7d15d1f917359fb@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Wed, 17 Jul 2024 14:07:05 +0000
Shiju Jose <shiju.jose@huawei.com> escreveu:

> >-----Original Message-----
> >From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >Sent: 17 July 2024 13:57
> >To: Shiju Jose <shiju.jose@huawei.com>
> >Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
> >acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> >bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
> >mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
> >Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
> >alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.co=
m;
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
> >Subject: Re: [RFC PATCH v9 02/11] EDAC: Add EDAC scrub control driver
> >
> >Em Tue, 16 Jul 2024 16:03:26 +0100
> ><shiju.jose@huawei.com> escreveu:
> > =20
> >> From: Shiju Jose <shiju.jose@huawei.com>
> >>
> >> Add generic EDAC scrub control driver supports configuring the memory
> >> scrubbers in the system. The device with scrub feature, get the scrub
> >> descriptor from the EDAC scrub and registers with the EDAC RAS feature
> >> driver, which adds the sysfs scrub control interface. The scrub
> >> control attributes are available to the userspace in =20
> >/sys/bus/edac/devices/<dev-name>/scrub/. =20
> >>
> >> Generic EDAC scrub driver and the common sysfs scrub interface
> >> promotes unambiguous access from the userspace irrespective of the
> >> underlying scrub devices.
> >>
> >> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> >> ---
> >>  Documentation/ABI/testing/sysfs-edac-scrub |  64 +++++
> >>  drivers/edac/Makefile                      |   2 +-
> >>  drivers/edac/edac_ras_feature.c            |   1 +
> >>  drivers/edac/edac_scrub.c                  | 312 +++++++++++++++++++++
> >>  include/linux/edac_ras_feature.h           |  28 ++
> >>  5 files changed, 406 insertions(+), 1 deletion(-)  create mode 100644
> >> Documentation/ABI/testing/sysfs-edac-scrub
> >>  create mode 100755 drivers/edac/edac_scrub.c
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-edac-scrub
> >> b/Documentation/ABI/testing/sysfs-edac-scrub
> >> new file mode 100644
> >> index 000000000000..dd19afd5e165
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-edac-scrub
> >> @@ -0,0 +1,64 @@
> >> +What:		/sys/bus/edac/devices/<dev-name>/scrub
> >> +Date:		Oct 2024
> >> +KernelVersion:	6.12
> >> +Contact:	linux-edac@vger.kernel.org
> >> +Description:
> >> +		The sysfs edac bus devices /<dev-name>/scrub subdirectory
> >> +		belongs to the memory scrub control feature, where <dev-
> >name>
> >> +		directory corresponds to a device/memory region registered
> >> +		with the edac scrub driver and thus registered with the
> >> +		generic edac ras driver too.
> >> +
> >> +What:		/sys/bus/edac/devices/<dev-
> >name>/scrub/addr_range_base
> >> +Date:		Oct 2024
> >> +KernelVersion:	6.12
> >> +Contact:	linux-edac@vger.kernel.org
> >> +Description:
> >> +		(RW) The base of the address range of the memory region
> >> +		to be scrubbed (on-demand scrubbing).
> >> +
> >> +What:		/sys/bus/edac/devices/<dev-
> >name>/scrub/addr_range_size
> >> +Date:		Oct 2024
> >> +KernelVersion:	6.12
> >> +Contact:	linux-edac@vger.kernel.org
> >> +Description:
> >> +		(RW) The size of the address range of the memory region
> >> +		to be scrubbed (on-demand scrubbing).
> >> +
> >> +What:		/sys/bus/edac/devices/<dev-
> >name>/scrub/enable_background
> >> +Date:		Oct 2024
> >> +KernelVersion:	6.12
> >> +Contact:	linux-edac@vger.kernel.org
> >> +Description:
> >> +		(RW) Start/Stop background(patrol) scrubbing if supported.
> >> +
> >> +What:		/sys/bus/edac/devices/<dev-
> >name>/scrub/enable_on_demand
> >> +Date:		Oct 2024
> >> +KernelVersion:	6.12
> >> +Contact:	linux-edac@vger.kernel.org
> >> +Description:
> >> +		(RW) Start/Stop on-demand scrubbing the memory region
> >> +		if supported. =20
> >
> >This is a generic comment for all sysfs calls: what happens if not suppo=
rted?
> >
> >There are a couple of ways to implement it, like:
> >
> >1. Don't create the attribute;
> >2. return an error code (-ENOENT? -EINVAL?) if trying to read or
> >   write to the devnode - please detail the used error code(s);
> >
> >In any case, please define the behavior and document it.
> >
> >From what I see, you're setting 0x444 on RW nodes when write is not enab=
led,
> >but still it is possible to not have RO supported. This is specially tru=
e as
> >technology evolves, as memory controllers and different types of memorie=
s may
> >have very different ways to control it[1]. =20
>=20
> It is not true. If the parent device does not support and define callback=
s for both read and write,
> then return 0 as you can see in the scrub_attr_visible() and the attribute
> would not be present for that device in the sysfs.
> For e.g. attributes addr_range_base and addr_range_size does not support =
by CXL patrol
> scrub feature, but supported by ACPI RAS2 scrub feature. =20
> >
> >[1] If you're curious enough, one legacy example of memories
> >    implemented on a very different way was Fully Buffered DIMMs
> >    where each DIMM had its own internal chipset to offload
> >    certain tasks, including scrubbing and ECC implementation.
> >    It ended not being succeeded long term, as it required
> >    special DIMMs for server's market, reducing the production
> >    scale, but it is an interesting example about how hardware
> >    designs could be innovative breaking existing paradigms.
> >    The FB-DIMM design actually forced a redesign at the EDAC
> >    subsystem, as it was too centered on how an specific type
> >    of memory controllers.
> > =20
> >> +
> >> +What:		/sys/bus/edac/devices/<dev-name>/scrub/name
> >> +Date:		Oct 2024
> >> +KernelVersion:	6.12
> >> +Contact:	linux-edac@vger.kernel.org
> >> +Description:
> >> +		(RO) name of the memory scrubber
> >> + =20
> >
> > =20
> >> +What:		/sys/bus/edac/devices/<dev-
> >name>/scrub/cycle_in_hours_available
> >> +Date:		Oct 2024
> >> +KernelVersion:	6.12
> >> +Contact:	linux-edac@vger.kernel.org
> >> +Description:
> >> +		(RO) Supported range for the scrub cycle in hours by the
> >> +		memory scrubber.
> >> +
> >> +What:		/sys/bus/edac/devices/<dev-
> >name>/scrubin_hours
> >> +Date:		Oct 2024
> >> +KernelVersion:	6.12
> >> +Contact:	linux-edac@vger.kernel.org
> >> +Description:
> >> +		(RW) The scrub cycle in hours specified and it must be with in =20
> >the =20
> >> +		supported range by the memory scrubber. =20
> >
> >Why specifying it in hours? I would use seconds, as it is easy to repres=
ent one
> >hour as 3600 seconds, but you can't specify a cycle of, let's say, 30min=
, if the
> >minimum range value is one hour. =20
> For the CXL patrol scrub, scrub cycle defined in hours(CXL spec 3.1 Table=
 8-208. Device Patrol Scrub
> Control Feature Writable Attributes), but ACPI RAS2 does not define the u=
nit for the scrub cycle.
> Thus proposed  represent scrub cycle in hours in common.

I understand that the final goal of this series is to have CXL exported
via sysfs, but this patch is not binding the scrub to CXL. Instead, it
is placing it on a generic location:

	/sys/bus/edac/devices/<dev-name>/scrub

So, it doesn't make sense to bind it to CXL 3.1 spec.

> Not sure how convenient to set the scrub cycle in seconds from the user p=
erspective and

=46rom users perspective, it doesn't make much difference.=20

See, IMO, we should define this as:

	/sys/bus/edac/devices/<dev-name>/scrub/min_cycle_duration
	/sys/bus/edac/devices/<dev-name>/scrub/max_cycle_duration
	/sys/bus/edac/devices/<dev-name>/scrub/current_cycle_duration

See, whatever logic userspace does, it needs to read the contents of
`min_cycle_duration`, choose a value higher than that, and then check=20
if the value is not bigger than `max_cycle_duration`.

Such value will then be written at current_cycle_duration.

The logic inside the Kernel will then convert it into some register
data, rounding it to the closest value to fit the actual memory
controller parameters.

A read from `current_cycle_duration` will than return what it was
actually programmed there.

So, even if the user programs it to, let's say, 4 hours, the actual
content of `current_cycle_duration` could return a number indicating
that the actual cycle is 4 hours, 20 minutes and 30 seconds.

> also is it require to finish the background scrubbing in such short time?

My main concern here is not about the minimal value, but about the minimal
quantity that can be specified/returned.=20

See, if you think on a generic way, It should be possible that some device
would support a scrub cycle lasting 2 hours and 30 minutes, for instance.

I'm also concerned scrubbing and memory refresh times are very dependent of
the memory technologies used to store and retain data at DRAM. From time to
time, we see large shifts on such technologies, affecting by orders of
order of magnitude memory timings including refresh and scrub cycles.

> >I mean, we never know how technology will evolve nor how manufacturers w=
ill
> >implement support for scrubbing cycle on their chipsets.
> > =20
> >> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile index
> >> c532b57a6d8a..de56cbd039eb 100644
> >> --- a/drivers/edac/Makefile
> >> +++ b/drivers/edac/Makefile
> >> @@ -10,7 +10,7 @@ obj-$(CONFIG_EDAC)			:=3D edac_core.o
> >>
> >>  edac_core-y	:=3D edac_mc.o edac_device.o edac_mc_sysfs.o
> >>  edac_core-y	+=3D edac_module.o edac_device_sysfs.o wq.o
> >> -edac_core-y	+=3D edac_ras_feature.o
> >> +edac_core-y	+=3D edac_ras_feature.o edac_scrub.o
> >>
> >>  edac_core-$(CONFIG_EDAC_DEBUG)		+=3D debugfs.o
> >>
> >> diff --git a/drivers/edac/edac_ras_feature.c
> >> b/drivers/edac/edac_ras_feature.c index 24a729fea66f..48927f868372
> >> 100755
> >> --- a/drivers/edac/edac_ras_feature.c
> >> +++ b/drivers/edac/edac_ras_feature.c
> >> @@ -36,6 +36,7 @@ static int edac_ras_feat_scrub_init(struct device
> >> *parent,  {
> >>  	sdata->ops =3D sfeat->scrub_ops;
> >>  	sdata->private =3D sfeat->scrub_ctx;
> >> +	attr_groups[0] =3D edac_scrub_get_desc();
> >>
> >>  	return 1;
> >>  }
> >> diff --git a/drivers/edac/edac_scrub.c b/drivers/edac/edac_scrub.c new
> >> file mode 100755 index 000000000000..0b07eafd3551
> >> --- /dev/null
> >> +++ b/drivers/edac/edac_scrub.c
> >> @@ -0,0 +1,312 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Generic EDAC scrub driver supports controlling the memory
> >> + * scrubbers in the system and the common sysfs scrub interface
> >> + * promotes unambiguous access from the userspace.
> >> + *
> >> + * Copyright (c) 2024 HiSilicon Limited.
> >> + */
> >> +
> >> +#define pr_fmt(fmt)     "EDAC SCRUB: " fmt
> >> +
> >> +#include <linux/edac_ras_feature.h>
> >> +
> >> +static ssize_t addr_range_base_show(struct device *ras_feat_dev,
> >> +				    struct device_attribute *attr,
> >> +				    char *buf)
> >> +{
> >> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> >> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> >> +	u64 base, size;
> >> +	int ret;
> >> +
> >> +	ret =3D ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &b=
ase, =20
> >&size); =20
> >> +	if (ret)
> >> +		return ret; =20
> >
> >Also a generic comment applied to all devnodes: what if ops->read_range =
is
> >NULL? Shouldn't it be checked? Btw, you could use read_range =3D=3D NULL=
 if to
> >implement error handling for unsupported features. =20
> If ops->read_range is NULL, scrub_attr_visible() return 0 and then the co=
rresponding attributes
> addr_range_base and addr_range_size  would not be added in the sysfs.
> Same for other attributes.

Ok. Please document that either at the patch description and/or at the ABI.

> > =20
> >> +
> >> +	return sysfs_emit(buf, "0x%llx\n", base); }
> >> +
> >> +static ssize_t addr_range_size_show(struct device *ras_feat_dev,
> >> +				    struct device_attribute *attr,
> >> +				    char *buf)
> >> +{
> >> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> >> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> >> +	u64 base, size;
> >> +	int ret;
> >> +
> >> +	ret =3D ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &b=
ase, =20
> >&size); =20
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return sysfs_emit(buf, "0x%llx\n", size); }
> >> +
> >> +static ssize_t addr_range_base_store(struct device *ras_feat_dev,
> >> +				     struct device_attribute *attr,
> >> +				     const char *buf, size_t len) {
> >> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> >> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> >> +	u64 base, size;
> >> +	int ret;
> >> +
> >> +	ret =3D ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &b=
ase, =20
> >&size); =20
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret =3D kstrtou64(buf, 16, &base); =20
> >
> >I would use base 0, letting the parser expect "0x" for hexadecimal value=
s.
> >Same for other *_store methods. =20
> Will check.
>=20
> > =20
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	ret =3D ops->write_range(ras_feat_dev->parent, ctx->scrub.private, b=
ase, =20
> >size); =20
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return len;
> >> +}
> >> +
> >> +static ssize_t addr_range_size_store(struct device *ras_feat_dev,
> >> +				     struct device_attribute *attr,
> >> +				     const char *buf,
> >> +				     size_t len)
> >> +{
> >> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> >> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> >> +	u64 base, size;
> >> +	int ret;
> >> +
> >> +	ret =3D ops->read_range(ras_feat_dev->parent, ctx->scrub.private, &b=
ase, =20
> >&size); =20
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret =3D kstrtou64(buf, 16, &size);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	ret =3D ops->write_range(ras_feat_dev->parent, ctx->scrub.private, b=
ase, =20
> >size); =20
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return len;
> >> +}
> >> +
> >> +static ssize_t enable_background_store(struct device *ras_feat_dev,
> >> +				       struct device_attribute *attr,
> >> +				       const char *buf, size_t len) {
> >> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> >> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> >> +	bool enable;
> >> +	int ret;
> >> +
> >> +	ret =3D kstrtobool(buf, &enable);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	ret =3D ops->set_enabled_bg(ras_feat_dev->parent, ctx->scrub.private=
, =20
> >enable); =20
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return len;
> >> +}
> >> +
> >> +static ssize_t enable_background_show(struct device *ras_feat_dev,
> >> +				      struct device_attribute *attr, char *buf) {
> >> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> >> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> >> +	bool enable;
> >> +	int ret;
> >> +
> >> +	ret =3D ops->get_enabled_bg(ras_feat_dev->parent, ctx->scrub.private=
, =20
> >&enable); =20
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return sysfs_emit(buf, "%d\n", enable); }
> >> +
> >> +static ssize_t enable_on_demand_show(struct device *ras_feat_dev,
> >> +				     struct device_attribute *attr, char *buf) {
> >> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> >> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> >> +	bool enable;
> >> +	int ret;
> >> +
> >> +	ret =3D ops->get_enabled_od(ras_feat_dev->parent, ctx->scrub.private=
, =20
> >&enable); =20
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return sysfs_emit(buf, "%d\n", enable); }
> >> +
> >> +static ssize_t enable_on_demand_store(struct device *ras_feat_dev,
> >> +				      struct device_attribute *attr,
> >> +				      const char *buf, size_t len) {
> >> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> >> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> >> +	bool enable;
> >> +	int ret;
> >> +
> >> +	ret =3D kstrtobool(buf, &enable);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	ret =3D ops->set_enabled_od(ras_feat_dev->parent, ctx->scrub.private=
, =20
> >enable); =20
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return len;
> >> +}
> >> +
> >> +static ssize_t name_show(struct device *ras_feat_dev,
> >> +			 struct device_attribute *attr, char *buf) {
> >> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> >> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> >> +	int ret;
> >> +
> >> +	ret =3D ops->get_name(ras_feat_dev->parent, ctx->scrub.private, buf);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return strlen(buf);
> >> +}
> >> +
> >> +static ssize_t cycle_in_hours_show(struct device *ras_feat_dev, struc=
t =20
> >device_attribute *attr, =20
> >> +				   char *buf)
> >> +{
> >> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> >> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> >> +	u64 val;
> >> +	int ret;
> >> +
> >> +	ret =3D ops->cycle_in_hours_read(ras_feat_dev->parent, ctx-
> >>scrub.private, &val);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return sysfs_emit(buf, "0x%llx\n", val); }
> >> +
> >> +static ssize_t cycle_in_hours_store(struct device *ras_feat_dev, stru=
ct =20
> >device_attribute *attr, =20
> >> +				    const char *buf, size_t len)
> >> +{
> >> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> >> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> >> +	long val;
> >> +	int ret;
> >> +
> >> +	ret =3D kstrtol(buf, 10, &val); =20
> >
> >Even here, I would be using base=3D0, but if you only want to support ba=
se 10,
> >please document it at the sysfs ABI. =20
> Will do.
> > =20
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	ret =3D ops->cycle_in_hours_write(ras_feat_dev->parent, ctx-
> >>scrub.private, val);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return len;
> >> +}
> >> +
> >> +static ssize_t cycle_in_hours_range_show(struct device *ras_feat_dev,
> >> +					 struct device_attribute *attr,
> >> +					 char *buf)
> >> +{
> >> +	struct edac_ras_feat_ctx *ctx =3D dev_get_drvdata(ras_feat_dev);
> >> +	const struct edac_scrub_ops *ops =3D ctx->scrub.ops;
> >> +	u64 min_schrs, max_schrs;
> >> +	int ret;
> >> +
> >> +	ret =3D ops->cycle_in_hours_range(ras_feat_dev->parent, ctx-
> >>scrub.private,
> >> +					&min_schrs, &max_schrs);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return sysfs_emit(buf, "0x%llx-0x%llx\n", min_schrs, max_schrs); =20
> >
> >Hmm... you added the store in decimal, but here you're showing in hexa..=
. =20
> Will check for store and show decimal.
> >
> >Btw, don't group multiple values on a single sysfs node. Instead, implem=
ent two
> >separate devnodes: =20
> Here we are showing the supported range for the scrub cycle.=20
> I am wondering any opinion on this from others?

That is how ABIs are implemented.=20

See for instance hwmon class, where all measurements have ranges, mapped
as min/max pairs:

/sys/class/hwmon/hwmonX/currY_max
/sys/class/hwmon/hwmonX/currY_min
/sys/class/hwmon/hwmonX/currY_rated_max
/sys/class/hwmon/hwmonX/currY_rated_min
/sys/class/hwmon/hwmonX/fanY_max
/sys/class/hwmon/hwmonX/fanY_min
/sys/class/hwmon/hwmonX/humidityY_max
/sys/class/hwmon/hwmonX/humidityY_max_alarm
/sys/class/hwmon/hwmonX/humidityY_max_hyst
/sys/class/hwmon/hwmonX/humidityY_min
/sys/class/hwmon/hwmonX/humidityY_min_alarm
/sys/class/hwmon/hwmonX/humidityY_min_hyst
/sys/class/hwmon/hwmonX/humidityY_rated_max
/sys/class/hwmon/hwmonX/humidityY_rated_min
/sys/class/hwmon/hwmonX/inY_max
/sys/class/hwmon/hwmonX/inY_min
/sys/class/hwmon/hwmonX/inY_rated_max
/sys/class/hwmon/hwmonX/inY_rated_min
...

You can also seek for range: there's none defined under ABI=20
documentation.

Tip: you can use:
	./scripts/get_abi.pl search

to check such things.

