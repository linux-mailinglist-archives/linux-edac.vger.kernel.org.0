Return-Path: <linux-edac+bounces-5399-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A8CC3C2B3
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 16:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9343ABED2
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 15:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369D30DEAC;
	Thu,  6 Nov 2025 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oyafMGVj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC2302179
	for <linux-edac@vger.kernel.org>; Thu,  6 Nov 2025 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443900; cv=none; b=lKinzvM0OEMFXdiJrcXnSzkNFBBf7+P5fkmGNQ9cZMwqm09Z7rmyITitB7t4kZQ8QSf3mfR3MRzp7A/4QXNlkyEy8PADQAaUobeogOiGXc+ulx8ZrxN+yOaTp7UxqvhgziNbsxaIt+WHW81r23vGHp8hR9evIBuabRUjhkCTJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443900; c=relaxed/simple;
	bh=ir86bNXUyXX52mY7hjK0YW1lIK6fPwyN3rKPVErB4Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1FM7h2P1u1sc6+NIZk1rltcT+UdqxreUsIcEnU+Jc6xyHIPLX4hKP/8WxP+2Rwgt3S79APyAj9OyFvpQDrBVLXME2G7nTcskKAEJ28WJkjTJtTxNa2BIdKKQKHq9I5tc7iTcVraq4aKIYhue8ikl0gkLexYbEEZ2Sv7hBGPdEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oyafMGVj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47114a40161so11454175e9.3
        for <linux-edac@vger.kernel.org>; Thu, 06 Nov 2025 07:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762443897; x=1763048697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDBfIt+d555CHw458VAbNG3bfHQEwmpPFewi9LatYFE=;
        b=oyafMGVj8rfucZtwMDNT7+phmmyZ8dNEZOYEY9Q57QHqZJoyoIJ9OQJpzpssPwAAUY
         p1cucHLkqadoykScHTYiZZygeQ/2+y+X9FXBBrzheC8maMeT3KaSdcKzfJuIAtFiKMVD
         9bTv3YnG5FJcmpkd662vPds4xEsAH7Ni3IcYRWHdk2BAh9rtXwffQmy39LFYYprGFkbP
         NHwOTlJfQ9UI2vyII4ONRiqWKMGAT4G38zP5/ICf0lH6eDc/WqOChblx20cnzIVdMf/s
         +pkDF7X4DR5yijB/jniXDKERhHa0ItlV6wMuNhqGMXQxnO3rr/fg61KyjIC7zgKqc47F
         I4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443897; x=1763048697;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDBfIt+d555CHw458VAbNG3bfHQEwmpPFewi9LatYFE=;
        b=sLKv3gXn/8hHoEK+UHs+Bg54wlwlLsCtVNIqf50VFu7At7XWRGDk490XFzv5XeieF+
         +OmERsfkh1tdyj5P71rKeXlRqA7MQ9B5yfzHVsiv3leR9ZxpPnXfUAaBH+duFpAN+TMa
         TkTRu8P1oZE/quN8NXMp55XHtyhEt5u7Pp41VUcjevJUSvWPQFv9VPsZIofGGaWFcQ2H
         VxE+jwUqi/6M6w9eCaNqMoCM/cNtix0hFExudVSnX23xy1Ysyy/y36kZlOquj9Mzx9mq
         ZLz/GYhn56ZpKEvC26rfuOGOHTR1BwTPm2Rx7sIvSxFN0EKywiBhP/6L7wdNcKH3vSN+
         F5yw==
X-Forwarded-Encrypted: i=1; AJvYcCX5CArQWhlPC1ZfJBNYY9Sii228w75hdZcrFfDLTi2c2c3pNTdZZSzCLKbTA61gYR3pRhNbLZPjvOeZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv2omZaQbJRyoeQjUrMyfSAyE/Jc+8wSRnOtF/pGqqfG/UXBjM
	9xXz22i8yGs3eP53UZzQl2CNO3jWhSdXWBfhbZZ493HvHhlfOKco//BXsntAbB92xn8=
X-Gm-Gg: ASbGncsfbkXtagh65TQ0RqLvZYPozBDQHeAp8jEYxaByPIahPz3uv1DD23vym36V0l+
	PStRqDG0znK8w8cSdsNBWE02EXPcOfaUvUVYUZQ429LuR4q1DYBuQvaEmjIJatOvQ167tWkKk3u
	lbpaMlUcLb9YoGwWNrdrZbiSkrGgzJUbBSIXWMdD2HsI22babiFh4qCmL8DjBUBjhEXfrK6H+j/
	LdFR+WMwkQEUu00ltl/yIdmfb/jGiKwdpL5CNpMr5+CopNadLe6g50mmGVIw9f/2WdQT1CZZYMU
	I9KqoBQjGyb2z8LAhHX6CAXquRNvq2tmgX/zFC97YlLniFvPhMGfCNlJe4faE6ZgxxWxzXwakLK
	qT2tOZwpqku8AxVTO2zXvDUlF5d2ROe8VvEmc4vTpUDdkw4ukwHF6PFBAC0jZSGsJo/EPwWtzIk
	oDY4D/wlV9
X-Google-Smtp-Source: AGHT+IEAc10N1RtkN4NVSk1Zu24SSpZFPG8gHp4xc27V6x28O5IWRTQBVQkr2p/iYh6QAS/I0T8A6w==
X-Received: by 2002:a05:6000:310a:b0:429:c8f6:5873 with SMTP id ffacd0b85a97d-429e32edf7bmr7715744f8f.22.1762443896966;
        Thu, 06 Nov 2025 07:44:56 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40375bsm5553906f8f.8.2025.11.06.07.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 07:44:56 -0800 (PST)
Message-ID: <509b427c-5586-4c92-88ad-16bbde7c3f92@tuxon.dev>
Date: Thu, 6 Nov 2025 17:44:53 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/26] clk: at91: Convert to common field_{get,prep}()
 helpers
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
 <7414c080bbacc3c5be00c0eec4f5cbca386acaf3.1762435376.git.geert+renesas@glider.be>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <7414c080bbacc3c5be00c0eec4f5cbca386acaf3.1762435376.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/25 15:34, Geert Uytterhoeven wrote:
> Drop the driver-specific field_get() and field_prep() macros, in favor
> of the globally available variants from <linux/bitfield.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


Acked-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

