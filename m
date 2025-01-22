Return-Path: <linux-edac+bounces-2943-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D53CA19913
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jan 2025 20:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705E23A2EAE
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jan 2025 19:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C035F21519C;
	Wed, 22 Jan 2025 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Scp14krE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10875215182;
	Wed, 22 Jan 2025 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737573368; cv=none; b=KwrFcrq/hKcH/JGKx5sTMsRyc03rH/s7F+rhKkOjDEI39u2Rvxtx+PO+jldg8mUTDPPTTRF0FUd5ComYhlJvfbc7dW1Dhr3T3ydPujXu1LqsDH41+gTBlnJmjwci5hZIqU5b0+HCMd07lUwJNBv0SOsYzuc7QWDKwUZ3rHpO6/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737573368; c=relaxed/simple;
	bh=v6YV9eIDsJMLS4oejIi8jAG2xTfl0sZ+XRNDM7u25to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sALCZJpAviFsPTlvd0zjKG2YsQPPNKd9oxOnIbH7RgcRFgD4GtZ2/ClE++fg7fvtxoQZJBGctKH/1tuzDyI8BA2PzD3WafcQ6XojuvpSjNB6hb+SSW8zVhEwwCBz1LhDTqI8+ZB+NNOEk0L7iWvinC+xV+249J7M+n/DFcBw1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Scp14krE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2C9E040E0194;
	Wed, 22 Jan 2025 19:10:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7gbpTtE4YNEk; Wed, 22 Jan 2025 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1737573007; bh=Tcb2Z6DGVFgByVLZsGDzi5H0qUPxCY9mavsd9VzPlvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Scp14krEEXpmv7pRF0EklohRi6aP0zbh/s92cJ440j7InvtCw0KkFgctx/FlD9gvY
	 ASsaGlYI5lhfgarZFSME4UptgQVYyVGwg39T+OVXA9T9oi2Pcu7g5A36xnaBxpV3mU
	 swk5OSaimu3YGKMetCAyA03blAN0B3qx+CiaiAT94ycERupkLgh6zghmFSnDlWMyNh
	 dARMKMC9LuWhIIZW0rV96Gm+4i2jMahLwzEADxtZTIAR6owiN5aiWR6bEAU18bQRfC
	 T3snd8Rh/r2uL5TpmXttWgZNy8Kwj/KEAeUyo9sQ9Emyd53bVo6EWPAkWRRGsDYYXk
	 3KbP2vIncRcJX+L82yUpIN56G3j9IZWDz2t2tFP8RA3EP4qWPvCSmPiIKaOKiS5AQA
	 SnNcLVEoYq4gIJuAFtFSM65VtjfdKrdEbn6Rz6vo694oHvgdonB6EsKpwMvtat2Hoj
	 pRyiVOdKcZUh+sxwJp1iLtPmB+Kbm5JW9uRKvLbafbgAtDnyiPbAPH9zgY45Xns93W
	 DL1vzGD3QDtvPt7R5MAL/SY6bvoC6yGfH79vMl7EA9nAADHraGFb1o1Zkg4TF5g/Pp
	 jk7X1IhIQ1yh8yvnapK4oJEKRdGnzMSiTw6hOP8jR+McoWEDwBOD/U29KIr7X2zSRq
	 G1wsyO4EhemY7RkmXtZbAUqs=
Received: from zn.tnic (pd953008e.dip0.t-ipconnect.de [217.83.0.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 365FB40E01C5;
	Wed, 22 Jan 2025 19:09:23 +0000 (UTC)
Date: Wed, 22 Jan 2025 20:09:17 +0100
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
	Linuxarm <linuxarm@huawei.com>, Vandana Salve <vsalve@micron.com>
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250122190917.GDZ5FCXetp9--djyQ6@fat_crate.local>
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
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250121181632.0000637c@huawei.com>

On Tue, Jan 21, 2025 at 06:16:32PM +0000, Jonathan Cameron wrote:
> Clearly we need to provide more evidence of use cases: 'Show us your code'
> seems to apply here.  We'll do that over the next few weeks.

Thanks.

> based on simple algorithms applied to the data RAS Daemon already has.
> The interface for the reasons discussed in the long thread with Dan
> is the minimum required to provide the information needed to allow
> for two use cases.  We enumerated them explicitly in the discussion with
> Dan because they possibly affected 'safety'.
> 
> 1) Power up, pre memory online, (typically non persistent) repair of
>    known bad memory.

Lemme make sure I understand this: during boot you simply know from somewhere
that a certain rank (let's use rank for simplicity's sake) is faulty. Before
you online the memory, you simply replace that rank in the logic so that the
system uses the spare rank while the faulty rank is disabled.

>    There are two interface options for this, inject the prior mapping from
>    device physical address space (host address is not necessarily relevant
>    here as no address decoders have been programmed yet in CXL - that
>    happens as part of the flow to bring the memory up), or use the
>    information that userspace already has (bank, rank etc) to select what
>    memory is to be replaced with spare capacity.

Ok, so this is all CXL-specific because this use case relies on userspace
being present. Which means you cannot really use this for DIMMs used during
boot. So if DIMMs, those should be online-able later, when userspace is there.

>    Given the injection interface and the repair interface have to
>    convey the same data, the interface complexity is identical and
>    we might as well have a single step 'repair' rather than
>      1. Inject prior records then

What exactly is this injecting? The faulty rank? Which then would cause the
respective driver to go and do that repairing.

Which then means that you can online that device after rasdaemon has loaded
and has the required info to online it.

Which then means, rasdaemon needs to be part of the device onlining process.

I'm simply conjecturing here - I guess I'll see your detailed use case later.

>      2. Pass a physical address that is matched to one of those records.

I don't know what that one does.

>    There are no security related concerns here as we always treat this
>    as new memory and zero it etc as part of onlining.

Right, goes without saying.

> 2) Online case.  Here the restriction Dan proposed was that we 'check'
>    that we have seen an error record on this boot that matches the full
>    description.  That is matching both the physical address and the
>    topology (as that mapping can change from boot to boot, but not whilst
>    the memory is in use). This doesn't prevent any use case we have
>    come up with yet because, if we are making a post initial onlining
>    decision to repair we can assume there is a new error record that
>    provided new information on which we are acting.  Hence the kernel
>    had the information to check.
> 
>    Whilst I wasn't convinced that we had a definite security
>    problem without this protection, it requires minimal changes and doesn't
>    block the flows we care about so we are fine with adding this check.

