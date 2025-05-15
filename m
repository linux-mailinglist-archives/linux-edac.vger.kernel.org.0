Return-Path: <linux-edac+bounces-3923-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEC2AB8DA7
	for <lists+linux-edac@lfdr.de>; Thu, 15 May 2025 19:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703111BC43B1
	for <lists+linux-edac@lfdr.de>; Thu, 15 May 2025 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A2F258CD8;
	Thu, 15 May 2025 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NJf6lDcc"
X-Original-To: linux-edac@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E107B1DDD1;
	Thu, 15 May 2025 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329822; cv=none; b=iwKg/12tG+jucp3qrWJavN1ctVD145udbieUBlZBdvC5dX+YM9IKIkSYqKccfj9teKrZTsAjOgkRv1Gkbe4+MbD+WAZ6lZxNLlr2KTka2oxc3os+bDGy0Xapgwj5xLv7Gb8hHD1YSNbpjcvkSWfOslDLSjtl4LJ6HsWKNRtYRWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329822; c=relaxed/simple;
	bh=cN0o+cjEAmcsbf3emVfh0/+2GXrsKo2GngcXznfkrF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqvzMvNKC9PrsP3g1/3gQgrZ2yvaovoI9NnVU1ZemNHoz12p5HmOBt4o1Lcz2/SfMS0aA2/YF23yXWfS+/sj4lyRlpAv4UslM8UEqskZPGjVEeZp8Gp02Y/z1NUbLkgC9AflhRe2NgKaxk3fbmQz61Z5ez8xgFb61lzs7Ukw4BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NJf6lDcc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GTCT7BSmAZqTWnu91btoJaKscnIU2IMk9i6RJnUQ9pA=; b=NJf6lDccfxPbXwIG7n6eC04DiW
	RyLMA0kreSdpdLkcH1h85edPITzAkQFciyzItPFtP9VUj06nYCn/p9f+d/NMib8uhUZEI3pGF7LSh
	DFNt4PdMWTNruOqjvbCvDkBiGlovAWXyoKG3ctism7pETo82x0ZQ9g1s5b5x9q3R0CPg6z/+OUY1N
	SQpttZFyildt5AvqjgV9ecypb9qULP7kFPMHawM92uYZqbSqTSdeEpVW+X6qQFA5M+1j5cgEBzB9M
	sf93EsvXMTRCrX2/aX3HbJMf+vkdXwzTXGSZJF96oHfzF/dCcSP47//5no0edPvKccFQFahL34/8R
	NOWHxT9w==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uFcIy-0000000HVi1-2R7x;
	Thu, 15 May 2025 17:23:36 +0000
Message-ID: <86282fa2-3248-44bc-835e-4121214d6992@infradead.org>
Date: Thu, 15 May 2025 10:23:31 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] cxl/edac: Add CXL memory device soft PPR control
 feature
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 dave@stgolabs.net, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com
Cc: linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, bp@alien8.de,
 tony.luck@intel.com, lenb@kernel.org, Yazen.Ghannam@amd.com,
 mchehab@kernel.org, nifan.cxl@gmail.com, linuxarm@huawei.com,
 tanxiaofei@huawei.com, prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
References: <20250515115927.772-1-shiju.jose@huawei.com>
 <20250515115927.772-9-shiju.jose@huawei.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250515115927.772-9-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/25 4:59 AM, shiju.jose@huawei.com wrote:
> diff --git a/Documentation/edac/memory_repair.rst b/Documentation/edac/memory_repair.rst
> index 5b1cd8297442..3a3fc11b8fea 100644
> --- a/Documentation/edac/memory_repair.rst
> +++ b/Documentation/edac/memory_repair.rst
> @@ -138,5 +138,15 @@ CXL device to perform a repair operation on its media. For example, a CXL
>  device with DRAM components that support memory sparing features may
>  implement sparing maintenance operations.
>  
> +2. CXL memory Soft Post Package Repair (sPPR)
> +
> +Post Package Repair (PPR) maintenance operations may be supported by CXL
> +devices that implement CXL.mem protocol. A PPR maintenance operation
> +requests the CXL device to perform a repair operation on its media.
> +For example, a CXL device with DRAM components that support PPR features
> +may implement PPR Maintenance operations. Soft PPR (sPPR), is a temporary

  no comma:                                                 ^

> +row repair. Soft PPR may be faster, but the repair is lost with a power
> +cycle.
> +
>  Sysfs files for memory repair are documented in
>  `Documentation/ABI/testing/sysfs-edac-memory-repair

-- 
~Randy


