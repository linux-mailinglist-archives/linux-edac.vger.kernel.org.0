Return-Path: <linux-edac+bounces-82-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E6C7F5E92
	for <lists+linux-edac@lfdr.de>; Thu, 23 Nov 2023 12:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8F91C20EE0
	for <lists+linux-edac@lfdr.de>; Thu, 23 Nov 2023 11:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAA02377E;
	Thu, 23 Nov 2023 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gfSsodfl"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D20F1BF;
	Thu, 23 Nov 2023 03:58:35 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 54AF240E0259;
	Thu, 23 Nov 2023 11:58:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id X3NKKQJzBsfh; Thu, 23 Nov 2023 11:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1700740710; bh=x0a9jKb8T+GdxkKAWUNyWFH+pL0NxSkyw8byfB61vIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gfSsodfl5VWH5smd66eoq7M+EVCxMVyin36soE62zLX/kKXih4eojZA8wQH69kip3
	 ORkO5xOqks51SYkYDAQsVtLL7qZrRfMHcrcQFNQiwUOsVrSrw171SKj30HG/BvD+G6
	 z8z8ML5rLadXM3+CpgORSEYBF7ISKxspy+uBYXKYfL79a38a0NlHACsX+oHWd+H103
	 p3KyMsD7APPprAA9irbyIfDgUnq2pTlJfzgyJQwLlUJOJ8mhRPj9u4qRNZTrmo9rre
	 e7Q7M6lbthelJVDnFMjkFJ55CFAxZOi6NE/qvHADfoKEi3CesgQOHaIRVSwJSSJOp2
	 Acjmq+jKB9sMAXLQwZc3E9645/z/Sqfn1kkjJ/AHv6UNzNbV8CqRnl+sljFHpDxyPN
	 F83ZLhnbZyXf5nNFGDIEEGxy7gCH5HbICoZw8C0YYhws5V8wMQRS1hxIuAXIdmCpFv
	 2dwVjxo2TwP+lLRMXmpI3ncLauZNR0+HOZ8j+9yKly4iuF4Kke5U3erbvr8U+6W683
	 ymChZOmuMZQiIa8wdxijaB21ia1KRsHlE8+FmmUuQACL/WG3f68GJAs2S9+h7rRrZv
	 5DFGid//Hq7ZEbp7I+/BLb5KmTqzShYK2c3JItuSRmAlyqH+c1WF1/nyJiSmWJ9rK7
	 P9GgxdFmMenURi7pfh9btwDY=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F99940E014B;
	Thu, 23 Nov 2023 11:58:18 +0000 (UTC)
Date: Thu, 23 Nov 2023 12:58:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Robert Richter <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Sergey Temerkhanov <s.temerkhanov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Yeqi Fu <asuk4.q@gmail.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, thunderx: fix possible out-of-bounds string access.
Message-ID: <20231123115812.GBZV8+VHPKYmKB/sva@fat_crate.local>
References: <20231122222007.3199885-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122222007.3199885-1-arnd@kernel.org>

On Wed, Nov 22, 2023 at 11:19:53PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Commit 1b56c90018f0 ("Makefile: Enable -Wstringop-overflow globally") exposes a

$ git describe 1b56c90018f0
fatal: Not a valid object name 1b56c90018f0

I'm assuming that's in linux-next?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

