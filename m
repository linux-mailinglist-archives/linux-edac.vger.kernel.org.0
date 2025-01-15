Return-Path: <linux-edac+bounces-2918-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC656A11EF1
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 11:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC66188BAF7
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 10:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A74F20CCCE;
	Wed, 15 Jan 2025 10:08:10 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634841E7C22;
	Wed, 15 Jan 2025 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935689; cv=none; b=NzQhDFvQ8WfzM20xpBhiC1iqvZDloL9i5ItXnmNXfr5zawro8uL2hpLvsy4SG6lEklzbMrVlHn2N/yOmen/FTYaqvSyt4UibczCAV+/Nzfmbl1iwxxwsg7QXUd/fCvUU3yit4yn6I4M7gscw4eHQgkeKbrz4AGiYps3SXbR0VUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935689; c=relaxed/simple;
	bh=P/dVDwWgEoHHee1z3BcZKO0YGF23HZG/cTEzAh7CZb4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfFhHFgiJYhXHJKuXPyz8+BDY78QAbvgl9HrYEelRGXzfmFrZtSCpNdcCh8a+lxugXv+/PJcif+JrlmCHfMaMDSaoeh/jSGXh+tePTRT4wGDjlWjofJTzMNk+TAhavYfxV1enb8Wk4jvMoe9TAgZmA0PL8kjCm+W1O58YXHXLYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YY1q71rmZz6M4YM;
	Wed, 15 Jan 2025 18:06:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 30EB9140A35;
	Wed, 15 Jan 2025 18:07:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 15 Jan
 2025 11:07:53 +0100
Date: Wed, 15 Jan 2025 10:07:51 +0000
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
Message-ID: <20250115100751.00001b73@huawei.com>
In-Reply-To: <6786bc792c66a_20f3294ce@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
	<20250109142433.00004ea7@huawei.com>
	<20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
	<20250109160159.00002add@huawei.com>
	<20250109161902.GDZ3_29rH-sQMV4n0N@fat_crate.local>
	<20250109183448.000059ec@huawei.com>
	<6780610bc33e9_9b92294cd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20250110110106.00006cd5@huawei.com>
	<6781a3dfa53d6_2aff429471@dwillia2-xfh.jf.intel.com.notmuch>
	<20250113114026.0000548e@huawei.com>
	<6786bc792c66a_20f3294ce@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 14 Jan 2025 11:35:21 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Fri, 10 Jan 2025 14:49:03 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:  
> [..]
> > > This is where you lose me. The error record is a point in time snapshot
> > > of the SPA:HPA:DPA:<proprietary internal "DIMM" mapping>. The security
> > > model for memory operations is based on coordinating with the kernel's
> > > understanding of how that SPA is *currently* being used.  
> > 
> > Whilst it is being used I agree.  Key is to only do disruptive / data
> > changing actions when it is not being used.  
> 
> Sure.
> 
> > > The kernel can not just take userspace's word for it that potentially
> > > data changing, or temporary loss-of-use operations are safe to execute
> > > just because once upon a time userspace saw an error record that
> > > implicated a given SPA in the past, especially over reboot.   
> > 
> > There are two cases (discoverable from hardware)
> > 
> > 1) Non disruptive.  No security concern as the device guarantees to
> >    not interrupt traffic and the memory contents is copied to the new
> >    location. Basically software never knows it happened.
> > 2) Disruptive.  We only allow this if the memory is offline. In the CXL case
> >    the CXL specific code must check no memory on the device is online so
> >    we aren't disrupting anything.  The other implementation we have code
> >    for (will post after this lands) has finer granularity constraints and only
> >    the page needs to be offline.
> >    As it is offline the content is not preserved anyway. We may need to add extra
> >    constraints along with future support for temporal persistence / sharing but
> >    we can do that as part of adding that support in general.
> >    (Personally I think in those cases memory repair is a job for the out of
> >     band management anyway).
> > 
> > In neither case am I seeing a security concern.  Am I missing something?  
> 
> s/security/system-integrity/
> 
> 1/ Hardware engineers may have a different definition of "non-disuptive"
> than software. See the history around hibernate_quiet_exec() to work
> around the disruption of latency spikes. If this is poorly specified
> across vendors we are going to wish that we did not build a "take
> userspace's word for it" interface.

