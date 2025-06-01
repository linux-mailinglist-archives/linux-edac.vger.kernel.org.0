Return-Path: <linux-edac+bounces-4056-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D42EAC9E3B
	for <lists+linux-edac@lfdr.de>; Sun,  1 Jun 2025 11:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268EB1897A8D
	for <lists+linux-edac@lfdr.de>; Sun,  1 Jun 2025 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981DF1A2547;
	Sun,  1 Jun 2025 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EhP9TXEw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D0B84D34;
	Sun,  1 Jun 2025 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748770555; cv=none; b=ncQSZzUmLDqZ2pfzvHenfbw8WMZa72Cphc6B58AL/4nfy50giI9SRGpUhVuny4xxMM+FUJubqMsQprdMTsviRD6j+xM57cYbiGcr54IuNtuKRqeTwQY/etwr/hchKP3zvsm8Roe+X28hSHJ5BvcwufXqZ6XMXSbKijxPlXcEMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748770555; c=relaxed/simple;
	bh=RJKCaPiWIDE8bOx2/4ctR5l64HsBPwzlyJLVNSxp/g0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qa2sJ6ctTN/6jdAqc68SS4+OdwuHFnuBpcRWlktj3n+xTNE21XGLv0miukFi/OqQdAVJwGK7/EwfzsqBFkQUJCXFlcu0NeK6VuQHV0yjgM053HtJANIiHaWED188puNeQX9Yvr82fdbLvTce2YWtWpSEKnj3Et2LGMqxLPIwJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EhP9TXEw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 41B6440E01B0;
	Sun,  1 Jun 2025 09:35:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zHX6jAr_AudW; Sun,  1 Jun 2025 09:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748770538; bh=534HHIEC23nasQx/1enxYyPwoTEAc9KU8mA7uY/u/Dw=;
	h=Date:From:To:Cc:Subject:From;
	b=EhP9TXEwnZPnTaYxQm7AIaFOD9abj8+1DyQdWrcsXcK2HKenEzJpKS7A8YmJ+SK8w
	 BRyrzVLBVC5FLR+qOJE4B8qQWCVfe8yZnXR1U+joJUvbFGF+DLPmUlVlNdGzNKCQYa
	 ed80dqgvIig+v5oTyF/nKcTWBxbxOfWKoXzDq7+ZxpHL2SMngjT86D3z3eHj5ECvh+
	 BUvjgI9hx9+hoH8wqNr4lrlN1CGaJS7LdK/tJD0Bq6uQUp3tx0HWLzVKsdVJzuvrkF
	 clpCnkWC2Vne8E8Yc2Bz5sarvgFF2xifiTUPdSB9EGrErL30XFScbNS+Bec5s/JwFt
	 wSpXI0c+YfNN0r4vqr9PyMv9QvMdETp1E2fpEbeNyQdTidvGTbiWRLZCsDmy4WPI59
	 Fc8J6fbVARZ6BOy0gLTQxeVLbkYlzeGaJmlB3Vlcdj+vUs4Rbw5Z/sGgu8SN6HjfBa
	 qozo1Z3zbmA5d9zz38MMDYpfoFXMRSOPkb7Vutu10qhzPYJfWmFW8kcW6F8VRGjY3L
	 6HvC1V7xU+/vmyYlZxL+9i3E5H4tlSTCMMI1h+ybn6OxPcPfvZGsmxs547pU9NatK4
	 Yq7TKNIzFMlvBMtbpwWntFEqnsH8ngUuNl5E7SdlKW9MhU6NkRCNfIJBCK9U660uAX
	 ezeA+92SBCZaQu53f0I0ISWY=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A480740E01AD;
	Sun,  1 Jun 2025 09:35:35 +0000 (UTC)
Date: Sun, 1 Jun 2025 11:35:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for v6.16-rc1
Message-ID: <20250601093529.GAaDwe4Ucse6iANlLb@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a urgent EDAC fix for v6.16-rc1.

Thx.

---

The following changes since commit ada1b0436b5a290923b072b2eb0368a7869bf680:

  Merge tag 'edac_updates_for_v6.16' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras (2025-05-27 10:13:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.16_rc1

for you to fetch changes up to e5ef4cd2a47f27c0c9d8ff6c0f63a18937c071a3:

  EDAC/altera: Use correct write width with the INTTEST register (2025-05-29 17:38:55 +0200)

----------------------------------------------------------------
Limit a register write width in altera_edac to avoid hw errors

----------------------------------------------------------------
Niravkumar L Rabara (1):
      EDAC/altera: Use correct write width with the INTTEST register

 drivers/edac/altera_edac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

