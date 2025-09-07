Return-Path: <linux-edac+bounces-4732-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2C0B47B0E
	for <lists+linux-edac@lfdr.de>; Sun,  7 Sep 2025 13:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D2617A0F0
	for <lists+linux-edac@lfdr.de>; Sun,  7 Sep 2025 11:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A416264A60;
	Sun,  7 Sep 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Kh9UFQ0Z"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1678C2905;
	Sun,  7 Sep 2025 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757245417; cv=none; b=G7vwLUmTWBHHihn4cD6PE2eILuTefsuUTlGbbXWPWqJzf5WCYq8d71zXjiPE98rNG1XWWS7k0XqzzfUMS0csHkPR2WCydqAgdGA3Shk+j1oGety0TXjfPVZtwcCMnQQcAv1ak36GvhCSqcWNBcNQ86+W1lpy626dhECmClon0Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757245417; c=relaxed/simple;
	bh=CEGW9pABftoSfMmc4wBV9NvVYkQcPw35dfFr4tknbOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K5H/m55ewFmwKBQKxFYPZVAT5a48aDKyYIXx7tw0BsVIbMV5oGCrfKA3h+haeJz9BNORIVVMQ50bH7B8qxq9XZ53xMtx8FQrotb3x/AXa/2rQpL83n17eduzmWTVAmax1ExoSNFQsxTa9BXGA55tiqEZYAg/M5/2CZD89zo+Xt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Kh9UFQ0Z; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DC32F40E0174;
	Sun,  7 Sep 2025 11:43:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jHwm0hphiuTQ; Sun,  7 Sep 2025 11:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757245408; bh=iO0Q+99clM90GYXKvIUjDeV09/pcYXGUidOT9+19Jxk=;
	h=Date:From:To:Cc:Subject:From;
	b=Kh9UFQ0ZZXncboj84KPhwTNsngw1Wjv8GCGBMplrHlwhlZfKiPEgSBSUSiMsg/Vn9
	 B7vLcBtTrVlcdARWc6LCUwC0FnCosGakCJn2kWXut1cVxxId2ais1ImUB1JG3xLasf
	 xY88gT1arkrrzKn1lRFonxfzQscyH5Xo/xTWn2FZ9X5SSEVaaCJ3f+jtYM+tsPg8ft
	 KjiOlzHf9dY2x5tDJg0AWCj73kSSUH0aJJv4ZRWo+FF2lZVqqBUoVLHSh5vKbF1mUu
	 9fKvbsDIrIV0IOFnxfZNml0eqiCC7FQV+J58mbMlpm0PskK55inWnTwulP1nyRV4vE
	 LZTDmxB6tAc5UGOr7bLUpqx6/IWNNsVJxik/sdYbhNxuEcVw8CwKcdc3qha8FywjFJ
	 LAAx1C13DUqKyXKIyn5BSS2Byqj/hpUzc6cnP9ZJB0BgG1g15OBsplLDxc49Yqt1Yt
	 grySM38dROvKbik/RFb3T5pk9PeKpx+N2HVu56JaVLEBDFhUL3Jy9hYz7qA2Ai3pyD
	 tn1BAlFxVL1+AzSZH1RMulkrw6sEolsdhf5av/NJT/iFHZ02sTPcqEvENYSPcoGjSk
	 hlN2s9MhCOG83MvqxU0ZPFjSAaR7mulXzoGOcxSMjd5CmL/hmwG0cbphSMkeabsMaN
	 Qm3SUIwbFCvU1aICfZW6Xt+0=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7EC4040E015C;
	Sun,  7 Sep 2025 11:43:25 +0000 (UTC)
Date: Sun, 7 Sep 2025 13:43:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC fix for v6.17-rc5
Message-ID: <20250907114319.GAaL1v16f5XIbbkIZY@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull an EDAC fix for v6.17-rc5.

Thx.

---

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.17_rc5

for you to fetch changes up to ff2a66d21fd2364ed9396d151115eec59612b200:

  EDAC/altera: Delete an inappropriate dma_free_coherent() call (2025-08-25 13:56:16 +0200)

----------------------------------------------------------------
- Remove a misplaced dma_free_coherent() call in altera_edac

----------------------------------------------------------------
Salah Triki (1):
      EDAC/altera: Delete an inappropriate dma_free_coherent() call

 drivers/edac/altera_edac.c | 1 -
 1 file changed, 1 deletion(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

