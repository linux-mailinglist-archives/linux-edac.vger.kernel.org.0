Return-Path: <linux-edac+bounces-2444-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9431A9BD2F9
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2024 17:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3541F23380
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2024 16:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7451DC182;
	Tue,  5 Nov 2024 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwUKbSwb"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A6D1DB940;
	Tue,  5 Nov 2024 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825812; cv=none; b=Pv9UFLdQhrydp+svBQrC/PJDVsnUjXhavfaOmr4/zN9JtwsYdL+EIa69uYzWrPe73lJ5x1nQpFnKV0RrwgUOa8lfWH4UOLipiGIgvbDZSqpEcW6SPxeWSwIyHMHhEcOll6Y6ps0x02NAW14xUVeAheePDWPLwsu1haN7j5tDUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825812; c=relaxed/simple;
	bh=mxXdhn9082V/+eWc2UvTpidq1SQnQuFmuGGmGo46OTk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jx3AWaYmsiDmeoRnfo5yqO6l9l8KQM14sfzRkM+7JAhWni/NONZXimR19mnrRmmKc4p4rFnntLHfN5WKhCe77ynkhF0vhf6BHhiBxMJXSp47nCKy7G9IAqbUA8zofvFpwQ7pojyZbDXgVhpap0aSgZH7Eb3zULRqeZG25JRhqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwUKbSwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80BDC4CECF;
	Tue,  5 Nov 2024 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730825811;
	bh=mxXdhn9082V/+eWc2UvTpidq1SQnQuFmuGGmGo46OTk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=SwUKbSwbPVI5PWUq4M4pSnRYCfeNObfw/7OZuyjT578X7Y710ODIuBAGq2D88aIIp
	 tTdYomg6iGsDc+0YiHMcnF4qKA/jJM7bHgqbhc5QWb/KRxYW2ct91YBUFz8T419RH8
	 tKM1JyxUajmkMsdUtb4v7dD3xPE4MmYhBH0Y1Kmpm2l61FR91luBcGhbrCGFQJV/W1
	 7LcsdWnp3s805zhZehYtsK3IENqXwBoSPyHlo96y/6w6V93qKmBjhc0gx6DSWgHFsA
	 NkOpzmmqz/kyF/TWcWLUwDBPbse3LzzI/qNCzKLTdR49HL15V9E2dhH0TqrsgFhv0m
	 RhmZb690dEkDg==
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Nov 2024 18:56:47 +0200
Message-Id: <D5EEJIV08CS8.267DGCUDZLRR3@kernel.org>
Cc: <mark.rutland@arm.com>, <catalin.marinas@arm.com>, <mingo@redhat.com>,
 <robin.murphy@arm.com>, <Jonathan.Cameron@huawei.com>, <bp@alien8.de>,
 <rafael@kernel.org>, <wangkefeng.wang@huawei.com>, <tanxiaofei@huawei.com>,
 <mawupeng1@huawei.com>, <tony.luck@intel.com>, <linmiaohe@huawei.com>,
 <naoya.horiguchi@nec.com>, <james.morse@arm.com>, <tongtiangen@huawei.com>,
 <gregkh@linuxfoundation.org>, <will@kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
 <linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
 <ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
 <baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>,
 <dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
 <robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
 <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v16 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Yazen Ghannam" <yazen.ghannam@amd.com>, "Shuai Xue"
 <xueshuai@linux.alibaba.com>
X-Mailer: aerc 0.18.2
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20241104015430.98599-2-xueshuai@linux.alibaba.com>
 <20241105150945.GE916505@yaz-khff2.amd.com>
In-Reply-To: <20241105150945.GE916505@yaz-khff2.amd.com>

On Tue Nov 5, 2024 at 5:09 PM EET, Yazen Ghannam wrote:
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index ada93cfde9ba..af3339dd3817 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -801,6 +801,16 @@ static bool ghes_do_proc(struct ghes *ghes,
> >  		}
> >  	}
> > =20
> > +	/*
> > +	 * If no memory failure work is queued for abnormal synchronous
> > +	 * errors, do a force kill.
> > +	 */
> > +	if (sync && !queued) {
> > +		pr_err(HW_ERR GHES_PFX "%s:%d: hardware memory corruption (SIGBUS)\n=
",
>
> Is this always a memory error? The code flow above implies that an
> unrecoverable ARM processor error can all be !queued. So should the
> message be more generic like "synchronous unrecoverable error" or
> similar?
>
> In any case, this is just a minor nit if this is not an issue in
> practice.

One minor thing that came to mind after reading your response: wouldn't
it be a better idea to use dev_err() against ghes->dev, rather than raw
pr_err()?

That would better context information and also I just (re-)checked the
file and also ghes_remove() is using dev_err().

>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>
> Thanks,
> Yazen

BR, Jarkko

