Return-Path: <linux-edac+bounces-4637-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85462B30A44
	for <lists+linux-edac@lfdr.de>; Fri, 22 Aug 2025 02:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A613AB417
	for <lists+linux-edac@lfdr.de>; Fri, 22 Aug 2025 00:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1DF4C81;
	Fri, 22 Aug 2025 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2xxZwe7Z"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64EEC2
	for <linux-edac@vger.kernel.org>; Fri, 22 Aug 2025 00:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755822269; cv=none; b=X0xfIazwqRiqFlFvMM5YW5XbLYtXtLdmaNfrNZcy7eykysLRzvZRRlemMl1OnxsCMtA5IOJmKnwjhSN8sjSmr+S6T1l3XnHvEX7Hdc/eN4rK5fumvDcXd7L1Tj9cyKfCBw09Ztlhi8B1wUdp8FM9S0LxCDhxOYL9vLOYgua3OJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755822269; c=relaxed/simple;
	bh=g2H703HIDYfbEY+rrEgFD1cXFrZOynHCF3jxRypLixA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2h2XrvRUbfvO8TfylADw8G8VfjQjNVbZQtqnuj5wq2MhCIVcv8gBxERqmqBouENZIlYASwdtT0QIKKJ6OLjIJIwq7LnkToqAxFp92T75v/0tzTqFjs27LO1hXJDUeoXLoYGkOpCorswfCCycqP4JOXRPNJj6uXNXK5Pxq6+5Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2xxZwe7Z; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-459fbca0c95so33525e9.0
        for <linux-edac@vger.kernel.org>; Thu, 21 Aug 2025 17:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755822266; x=1756427066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCSTC0WIj5wZxnOAo09AXpNhmufPIU9VpSHbeth6h8Y=;
        b=2xxZwe7ZislKSR7aLi63ZpnsP9Hht+Ks9TiilqEpli+mn0yPlTiTYIpRWbPwfpqi8j
         1YPcpDzIZHWdKIU+bhLfvJetvRYgXSJY0vPXC4CTBtXS31kqDccolQYcLUlZZfpjGBW0
         UNriDPngmDKvdwzhZvlBlKB9G8Btm7nYpNQhMhEs5NUUouvBNArVN0BuPNrhnNxt5Hgv
         ysKpd5r+SqMZK8FIxR3akFzDONiz6rKf1SHZRosQEGDZ1GUrqPageLoAZc+V3rmECWi2
         MLCuWX3jn1JNjp5Mw2c1EXWPBbIKVTbpz8WVW4BoaT4PGm3NCQAiu5aC4a1S/MRHBT7d
         ShYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755822266; x=1756427066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCSTC0WIj5wZxnOAo09AXpNhmufPIU9VpSHbeth6h8Y=;
        b=GQycGU20TIwELaeWNqFGu8bM66i/y6uDW/GHVLQ9Q15hxf+84plZOhMxXAvlWbBDfG
         EtAY8CDe8+L1eAL8zuK+KeruTa5wnAIjiWbXzgKfkRf6Q28ERFIfXVkwcVHGrkfrlq40
         xBJ0jGooVCMkXh2HWAALfEhqqJ9lqboD4HItjd1pFiNEh/xMMq1fwQEFfLND6w302Qda
         zZiB8yaF1NM1WvnBrmNa7GsrAeOAw+MBcqtxP+Hu/ROz/SKargf61sX0xZEM9I4gBBbu
         ZWJuNZa2E0xJ+mTETqEYB8zNV5sCzoL6oE72eG44sTT+jxUwthfnCoKOjGsI0GHha/r/
         Li2A==
X-Forwarded-Encrypted: i=1; AJvYcCV6/Qb+eDJpEgksUcxxgALrSnobFB27ww4C855gRvo6YhOlANA1UbfnzhWDrxJ42IM9o5OQ7N4c+vjE@vger.kernel.org
X-Gm-Message-State: AOJu0YwkVMda6D43WlY8bbvm8pdFEc3h6hXoMwuSLfMI1wdeF1U5YcD6
	IHWaMKoN/v9bwsI1HFcEqzZvUZh4S/NYVjofoYryAMFsUWGsoHVwtNvhwSZjDOyb1gpSziVUPXq
	zrGJT17a4MkNNqDXjaZkh1JSrhLxdFMCIamtyhyoC
