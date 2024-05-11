Return-Path: <linux-edac+bounces-1046-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385BA8C3091
	for <lists+linux-edac@lfdr.de>; Sat, 11 May 2024 12:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0451C20AB5
	for <lists+linux-edac@lfdr.de>; Sat, 11 May 2024 10:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E807653E2E;
	Sat, 11 May 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DKtzd3Su"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F32F26;
	Sat, 11 May 2024 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715422700; cv=none; b=GmomvJ+7wnVHIna4vNxbPvVAJEIvQajdMb4QPF0nH6TP8f7iOIlMPLzVLaQpejntfesdC0+lu3CW/ukSl0H8iQoDh0R4nucsIaYqQcDhh7GQwdlkN/2/6gOV63U1YJ6VbwDNW6n6mPTRj0sB5h2JgcvuosSor13ZYkyQQ5CH/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715422700; c=relaxed/simple;
	bh=O0xewY3Y5Jb5OD/3Rs+2TXsH4TbN9Y5C4D+AfGM6Zxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5XGo2lialv0qkXvGiihYjCqsgVQiS1JSl+nfaAV4UZ3y3yX6f6Fa6raWY6waz1BIiBfHhRfSwUCnNQTm+EwYEGjVAXwbos3mLsW177j0e57UZSPl85KDHXR3KlEGKgghPDqZhk++vx/397xMJshYViQeoS4b339vb1Yk1Ut+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DKtzd3Su; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D720C40E016A;
	Sat, 11 May 2024 10:18:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5d3Fh0OE80Bw; Sat, 11 May 2024 10:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715422690; bh=OWiW3+Pv1PHgnBB9aOP0p9srtw8n5xByedUyYyJohrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKtzd3Suq42E445Ys800MflaKzKL/t+f2IE/nuTcCvY+qSzRtYBJX1fUzD6X4bc0w
	 4lBQt+IiQuJoneh1wnZK35b3FrTZwFEy6Oz24JM2JQpIowf76hBIpPKc4Cp2b3yFYb
	 Gs9jXbx8WKJEswJL183a/f9ncBJEBABVuSv5iQ+UHZAdp2lmGSR510w8AwTyRjN20V
	 lpb2XAoIMfGB1ttF6Ic1r5rxq9witRmqaLDBNvJdNqxYQ9i7lRibzcYsUz7/vR5mjy
	 ItffzVSf/m6opBDMdtBYsLgZmHmkoyvzVHdLZcI1relrEqj6vJO3AXvfYYLWT5H+8j
	 kB2KxVxBDNXxTBwb4z4XkPndnAk0+l3CDvOEMRdIr/CD6cyqXOPzO2ZrjLhxRFmHjP
	 VdXtmk+OiA86+br87CaKvlL81SUoN8KgF6T1qE/AiTtuE305nD76ETC3zTKW5iWyKu
	 Jkd/dSNcUNwQy6yHha7nZ0kZSCbJLZ2kivpcbN7BoOjuhCORY3UhxpbZeCYEbfMxRI
	 IDZquGjtvp0BjbIr7Aw1c7AiCtMcKxIRRR2RcTV+FiI1glo0pxT7DVnJdFAaLeivMD
	 9cfHOXQabloDRE6Pa7JS/BAgwwf4DTChNl/RDmtnr43rMIiHCaptgU0XJNWad/1IrH
	 osI6PeDIC9ZhddFbI0sv+3x4=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ECC9E40E022F;
	Sat, 11 May 2024 10:17:23 +0000 (UTC)
Date: Sat, 11 May 2024 12:17:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
	"erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>,
	"mike.malvestuto@intel.com" <mike.malvestuto@intel.com>,
	"gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <20240511101705.GAZj9FoVbThp7JUK16@fat_crate.local>
References: <4ceb38897d854cc095fca1220d49a4d2@huawei.com>
 <20240508192546.GHZjvRuvtu0XSJbkmz@fat_crate.local>
 <20240509101939.0000263a@Huawei.com>
 <D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>
 <20240509200306.GAZj0r-h5Tnc0ecIOz@fat_crate.local>
 <663d3e58a0f73_1c0a1929487@dwillia2-xfh.jf.intel.com.notmuch>
 <20240509215147.GBZj1Fc06Ieg8EQfnR@fat_crate.local>
 <663d55515a2d9_db82d2941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240510092511.GBZj3n9ye_BCSepFZy@fat_crate.local>
 <663e55c59d9d_3d7b429475@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <663e55c59d9d_3d7b429475@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Fri, May 10, 2024 at 10:13:41AM -0700, Dan Williams wrote:
