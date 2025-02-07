Return-Path: <linux-edac+bounces-2981-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B2BA2C5E1
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 15:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3C81882710
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 14:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FFD240611;
	Fri,  7 Feb 2025 14:45:39 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A708A2405E3;
	Fri,  7 Feb 2025 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939539; cv=none; b=Q967RKYf8aON3G/BmQCQFKDyvXV33yzsJ/NVA3Mdrh/yj19r58lDf7AwhnWXgr5tcR5nqItl2w36bc/qxKV0AyYGrQ6G6EyrTjMcZnbloicfB0gmyXS3PB8uav8+KURdU+jL8GKVqZgDlmDM9bfXRGfK8rJbVfzDzaV0do/b+ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939539; c=relaxed/simple;
	bh=czVt5kLHyt3wsAmGOUrOrU4aTmQJvYkeigkjWk81LXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOSnLa0rWDKOmmguGGXWf3r2vdos1zayuA0jn/2Iwca1I4rC3knF5UP/Kv+B89jvLQVKzbAZ58S2pSTLyBMjo02xzVwYMsuVdricQcExTaIq+iGNLKHGfJOGZIrlGdMV/nRLapIunXMPHKvN/5u5wq+Q6yfVxnUKl2f1MpGpBNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqGtC6jWjz6H7dL;
	Fri,  7 Feb 2025 22:43:15 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E4C5140A30;
	Fri,  7 Feb 2025 22:45:34 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.173.5) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Feb 2025 15:45:32 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
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
Subject: [PATCH v19 04/15] EDAC: Add memory repair control feature
Date: Fri, 7 Feb 2025 14:44:33 +0000
Message-ID: <20250207144445.1879-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250207144445.1879-1-shiju.jose@huawei.com>
References: <20250207144445.1879-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add a generic EDAC memory repair control driver to manage memory repairs
in the system, such as CXL Post Package Repair (PPR) and other soft and
hard PPR features.

For example, a CXL device with DRAM components that support PPR features
may implement PPR maintenance operations. DRAM components may support two
types of PPR, hard PPR, for a permanent row repair, and soft PPR,  for a
temporary row repair. Soft PPR is much faster than hard PPR, but the repair
is lost with a power cycle.

When a CXL device detects an error in a memory, it may report the need
for a repair maintenance operation by using an event record where the
"maintenance needed" flag is set. The event records contains the device
physical address(DPA) and other optional attributes of the memory to
repair. The kernel will report the corresponding CXL general media or
DRAM trace event to userspace, and userspace tools (e.g. rasdaemon) will
initiate a repair operation in response to the device request via the
sysfs repair control.

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
 .../ABI/testing/sysfs-edac-memory-repair      | 149 ++++++++++
 Documentation/edac/features.rst               |   4 +
 Documentation/edac/index.rst                  |   1 +
 Documentation/edac/memory_repair.rst          | 106 +++++++
 drivers/edac/Kconfig                          |  10 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/edac_device.c                    |  33 +++
 drivers/edac/mem_repair.c                     | 280 ++++++++++++++++++
 include/linux/edac.h                          |  74 +++++
 9 files changed, 658 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-edac-memory-repair
 create mode 100644 Documentation/edac/memory_repair.rst
 create mode 100755 drivers/edac/mem_repair.c

