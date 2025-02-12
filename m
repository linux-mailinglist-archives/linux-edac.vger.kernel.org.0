Return-Path: <linux-edac+bounces-3038-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6595BA32890
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 15:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E445F7A20AA
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 14:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A011B210192;
	Wed, 12 Feb 2025 14:37:19 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A0F20E314;
	Wed, 12 Feb 2025 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371039; cv=none; b=jwBSeXgK3+OT5yoTtwS9W8EykCp/HqXtzOByKKqRbSKgecAfuo4LzLJ2hFLyy32aKavxWNFmPumHNzZSgr73WqKf0XVSKyT4alsjHZHVtCHOX4Wdj0oN8fT6q9+IKTg87ToFrXXh0Bw5rcICXgz2Mg7YepEJ44VTyKhlpGIYBA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371039; c=relaxed/simple;
	bh=yJGrslbGusQIQiNcrBI9fTyCSF7X5JNZfXqP5PpSwZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IYNwScW3zcmFj5OOlR+5bH5lsAg3J8nbS2JTCE4+xJeczyk09bh/NrN1NwnSKbiWOo87EQqTtmvwMjLo2ZhmDCg1WjLclMxR3azybrwOIFy6vnJv9wcvNvC7x+ycZWj1NWopNtD4GM9hgMT1piiAh/knJedIptQQvhDkLRN8pkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtLS63RJbz6J7gS;
	Wed, 12 Feb 2025 22:34:46 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id CFDF91401DC;
	Wed, 12 Feb 2025 22:37:11 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.169.206) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Feb 2025 15:37:09 +0100
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
Subject: [PATCH v20 00/15] EDAC: Scrub: introduce generic EDAC RAS control feature driver + CXL/ACPI-RAS2 drivers
Date: Wed, 12 Feb 2025 14:36:38 +0000
Message-ID: <20250212143654.1893-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

The CXL patches of this series has dependency on Dave's CXL fwctl
series [1].

The code is based on v5 of CXL fwctl series [1] posted by Dave and
v4 of FWCTL series [2] posted by Jason and rebased on top of
v6.14-rc1 + other related patches from Dave's fwctl kernel branch [3].

[1]: https://lore.kernel.org/all/20250211182909.1650096-1-dave.jiang@intel.com/
[2]: https://lore.kernel.org/linux-cxl/0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com/#r
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl/fwctl


Userspace code for CXL memory repair features [4] and
sample boot-script for CXL memory repair [5].

[4]: https://lore.kernel.org/lkml/20250207143028.1865-1-shiju.jose@huawei.com/
[5]: https://lore.kernel.org/lkml/20250207143028.1865-5-shiju.jose@huawei.com/
  
Augmenting EDAC for controlling RAS features
============================================
The proposed expansion of EDAC for controlling RAS features and
exposing features control attributes to userspace in sysfs.
Some Examples:
 - Scrub control
 - Error Check Scrub (ECS) control
 - ACPI RAS2 features
 - Post Package Repair (PPR) control
 - Memory Sparing Repair control etc.

High level design is illustrated in the following diagram.
 
        +-----------------------------------------------+
        |   Userspace - Rasdaemon                       |
        | +-------------+                               |
        | | RAS CXL mem |     +---------------+         |
        | |error handler|---->|               |         |
        | +-------------+     | RAS dynamic   |         |
        | +-------------+     | scrub, memory |         |
        | | RAS memory  |---->| repair control|         |
        | |error handler|     +----|----------+         |
        | +-------------+          |                    |
        +--------------------------|--------------------+
                                   |
                                   |
   +-------------------------------|------------------------------+
   |     Kernel EDAC extension for | controlling RAS Features     |
   |+------------------------------|----------------------------+ |
   || EDAC Core          Sysfs EDAC| Bus                        | |
   ||   +--------------------------|---------------------------+| |
   ||   |/sys/bus/edac/devices/<dev>/scrubX/ |   | EDAC device || |
   ||   |/sys/bus/edac/devices/<dev>/ecsX/   |<->| EDAC MC     || |
   ||   |/sys/bus/edac/devices/<dev>/repairX |   | EDAC sysfs  || |
   ||   +---------------------------|--------------------------+| |
   ||                           EDAC|Bus                        | |
   ||                               |                           | |
   ||   +----------+ Get feature    |      Get feature          | |
   ||   |          | desc +---------|------+ desc +----------+  | |
   ||   |EDAC scrub|<-----| EDAC device    |      |          |  | |
   ||   +----------+      | driver- RAS    |----->| EDAC mem |  | |
   ||   +----------+      | feature control|      | repair   |  | |
   ||   |          |<-----|                |      +----------+  | |
   ||   |EDAC ECS  |      +---------|------+                    | |
   ||   +----------+    Register RAS|features                   | |
   ||         ______________________|_____________              | |
   |+---------|---------------|------------------|--------------+ |
   |  +-------|----+  +-------|-------+     +----|----------+     |
   |  |            |  | CXL mem driver|     | Client driver |     |
   |  | ACPI RAS2  |  | scrub, ECS,   |     | memory repair |     |
   |  | driver     |  | sparing, PPR  |     | features      |     |
   |  +-----|------+  +-------|-------+     +------|--------+     |
   |        |                 |                    |              |
   +--------|-----------------|--------------------|--------------+
            |                 |                    |
   +--------|-----------------|--------------------|--------------+
   |    +---|-----------------|--------------------|-------+      |
   |    |                                                  |      |
   |    |            Platform HW and Firmware              |      |
   |    +--------------------------------------------------+      |
   +--------------------------------------------------------------+


