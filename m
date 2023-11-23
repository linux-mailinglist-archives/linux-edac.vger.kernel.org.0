Return-Path: <linux-edac+bounces-87-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 221C17F6253
	for <lists+linux-edac@lfdr.de>; Thu, 23 Nov 2023 16:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9903BB2141D
	for <lists+linux-edac@lfdr.de>; Thu, 23 Nov 2023 15:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFD333CF8;
	Thu, 23 Nov 2023 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SM/6TxLm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDD1D64;
	Thu, 23 Nov 2023 07:07:53 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F2CDC40E0257;
	Thu, 23 Nov 2023 15:07:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m5sjdodFMcPV; Thu, 23 Nov 2023 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1700752069; bh=GZioNhBqPoaVW6r9VNgUDTxDc/9WQFahtmtDcDv1jQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SM/6TxLmCLeeCMJ4E7eAn6aIauEZQYDF368OVQdaxtJMkCf3CvIxti5slID2BVG8T
	 7vlw2LVVbk1bS3DnCn8J6Tm8te6+efi6FDcjzlIjoC5+f+QG27JxLjHfBHheYGcQut
	 bcOXtX8ftoC4YUDrQFAKRPkmwTfJpRrkbI/0OTy7nU2hjzvU4t6tY69JbHucTrYPhW
	 8wP8EdCI9dHTom0ATgsb5RTUjJiC/9JbjriV6R+OowpPSQCgBYWZzYiUbUXaXXGBTV
	 Lnp1aVp6+K9DwYxKXo/kCkQMMAl0tSwCDo0vI+gV7IYDVnOj/tgn58Qmck734jvle8
	 s1qX7K27uPhTo8tutx/KBwdLgam7VR46wBo204py/FLWXvyjkS5KbwYeqcRf4ds/vv
	 189WaejXxC4zyMAngHPMVWdfiH/srNz8tUIUbyYdk5Sw02kWFghaX6yseQsJKvSDmy
	 n7CbsMRUZtQ/55hbbKcNiSVnH6BwIDxaRfmIxV2EURLNtKr/8PjKsI4/oozYuoREDy
	 WYRCFGP/z/hq+4RWfu0JFOyZywYRt0OoPMUhYmMyFHV0v7q+T4g8v19Ulkm8Kfu1Gn
	 n5kP3VMwL0iPvOkOfUoEqDF875T1CllORUq1wJebvge1tYzhwHHP8sFcRsrR3YZ3oE
	 ej22VW8rwDIqG1Ea0/a5GaHE=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9922540E0195;
	Thu, 23 Nov 2023 15:07:14 +0000 (UTC)
Date: Thu, 23 Nov 2023 16:07:10 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: rafael@kernel.org, wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
	mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
	naoya.horiguchi@nec.com, james.morse@arm.com,
	gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-edac@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
	stable@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
	ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
	robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v9 0/2] ACPI: APEI: handle synchronous errors in task
 work with proper si_code
Message-ID: <20231123150710.GEZV9qnkWMBWrggGc1@fat_crate.local>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20231007072818.58951-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231007072818.58951-1-xueshuai@linux.alibaba.com>

On Sat, Oct 07, 2023 at 03:28:16PM +0800, Shuai Xue wrote:
> However, this trick is not always be effective

So far so good.

What's missing here is why "this trick" is not always effective.

Basically to explain what exactly the problem is.

> For example, hwpoison-aware user-space processes use the si_code:
> BUS_MCEERR_AO for 'action optional' early notifications, and BUS_MCEERR_AR
> for 'action required' synchronous/late notifications. Specifically, when a
> signal with SIGBUS_MCEERR_AR is delivered to QEMU, it will inject a vSEA to
> Guest kernel. In contrast, a signal with SIGBUS_MCEERR_AO will be ignored
> by QEMU.[1]
> 
> Fix it by seting memory failure flags as MF_ACTION_REQUIRED on synchronous events. (PATCH 1)

So you're fixing qemu by "fixing" the kernel?

This doesn't make any sense.

Make errors which are ACPI_HEST_NOTIFY_SEA type return
MF_ACTION_REQUIRED so that it *happens* to fix your use case.

Sounds like a lot of nonsense to me.

What is the issue here you're trying to solve?

> 2. Handle memory_failure() abnormal fails to avoid a unnecessary reboot
> 
> If process mapping fault page, but memory_failure() abnormal return before
> try_to_unmap(), for example, the fault page process mapping is KSM page.
> In this case, arm64 cannot use the page fault process to terminate the
> synchronous exception loop.[4]
> 
> This loop can potentially exceed the platform firmware threshold or even trigger
> a kernel hard lockup, leading to a system reboot. However, kernel has the
> capability to recover from this error.
> 
> Fix it by performing a force kill when memory_failure() abnormal fails or when
> other abnormal synchronous errors occur.

Just like that?

Without giving the process the opportunity to even save its other data?

So this all is still very confusing, patches definitely need splitting
and this whole thing needs restraint.

You go and do this: you split *each* issue you're addressing into
a separate patch and explain it like this:

---
1. Prepare the context for the explanation briefly.

2. Explain the problem at hand.

3. "It happens because of <...>"

4. "Fix it by doing X"

5. "(Potentially do Y)."
---

and each patch explains *exactly* *one* issue, what happens, why it
happens and just the fix for it and *why* it is needed.

Otherwise, this is unreviewable.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

