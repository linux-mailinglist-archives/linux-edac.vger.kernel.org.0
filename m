Return-Path: <linux-edac+bounces-1171-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E18D8817
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 19:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F5E1F21F4E
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 17:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2371369A7;
	Mon,  3 Jun 2024 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W1d4dOyI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0328382;
	Mon,  3 Jun 2024 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717436268; cv=none; b=lOjPIIelohdHKdjdwVWJWae9Fp/eQ+VOyxu/55Huf7J72ZXnI12cKxKBUSPfAAOxVwnnsZl2mDKI+FlnGl/S5oHQkX2zjEa4nkxefxxxaK5Pm6L4zK2Dk6c/zyTc4DYbp/Zmm4eJjNeCk6Ox3Eya5/I0Xkmaza+0OJ7Aehykf6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717436268; c=relaxed/simple;
	bh=jVYpDKFsAQoVl6zoNLBDteeJmjYcmSe5lrpmSH4vu1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WT2xOflguyOo6NATrGmU46r8vgbTM3QEeCFd7UDCoswBS/Nb1Mo5+R6wSeDlvkoCHn88iw0rgvtpGIKQbK2EdElEPGJ37Wt9OAX0ek4pWbTI6klsTre6iIiif/2ZObts2Lm/uYsFnlNVQMwoM/XYebhHgLYPCNEt2OyBtkFv77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=W1d4dOyI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 15BC440E016A;
	Mon,  3 Jun 2024 17:37:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id G0wd4BSyBX0M; Mon,  3 Jun 2024 17:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717436260; bh=hpYIA2DA+gPQxWdwquhJ9GCmfI5W+kioR5xvfct83vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W1d4dOyIVmtZOVL7jYc/a+ptiZvBitggW6+IGai6I05/WZLTltDl/cdFieQN4iX0k
	 Kk2Rq66y7bPwGYBpq70+nb6kPGyyM68RmoRK0aD/a8IRjAnMoVkpZvsnU9uGH2RqJE
	 PZc3mvJUjRaNVgbohpZJsdkGjFbfVRHoU3aFZN+8rZnnqUWMm0NUIakC90O0rl/f1H
	 q/AatCU9/JcAANx4/uOOVknU7MRqKOlqt8D921ucdX5j6u0AINuqHB2xVBMwFo9OOV
	 68WPKPZ42x4PQAcz3l4F2L/PTPPsW9mc1G3sTF9p1spb0gi4hBJYp7d4LxDXpX9Gpe
	 bHoRmHy/F03+mC7sjK5/S5sJMswXbWVKUquHYtg583DvHwSVBEGSsuuEq4BCs2q4ST
	 l8j6VOIe/Qsie/YIfbqzZZ/45p1qKCL4QoLpuRxpwrXjGW8v7vdO+xc3sGpqoFHGUU
	 O4f+5Hm5JOls3u7SYHw1R1iOrzPN8rHtkb88n/CcucQTK918WZZQhk2xB4hUl09OQI
	 ICbR1Pu2jmAUt9lVR3hDJHfNpdTzjHrmCLSgr8hzYbdU31lG7iNE8G2OL3ZBjt+ncX
	 B2mHAKVxLEShK6WaHm4jwfA2zxtMIkpWy8pXrhPXfvzcw1XRrablua7mTtRaFladGR
	 c5Fs0W3EGsvffxG2kWIum5o0=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 480E340E016C;
	Mon,  3 Jun 2024 17:37:33 +0000 (UTC)
Date: Mon, 3 Jun 2024 19:37:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 4/9] x86/mce: Move machine_check_poll() status checks to
 helper functions
Message-ID: <20240603173727.GOZl3_V9eVbm0184Wi@fat_crate.local>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
 <20240523155641.2805411-5-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523155641.2805411-5-yazen.ghannam@amd.com>

On Thu, May 23, 2024 at 10:56:36AM -0500, Yazen Ghannam wrote:
> @@ -709,48 +747,9 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
>  		if (!mca_cfg.cmci_disabled)
>  			mce_track_storm(&m);
>  
> -		/* If this entry is not valid, ignore it */
> -		if (!(m.status & MCI_STATUS_VAL))
> +		if (!log_poll_error(flags, &m))
>  			continue;
>  
> -		/*
> -		 * If we are logging everything (at CPU online) or this
> -		 * is a corrected error, then we must log it.
> -		 */
> -		if ((flags & MCP_UC) || !(m.status & MCI_STATUS_UC))
> -			goto log_it;
> -
> -		/*
> -		 * Newer Intel systems that support software error
> -		 * recovery need to make additional checks. Other
> -		 * CPUs should skip over uncorrected errors, but log
> -		 * everything else.
> -		 */

You lost that comment.

> -		if (!mca_cfg.ser) {
> -			if (m.status & MCI_STATUS_UC)
> -				continue;
> -			goto log_it;
> -		}
> -
> -		/* Log "not enabled" (speculative) errors */
> -		if (!(m.status & MCI_STATUS_EN))
> -			goto log_it;
> -
> -		/*
> -		 * Log UCNA (SDM: 15.6.3 "UCR Error Classification")
> -		 * UC == 1 && PCC == 0 && S == 0
> -		 */
> -		if (!(m.status & MCI_STATUS_PCC) && !(m.status & MCI_STATUS_S))
> -			goto log_it;
> -
> -		/*
> -		 * Skip anything else. Presumption is that our read of this
> -		 * bank is racing with a machine check. Leave the log alone
> -		 * for do_machine_check() to deal with it.
> -		 */
> -		continue;
> -
> -log_it:
>  		if (flags & MCP_DONTLOG)
>  			goto clear_it;

Btw, the code looks really weird now:

                if (!log_poll_error(flags, &m))
                        continue;

                if (flags & MCP_DONTLOG)
                        goto clear_it;

i.e.,

1. Should I log it?

2. Should I not log it?

Oh well, it was like that before logically so...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

