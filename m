Return-Path: <linux-edac+bounces-4880-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F018B8F1E3
	for <lists+linux-edac@lfdr.de>; Mon, 22 Sep 2025 08:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B1317972F
	for <lists+linux-edac@lfdr.de>; Mon, 22 Sep 2025 06:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86922F5322;
	Mon, 22 Sep 2025 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FxYfeYpH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA90A298CD5
	for <linux-edac@vger.kernel.org>; Mon, 22 Sep 2025 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522123; cv=none; b=CzrDKPFGhmk6LNoNDMu2C66eHt/U8zB9gO6ytwqUzystBTrChg9yCnVtc/VN1NEn17QczJCD9dY1GdIV0avBPtAwjSB6ka9Kd1XCiTOA/ANPONO424ULrpi9JEF+rrn/ZIY0hLxlFs53nO3+DsnnvFKCg0KbXSMUHoKnxg+vf8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522123; c=relaxed/simple;
	bh=CJCL5BEPcUDkaY186ZiSz1N6maZ/1QO2mHIcYWEJb5g=;
	h=Mime-Version:In-Reply-To:From:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aL8gGXTlgBhW+zMFsDiccHUiSYL2HQmT+1kl+m0zgVVGftJFq+VXn2LrjP9bseOYchdn/bXwmnuSl1CfkgMnISio0hg1zXz3fKWQgtIwyJhbUGSiTNmqAUhF9l2zv9QHEUESvJhZqi7d+nepx0aD4EJiRYPKhksmFY+62C0mRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FxYfeYpH; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6353f2937f3so327817d50.3
        for <linux-edac@vger.kernel.org>; Sun, 21 Sep 2025 23:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758522121; x=1759126921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:references:from
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJCL5BEPcUDkaY186ZiSz1N6maZ/1QO2mHIcYWEJb5g=;
        b=FxYfeYpHaKHeup202awRg2FDFKafLZoHcKLbZ9avm2jZbJSdN6Z5Xobxaa8O/ABZmB
         wPcQC5bUkEWE4vs5EiK18PY9UCR3V/sx8MdnVw+uTqMayS88+7cN1xukGY04w2jXqzB9
         E8I+xLhAwH+51YB7aS17j2tix2BRK7rRKik8gV688kjk6JLajUNqWdpqhiqQ+/sMqvyG
         YjLaPo2iigxaRdxwGWpLdLbx02p1dXDqghJ0hcM+S8h9bsCNHZdi5y49Fm/gZItBjOIj
         JN1HUI+a+TOCldjDU8qkVb5EhqxmspPoEZNBOPBV/rwqu04wIuGIjIXahpoqGeOKB16f
         pqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758522121; x=1759126921;
        h=cc:to:subject:message-id:date:user-agent:references:from
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJCL5BEPcUDkaY186ZiSz1N6maZ/1QO2mHIcYWEJb5g=;
        b=huDcu04eODSEUq01s0P0Qp5fv9srkqpzmBqd2gkfpcnN2gbj+Zsy83tw/TyLvGAZH0
         Z95PyKydxcfx4sNQQbQryzQzMG8xNXnpvssRDXM04Lh8FvA84RhA7BQOFFGH5ruP5VB4
         DVS95MAD0AR/C8LRp2eyX0CFRmUTgRDqnCuC/BL/DO+d4zUnkatoofdhAnQAx/nh0Zka
         21bPebfrLwK5eYB/5SMaTgQBA3XsZfIogjL8hH4vZvHYi7sfMkCyw0QjcnWSya/eQSQN
         cuI0vexn3+Bp/IVwFz05GEIjI1TudeKjPFojZicnAjEdjtzPR/204NyrdaZWztVVBnue
         5YnQ==
X-Gm-Message-State: AOJu0YylZQImZJHu9bG6Ulk7SDtsOkuAmzqOUGfKYPCOwYwVk1u6gHf/
	e5oME9frNKYhJba1QG0R/B6ZxUZ57s4tCosCrC+L6EPtsYmAQ/mEWdYq4RzV32suRCIeb09TC2W
	zH3ne83q/lR0Ux5wnSL0m8+Yetz9ohfflHvbslheSPA==
X-Gm-Gg: ASbGnctVIKZ1DxqazVpzGLtOCuoX9pVsLb4GEgH4+LOYNuemNXe11FVoASYgxnzHlB2
	lJmQu2jAQGoNXJA6RT2pqiHlMJdL2vv+ulOIt8ccx16UHtETTY0KNGGpV39MNp7TBQfVCctQVFk
	ca/YKJmZc5i0WxJwpGh10tZAKQhtssegBHA4VNJ8NYbPxvtaZu1yw+aW1b7Ugdunli6j9IOFREQ
	XJIg+0Yrg==
X-Google-Smtp-Source: AGHT+IHhXNBQkZKHusfqahAqxM1ALfuXESEXOtvpI4K6U0wS4nO9F3zMYGz5W6IsEBxhXvfLKW+/GTAzoL105VPYcCU=
X-Received: by 2002:a05:690e:2505:20b0:630:8fd5:4cd9 with SMTP id
 956f58d0204a3-6347f5d0343mr7947322d50.36.1758522120671; Sun, 21 Sep 2025
 23:22:00 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 21 Sep 2025 23:22:00 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 21 Sep 2025 23:22:00 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <SA1PR11MB7130D0C4D54EBAD854CB18B68911A@SA1PR11MB7130.namprd11.prod.outlook.com>
From: Rui Qi <qirui.001@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
References: <20250918121704.45116-1-qirui.001@bytedance.com> <SA1PR11MB7130D0C4D54EBAD854CB18B68911A@SA1PR11MB7130.namprd11.prod.outlook.com>
User-Agent: Mozilla Thunderbird
Date: Sun, 21 Sep 2025 23:22:00 -0700
X-Gm-Features: AS18NWC7ydSo-Pbyk19l4vC7zCVBkL-thS0EJngVcF_Vzt340CAkOsiiQC93ouE
Message-ID: <CALU4DmqEF4qbWdz5E6wo_XrWXKpYNfCzTrENCj2jH=DaZOzftQ@mail.gmail.com>
Subject: Re: [External] RE: [PATCH] EDAC/skx_common: Fix allocation check when
 adxl_component_count is 0
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Luck, Tony" <tony.luck@intel.com>, 
	"bp@alien8.de" <bp@alien8.de>, "mchehab@kernel.org" <mchehab@kernel.org>, 
	"james.morse@arm.com" <james.morse@arm.com>, "rric@kernel.org" <rric@kernel.org>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On 9/19/25 8:56 PM, Zhuo, Qiuxu wrote:
> Hi Rui Qi,
>
> Thanks for looking at the code.
>
>> From: Rui Qi <qirui.001@bytedance.com>
>> [...]
>> Subject: [PATCH] EDAC/skx_common: Fix allocation check when
>> adxl_component_count is 0
>>
>> From: Rui Qi <qirui.001@bytedance.com>
>>
>> Use ZERO_OR_NULL_PTR instead of simple NULL check to properly handle the
>> case where adxl_component_count is 0, which would result in kcalloc
>> returning ZERO_SIZE_PTR rather than NULL.
>>
>> This ensures correct error handling when no ADXL components are present
>> and prevents potential issues with zero-sized allocations.
>
> If the ADXL component names are empty, skx_adxl_get() will immediately jump to error handling.
> So, the adxl_component_count value is guaranteed to be non-zero when passed to kcalloc().
>

Well, I've rechecked the code, and your statement is correct. So my
modification is indeed unnecessary.

>>
>> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
>> [...]

