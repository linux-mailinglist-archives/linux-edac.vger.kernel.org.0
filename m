Return-Path: <linux-edac+bounces-3184-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70439A40DF4
	for <lists+linux-edac@lfdr.de>; Sun, 23 Feb 2025 11:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD713B58AB
	for <lists+linux-edac@lfdr.de>; Sun, 23 Feb 2025 10:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D272036F0;
	Sun, 23 Feb 2025 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gdvWJm3i"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A71FECC5;
	Sun, 23 Feb 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740305216; cv=none; b=qdZ6ciJCFj6v7vMtCh7JzUAo0i642gOn3YUKQbR6uJb27ZQmz5T3J5g8DG8p5qGfaD60A7+Vi0klGEDpK53m3x+84XzYVr8jmZuhFmU8P1tvHGQqHTTJS3lBXfXk4Czn36OWQb6w94ukNDTfvEtpWR75A050VCVckj9uVewfess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740305216; c=relaxed/simple;
	bh=oSy18XAki1+6x8dW7QY7IgnNHl+k43vT3kfv5uUDAF0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B43s6kQdwK3OFl2TP7bKP8ioXdiYEEQKJKhnk7PeftOI1Sf57g6YVJ67ioysDfLThoyLD3kENrVKebpEa4d4OyW+LihN6hRzX3eSMY17rnCRT9IsuieGiM42L6rzd9UMY9N+dDMdqIoNdcV2TlxneajgIyd8ZtvOXYEvi/V9bSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gdvWJm3i; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D865840E01AD;
	Sun, 23 Feb 2025 10:06:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ty4w8bSL0XT6; Sun, 23 Feb 2025 10:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740305204; bh=2PiOQrVk3cndOooItUZakJvKkilYjGZbUj7JS9r51f4=;
	h=Date:From:To:Cc:Subject:From;
	b=gdvWJm3ipC46PpSR0u9Iyff+k+N+fora2pEXxjEOlIiZ79DP1uNlqXnQ/9oyNDWKd
	 rmh/T/Dm0SZppa/eDkuVCkpv1DFQU9HSHOjvaUVR4e+sJpVl0bRHyLzWVu3roNPX70
	 JlJPEWqwCBYmOc6+MCdPNmgvrU1CbsE2FDm4SjCII9nRRRtE2g075hvifJ05+tbgGi
	 C6k0Vc7ICY/SJPWK97XxB1NAsB2DvD2RFCplX2Vao4zY+m8cNyJm/of9XpGcaQ1wuV
	 3u2o6Cku5s/8LuWB3Kb33u8oQpzMSkCpMcZEmihFHv4CAuc1lZHB8wiMzU8QHQ7znA
	 7drlzgImxrJkxWGDRFT+7tJZ4thexuvoXDA+nl83VPMK8qXI42Saec/X5Zq2EmWpbj
	 BRKczwPH/OCb6IJ0xKkUKUTWkUnWNF7QuviS1I42ZZmut9MJT/Kzu5cPsRQ9nTdn6F
	 MxyXhvWvwXrrIQtMHzKS5oA/CndZT7wQAoNiUF2bbVH96vUq1YKDXSltSGko2iVoiS
	 k+oww7R0OTiImCd9QVNGF/D258uCIpNFXNZoMgQLS5Q58XQ3drFsJZijD3UJ6rI6q3
	 oEZuOmtNXxszGKPyzFjCTpr1OJDQF27mluq1euzD7CLX/x3d6cGjiGKMP1UyzSR8j1
	 HXEdV0i5B6hXwX/bN73kfRXE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80B2640E0176;
	Sun, 23 Feb 2025 10:06:41 +0000 (UTC)
Date: Sun, 23 Feb 2025 11:06:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC/urgent for v6.14-rc4
Message-ID: <20250223100633.GAZ7rzKTBKLL0-bqMn@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a single EDAC urgent fix for v6.14-rc4.

Thx.

---

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.14_rc4

for you to fetch changes up to c158647c107358bf1be579f98e4bb705c1953292:

  EDAC/qcom: Correct interrupt enable register configuration (2025-02-14 20:36:11 +0100)

----------------------------------------------------------------
- Have qcom_edac use the correct interrupt enable register to configure
  the RAS interrupt lines

----------------------------------------------------------------
Komal Bajaj (1):
      EDAC/qcom: Correct interrupt enable register configuration

 drivers/edac/qcom_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

