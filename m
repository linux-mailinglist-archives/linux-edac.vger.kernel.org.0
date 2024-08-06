Return-Path: <linux-edac+bounces-1625-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C389492EC
	for <lists+linux-edac@lfdr.de>; Tue,  6 Aug 2024 16:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37531F25142
	for <lists+linux-edac@lfdr.de>; Tue,  6 Aug 2024 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CE718D64B;
	Tue,  6 Aug 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ebdGmdbB"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2DF17ADE0
	for <linux-edac@vger.kernel.org>; Tue,  6 Aug 2024 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954388; cv=none; b=Hwn8exBgGL7Q92M3QXT/5rBwyGofO8Q/j8Br7zpdkj9HvKOwIlnQV/hDnY991rCmI5DkgBc8elEMzuWKrqfvVxfVzRug77WD/jLpduZrffZxX3aTqfp6Gu7wYrxDNTBhWKYVsOMoGTySjWPKU1IaHd+rNx/6Mb1QoUVRI6txc+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954388; c=relaxed/simple;
	bh=OLlV4kSR07kViA6wYipScsY3O8OsCoan2oV+qxcl1Aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6DI7thUiiB18ZnKBxD38C/r9xebx4fNh+P/pq+AHajjEaheFmsciXCQ8qjIAwTmAKTUtezy7iEj4Bsq60J6n/oidR4KoKXO/20oye6zAgfvYygL+Vv5kmIm9cOLd2Vq4zuTZBbzN3AyZ4ScEh3DSABDuxNH7bTlJGdWDJy+aK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ebdGmdbB; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1722953941;
	bh=OLlV4kSR07kViA6wYipScsY3O8OsCoan2oV+qxcl1Aw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ebdGmdbBSnN94e4Bi03LDyxRfiT12DE8SzkUaOdwyQW4bGTag6f2EZvQV48xjLCSj
	 Ou7boiUkWZ032GzkSOjezxMTc+zj6I0wRs4eH8qCQHkxglpXGuU93oCS65JPUChxHZ
	 QXcWfDWdY/ahi8p10r1amb3NhA5ZrhF0YPlgkoCYC+6skxd9MBZwd+gsM4b6yltbV+
	 NH0Ox510OD32IuBR0a5jtk+g9KlSEQRqTUzK/njU3x6EwOuJGf2PlFfyxiAOwyn1LD
	 iRatzhA+SmhI3aJchDaQAB4agjyHUw3pqzU5BUHma26E5I3LNEZaxY1DsuP17LYCAm
	 WNcijLxZfFXBw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wdb5d45mXz1FZ7;
	Tue,  6 Aug 2024 10:19:01 -0400 (EDT)
Message-ID: <0679fdba-1516-47e6-bd98-ec1ab4fe8a5c@efficios.com>
Date: Tue, 6 Aug 2024 10:19:03 -0400
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH 3/3] rseq: Ensure SIGBUS delivered on memory
 failure
To: Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>
Cc: Andrew Zaborowski <andrew.zaborowski@intel.com>,
 linux-edac@vger.kernel.org, linux-mm@kvack.org,
 Tony Luck <tony.luck@intel.com>, Eric Biederman <ebiederm@xmission.com>,
 Borislav Petkov <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, oleg@redhat.com
References: <20240723144752.1478226-1-andrew.zaborowski@intel.com>
 <20240723144752.1478226-3-andrew.zaborowski@intel.com>
 <202408052136.119CD53B@keescook>
 <20240806075146.GQ39708@noisy.programming.kicks-ass.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240806075146.GQ39708@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-06 03:51, Peter Zijlstra wrote:
> On Mon, Aug 05, 2024 at 09:37:48PM -0700, Kees Cook wrote:
>> On Tue, Jul 23, 2024 at 04:47:52PM +0200, Andrew Zaborowski wrote:
>>> Uncorrected memory errors for user pages are signaled to processes
>>> using SIGBUS or, if the error happens in a syscall, an error retval
>>> from the syscall.  The SIGBUS is documented in
>>> Documentation/mm/hwpoison.rst#failure-recovery-modes
>>>
>>> Once a user task sets t->rseq in the rseq() syscall, if the kernel
>>> cannot access the memory pointed to by t->rseq->rseq_cs, that initial
>>> rseq() and all future syscalls should return an error so understandably
>>> the code just kills the task.
>>>
>>> To ensure that SIGBUS is used set the new t->kill_on_efault flag and
>>> run queued task work on rseq_get_rseq_cs() errors to give memory_failure
>>> the chance to run.
>>>
>>> Note: the rseq checks run inside resume_user_mode_work() so whenever
>>> _TIF_NOTIFY_RESUME is set.  They do not run on every syscall exit so
>>> I'm not concerned that these extra flag operations are in a hot path,
>>> except with CONFIG_DEBUG_RSEQ.
>>>
>>> Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
>>> ---
>>>   kernel/rseq.c | 25 +++++++++++++++++++++----
>>
>> Can an rseq maintainer please review this? I can carry it via the execve
>> tree with the related patches...
> 
> *sigh*,.. because get_maintainers just doesn't work or something?
> 
> Anyway, I'm confused by the signal code (as always), why isn't the
> task_work_run() in get_signal() sufficient?
> 
> At some point we're going to run into trouble with sprinkling
> task_work_run() around willy nilly :/

I agree with Peter: adding explicit calls to task_work_run all over
the kernel does not appear to be an elegant solution.

One thing I am missing is a clear motivation for adding this code:
what is the real-world use-case that benefits from getting this SIGBUS
rather than a SIGSEGV or -EFAULT ?

Also, I feel like we should investigate turning SIGSEGV into SIGBUS
at signal delivery rather than handle this here and there in the kernel
code.

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


