Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C67B58FBA6
	for <lists+linux-edac@lfdr.de>; Thu, 11 Aug 2022 13:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiHKLxr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Aug 2022 07:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbiHKLxp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Aug 2022 07:53:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C8796755
        for <linux-edac@vger.kernel.org>; Thu, 11 Aug 2022 04:53:40 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gj1so17510901pjb.0
        for <linux-edac@vger.kernel.org>; Thu, 11 Aug 2022 04:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=928+0dNDnh9BrVH3Kb7MNns7s4CSLu2U2eONjpKru7c=;
        b=etOIlPa3txUXt0w93XsVdkaKQ0zIq0uYs2u2YmMzAtwspOTI4S7kncz6FvCDV6ctTL
         kYkJSpDhP1oJpKJNQWtlbK5B1TAigfqLEDEOG3RS7a6xLh4DsOZwpWuOn8ISr7fdatcy
         POi75YyoeGo9HL7JFohqNWt0Sg0hdNSLME+11kAZl6kzEAU5nENSCe9tAvevqs3sK6OZ
         EA0Ja9CEuC9y4tmbKV64E3iBXLW/JbuFp40jUD/a0XEC6cX9lOaZWEJKbUhMMfb+DUXI
         uo9OxJW7g8xGg1MRp/KMh6CfoPBTbJPc51V0YO8zMlWUcGurKwhm/LqrZaeYywjJAFsv
         yk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=928+0dNDnh9BrVH3Kb7MNns7s4CSLu2U2eONjpKru7c=;
        b=cUlGjMWV3Z1Dr343vE/RHMwhNRSdvpRkO88NyZARJVy8nJmdquCpxY7gyTf+F744Ok
         Y2EE+o442OqcSYc7wjc9iQDeaOsNUJkJVZgzrb9nyFmc3iYzw9onvPAS8yJRFievYpDL
         8IcooNM+7EQ0th/2Nd4upRbCmhLZAWwU2FYxAiKaftWtiZyvDAu/RuGlYcThZqYWRiGE
         NSbHaGeVJw9KISsk8IoYf0zIhhs2Agt+HxWUeLvAsfhkV//cLMipoysWgTqu5fskRRe4
         AikqESnqJRBmm9/+6qHwGDkZwGvptl0awes8BP1MymXHUMKd19IiNdBTKGAoQ7sAKFzZ
         sCjg==
X-Gm-Message-State: ACgBeo3g6EjfuBpP3cgaDhKivgGF/1cqDjVYaw/O+1LDrekDWUrF6KDf
        bWztdsuJzTQ1S5WHkBiJi+GD
X-Google-Smtp-Source: AA6agR5oH0nx5NKeq3WJX0XIbNZE4NOyyNW1VRoAhKXB1IqLE5TkOZL8BApTG3/jYzX7DwFcopJwiw==
X-Received: by 2002:a17:90b:3892:b0:1f5:8be1:d8a0 with SMTP id mu18-20020a17090b389200b001f58be1d8a0mr8471979pjb.162.1660218820209;
        Thu, 11 Aug 2022 04:53:40 -0700 (PDT)
Received: from workstation ([59.92.103.103])
        by smtp.gmail.com with ESMTPSA id g12-20020a17090a4b0c00b001f4d711e165sm3456307pjh.11.2022.08.11.04.53.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Aug 2022 04:53:39 -0700 (PDT)
Date:   Thu, 11 Aug 2022 17:23:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     bjorn.andersson@linaro.org, ckadabi@quicinc.com,
        vnkgutta@quicinc.com, mchehab@kernel.org, james.morse@arm.com,
        rric@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Channagoud Kadabi <ckadabi@codeaurora.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: Re: [PATCH 0/2] Fix crash when using Qcom LLCC/EDAC drivers
Message-ID: <20220811115334.GC29799@workstation>
References: <20220811100924.79505-1-manivannan.sadhasivam@linaro.org>
 <YvTehUOIqJGqXgXY@zn.tnic>
 <YvTfqg0q/8kIMY91@zn.tnic>
 <20220811112032.GB29799@workstation>
 <YvTo8tE3DaHifrSp@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvTo8tE3DaHifrSp@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 11, 2022 at 01:33:06PM +0200, Borislav Petkov wrote:
> On Thu, Aug 11, 2022 at 04:50:32PM +0530, Manivannan Sadhasivam wrote:
> > I know get_maintainer.pl :) But the problem is, Qualcomm recently
> > switched their email domain from codeaurora.org to quicinc.com.
> 
> Great:
> 
> $ git grep codeaurora.org MAINTAINERS | wc -l
> 5
> 

Yep! Most of the active developers have already changed their domains in
MAINTAINERS file. But the left ones are either not actively maintained
(yeah bad) or the maintainers have left Qualcomm.

> ;-\
> 
> > So even if I use the maintainers codeaurora domain now, they will
> > bounce.
> 
> Hmm, so the mails I sent with codeaurora on Cc didn't bounce back - I
> got only the quicinc bounces. That doesn't mean that codeaurora actually
> gets delivered...
> 

Not sure why. It was supposed to bounce. But could be that Qualcomm IT
decided to not bounce anymore since they have got enough complaints from
developers ;)

> > For that reason, I used their quicinc domain addresses. But since they
> > are bouncing, it looks like the maintainers left Qualcomm :/
> 
> Hmm, is there some way to get in touch with those folks?
> 

I don't think so. I checked in the internal Qualcomm database and
confirmed that I couldn't find the maintainers names there.

> Or whoever is taking over those drivers?
> 

LLCC is maintained by Bjorn (CCed) since it falls under soc/qcom. But I'm
not sure about EDAC. I think we should mark it as not maintainted until we
find a volunteer.

Bjorn, thoughts?

Thanks,
Mani

> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
