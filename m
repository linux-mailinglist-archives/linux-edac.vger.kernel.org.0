Return-Path: <linux-edac+bounces-4364-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D72B05A6E
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jul 2025 14:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331EE1A6404D
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jul 2025 12:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C2A2E0901;
	Tue, 15 Jul 2025 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ldj1uTFe"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F452E0415;
	Tue, 15 Jul 2025 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583253; cv=none; b=pAqzmw9U+hLQprTTvQRfoBmzS36Hjk0SHDyHQSEeRw/rdHNFC1nX6xCSiH0F4hCG8dA29GdlFoVTlQqqceHKxAP/1alMFOvb2F96KSdWBt+XIGiY52jH7Y6kOAAGaOKrRmBHYEkzH7Gm49Q482YUItzD4PcRAZy1VMEJrX2PQAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583253; c=relaxed/simple;
	bh=TfeoKILN6uGz1OGlxgj30IyoFkYk5lj4H8dBRWQrclQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ennUiPPQpPmtdZPHYENq6L7EVvepJ60i8nbzzhGipubIZ1tGFEN7mNvYWoDTF7NBJm5uc2XoXhN4qJZ+gwt0O39dDHXrtHVGwRxxtv8XmYaErQz/tKB3yeQU1BLY2qoCyWUaUc/BU61iaWRS01kFAJ9UfYtW/8JSn9G2meXbuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ldj1uTFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E64C4CEFC;
	Tue, 15 Jul 2025 12:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752583253;
	bh=TfeoKILN6uGz1OGlxgj30IyoFkYk5lj4H8dBRWQrclQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ldj1uTFeF8vRtelS18jNkjoSIN+J0Dpm3JC9C8F5fhh9n0WLBVYVqmqUQUVjO1vdo
	 UvZgyFgUk//9F9vQZDrK0hk0kvwwOmMnUqTO7w52dz1SDRE8lArgb4v1+vJedgzWls
	 RfDVQvGJJFbXSWn/KX8d/TweuYV71vee0M0cxak+3W4DV7i4yoGPOGfvWX5KwiUlEW
	 qzbFVHik4j6wWDDFkL468tJtQU/xmJqGGYG1LBroafoN387acc9Lb5EJSjx+QuP9eh
	 o5DujpfqbCSYOzkOjOwScai+9ypqlZT/Tir24UTLEReuDDigOZbeOq2RHlb7jrIMtF
	 PPcfgLXKf0Vuw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-615831a3a78so797961eaf.1;
        Tue, 15 Jul 2025 05:40:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjb1b9tdrxWR8PS0ff4QuZ9do04+bPySQUyIkgHHWVc+bmm1879FsKnAAt9AgNyISO93nZsmI0Cdtz@vger.kernel.org, AJvYcCW3NigeA/lwjJ1Td+NqC+OkDJ0MiQR+td0o95zW7Y7kkc5NsTa8ZtPCaRad/OImFpy6dBukRvsoym5pPQ==@vger.kernel.org, AJvYcCWFMaz8gLKL1hSY6uxok42Oa+b7M4EdaQJERoBOl5MCqilqcC1gTOnS89EEv/YMnP/CrwOYSNaWKVBaQB63@vger.kernel.org
X-Gm-Message-State: AOJu0YyYoUiwJuvX0uyQY/LGhg94MVaMj5ezpmNhAUZdL7SPN+zVW70q
	nJOzWxHP0wqNY9G8oigMtqgFrBWwY1Fxsv4cT7H8VJFXFno88kiLyv7di7g44N9+cj78X3+wVMe
	tXvC4GXzKNlFd4BKNRs+wvUg1uzw2ldY=
X-Google-Smtp-Source: AGHT+IE3VFsF0gCgkTbX+pN39J81tOvuuA0nHR7XTTqD3toqPIZXLr17a7eF4UGTVFewKNiMTJbsM+Wk4nshukXwDTo=
X-Received: by 2002:a05:6820:2009:b0:611:f244:dfa5 with SMTP id
 006d021491bc7-613e5eea6d1mr12571655eaf.2.1752583252489; Tue, 15 Jul 2025
 05:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404112050.42040-1-xueshuai@linux.alibaba.com>
 <20250404112050.42040-2-xueshuai@linux.alibaba.com> <0c0bc332-0323-4e43-a96b-dd5f5957ecc9@huawei.com>
 <709ee8d2-8969-424c-b32b-101c6a8220fb@linux.alibaba.com> <353809e7-5373-0d54-6ddb-767bc5af9e5f@huawei.com>
 <653abdd4-46d2-4956-b49c-8f9c309af34d@linux.alibaba.com> <de5d2417-dc92-b276-1125-4feb5151de7f@huawei.com>
 <f60f1128-0d42-48e5-9a06-6ed7ca10767f@linux.alibaba.com> <20250428152350.GA23615@willie-the-truck>
 <6671c3cc-5119-4544-bcb5-17e8cc2d7057@linux.alibaba.com> <CAJZ5v0j3NC2ki1XPXfznxZRBLaReDBJ+nzHFgvqMx5+MgERL-A@mail.gmail.com>
 <3a465782-a8ff-4be8-9c15-e46f39196757@linux.alibaba.com> <CAJZ5v0gfFHCvE2Uu8=GRb9=ueK51s1-0BDBkJbbDG0tQvD5pLA@mail.gmail.com>
 <20250715140530.42c6bdc4@sal.lan>
