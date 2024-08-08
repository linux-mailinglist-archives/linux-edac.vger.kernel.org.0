Return-Path: <linux-edac+bounces-1627-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D4B94B518
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2024 04:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D77B21D16
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2024 02:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E7DC2F2;
	Thu,  8 Aug 2024 02:33:50 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776B2CA7
	for <linux-edac@vger.kernel.org>; Thu,  8 Aug 2024 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723084430; cv=none; b=J1ZOueVOMrAzQ25qAbn65LrnDqZzEozTbb18DpQgWwpkbDNCNpgBcbVWiByXLA40G5vkp9e21+a9GnoFKAh0mHAEzG/D9mgcRfGW+nUugTGzkiYmNhfCZno7TSuSXZCAs8hCqKipoXSy0dTaYwLVrjn0yPx9HoAmZMD52qYIMh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723084430; c=relaxed/simple;
	bh=AjjIk5IbBHaocaL8wA4nYXnXsVamNc/bSEzEb/ucqT8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Mk19mZl02Bm3JUGv4BXzvcheAfLtjZ3yo1/VVUccHBknGpCEGssB7eRECEwZcBhdp93nHSCcyBvbwsaEaz1l2I0vkqgoC4i9JwU0uTfhGKhq/tDMIrM/65qo8Ehk+sprfkUeFNfJMVJ0bULu2cnNXhXV8cy9A2s/DnW447EpkeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so5224321fa.2
        for <linux-edac@vger.kernel.org>; Wed, 07 Aug 2024 19:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723084424; x=1723689224;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MJLUQioufJPJ3RA5u2LQh0seBEtgswZmfU1+YsbdrOI=;
        b=tnvlHT6M68cXJtAxEiLSsiFVRvvNIYborTIk9mMHS4/xCHMUhMaOMJcQBn+n8jujCK
         GVwcICp/VhjYUCiuG02nJwSSQwH6e9tuVYpy0FtXmEpB303pe8FcFT/Ib6A4AoAcBWPU
         ewOwxBXawqcLdApZPnhj/KKFNmhL0SbC96dQ3V0QUAunFnORLwOE+QxUOjUsdaQh7M6a
         RZZOiCI2vnnV+jVeNlZJdNAA9NoGZc987W2i3Gqk8FvB9PEqeBPo2aJOgXCZ3Wxanb02
         SenS6N/wptvy4qIi6PL4qvEi2O2x2tl5YEog/Gp1UzmR/8yuVmPRsV7CwoQYUFE4TEcR
         Ev5w==
X-Forwarded-Encrypted: i=1; AJvYcCUnhBp+ZB5TGRLnrVvJ0zXkSBShnPyCYwmTYd1uFd7jVNm6TMvxjUwWi0S6TjPrXQSZ4XIpRW1Xo84K@vger.kernel.org
X-Gm-Message-State: AOJu0YwNvuWgO9b3TV5RzZTIgqmR5r8zZhqjQmR55tZU/tbCH1EsIjU3
	qAALwEJxWWq1VQTEwyvxrsYZ54hdMGiLM5jGSjWJzu45jjVIOSa8WD4MzNMEvMJBhw==
X-Google-Smtp-Source: AGHT+IE9AjRSZG+NwdCd+1sYHMI345ufj8nFzxQ9z1qtF6+VkMZ9rD5RLmxFqdeDfOkwN/i99NFsTQ==
X-Received: by 2002:a2e:8057:0:b0:2ef:2f17:9edd with SMTP id 38308e7fff4ca-2f19de8d672mr1859871fa.44.1723084423584;
        Wed, 07 Aug 2024 19:33:43 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e186a5csm20449271fa.20.2024.08.07.19.33.42
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 19:33:42 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so5223901fa.2
        for <linux-edac@vger.kernel.org>; Wed, 07 Aug 2024 19:33:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyncEDMXuiro0qH4yD6CT7/LT+JTBo/d3Qm8zaHCAMqomQa3lTUJ50n8qIOeVwdFaE71Yw3n+PGKcn@vger.kernel.org
