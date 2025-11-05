Return-Path: <linux-edac+bounces-5342-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1705C3467C
	for <lists+linux-edac@lfdr.de>; Wed, 05 Nov 2025 09:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A758C4F28C3
	for <lists+linux-edac@lfdr.de>; Wed,  5 Nov 2025 08:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1422BFC8F;
	Wed,  5 Nov 2025 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9KTd5iK"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C921CC68;
	Wed,  5 Nov 2025 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330333; cv=none; b=HVB07PjkTicqUx1BY6iX4byskVlgMiygPPVWAJUV+XOyu3SKzABZ4Nad3vWm1iYrBkzgJJpLc69HLtqmzPnwVUN8nD7NzEDCaAGOWHXZOh5oDqxYddsZyjF76qGN7Eza3IcA7u+rVyO4a3iFaQzIupR/Poc1YDP7VuA3c0TXXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330333; c=relaxed/simple;
	bh=7Fk+JE049jRq/zXL5tufjYxIcvB4hcpZcXMbt7dUjgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=deflOVm0Qk+7jiaAHdUYgzEowGEXyEMMCPIzs0AmsWMAhcQk6ZFrdwqG+4RtZjXqFGdNF6Bht9+MYkhbCoA09+47rvnTrX+G79sy4x8l4zSpM4bK8A2L8HgRTL74RcDS+Bju5Tw45hTpxwKRsi9DUEHQSiYr67aRB3pr572VWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9KTd5iK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D610C4CEFB;
	Wed,  5 Nov 2025 08:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762330332;
	bh=7Fk+JE049jRq/zXL5tufjYxIcvB4hcpZcXMbt7dUjgA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c9KTd5iKkP88XP9XQhtAfMBSRIhe9sA+rFNNqkfPPMLWhXnldgaJ4P+jz+479/mjE
	 HTs2V8zAPf554XF2yCjENkd20C32geFAE3e5fEYClAjs/Rg5w7QVRmijfEcvDlGeex
	 2MOQ8xhjGTWLnUwmNBPZ1+lIM0wt7+kVVRJloUgWy1OX+I4avR8q11yQE7BWHqz7r/
	 5/5H1QjUCf36/VloeQmGJsOYqULVviz/x+rrbSG9onf3Xfzc4ORjolHqRHoxYEBiYO
	 ei2eqoX/HIVlZtHbZNcqWXMrRTurUxRkuZqQ6zdmCefDLn52Y0OPrsIik73VVQH7l2
	 pbBWSSateNTJQ==
Message-ID: <57936358-69b0-4028-a0df-b5f5acc32ca9@kernel.org>
Date: Wed, 5 Nov 2025 09:12:04 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] x86/mm: support memory-failure on 32-bits with
 SPARSEMEM
To: Xie Yuanbin <xieyuanbin1@huawei.com>, dave.hansen@intel.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, liaohua4@huawei.com,
 lilinjie8@huawei.com, linmiaohe@huawei.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, luto@kernel.org, mhocko@suse.com,
 mingo@redhat.com, nao.horiguchi@gmail.com, peterz@infradead.org,
 rppt@kernel.org, surenb@google.com, tglx@linutronix.de, tony.luck@intel.com,
 vbabka@suse.cz, will@kernel.org, x86@kernel.org
References: <47b3e8ba-bc95-41ce-be0a-ddfd1323bab3@intel.com>
 <20251105024523.14300-1-xieyuanbin1@huawei.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251105024523.14300-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.11.25 03:45, Xie Yuanbin wrote:
> On Tue, 4 Nov 2025 06:26:58 -0800, Dave Hansen wrote:
>> Which LLM generated that for you, btw?
> 
> I wrote this myself; LLM just helped me with the translation. My English
> isn't very good, so I apologize for any mistakes.
> 
>> I wanted to know _specifically_ what kind of hardware or 32-bit
>> environment you wanted to support with this series, though.
> 
> I think I have explained it clearly enough in this email:
> Link: https://lore.kernel.org/20251104133254.145660-1-xieyuanbin1@huawei.com
> 
> In simple terms, it refers to some old existing equipment and some
> embedded devices. More specifically, it includes some routers, switches,
> and similar devices. From what I know, there is no VM environment that
> using it.
> If you are asking about a specific CPU chip model, I'm sorry, but I may
> not be able to provide that information for you.
> 
> Btw, why do you only ask about which x86_32 devices use memory-failure,
> but not which x86_32 devices use sparsemem? This patch just allows both
> to coexist, and perhaps both are important?

Let me clarify what we need to know:

Will you (or your employer) be running such updated 32bit kernels on 
hardware that supports MCEs.

In other words: is this change driver by *real demand* or just by "oh 
look, we can enable that now, I can come up with a theoretical use case 
but I don't know if anybody would actually care"?

-- 
Cheers

David