1. EDAC RAS Features components - Create feature specific descriptors.
   for example, EDAC scrub, EDAC ECS, EDAC memory repair in the above
   diagram. 
2. EDAC device driver for controlling RAS Features - Get feature's attr
   descriptors from EDAC RAS feature component and registers device's
   RAS features with EDAC bus and expose the feature's sysfs attributes
   under the sysfs EDAC bus.
3. RAS dynamic scrub controller - Userspace sample module added for scrub
   control in rasdaemon to issue scrubbing when excess number of memory
   errors are reported in a short span of time.

The added EDAC feature specific components (e.g. EDAC scrub, EDAC ECS,
EDAC memory repair etc) do callbacks to  the parent driver (e.g. CXL
driver, ACPI RAS driver etc) for the controls rather than just letting the
caller deal with it because of the following reasons.
1. Enforces a common API across multiple implementations can do that
   via review, but that's not generally gone well in the long run for
   subsystems that have done it (several have later moved to callback
   and feature list based approaches).
2. Gives a path for 'intercepting' in the EDAC feature driver.
   An example for this is that we could intercept PPR repair calls
   and sanity check that the memory in question is offline before
   passing back to the underlying code.  Sure we could rely on doing
   that via some additional calls from the parent driver, but the
   ABI will get messier.
3. (Speculative) we may get in kernel users of some features in the
   long run.

More details of the common RAS features are described in the following
sections.

Memory Scrubbing
================
Increasing DRAM size and cost has made memory subsystem reliability
an important concern. These modules are used where potentially
corrupted data could cause expensive or fatal issues. Memory errors are
one of the top hardware failures that cause server and workload crashes.

Memory scrub is a feature where an ECC engine reads data from
each memory media location, corrects with an ECC if necessary and
writes the corrected data back to the same memory media location.

The memory DIMMs could be scrubbed at a configurable rate to detect
uncorrected memory errors and attempts to recover from detected memory
errors providing the following benefits.
- Proactively scrubbing memory DIMMs reduces the chance of a correctable
  error becoming uncorrectable.
- Once detected, uncorrected errors caught in unallocated memory pages are
  isolated and prevented from being allocated to an application or the OS.
- The probability of software/hardware products encountering memory
  errors is reduced.
Some details of background can be found in Reference [5].

There are 2 types of memory scrubbing,
1. Background (patrol) scrubbing of the RAM whilst the RAM is otherwise
   idle.
2. On-demand scrubbing for a specific address range/region of memory.

There are several types of interfaces to HW memory scrubbers
identified such as ACPI NVDIMM ARS(Address Range Scrub), CXL memory
device patrol scrub, CXL DDR5 ECS, ACPI RAS2 memory scrubbing.

The scrub control varies between different memory scrubbers. To allow
for standard userspace tooling there is a need to present these controls
with a standard ABI.

Introduce generic memory EDAC scrub control which allows user to control
underlying scrubbers in the system via generic sysfs scrub control
interface. The common sysfs scrub control interface abstracts the control
of an arbitrary scrubbing functionality to a common set of functions.

Use case of common scrub control feature
========================================
1. There are several types of interfaces to HW memory scrubbers identified
   such as ACPI NVDIMM ARS(Address Range Scrub), CXL memory device patrol
   scrub, CXL DDR5 ECS, ACPI RAS2 memory scrubbing features and software
   based memory scrubber(discussed in the community Reference [5]).
   Also some scrubbers support controlling (background) patrol scrubbing
   (ACPI RAS2, CXL) and/or on-demand scrubbing(ACPI RAS2, ACPI ARS).
   However the scrub controls varies between memory scrubbers. Thus there
   is a requirement for a standard generic sysfs scrub controls exposed
   to userspace for the seamless control of the HW/SW scrubbers in
   the system by admin/scripts/tools etc.
2. Scrub controls in user space allow the user to disable the scrubbing
   in case disabling of the background patrol scrubbing or changing the
   scrub rate are needed for other purposes such as performance-aware
   operations which requires the background operations to be turned off
   or reduced.
3. Allows to perform on-demand scrubbing for specific address range if
   supported by the scrubber.
4. User space tools controls scrub the memory DIMMs regularly at a
   configurable scrub rate using the sysfs scrub controls discussed help,
   - to detect uncorrectable memory errors early before user accessing
     memory, which helps to recover the detected memory errors.
   - reduces the chance of a correctable error becoming uncorrectable.
