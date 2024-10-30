Return-Path: <linux-edac+bounces-2356-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EAE9B697B
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 17:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7EC9B20C42
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 16:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F501F473A;
	Wed, 30 Oct 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKq3cCm8"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E75768FC;
	Wed, 30 Oct 2024 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306788; cv=none; b=kcZK6j63SaUg9qt0KDzoBobkbmdPY8eZNoCd42djeUrVm1upWzswCPDszwiioWsM9irivgiNsa31LU1mdvc4P6jtZuDwFp4hkxNs6F5nKE2qDljiQKjwM/Ro/8zhPf+J2ZuhwgzekYsbOYJY8J9jWxIWyytY3WiD0sw4ZHbnY/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306788; c=relaxed/simple;
	bh=kkCKvFjpUCVV69H1kfwrpgpFazlpD0ZkPP3c2tJJ1tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4UeDKAM0oJw7y3Adpeo/6+dihl7iqZWjOmBoP/mLobMGzInz+7URSDtmzx6WoPkhGJymeqVrMOIpjEwp/7R7ToTe5WL4q0WIVhGAM1JqzukE4ms+L5MFOR40LdRfymeUlMjf+3jfyhxYAwdoAxNNtbRhjMEgL7ghX3jrByxbfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKq3cCm8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730306785; x=1761842785;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kkCKvFjpUCVV69H1kfwrpgpFazlpD0ZkPP3c2tJJ1tg=;
  b=aKq3cCm8Qfyofv33tOobtuPqk5YsKVORGziaV4oWSBf8dui+2O91IGaY
   ee46XxOcXqwgoRDtm26mD85D3we3JWPgJNAJwgZwCM2f62prThR3p3Yk+
   CwFSCsTh6gUPgG2i+ixnGxnuDQxxLxGl7SzKaFSMguKFdJ4wzm67zSjhi
   1s0WAvX3srLrIV1dia1uPWCpk4pz53XQHVLfq+uwNKlxNB2as4NtvsQA1
   mnvZUTc45IY0GQD5TCRDirIRtuvGRrKKdjfJ2NM7zb/9p7dHzwbj6P9Dh
   y/dNHnCzaZ8t0LuAv4ETjWu1zCIPq5GRibnu3SD7PtVFRbAZZw351Ufdx
   g==;
X-CSE-ConnectionGUID: wt/O2aquQtq96/i97ClxuQ==
X-CSE-MsgGUID: BXrcFWUASJqEFxia4Q4qZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="40592506"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="40592506"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:46:23 -0700
X-CSE-ConnectionGUID: yB+rFLQpRhmf61Ein+LMbw==
X-CSE-MsgGUID: FAVjUsqvTqeuOf+OyGtp+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="87150911"
Received: from nnlnb-sb-019.ccr.corp.intel.com (HELO [10.125.108.160]) ([10.125.108.160])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:46:17 -0700
Message-ID: <35faf0e5-9f54-44e8-ae65-ce1dc91b9cbd@intel.com>
Date: Wed, 30 Oct 2024 09:46:16 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/14] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "david@redhat.com" <david@redhat.com>,
 "Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
 "leo.duran@amd.com" <leo.duran@amd.com>,
 "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
 "rientjes@google.com" <rientjes@google.com>,
 "jiaqiyan@google.com" <jiaqiyan@google.com>,
 "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "jthoughton@google.com" <jthoughton@google.com>,
 "somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
 "erdemaktas@google.com" <erdemaktas@google.com>,
 "pgonda@google.com" <pgonda@google.com>,
 "duenwen@google.com" <duenwen@google.com>,
 "gthelen@google.com" <gthelen@google.com>,
 "wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
 "dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
 "wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
 "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)"
 <prime.zeng@hisilicon.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 "kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>
References: <20241025171356.1377-1-shiju.jose@huawei.com>
 <20241025171356.1377-8-shiju.jose@huawei.com>
 <3a007a70-136b-4a45-8dd2-d33725ea96bc@intel.com>
 <e6aed765394b4822ad5a70018c87ef1f@huawei.com>
 <67b569b0-1cd5-44e0-8465-064b41a1afd8@intel.com>
 <20241030161628.00001fdc@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241030161628.00001fdc@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/24 9:16 AM, Jonathan Cameron wrote:
