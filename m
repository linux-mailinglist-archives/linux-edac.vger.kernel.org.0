Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EDD5457A5
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jun 2022 00:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbiFIWth (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jun 2022 18:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345808AbiFIWtg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 9 Jun 2022 18:49:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19068FF5BB
        for <linux-edac@vger.kernel.org>; Thu,  9 Jun 2022 15:49:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id s6so40151404lfo.13
        for <linux-edac@vger.kernel.org>; Thu, 09 Jun 2022 15:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OAj7kkMIiekJ9rTKt4JAtAfIGa2quITOg+UqYlGq1Vc=;
        b=h+XSjN/WVesJqDJFOPBbUOjCsElze90l5AUaZpaMfQE4BCHJP6262qTzyHWJva9Bl7
         Ylea2b1VMRtuu3W6K04USb5N4DyE9/FJG1TJX23DJAAyMpmTkNe0IhcujfXyw2tL6Yzm
         5AoAwHI63jQHxPEb7KgmYY7AsIWc/AhRsgnJ71aDa/ZsS0NcL3wur4vFJaN8UMyAklRE
         aEGCgipKXq1q5OQuT+b1/Z3ZAjDVwg+cOz821DhKZdc3CbTWkxewf2eBhHZ6cA8kCpl2
         vQoxv4lOBXpPPrGtb7sLkscBoEWxzlYML194UCnlDBfFSziOT58BYv12MhyX6zYq7k9Z
         Vkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OAj7kkMIiekJ9rTKt4JAtAfIGa2quITOg+UqYlGq1Vc=;
        b=qtEfMHUsBS64w4jDRjpmz4PMOE8p7uhLd/E3877LH6ZVXYZvm7NK5UNPHfUo83AYpe
         sYIH/WQoeTgGt2cVLxXhUd3Qh9WysT1XANayEQqwCCXozZUE1RL0kpzqZcmwwXioesYq
         qCRQxQFhGFnwMHxOBftSbBcYOm1ESOIOs4T9sDhKHfp4JuB5PxmuNB73W9/Cic8iMZIt
         HyyygJUfWVDSN0D/oQNRN88Qd+G1GT7X0ncz4bacFBEWbK96VH/yfRvXcf3D5vfnu9v0
         UUh2JXmG9MFYGAcTdRs1yVT21siWdaXCfCXcRHgCYarg0Dj7FJGKWNWfFcrO7E001u6K
         LWmA==
X-Gm-Message-State: AOAM531yu8BB9bUfIrIdNllv58/rMq7ntDFX1LudhAzIUxX15QKSi1L+
        JgqBu7GetBhEm8cDRHh0PFiOXGtEMwOPgqLQzKyC
X-Google-Smtp-Source: ABdhPJxZXTnzcCwuX2K8dXo0GsWxPjCKHZ8xLR+ukHeOsc32GB8PW2KE6FFGhS4Nls3KDQ2FUv5nfKYIhCIQyfCKYvU=
X-Received: by 2002:a05:6512:114e:b0:479:1e02:9318 with SMTP id
 m14-20020a056512114e00b004791e029318mr20896704lfg.156.1654814973186; Thu, 09
 Jun 2022 15:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220609221702.347522-1-morbo@google.com> <20220609152527.4ad7862d4126e276e6f76315@linux-foundation.org>
In-Reply-To: <20220609152527.4ad7862d4126e276e6f76315@linux-foundation.org>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 9 Jun 2022 15:49:21 -0700
Message-ID: <CAGG=3QXDt9AeCQOAp1311POFRSByJru4=Q=oFiQn3u2iZYk2_w@mail.gmail.com>
Subject: Re: [PATCH 00/12] Clang -Wformat warning fixes
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Bill Wendling <isanbard@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jan Kara <jack@suse.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-edac@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-mm@kvack.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, Networking <netdev@vger.kernel.org>,
        alsa-devel@alsa-project.org,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 9, 2022 at 3:25 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu,  9 Jun 2022 22:16:19 +0000 Bill Wendling <morbo@google.com> wrote:
>
> > This patch set fixes some clang warnings when -Wformat is enabled.
> >
>
> tldr:
>
> -       printk(msg);
> +       printk("%s", msg);
>
> the only reason to make this change is where `msg' could contain a `%'.
> Generally, it came from userspace.

It helps kernel developers not accidentally to insert an unescaped '%'
in their messages, potentially exposing their code to an attack
vector.

> Otherwise these changes are a
> useless consumer of runtime resources.

Calling a "printf" style function is already insanely expensive. :-) I
understand that it's not okay blithely to increase runtime resources
simply because it's already slow, but in this case it's worthwhile.

> I think it would be better to quieten clang in some fashion.

The "printk" and similar functions all have the "__printf" attribute.
I don't know of a modification to that attribute which can turn off
this type of check.

-bw
