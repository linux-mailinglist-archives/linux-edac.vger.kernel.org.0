Return-Path: <linux-edac+bounces-4456-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 815C0B13CE9
	for <lists+linux-edac@lfdr.de>; Mon, 28 Jul 2025 16:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A828C3A79A5
	for <lists+linux-edac@lfdr.de>; Mon, 28 Jul 2025 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E702BD04;
	Mon, 28 Jul 2025 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DS2MzbO7"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67E3252906;
	Mon, 28 Jul 2025 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712144; cv=none; b=DZzb6nznZ9Oyq20zu29shu/S/J1CLvXTMR1eUxfIZxeZVUPXnCfYwGELznzcQLT8RAxFx94asUh908JiZ5bwJ2QjJ7CDs2v4eJ7guA4Gn4uMaQ5zyofBtzAubrVWlODDsugEa/0blvEBgkn/hGA6cQPaEPRvQTct20dJ8XDV69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712144; c=relaxed/simple;
	bh=dtu3KlJUWUhrvmA8qAJUbEP/cmxhlgR0WbIpvIOqiX8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qOk7jkranqEgbZVfatb6qtV/lwSIJgSiEg/fH7jwCuddaEh9nBluuGXM7oSPZqe8kRiLhZVvN1nJ2+tvYz1lWQykXbUCUfLaBpzZMgKrjyy7SNRIVfwPZrkaLxb0z642rL77X1U10dSU5oexg62EpAGo4h6S9eWQJ/uRScQJbSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DS2MzbO7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AAF0340E0257;
	Mon, 28 Jul 2025 14:15:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IRVijsMAJqhA; Mon, 28 Jul 2025 14:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753712133; bh=ez8QcFfxV1IA6+WZpvqSuMttUA8cEfmeY7NaeczZ+Mw=;
	h=Date:From:To:Cc:Subject:From;
	b=DS2MzbO75i+Lpycdjv8k32CtvWmpLMedpuQsw5okhMV3iKk9Wjo5Qvudwro1RT2/M
	 OXpW4zT08GYnWa9RucY+J20cO5J7Kuf0DVMGdEH1P3CUlCyRT+7CvK7RGunoJh9i0+
	 HuLMI7SoMO06vO2ytoE96kEpd8aFSdG38dkMk1bnum1XBx5xt4fGrk1Te9XqeP9j5p
	 QjQK+vzcXRrOkROp5CAw8GMrH6v67nGH+phnxdMuQqHUAyjE/uJWJ53QsXaUJltjr8
	 oYPUZkk6JybZaLezUDe2Q+1Yjsrb3ExKi+tid4k7b56HLxD2fg7Yz2rKv/a43tzvXn
	 LgIZlz7poQYzss8rK5N5vensddzB8dIf6ERs47r14DsZMjIzT3SPYvz7ptLPNSUAN2
	 LdOvtOVRP+VaG/7VNU7jwYOIIT3yJ7cz0XCWNJ0rjK0tRkrvWzaKJKiETt3doGQFkF
	 ka+ksMBnXE+457K0uQocIU/GozBA4GdGR4e2AxaXB/SCj8LCq/OLUDvvYG0J45z8Nl
	 REEI9fCM69Twt+ciGwR7QlTDgp0LqCrlbesd0Xwk67fJVCeYVqR7NuqQYfyGHpzEzd
	 36aFi1ZrZq4EyKP7stE3ynKxBbbI/U/mxYO86u/f+LMv6wuwE2kUIXXGoqfzjikBcp
	 usdvE0crHDZ4S68yGzpCZzvM=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF19840E0256;
	Mon, 28 Jul 2025 14:15:30 +0000 (UTC)
Date: Mon, 28 Jul 2025 16:15:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v6.17-rc1
Message-ID: <20250728141521.GAaIeF-XYJVbfOQdT6@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the EDAC updates for v6.17-rc1.

There's a small merge conflict with upstream, I've added the resolution at the
end of this mail if it helps.

