Return-Path: <linux-edac+bounces-5543-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10176C97347
	for <lists+linux-edac@lfdr.de>; Mon, 01 Dec 2025 13:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898463A2C6E
	for <lists+linux-edac@lfdr.de>; Mon,  1 Dec 2025 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588F0309EFE;
	Mon,  1 Dec 2025 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QhE/UqZc"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405AC2DA76C;
	Mon,  1 Dec 2025 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591553; cv=none; b=FSE0AdNe4Z8YQ+tuW6ZKfgAUZjANGRgaoVOA2w1PjBO+fs58E40fsN58DUkUzjyO8r8/mTqYR/i625h/HVnKvM5gFoPbeZIREH0QRjPefIHYE4TsvAAu/QxWTFCIdXMYme8pcbpiirRAuVQ9G3tySEEYnLPxGnvsQlN0b2IXM0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591553; c=relaxed/simple;
	bh=z3gQ8aiicz/6lAaekX87/P9T8+YLOStYfh1pfyxMk3c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K0CU5VoC9UPjgduD/arwQlZYV7/kFo490fCH0UJwFZjb4N9x+Gzvh17ejN9nPncJpa+3gu96RRcNximYECeSGFUdUqj8XPtUfVW46Aavj1mhu7k0h26w21g3ByR+OdKZ6XPJ7MQUwv7/umxCJJDPflwe3kskzwugehjFwHsEBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QhE/UqZc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5C13840E0218;
	Mon,  1 Dec 2025 12:19:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UR32rjSPhMI1; Mon,  1 Dec 2025 12:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764591542; bh=dx8I8K/bFXi1naCcOjmn//lcrn5EWYEy0bPyzBqresI=;
	h=Date:From:To:Cc:Subject:From;
	b=QhE/UqZcw8Vl4ETdfHaGVmV6vzLXu686rqoVDrh0cHhGKkLAy5NWSMYOaYt69nnTg
	 EsilPstzAYofZYMYQQHD8WgAWVels5rhQOWr4iJ26fficnsG5iXFacc/g7F2gxFKDd
	 vscKCGtOixdM7k4/rcNtyddooJ0XKQjz+IYOlD0LdQltouUkVGYemqjYFhE/zpEVEA
	 LfKe2WPuhxo14L9UyaQuJa6XImZmsP/+pjgpGVYNEcqxMSAkcE3Q30hhphfpSLTphp
	 i+KC3AK2sLzlmiKvax71Cc1xOxe9i8cgbV8M5EWpTgkYq5UxEOqeiWYMc/zKEgH8b+
	 TbIwOWloRpQKvblMVt7dCyqULz8TLL54oyC7aKQKWC3AT6mcF6RAn4nHw6L1CaWiDX
	 L00tasBocLxpk7N64iQ4A4E00H6N++s6t9ggoGYTSLOFY1U1gsiK0cPi/ipzB+QIAF
	 /hvjROmiP1OrVn0blY5A6MSW3Tx6xkXod/AkpNrwygg3hpsfV8QQB8VIxnGsBQPFx8
	 xu/aICIEsTRkbDI+k37NJQ19AMS4nu97nUD6x+S7wBLylFPF9vA0PSg8Q5PDFF7plS
	 Uv0H50Mc8U6zAooobvR0mGVPR+YRFPNCVKPLOidt+0iDKTnbYJWvSYqDpULojAXxMD
	 li50fc4IPrBU/ZpwmyegsKcw=
