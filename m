Return-Path: <linux-edac+bounces-1828-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AACB9712DC
	for <lists+linux-edac@lfdr.de>; Mon,  9 Sep 2024 11:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F00B225A6
	for <lists+linux-edac@lfdr.de>; Mon,  9 Sep 2024 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26AB1B29BF;
	Mon,  9 Sep 2024 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jnClp46A"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEDC13635E;
	Mon,  9 Sep 2024 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872600; cv=none; b=edAvI2v5NhNJv9H/+gFf4ABx0lz+gvcET4zs0BV0D0X7eiaq4u6mtVuA+auDN6igyH5zN4KvnMomAykiWEAnK1iavgZfO7H3PkczIIBaQvF0Nq8+h0n/xPsCCzvChOeQJ+S5QuHjrBNNtLZ2UdD6iYGrVckcRA51mM4FJr+96hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872600; c=relaxed/simple;
	bh=8WYAzJl0zYRh1E8R9UP4JEzv76LjRdU1nrYAQz8NicI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N9tOX2HnVnO+Wb6ZEbUX5ttZCvT/9LBQcklUU4xGTXZdUHAmxN47fTzmnQ6d0J0eVdJbQKfL/XXiLO3FwUIosUMXpD7Hak4RhILjdX26M/h5CE282YEjWObCieqrDRNFviK9ebJttQXGHWiDApNt26gnhxQQlWfaz5PIAXp30iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jnClp46A; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E86F640E0185;
	Mon,  9 Sep 2024 09:03:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7bh40M_SYptb; Mon,  9 Sep 2024 09:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725872592; bh=eDk+ruS6hx45oNskKYQXXNbRrKJegFNg5kxe7NFyCmo=;
	h=Date:From:To:Cc:Subject:From;
	b=jnClp46A02FcRBBeAjcUm3XiUnmWSSMkxZiuhm1AWKoYiwnsmyCx2qBPjy7MxvfVL
	 rrF9dK6AHJQsekaO17YXDGDAY1LypLKnm+W5Uhcvjh0Xq001YJytM0A4y5U0IvGHvP
	 uT4Xx03z+mAPFKkmpkmMnHtsojFaCqbU5YK2qNdUYO4prAsVny/MaycyFUfNP6mvQE
	 16kKx4n+8xt46QmhrvYh24ozfITaRkuljmlzFVVBf8kV/izFBiYYiIPOStaLiGhOlR
	 VJ6iLmaT0LLpv2/rFJ2XkhGnUu5IFwdLsTeQc/OzgN0NMrgIhCMSH8QYgjY9PJYGVw
	 1NXvRAZ+L/uhz69RQESM5EZP/RX7900Dal+bJwoTKd/t6RE6piHWkWiQK/jKmqhAn0
	 Gi7dNmHIh7vUYOYRtoKWyp4BCXMYHqfHFnBVBbpb97zdYnot8WTX+2nPOcTsCctSGU
	 ZbAOkfwcmdejRbx440UUsRGBj5HjUHpEp0hsqoze9uOgHzs8Bys/Dg+L6DSvnG8XLC
	 j+ODxZ0thsL2IIFKbtsmGoAJP1HsoKV/i4DeyZ2mjdYzBZCSMmV8ubU07sFP5HrTba
	 4HxRQFi/VcQne2rbnMjSEU4jO1yrkQcbJpWsXzuorKaD1qnnbd5bS0zc4k6w5Ogb8N
	 RCcropa2BGZlXwz+z/A5yoqk=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D72540E0263;
	Mon,  9 Sep 2024 09:03:09 +0000 (UTC)
Date: Mon, 9 Sep 2024 11:03:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v6.12
Message-ID: <20240909090302.GAZt65xhBpCvrrefhl@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull EDAC updates for v6.12.

Like you said "All the actual work should be done before the
merge window" and before we bring you the pull requests live, written with
a pen and paper, lemme send you some now so that there's less stress next
week.

Thx.

---

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.12

for you to fetch changes up to 92f8358bce13da0b2c37122573a2b2d7de0071df:

  Merge remote-tracking branches 'ras/edac-amd-atl', 'ras/edac-misc' and 'ras/edac-drivers' into edac-updates (2024-09-09 10:51:30 +0200)

----------------------------------------------------------------
- Drop a now obsolete ppc4xx_edac driver

- Fix conversion to physical memory addresses on Intel's Elkhart Lake and Ice
  Lake hardware when the system address is above the (Top-Of-Memory) TOM
  address

- Pay attention to the memory hole on Zynq UltraScale+ MPSoC DDR controllers
  when injecting errors for testing purposes

- Add support for translating normalized error addresses reported by an AMD
  memory controller into system physical addresses using an UEFI mechanism
  called platform runtime mechanism (PRM).

- The usual cleanups and fixes

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      Merge remote-tracking branches 'ras/edac-amd-atl', 'ras/edac-misc' and 'ras/edac-drivers' into edac-updates

John Allen (2):
      ACPI: PRM: Add PRM handler direct call support
      RAS/AMD/ATL: Translate normalized to system physical addresses using PRM

Qiuxu Zhuo (4):
      EDAC/igen6: Fix conversion of system address to physical memory address
      EDAC/{skx_common,skx,i10nm}: Move the common debug code to skx_common
      EDAC/{skx_common,i10nm}: Remove the AMAP register for determing DDR5
      EDAC/sb_edac: Fix the compile warning of large frame size

Rob Herring (Arm) (1):
      EDAC: Drop obsolete PPC4xx driver

Shubhrajyoti Datta (1):
      EDAC/synopsys: Fix error injection on Zynq UltraScale+

 drivers/acpi/prmt.c            |   24 +
 drivers/edac/Kconfig           |    9 -
 drivers/edac/Makefile          |    1 -
 drivers/edac/i10nm_base.c      |   61 +-
 drivers/edac/igen6_edac.c      |    2 +-
 drivers/edac/ppc4xx_edac.c     | 1425 ----------------------------------------
 drivers/edac/ppc4xx_edac.h     |  167 -----
 drivers/edac/sb_edac.c         |   35 +-
 drivers/edac/skx_base.c        |   52 +-
 drivers/edac/skx_common.c      |   49 +-
 drivers/edac/skx_common.h      |    8 +
 drivers/edac/synopsys_edac.c   |   35 +-
 drivers/ras/amd/atl/Kconfig    |    4 +
 drivers/ras/amd/atl/Makefile   |    2 +
 drivers/ras/amd/atl/internal.h |   10 +
 drivers/ras/amd/atl/prm.c      |   57 ++
 drivers/ras/amd/atl/umc.c      |    5 +
 include/linux/prmt.h           |    5 +
 18 files changed, 222 insertions(+), 1729 deletions(-)
 delete mode 100644 drivers/edac/ppc4xx_edac.c
 delete mode 100644 drivers/edac/ppc4xx_edac.h
 create mode 100644 drivers/ras/amd/atl/prm.c


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

