Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EA7655FFA
	for <lists+linux-edac@lfdr.de>; Mon, 26 Dec 2022 05:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLZEuy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 25 Dec 2022 23:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLZEux (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 25 Dec 2022 23:50:53 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F56FE0;
        Sun, 25 Dec 2022 20:50:49 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B30A71EC0606;
        Mon, 26 Dec 2022 05:50:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672030247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2TqhcXRdNl3g+ClAVEK77kT8OaeakGMOWOaBw6GqDn0=;
        b=WFP3AndyTdJ/0Y24e5xR2XhHSdoolCbSftNI2Xh2gy9QqQhv52RTizBh9Ds2KQE4EIZFn+
        myKgbEhCq4N20ADJiiZGS235J4SUISmWVGrxghd/rPvAQtWzOyUG+aitPjnDjB51rdJpz0
        yViGK+/U5sHd+jG7L4Z0oIyJGL1s+TQ=
Date:   Mon, 26 Dec 2022 05:50:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kun-Fa Lin <milkfafa@gmail.com>
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, benjaminfair@google.com, yuenn@google.com,
        venture@google.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        ctcchien@nuvoton.com, kflin@nuvoton.com
Subject: Re: [PATCH v17 3/3] EDAC/npcm: Add NPCM memory controller driver
Message-ID: <Y6koIrTN2PYpQVGO@zn.tnic>
References: <20221223032859.3055638-1-milkfafa@gmail.com>
 <20221223032859.3055638-4-milkfafa@gmail.com>
 <Y6WniKjA6BHLknP6@zn.tnic>
 <CADnNmFqQ5_OQ-FiqdSZAtXFdG2X=qociXBykqL0TqtMw9r_=_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnNmFqQ5_OQ-FiqdSZAtXFdG2X=qociXBykqL0TqtMw9r_=_A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Dec 26, 2022 at 11:50:54AM +0800, Kun-Fa Lin wrote:
> > > +             syndrome = priv->location ? 1 << priv->bit :
> > > +                        data_synd[priv->bit];
> >
> >                 syndrome = priv->location ? 1 << priv->bit
> >                                           : data_synd[priv->bit];
> 
> Just to confirm the indentation, is it right as follows?
> 
> syndrome = priv->location ? 1 << priv->bit
>                                            : data_synd[priv->bit];
> 
> And I was wondering if I should just remove the line break and let it stick out?

The idea is to have the '?' and the ':' under each other so that one
can visually immediately "parse" where each of the sides of the ternary
statement start.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
