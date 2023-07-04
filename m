Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77469746BB2
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 10:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGDIRY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 04:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGDIRW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 04:17:22 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF517107
        for <linux-edac@vger.kernel.org>; Tue,  4 Jul 2023 01:17:20 -0700 (PDT)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 68B523F84D
        for <linux-edac@vger.kernel.org>; Tue,  4 Jul 2023 08:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688458639;
        bh=plwS1E5LG/PQJYulZxtADBBk2LmEp7YgNkT8yG1tzEQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Wtcg/8IMmyA5HnxtKJoNoiG6p2iRYJNr833s+VP0wDBrofcEArWGcXzHJGPjyoxgm
         l/dEGDKxs6QhyQQ4vTl3UkElVcbYW/5d7Ylvr8vvyiG+foi0J4H3aCy3kzGQjG5JNE
         I7wY7A+lBRDQmmhXykO1mV2mJ6D9yXQntLsKUWXfkBrswdRAuagjJn2Tya2LV7FSIH
         sxazJxi7cclKvdkv4WYYC4PL3qKTjO02ZOm2MRcmcyIcn9vDywRWOzS5MC5TB3pHYx
         T4S5/pY6J+zCErh89eQ+/hWua/5YxCzKUWjiJ36935Yg7hLv970xBwcRCzjvBrOcy7
         +nsiziA/4+42w==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-55b10eb289dso5903821a12.0
        for <linux-edac@vger.kernel.org>; Tue, 04 Jul 2023 01:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688458638; x=1691050638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plwS1E5LG/PQJYulZxtADBBk2LmEp7YgNkT8yG1tzEQ=;
        b=lLnVr+zoGpES3Gnm7wcIS+b+dX5quuzOtH7O/rNmHlDs+k+wUjOKJS0TdEkVvzKQ4h
         +4/DFMHUDxkAZKcfe/tN1N6m6bexvhKgvfC1YC3f5mkv/kaSkyu+0RceQGBTMX/v8O7e
         ws8/X0UyYLq5NNfj5dhEeI404vqANrWe6HfPUFdUp6dYTBriBS3w4CpKJUzF0B/CDnz8
         IQvgqKNMoynGjR+CQWHBaKZlvGw+CPdGow9Qhk0S2FssUee6+128kbbJqSAkqeW6nPmM
         eLY8aNuEXZWn0hVBEWX8OaA0ZeQEZnLXUB90ZPx6ydk8B4QgHcU2KYqWkV9+5ZH+vZLb
         PutQ==
X-Gm-Message-State: AC+VfDzXOh4U+ZsSuM8lLuQuPGvqE9Us+3maK4Yh3c70gbOTs+sLzdwy
        JsNd1eETv+jeZhw22T6gsOOMRcP+6u/bdv3+UYD5lZbSG/MIV8rnnI0/k8qkopQQDaJ/awE4bWT
        eTQZl02y4bJPj+t2rkyD5i6xoQNrjwcte81OtMlEXQrZLHYg8xNDBr8c=
X-Received: by 2002:a05:6a21:78a3:b0:12b:93d4:4964 with SMTP id bf35-20020a056a2178a300b0012b93d44964mr14049183pzc.30.1688458637811;
        Tue, 04 Jul 2023 01:17:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Ln0TaYhLIluFosHxn/CXxOt1wk4fpmNSvx1J0RXkoKu8qkKGFM4jH+Diyfth3iF9U5T72YxH49DbwfGkJmeI=
X-Received: by 2002:a05:6a21:78a3:b0:12b:93d4:4964 with SMTP id
 bf35-20020a056a2178a300b0012b93d44964mr14049168pzc.30.1688458637488; Tue, 04
 Jul 2023 01:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230703162509.77828-1-koba.ko@canonical.com> <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
 <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+X+09-m57JcZcb-_9dKUG3CtAbLXxGTEg7R0bB8pyJx9Q@mail.gmail.com>
 <CAJB-X+XVO29wVxVezjFrgCyXigqEJxAzb0K0wueXNto5K_x2tA@mail.gmail.com> <9c27530e-21f9-15ce-5116-5af5b0c25f53@web.de>
