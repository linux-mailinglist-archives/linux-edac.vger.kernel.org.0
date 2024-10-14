Return-Path: <linux-edac+bounces-2054-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F34799D48C
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 18:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B6A1F23421
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 16:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20331AE01F;
	Mon, 14 Oct 2024 16:23:21 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D1139D0B;
	Mon, 14 Oct 2024 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923001; cv=none; b=FZRB8oB/tFyx7vwKcG+Kf3oRJ1HHUD/oowMToMca1rDPl/LJkfx6aInvpr75i8fhlL7o3l5yFjsQRCng9MBrUguhAuhFI9IGicbBiTY4apANDDJQ2TsIaCt7BsTnRjx5cC7ejoM5pLwB+HJO5U0UkPudXVbLGNs0C7dSn7Ei7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923001; c=relaxed/simple;
	bh=/5Y56NXMxu6hrsRPBDx9TFFwv1dz2Qoek3MY3otzMCk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBN/XTkOowGeHVynp2/1s5WK/HLMJD+QphThZNUccNfVDFB+sx6Vrc1A7Fkou5uCPQt0FKcXuvL/1JmQRIORvCtxgp10wdtiSadOFOh4InW9ElDz/b+L80D0Cs+/YjKebvP8zpPWwc23G7L4i3fIdImSTZ6LEq2FbIGDr8huU2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS2ZW3DWfz6HJp7;
	Tue, 15 Oct 2024 00:22:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 95297140B55;
	Tue, 15 Oct 2024 00:23:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 18:23:14 +0200
Date: Mon, 14 Oct 2024 17:23:12 +0100
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
Subject: Re: [PATCH v13 15/18] EDAC: Add memory repair control feature
Message-ID: <20241014172312.00007034@Huawei.com>
In-Reply-To: <20241009124120.1124-16-shiju.jose@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-16-shiju.jose@huawei.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 9 Oct 2024 13:41:16 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add generic EDAC memory repair control, eg. PPR(Post Package Repair),
> memory sparing etc, control driver in order to control memory repairs
> in the system. Supports sPPR(soft PPR), hPPR(hard PPR), soft/hard memory
> sparing, memory sparing at cacheline/row/bank/rank granularity etc.
> Device with memory repair features registers with EDAC device driver,
> which retrieves memory repair descriptor from EDAC memory repair driver and
> exposes the sysfs repair control attributes to userspace in
> /sys/bus/edac/devices/<dev-name>/mem_repairX/.
> 
> The common memory repair control interface abstracts the control of an
> arbitrary memory repair functionality to a common set of functions.
> The sysfs memory repair attribute nodes would be present only if the client
> driver has implemented the corresponding attribute callback function and
> passed in ops to the EDAC device driver during registration.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
The question inline that we discussed offlist.

Whether it makes sense to potentially have one device provide
several mem_repairX differing in granularity (and may type) of
repair, or one mem_repairX that has a control over granularity?

The CXL spec has it designed as separate control interfaces but
I'm not sure if we should follow that precedence or not.

> ---
>  .../ABI/testing/sysfs-edac-mem-repair         | 152 +++++++++
>  drivers/edac/Makefile                         |   2 +-
>  drivers/edac/edac_device.c                    |  31 ++
>  drivers/edac/mem_repair.c                     | 317 ++++++++++++++++++
>  include/linux/edac.h                          |  67 ++++
>  5 files changed, 568 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-edac-mem-repair
>  create mode 100755 drivers/edac/mem_repair.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-edac-mem-repair b/Documentation/ABI/testing/sysfs-edac-mem-repair
> new file mode 100644
> index 000000000000..9a8712ed9d47
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-edac-mem-repair
> @@ -0,0 +1,152 @@
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		The sysfs EDAC bus devices /<dev-name>/mem_repairX subdirectory
> +		belongs to the memory media repair features control, such as
> +		PPR (Post Package Repair), memory sparing etc, where<dev-name>
> +		directory corresponds to a device registered with the EDAC
> +		device driver for the memory repair features.
> +		/mem_repairX belongs to either sPPR (Soft PPR) or hPPR (Hard PPR)
> +		feature of PPR feature, hard or soft memory sparing etc. The memory
> +		sparing is a repair function that replaces a portion of memory
> +		(spared memory) with a portion of functional memory. The memory
> +		sparing has cacheline/row/bank/rank sparing granularities.
> +		The sysfs memory repair attr nodes would be only present if a
> +		memory repair feature is supported.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/repair_type
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) Type of the repair instance. For eg. sPPR, hPPR, cacheline/
> +		row/bank/rank memory sparing etc.
So this is the open question for me with this feature.
Do we do a monolithic 'device' that does all repair types for which we pick a mode
or do we (as here) allow for one mem_repairX for each supported type?

I don't particularly mind but it is a design question I'd like input on
from a wider audience.

> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/hpa
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(WO) Set HPA (Host Physical Address) for memory repair.

Can we not just read back what was written?  Seems like userspace
might expect that?


