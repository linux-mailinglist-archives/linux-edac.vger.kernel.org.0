Return-Path: <linux-edac+bounces-1079-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 938538CA99F
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2024 10:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DE0284B8A
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2024 08:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05CF54277;
	Tue, 21 May 2024 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TbMaAm5p"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E782209F;
	Tue, 21 May 2024 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278841; cv=none; b=EbN45Sws2fb3osoIY7Luk2/UIPrkJZMBsKhO7HjC3841Pm78eLeHyHFXmfYo9sPtZwjEMElTHEUpUXjpZB3YVo26S6rpoAMyOpD+Rr9NihVYw7hCw8st3XhTJUM+a7Q+xOiBhD5euuxXiy597Dp+ZwxQ1EP4l/6F8R15MMR5H+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278841; c=relaxed/simple;
	bh=ckPMRuIbbfcjK4leF67Zyjh1c9FjVXVpqOAReRsiJgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVX8lui7gfNaWAiMvscczfuJ81ZMYidiNLxcTcMHFicQWGpHbw+7CHSqNqKZWm12TuJQO2MSYiT1VjPGJeFiRmfBZt7MrpC+ETAA2ReDLGXH5H2g82wkPGb+Sd2w3xfRhTbdd++FlbLtPprlUpFX9qKMpKHw/8WKqJhInhitFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TbMaAm5p; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AD51140E0254;
	Tue, 21 May 2024 08:07:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FQIIf5xTKZTj; Tue, 21 May 2024 08:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716278833; bh=bUrz/vVy5veieaUpjlFebAVZrIuR6VrAhNkZf46x+aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbMaAm5pqlP8mAwrgyTY1siPWBqt9Xdn3FfN+/H4eL+oqvHy69dDQYM148H7Ud3V9
	 5ljZCdAobGwLYqllyGYk/mpW1jH1vCKur0QKIDU6DB7z0ZUNh4lpcXgibYeJLoW03p
	 t2qrLEapGwEMIOB/xDkdN+zRn0IeVFKlFo/sKzQfophQumyLjD4lRt55TdNT46WCDE
	 EOgKVOnCYNpEzdyk7E4CLMmUrlmDXb9Ww3ClEDBHHyBaXNk+uYfdvx18Sse4vl+AXt
	 Jl2nVWN73SEgL8+IDfk9Kgke6QDnN7nDNG+A7kqxGEjhSZw5kjk+9sVIPL3+ien+/9
	 Zz0rWImSt2CnDhZIlD7sVFBQvHpEwpeEyzEcrQFqWIyImymWw2dfS1L4JYmTIoOWmV
	 anUIcAhaYFRCSoSZGeGZbsX+X0pN537YYXUNhJeFbAcMnqbvKkTh4OXPh75nOQztHc
	 l0YXYKtmfpsJjFvNrjbqTp0l7YjuZlZkQo5gFpOzn+0fP9PNheNhdx1A2kygHA1ued
	 XKXh2RIk+TArNwtjnkqCET45albjyozv4L2u9vHCCG/MHK9IBfdN6+WqTTuwWsCis/
	 zq/e79l4rwRCUbc14OBhFQ6fVrzR3+XooxlVQ54/8izgmCWgAsiPtVXl8kX9/9Nj50
	 ervES1GITMpUmD2qO8MTN1CE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C3AF740E01A3;
	Tue, 21 May 2024 08:06:26 +0000 (UTC)
Date: Tue, 21 May 2024 10:06:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20240521080621.GBZkxV_ZWnbbrq-yV_@fat_crate.local>
References: <D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>
 <20240509200306.GAZj0r-h5Tnc0ecIOz@fat_crate.local>
 <663d3e58a0f73_1c0a1929487@dwillia2-xfh.jf.intel.com.notmuch>
 <20240509215147.GBZj1Fc06Ieg8EQfnR@fat_crate.local>
 <663d55515a2d9_db82d2941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240510092511.GBZj3n9ye_BCSepFZy@fat_crate.local>
 <663e55c59d9d_3d7b429475@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240511101705.GAZj9FoVbThp7JUK16@fat_crate.local>
 <20240517121554.000031d4@Huawei.com>
 <20240517124418.00000b48@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240517124418.00000b48@Huawei.com>

On Fri, May 17, 2024 at 12:44:18PM +0100, Jonathan Cameron wrote:
> Given we are talking about something new, maybe this is an opportunity
> to not perpetuate this?
> 
> If we add scrub in here I'd prefer to just use the normal bus registration
> handling rather than creating a nest of additional nodes.  So perhaps we
> could consider
> /sys/bus/edac/device/scrub0 (or whatever name makes sense, as per the
> earlier discussion of cxl_scrub0 or similar).

Yes, my main worry is how this RAS functionality is going to be all
organized in the tree. Yes, EDAC legacy methods can die but the
user-visible part can't so we might as well use it to concentrate stuff
there.

> Could consider moving the bus location of mc0 etc in future to there with
> symlinks to /sys/bus/edac/device/mc/* for backwards compatibility either
> via setting their parents or more explicit link creation.

You can ignore the mc - that's the memory controller representation EDAC
does and that's also kind of semi-legacy considering how heterogeneous
devices are becoming. Nowadays, scrubbing functionality can be on
anything that has memory and that's not only a memory controller.

So it would actually be the better thing to abstract that differently
and use .../edac/device/ for the different RAS functionalities. I.e.,
have the "device" organize it all.

> These scrub0 would have their dev->parent set to who ever actually
> registered them providing that reference cleanly and letting all the
> normal device model stuff work more simply.

Ack.

> If we did that with the scrub nodes, the only substantial change from
> a separate subsystem as seen in this patch set would be to register
> them on the edac bus rather than a separate class.
> 
> As you pointed out, there is a simple scrub interface in the existing
> edac memory controller code. How would you suggest handling that?
> Have them all register an additional device on the bus (as a child
> of the mcX devices) perhaps?  Seems an easy step forwards and should
> be no backwards compatibility concerns.

Well, you guys want to control that scrubbing from userspace and those
old things probably do not fit that model? We could just not convert
them for now and add them later if really needed. I.e., leave sleeping
dogs lie.

> It absolutely doesn't as long as we can do it fairly cleanly within
> existing code. I wasn't sure that was possible, but you know edac
> a lot better than me and so I'll defer to you on that!

Meh, I'm simply maintaining it because no one else wants to. :)

> Several options for that, but fair question - bringing (at least some of)
> the RAS mess together will focus reviewer bandwidth etc better.

Review is more than appreciated, as always.

> I'm definitely keen on unifying things as I agree, this mixture of different
> RAS functionality is a ever worsening mess.

Yap, it needs to be unified and reigned into something more
user-friendly and manageable.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

