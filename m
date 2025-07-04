Return-Path: <linux-edac+bounces-4317-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F21AF8E8E
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 11:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88113A3026
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 09:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74C628935D;
	Fri,  4 Jul 2025 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VpzYj7ZK"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966402877EF
	for <linux-edac@vger.kernel.org>; Fri,  4 Jul 2025 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621154; cv=none; b=Hw6Te+EwXAPZ2Lutc9nKEYdvjTsedccKdCb28tryUUm8OW0/JQr+YuE8t3jtkdZb/GPO15+ImQajwZcsP4uJgwivk23oiJlwyKwx9j4GQC4moEC1gCT83ilXXwRpJTF1BmxTwQE5tHTIEX9wH3HRiwMI0T3fxzPGkr5iaMauP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621154; c=relaxed/simple;
	bh=y7/0BFL5N1MvOPzfXX627K1ob2AT/DAkYYWit6nWrgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyK60/qLws98bEnk92XLdiYFGztALiblmGiK0kRx3KNh6pSHcopo/fK9xtbr3wGKoEI5eL9claBVxrTGvKf5c9PPahbSDMqaxyQNIIR0G/uSrT0v9Wz7q5yy7NjA/+iwkDVJ4xrlq0gFN+mjdtR3kvdL8JK+mB3chofPp4Y5PmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VpzYj7ZK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C47A540E021E;
	Fri,  4 Jul 2025 09:25:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jIYl9M8M1m0i; Fri,  4 Jul 2025 09:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751621142; bh=RSbTPogNW66JDedK58NnQ5OQzDO3X8R2It5qoGxfMbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VpzYj7ZK66SFCsA2MGV3OL0pqKZMXcVmBIjLeelzE/Q2bjpz9SV+knZA3AaDOu7GK
	 QadaE+jyeoQ2H3Sjto3S7JaC7OomPPX/V+a9pFZef/10+pm9MxMjyLB9R/i63KAbv5
	 Kc+kKI5GQXF2dNxB/jDn3f2ALwmle+c5ffOUtwnys6PtfdbgwBgK/iLLnlWOJc0FTU
	 4AjvOwyn2O6JDL5Ry2NIU3HmS3o94RO8sO0bYI0jfxMEVrmmAHLPB6m6VGqT6Vl7Sm
	 1mMcgC5qqoMK6oY0EmqKtFOGdRNLxC9H9nVSGnRYWCWiB5C14qmcwlE//JUTIcnaWX
	 D/hZFsmOTtkm3n91oQ4OLJB7B08v2pYKVqdyt4+MwWzgmeIGFTEaLFiuH2EFzj7DUB
	 byBj9nP0KNG4+yA28tCbv6v78ZUze5eR9At0GOQphlDG6j1NhyI1fXL/xyuWNVV7su
	 0IUKFqjz3UXnS39MhAlcIh+1q/ujXYCGfsnDX1LhmYJS6SDnD57o2I6TF0vJO9/XSe
	 0533vXoBmyqqyj1jMYONqe4/z0SunuFANGzA6ejmlDci1oJ8P5o1R5HCGjBq4TCnx8
	 jj/7AIPZ73Uf+bzVK5/egO24hZbylZYaR6wY6F3iwWA9Gt7xPJ64l/CAAxIH+yFQjJ
	 /vV/7Lh5GZengeFfXQc+OXN0=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B442740E0220;
	Fri,  4 Jul 2025 09:25:31 +0000 (UTC)
Date: Fri, 4 Jul 2025 11:25:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, tony.luck@intel.com, arnd@kernel.org,
	mchehab@kernel.org, rric@kernel.org, dave.jiang@intel.com,
	jonathan.cameron@huawei.com, linuxarm@huawei.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [RESEND PATCH v2 0/2] EDAC/features:  Reduce stack usage in
 create_desc functions
Message-ID: <20250704092516.GAaGed_PnbpW5s1a5C@fat_crate.local>
References: <20250704062911.1882-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250704062911.1882-1-shiju.jose@huawei.com>

On Fri, Jul 04, 2025 at 07:29:09AM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Constructing an array on the stack can exceed the warning limit for 
> per-function stack usage. Reduce per-function stack usage by changing
> to an actual attribute array allocated statically.
> 
> Changes
> =======
> v1 -> v2:
> 1. Fix for the error reported by the kernel test robot.
>   https://patchwork.kernel.org/project/linux-edac/patch/20250630162034.1788-3-shiju.jose@huawei.com/#26450738.

Why are you resending the same thing 3 days later?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

