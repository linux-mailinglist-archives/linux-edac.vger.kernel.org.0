Return-Path: <linux-edac+bounces-3123-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DE1A39474
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 09:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766E93AA041
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 08:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7B32153C3;
	Tue, 18 Feb 2025 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fMDANAgX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD7219F120;
	Tue, 18 Feb 2025 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739865807; cv=none; b=BENKqojWuhLfZykAR5JSCEYgUihYattS09O0A4f/Zv8z0gLCwb2RFSG7jVg/Guz0jpwJbWJpA3ojrsx0tijvjZAnvfHf6p+bZ5ni7TbtFb8De0+ykakW2o2M8R9hbUNiUeuZUBMSlUdRpX11lgoCCY1/Dje9IaRTFeeF881chHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739865807; c=relaxed/simple;
	bh=+P6ReYVOxMFlYR/URuQebiSVYq4Ll96FRU/nVDQGJfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6h02jhthWXZQadmA0xkMquS6ZsYwbC+bRCUuNndyBRlWthze3QKhTeVyKv0Yjon7kmj0MP/WwPNrem8oLniTBc529qKgshMPixX6M7ihRTHJNHSD4gPjPixuBXUXqA06XkH5UjHsVkOUVhXCqtq5uTFZhnfHc7pCxTGs3HDSYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fMDANAgX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1FDF040E020E;
	Tue, 18 Feb 2025 08:03:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id D6rjv6eRpWc0; Tue, 18 Feb 2025 08:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739865799; bh=Bl9BOnQaU0OVBVW22leXuy1TzNpH2m9SoOSIuEkd7eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMDANAgXRYXIR0j1WFWCZKnZ1ysygYHcs8k9ID98kpwzAmqwvafLudQyEuVuQDsPb
	 OUkXNhBL/2+6yvlzsiBR4KhBi5TFJj2Xlk9Dib428tTd9IlJounJIkegsDKT0TmktT
	 +BrTQx3XW/WMtRhI3dCFFrEQ0ENGS9NNV61I2DIJ4G+bCr/o/l7KxxRm83KE87Qe/8
	 ZZN8JqfG/u3kFCW9BpC1Y5fdqgxHjtN/6T4xi8QS6DPVDXN6cJoDADKleOqwrjL1nc
	 OgGaQxb/Cv06AWQ0AWBqmDYQM2VytLh8kp/A027LNaIfugXSwhfKeDnUoGbTMGxvwt
	 Ba6/42EfBvf0dacU3EaJsq1sOPhOEyqjNOKSsYgrfMtrZ+ukNbEOGw7Ri2BvWGUyNK
	 E0MYxM6HRvjkniZj4pVxEqnrXZUqkbur5p+fn0MLTJ366BaPHzNbXYuIqkELPU9Uc9
	 fEvG+TQIfH/QI3GKbg97wwO9jj3F52gr6cIbYjwlNLDvNkxgu73fKgc/Nm7R4oJOm7
	 rpOss0NkK/9YYx86NsBlGQL7WY7CAItmUXmRBeHuZVDygl6bwrJmrGgXPikQ5rfIvc
	 K8P8Dwn1AidkdwC8at6YRizY4FfxiFxODvGUXuRocEhYuYjz+Xs7GhElkjMwbX8ina
	 OEL6F5aPZJ6Avo1CJPTv1H8g=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ACAA640E00C9;
	Tue, 18 Feb 2025 08:03:01 +0000 (UTC)
Date: Tue, 18 Feb 2025 09:03:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, tony.luck@intel.com,
	nao.horiguchi@gmail.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linmiaohe@huawei.com, peterz@infradead.org, jpoimboe@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: Re: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
Message-ID: <20250218080300.GBZ7Q-tG0r3z3T0_i_@fat_crate.local>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217192954.b64f88bbd79ba83ecf05110a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250217192954.b64f88bbd79ba83ecf05110a@linux-foundation.org>

On Mon, Feb 17, 2025 at 07:29:54PM -0800, Andrew Morton wrote:
> On Mon, 17 Feb 2025 14:33:30 +0800 Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
> > This patch addresses three regressions identified in memory failure
> > handling, as discovered using ras-tools[1]:
> 
> Thanks.  I added these to mm.git for further exposure and testing. 
> They do appear to be more an x86 thing so I'll do the usual thing: if
> they later turn up in the x86 tree I shall drop the mm.git copies.  

Please drop 'em. They look confused and need proper review first.

Also, your commits have

"Cc: Acked-by:Thomas Gleixner <tglx@linutronix.de>"

When did tglx ack them? I don't see anything in my mbox.

Andrew, again, please do not take unreviewed x86 patches through your tree
without synchronizing with us. This keeps happening and it is not helping at
all - the opposite is happening.

:-(

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

