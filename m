Return-Path: <linux-edac+bounces-4611-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A5EB2CA02
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 18:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0261BC7664
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F302BEFEE;
	Tue, 19 Aug 2025 16:54:29 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B796C255E53;
	Tue, 19 Aug 2025 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755622469; cv=none; b=hdpNUNcQKI9MkO5atyvvMZVbipK1epXKTXUFh9Nnea2Ea/9t0s3ZsowhWiiy6p+3c8EL+C3i59EOeldOqmJjicG2X+tGX2TVgaz6G42X/ziBpdz6V0N6tk5pQXEz2zRdflS3H4llQrcX/DryJOXG9NAyg+ynnohrwkrvBw6kZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755622469; c=relaxed/simple;
	bh=aTvhuH50RKyGagT1nC1O+DaUbd9uQE1xNum/vjc31Jk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPYza/gkne/LHjgVehE41r5Ybbbh3E7R0yH+jACDn3IYsEm+AmYKWzosYCYipurOO9ZeLdL3D5ddBLwa9RGqQfFQ37fHkV1QZjSMB53QNmpFRasDODW272zO5zijHq5WAZ3Ln7m7DsYptrkmqcHU1VESUnMtBL0D5y40lRTsp7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5wZy4t9jz6L5BV;
	Wed, 20 Aug 2025 00:51:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FAA61402F2;
	Wed, 20 Aug 2025 00:54:23 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 18:54:21 +0200
Date: Tue, 19 Aug 2025 17:54:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <rafael@kernel.org>, <bp@alien8.de>, <akpm@linux-foundation.org>,
	<rppt@kernel.org>, <dferguson@amperecomputing.com>,
	<linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-doc@vger.kernel.org>, <tony.luck@intel.com>,
	<lenb@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <linuxarm@huawei.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>
Subject: Re: [PATCH v11 1/3] mm: Add support to retrieve physical address
 range of memory from the node ID
Message-ID: <20250819175420.00007ce6@huawei.com>
In-Reply-To: <20250812142616.2330-2-shiju.jose@huawei.com>
References: <20250812142616.2330-1-shiju.jose@huawei.com>
	<20250812142616.2330-2-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Aug 2025 15:26:13 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> In the numa_memblks, a lookup facility is required to retrieve the
> physical address range of memory in a NUMA node. ACPI RAS2 memory
> features are among the use cases.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Looks fine to me.  Mike, what do you think?

One passing comment inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  include/linux/numa.h         |  9 +++++++++
>  include/linux/numa_memblks.h |  2 ++
>  mm/numa.c                    | 10 ++++++++++
>  mm/numa_memblks.c            | 37 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 58 insertions(+)
> 
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index e6baaf6051bc..1d1aabebd26b 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -41,6 +41,10 @@ int memory_add_physaddr_to_nid(u64 start);
>  int phys_to_target_node(u64 start);
>  #endif
>  
> +#ifndef nid_get_mem_physaddr_range
> +int nid_get_mem_physaddr_range(int nid, u64 *start, u64 *end);
> +#endif
> +
>  int numa_fill_memblks(u64 start, u64 end);
>  
>  #else /* !CONFIG_NUMA */
> @@ -63,6 +67,11 @@ static inline int phys_to_target_node(u64 start)
>  	return 0;
>  }
>  
> +static inline int nid_get_mem_physaddr_range(int nid, u64 *start, u64 *end)
> +{
> +	return 0;
> +}
> +
>  static inline void alloc_offline_node_data(int nid) {}
>  #endif
>  
> diff --git a/include/linux/numa_memblks.h b/include/linux/numa_memblks.h
> index 991076cba7c5..7b32d96d0134 100644
> --- a/include/linux/numa_memblks.h
> +++ b/include/linux/numa_memblks.h
> @@ -55,6 +55,8 @@ extern int phys_to_target_node(u64 start);
>  #define phys_to_target_node phys_to_target_node
>  extern int memory_add_physaddr_to_nid(u64 start);
>  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> +extern int nid_get_mem_physaddr_range(int nid, u64 *start, u64 *end);
> +#define nid_get_mem_physaddr_range nid_get_mem_physaddr_range
>  #endif /* CONFIG_NUMA_KEEP_MEMINFO */
>  
>  #endif /* CONFIG_NUMA_MEMBLKS */
> diff --git a/mm/numa.c b/mm/numa.c
> index 7d5e06fe5bd4..5335af1fefee 100644
> --- a/mm/numa.c
> +++ b/mm/numa.c
> @@ -59,3 +59,13 @@ int phys_to_target_node(u64 start)
>  }
>  EXPORT_SYMBOL_GPL(phys_to_target_node);
>  #endif
> +
> +#ifndef nid_get_mem_physaddr_range
> +int nid_get_mem_physaddr_range(int nid, u64 *start, u64 *end)
> +{
> +	pr_info_once("Unknown target phys addr range for node=%d\n", nid);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nid_get_mem_physaddr_range);
> +#endif
> diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> index 541a99c4071a..e1e56b7a3499 100644
> --- a/mm/numa_memblks.c
> +++ b/mm/numa_memblks.c
> @@ -590,4 +590,41 @@ int memory_add_physaddr_to_nid(u64 start)
>  }
>  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
>  
> +/**
> + * nid_get_mem_physaddr_range - Get the physical address range
> + *				of the memblk in the NUMA node.
> + * @nid: NUMA node ID of the memblk
> + * @start: Start address of the memblk
> + * @end: End address of the memblk
> + *
> + * Find the lowest contiguous physical memory address range of the memblk
> + * in the NUMA node with the given nid and return the start and end
> + * addresses.
> + *
> + * RETURNS:
> + * 0 on success, -errno on failure.
> + */
> +int nid_get_mem_physaddr_range(int nid, u64 *start, u64 *end)
> +{
> +	struct numa_meminfo *mi = &numa_meminfo;
> +	int i;
> +
> +	if (!numa_valid_node(nid))
> +		return -EINVAL;
> +
> +	for (i = 0; i < mi->nr_blks; i++) {
> +		if (mi->blk[i].nid == nid) {
> +			*start = mi->blk[i].start;
> +			/*
> +			 * Assumption: mi->blk[i].end is the last address
> +			 * in the range + 1.

This was my fault for asking on internal review if this was documented
anywhere. It's kind of implicitly obvious when reading numa_memblk.c
because there are a bunch of end - 1 prints.
So can probably drop this comment.

> +			 */
> +			*end = mi->blk[i].end;
> +			return 0;
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(nid_get_mem_physaddr_range);
>  #endif /* CONFIG_NUMA_KEEP_MEMINFO */


