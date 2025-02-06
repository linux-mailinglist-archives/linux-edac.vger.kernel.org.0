Return-Path: <linux-edac+bounces-2968-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7747AA2AA21
	for <lists+linux-edac@lfdr.de>; Thu,  6 Feb 2025 14:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0559216159B
	for <lists+linux-edac@lfdr.de>; Thu,  6 Feb 2025 13:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2241EA7F4;
	Thu,  6 Feb 2025 13:39:59 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93280199B9;
	Thu,  6 Feb 2025 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738849199; cv=none; b=quR4xXibHlGZYswrInb5h0a4RC6Jgx1G7uwAkJbZEJ3PRCzrRC/BLamkElOo8WPbU/UY7gdZ9egslOFgvFsiaQYdPCB+zWaLzNnvrOeHVN96RE99RMONlixpIETU7WDarRpsDzzDbg/BlRXhwZCT8SPj4FnWi1giAP9FgY/nrOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738849199; c=relaxed/simple;
	bh=jbXs/lv0vv0lH8Vf0t9mbt1SDGzSRadJ5Oa/D6J+dao=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uy79WKyuhClIHqEn9sQvuoBRfN9KHrfMaQbmbjMsydYYwrfQRWrKxI6eIC+7uY72zlouyMclnfOHkvJ97CLta0AFFpYtjPdnN9cu8HhR9ccFPJqmg5GxzG5CehRma1Xgyvwbpdu32wwDVb8/XLU2m9ITY37DHbPZ16xipd9t16I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YpdVQ27F3z6HJcf;
	Thu,  6 Feb 2025 21:38:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A3EDB140520;
	Thu,  6 Feb 2025 21:39:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Feb
 2025 14:39:51 +0100
Date: Thu, 6 Feb 2025 13:39:49 +0000
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
Message-ID: <20250206133949.00006dd6@huawei.com>
In-Reply-To: <20250122190917.GDZ5FCXetp9--djyQ6@fat_crate.local>
References: <20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
	<20250109142433.00004ea7@huawei.com>
	<20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
	<20250109160159.00002add@huawei.com>
	<20250109161902.GDZ3_29rH-sQMV4n0N@fat_crate.local>
	<20250109183448.000059ec@huawei.com>
	<20250111171243.GCZ4Kmi5xMtY2ktCHm@fat_crate.local>
	<20250113110740.00003a7c@huawei.com>
	<20250121161653.GAZ4_IdYDQ9_-QoEvn@fat_crate.local>
	<20250121181632.0000637c@huawei.com>
	<20250122190917.GDZ5FCXetp9--djyQ6@fat_crate.local>
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

On Wed, 22 Jan 2025 20:09:17 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Jan 21, 2025 at 06:16:32PM +0000, Jonathan Cameron wrote:
> > Clearly we need to provide more evidence of use cases: 'Show us your code'
> > seems to apply here.  We'll do that over the next few weeks.  
> 
> Thanks.

Shiju is just finalizing a v19 + the userspace code.  So may make
sense to read this reply only after that is out!

> 
> > based on simple algorithms applied to the data RAS Daemon already has.
> > The interface for the reasons discussed in the long thread with Dan
> > is the minimum required to provide the information needed to allow
> > for two use cases.  We enumerated them explicitly in the discussion with
> > Dan because they possibly affected 'safety'.
> > 
> > 1) Power up, pre memory online, (typically non persistent) repair of
> >    known bad memory.  
> 
> Lemme make sure I understand this: during boot you simply know from somewhere
> that a certain rank (let's use rank for simplicity's sake) is faulty. Before
> you online the memory, you simply replace that rank in the logic so that the
> system uses the spare rank while the faulty rank is disabled.

Yes.

> 
> >    There are two interface options for this, inject the prior mapping from
> >    device physical address space (host address is not necessarily relevant
> >    here as no address decoders have been programmed yet in CXL - that
> >    happens as part of the flow to bring the memory up), or use the
> >    information that userspace already has (bank, rank etc) to select what
> >    memory is to be replaced with spare capacity.  
> 
> Ok, so this is all CXL-specific because this use case relies on userspace
> being present. Which means you cannot really use this for DIMMs used during
> boot. So if DIMMs, those should be online-able later, when userspace is there.

