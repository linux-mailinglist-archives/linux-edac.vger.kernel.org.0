Return-Path: <linux-edac+bounces-5658-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG56IjvzcWmvZwAAu9opvQ
	(envelope-from <linux-edac+bounces-5658-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:51:55 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E364D0D
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 10:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08E8E68AFF5
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jan 2026 09:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D423382F0;
	Thu, 22 Jan 2026 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="N1xj0lN0"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EA928506C;
	Thu, 22 Jan 2026 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075239; cv=none; b=ukx6FWoy7eamuHnGqYIwb+WrS98jdU8w4JzMpOXMIK+biG/yxgLIdILx7sBWEUnTGkc7xW2NiLN/tSGMlTE1haaGsn/Q6m3gjflkgz1pzpeF+Dx++ToQQCaCR8pDz3FmvIdbHcqDPXQAlTSSmmJsHN93b3IxCuyV0QBcqsNwVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075239; c=relaxed/simple;
	bh=2tS1P3++RX8Mb3hfYEVCMbPSoSQRbnE512WhD9SFeK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PyM3y+C1y9E9mxu4au3xDD4SiFF4N8TIMpZC+ZyXstORnxw+NZib0uc08ws2oyiWJuhJn04VjAfNIu7giaVouiGgMUCPbmlDXJDw+NFeV8XD4OuAio76y98S9rAVluphpT70/gf1/OPUmSIo2hg8kqos1aorKnHY2GoZgwJifFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=N1xj0lN0; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769075227; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=9a+M4WABMCHRC9YvzKt1jIcQpX8yStU/HvIDVdOsiqY=;
	b=N1xj0lN0IsVrkn24XdZKHdbztgK7E0Q/DWWIGmpbfMQmSH3TcZv/ytl6xky5Z76kPpBaiukCwoSjTi0BdfDDoEiEJ4T6f8GrAc/KvWgzzN8ZB2yxMhoOtX5sUfAwp7XTlgwGVRpWQVUlSs7I+uJAKHviSTfJpjTl/CYUu1C/NoY=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WxbuwS7_1769075219 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 17:47:06 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	robin.murphy@arm.com,
	mark.rutland@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org
Cc: lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-edac@vger.kernel.org,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH v6 00/16] Support Armv8 RAS Extensions for Kernel-first error handling
Date: Thu, 22 Jan 2026 17:46:40 +0800
Message-Id: <20260122094656.73399-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.96 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5658-lists,linux-edac=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tianruidong@linux.alibaba.com,linux-edac@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-edac];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,arm.com:url]
X-Rspamd-Queue-Id: 3F2E364D0D
X-Rspamd-Action: no action

Motivation: Reliability in Modern Data Centers
=================================================
In modern data centers, proactive maintenance is essential for achieving high
service availability. The practice of using Corrected Errors (CE) to predict
impending Uncorrected Errors (UE) is already widely deployed at scale across
the industry, like Alibaba[2], Tencent[4], Intel[1], AMD[2]. By analyzing CE
telemetry, operators can identify failing hardware and perform migrations
before catastrophic failures occur.

Problem: Inefficient CE Collection on ARM
==========================================
Currently, ARM-based systems primarily rely on "Firmware-First" error
handling (e.g., via GHES). This path is inherently heavy-weight. To avoid
significant performance overhead, firmware is often configured with high
thresholds—reporting to the OS only after thousands of CEs have occurred.
If the threshold is set lower, the high frequency of errors leads to
excessive and costly context switching between the OS and firmware.
Consequently, ARM platforms currently lack an efficient mechanism to collect
the granular CE data required for high-fidelity error prediction.

Solution: Kernel-First Handling via AEST
===========================================
Other architectures have long utilized "Kernel-First" approaches for
efficient CE collection: Intel provides CMCI (Corrected Machine Check
Interrupt), and AMD has recently introduced similar CE interrupt support[5].

