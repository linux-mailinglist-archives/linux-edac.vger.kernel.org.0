Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEAEE1443A0
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jan 2020 18:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAURxh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 Jan 2020 12:53:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgAURxh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 21 Jan 2020 12:53:37 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66C4720882;
        Tue, 21 Jan 2020 17:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579629216;
        bh=jSqnb8251iB+PaUjwL/WFnS37zciALpQsGn4VLiEZOM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pssvT+PNFm+V3NvPNyFH+RbfyYZF5MO2gKEGEnsd0K1kGLLSzzSQr2WAaFqWFlWXY
         aHO7HW+SWWV7htzelymF29D+hVY70A3cWLPyP46zOG8QNDg/OsPxGOZbMo6IQ7yesV
         2eqyFQXlAJZbovUdFWJ3wU4SGj16jqPUjA0Vi8r4=
Received: by mail-qk1-f182.google.com with SMTP id 21so3607035qky.4;
        Tue, 21 Jan 2020 09:53:36 -0800 (PST)
X-Gm-Message-State: APjAAAW2bHa4BicuauCnSmK36hnbDUumROoDLhpV4XT7JhYV7/y0zK0+
        jcQVDmiHlSlg+NvLD8RL2oFEZ1DDfgtFZKA/pw==
X-Google-Smtp-Source: APXvYqzHLixt8IrlgT/au2K+GmxkDhCwSit+HjQFs08D+Z88/At71jstGFhsanilwAJ1+GPhBTdil9wNxv/SeT9soW8=
X-Received: by 2002:a05:620a:135b:: with SMTP id c27mr5331728qkl.119.1579629215564;
 Tue, 21 Jan 2020 09:53:35 -0800 (PST)
MIME-Version: 1.0
References: <4fbf026a-4878-cd65-55f7-7d992782b331@gmail.com> <20200116233939.GI27148@zn.tnic>
In-Reply-To: <20200116233939.GI27148@zn.tnic>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Jan 2020 11:53:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKqC_xm9rrHYaO87BtEv=-ji080p_G8axFduqu1mcqHCA@mail.gmail.com>
Message-ID: <CAL_JsqKqC_xm9rrHYaO87BtEv=-ji080p_G8axFduqu1mcqHCA@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: edac: arm-dmc520.txt
To:     Borislav Petkov <bp@alien8.de>
Cc:     Shiping Ji <shiping.linux@gmail.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        shji@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>, wangglei@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 16, 2020 at 5:39 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jan 15, 2020 at 06:32:27AM -0800, Shiping Ji wrote:
> > This is the device tree bindings for new EDAC driver dmc520_edac.c.
> >
> > Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
> > Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> > Reviewed-by: James Morse <james.morse@arm.com>
>
> So for this patch, v2 had Rui Zhao as an author:
>
> https://lkml.kernel.org/r/BN7PR08MB5572B3388B2D7DC8F6C7F285AE4C0@BN7PR08MB5572.namprd08.prod.outlook.com
>
> v3 got Lei as an author:
>
> https://lkml.kernel.org/r/CY1PR0401MB1244062C1738B09D6100F202860A0@CY1PR0401MB1244.namprd04.prod.outlook.com
>
> and now it is you.
>
> So when you send next time, think about who's going to be the author.
>
> > +     line numbers. The valid interrupt names are the followings:
>
> WARNING: 'followings' may be misspelled - perhaps 'following'?
> #51: FILE: Documentation/devicetree/bindings/edac/arm-dmc520.txt:10:
> +     line numbers. The valid interrupt names are the followings:
>
> Please integrate scripts/checkpatch.pl into your patch creation
> workflow. Some of the warnings/errors *actually* make sense.
>
> Also, this patch throws this other checkpatch warning:
>
> WARNING: DT bindings should be in DT schema format. See: Documentation/devicetree/writing-schema.rst
>
> but since Rob reviewed it, I'm going to assume checkpatch is wrong here.

Would be happy for a schema, but not going to ask for that on a v9.

Rob
