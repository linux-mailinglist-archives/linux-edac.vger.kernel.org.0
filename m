Return-Path: <linux-edac+bounces-3106-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1585AA3848C
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 14:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4D016D73E
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 13:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C327221C9EA;
	Mon, 17 Feb 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W5GpODPx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C9E21ADB7;
	Mon, 17 Feb 2025 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798663; cv=none; b=oLPiMTVLlwaKn/oALXDmAZ6uHIHn1wPNr9CycoaOTElnrDQfT34JIJbib/rff9k62Wv0bWrws1F3mN3CJqnX3lWrVlcA/wRZk7Zwt6YDp5qN1x6eaFMm1aXpiXP1jzulGVSVyPIWPyVV7eoaCvmuThOYThh+bl3ud5xFDHlKeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798663; c=relaxed/simple;
	bh=1OCrK3NUD2+CMsbtRbW9TgNSZqrLmm7B5bbYiixdAkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvW9EW6/oy6P0b3IKRCmvdbGXGqsWRMPCsrrRaFgAhXXjGei/UhDbgJZUgqK57UH5bL45tFaJUVhrycmlojnbpKoULj/WbzGim3CSCY1IGo1lpgn4Fe8IuEeobc39B5pZ7NuEax2bwvoLqVU17AWuSGEewwTtZ2lm5Ezx51k8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=W5GpODPx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B2C6140E0202;
	Mon, 17 Feb 2025 13:24:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lN4sRkwnqkdm; Mon, 17 Feb 2025 13:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739798652; bh=2onwpgkhFDPCWv6IkvPW5ud97T/4ZgdkdGEXvd7PoMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5GpODPxu+IPrJGOXGnZ1B5wGCKyMgZ+Mgc6kiVPzoOhvkKoL43D+fnagH6L3D6XF
	 YyXcmSVFBjZh43qcK67uyF4rBOG8sp2OFeiKVINjS3yoD3HizoxrcO+X17FjO/I4PD
	 Xajpqd7T+pGWlVuHox+hIxEaCNM0FGVFPxY8SXHrS0GRrJ1YHEYpzgGS8nDbESNwVA
	 pIUHa3nxBuumd83oodh5wSMsqUho4qWzGG9UwdkiGgIwRdiO6EvA9AV2oXhBdg9fuZ
	 UMolTUXcLw/457qUh5HlyYLoeKkjvaJlbSc54l3SgfoaOR/0+QK+v+vNCg1DZfNoHH
	 aY5ebsyXqik6H/MatZNqD8YdIl1qgCAi+an4Ahq7D0cMnyaSamCQzZMKlSYj3gyUWC
	 JFtS211IFEWiogAA+WqG3wQkX3u8OpqP49vipAWCSkrvvP4jkGpuqt/X4tjCEYNqTZ
	 3CD3fj2gr/gF38dJGM74crPzpdJ9VNUOmHOBk96MxVdyhuj5CJBqN7hfnLygU4sjVB
	 oo/YsBGKvhrr/j/R6yB5WJ6c+wR/csa0nQ1SH1Lydkmjxaei/3oxTyxcr0W8ynSux2
	 ivPkA53NrV2SzUB0f9Jw1IPxzGnlH8wKhgNSl8Z95rKet4YraRinAXNMkh33XVqlDT
	 ohdAZxfPfHbjZypFwZEqaN5I=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4217540E0176;
	Mon, 17 Feb 2025 13:23:28 +0000 (UTC)
Date: Mon, 17 Feb 2025 14:23:22 +0100
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
Message-ID: <20250217132322.GCZ7M4Somf2VYvbwHb@fat_crate.local>
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
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250206133949.00006dd6@huawei.com>

On Thu, Feb 06, 2025 at 01:39:49PM +0000, Jonathan Cameron wrote:
> Shiju is just finalizing a v19 + the userspace code.  So may make
> sense to read this reply only after that is out!

Saw them.

So, from a cursory view, all that sysfs marshalling that happens in patch
1 and 2 here:

https://lore.kernel.org/r/20250207143028.1865-1-shiju.jose@huawei.com

is not really needed, AFAICT.

You can basically check CXL_EVENT_RECORD_FLAG_MAINT_NEEDED *in the kernel* and
go and start the recovery action. rasdaemon is basically logging the error
record and parroting it back into sysfs which is completely unnecessary - the
kernel can simply do that.

Patches 3 and 4 are probably more of a justification for the userspace
interaction as the kernel driver is "not ready" to do recovery for <raisins>.

But there I'm also questioning the presence of the sysfs interface - the 
error record could simply be injected raw and the kernel can pick it apart.

Or maybe there's a point for rasdaemon to ponder over all those different
attributes and maybe involve some non-trivial massaging of error info in order
to come at some conclusion and inject that as a recovery action.

I guess I'm missing something and maybe there really is a valid use case to
expose all those attributes through sysfs and use them. But I don't see
a clear reason now...

> For this comment I was referring letting the kernel do the
> stats gathering etc. We would need to put back records from a previous boot.
> That requires almost the same interface as just telling it to repair.
> Note the address to physical memory mapping is not stable across boots
> so we can't just provide a physical address, we need full description.

Right.

> Ah. No not that. I was just meaning the case where it is hard PPR. (hence
> persistent for all time) Once you've done it you can't go back so after
> N uses, any more errors mean you need a new device ASAP. That is as decision
> with a very different threshold to soft PPR where it's a case of you
> do it until you run out of spares, then you fall back to offlining
> pages.  Next boot you get your spares back again and may use them
> differently this time.

Ok.

> True enough. I'm not against doing things in kernel in some cases.  Even
> then I want the controls to allow user space to do more complex things.
> Even in the cases where the devices suggests repair, we may not want to for
> reasons that device can't know about.

Sure, as long as supporting such a use case is important enough to warrant
supporting a user interface indefinitely.

All I'm saying is, it better be worth the effort.

> The interface provides all the data, and all the controls to match.
> 
> Sure, something new might come along that needs additional controls (subchannel
> for DDR5 showed up recently for instance and are in v19) but that extension
> should be easy and fit within the ABI.  Those new 'features' will need
> kernel changes and matching rasdaemon changes anyway as there is new data
> in the error records so this sort of extension should be fine.

As long as you don't break existing usage, you're good. The moment you have to
change how rasdaemon uses the interface with a new rasdaemon, then you need to
support both.

> Agreed. We need an interface we can support indefinitely - there is nothing
> different between doing it sysfs or debugfs. That should be
> extensible in a clean fashion to support new data and matching control.
> 
> We don't have to guarantee that interface supports something 'new' though
> as our crystal balls aren't perfect, but we do want to make extending to
> cover the new straight forward.

Right.

> If a vendor wants to do their own thing then good luck to them but don't expect
> the standard software stack to work.  So far I have seen no sign of anyone
> doing a non compliant memory expansion device and there are quite a
> few spec compliant ones.

Nowadays hw vendors use a lot of Linux to verify hw so catching an unsupported
device early is good. But there's always a case...

> 
> We will get weird memory devices with accelerators perhaps but then that
> memory won't be treated as normal memory anyway and likely has a custom
> RAS solution.  If they do use the spec defined commands, then this
> support should work fine. Just needs a call from their drive to hook
> it up.
> 
> It might not be the best analogy, but I think of the CXL type 3 device
> spec as being similar to NVME. There are lots of options, but most people
> will run one standard driver.  There may be custom features but the
> device better be compatible with the NVME driver if they advertise
> the class code (there are compliance suites etc)

Ack.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

