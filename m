Return-Path: <linux-edac+bounces-2081-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC08F99F158
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 17:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C90F1F23A8E
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 15:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E7C1B3945;
	Tue, 15 Oct 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww0Z9FYv"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7851B393F;
	Tue, 15 Oct 2024 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006545; cv=none; b=oN6dQaiH0lZqzKo2YJeb1jS8IX7WM+WUNvdwuyJEr7QArPrUJw1HW2ZWmhsbcrqau+vMbuJQSX1SNnhOW8MT6YVlM+Lp7cvgAhL/RL8rlFF8mSPQcTozKyWE8YHEdHr+dn/CHQdcEQzq44h9HClOnRjWWjhl3AnUeoZJRP/5Ryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006545; c=relaxed/simple;
	bh=0l6KkvoDwX3UCktk+Bgp5F5kNFErOuVuyCFTPC5R9pQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsVRN03Gl6cHu9GDUw0icBPjXyhhWiiyL8GqjkUu2VUAlpC+1Er7WsvBW4JhWCVGdpzObY/VOfTAzkWZSJyh7DPoElQGCoYiH+d6RAvPHJUChpfVjQgzBmcQwnwwi30JXHQ+GDRTxOiJKpcLvKOhuemCyHIZ/oM7KYCypx9cm0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww0Z9FYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77104C4CED2;
	Tue, 15 Oct 2024 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729006544;
	bh=0l6KkvoDwX3UCktk+Bgp5F5kNFErOuVuyCFTPC5R9pQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ww0Z9FYv4+QykZ/JTQgGhst8EkSaXcEhi3dGYtIEfapusJzAYgSjbLwc3icb9PAXD
	 /jxbGdYqxmmTY3MbgfkdU0btL7Q6WckGSeD1QCEitPrv/+fMdZLBFWMUHpFTJcne6z
	 /v1kP4HCc9uQUoS1Rnv9hfNbtJLYzI+cTUdUV0F9cjuWDK6snyAIV9qpOZm1p/rymU
	 xK2aOtUzHLy02Z1bBSvmW64MOSl7rrAQIV1kcNjrnzohlEWb5HQMhureiHCfePY58w
	 KK7fyPTSz/kmg6JV/deSKydaJbCNCBWY82TjL7O3va5ieUqO7/qwMiAHI7p7wC28q2
	 4/+24pFLWPJRw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5e803a9f208so3179149eaf.0;
        Tue, 15 Oct 2024 08:35:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNd90erj5R5gsX+19wA6W7K5xFRsX7TCwVGve5sLbMsdg5aj5P2kteDloqIXsVnO0LINnRueOUDaid@vger.kernel.org, AJvYcCW+Mtpcx2rnfBV2EaYPFvvuSnbZIZDrtZ1tc9nuk1GSXa5Ruv4D6zuRCdWRLVNjWvfHHj+a1PBIyzjd@vger.kernel.org, AJvYcCWZtBJKO/tLljnto6kT9AsHTbjSUxm+IJxRIGJg9tBFq7yvVL6V40Lyr2geMWhFH4vVtfPVXyx6FfMvfg==@vger.kernel.org, AJvYcCX1+BaSbddgoZp5iXyKsE13sMxnG1Pe5Dj2mOCt84PaQ5V/tY4DVQ+XDIZpQFois5jTSzlCiIcBZvr1Nbr5@vger.kernel.org
X-Gm-Message-State: AOJu0YzdvUbDHJlqC8RStoZg7gDIYTMaaF7vySDPyph5JdQ3KQ9h3sZv
	YNduz0vJxMX4Xoqb5Wc2lzdk1HfniENVZLBhCJB2tqroF1Dnmbi9Kxfe1IuLknao8oqGOAUDT1o
	BuxGrCIFmIPZtTaBWUZTERqQOPKo=
