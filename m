Return-Path: <linux-edac+bounces-4620-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC84BB2D4ED
	for <lists+linux-edac@lfdr.de>; Wed, 20 Aug 2025 09:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F3A5E0995
	for <lists+linux-edac@lfdr.de>; Wed, 20 Aug 2025 07:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7FD2D77ED;
	Wed, 20 Aug 2025 07:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aksLANPG"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70A2D12F1;
	Wed, 20 Aug 2025 07:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755675268; cv=none; b=oHGv51o3BIrFdQzfPFQTo2jJlKsoWS3qJ94Yko/+2oLSiEB4811R2ofhZf9MITx7zF3vH7106998NaLYmPcRJXZN4IQ0GtrEWpndzqVw/vz7C/n86oBRXeN3avkmlkKMra/WARcrn+hwPEUmeEqniUeiBSxlz5QjYg1Fr5+xHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755675268; c=relaxed/simple;
	bh=S0V/4dKtt8sp5Rr98YYau2qnf57W5w/l2pXbvrWzIZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFUAjtsTfmnaHqulSrxU1SV33lOYF4rznm0p6ImzMwegiMt2S6vpi7y84Seqa6bXQ54a35rrNNiPSggAwFCx37U77IaJS2NxWv5GD4/gysuFbe0ll1IuFHRfZsSNZUg6k9cHm4w8WfW095jq1UNepc3MJiXGpyHjmW2pWMQ0SHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aksLANPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E56EC4CEEB;
	Wed, 20 Aug 2025 07:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755675267;
	bh=S0V/4dKtt8sp5Rr98YYau2qnf57W5w/l2pXbvrWzIZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aksLANPGpnI9UQe5XTTQfMLhWuAJfl4+lnUMD7idLLVt/7G9V17mbP2+ZVsieHrkJ
	 BaP2URMB7jrlbkiQnAvyih2743LQBwny1XJjC3jqtpy8q+zOBXVOjJKoY7jnyPr+/4
	 g/d7HOMIt3S/WVb2PUjeMQD8HVuB4cDz29q85/KOkhOpUpPQeg5sySUDHAB/j0qVp7
	 OPdwxIuaYdDRnSLNmiWhNPRBwYX+2JDnESggo5FwcPLsLWEWreiI9lpk3I34F4bn7U
	 D7Q2snD2Xzqdg3UGTCkZnYHRMpMkD0sP4sqvk7+576a0tL7C6KLY86LHTK9GOIjxjV
	 mEVgXf8lxy/yg==
Date: Wed, 20 Aug 2025 10:34:13 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: shiju.jose@huawei.com, rafael@kernel.org, bp@alien8.de,
	akpm@linux-foundation.org, dferguson@amperecomputing.com,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org, tony.luck@intel.com,
	lenb@kernel.org, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	mchehab@kernel.org, linuxarm@huawei.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
Subject: Re: [PATCH v11 1/3] mm: Add support to retrieve physical address
 range of memory from the node ID
Message-ID: <aKV6dVkPiBPw595T@kernel.org>
References: <20250812142616.2330-1-shiju.jose@huawei.com>
 <20250812142616.2330-2-shiju.jose@huawei.com>
 <20250819175420.00007ce6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819175420.00007ce6@huawei.com>

On Tue, Aug 19, 2025 at 05:54:20PM +0100, Jonathan Cameron wrote:
> On Tue, 12 Aug 2025 15:26:13 +0100
> <shiju.jose@huawei.com> wrote:
> 
> > From: Shiju Jose <shiju.jose@huawei.com>
> > 
> > In the numa_memblks, a lookup facility is required to retrieve the
> > physical address range of memory in a NUMA node. ACPI RAS2 memory
> > features are among the use cases.
> > 
> > Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> 
> Looks fine to me.  Mike, what do you think?

I still don't see why we can't use existing functions like
get_pfn_range_for_nid() or memblock_search_pfn_nid().

Or even node_start_pfn() and node_spanned_pages().

