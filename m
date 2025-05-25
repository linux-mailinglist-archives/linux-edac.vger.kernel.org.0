Return-Path: <linux-edac+bounces-3998-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D87AC36E7
	for <lists+linux-edac@lfdr.de>; Sun, 25 May 2025 23:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8481891DE1
	for <lists+linux-edac@lfdr.de>; Sun, 25 May 2025 21:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2A01547E7;
	Sun, 25 May 2025 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="II3KIFuM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7556145B3F;
	Sun, 25 May 2025 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748207819; cv=none; b=JUsE0V89IEoE3yRzhltK3Kmx8QHNLbKfpAje00J/PYK8ZTulGsosE2ePO8vfEqT29/AQ9KNb6sUkqvGFACVLWVxg4LTPIwCec6JZmo0bGk64Ih7oPw+ZTP6FZT6AGuHejwA5GcZq7sRwuw0BX59Tt7ePnuwkQNg3jQyftTMGziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748207819; c=relaxed/simple;
	bh=TBH+C9FThePkUfdvX9cVY62+HGyS1ZOanwJDuFFOIyA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dA7m4wQXPtZ5LqH7JNcQgndy+UCyIxksgRxatsfjFJvbKNWbQ3JNCg2S0UL1uEcbqzvvVRVup+1NOQ8q/QFw+wqb45Re1S1+Iq75MtswKaz/dCPY3ZqLPxn9JXy7cywnN0jgF63fbbzpqzAGN5wPrlVCBoGCwD+kBkWm2G3l7AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=II3KIFuM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D6BDA40E01A8;
	Sun, 25 May 2025 21:16:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0vsKWCsRoWUX; Sun, 25 May 2025 21:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748207795; bh=43WyX77Gfj9FWc2KCKZRWlU4Eg/+PHerZt8pajAaHHI=;
	h=Date:From:To:Cc:Subject:From;
	b=II3KIFuM/MCdmfemxw9ZMhi9j0Z/8zdKp7iQztONWfs9O26hX8xb2hfDK50fEihom
	 p9NSTkriGkAuRVA5rqJ4Ej3AMbeTbQ6Y37ut9pIcpIooAvI/HchYLZjD62BqjOOBr0
	 fzXGygjMftVmY9tRhR1ZV+2sGtW50gyJSqNuBpondm9nVHR9D+Dr+Ywlq5jaYQRAXR
	 gw+bISQk5Rn189quLRloBS77BN1v1igyXK4PjH2Su/BWwMemUaUvS8NF0mcxG/H6CF
	 r/h7azyzPFLWQb2mgQn32Lpgx8Jwwf6kfRyxtI5vZsVQhcFwfbD32ellcjcqLf/WLf
	 7yVkc+lGwPAEqMgndIfC+WvfINeBaqMvpe5IERcckTaI+uHqZKM78o2WDk45HqkRJP
	 Z0VN/H84paO7b5kFw2OtIFzT1FPqodWVjWgeS1iFBUwctNQCc3gqV8n4xo+L94gz8s
	 b3fj9KPgNjVZmPp1EuUO6S7cRE1ZOxGkPyu89gjDDOnfrKinTj9DQVMAMs5GgZJd1K
	 qWDptuostKv0/BySk++rBaNRtDk52IlgkjnJtjvBSWrasZd71KkmnaF7N5Vt5Xi3jr
	 2pT8J6GSfpDnwqPFfV2llG8WQrj40lLsPV4XfJ+i334NZAvBwQE2ptfALGXmzagqLw
	 ZpmzBsTLQufdqh1w4z+4EB6s=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 81A0440E0028;
	Sun, 25 May 2025 21:16:32 +0000 (UTC)
Date: Sun, 25 May 2025 23:16:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v6.16
Message-ID: <20250525211618.GAaDOIolEntC03ernr@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the EDAC updates for v6.16.

Thx.

---

The following changes since commit 8ffd015db85fea3e15a77027fda6c02ced4d2444:

  Linux 6.15-rc2 (2025-04-13 11:54:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.16

for you to fetch changes up to ea3b0b7f541b9511abe2b89547c95458804f38e2:

  EDAC/bluefield: Don't use bluefield_edac_readl() result on error (2025-05-22 17:58:28 +0200)

----------------------------------------------------------------
- ie31200: Add support for Raptor Lake-S and Alder Lake-S compute dies

- Rework how RRL registers per channel tracking is done in order to
  support newer hardware with different RRL configurations and refactor
  that code. Add support for Granite Rapids server

- i10nm: explicitly set RRL modes to fix any wrong BIOS programming

- Properly save and restore Retry Read error Log channel configuration
  info on Intel drivers

- igen6: Handle correctly the case of fused off memory controllers on
  Arizona Beach and Amston Lake SoCs before adding support for them

- the usual set of fixes and cleanups

----------------------------------------------------------------
David Thompson (1):
      EDAC/bluefield: Don't use bluefield_edac_readl() result on error

Qiuxu Zhuo (12):
      EDAC/igen6: Skip absent memory controllers
      EDAC/igen6: Add Intel Arizona Beach SoCs support
      EDAC/igen6: Add Intel Amston Lake SoCs support
      EDAC/skx_common: Fix general protection fault
      EDAC/{skx_common,i10nm}: Fix the loss of saved RRL for HBM pseudo channel 0
      EDAC/i10nm: Explicitly set the modes of the RRL register sets
      EDAC/{skx_common,i10nm}: Structure the per-channel RRL registers
      EDAC/{skx_common,i10nm}: Refactor enable_retry_rd_err_log()
      EDAC/{skx_common,i10nm}: Refactor show_retry_rd_err_log()
      EDAC/{skx_common,i10nm}: Add RRL support for Intel Granite Rapids server
      EDAC/ie31200: Add two Intel SoCs for EDAC support
      EDAC/i10nm: Fix the bitwise operation between variables of different sizes

 drivers/edac/bluefield_edac.c |  20 +-
 drivers/edac/i10nm_base.c     | 479 ++++++++++++++++++++++++------------------
 drivers/edac/ie31200_edac.c   |   6 +
 drivers/edac/igen6_edac.c     |  86 ++++++--
 drivers/edac/skx_common.c     |   1 +
 drivers/edac/skx_common.h     |  61 +++++-
 6 files changed, 422 insertions(+), 231 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

