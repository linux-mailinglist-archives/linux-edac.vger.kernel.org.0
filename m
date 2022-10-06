Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44535F65D0
	for <lists+linux-edac@lfdr.de>; Thu,  6 Oct 2022 14:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiJFMRs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Oct 2022 08:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFMRq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Oct 2022 08:17:46 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AB08307D;
        Thu,  6 Oct 2022 05:17:45 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s10so2017247ljp.5;
        Thu, 06 Oct 2022 05:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HaC2yQrwwb3ltz9nk5cY8Bb4jG2BU0i98Vnm/oUw4yw=;
        b=BkefqODvffFoUD6bpmhqCSU58pUq1lkP/wgAlRbkn65PaaUlvTw61yk9iFWfqKIk+r
         P4ywZkhUsDDuoNGOJ+gnoXFf16skJIYhiLT1LqA2gxv1crcySbFdo6hD7X669BO8adVB
         grP9GuKNrXAW1T5cgCpXa8g8b6SRz6HDhVJQ5QwO2zfxrCmv8Bn7+rebMVHu9PMS23nU
         Jq/fuKREluWvJRvu7N9yM1IdBijiAsEmArFZc1Vl7zVnXQc+LxbITY1LkOYzBmGAye7j
         LRgHkjYIQtyH4pCsAC83m8pxsH1/V2AVOHQIBRp0yqgrNtv0pcUKwRFy2UXDDaJv+Alm
         4OCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaC2yQrwwb3ltz9nk5cY8Bb4jG2BU0i98Vnm/oUw4yw=;
        b=hi4fm25o3YGsabaIWYk0+WuCNKq1Au5D6UgxT7OiAL+HRdHZBTHEzvq1EWsvwwpH0L
         KJ7jKus09PylMzxAtx+MfWJdqM7QXkUhzXzinX30GGqf4jeX5g0Rc5W4KqadgAwmav9S
         VvW30K0kXTwmgCOQxKfXR9PvAFk5+HU/Yy3z2WzHQQcsfAJw8LB+PG9eaolbjsMdhfP3
         Oc6x49RIOOZPU0EU0nP1+swO+eH9Qebe38fW0d10ICT3aZCMGYC0ehH2VUV6k+KlvWI3
         omAcoP5ODKLj6PoZHm/Y+ssvSy+L8VFP9VLsQOP28L9bIvF5urLI3qmDvkLd4VtAiEBq
         jZRw==
X-Gm-Message-State: ACrzQf0zEhQzvEAhnzagw9d3Wh+i2VSMfKQU4Xj71NlIthpBi4LCQANF
        kdtebRDIJHKx55NEmRtoHQs=
X-Google-Smtp-Source: AMsMyM5nsa5pqD4oTyEg4jpeaFQN7jBMq43YAxt09uQ7Tagedw4q28BB5YW7Q5PnV3oMV+q1yuJA0g==
X-Received: by 2002:a05:651c:102b:b0:26e:5ae:971d with SMTP id w11-20020a05651c102b00b0026e05ae971dmr249052ljm.72.1665058663476;
        Thu, 06 Oct 2022 05:17:43 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id n5-20020a0565120ac500b0048a9e899693sm2684796lfu.16.2022.10.06.05.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:17:42 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:17:40 +0300
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
Message-ID: <20221006121740.ksugoodbagr45fky@mobilestation>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <20220929232712.12202-15-Sergey.Semin@baikalelectronics.ru>
 <YzcAV2I/rhILfhwR@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzcAV2I/rhILfhwR@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 30, 2022 at 04:42:31PM +0200, Borislav Petkov wrote:
> On Fri, Sep 30, 2022 at 02:27:09AM +0300, Serge Semin wrote:
> > It was a bad idea in the first place to combine two absolutely different
> > controllers support in a single driver [1]. It caused having an additional
> > level of abstraction, which obviously have needlessly overcomplicated the
> > driver and as such caused many problems in the new main controller
> > features support implementation. The solution looks even more unreasonable
> > now seeing the justification of having both controllers support in a
> > single driver hasn't been implemented by the original code author [2].
> 

