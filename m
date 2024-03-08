Return-Path: <linux-edac+bounces-749-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F106B87649D
	for <lists+linux-edac@lfdr.de>; Fri,  8 Mar 2024 14:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8923CB20CAB
	for <lists+linux-edac@lfdr.de>; Fri,  8 Mar 2024 13:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB4F1BC39;
	Fri,  8 Mar 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aPUk/alJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32900367
	for <linux-edac@vger.kernel.org>; Fri,  8 Mar 2024 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902859; cv=none; b=u9NxLAzSoIJngnkpAiF4hZ9Iu5Odw738P9Mw5FTmz4GlRmsitOJGRlWWn1pL0lZicVC4zmSjnd0Io00SOF5NmzTkWXmByApmxig411Envv4cSF1efTmGY5Hc+XFQU6M9j+WQ8jaCE7arXUv/0P0ASmsDSq226jX7Zcxc3coadbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902859; c=relaxed/simple;
	bh=p40AsgVwP99IwPDa3Fb4tHBkibN1xW0iPseLaF/TXrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDSPobhBFTZkfWZy2zJSSiYDMoqJ6A1WqJ4K32gSBatKpkVaYd7pzt+z/TSgekupEYt6o5vDDGVVLeQrJ1djRlYOS3RxUzaHXJOurdbfcuCXaK7QlaexadpQUEfp6p1fOQO1Y4qX5rzjmdyHK17B51ilpaOnOFZhoAVJmwYIcYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aPUk/alJ reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D50BC40E016C;
	Fri,  8 Mar 2024 13:00:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eFsHeTgYkpci; Fri,  8 Mar 2024 13:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709902843; bh=rz0gNAJvGOLeaPU1w5fTGMAK2DpZHF1LcxaEQcxbsCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aPUk/alJ29PORZoRV0hxrRqJZrlnCLvD8h/XMKYTmQaHLubMhJMjcjZ+KHZC1HldE
	 7eDCYRtpLEYEg1ri2dCS+RYiMSrgmWwDbnghlmuYnxRPaFYbJxdhlx2WtdB7x4rWid
	 25fvgtD9pSMemQxvc4HEtMTsNI09zQZ5eG6bWjRgUVYqvf9k+aVHQcWal1iaLQ1+1+
	 gV9zthVGs/F1bYKnSLOcaVYLE8dIaqdfqAnhVJ84QZMA8zhfQzag6qyEV/y65tmuSF
	 yhACgal4/0+XmB0fFSQa9u0k2mfXA2jGEB71rz8GIng4zBoYKJnyEaPJ4Tu06b43DT
	 I1uZfdbFP+eHQBacPulOo3NfYyU3vLfdYn7f0Gd5Idkf1srVPB8ukwVbvq3dYHQthq
	 XXTYAcQ8U7e23yL3iQ8O+0P9uIfgxG22EVlyxfAU2xouQbyMr0fHLeCYUtzlk4hi9H
	 xCoEgd7hWrYx9zNcOAZtXMn+xd9C3Km4bZl3ZkPqF4OgKCZHLH+/kWJzlPn8pCWKL8
	 ZXmle2Mw0jV7sqOElyshCIKi83qgp/8Rh/KfijLrcpttzwOanE9CRocdkAtQ9kKCiC
	 xC8AMz6+cGZ39G+EF4Ph1fCbTnnbUi2U0RQ3+wmbW2+DV8kC0fXdjsZtor0iRq9fzw
	 VQyw7lKf0x3U+sqxwgzJzwx0=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 943B440E0185;
	Fri,  8 Mar 2024 13:00:34 +0000 (UTC)
Date: Fri, 8 Mar 2024 14:00:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH] EDAC/versal: Convert to platform remove callback
 returning void
Message-ID: <20240308130028.GFZesL7P28ZtR0IDI0@fat_crate.local>
References: <83deca1ce260f7e17ff3cb106c9a6946d4ca4505.1709886922.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83deca1ce260f7e17ff3cb106c9a6946d4ca4505.1709886922.git.u.kleine-koenig@pengutronix.de>
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 09:51:06AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling b=
y
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/edac/versal_edac.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

