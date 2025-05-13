Return-Path: <linux-edac+bounces-3891-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F89CAB5BEC
	for <lists+linux-edac@lfdr.de>; Tue, 13 May 2025 19:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B7F188337A
	for <lists+linux-edac@lfdr.de>; Tue, 13 May 2025 17:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2802BEC2F;
	Tue, 13 May 2025 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UTIUHlj3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766E1A23AD;
	Tue, 13 May 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747158966; cv=none; b=XzrxFT0pGuGaK3RiXAbXWdNGUOjZM2ZubwAAAxl5+EGaJgTcbatevgQ3SDrLUoPIav3pBywYD6Lf/2PwB3IrRQFChXCfDlbhu7iSaXnPkY6GlnMrrY6KFc1nyYRygoWVKyK9WJexDirOXDUtufqocAsp6XoLQ0rcVX5B/miq3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747158966; c=relaxed/simple;
	bh=lKU4yC0LDzvWGnPi2a2trNAiYx++eO2qqjqJ8pI4kWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVLr87P9kbHeVOwAkFCAlVpUPJhVWf9F0xD6JUds9yD8sb5mwYVQwFaJ1yjzfx98kaFK20nPmXCVG2myn6reglTOOHRwxNppqm34pEk2QT9Jh+GInDxekVQ+wpM9w50Jb3SOUGyv6d4ul65B9Y48HpjiTFaCgi5xTM4GrlStQJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UTIUHlj3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4E36440E0258;
	Tue, 13 May 2025 17:55:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JpLsm2pOe23w; Tue, 13 May 2025 17:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747158955; bh=sWXeWbXM32FMVWj9tAPAqAkgSHn0OWH7WTFUlRYYCcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTIUHlj3pZFEE1MC4xQAs0G03aNVpaSsw3x12AkbkaA5Z226yICH+EMBunFrsJLwt
	 yxhPoj/7r+HMQeeRFgHLbKda4bgTHOmEUjHbvckw4r7MaIm/Vkff07kmFdiOsgGkk+
	 j2Gn4IQyY451aV8gJHJU0FELZzfZsBqy9rc+9CN6UshmFlc/1dGgKtCLa6kFevGWfp
	 jC3PSAbWEtYhUps6dXnvHTa90znJvm+IzLzBIp0Mjd1a/z1rQca/0VvMrFfJ4JljI6
	 PeZe6ov9IWum6UfTNgrddXitJqdKJdhav+X242b5ourt8MHjhFw4Q6VXZmdr39Wbkr
	 w49yBkSuusiinA9fHXRWeO1I+oZorjT6m9VDK4vgKbf+Ggb/FKnL9osPVuayraDSnX
	 fFB9khGYv+n1F8NVPrqd7L0UIlDQbzz9JgB4f0uwe+8FHqe6VbEzN0+KSRIiqr7P3u
	 tNqvK+htLM/VIM30TMqZyDeYtS63gGpsZsF1JXyDcZGKfjPEKg8l1/2M+f359/Q5Yo
	 jvl9LITzN5Qv0Vn80AkGUiVyL3s3HfpE4wRGPXEkIZlLGWwsFizDd4QzggzSx1Nr5d
	 lEtszAyUQMjGVhHIgei1eg5jIsgTZh9uXp4Gx7xZpMyqRnHGalza5zFUVLFrcYfnod
	 65wZbD8qfA+Chb2LRLCFCfcw=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F55440E023B;
	Tue, 13 May 2025 17:55:48 +0000 (UTC)
Date: Tue, 13 May 2025 19:55:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 17/17] x86/mce: Restore poll settings after storm
 subsides
Message-ID: <20250513175543.GGaCOHn26isB18J9ig@fat_crate.local>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-17-8ffd9eb4aa56@amd.com>
 <20250512074616.GSaCGnSJbBpToh2VM6@fat_crate.local>
 <20250512154315.GC2355@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512154315.GC2355@yaz-khff2.amd.com>

On Mon, May 12, 2025 at 11:43:15AM -0400, Yazen Ghannam wrote:
> The use case is "disable MCA polling". I just gave two examples of how
> this can be done.

Our documentation says:

                ignore_ce
                        disable features for corrected errors, e.g.
                        polling timer and CMCI.  All events reported as 
                        corrected are not cleared by OS and remained in its
                        error banks.

                        Usually this disablement is not recommended, however
                        if there is an agent checking/clearing corrected
                        errors (e.g. BIOS or hardware monitoring 
                        applications), conflicting with OS's error handling,
                        and you cannot deactivate the agent, then this option
                        will be a help.

it basically disables all: polling *and* CMCI.

So why do we even bother with storms?

> We can focus on "check_interval=0". The user wants to disable MCA
> polling and rely only on interrupts. They still want to see the CEs.

Is that a use case we support?

Where is that documented?

I can see why someone would want to avoid the recurrent polling but I'm not
sure we explicitly say that somewhere in the text...

> When the storm ends, the kernel should go back to how things were before
> the storm. If there was a timer before, then go back to the old
> interval. If there was *not* a timer before, then delete/remove the
> timer.

That I agree with.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

