Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C792737A977
	for <lists+linux-edac@lfdr.de>; Tue, 11 May 2021 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhEKOhG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 May 2021 10:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbhEKOhE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 May 2021 10:37:04 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F002DC06138B
        for <linux-edac@vger.kernel.org>; Tue, 11 May 2021 07:35:57 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id k25so19224200oic.4
        for <linux-edac@vger.kernel.org>; Tue, 11 May 2021 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ETXAFKWQdH8/eG9YgJ2MyXQqUI4w0G+a8+7kidOetNw=;
        b=D+8UcMkB2GUwjj2F27jdDoxAVAL9rdC9MdMoJFlDBNeHzfe67XWP/sw3xSweHhjvu0
         L7zFyh43n9/fy4cUZSlUsyNvNqDkT2TqDuEFXFN77WQ7UwdcaxgaJydbt2h0Tqt9neqT
         2ljICDLxSDdscBg19eDiJRfFGl65YBejwUIvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ETXAFKWQdH8/eG9YgJ2MyXQqUI4w0G+a8+7kidOetNw=;
        b=Lmgw3PNI+pVDLuU/AczUlQmkYv78z2EmjhkM5Jf8gpcKhR8+pULdMvwfGQUZ4va25c
         PxbXBSX600gmIrzcuuqZXXAe2sR5e9WLVLcRTaYQaYWQuA9iwEm/+5BBjdEHQ/vzkzQg
         j5ZPsby3T91CMjYf9Njj63w5YoxAn3POpdVpol+M9XRtFVEoBmSeCxOC5VK2dX4hEV+7
         GyyL5H+965Kzli1y+zn/w8/kiwQrD8uRHXJjLVb5FytY6xf93D9ButRxwi70dA0bQpNR
         +5L/j2NeubS1gwqtswynp46iifCF2QBRCWN/y64XC4kNqPVqsSxXrE1dlT+SgAYMxRyP
         Jokw==
X-Gm-Message-State: AOAM531nHe3yKWRcPNw6bSKvJ4MJiwv0OQA0TAr81FLLYfiaJ2ndzFVI
        EJK2pBzmHzbUl7f4MlD0CNHQ8A==
X-Google-Smtp-Source: ABdhPJyvp7T0CdewBKkqMXtDA5ThSmqkKCGgPnZJ05uagz+Vq5z9FBuvh4nrA0ZkdxuooO6UIklVPg==
X-Received: by 2002:aca:53d8:: with SMTP id h207mr3883260oib.177.1620743757147;
        Tue, 11 May 2021 07:35:57 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id 2sm3341540ota.67.2021.05.11.07.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 07:35:56 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] kernel.h: Split out panic and oops helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20210511074137.33666-1-andriy.shevchenko@linux.intel.com>
From:   Alex Elder <elder@ieee.org>
Cc:     linux-xtensa@linux-xtensa.org,
        openipmi-developer@lists.sourceforge.net,
        linux-clk@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-hyperv@vger.kernel.org,
        coresight@lists.linaro.org, linux-leds@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org,
        kexec@lists.infradead.org, rcu@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <c6fa5d2c-84e2-2046-19f0-66cf5dd72077@ieee.org>
Date:   Tue, 11 May 2021 09:35:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210511074137.33666-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/11/21 2:41 AM, Andy Shevchenko wrote:
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out panic and
> oops helpers.
> 
> There are several purposes of doing this:
> - dropping dependency in bug.h
> - dropping a loop by moving out panic_notifier.h
> - unload kernel.h from something which has its own domain
> 
> At the same time convert users tree-wide to use new headers, although
> for the time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Corey Minyard <cminyard@mvista.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Kees Cook <keescook@chromium.org>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Co-developed-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Acked-by: Helge Deller <deller@gmx.de> # parisc
> ---
> v3: rebased on top of v5.13-rc1, collected a few more tags
> 
> Note WRT Andrew's SoB tag above: I have added it since part of the cases
> I took from him. Andrew, feel free to amend or tell me how you want me
> to do.
> 

Acked-by: Alex Elder <elder@kernel.org>

. . .

> diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
> index a5f7a79a1923..34b68dc43886 100644
> --- a/drivers/net/ipa/ipa_smp2p.c
> +++ b/drivers/net/ipa/ipa_smp2p.c
> @@ -8,6 +8,7 @@
>   #include <linux/device.h>
>   #include <linux/interrupt.h>
>   #include <linux/notifier.h>
> +#include <linux/panic_notifier.h>
>   #include <linux/soc/qcom/smem.h>
>   #include <linux/soc/qcom/smem_state.h>
>   

. . .
