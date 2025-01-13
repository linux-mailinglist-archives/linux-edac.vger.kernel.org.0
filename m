Return-Path: <linux-edac+bounces-2884-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65023A0BC9A
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2025 16:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0662C3A487A
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2025 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB551C5D60;
	Mon, 13 Jan 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmTlcF4y"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373B014B08E;
	Mon, 13 Jan 2025 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783445; cv=none; b=bw6LDbDwfwuzU0wT6W5mrMFxXWko/XMO7gd+GRzMlkhoKcxfjLyhcE8Z6MB49Kofa9SDe3ls4HHfD1dbHzuQIo+IAvDupx+UhNErpIUUHCFybO3StF+YqXMc9Q7Q0YhmtLNnMpyzs5D420FtkPedaFaglOc4pPSTajho4phDA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783445; c=relaxed/simple;
	bh=8AMTPaL4ud/nRdu2tV4EHcD5bEgAjPEz5LtQrkf2fLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ydf+FiUoyLG/0CxMzx/MHFGeA8oazCvKTgC057MDE0gh9Zmgc3pKnRKhzqFfzQ/fuNS84mG3JWnRUZj+BdPZ8VQ5ee45etklr5EcgMoUhazLFi1cJjHVhf0LlbY4ycYn8nJ3PH4Z2r2Qs1i7esx5WG7bXAWS3PcaypMrSPh5lew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmTlcF4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E78C4CED6;
	Mon, 13 Jan 2025 15:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736783444;
	bh=8AMTPaL4ud/nRdu2tV4EHcD5bEgAjPEz5LtQrkf2fLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pmTlcF4y0KQOELjIKqfDngBBrRhVrCTzg4yvPUjR1SPoM3R9ggOvDa6hJ/JdkA+uB
	 nw555rbU0YOfFukGCglh3XdS7bazyvlC7HD9PeA7+LFnPD+gGuL7V/eBd9E5cF9iiS
	 J779XSMi9DBhsXDwsoechntjYakrTM/Tug5uySYRUBssFeuh+WuD1OPX7Sra2DHR23
	 JqctX7+IcqPmtOGyyQrIL03IxEriq4BpuIoaIUcxaw/Nm03FsFDATWx/1HZw//1rYX
	 N5I6TMzEditjkMTfDoOAsMkjPh+K0jS+xi/D8pamBEoSIKwdoTtrFcgy5f8GKlvwCU
	 x3CyKrX5gjMng==
