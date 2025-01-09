Return-Path: <linux-edac+bounces-2855-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2269EA07CBF
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 17:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BA13A2A34
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141B421A45B;
	Thu,  9 Jan 2025 16:02:14 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258AF39AEB;
	Thu,  9 Jan 2025 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438534; cv=none; b=TqkSqJTb383n8sC1oeQhs5YI+uimw1G4pviw9GI1C5AmxSsqI2vFZhe21+fwSS7t9o39Bdh0Kp9N2sLDgkrecfIM+z86ER2sL1rsuAuiZMSR0I1KQwwe67P3ePtt0HQ52kJabIdWt5dPRRWtQE9LSNMEajGoKDmMt6U0fjl6wrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438534; c=relaxed/simple;
	bh=SwK6RCyFhO2gmnSlKKV7GmMT80VU5090A9fic0BSHkQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nB0ziKFeUvd1fr80+BH4WZdN6t1SZrsxQ5q8bvVeYg52sx5Wh/NmDJNfE8psJ9yJz/mtkvBavdVPE9uUv8vpogWfrxk8phUrYDl4Ko34DI3ZSJUJC6W/KFYUphR/COSXvcbCpVNnoAPJwVGJQ21mF/s3quedsFGDDDOGp7KoDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YTTv74rVcz6JBCB;
	Thu,  9 Jan 2025 23:57:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 467541403A2;
	Fri, 10 Jan 2025 00:02:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 9 Jan
 2025 17:02:00 +0100
Date: Thu, 9 Jan 2025 16:01:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: Shiju Jose <shiju.jose@huawei.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250109160159.00002add@huawei.com>
In-Reply-To: <20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-5-shiju.jose@huawei.com>
	<20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
	<3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>
	<20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
	<20250109142433.00004ea7@huawei.com>
	<20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 9 Jan 2025 16:18:54 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Jan 09, 2025 at 02:24:33PM +0000, Jonathan Cameron wrote:
> > To my thinking that would fail the test of being an intuitive interface.
> > To issue a repair command requires that multiple attributes be configured
> > before triggering the actual repair.
> > 
> > Think of it as setting the coordinates of the repair in a high dimensional
> > space.  
> 
> Why?

Ok. To me the fact it's not a single write was relevant. Seems not
in your mental model of how this works.  For me a single write
that you cannot query back is fine, setting lots of parameters and
being unable to query any of them less so.  I guess you disagree.
In interests of progress I'm not going to argue further. No one is
going to use this interface by hand anyway so the lost of useability
I'm seeing doesn't matter a lot.

> 
> You can write every attribute in its separate file and have a "commit" or
> "start" file which does that.

That's what we have.

> 
> Or you can designate a file which starts the process. This is how I'm
> injecting errors on x86:
> 
> see readme_msg here: arch/x86/kernel/cpu/mce/inject.c
> 
> More specifically:
> 
> "flags:\t Injection type to be performed. Writing to this file will trigger a\n"
> "\t real machine check, an APIC interrupt or invoke the error decoder routines\n"
> "\t for AMD processors.\n"
> 
> So you set everything else, and as the last step you set the injection type
> *and* you also trigger it with this one write.

Agreed. I'm not sure of the relevance though. This is how it works and
there is no proposal to change that.  

What I was trying to argue was for an interface that let you set all the
coordinates and read back what they were before hitting go. 

> 
> > Sure. In this case the addition of min/max was perhaps a wrong response to
> > your request for a way to those ranges rather than just rejecting a write
> > of something out of range as earlier version did.
> > 
> > We can revisit in future if range discovery becomes necessary.  Personally
> > I don't think it is given we are only taking these actions in response error
> > records that give us precisely what to write and hence are always in range.  
> 
> My goal here was to make this user-friendly. Because you need some way of
> knowing what valid ranges are and in order to trigger the repair, if it needs
> to happen for a range.

In at least the CXL case I'm fairly sure most of them are not discoverable.
Until you see errors you have no idea what the memory topology is.

> 
> Or, you can teach the repair logic to ignore invalid ranges and "clamp" things
> to whatever makes sense.

For that you'd need to have a path to read back what happened.

> 
> Again, I'm looking at it from the usability perspective. I haven't actually
> needed this scrub+repair functionality yet to know whether the UI makes sense.
> So yeah, collecting some feedback from real-life use cases would probably give
> you a lot better understanding of how that UI should be designed... perhaps
> you won't ever need the ranges, whow knows.
> 
> So yes, preemptively designing stuff like that "in the dark" is kinda hard.
> :-)

The discoverability is unnecessary for any known usecase.

Ok. Then can we just drop the range discoverability entirely or we go with
your suggestion and do not support read back of what has been
requested but instead have the reads return a range if known or "" /
return -EONOTSUPP if simply not known?


I can live with that though to me we are heading in the direction of
a less intuitive interface to save a small number of additional files.

Jonathan

> 


