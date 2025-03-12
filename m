Return-Path: <linux-edac+bounces-3349-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27B2A5D66A
	for <lists+linux-edac@lfdr.de>; Wed, 12 Mar 2025 07:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846BA3A82C1
	for <lists+linux-edac@lfdr.de>; Wed, 12 Mar 2025 06:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF4B1E5701;
	Wed, 12 Mar 2025 06:39:19 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9DB2C182;
	Wed, 12 Mar 2025 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741761559; cv=none; b=Jiq0qSju0JmbXKm6LVSlEwNTkEJnDA9ofhEytmCBtxOPK7x0lpD1GFg+oI6CNennnt0ECM5p7HQk6Z2ZXy7o0mI5vkI+3Lj8to/5LpWnL6X6izMxVmy/2hqtJi9uPgfuOqUt1CHCLCpchL8t4SvlRLlTSI6rEUOK2oAlq0RiMFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741761559; c=relaxed/simple;
	bh=x+qKEywmekSRK3kHMQCREugxjGBlHkojqfQG4iSOqZU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ECe+kDEwtr6za70TcewREScTJ7RYv2ZgTNQMSOdYXN2Pui2nSsD3AbOxQHlc5l95urWXqr8i5ig1Wn5r3a/Pi2LCPxTeFQ8lmBJRFAHA3Z5sse1Gd1jK9sAcHm02KwS5NjT1uo7apQGlAa1lBf0ved9KL98r1nIl+AmwwTAY5nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZCLVN3j4HzCs97;
	Wed, 12 Mar 2025 14:35:40 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 42B661800CD;
	Wed, 12 Mar 2025 14:39:13 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Mar 2025 14:39:11 +0800
Subject: Re: [PATCH v4 2/3] mm/hwpoison: Do not send SIGBUS to processes with
 recovered clean pages
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <jpoimboe@kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <baolin.wang@linux.alibaba.com>,
	<tianruidong@linux.alibaba.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<peterz@infradead.org>, <catalin.marinas@arm.com>, <yazen.ghannam@amd.com>,
	<akpm@linux-foundation.org>, <nao.horiguchi@gmail.com>
References: <20250307054404.73877-1-xueshuai@linux.alibaba.com>
 <20250307054404.73877-3-xueshuai@linux.alibaba.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <662a16ee-66d3-3fc8-6488-8788bcfbe84e@huawei.com>
Date: Wed, 12 Mar 2025 14:39:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250307054404.73877-3-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2025/3/7 13:44, Shuai Xue wrote:
> When an uncorrected memory error is consumed there is a race between the
> CMCI from the memory controller reporting an uncorrected error with a UCNA
> signature, and the core reporting and SRAR signature machine check when the
> data is about to be consumed.
> 
> - Background: why *UN*corrected errors tied to *C*MCI in Intel platform [1]
> 
> Prior to Icelake memory controllers reported patrol scrub events that
> detected a previously unseen uncorrected error in memory by signaling a
> broadcast machine check with an SRAO (Software Recoverable Action Optional)
> signature in the machine check bank. This was overkill because it's not an
> urgent problem that no core is on the verge of consuming that bad data.
> It's also found that multi SRAO UCE may cause nested MCE interrupts and
> finally become an IERR.
> 
> Hence, Intel downgrades the machine check bank signature of patrol
> scrub from SRAO to UCNA (Uncorrected, No Action required), and signal
> changed to #CMCI. Just to add to the confusion, Linux does take an action
> (in uc_decode_notifier()) to try to offline the page despite the UC*NA*
> signature name.
> 
> - Background: why #CMCI and #MCE race when poison is consuming in Intel platform [1]
> 
> Having decided that CMCI/UCNA is the best action for patrol scrub errors,
> the memory controller uses it for reads too. But the memory controller is
> executing asynchronously from the core, and can't tell the difference
> between a "real" read and a speculative read. So it will do CMCI/UCNA if an
> error is found in any read.
> 
> Thus:
> 
> 1) Core is clever and thinks address A is needed soon, issues a speculative read.
> 2) Core finds it is going to use address A soon after sending the read request
> 3) The CMCI from the memory controller is in a race with MCE from the core
>    that will soon try to retire the load from address A.
> 
> Quite often (because speculation has got better) the CMCI from the memory
> controller is delivered before the core is committed to the instruction
> reading address A, so the interrupt is taken, and Linux offlines the page
> (marking it as poison).
> 
> - Why user process is killed for instr case
> 
> Commit 046545a661af ("mm/hwpoison: fix error page recovered but reported
> "not recovered"") tries to fix noise message "Memory error not recovered"
> and skips duplicate SIGBUSs due to the race. But it also introduced a bug
> that kill_accessing_process() return -EHWPOISON for instr case, as result,
> kill_me_maybe() send a SIGBUS to user process.
> 
> If the CMCI wins that race, the page is marked poisoned when
> uc_decode_notifier() calls memory_failure(). For dirty pages,
> memory_failure() invokes try_to_unmap() with the TTU_HWPOISON flag,
> converting the PTE to a hwpoison entry. As a result,
> kill_accessing_process():
> 
> - call walk_page_range() and return 1 regardless of whether
>   try_to_unmap() succeeds or fails,
> - call kill_proc() to make sure a SIGBUS is sent
> - return -EHWPOISON to indicate that SIGBUS is already sent to the
>   process and kill_me_maybe() doesn't have to send it again.
> 
> However, for clean pages, the TTU_HWPOISON flag is cleared, leaving the
> PTE unchanged and not converted to a hwpoison entry. Conversely, for
> clean pages where PTE entries are not marked as hwpoison,
> kill_accessing_process() returns -EFAULT, causing kill_me_maybe() to
> send a SIGBUS.
> 
> Console log looks like this:
> 
>     Memory failure: 0x827ca68: corrupted page was clean: dropped without side effects
>     Memory failure: 0x827ca68: recovery action for clean LRU page: Recovered
>     Memory failure: 0x827ca68: already hardware poisoned
>     mce: Memory error not recovered
> 
> To fix it, return 0 for "corrupted page was clean", preventing an
> unnecessary SIGBUS to user process.
> 
> [1] https://lore.kernel.org/lkml/20250217063335.22257-1-xueshuai@linux.alibaba.com/T/#mba94f1305b3009dd340ce4114d3221fe810d1871
> Fixes: 046545a661af ("mm/hwpoison: fix error page recovered but reported "not recovered"")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Cc: stable@vger.kernel.org

Thanks for your detailed commit log. This patch looks good to me.

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.