On the ARM architecture, hardware already provides the necessary RAS
Extensions[6], and the ACPI AEST specification[0] defines a standardized way for
the OS to discover these error source registers. This series implements
AEST support, enabling the kernel to:

 - Discover error sources directly via ACPI tables.
 - Handle CE notifications via direct interrupts.
 - Bypass firmware overhead to collect every CE or use low-latency thresholds.

This implementation provides the missing link for efficient RAS telemetry
on ARM, bringing it to parity with other enterprise architectures.

Background and Maintenance
=============================
This series is based on Tyler Baicar's preliminary patches [7]. I attempted
to follow up with Tyler in 2022 [8] but received no reply. As he no longer
appears active on the mailing list, I have picked up this work, updated it
to align with the latest AEST v2.0 specification, and addressed pending
feedback to ensure this critical feature is integrated into the mainline.

AEST Driver Architecture
========================

The AEST driver is structured into three primary components:
  - AEST device: Responsible for handling interrupts, managing the lifecycle
                 of AEST nodes, and processing error records.
  - AEST node: Corresponds directly to a RAS node in the hardware
  - AEST record: Represents a set of RAS registers associated with a specific
                 error source.

Comparison with x86 MCA:

RAS record ≈ MCA bank.
RAS node ≈ A set of MCA banks + CMCI on a core.

The key difference lies in uncore handling: x86 typically maps uncore errors
(like those from a memory controller) into core-based MCA banks. In contrast,
ARM requires uncore components to provide their own standalone RAS nodes. When
a component requires multiple such nodes, they are grouped and managed as a
"RAS device" in AEST driver. 

These components are organized hierarchically as follows:

 ┌──────────────────────────────────────────────────┐
 │             AEST Driver Device Management        │
 │┌─────────────┐    ┌──────────┐     ┌───────────┐ │
 ││ AEST Device ├─┬─►│AEST Node ├──┬─►│AEST Record│ │
 │└─────────────┘ │  └──────────┘  │  └───────────┘ │
 │                │       .        │  ┌───────────┐ │
 │                │       .        ├─►│AEST Record│ │
 │                │       .        │  └───────────┘ │
 │                │  ┌──────────┐  │        .       │
 │                ├─►│AEST Node │  │        .       │
 │                │  └──────────┘  │        .       │
 │                │                │  ┌───────────┐ │
 │                │  ┌──────────┐  └─►│AEST Record│ │
 │                └─►│AEST Node │     └───────────┘ │
 │                   └──────────┘                   │
 └──────────────────────────────────────────────────┘

AEST Interrupt Handle
=====================

Upon an AEST interrupt, the driver performs the following sequence:
1. The AEST device iterates through all registered AEST nodes to identify the
   specific node(s) and record(s) that reported an error.
2. Each node typically contains two types of records:
      - report record: Errors can be located efficiently through a bitmap
                       in the `ERRGSR` register.
      - poll record: The node must individually poll all records to determine
                     if an error has occurred.
3. process record:
      - if error is corrected, The CE threshold is reset, and the error event
        is logged.
      - if error is defered, Relevant registers are dumped, and
        `memory_failure()` is invoked.
      - if error is uncorrected, panic, While UEs typically trigger an
        exception rather than an interrupt, if detected, the system will panic.
4. decode record: The AEST driver notifies other relevant drivers, such as
   EDAC, to further decode the reported RAS register information.

Testing
===================
I have tested this series on THead Yitian710 SOC with customized BIOS. Someone
can also use QEMU[9] for preliminary driver testing.

1. Boot Qemu

qemu-system-aarch64 -smp 4 -m 32G \
  -cpu host --enable-kvm -machine virt,gic-version=3 \
  -kernel Image -initrd initrd.cpio.gz \
  -device virtio-net-pci,netdev=t0 -netdev user,id=t0 \
  -bios /usr/share/edk2/aarch64/QEMU_EFI.fd  \
  -append "rdinit=/sbin/init earlycon verbose debug console=ttyAMA0 aest.dyndbg='+pt'" \
  -nographic -d guest_errors -D qemu.log

2. inject error
devmem 0x90d0808 l 0xc4800390

