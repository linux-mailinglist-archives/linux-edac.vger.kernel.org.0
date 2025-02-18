Return-Path: <linux-edac+bounces-3122-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 679A7A3943D
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 08:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43BA77A0497
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 07:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0AC2066C1;
	Tue, 18 Feb 2025 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gucWHkHv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C33B1EEA30;
	Tue, 18 Feb 2025 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739865573; cv=none; b=I7AClUV4XG5LAsuyphFH45xARjY1/OV7sUhBK3i5DBdsCRrBvF/9NGVn2K9HzOeu33sXErRUu2NlYydAfnTD2GmjYeYjxmPpZ/yPyM/ujwvg1DpB5cgT/JJkb+TE5mP08m2EFbxUfP3BBWgRpUmbgO/EePKXuA38vjFP7rMf6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739865573; c=relaxed/simple;
	bh=qGtiHyXODS5M/qLlBpOFQRYkyWWrYLh3zsYeNYFP0qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B244td+UJAXtN7IaaBiy9C+EWfewKfnk4FaarXgCTBDiGlLofRLHtyh/zafr/0mzgGfA4hd/k8M9tuoHVc4Q5UgN+eXf94JHow68YypC9SYqSITvdp6ONwtSJRVuu0lIqhNfKjLOTE/vSNbO86s/kIGlj/gVODeJ5h8HVSeZ1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gucWHkHv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 81CF940E0212;
	Tue, 18 Feb 2025 07:59:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gQrTBomRItDm; Tue, 18 Feb 2025 07:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739865562; bh=fKnAU/KEF7MFmyqTMzT8Xecp54gHhgt1Av8J7B4+x8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gucWHkHvSldV2Ggctopr4jGimaqrR3MK9VEo6eOnFu0C8Z5MxqhiJn1PS5T6CRF0t
	 r1pZLliZLk7JWUwB31b+HBNL4oWQpvOktGYEm2lFQ/dx3d+8FXVBbSE0UDGenVKJ8G
	 HU15damPO97VjzSf4gjxGs4FwjwP+FZXXzGdc8VKc7//Z/UR1aEKvzqrtv4MHjSwau
	 PywKfc3Jc0W/Dld+/7rFBl2cGlY/vFmSC+nDbtS9507L8P+T+HqZzB2LFhFqsw4hLv
	 tgcK6lAuQ2UgBuPiRcRFZXu1cEx1/Ob2eQXg9iuNvkBCFChwBFOnklCdDVtpbSuAa+
	 tmnPFSQXwLPPZgbDqB+UEMhNhxsyxNJtjSvKrcPRyy38koyCFgXDDUu+ujxkdffomG
	 tsIXYbiDzvQXc0sjcnXqQTi0ImfmpvETZLaAESZ6DbMDP1zdwGe17fdrlYaNHCBRyZ
	 Z39al1oD7Vqsn44UCQTwuoRCw59eFnIiub0+fFg6/jqvbFsqGw98OFaEo4p5AzV2ls
	 C9KtNZu2NMa7F5D8x4tXZZwBF6jQ0pH0fQznD4QwGhvAOubp4VnHjrACfdzGu9WbLx
	 m9825snpbUITnCKZZ/tRqgzoxB5ujbLm04ZaElgiqF3SaKGAi5X+nDxzsN9xi8kwYX
	 LKogMSFQphEd4EIlPLrEN2MA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2AF4A40E020E;
	Tue, 18 Feb 2025 07:59:05 +0000 (UTC)
Date: Tue, 18 Feb 2025 08:58:58 +0100
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
Message-ID: <20250218075858.GAZ7Q9wp_WQUsjq2AW@fat_crate.local>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-2-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250217063335.22257-2-xueshuai@linux.alibaba.com>

On Mon, Feb 17, 2025 at 02:33:31PM +0800, Shuai Xue wrote:
> Currently, mce_no_way_out() only collects error messages when the error
> severity is equal to `MCE_PANIC_SEVERITY`. To improve diagnostics,
> modify the behavior to also collect error messages when the severity is
> less than `MCE_PANIC_SEVERITY`.

That function is literally called "no way out" as in, is the error severe
enough so that there is no way out.

Now you went and stomped all over that to "improve diagnostics". What
diagnostsics? Your commit messages need to explain in detail why exactly
a patch exists.

So nope.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

