Return-Path: <linux-edac+bounces-4814-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263EDB5A332
	for <lists+linux-edac@lfdr.de>; Tue, 16 Sep 2025 22:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E53461CDF
	for <lists+linux-edac@lfdr.de>; Tue, 16 Sep 2025 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266AE32E2E9;
	Tue, 16 Sep 2025 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="PpSCS88b"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDFD2F9D85;
	Tue, 16 Sep 2025 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054485; cv=none; b=styfuh2wqyI04qAwUqIt/buoQ3MPRZoRO25TaNgwws8D7A4MSOy56rlogvJ/POWPtZuRrZRAKiOUO3nkAG/EeMSxnOMvD9eVzZI/4eOSbfQCEDuzOj8OsFlovfH+iWHc96605IA5AlOUwQAH4w/3onwKOI+2KG9sSJLhgAdpJkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054485; c=relaxed/simple;
	bh=grvBtZCWMxKeQ1DTFfErTrYUhvK+RcaOr8GI6t/UXyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CHvDSUaBjE8IJQ/KD+h/4ot4dilT2j2KwjtIf2wVTl9lDM7HxRCaB7bYD05Ubr2UDbzK7i2F2LSBoBQyDdDHzmNEoD8b37U/wXxExYWOR2aXC9IGdWrDmbCUeMQkm1BsDh3Rnfq3Y3giM5Oc682wLuNO67ohyxX/+jxkUDP3wqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=PpSCS88b; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758054459; x=1758659259; i=spasswolf@web.de;
	bh=+JrxHG/MJnEc/i2OimA0UNqPtzvaS8RjcL09hqgsEWo=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PpSCS88bjCKL5dBOmP4JoCrY0J3hC7QrjROdvCONi8Y4zSbgpmDZ5SACqgljqpr/
	 J1DO1qPmBRX8E6LV1FwLr9hprENnB0JrO/LobqwiAqeaphCK0+GdSCeXopB0JVL1p
	 8u/52aOi24Z+Sp0QCdhVeT+kct5VeKiLkbCszt23A7UyKFv0bTAh7SCk4AGHqqQew
	 32EmT6rpbELqDVSERkXHivDHheMLj+Oc13e4PydhAymZQEtRZZxi+pNp54Dx9i2Dk
	 35NFQXpoRtKfP8jYaiFCdnbdO/fGRwHKF4Jh13bIppKjxwSP+P/c9qnPbGOCno8Fn
	 q8d8JFwOZ9r6l8cIYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pUQ-1v2Tsz2mQY-004hG3; Tue, 16
 Sep 2025 22:27:39 +0200
Message-ID: <9488e4bf935aa1e50179019419dfee93d306ded9.camel@web.de>
Subject: Re: spurious mce Hardware Error messages in next-20250912
From: Bert Karwatzki <spasswolf@web.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-edac@vger.kernel.org, 
	linux-acpi@vger.kernel.org, x86@kernel.org, rafael@kernel.org, 
	qiuxu.zhuo@intel.com, nik.borisov@suse.com, 
	Smita.KoralahalliChannabasappa@amd.com, spasswolf@web.de
Date: Tue, 16 Sep 2025 22:27:35 +0200
In-Reply-To: <20250916140744.GA1054485@yaz-khff2.amd.com>
References: <20250915010010.3547-1-spasswolf@web.de>
	 <20250915175531.GB869676@yaz-khff2.amd.com>
	 <45d4081d93bbd50e1a23a112e3caca86ce979217.camel@web.de>
	 <426097525d5f9e88a3f7e96ce93f24ca27459f90.camel@web.de>
	 <20250916091055.GAaMkpn72GrFnsueCF@fat_crate.local>
	 <20250916140744.GA1054485@yaz-khff2.amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lyox2kB2rryLlIbmmttgdjE3nk1mLurtMDpPlNLoZv1LbWMVvCZ
 edkXP0oWcQNmbFle5TXoc1yjlYrWWFu/b27JKeIJ+MwH2vU0k99ldWICuYEis8A1dowuwrY
 T0uneC6MsL5wfJwUZd6W65yJC0VWU3pRqRP+uoW+qBe0FJBaSQcoAqgFW5SUJXNAZT+65WK
 OStYEyexa/Bb0VIw2GLkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MKUNAu8FFZo=;BRwp8cB/Ono7TKty5Riv/2ZRzLs
 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
 O0ODb3pETJ

Am Dienstag, dem 16.09.2025 um 10:07 -0400 schrieb Yazen Ghannam:
> On Tue, Sep 16, 2025 at 11:10:55AM +0200, Borislav Petkov wrote:
> > On Mon, Sep 15, 2025 at 11:43:26PM +0200, Bert Karwatzki wrote:
> > > After re-cloning linux-next I tested next-20250911 and I get no mce =
error messages
> > > even if I set the check_interval to 10.
> >=20
> > Yazen, I've zapped everything from the handler unification onwards:
> >=20
> > 28e82d6f03b0 x86/mce: Save and use APEI corrected threshold limit
> > c8f4cea38959 x86/mce: Handle AMD threshold interrupt storms
> > 5a92e88ffc49 x86/mce/amd: Define threshold restart function for banks
> > 922300abd79d x86/mce/amd: Remove redundant reset_block()
> > 9b92e18973ce x86/mce/amd: Support SMCA corrected error interrupt
> > fe02d3d00b06 x86/mce/amd: Enable interrupt vectors once per-CPU on SMC=
A systems
> > cf6f155e848b x86/mce: Unify AMD DFR handler with MCA Polling
> > 53b3be0e79ef x86/mce: Unify AMD THR handler with MCA Polling
> >=20
> > until this is properly sorted out, now this close to the merge window.
> >=20
> > Thanks, Bert, for reporting!
> >=20
>=20
> No problem, thanks Boris.
>=20
> Bert, can you please try the following patch on next-20250912?
>=20
> I expect that you will see the "debug" message, but the regular MCA
> logging should be gone.
>=20

Applied your patch on next-20250912, these are now the only messages
I get from mce:

[  333.337544] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa08000000=
00
[  333.337556] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[  661.017608] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a941=
3b
[  661.017619] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa08000000=
00
[  988.697243] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa08000000=
00
[  988.697250] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724ab88000000=
00
[ 1316.377571] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700a288000000=
00
[ 1316.377582] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8400aa4800a741=
3c


> Also, we haven't been able to reproduce this issue yet. So thank you for
> your help. It's much appreciated.
>=20
> Thanks,
> Yazen
>=20

It could still be a hardware error, I'm also going to run memtest86+.=20

Bert Karwatzki

