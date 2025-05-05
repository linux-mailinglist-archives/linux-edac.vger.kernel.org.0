Return-Path: <linux-edac+bounces-3825-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE45AA8A5C
	for <lists+linux-edac@lfdr.de>; Mon,  5 May 2025 02:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40DC3B3968
	for <lists+linux-edac@lfdr.de>; Mon,  5 May 2025 00:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07F935971;
	Mon,  5 May 2025 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nl76ZD8G"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B661BC3C;
	Mon,  5 May 2025 00:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746404868; cv=none; b=Lv4Ii95k6tpsqvX6l2xqf2zV3IK5WyWKC6r4BvoSgugr+PQbTjtyksdIpmm6lEYZvfZKL+Mlb5enBM4T/OT/PMsg5elsLnkkePH/5OR/xHWdIAdAZ4LrL+wVp3G1j/1eycqzs7jgJSo3yH3gy62ZjEsXm2/F42fY34B6vnm8mvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746404868; c=relaxed/simple;
	bh=iXtfiUF6TGskvbSI450IdwLrdOEdRh08e4wZW+TE/jo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NLoW5uGufpUT5uDm9W5lcKkQ0dlNTDPnZOhovhaSLMGHGVNkozuOJ7HJ/evURPBwp7H0M0FmDg4UnJ8ulUN0E2q1kV2w1RM/8b09Cn3kwWK1+ligtEFn8KyXwx8tbrIKT0SBBvx4l3lg13KvKVswFntyRVpv+i6ZT1AZ98AH8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nl76ZD8G; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1053)
	id 788BA2115DAC; Sun,  4 May 2025 17:27:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 788BA2115DAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746404860;
	bh=Trakv1Qm204VGiCgxUuQr6D7v219Lf932RaHvY9osg8=;
	h=From:To:Cc:Subject:Date:From;
	b=nl76ZD8GhJhhTz1ByF8nLAnYBl1qCnOOsrm/WOZGF7ffSzImuImU+PSMpAvRr2DYU
	 3VwoYcP4/9tNkAGxJAQLrsjYSpIzQBHB3xqOBVIo15M8qphJ0THR6ksaCqvE932B7f
	 XtVneEOm5nmWZi5BBSt0G8iMQQ8Om75of0re7S50=
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
Subject: [v8 PATCH 0/2] Add L1 and L2 error detection for A53, A57 and A72
Date: Sun,  4 May 2025 17:27:38 -0700
Message-Id: <1746404860-27069-1-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Hello,

This is an attempt to revive [v5] series. I have attempted to address comments
and suggestions from Marc Zyngier since [v5]. Additionally, I have extended
support for A72 processors. Testing the driver on a problematic A72 SoC
has led to the detection of Correctable Errors (CEs). Below are logs captured
from the problematic SoC during various boot instances.

[  876.896022] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'

[ 3700.978086] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'

[  976.956158] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'

[ 1427.933606] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'

[  192.959911] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'

Our primary focus is on A72. We have a significant number of A72-based systems
in our fleet, and timely replacements via monitoring CEs will be instrumental
in managing them effectively.

I am eager to hear your suggestions and feedback on this series.

Thanks,
Vijay

[v5] https://lore.kernel.org/all/20210401110615.15326-1-s.hauer@pengutronix.de/#t
[v6] https://lore.kernel.org/all/1744241785-20256-1-git-send-email-vijayb@linux.microsoft.com/
[v7] https://lore.kernel.org/all/1744409319-24912-1-git-send-email-vijayb@linux.microsoft.com/#t

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

Changes since v4:
- Rebase on v5.12-rc5

Changes since v3:
- Add edac-enabled property to make EDAC 3support optional

Changes since v2:
- drop usage of virtual dt node (Robh)
- use read_sysreg_s instead of open coded variant (James Morse)
- separate error retrieving from error reporting
- use smp_call_function_single rather than smp_call_function_single_async
- make driver single instance and register all 'cpu' hierarchy up front once

Changes since v1:
- Split dt-binding into separate patch
- Sort local function variables in reverse-xmas tree order
- drop unnecessary comparison and make variable bool

Sascha Hauer (2):
  drivers/edac: Add L1 and L2 error detection for A53, A57 and A72
  dt-bindings: arm: cpus: Add edac-enabled property

 .../devicetree/bindings/arm/cpus.yaml         |   6 +
 drivers/edac/Kconfig                          |   9 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/cortex_arm64_l1_l2.c             | 229 ++++++++++++++++++
 4 files changed, 245 insertions(+)
 create mode 100644 drivers/edac/cortex_arm64_l1_l2.c


base-commit: 59c9ab3e8cc7f56cd65608f6e938b5ae96eb9cd2
-- 
2.49.0


