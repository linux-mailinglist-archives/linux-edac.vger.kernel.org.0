Return-Path: <linux-edac+bounces-1821-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D14F96DB93
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2024 16:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F35B23CA3
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2024 14:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921C419FA8F;
	Thu,  5 Sep 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYENXWRq"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D8319F123;
	Thu,  5 Sep 2024 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545865; cv=none; b=PyGvCD2/6e0l8IcKWv39dLzjlIWAL0Oobc0hVTVUCJBTj4IeQxtdTY5oqe4mg/puPJnd+thRic6+WKmtaLJMta2CWKzIdMFUs29fqunuYrEZwMFLGmNJGatIXmJjBJGiOgXwe3d0uPnKBT9PANb1wJMKgKRO6YOzX8seBZP8FFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545865; c=relaxed/simple;
	bh=9ObeGGmMmZUQNIKDyBpvXEWmJ0neSXU3BmU9ES+ry00=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sYIlDBmVmcvBSP7OWqCyZEhY8QHcgsXb44AfpNG12K5ieyPUqXmGuwTm7k6csi+ZPLufUs3QthjjN37iyG3aUwEloeQlPdWAEapuxDTSNIjqyQ1NtbLuoPc6RhHERqNc6KtkUvEVYo+r+0PA/3xTX9LyE1uRBlMGDoCX2QgBCvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYENXWRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F66CC4CEC3;
	Thu,  5 Sep 2024 14:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725545864;
	bh=9ObeGGmMmZUQNIKDyBpvXEWmJ0neSXU3BmU9ES+ry00=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=jYENXWRq/s5piuSSClbLNfn9GFyK4cNTB1pV0h/NuSNrs5WGB/QZd94fU1antviwf
	 aoUjZN+asVBX/qvzQfKFoQWXme7Z3PyBLR+1op7KQltt2sWvirJQksblrYbPCNpgY5
	 kXYaFMy2m64KmCZIRGNuMFscNyQXoeciOoOTQQtnkWF5fU7WgQwNLk7Qe+ZZU2ZX0+
	 i8qVFEBpXfTvhMFsPy4xrXlXAGXlCz25fW7aycdWn2N2dzY6EwRjxncUuFQQhzp+X7
	 xfr1vTNQ8FW5YM1ih7KNGLzHa0gS3mbijcLxtm/Di4C6vb98WpFgMsOEQqYlf5Uca2
	 ZF9PgrfFzBebQ==
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Sep 2024 17:17:41 +0300
Message-Id: <D3YEYH69KMV4.13SX59Y2HT6D@kernel.org>
Cc: <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
 <linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
 <ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
 <baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
 <dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
 <robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
 <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v12 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Shuai Xue"
 <xueshuai@linux.alibaba.com>, <bp@alien8.de>, <rafael@kernel.org>,
 <wangkefeng.wang@huawei.com>, <tanxiaofei@huawei.com>,
 <mawupeng1@huawei.com>, <tony.luck@intel.com>, <linmiaohe@huawei.com>,
 <naoya.horiguchi@nec.com>, <james.morse@arm.com>, <tongtiangen@huawei.com>,
 <gregkh@linuxfoundation.org>, <will@kernel.org>
X-Mailer: aerc 0.18.2
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240902030034.67152-2-xueshuai@linux.alibaba.com>
 <D3WS2P2DU0CE.SANBOLMHG6TC@kernel.org>
 <bf984773-2a8e-4528-9af1-9775fdc7c4e2@linux.alibaba.com>
 <D3YEWCUXEWY3.ALFECJPKZMMG@kernel.org>
In-Reply-To: <D3YEWCUXEWY3.ALFECJPKZMMG@kernel.org>

On Thu Sep 5, 2024 at 5:14 PM EEST, Jarkko Sakkinen wrote:
> On Thu Sep 5, 2024 at 6:04 AM EEST, Shuai Xue wrote:
> >
> >
> > =E5=9C=A8 2024/9/4 00:09, Jarkko Sakkinen =E5=86=99=E9=81=93:
> > > On Mon Sep 2, 2024 at 6:00 AM EEST, Shuai Xue wrote:
> > >> Synchronous error was detected as a result of user-space process acc=
essing
> > >> a 2-bit uncorrected error. The CPU will take a synchronous error exc=
eption
> > >> such as Synchronous External Abort (SEA) on Arm64. The kernel will q=
ueue a
> > >> memory_failure() work which poisons the related page, unmaps the pag=
e, and
> > >> then sends a SIGBUS to the process, so that a system wide panic can =
be
> > >> avoided.
> > >>
> > >> However, no memory_failure() work will be queued unless all bellow
> > >> preconditions check passed:
> > >>
> > >> - `if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))` in ghes_han=
dle_memory_failure()
> > >> - `if (flags =3D=3D -1)` in ghes_handle_memory_failure()
> > >> - `if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))` in ghes_do_mem=
ory_failure()
> > >> - `if (!pfn_valid(pfn) && !arch_is_platform_page(physical_addr)) ` i=
n ghes_do_memory_failure()
> > >>
> > >> In such case, the user-space process will trigger SEA again.  This l=
oop
> > >> can potentially exceed the platform firmware threshold or even trigg=
er a
> > >> kernel hard lockup, leading to a system reboot.
> > >>
> > >> Fix it by performing a force kill if no memory_failure() work is que=
ued
> > >> for synchronous errors.
> > >>
> > >> Suggested-by: Xiaofei Tan <tanxiaofei@huawei.com>
> > >> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > >>
> > >> ---
> > >>   drivers/acpi/apei/ghes.c | 10 ++++++++++
> > >>   1 file changed, 10 insertions(+)
> > >>
> > >> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > >> index 623cc0cb4a65..b0b20ee533d9 100644
> > >> --- a/drivers/acpi/apei/ghes.c
> > >> +++ b/drivers/acpi/apei/ghes.c
> > >> @@ -801,6 +801,16 @@ static bool ghes_do_proc(struct ghes *ghes,
> > >>   		}
> > >>   	}
> > >>  =20
> > >> +	/*
> > >> +	 * If no memory failure work is queued for abnormal synchronous
> > >> +	 * errors, do a force kill.
> > >> +	 */
> > >> +	if (sync && !queued) {
> > >> +		pr_err("Sending SIGBUS to %s:%d due to hardware memory corruption=
\n",
> > >> +			current->comm, task_pid_nr(current));
> > >=20
> > > Hmm... doest this need "hardware" or would "memory corruption" be
> > > enough?
> > >=20
> > > Also, does this need to say that it is sending SIGBUS when the signal
> > > itself tells that already?
> > >=20
> > > I.e. could "%s:%d has memory corruption" be enough information?
> >
> > Hi, Jarkko,
> >
> > Thank you for your suggestion. Maybe it could.
> >
> > There are some similar error info which use "hardware memory error", e.=
g.
>
> By tweaking my original suggestion just a bit:
>
> "%s:%d: hardware memory corruption"
>
> Can't get clearer than that, right?

And obvious reason that shorter and more consistent klog message is easy
to spot and grep. It is simply less convoluted.

If you want also SIGBUS, I'd just put it as "%s:%d: hardware memory
corruption (SIGBUS)"

BR, Jarkko

