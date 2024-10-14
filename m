Return-Path: <linux-edac+bounces-2052-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADFC99D467
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 18:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BEB28A971
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 16:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AA81BFDF4;
	Mon, 14 Oct 2024 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="On9u0jL1"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B01D1ADFFC;
	Mon, 14 Oct 2024 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922353; cv=none; b=DnqF7HZuwXHYEfArrpgDcV+2RlAggbp4QabqoIaIegm0X9B1lw8UMTS/ZBdY/ok5LV8rOmXkMzX5YHaQhe1jVBJcX9Kcxkq5N9a7TJruWq8RX8UZBBKf63vpSaUYd9zA5XzXBGrs+F+8csgkIqHyCR9pL8dKxnCxx/xV7wJDWVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922353; c=relaxed/simple;
	bh=Y3hE47/OK0BbVre1jFls3lsPiQKWx6O6pmGYIV+KlSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG/cz40h+gbGmMr0/iwFigFqbL24BV1zGvn5me/vG1/IR8MPuNhTTqheaz8hW6ciwD4meHBACp4hRi/NeVWA0eqVQ81fe06dyuD7aILGvkVBld1iZ4Q0YDnVUsQaA6Eh0++p9pfwamNc0KJX7qx/+SwKwDZwOGK7t0gGfVYWFU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=On9u0jL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C26C4CEC3;
	Mon, 14 Oct 2024 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728922353;
	bh=Y3hE47/OK0BbVre1jFls3lsPiQKWx6O6pmGYIV+KlSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=On9u0jL1Dfv0hs+NKB8/Ct7P2koqbBYUEuOz4NZVBfS2st6MOFLVyLqQrOGtC1q9R
	 EcwUfp8FvPednLGua1jBua734B5mM1ZbRlh70dkzI8wsmYmj/nyYjmWphrgyj1NeHb
	 nXaGB1+7BSzxuJuJV7TWZIq8wwPXr4h8DevEZOHg=
Date: Mon, 14 Oct 2024 18:00:51 +0200
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
Message-ID: <2024101410-turf-junior-7739@gregkh>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
 <20241009124120.1124-13-shiju.jose@huawei.com>
 <20241014164339.00003e73@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014164339.00003e73@Huawei.com>

On Mon, Oct 14, 2024 at 04:43:39PM +0100, Jonathan Cameron wrote:
> On Wed, 9 Oct 2024 13:41:13 +0100
> <shiju.jose@huawei.com> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Add __free() based cleanup function for platform_device_put().
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > ---
> >  include/linux/platform_device.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> > index d422db6eec63..606533b88f44 100644
> > --- a/include/linux/platform_device.h
> > +++ b/include/linux/platform_device.h
> > @@ -232,6 +232,7 @@ extern int platform_device_add_data(struct platform_device *pdev,
> >  extern int platform_device_add(struct platform_device *pdev);
> >  extern void platform_device_del(struct platform_device *pdev);
> >  extern void platform_device_put(struct platform_device *pdev);
> > +DEFINE_FREE(platform_device_put, struct platform_device *, if (_T) platform_device_put(_T))
> >  
> >  struct platform_driver {
> >  	int (*probe)(struct platform_device *);
> 
> +CC Greg KH and Rafael.
> 
> Makes sure to include them on v14 as this needs review from a driver core point
> of view I think.

Why is this needed for a platform device?  This feels like you will have
to do more work to "keep" the reference on the normal path than you to
today to release the reference on the error path, right?  Have a pointer
to a patch that uses this?

thanks,

greg k-h

