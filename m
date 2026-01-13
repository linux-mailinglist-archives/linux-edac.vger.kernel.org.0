Return-Path: <linux-edac+bounces-5633-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A6DD1B1C9
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 20:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0CB33019B48
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 19:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351BA34DCF9;
	Tue, 13 Jan 2026 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sp1hX+da"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECD03126C2
	for <linux-edac@vger.kernel.org>; Tue, 13 Jan 2026 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333913; cv=none; b=Z72Wd11WbODhdXwcYFxLs6KcyYhb6PQZivHOOEdS1RPad0V60DR/6grAljoLfZ1G3BJQHRUe400ECF7n1Uw4Vy/rkDUcLKYT/NBbHtpLS/YwqgooW1WK7QSHcN37H0XDPLW1YV1sq805ld4KWpQGX2C0XiT+QNbbeEIlbNdGPNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333913; c=relaxed/simple;
	bh=zRIffyaOvjED6xMKcvOp8Na2Lv842tUD9UTt3e8ABQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsGOxmmt0d+z86WqyC1RkBfR4bKJCkEbHSWGOS2EAljDTBYydoHkD69mksC0W0wT7cvdH2XsPZFagxRw+kAGwSXqDhPxP4U+hRab68GYsqFhs/7jJk/1Qv1EGPcmRNIsmoDgX6G/kUdkOhfjQv59T1hy8eZEIHV8SWJVmPotp4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sp1hX+da; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47796a837c7so54833225e9.0
        for <linux-edac@vger.kernel.org>; Tue, 13 Jan 2026 11:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768333910; x=1768938710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FMbDmZKI5cb2u07kpKeASbvMWOPA0DZS64gMvOkNgOU=;
        b=Sp1hX+daa8eFzNfWwfF6gHr6ly+wufSmt2ROXMY8+3lSCgBQ37wk5q+hwrr/D9VXHN
         8vnqmEfowOAp8lPZx9TmWV7AmE6FphphzBvR+eYaEHUCuZgvMDSrtXi/V7BOB9f07cLm
         qFv2RY6sDNxuMFjgUkdLVxyYS0RZDsFdzsG371Ol/VOhhMqWIm1/W4xIFWirXckJlOWD
         Y8hpU1/GkvTcfvoWEFhjOCvFrjxM3FPuSYbklerWtFmj056NuO0VNFOgUDGYf2vB3uUZ
         DZCHnIfLLP3IRwP+ivt9FtrnF+T/M4B7sVlYIlj3oCNDsPogn0xW5GlBDk46NF9QaJZk
         rqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768333910; x=1768938710;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMbDmZKI5cb2u07kpKeASbvMWOPA0DZS64gMvOkNgOU=;
        b=BHpulp/pKbaC+bU2laNsqtSGO47UivZp7kHm6G0FctjBaMnftby3OxJh3I5oVtrkXM
         rl/rEythF76jnBQhCeTS22PCxABDkY4LeV1DLR7dxMo6vdyN4aYyqq5VpS+5Drk67kEq
         c92E2tYMANomY8R9bvQTogzWWFEzYoE6gZbIXuKwm9XP5+ayaU29qBrPFOWUlUyLUz9d
         njLMBAPFa4/s4U0vDrhal66iAu5JiCxpbfEGsu/pBzii2ER2o7V1FKfSAVu6g/tWoIxW
         gn6TCZ5ctjAQXlA9v3zm6dSu61omB2INpTxhGdaM7LQaYI1eTr/saVk8dPkybQm/PqvT
         R0mg==
X-Forwarded-Encrypted: i=1; AJvYcCXCSuLuOFowJwIiwDjY7tK64TwIArsoBbQdmTfqI6pKkUqYZCl3DyX/DkBNcMNBoTTR3jvxoiBwZmuU@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRiG8J2o2NJDVuLjOko4sK6A2JAb1znq0gI8ur0pq9Ka/WT8d
	btdfmXln6V46S7ClvqOv4+wzEiuOPOlVMUQlX/AIamcMDilSeNmEWBUIPWqc6xmtqIE=