In-Reply-To: <20250715140530.42c6bdc4@sal.lan>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Jul 2025 14:40:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ikkHeopHQb2Gxr4GnW3rqtowpWu_DEa5ahLK6f2nHH9Q@mail.gmail.com>
X-Gm-Features: Ac12FXwKRYlUaFcGojWqkbjqTj5QJ0Jc1mh4fnplvgyugSBLLnhZkoPPPY9gJ9A
Message-ID: <CAJZ5v0ikkHeopHQb2Gxr4GnW3rqtowpWu_DEa5ahLK6f2nHH9Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 1/2] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>, "Luck, Tony" <tony.luck@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com, 
	ardb@kernel.org, ying.huang@linux.alibaba.com, ashish.kalra@amd.com, 
	baolin.wang@linux.alibaba.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com, 
	robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com, 
	zhuo.song@linux.alibaba.com, sudeep.holla@arm.com, lpieralisi@kernel.org, 
	linux-acpi@vger.kernel.org, yazen.ghannam@amd.com, mark.rutland@arm.com, 
	mingo@redhat.com, robin.murphy@arm.com, Jonathan.Cameron@huawei.com, 
	bp@alien8.de, linux-arm-kernel@lists.infradead.org, 
	wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com, 
	linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com, 
	tongtiangen@huawei.com, gregkh@linuxfoundation.org, jarkko@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 2:06=E2=80=AFPM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Mon, 14 Jul 2025 19:30:19 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> escreveu:
>
> > Hi,
> >
> > On Mon, Jul 14, 2025 at 1:54=E2=80=AFPM Shuai Xue <xueshuai@linux.aliba=
ba.com> wrote:
> > >
> > > =E5=9C=A8 2025/7/1 21:56, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > > > On Tue, Jul 1, 2025 at 1:00=E2=80=AFPM Shuai Xue <xueshuai@linux.al=
ibaba.com> wrote:
> > > >>
> > > >>   >=E5=9C=A8 2025/4/28 23:23, Will Deacon =E5=86=99=E9=81=93:
> > > >>   >> On Fri, Apr 25, 2025 at 09:10:09AM +0800, Shuai Xue wrote:
> > > >>   >>> =E5=9C=A8 2025/4/25 09:00, Hanjun Guo =E5=86=99=E9=81=93:
> > > >>   >>>> Call force_sig(SIGBUS) directly in ghes_do_proc() is not my=
 favourite,
> > > >>   >>>> but I can bear that, please add
> > > >>   >>>>
> > > >>   >>>> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> > > >>   >>>>
> > > >>   >>>> Thanks
> > > >>   >>>> Hanjun
> > > >>   >>>
> > > >>   >>> Thanks. Hanjun.
> > > >>   >>>
> > > >>   >>> @Rafael, @Catalin,
> > > >>   >>>
> > > >>   >>> Both patch 1 and 2 have reviewed-by tag from the arm64 ACPI
> > > >> maintainers, Hanjun,
> > > >>   >>> now. Are you happpy to pick and queue this patch set to acpi=
 tree
> > > >> or arm tree?
> > > >>   >>
> > > >>   >> Since this primarily touches drivers/acpi/apei/ghes.c, I thin=
k it should
> > > >>   >> go via the ACPI tree and not the arm64 one.
> > > >>   >>
> > > >>   >> Will
> > > >>   >
> > > >>   >Hi, Will,
> > > >>   >
> > > >>   >Thank you for your confirmation :)
> > > >>   >
> > > >>   >@Rafael, do you have more comments on this patch set?
> > > >>   >
> > > >>   >Thanks you.
> > > >>   >
> > > >>   >Best Regards,
> > > >>   >Shuai
> > > >>
> > > >> Hi, all,
> > > >>
> > > >> Gentle ping.
> > > >>
> > > >> Does ACPI or APEI tree still active? Looking forward to any respon=
se.
> > > >
> > > > For APEI changes, you need an ACK from one of the reviewers listed =
in
> > > > the MAINTAINERS entry for APEI.
> > > >
> > > > Thanks!
> > >
> > > Hi, Rafael
> > >
> > > Sorry, I missed your email which goes in span (:
> > >
> > > ARM maintain @Catalin points that:
> > >
> > >  > James Morse is listed as reviewer of the ACPI APEI code but he's b=
usy
> > >  > with resctrl/MPAM. Adding Lorenzo, Sudeep and Hanjun as arm64 ACPI
> > >  > maintainers, hopefully they can help.
> > >
> > > And Hanjun explictly gived his Reviewed-by tag in this thread, is tha=
t
> > > happy for you for merge?
> >
> > Not really.
> >
> > I need an ACK or R-by from a reviewer listed in the APEI entry in MAINT=
AINERS.
> >
> > If James Morse is not able to fill that role (and AFAICS he's not been
> > for quite some time now), I'd expect someone else to step up.

Hi Mauro,

> Rafael,
>
> If you want, I can step-up to help with APEI review. Besides my work
> with RAS/EDAC in the past, I'm doing some work those days adding
> APEI injection in QEMU those days (currently focused on ARM error
> injection via SEA and GPIO).

Thank you!

OK, let me send a MAINTAINERS update with a list of new APEI reviewers.

