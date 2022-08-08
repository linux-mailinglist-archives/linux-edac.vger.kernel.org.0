Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FFB58CD8B
	for <lists+linux-edac@lfdr.de>; Mon,  8 Aug 2022 20:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiHHSSO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Aug 2022 14:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiHHSSL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Aug 2022 14:18:11 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CC4B4A5;
        Mon,  8 Aug 2022 11:18:10 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id n8so14939525yba.2;
        Mon, 08 Aug 2022 11:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8jH7+ZXVqCzuIvf2o9j1mefBDUXyehpM3Odx06gRB+w=;
        b=ZQO1uBfRhgTO+skCDBPVVF4Mb0a4ywRSV+OUdUpToo7NAPA55iaADRL57SEpTkDXHp
         NHUJidLTwtJDjTtdI+4fZb9dPc0z+9cpGCtGxkjc/rW6gEmdiAjmRInNtdudKNY2O57z
         rJjz0sfoHTYw7WCns8LcVuyFjxWjNpoSPC66pF2QNF0Gfqdbvlpb2E4pvg4/VjE5oePz
         Zm5j7eb+8iHBM+EcAtWVBVdXPFlIj1H6bvF8R2FM+7GZdjDFdlfRzm6J3HVVTDUSqdpQ
         qy9PnbgLUiqQJWcOsHoc+KIhtq059YCqqULdQq+yD5WUXHrEMVrRigXTG3c/CKOYO16w
         ZBeA==
X-Gm-Message-State: ACgBeo0UBvno0mPVeV+jIeCo8kj8TI3Fk3EQYy+pngptnyrqQ6nmEVel
        Uk2dTxTMsIixFuCqqs6SJ6DQobRo8Vs/6UfKw89VMiCk
X-Google-Smtp-Source: AA6agR6PTShLHObcZjSmfMFci6QIl6i+0BPkse1W7qtCHO00ewr0c8Z/ZhJk0lvdgsy8Z9O1s/6EWIR3H/B6f+Hr4ok=
X-Received: by 2002:a25:cc51:0:b0:676:ccba:875 with SMTP id
 l78-20020a25cc51000000b00676ccba0875mr17832490ybf.137.1659982689714; Mon, 08
 Aug 2022 11:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220805023200.154634-1-justin.he@arm.com>
In-Reply-To: <20220805023200.154634-1-justin.he@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Aug 2022 20:17:58 +0200
Message-ID: <CAJZ5v0gUbKYaxRcZsYO6eq7vLgKdgfdLdoL_Hzmd6r-JczkVPg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: move edac_init ahead of ghes platform drv register
To:     Jia He <justin.he@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 5, 2022 at 4:32 AM Jia He <justin.he@arm.com> wrote:
>
> Commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in
> apci_init()") introduced a bug that invoking ghes_edac_register()
> before edac_init(). Because at that time, the bus "edac" hasn't been
> registered, this created sysfs /devices/mc0 instead of
> /sys/devices/system/edac/mc/mc0 and caused a sysfs dup splat on an
> Ampere eMag server:
>  sysfs: cannot create duplicate filename '/devices/mc0'
>  CPU: 19 PID: 1 Comm: swapper/0 Not tainted 5.19.0+ #138
>  random: crng init done
>  Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 0.14 02/22/2019
>  Call trace:
>   sysfs_warn_dup+0x6c/0x88
>   sysfs_create_dir_ns+0xec/0x108
>   kobject_add_internal+0xc0/0x328
>   kobject_add+0x94/0x108
>   device_add+0x104/0x8b0
>   pmu_dev_alloc+0xb4/0x128
>   perf_pmu_register+0x308/0x438
>   xgene_pmu_dev_add+0x168/0x2c8
>   acpi_pmu_dev_add+0x1f0/0x370
>   acpi_ns_walk_namespace+0x16c/0x1ec
>   acpi_walk_namespace+0xb0/0xf8
>   xgene_pmu_probe+0x6b8/0x8a0
>   platform_probe+0x70/0xe0
>   really_probe+0x164/0x3b0
>   __driver_probe_device+0x11c/0x190
>   driver_probe_device+0x44/0xf8
>   __driver_attach+0xc4/0x1b8
>   bus_for_each_dev+0x78/0xd0
>   driver_attach+0x2c/0x38
>   bus_add_driver+0x150/0x240
>   driver_register+0x6c/0x128
>   __platform_driver_register+0x30/0x40
>   xgene_pmu_driver_init+0x24/0x30
>   do_one_initcall+0x50/0x248
>   kernel_init_freeable+0x284/0x328
>   kernel_init+0x2c/0x140
>   ret_from_fork+0x10/0x20
>  kobject_add_internal failed for mc0 with -EEXIST, don't try to register things with the same name in the same
>
> This patch fixes it by moving edac_init() into acpi_ghes_init() and ahead of
> platform_driver_register().
>
> Fixes: dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in apci_init()")
> Signed-off-by: Jia He <justin.he@arm.com>
> Cc: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/acpi/apei/ghes.c   | 1 +
>  drivers/edac/edac_module.c | 3 +--
>  include/linux/edac.h       | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d91ad378c00d..1127dfffeeb0 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1462,6 +1462,7 @@ void __init acpi_ghes_init(void)
>         int rc;
>
>         sdei_init();
> +       edac_init();
>
>         if (acpi_disabled)
>                 return;
> diff --git a/drivers/edac/edac_module.c b/drivers/edac/edac_module.c
> index 32a931d0cb71..34ada2064b36 100644
> --- a/drivers/edac/edac_module.c
> +++ b/drivers/edac/edac_module.c
> @@ -99,7 +99,7 @@ EXPORT_SYMBOL_GPL(edac_get_sysfs_subsys);
>   * edac_init
>   *      module initialization entry point
>   */
> -static int __init edac_init(void)
> +int __init edac_init(void)
>  {
>         int err = 0;
>
> @@ -160,7 +160,6 @@ static void __exit edac_exit(void)
>  /*
>   * Inform the kernel of our entry and exit points
>   */
> -subsys_initcall(edac_init);

This effectively makes EDAC depend on GHES which may not be always valid AFAICS.

>  module_exit(edac_exit);
>
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index e730b3468719..104b22c2c177 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -30,6 +30,7 @@ struct device;
>
>  extern int edac_op_state;
>
> +int __init edac_init(void);
>  struct bus_type *edac_get_sysfs_subsys(void);
>
>  static inline void opstate_init(void)
> --
