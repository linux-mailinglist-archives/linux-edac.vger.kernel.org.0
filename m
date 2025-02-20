Return-Path: <linux-edac+bounces-3170-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 485D1A3D9BF
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 13:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56694204A8
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BD51F8670;
	Thu, 20 Feb 2025 12:19:25 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F11C1F582A;
	Thu, 20 Feb 2025 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053965; cv=none; b=GRlnWO+rr/rPjJ6RrYuQhvDbeDwPqb42Neb24FdrhvkfXcoL5+/g4Xrell3kuTqUpLH+SzLAKyoTUO8D+YzgiFJOtZtT20z8Bi/8kI9LFPIuYHtXiwADbSNZ+t6QwkooBSLA2EutkSiGCWNT5bosiW5sIm+hMKzjVUDO3xadKJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053965; c=relaxed/simple;
	bh=DY0KP4iwrTYG2pXg4GoCemRkht2uRnkGK9mkmW+EEfg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ErL8AbFIw/vktN+D+nqKB8Q07T6wNYbVOB4J1Ku9S7q1Es2E1AXMdgWW0HEsk5DeEKiWOhbk2u2d9jD9GyOvWeMd4ezJP38zaN59rKZkAj67vkcFRafOU9LRjPCd6wwMAV/9o/lAgiTgrGD4rZT846v1Aulxy3WTAuT+2tRK2ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzC091d91z6H6w3;
	Thu, 20 Feb 2025 20:15:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BBB5C140B33;
	Thu, 20 Feb 2025 20:19:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Feb
 2025 13:19:17 +0100
Date: Thu, 20 Feb 2025 12:19:15 +0000
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
	Linuxarm <linuxarm@huawei.com>, Vandana Salve <vsalve@micron.com>, "Steven
 Rostedt" <rostedt@goodmis.org>
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250220121915.00001391@huawei.com>
In-Reply-To: <20250219184533.GCZ7YmzTDk5B4p-C7e@fat_crate.local>
References: <20250109161902.GDZ3_29rH-sQMV4n0N@fat_crate.local>
	<20250109183448.000059ec@huawei.com>
	<20250111171243.GCZ4Kmi5xMtY2ktCHm@fat_crate.local>
	<20250113110740.00003a7c@huawei.com>
	<20250121161653.GAZ4_IdYDQ9_-QoEvn@fat_crate.local>
	<20250121181632.0000637c@huawei.com>
	<20250122190917.GDZ5FCXetp9--djyQ6@fat_crate.local>
	<20250206133949.00006dd6@huawei.com>
	<20250217132322.GCZ7M4Somf2VYvbwHb@fat_crate.local>
	<20250218165125.00007065@huawei.com>
	<20250219184533.GCZ7YmzTDk5B4p-C7e@fat_crate.local>
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

On Wed, 19 Feb 2025 19:45:33 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Feb 18, 2025 at 04:51:25PM +0000, Jonathan Cameron wrote:
> > As a side note, if you are in the situation where the device can do
> > memory repair without any disruption of memory access then my
> > assumption is in the case where the device would set the maintenance
> > needed + where it is considering soft repair (so no long term cost
> > to a wrong decision) then the device would probably just do it
> > autonomously and at most we might get a notification.  
> 
> And this is basically what I'm trying to hint at: if you can do recovery
> action without userspace involvement, then please, by all means. There's no
> need to noodle information back'n'forth through user if the kernel or the
> device itself even, can handle it on its own.
> 
> More involved stuff should obviously rely on userspace to do more involved
> "pondering."

