Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8988D3C6AA2
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jul 2021 08:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhGMGgb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Jul 2021 02:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbhGMGga (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Jul 2021 02:36:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF213C0613DD;
        Mon, 12 Jul 2021 23:33:29 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b26so15963250lfo.4;
        Mon, 12 Jul 2021 23:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMJaT/nZ6S3bRnzrlMyan4xNGvrrXcYoCyU3SginI2A=;
        b=vUux1m6X3zVaN75YGOyNj4/StrdScUMFS6amXR0rSqVZKGq7PRlRo0rMYsPqhHrxq/
         ujYO4PBrWIbVvABxQhDXSHsUiKX67UbLVFRU9fXX5Mg247KADBx7Fpg8CO6Cv/aMofrK
         m/6DerrjN6eVVaeU+Tz1W5Sk9dabAN8EM+CU4oAvxNOjB8dljQkDBh31uIgcUneT8US7
         OYNlDRzeHWNhIPxD5pvh2E9ihIAdTpKcLRFnMGpkd57Qv+NE/dM3Gqt0f40Nis5utYw7
         Gm3OVgRY4dmirShEvkq73liqjr/+HeOYD2oNPjzUNW67GtjO/N/KADtDGzdL0up/rwBR
         Hm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMJaT/nZ6S3bRnzrlMyan4xNGvrrXcYoCyU3SginI2A=;
        b=Xwh5l+R4nrO9R8PiOagoaodW3bim8lj77ZZM4IPQiNboQbJa7Eay5CTqOvdB2Bh/+H
         kwzc610wSs8AppsGAEa5XK7c0wKFRRjng70IrjbKW7gPCkMLNDt+xjCNHkzFyzrH5GZw
         7hnQy8cXEEYcIwE5qe3fJEuwatZ4C6Nf8CmrX+lC1hdax9opvAi2FLvllwMbEtIAjM+I
         iwszMNECedUPxSMu40kHRXoFLr8cxy+uYos2BWNTuz5PdciQQn9mzXQrAeV72RTji2ez
         4bzcJ6VYYF83LgPpLxnues5hA3vzOiqJ7f2ZtozE3sjuOIjqSNIRRSjIqL//SGcbyz5/
         466g==
X-Gm-Message-State: AOAM531cdLq90oixakUY+cDTnC3r+q3gq/M+ls/KQYN5W72+cEL7PCtx
        cvkSXRH0Tm2Ob5myWZzMk0kFFtx4XEjS4IblcNA=
X-Google-Smtp-Source: ABdhPJyNTI/m2EI6US1z4Qhq+ZpzG82hXaT5ovcFwoPSSlrcEZhk8S5Q8+IsGbxPNQH2dx01/VQdaqHNCtCaiOKcPrg=
X-Received: by 2002:ac2:4ed9:: with SMTP id p25mr2194335lfr.576.1626158008035;
 Mon, 12 Jul 2021 23:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210711141002.103445-1-dwaipayanray1@gmail.com> <20210712194433.GA1002@aus-x-yghannam.amd.com>
In-Reply-To: <20210712194433.GA1002@aus-x-yghannam.amd.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Tue, 13 Jul 2021 12:03:17 +0530
Message-ID: <CABJPP5AHCidvreH0segwYmHL8k1+1uxSjRRtOeexR1vYPhh9Vg@mail.gmail.com>
Subject: Re: [PATCH v2] drivers:edac: Use DEVICE_ATTR helper macros
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     bp@alien8.de, Mauro Carvalho Chehab <mchehab@kernel.org>,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        kbuild-all@lists.01.org, linux-edac@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jul 13, 2021 at 1:14 AM Yazen Ghannam <yazen.ghannam@amd.com> wrote:
>
> On Sun, Jul 11, 2021 at 07:40:02PM +0530, Dwaipayan Ray wrote:
> > Instead of "open coding" DEVICE_ATTR, use the corresponding
> > helper macros DEVICE_ATTR_{RW,RO_WO} in amd64_edac.c
> >
>
> I think you meant to write "RO,WO" rather than "RO_WO", correct?
>

Yes that's correct. It's a typo. I will fix it.

> Was this change inspired by a code-checking tool or script?
>

Yes, the particular warnings were detected via a checkpatch run on
the whole kernel and screening for really unwanted violations.
However, the changes were made manually.


> > Some function names needed to be changed to match the device
> > conventions <foo>_show and <foo>_store, but the functionality
> > itself is unchanged.
> >
> > The devices using EDAC_DCT_ATTR_SHOW() are left unchanged.
> >
> > Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> > ---
> >
> > Changes in v2:
> > - Revert back the device name changes which broke
> >   the kernel. These were using the macro EDAC_DCT_ATTR_SHOW()
> >   to construct the show methods based on device name.
> >   Reported by Kernel test bot.
> >
> >  drivers/edac/amd64_edac.c | 21 ++++++++-------------
> >  1 file changed, 8 insertions(+), 13 deletions(-)
> >
>
> The $SUBJECT should say something like "EDAC/amd64" since the change is
> wholly within amd64_edac.c. Using "driver:edac" makes it seem like this
> patch affects multiple EDAC modules.
>

That makes sense. I will send in a new patch with these updates.

> But otherwise it looks good to me.
>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>
> Thanks,
> Yazen

Thanks for the review,
Dwaipayan.
