Return-Path: <linux-edac+bounces-2900-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325D6A1093A
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 15:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D59F7A2701
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 14:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCC81474A5;
	Tue, 14 Jan 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVoqCHDR"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC71428F3;
	Tue, 14 Jan 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864789; cv=none; b=VRzwNMR4plG1MYNSkIMNG2WJjy2bUAi44W703DNTX+gliUYOJ6Yl/MMmsTkpcDT9lfrYndlskNpfDpUYpe8y+2kAf57vwxlEy4ZEvmSdBPnrJQQ5rgcbjS/FCmy8ec9+8a36dtyAPSaZ3Qz7nqH3rm6+UzN7PdGMIdLqxnbteOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864789; c=relaxed/simple;
	bh=6lPeIc8Kx8uL1jk1fEfVYaiiW/b6yM7rLPWmuu7ZTrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzckjGzBLnC9hwKJ9nssCuRgcfrqnwgO38BZUmPO5Zw4joH6h0HtQAuHkrEoz+Rnr+pDft8ADZETqxXqS4PUlcoc1Plh/ZmwuxgCRJkmSoyTitamkiMD0Hr/A27zSXVujv+4eIW2ZUWaCBCjPCv+Hmq2Scse7yRBsam6g5Oq+bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVoqCHDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9C6C4CEDD;
	Tue, 14 Jan 2025 14:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736864788;
	bh=6lPeIc8Kx8uL1jk1fEfVYaiiW/b6yM7rLPWmuu7ZTrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rVoqCHDR2OS2gurGtQV8Sny/VzC3eahz+N7IHkK416GzX8lOUSndcfHuw1aqLUK0p
	 iQ2sFrtsSlDOeREcQcWfQQtN1mxIDzhKjMbN/ANsAaAlv4Z0ESwfuxNXxLpDSlMmmm
	 Gy47zbS5mEIPOABkeU91/4szqfTHMoio1PBtKYsWQD/A+kmo2yjIu0gkDiMX22pCuk
	 4HDe6PWExShJUqy5PkLL1S0Gw4v3j7X0ZQXcLJDbqMtjnNiBmFiwIBP24m1PmVATi1
	 eB4KKqVDwFijXh0FsU7uxqS3XQdKY7D1hZCreG5XZBiJYRrNcgavEy+bJjuvdnCCp9
	 l+hMv9MzfQuyw==
Date: Tue, 14 Jan 2025 15:26:17 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "Jonathan Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
 <dave.jiang@intel.com>, "alison.schofield@intel.com"
 <alison.schofield@intel.com>, "vishal.l.verma@intel.com"
 <vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
 <Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
 "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
 <rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
 "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
 <naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
 "jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
 <somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
 "pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
 <duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
 "wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
 "dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
 "wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
 "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
 <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
 <kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
 Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250114152617.14eb41b5@foz.lan>
In-Reply-To: <df8b3c3bffd24e1e8eb05b2ec53b3c58@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-5-shiju.jose@huawei.com>
	<20250114124740.2b311cd1@foz.lan>
	<df8b3c3bffd24e1e8eb05b2ec53b3c58@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 14 Jan 2025 12:31:44 +0000
Shiju Jose <shiju.jose@huawei.com> escreveu:

