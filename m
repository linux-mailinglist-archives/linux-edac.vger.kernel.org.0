Return-Path: <linux-edac+bounces-1237-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324928FFA34
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 05:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5F31C2233B
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 03:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAC017543;
	Fri,  7 Jun 2024 03:31:01 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0473FEC;
	Fri,  7 Jun 2024 03:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717731061; cv=none; b=miEsj930AdT2jxEsF9hq2BY21P9XQ1eMHeJsGPrN0kUVnNLEVEX2VeSsNhrzIZMg5nN3uxskSF4ScjrXXu3YFeKi/pXnlJyMZs33UFzPC1tlP+pPwpWyVNmtywCqB11GaTr7fp8Tduh62+KEu6YuguUkz3t61dhlrr72oPQ2qOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717731061; c=relaxed/simple;
	bh=tugW9+yQGskgfXwfNypExPWJOWx9+Wo0NHs0myos7EA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VsboZON1L3G+YJWY1HMpYzzjyZ/sdaqsOeDMMpkAesTjpT4AMLtWcc9i5yhCgwi/I2/A7vrrBc+5bptyuWQc8/iCcVEu6U+25hZZsnp4+br7llWnE47VABEMh4vvSsM756Gg2wstGfPDIde5KOB14eYO4wFQPO9BUP5Uy8JApKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwRSw4b8YzwS2w;
	Fri,  7 Jun 2024 11:26:56 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 82ADA14022D;
	Fri,  7 Jun 2024 11:30:55 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 11:30:54 +0800
Subject: Re: [PATCH v2 07/13] mm/memory-failure: simplify unneeded
 hwpoison_filter() variant
To: kernel test robot <lkp@intel.com>
CC: <oe-kbuild-all@lists.linux.dev>, <nao.horiguchi@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <akpm@linux-foundation.org>,
	<tony.luck@intel.com>, <bp@alien8.de>
References: <20240606063247.712575-8-linmiaohe@huawei.com>
 <202406070136.hGQwVbsv-lkp@intel.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <81c78eb3-dd2f-2a23-3c08-359165c1404d@huawei.com>
Date: Fri, 7 Jun 2024 11:30:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202406070136.hGQwVbsv-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/6/7 1:15, kernel test robot wrote:
> Hi Miaohe,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 19b8422c5bd56fb5e7085995801c6543a98bda1f]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Miaohe-Lin/mm-memory-failure-simplify-put_ref_page/20240606-143939
> base:   19b8422c5bd56fb5e7085995801c6543a98bda1f
> patch link:    https://lore.kernel.org/r/20240606063247.712575-8-linmiaohe%40huawei.com
> patch subject: [PATCH v2 07/13] mm/memory-failure: simplify unneeded hwpoison_filter() variant
> config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240607/202406070136.hGQwVbsv-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406070136.hGQwVbsv-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406070136.hGQwVbsv-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> mm/memory-failure.c:299:19: error: static declaration of 'hwpoison_filter' follows non-static declaration
>      299 | static inline int hwpoison_filter(struct page *p)
>          |                   ^~~~~~~~~~~~~~~
>    In file included from mm/memory-failure.c:64:
>    mm/internal.h:1072:12: note: previous declaration of 'hwpoison_filter' with type 'int(struct page *)'
>     1072 | extern int hwpoison_filter(struct page *p);
>          |            ^~~~~~~~~~~~~~~
> 

Thanks for reporting again. Will fix it.
Thanks.
.

