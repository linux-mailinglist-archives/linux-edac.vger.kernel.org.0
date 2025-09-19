Return-Path: <linux-edac+bounces-4868-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB0CB891EC
	for <lists+linux-edac@lfdr.de>; Fri, 19 Sep 2025 12:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534063AE002
	for <lists+linux-edac@lfdr.de>; Fri, 19 Sep 2025 10:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F603081AB;
	Fri, 19 Sep 2025 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gzcDo2n5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C476E2FE062;
	Fri, 19 Sep 2025 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278445; cv=none; b=svJ4ZCSKRtLBgS4HQ1eyMocNPnKgZup/HvC1xxNKt96e4k4AH4f1LGt+0saAlPT5H8x4ZV/fgWDuYXmCOby7k8sowHUefKerhCkOAoFU+Witpm3I+KYYgthr48S3kChxM1pP9U3n6pcYwNozy6iIFGV2YbDHCFZMtL/XxLm5Nhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278445; c=relaxed/simple;
	bh=mGjdhf7kkAqN/3UQNbblDRLoDVCgqpkaOt73COZp/6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNL4qoylvSWTOGTReybv65fqls7T1je4GWqWsKFS5PgOJqFiAK4SJ//ElEsAIdvmh4mTV9tvbeehjIWSUDEGutz8j3X5I5HfctDyPjhfnd9B3RUtdO/F8BwDFL++36H2sAiJcjY/WNZv+F5X94ODSWwkhRH7JB6029+pt70aNRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gzcDo2n5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0A94340E019E;
	Fri, 19 Sep 2025 10:40:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id II-tU-70Mx6R; Fri, 19 Sep 2025 10:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758278432; bh=2Pk7UDyluMT9wTT16Dwfk065aUtC7WyLyoHzQain/Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzcDo2n5keM9vsYXKO5vELkDMk154mpEC9fwEXKYTPBqo12ub+t+dtWgqxtJzqeAz
	 sSawPLMiU6BwbGmynYvs+TPRT1V2milcv9J5xqMlHoLYVfmZV9skrjGtBlMcObRNNc
	 ppFkz+NUzya3Z6fT+2h4xKanjnxx4ajygLbLudqZY51QPCwVervOKuO+3yAxUNTC3i
	 ZuEttHaJgURnpeEVy07nR1no0CoRrA76aHdiqO+3RWKWmu0dS7mJbkxdfpliKUlMjT
	 6K9xIVDqN/LOwQuJ4jMzMAOYOm/E1TUoc3TayD5EF8LnyUdjGEjGTHUYrlfT9KdAf8
	 xdHQX2DX0C/4av21DVQFZKDDDIWCIGr8hihz7ahrIdz6WWYe9mCFKEcTkjCO3y43Wv
	 vIcx/a7XUDj2tVm+U8GCGHoMQ2KbsLRrMa5SaElf6EY3FQiV1kP9STmkupLULXEe1K
	 6fBWHu4cP21+yeGNxd2fq4qNwawpUc6t3HIOBu08HDXceFu9J3uaGI+Ybet62mvVP/
	 K999BVKFyTfNX08suL8A2Bl4NsJIkB7N/+x0Nj2245661f3QJOIUKFAFUerga9UiMT
	 PZjcAAP6K4eupHsLO0MkHB4HCC4TzT2zdWIKH/QLMp6cV0SofOiGeDJtuLVdw84NJ5
	 ZM1W3hL/NFSlwjFPr104jH40=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 84FAE40E019F;
	Fri, 19 Sep 2025 10:39:56 +0000 (UTC)
Date: Fri, 19 Sep 2025 12:39:50 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>,
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
Message-ID: <20250919103950.GCaM0y9r6R6b5jfx8z@fat_crate.local>
References: <20250902173043.1796-1-shiju.jose@huawei.com>
 <20250902173043.1796-2-shiju.jose@huawei.com>
 <20250910192707.GAaMHRCxWx37XitN3t@fat_crate.local>
 <9dd5e9d8e9b04a93bd4d882ef5d8b63e@huawei.com>
 <20250912141155.GAaMQqK4vS8zHd1z4_@fat_crate.local>
 <9433067c142b45d583eb96587b929878@huawei.com>
 <20250917162253.GCaMrgXYXq2T4hFI0w@fat_crate.local>
 <20250917183608.000038c4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917183608.000038c4@huawei.com>

On Wed, Sep 17, 2025 at 06:36:08PM +0100, Jonathan Cameron wrote:
> This 'first contiguous range' is an attempt to DTRT in a corner
> case that is real but where there is not an obvious right thing due to spec limitations.

Thanks for taking the time to expand. The gist of this needs to be in a commit
message for future reference.

HOWEVER, I'm still not clear *why* we're jumping through hoops which we
probably set up ourselves without even knowing why... at least it looks like
this from where I'm standing.

So why not start a scrub on the whole system? Why do we care?

Scrub is "cheap" in the sense that it runs in the background and is the lowest
priority and everything else overrides it.

So why design an interface only when there's a need to design one and do the
simplest thing now, for starters? Gather some experience and then imrpove it
by actually designing an interface...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