> Hi Mauro,
> 
> Thanks for the comments.
> 
> >-----Original Message-----
> >From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >Sent: 14 January 2025 11:48
> >To: Shiju Jose <shiju.jose@huawei.com>
> >Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
> >acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> >bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
> >mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
> >Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
> >alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
> >david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
> >Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
> >Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
> >naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
> >somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
> >duenwen@google.com; gthelen@google.com;
> >wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
> >wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
> ><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
> >Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
> >wanghuiqiang <wanghuiqiang@huawei.com>; Linuxarm
> ><linuxarm@huawei.com>
> >Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
> >
> >Em Mon, 6 Jan 2025 12:10:00 +0000
> ><shiju.jose@huawei.com> escreveu:
> >  
> >> From: Shiju Jose <shiju.jose@huawei.com>
> >>
> >> Add a generic EDAC memory repair control driver to manage memory repairs
> >> in the system, such as CXL Post Package Repair (PPR) and CXL memory sparing
> >> features.
> >>
> >> For example, a CXL device with DRAM components that support PPR features
> >> may implement PPR maintenance operations. DRAM components may support  
> >two  
> >> types of PPR, hard PPR, for a permanent row repair, and soft PPR,  for a
> >> temporary row repair. Soft PPR is much faster than hard PPR, but the repair
> >> is lost with a power cycle.
> >> Similarly a CXL memory device may support soft and hard memory sparing at
> >> cacheline, row, bank and rank granularities. Memory sparing is defined as
> >> a repair function that replaces a portion of memory with a portion of
> >> functional memory at that same granularity.
> >> When a CXL device detects an error in a memory, it may report the host of
> >> the need for a repair maintenance operation by using an event record where
> >> the "maintenance needed" flag is set. The event records contains the device
> >> physical address(DPA) and other attributes of the memory to repair (such as
> >> channel, sub-channel, bank group, bank, rank, row, column etc). The kernel
> >> will report the corresponding CXL general media or DRAM trace event to
> >> userspace, and userspace tools (e.g. rasdaemon) will initiate a repair
> >> operation in response to the device request via the sysfs repair control.
> >>
> >> Device with memory repair features registers with EDAC device driver,
> >> which retrieves memory repair descriptor from EDAC memory repair driver
> >> and exposes the sysfs repair control attributes to userspace in
> >> /sys/bus/edac/devices/<dev-name>/mem_repairX/.
> >>
> >> The common memory repair control interface abstracts the control of
> >> arbitrary memory repair functionality into a standardized set of functions.
> >> The sysfs memory repair attribute nodes are only available if the client
> >> driver has implemented the corresponding attribute callback function and
> >> provided operations to the EDAC device driver during registration.
> >>
> >> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> >> ---
> >>  .../ABI/testing/sysfs-edac-memory-repair      | 244 +++++++++
> >>  Documentation/edac/features.rst               |   3 +
> >>  Documentation/edac/index.rst                  |   1 +
> >>  Documentation/edac/memory_repair.rst          | 101 ++++
> >>  drivers/edac/Makefile                         |   2 +-
> >>  drivers/edac/edac_device.c                    |  33 ++
> >>  drivers/edac/mem_repair.c                     | 492 ++++++++++++++++++
> >>  include/linux/edac.h                          | 139 +++++
> >>  8 files changed, 1014 insertions(+), 1 deletion(-)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-edac-memory-repair
> >>  create mode 100644 Documentation/edac/memory_repair.rst
> >>  create mode 100755 drivers/edac/mem_repair.c
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-edac-memory-repair  
> >b/Documentation/ABI/testing/sysfs-edac-memory-repair  
> >> new file mode 100644
> >> index 000000000000..e9268f3780ed
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-edac-memory-repair
> >> @@ -0,0 +1,244 @@
> >> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX
> >> +Date:		Jan 2025
> >> +KernelVersion:	6.14
> >> +Contact:	linux-edac@vger.kernel.org
> >> +Description:
> >> +		The sysfs EDAC bus devices /<dev-name>/mem_repairX  
> >subdirectory  
> >> +		pertains to the memory media repair features control, such as
> >> +		PPR (Post Package Repair), memory sparing etc, where<dev-
> >name>
> >> +		directory corresponds to a device registered with the EDAC
> >> +		device driver for the memory repair features.
> >> +
> >> +		Post Package Repair is a maintenance operation requests the  
> >memory  
> >> +		device to perform a repair operation on its media, in detail is a
> >> +		memory self-healing feature that fixes a failing memory  
> >location by  
> >> +		replacing it with a spare row in a DRAM device. For example, a
> >> +		CXL memory device with DRAM components that support PPR  
> >features may  
> >> +		implement PPR maintenance operations. DRAM components  
> >may support  
> >> +		two types of PPR functions: hard PPR, for a permanent row  
> >repair, and  
> >> +		soft PPR, for a temporary row repair. soft PPR is much faster  
> >than  
> >> +		hard PPR, but the repair is lost with a power cycle.
> >> +
> >> +		Memory sparing is a repair function that replaces a portion
> >> +		of memory with a portion of functional memory at that same
> >> +		sparing granularity. Memory sparing has  
> >cacheline/row/bank/rank  
> >> +		sparing granularities. For example, in memory-sparing mode,
> >> +		one memory rank serves as a spare for other ranks on the same
> >> +		channel in case they fail. The spare rank is held in reserve and
> >> +		not used as active memory until a failure is indicated, with
> >> +		reserved capacity subtracted from the total available memory
> >> +		in the system.The DIMM installation order for memory sparing
> >> +		varies based on the number of processors and memory modules
> >> +		installed in the server. After an error threshold is surpassed
> >> +		in a system protected by memory sparing, the content of a  
> >failing  
> >> +		rank of DIMMs is copied to the spare rank. The failing rank is
> >> +		then taken offline and the spare rank placed online for use as
> >> +		active memory in place of the failed rank.
> >> +
> >> +		The sysfs attributes nodes for a repair feature are only
> >> +		present if the parent driver has implemented the corresponding
> >> +		attr callback function and provided the necessary operations
> >> +		to the EDAC device driver during registration.
> >> +
> >> +		In some states of system configuration (e.g. before address
> >> +		decoders have been configured), memory devices (e.g. CXL)
> >> +		may not have an active mapping in the main host address
> >> +		physical address map. As such, the memory to repair must be
> >> +		identified by a device specific physical addressing scheme
> >> +		using a device physical address(DPA). The DPA and other control
> >> +		attributes to use will be presented in related error records.
> >> +
> >> +What:		/sys/bus/edac/devices/<dev-
> >name>/mem_repairX/repair_function
> >> +Date:		Jan 2025
> >> +KernelVersion:	6.14
> >> +Contact:	linux-edac@vger.kernel.org
> >> +Description:
> >> +		(RO) Memory repair function type. For eg. post package repair,
> >> +		memory sparing etc.
> >> +		EDAC_SOFT_PPR - Soft post package repair
> >> +		EDAC_HARD_PPR - Hard post package repair
> >> +		EDAC_CACHELINE_MEM_SPARING - Cacheline memory sparing
> >> +		EDAC_ROW_MEM_SPARING - Row memory sparing
> >> +		EDAC_BANK_MEM_SPARING - Bank memory sparing
> >> +		EDAC_RANK_MEM_SPARING - Rank memory sparing
> >> +		All other values are reserved.  
> >
> >Too big strings. Why are them in upper cases? IMO:
> >
> >	soft-ppr, hard-ppr, ... would be enough.
> >  
> Here return repair type (single value, such as 0, 1, or 2 etc not as decoded string  for eg."EDAC_SOFT_PPR")
> of the memory repair instance, which is  defined as enums (EDAC_SOFT_PPR, EDAC_HARD_PPR, ... etc) 
> for the memory repair interface in the include/linux/edac.h.
> 
> enum edac_mem_repair_function {
> 	EDAC_SOFT_PPR,
> 	EDAC_HARD_PPR,
> 	EDAC_CACHELINE_MEM_SPARING,
> 	EDAC_ROW_MEM_SPARING,
> 	EDAC_BANK_MEM_SPARING,
> 	EDAC_RANK_MEM_SPARING,
> };
>   
> I documented return value in terms of the above enums.

The ABI documentation describes exactly what numeric/strings values will be there.
So, if you place:

	EDAC_SOFT_PPR

It means a string with EDAC_SOFT_PPR, not a numeric zero value.

Also, as I explained at:
	 https://lore.kernel.org/linux-edac/1bf421f9d1924d68860d08c70829a705@huawei.com/T/#m1e60da13198b47701a4c2f740d4b78701f912d2d

it doesn't make sense to report soft/hard PPR, as the persist mode
is designed to be on a different sysfs devnode (/persist_mode on your
proposal).

So, here you need to fold EDAC_SOFT_PPR and EDAC_HARD_PPR into a single
value ("ppr").

-

Btw, very few sysfs nodes use numbers for things that can be mapped with 
enums:

	$ git grep -l "\- 0" Documentation/ABI|wc -l
	20
	(several of those are actually false-positives)

and this is done mostly when it reports what the hardware actually
outputs when reading some register.

Thanks,
Mauro

