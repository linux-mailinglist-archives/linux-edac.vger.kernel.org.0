Return-Path: <linux-edac+bounces-2061-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A1C99D568
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 19:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14889B20CF4
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 17:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2C11AB6DA;
	Mon, 14 Oct 2024 17:17:02 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D845A29A0;
	Mon, 14 Oct 2024 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926222; cv=none; b=MitvxvdxKWT2schBe8Gyq04IjrBAO1uOpL20bWIpcB4gyqr7QrpImtcRT/sbmFOFUXMHOcBTrapT6g05hZiV84GV1YXTcaGdYalfIIoLFKNZ9kM4D8+QEgUkmvxfwaXFY9DDV4s4LR5lYJs1AAxvRl2biX1DzOmeWJKudC/J6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926222; c=relaxed/simple;
	bh=XCeA+5nUpigSV09HFAGPYtOx2/NeR3ALQlw3vYP/wjE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/DHLrVU3Rb5CQFm6GUOowGKUA/yiFVKw4mMlZwjXaPoHgLjNxAD6755479acx7R6W7iN5vbiYcNRWGBAwko8RzQu6EZD8RniOKftNOXzM8zBgiSS6EYc7g/fBgUsks4mnarQerkRRRSQpyrhbOnSeWAGatvoCljGRtDO/LBzl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS3mS5pQJz6HJpx;
	Tue, 15 Oct 2024 01:16:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 43E88140CF4;
	Tue, 15 Oct 2024 01:16:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 19:16:55 +0200
Date: Mon, 14 Oct 2024 18:16:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <shiju.jose@huawei.com>, <linux-edac@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<mchehab@kernel.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
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
Message-ID: <20241014181654.00005180@Huawei.com>
In-Reply-To: <2024101451-reword-animation-2179@gregkh>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-13-shiju.jose@huawei.com>
	<20241014164339.00003e73@Huawei.com>
	<2024101410-turf-junior-7739@gregkh>
	<2024101451-reword-animation-2179@gregkh>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Oct 2024 18:04:37 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Oct 14, 2024 at 06:00:51PM +0200, Greg KH wrote:
> > On Mon, Oct 14, 2024 at 04:43:39PM +0100, Jonathan Cameron wrote:  
> > > On Wed, 9 Oct 2024 13:41:13 +0100
> > > <shiju.jose@huawei.com> wrote:
> > >   
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > 
> > > > Add __free() based cleanup function for platform_device_put().
> > > > 
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > > > ---
> > > >  include/linux/platform_device.h | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> > > > index d422db6eec63..606533b88f44 100644
> > > > --- a/include/linux/platform_device.h
> > > > +++ b/include/linux/platform_device.h
> > > > @@ -232,6 +232,7 @@ extern int platform_device_add_data(struct platform_device *pdev,
> > > >  extern int platform_device_add(struct platform_device *pdev);
> > > >  extern void platform_device_del(struct platform_device *pdev);
> > > >  extern void platform_device_put(struct platform_device *pdev);
> > > > +DEFINE_FREE(platform_device_put, struct platform_device *, if (_T) platform_device_put(_T))
> > > >  
> > > >  struct platform_driver {
> > > >  	int (*probe)(struct platform_device *);  
> > > 
> > > +CC Greg KH and Rafael.
> > > 
> > > Makes sure to include them on v14 as this needs review from a driver core point
> > > of view I think.  
> > 
> > Why is this needed for a platform device?  This feels like you will have
> > to do more work to "keep" the reference on the normal path than you to
> > today to release the reference on the error path, right?  Have a pointer
> > to a patch that uses this?  
> 
> Ah, is it this one:
> 	https://lore.kernel.org/all/20241014164955.00003439@Huawei.com/
> ?
> 
> If so, no, that's an abuse of a platform device, don't do that, make a
> REAL device on the bus that this device lives on.  If it doesn't live on
> a real bus, then put it on the virtual bus but do NOT abuse the platform
> device layer for something like this.

Ok.  Probably virtual bus it is then.  Rafael, what do you think makes sense
for a 'feature' that is described only by an ACPI table (here RAS2)?
Kind of similar(ish) to say IORT.

My thinking on a platform device was that this could be described
in DSDT and would have ended up as one. No idea why it isn't.
Maybe it predated the resource stuff that lets you use PCC channels
from methods under devices. Anyhow, it's not something I care about
so virtual bus is fine by me.

Jonathan


> 
> thanks,
> 
> greg k-h
> 


