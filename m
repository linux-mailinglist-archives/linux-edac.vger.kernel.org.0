Return-Path: <linux-edac+bounces-1626-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF094B3F1
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2024 02:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E771F22B4D
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2024 00:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B23646;
	Thu,  8 Aug 2024 00:02:00 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2EA1DFED
	for <linux-edac@vger.kernel.org>; Thu,  8 Aug 2024 00:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723075320; cv=none; b=koFsMLQaxnDdBY1r9zHzwT7c9Qc23+9dkpFtpD85OR1B+0oZ8V2wheKCXKatYJ2lX7EW13NpjZCW7o88JDVNGu2zmf5Dzp9X6zvauHHHRy0Qqy/xY9aV5iXVw/T9uEMkwNo9K75MyMLcOTATyUUurEKIpmiFmPd/Ot2zJO22jJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723075320; c=relaxed/simple;
	bh=HIosFDDb3xmcdQDHmm4bmSCnJB9EtQP7Sf/EvVktJ/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CjUBPQyLClcmz2XZDyrl7a+heFv2yrLjJInGulEhyQq7vNcE+LMlI6jbf1dvArxBYHlkHvMzOaI/1rfUO6Sqc+GjRffsYTnf46/FGa+AGtLZgHsn/b+9LE9HCkOgPIl72d3xzO/9MbkbLmP3mZiVOE38Rl0jRiWDqJa0PqLa4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f0277daa5so487138e87.0
        for <linux-edac@vger.kernel.org>; Wed, 07 Aug 2024 17:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723075316; x=1723680116;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjKO/GYaKXHmkh3TbLbzKmv/CHSYNDihYf6utfSCgRE=;
        b=Yk9oaua6Ft5JvWUzTLqxfP1AizTwncR/GkVG+Ic+5fPI6gVjw+NaY+zz+wCed2lddx
         tXet3xc48Ns8ynl57PaMmsuOsNUZTXVzXfqqqLauqGkWcsGYoxfP0QXpj4mqsuX3+wZj
         DRJRZlMbfBkWpH3pjkP4DZvmw8lClv/M7hYhXY0pwyjdTB9ByndkjraW/1PthvbFIKS3
         MZnds0gkHlbFh8zHYt0EjemQiSLeWmNKuoj7Lo/McNZrrALn3xlMCVmZfW++UWA3u3u4
         voHLRRIwSEASV13GQ+dW7uwIjPUCdwRhO2Z9ugYaK9ujQ3KmF+YVV5Uwvdmm/B7TPDTF
         r5rw==
X-Forwarded-Encrypted: i=1; AJvYcCU8SZyoCoTcr+lv2FtZqzpfDM3YI8jlKRc9oUF91EnLxjuIyiBOTNHhfEu2Yq+MCuR11M2N+vltRhc998qiWotVn+Y+l+YIkgxqMA==
X-Gm-Message-State: AOJu0YzpLuox+j4Cx3gTudGffeS1Ll0dChxlrqNaicPRMlMyIi6u7TlL
	gcG8DGPXc9VpybnuYizTeFj8Kr2zfV9O599/DpIXdfZjshy3Ek0N7dIM9rOk+QY=
X-Google-Smtp-Source: AGHT+IFXSRt+VqMOe9Fu6OJSE5tNTEXX1U7PzESghV4/YoPErM6IBRuecG35uiSXkSD2WLBmWyt0Og==
X-Received: by 2002:a05:6512:1107:b0:530:e1ee:d95 with SMTP id 2adb3069b0e04-530e5811ba4mr107638e87.1.1723075316084;
        Wed, 07 Aug 2024 17:01:56 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de481f2fsm412625e87.284.2024.08.07.17.01.55
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 17:01:55 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f025b94e07so4154301fa.0
        for <linux-edac@vger.kernel.org>; Wed, 07 Aug 2024 17:01:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwwwA6/DMObnK32vrRw9RZXyV7XBMGC4C14624vOj/0QdyQK37DqaZ74X9FMEdXj2TY3DgMVrXhCRHXlhCoBH00MVlBR64KbDuFA==
X-Received: by 2002:a05:651c:19a0:b0:2ef:2281:2158 with SMTP id
 38308e7fff4ca-2f19de1f84dmr993661fa.1.1723075315433; Wed, 07 Aug 2024
 17:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723144752.1478226-1-andrew.zaborowski@intel.com>
 <202408052135.342F9455@keescook> <6273D749-9CEC-45E4-8C56-FA3A1DBE1137@alien8.de>
 <SA1PR11MB69926BFE8EFDA7B3C3D84560E7B82@SA1PR11MB6992.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB69926BFE8EFDA7B3C3D84560E7B82@SA1PR11MB6992.namprd11.prod.outlook.com>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Thu, 8 Aug 2024 02:01:43 +0200
X-Gmail-Original-Message-ID: <CAOq732KXwsKdht55E-Z18choiAYn6dMpXc-TD15B7MOUH1fpxQ@mail.gmail.com>
Message-ID: <CAOq732KXwsKdht55E-Z18choiAYn6dMpXc-TD15B7MOUH1fpxQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH 1/3] x86: Add task_struct flag to force SIGBUS on MCE
To: Borislav Petkov <bp@alien8.de>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Eric Biederman <ebiederm@xmission.com>, 
	"x86@kernel.org" <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Andrew Zaborowski <balrogg@gmail.com>
Content-Type: text/plain; charset="UTF-8"

[Sorry if I'm breaking threading]

Borislav Petkov <bp@alien8.de> wrote:
> On August 6, 2024 7:36:40 AM GMT+03:00, Kees Cook <kees@kernel.org> wrote:
> >> While not explicitly stated, it can be argued that it
> >> should be a SIGBUS, for consistency and for the benefit of the userspace
> >> signal handlers.  Even if the process cannot handle the signal, perhaps
> >> the parent process can.  This was the case in the scenario that
> >> motivated this patch.
>
> I have no clue what that is trying to tell me.

Documentation/mm/hwpoison.rst#failure-recovery-modes documents the
SIGBUS on memory failure behavior:

       Send SIGBUS when the application runs into the corrupted page.

There may be other docs that specify this behavior but I didn't find
them.  To me this implies that when userspace code directly accesses
poisoned memory it should receive a SIGBUS but not sure if the wording
also implies a SIGBUS on a kernel access on behalf of userspace, i.e.
in a syscall.  Hence why I said "not explicitly stated".

Now I'm not sure it matters.  Logically if a program wants to handle
memory errors, or its parent process wants to know the child was
killed because of a HW problem, it probably doesn't care whether the
page was accessed directly or indirectly so it expects a SIGBUS
always.  Tony Luck also seemed to agree this was the expected behavior
when commenting on this on a different forum.

Best regards