X-Gm-Gg: AY/fxX4cPhu3uvlhwqdNXVaFbVbsJ7K1hs1uVXXlC5GpWnTUkPgH9L5PZJ9SocPz40z
	FerzA28k9zCIVWd+uBjPttj15jQAp31V3vQRgulFtOuBmp9u1k4JSgJ+rABu8fQK5gfecGO+iuy
	KsRGdbb9re/EBZAd7KLA7ZEIFvBqnVmGC3zC2Epq/5IDj5V0TNw3gGuRbffmClaHfyJuY+2NOti
	0pncdua3AqiZPxnE64vJ4Nt9taEkrlhyHtz3c45eKWxUgfq/yOy4aNEY0JssFsGKEUg8vdkHA8A
	YX9GiTNxszFrAlvt91oxShKj0ztXdMlYBvyUB+0pF4JGHIea/nXH827k/ghd8Sa4fRuJ6z8v30B
	49qLXsRABkGiO07X7KUE6v+jST303w4y74DO+9DNKe0kgKghtz63qvRRAJHm6Z2ioCXH6h5L8Ry
	5OrtQJx2QA8ATPSe2aAmr4WAPC82xWaD4ojHCr
X-Received: by 2002:a05:600c:8506:b0:477:1bb6:17de with SMTP id 5b1f17b1804b1-47ee33a646emr3823215e9.30.1768333909936;
        Tue, 13 Jan 2026 11:51:49 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47eda93feb3sm53176345e9.13.2026.01.13.11.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 11:51:49 -0800 (PST)
Message-ID: <dd23220f-d023-4e95-a1b4-d8e67ed6b777@suse.com>
Date: Tue, 13 Jan 2026 21:51:48 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IFvlpJbpg6jpgq7ku7Zd?=
 =?UTF-8?Q?_Re=3A_=5BPATCH=5D_x86/mce=3A_Fix_timer_interval_adjustment_after?=
 =?UTF-8?Q?_logging_a_MCE_event?=
To: Borislav Petkov <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, "Li, Rongqing"
 <lirongqing@baidu.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 Avadhut Naik <avadhut.naik@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <be786e9a-0302-47be-b2a8-bfa4449c7ab7@suse.com>
 <20260113191351.GQaWaZb6yzj4a9I_0Z@fat_crate.local>
 <6feff2b3-6088-412c-b0c6-1d32aa5a9d50@suse.com>
 <20260113193327.GCaWaeB1rp7HCFJBHV@fat_crate.local>
 <c425bc04-2b01-4616-a244-01c896367f7a@suse.com>
 <20260113194438.GRaWagpmRGD0qGx9az@fat_crate.local>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260113194438.GRaWagpmRGD0qGx9az@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13.01.26 г. 21:44 ч., Borislav Petkov wrote:
> On Tue, Jan 13, 2026 at 09:37:13PM +0200, Nikolay Borisov wrote:
>> Yes, and why is Li's approach not working, i.e if mc_poll_banks() returns a
>> value signalling "i found an MCE" we halve, otherwise we double it?
> 
> It might be "working" but I don't like that "bool logged" thing and
> marshalling it back'n'forth. This should be waaay simpler.
> 
>> That's certainly doable, but why should the interval setting be coupled to
>> the initial notifier and not to mc_poll_banks?
> 
> What's the difference who notifies the timer? The banks polling will call the
> notifier if it finds an error to log.
> 
> But before we do any of that, we need to figure out what commit broke this so
> that we fix stable.
> 
> Thx.
> 


grepping around points to your 011d82611172 ("RAS: Add a Corrected 
Errors Collector"). Because looking at the commit log of my 6447828875b7 
("x86/mce/inject: Remove call to mce_notify_irq()") I mention that 
mce_need_notify got introduced in your commit and it was called 
"notify_user" before that. Before your commit in mce_log there was an 
explicit set_bit(mce_need_notify) call .

