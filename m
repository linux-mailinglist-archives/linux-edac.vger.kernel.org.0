Return-Path: <linux-edac+bounces-5249-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95488C1B08C
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 14:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D486400AE
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 13:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09873346AB;
	Wed, 29 Oct 2025 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AyOmu0Bq"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD85327213;
	Wed, 29 Oct 2025 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743335; cv=none; b=dRj3urfTAQ4OR22wU8vGfb4VttdjWlgtZcBVxp7TcBD0QSeHZC1V72iG09jRtEzVVocnfkUuxjvfzrLOa/iHZ9O2GIsbUguHY1b7AmLNr4RdY7rKwybZXQizCWo5qUE5VHGixWwGN4Hh19DSvQ8zUiC1THPkG+yTmIVB2OScXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743335; c=relaxed/simple;
	bh=UngHmgDP1nr6K0S8aa8Y0NIoHUi35dCsUpErrVr5J9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhH0pwVh2qR1t1Lqa6/LiRiB9cBFp18fV7Dxlvci7n3kvEVYanV2JA2VykUQP+2qkwXBkhREHFTeHL/kerE8+dNpYnRIaqPn5y2r6ovBJIqmFsCtPvtszcKHuvU/i1BNAxrvWQbrtWzcDf6iK+aCu+mD3ySvcpt1UEy4Ph6c+Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AyOmu0Bq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6C27440E0231;
	Wed, 29 Oct 2025 13:08:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JXSUdgHo4cTz; Wed, 29 Oct 2025 13:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761743326; bh=2JgUCL+m1awbrs708pVpItdTrCu+IIhOCpTs2+LmYl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AyOmu0BqXehF6sQ85sEKJCavJx84OVp5WuTATkBcSaZFbqGETlhvoGpA6rwYTzH3a
	 K6xxMEJfE662xlv9YEimnuMr8IjagDg0YPXXcwVV/ArFKXCJb55/u5AMMLmklcOSd3
	 TXTWYo/+8EFdv0R4vXp/DegMeZ6vRUjcMLdwyyUhZracw3Hxddv7OdAA+RQYBCDILz
	 ssZuPfbfnhpY8QG6gHFoT2l0pe23RMakSrXKH1ZA1S0/NRdkkvLaePKzi19pWVlmQ3
	 23apIAlriFXb+5h9w2Y9tnrt+qhL3A5WJAnn/Wd/zLN1lSb33TidWEi6FQbNvXLyi1
	 fX+coo0KGh6enkl7kALTxxCL85ikVerz7w8aqtlj8ZmvxCsC3k7rsgSF/6RgOgssU9
	 B1M/0Er0VTxszVup0PtOBCti/A6jqFDI4lHYJATD4s+Juv5OwNkmQU9n7+wi+C1rpB
	 Hh5Bn/IQ4mI3OHw/N5vJNhkNKc1hkMVOK/6AC7bJHvnMX9ulERGpIJwq1K283Aq8OI
	 5rjcZD5fbJuCjX88v3TNcJrmOHtZ2cN85XTM0QSvDp0BjUZYgMa8oQC3NAzvqYaiVp
	 RQTKS2Ka87FKlBQyzwi1EjEKHpuxMqQYGwAXS+tZzGhc4whnWXE0EMs13Be7obwT79
	 M+hH/Uz+OtzHSx76l08aTdpM=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 16F1240E0225;
	Wed, 29 Oct 2025 13:08:37 +0000 (UTC)
Date: Wed, 29 Oct 2025 14:08:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, git@amd.com,
	shubhrajyoti.datta@gmail.com, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH] EDAC/versalnet: Handle split messages for non-standard
 errors
Message-ID: <20251029130832.GBaQIR0CF8kSl6exi7@fat_crate.local>
References: <20251023113108.3467132-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251023113108.3467132-1-shubhrajyoti.datta@amd.com>

On Thu, Oct 23, 2025 at 05:01:08PM +0530, Shubhrajyoti Datta wrote:
> The current code assumes that only DDR errors have split messages.
> Ensures proper logging of non-standard event errors
> that may be split across multiple messages.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
>  drivers/edac/versalnet_edac.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
> index fc7e4c43b387..a055f54a389b 100644
> --- a/drivers/edac/versalnet_edac.c
> +++ b/drivers/edac/versalnet_edac.c
> @@ -605,6 +605,12 @@ static int rpmsg_cb(struct rpmsg_device *rpdev, void *data,
>  	length = result[MSG_ERR_LENGTH];
>  	offset = result[MSG_ERR_OFFSET];
>  
> +	for (i = 0 ; i < length; i++) {
> +		k = offset + i;
> +		j = ERROR_DATA + i;
> +		mc_priv->regs[k] = result[j];
> +	}
> +
>  	if (result[TOTAL_ERR_LENGTH] > length) {
>  		if (!mc_priv->part_len)
>  			mc_priv->part_len = length;
> @@ -615,11 +621,6 @@ static int rpmsg_cb(struct rpmsg_device *rpdev, void *data,
>  		 * messages the offset indicates the offset from which the data is to
>  		 * be taken
>  		 */

I'm guessing you want to move that comment too?

If so, I can move it - you don't have to resend.

> -		for (i = 0 ; i < length; i++) {
> -			k = offset + i;
> -			j = ERROR_DATA + i;
> -			mc_priv->regs[k] = result[j];
> -		}a

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

