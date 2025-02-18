Return-Path: <linux-edac+bounces-3143-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCDFA3A334
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 17:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF39C3A8DE5
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 16:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DD526E65E;
	Tue, 18 Feb 2025 16:51:36 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01C22A80F;
	Tue, 18 Feb 2025 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897496; cv=none; b=NVKvB9r3H5ToAE90hTmUs2zLmMjtFjffnauZDogvaHlA7IUxvK+9BwnSerWsEx9yWeXNQj558PMautsEeFBLvwJkxCJSKQPBxI4vevaCG2BY0iPcZiJbBNLTx8ynyDLBWsA/jx2EY0krGcvxXBNCQdlJicvtUbi53gjvvB+GTSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897496; c=relaxed/simple;
	bh=nzWJpx9BVAaZk815sElCWr4+NdgxJeVWKdea1ra9JsQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtCCfpOjhtZSbwzn2dM57jzmiE6c3cjbYwca+5X7nDReWDy2o5EFf46YT53XNISoYfyHn3A3pxNCOu0OzIFnxWYJKKCCJ3c9Pq42WELWnHvS/5fIkWa2qr40JZkMB0m306hRWu8zYjKvmuEkYh/g82h2eWox5v6oD9JuPWTR0ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yy59H2b1qz6D8cb;
	Wed, 19 Feb 2025 00:49:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 94172140133;
	Wed, 19 Feb 2025 00:51:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 18 Feb
 2025 17:51:26 +0100
Date: Tue, 18 Feb 2025 16:51:25 +0000
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
Message-ID: <20250218165125.00007065@huawei.com>
In-Reply-To: <20250217132322.GCZ7M4Somf2VYvbwHb@fat_crate.local>
References: <20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
	<20250109160159.00002add@huawei.com>
	<20250109161902.GDZ3_29rH-sQMV4n0N@fat_crate.local>
	<20250109183448.000059ec@huawei.com>
	<20250111171243.GCZ4Kmi5xMtY2ktCHm@fat_crate.local>
	<20250113110740.00003a7c@huawei.com>
	<20250121161653.GAZ4_IdYDQ9_-QoEvn@fat_crate.local>
	<20250121181632.0000637c@huawei.com>
	<20250122190917.GDZ5FCXetp9--djyQ6@fat_crate.local>
	<20250206133949.00006dd6@huawei.com>
	<20250217132322.GCZ7M4Somf2VYvbwHb@fat_crate.local>
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

On Mon, 17 Feb 2025 14:23:22 +0100
Borislav Petkov <bp@alien8.de> wrote:

+CC Steven for question about using tracepoints as injection ABI.

> On Thu, Feb 06, 2025 at 01:39:49PM +0000, Jonathan Cameron wrote:
> > Shiju is just finalizing a v19 + the userspace code.  So may make
> > sense to read this reply only after that is out!  
> 
> Saw them.
> 
> So, from a cursory view, all that sysfs marshalling that happens in patch
> 1 and 2 here:
> 
> https://lore.kernel.org/r/20250207143028.1865-1-shiju.jose@huawei.com
> 
> is not really needed, AFAICT.
> 
> You can basically check CXL_EVENT_RECORD_FLAG_MAINT_NEEDED *in the kernel* and
> go and start the recovery action. rasdaemon is basically logging the error
> record and parroting it back into sysfs which is completely unnecessary - the
> kernel can simply do that.

Hi Borislav,

I think this point is addressing only one case (the one we chose to
prove out the interface so fair enough!) It is optional whether
a device ever sets the maintenance needed flag or does any of the
tracking needed to do so (which is potentially very expensive to
implement at the finer granularities of repair). Also no guarantees
on persistence of that tracking over reset. 

The intent of the rasdaemon series was to focus on the usability of the
interface, not the perfect decision process - we just picked the
easy case of the device giving us a hint. Perhaps we didn't call
that out clearly.

As a side note, if you are in the situation where the device can do
memory repair without any disruption of memory access then my
assumption is in the case where the device would set the maintenance
needed + where it is considering soft repair (so no long term cost
to a wrong decision) then the device would probably just do it
autonomously and at most we might get a notification.

So I think that if we see this there will be some disruption.
Latency spikes for soft repair or we are looking at hard repair.
In that case we'd need policy on whether to repair at all.
In general the rasdaemon handling in that series is intentionally
simplistic. Real solutions will take time to refine but they
don't need changes to the kernel interface, just when to poke it.

If that assumption about autonomous repair is wrong it would be
helpful for a memory manufacturer to shout!

> 
> Patches 3 and 4 are probably more of a justification for the userspace
> interaction as the kernel driver is "not ready" to do recovery for <raisins>.
> 
> But there I'm also questioning the presence of the sysfs interface - the 
> error record could simply be injected raw and the kernel can pick it apart.

The error record comes out as a trace point. Is there any precedence for
injecting those back into the kernel?  Whilst we'd need a subset of the
parsing code I think that's a tall order unless that infrastructure
already exists for some use case I don't know about. We'd also need to
invent a new logging scheme to keep the binary tracepoint around across
boots and poke it back in again. Given this is keeping tracepoint dumps over
kernel boots we'd also need to deal with backwards/forwards compatibility over
kernel version changes, so log the format file as well or convert to
a standard form.

Alternatively we could push these out through a new or modified version of
existing binary interfaces in a standard form.  I think that's unnecessary
duplication but happy to consider it if that's a path forwards. To me it
seems like a lot of complexity compared to current solution.

