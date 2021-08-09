Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A5F3E4AC5
	for <lists+linux-edac@lfdr.de>; Mon,  9 Aug 2021 19:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhHIRZc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Aug 2021 13:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233847AbhHIRZb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Aug 2021 13:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628529910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hTeRlhRqMh8+j3wOmrgr2KjDpOochc5TMrkMztkGvsQ=;
        b=QkraaujTP7EFPmBB47J21E/eVo8x1VYsPZflThzM3GDffDA8Z8kmAqRxrqFUqLg0sANbXU
        JY1xPqrm7VbQlLyU+2feTaC0Y+7CVLOB6XX/ow0aHTEoKVsy4Wy1PvLIzD+pFZGzaOkLP3
        M91d096AZbIfucw4vXfg6V27OD3IvW8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-SjX3tl2gOXK5FND_wb473A-1; Mon, 09 Aug 2021 13:25:09 -0400
X-MC-Unique: SjX3tl2gOXK5FND_wb473A-1
Received: by mail-wm1-f72.google.com with SMTP id y186-20020a1c32c30000b02902b5ac887cfcso5495357wmy.2
        for <linux-edac@vger.kernel.org>; Mon, 09 Aug 2021 10:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hTeRlhRqMh8+j3wOmrgr2KjDpOochc5TMrkMztkGvsQ=;
        b=KbjYMMBLwGnk99NdKi4Xied2hLZRLgxYG82N5Ih3VwK2Cf2saSmdaMNxxpeSKLvePO
         ANa4d65exA410IjnooYQsfSCCKiLjBPB8AY71Kn1FLAZF2dp8Niwd8MlHkd25aZMnuoT
         KGBtT+5M/I5pTAVVnu3Jky16T5DsoyNloHwre/SwX8CcXiMTmhwHhgEg5SisY6VeK0E+
         ocPN8cdn8FNpPGM5bN+vE35fRNYbWWOqqPiGoVPJ1yWLQ0sQEUsaO+KOCbZsOBZdfTuj
         KHwavDMaH6QA4E5kqjP9/QQD/Q9qjDLvg4DXlR073p9wGzxXTMESm8iKc+0isH5O0GMH
         bXFw==
X-Gm-Message-State: AOAM533JlOfXL609JwWNLI2ihih6oZP6HGB1cRG82rdJec6XwAVEGDbS
        jBvFZ/Q7e7y05UGgniqJn3BkWUCq99L1auSjShtWMGtftMQgG2qTK3//2tSQFtKFyqCs5sqVMIm
        CZZYBDZ0uLVJG/LLAKeoQPQ==
X-Received: by 2002:a5d:49c8:: with SMTP id t8mr26061442wrs.365.1628529908240;
        Mon, 09 Aug 2021 10:25:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAHLSPzsnND+hO/zlQTOPI7qReRRIrDoFq5kGbbuFeAXmeig7zcuj0KbapLsDBHAQHngTKyQ==
X-Received: by 2002:a5d:49c8:: with SMTP id t8mr26061423wrs.365.1628529908004;
        Mon, 09 Aug 2021 10:25:08 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id c1sm127690wmp.7.2021.08.09.10.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 10:25:07 -0700 (PDT)
Subject: Re: [patch] x86/pat: pass correct address to sanitize_phys
To:     Jeff Moyer <jmoyer@redhat.com>, dan.j.williams@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <x49tuknmosl.fsf@segfault.boston.devel.redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <6f485d5f-56b6-9397-a368-4e57bb109a9d@redhat.com>
Date:   Mon, 9 Aug 2021 19:25:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <x49tuknmosl.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 21.07.21 21:48, Jeff Moyer wrote:
> memtype_reserve takes an address range of the form [start, end).  It
> then passes the start and end addresses to sanitize_phys, which is meant
> to operate on the inclusive addresses.  If end falls at the end of the
> physical address space, sanitize_phys will return 0.  This can result in
> drivers failing to load:
> 
> [   10.000087] mpt3sas_cm0: unable to map adapter memory! or resource not found
> [   10.000334] mpt3sas_cm0: failure at drivers/scsi/mpt3sas/mpt3sas_scsih.c:10597/_scsih_probe()!
> 
> Fix this by passing the inclusive end address to sanitize_phys.
> 
> Fixes: 510ee090abc3 ("x86/mm/pat: Prepare {reserve, free}_memtype() for "decoy" addresses")
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> --
> It might be worth adding a comment, here.  If there are any suggestions
> on what a sane wording would be, I'm all ears.
> 
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index 3112ca7786ed..482557905294 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -583,7 +583,7 @@ int memtype_reserve(u64 start, u64 end, enum page_cache_mode req_type,
>   	int err = 0;
>   
>   	start = sanitize_phys(start);
> -	end = sanitize_phys(end);
> +	end = sanitize_phys(end - 1) + 1;
>   	if (start >= end) {
>   		WARN(1, "%s failed: [mem %#010Lx-%#010Lx], req %s\n", __func__,
>   				start, end - 1, cattr_name(req_type));
> 
> 

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

