Return-Path: <linux-edac+bounces-5444-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E36C612AA
	for <lists+linux-edac@lfdr.de>; Sun, 16 Nov 2025 11:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE26D4E1D36
	for <lists+linux-edac@lfdr.de>; Sun, 16 Nov 2025 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC67229ACD7;
	Sun, 16 Nov 2025 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MRcy8WBT"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D216156661;
	Sun, 16 Nov 2025 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763290330; cv=none; b=AJsmtjfDpa+gVQj+RiSQhpeAKPSc95/Ugkk9qjzMZHndJBxuu0kyyEGfcUCcDUiKu/Makshb31+uXRFp9RX+20dtjtJtYoAdf+acgVN6y83qJTKHugtyLefOcqL1/n3oonFF6ICe3aTFNvxMpWee+8SURLwycDVy5NX7u/RtAyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763290330; c=relaxed/simple;
	bh=Ko4P7HgACTLBOP9le4/gMxVBe6lA25la7NnXA73qMFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SNzDWqcVt2rj5Lzq56fMoKd8EMbNGAHuittLH+uQtYDykA5lXDC5bCw6IRhFny/s1BMiJP5sGTU04EMTjuSufP4So92rz9KagiQnPKdEIJ0UNQ8NncfB6xeVPkKlNFaRK48F5I3LsWJ7hmwn/I6p7nPXzG4haDrLSRRK1yqh6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MRcy8WBT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B0BD640E01A8;
	Sun, 16 Nov 2025 10:51:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TiAiJ_0Nt38s; Sun, 16 Nov 2025 10:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763290310; bh=gaPSnsiGQHfbtlm90srQ1l4RxXSp254wBCDyM4rtPFY=;
	h=Date:From:To:Cc:Subject:From;
	b=MRcy8WBTBDLndFZcnVlDW0nVbw5w6ZSvFd3eDMT/IhBQqgJSrLHHqp3L55D8140PK
	 28pbbVptM73oIfCFn4qvRxDkgbYBwRIZYlFmBvFLp9+1yDKDFdCsoPnKAqA8IXlsoZ
	 tTlpCqFzqXVm8Rvvalo3fM9vFaaQFcwRiJ1Xjos1X3D2lxTwMIWMLGoWw//7p18c1m
	 w7vt1GpUgCaMuh7f+X+qwGpBDcqGX6UodaXisD4BUrdeVth2FTk81FdueuqzQVCTRE
	 ywt0mvGKgO2dnGxAbKkl4r75piNn1Ow02eK06MwE9KqFU6UrmCK1+Ci8a/2Cs5vz9f
	 DqtvwWq9ciauHcN2XmlUJT+Brivg7H0CtGB86fypqqUNfoc4tD2xHN2IFqbiMwSPRL
	 06LdqPKsdlmK5uZxTVIaGGn7vKU/90lEUaYNi8LvlY75t/KKQmijQDrwkL1W2QrBpC
	 RVgbCdu2F0rXo8g7ZgK9Hgnedyh+RLFSGwGmMjULV/EWu4P6lezhfPvp7pir3illBk
	 GpWe8Nmp6twYxscNxLDu+67F3kBxQK9k8aCnyKj9fK0r/LkRb7F4JFT+LYDGEfiTbD
	 lbLvVc1g+004k42RZ4A6wvrriuJ3ZALP63e64HTnajz7uwfngBH+XtlKEcJltg8GRZ
	 4IkLEiDckMol5SmVZA0zou3s=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 436CF40E016E;
	Sun, 16 Nov 2025 10:51:47 +0000 (UTC)
Date: Sun, 16 Nov 2025 11:51:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for v6.18-rc6
Message-ID: <20251116105140.GAaRmsvNHdHys6awJr@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the urgent EDAC lineup for v6.18-rc6.

Thx.

---

The following changes since commit 79c0a2b7abc906c7cf3c793256c6b638d7dc477f:

  EDAC/versalnet: Fix off by one in handle_error() (2025-10-13 17:14:47 +0200)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.18_rc6

for you to fetch changes up to 281326be67252ac5794d1383f67526606b1d6b13:

  EDAC/altera: Use INTTEST register for Ethernet and USB SBE injection (2025-11-11 14:59:04 +0100)

----------------------------------------------------------------
- In Versalnet, handle the reporting of non-standard hw errors whose
  information can come in more than one remote processor message.

- Explicitly reenable ECC checking after a warm reset in Altera OCRAM as those
  registers are reset to default otherwise

- Fix single-bit error injection in Altera EDAC to not inject errors directly
  in ECC RAM and thus lead to false double-bit errors due to same ECC RAM
  being in concurrent use

----------------------------------------------------------------
Niravkumar L Rabara (2):
      EDAC/altera: Handle OCRAM ECC enable after warm reset
      EDAC/altera: Use INTTEST register for Ethernet and USB SBE injection

Shubhrajyoti Datta (1):
      EDAC/versalnet: Handle split messages for non-standard errors

 drivers/edac/altera_edac.c    | 22 +++++++++++++++++-----
 drivers/edac/versalnet_edac.c | 24 +++++++++++++-----------
 2 files changed, 30 insertions(+), 16 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