2.1 Memory error
[   64.959849] AEST: {1}[Hardware Error]: Hardware error from AEST memory.90d0000
[   64.959852] AEST: {1}[Hardware Error]:  Error from memory at SRAT proximity domain 0x0
[   64.959855] AEST: {1}[Hardware Error]:   ERR0FR: 0x40000080044081
[   64.959858] AEST: {1}[Hardware Error]:   ERR0CTRL: 0x108
[   64.959859] AEST: {1}[Hardware Error]:   ERR0STATUS: 0xc4800390
[   64.959860] AEST: {1}[Hardware Error]:   ERR0ADDR: 0x8400000043344521
[   64.959861] AEST: {1}[Hardware Error]:   ERR0MISC0: 0x7fff00000000
[   64.959861] AEST: {1}[Hardware Error]:   ERR0MISC1: 0x0
[   64.959862] AEST: {1}[Hardware Error]:   ERR0MISC2: 0x0
[   64.959863] AEST: {1}[Hardware Error]:   ERR0MISC3: 0x0
[   64.959873] Memory failure: 0x43344: recovery action for free buddy page: Recovered

2.2 CMN error
[  132.044283] AEST: {2}[Hardware Error]: Hardware error from AEST XP
[  132.044286] AEST: {2}[Hardware Error]:  Error from vendor hid ARMHC700 uid 0x0
[  132.044288] AEST: {2}[Hardware Error]:   ERR0FR: 0x48a5
[  132.044290] AEST: {2}[Hardware Error]:   ERR0CTRL: 0x108
[  132.044292] AEST: {2}[Hardware Error]:   ERR0STATUS: 0xc4800390
[  132.044293] AEST: {2}[Hardware Error]:   ERR0ADDR: 0x8400000043344521
[  132.044295] AEST: {2}[Hardware Error]:   ERR0MISC0: 0x0
[  132.044296] AEST: {2}[Hardware Error]:   ERR0MISC1: 0x0
[  132.044298] AEST: {2}[Hardware Error]:   ERR0MISC2: 0x0
[  132.044299] AEST: {2}[Hardware Error]:   ERR0MISC3: 0x0
[  132.044302] Memory failure: 0x43344: recovery action for already poisoned page: Failed

[0]: https://developer.arm.com/documentation/den0085/0200/
[1]: Intel: Predicting Uncorrectable Memory Errors from the Correctable Error History
[2]: Alibaba. Predicting DRAM-Caused Risky VMs in Large-Scale Clouds. Published in HPCA2025
[3]: AMD: Physics-informed machinelearning for dram error modeling
[4]: Tencent: Predicting uncorrectablememory errors for proactive replacement: An empirical study on large-scale field data
[5]: https://lore.kernel.org/all/20251104-wip-mca-updates-v8-4-66c8eacf67b9@amd.com/
[6]: https://developer.arm.com/documentation/ihi0100/
[7]: https://lore.kernel.org/all/20211124170708.3874-1-baicar@os.amperecomputing.com/
[8]: https://lore.kernel.org/all/b365db02-b28c-1b22-2e87-c011cef848e2@linux.alibaba.com/
[9]: https://github.com/winterddd/qemu/tree/error_record

Change from V5:
https://lore.kernel.org/all/20251230090945.43969-1-tianruidong@linux.alibaba.com/
1. Based on the feedback from Borislav Petkov, I've dropped the idea of a 
   unified address translation interface across ARM and AMD.

Change from V4:
https://lore.kernel.org/all/20251222094351.38792-1-tianruidong@linux.alibaba.com/
1. Fix build warning in 0010 and 0014 report by kernel test robot:
    https://lore.kernel.org/all/202512230122.CfXZcF76-lkp@intel.com/
    https://lore.kernel.org/all/202512230007.Vs6IvFVD-lkp@intel.com/
2. Dropped the extra patch(0014) that was mistakenly included in v4.

