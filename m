Return-Path: <linux-edac+bounces-4794-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A5BB5363C
	for <lists+linux-edac@lfdr.de>; Thu, 11 Sep 2025 16:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 723C57A395E
	for <lists+linux-edac@lfdr.de>; Thu, 11 Sep 2025 14:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4667632ED3E;
	Thu, 11 Sep 2025 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MxdO0f+q"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456AA3168E3
	for <linux-edac@vger.kernel.org>; Thu, 11 Sep 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602169; cv=none; b=hjioID8LbKvCcKX75HkrdqZKS/zC42o50juSLghjDGT4enC2MKvsh2iU9eraB1d73cFB9bl+nJW3EP7ojqqhvOGzqBpzl4xmQ1XWqz/Tg1zCQKvBtEMBOKuDciVjn5woFriQg6GZY2yyqHQV6o209mSvyJwzOgbcevGmwLC7bzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602169; c=relaxed/simple;
	bh=nZNJNdLhUX4eZQi5WdK6un19/X+qzc4I91sCsvrOkwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODluMUzWTpx34Uob0mVpAJnsrwrFLuO+7kpw/brkqJCaMtC22pEqw9nzEez2arwdZpvWjJqEI81hmOVteQJEDRSIXHZyDsSlPt4+RHebLjCD6uUs6FAe1gvVpzdIP2cJLSLuaZ0QBxBRNb3vdLlpq2YN6D8I/OBnT/xak70O1ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MxdO0f+q; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b046f6fb230so161794866b.1
        for <linux-edac@vger.kernel.org>; Thu, 11 Sep 2025 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757602165; x=1758206965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MEz2+cml5j+5MjPboSsybw9IPJE7JLDZt4tZ1qBoVoo=;
        b=MxdO0f+q+9bwjrBvh4IZAK5NVxbyhcYa8am4qmq25+9FlsGj+IO418SAwNKSeK7KNI
         QUWbZdRpWLdYPlMRijzvLUzSyr5QYzCgmCBZtmB+dQXHvNTfHGBKKuvhNIws32ZHCGws
         F2c/jihpHTvnffnMAchnvdxQo7PJUtOV+BPmqz+AL6ShT47jnyIceWTHFtLRw1xr8GJ8
         lnkXCYCQw0+r+0/uWF9AiN+VW5tJRoun82KNPJYl4+3WSqOOlGrwfdxQzxt7tkagMdds
         +CnBKeHygCHiUZWQthQLLVakgt6s4PwGJC3yX1aM9uAdPwg5jqC97bmaaKBxAeXVLftc
         uIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757602165; x=1758206965;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEz2+cml5j+5MjPboSsybw9IPJE7JLDZt4tZ1qBoVoo=;
        b=NR2ERCh9EJ2l7XzcBkc1A7DNVLWnYHvoWNVLwsdlVLFMISQAcBk7aRKZK/JtIe1QGh
         6NBQg+PfJB8tzclr5/5ezathcxFscfZIQgKfhwpLIbrfApZ/c6c3NoTRhyFOxOK5nVjN
         xBwcEWuhztBqjoGkWcaNyXK6mxxCF1fkLhkrKnR2aw3Cyrj9RsW9GZAyxfFRoKnoTqOE
         BDf50PRgujqjl53f7Wy2BGsmzPT6xEav8d2gdqLWKdQXQbF2JlC4nXNXSgvbYv/FXN9n
         GLgz63GDbmhY/4vvadjrtdw1NGL2x/1zyqLTNi4puRUaqTyIk7uw8l2XExCDcJUT9SS8
         GLSg==
X-Forwarded-Encrypted: i=1; AJvYcCW8Dlsi9kRNgsfiHsR257dS5V/xdOwo/Risu5J4P/SL2zRC3P0IfEx/1zR6oZpDmU30EgxzPZWrt/Oc@vger.kernel.org
X-Gm-Message-State: AOJu0YyxULlZkN2KSrlEWZ7LrN8PtuRYE0CzSB7kqPQfku7U+ubk6xhc
	YZWzdCQ87J/vhELjFGneDiNvrxnatqcf4nV81MZYYnOJlQNg5ZjtqrXn0o0mWZKwx/s=
X-Gm-Gg: ASbGncvWiYiLJACzq+s/IPawSWwltJENir+Wq5iZFbCWJy9yLPCpqER20WoC5jO+xsZ
	/FeDjvFLYBKz2iVLoFEJFIJujgwbVxacxPhx2LVmAE2p0gn/3Q/xQxrXKxdgSJDPbFmYpelPBBx
	NRkM7srzdOOxVuCykvRU7a0km9kxahkjn2oYTBOFxMAbK6m3WIsJOMDxqlPq3tuo324gYDrU25K
	19NxGfg542acsJz/p2KBUN1YwQ5E8eJY06r79A1T22X/Zqjap1BN9txCxvXXQv/xZMq0UZxQ57J
	IxpHrGIV0VR5TgA3sdSwltb9br8dR5f9t2EPYRJV3hGBj/UqeYs1NPPU/aL6YFXg17Ti0UMroD9
	BSilnNTgCV0YEFucgdO5mEdTcOF3ni54ccsDA0jqZuEAW6Q==
X-Google-Smtp-Source: AGHT+IHPb3IjrEimQsyumFROs4NKhrkNJv561MRSVOi7204nznH7JQ1izwhU2UokmRl99dhwlmX1kg==
X-Received: by 2002:a17:907:e2e6:b0:b04:3b97:f972 with SMTP id a640c23a62f3a-b07a629c5famr421639466b.3.1757602165514;
        Thu, 11 Sep 2025 07:49:25 -0700 (PDT)
Received: from [10.20.0.214] (ivokam.ddns.nbis.net. [109.121.139.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd57csm143221066b.52.2025.09.11.07.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 07:49:25 -0700 (PDT)
Message-ID: <6ac1df31-0e2e-440e-9753-16f3a29dbc9d@suse.com>
Date: Thu, 11 Sep 2025 17:49:21 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/15] x86/mce/amd: Define threshold restart function
 for banks
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-13-eef5d6c74b9c@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250908-wip-mca-updates-v6-13-eef5d6c74b9c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8.09.25 г. 18:40 ч., Yazen Ghannam wrote:
> Prepare for CMCI storm support by moving the common bank/block
> iterator code to a helper function.
> 
> Include a parameter to switch the interrupt enable. This will be used by
> the CMCI storm handling function.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

