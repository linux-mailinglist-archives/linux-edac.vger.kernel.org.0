Return-Path: <linux-edac+bounces-3125-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FFBA3957A
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 09:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274BF3B42B9
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 08:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07FD22ACE4;
	Tue, 18 Feb 2025 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UoKlHSOz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58F1B87CF;
	Tue, 18 Feb 2025 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867280; cv=none; b=qRlPMq8LF6N+ksEagqDfQM5IZvRCDzNw50PmVrotcpsFxKNyE46BQHu0Z+yRT29iu9oYtMQIMYVaaExHg22e33Eldo0uKXM0F0kvTSsnFJjjW2WpWT7xTfV6eMuNrtxKemLGRIQg22OO6BtDpVx3mTNVbtR2CdQP6LjqxsKeH6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867280; c=relaxed/simple;
	bh=1hbGrgaPb6b6ENR44HlCCVsM2gp2+PClw4vmk3z4fsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcdJQ/YuGgJ/uZEGSpsx9qVvZIwqsV7iMrZ/QPVLXCwvtZpQ8rzvIB17820sKuzWbgysQDNIFA+oXYPQfKUArVX15NQKAEdD1AFy69dJ1JbIB+/s9EDcV2DTXmbedyo+wCcwSJpMX6Ql0YNGG1exNupp7tcarDlBbPQy6xUnewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UoKlHSOz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 33B3940E01A1;
	Tue, 18 Feb 2025 08:27:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1jdlKZXk4JKo; Tue, 18 Feb 2025 08:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739867270; bh=jAn/HNcN37jbOxycChzF/f77JjKiI97PDWxT1WP+ZdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoKlHSOzJAu0JSvQFqfJYA9VfpBnBpdcy+1rmxWYA5pGqGdTKar0S7NRvWfUYgf/P
	 0mjWPnZOClBlKipV5IspJBaBhQCiFkgLcAY64SB6Cj+JTs3cUeQ3EcDoAasH6jwalU
	 Mn3IXfZNCeAH553uN2iZ0RGWFqHYl5oIO0TTyt+Oxtly+ARdyMV4Uz0/0ZWiVGFn9S
	 SvbvuFlVnawHGcn4p6qSG0g3gZjkRgLrRt5FnfI0TgIKqQWFAC8r3zfZ/O475kYvGZ
	 lRJKn1gtrHf5j4nrrC8zOFoTAtZ7CnID06cVx3k4a2R//Yu3jIYqYYDpEAtZvWqQaN
	 5wLQ3bb2BiuamJ6xpV2Ki69A1oZk3yEiTLv+k/9pzD18A/b0nUyza17Fa5wIZyjLsI
	 LKfOSsWXZ/hqJtPFo8EdBhGZKAWCMdbwu+TFsWFFF+GK8K64XO3XjiyysD0XoDeoaS
	 dQefxl0K3X22C1JDh+lhx8TJa8Op8GG/uvxyfhE1iuuEYkoB5auo+57Hi7mLS87cmu
	 YCsbhTWtA8ovVjif1o/Uk0k+3yRqvapxFmJjEG9SgUYwZII5KxqInIw7QZgTZNBhYe
	 UcV0Ip+LOSpb5b8oCelDUcgZH8EaWxkWiYm+PY9m+VYXPGtVExwVAIWplbO+yj9x7Y
	 ySs9TH3AjydRhA609hjHzfUY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C000F40E021F;
	Tue, 18 Feb 2025 08:27:32 +0000 (UTC)
Date: Tue, 18 Feb 2025 09:27:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: tony.luck@intel.com, nao.horiguchi@gmail.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linmiaohe@huawei.com, akpm@linux-foundation.org,
	peterz@infradead.org, jpoimboe@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: Re: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
Message-ID: <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250217063335.22257-1-xueshuai@linux.alibaba.com>

On Mon, Feb 17, 2025 at 02:33:30PM +0800, Shuai Xue wrote:
> changes singce v1:
> - Patch 1: Fix cur_sev and sev type to `int` per Tony
> - Patch 4: Fix return value to 0 for clean pages per Miaohe
> - Patch 5: pick return value comments of memory-failure()
> 
> This patch addresses three regressions identified in memory failure
> handling, as discovered using ras-tools[1]:
> 
> - `./einj_mem_uc copyin -f`
> - `./einj_mem_uc futex -f`
> - `./einj_mem_uc instr`

This is not how you write a problem statement and explain why your patches
exist.

You need to state:

1. What are you trying to do
2. What is the expected outcome and why
3. What actually happens and why
4. The fix, in your opinion, should be X or Y

Not quote some ras tools commands. Show me that you actually know what you're
doing and explain the problem in human understandable way.  And then we can
talk fixes.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

