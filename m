Return-Path: <linux-edac+bounces-3285-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B05A54663
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 10:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03863AB3D1
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 09:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B89D201270;
	Thu,  6 Mar 2025 09:32:41 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609E56FC3;
	Thu,  6 Mar 2025 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253561; cv=none; b=p4Ya0s4JTkJg3nn074gc3Xlo5HyvFBH6V2IYBnIwhj03wF/J8e7BDsfUHWLiGZJ0XliaxtI4Ih8AQtpC+XC+Xk4L6gnSZ13sEkal2IFpnG1GjDvbN7TWwVZy9M8XmmTu0pae9wvtF/Q5XzlyddK4Gr5gCUuXtkQijkBRCuk8cvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253561; c=relaxed/simple;
	bh=iuqF/E5A0tvcLhqTvZPeLcJknYpnsMybrIO8ZXwglBc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXGd0w5OJgoFB0Pf3jCRcbFVEa6PIe37Wida3lTKXkHOBocJ1OIWDwEPXF4E5o1/L76FFLbra4EARsdBQnEq+MxA/7l8nbwrSM/kBs9bDhWX5s1cFTu0O3I3sal8imcwmRCD9dEBB/ZohgQfXwlfWolXt+j179YrUPYrONjEOXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z7kcN4T2yz67QRR;
	Thu,  6 Mar 2025 17:28:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A431C140A70;
	Thu,  6 Mar 2025 17:32:29 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Mar
 2025 10:32:18 +0100
Date: Thu, 6 Mar 2025 17:32:14 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<bp@alien8.de>, <tony.luck@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 3/3] ras: mem: Add memory ACPI RAS2 driver
Message-ID: <20250306173214.0000204e@huawei.com>
In-Reply-To: <20250305180225.1226-4-shiju.jose@huawei.com>
References: <20250305180225.1226-1-shiju.jose@huawei.com>
	<20250305180225.1226-4-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 5 Mar 2025 18:02:24 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Memory ACPI RAS2 auxiliary driver binds to the auxiliary device
> add by the ACPI RAS2 table parser.
> 
> Driver uses a PCC subspace for communicating with the ACPI compliant
> platform.
> 
> Device with ACPI RAS2 scrub feature registers with EDAC device driver,
> which retrieves the scrub descriptor from EDAC scrub and exposes
> the scrub control attributes for RAS2 scrub instance to userspace in
> /sys/bus/edac/devices/acpi_ras_mem0/scrubX/.
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>



> diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
> index daab929cdba1..fc8dcbd13f91 100644
> --- a/Documentation/edac/scrub.rst
> +++ b/Documentation/edac/scrub.rst
> @@ -264,3 +264,76 @@ Sysfs files are documented in

...

> +1.2.4. Program background scrubbing for RAS2 device to repeat in every 21600 seconds (quarter of a day).

wrap to 80 chars.  I think that is fine for titles in sphinx.

> +
> +# echo 21600 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/current_cycle_duration
> +
> +1.2.5. Start 'background scrubbing'.
> +
> +# echo 1 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/enable_background



> diff --git a/drivers/ras/acpi_ras2.c b/drivers/ras/acpi_ras2.c
> new file mode 100644
> index 000000000000..2f9317aa7b81
> --- /dev/null
> +++ b/drivers/ras/acpi_ras2.c
> @@ -0,0 +1,391 @@


> +struct acpi_ras2_ps_shared_mem {
> +	struct acpi_ras2_shmem common;
> +	struct acpi_ras2_patrol_scrub_param params;
> +};

...

> +static int ras2_update_patrol_scrub_params_cache(struct ras2_mem_ctx *ras2_ctx)
> +{
> +	struct acpi_ras2_ps_shared_mem __iomem *ps_sm =
> +		(void *)ras2_ctx->comm_addr;

Would a container_of() be better here given the type cast is doing
that with the assumption of it being first element of ps_shared_mem.
Same in other places, so maybe a macro.

> +	int ret;
> +
> +	ps_sm->common.set_caps[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
> +	ps_sm->params.cmd = RAS2_GET_PATROL_PARAMETERS;
...


> +
> +static int ras2_hw_scrub_set_enabled_bg(struct device *dev, void *drv_data, bool enable)
> +{
> +	struct ras2_mem_ctx *ras2_ctx = drv_data;
> +	struct acpi_ras2_ps_shared_mem __iomem *ps_sm =
> +		(void *)ras2_ctx->comm_addr;

As above, maybe container_of appropriate as we have
a definition of what we are casting it to that has the thing
we are casting from as first element.

> +	bool running;
> +	int ret;
> +

...

> +
> +static int ras2_probe(struct auxiliary_device *auxdev,
> +		      const struct auxiliary_device_id *id)
> +{
> +	struct ras2_mem_ctx *ras2_ctx = container_of(auxdev, struct ras2_mem_ctx, adev);
> +	struct edac_dev_feature ras_features[RAS2_DEV_NUM_RAS_FEATURES];
Given we only have 1 RAS2 feature I'd be tempted to leave
making this flexible for some future series that adds a second one.
So maybe just have a single feature rather than array of 1.
> +	char scrub_name[RAS2_SCRUB_NAME_LEN];
> +	int num_ras_features = 0;

With change below this isn't needed.

> +	int ret;
> +
> +	if (!ras2_is_patrol_scrub_support(ras2_ctx))
> +		return -EOPNOTSUPP;
> +
> +	ret = ras2_update_patrol_scrub_params_cache(ras2_ctx);
> +	if (ret)
> +		return ret;
> +
> +	snprintf(scrub_name, sizeof(scrub_name), "acpi_ras_mem%d",
> +		 ras2_ctx->id);
> +
> +	ras_features[num_ras_features].ft_type = RAS_FEAT_SCRUB;
> +	ras_features[num_ras_features].instance = ras2_ctx->instance;
> +	ras_features[num_ras_features].scrub_ops = &ras2_scrub_ops;
> +	ras_features[num_ras_features].ctx = ras2_ctx;
> +	num_ras_features++;
As above, can also just assume this is 1 becasue it always is.
> +
> +	return edac_dev_register(&auxdev->dev, scrub_name, NULL,
> +				 num_ras_features, ras_features);
here pass in &ras_feature after making it not be an array.

> +}


