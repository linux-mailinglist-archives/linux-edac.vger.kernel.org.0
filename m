Return-Path: <linux-edac+bounces-5404-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB69C3C7F4
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 17:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346AF18C5B68
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B863B34EEFB;
	Thu,  6 Nov 2025 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBzFCUZ9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AAD34EEF1
	for <linux-edac@vger.kernel.org>; Thu,  6 Nov 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446714; cv=none; b=PaGzYjjibr3VYoCv15e2uuAMqfmsfX9VkeeM80rAPdTUnPMS8aflSGtUeT3xZ4kitHRc12em5exz/V2n4W1uQg9xhrBG7eCkPXM7lLxgNY9Ty3LEpg2sNQK4RGQHSjWfJADqvoxzQSusPorY65BXzFGQTVluh8yX6svwlW2ySNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446714; c=relaxed/simple;
	bh=gZpeaDdMgA4EZA+xmuc5CunjJCGos8JY91Zsp13Ia/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1Ex4V8cjWxmKVmSTK6tPRE+8ihHrSr4sYI+wrW+CY0Lz45PNVIHCYbBzR6Pq7tse/gqhXkaAIwlVKuuyYc+xqUP2xndGEsvEaYYymEMQI2PcxCqmtaQIyFn8l8U7i2qh/6NjcSDJC7b5Y5cbTsRiikGnPqqb4XK88nGOFSb+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBzFCUZ9; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63cf0df1abbso1110760d50.2
        for <linux-edac@vger.kernel.org>; Thu, 06 Nov 2025 08:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762446711; x=1763051511; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mLV2PDnl4Ik3dMiBcJ6vRzCiNGFzAVWq7I4DrxmSPKg=;
        b=BBzFCUZ9klIovMxrLDKf0AEhQdmPaaLkdGiTL288rj0fGIr9iv6ugiMZ5LaX9IXg3e
         NEsYmUCYxI9YQH0TJ+SlPJF43CLL8orJ5aoq2UwEEaRudocQIGfxLI7ZDRLsDQr55H5l
         of1OvbAOdbkTyabjovfm78lhobzbEHmRAUwf++rBpVU3VlKfnGNPQ114ylm1JumfCOIk
         P3YHAyVfROWFHawR+a7+f3vErlsnAL01GIvGkZQgnB/m1mYCgbRmY3TQRYb8dU3k3PVB
         83srIck9JQaRNAVE14W0n8NRAUyWXpo8RrhmNGkUnpYu7qsvJiv6u9UKl5VZSxWL7TVI
         uTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446711; x=1763051511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLV2PDnl4Ik3dMiBcJ6vRzCiNGFzAVWq7I4DrxmSPKg=;
        b=CUGbEIePCStejoyJaIJ1a/WKGKTyFLMPVgU8kxDLV7zUyzF7c80uzK4oL8hKDBk1Kn
         k8V9PJVRSfoU0DBklessvQJBgyk2FGUc5cx6afK8bLsZyD0nHCPdGhVf223O48BVwgDT
         NRMVl106qI033lemnhqFkA2k75qy8JaEn3+gV3o47snECpalSaTWdTkLJvsZePDo0WGi
         lS7kRbwJCCbyYpB+Mrz4erZMl4ueDaVkw4N1EEzGl7KvDIXYt0GR8yTwMjIoe+mMYHBq
         NBqEuw5+P8Y4bRmszcSPsU/KoX4Fg2d8vYhR+BATde9rK09klRTh7LfjUOFEFNILI25I
         /VEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJlU+s6XPCyu7e9nMTtMSmBZSgpaY/LhdDy6D/sVAf5dRE360GYdqQUnG2kJ4OgOIKyupzW5a5FmZL@vger.kernel.org
X-Gm-Message-State: AOJu0YxMhVTJo6AkajdlQfgNDw7uOQSKJf+tmDyFq3wZ1x2eEoCdywuW
	4cprhanpU1As3097Fk/sNEAFbvnacnHbY74PGUIpGsNMNxZ/RRCRcXuz
