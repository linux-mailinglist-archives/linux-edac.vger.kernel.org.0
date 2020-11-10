Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A6F2AD933
	for <lists+linux-edac@lfdr.de>; Tue, 10 Nov 2020 15:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgKJOso (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Nov 2020 09:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730368AbgKJOsn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 10 Nov 2020 09:48:43 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626B8C0613D1
        for <linux-edac@vger.kernel.org>; Tue, 10 Nov 2020 06:48:43 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s30so17906710lfc.4
        for <linux-edac@vger.kernel.org>; Tue, 10 Nov 2020 06:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TRtX8baRaCtbeDJjWA3IRYfdgtIW44Wdj4Sdz3HfZMA=;
        b=An/Ddk0HLR+91xPRpInCFnfZ9o+5szjLSy+NtnyMq7UJRY1S3pi1mcTpeSPq8yWGO7
         +hYo5dzW6PHxmv0YE0x63sDphTthBePQ7rc/OdTTaSn1XaXPVNTS2Qj572/59VtqdnSE
         ADq1kQeLGgCPetyHlz4LQ8E+f4lA+tewwA3JqwJikM3iaVmfqn+lcqYRQW/wE7ooEhJ+
         bUglFTYdPjIL+R6utnbfqDb4IhOZ5rx4bucFlRBZmrj8DrD8Mjij9VzBx0YIKOoIC2Nb
         AA/x0kRUOLLFfqW7r0bkOIMPkR+YoHRBgD+4KlQ2b15e9/I5sO+IMBiDslv4L69nF3h/
         5YMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TRtX8baRaCtbeDJjWA3IRYfdgtIW44Wdj4Sdz3HfZMA=;
        b=U/kvEvWI59851P8q7FDfR6Gm97akCthQNrB5eEwmEQp5M0y4jtXKE3Ohqv3/dKr7dE
         7IWQTBgRf4VfDw+U6l8iAGeMmObmQb8J0resAnYrzpMz7oUqEWlkTcXnPQ1dGumfsnVD
         vF4GfQ7dUxKIvOHkC7wzb5ydLRHGjXlG2k9winqmnHaH1sAfUjPDuQX9QRpV67kH4ryP
         VYLmAn+hPkYx60vRDBQtP2WTZQhVaYYAyq3Hlf4MXO77rUGDoI/+F++iqzB6j3wJcTLu
         /u2T8Ni8eRFPxMVFP5lS4K7tdZ5DmhdD0s+JJNUnbtGnTcpMSgp6MvdNPcJqjcuSlF03
         M+lQ==
X-Gm-Message-State: AOAM530vALvxl6CB0+ET5iiwK0AqRT5auS/zWc2sSVXziYFfLGNGHZSy
        r+SjBZaWWPo4xdHWOdxlkv1xhFMq+XUrVddLYRoyyQ==
X-Google-Smtp-Source: ABdhPJw46ud/uUkcZJ6tSOXJvAqor8Mj5zSR0l7JClGYT9/b+K2wIXlkgMzo8k4v5SokXVFThmMVRoGjQRQOqS4C810=
X-Received: by 2002:ac2:4ac7:: with SMTP id m7mr5517480lfp.572.1605019721579;
 Tue, 10 Nov 2020 06:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20201109110654.12547-1-brgl@bgdev.pl> <20201109110654.12547-6-brgl@bgdev.pl>
In-Reply-To: <20201109110654.12547-6-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Nov 2020 15:48:30 +0100
Message-ID: <CACRpkdZ9tRHFS51pnQg_TgKGed3pD_hRE_rGP_9tiFNcGrb1bQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] pinctrl: use krealloc_array()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-edac@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev <netdev@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Nov 9, 2020 at 12:07 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Use the helper that checks for overflows internally instead of manually
> calculating the size of the new array.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
