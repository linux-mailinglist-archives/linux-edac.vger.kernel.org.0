Return-Path: <linux-edac+bounces-5397-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE2CC3C1D2
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 16:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B877F351585
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399A62BD597;
	Thu,  6 Nov 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kevjdNmR"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192E729B8E5
	for <linux-edac@vger.kernel.org>; Thu,  6 Nov 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443604; cv=none; b=u9EcPbHW3vEKNAc+iyFrfjlH2HWjHKX2QMkcPTIWulQvJzARo23sP/zRCYCed40/H7BCNXU1zgthd7PfvU6F8jI0hVAmh+tSXdH/BxyXpxg4qKVjuvhmckmpFEL+piiTpIhTSTicAAdaxZNjRFLEPDOfSTqgVEyxNiNlwV7lf2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443604; c=relaxed/simple;
	bh=OvVab99hJjNyRIYEydBN0V5gIv2r0yCOEdtFZCKRP7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsvxabE12kfdxNk3eYa2XMYX5N8yjP13ruVxi710a6U0DKjla7/rGCv9FRdwyHTckLCSh13QOEQWx6a91pOj6A/Mr2id3MB+rB5p8p7YT+RuV3sLbZTH1BPHfCmZBVs4i191OyxHcAZ2vBswYJinIPzR9d4AiyjACTu/tbr72H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kevjdNmR; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429b9b6ce96so844908f8f.3
        for <linux-edac@vger.kernel.org>; Thu, 06 Nov 2025 07:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762443599; x=1763048399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCImS8vAPGN6LTIAPQAR8IZZ+CU8X+89zO49Z6Ixv/M=;
        b=kevjdNmRx/vPItHpbAA8Fj/gaSq9j+ClmImM0Wu41WWm99Io6fzx1WKICnV2NjGuga
         7IPYAskhRW4/AmYolW7YBPO5Us9+jZsIrLHiG60JwBHYXnsUkPauVfjnTaE7HaGJ2vb9
         YGNWemlzo8c5S8XaxIUhpJdfzy1o0vDVeYDzanJ7FEzuwIBnVjTH+A2WC6Akerw0Ujh9
         XdXdYQ+U6S1KSzGZWRK+gDlIUg3OtdsU6dsVGLp7OZhbTOU7VORIj2VozYwXtAmuFWWY
         NHgSOcI4vnO0JmiT4KN7GSGhmyfgV6CH/JaOMA9Vvl/ijiQ7GjMFxUmDrbMY5N/29B7v
         jW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443599; x=1763048399;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCImS8vAPGN6LTIAPQAR8IZZ+CU8X+89zO49Z6Ixv/M=;
        b=qHH69vH7wxtR/EdS2aQTnl2qgCX5paVgNr7S1seoKNw1Ll9Th7K0FxRLGgjh7Teuz+
         0CD9PQX+p+Bit9C1oXzqANyEy5iXWa1Tg2b2jlJDPOob/Sw5Y+wX5qsUZ/aFj1JLa2Yb
         Lg4v6AcfuubTJvwnNF7ywfmm0IhfZAwdqeDvMF/OQj3e8flJ0bzfOCJUJbbyq9L3V5XT
         OTM8CQXQiiGgbdE1zciJKvyy5MyNYcHKk8X1aChtVi3LczyWKgE0FD6cKitM0WQu29z8
         qK14ERuPNOGJThl1ntZpbpTcIgbviQUad8qs8sp3X34ERSKYTMzXZZkmo1dLXViNCSdw
         CMPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKb7/RnqKaaF33WKxDnPsFiitfNTVLqvSfLKCbNtEQB0y1MD8U93K2mYRI1/SKL5woUSu1FPXgiuLM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5p7SY+SK4ysX7JD6qOOjJd9yQJemHqMx0YiNtrg8sz4zbhgWl
	Yak5jBPjA+8Yo03zz0ovsF6aIsx3usnPsHBBICL/CBDqALnd9gdQ0XDhAYx//Q05eAY=
X-Gm-Gg: ASbGncvD5BI74prK/9w6ozQJpf7EUlJnq5j021AsD+2QYZFdBx50mosHOUz1QNhWDtw
	v5K/ALU4P4YJir8XzF2+k61OjAi4qU+3PMDf3mzDnzym2MxvaIts/edjb5kdsAN3JoxQ5+pmu9G
	XuBK1m8t/fLMG3qsTj/PQ8fMyS2qhdk2PZoPgpQ3+R3QyGMlPuuy9Fk/vPYULaLiIty5nFxdU/C
	91eWVF8Vd6JgPgMXprY+x8xHTosiA7jIKW/oyDyaLh+Va8kCg6thQCCQ6m4FgGz4Te4X7kp8PUW
	HWH9LFfMp0b6WrQKbEpPmkPrKGg+W9lzggDKq9VIFBOiYJxumybLI8lYajYZfKFjX9bqY8rkaSt
	eTwz9faeTxC/6ZPkqQ+htIiV9hLZ4txJUwgsZCKGx/WV7C8gkp3qeUnXjBVz78ulBgXY/lQR4wD
	nFV4x6dSzA
X-Google-Smtp-Source: AGHT+IEnd90RJHx7ZuzW87zs5Q4EEB4nWgY3Vtjy9fpk248/BemBXzC7fRUumPfx0M4xpvI1GCS0qw==
X-Received: by 2002:a05:6000:2510:b0:429:d0b8:3850 with SMTP id ffacd0b85a97d-429e330b68dmr6675168f8f.48.1762443599342;
        Thu, 06 Nov 2025 07:39:59 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4772basm6489913f8f.26.2025.11.06.07.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 07:39:58 -0800 (PST)
Message-ID: <181cb561-4fdf-49c0-aeb0-85844411a6ad@tuxon.dev>
Date: Thu, 6 Nov 2025 17:39:55 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/26] soc: renesas: rz-sysc: #undef field_get() before
 local definition
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Yury Norov <yury.norov@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Miller
 <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>,
 Alex Elder <elder@ieee.org>, David Laight <david.laight.linux@gmail.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Jason Baron
 <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Kim Seer Paller <kimseer.paller@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Cosmin Tanislav <demonsingur@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Jianping Shen <Jianping.Shen@de.bosch.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-edac@vger.kernel.org, qat-linux@intel.com, linux-gpio@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1762435376.git.geert+renesas@glider.be>
 <7feec8e9cf823dd365d6e0f21004f943964e52a0.1762435376.git.geert+renesas@glider.be>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <7feec8e9cf823dd365d6e0f21004f943964e52a0.1762435376.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/25 15:33, Geert Uytterhoeven wrote:
> Prepare for the advent of a globally available common field_get() macro
> by undefining the symbol before defining a local variant.  This prevents
> redefinition warnings from the C preprocessor when introducing the common
> macro later.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>


