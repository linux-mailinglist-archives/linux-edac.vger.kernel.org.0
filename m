Return-Path: <linux-edac+bounces-1638-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33C294D9BC
	for <lists+linux-edac@lfdr.de>; Sat, 10 Aug 2024 03:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C462826D1
	for <lists+linux-edac@lfdr.de>; Sat, 10 Aug 2024 01:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8184138DD6;
	Sat, 10 Aug 2024 01:20:27 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90AB347C7
	for <linux-edac@vger.kernel.org>; Sat, 10 Aug 2024 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723252827; cv=none; b=JgjPvnA6b6QCGFmaCRFgsObJCwj4LiZRloQgLjtRDx3+lBxJEQ/LuFLICxBqOtplbYus1edBS2XlMrLKVg01WHrAHJiuTsoxHyeA+535RXSi1hJKHQym8r8isTrvuJtRhIP3K45mxhysoJXABi4q/AjkI3phyds4FQM/udhhdpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723252827; c=relaxed/simple;
	bh=sZKAqEPRH+3BXKesIUMnjObWxesO/WZHIDe7bFn8I/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ExlhtwZc+X654AlomLghAhpqKNxyaQBXjXqQaHeac3JcjeDCAsJPbXSEqo4KYMXbHdDqIuRldk7ndqwh0mWk/ivtLs0Fp88G3ABnJBqr2yGFaeXxRxhKZX5ECqT5EDApw4utdmdPvBe1zNqudNm18Mfx+d2pU+l6xYAUtp4WtZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-530e062217eso3354812e87.1
        for <linux-edac@vger.kernel.org>; Fri, 09 Aug 2024 18:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723252823; x=1723857623;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=921RZ7c4N2Z6LcTEM1hasybk9CumTC+dT+QKpGhch3o=;
        b=rKnIsZ1W7aQ2h3/2wIZUyJJi3iwYmnCvnEwo3kACxby0KIFVFrCrPS3Bw/V7H1s5qj
         821qy3POJrWqKoDZ9ooRhXdD+uAYjKE4RB+Gec21A98Z9qm14KS8sxbEdR+tcf5ZWlNJ
         5Y6z2UUipiBzt/3NXBhNz8rDhQ1dDGJbBOnMd0h+9JCkYkA6YOJvaI3Fqz5kQHrMbeXL
         OIpZoYchqetdoeVn6/Pf1K5VPbGEejvNZVCMeGjS5pLPyaIYhVrpuxzcl7FBSG6FeXsf
         bB6A9QZbZsekgdx67SCkNsPCrXFStP9+Q7M17Qr/vVLy6t2X/q03BVR1SfN9TUFKZ8cU
         YlIg==
X-Forwarded-Encrypted: i=1; AJvYcCWFk3Ai51jvJ585zv6eC8nnqNBiQgBn9xRAa68KyPwn6UzQ5gTXA2AZUOcwE51i/qDbUJ/oLepd4B2fskG7w2fsK5XX/vib94OMXw==
X-Gm-Message-State: AOJu0YwOn69UJCuV3EiF87UiXFI/J18PIoAgEw/+jYqvE4MzPv198+TM
	UzgWrK4uC/+JYYxQZYEYf2dAjJOUr1bWu/gDyck97pD8aMzkMAhUZdeRua71uXc=
X-Google-Smtp-Source: AGHT+IH+aX/roTEKjrMS5hxgqG8Rb+ot6T/WPLJj2KePabzkfepjy1PtClVlq4ppKMvNOam7H2xwlA==
X-Received: by 2002:a05:6512:ad2:b0:52e:9951:7881 with SMTP id 2adb3069b0e04-530ee9f3d9dmr2488163e87.52.1723252822998;
        Fri, 09 Aug 2024 18:20:22 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53200f1b2b5sm84368e87.217.2024.08.09.18.20.22
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 18:20:22 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f025b94e07so29719501fa.0
        for <linux-edac@vger.kernel.org>; Fri, 09 Aug 2024 18:20:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGBfM0PGi0ztG8DtppciC0P32JLW/rIAfINxUuOlKvW4VDcRn4z464ZEj1AtaeEurXdLrAoEcjVS5ebB5eDiYPdixsakq43RLGvA==
X-Received: by 2002:a2e:b887:0:b0:2f0:1b87:9090 with SMTP id
 38308e7fff4ca-2f1a6c6d3f8mr26956051fa.29.1723252822006; Fri, 09 Aug 2024
 18:20:22 -0700 (PDT)
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
In-Reply-To: <SA1PR11MB69927AE28B46583DCB5C97DEE7BA2@SA1PR11MB6992.namprd11.prod.outlook.com>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Sat, 10 Aug 2024 03:20:10 +0200
X-Gmail-Original-Message-ID: <CAOq732KnHFo3VaRH9V-x0k5m=h1jyNrdtKj4quG8Yaq7wPQjKg@mail.gmail.com>
Message-ID: <CAOq732KnHFo3VaRH9V-x0k5m=h1jyNrdtKj4quG8Yaq7wPQjKg@mail.gmail.com>
Subject: Re: [RESEND][PATCH 1/3] x86: Add task_struct flag to force SIGBUS on MCE
To: Borislav Petkov <bp@alien8.de>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Eric Biederman <ebiederm@xmission.com>, 
	"x86@kernel.org" <x86@kernel.org>, Tony <tony.luck@intel.com>, 
	Andrew Zaborowski <balrogg@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Borislav Petkov <bp@alien8.de> wrote:
> So instead of the process getting killed, you want to return SIGBUS
> because, "hey caller, your process encountered an MCE while being
> attempted to be executed"?

The tests could be changed to expect the SIGSEGV but in this case it
seemed that the test was good and the kernel was misbehaving.  One of
the authors of the MCE handling code confirmed that.

>
> > Qemu relies on the SIGBUS logic but the execve and rseq
> > cases cannot be recovered from, the main benefit of sending the
> > correct signal is perhaps information to the user.
>
> You will have that info in the logs - we're usually very loud when we
> get an MCE...

True, though that's hard to link to a specific process crash.  It's
also hard to extract the page address in the process's address space
from that, although I don't think there's a current use case.

>
> > If this cannot be fixed then optimally it should be documented.
>
> I'm not convinced at all that jumping through hoops you're doing, is
> worth the effort.

That could be, again this could be fixed in the documentation instead.

>
> > As for "all that code", the memory failure handling code is of certain
> > size and this is a comparatively tiny fix for a tiny issue.
>
> No, I didn't say anything about the memory failure code - it is about

I was replying to your comment about the size of the change.

> supporting that obscure use case and the additional logic you're adding
> to the #MC handler which looks like a real mess already and us having to
> support that use case indefinitely.

Supporting something generally includes supporting the common and the
obscure cases.  From the user's point of view the kernel has been
committed to supporting these scenarios indefinitely or until the
deprecation of the SIGBUS-on-memory-error logic, and simply has a bug.

>
> So why does it matter if a process which is being executed and gets an
> MCE beyond the point of no return absolutely needs to return SIGBUS vs
> it getting killed and you still get an MCE logged on the machine, in
> either case?

A SIGSEGV strongly implies a problem with the program being run, not a
specific instance of it.  A SIGBUS could be not the program's fault,
like in this case.

In these tests the workload was simply relaunched on a SIGBUS which
sounded fair to me.  A qemu VM could similarly be restarted on an
unrecoverable MCE in a page that doesn't belong to the VM but to qemu
itself.

Best regards

