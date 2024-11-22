Return-Path: <linux-edac+bounces-2623-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4779D63E2
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 19:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FA1283F42
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 18:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45D71DF75B;
	Fri, 22 Nov 2024 18:05:27 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA7A1DFE33;
	Fri, 22 Nov 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298727; cv=none; b=iKqVQ+iepDQMoMi2CzD+tUWgd9V1FoIYimS+qGSCr6bw1u8ghpcyMlwyR8m9h08R8TJNMuYWvpgWqmdt0rzxspQMAy6EVB1KHKOC5FfsR/sokkxAKNQp5Fm/G/lI29G0p22/V+qzH//2scKYoWTGVDq5dY3IFrcIYAQanywlv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298727; c=relaxed/simple;
	bh=g/L3Hb9ykED3kk72INJ9khh0OhypHoLKaD8w7rCUaXM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inz4ZybNFiHehflj1aJt6WRB4gK+nOgWKdHGbaxjObosxl8vI1vr/nSlm9Fddm87atErbiYOagSksCEs6lYvY99KslH6U6LAnFe3CDUldRyUilJRLosbQehIDUhbRPbnhfwDNUXPcaDkcnI9yom06/jgNQdamuh1YkAoVDugxN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xw30N3tsTz6LCZY;
	Sat, 23 Nov 2024 02:04:52 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F048140B3C;
	Sat, 23 Nov 2024 02:05:18 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.171.16) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 19:05:16 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v17 15/18] EDAC: Add memory repair control feature
Date: Fri, 22 Nov 2024 18:04:12 +0000
Message-ID: <20241122180416.1932-16-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241122180416.1932-1-shiju.jose@huawei.com>
References: <20241122180416.1932-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add a generic EDAC memory repair control driver to manage memory repairs
in the system, such as CXL Post Package Repair (PPR) and CXL memory sparing
features.

For example, a CXL device with DRAM components that support PPR features
may implement PPR maintenance operations. DRAM components may support two
types of PPR, hard PPR, for a permanent row repair, and soft PPR,  for a
temporary row repair. Soft PPR is much faster than hard PPR, but the repair
is lost with a power cycle.
Similarly a CXL memory device may support soft and hard memory sparing at
cacheline, row, bank and rank granularities. Memory sparing is defined as
a repair function that replaces a portion of memory with a portion of
functional memory at that same granularity.
When a CXL device detects an error in a memory, it may report the host of
the need for a repair maintenance operation by using an event record where
the "maintenance needed" flag is set. The event records contains the device
physical address(DPA) and other attributes of the memory to repair (such as
channel, sub-channel, bank group, bank, rank, row, column etc). The kernel
will report the corresponding CXL general media or DRAM trace event to
userspace, and userspace tools (e.g. rasdaemon) will initiate a repair
operation in response to the device request via the sysfs repair control.

Device with memory repair features registers with EDAC device driver,
which retrieves memory repair descriptor from EDAC memory repair driver
and exposes the sysfs repair control attributes to userspace in
/sys/bus/edac/devices/<dev-name>/mem_repairX/.

The common memory repair control interface abstracts the control of
arbitrary memory repair functionality into a standardized set of functions.
The sysfs memory repair attribute nodes are only available if the client
driver has implemented the corresponding attribute callback function and
provided operations to the EDAC device driver during registration.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 .../ABI/testing/sysfs-edac-memory-repair      | 245 +++++++++
 Documentation/edac/features.rst               |   3 +
 Documentation/edac/index.rst                  |   1 +
 Documentation/edac/memory_repair.rst          | 101 ++++
 drivers/edac/Makefile                         |   2 +-
 drivers/edac/edac_device.c                    |  33 ++
 drivers/edac/mem_repair.c                     | 492 ++++++++++++++++++
 include/linux/edac.h                          | 139 +++++
 8 files changed, 1015 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-edac-memory-repair
 create mode 100644 Documentation/edac/memory_repair.rst
 create mode 100755 drivers/edac/mem_repair.c

