Return-Path: <linux-edac+bounces-5348-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A441C3709C
	for <lists+linux-edac@lfdr.de>; Wed, 05 Nov 2025 18:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE301626B98
	for <lists+linux-edac@lfdr.de>; Wed,  5 Nov 2025 16:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C515632ED56;
	Wed,  5 Nov 2025 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iQKcGWnv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945D831B113;
	Wed,  5 Nov 2025 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360202; cv=none; b=eSfFHVYR+dxjFluka9rwGSg9Um8GwOnov3dGlKOKjdBnsKMwha4Dg0jYscfSlGbmA9dtq7WhtqSRVULPa6yuNrJtI0At3WoSz3kFjskLdQsoVU3Uy+85nXbW89CtvZdd03dkVfmLJgiqvowxzMrULpRzdTRoEBV722ubJ2AVzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360202; c=relaxed/simple;
	bh=xmMPnx3YKPcWp71Ul44Dt6CmZiCIfCfg+fQ7k9riRuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1vo1KUWw4J52Oinx7kN/mmY5dsM/FZ6TbDEK4tT+9oFZcnbDHFpUoL7JjH9NrLi3yX+lTtG/GRsxZTTGF6mToNQQRiovGMo19h0rMm6DSuF8gmKZjrg0077ZFDee+z/lfH5y6cameE8P/3ysUF2NL3ZWQYg0Sqzk4EEBG/m8VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iQKcGWnv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 09CAF40E015B;
	Wed,  5 Nov 2025 16:29:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Jpqhu7UYiidN; Wed,  5 Nov 2025 16:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762360188; bh=N9KnH9xbtC4+g6m0PqksYjhsKL3Pdx7HzuaxpMw7t28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQKcGWnv1O4CfnJFptzv9rMOWKEGH8XPbyKXEqcYYcX7OP7vkp0fGnCA10ydw2Q7o
	 0PzLZr/DUyAqsZ/z8S1q17DvfkcFPKTWQSUq/04jOx/loylNZcU6hreeIjqMthbmA9
	 qHpMODyr/M1JsGKrQby1k9lwiq3LWP5mlNZH7rTnmDKTs299HNyDo0vA6t6kRaXmrg
	 KP9hr/uOPoVoSzQ3kQIeMWMrti4YDrmkrYA4EJ6K5plGmFSQnkGdou3Rypviarzisc
	 0IgIYssckEG1KpCyOREC85l+RjG9ROLfIUFGzCUxfq3dI3K9paZP1ZDXWohycy+7zr
	 DmxfQm3hE+6pB7f8pUmop8Xc7H2o5udpGO49BZicWOjHFuAHwWHo2inMk/awYPj3Sw
	 4CznaPIIFRtQQ70lVbdNI4cgjocEousTeiNjg64HKUU8rP6Ld4dTMhODCEdHXECUPQ
	 WWPTcyTu04dXryXsXZEOddBu3xXtsUJUSsoeUAUNZlsOGUmBjkx9Lkk3LtY7xBjiN1
	 qL9Nyy6nUvHsUy/my4jEmRXtquhPJFuoUzgJWiH2e9UVsjsdx3AcdrlJp5Gs6Jz84P
	 +HaLkogYbLtVx/89pqw1lz6OzY05j0cbn0kJcQSRFXPKNyv7YN8VkTN8R/s0UExMgR
	 c+XFqeyqSwUp5JVwK3J38doQ=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 696B940E00DA;
	Wed,  5 Nov 2025 16:29:39 +0000 (UTC)
Date: Wed, 5 Nov 2025 17:29:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] RAS/CEC: replace use of system_wq with system_percpu_wq
Message-ID: <20251105162932.GAaQt7bON4FtSmxQ3Z@fat_crate.local>
References: <20251105160819.302988-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105160819.302988-1-marco.crivellari@suse.com>

On Wed, Nov 05, 2025 at 05:08:19PM +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use

Please write out "wq" - the commit message should be for humans and not
contain variables or entities from the code.

> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to

s/cpu/CPU/

> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistency cannot be addressed without refactoring the API.
> 
> This patch continues the effort to refactor worqueue APIs, which has begun

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> with the change introducing new workqueues and a new alloc_workqueue flag:
> 
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> Replace system_wq with system_percpu_wq, keeping the old behavior.

What is the new behavior?

Should this driver be converted to it?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

