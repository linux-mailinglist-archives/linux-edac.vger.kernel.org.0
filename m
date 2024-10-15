Return-Path: <linux-edac+bounces-2075-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EB899EDB5
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 15:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60923B2179C
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 13:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1490B136E28;
	Tue, 15 Oct 2024 13:34:35 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A1A1FC7F4;
	Tue, 15 Oct 2024 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999275; cv=none; b=pPuDq7kTLRpE5ZZToQAnSGG41tBhFqj32QSu+4dytddODNF4cjiHNriTFU4trx8y36INYbI0zipBHd+a11UlaJEpNI7t8fkbx5OSc6CdCueel3DpfffUX97TaQj3lh+76l4uuXHHYFHj7fw/MRdD6cEaZhPIt8YNqPszYFU46oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999275; c=relaxed/simple;
	bh=1886izmvLshgJ46+qnR5XH1DVcu9nJf6t51WVT0kXZ4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELzXocWlfCrfPiDuR0Dn326IKJ2auzbVXHVnbt8uKMi/TuXP0cTbfyL61nHKjuApx8iL7GSBPqykCBaTCvxBiiwzEO3FEdu/qedrO1bdO7tcgdjJGZ6EIFkXhFx18gPS3somuzm1IynfeaUhQcldXkaDoQaYo76BDI1MaMTfXTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XSZnH22jlz6HJ5h;
	Tue, 15 Oct 2024 21:33:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CCAFB140451;
	Tue, 15 Oct 2024 21:34:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Oct
 2024 15:34:28 +0200
Date: Tue, 15 Oct 2024 14:34:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linuxarm@huawei.com>,
	<shiju.jose@huawei.com>, <linux-edac@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <mchehab@kernel.org>,
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
	<wanghuiqiang@huawei.com>
Subject: Re: [PATCH v13 12/18] platform: Add __free() based cleanup function
 for platform_device_put
Message-ID: <20241015143426.00002e5b@Huawei.com>
In-Reply-To: <2024101517-bubbling-deploy-1be0@gregkh>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-13-shiju.jose@huawei.com>
	<20241014164339.00003e73@Huawei.com>
	<2024101410-turf-junior-7739@gregkh>
	<2024101451-reword-animation-2179@gregkh>
	<20241014181654.00005180@Huawei.com>
	<CAJZ5v0j-mwZmuciSTaL8MyAp530y=n9HbQ=uVvcnvGLR1n+YuQ@mail.gmail.com>
	<20241015101025.00005305@Huawei.com>
	<20241015104021.00002906@huawei.com>
	<2024101517-bubbling-deploy-1be0@gregkh>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 15 Oct 2024 12:17:25 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Oct 15, 2024 at 10:40:54AM +0100, Jonathan Cameron wrote:
