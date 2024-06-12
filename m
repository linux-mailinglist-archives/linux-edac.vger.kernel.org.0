Return-Path: <linux-edac+bounces-1267-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCD69058D6
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 18:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C147281033
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 16:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6BC180A99;
	Wed, 12 Jun 2024 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HTBcCf/q"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F6C16E882
	for <linux-edac@vger.kernel.org>; Wed, 12 Jun 2024 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209973; cv=none; b=mBu/AlEc2jugMMIkflnFVSCXmLvsg8Uz94/ckIkaDkz5uZrNQg79zLIaQ5eal85Ku5DxRK56eYE2cjXcHVRUGcKliOw8hYf2EXzPTNFcnFLplfVLEXJY9Rw9HWZKRpCJU4S4yono1N4kMSu9A9RlaZ3Aw+hm3+jblseAJiewYe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209973; c=relaxed/simple;
	bh=t1kAK2Nsn1MO2x/IyxLSFdmm3WNXqdmewfC2eehUJkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNUPeOpuqOBQYjgzQh0t7ghmQk8raJqohXVCxJX41Mda9bbz3Gn+OOyKNv8qVuFVUef9QEU5E3JBsh2cBAjR9UUalchR3Rj/MAfQrrfpwgkrDMjW19/zDbPxLcwJfouN2xLZH4t0r9/wy9VDHVs7YEAA+6mArdQ7V/86wGfA6H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HTBcCf/q; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 43A7E40E0176;
	Wed, 12 Jun 2024 16:32:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CB2gvMdoqLqd; Wed, 12 Jun 2024 16:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718209964; bh=DuEJ/kTPUUrGXkjOdSB7xrtF5GMPIySBWSXVhNwZ04E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTBcCf/q+ybIb0fjBr0VJmMixjrqf/WPEXseILeSE+t6nnvh8F/BBP5Eg+kyzmlUf
	 n1ve4f5WyHsPKRctJRg3IxtDo/72ibhuh9n8xX4N69pPbvuOf4wU/pwbmgLz/WRCz2
	 eOQTuDX8j851a0LHDLuwwNzEGtPjGRO/pn0KImsbEKohK4zl313tsrUQJulQaUP3XZ
	 0iQGLdiNonjil0JPY2P1SWQOOWNaQ0bv5jcM8is/zHMAmiEmUtfQBxwqjZI5CqImGx
	 w4swt8G5srnEhITdaFbenGPngMEx0Z/FZRXB79Tt8JVMtknYLmbV/3nwkOGvFklCUc
	 yQjwi3LIqzu8CxlTbneB9PwHX+iyxWRGvRbMjUsuhtgYirF7ENgo5Ma/xNi6tyNA8Z
	 YE46wNvoG6OvOzlQrrKz7jkkfH5txuzpcQmxEV840ciEjRZG0dtplHMXBV8wsjzGGu
	 PQUVuUz/sKX886/0pQ5eIe4t66scsoPOeEHcB2mjGMvOcke8riA2rTtCvVtXemEf1t
	 3eE9OG3OAq8rtuzphfL5/eYMvc45S9ZRy03IhVxwsdacH07z6sJvoFxWJqHplR4KqS
	 0rLFK7neNWa2T7nbBfmfZqa7fTDTlVXEZrqQfp0l1wJsTSEcwm6OvP3LiXGyzxFtL8
	 L6/MDQPPrsAduYtMibh+yZp0=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA6C940E0081;
	Wed, 12 Jun 2024 16:32:35 +0000 (UTC)
Date: Wed, 12 Jun 2024 18:32:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-edac@vger.kernel.org, git@amd.com, sai.krishna.potthuri@amd.com,
	tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, michal.simek@amd.com
Subject: Re: [PATCH] EDAC/versal: Report the bit position of the error
Message-ID: <20240612163229.GCZmnNnYBREuuR4cAs@fat_crate.local>
References: <20240521115959.17596-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240521115959.17596-1-shubhrajyoti.datta@amd.com>

On Tue, May 21, 2024 at 05:29:59PM +0530, Shubhrajyoti Datta wrote:
> In the case of CE, the bit position can be derived from the data
> and the parity registers. The values are read and
> then from the fixed H Matrix the corrected bit
> position is derived. The hardware already corrects the
> CE errors however it is derived from the registers and
> reported for debug purposes.
> 
> When a correctable error is detected, the driver reads from the
> registers:
> 
> eccr0/eccr1_corr_err_data_lo
> eccr0/eccr1_corr_err_data_hi
> eccr0/eccr1_corr_err_data_par
> 
> and along with shifting/XORing fixed H_Matrix ECC values,
> calculates which bit location is found, mimicking the calculation
> done in the DDRMC ECC hw.
> 
> The H_Matrix was generated from an old 1950's IBM paper.
> 
> The maximum bits in the data read is 64 so the data match is run for
> 64 bits.

This commit message is "all over the place". After reading it, I still don't
know "why" this patch even exists.

The goal for our commit messages is to be as clear to humans as possible, even
for people who do not have intimate knowledge of the matter.

And, more importantly, when we start doing git archeology months, years from
now, it should be perfectly clear why a commit was done.

A possible way to structure is:

1. Prepare the context for the explanation briefly.

2. Explain the problem at hand.

3. "It happens because of <...>"

4. "Fix it by doing X"

5. "(Potentially do Y)."

And some of those above are optional depending on the issue being explained.

For more detailed info, see
Documentation/process/submitting-patches.rst,
Section "2) Describe your changes".

Also, do not talk about what your patch does - that should (hopefully) be
visible from the diff itself. Rather, talk about *why* you're doing what
you're doing and about the non-obvious aspects of a code change.

So pls give it another try.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

