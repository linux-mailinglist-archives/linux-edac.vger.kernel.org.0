Return-Path: <linux-edac+bounces-2857-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A846A07FD5
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 19:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CBA162732
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 18:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01D019922F;
	Thu,  9 Jan 2025 18:34:58 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B9813B2B8;
	Thu,  9 Jan 2025 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447698; cv=none; b=k9urQ4YQDyo+ehiTRi9xO+qWR0XzkFIOOndm7/6IqYSGguSEx6fx75Qc5jC2al5S8vxCldF+CavxAE1ReYpCdhs2u7/VlgSfzaan3iTF4+68VfWT+1SfeVIJv1XC5WWWHimn28xrDVA+odinxDYxpQYgIBEum6d/JMVUt1/hYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447698; c=relaxed/simple;
	bh=S54WHLS3HOplqLcg789znsO+qN6VM9K4pzw2t67YItQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1yiB+hnu2VTko0HGndXmESkbluWM5BFgmI2CkrtgackCyBmmJtMF8PacCAvhiQL2IdshPdi/e/9upGa/8WROqqzgmdAV8Nxkk0X+CAqs1Cb3ViFwewin1mDFz8EKApuUlG2fE1J1cbeiWupeH51OKp4Y4X92qAvC5ArsBItMyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YTYHT2wlcz6JBDN;
	Fri, 10 Jan 2025 02:30:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 482AC14038F;
	Fri, 10 Jan 2025 02:34:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 9 Jan
 2025 19:34:50 +0100
Date: Thu, 9 Jan 2025 18:34:48 +0000
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
Message-ID: <20250109183448.000059ec@huawei.com>
In-Reply-To: <20250109161902.GDZ3_29rH-sQMV4n0N@fat_crate.local>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-5-shiju.jose@huawei.com>
	<20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
	<3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>
	<20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
	<20250109142433.00004ea7@huawei.com>
	<20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
	<20250109160159.00002add@huawei.com>
	<20250109161902.GDZ3_29rH-sQMV4n0N@fat_crate.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 9 Jan 2025 17:19:02 +0100
Borislav Petkov <bp@alien8.de> wrote:
	
> On Thu, Jan 09, 2025 at 04:01:59PM +0000, Jonathan Cameron wrote:
> > Ok. To me the fact it's not a single write was relevant. Seems not
> > in your mental model of how this works.  For me a single write
> > that you cannot query back is fine, setting lots of parameters and
> > being unable to query any of them less so.  I guess you disagree.  
> 
> Why can't you query it back?
> 
> grep -r . /sysfs/dir/
> 
> All files' values have been previously set and should still be there on
> a read, I'd strongly hope. Your ->read routines should give the values back.

Today you can.  Seems we are talking cross purposes.

I'm confused. I thought your proposal was for "bank" attribute to present an
allowed range on read.
"bank" attribute is currently written to and read back as the value of the bank on which
to conduct a repair.  Maybe this disconnect is down to the fact max_ and min_
attributes should have been marked as RO in the docs. They aren't controls,
just presentation of limits to userspace.

Was intent a separate bank_range type attribute rather than max_bank, min_bank?
One of those would be absolutely fine (similar to the _available attributes
in IIO - I added those years ago to meet a similar need and we've never had
any issues with those).

> 
> > In interests of progress I'm not going to argue further. No one is
> > going to use this interface by hand anyway so the lost of useability
> > I'm seeing doesn't matter a lot.  
> 
> I had the suspicion that this user interface is not really going to be used by
> a user but by a tool. But then if you don't have a tool, you're lost.
> 
> This is one of the reasons why you can control ftrace directly on the shell
> too - without a tool. This is very useful in certain cases where you cannot
> run some userspace tools.

