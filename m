Return-Path: <linux-edac+bounces-3350-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFA0A5D7C1
	for <lists+linux-edac@lfdr.de>; Wed, 12 Mar 2025 09:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF0517A7B2
	for <lists+linux-edac@lfdr.de>; Wed, 12 Mar 2025 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F4B22E40A;
	Wed, 12 Mar 2025 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OPfIehn4"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3663D1E260A;
	Wed, 12 Mar 2025 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766618; cv=none; b=mE9Rks5/9Q7LZaeM2p8pgFp4onxrMbmpDdm/46s0hmYsS5cTj55HCCa8rJTrpx+wDJVDZRKdVXHerN8BiVHW7+JkykTJSdS2YCRCOKMOFj+gpXRWtB7QmjibJvizNuRgTH1TeIY2zt2vkq3gr5k3T0w879nnrkthwdYVZyUPiZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766618; c=relaxed/simple;
	bh=lCiD3frpAVcYl2Zjx16HB4J98GURUosGxHB94ESnJXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pybuZ4s1zrlkrGZQxa/DqaNO/33MrScSfLIab1Sif3uInQGxTKBon1bmFl3qaNHBPz6LhgnvxeadWb6c/JrSXuQM4kc+AgnhmD1/oJvCsgZHV2YbdfRIsvof0xHw0pS+g0RXUSwUOP8kJowHdqvTDdQM1MRIXqaO/sZWDWdNf3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OPfIehn4; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741766606; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4eQWP95hD+rHKyU8INAu0G1d6sAjuAMp9XDqbuG9YPA=;
	b=OPfIehn4lAwlVIgB4gyAWjyk5LPK4GGXCgFzb7SOjZt8NEwrNZdm89r7wjNlZm4ea6Lwl1IaZuUZYlQujUrgA5kYdB0XG2YkqnzFFhmeJ5y7PdrdylVTS+Ko5x5N7VDmvd+oEtd6qwJW2Y/hm7JGiRaFfItglCCdoJ78rUVh3AM=
Received: from 30.221.65.55(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WRBqTIH_1741766603 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Mar 2025 16:03:24 +0800
Message-ID: <62e01956-0796-42d5-b4fc-f66b478bf9bc@linux.alibaba.com>
Date: Wed, 12 Mar 2025 16:03:23 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] mm/hwpoison: Do not send SIGBUS to processes with
 recovered clean pages
To: Miaohe Lin <linmiaohe@huawei.com>, tony.luck@intel.com,
 Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, jpoimboe@kernel.org,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
 tianruidong@linux.alibaba.com, bp@alien8.de, peterz@infradead.org,
 catalin.marinas@arm.com, yazen.ghannam@amd.com, akpm@linux-foundation.org,
 nao.horiguchi@gmail.com
References: <20250307054404.73877-1-xueshuai@linux.alibaba.com>
 <20250307054404.73877-3-xueshuai@linux.alibaba.com>
 <662a16ee-66d3-3fc8-6488-8788bcfbe84e@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <662a16ee-66d3-3fc8-6488-8788bcfbe84e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/12 14:39, Miaohe Lin 写道:
> On 2025/3/7 13:44, Shuai Xue wrote:
>> When an uncorrected memory error is consumed there is a race between the
>> CMCI from the memory controller reporting an uncorrected error with a UCNA
>> signature, and the core reporting and SRAR signature machine check when the
>> data is about to be consumed.
>>
>> - Background: why *UN*corrected errors tied to *C*MCI in Intel platform [1]
>>
>> Prior to Icelake memory controllers reported patrol scrub events that
>> detected a previously unseen uncorrected error in memory by signaling a
>> broadcast machine check with an SRAO (Software Recoverable Action Optional)
>> signature in the machine check bank. This was overkill because it's not an
>> urgent problem that no core is on the verge of consuming that bad data.
>> It's also found that multi SRAO UCE may cause nested MCE interrupts and
>> finally become an IERR.
>>
>> Hence, Intel downgrades the machine check bank signature of patrol
>> scrub from SRAO to UCNA (Uncorrected, No Action required), and signal
>> changed to #CMCI. Just to add to the confusion, Linux does take an action
>> (in uc_decode_notifier()) to try to offline the page despite the UC*NA*
>> signature name.
>>
>> - Background: why #CMCI and #MCE race when poison is consuming in Intel platform [1]
>>
>> Having decided that CMCI/UCNA is the best action for patrol scrub errors,
>> the memory controller uses it for reads too. But the memory controller is
>> executing asynchronously from the core, and can't tell the difference
>> between a "real" read and a speculative read. So it will do CMCI/UCNA if an
>> error is found in any read.
>>
>> Thus:
>>
>> 1) Core is clever and thinks address A is needed soon, issues a speculative read.
>> 2) Core finds it is going to use address A soon after sending the read request
>> 3) The CMCI from the memory controller is in a race with MCE from the core
>>     that will soon try to retire the load from address A.
>>
>> Quite often (because speculation has got better) the CMCI from the memory
>> controller is delivered before the core is committed to the instruction
>> reading address A, so the interrupt is taken, and Linux offlines the page
>> (marking it as poison).
>>
>> - Why user process is killed for instr case
>>
>> Commit 046545a661af ("mm/hwpoison: fix error page recovered but reported
>> "not recovered"") tries to fix noise message "Memory error not recovered"
>> and skips duplicate SIGBUSs due to the race. But it also introduced a bug
>> that kill_accessing_process() return -EHWPOISON for instr case, as result,
>> kill_me_maybe() send a SIGBUS to user process.
>>
>> If the CMCI wins that race, the page is marked poisoned when
>> uc_decode_notifier() calls memory_failure(). For dirty pages,
>> memory_failure() invokes try_to_unmap() with the TTU_HWPOISON flag,
>> converting the PTE to a hwpoison entry. As a result,
>> kill_accessing_process():
>>
>> - call walk_page_range() and return 1 regardless of whether
>>    try_to_unmap() succeeds or fails,
>> - call kill_proc() to make sure a SIGBUS is sent
>> - return -EHWPOISON to indicate that SIGBUS is already sent to the
>>    process and kill_me_maybe() doesn't have to send it again.
>>
>> However, for clean pages, the TTU_HWPOISON flag is cleared, leaving the
>> PTE unchanged and not converted to a hwpoison entry. Conversely, for
>> clean pages where PTE entries are not marked as hwpoison,
>> kill_accessing_process() returns -EFAULT, causing kill_me_maybe() to
>> send a SIGBUS.
>>
>> Console log looks like this:
>>
>>      Memory failure: 0x827ca68: corrupted page was clean: dropped without side effects
>>      Memory failure: 0x827ca68: recovery action for clean LRU page: Recovered
>>      Memory failure: 0x827ca68: already hardware poisoned
>>      mce: Memory error not recovered
>>
>> To fix it, return 0 for "corrupted page was clean", preventing an
>> unnecessary SIGBUS to user process.
>>
>> [1] https://lore.kernel.org/lkml/20250217063335.22257-1-xueshuai@linux.alibaba.com/T/#mba94f1305b3009dd340ce4114d3221fe810d1871
>> Fixes: 046545a661af ("mm/hwpoison: fix error page recovered but reported "not recovered"")
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Cc: stable@vger.kernel.org
> 
> Thanks for your detailed commit log. This patch looks good to me.
> 
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Thanks.
> .

Thanks.

Most part is borrowed from disscusion with Tony and Borislav.
Thanks to them :)

Best Regards,
Shuai

