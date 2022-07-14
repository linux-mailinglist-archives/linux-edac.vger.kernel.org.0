Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF69574AB4
	for <lists+linux-edac@lfdr.de>; Thu, 14 Jul 2022 12:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbiGNKel (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Jul 2022 06:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237998AbiGNKej (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Jul 2022 06:34:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345234BD17
        for <linux-edac@vger.kernel.org>; Thu, 14 Jul 2022 03:34:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so800292wmb.3
        for <linux-edac@vger.kernel.org>; Thu, 14 Jul 2022 03:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=W6txFljYfKmn6JSD3sjou2N7DJFkcDR6jeyYOHSyWrU=;
        b=gvZ4kN1Ki6OChldKcT3MpnPrFEubJtUXdh8C24U5b24nOK5/h+IFIOOL4CSL0vw4tB
         iVOziuWudewMTKVk3jRln6XJM9BdGVWQJpYrvPZoS0SRyNbLJDbnqmHX0OiTMC93EAOI
         JcjhtEYjG85cPEi1tixKsAG20DrICDh0hKOQLzzsHeY4b0HCr55DYiwKJVRFDU7Kdu+O
         mxNZJRlpNVvagt18yu/SJI6rr+Lj/fJT40FO71qf5KPgkWcpez7epwuyUNaFMA3yLK4j
         Om94Y3m17NS1I+wO1+1v1Mu6M3C0Kq4jL6mLU3G2P9kcle0kBLSnLPUfLwZ0LLN/ruDR
         duVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W6txFljYfKmn6JSD3sjou2N7DJFkcDR6jeyYOHSyWrU=;
        b=KrFzvgcBV3ISRn42/kGVjcO9G2ptxISJ9pISl9uZrEZ/b8u1Ni6+jKlWnB5FIM8Dwt
         A+93zBe0er3+R58+CcSU/TD9FpnhtRaSwbhP99gtuuztf0XLqQEmF/GroYOBS4QTT3VZ
         QHhPd6XoDIx6LG8yPdFXfF9ahPWFja6dHOIwqCU1c8WP5Dw4UUTowrt5Zgr+pr50x9zE
         PXiqYgTsNtMfDcVHQqrIDCb59+GnhAwCP+vuE6bmPfHqXl1GQehpNd+2dHuhkMhQxbYQ
         GKT2lPrxT04k2xT8B44yt2WGGzI1tMoJEMaY/lG7JUXodnlsjoGxgDNVwMagnYyMaf2L
         Q7ZQ==
X-Gm-Message-State: AJIora84815Z7N6cyx9MYVJttlSJ/6yYCKYhWBIMh+1m+fwPGEr+E5Pz
        3P56O1gfn6+gAYQ/tpcC1H8w0w==
X-Google-Smtp-Source: AGRyM1s4Lh53O5b+jj1CVhSlBTSYJOqKGj742dw9wSLaQ2htY7KgAPxfs1Ue9vLFbkz25LTPVtIDCQ==
X-Received: by 2002:a05:600c:1908:b0:3a0:bfaa:38c with SMTP id j8-20020a05600c190800b003a0bfaa038cmr8428781wmq.130.1657794874579;
        Thu, 14 Jul 2022 03:34:34 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000180900b0021d6a520ce9sm1094947wrh.47.2022.07.14.03.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:34:34 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:34:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Henning Schild <henning.schild@siemens.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Wolfram Sang <wsa@kernel.org>,
        Jean Delvare <jdelvare@suse.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Yong <jonathan.yong@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-edac@vger.kernel.org, linux-i2c <linux-i2c@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v6 00/12] platform/x86: introduce p2sb_bar() helper
Message-ID: <Ys/xN+6P0DvMrDOC@google.com>
References: <20220606164138.66535-1-andriy.shevchenko@linux.intel.com>
 <YqBS8I62YBPFC9iS@google.com>
 <CAHp75Ve9Lju8AEQd5huz1aYGg4sOu-ae7tTdyDWCXPCBR=wXbQ@mail.gmail.com>
 <YrGyWCaY+swYAYzH@smile.fi.intel.com>
 <YryAXlZqcr/liN7n@smile.fi.intel.com>
 <20220629191406.35965d5b@md1za8fc.ad001.siemens.net>
 <Ys71dyMdozGUAto0@smile.fi.intel.com>
 <20220713204827.0b290fd7@md1za8fc.ad001.siemens.net>
 <Ys/jz7HqhrxSCOnV@google.com>
 <Ys/ukP8dqnwUoou4@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ys/ukP8dqnwUoou4@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 14 Jul 2022, Andy Shevchenko wrote:

> On Thu, Jul 14, 2022 at 10:37:19AM +0100, Lee Jones wrote:
> > On Wed, 13 Jul 2022, Henning Schild wrote:
> > > Am Wed, 13 Jul 2022 19:40:23 +0300
> > > schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> 
> ...
> 
> > > And maybe there is a way/process to escalate to another maintainer.
> > > Does anyone even know what is going on with Pavel? 
> > 
> > I'll take the hit.  He had his chance.
> > 
> > I'm happy to move forward with Andy's review.
> 
> Thank you, Lee, much appreciated!
> The patches (9..12) have my SoB, I think it should be enough, but if you thinks
> they need my Rb tag, I can reply to them with it.

That's okay.  I've applied them and they are currently in soak.

> > (Side note: Seeing as Pavel hasn't been seen for 2 months, I'll also
> >  follow-up on  the LED ML to offer to become temporary maintainer for a
> >  bit)
> 
> This is good news as well, because I noticed there are a few series there stuck
> as well.

Feel free to reply to object or in support:

https://lore.kernel.org/all/Ys%2Fkruf8DE4ISo8M@google.com/

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