Thx.

---

The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.17_rc1

for you to fetch changes up to 35928bc38db69a2af26624e35a250c1e0f9a6a3f:

  EDAC/{skx_common,i10nm}: Use scnprintf() for safer buffer handling (2025-07-15 10:06:58 -0700)

----------------------------------------------------------------
- i10nm:
 - switch to use scnprintf()
 - Add Granite Rapids-D support

- synopsys: Make sure ECC error and counter registers are cleared during
  init/probing to avoid reporting stale errors

- igen6: Add Wildcat Lake SoCs support

- Make sure scrub features sysfs attributes are initialized properly

- Allocate memory repair sysfs attributes statically to reduce stack
  usage

- Fix DIMM module size computation for DIMMs with total capacity which
  is a non power-of-two number, in amd64_edac

- Do not be too dramatic when reporting disabled memory controllers in
  igen6_edac

- Add support to ie31200_edac for the following SoCs:
 - Core i5-14[67]00
 - Bartless Lake-S SoCs
 - Raptor Lake-HX

----------------------------------------------------------------
Arnd Bergmann (1):
      EDAC/mem_repair: Reduce stack usage in edac_mem_repair_get_desc()

George Gaidarov (2):
      EDAC/ie31200: Enable support for Core i5-14600 and i7-14700
      EDAC/ie31200: Document which CPUs correspond to each Raptor Lake-S device ID

Lili Li (1):
      EDAC/igen6: Add Intel Wildcat Lake SoCs support

Qiuxu Zhuo (4):
      ie31200/EDAC: Add Intel Bartlett Lake-S SoCs support
      EDAC/igen6: Reduce log level to debug for absent memory controllers
      EDAC/i10nm: Add Intel Granite Rapids-D support
      EDAC/ie31200: Add Intel Raptor Lake-HX SoCs support

Shubhrajyoti Datta (1):
      EDAC/synopsys: Clear the ECC counters on init

Wang Haoran (1):
      EDAC/{skx_common,i10nm}: Use scnprintf() for safer buffer handling

 drivers/edac/i10nm_base.c    | 30 +++++++++-----
 drivers/edac/ie31200_edac.c  | 38 +++++++++++++++--
 drivers/edac/igen6_edac.c    | 17 +++++++-
 drivers/edac/mem_repair.c    | 56 ++++++++++---------------
 drivers/edac/skx_common.c    |  4 +-
 drivers/edac/synopsys_edac.c | 97 +++++++++++++++++++++-----------------------
 6 files changed, 140 insertions(+), 102 deletions(-)

---

Merge conflict resolution:

diff --cc drivers/edac/mem_repair.c
index 70a033a76233,2e4e790e0ffe..000000000000
--- a/drivers/edac/mem_repair.c
+++ b/drivers/edac/mem_repair.c
@@@ -331,11 -319,10 +319,11 @@@ static int mem_repair_create_desc(struc
  		return -ENOMEM;
  
  	for (i = 0; i < MR_MAX_ATTRS; i++) {
- 		memcpy(&ctx->mem_repair_dev_attr[i],
- 		       &dev_attr[i], sizeof(dev_attr[i]));
+ 		ctx->mem_repair_dev_attr[i].dev_attr = mem_repair_dev_attr[i];
+ 		ctx->mem_repair_dev_attr[i].instance = instance;
 -		ctx->mem_repair_attrs[i] =
 -			&ctx->mem_repair_dev_attr[i].dev_attr.attr;
++
 +		sysfs_attr_init(&ctx->mem_repair_dev_attr[i].dev_attr.attr);
- 		ctx->mem_repair_attrs[i] =
- 			&ctx->mem_repair_dev_attr[i].dev_attr.attr;
++		ctx->mem_repair_attrs[i] = &ctx->mem_repair_dev_attr[i].dev_attr.attr;
  	}
  
  	sprintf(ctx->name, "%s%d", "mem_repair", instance);


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

