Return-Path: <linux-edac+bounces-2878-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9DCA0A4FB
	for <lists+linux-edac@lfdr.de>; Sat, 11 Jan 2025 18:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3240167A24
	for <lists+linux-edac@lfdr.de>; Sat, 11 Jan 2025 17:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B671B414E;
	Sat, 11 Jan 2025 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OgD4Au04"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE77F1A8F6E;
	Sat, 11 Jan 2025 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736615624; cv=none; b=EhEpg7QMAgLeodEsMgcIRNYPRd7/ivCDRBJFyT0mXG4XAT/Z8j+ihb8cH43oFdDsjpDqmS0QSkXiOhBIuDwj0zCdRE9Wjk0PlU/5+mSNwAI8kD9srvcqyQiJZDKRAYJIKvVHyWzm+wCx9tNyz53WP1TbWffiBdx6s9nEsdTN3k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736615624; c=relaxed/simple;
	bh=asMUKgsDyIN5F6iw9zNQjAhLvH1K2NVYZ0h+Wrf1VXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cqer4KRF6/FBTayHfqk3noB4UwFm6CNOnPZwCI6EJ4GFgaoBf8NylFhdIgzV5CU5F+kehAbx5mmVyuVq05xLCW4mDj26obx2ORGTaMdpd7fjPqN15lr8qIXuUKJDtaz/K8ojF5qrLxi0La54NDo2K7y5Ssysuio5PDO21SP5jlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OgD4Au04; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C3A8640E01B5;
	Sat, 11 Jan 2025 17:13:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tE6Ly5eTuki8; Sat, 11 Jan 2025 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736615614; bh=dy/nLqIHFB1W6aDIAXq0L4N3W+XLgmeHWVFfPlL6OZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OgD4Au04w7yNqKvb1xwuel8mJVIjoFPyfCzdGWssaAU7lktQhh/OxwupNjtI1TFsd
	 gT/ZemcjG4/wDC7AJjQCIh3LRWWrXGR6G3M3pNRb75/8c/AeIE3d+xVfv8xrjX6s7x
	 z869j3MfOlzJdOCIxHQdDOHPbLUElbjM2qTDEYLPB5htGJJoDa62JfzpLJ7GN1+IDq
	 h1vZTYb/QeGbAU+vlBYkQ/Gy1vGCsJLDLzCkLQQEfCWlnCuQwDa5E8m+bXg+AupPH0
	 MkZXqYuEfI9xhKIkaO/b9ejGfdEn4RENncDCJsdjubNT4h8cBPWAC5xRKukGHHLnm3
	 cdNQw4sgHFJoWcIy4yp0gzp6DLQsOQ91dRB6CPNasqglSwgCFdBM/5PKBiD2SPxNoE
	 pZvOlozxkvJeNQUQnoAmCNSGEC88sI37sK/wG/9NcqYGFRhB7JJgJkybbjaC7/tlHH
	 tJCxbTjsrtDSkypy4NY7BCHs/jOfxs6JhwiEdLrGvQes+Hb8j+HTp917affjX/IuKr
	 deuuZ7/eqdtlDoMQKAkCTP57V8eFOB6sHwHRGfeEU9GeU6TsirbQIc4V+yw55KlS6G
	 vY7lAMOChfNTgRVc5Z76KsCg6q837EigHDPhlaBJQWrCRh7O6tloA0nJCkECFlliCL
	 IoLbsSWJiqc/5YwU9V6HNueU=
