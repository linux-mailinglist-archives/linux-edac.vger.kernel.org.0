Return-Path: <linux-edac+bounces-1843-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 000BE974DE6
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2024 11:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B346C285FAB
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2024 09:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A567915E5B8;
	Wed, 11 Sep 2024 09:07:03 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBA95339F;
	Wed, 11 Sep 2024 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045623; cv=none; b=T+d0l42ZObjOoBP9EUQB3krmSPQgNvfnTK3duPzX17u2CxtGg2DZs+0rh/PlUqMuYsnlbOmr4TQ+N7NzqWbAXlt3eI9k6bLqiYbjZM2m/++YVjp5eRIEk14kF4AkHXCHjVJr2LfNbrvobk1vdvZ2iCALLG3d9GRqpcwVY5/g3TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045623; c=relaxed/simple;
	bh=kfq6IUMsX5q/85fA0oHTaOr+KspV5sjMULBQnQa1qHE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=klJ5QEyVKc/8TNvZiXLOuUAFHv8XZ8hriNfIL75ZNp9IYc6sNKTMIm5KVABTcxv/N/7gabicYPuj2cQu08OXRgQT5kUXs25CfO2/PnGH+UxTjUBaVxj6GSl9YftLL2WOnV0BMVPAD95gq9okid7l6Xv7oH+76ajaUkUTldJ7lJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X3ZNm28Rsz6LDFQ;
	Wed, 11 Sep 2024 17:03:20 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A7521400F4;
	Wed, 11 Sep 2024 17:06:57 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.245.151) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 11:06:54 +0200
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
	<duenwen@google.com>, <mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>,
	<jgroves@micron.com>, <vsalve@micron.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v12 00/17] EDAC: Scrub: introduce generic EDAC RAS control feature driver + CXL/ACPI-RAS2 drivers
Date: Wed, 11 Sep 2024 10:04:29 +0100
Message-ID: <20240911090447.751-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Previously known as "ras: scrub: introduce subsystem + CXL/ACPI-RAS2 drivers".

Augmenting EDAC for controlling RAS features
============================================
The proposed expansion of EDAC for controlling RAS features and
exposing feature's control attributes to userspace in sysfs.
Some Examples:
 - Scrub control
 - Error Check Scrub (ECS) control
 - ACPI RAS2 features
 - ACPI Address Range Scrubbing (ARS)
 - Post Package Repair (PPR) etc.

High level design is illustrated in the following diagram.
 
         _______________________________________________
        |   Userspace - Rasdaemon                       |
        |  ____________                                 |
        | | RAS CXL    |       _____________            | 
        | | Err Handler|----->|             |           |
        | |____________|      | RAS Dynamic |           |
        |  ____________       | Scrub, PPR  |           |
        | | RAS Memory |----->| Controller  |           |
        | | Err Handler|      |_____________|           |
        | |____________|           |                    |
        |__________________________|____________________|                              
                                   |
                                   |
    _______________________________|______________________________
   |   Kernel EDAC based SubSystem | for RAS Features Control     |
   | ______________________________|____________________________  |
   || EDAC Core          Sysfs EDAC| Bus                        | |
   ||    __________________________|_______     _____________   | |
   ||   |/sys/bus/edac/devices/<dev>/scrub/|   | EDAC Device |  | |
   ||   |/sys/bus/edac/devices/<dev>/ecs*/ |<->| EDAC MC     |  | |
   ||   |/sys/bus/edac/devices/<dev>/ars/  |   | EDAC Sysfs  |  | |
   ||   |/sys/bus/edac/devices/<dev>/ppr/  |   | EDAC Module |  | |
   ||   |__________________________________|   |_____________|  | |
   ||                               | EDAC Bus                  | |
   ||               Get             |                           | |
   ||    __________ Feature's       |             __________    | |
   ||   |          |Descs  _________|______      |          |   | |
   ||   |EDAC Scrub|<-----| EDAC Device    |---->| EDAC ARS |   | |
   ||   |__________|      | Driver- RAS    |     |__________|   | |
   ||    __________       | Feature Control|      __________    | |
   ||   |          |<-----|________________|---->|          |   | |
   ||   |EDAC ECS  |   Register RAS | Features   | EDAC PPR |   | |
   ||   |__________|                |            |__________|   | |
   ||         ______________________|___________________        | |
   ||_________|_____________|_____________|____________|________| |
   |   _______|____    _____|______   ____|______   ___|_____     |
   |  |            |  | CXL Mem    | |           | | Client  |    |
   |  | ACPI RAS2  |  | Driver PPR,| | ACPI ARS  | | PPR     |    |
   |  | Driver     |  | Scrub,ECS  | | Driver    | | Driver  |    |
   |  |____________|  |____________| |___________| |_________|    |
   |        |              |              |           |           |
   |________|______________|______________|___________|___________|
            |              |              |           |          
     _______|______________|______________|___________|___________
    |     __|______________|_ ____________|___________|_____      |
    |    |                                                  |     |
    |    |            Platform HW and Firmware              |     |
    |    |__________________________________________________|     |
    |_____________________________________________________________|                             

