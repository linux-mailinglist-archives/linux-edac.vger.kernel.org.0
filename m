Return-Path: <linux-edac+bounces-3503-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46A8A834A3
	for <lists+linux-edac@lfdr.de>; Thu, 10 Apr 2025 01:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9042E1892CC9
	for <lists+linux-edac@lfdr.de>; Wed,  9 Apr 2025 23:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7631221CFFA;
	Wed,  9 Apr 2025 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MJZE5ooI"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAFF21ABA0;
	Wed,  9 Apr 2025 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744241788; cv=none; b=YH3hG9sjeSYAImwpt9Dw7RZA9V5cn5Mxh6txeGi61AKQKzFOy5LEJxat9hLgeCFo6L8QqftleyWbu7TVN9ltpat1XIOnji+M5JuqMYQAERgysTo99VUDRwCPDJCGtvyG2w6QDFUqqowKYcaa7lqj2C2GV0wSv8auptQ1YzCpYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744241788; c=relaxed/simple;
	bh=DJmHlqzs/Fyyz8PiXZ8HkfkLc23qE7KVNRcY0jeHeGc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZuwPPcGAS2OqAGQNsyRQguXOMHvTHhUcwiGpbtOw+Q29lKOfwZeTauum5pkQIsqzAF0tYUPcnqtK4+ppdjj3zKVMlDk8X5l+Ckraq2Mhm0YBDcqoiWevFUF49kO6o9WxCYtj2h1oxpM64W+aRR+qIETz1DEeZwAmJxvembdPqcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MJZE5ooI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1053)
	id F36922052507; Wed,  9 Apr 2025 16:36:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F36922052507
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744241786;
	bh=eva2XFRXoEsdS8FmNdZDDjKAvFmBX+pAN572/Qk4uxg=;
	h=From:To:Cc:Subject:Date:From;
	b=MJZE5ooIe55pyse7SOeRFq4ZdTPTJ/TWLyLSWXkwp8rhcl5hqRQaTobq0+KqgNH1L
	 oc7dfchhPSTD0uDuxcZTM52iL9sM+mG8xq0cPOD9cgEe3tU1ryH3KK3nW7nRljrk7b
	 qv6OuQQdky3xOhJG5RvvvReRy4T0po/SCb3o+Fz4=
From: Vijay Balakrishna <vijayb@linux.microsoft.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tyler Hicks <code@tyhicks.com>,
	Marc Zyngier <maz@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v6 0/2] Add L1 and L2 error detection for A53, A57 and A72
Date: Wed,  9 Apr 2025 16:36:23 -0700
Message-Id: <1744241785-20256-1-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Hello,

This is an attempt to revive [v5] series. I have attempted to address comments
and suggestions from Marc Zyngier since [v5]. Additionally, I have extended
support for A72 processors. Testing on a problematic A72 SoC has led to the
detection of Correctable Errors (CEs). I am eager to hear your suggestions and
feedback on this series.

Thanks,
Vijay

[v5] https://lore.kernel.org/all/20210401110615.15326-1-s.hauer@pengutronix.de/#t

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
 drivers/edac/cortex_arm64_l1_l2.c             | 225 ++++++++++++++++++
 4 files changed, 241 insertions(+)
 create mode 100644 drivers/edac/cortex_arm64_l1_l2.c


base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.49.0


