Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D4733391D
	for <lists+linux-edac@lfdr.de>; Wed, 10 Mar 2021 10:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhCJJpo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Mar 2021 04:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbhCJJpb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Mar 2021 04:45:31 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96736C06174A
        for <linux-edac@vger.kernel.org>; Wed, 10 Mar 2021 01:45:31 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a18so22522421wrc.13
        for <linux-edac@vger.kernel.org>; Wed, 10 Mar 2021 01:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0Erx94zt8ljBM/yS3nXtNjrWvctYWuUVNAQLWpYJJRo=;
        b=gmhG//67uUiQkJT3GRUTS9z+Tq+SpQbswnEQR3XBOpiU7cuv9y1ZxqWW5di7WTiU0z
         5IGBqN7qnmOOotjHLYfwHb3ymzghFWrRTY1lWccM1Jx+OctRRl2HrazL+Ie3zn+oOLg4
         +Cr93FaZA5kDLdCQdfSnM2ocPGfjV/4QFyjlmLL+A/yeCntkZRxL1Y6VHE3Ix0XGWvt0
         6g/f18dGAHNtTske/QJGnxe1q9MAz0KsF1R4s87be2nrW/bOkzR56VrkiKlK8Lct6oeX
         n8ruIEf/G85aTXWUgm6d5CINJa9ul6yAnrKIqzkWyNT+48PSH1UtSBhOAi5f8ntwPNJr
         7JyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0Erx94zt8ljBM/yS3nXtNjrWvctYWuUVNAQLWpYJJRo=;
        b=B+rKk5F2p9Q4qrMTE/+SH2zpnvSC6R1RfANQi/KwCtJAZ1TEYKk7iVtLJvrdatyc0r
         U3C8fEtnHTmdrrJfrzOAi8zHrwOiEksjQFcZ49H8SISNZKXwBbBRRkRscXfcloEw9lE/
         TPKtv40HECMgKZFk9NwsBHaDHinvlXyG8mqST371ctb67y9vl3UdeCNWEUE3uDcmHZo0
         /qIJsF/tFZ2pF2YeO1O7U+Y1I6u3/OK67QQv4z4Dx1ZPPR+Bl6CjNqtIf6FcL/l6Lx9B
         f9gnJTMYv7TW+ZNf0yoIcGRPl0aUYUCWp4z+lhlNu8Cmv+EdE2bnV5cWfh4NX2YEx8+Q
         fKdA==
X-Gm-Message-State: AOAM531JRVNnRCDIZP0GEupmF5DXzvTrXIIACqY09O3Wf2YporueU/R9
        e4CC2z+NerLrYqUaInG78hEzvA==
X-Google-Smtp-Source: ABdhPJxcv9V5lAz+sEJ4HCtbzjFqfXkdmpxw/ngT7vdSlUljH3RkiAsQdLLVCP49qFAMYuC+GEIjxg==
X-Received: by 2002:a5d:6381:: with SMTP id p1mr2649040wru.266.1615369530343;
        Wed, 10 Mar 2021 01:45:30 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id c9sm11764201wrr.78.2021.03.10.01.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 01:45:29 -0800 (PST)
Date:   Wed, 10 Mar 2021 09:45:27 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-fpga@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [RFC v2 3/5] arm64: socfpga: rename ARCH_STRATIX10 to
 ARCH_SOCFPGA64
Message-ID: <20210310094527.GA701493@dell>
References: <20210310083327.480837-1-krzysztof.kozlowski@canonical.com>
 <20210310083840.481615-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210310083840.481615-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, 10 Mar 2021, Krzysztof Kozlowski wrote:

> Prepare for merging Stratix 10, Agilex and N5X into one arm64
> architecture by first renaming the ARCH_STRATIX10 into ARCH_SOCFPGA64.
> 
> The existing ARCH_SOCFPGA (in ARMv7) Kconfig symbol cannot be used
> because altera_edac driver builds differently between them (with
> ifdefs).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  arch/arm64/Kconfig.platforms                |  7 ++++---
>  arch/arm64/boot/dts/altera/Makefile         |  2 +-
>  arch/arm64/configs/defconfig                |  2 +-
>  drivers/clk/Makefile                        |  2 +-
>  drivers/clk/socfpga/Kconfig                 |  4 ++--
>  drivers/edac/Kconfig                        |  2 +-
>  drivers/edac/altera_edac.c                  | 10 +++++-----
>  drivers/firmware/Kconfig                    |  2 +-
>  drivers/fpga/Kconfig                        |  2 +-

>  drivers/mfd/Kconfig                         |  2 +-

If it's okay with everyone else, it'll be okay with me:

Acked-by: Lee Jones <lee.jones@linaro.org>

>  drivers/net/ethernet/stmicro/stmmac/Kconfig |  4 ++--
>  drivers/reset/Kconfig                       |  2 +-
>  12 files changed, 21 insertions(+), 20 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