5. Policy control for hotplugged memory. There is not necessarily a system
   wide bios or similar in the loop to control the scrub settings on a CXL
   device that wasn't there at boot. What that setting should be is a policy
   decision as we are trading of reliability vs performance - hence it should
   be in control of userspace. As such, 'an' interface is needed. Seems more
   sensible to try and unify it with other similar interfaces than spin
   yet another one.

The draft version of userspace code added in rasdaemon for dynamic scrub
control, based on frequency of memory errors reported to userspace, tested
for CXL device based patrol scrubbing feature and ACPI RAS2 based
scrubbing feature.

https://github.com/shijujose4/rasdaemon/tree/ras_feature_control

ToDO: For memory repair features, such as PPR, memory sparing, rasdaemon
collates records and decides to replace a row if there are lots of
corrected errors, or a single uncorrected error or error record received
with 'maintenance need' flag set as in some CXL event records.

Comparison of scrubbing features
================================
 +--------------+-----------+-----------+-----------+-----------+
 |              |   ACPI    | CXL patrol|  CXL ECS  |  ARS      |
 |  Name        |   RAS2    | scrub     |           |           |
 +--------------+-----------+-----------+-----------+-----------+
 |              |           |           |           |           |
 | On-demand    | Supported | No        | No        | Supported |
 | Scrubbing    |           |           |           |           |
 |              |           |           |           |           |
 +--------------+-----------+-----------+-----------+-----------+
 |              |           |           |           |           |
 | Background   | Supported | Supported | Supported | No        |
 | scrubbing    |           |           |           |           |
 |              |           |           |           |           |
 +--------------+-----------+-----------+-----------+-----------+
 |              |           |           |           |           |
 | Mode of      | Scrub ctrl| per device| per memory|  Unknown  |
 | scrubbing    | per NUMA  |           | media     |           |
 |              | domain.   |           |           |           |
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

CXL Memory Scrubbing features
=============================
CXL spec r3.1 section 8.2.9.9.11.1 describes the memory device patrol scrub
control feature. The device patrol scrub proactively locates and makes
corrections to errors in regular cycle. The patrol scrub control allows the
request to configure patrol scrubber's input configurations.

The patrol scrub control allows the requester to specify the number of
hours in which the patrol scrub cycles must be completed, provided that
the requested number is not less than the minimum number of hours for the
patrol scrub cycle that the device is capable of. In addition, the patrol
scrub controls allow the host to disable and enable the feature in case
disabling of the feature is needed for other purposes such as
performance-aware operations which require the background operations to be
turned off.

The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
Specification (JESD79-5) and allows the DRAM to internally read, correct
single-bit errors, and write back corrected data bits to the DRAM array
while providing transparency to error counts.

The DDR5 device contains number of memory media FRUs per device. The
DDR5 ECS feature and thus the ECS control driver supports configuring
the ECS parameters per FRU.

ACPI RAS2 Hardware-based Memory Scrubbing
=========================================
ACPI spec 6.5 section 5.2.21 ACPI RAS2 describes ACPI RAS2 table
provides interfaces for platform RAS features and supports independent
RAS controls and capabilities for a given RAS feature for multiple
instances of the same component in a given system.
Memory RAS features apply to RAS capabilities, controls and operations
that are specific to memory. RAS2 PCC sub-spaces for memory-specific RAS
features have a Feature Type of 0x00 (Memory).

The platform can use the hardware-based memory scrubbing feature to expose
controls and capabilities associated with hardware-based memory scrub
engines. The RAS2 memory scrubbing feature supports following as per spec,
 - Independent memory scrubbing controls for each NUMA domain, identified
   using its proximity domain.
   Note: However AmpereComputing has single entry repeated as they have
         centralized controls.
 - Provision for background (patrol) scrubbing of the entire memory system,
   as well as on-demand scrubbing for a specific region of memory.

ACPI Address Range Scrubbing(ARS)
================================
ARS allows the platform to communicate memory errors to system software.
This capability allows system software to prevent accesses to addresses
with uncorrectable errors in memory. ARS functions manage all NVDIMMs
present in the system. Only one scrub can be in progress system wide
at any given time.
Following functions are supported as per the specification.
1. Query ARS Capabilities for a given address range, indicates platform
   supports the ACPI NVDIMM Root Device Unconsumed Error Notification.
2. Start ARS triggers an Address Range Scrub for the given memory range.
   Address scrubbing can be done for volatile memory, persistent memory,
   or both.
3. Query ARS Status command allows software to get the status of ARS,  
   including the progress of ARS and ARS error record.
4. Clear Uncorrectable Error.
5. Translate SPA
6. ARS Error Inject etc.
Note: Support for ARS is not added in this series because to reduce the
line of code for review and could be added after initial code is merged. 
We'd like feedback on whether this is of interest to ARS community?

