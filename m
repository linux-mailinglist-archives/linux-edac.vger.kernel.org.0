Return-Path: <linux-edac+bounces-1516-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884E193122A
	for <lists+linux-edac@lfdr.de>; Mon, 15 Jul 2024 12:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD02283D6B
	for <lists+linux-edac@lfdr.de>; Mon, 15 Jul 2024 10:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AE018735C;
	Mon, 15 Jul 2024 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DXN7941F"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41819187358;
	Mon, 15 Jul 2024 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038922; cv=none; b=pfIY8sSWPa8PgknQJ89JwiDTJ/YWV6QjMab6505g5jUR8zA+9okd84FpQ8y0yo8tKNWTZETIIXtnh1kFrIOL6WXNTDf+offazd4rD9Y6MaH8WBOKolmC8bZi+nON0GY9GKWoC7c7s1yM7avg/jCuyBIBxa9tt5mkszcTjGjzjAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038922; c=relaxed/simple;
	bh=burazMDZpi6NKYAgTXiPXsvahmz8bfe7vpPA0eHJ5k8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ieXv2Q3TaG1ISnNgR/FWWLjJ1Pk76AYrSqYB452P2Mmj7AozLVIBrjr2s6G+Oauk532xpefDK40/Z5Uf2ZU71iJaXR2PGB8LQiyRaqZIs0L7qHtNA2sAGFghbmXipUBviXd7ia29VxnstOtSTeBd/74A+hGlvTdnPg9Z8965F6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DXN7941F; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EED9E40E021B;
	Mon, 15 Jul 2024 10:21:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 60r5F6tyxjpH; Mon, 15 Jul 2024 10:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721038905; bh=fD61eYPQ6WA4OFAfZ7JgMOmG8QVQWZ3mqWe4mDajDxc=;
	h=Date:From:To:Cc:Subject:From;
	b=DXN7941FwDIO1oJF+EeWErcwEp9pDCx8AqpaF1eneFnLpSkSe6reUN4UjlU9eraID
	 u8V1p8rIhRYUHPwI7CIWUWAVsQR5nA2AV9x6O3bkY5hyF83ylg14I+7R/dp/eOGeCp
	 F3FCsE0whHBVpxqOCXa/7A4FS9oZ2Pve+hwyOaAuxuTOeUWC2dxw0TWZEalMO3q37m
	 /Mof+VB88vi0VjmwADnzkGaUePZZUxO0MQJ2wJGfzyk/KBdVVtcVWbnmvKNOQPmvL5
	 /fVkri16J7eA/iRF4eh8DbFFW77zQAlqkWXCahpEq1VoTxPd6iQce5SVTpETiKzYa8
	 Fg1Q3nc1nZgaJ2a68bTPDBz/hvC0gsd4tvNwGjN6E/EmLy4SyyPfLZzcBLxa/i0n+r
	 JxEHdyDaVjmEidortZMAgRZ9pDVgWEgPCLwYjLKDb6MYWr6h2k10Xd7icaU04si7a2
	 9TjgiCqoq+gwrN3MvdRRgS/T3ywIOYhOYYnSeqYEOg8Ch7g1Eomtm/2o5Hr8J7IEmb
	 hKl3P3IAZ2NuRbaLabEBJJdQfMvmIQmUeynVryidTC2Jgi6egBPU3DEXKToLKa8Hp3
	 Tjzr5awPG6tAMdV7Puu6SprKvcgMUDMZ/0VMzSiZL9vCqaOryUGf1m6VPcxSUE7DXm
	 /FD/4bTsdhUGMfgi+GpmHm6M=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BDA9F40E019C;
	Mon, 15 Jul 2024 10:21:42 +0000 (UTC)
Date: Mon, 15 Jul 2024 12:21:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v6.11
Message-ID: <20240715102134.GAZpT4LmsnVCrZsmt5@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the EDAC updates for v6.11.

Thx.

---

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.11

for you to fetch changes up to 03a9b67087ba071f69b12d730b36aa7c2d3dbf21:

  Merge remote-tracking branches 'ras/edac-amd-atl' and 'ras/edac-misc' into edac-updates (2024-07-15 11:59:10 +0200)

----------------------------------------------------------------
- The AMD memory controllers data fabric version 4.5 supports
  non-power-of-2 denormalization in the sense that certain bits of the
  system physical address cannot be reconstructed from the normalized
  address reported by the RAS hardware. Add support for handling such
  addresses

- Switch the EDAC drivers to the new Intel CPU model defines

- The usual fixes and cleanups all over the place

----------------------------------------------------------------
Arnd Bergmann (1):
      EDAC, i10nm: make skx_common.o a separate module

Borislav Petkov (AMD) (1):
      Merge remote-tracking branches 'ras/edac-amd-atl' and 'ras/edac-misc' into edac-updates

Dr. David Alan Gilbert (1):
      EDAC/thunderx: Remove unused struct error_syndrome

Jai Arora (1):
      EDAC/dmc520: Use devm_platform_ioremap_resource()

Jeff Johnson (2):
      RAS/AMD/ATL: Add a missing module description
      EDAC: Add missing MODULE_DESCRIPTION() macros

John Allen (6):
      RAS/AMD/ATL: Add amd_atl pr_fmt() prefix
      RAS/AMD/ATL: Read DRAM hole base early
      RAS/AMD/ATL: Expand helpers for adding and removing base and hole
      RAS/AMD/ATL: Validate address map when information is gathered
      RAS/AMD/ATL: Implement DF 4.5 NP2 denormalization
      RAS/AMD/FMPM: Use atl internal.h for INVALID_SPA

Qiuxu Zhuo (1):
      EDAC/igen6: Add Intel Arrow Lake-U/H SoCs support

Tony Luck (4):
      EDAC/i10nm: Switch to new Intel CPU model defines
      EDAC, pnd2: Switch to new Intel CPU model defines
      EDAC/sb_edac: Switch to new Intel CPU model defines
      EDAC/skx: Switch to new Intel CPU model defines

Vasyl Gomonovych (2):
      RAS/AMD/ATL: Add missing newline to pr_info() statement
      EDAC/ghes: Add missing newline to pr_info() statement

 drivers/edac/Makefile             |  10 +-
 drivers/edac/dmc520_edac.c        |   4 +-
 drivers/edac/ghes_edac.c          |   2 +-
 drivers/edac/i10nm_base.c         |  20 +-
 drivers/edac/igen6_edac.c         |   8 +
 drivers/edac/layerscape_edac.c    |   1 +
 drivers/edac/mpc85xx_edac.c       |   1 +
 drivers/edac/octeon_edac-l2c.c    |   1 +
 drivers/edac/octeon_edac-lmc.c    |   1 +
 drivers/edac/octeon_edac-pc.c     |   1 +
 drivers/edac/octeon_edac-pci.c    |   1 +
 drivers/edac/pnd2_edac.c          |   4 +-
 drivers/edac/sb_edac.c            |  14 +-
 drivers/edac/skx_base.c           |   2 +-
 drivers/edac/skx_common.c         |  21 +-
 drivers/edac/skx_common.h         |   4 +-
 drivers/edac/thunderx_edac.c      |   6 -
 drivers/ras/amd/atl/core.c        |  52 ++--
 drivers/ras/amd/atl/dehash.c      |  43 ---
 drivers/ras/amd/atl/denormalize.c | 561 ++++++++++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/internal.h    |  48 ++++
 drivers/ras/amd/atl/map.c         |  97 +++++++
 drivers/ras/amd/atl/system.c      |  21 +-
 drivers/ras/amd/fmpm.c            |   4 +-
 24 files changed, 819 insertions(+), 108 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

