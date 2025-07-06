Return-Path: <linux-edac+bounces-4326-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8CCAFA394
	for <lists+linux-edac@lfdr.de>; Sun,  6 Jul 2025 10:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E4517E228
	for <lists+linux-edac@lfdr.de>; Sun,  6 Jul 2025 08:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825921ACEDC;
	Sun,  6 Jul 2025 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="e/Xezt7N"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930601865EE;
	Sun,  6 Jul 2025 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751789087; cv=none; b=bZyh1jZ8l4s2mtsG7zDKR2N//XsSK5TUm13UZIj3v6JrrV0HmFPIzcVB65reRi0Vax+rutn9LlbpyT1ogvSTMwbJhk5wMTkXe3lWQ2kG3QXW6tLggZ6sP2RolMH5bcd1Z24Ixld5pynDnwoCrI4chrtSbhDDApiMZAoMHSEd31g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751789087; c=relaxed/simple;
	bh=rWitimji/TArZoN7xNQcJhAHxmy74el6SQ28neA1wDE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W10kMj7M5K5y8YysRR/CRfru2URb1hadoi7M/7pDgNd3aUOpIlx4e/MaXZ1ePm9yDbbx+yjUPH0BBBpdQm3bIf3it6uJCMFdg8K1pzeUQrajzZlhNnzOLnhIhnttgemI7jnuoRr5rvkpOFYTowK2WYKrmrvDi+2uR6M6/U6Akok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=e/Xezt7N; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 173DF40E0198;
	Sun,  6 Jul 2025 08:04:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tByoW6Y3RtQZ; Sun,  6 Jul 2025 08:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751789062; bh=++minv9RSmkgrrFu2G5MHkvmAC7Xah7qbPgFSQE+CnE=;
	h=Date:From:To:Cc:Subject:From;
	b=e/Xezt7Nel+SvkugAot3jDMs6kzqiw05EGYSjeNgZRfXJ6S48E/dKOXPaGGw5Oqly
	 q4Is0DZwKmx/ZwM7WQ2hTJFdae1Ew99dZtwXl6vvXuxItbIsVnldMARV0N/3eB+2SN
	 Q3OwIMY5nppFJ6x74w1gJRgU+9eSGcB/c+ihi7uPJdKrtx/YPgJbSjw5tKDsMR7Y0z
	 doQ1504YwHdfuV+oW668ImK8g9zUGjEwRgXNas/RUW5sD55DFLpUF2cigv8xRxUNpd
	 ZuIsLRB0kYQaAi9DVa8M7ezbseKG9i1qMUe/BmsNa4gVl3Ef6rsBzUeGJ4H3g3TWGP
	 7g6Q2T+pSE7NAS2YYKquhgX2fCjWw4Zu9RWB7hiohuhKmptdNLAz56mXvVn+n/ox7+
	 JFOhtyUtAkTcI1/d6MXZzWKNQxi925iPiHcRh+AeSBIVhSnFG2weHUOhHowINdmiEf
	 y9q/mPHseytTO2Dpn7+l1JzF5RzgSQK/TUqH9g++4jbGBGLU5HTeL9f3+HyG9bxXK2
	 /FbV1nO4ay6U2y6D7gdHZmzcN/Bqu86X2pOvCA1gAhzjBhtd/Zycg6Q9V+AoBx0IUr
	 gWspnNGJsKxz/Ar6+5c71Y5vM9+RM6aiOdvkC8Y0yv+qBj8LGx4q1BZwh0lexqCBFr
	 oU3Gb2Jxuu3luEboSEtL3tto=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5552140E0184;
	Sun,  6 Jul 2025 08:04:19 +0000 (UTC)
Date: Sun, 6 Jul 2025 10:04:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for v6.16-rc5
Message-ID: <20250706080410.GAaGot-nOKs75u4yKR@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull an urgent EDAC fix for v6.16-rc5.

Thx.

---

The following changes since commit a3f3040657417aeadb9622c629d4a0c2693a0f93:

  EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs (2025-06-25 16:40:03 +0200)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.16_rc5

for you to fetch changes up to 1e14ea901dc8d976d355ddc3e0de84ee86ef0596:

  EDAC: Initialize EDAC features sysfs attributes (2025-06-30 10:57:24 +0200)

----------------------------------------------------------------
- Initialize sysfs attributes properly to avoid lockdep complaining about
  an uninitialized lock class

----------------------------------------------------------------
Shiju Jose (1):
      EDAC: Initialize EDAC features sysfs attributes

 drivers/edac/ecs.c        | 4 +++-
 drivers/edac/mem_repair.c | 1 +
 drivers/edac/scrub.c      | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