> Yeah, no, you need to give more concrete details here.
> 
> Why exactly is this a problem?

In general because it needlessly overcomplicates the driver, worsen
it scalability, maintainability and readability, makes it much harder
to add new controller features. Moreover even if you still able to add
some more features support the driver will get to be more and more messy
(as Michal correctly said in the original thread [1]). It will get to
be messy since you'll need to add more if-flag-else conditionals or
define new device-specific callbacks to select the right code path for
different controllers; you'll need to define some private data
specific to one controller and unused in another. All of that you
already have in the driver and all of that would be unneeded should the
driver author have followed the standard kernel bus-device-driver model.

Regarding this particular case. This series and two more patchsets
mentioned in the cover letter are about extending the Synopsys uMCTL2
DDRC controller functionality support in the driver. Here is just the
most significant part of the being added features:
1. DW uCMTL2 IP-core parameters auto-detection (DDR bus-width, frequency
ratio, burst-length, ECC-mode, etc).
2. Common SDRAM<->phys address translation.
3. Multi-ranked memory support.
4. ECC-scrubber and Scrubber IRQ support.
5. Individual IRQ signals support.
6. DFI alert_n IRQ support.
7. Add reference clock sources support.

None of the above can be utilized for the Zynq A05 DDR controller, but
is of the Synopsys uMCTL2 DDRC specific. Seeing the controllers are
not even of the same vendor and are absolutely incompatible,
considering all the new features, moving the Zynq A05 DDRC support
away to another driver was the best choice in order to create a
coherent and easy-to-read code, provide simple-enough patches for
review. The standard kernel bus-device-driver model is perfectly
suitable to differentiate these controllers. There is no point in
creating an additional abstraction.

> 
> Are you saying that if synopsys puts out 10 incompatible memory
> controllers, we should have 10 separate EDAC drivers?

I said "absolutely different controllers" in the patchlog. The level
of incompatibility can be different and can vary from case to case. In
this particular case there is nothing in common in Synopsys uMCTL2
DDRC and Zynq A05 DDRC. So if there are two absolutely different
devices at consideration then in general they should be handled in
different drivers as per the kernel bus-device-driver model.

Note having absolutely different devices detectable on the same
platform doesn't mean they should be handled by the same driver
otherwise the kernel would have had tons of common platform-drivers
instead of the device-specific ones. Even in current synopsys EDAC
driver state (without my patches applied) should you detach the Zynq
A05 DDRC support to another driver, the code would have got to be much
easier to read and maintain.

I one more time draw your attention to the fact that the original
reason of having both Synopsys uMCTL2 and Zynq A05 DDRC support in the
same driver has never been implemented [2]. See edac_mc_alloc()
is always called with index zero in the driver. Even despite of that I
still provide a way to solve the problem denoted in [2] in the patch
"EDAC/mc: Add MC unique index allocation procedure" in this patchset.

> 
> Hell no.
> 

> synopsys_edac.c is not a huge file and the probe logic which matches
> which synps_platform_data to load is pretty straight-forward to me.

The synps_platform_data interface is so abstractive so you could have
added any basic EDAC device support to the driver. It doesn't mean you
should even if the devices can be detected on the same platform,
especially if you expect the code to evolve further being extended with
new more complex features.

> 
> But maybe I'm missing something so please explain in detail what the
> actual problems with this are?

In this case I'd say the KISS principle applies. Simplification will
be reached by splitting the driver up only. I understand that it
couldn't have been done back then due to the original driver author
claiming the EDAC core to require the MC auto-index generation [2].
That's why I have added such functionality in the framework of this
series.

[1] https://lore.kernel.org/all/808655a9-77eb-4e3a-9781-2b059ad9517b@BN1AFFO11FD020.protection.gbl/
[2] https://lore.kernel.org/all/9dc2a947-d2ab-4f00-8ed3-d2499cb6fdfd@BN1BFFO11FD002.protection.gbl/

-Sergey

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
