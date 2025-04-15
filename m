Return-Path: <linux-edac+bounces-3541-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78593A89E2B
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E160F189C88C
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 12:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8A627A934;
	Tue, 15 Apr 2025 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="L6j2TmlH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8450722F01;
	Tue, 15 Apr 2025 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720438; cv=none; b=I8yPgNLcatAr0hgmEYXNuLjRgjM/dLwPTNXbY8VVcWXi/W8Fxm/6xuI3mCvl9ZzyYPZrwyjrMNOtKldujZKy5wdJHtr9KVOGOH/ZMRfGOHPyHTkLDUG3Y9AVzd/NzVQWsNOfy8tiOSuE7+9cIvq2MAfDkRb95QpqElab3uQlKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720438; c=relaxed/simple;
	bh=MNvE2UciHcCATVpJmKQhjrJtY36mxwEqQHk00pdt6J4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UE53k2zFb/K0ggdPUm6Q62ARKtcr6ew5J2Pooc8GShYgYVbdgC+bBbsIIqyu9oC+1FOPG7hmUX7a341WoFjCae0M3+ddkac3NRnELKt9a0c3WMyUPYnq25AUQv/PW8+mh2M3P9+oVePi1krSZQ6K1cDVgwM2ojVkOS+11nyO5Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=L6j2TmlH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 45CF440E0242;
	Tue, 15 Apr 2025 12:33:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id G6shJrgwfx3o; Tue, 15 Apr 2025 12:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744720423; bh=zyR8Wu7rN0QSLorbTrWYixx98F1h7tDtKpJUD3C8MnM=;
	h=Date:From:To:Cc:Subject:From;
	b=L6j2TmlHZJYVEx+WRcgMuiACGD/hIMNrm4Warsu0JLfcYuBwIN206ixb62BBFTU/w
	 DaYCEba1H4LDOh2rlz8tsbKVIaiYOTc+IsARumRcfzSdWvzbNe+/7d7d5HE+AuLLIe
	 OYK1tp6qfMeSJmY2O9KZrzgSA6WLYTNbIXcF4UETS05ocZq6Hce1FGnjcePPgBJiPr
	 6bdc9DT83MeS1OQqxYi5nVKtt9vm/EyM4Pvucy3bl5Yv9OXUD1e2hKkimWceY6/AW0
	 NE7M0IZyHTH0jiVv6RKzC8Q18IoJAGn5iXKl7rbZYqJk3fU9vRXE2Eg13V7cA9MhHx
	 4Qd8H/p10+8MW17zxsXdFB/2t56uR4tlmIlvlwq7pu5tFjHZ5zpDVKIgxCJ+MUYhAj
	 CkMAHVlGwP7p/mf0E/ss9fI9Fm/eVy35xY+h8MLc7/9tUWcIWs03C1O3cS50koohtD
	 1EVBHu8oTFICF1mj8/0TD+HxtPrK1lUHPTMJrJaakVhyHDQU0wlbpBnhPKqSvOEphT
	 UvEY2h4tQX+4yJQN2f/keju+3Hdyyx3E6unjp9zpeKwghrhoA92bix2X4gnRq0bNve
	 syeeVsJXFWAL+du64s0tsyDUCzefbtLHCKiic0UmdhNtFnf3b6iMYxm2xQxwfHCSlp
	 nmdv3sBZx4vhrSHXVw26K2og=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 841EC40E01FF;
	Tue, 15 Apr 2025 12:33:40 +0000 (UTC)
Date: Tue, 15 Apr 2025 14:33:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for v6.15-rc3
Message-ID: <20250415123332.GAZ_5SHIlZcpQxbLMj@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull two urgent EDAC fixes for v6.15-rc3.

Thx.

---

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.15_rc3

for you to fetch changes up to 58029c39cdc54ac4f4dc40b4a9c05eed9f9b808a:

  RAS/AMD/FMPM: Get masked address (2025-04-08 19:30:58 +0200)

----------------------------------------------------------------
Two fixes to the AMD translation library for the MI300 side of things:

  - Use the row[13] bit when calculating the memory row to retire

  - Mask the physical row address in order to avoid creating duplicate
    error records

----------------------------------------------------------------
Yazen Ghannam (2):
      RAS/AMD/ATL: Include row[13] bit in row retirement
      RAS/AMD/FMPM: Get masked address

 drivers/ras/amd/atl/internal.h |  3 +++
 drivers/ras/amd/atl/umc.c      | 19 +++++++++++++++++--
 drivers/ras/amd/fmpm.c         |  9 ++++++++-
 3 files changed, 28 insertions(+), 3 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

