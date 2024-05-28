Return-Path: <linux-edac+bounces-1143-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC578D16E1
	for <lists+linux-edac@lfdr.de>; Tue, 28 May 2024 11:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D37A1F2441C
	for <lists+linux-edac@lfdr.de>; Tue, 28 May 2024 09:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFB913D29A;
	Tue, 28 May 2024 09:06:52 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D886713CABD;
	Tue, 28 May 2024 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887212; cv=none; b=RWpvG4PKv0zhKZWgfJ3rj6m14D8aDEObaukhwSqjJ/k/jAohlc5k4HKS+hqdd7lzGlUb7fOHWNUlEWVVEEfbwyz5bTOXEROyUmAPkP2YQkxHTdqo8QFTwBcIRkxZ2/QPT5tvSMuBZXMEvJos8DBBFrhQQdETb7mnmWk7IJB/+KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887212; c=relaxed/simple;
	bh=EpeHOkkWQb+2XSLY2sC69vMqvyJtOXHM8BgN7N+1tFU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDJnxMbHfq1glKso5GQl/aydPxlwChoVSo8j2YpyRYcx+MCyH4fkDfeOjXPOOJOlA+v9SSnTmvEuRyzNQ5yDdTX2Z8z0lk974yt4/cIICnqu9qK7JkvgicOLEcERcZIKDziduug2hKFs8K9Zn70WO6lfwNgkJWenZTOh9nunkUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VpRNs5z0Bz6K61Q;
	Tue, 28 May 2024 17:02:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C98041400E7;
	Tue, 28 May 2024 17:06:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 28 May
 2024 10:06:46 +0100
Date: Tue, 28 May 2024 10:06:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: Shiju Jose <shiju.jose@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
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
Message-ID: <20240528100645.00000765@Huawei.com>
In-Reply-To: <20240527092131.GBZlRQmxwFTxxyR20q@fat_crate.local>
References: <D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>
	<20240509200306.GAZj0r-h5Tnc0ecIOz@fat_crate.local>
	<663d3e58a0f73_1c0a1929487@dwillia2-xfh.jf.intel.com.notmuch>
	<20240509215147.GBZj1Fc06Ieg8EQfnR@fat_crate.local>
	<663d55515a2d9_db82d2941e@dwillia2-xfh.jf.intel.com.notmuch>
	<20240510092511.GBZj3n9ye_BCSepFZy@fat_crate.local>
	<663e55c59d9d_3d7b429475@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240511101705.GAZj9FoVbThp7JUK16@fat_crate.local>
	<6645f0738ead48a79f1baf753fc709c6@huawei.com>
	<20240520125857.00007641@Huawei.com>
	<20240527092131.GBZlRQmxwFTxxyR20q@fat_crate.local>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 27 May 2024 11:21:31 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Mon, May 20, 2024 at 12:58:57PM +0100, Jonathan Cameron wrote:
> > > Following are some of the use cases of generic scrub control
> > > subsystem as given in the cover letter.  Request please add any
> > > other use cases, which I missed.
> > >
> > > 1. There are several types of interfaces to HW memory scrubbers
> > >    identified such as ACPI NVDIMM ARS(Address Range Scrub), CXL
> > >    memory device patrol scrub, CXL DDR5 ECS, ACPI RAS2 memory
> > >    scrubbing features and software based memory scrubber(discussed
> > >    in the community Reference [5] in the cover letter). Also some
> > >    scrubbers support controlling (background) patrol scrubbing(ACPI
> > >    RAS2, CXL)  and/or on-demand scrubbing(ACPI RAS2, ACPI ARS).
> > >    However the scrub controls varies between memory scrubbers. Thus
> > >    there is  a need  for a standard generic ABI and sysfs scrub
> > >    controls for the userspace tools, which control HW and SW
> > >    scrubbers in the system, for the easiness of use.  
> 
> This is all talking about what hw functionality there is. I'm more
> interested in the "there is a need" thing. What need? How?
> 
> In order to support something like this upstream, I'd like to know how
> it is going to be used and whether the major use cases are covered. So
> that everyone can benefit from it - not only your employer.

