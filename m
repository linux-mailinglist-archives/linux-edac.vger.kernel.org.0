Return-Path: <linux-edac+bounces-2042-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C1E99CD7F
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 16:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19A3CB21760
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE6E1AB6FD;
	Mon, 14 Oct 2024 14:33:08 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAD925632;
	Mon, 14 Oct 2024 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916388; cv=none; b=n1SwfhOp1tFKT0dmYKUAN8cePz7MVlPRraVWrhv/M8gnUw/91C3sXXZV9+wnoLhGNr5svAfxpTWkY1Q/9eE9FGtuWLWHPe7y7TXchxjC7+ZVPeHJehJVQHErjd0ponpdudrNF6OW8UsTD6JZbM8g+hyMKuFdgwDPwW+af/63aMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916388; c=relaxed/simple;
	bh=FrG1SBXVyfzmObKogdqJYzDcDZvE3ERkUU0F38QKt+E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKuvyJdWKVFMa1sA6OribnvtoeHUd9zQyYParETDGO9r3sJOJ1AXrRkO5j2X+Z1RViZv3xFeSHE5SOjqJKqGn/2ioQgjmq8RgdgWdQv/Zmyvt2+xEnL4bdgQzg7WqhTeAY1P27FaaUR+ZSZXiZJnI7MfTx3vlDXVOYYn3FCa3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS0686Qbgz6GC8c;
	Mon, 14 Oct 2024 22:31:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D020140C72;
	Mon, 14 Oct 2024 22:33:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 16:33:01 +0200
Date: Mon, 14 Oct 2024 15:33:00 +0100
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
Subject: Re: [PATCH v13 03/18] EDAC: Add ECS control feature
Message-ID: <20241014153300.00002942@Huawei.com>
In-Reply-To: <20241009124120.1124-4-shiju.jose@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-4-shiju.jose@huawei.com>
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

On Wed, 9 Oct 2024 13:41:04 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add EDAC ECS (Error Check Scrub) control in order to control a memory
> device's ECS feature.
> 
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts.
> 
> The DDR5 device contains number of memory media FRUs per device. The
> DDR5 ECS feature and thus the ECS control driver supports configuring
> the ECS parameters per FRU.
> 
> The memory devices support ECS feature register with EDAC device
> driver, which retrieves the ECS descriptor from EDAC ECS driver and
> exposes the sysfs ECS control attributes to userspace in
> /sys/bus/edac/devices/<dev-name>/ecs_fruX/.
> 
> The common sysfs ECS control interface abstracts the control of an
> arbitrary ECS functionality to a common set of functions.
> 
> The support for ECS feature is added separately because the DDR5 ECS
> features control attributes are dissimilar from those of the scrub
> feature.
> 
> The sysfs ECS attr nodes would be present only if the client driver
> has implemented the corresponding attr callback function and passed
> in ops to the EDAC RAS feature driver during registration.
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Hi Shiju

A few minor bits and bobs inline.

> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/mode_counts_codewords
> +Date:		Oct 2024
> +KernelVersion:	6.12

These all need updating to 6.13 given we missed on 6.12.

> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) True if current mode is ECS counts codewords with errors.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/reset
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(WO) ECS reset ECC counter.
> +		0 - normal, ECC counter running actively.

For a write only parameter, maybe just reject anything that isn't 1?

> +		1 - reset ECC counter to the default value.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/threshold
> +Date:		Oct 2024
> +KernelVersion:	6.12
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) ECS threshold count per GB of memory cells.

In the CXL spec it is Gb of memory cells (bits, not bytes).
I'm assuming this is meant to match that.
Maybe safer to spell it out.


> diff --git a/drivers/edac/ecs.c b/drivers/edac/ecs.c
> new file mode 100755
> index 000000000000..a2b64d7bf6b6
> --- /dev/null
> +++ b/drivers/edac/ecs.c


> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index 5344e2cf6808..20bdb08c7626 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h

>  
> +/**
> + * struct ecs_ops - ECS device operations (all elements optional)
> + * @get_log_entry_type: read the log entry type value.
> + * @set_log_entry_type: set the log entry type value.
> + * @get_log_entry_type_per_dram: read the log entry type per dram value.
> + * @get_log_entry_type_memory_media: read the log entry type per memory media value.
> + * @get_mode: read the mode value.
> + * @set_mode: set the mode value.
> + * @get_mode_counts_rows: read the mode counts rows value.
> + * @get_mode_counts_codewords: read the mode counts codewords value.
> + * @reset: reset the ECS counter.
> + * @get_threshold: read the threshold value.
> + * @set_threshold: set the threshold value.

Maybe it's worth duplicating the ABI docs statement on units?

> + */
> +struct edac_ecs_ops {
> +	int (*get_log_entry_type)(struct device *dev, void *drv_data, int fru_id, u32 *val);
> +	int (*set_log_entry_type)(struct device *dev, void *drv_data, int fru_id, u32 val);
> +	int (*get_log_entry_type_per_dram)(struct device *dev, void *drv_data,
> +					   int fru_id, u32 *val);
> +	int (*get_log_entry_type_per_memory_media)(struct device *dev, void *drv_data,
> +						   int fru_id, u32 *val);
> +	int (*get_mode)(struct device *dev, void *drv_data, int fru_id, u32 *val);
> +	int (*set_mode)(struct device *dev, void *drv_data, int fru_id, u32 val);
> +	int (*get_mode_counts_rows)(struct device *dev, void *drv_data, int fru_id, u32 *val);
> +	int (*get_mode_counts_codewords)(struct device *dev, void *drv_data, int fru_id, u32 *val);
> +	int (*reset)(struct device *dev, void *drv_data, int fru_id, u32 val);
> +	int (*get_threshold)(struct device *dev, void *drv_data, int fru_id, u32 *threshold);
> +	int (*set_threshold)(struct device *dev, void *drv_data, int fru_id, u32 threshold);
> +};



