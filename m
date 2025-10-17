Return-Path: <linux-edac+bounces-5123-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C994BEB469
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 20:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83B4E4FC99A
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 18:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08295332ECA;
	Fri, 17 Oct 2025 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlifDMN/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598893321DF
	for <linux-edac@vger.kernel.org>; Fri, 17 Oct 2025 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727104; cv=none; b=eCgB0egkVCTssfqhnnqbff6IwnOi2zlekcAgwOT4uunt7b7wG1xdjB6XjMyo2NdSxkwr1B71GVVn8jpR/hdeVMfZv28WxI9e293H4FT+i8T8CARwGe6GXQZOxx73evjf+D+XFgsgeRwzQ/E5WRL5RmfYQ0CH1If8Opp2905ZX84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727104; c=relaxed/simple;
	bh=gXqMz+CcZKPeGt9WvOXq76EJR6tDE24GCMGXdrKpDu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E49VT3YFgWFyKstKnLBbc0Yj5iHSVxAXCTvv9SxBbMbyFp6hUI4dlApTNGxHzEoXfO9+Ve8ti/Youau2+OEmCs5N5UJyN19Fx5GKDg70vXzT78RWQ3xwryQPTMOVDXvIHRK8DADQUniH8C8+Odx7hk2T7lkwQtZ+qLZ3InWTH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlifDMN/; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8901a7d171bso263625785a.1
        for <linux-edac@vger.kernel.org>; Fri, 17 Oct 2025 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760727101; x=1761331901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcMHrjvb7aW8dOEyGXLP26k9PcHppfS2rsN7ygfXW0s=;
        b=YlifDMN/c6vzWfG76u/120EPvwuMWFthOAow4pFmcd4wRErr+JpLRZql/RdI3ZFvcB
         i/kn+nu5cNXXW48slMOD4L6lHLVy3FA4mmGcR3j7sUmM/LE4seQpds7VwSE9vlLwVh3o
         X1HTtMLfOIpOJyJOjUCEWK8GwEwrWZX/JQPe4/ixsO1syLpRFZhVfUI0Ov235fj/Q76A
         WJZ59va+96A/5qkKYYeqeNYf62Q9XkdErfCxy9xNt6llZj9JDoLeCM2K0Ze4Yd+TiJPv
         A6K/xxN5jA/qgnJr3ePqiE3FHyhC5XCOvqxac3E8yeWImyX2jvnjQPJXoRM1N0UQNxHH
         rODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760727101; x=1761331901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcMHrjvb7aW8dOEyGXLP26k9PcHppfS2rsN7ygfXW0s=;
        b=ib8yIt4DIiRKsG2J08v3026S5vWF+nDCYtz9d4qIr3PE6OMstZ7KZAIGCZlvZGwPuT
         k1CI0zgKLpzydBakT+WFvlprERK0W0S5dGAaRjY3Lbd5Ly0ue840EEqWb7bO/UDmOUBf
         5C40klORXB6Pit+tkUthzqDEUgJBk8z+U96ZF2Wy9Yp/3m2aVrPXS5xrZxiNoTadWiVl
         WOyKVJyH9o87sHlV0rY94BnPSggkinL/Tk7MtlEBJ20N7sCKJEkqrWB6BRST4OZxvPVF
         BJNIsS+VXGO1I6lFQzf0vbMRmXKE7NaD37+sa10w9crVpGOFo2TQmIezUi8sgn8w9ut+
         DQqw==
X-Forwarded-Encrypted: i=1; AJvYcCVWzLLr1R0+vG6w03wGyTzIOWpGe58r1GOY3WyMvfiYhhvjmMmIqF5oNIooh45l6fe7FMWBQ5Sw1Jt4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywge/H6RGr08gTRGI2yZ9G0TN/Be9cn9LA/61dFHCFzTH5mS6Sc
	lv8Hqmdsb08Qv6MR0Gei3UDz5ccrzF7NIq7BJ2y5xTVitsJq1vLugkwW
X-Gm-Gg: ASbGncudEUXIl1ewp/CMG37FJtzqf4NTo6AQeDFbGBjEKqOgILLOGY5/sq9XdfsMC1U
	wZqBJAKGJHgiO+3la90BrbOkSZsWC76B79JH0IDKvDTTUbUXa42GH4HVwb7CqXb/rU4JN3VvR1H
	t07ZKcZ144bMIjAGhOks5BYLZ+j7v1CzSCbmlBpRpTw+1fp/6fwjxGjde1CxPD7xNxyDGKNaN1R
	5f9R2Bs5Ch7C8qIJlvItorWxv4hXLbUArCY1AWG1t9et8+K3JLcvasG74DhSpx19/bvXzSQh0c2
	qmqVH2VQdgj2WBpTd00LAPp2ZVeEaY36VsaN/5+oL/oBBxFH/lD4ATQtELNDSNIBnbrBX/ou/Wl
	uxrraDE7ka+qb/xOVJh8sNEGqSiVb0oYvMMs2zVZnEwVsXuOAPx1CDLVt+nNYZnu6B0ipx2JFUF
	WPkSQ0Ljs=
X-Google-Smtp-Source: AGHT+IGgZXVqJ39mGvceINRef9aDCQGOzv3U5h5nFkBRWec10RvkxHjWCypd6ooOxs18G5q6X1BFng==
X-Received: by 2002:ac8:7f48:0:b0:4e8:910a:ad95 with SMTP id d75a77b69052e-4e89d20f6cdmr65322091cf.6.1760727100900;
        Fri, 17 Oct 2025 11:51:40 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf87ecdsm3689291cf.16.2025.10.17.11.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 11:51:40 -0700 (PDT)
Date: Fri, 17 Oct 2025 14:51:38 -0400
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
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 2/4] bitfield: Add non-constant field_{prep,get}()
 helpers