Fair questions.

> 
> > > 2. Scrub controls in user space allow the user space tool to disable
> > >    and enable the feature in case disabling of the background patrol
> > >    scrubbing and changing the scrub rate are needed for other
> > >    purposes such as performance-aware operations which requires the
> > >    background operations to be turned off or reduced.  
> 
> Who's going to use those scrub controls? Tools? Admins? Scripts?

If dealing with disabling, I'd be surprised if it was a normal policy but
if it were udev script or boot script. If unusual event (i.e. someone is
trying to reduce jitter in a benchmark targetting something else) then interface
is simple enough that an admin can poke it directly.

> 
> > > 3. Allows to perform on-demand scrubbing for specific address range
> > >    if supported by the scrubber.
> > > 4. User space tools controls scrub the memory DIMMs regularly at
> > >    a configurable scrub rate using the sysfs scrub controls
> > >    discussed help, - to detect uncorrectable memory errors early
> > >    before user accessing memory, which helps to recover the detected
> > >    memory errors.  -  reduces the chance of a correctable error
> > >    becoming uncorrectable.  
> 
> Yah, that's not my question: my question is, how is this new thing,
> which is exposed to userspace and which then means, this will be
> supported forever, how is this thing going to be used?
> 
> And the next question is: is that interface sufficient for those use
> cases?
> 
> Are we covering the majority of the usage scenarios?

To a certain extent this is bounded by what the hardware lets us
do but agreed we should make sure it 'works' for the usecases we know
about.  Starting point is some more documentation in the patch set
giving common flows (and maybe some example scripts).

> 
> > Just to add one more reason a user space interface is needed.
> > 5. Policy control for hotplugged memory.  There is not necessarily
> >    a system wide bios or similar in the loop to control the scrub
> >    settings on a CXL device that wasn't there at boot.  What that
> >    setting should be is a policy decision as we are trading of
> >    reliability vs performance - hence it should be in control of
> >    userspace.
> >    As such, 'an' interface is needed. Seems more sensible to try and
> >    unify it with other similar interfaces than spin yet another one.  
> 
> Yes, I get that: question is, let's say you have that interface. Now
> what do you do?
> 
> Do you go and start a scrub cycle by hand?

Typically no, but the option would be there to support an admin who is
suspicious or who is trying to gather statistics or similar.

> 
> Do you have a script which does that based on some system reports?
> 

That definitely makes sense for NVDIMM scrub as the model there is
to only ever do it on a demand as a single scrub pass.
For a cyclic scrub we can spin a policy in rasdaemon or similar to
possibly crank up the frequency if we are getting lots of 'non scrub'
faults (i.e. correct error reported on demand accesses).

Shiju is our expert on this sort of userspace stats monitoring and
handling so I'll leave him to come back with a proposal / PoC for doing that.

I can see two motivations though:
a) Gather better stats on suspect device by ensuring more correctable
   error detections.
b) Increase scrubbing on a device which is on it's way out but not replacable
   yet for some reason.

I would suggest this will be PoC level only for now as it will need
a lot of testing on large fleets to do anything sophisticated.

> Do you automate it? I wanna say yes because that's miles better than
> having to explain yet another set of knobs to users.

First instance, I'd expect an UDEV policy so when a new CXL memory
turns up we set a default value.  A cautious admin would have tweaked
that script to set the default to scrub more often, an admin who 
knows they don't care might turn it off. We can include an example of that
in next version I think.
> 
> And so on and so on...
> 
> I'm trying to get you to imagine the *full* solution and then ask
> yourselves whether that new interface is adequate.
> 
> Makes more sense?
> 

Absolutely.  One area that needs to improve (Dan raised it) is
association with HPA ranges so we at can correlate easily error reports
with which scrub engine.  That can be done with existing version but
it's fiddlier than it needs to be. This 'might' be a userspace script
example, or maybe making associations tighter in kernel.

Jonathan

> Thx.
> 


