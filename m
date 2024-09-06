Return-Path: <linux-edac+bounces-1824-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41E896F721
	for <lists+linux-edac@lfdr.de>; Fri,  6 Sep 2024 16:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6862B1F24FF5
	for <lists+linux-edac@lfdr.de>; Fri,  6 Sep 2024 14:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA73B1D1727;
	Fri,  6 Sep 2024 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZc3U5fZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDFC156880;
	Fri,  6 Sep 2024 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633745; cv=none; b=X5Uz3Nw3HJgjvRSAU9LJZYQME0uScoeaNdCSVpdJ0la1V2ST8Ubd89Ex8a0T0H71RF5ngbPM+IimMhlnwnfzm2Qp0c3QIa6tEQpb8+KqWnS9wKdky53h5PbgGmNe9XWD3Jw/9bi1nofKXehF5VI+rYbvtD1zopXH8ybei/ZTxaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633745; c=relaxed/simple;
	bh=TmcKdTXExCJ2UcE1g4PkpPFg+K6EEGji27f/9N6zwT0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QGr0bzmWfdSTmwuLpyLssStf07X75+li9lFR4aW4LxET/MmQ3fuy329F+eyU8QPX1GFJeJLr0rMstVgrIdik9/YldZdypQBh1gGkAOUnxBaFAYsZJGjabjmzdqB2IyUNB8g0JfpE1tttK3hrspms6iIMVoN3lGSXxTX5IeUaUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZc3U5fZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70578C4CEC4;
	Fri,  6 Sep 2024 14:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725633744;
	bh=TmcKdTXExCJ2UcE1g4PkpPFg+K6EEGji27f/9N6zwT0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=kZc3U5fZf44vXMVSFFrz1bJ9A6votpx8WQajkGxDUSrPlM8OPiv1f6Z5yr9fNl2ij
	 C/+WXsA17kFTHcMX03Y3/PS8eWODt2aFHvgmJbEXdqGVcm9a5q0CmtXYSy0w18/1qY
	 4s6zBZsVVggdBdVUm4EZ8guz3uyv71PT3UJjbu3OB8U+Gkm2CNFdZvdmCf06jsdXwv
	 OBViOamHdL09ScYOdhhMNM6CKWO3auKqPam/oN/XpfAF0hfYLu2DKlmXKL9hTxJiQQ
	 rqnH4044VJVCrImz2XOeny9ykWOxS9e3QQFPKinAYrHXUSXsua65KTOTelz/DYgoSW
	 RLy5712wW+YWQ==
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Sep 2024 17:42:20 +0300
Message-Id: <D3ZA3WBGABKG.1SE9YOAX30B2Y@kernel.org>
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
 <D3YEWCUXEWY3.ALFECJPKZMMG@kernel.org>
 <D3YEYH69KMV4.13SX59Y2HT6D@kernel.org>
 <34d5d58b-7fc2-4f93-9d3b-3051ec5e6a23@linux.alibaba.com>
In-Reply-To: <34d5d58b-7fc2-4f93-9d3b-3051ec5e6a23@linux.alibaba.com>

On Fri Sep 6, 2024 at 4:53 AM EEST, Shuai Xue wrote:
>
>
> =E5=9C=A8 2024/9/5 22:17, Jarkko Sakkinen =E5=86=99=E9=81=93:
> > On Thu Sep 5, 2024 at 5:14 PM EEST, Jarkko Sakkinen wrote:
> >> On Thu Sep 5, 2024 at 6:04 AM EEST, Shuai Xue wrote:
> >>>
> >>>
> >>> =E5=9C=A8 2024/9/4 00:09, Jarkko Sakkinen =E5=86=99=E9=81=93:
> >>>> On Mon Sep 2, 2024 at 6:00 AM EEST, Shuai Xue wrote:
> >>>>> Synchronous error was detected as a result of user-space process ac=
cessing
> >>>>> a 2-bit uncorrected error. The CPU will take a synchronous error ex=
ception
> >>>>> such as Synchronous External Abort (SEA) on Arm64. The kernel will =
queue a
> >>>>> memory_failure() work which poisons the related page, unmaps the pa=
ge, and
> >>>>> then sends a SIGBUS to the process, so that a system wide panic can=
 be
> >>>>> avoided.
> >>>>>
> >>>>> However, no memory_failure() work will be queued unless all bellow
> >>>>> preconditions check passed:
> >>>>>
> >>>>> - `if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))` in ghes_ha=
ndle_memory_failure()
> >>>>> - `if (flags =3D=3D -1)` in ghes_handle_memory_failure()
> >>>>> - `if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))` in ghes_do_me=
mory_failure()
> >>>>> - `if (!pfn_valid(pfn) && !arch_is_platform_page(physical_addr)) ` =
in ghes_do_memory_failure()
> >>>>>
> >>>>> In such case, the user-space process will trigger SEA again.  This =
loop
> >>>>> can potentially exceed the platform firmware threshold or even trig=
ger a
> >>>>> kernel hard lockup, leading to a system reboot.
> >>>>>
> >>>>> Fix it by performing a force kill if no memory_failure() work is qu=
eued
> >>>>> for synchronous errors.
> >>>>>
> >>>>> Suggested-by: Xiaofei Tan <tanxiaofei@huawei.com>
> >>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> >>>>>
> >>>>> ---
> >>>>>    drivers/acpi/apei/ghes.c | 10 ++++++++++
> >>>>>    1 file changed, 10 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> >>>>> index 623cc0cb4a65..b0b20ee533d9 100644
> >>>>> --- a/drivers/acpi/apei/ghes.c
> >>>>> +++ b/drivers/acpi/apei/ghes.c
> >>>>> @@ -801,6 +801,16 @@ static bool ghes_do_proc(struct ghes *ghes,
> >>>>>    		}
> >>>>>    	}
> >>>>>   =20
> >>>>> +	/*
> >>>>> +	 * If no memory failure work is queued for abnormal synchronous
> >>>>> +	 * errors, do a force kill.
> >>>>> +	 */
> >>>>> +	if (sync && !queued) {
> >>>>> +		pr_err("Sending SIGBUS to %s:%d due to hardware memory corruptio=
n\n",
> >>>>> +			current->comm, task_pid_nr(current));
> >>>>
> >>>> Hmm... doest this need "hardware" or would "memory corruption" be
> >>>> enough?
> >>>>
> >>>> Also, does this need to say that it is sending SIGBUS when the signa=
l
> >>>> itself tells that already?
> >>>>
> >>>> I.e. could "%s:%d has memory corruption" be enough information?
> >>>
> >>> Hi, Jarkko,
> >>>
> >>> Thank you for your suggestion. Maybe it could.
> >>>
> >>> There are some similar error info which use "hardware memory error", =
e.g.
> >>
> >> By tweaking my original suggestion just a bit:
> >>
> >> "%s:%d: hardware memory corruption"
> >>
> >> Can't get clearer than that, right?
> >=20
> > And obvious reason that shorter and more consistent klog message is eas=
y
> > to spot and grep. It is simply less convoluted.
> >=20
> > If you want also SIGBUS, I'd just put it as "%s:%d: hardware memory
> > corruption (SIGBUS)"
> >=20
> > BR, Jarkko
>
> Hi, Jarkko,
>
> I will change it to "%s:%d: hardware memory corruption (SIGBUS)".
>
> Thank you for valuable suggestion.

Yeah, no intention nitpick, it has a practical value when debugging
issues :-)

>
> Best Regards,
> Shuai

BR, Jarkko