In this case yes, this isn't appropriate for general purpose DIMMs.
It's not CXL Specific as such but that is the most common type of device
providing expansion / memory pooling type facilities today and those
are the most common forms of memory not needed at boot (I don't think
NVDIMMS ever supported PPR etc).

> 
> >    Given the injection interface and the repair interface have to
> >    convey the same data, the interface complexity is identical and
> >    we might as well have a single step 'repair' rather than
> >      1. Inject prior records then  
> 
> What exactly is this injecting? The faulty rank? Which then would cause the
> respective driver to go and do that repairing.

For this comment I was referring letting the kernel do the
stats gathering etc. We would need to put back records from a previous boot.
That requires almost the same interface as just telling it to repair.
Note the address to physical memory mapping is not stable across boots
so we can't just provide a physical address, we need full description.

> 
> Which then means that you can online that device after rasdaemon has loaded
> and has the required info to online it.
> 
> Which then means, rasdaemon needs to be part of the device onlining process.

Yes. For this flow (sort of)  The PoC / proposal is a boot script rather
than rasdaemon but it uses the rasdaemon DB.

It would definitely be interesting to explore other options in addition to
this.  Perhaps we get some firmware interface standardization to ask the
firmware if it can repair stuff before the memory is in use.  Might work
for cases where the firmware knows enough about them to do the repair.

> 
> I'm simply conjecturing here - I guess I'll see your detailed use case later.
> 
> >      2. Pass a physical address that is matched to one of those records.  
> 
> I don't know what that one does.

This was about practical restrictions on interface simplification.
If we have prior records pushed back into the kernel, we could then 'find' the
data we need to repair by looking it up by physical address.  In v19 we do
that for records from this boot if the memory is online.  This is
part of the sanity check Dan asked for to harden against userspace
repairing something based on stale data, but it is specific to the CXL
driver. More generally that sanity check may not be needed if PA to
actual memory mapping is a stable thing.
> 
> >    There are no security related concerns here as we always treat this
> >    as new memory and zero it etc as part of onlining.  
> 
> Right, goes without saying.
> 
> > 2) Online case.  Here the restriction Dan proposed was that we 'check'
> >    that we have seen an error record on this boot that matches the full
> >    description.  That is matching both the physical address and the
> >    topology (as that mapping can change from boot to boot, but not whilst
> >    the memory is in use). This doesn't prevent any use case we have
> >    come up with yet because, if we are making a post initial onlining
> >    decision to repair we can assume there is a new error record that
> >    provided new information on which we are acting.  Hence the kernel
> >    had the information to check.
> > 
> >    Whilst I wasn't convinced that we had a definite security
> >    problem without this protection, it requires minimal changes and doesn't
> >    block the flows we care about so we are fine with adding this check.  
> 
> I need more detail on that 2nd case - lemme read that other subthread.
> 
> > Ok. We'll put together an example script / RASdaemon code to show how
> > it is used. I think you may be surprised at how simple this is and hopefully
> > that will show that the interface is appropriate.  
> 
> That sounds good, thanks.
> 
> > This we disagree on. For this persistent case in particular these are limited
> > resources. Once you have used them all you can't do it again.  Using them
> > carefully is key. An exception is mentioned below as a possible extension but
> > it relies on a specific subset of allowed device functionality and only
> > covers some use cases (so it's an extra, not a replacement for what this
> > set does).  
> 
> By "this persistent case" you mean collecting logs per error address,
> collating them and massaging them or hunting them through a neural network to
> recognize potential patterns and then act upon them?

Ah. No not that. I was just meaning the case where it is hard PPR. (hence
persistent for all time) Once you've done it you can't go back so after
N uses, any more errors mean you need a new device ASAP. That is as decision
with a very different threshold to soft PPR where it's a case of you
do it until you run out of spares, then you fall back to offlining
pages.  Next boot you get your spares back again and may use them
differently this time.

