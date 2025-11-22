Return-Path: <linux-edac+bounces-5505-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D8BC7C7DE
	for <lists+linux-edac@lfdr.de>; Sat, 22 Nov 2025 06:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9125A35A560
	for <lists+linux-edac@lfdr.de>; Sat, 22 Nov 2025 05:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B4A27B34F;
	Sat, 22 Nov 2025 05:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SJwdLMeF"
X-Original-To: linux-edac@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075F78C9C;
	Sat, 22 Nov 2025 05:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763788697; cv=none; b=bcWhLJuQhxIhO67Rn5ezzUBhyZLocVbciiZYEOxA4RKclcoCs0D5zFEz5qeYg6f78/15YDOT/Tqwhvudg4Z2+m6E1R4s2SfcyNRhf9kafrfaqD1t2zOyaVmikiSATvlVtI+I+xUrcWrtzOR3gsKOtfKO/+bKwhf4eVKsK7wvxOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763788697; c=relaxed/simple;
	bh=wAT8xGw54oXyIl0D5IXkk6rDDrwI1ll9MmjwHO0ui2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzXa1l/D88SgwMPktctrAOwIh+0NGKICD/1nTpNhVepOW3wJaeUcied6wyxH84DysMpRy+Yhvhd16dMf/vGXrzec4BEoQ4EFatzAY7PL6mamsww/hamHWOCuUscMli5kmZxehUsxkT9ktd3dnvrryIpPpBy+vaChccNx6Eq9uX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SJwdLMeF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=a21mFOrYW7EF2pPoO72JM91N95zDCsdN4gaOlTsjcgM=; b=SJwdLMeFBkF2KqNV6jfhdJ/TKL
	k19kD1CgRMJvJ9174C+g2EXK/WbSoyN0Vy1aLXajePZWlWWr7uaNxBRzt8koHeZ3JQkp6wxEEjSKv
	IEXa2504U+Zs2zGOXGzZttOK4QpBQqBX0CR9iT4ZLPe1bF3k2/TEx+U10GNEfmerqsEwheVMSuL8s
	JY0ZAKjiKOlYWhPliWGPChHFBpEgdmRWt8xTRdQGYH0jsqnCc479ZlXe0mh89iLLvgyqBlcTyyXX7
	4ojJYiUEKmA1fqd26Ym5WozMay98Oxus+y5hq7+ih6pabeas3AaYIGGrzIqSYiLzZFsRZhA1aMJ3w
	FDOCIYXA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMg0Y-00000009HED-3nNK;
	Sat, 22 Nov 2025 05:18:02 +0000
Message-ID: <4807417b-a8f7-47a3-b38a-94ea7bdbf775@infradead.org>
Date: Fri, 21 Nov 2025 21:18:01 -0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
To: shiju.jose@huawei.com, rafael@kernel.org, bp@alien8.de,
 akpm@linux-foundation.org, rppt@kernel.org, dferguson@amperecomputing.com,
 linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
 leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org
Cc: jonathan.cameron@huawei.com, linuxarm@huawei.com, rientjes@google.com,
 jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
 naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
 somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
 duenwen@google.com, gthelen@google.com, wschwartz@amperecomputing.com,
 wbs@os.amperecomputing.com, nifan.cxl@gmail.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
References: <20251121182825.237-1-shiju.jose@huawei.com>
 <20251121182825.237-2-shiju.jose@huawei.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251121182825.237-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/21/25 10:28 AM, shiju.jose@huawei.com wrote:
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ca00a5dbcf75..bfa9f3f4def5 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -293,6 +293,18 @@ config ACPI_CPPC_LIB
>  	  If your platform does not support CPPC in firmware,
>  	  leave this option disabled.
>  
> +config ACPI_RAS2
> +	bool "ACPI RAS2 driver"
> +	select AUXILIARY_BUS
> +	select MAILBOX
> +	select PCC
> +	depends on NUMA_KEEP_MEMINFO
> +	help
> +	  This driver adds support for RAS2 feature table provides interfaces
> +	  for platform RAS features, for eg. HW-based memory scrubbing.

	                   features, e.g., for HW-based

> +	  If your platform does not support RAS2 in firmware, leave this
> +	  option disabled.

-- 
~Randy


