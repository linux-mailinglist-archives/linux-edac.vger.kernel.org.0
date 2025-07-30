Return-Path: <linux-edac+bounces-4471-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13388B1628A
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jul 2025 16:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EE33A1D81
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jul 2025 14:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9444D2D5C73;
	Wed, 30 Jul 2025 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VmW6n4Ue"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029F02AE84
	for <linux-edac@vger.kernel.org>; Wed, 30 Jul 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885219; cv=none; b=N/2nYt6cM67HHk3g3/w9Efxev82PEmp1naT2JX1xynJxD3XxaVChg4+z5I8O5IZwFXkKk/R3bF21vmrBhAD/7mhLG79xFvdPolZ5BF3bCO9SBzp7t+ReRoKRC0ABQl2QcET3pnzRRR1mwJrflFyC+RSSxtnUprmrXTTzEV6Ricg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885219; c=relaxed/simple;
	bh=zbZ8zJ6FNNzVnMHRaX//DZkRQUevfKQvh7Gz3zKWny8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auF9P4eKGH9wzsu3p8bm2/RSMfBl09ITwn9v93oO7TfXWjdCVmrEK/RbvzqE+OIhE66k68Y4q8M097FSdFZrlyqaYXpaVuUxA7wydnYTeOD5dJgPzL+E9ypeu9z/DJudqVhPZC6FsFqThiI9mvrftVc5JdLHKz0w+v5UIHBFwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VmW6n4Ue; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24070dd87e4so148885ad.0
        for <linux-edac@vger.kernel.org>; Wed, 30 Jul 2025 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753885217; x=1754490017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5+kEdkXghppyQYetmPBQ6sqq9QmR3md7y7HiaGpJ0I=;
        b=VmW6n4UeXMci5ovMEVQwhWyl5xnCpM7Lv/LaJTLJmmHipCgQCHS42yIALS66dV5un0
         lVta1hj2fVzRWhXZ0vYk5w9Zw92EGDs7xA92pGSAFwqajgbnQqwtaA6A3Pn4oQb/i7yU
         l6uich3/CO5E4kOdBIpylGbeIBeRPC2hv+XNAjWKaac3vywdXy1+MJQYaz2DPHzDzTuz
         y06yOkO5jVXpWvCwNR25VdIJpJjqjQMwMM5r4WwNowNyf7bV8+eDEKr3G32NfydM/Hd6
         DxqpnHuRpd38PbtbEenY/BiHdLhgEBsDYQh37vOYdaqjXvQ30CIkp/ntm0FMCLVzFmQb
         +wKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753885217; x=1754490017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5+kEdkXghppyQYetmPBQ6sqq9QmR3md7y7HiaGpJ0I=;
        b=g7oPLo/01KBLc3m7HTSFMPFIrVI5ZGz4zrS7YbkyFNkHobk3ZugN4Hpqbtk1T7uzYQ
         bK8/XLloxoWpASf+BDpxK2VuGKXxA5W7UQg0xnbS4yDDohY9t/H3q5iRe07eK7Dr4Yky
         k1vqAZ2DcPxCcqBMVERTCAx94DE6OsCosfrMPOAVxhpk4BOaeE5xBp9Yo0wsQi+CBide
         vpI45ht7EWWh3XXUDtNEfE5J3yWHYltd1cb+OZF316jRp0PDOSZ+i90lyaCGfS4v5sU8
         3wP184yKCaNEyjCuA5SFv7hffxJtWMYF+GNgX25Kf2eO+AvgiRsy88GfM8YmG2D/sgSu
         DPjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYDCECQfrmTStLT0I9nb7hzG1qXnwKJri2Gl8V9XDkjycwd1YHMO1ze13nUggXW/fBozsxHIrKMHpD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3IEt0MIp7wGlOtIIpfBO3Z7fHN7NyLbstt0wPVNlBMkpaxVAe
	nCdYQw7JR4n64TcrBANpShlikahj9pmtHDRISbex32iOeNS5VpY0wEqGVKqdU1qQeTk2nqEK6bJ
	3vlgjcr8YLvJpxFKLXHuhBDQtJQw0EQFfi/YvKgHf
X-Gm-Gg: ASbGncsjdfOHON66G0WoeDEdCxuRqu7Lj0s3kcaP+jGzsnUM4RcUfWDrR4lUZAw42nM
	LIDRKrDEThqhEoN0MaaOf//CkD+e9ga50LfdEfjjeRpdWbP1MMpRmEtDfhjxGA2CVevE8TcxVBv
	sJ7S80lGWt3P2i7CBpOeM06g5ftn8kzRzwpf+yH05SanRNcmop960BCO+X0D10zH/gkyf/TOXPa
	LMSiW3kRoYdV7CyJ4895ZF+aqJywMZyvxkA0KC0
