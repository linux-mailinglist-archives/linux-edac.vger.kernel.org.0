Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A70A3FE0ED
	for <lists+linux-edac@lfdr.de>; Wed,  1 Sep 2021 19:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbhIARJg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Sep 2021 13:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344682AbhIARJf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 1 Sep 2021 13:09:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4BEC061575
        for <linux-edac@vger.kernel.org>; Wed,  1 Sep 2021 10:08:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m4so86685pll.0
        for <linux-edac@vger.kernel.org>; Wed, 01 Sep 2021 10:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v2XLK1vGEzZIOUNqlY1IqHLpN0ROAFUqn3UGHO+I7VY=;
        b=XBA1O65n1gbN6cPrV9+41k+LTAxZPhtbxDBy0Fw52JYq0fkfVH/ULgkMybhenv1Fbe
         OWmT5fPGUNXNOFCKPxdPryVD2wWXaOgXTniMM6GEVMKWbTZwhCha83BC0q2tidTZeihN
         bLRdKI98ux6DRbs/QfKl/GhuepsqeURaJd2i8o4V0OUvmrYsHlqRBuhMv6cNansgfYsG
         uBfoKqGidMO4wM8lRXOXNx6aRteVYMLbg1KAxKcXaTYyiR4GIMvHCFxC+EOY9eH7dbql
         wMf9kC00jcAZ1mFjd87/VYI+7cJGB6el9GIO7jcXsowkHZoaxtdUByN/9IEilenErD3R
         RWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v2XLK1vGEzZIOUNqlY1IqHLpN0ROAFUqn3UGHO+I7VY=;
        b=hUakcHRCBcG5mNMsu3ZnrO42uWcl0HVLzLbtT/G+ZhetZxm0H75lMSiBN0qMpnALwR
         VurKYkLKHy0j9ncSbCEFCenF9Ftb6lqvB1klgrTJooBKsVqMBgAGIA9eQAUgpQWowoYq
         m0ZSSQ8WC4Y9SIkiWJXiLNH70NL48kJXe6xZ66BzS4GoWL/+i/k4hZ2CRgfEMlArqV0p
         +bO3wtCRYQu1QO/Rudtt9pzdxQVUwKy2zcQ5ZCj+hB74MAHBxd576D4kYoiDzUbY8Sfw
         2xTViqKvk340vSu2gqtRE5s6kIRwyYReYI2fC+XB0ArD/fmh2+h0QYVvFn44H+gKO2MX
         1h9w==
X-Gm-Message-State: AOAM532jBwc/6DnBt/UbywbFlXq/W7RY/U+vnqIaXCscUd/yDcgsJD+5
        70GdCNL1jSLCf51GfR7wXUVm2M724ljl9mvKBHFg+MomEPPrHw==
X-Google-Smtp-Source: ABdhPJzFS2Yz4XqYRzwEigrdW654194TKs8JtrS0A1uDukRefQWLrvwzu4krQD/ftL/oMNqO0O9vxaK3fbV1sRX0sOs=
X-Received: by 2002:a17:90a:1991:: with SMTP id 17mr375005pji.149.1630516117376;
 Wed, 01 Sep 2021 10:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <x49o8a3pu5i.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49o8a3pu5i.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 1 Sep 2021 10:08:26 -0700
