Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FA45FCE6F
	for <lists+linux-edac@lfdr.de>; Thu, 13 Oct 2022 00:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJLWar (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Oct 2022 18:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJLWaq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Oct 2022 18:30:46 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A4D7C1EE;
        Wed, 12 Oct 2022 15:30:43 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id by36so253337ljb.4;
        Wed, 12 Oct 2022 15:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=azE12fzqRCStn66Je+WUIHSMRHR4VMhkId7Ezn0e0GI=;
        b=KqWahBrwFFt7wwUBu4sWrxYFEmVFhzqQm/zJaehY6IiVjusjopa7jWkcpcBI0Z+vTR
         6ZDxAKdvHK2YzJf65j830bsFBi4PJTpLFBG2Oa7Ah9166uy+uf4NZXgr9KabetOCoK2d
         YlqescKx+SactBPcFlLQ2gZTIan7/ixJl+m5LFvazsBo0YfpUIJ3r2Di+CF1riMPr7Ia
         UmJC5vPVIP7XvZ4b2AbCFR6d5UN7n/JAlEJYZ/W8AWhLkljR+iCyM8em/79vIIQY34r6
         m0kzFaNu7NrTkXZP+s5faoJZkJEcuF3r+L3/itnskG9a4SFEDwejO+sEh/xgO+ihf4pd
         3irQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azE12fzqRCStn66Je+WUIHSMRHR4VMhkId7Ezn0e0GI=;
        b=VEC4R1utan4QGuw0Yj/P5z9Mvc7jhDqi5XMa/cgrNJZH8kob5aTfChpDhMqW1MOo2b
         B0T454iqbmH4eh0cvPenpS6/J1g0soVRUyDXtaUqQ1K3Q6ePmpCtap1vhKPhn8Jz42/A
         8hNhFGHgESk0qg1NOjHNVbPoKTtNwz9ncBP9ahw36Y35XMi9X9RDpTLnjy1tOqRHpfMY
         Pr8CrxGKgF5H35rdv3Z/rQY9UfDQxSyvwFxwNF+GYcpNW/UcCkAPIIu+e2S/gy32QmGX
         1sf/Cho9iOhnhBw5fvl1YSY8C/Ab+8CcfCE8wx6aTNzHnlSJkKWxwr63ZjARgbQVr/us
         IJ9A==
X-Gm-Message-State: ACrzQf1sMn11ZAIgip3ZbqMaHGUmFnkldrTGGrxgkF7c9PcwEF2U69KP
        kKCW3LHJn1+aZuCouyuS28BGi/e6GW856g==
X-Google-Smtp-Source: AMsMyM7TD4UcwGgkIBKz+hsKyaoJC6pIwUE9+NB35Zt+uOXpbXiArq3gLn5mI847Ekzm+v5mYMw2aA==
X-Received: by 2002:a05:651c:c99:b0:26e:6c39:fc4e with SMTP id bz25-20020a05651c0c9900b0026e6c39fc4emr11223894ljb.311.1665613841906;
        Wed, 12 Oct 2022 15:30:41 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id 26-20020ac25f5a000000b004972b0bb426sm122907lfz.257.2022.10.12.15.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:30:41 -0700 (PDT)
Date:   Thu, 13 Oct 2022 01:30:39 +0300
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
Message-ID: <20221012223039.upbjsiywiipdrjjk@mobilestation>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <20220929232712.12202-14-Sergey.Semin@baikalelectronics.ru>
 <Y0b5cq4evSg1nfb0@zn.tnic>
 <20221012200154.7fq3i7igbgkcy2mx@mobilestation>
 <Y0ckn5r3KN416Jeg@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0ckn5r3KN416Jeg@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 12, 2022 at 10:33:35PM +0200, Borislav Petkov wrote:
> On Wed, Oct 12, 2022 at 11:01:54PM +0300, Serge Semin wrote:
> > The unified approach makes code indeed more readable in the platform
> > drivers and safer since they didn't have to bother with more coding.
> > See for instance the drivers with the static variable-based IDs
> > allocation.
> 
> Which drivers? Concrete examples please.

See below.

> 
> > Have you read it yourself? 
> 
> Yes. I even have improved it over the years.
> 
> > Here is a short excerpt from there:
> > "Once the problem is established, describe what you are actually doing
> > about it in technical detail.  It's important to describe the change
> > in plain English for the reviewer to verify that the code is behaving
> > as you intend it to."
> 
> Maybe that part can be misunderstood: "describe what you're doing about
> it". That doesn't mean the text should explain what you're adding and
> how stuff is defined: "It's defined by the EDAC_AUTO_MC_NUM macro." I
> can see that from the diff.
> 
> So let me try to explain to you what I'm expecting from commit messages
> in the EDAC tree:
> 

> The commit message should explain *why* a change is being done so that,
> months, years from now, when you've gone on to do something else, people
> doing git archeology can actually figure out *why* this change was done.
> 
> And the explanation in that commit message should be *complete* and
> should contain *all* necessary information to understand why this change
> was done.

A level of completeness can be relative to each person. For all the
years I've submitting the patches to the kernel I couldn't even
remember the last request to elaborate my logs. In no means I want to
say they were perfect. I could just be too immersed into the problem
so thought that the provided text was descriptive enough especially
for the subsystem maintainer. So to speak asking for more details
would be more than enough.

> 
> Your commit message is not explaining the problem.
> 
> "In case of the unique index allocation it's not that optimal to always
> rely on the low-level device drivers (platform drivers)"
> 

> That's your statement. That needs to have exact details so that people
> can look at that commit message, look at the code which *you* point them
> to in it and go, aha, that is the problem.
> 
> "because they get to start to implement either the same design pattern
> (for instance global static MC counter) or may end-up with having
> non-unique index eventually at runtime."
> 
> Who are they, exact pointers please.

So you need more details. You should have just asked. I can't read
your mind after all. IMO the description was detailed enough to
understand the problem. Anyway as I already said the current MC
indexing approach wasn't that optimal (always relying on the low-level
driver to allocate the index) because it caused having the same IDx
allocation pattern re-implemented in the drivers. The brightest
example is the drivers with the static variable-based IDs allocation.
It doesn't seem like these drivers bother with the detected DDR
devices order. If so then the automatic IDs allocation is perfect for
them. Instead they can just pass the EDAC_AUTO_MC_NUM id to the
edac_mc_alloc() method and drop the static-based pattern. Thus getting
smaller and more readable drivers code. Moreover the variable
increment isn't atomic. Thus the ID allocation algorithm there is
prone to races should the devices probe is run concurrently.

