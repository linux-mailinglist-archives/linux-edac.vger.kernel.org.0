Return-Path: <linux-edac+bounces-1003-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8158BCD8B
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 14:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4411C2219D
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 12:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C0D143892;
	Mon,  6 May 2024 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SexplnPz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD55143895;
	Mon,  6 May 2024 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997587; cv=none; b=BH/rFKxlgiwXkTCa14pfEedFwsvm/fIxJSCGEfPV7v3s/ioaqUbJ7IsVs0OcZmK65lzSEb7zOiufo/cPOEyyWytowjBvveXikza0lChhrCm+4CCoVhnDaSAHdPe+lakBPD+9kTdrnXo86/8i9vPUw+4IkPCaoGg28gafT0DmcAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997587; c=relaxed/simple;
	bh=JG4F5Vliq1cxbKJA3HniZ3sx6UHw/Yf2C1Q65sEsqrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noebAiBGYCFTTb7Lqw18RkxD7h3q71srMGz6IBwpebzGTMLubFHCYEWobhkThiMeqdqCFNw8H689W0fK4wqCjBWtpOFZM389Lr5EDnlf7u7WJ8Z+OxMoeHn/ik2kSdakgR4E9pIE439r95StSDt7DwO20BtQ8+SUf+g25t7yc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SexplnPz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7971340E01E8;
	Mon,  6 May 2024 12:13:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rJfRrwpOcMj5; Mon,  6 May 2024 12:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714997579; bh=/of+dyTW6UaI+A6BFaoUs57S0GorDUxHRqObed0VRzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SexplnPzD845D+0w5+eP+0ESkaUvL6gUYWbrNRIpCCuz4OGDoKbSBa1Tu/U7Xbd+I
	 mwlut2leWuEoIZU7PdPiKcwoRPab8QMn23dHrBAVLjwE8eA74TFlnAc7wBNiNB6HPn
	 9oy2JEokTaIY0t11CKL0LVc/JcoKuz3grWqgS+wb6yuYUdhsZtuQ+rWYzhEWY4XhoA
	 vRLFQByu9+kEWbrbVDJOlfMT4bIsw7cvJGH6S6MtrmuI/upRGNFFcjeUnbuLFD6Ret
	 p6jBHz0AAt15YEKS+BRLe4wdGFnXXtC9Lmp4Bm9EGcZXWAnfgBWuIuPx56ftf4ZN4/
	 EXcmUGX0krYdPVweESAWlAeU/nC2l0XHSMhqAg2hW2+Mjg8b6iGaT4GPbdADsglESU
	 4gjakgghhzSTNU4JcIFOW5XtY3E/+oXc4cD/+YtjUsBJHOLKMxTKz9aAu26Kblqdk0
	 UZwjxIAxh2nVBvqPuM1VLGGq//APBQc3oOj+Ulzni5YFNQ9pQ9AwJLvsnNMey7AL4b
	 kwDmsMFt0eQS3y2fRS9LQvtpYlcEj/l22wa3qxIvysJy0Tu4HCUO5DI/YwbpZJScGo
	 I1+DUWnLGNf2hXdU6etWiuJ1d8e3vOjO2/rlZ4LzmHFVqO5Zc4TpPkG5b493kkzehX
	 gX6GyQCoALjr5JpNMGI1bXFQ=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2CE9540E0187;
	Mon,  6 May 2024 12:12:43 +0000 (UTC)
Date: Mon, 6 May 2024 14:12:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sherry Sun <sherry.sun@nxp.com>,
	Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v5 01/20] EDAC/synopsys: Fix ECC status data and IRQ
 disable race condition
Message-ID: <20240506121237.GIZjjJNRhtixp7VVHl@fat_crate.local>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
 <20240222181324.28242-2-fancer.lancer@gmail.com>
 <20240415183616.GDZh1zoFsBzvAEduRo@fat_crate.local>
 <szcie4giwjykne4su6uu5wsmtsl3e3jd53rjfiwir6hm3ju7as@6eqh2xmj35ie>
 <20240421100712.GAZiTlUOm1hrLQvaMi@fat_crate.local>
 <whgp2xx4dv3szezz3bvmgutgazz6kvie3q7rgpr35zqzuzsygk@wppqzusteru4>
 <20240506102029.GGZjiu7TKP9FVp-2Sb@fat_crate.local>
 <vugkhnu5c7so7dk3z2cuhlbu66gv6skvicuseblrmkzyttnnlr@lqzqvysk6wbl>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vugkhnu5c7so7dk3z2cuhlbu66gv6skvicuseblrmkzyttnnlr@lqzqvysk6wbl>

On Mon, May 06, 2024 at 02:27:50PM +0300, Serge Semin wrote:
> Always welcome. Glad we've settled this.)

Yap, it looks good so far.

Lemme queue it into urgent and send it Linuswards soon-ish.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

