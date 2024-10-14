Return-Path: <linux-edac+bounces-2049-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA0799D3B4
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 17:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FAF1C240DF
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 15:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C311B85D0;
	Mon, 14 Oct 2024 15:41:05 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E51ADFF9;
	Mon, 14 Oct 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920465; cv=none; b=XKHEYnx3WjXztXBuHTq96qA2mHKWbONfCuwCsKZKvASnJ21AY2iYPjggXmoYFFqhmbYKxQ2yM7kV1FnynSaFWxnNKF1FMLgNQtGppHixFpL2juA9hzhMOpBlj58gO1ydvMrOaWOGsJjhRJoYnTpM0NSxL74zxv/YsizzmIM40R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920465; c=relaxed/simple;
	bh=kWirdfy8Sq4ERX3554ZRHJH8UMECSWQ9Y6eB3rtp2yE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qm0w6sIdvuCPzj3s9s6lE5XwmVQ/vWDYug78r2e0E/6nqXJPEpEfcGeZ3EmSJFunF+c8GVFcLwhKIVuil8Tj3wmIPBI6lYNpklo6kbqrh5YU8xYBQFLNmheuOEju+xwW7FpzopgwSu7s+kjw7zhs7lrY0/iLXaZY4NWUMrd8h1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS1cX1gncz6GC8t;
	Mon, 14 Oct 2024 23:39:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A5CF1401F4;
	Mon, 14 Oct 2024 23:40:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 17:40:57 +0200
Date: Mon, 14 Oct 2024 16:40:55 +0100
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
Subject: Re: [PATCH v13 11/18] cxl/memfeature: Add CXL memory device ECS
 control feature
Message-ID: <20241014164055.00002019@Huawei.com>
In-Reply-To: <20241009124120.1124-12-shiju.jose@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-12-shiju.jose@huawei.com>
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

On Wed, 9 Oct 2024 13:41:12 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 ECS (Error Check
> Scrub) control feature.
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts.
I never understood the 'transparency to error counts'.
Maybe from software point of view 
'while reporting error counts to the host'.
Unless anyone else can figure out what that text from the CXL spec
means? (I'm guessing it is cut and paste from the JEDEC spec)

> 
> The ECS control allows the requester to change the log entry type, the ECS
> threshold count provided that the request is within the definition
> specified in DDR5 mode registers, change mode between codeword mode and
> row count mode, and reset the ECS counter.
> 
> Register with EDAC device driver, which gets the ECS attr descriptors
> from the EDAC ECS and expose sysfs ECS control attributes to userspace.
> For example ECS control for the memory media FRU 0 in CXL mem0 device is
> in /sys/bus/edac/devices/cxl_mem0/ecs_fruX/
fru0?
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

A few little things in line. In general looks good to me.

> ---
>  drivers/cxl/core/memfeature.c | 467 +++++++++++++++++++++++++++++++++-
>  1 file changed, 461 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/memfeature.c b/drivers/cxl/core/memfeature.c
> index 84d6e887a4fa..567406566c77 100644
> --- a/drivers/cxl/core/memfeature.c
> +++ b/drivers/cxl/core/memfeature.c
> @@ -19,7 +19,7 @@
>  #include <cxl.h>
>  #include <linux/edac.h>
>  
> -#define CXL_DEV_NUM_RAS_FEATURES	1
> +#define CXL_DEV_NUM_RAS_FEATURES	2
>  #define CXL_DEV_HOUR_IN_SECS	3600
>  
>  #define CXL_SCRUB_NAME_LEN	128
> @@ -309,6 +309,420 @@ static const struct edac_scrub_ops cxl_ps_scrub_ops = {
>  	.set_cycle_duration = cxl_patrol_scrub_write_scrub_cycle,
>  };
>  
> +/* CXL DDR5 ECS control definitions */
> +static const uuid_t cxl_ecs_uuid =
> +	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,     \

Why the \?

> +		  0x89, 0x33, 0x86);
> +


> +
> +#define	CXL_ECS_LOG_ENTRY_TYPE_MASK	GENMASK(1, 0)
> +#define	CXL_ECS_REALTIME_REPORT_CAP_MASK	BIT(0)
> +#define	CXL_ECS_THRESHOLD_COUNT_MASK	GENMASK(2, 0)
> +#define	CXL_ECS_MODE_MASK	BIT(3)

