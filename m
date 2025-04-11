Return-Path: <linux-edac+bounces-3523-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A2EA868B4
	for <lists+linux-edac@lfdr.de>; Sat, 12 Apr 2025 00:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F32174694
	for <lists+linux-edac@lfdr.de>; Fri, 11 Apr 2025 22:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D406229DB62;
	Fri, 11 Apr 2025 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tHVKOYoS"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1268C290BC0;
	Fri, 11 Apr 2025 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744409321; cv=none; b=brpAHhHEB720lEt4UtghYVE2uG+gtYkkd4BCMAjYgDcaag3+GU6O972gtL5DpmeJXnXJqBhjg0hflJLhiz7nXlOA/i/hRGakA6D0YAiR0g2pse/nzfESzNe9VOY2xYx6MpcxxeTZqNBfGDe739DoLo1lI4+lEc8GsVEIpKf3zxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744409321; c=relaxed/simple;
	bh=31xar6e/IMxi5dIGGBqk0EkwQW+N0Ku1fqXbRY2PWIA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=IU3B3q+7wAdfIRb8jQrgZhV0htpQ6dqVFQ4n63xYvSNiOh72pXUfculQ+2omojjJ/Fn2QFj/I/rQ9eIjr5lZeteefknsaw1g8Pc0jfUdYt6pGPcz0/73+//uujI73zEeGDjnUtHm2UpJpg+uJM1N3DLsQLN6cDUAxWS3b9P9CqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tHVKOYoS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1053)
	id 88BD821165AA; Fri, 11 Apr 2025 15:08:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88BD821165AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744409319;
	bh=NScl/Ivan4EQzfeSemtbsghq5c09TU6KnZY4GQMHH28=;
	h=From:To:Cc:Subject:Date:From;
	b=tHVKOYoSB+aUWGMnGU/JNxLrcyX0yto2Z5Yx9SxVOy/aKzVjHK0Fr3QEdqOHFaVS0
	 jQ0qkruvuGI5IUKMSFEc+cCxBTypHRHJDdOV1MqXomspzYg1IfPYla0pnUf7ES+l8f
	 mdBbWO6+GdB7chT0u+w7cJupoa9jkf9ygLWV/Hzs=
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
Subject: [v7 PATCH 0/2] Add L1 and L2 error detection for A53, A57 and A72
Date: Fri, 11 Apr 2025 15:08:37 -0700
Message-Id: <1744409319-24912-1-git-send-email-vijayb@linux.microsoft.com>
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
[v6] https://lore.kernel.org/all/1744241785-20256-1-git-send-email-vijayb@linux.microsoft.com/

Changes since v6:
- restore the change made in [v5] to clear CPU/L2 syndrome registers
  back to read_errors() (Tyler)
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
 drivers/edac/cortex_arm64_l1_l2.c             | 232 ++++++++++++++++++
 4 files changed, 248 insertions(+)
 create mode 100644 drivers/edac/cortex_arm64_l1_l2.c


base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.49.0


