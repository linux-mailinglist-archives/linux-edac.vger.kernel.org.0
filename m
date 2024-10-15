Return-Path: <linux-edac+bounces-2073-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEB099E390
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 12:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BF71C221FD
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 10:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF281DAC89;
	Tue, 15 Oct 2024 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R1oIn4oH"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE8EC5;
	Tue, 15 Oct 2024 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987449; cv=none; b=qmHdo6HqPY4gB07yg6kIAC9BwhPRl4tUDRu51X/mUzcLRktmALkwMsKyHZmCyaN7vwndcCtNcusOmY1KISxmzL92P+OzZmrw4cZnarU4hFAziJmT2o7CCQH7KwbpKoMBiW4q13/wzcrW7cSxZDpjy3368RKoq2fZh+DbqF3Ns3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987449; c=relaxed/simple;
	bh=1XioJJa406lWyL8OF3hTMXDRkaQxQJuPtDiqIJLiZc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVjGzRT9N16siO0p2F4pIhsMWwJGBIdQKX6JUvgV3n7+WX80Kp0d0r9fIP5hFtkdeB187hHkjHOWfSHy9d4MQQuvAYzt17r1pgFDXv3alIPyE3bppjBtmtekdjpPepHk+EllY1r8o2wSdeScbF193VqXhllpQvIzziXf5U4RU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R1oIn4oH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F153FC4CEC6;
	Tue, 15 Oct 2024 10:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728987448;
	bh=1XioJJa406lWyL8OF3hTMXDRkaQxQJuPtDiqIJLiZc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R1oIn4oHXvuLthWWfMkDIUIE9b0m7QWC/zwa5yzcNb4hF3sxtk+62f3meEtAnkhY9
	 0RGB3CBufJ1vuVpQouiZoriGjbP0RuhutUDKiI4Bdw7NlFAtdKE5ScQg7EOPG/FxKY
	 vmg51dxsQDgi61h4T4Bd4vY6xPcfuTO7mF16imh4=
Date: Tue, 15 Oct 2024 12:17:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linuxarm@huawei.com,
	shiju.jose@huawei.com, linux-edac@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, bp@alien8.de,
	tony.luck@intel.com, lenb@kernel.org, mchehab@kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v13 12/18] platform: Add __free() based cleanup function
 for platform_device_put
Message-ID: <2024101517-bubbling-deploy-1be0@gregkh>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
 <20241009124120.1124-13-shiju.jose@huawei.com>
 <20241014164339.00003e73@Huawei.com>
 <2024101410-turf-junior-7739@gregkh>
 <2024101451-reword-animation-2179@gregkh>
 <20241014181654.00005180@Huawei.com>
 <CAJZ5v0j-mwZmuciSTaL8MyAp530y=n9HbQ=uVvcnvGLR1n+YuQ@mail.gmail.com>
 <20241015101025.00005305@Huawei.com>
 <20241015104021.00002906@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241015104021.00002906@huawei.com>

