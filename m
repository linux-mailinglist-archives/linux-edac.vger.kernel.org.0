Return-Path: <linux-edac+bounces-103-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9C87FA7CB
	for <lists+linux-edac@lfdr.de>; Mon, 27 Nov 2023 18:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616B3281888
	for <lists+linux-edac@lfdr.de>; Mon, 27 Nov 2023 17:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E32434CDE;
	Mon, 27 Nov 2023 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BYnUBMxl"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B25189;
	Mon, 27 Nov 2023 09:14:49 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9C47640E014B;
	Mon, 27 Nov 2023 17:14:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TjHxyBW3GjS7; Mon, 27 Nov 2023 17:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1701105285; bh=1XsCHVs3G1AK8quCu6PRq/dRGJyYh/0vS/L9fgr5Dsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BYnUBMxlUm/TeOHT5vbel+mUEYciMKpvvy+i3YEyhxclh1vMaMbB9Wdcrfgn0+Cr+
	 GIKWaOh16XC0T5xDMYAyjF10xt41gjmE4hMY6xzxao5+KbzngfJUuXQzobZDxr0SS3
	 R7YIYl8jGA+haI1u/73qjzSrfRQm+PCqOKnmwGrmZdCYpkENE/by7jpVjJYBqAeUlz
	 QtIs88mTZvYi7uE/oMoM/8xaZmCf4Nk2KzokmUhX7kCQOqD2P43jNGEtNV/MsWy4qA
	 EOyYJhLmgKNgvzl86irhK8LEDW1xi0f84Q3huE5tSN4WZhbKrH1Zi05fyhOoFva0L6
	 y7vGf2RDhrV2SRxhVPTmnMFI/235COquRZeyX/piq3v/ughSaGrvViR0oX/gO+dKE1
	 wQgt8I9CZADCeSsv+1gCPT1zxQErPcA0nsfqD+Wl94yxknBrBl/rnkhCE+Tz/3xoTf
	 +qJ27ibC2ldTHPbR1NckGyOSile12D0Dxx38HipK+75l14qJ2CxFVTy0bAXTaMiyn4
	 qKJswJarSLRRalEwOjHZs1cgHBzKcOI1MBSe3/lWorYuVnRf2J6Nj1KdGUphYMxs2M
	 mpv0w9U4kgcVFHtNfsSJqOzcSqSSW2a1rADflw2Go9zmbIqORCExdBVhXXytbJjRn5
	 87FeZVC+5BF6ZSqdTDwErw68=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9BC740E0031;
	Mon, 27 Nov 2023 17:14:36 +0000 (UTC)
Date: Mon, 27 Nov 2023 18:14:35 +0100
From: Borislav Petkov <bp@alien8.de>
To: Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc: tony.luck@intel.com, qiuxu.zhuo@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] driver : edac : Fix warning using plain integer as NULL
Message-ID: <20231127171435.GCZWTOe+DQSy4kkuKO@fat_crate.local>
References: <20231109212157.1454726-1-singhabhinav9051571833@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109212157.1454726-1-singhabhinav9051571833@gmail.com>

On Fri, Nov 10, 2023 at 02:51:57AM +0530, Abhinav Singh wrote:
> Sparse static analysis tools generate a warning with this message
> "Using plain integer as NULL pointer". In this case this warning is
> being shown because we are trying to initialize  pointer to NULL using
> integer value 0.

And that is a problem because?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

