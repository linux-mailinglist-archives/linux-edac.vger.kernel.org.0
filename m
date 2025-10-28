Return-Path: <linux-edac+bounces-5239-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC744C15B84
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 17:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FDD24FE3DF
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 16:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5076A3451CB;
	Tue, 28 Oct 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KjJPEYPJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gw2QrTQ4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KjJPEYPJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gw2QrTQ4"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E133F8C6
	for <linux-edac@vger.kernel.org>; Tue, 28 Oct 2025 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668004; cv=none; b=RzaNevAj9EW2e2uqYAocvi8cYfXLTYJGV8rIEYsVhKFwpAiNtAiyCilS7jrHRUQ1XeEkilSa56ICoOo56m3LuJ0lWZWqkEURpLD357LkjWKO0QiIKuNuf4Mev5wbRSDO7RKyf9c1Sz52BAQV/1KIUHp1G1vnCimWYEI8qZ8+4OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668004; c=relaxed/simple;
	bh=AqmDL9HYwKlOC1v96mDTpURTB0eXu0WZp5/vnGerPw4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGBZGnUY0OlZdC+OErR6d0jgBeQqi95nwwkzeDA4QB2bWZNjiXardl03ePgL6hJ3il1m767nmYclPJ5hHIf8t2KfgZ1eyPMqb7/5f9wGmDXl9BkZeNT5MkupJvoVkHMLo02QWvc+x3GGJnAi2kSTDJvejsM3S8cPCjoYCxL8MPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KjJPEYPJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gw2QrTQ4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KjJPEYPJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gw2QrTQ4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C99BD21A64;
	Tue, 28 Oct 2025 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761667999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSosvxi5dPFtdhC5U0/TTS2WAyGF8TeP5oXRsKZhx7U=;
	b=KjJPEYPJ7HZdpBT02TjYQ61cQjBJIEBgA6xrd5hVWW6xAJANi0wiYFNW6d5v7xV2N7YmlE
	h6SetL0FQi/IqvkJSpicxJI7317JmcnGp5XrGSNF69XjHib4Xs4pSezxRpirGmBaonvMPF
	xG/ODKCnE+Q8Gml9lNP6EM6O/Lt0Fag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761667999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSosvxi5dPFtdhC5U0/TTS2WAyGF8TeP5oXRsKZhx7U=;
	b=Gw2QrTQ427yrPNuYnSYVl0sYdSQd5/RgHd0ptf3XwxfdMZudizoPqUBaiHtRb5cqG4Is5B
	5/rgTt+d8ttytfBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761667999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSosvxi5dPFtdhC5U0/TTS2WAyGF8TeP5oXRsKZhx7U=;
	b=KjJPEYPJ7HZdpBT02TjYQ61cQjBJIEBgA6xrd5hVWW6xAJANi0wiYFNW6d5v7xV2N7YmlE
	h6SetL0FQi/IqvkJSpicxJI7317JmcnGp5XrGSNF69XjHib4Xs4pSezxRpirGmBaonvMPF
	xG/ODKCnE+Q8Gml9lNP6EM6O/Lt0Fag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761667999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSosvxi5dPFtdhC5U0/TTS2WAyGF8TeP5oXRsKZhx7U=;
	b=Gw2QrTQ427yrPNuYnSYVl0sYdSQd5/RgHd0ptf3XwxfdMZudizoPqUBaiHtRb5cqG4Is5B
	5/rgTt+d8ttytfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D26E13A7D;
	Tue, 28 Oct 2025 16:13:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id udwmHJ7rAGmPCAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 28 Oct 2025 16:13:18 +0000
Date: Tue, 28 Oct 2025 17:13:18 +0100
Message-ID: <87o6prf1i9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,	Stephen Boyd
 <sboyd@kernel.org>,	Nicolas Ferre <nicolas.ferre@microchip.com>,	Alexandre
 Belloni <alexandre.belloni@bootlin.com>,	Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,	David Miller
 <davem@davemloft.net>,	Linus Walleij <linus.walleij@linaro.org>,	Bartosz
 Golaszewski <brgl@bgdev.pl>,	Joel Stanley <joel@jms.id.au>,	Andrew Jeffery
 <andrew@codeconstruct.com.au>,	Crt Mori <cmo@melexis.com>,	Jonathan Cameron
 <jic23@kernel.org>,	Lars-Peter Clausen <lars@metafoo.de>,	Jacky Huang
 <ychuang3@nuvoton.com>,	Shan-Chun Hung <schung@nuvoton.com>,	Yury Norov
 <yury.norov@gmail.com>,	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,	Johannes
 Berg <johannes@sipsolutions.net>,	Jakub Kicinski <kuba@kernel.org>,	Alex
 Elder <elder@ieee.org>,	David Laight <david.laight.linux@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,	Jason Baron
 <jbaron@akamai.com>,	Borislav Petkov <bp@alien8.de>,	Tony Luck
 <tony.luck@intel.com>,	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,	David Lechner
 <dlechner@baylibre.com>,	Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,	Richard Genoud
 <richard.genoud@bootlin.com>,	Cosmin Tanislav <demonsingur@gmail.com>,	Biju
 Das <biju.das.jz@bp.renesas.com>,	Jianping Shen
 <Jianping.Shen@de.bosch.com>,	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,	linux-renesas-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,	linux-edac@vger.kernel.org,
	qat-linux@intel.com,	linux-gpio@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,	linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org,	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/23] ALSA: usb-audio: #undef field_{get,prep}() before local definition
In-Reply-To: <8f19d783dd783df5510408ffe9664dc6ef0d9434.1761588465.git.geert+renesas@glider.be>
References: <cover.1761588465.git.geert+renesas@glider.be>
	<8f19d783dd783df5510408ffe9664dc6ef0d9434.1761588465.git.geert+renesas@glider.be>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[renesas];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,wanadoo.fr];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,microchip.com,bootlin.com,tuxon.dev,intel.com,gondor.apana.org.au,davemloft.net,linaro.org,bgdev.pl,jms.id.au,codeconstruct.com.au,melexis.com,metafoo.de,nuvoton.com,gmail.com,rasmusvillemoes.dk,perex.cz,suse.com,sipsolutions.net,ieee.org,wanadoo.fr,akamai.com,alien8.de,analog.com,bp.renesas.com,de.bosch.com,vger.kernel.org,lists.infradead.org,lists.ozlabs.org];
	R_RATELIMIT(0.00)[to_ip_from(RLr5uiezb5xkkwytzfr8x566qh)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 

On Mon, 27 Oct 2025 19:41:43 +0100,
Geert Uytterhoeven wrote:
> 
> Prepare for the advent of globally available common field_get() and
> field_prep() macros by undefining the symbols before defining local
> variants.  This prevents redefinition warnings from the C preprocessor
> when introducing the common macros later.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> --
> v5:
>   - New.
> ---
>  sound/usb/mixer_quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
> index 828af3095b86ee0a..713a8498b975e1ac 100644
> --- a/sound/usb/mixer_quirks.c
> +++ b/sound/usb/mixer_quirks.c
> @@ -3312,7 +3312,9 @@ static int snd_bbfpro_controls_create(struct usb_mixer_interface *mixer)
>  #define RME_DIGIFACE_INVERT BIT(31)
>  
>  /* Nonconst helpers */
> +#undef field_get
>  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +#undef field_prep
>  #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
>  
>  static int snd_rme_digiface_write_reg(struct snd_kcontrol *kcontrol, int item, u16 mask, u16 val)

Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

