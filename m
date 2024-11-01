Return-Path: <linux-edac+bounces-2402-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826E09B8DB7
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2024 10:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42477284686
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2024 09:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199EB1A0AFB;
	Fri,  1 Nov 2024 09:18:43 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1E319F437;
	Fri,  1 Nov 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730452723; cv=none; b=as9lvzbc5D8oJBsv1D5omYDjhVhpj/KhS4CtQFQiUFzMAfzAfeJ0sltUmj+gCfwOLdznxxtdcD8wPoqVT2qt+asK8ZJJJzbTcbqTif45F0acojsljLvTZLv7wd7zPXv40SKqlfnpSxNoTwXYGcxNPxUx/FAMYWPe05/vP78bR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730452723; c=relaxed/simple;
	bh=miqxuLoHl2YVbn6sbhF0k2wOoQVI5CsTr2GZNUX9TS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEwJ4xHR2UlXU7teNjk5pXOHSinx7++0SSqWCXysleGS2obaoNeetMIYF/IQVrPg7L0jH9sp7OUIFTYg8ix2FwBb+/URwua6l4Ln20jB5fVbHJ4ySl7QBoljfXYJ2lQ1+yiTuBryNP1VwxQguMiSwae4gh8AwOJlbxUgivNgzXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XfwFx6jqsz6K7MW;
	Fri,  1 Nov 2024 17:16:05 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id D669114058E;
	Fri,  1 Nov 2024 17:18:36 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.171.129) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 10:18:34 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<gregkh@linuxfoundation.org>, <sudeep.holla@arm.com>,
	<jassisinghbrar@gmail.com>, <dave.jiang@intel.com>,
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
Subject: [PATCH v15 15/15] EDAC: Add documentation for RAS feature control
Date: Fri, 1 Nov 2024 09:17:33 +0000
Message-ID: <20241101091735.1465-16-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241101091735.1465-1-shiju.jose@huawei.com>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add Documentation for expansion of EDAC for controlling RAS features.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/edac/features.rst      | 102 +++++++
 Documentation/edac/index.rst         |  12 +
 Documentation/edac/memory_repair.rst | 230 ++++++++++++++++
 Documentation/edac/scrub.rst         | 393 +++++++++++++++++++++++++++
 4 files changed, 737 insertions(+)
 create mode 100644 Documentation/edac/features.rst
 create mode 100644 Documentation/edac/index.rst
 create mode 100644 Documentation/edac/memory_repair.rst
 create mode 100644 Documentation/edac/scrub.rst

