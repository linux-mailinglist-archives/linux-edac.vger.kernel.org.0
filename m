Return-Path: <linux-edac+bounces-4775-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DB4B517E8
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 15:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3D71894A81
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 13:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C3F30649B;
	Wed, 10 Sep 2025 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NzbxX17/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D547C288CA6
	for <linux-edac@vger.kernel.org>; Wed, 10 Sep 2025 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757510981; cv=none; b=BnEX7piBwqjMNtJ7EOkg1J/IJ090UtlLcd3e74q+6jCTRnsVXi2rBghKXD6FeiM/9K3Eg85yVCFQ7Y4n3/o/Lm6WqvG2fTnuS4UaUPvdIO4GWd+O8FS2V9l3cMp/ddELmYfp9sRA6EVm8cm64nL2xQWEz0fBfIsZtvv9GNCZEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757510981; c=relaxed/simple;
	bh=ummYQlHD+Zi9f47ks9lb05+8D8/hSZq4RnitAF5O7u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZymurcbgeZNzvnBRQQItdsdDFNjTf1QUo6H5E56pM6etpdgohGRvPpen9vY5hJ/f0Rdld2xJRPRvqi6Gs58lJYOR5hsZsw2aONKrMKq/lmxlXsRO3MmNUI8x9TV+wQi4bfLb4HpX910TY9ao+cyxmCCyA4inUWrSi6if4LMLexo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NzbxX17/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso18972755e9.3
        for <linux-edac@vger.kernel.org>; Wed, 10 Sep 2025 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757510977; x=1758115777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qlKGaH1d3s0RHZ4omQFOWJ+FEfeUfvKfp8hqseleBdI=;
        b=NzbxX17/5esenJJ7V5bJGlb0yuqpeiXJnnFgS5nLFDyHAsPqFwkmfQVkFZmF9EruyQ
         Cu2EMGGzbUqzYo5dJLjTUklAzVLeLnMRL9wYMu4GI5TebxegS/QzxPBYH49wwjkf5zUZ
         LyxX4EcC3fwp4g3/IBo2v17qXBALIMUYx+svRmNbXJAUEoxFfptYgKZEIKTHMI+YeHVC
         8pc20hZzgO406rgAuuvoYq3vPsrafaW8yz744QOjm2WVQNiX3Xd4DwNNOUjwrUMJwgzG
         aw3ewFWXkWobJEDBGJFunKHALD5t+JbzocfflfF9XS6TkI03xH1heMsFk4hwyl0rA4Qb
         4GoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757510977; x=1758115777;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlKGaH1d3s0RHZ4omQFOWJ+FEfeUfvKfp8hqseleBdI=;
        b=xNjEFGrgi2n9ayyHwg9fFyGpJ9IK9OB+hdxeCD0l3urJYFolJtHyaRp3mmVVk/wx3y
         G8jAd0GNQG8V2jW+3ngiVa4As5Cmy3GPnK+5Ne/JDNtm9V2GwS8EkbmDgRgcXrQ6nvPc
         LUenKCo1474Z+GQIGYrqK6jNJXyMsSUE66Kj1OKlY404WNGXb6I00ZDwdBpRVYhf9vAL
         d5HAu0+GCV6IRbz8siHdbY/McHjkzu+DsB8jy8lZrjT8f/8+j+exn7+PQHlo35PcN3ZN
         lo6PRO9mgW8ILA9C1LMuItFRSQdaW9vXvczm/yxklx48ju5SXfszhq97ht+i1e0pB5Zh
         dKHA==
X-Forwarded-Encrypted: i=1; AJvYcCXTJFvKPmgTvmFgSLkIbQKoDgLflPJVaP7joGRmDVxqwpVOKfBG1iU1FG3oEZ+Iil0kv3HFNkoGsRlZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa54hSzCuQRnb+G/DYG8hb1GAaLl0G+nEPWvhgLlgWk9+o/ukV
	Yc4QVE/6300KXGwMuxGvL0Jqgqbv2yZjQOA6quyQskK3cec8YRLXwIHduLfhOpMthHXSQ2Trlfj
	RfMY2
X-Gm-Gg: ASbGncvVvf9FORQxgQq3jY2iABz6c3HT4ndOqHipbMdPrGGnJxHNR0aXW4l8mejMbUR
	/gqsHMwdY+XrzklfGcK6T1Gj+tpz9Cvi3Jo7fI7aMosz8f2aBzJas6A2Jaf7UsQ9cRWDesbVXUY
	kl/nUjyNdnvYpY5l2lXoeX7RN7FgXNchPof1kka9XF7eT/yKY7yUegEjaS6SHUiXp4IKeRnlsB5
	dxbuDQd5WBUuXuwj4rljRwvF25Tyzb5UxoYIeOQDYlJFEdXvt5pWWrMY/LjCnaeYftRQHnlUT5L
	9s2FMsLR5/d4CJOVFYmHVWa54NQGNhLfwmolZb19B9Tanq3hIwf/Cv6FVH+g/DGRBkbIjJrGERP
	9dk6zmnzCDuwbajxfj/pi91cML0jnCwUapnC3vmtARMbilw==
X-Google-Smtp-Source: AGHT+IGqaolibMl01HDsfx6w/vwOU7QUB/JY1ULsIM13HTYf1eE/9UqxSorRgHaJZ96041ndQjfP8g==
X-Received: by 2002:a05:6000:2389:b0:3b7:9929:871c with SMTP id ffacd0b85a97d-3e642f90df2mr10709983f8f.37.1757510977136;
        Wed, 10 Sep 2025 06:29:37 -0700 (PDT)
Received: from [10.20.0.214] (ivokam.ddns.nbis.net. [109.121.139.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81fcb04sm28019515e9.8.2025.09.10.06.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 06:29:36 -0700 (PDT)
Message-ID: <b669a4a9-ce0e-4906-96c9-689d69a66c23@suse.com>
Date: Wed, 10 Sep 2025 16:29:32 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/15] x86/mce: Separate global and per-CPU quirks
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-5-eef5d6c74b9c@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250908-wip-mca-updates-v6-5-eef5d6c74b9c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8.09.25 г. 18:40 ч., Yazen Ghannam wrote:
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


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

