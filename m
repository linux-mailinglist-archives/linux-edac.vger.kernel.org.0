Return-Path: <linux-edac+bounces-4822-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15524B80F8B
	for <lists+linux-edac@lfdr.de>; Wed, 17 Sep 2025 18:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4E41C27282
	for <lists+linux-edac@lfdr.de>; Wed, 17 Sep 2025 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F034BA49;
	Wed, 17 Sep 2025 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b1QHgXi5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D834BA3E;
	Wed, 17 Sep 2025 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126234; cv=none; b=LumSA0dK2Q/LAXPAAsKOtvSnbJMlPaF4ztaBtFhAhys3O0vQZwAlHYShTRY5y524qGjEMOPlG8q2bPfjtwk+/BHNEljrbpoYlaxyCytYogpekX5bOLmEfxMlWlPLHWLdCtkwe5/8K0JwaP+LUIuoR+ZogFoKoXWVG18lGTUVjX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126234; c=relaxed/simple;
	bh=MAGJlZYD5VHMXkhfifP540QxU+HaAx7++Od8cOIArlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIPN3bZempmjrmuMmMoKwB9lHyvyqs05/CbfXVDNrEqdLUgulEmcvJ9np7RUCUWH2McmznbaIgj8z1LNyh4CUTuXRtkGVeB5ewPl9He6XbcoZMfxB+R4cTglNnpSQCcEVJVHVKgSRZ1flzAS7syZdJgKhQnEJODiOXgMfpJKKP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=b1QHgXi5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5202540E0176;
	Wed, 17 Sep 2025 16:23:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DLmdsVukSGBV; Wed, 17 Sep 2025 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758126214; bh=Vbpx2/EQFsv68Z8YLJv2Q1LEaliBfPp1phTF0OcPHX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1QHgXi59hwSfoy/WamP+UQar5Wx6lMdvI5x0AupjorX7gJryB3gf2+K6ZycJND6B
	 ftTs2l1lBif0obM6nPca0chtIDKQNY8tfU+oQ2k/SRockCWgVHwXJ0KT6e9YkZun4M
	 q+GYLCBBBiQPmjyaJWGQSmnQooPfV/o+g+48GazhYZdLNNBvbSUkob4f5QYkWrDAs5
	 zWgnD3SaaPlrz4rOiC2wgXnewphWzWobY9qKNbEq+3sn8ib1WVGrA5/0bzSmFmEbbp
	 39U5h8sn8FdaagJSt3/hrtHG7bj/8uxAAlaggpx/1DRrBTMxDUIhmM13sIxsrcohPy
	 tM+MAYVzHt1GS5HEbIIwlk6uYw6gnxzc0fgtW7rRoJ5LHJTjFG2OZw4KAHJE+dD+ZZ
	 3W74juSmASbbzditF1Vj11hs4ZBqzyfG/pah5LUIdJXo7dKb9BPwabCo5Dx8HG9RkR
	 0rQrei2zIC5XOxwdSHxygp9+DZ7OKsw3Lw2j0KGdk4g3X1jfTUmnuWQrKmXatG/7+o
	 UsoR1nXfdVvf2LnP03zPb61sKAH9yvdHjTVTE+Sprw3wNpRHTZ7F5YgZstvF83JD0K
	 YreUQHA0D5EZVU2uj8S/ubzOgUZ9jc7VdcG0iFQCi3Nrmj14Zvq2yrbaoJOL3WZpRP
	 O3kuWMdPuVyQPTIlgGzImDq4=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5666140E019E;
	Wed, 17 Sep 2025 16:22:59 +0000 (UTC)
Date: Wed, 17 Sep 2025 18:22:53 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Linuxarm <linuxarm@huawei.com>,
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
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>
Subject: Re: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Message-ID: <20250917162253.GCaMrgXYXq2T4hFI0w@fat_crate.local>
References: <20250902173043.1796-1-shiju.jose@huawei.com>
 <20250902173043.1796-2-shiju.jose@huawei.com>
 <20250910192707.GAaMHRCxWx37XitN3t@fat_crate.local>
 <9dd5e9d8e9b04a93bd4d882ef5d8b63e@huawei.com>
 <20250912141155.GAaMQqK4vS8zHd1z4_@fat_crate.local>
 <9433067c142b45d583eb96587b929878@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9433067c142b45d583eb96587b929878@huawei.com>

On Mon, Sep 15, 2025 at 11:50:16AM +0000, Shiju Jose wrote:
> This has been added as suggested by Jonathan considering the interleaved NUMA node.
> Link to the related discussion in V11:
> https://lore.kernel.org/all/20250821100655.00003942@huawei.com/#t

Sorry, this doesn't work this way.

If something in the code is being done which is not obvious and trivial, then
the reason for it is written down in a prominent place so that it is clear to
people.

Not pointing to a discussion or some funky place on the web where someone
might've said something.

Your patch submission should contain that info and not have reviewers ask for
it.

> | node 0 | node 1 | node 0 |   PA address map.
> Can you give your suggestion what we should do about it?

I don't know what the problem is to begin with...

> I think Option (2) seems better?  If so, can the EDAC scrub interface  be
> updated to include attributes for publishing the supported PA range for the
> memory device to scrub?

The memory ranges should already be available somewhere in the NUMA/mm code or
so and for starters, we should start a scrub for all ranges and do the
single-range only when there really is a good reason for it.

Also, you don't have to expose any ranges to userspace in order to start
a scrub activity - you can simply start the scrub in the affected range
automatically.

Like I preached the last time, your aim should be to make as much of the
variables that control the scrub automatic and not expose everything to
userspace so that some userspace tool decides. The tool should simply start
the scrub and the kernel should DTRT.

> This returns error on the first failure.
> 
> What if there was a success before? Does that aux_device need to be removed?
> 
> If not, then why return failure at all? Why not just try to add all devices? Some may fail and some may succeed.
> ============================= 
> 
> We thought second option is a better because a successfully added aux dev for a memory device and corresponding
> EDAC interface continue exist and support the scrub/a memory feature. 
> We do not mind doing stop on a failure adding an aux_device and free previously crated aux devices, though
> it may require some additional dynamically allocated memory space to store the successfully created aux devices
> so that free them on a failure later. Hope that is acceptable?

So how are you going to present to people a subset of devices loaded? And what
is the point at all? 

Is there a valid use case where you can use only a subset of the devices to
even try to support such nonsense?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

