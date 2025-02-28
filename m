Return-Path: <linux-edac+bounces-3240-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE8CA4997E
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2025 13:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B73F172F7F
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2025 12:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9206526AABB;
	Fri, 28 Feb 2025 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="emtei0Bh"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E751425E471;
	Fri, 28 Feb 2025 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746269; cv=none; b=DPc31/b0DKHgB0fUlnQbNwrsm1OpyyGCClDovlwJw1Ur+ED/R2FWXyowX6VYeNDysQVJfHeBPW+9hhpGuwtfo3WkYuTTH754SE0BEoROvnPQWUOEK/k1pQFAfFwQdp8kr6/cOI+iEfgV8xiAnG9uhRqajCDLZeyofFQHl5K6muc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746269; c=relaxed/simple;
	bh=GNT+jOaUaDBW3O/Qf3E/Eqtp83WOGwtOUsGJpvVdMl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swtfM6xJxJTkSzaMX5/t3GYh/ChVPEldSi/0sVhMxbOrzpZy2FcNkA+b1B2C6WA+bZK383XNLk6ZWzMC5hlAxsQMHcUgDADbr244tyOtG3gNQ6VM/kUkynFHqhQFGq/YZiEm2TpPsMor/9qKmh9tRwXEmoGyfFMrByNLjiP6SYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=emtei0Bh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E43AF40E0173;
	Fri, 28 Feb 2025 12:37:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id a444JwmclsZ4; Fri, 28 Feb 2025 12:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740746262; bh=JUtOsGlXPNSyoqlVTsGp10E9uKAUaYowh1obxJjntFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=emtei0BhJ4iqSjPKP7YG8cO57UJbcpaKzfdFTNxRhtPrkTuVB2bXfgF6GKjayqFFW
	 bYUxjMyunNL2di7Hh1BQ/Ne1UCVbfZdJF/ZAa+UEqnnynkYZ+8WO7F+hnKYbiEts+g
	 hYBWJ5Q7ggnsZb3oIU01XNrvcjRgwqaDp6HDdu3de15SFkTmFfyICNH4nWvmA0Di0s
	 fpPOO+ZvWB/gGVN+pcaRXGbgJKBuXTGJMGWroxUGbr4knhDEQ2UpEa3b9NhgVoXR7c
	 IZO4DyGvzuDl8nnfGdaeTmAaNMeGI8jLJTUCcMEKfFchHPz6R+P8/aLdTZYzQhnZfn
	 AwP/JHZwSgNG1FCm41rxnvjQ2/ynL4d/jn4W5z76x3hE6hVi+95jxDvJhqYBCMiy/8
	 SBJrMuLh+8qBzP9fKIsNnN+2t9HTFyXGMROsQr0bDOjXRHKwZcrhS2V4wwSjc2vjm0
	 7YVyTjUHIpRZSHOEApP7ZLV+RGwYWA1+IjB/2NGpm8kG2AIGi5oM/vZSfFUZEMS4Uw
	 zu8tXxlEVYt9LOCyJSDdSEbWWQbf+jMQ2enCW5ZOZ582kvEyugMAVJcfofJdct2WM9
	 7VpQWK94daZjj6eSH+bHj01r5asAOm+SbJaDbWFdAXjqv8TeGQJyeUKr1GpzpygXAh
	 8cpjXN7gnBy6cKK751KU0MII=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB0B940E021F;
	Fri, 28 Feb 2025 12:37:25 +0000 (UTC)
Date: Fri, 28 Feb 2025 13:37:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: tony.luck@intel.com, nao.horiguchi@gmail.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linmiaohe@huawei.com, akpm@linux-foundation.org,
	peterz@infradead.org, jpoimboe@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: Re: [PATCH v2 2/5] x86/mce: dump error msg from severities
Message-ID: <20250228123724.GDZ8GuBOuDy5xeHvjc@fat_crate.local>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-3-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250217063335.22257-3-xueshuai@linux.alibaba.com>

On Mon, Feb 17, 2025 at 02:33:32PM +0800, Shuai Xue wrote:
> The message in severities is useful for identifying the type of MCE that
> has occurred; dump it if it is valid.

Needs more explanation as to what "useful" means. We already log and report
MCEs in gazillion ways.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

