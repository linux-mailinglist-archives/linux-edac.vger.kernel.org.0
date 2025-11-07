Return-Path: <linux-edac+bounces-5412-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ABBC40022
	for <lists+linux-edac@lfdr.de>; Fri, 07 Nov 2025 14:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A583188A2DF
	for <lists+linux-edac@lfdr.de>; Fri,  7 Nov 2025 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1993213AD26;
	Fri,  7 Nov 2025 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Z4uunHem"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3394A1E;
	Fri,  7 Nov 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520455; cv=none; b=kkrgppXzxfVv197rbbG8xOSstrGyO9qZ8NMQnULESlVTiJVneAG1soVksd0u5FJqeOPbg7PU5qKI4HkkGP3wD1rBz2CCxIybvelqBlioeVjwnQc8uixuR+d5rr0Pzh8aVNwC/Hul5ndGoDkzik2JHSl2ToUjBxD+0dcm1dzqg8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520455; c=relaxed/simple;
	bh=Za1B0mGOccYYqV9TQVanc1/eNHd22vXD1GFqNFHdUMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ocjn5EPmiVoiRwBfBlCZZPuhrRzrvf7Ix+RioaTn7uJd/p8VtRO0AIBL+vWVzaJ4+PUArXXIKJlncXa5OxDpdnrBnqtR9VJLuwFFweLqEBvo/Y5kmnMLfM4Xk0W427j7aaRbj/ZxZNwREkJKU1K+T1BLZL3n449wukcqxkY6ovE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Z4uunHem; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3CA1340E019D;
	Fri,  7 Nov 2025 13:00:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yhZDK7HV0Mky; Fri,  7 Nov 2025 13:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762520447; bh=cQV3QbSfhhiR1dgFUEOXrhIJtSkr5i7YZAG4ewZGi+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z4uunHemwJG47CSA/VX5czcjffx6S4e+q9qnmfZHib7bbhvR2LZd+YlI2tVynQ+e/
	 SuoOGeQfM69C6ibZvD8Fch6j07PtS9OtMS454G225h3SSbSUbOXkUt8Bs+MqJyG148
	 Os0mzoapgode1Y2qTfn70qCj2722SXHNhuNnImSQ89UsIEPojgVUWKCxlvTeA1P62s
	 aZzW8tFPITvoOLFld1BT19gKQTdOuT67lvP+q0mM4z03KAeiFj4cp72kZ4IfWlZOhO
	 s6AQtbzNxCCgMgZQtGT12KyFBi+O6fegPsrC9XrivZ3FlCwGfokt80+XuKFl+hm9xI
	 KtmFn3AyBrrZI9skGLD5+xc+bCRYkLARO8vCVP798mM9XcAnwkmPAVDK92x4AgITT7
	 d2PeXaMWXI5LLAF3RZraLrj3eQ2UYqEbOLHOx2HDAu+wxM3cUmNuQDvPtJnkaeSRUb
	 7gpqYxpjJoGtt30pikPR/he575RjeDK1VMpoOS/ApaOf8GBWUaqSOEI1XQz1/C1pS3
	 XicBFhhRWiu0w17a1eMtq0iJGTsx/v3fNOS68ES8ene9IlsAy5G/iXnoRza2nFv67R
	 LobFuqV4xwr0heMl982mNJ83w51vvT1K/B+P8bgdBnqeeeEx1gCS5Wp1lSw0MzUQvS
	 D0ZGw0epav3pQN8RCuwK+cS4=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id ED2FD40E015B;
	Fri,  7 Nov 2025 13:00:37 +0000 (UTC)
Date: Fri, 7 Nov 2025 14:00:31 +0100
From: Borislav Petkov <bp@alien8.de>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2] RAS/CEC: replace use of system_wq with
 system_percpu_wq
Message-ID: <20251107130031.GBaQ3tb5GLPNeFSgbm@fat_crate.local>
References: <20251106112454.124568-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106112454.124568-1-marco.crivellari@suse.com>

On Thu, Nov 06, 2025 at 12:24:54PM +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used workqueue is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a CPU is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistency cannot be addressed without refactoring the API.
> For more details see the Link tag below.
> 
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> Switch to using system_percpu_wq because system_wq is going away as part of
> a workqueue restructuring.
> 
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/ras/cec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

