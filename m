Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A68BCEA2D
	for <lists+linux-edac@lfdr.de>; Mon,  7 Oct 2019 19:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfJGRI3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Oct 2019 13:08:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbfJGRI2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 7 Oct 2019 13:08:28 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F14CA909
        for <linux-edac@vger.kernel.org>; Mon,  7 Oct 2019 17:08:28 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id o10so2996023wrm.22
        for <linux-edac@vger.kernel.org>; Mon, 07 Oct 2019 10:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4dMNikcs4E1Y6yKRSwkPQbM0//TiQDXUZcr0YM9OD1c=;
        b=LwsMA0zzC04J212pj50R3E1JdDwxHd3k0Zmwr0ZYT6hQUz04pJTo0h0HlskgSkmPCy
         UuBNjz5T5ZePkz+uWdVj8bX1W4n/I2lhsjFRUk3evKh6Oev+HN9O+bxINDdvWdf1Ce0F
         Nx4xzFQoNUmGqf9gZhuZfyYLO+lpzMDyIOXIrlHBRZcDmKa9AhfnB1YWXjAYHgLJDsll
         6BBJZaHbFursEXWVcy0kNVHX/zHY3734dGKusDxHQ38f4P59wF73w26aqvKSiHof2j4p
         KUNmqr+yFhtTUBTUEcbCB3lxx36f6jn5cl+nb5WNxEsLgGw+L4WI0MJ8jJqXcrBC6rrn
         YPLQ==
X-Gm-Message-State: APjAAAUTd1GSxKJr4I7tH/Abi2pHE5gs7MzWRUuxiwG3VeXWnefM7AXn
        iDlFBWguaGujzmyrMQRSIOaZThisyCWu1OJdjNdbHlmWNnIINt6fLBenGCkypCixIT2/gXw1mHg
        zMhkSB633nj1m8MAoXClWTA==
X-Received: by 2002:a1c:658a:: with SMTP id z132mr234256wmb.174.1570468106765;
        Mon, 07 Oct 2019 10:08:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyl2zL9+JMyC3FnFxnpfwEeHdK9iIlPFdBf18ZjZZ5+fIVvZmESnuAYRAzXBT2rMkqUBPJFMg==
X-Received: by 2002:a1c:658a:: with SMTP id z132mr234231wmb.174.1570468106497;
        Mon, 07 Oct 2019 10:08:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dd9:ce92:89b5:d1f2? ([2001:b07:6468:f312:9dd9:ce92:89b5:d1f2])
        by smtp.gmail.com with ESMTPSA id 79sm330487wmb.7.2019.10.07.10.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 10:08:25 -0700 (PDT)
Subject: Re: [PATCH 09/16] x86/vmx: Introduce VMX_FEATURES_*
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-edac@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <20191004215615.5479-1-sean.j.christopherson@intel.com>
 <20191004215615.5479-10-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <149d4422-b955-9118-e7df-e135075ad490@redhat.com>
Date:   Mon, 7 Oct 2019 19:08:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004215615.5479-10-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 04/10/19 23:56, Sean Christopherson wrote:
> +#define VMX_FEATURE_RDSEED_EXITING	( 2*32+ 16) /* "" VM-Exit on RDSEED */
> +#define VMX_FEATURE_PAGE_MOD_LOGGING	( 2*32+ 17) /* "pml" Log dirty pages into buffer */
> +#define VMX_FEATURE_EPT_VIOLATION_VE	( 2*32+ 18) /* "" Conditionally reflect EPT violations as #VE exceptions */
> +#define VMX_FEATURE_PT_CONCEAL_VMX	( 2*32+ 19) /* "" Suppress VMX indicators in Processor Trace */
> +#define VMX_FEATURE_XSAVES		( 2*32+ 20) /* "" Enable XSAVES and XRSTORS in guest */
> +#define VMX_FEATURE_RESERVED_PIN_21	( 2*32+ 21) /* "" Reserved */
> +#define VMX_FEATURE_MODE_BASED_EPT_EXEC	( 2*32+ 22) /* Enable separate EPT EXEC bits for supervisor vs. user */
> +#define VMX_FEATURE_RESERVED_PIN_23	( 2*32+ 23) /* "" Reserved */
> +#define VMX_FEATURE_PT_USE_GPA		( 2*32+ 24) /* "" Processor Trace logs GPAs */
> +#define VMX_FEATURE_TSC_SCALING		( 2*32+ 25) /* Scale hardware TSC when read in guest */
> +#define VMX_FEATURE_RESERVED_PIN_26	( 2*32+ 26) /* "" Reserved */
> +#define VMX_FEATURE_RESERVED_PIN_27	( 2*32+ 27) /* "" Reserved */
> +#define VMX_FEATURE_ENCLV_EXITING	( 2*32+ 28) /* "" VM-Exit on ENCLV (leaf dependent) */
> +#define VMX_FEATURE_RESERVED_PIN_29	( 2*32+ 29) /* "" Reserved */
> +#define VMX_FEATURE_RESERVED_PIN_30	( 2*32+ 30) /* "" Reserved */
> +#define VMX_FEATURE_RESERVED_PIN_31	( 2*32+ 31) /* "" Reserved */

Pasto on the reserved bit names, but in general why is it useful to
define them?

Paolo
