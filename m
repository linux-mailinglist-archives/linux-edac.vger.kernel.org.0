Return-Path: <linux-edac+bounces-1124-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E82078CE787
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 17:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA33282951
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 15:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C8612D214;
	Fri, 24 May 2024 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEqdJmya"
X-Original-To: linux-edac@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1E12D1EA
	for <linux-edac@vger.kernel.org>; Fri, 24 May 2024 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563178; cv=none; b=AUk76YQlYLMASgXGrfiu6j+k6EOpBlfvT0vL6Bm6xvNHi3dmNO+WV31fFVDJPHBtCzYoXFn8LpUAvsuSihofg0haHDSXLe1ALaMrXogdfblnqR1MtpDUXC+rmT41IVfrRmFraK0dWT4bfy5Zk5UfektAIIGryrusHNJi4Gh/pkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563178; c=relaxed/simple;
	bh=7jEQdSU7Rg63/C2v0Z0arE+Uxrcq0NTUUdiTgoLsLdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/IRPfVCpk38dw+cKjOF0shrYNNWMGJz9IK8+m2REFYuXW8/wqEpUwmOlaI2Lniqu5WCSKoJETEWouEP5YYiQ81kWIiGspwcy/2j1sSbEcjwaHTW1flCo6yENr8E6PCC+dhP+Qzbl16EPo0pQCOvKTWh6LuqMbIOaPLs739EPHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IEqdJmya; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716563176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I1BCpL/PStPCH7MJBW+moVlonxUq2Qtd0gJwH5QgdVc=;
	b=IEqdJmyaOSDj3zA2NM/5EO1lyBRpBG3Umxv+gYB+vn4w5GQWn6rxza81mttNUQcLI3OHQm
	lRpToNaSLNuOjeZOinUMRhojwKv+BMHBfDSXUpz7bZz3QfGCOj6mf7HgFC2WJQd55bgO1P
	4fEZ45Ld2sDBQOAdBXBcSL0wJFSweTI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-3BlWYJjcOcaltBL95gyrNA-1; Fri, 24 May 2024 11:06:14 -0400
X-MC-Unique: 3BlWYJjcOcaltBL95gyrNA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41fc6a4f513so1888275e9.0
        for <linux-edac@vger.kernel.org>; Fri, 24 May 2024 08:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716563173; x=1717167973;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I1BCpL/PStPCH7MJBW+moVlonxUq2Qtd0gJwH5QgdVc=;
        b=Y/z1y2Mx/ZdJl/tAFzbwz9k4Q3k4EbeCRZ0jI4XPVPt3+h2NUt/Z/PCd9li36Op0Pz
         8+ldkOIEVgmGTllW1G6yNxd0BosJiDT/w3FVsy+D1DPVO4jkRt0NLXcJpuH1gmhVKmDd
         FCzRaZfMQ5JfbQ+iQVrCl5ZOw2a5LhN1JaW7UEG1FOG2p4Fly6cVK5buiPMxgONdDl+B
         wFraBx6sMn4GvGo+oofyRXDvLKztfnK0YeZMJLBRWp5ZdTiikgkCXK/WxyX9K5Ij61VC
         vE/WheUpZNtpCQ+rwbgos3ogv1+p3J2DCdT/VUi4dsdQ2DDiLtOF0Dg3lKO/TSs/eA1U
         l7xA==
X-Forwarded-Encrypted: i=1; AJvYcCXH4mIqIRctq/1UNVwQQK23fiP7iVDc/owjJDUW2UFmyewqJcOe9G/RVrHPRHXqkSwTXuhZXwNV/WzijCW9R1HAjGnWe6DEeWstyQ==
X-Gm-Message-State: AOJu0YyupCPNaDRkIynjot92X9IyAQnQjRYaPqS8Irhp6I8k18c0DpRn
	H3PqHrSdSmt5n/kRsYUhoHR8rQAeh/OMib4v++wxJbxB/dw+0uFquhfBuU7AzIIBDpaoeQdoE4g
	WWHGv/LBcsXDBexFI12X7W8xzftZuG7jVyI8dvCu92XkBgMDBzRCOcSBDDIM=
X-Received: by 2002:a05:600c:358b:b0:418:7ec1:7bdb with SMTP id 5b1f17b1804b1-421015ae128mr52793155e9.5.1716563173601;
        Fri, 24 May 2024 08:06:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiU9+kaG5yUruAptWc0nWWtPse7n1sPHrG9uGZZ4QrNbQYAhHC77nqCz1rYW+K7Lp9HD7z6w==
X-Received: by 2002:a05:600c:358b:b0:418:7ec1:7bdb with SMTP id 5b1f17b1804b1-421015ae128mr52792805e9.5.1716563173120;
        Fri, 24 May 2024 08:06:13 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089cc4e2sm22879045e9.39.2024.05.24.08.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 08:06:12 -0700 (PDT)
Message-ID: <65447480-f46f-4256-a093-f8232fb6ed84@redhat.com>
Date: Fri, 24 May 2024 17:06:11 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] mm/memory-failure: save a page_folio() call
To: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
 tony.luck@intel.com, bp@alien8.de
Cc: nao.horiguchi@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
References: <20240524091310.1430048-1-linmiaohe@huawei.com>
 <20240524091310.1430048-5-linmiaohe@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240524091310.1430048-5-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.05.24 11:13, Miaohe Lin wrote:
> Use local variable folio directly to save a page_folio() call.
> No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/memory-failure.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index b571aaf987a2..73878ecdec22 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1658,7 +1658,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
>   	unmap_success = !page_mapped(p);

We should be using folio_mapped() here.

>   	if (!unmap_success)
>   		pr_err("%#lx: failed to unmap page (folio mapcount=%d)\n",
> -		       pfn, folio_mapcount(page_folio(p)));
> +		       pfn, folio_mapcount(folio));

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


