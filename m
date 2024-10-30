Return-Path: <linux-edac+bounces-2353-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AA29B68F9
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 17:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C592824F2
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B713213EF3;
	Wed, 30 Oct 2024 16:16:38 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C11E47AE;
	Wed, 30 Oct 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304998; cv=none; b=ivuCpF0zXE2itxmaBbJ9MDOqPxg8dPE1xroaX4qLFxvMW29yhMHxdkIr7A1sTl73eS+gnh0fA0+Cf3aUF9/Z9M9gRWP1HrmwQmm77HYPm0Lkxv+9mpgGDQya3cPJlQ9jn9Pw4nQ63+Qs6/S2heAL+Hryx9456MdnRTvKqe1Ch+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304998; c=relaxed/simple;
	bh=aqDYmaw+KNVR5HjU71s9yAZRVNg3X5jMvykPat0LzI4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9dnEJ+ATAIFoMHwDLnnxKf5//+qK/iCv6bh3AzgAOnvSeOovOj/K6Xe+emyZspshzBpGzAR7W/c7tBPtSMkltfvL3JKqePawpbjZCZNoj7MlriJI6aZ22Hsn7izDZkracj9oIZ4IMLDzjqtoEpa4CuHa69L3D/Dp/WyiSR2UIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdsdB5CCXz6K6Gy;
	Thu, 31 Oct 2024 00:14:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 36F341400D3;
	Thu, 31 Oct 2024 00:16:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 17:16:30 +0100
Date: Wed, 30 Oct 2024 16:16:28 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Shiju Jose <shiju.jose@huawei.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v14 07/14] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Message-ID: <20241030161628.00001fdc@Huawei.com>
In-Reply-To: <67b569b0-1cd5-44e0-8465-064b41a1afd8@intel.com>
References: <20241025171356.1377-1-shiju.jose@huawei.com>
	<20241025171356.1377-8-shiju.jose@huawei.com>
	<3a007a70-136b-4a45-8dd2-d33725ea96bc@intel.com>
	<e6aed765394b4822ad5a70018c87ef1f@huawei.com>
	<67b569b0-1cd5-44e0-8465-064b41a1afd8@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Oct 2024 11:32:47 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 10/29/24 10:00 AM, Shiju Jose wrote:
