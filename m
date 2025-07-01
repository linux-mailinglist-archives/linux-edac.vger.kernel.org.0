Return-Path: <linux-edac+bounces-4303-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046A1AEFB70
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jul 2025 16:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EB94A5DF2
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jul 2025 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBED27F187;
	Tue,  1 Jul 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahU48zzh"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90B27E7FC;
	Tue,  1 Jul 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378229; cv=none; b=Afbrpv4q2huOnuepVlPlfh3mt9m2l3t0D2cO2zi6FcQnLCBNrP3BUGyWekeHoCqoFEqajqZeJ+wDV25j4cVEtGM7Gqco8ulfpYebe/peIWsretbqs/S+1Si/unUUnDc/m/pP98gztzbsjGi1FIQfgIbUOgHR4EP7uGyAfpX/d3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378229; c=relaxed/simple;
	bh=bfyf64/9Lz8TeBB7ZRQVJI6e73cpzQVKOsse3DwDWRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZuznBmkR8XfmmWI4SZ7dyqWJ/HytVTGGBLqK9XLO4rQDy8xS4jRO64XL9jJHHMbLtlyIi7MLDh1B/X9bRagtWB+xW32IevjbWBeKb7bL/2xHj7fI+MzMsRTLCtmOcfhsSqMGI4HWmxqnVaDSae1CRJtziDnjJU0YHDvWPFAFFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahU48zzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D558C4CEF7;
	Tue,  1 Jul 2025 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751378229;
	bh=bfyf64/9Lz8TeBB7ZRQVJI6e73cpzQVKOsse3DwDWRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ahU48zzhuH3p0zjEEHJCC+eyqLqcVOS6ZGsdCIeneizv3aQAg97P2s3FrQBaEpu/T
	 zc6YioylJbdVu47UwHW6qo6wJ93aZz+E5j/MLruvSvwKVzzRgtiu+4bhm4mOx6a06c
	 n13afKMjPR6sxyjncmIFbIzvBdQcbgj/Zp7Qb2lmlWWu1xL/3ZQeYGtfkcIB3C3HuR
	 REmvCvt4QUcSQ2rJwPKk3CZJVSxp+SrfxLAWXGjn86gF6xll986zDjE4k2e9xzKYJZ
	 g4lAAgQ71DCVPESNVYtMOZyJ9B/Igc9pk8NkaEZGLZTyQjKe8OhxkAvMi4TTsbZ2sX
	 5XwpoS4YiTdwA==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6118c1775dbso1681003eaf.1;
        Tue, 01 Jul 2025 06:57:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnN3znckr+n/FMKKO1StreYa4w05oGe3de2T/lkcOh8KJZRmacvBkUm8QPPWbvFHyCGkXsIXImLvmc@vger.kernel.org, AJvYcCXslInms+M45J32zTtsKd+0FGQm0cOYjm7JB1N9P/cyJhuYfqeJQ/oYX+pmlUGYSZlzJjAy/25waNfH0w==@vger.kernel.org, AJvYcCXsoqwh17eLWjaVhEtNw80L19nBh2XVGv5iL5UL2Cxmd2pVqsw9Fg/QNra/a2QBDcjHX516zDhZ+05t5UYS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt5RVXSzqTrWqavbudZrBfIGuEkFmMh0B8Nmd45gseX1oM8En8
	3rAN5lBMQMS//oajI2AoR/Jw/0eQ/Tk5vioA/SwqT8yv6/SmzSwIKXsPCWHGwFHOay5zomWy6pH
	56ALjP7l4YI7u0xG50iFjgG7PUrAJpZQ=
X-Google-Smtp-Source: AGHT+IH8y5e96zUJRFb1OuI8gvD6XWj6u4OkFPyGcGOEmUKVc6TEctKaRmc0KPqe/ewtdYlc9kWivElDVmZVzHILVRs=
X-Received: by 2002:a4a:ee96:0:b0:605:f34d:7e00 with SMTP id
 006d021491bc7-611b914ca94mr11199187eaf.7.1751378226833; Tue, 01 Jul 2025
 06:57:06 -0700 (PDT)
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
 <6671c3cc-5119-4544-bcb5-17e8cc2d7057@linux.alibaba.com>
In-Reply-To: <6671c3cc-5119-4544-bcb5-17e8cc2d7057@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 1 Jul 2025 15:56:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j3NC2ki1XPXfznxZRBLaReDBJ+nzHFgvqMx5+MgERL-A@mail.gmail.com>
X-Gm-Features: Ac12FXx9H-3vG8ZmZDA8pugDyN2jgQvzGSowL6_ycQvP5EUOr-jzraGGBrVWxV0
Message-ID: <CAJZ5v0j3NC2ki1XPXfznxZRBLaReDBJ+nzHFgvqMx5+MgERL-A@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 1/2] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Will Deacon <will@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, rafael@kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, "Luck, Tony" <tony.luck@intel.com>, linux-mm@kvack.org, 
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

On Tue, Jul 1, 2025 at 1:00=E2=80=AFPM Shuai Xue <xueshuai@linux.alibaba.co=
m> wrote:
>
>  >=E5=9C=A8 2025/4/28 23:23, Will Deacon =E5=86=99=E9=81=93:
>  >> On Fri, Apr 25, 2025 at 09:10:09AM +0800, Shuai Xue wrote:
>  >>> =E5=9C=A8 2025/4/25 09:00, Hanjun Guo =E5=86=99=E9=81=93:
>  >>>> Call force_sig(SIGBUS) directly in ghes_do_proc() is not my favouri=
te,
>  >>>> but I can bear that, please add
>  >>>>
>  >>>> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
>  >>>>
>  >>>> Thanks
>  >>>> Hanjun
>  >>>
>  >>> Thanks. Hanjun.
>  >>>
>  >>> @Rafael, @Catalin,
>  >>>
>  >>> Both patch 1 and 2 have reviewed-by tag from the arm64 ACPI
> maintainers, Hanjun,
>  >>> now. Are you happpy to pick and queue this patch set to acpi tree
> or arm tree?
>  >>
>  >> Since this primarily touches drivers/acpi/apei/ghes.c, I think it sho=
uld
>  >> go via the ACPI tree and not the arm64 one.
>  >>
>  >> Will
>  >
>  >Hi, Will,
>  >
>  >Thank you for your confirmation :)
>  >
>  >@Rafael, do you have more comments on this patch set?
>  >
>  >Thanks you.
>  >
>  >Best Regards,
>  >Shuai
>
> Hi, all,
>
> Gentle ping.
>
> Does ACPI or APEI tree still active? Looking forward to any response.

For APEI changes, you need an ACK from one of the reviewers listed in
the MAINTAINERS entry for APEI.

Thanks!

