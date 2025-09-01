Return-Path: <linux-edac+bounces-4711-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D79DEB3EC70
	for <lists+linux-edac@lfdr.de>; Mon,  1 Sep 2025 18:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651C6188843C
	for <lists+linux-edac@lfdr.de>; Mon,  1 Sep 2025 16:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AC12EF66A;
	Mon,  1 Sep 2025 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BfPbhryw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85141C5D7D;
	Mon,  1 Sep 2025 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744912; cv=none; b=KDQXcytCOMlOKjDyF+9wJD0ecarxSfZSL0etTlDYs6vtR5Yd8YNcCf8OzSsM/sxXw+eS50QJtse8AwFXAUnxbIAh8kvtBrVcEP87JVdWOqhG2yIXDYZGWRPpuPNu39OYDMUMXK+lH8pqPob8FiUzNgyO0yiPiIeQF0duOwvwKWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744912; c=relaxed/simple;
	bh=p8/7WEVkTduEKJGch8LKpul9HTK4oWe3sq0Pkl5v9eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgriHBSuY1MO3z+gD/dh1YizLuE/8o5dvUjF6YRKeeEbtaV7a8YqvigOtiflvZQTi9nFUwOT2MVh5DvWwq9om8eOJKhTjubzlBTKk4qwTdgmfBsSumycFSXzYKnBeuuHY4Dmpqhkc1BPes8Ax4DNBtqDglwxvhyVKKghVTwuzL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BfPbhryw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 61CC440E0174;
	Mon,  1 Sep 2025 16:41:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Vyyl7ZB28m6j; Mon,  1 Sep 2025 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756744902; bh=dMIQAtkoujJNauIq7vZnF7gyvWuiGZt+R4XWw++n8pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfPbhrywXwL+wj80Nwab8pTNgiwWQd0rnCXaQ+QAsXGhudGtVVz9cnJ8SbqzOhjhY
	 FuP7YmyA5q0JQnRemYTDB972HNo0/xcrKiq6Tvp4wHWrIrbxpyWy6qyywS2XdmTKKo
	 BwOqMEH4qdbHylgUaqsbCpA/nxU6+mIvgiy1j9Cl+4GVneJDu6vrOUfwFlq/yhSJhu
	 8m469C7qqN6Tndm9qHns92wX6AKC7wp6BW+m/TckeXG3AHqaYagf3UhpzaSIbSwjFI
	 Y7nBVBj5GnBKV+/cqV6hNvGcP+eB3bfQj5xju4Mabs9vmoLGRl0PeQp+UzCULQ+mXE
	 basHp3FYdnlCji6o+zYHBXExTm6w31Tuizp49qN+SXsUynQoUMk8/C6GGBQqbk05G8
	 b3EDtFn6wSD8Cca3GKK3+pdonSE6dpXH/i7f3u82AayJwYo93wsY0ZgUdoV3PDiMdg
	 M8f0DpOxCr5bE32lYecVPczcm2FgeIduIlmEgVauY3kbdcTxYpGvq9Yok42i9QjGCn
	 s83YLbTR6aWlA/ipyfbB2L95r6Pc1HmtmF3ptYJRU9lNyrLyLEft5MWKE6zRpwHz9Z
	 INu/UMYiOpcQwBhPL03haMTJs8imQ4ZDX1VzMtRCEENOiFztPLYOZf/x698fVX1BWQ
	 uH/fR9P7XMcfIdjMmC5gpllI=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E729C40E01A3;
	Mon,  1 Sep 2025 16:41:31 +0000 (UTC)
Date: Mon, 1 Sep 2025 18:41:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 04/20] x86/mce/amd: Put list_head in threshold_bank
Message-ID: <20250901164126.GGaLXMtqhTlUcFyf13@fat_crate.local>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-4-865768a2eef8@amd.com>
 <49d90a98-f3fb-4df2-837f-53b109cfcd6d@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49d90a98-f3fb-4df2-837f-53b109cfcd6d@suse.com>

On Mon, Sep 01, 2025 at 06:41:12PM +0300, Nikolay Borisov wrote:
> Will you integrate it (Boris) at merge time or should I send a patch now (or later) ?

No, a separate patch ontop pls with the rationale what this cleanup is
bringing, show asm and so on.

Also, there's this_cpu_read() and this_cpu_read_stable() - see comment above
the x86_this_cpu* so which ones are the best and why.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

