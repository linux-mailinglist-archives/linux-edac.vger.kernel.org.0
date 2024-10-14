Return-Path: <linux-edac+bounces-2063-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3060B99D621
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 20:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623C01C22187
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 18:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015D01C7608;
	Mon, 14 Oct 2024 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqw2IT6y"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DE085260;
	Mon, 14 Oct 2024 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929213; cv=none; b=APgTdvzUmi26JLKmno6R2xqRIfz++bkI7584nn15n2MzyqX5kQXomXSUGld8yoBwEsfVV4R2jLChWyq1oQHWOrf+KaMJwps8NPpBBxfF1MsyCtbtyD7VHehtr/c/iabM38nBK+/3ATWvq8y665rLbEHSejxGxype+bx/f2eFTH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929213; c=relaxed/simple;
	bh=328xf27GjivinbPRZ7hRzDtoHLMfZyHs/8hq0LBb480=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7ThTrgO4/RxyMArSDEat62KO4nqxQi67/MDDXIBSAFJSeGfSbGe/x1QjFvZlL1npNz0SoZE96V/qhC7fJgoXL4V2Rj3j/stzeKSPXNfYryiq3AeL2uVxeMCwW3qT6ooBRVFCu4p1yg3CwEAKam12qL1j2VGGUmm/rS5NiKVmgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqw2IT6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F79FC4CED9;
	Mon, 14 Oct 2024 18:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728929213;
	bh=328xf27GjivinbPRZ7hRzDtoHLMfZyHs/8hq0LBb480=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aqw2IT6yHheGJ7fz18ra7eVQ8O0cRQrNgKjHLslffeYq89nIvV9M3LebbF9D1CS2d
	 jx20LqApzwQAW6UMnCDzs7DlBfRt97swT330IXPpysEkfm4jHGMUeI4YGdy6M9DC8s
	 PxYmkDLKeTlNHjoI03bE+K50GV+GymRCcCSIECbFqaOVZ8R+2YcYGnxLF1F9BBZhF+
	 15iRHHbPyf7ZWfaEudEpMGqNg4AlIHFkebvkpfpweU0FTO0SeZUQ8sC6OWIDRqj02I
	 0ckHCDU0GFVpgaWJeklXzl/+/iQVMLS0Z4uC+85oOQdmHd0eh2iwUYdiGlAX6zAv5O
	 j5fkXaPR3O1gw==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e4d53fbe0dso2507176b6e.3;
        Mon, 14 Oct 2024 11:06:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyFIdaW7qs/iO1Fk2KqY9bNYn0vs67Yp0TPlIaGpI3jEZUr+jj3nQ47CCT90pSXylHLTL7AlLsY8Xp@vger.kernel.org, AJvYcCVY/dRivoJIxgMwuWMOwMwMXqJHnuDBmw/J+e6XfRdFN70bbxPvkR6gIIOuo8AFZMeylfAj8OfDbrw9@vger.kernel.org, AJvYcCWG4Jr1sHRQ1scUbOm8WF0kxSyWKMDY0GXvICyTUuhN7CVzHgZUKBqXCWaztrSgI7oBQlbOCrvai32pLWCy@vger.kernel.org, AJvYcCXCfNXEsjeP5gakSGe8O12ykMzxOLlBoOp8IrtBF6Uk0IKOR3lhmX0bVwbbukJNYwqKM5WXTlcRLCauBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpqwev5N0QEnYxZAc1kNnVREeVe1V4C/smZCrctZ5aN150IgRW
	8FACS/sxvPqqIWB38caCjYJJssb2JPkpDhAMwSmm+YEuHFopUH3U/TZw0QyPlljp8rbgZZi/F0e
	BX7mcUaJl8YlTc9fLTxkuPWaF4Qs=
X-Google-Smtp-Source: AGHT+IGQGwT6cXGmJK8qwoh50vsACcMeRbM+96UyfnnpM9FQSznkvhAcjB/uDWXvr+/SF+GzDS6sTWMArbOPvqmwa/o=
X-Received: by 2002:a05:6871:299:b0:260:e3fa:ab8d with SMTP id
 586e51a60fabf-28887477812mr5317452fac.37.1728929212580; Mon, 14 Oct 2024
 11:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009124120.1124-1-shiju.jose@huawei.com> <20241009124120.1124-13-shiju.jose@huawei.com>
 <20241014164339.00003e73@Huawei.com> <2024101410-turf-junior-7739@gregkh>
 <2024101451-reword-animation-2179@gregkh> <20241014181654.00005180@Huawei.com>