I need more detail on that 2nd case - lemme read that other subthread.

> Ok. We'll put together an example script / RASdaemon code to show how
> it is used. I think you may be surprised at how simple this is and hopefully
> that will show that the interface is appropriate.

That sounds good, thanks.

> This we disagree on. For this persistent case in particular these are limited
> resources. Once you have used them all you can't do it again.  Using them
> carefully is key. An exception is mentioned below as a possible extension but
> it relies on a specific subset of allowed device functionality and only
> covers some use cases (so it's an extra, not a replacement for what this
> set does).

By "this persistent case" you mean collecting logs per error address,
collating them and massaging them or hunting them through a neural network to
recognize potential patterns and then act upon them?

In any case, I don't mean that - I mean something simple like: "after X errors
on address Y, offline page Z." Like we do with .../ras/cec.c. Ofc you can't
put really complex handling in the kernel and why would you - it must be *the*
best thing after sliced bread to impose that on everyone.

All I'm saying is, simple logic like that can be in the kernel if it is useful
in the general case. You don't *have* to carry all logic in some userspace
daemon - the kernel can be smart too :-)

> With the decision algorithms in userspace, we can design the userspace to kernel
> interface because we don't care about the algorithm choice - only what it needs
> to control which is well defined. Algorithms will start simple and then
> we'll iterate but it won't need changes in this interface because none of it
> is connected to how we use the data.

Are you saying that this interface you have right now is the necessary and
sufficient set of sysfs nodes which will be enough for most algorithms in
userspace?

And you won't have to change it because you realize down the road that it is
not enough?

> In general an ABI that is used is cast in stone. To my understanding there
> is nothing special about debugfs.  If we introduce a regression in tooling
> that uses that interface are we actually any better off than sysfs?
> https://lwn.net/Articles/309298/ was a good article on this a while back.
> 
> Maybe there has been a change of opinion on this that I missed.

I don't think so and I can see that article's point. So let's cut to the
chase: what are we going to do when the sysfs or debugfs nodes you've added
become insufficient and you or someone else needs to change them in the
future, for their specific use case?

The last paragraph of that article basically sums it up pretty nicely.

> Absolutely though the performance impact of punching holes in memory over
> time is getting some cloud folk pushing back because they can't get their
> 1GIB pages to put under a VM.  Mind you that's not particularly relevant
> to this thread.

What is relevant to this thread is the fact that you can't simply reboot as
a RAS recovery action. Not in all cases.

> For this we'll do as we did for scrub control and send a patch set adding tooling
> to RASdaemon and/or if more appropriate a script along side it.  My fault,
> I falsely thought this one was more obvious and we could leave that until
> this landed. Seems not!

Sorry, I can't always guess the use case by looking solely at the sysfs nodes.

> This I agree on. However, if CXL takes off (and there seems to be agreement
> it will to some degree at least) then this interface is fully general for any spec
> compliant device.

Ok, sounds good.

> Sure. We can definitely do that.  We have this split in v19 (just undergoing
> some final docs tidy up etc, should be posted soon).

Thx.

You don't have to rush it - we have merge window anyway.

> Early devices and the ones in a few years time may make different
> decisions on this. All options are covered by this driver (autonomous
> repair is covered for free as nothing to do!)

Don't forget devices which deviate from the spec because they were implemented
wrong. It happens and we have to support them because no one else cares but
people have already paid for them and want to use them.

> CXL is not vendor specific. Our other driver that I keep referring
> to as 'coming soon' is though.  I'll see if I can get a few memory
> device manufacturers to specifically stick their hands up that they
> care about this. As an example we presented on this topic with
> Micron at the LPC CXL uconf (+CC Vandana).  I don't have access
> to Micron parts so this isn't just Huawei using Micron, we simply had two
> proposals on the same topic so combined the sessions.  We have a CXL
> open source sync call in an hour so I'll ask there.

Having hw vendors agree on a single driver and Linux implementing it would be
ofc optimal.

> Maybe for the follow on topic of non persistent repair as a path to
> avoid offlining memory detected as bad. Maybe that counts
> as generalization (rather than extension).  But that's not covering
> our usecase of restablishing the offline at boot, or the persistent
> usecases.  So it's a value add feature for a follow up effort,
> not a baseline one which is the intent of this patch set.

Ok, I think this whole pile should simply be in two parts: generic, CXL-spec
implementing, vendor-agnostic pieces and vendor-specific drivers which use
that.

It'll be lovely if vendors could agree on this interface you're proposing but
I won't hold my breath...

> Thanks for taking time to continue the discussion and I think we
> are converging somewhat even if there is further to go.

Yap, I think so. A lot of things got cleared up for me too, so thanks too.
I'm sure you know what the important things are that we need to pay attention
when it comes to designing this with a broader audience in mind.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

