Return-Path: <linux-edac+bounces-1903-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D58F997D4DE
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 13:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D476B2365C
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 11:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF0E13D529;
	Fri, 20 Sep 2024 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdWgq8SJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE26D24B4A;
	Fri, 20 Sep 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726832112; cv=none; b=m499YkNCIz7wZVo+kpY9x6116JXY5VGqoBbU/uIZf8QP8+EO7UQ8bZtw5Ew/xuSm/Y7woPAmmxSbqnB4/3xm2iY/9pnucCen+G3o+h0PRBGJIMh+61mJbP06J/KgXjWw9zOFVtQs88FaP5EjQQFlpWaCbvt0L7tTBsnMw8q52Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726832112; c=relaxed/simple;
	bh=zQ5iM5k6GIU+AK5anD56YHmGTiqTiNOqalEcNMllZGo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=F19JqFbd4WvaVNxYJlWxKEAuHGhfVPMGMYL1CHIK4nhdRR6szUxodH9Xzo+G0lHs7HMKa2AJUU+OchB6MU9usA6dRN9J/Okk1sgOHQHqznFNA7XdIibGwOT9MJ1GapknfNQ55uZpTapA0GuzaGrIuuSznMSAGLSOAgLReYTWMpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdWgq8SJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68DBC4CEC3;
	Fri, 20 Sep 2024 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726832111;
	bh=zQ5iM5k6GIU+AK5anD56YHmGTiqTiNOqalEcNMllZGo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=BdWgq8SJ2lfmexGOinqSNJ7KTTER9GBlcMO1r2/mh0d5RvNRQltH0QGldPd83qHqz
	 MAEO0XtNS+tc3F+4ngBm0HC+Ir7xxVhB1HFY+23UH5zRY3w81D70HOt8p2wlKbxfyx
	 y4Mx4h9471GfwaNlK5fxw2BpV6uzeVnk7xPuUBohaE9vJYDmIINz4muvTeg979pqXP
	 adE1/FxhvliYxUSfImsNiuu17FawHKd5MvHJKYtLgzIC7ia+llY9dvr6bkU6GhjUGD
	 144Oww8VP59IcX8tqiZhCussXXNjpN3ifVblloZFdzKZyS8HGbW9bJqhduYC1iThDy
	 zJm/02/kjuFbA==
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Sep 2024 14:35:07 +0300
Message-Id: <D4B2W6MR4585.3IS3HYGQ6GM6O@kernel.org>
Cc: <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
 <linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
 <ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
 <baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>,
 <dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
 <robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
 <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v13 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
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
 <20240920043027.21907-2-xueshuai@linux.alibaba.com>
In-Reply-To: <20240920043027.21907-2-xueshuai@linux.alibaba.com>

On Fri Sep 20, 2024 at 7:30 AM EEST, Shuai Xue wrote:
> Synchronous error was detected as a result of user-space process accessin=
g
> a 2-bit uncorrected error. The CPU will take a synchronous error exceptio=
n
> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue =
a
> memory_failure() work which poisons the related page, unmaps the page, an=
d
> then sends a SIGBUS to the process, so that a system wide panic can be
> avoided.
>
> However, no memory_failure() work will be queued when abnormal synchronou=
s
> errors occur. These errors can include situations such as invalid PA,
> unexpected severity, no memory failure config support, invalid GUID
> section, etc. In such case, the user-space process will trigger SEA again=
.
> This loop can potentially exceed the platform firmware threshold or even
> trigger a kernel hard lockup, leading to a system reboot.
>
> Fix it by performing a force kill if no memory_failure() work is queued
> for synchronous errors.
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/acpi/apei/ghes.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 623cc0cb4a65..93eb11482832 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -801,6 +801,16 @@ static bool ghes_do_proc(struct ghes *ghes,
>  		}
>  	}
> =20
> +	/*
> +	 * If no memory failure work is queued for abnormal synchronous
> +	 * errors, do a force kill.
> +	 */
> +	if (sync && !queued) {
> +		pr_err("%s:%d: hardware memory corruption (SIGBUS)\n",
> +			current->comm, task_pid_nr(current));
> +		force_sig(SIGBUS);
> +	}
> +
>  	return queued;
>  }
> =20

Looks good to me!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

