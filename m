Return-Path: <linux-edac+bounces-2070-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546EA99E26A
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 11:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D882E1F2296C
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 09:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D631E5021;
	Tue, 15 Oct 2024 09:10:34 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2721CFECF;
	Tue, 15 Oct 2024 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983434; cv=none; b=tU6tXgY/1WM24+P6niRRbvVXWTCvyDWvS+3myusLAi4WaeXcyd/QNFYRn3hcyQDoQkhJ1r3vY59wLhbjjswoM3GE3UA3XsFSAZfoS2RQJpNrmRupRSZ20oxA1ye5bJrpn0W92NDIlDqTyom4hJ4+ycgDrW1r3aA4G4qvGvPqeAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983434; c=relaxed/simple;
	bh=ZPIoCpxu67xAOL3ntfDBE9PLJHmZbiNck7d5LLVG9ss=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0+g5T9TOIfc4L4ihFIULaFtSHsSeR0AvkvsCGH5ZO/SCjjV//hfC6ujI2Kj0Mpe66Vg6Kh4E3vubaoe5Ux2eOjjcj7a0bBCW1zoSekbIRm0mkVLHkeBYGLEpGReWKzRDRqFHEhI03lX/ntzM/Gg5HEKXPMAb0KgG8U7nmyi90Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XSSwf4c5Rz6K93g;
	Tue, 15 Oct 2024 17:09:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A73B7140AA7;
	Tue, 15 Oct 2024 17:10:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Oct
 2024 11:10:27 +0200
Date: Tue, 15 Oct 2024 10:10:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Greg KH <gregkh@linuxfoundation.org>, <shiju.jose@huawei.com>,
	<linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <david@redhat.com>,
	<Vilas.Sridharan@amd.com>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<rientjes@google.com>, <jiaqiyan@google.com>, <Jon.Grimm@amd.com>,
	<dave.hansen@linux.intel.com>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v13 12/18] platform: Add __free() based cleanup function
 for platform_device_put
Message-ID: <20241015101025.00005305@Huawei.com>
In-Reply-To: <CAJZ5v0j-mwZmuciSTaL8MyAp530y=n9HbQ=uVvcnvGLR1n+YuQ@mail.gmail.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-13-shiju.jose@huawei.com>
	<20241014164339.00003e73@Huawei.com>
	<2024101410-turf-junior-7739@gregkh>
	<2024101451-reword-animation-2179@gregkh>
	<20241014181654.00005180@Huawei.com>
	<CAJZ5v0j-mwZmuciSTaL8MyAp530y=n9HbQ=uVvcnvGLR1n+YuQ@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Oct 2024 20:06:40 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Mon, Oct 14, 2024 at 7:17=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Mon, 14 Oct 2024 18:04:37 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> > =20
> > > On Mon, Oct 14, 2024 at 06:00:51PM +0200, Greg KH wrote: =20
> > > > On Mon, Oct 14, 2024 at 04:43:39PM +0100, Jonathan Cameron wrote: =
=20
> > > > > On Wed, 9 Oct 2024 13:41:13 +0100
> > > > > <shiju.jose@huawei.com> wrote:
> > > > > =20
> > > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > >
> > > > > > Add __free() based cleanup function for platform_device_put().
> > > > > >
> > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > > > > > ---
> > > > > >  include/linux/platform_device.h | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/include/linux/platform_device.h b/include/linux/pl=
atform_device.h
> > > > > > index d422db6eec63..606533b88f44 100644
> > > > > > --- a/include/linux/platform_device.h
> > > > > > +++ b/include/linux/platform_device.h
> > > > > > @@ -232,6 +232,7 @@ extern int platform_device_add_data(struct =
platform_device *pdev,
> > > > > >  extern int platform_device_add(struct platform_device *pdev);
> > > > > >  extern void platform_device_del(struct platform_device *pdev);
> > > > > >  extern void platform_device_put(struct platform_device *pdev);
> > > > > > +DEFINE_FREE(platform_device_put, struct platform_device *, if =
(_T) platform_device_put(_T))
> > > > > >
> > > > > >  struct platform_driver {
> > > > > >         int (*probe)(struct platform_device *); =20
> > > > >
> > > > > +CC Greg KH and Rafael.
> > > > >
> > > > > Makes sure to include them on v14 as this needs review from a dri=
ver core point
> > > > > of view I think. =20
> > > >
> > > > Why is this needed for a platform device?  This feels like you will=
 have
> > > > to do more work to "keep" the reference on the normal path than you=
 to
> > > > today to release the reference on the error path, right?  Have a po=
inter
> > > > to a patch that uses this? =20
> > >
> > > Ah, is it this one:
> > >       https://lore.kernel.org/all/20241014164955.00003439@Huawei.com/
> > > ?
> > >
> > > If so, no, that's an abuse of a platform device, don't do that, make a
> > > REAL device on the bus that this device lives on.  If it doesn't live=
 on
> > > a real bus, then put it on the virtual bus but do NOT abuse the platf=
orm
> > > device layer for something like this. =20
> >
> > Ok.  Probably virtual bus it is then.  Rafael, what do you think makes =
sense
> > for a 'feature' that is described only by an ACPI table (here RAS2)?
> > Kind of similar(ish) to say IORT. =20
>=20
> Good question.
>=20
> I guess it depends on whether or not there are any registers to access
> or AML to interact with.  If so, I think that a platform device makes
> sense.

Unfortunately still a gray area I think.

This does access mailbox memory addresses, but they are provided
by an existing platform device, so maybe platform device for this
device is still inappropriate :(

What this uses is:
PCC channel (mailbox in memory + doorbells, etc but that is indirectly
provided as a service via reference in ACPI to the PCCT table entry
allowing this to find the mailbox device - which is a platform
device drivers/mailbox/pcc.c).
Because it's all spec defined content in the mailbox messages, we don't
have the more flexible (and newer I think) 'register' via operation region
stuff in AML.

A wrinkle though.  The mailbox data is mapped into this driver via
an acpi_os_ioremap() call. =20

So I'm thinking we don't have a strong reason for a platform device
other than 'similarity' to other examples.  Never the strongest reason!

We'll explore alternatives and see what they end up looking like.

Jonathan



>=20
> > My thinking on a platform device was that this could be described
> > in DSDT and would have ended up as one. No idea why it isn't.
> > Maybe it predated the resource stuff that lets you use PCC channels
> > from methods under devices. Anyhow, it's not something I care about
> > so virtual bus is fine by me. =20
>=20