X-Gm-Gg: ASbGncu/23kp3v/+KL0dSPfXatsET+viLJu5Gekv9ffZh+42Y7C/1mJjQ3o+N/vgldH
	54z4RztUiGIbMOPwKRwM2SYzozeu7nYhWCLMpG9vK5jNrC2XuzTsF0Rxl6z2a0wX/QjzpUBVI3u
	kfb8h2G3OFOUZWZypKM2M4QWwpw1FlAVCEwVTXSOuR0o5whplcuVw7PN6myHjyTLRzyfSWDgiFN
	u4qPEaKVXGuYb217iXWaym+123wP/UQmc1+3VR0xY0VnALCitFfFwARIJDLA+ybZIU9ozCiauhQ
	ZYwdNTtIXpVMBh2qTn2NK6ts0mfQYXn4iLZWd5hplTsooGKpNWOfLj8NGvZEwwdmm0z9XalhoKl
	qiMl+5/+B8VKB6GMvG9X2vc3eWqIebGYppkCqivLx2x6pZ5IMZkt+ZhogJYD3N9SbG270GZyhKP
	of39WOPOYwkOFWHLJd7Ls3ezWFEX8h1iUS
X-Google-Smtp-Source: AGHT+IEpqWmkZjuH3DQIeoTdW2YBETsoULiRC/YJVd9G+NTFiGKOkPxXPnseVKzqKGSB50LDoYAi6w==
X-Received: by 2002:a05:690e:4109:b0:63f:b9d1:b165 with SMTP id 956f58d0204a3-63fd359be98mr4428593d50.50.1762446710597;
        Thu, 06 Nov 2025 08:31:50 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5d94487sm902855d50.21.2025.11.06.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:31:49 -0800 (PST)
Date: Thu, 6 Nov 2025 11:31:48 -0500
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
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org, qat-linux@intel.com,
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v6 13/26] bitfield: Add non-constant field_{prep,get}()
 helpers
Message-ID: <aQzNdJFcStVak5jS@yury>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <62a5058e460129155e4e7539e37140bd0f0d4abc.1762435376.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62a5058e460129155e4e7539e37140bd0f0d4abc.1762435376.git.geert+renesas@glider.be>