Sure, but given the spec is fairly specific "CXL.mem requests are correctly
preserved and data is retained" they will have to stay with latency
requirements of the CXL system.  If a device breaks these admittedly soft
rules then we can add allow / deny lists or let userspace tooling handle
that (which I'd prefer).  Note that this stuff happens on some devices
under the hood anyway, so I'd not expect the command driven case to be
much worse (but I accept it might be).

I'd also expect some very grumpy large purchasers of that device to get
the firmware changed to not advertise that it is fine to do it live if
the performance drop is large.

Note this happens today under the hood on at least some (I think most?)
servers.  Have you ever seen a latency bug report from memory sparing?
How often?  The memory and controllers on CXL devices are going to be very
similar in technology to host memory controllers so I can't see why they'd
be much worse (subject of course to cheap and nasty maybe turning up - I doubt
that will be common given the cost of the RAM behind these things).

This applies just as much however we implement this interface. So a concern
but not one specific to the 'how' part.

> 
> 2/ Yes, if the device is not actively decoding any in use memory feel
> free to run destructive operations on the device. However, is sysfs the
> right interface for "submit multi-parameter atomic operation with
> transient result"? I lean heavily into sysfs, but ioctl and netlink have
> a role to play in scenarios like this. Otherwise userspace can inject
> error records back into the kernel with the expectation that the kernel
> can only accept the DIMM address and not any of the translation data
> which might be stale.

I'd argue yes to the sysfs question.  This is common enough for other
subsystems (e.g. CXL - I still do all tests with bash scripts!) and this
really isn't a particularly complex interface. I'd expect very
light weight tooling to be able to use it (though solutions to work out
whether to do it are way more complex). It is a simple more or less self
describing interface that directly exposes what controls are available.

If we end up reinjecting error records (which I'm still pushing back
strongly on because I am yet to see any reason to do so) then maybe
sysfs is not the right interface.  Pushing it to netlink or ioctl
doesn't change the complexity of the interface, so I'm not sure there
is any strong reason to do so.  Files are cheap and easy to use from
all manner of simple scripting.  I think from later discussion below
that we don't need to reinject which is nice!

> 
> [..]
> > > Again, the repair control assumes that the kernel can just trust
> > > userspace to get it right. When the kernel knows the SPA implications it
> > > can add safety like "you are going to issue sparing on deviceA that will
> > > temporarily take deviceA offline. CXL subsystem tells me deviceA is
> > > interleaved with deviceB in SPA so the whole SPA range needs to be
> > > offline before this operation proceeds". That is not someting that
> > > userspace can reliably coordinate.  
> > 
> > Absolutely he kernel has to enforce this. Same way we protect against
> > poison injection in some cases.  Right now the enforcement is slightly
> > wrong (Shiju is looking at it again) as we were enforcing at wrong
> > granularity (specific dpa, not device). Identifying that hole is a good
> > outcome of this discussion making us take another look.
> > 
> > Enforcing this is one of the key jobs of the CXL specific driver.
> > We considered doing it in the core, but the granularity differences
> > between our initial few examples meant we decided on specific driver
> > implementations of the checks for now.  
> 
> Which specific driver? Is this not just a callback provided via the EDAC
> registration interface to say "sparing allowed"?

That would be a reasonable interface to add. There was push back in earlier
reviews on an explicit query so we backed away from this sort of thing.
The question IIRC was what was the point in querying given we could just
try it and rapidly see an error if it can't. There is a callback to say
it is disruptive but it is an exercise for userspace to figure out what
it needs to do to allow the request to succeed.

The granularity varies across the two sparing implementations I have access
to, so this interface would just be a 'can I do it now?'  Whether that
is helpful given userspace will have to be involved in getting that answer
to be 'yes' is not entirely clear to me.

So interesting thought, but I'm not yet convinced this isn't a userspace
problem + the suck it and see call to find out the answer.

> 
> Yes, this needs to avoid the midlayer mistake, but I expect more CXL
> memory exporting devices can live with the CXL core's determination that
> HDM decode is live or not.

I think this is valid for the ones that advertise that they need the
traffic to stop. From later in discussion I think we are aligned on that.

> 
> > > > > 3/ What if the device does not use DDR terminology / topology terms for
> > > > > repair?    
> > > > 
> > > > Then we provide the additional interfaces assuming the correspond to well
> > > > known terms.  If someone is using a magic key then we can get grumpy
> > > > with them, but that can also be supported.
> > > > 
> > > > Mostly I'd expect a new technology to overlap a lot of the existing
> > > > interface and maybe add one or two more; which layer in the stack for
> > > > HBM for instance.    
> > > 
> > > The concern is the assertion that sysfs needs to care about all these
> > > parameters vs an ABI that says "repair errorX". If persistence and
> > > validity of error records is the concern lets build an ABI for that and
> > > not depend upon trust in userspace to properly coordinate memory
> > > integrity concerns.  
> > 
> > It doesn't have to.  It just has to ensure that the memory device is in the correct
> > state.  So check, not coordinate. At a larger scale, coordination is already doable
> > (subject to races that we must avoid by holding locks), tear down the regions
> > so there are no mappings on the device you want to repair.  Don't bring them
> > up again until after you are done.
> > 
> > The main use case is probably do it before you bring the mappings up, but
> > same result.  
> 
> Agree.
> 
> >   
> > >   
> > > > 
> > > > The main alternative is where the device takes an HPA / SPA / DPA. We have one
> > > > driver that does that queued up behind this series that uses HPA. PPR uses
> > > > DPA.  In that case userspace first tries to see if it can repair by HPA then
> > > > DPA and if not moves on to see if it it can use the fuller description.
> > > > We will see devices supporting HPA / DPA (which to use depends on when you
> > > > are doing the operation and what has been configured) but mostly I'd expect
> > > > either HPA/DPA or fine grained on a given repair instance.
> > > > 
> > > > HPA only works if the address decoders are always configured (so not on CXL)
> > > > What is actually happening in that case is typically that a firmware is
> > > > involved that can look up address decoders etc, and map the control HPA
> > > > to Bank / row etc to issue the actual low level commands.  This keeps
> > > > the memory mapping completely secret rather than exposing it in error
> > > > records.
> > > >     
> > > > > 
> > > > > I expect the flow rasdaemon would want is that the current PFA (leaky
> > > > > bucket Pre-Failure Analysis) decides that the number of soft-offlines it
> > > > > has performed exceeds some threshold and it wants to attempt to repair
> > > > > memory.    
> > > > 
> > > > Sparing may happen prior to point where we'd have done a soft offline
> > > > if non disruptive (whether it is can be read from another bit of the
> > > > ABI).  Memory repair might be much less disruptive than soft-offline!
> > > > I rather hope memory manufacturers build that, but I'm aware of at least
> > > > one case where they didn't and the memory must be offline.    
> > > 
> > > That's a good point, spare before offline makes sense.  
> > 
> > If transparent an resources not constrained.
> > Very much not if we have to tear down the memory first.
> >   
> > > 
> > > [..]  
> > > > However, there are other usecases where this isn't needed which is why
> > > > that isn't a precursor for this series.
> > > > 
> > > > Initial enablement targets two situations:
> > > > 1) Repair can be done in non disruptive way - no need to soft offline at all.    
> > > 
> > > Modulo needing to quiesce access over the sparing event?  
> > 
> > Absolutely.  This is only doable in devices that don't need to quiesce.
> >   
> > >   
> > > > 2) Repair can be done at boot before memory is onlined or on admin
> > > >    action to take the whole region offline, then repair specific chunks of
> > > >    memory before bringing it back online.    
> > > 
> > > Which is userspace racing the kernel to online memory?  
> > 
> > If you are doing this scheme you don't automatically online memory. So
> > both are in userspace control and can be easily sequenced.
> > If you aren't auto onlining then buy devices with hard PPR and do it by offlining
> > manually, repairing and rebooting. Or buy devices that don't need to quiecse
> > and cross your fingers the dodgy ram doesn't throw an error before you get
> > that far.  Little choice if you decide to online right at the start as normal
> > memory.
> >   
> > >   
> > > > > So, yes, +1 to simpler for now where software effectively just needs to
> > > > > deal with a handful of "region repair" buttons and the semantics of
> > > > > those are coarse and sub-optimal. Wait for a future where a tool author
> > > > > says, "we have had good success getting bulk offlined pages back into
> > > > > service, but now we need this specific finer grained kernel interface to
> > > > > avoid wasting spare banks prematurely".    
> > > > 
> > > > Depends on where you think that interface is.  I can absolutely see that
> > > > as a control to RAS Daemon.  Option 2 above, region is offline, repair
> > > > all dodgy looking fine grained buckets.
> > > > 
> > > > Note though that a suboptimal repair may mean permanent use of very rare
> > > > resources.  So there needs to be a control a the finest granularity as well.
> > > > Which order those get added to userspace tools doesn't matter to me.
> > > > 
> > > > If you mean that interface in kernel it brings some non trivial requirements.
> > > > The kernel would need all of:
> > > > 1) Tracking interface for all error records so the reverse map from region
> > > >    to specific bank / row etc is available for a subset of entries.  The
> > > >    kernel would need to know which of those are important (soft offline
> > > >    might help in that use case, otherwise that means decision algorithms
> > > >    are in kernel or we have fine grained queue for region repair in parallel
> > > >    with soft-offline).
> > > > 2) A way to inject the reverse map information from a userspace store
> > > >   (to deal with reboot etc).    
> > > 
> > > Not a way to inject the reverse map information, a way to inject the
> > > error records and assert that memory topology changes have not
> > > invalidated those records.  
> > 
> > There is no way to tell that the topology hasn't changed.
> > For the reasons above, I don't think we care. Instead of trying to stop
> > userspace reparing the wrong memory, make sure it is safe for it to do that.
> > (The kernel is rarely in the business of preventing the slightly stupid)  
> 
> If the policy is "error records with SPA from the current boot can be
> trusted" and "userspace requests outside of current boot error records
> must only be submitted to known offline" then I think we are aligned.

