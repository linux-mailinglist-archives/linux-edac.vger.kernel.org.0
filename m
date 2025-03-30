Return-Path: <linux-edac+bounces-3416-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88459A759A3
	for <lists+linux-edac@lfdr.de>; Sun, 30 Mar 2025 12:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5281658A7
	for <lists+linux-edac@lfdr.de>; Sun, 30 Mar 2025 10:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4431A192D83;
	Sun, 30 Mar 2025 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aNeYAZnl"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C7832C8E
	for <linux-edac@vger.kernel.org>; Sun, 30 Mar 2025 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743331174; cv=none; b=BiYeRCPfgx8sZu9ak3i21Iu1A1fb0ZSQeHvQ0V46SGkdSihCGUMCararODAaLe/ichPwb/CrfHvi6NN6/Sp9pS07piJL1qI3HCrDWIDHTPrfDg+JdHDBQF4hRHLi63aqSV4eA7BVWsUc13emDzxVU1++cpP8apZYCM/IUAGc2UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743331174; c=relaxed/simple;
	bh=eUl+yAcZpaVBbYNslQ4Nb8EHnRH7HXpRur0THt8VvGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YV3xsJGtPXj6EApeSvqMl8IpkQ7eMHPn+wVX6c05WkMu2oqYtlkt1T5VbFAsdcf6b1tppC0vCX5rXYTmaFT3itVFsI9yhh3+n9pmtCmRBo7JLN7lsS/Khx0TpNLm/jQuSIbvnmDUn8nGWuhrVfBfvXuFgRKfuoIMqbgRLq8I49I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aNeYAZnl reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AAA4440E0213;
	Sun, 30 Mar 2025 10:39:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6Rh4nUiOEG2A; Sun, 30 Mar 2025 10:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1743331160; bh=XFz3Adeoq5tM4/rhwX9WMcR2XDffU/oix8sp72A3HwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNeYAZnlXViTm8SEx6m8i0U6zMpj+7sl+utqllWK4mQ79a6V3F5mFTZv031afKDf5
	 eGlq2W8VUM3oTuvVOmQzNnqfWlE3ShaKAYAA4M7S46QBrGasmkw0nuDdoccDyKBPf6
	 RdzMLR7mO1F5iDqB8H0Met6p6J9tohkf1y4Dp5yDnSbXPRfFTf40nOavZdDC240EQv
	 3o2RpPJO/lJzll2yaa+mRUDxpuJVxgG8kMtU9sjp92rXTLdw85/Rkqc1UGF5Vx79CT
	 PqmlJQDS1hURlsHXVpoKk4sATfJbaHS7ywA7kAnE02/ixmSrD68PgC1+OKL18DGmaK
	 6I/TdPPkS1vkslYAjeOY8FH48MJK8DSQnMNifmyqhQaGj2LJfI0U4eeH0ic/HsYoP8
	 SiCOPjMCRLn+F6DC6tomMqCD7qF+D0hS/aE4jcVGm21si7QKiP8YQG5m0JPPpCyWkT
	 ryutNw3d6SUVQ8RgnH12OKK0S0q4xa92hEcXZ1qU+6JnsTpsSfQ12F/wXB+q+5qtjo
	 INg+jQCpTdRiWK1wh3thYmCS+PsmZlMxipsclrxLCTMHH3y5NneUX5J8NKWLhdwX3L
	 lb1D5PgoMYIwdaxw65cYknJBOkHL2tnSdaxSEwjwIfjYbcuGHUnHSFNwU01AStYVoq
	 ZU8fhRUdTIZtanLKEHDYBoR0=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1E3C40E015D;
	Sun, 30 Mar 2025 10:39:15 +0000 (UTC)
Date: Sun, 30 Mar 2025 12:39:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?xb1pbHZpbmFz?= <zilvinas@natrix.lt>
Cc: mailinglist@reox.at, yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: Memory controller not showing half of the memory?
Message-ID: <20250330103906.GAZ-kfSjT1IqkH7nUs@fat_crate.local>
References: <20250317120702.GA7066@yaz-khff2.amd.com>
 <dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt>
 <20250328152415.GCZ-a_HzI0zpcaLNWD@fat_crate.local>
 <e1b214f4-1093-4713-9ba6-3a9774ed4d63@natrix.lt>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1b214f4-1093-4713-9ba6-3a9774ed4d63@natrix.lt>
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 30, 2025 at 11:25:17AM +0300, =C5=BDilvinas wrote:
> I have applied that patch on top of 6.13.8 and now EDAC shows:
>=20
> UMC0: MC0=3D0GB, MC1=3D0GB, MC2=3D24GB, MC3=3D24GB
> UMC1: MC0=3D0GB, MC1=3D0GB, MC2=3D24GB, MC3=3D24GB
>=20
> it looks correct now.

Thanks for testing.

Want me to add your tags to the patch:

Reported-by: =C5=BDilvinas =C5=BDaltiena <zilvinas@natrix.lt>
Tested-by: =C5=BDilvinas =C5=BDaltiena <zilvinas@natrix.lt>

?

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

