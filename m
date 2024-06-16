Return-Path: <linux-edac+bounces-1296-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2D8909CC6
	for <lists+linux-edac@lfdr.de>; Sun, 16 Jun 2024 11:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D132821EC
	for <lists+linux-edac@lfdr.de>; Sun, 16 Jun 2024 09:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66461180A99;
	Sun, 16 Jun 2024 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Zm9h1ND6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031233C0;
	Sun, 16 Jun 2024 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718530008; cv=none; b=K9jYdAyDUbsYRSXWbSgIywtCnvR5Jbe5vWzmmTo2IFo+drpLnp0Zxp1tK1KzJc0bPcbTHosjRFCwExiwwmkwLah3s5k7Z2bAqeecCBV33HydLH2/NfNNDqpBlKIN98uV00EVD2T+SdapVlvqW8e/DYp7wO1fwaitBUSV3rMfXGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718530008; c=relaxed/simple;
	bh=j3vOrzweWX1GE41fTl2m6LEe4d+ziKfF15U+bYMV0D4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PYyb1MopNKYyJzLZcBqIhsCILOs641fGpNGiQ4pTqsrm1x0DCcQBT9YPm1dCipTx16IfWYn0as9wXyAKbB5wFdzFMJp2ZsMez9ALld5+V/UzwHPZUaCGIZl5xfcbWl9vAqNPWMZLkIzLsAzlMxbIlN/kAMCN4yktmy5vTqUSf0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Zm9h1ND6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8EC2B40E021A;
	Sun, 16 Jun 2024 09:26:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9BjSBD58pyW3; Sun, 16 Jun 2024 09:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718529992; bh=v8KnRjWWYrWsg8jYbf/KCGOCjIQw22bsuKrCdsHH1PE=;
	h=Date:From:To:Cc:Subject:From;
	b=Zm9h1ND6F3c0XzAdHuNUUdBQcyPvx08g7P1k7oNCIRKqmkuRqe4KFicHWYum5afGV
	 NbeIUhanKpSxHJHHoLCirj6wosKRdl+MMsmU5RR6jiP0KS75DqeUo676zrIUo9XZ0h
	 /7ZF9mEIKG3JPF09/mFHZOq7gWTT5bSSlduRDWmQn/BQsVjeXGIjPR2AORO3o4ZsBv
	 hIrL+O+WqLkhuZl6cmTaUJd5nou067u5obX9VZKGe4vxqQ8wrJOCRZb7zH3iVD+BF4
	 UyJqUJqfDBqEuWW/HBV0biD5KjjckuvR55hGCdNKl7oZwhf5jMaqfKaoTq75ubCuq7
	 ccCqtiwCuRZ+F6HFIwkvGy8vslzDXFmTgCgS6uouHWjtlC18ypEOu3TcgRQPTODcb9
	 CzQyurPGsk3aEwA1Osudty+0GDP3Iru4S+ogwE+GNmYmTAcpo0mhMfxmDGL04Q/6iS
	 wt4uQzM4ADoXoRgaDr6qBWUpJ2TtQxF/F62bbtL3CY0wxLssBlJRlho80cRdjZUfgX
	 XhQ4BP//lodlCE2DgF9fyS0hWvt6xV/vsCmg/28nS9ESjOPkFl1b3QJvqTn3iluzya
	 PSaQoWuwZjjCS6bXXSSBE3s46Ud7sQt77HkVtIGe0B/ynw3rV2EpTHW+8D5vm9SiI3
	 YRUHzzQB/DHdWFnxwCAmC7XM=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44EA140E01D6;
	Sun, 16 Jun 2024 09:26:29 +0000 (UTC)
Date: Sun, 16 Jun 2024 11:26:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for v6.10-rc4
Message-ID: <20240616092621.GAZm6vvbHCGbc4hKz_@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull two MI300 address translation fixes for v6.10-rc4.

Thx.

---

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.10_rc4

for you to fetch changes up to ba437905b4fbf0ee1686c175069239a1cc292558:

  RAS/AMD/ATL: Use system settings for MI300 DRAM to normalized address translation (2024-06-16 11:22:57 +0200)

----------------------------------------------------------------
- Fix two issues with MI300 address translation logic

----------------------------------------------------------------
Yazen Ghannam (2):
      RAS/AMD/ATL: Fix MI300 bank hash
      RAS/AMD/ATL: Use system settings for MI300 DRAM to normalized address translation

 drivers/ras/amd/atl/internal.h |   2 +-
 drivers/ras/amd/atl/system.c   |   2 +-
 drivers/ras/amd/atl/umc.c      | 160 +++++++++++++++++++++++++++++------------
 3 files changed, 116 insertions(+), 48 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