Post Package Repair(PPR)
========================
PPR (Post Package Repair) maintenance operation requests the memory device
to perform a repair operation on its media if supported. A memory device
may support two types of PPR: Hard PPR (hPPR), for a permanent row repair,
and Soft PPR (sPPR), for a temporary row repair. sPPR is much faster than
hPPR, but the repair is lost with a power cycle. During the execution of a
PPR maintenance operation, a memory device, may or may not retain data and
may or may not be able to process memory requests correctly. sPPR maintenance
operation may be executed at runtime, if data is retained and memory requests
are correctly processed. hPPR maintenance operation may be executed only at
boot because data would not be retained.

Use cases of common PPR control feature
=======================================
1. The Soft PPR (sPPR) and Hard PPR (hPPR) share similar control interfaces,
thus there is a requirement for a standard generic sysfs PPR controls exposed
to userspace for the seamless control of the PPR features in the system by the
admin/scripts/tools etc.
2. When a CXL device identifies a failure on a memory component, the device
may inform the host about the need for a PPR maintenance operation by using
an event record, where the maintenance needed flag is set. The event record
specifies the DPA that should be repaired. Kernel reports the corresponding
cxl general media or DRAM trace event to userspace. The userspace tool,
for reg. rasdaemon initiate a PPR maintenance operation in response to a
device request using the sysfs PPR control.
3. User space tools, for eg. rasdaemon, do request PPR on a memory region
when uncorrected memory error or excess corrected memory errors reported
on that memory.
4. Likely multiple instances of PPR present per memory device.

Memory Sparing
==============
Memory sparing is defined as a repair function that replaces a portion of
memory with a portion of functional memory at that same DPA. User space
tool, e.g. rasdaemon, may request the sparing operation for a given
address for which the uncorrectable error is reported. In CXL,
(CXL spec 3.1 section 8.2.9.7.1.4) subclasses for sparing operation vary
in terms of the scope of the sparing being performed. The cacheline sparing
subclass refers to a sparing action that can replace a full cacheline.
Row sparing is provided as an alternative to PPR sparing functions and its
scope is that of a single DDR row. Bank sparing allows an entire bank to
be replaced. Rank sparing is defined as an operation in which an entire
DDR rank is replaced.

Series adds,
1. EDAC device driver extended for controlling RAS features, EDAC scrub
   driver, EDAC ECS driver, EDAC memory repair driver supports memory
   scrub control, ECS control, memory repair(PPR, sparing) control
   respectively.
2. Several common patches from Dave's cxl/fwctl series.   
3. Support for CXL feature mailbox commands, which is used by CXL device
   scrubbing and memory repair features. 
4. CXL features driver supporting patrol scrub control (device and
   region based).
5. CXL features driver supporting ECS control feature.
6. ACPI RAS2 driver adds OS interface for RAS2 communication through
   PCC mailbox and extracts ACPI RAS2 feature table (RAS2) and
   create platform device for the RAS memory features, which binds
   to the memory ACPI RAS2 driver.
7. Memory ACPI RAS2 driver gets the PCC subspace for communicating
   with the ACPI compliant platform supports ACPI RAS2. Add callback
   functions and registers with EDAC device to support user to
   control the HW patrol scrubbers exposed to the kernel via the
   ACPI RAS2 table.
8. Support for CXL maintenance mailbox command, which is used by
   CXL device memory repair feature.   
9. CXL features drivers supporting PPR and memory sparing features.
    Note: There are other PPR, memory sparing drivers to come.

Open Questions based on feedbacks from the community:
1. Jonathan:
   - Any need for discoverability of capability to scan different regions,
   such as global PA space to userspace. Left as future extension.

2. Jiaqi:
   - STOP_PATROL_SCRUBBER from RAS2 must be blocked and, must not be exposed to
     OS/userspace. Stopping patrol scrubber is unacceptable for platform where
     OEM has enabled patrol scrubber, because the patrol scrubber is a key part
     of logging and is repurposed for other RAS actions.
   If the OEM does not want to expose this control, they should lock it down so the
   interface is not exposed to the OS. These features are optional after all.
   - "Requested Address Range"/"Actual Address Range" (region to scrub) is a
      similarly bad thing to expose in RAS2.
   If the OEM does not want to expose this, they should lock it down so the
   interface is not exposed to the OS. These features are optional after all.
   As per LPC discussion, support for stop and attributes for addr range
   to be exposed to the userspace. 
3. Borislav: 
   - How the scrub control exposed to userspace will be used?
     POC added in rasdaemon with dynamic scrub control for CXL memory media
     errors and memory errors reported to userspace.
     https://github.com/shijujose4/rasdaemon/tree/scrub_control_6_june_2024
   - Is the scrub interface is sufficient for the use cases?
   - Who is going to use scrub controls tools/admin/scripts?
     1) Rasdaemon for dynamic control
     2) Udev script for more static 'defaults' on hotplug etc.
   - Sample userspace code for memory repair feature
     https://lore.kernel.org/lkml/20250207143028.1865-1-shiju.jose@huawei.com/
   - Sample boot-script for memory repair
     https://lore.kernel.org/lkml/20250207143028.1865-5-shiju.jose@huawei.com/

     
