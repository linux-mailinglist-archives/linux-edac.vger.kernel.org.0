Return-Path: <linux-edac+bounces-5650-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F217AD38B52
	for <lists+linux-edac@lfdr.de>; Sat, 17 Jan 2026 02:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A5A73034A2B
	for <lists+linux-edac@lfdr.de>; Sat, 17 Jan 2026 01:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339B31E47C5;
	Sat, 17 Jan 2026 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5USWxNM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110214A91
	for <linux-edac@vger.kernel.org>; Sat, 17 Jan 2026 01:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768614402; cv=pass; b=cOOkZnlyrdVbdiXvI7Y4wh5P7R3OzAu0dQs+vjU8r+PnazUi1ll0F5ra97bn9iSgGTSImrAAjBxWOpKdYY1tJwsZ/lB/m0EmGiaR16rvOLjDMf3vL3XNz1X5oJZfkEYfv+ZCq9A6vIn9zdJJe1wJ6l5fHpR6LfqQh1llTou7wCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768614402; c=relaxed/simple;
	bh=rhGlXDGJVZh//kyAHEA9D+kTdWvg73LAXj19n+HVlEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsuQjEa7HhBVwM+AqZpg9QtGiXzbGnea9ehVH5mCIZgs6mTW7ZTcwoJnidEM1E0CMNCAoMGGForyLljCVTj3X5EBqros+tm/pj2YyGXo7dyEmPSz01L4TriGq0kDvOVuHCwOzg4/A6MQ7P/Dwbd2Rtk4HnezC8i64KtKgncouMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5USWxNM; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4801cf7c2c7so10885e9.1
        for <linux-edac@vger.kernel.org>; Fri, 16 Jan 2026 17:46:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768614399; cv=none;
        d=google.com; s=arc-20240605;
        b=O6ETUOuJjv02/mCFRU/9hURHJ8ckiwO3HJkbUc+sUnb1iVgaLdwlHkBAYZqyVVYOTQ
         b9nf99QYNbFF4mRGcqAXZh5AMMZzUvWyC0Xt30gAbJ8zlwb/kfY1syEq+QoZiwStP8ao
         B6G2nSzCnLn4jLTbsh9Z2mD5Go3HRYb30s+33vVGrp3xPAGXkNEFO3/k+n6pUtinq1v6
         bR3pdn31qjQ8RFyKgBmks3iUSlareAeVLVxD9VQIyRGmE9y+1b1PePwncWZhu1Os3eMQ
         897iMylZSvnRui2/D3L8tIVej8TTb3fWItOV4yNXGlLpZIqf8d/J7YdP6dXcYd6KmgiD
         +q4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QawnIC/rKqzEiT5sLO4diiV4bNp94xP9Rmr2Cmn3G2E=;
        fh=tmRQbXqXKslV+IehaV2kozYZF1LVYrdyr0KJ2ya7Ok0=;
        b=fSWQG2AssqhQ735Q+kTD1GhKBdHvkYt6o/giNUbgqPPfjqN6PCAab7Y1chM3r0Haz9
         ppLLwDv50bDi1dZJlctw2taqpb1LoxAI+HpH5x5nMQr0/Zi8HO+qlOkAhCKVkqWoGF3m
         Cq/MyaFslKTsfa5hpwSAN0GKBjD/hg7pa2aps/cWniqb+oY0Qgw3ee0rBdlt/DyZM7On
         4ULqFv5O5O7hYPEHn6shix/kCRLRFMYhhGbOY6XiMLHbtsXbmC3YKO7wnrmBdf68wmiT
         j7b/BjsheBrKO9Pabyi0cesYuOEWpTxUEP5ZzGWDBP4blg/zjXcjK0DYQ9DPux9/ZbyZ
         krDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768614399; x=1769219199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QawnIC/rKqzEiT5sLO4diiV4bNp94xP9Rmr2Cmn3G2E=;
        b=g5USWxNMS63TEdPoBmHk5Y9sNP1mQqE6FqRIGQY32DTaKWxT6qH5b4PU8OyMgLPjdX
         AcvSbirMGeMdGbtaBcwz+m3KOajUrj1SD/a6/nMT4fuCVQunvq2nJqF0aObUJ3U+nj5R
         0VYUAqGc4Hx81h3h8oZTQc6U11NOTHmMImSb+8JdHt6uP+v6Xv6znaeRktTYRxV9iEd1
         GQP9Bq+vtXVG6b9kiuDAVCvfGgzKKWuHOLpaNK44LeIpugi70fZwj+PSmZrZh64HXRhR
         xD/gsgyS81bxJxn6pS/er1v930grEDNZ7fvU6ro7WY3/gHwFeU5Zet2nlYaTEjGs+UtE
         CPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768614399; x=1769219199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QawnIC/rKqzEiT5sLO4diiV4bNp94xP9Rmr2Cmn3G2E=;
        b=e/oM+PWaOWFX8rhGBXW1qxzPYPkh+8s3QmFwj8ug0eSZGHzxIijK3M6AHYcGTPMnep
         5/L4v9QAzLy0NNDCtqykBFsjXmpPSNiNJ+OKyYV6wunn3bESSh9A2uHHD2EEpm0HdRdG
         xh7gLNuBnZrYdwxhOG6SCaYlNyNc1sV26nubQF3sdZXbP6NnTdotmvq8JLmsN6Jeh7Vv
         5AowLaiiFavgF8HXkxW8cciQ2sokAz/Q6Nez6yiomBXRTExOCQKgF2Iz3ytCMcnMAHxs
         U6C+yMu3luToDdv2MWwABopL1y5o7a4V76jFMMV4dWEknup4DbysG5TCE+u8xEyjydEH
         5VWA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Ss7lG1ArorRdIsKaZ8aEpAg6weAeDLriOzXsHMeuuei3+BfAkCYtjkJNGjRx3lUzrC6cEnSkNp+I@vger.kernel.org