Date: Mon, 13 Jan 2025 16:50:32 +0100
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
Subject: Re: [PATCH v18 02/19] EDAC: Add scrub control feature
Message-ID: <20250113165032.2f3edb5a@foz.lan>
In-Reply-To: <20250106121017.1620-3-shiju.jose@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-3-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 6 Jan 2025 12:09:58 +0000
<shiju.jose@huawei.com> escreveu:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add a generic EDAC scrub control to manage memory scrubbers in the system.
> Devices with a scrub feature register with the EDAC device driver, which
> retrieves the scrub descriptor from the EDAC scrub driver and exposes the
> sysfs scrub control attributes for a scrub instance to userspace at
> /sys/bus/edac/devices/<dev-name>/scrubX/.
> 
> The common sysfs scrub control interface abstracts the control of
> arbitrary scrubbing functionality into a common set of functions. The
> sysfs scrub attribute nodes are only present if the client driver has
> implemented the corresponding attribute callback function and passed the
> operations(ops) to the EDAC device driver during registration.
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-edac-scrub |  74 +++++++
>  Documentation/edac/features.rst            |   5 +
>  Documentation/edac/index.rst               |   1 +
>  Documentation/edac/scrub.rst               | 244 +++++++++++++++++++++
>  drivers/edac/Makefile                      |   1 +
>  drivers/edac/edac_device.c                 |  41 +++-
>  drivers/edac/scrub.c                       | 209 ++++++++++++++++++
>  include/linux/edac.h                       |  34 +++
>  8 files changed, 605 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-edac-scrub
>  create mode 100644 Documentation/edac/scrub.rst
>  create mode 100755 drivers/edac/scrub.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-edac-scrub b/Documentation/ABI/testing/sysfs-edac-scrub
> new file mode 100644
> index 000000000000..af14a68ee5a9
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-edac-scrub
> @@ -0,0 +1,74 @@
> +What:		/sys/bus/edac/devices/<dev-name>/scrubX
> +Date:		Jan 2025
> +KernelVersion:	6.14
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		The sysfs EDAC bus devices /<dev-name>/scrubX subdirectory
> +		belongs to an instance of memory scrub control feature,
> +		where <dev-name> directory corresponds to a device/memory
> +		region registered with the EDAC device driver for the
> +		scrub control feature.
> +		The sysfs scrub attr nodes are only present if the parent
> +		driver has implemented the corresponding attr callback
> +		function and provided the necessary operations to the EDAC
> +		device driver during registration.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrubX/addr
> +Date:		Jan 2025
> +KernelVersion:	6.14
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The base address of the memory region to be scrubbed
> +		for on-demand scrubbing. Setting address would start
> +		scrubbing. The size must be set before that.
> +		The readback addr value would be non-zero if the requested
> +		on-demand scrubbing is in progress, zero otherwise.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrubX/size
> +Date:		Jan 2025
> +KernelVersion:	6.14
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The size of the memory region to be scrubbed
> +		(on-demand scrubbing).
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrubX/enable_background
> +Date:		Jan 2025
> +KernelVersion:	6.14
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Start/Stop background(patrol) scrubbing if supported.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrubX/enable_on_demand
> +Date:		Jan 2025
> +KernelVersion:	6.14
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) Start/Stop on-demand scrubbing the memory region
> +		if supported.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrubX/min_cycle_duration
> +Date:		Jan 2025
> +KernelVersion:	6.14
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) Supported minimum scrub cycle duration in seconds
> +		by the memory scrubber.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrubX/max_cycle_duration
> +Date:		Jan 2025
> +KernelVersion:	6.14
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RO) Supported maximum scrub cycle duration in seconds
> +		by the memory scrubber.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/scrubX/current_cycle_duration
> +Date:		Jan 2025
> +KernelVersion:	6.14
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The current scrub cycle duration in seconds and must be
> +		within the supported range by the memory scrubber.
> +		Scrub has an overhead when running and that may want to be
> +		reduced by taking longer to do it.
> diff --git a/Documentation/edac/features.rst b/Documentation/edac/features.rst
> index f32f259ce04d..ba3ab993ee4f 100644
> --- a/Documentation/edac/features.rst
> +++ b/Documentation/edac/features.rst
> @@ -92,3 +92,8 @@ the sysfs EDAC bus. For example, /sys/bus/edac/devices/<dev-name>/<feature>X/
>  3. RAS dynamic feature controller - Userspace sample modules in rasdaemon for
>  dynamic scrub/repair control to issue scrubbing/repair when excess number
>  of corrected memory errors are reported in a short span of time.
> +
> +RAS features
> +------------
> +1. Memory Scrub
> +Memory scrub features are documented in `Documentation/edac/scrub.rst`.
> diff --git a/Documentation/edac/index.rst b/Documentation/edac/index.rst
> index b6c265a4cffb..dfb0c9fb9ab1 100644
> --- a/Documentation/edac/index.rst
> +++ b/Documentation/edac/index.rst
> @@ -8,3 +8,4 @@ EDAC Subsystem
>     :maxdepth: 1
>  
>     features
> +   scrub
> diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
> new file mode 100644
> index 000000000000..5a5108b744a4
> --- /dev/null
> +++ b/Documentation/edac/scrub.rst
> @@ -0,0 +1,244 @@
> +.. SPDX-License-Identifier: GPL-2.0

Same note of patch 1, e. g.:

	.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.2-no-invariants-or-later


> +
> +===================
> +EDAC Scrub Control
> +===================
> +
> +Copyright (c) 2024 HiSilicon Limited.
> +
> +:Author:   Shiju Jose <shiju.jose@huawei.com>
> +:License:  The GNU Free Documentation License, Version 1.2
> +          (dual licensed under the GPL v2)

See my notes on patch 1.

I won't repeat those over the other patches in this series touching
documentation

