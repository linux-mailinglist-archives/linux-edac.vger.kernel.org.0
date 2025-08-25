Return-Path: <linux-edac+bounces-4652-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F56B33EAF
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 14:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6B93A1EE0
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 12:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A42524A066;
	Mon, 25 Aug 2025 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YYwS79DM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB09414A4DB;
	Mon, 25 Aug 2025 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123490; cv=none; b=HindzKXAc15OLgsBt+xIVd0kq6QIUlcD7LbevHrA5xws7lGV4e0BWaPitHsKiJekWvkuqD0EibKwhplPw8aSQ4ihFqYQ3KyToJux/UE+V/fvbDiKMV5cr5ugsDuut9lWiQFzk9KnExXeF83FdK0qdjUfOUh6ErvLwoP1RxsSpzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123490; c=relaxed/simple;
	bh=wc9yzC1w0oDY5Rrrc5b+vRIsswJg6nCQZcY6Ge7F6sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VA8WOHky9E4wVeCTT0gkl0i6qIClFtxgpkmwf0jfOmkpedNrj2ShsA43r/Uq3jLEkUYDES8r3cHDB0B5Dfei5gxH8F52nie76Xa40dEFgHWQKfDzbsB8LduzbpaM4vm8FmzNdpOoAd5rdu6YZpmwNov+UOiWNKbskLlA0hd5ils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YYwS79DM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6BCC540E0202;
	Mon, 25 Aug 2025 12:04:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AnyG2N-1O2KL; Mon, 25 Aug 2025 12:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756123473; bh=IsU0wvnQjX2rP1sM+BcRLLHmk2CHZDI5c8J9mfULb/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYwS79DMfCmQU0O58jl55ssfSoqh0j7RpdAEFKU7w4OubEjxMNn6DTYNEKd15mG2A
	 lD17OD/ZzY20yG6di9J7xq51xN33pCVRj5b9uM0Dr7PKL3uTMorGg1g5V6vzV2jl2A
	 VqBwJFEndg2NLh753k6mg7C10Gepk8ra1+0BADfyOKIY5VBJn33MIwlla2Bw+1Lpdd
	 B6MhMQf9cPfkxLoKfUoq0u6ULlmi7pDyAMoIfkD8oVJAXpCaPL7T/+7Yrb5q3deEVp
	 ssmXghs9Q8l1CGUbacDd3xveHIzr8Kh555A7rUW4aad3Pp2ULqAjFYBFm+1xIkQG3i
	 pDjAgW2XKoqWnnKjEvhv8adlmavuG+IgHxQMDB3kee/dSMaa2/Q7mvRdxHhdEpoK72
	 zr5BV3uT+ES1n37gaF5QGdeSTZ0RgMANdIfi3m3tvxJCIje+DN8b6Iac/q0z3b8vHh
	 G3P6i8b4R6N08cv5Eg2EBf99kA4I/p/YpYwNtelKoKF0xup7r8cpZVSBkqUwydy/Fy
	 e6LoZO1K/DHBOpddN3LHLATpBz9tdGNZySdAS3UG58KL9iTpWC4omUe9RjOiKKaZ2H
	 17WjzCPH1nhkv070FBvRn1NrIouJf3HRK3WmVuCaPHZFUr67ARYg1monNAluLmzJ0+
	 YlAiJ2ywRQc0DhdTR0IpJy6E=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1227040E01A1;
	Mon, 25 Aug 2025 12:04:23 +0000 (UTC)
Date: Mon, 25 Aug 2025 14:04:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Salah Triki <salah.triki@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] EDAC: altera: Delete an inappropriate
 dma_free_coherent() call in altr_sdr_mc_err_inject_write()
Message-ID: <20250825120416.GBaKxRQCES-psm-XrY@fat_crate.local>
References: <aIrfzzqh4IzYtDVC@pc>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIrfzzqh4IzYtDVC@pc>

On Thu, Jul 31, 2025 at 04:15:27AM +0100, Salah Triki wrote:
> `dma_free_coherent()` must only be called if the corresponding
> `dma_alloc_coherent()` call has succeeded. Calling it when the allocation
> fails leads to undefined behavior.
> 
> Add a check to ensure that the memory is only freed when the allocation
> was successful.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> Fixes: 71bcada88b0f3 ("edac: altera: Add Altera SDRAM EDAC support")
> Cc: Markus Elfring <Markus.Elfring@web.de>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Robert Richter <rric@kernel.org>
> Cc: linux-edac@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  drivers/edac/altera_edac.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index cae52c654a15..7685a8550d4b 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -128,7 +128,6 @@ static ssize_t altr_sdr_mc_err_inject_write(struct file *file,
>  
>  	ptemp = dma_alloc_coherent(mci->pdev, 16, &dma_handle, GFP_KERNEL);
>  	if (!ptemp) {
> -		dma_free_coherent(mci->pdev, 16, ptemp, dma_handle);
>  		edac_printk(KERN_ERR, EDAC_MC,
>  			    "Inject: Buffer Allocation error\n");
>  		return -ENOMEM;
> -- 


Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

