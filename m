Return-Path: <linux-edac+bounces-1429-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BE591BAFF
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 11:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880BB1F211A4
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 09:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E113014EC51;
	Fri, 28 Jun 2024 09:06:19 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430A9156653
	for <linux-edac@vger.kernel.org>; Fri, 28 Jun 2024 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565579; cv=none; b=aGh6ygHkR7YmsySN0SiHLVWFPx7eA6qdZZQqxTIx1K7bR7GtwVjVK+q33AktIeSjYGetVxuRUwRNgOD8HF9zC2jq0XsH32ThuYKKveRSkcOVhNRJ2RfbaTCq41WolvSswQsOBw9eqfi6w50AJw5TZ8JPDn7BBtPanKnK8oI1A4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565579; c=relaxed/simple;
	bh=zI9fi6jOvK0GbqOYMuEJYOw5tCYid2fvT73TZT50k/U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RaxQljWGfIES8UWSaROKvZ1/zc+FnPU72+nJBxbIKjB2FT3c4drM8B1tdAJzBXUvA6ifrstKBMYDbq+BUZ+6ELt0W9enRPT2mpbzwgjaYYrbsAqe+PpyF4PXEHKwk28wfhgJ4dbgwJ+2lg2S8hK9ukHRnb6R+GSQPyDCFWxDXqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W9Tyj2zc4z6K8wN;
	Fri, 28 Jun 2024 17:04:29 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 2130D1400CA;
	Fri, 28 Jun 2024 17:06:14 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.147.160) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 10:06:13 +0100
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
	<linux-edac@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <mchehab+huawei@kernel.org>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<shiju.jose@huawei.com>
Subject: [RFC PATCH 0/3 qemu] arm/acpi: ACPI based FW First error injection
Date: Fri, 28 Jun 2024 10:06:01 +0100
Message-ID: <20240628090605.529-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Series adds,
1. ACPI based FW First error injection and
2. Support for injecting ARM processor errors.

This qemu based error injection mechanism found very useful for testing and
upstream the RAS FW-first related changes in the kernel
as well as in the user space tools when hardware is not available. 

What is this?
- ACPI + UEFI specs define a means of notifying the OS of errors that
  firmware has handled (gathered up data etc, reset the relevant error tracking
  units etc) in a set of standard formats (UEFI spec appendix N).
- ARM virt already supports standard HEST ACPI table description of Synchronous
  External Abort (SEA) for memory errors. This series builds on this to
  add a GHESv2 / Generic Error Device / GPIO interrupt path for asynchronous
  error reporting.

- The OS normally negotiates for control of error registers via _OSC.
  Previously QEMU unconditionally granted control of these registers.
  This series includes a machine parameter to allow the 'FW' to not let the
  OS take control and tracks whether the OS has asked for control or not.
  Note this code relies on the standard handshake - it's not remotely
  correct if the OS does follow that flow - this can be hardened with some
  more AML magic.

Alternatives:
- In theory we could emulate a management controller running appropriate firmware
  and have that actually handle the errors. It's much easier to instead intercept
  them before the error reporting messages are sent and result logged in the root
  ports error registers. As far as the guest is concerned it doesn't matter if
  these registers are handled via the firmware or never got written in the first
  place (the guest isn't allowed to touch these registers anyway!)
  This is sort of same argument for why we build ACPI tables in general in QEMU
  rather than making that an EDK2 problem.

Why?
- The kernel supports both firmware first and native RAS.
  As only some vendors have adopted a FW first model and hardware
  availability is limited this code has proven challenging to test.

Why an RFC?
- Assuming adding this support to QEMU will be controversial.
- Probably figure out how to do this for x86 as apparently people
  also want to use that architecture.

Reference to the previous series.
https://patchew.org/QEMU/20240205141940.31111-1-Jonathan.Cameron@huawei.com/

Mauro Carvalho had added instructions in wiki about how to inject ARM
procssor errors:
https://github.com/mchehab/rasdaemon/wiki/error-injection

Series is avaiable here:
https://gitlab.com/shiju.jose/qemu/-/commits/arm-error-inject

Jonathan Cameron (3):
  arm/virt: Wire up GPIO error source for ACPI / GHES
  acpi/ghes: Support GPIO error source.
  acpi/ghes: Add a logic to handle block addresses and FW first ARM
    processor error injection

 configs/targets/aarch64-softmmu.mak |   1 +
 hw/acpi/ghes.c                      | 266 ++++++++++++++++++++++++++--
 hw/arm/Kconfig                      |   4 +
 hw/arm/arm_error_inject.c           |  35 ++++
 hw/arm/arm_error_inject_stubs.c     |  18 ++
 hw/arm/meson.build                  |   3 +
 hw/arm/virt-acpi-build.c            |  29 ++-
 hw/arm/virt.c                       |  12 +-
 include/hw/acpi/ghes.h              |   3 +
 include/hw/boards.h                 |   1 +
 qapi/arm-error-inject.json          |  49 +++++
 qapi/meson.build                    |   1 +
 qapi/qapi-schema.json               |   1 +
 13 files changed, 405 insertions(+), 18 deletions(-)
 create mode 100644 hw/arm/arm_error_inject.c
 create mode 100644 hw/arm/arm_error_inject_stubs.c
 create mode 100644 qapi/arm-error-inject.json

-- 
2.34.1


