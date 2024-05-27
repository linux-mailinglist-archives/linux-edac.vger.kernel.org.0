Return-Path: <linux-edac+bounces-1138-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA648CFCB4
	for <lists+linux-edac@lfdr.de>; Mon, 27 May 2024 11:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723431C21BB7
	for <lists+linux-edac@lfdr.de>; Mon, 27 May 2024 09:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452B913A404;
	Mon, 27 May 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SPBZriHQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834BB13A3E7;
	Mon, 27 May 2024 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801753; cv=none; b=MvW/OpPBmGc9n3DQaGYvsJW3PvfQC016S+r5QVNz8WOor9pCqzt21Z5iJLRm9pcbX24r/ptnb4fnYEcHLh+TtKjk67f5Tur43OLjxnTK3GqsnU0Kog8wreOSS/3qv0ye7UK77e5m7eybyspDKj0NAqNTU1YqaqMrv3nNq0lJRNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801753; c=relaxed/simple;
	bh=7Do3jd1IN413L/V5MF6Yd5UQUtCIWA7aOu/aea4sp3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCjbqDI+M0/O/9TrhQE0bedRTK/DY2rwg5UZCPcKWTNpMWDr78pzavW0ZCjH3MXY8aiVkYkZaJ5rAZG7HLehP6oomDEIE1erhCHwD0ksb95ZutG1P+Dhl9sykp3tEa1++sm2mNiW4L1hr4v/LDjCaVp/Ytxto5YiF6/3bCxdmMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SPBZriHQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7201740E01E8;
	Mon, 27 May 2024 09:22:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RYjAB7Wc3NWx; Mon, 27 May 2024 09:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716801745; bh=T0xBExIPLlnb73V0TN4uBsw1poWCW7XSDlsFHChb7DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPBZriHQF7lKX5IFE2i7S1WHgpw/e2ZgDazXBq2Ne56WAW5uru0h+D/KZXOPaow1P
	 FHipNPfAwwjOQbjng7shfjAA0cwUnWZ3jtcBFYS6Is/DGJ2O0rDVCkWUXAD+RWMRxc
	 61UBtzXkkk8FoB0eTYVOFKTsHyZiSAJO2cJSnM2Gqhjenoby2XPyH2j4AfwJTSX0uQ
	 On6B/ja7boKIi1jWU0PrZSauop8+bPkkRszbZn6uflLP8SiAbTngYcS6t+0eRxFfYs
	 0SVkKasS/iskL50XTOEtGisylul6MNaQbrDx4qVFtkXEoH2Rp679HS3MJ/p/Hr4Eck
	 /otdKmMO4CH5lQmzOP9kfXSxA4lD5+4lnghX8DDs7KJt1jidNFjQBtrHrj083/6lpe
	 Akawq58ni+CJiL2kNQlWenuIZZleiXG3oITRIZ+Ydlb7L4pxaOwcbnBn1UXolrrfYh
	 J7hOrSYRjZ+vRgJEV7jMQ5Dlxl6htEvaRFcEV+g9J1rJao8MxgPsmwxe0WmRlvxjjW
	 lJOcTQr/90xnlE4LuW62QkLpUGIN6WRohLJEaQP2Qfbqw9OXBmRaMKFpstAdFmoG0W
	 CSoPIFHshGcybeQ2Czc5N8HCQKWfCj6p9M/HeLlt0G9TC/V0Am0BKjRTH0sjyOmljv
	 6nCCho46U5kXTjKdcgyD3No0=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B97F40E0177;
	Mon, 27 May 2024 09:21:38 +0000 (UTC)
Date: Mon, 27 May 2024 11:21:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20240527092131.GBZlRQmxwFTxxyR20q@fat_crate.local>
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
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240520125857.00007641@Huawei.com>

On Mon, May 20, 2024 at 12:58:57PM +0100, Jonathan Cameron wrote:
> > Following are some of the use cases of generic scrub control
> > subsystem as given in the cover letter.  Request please add any
> > other use cases, which I missed.
> >
> > 1. There are several types of interfaces to HW memory scrubbers
> >    identified such as ACPI NVDIMM ARS(Address Range Scrub), CXL
> >    memory device patrol scrub, CXL DDR5 ECS, ACPI RAS2 memory
> >    scrubbing features and software based memory scrubber(discussed
> >    in the community Reference [5] in the cover letter). Also some
> >    scrubbers support controlling (background) patrol scrubbing(ACPI
> >    RAS2, CXL)  and/or on-demand scrubbing(ACPI RAS2, ACPI ARS).
> >    However the scrub controls varies between memory scrubbers. Thus
> >    there is  a need  for a standard generic ABI and sysfs scrub
> >    controls for the userspace tools, which control HW and SW
> >    scrubbers in the system, for the easiness of use.

This is all talking about what hw functionality there is. I'm more
interested in the "there is a need" thing. What need? How?

In order to support something like this upstream, I'd like to know how
it is going to be used and whether the major use cases are covered. So
that everyone can benefit from it - not only your employer.

> > 2. Scrub controls in user space allow the user space tool to disable
> >    and enable the feature in case disabling of the background patrol
> >    scrubbing and changing the scrub rate are needed for other
> >    purposes such as performance-aware operations which requires the
> >    background operations to be turned off or reduced.

Who's going to use those scrub controls? Tools? Admins? Scripts?

> > 3. Allows to perform on-demand scrubbing for specific address range
> >    if supported by the scrubber.
> > 4. User space tools controls scrub the memory DIMMs regularly at
> >    a configurable scrub rate using the sysfs scrub controls
> >    discussed help, - to detect uncorrectable memory errors early
> >    before user accessing memory, which helps to recover the detected
> >    memory errors.  -  reduces the chance of a correctable error
> >    becoming uncorrectable.

Yah, that's not my question: my question is, how is this new thing,
which is exposed to userspace and which then means, this will be
supported forever, how is this thing going to be used?

And the next question is: is that interface sufficient for those use
cases?

Are we covering the majority of the usage scenarios?

> Just to add one more reason a user space interface is needed.
> 5. Policy control for hotplugged memory.  There is not necessarily
>    a system wide bios or similar in the loop to control the scrub
>    settings on a CXL device that wasn't there at boot.  What that
>    setting should be is a policy decision as we are trading of
>    reliability vs performance - hence it should be in control of
>    userspace.
>    As such, 'an' interface is needed. Seems more sensible to try and
>    unify it with other similar interfaces than spin yet another one.

Yes, I get that: question is, let's say you have that interface. Now
what do you do?

Do you go and start a scrub cycle by hand?

Do you have a script which does that based on some system reports?

Do you automate it? I wanna say yes because that's miles better than
having to explain yet another set of knobs to users.

And so on and so on...

I'm trying to get you to imagine the *full* solution and then ask
yourselves whether that new interface is adequate.

Makes more sense?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

