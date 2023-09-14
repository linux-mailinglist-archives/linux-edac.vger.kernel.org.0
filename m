Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD3D7A06D9
	for <lists+linux-edac@lfdr.de>; Thu, 14 Sep 2023 16:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbjINOFu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Sep 2023 10:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjINOFt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Sep 2023 10:05:49 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50CF1FD6
        for <linux-edac@vger.kernel.org>; Thu, 14 Sep 2023 07:05:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-404314388ceso8343525e9.2
        for <linux-edac@vger.kernel.org>; Thu, 14 Sep 2023 07:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1694700343; x=1695305143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4vYOPKXU60d+VwTOR7zcpHoS7EW3RwNwXYL0thebH04=;
        b=BP6Wcb2AOM+ZA1fjpijwFsP3sdHAJoKEYJJcOiEAuw9Bv5822B60aaTu/r1wMLw38r
         2QIMywqGQDP5+byc5UXoS/bedwfxn27igOXZukvL3E96JQI+CJ4/JdA+eludBI2x8sDH
         LkYwexu+hF0RruyxCEybcA2ChsTCmNRU56SmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694700343; x=1695305143;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vYOPKXU60d+VwTOR7zcpHoS7EW3RwNwXYL0thebH04=;
        b=QLPpWdglBQNOSlN5mfqvkfgyQOF1lMRQ/sVLAbKnaGayS7eTRA4K3f7IWkn9T9L4Fh
         PrC3R8dI8ehxxl63rM2a348lUBe54rusWk3kbLKa6+Ln0QGjxYTW8S2FxoqgAMf2HrAM
         bcHIr1oMIYTQRKIPF+/EQVay7mk2AILHXXLvQdtPwH9m8lkrvvNsdN/4sjdH2RBqNSG/
         buGMCnXdZdsV97qMxB9v3rulEafO0+KbGFMPPJ9ig20NVoyRXheDoxG3cc/ELswC7OX0
         utACWx2t6y1PjJXlQCJZ1YlthbO+N8sk2YyqzoVomQxiIvjz8ZGIAVfp5w1AUjYxeemb
         hl3g==
X-Gm-Message-State: AOJu0YxIcHvvC6VjWzjIvUGccc5F8KQA+oDTfV1s1cKikb0X0m88pcop
        I88mNwrHPYP1KpwdROOiAFRFmA==
X-Google-Smtp-Source: AGHT+IEyocHSn+uMmNECVz8ii8zQMuIDZmm28KTVIUinAogCrqYkG9ProhxotsEPQjJrSGm8ruhh3w==
X-Received: by 2002:a7b:c44b:0:b0:3f7:f2d0:b904 with SMTP id l11-20020a7bc44b000000b003f7f2d0b904mr4542256wmi.8.1694700342824;
        Thu, 14 Sep 2023 07:05:42 -0700 (PDT)
Received: from [10.80.67.28] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id z16-20020adfe550000000b0031980294e9fsm1839303wrm.116.2023.09.14.07.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 07:05:42 -0700 (PDT)
Message-ID: <6f5678ff-f8b1-9ada-c8c7-f32cfb77263a@citrix.com>
Date:   Thu, 14 Sep 2023 15:05:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   andrew.cooper3@citrix.com
Subject: Re: [PATCH v10 03/38] x86/msr: Add the WRMSRNS instruction support
Content-Language: en-GB
To:     Xin Li <xin3.li@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, pbonzini@redhat.com, seanjc@google.com,
        peterz@infradead.org, jgross@suse.com, ravi.v.shankar@intel.com,
        mhiramat@kernel.org, jiangshanlai@gmail.com
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-4-xin3.li@intel.com>
In-Reply-To: <20230914044805.301390-4-xin3.li@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 14/09/2023 5:47 am, Xin Li wrote:
> Add an always inline API __wrmsrns() to embed the WRMSRNS instruction
> into the code.
>
> Tested-by: Shan Kang <shan.kang@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>
> ---
>  arch/x86/include/asm/msr.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> index 65ec1965cd28..c284ff9ebe67 100644
> --- a/arch/x86/include/asm/msr.h
> +++ b/arch/x86/include/asm/msr.h
> @@ -97,6 +97,19 @@ static __always_inline void __wrmsr(unsigned int msr, u32 low, u32 high)
>  		     : : "c" (msr), "a"(low), "d" (high) : "memory");
>  }
>  
> +/*
> + * WRMSRNS behaves exactly like WRMSR with the only difference being
> + * that it is not a serializing instruction by default.
> + */
> +static __always_inline void __wrmsrns(u32 msr, u32 low, u32 high)
> +{
> +	/* Instruction opcode for WRMSRNS; supported in binutils >= 2.40. */
> +	asm volatile("1: .byte 0x0f,0x01,0xc6\n"
> +		     "2:\n"
> +		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
> +		     : : "c" (msr), "a"(low), "d" (high));
> +}
> +
>  #define native_rdmsr(msr, val1, val2)			\
>  do {							\
>  	u64 __val = __rdmsr((msr));			\
> @@ -297,6 +310,11 @@ do {							\
>  
>  #endif	/* !CONFIG_PARAVIRT_XXL */
>  
> +static __always_inline void wrmsrns(u32 msr, u64 val)
> +{
> +	__wrmsrns(msr, val, val >> 32);
> +}

This API works in terms of this series where every WRMSRNS is hidden
behind a FRED check, but it's an awkward interface to use anywhere else
in the kernel.

I fully understand that you expect all FRED capable systems to have
WRMSRNS, but it is not a hard requirement and you will end up with
simpler (and therefore better) logic by deleting the dependency.

As a "normal" user of the WRMSR APIs, the programmer only cares about:

1) wrmsr() -> needs to be serialising
2) wrmsr_ns() -> safe to be non-serialising


In Xen, I added something of the form:

/* Non-serialising WRMSR, when available.  Falls back to a serialising
WRMSR. */
static inline void wrmsr_ns(uint32_t msr, uint32_t lo, uint32_t hi)
{
    /*
     * WRMSR is 2 bytes.  WRMSRNS is 3 bytes.  Pad WRMSR with a redundant CS
     * prefix to avoid a trailing NOP.
     */
    alternative_input(".byte 0x2e; wrmsr",
                      ".byte 0x0f,0x01,0xc6", X86_FEATURE_WRMSRNS,
                      "c" (msr), "a" (lo), "d" (hi));
}

and despite what Juergen said, I'm going to recommend that you do wire
this through the paravirt infrastructure, for the benefit of regular
users having a nice API, not because XenPV is expecting to do something
wildly different here.


I'd actually go as far as suggesting that you break patches 1-3 into
different series and e.g. update the regular context switch path to use
the WRMSRNS-falling-back-to-WRMSR helpers, just to get started.

~Andrew
