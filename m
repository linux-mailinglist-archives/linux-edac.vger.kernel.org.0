Return-Path: <linux-edac+bounces-2856-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EF5A07D51
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 17:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A71E3A656F
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6B1222571;
	Thu,  9 Jan 2025 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RkLtBkYM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8715C221DAA;
	Thu,  9 Jan 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439605; cv=none; b=a6eBRNiyUuT/nt86+3shlBYG0/nQwVPuWdlcDKsf7iHKiDV19fWmYGK5MGzhx6ZlPJ4gf9H7/Kz79ni2jm8OfsurpDBoOtP9dvsz4ep21so+dRv5cGgzbyg6Q0K3dMKLz3SLkiF8PdkBTU9/rYiX52ljOru5iE7tfpOwTHSjCIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439605; c=relaxed/simple;
	bh=+pocBmrDEcKGQRVoRGn6fpy/Sk8VsUR1S6n9vNGGl1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZpb2LJ9XG5Apyga0dGBjPrMWDMETCgpmfk64suJ5nXv17ODtvfoM2x8pLLB//CXsorYBbqUPWGXB0KanbVRgNRE69jXBI+//c4ZVG4pF46P6M7YEfcjYayBqv/bvd6jTa9Si6ioMuDWy6W1oZe+Ea0OiXzItsy5AGEzW3puJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RkLtBkYM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 81E3640E028B;
	Thu,  9 Jan 2025 16:19:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id E1yBSN-FQfqE; Thu,  9 Jan 2025 16:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736439592; bh=fFMiN1tnPtLjAxIUIMtgxfPtiWXSUncNXBiAsX2cXhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkLtBkYM247YXiypz7ani0G2iHbSTtmaY2KyE2aF9VvsMadiQV5AhuX2E34pqBHhV
	 ogPs7NzUGg+pI8rJe4BQHy3rnYZ0uOWL3l8yujemXz35nkz/MguEOjSPoJC07/Z0ww
	 ok7p0nF25Vod1mbj5jTqacOL80lD7zcxhE5MDiBGe86zlWLCXey+lKrLcAoGoeJsuD
	 1ledtXr2rKqxE4BMbgkipVCWJRa3UPyRhggim3YuSmx6GKHpy1LhjDCO4pBFG7mstc
	 Bygp+ng0vK8GrvG3AxmIP4Zsy/kC5LzBvcfuWtsBgjQe8rhejs92ssWjLY1R82rz1P
	 hcqsT4bXn+mGAJTxbteqfxFDKS6xfbTd0WRBlzX4vogE1sIlG/XEOllSRKslkrimVJ
	 DrsrKERUHHtgIuv3gifCWb/hyCXon+LdiB6MHu6eMNQHE++NvI0nwN3HALJ6JAaBvX
	 d1axMiFpjd3jMznL6Yej1xye0EgIRtfksEAUez6px8HJxkFaucJouQuFJpJ1zoLNDo
	 VDCX1vompoUUDQsb7y9ht2CszmlGDiVW2heif5cEGYEarimqIM3ghzy+BUurEEiRMy
	 /3FVEIvABOkiC7A+dWJo2ogZYnQeER6dD/pFooXD5nkauRZkqWVSj9WlHMPVxdWUJd
	 2xbMTmR2yQKnMK3fMjfLukbA=
Received: from zn.tnic (p200300ea971F933C329c23FfFeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:933c:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 994F140E01F9;
	Thu,  9 Jan 2025 16:19:08 +0000 (UTC)
Date: Thu, 9 Jan 2025 17:19:02 +0100
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
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250109161902.GDZ3_29rH-sQMV4n0N@fat_crate.local>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-5-shiju.jose@huawei.com>
 <20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
 <3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>
 <20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
 <20250109142433.00004ea7@huawei.com>
 <20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
 <20250109160159.00002add@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109160159.00002add@huawei.com>

On Thu, Jan 09, 2025 at 04:01:59PM +0000, Jonathan Cameron wrote:
> Ok. To me the fact it's not a single write was relevant. Seems not
> in your mental model of how this works.  For me a single write
> that you cannot query back is fine, setting lots of parameters and
> being unable to query any of them less so.  I guess you disagree.

Why can't you query it back?

grep -r . /sysfs/dir/

All files' values have been previously set and should still be there on
a read, I'd strongly hope. Your ->read routines should give the values back.

> In interests of progress I'm not going to argue further. No one is
> going to use this interface by hand anyway so the lost of useability
> I'm seeing doesn't matter a lot.

I had the suspicion that this user interface is not really going to be used by
a user but by a tool. But then if you don't have a tool, you're lost.

This is one of the reasons why you can control ftrace directly on the shell
too - without a tool. This is very useful in certain cases where you cannot
run some userspace tools.

> In at least the CXL case I'm fairly sure most of them are not discoverable.
> Until you see errors you have no idea what the memory topology is.

Ok.

> For that you'd need to have a path to read back what happened.

So how is this scrubbing going to work? You get an error, you parse it for all
the attributes and you go and write those attributes into the scrub interface
and it starts scrubbing?

But then why do you even need the interface at all?

Why can't the kernel automatically collect all those attributes and start the
scrubbing automatically - no need for any user interaction...?

So why do you *actually* even need user interaction here and why can't the
kernel be smart enough to start the scrub automatically?

> Ok. Then can we just drop the range discoverability entirely or we go with
> your suggestion and do not support read back of what has been
> requested but instead have the reads return a range if known or "" /
> return -EONOTSUPP if simply not known?

Probably.

> I can live with that though to me we are heading in the direction of
> a less intuitive interface to save a small number of additional files.

This is not the point. I already alluded to this earlier - we're talking about
a user visible interface which, once it goes out, it is cast in stone forever.

So those files better have a good reason to exist...

And if we're not sure yet, we can upstream only those which are fine now and
then continue discussing the rest.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

