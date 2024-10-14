Return-Path: <linux-edac+bounces-2043-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB1D99CDA4
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 16:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4619F1C215C9
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEC91AB521;
	Mon, 14 Oct 2024 14:34:42 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91E1798C;
	Mon, 14 Oct 2024 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916482; cv=none; b=PlSJnki3JLWIVuXVuzltTkpxLhXi/7tMB9sqMXy3GYKZ6iOjw0xGicUd/U2qo8fOxBQxlGwUFyi70CEEJ1q/0H9bWzTX9CL9Y6pVTfzKObFxMn5AMt+DmHmfslbtj3vjuHEOMtP4IC6AQFts3tfKZ7jcAZdxKLg95Yv89IZyhzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916482; c=relaxed/simple;
	bh=qNdam3C9gOrjO/3CDlp0IBHlqJ8S+hvHMEtUfCt3Rl0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvcEfYm6L2erc/WpIM0hArjkdyBIN9hoUJRgf/gy9GGkFGCHKH+6ANtcMLUxoXTWeIdE5skK569QsOiTAyPasMJcFpdparANBQJUBfY69tVyxVRYQSpTMbw+adtE6RSjCD7kHmF0Udh8fP/ryR+GjwMvVPQxXg43YLiX2dlh3+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS0992tBXz67j73;
	Mon, 14 Oct 2024 22:34:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 550F7140AB8;
	Mon, 14 Oct 2024 22:34:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 16:34:35 +0200
Date: Mon, 14 Oct 2024 15:34:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
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
Subject: Re: [PATCH v13 04/18] cxl: move cxl headers to new include/cxl/
 directory
Message-ID: <20241014153434.00001ec5@Huawei.com>
In-Reply-To: <20241009124120.1124-5-shiju.jose@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-5-shiju.jose@huawei.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 9 Oct 2024 13:41:05 +0100
<shiju.jose@huawei.com> wrote:

> From: Dave Jiang <dave.jiang@intel.com>
> 
> Group all cxl related kernel headers into include/cxl/ directory.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  MAINTAINERS                                | 3 +--
>  drivers/acpi/apei/einj-cxl.c               | 2 +-
>  drivers/acpi/apei/ghes.c                   | 2 +-
>  drivers/cxl/core/port.c                    | 2 +-
>  drivers/cxl/cxlmem.h                       | 2 +-
>  include/{linux/einj-cxl.h => cxl/einj.h}   | 0
>  include/{linux/cxl-event.h => cxl/event.h} | 0
>  7 files changed, 5 insertions(+), 6 deletions(-)
>  rename include/{linux/einj-cxl.h => cxl/einj.h} (100%)
>  rename include/{linux/cxl-event.h => cxl/event.h} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc40a9d9b8cd..ae17d28c5f73 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5620,8 +5620,7 @@ L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/driver-api/cxl
>  F:	drivers/cxl/
> -F:	include/linux/einj-cxl.h
> -F:	include/linux/cxl-event.h
> +F:	include/cxl/
>  F:	include/uapi/linux/cxl_mem.h
>  F:	tools/testing/cxl/
>  
> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
> index 8b8be0c90709..4f81a119ec08 100644
> --- a/drivers/acpi/apei/einj-cxl.c
> +++ b/drivers/acpi/apei/einj-cxl.c
> @@ -7,9 +7,9 @@
>   *
>   * Author: Ben Cheatham <benjamin.cheatham@amd.com>
>   */
> -#include <linux/einj-cxl.h>
>  #include <linux/seq_file.h>
>  #include <linux/pci.h>
> +#include <cxl/einj.h>
>  
>  #include "apei-internal.h"
>  
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 623cc0cb4a65..ada93cfde9ba 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -27,7 +27,6 @@
>  #include <linux/timer.h>
>  #include <linux/cper.h>
>  #include <linux/cleanup.h>
> -#include <linux/cxl-event.h>
>  #include <linux/platform_device.h>
>  #include <linux/mutex.h>
>  #include <linux/ratelimit.h>
> @@ -50,6 +49,7 @@
>  #include <acpi/apei.h>
>  #include <asm/fixmap.h>
>  #include <asm/tlbflush.h>
> +#include <cxl/event.h>
>  #include <ras/ras_event.h>
>  
>  #include "apei-internal.h"
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1d5007e3795a..e0b28a6730c1 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -3,7 +3,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/memregion.h>
>  #include <linux/workqueue.h>
> -#include <linux/einj-cxl.h>
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> @@ -11,6 +10,7 @@
>  #include <linux/slab.h>
>  #include <linux/idr.h>
>  #include <linux/node.h>
> +#include <cxl/einj.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
>  #include <cxl.h>
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index afb53d058d62..a81a8982bf93 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -6,8 +6,8 @@
>  #include <linux/cdev.h>
>  #include <linux/uuid.h>
>  #include <linux/rcuwait.h>
> -#include <linux/cxl-event.h>
>  #include <linux/node.h>
> +#include <cxl/event.h>
>  #include "cxl.h"
>  
>  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> diff --git a/include/linux/einj-cxl.h b/include/cxl/einj.h
> similarity index 100%
> rename from include/linux/einj-cxl.h
> rename to include/cxl/einj.h
> diff --git a/include/linux/cxl-event.h b/include/cxl/event.h
> similarity index 100%
> rename from include/linux/cxl-event.h
> rename to include/cxl/event.h


