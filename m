Return-Path: <linux-edac+bounces-3822-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9676DAA85E2
	for <lists+linux-edac@lfdr.de>; Sun,  4 May 2025 12:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29C73B5923
	for <lists+linux-edac@lfdr.de>; Sun,  4 May 2025 10:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528BF1A2381;
	Sun,  4 May 2025 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WREyH1if"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BEB3597E;
	Sun,  4 May 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354112; cv=none; b=ZxgjHu6oNC29+iOG8XqgEXyPPgpndV0nMqDFkHbHrclrMzO+GcaRkZ6SMb5EfFNjqlQibVPIEpetos5mmEgZiryMkFnZ5jKT9MZs9MfNO01QFIOgKazRhX67+pXrrBqmI3DQ3KmU+s/O2rTTXi+VI/YSV4F77N3k3PzTIk3i3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354112; c=relaxed/simple;
	bh=R0+kP0V9GqTcqrFB9+kBbmLscqAF4uAt/oWjzFf466U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XueAWdP6orj1LDIbAJ+emMA8phedeeAIpxr6lszScvG+cI0cKbSBSXzXpkAiobZ6IfmbbPFKPzmwCjE6Kwn2CrAwIsD5ZWEahwu1e9vY8SN9Nwml0scmff0Xv2hUHdH8H85xjsQ6cLzFCw4raaP9P4x5mzCtKNUjRud7KQaE8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WREyH1if; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CF4BB40E0222;
	Sun,  4 May 2025 10:21:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Gfzxt_oBFv7e; Sun,  4 May 2025 10:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746354103; bh=Oe8Jm9A1eez88U6KkWZnuM9occZIORvr9c2rcqvhIZ8=;
	h=Date:From:To:Cc:Subject:From;
	b=WREyH1ifapTfvpFtzX0HD/Gx2fmf9SD4FLHo1+N2NPR42EXTjsIPs9AMqE6JHG9Gf
	 K14fIRAjOCdlSYKcScGZ0dd6a35uebs9U8BO0GCRc8FmjUE7OknF89hZ3XuzeLbuSU
	 tyYpQpbKwhixvwq78yLwxKZSINQwuauUaetgZNU/Jf0b+JZaoQ/uyXOvgn7KUC8FWS
	 RpnRcJEToz8GfRERldKo7DT+6yLM4R+FclGYg+LEOL8Y5bpY0Omk61CRb7qkUBA7Qx
	 /mmVKBoLs/lTYvJ1oda5wpVQTrcRgECM+N1XzcsVxJ0o8FdTqKafELs/41z+b/hOwk
	 UTtk0gTtn/jfxZT0/M0dTb/PCmIyOr6qXM2ujAJ4Mc2ZkicrlYEYSB2kxSDM1Op2wW
	 dzz5R9D4cxIMh8xUyiRYH1LBLoUbk6dPrAqzw2a0c12rtDjcR+dkl7FMlJyeMRodRG
	 9HNxtQhsau3AILSHsRTgAdqM5SfRoAztgBJq11bVmUv5XZQ+XkBVjMatMkedaR3YK1
	 3UHlhmr58zW+8UxVFjqKC+2fOzJgvSR//hZnn5n0PseLC0/9NgyhV9UDtOE+YISmLb
	 /Hila9wHZMmdisIlPB0IMhZ7DFZRFUlMcByFAYUagydn9YCUD/tC8wtpi1jX8dat+i
	 eoj0qERhWB3R2IXQMF1pzSLg=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BDE1340E015E;
	Sun,  4 May 2025 10:21:40 +0000 (UTC)
Date: Sun, 4 May 2025 12:21:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC/urgent for v6.15-rc5
Message-ID: <20250504102133.GAaBc_rTClPZmy75Rm@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull two urgent fixes to the Altera EDAC driver for v6.15-rc5.

Thx.

---

The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:

  Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.15_rc5

for you to fetch changes up to 6dbe3c5418c4368e824bff6ae4889257dd544892:

  EDAC/altera: Set DDR and SDMMC interrupt mask before registration (2025-04-28 12:38:53 +0200)

----------------------------------------------------------------
- Test the correct structure member when handling correctable errors and
  avoid spurious interrupts, in altera_edac

----------------------------------------------------------------
Niravkumar L Rabara (2):
      EDAC/altera: Test the correct error reg offset
      EDAC/altera: Set DDR and SDMMC interrupt mask before registration

 drivers/edac/altera_edac.c | 9 +++++----
 drivers/edac/altera_edac.h | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

