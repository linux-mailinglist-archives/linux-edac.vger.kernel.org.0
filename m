Return-Path: <linux-edac+bounces-3400-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF35AA703BC
	for <lists+linux-edac@lfdr.de>; Tue, 25 Mar 2025 15:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5241889899
	for <lists+linux-edac@lfdr.de>; Tue, 25 Mar 2025 14:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E0425B693;
	Tue, 25 Mar 2025 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="imwAy0Vv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0511B25A357;
	Tue, 25 Mar 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913009; cv=none; b=Y3U9ZFdBsBk4cA2kOT2Qi5HwC6juvRafuoM9CglMGO0nHMuAUeRkCFUzVHq8WqeBzc4FLfXo4cJXebZpQaeEcY5++6hWmtKzCK3kg9CU2kzZ7ViPiP1C7yZoe4Kfz9TYb6s3+X8p4RudZ1brG5p+3OeIUtPusOKg0HlzfnVMex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913009; c=relaxed/simple;
	bh=DGCPw7uqthNFfxZvHSwm7GOwjXM6Etp/joQOSVf8YSo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HjYhpYJC66JVt6hIM6DN+cidE+Eci/YE/nx/YFo5wbPCf0X4ycak7X5OtPtRDu48Pmwz6MlA68qApBOSSgxhFkfLPnYeUoFV3mkDthYCBCGFyWJA2726oT6dGhUdabAz0sMfAIWlJpjF/6od+TvFF+B5Dx1DYH1/ZBpHAFDo+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=imwAy0Vv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 91BE440E0219;
	Tue, 25 Mar 2025 14:30:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aXqoICNDnDVX; Tue, 25 Mar 2025 14:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742912999; bh=Er5cXo6uby70n3806YQnxGFQf13dha/YemMQxz/+lOk=;
	h=Date:From:To:Cc:Subject:From;
	b=imwAy0VvHttLJzyFH64ToN0OAAAyje1MVKE6+Lpw0BqK+h6vdk9lXsH2m6mjPNo2l
	 vM+7Jg/0M6eaaC8qPebvNRmEcpOxoiQwabbwpryk7Ax9ms9VvL/9mDfGyu+BTdcCfk
	 CdCqyq+jZysRdtudmtPbsxfRwNxEn2aoJaI5Df7Ae25HArNeudharFcmamDzWtTJr8
	 3gnJOLt8/jX4gJTfe4S3xDy15n/bu56rRGPa6/TFomExtkZaE2Yp3rMO57iEKzWdgq
	 tWlO9AN11Y/vMbJvZkju/jANtKEnUfLd5HubhnzYlci0CN7lrUIFJjx8OExbZ0Hb9U
	 +VeJabunVyDWHZQb4j9WH1IeGZPw3fOvc42JQ5c6tNkHFLLok9HY8bxjHVW02VnKuP
	 IhpgCLl/Lu0QkVUIEyJ8IzSDeVHUbbQ6HNzOCnBHLN63K1HG3uBMkaxPdRUYQdeE6g
	 4gUyE5rwjXn2whBQnMh8ZOfwbvT/A7EgT4PAtIB3cK1m5y5aKHiCRX4LEJ+u524Gxv
	 mb+nR+fB+W6uDsSKSAW0seCdwSvJ2GJUGxlj/r8CDDSiVKDOHcG67bGVV5Mns7EWPb
	 5IcVuBBqNubsG/by6ZPdo/j9r2TReHOdcFhQUhdPsNPyrJtIkK3eILxkfhKlNNyv6d
	 Xqktb0mrzEbrugJt7slUjQNA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CBD740E01D1;
	Tue, 25 Mar 2025 14:29:56 +0000 (UTC)
Date: Tue, 25 Mar 2025 15:29:48 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v6.15
Message-ID: <20250325142948.GAZ-K93G38luDj558S@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the EDAC lineup for v6.15.

Thx.

---

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_updates_for_v6.15

for you to fetch changes up to 298ffd537585ceb45034749d51d8a82c8f3f3c0c:

  Merge remote-tracking branches 'ras/edac-cxl', 'ras/edac-drivers' and 'ras/edac-misc' into edac-updates (2025-03-25 14:53:27 +0100)

----------------------------------------------------------------
- Add infrastructure support to EDAC in order to be able to register memory
  scrubbing RAS functionality with the kernel and expose sysfs nodes to
  control such scrubbing functionality. The main use case is CXL devices which
  provide different scrubbers for their built-in memories so that tools like
  rasdaemon can configure and control memory scrubbing and other, more
  advanced RAS functionality. (Shiju Jose and Jonathan Cameron)