4. PPR   
   - For PPR, rasdaemon collates records and decides to replace a row if there
     are lots of corrected errors, or a single uncorrected error or error record
     received with maintenance request flag set as in CXL DRAM error record.
   - sPPR more or less startup only (so faking hPPR) or actually useful
     in a running system (if not the safe version that keeps everything
     running whilst replacement is ongoing)
   - Is future proofing for multiple PPR units useful given we've mashed
     together hPPR and sPPR for CXL.

Implementation
==============
1. Linux kernel
Version 20 of EDAC series is available in https://github.com/shijujose4/linux.git
Branch: edac-enhancement-ras-features_v20

The code is based on v5 of CXL fwctl series [1] posted by Dave and
v4 of FWCTL series [2] posted by Jason and rebased on top of
v6.14-rc1 + patches from Dave's fwctl kernel branch [3].

[1]: https://lore.kernel.org/all/20250211182909.1650096-1-dave.jiang@intel.com/
[2]: https://lore.kernel.org/linux-cxl/0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com/#r
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl/fwctl

2. QEMU emulation
QEMU for CXL RAS features implementation is available in, 
https://gitlab.com/shiju.jose/qemu.git
Branch: cxl-ras-features-2024-10-24

3. Userspace - rasdaemon
3.1. Memory scrubbing 
   The draft version of userspace sample code for dynamic scrub control,
   based on frequency of memory errors reported to userspace, is added
   in rasdaemon and enabled, tested for CXL device based patrol scrubbing
   feature and ACPI RAS2 based scrubbing feature. This required updation
   for the latest sysfs scrub interface.
   https://github.com/shijujose4/rasdaemon/tree/ras_feature_control

3.2. Memory repair
   - Sample userspace code for memory repair feature [4].

   - Sample boot-script for memory repair [5].

[4]: https://lore.kernel.org/lkml/20250207143028.1865-1-shiju.jose@huawei.com/
[5]: https://lore.kernel.org/lkml/20250207143028.1865-5-shiju.jose@huawei.com/

References:
1. ACPI spec r6.5 section 5.2.21 ACPI RAS2.
2. ACPI spec r6.5 section 9.19.7.2 ARS.
3. CXL spec  r3.1 8.2.9.9.11.1 Device patrol scrub control feature
4. CXL spec  r3.1 8.2.9.9.11.2 DDR5 ECS feature
5. CXL spec  r3.1 8.2.9.7.1.1 PPR Maintenance Operations
6. CXL spec  r3.1 8.2.9.7.2.1 sPPR Feature Discovery and Configuration
7. CXL spec  r3.1 8.2.9.7.2.2 hPPR Feature Discovery and Configuration
8. Background information about kernel support for memory scan, memory
   error detection and ACPI RASF.
   https://lore.kernel.org/all/20221103155029.2451105-1-jiaqiyan@google.com/
9. Discussions on RASF:
   https://lore.kernel.org/lkml/20230915172818.761-1-shiju.jose@huawei.com/#r 

Changes
=======
v19 -> v20:
1. Fixed the build errors due to config dependency issues (CXL & RAS2)
    with module configs, reported by Ni Fan.

2. Rebased to v5 of CXL fwctl series [1] posted by Dave and
   few related changes in the patch
   "cxl: Add helper function to retrieve a feature entry".

v18 -> v19:
1. Added config EDAC_SCRUB, EDAC_ECS and EDAC_MEM_REPAIR and
   associated changes for feedback from Borislav.

2. Control attributes related to the memory-sparing features
   in EDAC memory repair moved into another patch.

3. Feedback from Dan on CXL patches, 
   - Added more comments to the examples given for CXL features
     in the Documentation/edac/scrub.rst and 
     Documentation/edac/memory_repair.rst  
   - Removed CXL_PCI dependency for the CONFIG_CXL_RAS_FEATURES 
   - Updated description for CONFIG_CXL_RAS_FEATURES ad Dan suggested.
   - Added specification reference comments for CXL patrol scrub and ECS.  
   - kmalloc -> kzalloc
   - Added comment and/or hold lock for region based memory scrubbing code. 
     In addition, Added common helper functions to hold and release rwsem for read.
   - Removed unwanted logs and dev_err -> dev_dbg in other places.
   - Added separate helper functions for cxl_mem_ras_features_init() for memdev and region.
     This solved a bug pointed by Dan in region based init.
   - Replaced "cxl_region%d", cxlr->id with "%s_%s", "cxl", dev_name(&cxlr->dev)  
   - removed module soft dep on cxl_features.  

4. Mauro's review comments,
   - Fixed ABI documentation issues, update diagram & table for ReST
     and update .rst docs licensing update.
   - Changed sysfs memory repair_type from integer to string format.
   - Reorder, diagram and table updates in the patch[0].

