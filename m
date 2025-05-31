Return-Path: <linux-edac+bounces-4050-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B0AC9A01
	for <lists+linux-edac@lfdr.de>; Sat, 31 May 2025 10:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0A11891B7F
	for <lists+linux-edac@lfdr.de>; Sat, 31 May 2025 08:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ABE22D9E0;
	Sat, 31 May 2025 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrCwpRra"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542D61096F
	for <linux-edac@vger.kernel.org>; Sat, 31 May 2025 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748679287; cv=none; b=KGE8D/nBhTjpiX725xc2SSOeSCFrtXG7UoqXhHjzhR78CuIIKsOOnq8uE1PAx9+zK+bEmVUn2xkqFdo/7nIagSN1wtBcrYl08JDDNL3WgTAH1saMr7ubQmf/AtqH4yTC919fTaw15vdUHoXWqeB7Rcd8+x5tSMKshA3nTKCYGy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748679287; c=relaxed/simple;
	bh=T/ang+L20AkogPPGRQnrXLlPtnrO2fPR6YRAeIe/vRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVhY9ieGNHPOOtZdPjVl5Y93mOMHWwrwe1e5byOMWzGulmo7mRu6Ydf0PyZnrLzQoatOmokyx3fTuZUZ5icg5DrKvtso4IW7CTa/97GEwHXHIP++nj/lvyPggSKUaoBD2qXU2+UuKKpU6vs6a69or/FayvBy567VYZwflGihD7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrCwpRra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008E6C4CEE3;
	Sat, 31 May 2025 08:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748679285;
	bh=T/ang+L20AkogPPGRQnrXLlPtnrO2fPR6YRAeIe/vRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrCwpRrapOjcUaVVUWorCUtzkbp+dqGrERcFHZsi3IBTc1w4UwAeLI23u01jtUQk7
	 mme2gAChtQnOfOKXb0FwFLJah+dVSd93o1ie0jYUG/pSwLig1YRPo2HrF320mqtgli
	 EF9DwIIxzKhYVbwQlcpXBAPz3lNSgrXrexFztWzjsWhjeLuf+vOIR9UZmNH5cA/aEv
	 EpYzs2m3wDF5YicyRiMzjkZ5Q/Krkef2bTaG0RRBoAV1KLFXKoVQcxyM+iT/7BT3hM
	 B0J1vlmanMWWKfyXF4jNU382fuPk/Dp4TEgCbWFQxAN7Q6QTRANvjrq1dVfLwgaqLc
	 Rz5shvkodbX3w==
Date: Sat, 31 May 2025 10:14:41 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>, tony.luck@intel.com,
	x86@kernel.org, linux-edac@vger.kernel.org, wanghai38@huawei.com,
	bobo.shaobowang@huawei.com
Subject: Re: [RFC PATCH] x86/mce/inject: Add sanity check in inject_mce()
Message-ID: <aDq6cecrsKYrwra2@gmail.com>
References: <20250529033256.31554-1-wangxiongfeng2@huawei.com>
 <20250529094534.GAaDgsvhdl-BrzlM0J@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529094534.GAaDgsvhdl-BrzlM0J@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Thu, May 29, 2025 at 11:32:56AM +0800, Xiongfeng Wang wrote:
> > syzbot reported the following kernel panic:
> > 
> > [  306.335489][ T3298] mce: CPUs not responding to MCE broadcast (may include false positives): 1-3
> > [  306.336332][ T3298] Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler
> > [  306.337786][ T3298] Kernel Offset: 0x17400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > 
> > The syzkaller test didn't set 'MCJ_IRQ_BROADCAST | MCJ_NMI_BROADCAST' in
> 
> That's because you're not supposed to inject MCEs with syzkaller 
> doing rando poking at the interface but someone with a brain should 
> use it.

Uhm, avoiding a hard kernel crash in case of a tooling or human error:

  [  306.336332][ T3298] Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler

... is in fact a proper interface robustness fix, especially if it's so 
incredibly simple as in this case. (The comment might need a bit of 
work but I digress.)

Injection can disrupt the kernel, but it shouldn't be able to trivially 
crash it in this case.

Improving MCE injection robustness might also help syzbot uncover 
*other* kernel bugs, because it can continue testing via the injection 
framework. But your proposed solution:

> Please point your syzkaller somewhere else.

... is how real kernel bugs might be hidden ...

Thanks,

	Ingo