> In fact this question matches my reaction to the last posting [1], and
> led to a much improved cover letter and the "Comparison of scrubbing
> features". To your point there are scrub capabilities already in the
> kernel and we would need to make a decision about what to do about them.

The answer to that question is whether this new userspace usage is going
to want to control those too.

So

"Use case of scrub control feature"

from the cover letter is giving two short sentences about what one would
do but I'm still meh. A whole subsystem needing a bunch of effort would
need a lot more justification.

So can anyone please elaborate more on the use cases and why this new
thing is needed?

> I called out NVDIMM ARS as one example and am open to exploring
> converting that to the common scrub ABI, but not block this proposal
> in the meantime.
>
> For me the proposal can be boiled down to, "here we (kernel community)
> are again with 2 new scrub interfaces to add to the kernel. Lets step
> back, define a common ABI for ACPI RAS 2 and CXL to stop the
> proliferation of scrub ABIs, and then make a decision about when/whether
> to integrate legacy scrub facilities into this new interface".

Fully agreed as long as there's valid users for it and we don't end up
designing and supporting an interface which people are not sure if
anyone uses. ras_userspace_consumers() from the other thread
case-in-point.

> [1]: http://lore.kernel.org/r/65d6936952764_1138c7294e@dwillia2-xfh.jf.intel.com.notmuch
^^^^^

Ha, you're speaking what I'm thinking here. :-)

> The scrub_core, like edac_core, has no method to detect scrubbing
> facility, it is simply a passive library waiting for the first
> scrub_device_register() call.

Well, those scrub things still have methods which are better than
nothing. EDAC is ancient. But ok, let's just say they're the same for
the sake of simplicity.

> Yeah, that's backwards. CXL enumeration belongs in the CXL driver and
> the CXL driver is fully responsible for deciding when to incur the costs
> of loading scrub_core.

Ok, fair enough.

> Assume that it does and memory_scrub_control_init() finds no scrub
> facilities in any CXL devices and fails memory_scrub_control_init(). Any
> module that links to scrub_device_register() will also fail to load
> because module symbol resolution depends on all modules completing init.

My angle was: scan the system for *all* possible scrub functionalities
and if none present, then fail. And since they're only two...

> Sure, but that's a driver-probe-time facility, not a module_init-time
> facility.

Oh well.

> I assume you do not consider edac_core a mess?

The whole EDAC is a mess but that's a whole another story. :-)

> Now, the question of how many legacy scrub interfaces should be
> considered in this design out of the gate is a worthwhile discussion. I
> am encouraged that this ABI is at least trying to handle more than 1
> backend, which makes me feel better that adding a 3rd and 4th might not
> be prohibitive.

See above.

I'm perfectly fine with: "hey, we have a new scrub API interfacing to
RAS scrub capability and it is *the* thing to use and all other hw scrub
functionality should be shoehorned into it.

So this thing's design should at least try to anticipate supporting
other scrub hw.

Because there's EDAC too. Why isn't this scrub thing part of EDAC? Why
isn't this scrub API part of edac_core? I mean, this is all RAS so why
design a whole new thing when the required glue is already there?

We can just as well have a

	/sys/devices/system/edac/scrub/

node hierarchy and have everything there.

Why does it have to be yet another thing?

And if it needs to be separate, who's going to maintain it?

> Which matches what I reacted to on the last posting:
> 
>    "Maybe it is self evident to others, but for me there is little in these
>     changelogs besides 'mechanism exists, enable it'"
> 
> ...and to me that feedback was taken to heart with much improved
> changelogs in this new posting.

Ok.

> This init time feature probing discussion feels like it was born from a
> micommunication / misunderstanding.

Yes, it seems so, thanks for clarifying things.

I still am unclear on the usecases and how this is supposed to be used
and also, as mentioned above, we have a *lot* of RAS functionality
spread around the kernel. Perhaps we should start unifying it instead of
adding more...

So the big picture and where we're headed to, needs to be clarified first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