Received: from zn.tnic (pd953008e.dip0.t-ipconnect.de [217.83.0.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E015140E02BF;
	Sat, 11 Jan 2025 17:12:50 +0000 (UTC)
Date: Sat, 11 Jan 2025 18:12:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
	"erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>,
	"gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250111171243.GCZ4Kmi5xMtY2ktCHm@fat_crate.local>
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
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109183448.000059ec@huawei.com>

On Thu, Jan 09, 2025 at 06:34:48PM +0000, Jonathan Cameron wrote:
> Today you can.  Seems we are talking cross purposes.
> 
> I'm confused. I thought your proposal was for "bank" attribute to present an
> allowed range on read.
> "bank" attribute is currently written to and read back as the value of the bank on which
> to conduct a repair.  Maybe this disconnect is down to the fact max_ and min_
> attributes should have been marked as RO in the docs. They aren't controls,
> just presentation of limits to userspace.
> 
> Was intent a separate bank_range type attribute rather than max_bank, min_bank?

I don't know - I'm just throwing ideas out there. You could do:

cat /sys/.../bank

and that gives you

[<low> <current_value> <high>]

So you have all the needed information. Dunno if this would be abusing sysfs
rules too much tho.

> > 
> > > In at least the CXL case I'm fairly sure most of them are not discoverable.
> > > Until you see errors you have no idea what the memory topology is.  
> > 
> > Ok.
> > 
> > > For that you'd need to have a path to read back what happened.  
> > 
> > So how is this scrubbing going to work? You get an error, you parse it for all
:> > the attributes and you go and write those attributes into the scrub interface
> > and it starts scrubbing?
> 
> Repair not scrubbing. They are different things we should keep separate,
> scrub corrects the value, if it can, but doesn't change the underlying memory to
> new memory cells to avoid repeated errors. Replacing scrub with repair 
> (which I think was the intent here)...

Really?

So how is scrubbing defined for CXL? You read memory, do ECC check on it,
report any potential errors but write back the *original* wrong value?!

I thought the point of scrubbing is to repair it while at it too...

> You get error records that describe the error seen in hardware, write back the
> values into this interface and tell it to repair the memory.  This is not
> necessarily a synchronous or immediate thing - instead typically based on
> trend analysis.

This is just silly: I'm scrubbing, I found an error, I should simply fix it
while at it. Why would I need an additional command to repair it?!

> As an example, the decision might be that bit of ram threw up 3 errors
> over a month including multiple system reboots (for other reasons) and
> that is over some threshold so we use a spare memory line to replace it.

Right.

> Short answer, it needs to be very smart and there isn't a case of one size
> fits all - hence suggested approach of making it a user space problem.

Making it a userspace problem is pretty much always a sign that the hw design
failed.

> Given in the systems being considered here, software is triggering the repair,
> we want to allow for policy in the decision. 

Right, you can leave a high-level decision to userspace: repair only when
idle, repair only non-correctable errors, blabla but exposing every single
aspect of every single error... meh.

> In simple cases we could push that policy into the kernel e.g. just repair
> the moment we see an error record.
> 
> These repair resources are very limited in number, so immediately repairing
> may a bad idea. We want to build up a history of errors before making
> such a decision.  That can be done in kernel. 

Yap, we are doing this now:

drivers/ras/cec.c

Userspace involvement is minimal, if at all. It is mostly controlling the
parameters of the leaky bucket.

> The decision to repair memory is heavily influenced by policy and time considerations
> against device resource constraints.
> 
> Some options that are hard to do in kernel.
> 
> 1. Typical asynchronous error report for a corrected error.
> 
>    Tells us memory had an error (perhaps from a scrubbing engine on the device
>    running checks). No need to take action immediately. Instead build up more data
>    over time and if lots of errors occur make decision to repair as no we are sure it
>    is worth doing rather than a single random event. We may tune scrubbing engines
>    to check this memory more frequently and adjust our data analysis to take that
>    into account for setting thresholds etc.

See above.

What happens when your daemon dies and loses all that collected data?

> 2. Soft repair across boots.  We are actually storing the error records, then only
>    applying the fix on reboot before using the memory - so maintaining a list
>    of bad memory and saving it to a file to read back on boot. We could provide
>    another kernel interface to get this info and reinject it after reboot instead
>    of doing it in userspace but that is another ABI to design.

We did something similar recently: drivers/ras/amd/fmpm.c. It basically
"replays" errors from persistent storage as that memory cannot be replaced.

> 3. Complex policy across fleets.  A lot of work is going on around prediction techniques
>    that may change the local policy on each node dependent on the overall reliability
>    patterns of a particular batch of devices and local characteristics, service guarantees
>    etc. If it is hard repair, then once you've run out you need schedule an engineer
>    out to replace the DIMM. All complex inputs to the decision.

You probably could say here: "repair or report when this and that." or
"offline page and report error" and similar high-level decisions by leaving
the details to the kernel instead of looking at every possible error in
userspace and returning back to the kernel to state your decision.

> Similar cases like CPU offlining on repeated errors are done in userspace (e.g.
> RAS Daemon) for similar reasons of long term data gathering and potentially
> complex algorithms.
>   
> > 
> > > Ok. Then can we just drop the range discoverability entirely or we go with
> > > your suggestion and do not support read back of what has been
> > > requested but instead have the reads return a range if known or "" /
> > > return -EONOTSUPP if simply not known?  
> > 
> > Probably.
> 
> Too many options in the above paragraph so just to check...  Probably to which?
> If it's a separate attribute from the one we write the control so then
> we do what is already done here and don't present the interface at all if
> the range isn't discoverable.

Probably means I still don't get a warm and fuzzy feeling about this design.
As I've noted above.

> Ok. Best path is drop the available range support then (so no min_ max_ or
> anything to replace them for now).
> 
> Added bonus is we don't have to rush this conversation and can make sure we
> come to the right solution driven by use cases.

Yap, that sounds like a prudent idea.

What I'm trying to say, basically, is, this interface through sysfs is
a *lot* of attributes, there's no clear cut use case where we can judge how
useful it is and as I alluded to above, I really think that you should leave
the high-level decisions to userspace and let the kernel do its job.

This'll make your interface a lot simpler.

And if you really need to control every single aspect of scrubbing in
userspace, then you can always come later with proper design and use case.

But again, I really think you should keep as much recovery logic in the kernel
and as automatic as possible. Only when you really really need user input,
only then you should allow it...

I hope I'm making sense here...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

