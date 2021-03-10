Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCDB334207
	for <lists+linux-edac@lfdr.de>; Wed, 10 Mar 2021 16:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhCJPsR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Mar 2021 10:48:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53711 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbhCJPrp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Mar 2021 10:47:45 -0500
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lK13o-0004Jh-3q
        for linux-edac@vger.kernel.org; Wed, 10 Mar 2021 15:47:44 +0000
Received: by mail-ed1-f69.google.com with SMTP id w18so5774952edu.5
        for <linux-edac@vger.kernel.org>; Wed, 10 Mar 2021 07:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yFz6dzZZeHtwfAjkcR+5KOfHHzaYWeftITQqDuozS6s=;
        b=KpMk4O9B0sLjjroLI7egD/eLjtkpEZlAhN2uSEik1zh4xEXKcax9c6ym2fPh6BTtix
         /sPGVuFNUq2sl2kCgRXjd8vn+vP4i2vvxNjOPNvrS0Tcw6VVa9CjKzRuJi3o3d8VhA6n
         L5MRvbgmcdrzTJFPz0CiVjg1m3aqRzdoj2S8IBbY8z6XNMDOikg1+ACAQUk/1XqffZAL
         7cWqQrdrLaZErVKFo+Wn7bt352/69uZmUbVvF4vbsUm0LJqpcc6UAguui5SSdrhPEZP1
         lyhQLSqvuSjX4tlFeTuk74X0duoXWcuww8MoywapKY/VGcZym32307HuvepF+aIa+824
         bPrA==
X-Gm-Message-State: AOAM531qKcjNplMPvHQ0rhD0+CU9zz6jAu8t/QVkwZ0bc/GmNRK4VofP
        2lJEBSIQkJMBwmk3DaaplKnxozCsFsxbaCfopNgKoY30ORxkDE8B7JD+3Kh7vkBmMG0cgG6Yrw+
        D5CrANXTCO0AvPUj1fVTrIWO8VIXnGSDGHPlRbOU=
X-Received: by 2002:a05:6000:245:: with SMTP id m5mr4302683wrz.284.1615391262920;
        Wed, 10 Mar 2021 07:47:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOKdQu1Zo+KUna4pwaQZuaYLADylFjwZtUs6uPbYZncoy6CBJ+ZAg4yMoz8Ix7vWin+JBTOQ==
X-Received: by 2002:a05:6000:245:: with SMTP id m5mr4302666wrz.284.1615391262790;
        Wed, 10 Mar 2021 07:47:42 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id n6sm30989558wrt.1.2021.03.10.07.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 07:47:42 -0800 (PST)
Subject: Re: [RFC v2 3/5] arm64: socfpga: rename ARCH_STRATIX10 to
 ARCH_SOCFPGA64
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Tom Rix <trix@redhat.com>, Lee Jones <lee.jones@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Moritz Fischer <mdf@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-edac@vger.kernel.org, linux-fpga@vger.kernel.org,
        Networking <netdev@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Olof Johansson <olof@lixom.net>
References: <20210310083327.480837-1-krzysztof.kozlowski@canonical.com>
 <20210310083840.481615-1-krzysztof.kozlowski@canonical.com>
 <20210310094527.GA701493@dell>
 <35c39c81-08e4-24c8-f683-2fa7a7ea71de@redhat.com>
 <1c06cb74-f0b0-66e5-a594-ed1ee9bc876e@canonical.com>
 <CAK8P3a1CCQwbeH4KiUgif+-HdubVjjZBkMXimEjYkgeh4eJ7cg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <52d0489f-0f77-76a2-3269-e3004c6b6c07@canonical.com>
Date:   Wed, 10 Mar 2021 16:47:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1CCQwbeH4KiUgif+-HdubVjjZBkMXimEjYkgeh4eJ7cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 10/03/2021 16:39, Arnd Bergmann wrote:
> On Wed, Mar 10, 2021 at 4:06 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>> On 10/03/2021 15:45, Tom Rix wrote:
>>> On 3/10/21 1:45 AM, Lee Jones wrote:
>>
>> Many other architectures do not have vendor prefix (TEGRA, EXYNOS,
>> ZYNQMP etc). I would call it the same as in ARMv7 - ARCH_SOCFPGA - but
>> the Altera EDAC driver depends on these symbols to be different.
>> Anyway, I don't mind using something else for the name.
> 
> I agree the name SOCFPGA is confusing, since it is really a class of
> device that is made by multiple manufacturers rather than a brand name,
> but renaming that now would be equally confusing. If the Intel folks
> could suggest a better name that describes all products in the platform
> and is less ambiguous, we could rename it to that. I think ARCH_ALTERA
> would make sense, but I don't know if that is a name that is getting
> phased out. (We once renamed the Marvell Orion platform to ARCH_MVEBU,
> but shortly afterwards, Marvell renamed their embedded business unit (EBU)
> and the name has no longer made sense since).

I wait then for some ideas from Dinh (or anyone else).

> 
> Regardless of what name we end up with, I do think we should have the
> same name for 32-bit and 64-bit and instead fix the edac driver to do
> runtime detection based on the compatible string.

I can rename ARCH_SOCFPGA on 32-bit ARM as well, however converting edac
driver from #ifdef ARCH_SOCFPGA64 to proper compatible string will be
too much for me: I am not able to test it.

This edac Altera driver is very weird... it uses the same compatible
differently depending whether this is 32-bit or 64-bit (e.g. Stratix
10)! On ARMv7 the compatible means for example one IRQ... On ARMv8, we
have two. It's quite a new code (2019 from Intel), not some ancient
legacy, so it should never have been accepted...

Best regards,
Krzysztof
