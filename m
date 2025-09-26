Return-Path: <linux-edac+bounces-4937-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF23BA33C5
	for <lists+linux-edac@lfdr.de>; Fri, 26 Sep 2025 11:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0AE3835EA
	for <lists+linux-edac@lfdr.de>; Fri, 26 Sep 2025 09:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C2B29BDA7;
	Fri, 26 Sep 2025 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fy/iNemC"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B492BDC19;
	Fri, 26 Sep 2025 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880219; cv=none; b=d2NJVOM6Buyf/ZkZYjE9zjSL//fzEkNFV3TqriCYGKbuflxcaas+o+rQ4NM91Uk7I4Grv7hTQjgQQjOdYN84V5WSUWoKbMKviBhAHdPBQSzmehrU3N1b1YTmyl3dn4tIKd48k+Ib5vP0OEBDZ3jZ8WWBKPvxYsNg5NSCrWKP2DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880219; c=relaxed/simple;
	bh=RVunrFGg2fqla5CN9iPHL7VuTOw5Mx96SG1J7Z4a1xA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IxfzoCRTatQ3mCp1bEwuGFjLqhHUt/nEV/i8bl2Li2GUbM8sWf0IkpqiEtuBvFi9H2IYRN9kyUeMILoaXii7CRk6S8GL7j+eG00mSMlPKj6TKc+n0sLsOu8xysMqeXiRTMOlixwZrplZbuT6WpPerNPMH+QifgZ+s9IQ3Byh3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fy/iNemC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9318B40E016D;
	Fri, 26 Sep 2025 09:50:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tIUoaUkxrX-h; Fri, 26 Sep 2025 09:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758880201; bh=9spBoCuluCq7wXBdqA1NjSL0lEKzvM3IdvWoFbv1x+w=;
	h=Date:From:To:Cc:Subject:From;
	b=fy/iNemCRq0b6q/6ILKK00CTgpP2eiYperebJKLrgLAkI6OJG2F3wZw2vj4gg4Pmj
	 Hizt+HQB1/YEc9FaJQPkvwEEAqc1Ce4zr2/hErfxV1ggvxWEX7KDAXCnHlVzrED9gl
	 V7Cs+rH/xrXRv3SSu9lGXPO2elnZbh2DvFxOitPVMO7fBhBHTK8TNhnVvqo3E2Awxc
	 QgC7qjmnOZ9Q+yRGpbehNw5bis/sp7T30ja/wUi3jVFKykKtDvm0nlu9paMKOKYWKr
	 Pp/Ar51Wyz4fqG1H2huV2zoOjwF/w++HHiPVCZeglnif46iKzZyL4pHLlO3sgrbRDy
	 4W4c5ZzyXmP5dCyDqyeWutFoGV/sPqFwglhChWlwpwtnbX0g//5C3mhmj7eFGTy7Ff
	 XWnxqtLhjhGCDEqWy9bmzo2DNT68TOTOjhkNhWwCScDZSVAwRyqY6ek3X8Jv2ThnDl
	 JagNXe3HyD89+YXtkjpLFXPdAbAINm2Iz8BdlkML66jkQCyGhftHtMR6nLsa11GOnx
	 Zu/A5sCr6xSBBJBl/hGUmtDLf50PNLkEtSkBZDogsrhYynXoqsepQJWGXyduWG6zrV
	 miRztf8q4q36C9XCm2RHo2oGeDJSXv3omefBgatNSRtRUcTszOcMBAgTmyHUaO5i9D
	 WIQgpaZRhn+PYs9Vryc8zJ8w=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6BD2B40E00DD;
	Fri, 26 Sep 2025 09:49:58 +0000 (UTC)
Date: Fri, 26 Sep 2025 11:49:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v6.18
Message-ID: <20250926094948.GAaNZhvEm0mULL_iSp@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the EDAC lineup for v6.18.

Thx.

---

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.18

for you to fetch changes up to 69ed025aeb4c8faa3019e5997b850a554b47498c:

  Merge branches 'edac-drivers' and 'edac-misc' into edac-updates (2025-09-26 11:44:35 +0200)

----------------------------------------------------------------
- Add support for new AMD family 0x1a models to amd64_edac

- Add an EDAC driver for the AMD VersalNET memory controller which
  reports hw errors from different IP blocks in the fabric using an
  IPC-type transport

- Drop the silly static number of memory controllers in the Intel EDAC
  drivers (skx, i10nm) in favor of a flexible array so that former
  doesn't need to be increased with every new generation which adds more
  memory controllers; along with a proper refactoring

- Add support for two Alder Lake-S SOCs to ie31200_edac

- Add an EDAC driver for ADM Cortex A72 cores, and specifically for
  reporting L1 and L2 cache errors