On Thu, Nov 06, 2025 at 02:34:01PM +0100, Geert Uytterhoeven wrote:
> The existing FIELD_{GET,PREP}() macros are limited to compile-time
> constants.  However, it is very common to prepare or extract bitfield
> elements where the bitfield mask is not a compile-time constant.
> 
> To avoid this limitation, the AT91 clock driver and several other
> drivers already have their own non-const field_{prep,get}() macros.
> Make them available for general use by adding them to
> <linux/bitfield.h>, and improve them slightly:
>   1. Avoid evaluating macro parameters more than once,
>   2. Replace "ffs() - 1" by "__ffs()",
>   3. Support 64-bit use on 32-bit architectures,
>   4. Wire field_{get,prep}() to FIELD_{GET,PREP}() when mask is
>      actually constant.
> 
> This is deliberately not merged into the existing FIELD_{GET,PREP}()
> macros, as people expressed the desire to keep stricter variants for
> increased safety, or for performance critical paths.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Crt Mori <cmo@melexis.com>
> Acked-by: Nuno Sá <nuno.sa@analog.com>
> Acked-by: Richard Genoud <richard.genoud@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
> v6:
>   - Align \,
>   - Add Return sections to kerneldoc,
>   - Add Reviewed-by,
>   - Document field_{get,prep} in top comment block,
>   - Use less-checking __FIELD_{GET,PREP}() to avoid build issues with
>     clang and W=1:
>     https://lore.kernel.org/all/202510281335.UpSLYJG9-lkp@intel.com
>     https://lore.kernel.org/all/202510281414.DnejZh4n-lkp@intel.com
>     https://lore.kernel.org/all/202510281304.RK3J3c3t-lkp@intel.com
> 
> v5:
>   - Add Acked-by,
>   - Split off changes outside <linux/bitfield.h>,
>   - Document that mask must be non-zero,
>   - Document typical usage pattern,
>   - Recommend using FIELD_{PREP,GET}() directly to ensure compile-time
>     constant masks,
>   - Check BITS_PER_TYPE(mask) instead of sizeof(mask),
>   - Wire field_{get,prep}() to FIELD_{GET,PREP}() when mask is
>     constant, to improve type checking.
> 
> v4:
>   - Add Acked-by,
>   - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocate
>     power management debugfs helper APIs") in v6.17-rc1,
>   - Convert more recently introduced upstream copies:
>       - drivers/edac/ie31200_edac.c
>       - drivers/iio/dac/ad3530r.c
> 
> v3:
>   - Add Acked-by,
>   - Drop underscores from macro parameters,
>   - Use __auto_type where possible,
>   - Correctly cast reg to the mask type,
>   - Introduces __val and __reg intermediates to simplify the actual
>     operation,
>   - Drop unneeded parentheses,
>   - Clarify having both FIELD_{GET,PREP}() and field_{get,prep}(),
> 
> v2:
>   - Cast val resp. reg to the mask type,
>   - Fix 64-bit use on 32-bit architectures,
>   - Convert new upstream users:
>       - drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
>       - drivers/gpio/gpio-aspeed.c
>       - drivers/iio/temperature/mlx90614.c
>       - drivers/pinctrl/nuvoton/pinctrl-ma35.c
>       - sound/usb/mixer_quirks.c
>   - Convert new user queued in renesas-devel for v6.15:
>       - drivers/soc/renesas/rz-sysc.c
> ---
>  include/linux/bitfield.h | 59 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index bf8e0ae4b5b41038..f92e18c9629a59c6 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -17,6 +17,7 @@
>   * FIELD_{GET,PREP} macros take as first parameter shifted mask
>   * from which they extract the base mask and shift amount.
>   * Mask must be a compilation time constant.
> + * field_{get,prep} are variants that take a non-const mask.
>   *
>   * Example:
>   *
> @@ -240,4 +241,62 @@ __MAKE_OP(64)
>  #undef __MAKE_OP
>  #undef ____MAKE_OP
>  
> +#define __field_prep(mask, val)						\
> +	({								\
> +		__auto_type __mask = (mask);				\
> +		typeof(mask) __val = (val);				\

typeof(__mask), I guess.

> +		unsigned int __shift = BITS_PER_TYPE(mask) <= 32 ?	\

Same here: BITS_PER_TYPE(__mask). BITS_PER_TYPE() doesn't evaluate the
expression because it is based on sizeof(). But we definitely don't
want people check it every time they read the code.

No need to send another version for this. I can fix it inplace.

Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

> +				       __ffs(__mask) : __ffs64(__mask);	\
> +		(__val << __shift) & __mask;				\
> +	})
> +
> +#define __field_get(mask, reg)						\
> +	({								\
> +		__auto_type __mask = (mask);				\
> +		typeof(mask) __reg =  (reg);				\
> +		unsigned int __shift = BITS_PER_TYPE(mask) <= 32 ?	\
> +				       __ffs(__mask) : __ffs64(__mask);	\
> +		(__reg & __mask) >> __shift;				\
> +	})
> +
> +/**
> + * field_prep() - prepare a bitfield element
> + * @mask: shifted mask defining the field's length and position, must be
> + *        non-zero
> + * @val:  value to put in the field
> + *
> + * Return: field value masked and shifted to its final destination
> + *
> + * field_prep() masks and shifts up the value.  The result should be
> + * combined with other fields of the bitfield using logical OR.
> + * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
> + * Typical usage patterns are a value stored in a table, or calculated by
> + * shifting a constant by a variable number of bits.
> + * If you want to ensure that @mask is a compile-time constant, please use
> + * FIELD_PREP() directly instead.
> + */
> +#define field_prep(mask, val)						\
> +	(__builtin_constant_p(mask) ? __FIELD_PREP(mask, val, "field_prep: ") \
> +				    : __field_prep(mask, val))
> +
> +/**
> + * field_get() - extract a bitfield element
> + * @mask: shifted mask defining the field's length and position, must be
> + *        non-zero
> + * @reg:  value of entire bitfield
> + *
> + * Return: extracted field value
> + *
> + * field_get() extracts the field specified by @mask from the
> + * bitfield passed in as @reg by masking and shifting it down.
> + * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
> + * Typical usage patterns are a value stored in a table, or calculated by
> + * shifting a constant by a variable number of bits.
> + * If you want to ensure that @mask is a compile-time constant, please use
> + * FIELD_GET() directly instead.
> + */
> +#define field_get(mask, reg)						\
> +	(__builtin_constant_p(mask) ? __FIELD_GET(mask, reg, "field_get: ") \
> +				    : __field_get(mask, reg))
> +
>  #endif
> -- 
> 2.43.0