> On Tue, 29 Oct 2024 11:32:47 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> On 10/29/24 10:00 AM, Shiju Jose wrote:
>>>
>>>   
>>>> -----Original Message-----
>>>> From: Dave Jiang <dave.jiang@intel.com>
>>>> Sent: 29 October 2024 16:32
>>>> To: Shiju Jose <shiju.jose@huawei.com>; linux-edac@vger.kernel.org; linux-
>>>> cxl@vger.kernel.org; linux-acpi@vger.kernel.org; linux-mm@kvack.org; linux-
>>>> kernel@vger.kernel.org
>>>> Cc: bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
>>>> mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
>>>> Cameron <jonathan.cameron@huawei.com>; gregkh@linuxfoundation.org;
>>>> sudeep.holla@arm.com; jassisinghbrar@gmail.com; alison.schofield@intel.com;
>>>> vishal.l.verma@intel.com; ira.weiny@intel.com; david@redhat.com;
>>>> Vilas.Sridharan@amd.com; leo.duran@amd.com; Yazen.Ghannam@amd.com;
>>>> rientjes@google.com; jiaqiyan@google.com; Jon.Grimm@amd.com;
>>>> dave.hansen@linux.intel.com; naoya.horiguchi@nec.com;
>>>> james.morse@arm.com; jthoughton@google.com; somasundaram.a@hpe.com;
>>>> erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>>>> gthelen@google.com; wschwartz@amperecomputing.com;
>>>> dferguson@amperecomputing.com; wbs@os.amperecomputing.com;
>>>> nifan.cxl@gmail.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
>>>> <prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
>>>> kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>>>> Linuxarm <linuxarm@huawei.com>
>>>> Subject: Re: [PATCH v14 07/14] cxl/memfeature: Add CXL memory device patrol
>>>> scrub control feature
>>>>
>>>>
>>>>
>>>> On 10/25/24 10:13 AM, shiju.jose@huawei.com wrote:  
>>>>> From: Shiju Jose <shiju.jose@huawei.com>
>>>>>
>>>>> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub
>>>>> control feature. The device patrol scrub proactively locates and makes
>>>>> corrections to errors in regular cycle.
>>>>>
>>>>> Allow specifying the number of hours within which the patrol scrub
>>>>> must be completed, subject to minimum and maximum limits reported by the  
>>>> device.  
>>>>> Also allow disabling scrub allowing trade-off error rates against
>>>>> performance.
>>>>>
>>>>> Add support for patrol scrub control on CXL memory devices.
>>>>> Register with the EDAC device driver, which retrieves the scrub
>>>>> attribute descriptors from EDAC scrub and exposes the sysfs scrub
>>>>> control attributes to userspace. For example, scrub control for the
>>>>> CXL memory device "cxl_mem0" is exposed in  
>>>> /sys/bus/edac/devices/cxl_mem0/scrubX/.  
>>>>>
>>>>> Additionally, add support for region-based CXL memory patrol scrub control.
>>>>> CXL memory regions may be interleaved across one or more CXL memory
>>>>> devices. For example, region-based scrub control for "cxl_region1" is
>>>>> exposed in /sys/bus/edac/devices/cxl_region1/scrubX/.
>>>>>
>>>>> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>>>>> ---
>>>>>  Documentation/edac/edac-scrub.rst |  74 ++++++
>>>>>  drivers/cxl/Kconfig               |  18 ++
>>>>>  drivers/cxl/core/Makefile         |   1 +
>>>>>  drivers/cxl/core/memfeature.c     | 381 ++++++++++++++++++++++++++++++
>>>>>  drivers/cxl/core/region.c         |   6 +
>>>>>  drivers/cxl/cxlmem.h              |   7 +
>>>>>  drivers/cxl/mem.c                 |   4 +
>>>>>  7 files changed, 491 insertions(+)
>>>>>  create mode 100644 Documentation/edac/edac-scrub.rst  create mode
>>>>> 100644 drivers/cxl/core/memfeature.c
>>>>>
>>>>> diff --git a/Documentation/edac/edac-scrub.rst
>>>>> b/Documentation/edac/edac-scrub.rst
>>>>> new file mode 100644
>>>>> index 000000000000..4aad4974b208
>>>>> --- /dev/null
>>>>> +++ b/Documentation/edac/edac-scrub.rst
>>>>> @@ -0,0 +1,74 @@
>>>>> +.. SPDX-License-Identifier: GPL-2.0
>>>>> +  
>>> [...]
>>>   
>>>>> +static int cxl_mem_ps_get_attrs(struct cxl_memdev_state *mds,
>>>>> +				struct cxl_memdev_ps_params *params) {
>>>>> +	size_t rd_data_size = sizeof(struct cxl_memdev_ps_rd_attrs);
>>>>> +	size_t data_size;
>>>>> +	struct cxl_memdev_ps_rd_attrs *rd_attrs __free(kfree) =
>>>>> +						kmalloc(rd_data_size,  
>>>> GFP_KERNEL);  
>>>>> +	if (!rd_attrs)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	data_size = cxl_get_feature(mds, cxl_patrol_scrub_uuid,
>>>>> +				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
>>>>> +				    rd_attrs, rd_data_size);
>>>>> +	if (!data_size)
>>>>> +		return -EIO;
>>>>> +
>>>>> +	params->scrub_cycle_changeable =  
>>>> FIELD_GET(CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK,  
>>>>> +						   rd_attrs->scrub_cycle_cap);
>>>>> +	params->enable =  
>>>> FIELD_GET(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,  
>>>>> +				   rd_attrs->scrub_flags);
>>>>> +	params->scrub_cycle_hrs =  
>>>> FIELD_GET(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,  
>>>>> +					    rd_attrs->scrub_cycle_hrs);
>>>>> +	params->min_scrub_cycle_hrs =  
>>>> FIELD_GET(CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK,  
>>>>> +						rd_attrs->scrub_cycle_hrs);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int cxl_ps_get_attrs(struct device *dev, void *drv_data,  
>>>>
>>>> Would a union be better than a void *drv_data for all the places this is used as a
>>>> parameter? How many variations of this are there?
>>>>
>>>> DJ  
>>> Hi Dave,
>>>
>>> Can you give more info on this given this is a generic callback for the scrub control and each
>>> implementation will have its own context struct (for eg. struct cxl_patrol_scrub_context here
>>> for CXL scrub control), which in turn will be passed in and out as opaque data.  
>>
>> Mainly I'm just seeing a lot of calls with (void *). Just asking if we want to make it a union that contains 'struct cxl_patrol_scrub_context' and etc.
> 
> You could but then every new driver would need to include
> changes in the edac core to add it's own entry to that union.
> 
> Not sure that's a good way to go for opaque driver specific context.
> 
> This particular function though can use
> a struct cxl_patrol_scrub_context * anyway as it's not part of the
> core interface, but rather one called only indirectly
> by functions that are passed a void * but know it is a
> struct clx_patrol_scrub_context *.

Thanks Jonathan. That's basically what I wanted to know. 

> 
> Jonathan
> 
> 
>>
>>>
>>> Thanks,
>>> Shiju  
>>>>  
>>>>> +			    struct cxl_memdev_ps_params *params) {
>>>>> +	struct cxl_patrol_scrub_context *cxl_ps_ctx = drv_data;
>>>>> +	struct cxl_memdev *cxlmd;
>>>>> +	struct cxl_dev_state *cxlds;
>>>>> +	struct cxl_memdev_state *mds;
>>>>> +	u16 min_scrub_cycle = 0;
>>>>> +	int i, ret;
>>>>> +
>>>>> +	if (cxl_ps_ctx->cxlr) {
>>>>> +		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
>>>>> +		struct cxl_region_params *p = &cxlr->params;
>>>>> +
>>>>> +		for (i = p->interleave_ways - 1; i >= 0; i--) {
>>>>> +			struct cxl_endpoint_decoder *cxled = p->targets[i];
>>>>> +
>>>>> +			cxlmd = cxled_to_memdev(cxled);
>>>>> +			cxlds = cxlmd->cxlds;
>>>>> +			mds = to_cxl_memdev_state(cxlds);
>>>>> +			ret = cxl_mem_ps_get_attrs(mds, params);
>>>>> +			if (ret)
>>>>> +				return ret;
>>>>> +
>>>>> +			if (params->min_scrub_cycle_hrs > min_scrub_cycle)
>>>>> +				min_scrub_cycle = params-
>>>>> min_scrub_cycle_hrs;
>>>>> +		}
>>>>> +		params->min_scrub_cycle_hrs = min_scrub_cycle;
>>>>> +		return 0;
>>>>> +	}
>>>>> +	cxlmd = cxl_ps_ctx->cxlmd;
>>>>> +	cxlds = cxlmd->cxlds;
>>>>> +	mds = to_cxl_memdev_state(cxlds);
>>>>> +
>>>>> +	return cxl_mem_ps_get_attrs(mds, params); }
>>>>> +  
>>> [...]  
>>>>  
>>>   
>>
>>
> 
> 