> One passing comment inline.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> > ---
> >  include/linux/numa.h         |  9 +++++++++
> >  include/linux/numa_memblks.h |  2 ++
> >  mm/numa.c                    | 10 ++++++++++
> >  mm/numa_memblks.c            | 37 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 58 insertions(+)
> > 
> > diff --git a/include/linux/numa.h b/include/linux/numa.h
> > index e6baaf6051bc..1d1aabebd26b 100644
> > --- a/include/linux/numa.h
> > +++ b/include/linux/numa.h
> > @@ -41,6 +41,10 @@ int memory_add_physaddr_to_nid(u64 start);
> >  int phys_to_target_node(u64 start);
> >  #endif
> >  
> > +#ifndef nid_get_mem_physaddr_range
> > +int nid_get_mem_physaddr_range(int nid, u64 *start, u64 *end);
> > +#endif
> > +
> >  int numa_fill_memblks(u64 start, u64 end);
> >  
> >  #else /* !CONFIG_NUMA */
> > @@ -63,6 +67,11 @@ static inline int phys_to_target_node(u64 start)
> >  	return 0;
> >  }
> >  
> > +static inline int nid_get_mem_physaddr_range(int nid, u64 *start, u64 *end)
> > +{
> > +	return 0;
> > +}
> > +
> >  static inline void alloc_offline_node_data(int nid) {}
> >  #endif
> >  
> > diff --git a/include/linux/numa_memblks.h b/include/linux/numa_memblks.h
> > index 991076cba7c5..7b32d96d0134 100644
> > --- a/include/linux/numa_memblks.h
> > +++ b/include/linux/numa_memblks.h
> > @@ -55,6 +55,8 @@ extern int phys_to_target_node(u64 start);
> >  #define phys_to_target_node phys_to_target_node
> >  extern int memory_add_physaddr_to_nid(u64 start);
> >  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> > +extern int nid_get_mem_physaddr_range(int nid, u64 *start, u64 *end);
> > +#define nid_get_mem_physaddr_range nid_get_mem_physaddr_range
> >  #endif /* CONFIG_NUMA_KEEP_MEMINFO */
> >  
> >  #endif /* CONFIG_NUMA_MEMBLKS */
> > diff --git a/mm/numa.c b/mm/numa.c
> > index 7d5e06fe5bd4..5335af1fefee 100644
> > --- a/mm/numa.c
> > +++ b/mm/numa.c
> > @@ -59,3 +59,13 @@ int phys_to_target_node(u64 start)
> >  }
> >  EXPORT_SYMBOL_GPL(phys_to_target_node);
> >  #endif
> > +
> > +#ifndef nid_get_mem_physaddr_range
> > +int nid_get_mem_physaddr_range(int nid, u64 *start, u64 *end)
> > +{
> > +	pr_info_once("Unknown target phys addr range for node=%d\n", nid);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(nid_get_mem_physaddr_range);
> > +#endif
> > diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> > index 541a99c4071a..e1e56b7a3499 100644
> > --- a/mm/numa_memblks.c
> > +++ b/mm/numa_memblks.c
> > @@ -590,4 +590,41 @@ int memory_add_physaddr_to_nid(u64 start)
> >  }
> >  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> >  
> > +/**
> > + * nid_get_mem_physaddr_range - Get the physical address range
> > + *				of the memblk in the NUMA node.
> > + * @nid: NUMA node ID of the memblk
> > + * @start: Start address of the memblk
> > + * @end: End address of the memblk
> > + *
> > + * Find the lowest contiguous physical memory address range of the memblk
> > + * in the NUMA node with the given nid and return the start and end
> > + * addresses.
> > + *
> > + * RETURNS:
> > + * 0 on success, -errno on failure.
> > + */
> > +int nid_get_mem_physaddr_range(int nid, u64 *start, u64 *end)
> > +{
> > +	struct numa_meminfo *mi = &numa_meminfo;
> > +	int i;
> > +
> > +	if (!numa_valid_node(nid))
> > +		return -EINVAL;
> > +
> > +	for (i = 0; i < mi->nr_blks; i++) {
> > +		if (mi->blk[i].nid == nid) {
> > +			*start = mi->blk[i].start;
> > +			/*
> > +			 * Assumption: mi->blk[i].end is the last address
> > +			 * in the range + 1.
> 
> This was my fault for asking on internal review if this was documented
> anywhere. It's kind of implicitly obvious when reading numa_memblk.c
> because there are a bunch of end - 1 prints.
> So can probably drop this comment.
> 
> > +			 */
> > +			*end = mi->blk[i].end;
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	return -ENODEV;
> > +}
> > +EXPORT_SYMBOL_GPL(nid_get_mem_physaddr_range);
> >  #endif /* CONFIG_NUMA_KEEP_MEMINFO */
> 

-- 
Sincerely yours,
Mike.