1. EDAC RAS Features components - Create feature specific descriptors.
   for example, EDAC scrub, EDAC ECS, EDAC PPR, EDAC ARS in the above diagram. 
2. EDAC control RAS Feature driver - Get feature's attr descriptors from the 
   EDAC RAS feature component and registers device's RAS features with
   EDAC bus and expose the feature's sysfs attributes under the sysfs
   EDAC bus.
3. RAS dynamic scrub controller - Userspace sample module added in the
   rasdaemon to start scrubbing when excess number of related errors
   are reported in a short span of time.

The added EDAC feature specific components (e.g. EDAC scrub, EDAC ECS,
EDAC PPR etc) do callbacks to  the parent driver (e.g. CXL driver,
ACPI RAS driver etc) for the controls rather than just letting the
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
1. Background (patrol) scrubbing of the RAM whilest the RAM is otherwise
   idle.
2. On-demand scrubbing for a specific address range/region of memory.

There are several types of interfaces to HW memory scrubbers
identified such as ACPI NVDIMM ARS(Address Range Scrub), CXL memory
device patrol scrub, CXL DDR5 ECS, ACPI RAS2 memory scrubbing.

The scrub control varies between different memory scrubbers. To allow
for standard userspace tooling there is a need to present these controls
with a standard ABI.

Introduce generic memory EDAC scrub control which allows user to
control underlying scrubbers in the system via generic sysfs scrub
control interface.

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
   - to detect uncorrectable memory errors early before user accessing memory,
     which helps to recover the detected memory errors.
   - reduces the chance of a correctable error becoming uncorrectable.
5. Policy control for hotplugged memory. There is not necessarily a system
   wide bios or similar in the loop to control the scrub settings on a CXL
   device that wasn't there at boot. What that setting should be is a policy
   decision as we are trading of reliability vs performance - hence it should
   be in control of userspace. As such, 'an' interface is needed. Seems more
   sensible to try and unify it with other similar interfaces than spin
   yet another one.

The draft version of userspace code for dynamic scrub control, based
on frequency of memory errors reported to userspace, is added in
rasdaemon and enabled, tested for CXL device based patrol scrubbing feature
and ACPI RAS2 based scrubbing feature.

https://github.com/shijujose4/rasdaemon/tree/ras_feature_control

ToDO: For PPR, rasdaemon collates records and decides to replace a row if there
are lots of corrected errors, or a single uncorrected error or error record
received with maintenance request flag set as in CXL DRAM error record.

Comparison of scrubbing features
================================
 ................................................................
 .              .   ACPI    . CXL patrol.  CXL ECS  .  ARS      .
 .  Name        .   RAS2    . scrub     .           .           .
 ................................................................
 .              .           .           .           .           .
 . On-demand    . Supported . No        . No        . Supported .
 . Scrubbing    .           .           .           .           .
 .              .           .           .           .           .  
 ................................................................
 .              .           .           .           .           .
 . Background   . Supported . Supported . Supported . No        .
 . scrubbing    .           .           .           .           .
 .              .           .           .           .           .
 ................................................................
 .              .           .           .           .           .
 . Mode of      . Scrub ctrl. per device. per memory.  Unknown  .
 . scrubbing    . per NUMA  .           . media     .           .
 .              . domain.   .           .           .           .
 ................................................................
 .              .           .           .           .           . 
 . Query scrub  . Supported . Supported . Supported . Supported .       
 . capabilities .           .           .           .           .
 .              .           .           .           .           .
 ................................................................
 .              .           .           .           .           . 
 . Setting      . Supported . No        . No        . Supported .       
 . address range.           .           .           .           .
 .              .           .           .           .           .
 ................................................................
 .              .           .           .           .           . 
 . Setting      . Supported . Supported . No        . No        .       
 . scrub rate   .           .           .           .           .
 .              .           .           .           .           .
 ................................................................
 .              .           .           .           .           . 
 . Unit for     . Not       . in hours  . No        . No        .       
 . scrub rate   . Defined   .           .           .           .
 .              .           .           .           .           .
 ................................................................
 .              . Supported .           .           .           .
 . Scrub        . on-demand . No        . No        . Supported .
 . status/      . scrubbing .           .           .           .
 . Completion   . only      .           .           .           .
 ................................................................
 . UC error     .           .CXL general.CXL general. ACPI UCE  .
 . reporting    . Exception .media/DRAM .media/DRAM . notify and.
 .              .           .event/media.event/media. query     .
 .              .           .scan?      .scan?      . ARS status.
 ................................................................
 .              .           .           .           .           .      
 . Clear UC     .  No       . No        .  No       . Supported .
 . error        .           .           .           .           .
 .              .           .           .           .           .  
 ................................................................
 .              .           .           .           .           .
 . Translate    . No        . No        . No        . Supported .
 . *(1)SPA to   .           .           .           .           .
 . *(2)DPA      .           .           .           .           .  
 ................................................................