X-Gm-Gg: ASbGncvfz4TW27K809CmipjlomGv3D+SEUSprLrSW4NDtlXPduoY09LBNjAk0/bxtlf
	QEKEX7Hv4LNcQ6HpVHRYXT6K/kik/yRn3ZcdvvV30b7V4CODhJbJT0MGaoWjRcOPhCvIorA3q/c
	Q4nJxAkHqSZPdbd+tKsVYJYUK19ad2f6CgwAVkKm6IxgigoWZJEGnIsh8x7KwoujZOkWWVtxr4s
	0PvVNq9U1QPnMXB3VKZjeI1DVMDXQOrX76HFmZNFSSt
X-Google-Smtp-Source: AGHT+IGH3NeXHDM/VzClhYP4trwtkdeO3+yJ+kVPFdTAwoZ40UPilU+wF+IASK3XljS4g/6haDSsaWYELnnhb5+t924=
X-Received: by 2002:a05:600c:4b9a:b0:453:65f4:f4c8 with SMTP id
 5b1f17b1804b1-45b52119e54mr240435e9.3.1755822265590; Thu, 21 Aug 2025
 17:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821164445.14467-1-kyle.meyer@hpe.com> <CACw3F53KmKRJyH+ajicyDUgGbPZT=U3VE4n+Jt3E62BxEiiCGA@mail.gmail.com>
 <aKd1K3ueTacGTf1W@hpe.com>
In-Reply-To: <aKd1K3ueTacGTf1W@hpe.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 21 Aug 2025 17:24:13 -0700
X-Gm-Features: Ac12FXxEDY6SrAotIEMY6iY0lvmtqJulbKla6z5zGMm5JvGnSkWnazlZYTp7qjU
Message-ID: <CACw3F527M-x=UeB0tN_sjCgp_YP_8yLkVRCLP2dLO2bzXrqWsA@mail.gmail.com>
Subject: Re: [PATCH] mm/memory-failure: Do not call action_result() on already
 poisoned pages
To: Kyle Meyer <kyle.meyer@hpe.com>, linmiaohe@huawei.com
Cc: akpm@linux-foundation.org, david@redhat.com, tony.luck@intel.com, 
	bp@alien8.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-edac@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, nao.horiguchi@gmail.com, jane.chu@oracle.com, 
	osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 12:36=E2=80=AFPM Kyle Meyer <kyle.meyer@hpe.com> wr=
ote:
>
> On Thu, Aug 21, 2025 at 11:23:48AM -0700, Jiaqi Yan wrote:
> > On Thu, Aug 21, 2025 at 9:46=E2=80=AFAM Kyle Meyer <kyle.meyer@hpe.com>=
 wrote:
> > >
> > > Calling action_result() on already poisoned pages causes issues:
> > >
> > > * The amount of hardware corrupted memory is incorrectly incremented.
> > > * NUMA node memory failure statistics are incorrectly updated.
> > > * Redundant "already poisoned" messages are printed.
> >
> > All agreed.
> >
> > >
> > > Do not call action_result() on already poisoned pages and drop unused
> > > MF_MSG_ALREADY_POISONED.
> >
> > Hi Kyle,
> >
> > Patch looks great to me, just one thought...
> >
> > Alternatively, have you thought about keeping MF_MSG_ALREADY_POISONED
> > but changing action_result for MF_MSG_ALREADY_POISONED?
> > - don't num_poisoned_pages_inc(pfn)
> > - don't update_per_node_mf_stats(pfn, result)
> > - still pr_err("%#lx: recovery action for %s: %s\n", ...)
> > - meanwhile remove "pr_err("%#lx: already hardware poisoned\n", pfn)"
> > in memory_failure and try_memory_failure_hugetlb
>
> I did consider that approach but I was concerned about passing
> MF_MSG_ALREADY_POISONED to action_result() with MF_FAILED. The message is=
 a
> bit misleading.

Based on my reading the documentation for MF_* in static const char
*action_name[]...

