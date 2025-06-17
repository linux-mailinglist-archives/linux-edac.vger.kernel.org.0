Return-Path: <linux-edac+bounces-4150-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E530ADCA1C
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 13:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8C03B8C4F
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 11:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714182DF3E4;
	Tue, 17 Jun 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dYepOE+V"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7197E21C9FF;
	Tue, 17 Jun 2025 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161449; cv=none; b=V90T9+kjISPpomnDBWJBkuE7Me7TQe/As2j6CI+pyd2YwxVrKxmSWpaH/tHjhDg8S2XcGmk8fCZGiDmStGjGK+8RG7cZUASlG6b6oRc75VDD0HQlCufz1AWLrBOyrOQ2LK7bZLqEofLd24S+/O9RSf5eYz2eGEcoHiluJ5P6l+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161449; c=relaxed/simple;
	bh=4CWH84s/vbMvl+7mHb9dxsSh1ip7Ask5yz2SszX7VcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D07n93rIVWA6cw+pTMOmwbQqFo4vVRIHsLZu2pP9GQuv+/MhXty79l2Pa9kJqTQKTSlQ3geNq30wHZG3wjqCgUFmD6Q41fKmdesq/JSbvxTBvo0j0yYUvFgQ2Ndxls0iNIriudLXvmxlAYu4Hlb/Oh/d52Ic/yN5MrSNLG2/jWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dYepOE+V reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 46C6340E01D5;
	Tue, 17 Jun 2025 11:57:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4X2rHHTjtZGw; Tue, 17 Jun 2025 11:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750161438; bh=gYPjxW0HE2/iw3t36362GrrAge3Xkp6XlXwNcMsp5WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYepOE+V36wvr5fZa+NzB5B04H9V3yZgtbAgdNRrjMFm/yVQmB+IUAnjB0snrrkjn
	 ihg9riD2GqhqIQ0CBqhI/Nm6Jehn17Atav/54fl6lxnSLc1rZ0HF87k6CA9ckyxTE3
	 2n6q02pIPsUhKRlYCwffGq6YgyGorWQrsHHZGeUn47Hyfu5xaWf7NUnJWk5LMDhrRF
	 gH7MR7B/xyNOJ9Nt8r9rOl2mXfbP1eCw5Vw74fwwnvRt8rxC/+Mc2LtHMgjzeUEXVh
	 EOFQsU4GNgFkr121QEwCIrETdqC7SODQq3vYfBeD6PVXYUuWzklsaKHHO3o7dDVNlk
	 Wy8qe/BiDtm8m3vJ5IcALCQFWacTOsoDq7Ge+M6mvO83CkVLecdRJt0QVygCVxVgdE
	 5TzO53LaiB6CAI+DYHdaom32a7nv+LMuldblinzPzgwK2+bjRHdacJyQHWlKCuKHmv
	 Ivqnv8wLCp7gSp/WZZQu/1tRyDy8nOUpNDXV/V64FTOdWplEc/l0aQoI8tEK8T7ME6
	 B6h0hm0MBLSfMfbWLo99oc3bSzS6Y1MdvEeVPcHpflpB90AAR06WqfoWFvJeFYaWcu
	 f9NrOoSH+SzC7HbiC3gYxKXdGczDCVXVppvbN+r7NgWcDcW1f0+3hjKLepdhdMp2QS
	 c+BaQDEErWklVysSGXk/pdY0=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A9C540E01B3;
	Tue, 17 Jun 2025 11:57:13 +0000 (UTC)
Date: Tue, 17 Jun 2025 13:57:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	"open list:EDAC-IGEN6" <linux-edac@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: NULL pointer dereference in igen6_probe - 6.16-rc2
Message-ID: <20250617115707.GBaFFYE61vYHNuAkxR@fat_crate.local>
References: <aFFN7RlXkaK_loQb@mail-itl>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aFFN7RlXkaK_loQb@mail-itl>
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 01:13:49PM +0200, Marek Marczykowski-G=C3=B3recki=
 wrote:
> [   13.562085] intel_pmc_core INT33A1:00: Assuming a default substate o=
rder for this platform
> [   13.562682] intel_pmc_core INT33A1:00:  initialized
> [   13.565035] EDAC MC0: Giving out device to module igen6_edac control=
ler Intel_client_SoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
> [   13.565746] EDAC igen6: Expected 2 mcs, but only 1 detected.

Well, folks, if you've detected only one memory controller, then work wit=
h
only one and do not kill the machine:

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 1930dc00c791..23e26ba2d49b 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1350,9 +1350,11 @@ static int igen6_register_mcis(struct pci_dev *pde=
v, u64 mchbar)
 		return -ENODEV;
 	}
=20
-	if (lmc < res_cfg->num_imc)
+	if (lmc < res_cfg->num_imc) {
 		igen6_printk(KERN_WARNING, "Expected %d mcs, but only %d detected.",
 			     res_cfg->num_imc, lmc);
+		res_cfg->num_imc =3D lmc;
+	}
=20
 	return 0;
=20
---

but then that cfg struct is const :-\

drivers/edac/igen6_edac.c: In function =E2=80=98igen6_register_mcis=E2=80=
=99:
drivers/edac/igen6_edac.c:1356:34: error: assignment of member =E2=80=98n=
um_imc=E2=80=99 in read-only object
 1356 |                 res_cfg->num_imc =3D lmc;
      |                                  ^


Unless it is some gunky crap this coreboot does - then we will have to ha=
ve
a longer talk.

:-P

Thx.


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

