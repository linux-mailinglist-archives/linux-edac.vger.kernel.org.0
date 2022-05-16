Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC9A52896B
	for <lists+linux-edac@lfdr.de>; Mon, 16 May 2022 18:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245544AbiEPQCz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 May 2022 12:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245550AbiEPQCx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 16 May 2022 12:02:53 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59052FE67
        for <linux-edac@vger.kernel.org>; Mon, 16 May 2022 09:02:52 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id v65so19106094oig.10
        for <linux-edac@vger.kernel.org>; Mon, 16 May 2022 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScgtWm2uFkOxfulqs7520gHM/my4MYIe3yq/VcV3Ozw=;
        b=Ui6BaQ6lQ9IwPfOUL4TJm7cJvfYf8UFV8wI0yIE/ecSwLqobvQf4rTIikXPC8Ksnp/
         JRSTr3Fgwya3hm14X44WgUx1HJGuc9H1MoeHAN4VBzxuhJEnypxN8+xF6HAWoKiAVAs3
         mxYrKvjtDKZ5Z0eJvjVSmqSHIwF8R/De7GbNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScgtWm2uFkOxfulqs7520gHM/my4MYIe3yq/VcV3Ozw=;
        b=une/jT9yWg5nrAcg7nHiSgkn+VLQqbl0f9UCzEUpZy438YUzNqsPZyNY2lTf+xnJSm
         5o/kcp4aIVMpSc1MNbBoXz4Xnp5VmmJcb/YE/t6DNJ69AbRSBZ8wUEXa24vHL0HSoUMX
         ouGajReVRFv/gBnVPCE/Xqq9HWVxPxj+D311ZLWIMs0nkwexblSIWclrGRyLerFbeBM8
         UC75lBLCNmQpulAFNQ+dUKA0n2rabXTftrPQOD+3CPZ5Czo48Rl8dGRsgS32qn25os2Q
         pIzSL65gbWdx5g/xMTFcgzgZc7TO5xJYmpUGX3x5m/dzgJ73IiuJ3CghNLME2LcEeGU7
         ks7g==
X-Gm-Message-State: AOAM531KsIvQk/bivIFrJ2VPAI821EOGXcdwLBPHASxfS2ucNIpHERhZ
        tmWPIgqi3rA6HVyrQ0vLZBP1RYd0flhJlEsJ
X-Google-Smtp-Source: ABdhPJzKjRlkigGbGp7fqLk0q4sM3A6TqI8XveQZ6ikaA/r1lxfLcpM1SmlhMs/FECF80XtfTxabVg==
X-Received: by 2002:a05:6808:1645:b0:325:5182:a9ca with SMTP id az5-20020a056808164500b003255182a9camr8359060oib.104.1652716971706;
        Mon, 16 May 2022 09:02:51 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com. [209.85.160.52])
        by smtp.gmail.com with ESMTPSA id b7-20020acab207000000b0032647f4e437sm3906752oif.45.2022.05.16.09.02.47
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 09:02:48 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-d39f741ba0so20656288fac.13
        for <linux-edac@vger.kernel.org>; Mon, 16 May 2022 09:02:47 -0700 (PDT)
X-Received: by 2002:a05:6870:63a0:b0:f1:8bca:8459 with SMTP id
 t32-20020a05687063a000b000f18bca8459mr4861359oap.174.1652716966894; Mon, 16
 May 2022 09:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220427224924.592546-1-gpiccoli@igalia.com> <20220427224924.592546-20-gpiccoli@igalia.com>
 <YoJZVZl/MH0KiE/J@alley> <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com>
