Return-Path: <linux-edac+bounces-2053-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F86299D469
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 18:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E844928AD30
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 16:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A731C3025;
	Mon, 14 Oct 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0v0YUG9t"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE11C2439;
	Mon, 14 Oct 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922356; cv=none; b=hL7JvD0VPx8/I/8xVtrLFL7QGkp+JWvO0hNZn//IykzP+rOA6liDRYJ4PTCKKqULSko3Y3l2jIoMB4nGnr1MqrFJIzk45eRUF96ba0MtGT3wQvkhoebmr61BzCH2phZMobvRnN+WtuVKtzedwHBAb3Y4R/jNzrtwTMZ7D5MdQ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922356; c=relaxed/simple;
	bh=ihTjQMfT+HpJ1Yf30NWcPkihLJvrI6C5hJHvt+WDVNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPYvfuTvxrRna4ZR01lDZd5YFz7l7cdSZ9l5+Vu16loUw2Up8APpUIYJZlwcogB87ZMSFsOT3ezKFnKZeX4UTAavDb38fR6JR5g3cIF0bb83DtXkkGXGIrSX+ftS+8E3gOeUsbujfi709Byy6cU+F3ie4RntduVTvNAojo/bN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0v0YUG9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A1DC4CEC3;
	Mon, 14 Oct 2024 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728922356;
	bh=ihTjQMfT+HpJ1Yf30NWcPkihLJvrI6C5hJHvt+WDVNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0v0YUG9tKk8CPFe1ByE0w3apGT0w+Cj1c0RH5p3Da8JSiHBhHn33V28LNnNLqiIeq
	 zjnCVz9/ZW8S6NUNgtP9iI9MVPanVxwZ9TNiGT+m0DUOj9VC+zqZptwrlNXJzd1tdA
	 nbb9b1h1qeqSAXkkUgigFfRHc0cUPp1LVabDvu94=
Date: Mon, 14 Oct 2024 18:04:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, bp@alien8.de,
	tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org,
	mchehab@kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, david@redhat.com,
	Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	linuxarm@huawei.com
Subject: Re: [PATCH v13 12/18] platform: Add __free() based cleanup function
 for platform_device_put
Message-ID: <2024101451-reword-animation-2179@gregkh>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
 <20241009124120.1124-13-shiju.jose@huawei.com>
 <20241014164339.00003e73@Huawei.com>
 <2024101410-turf-junior-7739@gregkh>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024101410-turf-junior-7739@gregkh>

On Mon, Oct 14, 2024 at 06:00:51PM +0200, Greg KH wrote:
> On Mon, Oct 14, 2024 at 04:43:39PM +0100, Jonathan Cameron wrote:
> > On Wed, 9 Oct 2024 13:41:13 +0100
> > <shiju.jose@huawei.com> wrote:
> > 
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Add __free() based cleanup function for platform_device_put().
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > > ---
> > >  include/linux/platform_device.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> > > index d422db6eec63..606533b88f44 100644
> > > --- a/include/linux/platform_device.h
> > > +++ b/include/linux/platform_device.h
> > > @@ -232,6 +232,7 @@ extern int platform_device_add_data(struct platform_device *pdev,
> > >  extern int platform_device_add(struct platform_device *pdev);
> > >  extern void platform_device_del(struct platform_device *pdev);
> > >  extern void platform_device_put(struct platform_device *pdev);
> > > +DEFINE_FREE(platform_device_put, struct platform_device *, if (_T) platform_device_put(_T))
> > >  
> > >  struct platform_driver {
> > >  	int (*probe)(struct platform_device *);
> > 
> > +CC Greg KH and Rafael.
> > 
> > Makes sure to include them on v14 as this needs review from a driver core point
> > of view I think.
> 
> Why is this needed for a platform device?  This feels like you will have
> to do more work to "keep" the reference on the normal path than you to
> today to release the reference on the error path, right?  Have a pointer
> to a patch that uses this?

Ah, is it this one:
	https://lore.kernel.org/all/20241014164955.00003439@Huawei.com/
?

If so, no, that's an abuse of a platform device, don't do that, make a
REAL device on the bus that this device lives on.  If it doesn't live on
a real bus, then put it on the virtual bus but do NOT abuse the platform
device layer for something like this.

thanks,

greg k-h