In-Reply-To: <9c27530e-21f9-15ce-5116-5af5b0c25f53@web.de>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Tue, 4 Jul 2023 16:17:06 +0800
Message-ID: <CAJB-X+VjjxLi60k-6VNcypMB8EomJ0uYpDdfwpJ1dHPWRG7Vxg@mail.gmail.com>
Subject: Re: [PATCH v2] EDAC/i10nm: shift exponent is negative
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

@Markus and all,
please review it, thanks

Subject: [PATCH][V3] EDAC/i10nm: Fix an inappropriate shift exponen

A surprising value was determined after a read failure from a DIMM.

Software analyses pointed a data processing issue out.
`UBSAN: shift-out-of-bounds in drivers/edac/skx_common.c:369:16
 shift exponent -66 is negative`

when get rows, cols and ranks, A special value combination could not
be handled so far.

Check if an invalid value was detected by a call of the function
=E2=80=9Cskx_get_dimm_attr=E2=80=9D.
* Print a corresponding error message in this case.
* Return zero then directly from the function =E2=80=9Cskx_get_dimm_info=E2=
=80=9D.

Fixes: 4ec656bdf43a13 (EDAC, skx_edac: Add EDAC driver for Skylake)
Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
V3: simplify and polish the summary and add `Fixes:`
V2: make error-print explicitly

Thanks
Koba Ko

On Tue, Jul 4, 2023 at 3:16=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> > As per suggestions, i modified V3.
> > could you please take a look
> >
> > Subject: [PATCH][V3] EDAC/i10nm: shift exponent is negative
>
> Would you like to put the text =E2=80=9C[PATCH v4] EDAC/i10nm: Fix an ina=
ppropriate shift exponent=E2=80=9D
> into a subsequent patch?
>
> I would find further wording variants nicer.
>
>
> > Because failed to read from DIMM, get the negative value for shift
> > operation.
>
> A surprising value was determined after a read failure from a DIMM.
>
>
> =E2=80=A6
> > UBSAN complains this error
>
> Software analyses pointed a data processing issue out.
>
>
> > `UBSAN: shift-out-of-bounds in drivers/edac/skx_common.c:369:16
> >  shift exponent -66 is negative`
> >
> > when get rows, cols and ranks, the returned error value doesn't be
> > handled.
>
> A special value combination could not be handled so far.
>
>
> > check the return value is EINVAL, if yes, directly return 0 and
> > show error message explicitly.
>
> Check if an invalid value was detected by a call of the function =E2=80=
=9Cskx_get_dimm_attr=E2=80=9D.
>
> * Print a corresponding error message in this case.
>
> * Return zero then directly from the function =E2=80=9Cskx_get_dimm_info=
=E2=80=9D.
>
>
> =E2=80=A6
> @@ -351,6 +351,8 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, s=
truct dimm_info *dimm,
>         ranks =3D numrank(mtr);
>         rows =3D numrow(mtr);
>         cols =3D imc->hbm_mc ? 6 : numcol(mtr);
> +       if (ranks =3D=3D -EINVAL || rows =3D=3D -EINVAL || cols =3D=3D -E=
INVAL)
> +               return 0;
> =E2=80=A6
>
>
> Can it be nicer to perform a check for such an error code directly
> after each variable assignment?
> (May this condition check be split?)
>
>
> > Fixes: 4ec656bdf43a13) EDAC, skx_edac: Add EDAC driver for Skylake
>
> Please properly apply parentheses and double quotes for this tag.
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.4#n145
>
>
> > V2 -> V3: simplify the summary and add 'Fixes:'
> > V1 -> V2: make error-print explicitly
>
> How do you think about to use more succinct version identifiers
> for such descriptions?
>
> V4:
> =E2=80=A6
>
> V3:
> =E2=80=A6
>
>
> Regards,
> Markus
