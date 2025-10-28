Return-Path: <linux-edac+bounces-5240-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC52C15BF3
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 17:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6361893448
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D6334575A;
	Tue, 28 Oct 2025 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HtMDbF8r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ytJTULRp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HtMDbF8r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ytJTULRp"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A53345754
	for <linux-edac@vger.kernel.org>; Tue, 28 Oct 2025 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668028; cv=none; b=FKr6VYVu7wqbJmFrKg7ZV/itpiEfj4xB8ZbqjmRXnnmEIwKS5DDZyyCL4s8akkxARN0XmpcxKTPj81R65yb4zIsUoVLbGNvsuiPJhzvI6R1HCl4SxECDW5CbJbmKU0CBrmXzH+5YmLAkyUrtc0T4VOmEGCVWz2kB4bBcNeqAt/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668028; c=relaxed/simple;
	bh=t3buJ2ysQkdol3q5rs3qBMfbIGRLgldMKJXCive1rt8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXcNHDhz97/zT+74MeV8ukEqxx2YsYJBIiKfOujhZDtNGGRdYQraIEWQUSVKgiBBcgrgvOCC9iuI60AS5Co82CGErwz/3WYTj+LH4UXV3lbQvh3UQE2RiRrNqBAaLwQ5kji2EF7v19hiG2Yu4sDpH9FN2uv6n0iMupKbmzdgdeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HtMDbF8r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ytJTULRp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HtMDbF8r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ytJTULRp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 71D431F46E;
	Tue, 28 Oct 2025 16:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761668022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIkfaA109e058juxrbARLnbhnw+30Zzst1672lVORwA=;
	b=HtMDbF8r2wRWDGifnv9gYxSNAhmS0ojzB1YP8QtBcy8ubsAT3ZsONof3Bhi32jnCH/lw5z
	Hq6v+a16uHNBw7YVLG0EXbD607lh+hXWEV2szjXMyw6CmEW2DhnqmsfmuG+WL6eiBIJi6S
	EIT708Ji0KWfCPRQ6wSJTudLeMIbq9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761668022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIkfaA109e058juxrbARLnbhnw+30Zzst1672lVORwA=;
	b=ytJTULRp9UW/jr9bzPTDO3cAAmBQor2fn8ie0J+jiQytAqY1LFwxRRsg/XxfPqgAg/w4Xj
	zB2K4ve4Da2VOpCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761668022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIkfaA109e058juxrbARLnbhnw+30Zzst1672lVORwA=;
	b=HtMDbF8r2wRWDGifnv9gYxSNAhmS0ojzB1YP8QtBcy8ubsAT3ZsONof3Bhi32jnCH/lw5z
	Hq6v+a16uHNBw7YVLG0EXbD607lh+hXWEV2szjXMyw6CmEW2DhnqmsfmuG+WL6eiBIJi6S
	EIT708Ji0KWfCPRQ6wSJTudLeMIbq9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761668022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIkfaA109e058juxrbARLnbhnw+30Zzst1672lVORwA=;
	b=ytJTULRp9UW/jr9bzPTDO3cAAmBQor2fn8ie0J+jiQytAqY1LFwxRRsg/XxfPqgAg/w4Xj
	zB2K4ve4Da2VOpCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22B2113A7D;
	Tue, 28 Oct 2025 16:13:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h0gZB7XrAGm0CAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 28 Oct 2025 16:13:41 +0000
Date: Tue, 28 Oct 2025 17:13:40 +0100
Message-ID: <87ms5bf1hn.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v5 20/23] ALSA: usb-audio: Convert to common field_{get,prep}() helpers
In-Reply-To: <91f957d8857d64df9eae33824203cc770b0182b3.1761588465.git.geert+renesas@glider.be>
References: <cover.1761588465.git.geert+renesas@glider.be>
	<91f957d8857d64df9eae33824203cc770b0182b3.1761588465.git.geert+renesas@glider.be>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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

On Mon, 27 Oct 2025 19:41:54 +0100,
Geert Uytterhoeven wrote:
> 
> Drop the driver-specific field_get() and field_prep() macros, in favor
> of the globally available variants from <linux/bitfield.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v5:
>   - Extracted from "bitfield: Add non-constant field_{prep,get}()
>     helpers".
> ---
>  sound/usb/mixer_quirks.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
> index 713a8498b975e1ac..6eee89cbc0867f2b 100644
> --- a/sound/usb/mixer_quirks.c
> +++ b/sound/usb/mixer_quirks.c
> @@ -3311,12 +3311,6 @@ static int snd_bbfpro_controls_create(struct usb_mixer_interface *mixer)
>  #define RME_DIGIFACE_REGISTER(reg, mask) (((reg) << 16) | (mask))
>  #define RME_DIGIFACE_INVERT BIT(31)
>  
> -/* Nonconst helpers */
> -#undef field_get
> -#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> -#undef field_prep
> -#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
> -
>  static int snd_rme_digiface_write_reg(struct snd_kcontrol *kcontrol, int item, u16 mask, u16 val)
>  {
>  	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);

Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi


