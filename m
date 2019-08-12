Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1EEB8A419
	for <lists+linux-edac@lfdr.de>; Mon, 12 Aug 2019 19:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbfHLRQw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Aug 2019 13:16:52 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43100 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfHLRQw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Aug 2019 13:16:52 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so13227855qkd.10;
        Mon, 12 Aug 2019 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtBXM090wQ33aSD3OfaN8dNIs/4MWHf6KDcAkchuLpQ=;
        b=RR7TtUdP82ci6fgUyyFPtz5v03ncaUV+qUbf9QTbsSN48mhud6FQMJIWcnmdGgx3/v
         kA+oZAE70C3ETI1ZxHHg6MUIiJeF8a/f09srgpsLn/sYpWM2iY71ZdaVa2XK5kuO670q
         p3VW/ObwgBXNqNkSGuppsgKJimQJvTWk6X4HGQGSALkV3Rh+Q38/lB9K1PtuuG9FiJ87
         hPoJR+hWaga1WJeKluEZwHQmP0CRJMbd5W/JlPmoMhruDlyZZBbEgDUT9AhCvIxfpzXe
         GGiEvoyW8XMDSbzwbvlzgDJDfrsXd9tJVi1jYoilIw5EFnHSvZViqPBPqIralIv2fRHX
         6TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtBXM090wQ33aSD3OfaN8dNIs/4MWHf6KDcAkchuLpQ=;
        b=TlU2dnkkkD8SZ10YMSoTtgD+rJ99y22xz8e/znNcxLVfWhxIPrm/W2o1kjpFriB2T8
         yxOFlD3VjTXLBxGKduIcEAQY+N6MmH/TYpoA5LNZ1lHQdCHdD7KoPzn5SEfyWTg5o2vJ
         RJIRA/NQND75cSyLOGPZUTHrDlL7g0Y/PlsdXZTcdNnMA9hHTSQ+1JAz5R/8NC0hJmP1
         fQMNK9tfpLKSNiHOMji6f6TbcrFYaNuJPu7yX41QfbaHMQgDMNrX13UgaD1dUgZiImu1
         flE0NLzRAw+RmE4vtQAiHeefBQUrCTh6X7qeJ+jOj3WKIzlQn8MProOXrdAndDRG7qQ2
         AGqw==
X-Gm-Message-State: APjAAAX5Gpy5Lo4yTSHAgOoc6zftwfQZ4UA9dStLSQySSUa00u/V79fg
        lEBit4ZfUt0P3dABs366TRdi8S9w5XzMX7khUkE=
X-Google-Smtp-Source: APXvYqyLHmujuBanHsJfl5xNeVIrqPmRXrXe6Gt6bY0l1E1v1ndOo/T1IuOolwjZjXVUcDrOQJ2UWWeX2ocPzTjbE9Y=
X-Received: by 2002:a37:7144:: with SMTP id m65mr24542013qkc.149.1565630211206;
 Mon, 12 Aug 2019 10:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <1560928518-243100-1-git-send-email-jiping.ma2@windriver.com> <1560928518-243100-2-git-send-email-jiping.ma2@windriver.com>
In-Reply-To: <1560928518-243100-2-git-send-email-jiping.ma2@windriver.com>
From:   Tony Luck <tony.luck@intel.com>
Date:   Mon, 12 Aug 2019 10:16:40 -0700
Message-ID: <CA+8MBbKegE2Z3YqB+a4XFEwN=C23YG3c9ju3su-WS5pt1HPCwA@mail.gmail.com>
Subject: Re: [PATCH] EDAC, ie31200: Add Intel Corporation 3rd Gen Core processor
To:     Jiping Ma <jiping.ma2@windriver.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 19, 2019 at 12:34 AM Jiping Ma <jiping.ma2@windriver.com> wrote:

Oops. Boris pointed out to me that this has been left hanging. Sorry
for the delay.

> 3rd Gen Core seems to work just like Skylake.

Maybe "just like all the other Xeon-E3 processors?

"3rd Gen Core" seems to be Ivybridge generation (based on the PCI
device ID below).
I.e. "Xeon E3-12xx V2". Is that correct?

I don't have a way to test that, so I'd like some more details on the
testing that
you have done.  Specifically has this driver been run on a system and correctly
reported at least one error?

> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
> ---
>  drivers/edac/ie31200_edac.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
> index aac9b9b..1445336 100644
> --- a/drivers/edac/ie31200_edac.c
> +++ b/drivers/edac/ie31200_edac.c
> @@ -19,6 +19,7 @@
>   * 0c08: Xeon E3-1200 v3 Processor DRAM Controller
>   * 1918: Xeon E3-1200 v5 Skylake Host Bridge/DRAM Registers
>   * 5918: Xeon E3-1200 Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
> + * 0154: 3rd Gen Core processor DRAM Controller

I think this line should be added chronologically by age of processor
(i.e. at the start
of the list)

>   *
>   * Based on Intel specification:
>   * http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e3-1200v3-vol-2-datasheet.pdf
> @@ -59,6 +60,7 @@
>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_7 0x0c08
>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_8 0x1918
>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_9 0x5918
> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_10 0x0154
>
>  #define IE31200_DIMMS                  4
>  #define IE31200_RANKS                  8
> @@ -569,6 +571,9 @@ static void ie31200_remove_one(struct pci_dev *pdev)
>                 PCI_VEND_DEV(INTEL, IE31200_HB_9), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>                 IE31200},
>         {
> +               PCI_VEND_DEV(INTEL, IE31200_HB_10), PCI_ANY_ID, PCI_ANY_ID, 0, 0
> +               , IE31200},
> +       {
>                 0,
>         }            /* 0 terminated list. */
>  };
> --
> 1.9.1
>
