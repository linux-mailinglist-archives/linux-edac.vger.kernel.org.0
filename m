Return-Path: <linux-edac+bounces-2920-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41764A1236F
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 13:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80077A4261
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 12:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43532475E4;
	Wed, 15 Jan 2025 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrl9KSqc"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F552475C9;
	Wed, 15 Jan 2025 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736942641; cv=none; b=ut02kq9OYuNmDnwOd1ws/HWFAVNRru/SB9r4lw1Sgi0rzo0y02x9pjdjuJS+H9XHbWJWuCcXLZN5nCf17RElZc/M+620AsR5fJD63PDo9ooKUWfj0+6cdmYGaSzkm0Nb1QxtQRdchFS54eVV+sO0fEYe+IHycGr4oMUvv7Ka4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736942641; c=relaxed/simple;
	bh=yUx/yUguaizzZsiI9KbLT/PSUorU7als0RUQxxoKr7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BoM8ly7P5/L8ml4Ll8q2QN/yennNKS9v6hSBm2BNpKfSQnSOspl7VKpRoaNrdEXtyY+szVADqjdm/Ghi9mNalCYSsBZcY8Ow4fMm+F9hGJj/cAEqv+R/5wCbyDG6TeizRysikWNEGLq55EeFYmsZN/UznHnh6xxYNyYYQh0qlfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrl9KSqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D74C4CEDF;
	Wed, 15 Jan 2025 12:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736942641;
	bh=yUx/yUguaizzZsiI9KbLT/PSUorU7als0RUQxxoKr7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hrl9KSqc1A7sY0vPdhGUstBdZR424Pe9WSR+Fxb6PymyiuAkAGvIJln2fpMBv0C9f
	 W2OYf/Hn7K8d0hJVQDIaGo8zhk1n0AwiWDcsYAAU9gYY2m9kOLCKNyDnp+Me+A+9oj
	 PY8v+eDlYl4j0cxbkWOlS7wF6TDRp89Lmk4seB+uCDagW0kfVELkQrKUtR9vNNdpJH
	 hvcd0rkN81jv3sT58bJ6lwB/m9yiCdh4OaRGzNwul7zjZ0MoNNJK3sfAYPQ0hrjeqh
	 HIhOgyc/rJtSCODYHMpT4eIU3QYfcOMg7Ozk/olBtL7vuBcNguM64eoVggN9O0IYh0
	 aE8nDsuD1YVMg==
Date: Wed, 15 Jan 2025 13:03:49 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "Jonathan Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
 <dave.jiang@intel.com>, "alison.schofield@intel.com"
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
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250115130349.655c5461@foz.lan>
In-Reply-To: <7a758dde8f044a0d955413b379179b93@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-5-shiju.jose@huawei.com>
	<20250114144712.49cd98f2@foz.lan>
	<7a758dde8f044a0d955413b379179b93@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 14 Jan 2025 14:30:53 +0000
Shiju Jose <shiju.jose@huawei.com> escreveu:

> >-----Original Message-----
> >From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >Sent: 14 January 2025 13:47
> >To: Shiju Jose <shiju.jose@huawei.com>
> >Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
> >acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> >bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
> >mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
> >Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
> >alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
> >david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
> >Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
> >Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
> >naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
> >somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
> >duenwen@google.com; gthelen@google.com;
> >wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
> >wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
> ><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
> >Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
> >wanghuiqiang <wanghuiqiang@huawei.com>; Linuxarm
> ><linuxarm@huawei.com>
> >Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
> >
> >Em Mon, 6 Jan 2025 12:10:00 +0000
> ><shiju.jose@huawei.com> escreveu:
> >  
> >> +What:		/sys/bus/edac/devices/<dev-
> >name>/mem_repairX/repair_function
> >> +Date:		Jan 2025
> >> +KernelVersion:	6.14
> >> +Contact:	linux-edac@vger.kernel.org
> >> +Description:
> >> +		(RO) Memory repair function type. For eg. post package repair,
> >> +		memory sparing etc.
> >> +		EDAC_SOFT_PPR - Soft post package repair
> >> +		EDAC_HARD_PPR - Hard post package repair
> >> +		EDAC_CACHELINE_MEM_SPARING - Cacheline memory sparing
> >> +		EDAC_ROW_MEM_SPARING - Row memory sparing
> >> +		EDAC_BANK_MEM_SPARING - Bank memory sparing
> >> +		EDAC_RANK_MEM_SPARING - Rank memory sparing
> >> +		All other values are reserved.
> >> +
> >> +What:		/sys/bus/edac/devices/<dev-
> >name>/mem_repairX/persist_mode
> >> +Date:		Jan 2025
> >> +KernelVersion:	6.14
> >> +Contact:	linux-edac@vger.kernel.org
> >> +Description:
> >> +		(RW) Read/Write the current persist repair mode set for a
> >> +		repair function. Persist repair modes supported in the
> >> +		device, based on the memory repair function is temporary
> >> +		or permanent and is lost with a power cycle.
> >> +		EDAC_MEM_REPAIR_SOFT - Soft repair function (temporary  
> >repair).  
> >> +		EDAC_MEM_REPAIR_HARD - Hard memory repair function  
> >(permanent repair).  
> >> +		All other values are reserved.
> >> +  
> >
> >After re-reading some things, I suspect that the above can be simplified a little
> >bit by folding soft/hard PPR into a single element at /repair_function, and letting
> >it clearer that persist_mode is valid only for PPR (I think this is the case, right?),
> >e.g. something like:  
> persist_mode is valid for memory sparing features(atleast in CXL) as well.
> In the case of CXL memory sparing, host has option to request either soft or hard sparing
> in a flag when issue a memory sparing operation.

Ok.

> 
> >
> >	What:		/sys/bus/edac/devices/<dev-  
> >name>/mem_repairX/repair_function  
> >	...
> >	Description:
> >			(RO) Memory repair function type. For e.g. post
> >package repair,
> >			memory sparing etc. Valid values are:
> >
> >			- ppr - post package repair.
> >			  Please define its mode via
> >			  /sys/bus/edac/devices/<dev-  
> >name>/mem_repairX/persist_mode  
> >			- cacheline-sparing - Cacheline memory sparing
> >			- row-sparing - Row memory sparing
> >			- bank-sparing - Bank memory sparing
> >			- rank-sparing - Rank memory sparing
> >			- All other values are reserved.
> >
> >and define persist_mode in a different way:  
> Note: For return as decoded strings instead of raw value,  I need to add some extra callback function/s
> in the edac/memory_repair.c  for these attributes  and which will reduce the current level of optimization done to
> minimize the code size.

You're already using a callback at EDAC_MEM_REPAIR_ATTR_SHOW macro.
So, no need for any change at the current code, except for the type
used at the EDAC_MEM_REPAIR_ATTR_SHOW() call.

Something similar to this (not tested) would work:

    int get_repair_function(struct device *dev, void *drv_data, const char **val)
    {
	unsigned int type;

	// Some logic to get repair type from *drv_data, storing into "unsigned int type"

	const char *repair_type[] = {
		[EDAC_SOFT_PPR] = "ppr",
		[EDAC_HARD_PPR] = "ppr",
		[EDAC_CACHELINE_MEM_SPARING] = "cacheline-sparing",
		...
	}

	if (type < ARRAY_SIZE(repair_type)) {
		*val = repair_type(type);
		return 0;
	}

	return -EINVAL;
    }

    EDAC_MEM_REPAIR_ATTR_SHOW(repair_function, get_repair_function, const char *, "%s\n");

Thanks,
Mauro

