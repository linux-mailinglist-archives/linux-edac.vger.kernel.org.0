Return-Path: <linux-edac+bounces-2879-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9783A0B51D
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2025 12:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C113A1886A7A
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2025 11:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACDC21ADDB;
	Mon, 13 Jan 2025 11:07:55 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736CC235C0F;
	Mon, 13 Jan 2025 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736766475; cv=none; b=NX/dNaq+9GTo4J/63E+vyQgVOzs4kR9+1wqmu9p1s9HpfG8WsLbqThRGcliK/kt3vXOc8gKVAieuOB5pLsy3bfQJd0rnvC0Y7ERkbRr7sBNgkV0DKvhj8YdH6+yFpHphnRIWS+MLLWqGrOROWhxQHEZTqlFWqbAjWQf8rYZFabo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736766475; c=relaxed/simple;
	bh=nAubFLiqv0gfkpnzEzUQDcCurKHzWRDIqrsIXeSkiBc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdtmywKHJArhvIHWf4WeXm2WDA1vtwcuupXV2ue5I2Zo82+kVv4TscSwejhWZHSVkCV1bu4G1+TozPR7vVJX9KrFny+eLPjHyJSnZqEYBmtimLCRIL3aXMNFCg6fwxd6K6OouHurI6sIylWxYdAumWN9gbjOK8GLvZvxxnGZjKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YWq9V1c33z6K9XR;
	Mon, 13 Jan 2025 19:02:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A8D314038F;
	Mon, 13 Jan 2025 19:07:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 13 Jan
 2025 12:07:42 +0100
Date: Mon, 13 Jan 2025 11:07:40 +0000
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
Message-ID: <20250113110740.00003a7c@huawei.com>
In-Reply-To: <20250111171243.GCZ4Kmi5xMtY2ktCHm@fat_crate.local>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-5-shiju.jose@huawei.com>
	<20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
	<3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>
	<20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
	<20250109142433.00004ea7@huawei.com>
	<20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
	<20250109160159.00002add@huawei.com>
	<20250109161902.GDZ3_29rH-sQMV4n0N@fat_crate.local>
	<20250109183448.000059ec@huawei.com>
	<20250111171243.GCZ4Kmi5xMtY2ktCHm@fat_crate.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 11 Jan 2025 18:12:43 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Jan 09, 2025 at 06:34:48PM +0000, Jonathan Cameron wrote:
> > Today you can.  Seems we are talking cross purposes.
> > 
> > I'm confused. I thought your proposal was for "bank" attribute to present an
> > allowed range on read.
> > "bank" attribute is currently written to and read back as the value of the bank on which
> > to conduct a repair.  Maybe this disconnect is down to the fact max_ and min_
> > attributes should have been marked as RO in the docs. They aren't controls,
> > just presentation of limits to userspace.
> > 
> > Was intent a separate bank_range type attribute rather than max_bank, min_bank?  
> 
> I don't know - I'm just throwing ideas out there. You could do:
> 
> cat /sys/.../bank
> 
> and that gives you
> 
> [<low> <current_value> <high>]
> 
> So you have all the needed information. Dunno if this would be abusing sysfs
> rules too much tho.

We could do that, trade off between count of files and parsing complexity, but
given I don't expect anyone to parse the reads anyway, sure.

If we do go that way I guess we'd have things like
<0> 33 <123>
33

To allow for cases where the range is known vs not known? Or
<?> 33 <?> maybe?

We can do that if you prefer.  I'm not that fussed how this is handled
because, for tooling at least, I don't see why we'd ever read it.
It's for human parsing only and the above is fine.

> 
> > >   
> > > > In at least the CXL case I'm fairly sure most of them are not discoverable.
> > > > Until you see errors you have no idea what the memory topology is.    
> > > 
> > > Ok.
> > >   
> > > > For that you'd need to have a path to read back what happened.    
> > > 
> > > So how is this scrubbing going to work? You get an error, you parse it for all
> :> > the attributes and you go and write those attributes into the scrub interface
> > > and it starts scrubbing?  
> > 
> > Repair not scrubbing. They are different things we should keep separate,
> > scrub corrects the value, if it can, but doesn't change the underlying memory to
> > new memory cells to avoid repeated errors. Replacing scrub with repair 
> > (which I think was the intent here)...  
> 
> Really?
> 
> So how is scrubbing defined for CXL? You read memory, do ECC check on it,
> report any potential errors but write back the *original* wrong value?!