diff --git a/Documentation/edac/features.rst b/Documentation/edac/features.rst
new file mode 100644
index 000000000000..5e855952136b
--- /dev/null
+++ b/Documentation/edac/features.rst
@@ -0,0 +1,102 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================
+Augmenting EDAC for controlling RAS features
+============================================
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
+The expansion of EDAC for controlling RAS features and exposing features
+control attributes to userspace via sysfs. Some Examples:
+
+* Scrub control
+
+* Error Check Scrub (ECS) control
+
+* ACPI RAS2 features
+
+* Post Package Repair (PPR) control
+
+* Memory Sparing Repair control etc.
+
+High level design is illustrated in the following diagram::
+
+         _______________________________________________
+        |   Userspace - Rasdaemon                       |
+        |  _____________                                |
+        | | RAS CXL mem |      _______________          |
+        | |error handler|---->|               |         |
+        | |_____________|     | RAS dynamic   |         |
+        |  _____________      | scrub, memory |         |
+        | | RAS memory  |---->| repair control|         |
+        | |error handler|     |_______________|         |
+        | |_____________|          |                    |
+        |__________________________|____________________|
+                                   |
+                                   |
+    _______________________________|______________________________
+   |     Kernel EDAC extension for | controlling RAS Features     |
+   | ______________________________|____________________________  |
+   || EDAC Core          Sysfs EDAC| Bus                        | |
+   ||    __________________________|_________     _____________ | |
+   ||   |/sys/bus/edac/devices/<dev>/scrubX/ |   | EDAC device || |
+   ||   |/sys/bus/edac/devices/<dev>/ecsX/   |<->| EDAC MC     || |
+   ||   |/sys/bus/edac/devices/<dev>/repairX |   | EDAC sysfs  || |
+   ||   |____________________________________|   |_____________|| |
+   ||                           EDAC|Bus                        | |
+   ||                               |                           | |
+   ||    __________ Get feature     |      Get feature          | |
+   ||   |          |desc   _________|______ desc  __________    | |
+   ||   |EDAC scrub|<-----| EDAC device    |     |          |   | |
+   ||   |__________|      | driver- RAS    |---->| EDAC mem |   | |
+   ||    __________       | feature control|     | repair   |   | |
+   ||   |          |<-----|________________|     |__________|   | |
+   ||   |EDAC ECS  |    Register RAS|features                   | |
+   ||   |__________|                |                           | |
+   ||         ______________________|_____________              | |
+   ||_________|_______________|__________________|______________| |
+   |   _______|____    _______|_______       ____|__________      |
+   |  |            |  | CXL mem driver|     | Client driver |     |
+   |  | ACPI RAS2  |  | scrub, ECS,   |     | memory repair |     |
+   |  | driver     |  | sparing, PPR  |     | features      |     |
+   |  |____________|  |_______________|     |_______________|     |
+   |        |                 |                    |              |
+   |________|_________________|____________________|______________|
+            |                 |                    |
+    ________|_________________|____________________|______________
+   |     ___|_________________|____________________|_______       |
+   |    |                                                  |      |
+   |    |            Platform HW and Firmware              |      |
+   |    |__________________________________________________|      |
+   |______________________________________________________________|
+
+
+1. EDAC Features components - Create feature specific descriptors.
+For example, EDAC scrub, EDAC ECS, EDAC memory repair in the above
+diagram.
+
+2. EDAC device driver for controlling RAS Features - Get feature's attribute
+descriptors from EDAC RAS feature component and registers device's RAS
+features with EDAC bus and exposes the features control attributes via
+the sysfs EDAC bus. For example, /sys/bus/edac/devices/<dev-name>/<feature>X/
+
+3. RAS dynamic feature controller - Userspace sample modules in rasdaemon for
+dynamic scrub/repair control to issue scrubbing/repair when excess number
+of corrected memory errors are reported in a short span of time.
+
+RAS features
+------------
+1. Memory Scrub
+Memory scrub features are documented in `Documentation/edac/scrub.rst`.
+
+2. Memory Repair
+Memory repair features are documented in `Documentation/edac/memory_repair.rst`.
diff --git a/Documentation/edac/index.rst b/Documentation/edac/index.rst
new file mode 100644
index 000000000000..d6778f4562dd
--- /dev/null
+++ b/Documentation/edac/index.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+EDAC Subsystem
+==============
+
+.. toctree::
+   :maxdepth: 1
+
+   features
+   memory_repair
+   scrub
diff --git a/Documentation/edac/memory_repair.rst b/Documentation/edac/memory_repair.rst
new file mode 100644
index 000000000000..ad7f869e0b15
--- /dev/null
+++ b/Documentation/edac/memory_repair.rst
@@ -0,0 +1,230 @@
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
+Memory devices may support memory repair and maintenance operations to
+perform repairs on faulty memory media. Various types of memory repair
+features are available, such as Post Package Repair (PPR) and memory
+sparing.
+
+Post Package Repair(PPR)
+~~~~~~~~~~~~~~~~~~~~~~~~
+PPR maintenance operation requests the memory device to perform a repair
+operation on its media if supported. A memory device may support two types
+of PPR: Hard PPR (hPPR), for a permanent row repair and Soft PPR (sPPR),
+for a temporary row repair. sPPR is much faster than hPPR, but the repair
+is lost with a power cycle. During the execution of a PPR maintenance
+operation, a memory device, may or may not retain data and may or may not
+be able to process memory requests correctly. sPPR maintenance operation
+may be executed at runtime, if data is retained and memory requests are
+correctly processed. hPPR maintenance operation may be executed only at
+boot because data would not be retained. In CXL devices, sPPR and hPPR
+repair operations may be supported (CXL spec rev 3.1 sections 8.2.9.7.1.2
+and 8.2.9.7.1.3).
+
+Memory Sparing
+~~~~~~~~~~~~~~
+Memory sparing is defined as a repair function that replaces a portion of
+memory with a portion of functional memory at that same DPA. User space
+tool, e.g. rasdaemon, may request the sparing operation for a given
+address for which the uncorrectable error is reported. In CXL,
+(CXL spec 3.1 section 8.2.9.7.1.4) subclasses for sparing operation vary
+in terms of the scope of the sparing being performed. Cacheline sparing
+subclass refers to a sparing action that can replace a full cacheline.
+Row sparing is provided as an alternative to PPR sparing functions and its
+scope is that of a single DDR row. Bank sparing allows an entire bank to
+be replaced. Rank sparing is defined as an operation in which an entire
+DDR rank is replaced.
+
+Use cases of generic memory repair features control
+---------------------------------------------------
+
+1. The Soft PPR (sPPR), Hard PPR (hPPR), and memory-sparing features share
+similar control interfaces. Therefore, there is a need for a standardized,
+generic sysfs repair control that is exposed to userspace and used by
+administrators, scripts, and tools.
+
+2. When a CXL device detects a failure in a memory component, it may inform
+the host of the need for a repair maintenance operation by using an event
+record where the "maintenance needed" flag is set. The event record
+specifies the DPA that requires repair. The kernel reports the corresponding
+CXL general media or DRAM trace event to userspace, and userspace tools
+(e.g., rasdaemon) initiate a repair maintenance operation in response to
+the device request using the sysfs repair control.
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
+
+Example
+-------
+
+The usage takes the form shown in this example:
+
+1. CXL memory device sPPR
+
+# read capabilities
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/dpa_support
+
+1
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/nibble_mask
+
+0x0
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/persist_mode_avail
+
+0
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/persist_mode
+
+0
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/repair_type
+
+0
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/repair_safe_when_in_use
+
+1
+
+# set and readback attributes
+
+root@localhost:~# echo 0x8a2d > /sys/bus/edac/devices/cxl_mem0/mem_repair0/nibble_mask
+
+root@localhost:~# echo 0x300000 >  /sys/bus/edac/devices/cxl_mem0/mem_repair0/dpa
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/dpa
+
+0x300000
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair0/nibble_mask
+
+0x8a2d
+
+# issue repair operations
+
+# query and reapir return error if unsupported/failed.
+
+root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_mem0/mem_repair0/query
+
+root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_mem0/mem_repair0/repair
+
+1.2. CXL memory sparing
+
+# read capabilities
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/repair_type
+
+2
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/dpa_support
+
+1
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/persist_mode_avail
+
+0,1
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/persist_mode
+
+0
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/repair_safe_when_in_use
+
+1
+
+#set and readback attributes
+
+root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/bank_group
+
+root@localhost:~# echo 3 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/bank
+
+root@localhost:~# echo 2 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/channel
+
+root@localhost:~# echo  7 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/rank
+
+root@localhost:~# echo 0x4fb9 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/row
+
+root@localhost:~# echo 5 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/sub_channel
+
+root@localhost:~# echo 11 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/column
+
+root@localhost:~# echo 0x85c2 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/nibble_mask
+
+root@localhost:~# echo 0x700000 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/dpa
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/bank_group
+
+1
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/bank
+
+3
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/channel
+
+2
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/rank
+
+7
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/row
+
+0x4fb9
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/sub_channel
+
+5
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/column
+
+11
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/nibble_mask
+
+0x85c2
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/dpa
+
+0x700000
+
+# issue repair operations
+
+# query and repair return error if unsupported/failed.
+
+root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/query
+
+root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_mem0/mem_repair1/repair
diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
new file mode 100644
index 000000000000..d316f98604ad
--- /dev/null
+++ b/Documentation/edac/scrub.rst
@@ -0,0 +1,393 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================
+EDAC Scrub Control
+===================
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
+Increasing DRAM size and cost have made memory subsystem reliability an
+important concern. These modules are used where potentially corrupted data
+could cause expensive or fatal issues. Memory errors are among the top
+hardware failures that cause server and workload crashes.
+
+Memory scrubbing is a feature where an ECC (Error-Correcting Code) engine
+reads data from each memory media location, corrects with an ECC if
+necessary and writes the corrected data back to the same memory media
+location.
+
+The memory DIMMs can be scrubbed at a configurable rate to detect
+uncorrected memory errors and attempt recovery from detected errors,
+providing the following benefits.
+
+* Proactively scrubbing memory DIMMs reduces the chance of a correctable error becoming uncorrectable.
+
+* When detected, uncorrected errors caught in unallocated memory pages are isolated and prevented from being allocated to an application or the OS.
+
+* This reduces the likelihood of software or hardware products encountering memory errors.
+
+There are 2 types of memory scrubbing:
+
+1. Background (patrol) scrubbing of the RAM while the RAM is otherwise
+idle.
+
+2. On-demand scrubbing for a specific address range or region of memory.
+
+Several types of interfaces to hardware memory scrubbers have been
+identified, such as CXL memory device patrol scrub, CXL DDR5 ECS, ACPI
+RAS2 memory scrubbing, and ACPI NVDIMM ARS (Address Range Scrub).
+
+The scrub control varies between different memory scrubbers. To allow
+for standard userspace tooling there is a need to present these controls
+with a standard ABI.
+
+The control mechanisms vary across different memory scrubbers. To enable
+standardized userspace tooling, there is a need to present these controls
+through a standardized ABI.
+
+Introduce a generic memory EDAC scrub control that allows users to manage
+underlying scrubbers in the system through a standardized sysfs scrub
+control interface. This common sysfs scrub control interface abstracts the
+management of various scrubbing functionalities into a unified set of
+functions.
+
+Use cases of common scrub control feature
+-----------------------------------------
+1. Several types of interfaces for hardware (HW) memory scrubbers have
+been identified, including the CXL memory device patrol scrub, CXL DDR5
+ECS, ACPI RAS2 memory scrubbing features, ACPI NVDIMM ARS (Address Range
+Scrub), and software-based memory scrubbers. Some of these scrubbers
+support control over patrol (background) scrubbing (e.g., ACPI RAS2, CXL)
+and/or on-demand scrubbing (e.g., ACPI RAS2, ACPI ARS). However, the scrub
+control interfaces vary between memory scrubbers, highlighting the need for
+a standardized, generic sysfs scrub control interface that is accessible to
+userspace for administration and use by scripts/tools.
+
+2. User-space scrub controls allow users to disable scrubbing if necessary,
+for example, to disable background patrol scrubbing or adjust the scrub
+rate for performance-aware operations where background activities need to
+be minimized or disabled.
+
+3. User-space tools enable on-demand scrubbing for specific address ranges,
+provided that the scrubber supports this functionality.
+
+4. User-space tools can also control memory DIMM scrubbing at a configurable
+scrub rate via sysfs scrub controls. This approach offers several benefits:
+
+* Detects uncorrectable memory errors early, before user access to affected memory, helping facilitate recovery.
+
+* Reduces the likelihood of correctable errors developing into uncorrectable errors.
+
+5. Policy control for hotplugged memory is necessary because there may not
+be a system-wide BIOS or similar control to manage scrub settings for a CXL
+device added after boot. Determining these settings is a policy decision,
+balancing reliability against performance, so userspace should control it.
+Therefore, a unified interface is recommended for handling this function in
+a way that aligns with other similar interfaces, rather than creating a
+separate one.
+
+Scrubbing features
+------------------
+Comparison of various scrubbing features::
+
+ ................................................................
+ .              .   ACPI    . CXL patrol.  CXL ECS  .  ARS      .
+ .  Name        .   RAS2    . scrub     .           .           .
+ ................................................................
+ .              .           .           .           .           .
+ . On-demand    . Supported . No        . No        . Supported .
+ . Scrubbing    .           .           .           .           .
+ .              .           .           .           .           .
+ ................................................................
+ .              .           .           .           .           .
+ . Background   . Supported . Supported . Supported . No        .
+ . scrubbing    .           .           .           .           .
+ .              .           .           .           .           .
+ ................................................................
+ .              .           .           .           .           .
+ . Mode of      . Scrub ctrl. per device. per memory.  Unknown  .
+ . scrubbing    . per NUMA  .           . media     .           .
+ .              . domain.   .           .           .           .
+ ................................................................
+ .              .           .           .           .           .
+ . Query scrub  . Supported . Supported . Supported . Supported .
+ . capabilities .           .           .           .           .
+ .              .           .           .           .           .
+ ................................................................
+ .              .           .           .           .           .
+ . Setting      . Supported . No        . No        . Supported .
+ . address range.           .           .           .           .
+ .              .           .           .           .           .
+ ................................................................
+ .              .           .           .           .           .
+ . Setting      . Supported . Supported . No        . No        .
+ . scrub rate   .           .           .           .           .
+ .              .           .           .           .           .
+ ................................................................
+ .              .           .           .           .           .
+ . Unit for     . Not       . in hours  . No        . No        .
+ . scrub rate   . Defined   .           .           .           .
+ .              .           .           .           .           .
+ ................................................................
+ .              . Supported .           .           .           .
+ . Scrub        . on-demand . No        . No        . Supported .
+ . status/      . scrubbing .           .           .           .
+ . Completion   . only      .           .           .           .
+ ................................................................
+ . UC error     .           .CXL general.CXL general. ACPI UCE  .
+ . reporting    . Exception .media/DRAM .media/DRAM . notify and.
+ .              .           .event/media.event/media. query     .
+ .              .           .scan?      .scan?      . ARS status.
+ ................................................................
+ .              .           .           .           .           .
+ . Support for  . Supported . Supported . Supported . No        .
+ . EDAC control .           .           .           .           .
+ .              .           .           .           .           .
+ ................................................................
+
+CXL Memory Scrubbing features
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+CXL spec r3.1 section 8.2.9.9.11.1 describes the memory device patrol scrub
+control feature. The device patrol scrub proactively locates and makes
+corrections to errors in regular cycle. The patrol scrub control allows the
+request to configure patrol scrubber's input configurations.
+
+The patrol scrub control allows the requester to specify the number of
+hours in which the patrol scrub cycles must be completed, provided that
+the requested number is not less than the minimum number of hours for the
+patrol scrub cycle that the device is capable of. In addition, the patrol
+scrub controls allow the host to disable and enable the feature in case
+disabling of the feature is needed for other purposes such as
+performance-aware operations which require the background operations to be
+turned off.
+
+Error Check Scrub (ECS)
+~~~~~~~~~~~~~~~~~~~~~~~
+CXL spec r3.1 section 8.2.9.9.11.2 describes the Error Check Scrub (ECS)
+is a feature defined in JEDEC DDR5 SDRAM Specification (JESD79-5) and
+allows the DRAM to internally read, correct single-bit errors, and write
+back corrected data bits to the DRAM array while providing transparency
+to error counts.
+
+The DDR5 device contains number of memory media FRUs per device. The
+DDR5 ECS feature and thus the ECS control driver supports configuring
+the ECS parameters per FRU.
+
+ACPI RAS2 Hardware-based Memory Scrubbing
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ACPI spec 6.5 section 5.2.21 ACPI RAS2 describes ACPI RAS2 table
+provides interfaces for platform RAS features and supports independent
+RAS controls and capabilities for a given RAS feature for multiple
+instances of the same component in a given system.
+Memory RAS features apply to RAS capabilities, controls and operations
+that are specific to memory. RAS2 PCC sub-spaces for memory-specific RAS
+features have a Feature Type of 0x00 (Memory).
+
+The platform can use the hardware-based memory scrubbing feature to expose
+controls and capabilities associated with hardware-based memory scrub
+engines. The RAS2 memory scrubbing feature supports following as per spec,
+
+* Independent memory scrubbing controls for each NUMA domain, identified using its proximity domain.
+
+* Provision for background (patrol) scrubbing of the entire memory system, as well as on-demand scrubbing for a specific region of memory.
+
+ACPI Address Range Scrubbing(ARS)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ACPI spec 6.5 section 9.19.7.2 describes Address Range Scrubbing(ARS).
+ARS allows the platform to communicate memory errors to system software.
+This capability allows system software to prevent accesses to addresses
+with uncorrectable errors in memory. ARS functions manage all NVDIMMs
+present in the system. Only one scrub can be in progress system wide
+at any given time.
+Following functions are supported as per the specification.
+
+1. Query ARS Capabilities for a given address range, indicates platform
+supports the ACPI NVDIMM Root Device Unconsumed Error Notification.
+
+2. Start ARS triggers an Address Range Scrub for the given memory range.
+Address scrubbing can be done for volatile memory, persistent memory, or both.
+
+3. Query ARS Status command allows software to get the status of ARS,
+including the progress of ARS and ARS error record.
+
+4. Clear Uncorrectable Error.
+
+5. Translate SPA
+
+6. ARS Error Inject etc.
+
+The kernel supports an existing control for ARS and ARS is currently not
+supported in EDAC.
+
+The File System
+---------------
+
+The control attributes of a registered scrubber instance could be
+accessed in the
+
+/sys/bus/edac/devices/<dev-name>/scrubX/
+
+sysfs
+-----
+
+Sysfs files are documented in
+
+`Documentation/ABI/testing/sysfs-edac-scrub`.
+
+`Documentation/ABI/testing/sysfs-edac-ecs`.
+
+Example
+-------
+
+The usage takes the form shown in this example:
+
+1. CXL memory device patrol scrubber
+
+1.1 device based
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/min_cycle_duration
+
+3600
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/max_cycle_duration
+
+918000
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
+
+43200
+
+root@localhost:~# echo 54000 > /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
+
+54000
+
+root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
+
+1
+
+root@localhost:~# echo 0 > /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
+
+0
+
+1.2. region based
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/min_cycle_duration
+
+3600
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/max_cycle_duration
+
+918000
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
+
+43200
+
+root@localhost:~# echo 54000 > /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
+
+54000
+
+root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
+
+1
+
+root@localhost:~# echo 0 > /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
+
+root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
+
+0
+
+2. RAS2
+
+2.1 On demand scrubbing for a specific memory region.
+
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/min_cycle_duration
+
+3600
+
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/max_cycle_duration
+
+86400
+
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/current_cycle_duration
+
+36000
+
+# Readback 'addr', non-zero - demand scrub is in progress, zero - scrub is finished.
+
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/addr
+
+0
+
+root@localhost:~# echo 54000 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/current_cycle_duration
+
+root@localhost:~# echo 0x150000 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/size
+
+# Write 'addr' starts demand scrubbing, please make sure other attributes are set prior to that.
+
+root@localhost:~# echo 0x120000 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/addr
+
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/current_cycle_duration
+
+54000
+
+# Readback 'addr', non-zero - demand scrub is in progress, zero - scrub is finished.
+
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/addr
+
+0x120000
+
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/addr
+
+0
+
+2.2 Background scrubbing the entire memory
+
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/min_cycle_duration
+
+3600
+
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/max_cycle_duration
+
+86400
+
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/current_cycle_duration
+
+36000
+
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/enable_background
+
+0
+
+root@localhost:~# echo 10800 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/current_cycle_duration
+
+root@localhost:~# echo 1 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/enable_background
+
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/enable_background
+
+1
+
+root@localhost:~# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/current_cycle_duration
+
+10800
+
+root@localhost:~# echo 0 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/enable_background
-- 
2.34.1


