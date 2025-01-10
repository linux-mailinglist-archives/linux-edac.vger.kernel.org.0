Return-Path: <linux-edac+bounces-2859-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF4DA08EC5
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 12:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01CC188D0E1
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 11:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677E120C004;
	Fri, 10 Jan 2025 11:01:15 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52CC20CCDB;
	Fri, 10 Jan 2025 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736506875; cv=none; b=hzR6bDht6Y7YgYE8/zWQzTrpQqFlMTFKKzM4BCKWTBmhEreS0A1yCStiRyOQZQpUP93S23MJeQtAovh6aI+TVHQSCQtD6YT7TtlTfntvwLIiZydTcM16Y6z+gDTI+U04E/sERCDPA4ZJkAsZb9+g5/8+5E9EixYQ8c3mzqTDdMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736506875; c=relaxed/simple;
	bh=v+ODeeszsAGLfK7D4TGnwjYzy93Yf3zVkPDsS8Qp2gk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKGRONNwNItmvPWFStBhXHLQEtlbcln32/AB3WGz2Pl29B7E3OgjBVjij30bJ9WGKRKC1oiYE16idyIjIFY+bzKUOZYevS398AYDqoii8KEmlPpWxxf9sFz99klGNvdH/B+z3rRTJOU/E/2ZqqPlnzczG+2bD1ATfPuYKNvXDdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YTzDz4KRQz6GFHH;
	Fri, 10 Jan 2025 18:59:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 61672140D26;
	Fri, 10 Jan 2025 19:01:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 10 Jan
 2025 12:01:07 +0100
Date: Fri, 10 Jan 2025 11:01:06 +0000
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
Message-ID: <20250110110106.00006cd5@huawei.com>
In-Reply-To: <6780610bc33e9_9b92294cd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
	<6780610bc33e9_9b92294cd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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

On Thu, 9 Jan 2025 15:51:39 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > Ok. Best path is drop the available range support then (so no min_ max_ or
> > anything to replace them for now).  
> 
> I think less is more in this case.

A few notes before I get to specific questions.

Key in the discussion that follows is that the 'repair' is a separate
from the 'decision to repair'.  They mostly need different information
all of which is in the error trace points. A lot of the questions
are about the 'decision to repair' part not the repair itself.

Critical point is there is on some devices (all CXL ones), there may
be no direct way to discover the mapping from HPA/SPA/DPA to bank row etc
other than the error record. The memory mapping functions are an internal
detail not exposed on any interfaces. Odd though it may seem, those
mapping functions are considered confidential enough that manufacturers
don't always publish them (though I believe they are fairly easy to reverse
engineer) - I know a team whose job involves designing those.

Anyhow, short of the kernel or RAS Daemon carrying a look up table
of all known devices (no support for new ones until they are added) we
can't do a reverse map from DPA etc to bank. There are complex ways
round this like storing the mappings when issuing an error record,
to build up the necessary reverse map, but that would have to be
preserved across boot. These error tend not to be frequent, so cross
reboot /kexec etc need to be incorporated.

PPR on CXL does use DPA, but memory sparing commands are meant to
supersede that interface (the reason for that is perhaps bordering on
consortium confidential, but lets say it doesn't work well for some
cases). Memory sparing does not use DPA.