What you describe is correction, not repair. Of course it corrects!
These two terms mean different things in CXL world and in DDR specs etc.
We should have made that distinction clearer as perhaps that is the root
of this struggle to reach agreement.

> 
> I thought the point of scrubbing is to repair it while at it too...

No. There is a major difference between correction (which scrubbing does)
and repair.

Point of scrubbing is to correct errors if it can by using (typically)
the single error correction of SECDED ECC codes (single correct, double detect).
In many cases it reports the error and uncorrectable errors it runs into.
This is common for all scrub implementations not just CXL ones.

What happens with those error reports differs between systems. This is
not CXL specific. I'm aware of other systems that make repair an OS managed
thing - we have another driver queued up behind this set that does exactly
that.

In many existing servers (I know some of ours do this for example), the
firmware / BMC etc keep track of those errors and make the decision to
repair the memory. It does not do this on detection of one correctable
error, it does it after a repeated pattern.

Repair cam be a feature of the DIMMs themselves or it can be a feature
of the memory controller. It is basically replacing them with spare
memory from somewhere else (usually elsewhere on same DIMMs that have
a bit of spare capacity for this).  Bit like a hot spare in a RAID setup.

In some other systems the OS gets the errors and is responsible for making
the decision. Sticking to the corrected error case (uncorrected handling
is going to require a lot more work given we've lost data, Dan asked about that
in the other branch of the thread), the OS as a whole (kernel + userspace)
gets the error records and makes the policy decision to repair based on
assessment of risk vs resource availability to make a repair.

Two reasons for this
1) Hardware isn't necessarily capable of repairing autonomously as
   other actions may be needed (memory traffic to some granularity of
   memory may need to be stopped to avoid timeouts). Note there are many
   graduations of this from A) can do it live with no visible effect, through
   B) offline a page, to C) offlining the whole device.
2) Policy can be a lot more sophisticated than a BMC can do.

> 
> > You get error records that describe the error seen in hardware, write back the
> > values into this interface and tell it to repair the memory.  This is not
> > necessarily a synchronous or immediate thing - instead typically based on
> > trend analysis.  
> 
> This is just silly: I'm scrubbing, I found an error, I should simply fix it
> while at it. Why would I need an additional command to repair it?!

This is confusing correction with repair.  They are different operations.
Correction of course happens (if we can- normally single bit errors only).
No OS involvement in scrub based correction.
Repair is normally only for repeated errors.   If the memory is fine and
we get a cosmic ray or similar flipping a bit there is no long term
increased likelihood of seeing another error.  If we get one every X
hours then it is highly likely the issue is something wrong with the memory.

> 
> > As an example, the decision might be that bit of ram threw up 3 errors
> > over a month including multiple system reboots (for other reasons) and
> > that is over some threshold so we use a spare memory line to replace it.  
> 
> Right.
> 
> > Short answer, it needs to be very smart and there isn't a case of one size
> > fits all - hence suggested approach of making it a user space problem.  
> 
> Making it a userspace problem is pretty much always a sign that the hw design
> failed.

In some cases perhaps, but another very strong driver is that policy is involved.

We can either try put a complex design in firmware and poke it with N opaque
parameters from a userspace tool or via some out of band method or we can put
the algorithm in userspace where it can be designed to incorporate lessons learnt
over time.  We will start simple and see what is appropriate as this starts
to get used in large fleets.  This stuff is a reasonable target for AI type
algorithms etc that we aren't going to put in the kernel.

Doing this at all is a reliability optimization, normally it isn't required for
correct operation.

