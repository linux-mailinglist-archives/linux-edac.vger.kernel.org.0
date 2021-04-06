Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EFD3558FB
	for <lists+linux-edac@lfdr.de>; Tue,  6 Apr 2021 18:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346333AbhDFQPe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Apr 2021 12:15:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39014 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346331AbhDFQPe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 6 Apr 2021 12:15:34 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lToMO-0005kY-HH
        for linux-edac@vger.kernel.org; Tue, 06 Apr 2021 16:15:24 +0000
Received: by mail-ed1-f72.google.com with SMTP id dj13so3208578edb.14
        for <linux-edac@vger.kernel.org>; Tue, 06 Apr 2021 09:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pc7Mc2iBHF1g8Xf3WZmYYKPrF2SwmZQ5FMyrEN7WVwU=;
        b=cHsLuUL4fngY+c4Tf4A794O6nePk8xZQIueBiTO9UEhjYAcnuTE217K7SkIJFfPr4K
         TbMSXQ5MZaE86dR2ywXlN8hVOjFpfqTkh0GmKPXQyiRQm681ITZ7oIzjuowIohN55C9K
         LuqRnEYdLsxok1S4qyB4MWKiQLxmu+jIiZKC6EPnoVV2/OJPfoaP23wfTHnij79U1bCF
         9uJ99x5sPw9FJf5U0VvsWx6YQ8R6fH/FPHtcqly9jwJh4Mt520GuPqg7LHRAeGVZMZFP
         +pN/jtRK82luRn5tpOyzdmz0nNwqD9DPV0YuW/cFHYgGNrk3MnTjPfZjNPLqsRBNWZb8
         EUbA==
X-Gm-Message-State: AOAM533fjEOzy0q9xxs11BZ7W9Z33iGdNkNrlsYl/5tkbvTe5uy7Z3Et
        4DWArQaBjgR75b6rDLDo7kFbAUTFYm7sXEbcR0W+yj9zhr8wQPZUe/hlQZyv0LthZewXeicISnU
        AN6ojTXtuCIK5h10XuV+Ysh0BnSpaH0wkDROL0eFr58Acv8CyXw3nVzQ=
X-Received: by 2002:a17:906:ff15:: with SMTP id zn21mr20674078ejb.296.1617725724102;
        Tue, 06 Apr 2021 09:15:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw804Texr+Avxb2Xtww4+jktrq8ZbSClHDrPU8KBZum7liZCTe94GVIXgCnwrVcGVlgqfayCTK8SXCiOhy7+HI=
X-Received: by 2002:a17:906:ff15:: with SMTP id zn21mr20674031ejb.296.1617725723902;
 Tue, 06 Apr 2021 09:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210311152545.1317581-1-krzysztof.kozlowski@canonical.com>
 <20210311152545.1317581-9-krzysztof.kozlowski@canonical.com> <20210406160959.GA208060@roeck-us.net>
In-Reply-To: <20210406160959.GA208060@roeck-us.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Tue, 6 Apr 2021 18:15:13 +0200
Message-ID: <CA+Eumj6C60r4DF24W2GobwB1GrQADLpm5YXLAzHjcjWmrrsE3g@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] arm64: socfpga: merge Agilex and N5X into ARCH_INTEL_SOCFPGA
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 6 Apr 2021 at 18:10, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Mar 11, 2021 at 04:25:38PM +0100, Krzysztof Kozlowski wrote:
> > Agilex, N5X and Stratix 10 share all quite similar arm64 hard cores and
> > SoC-part.  Up to a point that N5X uses the same DTSI as Agilex.  From
> > the Linux kernel point of view these are flavors of the same
> > architecture so there is no need for three top-level arm64
> > architectures.  Simplify this by merging all three architectures into
> > ARCH_INTEL_SOCFPGA and dropping the other ARCH* arm64 Kconfig entries.
> >
> > The side effect is that the INTEL_STRATIX10_SERVICE will now be
> > available for both 32-bit and 64-bit Intel SoCFPGA, even though it is
> > used only for 64-bit.
>
> Did you try to compile, say, arm:allmodconfig with this patch applied ?
> Because for me that results in:
>
> In file included from <command-line>:
> drivers/firmware/stratix10-rsu.c: In function 'rsu_status_callback':
> include/linux/compiler_types.h:320:38: error:
>         call to '__compiletime_assert_177' declared with attribute error:
>         FIELD_GET: type of reg too small for mask
>
> and lots of similar errors.

Thanks for the report. I fixed that already with:
https://lore.kernel.org/lkml/20210321184650.10926-1-krzysztof.kozlowski@canonical.com/
(and https://lore.kernel.org/lkml/20210404124609.122377-1-dinguyen@kernel.org/ )
but for some reason it did not go to the same tree.

Best regards,
Krzysztof
