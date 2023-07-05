Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC583748005
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jul 2023 10:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjGEIpY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Jul 2023 04:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjGEIpX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 Jul 2023 04:45:23 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A13510D5
        for <linux-edac@vger.kernel.org>; Wed,  5 Jul 2023 01:45:19 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E819F3F04D
        for <linux-edac@vger.kernel.org>; Wed,  5 Jul 2023 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688546716;
        bh=EhBgbfMMNPfoW5bol7yuNsWA9PiXcWNElnIKvGjgKG4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=gye5jX4EwjuJyOzwxlzqIhCMrjsMtXJNwBcJkGV4JrT2MYNlh/0lfpDMYkoXxqU3Y
         AsI1AuKBsx8CNdEUrjtylaPq3NO+1OSQk4nD8j5xb93XFZ29IThFFH14O09Yh3MDjy
         VnX+iXtJDAsA8pfQjZLUIBQ2AScHzogUaB0noHBY7Wky1yV9ErsofX7UFcqzyMYsOZ
         dLci+n/10o7rBWdCnLTBca26RTgTN7N2o8BA66RUPZ6vMkSLq8mGY4Bcxt4Lp8G/Ne
         8m0HNsuuUI5aOum56qFsLhIWiSBcG12VDGbLWZ4cfsY/cm0Ot0qLoQFnxKY8enSUFj
         TRfVfH3ieY9Aw==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-66872e30de9so8592089b3a.3
        for <linux-edac@vger.kernel.org>; Wed, 05 Jul 2023 01:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688546714; x=1691138714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhBgbfMMNPfoW5bol7yuNsWA9PiXcWNElnIKvGjgKG4=;
        b=WJsVTAqDNWYfydz+Cee+nX11GjktJ3OMtkrFb6/2Q1N/cUZXheGvBD4GKY6tKG8rlR
         C/AniEf907xvkdWeFybO9G9cXf1TexlO4kDK1JvH/JEWjH/w/5jVin2TeFG4C9kZSttk
         L7+ZUIuL5mFg6ZbwWcJJBhyELbWQ8Rk0lTqUUdEmmnUyJ9olR1NJGd9xoab/CHdabCNO
         +QEYTwY2XzikplghFoXyBod8VtjcRqGTOH0vfXV1JXDBQJi5TZ1F5MvXaOe/+FBXojZc
         ChUc1Ji9VHt+ejy+4kgQH/fWfGocZPFTVsLRFKSIXE+wO6LIUOGQgvmw8R3FZxN3dg+s
         BGxg==
X-Gm-Message-State: ABy/qLbfjwW7WZbZ6L/SlX+rwQs5GmYGCXYlnNqfIcr7oSjfpv7ufxmu
        EE19E/tCgtgXjxgtc+/wGb3Ca6jb5Ya+kkqIESS5x+zfbqddF1IZ7R5wjrwIWcZwZgQt14dRy/2
        GFs6OEX03of3rWXIjOwhLx8vXiobr9/oqPHpNo/6qCj+dZVY+GygUeE4=
X-Received: by 2002:a62:17d1:0:b0:666:8cbb:6e02 with SMTP id 200-20020a6217d1000000b006668cbb6e02mr16496635pfx.8.1688546713834;
        Wed, 05 Jul 2023 01:45:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGPsN2XwaB28oN7la+m6ycw2aZ7zvlnCnXD23EYRBZizfqasNPWxPXnC+DaWSeSWxpwIbpeArLp0ZNI+pR8rbc=
X-Received: by 2002:a62:17d1:0:b0:666:8cbb:6e02 with SMTP id
 200-20020a6217d1000000b006668cbb6e02mr16496613pfx.8.1688546713250; Wed, 05
 Jul 2023 01:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230703162509.77828-1-koba.ko@canonical.com> <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
 <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+UB+eYoYOOVH2bqnnVEJcLrxaj5A7-zyfgBM7hOf4y8zw@mail.gmail.com> <SJ1PR11MB608383A5841E4AE8D3A64B79FC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608383A5841E4AE8D3A64B79FC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Wed, 5 Jul 2023 16:45:01 +0800
Message-ID: <CAJB-X+VFYyTiQ7yhX=Z8-Q4QW-GMsGXMuEWxLjuoZ1aDB98qXg@mail.gmail.com>
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

On Wed, Jul 5, 2023 at 12:08=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> > I shared the whole dmesg through g-drive.
> > https://drive.google.com/file/d/1epnDZNezGiJsK1eT4UNOi8_igcBSXtiF/view?=
usp=3Dsharing
>
> The EDAC driver was OK for MC#0, but then failed for the other memory con=
trollers.
>
> Can you send some more information about your system. Output from the
> following commands:
>
> # head /proc/cpuinfo
>
> # dmidecode -t 17
>
> # lspci
please check through this url,
https://drive.google.com/drive/folders/199k3BX6IipNYCDfuMGy8W26ZtYRDIYZr?us=
p=3Dsharing
>
> Thanks
>
> -Tony
