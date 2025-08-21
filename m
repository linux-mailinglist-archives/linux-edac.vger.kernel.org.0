Return-Path: <linux-edac+bounces-4630-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CC4B2F35B
	for <lists+linux-edac@lfdr.de>; Thu, 21 Aug 2025 11:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0781CC1D50
	for <lists+linux-edac@lfdr.de>; Thu, 21 Aug 2025 09:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355672F5307;
	Thu, 21 Aug 2025 09:07:12 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE8E2BD031;
	Thu, 21 Aug 2025 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767232; cv=none; b=a8Puz/aY7JKJWSmi1EANeB02zzs9MKopngoXrpOvjvSPSqVfl1cb93yzeSpzRtrr2USj28B4TLT3O0rr8vNszCComPssEQkcbnu4IT+fqfxNscFKWN2TmUOp3Tw4Rzowqf+Qkrd4DuTKLNFMW9NPkD0AsJUf7pV2LMDgekEDnJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767232; c=relaxed/simple;
	bh=Zh+kkBZNDfZfIiwJzIeX6K/FMXbnoYDsLw2oj5rNOsk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nare+ksjeuP0DiKSLu5eu1khHb1pssztNTSepE5B+UHlBr0q7R+5/t5nSCupOOUYM8JcUYaJPyPh+foEr74rXrOGRB3CIyTz+gba2OeFSweSEZvDmmgY9gBA8v4eVRFlymZUzc4zH5S5LIkTzmTjdK9Vj6hsORgnL9EXAltrD6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c6y9t4GNYz6JBWR;
	Thu, 21 Aug 2025 17:06:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 43D6A1400DB;
	Thu, 21 Aug 2025 17:06:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Aug
 2025 11:06:56 +0200
Date: Thu, 21 Aug 2025 10:06:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mike Rapoport <rppt@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, Linuxarm <linuxarm@huawei.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, Roberto
 Sassu <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>
Subject: Re: [PATCH v11 1/3] mm: Add support to retrieve physical address
 range of memory from the node ID
Message-ID: <20250821100655.00003942@huawei.com>
In-Reply-To: <aKX_rk0DasbDgJrS@kernel.org>
References: <20250812142616.2330-1-shiju.jose@huawei.com>
	<20250812142616.2330-2-shiju.jose@huawei.com>
	<20250819175420.00007ce6@huawei.com>
	<aKV6dVkPiBPw595T@kernel.org>
	<20250820095413.00003bd7@huawei.com>
	<964fc2721fb7499daa5f49eddfed54ff@huawei.com>
	<aKX_rk0DasbDgJrS@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 20 Aug 2025 20:02:38 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> On Wed, Aug 20, 2025 at 10:00:50AM +0000, Shiju Jose wrote:
> > >-----Original Message-----
> > >From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > >Sent: 20 August 2025 09:54
> > >To: Mike Rapoport <rppt@kernel.org>
> > >Cc: Shiju Jose <shiju.jose@huawei.com>; rafael@kernel.org; bp@alien8.de;
> > >akpm@linux-foundation.org; dferguson@amperecomputing.com; linux-
> > >edac@vger.kernel.org; linux-acpi@vger.kernel.org; linux-mm@kvack.org; linux-
> > >doc@vger.kernel.org; tony.luck@intel.com; lenb@kernel.org;
> > >leo.duran@amd.com; Yazen.Ghannam@amd.com; mchehab@kernel.org;
> > >Linuxarm <linuxarm@huawei.com>; rientjes@google.com;
> > >jiaqiyan@google.com; Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
> > >naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
> > >somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
> > >duenwen@google.com; gthelen@google.com;
> > >wschwartz@amperecomputing.com; wbs@os.amperecomputing.com;
> > >nifan.cxl@gmail.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
> > ><prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
> > >kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>
> > >Subject: Re: [PATCH v11 1/3] mm: Add support to retrieve physical address
> > >range of memory from the node ID
> > >
> > >On Wed, 20 Aug 2025 10:34:13 +0300
> > >Mike Rapoport <rppt@kernel.org> wrote:
> > >  
> > >> On Tue, Aug 19, 2025 at 05:54:20PM +0100, Jonathan Cameron wrote:  
> > >> > On Tue, 12 Aug 2025 15:26:13 +0100
> > >> > <shiju.jose@huawei.com> wrote:
> > >> >  
> > >> > > From: Shiju Jose <shiju.jose@huawei.com>
> > >> > >
> > >> > > In the numa_memblks, a lookup facility is required to retrieve the
> > >> > > physical address range of memory in a NUMA node. ACPI RAS2 memory
> > >> > > features are among the use cases.
> > >> > >
> > >> > > Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > >> > > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>  
> > >> >
> > >> > Looks fine to me.  Mike, what do you think?  
> > >>
> > >> I still don't see why we can't use existing functions like
> > >> get_pfn_range_for_nid() or memblock_search_pfn_nid().
> > >>
> > >> Or even node_start_pfn() and node_spanned_pages().  
> > >
> > >Good point.  No reason anyone would scrub this on memory that hasn't been
> > >hotplugged yet, so no need to use numa-memblk to get the info.
> > >I guess I was thinking of the wrong hammer :)
> > >
> > >I'm not sure node_spanned_pages() works though as we need not to include
> > >ranges that might be on another node as we'd give a wrong impression of what
> > >was being scrubbed.  
> 
> If nodes are not interleaved node_spanned_pages() would work, even if there
> are holes inside the node, like e.g. e820-reserved memory.
> So with non-interleaved nodes node_start_pfn() and either
> node_spanned_pages() or node_end_pfn() will give the node extents and they
> are faster than get_pfn_range_for_nid().
> 
> If the nodes are interleaved, though, a single mem_base, mem_size are not
> enough for a node as there are a few contiguous ranges in that node, e.g.
> 
>   0              4G              8G             12G            16G
>   +-------------+ +-------------+ +-------------+ +-------------+
>   |    node 0   | |    node 1   | |    node 0   | |    node 1   |
>   +-------------+ +-------------+ +-------------+ +-------------+
> 
> I didn't look into the details of the RAS2 driver, but isn't it's something
> it should handle?

The aim here is that a query prior to setting a specific range returns
data for at least a range that the scrub controller covers and nothing
it doesn't. So just presenting the first chunk for a node is fine.
There is plenty of info for userspace to figure things out if it wants
to trigger a scrub on 8-12G in your example, but until it does we want
to return 0-4G for the default range.

I hacked up some SRAT tables to give something like the above for testing.
> 
> > >Should be able to use some combination of node_start_pfn() and maybe
> > >memblock_search_pfn_nid() to get it though (that also gets the nid we already
> > >know but meh, no ral harm in that.)  
> > 
> > Thanks Mike and Jonathan.
> > 
> > The following approaches were tried as you suggested, instead of newly proposed
> > nid_get_mem_physaddr_range().
> > Methods 1 to 3 give the same result as nid_get_mem_physaddr_range(), but
> > Method 4 gives a different value for the size.  
> 
> I believe that's because on x86 the node 0 is really scrambled because of
> e820/efi reservations that never make it to memblock.

Fun question of whether we should take any notice of those.
Would depend on whether anyone's scrub firmware gets confused if we scrub
them and they aren't backed by memory.  If they are we can rely on system
constraints refusing to scrub that stuff at an 'unsafe' level and if we
set it higher than it otherwise would be only possibility is we see earlier
error detections in those and have to deal with them.

Jonathan


>  
> > Please advise which method should be used for the RAS2?
> > 
> > Thanks,
> > Shiju
> >   
> 


