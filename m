Return-Path: <linux-edac+bounces-2935-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1FFA18511
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jan 2025 19:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F9F18839C8
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jan 2025 18:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5FA1F5403;
	Tue, 21 Jan 2025 18:16:44 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2846519F424;
	Tue, 21 Jan 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737483404; cv=none; b=I9VmxYPIdMnfmUu/9p/vMb97yNkqI6vZ43xSOJ/i0Pk7gLTxLcSb3UPDXu+2gsQ+2m7vsTdR7qOcReHXngpHTW/wtM8fVH9U3vkIBtK3oK6cTrmH+AuGVDejAnfdfrPxbcozT62x/tbagEHCUyeW5dCol/CQA6iq1rwcqWJjhdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737483404; c=relaxed/simple;
	bh=gjwpNw5OGaTBwscHmvWr0PiuOtX46QpIj9dpYx/ror4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9skBAO2DMXR28mh01J3GIFeoktakOzZlIBLmTjco0QQeKROCSRceUhEruCA+LZxJV8BI22M4UZydJZWRNy6PHxXAw6noQm8X5EQoiahRIgdKrTJe5E9J9kcAHm4yeq8PMJN7IvCTAYPTOZda/wPZxTrtGyO/wA386b6uNMGW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YcwPy6XZzz6K9K3;
	Wed, 22 Jan 2025 02:16:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AB7B1400DB;
	Wed, 22 Jan 2025 02:16:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 21 Jan
 2025 19:16:34 +0100
Date: Tue, 21 Jan 2025 18:16:32 +0000
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
	Linuxarm <linuxarm@huawei.com>, Vandana Salve <vsalve@micron.com>
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250121181632.0000637c@huawei.com>
In-Reply-To: <20250121161653.GAZ4_IdYDQ9_-QoEvn@fat_crate.local>
References: <20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
	<3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>
	<20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
	<20250109142433.00004ea7@huawei.com>
	<20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
	<20250109160159.00002add@huawei.com>
	<20250109161902.GDZ3_29rH-sQMV4n0N@fat_crate.local>
	<20250109183448.000059ec@huawei.com>
	<20250111171243.GCZ4Kmi5xMtY2ktCHm@fat_crate.local>
	<20250113110740.00003a7c@huawei.com>
	<20250121161653.GAZ4_IdYDQ9_-QoEvn@fat_crate.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 21 Jan 2025 17:16:53 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Jan 13, 2025 at 11:07:40AM +0000, Jonathan Cameron wrote:
> > We can do that if you prefer.  I'm not that fussed how this is handled
> > because, for tooling at least, I don't see why we'd ever read it.
> > It's for human parsing only and the above is fine.  
> 
Note we are dropping the min / max stuff in most cases as it was only
added as it seems to be our misguided attempt to resolve an earlier
review comment. That reduces some of the complexity and wasn't useful anyway.

We are also splitting the patch set up differently so maybe we can
move the discussion on to the 'extended' case for repair without also
blocking the simple memory address based one.

> Is there even a concrete use case for humans currently? Because if not, we
> might as well not do it at all and keep it simple.

Clearly we need to provide more evidence of use cases: 'Show us your code'
seems to apply here.  We'll do that over the next few weeks.

The concrete use case is repair of CXL memory devices using sparing,
based on simple algorithms applied to the data RAS Daemon already has.
The interface for the reasons discussed in the long thread with Dan
is the minimum required to provide the information needed to allow
for two use cases.  We enumerated them explicitly in the discussion with
Dan because they possibly affected 'safety'.

1) Power up, pre memory online, (typically non persistent) repair of
   known bad memory.  There are two interface options for this, inject
   the prior mapping from device physical address space (host address
   is not necessarily relevant here as no address decoders have been
   programmed yet in CXL - that happens as part of the flow to bring
   the memory up), or use the information that userspace already has
   (bank, rank etc) to select what memory is to be replaced with
   spare capacity.
   
   Given the injection interface and the repair interface have to
   convey the same data, the interface complexity is identical and
   we might as well have a single step 'repair' rather than
     1. Inject prior records then
     2. Pass a physical address that is matched to one of those records.
   
   There are no security related concerns here as we always treat this
   as new memory and zero it etc as part of onlining.

