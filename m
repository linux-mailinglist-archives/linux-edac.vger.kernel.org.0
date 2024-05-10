Return-Path: <linux-edac+bounces-1033-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA84F8C20E0
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 11:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573911F22D75
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 09:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E51160781;
	Fri, 10 May 2024 09:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XUfzHMep"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B643F16132C;
	Fri, 10 May 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333177; cv=none; b=OuSFi/LnkajaO3GM2/K0PViDZAebnE6RQ4cyJix8rdfFYSsANO3OTK7YbXChdR7CwlzdPAB9ZoW77OEU+/QeZmBPGVHSnVPMQI9vsJcMoHVE239asAziVqpkiEB4eME0WAPfCpjkl+9uP0f9ndXFqF6hWYzf3O6cBomLHVCZZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333177; c=relaxed/simple;
	bh=y09aU3jLc3FuTNGiBAOkD/IJp3wci1UlfN8un8+6Sv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP4V6SDhffLEqWtr69M/k+/4L7o3yMBnBbdg4b1bfn+C9wgQ+cQH9AEPaZBEQlgk1Xh4V9RGtn62WwvD7WUV6tI0Pd0R1/VJnvuKBO3OXrDftQAT8sLS0xGbHc7I/yC0c6uxiHgdM3NpkOMSos4xSYDumOTuYbVfdjBET37CK5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XUfzHMep; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 17A2440E0249;
	Fri, 10 May 2024 09:26:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id plVXWEu6CSsG; Fri, 10 May 2024 09:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715333163; bh=fRAsiqdaxYNLWRPjqSgsM/ZnfQQhG+p8NwrR51D23nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUfzHMepSn4/+ARY812zuUTZb37qycJWK1yUQ/J5b0dM1vo/H4JxUPvCeFPJtXZ92
	 4tDsOc1Gxve7TVkNl8IITGIAZTp3mCJ+0esUpdjY5h3ZfLe2exvjxxd9KxEUwEIfIb
	 UtyEIUDSTywR16SF8+u/T8bO8Z4r3V8zHVf0NfIqKwwx3XgMKSAYHkHSVASdFtQSd0
	 v2m3vSCRS/j7npFX/QRO9qzkWpdh6ywBiQ5Q6qnn323/AWpecrLBHX/BBAYEM0bXcE
	 8CrYjb/Xlu5pBV7KJmCCI1D9zISrgytBG+8w0KE+QGfp+8Bx8F2xbusnHqF6+8ptB3
	 ppUjQgSuH0QGyOcHpP7z9ykO7LWPIJkALa5s+08UjIB+WZIIdRIfzBdnJqeg9W+gjP
	 9gx1i5OeCuBTPDZ39+2l4dJCMFm/p6p2D/d87x8KYrLjcGeHx+hf+oz4ECjUIX7XM7
	 20wxMOHyLhstOSOvcDEBUIirXRXu5rv8UdTa+it96/mfIfoNpzXQ0Bzs4sa4ZgZOSv
	 j7oRwPSN53LFchyK9MyjIha7+u6ObleFB20Y0TM+jvFCR9p7FyoyyebUyFps7NWjDr
	 PjRYNWCqDrNjuQ3/QkiVrNTKVI/qx2Eo5vghzBSGYvaeFF7oyFmp/V6eQZVyGmjRNz
	 VFI/97BiGc+9OZSKaGWZj0dA=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE34040E0187;
	Fri, 10 May 2024 09:25:16 +0000 (UTC)