In-Reply-To: <20241014181654.00005180@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 14 Oct 2024 20:06:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j-mwZmuciSTaL8MyAp530y=n9HbQ=uVvcnvGLR1n+YuQ@mail.gmail.com>
Message-ID: <CAJZ5v0j-mwZmuciSTaL8MyAp530y=n9HbQ=uVvcnvGLR1n+YuQ@mail.gmail.com>
Subject: Re: [PATCH v13 12/18] platform: Add __free() based cleanup function
 for platform_device_put
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, shiju.jose@huawei.com, 
	linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bp@alien8.de, tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org, 
	mchehab@kernel.org, dan.j.williams@intel.com, dave@stgolabs.net, 
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com, 
	leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com, 
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com, 
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com, 
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com, 
	duenwen@google.com, gthelen@google.com, wschwartz@amperecomputing.com, 
	dferguson@amperecomputing.com, wbs@os.amperecomputing.com, 
	nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com, 
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 7:17=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 14 Oct 2024 18:04:37 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
>
> > On Mon, Oct 14, 2024 at 06:00:51PM +0200, Greg KH wrote:
> > > On Mon, Oct 14, 2024 at 04:43:39PM +0100, Jonathan Cameron wrote:
> > > > On Wed, 9 Oct 2024 13:41:13 +0100
> > > > <shiju.jose@huawei.com> wrote:
> > > >
> > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > >
> > > > > Add __free() based cleanup function for platform_device_put().
> > > > >
> > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > > > > ---
> > > > >  include/linux/platform_device.h | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/include/linux/platform_device.h b/include/linux/plat=
form_device.h
> > > > > index d422db6eec63..606533b88f44 100644
> > > > > --- a/include/linux/platform_device.h
> > > > > +++ b/include/linux/platform_device.h
> > > > > @@ -232,6 +232,7 @@ extern int platform_device_add_data(struct pl=
atform_device *pdev,
> > > > >  extern int platform_device_add(struct platform_device *pdev);
> > > > >  extern void platform_device_del(struct platform_device *pdev);
> > > > >  extern void platform_device_put(struct platform_device *pdev);
> > > > > +DEFINE_FREE(platform_device_put, struct platform_device *, if (_=
T) platform_device_put(_T))
> > > > >
> > > > >  struct platform_driver {
> > > > >         int (*probe)(struct platform_device *);
> > > >
> > > > +CC Greg KH and Rafael.
> > > >
> > > > Makes sure to include them on v14 as this needs review from a drive=
r core point
> > > > of view I think.
> > >
> > > Why is this needed for a platform device?  This feels like you will h=
ave
> > > to do more work to "keep" the reference on the normal path than you t=
o
> > > today to release the reference on the error path, right?  Have a poin=
ter
> > > to a patch that uses this?
> >
> > Ah, is it this one:
> >       https://lore.kernel.org/all/20241014164955.00003439@Huawei.com/
> > ?
> >
> > If so, no, that's an abuse of a platform device, don't do that, make a
> > REAL device on the bus that this device lives on.  If it doesn't live o=
n
> > a real bus, then put it on the virtual bus but do NOT abuse the platfor=
m
> > device layer for something like this.
>
> Ok.  Probably virtual bus it is then.  Rafael, what do you think makes se=
nse
> for a 'feature' that is described only by an ACPI table (here RAS2)?
> Kind of similar(ish) to say IORT.

Good question.

I guess it depends on whether or not there are any registers to access
or AML to interact with.  If so, I think that a platform device makes
sense.

> My thinking on a platform device was that this could be described
> in DSDT and would have ended up as one. No idea why it isn't.
> Maybe it predated the resource stuff that lets you use PCC channels
> from methods under devices. Anyhow, it's not something I care about
> so virtual bus is fine by me.

