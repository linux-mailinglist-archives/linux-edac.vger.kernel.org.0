Return-Path: <linux-edac+bounces-5190-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA468C08F83
	for <lists+linux-edac@lfdr.de>; Sat, 25 Oct 2025 13:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7441B230EF
	for <lists+linux-edac@lfdr.de>; Sat, 25 Oct 2025 11:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667B42F7AB8;
	Sat, 25 Oct 2025 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wTxY2ccG"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E1125A9;
	Sat, 25 Oct 2025 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761392537; cv=none; b=YvBlXj3defNVn4mxadl/wxFJoDQ9Bp1E/PXiYez9jioJX1QaVxttZ9Bxjmy2rDHt/bawfgPUMXKurGa/FfuI2pjIIL5zWBcPX+gt1nH1I+rfe9I6raIGkuySECvnIZFVgRVtaTI8edHyvujl4TETZVX1ofTt+3+demlDuJxz2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761392537; c=relaxed/simple;
	bh=H3mlJ0jLzxUq3liDuRwZIkiiKefMUKLhNzLfln0Gb/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nUESeWLnvoeEJcb/MT8akSgtczB6XphHCllEPaa2fD1lBUolgls6mu3565ytFgWQZoiiWnwAuKzaUXH9Z53AbyFt/3dH1U+iLLAZNZcWY7Yrc3KT/rNGXDnwfC8xLTS5KSStQXaYnNp1OMQKAo2ZjjqO0YJDXIX4K8pPAR+O4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wTxY2ccG; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761392526; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=GhFrCpZd8LutM5rPkha9lgb3n3CgPlLWOr9ztbGOOE0=;
	b=wTxY2ccGHTgzCjVgc+VvS4RSgNYOq30/u1RomlgSFcb3KlbugLQ8PiK6LQmVqIB77XyX/TMPEQmiDkZcOdhwGs+8oQXur10xBredWdJSHPl1Ae4abRDHQjqdtN+65Og3zj2BWcF22sJCRDBRV9zxvn4/pAzz+VL8acaSt+00i/c=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqwoUfp_1761392522 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 25 Oct 2025 19:42:04 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: rostedt@goodmis.org,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	helgaas@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mattc@purestorage.com,
	Jonathan.Cameron@huawei.com
Cc: bhelgaas@google.com,
	tony.luck@intel.com,
	bp@alien8.de,
	xueshuai@linux.alibaba.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	oleg@redhat.com,
	naveen@kernel.org,
	davem@davemloft.net,
	anil.s.keshavamurthy@intel.com,
	mark.rutland@arm.com,
	peterz@infradead.org,
	tianruidong@linux.alibaba.com
Subject: [PATCH v13 0/3] PCI: trace: Add a RAS tracepoint to monitor link speed changes
Date: Sat, 25 Oct 2025 19:41:55 +0800
Message-Id: <20251025114158.71714-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

changes since v12:
- add Reviewed-by tag for PATCH 1 from Steve
- add Reviewed-by tag for PATCH 1-3 from Ilpo
- add comments for why use string to define tracepoint per Steve
- minor doc improvements from Ilpo
- remove use pci_speed_string to fix PCI dependends which cause build error on sparc64

changes since v11:
- rebase to Linux 6.18-rc1 (no functional changes)

changes since v10:
- explicitly include header file per Ilpo
- add comma on any non-terminator entry  per Ilpo
- compile trace.o under CONFIG_TRACING per Ilpo

changes since v9:
- add a documentation about PCI tracepoints per Bjorn
- create a dedicated drivers/pci/trace.c that always defines the PCI tracepoints per Steve
- move tracepoint callite into __pcie_update_link_speed() per Lukas and Bjorn

changes since v8:
- rewrite commit log from Bjorn
- move pci_hp_event to a common place (include/trace/events/pci.h) per Ilpo
- rename hotplug event strings per Bjorn and Lukas
- add PCIe link tracepoint per Bjorn, Lukas, and Ilpo

changes since v7:
- replace the TRACE_INCLUDE_PATH to avoid macro conflict per Steven
- pick up Reviewed-by from Lukas Wunner

Hotplug events are critical indicators for analyzing hardware health, and
surprise link downs can significantly impact system performance and reliability.
In addition, PCIe link speed degradation directly impacts system performance and
often indicates hardware issues such as faulty devices, physical layer problems,
or configuration errors.

This patch set add PCI hotplug and PCIe link tracepoint to help analyze PCI
hotplug events and PCIe link speed degradation.

Shuai Xue (3):
  PCI: trace: Add a generic RAS tracepoint for hotplug event
  PCI: trace: Add a RAS tracepoint to monitor link speed changes
  Documentation: tracing: Add documentation about PCI tracepoints

 Documentation/trace/events-pci.rst |  74 +++++++++++++++++
 drivers/pci/Makefile               |   3 +
 drivers/pci/hotplug/pciehp_ctrl.c  |  31 +++++--
 drivers/pci/hotplug/pciehp_hpc.c   |   3 +-
 drivers/pci/pci.c                  |   2 +-
 drivers/pci/pci.h                  |  21 ++++-
 drivers/pci/pcie/bwctrl.c          |   4 +-
 drivers/pci/probe.c                |   9 +-
 drivers/pci/trace.c                |  11 +++
 include/trace/events/pci.h         | 129 +++++++++++++++++++++++++++++
 include/uapi/linux/pci.h           |   7 ++
 11 files changed, 279 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/trace/events-pci.rst
 create mode 100644 drivers/pci/trace.c
 create mode 100644 include/trace/events/pci.h

-- 
2.39.3


