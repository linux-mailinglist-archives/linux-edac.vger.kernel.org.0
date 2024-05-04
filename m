Return-Path: <linux-edac+bounces-997-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848B58BBC89
	for <lists+linux-edac@lfdr.de>; Sat,  4 May 2024 16:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D101C20DB6
	for <lists+linux-edac@lfdr.de>; Sat,  4 May 2024 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5012F3BBEA;
	Sat,  4 May 2024 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JHQxv6aD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467FC381AF;
	Sat,  4 May 2024 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714834393; cv=none; b=YTyYjmAmzsXvMgbLwheXMJBGvENWAntXf3eFRKnNnPlgSu1F8p3g2vtNksoLCSIcLHqNbHVlopGxDDoow8FCMIBXfXEFM90n4IEsR1IvzSbPfONj4zDauQl3Z+VYTZ4W7dWf5Cj75BoVvkgKk0tHbtuI169YZY2/Axxqx/1zXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714834393; c=relaxed/simple;
	bh=g7rQnQWGtHI0w+y4vVYitdJVhPe5gL0qcIqCRIP5ahU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxq7tCTCgnutb5SVemONHgH305zg02HAuVM1vuSsSDx2clKvTbCeAm49eMAx218IdxH13OvpOYYyENeSiDanv1XIcNa8tALwiFn8JojD63bC5aZimCzbhr1KbfYaPLs2NB7/0VevdU2XYe6QIgyFqTAcapS6rxS4vdSCjQCB6zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JHQxv6aD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4C9F540E01F6;
	Sat,  4 May 2024 14:53:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ubg6ZDnWqevz; Sat,  4 May 2024 14:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714834386; bh=9rVkdFBHzRyq2jRYH3nY+m34iQIVk1o2/zG/U7xty3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHQxv6aDaa3ef0m0Zx6wotMzRKCUZ7GLwh0dItkA1aIZ0fixPctCMbhNkGq1xhIrR
	 KqGphU1Wf5DWeqbPwnhvZj/sKapfBoCMCu9nAIZuTYGToSzTy640evt5WPJhgcHfwR
	 6Uks7gpzpuBnkrtABvaauWmgTEBffy62SvHmwRBEasxS5QWN2/x5zr2mDwo2+lJc3W
	 qVSvKA4FTy2A+PcW7OmEtF1tAEmrXgIjAtRwlYLKrLZZnleYD0mIXKHm5OvsjdexYc
	 CHNKmODbFcKDRG6wOleX28cqX5AMhz0qEyrPXAYQFc5zSdVUWs03Q+QVqZcSe9/FGF
	 8ygmyN8Ma+RXVPAoelwp7ZUmaM7WnxbrKV/mciW4b85mBzzylNoDVVeCXL7KGqc17x
	 SMT5lWnFmTiky8fzgoAPBI+dAgtP3k8S4Zt3+JTxDg0ge/CfLCKykuoFZmE2Y9i2Au
	 +0orI/qLiXj28ctPVw8ZftvH2sbQ9ygk2LxEULGMMnvJ8f21ZKdtVBoR8Ktxy+9zvb
	 IyDzkoHPPvZMe9CygXcb8O60m57asOcZbVj90RT0N9HdqHHMCDV2tylEFC81xrgyoZ
	 vQH4upUC3GCJfTJjfclEFWoYolB8/3OkROR1a5R3Lfam49i7L0S8s0IxK707guqG2Q
	 T5jByz6Zb4u52zaAVdbCfM4U=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2581F40E01A1;
	Sat,  4 May 2024 14:52:59 +0000 (UTC)
Date: Sat, 4 May 2024 16:52:53 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
	John.Allen@amd.com
Subject: Re: [PATCH v2 09/16] x86/mce: Unify AMD THR handler with MCA Polling
Message-ID: <20240504145253.GFZjZLxf3lzAHGaHhh@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-10-yazen.ghannam@amd.com>
 <20240429134043.GPZi-jWzoVe3bJkyYX@fat_crate.local>
 <7b68f364-a324-4e2c-87be-19cdef4e3ad2@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b68f364-a324-4e2c-87be-19cdef4e3ad2@amd.com>

On Mon, Apr 29, 2024 at 10:36:57AM -0400, Yazen Ghannam wrote:
> Related to this, I've been thinking that banks with thresholding enabled
> should be removed from the list of polling banks. This is done on Intel but
> not on AMD.
> 
> I wanted to give it more thought, because I think folks have come to expect
> polling and thresholding to be independent on AMD.

Yes, this whole thing sounds weird.

On the one hand, you have a special interrupt for errors which have
reached a threshold *just* *so* you don't have to poll. Because polling
is ok but getting a a special interrupt is better and such notification
systems always want to have a special interrupt and not have to poll.

On the other hand, you're marrying the two which sounds weird. Why?

What is wrong with getting thresholding interrupts?

Why can't we simply stop the polling and do THR only if available? That
would save a lot of energy.

So why can't we program the THR to raise an interrupt on a single error
and disable polling completely?

Because that would be a lot better as the hardware would be doing the
work for us.

In any case, I'm missing the strategy here so no cleanups without
a clear goal first please.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