The last but not least there is no currently way to assign the
controllers ID by means of the DTS file. The suggested patch provides
such functionality by means of the DT aliases.

If it describes the problem better I'll add the text to the patchlog
on the next patchset re-spin.

> 
> "The suggested implementation is based on the kernel IDA infrastructure
> exposed by the lib/idr.c driver with API described in linux/idr.h header
> file."
> 
> That doesn't matter one bit for the change you're doing. You could have
> added it under the "---" line.

Ok. I'll drop it from the log.

> 
> "A new special MC index is introduced here. It's defined by the
> EDAC_AUTO_MC_NUM macro with a value specifically chosen as the least
> probable value used for the real MC index. In case if the EDAC_AUTO_MC_NUM
> index is specified by the EDAC LLDD, the MC index will be either retrieved
> from the MC device OF-node alias index ("mc[:number:]") or automatically
> generated as the next-free MC index found by the ID allocation procedure."
>
 
> Some of that paragraph should go over the function as a comment - not in
> the commit message as it pertains to what the function does and it would
> make a *lot* more sense there when someone tries to figure out what the
> function does instead of in the commit message.
> 

IMO the function isn't that complex to add the comment there. The
semantic can be easily enough inferred from the implementation. 

> So, I'm still not convinced why do some EDAC drivers need unique MC
> identifiers, why the current scheme doesn't work and where it doesn't
> work.

Once again. I didn't say it didn't work. I said it wasn't optimal.
Though in some circumstance it can misbehave for some drivers.
Please see my response above.

-Sergey

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