- Last but not least, the usual fixes, cleanups and improvements all
  over the subsystem

----------------------------------------------------------------
Avadhut Naik (2):
      EDAC/amd64: Add support for AMD family 1Ah-based newer models
      EDAC/mc_sysfs: Increase legacy channel support to 16

Borislav Petkov (AMD) (2):
      MAINTAINERS: EDAC: Drop inactive reviewers
      Merge branches 'edac-drivers' and 'edac-misc' into edac-updates

Dan Carpenter (1):
      EDAC/versalnet: Return the correct error in mc_probe()

Jiri Slaby (SUSE) (1):
      EDAC/altera: Use dev_fwnode()

Kuan-Wei Chiu (1):
      EDAC: Fix wrong executable file modes for C source files

Kyle Manna (1):
      EDAC/ie31200: Add two more Intel Alder Lake-S SoCs for EDAC support

Qiuxu Zhuo (9):
      EDAC/i10nm: Skip DIMM enumeration on a disabled memory controller
      EDAC/{skx_common,skx}: Use configuration data, not global macros
      EDAC/skx_common: Move mc_mapping to be a field inside struct skx_imc
      EDAC/skx_common: Swap memory controller index mapping
      EDAC/skx_common: Make skx_dev->imc[] a flexible array
      EDAC/skx_common: Remove redundant upper bound check for res->imc
      EDAC/i10nm: Reallocate skx_dev list if preconfigured cnt != runtime cnt
      EDAC/skx_common: Remove unused *NUM*_IMC macros
      EDAC/skx_common: Use topology_physical_package_id() instead of open coding

Sascha Hauer (2):
      EDAC: Add EDAC driver for ARM Cortex A72 cores
      dt-bindings: arm: cpus: Add edac-enabled property

Shubhrajyoti Datta (5):
      cdx: Split mcdi.h and reorganize headers
      cdx: Export Symbols for MCDI RPC and Initialization
      RAS: Export log_non_standard_event() to drivers
      dt-bindings: memory-controllers: Add support for Versal NET EDAC
      EDAC: Add a driver for the AMD Versal NET DDR controller

 Documentation/devicetree/bindings/arm/cpus.yaml    |  17 +
 .../memory-controllers/xlnx,versal-net-ddrmc5.yaml |  41 +
 MAINTAINERS                                        |  17 +-
 drivers/cdx/controller/cdx_controller.c            |   2 +-
 drivers/cdx/controller/cdx_rpmsg.c                 |   2 +-
 drivers/cdx/controller/mcdi.c                      |  43 +-
 drivers/cdx/controller/mcdi_functions.c            |   1 -
 drivers/cdx/controller/mcdi_functions.h            |   3 +-
 drivers/cdx/controller/mcdid.h                     |  63 ++
 drivers/edac/Kconfig                               |  16 +
 drivers/edac/Makefile                              |   2 +
 drivers/edac/a72_edac.c                            | 225 +++++
 drivers/edac/altera_edac.c                         |   4 +-
 drivers/edac/amd64_edac.c                          |  20 +
 drivers/edac/amd64_edac.h                          |   2 +-
 drivers/edac/ecs.c                                 |   0
 drivers/edac/edac_mc_sysfs.c                       |  24 +
 drivers/edac/i10nm_base.c                          |  27 +-
 drivers/edac/ie31200_edac.c                        |   4 +
 drivers/edac/mem_repair.c                          |   0
 drivers/edac/scrub.c                               |   0
 drivers/edac/skx_base.c                            |  33 +-
 drivers/edac/skx_common.c                          |  54 +-
 drivers/edac/skx_common.h                          |  28 +-
 drivers/edac/versalnet_edac.c                      | 960 +++++++++++++++++++++
 drivers/ras/ras.c                                  |   1 +
 .../controller => include/linux/cdx}/bitfield.h    |   0
 include/linux/cdx/edac_cdx_pcol.h                  |  28 +
 .../cdx/controller => include/linux/cdx}/mcdi.h    |  47 +-
 29 files changed, 1553 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-net-ddrmc5.yaml
 create mode 100644 drivers/cdx/controller/mcdid.h
 create mode 100644 drivers/edac/a72_edac.c
 mode change 100755 => 100644 drivers/edac/ecs.c
 mode change 100755 => 100644 drivers/edac/mem_repair.c
 mode change 100755 => 100644 drivers/edac/scrub.c
 create mode 100644 drivers/edac/versalnet_edac.c
 rename {drivers/cdx/controller => include/linux/cdx}/bitfield.h (100%)
 create mode 100644 include/linux/cdx/edac_cdx_pcol.h
 rename {drivers/cdx/controller => include/linux/cdx}/mcdi.h (79%)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

