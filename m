Return-Path: <linux-edac+bounces-2950-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC4A1D40F
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jan 2025 11:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF52716624A
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jan 2025 10:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774CC1FDA83;
	Mon, 27 Jan 2025 10:06:31 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A62F135A63;
	Mon, 27 Jan 2025 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737972391; cv=none; b=WFMk+hdK6RuIH4M/38ogg/FXT9mvJWTGokf1Oe4ClMvQMNfXxI25EpmiiPgmbcCclFe8jfRoG5u07SpxfCr3i+gS7JmM/1QT6fxMy+MkOipbr3bTm22jSq3u+US6h6YcpB+M5i8u5eowqpJYyoD2Bcl289Z8hm0eERjm9BwbAXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737972391; c=relaxed/simple;
	bh=HaJISOiWz7R1r1J6OtqNGdfHPZ+ielbWHGWQOkSlAY8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWRcSoVyqFK4DlNHZ5isNM3gz/oULlc9mVFr+lWSTsJHBjoyU3C8jE1ns1tdpLKfSbAJ/FeTpoCquLKQjTawxK3wVAx9cONygjWGkOQmb7N9ZLEg6X21jKynir+IucPyMMgOynBwjUSYyxA8+v46l+IaAVltxMCAcULIqpiK2p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YhPCP5hTVz6M4Pk;
	Mon, 27 Jan 2025 18:04:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A78E1400D4;
	Mon, 27 Jan 2025 18:06:20 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 27 Jan
 2025 11:06:18 +0100
Date: Mon, 27 Jan 2025 10:06:17 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <shiju.jose@huawei.com>, <linux-edac@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<mchehab@kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v18 15/19] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Message-ID: <20250127100617.00005e77@huawei.com>
In-Reply-To: <6793fa5351fc7_20f3294d0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-16-shiju.jose@huawei.com>
	<6793fa5351fc7_20f3294d0@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 24 Jan 2025 12:38:43 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> shiju.jose@ wrote:
> > From: Shiju Jose <shiju.jose@huawei.com>
> > 
> > CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
> > feature. The device patrol scrub proactively locates and makes corrections
> > to errors in regular cycle.
> > 
> > Allow specifying the number of hours within which the patrol scrub must be
> > completed, subject to minimum and maximum limits reported by the device.
> > Also allow disabling scrub allowing trade-off error rates against
> > performance.
> > 
> > Add support for patrol scrub control on CXL memory devices.
> > Register with the EDAC device driver, which retrieves the scrub attribute
> > descriptors from EDAC scrub and exposes the sysfs scrub control attributes
> > to userspace. For example, scrub control for the CXL memory device
> > "cxl_mem0" is exposed in /sys/bus/edac/devices/cxl_mem0/scrubX/.
> > 
> > Additionally, add support for region-based CXL memory patrol scrub control.
> > CXL memory regions may be interleaved across one or more CXL memory
> > devices. For example, region-based scrub control for "cxl_region1" is
> > exposed in /sys/bus/edac/devices/cxl_region1/scrubX/.
> > 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Hi Dan,

A few specific replies in line. I've left the detail stuff to Shiju
to address.  Definitely a few things in there I'd missed!

Thanks,

Jonathan


