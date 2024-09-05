Return-Path: <linux-edac+bounces-1820-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2028896DB7D
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2024 16:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6CC28A4EC
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2024 14:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7292F19EEA9;
	Thu,  5 Sep 2024 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R360bgrM"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DFA19E7F8;
	Thu,  5 Sep 2024 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545699; cv=none; b=izZ0CvX9EwFsRRYYbfxLiyM0yQ77xxototlZf+arPwytG372q1SHoJsWcWLQuYZZ9V5WVlBaH1fXZ15kDSp95jn5K1BFV6K1knKHZfEWy17IY7Z4gUeyT/PLaTlJaCoEzukl60vf7zdPynAjiha8+UTZz+hTwisw2VcBix6rq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545699; c=relaxed/simple;
	bh=EsBw3yPNu0bH1zfvQrN4wz32OLkncS3WVmWwvRCuNwM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bulOshCcUMIOMWWU4aHtGLZTZXI4iBZNqau1n+2z7JNEdk8++MoMAaotcL+ED49xpgPNr2IekHWtBwISiCeQRHJH2nMhlPUR5ZEtWgG2TW2nvBhI9/qMk0jZ2SQptoWbEkOs7Ga8AYJs1ZD2s8MZElXGpNaHiLf+/pWx03lBgKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R360bgrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C8EC4CEC5;
	Thu,  5 Sep 2024 14:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725545698;
	bh=EsBw3yPNu0bH1zfvQrN4wz32OLkncS3WVmWwvRCuNwM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=R360bgrMAiS3CivOOjXyUdgY5mo2H3g7KkCXk1zaPYonwTIA037emLJBTORDXoNqW
	 rdDZsAFSOeQ+TrCWcsfJvPZoVhMhP53ytT83TXufLoFiTy2YfH0jPAUuU2iUjZbdQm
	 8jb1lOoaa0FXqu+xjElA9pQllZXxwgETe/9oAn6zJykfdYBX3OflfzeiBOYBh/VEnf
	 bznsvlEMus1xyVUIJjnnTLKF3wNAKTNGFtHetuzxHPQHAXtvDAlKF0WUy+5BZMZMpR
	 HJbOL7ode/W3dVX2CmB3u6A7oukctwEX+1YOXb3KrqVEOxahoaUYYO67+rnPr2DfbY
	 6GdTx2d90tRqw==
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Sep 2024 17:14:54 +0300
Message-Id: <D3YEWCUXEWY3.ALFECJPKZMMG@kernel.org>
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
To: "Shuai Xue" <xueshuai@linux.alibaba.com>, <bp@alien8.de>,
 <rafael@kernel.org>, <wangkefeng.wang@huawei.com>, <tanxiaofei@huawei.com>,
 <mawupeng1@huawei.com>, <tony.luck@intel.com>, <linmiaohe@huawei.com>,
 <naoya.horiguchi@nec.com>, <james.morse@arm.com>, <tongtiangen@huawei.com>,
 <gregkh@linuxfoundation.org>, <will@kernel.org>
X-Mailer: aerc 0.18.2
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240902030034.67152-2-xueshuai@linux.alibaba.com>
 <D3WS2P2DU0CE.SANBOLMHG6TC@kernel.org>
 <bf984773-2a8e-4528-9af1-9775fdc7c4e2@linux.alibaba.com>
In-Reply-To: <bf984773-2a8e-4528-9af1-9775fdc7c4e2@linux.alibaba.com>

On Thu Sep 5, 2024 at 6:04 AM EEST, Shuai Xue wrote:
>
>
> =E5=9C=A8 2024/9/4 00:09, Jarkko Sakkinen =E5=86=99=E9=81=93:
> > On Mon Sep 2, 2024 at 6:00 AM EEST, Shuai Xue wrote:
> >> Synchronous error was detected as a result of user-space process acces=
sing
> >> a 2-bit uncorrected error. The CPU will take a synchronous error excep=
tion
> >> such as Synchronous External Abort (SEA) on Arm64. The kernel will que=
ue a
> >> memory_failure() work which poisons the related page, unmaps the page,=
 and
> >> then sends a SIGBUS to the process, so that a system wide panic can be
> >> avoided.
> >>
> >> However, no memory_failure() work will be queued unless all bellow
> >> preconditions check passed:
> >>
> >> - `if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))` in ghes_handl=
e_memory_failure()
> >> - `if (flags =3D=3D -1)` in ghes_handle_memory_failure()
> >> - `if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))` in ghes_do_memor=
y_failure()
> >> - `if (!pfn_valid(pfn) && !arch_is_platform_page(physical_addr)) ` in =
ghes_do_memory_failure()
> >>
> >> In such case, the user-space process will trigger SEA again.  This loo=
p
> >> can potentially exceed the platform firmware threshold or even trigger=
 a
> >> kernel hard lockup, leading to a system reboot.
> >>
> >> Fix it by performing a force kill if no memory_failure() work is queue=
d
> >> for synchronous errors.
> >>
> >> Suggested-by: Xiaofei Tan <tanxiaofei@huawei.com>
> >> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> >>
> >> ---
> >>   drivers/acpi/apei/ghes.c | 10 ++++++++++
> >>   1 file changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> >> index 623cc0cb4a65..b0b20ee533d9 100644
> >> --- a/drivers/acpi/apei/ghes.c
> >> +++ b/drivers/acpi/apei/ghes.c
> >> @@ -801,6 +801,16 @@ static bool ghes_do_proc(struct ghes *ghes,
> >>   		}
> >>   	}
> >>  =20
> >> +	/*
> >> +	 * If no memory failure work is queued for abnormal synchronous
> >> +	 * errors, do a force kill.
> >> +	 */
> >> +	if (sync && !queued) {
> >> +		pr_err("Sending SIGBUS to %s:%d due to hardware memory corruption\n=
",
> >> +			current->comm, task_pid_nr(current));
> >=20
> > Hmm... doest this need "hardware" or would "memory corruption" be
> > enough?
> >=20
> > Also, does this need to say that it is sending SIGBUS when the signal
> > itself tells that already?
> >=20
> > I.e. could "%s:%d has memory corruption" be enough information?
>
> Hi, Jarkko,
>
> Thank you for your suggestion. Maybe it could.
>
> There are some similar error info which use "hardware memory error", e.g.

By tweaking my original suggestion just a bit:

"%s:%d: hardware memory corruption"

Can't get clearer than that, right?

BR, Jarkko

