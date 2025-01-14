Return-Path: <linux-edac+bounces-2898-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D955A1081A
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 14:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0871888B2D
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 13:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96387232449;
	Tue, 14 Jan 2025 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq4YIFNx"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645031A28D;
	Tue, 14 Jan 2025 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736862444; cv=none; b=CtmC6uBStyHWEiS9+KJXmR093efzy2bQ7Q7kZRuYG2RnI7KaawXzENDk4vDyRleGuYh0qiqjsPT2wrPTT9ckbEFVnvryxgk84dC2NuVfSokTwnwUuJAyz/9+KnihCkV57IDFYBrcm+1YvFo4sXG+TbyWcaYUQzPubzn7ITrZRPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736862444; c=relaxed/simple;
	bh=e72fpHGjY3D9f7LxRjXJmd4LWGSCP8u/02wYpWhOXTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dk3/NFLnSy63r4bC10yYvwsbKSXT+pBEi41u9kVsqP2dtqosbCE/X6dyU+dRDjQLhQfhEUi8Mcg3Ih82M+XF8AQIFUAVjAe7M2HddGrCqkDShlXNu5Jn8zqMlxN9/x0xjRw4TGZU3+5eykcq47W4G9R2ucFmpvaPaeSo2FED5Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq4YIFNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802D5C4CEDD;
	Tue, 14 Jan 2025 13:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736862444;
	bh=e72fpHGjY3D9f7LxRjXJmd4LWGSCP8u/02wYpWhOXTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zq4YIFNx3IvUdetyN3iQdwJWxkgJhfu/4+1GklYZR2AMfv0TNI1dtH8+lBmlhZZjO
	 0b4aiOGO94wFWqdFE0KfuYCiSX4NR+lP5UrS/eqYuDzkFYZh1OEm0KwuZVLFX7rY5T
	 /FIvKZ3/yKqu2GORgWMqbfk3Q/ZUfux0VPyuW33hdztF5ZzEOJWB/qSXOGtiWEOQpj
	 s2iF+P1qnvaKXG5wzfAA0RT2UhzVp84fYo0HRf1tKf3H8nzuqhaRiNaqSiHUhKGfwU
	 4YdIiN7k5LM4T9kJsqFJtZUUUemKDtCQ/bV+Mrxqvzn+Z0HmzX4u++RGR+KRWzeL2N
	 fQlDiENdRbErQ==
Date: Tue, 14 Jan 2025 14:47:12 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: <shiju.jose@huawei.com>
Cc: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
 <rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
 <dan.j.williams@intel.com>, <dave@stgolabs.net>,
 <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
 <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
 <ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
 <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
 <jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
 <naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
 <somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
 <duenwen@google.com>, <gthelen@google.com>,
 <wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
 <wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>,
 <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
 <roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
 <wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250114144712.49cd98f2@foz.lan>
In-Reply-To: <20250106121017.1620-5-shiju.jose@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-5-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 6 Jan 2025 12:10:00 +0000
<shiju.jose@huawei.com> escreveu:

> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/repair_function
> +Date:		Jan 2025
> +KernelVersion:	6.14
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) Memory repair function type. For eg. post package repair,
> +		memory sparing etc.
> +		EDAC_SOFT_PPR - Soft post package repair
> +		EDAC_HARD_PPR - Hard post package repair
> +		EDAC_CACHELINE_MEM_SPARING - Cacheline memory sparing
> +		EDAC_ROW_MEM_SPARING - Row memory sparing
> +		EDAC_BANK_MEM_SPARING - Bank memory sparing
> +		EDAC_RANK_MEM_SPARING - Rank memory sparing
> +		All other values are reserved.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/persist_mode
> +Date:		Jan 2025
> +KernelVersion:	6.14
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Read/Write the current persist repair mode set for a
> +		repair function. Persist repair modes supported in the
> +		device, based on the memory repair function is temporary
> +		or permanent and is lost with a power cycle.
> +		EDAC_MEM_REPAIR_SOFT - Soft repair function (temporary repair).
> +		EDAC_MEM_REPAIR_HARD - Hard memory repair function (permanent repair).
> +		All other values are reserved.
> +

After re-reading some things, I suspect that the above can be simplified
a little bit by folding soft/hard PPR into a single element at
/repair_function, and letting it clearer that persist_mode is valid only
for PPR (I think this is the case, right?), e.g. something like:

	What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/repair_function
	...
	Description:
			(RO) Memory repair function type. For e.g. post package repair,
			memory sparing etc. Valid values are:

			- ppr - post package repair.
			  Please define its mode via
			  /sys/bus/edac/devices/<dev-name>/mem_repairX/persist_mode
			- cacheline-sparing - Cacheline memory sparing
			- row-sparing - Row memory sparing
			- bank-sparing - Bank memory sparing
			- rank-sparing - Rank memory sparing
			- All other values are reserved.

and define persist_mode in a different way:

	What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/ppr_persist_mode
	...
	Description:
		(RW) Read/Write the current persist repair (PPR) mode set for a
		post package repair function. Persist repair modes supported 
		in the device, based on the memory repair function is temporary
		or permanent and is lost with a power cycle. Valid values are:

		- repair-soft - Soft PPR function (temporary repair).
		- repair-hard - Hard memory repair function (permanent repair).
		- All other values are reserved.

Thanks,
Mauro

