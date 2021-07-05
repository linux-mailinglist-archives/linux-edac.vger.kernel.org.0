Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2023BBECA
	for <lists+linux-edac@lfdr.de>; Mon,  5 Jul 2021 17:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhGEPWs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Jul 2021 11:22:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59537 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhGEPWr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Jul 2021 11:22:47 -0400
Received: from mail-lj1-f197.google.com ([209.85.208.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1m0QOH-0007rR-WA
        for linux-edac@vger.kernel.org; Mon, 05 Jul 2021 15:20:10 +0000
Received: by mail-lj1-f197.google.com with SMTP id 70-20020a2e09490000b02901827163ceefso1875488ljj.18
        for <linux-edac@vger.kernel.org>; Mon, 05 Jul 2021 08:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7HXLCPSoU2ku5Z25x/c/7Afb0RvzkTlC09xs4+z78F4=;
        b=omFQGPan3QjYFra9Rh7M8MD86CS7eNtR0OpPQwMXO7CK3/eSNCNsInhR7h37ubTpW+
         GddWkldLVjv3GoXh7+cQtb7pIx6HJ5Ar1iNiUPDE/ECPEjbicePTrQsMYYec49tlZxsF
         fbDmvJcVBq0mw+rjnU9ZfJCX2ZE9n/pGr+8rJ4qP+GL75yrzo95gdtFyGWe3UzgeuHEC
         Ylm8mJVqlpilQwZzS5cmWZ/FI9JLQThg2egrS8VmpwRqTcoyL0XMByMUVX+mQo4I3+bm
         JKSRVvLvKa6C096sqsdyZhHMnH8p6FwUyWUtB3SptOkA4GT6D1acsiaATNCyGzJGuIU8
         4bCQ==
X-Gm-Message-State: AOAM533TTGJvxUZ65ht4+x06Z+YgACFkrOwgNHp0B74wNy/Wsx6RJkuB
        Btm8D9Il7vy4i7Vckvk7mbpg1yPW/SWmEE4fqfNMMA7Gv6yuyv5PuDAnf+8vI4G1gCp1YXPMOtk
        8r7Q3IGRsSQCLN4OjeKBBDLMZT0kYOVf3JXESiKI=
X-Received: by 2002:a05:6402:204:: with SMTP id t4mr16842384edv.34.1625498002782;
        Mon, 05 Jul 2021 08:13:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEBSAhhUehUatN39q10BAqmQC9QTSYyb9SbUpH2qnPy7k6MqtbBUwfOrKncFM/WsxjkNCpUQ==
X-Received: by 2002:a05:6402:204:: with SMTP id t4mr16842367edv.34.1625498002669;
        Mon, 05 Jul 2021 08:13:22 -0700 (PDT)
Received: from [192.168.3.211] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id br4sm4348512ejb.110.2021.07.05.08.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 08:13:22 -0700 (PDT)
Subject: Re: [PATCH] EDAC, altera: skip defining unused structures for
 specific configs
To:     Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
References: <20210601092704.203555-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <b60d6dc2-abc2-b0fc-a880-1a7fec1dec67@canonical.com>
Date:   Mon, 5 Jul 2021 17:13:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210601092704.203555-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 01/06/2021 11:27, Krzysztof Kozlowski wrote:
> The Altera EDAC driver has several features conditionally built
> depending on Kconfig options.  The edac_device_prv_data structures are
> conditionally used in of_device_id tables.  They reference other
> functions and structures which can be defined as __maybe_unused.  This
> silences build warnings like:
> 
>     drivers/edac/altera_edac.c:643:37: warning:
>         ‘altr_edac_device_inject_fops’ defined but not used [-Wunused-const-variable=]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/edac/altera_edac.c | 44 ++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 18 deletions(-)

Hi Altera and EDAC maintainers,

Any comments on this patch?

Best regards,
Krzysztof
