Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740097A072D
	for <lists+linux-edac@lfdr.de>; Thu, 14 Sep 2023 16:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbjINOWf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Sep 2023 10:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240003AbjINOWe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Sep 2023 10:22:34 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAD1DD
        for <linux-edac@vger.kernel.org>; Thu, 14 Sep 2023 07:22:29 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40472f9db24so6084755e9.2
        for <linux-edac@vger.kernel.org>; Thu, 14 Sep 2023 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1694701348; x=1695306148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ff9Ehpvke6LtFPxvHhzarjEmuj2e3YwgZf0e14rNLIQ=;
        b=oFoJvRewtC6A80eeRdd+puYIumNM+E1bfXQYd3VmpzcXsIEabMXBB+vrO2KmBnsoWs
         ppRNLJDdee40avDVqtKO4TsqeW/qOcSMLUjEGOPNCjhdrIVQqi+tozip8YfdZXL/Zu2y
         2I8l2NE2J4QwrfM3W39ZSacGyERMECQsB8iqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694701348; x=1695306148;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ff9Ehpvke6LtFPxvHhzarjEmuj2e3YwgZf0e14rNLIQ=;
        b=ieY4VK3IoK4nyZgdVDfYsNAtBywkoDHsQ6vgZ98TzDbmStJIcpGiiHIfAYm9l8cR0Y
         i5Az7AeMLT1eynQqqLzFZ3iINFgOSVwnJsgJ7yiDVFbocuP3m4DoBTKniR8g0iGyXLlW
         QFq8UKqQXN37bN6SfxuhYXCbd+orydkh1l+52Um3EMT0p8L2JJRKCR8eSOiZJNEDbItd
         /V30dZsBKrrKmnFcUNPhtIPf4FImt99lzyXNvfeHqGLuHKgQbWy0tr4rBQvZ65Sr2fY2
         JlkF6FreHbFzqNDhRRGV7ojMNTw/3a+Ivr+C8ZPW5M63oVgJMPlJBaBXCzahnSORPfRz
         1PRQ==
X-Gm-Message-State: AOJu0YylW94J856IvfvoiKBCgYj1pyfBOv3o9CGEVwhfHfaVXyNVd+sw
        I1CedbLIlIl5nfU9iQ0A44sWrg==
X-Google-Smtp-Source: AGHT+IFve9l57veSgCPqyrpryNeRPxRNyvtIANtQFRamRYlphhlxA6Tmolp/NSw7/qlFLxzi7VWxww==
X-Received: by 2002:a7b:c414:0:b0:402:fe6d:6296 with SMTP id k20-20020a7bc414000000b00402fe6d6296mr4934579wmi.9.1694701348349;
        Thu, 14 Sep 2023 07:22:28 -0700 (PDT)
Received: from [10.80.67.28] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id v26-20020a1cf71a000000b003fe1630a8f0sm5015544wmh.24.2023.09.14.07.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 07:22:28 -0700 (PDT)
Message-ID: <cd4979cf-bcf4-75b4-a18b-c61a9b2e0ffb@citrix.com>
Date:   Thu, 14 Sep 2023 15:22:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   andrew.cooper3@citrix.com
Subject: Re: [PATCH v10 05/38] x86/trapnr: Add event type macros to
 <asm/trapnr.h>
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
 <20230914044805.301390-6-xin3.li@intel.com>
In-Reply-To: <20230914044805.301390-6-xin3.li@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 14/09/2023 5:47 am, Xin Li wrote:
> Intel VT-x classifies events into eight different types, which is
> inherited by FRED for event identification. As such, event type
> becomes a common x86 concept, and should be defined in a common x86
> header.
>
> Add event type macros to <asm/trapnr.h>, and use it in <asm/vmx.h>.
>
> Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Tested-by: Shan Kang <shan.kang@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>
> ---
>  arch/x86/include/asm/trapnr.h | 12 ++++++++++++
>  arch/x86/include/asm/vmx.h    | 17 +++++++++--------
>  2 files changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/include/asm/trapnr.h b/arch/x86/include/asm/trapnr.h
> index f5d2325aa0b7..ab7e4c9d666f 100644
> --- a/arch/x86/include/asm/trapnr.h
> +++ b/arch/x86/include/asm/trapnr.h
> @@ -2,6 +2,18 @@
>  #ifndef _ASM_X86_TRAPNR_H
>  #define _ASM_X86_TRAPNR_H
>  
> +/*
> + * Event type codes used by both FRED and Intel VT-x

And AMD SVM.  This enumeration has never been unique to just VT-x.

> + */
> +#define EVENT_TYPE_EXTINT	0	// External interrupt
> +#define EVENT_TYPE_RESERVED	1
> +#define EVENT_TYPE_NMI		2	// NMI
> +#define EVENT_TYPE_HWEXC	3	// Hardware originated traps, exceptions
> +#define EVENT_TYPE_SWINT	4	// INT n
> +#define EVENT_TYPE_PRIV_SWEXC	5	// INT1
> +#define EVENT_TYPE_SWEXC	6	// INT0, INT3

Typo.  into, not int0  (the difference shows up more clearly in lower case.)

> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index 0e73616b82f3..c84acfefcd31 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -374,14 +375,14 @@ enum vmcs_field {
>  #define VECTORING_INFO_DELIVER_CODE_MASK    	INTR_INFO_DELIVER_CODE_MASK
>  #define VECTORING_INFO_VALID_MASK       	INTR_INFO_VALID_MASK
>  
> -#define INTR_TYPE_EXT_INTR              (0 << 8) /* external interrupt */
> -#define INTR_TYPE_RESERVED              (1 << 8) /* reserved */
> -#define INTR_TYPE_NMI_INTR		(2 << 8) /* NMI */
> -#define INTR_TYPE_HARD_EXCEPTION	(3 << 8) /* processor exception */
> -#define INTR_TYPE_SOFT_INTR             (4 << 8) /* software interrupt */
> -#define INTR_TYPE_PRIV_SW_EXCEPTION	(5 << 8) /* ICE breakpoint - undocumented */
> -#define INTR_TYPE_SOFT_EXCEPTION	(6 << 8) /* software exception */
> -#define INTR_TYPE_OTHER_EVENT           (7 << 8) /* other event */
> +#define INTR_TYPE_EXT_INTR		(EVENT_TYPE_EXTINT << 8)	/* external interrupt */
> +#define INTR_TYPE_RESERVED		(EVENT_TYPE_RESERVED << 8)	/* reserved */
> +#define INTR_TYPE_NMI_INTR		(EVENT_TYPE_NMI << 8)		/* NMI */
> +#define INTR_TYPE_HARD_EXCEPTION	(EVENT_TYPE_HWEXC << 8)		/* processor exception */
> +#define INTR_TYPE_SOFT_INTR		(EVENT_TYPE_SWINT << 8)		/* software interrupt */
> +#define INTR_TYPE_PRIV_SW_EXCEPTION	(EVENT_TYPE_PRIV_SWEXC << 8)	/* ICE breakpoint - undocumented */

ICEBP/INT1 is no longer undocumented.

~Andrew