*(1) - SPA - System Physical Address. See section 9.19.7.8
       Function Index 5 - Translate SPA of ACPI spec r6.5.  
*(2) - DPA - Device Physical Address. See section 9.19.7.8
       Function Index 5 - Translate SPA of ACPI spec r6.5.  

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

Series adds,
1. Generic EDAC RAS feature driver, EDAC scrub driver, EDAC ECS driver
   supports memory scrub control, ECS control and PPR control, other
   RAS features in the system.
2. Support for CXL feature mailbox commands, which is used by
   CXL device scrubbing and PPR features. 
3. CXL scrub driver supporting patrol scrub control (device and
   region based).
4. CXL ECS driver supporting ECS control feature.
5. ACPI RAS2 driver adds OS interface for RAS2 communication through
   PCC mailbox and extracts ACPI RAS2 feature table (RAS2) and
   create platform device for the RAS memory features, which binds
   to the memory ACPI RAS2 driver.
7. Memory ACPI RAS2 driver gets the PCC subspace for communicating
   with the ACPI compliant platform supports ACPI RAS2. Add callback
   functions and registers with EDAC scrub to support user to
   control the HW patrol scrubbers exposed to the kernel via the
   ACPI RAS2 table.
8. Support for CXL maintenance mailbox command, which is used by
   CXL device PPR feature.   
9. CXL PPR driver supporting PPR control feature.
10. Note: There are other PPR drivers to come.

Open Questions based on feedbacks from the community:
1. Leo: Standardize unit for scrub rate, for example ACPI RAS2 does not define
   unit for the scrub rate. RAS2 clarification needed. 
2. Jonathan: Any need for discoverability of capability to scan different regions,
   such as global PA space to userspace. Left as future extension.
3. Jiaqi:
   - STOP_PATROL_SCRUBBER from RAS2 must be blocked and, must not be exposed to
     OS/userspace. Stopping patrol scrubber is unacceptable for platform where
     OEM has enabled patrol scrubber, because the patrol scrubber is a key part
     of logging and is repurposed for other RAS actions.
   If the OEM does not want to expose this control, they should lock it down so the
   interface is not exposed to the OS. These features are optional afterall.
   - "Requested Address Range"/"Actual Address Range" (region to scrub) is a
      similarly bad thing to expose in RAS2.
   If the OEM does not want to expose this, they should lock it down so the
   interface is not exposed to the OS. These features are optional afterall.
4. Borislav: 
   - How the scrub control exposed to userspace will be used?
     POC added in rasdaemon with dynamic scrub control for CXL memory media
     errors and memory errors reported to userspace.
     https://github.com/shijujose4/rasdaemon/tree/scrub_control_6_june_2024
   - Is the scrub interface is sufficient for the use cases?
   - Who is going to use scrub controls tools/admin/scripts?
     1) Rasdaemon for dynamic control
     2) Udev script for more static 'defaults' on hotplug etc.
5. PPR   
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
Latest version of kernel implementation of RAS features control is available in,
https://github.com/shijujose4/linux/tree/edac-enhancement-ras-features

2. QEMU emulation
2.1. The QEMU series to support the CXL specific scrub features is available in,
     https://gitlab.com/qemu-project/qemu.git
    
2.2. QEMU patch supports the CXL PPR feature is available in,
     https://lore.kernel.org/all/20240730045722.71482-1-dave@stgolabs.net/

3. Userspace rasdaemon
The draft version of userspace code for dynamic scrub control, based on
frequency of memory errors reported to userspace, is added in rasdaemon
and enabled, tested for CXL device based patrol scrubbing feature and
ACPI RAS2 based scrubbing feature.
https://github.com/shijujose4/rasdaemon/tree/ras_feature_control

