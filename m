Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E916E5FCB93
	for <lists+linux-edac@lfdr.de>; Wed, 12 Oct 2022 21:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJLT1u (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Oct 2022 15:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJLT1t (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Oct 2022 15:27:49 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F43FF255;
        Wed, 12 Oct 2022 12:27:48 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q7so19338366ljp.3;
        Wed, 12 Oct 2022 12:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MfeDoK0lHqJSQ+8XSsNrm9RX16bLPg2MaCdFsvsR0gQ=;
        b=kDiSH5y2o+H8yMW6xFolH2JJoq88FPbIbP1jewr8mrvgg4MalcchWPRiB3SKeCl6QC
         JELZOevCXHyKFA5foxYnLrXMiZqm9fr7Jb5QrFFOdB9gpCc+KJt4t0q2G+CpCtuhVFnr
         zpQDCHR7lLjcovsLaUs9ycH14BrFKe5bbY+gRTsx2BAEfMlq2zXq412cKZQ0AevTzWze
         MqgVB6yfI4k8lqcZZWAGJNFoLewW7G6nZv0LXyNz/V/cSIyvLjLGXIvWAqGjmsS7cH6G
         fT1Axh6SadtRY/AMKOX8yYqztiNdEFVWzOFBDeXBsgbjaBYll8XPqu6SLl9mUNB4LlaP
         lZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfeDoK0lHqJSQ+8XSsNrm9RX16bLPg2MaCdFsvsR0gQ=;
        b=bZAlDl0W9vlcIt1HUWt6YOPWYuHyFwnjJNQp8oG89qhkw+ko6SagmX3AQ6Kr+VaYQR
         SrJAfwtWHqP3WFqD0PNVsq9AqAkb2+7hQQITtXZCbQ3e7SDDtTT5gO7kMFSjrRF9i093
         X5dtTropOgWRTJPszaIUqOgNgug7/UT3cVeZMqYRw49xdoxrDxTKZzHcLN/FGmvdDgi8
         qrytgAkxjGZr5tRE2lcEABvsxKLNjVdcx5paoX6Yp5i2jJHRdViqmO5CZl5jHNzQMsz2
         MzMMjruk2f8y34HJsWSCIpkD/MPxQTZD0NJzAfCCM3YzJlu1WCaY93T/1Ez36hT9gPU/
         fROg==
X-Gm-Message-State: ACrzQf115djGw88c7LCdYau68jm30ijkc8XZUUHq2tclQACjTM47uVzP
        wRS3WFUp6M1I2gdBjEmRCFE=
X-Google-Smtp-Source: AMsMyM628HI6sIVEd9p+5Lz2Siq9e50lLruZnhKfeQoPB3dFcTmcRFM1abdobgvlnpgc38LuSteWTA==
X-Received: by 2002:a05:651c:506:b0:26e:6fa:8a53 with SMTP id o6-20020a05651c050600b0026e06fa8a53mr10894300ljp.93.1665602866387;
        Wed, 12 Oct 2022 12:27:46 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id d15-20020ac244cf000000b0048a982ad0a8sm84690lfm.23.2022.10.12.12.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 12:27:45 -0700 (PDT)
Date:   Wed, 12 Oct 2022 22:27:43 +0300
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
Message-ID: <20221012192743.ihy4nidkzxweqebj@mobilestation>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <20220929232712.12202-15-Sergey.Semin@baikalelectronics.ru>
 <YzcAV2I/rhILfhwR@zn.tnic>
 <20221006121740.ksugoodbagr45fky@mobilestation>
 <Yz7XVqeopgGVR7+3@zn.tnic>
 <20221008004224.owqbzbdctclua2hb@mobilestation>
 <Y0b5UAMXPWbDC6HK@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0b5UAMXPWbDC6HK@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 12, 2022 at 07:28:48PM +0200, Borislav Petkov wrote:
> On Sat, Oct 08, 2022 at 03:42:24AM +0300, Serge Semin wrote:
> > Of course I did. Here is a short summary:
> 
> You didn't have to do a short summary but sure, if you prefer...

It seemed to me as I should have so to make sure we are on the page of
the original discussion understanding.

> 
> > 7. So you all decided to keep both controllers support in a single file,
> > but would get back to a discussion of having separate drivers for them
> > later.
> 
> Yes, pretty much.
> 
> > But after all these years of the Synopsys EDAC driver living in kernel
> > we can conclude that combining the two different devices support in a
> > single driver was pointless. First by the driver design nobody ever
> > used the driver to handle both of them at the same time (MC index is
> > fixed to zero).
> 

> So how was this supposed to work on his system?

How am I supposed to know? You should have asked him at the time of
his patches review before accepting them. He (Punnaiah Choudary
Kalluri) said they had the system with two different DDR controllers.
Since the MC idx was supposed to be provided by the controller driver
he suggested to have both devices support implemented in the same
driver. You agreed. If no interaction intended between the two devices
why did he need to combine their support in the same driver then? He
could have as well just split the drivers up and didn't bother with
all the discussions.

> 
> If you have a system with two different memory controllers 

I don't. The Synopsys EDAC driver author (Punnaiah) did judging by
what he said in your discussion.

> and you want
> to have two different EDAC drivers for each, then the whole EDAC core
> code needs to be audited wrt concurrency and synchronizing access to
> its facilities because I don't think it has ever supported more than a
> single EDAC driver per system.

Once again. What is driver-depended do you have in the EDAC core?
Does it follow the bus-device-drivers model? I failed to find any
inter-driver dependency (what could be seen for instance in the
tty/serial subsystem). But I am not the subsystem maintainer after all.
I found the possible races in the MC index registration and fixed it
in the corresponding patch. But that was the just
registration-specifics behavior which could be easily fixed in the
same way as the most of the kernel subsystem do.

You are worried about the concurrencies. Does the EDAC core have
problems if there are several DDR devices of the same type probed?
AFAICS it doesn't as long as the indexes are properly allocated by the
driver. What is the problem with registering devices of different
types? The error counters are the MC-data-specific, so are the
sysfs-nodes. The EDAC MC error handler function doesn't touch any
inter-device parts of the core. The registration procedure is
protected by the mutex and RCU. So it seems as the EDAC core developer
thought about having the devices being registered concurrently.

> 
> And it has never needed to, at least not on x86 land. Which is
> currently changing because of CXL, because of accelerators needing
> RAS, GPUs needing RAS and so on and so on. So eventually we'd have to
> either put the new RAS functionality in the existing chipset-specific
> driver or have to go the multiple EDAC drivers route. But that's only
> tangential...

If it has never needed to, then please explain why did you let the
Synopsys EDAC driver being accepted like that then? 

> 
> So first I'd like to hear what your use case is: single EDAC driver for
> your particular Baical-T1 device or you need to support multiple EDAC
> drivers.

In my case it's a single EDAC driver per-chip. There can be several
DDR-controllers installed on the same SoC, but all of them of the same
type (Synopsys DW uMCTL2 v2.61a).

> 
> If so, why?

I don't have a system with different DDR controllers detected on the
same SoC but Punnaiah Choudary Kalluri, original Synopsys EDAC driver
developer, did.

> 
> > Moreover in order to cover a still possible case of having both
> > Synopsys uMCTL2 DDRC and Zynq A05 DDRC used on the same system in
> > future I have implemented the solution 2.
> 
> See above.
> 
> > Em, if there is something else which makes the EDAC drivers to be
> > impossible to co-exist on the same system, then it greatly violates
> > the bus-device-driver model.
> 
> If by that you mean the aspect of a driver associating with a device and
> performing operations with it then why do you assume that EDAC drivers
> have to adhere to that model?
> 
> > Have you read the patchlog?
> 
> Lemme reply to it directly.
> 
> > BTW have you read the cover letter? It contains a short summary of the
> > changes and their justification.
> 

> Yes, I have read it and it contains a lot of unnecessary detail which
> should be in the respective patches themselves. And I still don't know
> exactly what *you* are trying to do, as I said above.
> 
> A cover letter should contain a short executive summary explaining only
> the goal of the patchset and then you can go into details if you prefer.
> A reviewer should not have to dig into patch management details to know
> what this patchset is trying to do.

The main part of the letter starts exactly with the goals and then has
text with more details of what is done and why. It is enough to get a
notion regarding the patchset aim and content. Each patchlog starts
with the problem description, the suggested solution and some details
of the implementation I thought was required to add. Everything in
accordance with the kernel patches standards.

-Sergey

> 
> A possible structure could be:
> 
> Problem is A.
> 
> It happens because of B.
> 
> Fix it by doing C.
> 
> (Potentially do D).
> 
> Btw, when you're writing your commit messages, please use passive voice
> in your commit message: no "we" or "I", etc, and describe your changes
> in imperative mood.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
