Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6225FCD4E
	for <lists+linux-edac@lfdr.de>; Wed, 12 Oct 2022 23:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJLVbl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Oct 2022 17:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJLVbY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Oct 2022 17:31:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3CD120EDF;
        Wed, 12 Oct 2022 14:31:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id r22so68061ljn.10;
        Wed, 12 Oct 2022 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+u5zTxsQpjiuj7kJ8NImmHJwlmXGjiHmqr7wGB9659Y=;
        b=SaKHthR+wG3Es3kmvRYC96e31d2/qYDWIOmiGR64bxw/8Lt4fTC/kE4uLXiyeboZNk
         twGw7vqpIpx4oGsX6MbkWCaA8NwOvtixhXZHPSd7BO8L0cWMcRkcREjQviGLVTXWLRiz
         pdmrvSGH+Pt/KP0e1njrrcYVWVcAMKHoiIyH5zwTgsoLR1P0ZAWs2PLZ1RDm3cdit4a9
         CMVfKoYZt956B2Rg2W9vO0mwciR45C9t1LUpDehaDBFjouoF46YBpPLpzhYUR4CCJpYs
         qWzUC7S4RmG5DSfjR8KWie8jTR3qyEA8Gu2BIuL/oAzRaQRKQA0eR6zwMNSmvDs7w/m9
         K6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+u5zTxsQpjiuj7kJ8NImmHJwlmXGjiHmqr7wGB9659Y=;
        b=YLLyXHIbqHobMhO4Q1UQtwX760CcEG0DJPKrDJCpF3m+uavsHZNglMJkfYvwrpnBaG
         s9cE/SSh5GquGwc2eFhje6mSMXWlHEKTEC0PgYD3eMP9sBOA3aebF0F0uvwfRkZzO2aW
         furOwH316C6NAh2JM1G635/LrNW3HIlH4DAOc7gxkKXpNhccBxYYj9hohsTjDy17tdF9
         ESy71hX8866m0bdMWwMEUbsKhKELUjxZvLowCawm07CArw192BwsKZXl2Lw8h4AFwMd0
         BFSob6gXRQVFvTISAVop16NnFMw62EqPlABbTYjObPgzzuZP+Ymy0XgM/beAIp22FyzW
         g/pA==
X-Gm-Message-State: ACrzQf2pz8agXCSS06RHTzKHhcdGLzyWvKq4uvAOFffmnyFwT1Mygolh
        1EWr/nue/NQVSfjRrSgkSRI=
X-Google-Smtp-Source: AMsMyM5nPJG9As/+UNLN3CVpn76zI3Ad1+oKSu/NW+qfUWOTHWvdb5VmDyFjw0EgSUpbKK7OxzVZHg==
X-Received: by 2002:a2e:a887:0:b0:26a:ba85:8fbe with SMTP id m7-20020a2ea887000000b0026aba858fbemr10875427ljq.14.1665610276205;
        Wed, 12 Oct 2022 14:31:16 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id t18-20020a056512209200b004946bec4e7fsm119652lfr.41.2022.10.12.14.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:31:15 -0700 (PDT)
Date:   Thu, 13 Oct 2022 00:31:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 13/17] EDAC/mc: Add MC unique index allocation
 procedure
Message-ID: <20221012213113.fop4kqqtu43hka4b@mobilestation>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <20220929232712.12202-14-Sergey.Semin@baikalelectronics.ru>
 <Y0b5cq4evSg1nfb0@zn.tnic>
 <20221012200154.7fq3i7igbgkcy2mx@mobilestation>
 <Y0ckn5r3KN416Jeg@zn.tnic>
 <Y0cnS0uOtjmYL7fQ@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0cnS0uOtjmYL7fQ@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 12, 2022 at 01:44:59PM -0700, Tony Luck wrote:
> On Wed, Oct 12, 2022 at 10:33:35PM +0200, Borislav Petkov wrote:
> > On Wed, Oct 12, 2022 at 11:01:54PM +0300, Serge Semin wrote:
> 
> > "A new special MC index is introduced here. It's defined by the
> > EDAC_AUTO_MC_NUM macro with a value specifically chosen as the least
> > probable value used for the real MC index. In case if the EDAC_AUTO_MC_NUM
> > index is specified by the EDAC LLDD, the MC index will be either retrieved
> > from the MC device OF-node alias index ("mc[:number:]") or automatically
> > generated as the next-free MC index found by the ID allocation procedure."
> 

> Just curious.If I have an EDAC driver using EDAC_AUTO_MC_NUM, and I
> unload and reload the driver a bunch of times. Do I get the same memory
> controller numbers each reload, or get an ever increasing set each time?

You'll get the same numbers if no other device-driver allocated them
(which we already established isn't relevant to EDAC since only one
driver per system is supposed to work). In order to implement what you
said I should have called idr_alloc_cyclic() instead.

Here is what the suggested implementation implies:

1. If there is a particular ID assigned in the framework of the dts aliases
(i.e. mcX = &ddr0) then that value will be selected for the controller.
2. If no particular ID is assigned but there are mcX-like aliases
defined in DTS, then the next free id greater than the last mcX value
will be assigned.
3. If none if the above is relevant the first free ID in the pool will be
allocated.
4. On the driver unload the driver remove method will be called thus
the allocated ID will be freed on the MC-controller de-registration.
Thus on the next driver loading the freed IDs will be reused by the
idr_alloc() method design.

-Sergey

> 
> -Tony
