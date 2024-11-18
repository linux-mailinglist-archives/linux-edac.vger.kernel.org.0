Return-Path: <linux-edac+bounces-2558-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC229D0FEB
	for <lists+linux-edac@lfdr.de>; Mon, 18 Nov 2024 12:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7981F22D7F
	for <lists+linux-edac@lfdr.de>; Mon, 18 Nov 2024 11:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBEF1946DA;
	Mon, 18 Nov 2024 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OzVNxIiz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CD0188A0D;
	Mon, 18 Nov 2024 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930239; cv=none; b=mVb/u2NOLS9QYZjGFbm7dIMVGDm2ttaZVnndYNHjTrf8/mWjAkhwK+kqY9/KmBWFDULz7p4lVzcPIlrlg4V786wasAyz4/XsNX0NWM9BQ+Q25AiUlQwzJ3O6rPcsHw+e1OdsT8BATEcdfOaIMBxco2vF5yXfm/MhwtHAoBw4LHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930239; c=relaxed/simple;
	bh=TwKBlDPWto5qUMoY6Ex07TeBDc1LB+82jYTKWT+EUOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kZmoo+6QnjdhJ3rOa7DK8OUgNekkuSYayQpK0Z2By2Pmuv7nJAJxhHAds3Fou2+6xZlovyzJseFuDo8JmhI0kRTvF57yFVfXR1269OBsFBTr44cmPd4BAYC5KOwF75jKjzD9q0qB3i3M4RxgmP2wDWS4u51p0/pkyzE5x7A67Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OzVNxIiz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0D1B440E015F;
	Mon, 18 Nov 2024 11:43:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2DULiPkMLEzc; Mon, 18 Nov 2024 11:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731930227; bh=5utdCM8Zl8kLwYkNyCmXrpE9uKkf1ZAvCdSEtJSzNKQ=;
	h=Date:From:To:Cc:Subject:From;
	b=OzVNxIizEInNjKjgUXLR/6LKDh8awijG+7prSh37p/dCD9eimAbJUbmIac0X7qq2N
	 8Y2KXFf/nrvGUgPxTDk71kwCjlufBmwSURVlCv8q+jLnUpdcOAFMKcF4vVTDkv6t2v
	 thlcJLkUo3uKKtvt/W0NE/aMMn9gFrysbIBG0C/IEv5BXKIJkU8URtEialRMdLzh6S
	 0vKZSJoAT00jfW9AXJiL1jwT/8W24EmXd941BgUvl8XHcB2YheIujeeiwMP8KukrOE
	 5aUibfTWcMepheiv33H7SobFhzLiFUUsrnx9Pkh2JoVJlI5W4+X/HfMPEQ2kNHTS1r
	 Q6UwyNFzlGFeqIIrlFvG4qf0ZCd62PfBiDsksNtJp6msyBR9Me77XpGHwJOs6C9jM0
	 tZAD6OQEN3f7hjXL6/ySvkQpAtMIOudIUnZxvQdM+wkKGvGqR5IUGa54hfIlfjfJe3
	 5xGyzaZzJgYAKyQjCB8eKxW+8ga6Ow07SBAxopLEifmFmEt5+RyhgBtLHXARFNX6wU
	 3X8wVFiibfGsvADWkrFPs1peKvgkQ9+ERSljRbCUQw1VfersfjJdvF+/2dgaGRjMiD
	 4AiG38CbsZWaMVDEPYxConzvEX+pE4DqFv/U7ZRnUS5p+pQMo+D/0La/3tRd9Huzmx
	 yKo+iosQGdm+u/K24XFUDqyU=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 94ADC40E019C;
	Mon, 18 Nov 2024 11:43:44 +0000 (UTC)
Date: Mon, 18 Nov 2024 12:43:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v6.13
Message-ID: <20241118114343.GAZzsob_d_C5sYNHUn@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the EDAC pile for v6.13.

Thx.

---

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.13

for you to fetch changes up to 1b38da0115598e30cc7cdd84761fc427c18b281f:

  Merge branch 'edac-misc' into edac-updates (2024-11-18 11:33:23 +0100)

----------------------------------------------------------------
- Add support for Bluefield-2 SOCs to bluefield_edac

- Add support for Intel Panther Lake-H to igen6_edac

- Add polling support to igen6_edac as some Intel M100 chips have trouble with
  error interrupts

- Add Kaby Lake-S support to ie31200_edac

- Fix memory source detection in the SKX common module which is used by
  a couple of Intel EDAC drivers

- Add support for the NXP i.MX9 memory controller to fsl_edac

- The usual fixes and cleanups all over the place

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      Merge branch 'edac-misc' into edac-updates

David Thompson (2):
      EDAC/bluefield: Fix potential integer overflow
      EDAC/bluefield: Use Arm SMC for EMI access on BlueField-2

Frank Li (3):
      EDAC/fsl_ddr: Pass down fsl_mc_pdata in ddr_in32() and ddr_out32()
      EDAC/fsl_ddr: Move global variables into struct fsl_mc_pdata
      dt-bindings: memory: fsl: Add compatible string nxp,imx9-memory-controller

James Ye (1):
      EDAC/ie31200: Add Kaby Lake-S dual-core host bridge ID

Krzysztof Kozlowski (1):
      MAINTAINERS: Change FSL DDR EDAC maintainership

Lili Li (1):
      EDAC/igen6: Add Intel Panther Lake-H SoCs support

Orange Kao (2):
      EDAC/igen6: Avoid segmentation fault on module unload
      EDAC/igen6: Add polling support

Priyanka Singh (1):
      EDAC/fsl_ddr: Fix bad bit shift operations

Qiuxu Zhuo (3):
      EDAC/skx_common: Differentiate memory error sources
      EDAC/{skx_common,i10nm}: Fix incorrect far-memory error source indicator
      EDAC/igen6: Initialize edac_op_state according to the configuration data

Yazen Ghannam (1):
      RAS/AMD/ATL: Add debug prints for DF register reads

Ye Li (1):
      EDAC/fsl_ddr: Add support for i.MX9 DDR controller

 CREDITS                                            |   4 +
 .../bindings/memory-controllers/fsl/fsl,ddr.yaml   |  31 +++-
 MAINTAINERS                                        |   3 +-
 drivers/edac/bluefield_edac.c                      | 170 ++++++++++++++++++---
 drivers/edac/fsl_ddr_edac.c                        | 141 +++++++++++------
 drivers/edac/fsl_ddr_edac.h                        |  13 ++
 drivers/edac/i10nm_base.c                          |   1 +
 drivers/edac/ie31200_edac.c                        |   8 +-
 drivers/edac/igen6_edac.c                          |  49 +++++-
 drivers/edac/layerscape_edac.c                     |   1 +
 drivers/edac/skx_common.c                          |  57 ++++---
 drivers/edac/skx_common.h                          |   8 +
 drivers/ras/amd/atl/access.c                       |   8 +-
 13 files changed, 398 insertions(+), 96 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

