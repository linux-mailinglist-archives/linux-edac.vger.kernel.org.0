Return-Path: <linux-edac+bounces-3196-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EE0A42FBE
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2025 23:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392C03A746B
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2025 22:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5351C32EA;
	Mon, 24 Feb 2025 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FWpxCUm7"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A968C11;
	Mon, 24 Feb 2025 22:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434539; cv=none; b=tTdALDBp5QQi7udF7S7PcMQHrgieLQpXdx1t8bHSFfOHCoItwBLmR/9vH97LIl8miVcDv+EAC2xH09Cb+rzHSdqiVcBJC5wir9iZ/gfv8cUnK9Gkd18T8KPC9zo9ZcLPg5zaDp0kmzc31OBJyfLF7QRDj88Xn4UGtBEjxPB5iBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434539; c=relaxed/simple;
	bh=/rKiPHdMJyKIoy0x6nRegxth6DbSPTz3v0tveGQPkHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hd//RhS1GsGaIy71uyyjLF0njcaDtB/k81kwXCExJ3RAMO/slqHakIKnH/b49/BdFwdnNBPLycwXQ9Fdynwxmqvahq3PAvlQUGk6X1yvHt9q3+WjSeuVBi2eIs2KiI3v1647KkZ2EQ3anteX5H492Z/ccD5iyCKEyH81E2ZKaJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FWpxCUm7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 16F6E40E01AD;
	Mon, 24 Feb 2025 22:02:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dasogVygUtBK; Mon, 24 Feb 2025 22:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740434529; bh=ZBR+ADqnnnM3sXp77K9ZzJ39W0vxRbheejoHC6DUJTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWpxCUm7L7h99WwLCtPh++7b0CVG2n05Rklf8+bCimGPwpYUdTbVyACoenHRwI1An
	 kAizWc+ZVoNFQpU3MJ71COJdWj0d1zU6BD7NCQ5d9h9q62o+PPHQ90ln9L7e+JDIn1
	 2oCP9LZsLOUS17wai/mVhefPp5ERd8uPylL7T2B260kglWP4ZAGVd+EOUcKYJoYTBr
	 bO1F/+pHuc8N8ra/QP53WcF2g5PUsqIX8pcFKOPLciIT/IJnilZ1+ehXoz+CYLodES
	 t817GlpTK5J/bRJZA4OvVhFEl7WTZiRywDOz6GuY7fAN+3vPGaST1BcYulGjLzYD+c
	 QNCD5n7asyFH612IJkLmigZUmjffWEMIFNuQaql8Qw8YC8Bu0V0iJpNRVRkrQZ3Rha
	 eso/7QTqLZ95fYHA7ubaCX5Iq8xfSqe5h/jGNhf33ergcpyIkv1no+9xy5PLwrW3PX
	 +jXwynO08uDvRCildtfgzmmblnccQZyo+NIpAnoJ6DCOxaFLeiklmO0Kf4ax9T+p0G
	 tEm5WSONSwr2/EoGmt4lJB4FU/FwvaEmZavGURaVUvJY28ZGkT8FBQjFswAEi8KO+s
	 Je59+cg8L+n7O1LLzL+Owv8FeyUckMPj1unnMuXz0GK1umUvHeuqJIn5Rhl1QhPeGs
	 9VL0/jANcrrNvcmFyFaj/Adg=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8B8F40E0184;
	Mon, 24 Feb 2025 22:01:51 +0000 (UTC)
Date: Mon, 24 Feb 2025 23:01:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
Subject: Re: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
Message-ID: <20250224220146.GBZ7zsSnXLftyqWzW_@fat_crate.local>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
 <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
 <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
 <SJ1PR11MB60836781C4CE26C4B43AFF0BFCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250219081037.GAZ7WR_YmRtRvN_LKA@fat_crate.local>
 <SJ1PR11MB6083F7AC9C5AED072141B8CAFCC52@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250220111903.GDZ7cPp1qVq3t9Jgs6@fat_crate.local>
 <SJ1PR11MB608335ACA7AEC51F7F6A75D2FCC42@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <4e13bef2-7402-4f75-8f0c-4a3cc210c5a6@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e13bef2-7402-4f75-8f0c-4a3cc210c5a6@linux.alibaba.com>

