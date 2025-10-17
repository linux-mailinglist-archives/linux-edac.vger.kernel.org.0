Return-Path: <linux-edac+bounces-5121-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F5DBEADFA
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 18:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B8B158790D
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 16:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68192BF019;
	Fri, 17 Oct 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBrR57zW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C32BEFEA
	for <linux-edac@vger.kernel.org>; Fri, 17 Oct 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719035; cv=none; b=H4ZG8LUkkSuhBh1rU/BgPgw/LcwCFRYSCNhSFCMjD3IEQPGyiV4RDvptKgzJA4Pn93tfqV8STejOX0lKS1enf7eVxD7wKrASeDRwyWjvlD6DL0kNBOg9FrSeaFhzZMX5V70K+Sz4nWL98nTa4jovsp5npPHZpfIYVqEz0rC79jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719035; c=relaxed/simple;
	bh=K5dh/21yz367t5636zz5BS+SRG5wCokC8YohqZIkQhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y53yz5ejN7gPoZ2w0JOCiBLwpJXZwktPj4bG83qDAPpkXCUM6EWrKRru49ZvtMn2IZ0GRcOqyuH+xowLJ7Bwd6ayFTr92JS+MRwdw+mUwDAZ3MrWccpPQOL3cYbYO1Z38gOu3fADkKdB3UxMmpmzoyXFX0BHhLTnF2CuNvt3mQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBrR57zW; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-796fe71deecso26541346d6.1
        for <linux-edac@vger.kernel.org>; Fri, 17 Oct 2025 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760719032; x=1761323832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZqTIsgME323ZkO31yyQWUQxJPAMGciP0ot1SYinmXM=;
        b=gBrR57zWpXm2w/7blqiasX6rmV7vMOXlvxZj17ty4WRF2XnRnvCdJtbZv+TCRnKfEx
         dJRlYjhECXVkQ9Q1HIXqpT24ZGQzQyQsiU9ADp3KCRFJ3G7mv1AiaubTgOpTRR3QJiZ3
         nL5TZx6sR9W1Vxti398bZwYcjYqIqFXg7IwscFtEsLL6pqzhaQpJbypNsFnFKem58Lnt
         vDxezsCzssRFdXkEHo2TWlwIp5pluD9Qrl4KdwvuiuR/eE1k/nRL5SkfuLiqgxJrKVTe
         CXGLcSwa1vOVG6qTZzmTOJQt6xSCdBQTV/aXP+AmQChG2FjRoFtd4Y80fXd9rDh0uUM7
         a6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719032; x=1761323832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZqTIsgME323ZkO31yyQWUQxJPAMGciP0ot1SYinmXM=;
        b=kj80jFfnZphr7ccR1IKq2/jZIGGug2V9rC3afBoYcLJ3rjj3nBRqPWkNAytXydDxfn
         1Ux7khG/nFRhq+lU1x3Sp8HEFJJIOG+HV9VPvM0D4WWl8jp83yEXhgDCuu63nKs8M4O1
         5ZADdrb+XvdVAL8SXiXmVD5ZlUNdB8SZxlcf4cw7aKGmHzEV6+sIm+EGu71orNoc5Ty9
         XN3g1mdqJOg9dN8ZpTBab/cnKWAdUAQ7pRrv1be+w8qP6r3uyBO2cHtep6o6xLfs6u48
         zXgRpkxqJxJ2D3z7kRqKunPyekkIRmufRVqx9qN2vHxiV2ACIQfE/x2I/iZDARbjKPU1
         RwuA==
X-Forwarded-Encrypted: i=1; AJvYcCUiH8JvG0AUQcUV2OTInhQtq01jpvMHJJutzDUgVUFNQ0IuJOFnyvxhPE5ggQ884oF15SlQB07dwlwf@vger.kernel.org
X-Gm-Message-State: AOJu0YxgM3aa7GSOAU6CbZI83c6KuqJtNfXHNwi9hbteJ/sVvd493fUn
	imu3KumRypAvWQq9ifo7DkrNZgNDQfgRrhy6KBM/XnI3KyE7uDPqo2WD
