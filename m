Return-Path: <linux-edac+bounces-4626-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B7DB2E2E4
	for <lists+linux-edac@lfdr.de>; Wed, 20 Aug 2025 19:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910A75E3095
	for <lists+linux-edac@lfdr.de>; Wed, 20 Aug 2025 17:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C41F322C9F;
	Wed, 20 Aug 2025 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNX5FnBn"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D928221F2F;
	Wed, 20 Aug 2025 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709373; cv=none; b=prQpngrgVqSTeZkSFol/AASHNGhf3U/HBhQ3rlwV695dZViumdb7h56FGd4B5o/FTjyQjEB/qKvNRoYnzsucVCDJZdjx1tKZUAo7tLoM0Qtn6nOpgmj/Kitk6bDscCWJdYIl6WUbWb4lIFQOPGevtotM56fUwYMH+3Are6AWvq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709373; c=relaxed/simple;
	bh=HrCdwjFpFxpaKWtgscNZ318aNnsG5NhL9DO1rfmynjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyNVT4/9qlHhyGzVE1TIwlAXysvyHNg3kaOjLcNEbO0n1Q5MtDaP58RWS54rnUS6hpsrwUlWfv9Opht7DYM1KX+IsKUtdP0DjoQXm0yLYm9w485ypwv44sqOG53QmirTSHBnhCIx1MfvK9qWUeP+wPciN7q6id8Zso/EIaTST94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNX5FnBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F515C4CEE7;
	Wed, 20 Aug 2025 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755709372;
	bh=HrCdwjFpFxpaKWtgscNZ318aNnsG5NhL9DO1rfmynjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNX5FnBnvRPnHvtWE445pbsFMOEnqBch380SOWkKQEEqYR3bTQB3UhYZL1zZq86gy
	 ZAPvZkHUR2Bb4QrLdatZM7uw1LdxYOvmqWz3/07RD0VAVhBxhDq4rZY85a7K9Gxdg0
	 0+HnI/K4ybXFFjpiWB56YQ8ARtzypHtkFPkQmpK5ahtnKknsDoPb8mKVzPnjM9L6oJ
	 XqnFDf/pemk0g94lPuynwtt/HYP8zzZD2e+d0mpAUikbFf7Atz47ODTY5ZcDVIloj8
	 HQqR2YMk42KWsT4S1D3sc1hBNDesVadUMxcI9A6B8j45r8vsSK+hATFecL0KdfNc5M
	 jX2YADHI1r3FA==
Date: Wed, 20 Aug 2025 20:02:38 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
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
Subject: Re: [PATCH v11 1/3] mm: Add support to retrieve physical address
 range of memory from the node ID
Message-ID: <aKX_rk0DasbDgJrS@kernel.org>
References: <20250812142616.2330-1-shiju.jose@huawei.com>
 <20250812142616.2330-2-shiju.jose@huawei.com>
 <20250819175420.00007ce6@huawei.com>
 <aKV6dVkPiBPw595T@kernel.org>
 <20250820095413.00003bd7@huawei.com>
 <964fc2721fb7499daa5f49eddfed54ff@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <964fc2721fb7499daa5f49eddfed54ff@huawei.com>

On Wed, Aug 20, 2025 at 10:00:50AM +0000, Shiju Jose wrote:
> >-----Original Message-----
> >From: Jonathan Cameron <jonathan.cameron@huawei.com>
> >Sent: 20 August 2025 09:54
> >To: Mike Rapoport <rppt@kernel.org>
> >Cc: Shiju Jose <shiju.jose@huawei.com>; rafael@kernel.org; bp@alien8.de;
> >akpm@linux-foundation.org; dferguson@amperecomputing.com; linux-
> >edac@vger.kernel.org; linux-acpi@vger.kernel.org; linux-mm@kvack.org; linux-
> >doc@vger.kernel.org; tony.luck@intel.com; lenb@kernel.org;
> >leo.duran@amd.com; Yazen.Ghannam@amd.com; mchehab@kernel.org;
> >Linuxarm <linuxarm@huawei.com>; rientjes@google.com;
> >jiaqiyan@google.com; Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
> >naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
> >somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
> >duenwen@google.com; gthelen@google.com;
> >wschwartz@amperecomputing.com; wbs@os.amperecomputing.com;
> >nifan.cxl@gmail.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
> ><prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
> >kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>
> >Subject: Re: [PATCH v11 1/3] mm: Add support to retrieve physical address
> >range of memory from the node ID
> >
> >On Wed, 20 Aug 2025 10:34:13 +0300
> >Mike Rapoport <rppt@kernel.org> wrote:
> >
> >> On Tue, Aug 19, 2025 at 05:54:20PM +0100, Jonathan Cameron wrote:
> >> > On Tue, 12 Aug 2025 15:26:13 +0100
> >> > <shiju.jose@huawei.com> wrote:
> >> >
> >> > > From: Shiju Jose <shiju.jose@huawei.com>
> >> > >
> >> > > In the numa_memblks, a lookup facility is required to retrieve the
> >> > > physical address range of memory in a NUMA node. ACPI RAS2 memory
> >> > > features are among the use cases.
> >> > >
> >> > > Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> >> > > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> >> >
> >> > Looks fine to me.  Mike, what do you think?
> >>
> >> I still don't see why we can't use existing functions like
> >> get_pfn_range_for_nid() or memblock_search_pfn_nid().
> >>
> >> Or even node_start_pfn() and node_spanned_pages().
> >
> >Good point.  No reason anyone would scrub this on memory that hasn't been
> >hotplugged yet, so no need to use numa-memblk to get the info.
> >I guess I was thinking of the wrong hammer :)
> >
> >I'm not sure node_spanned_pages() works though as we need not to include
> >ranges that might be on another node as we'd give a wrong impression of what
> >was being scrubbed.

If nodes are not interleaved node_spanned_pages() would work, even if there
are holes inside the node, like e.g. e820-reserved memory.
So with non-interleaved nodes node_start_pfn() and either
node_spanned_pages() or node_end_pfn() will give the node extents and they
are faster than get_pfn_range_for_nid().

If the nodes are interleaved, though, a single mem_base, mem_size are not
enough for a node as there are a few contiguous ranges in that node, e.g.

  0              4G              8G             12G            16G
  +-------------+ +-------------+ +-------------+ +-------------+
  |    node 0   | |    node 1   | |    node 0   | |    node 1   |
  +-------------+ +-------------+ +-------------+ +-------------+

I didn't look into the details of the RAS2 driver, but isn't it's something
it should handle?

> >Should be able to use some combination of node_start_pfn() and maybe
> >memblock_search_pfn_nid() to get it though (that also gets the nid we already
> >know but meh, no ral harm in that.)
> 
> Thanks Mike and Jonathan.
> 
> The following approaches were tried as you suggested, instead of newly proposed
> nid_get_mem_physaddr_range().
> Methods 1 to 3 give the same result as nid_get_mem_physaddr_range(), but
> Method 4 gives a different value for the size.

I believe that's because on x86 the node 0 is really scrambled because of
e820/efi reservations that never make it to memblock.
 
> Please advise which method should be used for the RAS2?
> 
> Thanks,
> Shiju
> 

-- 
Sincerely yours,
Mike.