5. Feedback on memory repair from community and Jonathan, 
   - Removed min and max attributes for range from edac mem repair for
     bank, rank, channel,..etc. those were added in v16.
   - For range attributes series continue to use min_ and max_ 
     attributes. For eg. scrub rate in EDAC scrub and dpa & hpa in 
     EDAC memory repair. Not sure to change or not to the scheme
     suggested by Borislav for exposing range in sysfs.
   - CXL memory repair - Added check for memory if offline and memory
     to reapir with attributes reported in ev record in the current
     boot. Otherwise do not issue repair command. 
   etc.

6. Feedback from Jonathan from internal review, 
   - Fixes in the .rst documentations
   - Update date in file headers.
   - Change 'persist_mode' in memory repair to boolean.
   - Moved some enums from patch for EDAC mem repair patch to 
     CXL repair patches.
   - Few optimizations and tidy up in RAS2 drivers.
   - Removed extra return error code check for set_feature and get_feature
     functions in CXL RAS code.
   - Re-order structure definitions in CXL RAS driver for better packaging.
   - Fixed multi line comment format in CXL memory repair drivers.
   - Removed support for 'query' command from the CXL memory repair drivers.
   - Removed zeroing sparing attributes if spare request to the device return error.
   etc.

7. 
 - The code is based on v3 of CXL fwctl series [1] posted by Dave and
    v3 of FWCTL series [2] posted by Jason and rebased on top of v6.14-rc1.
 - Modified CXL code for Dave's changes based on Dan's suggestions, for
   input for the feature calls is mbox based.
 - In addition, added separate patch for cxl_get_supported_feature_entry()   
   to EDAC series.

v17 -> v18:
1. Rebased to kernel version 6.13-rc5
2. Reordered patches for feedback on v17.
3.
3.1 Took updated patches for CXL feature infrastructure and feature commands
   from Dave's cxl/features branch, debug and tested.
3.2. RAS features in the cxl/core/memfeature.c updated for interface
     changes in the CXL feature commands.
4. Modified ACPI RAS2 code for the recent interface changes in the
   PCC mbox code.

v16 -> v17:
1. 
1.1 Took several patches for CXL feature commands from Dave's 
   fwctl/cxl series and add fixes pointed by Jonathan in those patches.
1.2. cxl/core/memfeature.c updated for interface changes in the
   Get Supported Feature, Get Feature and Set Feature functions.
1.3. Used the UUID's for RAS features in CXL features code from
     include/cxl/features.h    
2. Changes based on feedbacks from Boris
 - Added attributes in EDAC memory repair to return the range for DPA
   and other control attributes, and added callback functions for the
   DPA range in CXL PPR and memory sparing code, which is the only one
   supported in the CXL.
 - Removed 'query' attribute for memory repair feature.

v15 -> v16:
1. Changes and Fixes for feedbacks from Boris
 - Modified documentations and interface file for EDAC memory repair
   to add more details and use cases.
 - Merged documentations to corresponding patches instead of common patch
   for full documentation for better readability.
 - Removed 'persist_mode_avail' attribute for memory repair feature.
2. Changes for feedback from Dave Jiang
 - Dave suggested helper function for ECS initialization in cxl/core/memfeature.c,
   which added for all CXl RAS features, scrub, ECS, PPR and memory sparing features.
 - Fixed endian conversion pointed by Dave in CXL memory sparing. Also I fixed
     similar in CXL scrub, ECS and PPR features.
3. Changes for feedback from Ni Fan.
 - Fixed a memory leak in edac_dev_register() for memory repair feature
   and few suggestions by Ni Fan.

v14 -> v15:
1. Changes and Fixes for feedbacks from Boris
  - Added documentations for edac features, scrub and memory_repair etc
    and placed in a separate patch.
  - Deleted extra 2 attributes for EDAC ECS log_entry_type_per_* and
    mode_counts_*.
  - Rsolved issues reported in Documentation/ABI/testing/sysfs-edac-ecs.
  - Deleted unused pr_ftmt() from few files.
  - Fixed some formatting issues EDAC ECS code and similar in other files. 
    etc.
2. Change for feedback from Dave Jiang
  - In CXL code for patrol scrub control, Dave suggested replace
    void *drv_data with a union of parameters in cxl_ps_get_attrs() and
    similar functions.
    This is fixed by replacing void *drv_data with corresponding context
    structure(struct cxl_patrol_scrub_context) in CXL local functions as
    struct cxl_patrol_scrub_context difficult and can't be visible in
    generic EDAC control interface. Similar changes are made for CXL ECS,
    CXL PPR and CXL memory sparing local functions.

v13 -> v14:
1. Changes and Fixes for feedback from Boris
  - Check grammar of patch description.
  - Changed scrub control attributes for memory scrub range to "addr" and "size".
  - Fixed unreached code in edac_dev_register(). 
  - Removed enable_on_demand attribute from EDAC scrub control and modified
    RAS2 driver for the same.
  - Updated ABI documentation for EDAC scrub control.
    etc.

