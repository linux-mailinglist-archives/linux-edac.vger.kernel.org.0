Return-Path: <linux-edac+bounces-3997-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA182AC2B08
	for <lists+linux-edac@lfdr.de>; Fri, 23 May 2025 22:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998AF167FA8
	for <lists+linux-edac@lfdr.de>; Fri, 23 May 2025 20:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FF21EB36;
	Fri, 23 May 2025 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqCqZrN4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8D01A5BAC;
	Fri, 23 May 2025 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748032701; cv=none; b=AJRgjPbRIHfDcss8qpvyi1KiIvfzdG+XAkrYu3/bZdbwnFtGHezDlxfDyv5vnEElSmMW4R5umcQpEvjlWkU7lvUpoVDehtOdIog2GK0nq6AubVlS/qeiSmyce4zuAvW3G8FsnaCsPL/I8Yg2lXTAIeD0TbzEdAprle3bxOkbDl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748032701; c=relaxed/simple;
	bh=2eHoAb897E4Zll0VREizd3vRpfOFku8VAPjFPS4p8lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o29RNMBbbT5MTBJbBwrXDCaNg8/nfYDKN+bFslgv1CToWcWy6wTo3Tz4XqMnUm41DksyG1u+zBoKLhTWfePfs7hqUrB5AuBJvo4mgEWEmdhvYN//zSvT6XW+0ZybtzIcQlxNaKVUBRX3cfUaNLjlfsPxF9LBQP5DWKK8yetlW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqCqZrN4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748032699; x=1779568699;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2eHoAb897E4Zll0VREizd3vRpfOFku8VAPjFPS4p8lE=;
  b=eqCqZrN47U9NzwHKQmDGzpkncYY8BpZNR6uGBzrV9K2mxg+o5tYab/OE
   YyZpEHvRE8cIqeYrk3JbAoawiqsdgbBuZbxQfaAF3XYAAl0zZD6qdblmT
   qHETVjnz+uXuZS7Qe5rDHXMuZZqvKA/Oo1bHZpiwPci7K8ipXjYp47ngw
   RzwvAXHmZvsiI56tzRfoal6rtqfewtuKPQWPpKDLO7vqUGz3Sryoup7aq
   OfZHKHlIeqzy4bzwmxYR32vSE4Y4FDpre/P0JBDYNCmw0VA6SDyCWe1Vd
   7N3mrz6P/qvIwN/+EdqkRfnQbZ902CpeB6jRn3RsErx7nvc/rEScUoJkp
   w==;
X-CSE-ConnectionGUID: tG6vLdxhQz+rPr38JRSqhQ==
X-CSE-MsgGUID: e8uQoKAISLuO18EUMLBTSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49979091"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="49979091"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 13:38:18 -0700
X-CSE-ConnectionGUID: n1qtln1OQsaDOPUTIfIE9Q==
X-CSE-MsgGUID: JLd2Q99zST6ZU0os1CXd5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141178387"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.109.152]) ([10.125.109.152])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 13:38:17 -0700
Message-ID: <0ece175b-ee76-4814-a591-7a75cac321ea@intel.com>
Date: Fri, 23 May 2025 13:38:13 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] cxl: support CXL memory RAS features
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, jonathan.cameron@huawei.com, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, bp@alien8.de,
 tony.luck@intel.com, lenb@kernel.org, Yazen.Ghannam@amd.com,
 mchehab@kernel.org, nifan.cxl@gmail.com, linuxarm@huawei.com,
 tanxiaofei@huawei.com, prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
References: <20250521124749.817-1-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250521124749.817-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/21/25 5:47 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Support for CXL memory EDAC features: patrol scrub, ECS, soft-PPR and
> memory sparing.
> 
> Detailed history of the complete EDAC series with CXL EDAC patches
> up to V20 [1] and this CXL specific series had separated from V20 of
> the above series.
> 
> The series is based on [2] v6.15-rc4 (based on comment from Dave
> in the thread [4]).
> 
> Also applied(no conflicts) and tested on cxl.git [3] branch: next
> 
> 1. https://lore.kernel.org/linux-cxl/20250212143654.1893-1-shiju.jose@huawei.com/
> 2. https://github.com/torvalds/linux.git
> 3. https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
> 4. https://lore.kernel.org/all/d83a83d1-37e7-4192-913f-243098f679e3@intel.com/
> 
> Userspace code for CXL memory repair features [5] and
> sample boot-script for CXL memory repair [6].
> 
> [5]: https://lore.kernel.org/lkml/20250207143028.1865-1-shiju.jose@huawei.com/
> [6]: https://lore.kernel.org/lkml/20250207143028.1865-5-shiju.jose@huawei.com/

