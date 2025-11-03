Return-Path: <linux-edac+bounces-5291-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1A4C2B845
	for <lists+linux-edac@lfdr.de>; Mon, 03 Nov 2025 12:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07C8C4F5636
	for <lists+linux-edac@lfdr.de>; Mon,  3 Nov 2025 11:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B95303C93;
	Mon,  3 Nov 2025 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OQDSrCz8"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5449B303CAF;
	Mon,  3 Nov 2025 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170298; cv=none; b=X88dFDMBUZrIFM8A6L6sDqp8up31HDsfuvbimwZamVJjxs+wNCEnX9bOlWfDFddW75AbFajdpswoSirWznSoTbvsXBZpWHT6m5v6GNpP/rCPPlP2WC6gr9as5L652Gx5kjSXL6YLFaABafKrRBIkyCRDvjZwcyDpC6ZmEM/jc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170298; c=relaxed/simple;
	bh=t5aGrmdF4tQP/CQ2jddNepY+udXSidizPHnsMs1PxKM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kapEZjQ8YvYf/QAKGq1h/LGRXJWX6N8quU/n0L4k9HmDD1WQm5cvk3l3GRxWmuZMhc8nM/EEKFoq0KVQE8gpQ+ZkXeuoRjjstad53DwUfF/yUcdo3Nf1tnlj2vurdyI5UVd19EPIQ4HmHBu2iuD0w1OHM84jq83R/XB2gsbKHkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OQDSrCz8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ACC8C40E01CD;
	Mon,  3 Nov 2025 11:44:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cBmXYK2guAcO; Mon,  3 Nov 2025 11:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762170288; bh=TL7DpLIYhTptquzV2zwiU5VgxMPOQvNuyzCHiDkFPBI=;
	h=Date:From:To:Cc:Subject:From;
	b=OQDSrCz8tqt8eA3S4LE6KH9OLsTrCIWXP5/oX1Esl4s1WFd9EyZiqpLbIFB92HlzS
	 3wTQiRbNgvUlWNmecRUAf9SbPup1fjhoEifW4tAKPNjz+x2SYKGLpFmv6TiR/aLwxE
	 0ccjXonWZh5CHwuldNOuvkHlAlrrpADqKYljLzHR2wsMEbWigf+mAvm0XMsDI0N5s9
	 6K8XAUFxt5l9BaOVew54cukFeebGu7a7jt88KrJbA7sEk4HkXooRyCS/w9xJrHI4jR
	 zOzgJRRHqaOdDb5VMVVyV26KjsaMeQVc5wDwxMsR5v9fgvmk5xAFYLAs7FEQzG+bC7
	 1xs9AVE8HdfQLvqgOhJjrm+CYC7ML4Z8OPOGBcnuNpxzJMI94mAlhx7BMpgLVks0zv
	 H4seRjFhs1LQBI4b5rYshGINm21wEVu9PgJWbxsiLaRoDVMO9I+jP7bPhJ/QJpbo8W
	 N8P9nYhyBZ0d0MRDuUrdXrjvf6T8JH0BQ9eYqkqR+kLwvOWm+dHRuUknHWWK8aG3Fr
	 +gAGYUdI5Z2dqdknC11Eic4yqjYjRBInObFG5M/lMO8DxmFlVAqxK9qIj2UFxth1Tk
	 KaaI9aNG61CgsTstMqjg48pk1VQvGd3qbojdDzDC9ILaV135Z154bqt6olBXx1mVYv
	 qEzzDLBp64DFY6E+QkDI4zdA=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 2C89940E019D;
	Mon,  3 Nov 2025 11:44:45 +0000 (UTC)
Date: Mon, 3 Nov 2025 12:44:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for v6.18-rc5
Message-ID: <20251103114438.GAaQiVpgXgECnocHvE@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull an urgent EDAC fix for v6.18-rc5.

Thx.

---

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.18_rc5

for you to fetch changes up to 79c0a2b7abc906c7cf3c793256c6b638d7dc477f:

  EDAC/versalnet: Fix off by one in handle_error() (2025-10-13 17:14:47 +0200)

----------------------------------------------------------------
- Fix an off-by-one error in versalnet_edac

----------------------------------------------------------------
Dan Carpenter (1):
      EDAC/versalnet: Fix off by one in handle_error()

 drivers/edac/versalnet_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