> > 
> >   
> >> -----Original Message-----
> >> From: Dave Jiang <dave.jiang@intel.com>
> >> Sent: 29 October 2024 16:32
> >> To: Shiju Jose <shiju.jose@huawei.com>; linux-edac@vger.kernel.org; linux-
> >> cxl@vger.kernel.org; linux-acpi@vger.kernel.org; linux-mm@kvack.org; linux-
> >> kernel@vger.kernel.org
> >> Cc: bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
> >> mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
> >> Cameron <jonathan.cameron@huawei.com>; gregkh@linuxfoundation.org;
> >> sudeep.holla@arm.com; jassisinghbrar@gmail.com; alison.schofield@intel.com;
> >> vishal.l.verma@intel.com; ira.weiny@intel.com; david@redhat.com;
> >> Vilas.Sridharan@amd.com; leo.duran@amd.com; Yazen.Ghannam@amd.com;
> >> rientjes@google.com; jiaqiyan@google.com; Jon.Grimm@amd.com;
> >> dave.hansen@linux.intel.com; naoya.horiguchi@nec.com;
> >> james.morse@arm.com; jthoughton@google.com; somasundaram.a@hpe.com;
> >> erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
> >> gthelen@google.com; wschwartz@amperecomputing.com;
> >> dferguson@amperecomputing.com; wbs@os.amperecomputing.com;
> >> nifan.cxl@gmail.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
> >> <prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
> >> kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
> >> Linuxarm <linuxarm@huawei.com>
> >> Subject: Re: [PATCH v14 07/14] cxl/memfeature: Add CXL memory device patrol
> >> scrub control feature
> >>
> >>
> >>
> >> On 10/25/24 10:13 AM, shiju.jose@huawei.com wrote:  
> >>> From: Shiju Jose <shiju.jose@huawei.com>
> >>>
> >>> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub
> >>> control feature. The device patrol scrub proactively locates and makes
> >>> corrections to errors in regular cycle.
> >>>
> >>> Allow specifying the number of hours within which the patrol scrub
> >>> must be completed, subject to minimum and maximum limits reported by the  
> >> device.  
> >>> Also allow disabling scrub allowing trade-off error rates against
> >>> performance.
> >>>
> >>> Add support for patrol scrub control on CXL memory devices.
> >>> Register with the EDAC device driver, which retrieves the scrub
> >>> attribute descriptors from EDAC scrub and exposes the sysfs scrub
> >>> control attributes to userspace. For example, scrub control for the
> >>> CXL memory device "cxl_mem0" is exposed in  
> >> /sys/bus/edac/devices/cxl_mem0/scrubX/.  
> >>>
> >>> Additionally, add support for region-based CXL memory patrol scrub control.
> >>> CXL memory regions may be interleaved across one or more CXL memory
> >>> devices. For example, region-based scrub control for "cxl_region1" is
> >>> exposed in /sys/bus/edac/devices/cxl_region1/scrubX/.
> >>>
> >>> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> >>> ---
> >>>  Documentation/edac/edac-scrub.rst |  74 ++++++
> >>>  drivers/cxl/Kconfig               |  18 ++
> >>>  drivers/cxl/core/Makefile         |   1 +
> >>>  drivers/cxl/core/memfeature.c     | 381 ++++++++++++++++++++++++++++++
> >>>  drivers/cxl/core/region.c         |   6 +
> >>>  drivers/cxl/cxlmem.h              |   7 +
> >>>  drivers/cxl/mem.c                 |   4 +
> >>>  7 files changed, 491 insertions(+)
> >>>  create mode 100644 Documentation/edac/edac-scrub.rst  create mode
> >>> 100644 drivers/cxl/core/memfeature.c
> >>>
> >>> diff --git a/Documentation/edac/edac-scrub.rst
> >>> b/Documentation/edac/edac-scrub.rst
> >>> new file mode 100644
> >>> index 000000000000..4aad4974b208
> >>> --- /dev/null
> >>> +++ b/Documentation/edac/edac-scrub.rst
> >>> @@ -0,0 +1,74 @@
> >>> +.. SPDX-License-Identifier: GPL-2.0
> >>> +  
> > [...]
> >   
> >>> +static int cxl_mem_ps_get_attrs(struct cxl_memdev_state *mds,
> >>> +				struct cxl_memdev_ps_params *params) {
> >>> +	size_t rd_data_size = sizeof(struct cxl_memdev_ps_rd_attrs);
> >>> +	size_t data_size;
> >>> +	struct cxl_memdev_ps_rd_attrs *rd_attrs __free(kfree) =
> >>> +						kmalloc(rd_data_size,  
> >> GFP_KERNEL);  
> >>> +	if (!rd_attrs)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	data_size = cxl_get_feature(mds, cxl_patrol_scrub_uuid,
> >>> +				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
> >>> +				    rd_attrs, rd_data_size);
> >>> +	if (!data_size)
> >>> +		return -EIO;
> >>> +
> >>> +	params->scrub_cycle_changeable =  
> >> FIELD_GET(CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK,  
> >>> +						   rd_attrs->scrub_cycle_cap);
> >>> +	params->enable =  
> >> FIELD_GET(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,  
> >>> +				   rd_attrs->scrub_flags);
> >>> +	params->scrub_cycle_hrs =  
> >> FIELD_GET(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,  
> >>> +					    rd_attrs->scrub_cycle_hrs);
> >>> +	params->min_scrub_cycle_hrs =  
> >> FIELD_GET(CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK,  
> >>> +						rd_attrs->scrub_cycle_hrs);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int cxl_ps_get_attrs(struct device *dev, void *drv_data,  
> >>
> >> Would a union be better than a void *drv_data for all the places this is used as a
> >> parameter? How many variations of this are there?
> >>
> >> DJ  
> > Hi Dave,
> > 
> > Can you give more info on this given this is a generic callback for the scrub control and each
> > implementation will have its own context struct (for eg. struct cxl_patrol_scrub_context here
> > for CXL scrub control), which in turn will be passed in and out as opaque data.  
> 
> Mainly I'm just seeing a lot of calls with (void *). Just asking if we want to make it a union that contains 'struct cxl_patrol_scrub_context' and etc.

You could but then every new driver would need to include
changes in the edac core to add it's own entry to that union.

Not sure that's a good way to go for opaque driver specific context.

This particular function though can use
a struct cxl_patrol_scrub_context * anyway as it's not part of the
core interface, but rather one called only indirectly
by functions that are passed a void * but know it is a
struct clx_patrol_scrub_context *.

Jonathan


> 
> > 
> > Thanks,
> > Shiju  
> >>  
> >>> +			    struct cxl_memdev_ps_params *params) {
> >>> +	struct cxl_patrol_scrub_context *cxl_ps_ctx = drv_data;
> >>> +	struct cxl_memdev *cxlmd;
> >>> +	struct cxl_dev_state *cxlds;
> >>> +	struct cxl_memdev_state *mds;
> >>> +	u16 min_scrub_cycle = 0;
> >>> +	int i, ret;
> >>> +
> >>> +	if (cxl_ps_ctx->cxlr) {
> >>> +		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
> >>> +		struct cxl_region_params *p = &cxlr->params;
> >>> +
> >>> +		for (i = p->interleave_ways - 1; i >= 0; i--) {
> >>> +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> >>> +
> >>> +			cxlmd = cxled_to_memdev(cxled);
> >>> +			cxlds = cxlmd->cxlds;
> >>> +			mds = to_cxl_memdev_state(cxlds);
> >>> +			ret = cxl_mem_ps_get_attrs(mds, params);
> >>> +			if (ret)
> >>> +				return ret;
> >>> +
> >>> +			if (params->min_scrub_cycle_hrs > min_scrub_cycle)
> >>> +				min_scrub_cycle = params-
> >>> min_scrub_cycle_hrs;
> >>> +		}
> >>> +		params->min_scrub_cycle_hrs = min_scrub_cycle;
> >>> +		return 0;
> >>> +	}
> >>> +	cxlmd = cxl_ps_ctx->cxlmd;
> >>> +	cxlds = cxlmd->cxlds;
> >>> +	mds = to_cxl_memdev_state(cxlds);
> >>> +
> >>> +	return cxl_mem_ps_get_attrs(mds, params); }
> >>> +  
> > [...]  
> >>  
> >   
> 
> 


