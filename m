Return-Path: <linux-edac+bounces-4359-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA20B04687
	for <lists+linux-edac@lfdr.de>; Mon, 14 Jul 2025 19:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8011A62DBF
	for <lists+linux-edac@lfdr.de>; Mon, 14 Jul 2025 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E798C262FFE;
	Mon, 14 Jul 2025 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vC3BlaM7"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA361B040D;
	Mon, 14 Jul 2025 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752514232; cv=none; b=IKFEgANuVtIwqFVb8Paz1uuPE2KpLmCfJCG7S/ZLy46ToMVNJCN05/TDjWkLM0lmY3rIislby25IiYGABN4kMyE45rOFub+jjSMpW1IBb6tO4hZlpl/7EmbJtUnZCnup5KRf93aL5nDQuCH9U+cTWw3VEjmfxBR8uGkSyJL4vi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752514232; c=relaxed/simple;
	bh=XewLOYfqb/7YOskJSpnvvo/9VcSLIkCqEbvjb0MSFEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVnqd2/9AUMUvuXEKP67aLZKk+Vhz7hZoGBkEbQ4/6EqMoOZsJ/jlRThnohN5AVwFDXgVWtJb4++exnBjva6B2i4gMKkVUwDf0t8KjUUrNUf6PJ9X4pL60oH1UgJRl4Wi79+04vk4e7JA2viW1HiWfNR8vcFAVpjeafx3tEODPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vC3BlaM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38917C4CEFA;
	Mon, 14 Jul 2025 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752514232;
	bh=XewLOYfqb/7YOskJSpnvvo/9VcSLIkCqEbvjb0MSFEE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vC3BlaM7f2IBlwpaGHoUkbNZRHgzwAXzEFSEpHaDofE+LDrxosQDKvHY4bEU2jJ5V
	 hpD+ePz3X3cBR0VbtM7jCI+5JBSgzFiJVgmwK5FA+/zw4egBN0prmsXN7dpSpRA9bV
	 Sl5841KwT9a0KuLIbDadQvy351QnkIx5ZpQULQ7UM66s9VGBB7JflEsi0cerg2ScCp
	 tMvB0yJygsKorHVdiqXCfK2kSyVefetSPA2OD0d1Kpb6pw7P90B2AsHwYo/kyffPzz
	 HuJzdX2/4RrBW50TgwfjCGyDnXE7h0J8qDwA/xWxphSt3s/nazOYSPscpjFJfda0q8
	 mGvAB0vJ81zfg==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-61590f8fea4so108965eaf.2;
        Mon, 14 Jul 2025 10:30:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9h9m4f86jS8EzWJ0PWily/Im3DtUWNX+DRmErz3mNCDojuRZdWMvOtrNopnnA5eqbNQjyW8lyIZlg@vger.kernel.org, AJvYcCVq83DZtyaSh2sO7gEIrAQBG4RhmsOhdnziNEpBnw10CetHN+gdIrbkU+7pBDVXpwcJlh17e5pXhUKYJw==@vger.kernel.org, AJvYcCWa0kilXghxyMdZF3lvaoMPEWZ+vr125mk7fh54HCsxmPKO24w7HO30HI+bdDa/KLTQWRfEdjz/oN8HHo9n@vger.kernel.org
X-Gm-Message-State: AOJu0YzlyeDVgXv59fL5/e1arPevpA0s2KaR+SU8rGFqr7n/if3sljlK
	K7fGB38HvE7VOh89keuAAiUd1xs5i8s94SCLZQ9tO5Q2NgnXqLLO0yYu+5zHGmrzhdkR1+WwcHH
	SM+YX4oTZaf7V8w1ZVrFgucLDCS/5qw8=
X-Google-Smtp-Source: AGHT+IG4gzTqDxo2kiaKUs9NT7jG7S74R8m7Mf4wFxMthg+jlzsnlgq3c8r8+igPvIkveiZL9WDapKKnPzYucmsi8/0=
X-Received: by 2002:a05:6820:4b0b:b0:611:75a8:f6ca with SMTP id
 006d021491bc7-613e60042aemr9525757eaf.6.1752514231388; Mon, 14 Jul 2025
 10:30:31 -0700 (PDT)
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
 <3a465782-a8ff-4be8-9c15-e46f39196757@linux.alibaba.com>