Date: Fri, 10 May 2024 11:25:11 +0200
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
Message-ID: <20240510092511.GBZj3n9ye_BCSepFZy@fat_crate.local>
References: <e0ce36eb80054440ab877ccee4e606de@huawei.com>
 <20240508172002.GGZju0QvNfjB7Xm6qL@fat_crate.local>
 <4ceb38897d854cc095fca1220d49a4d2@huawei.com>
 <20240508192546.GHZjvRuvtu0XSJbkmz@fat_crate.local>
 <20240509101939.0000263a@Huawei.com>
 <D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>
 <20240509200306.GAZj0r-h5Tnc0ecIOz@fat_crate.local>
 <663d3e58a0f73_1c0a1929487@dwillia2-xfh.jf.intel.com.notmuch>
 <20240509215147.GBZj1Fc06Ieg8EQfnR@fat_crate.local>
 <663d55515a2d9_db82d2941e@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <663d55515a2d9_db82d2941e@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, May 09, 2024 at 03:59:29PM -0700, Dan Williams wrote:
> No, at a minimum that's a layering violation. This is a generic library
> facility that should not care if it is being called for a CXL device or
> an ACPI device.

Really?

Because this looks like creating a subsystem for those two newfangled
scrubbing functionalities which will be present in CXL devices and
by that ACPI RAS2 thing.

Because we have a *lot* of hw scrubbing functionality already. Just do:

git grep "scrub"

Some of it controls hw scrubbing. If this is a generic facility, does
this mean that all those older scrubbers should be converted to it?

Or is this thing going to support only new stuff? I.e., we want to
disable our scrubbers when doing performance-sensitive workloads and
reenable them after that but we don't care about old systems?

And all that other bla about controlling scrubbers from userspace.

So which is it?

> I think it works for x86 drivers because the functionality in those
> modules is wholly contained within that one module. This scrub module is
> a service library for other modules.

Well, you have that thing in EDAC. edac_core.ko is that service module
and the chipset-specific drivers - at least on x86 - use a match_id to
load only on the systems they should load on.

If I had a BIOS table which had "EDAC" in it, I won't load edac_core.ko
either but there isn't one.

> It is functionally the wrong place to do the check. When module_init()
> fails it causes not only the current module to be unloaded but any
> dependent modules will also fail to load.

See above. I'm under the assumption that this is using two methods to
detect scrubbing functionality.

> Let's take an example of the CXL driver wanting to register with this
> scrub interface to support the capability that *might* be available on
> some CXL devices. The cxl_pci.ko module, that houses cxl_pci_driver,
> grows a call to scrub_device_register(). That scrub_device_register()
> call is statically present in cxl_pci.ko so that when cxl_pci.ko loads
> symbol resolution requires scrub.ko to load.
> 
> Neither of those modules (cxl_pci.ko or scrub.ko) load automatically.
> Either udev loads cxl_pci.ko because it sees a device that matches
> cxl_mem_pci_tbl, or the user manually insmods those modules because they
> think they know better. No memory wasted unless the user explicitly asks
> for memory to be wasted.

The scrub.ko goes and asks the system: "Do you have a CXL device with
scrubbing functionality?" "Yes: load." "No: ok, won't."

> If no CXL devices in the system have scrub capabilities, great, then
> scrub_device_register() will never be called.
> 
> Now, if memory_scrub_control_init() did its own awkward and redundant
> CXL scan, and fails with "no CXL scrub capable devices found" it would
> not only block scrub.ko from loading, but also cxl_pci.ko since
> cxl_pci.ko needs to resolve that symbol to load.

Why would it fail the scan?

Isn't this fancy GET_SUPPORTED_FEATURES command giving you all info you
need?

> I would not say "no" to a generic facility that patches out module
> dependencies until the first call, just not sure the return on
> investment would be worth it.

From the discussion so far yeah, I think you're right, it is not worth
the effort.

> Lastly I think drivers based on ACPI tables are awkward. They really
> need to have an ACPI device to attach so that typical automatic Linux
> module loading machinery can be used. The fact this function is a
> subsys_initcall() is a red-flag since nothing should be depending on the
> load order of a little driver to control scrub parameters.

Yeah, it is becoming a mess before it has even started.

So I don't mind if such drivers get loaded as long as doing this is the
best we can do given the situation. What gets me up the palms, as they
say in .de, is "just because" and "look, the others do it too."

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