diff --git a/Documentation/ABI/testing/sysfs-edac-memory-repair b/Documentation/ABI/testing/sysfs-edac-memory-repair
new file mode 100644
index 000000000000..c59c8dd9f4a7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-edac-memory-repair
@@ -0,0 +1,245 @@
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		The sysfs EDAC bus devices /<dev-name>/mem_repairX subdirectory
+		pertains to the memory media repair features control, such as
+		PPR (Post Package Repair), memory sparing etc, where<dev-name>
+		directory corresponds to a device registered with the EDAC
+		device driver for the memory repair features.
+
+		Post Package Repair is a maintenance operation requests the memory
+		device to perform a repair operation on its media, in detail is a
+		memory self-healing feature that fixes a failing memory location by
+		replacing it with a spare row in a DRAM device. For example, a
+		CXL memory device with DRAM components that support PPR features may
+		implement PPR maintenance operations. DRAM components may support
+		two types of PPR functions: hard PPR, for a permanent row repair, and
+		soft PPR, for a temporary row repair. soft PPR is much faster than
+		hard PPR, but the repair is lost with a power cycle.
+
+		Memory sparing is a repair function that replaces a portion
+		of memory with a portion of functional memory at that same
+		sparing granularity. Memory sparing has cacheline/row/bank/rank
+		sparing granularities. For example, in memory-sparing mode,
+		one memory rank serves as a spare for other ranks on the same
+		channel in case they fail. The spare rank is held in reserve and
+		not used as active memory until a failure is indicated, with
+		reserved capacity subtracted from the total available memory
+		in the system.The DIMM installation order for memory sparing
+		varies based on the number of processors and memory modules
+		installed in the server. After an error threshold is surpassed
+		in a system protected by memory sparing, the content of a failing
+		rank of DIMMs is copied to the spare rank. The failing rank is
+		then taken offline and the spare rank placed online for use as
+		active memory in place of the failed rank.
+
+		The sysfs attributes nodes for a repair feature are only
+		present if the parent driver has implemented the corresponding
+		attr callback function and provided the necessary operations
+		to the EDAC device driver during registration.
+
+		In some states of system configuration (e.g. before address
+		decoders have been configured), memory devices (e.g. CXL)
+		may not have an active mapping in the main host address
+		physical address map. As such, the memory to repair must be
+		identified by a device specific physical addressing scheme
+		using a device physical address(DPA). The DPA and other control
+		attributes to use will be presented in related error records.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/repair_function
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) Memory repair function type. For eg. post package repair,
+		memory sparing etc.
+		EDAC_SOFT_PPR - Soft post package repair
+		EDAC_HARD_PPR - Hard post package repair
+		EDAC_CACHELINE_MEM_SPARING - Cacheline memory sparing
+		EDAC_ROW_MEM_SPARING - Row memory sparing
+		EDAC_BANK_MEM_SPARING - Bank memory sparing
+		EDAC_RANK_MEM_SPARING - Rank memory sparing
+		All other values are reserved.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/persist_mode
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Read/Write the current persist repair mode set for a
+		repair function. Persist repair modes supported in the
+		device, based on the memory repair function is temporary
+		or permanent and is lost with a power cycle.
+		EDAC_MEM_REPAIR_SOFT - Soft repair function (temporary repair).
+		EDAC_MEM_REPAIR_HARD - Hard memory repair function (permanent repair).
+		All other values are reserved.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/dpa_support
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) True if memory device required device physical
+		address (DPA) of memory to repair.
+		False if memory device required host specific physical
+                address (HPA) of memory to repair.
+		In some states of system configuration (e.g. before address
+		decoders have been configured), memory devices (e.g. CXL)
+		may not have an active mapping in the main host address
+		physical address map. As such, the memory to repair must be
+		identified by a device specific physical addressing scheme
+		using a DPA. The device physical address(DPA) to use will be
+		presented in related error records.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/repair_safe_when_in_use
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) True if memory media is accessible and data is retained
+		during the memory repair operation.
+		The data may not be retained and memory requests may not be
+		correctly processed during a repair operation. In such case
+		the repair operation should not executed at runtime.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/hpa
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Host Physical Address (HPA) of the memory to repair.
+		See attribute 'dpa_support' for more details.
+		The HPA to use will be provided in related error records.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/dpa
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Device Physical Address (DPA) of the memory to repair.
+		See attribute 'dpa_support' for more details.
+		The specific DPA to use will be provided in related error
+		records.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/nibble_mask
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Read/Write Nibble mask of the memory to repair.
+		Nibble mask identifies one or more nibbles in error on the
+		memory bus that produced the error event. Nibble Mask bit 0
+		shall be set if nibble 0 on the memory bus produced the
+		event, etc. For example, CXL PPR and sparing, a nibble mask
+		bit set to 1 indicates the request to perform repair
+		operation in the specific device. All nibble mask bits set
+		to 1 indicates the request to perform the operation in all
+		devices. For CXL memory to repiar, the specific value of
+		nibble mask to use will be provided in related error records.
+		For more details, See nibble mask field in CXL spec ver 3.1,
+		section 8.2.9.7.1.2 Table 8-103 soft PPR and section
+		8.2.9.7.1.3 Table 8-104 hard PPR, section 8.2.9.7.1.4
+		Table 8-105 memory sparing.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/bank_group
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/bank
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/rank
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/row
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/column
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/channel
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/sub_channel
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) The control attributes associated with memory address
+		that is to be repaired. The specific value of attributes to
+		use depends on the portion of memory to repair and may be
+		reported to host in related error records and may be
+		available to userspace in trace events, such as in CXL
+		memory devices.
+
+		channel - The channel of the memory to repair. Channel is
+		defined as an interface that can be independently accessed
+		for a transaction.
+		rank - The rank of the memory to repair. Rank is defined as a
+		set of memory devices on a channel that together execute a
+		transaction.
+		bank_group - The bank group of the memory to repair.
+		bank - The bank number of the memory to repair.
+		row - The row number of the memory to repair.
+		column - The column number of the memory to repair.
+		sub_channel - The sub-channel of the memory to repair.
+
+		The requirement to set these attributes varies based on the
+		repair function. The attributes in sysfs are not present
+		unless required for a repair function.
+		For example, CXL spec ver 3.1, Section 8.2.9.7.1.2 Table 8-103
+		soft PPR and Section 8.2.9.7.1.3 Table 8-104 hard PPR operations,
+		these attributes are not required to set.
+		For example, CXL spec ver 3.1, Section 8.2.9.7.1.4 Table 8-105
+		memory sparing, these attributes are required to set based on
+		memory sparing granularity as follows.
+		Channel: Channel associated with the DPA that is to be spared
+		and applies to all subclasses of sparing (cacheline, bank,
+		row and rank sparing).
+		Rank: Rank associated with the DPA that is to be spared and
+		applies to all subclasses of sparing.
+		Bank & Bank Group: Bank & bank group are associated with
+		the DPA that is to be spared and applies to cacheline sparing,
+		row sparing and bank sparing subclasses.
+		Row: Row associated with the DPA that is to be spared and
+		applies to cacheline sparing and row sparing subclasses.
+		Column: column associated with the DPA that is to be spared
+		and applies to cacheline sparing only.
+		Sub-channel: sub-channel associated with the DPA that is to
+		be spared and applies to cacheline sparing only.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_hpa
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_dpa
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_nibble_mask
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_bank_group
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_bank
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_rank
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_row
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_column
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_channel
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_sub_channel
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_hpa
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_dpa
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_nibble_mask
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_bank_group
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_bank
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_rank
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_row
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_column
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_channel
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_sub_channel
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) The supported range of control attributes (optional)
+		associated with a memory address that is to be repaired.
+		The memory device may give the supported range of
+		attributes to use and it will depend on the memory device
+		and the portion of memory to repair.
+		The userspace may receive the specific value of attributes
+		to use for a repair operation from the memory device via
+		related error records and trace events, such as in CXL
+		memory devices.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/repair
+Date:		Jan 2025
+KernelVersion:	6.13
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(WO) Issue the memory repair operation for the specified
+		memory repair attributes. The operation may fail if resources
+		are insufficient based on the requirements of the memory
+		device and repair function.
+		EDAC_DO_MEM_REPAIR - issue repair operation.
+		All other values are reserved.
diff --git a/Documentation/edac/features.rst b/Documentation/edac/features.rst
index 4c3c190a3e48..d480944d506d 100644
--- a/Documentation/edac/features.rst
+++ b/Documentation/edac/features.rst
@@ -97,3 +97,6 @@ RAS features
 ------------
 1. Memory Scrub
 Memory scrub features are documented in `Documentation/edac/scrub.rst`.
