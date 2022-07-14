Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D1E574D2D
	for <lists+linux-edac@lfdr.de>; Thu, 14 Jul 2022 14:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbiGNMLx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Jul 2022 08:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238849AbiGNMLk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Jul 2022 08:11:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D677C5D5A0
        for <linux-edac@vger.kernel.org>; Thu, 14 Jul 2022 05:10:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v16so2259461wrd.13
        for <linux-edac@vger.kernel.org>; Thu, 14 Jul 2022 05:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y5Tg7l3XIXoLarUSKVZXEIQ6qB8NqY7J9uUJaMOQEX8=;
        b=b/ypvXVyh+dDxJNobrL9DNZ1DoTaduf7JAcxjZ4FguVhuYGZjXPdNS5C3UDuBmE3JX
         B5BVsODBbBg4sgftte7GAxhPHdvpFPAAGPql53cVq4Oee/IumsBM1qvYwyKDpGX9OFd9
         OCghFn7ZZhG14Ro3ckNC3+/t82pvU1ECLnWquKP5LGO9Dffux4Jysc13mVFUjKiIQ7P4
         7G9H4ojcn7vuZ9//k56Ucu3Js86jjVaMY3H8ckafZ7oYSFwTgQ9CKX71g7WJM9QhYS6a
         dB0gF/WK12cO461nmCJn9BDxYvx9wI6OMw5AGJSj9PfJlzmyvfCtv3TyoYWlx3KBp1YG
         0zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y5Tg7l3XIXoLarUSKVZXEIQ6qB8NqY7J9uUJaMOQEX8=;
        b=528uvUr0UvuGEu9dCl8KdYMpjE1sbNto3qPqWJGXFOMrlt2LtL8j1sodVXat+xihch
         mRLb0crpdoiFzLu3uiPEHgwRyPpMQx7IzRjs/NijzQWY2zTbLuZGQMh/uIHzmMaEaIyw
         rieODejvsVFzETkqKl48XdYAv4onaAWIgn3hlnbbWGG5QSfC7otNg0VB0aY15GdgnwSn
         2M3nZnp2X0QcwHYflW6hIZ9HTNeFXJugp0sv9D43TG7TDIHXMhzi0AkZ3iXx7yTqEMzw
         /wPuL4Lf+1BD6W9+cnYmZbuBOw/V+kukuVf4bLYZqHIWMmneHOR+vftCoMms9FVl3LCE
         j/bg==
X-Gm-Message-State: AJIora8n+vMu0XaG472g7oqZwtzCjtSS0wTRQ9BmslmRDugfJtaYtIoO
        pJpq62ehnygSw2GjgS8974SHYA==
X-Google-Smtp-Source: AGRyM1v/MKz110s+XqlPHUIpr1tAlhGTb2EkTdhvuwwGbX91Jd/nkFrdVfYH/EhwzLayzDaDhecP8g==
X-Received: by 2002:adf:f5c7:0:b0:21d:7f20:7508 with SMTP id k7-20020adff5c7000000b0021d7f207508mr7965566wrp.458.1657800652395;
        Thu, 14 Jul 2022 05:10:52 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b003976fbfbf00sm2121158wms.30.2022.07.14.05.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 05:10:51 -0700 (PDT)
Date:   Thu, 14 Jul 2022 13:10:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, Wolfram Sang <wsa@kernel.org>,
        Jean Delvare <jdelvare@suse.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Henning Schild <henning.schild@siemens.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Yong <jonathan.yong@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v6 00/12] platform/x86: introduce p2sb_bar() helper
Message-ID: <YtAHyZ5WHDRbgOZe@google.com>
References: <20220606164138.66535-1-andriy.shevchenko@linux.intel.com>
 <YqBS8I62YBPFC9iS@google.com>
 <20220714112656.GB16407@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714112656.GB16407@duo.ucw.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 14 Jul 2022, Pavel Machek wrote:

> On Wed 2022-06-08 08:42:40, Lee Jones wrote:
> > On Mon, 06 Jun 2022, Andy Shevchenko wrote:
> > 
> > > There are a few users that would like to utilize P2SB mechanism of hiding
> > > and unhiding a device from the PCI configuration space.
> > > 
> > > Here is the series to consolidate p2sb handling code for existing users
> > > and to provide a generic way for new comer(s).
> > > 
> > > It also includes a patch to enable GPIO controllers on Apollo Lake
> > > when it's used with ABL bootloader w/o ACPI support.
> > > 
> > > The patch that brings the helper ("platform/x86/intel: Add Primary to
> > > Sideband (P2SB) bridge support") has a commit message that sheds a light
> > > on what the P2SB is and why this is needed.
> > > 
> > > I have tested this on Apollo Lake platform (I'm able to see SPI NOR and
> > > since we have an ACPI device for GPIO I do not see any attempts to recreate
> > > one).
> > > 
> > > The series is ready to be merged via MFD tree, but see below.
> > > 
> > > The series also includes updates for Simatic IPC drivers that partially
> > > tagged by respective maintainers (the main question is if Pavel is okay
> > > with the last three patches, since I believe Hans is okay with removing
> > > some code under PDx86). Hence the first 8 patches can be merged right
> > > away and the rest when Pavel does his review.
> > 
> > Can we just wait for Pavel's review, then merge them all at once?
> 
> 10,12: Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks Pavel.  I'll get that added.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