diff --git a/Documentation/ABI/testing/sysfs-edac-memory-repair b/Documentation/ABI/testing/sysfs-edac-memory-repair
new file mode 100644
index 000000000000..c54f59e4497b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-edac-memory-repair
@@ -0,0 +1,149 @@
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX
+Date:		March 2025
+KernelVersion:	6.15
+Contact:	linux-edac@vger.kernel.org
+Description:
+		The sysfs EDAC bus devices /<dev-name>/mem_repairX subdirectory
+		pertains to the memory media repair features control, such as
+		PPR (Post Package Repair), memory sparing etc, where <dev-name>
+		directory corresponds to a device registered with the EDAC
+		device driver for the memory repair features.
+
+		Post Package Repair is a maintenance operation requests the memory
+		device to perform a repair operation on its media. It is a memory
+		self-healing feature that fixes a failing memory location by
+		replacing it with a spare row in a DRAM device. For example, a
+		CXL memory device with DRAM components that support PPR features may
+		implement PPR maintenance operations. DRAM components may support
+		two types of PPR functions: hard PPR, for a permanent row repair, and
+		soft PPR, for a temporary row repair. Soft PPR may be much faster
+		than hard PPR, but the repair is lost with a power cycle.
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
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/repair_type
+Date:		March 2025
+KernelVersion:	6.15
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) Memory repair type. For eg. post package repair,
+		memory sparing etc. Valid values are:
+
+		- ppr - Post package repair.
+
+		- All other values are reserved.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/persist_mode
+Date:		March 2025
+KernelVersion:	6.15
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Get/Set the current persist repair mode set for a
+		repair function. Persist repair modes supported in the
+		device, based on a memory repair function, either is temporary,
+		which is lost with a power cycle or permanent. Valid values are:
+
+		- 0 - Soft memory repair (temporary repair).
+
+		- 1 - Hard memory repair (permanent repair).
+
+		- All other values are reserved.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/repair_safe_when_in_use
+Date:		March 2025
+KernelVersion:	6.15
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RO) True if memory media is accessible and data is retained
+		during the memory repair operation.
+		The data may not be retained and memory requests may not be
+		correctly processed during a repair operation. In such case
+		repair operation can not be executed at runtime. The memory
+		must be taken offline.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/hpa
+Date:		March 2025
+KernelVersion:	6.15
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Host Physical Address (HPA) of the memory to repair.
+		The HPA to use will be provided in related error records.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/dpa
+Date:		March 2025
+KernelVersion:	6.15
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) Device Physical Address (DPA) of the memory to repair.
+		The specific DPA to use will be provided in related error
+		records.
+
+		In some states of system configuration (e.g. before address
+		decoders have been configured), memory devices (e.g. CXL)
+		may not have an active mapping in the main host address
+		physical address map. As such, the memory to repair must be
+		identified by a device specific physical addressing scheme
+		using a DPA. The device physical address(DPA) to use will be
+		presented in related error records.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/nibble_mask
+Date:		March 2025
+KernelVersion:	6.15
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
+		devices. Eg. for CXL memory repair, the specific value of
+		nibble mask to use will be provided in related error records.
+		For more details, See nibble mask field in CXL spec ver 3.1,
+		section 8.2.9.7.1.2 Table 8-103 soft PPR and section
+		8.2.9.7.1.3 Table 8-104 hard PPR, section 8.2.9.7.1.4
+		Table 8-105 memory sparing.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_hpa
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_hpa
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_dpa
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_dpa
+Date:		March 2025
+KernelVersion:	6.15
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(RW) The supported range of memory address that is to be
+		repaired. The memory device may give the supported range of
+		attributes to use and it will depend on the memory device
+		and the portion of memory to repair.
+		The userspace may receive the specific value of attributes
+		to use for a repair operation from the memory device via
+		related error records and trace events, for eg. CXL DRAM
+		and CXL general media error records in CXL memory devices.
+
+What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/repair
+Date:		March 2025
+KernelVersion:	6.15
+Contact:	linux-edac@vger.kernel.org
+Description:
+		(WO) Issue the memory repair operation for the specified
+		memory repair attributes. The operation may fail if resources
+		are insufficient based on the requirements of the memory
+		device and repair function.
+
+		- 1 - Issue the repair operation.
+
+		- All other values are reserved.
diff --git a/Documentation/edac/features.rst b/Documentation/edac/features.rst
index 942d7a92b8d7..9ef96734a519 100644
--- a/Documentation/edac/features.rst
+++ b/Documentation/edac/features.rst
@@ -98,3 +98,7 @@ RAS features
 1. Memory Scrub
 
 Memory scrub features are documented in `Documentation/edac/scrub.rst`.