Ok, I'm not sure the requirement is clear, but given that is probably not
too bad to do and we can rip it out later if it turns out to be overkill.
I'll discuss this with Shiju and others later today.

For now I think this belongs in the specific drivers, not the core
as they will be tracking different things and getting the data
from different paths.

How we make this work with other error records is going to be more painful but
should be easy enough for CXL non firmware first reporting. Other sources
of records can come later.

Eventually we might end up with a top level PA check in the EDAC core code,
and additional optional checks in the drivers, or factor out the shared bit
as library code. Not sure yet.

> 
> > > > That sounds a lot harder to deal with than relying on the usespace program
> > > > that already does the tracking across boots.    
> > > 
> > > I am stuck behind the barrier of userspace must not assume it knows
> > > better than the kernel about the SPA impact of a DIMM sparing
> > > event. The kernel needs evidence either live records from within the
> > > same kernel boot or validated records from a previous boot.  
> > 
> > I think this is the wrong approach.  The operation must be 'safe'.
> > With that in place we absolutely can let userspace assume it knows better than
> > the kernel.   
> 
> Violent agreement? Operation must be safe, yes, next what are the criteria
> for kernel management of safety. Offline-only repair is great place to
> be.

Offline makes life easy but removes a significant usecase - the above extra
checks bring that back so may give a way forwards.  The combination
of 'only previous records' and online isn't an important one as you can
act on them before it is online.

So 'maybe' a path forwards that adds extra guarantees.  I'm not convinced
we need them, but it seems to not restrict real usecases so not too bad.

Jonathan

