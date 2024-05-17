Return-Path: <linux-edac+bounces-1068-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC068C85CB
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2024 13:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BBD28509B
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2024 11:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46C83E49C;
	Fri, 17 May 2024 11:44:28 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E133D3C068;
	Fri, 17 May 2024 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715946268; cv=none; b=jp/Q+tfWDnPcCm5jeCRDeI6rrv6xs3ZMj9aywKPkFVdJMaGmkjeOqkkdpwBG+1cJ7AQztZM4yR3VstWLK79WmgAmRW6e9KwfFnRwwnbhYz+a0XO2FdS6KSef9mX8slSqhWR7Fp7bXVn8ClXvl7C8LwyFBzUw58zfNKtB5zb6Oh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715946268; c=relaxed/simple;
	bh=oe2uN6/FMJd8agEcFyxu+AWXUbAd2SNUJYKEVSDGkuM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwKwGIKygrZQIhpQ8HlnRE7tO0vpoqouR73RiI5f9VFJ4FV54ITX0Oh08DvBFQy81voumlBLMOT0Eob3RlIQcghK9XNqiEIOsJOR6AEbSjDU5WfiVauqvusDBeQ0nAJ+/6QQ6l1mFHbyp7Ew7vEIHU06fotypkXkmPz5DmO4q0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VglQP6tvSz6K6yd;
	Fri, 17 May 2024 19:40:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B32FF140B54;
	Fri, 17 May 2024 19:44:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 May
 2024 12:44:19 +0100
Date: Fri, 17 May 2024 12:44:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: Dan Williams <dan.j.williams@intel.com>, Shiju Jose
	<shiju.jose@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Jean Delvare
	<jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <20240517124418.00000b48@Huawei.com>
In-Reply-To: <20240517121554.000031d4@Huawei.com>
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
	<20240511101705.GAZj9FoVbThp7JUK16@fat_crate.local>
	<20240517121554.000031d4@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 17 May 2024 12:15:54 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> Focusing on just one bit.
> 
> > > Now, the question of how many legacy scrub interfaces should be
> > > considered in this design out of the gate is a worthwhile discussion. I
> > > am encouraged that this ABI is at least trying to handle more than 1
> > > backend, which makes me feel better that adding a 3rd and 4th might not
> > > be prohibitive.    
> > 
> > See above.
> > 
> > I'm perfectly fine with: "hey, we have a new scrub API interfacing to
> > RAS scrub capability and it is *the* thing to use and all other hw scrub
> > functionality should be shoehorned into it.
> > 
> > So this thing's design should at least try to anticipate supporting
> > other scrub hw.
> > 
> > Because there's EDAC too. Why isn't this scrub thing part of EDAC? Why
> > isn't this scrub API part of edac_core? I mean, this is all RAS so why
> > design a whole new thing when the required glue is already there?
> > 
> > We can just as well have a
> > 
> > 	/sys/devices/system/edac/scrub/
> > 
> > node hierarchy and have everything there.  

Sorry - finger fumble, wasn't meant to send yet :( 

> 
> A few questions about this. It seems an unusual use of fake devices and a bus
> so I'm trying to understand how we might do something that looks more standard
> but perhaps also fit within the existing scheme.  I appreciate this stuff
> has evolved over a long time, so lots of backwards compatibility concerns.
> 
> If I follow this right the current situation is:
> 
> /sys/devices/system/edac is the 'virtual' device registered on the edac bus.

Actually that's wrong it's not on the edac bus as that is the bus registered
via subsys_system_register() (which does create a fake device as per the docs
telling us not to use it any more - fair enough, legacy).

The mc below it is a bare device - I think just to provide a directory?
The comment on the release function seems to say that. This gives.

/sys/devices/system/edac/mc
/sys/bus/edac/devices/mc

Under that we have individual mc0/mc1 etc for the instances of that
accessible via
/sys/devices/system/edac/mc/mc0
/sys/bus/edac/device/mc/mc0
Those are registered a children of mc. I'd have expected them to be
children of the device that registered them - so for our case, a CXL mc0
node would be child of the CXL device rather than here but again
I'm guessing legacy that had to be maintained.

In general this nesting seems unusual, as I'd have expected the
registration directly on the edac bus with
/sys/bus/edac/device/mc0
/sys/bus/edac/device/pci0

Given we are talking about something new, maybe this is an opportunity
to not perpetuate this?

If we add scrub in here I'd prefer to just use the normal bus registration
handling rather than creating a nest of additional nodes.  So perhaps we
could consider
/sys/bus/edac/device/scrub0 (or whatever name makes sense, as per the
earlier discussion of cxl_scrub0 or similar).
Could consider moving the bus location of mc0 etc in future to there with
symlinks to /sys/bus/edac/device/mc/* for backwards compatibility either
via setting their parents or more explicit link creation.

These scrub0 would have their dev->parent set to who ever actually registered
them providing that reference cleanly and letting all the normal device
model stuff work more simply.

If we did that with the scrub nodes, the only substantial change from
a separate subsystem as seen in this patch set would be to register
them on the edac bus rather than a separate class.

As you pointed out, there is a simple scrub interface in the existing
edac memory controller code. How would you suggest handling that?
Have them all register an additional device on the bus (as a child
of the mcX devices) perhaps?  Seems an easy step forwards and should
be no backwards compatibility concerns.

> 
> > 
> > Why does it have to be yet another thing?

It absolutely doesn't as long as we can do it fairly cleanly within
existing code. I wasn't sure that was possible, but you know edac
a lot better than me and so I'll defer to you on that!

> > 
> > And if it needs to be separate, who's going to maintain it?

Several options for that, but fair question - bringing (at least some of)
the RAS mess together will focus reviewer bandwidth etc better.

> >   
> > > Which matches what I reacted to on the last posting:
> > > 
> > >    "Maybe it is self evident to others, but for me there is little in these
> > >     changelogs besides 'mechanism exists, enable it'"
> > > 
> > > ...and to me that feedback was taken to heart with much improved
> > > changelogs in this new posting.    
> > 
> > Ok.
> >   
> > > This init time feature probing discussion feels like it was born from a
> > > micommunication / misunderstanding.    
> > 
> > Yes, it seems so, thanks for clarifying things.
> > 
> > I still am unclear on the usecases and how this is supposed to be used
> > and also, as mentioned above, we have a *lot* of RAS functionality
> > spread around the kernel. Perhaps we should start unifying it instead of
> > adding more...

I'm definitely keen on unifying things as I agree, this mixture of different
RAS functionality is a ever worsening mess.

Jonathan


> > 
> > So the big picture and where we're headed to, needs to be clarified first.
> > 
> > Thx.
> >   
> 


