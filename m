Return-Path: <linux-edac+bounces-2880-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE14A0B5E6
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2025 12:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FD516696F
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2025 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89B622CF1F;
	Mon, 13 Jan 2025 11:40:35 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6885922CF00;
	Mon, 13 Jan 2025 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768435; cv=none; b=Ecz431eJB+mW1pi0Qu24kRer3pQpggpyWfNijio5qscalXqBgn/jyjjv1Fyos0JlI6/imK7VIThlleppRqJFg8Yp9VhibisNVwnEcHbFcDgXgtHecUUy3KRxFvcS7eQseoFEdmZNocB+x4IXRYEpwZEC/aDdOxdGcGl1uqOsw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768435; c=relaxed/simple;
	bh=C3vw2Bv6d6hnMBKQvroRdqj7POPNa1DQP0uud0/pwks=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3n0sV5M+Jx3muuQWT54h4lJtAsWIfhlomhqapiMcZo7oytp2yNlGaG0oIipXqwnk+LqyMPDNZOukIWtrpDXvhsZEXek9mDC4skCCzPm84+5NALJb60qQ9hiZiz92kCM8QOLPxJZwIajlRZGbBrUm+K1fQjMVGaWC+RIn8h+5Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YWqzG1PGqz6L5RZ;
	Mon, 13 Jan 2025 19:39:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C5A3314034E;
	Mon, 13 Jan 2025 19:40:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 13 Jan
 2025 12:40:28 +0100
Date: Mon, 13 Jan 2025 11:40:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Borislav Petkov <bp@alien8.de>, Shiju Jose <shiju.jose@huawei.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>, "erdemaktas@google.com"
	<erdemaktas@google.com>, "pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>, "gthelen@google.com"
	<gthelen@google.com>, "wschwartz@amperecomputing.com"
	<wschwartz@amperecomputing.com>, "dferguson@amperecomputing.com"
	<dferguson@amperecomputing.com>, "wbs@os.amperecomputing.com"
	<wbs@os.amperecomputing.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"Roberto Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250113114026.0000548e@huawei.com>
In-Reply-To: <6781a3dfa53d6_2aff429471@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
	<3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>
	<20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
	<20250109142433.00004ea7@huawei.com>
	<20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
	<20250109160159.00002add@huawei.com>
	<20250109161902.GDZ3_29rH-sQMV4n0N@fat_crate.local>
	<20250109183448.000059ec@huawei.com>
	<6780610bc33e9_9b92294cd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20250110110106.00006cd5@huawei.com>
	<6781a3dfa53d6_2aff429471@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 10 Jan 2025 14:49:03 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Thu, 9 Jan 2025 15:51:39 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > Jonathan Cameron wrote:  