X-Google-Smtp-Source: AGHT+IGnjBrALMz00bhbW0eE2eYltdA4uM50iHZ54Y4zr/NCz2eT9UCef9cglvhlSULb7QAcPGQ6YPk3ZKf0ScENAHo=
X-Received: by 2002:a17:902:d50c:b0:237:e45b:4f45 with SMTP id
 d9443c01a7336-240a2210339mr3862855ad.1.1753885216823; Wed, 30 Jul 2025
 07:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618120806.113884-1-adrian.hunter@intel.com>
 <20250618120806.113884-2-adrian.hunter@intel.com> <487c5e63-07d3-41ad-bfc0-bda14b3c435e@intel.com>
 <ccee2a0f-18fa-4037-bf97-f359e0791bf6@intel.com> <d443db90-ced5-43d0-9f85-ad436e445c3a@intel.com>
 <9a4752a4-e783-4f03-babf-23c31cee4ff9@intel.com> <SJ1PR11MB60836014330204B2FBCC7418FC45A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <79eca29a-8ba4-4ad9-b2e0-54d8e668f731@intel.com> <807ff02d-7af0-419d-8d14-a4d6c5d5420d@intel.com>
In-Reply-To: <807ff02d-7af0-419d-8d14-a4d6c5d5420d@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 30 Jul 2025 07:20:04 -0700
X-Gm-Features: Ac12FXx-NEErOwD5zsvgMenGyME20wGkcAEBJZMWnCCssNMO3qRavJ35mIpH_0w
Message-ID: <CAGtprH9SpjSnR-u-AH+t6BB+0pzHbgLTUv0pu+dkYR=ZzEYicA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/mce: Fix missing address mask in recovery for
 errors in TDX/SEAM non-root mode
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "Luck, Tony" <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	H Peter Anvin <hpa@zytor.com>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "Huang, Kai" <kai.huang@intel.com>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "Gao, Chao" <chao.gao@intel.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 3:55=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 27/06/2025 19:33, Dave Hansen wrote:
> > On 6/27/25 09:24, Luck, Tony wrote:
> >> We've been sending a combined key+address in the "mce->addr" to
> >> user space for a while. Has anyone built infrastructure on top of that=
?
> >
> > I'm not sure they can do anything useful with an address that has the
> > KeyID in the first place. The partitioning scheme is in an MSR, so
> > they'd need to be doing silly gymnastics to even decode the address.
> >
> > Userspace can deal with the KeyID not being in the address. It's been
> > the default for ages. So, if we take it back out, I'd expect it fixes
> > more things than it breaks.
> >
> > So, yeah, we should carefully consider it. But it still 100% looks like
> > the right thing to me to detangle the KeyID and physical address in the=
 ABI.
>
> Coming back to this after a bit of a break.
>
> It feels unlikely to me that any users are expecting KeyID in mce->addr.
>
> Looking at user space programs like mcelog and rasdaemon, gives the
> impression that mce->addr contains only an address.
>
> The UAPI header file describes addr as "Bank's MCi_ADDR MSR", but what
> mce_read_aux() does tends to contradict that, especially for AMD
> SMCA.
>
> But there are also additional places where it seems like MCI_ADDR_PHYSADD=
R
> is missing:
>
>         tdx_dump_mce_info()
>                 paddr_is_tdx_private()
>                         __seamcall_ret(TDH_PHYMEM_PAGE_RDMD, &args)
>                                 TDH_PHYMEM_PAGE_RDMD expects KeyID bits t=
o be zero
>
>         skx_mce_output_error()
>                 edac_mc_handle_error()
>                         expects page_frame_number, so without KeyID
>
> The KeyID is probably only useful for potentially identifying the TD, but
> given that the TD incurs a FATAL error, that may be obvious anyway.
>
> So removing the KeyID from mce->addr looks like the right thing to do.
>
> Note AFAICT there are 3 kernel APIs that deal with the MCE address:
>
>         Device /dev/mcelog which outputs struct mce
>         Tracepoint mce:mce_record which outputs members from struct mce
>         Tracepoint ras:mc_event where the kernel constructs the address
>         from page_frame_number implying that KeyID should not be present
>
> I guess it would be sensible to ask what customers think.
>
> Vishal, do you know anyone at Google who deals with handling machine
> check information, and who might have an opinion on this?
>

I think it's safe to assume Google hasn't built any infra in the
userspace that needs KeyID bits in the mce address. That being said,
Dave's suggestion to "detangle the KeyID and physical address in the
ABI" makes sense to me.