Lets explore this further as a follow up. A policy switch to let the kernel
do the 'easy' stuff (assuming device didn't do it) makes sense if this
particular combination is common.

> 
> > So I think that if we see this there will be some disruption.
> > Latency spikes for soft repair or we are looking at hard repair.
> > In that case we'd need policy on whether to repair at all.
> > In general the rasdaemon handling in that series is intentionally
> > simplistic. Real solutions will take time to refine but they
> > don't need changes to the kernel interface, just when to poke it.  
> 
> I hope so.
> 
> > The error record comes out as a trace point. Is there any precedence for
> > injecting those back into the kernel?   
> 
> I'm just questioning the whole interface and its usability. Not saying it
> doesn't make sense - we're simply weighing all options here.
> 
> > That policy question is a long term one but I can suggest 'possible' policies
> > that might help motivate the discussion
> >
> > 1. Repair may be very disruptive to memory latency. Delay until a maintenance
> >    window when latency spike is accepted by the customer until then rely on
> >    maintenance needed still representing a relatively low chance of failure.  
> 
> So during the maintenance window, the operator is supposed to do
> 
> rasdaemon --start-expensive-repair-operations

Yes, would be something along those lines.  Or a script very similar to the
the boot one Shiju wrote.  Scan the DB and find what needs repairing + do so.

> 
> ?
> 
> > 2. Hard repair uses known limited resources - e.g. those are known to match up
> >    to a particular number of rows in each module. That is not discoverable under
> >    the CXL spec so would have to come from another source of metadata.
> >    Apply some sort of fall off function so that we repair only the very worst
> >    cases as we run out. Alternative is always soft offline the memory in the OS,
> >    aim is to reduce chance of having to do that a somewhat optimal fashion.
> >    I'm not sure on the appropriate stats, maybe assume a given granual failure
> >    rate follows a Poison distribution and attempt to estimate lambda?  Would
> >    need an expert in appropriate failure modes or a lot of data to define
> >    this!  
> 
> I have no clue what you're saying here. :-)

I'll write something up at some point as it's definitely a complex
topic and I need to find a statistician + hardware folk with error models to
help flesh it out. 

There is another topic to look at which is what to do with synchronous poison
if we can repair the memory and bring it back into use.
I can't find the thread, but last time I asked about recovering from that, the
mm folk said they'd need to see the code + usecases (fair enough!).

> 
> > It is the simplest interface that we have come up with so far. I'm fully open
> > to alternatives that provide a clean way to get this data back into the
> > kernel and play well with existing logging tooling (e.g. rasdaemon)
> > 
> > Some things we could do,
> > * Store binary of trace event and reinject. As above + we would have to be
> >   very careful that any changes to the event are made with knowledge that
> >   we need to handle this path.  Little or now marshaling / formatting code
> >   in userspace, but new logging infrastructure needed + a chardev /ioctl
> >   to inject the data and a bit of userspace glue to talk to it.
> > * Reinject a binary representation we define, via an ioctl on some
> >   chardev we create for the purpose.  Userspace code has to take
> >   key value pairs and process them into this form.  So similar amount
> >   of marshaling code to what we have for sysfs.
> > * Or what we currently propose, write set of key value pairs to a simple
> >   (though multifile) sysfs interface. As you've noted marshaling is needed.  
> 
> ... and the advantage of having such a sysfs interface: it is human readable
> and usable vs having to use a tool to create a binary blob in a certain
> format...
> 
> Ok, then. Let's give that API a try... I guess I need to pick up the EDAC
> patches from here:
> 
> https://lore.kernel.org/r/20250212143654.1893-1-shiju.jose@huawei.com
> 
> If so, there's an EDAC patch 14 which is not together with the first 4. And
> I was thinking of taking the first 4 or 5 and then giving other folks an
> immutable branch in the EDAC tree which they can use to base the CXL stuff on
> top.
> 
> What's up?

My fault. I asked Shiju to split the more complex ABI for sparing out
to build the complexity up rather than having it all in one patch.

Should be fine for you to take 1-4 and 14 which is all the EDAC parts.

For 5 and 6 Rafael acked the ACPI part (5), and the ACPI ras2 scrub driver
has no other dependencies so I think that should go through your
tree as well, though no need to be in the immutable branch.

Dave Jiang can work his magic on the CXL stuff on top of a merge of your
immutable branch.

Thanks!

Jonathan
> 


