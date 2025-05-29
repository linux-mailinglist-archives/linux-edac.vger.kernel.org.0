Return-Path: <linux-edac+bounces-4029-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B008AC7602
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 05:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EABA401A0
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 03:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91FC24469E;
	Thu, 29 May 2025 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o2tgEU/2"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133C919DFA2;
	Thu, 29 May 2025 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748487630; cv=none; b=e77UCFwTJN0OLYs3kEvqV5Z1jHxPg2aE/IrABrW8D6iJTT8Sk2nKvH+sZK0Utwq3mjBZIfIzFBPapMdr84OJJjfV3dBooVTuPZuNZaNoQcNreJMfQknIpi8iAFzQE9bLqC3DWMZlZiYnotYShaf7Y6Gv7eXX5xBnsPcmDMz7PmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748487630; c=relaxed/simple;
	bh=YAN4uEVex/h42afm3vxFht1b6ELxdAfRDQHI1svE8KA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=UHaAqp+7XpUDL7234B8vYAchonmxKSaxMA4Tz/Ch1iWmHTkhHlRVSFSaJCvPgdT49c9CkXalcCuLyXAHgvpU3/8DUQ83wAXGdQavMQpObHSTW8nhWmqoh/liK8fx1BD9qFGTsS1gB5XYgTwY8EdXExmglS4lqsxWICxYnL2CmXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=o2tgEU/2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1053)
	id 915A22025672; Wed, 28 May 2025 20:00:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 915A22025672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748487628;
	bh=scNN6xCYjodU5uYJB32QFcuotsyro0TTd3EtAy5SpIM=;
	h=From:To:Cc:Subject:Date:From;
	b=o2tgEU/2BdIF+jFXpArYzdBfo+NST72w+soElO4A+B43Xr7dmKj/v9FjzhHSoF84W
	 Z5blO12gUgqc+MFHgIsQcP6tLt909rihCDKH2rM7JKr75XUnmrKiXBzhLCMGeYLUZD
	 IrA8JwGBk6s4WD/orLgGjUJac589S8wCeT/5mi8c=
From: Vijay Balakrishna <vijayb@linux.microsoft.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tyler Hicks <code@tyhicks.com>,
	Marc Zyngier <maz@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org,
	Vijay Balakrishna <vijayb@linux.microsoft.com>
Subject: [v11 PATCH 0/2] Add L1 and L2 error detection for A72
Date: Wed, 28 May 2025 20:00:26 -0700
Message-Id: <1748487628-30123-1-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

This is an attempt to revive [v5] series. I have attempted to address comments
and suggestions from Marc Zyngier since [v5]. Additionally, I have limited
the support only for A72 processors per [v8] discussion. Testing the driver
on a problematic A72 SoC has led to the detection of Correctable Errors (CEs).
Below are logs captured from the problematic SoC during various boot instances.

[  876.896022] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'

[ 3700.978086] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'

[  976.956158] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'

[ 1427.933606] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'

[  192.959911] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'

Testing our product kernel involved adding the 'edac-enabled' property to CPU
nodes in the DTS. For mainline sanity checks, we tested under QEMU by
extracting the default DTB and modifying the DTS to include the 'edac-enabled'
property. We then verified the presence of /sysfs nodes for CE and UE counts
for the emulated A72 CPUs.

Our primary focus is on A72. We have a significant number of A72-based systems
in our fleet, and timely replacements via monitoring CEs will be instrumental
in managing them effectively.

I am eager to hear your suggestions and feedback on this series.

Thanks,
Vijay

[v5] https://lore.kernel.org/all/20210401110615.15326-1-s.hauer@pengutronix.de/#t
[v6] https://lore.kernel.org/all/1744241785-20256-1-git-send-email-vijayb@linux.microsoft.com/
[v7] https://lore.kernel.org/all/1744409319-24912-1-git-send-email-vijayb@linux.microsoft.com/#t
[v8] https://lore.kernel.org/all/1746404860-27069-1-git-send-email-vijayb@linux.microsoft.com/
[v9] https://lore.kernel.org/all/1747353973-4749-1-git-send-email-vijayb@linux.microsoft.com/
[v10] https://lore.kernel.org/all/1748387790-20838-1-git-send-email-vijayb@linux.microsoft.com/

Changes since v10: 
- edac_a72.c: copyright line add (Jonathan)
- cpus.yaml: drop stale comment line (Krzysztof)
- added "Reviewed-by" tags

Changes since v9: 
- commit title, message and prefix update (Boris)
- fix spelling in Kconfig help text (Boris)
- prepared patches against edac-for-next (Boris)
- struct naming update from "merrsr" to "mem_err_synd_reg" (Boris)
- grouping of all defines (Boris)
- function variable declarations in reverse fir tree order (Boris)
- simplify naming of static functions (Boris)
- protect smp_call_function_single() against CPU hotplug (Boris)
- "CPU" in visible string instead of "cpu" (Boris)
- error message reflects "edac_a72" driver name (Boris)
- fixed the issues with device_node release using scope exit (Jonathan)
- of_cpu_device_node_get() instead of of_get_cpu_node() (Jonathan)
- make dt-binding update applicable only for A72 using if/then schema (Rob)

Changes since v8: 
- removed support for A53 and A57
- added entry to MAINTAINERS
- added missing module exit point to enable unload

Changes since v7: 
- v5 was based on the internal product kernel, identified following upon review
- correct format specifier to print CPUID/WAY
- removal of unused dynamic attributes for edac_device_alloc_ctl_info() 
- driver remove callback return type is void

Changes since v6:
- restore the change made in [v5] to clear CPU/L2 syndrome registers
  back to read_errors()
- upon detecting a valid error, clear syndrome registers immediately
  to avoid clobbering between the read and write (Marc)
- NULL return check for of_get_cpu_node() (Tyler)
- of_node_put() to avoid refcount issue (Tyler)
- quotes are dropped in yaml file (Krzysztof)

Changes since v5:
- rebase on v6.15-rc1
- the syndrome registers for CPU/L2 memory errors are cleared only upon
  detecting an error and an isb() after for synchronization (Marc)
- "edac-enabled" hunk moved to initial patch to avoid breaking virtual
  environments (Marc)
- to ensure compatibility across all three families, we are not reporting
  "L1 Dirty RAM," documented only in the A53 TRM
- above prompted changing default CPU L1 error meesage from "unknown"
  to "Unspecified"
- capturing CPUID/WAY information in L2 memory error log (Marc)
- module license from "GPL v2" to "GPL" (checkpatch.pl warning)
- extend support for A72

Sascha Hauer (2):
  EDAC: Add EDAC driver for ARM Cortex A72 cores
  dt-bindings: arm: cpus: Add edac-enabled property

 .../devicetree/bindings/arm/cpus.yaml         |  50 ++--
 MAINTAINERS                                   |   7 +
 drivers/edac/Kconfig                          |   8 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/edac_a72.c                       | 230 ++++++++++++++++++
 5 files changed, 280 insertions(+), 16 deletions(-)
 create mode 100644 drivers/edac/edac_a72.c


base-commit: 855b5de2e562c07d6cda4deb08d09dc2e0e2b18d
-- 
2.49.0