Message-ID: <CAPcyv4hbwLjE599cKXKCOST1LF1NUhKv-YvNnU5jcV_xZbAzxg@mail.gmail.com>
Subject: Re: [patch, v2] x86/pat: pass valid address to sanitize_phys()
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Aug 11, 2021 at 2:06 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> The end address passed to memtype_reserve() is handed directly to
> sanitize_phys().  However, end is exclusive and sanitize_phys() expects
> an inclusive address.  If end falls at the end of the physical address
> space, sanitize_phys() will return 0.  This can result in drivers
> failing to load, and the following warning:
>
> [    9.999440] mpt3sas version 29.100.01.00 loaded
> [    9.999817] mpt3sas_cm0: 64 BIT PCI BUS DMA ADDRESSING SUPPORTED, tota=
l mem (65413664 kB)
> [    9.999819] ------------[ cut here ]------------
> [    9.999826] WARNING: CPU: 26 PID: 749 at arch/x86/mm/pat.c:354 reserve=
_memtype+0x262/0x450
> [    9.999828] reserve_memtype failed: [mem 0x3ffffff00000-0xffffffffffff=
ffff], req uncached-minus
> [    9.999828] Modules linked in: mpt3sas(+) bnxt_en(+) ahci(+) crct10dif=
_pclmul crct10dif_common nvme crc32c_intel libahci nvme_core libata raid_cl=
ass scsi_transport_sas devlink drm_panel_orientation_quirks nfit libnvdimm =
dm_mirror dm_region_hash dm_log dm_mod
> [    9.999840] CPU: 26 PID: 749 Comm: systemd-udevd Not tainted 3.10.0-10=
77.el7_7.mpt3sas_test008.x86_64 #1
> [    9.999842] Hardware name: Inspur SA5112M5/SA5112M5, BIOS 4.1.12 02/24=
/2021
> [    9.999843] Call Trace:
> [    9.999851]  [<ffffffffa497c4e4>] dump_stack+0x19/0x1b
> [    9.999857]  [<ffffffffa429bc08>] __warn+0xd8/0x100
> [    9.999859]  [<ffffffffa429bc8f>] warn_slowpath_fmt+0x5f/0x80
> [    9.999861]  [<ffffffffa427b1f2>] reserve_memtype+0x262/0x450
> [    9.999867]  [<ffffffffa4276254>] __ioremap_caller+0xf4/0x330
> [    9.999872]  [<ffffffffc04620a1>] ? mpt3sas_base_map_resources+0x151/0=
xa60 [mpt3sas]
> [    9.999875]  [<ffffffffa42764aa>] ioremap_nocache+0x1a/0x20
> [    9.999879]  [<ffffffffc04620a1>] mpt3sas_base_map_resources+0x151/0xa=
60 [mpt3sas]
> [    9.999884]  [<ffffffffa442656b>] ? __kmalloc+0x1eb/0x230
> [    9.999889]  [<ffffffffc0465555>] mpt3sas_base_attach+0xf5/0xa50 [mpt3=
sas]
> [    9.999894]  [<ffffffffc046af3c>] _scsih_probe+0x4ec/0xb00 [mpt3sas]
> [    9.999901]  [<ffffffffa45d297a>] local_pci_probe+0x4a/0xb0
> [    9.999903]  [<ffffffffa45d40c9>] pci_device_probe+0x109/0x160
> [    9.999909]  [<ffffffffa46b7225>] driver_probe_device+0xc5/0x3e0
> [    9.999910]  [<ffffffffa46b7623>] __driver_attach+0x93/0xa0
> [    9.999912]  [<ffffffffa46b7590>] ? __device_attach+0x50/0x50
> [    9.999914]  [<ffffffffa46b4dc5>] bus_for_each_dev+0x75/0xc0
> [    9.999916]  [<ffffffffa46b6b9e>] driver_attach+0x1e/0x20
> [    9.999918]  [<ffffffffa46b6640>] bus_add_driver+0x200/0x2d0
> [    9.999920]  [<ffffffffa46b7cb4>] driver_register+0x64/0xf0
> [    9.999922]  [<ffffffffa45d3905>] __pci_register_driver+0xa5/0xc0
> [    9.999924]  [<ffffffffc049b000>] ? 0xffffffffc049afff
> [    9.999928]  [<ffffffffc049b16e>] _mpt3sas_init+0x16e/0x1000 [mpt3sas]
> [    9.999933]  [<ffffffffa420210a>] do_one_initcall+0xba/0x240
> [    9.999940]  [<ffffffffa431e95a>] load_module+0x271a/0x2bb0
> [    9.999946]  [<ffffffffa45b0600>] ? ddebug_proc_write+0x100/0x100
> [    9.999948]  [<ffffffffa431eedf>] SyS_init_module+0xef/0x140
> [    9.999954]  [<ffffffffa498fed2>] system_call_fastpath+0x25/0x2a
> [    9.999955] ---[ end trace 6d6eea4438db89ef ]---
> [    9.999957] ioremap reserve_memtype failed -22
> [   10.000087] mpt3sas_cm0: unable to map adapter memory! or resource not=
 found
> [   10.000334] mpt3sas_cm0: failure at drivers/scsi/mpt3sas/mpt3sas_scsih=
.c:10597/_scsih_probe()!
>
> (Note that this warning was from an older distribution kernel, so line
> numbers and file names may not line up with the current tree.)
>
> Fix this by passing the inclusive end address to sanitize_phys().
>
> Fixes: 510ee090abc3 ("x86/mm/pat: Prepare {reserve, free}_memtype() for "=
decoy" addresses")
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
