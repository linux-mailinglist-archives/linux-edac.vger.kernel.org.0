Return-Path: <linux-edac+bounces-4267-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F84AEB5B0
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jun 2025 13:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001181C221EA
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jun 2025 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1162980B4;
	Fri, 27 Jun 2025 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZQUl37sN"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353F1917FB
	for <linux-edac@vger.kernel.org>; Fri, 27 Jun 2025 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022147; cv=none; b=A9GUH2ijdS9Gv075MdjHfpPPnu/CbXSIp6KPy/uqH0p/ezfpouDkr4Lg7jusWhOEInLOYbsPI37CitTiRcCRUcMpus5f+mMUjEgoULEhAuQSZHh+C4TIaIqQCaxPvnV5+dixCJZ2lcuSk7SzV1j1CA5FWgRzGcRTp+uzAd64Yj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022147; c=relaxed/simple;
	bh=UbocRxrPuinG6iYFnuvEcRqpEfvfqq9ovOc0tDbRGtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7v4jofoRtGWqNz0vREWHBxpbll1mA7T1QT4Y81+9VkTeApr5u4PwBH8UaTGyVWm38bflk48J2YcliBkVJ6z4Sb4CU1aCL/BP2mbZaUYZEdfW9Q7O0caZlf4yEJtdb9IllVp3uUy27DFrt7UIKZbJjyTgGmC8SpJGjxc+93r36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZQUl37sN; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso1116804f8f.2
        for <linux-edac@vger.kernel.org>; Fri, 27 Jun 2025 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751022144; x=1751626944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5MB5U8bqYDJvjeC9i1OhQ7bFIZu2Wa/gbdobERtzeqk=;
        b=ZQUl37sNLgIwffCNus2cKZAu9Uzh5XeMjDhwKWFUBV9/TLxQrYWpKedzdQSg9xGMTI
         AY9YQ7J3eOiJ5DFCSOt2tvXSma8zjhxUNEGuHEbHWMH6kq6fciIiIURtEU8Qj2xqEA59
         AU19Ec9SvCI7gQNGKtVbvotIqZiSXTtLDVzVo5vATPPdGA92fupFMB+uqnjs2WX9paxg
         9JTG/V+ZR6bJT9+vymVOMF4L27MiIKsFIdcZutiubRbkfghTxdz807LZVV5iSo9Az4J9
         J8z100MTOjHHWg1kHYzaA6f6V5p8SSKltli1CZc44QDL5nXJTULtpc/gfvapuCOoHEZI
         7Qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751022144; x=1751626944;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MB5U8bqYDJvjeC9i1OhQ7bFIZu2Wa/gbdobERtzeqk=;
        b=HOKHox/p3I2Dpt7WJS2WGHtAFBz81twWtZo5/KHvazT832QFMlLpW31y+AA8hMZcEB
         eUl/Xev8au/obBm8RnNWX6tzpgKu+EhZvBYxeUTMJbH1P6tUAmcHckVSNMsYH4qzH9OE
         mI/PMLuiIu9uiT2F04TDu5cfn0Ee7Avkn/Hl21HFwwRBOjoI+I9gOVTq2HP8HnFouOpB
         tO/5yUwWDreHEqfMfcfHTgNyWucHrrFpnuwHgd/YdR7PjR7bvVT2yWIFPJukYRzTBBGW
         V5fZNZJiRuw74zoH9MxhG7xMBBHachFvZxp34eRFA0hAj1FcGHWbA7ihUKl66Lvp4E/E
         /5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXK+Ah4IU2nOftKjjfL09zS8rUEFDx+A2bmA7oSC5Em1nxgtqfqIrjXJSyn74odSMm5/rQsOk0SjzCR@vger.kernel.org
X-Gm-Message-State: AOJu0YzmmwFwsOOAiaWCaZF4HWCpK8ciASvxyH/HLbmn71BH3rbtmErU
	oBLAD1Qv4l7H13BvlO3+CL10PVYWKCGVGqhAaD7PkjSZk8EIqgrKwjjW88ffsVznUpk=
X-Gm-Gg: ASbGncv6adR+CilvJW6PbXCZNMVktrGFa7E3akE9UWyHzWCk1JY/VCbnaz2WU30Ru93
	WM3dSIm4hOLo2UY/3WixyY0atEHZZoqrNqDvsyjtEg5xSJ+2/UMwYnX57mvAPuA9G80OaWYC2ob
	hAKDJzRGQiLW+EJBpZ+bj7alx3Q1eVhVgCmtA3CTzAqDR/7rFwZU7ePzIMWBBCzRP2mQzUDsBBb
	A8PYQPhY0/sSnTBF5fglLRBcz86U9x3PuzjhsNszbHtyJ8GCbuX0W5AFcGcMC2tQF30vaDvHAI1
	thex5e/ZpCstdMeG4PqtWoktvtXiMwaYzGtLXy8lwaatIJfInXgZnD3PbLMD17iJQ5qYauN3cc7
	e
X-Google-Smtp-Source: AGHT+IHdTlXlXAt6xlaCQO8aQcUU0g1Gwno+uw9Gk0I0YiQJvSGgcSxuFvYNh4HIOayLHeaO/O805w==
X-Received: by 2002:a05:6000:2809:b0:3a5:232c:6976 with SMTP id ffacd0b85a97d-3a90038b991mr2054599f8f.44.1751022143774;
        Fri, 27 Jun 2025 04:02:23 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.159.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fa8aasm2361784f8f.27.2025.06.27.04.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 04:02:23 -0700 (PDT)
Message-ID: <c161e5b3-0719-4bf9-b7db-e5dd0fa8902b@suse.com>
Date: Fri, 27 Jun 2025 14:02:22 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/22] x86/mce: Separate global and per-CPU quirks
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
 <20250624-wip-mca-updates-v4-14-236dd74f645f@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250624-wip-mca-updates-v4-14-236dd74f645f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/24/25 17:16, Yazen Ghannam wrote:
> Many quirks are global configuration settings and a handful apply to
> each CPU.
> 
> Move the per-CPU quirks to vendor init to execute them on each online
> CPU. Set the global quirks during BSP-only init so they're only executed
> once and early.
> 
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>


After this patch the code ends up with 2 sets of quirk functions with 
very confusing names:

amd_apply_quirks/apply_quirks_amd
intel_apply_quirks/apply_quirks_intel


Better naming convention would be something along the lines of:

amd_apply_global_quirks/amd_apply_cpu_quirks and the same for intel.


> 


