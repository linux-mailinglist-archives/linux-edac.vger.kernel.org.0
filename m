Return-Path: <linux-edac+bounces-3291-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2797A55C99
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 02:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45311897163
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 01:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156F482899;
	Fri,  7 Mar 2025 01:02:04 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A697E28FF;
	Fri,  7 Mar 2025 01:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309324; cv=none; b=kXsmnaBuEWp9Aa0Rn44pRwSVgFcYf95Xe2sYSFpAy25z/FK/KaBp4fnotJbsjug+J+6PvV4gUwJf2yGoQX0yBv6v9NONVQP6nwhZTirf0f+b+XJTUpRX8Ust7P//iM9PmG45s9DR1OicriyexM3r8rod3oyQTvwvdEUbIXkMqfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309324; c=relaxed/simple;
	bh=xkHJgHv1hq6vVqHXKJBL8m/9XUZ+TOSka++iVqVosPs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6fAs0d4YhrhxenNuWGmxniDaIbVBJjYsvGEz4lRUqYh8xnVz3uTf9s8zqr0NP8lRg0nwt8ENX1kbHovKD2O0w5jUQeFDcblFNQWt7EIyYul6gPUJcVTIhvcaVdJD31i8CtUBYbPOI8zrZt5Zh1Uen8cMPdvXv2vjr9m2etHCog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z87Gz49BKz6K8Rw;
	Fri,  7 Mar 2025 08:59:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A7DF1403D2;
	Fri,  7 Mar 2025 09:01:59 +0800 (CST)
Received: from localhost (10.48.43.65) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Mar
 2025 02:01:48 +0100
Date: Fri, 7 Mar 2025 09:01:43 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <david@redhat.com>,
	<Vilas.Sridharan@amd.com>, <linux-edac@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 3/8] cxl/memfeature: Add CXL memory device ECS control
 feature
Message-ID: <20250307090143.00003e3f@huawei.com>
In-Reply-To: <20250227223816.2036-4-shiju.jose@huawei.com>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
	<20250227223816.2036-4-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 27 Feb 2025 22:38:10 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.2 section 8.2.10.9.11.2 describes the DDR5 ECS (Error Check
> Scrub) control feature.
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts.
> 
> The ECS control allows the requester to change the log entry type, the ECS
> threshold count (provided the request falls within the limits specified in
> DDR5 mode registers), switch between codeword mode and row count mode, and
> reset the ECS counter.
> 
> Register with EDAC device driver, which retrieves the ECS attribute
> descriptors from the EDAC ECS and exposes the ECS control attributes to
> userspace via sysfs. For example, the ECS control for the memory media FRU0
> in CXL mem0 device is located at /sys/bus/edac/devices/cxl_mem0/ecs_fru0/
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Hmm. No idea why I didn't tag this before. It's been fine for ages.

One really small thing if respinning for some other reason,
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> +static int cxl_mem_ecs_set_attrs(struct device *dev,
> +				 struct cxl_ecs_context *cxl_ecs_ctx,
> +				 int fru_id, struct cxl_ecs_params *params,
> +				 u8 param_type)
> +{
...
> +
> +	/*
> +	 * Fill attribute to be set for the media FRU

Trivial but could be a single line comment.

> +	 */
> +	ecs_config = le16_to_cpu(fru_rd_attrs[fru_id].ecs_config);
> +	switch (param_type) {
> +	case CXL_ECS_PARAM_LOG_ENTRY_TYPE:


