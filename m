Return-Path: <linux-edac+bounces-5476-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B597DC6F7E6
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 16:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 3CB152FE31
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D3D36B05F;
	Wed, 19 Nov 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsmAN0H0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEF21B4257
	for <linux-edac@vger.kernel.org>; Wed, 19 Nov 2025 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563835; cv=none; b=Mm0wB4sDnrCUBhQ3FrtMy6a9oZkkObw5agECPZm7QaAZ4kQ2B1VuvLSxpXTGICLAe+JX2ZEkoXq6IIXNT/RZrewLSlfIdNhsL5XtNtLEBs38+ZT7e8JSx6YRUQ6f1nWFdApr0xEn0L2uECfdhxFryAu/ASTMBsyuKXjpTst58gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563835; c=relaxed/simple;
	bh=1Wruu9gggvjosYoKum2V+cZ9fCd6dFFd/5SKcpbFf7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3KHJqCLqdgXKVav/Ysuve1i5fAOq0SZyfDGwy6BBUvbdXe26XXPwJ5iWPo33aFQQoCKa5EOiPzDJrSzGB6rbN1Q0T29HuU/g4H2MiNIGDHBAR/PGDvyRp3COvM7eZJeSZfFF1+pFHWMczF/BBh2GREz0kgQFJel2wYkAUGMUEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsmAN0H0; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-882360ca0e2so50020596d6.0
        for <linux-edac@vger.kernel.org>; Wed, 19 Nov 2025 06:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763563832; x=1764168632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UEa5dU5h8VTkStggLA2EFBcu8SFqsu0VyRflw3qSQbY=;
        b=SsmAN0H0dW4pniwEPfi7ntnomTvrnK0bOh98GRqlM66jfMIRrCCmEP2AvXC3HRRCmV
         7g/qWz/7yxs1plOWoLSgEZFqXqMOfVAES46UCC3gAbXavKi2qNkqks9VPXfNYmkzGuFd
         Q5I9V127jwdVG17TFwwx5snj3oIsqDAQ4U3ZDMIjFeJBPC1kDbDek9H08MwcYqowfH2y
         OG+QJJFzNqeD0YdjzmGTC9LhWa1frGuIlT1/8whm+I2RPHXYOfLqG7/tExznEqIkOaLF
         MVab0MlufwIXjF/3XH8b7kl/bcvgJoS2Kb6Zaia++StlKQIiiuC3nKR94iY+PKgXA6a8
         5wbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763563832; x=1764168632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEa5dU5h8VTkStggLA2EFBcu8SFqsu0VyRflw3qSQbY=;
        b=a7+xUuTL1Tq0AkB9l5cakwM/kl1kmW2eNVxfnVr4kZbIaxKN6bJPpeBoXJ3LnkQZvW
         ZkSMUm92LzUGf63icSefuAwP01UIkr8kv8U8qVj1qojCM455AYaZ/RcKZEt+TbIGE61x
         YgkBAxDqPsoxZ11LRzETrV0okndsFe7sD8HPqTQj1InjfCSuVVxbACVYYuZEMnx2f0IA
         qpbiMPXC8g0iobs2VL6Dn0YhSKpBusiay3bmGGJ7WmPKuoxWxjzfp5H5OLn4Yd1aKqoe
         GzNsVO/v+MiEI+O375WetaZlWcV1YxIJ81wQ8fmgFnVOVSKcur76ql3YfRR85M5TaLYd
         BNNg==
X-Forwarded-Encrypted: i=1; AJvYcCUDa1MJv7IqqG1s5GiiQ+9qHRRJGNfK/VhuT+K+zWiESv7FOobLUykTV8KeJgIhqeZuYF2QcKVGP97C@vger.kernel.org
X-Gm-Message-State: AOJu0YxOsCZcIL3diKbWAVHSVYvIIdGt+tTJ+7Rg7Wlx5QtFeiRYqG8M
	3g/8xVqKCsgw/uvqUHKnTNlEySPuO8NQyFSbSlhZoP8Ex5xHMEo90RLs
