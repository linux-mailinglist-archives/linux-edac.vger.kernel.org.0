Return-Path: <linux-edac+bounces-4153-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7FCADD0B7
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 16:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2091E1892F08
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 14:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13F8220F58;
	Tue, 17 Jun 2025 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="U6NqjxsW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BE021B195;
	Tue, 17 Jun 2025 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171930; cv=none; b=JRe1vZuJw0BUFUi4HxxqUat1WO2cgDeyJkVvigr4Qx0XWU4Ox43EqpBwy0wmu52w7tfiYQQMQZiGjTmdDdVrPZ+YeQWGVZ93tG5TtPb+vDf2MTuPdwzhAXR43WbkcWsl/VTGm9J1vhrkGs3EelfIlpAY1ORtIwqOBuP/Yta5KSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171930; c=relaxed/simple;
	bh=VsX4BK5co1HC6Jug9KwYzKm9GLrnoOFDIzHije9R4O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STKqEQ5M/j+5OL7XAznkB+y0WZ8XkUCRZQU83txTF6f9MsCXiVh/L9ifomJ7L4MAnGvs0qmd1Cnl3AXNeg8RZoDBfAptoXtWXiDxn3MfkQx0+oiQp9uIn1ymINRytjiai1pFqy7c3QkdDAmsrRikaRAfMj4MkABYVJWdEBgpM0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=U6NqjxsW reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 68E2940E00DD;
	Tue, 17 Jun 2025 14:52:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iZ_vovgaj2_k; Tue, 17 Jun 2025 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750171921; bh=4ml0rmeUNs5rZ2x1hKl+QU0ujpUUnFpHGuedE0DaH8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6NqjxsWEin738TaCub5Tc3fq7XrJ5LUDAkq2tZnvXgmvLYSHq6xzcnTUrKgaDeu1
	 j/Bat/c/ugqL7rC42R9az7KmQSRhtFm6sBcTu2dcLWfT7bJS7S9aAKQWwk0BEi50KX
	 LF/ds1jSTw43y8lj7q9EhD5r2tN/VjcuAT+lTDFNJLaMACvss3KJC134yLOv+3v4vb
	 wCtnlUFlGT0lnAnRYQ7v/PCA5WCNINhifVBpdTsj5CwwyWUPOolNDhONLDkukrMA1g
	 p1sfa6C8Y3EJYnK/Zt3fFSB6qjYJNVU8oh4lJbpDWjibe0wyzO9RZTjLNIan5kSr03
	 0Uv55UFkTSptMSJU6IgddQucjIHO2UzYAArv7juyr/zhLU6rDC9TLzy1y+VP9U/USq
	 I0bdO4kyzJtcRsuNo5kASjoQwt2q3s+Cnn97W0qQr/kJa2En2g/pZ0dntLLrlyKqpy
	 x0NtFrsBSSMN3qyDn3Jz0tPpjYKW8xWHi29xLaaZ+prbjbjAB5NaeZt2jxkuX7rY5k
	 mI0lJjcwNul2UpkZUZEDquEodKcTOpGOdMkgyan5pCMHelUKYnboXLlYeUJUt4pj4L
	 maFXELW3QzMdJRIQuxXXTC65NNqzHsDAx62dOy+n2PBQaAaDbILjpfCSU7KvWiUIVM
	 yl37K8OpWsPARZdDtspXT/F0=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 829DC40E00CE;
	Tue, 17 Jun 2025 14:51:56 +0000 (UTC)
Date: Tue, 17 Jun 2025 16:51:50 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	"open list:EDAC-IGEN6" <linux-edac@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: NULL pointer dereference in igen6_probe - 6.16-rc2
Message-ID: <20250617145150.GCaFGBBvUvkrtpO9j_@fat_crate.local>
References: <aFFN7RlXkaK_loQb@mail-itl>
 <20250617115707.GBaFFYE61vYHNuAkxR@fat_crate.local>
 <CY8PR11MB71345FDE3DF74BAF97B563F08973A@CY8PR11MB7134.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY8PR11MB71345FDE3DF74BAF97B563F08973A@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 02:09:42PM +0000, Zhuo, Qiuxu wrote:
> In the 10nm_edac driver for Intel Xeon server, 'cfg' is non-const, and =
the field
> 'cfg->ddr_imc_num' [1] is overwritten with the number of detected DDR m=
emory
> controllers at runtime.
>=20
> Reverting 'cfg' in this igen6_edac driver to non-const, allowing it to =
be set
> with the actual number of detected memory controllers seems reasonable.

Question is: is that something the driver should allow? Detecting more me=
mory
controllers but enabling less. How can that even happen?

> After that then applying Boris' fix above is the simplest way to resolv=
e the=20
> issue. =F0=9F=98=8A

Right, just prepare a proper patch, please, so that Marek can test and
confirm.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

