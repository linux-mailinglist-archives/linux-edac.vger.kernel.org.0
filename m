Return-Path: <linux-edac+bounces-5296-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB2CC2C09E
	for <lists+linux-edac@lfdr.de>; Mon, 03 Nov 2025 14:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2221884052
	for <lists+linux-edac@lfdr.de>; Mon,  3 Nov 2025 13:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A902222A7E5;
	Mon,  3 Nov 2025 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aY0ndYWs"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC32635;
	Mon,  3 Nov 2025 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176009; cv=none; b=f78LfhmZSjKFrPb3Kl2nkiWzI1AXA1uZxgblT7kLKFqT26dQpCMFWlHaYwonhHk3ObyYCiMxntZsD6GzV0nn/aStRxIdV09COd03DfxlhIkon0+0Zc9/MEa8z/tJFrSFf64qxsDdzMtIKGLL69r1CFVqhYLnIW3dKRzMOlu9vOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176009; c=relaxed/simple;
	bh=/wr6DM7plefzFxe5cqGRChKJvSm5bKx5O8az99iQw1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tiy388kz51VPy6AJfo6LFofWU2e2/8q1+rE6mmTDNDAK9p13vXzZZCg5DlK0f+nOVOfJLf26XDEKuXkpwTBxHm38sQvTc9g3iWWRhotyCYNjHFPHjDivB6u7XE20RocTQDzP7VNqwzumK7PBpNc0NvxeGVUV7iW9OEa4uoGummc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aY0ndYWs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9185740E01A5;
	Mon,  3 Nov 2025 13:20:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YJCfSWo4KNQ9; Mon,  3 Nov 2025 13:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762175996; bh=YVO+ioF7tgxntygjp0N1BdULWpfg3s1EkWAhl+6LYHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aY0ndYWsl9sd4t9nwaRWQWqnTfFnVOpBMIw/gtqif0UtUjRGIkFkj4W1aMzNIGl1u
	 AZyPMsi4m+T8U6b9gsZlnQ7bL/yBi/wuwBpfVm7YJeArtR8YGQLVLVlvQ9QRVLCsS4
	 sATk6rdG4dVBCARBtwtLoaUKkvKdHTqyfmrXYWgb3HIukKhKV1vPqrr/LQyjtJOjDf
	 YZkcMw/DxhYLgx12ALprr38zMYISlJg7d4mA5CotRoDizAS7k/1/HYuinlHWCEsK3X
	 uDYHNJ2ezIKiM1FExr2Jrn8tgtPbq4c2DOop3IqPSdgIwKXONpHZ/A/7Qkf2sLS5wq
	 jysa2mn8uy7+wPaEKDgggWQKFwwqYoffuGZ6kS455EmVDQsAb3dhvM3j4H8sxolv8E
	 OHxkj15zfkutEpIFMf7XphyVeFIhvlAcwp60mtaPVSqduuOgbkhtc0CbtkAVNSvkXp
	 h1zjOOs8j7e8044eMOfF6UWlXcyi3mwGCSqu10W3EbILloBbAU87qSZYBzE11kaFqg
	 QfRUe91E9ueRM/B8Fya7QC0pAUGytwjMVfmvaU6tpSFJyP9rRbXj3PfKyfypmwYrB2
	 ROR6iy0NkS6PSFnzg0H7GfBjjxj4mFOHDNP6lws0NKXTPsWBKu+4tFROocs/kug2CW
	 5lKels5SpWXndmPaKrU9RSzk=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 361F840E01CD;
	Mon,  3 Nov 2025 13:19:20 +0000 (UTC)