On Tue, Oct 15, 2024 at 10:40:54AM +0100, Jonathan Cameron wrote:
> On Tue, 15 Oct 2024 10:10:25 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Mon, 14 Oct 2024 20:06:40 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > 
> > > On Mon, Oct 14, 2024 at 7:17 PM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:
> > > >
> > > > On Mon, 14 Oct 2024 18:04:37 +0200
> > > > Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >  
> > > > > On Mon, Oct 14, 2024 at 06:00:51PM +0200, Greg KH wrote:  
> > > > > > On Mon, Oct 14, 2024 at 04:43:39PM +0100, Jonathan Cameron wrote:  
> > > > > > > On Wed, 9 Oct 2024 13:41:13 +0100
> > > > > > > <shiju.jose@huawei.com> wrote:
> > > > > > >  
> > > > > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > > >
> > > > > > > > Add __free() based cleanup function for platform_device_put().
> > > > > > > >
> > > > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > > > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > > > > > > > ---
> > > > > > > >  include/linux/platform_device.h | 1 +
> > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > >
> > > > > > > > diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> > > > > > > > index d422db6eec63..606533b88f44 100644
> > > > > > > > --- a/include/linux/platform_device.h
> > > > > > > > +++ b/include/linux/platform_device.h
> > > > > > > > @@ -232,6 +232,7 @@ extern int platform_device_add_data(struct platform_device *pdev,
> > > > > > > >  extern int platform_device_add(struct platform_device *pdev);
> > > > > > > >  extern void platform_device_del(struct platform_device *pdev);
> > > > > > > >  extern void platform_device_put(struct platform_device *pdev);
> > > > > > > > +DEFINE_FREE(platform_device_put, struct platform_device *, if (_T) platform_device_put(_T))
> > > > > > > >
> > > > > > > >  struct platform_driver {
> > > > > > > >         int (*probe)(struct platform_device *);  
> > > > > > >
> > > > > > > +CC Greg KH and Rafael.
> > > > > > >
> > > > > > > Makes sure to include them on v14 as this needs review from a driver core point
> > > > > > > of view I think.  
> > > > > >
> > > > > > Why is this needed for a platform device?  This feels like you will have
> > > > > > to do more work to "keep" the reference on the normal path than you to
> > > > > > today to release the reference on the error path, right?  Have a pointer
> > > > > > to a patch that uses this?  
> > > > >
> > > > > Ah, is it this one:
> > > > >       https://lore.kernel.org/all/20241014164955.00003439@Huawei.com/
> > > > > ?
> > > > >
> > > > > If so, no, that's an abuse of a platform device, don't do that, make a
> > > > > REAL device on the bus that this device lives on.  If it doesn't live on
> > > > > a real bus, then put it on the virtual bus but do NOT abuse the platform
> > > > > device layer for something like this.  
> > > >
> > > > Ok.  Probably virtual bus it is then.  Rafael, what do you think makes sense
> > > > for a 'feature' that is described only by an ACPI table (here RAS2)?
> > > > Kind of similar(ish) to say IORT.  
> > > 
> > > Good question.
> > > 
> > > I guess it depends on whether or not there are any registers to access
> > > or AML to interact with.  If so, I think that a platform device makes
> > > sense.
> > 
> > Unfortunately still a gray area I think.
> > 
> > This does access mailbox memory addresses, but they are provided
> > by an existing platform device, so maybe platform device for this
> > device is still inappropriate :(
> > 
> > What this uses is:
> > PCC channel (mailbox in memory + doorbells, etc but that is indirectly
> > provided as a service via reference in ACPI to the PCCT table entry
> > allowing this to find the mailbox device - which is a platform
> > device drivers/mailbox/pcc.c).
> > Because it's all spec defined content in the mailbox messages, we don't
> > have the more flexible (and newer I think) 'register' via operation region
> > stuff in AML.
> > 
> > A wrinkle though.  The mailbox data is mapped into this driver via
> > an acpi_os_ioremap() call.  
> > 
> > So I'm thinking we don't have a strong reason for a platform device
> > other than 'similarity' to other examples.  Never the strongest reason!
> > 
> > We'll explore alternatives and see what they end up looking like.
> > 
> > Jonathan
> > 
> 
> Greg,
> 
> I'm struggling a little to figure out how you envision the virtual bus
> working here.  So before we spend too much time implementing the wrong thing
> as it feels non trivial, let me check my understanding.
> 
> Would this mean registering a ras2 bus via subsys_virtual_register().
> (Similar to done for memory tiers)

It should show up under /sys/devices/virtual/ is what I mean.

> On that we'd then add all the devices: one per RAS2 PCC descriptor (these
> are one per independent feature). Each feature has its own mailbox sub
> channel (via a reference to the PCC mailbox devices .
> Typically you have one of these per feature type per numa node, but
> that isn't guaranteed.  That will then need wiring up with bus->probe() etc
> so that the RAS2 edac feature drivers can find this later and bind to it to
> register with edac etc.
> 
> So spinning up a full new bus, to support this?  I'm not against that.

No, again, see how the stuff that shows up in /sys/devices/virtual
works, that should be much simpler.

But really, as this is a "bus", just make a new one.  I don't understand
why ACPI isn't creating your devices for you, as this is ACPI code,
perhaps just fix that up instead?  That would make much more sense to
me...

thanks,

greg k-h

