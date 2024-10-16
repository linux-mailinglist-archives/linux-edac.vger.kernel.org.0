Return-Path: <linux-edac+bounces-2093-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE219A04E9
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 11:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EBD1F268C3
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 09:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD14204F94;
	Wed, 16 Oct 2024 09:00:11 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5411C6F55;
	Wed, 16 Oct 2024 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069211; cv=none; b=X+16r0HpuTLCWETHxalGflC/+azkzNhFjSzgs09P1C97z244Sx4/Ogsq0TCfaXx8B4klweEfDmu+0W/9l/d9/Z+tfcTejUhvD1GG+Ik/+MgcaIldrlbPIDwG5FJmcuKdpG/+exHgY7CMi1D9RPRbqj9wRfmR7Yd74QL6/ajwHcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069211; c=relaxed/simple;
	bh=Z8vYqfcihPahyj6XkwjiIM4tnoQjxhP9bBwIwwT90C4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGZukVFs+LKB3HCfZDlVprBHxCD5U7VThfW55f39M+uiPl8tJth4sjTjHTyLLqy4sI+o2AwwsRkEnc5F+hEPe8n6K7UzVLSis1Mj3rzK6082iyjiQxIlvdpD3LYFMqCEkOPe2APKdHO2cocbG15LG8NhygCeu4bMxm/lFWzzk4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XT4cx6f2mz67ntN;
	Wed, 16 Oct 2024 16:58:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3079E140B67;
	Wed, 16 Oct 2024 17:00:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 11:00:04 +0200
Date: Wed, 16 Oct 2024 10:00:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Greg KH <gregkh@linuxfoundation.org>, <linuxarm@huawei.com>,
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
	<wanghuiqiang@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Jassi Brar
	<jassisinghbrar@gmail.com>
Subject: Re: [PATCH v13 12/18] platform: Add __free() based cleanup function
 for platform_device_put
Message-ID: <20241016100003.000072fd@Huawei.com>
In-Reply-To: <CAJZ5v0iRzFQ4EaHKjs0oirmh1HpkONz--JKYB3oLrT84A+XXzA@mail.gmail.com>
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
	<CAJZ5v0iyc5gvpXjpZdmv-vh8+haPENz+UBXVSF6UDBCRT12fMg@mail.gmail.com>
	<20241015151947.00006a4f@Huawei.com>
	<CAJZ5v0iRzFQ4EaHKjs0oirmh1HpkONz--JKYB3oLrT84A+XXzA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 15 Oct 2024 17:35:31 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Oct 15, 2024 at 4:19=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue, 15 Oct 2024 15:32:28 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > =20
