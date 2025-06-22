Return-Path: <linux-edac+bounces-4201-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E4AAE2EC8
	for <lists+linux-edac@lfdr.de>; Sun, 22 Jun 2025 09:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51AC173228
	for <lists+linux-edac@lfdr.de>; Sun, 22 Jun 2025 07:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B308198E6F;
	Sun, 22 Jun 2025 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="g8+IyqL2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8B71BC4E;
	Sun, 22 Jun 2025 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750578852; cv=none; b=Ia1xfGS0+Ow9TCwC6xB+aBTelAzWOflJmklGBv44JC5XhLdzkRN/T8LaUxtgn8IYtMDXOD4kb7DZU5omnwt2SsnXyyPKpOpbD4VQtUxPjevEasTBtdrFOG7LBgvqn/es4ybS1lL0ULlC/vQBotocv8f878CZSt35D71GrY8jD2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750578852; c=relaxed/simple;
	bh=m3QhgC9Oxl2Bc7EUQ1UlUUrTpGTYUv9PwwzaefYP+9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z2AKWLzBcUUosZKvwbdW9NBVbw969aVrWS8gJHGCvyWH/gFq9/zx8hQyU5gMFVUK2dUPZh8NKtOOa4+3+LpVcuaymZYvcaAGUoN5qWnGHchDgRx/NSFJi7C0sgxVVIYQLbs8k9rO7z1IgQWjrbrTCcRipMJ99SnHcPBWF9aKRUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=g8+IyqL2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8BADC40E016E;
	Sun, 22 Jun 2025 07:53:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id r08CE6IFBEys; Sun, 22 Jun 2025 07:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750578835; bh=UNHDt2clM+6bGn8vHpQjAgNYRNnxjqxu28E8pcHqDfQ=;
	h=Date:From:To:Cc:Subject:From;
	b=g8+IyqL2f61heXobF4c7RXeJ+VYQ0BisnYVF1mjpWi0prw3wc8HexwbtO5sYRTCno
	 6xM1H2ueCn07LMhJHXY/t0FkHhneyJgByiZADyeDFNL7mnAtgq2ZUyEFHZWPYP5BNz
	 HPCntH0BnMNGy3Nxv5PZ+qAOX5iZvKuGGHIxp4vSj6nV64/XyiPwMAcA+J+4ddzeU2
	 us2+Eo+Yoz5ozCYdLZJFZG6yC02U8nbtlhuq6NzWZQvq2FYAemdU1QiIc4JGTmQFWV
	 o2TzyLIagYY+96bvvR2R5xEnUh3nlndza79rbEathUVhzerI/0RGTWkS/onQJ8b2Un
	 Gg/dre5uGhnf4T1D4dRLVfdZAN2t+ImDUv9YYQqqehcSFsRzH5axkLBDPtFE1aZ9zC
	 OeoC77TDbcOumkmFpmg3lYEKH/Hj2W5R//N+LkiWyEq/xuhwrlyeYj2AuHZGy9ZICh
	 VbGkXu1oz63KxuLzXmrrXRg+NS323jdfcptQlPtDWdwDet5WKZNVSucQoJ5GiXLtMM
	 P73H8NYYgTkJU6uPPXIHrQlKP4T0xfM9vFe3hzDvhBuBDZNgx4MSOW+zrFZcjy+ZQ0
	 5Qu3YkYEHKs/UFHNTqa8d2Z+F/AAomgAoTkfkCFVkBRjC6TkZQXO9eXg24zcyCodkU
	 aJDEH/Hva2UZDCAnmxWfszQk=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 28EDE40E015D;
	Sun, 22 Jun 2025 07:53:52 +0000 (UTC)
Date: Sun, 22 Jun 2025 09:53:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for v6.16-rc3
Message-ID: <20250622075345.GAaFe2iR1i-n1neZcW@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull two urgent EDAC fixes for v6.16-rc3.

Thx.

---

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_urgent_for_v6.16_rc3

for you to fetch changes up to 88efa0de3285be66969b71ec137d9dab1ee19e52:

  EDAC/igen6: Fix NULL pointer dereference (2025-06-18 20:19:45 +0200)

----------------------------------------------------------------
- amd64: Correct the number of memory controllers on some AMD Zen clients

- igen6: Handle firmware-disabled memory controllers properly

----------------------------------------------------------------
Avadhut Naik (1):
      EDAC/amd64: Correct number of UMCs for family 19h models 70h-7fh

Qiuxu Zhuo (1):
      EDAC/igen6: Fix NULL pointer dereference

 drivers/edac/amd64_edac.c |  1 +
 drivers/edac/igen6_edac.c | 24 +++++++++++++-----------
 2 files changed, 14 insertions(+), 11 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