Change from V3:
https://lore.kernel.org/all/20250115084228.107573-1-tianruidong@linux.alibaba.com/
1. Add vendor AEST node framework and support CMN700
2. Borislav Petkov
    - Split into multiple smaller patches for easier review.
    - refined the English in the cover letter for better flow.
3. Accept Tomohiro Misono's comment

Change from V2:
https://lore.kernel.org/all/20240321025317.114621-1-tianruidong@linux.alibaba.com/
1. Tomohiro Misono
    - dump register before panic
2. Baolin Wang & Shuai Xue: accept all comment.
3. Support AEST V2.

Change from V1:
https://lore.kernel.org/all/20240304111517.33001-1-tianruidong@linux.alibaba.com/
1. Marc Zyngier
  - Use readq/writeq_relaxed instead of readq/writeq for MMIO address.
  - Add sync for system register operation.
  - Use irq_is_percpu_devid() helper to identify a per-CPU interrupt.
  - Other fix.
2. Set RAS CE threshold in AEST driver.
3. Enable RAS interrupt explicitly in driver.
4. UER and UEO trigger memory_failure other than panic.

Ruidong Tian (16):
  ACPI/AEST: Parse the AEST table
  ras: AEST: Add probe/remove for AEST driver
  ras: AEST: support different group format
  ras: AEST: Unify the read/write interface for system and MMIO register
  ras: AEST: Probe RAS system architecture version
  ras: AEST: Support RAS Common Fault Injection Model Extension
  ras: AEST: Support CE threshold of error record
  ras: AEST: Enable and register IRQs
  ras: AEST: Add cpuhp callback
  ras: AEST: Introduce AEST driver sysfs interface
  ras: AEST: Add error count tracking and debugfs interface
  ras: AEST: Allow configuring CE threshold via debugfs
  ras: AEST: Introduce AEST inject interface to test AEST driver
  ras: AEST: Add framework to process AEST vendor node
  ras: AEST: support vendor node CMN700
  trace, ras: add ARM RAS extension trace event

 Documentation/ABI/testing/debugfs-aest |   99 +++
 MAINTAINERS                            |   11 +
 arch/arm64/include/asm/arm-cmn.h       |   47 ++
 arch/arm64/include/asm/ras.h           |   95 +++
 drivers/acpi/arm64/Kconfig             |   11 +
 drivers/acpi/arm64/Makefile            |    1 +
 drivers/acpi/arm64/aest.c              |  311 +++++++
 drivers/perf/arm-cmn.c                 |   37 +-
 drivers/ras/Kconfig                    |    1 +
 drivers/ras/Makefile                   |    1 +
 drivers/ras/aest/Kconfig               |   17 +
 drivers/ras/aest/Makefile              |    8 +
 drivers/ras/aest/aest-cmn.c            |  330 ++++++++
 drivers/ras/aest/aest-core.c           | 1054 ++++++++++++++++++++++++
 drivers/ras/aest/aest-inject.c         |  131 +++
 drivers/ras/aest/aest-sysfs.c          |  228 +++++
 drivers/ras/aest/aest.h                |  410 +++++++++
 drivers/ras/ras.c                      |    3 +
 include/linux/acpi_aest.h              |   75 ++
 include/linux/cpuhotplug.h             |    1 +
 include/linux/ras.h                    |    8 +
 include/ras/ras_event.h                |   71 ++
 22 files changed, 2914 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-aest
 create mode 100644 arch/arm64/include/asm/arm-cmn.h
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 drivers/acpi/arm64/aest.c
 create mode 100644 drivers/ras/aest/Kconfig
 create mode 100644 drivers/ras/aest/Makefile
 create mode 100644 drivers/ras/aest/aest-cmn.c
 create mode 100644 drivers/ras/aest/aest-core.c
 create mode 100644 drivers/ras/aest/aest-inject.c
 create mode 100644 drivers/ras/aest/aest-sysfs.c
 create mode 100644 drivers/ras/aest/aest.h
 create mode 100644 include/linux/acpi_aest.h

-- 
2.51.2.612.gdc70283dfc


