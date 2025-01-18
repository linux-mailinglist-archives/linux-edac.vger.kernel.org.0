Return-Path: <linux-edac+bounces-2929-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A28A15C74
	for <lists+linux-edac@lfdr.de>; Sat, 18 Jan 2025 12:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBC61887C97
	for <lists+linux-edac@lfdr.de>; Sat, 18 Jan 2025 11:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E8615FD01;
	Sat, 18 Jan 2025 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ve0lf8Wj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984BC126C18;
	Sat, 18 Jan 2025 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737198579; cv=none; b=mPi7xl5xoCelBa+S6Xm3fkGu8VGUF4C9FmIkdzj75avDVuG4+egXifK6Ue2sMaufwiPN1ZIDcxiS6M6FN07wx+9vrO42RqouStBHLdXvM348/RmxL3BTxWLnUnX0o2G6smunKHu0mmR1ahm5+zHK8pPlBO1qKP6u0nASJads+PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737198579; c=relaxed/simple;
	bh=/RP/y0VzEc7l3rlxelm69dHgxhfCVSW7oEytkB95P+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kU3jSqBT2dnqPYTpurbd5JQzJI8OAtBjb+E5ahOfZNIXhFblC1ZvHq62Fw/T5PtFDboxgpcun2bhQXiwsKIiRl/tnrLOv0vCeZ7mil0X3tGWimSnvKDmRANBNEh3HxmxBVsVcq7GzoFA/7Rbksk/gahlVRHDfH5T79XS7eqYyTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ve0lf8Wj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 19CF740E0376;
	Sat, 18 Jan 2025 11:09:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kdEyycIHLOIL; Sat, 18 Jan 2025 11:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1737198569; bh=E7yArSeJJYIlTrb4H7Kl9AdqhVtIlzeoln/zez6MT3M=;
	h=Date:From:To:Cc:Subject:From;
	b=Ve0lf8WjSR7tMxXm1yTdPIBL8YVf6U1oul1pmqAy/axBNsl4RGljYmmVuYU6kvLnK
	 STKlhZpEJUznhrG50AeaJOQ9S9qi+O5kCB++Las9W9ayzxtbg8xpPIu745cf2CC289
	 zR3ZbLiQemrTNILWs28JA1slBzI1e02xQSodoYnb7HsNZxk9XCrAG4yzO5Jgzl6YeU
	 4oyQOknP3ouWURaHcOhaJhFUsWIyfe13cmQhLAQrGPvfOouT1LuFDKQwdg9VolnLbc
	 Gq4xOHREXY7Pr04+JpxKwK1toQdcRQvymJpnpykaHkgcAmCG2CXeAQrvYzo+fcDYTM
	 TaXd0UpDKCUo6Yf2e4HWN5Gaji+YNnRUHxL1d/s3fbEkTScTLa9d0FUIiDyX+6JrB3
	 7LcjYBQj1gTSKkrM1wlGF97fPpnMkAVrUAn7DRzTkb5lUqMtyUClvASpxpap6ziH7A
	 2sFyrEKSpjtgSGe4svnSzogDnKfZifBIx/wct2H2G2+bP4CcvNVbNUlHhnJ5JziZcD
	 nsqmOh6qRzxy+c12QmKTRJ10qhgEZ67m57x2Rw0Gw7mRYysSNaBfsA5k33m8shGOyd
	 RDuyEWD3/Bm9WeeEEAIEeNIe2sS1Rp4jSQ/V034K8V6xJ2Vn5UPtbV5GahON1sMGle
	 2fgFAD29Cu/HJqn1vJu6Ha4A=
Received: from zn.tnic (p200300ea971F9362329C23fFfEa6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9362:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D7E040E0289;
	Sat, 18 Jan 2025 11:09:26 +0000 (UTC)
Date: Sat, 18 Jan 2025 12:09:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v6.14
Message-ID: <20250118110917.GAZ4uL3XJE4ICoZfx8@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the accumulated EDAC lineup for v6.14.

Thx.

---

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_updates_for_v6.14

for you to fetch changes up to 368736db4d1c317ad065a1c827b09cfac942e05a:

  Merge remote-tracking branches 'ras/edac-drivers' and 'ras/edac-misc' into edac-updates (2025-01-17 19:36:27 +0100)

----------------------------------------------------------------
- Remove the EDAC PowerPC Cell driver due to the removal of the IBM Cell
  blades support

- Add a new EDAC driver for Loongson SoCs which reports single-bit correctable
  errors

- Extend the SKX and i10NM EDAC drivers to support UV systems which can have
  more than 8 nodes

- Add Intel Clearwater Forest server support to i10nm_edac

- Minor fix

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      Merge remote-tracking branches 'ras/edac-drivers' and 'ras/edac-misc' into edac-updates

Kyle Meyer (1):
      EDAC/{i10nm,skx,skx_common}: Support UV systems

Michael Ellerman (1):
      EDAC/cell: Remove powerpc Cell driver

Qiuxu Zhuo (1):
      EDAC/i10nm: Add Intel Clearwater Forest server support

Yan Zhen (1):
      EDAC: Fix typos in comments

Zhao Qunqin (1):
      EDAC: Add an EDAC driver for the Loongson memory controller

 MAINTAINERS                         |   6 +
 arch/loongarch/Kconfig              |   1 +
 arch/powerpc/configs/cell_defconfig |   1 -
 drivers/edac/Kconfig                |  16 +-
 drivers/edac/Makefile               |   3 +-
 drivers/edac/cell_edac.c            | 281 ------------------------------------
 drivers/edac/edac_mc.c              |   2 +-
 drivers/edac/edac_mc_sysfs.c        |   6 +-
 drivers/edac/i10nm_base.c           |  12 +-
 drivers/edac/i5000_edac.c           |   8 +-
 drivers/edac/loongson_edac.c        | 157 ++++++++++++++++++++
 drivers/edac/skx_base.c             |   9 +-
 drivers/edac/skx_common.c           |  47 ++++--
 drivers/edac/skx_common.h           |   3 +-
 14 files changed, 222 insertions(+), 330 deletions(-)
 delete mode 100644 drivers/edac/cell_edac.c
 create mode 100644 drivers/edac/loongson_edac.c


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

