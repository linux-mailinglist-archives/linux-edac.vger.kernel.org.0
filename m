Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BF6655F9E
	for <lists+linux-edac@lfdr.de>; Mon, 26 Dec 2022 04:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiLZDvK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 25 Dec 2022 22:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLZDvI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 25 Dec 2022 22:51:08 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C693F4D;
        Sun, 25 Dec 2022 19:51:07 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id 128so9396715vsz.12;
        Sun, 25 Dec 2022 19:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ebdzjNZkPM5tKxMYiRS8XjnRbsm2WIJ55zWlFIDdo/M=;
        b=MblcnAWS481tElFFCtcHLHp/1bPzKgl42LGIunOJDMq/cyFIfuNEH4PhXP5wO3p+h1
         AA7U0R2Rcur3i3kidhnOFtdTL2uSlKc8bG9PN/K620uCQBIvm1Trli0lvc45dK3+lxCF
         tXD1RLPlndPfgZw6EkuDBl9UGPQYaFpDCb+tU6MVaOxefhdxRaDbIf2q7xs0bL9xYveH
         i+3iJD1NSDavycLLPvi3FG8BMIxkT2gmb0zRI8LMQjah1vomnCt5G0wuDTffveUvFMJp
         GurW/p8kYzEka0SE8Q8XWG0aKG/wlaknT5iaONCXk/MDLJET8P56lKvhSq4R0v6dvX5Z
         EBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ebdzjNZkPM5tKxMYiRS8XjnRbsm2WIJ55zWlFIDdo/M=;
        b=TFFFTJ+pXKB73LG1mAzNNaozkpJM+foariq36lhkH8keUXW1wRY0SN6AAggzro/l6g
         PAXXP8AlDtMEUqfW3SqCyJnPJ5PZ1Uymv/HQ1txIQE8iXjBNIuP5Et7UyCE8Q9go1vIV
         RU8BT2G3xVf5FLv0bG1VDaiJs+jgYBkRjgw/FrBM/KsJkyiAA4fQE512UFWzuevmuYFQ
         lZSeaqyCjaSnAnI9ppBHSL1HrqTcHuWYfCArHs1vaZFtHB9q/lEAYh81I1CD7JK0GOLb
         jQ743dviGfjihfYo1/aZUiLwl6lE1MjeLt4MUA7UZrqtxfu5JgBeyrbLUTVvbHgRA79A
         072g==
X-Gm-Message-State: AFqh2koVKv/6/RXeBUWlBYDAfDHAx5WRBUGNFNyneDvuRJOkKOysh6HA
        YpB+q9AOv6IE5CEp8QiLOEYVri/ZVkttrWe1u2Y=
X-Google-Smtp-Source: AMrXdXv7O/NhidrnpBGzUMwPNfsTKnYtgU/aAn85pdY6ULJakn7iPm/W42Lju4MTmpWQuMZLKSjjRpip2rnB5HnPrGA=
X-Received: by 2002:a05:6102:e94:b0:3b1:3231:ac9e with SMTP id
 l20-20020a0561020e9400b003b13231ac9emr1815373vst.50.1672026666154; Sun, 25
 Dec 2022 19:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20221223032859.3055638-1-milkfafa@gmail.com> <20221223032859.3055638-4-milkfafa@gmail.com>
 <Y6WniKjA6BHLknP6@zn.tnic>
In-Reply-To: <Y6WniKjA6BHLknP6@zn.tnic>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Mon, 26 Dec 2022 11:50:54 +0800
Message-ID: <CADnNmFqQ5_OQ-FiqdSZAtXFdG2X=qociXBykqL0TqtMw9r_=_A@mail.gmail.com>
Subject: Re: [PATCH v17 3/3] EDAC/npcm: Add NPCM memory controller driver
To:     Borislav Petkov <bp@alien8.de>
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, benjaminfair@google.com, yuenn@google.com,
        venture@google.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        ctcchien@nuvoton.com, kflin@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

Thanks for the review.

