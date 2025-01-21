Return-Path: <linux-edac+bounces-2932-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD61BA181DE
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jan 2025 17:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B221C3AA3DF
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jan 2025 16:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60DA1F429A;
	Tue, 21 Jan 2025 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ezxvh7oE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983F41F470A;
	Tue, 21 Jan 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737476277; cv=none; b=LnW/5dsT7bZH1TfXaIqTe9IWjOMouTp3f/L0TXZK98ezgPcEzX4ISIQZM4LgzL/DNgb/pxZa/6lkR1SFpda/g4KqKCAZ+KZQlgF17v6Q7s3exrjcMj2KXlqY6z7Gs6ewxffUxhcrvKvO0tj8GI+R9b59hgmUvFkZAmm4rtyl7iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737476277; c=relaxed/simple;
	bh=Mk5hlYtJZlJln1qCiDw9xFeu7aIpc5NJ8oDwZMk+0/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNNmzoxuMzAB/ZYXAQ8ShAXL+FUdhHt8CcoqfvWmlyXFyp/Dbm1zlaxNxBGbCaBQov02xWmhmV4aM1EStiMaicrVE3LD2PE9R112EpW2Ji8OuZXw/25csQLuUoSeOhYaehZZ+kmXc68CTwTM7oaSuNbbP4ZT9AFfY69yV7Xf+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ezxvh7oE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A826040E0163;
	Tue, 21 Jan 2025 16:17:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NQ1Mzao_5O3B; Tue, 21 Jan 2025 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1737476261; bh=FJJSiQXUIBZS6C9T32PHRLmLlFJ7pV2FP0Wl5e8J/6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ezxvh7oEpo0H8NqDkW69b1HKC3T/t6hNUCDcxv+ckP2vkVdRONtbeFZ4n0+eZy7Fg
	 IVV1K7RC7P4AWJNBVpG+E0CqjwdfxLR+aoDhj0SGhsqFI2z6BuMv82UueXzt6AeNjq
	 b3AAmFNl/f4sZ3fwFav2bk4wv7oov0DnFX8uoemBQlWNl4JLF3zh4IeMze24g1Zr+A
	 84w3powOF1jEKn4JwTBrj/gqG5RHElzoZzCbyz3HZ+ksrD83t0f8Iog3Exy7A7W+G9
	 jMxRUJC/T80AO5QKNib3v4HkfJ/rxq9Ok+g+E3E/SSEViJOsZym5ihUdD9JTieCspx
	 7mFed7ch9QBXfQQxRZnSxznRzE650rbE85GPs9fImaX4QJ8h25w6sjlLN3ByLMTuuH
	 KAun1Ivod3F6qMsBjdo9p/XsUJYtwITsacFWQNbBLUHTVl8haZfgLducSV+2ZE+0f8
	 GlY9a+UeI8JV1uZTfzXIX4n92bOqgxM3rqO00f1psk07imAZwa/nbG9zjy5xlBAngZ
	 PSi0d6LkNfM+Mjd02hPTUICsfWc3SFWZK428xHNM/eV2IGZen1D2BDOSu/ypXHChPh
	 iBf0ORa1Y4m3z44QLq+v3MFaG48T9rOFsJnnMMkmIQRZZ3BUAJqV5hFt5877IGZ5yf
	 yAEd7N1q8knWEj/A6qYGBU2g=
Received: from zn.tnic (pd953008e.dip0.t-ipconnect.de [217.83.0.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5041440E01F9;
	Tue, 21 Jan 2025 16:16:58 +0000 (UTC)
Date: Tue, 21 Jan 2025 17:16:53 +0100
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
Message-ID: <20250121161653.GAZ4_IdYDQ9_-QoEvn@fat_crate.local>
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
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113110740.00003a7c@huawei.com>

On Mon, Jan 13, 2025 at 11:07:40AM +0000, Jonathan Cameron wrote:
> We can do that if you prefer.  I'm not that fussed how this is handled
> because, for tooling at least, I don't see why we'd ever read it.
> It's for human parsing only and the above is fine.

Is there even a concrete use case for humans currently? Because if not, we
might as well not do it at all and keep it simple.

All I see is an avalanche of sysfs nodes and I'm questioning the usefulness of
the interface and what's the 30K ft big picture for all this.

If this all is just wishful thinking on the part of how this is going to be
used, then I agree with Dan: less is more. But I need to read the rest of that
thread when there's time.

...
> Repair cam be a feature of the DIMMs themselves or it can be a feature
> of the memory controller. It is basically replacing them with spare
> memory from somewhere else (usually elsewhere on same DIMMs that have
> a bit of spare capacity for this).  Bit like a hot spare in a RAID setup.

Ooh, this is what you call repair. That's using a spare rank or so, under
which I know it as one example.

What I thought you mean with repair is what you mean with "correct". Ok,
I see.

> In some other systems the OS gets the errors and is responsible for making
> the decision.

This decision has been kept away from the OS in my world so far. So yes, the
FW doing all the RAS recovery work is more like it. And the FW is the better
agent in some sense because it has a lot more intimate knowledge of the
platform. However...

> Sticking to the corrected error case (uncorrected handling
> is going to require a lot more work given we've lost data, Dan asked about that
> in the other branch of the thread), the OS as a whole (kernel + userspace)
> gets the error records and makes the policy decision to repair based on
> assessment of risk vs resource availability to make a repair.
> 
> Two reasons for this
> 1) Hardware isn't necessarily capable of repairing autonomously as
>    other actions may be needed (memory traffic to some granularity of
>    memory may need to be stopped to avoid timeouts). Note there are many
>    graduations of this from A) can do it live with no visible effect, through
>    B) offline a page, to C) offlining the whole device.
> 2) Policy can be a lot more sophisticated than a BMC can do.