> 
> > Given in the systems being considered here, software is triggering the repair,
> > we want to allow for policy in the decision.   
> 
> Right, you can leave a high-level decision to userspace: repair only when
> idle, repair only non-correctable errors, blabla but exposing every single
> aspect of every single error... meh.

Those aspects identify the error location. As I put in reply to Dan a device
does not necessarily have a fixed mapping to a device physical address over
reboots etc.  There are solutions that scramble that mapping on reboot
or hotplug for various reasons (security and others).

For CXL at least these are all in userspace already (RAS-daemon has supported
them for quite a while).  The same data is coming in a CPER record for other
memory errors though I'm not sure it is currently surfaced to RAS Daemon.


> 
> > In simple cases we could push that policy into the kernel e.g. just repair
> > the moment we see an error record.
> > 
> > These repair resources are very limited in number, so immediately repairing
> > may a bad idea. We want to build up a history of errors before making
> > such a decision.  That can be done in kernel.   
> 
> Yap, we are doing this now:
> 
> drivers/ras/cec.c
> 
> Userspace involvement is minimal, if at all. It is mostly controlling the
> parameters of the leaky bucket.

Offline has no permanent cost and no limit on number of times you can
do it. Repair is definitely a limited resource and may permanently use
up that resource (discoverable as a policy wants to know that too!)
In some cases once you run out of repair resources you have to send an
engineer to replace the memory before you can do it again.

So to me, these are different situations requiring different solutions.

> 
> > The decision to repair memory is heavily influenced by policy and time considerations
> > against device resource constraints.
> > 
> > Some options that are hard to do in kernel.
> > 
> > 1. Typical asynchronous error report for a corrected error.
> > 
> >    Tells us memory had an error (perhaps from a scrubbing engine on the device
> >    running checks). No need to take action immediately. Instead build up more data
> >    over time and if lots of errors occur make decision to repair as no we are sure it
> >    is worth doing rather than a single random event. We may tune scrubbing engines
> >    to check this memory more frequently and adjust our data analysis to take that
> >    into account for setting thresholds etc.  
> 
> See above.
> 
> What happens when your daemon dies and loses all that collected data?

It is logged always - in rasdaemon, either local sqlite DB or people are carrying
patches to do fleet scale logging.  This works across reboot so a daemon dying is
part of the design rather than just an error case.
If the daemon is able to corrupt your error logs then we have bigger problems.

> 
> > 2. Soft repair across boots.  We are actually storing the error records, then only
> >    applying the fix on reboot before using the memory - so maintaining a list
> >    of bad memory and saving it to a file to read back on boot. We could provide
> >    another kernel interface to get this info and reinject it after reboot instead
> >    of doing it in userspace but that is another ABI to design.  
> 
> We did something similar recently: drivers/ras/amd/fmpm.c. It basically
> "replays" errors from persistent storage as that memory cannot be replaced.

Ok. I guess it is an option (I wasn't aware of that work).

I was thinking that was far more complex to deal with than just doing it in
userspace tooling. From a quick look that solution seems to rely on ACPI ERSR
infrastructure to provide that persistence that we won't generally have but
I suppose we can read it from the filesystem or other persistent stores.
We'd need to be a lot more general about that as can't make system assumptions
that can be made in AMD specific code.

So could be done, I don't think it is a good idea in this case, but that
example does suggest it is possible.
 
> > 3. Complex policy across fleets.  A lot of work is going on around prediction techniques
> >    that may change the local policy on each node dependent on the overall reliability
> >    patterns of a particular batch of devices and local characteristics, service guarantees
> >    etc. If it is hard repair, then once you've run out you need schedule an engineer
> >    out to replace the DIMM. All complex inputs to the decision.  
> 
> You probably could say here: "repair or report when this and that." or
> "offline page and report error" and similar high-level decisions by leaving
> the details to the kernel instead of looking at every possible error in
> userspace and returning back to the kernel to state your decision.

In approach we are targetting, there is no round trip situation.  We let the kernel
deal with any synchronous error just fine and run it's existing logic
to offline problematic memory.  That needs to be timely and to carry on operating
exactly as it always has.

In parallel with that we gather the error reports that we will already be
gathering and run analysis on those.  From that we decide if a memory is likely to fail
again and perform a sparing operation if appropriate.
Effectively this is 'free'. All the information is already there in userspace
and already understood by tools like rasdaemon, we are not expanding that
reporting interface at all.

Or we don't decide to and the memory continues to be used as before.  Sure there
may be a higher chance of error but there isn't one right now.  (or there is and
we have offlined the memory anyway via normal mechanisms so no problem).

