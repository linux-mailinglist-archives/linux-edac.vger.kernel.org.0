Return-Path: <linux-edac+bounces-59-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A73FD7F0E90
	for <lists+linux-edac@lfdr.de>; Mon, 20 Nov 2023 10:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37365B20F7B
	for <lists+linux-edac@lfdr.de>; Mon, 20 Nov 2023 09:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C53107A3;
	Mon, 20 Nov 2023 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BnLufiub"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E988AA;
	Mon, 20 Nov 2023 01:09:03 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0D20540E0191;
	Mon, 20 Nov 2023 09:09:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NIZxxt3lKTWI; Mon, 20 Nov 2023 09:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1700471340; bh=1PeZhKr9FNO+V97mL9x/+VpJfeePD/XPT8/+rHdaj3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BnLufiubUKKmAmitL3/r/UjPfjPAN0+KObrW+hWDYQQ6Qfu4pIsXXIU6dZ6S2BMFn
	 jzFJIq6kqIa9/QPT9KcVqMH9b7o30Jje30LWzBl26JNM/1s2a//5yZ9rGy138k7k9H
	 rP3PvvXUwH3YkgtX91fgywjuc+UaqcRgX22O3aIgNmxMYxNg/qiC3By+sMg2hYojwS
	 IKW0UZt1YZD3O0Q2hvXfsnHCoevv6m48Pcq1q5gADkVSRlVbVQg7SPp3c6/E4TfOLZ
	 HThyhkBGieWH8Ugpd/AkUO+2+XTmTpw9ny5mIspUmSGz9isgIelzufcyNyqWfy1GBT
	 Req3VC61pg18LHuTJCvSLaQ1JdOo5trC1jMqV9HU29QfkWrxwYwsBXAzvXwMHT+4I9
	 +YE/pAjTGTuO1HBWkOTKWCQ57AHImYkQPWcKf9RPSlIBmempislgKqMydqqIM/cld7
	 yVNcNZxgd4ffHEX1tWg0kln9jQJrabZ4zGgUndEMpIP5X3tcfxL98Id5XU5DT+hcoG
	 OYbPDCby8j0C0WqHRN9a7jb1yZZ1QpCIwlBVik2DMwhe88/Y3VaVLZV4jHFeHhzoYE
	 DUaEYm68EYwA1Gc9EX5sWg7J0xlNCq8JG0Q+PT/fBX2bTcicyn2NUBartPsPQqNCzX
	 QOanwVRKr2Rv7AmzBEz4rQ5U=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCB9640E0030;
	Mon, 20 Nov 2023 09:08:51 +0000 (UTC)
Date: Mon, 20 Nov 2023 10:08:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rob Herring <robh@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] EDAC: altera: Use device_get_match_data()
Message-ID: <20231120090846.GBZVsiHstd6fCuFaQy@fat_crate.local>
References: <20231115210201.3743564-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115210201.3743564-1-robh@kernel.org>

On Wed, Nov 15, 2023 at 03:02:01PM -0600, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/edac/altera_edac.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

