Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C558B741EEA
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jun 2023 05:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjF2Dw5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Jun 2023 23:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjF2Dwu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Jun 2023 23:52:50 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2D4297C
        for <linux-edac@vger.kernel.org>; Wed, 28 Jun 2023 20:52:49 -0700 (PDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 05C353F18D
        for <linux-edac@vger.kernel.org>; Thu, 29 Jun 2023 03:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688010767;
        bh=ln7LWd40lnjGepxvFLRyaxcRyxZ30/1SOSyaN+ooqhU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QIpPVd77DbiwRV+SI1GrWj1L/oA8VXduVNWPQmMSHyHEZdp/JxrzuKb8E2Kj7D23n
         brRU3uRg/qrdVnvM0cG7k0VW8AVz5QVK3JC7In+BjPiZP8/a4BhRD25oM7IxpubqKJ
         LAU4dzEiaWUh6gU5Jm76m/ZziJ0WNe/fDc6w2yTszEN5aogu6hjy2BGtrLj3JdVoV4
         0ifoik3HNm/3akIZnndq8AAn//9yv4ADyz21V+HYQvEgNM91ODkm3sRxJLNzeUgRDS
         Ce+IRjHFQFVO0nvzJN89Ucam1HaZxs6jItbgoND1zo9Z/dh35Qjkczkj0sbwQa1M6E
         xVKeWyqh/qZvg==
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-780addd7382so12549939f.1
        for <linux-edac@vger.kernel.org>; Wed, 28 Jun 2023 20:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688010765; x=1690602765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ln7LWd40lnjGepxvFLRyaxcRyxZ30/1SOSyaN+ooqhU=;
        b=iAY1vu4fXt8trm45R+chBj0AUUKQiZQK6fK8DLcofBpqjIYWc4MWTwd4IqBl1eB7sG
         Qc/1E0BKoJ0PgNCY7bMEBM64sUwll/v/Hcgm5CwFfpvjR/29T5WPU6mZV5Aj9860PQ/M
         FfZlzi/qHQC5Yq52FAB11F2NyjMi8Lb7KzfGjiTk1/7Wec+xM6Bm0zWB6sDrXQsCpJzJ
         /dVKijvAkiGrdKT3zXwn4FuQxB5mn+Hk2NuBD87D5i0jY+Ve45LBBqQAPbHI3jzzXmIK
         lrePoU5GOWJgLbJgbeoJf8AdT0+rZCeyFBMCNlrkJkzcgbXrUxv7ARoGR7AyjULfBoR+
         ujZg==
X-Gm-Message-State: AC+VfDxpK1X5MZUiedMc3Jl9Kg8B3+bPAjsU982PQKnKpavfLTIYXu6j
        OKeB3B28/Jbpbxp0S4iw8e5jy/35r1Ke3G7uMC98Xtop6SnXIJkDP3qO5UBUK5D1bp3opFIlkW0
        Su63CVhQzt9FhJ829Tm5Eo/wzGC9Ae+vjYJmGcO30G0l/vB7hQWnVSj4=
X-Received: by 2002:a05:6602:19c7:b0:783:7307:faea with SMTP id ba7-20020a05660219c700b007837307faeamr7544507iob.2.1688010765018;
        Wed, 28 Jun 2023 20:52:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ahLOnBMgwMBsY52+7hoRe2i6gCDHsrz6TZy1dtXaKOLZeiNExKjYO+GHTOJMSyok6Q0EEBkJFQLvNqRPoS4U=
X-Received: by 2002:a05:6602:19c7:b0:783:7307:faea with SMTP id
 ba7-20020a05660219c700b007837307faeamr7544484iob.2.1688010764714; Wed, 28 Jun
 2023 20:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230628085253.1013799-1-koba.ko@canonical.com> <SJ1PR11MB608340E81A15F20EBAD75F08FC24A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608340E81A15F20EBAD75F08FC24A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Thu, 29 Jun 2023 11:52:33 +0800
Message-ID: <CAJB-X+U7Af3ypru3O0quGTqrsJPMO3b7uoBTNjTLSixrmrvXJw@mail.gmail.com>
Subject: Re: [PATCH] EDAC/i10nm: shift exponent is negative
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

hi Luck,
I agree with your points
is it expected to shift with negative?

Thanks
Koba Ko

On Thu, Jun 29, 2023 at 12:41=E2=80=AFAM Luck, Tony <tony.luck@intel.com> w=
rote:
>
> >       ranks =3D numrank(mtr);
> >       rows =3D numrow(mtr);
> >       cols =3D imc->hbm_mc ? 6 : numcol(mtr);
> > +     if (ranks =3D=3D -EINVAL || rows =3D=3D -EINVAL || cols =3D=3D -E=
INVAL)
> > +             return 0;
>
> This seems to be just hiding the real problem that a DIMM was found
> with some number of ranks, rows, or columns that the EDAC driver
> didn't expect to see. Your fix makes the driver skip over this DIMM.
>
> Can you build your kernel with CONFIG_EDAC_DEBUG=3Dy and see
> what messages you get from this code:
>
> static int skx_get_dimm_attr(u32 reg, int lobit, int hibit, int add,
>                              int minval, int maxval, const char *name)
> {
>         u32 val =3D GET_BITFIELD(reg, lobit, hibit);
>
>         if (val < minval || val > maxval) {
>                 edac_dbg(2, "bad %s =3D %d (raw=3D0x%x)\n", name, val, re=
g);
>                 return -EINVAL;
>         }
>
> -Tony
>
>
