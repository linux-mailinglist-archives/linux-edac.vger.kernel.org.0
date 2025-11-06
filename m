Return-Path: <linux-edac+bounces-5396-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D273CC3C175
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 16:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26F07350FEC
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 15:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A18C279327;
	Thu,  6 Nov 2025 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RCBBHmI5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A6128134F
	for <linux-edac@vger.kernel.org>; Thu,  6 Nov 2025 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443408; cv=none; b=dGrJjQ3hRlF5Zn+g4ggwc4Oo0ISlmOc8Gt31zjcYxaNNQnV2FRT7uy1OWOQ6fLwPu9MQmaHW/VAnwt06Dm/bqozKAmNkSqW/SIvFopyKQYI1ILbIEZFFCq++wo2HR/lLSitvT06W4WoOnGOLsXBp0cyXJeBFQG0tze30w1alw4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443408; c=relaxed/simple;
	bh=xk6l2WOOOp6czqXIg1WfykCAiMAdHCUw6VSHs/tqjfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4V7btwnNz5oEKdDT4+mgBQqPhSfIB9qcLO5FDZwEsPUS4iLzrvry3VteNbm4p4GsLsrk1hXTUgN69qxgh0C0Fn5RZgc0SjHihIMpE/vdVCHybB3xdolO3F7mweDjqZyMx/iwgkwU5GFWUPRWWOzgy87Xv5OBIdRF9s2JwoA24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RCBBHmI5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477549b3082so10458215e9.0
        for <linux-edac@vger.kernel.org>; Thu, 06 Nov 2025 07:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762443404; x=1763048204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NoiFfWZaW31Ma9mD3WuZZQSDOEMD5VY8nTTYH6Ca1fs=;
        b=RCBBHmI5NJuL/b0QMZqwJKF7ud8TA4ryMo59VDUQpnay3XsUAvEHe9LO/fOzuRpsZT
         Jx1NFanVf4S6AnMyYzJCnljlJyN6jxlel+V/rblI5B/Ke6DaEPf+ndUzWrqDMCP+HdnB
         uDl16AbXtCY5QarJXQGxMW4weytJLsYo/hhgWgTWp6oEXUmaIM9yVLpkAXqAknXGbXx1
         QuqO79EbjR+FpS9ROH8ywiCYKLR1Vo0TveRfPl4UAmhu6xulcIFSO5a0/1OJf0Rjev67
         yegxuQY82ZCP4p/4NvCgTDGdk/lzzVLD1htvb51kbSpM+eaB4whicLPwz/DWF4glUFn4
         0IHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443404; x=1763048204;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NoiFfWZaW31Ma9mD3WuZZQSDOEMD5VY8nTTYH6Ca1fs=;
        b=sukWP39oulACQdMt9MhInziyoK5vb1cRf9mrESeSWmaQetFqYXBXSy8TqQ8tGtOl/D
         xPVkduwaGtBa4u9Kq9lX4iSGFF+95pk1uJh4dzBCN+SlQncQhZRTV56/CarvtiPNSjvT
         /dXlFcnvorcLPgBvlwqCIoqval9mKUqFkxgUhAWl51Bt6P9pxnsVjUB1W4UPVnDOJGfT
         WERmpTZmf88tlHl3ddmnGXkyNyjsdov1N5Awb1Xw2YaZzsDI6lvPb/WotXZvXE2ToWjn
         om4s77pehI9pnEwKPNs9OEDeaSQz6GaTxDB+o0V4CAUZcu5zSJc/xMyYvicYgdq+2CF1
         69Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU9WvZTcjDNL5KfdDBM7GXQ8o9DxyEOxon0WAfpRrNsvDLr2JYVSQaXOh80vW+pye/HHoK/a03bFR9W@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb9BbeBu5UjnL5yyval/BPj+4BUIytvB3oCpOGs9hbb2t/eQR8
	0rtbnNOPiosA6FfmOLzOikhAAe19uoVBCRAPy0NzYlXU27moWkcWrYlH4faGLFk5fY4=
X-Gm-Gg: ASbGncsniOEvrpe3ctHmfPM/w8+S012Go4CfSesqgFf0DGHiE7qqK3aR7ZlI/WhylXL
	9qGyJQ8qERKHR1ps9EYrUJwEmWOp8CZYR5uHwe5N7JgL7B22NjaUymgAgPsVzZ6m2LevETvyFOb
	AfQynvfyE/fuBtiziXcwmQ6k3FCvDzrUEIB03fkMtzfOkt8VgKkDPIKA8/0Avf7jfdFtj6IgoTn
	xaXwuMfI1b4EUCwGJSFuE6fxZUH71v+MWG64JQBy2t48icjb9STQ/IaptW4vzvTZssbY0j6EYTT
	aAVlqC8otKFYkXzLyga5mClOBwwNr3SHwwftgN6VEoir/jpDmCzQeIhrvC8GL58LRdPa990X7p8
	2Y5aMn7SI1h13efKq+MaOwxeaRhbLH3WDTbqNcgdO+XoiFBxGzrxOZ4PXd90ndQh0QVD9hInwwo
	f3U0R2j9qOS/Jz5ipoY9I=
X-Google-Smtp-Source: AGHT+IHm/6/RnHvUQpqjyEKIYZGBSjHuPRp5b3DBLGbL1GoDEzCDZheRRGUhzX2BHAHpgilQLx/Q7g==
X-Received: by 2002:a05:600c:621a:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-4775ce206f3mr59734595e9.33.1762443404278;
        Thu, 06 Nov 2025 07:36:44 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477622f42a5sm98437525e9.1.2025.11.06.07.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 07:36:43 -0800 (PST)
Message-ID: <d1b02488-7722-4b39-bb8e-f7e5c8e11b1e@tuxon.dev>
Date: Thu, 6 Nov 2025 17:36:40 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/26] clk: at91: pmc: #undef field_{get,prep}() before
 definition
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
 <939d8c6da1f468026b1bb201413ba08b1d0751fd.1762435376.git.geert+renesas@glider.be>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <939d8c6da1f468026b1bb201413ba08b1d0751fd.1762435376.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/25 15:33, Geert Uytterhoeven wrote:
> Prepare for the advent of globally available common field_get() and
> field_prep() macros by undefining the symbols before defining local
> variants.  This prevents redefinition warnings from the C preprocessor
> when introducing the common macros later.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

