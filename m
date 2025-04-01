Return-Path: <linux-edac+bounces-3455-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7B5A78401
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 23:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620EE1673F5
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 21:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209D520F081;
	Tue,  1 Apr 2025 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VedkH4cJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9972C1E9B3F;
	Tue,  1 Apr 2025 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743542976; cv=none; b=kDMs7+uDy/POKF4tIyZnY23FwaHKyzMtuPjHKxqBDj0NeSJhRvCqEcVKxoXSlFUklcqStgCr4AwbppqF1fGgTkE4iTbdhOV4rrHP84g1wzqx//ZtKl/CyxbhaxrgpfTmLy5i+p85R8JmG2hFumllGLwU1EWqH6TSATgd0MIKXp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743542976; c=relaxed/simple;
	bh=T2+JYAx+5D8Ym3OvFmztopFF5kmSridBqxQ38Di4z5U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=prwchdsW35vw4d7C/JbKkx7qIIjMJ410+kaqH54Q5/iitZCBudGIWNVMzjiKNN0DZPlkbu+Fm6VQVGRSa9BCW1Rr2GBWJLrpW+ZIj71PmzYpKzkHagdl+aX22dK+Sz5wGWUAcdAcMgbmLwgwjNLjce+8h2AjdAv+SkCRfiKuGaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VedkH4cJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C20FF40E0219;
	Tue,  1 Apr 2025 21:29:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kljK5XvfnCw9; Tue,  1 Apr 2025 21:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1743542961; bh=D7jq3FrBQpu6BWFdVkFPOJihlBYfKM2JylTeULktWSU=;
	h=Date:From:To:Cc:Subject:From;
	b=VedkH4cJ0a0EABWSXsoaE/tG2KTOq/A4x6BubxBd7p6aBiqFnPO6IrmdlET+C6Ufd
	 0jZrfdpSEsinANBAqwRSxULPEUP30s+f9gxmT9wKpAyPb+if3as0HoSI5Z8N1UnESG
	 u39f6/6v4pNFv619dijj15L5gISXvUWKzw0Zl5loIsFf02mAO7llkOs32RZ2kgXa8o
	 7Ev3jQZa2v3L4aPvf9okKP4yUdeFvUrH4LNP7VOxA9yZSPm2bLIz8B/UGYSLGJOf36
	 +RzBRxx81rP76XZ9DhnCmd8p4CwNmg7IpQQMUuqdNxWFhFuOacIFUQ5xwY/f2paUrr
	 o3ES9IvCYl2qMK6tc/p+qKJ8HNOhtInPpF7SUKkSxLL9GQWKCmDOyuGYOJqMMZd4Vq
	 o2YdX6mZoWxRIqdHaz6kCnAf0s1LNocR5FFZoDPYBmkCq7b/Z4ioft2lD2ubPoBVLS
	 En9FWyL15f8ET/5ovfGSxVKnrdu+q6ScBOPGOY/q6ir5b0Au+yXl20kpwQroL1jh2y
	 0JSbSkFR9JY04Yh0a22uTUWiSypL6Sx3uwTg4O/n5i2/rKgWtPKHJnR/oUZP+u/s3r
	 faefYm8NM6LN4amVyFE7WbCI0oas1IxWCXJQqyqPl46Bhi5GI3nfzuQ4FKRt3WdJkn
	 RcKvluNhearA5gnvCLoGIeKI=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BE73740E0215;
	Tue,  1 Apr 2025 21:29:18 +0000 (UTC)
Date: Tue, 1 Apr 2025 23:29:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for v6.15-rc1
Message-ID: <20250401212907.GAZ-xao52zj3Enjy8W@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull an urgent EDAC fix for v6.15-rc1.

Thx.

---

The following changes since commit ae8371a46e59d768a5540a237309962b50b8bec7:

  Merge tag 'edac_updates_for_v6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras (2025-03-25 14:00:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_urgent_for_v6.15_rc1

for you to fetch changes up to 212120a164d59fd534148d315f13db3d296efb0f:

  Documentation/EDAC: Fix warning document isn't included in any toctree (2025-04-01 22:26:47 +0200)

----------------------------------------------------------------
- A single fix making sure the EDAC subtree is included in the
  documentation table of contents

----------------------------------------------------------------
Shiju Jose (1):
      Documentation/EDAC: Fix warning document isn't included in any toctree

 Documentation/subsystem-apis.rst | 1 +
 1 file changed, 1 insertion(+)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

