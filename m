Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5781433411F
	for <lists+linux-edac@lfdr.de>; Wed, 10 Mar 2021 16:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhCJPFh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Mar 2021 10:05:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51898 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbhCJPFX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Mar 2021 10:05:23 -0500
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lK0Oo-0000Jy-Jv
        for linux-edac@vger.kernel.org; Wed, 10 Mar 2021 15:05:22 +0000
Received: by mail-wr1-f69.google.com with SMTP id i5so8108283wrp.8
        for <linux-edac@vger.kernel.org>; Wed, 10 Mar 2021 07:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6O6+tOduwR48d8zZ29bwhvehUqmwn5KZAJpghN9/ZFw=;
        b=cW4XrJz7/5hgxwXNecyHn46ANjenNtarnd9Pcu4Lf1k37E6MNeKFUOGgWHxs0ff/1d
         QWiP4fPdrY18apAVt+wFCEe4dfxKxKT+jO9aDZj2ujEGqqRTzfcv3z47BlSf6qJ2Q7VU
         obHszw7PyIRu31xq4zqq7w66osTgM3XLcTtTQ72dkmH/U+xDAycAIRV8aBTS20gZMT6e
         lmU1F+1Wit8ZCZvomAODdIjDEWr/JkkbG4Dyi0XtFj0ztpSmaJb/0W7TURPiNp+L3lAo
         ok9u5YBoREfCakppAB71qn/V8UvyHrnfya/ZjeWHodkPyAHVZhfpHfe61FQuG4PQ2mGP
         XpYQ==
X-Gm-Message-State: AOAM531H0Cx+ejraxEBkfeeq4iPxXAEY5xCxHLrj5rvJW7d0P+NG48i+
        anAo5aDyyEUq91wbuz0XDS6KDSDB5LVIWwpZ3z7eJaX9Ao9Q2hLtExTpEghzjKfq4uBAohxlAj7
        8tHL5gOoYZ8UgZB7QIEgI+2Nud8d65dWqpLcz2v0=
X-Received: by 2002:adf:f303:: with SMTP id i3mr3936169wro.67.1615388721851;
        Wed, 10 Mar 2021 07:05:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGJJurjVb7EYp0bgYqxrECEX4ZhpKbOThOV2/LSr/fZ3VGeNkWRh86xSztb8QWNx4T9B9Jfg==
X-Received: by 2002:adf:f303:: with SMTP id i3mr3936156wro.67.1615388721715;
        Wed, 10 Mar 2021 07:05:21 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id c26sm32188982wrb.87.2021.03.10.07.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 07:05:21 -0800 (PST)
Subject: Re: [RFC v2 3/5] arm64: socfpga: rename ARCH_STRATIX10 to
 ARCH_SOCFPGA64
To:     Tom Rix <trix@redhat.com>, Lee Jones <lee.jones@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Moritz Fischer <mdf@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-fpga@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
References: <20210310083327.480837-1-krzysztof.kozlowski@canonical.com>
 <20210310083840.481615-1-krzysztof.kozlowski@canonical.com>
 <20210310094527.GA701493@dell>
 <35c39c81-08e4-24c8-f683-2fa7a7ea71de@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <1c06cb74-f0b0-66e5-a594-ed1ee9bc876e@canonical.com>
Date:   Wed, 10 Mar 2021 16:05:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <35c39c81-08e4-24c8-f683-2fa7a7ea71de@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 10/03/2021 15:45, Tom Rix wrote:
> 
> On 3/10/21 1:45 AM, Lee Jones wrote:
>> On Wed, 10 Mar 2021, Krzysztof Kozlowski wrote:
>>
>>> Prepare for merging Stratix 10, Agilex and N5X into one arm64
>>> architecture by first renaming the ARCH_STRATIX10 into ARCH_SOCFPGA64.
>>>
>>> The existing ARCH_SOCFPGA (in ARMv7) Kconfig symbol cannot be used
>>> because altera_edac driver builds differently between them (with
>>> ifdefs).
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>> ---
>>>  arch/arm64/Kconfig.platforms                |  7 ++++---
>>>  arch/arm64/boot/dts/altera/Makefile         |  2 +-
>>>  arch/arm64/configs/defconfig                |  2 +-
>>>  drivers/clk/Makefile                        |  2 +-
>>>  drivers/clk/socfpga/Kconfig                 |  4 ++--
>>>  drivers/edac/Kconfig                        |  2 +-
>>>  drivers/edac/altera_edac.c                  | 10 +++++-----
>>>  drivers/firmware/Kconfig                    |  2 +-
>>>  drivers/fpga/Kconfig                        |  2 +-
>>>  drivers/mfd/Kconfig                         |  2 +-
>> If it's okay with everyone else, it'll be okay with me:
>>
>> Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> I think the name is too broad, from the description in the config
> 
> +	bool "Intel's SoCFPGA ARMv8 Families"
> 
> A better name would be ARCH_INTEL_SOCFPGA64
> 
> So other vendors like Xilinx could do their own thing.

Many other architectures do not have vendor prefix (TEGRA, EXYNOS,
ZYNQMP etc). I would call it the same as in ARMv7 - ARCH_SOCFPGA - but
the Altera EDAC driver depends on these symbols to be different.
Anyway, I don't mind using something else for the name.

Best regards,
Krzysztof
