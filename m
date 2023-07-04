Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E399974673F
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 04:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjGDCUi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Jul 2023 22:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGDCUh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Jul 2023 22:20:37 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11A9136
        for <linux-edac@vger.kernel.org>; Mon,  3 Jul 2023 19:20:36 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 218EA3F84D
        for <linux-edac@vger.kernel.org>; Tue,  4 Jul 2023 02:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688437235;
        bh=gPUh1UKYRUTDUZfqtjt41zw9iPe9y1sFpRCgNtjp5pI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=WvH9r4jjWfvpUGN+M3Px0UjxpcJHUZSeu1YRqT6UyT17gOEQpZw0HkLFq24ZsPNIQ
         XdcFriAHz4wcBzFrW+U8AYk85VXF0HqiTkar6FvI9H9OVhF1qBkumkAcAYAEqX+Kee
         L4u9ZxujGjGjnd47o+RXsL+eYbkf0+vVoCjEmCc7G2lQOFbP8mEZLK1xkvH8vOkRk8
         a3Ygjwi7HbL1GmXYFZJBlX0g3cCCMKVJTTQW7h/o43FClsgGT/qSGDSE+83QhlkRls
         FeEAQgotRXYPfyMyaqXs1HuhEGRalNTh4FTnV7vN2Bl3uSDG0rBLHTgiYjcvyZnOiv
         Tg2aXF04CpoNA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-988643252e0so354529666b.2
        for <linux-edac@vger.kernel.org>; Mon, 03 Jul 2023 19:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688437234; x=1691029234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPUh1UKYRUTDUZfqtjt41zw9iPe9y1sFpRCgNtjp5pI=;
        b=mIDyr+7JYsaf22Ugz7k6Kjw7taeQoGRO2XbJH9+YoT2at3KgsZwVuR0fmFKny+D6yH
         F4VfQCRCN2zprZeurmy3USxCZWcMemJS8eJlAmX6UE7PaohvwcMjx/ahQDvGps3hRH6d
         LXfnPD/L0i3telEllgqww0c3Hv3PmaE822wrNZScj0g0YF1Ut3Z8VXSOqnSTihgRcU6H
         V3EmvIgyJBwd6GaJG0DbM8NRtokEn0sLj1sKHxWfrz+BuQzIrNoo4JKXZY6An0/0HtR/
         NiGhVuWoyk/XTE1GY83SgprzTTZWgh/oYlDcaxaHQTd9RS+aItn5H9RAF3Eq5UkMZMw4
         wGVA==
X-Gm-Message-State: ABy/qLY8xUi7TMCbk0x+TxcPVI9TeY4uScAP0d+YRT/19lMy+94v7+xC
        SqKmW2GRSPxFMPUGav9jSvyyPYJ0z+C+K+KPehrHPo9ScflYBEHBOzL8x3w+qsj2Lvl+P+V1Q4/
        ThJHsDsdNn26CRF5w1QXzLggTaFcriisykOMQEVJjhxX6E4TN0qvK9rE=
X-Received: by 2002:a17:907:9850:b0:993:3556:b7ed with SMTP id jj16-20020a170907985000b009933556b7edmr5359538ejc.6.1688437233881;
        Mon, 03 Jul 2023 19:20:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFfr+4nSObV9okaYd8nc1mjdTLkRmk1774yuvQp5tR7ZGFYw29tiQlOXSBPPnbWZ8jRWJg5yiQCcEgEHmT8oiA=
X-Received: by 2002:a17:907:9850:b0:993:3556:b7ed with SMTP id
 jj16-20020a170907985000b009933556b7edmr5359526ejc.6.1688437233447; Mon, 03
 Jul 2023 19:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230703162509.77828-1-koba.ko@canonical.com> <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
 <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Tue, 4 Jul 2023 10:20:20 +0800
Message-ID: <CAJB-X+X+09-m57JcZcb-_9dKUG3CtAbLXxGTEg7R0bB8pyJx9Q@mail.gmail.com>
Subject: Re: [PATCH v2] EDAC/i10nm: shift exponent is negative
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jul 4, 2023 at 5:51=E2=80=AFAM Luck, Tony <tony.luck@intel.com> wro=
te:
>
> > > UBSAN complains this error
> > > ~~~
> > >  UBSAN: shift-out-of-bounds in drivers/edac/skx_common.c:369:16
> > =E2=80=A6
> > > ~~~
> > >
> > > when get rows, cols and ranks, the returned error value doesn't be
> > > handled.
> > >
> > > check the return value is EINVAL, if yes, directly return 0.
> > =E2=80=A6
> >
> > * Please improve this change description further.
>
> To be specific. Initially you reported this because of the UBSAN error
> report. But, after community discussion you now know that the problem
> is that one or more of the rows/cols/ranks has a value that the EDAC driv=
er
> doesn't expect and probably can handle.
>
> So, in V2, the commit message should start with the information these
> values are out of range and mention this was discovered when UBSAN
> put out a warning about a negative shift. No need to include the whole
> of the UBSAN stack trace.
>
> Then describe the two fixes that this patch includes. One is to change th=
e
> edac debug message into a console error message to enable further
> debug of this issue. The other is to skip the unrecognized DIMM.
>
> > * How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?
>
> This is a good idea.  Use git blame, or dig into the GIT history to
> find the commit where this code was introduced (hint .. git blame
> says:
> 88a242c98740 ("EDAC, skx_common: Separate common code out from skx_edac")
> but that obviously just refactored code, so you should dig back more into
> the history.
There are two parts,
1. @get_dimm_attr, edac_dbg was added since e235dd43d8b0f0
2. get num of ranks, rows and cols, 4ec656bdf43a13

Should I add all of them prefixes with "Fixes"?

>
> > > V2: make error-print explicitly
> > > ---
> >
> > Would you like to avoid a misplaced marker line here?
> >
> > See also:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.4#n686
>
> That's an excellent resource.
>
> -Tony
