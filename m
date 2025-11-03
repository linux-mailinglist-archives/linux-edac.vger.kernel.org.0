Return-Path: <linux-edac+bounces-5292-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D81C2B93B
	for <lists+linux-edac@lfdr.de>; Mon, 03 Nov 2025 13:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F0DF4E0F34
	for <lists+linux-edac@lfdr.de>; Mon,  3 Nov 2025 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7C0305046;
	Mon,  3 Nov 2025 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HK096hf3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSwwHk5j"
X-Original-To: linux-edac@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CF12F39D0
	for <linux-edac@vger.kernel.org>; Mon,  3 Nov 2025 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171726; cv=none; b=TtAEr8XlipMkNeOYBEmXBadVwOyHJh6qIJDyQ5ORnQ/JjNlVQZ+nejKsLaTwoxrHfSfHa9OmxiD81JgQ2V4aH29BYqvtnfAwzx+kR9kVUa9SPHjDMBAQh63eGWmrizNd9nwEfvOzqUXVPzMcCsVY+eqqrPETOhjph31oHuj44pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171726; c=relaxed/simple;
	bh=JXpVRy5b4T+PPaUtJiNGrC0H6yOvhmCXZ84l2Gwz0M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMRnQgOwdnuVsrjdI0JYs0P5WCSTYR+Tdc07T72c/h+7S/N+VhJ1SB/U/cYG5AkXaXF64AIDJ3VgtOUXGCc5IBeyx8CdhqWkre00+bRBFviBJaDKBPyv/v6rqjDzyIkh/iIkE+QMu4U98KyHNz1s4hlNRj04hAb30UeypEhagLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HK096hf3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSwwHk5j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762171724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cYCA/A3pDMqDmKQxMSerZc0Sd4+MTvVdqogc8ia6KkQ=;
	b=HK096hf3xMWDB7dlq85D1YNAutVbS7FpL2Xz3+EUVJ2Pbli1sjKvCYAb8E77VdFHcRjELr
	0tvvaox7t9GuRIbMHF2Jz6MDaCbBXf1OTOZ3gC/BoqNLDg/MTAjybgo886lhbaYzlaxVeD
	3WyZCzFsS2Ho5guN6iJXShDakP9xtS4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-0rShW7DpPvqy2_g8Xs70sw-1; Mon, 03 Nov 2025 07:08:42 -0500
X-MC-Unique: 0rShW7DpPvqy2_g8Xs70sw-1
X-Mimecast-MFC-AGG-ID: 0rShW7DpPvqy2_g8Xs70sw_1762171721
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429cbd8299cso715108f8f.1
        for <linux-edac@vger.kernel.org>; Mon, 03 Nov 2025 04:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762171721; x=1762776521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cYCA/A3pDMqDmKQxMSerZc0Sd4+MTvVdqogc8ia6KkQ=;
        b=YSwwHk5jWqIzdamlZ7IzmvWwVj2xdt74qX3ckmDBroaSOG8BJm19je8ZnATwfePfCX
         11RFfzlXE45EqtjGZrkbeIdae3sSYQw8Q0cw5F/fkWFH8dowwNqKaonlaUmj4Q8EEDYJ
         /ppzKmWOR8Ht6/385DnYoT+EdP8/wA+DhTGg6ge/WkXnJkiNqG7VHsq88jD+lIUDX2/6
         aLAoFD28EhhGhm4vth9Eh0s56QNHlRU1vFE6JawF7viscZ0AEq6tbp0nL9t29n+fdI2U
         Hwy6kwxsBIpmB9J23rbW5ZRLRWoWj2PwDepfUGb1khl7M5oDAsfrzDsErGVDI3W/YnRH
         zGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762171721; x=1762776521;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYCA/A3pDMqDmKQxMSerZc0Sd4+MTvVdqogc8ia6KkQ=;
        b=oH0lW202em7M+YauLX401uS+u3t0LHkWfCqto24iiwW1s7wJnXY0ZbRuzmwiLd/v8U
         hpcmhkeg2PXxTlmhxWIAQx6tpGLu8Txkt1osqRLcr5pzJcGEHjwAkRUO5MES1A/8pB3N
         aYKwYnOHjzG2eYG9qNyC3WFKwem1Mq8cvJboQLpVr+aQeQLmcGEV+tZR+pyXwsklFiHR
         CX1yZaicYLI/oM3HfGGppf7yli2Sn4tm2xgqnZEuCvxLFxO1ey4zuS7kKs69YzuCzw9O
         ohq+ZIpqhkL5bOeeesZWYfbnH4myeMeLLknTCANVx/jeWuWvOVUJhm0Is1e5hHYsjxxm
         TGTA==
