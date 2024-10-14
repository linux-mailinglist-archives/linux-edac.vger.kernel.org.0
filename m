Return-Path: <linux-edac+bounces-2041-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB6199CCED
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 16:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDA61C20CAC
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 14:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DF11AC420;
	Mon, 14 Oct 2024 14:26:33 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242721AB512;
	Mon, 14 Oct 2024 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915993; cv=none; b=GQ7Jtc2FWw2A5hkKg9gYu7YxWH9HLo8dutSMWCvoZ/xHkMU1aEelhgtCIOg5OFcp5LYHTOjgZUXHa+K6RaZIf9Gk9Y3SDFuP53ItdXTAp+zptrul6XNkQJV3ekLYNJH9BIH3jYjJvzo/LdNMgWj51W45rQqEzK/cbbSa81+QDWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915993; c=relaxed/simple;
	bh=mLDhkk/oWc8jzbsrGOzq+yJ90yzYp9UwZOZz7ROfGXc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKebRuRuhA166IQe6oNQSCuVFsetVVsxUzv1AppSNwy/MFYKLUvgGdg5FAAoUWJXuoA8INaJ8H2YYwaWwKVvfWIrkxgry1CYD0Azbg+C7vcrNP81uuQbjVqdL4prfV/SiC2635XiCH+J25H4SjhPldcEiJVwQHZEyRD9rropY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRzvF2rzKz6L75K;
	Mon, 14 Oct 2024 22:22:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E6521400CA;
	Mon, 14 Oct 2024 22:26:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 16:26:27 +0200
Date: Mon, 14 Oct 2024 15:26:25 +0100
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
Subject: Re: [PATCH v13 02/18] EDAC: Add scrub control feature
Message-ID: <20241014152625.00003c62@Huawei.com>
In-Reply-To: <20241009124120.1124-3-shiju.jose@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-3-shiju.jose@huawei.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 9 Oct 2024 13:41:03 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add generic EDAC scrub control in order to control the memory scrubbers
> in the system. The device with scrub feature registers with EDAC device
> driver, which retrieves the scrub descriptor from EDAC scrub driver and
> expose the sysfs scrub control attributes for a scrub instance to userspace
> in /sys/bus/edac/devices/<dev-name>/scrubX/.
> 
> The common sysfs scrub control interface abstracts the control of an
> arbitrary scrubbing functionality to a common set of functions.
> The sysfs scrub attribute nodes would be present only if the client driver
> has implemented the corresponding attribute callback function and passed
> in ops to the EDAC device driver during registration.
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

One follow on comment. Otherwise LGTM and the new macros definitely help on
reducing code. (I'm not normally fan of macros at the function
level, but here I'm convinced)

>  
> @@ -657,17 +686,19 @@ int edac_dev_register(struct device *parent, char *name,
>  
>  	ret = dev_set_name(&ctx->dev, name);
>  	if (ret)
> -		goto groups_free;
> +		goto data_mem_free;
>  
>  	ret = device_register(&ctx->dev);
>  	if (ret) {
>  		put_device(&ctx->dev);
> -		goto groups_free;
> +		goto data_mem_free;
As in previous patch I think this goto is incorrect and should be dropped. 
>  		return ret;
>  	}
>  
>  	return devm_add_action_or_reset(parent, edac_dev_unreg, &ctx->dev);
>  
> +data_mem_free:
> +	kfree(ctx->scrub);
>  groups_free:
>  	kfree(ras_attr_groups);
>  ctx_free:


