Return-Path: <linux-edac+bounces-2076-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E045999EDF8
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 15:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC6F2869AD
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF77227BB6;
	Tue, 15 Oct 2024 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETB4zcJ1"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B404227BB0;
	Tue, 15 Oct 2024 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999470; cv=none; b=ahxmGzXNWT0dkxbSrlALmXqY7rjbmzLIVRvpB4UIWENFH8rjwCrnC2PEKfjuc3DnxnBCjmbfarYIGMWV9H63qgduS3W9fDjeTxID8XXVUlMQGhqQV8Cj6TY/zMvwN/hrq2LAeM4OgZRTBTLwXS4kMesDhb7wqnkaqgLBJ3QXBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999470; c=relaxed/simple;
	bh=0lvh4hdmAOb0s83k6vRo9pwBzqdkcx+VSvXBxzdAwRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRg2G7K5RLgtqdUSN53fywfdhM5XhslYf7r+/aoXFA7mIgr4d1W1zBE1zWV9Jj1++UKkY7Rgto6Y7FhzYIMws0PW/BQLTGdvUDvsK+Ly/PB+RhvPyn3dk7FeeDcXIMRnif7sxy7zEkKAykv6AfTtcz63+4ImH3W4c6ejO7xAMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETB4zcJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D98C4CECE;
	Tue, 15 Oct 2024 13:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728999469;
	bh=0lvh4hdmAOb0s83k6vRo9pwBzqdkcx+VSvXBxzdAwRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ETB4zcJ1bvQRIrZfCBt/w7Dc7v09G+KDOEM7YA4g1rZeu3T+oRmH729LpkIJVyRrp
	 TKWzd8XULvEqZs8Cs7RueHcOrDG1bRcl9CsJ/G53W921B1+FCaTd7etqPafMQlAI0F
	 ib1oBpW41pJegIROlzO+OLuAWgdgYvDh9dot00AOBkeIuy2X2pRb4KuI75dNMm3YaB
	 PKyHbRIBBhJ81yitlfck0J8ZWBasEmNmcgxAbnCFKDFuFRHNLa/MAj6RyrO8gI7htp
	 ojSbErckGxeUdLcaSzMJSYwi3eqYbzz1Fp+7CvxDRrqTs2c2DOWLf89K/2qzMJPY1Z
	 x28xzBhSZpQAw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-288c7567f5dso626526fac.1;
        Tue, 15 Oct 2024 06:37:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVspd9qius50R6OeIgjrFOLM6HI5HLKE5uHAdwDsnRnH6AhXLg1a5aJv+YBRM0fXiKrIM4xE0B9g5ir@vger.kernel.org, AJvYcCWc+RE60Om/5lrN88dAstbsiBtt4qjitAJ7NIkc9tk1/j9/BeEvrO4fkp+sm5NIEX8rpvFhr3miYi4Gt7U2@vger.kernel.org, AJvYcCXMjd6ub4K6+GRJZp2ubvL39+1AvW9IZF7DL0Qev7XsJFeiBX1fyWOXPQaxc8V8Ws6gnTmFBwssMDgw@vger.kernel.org, AJvYcCXYEO5vlC7P/lyeqo3qjOhnc+Gm137wD2mcm+A9hj616/7auMmz/rD14fJUgVpsiTw+pn3CwALkM4dogg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrwAN59zKSF2loFc225Raud3vYCh4ueOvkAlMLgNEyZiRp0ZxH
	lrXfB1TSUcpJf80D7hwKlAS7KndwCiGoJ4SnuEHu6+hE8yTt0OxYxZO+LV91TVpMQUBphW7NvZ0
	J5dtoMLTPXnxMyll2lK/3SNHrNVY=
X-Google-Smtp-Source: AGHT+IHfAX/cxRLnscOYJv3CtQRPKm7/cRU8i/lagw3N7aaUlIjeOz1E8fXmGihj25bXbFeQaFWbA5ocgWv+38FeYL4=
X-Received: by 2002:a05:6871:14f:b0:287:4904:7125 with SMTP id
 586e51a60fabf-288ede0f330mr289191fac.14.1728999469127; Tue, 15 Oct 2024
 06:37:49 -0700 (PDT)
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
 <2024101517-bubbling-deploy-1be0@gregkh> <20241015143426.00002e5b@Huawei.com>
In-Reply-To: <20241015143426.00002e5b@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Oct 2024 15:37:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gecxs3fMi7tHz9bLBEjTRqv_Fh0iTC4BM30C8zvRMRog@mail.gmail.com>
Message-ID: <CAJZ5v0gecxs3fMi7tHz9bLBEjTRqv_Fh0iTC4BM30C8zvRMRog@mail.gmail.com>
Subject: Re: [PATCH v13 12/18] platform: Add __free() based cleanup function
 for platform_device_put
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linuxarm@huawei.com, 
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

On Tue, Oct 15, 2024 at 3:34=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 15 Oct 2024 12:17:25 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
>
> > On Tue, Oct 15, 2024 at 10:40:54AM +0100, Jonathan Cameron wrote:
> > > On Tue, 15 Oct 2024 10:10:25 +0100
> > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > >
> > > > On Mon, 14 Oct 2024 20:06:40 +0200
> > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > >
> > > > > On Mon, Oct 14, 2024 at 7:17=E2=80=AFPM Jonathan Cameron
> > > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > > >
> > > > > > On Mon, 14 Oct 2024 18:04:37 +0200
> > > > > > Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > > On Mon, Oct 14, 2024 at 06:00:51PM +0200, Greg KH wrote:
> > > > > > > > On Mon, Oct 14, 2024 at 04:43:39PM +0100, Jonathan Cameron =
wrote:
> > > > > > > > > On Wed, 9 Oct 2024 13:41:13 +0100
> > > > > > > > > <shiju.jose@huawei.com> wrote:
> > > > > > > > >
> > > > > > > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > > > > >
> > > > > > > > > > Add __free() based cleanup function for platform_device=
_put().
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawe=
i.com>
> > > > > > > > > > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > > > > > > > > > ---
> > > > > > > > > >  include/linux/platform_device.h | 1 +
> > > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/include/linux/platform_device.h b/include/=
linux/platform_device.h
> > > > > > > > > > index d422db6eec63..606533b88f44 100644
> > > > > > > > > > --- a/include/linux/platform_device.h
> > > > > > > > > > +++ b/include/linux/platform_device.h
> > > > > > > > > > @@ -232,6 +232,7 @@ extern int platform_device_add_data=
(struct platform_device *pdev,
> > > > > > > > > >  extern int platform_device_add(struct platform_device =
*pdev);
> > > > > > > > > >  extern void platform_device_del(struct platform_device=
 *pdev);
> > > > > > > > > >  extern void platform_device_put(struct platform_device=
 *pdev);
> > > > > > > > > > +DEFINE_FREE(platform_device_put, struct platform_devic=
e *, if (_T) platform_device_put(_T))
> > > > > > > > > >
> > > > > > > > > >  struct platform_driver {
> > > > > > > > > >         int (*probe)(struct platform_device *);
> > > > > > > > >
> > > > > > > > > +CC Greg KH and Rafael.
> > > > > > > > >
> > > > > > > > > Makes sure to include them on v14 as this needs review fr=
om a driver core point
> > > > > > > > > of view I think.
> > > > > > > >
> > > > > > > > Why is this needed for a platform device?  This feels like =
you will have
> > > > > > > > to do more work to "keep" the reference on the normal path =
than you to
> > > > > > > > today to release the reference on the error path, right?  H=
ave a pointer
> > > > > > > > to a patch that uses this?
> > > > > > >
> > > > > > > Ah, is it this one:
> > > > > > >       https://lore.kernel.org/all/20241014164955.00003439@Hua=
wei.com/
> > > > > > > ?
> > > > > > >
> > > > > > > If so, no, that's an abuse of a platform device, don't do tha=
t, make a
> > > > > > > REAL device on the bus that this device lives on.  If it does=
n't live on
> > > > > > > a real bus, then put it on the virtual bus but do NOT abuse t=
he platform
> > > > > > > device layer for something like this.
> > > > > >
> > > > > > Ok.  Probably virtual bus it is then.  Rafael, what do you thin=
k makes sense
> > > > > > for a 'feature' that is described only by an ACPI table (here R=
AS2)?
> > > > > > Kind of similar(ish) to say IORT.
> > > > >
> > > > > Good question.
> > > > >
> > > > > I guess it depends on whether or not there are any registers to a=
ccess
> > > > > or AML to interact with.  If so, I think that a platform device m=
akes
> > > > > sense.
> > > >
> > > > Unfortunately still a gray area I think.
> > > >
> > > > This does access mailbox memory addresses, but they are provided
> > > > by an existing platform device, so maybe platform device for this
> > > > device is still inappropriate :(
> > > >
> > > > What this uses is:
> > > > PCC channel (mailbox in memory + doorbells, etc but that is indirec=
tly
> > > > provided as a service via reference in ACPI to the PCCT table entry
> > > > allowing this to find the mailbox device - which is a platform
> > > > device drivers/mailbox/pcc.c).
> > > > Because it's all spec defined content in the mailbox messages, we d=
on't
> > > > have the more flexible (and newer I think) 'register' via operation=
 region
> > > > stuff in AML.
> > > >
> > > > A wrinkle though.  The mailbox data is mapped into this driver via
> > > > an acpi_os_ioremap() call.
> > > >
> > > > So I'm thinking we don't have a strong reason for a platform device
> > > > other than 'similarity' to other examples.  Never the strongest rea=
son!
> > > >
> > > > We'll explore alternatives and see what they end up looking like.
> > > >
> > > > Jonathan
> > > >
> > >
> > > Greg,
> > >
> > > I'm struggling a little to figure out how you envision the virtual bu=
s
> > > working here.  So before we spend too much time implementing the wron=
g thing
> > > as it feels non trivial, let me check my understanding.
> > >
> > > Would this mean registering a ras2 bus via subsys_virtual_register().
> > > (Similar to done for memory tiers)
> >
> > It should show up under /sys/devices/virtual/ is what I mean.
> >
> > > On that we'd then add all the devices: one per RAS2 PCC descriptor (t=
hese
> > > are one per independent feature). Each feature has its own mailbox su=
b
> > > channel (via a reference to the PCC mailbox devices .
> > > Typically you have one of these per feature type per numa node, but
> > > that isn't guaranteed.  That will then need wiring up with bus->probe=
() etc
> > > so that the RAS2 edac feature drivers can find this later and bind to=
 it to
> > > register with edac etc.
> > >
> > > So spinning up a full new bus, to support this?  I'm not against that=
.
> >
> > No, again, see how the stuff that shows up in /sys/devices/virtual
> > works, that should be much simpler.
> >
> > But really, as this is a "bus", just make a new one.  I don't understan=
d
> > why ACPI isn't creating your devices for you, as this is ACPI code,
> > perhaps just fix that up instead?
>
> Filling in that registration gap was the purpose of the next patch.
>
> In all the similar cases that I can find where a static ACPI table is par=
sed
> (maybe Rafael can point at another) one of two things happen:
> 1) The table is parsed and platform devices are created for the entries f=
ound
>   (IORT etc) to which drivers later bind.
> 2) There is a 'fake' device in DSDT. E.g. ACPI0012 for NFIT, ACPI0017 for=
 CEDT
> (the CXL table) that are there to trigger enumeration of the static table=
 and
> those are done via device on the acpi bus.  That allows late enumeration =
and
> registration of devices with the appropriate classes etc.
>
> We'll explore the options but right now I'm thinking a new bus/acpi_ras2 =
is probably
> the way to go.

Have you looked at auxiliary devices?

