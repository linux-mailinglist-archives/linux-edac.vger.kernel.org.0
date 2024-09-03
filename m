Return-Path: <linux-edac+bounces-1796-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DDD96A3B4
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 18:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED3D1F261C9
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 16:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D551318BB87;
	Tue,  3 Sep 2024 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujGJwoBi"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F5418A6CB;
	Tue,  3 Sep 2024 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379750; cv=none; b=ckPdAYqLK0x01Lp1v0G6vgM636h0V3BcqyQiUvK30vMjR9aSHzWGbQ33rfyvdzJpn7c1PPoEf+ux1wD3hip/3IaM4Ca7knyio9HZ+JZpOrOCw/JM14fYW+OiQQz21pXiCtDKn+tSifOkpkYA7ATku2p0I1olSXLm1fNHbSwQaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379750; c=relaxed/simple;
	bh=2oYWilPB6GddQnusHJpSufcnEcbn+RzWwm5DmozUZ5Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iS8S1hP2YBAN9QBbcv+V/BpwP9oyZUMyPBuf4jQpJ31mIUbdMjB/FEnq/wnvYF705KfifDN7IdJQoME1Sdiua3y75HAC9cJszfAxdxc+39iX96+Y6jzqvAwbPrHgUPmeOO7b3ZsbOr8ZwnEYK/a5AlOFCUW6TGbLCbD7xuHiKkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujGJwoBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95293C4CEC9;
	Tue,  3 Sep 2024 16:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725379750;
	bh=2oYWilPB6GddQnusHJpSufcnEcbn+RzWwm5DmozUZ5Y=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ujGJwoBiOh2tAitzebKvJV818ZPaoPQPGoqDLnRbHBC9DXT4PpN9tWumvGo3t5ihn
	 OKUzwmYInDHw+s1JSfEN9mGM6hGjklGRUyjOroraCZYLV7HJivjXdljn72TI34x1w9
	 rn1br2qKhJ2VlnY1nhQfyi+uRzfy5RZf6lm3H85CvDsX4fGefJaPydF4s3r0luCB2k
	 j5y1XxE2QDmAhogT7Pn1MdOOnOo26OMmxmfyyUkI3LnLq+J50GDjW7bZg3N7o+/L+k
	 DyNUk59BgN9jsvVVvfX/zQC12RXSHTDW8wznhdE4b21z523+iZwNymeTE0sfeQG0dN
	 WuvpuhCHlS5rA==
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Sep 2024 19:09:06 +0300
Message-Id: <D3WS2P2DU0CE.SANBOLMHG6TC@kernel.org>
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
In-Reply-To: <20240902030034.67152-2-xueshuai@linux.alibaba.com>

On Mon Sep 2, 2024 at 6:00 AM EEST, Shuai Xue wrote:
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
> However, no memory_failure() work will be queued unless all bellow
> preconditions check passed:
>
> - `if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))` in ghes_handle_m=
emory_failure()
> - `if (flags =3D=3D -1)` in ghes_handle_memory_failure()
> - `if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))` in ghes_do_memory_f=
ailure()
> - `if (!pfn_valid(pfn) && !arch_is_platform_page(physical_addr)) ` in ghe=
s_do_memory_failure()
>
> In such case, the user-space process will trigger SEA again.  This loop
> can potentially exceed the platform firmware threshold or even trigger a
> kernel hard lockup, leading to a system reboot.
>
> Fix it by performing a force kill if no memory_failure() work is queued
> for synchronous errors.
>
> Suggested-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>
> ---
>  drivers/acpi/apei/ghes.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 623cc0cb4a65..b0b20ee533d9 100644
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
> +		pr_err("Sending SIGBUS to %s:%d due to hardware memory corruption\n",
> +			current->comm, task_pid_nr(current));

Hmm... doest this need "hardware" or would "memory corruption" be
enough?

Also, does this need to say that it is sending SIGBUS when the signal
itself tells that already?

I.e. could "%s:%d has memory corruption" be enough information?

> +		force_sig(SIGBUS);
> +	}
> +
>  	return queued;
>  }
> =20

BR, Jarkko

