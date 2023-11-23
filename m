Return-Path: <linux-edac+bounces-85-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6DE7F617D
	for <lists+linux-edac@lfdr.de>; Thu, 23 Nov 2023 15:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB469281D9F
	for <lists+linux-edac@lfdr.de>; Thu, 23 Nov 2023 14:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B463321D;
	Thu, 23 Nov 2023 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MwvfBChw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34604A4;
	Thu, 23 Nov 2023 06:30:37 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1D5A540E0257;
	Thu, 23 Nov 2023 14:30:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OkiWKAWqFvOB; Thu, 23 Nov 2023 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1700749833; bh=CbtmBDjQ9qd0QRr4KwqrmOaMwZq9bR8pSRoPEZXDNqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MwvfBChw+Z9+GdVylxTDucIGOFOYLbEQWbfpP1AZg0eZ7LT/C1tspkTEb39FrCeeI
	 BvSqD/1lBWFddp6ilfvdQXfAKSLIZekxVqU9pcgm/CPEAf/5c7TvAEHx1zNOj12lyk
	 NRRWWuwURHrXapku1youRrXfABcCmd26tFkbXt4MtrM/opkawyMg84+/YuHqrtOvkp
	 xIb/LcClHowTyBtvp8uLtSVWP5WGA4rHJNYdGq1zyInTQ2Qd7vrs11gDs6fixbL4ef
	 r+SWOaEGSbj82zO3I35fKBBMMWxzwzFb9LeDg/SPdIfxlM+NeDHmpXW4JQvKWq1yEm
	 3pNfx2dxTK1K5uHdtL14fQsxwSkCTh5Lm5O8iJ3VZtYTulbyjBm5r36Csl37Mawqnt
	 ICbd0ymJ701Vo+OzNQXYt+NGqqZ6vpsmOoWuFyD5Ygq1qZFNWCCBJUK94qIn1te/u9
	 r41vJxnSSEuvj6Bfjbf82STOtTAvaP+FQBVIo59njveDQFPwCAEJBgH9IwhNy8VjzI
	 doSIO9c8OMBXGpNEZ7FWokww9nlIxaze7jcXpVt6qWlAryfRof/GAQNNGdfbz6Kn7I
	 CrfPifM5VEt7dMADlJn9BisbSmkL0YwUWGuTxF3w5TFtWNsLYJu6hObZCGdLzxZ/Y3
	 n1MYJpjHEohD3Yiis0t2m0/A=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C90E40E014B;
	Thu, 23 Nov 2023 14:30:20 +0000 (UTC)
Date: Thu, 23 Nov 2023 15:30:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Robert Richter <rric@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Sergey Temerkhanov <s.temerkhanov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Yeqi Fu <asuk4.q@gmail.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, thunderx: fix possible out-of-bounds string access.
Message-ID: <20231123143019.GDZV9h+zIVj5pBQySh@fat_crate.local>
References: <20231122222007.3199885-1-arnd@kernel.org>
 <20231123115812.GBZV8+VHPKYmKB/sva@fat_crate.local>
 <f018b794-8af5-4c08-ae7f-0528a3e0f0e8@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f018b794-8af5-4c08-ae7f-0528a3e0f0e8@embeddedor.com>

On Thu, Nov 23, 2023 at 08:03:58AM -0600, Gustavo A. R. Silva wrote:
> That's correct, yes.

Commit ID is stable enough so that it doesn't change?

I don't want to commit it now and it would happen to change later and
I'll have a stale reference in the commit message...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