X-Forwarded-Encrypted: i=1; AJvYcCVZVCc6eszStXsQepkNLGKAdIg3AAYTF5Q+l1FGX4LTxNo3rk451Rh8SajAwo4K5enhxvKjQsNbJtn7@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh4SQfJNaW02RRNJqfwEp/CL+0Er41mDUsKYQgoL67HZzf4o/0
	mzHYvH0Cs9wmfPlHxUcO8yAditiYsIAkb5ZEiQoyFUnfuRQtraSq2BOx4jnahzFHdGSuD3JMQIN
	LjGtOaSQPDcKT8YvK8lpNAbYypxr3vAwJ/Chb6rKxqV6KalEYMadbdDTrAIZdwCE=
X-Gm-Gg: ASbGncsvUyzTEcAtBF7mMbHJTO+K6akp3VLfrMvDG06jVXscCIv0+Ekh1/54Ch1I78k
	oRVYP80xkYDx8WQsg50ADsEXn2VPrisFfUBiy2KgxoxNL06O2CSTEYND3AKCo7SOfKR+VZqMvQe
	nqsaFp8C7l+HSaVrpM8HNj8TVWssJvNcNwQWO9PW0CC59C02YUCMIa8ua2+2MGQ1ihJVI3sNM4i
	EBeDAuQ8wKa/JYrXbRtOnUfRFzp4bpA/nN60EFxeDG6efb9+zTTKHhaGnyO6QOS9/BN/ndhEprC
	pbsUtCW5uL/KXuqkImmvngjfdGAMXW0DqQidGp3pVIiIKaJMyAOEK+21Z+94qnAr5mqRgODTfmk
	V+pwFsgfEVfDPs4QCULZh1+wOB9jDVJEHke7L5nY0Kq8s8nZPd1KOBRY2EeQUSJyzage2vkZjYz
	mng8cAU7ZAdmI1dp5iN1tapJB6cBc=
X-Received: by 2002:a05:6000:250a:b0:429:d0ba:f002 with SMTP id ffacd0b85a97d-429d0baf1cemr3808941f8f.51.1762171721567;
        Mon, 03 Nov 2025 04:08:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFORN35rwn/ZHqlzoFuluITkWiBVqUu+wEC5M9/kjlhkeFWf7xzY34hBJFVBj9s+pvDlX+lHQ==
X-Received: by 2002:a05:6000:250a:b0:429:d0ba:f002 with SMTP id ffacd0b85a97d-429d0baf1cemr3808909f8f.51.1762171721096;
        Mon, 03 Nov 2025 04:08:41 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429d1a77614sm7726647f8f.21.2025.11.03.04.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 04:08:40 -0800 (PST)
Message-ID: <5ace86cc-0b2d-4306-8bc1-dfc34cccef1a@redhat.com>
Date: Mon, 3 Nov 2025 13:08:38 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/mm: support memory-failure on 32-bits with
 SPARSEMEM
To: Xie Yuanbin <xieyuanbin1@huawei.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linmiaohe@huawei.com, nao.horiguchi@gmail.com,
 luto@kernel.org, peterz@infradead.org, tony.luck@intel.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-edac@vger.kernel.org, will@kernel.org, liaohua4@huawei.com,
 lilinjie8@huawei.com
References: <20251103033536.52234-1-xieyuanbin1@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251103033536.52234-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.11.25 04:35, Xie Yuanbin wrote:
> The historical commit d949f36f1865c60239d4 ("x86: Fix hwpoison code
> related build failure on 32-bit NUMAQ"), disabled x86_32's
> memory-failure when SPARSEMEM is enabled, because the number of
> page-flags are insufficient.
> 
> The commit 09022bc196d23484a7a5 ("mm: remove PG_error") removes a
> page flag, so memory-failure can now be enable now.

In the meantime, we added PG_dropbehind

-- 
Cheers

David / dhildenb