+
+2. Memory Repair
+Memory repair features are documented in `Documentation/edac/memory_repair.rst`.
diff --git a/Documentation/edac/index.rst b/Documentation/edac/index.rst
index dfb0c9fb9ab1..d6778f4562dd 100644
--- a/Documentation/edac/index.rst
+++ b/Documentation/edac/index.rst
@@ -8,4 +8,5 @@ EDAC Subsystem
    :maxdepth: 1
 
    features
+   memory_repair
    scrub
diff --git a/Documentation/edac/memory_repair.rst b/Documentation/edac/memory_repair.rst
new file mode 100644
index 000000000000..f22042ac3d91
--- /dev/null
+++ b/Documentation/edac/memory_repair.rst
@@ -0,0 +1,101 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+EDAC Memory Repair Control
+==========================
+
+Copyright (c) 2024 HiSilicon Limited.
+
+:Author:   Shiju Jose <shiju.jose@huawei.com>
+:License:  The GNU Free Documentation License, Version 1.2
+          (dual licensed under the GPL v2)
+:Original Reviewers:
+
+- Written for: 6.13
+
+Introduction
+------------
+Memory devices may support repair operations to address issues in their
+memory media. Post Package Repair (PPR) and memory sparing are examples
+of such features.
+
+Post Package Repair(PPR)
+~~~~~~~~~~~~~~~~~~~~~~~~
+Post Package Repair is a maintenance operation requests the memory device
+to perform repair operation on its media, in detail is a memory self-healing
+feature that fixes a failing memory location by replacing it with a spare
+row in a DRAM device. For example, a CXL memory device with DRAM components
+that support PPR features may implement PPR maintenance operations. DRAM
+components may support types of PPR functions, hard PPR, for a permanent row
+repair, and soft PPR, for a temporary row repair. Soft PPR is much faster
+than hard PPR, but the repair is lost with a power cycle.  The data may not
+be retained and memory requests may not be correctly processed during a
+repair operation. In such case, the repair operation should not executed
+at runtime.
+For example, CXL memory devices, soft PPR and hard PPR repair operations
+may be supported. See CXL spec rev 3.1 sections 8.2.9.7.1.1 PPR Maintenance
+Operations, 8.2.9.7.1.2 sPPR Maintenance Operation and 8.2.9.7.1.3 hPPR
+Maintenance Operation for more details.
+
+Memory Sparing
+~~~~~~~~~~~~~~
+Memory sparing is a repair function that replaces a portion of memory with
+a portion of functional memory at that same sparing granularity. Memory
+sparing has cacheline/row/bank/rank sparing granularities. For example, in
+memory-sparing mode, one memory rank serves as a spare for other ranks on
+the same channel in case they fail. The spare rank is held in reserve and
+not used as active memory until a failure is indicated, with reserved
+capacity subtracted from the total available memory in the system. The DIMM
+installation order for memory sparing varies based on the number of processors
+and memory modules installed in the server. After an error threshold is
+surpassed in a system protected by memory sparing, the content of a failing
+rank of DIMMs is copied to the spare rank. The failing rank is then taken
+offline and the spare rank placed online for use as active memory in place
+of the failed rank.
+
+For example, CXL memory devices may support various subclasses for sparing
+operation vary in terms of the scope of the sparing being performed.
+Cacheline sparing subclass refers to a sparing action that can replace a
+full cacheline. Row sparing is provided as an alternative to PPR sparing
+functions and its scope is that of a single DDR row. Bank sparing allows
+an entire bank to be replaced. Rank sparing is defined as an operation
+in which an entire DDR rank is replaced. See CXL spec 3.1 section
+8.2.9.7.1.4 Memory Sparing Maintenance Operations for more details.
+
+Use cases of generic memory repair features control
+---------------------------------------------------
+
+1. The soft PPR , hard PPR and memory-sparing features share similar
+control attributes. Therefore, there is a need for a standardized, generic
+sysfs repair control that is exposed to userspace and used by
+administrators, scripts and tools.
+
+2. When a CXL device detects an error in a memory component, it may inform
+the host of the need for a repair maintenance operation by using an event
+record where the "maintenance needed" flag is set. The event record
+specifies the device physical address(DPA) and attributes of the memory that
+requires repair. The kernel reports the corresponding CXL general media or
+DRAM trace event to userspace, and userspace tools (e.g. rasdaemon) initiate
+a repair maintenance operation in response to the device request using the
+sysfs repair control.
+
+3. Userspace tools, such as rasdaemon, may request a PPR/sparing on a memory
+region when an uncorrected memory error or an excess of corrected memory
+errors is reported on that memory.
+
+4. Multiple PPR/sparing instances may be present per memory device.
+
+The File System
+---------------
+
+The control attributes of a registered scrubber instance could be
+accessed in the
+
+/sys/bus/edac/devices/<dev-name>/mem_repairX/
+
+sysfs
+-----
+
+Sysfs files are documented in
+
+`Documentation/ABI/testing/sysfs-edac-memory-repair`.
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index b24c2c112d9c..d037bce88487 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
 
 edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
 edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
-edac_core-y	+= scrub.o ecs.o
+edac_core-y	+= scrub.o ecs.o mem_repair.o
 
 edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
 
diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 1c1142a2e4e4..a401d81dad8a 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -575,6 +575,7 @@ static void edac_dev_release(struct device *dev)
 {
 	struct edac_dev_feat_ctx *ctx = container_of(dev, struct edac_dev_feat_ctx, dev);
 
+	kfree(ctx->mem_repair);
 	kfree(ctx->scrub);
 	kfree(ctx->dev.groups);
 	kfree(ctx);
@@ -611,6 +612,7 @@ int edac_dev_register(struct device *parent, char *name,
 	const struct attribute_group **ras_attr_groups;
 	struct edac_dev_data *dev_data;
 	struct edac_dev_feat_ctx *ctx;
+	int mem_repair_cnt = 0;
 	int attr_gcnt = 0;
 	int scrub_cnt = 0;
 	int ret, feat;
@@ -628,6 +630,10 @@ int edac_dev_register(struct device *parent, char *name,
 		case RAS_FEAT_ECS:
 			attr_gcnt += ras_features[feat].ecs_info.num_media_frus;
 			break;
+		case RAS_FEAT_MEM_REPAIR:
+			attr_gcnt++;
+			mem_repair_cnt++;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -651,8 +657,17 @@ int edac_dev_register(struct device *parent, char *name,
 		}
 	}
 
+	if (mem_repair_cnt) {
+		ctx->mem_repair = kcalloc(mem_repair_cnt, sizeof(*ctx->mem_repair), GFP_KERNEL);
+		if (!ctx->mem_repair) {
+			ret = -ENOMEM;
+			goto data_mem_free;
+		}
+	}
+
 	attr_gcnt = 0;
 	scrub_cnt = 0;
+	mem_repair_cnt = 0;
 	for (feat = 0; feat < num_features; feat++, ras_features++) {
 		switch (ras_features->ft_type) {
 		case RAS_FEAT_SCRUB:
@@ -686,6 +701,23 @@ int edac_dev_register(struct device *parent, char *name,
 
 			attr_gcnt += ras_features->ecs_info.num_media_frus;
 			break;
+		case RAS_FEAT_MEM_REPAIR:
+			if (!ras_features->mem_repair_ops ||
+			    mem_repair_cnt != ras_features->instance)
+				goto data_mem_free;
+
+			dev_data = &ctx->mem_repair[mem_repair_cnt];
+			dev_data->instance = mem_repair_cnt;
+			dev_data->mem_repair_ops = ras_features->mem_repair_ops;
+			dev_data->private = ras_features->ctx;
+			ret = edac_mem_repair_get_desc(parent, &ras_attr_groups[attr_gcnt],
+						       ras_features->instance);
+			if (ret)
+				goto data_mem_free;
+
+			mem_repair_cnt++;
+			attr_gcnt++;
+			break;
 		default:
 			ret = -EINVAL;
 			goto data_mem_free;
@@ -712,6 +744,7 @@ int edac_dev_register(struct device *parent, char *name,
 	return devm_add_action_or_reset(parent, edac_dev_unreg, &ctx->dev);
 
 data_mem_free:
+	kfree(ctx->mem_repair);
 	kfree(ctx->scrub);
 groups_free:
 	kfree(ras_attr_groups);
diff --git a/drivers/edac/mem_repair.c b/drivers/edac/mem_repair.c
new file mode 100755
index 000000000000..e7439fd26c41
--- /dev/null
+++ b/drivers/edac/mem_repair.c
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The generic EDAC memory repair driver is designed to control the memory
+ * devices with memory repair features, such as Post Package Repair (PPR),
+ * memory sparing etc. The common sysfs memory repair interface abstracts
+ * the control of various arbitrary memory repair functionalities into a
+ * unified set of functions.
+ *
+ * Copyright (c) 2024 HiSilicon Limited.
+ */
+
+#include <linux/edac.h>
+
+enum edac_mem_repair_attributes {
+	MEM_REPAIR_FUNCTION,
+	MEM_REPAIR_PERSIST_MODE,
+	MEM_REPAIR_DPA_SUPPORT,
+	MEM_REPAIR_SAFE_IN_USE,
+	MEM_REPAIR_HPA,
+	MEM_REPAIR_MIN_HPA,
+	MEM_REPAIR_MAX_HPA,
+	MEM_REPAIR_DPA,
+	MEM_REPAIR_MIN_DPA,
+	MEM_REPAIR_MAX_DPA,
+	MEM_REPAIR_NIBBLE_MASK,
+	MEM_REPAIR_MIN_NIBBLE_MASK,
+	MEM_REPAIR_MAX_NIBBLE_MASK,
+	MEM_REPAIR_BANK_GROUP,
+	MEM_REPAIR_MIN_BANK_GROUP,
+	MEM_REPAIR_MAX_BANK_GROUP,
+	MEM_REPAIR_BANK,
+	MEM_REPAIR_MIN_BANK,
+	MEM_REPAIR_MAX_BANK,
+	MEM_REPAIR_RANK,
+	MEM_REPAIR_MIN_RANK,
+	MEM_REPAIR_MAX_RANK,
+	MEM_REPAIR_ROW,
+	MEM_REPAIR_MIN_ROW,
+	MEM_REPAIR_MAX_ROW,
+	MEM_REPAIR_COLUMN,
+	MEM_REPAIR_MIN_COLUMN,
+	MEM_REPAIR_MAX_COLUMN,
+	MEM_REPAIR_CHANNEL,
+	MEM_REPAIR_MIN_CHANNEL,
+	MEM_REPAIR_MAX_CHANNEL,
+	MEM_REPAIR_SUB_CHANNEL,
+	MEM_REPAIR_MIN_SUB_CHANNEL,
+	MEM_REPAIR_MAX_SUB_CHANNEL,
+	MEM_DO_REPAIR,
+	MEM_REPAIR_MAX_ATTRS
+};
+
+struct edac_mem_repair_dev_attr {
+	struct device_attribute dev_attr;
+	u8 instance;
+};
+
+struct edac_mem_repair_context {
+	char name[EDAC_FEAT_NAME_LEN];
+	struct edac_mem_repair_dev_attr mem_repair_dev_attr[MEM_REPAIR_MAX_ATTRS];
+	struct attribute *mem_repair_attrs[MEM_REPAIR_MAX_ATTRS + 1];
+	struct attribute_group group;
+};
+
+#define TO_MEM_REPAIR_DEV_ATTR(_dev_attr)      \
+		container_of(_dev_attr, struct edac_mem_repair_dev_attr, dev_attr)
+
+#define EDAC_MEM_REPAIR_ATTR_SHOW(attrib, cb, type, format)			\
+static ssize_t attrib##_show(struct device *ras_feat_dev,			\
+			     struct device_attribute *attr, char *buf)		\
+{										\
+	u8 inst = TO_MEM_REPAIR_DEV_ATTR(attr)->instance;			\
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
+	const struct edac_mem_repair_ops *ops =					\
+				ctx->mem_repair[inst].mem_repair_ops;		\
+	type data;								\
+	int ret;								\
+										\
+	ret = ops->cb(ras_feat_dev->parent, ctx->mem_repair[inst].private,	\
+		      &data);							\
+	if (ret)								\
+		return ret;							\
+										\
+	return sysfs_emit(buf, format, data);					\
+}
+
+EDAC_MEM_REPAIR_ATTR_SHOW(repair_function, get_repair_function, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(persist_mode, get_persist_mode, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(dpa_support, get_dpa_support, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(repair_safe_when_in_use, get_repair_safe_when_in_use, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(hpa, get_hpa, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(min_hpa, get_min_hpa, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(max_hpa, get_max_hpa, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(dpa, get_dpa, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(min_dpa, get_min_dpa, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(max_dpa, get_max_dpa, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(nibble_mask, get_nibble_mask, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(min_nibble_mask, get_min_nibble_mask, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(max_nibble_mask, get_max_nibble_mask, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(bank_group, get_bank_group, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(min_bank_group, get_min_bank_group, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(max_bank_group, get_max_bank_group, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(bank, get_bank, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(min_bank, get_min_bank, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(max_bank, get_max_bank, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(rank, get_rank, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(min_rank, get_min_rank, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(max_rank, get_max_rank, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(row, get_row, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(min_row, get_min_row, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(max_row, get_max_row, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(column, get_column, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(min_column, get_min_column, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(max_column, get_max_column, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(channel, get_channel, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(min_channel, get_min_channel, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(max_channel, get_max_channel, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(sub_channel, get_sub_channel, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(min_sub_channel, get_min_sub_channel, u32, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(max_sub_channel, get_max_sub_channel, u32, "%u\n")
+
+#define EDAC_MEM_REPAIR_ATTR_STORE(attrib, cb, type, conv_func)			\
+static ssize_t attrib##_store(struct device *ras_feat_dev,			\
+			      struct device_attribute *attr,			\
+			      const char *buf, size_t len)			\
+{										\
+	u8 inst = TO_MEM_REPAIR_DEV_ATTR(attr)->instance;			\
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
+	const struct edac_mem_repair_ops *ops =					\
+				ctx->mem_repair[inst].mem_repair_ops;		\
+	type data;								\
+	int ret;								\
+										\
+	ret = conv_func(buf, 0, &data);						\
+	if (ret < 0)								\
+		return ret;							\
+										\
+	ret = ops->cb(ras_feat_dev->parent, ctx->mem_repair[inst].private,	\
+		      data);							\
+	if (ret)								\
+		return ret;							\
+										\
+	return len;								\
+}
+
+EDAC_MEM_REPAIR_ATTR_STORE(persist_mode, set_persist_mode, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(hpa, set_hpa, u64, kstrtou64)
+EDAC_MEM_REPAIR_ATTR_STORE(dpa, set_dpa, u64, kstrtou64)
+EDAC_MEM_REPAIR_ATTR_STORE(nibble_mask, set_nibble_mask, u64, kstrtou64)
+EDAC_MEM_REPAIR_ATTR_STORE(bank_group, set_bank_group, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(bank, set_bank, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(rank, set_rank, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(row, set_row, u64, kstrtou64)
+EDAC_MEM_REPAIR_ATTR_STORE(column, set_column, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(channel, set_channel, unsigned long, kstrtoul)
+EDAC_MEM_REPAIR_ATTR_STORE(sub_channel, set_sub_channel, unsigned long, kstrtoul)
+
+#define EDAC_MEM_REPAIR_DO_OP(attrib, cb)						\
+static ssize_t attrib##_store(struct device *ras_feat_dev,				\
+			      struct device_attribute *attr,				\
+			      const char *buf, size_t len)				\
+{											\
+	u8 inst = TO_MEM_REPAIR_DEV_ATTR(attr)->instance;				\
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);			\
+	const struct edac_mem_repair_ops *ops = ctx->mem_repair[inst].mem_repair_ops;	\
+	unsigned long data;								\
+	int ret;									\
+											\
+	ret = kstrtoul(buf, 0, &data);							\
+	if (ret < 0)									\
+		return ret;								\
+											\
+	ret = ops->cb(ras_feat_dev->parent, ctx->mem_repair[inst].private, data);	\
+	if (ret)									\
+		return ret;								\
+											\
+	return len;									\
+}
+
+EDAC_MEM_REPAIR_DO_OP(repair, do_repair)
+
+static umode_t mem_repair_attr_visible(struct kobject *kobj, struct attribute *a, int attr_id)
+{
+	struct device *ras_feat_dev = kobj_to_dev(kobj);
+	struct device_attribute *dev_attr = container_of(a, struct device_attribute, attr);
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
+	u8 inst = TO_MEM_REPAIR_DEV_ATTR(dev_attr)->instance;
+	const struct edac_mem_repair_ops *ops = ctx->mem_repair[inst].mem_repair_ops;
+
+	switch (attr_id) {
+	case MEM_REPAIR_FUNCTION:
+		if (ops->get_repair_function)
+			return a->mode;
+		break;
+	case MEM_REPAIR_PERSIST_MODE:
+		if (ops->get_persist_mode) {
+			if (ops->set_persist_mode)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_DPA_SUPPORT:
+		if (ops->get_dpa_support)
+			return a->mode;
+		break;
+	case MEM_REPAIR_SAFE_IN_USE:
+		if (ops->get_repair_safe_when_in_use)
+			return a->mode;
+		break;
+	case MEM_REPAIR_HPA:
+		if (ops->get_hpa) {
+			if (ops->set_hpa)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_MIN_HPA:
+		if (ops->get_min_hpa)
+			return a->mode;
+		break;
+	case MEM_REPAIR_MAX_HPA:
+		if (ops->get_max_hpa)
+			return a->mode;
+		break;
+	case MEM_REPAIR_DPA:
+		if (ops->get_dpa) {
+			if (ops->set_dpa)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_MIN_DPA:
+		if (ops->get_min_dpa)
+			return a->mode;
+		break;
+	case MEM_REPAIR_MAX_DPA:
+		if (ops->get_max_dpa)
+			return a->mode;
+		break;
+	case MEM_REPAIR_NIBBLE_MASK:
+		if (ops->get_nibble_mask) {
+			if (ops->set_nibble_mask)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_MIN_NIBBLE_MASK:
+		if (ops->get_min_nibble_mask)
+			return a->mode;
+		break;
+	case MEM_REPAIR_MAX_NIBBLE_MASK:
+		if (ops->get_max_nibble_mask)
+			return a->mode;
+		break;
+	case MEM_REPAIR_BANK_GROUP:
+		if (ops->get_bank_group) {
+			if (ops->set_bank_group)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_MIN_BANK_GROUP:
+		if (ops->get_min_bank_group)
+			return a->mode;
+		break;
+	case MEM_REPAIR_MAX_BANK_GROUP:
+		if (ops->get_max_bank_group)
+			return a->mode;
+		break;
+	case MEM_REPAIR_BANK:
+		if (ops->get_bank) {
+			if (ops->set_bank)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_MIN_BANK:
+		if (ops->get_min_bank)
+			return a->mode;
+		break;
+	case MEM_REPAIR_MAX_BANK:
+		if (ops->get_max_bank)
+			return a->mode;
+		break;
+	case MEM_REPAIR_RANK:
+		if (ops->get_rank) {
+			if (ops->set_rank)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_MIN_RANK:
+		if (ops->get_min_rank)
+			return a->mode;
+		break;
+	case MEM_REPAIR_MAX_RANK:
+		if (ops->get_max_rank)
+			return a->mode;
+		break;
+	case MEM_REPAIR_ROW:
+		if (ops->get_row) {
+			if (ops->set_row)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_MIN_ROW:
+		if (ops->get_min_row)
+			return a->mode;
+		break;
+	case MEM_REPAIR_MAX_ROW:
+		if (ops->get_max_row)
+			return a->mode;
+		break;
+	case MEM_REPAIR_COLUMN:
+		if (ops->get_column) {
+			if (ops->set_column)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_MIN_COLUMN:
+		if (ops->get_min_column)
+			return a->mode;
+		break;
+	case MEM_REPAIR_MAX_COLUMN:
+		if (ops->get_max_column)
+			return a->mode;
+		break;
+	case MEM_REPAIR_CHANNEL:
+		if (ops->get_channel) {
+			if (ops->set_channel)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_MIN_CHANNEL:
+		if (ops->get_min_channel)
+			return a->mode;
+		break;
+	case MEM_REPAIR_MAX_CHANNEL:
+		if (ops->get_max_channel)
+			return a->mode;
+		break;
+	case MEM_REPAIR_SUB_CHANNEL:
+		if (ops->get_sub_channel) {
+			if (ops->set_sub_channel)
+				return a->mode;
+			else
+				return 0444;
+		}
+		break;
+	case MEM_REPAIR_MIN_SUB_CHANNEL:
+		if (ops->get_min_sub_channel)
+			return a->mode;
+		break;
+	case MEM_REPAIR_MAX_SUB_CHANNEL:
+		if (ops->get_max_sub_channel)
+			return a->mode;
+		break;
+	case MEM_DO_REPAIR:
+		if (ops->do_repair)
+			return a->mode;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+#define EDAC_MEM_REPAIR_ATTR_RO(_name, _instance)       \
+	((struct edac_mem_repair_dev_attr) { .dev_attr = __ATTR_RO(_name), \
+					     .instance = _instance })
+
+#define EDAC_MEM_REPAIR_ATTR_WO(_name, _instance)       \
+	((struct edac_mem_repair_dev_attr) { .dev_attr = __ATTR_WO(_name), \
+					     .instance = _instance })
+
+#define EDAC_MEM_REPAIR_ATTR_RW(_name, _instance)       \
+	((struct edac_mem_repair_dev_attr) { .dev_attr = __ATTR_RW(_name), \
+					     .instance = _instance })
+
+static int mem_repair_create_desc(struct device *dev,
+				  const struct attribute_group **attr_groups,
+				  u8 instance)
+{
+	struct edac_mem_repair_context *ctx;
+	struct attribute_group *group;
+	int i;
+	struct edac_mem_repair_dev_attr dev_attr[] = {
+		[MEM_REPAIR_FUNCTION] = EDAC_MEM_REPAIR_ATTR_RO(repair_function,
+							    instance),
+		[MEM_REPAIR_PERSIST_MODE] =
+				EDAC_MEM_REPAIR_ATTR_RW(persist_mode, instance),
+		[MEM_REPAIR_DPA_SUPPORT] =
+				EDAC_MEM_REPAIR_ATTR_RO(dpa_support, instance),
+		[MEM_REPAIR_SAFE_IN_USE] =
+				EDAC_MEM_REPAIR_ATTR_RO(repair_safe_when_in_use,
+							instance),
+		[MEM_REPAIR_HPA] = EDAC_MEM_REPAIR_ATTR_RW(hpa, instance),
+		[MEM_REPAIR_MIN_HPA] = EDAC_MEM_REPAIR_ATTR_RO(min_hpa, instance),
+		[MEM_REPAIR_MAX_HPA] = EDAC_MEM_REPAIR_ATTR_RO(max_hpa, instance),
+		[MEM_REPAIR_DPA] = EDAC_MEM_REPAIR_ATTR_RW(dpa, instance),
+		[MEM_REPAIR_MIN_DPA] = EDAC_MEM_REPAIR_ATTR_RO(min_dpa, instance),
+		[MEM_REPAIR_MAX_DPA] = EDAC_MEM_REPAIR_ATTR_RO(max_dpa, instance),
+		[MEM_REPAIR_NIBBLE_MASK] =
+				EDAC_MEM_REPAIR_ATTR_RW(nibble_mask, instance),
+		[MEM_REPAIR_MIN_NIBBLE_MASK] =
+				EDAC_MEM_REPAIR_ATTR_RO(min_nibble_mask, instance),
+		[MEM_REPAIR_MAX_NIBBLE_MASK] =
+				EDAC_MEM_REPAIR_ATTR_RO(max_nibble_mask, instance),
+		[MEM_REPAIR_BANK_GROUP] =
+				EDAC_MEM_REPAIR_ATTR_RW(bank_group, instance),
+		[MEM_REPAIR_MIN_BANK_GROUP] =
+				EDAC_MEM_REPAIR_ATTR_RO(min_bank_group, instance),
+		[MEM_REPAIR_MAX_BANK_GROUP] =
+				EDAC_MEM_REPAIR_ATTR_RO(max_bank_group, instance),
+		[MEM_REPAIR_BANK] = EDAC_MEM_REPAIR_ATTR_RW(bank, instance),
+		[MEM_REPAIR_MIN_BANK] = EDAC_MEM_REPAIR_ATTR_RO(min_bank, instance),
+		[MEM_REPAIR_MAX_BANK] = EDAC_MEM_REPAIR_ATTR_RO(max_bank, instance),
+		[MEM_REPAIR_RANK] = EDAC_MEM_REPAIR_ATTR_RW(rank, instance),
+		[MEM_REPAIR_MIN_RANK] = EDAC_MEM_REPAIR_ATTR_RO(min_rank, instance),
+		[MEM_REPAIR_MAX_RANK] = EDAC_MEM_REPAIR_ATTR_RO(max_rank, instance),
+		[MEM_REPAIR_ROW] = EDAC_MEM_REPAIR_ATTR_RW(row, instance),
+		[MEM_REPAIR_MIN_ROW] = EDAC_MEM_REPAIR_ATTR_RO(min_row, instance),
+		[MEM_REPAIR_MAX_ROW] = EDAC_MEM_REPAIR_ATTR_RO(max_row, instance),
+		[MEM_REPAIR_COLUMN] = EDAC_MEM_REPAIR_ATTR_RW(column, instance),
+		[MEM_REPAIR_MIN_COLUMN] = EDAC_MEM_REPAIR_ATTR_RO(min_column, instance),
+		[MEM_REPAIR_MAX_COLUMN] = EDAC_MEM_REPAIR_ATTR_RO(max_column, instance),
+		[MEM_REPAIR_CHANNEL] = EDAC_MEM_REPAIR_ATTR_RW(channel, instance),
+		[MEM_REPAIR_MIN_CHANNEL] = EDAC_MEM_REPAIR_ATTR_RO(min_channel, instance),
+		[MEM_REPAIR_MAX_CHANNEL] = EDAC_MEM_REPAIR_ATTR_RO(max_channel, instance),
+		[MEM_REPAIR_SUB_CHANNEL] =
+				EDAC_MEM_REPAIR_ATTR_RW(sub_channel, instance),
+		[MEM_REPAIR_MIN_SUB_CHANNEL] =
+				EDAC_MEM_REPAIR_ATTR_RO(min_sub_channel, instance),
+		[MEM_REPAIR_MAX_SUB_CHANNEL] =
+				EDAC_MEM_REPAIR_ATTR_RO(max_sub_channel, instance),
+		[MEM_DO_REPAIR] = EDAC_MEM_REPAIR_ATTR_WO(repair, instance)
+	};
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	for (i = 0; i < MEM_REPAIR_MAX_ATTRS; i++) {
+		memcpy(&ctx->mem_repair_dev_attr[i].dev_attr,
+		       &dev_attr[i], sizeof(dev_attr[i]));
+		ctx->mem_repair_attrs[i] =
+				&ctx->mem_repair_dev_attr[i].dev_attr.attr;
+	}
+
+	sprintf(ctx->name, "%s%d", "mem_repair", instance);
+	group = &ctx->group;
+	group->name = ctx->name;
+	group->attrs = ctx->mem_repair_attrs;
+	group->is_visible  = mem_repair_attr_visible;
+	attr_groups[0] = group;
+
+	return 0;
+}
+
+/**
+ * edac_mem_repair_get_desc - get EDAC memory repair descriptors
+ * @dev: client device with memory repair feature
+ * @attr_groups: pointer to attribute group container
+ * @instance: device's memory repair instance number.
+ *
+ * Return:
+ *  * %0	- Success.
+ *  * %-EINVAL	- Invalid parameters passed.
+ *  * %-ENOMEM	- Dynamic memory allocation failed.
+ */
+int edac_mem_repair_get_desc(struct device *dev,
+			     const struct attribute_group **attr_groups, u8 instance)
+{
+	if (!dev || !attr_groups)
+		return -EINVAL;
+
+	return mem_repair_create_desc(dev, attr_groups, instance);
+}
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 979e91426701..5d07192bf1a7 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -668,6 +668,7 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
 enum edac_dev_feat {
 	RAS_FEAT_SCRUB,
 	RAS_FEAT_ECS,
+	RAS_FEAT_MEM_REPAIR,
 	RAS_FEAT_MAX
 };
 
@@ -729,11 +730,147 @@ int edac_ecs_get_desc(struct device *ecs_dev,
 		      const struct attribute_group **attr_groups,
 		      u16 num_media_frus);
 
+enum edac_mem_repair_function {
+	EDAC_SOFT_PPR,
+	EDAC_HARD_PPR,
+	EDAC_CACHELINE_MEM_SPARING,
+	EDAC_ROW_MEM_SPARING,
+	EDAC_BANK_MEM_SPARING,
+	EDAC_RANK_MEM_SPARING,
+};
+
+enum edac_mem_repair_persist_mode {
+	EDAC_MEM_REPAIR_SOFT, /* soft memory repair */
+	EDAC_MEM_REPAIR_HARD, /* hard memory repair */
+};
+
+enum edac_mem_repair_cmd {
+	EDAC_DO_MEM_REPAIR = 1,
+};
+
+/**
+ * struct edac_mem_repair_ops - memory repair operations
+ * (all elements are optional except do_repair, set_hpa/set_dpa)
+ * @get_repair_function: get the memory repair function, listed in
+ *			 enum edac_mem_repair_function.
+ * @get_persist_mode: get the current persist mode. Persist repair modes supported
+ *		      in the device is based on the memory repair function which is
+ *		      temporary or permanent and is lost with a power cycle.
+ *		      EDAC_MEM_REPAIR_SOFT - Soft repair function (temporary repair).
+ *		      EDAC_MEM_REPAIR_HARD - Hard memory repair function (permanent repair).
+ * All other values are reserved.
+ * @set_persist_mode: set the persist mode of the memory repair instance.
+ * @get_dpa_support: get dpa support flag. In some states of system configuration
+ *		     (e.g. before address decoders have been configured), memory devices
+ *		     (e.g. CXL) may not have an active mapping in the main host address
+ *		     physical address map. As such, the memory to repair must be identified
+ *		     by a device specific physical addressing scheme using a device physical
+ *		     address(DPA). The DPA and other control attributes to use for the
+ *		     dry_run and repair operations will be presented in related error records.
+ * @get_repair_safe_when_in_use: get whether memory media is accessible and
+ *				 data is retained during repair operation.
+ * @get_hpa: get current host physical address (HPA).
+ * @set_hpa: set host physical address (HPA) of memory to repair.
+ * @get_min_hpa: get the minimum supported host physical address (HPA).
+ * @get_max_hpa: get the maximum supported host physical address (HPA).
+ * @get_dpa: get current device physical address (DPA).
+ * @set_dpa: set device physical address (DPA) of memory to repair.
+ * @get_min_dpa: get the minimum supported device physical address (DPA).
+ * @get_max_dpa: get the maximum supported device physical address (DPA).
+ * @get_nibble_mask: get current nibble mask.
+ * @set_nibble_mask: set nibble mask of memory to repair.
+ * @get_min_nibble_mask: get the minimum supported nibble mask.
+ * @get_max_nibble_mask: get the maximum supported nibble mask.
+ * @get_bank_group: get current bank group.
+ * @set_bank_group: set bank group of memory to repair.
+ * @get_min_bank_group: get the minimum supported bank group.
+ * @get_max_bank_group: get the maximum supported bank group.
+ * @get_bank: get current bank.
+ * @set_bank: set bank of memory to repair.
+ * @get_min_bank: get the minimum supported bank.
+ * @get_max_bank: get the maximum supported bank.
+ * @get_rank: get current rank.
+ * @set_rank: set rank of memory to repair.
+ * @get_min_rank: get the minimum supported rank.
+ * @get_max_rank: get the maximum supported rank.
+ * @get_row: get current row.
+ * @set_row: set row of memory to repair.
+ * @get_min_row: get the minimum supported row.
+ * @get_max_row: get the maximum supported row.
+ * @get_column: get current column.
+ * @set_column: set column of memory to repair.
+ * @get_min_column: get the minimum supported column.
+ * @get_max_column: get the maximum supported column.
+ * @get_channel: get current channel.
+ * @set_channel: set channel of memory to repair.
+ * @get_min_channel: get the minimum supported channel.
+ * @get_max_channel: get the maximum supported channel.
+ * @get_sub_channel: get current sub channel.
+ * @set_sub_channel: set sub channel of memory to repair.
+ * @get_min_sub_channel: get the minimum supported sub channel.
+ * @get_max_sub_channel: get the maximum supported sub channel.
+ * @do_repair: Issue memory repair operation for the HPA/DPA and
+ *	       other control attributes set for the memory to repair.
+ */
+struct edac_mem_repair_ops {
+	int (*get_repair_function)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_persist_mode)(struct device *dev, void *drv_data, u32 *mode);
+	int (*set_persist_mode)(struct device *dev, void *drv_data, u32 mode);
+	int (*get_dpa_support)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_repair_safe_when_in_use)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_hpa)(struct device *dev, void *drv_data, u64 *hpa);
+	int (*set_hpa)(struct device *dev, void *drv_data, u64 hpa);
+	int (*get_min_hpa)(struct device *dev, void *drv_data, u64 *hpa);
+	int (*get_max_hpa)(struct device *dev, void *drv_data, u64 *hpa);
+	int (*get_dpa)(struct device *dev, void *drv_data, u64 *dpa);
+	int (*set_dpa)(struct device *dev, void *drv_data, u64 dpa);
+	int (*get_min_dpa)(struct device *dev, void *drv_data, u64 *dpa);
+	int (*get_max_dpa)(struct device *dev, void *drv_data, u64 *dpa);
+	int (*get_nibble_mask)(struct device *dev, void *drv_data, u64 *val);
+	int (*set_nibble_mask)(struct device *dev, void *drv_data, u64 val);
+	int (*get_min_nibble_mask)(struct device *dev, void *drv_data, u64 *val);
+	int (*get_max_nibble_mask)(struct device *dev, void *drv_data, u64 *val);
+	int (*get_bank_group)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_bank_group)(struct device *dev, void *drv_data, u32 val);
+	int (*get_min_bank_group)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_max_bank_group)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_bank)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_bank)(struct device *dev, void *drv_data, u32 val);
+	int (*get_min_bank)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_max_bank)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_rank)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_rank)(struct device *dev, void *drv_data, u32 val);
+	int (*get_min_rank)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_max_rank)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_row)(struct device *dev, void *drv_data, u64 *val);
+	int (*set_row)(struct device *dev, void *drv_data, u64 val);
+	int (*get_min_row)(struct device *dev, void *drv_data, u64 *val);
+	int (*get_max_row)(struct device *dev, void *drv_data, u64 *val);
+	int (*get_column)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_column)(struct device *dev, void *drv_data, u32 val);
+	int (*get_min_column)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_max_column)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_channel)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_channel)(struct device *dev, void *drv_data, u32 val);
+	int (*get_min_channel)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_max_channel)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_sub_channel)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_sub_channel)(struct device *dev, void *drv_data, u32 val);
+	int (*get_min_sub_channel)(struct device *dev, void *drv_data, u32 *val);
+	int (*get_max_sub_channel)(struct device *dev, void *drv_data, u32 *val);
+	int (*do_repair)(struct device *dev, void *drv_data, u32 val);
+};
+
+int edac_mem_repair_get_desc(struct device *dev,
+			     const struct attribute_group **attr_groups,
+			     u8 instance);
+
 /* EDAC device feature information structure */
 struct edac_dev_data {
 	union {
 		const struct edac_scrub_ops *scrub_ops;
 		const struct edac_ecs_ops *ecs_ops;
+		const struct edac_mem_repair_ops *mem_repair_ops;
 	};
 	u8 instance;
 	void *private;
@@ -744,6 +881,7 @@ struct edac_dev_feat_ctx {
 	void *private;
 	struct edac_dev_data *scrub;
 	struct edac_dev_data ecs;
+	struct edac_dev_data *mem_repair;
 };
 
 struct edac_dev_feature {
@@ -752,6 +890,7 @@ struct edac_dev_feature {
 	union {
 		const struct edac_scrub_ops *scrub_ops;
 		const struct edac_ecs_ops *ecs_ops;
+		const struct edac_mem_repair_ops *mem_repair_ops;
 	};
 	void *ctx;
 	struct edac_ecs_ex_info ecs_info;
-- 
2.43.0


