Return-Path: <linux-edac+bounces-1078-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 681BD8C9CCE
	for <lists+linux-edac@lfdr.de>; Mon, 20 May 2024 13:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3191C20BA2
	for <lists+linux-edac@lfdr.de>; Mon, 20 May 2024 11:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76155381D;
	Mon, 20 May 2024 11:59:05 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2E54BF6;
	Mon, 20 May 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206345; cv=none; b=neTYBgtreGpu5BVnk+szmVGROGTa3r2a9xMtbYqdkfQ1ZFvNA7y/Lg5gq8FYGcG9Dz+BdJBrH/trOAdDrgzIS5wSjk7Cs/lvaFUJlPna730GN87ZbyETXLxgDxYvm2o0LsEl9QxGbBPeov+sPOPLDUjOVXtVee4WbOXSDloq+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206345; c=relaxed/simple;
	bh=LnBJ8MxDkQz+E/8LFMQ1ASsV9F3ldjuT22qaa1zk5ps=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQzSlIgwElwcu2khIHcDgZpwxa33VhAJqJ6C6Z2WPd+E+Fbx1mxCBZBy0cL3REQRuxzq8dfEOnP8pkvbo9DXZQk8LVZOgFxJ3DWmihKRXS4tZ3ePV5NOpjoelAlCBMvNgXyxITy4L8zvepgQlR+pAStorP2GLdorn579hZHqKVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vjbby5TsBz6JBPr;
	Mon, 20 May 2024 19:55:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3287B140A36;
	Mon, 20 May 2024 19:59:00 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 20 May
 2024 12:58:59 +0100
Date: Mon, 20 May 2024 12:58:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shiju Jose <shiju.jose@huawei.com>
CC: Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Jean Delvare
	<jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <20240520125857.00007641@Huawei.com>
In-Reply-To: <6645f0738ead48a79f1baf753fc709c6@huawei.com>
References: <4ceb38897d854cc095fca1220d49a4d2@huawei.com>
	<20240508192546.GHZjvRuvtu0XSJbkmz@fat_crate.local>
	<20240509101939.0000263a@Huawei.com>
	<D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>
	<20240509200306.GAZj0r-h5Tnc0ecIOz@fat_crate.local>
	<663d3e58a0f73_1c0a1929487@dwillia2-xfh.jf.intel.com.notmuch>
	<20240509215147.GBZj1Fc06Ieg8EQfnR@fat_crate.local>
	<663d55515a2d9_db82d2941e@dwillia2-xfh.jf.intel.com.notmuch>
	<20240510092511.GBZj3n9ye_BCSepFZy@fat_crate.local>
	<663e55c59d9d_3d7b429475@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240511101705.GAZj9FoVbThp7JUK16@fat_crate.local>
	<6645f0738ead48a79f1baf753fc709c6@huawei.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 20 May 2024 11:54:50 +0100
Shiju Jose <shiju.jose@huawei.com> wrote:

> >-----Original Message-----
> >From: Borislav Petkov <bp@alien8.de>
> >Sent: 11 May 2024 11:17
> >To: Dan Williams <dan.j.williams@intel.com>
> >Cc: Jonathan Cameron <jonathan.cameron@huawei.com>; Shiju Jose
> ><shiju.jose@huawei.com>; linux-cxl@vger.kernel.org; linux-
> >acpi@vger.kernel.org; linux-mm@kvack.org; dave@stgolabs.net;
> >dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com;
> >ira.weiny@intel.com; linux-edac@vger.kernel.org; linux-
> >kernel@vger.kernel.org; david@redhat.com; Vilas.Sridharan@amd.com;
> >leo.duran@amd.com; Yazen.Ghannam@amd.com; rientjes@google.com;
> >jiaqiyan@google.com; tony.luck@intel.com; Jon.Grimm@amd.com;
> >dave.hansen@linux.intel.com; rafael@kernel.org; lenb@kernel.org;
> >naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
> >somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
> >duenwen@google.com; mike.malvestuto@intel.com; gthelen@google.com;
> >wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
> >wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
> ><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> >kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
> >Linuxarm <linuxarm@huawei.com>; Greg Kroah-Hartman
> ><gregkh@linuxfoundation.org>; Jean Delvare <jdelvare@suse.com>; Guenter
> >Roeck <linux@roeck-us.net>; Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
> >
> >On Fri, May 10, 2024 at 10:13:41AM -0700, Dan Williams wrote:  
> >> In fact this question matches my reaction to the last posting [1], and
> >> led to a much improved cover letter and the "Comparison of scrubbing
> >> features". To your point there are scrub capabilities already in the
> >> kernel and we would need to make a decision about what to do about them.  
> >
> >The answer to that question is whether this new userspace usage is going to
> >want to control those too.
> >
> >So
> >
> >"Use case of scrub control feature"
> >
> >from the cover letter is giving two short sentences about what one would do but
> >I'm still meh. A whole subsystem needing a bunch of effort would need a lot
> >more justification.
> >
> >So can anyone please elaborate more on the use cases and why this new thing is
> >needed?  
> 
> Following are some of the use cases of generic scrub control subsystem as given in the cover letter.
> Request please add any other use cases, which I missed.
> 
> 1. There are several types of interfaces to HW memory scrubbers identified such as ACPI NVDIMM ARS(Address Range Scrub), CXL memory device patrol scrub, CXL DDR5 ECS, ACPI RAS2 memory scrubbing features and software based memory scrubber(discussed in the community Reference [5] in the cover letter). Also some scrubbers support controlling (background) patrol scrubbing(ACPI RAS2, CXL)  and/or on-demand scrubbing(ACPI RAS2, ACPI ARS).  However the scrub controls varies between memory scrubbers. Thus there is  a need  for a standard generic ABI and sysfs scrub controls for the userspace tools, which control HW and SW scrubbers in the system, for the easiness of use.
> 2. Scrub controls in user space allow the user space tool to disable and enable the feature in case disabling of the background patrol  scrubbing and changing the scrub rate are needed for other purposes such as performance-aware operations which requires the background operations to be turned off or reduced.
> 3. Allows to perform on-demand scrubbing for specific address range if supported by the scrubber.
> 4. User space tools controls scrub the memory DIMMs regularly at a configurable scrub rate using the sysfs scrub controls discussed help, 
>     - to detect uncorrectable memory errors early before user accessing memory, which helps to recover the detected memory errors.
>     -  reduces the chance of a correctable error becoming uncorrectable.

Just to add one more reason a user space interface is needed.
5. Policy control for hotplugged memory.  There is not necessarily a system wide bios
   or similar in the loop to control the scrub settings on a CXL device that wasn't
   there at boot.  What that setting should be is a policy decision as we are trading
   of reliability vs performance - hence it should be in control of userspace.
   As such, 'an' interface is needed. Seems more sensible to try and unify it with
   other similar interfaces than spin yet another one.

> 
> Regards,
> Shiju
> 