I'd advise mostly ignoring PPR and looking at memory sparing in
the CXL spec if you want to consider an example. For PPR DPA is used
(there is an HPA option that might be available). DPA is still needed
for on boot soft repair (or we could delay that until regions configured,
but then we'd need to do DPA to HPA mapping as that will be different
on a new config, and then write HPA for the kernel to map it back to DPA.

> 
> The hpa, dpa, nibble, column, channel, bank, rank, row... ABI looks too
> wide for userspace to have a chance at writing a competent tool. At
> least I am struggling with where to even begin with those ABIs if I was
> asked to write a tool. Does a tool already exist for those?

There is little choice on that - those are the controls for this type
of repair. If we do something like a magic 'key' based on a concatenation
of those values we need to define that description to replace a clean
self describing interface. I'm not 100% against that but I think it would
be a terrible interface design and I don't think anyone is really in favor of it.

All a userspace tool does is read the error record fields of
exactly those names.  From that it will log data (already happening under
those names in RAS daemon alongside HPA/ DPA).  Then, in simplest case,
a threshold is passed and we write those values to the repair interface. 

There is zero need in that simple case for these to be understood at all.
You can think of them as a complex key but divided into well defined fields. 

For more complex decision algorithms, that structure info may be needed
to make the decision. As a dumb example, maybe certain banks are more
error prone on a batch of devices so we need a lower threshold before repairing.

Simplest case is maybe 20-30 lines of code looping over result of an SQL
query on the RASDaemon DB and writing the values to the files.
Not the most challenging userspace tool.  The complexity is in
the analysis of the errors, not this part. I don't think we bothered
doing this one yet in rasdaemon because we considered it obvious enough
an example wasn't needed. (Mauro / Shiju, does that estimate sound reasonable?)
We would need a couple of variants but those map 1:1 with the variants of
error record parsing and logging RAS Daemon already has.

> 
> Some questions that read on those ABIs are:
> 
> 1/ What if the platform has translation between HPA (CXL decode) and SPA
> (physical addresses reported in trace points that PIO and DMA see)?

See later for discussion of other interfaces.. This is assuming the
repair key is not HPA (it is on some systems / situations) - if it's
the repair key then that is easily dealt with.

HPA / SPA more or less irrelevant for repair itself, they are relevant
for the decision to repair. In the 'on reboot' soft repair case they may
not even exist at the time of repair as it would be expected to happen
before we've brought up a region (to get the RAM into a good state at boot).

For cases where the memory decoders are configured and so there is an HPA
to DPA mapping:
The trace reports provide both all these somewhat magic values and
the HPA.  Thus we can do the HPA aware stuff on that before then looking
up the other bit of the appropriate error reports to get the bank row etc.

> 
> 2/ What if memory is interleaved across repair domains? 

Also not relevant to a repair control and only a little relevant to the
decision to repair.  The domains would be handled separately but if
we are have to offline a chunk of memory to do it (needed for repair
on some devices) that may be a bigger chunk if fine grained interleave
in use and that may affect the decision.

> 
> 3/ What if the device does not use DDR terminology / topology terms for
> repair?

Then we provide the additional interfaces assuming the correspond to well
known terms.  If someone is using a magic key then we can get grumpy
with them, but that can also be supported.

Mostly I'd expect a new technology to overlap a lot of the existing
interface and maybe add one or two more; which layer in the stack for
HBM for instance.

The main alternative is where the device takes an HPA / SPA / DPA. We have one
driver that does that queued up behind this series that uses HPA. PPR uses
DPA.  In that case userspace first tries to see if it can repair by HPA then
DPA and if not moves on to see if it it can use the fuller description.
We will see devices supporting HPA / DPA (which to use depends on when you
are doing the operation and what has been configured) but mostly I'd expect
either HPA/DPA or fine grained on a given repair instance.

HPA only works if the address decoders are always configured (so not on CXL)
What is actually happening in that case is typically that a firmware is
involved that can look up address decoders etc, and map the control HPA
to Bank / row etc to issue the actual low level commands.  This keeps
the memory mapping completely secret rather than exposing it in error
records.

> 
> I expect the flow rasdaemon would want is that the current PFA (leaky
> bucket Pre-Failure Analysis) decides that the number of soft-offlines it
> has performed exceeds some threshold and it wants to attempt to repair
> memory.

Sparing may happen prior to point where we'd have done a soft offline
if non disruptive (whether it is can be read from another bit of the
ABI).  Memory repair might be much less disruptive than soft-offline!
I rather hope memory manufacturers build that, but I'm aware of at least
one case where they didn't and the memory must be offline.

> 
> However, what is missing today for volatile memory is that some failures
> can be repaired with in-band writes and some failures need heavier
> hammers like Post-Package-Repair to actively swap in whole new banks of
> memory. So don't we need something like "soft-offline-undo" on the way
> to PPR?

Ultimately we may do. That discussion was in one of the earlier threads
on more heavy weight case of recovery from poison (unfortunately I can't
find the thread) - the ask was for example code so that the complexity
could be weighed against the demand for this sort of live repair or a lesser
version where repair can only be done once a region is offline (and parts
poisoned).

However, there are other usecases where this isn't needed which is why
that isn't a precursor for this series.

Initial enablement targets two situations:
1) Repair can be done in non disruptive way - no need to soft offline at all.
2) Repair can be done at boot before memory is onlined or on admin
   action to take the whole region offline, then repair specific chunks of
   memory before bringing it back online.

> 
> So, yes, +1 to simpler for now where software effectively just needs to
> deal with a handful of "region repair" buttons and the semantics of
> those are coarse and sub-optimal. Wait for a future where a tool author
> says, "we have had good success getting bulk offlined pages back into
> service, but now we need this specific finer grained kernel interface to
> avoid wasting spare banks prematurely".

Depends on where you think that interface is.  I can absolutely see that
as a control to RAS Daemon.  Option 2 above, region is offline, repair
all dodgy looking fine grained buckets.

Note though that a suboptimal repair may mean permanent use of very rare
resources.  So there needs to be a control a the finest granularity as well.
Which order those get added to userspace tools doesn't matter to me.

If you mean that interface in kernel it brings some non trivial requirements.
The kernel would need all of:
1) Tracking interface for all error records so the reverse map from region
   to specific bank / row etc is available for a subset of entries.  The
   kernel would need to know which of those are important (soft offline
   might help in that use case, otherwise that means decision algorithms
   are in kernel or we have fine grained queue for region repair in parallel
   with soft-offline).
2) A way to inject the reverse map information from a userspace store
  (to deal with reboot etc).

That sounds a lot harder to deal with than relying on the usespace program
that already does the tracking across boots.

> 
> Anything more complex than a set of /sys/devices/system/memory/
> devices has a /sys/bus/edac/devices/devX/repair button, feels like a
> generation ahead of where the initial sophistication needs to lie.
> 
> That said, I do not closely follow ras tooling to say whether someone
> has already identified the critical need for a fine grained repair ABI?

It's not that we necessarily want to repair at fine grain, it's that
the control interface to hardware is fine grained and the reverse mapping
often unknown except for specific error records.

I'm fully on board with simple interfaces for common cases like repair
the bad memory in this region.  I'm just strongly against moving the
complexity of doing that into the kernel.

Jonathan

> 