- Add support to ie31200_edac for client SoCs like Raptor Lake-S which have
  multiple memory controllers and out-of-band ECC capability. (Qiuxu Zhuo)

- The usual round of cleanups, simplifications and fixlets

----------------------------------------------------------------
Arnd Bergmann (2):
      EDAC/ie31200: work around false positive build warning
      EDAC/device: Fix dev_set_name() format string

Borislav Petkov (AMD) (1):
      Merge remote-tracking branches 'ras/edac-cxl', 'ras/edac-drivers' and 'ras/edac-misc' into edac-updates

Christophe JAILLET (1):
      EDAC/igen6: Constify struct res_config

Colin Ian King (1):
      EDAC/pnd2: Make read-only const array intlv static

David Thompson (1):
      MAINTAINERS: Add a secondary maintainer for bluefield_edac

Qiuxu Zhuo (13):
      EDAC/igen6: Fix the flood of invalid error reports
      EDAC/{skx_common,i10nm}: Fix some missing error reports on Emerald Rapids
      EDAC/ie31200: Fix the size of EDAC_MC_LAYER_CHIP_SELECT layer
      EDAC/ie31200: Fix the DIMM size mask for several SoCs
      EDAC/ie31200: Fix the error path order of ie31200_init()
      EDAC/ie31200: Fix the 3rd parameter name of *populate_dimm_info()
      EDAC/ie31200: Simplify the pci_device_id table
      EDAC/ie31200: Make the memory controller resources configurable
      EDAC/ie31200: Make struct dimm_data contain decoded information
      EDAC/ie31200: Fold the two channel loops into one loop
      EDAC/ie31200: Break up ie31200_probe1()
      EDAC/ie31200: Add Intel Raptor Lake-S SoCs support
      EDAC/ie31200: Switch Raptor Lake-S to interrupt mode

Shiju Jose (5):
      EDAC: Add support for EDAC device features control
      EDAC: Add scrub control feature
      EDAC: Add a Error Check Scrub control feature
      EDAC: Add a memory repair control feature
      EDAC: Update memory repair control interface for memory sparing feature

Thorsten Blum (2):
      EDAC: Use string choice helper functions
      EDAC/amd64: Simplify return statement in dct_ecc_enabled()

 Documentation/ABI/testing/sysfs-edac-ecs           |  74 +++
 Documentation/ABI/testing/sysfs-edac-memory-repair | 206 +++++++
 Documentation/ABI/testing/sysfs-edac-scrub         |  69 +++
 Documentation/edac/features.rst                    | 103 ++++
 Documentation/edac/index.rst                       |  12 +
 Documentation/edac/memory_repair.rst               | 121 ++++
 Documentation/edac/scrub.rst                       | 266 +++++++++
 MAINTAINERS                                        |   1 +
 drivers/edac/Kconfig                               |  30 +-
 drivers/edac/Makefile                              |   3 +
 drivers/edac/amd64_edac.c                          |  52 +-
 drivers/edac/debugfs.c                             |   5 +-
 drivers/edac/ecs.c                                 | 205 +++++++
 drivers/edac/edac_device.c                         | 185 ++++++
 drivers/edac/i10nm_base.c                          |   2 +
 drivers/edac/i5400_edac.c                          |   3 +-
 drivers/edac/i7300_edac.c                          |   7 +-
 drivers/edac/ie31200_edac.c                        | 641 +++++++++++++--------
 drivers/edac/igen6_edac.c                          |  41 +-
 drivers/edac/mem_repair.c                          | 359 ++++++++++++
 drivers/edac/pnd2_edac.c                           |   4 +-
 drivers/edac/scrub.c                               | 209 +++++++
 drivers/edac/skx_common.c                          |  33 ++
 drivers/edac/skx_common.h                          |  11 +
 drivers/edac/xgene_edac.c                          |  17 +-
 include/linux/edac.h                               | 215 +++++++
 26 files changed, 2560 insertions(+), 314 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-edac-ecs
 create mode 100644 Documentation/ABI/testing/sysfs-edac-memory-repair
 create mode 100644 Documentation/ABI/testing/sysfs-edac-scrub
 create mode 100644 Documentation/edac/features.rst
 create mode 100644 Documentation/edac/index.rst
 create mode 100644 Documentation/edac/memory_repair.rst
 create mode 100644 Documentation/edac/scrub.rst
 create mode 100755 drivers/edac/ecs.c
 create mode 100755 drivers/edac/mem_repair.c
 create mode 100755 drivers/edac/scrub.c

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

