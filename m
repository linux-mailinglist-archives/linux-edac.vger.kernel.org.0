Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7B25FCC6F
	for <lists+linux-edac@lfdr.de>; Wed, 12 Oct 2022 22:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJLUzk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Oct 2022 16:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJLUzi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Oct 2022 16:55:38 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EF1A478;
        Wed, 12 Oct 2022 13:55:37 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bn8so22068721ljb.6;
        Wed, 12 Oct 2022 13:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t94iU6tiDOrr2Z3ZKXKEtLbEQqYDhthkqiU9i1YH9OE=;
        b=ninVkB9GUhO57bjgFgbl1StVZevTrq0zFzJBAvW68mWeHoY229TuMBta4JS9Tvwcp3
         Bk/SD2031yWLCS//kymgyY65ZKkh2rnOVAdOkVE6+aZG8tUbTy5mKnF/5JV9CrGnYvBj
         GSS9A6MxVRzvuUX10vRPhcLOYh8nxx4+nm8IR3ofrRlzM3+dfZGqajfsegUTA09h6301
         eNeLDoWd+y91Hxur9PEAw2Yvo7avLRxa2G1f9cEvHkZxtQ4+ucT4x1ztE/0Z/Ud3QmDy
         DTCSdhpH1NtqsrbzXdRJBix0u2FcX8h+/LQ62N2H76HpBJNbXwrUlKW+rONL4MuCBX6a
         4ROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t94iU6tiDOrr2Z3ZKXKEtLbEQqYDhthkqiU9i1YH9OE=;
        b=DujCY4IXNgJYqQTi1ijNMNN14j+TVIJKNg/M3nhHccMvB3g6142rifMsnxUnA6a/+9
         Hus5T1+MYJ9mWV6SAEoV/jX+2PxHVVmMbnYBJcn6p6PggCCTOLU37lskxTMS39HamVwp
         mIWUikBd9OA2xlBcu9mkan/4keKENMQNz6y9NP5TOj01eXCy/xHvrgrX1qHvkdW2enQJ
         1zLpfoObrCnDNvHIq7qOek625NA2YtcTj/mrvOs9Mknv8Sp1oJLf26K/hhVTlCze8Amq
         kZsv3+RqDSYI7o+qnVaG1LIRB73LbHcXHxelSfWX2pVB+17ZTIT8czSXyZ25pxBxYOqv
         wcIg==
X-Gm-Message-State: ACrzQf1zZcdPZv6p8XENWNG/qc6UK6ofg7srsYk7njjlo2mQeLjFXzXc
        MtTcP8YIA8zIPCNv3s9u16YbFE75D5mpyQ==
X-Google-Smtp-Source: AMsMyM4+9+bYISlmz2xYMf7b5a3yNjLlkesrHctQO6qJpsGL+rStXibgcJcOtp8/RsiRapDieqUiig==
X-Received: by 2002:a05:651c:1509:b0:26f:a762:7139 with SMTP id e9-20020a05651c150900b0026fa7627139mr6179680ljf.416.1665608136181;
        Wed, 12 Oct 2022 13:55:36 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512114700b0049aa7a56715sm93926lfg.267.2022.10.12.13.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 13:55:35 -0700 (PDT)
Date:   Wed, 12 Oct 2022 23:55:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
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
Subject: Re: [PATCH RESEND v3 14/17] EDAC/synopsys: Detach Zynq DDRC
 controller support
Message-ID: <20221012205533.kp45dht3j5zk4bdx@mobilestation>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <20220929232712.12202-15-Sergey.Semin@baikalelectronics.ru>
 <YzcAV2I/rhILfhwR@zn.tnic>
 <20221006121740.ksugoodbagr45fky@mobilestation>
 <Yz7XVqeopgGVR7+3@zn.tnic>
 <20221008004224.owqbzbdctclua2hb@mobilestation>
 <Y0b5UAMXPWbDC6HK@zn.tnic>
 <20221012192743.ihy4nidkzxweqebj@mobilestation>
 <Y0cZAGhUAzH6S9vI@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0cZAGhUAzH6S9vI@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 12, 2022 at 09:44:00PM +0200, Borislav Petkov wrote:
> On Wed, Oct 12, 2022 at 10:27:43PM +0300, Serge Semin wrote:
> > ... inter-device parts of the core. The registration procedure is
> > protected by the mutex and RCU. So it seems as the EDAC core developer
> 
> Seems, schmeems. As I said already, EDAC has always had a single
> chipset-specific driver. Period. So if one needs to run more than one
> chipset-specific driver concurrently, then the whole code needs to be
> audited because this hasn't been done before.
> 
> > If it has never needed to, then please explain why did you let the
> > Synopsys EDAC driver being accepted like that then? 
> 
> I think I already did.

Kind of. What you didn't explain was the driver-specific problem in the
edac_mc core. What is the difference in the EDAC core handling
two devices (including of difference types) on the same platform and
handling the same devices each probed by two different drivers? (Consider
the drivers are designed thread-safe and we are talking about the EDAC
MC core.)

> 
> > In my case it's a single EDAC driver per-chip. There can be several
> > DDR-controllers installed on the same SoC, but all of them of the same
> > type (Synopsys DW uMCTL2 v2.61a).
> 
> Good.
> 
> I'll look at your patches as time allows.

Ok. Thanks in advance.

-Sergey

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
