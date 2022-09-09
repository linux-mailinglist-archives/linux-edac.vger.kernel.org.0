Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30145B3857
	for <lists+linux-edac@lfdr.de>; Fri,  9 Sep 2022 14:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiIIM55 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Sep 2022 08:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiIIM54 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 9 Sep 2022 08:57:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFB517AB2;
        Fri,  9 Sep 2022 05:57:50 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w8so2501133lft.12;
        Fri, 09 Sep 2022 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=S4/m6aJI9RYrEBxRHv4vOa1BDy2/J11xb+qcIeUTq4Y=;
        b=chKaoVYxLtYqjBSP/4q/+lWZ9IYwPzQcFdhYdydTIMSaWWVpK3WfDTZ3vIs5phQ0my
         5/06w6DKnzHyBdoxAD9virgcWldBdte6NXVJN+HbA9SiDJrYYMAJIsoclGROWSp1nNhN
         iZlk/7Dsoh8XVES3v7+Q2G+n/LdLku+D8U1GNeO1W4KP7RTn+kzuLp2f4ZLCNuQl2p/3
         3WLnqgR7gr3lQ7AWe5bQZpw3R1c9hvN2X2zfKJvwxTYWnAvoRCiMXY4w/fxJ46oaQZ8y
         iLCnyZc16O4uJ3+eZ63mwvU+zsBCg7oPLG5Mx95ebgjeL0GBC+iCQyVJJhAKcsG6AAP0
         nkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=S4/m6aJI9RYrEBxRHv4vOa1BDy2/J11xb+qcIeUTq4Y=;
        b=PdDou3eyx0xHSU8FFFXRs76i/B4VV8BHuPIb9FzYzUI6aKEZBw92uS29+juGoxGIGu
         aUxVqwWWOaD37BSnqvbd35a2jUSEa0nER79ikBstHMrAG84rP8qB9dhbe6kx7VqWi967
         f7z3m43SXxvOnJ3jHdPR9N6R1CCkDHQkWc2DzuqUsVZOdUK9LA1eQvGBKboz0xJMwaRv
         AcLyMmwgLmpQyEg0ADOR3XCYcLfcs/6Nf64WZ6GttczcXy99USaruCoQvK7iTxmKgSCI
         2dSJMoCikIxpAmgXj6Hh0Qe9+pf5o1nJ0fYabPztVcfDUDRgN7RAEE2CoV43vbqcXQ4R
         2shw==
X-Gm-Message-State: ACgBeo02zy7sUfktIGaogUQyQGhHKWhvHVEMcrJnR531Ton1BVeIPKhP
        q+yrWPmZ6masWPAOonamzdI=
X-Google-Smtp-Source: AA6agR7Sz7rXYWYQKDSTMczmekU48EdA1TJUJPL7yFZTbw7xckVNXhdmOUhAsNxxA8z/6IZjCaHcgg==
X-Received: by 2002:a05:6512:ad3:b0:492:d78f:2c09 with SMTP id n19-20020a0565120ad300b00492d78f2c09mr4126789lfu.99.1662728268489;
        Fri, 09 Sep 2022 05:57:48 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id f29-20020a05651c03dd00b002688cceee17sm64429ljp.131.2022.09.09.05.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:57:47 -0700 (PDT)
Date:   Fri, 9 Sep 2022 15:57:45 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 02/13] dt-bindings: memory: snps: Add Baikal-T1 DDRC
 support
Message-ID: <20220909125745.42myr3zwwbfn2tea@mobilestation>
References: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
 <20220822191957.28546-3-Sergey.Semin@baikalelectronics.ru>
 <20220830180028.GA1758236-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830180028.GA1758236-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Rob,
Sorry for missing your message. It has kind of got lost among the
Krzysztof' comments.

On Tue, Aug 30, 2022 at 01:00:28PM -0500, Rob Herring wrote:
> On Mon, Aug 22, 2022 at 10:19:45PM +0300, Serge Semin wrote:
> > Baikal-T1 DDR controller is based on the DW uMCTL2 DDRC IP-core v2.51a
> > with up to DDR3 protocol capability and 32-bit data bus + 8-bit ECC. There
> > are individual IRQs for each ECC and DFI events.The dedicated scrubber
> > clock source is absent since it's fully synchronous to the core clock.
> > In addition to that the DFI-DDR PHY CSRs can be accessed via a separate
> > registers space.
> 

> Are you sure the phy and dfi irq shouldn't be a separate device?

I am sure that the DFI IRQ is a part of the DW uMCTl2 DDR controller
specification. The DFI interface has a special signal called
"dfi_alert_n". It is supposed to be supplied to the DDR controller
from the DDR PHY. The signal state indicates the CRC/Parity errors
detected on the address/command sent to the PHY/SDRAM side. Aside with
some other statuses the signal state is reflected in the DW uMCTL2
CRCPARSTAT register. The CSR state in its turn is then sent out via
the corresponding output wire (dfi_err_int) up to the IRQ controller.
So to speak there is no doubts the DFI errors IRQ is a part of the DW
uMCTL2 DDRC IRQs interface.

Regarding the PHY CSR space. You are right. It is a separate device
indeed. I'll drop the PHY CSR region from here.

-Sergey

> 
> Rob