+
+2. Memory Repair
+
+Memory repair features are documented in `Documentation/edac/memory_repair.rst`.
diff --git a/Documentation/edac/index.rst b/Documentation/edac/index.rst
index 0a00c23838b6..420c6601dbae 100644
--- a/Documentation/edac/index.rst
+++ b/Documentation/edac/index.rst
@@ -8,4 +8,5 @@ EDAC Subsystem
    :maxdepth: 1
 
    features
+   memory_repair
    scrub
diff --git a/Documentation/edac/memory_repair.rst b/Documentation/edac/memory_repair.rst
new file mode 100644
index 000000000000..7ccca02632f5
--- /dev/null
+++ b/Documentation/edac/memory_repair.rst
@@ -0,0 +1,106 @@
+.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.2-no-invariants-or-later
+
+==========================
+EDAC Memory Repair Control
+==========================
+
+Copyright (c) 2024-2025 HiSilicon Limited.
+
+:Author:   Shiju Jose <shiju.jose@huawei.com>
+:License:  The GNU Free Documentation License, Version 1.2 without
+           Invariant Sections, Front-Cover Texts nor Back-Cover Texts.
+           (dual licensed under the GPL v2)
+:Original Reviewers:
+
+- Written for: 6.15
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
+to perform repair operation on its media. It is a memory self-healing
+feature that fixes a failing memory location by replacing it with a spare
+row in a DRAM device. For example, a CXL memory device with DRAM components
+that support PPR features may implement PPR maintenance operations. DRAM
+components may support types of PPR functions, hard PPR, for a permanent row
+repair, and soft PPR, for a temporary row repair. Soft PPR is much faster
+than hard PPR, but the repair is lost with a power cycle.  The data may not
+be retained and memory requests may not be correctly processed during a
+repair operation. In such case, the repair operation should not executed
+at runtime.
+
+For example, CXL memory devices, soft PPR and hard PPR repair operations
+may be supported. See CXL spec rev 3.1 [1]_ sections 8.2.9.7.1.1 PPR
+Maintenance Operations, 8.2.9.7.1.2 sPPR Maintenance Operation and
+8.2.9.7.1.3 hPPR Maintenance Operation for more details.
+
+Memory Sparing
+~~~~~~~~~~~~~~
+Memory sparing is a repair function that replaces a portion of memory with
+a portion of functional memory at a particular granularity. Memory
+sparing has cacheline/row/bank/rank sparing granularities. For example, in
+rank memory-sparing mode, one memory rank serves as a spare for other ranks
+on the same channel in case they fail. The spare rank is held in reserve and
+not used as active memory until a failure is indicated, with reserved
+capacity subtracted from the total available memory in the system.
+After an error threshold is surpassed in a system protected by memory sparing,
+the content of a failing rank of DIMMs is copied to the spare rank. The
+failing rank is then taken offline and the spare rank placed online for
+use as active memory in place of the failed rank.
+
+For example, CXL memory devices may support various subclasses for sparing
+operation vary in terms of the scope of the sparing being performed.
+Cacheline sparing subclass refers to a sparing action that can replace a
+full cacheline. Row sparing is provided as an alternative to PPR sparing
+functions and its scope is that of a single DDR row. Bank sparing allows
+an entire bank to be replaced. Rank sparing is defined as an operation
+in which an entire DDR rank is replaced. See CXL spec 3.1 [1]_ section
+8.2.9.7.1.4 Memory Sparing Maintenance Operations for more details.
+
+.. [1] https://computeexpresslink.org/cxl-specification/
+
+Use cases of generic memory repair features control
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+1. The soft PPR, hard PPR and memory-sparing features share similar
+   control attributes. Therefore, there is a need for a standardized, generic
+   sysfs repair control that is exposed to userspace and used by
+   administrators, scripts and tools.
+
+2. When a CXL device detects an error in a memory component, it may inform
+   the host of the need for a repair maintenance operation by using an event
+   record where the "maintenance needed" flag is set. The event record
+   specifies the device physical address(DPA) and attributes of the memory that
+   requires repair. The kernel reports the corresponding CXL general media or
+   DRAM trace event to userspace, and userspace tools (e.g. rasdaemon) initiate
+   a repair maintenance operation in response to the device request using the
+   sysfs repair control.
+
+3. Userspace tools, such as rasdaemon, may request a repair operation on a
+   memory region when maintenance need flag set or an uncorrected memory error
+   or excess of corrected memory errors above a threshold value is reported or
+   an exceed corrected errors threshold flag set for that memory.
+
+4. Multiple PPR/sparing instances may be present per memory device.
+
+5. Drivers should enforce that live repair is safe. In systems where memory
+   mapping functions may change between boots, one approach to this is to log
+   memory errors seen on this boot against which to check live memory repair
+   requests.
+
+The File System
+---------------
+
+The control attributes of a registered memory repair instance could be
+accessed in the /sys/bus/edac/devices/<dev-name>/mem_repairX/
+
+sysfs
+-----
+
+Sysfs files are documented in
+`Documentation/ABI/testing/sysfs-edac-memory-repair`.
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 9dfc2ea02df1..703522d5d6c3 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -93,6 +93,16 @@ config EDAC_ECS
 	  into a unified set of functions.
 	  Say 'y/n' to enable/disable EDAC ECS feature.
 
