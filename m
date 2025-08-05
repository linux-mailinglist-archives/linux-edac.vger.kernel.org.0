Return-Path: <linux-edac+bounces-4514-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A83B1B1D2
	for <lists+linux-edac@lfdr.de>; Tue,  5 Aug 2025 12:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A9F17BF13
	for <lists+linux-edac@lfdr.de>; Tue,  5 Aug 2025 10:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5549725C708;
	Tue,  5 Aug 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIQl1Zs0"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DAE1C6FE8;
	Tue,  5 Aug 2025 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389202; cv=none; b=TNraR2i1GGYBCRETLCCGaCQGUzAA7LC8awCHrO5/cSzIVoqre/JnQBmoDb5jhHtnA2elbqiuF9WQyF0H8CvKtDuhEpeXjNE6YknyP829XDk78HscOApvCQAXQRo7qeDbbPEVc7nREjXTBcvpa6l6mbyqU8k24Rav1+plvKEZHAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389202; c=relaxed/simple;
	bh=mdNZYWbFwgA6wLySuufnXZ/JAGUhvzf+uMdGc+KNcdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk0x56RZ2qIQ3HnrMLxjjrjgpbcTdGitzfJmTeTp6vjvMrt1P20BiVJmzcPSspAqF9CmZbXjX4L2XzdIUdtH29yCJVfX/hNxl71G9S3mMKrvAsLioocojjmBkYI7j3x05knUDEBXEWJV8m3ST9GMDNjPHFGZYoPfhN/OL/wuQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIQl1Zs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C66C4CEF0;
	Tue,  5 Aug 2025 10:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754389201;
	bh=mdNZYWbFwgA6wLySuufnXZ/JAGUhvzf+uMdGc+KNcdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIQl1Zs0pphGzQ0D+uUStwqrKbP0YZ16uUALphH+BgUVJxBpBDD/jms0iHyHR3/4c
	 VBiG6syvDMsxCFiM/ra36yC4X41rXNG34op9JTHWewqtax9FMGuVbtGqDnWb0YBKI+
	 ZDQPX+200tPD+X09fpd+CGRmjFfj05gyHnfuvQRz8IpfmxME3tyMWrb3zwbJ7bnGZV
	 jGGg0VOw03cOD40VrrsUelw/S2tLepRWw2Bn+eqrwJ9xDjjl8LkVGmsG1iuva/X7yA
	 HKuixAgByb96cjaiT+nOQljFx33X4WlgUuoqYezLIsDVcXcjlmboUVzX8Ra3VSfejh
	 VEit4gDLeGixw==
Date: Tue, 5 Aug 2025 13:19:46 +0300
From: Mike Rapoport <rppt@kernel.org>
To: shiju.jose@huawei.com
Cc: rafael@kernel.org, bp@alien8.de, akpm@linux-foundation.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org,
	jonathan.cameron@huawei.com, linuxarm@huawei.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v10 1/3] mm: Add node_to_range lookup facility to
 numa_memblks
Message-ID: <aJHawm1zE62x1YH9@kernel.org>
References: <20250801172040.2175-1-shiju.jose@huawei.com>
 <20250801172040.2175-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801172040.2175-2-shiju.jose@huawei.com>

On Fri, Aug 01, 2025 at 06:20:27PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Lookup facility to retrieve memory phys lowest continuous range for
> a NUMA node is required in the numa_memblks for the ACPI RAS2 memory
> scrub use case.

If the code that needs to find the lowest contiguous range in a node runs
before we discard .init you can just use

	unsigned long pfn = node_start_pfn(nid);
	unsigned long start_pfn, end_pfn;

	memblock_search_pfn_nid(pfn, &start_pfn, &end_pfn);
 
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  include/linux/numa.h         | 10 ++++++++++
>  include/linux/numa_memblks.h |  2 ++
>  mm/numa.c                    | 10 ++++++++++
>  mm/numa_memblks.c            | 23 +++++++++++++++++++++++
>  4 files changed, 45 insertions(+)
> 
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index e6baaf6051bc..d41e583a902d 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -41,6 +41,10 @@ int memory_add_physaddr_to_nid(u64 start);
>  int phys_to_target_node(u64 start);
>  #endif
>  
> +#ifndef node_to_phys_lowest_continuous_range
> +int node_to_phys_lowest_continuous_range(int nid, u64 *start, u64 *end);
> +#endif
> +
>  int numa_fill_memblks(u64 start, u64 end);
>  
>  #else /* !CONFIG_NUMA */
> @@ -63,6 +67,12 @@ static inline int phys_to_target_node(u64 start)
>  	return 0;
>  }
>  
> +static inline int node_to_phys_lowest_continuous_range(int nid, u64 *start,
> +						       u64 *end)
> +{
> +	return 0;
> +}
> +
>  static inline void alloc_offline_node_data(int nid) {}
>  #endif
>  
> diff --git a/include/linux/numa_memblks.h b/include/linux/numa_memblks.h
> index 991076cba7c5..ccc53029de8b 100644
> --- a/include/linux/numa_memblks.h
> +++ b/include/linux/numa_memblks.h
> @@ -55,6 +55,8 @@ extern int phys_to_target_node(u64 start);
>  #define phys_to_target_node phys_to_target_node
>  extern int memory_add_physaddr_to_nid(u64 start);
>  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> +extern int node_to_phys_lowest_continuous_range(int nid, u64 *start, u64 *end);
> +#define node_to_phys_lowest_continuous_range node_to_phys_lowest_continuous_range
>  #endif /* CONFIG_NUMA_KEEP_MEMINFO */
>  
>  #endif /* CONFIG_NUMA_MEMBLKS */
> diff --git a/mm/numa.c b/mm/numa.c
> index 7d5e06fe5bd4..0affb56ef4f2 100644
> --- a/mm/numa.c
> +++ b/mm/numa.c
> @@ -59,3 +59,13 @@ int phys_to_target_node(u64 start)
>  }
>  EXPORT_SYMBOL_GPL(phys_to_target_node);
>  #endif
> +
> +#ifndef node_to_phys_lowest_continuous_range
> +int node_to_phys_lowest_continuous_range(int nid, u64 *start, u64 *end)
> +{
> +	pr_info_once("Unknown target phys addr range for node=%d\n", nid);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(node_to_phys_lowest_continuous_range);
> +#endif
> diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> index 541a99c4071a..9cbaa38cb92d 100644
> --- a/mm/numa_memblks.c
> +++ b/mm/numa_memblks.c
> @@ -590,4 +590,27 @@ int memory_add_physaddr_to_nid(u64 start)
>  }
>  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
>  
> +static int nid_to_meminfo(struct numa_meminfo *mi, int nid, u64 *start, u64 *end)
> +{
> +	int i;
> +
> +	if (!numa_valid_node(nid))
> +		return -EINVAL;
> +
> +	for (i = 0; i < mi->nr_blks; i++) {
> +		if (mi->blk[i].nid == nid) {
> +			*start = mi->blk[i].start;
> +			*end = mi->blk[i].end;
> +			return 0;
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +int node_to_phys_lowest_continuous_range(int nid, u64 *start, u64 *end)
> +{
> +	return nid_to_meminfo(&numa_meminfo, nid, start, end);
> +}
> +EXPORT_SYMBOL_GPL(node_to_phys_lowest_continuous_range);
>  #endif /* CONFIG_NUMA_KEEP_MEMINFO */
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

