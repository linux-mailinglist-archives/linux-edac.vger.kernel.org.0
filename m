Return-Path: <linux-edac+bounces-1034-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FD08C2340
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 13:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B0B284411
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 11:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E1B16E893;
	Fri, 10 May 2024 11:23:40 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782116EC0C;
	Fri, 10 May 2024 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340220; cv=none; b=sAP2i8NS4MwfD+GSwuxEQgC/XLzfMoKjHy5RcRSIzsoJBjputbpZaRVKb3NFvdkVFiqR8yg19EDRCyA5gdpGmtcDAgFD6k52u8vjXZjXW1JEu/ABCKimZVH3yupENyGW4vPKw9h+gQlED8xji8RtMu03Y36djILb49bUtFArkY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340220; c=relaxed/simple;
	bh=Lno1tWiY1+h5kAeqlxDHiicLEPlL2vfS2TjNN2jg2h4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BtFWesmlfsBhvU7DA750OWaCyfx3mC5FZcqL5bo1atlSqV4pKbJq+jKxhjT9xg8IwMsZiUcRBsi4s7zdNy5nevnfD8nGEd9cv6ByHHzA2Rzs/4jzxb0yI1rH3ofnzuP2PSClDqRcxkZQVaow6lfpsoJSDFL57glMNnWIrzf/dAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VbRM36936z6K9R3;
	Fri, 10 May 2024 19:22:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EF1A1140A77;
	Fri, 10 May 2024 19:23:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 10 May
 2024 12:23:27 +0100
Date: Fri, 10 May 2024 12:23:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v8 05/10] cxl/memscrub: Add CXL device patrol scrub
 control feature
Message-ID: <20240510122325.00005e83@Huawei.com>
In-Reply-To: <663d69c61db8c_3d7b4294e0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
	<20240419164720.1765-6-shiju.jose@huawei.com>
	<663d69c61db8c_3d7b4294e0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 9 May 2024 17:26:46 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> shiju.jose@ wrote:
> > From: Shiju Jose <shiju.jose@huawei.com>
> > 
> > CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
> > feature. The device patrol scrub proactively locates and makes corrections
> > to errors in regular cycle.
> > 
> > Allow specifying the number of hours within which the patrol scrub must be
> > completed, subject to minimum and maximum limits reported by the device.
> > Also allow disabling scrub allowing trade-off error rates against
> > performance.
> > 
> > Register with scrub subsystem to provide scrub control attributes to the
> > user.
> > 
> > Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>  
> [..]
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 0c79d9ce877c..399e43463626 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -117,6 +117,12 @@ static int cxl_mem_probe(struct device *dev)
> >  	if (!cxlds->media_ready)
> >  		return -EBUSY;
> >  
> > +	rc = cxl_mem_patrol_scrub_init(cxlmd);
> > +	if (rc) {
> > +		dev_dbg(&cxlmd->dev, "CXL patrol scrub init failed\n");
> > +		return rc;
> > +	}  
> 
> 2 concerns:
> 
> * Why should cxl_mem_probe() fail just because this optional
>   scrub interface did not register?
> 

Flip the dev_dbg to dev_warn() and indeed carry on.

> * Why is this not located in cxl_region_probe()? If the ras2 scrub is an
>   HPA-based scrub I think CXL should do the work to interface with the scrub
>   interface at the same level. This also provides another in-kernel user
>   for all the DPA-to-HPA translation infrastructure that the CXL driver
>   contains. Pretty much the only reason the CXL driver needs to exist at
>   all is address translation, so at a minimum it seems a waste to inflict
>   more need to understand DPAs on userspace.

As you might expect this will get messy - I'm not saying it's a bad thing
to do, but complexities that come to mind include:

* Scrub is device wide (unlike RAS2 which in theory supports HPA range control)
  So if you map a given DPA range into multiple regions then the controls
  will interfere.  Maybe scrub at max rate requested for any region is fine.
* Interleave - so we'd be controlling multiple hardware scrubbers.
* Comes and goes with regions.  Do we stop scrubbing if no region?  Not sure.

My guess is break down is:
1) Component registered for each CXL mem device to handle the control + combining
   of all regions specific requests.
2) Region specific component that exposes the controls on HPA basis, and
   requests from all it's CXL mem device drivers a minimum service level.
3) Device specific scrub instance (perhaps) reflecting that some scrub may
   make sense when not yet in a region (identify bad mem etc).

So I think we will end up with a lot more layering in here, but end result
will indeed be better.

This has been going on a while, so not sure the DPA to HPA stuff was all in place
and at the time I think was still an open question of whether that should be
a userspace problem or not.  Anyhow time to adapt :)

Jonathan




