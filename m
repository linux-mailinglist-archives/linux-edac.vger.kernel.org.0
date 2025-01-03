Return-Path: <linux-edac+bounces-2776-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D603CA00BAC
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2025 16:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8023A2DD0
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2025 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BAD1FA156;
	Fri,  3 Jan 2025 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="guD1xjk2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB8D1A8F9A;
	Fri,  3 Jan 2025 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735919390; cv=none; b=B6G54B08H/rN7o2e1Emr39l122PdyoVz6YU9HrJjmTa6VRu+yI7J34UUTIV/mCZRTA0RLk9OzY7aZaWeit9SbfFYS94+4iGZaG1ymewTYE0URS0vxS9VQOai715EgDtpKcDXzdkZx8wBTtTBih8x3q+svh4FBziuw9OEsNRGs/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735919390; c=relaxed/simple;
	bh=1M6cKi7PT9clm8YB/qYa2Ju4pXO80UrAsUJC1DPmJBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuAXv4MOZNFWqnrLy3gZ/wmIENvTUnBebyW0C8B2f9Hv1Qr71AjXjR2LHV18rw4z+yJ7JJZ/F6x/G3zXdlNaCD5Bmysa4sEZW1nUxQkGxnjJSoy5KI3/lpv7ux8VrjR3YzlRrXFMZ+ZiZTvtwzKM3Uxg/PYuvFqGQJv36zqubXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=guD1xjk2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735919389; x=1767455389;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1M6cKi7PT9clm8YB/qYa2Ju4pXO80UrAsUJC1DPmJBg=;
  b=guD1xjk2KyftlXM0MszssdXcdmsDsvru4t72JhrCPc53t9Sc+yQ+gLVX
   8jwzfDj49weYmnpsA3URTOBzUQFgvywQcOGkpDlPaUUMVsqs3VEFF8yNH
   2EjH+KrKEH68i3ligtiT2eF5mlpb0YeB+bqf2o3aQvinYSVfzQEZV446w
   p415m1E0IumzmrqeW65zueVVSzEYqN3NK/K21Pdw7wugl/iA6RJBgoZB7
   eLCzYLT121sj2GNyr1qsQlENJ6H1oD1kJL5B2a9ZnvtM5zMQlOdcoTzlO
   CJhQNmq7WhPk9OiOXDDdvsaSVvEDCsljfqWJgLUQCa46lU2Kyo7Y297mA
   g==;
X-CSE-ConnectionGUID: cp3sGi/vRp+iw7v7ONv+aA==
X-CSE-MsgGUID: IrFM1mOSQ++ULg7kqHsDyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="40095150"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="40095150"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 07:49:48 -0800
X-CSE-ConnectionGUID: cqjjp0lqTluA/TIGnYXdcg==
X-CSE-MsgGUID: ve/dGZInQMmW3/WppMVc+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="132739840"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.13]) ([10.125.110.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 07:49:45 -0800
Message-ID: <c89765ef-1243-445a-bc4a-db88fb5b9377@intel.com>
Date: Fri, 3 Jan 2025 08:49:44 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/18] EDAC: Scrub: introduce generic EDAC RAS control
 feature driver + CXL/ACPI-RAS2 drivers
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Borislav Petkov <bp@alien8.de>
Cc: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, rafael@kernel.org,
 lenb@kernel.org, mchehab@kernel.org, dan.j.williams@intel.com,
 dave@stgolabs.net, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
 leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
 jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
 naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
 somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
 duenwen@google.com, gthelen@google.com, wschwartz@amperecomputing.com,
 dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
 nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
 wanghuiqiang@huawei.com, linuxarm@huawei.com
References: <20241122180416.1932-1-shiju.jose@huawei.com>
 <20250103114109.GAZ3fM1dEsyBSn9lWA@fat_crate.local>
 <20250103130213.00006abd@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250103130213.00006abd@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/3/25 6:02 AM, Jonathan Cameron wrote:
> On Fri, 3 Jan 2025 12:41:45 +0100
> Borislav Petkov <bp@alien8.de> wrote:
> 
>> On Fri, Nov 22, 2024 at 06:03:57PM +0000, shiju.jose@huawei.com wrote:
>>>  drivers/edac/Makefile                         |    1 +
>>>  drivers/edac/ecs.c                            |  207 +++
>>>  drivers/edac/edac_device.c                    |  183 ++
>>>  drivers/edac/mem_repair.c                     |  492 +++++
>>>  drivers/edac/scrub.c                          |  209 +++
>>>  drivers/ras/Kconfig                           |   10 +
>>>  drivers/ras/Makefile                          |    1 +
>>>  drivers/ras/acpi_ras2.c                       |  385 ++++
>>>  include/acpi/ras2_acpi.h                      |   45 +
>>>  include/cxl/features.h                        |   48 +
>>>  include/cxl/mailbox.h                         |   45 +-
>>>  include/linux/edac.h                          |  238 +++
>>>  include/uapi/linux/cxl_mem.h                  |    3 +  
>>
>> So what's the plan here? Am I supposed to merge the EDAC/RAS bits through the
>> RAS tree and then give folks an immutable branch or how do we want to proceed
>> here?
>>
> 
> Dave Jiang / Rafael, what would work best for the two of you?
> 
> To me Boris' suggestion makes sense, particularly as that
> avoids the complexity of CXL get/set features being in multiple series.
> 
> I think the split that would make sense is:
> 
> EDAC immutable branch for:
>  1: EDAC: Add support for EDAC device features control
>  2: Add scrub control feature
>  3: EDAC: Add ECS control feature
>  15: EDAC: Add memory repair control feature
> 
> ACPI merges EDAC immutable +
>  13: ACPI:RAS2: Add ACPI RAS2 driver
>  14: ras: mem: Add memory ACPI RAS2 driver
> 
> CXL merges EDAC immutable +
>  4: cxl: Refactor user ioctl command path from mds to mailbox
>  5: cxl: Add Get Supported Features command for kernel usage 
>  6: cxl/mbox: Add GET_FEATURE mailbox command
>  7: cxl: Add Get Feature command support for user submission
>  8: cxl/mbox: Add SET_FEATURE mailbox command
>  9: cxl: Add Set Feature command support for user submission
>  10: cxl: Add UUIDs for the CXL RAS features
>  11: cxl/memfeature: Add CXL memory device patrol scrub control feature
>  12: cxl/memfeature: Add CXL memory device ECS control feature
>  16: cxl/mbox: Add support for PERFORM_MAINTENANCE mailbox command
>  17: cxl/memfeature: Add CXL memory device soft PPR control feature
>  18: cxl/memfeature: Add CXL memory device memory sparing control feature

That works for me. 

DJ

> 
> That does mean that the actual drivers/edac/ specific drivers land
> via the ACPI and CXL trees only, but without another layer of immutable branches
> we can't avoid that. Might cause merge conflicts in Kconfig/Makefiles but otherwise
> shouldn't be too bad.
> 
> There is going to be some noise in documentation as examples are added
> to the docs with the actual drivers (whereas generic docs are introduced
> with the infrastructure).  I think that will work out though.
> Shiju, could you spin this ordering up and check it all works
> (incorporating Dave's updates to the GET / SET feature)?
> > Thanks,
> 
> Jonathan


