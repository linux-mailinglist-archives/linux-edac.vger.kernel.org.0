Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1799695721
	for <lists+linux-edac@lfdr.de>; Tue, 20 Aug 2019 08:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfHTGMV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 20 Aug 2019 02:12:21 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38605 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfHTGMV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 20 Aug 2019 02:12:21 -0400
Received: by mail-lf1-f67.google.com with SMTP id h28so3175792lfj.5
        for <linux-edac@vger.kernel.org>; Mon, 19 Aug 2019 23:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVWwBfeeEc6ykP1yn9xAU0YHj4y8t5z69Vb4C4M4hMM=;
        b=Ak1KPl2ruMueSxtLrtsk2/HCDb7HZSPVMHFJes7D6Z1B713y8fDQV/krKLsyza9bY6
         WFmr4Wl4fUgERrYga+/eO5AawMmTfNntXSRGSs9rtGQfHjlHBpqyn2R9pNqrKj+/5JdN
         C3wXAKUSbmN8APlzDES6eZSWSG0OeEDnwdNYxOPNvxm1gX6GWPblu+K83n3ylcQ8UrOo
         gWv2Ma1vvO0VQCC4ZOZgDlCuLIdFrfpktl1bvGkVz/R0AFCPf94al/hWf5h+Fo9r0vAe
         t0e1DzYQawnXhbFm5BMgPuDYPgE3GN6/Aq1q31ejOFFC7g9zo6te1tOTUwf6Tc/di12S
         vAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVWwBfeeEc6ykP1yn9xAU0YHj4y8t5z69Vb4C4M4hMM=;
        b=AZFpYGctCfgviIK1gxUVJBLLV4hcus7F3M1C/yIeda9oItYOey1Z9PKCLWEWup7zsE
         zFH7lHtqT8by7IHamR+9N4hlHnJ8gnuv2QcsC9x0ViWNngc3uN4KXIJNZFJYYATNBdNA
         0wuUL56t1p8feOu8ay1nA4IcdFitTZDmPeT4PPu0yW7tLXHJotg/GplE4E+GorJo5gQ5
         ugevNf+apaA0ZBLMLjJP62nSkG9qq1W/Wodv/haowCY58lqWpPfE6Nnhwgj177q7Tt2/
         7L7iZuf6ITjmAzCQJjpkoccMSYYtv9TeCZSn9o70/wcAvDYtTW8baAVN4s/GLsurWPR/
         PH0g==
X-Gm-Message-State: APjAAAWu6fWVcA5jHkbJ6rKcxttAjXhiJAgThu628WuToed6W2marPuU
        JIRBD/EQCPwyodljZD/N11ZDj3U92n9pDJhXrTn9cA==
X-Google-Smtp-Source: APXvYqzV9ocam7R0KX0h25q6wZG5L3RbMxVhpIEF0AhCwIEfcOv3/2UNAL1mhxVdOGFdkYJqlRLxEzVxWcbziV0wnPc=
X-Received: by 2002:ac2:4309:: with SMTP id l9mr14044401lfh.65.1566281539133;
 Mon, 19 Aug 2019 23:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190814143136.GA3226@mwanda>
In-Reply-To: <20190814143136.GA3226@mwanda>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Tue, 20 Aug 2019 11:41:42 +0530
Message-ID: <CAJ2_jOH07XQrn3PfVpEt2eM5y44dc6rxrtbUUDSZ5oFBXAx3_A@mail.gmail.com>
Subject: Re: [bug report] EDAC/sifive: Add EDAC platform driver for SiFive SoCs
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Aug 14, 2019 at 8:01 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Yash Shah,
>
> The patch 91abaeaaff35: "EDAC/sifive: Add EDAC platform driver for
> SiFive SoCs" from May 6, 2019, leads to the following static checker
> warning:
>
>         drivers/edac/sifive_edac.c:60 ecc_register()
>         warn: 'p->dci' can also be NULL
>
> drivers/edac/sifive_edac.c
>     43  static int ecc_register(struct platform_device *pdev)
>     44  {
>     45          struct sifive_edac_priv *p;
>     46
>     47          p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
>     48          if (!p)
>     49                  return -ENOMEM;
>     50
>     51          p->notifier.notifier_call = ecc_err_event;
>     52          platform_set_drvdata(pdev, p);
>     53
>     54          p->dci = edac_device_alloc_ctl_info(0, "sifive_ecc", 1, "sifive_ecc",
>     55                                              1, 1, NULL, 0,
>     56                                              edac_device_alloc_index());
>     57          if (IS_ERR(p->dci))
>                     ^^^^^^^^^^^^^^
> The edac_device_alloc_ctl_info() function never returns error pointers,
> it returns NULL.
>

Thanks for reporting this bug. Currently, a discussion is going on to
move this code into some other directory. The patch for the same has
been submitted [0].
I will take care of this bug once that patch is accepted.

- Yash

[0] https://lkml.org/lkml/2019/8/18/39
