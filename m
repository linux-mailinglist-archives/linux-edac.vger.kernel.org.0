Return-Path: <linux-edac+bounces-4703-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151B6B3AB71
	for <lists+linux-edac@lfdr.de>; Thu, 28 Aug 2025 22:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A72A02BA5
	for <lists+linux-edac@lfdr.de>; Thu, 28 Aug 2025 20:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEA7274FF2;
	Thu, 28 Aug 2025 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjfZ587K"
X-Original-To: linux-edac@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B472D278E7E
	for <linux-edac@vger.kernel.org>; Thu, 28 Aug 2025 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412209; cv=none; b=Cnt0zSBxj3KLnaRe+lutPYflt6tZPwBb8MMutJNxhqHARuG06vuTqhdK6f9vGhuk9DBizLXyZ6NE5OjKIP6Wux7lGUytjJbCuEqM6DJ6OxFppU5Np7mE37/WkwmOcJkLZB7UhnqYrddNMnYz1I1Ug+qPJq2oX3cGwWOG3n1SbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412209; c=relaxed/simple;
	bh=omStx6Vdan48sEm8PL/UoDjYdWtcY6Lxj4Ld5gcz9Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snfRxyMkM0iS/Aqp63phu0mArTN68FAg2sW59rW05LWmiwsgqz8so3AKEb20banmDEn3ncMCbmbErgm+Yx8rL26CZuasN1Jn4fMG7PmDa2tz6eb/g48JAJcQBRypVJa/eFRynNwzBuCMAuzMkNnhZS0mED4HB03AW3XakPRmVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjfZ587K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756412206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+uwHlyQ6LciyyA2ZqVWztkqsrihdSVO7uAsTz06acTE=;
	b=GjfZ587K5sMopN56fcfJksmu36VuWTKiX33SBkkNKRJykR+Y/QvLb6ILf3kMfqz+c/r0o2
	dGmOAZT6VbjYnJuSRZ9PwaJXkbTmKEioh6n4C87uCq62vfJXZXojHdhv7t1PDzCNd34jTX
	7hGK8AcRAY/pmnJp+P1xLbT9PaGe5ZM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-u8FIt5q9NuajlYaaigZC7Q-1; Thu, 28 Aug 2025 16:16:45 -0400
X-MC-Unique: u8FIt5q9NuajlYaaigZC7Q-1
X-Mimecast-MFC-AGG-ID: u8FIt5q9NuajlYaaigZC7Q_1756412204
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b7d485153so5518155e9.0
        for <linux-edac@vger.kernel.org>; Thu, 28 Aug 2025 13:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756412204; x=1757017004;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uwHlyQ6LciyyA2ZqVWztkqsrihdSVO7uAsTz06acTE=;
        b=r2hMy5H8nFr0OSVLurnkgpE1x7D6s9fFlbaX8P5MttrePmCWbWwyN1wK+Vv7NYaE+d
         BtAkhOfm0k40+40dPMPeFqNkxANhoUiiuxDfs7Kel8Zj9MDiKtUG/j6sbxIyY7+grfwQ
         OIzOu9UTajKeZ5sevnudVaktDCegcrWM/PBmNxb9lQTl6pg1RzA9o7+2WzSs2m8QyNsq
         iF35DV5zDxd+fk8OAbMNvdVCammEryuP92kUIf+94jQAq4omfyDcFq/xV8g5oOSxBT5V
         aoGVAZFKUjCKeJteudw7WwHsFUfY63yYDAztMRHhg+6D4+LVrT4Yac+VanhXygggRiJp
         Q71A==
X-Forwarded-Encrypted: i=1; AJvYcCW3TmMuXeieK3yBsvuWFUHJvyJ5/JuooVePpNN2V36qP3MNpjad5O2PKkPxgEZtWkkM0qwHy6UHmaeT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxabz+zgpA5Uo3YMou3bUkURFN/GRWJ/JXacBFKlBVvtyymMuR
	SttkNE9k5SohVoFQ1l5uJv7GmOH2ouQW5wsdnm8ssN3+JMAJSgZyJzXxcIIVZMGGjcWq6ezZoC2
	i3+vBEJnwyxxivC1sCibW6o0nGxx3crxJ3FI2aPg5Pf6o8fmY3sV/kkMAIgS6OZs=
X-Gm-Gg: ASbGncvx9/g8ShOdWanrOurdS0uErIv4sd7z4atSMNb+38xNsMcHWxKpHhoeXwQlfyt
	/W9Jwpfdlj4GyS+tYgByyb8j8Wwf4/KA3Ae/Q2oFF9huuknyPwllE1s/4wFJOcdQ/U6LhzNfXgB
	wnrWDOFgjPQaxz4sEIHhTPREddpe2IhVCWIkdL050iS3xtVw2EK+Gk+ZYk6G4f+t5GtAjedbl04
	PcnCgeNt/zYX3Gfw8wuFgockB6zLowLIm8PK/Tg0rOH1NTjEhGDJfeASRL/c0ypn5rI509rK2ce
	JRPFyQIMUV2Bm5tGIQB/uZSg/dW7KAzAdYLT9rYQaQodvOj9B716ndj3qZ5fZoDaTo/NvyDuqDM
	sVLHyBXrB+JM0ZuV4dya9DWA0BE0zBprAIA20qCjjh6AB7wwmCVOSfiIKb2Ud3xSIdyU=