X-Gm-Gg: ASbGncu5rhy5w86uny127YZ3Np3G4Jz55L71mrwkxwiYmrgV3vJPfpJx5CxwN6HoB48
	urqbxLEznldJhaoS8wmZknZt5FeYEi4iNry0aBuFZJaMm9nPfvGfe52ZV+lD+Wup95ivIiG1hp1
	cu6E4qPorLFtxy3mjjeAM8KVT5h39+YCsoghoK5mAnn/Q3O6Hwe4Ge/t1LehOESg3Sass3SG3zu
	h9T1DP4Bnj4QTw/GRkBL7AmH1dbM3fu1iVwWDvmIMYiv/RTY4ApRCaphI8/sGajsCpP6dfCbjTU
	G9d5IyGhHkx5PCU8wn2DkD8jwSlJHynKxh53+2yr35h31L2+teCoj1lGWlcWexmQwx7k2Vz8yfo
	3W2LQmeFNjr+COi5TwNvIOXgVyY19a7CTy8ELuSC3NcgqfkATBiOAulcXmd8Sr8Y8a7TKdiEMNs
	b6obRhbJlFUTp8O4bW9Q==
X-Google-Smtp-Source: AGHT+IEl27VY0Fzg06WvTYKsPnTaG3CI8XR1O4Jx2OOSNMzexShqbizbMp95FvmlDbVG54xJ6MBR9A==
X-Received: by 2002:a05:6214:529d:b0:882:49f4:da25 with SMTP id 6a1803df08f44-8829269e07bmr301776726d6.39.1763563831679;
        Wed, 19 Nov 2025 06:50:31 -0800 (PST)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882862d04e1sm135929226d6.7.2025.11.19.06.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:50:31 -0800 (PST)
Date: Wed, 19 Nov 2025 09:50:30 -0500
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
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/26] Non-const bitfield helpers
Message-ID: <aR3ZNmSMmtSsUR23@yury>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <aQzQjSMOSrUIgMCL@yury>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQzQjSMOSrUIgMCL@yury>

On Thu, Nov 06, 2025 at 11:45:02AM -0500, Yury Norov wrote:
> On Thu, Nov 06, 2025 at 02:33:48PM +0100, Geert Uytterhoeven wrote:
> > 	Hi all,
> > 
> > <linux/bitfield.h> contains various helpers for accessing bitfields, as
> > typically used in hardware registers for memory-mapped I/O blocks.
> > These helpers ensure type safety, and deduce automatically shift values
> > from mask values, avoiding mistakes due to inconsistent shifts and
> > masks, and leading to a reduction in source code size.
> > 
> > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > constants.  However, it is very common to prepare or extract bitfield
> > elements where the bitfield mask is not a compile-time constant (e.g. it
> > comes from a table, or is created by shifting a compile-time constant).
> > To avoid this limitation, the AT91 clock driver introduced its own
> > field_{prep,get}() macros.  During the past four years, these have been
> > copied to multiple drivers, and more copies are on their way[1], leading
> > to the obvious review comment "please move this to <linux/bitfield.h>".
> > 
> > Hence this series
> >   1. Takes preparatory steps in drivers definining local
> >      field_{get,prep}() macros (patches 1-11),
> >   2. Introduces __FIELD_{PREP,GET}() helpers to avoid clang W=1 warnings
> >      (patch 12),
> >   3. Makes field_{prep,get}() available for general use (patch 13),
> >   4. Converts drivers with local variants to the common helpers (patches
> >      14-24),
> >   5. Converts a few Renesas drivers to the existing FIELD_{GET,PREP}()
> >      and the new field_{get,prep}() helpers (patches 25-26).
> > 
> > Alternatives would be to use the typed {u*,be*,le*,...}_{get,encode}_bits()
> > macros instead (which currently do not work with non-constant masks
> > either, and the first attempt to change that generates much worse code),
> > or to store the low bit and width of the mask instead (which would
> > require changing all code that passes masks directly, and also generates
> > worse code).
> 
> Everyone please send your tags. I'm going to merge it in
> bitmap-for-next before Monday.

Fortunately I didn't specify the exact Monday. :)

Now it's in my tree for local testing:

https://github.com/norov/linux/tree/field-prep-for-6.19

Will move in bitmap-for-next shortly.

Thanks,
Yury

