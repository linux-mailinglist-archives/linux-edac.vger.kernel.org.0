Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5875F81A3
	for <lists+linux-edac@lfdr.de>; Sat,  8 Oct 2022 02:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJHAmb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Oct 2022 20:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJHAma (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 7 Oct 2022 20:42:30 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974D88E0C8;
        Fri,  7 Oct 2022 17:42:29 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id f9so7426206ljk.12;
        Fri, 07 Oct 2022 17:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EWAPBnezUCKP64JAhKkQx4qOysooFhc6GZFtUeg2dhI=;
        b=IhyWg+FLCjabhYMwwyaGFAluhb064/70v/d5QDzasAWea21gqhido7Ws8Fgyvr1T71
         PZEiputMrJv25A/Sac1YhQP9a0BQJcXDkzLt2/D5CGTFZP3374lEDeD3S677tewlybTv
         rDPiAHsW84mCy+jXKEqAM0P6BBGZAg52hCpaQ5KxoexnrAPAaJ8dZb7o/1HIW2VL3Ab/
         fL9/QCGgabPap3RRHDn90oBuNOTpOWC6YqsAsK//EfpX5eJZ/roL6Ga1EECwwF0KMEm9
         qy557GKMWvi9f6OsxYG5eU+jRDTwKcRbIKS/x0W8qnfuqT1VRcvj75y6XvgW/qkGbLVO
         uw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWAPBnezUCKP64JAhKkQx4qOysooFhc6GZFtUeg2dhI=;
        b=ihxvrzMBfaWIpnj71uQDJY8kKaL4u6ImlnjRyeFxaomV7Zr8akHz7XvyCidwa4hEC9
         2llhzGYZSuQ2LBYgfgnoEGlNblrWl+6QFoBGZP8c8ctK+qgVh2yXZ5AZDzPZqM/YHtz8
         apySOXL8ZdmtcESMUOPCjG4G6DqNR4gWyr8Nqz6K4x0bmXeJtnwyfc8xmS9qToSOHmtI
         UkmSUXGGNcddOo4E98MNyQgp1dIzEs6qID9bgiSryBo269T4CMQZ2U+q4+sJp4vCVqw7
         NaVljmgY78vIemx46SuAWjYqc9gtABKJWCe8nOKeT9Gr6HxHXxDMOkA4Cf9V04DjHIvT
         MrTg==
X-Gm-Message-State: ACrzQf2SxFzgeix5EyT7VAgJjuzAQQLVqevzATC3OHHP8L+kycRCCSRT
        3A0KRXkekRLu654IuWLH+bU=
X-Google-Smtp-Source: AMsMyM49grFmO4p1twZNlHTxenKJ36XQur8FMu+rmD1vJTwJPqRO+lMrKro2wvT0vbwXkAUi0AmgLw==
X-Received: by 2002:a2e:9c89:0:b0:26e:502:f26 with SMTP id x9-20020a2e9c89000000b0026e05020f26mr2536298lji.269.1665189747816;
        Fri, 07 Oct 2022 17:42:27 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id t14-20020a056512208e00b004a25468d86asm483510lfr.68.2022.10.07.17.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 17:42:27 -0700 (PDT)
Date:   Sat, 8 Oct 2022 03:42:24 +0300
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
Message-ID: <20221008004224.owqbzbdctclua2hb@mobilestation>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <20220929232712.12202-15-Sergey.Semin@baikalelectronics.ru>
 <YzcAV2I/rhILfhwR@zn.tnic>
 <20221006121740.ksugoodbagr45fky@mobilestation>
 <Yz7XVqeopgGVR7+3@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz7XVqeopgGVR7+3@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 06, 2022 at 03:25:42PM +0200, Borislav Petkov wrote:
> On Thu, Oct 06, 2022 at 03:17:40PM +0300, Serge Semin wrote:
> > In general because it needlessly overcomplicates the driver, worsen
> > it scalability, maintainability and readability, makes it much harder
> > to add new controller features. Moreover even if you still able to add
> > some more features support the driver will get to be more and more messy
> > (as Michal correctly said in the original thread [1]).
> 

> Did you read that thread until the end?

Of course I did. Here is a short summary:

1. @Punnaiah described that he got a Zynq system with two different
DDR controllers. One of them was Synopsys DW uMCTL2 DDRC (ARM cortex A9
PS) and another one - Zynq A05 DDRC (Xilinx PL). All of these DDR
controllers could be probed in Linux. It was required to detect the ECC
errors for both of them.

2. @Punnaiah suggested that both of these controllers should have been
handled by two different drivers since the controllers were different.
But he was reasonably afraid that there could be a race condition for
the mc_num assignment since it was the drivers responsibility to
allocate one.

3. @Punnaiah suggested two solutions: 1) Keep two drivers in single file
and use static global variable for tracking the mc_num. 2) Let the
framework assign the mc_num to the edac driver.

