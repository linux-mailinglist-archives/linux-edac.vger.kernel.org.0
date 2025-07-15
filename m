Return-Path: <linux-edac+bounces-4363-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E02B05998
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jul 2025 14:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7011C7A495E
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jul 2025 12:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082392DCBF3;
	Tue, 15 Jul 2025 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLOwrxt3"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B218E1F;
	Tue, 15 Jul 2025 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581190; cv=none; b=EL0OBxfoyj6RvTwQJXYxTuQpTYgiw73rIhu20pPDpmOtVD2ztEa8ZzYbA73KSlAzIMY5DvgbopTbb1wOq06NCuzqX0XHQ5RSGC1mb0sIc6hIzHkH8sLYQEymva7UaCFaz8+GNE9Hqan40Mhk6d8tEaxmS+D+Dcwb34f9U5kPlzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581190; c=relaxed/simple;
	bh=SKX8mwbvuYrvzxvuQc2xX0ubBY9BG5T8COQUMdXHRpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5SFYCpBFv+2YVMC731kFxFFZXw1SZwAfXRhOKWENnPNE6T5RHvKNZ2uL+Mh0FyOq8R/FZx9FU7KFD0XbdhF2ktWBnthdcQyfvkrvttpjXiLaMk2Q1RgU61UKfaylWnjpE3nnrs+9yn9jylQ9sf0pl+klteStOaNXeAwG/m9DHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLOwrxt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7195C4CEE3;
	Tue, 15 Jul 2025 12:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752581190;
	bh=SKX8mwbvuYrvzxvuQc2xX0ubBY9BG5T8COQUMdXHRpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aLOwrxt31MYxFG3Kdav0yrmN1YeAvoNS2FBt+FHeDTE2S1jd9VwzmsrBk0/U5+VpG
	 BHBvUpJoiqWnFP0iGdvqb8Dq0aUeCbuNradkN8yfthUsnDTXgOMQyNuIrZUoaFNfQz
	 eUvKpJjtpXgpBKivZ0ecySnNT85pT2nQUsYzhZrHAPvXsn/LzThkw9c5Ow86byQVV9
	 vPQdTQdjsMthMeHHrOAn+EhsuWvw8weiQrf0jPG3frRD6Tnvxfc1v6RlXzxM087pVP
	 PQgu5bkOnsLPBzIU6+ereZVuQbVeSpUljQu1QQOEbYdk03tI0KFXLdDUlV+QWC/6hH
	 8zgcLbJPy3i2A==
Date: Tue, 15 Jul 2025 14:06:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, "Luck, Tony" <tony.luck@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [RESEND PATCH v18 1/2] ACPI: APEI: send SIGBUS to current task
 if synchronous memory error not recovered
Message-ID: <20250715140530.42c6bdc4@sal.lan>
In-Reply-To: <CAJZ5v0gfFHCvE2Uu8=GRb9=ueK51s1-0BDBkJbbDG0tQvD5pLA@mail.gmail.com>
References: <20250404112050.42040-1-xueshuai@linux.alibaba.com>
	<20250404112050.42040-2-xueshuai@linux.alibaba.com>
	<0c0bc332-0323-4e43-a96b-dd5f5957ecc9@huawei.com>
	<709ee8d2-8969-424c-b32b-101c6a8220fb@linux.alibaba.com>
	<353809e7-5373-0d54-6ddb-767bc5af9e5f@huawei.com>
	<653abdd4-46d2-4956-b49c-8f9c309af34d@linux.alibaba.com>
	<de5d2417-dc92-b276-1125-4feb5151de7f@huawei.com>
	<f60f1128-0d42-48e5-9a06-6ed7ca10767f@linux.alibaba.com>
	<20250428152350.GA23615@willie-the-truck>
	<6671c3cc-5119-4544-bcb5-17e8cc2d7057@linux.alibaba.com>
	<CAJZ5v0j3NC2ki1XPXfznxZRBLaReDBJ+nzHFgvqMx5+MgERL-A@mail.gmail.com>
	<3a465782-a8ff-4be8-9c15-e46f39196757@linux.alibaba.com>
	<CAJZ5v0gfFHCvE2Uu8=GRb9=ueK51s1-0BDBkJbbDG0tQvD5pLA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Mon, 14 Jul 2025 19:30:19 +0200
