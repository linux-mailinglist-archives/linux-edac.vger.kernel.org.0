Return-Path: <linux-edac+bounces-1125-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C688CE78A
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 17:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 624F0B22544
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 15:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7C712D1E9;
	Fri, 24 May 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCbC7Ozl"
X-Original-To: linux-edac@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04ED12CDBA
	for <linux-edac@vger.kernel.org>; Fri, 24 May 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563204; cv=none; b=YlFD4z+cPa3RUw9ZQ/m1lnHaVFIi88y6q2nPKUkxv0S6F56iPOsbiqr9R1Rgzd1eFFXH3rlRNZ9Geu0Wbq+OjdYu3YTf46+SEfGcAP4cgtlKbw+PDVUGpbhCDlPGuGgmH+Jwp1YcdgtMwbPirmAyE/H0/6aI3J+rlo010MU1lUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563204; c=relaxed/simple;
	bh=9U+I+3UvUYJ5TOhbk28BWESWOvCg3Hz3YAevF5AWKgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ow5O8zw7aBLZn5Kfva0kr4Bx8nnEMrQxDNnhN44731ByrbyjGy+q1qfmVVjcbsJUGvKpM3j99wHkmVc5tIbDxNaqrnIVBY068Zeiu+9cPKXTTJdTLE+hGt/AJwb5sIKcSnRO7vwZefRvaTKgK3KubyThfygZlGRFRyMXVEZHz0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCbC7Ozl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716563201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jEzeUmdMITBKrrK64NgaWJvJ6PGeqKr9vTpwhksm3mY=;
	b=hCbC7OzlcKgRRaSY/NB8JIIrQ/C5fsQ7o/o+IvMKYXH5TMcGBns/Rwjb48pChCSv0ZioPb
	gzpS525TQrmEDHGyFk4wmHDosDXJX4f9ibBA/k09i9bMcG2hhw1DkwSgdA5ihiAfLvVFqV
	biRI4jyDR6Rs9acboSC7unAZPVSQ2g0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-WNN_25dkMTSrofpUZ8C_Eg-1; Fri, 24 May 2024 11:06:39 -0400
X-MC-Unique: WNN_25dkMTSrofpUZ8C_Eg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2e7185089daso19385601fa.3
        for <linux-edac@vger.kernel.org>; Fri, 24 May 2024 08:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716563198; x=1717167998;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEzeUmdMITBKrrK64NgaWJvJ6PGeqKr9vTpwhksm3mY=;
        b=gFth1Lc5vReABMjh8bmIBuyPExXTNV2SQLgmdlSn+mqjyi5GOEQpabIS2pSNieWzd4
         Vlkqz4KB4dMv15z4aBcsMI9kWiaqvBsNHjtwZIaOMZoyrfZIS2o/nXCaztU3zhKl7LBb
         Xe8WY+FpSzadKsjI+REPk9Tae15xSlTMnYoNZcXABBswzSY+gwpfMve/dz5ikAK55ksU
         ojx85aYBRdjaNnLc15xq/baCxT1cE7xIZDVo82+0yuY67zwNLPdALDHDqrisXDHtLJ5R
         v/1ZemfAfLPBQU55kuhFfxnkOqndWCDawfjLRaRf+P0rMoyIDvtDKhguQlqfJ6I0Gz86
         n4oA==
X-Forwarded-Encrypted: i=1; AJvYcCWPZv6RqQ5zSYjnZnwxCREEWeyFeb4Jjd0mgDhCS4CjYJC0HonkWJ6mJGXUg1z7uNT16Jbr68ZqEsG593QC6mmi61aXWADl5d+Hbg==
X-Gm-Message-State: AOJu0YwUXAYPp3USgpaHkF2wRaVxoj1T7TyEOAZrGW5hHOhorw5aNpJe
	o1B4FOXqiITQAjyzdTjwi0Xf/iZfDAzU1IQD1dtpukTw7a+ItJnLbX+p93Vj9NPNd+5KZ9zIM1U
	2bTq+bmVl0SV/SIwnQkSnFByFYZDCz6I+6heZt1g/AfGb8/9lmLIcXyozRkU=
X-Received: by 2002:a2e:9e9a:0:b0:2e1:5644:24e7 with SMTP id 38308e7fff4ca-2e95b1cbdd2mr14931341fa.13.1716563198091;
        Fri, 24 May 2024 08:06:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgVAO8a8+GpE50ED3afdkRmdjzibIG4w46Bmqk+wo1oLzofJQBLswBxjKT8Kl9N8FxBnAmOA==
X-Received: by 2002:a2e:9e9a:0:b0:2e1:5644:24e7 with SMTP id 38308e7fff4ca-2e95b1cbdd2mr14931141fa.13.1716563197635;
        Fri, 24 May 2024 08:06:37 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7dba2sm1797507f8f.17.2024.05.24.08.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 08:06:37 -0700 (PDT)
Message-ID: <93f3b2cb-7f79-4556-b3de-1aee015a2382@redhat.com>
Date: Fri, 24 May 2024 17:06:36 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] mm/memory-failure: remove obsolete comment in
 unpoison_memory()
To: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
 tony.luck@intel.com, bp@alien8.de
Cc: nao.horiguchi@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
References: <20240524091310.1430048-1-linmiaohe@huawei.com>
 <20240524091310.1430048-10-linmiaohe@huawei.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240524091310.1430048-10-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.05.24 11:13, Miaohe Lin wrote:
> Since commit 130d4df57390 ("mm/sl[au]b: rearrange struct slab fields to
> allow larger rcu_head"), folio->_mapcount is not overloaded with SLAB.
> Update corresponding comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/memory-failure.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 19d338e83e43..e4252f297d41 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2610,10 +2610,6 @@ int unpoison_memory(unsigned long pfn)
>   	    folio_test_reserved(folio) || folio_test_offline(folio))
>   		goto unlock_mutex;
>   
> -	/*
> -	 * Note that folio->_mapcount is overloaded in SLAB, so the simple test
> -	 * in folio_mapped() has to be done after folio_test_slab() is checked.
> -	 */
>   	if (folio_mapped(folio)) {
>   		unpoison_pr_info("Unpoison: Someone maps the hwpoison page %#lx\n",
>   				 pfn, &unpoison_rs);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


