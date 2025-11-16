Return-Path: <linux-edac+bounces-5446-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ECBC61454
	for <lists+linux-edac@lfdr.de>; Sun, 16 Nov 2025 13:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EDF93612BC
	for <lists+linux-edac@lfdr.de>; Sun, 16 Nov 2025 12:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2C223EA95;
	Sun, 16 Nov 2025 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Okw+lGrt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6AEEEC0
	for <linux-edac@vger.kernel.org>; Sun, 16 Nov 2025 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763294581; cv=none; b=tH8h+fOdMpjA6hZ46MwUT1y5eL798848IB4Ftmo/ejJiJ0TZdnaCIWQpUUZkptjoMQSCOg4uCIzWUr0R/w0tTRsE7GMRwoGsSRJi/5/Vt1zFEmfOALjkkJZES7B9cDbnQudEOlGhocqZZL3pGSKO4RgRXRf+8Ewo5Bl8YzVhQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763294581; c=relaxed/simple;
	bh=SERTZL7K8q+k4BniW854aVlar5EQKET2P6Ult7nVB18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBNybRUUIYtJf/iCp4/PqL51WfFckcUljLHuDp+xL8drN1AcnShdRuKs0KTUw24+++i19dFwKEDrpBQvGFQUfMHPn+Rzf+8sN1P0gpBPPzq588IFEP8ayyB6zmCGQzedtEQ23h34Rn5PAoRqgsJXa8afZEHy6xdvdx29Crl0Hbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Okw+lGrt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0AED540E015B;
	Sun, 16 Nov 2025 12:02:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gSYyXmM8yw0X; Sun, 16 Nov 2025 12:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763294571; bh=byBmX0imtn5Gc2sW603dctUpujsGLsmWXhVjoHC42ZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Okw+lGrtKzMBmU7bb8c+fFfm/jzIyx9jvrNbn1dNdkiIqZacaym5Qi92dTjmeBG/2
	 Q8Na/Tah4CTM0f3FXExM9g5nuMrlUhGNJ89Qr6Z4I11a4HUa7rdURNoyN4m+pcm4rT
	 8UrI+7w5PZ11+iNNj8TWZISNwiEYS7qIvBXNKQdDDvIbt8pLqk44K8CbFnN0rvQusc
	 uYs76HjYWEACl0KQclwtfCcAtnX25HfzHDgz79WleJXZNBZGnVe3cqRVXMqNWiAvtU
	 Qo5TPlgPfpl4m1/aR0NfzICzJnNJpXnN8cURvU+YSNc5cSkh9wVZ079eGT/qMxiKCe
	 llseWC5gfLrX6Ry7OWEbZEYA/sx46wncdHAHoF8RwwLJxJqKysXct9gIrGJUgsu4Q8
	 vh0rY9HRa7u7lIrYRqnmjaOMulcXkTLn7niQ0PjSmh71EHfPrEsJgmn8O8riLSXzeP
	 9GutkLPrkIf6pW4J1ItLsbyPYTxYvsug7WPVfvwMJtzoxEXNfh8oqtVrkC/DJv0c1P
	 5viuaHttgnNhGPiURE8m8B/pzXZT5AAbXLb3wX7xXgF7LjfPyoMJoGj0EQPMSBgQ7X
	 YsRULvC++EUHhaBOBWrp3tZOeRRcmHE1WxyVu7ubVyq61nui60mSl278CrjIYYeUAi
	 /sKkD+r9+HZpL3gCKQCsYHzI=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 99FDE40E016E;
	Sun, 16 Nov 2025 12:02:48 +0000 (UTC)
Date: Sun, 16 Nov 2025 13:02:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>,
	shubhrajyoti.datta@amd.com
Cc: linux-edac@vger.kernel.org
Subject: Re: [PATCH] edac: versalnet: Use kasprintf() to simplify string
 allocation.
Message-ID: <20251116120243.GBaRm9YwFA1cMr5zGR@fat_crate.local>
References: <20251115195653.48249-1-ayaanmirzabaig85@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251115195653.48249-1-ayaanmirzabaig85@gmail.com>

On Sun, Nov 16, 2025 at 01:26:53AM +0530, Ayaan Mirza Baig wrote:
> Replace the kmalloc() + sprintf() pattern with a single call
> to kasprintf(). This is cleaner, simpler, and avoids potential
> buffer overflows from the fixed-size 32-byte allocation.
> 
> Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
> ---
>  drivers/edac/versalnet_edac.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
> index 1ded4c3f0213..c79509b0a464 100644
> --- a/drivers/edac/versalnet_edac.c
> +++ b/drivers/edac/versalnet_edac.c
> @@ -812,8 +812,7 @@ static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
>  
>  		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>  		dev->release = versal_edac_release;
> -		name = kmalloc(32, GFP_KERNEL);
> -		sprintf(name, "versal-net-ddrmc5-edac-%d", i);
> +		name = kasprintf(GFP_KERNEL, "versal-net-ddrmc5-edac-%d", i);

I like that.

However, kasprintf() can return NULL so you need to handle that. I know,
I know, the original code doesn't do it either and yes, we have been working
towards cleaning up that whole area. But pls fix that while you're at it.

Also, Shubhrajyoti, that ->init_name needs to be freed somewhere on the
destroy path... remove_versalnet() perhaps which does device_unregister()...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