2) Online case.  Here the restriction Dan proposed was that we 'check'
   that we have seen an error record on this boot that matches the full
   description.  That is matching both the physical address and the
   topology (as that mapping can change from boot to boot, but not whilst
   the memory is in use). This doesn't prevent any use case we have
   come up with yet because, if we are making a post initial onlining
   decision to repair we can assume there is a new error record that
   provided new information on which we are acting.  Hence the kernel
   had the information to check.

   Whilst I wasn't convinced that we had a definite security
   problem without this protection, it requires minimal changes and doesn't
   block the flows we care about so we are fine with adding this check.

> 
> All I see is an avalanche of sysfs nodes and I'm questioning the usefulness of
> the interface and what's the 30K ft big picture for all this.

Ok. We'll put together an example script / RASdaemon code to show how
it is used. I think you may be surprised at how simple this is and hopefully
that will show that the interface is appropriate.

> 
> If this all is just wishful thinking on the part of how this is going to be
> used, then I agree with Dan: less is more. But I need to read the rest of that
> thread when there's time.
> 

I'll let Dan speak for himself, but my understanding is that what
Dan is focused on is safety and other than tidying up a little isn't
proposing an significant interface change.

> ...
> > Repair cam be a feature of the DIMMs themselves or it can be a feature
> > of the memory controller. It is basically replacing them with spare
> > memory from somewhere else (usually elsewhere on same DIMMs that have
> > a bit of spare capacity for this).  Bit like a hot spare in a RAID setup.  
> 
> Ooh, this is what you call repair. That's using a spare rank or so, under
> which I know it as one example.
> 
> What I thought you mean with repair is what you mean with "correct". Ok,
> I see.
> 
> > In some other systems the OS gets the errors and is responsible for making
> > the decision.  
> 
> This decision has been kept away from the OS in my world so far. So yes, the
> FW doing all the RAS recovery work is more like it. And the FW is the better
> agent in some sense because it has a lot more intimate knowledge of the
> platform. However...
> 
> > Sticking to the corrected error case (uncorrected handling
> > is going to require a lot more work given we've lost data, Dan asked about that
> > in the other branch of the thread), the OS as a whole (kernel + userspace)
> > gets the error records and makes the policy decision to repair based on
> > assessment of risk vs resource availability to make a repair.
> > 
> > Two reasons for this
> > 1) Hardware isn't necessarily capable of repairing autonomously as
> >    other actions may be needed (memory traffic to some granularity of
> >    memory may need to be stopped to avoid timeouts). Note there are many
> >    graduations of this from A) can do it live with no visible effect, through
> >    B) offline a page, to C) offlining the whole device.
> > 2) Policy can be a lot more sophisticated than a BMC can do.  
> 
> ... yes, that's why you can't rely only on the FW to do recovery but involve
> the OS too. Basically what I've been saying all those years. Oh well...

This we agree on.

> 
> > In some cases perhaps, but another very strong driver is that policy is involved.
> > 
> > We can either try put a complex design in firmware and poke it with N opaque
> > parameters from a userspace tool or via some out of band method or we can put
> > the algorithm in userspace where it can be designed to incorporate lessons learnt
> > over time.  We will start simple and see what is appropriate as this starts
> > to get used in large fleets.  This stuff is a reasonable target for AI type
> > algorithms etc that we aren't going to put in the kernel.
> > 
> > Doing this at all is a reliability optimization, normally it isn't required for
> > correct operation.  
> 
> I'm not saying you should put an AI engine into the kernel - all I'm saying
> is, the stuff which the kernel can decide itself without user input doesn't
> need user input. Only toggle: the kernel should do this correction and/or
> repair automatically or not.

This we disagree on. For this persistent case in particular these are limited
resources. Once you have used them all you can't do it again.  Using them
carefully is key. An exception is mentioned below as a possible extension but
it relies on a specific subset of allowed device functionality and only
covers some use cases (so it's an extra, not a replacement for what this
set does).

> 
> What is clear here is that you can't design an interface properly right now
> for algorithms which you don't have yet. And there's experience missing from
> running this in large fleets.

With the decision algorithms in userspace, we can design the userspace to kernel
interface because we don't care about the algorithm choice - only what it needs
to control which is well defined. Algorithms will start simple and then
we'll iterate but it won't need changes in this interface because none of it
is connected to how we use the data.

