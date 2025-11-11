Return-Path: <linux-edac+bounces-5435-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ADEC4F90E
	for <lists+linux-edac@lfdr.de>; Tue, 11 Nov 2025 20:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955B71891240
	for <lists+linux-edac@lfdr.de>; Tue, 11 Nov 2025 19:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC454302169;
	Tue, 11 Nov 2025 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAB3TiSt"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78742571BE;
	Tue, 11 Nov 2025 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888668; cv=none; b=TBb/aWU0jTg8i0jrNz1WbVOW3lAeZPR7pCcbL2SO9eWbBAbFI+p5TLUiNcOnDjVktgn9W0YfppWECngOdTywYmQjWyoSJu6uPH1bVs7nXt4oXJ3+sCo3WrPnuAlntbUuEeGRWuy8nHCSlFm7j9UjmzfZjzZ/AGSSPdh3KFkWX3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888668; c=relaxed/simple;
	bh=41RLRtaKbXKVyhTCyKGvYapSSOb8728iYPhMLtH1kSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njk41oaX0JhW9Mt/26CCUL8MvphIpHTP/uT229bHmQbCVE0u/e6FsK8isfCKz77W0NicfbISBjWgpbhHRB+dVO2YlBLaGxAVFr8SdN4wroFJZ+k3XA4sOGHPzh7eLcmrDIAyc9jg0e4h8LDgBXo96EE927CYGEwbQXHjbXZT8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAB3TiSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8EDC4CEFB;
	Tue, 11 Nov 2025 19:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888668;
	bh=41RLRtaKbXKVyhTCyKGvYapSSOb8728iYPhMLtH1kSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WAB3TiStxkM1FNwO8Op8NHHDZWFMtIxWcQcyMeysB/zEXMu7NC5jN7X7oCAZuO/uB
	 kcb7FtT/bygYU7KdFv5BXUDnSmTnFkOZ8nnrMugK3rc8YAb9Myqj0+j/30pn8eY8Mi
	 FkINs55JVB5sRHCnTlFQ5BMCeVelWSh/mOsZSAa3tc2o2UVRqLAHzjnGrk3XfMFmKE
	 yUZtkwYIljsWxIjRlVV5OUJuG4eBUG7Ex4ojuJLvn0I0Ye5hWgfKtnWEOSOBCHSp4c
	 JDb7nCKhP6NvnxojBfFa0FUjKp21Eg/jL89c2RHwG69wReDvu3Q1lYYDIxR5d/e8TK
	 8F/IQbicLA9ig==
Date: Tue, 11 Nov 2025 19:17:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Miller
 <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun
 Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Johannes Berg <johannes@sipsolutions.net>,
 Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>, David Laight
 <david.laight.linux@gmail.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, Jason Baron <jbaron@akamai.com>, Borislav
 Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Richard Genoud <richard.genoud@bootlin.com>, Cosmin Tanislav
 <demonsingur@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, Jianping
 Shen <Jianping.Shen@de.bosch.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org,
 qat-linux@intel.com, linux-gpio@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v5 10/23] iio: imu: smi330: #undef
 field_{get,prep}() before definition
Message-ID: <20251111191351.06c0e660@jic23-huawei>
In-Reply-To: <CAMuHMdX8c1VkBuPDpJ5mpCcRH+zEX4F1bQKFf_V8N9ZZtCYqxA@mail.gmail.com>
References: <cover.1761588465.git.geert+renesas@glider.be>
	<97549838f28a1bb7861cfb42ee687f832942b13a.1761588465.git.geert+renesas@glider.be>
	<20251102104326.0f1db96a@jic23-huawei>
	<CAMuHMdUkm2hxSW1yeKn8kZkSrosr8V-QTrHKSMkY2CPJ8UH_BQ@mail.gmail.com>
	<20251109125956.106c9a1a@jic23-huawei>
	<CAMuHMdX8c1VkBuPDpJ5mpCcRH+zEX4F1bQKFf_V8N9ZZtCYqxA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 09:59:34 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Jonathan,

Hi Geert,

> 
> On Sun, 9 Nov 2025 at 14:01, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Mon, 3 Nov 2025 11:09:36 +0100
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:  
> > > On Sun, 2 Nov 2025 at 11:43, Jonathan Cameron <jic23@kernel.org> wrote:  
> > > > On Mon, 27 Oct 2025 19:41:44 +0100
> > > > Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > > >  
> > > > > Prepare for the advent of globally available common field_get() and
> > > > > field_prep() macros by undefining the symbols before defining local
> > > > > variants.  This prevents redefinition warnings from the C preprocessor
> > > > > when introducing the common macros later.
> > > > >
> > > > > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>  
> > > >
> > > > So this is going to make a mess of merging your series given this is
> > > > queued up for next merge window.
> > > >
> > > > I can pick this one up perhaps and we loop back to the replacement of
> > > > these in a future patch?  Or perhaps go instead with a rename
> > > > of these two which is probably nicer in the intermediate state than
> > > > undefs.  
> > >
> > > Renaming would mean a lot of churn.
> > > Just picking up the #undef patch should be simple and safe? The
> > > removal of the underf and redef can be done in the next cycle.
> > > Thanks!  
> >
> > Only 1 call of each of these in the driver, so churn is small either way.
> >
> > To avoid a bisection problem if your tree merges first I need to modify
> > this stuff in the original patch or leave it for Linus to deal with as
> > a merge conflict resolution which is mess I'd rather do without.  
> 
> If you add the #undef, there won't be any bisection problem?

Two different things.  The bisection comment was about squashing into the
original driver patch - not what was squashed.  Your tree may well merge
before mine does and a bisection could therefore land in between the 
driver introduction and a patch I merge today.

The rename is a preference only because I don't want an undef that smells
like a hack / bug work around kicking around in the tree for significant time
(probably a whole kernel cycle). In this case the churn is very similar
with that or a rename of the macros - so rename it is.

Jonathan

 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


