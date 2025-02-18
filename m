Return-Path: <linux-edac+bounces-3127-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69B5A397E0
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 11:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E40C3A7A04
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 09:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561F5233121;
	Tue, 18 Feb 2025 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hB9N19FO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366B523278D;
	Tue, 18 Feb 2025 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872290; cv=none; b=IfDhrXQGF+yXPP4LotAvwJpyMEkM2YXnXC4XHj2/yUAEWZ8TlCsZEI2QsT16lMaUS5S3lqEUyK2BSblW/dHAboEbHklwmql+UiYVkzinq8sWnc8pHhd1J6Tv2oSeWDdr9lX7iTftenw6BarmtK6LTlpOKAH90mZ5EP3xfhfADbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872290; c=relaxed/simple;
	bh=tzev4nRdjUhf+Tc0CrR2GGEjicCFgdra84D4P+0BmQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyMXWttK9u6e2wI5l7VzR9sB/zMKVlgW9KTUecykGGAdBXsaiClbO3sJmrrBOvgfWwDjrZQKvvxI9HrApS/s0Eo4c34tI9mnicW63g9lfBcbz2Qjmgwoh2Sc7cAHA3yWlYzO5nuUez5XVEvL7UKf7bVUutuVzLYgfPbIiKrMabg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hB9N19FO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BAC3840E021F;
	Tue, 18 Feb 2025 09:51:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GoaDm_LIYlEX; Tue, 18 Feb 2025 09:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739872281; bh=Nr+ITGOxF83JpvuoLqhxJi5qZg9f0Li2Qbe33nyvjOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hB9N19FOVlhM+bud2kB+nzrf8irQLHAX8Y1qk0PJBPWCFBwT0TTfuWA/vjMvTBfjV
	 G7gUwrWnx8rIvlKoZL5Qc31QcF2BySmVHJjk00ceJsRWYlV7YXnTKtYdh8IzgATpZG
	 4TUEfN/SvrXjkC0hm5sQCYReDTqqA2cVPmTex0VKHRMcuFzm9PaSJNIMheT22fSaj+
	 PBXvvsNSf+DCsz945knpdmV2gr2u+FqCJ5XkASQ0daE/bMWBweRgs4ZGMU5o+xTXrM
	 Ci+ZZbQeuWECf/cHCP6ZH2rdwTQn/aOYvRrKRElodG67DZhpMubwvIto3aMCuOFr1e
	 M2dKERiBwaknanPa+5iQqr5jRt7vk+CAl9mwDTkbd33KhztRq2PTRzMJzA1sGEKSqD
	 6LyqZfe2AFsQL1HalX1cQ4eJsa3hKY+dtay0wJ40qOM2ku7+MGBYRGh7vGVyrYDkic
	 59CqIrU4D4PIjl3syfRQSQad9pIvFYkabrSoXYigBt3wbDL8k9uwBw8HrnDDY1LyCY
	 4w27/zd1dp1RPRI90Vquw08Vo8kOakrh/9KD7GWsKalJcq+rS+86i5+GEV775X0Ez2
	 F6op/N3wAJ48J7IYpeLiffXrXiilKANf+59+1fjhZ1gDxdwQGTYouw1MSI15uZipNx
	 e60DYGEp4luabVNFZWcCdg/Y=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F75440E00C9;
	Tue, 18 Feb 2025 09:51:04 +0000 (UTC)
Date: Tue, 18 Feb 2025 10:50:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: tony.luck@intel.com, nao.horiguchi@gmail.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linmiaohe@huawei.com, akpm@linux-foundation.org,
	peterz@infradead.org, jpoimboe@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: Re: [PATCH v2 1/5] x86/mce: Collect error message for severities
 below MCE_PANIC_SEVERITY
Message-ID: <20250218095059.GEZ7RYAzleMDRSQJAm@fat_crate.local>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-2-xueshuai@linux.alibaba.com>
 <20250218075858.GAZ7Q9wp_WQUsjq2AW@fat_crate.local>
 <b3c12f1f-f27a-44f0-b32c-32b58e6e926c@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3c12f1f-f27a-44f0-b32c-32b58e6e926c@linux.alibaba.com>

On Tue, Feb 18, 2025 at 05:39:33PM +0800, Shuai Xue wrote:
> Is __mc_scan_banks() a proper function to extend?

No, first you need to explain the big picture:

https://lore.kernel.org/r/20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

