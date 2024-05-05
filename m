Return-Path: <linux-edac+bounces-998-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D5F8BBFF3
	for <lists+linux-edac@lfdr.de>; Sun,  5 May 2024 11:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2261F20582
	for <lists+linux-edac@lfdr.de>; Sun,  5 May 2024 09:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAA1747F;
	Sun,  5 May 2024 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Eyq36By/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC4B653;
	Sun,  5 May 2024 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714903075; cv=none; b=cL6W1BOyO8KcG3FGpaa1TGBKAPSJ5BI58MtNUjisGVGHF/ni5GwyjAU7nLMTsdc64s/mJ36fH0IBYDRTQwCv+K410/DpZAR1jxo4xkTbJAI9Pe1aB9x5AxeAkD5DbmrvTY9i6i2pXuORD5ddUowipXf1V1b6I+l2FqzlOHOq0Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714903075; c=relaxed/simple;
	bh=UJ7kG3CgwYTS1JYqa38g1qK01f7K30E654IZFD1W8qU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HTUDdF1GniBYpGMrqE+bZH3zODrcGHi2A5VL39pVNRMFKlfzYsws3SmCuFrwOtvt7p3iSVNND6XqUQToJ0XLjpHvxxuMDUZFZZ/Pl5bhXb/3Ht08Yu0pwbDMhoibpSopxgYHlU7+/EttUGcUmP5HVxNXkbtysnH6rim9QARpC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Eyq36By/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 33B8040E01A1;
	Sun,  5 May 2024 09:57:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7M5ZAwj60ufJ; Sun,  5 May 2024 09:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714903067; bh=DvC/cXMibLd7eYUFXxsA0ZgtnUWc2cEbaj+9sCn8hF0=;
	h=Date:From:To:Cc:Subject:From;
	b=Eyq36By/gAW7uL3tcE1TkLwxdVaF6uPOALP8nMezsgqQAEd8UYSixhriMEIr4SxN5
	 z97ArKJKC12XRUY1GV1d5qZiEaCq95VQrYY4iS7kYjaAufaO/VEnFsfWCWhy1Bxydl
	 Mu0LOkc88DS9CWfOpAuW6gARm6QltdcrzPLerwKf0kRSHGFYXamdO9tWhdB9gCBWZd
	 vqCWq2RZl8j0WzlG+m8O72U+EAQbfRZ+mWKjKLfaqICL0uIEwXXxjKepil6E+4+tn4
	 5zt5G1K8r+Lwwmu+nt/+G64oCaSeChBUMfc7F85J1PjmJOYQKJ6RXY1/BEjGOgE1gp
	 5m03Hu2gFhBd4Whktyy6YW1oDmenljbHpId9Aw2c1HoDX/DydpOnx+M34+Ai5Ygrll
	 ohh15TwfDFw7hDUfgfcI8NJfGsEOs3uoSENo+g7+2SaSAkFLgQ2Q9tw61A5VArNsLe
	 52umVw9aeOVXNSrR1+PTrRKixY2R2uKVihbn+jkHJXGFQf5uq7Z+YoNqXPTErC+8my
	 23vf0tRptTK+5/Gb3C1Z2O2YWE95i9FH39KHF596HfU/lJGdl0WiN55kSp7HCwWpmA
	 bgo2NyloQPPaA+8SIDkszWZK+CJ8/Zn24Hpqrm6Cl4jBChm7EUhP2dQhGHGNMkJdk7
	 yT+EtHm4w/ara/VNDagOqFio=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EC79040E0187;
	Sun,  5 May 2024 09:57:43 +0000 (UTC)
Date: Sun, 5 May 2024 11:57:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for v6.9-rc7
Message-ID: <20240505095735.GAZjdYD8m5ZAhNGd4_@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a couple of urgent EDAC Versal driver fixes for v6.9-rc7.

Thx.

---

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.9_rc7

for you to fetch changes up to 1a24733e80771d8eef656e515306a560519856a9:

  EDAC/versal: Do not log total error counts (2024-04-25 18:08:05 +0200)

----------------------------------------------------------------
- Fix error logging and check user-supplied data when injecting an error
  in the versal EDAC driver

----------------------------------------------------------------
Shubhrajyoti Datta (3):
      EDAC/versal: Do not register for NOC errors
      EDAC/versal: Check user-supplied data before injecting an error
      EDAC/versal: Do not log total error counts

 drivers/edac/versal_edac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