Yeah, for file mapped pages, kernel may not have hole-punched or
truncated it from the file mapping (shmem and hugetlbfs for example)
but that still considered as MF_RECOVERED, so touching a page with
HWPoison flag doesn't mean that page was failed to be recovered
previously.

For pages intended to be taken out of the buddy system, touching a
page with HWPoison flag does imply it isn't isolated and hence
MF_FAILED.

In summary, seeing the HWPoison flag again doesn't necessarily
indicate what the recovery result was previously; it only indicate
kernel won't re-attempt to recover?

>
> How about introducing a new MF action result? Maybe MF_NONE? The message =
could
> look something like:

Adding MF_NONE sounds fine to me, as long as we correctly document its
meaning, which can be subtle.

Let's see what Miaohe's thoughts are.

>
> Memory failure: 0xXXXXXXXX: recovery action for already poisoned page: No=
ne
>
> > This way, all the MF recovery result kernel logs out will be sitting
> > in one place, action_result, instead of scattering around all over the
> > place.
>
> That sounds better to me.
>
> > >
> > > Fixes: b8b9488d50b7 ("mm/memory-failure: improve memory failure actio=
n_result messages")
> > > Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> > > ---
> > >  include/linux/mm.h      | 1 -
> > >  include/ras/ras_event.h | 1 -
> > >  mm/memory-failure.c     | 3 ---
> > >  3 files changed, 5 deletions(-)
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 1ae97a0b8ec7..09ce81ef7afc 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -4005,7 +4005,6 @@ enum mf_action_page_type {
> > >         MF_MSG_BUDDY,
> > >         MF_MSG_DAX,
> > >         MF_MSG_UNSPLIT_THP,
> > > -       MF_MSG_ALREADY_POISONED,
> > >         MF_MSG_UNKNOWN,
> > >  };
> > >
> > > diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> > > index c8cd0f00c845..f62a52f5bd81 100644
> > > --- a/include/ras/ras_event.h
> > > +++ b/include/ras/ras_event.h
> > > @@ -374,7 +374,6 @@ TRACE_EVENT(aer_event,
> > >         EM ( MF_MSG_BUDDY, "free buddy page" )                       =
   \
> > >         EM ( MF_MSG_DAX, "dax page" )                                =
   \
> > >         EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )                     =
   \
> > > -       EM ( MF_MSG_ALREADY_POISONED, "already poisoned" )           =
   \
> > >         EMe ( MF_MSG_UNKNOWN, "unknown page" )
> > >
> > >  /*
> > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > index e2e685b971bb..7839ec83bc1d 100644
> > > --- a/mm/memory-failure.c
> > > +++ b/mm/memory-failure.c
> > > @@ -948,7 +948,6 @@ static const char * const action_page_types[] =3D=
 {
> > >         [MF_MSG_BUDDY]                  =3D "free buddy page",
> > >         [MF_MSG_DAX]                    =3D "dax page",
> > >         [MF_MSG_UNSPLIT_THP]            =3D "unsplit thp",
> > > -       [MF_MSG_ALREADY_POISONED]       =3D "already poisoned",
> > >         [MF_MSG_UNKNOWN]                =3D "unknown page",
> > >  };
> > >
> > > @@ -2090,7 +2089,6 @@ static int try_memory_failure_hugetlb(unsigned =
long pfn, int flags, int *hugetlb
> > >                 if (flags & MF_ACTION_REQUIRED) {
> > >                         folio =3D page_folio(p);
> > >                         res =3D kill_accessing_process(current, folio=
_pfn(folio), flags);
> > > -                       action_result(pfn, MF_MSG_ALREADY_POISONED, M=
F_FAILED);
> > >                 }
> > >                 return res;
> > >         } else if (res =3D=3D -EBUSY) {
> > > @@ -2283,7 +2281,6 @@ int memory_failure(unsigned long pfn, int flags=
)
> > >                         res =3D kill_accessing_process(current, pfn, =
flags);
> > >                 if (flags & MF_COUNT_INCREASED)
> > >                         put_page(p);
> > > -               action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED=
);
> > >                 goto unlock_mutex;
> > >         }
> > >
> > > --
> > > 2.50.1
> > >
> > >