Received: from zn.tnic (pd953063a.dip0.t-ipconnect.de [217.83.6.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7532F40E022E;
	Mon,  1 Dec 2025 12:18:59 +0000 (UTC)
Date: Mon, 1 Dec 2025 13:18:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v6.19-rc1
Message-ID: <20251201121852.GAaS2HrICVFEQyuAIh@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the EDAC lineup for v6.19-rc1.

Thx.

---

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.19_rc1

for you to fetch changes up to e2349c5811ae642f6d948d1ee4bfc4a93566c178:

  Merge remote-tracking branches 'ras/edac-amd-atl', 'ras/edac-drivers' and 'ras/edac-misc' into edac-updates (2025-12-01 12:06:08 +0100)

----------------------------------------------------------------
- imh_edac: Add a new EDAC driver for Intel Diamond Rapids and
  future incarnations of this memory controllers architecture

- amd64_edac: Remove the legacy csrow sysfs interface which has been
  deprecated and unused (we assume) for at least a decade

- Add the capability to fallback to BIOS-provided address translation
  functionality (ACPI PRM) which can be used on systems unsupported by
  the current AMD address translation library

- The usual fixes, fixlets, cleanups and improvements all over the place

----------------------------------------------------------------
Avadhut Naik (3):
      EDAC/amd64: Generate ctl_name string at runtime
      EDAC/amd64: Remove NUM_CONTROLLERS macro
      EDAC: Remove the legacy EDAC sysfs interface

Borislav Petkov (AMD) (1):
      Merge remote-tracking branches 'ras/edac-amd-atl', 'ras/edac-drivers' and 'ras/edac-misc' into edac-updates

Ma Ke (2):
      EDAC/ie31200: Fix error handling in ie31200_register_mci
      EDAC/igen6: Fix error handling in igen6_edac driver

Marco Crivellari (1):
      RAS/CEC: Replace use of system_wq with system_percpu_wq

Nikolay Borisov (1):
      RAS/AMD/ATL: Replace bitwise_xor_bits() with hweight16()

Qiuxu Zhuo (7):
      EDAC/{skx_common,skx,i10nm}: Make skx_register_mci() independent of pci_dev
      EDAC/skx_common: Prepare for skx_get_edac_list()
      EDAC/skx_common: Prepare for skx_set_hi_lo()
      EDAC/{skx_common,imh}: Add EDAC driver for Intel Diamond Rapids servers
      EDAC/skx_common: Extend the maximum number of DRAM chip row bits
      EDAC/{skx_comm,imh}: Detect 2-level memory configuration
      EDAC/imh: Setup 'imh_test' debugfs testing node

Thorsten Blum (1):
      EDAC/ghes: Replace deprecated strcpy() in ghes_edac_report_mem_error()

Yazen Ghannam (3):
      RAS/AMD/ATL: Return error codes from helper functions
      ACPI: PRM: Add acpi_prm_handler_available()
      RAS/AMD/ATL: Require PRM support for future systems

 Documentation/admin-guide/RAS/main.rst     | 142 +------
 arch/loongarch/configs/loongson3_defconfig |   1 -
 drivers/acpi/prmt.c                        |   6 +
 drivers/edac/Kconfig                       |  20 +-
 drivers/edac/Makefile                      |   3 +
 drivers/edac/amd64_edac.c                  |  61 +--
 drivers/edac/amd64_edac.h                  |   7 +-
 drivers/edac/edac_mc_sysfs.c               | 404 -------------------
 drivers/edac/ghes_edac.c                   |   7 +-
 drivers/edac/i10nm_base.c                  |   3 +-
 drivers/edac/ie31200_edac.c                |   2 +
 drivers/edac/igen6_edac.c                  |   2 +
 drivers/edac/imh_base.c                    | 602 +++++++++++++++++++++++++++++
 drivers/edac/skx_base.c                    |   4 +-
 drivers/edac/skx_common.c                  |  33 +-
 drivers/edac/skx_common.h                  |  98 +++--
 drivers/ras/amd/atl/core.c                 |   7 +-
 drivers/ras/amd/atl/internal.h             |   6 +-
 drivers/ras/amd/atl/prm.c                  |   4 -
 drivers/ras/amd/atl/system.c               |  30 +-
 drivers/ras/amd/atl/umc.c                  |  23 +-
 drivers/ras/cec.c                          |   2 +-
 include/linux/prmt.h                       |   2 +
 23 files changed, 796 insertions(+), 673 deletions(-)
 create mode 100644 drivers/edac/imh_base.c


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