In-Reply-To: <3a465782-a8ff-4be8-9c15-e46f39196757@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 14 Jul 2025 19:30:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gfFHCvE2Uu8=GRb9=ueK51s1-0BDBkJbbDG0tQvD5pLA@mail.gmail.com>
X-Gm-Features: Ac12FXyg6J3C22EsHHhK7h8dr6Kl_ZD1YWcAXSIJ5XogUO6kfZzV-U7v3B2lVCQ
Message-ID: <CAJZ5v0gfFHCvE2Uu8=GRb9=ueK51s1-0BDBkJbbDG0tQvD5pLA@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 1/2] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	"Luck, Tony" <tony.luck@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, linux-edac@vger.kernel.org, x86@kernel.org, 
	justin.he@arm.com, ardb@kernel.org, ying.huang@linux.alibaba.com, 
	ashish.kalra@amd.com, baolin.wang@linux.alibaba.com, tglx@linutronix.de, 
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

Hi,

On Mon, Jul 14, 2025 at 1:54=E2=80=AFPM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
> =E5=9C=A8 2025/7/1 21:56, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Tue, Jul 1, 2025 at 1:00=E2=80=AFPM Shuai Xue <xueshuai@linux.alibab=
a.com> wrote:
> >>
> >>   >=E5=9C=A8 2025/4/28 23:23, Will Deacon =E5=86=99=E9=81=93:
> >>   >> On Fri, Apr 25, 2025 at 09:10:09AM +0800, Shuai Xue wrote:
> >>   >>> =E5=9C=A8 2025/4/25 09:00, Hanjun Guo =E5=86=99=E9=81=93:
> >>   >>>> Call force_sig(SIGBUS) directly in ghes_do_proc() is not my fav=
ourite,
> >>   >>>> but I can bear that, please add
> >>   >>>>
> >>   >>>> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> >>   >>>>
> >>   >>>> Thanks
> >>   >>>> Hanjun
> >>   >>>
> >>   >>> Thanks. Hanjun.
> >>   >>>
> >>   >>> @Rafael, @Catalin,
> >>   >>>
> >>   >>> Both patch 1 and 2 have reviewed-by tag from the arm64 ACPI
> >> maintainers, Hanjun,
> >>   >>> now. Are you happpy to pick and queue this patch set to acpi tre=
e
> >> or arm tree?
> >>   >>
> >>   >> Since this primarily touches drivers/acpi/apei/ghes.c, I think it=
 should
> >>   >> go via the ACPI tree and not the arm64 one.
> >>   >>
> >>   >> Will
> >>   >
> >>   >Hi, Will,
> >>   >
> >>   >Thank you for your confirmation :)
> >>   >
> >>   >@Rafael, do you have more comments on this patch set?
> >>   >
> >>   >Thanks you.
> >>   >
> >>   >Best Regards,
> >>   >Shuai
> >>
> >> Hi, all,
> >>
> >> Gentle ping.
> >>
> >> Does ACPI or APEI tree still active? Looking forward to any response.
> >
> > For APEI changes, you need an ACK from one of the reviewers listed in
> > the MAINTAINERS entry for APEI.
> >
> > Thanks!
>
> Hi, Rafael
>
> Sorry, I missed your email which goes in span (:
>
> ARM maintain @Catalin points that:
>
>  > James Morse is listed as reviewer of the ACPI APEI code but he's busy
>  > with resctrl/MPAM. Adding Lorenzo, Sudeep and Hanjun as arm64 ACPI
>  > maintainers, hopefully they can help.
>
> And Hanjun explictly gived his Reviewed-by tag in this thread, is that
> happy for you for merge?

Not really.

I need an ACK or R-by from a reviewer listed in the APEI entry in MAINTAINE=
RS.

If James Morse is not able to fill that role (and AFAICS he's not been
for quite some time now), I'd expect someone else to step up.

Thanks!

