Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6181F7AE900
	for <lists+linux-edac@lfdr.de>; Tue, 26 Sep 2023 11:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjIZJ0n (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Sep 2023 05:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjIZJ0m (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 26 Sep 2023 05:26:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1B611D
        for <linux-edac@vger.kernel.org>; Tue, 26 Sep 2023 02:26:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32008e339adso7783827f8f.2
        for <linux-edac@vger.kernel.org>; Tue, 26 Sep 2023 02:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1695720392; x=1696325192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kmbdPGVs/W/K0GplugB5QvWG9QUiEtGu9P+FlblHW9s=;
        b=omASNCkvQh8ogDycK6NS67DjKJ9uzDzUSm5qj2PQ42ShbFSp0GjTT1kFT9G8h/y/NP
         CmD6FuqIQ10+Z9raam3r4/NqUsq7eXuiu9uvf3msORuxNCoxvZ96rhuaJz3VgwGB4Vth
         vUHV0Rs+bmjfVjEuTYRdZ6Py8lkOBcJCj+6iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695720392; x=1696325192;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmbdPGVs/W/K0GplugB5QvWG9QUiEtGu9P+FlblHW9s=;
        b=UWFbSF9WOiHv/JoaQbRC7ioTji0R82OeC9Gok0ABghd4XjhqFYrsOJiiy9vpZ7JZ4Y
         p7Rs1Yog8CadcCht6G2ABZEH4hu7dSq7Qcl614RF7/8gbcdgKdKM6MomYiQcOpUVUUxZ
         f8vPXMi+kmCUK952I8qYSOrF5vfwZmpI8p7O/dGkc2VP0UVAPERAnRQnnHa6QE4OPvwW
         ONT8HqVLqw33D0qIQw51VrABbwodrSK5305hpWxZdsVwoxNnQZBP0jsxr0sNxlQ9KllZ
         3x4UEmhWrZzIKWzRZIRQPLT+cTyHJSsczhuPXy6IebJwRfNi01IFpS4vLgsBsXe7zpbe
         9dlQ==
X-Gm-Message-State: AOJu0Yw4E/yO6AxTE8fOfoHEk1Mo6XhoJyby4havLSYJaomec/oZlm1I
        4pUBbwtCJKv74E57HR6uK/aiUg==
X-Google-Smtp-Source: AGHT+IGgfHuuM6+TDVmgDCR6/9jB/xVFtYMos7qI/oRqScsqgBiOvBrkuPDQ8QUbO3jvp1Bf0T5msA==
X-Received: by 2002:a5d:44ca:0:b0:31f:fdd8:7d56 with SMTP id z10-20020a5d44ca000000b0031ffdd87d56mr8037098wrr.12.1695720392647;
        Tue, 26 Sep 2023 02:26:32 -0700 (PDT)
Received: from [10.80.67.28] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id o5-20020adfeac5000000b0031984b370f2sm14100219wrn.47.2023.09.26.02.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 02:26:32 -0700 (PDT)
Message-ID: <6e0064bc-65c1-24f5-c29d-c1d1c027e2d3@citrix.com>
Date:   Tue, 26 Sep 2023 10:26:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   andrew.cooper3@citrix.com
Subject: Re: [PATCH v11 05/37] x86/trapnr: Add event type macros to
 <asm/trapnr.h>
Content-Language: en-GB
To:     Nikolay Borisov <nik.borisov@suse.com>, Xin Li <xin3.li@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, pbonzini@redhat.com, seanjc@google.com,
        peterz@infradead.org, jgross@suse.com, ravi.v.shankar@intel.com,
        mhiramat@kernel.org, jiangshanlai@gmail.com
References: <20230923094212.26520-1-xin3.li@intel.com>
 <20230923094212.26520-6-xin3.li@intel.com>
 <7acd7bb3-0406-4fd9-8396-835bfd951d87@suse.com>
In-Reply-To: <7acd7bb3-0406-4fd9-8396-835bfd951d87@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 26/09/2023 9:10 am, Nikolay Borisov wrote:
> On 23.09.23 г. 12:41 ч., Xin Li wrote:
>> diff --git a/arch/x86/include/asm/trapnr.h
>> b/arch/x86/include/asm/trapnr.h
>> index f5d2325aa0b7..8d1154cdf787 100644
>> --- a/arch/x86/include/asm/trapnr.h
>> +++ b/arch/x86/include/asm/trapnr.h
>> @@ -2,6 +2,18 @@
>>   #ifndef _ASM_X86_TRAPNR_H
>>   #define _ASM_X86_TRAPNR_H
>>   +/*
>> + * Event type codes used by FRED, Intel VT-x and AMD SVM
>> + */
>> +#define EVENT_TYPE_EXTINT    0    // External interrupt
>> +#define EVENT_TYPE_RESERVED    1
>> +#define EVENT_TYPE_NMI        2    // NMI
>> +#define EVENT_TYPE_HWEXC    3    // Hardware originated traps,
>> exceptions
>> +#define EVENT_TYPE_SWINT    4    // INT n
>> +#define EVENT_TYPE_PRIV_SWEXC    5    // INT1
>> +#define EVENT_TYPE_SWEXC    6    // INTO, INT3
>
> nit: This turned into INTO (Oh) rather than INT0( zero) in v11

Yes, v11 corrected a bug in v10.

The INTO instruction is "INT on Overflow".  No zero involved.

INT3 is thusly named because it generates vector 3.  Similarly for INT1
although it had the unofficial name ICEBP long before INT1 got documented.

If INTO were to have a number, it would need to be 4, but it's behaviour
is conditional on the overflow flag, unlike INT3/1 which are
unconditional exceptions.

~Andrew