> > > > Ok. Best path is drop the available range support then (so no min_ max_ or
> > > > anything to replace them for now).    
> > > 
> > > I think less is more in this case.  
> > 
> > A few notes before I get to specific questions.
> > 
> > Key in the discussion that follows is that the 'repair' is a separate
> > from the 'decision to repair'.  They mostly need different information
> > all of which is in the error trace points. A lot of the questions
> > are about the 'decision to repair' part not the repair itself.
> >   
> [snipped the parts I agree with]
> > I'd advise mostly ignoring PPR and looking at memory sparing in
> > the CXL spec if you want to consider an example. For PPR DPA is used
> > (there is an HPA option that might be available). DPA is still needed
> > for on boot soft repair (or we could delay that until regions configured,
> > but then we'd need to do DPA to HPA mapping as that will be different
> > on a new config, and then write HPA for the kernel to map it back to DPA.  
> 
> This is helpful because I was indeed getting lost in what kind of
> "repair" was being discussed in the thread. Ok, lets focus on sparing
> commands.
> 
> >   
> > > 
> > > The hpa, dpa, nibble, column, channel, bank, rank, row... ABI looks too
> > > wide for userspace to have a chance at writing a competent tool. At
> > > least I am struggling with where to even begin with those ABIs if I was
> > > asked to write a tool. Does a tool already exist for those?  
> > 
> > There is little choice on that - those are the controls for this type
> > of repair. If we do something like a magic 'key' based on a concatenation
> > of those values we need to define that description to replace a clean
> > self describing interface. I'm not 100% against that but I think it would
> > be a terrible interface design and I don't think anyone is really in favor of it.
> > 
> > All a userspace tool does is read the error record fields of
> > exactly those names.  From that it will log data (already happening under
> > those names in RAS daemon alongside HPA/ DPA).  Then, in simplest case,
> > a threshold is passed and we write those values to the repair interface. 
> > 
> > There is zero need in that simple case for these to be understood at all.  
> 
> This is where you lose me. The error record is a point in time snapshot
> of the SPA:HPA:DPA:<proprietary internal "DIMM" mapping>. The security
> model for memory operations is based on coordinating with the kernel's
> understanding of how that SPA is *currently* being used.

Whilst it is being used I agree.  Key is to only do disruptive / data
changing actions when it is not being used.

> 
> The kernel can not just take userspace's word for it that potentially
> data changing, or temporary loss-of-use operations are safe to execute
> just because once upon a time userspace saw an error record that
> implicated a given SPA in the past, especially over reboot. 

There are two cases (discoverable from hardware)

1) Non disruptive.  No security concern as the device guarantees to
   not interrupt traffic and the memory contents is copied to the new
   location. Basically software never knows it happened.
2) Disruptive.  We only allow this if the memory is offline. In the CXL case
   the CXL specific code must check no memory on the device is online so
   we aren't disrupting anything.  The other implementation we have code
   for (will post after this lands) has finer granularity constraints and only
   the page needs to be offline.
   As it is offline the content is not preserved anyway. We may need to add extra
   constraints along with future support for temporal persistence / sharing but
   we can do that as part of adding that support in general.
   (Personally I think in those cases memory repair is a job for the out of
    band management anyway).

In neither case am I seeing a security concern.  Am I missing something?

> 
> The SPA:HPA:DPA:DIMM tuple is invalidated on reconfiguration and reboot
> events. It follows that the kernel has a security/integrity interest in
> declining to act on invalidated tuples. This is solvable within a single
> boot as the kernel can cache the error records and userspace can ask to
> "trigger sparing based on cached record X".

The above rules remove this complexity.  Either it is always safe by
device design, or the memory is offline and we'll zero fill it anyway
so no security concern.

> 
> For the reboot case when the error record cache is flushed the kernel
> needs a reliable way to refill that cache, not an ABI for userspace to
> say "take my word for it, this *should* be safe".

It is safe because of 1 and 2 above we are not editing data in use
except in a fashion that the device guarantees is safe.

If you don't trust the device on this you have bigger problems.

> 
> [snipped the explanation of replaying the old trace record parameters
> data back through sysfs, because that is precisely the hang up I have
> with the proposal]
> 
> >   
> > > 
> > > Some questions that read on those ABIs are:
> > > 
> > > 1/ What if the platform has translation between HPA (CXL decode) and SPA
> > > (physical addresses reported in trace points that PIO and DMA see)?  
> > 
> > See later for discussion of other interfaces.. This is assuming the
> > repair key is not HPA (it is on some systems / situations) - if it's
> > the repair key then that is easily dealt with.
> > 
> > HPA / SPA more or less irrelevant for repair itself, they are relevant
> > for the decision to repair. In the 'on reboot' soft repair case they may
> > not even exist at the time of repair as it would be expected to happen
> > before we've brought up a region (to get the RAM into a good state at boot).
> > 
> > For cases where the memory decoders are configured and so there is an HPA
> > to DPA mapping:
> > The trace reports provide both all these somewhat magic values and
> > the HPA.  Thus we can do the HPA aware stuff on that before then looking
> > up the other bit of the appropriate error reports to get the bank row etc.
> >   
> > > 
> > > 2/ What if memory is interleaved across repair domains?   
> > 
> > Also not relevant to a repair control and only a little relevant to the
> > decision to repair.  The domains would be handled separately but if
> > we are have to offline a chunk of memory to do it (needed for repair
> > on some devices) that may be a bigger chunk if fine grained interleave
> > in use and that may affect the decision.  
> 
> Again, the repair control assumes that the kernel can just trust
> userspace to get it right. When the kernel knows the SPA implications it
> can add safety like "you are going to issue sparing on deviceA that will
> temporarily take deviceA offline. CXL subsystem tells me deviceA is
> interleaved with deviceB in SPA so the whole SPA range needs to be
> offline before this operation proceeds". That is not someting that
> userspace can reliably coordinate.