> +:Original Reviewers:
> +
> +- Written for: 6.14
> +
> +Introduction
> +------------
> +Increasing DRAM size and cost have made memory subsystem reliability an
> +important concern. These modules are used where potentially corrupted data
> +could cause expensive or fatal issues. Memory errors are among the top
> +hardware failures that cause server and workload crashes.
> +
> +Memory scrubbing is a feature where an ECC (Error-Correcting Code) engine
> +reads data from each memory media location, corrects with an ECC if
> +necessary and writes the corrected data back to the same memory media
> +location.
> +
> +The memory DIMMs can be scrubbed at a configurable rate to detect
> +uncorrected memory errors and attempt recovery from detected errors,
> +providing the following benefits.
> +
> +* Proactively scrubbing memory DIMMs reduces the chance of a correctable error becoming uncorrectable.
> +
> +* When detected, uncorrected errors caught in unallocated memory pages are isolated and prevented from being allocated to an application or the OS.
> +
> +* This reduces the likelihood of software or hardware products encountering memory errors.
> +
> +There are 2 types of memory scrubbing:
> +
> +1. Background (patrol) scrubbing of the RAM while the RAM is otherwise
> +idle.
> +
> +2. On-demand scrubbing for a specific address range or region of memory.
> +
> +Several types of interfaces to hardware memory scrubbers have been
> +identified, such as CXL memory device patrol scrub, CXL DDR5 ECS, ACPI
> +RAS2 memory scrubbing, and ACPI NVDIMM ARS (Address Range Scrub).
> +
> +The scrub control varies between different memory scrubbers. To allow
> +for standard userspace tooling there is a need to present these controls
> +with a standard ABI.
> +
> +The control mechanisms vary across different memory scrubbers. To enable
> +standardized userspace tooling, there is a need to present these controls
> +through a standardized ABI.
> +
> +Introduce a generic memory EDAC scrub control that allows users to manage
> +underlying scrubbers in the system through a standardized sysfs scrub
> +control interface. This common sysfs scrub control interface abstracts the
> +management of various scrubbing functionalities into a unified set of
> +functions.
> +
> +Use cases of common scrub control feature
> +-----------------------------------------
> +1. Several types of interfaces for hardware (HW) memory scrubbers have
> +been identified, including the CXL memory device patrol scrub, CXL DDR5
> +ECS, ACPI RAS2 memory scrubbing features, ACPI NVDIMM ARS (Address Range
> +Scrub), and software-based memory scrubbers. Some of these scrubbers
> +support control over patrol (background) scrubbing (e.g., ACPI RAS2, CXL)
> +and/or on-demand scrubbing (e.g., ACPI RAS2, ACPI ARS). However, the scrub
> +control interfaces vary between memory scrubbers, highlighting the need for
> +a standardized, generic sysfs scrub control interface that is accessible to
> +userspace for administration and use by scripts/tools.
> +
> +2. User-space scrub controls allow users to disable scrubbing if necessary,
> +for example, to disable background patrol scrubbing or adjust the scrub
> +rate for performance-aware operations where background activities need to
> +be minimized or disabled.
> +
> +3. User-space tools enable on-demand scrubbing for specific address ranges,
> +provided that the scrubber supports this functionality.
> +
> +4. User-space tools can also control memory DIMM scrubbing at a configurable
> +scrub rate via sysfs scrub controls. This approach offers several benefits:
> +
> +* Detects uncorrectable memory errors early, before user access to affected memory, helping facilitate recovery.
> +
> +* Reduces the likelihood of correctable errors developing into uncorrectable errors.
> +
> +5. Policy control for hotplugged memory is necessary because there may not
> +be a system-wide BIOS or similar control to manage scrub settings for a CXL
> +device added after boot. Determining these settings is a policy decision,
> +balancing reliability against performance, so userspace should control it.
> +Therefore, a unified interface is recommended for handling this function in
> +a way that aligns with other similar interfaces, rather than creating a
> +separate one.
> +
> +Scrubbing features
> +------------------
> +Comparison of various scrubbing features::
> +
> + ................................................................
> + .              .   ACPI    . CXL patrol.  CXL ECS  .  ARS      .
> + .  Name        .   RAS2    . scrub     .           .           .
> + ................................................................
> + .              .           .           .           .           .
> + . On-demand    . Supported . No        . No        . Supported .
> + . Scrubbing    .           .           .           .           .
> + .              .           .           .           .           .
> + ................................................................
> + .              .           .           .           .           .
> + . Background   . Supported . Supported . Supported . No        .
> + . scrubbing    .           .           .           .           .
> + .              .           .           .           .           .
> + ................................................................
> + .              .           .           .           .           .
> + . Mode of      . Scrub ctrl. per device. per memory.  Unknown  .
> + . scrubbing    . per NUMA  .           . media     .           .
> + .              . domain.   .           .           .           .
> + ................................................................
> + .              .           .           .           .           .
> + . Query scrub  . Supported . Supported . Supported . Supported .
> + . capabilities .           .           .           .           .
> + .              .           .           .           .           .
> + ................................................................
> + .              .           .           .           .           .
> + . Setting      . Supported . No        . No        . Supported .
> + . address range.           .           .           .           .
> + .              .           .           .           .           .
> + ................................................................
> + .              .           .           .           .           .
> + . Setting      . Supported . Supported . No        . No        .
> + . scrub rate   .           .           .           .           .
> + .              .           .           .           .           .
> + ................................................................
> + .              .           .           .           .           .
> + . Unit for     . Not       . in hours  . No        . No        .
> + . scrub rate   . Defined   .           .           .           .
> + .              .           .           .           .           .
> + ................................................................
> + .              . Supported .           .           .           .
> + . Scrub        . on-demand . No        . No        . Supported .
> + . status/      . scrubbing .           .           .           .
> + . Completion   . only      .           .           .           .
> + ................................................................
> + . UC error     .           .CXL general.CXL general. ACPI UCE  .
> + . reporting    . Exception .media/DRAM .media/DRAM . notify and.
> + .              .           .event/media.event/media. query     .
> + .              .           .scan?      .scan?      . ARS status.
> + ................................................................
> + .              .           .           .           .           .
> + . Support for  . Supported . Supported . Supported . No        .
> + . EDAC control .           .           .           .           .
> + .              .           .           .           .           .
> + ................................................................

