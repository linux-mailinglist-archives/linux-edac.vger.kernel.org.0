Return-Path: <linux-edac+bounces-5697-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJzzDcvniWmdDwAAu9opvQ
	(envelope-from <linux-edac+bounces-5697-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 09 Feb 2026 14:57:31 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 759B410FF15
	for <lists+linux-edac@lfdr.de>; Mon, 09 Feb 2026 14:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF75C30069A9
	for <lists+linux-edac@lfdr.de>; Mon,  9 Feb 2026 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1AD379992;
	Mon,  9 Feb 2026 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="c4hbmKxT"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA5537998B;
	Mon,  9 Feb 2026 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645445; cv=none; b=E4XZOeu0t3zhY30jQ3jmwaWzFVtxLoYXsrtjypWBMeypbIjIqE+yeUImRBAG0jwXPHIX84KrAIov8Ovcw7J5CXXSRE9vnuIh1pvP5nWbkP/Txp03Bp55d6b2ZUEIJgM7oUCID0DxNsYQ14QN8wcpq8uA9ozWkAShVCyrx3WwNq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645445; c=relaxed/simple;
	bh=CngMrntDJ0cZTWdrJ83MtPFq1otjQIjzoKieZ++NUGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EfJPRiawK2GjIfoB4r/PzVycUwLEmOLCcOtV7ZUVIbQ7gd1DgUFGnkP8yyIJQjTGSlvEtAEQfEfhWRLqMdElmWIhjb+2Tyw3NgTppOFTKlNT3XkGUTUK+1ei2AjH2SHTy+u2ApaNGFpqHTkWrFxcRutXIhxJYeO2rGYbzqSVjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=c4hbmKxT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 13F2740E0364;
	Mon,  9 Feb 2026 13:57:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CegZY5iq-aXq; Mon,  9 Feb 2026 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1770645439; bh=JvP8GL6tW8urGdlYM6YPpvXrducD5sK1N1m2vgkSwlE=;
	h=Date:From:To:Cc:Subject:From;
	b=c4hbmKxTzqHVx88ZmRE4LH/1rZKHdTV2X72U/kCTua1p1ySD6gJvrNvgz8sMIl5ox
	 ssnCaLpMLjwQfC9p3CfHMh9Ui/t/wk0q75BRm9wUpIO35mRmopCya5J4AlGc/vTh60
	 oayZiMFMykEcoEftmWAc+huG61PH6gbvvnLItZf02bUy8s13/IpGPPSowyoT5abxj0
	 cPOuQoWsgePwpa3gqf86+dYcOqbmjumzsx08g7smzv3ZJ/GJXEBNYF6jzSH1wNaiAa
	 2JSwDZvPD4sQiD4E7FA6ov6DqFXn9JOswYWk5mSvHYLlHrS/oRTv+VF3j+erlt5Q3R
	 SPhZCM2Iw/7AhiIa5FlNKYApo/X7QUGNfkEf1O1CZyyFniC+5+9VI9FrUcSDfpSCYZ
	 NeAmwskkNYRO1SMXnivegUekC2g7+gmrdYwQg5UQHIBMaqLoJASyLYKyNYq3BtA7CH
	 Umc4458Er4d7K7g6rDTiJp6ItaDc6FZ9u1Pad3EJmB3NTOVAvyzRklJRCydwOft4mC
	 diV4ImScqpxh8MULYNL4zyNRe/h/lD6bqIU53ttn+p0mgmgSABzG4DweaVqsT1p6Rk
	 8TaMQWDYzXDGR94+yPv80qNXQnjex+C2+x/hreO+1zsTFO6Fl2J1df0e2CRgvmoKz/
	 p0GFwVDJmXtfq3Urb+lEd+Ag=
Received: from zn.tnic (pd95306e3.dip0.t-ipconnect.de [217.83.6.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 72A8540E02E5;
	Mon,  9 Feb 2026 13:57:16 +0000 (UTC)
Date: Mon, 9 Feb 2026 14:57:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v7.0-rc1
Message-ID: <20260209135708.GAaYnntIzX5fP95e9T@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-5697-lists,linux-edac=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-edac];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alien8.de:dkim]
X-Rspamd-Queue-Id: 759B410FF15
X-Rspamd-Action: no action

Hi Linus,

please pull EDAC updates for v7.0-rc1.

Thx.

---

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v7.0_rc1

for you to fetch changes up to 5b115dccdc8612cd892c41354e63fd5b23d56c51:

  Merge remote-tracking branches 'ras/edac-drivers', 'ras/edac-misc' and 'ras/edac-amd-atl' into edac-updates (2026-02-09 13:49:36 +0100)

----------------------------------------------------------------
- Remove two drivers for obsolete hardware: i82443bxgx_edac and r82600_edac

- Add support for Intel Amston Lake and Panther Lake-H SoCs to igen6_edac

- The usual amount of fixes and cleanups

----------------------------------------------------------------
Arnd Bergmann (1):
      EDAC/amd64: Avoid a -Wformat-security warning

Borislav Petkov (AMD) (1):
      Merge remote-tracking branches 'ras/edac-drivers', 'ras/edac-misc' and 'ras/edac-amd-atl' into edac-updates

Chen Ni (1):
      RAS/AMD/ATL: Remove an unneeded semicolon

Dan Carpenter (2):
      EDAC/i5000: Fix snprintf() size calculation in calculate_dimm_size()
      EDAC/i5400: Fix snprintf() limit calculation in calculate_dimm_size()

Ethan Nelson-Moore (2):
      EDAC/i82443bxgx: Remove driver that has been marked broken since 2007
      EDAC/r82600: Remove this obsolete driver

Lili Li (1):
      EDAC/igen6: Add more Intel Panther Lake-H SoCs support

Qiuxu Zhuo (2):
      EDAC/igen6: Add two Intel Amston Lake SoCs support
      EDAC/igen6: Make masks of {MCHBAR, TOM, TOUUD, ECC_ERROR_LOG} configurable

 CREDITS                           |   5 +
 MAINTAINERS                       |  12 -
 drivers/edac/Kconfig              |  15 --
 drivers/edac/Makefile             |   2 -
 drivers/edac/amd64_edac.c         |   2 +-
 drivers/edac/i5000_edac.c         |   1 +
 drivers/edac/i5400_edac.c         |   2 +-
 drivers/edac/i82443bxgx_edac.c    | 462 --------------------------------------
 drivers/edac/igen6_edac.c         |  89 +++++++-
 drivers/edac/r82600_edac.c        | 426 -----------------------------------
 drivers/ras/amd/atl/denormalize.c |   2 +-
 11 files changed, 86 insertions(+), 932 deletions(-)
 delete mode 100644 drivers/edac/i82443bxgx_edac.c
 delete mode 100644 drivers/edac/r82600_edac.c


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

