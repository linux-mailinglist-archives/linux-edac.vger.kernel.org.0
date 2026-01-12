Return-Path: <linux-edac+bounces-5614-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCB2D115A6
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jan 2026 09:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E0E33013E87
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jan 2026 08:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20279346787;
	Mon, 12 Jan 2026 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g7icm/rL"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E04A345750
	for <linux-edac@vger.kernel.org>; Mon, 12 Jan 2026 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208213; cv=none; b=pSen2BiunxwDzefsek1nJAyEp0/QWOFyCcKLxOByBY1Uxe4lTpZ6y2vDTJ7NGdo7MLd4irUI+4Jj9Zi+0WdXqFgZE1Uoz3HOLxvbpN2DeEqW0YuyfWdn+IYghbYd1N/n6euwpSA/5KyBgpnnZ/ExSoIlvZLhpudoPgajFuK78Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208213; c=relaxed/simple;
	bh=X/5hoL4vsyw+/OxggE/JrchTzVJaler35/dzY9dSvYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IoZiKjFeFoJnTUs/E5hS6q5KXQokRAhQXSOXgAocYA/TevHDh9rrfngOURF8OpKcFfVtIcRV7tCEcjA8lVrBfImi/hE9N3YVEQ3G3isdg8NwA1CjPYH9PtmDE3lfMAHz67j4TtjFa4M3ONmTlQ5h8PWChm/10fM2VHWELdL7fe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g7icm/rL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso27802925e9.2
        for <linux-edac@vger.kernel.org>; Mon, 12 Jan 2026 00:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768208210; x=1768813010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xqnnGtIxNlVf6w1jM+yfYZ9zVPTNLypP9dGXnku780c=;
        b=g7icm/rL1YmjBK+8y01DEZtLfEPs2uXEWNe4yOnEV6CKCwjQOwxmhNB3Bukei4Sn7J
         G/3SdVwnulEojNSOPZZCuoX4+vS2no67IqOr3MSYh9UXQnUmY6jDUcAd5Mhs+Mswf4ke
         LWmOR8YzKU2YjA4+c6sW+m5i4vOLk2uXgc0lSiWAK8BJwUmq5UiPYCLtX+tDYLkntwiW
         JnG5L4t3w46SGjKZwAMh4qyEk+a5xnxlEVGji1G0JVs/yUcpCjKhuyDVrQ6fhMqhyaIv
         JZWB1DOAaM0+xgDdC1eAPJcGtU8rcqgz6FyxpFm8ExN6zQdBJnirWdydk+UAmmH69ae4
         LUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768208210; x=1768813010;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqnnGtIxNlVf6w1jM+yfYZ9zVPTNLypP9dGXnku780c=;
        b=cXQ1mZl38GpmeiJPnxQ4cRFTcALdUVDQUEZZEZCmReoDcDZZ6qXqm0Mo885I6blLeB
         PYbpEpYSgXcUKeM9c37in3E2Zkb1SRoc6K3fiK1qQ7dF1pY9tEvmN5YUAn+Q0b93o3pO
         4MlLMURjTFZdNoAEZfEWi1e/Hb3WAhPPQeJjEAU9cUZ8rKKr5+swUc3VsjYj/5gnGXrf
         cPQSPhwMPyM3IHIRFH9h02FxYUNnxMGwf+rPs00NxSKgyxMWOR69XOSFICPKK6w1/uM0
         XOjTa1lnq/4DT3E66+f7z+AbqSXIO5qenGzO7BPuExbn5fhsQZQvn6nWkIcfuDwdYvDw
         tYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaFEqg+p0JKVv7OS6atIYt6YtAcdq83l6CAWEtjDT2B8OR9aY/pctpaO1vEALONToU6QNtnGyQLtji@vger.kernel.org
X-Gm-Message-State: AOJu0YxYVY/Zy06AWi1NOcb4D+bC/Br+WG8dtBs/vBjaQJRQbiKsOYvJ
	5rsDVrnU/Cb39OCzs3otHzQoz9BRoi68EZkh83oNpGqg0Y6rv2PHvfodTad7LDrWCY8=
X-Gm-Gg: AY/fxX7hzrzpWCjrBIt9S2/PGUtqMM+zDbwGmUUQtD6/umwPKpLdLlHaipMwpmJxz0l
	mjPmlRgUkq0i8zSaRi6oGoF18X5oqxeb1UscmQlPuC0rQmj8NqQL7Cl7ECGQVJiAE4umRgzDc8a
	kGeF7oimibWeMrx2jEmGBHRiBWlF/RK/+5fasdI2ai57VFx51Q8JiHXQdtF5mrEGNwhiNSJcuvl
	vE18ut0LtpahvRt+eWTeEog7bM0cAEsemNf2BAJ9SV90Lg4lZIXT7FvrVSF7IFMLPqy6/6Ap2Jo
	ICAvSeHTN5uLtJSrxQOQc13RBXjRkhtMm/KK8xIUypPlLOkJBh4OeE9NReclKSW6Tf0kVKVHoon
	afzykbu5SfcSsS/6WO/P/e9sq4HF5mt6nRbQnN6l1CrtAzsKUs7DRTn60YY0ZcMrY+uO36Qluoe
	9UnZi3UU6nK8peEhd2VFI4hwqi0bS6gRWtttw8
X-Google-Smtp-Source: AGHT+IFuCnspaCv8g+IBSAWuq2o5Dpv1jawmEhlUdS77n/0/v6F6FTauE4NJ/C7ohaLR8Hktf9Y25Q==
X-Received: by 2002:a05:600c:3493:b0:477:333a:f71f with SMTP id 5b1f17b1804b1-47d84b3471fmr189644505e9.17.1768208209792;
        Mon, 12 Jan 2026 00:56:49 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f69dsm340713765e9.1.2026.01.12.00.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 00:56:49 -0800 (PST)
Message-ID: <36b42ced-f1e8-4eb0-b6f8-2a9434d5d26c@suse.com>
Date: Mon, 12 Jan 2026 10:56:47 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mce: Fix timer interval adjustment after logging a
 MCE event
To: lirongqing <lirongqing@baidu.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Avadhut Naik <avadhut.naik@amd.com>, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org
References: <20260112082747.2842-1-lirongqing@baidu.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260112082747.2842-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12.01.26 г. 10:27 ч., lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Since commit 011d82611172 ("RAS: Add a Corrected Errors Collector"),
> mce_notify_irq() in should_enable_timer() always returns false even

should_enable_timer doesn't call mce_notify_irq

> when an MCE event is logged, because bit 0 of mce_need_notify is not
> set in mce_log. This prevents the timer interval from being properly
> adjusted.
> 
> Fix this by modifying machine_check_poll() to return a boolean indicating
> whether an MCE was logged, and update mc_poll_banks() to propagate this
> return value. The timer interval logic in mce_timer_fn() now uses this
> return value directly instead of relying on mce_notify_irq().

This warrants a bit more explanation why it's correct. Because 
mce_notify_irq is really a misnomer, it will ideally be named 
mce_notify_user(). That function is called from 2 places:

1. Early notifier block, but there it's guaranteed to do the right thing 
as mce_need_notify is explicitly set.

2. From the timer function, where as you have pointed out 
mce_need_notify is never set by the polling code, hence the function is 
a noop. But actually calling mce_log() processes all logged errors in 
the gen pool and that is processed by calling the x86_mce_decoder_chain 
which will DTRT w.r.t to mce_notify_irq since the early notifier will be 
called from there.

<snip>

