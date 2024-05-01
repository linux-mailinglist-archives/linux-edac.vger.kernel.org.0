Return-Path: <linux-edac+bounces-990-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F34728B8FE4
	for <lists+linux-edac@lfdr.de>; Wed,  1 May 2024 20:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7CB1F2103A
	for <lists+linux-edac@lfdr.de>; Wed,  1 May 2024 18:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C5812F395;
	Wed,  1 May 2024 18:52:49 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9FE37E
	for <linux-edac@vger.kernel.org>; Wed,  1 May 2024 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714589569; cv=none; b=aa6VBDvh/hQsIHoLLl/SJ6vDPQBPbzPjn6Q3xH/tv1BTNR1JTlzVBijFd/NdH9XemVJOOJky/o/qNvct49Pw6VoS+p8CLBNFBPCYdoTA2sgx1OMRoBI8/rv07PN8trgRGcTX7fStZtiRbCOrSX0ijBAke9byEjlxAxZ5kTZ013o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714589569; c=relaxed/simple;
	bh=2N180M234KK4dXtN8UihWL99eCmKt3nkiijrNw3Y2k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyHxJcJ5vzjsGauSCSSOGxVNT3cqf7GYoQ84dviyxuBL7pD/nSkJKXxoaYkUjD+c5e9Dtn8CrGSUPIt43JWvV6xMd+8pZoiSIeuRT6XeOJxXRPQqOGFwqniwwj6s3PxifLTrhT6bqdOQ/0TpAhXCFDErPB4dAePmo7+M71LFXp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516d68d7a8bso1021036e87.1
        for <linux-edac@vger.kernel.org>; Wed, 01 May 2024 11:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714589565; x=1715194365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ek57wG0+U+e3z9e6S4gM9prC7Z6Q2eW6sLnLC+rZ7BM=;
        b=hWqjzQtEO8KU7rr3imDbHOLwhkgw/YhuBBVJquP7w59oSVyhEoL16nz/F9aQVl/tMd
         mk2uZsuR2w3u/VmPM/wCfxo2/Ms+23F3kbl3LiLoKnJV4R0z6uUjq9x3VEvr6lpfeZQo
         CbjDea16ij1TLF0sVMbnbFqbjtbeLXJXDc4Y5IrC08Z88n4Gs13usLWR7tAAokXkmZer
         d5q4HG+gbkCc9Y8J4kFhuDINLVXsUj94Qzhl7ATOK9TmczMDRkScToOFy27uj1J5qFiU
         qwTtWuYQ9/SpdjihhyJ+mkW3I/VtoKmH1+8HneyvUIq9QqGes8GhTIV7/5b9M8Lpk9eD
         3D8g==
X-Gm-Message-State: AOJu0YyG9or+vyBZpTBRzii5My9DBOSS3w+KvQkMI9E0xhNDX6bEOMU3
	Sn2MFxM9jM4ZbP0nMof9sGULd+d2KDWN12KrGBzlpKqDQ/EA3ZAN/JeF4KeXaq8=
X-Google-Smtp-Source: AGHT+IGMWG+kuKeGo44s9zcIkZFljutpTmOt8s2k2psq7CFj8MlQHTIKG8HjxfG0bHtoKHMn6YT5HA==
X-Received: by 2002:ac2:4d0f:0:b0:51d:72e2:c7dc with SMTP id r15-20020ac24d0f000000b0051d72e2c7dcmr106506lfi.21.1714589564819;
        Wed, 01 May 2024 11:52:44 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id t2-20020a056512068200b0051cc6cd306fsm620490lfe.168.2024.05.01.11.52.44
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 11:52:44 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e1c0588151so1088551fa.0
        for <linux-edac@vger.kernel.org>; Wed, 01 May 2024 11:52:44 -0700 (PDT)
X-Received: by 2002:a05:651c:2229:b0:2dd:44b:d63d with SMTP id
 y41-20020a05651c222900b002dd044bd63dmr141281ljq.12.1714589564025; Wed, 01 May
 2024 11:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501015340.3014724-1-andrew.zaborowski@intel.com>
 <202405010915.465AF19@keescook> <SA1PR11MB69929DBECFE6D8503D214359E7192@SA1PR11MB6992.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB69929DBECFE6D8503D214359E7192@SA1PR11MB6992.namprd11.prod.outlook.com>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Wed, 1 May 2024 20:52:32 +0200
X-Gmail-Original-Message-ID: <CAOq732JjKpeqQze6VpMDTJSvhzjvZCM+HPfdqEp68PSzeW8L3Q@mail.gmail.com>
Message-ID: <CAOq732JjKpeqQze6VpMDTJSvhzjvZCM+HPfdqEp68PSzeW8L3Q@mail.gmail.com>
Subject: Re: [PATCH][RFC] exec: x86: Ensure SIGBUS delivered on MCE
To: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Tony Luck <tony.luck@intel.com>, Eric Biederman <ebiederm@xmission.com>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 May 2024 at 18:19, Kees Cook <keescook@chromium.org> wrote:
> Why is it needed to have a distinction between SIGBUS and SIGSEGV in
> this case?

So this is mostly to comply with
Documentation/mm/hwpoison.rst#failure-recovery-modes.  No doc probably
mentions the execve case but users might expect consistency with the
cases where user memory is accessed from userspace.

In our case it was the parent process that was confused by the SIGSEGV
but it was a validation scenario, not a real use case.

>
> > To ensure it is terminated with a SIGBUS we 1. let pending work run in
> > the bprm_execve error case.
> >
> > And 2. ensure memory_failure() is passed MF_ACTION_REQUIRED so that the
> > SIGBUS is queued.  Normally when the MCE is in a syscall, a fixup of
> > return IP and a call to kill_me_never are enough.  But in this case
> > it's necessary to queue kill_me_maybe() which will set
> > MF_ACTION_REQUIRED.
> >
> > Reuse current->in_execve to make the decision.
>
> We're actually in the process of trying to remove[1] this flag, so I'd
> like to avoid adding new users of it.

Oh, didn't see that.

> It sounds like it's desirable here
> because a choice is needed about kill_me_never() vs kill_me_maybe()?

Ideally it should be based on bprm->point_of_no_return and
current->in_execve matches that closely enough.

Instead bprm_execve could directly send the SIGBUS based on the return
value from the binary loader (which would have to be changed) or a
flag set by the MCE handler but I couldn't see a good way to do that.

Best regards

[I can't set the In-reply-to header correctly for this message, sorry]