X-Google-Smtp-Source: AGHT+IHFJh9rxSSaZMQcEQN8RDT7AyJeT13P5MvWKfMRdXo+P+Zu/PYJqtqAb/El25D+k7E4jFV6XBFJxO90UnNUNlk=
X-Received: by 2002:a05:6820:212:b0:5df:83a7:9ddf with SMTP id
 006d021491bc7-5eb1884dc96mr8268797eaf.0.1729006543638; Tue, 15 Oct 2024
 08:35:43 -0700 (PDT)
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
 <20241015101025.00005305@Huawei.com> <20241015104021.00002906@huawei.com>
 <2024101517-bubbling-deploy-1be0@gregkh> <CAJZ5v0iyc5gvpXjpZdmv-vh8+haPENz+UBXVSF6UDBCRT12fMg@mail.gmail.com>
 <20241015151947.00006a4f@Huawei.com>
In-Reply-To: <20241015151947.00006a4f@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Oct 2024 17:35:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iRzFQ4EaHKjs0oirmh1HpkONz--JKYB3oLrT84A+XXzA@mail.gmail.com>
Message-ID: <CAJZ5v0iRzFQ4EaHKjs0oirmh1HpkONz--JKYB3oLrT84A+XXzA@mail.gmail.com>
Subject: Re: [PATCH v13 12/18] platform: Add __free() based cleanup function
 for platform_device_put
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, linuxarm@huawei.com, 
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