Message-ID: <aPKQMdyMO-vrb30X@yury>
References: <cover.1760696560.git.geert+renesas@glider.be>
 <67c1998f144b3a21399672c8e4d58d3884ae2b3c.1760696560.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67c1998f144b3a21399672c8e4d58d3884ae2b3c.1760696560.git.geert+renesas@glider.be>

On Fri, Oct 17, 2025 at 12:54:10PM +0200, Geert Uytterhoeven wrote:
> The existing FIELD_{GET,PREP}() macros are limited to compile-time
> constants.  However, it is very common to prepare or extract bitfield
> elements where the bitfield mask is not a compile-time constant.
> 
> To avoid this limitation, the AT91 clock driver and several other
> drivers already have their own non-const field_{prep,get}() macros.
> Make them available for general use by consolidating them in
> <linux/bitfield.h>, and improve them slightly:
>   1. Avoid evaluating macro parameters more than once,
>   2. Replace "ffs() - 1" by "__ffs()",
>   3. Support 64-bit use on 32-bit architectures.
> 
> This is deliberately not merged into the existing FIELD_{GET,PREP}()
> macros, as people expressed the desire to keep stricter variants for
> increased safety, or for performance critical paths.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Crt Mori <cmo@melexis.com>
> ---
> v4:
>   - Add Acked-by,
>   - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocate
>     power management debugfs helper APIs") in v6.17-rc1,
>   - Convert more recently introduced upstream copies:
>       - drivers/edac/ie31200_edac.c
>       - drivers/iio/dac/ad3530r.c

Can you split out the part that actually introduces the new API?

...

> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 7ff817bdae19b468..c999fe70076f6684 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -220,4 +220,40 @@ __MAKE_OP(64)
>  #undef __MAKE_OP
>  #undef ____MAKE_OP
>  
> +/**
> + * field_prep() - prepare a bitfield element
> + * @mask: shifted mask defining the field's length and position
> + * @val:  value to put in the field
> + *
> + * field_prep() masks and shifts up the value.  The result should be
> + * combined with other fields of the bitfield using logical OR.
> + * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
> + */
> +#define field_prep(mask, val)						\
> +	({								\
> +		__auto_type __mask = (mask);				\
> +		typeof(mask) __val = (val);				\
> +		unsigned int __shift = sizeof(mask) <= 4 ?		\
> +				       __ffs(__mask) : __ffs64(__mask);	\
> +		(__val << __shift) & __mask;	\

__ffs(0) is undef. The corresponding comment in
include/asm-generic/bitops/__ffs.h explicitly says: "code should check
against 0 first".

I think mask = 0 is a sign of error here. Can you add a code catching
it at compile time, and maybe at runtime too? Something like:

 #define __field_prep(mask, val)
 ({
	unsigned __shift = sizeof(mask) <= 4 ? __ffs(mask) : __ffs64(mask);
        (val << __shift) & mask;
 })

 #define field_prep(mask, val)
 ({
        unsigned int __shift;
	__auto_type __mask = (mask), __ret = 0;
	typeof(mask) __val = (val);				

        BUILD_BUG_ON_ZERO(const_true(mask == 0));

        if (WARN_ON_ONCE(mask == 0))
                goto out;
        
        __ret = __field_prep(__mask, __val);
 out:
        ret;
 })

> +
> +/**
> + * field_get() - extract a bitfield element
> + * @mask: shifted mask defining the field's length and position
> + * @reg:  value of entire bitfield
> + *
> + * field_get() extracts the field specified by @mask from the
> + * bitfield passed in as @reg by masking and shifting it down.
> + * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
> + */
> +#define field_get(mask, reg)						\
> +	({								\
> +		__auto_type __mask = (mask);				\
> +		typeof(mask) __reg =  (reg);				\

This would trigger Wconversion warning. Consider
        unsigned reg = 0xfff;
        field_get(0xf, reg);

<source>:6:26: warning: conversion to 'int' from 'unsigned int' may change the sign of the result [-Wsign-conversion]
    6 |     typeof(mask) __reg = reg;
      |                          ^~~

Notice, the __auto_type makes the __mask to be int, while the reg is
unsigned int. You need to do:

        typeof(mask) __reg = (typeof(mask))(reg); 

Please enable higher warning levels for the next round.

Also, because for numerals __auto_type is int, when char is enough - are
you sure that the macro generates the optimal code? User can workaround it
with:
        
        field_get((u8)0xf, reg)

but it may not be trivial. Can you add an example and explanation please?

> +		unsigned int __shift = sizeof(mask) <= 4 ?		\
> +				       __ffs(__mask) : __ffs64(__mask);	\

Can you use BITS_PER_TYPE() here?

> +		(__reg & __mask) >> __shift;	\
> +	})
> +

When mask == 0, we shouldn't touch 'val' at all. Consider

        field_get(0, get_user(ptr))

In this case, evaluating 'reg' is an error, similarly to memcpy().

Thanks,
Yury

>  #endif
> diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
> index 828af3095b86ee0a..6eee89cbc0867f2b 100644
> --- a/sound/usb/mixer_quirks.c
> +++ b/sound/usb/mixer_quirks.c
> @@ -3311,10 +3311,6 @@ static int snd_bbfpro_controls_create(struct usb_mixer_interface *mixer)
>  #define RME_DIGIFACE_REGISTER(reg, mask) (((reg) << 16) | (mask))
>  #define RME_DIGIFACE_INVERT BIT(31)
>  
> -/* Nonconst helpers */
> -#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> -#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
> -
>  static int snd_rme_digiface_write_reg(struct snd_kcontrol *kcontrol, int item, u16 mask, u16 val)
>  {
>  	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
> -- 
> 2.43.0

