Return-Path: <linux-edac+bounces-2074-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D1399EDA0
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 15:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9631F2205F
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 13:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B8712F5B1;
	Tue, 15 Oct 2024 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ew1MCGii"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59631FC7C2;
	Tue, 15 Oct 2024 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999161; cv=none; b=gB4sVowd03oZCHKsL68UB9NvhAgq4Y3p7EdXOAUIvUXfb1dEAhWjLgLJesrxpWXudtOk17sclkhmKloGgti9UyqW2hw2h+JFMj0zRtv5hItTPM/TlNfAR97j3MJwSUmgn184fju7CA7FeKpJbEB+w7NohQRQfZoLRsYO2yrjT3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999161; c=relaxed/simple;
	bh=5fIT9OmKwq1xHPg4nWK9yuoW/kODnF5lwDlL5KHxdbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5Qi0rewQMizaOx96J+TyfzzxHcAHTRIKTWgWAEtwoa3HYK7YR6t2Rya5AZUpyQScMnGEM8XMZvkzMHlaF27c19DjVOtD5fb9DPhCFVVOKWmfoOfFx1LcAYRxOToFUAY7/Vw67+ZXIB4tc+AmJortDJbdZHJPrGkGuL3dHd+xEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ew1MCGii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A38C4CECE;
	Tue, 15 Oct 2024 13:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728999160;
	bh=5fIT9OmKwq1xHPg4nWK9yuoW/kODnF5lwDlL5KHxdbE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ew1MCGiimUYdnMV2OnA9mPw2zX+Lo/8sQxlvO3xGOROD8DmGJzveF+N2QQ0Ij3DOh
	 JzRTfn6ziFZ3c+2epd/w6ubYtOKv2IqHe66K1aQan++eU14Dk8mUqVJo1RkorVIKU8
	 exWfBmXZsC9+rHDDeyKIUnwZSiq39Is3dl+htJaQVHueBpuwNxKNLp0JDotHLB9b6l
	 PvvSZKBW8bgXPQWobmMITW2ZVqHevhQ8tbXmcKsGyCTv3Yow5BnrPa6uNZsnnsYsEK
	 AZQcQ2TTEuXz/Ec6rku+BrfQRQRZUdIigyHq431wGjIyiPWxugOUuDDjRdpRKrBVx2
	 p9O5nyiQ4PZCQ==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e5ccec079eso1860286b6e.3;
        Tue, 15 Oct 2024 06:32:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDtHSyvHazyOGPYognEkTi2CV5Qog+13ArQZe65NO9sz3SBNYhBhTnlEbB3AE5GS1AiElG2CWPUg79@vger.kernel.org, AJvYcCWIkVzR8dDCVbffca3cmXatfBPoubzyPAo6JD1r18fuTwrFbikHYFlhDobUlTIfKn8CQdpcXNFOD+y8@vger.kernel.org, AJvYcCWj1pHPDG4f8lJD7eUtppIkRsTRiwoT5Bj/fQEoPCWPD7OOjw7hndLCFqm92lWeQB6A8jeCEvSPOmahAAV3@vger.kernel.org, AJvYcCXRBmukqEViyI7RbSWQBALUpQlI+O+iRgtdqM9K3HdOdh8ZGDn78/LUrwQKcMF14jnQKI2VZWUBKa96sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNK3VQ4h9VD+s4x3r0XSJ/A3fBfNcEX0NxNIlNANY1zD9o0TOv
	Rk6Io4ffO7vrMsuhVk3bJX8w5614+AXQmByZ3Jgk5Pt0/fDOgxOg2HAXkAaGBHbdhPb55rC9j4q
	puV8AXxHN5HVfNZExn4XeLFVUbFk=
X-Google-Smtp-Source: AGHT+IHuO1i4hxtn/TwfVt+toXC1+oAP+6GnGpmajF9HnA2MJ52+I8CyfiFQ6xobfIYee3MmOj6Drz38cNmnbBK/tZA=
X-Received: by 2002:a05:6870:2896:b0:277:cc56:2300 with SMTP id
 586e51a60fabf-2886dd70fd1mr11104236fac.12.1728999159750; Tue, 15 Oct 2024
 06:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009124120.1124-1-shiju.jose@huawei.com> <20241009124120.1124-13-shiju.jose@huawei.com>
 <20241014164339.00003e73@Huawei.com> <2024101410-turf-junior-7739@gregkh>
 <2024101451-reword-animation-2179@gregkh> <20241014181654.00005180@Huawei.com>
 <CAJZ5v0j-mwZmuciSTaL8MyAp530y=n9HbQ=uVvcnvGLR1n+YuQ@mail.gmail.com>
 <20241015101025.00005305@Huawei.com> <20241015104021.00002906@huawei.com> <2024101517-bubbling-deploy-1be0@gregkh>
