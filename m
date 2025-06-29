Return-Path: <linux-edac+bounces-4278-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9680AECBBE
	for <lists+linux-edac@lfdr.de>; Sun, 29 Jun 2025 10:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911B21896F93
	for <lists+linux-edac@lfdr.de>; Sun, 29 Jun 2025 08:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23531F0984;
	Sun, 29 Jun 2025 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Elr5YFAE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB4B126BF1;
	Sun, 29 Jun 2025 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751186125; cv=none; b=KL7SEy3LtxFKYVmDvpQRR3xnS/anCMiCt6zcXRoNYK449cME47bCpO5HAicI2agMolJ5dUf/ng7afJaOpvXwJHnYyeJ+kAuRvTqROdAFjXZsJS5wDyWkft3wV93FxpjsMSxsnTrkOlpJYvwQNRmwNzcVKzSJghubOrYSTsYkI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751186125; c=relaxed/simple;
	bh=mrFp+fa2Ot1Q/rvbxMC0ldUW0RjVmgcoqPsSOOEvhdY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MjYgZq4NgdDC03QGqaYQA5qqK/+vQbSINZ/Yafqj13SZd1tSoGJGVhIywtpn/dRuOJwz/yxLrCGamdKulaNsS0sdgCWoX6vj+kBfE1hruoPD3u0bcOOW5RKG3SQk+nnxMEqccyQ+jRRaH1ufmqi6BGKY0ppu7mDROy1QSKodwNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Elr5YFAE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8092140E0198;
	Sun, 29 Jun 2025 08:35:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id w-Dlg_MbXOvo; Sun, 29 Jun 2025 08:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751186113; bh=1VZXEJEpugQR3EdGxvkK/5zvq3zJOuO5xMnezM7QQ6k=;
	h=Date:From:To:Cc:Subject:From;
	b=Elr5YFAER9ZnCXisdcmU8/Ogo9lti2/wlrNyuEYCKNyghUyANz8pWFxDjZXeKXhpf
	 oH33Ikr0mTSVOA9SA8GgfcOAcXmvah47Eo4xsmhIMQzqJu4GXnm1uTZlSuc7uuNPeU
	 o2s2wqfOC5Wx3gPctS31/cpNmj3JDiM2xseR/UP+VJNo5Em/1BwPlfVW+sjriV6nq/
	 25ZhmIwTiQEWiWK0MLuGvlecMrtFAjX4mh+OanufUEoKnOgTHxp5Eavpx+qBL60C0D
	 GW5xOlvhYyq5n6xma2Zs5CHik56qJKg3z/Sd++lPNHrChLMqX2GUdX4Ex6rOg61gJy
	 Cgqbl859zPLLjoS/jrDVvDEHiHqx0qnDRJm/6FAW76rSQWGH8KTTY28Iewszor+R+b
	 /zX3ThqJVxbQxmVYh44yMR8y0/YesL6AGnS7SWjpTTmFNR7e/kGuGnMHs6wdzQnHGD
	 vfsF6htt/rcNJ+KaUMutt0E7wDL3Cbk0l+w70tQz6/j6KPaXnhUCfoOVKNMTrDLeV1
	 4xah0xuByrtqzPgvaM7U5nHEHff8wjFAGiICdz/S6u1IhMOjhV427qAiHKKFvhuUen
	 S0r38ySL5+7D5mPD0uETLV3SFdfLjYmdCeFRZMkMw4Pv2U9QoSoHukhSx9EwetvYOS
	 F+Vlm9bLvh06VdYstN/2gzwk=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C0AC40E00DC;
	Sun, 29 Jun 2025 08:35:10 +0000 (UTC)
Date: Sun, 29 Jun 2025 10:35:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for v6.16-rc4
Message-ID: <20250629083502.GAaGD6tqBFp2YhK3Dr@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull an EDAC fix for v6.16-rc4.

Thx.

---

The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.16_rc4

for you to fetch changes up to a3f3040657417aeadb9622c629d4a0c2693a0f93:

  EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs (2025-06-25 16:40:03 +0200)

----------------------------------------------------------------
- Consider secondary address mask registers in amd64_edac in order to
  get the correct total memory size of the system

----------------------------------------------------------------
Avadhut Naik (1):
      EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs

 drivers/edac/amd64_edac.c | 57 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 21 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

