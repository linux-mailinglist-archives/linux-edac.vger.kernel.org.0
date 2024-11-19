Return-Path: <linux-edac+bounces-2561-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B3E9D25F4
	for <lists+linux-edac@lfdr.de>; Tue, 19 Nov 2024 13:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8125B29C6B
	for <lists+linux-edac@lfdr.de>; Tue, 19 Nov 2024 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961A71C4A30;
	Tue, 19 Nov 2024 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W8sZ6T2E"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0477F13B780;
	Tue, 19 Nov 2024 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019615; cv=none; b=Fe2UOh1+JR/fmThQfv/K/uxyu6BopZweNxyCJ1AqceXptVSb55Y5sn4/bjyfs8MnmlWwKD+1+k45TtC82bvGgjslcN4EVihy2xb5pPnx7NWm1TtOP2DO0BGQJ3kXOTVzf0yspXf4YFl1tqkiLTX1LstRcsx6ix7kRJhCxYKm9KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019615; c=relaxed/simple;
	bh=wYtKX1gkgU2eRIj2wm+HXUb+JU30L2HyOtpCN5Pw1oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtPbDfZOzkTXLEWvmDf+mYhstcfnXW1jrT5yeu8nHWMOh2psodaKbqwFp+E4V1ItjskbU141x/7GG5ujd4anwynJJgAuffR8SPLIkE+teUm4yUkJV5y/zi2KEFRZYRrVjm2EZWgGl/iCcPdzREfd4f0liUs44HEPoT8w/Fzw4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=W8sZ6T2E; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 022F740E0261;
	Tue, 19 Nov 2024 12:33:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0Ow-6GcQPyy3; Tue, 19 Nov 2024 12:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732019605; bh=rEP0FuldgnSoZBuL4zUQZ5eTxYEpIWQlSPv8f8rZbdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8sZ6T2ELT2tzGmP5OQFsooPkBrvRYFx+pP3+FbfossFsby3YKB9l/S/afxPXCHlD
	 r0qeAyfr97DtKVCTtoDzylXnparGjta3OXlgTb+RdnfvEiXTnPdy9wMJp6Zs1W3X8y
	 hj5tJb2crG7mGfafLUqruCQUJCRFPYEm5kDcyHZ731obfZErF1fjpw660MarATpitp
	 0hbFbmxCYMogmhLrFTUU2gCfbQUGgF0KlNN0lJmL2MEAdF5WnGTuM1kvurrk0wOwrQ
	 TdcqPAMEfEXq5E4dHdeZA0a9+SxudSC9ZU5jOttgs8IqSUF/U0+2oKSHp5rqlXcgaF
	 h/BmC8OcE6l3u8DBcMpExrmmL3FlriEDz9NusjOC4KwTU2CRo/z0Q+Inc7ctbmhrrr
	 vTZ7EeTYZjIDMpARPn3nF0OKRAPGV/+UzWZbU75amFBO9VkeVp14PlvmODtXe/fujP
	 UBjnNZ0A0kLamktz/QQufj1lFK1rphOZWFYpOxtyg6rGOypE9axZv30BpDObmkNSzZ
	 bwqNTt3kAEITo3H0hs7U3dt2x2hE/cObcNBZZb9pqFzNUGZ6RQrVtTSjrAEf4Lg6HT
	 7Qu+q9Q4Pj+Dny9MwlPaCdMveNXXAUEMH6RQK6iqpmVAMmKkPQBB4Kep0eTP8Oc9Gg
	 RwH+4hSSKG8FoDZyCt/rseBo=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AAC4540E015F;
	Tue, 19 Nov 2024 12:32:38 +0000 (UTC)
Date: Tue, 19 Nov 2024 13:32:33 +0100
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
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
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
Subject: Re: [PATCH v15 11/15] EDAC: Add memory repair control feature
Message-ID: <20241119123233.GBZzyFYfEttuJjfr6D@fat_crate.local>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
 <20241101091735.1465-12-shiju.jose@huawei.com>
 <20241104061554.GOZyhmmo9melwI0c6q@fat_crate.local>
 <1ac30acc16ab42c98313c20c79988349@huawei.com>
 <20241111112819.GCZzHqUz1Sz-vcW09c@fat_crate.local>
 <7fd81b442ba3477787f5342e69adbb96@huawei.com>
 <20241114133249.GEZzX8ATNyc_Xw1L52@fat_crate.local>
 <20241115121415.00005c76@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115121415.00005c76@huawei.com>

On Fri, Nov 15, 2024 at 12:14:15PM +0000, Jonathan Cameron wrote:
> We could drop the query for now and bring it back later once more of the surrounding
> infrastructure becomes clearer.  To me it's a useful feature, but I appreciate
> this is early days and we shouldn't always try for all the bells and whistles on
> day 1.

Agreed.

Let's add this only when it is really really needed and it cannot be part of
the actual repair flow. Right now it can be an implicit step of the repair
where latter is first tried, and if it works, it is actually done.

Then, if it really really turns out that one needs the "try" thing as an
explicit step, we can then actually carve it out.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

