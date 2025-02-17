Return-Path: <linux-edac+bounces-3105-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 967EDA38232
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 12:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A57C163F27
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 11:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE29217733;
	Mon, 17 Feb 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LCGt1pVQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700DC19F128;
	Mon, 17 Feb 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792874; cv=none; b=UrAbNBPdLnfdoXNC3InDUfkjLYWipZNCnlqJPi6DoHRSvwhBbFiTjNGuEog0P6fZIPOqajkUfqGom1rA6cW4ShCvwmFjZryQvRV5BUGDD7+YAPQGIl4NFjl4qUNjP6rHXOJa74256efI1Y7xcQ4xzuzq8yu76W5ifkJcshtXe0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792874; c=relaxed/simple;
	bh=EATzCimgjn+g/Uv0wR7R6AhaRYLHlFo0WlAdBq1fwK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbJwE8hDBdEWsf1oPtYNVpjgFZDO4mAVccIgrAfxoXiVwt2wHlsLuo4nehQEs8zneGAoFMXHL/9tFPdeItX02L6tc3TtY/rwytFtPqBWrOukf45O9Bb5q+xDThuMKi8zoepujT8meR7Y+SRi66Fr4whaGE2M8pzBwTpYuBCjT0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LCGt1pVQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2ECD040E01AE;
	Mon, 17 Feb 2025 11:47:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sMvrFybU7wvA; Mon, 17 Feb 2025 11:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739792866; bh=wpiM446cAiz/uog6GHwtTOYsK66olPLoas/UNj+19ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LCGt1pVQ33eEJiM6SmhdFTTbcl6HfJ7QNBZcur8jGG361PFLoEntH2qxm3HTCfUhX
	 TEknhRYAYLNkpOR70xZSNolcEsMZ0Sy6yvSonXiQYNE0r0P1uqle0zJmfOaK/+cHMy
	 xPSDtNsZ4Ge2GyCGSVGoJCq7Yj0tLpNKk0Le7/9baiW/EhNycpkz2qDxOcCtTk1i55
	 G/Zx+C8CaooSu6Zp6DJXcrzqR6wewXqS5o1urtB9QKZzMpCLD/reb2wtEMxoFiazhc
	 eDb5GzXSWURba4KQAJ7PdEFsYMfuWbIAiyG/0hMpG50ERgnY+FuDpplEpis6t9b7Zo
	 l0ZaNVfWeRK6gdKrJPzO5zpjXf02VkHj5FOY4Gnb71ZonaybGJgAMWnOTASZe6n3Yd
	 1XPHh6FMebQDTZSlrDQb5Ncys4E1k5k5j4txtacnu2T5wgoXffs0tZq8eQbM1CIUrV
	 0gq9WKNNFzdfZS1eVol5D9R6+2rzu0WLcmrHomBKyUY7F71pn8g9CCwbZtOPQh4XFy
	 PS5xrcA6c4VCVlSSw8f/eAqiLTMr/RPIIFqk6xmF1YoYiPLckgGaurmZgB4/uHJ0e4
	 f00Jr5ZlJkFWenkhRTI6ph59QKzceMRizijt7Yq9R7cnfpmAdncPySg3UPkgI86qlV
	 QycYECRwRCOwcmF2pdlI8DAA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 24DC440E01A1;
	Mon, 17 Feb 2025 11:47:41 +0000 (UTC)
Date: Mon, 17 Feb 2025 12:47:35 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, tony.luck@intel.com
Subject: Re: [PATCH v2 1/3] x86/mce/inject: Remove call to mce_notify_irq()
Message-ID: <20250217114735.GAZ7Mh12l48HmAXXm7@fat_crate.local>
References: <20250210154707.114219-1-nik.borisov@suse.com>
 <20250210154707.114219-2-nik.borisov@suse.com>
 <20250216161050.GBZ7IOCofLUUelomR4@fat_crate.local>
 <8cce2725-9efe-44e8-b071-f921874d7649@suse.com>
 <ff06575b-079b-4016-9a28-5b439beb0ff5@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff06575b-079b-4016-9a28-5b439beb0ff5@suse.com>

On Mon, Feb 17, 2025 at 01:20:55PM +0200, Nikolay Borisov wrote:
> Actually there is no loss of functionality since after an MCE is injected
> the early notifier will correctly call the usermode helper. So I
> think the following change log better reflects the situation:
> 
> 
>     x86/mce/inject: Remove call to mce_notify_irq()
>     The call to mce_notify_irq() has been there since the initial version of
>     the soft inject mce machinery, introduced in ea149b36c7f5 ("x86,
>     mce: add basic error injection infrastructure"). At that time it was
>     functional since injecting an MCE resulted in the following call chain:
>     raise_mce()
>       ->machine_check_poll()
>           ->mce_log() - sets notfiy_user_bit
>     ->mce_notify_user() (current mce_notify_irq) consumed the bit and called the
>     usermode helper.
>     However, with the introduction of 011d82611172 ("RAS: Add a Corrected Errors Collector")
>     the code got moved around and the user mode helper began to be called
>     via the early notifier (mce_first_notifier()) rendering the remaining call
>     in raise_local() defunct as the mce_need_notify bit (ex notify_user) is
>     only being set from the early notifier.
>     Remove the noop call and make mce_notify_irq static. No functional
>     changes.

Ah, there was that. We're doing a serious dance just to log an error, that's
for sure.

Yeah, that makes sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