Absolutely he kernel has to enforce this. Same way we protect against
poison injection in some cases.  Right now the enforcement is slightly
wrong (Shiju is looking at it again) as we were enforcing at wrong
granularity (specific dpa, not device). Identifying that hole is a good
outcome of this discussion making us take another look.

Enforcing this is one of the key jobs of the CXL specific driver.
We considered doing it in the core, but the granularity differences
between our initial few examples meant we decided on specific driver
implementations of the checks for now.

> 
> > > 3/ What if the device does not use DDR terminology / topology terms for
> > > repair?  
> > 
> > Then we provide the additional interfaces assuming the correspond to well
> > known terms.  If someone is using a magic key then we can get grumpy
> > with them, but that can also be supported.
> > 
> > Mostly I'd expect a new technology to overlap a lot of the existing
> > interface and maybe add one or two more; which layer in the stack for
> > HBM for instance.  
> 
> The concern is the assertion that sysfs needs to care about all these
> parameters vs an ABI that says "repair errorX". If persistence and
> validity of error records is the concern lets build an ABI for that and
> not depend upon trust in userspace to properly coordinate memory
> integrity concerns.

It doesn't have to.  It just has to ensure that the memory device is in the correct
state.  So check, not coordinate. At a larger scale, coordination is already doable
(subject to races that we must avoid by holding locks), tear down the regions
so there are no mappings on the device you want to repair.  Don't bring them
up again until after you are done.

The main use case is probably do it before you bring the mappings up, but
same result.

> 
> > 
> > The main alternative is where the device takes an HPA / SPA / DPA. We have one
> > driver that does that queued up behind this series that uses HPA. PPR uses
> > DPA.  In that case userspace first tries to see if it can repair by HPA then
> > DPA and if not moves on to see if it it can use the fuller description.
> > We will see devices supporting HPA / DPA (which to use depends on when you
> > are doing the operation and what has been configured) but mostly I'd expect
> > either HPA/DPA or fine grained on a given repair instance.
> > 
> > HPA only works if the address decoders are always configured (so not on CXL)
> > What is actually happening in that case is typically that a firmware is
> > involved that can look up address decoders etc, and map the control HPA
> > to Bank / row etc to issue the actual low level commands.  This keeps
> > the memory mapping completely secret rather than exposing it in error
> > records.
> >   
> > > 
> > > I expect the flow rasdaemon would want is that the current PFA (leaky
> > > bucket Pre-Failure Analysis) decides that the number of soft-offlines it
> > > has performed exceeds some threshold and it wants to attempt to repair
> > > memory.  
> > 
> > Sparing may happen prior to point where we'd have done a soft offline
> > if non disruptive (whether it is can be read from another bit of the
> > ABI).  Memory repair might be much less disruptive than soft-offline!
> > I rather hope memory manufacturers build that, but I'm aware of at least
> > one case where they didn't and the memory must be offline.  
> 
> That's a good point, spare before offline makes sense.

If transparent an resources not constrained.
Very much not if we have to tear down the memory first.

> 
> [..]
> > However, there are other usecases where this isn't needed which is why
> > that isn't a precursor for this series.
> > 
> > Initial enablement targets two situations:
> > 1) Repair can be done in non disruptive way - no need to soft offline at all.  
> 
> Modulo needing to quiesce access over the sparing event?

Absolutely.  This is only doable in devices that don't need to quiesce.

> 
> > 2) Repair can be done at boot before memory is onlined or on admin
> >    action to take the whole region offline, then repair specific chunks of
> >    memory before bringing it back online.  
> 
> Which is userspace racing the kernel to online memory?

