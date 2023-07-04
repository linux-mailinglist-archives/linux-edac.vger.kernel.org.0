Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A69F74716E
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 14:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGDMdU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 08:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjGDMdN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 08:33:13 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73B9DA
        for <linux-edac@vger.kernel.org>; Tue,  4 Jul 2023 05:33:11 -0700 (PDT)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 13CC33F18A
        for <linux-edac@vger.kernel.org>; Tue,  4 Jul 2023 12:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688473986;
        bh=gy4Y3Oco7V4O0qs2lvEoa7dVI3NuFWh8wF5vNDqvAfY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=YbyLnMseoSs17MIiRKp3cANONSRJvI3nPl+Zx4kXIg3KSHmyIqhUpIs3Gxkqmo9yW
         dl94c8+ucmsH5j/cigCQ5eWhSUWaxMGbhqYAg638DhLa+OeU9Wvdk26aM0jjc1w2EL
         LbXVtTl/fyykPdocS1ju9aX/a8JZZxBo8lhOsi0POi3bNqRYutUIYP+ekvMZMvKCOQ
         BFmwNG6yXj86oe+6GP3EDzOUhD4sbhi53Ym/JDRGUG3uKaROqMHi0OVMiXGO6I6Rox
         XG0KSg0cOfpAlugKAXa3695Rp7KYgg5gfrGW/4zhgw7boVq8ZwDnirbN09sa842+NH
         I/asQq/NA/fZw==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-55afcc54d55so5704258a12.0
        for <linux-edac@vger.kernel.org>; Tue, 04 Jul 2023 05:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688473983; x=1691065983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gy4Y3Oco7V4O0qs2lvEoa7dVI3NuFWh8wF5vNDqvAfY=;
        b=aDIQzegatQ9+3334hRWDPTTNRNaErH4E/JRJ46IZ6exin9dJF/S9DG/yqYR0ovmg2U
         YF0cdV5mL8wd1i/PR8RnyA/9uPeLvD1s0LNJoSGizYul3BiqcGBZ+XE0Sf6d2xzEsGRv
         AwA2xQGp2jTOPfZdvX1kIiRGxrXHSm69lbF0Z6hkoFUrRPK4QSB92RzdYMD7PIujmZ6L
         zub7t560xq7Vobgy24a1AOx2DAsbPX8j1mQWCAM1pnC4mcfaNMCIv5CKtBp9ayjuBP84
         WzRCrm3nERTXTwL6JBUSR9+s4bJGoDQTulU7mfBi+yd4UIlXe6J14y/wo4SnPnSqv8Wd
         pABg==
X-Gm-Message-State: ABy/qLbQwU4MZtyQGfCCUTutHR5LpuF5H50JKI3t8NmImXujVhoxFvMK
        sDxy8699ieaWu/bMlWZam8TZDqG0tTSWB+kUAhNOnoyLvYsV1CPBUrCUcWf4wibGkNwFt5JoADR
        7Adir3+/sZxXIdghYRUIZupRSGk0e/5i7O8i1xkJaLJo7uPh4ePKvaPNab/BC+Cl2kg==
X-Received: by 2002:a05:6a21:3814:b0:12e:44:a1a6 with SMTP id yi20-20020a056a21381400b0012e0044a1a6mr8431325pzb.11.1688473983386;
        Tue, 04 Jul 2023 05:33:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGae+2iySp3xgwZd0kWkyY46HWnfktpgUwojgNRFu2M9Wl2v4eWGdhI9PBPcXvWopiWdqDucbx4YO6MZ31PIcI=
X-Received: by 2002:a05:6a21:3814:b0:12e:44:a1a6 with SMTP id
 yi20-20020a056a21381400b0012e0044a1a6mr8431303pzb.11.1688473983018; Tue, 04
 Jul 2023 05:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230703162509.77828-1-koba.ko@canonical.com> <a0bf3b4c-a528-4507-9bd4-95a0a9eb927d@moroto.mountain>
In-Reply-To: <a0bf3b4c-a528-4507-9bd4-95a0a9eb927d@moroto.mountain>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Tue, 4 Jul 2023 20:32:51 +0800
Message-ID: <CAJB-X+XtfBm0a4btt6NT9rvdrxETNLNMVQ3G=u513Nh8RKwjWw@mail.gmail.com>
Subject: Re: [PATCH][V2] EDAC/i10nm: shift exponent is negative
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
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

On Tue, Jul 4, 2023 at 8:02=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> Here is a better commit message.  You can just copy and paste it.
> ------------------------------------------
> [PATCH v3] EDAC/i10nm: Prevent negative shifts in skx_get_dimm_info().
>
> UBSAN generated the following warning during a timeout:
>
>     UBSAN: shift-out-of-bounds in drivers/edac/skx_common.c:369:16
>     shift exponent -66 is negative
>
> That most likely means that rows, cols, and ranks were all set to
> -EINVAL.  Address this in two ways.
>
> 1) Change the debug output in skx_get_dimm_attr() to KERN_ERR so that
>    users will know where exactly the error is.
> 2) Add a check for errors in skx_get_dimm_info().
>
> Fixes: 88a242c98740 ("EDAC, skx_common: Separate common code out from skx=
_edac")
> Signed-off-by:
> -----------------------------------------------

have sent V3 as per Markus' comments.
https://patchwork.kernel.org/project/linux-edac/patch/20230704095939.119620=
-1-koba.ko@canonical.com/
Thanks
>
> > @@ -351,6 +351,8 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap,=
 struct dimm_info *dimm,
> >       ranks =3D numrank(mtr);
> >       rows =3D numrow(mtr);
> >       cols =3D imc->hbm_mc ? 6 : numcol(mtr);
> > +     if (ranks =3D=3D -EINVAL || rows =3D=3D -EINVAL || cols =3D=3D -E=
INVAL)
> > +             return 0;
>
> Change this to:
>
>         if (rangks < 0 || rows < 0 || cols < 0)
>                 return 0;
>
> It's bad form to check for a specific error code unless there is a need.
>
> regards,
> dan carpenter
>
