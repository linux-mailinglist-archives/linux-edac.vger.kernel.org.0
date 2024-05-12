Return-Path: <linux-edac+bounces-1048-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8688C3563
	for <lists+linux-edac@lfdr.de>; Sun, 12 May 2024 09:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 844E7B20DE7
	for <lists+linux-edac@lfdr.de>; Sun, 12 May 2024 07:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BE713FF6;
	Sun, 12 May 2024 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RcQV5buF"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541117547;
	Sun, 12 May 2024 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715500669; cv=none; b=hvwvouN5Q5KrAr781yf0Vt1UoFvJEz60jDasdtde/0xo9Jv/E1TRCjWnsXW8r/4MbkRYZKzQKZAd1lh8/evsnX0ZKZvgiUu5xii9eV7jDN4g01g2FLkPnpY5AdzVy1VnAtTZ0xWjZ/jjWodELfBwWqFfheouNLyChL88qcJx2mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715500669; c=relaxed/simple;
	bh=QXHxJHGm8I7427Cx6l2zmM59WVrA9mo6FKgFwLvF5UI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ITXGYXQnd6hptsKqogTHCVPz0pdf9a/9bf05gulGbAnNZF65kRpX7D9Fvoidd9zC/w9yHq0UtdZLyt15KQ4kzAFCOjWj2TW9NfWGqfbVbvHVmtAFoBatRC0SSh8L3tbWj4AUlKNhrVLrb9/nI2hls2Qd0GDYAuqxC9WpLBx0eTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RcQV5buF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7AEEA40E01E8;
	Sun, 12 May 2024 07:57:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 42L-u38UhMtn; Sun, 12 May 2024 07:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715500662; bh=ZKOV/WDxVJbHkMSxsJUPe7uSTsZds0t2PFPid3HynrA=;
	h=Date:From:To:Cc:Subject:From;
	b=RcQV5buFtscUSrJSfHythi/VAPdYZ8cDlseST8SP+M3R9Mt+OwyYZ2qXmdlrL6keW
	 VmGBJeBBRk0jiK3gY/+cX/ZxnU+1T4JAocfuSH34Rqaw0Av7BSjsZc5km7UL2WBaup
	 r83EuFe/8G9girQkgZJY4nJQ+oipwdSJfubeHDjomLcuvvQUzs53Kbvppe7/ygrYFQ
	 UnFBn/wrJrVcEb/O9UzukMYqPh7YyJuEJKEc3GyNYoprnFZFcvSpUyVrrO0gP8pcRN
	 az4w8XjhyZ7ZFwrIXLroz5aaoRD1jA7SUWHVjQbeo1vYWwnUTjhCMvjuZ6kDxu81aN
	 SGZQRMJTSSc6ARMlCbFJJIjblUM1B5fogmUdLRmpI/C//4CTKCvcKt/1GZCPkzBEAo
	 QtSbK0f6RzyQpY+5h3xSGAHqP66MXnOWgPizeusF6BTDCf3UVqPRyJnM8JwC7JkX95
	 eQfjC1uIuvI9NIVV8TAS8p0pogi1pQjETCilb78gbjJba76qvnUnN4UiYE0T74drNF
	 OgsIMXcnwwiyk9QJk4M7I3oLrbtoKBpoHH3GVUVNJVv++7ichbSguZMzAQiE4P7fMP
	 rKPT4HMyTco0VmiP7Q9tfYnbnS65vqln6muhrZAaO6UdVAgF7dTgzBED8GMRy7bPIL
	 o7JeF3p2hEivzBd2HQE5ftP4=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B2AC40E016A;
	Sun, 12 May 2024 07:57:39 +0000 (UTC)
Date: Sun, 12 May 2024 09:57:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC/urgent for v6.9
Message-ID: <20240512075732.GAZkB2bMH9QL7i1eZS@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a single urgent EDAC fix for v6.9.

Thx.

---

The following changes since commit dd5a440a31fae6e459c0d6271dddd62825505361:

  Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.9

for you to fetch changes up to 591c946675d88dcc0ae9ff54be9d5caaee8ce1e3:

  EDAC/synopsys: Fix ECC status and IRQ control race condition (2024-05-06 14:19:07 +0200)

----------------------------------------------------------------
- Fix a race condition when clearing error count bits and toggling
  the error interrupt throug the same register, in synopsys_edac

----------------------------------------------------------------
Serge Semin (1):
      EDAC/synopsys: Fix ECC status and IRQ control race condition

 drivers/edac/synopsys_edac.c | 50 ++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