> > On Tue, 15 Oct 2024 10:10:25 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >  =20
> > > On Mon, 14 Oct 2024 20:06:40 +0200
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >  =20
> > > > On Mon, Oct 14, 2024 at 7:17=E2=80=AFPM Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote: =20
> > > > >
> > > > > On Mon, 14 Oct 2024 18:04:37 +0200
> > > > > Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >   =20
> > > > > > On Mon, Oct 14, 2024 at 06:00:51PM +0200, Greg KH wrote:   =20
> > > > > > > On Mon, Oct 14, 2024 at 04:43:39PM +0100, Jonathan Cameron wr=
ote:   =20
> > > > > > > > On Wed, 9 Oct 2024 13:41:13 +0100
> > > > > > > > <shiju.jose@huawei.com> wrote:
> > > > > > > >   =20
> > > > > > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > > > >
> > > > > > > > > Add __free() based cleanup function for platform_device_p=
ut().
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.=
com>
> > > > > > > > > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > > > > > > > > ---
> > > > > > > > >  include/linux/platform_device.h | 1 +
> > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > >
> > > > > > > > > diff --git a/include/linux/platform_device.h b/include/li=
nux/platform_device.h
> > > > > > > > > index d422db6eec63..606533b88f44 100644
> > > > > > > > > --- a/include/linux/platform_device.h
> > > > > > > > > +++ b/include/linux/platform_device.h
> > > > > > > > > @@ -232,6 +232,7 @@ extern int platform_device_add_data(s=
truct platform_device *pdev,
> > > > > > > > >  extern int platform_device_add(struct platform_device *p=
dev);
> > > > > > > > >  extern void platform_device_del(struct platform_device *=
pdev);
> > > > > > > > >  extern void platform_device_put(struct platform_device *=
pdev);
> > > > > > > > > +DEFINE_FREE(platform_device_put, struct platform_device =
*, if (_T) platform_device_put(_T))
> > > > > > > > >
> > > > > > > > >  struct platform_driver {
> > > > > > > > >         int (*probe)(struct platform_device *);   =20
> > > > > > > >
> > > > > > > > +CC Greg KH and Rafael.
> > > > > > > >
> > > > > > > > Makes sure to include them on v14 as this needs review from=
 a driver core point
> > > > > > > > of view I think.   =20
> > > > > > >
> > > > > > > Why is this needed for a platform device?  This feels like yo=
u will have
> > > > > > > to do more work to "keep" the reference on the normal path th=
an you to
> > > > > > > today to release the reference on the error path, right?  Hav=
e a pointer
> > > > > > > to a patch that uses this?   =20
> > > > > >
> > > > > > Ah, is it this one:
> > > > > >       https://lore.kernel.org/all/20241014164955.00003439@Huawe=
i.com/
> > > > > > ?
> > > > > >
> > > > > > If so, no, that's an abuse of a platform device, don't do that,=
 make a
> > > > > > REAL device on the bus that this device lives on.  If it doesn'=
t live on
> > > > > > a real bus, then put it on the virtual bus but do NOT abuse the=
 platform
> > > > > > device layer for something like this.   =20
> > > > >
> > > > > Ok.  Probably virtual bus it is then.  Rafael, what do you think =
makes sense
> > > > > for a 'feature' that is described only by an ACPI table (here RAS=
2)?
> > > > > Kind of similar(ish) to say IORT.   =20
> > > >=20
> > > > Good question.
> > > >=20
> > > > I guess it depends on whether or not there are any registers to acc=
ess
> > > > or AML to interact with.  If so, I think that a platform device mak=
es
> > > > sense. =20
> > >=20
> > > Unfortunately still a gray area I think.
> > >=20
> > > This does access mailbox memory addresses, but they are provided
> > > by an existing platform device, so maybe platform device for this
> > > device is still inappropriate :(
> > >=20
> > > What this uses is:
> > > PCC channel (mailbox in memory + doorbells, etc but that is indirectly
> > > provided as a service via reference in ACPI to the PCCT table entry
> > > allowing this to find the mailbox device - which is a platform
> > > device drivers/mailbox/pcc.c).
> > > Because it's all spec defined content in the mailbox messages, we don=
't
> > > have the more flexible (and newer I think) 'register' via operation r=
egion
> > > stuff in AML.
> > >=20
> > > A wrinkle though.  The mailbox data is mapped into this driver via
> > > an acpi_os_ioremap() call. =20
> > >=20
> > > So I'm thinking we don't have a strong reason for a platform device
> > > other than 'similarity' to other examples.  Never the strongest reaso=
n!
> > >=20
> > > We'll explore alternatives and see what they end up looking like.
> > >=20
> > > Jonathan
> > >  =20
> >=20
> > Greg,
> >=20
> > I'm struggling a little to figure out how you envision the virtual bus
> > working here.  So before we spend too much time implementing the wrong =
thing
> > as it feels non trivial, let me check my understanding.
> >=20
> > Would this mean registering a ras2 bus via subsys_virtual_register().
> > (Similar to done for memory tiers) =20
>=20
> It should show up under /sys/devices/virtual/ is what I mean.
>=20
> > On that we'd then add all the devices: one per RAS2 PCC descriptor (the=
se
> > are one per independent feature). Each feature has its own mailbox sub
> > channel (via a reference to the PCC mailbox devices .
> > Typically you have one of these per feature type per numa node, but
> > that isn't guaranteed.  That will then need wiring up with bus->probe()=
 etc
> > so that the RAS2 edac feature drivers can find this later and bind to i=
t to
> > register with edac etc.
> >=20
> > So spinning up a full new bus, to support this?  I'm not against that. =
=20
>=20
> No, again, see how the stuff that shows up in /sys/devices/virtual
> works, that should be much simpler.
>=20
> But really, as this is a "bus", just make a new one.  I don't understand
> why ACPI isn't creating your devices for you, as this is ACPI code,
> perhaps just fix that up instead? =20

Filling in that registration gap was the purpose of the next patch.

In all the similar cases that I can find where a static ACPI table is parsed
(maybe Rafael can point at another) one of two things happen:
1) The table is parsed and platform devices are created for the entries fou=
nd
  (IORT etc) to which drivers later bind.
2) There is a 'fake' device in DSDT. E.g. ACPI0012 for NFIT, ACPI0017 for C=
EDT
(the CXL table) that are there to trigger enumeration of the static table a=
nd
those are done via device on the acpi bus.  That allows late enumeration and
registration of devices with the appropriate classes etc.

We'll explore the options but right now I'm thinking a new bus/acpi_ras2 is=
 probably
the way to go.

Jonathan




> That would make much more sense to
> me...
>=20
> thanks,
>=20
> greg k-h
>=20


