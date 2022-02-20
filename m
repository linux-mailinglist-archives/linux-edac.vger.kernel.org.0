Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480104BD17E
	for <lists+linux-edac@lfdr.de>; Sun, 20 Feb 2022 21:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiBTUjx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 20 Feb 2022 15:39:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiBTUjw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 20 Feb 2022 15:39:52 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FAA4504D
        for <linux-edac@vger.kernel.org>; Sun, 20 Feb 2022 12:39:30 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id e17so11857329ljk.5
        for <linux-edac@vger.kernel.org>; Sun, 20 Feb 2022 12:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKRB2WaBF2GQiP6qlxkilcBwOuI+2IkPQKIJsc3NqsQ=;
        b=SX6+NI65ZhEZjT0l+lz22ObM1ZRomNOXQVzcDjpB5YASTsnX4Uuq5t6Cet7vkOLXks
         aj3JuAWymCoQm7vmt2bwsxBatEGXFUsDHCXTKhDi7v5ho/LHIdE9nnZMOMw8fli5iDMi
         6FKTFvq4sD7aOtt89az18DgLMAcPVrsdyNxh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKRB2WaBF2GQiP6qlxkilcBwOuI+2IkPQKIJsc3NqsQ=;
        b=nrQQXfcl6p91Wy1n+t7VAwYXXlmDTrJ+fSihYF3A4rgXaH6gYIhDcpHCF4lMY/nHyz
         J5dfBzySOP+AmaqjLhsEmGr1T8xpuYUqenJgGS1rcCstbnqX900wkGV0rzuEgt1dDjHn
         SXsQdJ8H9sFg2in0OAv2n2+yBsK+BncMOBlf1y3Gxhd/Irf9Ug9EYbibppPDb2hRw5Wr
         EPPD9RaH1GMcoN5y/o5eATFohKMke/130mn1hzOP+HBSbSnt4mIW6tRTNIFtMWkRobiE
         6K4gxLpbp71ikI53Hb71vEJ3rshkzdpwon+c+31Su70bxplJ12V1HdQd/bfEUDQBUiuJ
         e2dg==
X-Gm-Message-State: AOAM533Z/zQxfNufmawiVmMU7EN/dtmeIFjzSYeEZHJbMZ7eJ+q4Kgo/
        hV3fhQZwubmoeIMMrC+wuj0xNXentSUosRQW
X-Google-Smtp-Source: ABdhPJyubzYkjdRIr6JG95lGbl13soTPGyp3bxyHxaWssm59GyQr7/kqf9rueg/599oYqfhS/J24IQ==
X-Received: by 2002:a2e:a5c5:0:b0:245:f5c5:d016 with SMTP id n5-20020a2ea5c5000000b00245f5c5d016mr12170678ljp.188.1645389568640;
        Sun, 20 Feb 2022 12:39:28 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id m7sm913684lfr.82.2022.02.20.12.39.27
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 12:39:27 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id g39so14978186lfv.10
        for <linux-edac@vger.kernel.org>; Sun, 20 Feb 2022 12:39:27 -0800 (PST)
X-Received: by 2002:ac2:4211:0:b0:438:2f1:83c4 with SMTP id
 y17-20020ac24211000000b0043802f183c4mr12074683lfh.435.1645389567567; Sun, 20
 Feb 2022 12:39:27 -0800 (PST)
MIME-Version: 1.0
References: <YhIq94B0MpYGrEm2@zn.tnic> <CAHk-=whi4n6xvy99U-q_GrR_hHk8es4GtDKtywiL5nRFUWroAQ@mail.gmail.com>
 <YhKj08BBnevqtbch@zn.tnic>
In-Reply-To: <YhKj08BBnevqtbch@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Feb 2022 12:39:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=whvy0h0WfT8g=6rfws75xB94+yuALtSY1Gpx0bvnOqTFg@mail.gmail.com>
Message-ID: <CAHk-=whvy0h0WfT8g=6rfws75xB94+yuALtSY1Gpx0bvnOqTFg@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC fix for 5.17
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Feb 20, 2022 at 12:25 PM Borislav Petkov <bp@suse.de> wrote:
>
> Yah, where do I start... so, about this, I think I can simplify it by
> simply unconditionally aligning to 8.

Sounds good.

Then you could just do something like

        void *ptr = (void *)ALIGN_UP((unsigned long)*p, 8);
        *p = ptr + size*n_memb;
        return ptr;

and that would be a lot simpler.

> My gut feeling is telling me
> 8-bytes alignment should simply work on everything. Because if it does,
> all that crap becomes a lot simpler. But maybe I'm being too simplistic
> here and there might be a corner-case where 8-bytes alignment just
> doesn't work...

Well, if 8-byte alignment doesn't work, then the existing code (with
the fix) doesn't work either, so..

                 Linus