There is an interesting future exploration to be done on recovery from poison
(uncorrectable error) situations, but that is not in scope of this initial
code and that would likely be an asynchronous best effort process as well.


> 
> > Similar cases like CPU offlining on repeated errors are done in userspace (e.g.
> > RAS Daemon) for similar reasons of long term data gathering and potentially
> > complex algorithms.
> >     
> > >   
> > > > Ok. Then can we just drop the range discoverability entirely or we go with
> > > > your suggestion and do not support read back of what has been
> > > > requested but instead have the reads return a range if known or "" /
> > > > return -EONOTSUPP if simply not known?    
> > > 
> > > Probably.  
> > 
> > Too many options in the above paragraph so just to check...  Probably to which?
> > If it's a separate attribute from the one we write the control so then
> > we do what is already done here and don't present the interface at all if
> > the range isn't discoverable.  
> 
> Probably means I still don't get a warm and fuzzy feeling about this design.
> As I've noted above.

Ok. I was confused as the paragraph asked and (A) or (B) question.

> 
> > Ok. Best path is drop the available range support then (so no min_ max_ or
> > anything to replace them for now).
> > 
> > Added bonus is we don't have to rush this conversation and can make sure we
> > come to the right solution driven by use cases.  
> 
> Yap, that sounds like a prudent idea.
> 
> What I'm trying to say, basically, is, this interface through sysfs is
> a *lot* of attributes, there's no clear cut use case where we can judge how
> useful it is and as I alluded to above, I really think that you should leave
> the high-level decisions to userspace and let the kernel do its job.
> 
> This'll make your interface a lot simpler.

Ok.  It seems you correlate number of files with complexity.
I correlated difficulty of understanding those files with complexity.
Everyone one of the files is clearly defined and aligned with long history
of how to describe DRAM (see how long CPER records have used these
fields for example - they go back to the beginning).

1) It is only 8 files (if we drop the range info).
   I don't consider that a complex enough interface to worry about complexity.
2) Moving the control into the kernel will require a control interface as
   there will be multiple tuneables for those decisions. Like most such
   algorithm parameter questions we may spend years arguing about what those
   look like.  Sure that problem also occurs in userspace but we aren't
   obliging people to use what we put in RASDaemon.

> 
> And if you really need to control every single aspect of scrubbing in
> userspace, then you can always come later with proper design and use case.

I'm all in favor of building an interface up by providing minimum first
and then adding to it, but here what is proposed is the minimum for basic
functionality and the alternative of doing the whole thing in kernel both
puts complexity in the wrong place and restricts us in what is possible.
See below for a proposal to maybe make some progress.

> 
> But again, I really think you should keep as much recovery logic in the kernel
> and as automatic as possible. Only when you really really need user input,
> only then you should allow it...

This is missing the key considerations of resource availability being
limited and not addressing the main usecase here. This is not and has
never been about the logic to recover form an error. It is about reducing
the possibility of repeated errors.

> 
> I hope I'm making sense here...

To some degree but I think there is a major mismatch in what we think
this is for.

What I've asked Shiju to look at is splitting the repair infrastructure
into two cases so that maybe we can make partial progress:

1) Systems that support repair by Physical Address
 - Covers Post Package Repair for CXL

2) Systems that support repair by description of the underlying hardware
- Covers Memory Sparing interfaces for CXL. 

We need both longer term anyway, but maybe 1 is less controversial simply
on basis it has fewer control parameters

This still fundamentally puts the policy in userspace where I
believe it belongs.

Jonathan



> 
> Thx.
> 


