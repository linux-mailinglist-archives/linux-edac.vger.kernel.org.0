Return-Path: <linux-edac+bounces-4635-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A13B301F8
	for <lists+linux-edac@lfdr.de>; Thu, 21 Aug 2025 20:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEA1AE057D
	for <lists+linux-edac@lfdr.de>; Thu, 21 Aug 2025 18:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F80343D98;
	Thu, 21 Aug 2025 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dACeYnc8"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0A2DFA2F
	for <linux-edac@vger.kernel.org>; Thu, 21 Aug 2025 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800645; cv=none; b=L9k70tMdA61s1KcuSYv8XzXlg9ciH6LAA6DimDYOtffERmPFdy0eC8Xms1V5UmTHiTXRV8gqayvx/yzQQW9ePjMwwFxrUUtuyc1jsZZocfsSkNJIua2u/RIhdVDOMs4v4FuRO1m+Vieus6CLgc4mK7lPTvRAoduS4f8OxsqGGCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800645; c=relaxed/simple;
	bh=PcPxhotZ4dmlM/chIJxSdYMAflFmCEQ5m8cSmQZufH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYHRKd3Rrt/JVsMCumPqkvLsQG+RIC4Z3B7vwb/U3QUUnKZCvpKWDX7EsXYKCyQ5oE3uRzUokCZqm4LDV2Aync+bXeKZjjAMlksuA1++n/KJ5vGemcKsXGsXMODIwFFHqh5ebfzNI6n2Of28f7SEIdinq1kIvecAJCk6PYJ58wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dACeYnc8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-459fbc92e69so9225e9.0
        for <linux-edac@vger.kernel.org>; Thu, 21 Aug 2025 11:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755800642; x=1756405442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S05XX1CMKeNm/D4lxTXlGtmP6fs7IzzZWQyQcXhC3KE=;
        b=dACeYnc8nCVK/SAO345I8JCMrrttj5npmW9Tx2amUSSQ0Xa9/obBM6WzHKVV5GQXRN
         miUTHMfXVmDC4nPUDLs9B+do3ZJiCkALClVAuzS5IRoOpzH7a2ByBteR5z3UDNg+Hxfk
         qSKoS4OGgTUaDZi5+JmbV8H1twsS5/RRT3YpjMfgc1Sne9bN32jmTF4I+hXuxOYkKnc/
         vJXvwILFHNi2HkkMLqXA0Sh762fIZtCHlIr9mTJ09H5oaKXg7R0I9E3D9mRc2fEXLHGp
         wp/meosFWiNN5ETO2p5X+eCpgJN2idYbLcOAj+uLitGRoV1SVQMUKlsaYv8NcH2Rh8fg
         insQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755800642; x=1756405442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S05XX1CMKeNm/D4lxTXlGtmP6fs7IzzZWQyQcXhC3KE=;
        b=TpkrUUf3EUzx1eZhlrKBs4xxnhx1I6RGirV75DAmLpGh/KuzWJJnZVEw2Aehp/LyKL
         FbUwXOTVXD2wOAdlJmFmbWjTiADzY4QyTNdrqBZs7YCiJDSWcrBUmcXT/ZmOA+0TTkEG
         zqv6nyCO5JNkgbwt+NeUW72JlmuT6OFscUO+XODzv3ORrhUh2KOhP9oahfPmHY+lrRsX
         V8pikv/W3dJSyL7KAUDbT9jR3A2b1ASXzST/WeoacrraXrrW2M0CKZl/Yt8S8hyRdHc4
         PAAxyJ4V95g78wLo/vr8/w3qVgLDvb+HIMB5Vodf9uKnvbYjzeLaUqjAtB0yKI4F762W
         tFDQ==
X-Forwarded-Encrypted: i=1; AJvYcCURqToF1xkPpGYKztMhIpMKa7u2cyI921WLNC7PxEqYEGOYNOcluupdSQoKr1ObhdMWS3vHwnualOcA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz99ossB0dOAP2aDmQmf3WPH7wFRVeJs15mN51SjNMi7FrvWEM6
	3o3j/gS+xaE7C8BOVJkvUT3XJVNME2bpihyyPqRIFrCjpX/IWfzaqLtZEyeFijteHp3ZBJ3vyBi
	dOPVLLIVMfi51sXNiiQ1W7rAN3DilHWnJgN8BBzpL
X-Gm-Gg: ASbGncsgRdLmIA1cMT1TXMfy+e/GWZnSm0igHi8fyLIL6maRKcWYGLJtIAk7wedvCId
	tEkSaEQcA+Sf2uKXXrcyY6XvTC+b2N2/qKI4GiOHMUuI7Y19YEJ/OjKbnU9NshpHOaYoIpKWJwf
	J/PI63GGfyE4bzbc9nxikqScCWZeT/BRHt2xK35lCU6PKxemIWFhwI0m3NVwiRIQVmnm6QVVJgA
	dSlH/ZgXv6+AGqsaeGjnC+EWxLV7bjPfqB/forQHpA=
