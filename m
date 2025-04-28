Return-Path: <linux-edac+bounces-3777-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3A7A9F450
	for <lists+linux-edac@lfdr.de>; Mon, 28 Apr 2025 17:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615901897EEE
	for <lists+linux-edac@lfdr.de>; Mon, 28 Apr 2025 15:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37972797AC;
	Mon, 28 Apr 2025 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hq3lpwr6"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42902797A1;
	Mon, 28 Apr 2025 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853841; cv=none; b=Cg7DbaaSxIAEnMQlSPTQCFkLFMsG69RkiL6V1d28AUGQn2URYvNi2jJshI/iEO/QID1IXsA21g99Mm1s0orOopwhoKzJYCMl3HHvfQlBgr7R1U5xc0ogTJ0hZIWqUZTFqbC4vx4lRSuK3RPz7etbBlJ2C/+CC/JODulenp2ZfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853841; c=relaxed/simple;
	bh=HzKzkrxa9A4F/zt2zYIknGsXS+zLy1fxDykz1llhI68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaSti2ch/fpuGC1DwtG+vBHgLqN4kwkNtn8+IHxPK2qvJQmOjk6HazAGNnc0J3FXHi0zawcE+LwTgQ8M623Dy5oK6Dytg6mhTpkZjJPwrMH9b5XIYkTGTFwYGKkoCjcIddkVqQLApKyXeZQ9WpVP+kp/pVIBDGlVa5lUFK6Axzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hq3lpwr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEA0C4CEE4;
	Mon, 28 Apr 2025 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745853841;
	bh=HzKzkrxa9A4F/zt2zYIknGsXS+zLy1fxDykz1llhI68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hq3lpwr6J3FigWsiuBd93GDgW7+LocZzZO4qV35W2Z3DVqLenlDHfJukspyiadhYm
	 uj9RRJp8DCUnPxagJAp2mDC8QgicsTp+AU7gFHo4L0fhRtj2t2btuUDnKTkafimpAO
	 jp2SjwZ909NDiImGdOHfc37lXm1c72newPMRUzXAqODW7nr23tQoKIcZfBnDd0X0hE
	 bPcKrnpek9brq0HwhW2DTumJdIZIyDI06TjdFtEHzvLmNIGwpaH6ifPFrj9WWn9zvi
	 isa7xYK/bOoG9YGq2Wh9Nc6ndsl8Wqs2XQI1xbhw0UbodP2JI5kY/PtRFa4d8SbpMo
	 LO4MFVuKpFbrg==
Date: Mon, 28 Apr 2025 16:23:51 +0100
From: Will Deacon <will@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Hanjun Guo <guohanjun@huawei.com>, "Luck, Tony" <tony.luck@intel.com>,
	rafael@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, linux-edac@vger.kernel.org,
	x86@kernel.org, justin.he@arm.com, ardb@kernel.org,
	ying.huang@linux.alibaba.com, ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com, tglx@linutronix.de,
	dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
	robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com, sudeep.holla@arm.com,
	lpieralisi@kernel.org, linux-acpi@vger.kernel.org,
	yazen.ghannam@amd.com, mark.rutland@arm.com, mingo@redhat.com,
	robin.murphy@arm.com, Jonathan.Cameron@Huawei.com, bp@alien8.de,
	linux-arm-kernel@lists.infradead.org, wangkefeng.wang@huawei.com,
	tanxiaofei@huawei.com, mawupeng1@huawei.com, linmiaohe@huawei.com,
	naoya.horiguchi@nec.com, james.morse@arm.com,
	tongtiangen@huawei.com, gregkh@linuxfoundation.org,
	jarkko@kernel.org
Subject: Re: [RESEND PATCH v18 1/2] ACPI: APEI: send SIGBUS to current task
 if synchronous memory error not recovered
Message-ID: <20250428152350.GA23615@willie-the-truck>
References: <20250404112050.42040-1-xueshuai@linux.alibaba.com>
 <20250404112050.42040-2-xueshuai@linux.alibaba.com>
 <0c0bc332-0323-4e43-a96b-dd5f5957ecc9@huawei.com>
 <709ee8d2-8969-424c-b32b-101c6a8220fb@linux.alibaba.com>
 <353809e7-5373-0d54-6ddb-767bc5af9e5f@huawei.com>
 <653abdd4-46d2-4956-b49c-8f9c309af34d@linux.alibaba.com>
 <de5d2417-dc92-b276-1125-4feb5151de7f@huawei.com>
 <f60f1128-0d42-48e5-9a06-6ed7ca10767f@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f60f1128-0d42-48e5-9a06-6ed7ca10767f@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Apr 25, 2025 at 09:10:09AM +0800, Shuai Xue wrote:
> 在 2025/4/25 09:00, Hanjun Guo 写道:
> > Call force_sig(SIGBUS) directly in ghes_do_proc() is not my favourite,
> > but I can bear that, please add
> > 
> > Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> > 
> > Thanks
> > Hanjun
> 
> Thanks. Hanjun.
> 
> @Rafael, @Catalin,
> 
> Both patch 1 and 2 have reviewed-by tag from the arm64 ACPI maintainers, Hanjun,
> now. Are you happpy to pick and queue this patch set to acpi tree or arm tree?

Since this primarily touches drivers/acpi/apei/ghes.c, I think it should
go via the ACPI tree and not the arm64 one.

Will