ToDO: For PPR, rasdaemon collates records and decides to replace a row if there
are lots of corrected errors, or a single uncorrected error or error
record received with maintenance request flag set as in CXL DRAM error
record.
  
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
     attribute node cycle_in_hours_avaiable to min_cycle_duration and 
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

History for v1 to v8 is avaiable here.
https://lore.kernel.org/lkml/20240726160556.2079-1-shiju.jose@huawei.com/


Dave Jiang (4):
  cxl: Move mailbox related bits to the same context
  cxl: Fix comment regarding cxl_query_cmd() return data
  cxl: Refactor user ioctl command path from mds to mailbox
  cxl: Add Get Supported Features command for kernel usage

Jonathan Cameron (1):
  platform: Add __free() based cleanup function for platform_device_put

Shiju Jose (12):
  EDAC: Add support for EDAC device features control
  EDAC: Add EDAC scrub control driver
  EDAC: Add EDAC ECS control driver
  cxl/mbox: Add GET_FEATURE mailbox command
  cxl/mbox: Add SET_FEATURE mailbox command
  cxl/memfeature: Add CXL memory device patrol scrub control feature
  cxl/memfeature: Add CXL memory device ECS control feature
  ACPI:RAS2: Add ACPI RAS2 driver
  ras: mem: Add memory ACPI RAS2 driver
  EDAC: Add EDAC PPR control driver
  cxl/mbox: Add support for PERFORM_MAINTENANCE mailbox command
  cxl/memfeature: Add CXL memory device PPR control feature

 Documentation/ABI/testing/sysfs-edac-ecs   |   78 ++
 Documentation/ABI/testing/sysfs-edac-ppr   |   69 ++
 Documentation/ABI/testing/sysfs-edac-scrub |   69 ++
 Documentation/edac/edac-scrub.rst          |  115 +++
 MAINTAINERS                                |    1 +
 drivers/acpi/Kconfig                       |   10 +
 drivers/acpi/Makefile                      |    1 +
 drivers/acpi/ras2.c                        |  391 +++++++
 drivers/cxl/Kconfig                        |   18 +
 drivers/cxl/core/Makefile                  |    1 +
 drivers/cxl/core/core.h                    |    6 +-
 drivers/cxl/core/mbox.c                    |  485 +++++++--
 drivers/cxl/core/memdev.c                  |   57 +-
 drivers/cxl/core/memfeature.c              | 1084 ++++++++++++++++++++
 drivers/cxl/core/region.c                  |    6 +
 drivers/cxl/cxlmem.h                       |  190 +++-
 drivers/cxl/mem.c                          |    4 +
 drivers/cxl/pci.c                          |   68 +-
 drivers/cxl/pmem.c                         |   10 +-
 drivers/cxl/security.c                     |   18 +-
 drivers/edac/Makefile                      |    1 +
 drivers/edac/edac_device.c                 |  213 ++++
 drivers/edac/edac_ecs.c                    |  376 +++++++
 drivers/edac/edac_ppr.c                    |  255 +++++
 drivers/edac/edac_scrub.c                  |  377 +++++++
 drivers/ras/Kconfig                        |   10 +
 drivers/ras/Makefile                       |    1 +
 drivers/ras/acpi_ras2.c                    |  412 ++++++++
 include/acpi/ras2_acpi.h                   |   60 ++
 include/linux/cxl/mailbox.h                |   68 ++
 include/linux/edac.h                       |  148 +++
 include/linux/platform_device.h            |    1 +
 include/uapi/linux/cxl_mem.h               |    1 +
 tools/testing/cxl/test/mem.c               |   27 +-
 34 files changed, 4442 insertions(+), 189 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-edac-ecs
 create mode 100644 Documentation/ABI/testing/sysfs-edac-ppr
 create mode 100644 Documentation/ABI/testing/sysfs-edac-scrub
 create mode 100644 Documentation/edac/edac-scrub.rst
 create mode 100755 drivers/acpi/ras2.c
 create mode 100644 drivers/cxl/core/memfeature.c
 create mode 100755 drivers/edac/edac_ecs.c
 create mode 100755 drivers/edac/edac_ppr.c
 create mode 100755 drivers/edac/edac_scrub.c
 create mode 100644 drivers/ras/acpi_ras2.c
 create mode 100644 include/acpi/ras2_acpi.h
 create mode 100644 include/linux/cxl/mailbox.h

-- 
2.34.1


