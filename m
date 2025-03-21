Return-Path: <linux-edac+bounces-3394-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156D7A6B578
	for <lists+linux-edac@lfdr.de>; Fri, 21 Mar 2025 08:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C92C170CFC
	for <lists+linux-edac@lfdr.de>; Fri, 21 Mar 2025 07:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597AE1EB5FC;
	Fri, 21 Mar 2025 07:50:07 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFA726ACB;
	Fri, 21 Mar 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742543407; cv=none; b=uPtQJxg/sw6WTilRssFVW3iHVsE1WkJxYmLPHrNRZUt7fD70fZ11ey7DUR9fdK/RudHo6NXQGNbMYMOEVY/G5JeMS43p/Ui1i0BEPIeWbM4LjeDVxIEJsN52CJUOyOSAFtXsHs77/610h1HUA6t2vDLQeicZi4exrofWeUU9c2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742543407; c=relaxed/simple;
	bh=6hI6HTb0SjrdNqP1YFqTh6hXn9ZSUNy1APKZfKSSCjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBoC8pIpZswCPs8stqF06r3JQHt9gNBxu8fQwARvxEqIt5EGQ90G8XiG8/zUzl2uubNRmb/kmrgw0eMUQtii6QJ7SjfSb16dZpZTJm8TsiO3fwnF/lY4O3BBFnPrVUX+ze1ciM1dGFHkvtDFdq7A1ZR5aVF7MX7s1ngVaB3ZYbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZJvVF4Pn7z9sRy;
	Fri, 21 Mar 2025 08:39:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F-EBTBk1L9WD; Fri, 21 Mar 2025 08:39:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZJvVF2zQJz9sRs;
	Fri, 21 Mar 2025 08:39:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 427FB8B79C;
	Fri, 21 Mar 2025 08:39:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 6L_KAMM1K10W; Fri, 21 Mar 2025 08:39:49 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 491FB8B763;
	Fri, 21 Mar 2025 08:39:47 +0100 (CET)
Message-ID: <eff21b9b-0b03-4dbc-aa0a-7d3771df9082@csgroup.eu>
Date: Fri, 21 Mar 2025 08:39:46 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] cxl: support CXL memory RAS features
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com
Cc: linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bp@alien8.de,
 tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
 leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
 jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
 naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
 somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
 duenwen@google.com, gthelen@google.com, wschwartz@amperecomputing.com,
 dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
 nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
 wanghuiqiang@huawei.com, linuxarm@huawei.com
References: <20250320180450.539-1-shiju.jose@huawei.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250320180450.539-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 20/03/2025 à 19:04, shiju.jose@huawei.com a écrit :
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Support for CXL memory RAS features: patrol scrub, ECS, soft-PPR and
> memory sparing.
> 
> This CXL series was part of the EDAC series [1].
> 
> The code is based on cxl.git next branch [2] merged with ras.git edac-cxl
> branch [3].
> 
> 1. https://lore.kernel.org/linux-cxl/20250212143654.1893-1-shiju.jose@huawei.com/
> 2. https://web.git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=next
> 3. https://web.git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-cxl
> 
> Userspace code for CXL memory repair features [4] and
> sample boot-script for CXL memory repair [5].
> 
> [4]: https://lore.kernel.org/lkml/20250207143028.1865-1-shiju.jose@huawei.com/
> [5]: https://lore.kernel.org/lkml/20250207143028.1865-5-shiju.jose@huawei.com/

The title for the series is quite confusing, CXL seems to be something 
else. There is a series here [1] that removes CXL driver, but after 
looking it seems to be something completely different.

[1] https://lore.kernel.org/all/20250219070007.177725-1-ajd@linux.ibm.com/

Christophe


> 
> Changes
> =======
> v1 -> v2:
> 1. Feedbacks from Dan Williams on v1,
>     https://lore.kernel.org/linux-mm/20250307091137.00006a0a@huawei.com/T/
>    - Fixed lock issues in region scrubbing, added local cxl_acquire()
>      and cxl_unlock.
>    - Replaced CXL examples using cat and echo from EDAC .rst docs
>      with short description and ref to ABI docs. Also corrections
>      in existing descriptions as suggested by Dan.
>    - Add policy description for the scrub control feature.
>      However this may require inputs from CXL experts.
>    - Replaced CONFIG_CXL_RAS_FEATURES with CONFIG_CXL_EDAC_MEM_FEATURES.
>    - Few changes to depends part of CONFIG_CXL_EDAC_MEM_FEATURES.
>    - Rename drivers/cxl/core/memfeatures.c as drivers/cxl/core/edac.c
>    - snprintf() -> kasprintf() in few places.
>    
> 2. Feedbacks from Alison on v1,
>    - In cxl_get_feature_entry()(patch 1), return NULL on failures and
>      reintroduced checks in cxl_get_feature_entry().
>    - Changed logic in for loop in region based scrubbing code.
>    - Replace cxl_are_decoders_committed() to cxl_is_memdev_memory_online()
>      and add as a local function to drivers/cxl/core/edac.c
>    - Changed few multiline comments to single line comments.
>    - Removed unnecessary comments from the code.
>    - Reduced line length of few macros in ECS and memory repair code.
>    - In new files, changed "GPL-2.0-or-later" -> "GPL-2.0-only".
>    - Ran clang-format for new files and updated.
> 3. Changes for feedbacks from Jonathan on v1.
>    - Changed few multiline comments to single line comments.
> 
> Shiju Jose (8):
>    cxl: Add helper function to retrieve a feature entry
>    EDAC: Update documentation for the CXL memory patrol scrub control
>      feature
>    cxl/edac: Add CXL memory device patrol scrub control feature
>    cxl/edac: Add CXL memory device ECS control feature
>    cxl/mbox: Add support for PERFORM_MAINTENANCE mailbox command
>    cxl: Support for finding memory operation attributes from the current
>      boot
>    cxl/memfeature: Add CXL memory device soft PPR control feature
>    cxl/memfeature: Add CXL memory device memory sparing control feature
> 
>   Documentation/edac/memory_repair.rst |   31 +
>   Documentation/edac/scrub.rst         |   47 +
>   drivers/cxl/Kconfig                  |   27 +
>   drivers/cxl/core/Makefile            |    1 +
>   drivers/cxl/core/core.h              |    2 +
>   drivers/cxl/core/edac.c              | 1730 ++++++++++++++++++++++++++
>   drivers/cxl/core/features.c          |   23 +
>   drivers/cxl/core/mbox.c              |   45 +-
>   drivers/cxl/core/memdev.c            |    9 +
>   drivers/cxl/core/ras.c               |  145 +++
>   drivers/cxl/core/region.c            |    5 +
>   drivers/cxl/cxlmem.h                 |   73 ++
>   drivers/cxl/mem.c                    |    4 +
>   drivers/cxl/pci.c                    |    3 +
>   drivers/edac/mem_repair.c            |    9 +
>   include/linux/edac.h                 |    7 +
>   16 files changed, 2159 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/cxl/core/edac.c
> 