Date: Mon, 3 Nov 2025 14:19:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: Daniel Ferguson <danielf@os.amperecomputing.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
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
Message-ID: <20251103131914.GEaQir0sdz4Te_ea0l@fat_crate.local>
References: <20250910192707.GAaMHRCxWx37XitN3t@fat_crate.local>
 <9dd5e9d8e9b04a93bd4d882ef5d8b63e@huawei.com>
 <20250912141155.GAaMQqK4vS8zHd1z4_@fat_crate.local>
 <9433067c142b45d583eb96587b929878@huawei.com>
 <20250917162253.GCaMrgXYXq2T4hFI0w@fat_crate.local>
 <20250917183608.000038c4@huawei.com>
 <20250919103950.GCaM0y9r6R6b5jfx8z@fat_crate.local>
 <6ac4ad35975142df986bfcb27d1e9b2c@huawei.com>
 <20251015223242.GBaPAhCuS7YWqu-aH0@fat_crate.local>
 <75e9bae2d30748d5b66c288135915cc3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75e9bae2d30748d5b66c288135915cc3@huawei.com>

On Fri, Oct 17, 2025 at 12:54:36PM +0000, Shiju Jose wrote:
> ACPI spec defined RAS2 interface for scrub and scrub parameters per node
> .  Thus to make compatible to the spec,  kernel and firmware implementations
> for RAS2 scrubbing are per node.

Ok, makes sense. You can have heterogeneous or whatever nodes.

> For the design and prototyping your request for "start a scrub on the whole
> system", we are trying make sysfs scrub control system-wide while keeping
> underlying RAS2 scrubbing per node.

I guess per-node does make sense...

> for the demand scrubbing should the kernel send scrub request to only on the
> corresponding node or to all the nodes etc.

Well, since scrubbing should not interfere with normal operation, you could
start it on the target where it should scrub and then do a full circle over
all memory. For example. Or do something simple and which comes "natural".

> From the ACPI spec RAS2 scrub interface perspective,  needs per-node scrub
> rate and other scrub parameters. One of the use case for demand/background
> scrubbing in a specific node in which frequent corrected memory errors
> reported to the user space and CE count exceeds the threshold.

I guess.

Or you can simply start scrubbing around the failing address. With a certain
radius. If the node thing comes more natural, sure but you can have a big fat
node and if you start scrubbing the whole thing, you will get to the actual
address you want to scrub after a long while. So the per-node thing is not
necessarily the optimal solution. Question is, what you really wanna do on an
error, as a reaction...

> If you agree to keep per-node scrub rate and thus per-node scrub control in
> the sysfs, then I will continue to use the original design in v12? Otherwise
> will try to use the new design with common system-wide scrub control in the
> sysfs and underlying RAS2 scrubbing implementation per node.

See above.

> This is for demand scrubbing feature/use case where a specific address range
> to scrub and OS must set the mandatory  spec defined  RAS2 table field
> 'Requested Address Range(INPUT)' while requesting the demand scrubbing in
> a node. Hope the firmware can ignore the request if the requested address
> range to scrub is irrelevant for a node, because in this approach we have
> common sysfs scrub control and kernel is requesting demand scrubbing
> system-wide across all nodes.
> 
> If this approach is not correct, can we use (b) as below? providing we need
> to get PA range for the nodes in the RAS2 driver  using the functions
> (start_pfn = node_start_pfn(nid) and size_pfn = node_spanned_pages(nid);)
> as implemented in v12 and discussed earlier in this thread.
> 

I'm wondering how useful that address range scrubbing would be and whether it
is worth the effort... I guess the goal here is something along those lines:
"oh, you just had an error at address X, so let's scrub [ A ... X ... B ] with
A and B having, hm, dunno, sufficient values to contain X and perhaps cover
sufficient range to catch error locality or whatnot.

But you'd need to do this only when you have a fat memory node and where you
start scrubbing at the beginning of the node range and then you'd have to wait
for a relatively long time to reach the PA X at fault...

But I have a better idea: how about you start at X - y, i.e., at an address
a bit smaller than the last reported one and then continue from there on,
reach the *end* of the node and then wraparound to the beginning until
you reach X again?

This way you don't need to supply any range and you are still "on time" when
reacting to the error with scrubbing...

Hmmm?

> Sure. Then background scrubbing will not be allowed if demand scrubbing is
> in progress in a node, if the system-wide scrub control in sysfs is chosen. 

So can the kernel interrupt background scrubbing on some node? Because then it
is easy:

You interrupt background scrubbing whenever needed with on-demand scrubbing on
that particular node...

It looks like it is starting to crystallize...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