Please format this as a table, in ReST, e. g:

Scrubbing features
------------------
Comparison of various scrubbing features:

+--------------+-----------+-----------+-----------+-----------+
|              |           |           |           |           |
| Background   | Supported | Supported | Supported | No        |
| scrubbing    |           |           |           |           |
|              |           |           |           |           |
+==============+===========+===========+===========+===========+
|              |           |           |           |           |
| Mode of      | Scrub ctrl| per device| per memory|  Unknown  |
| scrubbing    | per NUMA  |           | media     |           |
|              | domain    |           |           |           |
+--------------+-----------+-----------+-----------+-----------+
|              |           |           |           |           |
| Query scrub  | Supported | Supported | Supported | Supported |
| capabilities |           |           |           |           |
|              |           |           |           |           |
+--------------+-----------+-----------+-----------+-----------+
|              |           |           |           |           |
| Setting      | Supported | No        | No        | Supported |
| address range|           |           |           |           |
|              |           |           |           |           |
+--------------+-----------+-----------+-----------+-----------+
|              |           |           |           |           |
| Setting      | Supported | Supported | No        | No        |
| scrub rate   |           |           |           |           |
|              |           |           |           |           |
+--------------+-----------+-----------+-----------+-----------+
|              |           |           |           |           |
| Unit for     | Not       | in hours  | No        | No        |
| scrub rate   | Defined   |           |           |           |
|              |           |           |           |           |
+--------------+-----------+-----------+-----------+-----------+
|              | Supported |           |           |           |
| Scrub        | on-demand | No        | No        | Supported |
| status/      | scrubbing |           |           |           |
| Completion   | only      |           |           |           |
+--------------+-----------+-----------+-----------+-----------+
| UC error     |           |CXL general|CXL general| ACPI UCE  |
| reporting    | Exception |media/DRAM |media/DRAM | notify and|
|              |           |event/media|event/media| query     |
|              |           |scan?      |scan?      | ARS status|
+--------------+-----------+-----------+-----------+-----------+
|              |           |           |           |           |
| Support for  | Supported | Supported | Supported | No        |
| EDAC control |           |           |           |           |
|              |           |           |           |           |
+--------------+-----------+-----------+-----------+-----------+


> +CXL Memory Scrubbing features
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +CXL spec r3.1 section 8.2.9.9.11.1 describes the memory device patrol scrub
> +control feature. The device patrol scrub proactively locates and makes
> +corrections to errors in regular cycle. The patrol scrub control allows the
> +request to configure patrol scrubber's input configurations.
> +
> +The patrol scrub control allows the requester to specify the number of
> +hours in which the patrol scrub cycles must be completed, provided that
> +the requested number is not less than the minimum number of hours for the
> +patrol scrub cycle that the device is capable of. In addition, the patrol
> +scrub controls allow the host to disable and enable the feature in case
> +disabling of the feature is needed for other purposes such as
> +performance-aware operations which require the background operations to be
> +turned off.
> +
> +Error Check Scrub (ECS)
> +~~~~~~~~~~~~~~~~~~~~~~~
> +CXL spec r3.1 section 8.2.9.9.11.2 describes the Error Check Scrub (ECS)
> +is a feature defined in JEDEC DDR5 SDRAM Specification (JESD79-5) and
> +allows the DRAM to internally read, correct single-bit errors, and write
> +back corrected data bits to the DRAM array while providing transparency
> +to error counts.

Please add a reference for CXL spec, like:

	CXL spec r3.1 [1]_ section 8.2.9.9.11.2 describes...

.. [1] https://computeexpresslink.org/wp-content/uploads/2024/02/CXL-3.1-Specification.pdf

