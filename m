Return-Path: <linux-edac+bounces-3990-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F27EAC0F2D
	for <lists+linux-edac@lfdr.de>; Thu, 22 May 2025 17:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8A91C019A8
	for <lists+linux-edac@lfdr.de>; Thu, 22 May 2025 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E8128DB7E;
	Thu, 22 May 2025 14:58:12 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EEE28C5CA;
	Thu, 22 May 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925892; cv=none; b=LzI2s8Ri2oLC9XqpqlbolY7BnraWHZkIpZ3BN6Lw09z4XLjpIJe2o2gAQoWFeTk275ZQqbcSsYdPXB3xBwqcnkudRP9Sylpaksvn1UN86AOJNO8k2BMnIY3z2YTk++Tw1+eDQ8G7MqrVGK99WsSRkh4EmhaHRUOGIyhCr7I8vqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925892; c=relaxed/simple;
	bh=PfdEY65M9VrYioKAUqOOBm85qrHkaxYR5yp4YhmUp5I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NPBRo7+kwKZ7aubfEb3AsIL4aFBjOpvz/6BVh/2KD8VwwglMlIhZmHWjgRCwsQnr1/aRddhvrh2vfbINLauHC3aVK9IChr+5l7MjtorwA/ozKJ7rEpT++kHlT7+GOYC96iJqvCaq0eTkRW8xp0PAcrh8Zx2TeomZoZ1gNBCdjho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b3BCZ4Lk5z6L5Bh;
	Thu, 22 May 2025 22:54:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 70E2D140390;
	Thu, 22 May 2025 22:58:05 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 May
 2025 16:58:04 +0200
Date: Thu, 22 May 2025 15:58:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <bp@alien8.de>, <rafael@kernel.org>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <mchehab@kernel.org>, <linux-mm@kvack.org>,
	<linuxarm@huawei.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>
Subject: Re: [PATCH v7 0/2] ACPI: Add support for ACPI RAS2 feature table
Message-ID: <20250522155802.0000648b@huawei.com>
In-Reply-To: <20250519151116.803-1-shiju.jose@huawei.com>
References: <20250519151116.803-1-shiju.jose@huawei.com>
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

On Mon, 19 May 2025 16:11:13 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
Hi Rafael,

Are you looking for anything else for this series?
(reviews from others etc?)

The core EDAC support when upstream last cycle (this was
in that series as well so is kind of version 27). I believe
the expectation is this will go through your tree.

Tweaks have been pretty minor for last few versions.

Thanks,

Jonathan

> Add support for ACPI RAS2 feature table (RAS2) defined in the
> ACPI 6.5 specification, section 5.2.21 and RAS2 HW based memory
> scrubbing feature.
> 
> ACPI RAS2 patches were part of the EDAC series [1].
> 
> The code is based on ras.git: edac-for-next branch [2]
> merged with linux-pm.git [3] : linux-next branch.
> 
> 1. https://lore.kernel.org/linux-cxl/20250212143654.1893-1-shiju.jose@huawei.com/
> 2. https://web.git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-for-next
> 3. https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/
> 
> Changes
> =======
> v6 -> v7:
> 1. Fix for the issue reported by Daniel,
>    In ras2_check_pcc_chan(), add read, clear and check RAS2 set_cap_status outside
>    if (status & PCC_STATUS_ERROR) check. 
>    https://lore.kernel.org/all/51bcb52c-4132-4daf-8903-29b121c485a1@os.amperecomputing.com/
> 
> v5 -> v6:
> 1. Fix for the issue reported by Daniel, in start scrubbing with correct addr and size
>    after firmware return INVALID DATA error for scrub request with invalid addr or size.
>    https://lore.kernel.org/all/8cdf7885-31b3-4308-8a7c-f4e427486429@os.amperecomputing.com/
>    
> v4 -> v5:
> 1. Fix for the build warnings reported by kernel test robot.
>    https://patchwork.kernel.org/project/linux-edac/patch/20250423163511.1412-3-shiju.jose@huawei.com/
> 2. Removed patch "ACPI: ACPI 6.5: RAS2: Rename RAS2 table structure and field names"
>    from the series as the patch was merged to linux-pm.git : branch linux-next
> 3. Rebased to ras.git: edac-for-next branch merged with linux-pm.git : linux-next branch.
>       
> v3 -> v4:
> 1.  Changes for feedbacks from Yazen on v3.
>     https://lore.kernel.org/all/20250415210504.GA854098@yaz-khff2.amd.com/
> 
> v2 -> v3:
> 1. Rename RAS2 table structure and field names in 
>    include/acpi/actbl2.h limited to only necessary
>    for RAS2 scrub feature.
> 2. Changes for feedbacks from Jonathan on v2.
> 3. Daniel reported a known behaviour: when readback 'size' attribute after
>    setting in, returns 0 before starting scrubbing via 'addr' attribute.
>    Changes added to fix this.
> 4. Daniel reported that firmware cannot update status of demand scrubbing
>    via the 'Actual Address Range (OUTPUT)', thus add workaround in the
>    kernel to update sysfs 'addr' attribute with the status of demand
>    scrubbing.
> 5. Optimized logic in ras2_check_pcc_chan() function
>    (patch - ACPI:RAS2: Add ACPI RAS2 driver).
> 6. Add PCC channel lock to struct ras2_pcc_subspace and change
>    lock in ras2_mem_ctx as a pointer to pcc channel lock to make sure
>    writing to PCC subspace shared memory is protected from race conditions.
>    
> v1 -> v2:
> 1.  Changes for feedbacks from Borislav.
>     - Shorten ACPI RAS2 structures and variables names.
>     - Shorten some of the other variables in the RAS2 drivers.
>     - Fixed few CamelCases.
> 
> 2.  Changes for feedbacks from Yazen.
>     - Added newline after number of '}' and return statements.
>     - Changed return type for "ras2_add_aux_device() to 'int'.
>     - Deleted a duplication of acpi_get_table("RAS2",...) in the ras2_acpi_parse_table().
>     - Add "FW_WARN" to few error logs in the ras2_acpi_parse_table().
>     - Rename ras2_acpi_init() to acpi_ras2_init() and modified to call acpi_ras2_init()
>       function from the acpi_init().
>     - Moved scrub related variables from the struct ras2_mem_ctx from  patch
>       "ACPI:RAS2: Add ACPI RAS2 driver" to "ras: mem: Add memory ACPI RAS2 driver".
> 
> Shiju Jose (2):
>   ACPI:RAS2: Add ACPI RAS2 driver
>   ras: mem: Add memory ACPI RAS2 driver
> 
>  Documentation/edac/scrub.rst |  78 ++++++
>  drivers/acpi/Kconfig         |  11 +
>  drivers/acpi/Makefile        |   1 +
>  drivers/acpi/bus.c           |   3 +
>  drivers/acpi/ras2.c          | 450 +++++++++++++++++++++++++++++++++++
>  drivers/ras/Kconfig          |  11 +
>  drivers/ras/Makefile         |   1 +
>  drivers/ras/acpi_ras2.c      | 424 +++++++++++++++++++++++++++++++++
>  include/acpi/ras2.h          |  70 ++++++
>  9 files changed, 1049 insertions(+)
>  create mode 100644 drivers/acpi/ras2.c
>  create mode 100644 drivers/ras/acpi_ras2.c
>  create mode 100644 include/acpi/ras2.h
> 