> 
> But the interface you're adding now will remain forever cast in stone. Just
> for us to realize one day that we're not really using it but it is sitting out
> there dead in the water and we can't retract it. Or we're not using it as
> originally designed but differently and we need this and that hack to make it
> work for the current sensible use case.
> 
> So the way it looks to me right now is, you want this to be in debugfs. You
> want to go nuts there, collect experience, algorithms, lessons learned etc and
> *then*, the parts which are really useful and sensible should be moved to
> sysfs and cast in stone. But not preemptively like that.

In general an ABI that is used is cast in stone. To my understanding there
is nothing special about debugfs.  If we introduce a regression in tooling
that uses that interface are we actually any better off than sysfs?
https://lwn.net/Articles/309298/ was a good article on this a while back.

Maybe there has been a change of opinion on this that I missed.

> 
> > Offline has no permanent cost and no limit on number of times you can
> > do it. Repair is definitely a limited resource and may permanently use
> > up that resource (discoverable as a policy wants to know that too!)
> > In some cases once you run out of repair resources you have to send an
> > engineer to replace the memory before you can do it again.  
> 
> Yes, and until you can do that and because cloud doesn't want to *ever*
> reboot, you must do diminished but still present machine capabilities by
> offlining pages and cordoning off faulty hw, etc, etc.

Absolutely though the performance impact of punching holes in memory over
time is getting some cloud folk pushing back because they can't get their
1GIB pages to put under a VM.  Mind you that's not particularly relevant
to this thread.

> 
> > Ok. I guess it is an option (I wasn't aware of that work).
> > 
> > I was thinking that was far more complex to deal with than just doing it in
> > userspace tooling. From a quick look that solution seems to rely on ACPI ERSR
> > infrastructure to provide that persistence that we won't generally have but
> > I suppose we can read it from the filesystem or other persistent stores.
> > We'd need to be a lot more general about that as can't make system assumptions
> > that can be made in AMD specific code.
> > 
> > So could be done, I don't think it is a good idea in this case, but that
> > example does suggest it is possible.  
> 
> You can look at this as specialized solutions. Could they be more general?
> Ofc. But we don't have a general RAS architecture which is vendor-agnostic.

It could perhaps be made more general, but so far I'm not seeing why we would
do this for this particular feature.  It does seem like an interesting avenue
to investigate more generally.

The use cases discussed in the thread with Dan do not require injection of
prior records.  Mauro called out his view that complex policy should not be
in the kernel as well and as you have gathered I fully agree with him on
that!

> 
> > In approach we are targetting, there is no round trip situation.  We let the kernel
> > deal with any synchronous error just fine and run it's existing logic
> > to offline problematic memory.  That needs to be timely and to carry on operating
> > exactly as it always has.
> > 
> > In parallel with that we gather the error reports that we will already be
> > gathering and run analysis on those.  From that we decide if a memory is likely to fail
> > again and perform a sparing operation if appropriate.
> > Effectively this is 'free'. All the information is already there in userspace
> > and already understood by tools like rasdaemon, we are not expanding that
> > reporting interface at all.  
> 
> That is fair. I think you can do that even now if the errors logged have
> enough hw information to classify them and use them for predictive analysis.

Definitely.  In general (outside of CXL in particular) we think there are
some gaps that we'll look to address in future, but that's simple stuff
for another patch series.

> 
> > Ok.  It seems you correlate number of files with complexity.  
> 
> No, wrong. I'm looking at the interface and am wondering how is this going to
> be used and whether it is worth it to have it cast in stone forever.

Ok.  I'm not concerned by this because of the alignment with old specifications
going back a long way.  I'm not sure of the history of the CXL definition but
it is near identical to the UEFI CPER records that have been in use a long time.
For me that convinces me that this form of device description is pretty general
and stable.  I'm sure we'll get small new things over time (sub-channel came
with DDR5 for example) but those are minor additions.

> 
> > I correlated difficulty of understanding those files with complexity.
> > Everyone one of the files is clearly defined and aligned with long history
> > of how to describe DRAM (see how long CPER records have used these
> > fields for example - they go back to the beginning).  
> 
> Ok, then pls point me to the actual use cases how those files are going to be
> used or they are used already.

For this we'll do as we did for scrub control and send a patch set adding tooling
to RASdaemon and/or if more appropriate a script along side it.  My fault,
I falsely thought this one was more obvious and we could leave that until
this landed. Seems not!

> 
> > I'm all in favor of building an interface up by providing minimum first
> > and then adding to it, but here what is proposed is the minimum for basic
> > functionality and the alternative of doing the whole thing in kernel both
> > puts complexity in the wrong place and restricts us in what is possible.  
> 
> There's another point to consider: if this is the correct and proper solution
> for *your* fleet, that doesn't necessarily mean it is the correct and
> generic solution for *everybody* using the kernel. So you can imagine that I'd
> like to have a generic solution which can maximally include everyone instead
> of *some* special case only.

This I agree on. However, if CXL takes off (and there seems to be agreement
it will to some degree at least) then this interface is fully general for any spec
compliant device. It would be nice to have visibility of more OS managed
repair interfaces but for now I can only see one other and that is more
similar to PPR in CXL which is device/host physical address based.
So we have 3 examples on which to build generalizations, but only one fits
the model we are discussing here (which is the second part of repair
support in v19 patch set).

> 
> > To some degree but I think there is a major mismatch in what we think
> > this is for.
> > 
> > What I've asked Shiju to look at is splitting the repair infrastructure
> > into two cases so that maybe we can make partial progress:
> > 
> > 1) Systems that support repair by Physical Address
> >  - Covers Post Package Repair for CXL
> > 
> > 2) Systems that support repair by description of the underlying hardware
> > - Covers Memory Sparing interfaces for CXL. 
> > 
> > We need both longer term anyway, but maybe 1 is less controversial simply
> > on basis it has fewer control parameters
> > 
> > This still fundamentally puts the policy in userspace where I
> > believe it belongs.  
> 
> Ok, this is more concrete. Let's start with those. Can I have some more
> details on how this works pls and who does what? Is it generic enough?