... yes, that's why you can't rely only on the FW to do recovery but involve
the OS too. Basically what I've been saying all those years. Oh well...

> In some cases perhaps, but another very strong driver is that policy is involved.
> 
> We can either try put a complex design in firmware and poke it with N opaque
> parameters from a userspace tool or via some out of band method or we can put
> the algorithm in userspace where it can be designed to incorporate lessons learnt
> over time.  We will start simple and see what is appropriate as this starts
> to get used in large fleets.  This stuff is a reasonable target for AI type
> algorithms etc that we aren't going to put in the kernel.
> 
> Doing this at all is a reliability optimization, normally it isn't required for
> correct operation.

I'm not saying you should put an AI engine into the kernel - all I'm saying
is, the stuff which the kernel can decide itself without user input doesn't
need user input. Only toggle: the kernel should do this correction and/or
repair automatically or not.

What is clear here is that you can't design an interface properly right now
for algorithms which you don't have yet. And there's experience missing from
running this in large fleets.

But the interface you're adding now will remain forever cast in stone. Just
for us to realize one day that we're not really using it but it is sitting out
there dead in the water and we can't retract it. Or we're not using it as
originally designed but differently and we need this and that hack to make it
work for the current sensible use case.

So the way it looks to me right now is, you want this to be in debugfs. You
want to go nuts there, collect experience, algorithms, lessons learned etc and
*then*, the parts which are really useful and sensible should be moved to
sysfs and cast in stone. But not preemptively like that.

> Offline has no permanent cost and no limit on number of times you can
> do it. Repair is definitely a limited resource and may permanently use
> up that resource (discoverable as a policy wants to know that too!)
> In some cases once you run out of repair resources you have to send an
> engineer to replace the memory before you can do it again.

Yes, and until you can do that and because cloud doesn't want to *ever*
reboot, you must do diminished but still present machine capabilities by
offlining pages and cordoning off faulty hw, etc, etc.

> Ok. I guess it is an option (I wasn't aware of that work).
> 
> I was thinking that was far more complex to deal with than just doing it in
> userspace tooling. From a quick look that solution seems to rely on ACPI ERSR
> infrastructure to provide that persistence that we won't generally have but
> I suppose we can read it from the filesystem or other persistent stores.
> We'd need to be a lot more general about that as can't make system assumptions
> that can be made in AMD specific code.
> 
> So could be done, I don't think it is a good idea in this case, but that
> example does suggest it is possible.

You can look at this as specialized solutions. Could they be more general?
Ofc. But we don't have a general RAS architecture which is vendor-agnostic.

> In approach we are targetting, there is no round trip situation.  We let the kernel
> deal with any synchronous error just fine and run it's existing logic
> to offline problematic memory.  That needs to be timely and to carry on operating
> exactly as it always has.
> 
> In parallel with that we gather the error reports that we will already be
> gathering and run analysis on those.  From that we decide if a memory is likely to fail
> again and perform a sparing operation if appropriate.
> Effectively this is 'free'. All the information is already there in userspace
> and already understood by tools like rasdaemon, we are not expanding that
> reporting interface at all.

That is fair. I think you can do that even now if the errors logged have
enough hw information to classify them and use them for predictive analysis.

> Ok.  It seems you correlate number of files with complexity.

No, wrong. I'm looking at the interface and am wondering how is this going to
be used and whether it is worth it to have it cast in stone forever.

> I correlated difficulty of understanding those files with complexity.
> Everyone one of the files is clearly defined and aligned with long history
> of how to describe DRAM (see how long CPER records have used these
> fields for example - they go back to the beginning).

Ok, then pls point me to the actual use cases how those files are going to be
used or they are used already.

> I'm all in favor of building an interface up by providing minimum first
> and then adding to it, but here what is proposed is the minimum for basic
> functionality and the alternative of doing the whole thing in kernel both
> puts complexity in the wrong place and restricts us in what is possible.

There's another point to consider: if this is the correct and proper solution
for *your* fleet, that doesn't necessarily mean it is the correct and
generic solution for *everybody* using the kernel. So you can imagine that I'd
like to have a generic solution which can maximally include everyone instead
of *some* special case only.

> To some degree but I think there is a major mismatch in what we think
> this is for.
> 
> What I've asked Shiju to look at is splitting the repair infrastructure
> into two cases so that maybe we can make partial progress:
> 
> 1) Systems that support repair by Physical Address
>  - Covers Post Package Repair for CXL
> 
> 2) Systems that support repair by description of the underlying hardware
> - Covers Memory Sparing interfaces for CXL. 
> 
> We need both longer term anyway, but maybe 1 is less controversial simply
> on basis it has fewer control parameters
> 
> This still fundamentally puts the policy in userspace where I
> believe it belongs.

Ok, this is more concrete. Let's start with those. Can I have some more
details on how this works pls and who does what? Is it generic enough?

If not, can it live in debugfs for now? See above what I mean about this.

Big picture: what is the kernel's role here? To be a parrot to carry data
back'n'forth or can it simply do clear-cut decisions itself without the need
for userspace involvement?

So far I get the idea that this is something for your RAS needs. This should
have general usability for the rest of the kernel users - otherwise it should
remain a vendor-specific solution until it is needed by others and can be
generalized.

Also, can already existing solutions in the kernel be generalized so that you
can use them too and others can benefit from your improvements?

I hope this makes more sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

