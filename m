Return-Path: <linux-edac+bounces-1640-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C7A94DA8B
	for <lists+linux-edac@lfdr.de>; Sat, 10 Aug 2024 05:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140871F24B07
	for <lists+linux-edac@lfdr.de>; Sat, 10 Aug 2024 03:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395011311B5;
	Sat, 10 Aug 2024 03:55:58 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719C153A7
	for <linux-edac@vger.kernel.org>; Sat, 10 Aug 2024 03:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723262158; cv=none; b=kznFin8L4ik/k1llfgskrAEh2MSzm2I9HXpW5hV+35PfHdIVVyYuSEQswXx+4oVoILwkibIf7q71gkLurGQhEhOSDd1P6KodXsRVvoWwzwju49Rhf+bsNiDVyKj8/0xWbb5V0MkgeACX8j0UfIcJ2pLLwj9y0i15hPr+4/aJJBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723262158; c=relaxed/simple;
	bh=V5yZnAjl1NjjkEe/30ZjtXcmWfX2OCqeVUB1xoD8XY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tP4Ic7MDPOiJtHy6AIqUawaygykA/BzAzJ81k8e5d0tv1C5XCbbm5Cpac0lOauty8FSSpYGoPE1xmMDq/zU0eExJ4RfAFU0rjvwZBhbiGJkMpvKfUAme0xzIh0tA1vD1V5k5MmAJNxe11rwgc+prOtWdUgw6wnDloioqw9PzBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-530e2235688so2870662e87.3
        for <linux-edac@vger.kernel.org>; Fri, 09 Aug 2024 20:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723262154; x=1723866954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRu4U78Liz7L9GrLLIkOrIFgbDpdS/BRBdY91q3MGdM=;
        b=ZoR7/YU5+aUmdkgvBPZ+YxdgQ2bA9M4Kmb8WrBlT3cBnxbwPzIm7ww9icfmK1HZS3C
         8Gvwwkc26C4ERtJ0GvVGXY97A4zet2yLALCpeIHndVnrtRvZmV/wSxWcJx5tsUoE7H/9
         WlXaCXMmouPsDe/YqYye9WcH4OAw8Tp1jGGg29dKzvgCUJ166CjVveRslb4HL0x/EQPR
         oiT0S5wFUozhG8+pTWAtJBUIKnnUxMXnWizfFEDiMCq7MyiWIeNWe97hSUgBlklnnC+t
         FoQxbbydtc5BVkB8bnCPSoTlVVufoyfYGcTvAMghJK5OiduVePVDLXd8mjInB7Twr6PK
         l5EA==
X-Gm-Message-State: AOJu0YygM44dXBy2MFZwmNJSxnoOr0zYugG3uBzvjWODwqR8EH9x65V2
	fTs6jzpnYvoiu1qqz9HyTpRPda6BbFUaGcvCROCZGv7otBQ/Vnt8tAy/uKouD04=
X-Google-Smtp-Source: AGHT+IGtahM9buj+E84RoqrpMj+/VDt7fhh7Azzywrg2EMIH16lPCA0ozAEhNZ8GaSIn9z9pPOAG2Q==
X-Received: by 2002:a05:6512:acc:b0:52e:fd84:cec0 with SMTP id 2adb3069b0e04-530eea5a11emr2384433e87.52.1723262153976;
        Fri, 09 Aug 2024 20:55:53 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53200eb4d07sm108304e87.41.2024.08.09.20.55.53
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 20:55:53 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso26835201fa.0
        for <linux-edac@vger.kernel.org>; Fri, 09 Aug 2024 20:55:53 -0700 (PDT)
X-Received: by 2002:a05:651c:79e:b0:2ef:26f2:d3e6 with SMTP id
 38308e7fff4ca-2f1a6d59e8cmr21086211fa.34.1723262152892; Fri, 09 Aug 2024
 20:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723144752.1478226-1-andrew.zaborowski@intel.com>
 <202408052135.342F9455@keescook> <6273D749-9CEC-45E4-8C56-FA3A1DBE1137@alien8.de>
 <SA1PR11MB69926BFE8EFDA7B3C3D84560E7B82@SA1PR11MB6992.namprd11.prod.outlook.com>
 <CAOq732KXwsKdht55E-Z18choiAYn6dMpXc-TD15B7MOUH1fpxQ@mail.gmail.com>
 <20240808145331.GAZrTb60FX_I3p0Ukx@fat_crate.local> <CAOq732JV+zcCqgqTbAtVdE+7jYuen2ioG+F+3i5yaBd7Aj8ANA@mail.gmail.com>
 <20240809083229.GAZrXUHfjgVcHSZPsb@fat_crate.local> <SA1PR11MB69927AE28B46583DCB5C97DEE7BA2@SA1PR11MB6992.namprd11.prod.outlook.com>
 <CAOq732KnHFo3VaRH9V-x0k5m=h1jyNrdtKj4quG8Yaq7wPQjKg@mail.gmail.com> <20240810032134.GAZrbcvpn_cYzFdEwB@fat_crate.local>
In-Reply-To: <20240810032134.GAZrbcvpn_cYzFdEwB@fat_crate.local>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Sat, 10 Aug 2024 05:55:41 +0200
X-Gmail-Original-Message-ID: <CAOq732Ly1r06VedTa2EMb8o_L0+QMgJaVCHdEJFXVs5z7OVRBg@mail.gmail.com>
Message-ID: <CAOq732Ly1r06VedTa2EMb8o_L0+QMgJaVCHdEJFXVs5z7OVRBg@mail.gmail.com>
Subject: Re: [RESEND][PATCH 1/3] x86: Add task_struct flag to force SIGBUS on MCE
To: Borislav Petkov <bp@alien8.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Eric Biederman <ebiederm@xmission.com>, "x86@kernel.org" <x86@kernel.org>, Tony <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Aug 2024 at 05:21, Borislav Petkov <bp@alien8.de> wrote:
> On Sat, Aug 10, 2024 at 03:20:10AM +0200, Andrew Zaborowski wrote:
> > True, though that's hard to link to a specific process crash.
>
> The process name when the MCE gets reported is *actually* there in the
> splat: current->comm.

That's the current process.  The list of processes to be signalled is
determined later and not in a simple way.

>
> > Supporting something generally includes supporting the common and the
> > obscure cases.
>
> Bullshit. We certainly won't support some obscure use cases just
> because.

It's simple reliability, if you support something only sometimes no
one can rely on it.  Without a deep analysis of their kernel code
snapshot at least.

>
> > From the user's point of view the kernel has been committed to
> > supporting these scenarios indefinitely or until the deprecation of
> > the SIGBUS-on-memory-error logic, and simply has a bug.
>
> And lemme repeat my question:
>
> So why does it matter if a process which is being executed and gets an
> MCE beyond the point of no return absolutely needs to return SIGBUS vs
> it getting killed and you still get an MCE logged on the machine, in
> either case?
>
> Bug which is seen by whom or what?

In the case I know of, by the parent process, it's basing some
decision on the signal number and the expected behavior from the
kernel even if not unambiguously documented.

Like I said it can be worked around in userspace, my change doesn't
*enable* the use case.

Best regards

