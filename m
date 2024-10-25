Return-Path: <linux-edac+bounces-2286-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 931F29B0605
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 16:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65641C21434
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270C220102B;
	Fri, 25 Oct 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsLuE4Yu"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF91FB89A;
	Fri, 25 Oct 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867257; cv=none; b=M/Gy4NtPGO/82MAB5dl8+ZhxOc4hxZJCWuaaMjt4Q4wsC7VCdRwE63dJpbuJQKvqm3BTdfRixuieSQ7cVZLyUW/07Y5RFUt1IXn5xJPeaCjH4U0HUCACT4tSmJ2ZmVNcYlQIRzJmOjOnO7uLXdpCWx5uVUcGkUdAlPVyP9mlBHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867257; c=relaxed/simple;
	bh=dsMthO8Jrb9+1L6ZnDBu1t1OOQmY7jYi7dCIH4VZXdU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LSyyhzggLpzzD3dgSDimIdYxRq6ahFzgNo4A8I+NuPtyQA7UeQnWYJyWmwrbTXxNabqD7mEkRMhJSxRs7kjOBon9wxqkSy9ZkBbHNUDmv8eMzKQg0yNErhxRw4vgvgV96u0gbkYhdxWTL805znLqEHzWUgR1SFe3GKWadqs2PxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsLuE4Yu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79BFC4CEC3;
	Fri, 25 Oct 2024 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729867256;
	bh=dsMthO8Jrb9+1L6ZnDBu1t1OOQmY7jYi7dCIH4VZXdU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=DsLuE4YuLKTOMLwG4QbYcC/9yEVkwhUZJSvX6byCliyWU1yve4qV6bXccnRnvPJjy
	 hQt9TUaaD7vnPRgsNPSzA3knTTqaiRHdpAtWkgBqS3hwh5QYRN+DbjGSEPva2RuCai
	 S6ywofDYDrnJ+cXFONwgAVuS0pjNLNS/pXX0O3fciG6Gin4qYttjqZf49GswGeVLQJ
	 DIrSm19K/gfKrz+D7PFEVz8ZPZnZb4oJYVv2REqZnDHGgzX8ISatwGSkevd3Vz9wDK
	 bZb70FzWq0oht19nQCS1hq2gcSqpV5A+b4J84N48CQCj1MggHe/KcTucXhYFuNf0x+
	 rio8u6IbkoRCQ==
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Oct 2024 17:40:52 +0300
Message-Id: <D54YRGZ47LLS.2BGS3F7T80DF4@kernel.org>
Cc: <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
 <linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
 <ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
 <baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>,
 <dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
 <robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
 <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v14 3/3] ACPI: APEI: handle synchronous exceptions in
 task work
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Shuai Xue" <xueshuai@linux.alibaba.com>, <mark.rutland@arm.com>,
 <catalin.marinas@arm.com>, <mingo@redhat.com>, <robin.murphy@arm.com>,
 <Jonathan.Cameron@Huawei.com>, <bp@alien8.de>, <rafael@kernel.org>,
 <wangkefeng.wang@huawei.com>, <tanxiaofei@huawei.com>,
 <mawupeng1@huawei.com>, <tony.luck@intel.com>, <linmiaohe@huawei.com>,
 <naoya.horiguchi@nec.com>, <james.morse@arm.com>, <tongtiangen@huawei.com>,
 <gregkh@linuxfoundation.org>, <will@kernel.org>
X-Mailer: aerc 0.18.2
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20241014084240.18614-4-xueshuai@linux.alibaba.com>
 <05a8d26b-b023-426f-879c-7d33be4a6406@linux.alibaba.com>
In-Reply-To: <05a8d26b-b023-426f-879c-7d33be4a6406@linux.alibaba.com>