> > +     u64 addr = 0;
> > +     u64 data = 0;
> > +     u32 val_h = 0;
> > +     u32 val_l, id, synd;
>
>         u32 val_h = 0, val_l, id, synd;
>         u64 addr = 0, data = 0;
>
> Also, for all your functions:
>
> The EDAC tree preferred ordering of variable declarations at the
> beginning of a function is reverse fir tree order::
>
>         struct long_struct_name *descriptive_name;
>         unsigned long foo, bar;
>         unsigned int tmp;
>         int ret;
>
> The above is faster to parse than the reverse ordering::
>
>         int ret;
>         unsigned int tmp;
>         unsigned long foo, bar;
>         struct long_struct_name *descriptive_name;
>
> And even more so than random ordering::
>
>         unsigned long foo, bar;
>         int ret;
>         struct long_struct_name *descriptive_name;
>         unsigned int tmp;

I'll check all functions and follow this order.

> > +     edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1, addr >> PAGE_SHIFT,
> > +                          addr & ~PAGE_MASK, synd, 0, 0, -1, priv->message,
>
> No need for that linebreak with the trailing piece.
>
> > +                          "");

> > +     u64 addr = 0;
> > +     u64 data = 0;
> > +     u32 val_h = 0;
> > +     u32 val_l, id, synd;
>
> As above.

Check.

> > +     regmap_read(npcm_regmap, pdata->ctl_int_status, &status);
> > +     if (status & pdata->int_status_ce_mask) {
> > +             handle_ce(mci);
> > +
> > +             /* acknowledge the CE interrupt */
> > +             regmap_write(npcm_regmap, pdata->ctl_int_ack,
> > +                          pdata->int_ack_ce_mask);
> > +             return IRQ_HANDLED;
> > +     } else if (status & pdata->int_status_ue_mask) {
> > +             handle_ue(mci);
> > +
> > +             /* acknowledge the UE interrupt */
> > +             regmap_write(npcm_regmap, pdata->ctl_int_ack,
> > +                          pdata->int_ack_ue_mask);
> > +             return IRQ_HANDLED;
> > +     }
>
>         WARN_ON_ONCE(1);
>
> to catch weird cases.

OK.

> > +     /* write syndrome to XOR_CHECK_BITS */
> > +     if (priv->error_type == 0) {
>
>         if (priv->error_type == ERROR_TYPE_CORRECTABLE
>
> Use defines. Below too.
>
> > +             if (priv->location == 0 && priv->bit > 63) {

Will add defines.

> > +                     edac_printk(KERN_INFO, EDAC_MOD_NAME,
> > +                                 "data bit should not exceed 63\n");
>
>                                 "data bit should not exceed 63 (%d)\n", priv->bit...)
>
> Below too.
>
> > +                     return count;
> > +             }
> > +
> > +             if (priv->location == 1 && priv->bit > 7) {
> > +                     edac_printk(KERN_INFO, EDAC_MOD_NAME,
> > +                                 "checkcode bit should not exceed 7\n");

OK.

> > +             syndrome = priv->location ? 1 << priv->bit :
> > +                        data_synd[priv->bit];
>
>                 syndrome = priv->location ? 1 << priv->bit
>                                           : data_synd[priv->bit];

Just to confirm the indentation, is it right as follows?

syndrome = priv->location ? 1 << priv->bit
                                           : data_synd[priv->bit];

And I was wondering if I should just remove the line break and let it stick out?

> I'd find it helpful if there were a short recipe in a comment here
> explaining how the injection should be done...
>
> > +static void setup_debugfs(struct mem_ctl_info *mci)
> > +{

OK, will add some injection examples here.

> > +     regmap_update_bits(npcm_regmap, pdata->ctl_ecc_en, pdata->ecc_en_mask,
> > +                        0);
>
> You have a bunch of those things: the 80 cols rule is not a rigid and a
> static one - you should rather apply common sense. As in:
>
> Does it make sense to have this ugly linebreak with only the 0 argument there?
>
>         regmap_update_bits(npcm_regmap, pdata->ctl_ecc_en, pdata->ecc_en_mask,
>                            0);
>
> or should I simply let it stick out:
>
>         regmap_update_bits(npcm_regmap, pdata->ctl_ecc_en, pdata->ecc_en_mask, 0);
>
> and have much more readable code?
>
> Please apply common sense to all your linebreaks above.

Thanks for the guide.

> > +     edac_mc_del_mc(&pdev->dev);
> > +     edac_mc_free(mci);
>
> <--- What happens if someone tries to inject errors right at this
> moment, when you've freed the mci?
>
> Hint: you should destroy resources in the opposite order you've
> allocated them.

Understand. I'll correct the destroy order.

Regards,
Marvin