> 
> In any case, I don't mean that - I mean something simple like: "after X errors
> on address Y, offline page Z." Like we do with .../ras/cec.c. Ofc you can't
> put really complex handling in the kernel and why would you - it must be *the*
> best thing after sliced bread to impose that on everyone.
> 
> All I'm saying is, simple logic like that can be in the kernel if it is useful
> in the general case. You don't *have* to carry all logic in some userspace
> daemon - the kernel can be smart too :-)

True enough. I'm not against doing things in kernel in some cases.  Even
then I want the controls to allow user space to do more complex things.
Even in the cases where the devices suggests repair, we may not want to for
reasons that device can't know about.

> 
> > With the decision algorithms in userspace, we can design the userspace to kernel
> > interface because we don't care about the algorithm choice - only what it needs
> > to control which is well defined. Algorithms will start simple and then
> > we'll iterate but it won't need changes in this interface because none of it
> > is connected to how we use the data.  
> 
> Are you saying that this interface you have right now is the necessary and
> sufficient set of sysfs nodes which will be enough for most algorithms in
> userspace?
> 
> And you won't have to change it because you realize down the road that it is
> not enough?
> 

The interface provides all the data, and all the controls to match.

Sure, something new might come along that needs additional controls (subchannel
for DDR5 showed up recently for instance and are in v19) but that extension
should be easy and fit within the ABI.  Those new 'features' will need
kernel changes and matching rasdaemon changes anyway as there is new data
in the error records so this sort of extension should be fine.


> > In general an ABI that is used is cast in stone. To my understanding there
> > is nothing special about debugfs.  If we introduce a regression in tooling
> > that uses that interface are we actually any better off than sysfs?
> > https://lwn.net/Articles/309298/ was a good article on this a while back.
> > 
> > Maybe there has been a change of opinion on this that I missed.  
> 
> I don't think so and I can see that article's point. So let's cut to the
> chase: what are we going to do when the sysfs or debugfs nodes you've added
> become insufficient and you or someone else needs to change them in the
> future, for their specific use case?
> 
> The last paragraph of that article basically sums it up pretty nicely.

Agreed. We need an interface we can support indefinitely - there is nothing
different between doing it sysfs or debugfs. That should be
extensible in a clean fashion to support new data and matching control.

We don't have to guarantee that interface supports something 'new' though
as our crystal balls aren't perfect, but we do want to make extending to
cover the new straight forward.

> 
> > Absolutely though the performance impact of punching holes in memory over
> > time is getting some cloud folk pushing back because they can't get their
> > 1GIB pages to put under a VM.  Mind you that's not particularly relevant
> > to this thread.  
> 
> What is relevant to this thread is the fact that you can't simply reboot as
> a RAS recovery action. Not in all cases.

Agreed.  We still have the option to soft offline the memory if there is no
other choice.

> 
> > For this we'll do as we did for scrub control and send a patch set adding tooling
> > to RASdaemon and/or if more appropriate a script along side it.  My fault,
> > I falsely thought this one was more obvious and we could leave that until
> > this landed. Seems not!  
> 
> Sorry, I can't always guess the use case by looking solely at the sysfs nodes.
> 
> > This I agree on. However, if CXL takes off (and there seems to be agreement
> > it will to some degree at least) then this interface is fully general for any spec
> > compliant device.  
> 
> Ok, sounds good.
> 
> > Sure. We can definitely do that.  We have this split in v19 (just undergoing
> > some final docs tidy up etc, should be posted soon).  
> 
> Thx.
> 
> You don't have to rush it - we have merge window anyway.
> 
> > Early devices and the ones in a few years time may make different
> > decisions on this. All options are covered by this driver (autonomous
> > repair is covered for free as nothing to do!)  
> 
> Don't forget devices which deviate from the spec because they were implemented
> wrong. It happens and we have to support them because no one else cares but
> people have already paid for them and want to use them.

Mostly for CXL stuff we've so far avoided that in the upstream code,
but it is indeed the case that quirks will turn up :(

I'd hope the majority can be handled in the CXL specific driver or
by massaging the error records on their way out of the kernel.
For now we have constrained records to have to be complete as defined
by the spec, but I can definitely see we might have a 1 rank only device
that doesn't set the valid bit in the error record for rank.
In discussion with Shiju, we decided that's a case we'll solve in the
driver if it turns out to be relevant.  Maybe we'd quirk the error
report to fill in the missing data for that device, or maybe we'd
relax the constraints on parameters when doing an online repair.
That's a question to resolve if anyone ever builds it!

> 
> > CXL is not vendor specific. Our other driver that I keep referring
> > to as 'coming soon' is though.  I'll see if I can get a few memory
> > device manufacturers to specifically stick their hands up that they
> > care about this. As an example we presented on this topic with
> > Micron at the LPC CXL uconf (+CC Vandana).  I don't have access
> > to Micron parts so this isn't just Huawei using Micron, we simply had two
> > proposals on the same topic so combined the sessions.  We have a CXL
> > open source sync call in an hour so I'll ask there.  
> 
> Having hw vendors agree on a single driver and Linux implementing it would be
> ofc optimal.
> 
> > Maybe for the follow on topic of non persistent repair as a path to
> > avoid offlining memory detected as bad. Maybe that counts
> > as generalization (rather than extension).  But that's not covering
> > our usecase of restablishing the offline at boot, or the persistent
> > usecases.  So it's a value add feature for a follow up effort,
> > not a baseline one which is the intent of this patch set.  
> 
> Ok, I think this whole pile should simply be in two parts: generic, CXL-spec
> implementing, vendor-agnostic pieces and vendor-specific drivers which use
> that.

There is room for vendor specific drivers in that longer term and it
is happening in the CXL core to move from just supporting spec
complaint type 3 devices (the ones that use the class code)
to supporting accelerators (network cards, GPUs etc with local memory).
What we have here is vbuilt on the CXL core that provides services to
all those drivers. The actual opt in etc is coming from the type
3 device driver calling the registration call after finding the
hardware reports the relevant commands.

Overall the CXL subsystem is evolving to allow more reuse for accelerators.
Until recently the only public devices where type 3 memory only, so it
was a guessing game on where those spits should be.  Alejandro and others
are now fleshing that out.  So far no sign of memory repair on those
devices, but if they support it and use standard interfaces, then all good.

(for type 2 support)
https://lore.kernel.org/linux-cxl/20250205151950.25268-1-alucerop@amd.com/T/#t

> 
> It'll be lovely if vendors could agree on this interface you're proposing but
> I won't hold my breath...

True enough that vendors will do silly things.  However, if they want Linux
support for a CXL memory device out of the box the only option they
have is the driver stack that binds to the class code.
Dan and the rest of us are pushing back very hard (possibly too hard)
on vendor defined interfaces etc.  If we don't see at least an effort
to standardize them (not necessarily in the CXL spec, but somewhere)
then their chances of getting upstream support is near 0. There have
been a few 'discussions' about exceptions to this in the past.

Their only option might be fwctl for a few things with it's taints
etc.  The controls used for this set are explicitly excluded from being
used via fwctl:

https://lore.kernel.org/linux-cxl/20250204220430.4146187-1-dave.jiang@intel.com/T/#ma478ae9d7529f31ec6f08c2e98432d5721ca0b0e

If a vendor wants to do their own thing then good luck to them but don't expect
the standard software stack to work.  So far I have seen no sign of anyone
doing a non compliant memory expansion device and there are quite a
few spec compliant ones.

We will get weird memory devices with accelerators perhaps but then that
memory won't be treated as normal memory anyway and likely has a custom
RAS solution.  If they do use the spec defined commands, then this
support should work fine. Just needs a call from their drive to hook
it up.

It might not be the best analogy, but I think of the CXL type 3 device
spec as being similar to NVME. There are lots of options, but most people
will run one standard driver.  There may be custom features but the
device better be compatible with the NVME driver if they advertise
the class code (there are compliance suites etc)

> 
> > Thanks for taking time to continue the discussion and I think we
> > are converging somewhat even if there is further to go.  
> 
> Yap, I think so. A lot of things got cleared up for me too, so thanks too.
> I'm sure you know what the important things are that we need to pay attention
> when it comes to designing this with a broader audience in mind.

I'll encourage a few more memory vendor folk (who have visibility
of more specific implementations / use cases than me) to take another
look at v19 and the user space tooling.  Hopefully they will point
out any remaining holes.

Thanks,

Jonathan


> 
> Thx.
> 


