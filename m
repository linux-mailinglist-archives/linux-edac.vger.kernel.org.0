Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F69048E088
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jan 2022 23:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiAMWnJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jan 2022 17:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiAMWnG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 13 Jan 2022 17:43:06 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EB8C06173E
        for <linux-edac@vger.kernel.org>; Thu, 13 Jan 2022 14:43:06 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id x20so1170919pgk.1
        for <linux-edac@vger.kernel.org>; Thu, 13 Jan 2022 14:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=YbEI3Q/NEjCtDTVCV1jkA7nYNYBH/Wfa2wk3IkVyJko=;
        b=jEdbi3g5rG8VBJFcbi+jVr5GHBmnFDB+4j3C7NEaOIWN99ezPINYRJXxrbAhVnBhge
         dTpRF4xCpq81hKJrhOiAkcWRRND4S/7atZrdyiVJnnA5AzuZTsSiJr1kgHblvGkE1gwK
         FMZzx1ti807ZU17uY1icDZgcPuhTPsy/nklfcTR6Rmu3Q28LEDVPpja+OmbQBB2AhNBT
         lxpH5225wSwX08Uxq8d4/0aPDqg3bxF9U/DsjaLHbTweXlfnWFP+o9DoP7jvpoaOUS4T
         UKgM8uhwPN1i+awhGT+Q43NXiYPaIDsDsE5S4YDHus0ZTEIsGKHL1gDuI9V6LbSLq5df
         Tyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=YbEI3Q/NEjCtDTVCV1jkA7nYNYBH/Wfa2wk3IkVyJko=;
        b=k8VrCnzjyCXcv4Z70OVE/GmH6CFcLkZfg6oKGEPEPV4w9PVJ8kkdcAjp5tV1CQ2OrM
         epwzoHe5s+T3BtfxJuS0HklTVDcLH/cdxXih/h3NYY4ocBJoNHZrG+I25IDsA/abCjDE
         06h3yR5f6+SXb/lvUViOSpeBUHTDj8cM6GSJZ084NseMefufqFj2rGTOVUxyu1WbVO6h
         wnxYXMnPwSR8/3XxCuN3iM1dVYYb2YaVDd+n6i6sBBRXgqX2m0IQWqJAP6/vT8ODRnap
         nNxrcfdAP4dIlI0prtR/o2WaDC6fDqG1SU0p/yqtKr7FooSXuTAaX5RnHo0AJnxbWovN
         8cog==
X-Gm-Message-State: AOAM532mkRLrMacpYjtgmLsi/rvpjO2AmNxOb3N2XcVnL0Chz54PAmHQ
        iIKux/rZh+clv9BhUMQIhXjYYZPD9VSHRmHnZww=
X-Google-Smtp-Source: ABdhPJzC1p2sRakG86QBjYrD+ATpOAvgqOL5hbzTs+MqEbm/iqT+eGzetJ0l2s9sX0BO+JsRtp3+IqhI81k4s3/jEEs=
X-Received: by 2002:a05:6a00:2391:b0:4a2:cb64:2c97 with SMTP id
 f17-20020a056a00239100b004a2cb642c97mr6270162pfc.36.1642113786143; Thu, 13
 Jan 2022 14:43:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:f38c:0:0:0:0 with HTTP; Thu, 13 Jan 2022 14:43:05
 -0800 (PST)
Reply-To: mchristophdaniel@gmail.com
From:   Marcus Galois <marcus.galois@gmail.com>
Date:   Thu, 13 Jan 2022 23:43:05 +0100
Message-ID: <CANqBaXVyTFcov3oJmiL7YzhLMerdrb2yC8QizOG6MOyH4KVVvw@mail.gmail.com>
Subject: Good News Finally.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello friend.

You might find it so difficult to remember me, though it is indeed a
very long time, I am much delighted to contact you again after a long
period of time, I remember you despite circumstances that made things
not worked out as we projected then. I want to inform you that the
transaction we're doing together then finally worked out and I decided
to contact you and to let you know because of your tremendous effort
to make things work out then.

Meanwhile I must inform you that I'm presently in Caribbean Island for
numerous business negotiation with some partners. with my sincere
heart i have decided to compensate you with USD$900,000 for your
dedication then on our transaction, you tried so much that period and
I appreciated your effort. I wrote a cheque/check on your name, as
soon as you receive it, you let me know.

Contact my secretary now on his email: mchristophdaniel@gmail.com
Name: Mr. Christoph Daniel

You are to forward to him your Name........ Address.......,Phone
number......for shipment/dispatch of the cheque/Check to you

Regards,
Mr. Marcus Galois