4. @Punnaiah preferred the solution 2, but you said that the solution
1 would do it.

5. @Michal was against mixing up the support of two different devices
in a single driver. He reasonably assumed that the driver would get
to look messy. 

6. @Boris disagreed saying that it won't be messy and any
communication between the two memory controllers could be done
internally in that driver.

7. So you all decided to keep both controllers support in a single file,
but would get back to a discussion of having separate drivers for them
later.

But after all these years of the Synopsys EDAC driver living in kernel
we can conclude that combining the two different devices support in a
single driver was pointless. First by the driver design nobody ever
used the driver to handle both of them at the same time (MC index is
fixed to zero). Second there is no even a glimpse of communications
between two devices in the system. Third there are two different set
of macros and multiple platform-specific methods and if-flag-else
statements fully abstracting out the devices implementation from the
EDAC core.  All of that has made the driver overcomplicated in-vain
seeing none of the reasons of these complications have been realised.
Meanwhile extending further the Synopsys uMCTL2 DDR controller
functionality support would mean adding new macros, functions,
platform-specific flags, parameters and device-specific data. That
would have made the driver even more complicated. Dropping the
abstraction layer out and splitting up the drivers was the best choice
in the current circumstances especially seeing the driver author and
@Michal preferred that solution in the first place.

Moreover in order to cover a still possible case of having both
Synopsys uMCTL2 DDRC and Zynq A05 DDRC used on the same system in
future I have implemented the solution 2.

> 
> > It will get to be messy since you'll need to add more if-flag-else
> > conditionals or define new device-specific callbacks to select the
> > right code path for different controllers; you'll need to define
> > some private data specific to one controller and unused in another.
> > All of that you already have in the driver and all of that would be
> > unneeded should the driver author have followed the standard kernel
> > bus-device-driver model.
> 

> So lemme ask this again because the last time it all sounded weird and I
> don't think it got clarified fully: you cannot have more than one memory
> controller type at the same time on those systems, can you?

To be clear I don't work with the Xilinx systems. So I can only say based
on your discussion with @Punnaiah on the initial driver review.
@Punnaiah said they could have more than one memory controller type on
their systems. That's why he described the problem with the MC indexes
allocation and suggested to combine the devices support in a single
driver.

> 
> Because if you can and you want to support that, the current EDAC
> "design" allows to have only a single EDAC driver per system. So you
> can't do two drivers now.

I do understand that.

> 
> If your answer to that is
> 
> Subject: [PATCH RESEND v3 13/17] EDAC/mc: Add MC unique index allocation procedure
> 
> then I'm sceptical but I'd need to look at that first.

Em, if there is something else which makes the EDAC drivers to be
impossible to co-exist on the same system, then it greatly violates
the bus-device-driver model.

> 
> And reading your commit messages, you're talking a lot about what you're
> doing. But that should be visible from the patch. What I wanna read is
> *why* you're doing it.

Each patchlog has a thorough enough description of "why".

> 
> Like in this patch above, what's that "unique index allocation
> procedure" for?

Have you read the patchlog? 

> 
> edac_mc_alloc() already gets a mc_num as the MC number.
> 
> And yes, if you want to do multiple driver instances like x86 does per
> NUMA node instances, then that is done with edac_mc_alloc() which gives
> you a memory controller descriptor and then you can deal with those.
> 

See the "EDAC/mc: Add MC unique index allocation procedure" patch. It
also provides a way to assign the indexes based on the OF-aliases.

> From all the text it sounds to me you want to add a separate driver for
> that Zynq A05 thing but I might still be missing something...

I do want to detach the Zynq A05 device support from out of the
Synopsys uMCTL2 driver.

BTW have you read the cover letter? It contains a short summary of the
changes and their justification. It seems as if you started your
review straight from this patch.

-Sergey

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