On Tue, Oct 15, 2024 at 4:19=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 15 Oct 2024 15:32:28 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Tue, Oct 15, 2024 at 12:17=E2=80=AFPM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> > >
> > > On Tue, Oct 15, 2024 at 10:40:54AM +0100, Jonathan Cameron wrote:
> > > > On Tue, 15 Oct 2024 10:10:25 +0100
> > > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > > >
> > > > > On Mon, 14 Oct 2024 20:06:40 +0200
> > > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > >
> > > > > > On Mon, Oct 14, 2024 at 7:17=E2=80=AFPM Jonathan Cameron
> > > > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > > > >
> > > > > > > On Mon, 14 Oct 2024 18:04:37 +0200
> > > > > > > Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > > On Mon, Oct 14, 2024 at 06:00:51PM +0200, Greg KH wrote:
> > > > > > > > > On Mon, Oct 14, 2024 at 04:43:39PM +0100, Jonathan Camero=
n wrote:
> > > > > > > > > > On Wed, 9 Oct 2024 13:41:13 +0100
> > > > > > > > > > <shiju.jose@huawei.com> wrote:
> > > > > > > > > >
> > > > > > > > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > > > > > >
> > > > > > > > > > > Add __free() based cleanup function for platform_devi=
ce_put().
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@hua=
wei.com>
> > > > > > > > > > > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  include/linux/platform_device.h | 1 +
> > > > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/include/linux/platform_device.h b/includ=
e/linux/platform_device.h
> > > > > > > > > > > index d422db6eec63..606533b88f44 100644
> > > > > > > > > > > --- a/include/linux/platform_device.h
> > > > > > > > > > > +++ b/include/linux/platform_device.h
> > > > > > > > > > > @@ -232,6 +232,7 @@ extern int platform_device_add_da=
ta(struct platform_device *pdev,
> > > > > > > > > > >  extern int platform_device_add(struct platform_devic=
e *pdev);
> > > > > > > > > > >  extern void platform_device_del(struct platform_devi=
ce *pdev);
> > > > > > > > > > >  extern void platform_device_put(struct platform_devi=
ce *pdev);
> > > > > > > > > > > +DEFINE_FREE(platform_device_put, struct platform_dev=
ice *, if (_T) platform_device_put(_T))
> > > > > > > > > > >
> > > > > > > > > > >  struct platform_driver {
> > > > > > > > > > >         int (*probe)(struct platform_device *);
> > > > > > > > > >
> > > > > > > > > > +CC Greg KH and Rafael.
> > > > > > > > > >
> > > > > > > > > > Makes sure to include them on v14 as this needs review =
from a driver core point
> > > > > > > > > > of view I think.
> > > > > > > > >
> > > > > > > > > Why is this needed for a platform device?  This feels lik=
e you will have
> > > > > > > > > to do more work to "keep" the reference on the normal pat=
h than you to
> > > > > > > > > today to release the reference on the error path, right? =
 Have a pointer
> > > > > > > > > to a patch that uses this?
> > > > > > > >
> > > > > > > > Ah, is it this one:
> > > > > > > >       https://lore.kernel.org/all/20241014164955.00003439@H=
uawei.com/
> > > > > > > > ?
> > > > > > > >
> > > > > > > > If so, no, that's an abuse of a platform device, don't do t=
hat, make a
> > > > > > > > REAL device on the bus that this device lives on.  If it do=
esn't live on
> > > > > > > > a real bus, then put it on the virtual bus but do NOT abuse=
 the platform
> > > > > > > > device layer for something like this.
> > > > > > >
> > > > > > > Ok.  Probably virtual bus it is then.  Rafael, what do you th=
ink makes sense
> > > > > > > for a 'feature' that is described only by an ACPI table (here=
 RAS2)?
> > > > > > > Kind of similar(ish) to say IORT.
> > > > > >
> > > > > > Good question.
> > > > > >
> > > > > > I guess it depends on whether or not there are any registers to=
 access
> > > > > > or AML to interact with.  If so, I think that a platform device=
 makes
> > > > > > sense.
> > > > >
> > > > > Unfortunately still a gray area I think.
> > > > >
> > > > > This does access mailbox memory addresses, but they are provided
> > > > > by an existing platform device, so maybe platform device for this
> > > > > device is still inappropriate :(
> > > > >
> > > > > What this uses is:
> > > > > PCC channel (mailbox in memory + doorbells, etc but that is indir=
ectly
> > > > > provided as a service via reference in ACPI to the PCCT table ent=
ry
> > > > > allowing this to find the mailbox device - which is a platform
> > > > > device drivers/mailbox/pcc.c).
> > > > > Because it's all spec defined content in the mailbox messages, we=
 don't
> > > > > have the more flexible (and newer I think) 'register' via operati=
on region
> > > > > stuff in AML.
> > > > >
> > > > > A wrinkle though.  The mailbox data is mapped into this driver vi=
a
> > > > > an acpi_os_ioremap() call.
> > > > >
> > > > > So I'm thinking we don't have a strong reason for a platform devi=
ce
> > > > > other than 'similarity' to other examples.  Never the strongest r=
eason!
> > > > >
> > > > > We'll explore alternatives and see what they end up looking like.
> > > > >
> > > > > Jonathan
> > > > >
> > > >
> > > > Greg,
> > > >
> > > > I'm struggling a little to figure out how you envision the virtual =
bus
> > > > working here.  So before we spend too much time implementing the wr=
ong thing
> > > > as it feels non trivial, let me check my understanding.
> > > >
> > > > Would this mean registering a ras2 bus via subsys_virtual_register(=
).
> > > > (Similar to done for memory tiers)
> > >
> > > It should show up under /sys/devices/virtual/ is what I mean.
> > >
> > > > On that we'd then add all the devices: one per RAS2 PCC descriptor =
(these
> > > > are one per independent feature). Each feature has its own mailbox =
sub
> > > > channel (via a reference to the PCC mailbox devices .
> > > > Typically you have one of these per feature type per numa node, but
> > > > that isn't guaranteed.  That will then need wiring up with bus->pro=
be() etc
> > > > so that the RAS2 edac feature drivers can find this later and bind =
to it to
> > > > register with edac etc.
> > > >
> > > > So spinning up a full new bus, to support this?  I'm not against th=
at.
> > >
> > > No, again, see how the stuff that shows up in /sys/devices/virtual
> > > works, that should be much simpler.
> > >
> > > But really, as this is a "bus", just make a new one.  I don't underst=
and
> > > why ACPI isn't creating your devices for you, as this is ACPI code,
> > > perhaps just fix that up instead?  That would make much more sense to
> > > me...
> >
> > Because it is a data-only table, not AML.
> >
> > It looks to me like this could be an auxiliary device, similar to the
> > Intel VSEC driver: see intel_vsec_add_aux() etc.
> >
>
> That was in the other branch of the thread abbreviated as auxbus.
> My concern with that approach is we have no parent device and the
> auxiliary bus is always described as being for sub parts of a
> compound device. In the intel_vsec case there is always a parent
> pci device or platform device.
>
> I don't think there is any functional requirement for a real parent,
> it just feels like abuse given the stated purpose of auxiliary bus.
> Greg, auxiliary bus or separate acpi_ras2 bus feel better to you?
>
> We'd need to parent it off something to avoid the check in
> auxiliary_device_init() + all devices should have a parent anyway.

Wouldn't that be the platform device providing the mailbox memory
addresses mentioned in one of the previous messages?

