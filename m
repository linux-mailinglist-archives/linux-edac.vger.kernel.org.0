Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EBE5FCBC5
	for <lists+linux-edac@lfdr.de>; Wed, 12 Oct 2022 22:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJLUCD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Oct 2022 16:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJLUCC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Oct 2022 16:02:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18B51C40D;
        Wed, 12 Oct 2022 13:01:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bp15so27312099lfb.13;
        Wed, 12 Oct 2022 13:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=79SDMbgsMFe0kAcWZ8337yYSlLiSbukp1ZkX77xJUZE=;
        b=A0DaAUXrSk8uSYalBXlUqYnuljoQRW/N20juqG5exBub1TqJK8oaXCMUGResoK5v29
         kJi6wTIgYWUfXLifEnMXSJwP+/NALgb7zqaUZ4sYWHGJXnvKQGEweeiQ7qWO2G8ztYXs
         3qYOrllH8Ys/HjnlZNgLP0tODfSa2lj8uAdEyRc/2lUQ/ZR+hmzu7hzK2bd07vw9k+81
         f+vZnvq6oGle7Ini9kNKhD1VBFIGcUlXKUvQi+Z2VqERXYhwt4lqW8JCyH+RkzuLup+O
         a1rcgMsVroAHhIT7EN4nPJAnVHnOZ+DZazDCaTN+P5O6/h8mG59xCD1z4VTdUsgeAC1g
         5sKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79SDMbgsMFe0kAcWZ8337yYSlLiSbukp1ZkX77xJUZE=;
        b=YzHJuc1S+pHLY/IhTzWVglyr/Ppf7TSDr6fca4AWcCZgKCGtUV0KUcBxXPUx8OJNZo
         VWACNO1UYrleYUJIHJtWIfTSph0zqX5BokcvFnadb/I9nAz5Fd1UURDi8+FDk6y89FDf
         M3oSUEAdHvbzCzgT92Pe6hrT73Br0hIlgPJ0jBxA6sXBC4V/x4lRKDB6ycK96UAFGI+w
         EDjSW0gJ/UD/C9Aqgzrcwy+KySWrZQCMS3+IymolioQEjRzPRR0JER+w3479UX/w2OOz
         M3yJbvBV7zPodi3OuvEVCtskMqMP9JOJk3MMiX60JdDwpSOH/DeaeVBTpEBcqAtI1NOu
         j7Rw==
X-Gm-Message-State: ACrzQf2QDD33nsSObOLxrCo/n/yfcMY1lS1phM8/VpYBk4/YmAIvDjTr
        RbdbAmJHHbrfgt2keNsxRDc=
X-Google-Smtp-Source: AMsMyM56lNbIdMP/1IFUiefmVanFBnoRLeLA5Dn4YMgxV2CKC8uoqx68T07GaMTuQrPiWJ+lTNlK2Q==
X-Received: by 2002:ac2:4d46:0:b0:4a2:473f:1fb3 with SMTP id 6-20020ac24d46000000b004a2473f1fb3mr10297325lfp.408.1665604917094;
        Wed, 12 Oct 2022 13:01:57 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id e11-20020a05651236cb00b004a44ffb1050sm84837lfs.171.2022.10.12.13.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 13:01:56 -0700 (PDT)
Date:   Wed, 12 Oct 2022 23:01:54 +0300
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
Subject: Re: [PATCH RESEND v3 13/17] EDAC/mc: Add MC unique index allocation
 procedure
Message-ID: <20221012200154.7fq3i7igbgkcy2mx@mobilestation>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <20220929232712.12202-14-Sergey.Semin@baikalelectronics.ru>
 <Y0b5cq4evSg1nfb0@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0b5cq4evSg1nfb0@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 12, 2022 at 07:29:22PM +0200, Borislav Petkov wrote:
> On Fri, Sep 30, 2022 at 02:27:08AM +0300, Serge Semin wrote:
> > In case of the unique index allocation it's not that optimal to always
> > rely on the low-level device drivers (platform drivers), because they get
> > to start to implement either the same design pattern (for instance global
> > static MC counter) or may end-up with having non-unique index eventually
> > at runtime. Needless to say that having a generic unique index
> > allocation/tracking procedure will make code more readable and safer.
> 

> I guess this is trying to say that the current memory controller index
> thing doesn't work. But why doesn't it work?

From what have you got this? I said that the current MC indexing
approach wasn't that optimal (always relying on the low-level driver
to allocate the index) because it caused having the same IDx
allocation pattern re-implemented in the drivers. It can be avoided by
the provided patch. The unified approach makes code indeed more
readable in the platform drivers and safer since they didn't have to
bother with more coding. See for instance the drivers with the
static variable-based IDs allocation. It doesn't seem like these
drivers bother with the detected DDR devices order. If so then the
automatic IDs allocation is perfect for them. Note the static variable
increment isn't atomic. Thus the ID allocation algorithm there is prone
to races should the devices probe is run concurrently.

> 
> It works just fine with the x86 drivers - there the memory controller
> number is the same as the node number where it is located so that works
> just fine.
> 
> If that scheme cannot work on other systems, then I need to see an
> explanation why it cannot work first.
> 
> > The suggested implementation is based on the kernel IDA infrastructure
> > exposed by the lib/idr.c driver with API described in linux/idr.h header
> > file. It's used to create an ID resource descriptor "mc_idr", which then
> > is utilized either to track the custom MC idx specified by EDAC LLDDs or
> > to allocate the next-free MC idx.
> 

> This is talking about the "what" and not the "why".
> 
> > A new special MC index is introduced here. It's defined by the
> > EDAC_AUTO_MC_NUM macro with a value specifically chosen as the least
> > probable value used for the real MC index. In case if the EDAC_AUTO_MC_NUM
> > index is specified by the EDAC LLDD, the MC index will be either retrieved
> > from the MC device OF-node alias index ("mc[:number:]") or automatically
> > generated as the next-free MC index found by the ID allocation procedure.
> 
> This is also talking about the "what" and not the "why".
> 
> At best, what you're doing should be visible from the patch itself.
> 
> Here's a longer explanation of how a commit message should look like:
> 
> https://kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

Have you read it yourself? Here is a short excerpt from there:
"Once the problem is established, describe what you are actually doing
about it in technical detail.  It's important to describe the change
in plain English for the reviewer to verify that the code is behaving
as you intend it to."

So the "problem" is described in the first paragraph and the technical
details in the later paragraphs.

-Sergey

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