Sure. We can definitely do that.  We have this split in v19 (just undergoing
some final docs tidy up etc, should be posted soon).

> 
> If not, can it live in debugfs for now? See above what I mean about this.
> 
> Big picture: what is the kernel's role here? To be a parrot to carry data
> back'n'forth or can it simply do clear-cut decisions itself without the need
> for userspace involvement?

With the additional 'safety' checks Dan has asked for the kernel requirement
(beyond a standardized interface / place to look for the controls etc) is
now responsible for ensuring that a request to repair memory that is online
matches up with an error record that we have received. First instance of this
will be CXL native error handling based.  For now we've made this device
specific because exactly what needs checking depends on the type of repair
implementation.

My intent was that the kernel never makes decisions for this feature.

Potentially in future we could relax that to allow it to do so for a few
usecases - the non persistent ones, where it could be considered
a way to avoid offlining a page.  I see that as a much more complex case
though than the userspace managed handling so one for future work.
It only applies on some subset of devices and there are not enough in
the market yet for us to know if that is going to be commonly supported.
They will support repair, but whether they allow online repair rather
than only offline is yet to be seen. That question corresponds to a
single attribute in sysfs and a couple of checks in the driver code
but changes whether the second usecase above is possible.

Early devices and the ones in a few years time may make different
decisions on this. All options are covered by this driver (autonomous
repair is covered for free as nothing to do!)

Online sparing to avoid offline is a cute idea only at the moment.

> 
> So far I get the idea that this is something for your RAS needs. This should
> have general usability for the rest of the kernel users - otherwise it should
> remain a vendor-specific solution until it is needed by others and can be
> generalized.

CXL is not vendor specific. Our other driver that I keep referring
to as 'coming soon' is though.  I'll see if I can get a few memory
device manufacturers to specifically stick their hands up that they
care about this. As an example we presented on this topic with
Micron at the LPC CXL uconf (+CC Vandana).  I don't have access
to Micron parts so this isn't just Huawei using Micron, we simply had two
proposals on the same topic so combined the sessions.  We have a CXL
open source sync call in an hour so I'll ask there.

> 
> Also, can already existing solutions in the kernel be generalized so that you
> can use them too and others can benefit from your improvements?

Maybe for the follow on topic of non persistent repair as a path to
avoid offlining memory detected as bad. Maybe that counts
as generalization (rather than extension).  But that's not covering
our usecase of restablishing the offline at boot, or the persistent
usecases.  So it's a value add feature for a follow up effort,
not a baseline one which is the intent of this patch set.

> 
> I hope this makes more sense.

Thanks for taking time to continue the discussion and I think we
are converging somewhat even if there is further to go.

Jonathan
> 
> Thx.
> 


