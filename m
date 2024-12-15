Return-Path: <linux-edac+bounces-2714-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083669F23A5
	for <lists+linux-edac@lfdr.de>; Sun, 15 Dec 2024 13:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B7F7A10F9
	for <lists+linux-edac@lfdr.de>; Sun, 15 Dec 2024 12:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11301547C0;
	Sun, 15 Dec 2024 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GHxjwXFZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2735E14901B;
	Sun, 15 Dec 2024 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734264989; cv=none; b=ed6hxUFDSoMZFQTnlXu9BC1wqTpt1BKAG9j9Nc599BEihcR7w+7dHSlSeuV0G8zza2q6G5wwrB5eLXIdq+12m1JzUlS4ZXcBuF95CUaK9Y02ygYeq8G0fdPRPGgsOspRPYY1mkqVx+2jqPXVzxPXhu6Omes4+xsFnvk2EBjBK+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734264989; c=relaxed/simple;
	bh=muPkzf4vxFHXrCzPvAv5HvYIaxPOUhmCTNEMcZduc9o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FgtEHqOt7eKHuH/vLWZgcNEJQDG9RU0p8xGpDWfE8oRyt0TRGhicRylcVQtYehKJF1k0o0ySQNeiGfpHos8llUutMi6DxrMUHFZXT2VQzCF00aEQ3HPnFswj1vIH9jQh70QmvxHLn64G+11Hmsk8zC8rrbmlJF0w5OZvvlKFxGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GHxjwXFZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4BF0140E0263;
	Sun, 15 Dec 2024 12:16:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id esie3qLj_uak; Sun, 15 Dec 2024 12:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734264982; bh=brD1B+KlA02GJSuRo+SX/Q5kx8N1fn7ZLKeEpNIaaB4=;
	h=Date:From:To:Cc:Subject:From;
	b=GHxjwXFZVSyVRKSRYUFZRPxulLdWIEXSgSfeCplcmkHvpdH6JcIc8d/FmwBnT1OOt
	 8GxpcTs9F164tAwxgEC+ymlPXSciN3CwKHzFac1DnXSRGDwduiNV7CRM0z8KRiWvn6
	 2bErSoaQKfL7h87/VXN2UXdMSVEMFaFjk5s+1KuNIipA9sUIBgMxxE1c1RDmMZnRKV
	 GVJMOQdBDsyhs6Wp4ICIiXG/Na7uHrt7xV0O8xXXY86kOhEJfuV3oQ4dRvuQfCD/Y2
	 V0CltY4Pofut6jreYviprPIMpYC2g2zeSuadb1BPAJVpq0lhY6Xo6FohdVdDGh1+fI
	 mYdB23V39cTdF7h8SMZ2U7ByfgAa7Ell70LVlZs2p7ZqBIcn21RfSoYjKftAHPAjbh
	 KxYOT7XMoVwS4wp4/pe824nz6Dx5Ik105KYGxk9NFwQ0eIv3q2jU/u5tC5zZo5EtPe
	 64DdM3S3fOaHSwtV1q6Yh7zHm81qRp9Fs4utpWytCrCfxuzCHyN8NTPkvE//BfZ1Ro
	 r4Ynmt3gZ5Dv2b1RDNESxBAUHMx7PR3eOKnxrB+gAWtMwsZKoG1/16tTyqKhN2cMLp
	 HAJK9aHKUBTJpsbIdtCFtiJLEtfIpW4nq1Yr8QGKrxf1+RSOrAUV8OFuzOJBQG8eG+
	 +f7wBiKbekPKjKkSSjB8KQAY=
Received: from zn.tnic (p200300ea971f9324329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9324:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 40BC240E01C5;
	Sun, 15 Dec 2024 12:16:19 +0000 (UTC)
Date: Sun, 15 Dec 2024 13:16:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC fix for v6.13-rc3
Message-ID: <20241215121618.GAZ17IkjqHzDVyqjo1@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull an EDAC fix for v6.13-rc3.

Thx.

---

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.13_rc3

for you to fetch changes up to 747367340ca6b5070728b86ae36ad6747f66b2fb:

  EDAC/amd64: Simplify ECC check on unified memory controllers (2024-12-11 21:47:33 +0100)

----------------------------------------------------------------
- Make sure amd64_edac loads successfully on certain Zen4 memory
  configurations

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      EDAC/amd64: Simplify ECC check on unified memory controllers

 drivers/edac/amd64_edac.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

