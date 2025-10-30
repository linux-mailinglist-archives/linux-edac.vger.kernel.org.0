Return-Path: <linux-edac+bounces-5268-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21230C21E76
	for <lists+linux-edac@lfdr.de>; Thu, 30 Oct 2025 20:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B801A2537D
	for <lists+linux-edac@lfdr.de>; Thu, 30 Oct 2025 19:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6173283FF1;
	Thu, 30 Oct 2025 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T57tB1C2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E640274B40;
	Thu, 30 Oct 2025 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851955; cv=none; b=bDEk0wqruzeyWUjmf0bSqe1BQ/8GAR7uo+F47CNN/MiEQCSWZ+dNIROygFlsBZ4umcN5wNdGl2Nj5qJU4xHO3N/zw4KucrrfabCSSNEJnktuwSaE74r7yjgHVtcbJj876GFmQN4DJgdUGHxG2BBYHYteNZ6iyyG78RJMtoREzhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851955; c=relaxed/simple;
	bh=m60k/Vik3vCrl5XC/PYuZiKX57IHyHNKS12kNREt4hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjHza7/pB8Wlj9ixINX4whtGm0Ypk5PeG59z7H0IrRyPlDfKrz1hgZJRJ22ydYRX+TbyKA7hoyYcEr7+m4th9KWsVWWSNrcSufYmUMVI2N7rmh82vYyLlCIlN9hVhFxBkSEJwO6KjhW5pCwuAd47qF7jlRWz8L9Gu2L+vaaLmQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=T57tB1C2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4FDC240E021A;
	Thu, 30 Oct 2025 19:19:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZUYYFYtH-UW8; Thu, 30 Oct 2025 19:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761851944; bh=NANYfOYC7YcCesh5TCYBJSmQoitmiWP+5+6VP7B46J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T57tB1C27xP8sDhPznohf4mcGEV/jLxKVQHGuZhafRxEjk5+xJESJ1poqZm5ANHS7
	 3kpaWUWe3BkIVwwqsP0Z3M3xNj3iJtAAP0y12Wz56p3ZB6aeWz0+UU01SPP8u37gQZ
	 p4ADCXO5r+y9RPwU9hL6fSu6gJ10xwbXPas7bpjnY1ktcI4PQ5OzpFMPHno3RUoXee
	 AG9oE1cjjwdikMzc5EMf/UsVAJI3qVaiBIXXbDFBnH0MMA61T58Odd8DkwvmOcDK+9
	 4vpgvYtofQiS7Jx/Qq0GDrVOms+K+fWkQw2uUzO2Z4f3i27FEDe0lcjqWTfo3L54W4
	 7bXEjCOotYEsK0rG2Xt0inw03dcNNOSHkm2fuunwV9sPuEdUZ+6+axZ+kZi6LTED9w
	 nASCnVk1Eejh6Fw6ZxsLz3TzxmPTIskt63DJVCCEstB9T84ZoKflKGFnA4NQzoBr4s
	 7DY72AiUo+Rc0LcgXmhH2WT5eFN+PDWz7D26KOQD446O86upHtaR8D6mGWdmOleLEW
	 3MBfQPo0zfEfnVyT6AWtRv+vAH9ja/AAKU8rj6mN1RfhrX/38DANNJStzmx0/RS+qK
	 zL0kviXIFaUmjLN/dXKHHGxKdoy2c8/o8V1tWvzfYEaYdUFjJdCVuF/z7/+RtvZetm
	 pq3H6CIPreQr6BUkKOoT/fAs=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C2C9140E015B;
	Thu, 30 Oct 2025 19:18:59 +0000 (UTC)
Date: Thu, 30 Oct 2025 20:18:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	yazen.ghannam@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] EDAC/mc_sysfs: Begin deprecating legacy sysfs EDAC
 interface
Message-ID: <20251030191858.GEaQO6ImJ4fbqB_5ag@fat_crate.local>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
 <20251013173632.1449366-5-avadhut.naik@amd.com>
 <20251029172419.GGaQJNw4Pofl1x1mve@fat_crate.local>
 <2025103029-reforest-negate-cc34@gregkh>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025103029-reforest-negate-cc34@gregkh>

On Thu, Oct 30, 2025 at 04:01:43PM +0100, Greg KH wrote:
> No one is going to notice this type of kernel log message.  If you think
> that no one is using the sysfs files, delete them now.  Why wait?
> 
> sysfs is meant to be such that userspace can handle file removals (i.e.
> that value is not present.)  Unfortunately, sometimes this does not
> actually happen and user tools do mess up and rely on things.  So either
> no one uses the file and it can be removed now, OR you have to leave it
> in for "forever".  There's no real chance to remove it later, that's
> just postponing the decision.

Lemme try to repeat what you're proposing to make sure we're on the same page:

we simply zap the files and see if anyone complains. If yes, we figure out why
they're using them and if they can't be moved to the new interface, we restore
them and maintain them forever.

Right?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

