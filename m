Return-Path: <linux-edac+bounces-1216-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 639FA8FF193
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 18:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07731C231BB
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4940919307E;
	Thu,  6 Jun 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hjXKW9Dx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE36197A8A;
	Thu,  6 Jun 2024 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689997; cv=none; b=n4DlXRTRnVIDppRkqPddYk69nPpA3+FjrpQrKmr3w3MzCVyfxVR342YO08yfj/xRJV2aOcXAHKBbTouFiCvtMd8GrOSBcvhiFD933ycZSIdZ7/wwU+UYe2tRF3/ZDJP3Hj7EbO24PMI9QkN5m4tASgLORmKtQIAZaiyDwGK6810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689997; c=relaxed/simple;
	bh=4pA/6KLDnT53+vx4qMnQiKe0VoIk3n8+GEHKApSPA7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bri7gFpl+8ivHF816pDPKfHMxa58pZcmXLcq7Y0+2bjD/QCY4QqtfOzPEZ8M1Qb+/bSkd+FCVfYaY0t2xULOWhf+p1VWwD8S4YkamYYQJ0XaLwmq1jfOfSuSzIrfmyhs3HCiPm4j7L3QFjjFt04CxR/SzO0FtQFRZquR5SiCuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hjXKW9Dx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 59E0D40E0177;
	Thu,  6 Jun 2024 16:06:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9oTyQaefmcS0; Thu,  6 Jun 2024 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717689985; bh=yNiIiUrsriudqclFjLXJzKQ4Ttub+OIs99LR3avItYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjXKW9DxeUu9aYm5BTzAi4VUPIYgVK61PopErp2APevAYakJhr7CxNPIYBKp9jmbt
	 iJ83j1nCVMNLyfCzKTC6tvsWhjeFOz4y+Nt8R9iOrHvBEAemf1jcSL6rnApKXwcuX7
	 RCVpPSQWW5vvlDJ1+bHpKUuP2zLS8J++4Kqk1MBP9gq5JJKX+iPd8/K8DGizdE1Bu9
	 2M3gUiSkCPJ7uYw1mTQ4AXs0Jwc0IJydwcPq4vzbz6Z+I1uc52Dts5X3+jKfFyGAAx
	 Hm3U8Y3C47whcAX0yw0AZb/FNFqfkM+Nckf4gCaLIg9ufOuXD+YKe+l+4Ja3A/cVrc
	 VSXevzhXxMMd5r2FFZDrlH7X+LOXPTdTvkyVa4bCzlf4N/C0KAfjLuKlnq8IUgrWY7
	 KEs9cVxXvda/yssDlwzMrQhg9JguYckb8JwVzsZFg/eh9o0gqofKLA1y6u5HELj7fE
	 SahSODA0/z1zHY/6o72zqI5eZLZVBf24/8JFUeQY+pEhMtQur3oN3tN1et52bONwnI
	 NqHKhNrHI5OSHp5UkfKO0haHb/rFshLJNCGt5HyKxoUx8IoPa8ZkpnB5U/As1DTQX+
	 v0u54Wp0hdNWX8zS+wcWOIK65Robm0iQ0TlboK1qzt8LYJCZ0IPIcAoD8eEzR1vVmt
	 uM0W6E2TSQg6W6pgB/sdTUjQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C995340E016A;
	Thu,  6 Jun 2024 16:05:38 +0000 (UTC)
Date: Thu, 6 Jun 2024 18:05:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20240606160533.GDZmHeTbhCoJYKSsD2@fat_crate.local>
References: <663d3e58a0f73_1c0a1929487@dwillia2-xfh.jf.intel.com.notmuch>
 <20240509215147.GBZj1Fc06Ieg8EQfnR@fat_crate.local>
 <663d55515a2d9_db82d2941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240510092511.GBZj3n9ye_BCSepFZy@fat_crate.local>
 <663e55c59d9d_3d7b429475@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240511101705.GAZj9FoVbThp7JUK16@fat_crate.local>
 <6645f0738ead48a79f1baf753fc709c6@huawei.com>
 <20240520125857.00007641@Huawei.com>
 <20240527092131.GBZlRQmxwFTxxyR20q@fat_crate.local>
 <20240528100645.00000765@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240528100645.00000765@Huawei.com>

On Tue, May 28, 2024 at 10:06:45AM +0100, Jonathan Cameron wrote:
> If dealing with disabling, I'd be surprised if it was a normal policy but
> if it were udev script or boot script. If unusual event (i.e. someone is

Yeah, I wouldn't disable it during boot but around my workload only. You
want for automatic scrubs to still happen on the system.

> trying to reduce jitter in a benchmark targetting something else) then
> interface is simple enough that an admin can poke it directly.

Right, for benchmarks direct poking is fine.

When it is supposed to be something more involved like, dunno, HPC doing
a heavy workload and it wants to squeeze all performance so I guess
turning off the scrubbers would be part of the setup script. So yeah, if
this is properly documented, scripting around it is easy.

> To a certain extent this is bounded by what the hardware lets us
> do but agreed we should make sure it 'works' for the usecases we know
> about.  Starting point is some more documentation in the patch set
> giving common flows (and maybe some example scripts).

Yap, sounds good. As in: "These are the envisioned usages at the time of
writing... " or so.

> > Do you go and start a scrub cycle by hand?
> 
> Typically no, but the option would be there to support an admin who is
> suspicious or who is trying to gather statistics or similar.

Ok.

> That definitely makes sense for NVDIMM scrub as the model there is
> to only ever do it on a demand as a single scrub pass.
> For a cyclic scrub we can spin a policy in rasdaemon or similar to
> possibly crank up the frequency if we are getting lots of 'non scrub'
> faults (i.e. correct error reported on demand accesses).

I was going to suggest that: automating stuff with rasdaemon. It would
definitely simplify talking to that API.

> Shiju is our expert on this sort of userspace stats monitoring and
> handling so I'll leave him to come back with a proposal / PoC for doing that.
> 
> I can see two motivations though:
> a) Gather better stats on suspect device by ensuring more correctable
>    error detections.
> b) Increase scrubbing on a device which is on it's way out but not replacable
>    yet for some reason.
> 
> I would suggest this will be PoC level only for now as it will need
> a lot of testing on large fleets to do anything sophisticated.

Yeah, sounds like a good start.

> > Do you automate it? I wanna say yes because that's miles better than
> > having to explain yet another set of knobs to users.
> 
> First instance, I'd expect an UDEV policy so when a new CXL memory
> turns up we set a default value.  A cautious admin would have tweaked
> that script to set the default to scrub more often, an admin who 
> knows they don't care might turn it off. We can include an example of that
> in next version I think.

Yes, and then hook into rasdaemon the moment it logs an error in some
component to go and increase scrubbing of that component. But yeah, you
said that above already.

> Absolutely.  One area that needs to improve (Dan raised it) is
> association with HPA ranges so we at can correlate easily error reports
> with which scrub engine.  That can be done with existing version but
> it's fiddlier than it needs to be. This 'might' be a userspace script
> example, or maybe making associations tighter in kernel.

Right.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