If you are doing this scheme you don't automatically online memory. So
both are in userspace control and can be easily sequenced.
If you aren't auto onlining then buy devices with hard PPR and do it by offlining
manually, repairing and rebooting. Or buy devices that don't need to quiecse
and cross your fingers the dodgy ram doesn't throw an error before you get
that far.  Little choice if you decide to online right at the start as normal
memory.

> 
> > > So, yes, +1 to simpler for now where software effectively just needs to
> > > deal with a handful of "region repair" buttons and the semantics of
> > > those are coarse and sub-optimal. Wait for a future where a tool author
> > > says, "we have had good success getting bulk offlined pages back into
> > > service, but now we need this specific finer grained kernel interface to
> > > avoid wasting spare banks prematurely".  
> > 
> > Depends on where you think that interface is.  I can absolutely see that
> > as a control to RAS Daemon.  Option 2 above, region is offline, repair
> > all dodgy looking fine grained buckets.
> > 
> > Note though that a suboptimal repair may mean permanent use of very rare
> > resources.  So there needs to be a control a the finest granularity as well.
> > Which order those get added to userspace tools doesn't matter to me.
> > 
> > If you mean that interface in kernel it brings some non trivial requirements.
> > The kernel would need all of:
> > 1) Tracking interface for all error records so the reverse map from region
> >    to specific bank / row etc is available for a subset of entries.  The
> >    kernel would need to know which of those are important (soft offline
> >    might help in that use case, otherwise that means decision algorithms
> >    are in kernel or we have fine grained queue for region repair in parallel
> >    with soft-offline).
> > 2) A way to inject the reverse map information from a userspace store
> >   (to deal with reboot etc).  
> 
> Not a way to inject the reverse map information, a way to inject the
> error records and assert that memory topology changes have not
> invalidated those records.

There is no way to tell that the topology hasn't changed.
For the reasons above, I don't think we care. Instead of trying to stop
userspace reparing the wrong memory, make sure it is safe for it to do that.
(The kernel is rarely in the business of preventing the slightly stupid)

> 
> > That sounds a lot harder to deal with than relying on the usespace program
> > that already does the tracking across boots.  
> 
> I am stuck behind the barrier of userspace must not assume it knows
> better than the kernel about the SPA impact of a DIMM sparing
> event. The kernel needs evidence either live records from within the
> same kernel boot or validated records from a previous boot.

I think this is the wrong approach.  The operation must be 'safe'.
With that in place we absolutely can let userspace assume it knows better than
the kernel. 

> 
> ...devices could also help us out here with a way to replay DIMM error
> events. That would allow for refreshing error records even if the
> memory topology change because the new record would generate a refreshed
> SPA:HPA:DPA:DIMM tuple.

Maybe, but I'm not seeing necessity.

> 
> > > Anything more complex than a set of /sys/devices/system/memory/
> > > devices has a /sys/bus/edac/devices/devX/repair button, feels like a
> > > generation ahead of where the initial sophistication needs to lie.
> > > 
> > > That said, I do not closely follow ras tooling to say whether someone
> > > has already identified the critical need for a fine grained repair ABI?  
> > 
> > It's not that we necessarily want to repair at fine grain, it's that
> > the control interface to hardware is fine grained and the reverse mapping
> > often unknown except for specific error records.
> > 
> > I'm fully on board with simple interfaces for common cases like repair
> > the bad memory in this region.  I'm just strongly against moving the
> > complexity of doing that into the kernel.  
> 
> Yes, we are just caught up on where that "...but no simpler" line is
> drawn.
> 
Sure.  For now, I've proposed we split the two cases.
1) HPA / DPA repair (PPR)
2) Memory topology based repair (Sparing)

If we can make progress on (1) perhaps we can come to a conclusion on what
is required.

Note that so far I see no reason why either should do any checking against
errors observed by the kernel given the security guarantees above.
Userspace can repair the wrong bit of memory. That's pointless and burning
limited resources, but not a security problem.

Jonathan