X-Received: by 2002:a05:600c:444f:b0:458:a847:671e with SMTP id 5b1f17b1804b1-45b517d402cmr220840515e9.23.1756412203980;
        Thu, 28 Aug 2025 13:16:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFop3NDQa/jvUw/7iAhPc6xPyo6DCTowuFm5PMXVJXqUwMAoM+eWtpd9lIdKLYbcTafxwGkzg==
X-Received: by 2002:a05:600c:444f:b0:458:a847:671e with SMTP id 5b1f17b1804b1-45b517d402cmr220840175e9.23.1756412203527;
        Thu, 28 Aug 2025 13:16:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:c100:2225:10aa:f247:7b85? (p200300d82f28c100222510aaf2477b85.dip0.t-ipconnect.de. [2003:d8:2f28:c100:2225:10aa:f247:7b85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f3125ccsm87282945e9.19.2025.08.28.13.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:16:41 -0700 (PDT)
Message-ID: <c5d42263-7256-4be2-ab12-13cab0320ef4@redhat.com>
Date: Thu, 28 Aug 2025 22:16:39 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory-failure: Fix redundant updates for already
 poisoned pages
To: Kyle Meyer <kyle.meyer@hpe.com>, akpm@linux-foundation.org,
 linmiaohe@huawei.com, jane.chu@oracle.com, jiaqiyan@google.com
Cc: bp@alien8.de, Liam.Howlett@oracle.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, mhocko@suse.com, nao.horiguchi@gmail.com,
 osalvador@suse.de, rppt@kernel.org, russ.anderson@hpe.com,
 surenb@google.com, tony.luck@intel.com, vbabka@suse.cz
References: <aLCiHMy12Ck3ouwC@hpe.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aLCiHMy12Ck3ouwC@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 20:38, Kyle Meyer wrote:
> Duplicate memory errors can be reported by multiple sources.
> 
> Passing an already poisoned page to action_result() causes issues:
> 
> * The amount of hardware corrupted memory is incorrectly updated.
> * Per NUMA node MF stats are incorrectly updated.
> * Redundant "already poisoned" messages are printed.
> 
> Avoid those issues by:
> 
> * Skipping hardware corrupted memory updates for already poisoned pages.
> * Skipping per NUMA node MF stats updates for already poisoned pages.
> * Dropping redundant "already poisoned" messages.
> 
> Make MF_MSG_ALREADY_POISONED consistent with other action_page_types and
> make calls to action_result() consistent for already poisoned
> normal pages and huge pages.
> 
> Fixes: b8b9488d50b7 ("mm/memory-failure: improve memory failure action_result messages")
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
> 
> v1 -> v2:
>   * Continue passing poisoned pages to action_result() with MF_FAILED but don't
> update anything.
>   * https://lore.kernel.org/all/20250821164445.14467-1-kyle.meyer@hpe.com
> 
> ---
>   mm/memory-failure.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fc30ca4804bf..10b3c281c2ae 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -956,7 +956,7 @@ static const char * const action_page_types[] = {
>   	[MF_MSG_BUDDY]			= "free buddy page",
>   	[MF_MSG_DAX]			= "dax page",
>   	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
> -	[MF_MSG_ALREADY_POISONED]	= "already poisoned",
> +	[MF_MSG_ALREADY_POISONED]	= "already poisoned page",
>   	[MF_MSG_UNKNOWN]		= "unknown page",
>   };
>   
> @@ -1349,9 +1349,10 @@ static int action_result(unsigned long pfn, enum mf_action_page_type type,
>   {
>   	trace_memory_failure_event(pfn, type, result);
>   
> -	num_poisoned_pages_inc(pfn);
> -
> -	update_per_node_mf_stats(pfn, result);
> +	if (type != MF_MSG_ALREADY_POISONED) {
> +		num_poisoned_pages_inc(pfn);
> +		update_per_node_mf_stats(pfn, result);
> +	}
>   
>   	pr_err("%#lx: recovery action for %s: %s\n",
>   		pfn, action_page_types[type], action_name[result]);
> @@ -2094,12 +2095,11 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>   		*hugetlb = 0;
>   		return 0;
>   	} else if (res == -EHWPOISON) {
> -		pr_err("%#lx: already hardware poisoned\n", pfn);
>   		if (flags & MF_ACTION_REQUIRED) {
>   			folio = page_folio(p);
>   			res = kill_accessing_process(current, folio_pfn(folio), flags);
> -			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>   		}
> +		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);

Was briefly confused by that change, but action_result() now essentially 
only traces + pr_err() with MF_MSG_ALREADY_POISONED.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