That name is a little generic. Maybe CXL_ECS_COUNT_MODE_MASK ?

> +#define	CXL_ECS_RESET_COUNTER_MASK	BIT(4)
> +
> +static const u16 ecs_supp_threshold[] = { 0, 0, 0, 256, 1024, 4096 };
> +
> +enum {
> +	ECS_LOG_ENTRY_TYPE_DRAM = 0x0,
> +	ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU = 0x1,
> +};
> +
> +enum {
> +	ECS_THRESHOLD_256 = 3,
> +	ECS_THRESHOLD_1024 = 4,
> +	ECS_THRESHOLD_4096 = 5,
> +};
Perhaps move this above the ecs_supp_threshold array and use
static const ecs_supp_threshold[] = {
	[ECS_THRESHOLD_256] = 256,
	[ECS_THRESHOLD_1024] = 1024,
	[ECS_THRESHOLD_4096] = 4096,
};
which will fill the zeros in for you. You don't care about them anyway
as they are undefined values.

> +
> +enum cxl_ecs_mode {
> +	ECS_MODE_COUNTS_ROWS = 0,
> +	ECS_MODE_COUNTS_CODEWORDS = 1,
> +};

> +
> +static int cxl_mem_ecs_set_attrs(struct device *dev, void *drv_data, int fru_id,
> +				 struct cxl_ecs_params *params, u8 param_type)
> +{
> +	struct cxl_ecs_context *cxl_ecs_ctx = drv_data;
> +	struct cxl_memdev *cxlmd = cxl_ecs_ctx->cxlmd;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_ecs_fru_rd_attrs *fru_rd_attrs;
> +	struct cxl_ecs_fru_wr_attrs *fru_wr_attrs;
> +	size_t rd_data_size, wr_data_size;
> +	u16 num_media_frus, count;
> +	size_t data_size;
> +	int ret;
> +
> +	num_media_frus = cxl_ecs_ctx->num_media_frus;
> +	rd_data_size = cxl_ecs_ctx->get_feat_size;
> +	wr_data_size = cxl_ecs_ctx->set_feat_size;
> +	struct cxl_ecs_rd_attrs *rd_attrs __free(kfree) =
> +				kmalloc(rd_data_size, GFP_KERNEL);
> +	if (!rd_attrs)
> +		return -ENOMEM;
> +
> +	data_size = cxl_get_feature(mds, cxl_ecs_uuid,
> +				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
> +				    rd_attrs, rd_data_size);
> +	if (!data_size)
> +		return -EIO;

blank line here as the next line isn't part of this allocate / check
errors block.

> +	struct cxl_ecs_wr_attrs *wr_attrs __free(kfree) =
> +					kmalloc(wr_data_size, GFP_KERNEL);
> +	if (!wr_attrs)
> +		return -ENOMEM;
> +
> +	/* Fill writable attributes from the current attributes read
CXL uses 
	/*
	 * Fill writable 
style for multiline comments.
 
> +	 * for all the media FRUs.
> +	 */



> +static int cxl_ecs_get_mode_counts_rows(struct device *dev, void *drv_data,
> +					int fru_id, u32 *val)
> +{
> +	struct cxl_ecs_params params;
> +	int ret;
> +
> +	ret = cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
> +	if (ret)
> +		return ret;
> +
> +	if (params.mode == ECS_MODE_COUNTS_ROWS)
> +		*val = 1;
> +	else
> +		*val = 0;
> +
> +	return 0;
> +}
> +
> +static int cxl_ecs_get_mode_counts_codewords(struct device *dev, void *drv_data,
> +					     int fru_id, u32 *val)
> +{
> +	struct cxl_ecs_params params;
> +	int ret;

This form is pretty common. Maybe worth some macros like
you have in the edac side of things?

> +
> +	ret = cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
> +	if (ret)
> +		return ret;
> +
> +	if (params.mode == ECS_MODE_COUNTS_CODEWORDS)
> +		*val = 1;
> +	else
> +		*val = 0;
> +
> +	return 0;
> +}


