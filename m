Return-Path: <linux-edac+bounces-1131-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C141C8CEE11
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 08:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB30281BA2
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 06:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D46BE55;
	Sat, 25 May 2024 06:39:24 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9578DB65F;
	Sat, 25 May 2024 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716619164; cv=none; b=HVf9cD+eyRQYPS6tIPnd6I/zjeDfUG02/w72w0o7H15I8/5YOyBbphxMc76K8I7pKpGCCLx8fuLnHHC706ufpXJDfMcT/WPy0Ps6nVF1b0FnTJfR3IustJbr6zLFQP0QxV5EdGGIgbrzbmal1pbcs/taDQ3p49skUsSoFZY1kaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716619164; c=relaxed/simple;
	bh=tzjnnwmaKALSL+mff6QqnjTI8XCweVW0QvT8pa5RMTI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rK3a14a731iFoq8pfzi2u3B7WPnucQxMrqzZgXSbxDwkoDodS9ayAnKTPmKiVHAbPqxuqeCfRKcwtUjpYYxz4eoVoauPabm0/Rb2axRj6/waihpzkfIgYwx+l0a1jZIPVMCEEa8FXIqLVHa7O7FttbklPbrLpdDXgtjawWDVUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VmXGY2FwlzxPyn;
	Sat, 25 May 2024 14:35:33 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id D56DF180A9F;
	Sat, 25 May 2024 14:39:17 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 25 May 2024 14:39:17 +0800
Subject: Re: [PATCH 10/13] mm/memory-failure: move some function declarations
 into internal.h
To: kernel test robot <lkp@intel.com>
CC: <oe-kbuild-all@lists.linux.dev>, <nao.horiguchi@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <akpm@linux-foundation.org>,
	<tony.luck@intel.com>, <bp@alien8.de>
References: <20240524091310.1430048-11-linmiaohe@huawei.com>
 <202405251049.hxjwX7zO-lkp@intel.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2600230a-5e81-393f-509a-17dbdda99259@huawei.com>
Date: Sat, 25 May 2024 14:39:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202405251049.hxjwX7zO-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/25 10:39, kernel test robot wrote:
> Hi Miaohe,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on linus/master next-20240523]
> [cannot apply to v6.9]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Miaohe-Lin/mm-memory-failure-simplify-put_ref_page/20240524-171903
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240524091310.1430048-11-linmiaohe%40huawei.com
> patch subject: [PATCH 10/13] mm/memory-failure: move some function declarations into internal.h
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240525/202405251049.hxjwX7zO-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240525/202405251049.hxjwX7zO-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405251049.hxjwX7zO-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/vfio/vfio_iommu_spapr_tce.c: In function 'tce_page_is_contained':
>>> drivers/vfio/vfio_iommu_spapr_tce.c:195:16: error: implicit declaration of function 'page_shift'; did you mean 'page_size'? [-Werror=implicit-function-declaration]
>      195 |         return page_shift(compound_head(page)) >= it_page_shift;
>          |                ^~~~~~~~~~
>          |                page_size
>    cc1: some warnings being treated as errors
> --
>    arch/powerpc/mm/book3s64/iommu_api.c: In function 'mm_iommu_do_alloc':
>>> arch/powerpc/mm/book3s64/iommu_api.c:155:45: error: implicit declaration of function 'page_shift'; did you mean 'page_size'? [-Werror=implicit-function-declaration]
>      155 |                                 pageshift = page_shift(compound_head(page));
>          |                                             ^~~~~~~~~~
>          |                                             page_size
>    cc1: some warnings being treated as errors
> --
>    drivers/net/ethernet/ibm/ehea/ehea_qmr.c: In function 'ehea_is_hugepage':
>>> drivers/net/ethernet/ibm/ehea/ehea_qmr.c:676:13: error: implicit declaration of function 'page_shift'; did you mean 'page_size'? [-Werror=implicit-function-declaration]
>      676 |         if (page_shift(pfn_to_page(pfn)) != EHEA_HUGEPAGESHIFT)
>          |             ^~~~~~~~~~
>          |             page_size
>    cc1: some warnings being treated as errors

Will fix this too. Thanks for testing and reporting.
Thanks.
.


