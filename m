Return-Path: <linux-edac+bounces-2775-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F241EA009B1
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2025 14:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6315164494
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2025 13:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D931FA168;
	Fri,  3 Jan 2025 13:02:23 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07991FA826;
	Fri,  3 Jan 2025 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735909343; cv=none; b=rqtRkAbd+Ivtg7pdj03otviRN6K/44GEI8ENY1l239qkd5EuS3rNV0UMa9ySRctRQLWbNa6TB8WpM2bL7PolGbxUlFw5DCfazFcjmsWB0Qc9OBSn30lOJN2i1cYFEJ+VTASDJlxrn+qJ0J4BZbGeEGkD42o7y2Go/MVQFLudKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735909343; c=relaxed/simple;
	bh=LkcB2FxoHHUQrXN3mm00p6wM76Ru+nWNH+b3LTICErU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/jgaHrkCHLTwHwYcodfp0X+I19JodanRjW0/JAObARNlNzW/HAu1UFRBJrjatTfS5/yrc5k0tuaqcxgskEZfxxOuvVE9MdmPZ6DzHbjKzqrnD5KDfvc6D+Xmo2rcianc+WYBlmd1qYe1yFX50QrmeN1IsMe6DE5WtGz3CcDKOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YPkBp2Pl7z6K9L3;
	Fri,  3 Jan 2025 20:57:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E3021140367;
	Fri,  3 Jan 2025 21:02:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 3 Jan
 2025 14:02:14 +0100
Date: Fri, 3 Jan 2025 13:02:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: <shiju.jose@huawei.com>, <linux-edac@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
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
Subject: Re: [PATCH v17 00/18] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Message-ID: <20250103130213.00006abd@huawei.com>
In-Reply-To: <20250103114109.GAZ3fM1dEsyBSn9lWA@fat_crate.local>
References: <20241122180416.1932-1-shiju.jose@huawei.com>
	<20250103114109.GAZ3fM1dEsyBSn9lWA@fat_crate.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 3 Jan 2025 12:41:45 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Nov 22, 2024 at 06:03:57PM +0000, shiju.jose@huawei.com wrote:
> >  drivers/edac/Makefile                         |    1 +
> >  drivers/edac/ecs.c                            |  207 +++
> >  drivers/edac/edac_device.c                    |  183 ++
> >  drivers/edac/mem_repair.c                     |  492 +++++
> >  drivers/edac/scrub.c                          |  209 +++
> >  drivers/ras/Kconfig                           |   10 +
> >  drivers/ras/Makefile                          |    1 +
> >  drivers/ras/acpi_ras2.c                       |  385 ++++
> >  include/acpi/ras2_acpi.h                      |   45 +
> >  include/cxl/features.h                        |   48 +
> >  include/cxl/mailbox.h                         |   45 +-
> >  include/linux/edac.h                          |  238 +++
> >  include/uapi/linux/cxl_mem.h                  |    3 +  
> 
> So what's the plan here? Am I supposed to merge the EDAC/RAS bits through the
> RAS tree and then give folks an immutable branch or how do we want to proceed
> here?
> 

Dave Jiang / Rafael, what would work best for the two of you?

To me Boris' suggestion makes sense, particularly as that
avoids the complexity of CXL get/set features being in multiple series.

I think the split that would make sense is:

EDAC immutable branch for:
 1: EDAC: Add support for EDAC device features control
 2: Add scrub control feature
 3: EDAC: Add ECS control feature
 15: EDAC: Add memory repair control feature

ACPI merges EDAC immutable +
 13: ACPI:RAS2: Add ACPI RAS2 driver
 14: ras: mem: Add memory ACPI RAS2 driver

CXL merges EDAC immutable +
 4: cxl: Refactor user ioctl command path from mds to mailbox
 5: cxl: Add Get Supported Features command for kernel usage 
 6: cxl/mbox: Add GET_FEATURE mailbox command
 7: cxl: Add Get Feature command support for user submission
 8: cxl/mbox: Add SET_FEATURE mailbox command
 9: cxl: Add Set Feature command support for user submission
 10: cxl: Add UUIDs for the CXL RAS features
 11: cxl/memfeature: Add CXL memory device patrol scrub control feature
 12: cxl/memfeature: Add CXL memory device ECS control feature
 16: cxl/mbox: Add support for PERFORM_MAINTENANCE mailbox command
 17: cxl/memfeature: Add CXL memory device soft PPR control feature
 18: cxl/memfeature: Add CXL memory device memory sparing control feature

That does mean that the actual drivers/edac/ specific drivers land
via the ACPI and CXL trees only, but without another layer of immutable branches
we can't avoid that. Might cause merge conflicts in Kconfig/Makefiles but otherwise
shouldn't be too bad.

There is going to be some noise in documentation as examples are added
to the docs with the actual drivers (whereas generic docs are introduced
with the infrastructure).  I think that will work out though.
Shiju, could you spin this ordering up and check it all works
(incorporating Dave's updates to the GET / SET feature)?

Thanks,

Jonathan