2. Changes for feedback from Greg/Rafael/Jonathan for ACPI RAS2
  - Replaced platform device creation and binding with
    auxiliary device creation and binding with ACPI RAS2
    memory auxiliary driver.

3. Changes and Fixes for feedback from Jonathan
  - Fixed unreached code in edac_dev_register(). 
  - Optimize callback functions in CXL ECS using macros.
  - Add readback attributes for the EDAC memory repair feature
    and add support in the CXL driver for PPR and memory sparing.
  - Add refactoring in the CXL driver for PPR and memory sparing
    for query/repair maintenance commands.
  - Add cxl_dpa_to_region_locked() function.  
  - Some more cleanups in the ACPI RAS2 and RAS2 memory drivers.
    etc.

4. Changes and Fixes for feedback from Ni Fan
   - Fixed compilation error - cxl_mem_ras_features_init refined, when CXL components
     build as module.

5. Optimize callback functions in CXL memory sparing using macros.
   etc.
   
v12 -> v13:
1. Changes and Fixes for feedback from Boris
  - Function edac_dev_feat_init() merge with edac_dev_register()
  - Add macros in EDAC feature specific code for repeated code.
  - Correct spelling mistakes.
  - Removed feature specific code from the patch "EDAC: Add support
    for EDAC device features control"
2. Changes for feedbacks from Dave Jiang
   - Move fields num_features and entries to struct cxl_mailbox,
     in "cxl: Add Get Supported Features command for kernel usage"
   - Use series from 
     https://lore.kernel.org/linux-cxl/20240905223711.1990186-1-dave.jiang@intel.com/   
3. Changes and Fixes for feedback from Ni Fan
   - In documentation scrub* to scrubX, ecs_fru* to ecs_fruX
   - Corrected some grammar mistakes in the patch headers.
   - Fixed an error print for min_scrub_cycle_hrs in the CXL patrol scrub
     code.
   - Improved an error print in the CXL ECS code.
   - bool -> tristate for config CXL_RAS_FEAT
4. Add support for CXL memory sparing feature.
5. Add common EDAC memory repair driver for controlling memory repair
   features, PPR, memory sparing etc.

v11 -> v12:
1. Changes and Fixes for feedback from Boris mainly for
    patch "EDAC: Add support for EDAC device features control"
    and other generic comments.

2. Took CXL patches from Dave Jiang for "Add Get Supported Features
   command for kernel usage" and other related patches. Merged helper
   functions from this series to the above patch. Modifications of
   CXL code in this series due to refactoring of CXL mailbox in Dave's
   patches.

3. Modified EDAC scrub control code to support multiple scrub instances
   per device.

v10 -> v11:
1. Feedback from Borislav:
   - Add generic EDAC code for control device features to
     /drivers/edac/edac_device.c.
   - Add common structure in edac for device feature's data.
   
2. Some more optimizations in generic EDAC code for control
   device features.

3. Changes for feedback from Fan for ACPI RAS2 memory driver.

4. Add support for control memory PPR (Post Package Repair) features
   in EDAC.
   
5. Add support for maintenance command in the CXL mailbox code,
   which is needed for support PPR features in CXL driver.  

6. Add support for control memory PPR (Post Package Repair) features
   and do perform PPR maintenance operation in CXL driver.

7. Rename drivers/cxl/core/memscrub.c to drivers/cxl/core/memfeature.c

v9 -> v10:
1. Feedback from Mauro Carvalho Chehab:
   - Changes suggested in EDAC RAS feature driver.
     use uppercase for enums, if else to switch-case, documentation for
     static scrub and ecs init functions etc.
   - Changes suggested in EDAC scrub.
     unit of scrub cycle hour to seconds.
     attribute node cycle_in_hours_available to min_cycle_duration and 
     max_cycle_duration.
     attribute node cycle_in_hours to current_cycle_duration.
     Use base 0 for kstrtou64() and kstrtol() functions.
     etc.
   - Changes suggested in EDAC ECS.
     uppercase for enums
     add ABI documentation. etc
        
2. Feedback from Fan:
   - Changes suggested in EDAC RAS feature driver.
     use uppercase for enums, change if...else to switch-case. 
     some optimization in edac_ras_dev_register() function
     add missing goto free_ctx
   - Changes suggested in the code for feature commands.  
   - CXL driver scrub and ECS code
     use uppercase for enums, fix typo, use enum type for mode
     fix lonf lines etc.
       
v8 -> v9:
1. Feedback from Borislav:
   - Add scrub control driver to the EDAC on feedback from Borislav.
   - Changed DEVICE_ATTR_..() static.
   - Changed the write permissions for scrub control sysfs files as
     root-only.
