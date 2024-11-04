Return-Path: <linux-edac+bounces-2417-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E99BAC6E
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 07:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F17D1C211DE
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 06:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF9418DF85;
	Mon,  4 Nov 2024 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gxWmUGjW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA3F249E5;
	Mon,  4 Nov 2024 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730701018; cv=none; b=nlR3rYrjuJMZMTj4WspmRY63FNrvZ7b9gMwgrIAvXzoOgLF5vwD7mTXCk2W7xpa+OTznvCN/7/1YNclobfoypbrPQ525fOG5ksgSlcQxVO/zXd7BfbAUF5QLnVxXV5owBSAXqrvXjxbCHEbh8qOzTN/mOmirKGX4d64YkUra00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730701018; c=relaxed/simple;
	bh=BLImiBRHSGgad4OQdMMohR8GkyUm0oyAVKcAE5I/FdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGkSxgUE8DbEnpO1FRewflKCXZ8l5F23CtMmCvRnxQMbnHiBWw7vo1hM7tuSx4qzN+b9s5m3qHmjGY+hkCDfIrpzxSDHpYT+aHGIhTWAhCGdgkLkwAJid2HuALB1TyRVHMkWqA9bUxLnCfVLACE2fW0HwThEMdaB0Y4dbkFDEUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gxWmUGjW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5122E40E0261;
	Mon,  4 Nov 2024 06:16:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zBz5o0b0UpVc; Mon,  4 Nov 2024 06:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730701006; bh=TToQVmmc3nat3d+fha3HdsqcfrJIbah1c3Z2m4JRYVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxWmUGjWfURLHCQKAnNxXbYnEv7N8fZ0JMD/DFaCwgNtVximKzI2QHqUhUjXqd7AH
	 1XAxVhPBIs4ExVxLbj1fyseA4YpDCdFfJ/sOUqucIt1h7w9qtvag1pj4YTiGj/6qAw
	 SSYsBt+HTYYkURJFfZdPh4IR19Avp1dvnRdHkxV6hFKQ7UYp0eiFkB9R5Ny9slZLWi
	 sW7WodZtvdoAVwF9u8X93ieUw+CbtdeftXGnX12KX5Usi5WH7DW/RsPGpI+BLJn/jM
	 ESJTUh0cNSJiMHLFsr4fEEAs0HRgCLVxt6ejsovAALp3NAFbZkxhGcNNBnwZd3Bj5v
	 d9qudFSOSpLpFE/FoWsxzduSOalAVIhpJNXNAOwymSoPNuiU6t06jBCAwsv17ql8Sv
	 FWBDWaHKtcNhqp/FSmJka/EylDN6789ysHQOBhs3ZHYCX/k4xFnE9JzCdRdamhpV+b
	 kRV01XKDyyDDh8+rfsZAiyrSQeE4n3SNs+RklTOfzx6ME0BljCLfXgGSA6NiMI1R8g
	 FFR1tUBxWKb/+KITgGjTvGo30GK1e0kLoIOzzhdxc8Kdcf3XONBp1BFK5gNMSrFg/Y
	 L18wEXh2Pz75lqVSljq0ckfB1BVjfAZTJ3k8NbWpbqailEFCundYXT2vAIwq9Cqu+A
	 RhuQfczW5xeKL9dWnOvk08OM=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4ECA540E0220;
	Mon,  4 Nov 2024 06:16:00 +0000 (UTC)
Date: Mon, 4 Nov 2024 07:15:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, gregkh@linuxfoundation.org,
	sudeep.holla@arm.com, jassisinghbrar@gmail.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, david@redhat.com,
	Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	linuxarm@huawei.com
Subject: Re: [PATCH v15 11/15] EDAC: Add memory repair control feature
Message-ID: <20241104061554.GOZyhmmo9melwI0c6q@fat_crate.local>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
 <20241101091735.1465-12-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101091735.1465-12-shiju.jose@huawei.com>

On Fri, Nov 01, 2024 at 09:17:29AM +0000, shiju.jose@huawei.com wrote:
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
> The common memory repair control interface abstracts the control of
> arbitrary memory repair functionality into a standardized set of functions.
> The sysfs memory repair attribute nodes are only available if the client
> driver has implemented the corresponding attribute callback function and
> provided operations to the EDAC device driver during registration.

What is the valid use case for this thing?

> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  .../ABI/testing/sysfs-edac-memory-repair      | 168 ++++++++
>  drivers/edac/Makefile                         |   2 +-
>  drivers/edac/edac_device.c                    |  32 ++
>  drivers/edac/mem_repair.c                     | 367 ++++++++++++++++++
>  include/linux/edac.h                          |  87 +++++
>  5 files changed, 655 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-edac-memory-repair
>  create mode 100755 drivers/edac/mem_repair.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-edac-memory-repair b/Documentation/ABI/testing/sysfs-edac-memory-repair
> new file mode 100644
> index 000000000000..393206b8d418
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-edac-memory-repair
> @@ -0,0 +1,168 @@
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		The sysfs EDAC bus devices /<dev-name>/mem_repairX subdirectory
> +		pertains to the memory media repair features control, such as
> +		PPR (Post Package Repair), memory sparing etc, where<dev-name>
> +		directory corresponds to a device registered with the EDAC
> +		device driver for the memory repair features.
> +		Memory sparing is a repair function that replaces a portion
> +		of memory (spared memory) with a portion of functional memory.

a portion of *faulty* memory - this is the most important aspect here. You
want to explain why you're doing the replacing in the first place. Memory
which is going bad.

This first paragraph is a good explanation:

https://pubs.lenovo.com/sr850/memory_module_installation_order_sparing

the first hit in a web search here.

> +		Memory sparing has cacheline/row/bank/rank sparing
> +		granularities.
> +		The sysfs attributes nodes for a repair feature are only
> +		present if the parent driver has implemented the corresponding
> +		attr callback function and provided the necessary operations
> +		to the EDAC device driver during registration.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/repair_type
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) Type of the repair instance. For eg. sPPR, hPPR, cacheline/

WTH is a "repair instance"? Can we pls make this human readable and not some
crap spec language?

> +		row/bank/rank memory sparing etc.
> +		0 - Soft PPR(sPPR)
> +		1 - Hard PPR(hPPR)

Write out those abbreviations.

> +		2 - Cacheline memory sparing
> +		3 - Row memory sparing
> +		4 - Bank memory sparing
> +		5 - Rank memory sparing
> +		All other values are reserved.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/persist_mode_avail
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) Persist repair modes supported in the device.
> +		0 - Soft PPR(sPPR)/soft memory sparing (temporary repair).
> +		1 - Hard PPR(hPPR)/hard memory sparing (permanent repair).

Those need a longer, user-friendly explanation.

> +		All other values are reserved.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/persist_mode
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Current persist repair mode.
> +		0 - Soft PPR(sPPR)/soft memory sparing (temporary repair).
> +		1 - Hard PPR(hPPR)/hard memory sparing (permanent repair).
> +		All other values are reserved.

You can kill persist_mode_avail by making this persist_mode return the
available modes by reading it.

> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/dpa_support
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) True if supports DPA for a repair operation.
> +		E.g. PPR, memory sparing.

DPA? What?!

Why is *that* a sysfs file?

> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/repair_safe_when_in_use
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) True if memory media is accessible and data is retained
> +		during the memory repair operation.

Ditto.

> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/hpa
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) HPA (Host Physical Address) for memory repair.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/dpa
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) DPA (Device Physical Address) for memory repair.

Both need more explanation.

> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/nibble_mask
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Nibble mask for memory repair.

What is that?

> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/bank_group
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Memory bank group for repair.

Ditto.

> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/bank
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Memory bank for memory repair.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/rank
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Memory rank for repair.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/row
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Row for memory repair.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/column
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Column for memory repair.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/channel
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Channel for memory repair.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/sub_channel
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Sub-channel for memory repair.

All those above: need better explanation and need a way of finding out how
many of those are in each device so that the user can actually give a sensible
value there.

> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/query
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(WO) Query whether the repair operation is supported for the
> +		memory attributes set. Return failure if resources are
> +		not available to perform repair.
> +		1 - issue query.
> +		All other values are reserved.

What?!

If anything this should be a "status".

> +
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/repair
> +Date:		Jan 2025
> +KernelVersion:	6.13
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(WO) Start the memory repair operation for the memory attributes
> +		set. Return failure if resources are not available to
> +		perform repair.
> +		1 - issue repair operation.
> +		All other values are reserved.
> +		In some states of system configuration (e.g. before address
> +		decoders have been configured), memory devices (e.g. CXL)
> +		may not have an active mapping in the main host address
> +		physical address map. As such, the memory to repair must be
> +		identified by a device specific physical addressing scheme
> +		using a DPA. The DPA to use will be presented in related
> +		error records.

Yeh, this needs to be part of the interface and not hidden in some obscure
doc.

The whole repairing control needs to be explained somewhere so that the user
can make an informed decision and *actually* use this thing and not break out
a sweat when faced with those gazillion sysfs nodes which don't tell her
a whole lot.

And look into making that interface more user-friendly.

Thx.


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

