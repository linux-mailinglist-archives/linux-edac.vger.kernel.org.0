Return-Path: <linux-edac+bounces-4641-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7407B31CC7
	for <lists+linux-edac@lfdr.de>; Fri, 22 Aug 2025 16:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A43EAC23D0
	for <lists+linux-edac@lfdr.de>; Fri, 22 Aug 2025 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9D230E0F2;
	Fri, 22 Aug 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HyapY0/A"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A862EB84F;
	Fri, 22 Aug 2025 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874121; cv=none; b=I/pRVLwo8+kVHzvuRAaGNpIQQzjYPzHT7RD6X10RZMF99PCEMFvs3vEz8QKyebcWgjaiWbHMrisDKFa6UmpEqQFRziBnXILh2X2UVqSAOBltIk9Mi7yvw4hXkhpo6QuTLrhZ2NJYmB4R6x39aa7WRE6AB8qYhVsdPi3mW3RiXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874121; c=relaxed/simple;
	bh=uQif88yNNdYttf7+cRaZ0eiCASc8RCBeBqL7RUBpweY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdmYA69/8uSXimMcdUDX6G5xFfW81OsZu+mKfW4HI0ImiFQHxQgGw7iKFmUjIwb1S6EVswcLy97888jvhaiPukpQ93FYDkw+qNpm8XVpFxTImcXNEN59MtW1IiWlaQRkFMPC2bzLjhoVBSn/DMktIjeivLk0JAzCpQULqScMsSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HyapY0/A; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2FE7540E00DD;
	Fri, 22 Aug 2025 14:48:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UDit7YffPw_M; Fri, 22 Aug 2025 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755874112; bh=pMFvfqcahBTsCFrIW1RAWQWo0sTGzcaCEwz/SgmdPGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HyapY0/AW/Kd1MA+/ePvhypOqVVu8VLym9JUJN9lw4dyWdjbrTjPnGuDmu4ENLthk
	 LRic5nC4h3/RFVJVH+9nHRbi5V795R4GwllwcI3oRhOFWvA/DFPC3xThptQpAvAoWT
	 L3tn1z03LvQ4LZQ23vm///FmSuzuNbdQUYeTgnZnA/HfvqieAxa88OI523AzRc65dB
	 HsWwH4u8D4wBOmKteN3QIv3Ox18tcobYM2djOK3/TOtMw3Hlr17u8/WwlWESMTqoka
	 iZTpoeEHnleL5RRLiDRJVAx0Hj8a0Ryrsjd0EABu+dhDQP9dwr5X1lwmt8rTLyJexZ
	 0WEdXXYEnNAHGGdsZG+0QJ1yxNdwOY9D5pXoIhniG594jwUK1Q/DIslGj0xqnBoNqY
	 Xi3vnSm7OOXOHZy1GWymcNnIqzO4p8wN4LX8modeghqM5EEB7jF3G9Cam5OR7CdTAL
	 dWOfYkVtRF05niah+WdOyGeal/bHRXJEXOYJJENiLUbctM2fPNcREelXlGC15u4LSy
	 otv26hFGgwvNF2+499PxbKgWmjM1qGoivuHInbTRnbGGnBv7lh60pksAJ1/yD9gQr1
	 O1AWoaEHhC8Q1iMClT6pjF8bvaZvPC74TMhEIiW2Sij1FXHO+7zMmUCbxnGEMvtWRW
	 8o9iSQs2CBRWPT+8A5cJGb3c=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C564840E0163;
	Fri, 22 Aug 2025 14:48:24 +0000 (UTC)
Date: Fri, 22 Aug 2025 16:48:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: darshanrathod475@gmail.com
Cc: tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] edac/amd76x: Remove assignment from if condition in
 amd76x_remove_one()
Message-ID: <20250822144819.GAaKiDM8l-eJgU1-bs@fat_crate.local>
References: <20250812130154.2220684-1-darshanrathod475@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250812130154.2220684-1-darshanrathod475@gmail.com>

On Tue, Aug 12, 2025 at 06:31:54PM +0530, darshanrathod475@gmail.com wrote:
> From: Darshan Rathod <darshanrathod475@gmail.com>
> 
> The code was performing an assignment inside the if condition:
> 
>     if ((mci = edac_mc_del_mc(&pdev->dev)) == NULL)
> 
> This triggers a checkpatch.pl warning.

And?

Is this a bug or just something some silly script is telling you to do?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

