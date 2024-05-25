Return-Path: <linux-edac+bounces-1129-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E58CED72
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 03:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5C41C20899
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 01:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F9610F2;
	Sat, 25 May 2024 01:52:22 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2837A7E8;
	Sat, 25 May 2024 01:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716601942; cv=none; b=gM24tBt3Jef6S+g92FHwBpmwJ83rBfTSqi/h6yC7UI3fqDujrEcYg7jwcxdu9HUuqvK1hh/lS+2OvYPXyoGIpmAygchNMB9CLo2MEC7VM4fBx8+I4WFWwnbOZ3XuE56iWJTBKKCOpsC8SxJSZTz2GEVT89YBtmvTFbJLwjRhwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716601942; c=relaxed/simple;
	bh=awSIA+3nw6YEa7ya8Rz4WrVm5yoMZPTaf7PQQisCJ58=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZD1N/IquxCHTqKPrKMdqwmmG2RqQMJkvd7LAfZtMukVn6SE6SozBWYTP2b6KNeJ+14t5vRp2DAR0ec145uLG2eOGApWxJ7yLtumYHOdgF7O8VzWDi75crpWnoR7lngOmj8A2y9qa8qveGUacLGeO8jLgB0sYHQ5q4tf6xuwmY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VmPvQ0tBkzwPcM;
	Sat, 25 May 2024 09:48:34 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id C6AE6180A9F;
	Sat, 25 May 2024 09:52:15 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 25 May 2024 09:52:15 +0800
Subject: Re: [PATCH 07/13] mm/memory-failure: remove unneeded
 hwpoison_filter() variant
To: kernel test robot <lkp@intel.com>
CC: <oe-kbuild-all@lists.linux.dev>, <nao.horiguchi@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <akpm@linux-foundation.org>,
	<tony.luck@intel.com>, <bp@alien8.de>
References: <20240524091310.1430048-8-linmiaohe@huawei.com>
 <202405242336.o1NEOrln-lkp@intel.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c7e30692-2e53-e212-dfef-f2539528a0f3@huawei.com>
Date: Sat, 25 May 2024 09:52:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202405242336.o1NEOrln-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/24 23:59, kernel test robot wrote:
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
> patch link:    https://lore.kernel.org/r/20240524091310.1430048-8-linmiaohe%40huawei.com
> patch subject: [PATCH 07/13] mm/memory-failure: remove unneeded hwpoison_filter() variant
> config: i386-randconfig-005-20240524 (https://download.01.org/0day-ci/archive/20240524/202405242336.o1NEOrln-lkp@intel.com/config)
> compiler: gcc-11 (Ubuntu 11.4.0-4ubuntu1) 11.4.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405242336.o1NEOrln-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405242336.o1NEOrln-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    ld: mm/memory-failure.o: in function `try_memory_failure_hugetlb':
>>> mm/memory-failure.c:2098:(.text+0x28a8): undefined reference to `hwpoison_filter'
>    ld: mm/memory-failure.o: in function `memory_failure':
>    mm/memory-failure.c:2321:(.text+0x2a98): undefined reference to `hwpoison_filter'
>    ld: mm/memory-failure.o: in function `soft_offline_page':
>    mm/memory-failure.c:2841:(.text+0x3217): undefined reference to `hwpoison_filter'

Thanks for building and reporting. I will fix this in next version.
Thanks.
.