2. Feedback from Fan:
   - Optimized cxl_get_feature() function by using min() and removed
     feat_out_min_size.
   - Removed unreached return from cxl_set_feature() function.
   - Changed the term  "rate" to "cycle_in_hours" in all the
     scrub control code.
   - Allow cxl_mem_probe() continue if cxl_mem_patrol_scrub_init() fail,
     with just a debug warning.
      
3. Feedback from Jonathan:
   - Removed patch __free() based cleanup function for acpi_put_table.
     and added fix in the acpi RAS2 driver.

4. Feedback from Dan Williams:
   - Allow cxl_mem_probe() continue if cxl_mem_patrol_scrub_init() fail,
     with just a debug warning.
   - Add support for CXL region based scrub control.

5. Feedback from Daniel Ferguson on RAS2 drivers:
    In the ACPI RAS2 driver,
  - Incorporated the changes given for clearing error reported.
  - Incorporated the changes given for check the Set RAS Capability
    status and return an appropriate error.
    In the RAS2 memory driver,
  - Added more checks for start/stop bg and on-demand scrubbing
    so that addr range in cache do not get cleared and restrict
    permitted operations during scrubbing.

History for v1 to v8 is available here.
https://lore.kernel.org/lkml/20240726160556.2079-1-shiju.jose@huawei.com/

Shiju Jose (15):
  EDAC: Add support for EDAC device features control
  EDAC: Add scrub control feature
  EDAC: Add ECS control feature
  EDAC: Add memory repair control feature
  ACPI:RAS2: Add ACPI RAS2 driver
  ras: mem: Add memory ACPI RAS2 driver
  cxl: Add helper function to retrieve a feature entry
  cxl/memfeature: Add CXL memory device patrol scrub control feature
  cxl/memfeature: Add CXL memory device ECS control feature
  cxl/mbox: Add support for PERFORM_MAINTENANCE mailbox command
  cxl/region: Add helper function to determine memory is online
  cxl: Support for finding memory operation attributes from the current
    boot
  cxl/memfeature: Add CXL memory device soft PPR control feature
  EDAC: Update memory repair control interface for memory sparing
    feature
  cxl/memfeature: Add CXL memory device memory sparing control feature

 Documentation/ABI/testing/sysfs-edac-ecs      |   74 +
 .../ABI/testing/sysfs-edac-memory-repair      |  206 ++
 Documentation/ABI/testing/sysfs-edac-scrub    |   69 +
 Documentation/edac/features.rst               |  104 +
 Documentation/edac/index.rst                  |   12 +
 Documentation/edac/memory_repair.rst          |  209 ++
 Documentation/edac/scrub.rst                  |  393 ++++
 drivers/acpi/Kconfig                          |   11 +
 drivers/acpi/Makefile                         |    1 +
 drivers/acpi/ras2.c                           |  417 ++++
 drivers/cxl/Kconfig                           |   20 +
 drivers/cxl/core/Makefile                     |    1 +
 drivers/cxl/core/core.h                       |   11 +
 drivers/cxl/core/features.c                   |   20 +
 drivers/cxl/core/mbox.c                       |   45 +-
 drivers/cxl/core/memdev.c                     |    9 +
 drivers/cxl/core/memfeatures.c                | 1723 +++++++++++++++++
 drivers/cxl/core/ras.c                        |  151 ++
 drivers/cxl/core/region.c                     |   15 +
 drivers/cxl/cxlmem.h                          |   82 +
 drivers/cxl/mem.c                             |    4 +
 drivers/cxl/pci.c                             |    3 +
 drivers/edac/Kconfig                          |   28 +
 drivers/edac/Makefile                         |    4 +
 drivers/edac/ecs.c                            |  207 ++
 drivers/edac/edac_device.c                    |  185 ++
 drivers/edac/mem_repair.c                     |  365 ++++
 drivers/edac/scrub.c                          |  209 ++
 drivers/ras/Kconfig                           |   11 +
 drivers/ras/Makefile                          |    1 +
 drivers/ras/acpi_ras2.c                       |  383 ++++
 include/acpi/ras2_acpi.h                      |   47 +
 include/linux/edac.h                          |  228 +++
 33 files changed, 5246 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-edac-ecs
 create mode 100644 Documentation/ABI/testing/sysfs-edac-memory-repair
 create mode 100644 Documentation/ABI/testing/sysfs-edac-scrub
 create mode 100644 Documentation/edac/features.rst
 create mode 100644 Documentation/edac/index.rst
 create mode 100644 Documentation/edac/memory_repair.rst
 create mode 100644 Documentation/edac/scrub.rst
 create mode 100755 drivers/acpi/ras2.c
 create mode 100644 drivers/cxl/core/memfeatures.c
 create mode 100644 drivers/cxl/core/ras.c
 create mode 100755 drivers/edac/ecs.c
 create mode 100755 drivers/edac/mem_repair.c
 create mode 100755 drivers/edac/scrub.c
 create mode 100644 drivers/ras/acpi_ras2.c
 create mode 100644 include/acpi/ras2_acpi.h

-- 
2.43.0