> 
> Or maybe there's a point for rasdaemon to ponder over all those different
> attributes and maybe involve some non-trivial massaging of error info in order
> to come at some conclusion and inject that as a recovery action.

That policy question is a long term one but I can suggest 'possible' policies
that might help motivate the discussion
1. Repair may be very disruptive to memory latency. Delay until a maintenance
   window when latency spike is accepted by the customer until then rely on
   maintenance needed still representing a relatively low chance of failure.
2. Hard repair uses known limited resources - e.g. those are known to match up
   to a particular number of rows in each module. That is not discoverable under
   the CXL spec so would have to come from another source of metadata.
   Apply some sort of fall off function so that we repair only the very worst
   cases as we run out. Alternative is always soft offline the memory in the OS,
   aim is to reduce chance of having to do that a somewhat optimal fashion.
   I'm not sure on the appropriate stats, maybe assume a given granual failure
   rate follows a Poison distribution and attempt to estimate lambda?  Would
   need an expert in appropriate failure modes or a lot of data to define
   this!

> 
> I guess I'm missing something and maybe there really is a valid use case to
> expose all those attributes through sysfs and use them. But I don't see
> a clear reason now...

It is the simplest interface that we have come up with so far. I'm fully open
to alternatives that provide a clean way to get this data back into the
kernel and play well with existing logging tooling (e.g. rasdaemon)

Some things we could do,
* Store binary of trace event and reinject. As above + we would have to be
  very careful that any changes to the event are made with knowledge that
  we need to handle this path.  Little or now marshaling / formatting code
  in userspace, but new logging infrastructure needed + a chardev /ioctl
  to inject the data and a bit of userspace glue to talk to it.
* Reinject a binary representation we define, via an ioctl on some
  chardev we create for the purpose.  Userspace code has to take
  key value pairs and process them into this form.  So similar amount
  of marshaling code to what we have for sysfs.
* Or what we currently propose, write set of key value pairs to a simple
  (though multifile) sysfs interface. As you've noted marshaling is needed.

> 
> > For this comment I was referring letting the kernel do the
> > stats gathering etc. We would need to put back records from a previous boot.
> > That requires almost the same interface as just telling it to repair.
> > Note the address to physical memory mapping is not stable across boots
> > so we can't just provide a physical address, we need full description.  
> 
> Right.
> 
> > Ah. No not that. I was just meaning the case where it is hard PPR. (hence
> > persistent for all time) Once you've done it you can't go back so after
> > N uses, any more errors mean you need a new device ASAP. That is as decision
> > with a very different threshold to soft PPR where it's a case of you
> > do it until you run out of spares, then you fall back to offlining
> > pages.  Next boot you get your spares back again and may use them
> > differently this time.  
> 
> Ok.
> 
> > True enough. I'm not against doing things in kernel in some cases.  Even
> > then I want the controls to allow user space to do more complex things.
> > Even in the cases where the devices suggests repair, we may not want to for
> > reasons that device can't know about.  
> 
> Sure, as long as supporting such a use case is important enough to warrant
> supporting a user interface indefinitely.
> 
> All I'm saying is, it better be worth the effort.

Absolutely agree - it is a trade off against supporting that interface.

> 
> > The interface provides all the data, and all the controls to match.
> > 
> > Sure, something new might come along that needs additional controls (subchannel
> > for DDR5 showed up recently for instance and are in v19) but that extension
> > should be easy and fit within the ABI.  Those new 'features' will need
> > kernel changes and matching rasdaemon changes anyway as there is new data
> > in the error records so this sort of extension should be fine.  
> 
> As long as you don't break existing usage, you're good. The moment you have to
> change how rasdaemon uses the interface with a new rasdaemon, then you need to
> support both.

Agreed.  Given any new thing should be optional anyway (either you have subchannels
or you don't) then that should come naturally.  I'd not expect to see anything
new being added for software only reasons and we need to support old hardware.

> 
> > Agreed. We need an interface we can support indefinitely - there is nothing
> > different between doing it sysfs or debugfs. That should be
> > extensible in a clean fashion to support new data and matching control.
> > 
> > We don't have to guarantee that interface supports something 'new' though
> > as our crystal balls aren't perfect, but we do want to make extending to
> > cover the new straight forward.  
> 
> Right.
> 
> > If a vendor wants to do their own thing then good luck to them but don't expect
> > the standard software stack to work.  So far I have seen no sign of anyone
> > doing a non compliant memory expansion device and there are quite a
> > few spec compliant ones.  
> 
> Nowadays hw vendors use a lot of Linux to verify hw so catching an unsupported
> device early is good. But there's always a case...

True enough.  They get to find out how grumpy the maintainers are - thankfully
this stuff is typically mostly device firmware defined so we can (and will)
push back hard.

> 
> > 
> > We will get weird memory devices with accelerators perhaps but then that
> > memory won't be treated as normal memory anyway and likely has a custom
> > RAS solution.  If they do use the spec defined commands, then this
> > support should work fine. Just needs a call from their drive to hook
> > it up.
> > 
> > It might not be the best analogy, but I think of the CXL type 3 device
> > spec as being similar to NVME. There are lots of options, but most people
> > will run one standard driver.  There may be custom features but the
> > device better be compatible with the NVME driver if they advertise
> > the class code (there are compliance suites etc)  
> 
> Ack.
> 
> Thx.
> 
Thanks again for your inputs! I hope I've perhaps addressed some of them.

Jonathan