Applied to cxl/next

> 
> Changes
> =======
> v5 -> v6:
> 1. Fixed feedback from Randy Dunlap on CXL EDAC documentation.
> 
> 2. Feedback from Alison:
>   - Replace #ifdef using IS_ENABLED() in the series
>   - Fix for the kfree() oops in devm_cxl_memdev_edac_release()
>     while unloading cxl-test module. 
>   - Added separate helper functions for scrub set attributes for
>     dev scrub and region scrub.
>   - renaming to scrub_cycle and scrub_region_id.
>       
> 3. Feedback from Dave:
>   - Fix for the kfree() oops in devm_cxl_memdev_edac_release()
>     while unloading cxl-test module.
>   - Add cxl_test inclusion of edac.o
>   - Check return from cxl_feature_info() with IS_ERR in the series. 
>  
> 4. Rebased to linux.git [2] v6.15-rc4 (based on comment from Dave
> in the thread [4]).
>    
> v4 -> v5:
> 1. Fixed a compilation warning introduced by v3->v4, reported by Dave Jiang on v4. 
>    drivers/cxl/core/edac.c: In function ‘cxl_mem_perform_sparing’:
>    drivers/cxl/core/edac.c:1335:29: warning: the comparison will always evaluate as ‘true’ for the address of ‘validity_flags’ will never be NULL [-Waddress]
>  1335 |                         if (!rec->media_hdr.validity_flags)
>       |                             ^
>    In file included from ./drivers/cxl/cxlmem.h:10,
>                  from drivers/cxl/core/edac.c:21:
>    ./include/cxl/event.h:35:12: note: ‘validity_flags’ declared here
>    35 |         u8 validity_flags[2];
>       |            ^~~~~~~~~~~~~~
> 2. Updated patches for tags given.
> 
> v3 -> v4:
> 1. Feedback from Dave Jiang on v3,
> 1.1. Changes for comments in EDAC scrub documentation for CXL use cases.
>      https://lore.kernel.org/all/2df68c68-f1a8-4327-abc9-d265326c133d@intel.com/
> 1.2. Changes for comments in CXL memory sparing control feature.
>      https://lore.kernel.org/all/4ee3323c-fb27-4fbe-b032-78fd54bc21a0@intel.com/
>       
> v2 -> v3:
> 1. Feedback from Dan Williams on v2,
>    https://lore.kernel.org/linux-mm/20250320180450.539-1-shiju.jose@huawei.com/
>   - Modified get_support_feature_info() in fwctl series generic to use in
>     cxl/fxctl and cxl/edac and replace cxl_get_feature_entry() in the CXL edac
>     series.
>   - Add usecase note for CXL ECS in Documentation/edac/scrub.rst.
>   - Add info message when device scrub rate set by a region overwritten with a
>     local device scrub rate or another region's scrub rate.
>   - Replace 'ps' with patrol_scrub in the patrol scrub feature.
>   - Replaced usage of intermediate objects struct cxl_memdev_ps_params and
>     enum cxl_scrub_param etc for patrol scrub and did same for ECS.
>   - Rename CXL_MEMDEV_PS_* macros.
>   - Rename scrub_cycle_hrs-> scrub_cycle_hours
>   - Add if (!cxl_dev_name)
> 	return -ENOMEM;  to devm_cxl_memdev_edac_register()
>   - Add  devm_cxl_region_edac_register(cxlr) for CXL_PARTMODE_PMEM case.
>   - Add separate configurations for CXL scrub, ECS and memory repair
>     CXL_EDAC_SCRUB, CXL_EDAC_ECS and CXL_EDAC_MEM_REPAIR.
>   - Add 
>        if (!capable(CAP_SYS_RAWIO))
>              return -EPERM; for set attributes callbacks for CXL scrub, ECS and
>     memory repair.  	       
>   - In patch "cxl/mbox: Add support for PERFORM_MAINTENANCE mailbox command"
>     * cxl_do_maintenance() -> cxl_perform_maintenance() and moved to cxl/core/edac.c 
>     * kmalloc() -> kvzalloc()
>   - In patch, "cxl: Support for finding memory operation attributes from the current boot"  
>     * Moved code from drivers/cxl/core/ras.c to drivers/cxl/core/edac.c
>     * Add few logics to releasing the cache to give safety with respect to error storms and burning
>     * unlimited memory. 
>     * Add estimated memory overhead expense of this feature documented in the Kconfig.
>     * Unified various names such as attr, param, attrbs throughout the patches.
>     * Moved > struct xarray rec_gen_media and struct xarray rec_dram; out of struct cxl_memdev
>       to CXL edac object, but there is required a pointer to this object in struct cxl_memdev
>       because the error records are reported and thus stored in the cxl_memdev context not
>       in the CXL EDAC context.
>       
> 2. Feedback from Borislav on v2,
>   - In include/linux/edac.h 
>     Replace EDAC_PPR -> EDAC_REPAIR_PPR
>             EDAC_CACHELINE_SPARING -> EDAC_REPAIR_CACHELINE_SPARING etc.
> 
> v1 -> v2:
> 1. Feedback from Dan Williams on v1,
>    https://lore.kernel.org/linux-mm/20250307091137.00006a0a@huawei.com/T/
>   - Fixed lock issues in region scrubbing, added local cxl_acquire()
>     and cxl_unlock.
>   - Replaced CXL examples using cat and echo from EDAC .rst docs
>     with short description and ref to ABI docs. Also corrections
>     in existing descriptions as suggested by Dan.
>   - Add policy description for the scrub control feature.
>     However this may require inputs from CXL experts.
>   - Replaced CONFIG_CXL_RAS_FEATURES with CONFIG_CXL_EDAC_MEM_FEATURES.
>   - Few changes to depends part of CONFIG_CXL_EDAC_MEM_FEATURES.
>   - Rename drivers/cxl/core/memfeatures.c as drivers/cxl/core/edac.c
>   - snprintf() -> kasprintf() in few places.
> 
> 2. Feedback from Alison on v1,
>   - In cxl_get_feature_entry()(patch 1), return NULL on failures and
>     reintroduced checks in cxl_get_feature_entry().
>   - Changed logic in for loop in region based scrubbing code.
>   - Replace cxl_are_decoders_committed() to cxl_is_memdev_memory_online()
>     and add as a local function to drivers/cxl/core/edac.c
>   - Changed few multiline comments to single line comments.
>   - Removed unnecessary comments from the code.
>   - Reduced line length of few macros in ECS and memory repair code.
>   - In new files, changed "GPL-2.0-or-later" -> "GPL-2.0-only".
>   - Ran clang-format for new files and updated.                                                                                                                                          
> 3. Changes for feedbacks from Jonathan on v1.
>   - Changed few multiline comments to single line comments.
> 
> Shiju Jose (8):
>   EDAC: Update documentation for the CXL memory patrol scrub control
>     feature
>   cxl: Update prototype of function get_support_feature_info()
>   cxl/edac: Add CXL memory device patrol scrub control feature
>   cxl/edac: Add CXL memory device ECS control feature
>   cxl/edac: Add support for PERFORM_MAINTENANCE command
>   cxl/edac: Support for finding memory operation attributes from the
>     current boot
>   cxl/edac: Add CXL memory device memory sparing control feature
>   cxl/edac: Add CXL memory device soft PPR control feature
> 
>  Documentation/edac/memory_repair.rst |   31 +
>  Documentation/edac/scrub.rst         |   76 +
>  drivers/cxl/Kconfig                  |   71 +
>  drivers/cxl/core/Makefile            |    1 +
>  drivers/cxl/core/core.h              |    2 +
>  drivers/cxl/core/edac.c              | 2103 ++++++++++++++++++++++++++
>  drivers/cxl/core/features.c          |   17 +-
>  drivers/cxl/core/mbox.c              |   11 +-
>  drivers/cxl/core/memdev.c            |    1 +
>  drivers/cxl/core/region.c            |   10 +
>  drivers/cxl/cxl.h                    |   10 +
>  drivers/cxl/cxlmem.h                 |   30 +
>  drivers/cxl/mem.c                    |    4 +
>  drivers/edac/mem_repair.c            |    9 +
>  include/linux/edac.h                 |    7 +
>  tools/testing/cxl/Kbuild             |    1 +
>  16 files changed, 2372 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/cxl/core/edac.c
> 


