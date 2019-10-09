Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9742D1C79
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 01:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbfJIXJb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Oct 2019 19:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732501AbfJIXJb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 9 Oct 2019 19:09:31 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9407D21A4A;
        Wed,  9 Oct 2019 23:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570662569;
        bh=ohHhwFLHLpyDn+DVqk1XdMRpeBxYlKbvgLKaFM+Thic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q2iLNgUOqojrOM61BLBav7VkGbGgdRBJd+Uz00O8OQMEB7O/pT3j8MiTx1XVPFm1r
         EM4gkBtkY/JuI/3lu5BXSZyNplbKxaaPI9Rm9UdL8CrBy7Vwo0TmCh5l+Y13sD0UCY
         +saSwHvqYFfNrFT7YkxGVyPJGqnXkX1qvwHyIB7Y=
Received: by mail-qk1-f170.google.com with SMTP id x134so3874606qkb.0;
        Wed, 09 Oct 2019 16:09:29 -0700 (PDT)
X-Gm-Message-State: APjAAAUpziyGSc//TPmLO8MJFmvuqu3NJDMhfrgItx5huVqaHyI0zZaW
        9gXZx5hRT/LpbB64bSPu/cjWr4PXeqcCjRjK2Q==
X-Google-Smtp-Source: APXvYqxP5h6YfF3g56z6aD9hgcWAFrYHQC8vVGWxR537UKM4B1W7VOEFkDrtF21cIt5wBe67jfxL/DikrBoKWbynmXY=
X-Received: by 2002:a05:620a:136e:: with SMTP id d14mr6214231qkl.393.1570662568596;
 Wed, 09 Oct 2019 16:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191007151730.7705-1-hhhawa@amazon.com> <20191007151730.7705-4-hhhawa@amazon.com>
In-Reply-To: <20191007151730.7705-4-hhhawa@amazon.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 9 Oct 2019 18:09:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKk1SeUTPdVOC_5ewC+xqdPMZbBxiqZHYO3Zdme06P57w@mail.gmail.com>
Message-ID: <CAL_JsqKk1SeUTPdVOC_5ewC+xqdPMZbBxiqZHYO3Zdme06P57w@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] edac: Add support for Amazon's Annapurna Labs L2 EDAC
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>, daniel@iogearbox.net,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        devicetree@vger.kernel.org, "Woodhouse, David" <dwmw@amazon.co.uk>,
        benh@amazon.com, "Krupnik, Ronen" <ronenk@amazon.com>,
        Talel Shenhar <talel@amazon.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        "Hanoch, Uri" <hanochu@amazon.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

+Sudeep

On Mon, Oct 7, 2019 at 10:18 AM Hanna Hawa <hhhawa@amazon.com> wrote:
>
> Adds support for Amazon's Annapurna Labs L2 EDAC driver to detect and
> report L2 errors.

I was curious why you needed a DT cache parsing function...

[...]

> +static int al_l2_edac_probe(struct platform_device *pdev)
> +{
> +       struct edac_device_ctl_info *edac_dev;
> +       struct al_l2_edac *al_l2;
> +       struct device *dev = &pdev->dev;
> +       int ret, i;
> +
> +       edac_dev = edac_device_alloc_ctl_info(sizeof(*al_l2), DRV_NAME, 1, "L",
> +                                             1, 2, NULL, 0,
> +                                             edac_device_alloc_index());
> +       if (!edac_dev)
> +               return -ENOMEM;
> +
> +       al_l2 = edac_dev->pvt_info;
> +       edac_dev->edac_check = al_l2_edac_check;
> +       edac_dev->dev = dev;
> +       edac_dev->mod_name = DRV_NAME;
> +       edac_dev->dev_name = dev_name(dev);
> +       edac_dev->ctl_name = "L2_cache";
> +       platform_set_drvdata(pdev, edac_dev);
> +
> +       INIT_LIST_HEAD(&al_l2->l2_caches);
> +
> +       for_each_possible_cpu(i) {
> +               struct device_node *cpu;
> +               struct device_node *cpu_cache;
> +               struct al_l2_cache *l2_cache;
> +               bool found = false;
> +
> +               cpu = of_get_cpu_node(i, NULL);
> +               if (!cpu)
> +                       continue;
> +
> +               cpu_cache = of_find_next_cache_node(cpu);
> +               list_for_each_entry(l2_cache, &al_l2->l2_caches, list_node) {
> +                       if (l2_cache->of_node == cpu_cache) {
> +                               found = true;
> +                               break;
> +                       }
> +               }
> +
> +               if (found) {
> +                       cpumask_set_cpu(i, &l2_cache->cluster_cpus);
> +               } else {
> +                       l2_cache = devm_kzalloc(dev, sizeof(*l2_cache),
> +                                               GFP_KERNEL);
> +                       l2_cache->of_node = cpu_cache;
> +                       list_add(&l2_cache->list_node, &al_l2->l2_caches);
> +                       cpumask_set_cpu(i, &l2_cache->cluster_cpus);
> +               }
> +
> +               of_node_put(cpu);
> +       }

We already have what's probably similar code to parse DT and populate
cacheinfo data. Does that not work for you? If not, why not and can we
extend it?

Then your driver might work if the data comes from ACPI instead (or
maybe that's all different, I don't know).

Rob
