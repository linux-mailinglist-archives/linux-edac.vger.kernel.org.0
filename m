Return-Path: <linux-edac+bounces-5059-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BF5BE2CDB
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 12:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5534C19A533F
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 10:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A46A214812;
	Thu, 16 Oct 2025 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lY/NlE/b"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF6F328630;
	Thu, 16 Oct 2025 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610692; cv=none; b=qZ9eU8pJlxU931hGei6tbho9qxR+IQMNraXzxwC8hmRqPZde9yClKpLXEyfeDj1ABRlMbD1Grfd3yoC/1W5p+87jTp5R9/TJx+2IiyNhmulE6Yj3kqrP2UlcO7HnuQDUxHw/cRbrKPq4N6x75rXUy9us9FNhZ8Ie9R8+Uj/bQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610692; c=relaxed/simple;
	bh=QAFUhoRdFH+O2TBpmIuIh+zAj2Yf6mN2lO7jrmSNEe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv5G2uJbqSnmuxCBz0rLgucLLCLUvDDgp7WxNseG6nFNbOHSQB3F9KD8o+xM3QglngaqNJoR9mc3aNf5xD7Un7pWO8s466/ismOMddAX9h9rjOQjuC2mk3ZZQaX+KNEn3zn9l0YvOp8n5xA+wzVMZeqJHRnlVlg+YqxF3OPXz0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lY/NlE/b; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AE95240E01AB;
	Thu, 16 Oct 2025 10:31:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CjO_OZbZHhXX; Thu, 16 Oct 2025 10:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760610680; bh=UxTkzxZWRqOwIOCFQgXcutuiJic9xI7p5Uhf9tCak18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lY/NlE/bP8Uu488fCJhG0VgYb0R1RmofyVlWeYU0XvzJXOtwqnI+xxMcDXjl2A0Pl
	 6ELFwVzaFEpa8Hry+XC8jnIRWF3YDqcSeRawxxnaTJCQPb4jPJvQtFosFivqcrTsss
	 HdpxBZnmI6dw76swAIymhgwGB7IxO6t1OROHcIbFL3u5sgabLhNsOfTgJYzayQJR8r
	 lYyQuWIEhPQC/ZZ+7P8u4d/JAwWKYRnszVzsDdw4gK6KdB8DMN403K0WHxyvYdLagE
	 PfPidmueKn6PshP/FAV89SYV0jlguwSOYh4915QLvOyFjlaFaD4hWx0tyza+azW7Ah
	 oeYwG+7IqlCxVPwsJ4fhl7LqhALZZjrNycfQ6g6SI4ukTtFzxVT6wx5OsInC80ktRR
	 nOER+slSxz8ZYxAhUqJBivxp7sYvMiSWHedt5myWyLkwjP/58eQ1QDHGdIcAXPas6v
	 JexQQYLu9I1jME/Rldi0WojMbP6915UBKD/cV2iVxm/aj3F4A4P7JJ3eb5lmZxkDmz
	 0hWzTXQ/H4p5S0mPONWZDPpuh3q1O5ifLAwCghGaJ0BsggbS0GPDzIk4Bgojw6lm7b
	 Ok44P94ia/XsBtmEMjwOfruDT5DxMkXhRHWof1dTAMRywZPG9ThHIFUpg9DZ51ug5/
	 DmuV376y+aDKY5bmrbLXff3Y=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1977140E00DE;
	Thu, 16 Oct 2025 10:30:45 +0000 (UTC)
Date: Thu, 16 Oct 2025 12:30:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
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
Message-ID: <20251015223242.GBaPAhCuS7YWqu-aH0@fat_crate.local>
References: <20250902173043.1796-1-shiju.jose@huawei.com>
 <20250902173043.1796-2-shiju.jose@huawei.com>
 <20250910192707.GAaMHRCxWx37XitN3t@fat_crate.local>
 <9dd5e9d8e9b04a93bd4d882ef5d8b63e@huawei.com>
 <20250912141155.GAaMQqK4vS8zHd1z4_@fat_crate.local>
 <9433067c142b45d583eb96587b929878@huawei.com>
 <20250917162253.GCaMrgXYXq2T4hFI0w@fat_crate.local>
 <20250917183608.000038c4@huawei.com>
 <20250919103950.GCaM0y9r6R6b5jfx8z@fat_crate.local>
 <6ac4ad35975142df986bfcb27d1e9b2c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ac4ad35975142df986bfcb27d1e9b2c@huawei.com>

On Mon, Oct 06, 2025 at 10:37:39AM +0000, Shiju Jose wrote:
> 1.Scrub rate
> 1.1. Scrub rate is common across the NUMA node domains.
> 1.2. Common min scrub rate is max of min scrub rates across nodes.
> 1.3. Common max scrub rate is min of max scrub rates across nodes.

And you need scrub rate to be per node because...?

Why can't it be a system-wide scrub rate?

If the use case appears which needs per-node scrub rate, then you design it
this way.

Or you already have a valid use case for it which dictates this design?

> 1.4. Scrub rate allowed to change only if NO demand and patrol
>    scrubbing is in progress

Right.

> 2. Demand scrubbing and Background (patrol) scrubbing
> 2.1. Background scrubbing request enables BG scrubbing
>      on all NUMA nodes.

Right.

> 2.2. For, demand scrubbing request 2 options are identified,
>      with (b) tried. Please suggest the right approach?
> a) Enable demand scrubbing on all NUMA nodes, hope for
>      the 'Requested Address Range(INPUT)' field, can use
>      address set to scrub and PAGE_SIZE(or similar) for all the
>      nodes.

Why do you need an address range? Why not start scrubbing and have it be
fire-and-forget?

> b) Enable demand scrubbing on a NUMA node for which
>      the requested address to scrub is within the PA range of
>      that node.
> 
> 2.3. Demand scrubbing is not allowed when background scrubbing
>      is in progress.
> 
> 2.4. If 2.2. (b) is chosen, should kernel allow BG
>       scrubbing on rest of the nodes, when demand scrubbing on
>       some node/s is in progress?

It seems like all scrubbing should be mutually-exclusive... or is there
a point in scrubbing in parallel...?

> 2.5 The status of the BG scrubbing exposed to the user space
>     in 'enable_background' sysfs attribute.
> 
> 2.6 The status of the demand scrubbing exposed to the
>        user space in 'addr' sysfs attribute. However when the
>        demand scrubbing is on multiple/all nodes are in progress,
>        which demand scrubbing status and address in 'addr' sysfs attribute
>        as status should be exposed to the user space?
> a) May be the status of the first detected node with demand scrubbing
>      is in progress?
> b) Does not show the status at all, just fail the request if the
>     demand scrubbing is already in progress on a node/all nodes?
> c)  Any other suggestion?

First we need a proper granularity defined and then everything will revolve
around it: should it be system-wide, per-node, does it need to have an address
range or can it be started and no need for any further user interaction and so
on and so on...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