On Tue Oct 22, 2024 at 4:11 AM EEST, Shuai Xue wrote:
> Hi, Jarkko,
>
>
> =E5=9C=A8 2024/10/14 16:42, Shuai Xue =E5=86=99=E9=81=93:
> > The memory uncorrected error could be signaled by asynchronous interrup=
t
> > (specifically, SPI in arm64 platform), e.g. when an error is detected b=
y
> > a background scrubber, or signaled by synchronous exception
> > (specifically, data abort excepction in arm64 platform), e.g. when a CP=
U
> > tries to access a poisoned cache line. Currently, both synchronous and
> > asynchronous error use memory_failure_queue() to schedule
> > memory_failure() exectute in kworker context.
> >=20
> > As a result, when a user-space process is accessing a poisoned data, a
> > data abort is taken and the memory_failure() is executed in the kworker
> > context:
> >=20
> >    - will send wrong si_code by SIGBUS signal in early_kill mode, and
> >    - can not kill the user-space in some cases resulting a synchronous
> >      error infinite loop
> >=20
> > Issue 1: send wrong si_code in early_kill mode
> >=20
> > Since commit a70297d22132 ("ACPI: APEI: set memory failure flags as
> > MF_ACTION_REQUIRED on synchronous events")', the flag MF_ACTION_REQUIRE=
D
> > could be used to determine whether a synchronous exception occurs on
> > ARM64 platform.  When a synchronous exception is detected, the kernel i=
s
> > expected to terminate the current process which has accessed poisoned
> > page. This is done by sending a SIGBUS signal with an error code
> > BUS_MCEERR_AR, indicating an action-required machine check error on
> > read.
> >=20
> > However, when kill_proc() is called to terminate the processes who have
> > the poisoned page mapped, it sends the incorrect SIGBUS error code
> > BUS_MCEERR_AO because the context in which it operates is not the one
> > where the error was triggered.
> >=20
> > To reproduce this problem:
> >=20
> >    #sysctl -w vm.memory_failure_early_kill=3D1
> >    vm.memory_failure_early_kill =3D 1
> >=20
> >    # STEP2: inject an UCE error and consume it to trigger a synchronous=
 error
> >    #einj_mem_uc single
> >    0: single   vaddr =3D 0xffffb0d75400 paddr =3D 4092d55b400
> >    injecting ...
> >    triggering ...
> >    signal 7 code 5 addr 0xffffb0d75000
> >    page not present
> >    Test passed
> >=20
> > The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_A=
O
> > error and it is not fact.
> >=20
> > After this patch:
> >=20
> >    # STEP1: enable early kill mode
> >    #sysctl -w vm.memory_failure_early_kill=3D1
> >    vm.memory_failure_early_kill =3D 1
> >    # STEP2: inject an UCE error and consume it to trigger a synchronous=
 error
> >    #einj_mem_uc single
> >    0: single   vaddr =3D 0xffffb0d75400 paddr =3D 4092d55b400
> >    injecting ...
> >    triggering ...
> >    signal 7 code 4 addr 0xffffb0d75000
> >    page not present
> >    Test passed
> >=20
> > The si_code (code 4) from einj_mem_uc indicates that it is BUS_MCEERR_A=
R
> > error as we expected.
> >=20
> > Issue 2: a synchronous error infinite loop
> >=20
> > If a user-space process, e.g. devmem, a poisoned page which has been se=
t
> > HWPosion flag, kill_accessing_process() is called to send SIGBUS to the
> > current processs with error info. Because the memory_failure() is
> > executed in the kworker contex, it will just do nothing but return
> > EFAULT. So, devmem will access the posioned page and trigger an
> > excepction again, resulting in a synchronous error infinite loop. Such
> > loop may cause platform firmware to exceed some threshold and reboot
> > when Linux could have recovered from this error.
> >=20
> > To reproduce this problem:
> >=20
> >    # STEP 1: inject an UCE error, and kernel will set HWPosion flag for=
 related page
> >    #einj_mem_uc single
> >    0: single   vaddr =3D 0xffffb0d75400 paddr =3D 4092d55b400
> >    injecting ...
> >    triggering ...
> >    signal 7 code 4 addr 0xffffb0d75000
> >    page not present
> >    Test passed
> >=20
> >    # STEP 2: access the same page and it will trigger a synchronous err=
or infinite loop
> >    devmem 0x4092d55b400
> >=20
> > To fix above two issues, queue memory_failure() as a task_work so that =
it runs in
> > the context of the process that is actually consuming the poisoned data=
.
> >=20
> > Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> > Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > ---
> >   drivers/acpi/apei/ghes.c | 78 +++++++++++++++++++++++----------------=
-
> >   include/acpi/ghes.h      |  3 --
> >   include/linux/mm.h       |  1 -
> >   mm/memory-failure.c      | 13 -------
> >   4 files changed, 45 insertions(+), 50 deletions(-)
> >=20
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index f2ee28c44d7a..95e9520eb803 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -467,28 +467,42 @@ static void ghes_clear_estatus(struct ghes *ghes,
> >   }
> >  =20
> >   /*
> > - * Called as task_work before returning to user-space.
> > - * Ensure any queued work has been done before we return to the contex=
t that
> > - * triggered the notification.
> > + * struct ghes_task_work - for synchronous RAS event
> > + *
> > + * @twork:                callback_head for task work
> > + * @pfn:                  page frame number of corrupted page
> > + * @flags:                work control flags
> > + *
> > + * Structure to pass task work to be handled before
> > + * returning to user-space via task_work_add().
> >    */
>
>
> Do you have any futer comments about this patch? Any comments are
> welcomed. If not, are you happy to explictly give the reveiwed-by tag?

Sorry I've been busy switching to a new job.

I read this now through and both commit messages and the code changes
look sane to me so I guess I don't have any problem with that:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

>
> Best Regard,
> Shuai

BR, Jarkko

