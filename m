Return-Path: <linux-edac+bounces-3220-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344E6A48910
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 20:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6151884607
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 19:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33B5234979;
	Thu, 27 Feb 2025 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eX4CbKoQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8461926F463;
	Thu, 27 Feb 2025 19:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684821; cv=none; b=NJOky/L0DEt2i9q0QEAr1Go2HewaGBkey7XYwNikAqtQ/6UOmMyQ3lyJnymP/AbqL76NrW4XQGWm7IGEQOTlxw5GT0Te/r3AdJsaaWhN24TK7eWmSHi1Z5aEntzZfYxceNUzJ2n//Y4/A8/r/4CzB96m4b3NOQBJ+1NUYy0Vilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684821; c=relaxed/simple;
	bh=arrvYP38zx11lfjkahZduVsESdO1bo/jCLPz9A9XstM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fIvhPLK8npqU2WQPiXX/m6HGcmuSiVhmMIRlAoD4gCZdNiL4wsRHP1uz3aRocsf2FTZcOeBkHQ+Fh0W9M+21rVTaEmb5iuwSNPQaHg1r9D5HtTntv47kHoyHH75y8iuvD+srXj/A2XQHjGjlG7oF7zvnT/jBQAZaDsj/+p2HhHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eX4CbKoQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 78DD840E0202;
	Thu, 27 Feb 2025 19:33:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y_HgbEC5hZ5m; Thu, 27 Feb 2025 19:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740684810; bh=u6SK7poXPKsOx9Gn2T3FfPxaRRScytMW5+TVf8jE29M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=eX4CbKoQL3QeKVZOJctDMwh7Uvy7hXRjCz5Ukypw+7K19VykUvy77FFXvNOUY1UEO
	 7x1ENv+8Zf+AWtSb0fAFd2hot78347336UMSHgS9dzFO6zbwg/+lv/kZUUEDx4BqMd
	 9ELAUefffkbUOarbxDp/KYqTf9d8gKCJdNhOx1Ecy3wx42dnxvvnq1Yaw6g6Ic1B18
	 qO/ZFYYQoeFT2aD6yIx7lSgMJljvWaK7FTY94siAij/eQKlH1uHoCyoWNuosb1uYxO
	 voTkv2sMIz+k9+sbmHf+dVfXj8hSDTC4Io4YY8OYUklPxMV9cnIYPnd51Mb9/UbQMX
	 cdcX0i1mAH35QpweD0k/pnEGydaPtQDsuBvArAOFCqK121ra9Rkia4ugZEcRph50TG
	 ueGT0G5K4VJpAsWRZLgctCSoLD1rF1kWHWtOaTEh8Xtr9lBunwybrgkSs+oSBclP5q
	 oe2DERzVA3Sd41rEm8+4MUeRz6OTR9Y7vUzo2MGFZMkfFm87FfQXJYeRg8LcN3JDU1
	 Eo/wuvy6MZ8rPq4MA10Yhhx8X3QJLVDdmlxzSR/3BJo4j6VSowryT7Np2nb5eqIAmH
	 1BLPfIS+n+3lIsH2H9cKFmryn0h3RzmKlhWHceWBkUrObl77CNEK5hWFb6XNQTackB
	 E3w+pl9WSA8tq4sClgR3huvA=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3033:266:d506:45ad:ba23:3ebb:9784])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E5BBB40E01A3;
	Thu, 27 Feb 2025 19:33:23 +0000 (UTC)
Date: Thu, 27 Feb 2025 20:33:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: x86@kernel.org, Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 06/16] x86/mce: Remove __mcheck_cpu_init_early()
User-Agent: K-9 Mail for Android
In-Reply-To: <20250227163148.GA785742@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com> <20250213-wip-mca-updates-v2-6-3636547fe05f@amd.com> <20250227152500.GAZ8CDzEBRWBUukmcl@fat_crate.local> <20250227163148.GA785742@yaz-khff2.amd.com>
Message-ID: <DE184F9D-EF80-4A88-9275-C900C4AA13D2@alien8.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 27, 2025 5:31:48 PM GMT+01:00, Yazen Ghannam <yazen=2Eghannam@a=
md=2Ecom> wrote:
>On Thu, Feb 27, 2025 at 04:25:00PM +0100, Borislav Petkov wrote:
>> On Thu, Feb 13, 2025 at 04:45:55PM +0000, Yazen Ghannam wrote:
>> > Also, move __mcheck_cpu_init_generic() after
>> > __mcheck_cpu_init_prepare_banks() so that MCA is enabled after the fi=
rst
>> > MCA polling event=2E
>>=20
>> The reason being?
>>=20
>> Precaution?
>>=20
>> It was this way since forever, why are you moving it now? Any particula=
r
>> reason?
>>=20
>
>1) To read/clear old errors before turning on MCA=2E The updated
>__mcheck_cpu_init_prepare_banks() function does this for the MCi_CTL
>registers=2E This patch does this for the MCG_CTL register too=2E
>
>2) To ensure that vendor-specific setup is finished beforehand also=2E

That doesn't answer my question=2E All of the above gets done even without=
 shuffling the order=2E=2E=2E


--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