On Fri, Feb 21, 2025 at 02:05:28PM +0800, Shuai Xue wrote:
> #perf script
> kworker/48:1-mm 25516 [048]  1713.893549: probe:memory_failure: (ffffffffaa622db4)
>         ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
>         ffffffffaa25aa93 uc_decode_notifier+0x73 ([kernel.kallsyms])
>         ffffffffaa3068bb notifier_call_chain+0x5b ([kernel.kallsyms])
>         ffffffffaa306ae1 blocking_notifier_call_chain+0x41 ([kernel.kallsyms])
>         ffffffffaa25bbfe mce_gen_pool_process+0x3e ([kernel.kallsyms])
>         ffffffffaa2f455f process_one_work+0x19f ([kernel.kallsyms])
>         ffffffffaa2f509c worker_thread+0x20c ([kernel.kallsyms])
>         ffffffffaa2fec89 kthread+0xd9 ([kernel.kallsyms])
>         ffffffffaa245131 ret_from_fork+0x31 ([kernel.kallsyms])
>         ffffffffaa2076ca ret_from_fork_asm+0x1a ([kernel.kallsyms])
> 
> einj_mem_uc 44530 [184]  1713.908089: probe:memory_failure: (ffffffffaa622db4)
>         ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
>         ffffffffaa2594fb kill_me_maybe+0x5b ([kernel.kallsyms])
>         ffffffffaa2fac29 task_work_run+0x59 ([kernel.kallsyms])
>         ffffffffaaf52347 irqentry_exit_to_user_mode+0x1c7 ([kernel.kallsyms])
>         ffffffffaaf50bce noist_exc_machine_check+0x3e ([kernel.kallsyms])
>         ffffffffaa001303 asm_exc_machine_check+0x33 ([kernel.kallsyms])
>                   405046 thread+0xe (/home/shawn.xs/ras-tools/einj_mem_uc)
> 
> einj_mem_uc 44531 [089]  1713.916319: probe:memory_failure: (ffffffffaa622db4)
>         ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
>         ffffffffaa2594fb kill_me_maybe+0x5b ([kernel.kallsyms])
>         ffffffffaa2fac29 task_work_run+0x59 ([kernel.kallsyms])
>         ffffffffaaf52347 irqentry_exit_to_user_mode+0x1c7 ([kernel.kallsyms])
>         ffffffffaaf50bce noist_exc_machine_check+0x3e ([kernel.kallsyms])
>         ffffffffaa001303 asm_exc_machine_check+0x33 ([kernel.kallsyms])
>                   405046 thread+0xe (/home/shawn.xs/ras-tools/einj_mem_uc)

What are those stack traces supposed to say?

Two processes are injecting, cause a #MC and a kworker gets to handle the UC?

All injecting to the same page?

What's the upper limit on CPUs seeing the same hw error and all raising
a CMCI/#MC?

> - kill_accessing_process() is only called when the flags are set to
>   MF_ACTION_REQUIRED, which means it is in the MCE path.
> - Whether the page is clean determines the behavior of try_to_unmap. For a
>   dirty page, try_to_unmap uses TTU_HWPOISON to unmap the PTE and convert the
>   PTE entry to a swap entry. For a clean page, try_to_unmap uses ~TTU_HWPOISON
>   and simply unmaps the PTE.
> - When does walk_page_range() with hwpoison_walk_ops return 1?
>   1. If the poison page still exists, we should of course kill the current
>      process.
>   2. If the poison page does not exist, but is_hwpoison_entry is true, meaning
>      it is a dirty page, we should also kill the current process, too.
>   3. Otherwise, it returns 0, which means the page is clean.

I think you're too deep into detail. What I'd do is step back, think what
would be the *proper* recovery action and then make sure memory_failure does
that. If it doesn't - fix it to do so.

So, what should really happen wrt recovery action if any number of CPUs see
the same memory error?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

