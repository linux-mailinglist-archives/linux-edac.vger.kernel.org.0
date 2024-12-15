Return-Path: <linux-edac+bounces-2717-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 346C39F2637
	for <lists+linux-edac@lfdr.de>; Sun, 15 Dec 2024 22:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC1B1884BCE
	for <lists+linux-edac@lfdr.de>; Sun, 15 Dec 2024 21:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65E214AD0D;
	Sun, 15 Dec 2024 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OBoKpyhl"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60014A41;
	Sun, 15 Dec 2024 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734297574; cv=none; b=q0ubsfGdhEQ/b17/o+sv/JVEfVEJxj/PHEje7/wsPo2UQ22y47QVR/Md4Nr3o16VD6JWlhNRquX9GdY4jz9+lLBZ50tO91DJ1jVd5cSP9+all0FaP0lh2/a4wCtvUSUQKi9xN1+wrWMROqCqDN/l7BtVrZ+3Ls6Hflm8Tnzc0ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734297574; c=relaxed/simple;
	bh=LTIxK0RN0R6lsCrofer4wQZo0B6V8NcbLvOO30DIFt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOLaRTXLAWLyOs+VBSpluf/6CvXauwOeNi0A28JMG/jlK3w7IP12WfN3bB5d/dWarm86rDl8TRuTWyRcHUrh+AkompbroyL9INf1cZDmcCvRZFSPZ/bxwsEXbXW728pDvV8dc0O15135CqBzWywy9fLnQAQwpnp25RDGUscZKKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OBoKpyhl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 902DF40E0163;
	Sun, 15 Dec 2024 21:19:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1Rea2ZtLECJE; Sun, 15 Dec 2024 21:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734297564; bh=F7lqgFh5d53qqE9QyMC250Hz1iuK1qpbSQta7le242g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBoKpyhlXAelnezS65YehxjxndfCFk/ylLggVer4+KFGO/vFWIDmE4a5i4ei5O1Bb
	 k2XAI/iL/MmqTZJcDnkw7x48+pFhn0riga5YxDBO5V2LGzSSbttA0dpgjbt4zBVJVx
	 xlTE5mN+7SJ3VrdmP8u/Pm1sEc8Ckqae3XlsCNSw8rjuBjXx+nKBXq3e3wPIcvswkR
	 MbKydsjLjbfflXDVVRz6n0TPSGusLVHXVqpPqy1OX5Uuq/temQE6UZ7JMLUA/BeE6R
	 nqb0DnDRslubx7y31MhA2ImuW7+lsxp/bNBx/BA7+QO7+OtzjOxC1gBKOpPC3dmFgW
	 6aD11lxKF/ZFSPKLsa8nno6TPs2UN3GiANIR7BQcpXQsTm1i+LYQQAQowjwaKfRp9v
	 fgQaFb1WWmfo/ir5/scOt2VMgsYN8pnVkSXNyecs39EJ0me8iZfsALgQJZXlqxHcAh
	 ifbarSuWbVl74d2u3UHOmT4Cov1TFKd1gJJBqp+fap6pwMma1lEb+diKIEqU508XJU
	 nSjlSUrqPxnvTsaLGho+/TlEsQ5O3tNDNlwGiJHn5PVR91xptpA6umIuOa5M+FKLg1
	 QCv9gBXry5uReUOQFY+teiwi9AVIFj2YhXDUHdhVrYIB0QfHMtSE6XVdxCaSQXlxaf
	 h1SVua6p4l8Kn9C29eQ6Uy+c=
Received: from zn.tnic (p200300ea971f9324329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9324:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1444B40E0263;
	Sun, 15 Dec 2024 21:19:16 +0000 (UTC)
Date: Sun, 15 Dec 2024 22:19:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yan Zhen <yanzhen@vivo.com>
Cc: tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] EDAC: Fix typos in the comments
Message-ID: <20241215211908.GDZ19HzBchgHAaaent@fat_crate.local>
References: <20240930074023.618110-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240930074023.618110-1-yanzhen@vivo.com>

On Mon, Sep 30, 2024 at 03:40:23PM +0800, Yan Zhen wrote:
> Correctly spelled comments make it easier for the reader to understand
> the code.
> 
> Fix typos:
> 'Alocate' ==> 'Allocate',
> 'specifed' ==> 'specified',
> 'Technlogy' ==> 'Technology',
> 'Brnach' ==> 'Branch',
> 'branchs' ==> 'branches'.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>  drivers/edac/edac_mc.c       | 2 +-
>  drivers/edac/edac_mc_sysfs.c | 6 +++---
>  drivers/edac/i5000_edac.c    | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

