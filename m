Return-Path: <linux-edac+bounces-60-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544F17F0EC5
	for <lists+linux-edac@lfdr.de>; Mon, 20 Nov 2023 10:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E512282188
	for <lists+linux-edac@lfdr.de>; Mon, 20 Nov 2023 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4577010954;
	Mon, 20 Nov 2023 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VTY0wmma"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C226BBC
	for <linux-edac@vger.kernel.org>; Mon, 20 Nov 2023 01:16:20 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B0A3840E0171;
	Mon, 20 Nov 2023 09:16:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GP3j7CpRNPGJ; Mon, 20 Nov 2023 09:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1700471776; bh=NWudJA7sIU73lWXR1dk2xAv1aD8sQZcYhPWReGJ5VQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTY0wmma+bVyQGPTlfYPpMRmlvo+xduzgzjHt6W40724WHlpR9nj/QwFCaJ1HcELp
	 IrnmjQvypMnyEXOrv01KTOVb40/etMhsM07Zjw7asbsVF1h5CPr3Ep4Oc5CwUasQ4O
	 M5ax3nk+aAaNjanevELY+YPir1qWuVokXC2KzIwlvPrX/45vxxNsNITnj1MhUW75qK
	 SN0FgauSxgOAPYmYohyshxU3ObJLwHtvAomNVWtq/5S0ePJLF+nd+hNw2e0/Ev4EUS
	 41IqtQyRYcNRbz9g6sBs2nXmAA8YDpTe+vUNLFy5Pvg0+EKSBL4jQXwaMslfNGZoct
	 hvlykPbG0FhA4ya815sZmNHhBY67A285ugw1OF/gOK3kwKWqk3h2KdERwZXUMG2qYb
	 ZFmzMA0QamsFqORan4CvTVZhUJgAlADfI94gX2VXhDvstsFk8BfOd56o/kkDqw5g1U
	 VmKf+//k2tg4cOOplqxTuAPviZG8P8wrd2VXcR3SuhQkekmwovkYMs0GQtP+pb5OAd
	 Ksgz7OHD+eASsYqbIPjjtVfG31GMz5CUjm85erv8bjoHEEJrd0/C/u46bK5i/bVVSR
	 Yg7zxHDb85EHnkcVWF+z47zVh0hBQGd17YY90ACKZxX/5JZ/etGA/EkSJjIcRIx3rb
	 eb/k2kzZQvF7gEPNKAkKkNiI=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C05140E0031;
	Mon, 20 Nov 2023 09:16:08 +0000 (UTC)
Date: Mon, 20 Nov 2023 10:16:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: sai.krishna.potthuri@amd.com, linux-edac@vger.kernel.org,
	tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, shubhrajyoti.datta@gmail.com
Subject: Re: [PATCH v2] EDAC/versal: Fix the read of the num_rows
Message-ID: <20231120091607.GCZVsj13bBlWOhuR/Y@fat_crate.local>
References: <20231115072055.25373-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115072055.25373-1-shubhrajyoti.datta@amd.com>

On Wed, Nov 15, 2023 at 12:50:55PM +0530, Shubhrajyoti Datta wrote:
> Fix the read of the num_chans and num_csrows.

Just slapping a "Fix <bla>" oneliner is not enough.

This commit message needs work. A possible way to structure is:

1. Prepare the context for the explanation briefly.

2. Explain the problem at hand.

3. "It happens because of <...>"

4. "Fix it by doing X"

5. "(Potentially do Y)."

And some of those above are optional depending on the issue being
explained.

For more detailed info, see
Documentation/process/submitting-patches.rst,
Section "2) Describe your changes".

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