> > ---
> >  Documentation/edac/scrub.rst  |  66 ++++++
> >  drivers/cxl/Kconfig           |  17 ++
> >  drivers/cxl/core/Makefile     |   1 +
> >  drivers/cxl/core/memfeature.c | 392 ++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/region.c     |   6 +
> >  drivers/cxl/cxlmem.h          |   7 +
> >  drivers/cxl/mem.c             |   5 +
> >  include/cxl/features.h        |  16 ++
> >  8 files changed, 510 insertions(+)
> >  create mode 100644 drivers/cxl/core/memfeature.c
> > diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
> > index f86645c7f0af..80e986c57885 100644
> > --- a/Documentation/edac/scrub.rst
> > +++ b/Documentation/edac/scrub.rst
> > @@ -325,3 +325,69 @@ root@localhost:~# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/current_cycle_d
> >  10800
> >  
> >  root@localhost:~# echo 0 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/enable_background
> > +
> > +2. CXL memory device patrol scrubber
> > +
> > +2.1 Device based scrubbing
> > +
> > +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/min_cycle_duration
> > +
> > +3600
> > +
> > +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/max_cycle_duration
> > +
> > +918000
> > +
> > +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
> > +
> > +43200
> > +
> > +root@localhost:~# echo 54000 > /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
> > +
> > +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
> > +
> > +54000
> > +
> > +root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
> > +
> > +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
> > +
> > +1
> > +
> > +root@localhost:~# echo 0 > /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
> > +
> > +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
> > +
> > +0
> > +
> > +2.2. Region based scrubbing
> > +
> > +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/min_cycle_duration
> > +
> > +3600
> > +
> > +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/max_cycle_duration
> > +
> > +918000
> > +
> > +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
> > +
> > +43200
> > +
> > +root@localhost:~# echo 54000 > /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
> > +
> > +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
> > +
> > +54000
> > +
> > +root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
> > +
> > +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
> > +
> > +1
> > +
> > +root@localhost:~# echo 0 > /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
> > +
> > +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/enable_background  
> 
> What is this content-free blob of cat and echo statements? Please write actual
> documentation with theory of operation, clarification of assumptions,
> rationale for defaults, guidance on changing defaults... 

Note this is a continuation of existing documentation, but sure some inline comments
talking more about it would be fine.  The rational and top level discussion is
meant to be described in patch 2 as it is not CXL specific.

Defaults are a device thing, there are no software driven defaults.

So I'd suggest the above just adds a few comments along the lines of
what the actions of each block does. 
Something like:

Check current parameters and program the scrubbing for a region to repeat
every X seconds (% of day)


> 
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index 0bc6a2cb8474..6078f02e883b 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -154,4 +154,21 @@ config CXL_FEATURES
> >  
> >  	  If unsure say 'y'.
> >  
> > +config CXL_RAS_FEATURES
> > +	tristate "CXL: Memory RAS features"
> > +	depends on CXL_PCI  
> 
> What is the build dependency on CXL_PCI? This enabling does not call back into
> symbols provided by cxl_pci.ko does it?
> 
> > +	depends on CXL_MEM  
> 
> Similar comment, and this also goes away if all of this just moves into
> the new cxl_features driver.

I'm not sure moving to be a child of cxl_features makes sense. Can
probably do it but it's making the spiders web of connections even harder
to relate to the underlying hardware. In my mental model, this stuff
takes services from 'features' and 'mailbox' parts of the CXL driver.

Take repair.   Less than half of each of those drivers is feature related
(a few 'what can I do' type aspects). The control plane goes via
maintenance commands.

Obviously we can get to those by adding additional infrastructure to the
features driver, but that seems likely to be ugly and where do we stop?
It won't scale to likely future cases where the feature part is a tiny
tweak on some much larger chunk of infrastructure (which is mostly what
spec defined features seem to be for). I don't think we want to support
the complexity of device built-in test in the 3.2 spec necessarily
(haven't really thought about it yet!) but it is an example of what would
be an EDAC feature but has no dependence on features.

We could register the patrol scrub stuff from features, and the rest
separately but that seems even more confusing.

So to me, nesting under features is an ugly solution but I'm not that
attached to current approach.

So in my view this stuff should be dependent on CXL_FEATURES but
not a child of it.


(lots skipped - I'll leave the detailed stuff to Shiju!)
> > +	else
> > +		snprintf(cxl_dev_name, sizeof(cxl_dev_name),
> > +			 "%s_%s", "cxl", dev_name(&cxlmd->dev));  
> 
> Can a "cxl" directory be created so that the raw name can be used?

I'd like feedback from Boris on that.  It is a mess to instantiate
devices in subdirectories under a bus (that's kind of the big issue
with the EDAC usage of the device model already).

I'd say no it can't.

> 