In-Reply-To: <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 16 May 2022 09:02:10 -0700
X-Gmail-Original-Message-ID: <CAE=gft7ds+dHfEkRz8rnSH1EbTpGTpKbi5Wxj9DW0Jr5mX_j4w@mail.gmail.com>
Message-ID: <CAE=gft7ds+dHfEkRz8rnSH1EbTpGTpKbi5Wxj9DW0Jr5mX_j4w@mail.gmail.com>
Subject: Re: [PATCH 19/30] panic: Add the panic hypervisor notifier list
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Petr Mladek <pmladek@suse.com>, David Gow <davidgow@google.com>,
        Julius Werner <jwerner@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sebastian Reichel <sre@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com,
        kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
        rcu@vger.kernel.org, sparclinux@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com,
        fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>, d.hatayama@jp.fujitsu.com,
        dave.hansen@linux.intel.com, dyoung@redhat.com,
        feng.tang@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com,
        jgross@suse.com, john.ogness@linutronix.de,
        Kees Cook <keescook@chromium.org>, luto@kernel.org,
        mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, Alan Stern <stern@rowland.harvard.edu>,
        Thomas Gleixner <tglx@linutronix.de>, vgoyal@redhat.com,
        vkuznets@redhat.com, Will Deacon <will@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Dexuan Cui <decui@microsoft.com>,
        Doug Berger <opendmb@gmail.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Justin Chen <justinpopo6@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Lee Jones <lee.jones@linaro.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Wei Liu <wei.liu@kernel.org>,
        zhenwei pi <pizhenwei@bytedance.com>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 16, 2022 at 8:07 AM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> Thanks for the review!
>
> I agree with the blinking stuff, I can rework and add all LED/blinking
> stuff into the loop list, it does make sense. I'll comment a bit in the
> others below...
>
> On 16/05/2022 11:01, Petr Mladek wrote:
> > [...]
> >> --- a/arch/mips/sgi-ip22/ip22-reset.c
> >> +++ b/arch/mips/sgi-ip22/ip22-reset.c
> >> @@ -195,7 +195,7 @@ static int __init reboot_setup(void)
> >>      }
> >>
> >>      timer_setup(&blink_timer, blink_timeout, 0);
> >> -    atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
> >> +    atomic_notifier_chain_register(&panic_hypervisor_list, &panic_block);
> >
> > This notifier enables blinking. It is not much safe. It calls
> > mod_timer() that takes a lock internally.
> >
> > This kind of functionality should go into the last list called
> > before panic() enters the infinite loop. IMHO, all the blinking
> > stuff should go there.
> > [...]
> >> --- a/arch/mips/sgi-ip32/ip32-reset.c
> >> +++ b/arch/mips/sgi-ip32/ip32-reset.c
> >> @@ -145,7 +144,7 @@ static __init int ip32_reboot_setup(void)
> >>      pm_power_off = ip32_machine_halt;
> >>
> >>      timer_setup(&blink_timer, blink_timeout, 0);
> >> -    atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
> >> +    atomic_notifier_chain_register(&panic_hypervisor_list, &panic_block);
> >
> > Same here. Should be done only before the "loop".
> > [...]
>
> Ack.
>
>
> >> --- a/drivers/firmware/google/gsmi.c
> >> +++ b/drivers/firmware/google/gsmi.c
> >> @@ -1034,7 +1034,7 @@ static __init int gsmi_init(void)
> >>
> >>      register_reboot_notifier(&gsmi_reboot_notifier);
> >>      register_die_notifier(&gsmi_die_notifier);
> >> -    atomic_notifier_chain_register(&panic_notifier_list,
> >> +    atomic_notifier_chain_register(&panic_hypervisor_list,
> >>                                     &gsmi_panic_notifier);
> >
> > I am not sure about this one. It looks like some logging or
> > pre_reboot stuff.
> >
>
> Disagree here. I'm looping Google maintainers, so they can comment.
> (CCed Evan, David, Julius)
>
> This notifier is clearly a hypervisor notification mechanism. I've fixed
> a locking stuff there (in previous patch), I feel it's low-risk but even
> if it's mid-risk, the class of such callback remains a perfect fit with
> the hypervisor list IMHO.

This logs a panic to our "eventlog", a tiny logging area in SPI flash
for critical and power-related events. In some cases this ends up
being the only clue we get in a Chromebook feedback report that a
panic occurred, so from my perspective moving it to the front of the
line seems like a good idea.

-Evan
