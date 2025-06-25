Return-Path: <linux-edac+bounces-4243-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD8FAE8691
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jun 2025 16:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B1C4A6392
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jun 2025 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1460A267714;
	Wed, 25 Jun 2025 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLZcWRah"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948B7263C8E
	for <linux-edac@vger.kernel.org>; Wed, 25 Jun 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862036; cv=none; b=mVpvKgKnNSKaYYxxkzAfTDPGIrXQ3P3oj17lRKSyQXQ4O1fK/UZ3Qju1wkrGsrOyV7szNGorjvDhs6viI3U1j7s8Is1IYbIch27aVPBjsSMWgGdIpGAxBvgsPRwHXFvCOi4tPXT1g3q0GiUrvXt1GekxG2dO2LaW8QY2Kq+vy8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862036; c=relaxed/simple;
	bh=k/9Jmpcevuw9DPLUN7lxWq/HVRKdkSC2nfzszYCDb30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKT/hi1GcyHPqKL0V+t3KKCA7iLK0SZF9mXEcDmLGxrUCNhZScMe0csAxL1MfJyDG/Csn80FG3B9SmVYxyZ1lCkoKMKu1UCtjE8DOaRscoPx6KywB7RByYYXLGZN6wWPtw8s8Fpq8Cc/Jejc6kY8tGjUMMgyXcc+OAu6KmuTk1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLZcWRah; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-237f18108d2so192455ad.0
        for <linux-edac@vger.kernel.org>; Wed, 25 Jun 2025 07:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750862034; x=1751466834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdV48kTp/uRROljNRCynqJ7h0+dKwD9pZid+7Ju9vko=;
        b=FLZcWRahed/cn0x/habzbVuKXmZ8smUrK0DytAimjUAB29yqxoUhuNkSZSeo7lmqoO
         P53EXbq32TNb2FE/dcII/rv8m5wlWMUqK/9UMvfB/jhN3slPF0Akw6gbHqS6li+F6bIU
         3cwRdkH2PtAu/6OoQFOGDxODEZF/m0r/52USX1JlXUxkmyZFMusihN9lYR9d0+7O9V1i
         3doBljxT0RCG9PjDTIppWmVZkGOkx0ute/e1XSaIj36DfYx/RsVuc7uUCAw0Y4TLhr7D
         drAAsgAc7j3YLJEDQQmsE0w6dGyUatd16vZrjNUdbhXAw1Ph1Cgy7gGu1V49qb56hPNl
         KlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750862034; x=1751466834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdV48kTp/uRROljNRCynqJ7h0+dKwD9pZid+7Ju9vko=;
        b=HAUmS8B7bNc5aVnGb/0Z4LAmXD3C/t/3AVAwCmMjk2oE/x70YRUZJCNXhUdLQBQK/I
         GJj0jy1WwjVMc51ZDunTILh/ayYyzG8TpiZWLXfJxi24JPi51cS+FGNgfdQ9q8w19A1b
         2PFq9a3dv1Efpq9M2rgwHTJ+aGE0SQ6+hMmgoD+HoOKjnbhzroQPhfbBy1MYCiozPqHX
         WJFr7ufZLDKIUI0IpI3CDwxFzKc9Cwx6bOQPT1VYo06++Ym4wwvyYucETYPDJ1owDPfV
         8PFlACF955HlE0wt7jCAluBF0muPAhValGnXOlHisG4QqklNVygk7KexNfAIc8NZ/Jfb
         IrLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsBHKzbV3aQbkJyN/KynvQUrIZamwbHy1LwoCMvHbjtG3qE0A/DvzBbaXT+PSLIfJj0pFotHiX0R1H@vger.kernel.org
X-Gm-Message-State: AOJu0Yza42yjjlLV56JDXUEyccgH3tkiOMPhH4gyOb6+P40gmMHVnPHf
	TRqXjCpWe8hyRMOnlVkw785/+/pj2XmWyuNuewx29iBD03ucOtX1QrhDkLLyVCBnhJdjFESKiJc
	kjc+vOaipbWvlaRoAa/Z56y7FgKSaVYYt2+fmD4tL
X-Gm-Gg: ASbGncvKaMy+PIm5+zsLKsJYKfc10wZhfVRaWkUb7RUumdUqUNqO5it0uDPcKIoiI+k
	KDyyudK7oNSc82DcsULIhxWj3RioIG7KwKA67NVD9CGZSYisEnYLJIkky5NKmvKWmQIoJIjg8ji
	M7QzItqiBiLACh9drc2PX05IdKJL1ugvO9pEv2yP4zuA8h7vp0EfKkkKBp9B+bWvd7MXBt4KKX5
	wn2
X-Google-Smtp-Source: AGHT+IHOl4ROtzPHTK+wA3RxqSQB0nXvE1X3o8JvmI/Y5HuW89eI98s0XYuUXqOg4//IZvRW47fajZljsA5Du+i3Zig=
X-Received: by 2002:a17:903:178b:b0:235:f298:cbbb with SMTP id
 d9443c01a7336-23827442ec7mr2061555ad.26.1750862033549; Wed, 25 Jun 2025
 07:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618120806.113884-1-adrian.hunter@intel.com>
 <20250618120806.113884-3-adrian.hunter@intel.com> <68938275-3f6a-46fc-9b38-2c916fdec3d6@intel.com>
In-Reply-To: <68938275-3f6a-46fc-9b38-2c916fdec3d6@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 25 Jun 2025 07:33:41 -0700
X-Gm-Features: AX0GCFtcX4EHPJezVuR03z_zvYB0b1sB8iUGWdlclbBZyL1LJyYQEWzO3JG3LhQ
Message-ID: <CAGtprH_cVwWhfXFkM-=rVzQZ0CpY_zcnkF=q5x1n_9Bzm1xKfw@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: TDX: Do not clear poisoned pages
To: Dave Hansen <dave.hansen@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Tony Luck <tony.luck@intel.com>, pbonzini@redhat.com, 
	seanjc@google.com, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	H Peter Anvin <hpa@zytor.com>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, kai.huang@intel.com, 
	reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@linux.intel.com, 
	isaku.yamahata@intel.com, yan.y.zhao@intel.com, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 7:58=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 6/18/25 05:08, Adrian Hunter wrote:
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> > @@ -282,10 +282,10 @@ static void tdx_clear_page(struct page *page)
> >       void *dest =3D page_to_virt(page);
> >       unsigned long i;
> >
> > -     /*
> > -      * The page could have been poisoned.  MOVDIR64B also clears
> > -      * the poison bit so the kernel can safely use the page again.
> > -      */
> > +     /* Machine check handler may have poisoned the page */
> > +     if (PageHWPoison(page))
> > +             return;

IIUC, even if movdir64b stores contents on hwpoisoned pages, it's not
going to cause any trouble.

This check should be (unlikely(PageHWPoison(page)) and even better
probably should be omitted altogether if there are no side effects of
direct store to hwpoisoned pages.

>
> I think the old comment needs to stay in some form.
>
> There are two kinds of poisons here: One from an integrity mismatch and
> the other because the hardware decided the memory is bad. MOVDIR64B
> clears the integrity one, but not the hardware one obviously.

To ensure I understand correctly, Am I correct in saying: movdir64b
clearing the integrity poison is just hardware clearing the poison
bit, software will still treat that page as poisoned?

>
> Could we make that clear in the comment, please?
>
>