X-Gm-Message-State: AOJu0YxX985udbEk//09Rdc8oKaX0iLgnDSHUebCusbeBeAugHY1SNep
	M59Qzx0cqBxkTZQm8AN3jBWqbIP8KJ018guDeoM14p/1Zrobtcb37kmu2H/EGupRJACKhldMrqy
	iVooUCPHOBwtlrlnjEIFr+yoNrKQdyCGNsDispGyA
X-Gm-Gg: AY/fxX424I4RcsELx6TzT3KJOWgTcGGxF3Kxqbk+jXOxOy2VKHHUcQZlLxveqh9hwMT
	3vUFQAh7d3udUJRdXBq2W3ZvKOaC0/NL6pwAl/mxlXab7/cD2jyijAqXniz40iz44T4RL1Qlf51
	f9bHziPw53Tw7lbd3IGZXBt1NNFEUrhIcPcMkm5gIAQ7TIWE0ODSBuAoNQyoDt7CcvqAk1XytUb
	g6AQDozfWQNF6Ip7Bi60Xob+aO6jhYh02BV2SFPrmLhOl81Ei/TvIPdIbII+2u1SX0ibHmT+1sI
	rZJIx8G+ewPdpLOJoE6RjqRIpw==
X-Received: by 2002:a05:600c:2159:b0:47d:7428:d00c with SMTP id
 5b1f17b1804b1-4802831ff1bmr125265e9.17.1768614398594; Fri, 16 Jan 2026
 17:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102184434.2406-1-ankita@nvidia.com>
In-Reply-To: <20251102184434.2406-1-ankita@nvidia.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 16 Jan 2026 17:46:27 -0800
X-Gm-Features: AZwV_QgWqDDKvf2998qT7WGKusfsVNwwlVxtPgQtBBUSk5Pxl571jMObyaPcU9E
Message-ID: <CACw3F51k=sFtXB1JE3HCcXP6EA0Tt4Yf44VUi3JLz0bgW-aArQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] mm: Implement ECC handling for pfn with no struct page
To: ankita@nvidia.com
Cc: aniketa@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com, mochs@nvidia.com, 
	skolothumtho@nvidia.com, linmiaohe@huawei.com, nao.horiguchi@gmail.com, 
	akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, tony.luck@intel.com, bp@alien8.de, rafael@kernel.org, 
	guohanjun@huawei.com, mchehab@kernel.org, lenb@kernel.org, 
	kevin.tian@intel.com, alex@shazbot.org, cjia@nvidia.com, kwankhede@nvidia.com, 
	targupta@nvidia.com, zhiw@nvidia.com, dnigam@nvidia.com, kjaju@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-edac@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, ira.weiny@intel.com, 
	Smita.KoralahalliChannabasappa@amd.com, u.kleine-koenig@baylibre.com, 
	peterz@infradead.org, linux-acpi@vger.kernel.org, kvm@vger.kernel.org, 
	Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 10:45=E2=80=AFAM <ankita@nvidia.com> wrote:
>
> From: Ankit Agrawal <ankita@nvidia.com>
>
> Poison (or ECC) errors can be very common on a large size cluster.
> The kernel MM currently handles ECC errors / poison only on memory page
> backed by struct page. The handling is currently missing for the PFNMAP
> memory that does not have struct pages. The series adds such support.
>
> Implement a new ECC handling for memory without struct pages. Kernel MM
> expose registration APIs to allow modules that are managing the device
> to register its device memory region. MM then tracks such regions using
> interval tree.
>
> The mechanism is largely similar to that of ECC on pfn with struct pages.
> If there is an ECC error on a pfn, all the mapping to it are identified
> and a SIGBUS is sent to the user space processes owning those mappings.
> Note that there is one primary difference versus the handling of the
> poison on struct pages, which is to skip unmapping to the faulty PFN.
> This is done to handle the huge PFNMAP support added recently [1] that
> enables VM_PFNMAP vmas to map at PMD or PUD level. A poison to a PFN
> mapped in such as way would need breaking the PMD/PUD mapping into PTEs
> that will get mirrored into the S2. This can greatly increase the cost
> of table walks and have a major performance impact.
>
> nvgrace-gpu-vfio-pci module maps the device memory to user VA (Qemu) usin=
g
> remap_pfn_range without being added to the kernel [2]. These device memor=
y
> PFNs are not backed by struct page. So make nvgrace-gpu-vfio-pci module
> make use of the mechanism to get poison handling support on the device
> memory.
>
> Patch rebased to v6.17-rc7.
>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>
> Link: https://lore.kernel.org/all/20251026141919.2261-1-ankita@nvidia.com=
/ [v4]
>
> v4 -> v5
> - Removed pfn_space NULL checks. Instead a wrong parameter would cause
> a panic. (Thanks Andrew Morton for suggestion)
> - Log message to mention kmalloc allocation error and the failure to
> kill a process. (Thanks Andrew Morton)
> - Comments with 80 chars.
>
> v3 -> v4
> - Added guards in memory_failure_pfn, register, unregister function to
> simplify code. (Thanks Ira Weiny for suggestion).
> - Collected reviewed-by from Shuai Xue (Thanks!) on the mm GHES patch. Al=
so
> moved it to the front of the series.
> - Added check for interval_tree_iter_first before removing the device
> memory region. (Thanks Jiaqi Yan for suggestion)
> - If pfn doesn't belong to any address space mapping, returning
> MF_IGNORED (Thanks Miaohe Lin for suggestion).
> - Updated patch commit to add more details on the perf impact on
> HUGE PFNMAP (Thanks Jason Gunthorpe, Tony Luck for suggestion).
>
> v2 -> v3
> - Rebased to v6.17-rc7.
> - Skipped the unmapping of PFNMAP during reception of poison. Suggested b=
y
> Jason Gunthorpe, Jiaqi Yan, Vikram Sethi (Thanks!)
> - Updated the check to prevent multiple registration to the same PFN
> range using interval_tree_iter_first. Thanks Shameer Kolothum for the
> suggestion.
> - Removed the callback function in the nvgrace-gpu requiring tracking of
> poisoned PFN as it isn't required anymore.

Hi Ankit,

I get that for nvgrace-gpu driver, you removed pfn_address_space_ops
because there is no need to unmap poisoned HBM page.

What about the nvgrace-egm driver? Now that you removed the
pfn_address_space_ops callback from pfn_address_space in [1], how can
nvgrace-egm driver know the poisoned EGM pages at runtime?

I expect the functionality to return retired pages should also include
runtime poisoned pages, which are not in the list queried from
egm-retired-pages-data-base during initialization. Or maybe my
expection is wrong/obsolete?

[1] https://lore.kernel.org/linux-mm/20230920140210.12663-2-ankita@nvidia.c=
om
[2] https://lore.kernel.org/kvm/20250904040828.319452-12-ankita@nvidia.com

> - Introduced seperate collect_procs_pfn function to collect the list of
> processes mapping to the poisoned PFN.
>
> v1 -> v2
> - Change poisoned page tracking from bitmap to hashtable.
> - Addressed miscellaneous comments in v1.
>
> Link: https://lore.kernel.org/all/20240826204353.2228736-1-peterx@redhat.=
com/ [1]
> Link: https://lore.kernel.org/all/20240220115055.23546-1-ankita@nvidia.co=
m/ [2]
>
> Ankit Agrawal (3):
>   mm: Change ghes code to allow poison of non-struct pfn
>   mm: handle poisoning of pfn without struct pages
>   vfio/nvgrace-gpu: register device memory for poison handling
>
>  MAINTAINERS                         |   1 +
>  drivers/acpi/apei/ghes.c            |   6 --
>  drivers/vfio/pci/nvgrace-gpu/main.c |  45 ++++++++-
>  include/linux/memory-failure.h      |  17 ++++
>  include/linux/mm.h                  |   1 +
>  include/ras/ras_event.h             |   1 +
>  mm/Kconfig                          |   1 +
>  mm/memory-failure.c                 | 145 +++++++++++++++++++++++++++-
>  8 files changed, 209 insertions(+), 8 deletions(-)
>  create mode 100644 include/linux/memory-failure.h
>
> --
> 2.34.1
>
>