X-Received: by 2002:a2e:8057:0:b0:2ef:2f17:9edd with SMTP id
 38308e7fff4ca-2f19de8d672mr1859691fa.44.1723084422441; Wed, 07 Aug 2024
 19:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Thu, 8 Aug 2024 04:33:31 +0200
X-Gmail-Original-Message-ID: <CAOq732+abqDfdKP2M9Kvp6CGEtEEx5Oo5gKh3uXuciLzJq5SFw@mail.gmail.com>
Message-ID: <CAOq732+abqDfdKP2M9Kvp6CGEtEEx5Oo5gKh3uXuciLzJq5SFw@mail.gmail.com>
Subject: Re: [RESEND][PATCH 3/3] rseq: Ensure SIGBUS delivered on memory failure
To: Peter Zijlstra <peterz@infradead.org>, 
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Eric Biederman <ebiederm@xmission.com>, Borislav Petkov <bp@alien8.de>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, "oleg@redhat.com" <oleg@redhat.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"

[Sorry if breaking threading]

Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Aug 05, 2024 at 09:37:48PM -0700, Kees Cook wrote:
> > On Tue, Jul 23, 2024 at 04:47:52PM +0200, Andrew Zaborowski wrote:
> > > Uncorrected memory errors for user pages are signaled to processes
> > > using SIGBUS or, if the error happens in a syscall, an error retval
> > > from the syscall.  The SIGBUS is documented in
> > > Documentation/mm/hwpoison.rst#failure-recovery-modes
> > >
> > > Once a user task sets t->rseq in the rseq() syscall, if the kernel
> > > cannot access the memory pointed to by t->rseq->rseq_cs, that initial
> > > rseq() and all future syscalls should return an error so understandably
> > > the code just kills the task.
> > >
> > > To ensure that SIGBUS is used set the new t->kill_on_efault flag and
> > > run queued task work on rseq_get_rseq_cs() errors to give memory_failure
> > > the chance to run.
> > >
> > > Note: the rseq checks run inside resume_user_mode_work() so whenever
> > > _TIF_NOTIFY_RESUME is set.  They do not run on every syscall exit so
> > > I'm not concerned that these extra flag operations are in a hot path,
> > > except with CONFIG_DEBUG_RSEQ.
> > >
> > > Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
> > > ---
> > >  kernel/rseq.c | 25 +++++++++++++++++++++----
> >
> > Can an rseq maintainer please review this? I can carry it via the execve
> > tree with the related patches...
>
> *sigh*,.. because get_maintainers just doesn't work or something?

Oops, I should have re-run it on the v2.

>
> Anyway, I'm confused by the signal code (as always), why isn't the
> task_work_run() in get_signal() sufficient?

Ok, good point, I only considered the task_work_run() call inside
resume_user_mode_work() which was after the signals were already
delivered.

So the reason it's not sufficient seems to be that, given a SIGSEGV
and a SIGBUS, dequeue_synchronous_signal() returns the one that was
queued first i.e. the SIGSEGV.

dequeue_signal() would have returned the one with lower value, which
would have been the SIGBUS.

>
> At some point we're going to run into trouble with sprinkling
> task_work_run() around willy nilly :/

Right, this isn't ideal.

get_signal has this comment:

/*
 * Signals generated by the execution of an instruction
 * need to be delivered before any other pending signals
 * so that the instruction pointer in the signal stack
 * frame points to the faulting instruction.
 */
...
signr = dequeue_synchronous_signal(&ksig->info);
if (!signr)
    signr = dequeue_signal(current, &current->blocked, &ksig->info, &type);

In this case the two signals will have the same userspace IP.  The
SIGBUS will have a non-NULL .si_addr and is more specific.

I wonder if dequeue_synchronous_signal should have extra logic to
prefer the SIGBUS, or if memory_failure() should try to put the SIGBUS
at the top of current->pending.list.  In any case the code would need
to be careful when doing this and I can't think of the exact
conditions to be checked right now.

Best regards

