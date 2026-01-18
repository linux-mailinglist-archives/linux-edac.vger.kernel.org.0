Return-Path: <linux-edac+bounces-5652-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DEBD39474
	for <lists+linux-edac@lfdr.de>; Sun, 18 Jan 2026 12:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A492300C283
	for <lists+linux-edac@lfdr.de>; Sun, 18 Jan 2026 11:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E602E9748;
	Sun, 18 Jan 2026 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JUjKwUIh"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59FC21FF33;
	Sun, 18 Jan 2026 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768734769; cv=none; b=hDJdrq5vRGEv2Ip2hAN3ayMSGs3vCv+EK6XN1wLVaOBdf6AgwxoNNHCPCHhJ/MzJUIv6lJffDZeSgYJ/pvWgMnbOWvDEmizf8lPlwPDKot4/e9tND1ioWeX0PsgYzvwIskNfg1MjBRD7eYHz5YyS3kKqTO0EtwHLwj+MAFiltQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768734769; c=relaxed/simple;
	bh=39qtJjRffdl2LPqTnAcaB8Sqql9cV7Yonr2ZZhO3FLo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vDWvC/2+sLLb7VGQ7CZuyMm+aQvHZtPGVX+agXAH16SH0sRvIke7AEZyfCtH8VLGybdocc9MNwzFsT5fc0o8IogfGhMhAntgnZJDm1lTGycbZZ3wJekFhAi06pFzKpSe6RyzWZgZakm3OdsAHO+IWB9IL4wRlTPZ8RizE4z6TOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JUjKwUIh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 196A840E02D1;
	Sun, 18 Jan 2026 11:12:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0IZIiZ8VN-u8; Sun, 18 Jan 2026 11:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768734751; bh=ksRC24nt8WC7LKJUW0+6L/eon5vCreegMj8c11IVPw4=;
	h=Date:From:To:Cc:Subject:From;
	b=JUjKwUIhHE/HQwOCZIlQrasatTKieYe1T89zU+ZyFSGDBnikhAJiYaZikBqDDv/JH
	 WpdO7dXYKuY0FoRT4RVe9m8gmowNYBOruaYn+/Yr3HVouc2vg25/dS9ym42/0+HCui
	 AiA8uuodOsdk1rvj2mplh9AV7y7Z6rt44NraCxI8SS+kgvGkaZnOGNzImi84VNJ0nk
	 q0JlXyJzValLQ0OOLoSM+if8oBTasi4YAfkZNWP3Pj4dsO5kdVSyP7hfEziJQ7wcCy
	 jVbRoIPsIGTCspP0a5H8wbSEbXWuQ0mmS4sax73R/kECh2Dj7uAwXZpbJbQa9bFgh1
	 AsZnaYld+wZGF6eHYdtI4j0X4YBwGaqzz+2s03GLrpQMHUJ+fZ3SKN30GwKbmWPAR1
	 /CxFCu5ttsgH6XlYdyPVZ59S353RqwhbwcFo40ltufDa39oVX/hOlCEzo/YLCcP3sI
	 cJZM8zK1wZ2io+DRUOp06bLN63qDModn48BaYeYUH+RQWHA/N+u4m91AeQiCPa49UV
	 oe4RwFpNg2HGQF2nKg1Ckp3EoZyfhLDBYn13rhxlYJl/1wrJfDCD88p219KVWL1sKH
	 UbT4C8fFOLlDkn72/VhkvBAXjlP4DUkXQbQhIOeeI+K312ajnFiSrXO6dRtZ5btA9s
	 7uVo1goTssb8B/510Fi/PHsE=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B20CC40E016A;
	Sun, 18 Jan 2026 11:12:28 +0000 (UTC)
Date: Sun, 18 Jan 2026 12:12:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC fixes for v6.19-rc6
Message-ID: <20260118111227.GAaWzAG_7QzhlSTeKe@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull two forgot-to-unwind-resources-on-the-error-path fixes for
v6.19-rc6.

Thx.

---

The following changes since commit f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da:

  Linux 6.19-rc3 (2025-12-28 13:24:26 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.19_rc6

for you to fetch changes up to 0ff7c44106b4715fc27a2e455d9f57f1dfcfd54f:

  EDAC/x38: Fix a resource leak in x38_probe1() (2026-01-04 08:35:39 +0100)

----------------------------------------------------------------
- Make sure the memory-mapped memory controller registers BAR gets unmapped
  when the driver memory allocation fails. Fix that in both x38 and i3200 EDAC
  drivers as former has copied the bug from the latter, it looks like

----------------------------------------------------------------
Haoxiang Li (2):
      EDAC/i3200: Fix a resource leak in i3200_probe1()
      EDAC/x38: Fix a resource leak in x38_probe1()

 drivers/edac/i3200_edac.c | 11 ++++++-----
 drivers/edac/x38_edac.c   |  9 ++++++---
 2 files changed, 12 insertions(+), 8 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

