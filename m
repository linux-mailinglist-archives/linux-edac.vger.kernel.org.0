Return-Path: <linux-edac+bounces-4038-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BE5AC7B54
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 11:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916153AB4DD
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 09:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49455274FDF;
	Thu, 29 May 2025 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ag1EWUbx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239527FD59
	for <linux-edac@vger.kernel.org>; Thu, 29 May 2025 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511953; cv=none; b=LjLyl5tA1zQvbF/zsnDczBEj6zg085N9UUsj5Je2GLivXyZjSDD4r4Nrw3kLWr+KfZIn2jLTHym2Sft1ns2icykoidgq6Jcq3nISkaP/aZW9djwIEKwEayG9StmL58tgG0hZkk/5POmdag0/kgbKAovv48t6SwuHjYnR+WvdRuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511953; c=relaxed/simple;
	bh=fLZrkXXAZbnOpghNe2ZNYO+VPIyMYkFKsBdLL5DHQ8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=extEFIErBxw37EXnmy6+Vyp1J9hbRTUk7BW82wTI2WXwk0CC4g+cB8j6F9x2JVIaOfVxq+VXE7b1/Guq7iYsEcC4SGYC1fpSn6UuUModbgYzNxPqQn2X3bUi+zO7tQozpWFuUiRN36UpWBuPvT8WfRDXJnfBhXBHat6Kw/1HnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ag1EWUbx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A291240E01B0;
	Thu, 29 May 2025 09:45:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VPlYnA3GMFHw; Thu, 29 May 2025 09:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748511942; bh=poB2hzDcBMbXDRkNXfJXV6ZIxr8JSuop428tZ0JS7CM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ag1EWUbxeIJ9oejCyf0//hdyZLVCzH6an0KSDLjJM4UL9j1hc9O131nEo+fehNtwl
	 mz9mKYbGf8uxAUErlu6VJ6r3gzD/iCPwHvVojXpvRQy7zvQ2VPHAWzAlbdK1uQQp4I
	 DhfBS9KYLYwfa6CJXz1KM+HGLWhwll2FwRjdg1uyHpuAV1dbFGZXLPj6MymKVCmg+P
	 jzdei5Ya695cW5xmJ7hAfDt+2uDX0W3N9GMP0u26IQUiWF6W68gzfedP+4O0rRkq4f
	 AYLYks/pV3dia7TW6osVBRdtXyVlHc1FEwirygeCrgXJ8N1nFLZRzp4MTOdZntHGxI
	 0hZsmI7hPkNH6FIA76/KZWiljgsl/IDS4R5YILkuYTN/ybTFg4OKFQfSHxLsBv75At
	 yK7xQhCIYFnUHz6qDrOjbGouu74PasCQ19Vic26cYTuSHPbZjz5uKT+kGcgYQeX8ft
	 qsMZAsV94X7U1zE5YdgSjZWfYb7fAGr/Qhpb7/um4BhNlcnHnjgOinpmr47ntxQx28
	 R+MP+Z/KF4fHLNAEhj6R13shGcvAdlsuSfxXdUGoZjOlyE+xnMzidQw2ZJvARh90YP
	 bvkKDsPyIPDoRiEz94Go1krJxxtJSiqE2pxpKf20cLLP0/KaOa/XsnbVm/gvEqUqoY
	 3OJKeyYZlc7jbhowuVLBk9O8=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C2AFF40E01B4;
	Thu, 29 May 2025 09:45:36 +0000 (UTC)
Date: Thu, 29 May 2025 11:45:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: tony.luck@intel.com, x86@kernel.org, linux-edac@vger.kernel.org,
	wanghai38@huawei.com, bobo.shaobowang@huawei.com
Subject: Re: [RFC PATCH] x86/mce/inject: Add sanity check in inject_mce()
Message-ID: <20250529094534.GAaDgsvhdl-BrzlM0J@fat_crate.local>
References: <20250529033256.31554-1-wangxiongfeng2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250529033256.31554-1-wangxiongfeng2@huawei.com>

On Thu, May 29, 2025 at 11:32:56AM +0800, Xiongfeng Wang wrote:
> syzbot reported the following kernel panic:
> 
> [  306.335489][ T3298] mce: CPUs not responding to MCE broadcast (may include false positives): 1-3
> [  306.336332][ T3298] Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler
> [  306.337786][ T3298] Kernel Offset: 0x17400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> The syzkaller test didn't set 'MCJ_IRQ_BROADCAST | MCJ_NMI_BROADCAST' in

That's because you're not supposed to inject MCEs with syzkaller doing rando
poking at the interface but someone with a brain should use it.

And someone with a brain might realize that injecting a wrong error is also
a test.

Please point your syzkaller somewhere else.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

