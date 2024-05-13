Return-Path: <linux-edac+bounces-1054-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504FA8C3DE3
	for <lists+linux-edac@lfdr.de>; Mon, 13 May 2024 11:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC6B282914
	for <lists+linux-edac@lfdr.de>; Mon, 13 May 2024 09:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44601487D0;
	Mon, 13 May 2024 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="i9nXMw8c"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A031487D2;
	Mon, 13 May 2024 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715591606; cv=none; b=lnv1RBi2wTy4Y1bjG78+1cvZ2RY8ILbbEcUpDb2bR1sU5jAtwVIZO3m2dyFwPrAMnX+Xr46cDraUggSYBTwfCsDKdhbbEofHQsy2MyB2Sdw6IHY9YQXws8Ps4ZHI0wHKCKJpEa+T4BP6kK7+P0Gvrg97Ti4U8BmTPtnfNXX63c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715591606; c=relaxed/simple;
	bh=ETTJMxP526nDWVGZ2VZ+CQhmbdZGE6wqhJV0IsxB5oI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mB2tfm2pT0ChRFL9zR5DLy1mHgGKdHxr7cGcSsiGbQ5GGzoRe5tSJ1vmyqkhPSHn+GfaIzjCce+nqFiEvOPmd8ChZPYJe+SOcQZ81OWeG6CJkW+f6co396trSPXkOqZfiHwNc0dnhSXAtiOXQxpzENgOLWeUhF/qFEJ2rl9VLCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=i9nXMw8c; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4B51B40E01A3;
	Mon, 13 May 2024 09:13:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aXNytFTO2m4L; Mon, 13 May 2024 09:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715591592; bh=IYzIeVf8cY7wHCiLXApnXAIycqd85/pbtpdEs243Usk=;
	h=Date:From:To:Cc:Subject:From;
	b=i9nXMw8cpfGcNHOkz6+rLeJaNslcrHGBa8pciXug2sw1HO7xeQdnfmZy+0tdGEs8o
	 MSC6xxXv5Z7so1sJD5rC2VUCkiZ+vcD8gygGrTca8Tmy0XeePKZQtFcEK9JpIImjCp
	 OtAX6yT7yUUhejYGOqfPInK4+BzTQPFV9kXG7XZbl5aoXExzBR93bVrDZ+5QQpXU92
	 dry0o6xCXI4+GRQDL2osoV9FZp/x5b2UteD6nef+a4ZWDoyM6YPufPatlCw72hWJJi
	 wwsNtGjwOBuoAG7BUSdioVqIT2/3CVTmfETerqYDSwn8jjzJlS6qiLjCFvS2YIwhA/
	 CtoGvCJYWfveI/aHeV/VpLe57ltrRIhlbej2rlvlaEgPedY2MI1WgQDQxERlmHPAKD
	 /8HD67M9SR+MZsJoPgiXZlJ825bFYvCgEp33XBYwU+2QBJJ7QXUx0cclOR6Mejqgk4
	 4qb7gL7YBHrt/OGgaun+OCKeIbiugbHJp156vILTRatjoSxf1qzIs4loDKmzYrDKFi
	 2csMIKcSTU5EAfdcZAX5nSiqnL1Fibn50R4FYad77zcesA3VrjJqGtr/KICiIji0nk
	 kf2BKd0blW3FBzIJNejqWNyOay3+Kr5V3yWIwjbxMiCsPE3N4bfa91axBrD0LnazHk
	 obanrLk+ZOyfbR7Sd4l7MfFs=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 15AD340E0192;
	Mon, 13 May 2024 09:13:09 +0000 (UTC)
Date: Mon, 13 May 2024 11:13:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v6.10
Message-ID: <20240513091302.GAZkHZnuY3xHJWwzs-@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a boring set of EDAC updates for 6.10.

Thx.

---

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_updates_for_v6.10

for you to fetch changes up to e0d335077831196bffe6a634ffe385fc684192ca:

  EDAC/skx_common: Allow decoding of SGX addresses (2024-04-08 09:49:45 -0700)

----------------------------------------------------------------
- Have skx_edac decode error addresses belonging to SGX properly

- Remove a bunch of unused struct members

- Other cleanups

----------------------------------------------------------------
Jiri Slaby (SUSE) (5):
      EDAC/amd64: Remove unused struct member amd64_pvt::ext_nbcfg
      EDAC/device: Remove edac_dev_sysfs_block_attribute::{block,value}
      EDAC/device: Remove edac_dev_sysfs_block_attribute::store()
      EDAC: Remove dynamic attributes from edac_device_alloc_ctl_info()
      EDAC: Remove unused struct members

Li Zhijian (1):
      EDAC/mc_sysfs: Convert sprintf()/snprintf() to sysfs_emit()

Qiuxu Zhuo (1):
      EDAC/skx_common: Allow decoding of SGX addresses

 drivers/edac/altera_edac.c       |  8 +++---
 drivers/edac/amd64_edac.h        |  1 -
 drivers/edac/amd8111_edac.c      |  3 +--
 drivers/edac/armada_xp_edac.c    |  2 +-
 drivers/edac/cpc925_edac.c       |  2 +-
 drivers/edac/edac_device.c       | 53 ++--------------------------------------
 drivers/edac/edac_device.h       | 22 +++--------------
 drivers/edac/edac_device_sysfs.c | 22 +++--------------
 drivers/edac/edac_mc_sysfs.c     | 47 +++++++++++++++++------------------
 drivers/edac/edac_pci.h          |  5 ----
 drivers/edac/highbank_l2_edac.c  |  2 +-
 drivers/edac/mpc85xx_edac.c      |  2 +-
 drivers/edac/octeon_edac-l2c.c   |  2 +-
 drivers/edac/octeon_edac-pc.c    |  2 +-
 drivers/edac/qcom_edac.c         |  1 -
 drivers/edac/sifive_edac.c       |  3 +--
 drivers/edac/skx_common.c        |  2 +-
 drivers/edac/thunderx_edac.c     |  6 ++---
 drivers/edac/xgene_edac.c        | 10 +++-----
 drivers/edac/zynqmp_edac.c       |  2 +-
 20 files changed, 50 insertions(+), 147 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