Same for other specs mentioned at the docs. For more details, see:
	https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#footnotes

> +
> +The DDR5 device contains number of memory media FRUs per device. The
> +DDR5 ECS feature and thus the ECS control driver supports configuring
> +the ECS parameters per FRU.
> +
> +ACPI RAS2 Hardware-based Memory Scrubbing
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +ACPI spec 6.5 section 5.2.21 ACPI RAS2 describes ACPI RAS2 table
> +provides interfaces for platform RAS features and supports independent
> +RAS controls and capabilities for a given RAS feature for multiple
> +instances of the same component in a given system.
> +Memory RAS features apply to RAS capabilities, controls and operations
> +that are specific to memory. RAS2 PCC sub-spaces for memory-specific RAS
> +features have a Feature Type of 0x00 (Memory).
> +
> +The platform can use the hardware-based memory scrubbing feature to expose
> +controls and capabilities associated with hardware-based memory scrub
> +engines. The RAS2 memory scrubbing feature supports following as per spec,
> +
> +* Independent memory scrubbing controls for each NUMA domain, identified using its proximity domain.
> +
> +* Provision for background (patrol) scrubbing of the entire memory system, as well as on-demand scrubbing for a specific region of memory.
> +
> +ACPI Address Range Scrubbing(ARS)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +ACPI spec 6.5 section 9.19.7.2 describes Address Range Scrubbing(ARS).
> +ARS allows the platform to communicate memory errors to system software.
> +This capability allows system software to prevent accesses to addresses
> +with uncorrectable errors in memory. ARS functions manage all NVDIMMs
> +present in the system. Only one scrub can be in progress system wide
> +at any given time.
> +Following functions are supported as per the specification.
> +
> +1. Query ARS Capabilities for a given address range, indicates platform
> +supports the ACPI NVDIMM Root Device Unconsumed Error Notification.
> +
> +2. Start ARS triggers an Address Range Scrub for the given memory range.
> +Address scrubbing can be done for volatile memory, persistent memory, or both.
> +
> +3. Query ARS Status command allows software to get the status of ARS,
> +including the progress of ARS and ARS error record.
> +
> +4. Clear Uncorrectable Error.
> +
> +5. Translate SPA
> +
> +6. ARS Error Inject etc.
> +
> +The kernel supports an existing control for ARS and ARS is currently not
> +supported in EDAC.
> +
> +The File System
> +---------------
> +
> +The control attributes of a registered scrubber instance could be
> +accessed in the
> +
> +/sys/bus/edac/devices/<dev-name>/scrubX/
> +
> +sysfs
> +-----
> +
> +Sysfs files are documented in
> +
> +`Documentation/ABI/testing/sysfs-edac-scrub`.

Please remove the blank line, e. g.:

	Sysfs files are documented in
	`Documentation/ABI/testing/sysfs-edac-scrub`.

> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index f9cf19d8d13d..a162726cc6b9 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
>  
>  edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
>  edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
> +edac_core-y	+= scrub.o
>  
>  edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
>  
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 9fce46dd7405..60b20eae01e8 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -575,6 +575,7 @@ static void edac_dev_release(struct device *dev)
>  {
>  	struct edac_dev_feat_ctx *ctx = container_of(dev, struct edac_dev_feat_ctx, dev);
>  
> +	kfree(ctx->scrub);
>  	kfree(ctx->dev.groups);
>  	kfree(ctx);
>  }
> @@ -608,8 +609,10 @@ int edac_dev_register(struct device *parent, char *name,
>  		      const struct edac_dev_feature *ras_features)
>  {
>  	const struct attribute_group **ras_attr_groups;
> +	struct edac_dev_data *dev_data;
>  	struct edac_dev_feat_ctx *ctx;
>  	int attr_gcnt = 0;
> +	int scrub_cnt = 0;
>  	int ret, feat;
>  
>  	if (!parent || !name || !num_features || !ras_features)
> @@ -618,7 +621,10 @@ int edac_dev_register(struct device *parent, char *name,
>  	/* Double parse to make space for attributes */
>  	for (feat = 0; feat < num_features; feat++) {
>  		switch (ras_features[feat].ft_type) {
> -		/* Add feature specific code */
> +		case RAS_FEAT_SCRUB:
> +			attr_gcnt++;
> +			scrub_cnt++;
> +			break;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -634,13 +640,38 @@ int edac_dev_register(struct device *parent, char *name,
>  		goto ctx_free;
>  	}
>  
> +	if (scrub_cnt) {
> +		ctx->scrub = kcalloc(scrub_cnt, sizeof(*ctx->scrub), GFP_KERNEL);
> +		if (!ctx->scrub) {
> +			ret = -ENOMEM;
> +			goto groups_free;
> +		}
> +	}
> +
>  	attr_gcnt = 0;
> +	scrub_cnt = 0;
>  	for (feat = 0; feat < num_features; feat++, ras_features++) {
>  		switch (ras_features->ft_type) {
> -		/* Add feature specific code */
> +		case RAS_FEAT_SCRUB:
> +			if (!ras_features->scrub_ops ||
> +			    scrub_cnt != ras_features->instance)
> +				goto data_mem_free;
> +
> +			dev_data = &ctx->scrub[scrub_cnt];
> +			dev_data->instance = scrub_cnt;
> +			dev_data->scrub_ops = ras_features->scrub_ops;
> +			dev_data->private = ras_features->ctx;
> +			ret = edac_scrub_get_desc(parent, &ras_attr_groups[attr_gcnt],
> +						  ras_features->instance);
> +			if (ret)
> +				goto data_mem_free;
> +
> +			scrub_cnt++;
> +			attr_gcnt++;
> +			break;
>  		default:
>  			ret = -EINVAL;
> -			goto groups_free;
> +			goto data_mem_free;
>  		}
>  	}
>  
> @@ -653,7 +684,7 @@ int edac_dev_register(struct device *parent, char *name,
>  
>  	ret = dev_set_name(&ctx->dev, name);
>  	if (ret)
> -		goto groups_free;
> +		goto data_mem_free;
>  
>  	ret = device_register(&ctx->dev);
>  	if (ret) {
> @@ -663,6 +694,8 @@ int edac_dev_register(struct device *parent, char *name,
>  
>  	return devm_add_action_or_reset(parent, edac_dev_unreg, &ctx->dev);
>  
> +data_mem_free:
> +	kfree(ctx->scrub);
>  groups_free:
>  	kfree(ras_attr_groups);
>  ctx_free:
> diff --git a/drivers/edac/scrub.c b/drivers/edac/scrub.c
> new file mode 100755
> index 000000000000..3978201c4bfc
> --- /dev/null
> +++ b/drivers/edac/scrub.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The generic EDAC scrub driver controls the memory scrubbers in the
> + * system. The common sysfs scrub interface abstracts the control of
> + * various arbitrary scrubbing functionalities into a unified set of
> + * functions.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + */
> +
> +#include <linux/edac.h>
> +
> +enum edac_scrub_attributes {
> +	SCRUB_ADDRESS,
> +	SCRUB_SIZE,
> +	SCRUB_ENABLE_BACKGROUND,
> +	SCRUB_MIN_CYCLE_DURATION,
> +	SCRUB_MAX_CYCLE_DURATION,
> +	SCRUB_CUR_CYCLE_DURATION,
> +	SCRUB_MAX_ATTRS
> +};
> +
> +struct edac_scrub_dev_attr {
> +	struct device_attribute dev_attr;
> +	u8 instance;
> +};
> +
> +struct edac_scrub_context {
> +	char name[EDAC_FEAT_NAME_LEN];

Ok, here you're using EDAC_FEAT_NAME_LEN. Please move its definition from
patch 1 to this patch.

> +	struct edac_scrub_dev_attr scrub_dev_attr[SCRUB_MAX_ATTRS];
> +	struct attribute *scrub_attrs[SCRUB_MAX_ATTRS + 1];
> +	struct attribute_group group;
> +};
> +
> +#define TO_SCRUB_DEV_ATTR(_dev_attr)      \
> +		container_of(_dev_attr, struct edac_scrub_dev_attr, dev_attr)
> +
> +#define EDAC_SCRUB_ATTR_SHOW(attrib, cb, type, format)				\
> +static ssize_t attrib##_show(struct device *ras_feat_dev,			\
> +			     struct device_attribute *attr, char *buf)		\
> +{										\
> +	u8 inst = TO_SCRUB_DEV_ATTR(attr)->instance;				\
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;		\
> +	type data;								\
> +	int ret;								\
> +										\
> +	ret = ops->cb(ras_feat_dev->parent, ctx->scrub[inst].private, &data);	\
> +	if (ret)								\
> +		return ret;							\
> +										\
> +	return sysfs_emit(buf, format, data);					\
> +}
> +
> +EDAC_SCRUB_ATTR_SHOW(addr, read_addr, u64, "0x%llx\n")
> +EDAC_SCRUB_ATTR_SHOW(size, read_size, u64, "0x%llx\n")
> +EDAC_SCRUB_ATTR_SHOW(enable_background, get_enabled_bg, bool, "%u\n")
> +EDAC_SCRUB_ATTR_SHOW(min_cycle_duration, get_min_cycle, u32, "%u\n")
> +EDAC_SCRUB_ATTR_SHOW(max_cycle_duration, get_max_cycle, u32, "%u\n")
> +EDAC_SCRUB_ATTR_SHOW(current_cycle_duration, get_cycle_duration, u32, "%u\n")
> +
> +#define EDAC_SCRUB_ATTR_STORE(attrib, cb, type, conv_func)			\
> +static ssize_t attrib##_store(struct device *ras_feat_dev,			\
> +			      struct device_attribute *attr,			\
> +			      const char *buf, size_t len)			\
> +{										\
> +	u8 inst = TO_SCRUB_DEV_ATTR(attr)->instance;				\
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;		\
> +	type data;								\
> +	int ret;								\
> +										\
> +	ret = conv_func(buf, 0, &data);						\
> +	if (ret < 0)								\
> +		return ret;							\
> +										\
> +	ret = ops->cb(ras_feat_dev->parent, ctx->scrub[inst].private, data);	\
> +	if (ret)								\
> +		return ret;							\
> +										\
> +	return len;								\
> +}
> +
> +EDAC_SCRUB_ATTR_STORE(addr, write_addr, u64, kstrtou64)
> +EDAC_SCRUB_ATTR_STORE(size, write_size, u64, kstrtou64)
> +EDAC_SCRUB_ATTR_STORE(enable_background, set_enabled_bg, unsigned long, kstrtoul)
> +EDAC_SCRUB_ATTR_STORE(current_cycle_duration, set_cycle_duration, unsigned long, kstrtoul)
> +
> +static umode_t scrub_attr_visible(struct kobject *kobj, struct attribute *a, int attr_id)
> +{
> +	struct device *ras_feat_dev = kobj_to_dev(kobj);
> +	struct device_attribute *dev_attr = container_of(a, struct device_attribute, attr);
> +	u8 inst = TO_SCRUB_DEV_ATTR(dev_attr)->instance;
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_scrub_ops *ops = ctx->scrub[inst].scrub_ops;
> +
> +	switch (attr_id) {
> +	case SCRUB_ADDRESS:
> +		if (ops->read_addr) {
> +			if (ops->write_addr)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case SCRUB_SIZE:
> +		if (ops->read_size) {
> +			if (ops->write_size)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case SCRUB_ENABLE_BACKGROUND:
> +		if (ops->get_enabled_bg) {
> +			if (ops->set_enabled_bg)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case SCRUB_MIN_CYCLE_DURATION:
> +		if (ops->get_min_cycle)
> +			return a->mode;
> +		break;
> +	case SCRUB_MAX_CYCLE_DURATION:
> +		if (ops->get_max_cycle)
> +			return a->mode;
> +		break;
> +	case SCRUB_CUR_CYCLE_DURATION:
> +		if (ops->get_cycle_duration) {
> +			if (ops->set_cycle_duration)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +#define EDAC_SCRUB_ATTR_RO(_name, _instance)       \
> +	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_RO(_name), \
> +					.instance = _instance })
> +
> +#define EDAC_SCRUB_ATTR_WO(_name, _instance)       \
> +	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_WO(_name), \
> +					.instance = _instance })
> +
> +#define EDAC_SCRUB_ATTR_RW(_name, _instance)       \
> +	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_RW(_name), \
> +					.instance = _instance })
> +
> +static int scrub_create_desc(struct device *scrub_dev,
> +			     const struct attribute_group **attr_groups, u8 instance)
> +{
> +	struct edac_scrub_context *scrub_ctx;
> +	struct attribute_group *group;
> +	int i;
> +	struct edac_scrub_dev_attr dev_attr[] = {
> +		[SCRUB_ADDRESS] = EDAC_SCRUB_ATTR_RW(addr, instance),
> +		[SCRUB_SIZE] = EDAC_SCRUB_ATTR_RW(size, instance),
> +		[SCRUB_ENABLE_BACKGROUND] = EDAC_SCRUB_ATTR_RW(enable_background, instance),
> +		[SCRUB_MIN_CYCLE_DURATION] = EDAC_SCRUB_ATTR_RO(min_cycle_duration, instance),
> +		[SCRUB_MAX_CYCLE_DURATION] = EDAC_SCRUB_ATTR_RO(max_cycle_duration, instance),
> +		[SCRUB_CUR_CYCLE_DURATION] = EDAC_SCRUB_ATTR_RW(current_cycle_duration, instance)
> +	};
> +
> +	scrub_ctx = devm_kzalloc(scrub_dev, sizeof(*scrub_ctx), GFP_KERNEL);
> +	if (!scrub_ctx)
> +		return -ENOMEM;
> +
> +	group = &scrub_ctx->group;
> +	for (i = 0; i < SCRUB_MAX_ATTRS; i++) {
> +		memcpy(&scrub_ctx->scrub_dev_attr[i], &dev_attr[i], sizeof(dev_attr[i]));
> +		scrub_ctx->scrub_attrs[i] = &scrub_ctx->scrub_dev_attr[i].dev_attr.attr;
> +	}
> +	sprintf(scrub_ctx->name, "%s%d", "scrub", instance);
> +	group->name = scrub_ctx->name;
> +	group->attrs = scrub_ctx->scrub_attrs;
> +	group->is_visible  = scrub_attr_visible;
> +
> +	attr_groups[0] = group;
> +
> +	return 0;
> +}
> +
> +/**
> + * edac_scrub_get_desc - get EDAC scrub descriptors
> + * @scrub_dev: client device, with scrub support
> + * @attr_groups: pointer to attribute group container
> + * @instance: device's scrub instance number.
> + *
> + * Return:
> + *  * %0	- Success.
> + *  * %-EINVAL	- Invalid parameters passed.
> + *  * %-ENOMEM	- Dynamic memory allocation failed.
> + */
> +int edac_scrub_get_desc(struct device *scrub_dev,
> +			const struct attribute_group **attr_groups, u8 instance)
> +{
> +	if (!scrub_dev || !attr_groups)
> +		return -EINVAL;
> +
> +	return scrub_create_desc(scrub_dev, attr_groups, instance);
> +}
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index 521b17113d4d..ace8b10bb028 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -666,11 +666,43 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
>  
>  /* RAS feature type */
>  enum edac_dev_feat {
> +	RAS_FEAT_SCRUB,
>  	RAS_FEAT_MAX
>  };
>  
> +/**
> + * struct edac_scrub_ops - scrub device operations (all elements optional)
> + * @read_addr: read base address of scrubbing range.
> + * @read_size: read offset of scrubbing range.
> + * @write_addr: set base address of the scrubbing range.
> + * @write_size: set offset of the scrubbing range.
> + * @get_enabled_bg: check if currently performing background scrub.
> + * @set_enabled_bg: start or stop a bg-scrub.
> + * @get_min_cycle: get minimum supported scrub cycle duration in seconds.
> + * @get_max_cycle: get maximum supported scrub cycle duration in seconds.
> + * @get_cycle_duration: get current scrub cycle duration in seconds.
> + * @set_cycle_duration: set current scrub cycle duration in seconds.
> + */
> +struct edac_scrub_ops {
> +	int (*read_addr)(struct device *dev, void *drv_data, u64 *base);
> +	int (*read_size)(struct device *dev, void *drv_data, u64 *size);
> +	int (*write_addr)(struct device *dev, void *drv_data, u64 base);
> +	int (*write_size)(struct device *dev, void *drv_data, u64 size);
> +	int (*get_enabled_bg)(struct device *dev, void *drv_data, bool *enable);
> +	int (*set_enabled_bg)(struct device *dev, void *drv_data, bool enable);
> +	int (*get_min_cycle)(struct device *dev, void *drv_data,  u32 *min);
> +	int (*get_max_cycle)(struct device *dev, void *drv_data,  u32 *max);
> +	int (*get_cycle_duration)(struct device *dev, void *drv_data, u32 *cycle);
> +	int (*set_cycle_duration)(struct device *dev, void *drv_data, u32 cycle);
> +};
> +
> +int edac_scrub_get_desc(struct device *scrub_dev,
> +			const struct attribute_group **attr_groups,
> +			u8 instance);
> +
>  /* EDAC device feature information structure */
>  struct edac_dev_data {
> +	const struct edac_scrub_ops *scrub_ops;
>  	u8 instance;
>  	void *private;
>  };
> @@ -678,11 +710,13 @@ struct edac_dev_data {
>  struct edac_dev_feat_ctx {
>  	struct device dev;
>  	void *private;
> +	struct edac_dev_data *scrub;
>  };
>  
>  struct edac_dev_feature {
>  	enum edac_dev_feat ft_type;
>  	u8 instance;
> +	const struct edac_scrub_ops *scrub_ops;
>  	void *ctx;
>  };
>  



Thanks,
Mauro