> > > On Tue, Oct 15, 2024 at 12:17=E2=80=AFPM Greg KH <gregkh@linuxfoundat=
ion.org> wrote: =20
> > > >
> > > > On Tue, Oct 15, 2024 at 10:40:54AM +0100, Jonathan Cameron wrote: =
=20
> > > > > On Tue, 15 Oct 2024 10:10:25 +0100
> > > > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > > > > =20
> > > > > > On Mon, 14 Oct 2024 20:06:40 +0200
> > > > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > > > =20
> > > > > > > On Mon, Oct 14, 2024 at 7:17=E2=80=AFPM Jonathan Cameron
> > > > > > > <Jonathan.Cameron@huawei.com> wrote: =20
> > > > > > > >
> > > > > > > > On Mon, 14 Oct 2024 18:04:37 +0200
> > > > > > > > Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > > > =20
> > > > > > > > > On Mon, Oct 14, 2024 at 06:00:51PM +0200, Greg KH wrote: =
=20
> > > > > > > > > > On Mon, Oct 14, 2024 at 04:43:39PM +0100, Jonathan Came=
ron wrote: =20
> > > > > > > > > > > On Wed, 9 Oct 2024 13:41:13 +0100
> > > > > > > > > > > <shiju.jose@huawei.com> wrote:
> > > > > > > > > > > =20
> > > > > > > > > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > > > > > > >
> > > > > > > > > > > > Add __free() based cleanup function for platform_de=
vice_put().
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@h=
uawei.com>
> > > > > > > > > > > > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  include/linux/platform_device.h | 1 +
> > > > > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/include/linux/platform_device.h b/incl=
ude/linux/platform_device.h
> > > > > > > > > > > > index d422db6eec63..606533b88f44 100644
> > > > > > > > > > > > --- a/include/linux/platform_device.h
> > > > > > > > > > > > +++ b/include/linux/platform_device.h
> > > > > > > > > > > > @@ -232,6 +232,7 @@ extern int platform_device_add_=
data(struct platform_device *pdev,
> > > > > > > > > > > >  extern int platform_device_add(struct platform_dev=
ice *pdev);
> > > > > > > > > > > >  extern void platform_device_del(struct platform_de=
vice *pdev);
> > > > > > > > > > > >  extern void platform_device_put(struct platform_de=
vice *pdev);
> > > > > > > > > > > > +DEFINE_FREE(platform_device_put, struct platform_d=
evice *, if (_T) platform_device_put(_T))
> > > > > > > > > > > >
> > > > > > > > > > > >  struct platform_driver {
> > > > > > > > > > > >         int (*probe)(struct platform_device *); =20
> > > > > > > > > > >
> > > > > > > > > > > +CC Greg KH and Rafael.
> > > > > > > > > > >
> > > > > > > > > > > Makes sure to include them on v14 as this needs revie=
w from a driver core point
> > > > > > > > > > > of view I think. =20
> > > > > > > > > >
> > > > > > > > > > Why is this needed for a platform device?  This feels l=
ike you will have
> > > > > > > > > > to do more work to "keep" the reference on the normal p=
ath than you to
> > > > > > > > > > today to release the reference on the error path, right=
?  Have a pointer
> > > > > > > > > > to a patch that uses this? =20
> > > > > > > > >
> > > > > > > > > Ah, is it this one:
> > > > > > > > >       https://lore.kernel.org/all/20241014164955.00003439=
@Huawei.com/
> > > > > > > > > ?
> > > > > > > > >
> > > > > > > > > If so, no, that's an abuse of a platform device, don't do=
 that, make a
> > > > > > > > > REAL device on the bus that this device lives on.  If it =
doesn't live on
> > > > > > > > > a real bus, then put it on the virtual bus but do NOT abu=
se the platform
> > > > > > > > > device layer for something like this. =20
> > > > > > > >
> > > > > > > > Ok.  Probably virtual bus it is then.  Rafael, what do you =
think makes sense
> > > > > > > > for a 'feature' that is described only by an ACPI table (he=
re RAS2)?
> > > > > > > > Kind of similar(ish) to say IORT. =20
> > > > > > >
> > > > > > > Good question.
> > > > > > >
> > > > > > > I guess it depends on whether or not there are any registers =
to access
> > > > > > > or AML to interact with.  If so, I think that a platform devi=
ce makes
> > > > > > > sense. =20
> > > > > >
> > > > > > Unfortunately still a gray area I think.
> > > > > >
> > > > > > This does access mailbox memory addresses, but they are provided
> > > > > > by an existing platform device, so maybe platform device for th=
is
> > > > > > device is still inappropriate :(
> > > > > >
> > > > > > What this uses is:
> > > > > > PCC channel (mailbox in memory + doorbells, etc but that is ind=
irectly
> > > > > > provided as a service via reference in ACPI to the PCCT table e=
ntry
> > > > > > allowing this to find the mailbox device - which is a platform
> > > > > > device drivers/mailbox/pcc.c).
> > > > > > Because it's all spec defined content in the mailbox messages, =
we don't
> > > > > > have the more flexible (and newer I think) 'register' via opera=
tion region
> > > > > > stuff in AML.
> > > > > >
> > > > > > A wrinkle though.  The mailbox data is mapped into this driver =
via
> > > > > > an acpi_os_ioremap() call.
> > > > > >
> > > > > > So I'm thinking we don't have a strong reason for a platform de=
vice
> > > > > > other than 'similarity' to other examples.  Never the strongest=
 reason!
> > > > > >
> > > > > > We'll explore alternatives and see what they end up looking lik=
e.
> > > > > >
> > > > > > Jonathan
> > > > > > =20
> > > > >
> > > > > Greg,
> > > > >
> > > > > I'm struggling a little to figure out how you envision the virtua=
l bus
> > > > > working here.  So before we spend too much time implementing the =
wrong thing
> > > > > as it feels non trivial, let me check my understanding.
> > > > >
> > > > > Would this mean registering a ras2 bus via subsys_virtual_registe=
r().
> > > > > (Similar to done for memory tiers) =20
> > > >
> > > > It should show up under /sys/devices/virtual/ is what I mean.
> > > > =20
> > > > > On that we'd then add all the devices: one per RAS2 PCC descripto=
r (these
> > > > > are one per independent feature). Each feature has its own mailbo=
x sub
> > > > > channel (via a reference to the PCC mailbox devices .
> > > > > Typically you have one of these per feature type per numa node, b=
ut
> > > > > that isn't guaranteed.  That will then need wiring up with bus->p=
robe() etc
> > > > > so that the RAS2 edac feature drivers can find this later and bin=
d to it to
> > > > > register with edac etc.
> > > > >
> > > > > So spinning up a full new bus, to support this?  I'm not against =
that. =20
> > > >
> > > > No, again, see how the stuff that shows up in /sys/devices/virtual
> > > > works, that should be much simpler.
> > > >
> > > > But really, as this is a "bus", just make a new one.  I don't under=
stand
> > > > why ACPI isn't creating your devices for you, as this is ACPI code,
> > > > perhaps just fix that up instead?  That would make much more sense =
to
> > > > me... =20
> > >
> > > Because it is a data-only table, not AML.
> > >
> > > It looks to me like this could be an auxiliary device, similar to the
> > > Intel VSEC driver: see intel_vsec_add_aux() etc.
> > > =20
> >
> > That was in the other branch of the thread abbreviated as auxbus.
> > My concern with that approach is we have no parent device and the
> > auxiliary bus is always described as being for sub parts of a
> > compound device. In the intel_vsec case there is always a parent
> > pci device or platform device.
> >
> > I don't think there is any functional requirement for a real parent,
> > it just feels like abuse given the stated purpose of auxiliary bus.
> > Greg, auxiliary bus or separate acpi_ras2 bus feel better to you?
> >
> > We'd need to parent it off something to avoid the check in
> > auxiliary_device_init() + all devices should have a parent anyway. =20
>=20
> Wouldn't that be the platform device providing the mailbox memory
> addresses mentioned in one of the previous messages?

Added Sudeep and Jassi given this feels like we'd need their input
to consider doing this.

Hmm. Probably works, though it will be a little inelegant as we'll have
a discovery path unrelated to the mailbox provider discovery path
that then instantiates children of the mailbox device. This is just
one consumer of the mailbox device. It feels not too bad for this particular
combination at all because RAS2 entries don't have any other resources
so unlike many PCC channel users we wouldn't be introduce devices with
wider scope than the mailbox parent device (note I think there is only
device for all PCC in the system - each actual mailbox is a PCC subspace).

1) Mailbox path:
	acpi_pcc_probe() in drivers/mailbox/pcc.c via postcore_init_call()
 	Checks there are PCC channels in PCCT ACPI table.
	Instantiates a platform device and binds that via
	platform_create_bundle()
	Probes the available channels and stashes all the info
	about them in arrays associated with that platform device.
	Calls mbox_controller_register() which sounds like as
	class registration but isn't. That just puts it on
	LIST_HEAD(mbox_cons) so that it can be searched for
	by consumers of this channel.
2) RAS2 parsing (tweaked version of patch 13)
	acpi_ras2_probe() currently via a late_initcall()
	Checks for RAS2 table and for each RAS2 PCC descriptor and
	gets a channel from the appropriate mailbox via
	pcc_mbox_request_channel() giving us a struct pcc_mbox_chan.
	Then we would need to get from there to the platform device
	that represents all the mailboxes.
	pcc_mbox->mchan->mbox_controller->dev is it I think.
	Finally we parent our new device off that.

What do people think of this vs option of spinning a new bus/acpi_ras2
and no parent relationship between a ras2 feature entry the PCC
platform device - just a client of mailbox relationship
(effectively what is in patch 13, but with devices on a new bus rather
than as platform_device)
https://lore.kernel.org/all/20241009124120.1124-14-shiju.jose@huawei.com/
is that patch.

Jonathan