In-Reply-To: <2024101517-bubbling-deploy-1be0@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Oct 2024 15:32:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iyc5gvpXjpZdmv-vh8+haPENz+UBXVSF6UDBCRT12fMg@mail.gmail.com>
Message-ID: <CAJZ5v0iyc5gvpXjpZdmv-vh8+haPENz+UBXVSF6UDBCRT12fMg@mail.gmail.com>
Subject: Re: [PATCH v13 12/18] platform: Add __free() based cleanup function
 for platform_device_put
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linuxarm@huawei.com, 
	shiju.jose@huawei.com, linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bp@alien8.de, tony.luck@intel.com, lenb@kernel.org, mchehab@kernel.org, 
	dan.j.williams@intel.com, dave@stgolabs.net, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com, 
	david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com, 
	Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com, 
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, 
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com, 
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com, 
	gthelen@google.com, wschwartz@amperecomputing.com, 
	dferguson@amperecomputing.com, wbs@os.amperecomputing.com, 
	nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com, 
	wanghuiqiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 12:17=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Oct 15, 2024 at 10:40:54AM +0100, Jonathan Cameron wrote:
> > On Tue, 15 Oct 2024 10:10:25 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >
> > > On Mon, 14 Oct 2024 20:06:40 +0200
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >
> > > > On Mon, Oct 14, 2024 at 7:17=E2=80=AFPM Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > >
> > > > > On Mon, 14 Oct 2024 18:04:37 +0200
> > > > > Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > > On Mon, Oct 14, 2024 at 06:00:51PM +0200, Greg KH wrote:
> > > > > > > On Mon, Oct 14, 2024 at 04:43:39PM +0100, Jonathan Cameron wr=
ote:
> > > > > > > > On Wed, 9 Oct 2024 13:41:13 +0100
> > > > > > > > <shiju.jose@huawei.com> wrote:
> > > > > > > >
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
> > > > > > > > >         int (*probe)(struct platform_device *);
> > > > > > > >
> > > > > > > > +CC Greg KH and Rafael.
> > > > > > > >
> > > > > > > > Makes sure to include them on v14 as this needs review from=
 a driver core point
> > > > > > > > of view I think.
> > > > > > >
> > > > > > > Why is this needed for a platform device?  This feels like yo=
u will have
> > > > > > > to do more work to "keep" the reference on the normal path th=
an you to
> > > > > > > today to release the reference on the error path, right?  Hav=
e a pointer
> > > > > > > to a patch that uses this?
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
> > > > > > device layer for something like this.
> > > > >
> > > > > Ok.  Probably virtual bus it is then.  Rafael, what do you think =
makes sense
> > > > > for a 'feature' that is described only by an ACPI table (here RAS=
2)?
> > > > > Kind of similar(ish) to say IORT.
> > > >
> > > > Good question.
> > > >
> > > > I guess it depends on whether or not there are any registers to acc=
ess
> > > > or AML to interact with.  If so, I think that a platform device mak=
es
> > > > sense.
> > >
> > > Unfortunately still a gray area I think.
> > >
> > > This does access mailbox memory addresses, but they are provided
> > > by an existing platform device, so maybe platform device for this
> > > device is still inappropriate :(
> > >
> > > What this uses is:
> > > PCC channel (mailbox in memory + doorbells, etc but that is indirectl=
y
> > > provided as a service via reference in ACPI to the PCCT table entry
> > > allowing this to find the mailbox device - which is a platform
> > > device drivers/mailbox/pcc.c).
> > > Because it's all spec defined content in the mailbox messages, we don=
't
> > > have the more flexible (and newer I think) 'register' via operation r=
egion
> > > stuff in AML.
> > >
> > > A wrinkle though.  The mailbox data is mapped into this driver via
> > > an acpi_os_ioremap() call.
> > >
> > > So I'm thinking we don't have a strong reason for a platform device
> > > other than 'similarity' to other examples.  Never the strongest reaso=
n!
> > >
> > > We'll explore alternatives and see what they end up looking like.
> > >
> > > Jonathan
> > >
> >
> > Greg,
> >
> > I'm struggling a little to figure out how you envision the virtual bus
> > working here.  So before we spend too much time implementing the wrong =
thing
> > as it feels non trivial, let me check my understanding.
> >
> > Would this mean registering a ras2 bus via subsys_virtual_register().
> > (Similar to done for memory tiers)
>
> It should show up under /sys/devices/virtual/ is what I mean.
>
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
> >
> > So spinning up a full new bus, to support this?  I'm not against that.
>
> No, again, see how the stuff that shows up in /sys/devices/virtual
> works, that should be much simpler.
>
> But really, as this is a "bus", just make a new one.  I don't understand
> why ACPI isn't creating your devices for you, as this is ACPI code,
> perhaps just fix that up instead?  That would make much more sense to
> me...

Because it is a data-only table, not AML.

It looks to me like this could be an auxiliary device, similar to the
Intel VSEC driver: see intel_vsec_add_aux() etc.

Cheers, Rafael