"Rafael J. Wysocki" <rafael@kernel.org> escreveu:

> Hi,
>=20
> On Mon, Jul 14, 2025 at 1:54=E2=80=AFPM Shuai Xue <xueshuai@linux.alibaba=
.com> wrote:
> >
> > =E5=9C=A8 2025/7/1 21:56, Rafael J. Wysocki =E5=86=99=E9=81=93: =20
> > > On Tue, Jul 1, 2025 at 1:00=E2=80=AFPM Shuai Xue <xueshuai@linux.alib=
aba.com> wrote: =20
> > >> =20
> > >>   >=E5=9C=A8 2025/4/28 23:23, Will Deacon =E5=86=99=E9=81=93: =20
> > >>   >> On Fri, Apr 25, 2025 at 09:10:09AM +0800, Shuai Xue wrote: =20
> > >>   >>> =E5=9C=A8 2025/4/25 09:00, Hanjun Guo =E5=86=99=E9=81=93: =20
> > >>   >>>> Call force_sig(SIGBUS) directly in ghes_do_proc() is not my f=
avourite,
> > >>   >>>> but I can bear that, please add
> > >>   >>>>
> > >>   >>>> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> > >>   >>>>
> > >>   >>>> Thanks
> > >>   >>>> Hanjun =20
> > >>   >>>
> > >>   >>> Thanks. Hanjun.
> > >>   >>>
> > >>   >>> @Rafael, @Catalin,
> > >>   >>>
> > >>   >>> Both patch 1 and 2 have reviewed-by tag from the arm64 ACPI =20
> > >> maintainers, Hanjun, =20
> > >>   >>> now. Are you happpy to pick and queue this patch set to acpi t=
ree =20
> > >> or arm tree? =20
> > >>   >>
> > >>   >> Since this primarily touches drivers/acpi/apei/ghes.c, I think =
it should
> > >>   >> go via the ACPI tree and not the arm64 one.
> > >>   >>
> > >>   >> Will =20
> > >>   >
> > >>   >Hi, Will,
> > >>   >
> > >>   >Thank you for your confirmation :)
> > >>   >
> > >>   >@Rafael, do you have more comments on this patch set?
> > >>   >
> > >>   >Thanks you.
> > >>   >
> > >>   >Best Regards,
> > >>   >Shuai =20
> > >>
> > >> Hi, all,
> > >>
> > >> Gentle ping.
> > >>
> > >> Does ACPI or APEI tree still active? Looking forward to any response=
. =20
> > >
> > > For APEI changes, you need an ACK from one of the reviewers listed in
> > > the MAINTAINERS entry for APEI.
> > >
> > > Thanks! =20
> >
> > Hi, Rafael
> >
> > Sorry, I missed your email which goes in span (:
> >
> > ARM maintain @Catalin points that:
> > =20
> >  > James Morse is listed as reviewer of the ACPI APEI code but he's busy
> >  > with resctrl/MPAM. Adding Lorenzo, Sudeep and Hanjun as arm64 ACPI
> >  > maintainers, hopefully they can help. =20
> >
> > And Hanjun explictly gived his Reviewed-by tag in this thread, is that
> > happy for you for merge? =20
>=20
> Not really.
>=20
> I need an ACK or R-by from a reviewer listed in the APEI entry in MAINTAI=
NERS.
>=20
> If James Morse is not able to fill that role (and AFAICS he's not been
> for quite some time now), I'd expect someone else to step up.

Rafael,

If you want, I can step-up to help with APEI review. Besides my work
with RAS/EDAC in the past, I'm doing some work those days adding
APEI injection in QEMU those days (currently focused on ARM error
injection via SEA and GPIO).

Regards,
Mauro