X-Gm-Gg: ASbGncvD6ZFTW54r+kub5IkVuzf/Wc+umWQSZ9G23wdn8YwjLU5XCONDxFQOAXvKr9j
	uSWIT4rPD6+bEtFY+qzfe89bJtoE/szmLbSU4Q7bqaPjSygJ3qs4Ue+bM9YXwspY83u8lAPu7Ra
	j6hNpO01xVXInQeLSb3BEUpiT9gGPmrOuih09Yqt5Rd5KKtrObIyzm8JylnVENr0NOuYq08mADu
	T95+1sprquHSJT6gdpEKxDIUlyFhmnobSqNXSvhJkTyGKKJO/KtWYkeYDnlpEwsjkgls2lszeOg
	vCS8ZKiuBgibXuspWBMS/wjw4mH27pe0Od0ZZMhszBVx5nsZWXQDnZu82wdcz/1irLsG3LBiFNV
	rjb3GHq9vn8dzBUkQU0tqT+TLDgqNLCLcZ9fKG3VdA4KrYlAEHysmYffFOz/Da93rUphjLQTxJ5
	ewRmgV3Z8=
X-Google-Smtp-Source: AGHT+IEBLNSjsT2f6SbTw5aTPGakjHLdlQrL5hue+DxfPG8mzc3zrpMssrggDkT+31HrLygOdkrpIg==
X-Received: by 2002:ad4:594b:0:b0:87c:2920:5730 with SMTP id 6a1803df08f44-87c29205b08mr24398926d6.40.1760719031704;
        Fri, 17 Oct 2025 09:37:11 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d91324sm1575686d6.65.2025.10.17.09.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:37:11 -0700 (PDT)
Date: Fri, 17 Oct 2025 12:37:09 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>,
	David Laight <david.laight.linux@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org, qat-linux@intel.com,
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] bitfield: Drop underscores from macro parameters
Message-ID: <aPJwtZSMgZLDzxH8@yury>
References: <cover.1760696560.git.geert+renesas@glider.be>
 <792d176149bc4ffde2a7b78062388dc2466c23ca.1760696560.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <792d176149bc4ffde2a7b78062388dc2466c23ca.1760696560.git.geert+renesas@glider.be>

On Fri, Oct 17, 2025 at 12:54:09PM +0200, Geert Uytterhoeven wrote:
> There is no need to prefix macro parameters with underscores.
> Remove the underscores.
> 
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>   - Update recently introduced FIELD_MODIFY() macro,
> 
> v3:
>   - New.
> ---
>  include/linux/bitfield.h | 106 +++++++++++++++++++--------------------
>  1 file changed, 53 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 5355f8f806a97974..7ff817bdae19b468 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -60,68 +60,68 @@
>  
>  #define __bf_cast_unsigned(type, x)	((__unsigned_scalar_typeof(type))(x))
>  
> -#define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
> +#define __BF_FIELD_CHECK(mask, reg, val, pfx)				\
>  	({								\
> -		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
> -				 _pfx "mask is not constant");		\
> -		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
> -		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
> -				 ~((_mask) >> __bf_shf(_mask)) &	\
> -					(0 + (_val)) : 0,		\
> -				 _pfx "value too large for the field"); \
> -		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
> -				 __bf_cast_unsigned(_reg, ~0ull),	\
> -				 _pfx "type of reg too small for mask"); \
> -		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
> -					      (1ULL << __bf_shf(_mask))); \
> +		BUILD_BUG_ON_MSG(!__builtin_constant_p(mask),		\
> +				 pfx "mask is not constant");		\
> +		BUILD_BUG_ON_MSG((mask) == 0, pfx "mask is zero");	\
> +		BUILD_BUG_ON_MSG(__builtin_constant_p(val) ?		\
> +				 ~((mask) >> __bf_shf(mask)) &	\
> +					(0 + (val)) : 0,		\
> +				 pfx "value too large for the field"); \
> +		BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >	\
> +				 __bf_cast_unsigned(reg, ~0ull),	\
> +				 pfx "type of reg too small for mask"); \
> +		__BUILD_BUG_ON_NOT_POWER_OF_2((mask) +			\
> +					      (1ULL << __bf_shf(mask))); \
>  	})

Hi Geert,

Thanks for the series!

I agree that underscored parameters are excessive. But fixing them has
a side effect of wiping the history, which is a bad thing.

I would prefer to save a history over following a rule that seemingly
is not written down. Let's keep this untouched for now, and if there
will be a need to move the code, we can drop underscores as well.

Meanwhile you (and David) can propose a corresponding rule in
coding-style.rst and a checkpatch warning. That way we at least will
stop merging a new code of that style.

Thanks,
Yury