+config EDAC_MEM_REPAIR
+	bool "EDAC memory repair feature"
+	help
+	  The EDAC memory repair feature is optional and is designed to control
+	  the memory devices with repair features, such as Post Package Repair
+	  (PPR), memory sparing etc. The common sysfs memory repair interface
+	  abstracts the control of various memory repair functionalities into
+	  a unified set of functions.
+	  Say 'y/n' to enable/disable EDAC memory repair feature.
+
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 21334b909ec4..a342ea7a5f19 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -15,6 +15,7 @@ edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
 
 edac_core-$(CONFIG_EDAC_SCRUB)		+= scrub.o
 edac_core-$(CONFIG_EDAC_ECS)		+= ecs.o
+edac_core-$(CONFIG_EDAC_MEM_REPAIR)	+= mem_repair.o
 
 ifdef CONFIG_PCI
 edac_core-y	+= edac_pci.o edac_pci_sysfs.o
diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index a8421dc9ab3c..15c96b0bdd5b 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -575,6 +575,7 @@ static void edac_dev_release(struct device *dev)
 {
 	struct edac_dev_feat_ctx *ctx = container_of(dev, struct edac_dev_feat_ctx, dev);
 
+	kfree(ctx->mem_repair);
 	kfree(ctx->scrub);
 	kfree(ctx->dev.groups);
 	kfree(ctx);
@@ -613,6 +614,7 @@ int edac_dev_register(struct device *parent, char *name,
 	const struct attribute_group **ras_attr_groups;
 	struct edac_dev_data *dev_data;
 	struct edac_dev_feat_ctx *ctx;
+	int mem_repair_cnt = 0;
 	int attr_gcnt = 0;
 	int scrub_cnt = 0;
 	int ret, feat;
@@ -630,6 +632,10 @@ int edac_dev_register(struct device *parent, char *name,
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
@@ -653,8 +659,17 @@ int edac_dev_register(struct device *parent, char *name,
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
@@ -688,6 +703,23 @@ int edac_dev_register(struct device *parent, char *name,
 
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
@@ -714,6 +746,7 @@ int edac_dev_register(struct device *parent, char *name,
 	return devm_add_action_or_reset(parent, edac_dev_unreg, &ctx->dev);
 
 data_mem_free:
+	kfree(ctx->mem_repair);
 	kfree(ctx->scrub);
 groups_free:
 	kfree(ras_attr_groups);
diff --git a/drivers/edac/mem_repair.c b/drivers/edac/mem_repair.c
new file mode 100755
index 000000000000..9fe310050464
--- /dev/null
+++ b/drivers/edac/mem_repair.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The generic EDAC memory repair driver is designed to control the memory
+ * devices with memory repair features, such as Post Package Repair (PPR),
+ * memory sparing etc. The common sysfs memory repair interface abstracts
+ * the control of various arbitrary memory repair functionalities into a
+ * unified set of functions.
+ *
+ * Copyright (c) 2024-2025 HiSilicon Limited.
+ */
+
+#include <linux/edac.h>
+
+enum edac_mem_repair_attributes {
+	MEM_REPAIR_TYPE,
+	MEM_REPAIR_PERSIST_MODE,
+	MEM_REPAIR_SAFE_IN_USE,
+	MEM_REPAIR_HPA,
+	MEM_REPAIR_MIN_HPA,
+	MEM_REPAIR_MAX_HPA,
+	MEM_REPAIR_DPA,
+	MEM_REPAIR_MIN_DPA,
+	MEM_REPAIR_MAX_DPA,
+	MEM_REPAIR_NIBBLE_MASK,
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
+	container_of(_dev_attr, struct edac_mem_repair_dev_attr, dev_attr)
+
+#define EDAC_MEM_REPAIR_ATTR_SHOW(attrib, cb, type, format)			\
+static ssize_t attrib##_show(struct device *ras_feat_dev,			\
+			     struct device_attribute *attr, char *buf)		\
+{										\
+	u8 inst = TO_MEM_REPAIR_DEV_ATTR(attr)->instance;			\
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
+	const struct edac_mem_repair_ops *ops =					\
+		ctx->mem_repair[inst].mem_repair_ops;				\
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
+EDAC_MEM_REPAIR_ATTR_SHOW(repair_type, get_repair_type, const char *, "%s\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(persist_mode, get_persist_mode, bool, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(repair_safe_when_in_use, get_repair_safe_when_in_use, bool, "%u\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(hpa, get_hpa, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(min_hpa, get_min_hpa, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(max_hpa, get_max_hpa, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(dpa, get_dpa, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(min_dpa, get_min_dpa, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(max_dpa, get_max_dpa, u64, "0x%llx\n")
+EDAC_MEM_REPAIR_ATTR_SHOW(nibble_mask, get_nibble_mask, u32, "0x%x\n")
+
+#define EDAC_MEM_REPAIR_ATTR_STORE(attrib, cb, type, conv_func)			\
+static ssize_t attrib##_store(struct device *ras_feat_dev,			\
+			      struct device_attribute *attr,			\
+			      const char *buf, size_t len)			\
+{										\
+	u8 inst = TO_MEM_REPAIR_DEV_ATTR(attr)->instance;			\
+	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
+	const struct edac_mem_repair_ops *ops =					\
+		ctx->mem_repair[inst].mem_repair_ops;				\
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
+EDAC_MEM_REPAIR_ATTR_STORE(nibble_mask, set_nibble_mask, unsigned long, kstrtoul)
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
+	case MEM_REPAIR_TYPE:
+		if (ops->get_repair_type)
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
+		[MEM_REPAIR_TYPE] = EDAC_MEM_REPAIR_ATTR_RO(repair_type,
+							    instance),
+		[MEM_REPAIR_PERSIST_MODE] =
+				EDAC_MEM_REPAIR_ATTR_RW(persist_mode, instance),
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
+			&ctx->mem_repair_dev_attr[i].dev_attr.attr;
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
index f8346014c14e..cfb2ef41ab95 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -668,6 +668,7 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
 enum edac_dev_feat {
 	RAS_FEAT_SCRUB,
 	RAS_FEAT_ECS,
+	RAS_FEAT_MEM_REPAIR,
 	RAS_FEAT_MAX
 };
 
@@ -743,11 +744,82 @@ static inline int edac_ecs_get_desc(struct device *ecs_dev,
 { return -EOPNOTSUPP; }
 #endif /* CONFIG_EDAC_ECS */
 
+enum edac_mem_repair_type {
+	EDAC_REPAIR_MAX
+};
+
+enum edac_mem_repair_cmd {
+	EDAC_DO_MEM_REPAIR = 1,
+};
+
+/**
+ * struct edac_mem_repair_ops - memory repair operations
+ * (all elements are optional except do_repair, set_hpa/set_dpa)
+ * @get_repair_type: get the memory repair type, listed in
+ *			 enum edac_mem_repair_function.
+ * @get_persist_mode: get the current persist mode.
+ *		      false - Soft repair type (temporary repair).
+ *		      true - Hard memory repair type (permanent repair).
+ * @set_persist_mode: set the persist mode of the memory repair instance.
+ * @get_repair_safe_when_in_use: get whether memory media is accessible and
+ *				 data is retained during repair operation.
+ * @get_hpa: get current host physical address (HPA) of memory to repair.
+ * @set_hpa: set host physical address (HPA) of memory to repair.
+ * @get_min_hpa: get the minimum supported host physical address (HPA).
+ * @get_max_hpa: get the maximum supported host physical address (HPA).
+ * @get_dpa: get current device physical address (DPA) of memory to repair.
+ * @set_dpa: set device physical address (DPA) of memory to repair.
+ *	     In some states of system configuration (e.g. before address decoders
+ *	     have been configured), memory devices (e.g. CXL) may not have an active
+ *	     mapping in the host physical address map. As such, the memory
+ *	     to repair must be identified by a device specific physical addressing
+ *	     scheme using a device physical address(DPA). The DPA and other control
+ *	     attributes to use for the repair operations will be presented in related
+ *	     error records.
+ * @get_min_dpa: get the minimum supported device physical address (DPA).
+ * @get_max_dpa: get the maximum supported device physical address (DPA).
+ * @get_nibble_mask: get current nibble mask of memory to repair.
+ * @set_nibble_mask: set nibble mask of memory to repair.
+ * @do_repair: Issue memory repair operation for the HPA/DPA and
+ *	       other control attributes set for the memory to repair.
+ *
+ * All elements are optional except do_repair and at least one of set_hpa/set_dpa.
+ */
+struct edac_mem_repair_ops {
+	int (*get_repair_type)(struct device *dev, void *drv_data, const char **type);
+	int (*get_persist_mode)(struct device *dev, void *drv_data, bool *persist);
+	int (*set_persist_mode)(struct device *dev, void *drv_data, bool persist);
+	int (*get_repair_safe_when_in_use)(struct device *dev, void *drv_data, bool *safe);
+	int (*get_hpa)(struct device *dev, void *drv_data, u64 *hpa);
+	int (*set_hpa)(struct device *dev, void *drv_data, u64 hpa);
+	int (*get_min_hpa)(struct device *dev, void *drv_data, u64 *hpa);
+	int (*get_max_hpa)(struct device *dev, void *drv_data, u64 *hpa);
+	int (*get_dpa)(struct device *dev, void *drv_data, u64 *dpa);
+	int (*set_dpa)(struct device *dev, void *drv_data, u64 dpa);
+	int (*get_min_dpa)(struct device *dev, void *drv_data, u64 *dpa);
+	int (*get_max_dpa)(struct device *dev, void *drv_data, u64 *dpa);
+	int (*get_nibble_mask)(struct device *dev, void *drv_data, u32 *val);
+	int (*set_nibble_mask)(struct device *dev, void *drv_data, u32 val);
+	int (*do_repair)(struct device *dev, void *drv_data, u32 val);
+};
+
+#if IS_ENABLED(CONFIG_EDAC_MEM_REPAIR)
+int edac_mem_repair_get_desc(struct device *dev,
+			     const struct attribute_group **attr_groups,
+			     u8 instance);
+#else
+static inline int edac_mem_repair_get_desc(struct device *dev,
+					   const struct attribute_group **attr_groups,
+					   u8 instance)
+{ return -EOPNOTSUPP; }
+#endif /* CONFIG_EDAC_MEM_REPAIR */
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
@@ -758,6 +830,7 @@ struct edac_dev_feat_ctx {
 	void *private;
 	struct edac_dev_data *scrub;
 	struct edac_dev_data ecs;
+	struct edac_dev_data *mem_repair;
 };
 
 struct edac_dev_feature {
@@ -766,6 +839,7 @@ struct edac_dev_feature {
 	union {
 		const struct edac_scrub_ops *scrub_ops;
 		const struct edac_ecs_ops *ecs_ops;
+		const struct edac_mem_repair_ops *mem_repair_ops;
 	};
 	void *ctx;
 	struct edac_ecs_ex_info ecs_info;
-- 
2.43.0


