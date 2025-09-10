Return-Path: <linux-edac+bounces-4773-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8D5B51614
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 13:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B615467A65
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 11:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D86D2853F1;
	Wed, 10 Sep 2025 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SlFE3eEN"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52727877B
	for <linux-edac@vger.kernel.org>; Wed, 10 Sep 2025 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757504888; cv=none; b=XXB5mTsdtTll/zHgBhH7Tm075M3ARABrVaMI7bBaeom634LCkxV0nvcLBTRCFvLyGIotNOtbnlh+q5z4B6tYgFG1n8BMh1IWVrsWIbHmIQoMymqTQHIDFq9ECjutTN4dsY78y4wYMOHygq52/l+84B/vjrvVnT3uF/7DxrK1aZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757504888; c=relaxed/simple;
	bh=glUpWDjU/whbEm+cXSDLbJPOFLb0/DY79uUM8qwNMmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQkWWjipJef6s+dGi61W4nBY4CjIgvkhpT+6gXqEA9QvkOzMLTzmhKlzQICQeVnKJAuTOiZu3EQydKk68qGuL35oB/UWj4fdEAlnHWbvBunB9bEC2tWBzWLqY13F2kKlZroru6M6XfQun+/ymlaHKKR5rJ1njz2v203RWX35QXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SlFE3eEN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45ded619608so16423405e9.3
        for <linux-edac@vger.kernel.org>; Wed, 10 Sep 2025 04:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757504885; x=1758109685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=psddHzFokLiBPLVEpbVIxZmPYIzTbvsTQwlkDfkebjY=;
        b=SlFE3eENiwnEM1Al7EMhcCMqh9WhfBa4g+FJfrvc39yX5nwe4NVDfwywiqO6CVLk0g
         bW1MDTIzhCtViHtMWaNf47634TfjHUBYGkrXR4kHR7uIaSN+Lz/Z4xglnnPFmLSgIg+0
         /k586jnhIR/4GAlPlyQpbjp7Eoar5wYg7N7sKkkvF+kevpy/rPFBqpap+FDxT+H3+8rU
         LYHvuQlVM4/ts8vjnm9wK4QBndjvniWxo0nh2LL3ttEYxdC6skVXBeeVzX3HTK1M/UjO
         mv7/JzWYNm7PNhY0CAhZ0YMpz8EESxghbkWTrBOGqJUeH+kD8fVXFYUbCFWzn40ETX7x
         LS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757504885; x=1758109685;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psddHzFokLiBPLVEpbVIxZmPYIzTbvsTQwlkDfkebjY=;
        b=aV7h7S/ocNRnS7ydcTja5yq9Iy1M9l6Q8i8TpAHMoVvRQ8XtfOEjS0FLtPhKeWypa2
         huLRwcXRZzPHOl7Btag1YOzKq9978Pvu7Jnxd4RHpIukd3gCOG8Af5zrbK81gwEXV82Z
         zM4n4Oo3LL/GLXBLmUXNyuVbeQN2ek0DOvlyUERGqCWWYXHNNihvpQCaj1QBZGf/hGz0
         APGu+MmqQSZAgisqPdHi9QGT0IAvfWF2wKZWvMd3+MX4HU9xs06yXgwXdTScMc/FgmsK
         wXhjUQNOmF9ROZ83jI3DLKsG6XW5F1Xk2P09ICVtKwHXTRYRtqELHW5VmrlAS9H8WqAr
         jxWw==
X-Forwarded-Encrypted: i=1; AJvYcCUBmbPig6XK4jatmi5eJqQ3wl8tjf8Xz7oh8d5Yljtzh1rGdbjzUVz3fizkenPlIIlup/gtIBT6NACg@vger.kernel.org
X-Gm-Message-State: AOJu0YyxrlDpU3dgExQdWXfb1gBeFUmRtOq0AnQ5ncr/efHFKz5sT0/6
	zaFLLo0BNyyR8f8+O0HH59Slp8iqOphRmub6AM2uFwtyNdhkKXHf0+Y4rllgEyncfXP7WiS9Tcw
	KKRG+
X-Gm-Gg: ASbGnctP3skmWkvfzD82QzVD5G/KTz7yusHWc4d8Xd4qBaenBHfuCm7jl+zofu9QrUH
	64CjYtXSboGVa+c9+Ik1lG1qkvi+ByG3N0+O5seyfej5Ruign4NZaj19WvH6HsRfvgLMgJzIu+j
	NFRz46zqJaADrbMFmObdRSQKK/NEuKnwtn6NMBrGrlm7dEEzfDUWdVfl+0pDeSKUJ8jjZqbkaf9
	6L0uCQLMYgdJzoq+EM6aAvExVwwC7zJ0dbZCKLiq1fhL+PfGD6qFWL2lzYguxO4zOe/j7p5nLWJ
	e2/FiYu7ov3f+BTdn3KA08iN/hfXak+0SmoW4FVMuo9xllULszS6SDm61Rlvx/JucVEU4SfcQ15
	aADsgqdK+r7lL6n++UyAbzK3y/gKLg5JM8to8
X-Google-Smtp-Source: AGHT+IEC0BwkiBcLfkC6AyjnK+7m/uZFo+fHuHF5ML5ydk07hOwcF87TM1WXMbXyppNJR3OAgoJ1Xw==
X-Received: by 2002:a05:6000:1a8d:b0:3e4:e4e:3449 with SMTP id ffacd0b85a97d-3e64c692515mr12297520f8f.58.1757504885431;
        Wed, 10 Sep 2025 04:48:05 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.159.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df16070bdsm28840585e9.3.2025.09.10.04.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 04:48:04 -0700 (PDT)
Message-ID: <49960695-5de9-494b-98c3-2ad7f1d5fa9f@suse.com>
Date: Wed, 10 Sep 2025 14:48:03 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/15] x86/mce: Define BSP-only SMCA init
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-3-eef5d6c74b9c@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250908-wip-mca-updates-v6-3-eef5d6c74b9c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/25 18:40, Yazen Ghannam wrote:
> Currently on AMD systems, MCA interrupt handler functions are set during
> CPU init. However, the functions only need to be set once for the whole
> system.
> 
> Assign the handlers only during BSP init. Do so only for SMCA systems to
> maintain the old behavior for legacy systems.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

