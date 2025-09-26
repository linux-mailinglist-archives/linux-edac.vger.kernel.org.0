Return-Path: <linux-edac+bounces-4938-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB50BA3419
	for <lists+linux-edac@lfdr.de>; Fri, 26 Sep 2025 11:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2A51C037AE
	for <lists+linux-edac@lfdr.de>; Fri, 26 Sep 2025 09:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B3329D294;
	Fri, 26 Sep 2025 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gUeF1nSV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067F672608;
	Fri, 26 Sep 2025 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880480; cv=none; b=ataQVlf8hWXK11MVpQoMICaZQnuF7YqH9SgZKs1wR69e9mxuZnuQa3c7F2QsvHw1oGRpXDiL6p1InpUrK18RjofQBXmZZlbHVoKhPxDuMpJn7DCPp47Deuma+NARyhU20BJ4sXUrGv7SQGBWhfE4s2sbXkE4r3xT1e4NjkQmU04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880480; c=relaxed/simple;
	bh=eELDXjeQZxS6NsOIyW6XzwZXiL7iOPa489E3zQRrRNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjjdNx0yMN9o5DEGuEiMgUllElMV+RE5W4lTxZtGIW1uWRSHY4guz6B1gOXoLYPlIAoLS9gYHo464kYk937I16bmVMuEsVAfNFphAUYHWzfRF/3LPSHvD2PnvjpgF/DTAF0f3Sq7FQnTUfL+isV4/U5yA0TmzmFD23fIqbG/tdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gUeF1nSV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4443240E016E;
	Fri, 26 Sep 2025 09:54:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gFC9n_7gOEvU; Fri, 26 Sep 2025 09:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758880470; bh=a39b8Q3inNwJfR0YLv5Qz2n5BWsJMVO8UdZh+vhbf0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUeF1nSVsg96+HRQWlvpWHPFcAkXhrwsqUB6x75nCNkSwA0KvfkX2N4Mj3dXwvt4a
	 W5YzW/BDkhfYhnQQMOjf32oQcMG+t57I6EtPFDYYnonNv/T/tpLnMBIPVG2SU20jfJ
	 mYV3AR11emjNtLojVcyL0faVbBKISWSzvhImtwekaEuURRFZuH6Ur5hxjwoLOXD0iC
	 Gx1ER+OHlFZC+JQ7SmVCCcBv678T4pfzBk/UUlTi+fYRA0EsWb3X1w62CcLHOonOQt
	 t2TtM7G9icLthQTk1P5Bf5dzUBOHoNmn5765Z8K821wSsfQiaHQPTJMBMgzNzBIj5t
	 at3ko5OCSujSDuHkNIAGbo+8ee3buAm4RUMl5lDZTLpdjiJF+ddyfImOeiOcrGCXpY
	 802EW22KZyVURC/IITt8CuOyuT6/iuyV/3rHaAPgp3tByixNynazzMwJicjI9rx+pB
	 YKoAujgay4MgJ43/YMe2pvc0++h9l9XSNse1v3bqoKscPxfhRlaY2inaby/sMreHIK
	 vuSqtqa0nd39KRq+3rxbH4wGlEj5EnHuDsLeHOxSyW4DS5BCWH2hWNlfc81cBbjNbw
	 wLQvfe9FxEE346B8dH5W6cVb8pISCVulX6V2x7u2TfktSBHT99xsCJ3PGc9gB73+95
	 lbMxiIYDBEf9OXv0nnWImwto=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B956540E0140;
	Fri, 26 Sep 2025 09:54:21 +0000 (UTC)
Date: Fri, 26 Sep 2025 11:54:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: wangchuanguo <wangchuanguo@inspur.com>
Cc: tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce: deal with UCE when copy clean pagecache to user
 space
Message-ID: <20250926095419.GAaNZiy75HDdKV4LI2@fat_crate.local>
References: <20250926054402.1571-1-wangchuanguo@inspur.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250926054402.1571-1-wangchuanguo@inspur.com>

On Fri, Sep 26, 2025 at 01:44:02PM +0800, wangchuanguo wrote:
> Based on copy_from_user, extending the goal to unmap,discard,
> and remap when errors occur in clean pagecache.

This does not even begin to explain why this patch exists:
 
A possible way to structure the commit message is:
 
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
 
Also, to the tone, from Documentation/process/submitting-patches.rst:
 
 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."
 
Also, do not talk about what your patch does - that should (hopefully) be
visible from the diff itself. Rather, talk about *why* you're doing what
you're doing.

> @@ -264,8 +278,14 @@ static bool is_copy_from_user(struct pt_regs *regs)
>  		return false;
>  	}
>  
> -	if (fault_in_kernel_space(addr))
> -		return false;
> +	if (fault_in_kernel_space(addr)) {
> +		if (is_clean_pagecache(addr) && !fault_in_kernel_space(regs->di)) {
> +			//is copying clean pagecache to user space

Look at the comment style in the rest of the file before you add this //

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