I fully agree. What I was saying was in response to me thinking you wanted it
to not be possible to read back the user set values (overlapping uses of
single bank attribute which wasn't what you meant). That is useful for a user
wanting to do the cat /sys/... that you mention above, but not vital if they are
directly reading the tracepoints for the error records and poking the
sysfs interface.

Given it seems I misunderstood that suggestion, ignore my reply to that
as irrelevant.
 
> 
> > In at least the CXL case I'm fairly sure most of them are not discoverable.
> > Until you see errors you have no idea what the memory topology is.  
> 
> Ok.
> 
> > For that you'd need to have a path to read back what happened.  
> 
> So how is this scrubbing going to work? You get an error, you parse it for all
> the attributes and you go and write those attributes into the scrub interface
> and it starts scrubbing?

Repair not scrubbing. They are different things we should keep separate,
scrub corrects the value, if it can, but doesn't change the underlying memory to
new memory cells to avoid repeated errors. Replacing scrub with repair 
(which I think was the intent here)...

You get error records that describe the error seen in hardware, write back the
values into this interface and tell it to repair the memory.  This is not
necessarily a synchronous or immediate thing - instead typically based on
trend analysis.

As an example, the decision might be that bit of ram threw up 3 errors
over a month including multiple system reboots (for other reasons) and
that is over some threshold so we use a spare memory line to replace it.

> 
> But then why do you even need the interface at all?
> 
> Why can't the kernel automatically collect all those attributes and start the
> scrubbing automatically - no need for any user interaction...?
> 
> So why do you *actually* even need user interaction here and why can't the
> kernel be smart enough to start the scrub automatically?

Short answer, it needs to be very smart and there isn't a case of one size
fits all - hence suggested approach of making it a user space problem.

There are hardware autonomous solutions and ones handled by host firmware.
That is how repair is done in many servers - at most software sees a slightly
latency spike as the memory is repaired under the hood. Some CXL devices
will do this as well. Those CXL devices may provide an additional repair
interface for the less clear cut decisions that need more data processing
/ analysis than the device firmware is doing. Other CXL devices will take
the view the OS is best placed to make all the decisions - those sometimes
will give a 'maintenance needed' indication in the error records but that
is still a hint the host may or may not take any notice of.

Given in the systems being considered here, software is triggering the repair,
we want to allow for policy in the decision. In simple cases we could push
that policy into the kernel e.g. just repair the moment we see an error record.

These repair resources are very limited in number, so immediately repairing
may a bad idea. We want to build up a history of errors before making
such a decision.  That can be done in kernel. 

The decision to repair memory is heavily influenced by policy and time considerations
against device resource constraints.

Some options that are hard to do in kernel.

1. Typical asynchronous error report for a corrected error.

   Tells us memory had an error (perhaps from a scrubbing engine on the device
   running checks). No need to take action immediately. Instead build up more data
   over time and if lots of errors occur make decision to repair as no we are sure it
   is worth doing rather than a single random event. We may tune scrubbing engines
   to check this memory more frequently and adjust our data analysis to take that
   into account for setting thresholds etc.
   When an admin considers it a good time to take action, offline the memory and
   repair before bringing it back into use (sometimes by rebooting the machine).
   Sometimes repair can be triggered in a software transparent way, sometimes not.
   This also applies to uncorrectable errors though in that case you can't necessarily
   repair it without ever seeing a synchronous poison with all the impacts that has.

2. Soft repair across boots.  We are actually storing the error records, then only
   applying the fix on reboot before using the memory - so maintaining a list
   of bad memory and saving it to a file to read back on boot. We could provide
   another kernel interface to get this info and reinject it after reboot instead
   of doing it in userspace but that is another ABI to design.

3. Complex policy across fleets.  A lot of work is going on around prediction techniques
   that may change the local policy on each node dependent on the overall reliability
   patterns of a particular batch of devices and local characteristics, service guarantees
   etc. If it is hard repair, then once you've run out you need schedule an engineer
   out to replace the DIMM. All complex inputs to the decision.

Similar cases like CPU offlining on repeated errors are done in userspace (e.g.
RAS Daemon) for similar reasons of long term data gathering and potentially
complex algorithms.
  
> 
> > Ok. Then can we just drop the range discoverability entirely or we go with
> > your suggestion and do not support read back of what has been
> > requested but instead have the reads return a range if known or "" /
> > return -EONOTSUPP if simply not known?  
> 
> Probably.

Too many options in the above paragraph so just to check...  Probably to which?
If it's a separate attribute from the one we write the control so then
we do what is already done here and don't present the interface at all if
the range isn't discoverable.

> 
> > I can live with that though to me we are heading in the direction of
> > a less intuitive interface to save a small number of additional files.  
> 
> This is not the point. I already alluded to this earlier - we're talking about
> a user visible interface which, once it goes out, it is cast in stone forever.
> 
> So those files better have a good reason to exist...
> 
> And if we're not sure yet, we can upstream only those which are fine now and
> then continue discussing the rest.

Ok. Best path is drop the available range support then (so no min_ max_ or
anything to replace them for now).

Added bonus is we don't have to rush this conversation and can make sure we
come to the right solution driven by use cases.

Jonathan

> HTH.
> 


