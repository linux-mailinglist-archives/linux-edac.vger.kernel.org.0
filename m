Return-Path: <linux-edac+bounces-5358-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8124DC3A644
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 11:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E420446062B
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 10:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317B12E7F27;
	Thu,  6 Nov 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TJ4SWpwP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194FF2DF3E7;
	Thu,  6 Nov 2025 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426188; cv=none; b=S1ZIF9zZL19ARdPuDw2BrCxbMKhAKF0ZzjIp9mYE+TUxzGYw/OTx3fQmThwuL2Rd7aHPI1FRBsWBHv4fkKvm2CUtcV253C/7x1CbmJC+Se6ezbM1U0q0m5uVRKw7Au0ls45pBYY6c+DlmMINa8CuXW1Z3/CAEZF/8Q2WgdX7GgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426188; c=relaxed/simple;
	bh=YKP7Th4zVLuuAuOM7NcZ0i+1Bw6aYpx2EEwaVsgVlao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ydzjy4zkdyOs9eGt90NdRnGeXC2esJhdJkMRkQVtWBKx67Iy3TDXyv8g7/QiHxGvod7nmUpXMAGW/O15hNni22nSHzOHPjbUdLOe5LNUIJjkKC40QJqME3GvE7V2GnFPQ5hzNEmr2Eh6mZzomspAYEOlETvQxzvGK9X4zt8labs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TJ4SWpwP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E300C40E015B;
	Thu,  6 Nov 2025 10:49:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wTi7bhfukc6V; Thu,  6 Nov 2025 10:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762426177; bh=gyOvdXOrnEluTOO6haSsa++6h8EFc7Jgv5/xmdRSlJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJ4SWpwPL6aRcMuGCPD8nPiqrx0B52O1rl33MA6FdoJpmhLga3veTY5o9o7CgDtfJ
	 hvlbRjo9QJgtbHbdsRyJ/N7BxqZcRd6vIiAiJw25/pW7PJiEfxbfzYL7DkAWRBqGWi
	 WsN3kGl/rKDiV5vwWLBkp1b+ajaVKip2ZXbeCHlDSji/Pm04/rdYGXyk6QFRJ8WHDp
	 AWbWMl4HiFRPX12jUNgwIW7dVIlJEV0NlD+mrI2UCpmhGSd2u1oZpF4rnzdJBQk/bA
	 bgi51rnZ4L8PELQioKhVjY1SwSpuQA+7UOAtjbPnaww8FwM7hK6IMJeVvrDWm5pxgW
	 jdYr0V6++pj94QWGPHu3rHAqTlvU3WIXHZoCXYtaYdWmm0HSd2DmelGpSWJOJYrI0X
	 cLmbb9U6APA8bjo4omc0aIGdrmDGynVF8dxLAJSbuu56a4n2iPxLTux3gV1O+pqGLC
	 zlG3RcmsbHjvVo2LuMhCPY1ceqXCbwzOnETMqApTeVkAk3t76h9JrEDlFR4TYx0aSJ
	 LHT75/cO6F+fCrF3XWVp30TtpThVDthYnnGu9UiqX2WPwulmMjJeBchWiiishRNyzD
	 VXYJRfyWFT7LltFH+9nBY4q5rt/7E1I5jHloLfZNYugt2R4T2Zk1NakTMysD0hCjM4
	 i4WavLYk0L6Cjktg7V6y0/48=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6718B40E019F;
	Thu,  6 Nov 2025 10:49:28 +0000 (UTC)
Date: Thu, 6 Nov 2025 11:49:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] RAS/CEC: replace use of system_wq with system_percpu_wq
Message-ID: <20251106104921.GAaQx9MWLfhyqHNDYK@fat_crate.local>
References: <20251105160819.302988-1-marco.crivellari@suse.com>
 <20251105162932.GAaQt7bON4FtSmxQ3Z@fat_crate.local>
 <CAAofZF4fBbFtiKxde2M2ikK4k-LqYVRoavPbNVh-XFiQPmfGvw@mail.gmail.com>
 <20251105210800.GCaQu8sKCjZ9Xcq8-n@fat_crate.local>
 <CAAofZF4Sdk0REJFearcrB5_MLLQZWaNpecUPV0+BOiNcvmTaWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAofZF4Sdk0REJFearcrB5_MLLQZWaNpecUPV0+BOiNcvmTaWA@mail.gmail.com>

On Thu, Nov 06, 2025 at 10:17:18AM +0100, Marco Crivellari wrote:
> It's just a "rename" from system_wq to system_percpu_wq.

So why don't you call it that?

Instead of beating around the bush and confusing me? :-)

IOW, just do this:

"Rename system_wq to system_percpu_wq as part of workqueue refactoring.

For more details see the Link tag below.

...

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de"

And now all those people who are interested in the details can go look it up.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

