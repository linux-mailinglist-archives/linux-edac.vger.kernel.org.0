Return-Path: <linux-edac+bounces-5611-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EB9D03C9A
	for <lists+linux-edac@lfdr.de>; Thu, 08 Jan 2026 16:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C2563014126
	for <lists+linux-edac@lfdr.de>; Thu,  8 Jan 2026 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB274984BF;
	Thu,  8 Jan 2026 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ5Uf2k3"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8470B4A1E09
	for <linux-edac@vger.kernel.org>; Thu,  8 Jan 2026 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874150; cv=none; b=E3UoSBWM7/k5SISHi03lAsfrgFEjmuoYCTqvqpmr8ZuBux7H0f0glgZFka972tT2pyllaPxGCbZmq6wtjhViAtpsBD5KQSvfOFESoQt208vugkE7fKnl38UgYFkzUcYsAt4/n/QUSeZmzX0pCv8cv8p4xOUOCuOE0+6O+SYmZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874150; c=relaxed/simple;
	bh=IlkapupCVg4ayKuGBWjBIEEBZdPH2VQahkQRg+CWzI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHFxrFnHv25/ZhNNY+i3FVCxKlh/Ccuk5GMyVuhoONj6ZaB1yQxyyd8fEdkCyZPmnqSGKeosS/UxHj0eEz1DYtwqJ6KTOzHF6/bpjOr4J0ocGGXoD/Oa5WIgin655oT5pJqRij0iHY6/zKL8tVBuJFO2GtNWapkKym6xgonUKBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ5Uf2k3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA83FC2BCB4
	for <linux-edac@vger.kernel.org>; Thu,  8 Jan 2026 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767874148;
	bh=IlkapupCVg4ayKuGBWjBIEEBZdPH2VQahkQRg+CWzI4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bZ5Uf2k3b8UYtpsuzZr4FSp/8RtCV/2IH5RWV1y5/9//PtpZcgW9lONjONR3WDgwm
	 rsyw1018nRwu6KQxhapQzjne0xmLCJNajmj06/6X/raaDrcGo1HoAxY8A/uvROqG50
	 yAF+AMabZwa0v1M6pBAkTjGl64ocEJA+tDQUt3FUbf1uAQgaDUD8Rzi3/I7yk7DDP3
	 ZPH8YLcj0UFwwA9AQQr0waw/0/IL5nQ6ylEDGu9N4o4UV4Je9cuH6RPhmNRPkx9Ida
	 kOHwDydjQZXzCOPOeOiohya1UtUK7DIFCdAFzwJmwdKSZW2cWjKqkaHTOIXwRYbEdT
	 5UY4t2G5tUQdw==
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c3259da34so2121420a91.2
        for <linux-edac@vger.kernel.org>; Thu, 08 Jan 2026 04:09:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSrkHFJF3WaKfkAK4obP7tvIKkO5aUr28YSF3YslmkulykLoZxiVaDh3Zkcr3Dv65fz+2IXYaq/dcy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx25Rmyhn0NU+o5EvEzPjz2xsxtJ3ZNqAhnoA1NU3Ia7quRe0g4
	HLDzhAg1mC1jR1YJNYz3TEN+o7dMBQyU3LKAq70ToKb7ZSGtBiTbDQ1XCHOMXgW30eUMyqKnfUz
	pUGWQ84EHx9tqLBQxzM4sMQxwrAlmIWo=
X-Google-Smtp-Source: AGHT+IGX57hgeb2ZVSLwuDKQlmQUj2AYa0d42FefuZ+RRW6xX4ED47oShHaUK0b79KTNvwCW3/IAwSkNxAOZT9ITLtE=
X-Received: by 2002:a17:90a:ec8b:b0:34a:4a8d:2e2e with SMTP id
 98e67ed59e1d1-34f68c912a3mr6191078a91.17.1767874148227; Thu, 08 Jan 2026
 04:09:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767871950.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1767871950.git.mchehab+huawei@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 8 Jan 2026 13:08:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGxcOAEVQUUkFDtwqGojDrNNghthcys8qQynK==jbJ9eg@mail.gmail.com>
X-Gm-Features: AQt7F2oQ8CsSm2hrMLNcdbX_AytGzyTL2fR5DeQNbJcSRRylJ48LlKDj6r2-1BM
Message-ID: <CAMj1kXGxcOAEVQUUkFDtwqGojDrNNghthcys8qQynK==jbJ9eg@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] apei/ghes: don't OOPS with bad ARM error CPER records
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-edac@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ankit Agrawal <ankita@nvidia.com>, 
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Huang Yiwei <quic_hyiwei@quicinc.com>, 
	Ira Weiny <ira.weiny@intel.com>, Jason Tian <jason@os.amperecomputing.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Len Brown <lenb@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Jan 2026 at 12:35, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Rafael,
>
> Current parsing logic at apei/ghes for ARM Processor Error
> assumes that the record sizes are correct. Yet, a bad BIOS
> might produce malformed GHES reports.
>
> Worse than that, it may end exposing data from other memory
> addresses, as the logic may end dumping large portions of
> the memory.
>
> Avoid that by checking the buffer sizes where needed.
>
> ---
>
> v6:
>  - No code changes, just a cosmetic change at patch 3 description
>  - Added Jonathan's review on all patches
>
> v5:
>  - Changed the name of a var as requested by Jonathan
>
> v4:
>  - addressed Jonathan comments;
>  - added two extra patches to prevent other OOM issues.
>
> v3:
>   - addressed Shuai feedback;
>   - moved all ghes code to one patch;
>   - fixed a typo and a bad indent;
>   - cleanup the size check logic at ghes.c.
>
> Mauro Carvalho Chehab (4):
>   apei/ghes: ARM processor Error: don't go past allocated memory
>   efi/cper: don't go past the ARM processor CPER record buffer
>   apei/ghes: ensure that won't go past CPER allocated record
>   efi/cper: don't dump the entire memory region
>

I've skimmed over this and it all looks reasonable to me

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Thanks for cleaning this up.