X-Google-Smtp-Source: AGHT+IGAJ/WwMySwd32nkeR5X9Y03nD2OKRkLV9ZWlktV4dgbEHfBj/QYGnOAE1hTkrvp2B/i2b6vwUdUdzxGsf66Nc=
X-Received: by 2002:a05:600c:820c:b0:45b:4acd:836d with SMTP id
 5b1f17b1804b1-45b5178cc11mr78945e9.5.1755800641402; Thu, 21 Aug 2025 11:24:01
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821164445.14467-1-kyle.meyer@hpe.com>
In-Reply-To: <20250821164445.14467-1-kyle.meyer@hpe.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 21 Aug 2025 11:23:48 -0700
X-Gm-Features: Ac12FXxIQjlnaJcpKiZifZHaL_GQKCBr-ZXYxrrQp4nBKl4flBBfpBecptv_Ts0
Message-ID: <CACw3F53KmKRJyH+ajicyDUgGbPZT=U3VE4n+Jt3E62BxEiiCGA@mail.gmail.com>
Subject: Re: [PATCH] mm/memory-failure: Do not call action_result() on already
 poisoned pages
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: akpm@linux-foundation.org, david@redhat.com, tony.luck@intel.com, 
	bp@alien8.de, linmiaohe@huawei.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, nao.horiguchi@gmail.com, 
	jane.chu@oracle.com, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:46=E2=80=AFAM Kyle Meyer <kyle.meyer@hpe.com> wro=
te:
>
> Calling action_result() on already poisoned pages causes issues:
>
> * The amount of hardware corrupted memory is incorrectly incremented.
> * NUMA node memory failure statistics are incorrectly updated.
> * Redundant "already poisoned" messages are printed.

All agreed.

>
> Do not call action_result() on already poisoned pages and drop unused
> MF_MSG_ALREADY_POISONED.

Hi Kyle,

Patch looks great to me, just one thought...

Alternatively, have you thought about keeping MF_MSG_ALREADY_POISONED
but changing action_result for MF_MSG_ALREADY_POISONED?
- don't num_poisoned_pages_inc(pfn)
- don't update_per_node_mf_stats(pfn, result)
- still pr_err("%#lx: recovery action for %s: %s\n", ...)
- meanwhile remove "pr_err("%#lx: already hardware poisoned\n", pfn)"
in memory_failure and try_memory_failure_hugetlb

This way, all the MF recovery result kernel logs out will be sitting
in one place, action_result, instead of scattering around all over the
place.

>
> Fixes: b8b9488d50b7 ("mm/memory-failure: improve memory failure action_re=
sult messages")
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
>  include/linux/mm.h      | 1 -
>  include/ras/ras_event.h | 1 -
>  mm/memory-failure.c     | 3 ---
>  3 files changed, 5 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ae97a0b8ec7..09ce81ef7afc 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4005,7 +4005,6 @@ enum mf_action_page_type {
>         MF_MSG_BUDDY,
>         MF_MSG_DAX,
>         MF_MSG_UNSPLIT_THP,
> -       MF_MSG_ALREADY_POISONED,
>         MF_MSG_UNKNOWN,
>  };
>
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index c8cd0f00c845..f62a52f5bd81 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -374,7 +374,6 @@ TRACE_EVENT(aer_event,
>         EM ( MF_MSG_BUDDY, "free buddy page" )                          \
>         EM ( MF_MSG_DAX, "dax page" )                                   \
>         EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )                        \
> -       EM ( MF_MSG_ALREADY_POISONED, "already poisoned" )              \
>         EMe ( MF_MSG_UNKNOWN, "unknown page" )
>
>  /*
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index e2e685b971bb..7839ec83bc1d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -948,7 +948,6 @@ static const char * const action_page_types[] =3D {
>         [MF_MSG_BUDDY]                  =3D "free buddy page",
>         [MF_MSG_DAX]                    =3D "dax page",
>         [MF_MSG_UNSPLIT_THP]            =3D "unsplit thp",
> -       [MF_MSG_ALREADY_POISONED]       =3D "already poisoned",
>         [MF_MSG_UNKNOWN]                =3D "unknown page",
>  };
>
> @@ -2090,7 +2089,6 @@ static int try_memory_failure_hugetlb(unsigned long=
 pfn, int flags, int *hugetlb
>                 if (flags & MF_ACTION_REQUIRED) {
>                         folio =3D page_folio(p);
>                         res =3D kill_accessing_process(current, folio_pfn=
(folio), flags);
> -                       action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FA=
ILED);
>                 }
>                 return res;
>         } else if (res =3D=3D -EBUSY) {
> @@ -2283,7 +2281,6 @@ int memory_failure(unsigned long pfn, int flags)
>                         res =3D kill_accessing_process(current, pfn, flag=
s);
>                 if (flags & MF_COUNT_INCREASED)
>                         put_page(p);
> -               action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>                 goto unlock_mutex;
>         }
>
> --
> 2.50.1
>
>

