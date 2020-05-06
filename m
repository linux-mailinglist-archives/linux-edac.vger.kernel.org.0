Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD11C714F
	for <lists+linux-edac@lfdr.de>; Wed,  6 May 2020 15:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgEFNEP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 May 2020 09:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728045AbgEFNEP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 May 2020 09:04:15 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B5CC061A0F
        for <linux-edac@vger.kernel.org>; Wed,  6 May 2020 06:04:15 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g19so1250517otk.5
        for <linux-edac@vger.kernel.org>; Wed, 06 May 2020 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ogodDjzd8PHPpuPSoClvKVCajMEhNTrcVTpVmFQpWzM=;
        b=Tl3aEsHTeXmVOIOXfFBxu2EHTvP5G7TNzwOhxJDhxf6QAtBD2tg8HGDAs/0bwhSBA8
         80Gfe8lXDCHtwsV86EHjdJoCeFPFUUg0qIPWxCV1CoCZPv7M8qal84X7Bh2qsGTSQnt3
         2tSP1UEsVB4FOkkify1/M5F3heIEnaTeof5Fq+14vO2tMehJeNmw22oTf4u3/cJY+i6X
         yniIr12DN+lw/AdqouGEhyPzD/TYKVMIzJlBM5Q6D28qPzU43mJ+kDgpAxJ/dYnUyfiu
         hEwrNFUj1xrX4YuOOsfPNIECP/GAhnmcT0SLshniTY55nHBJtdAycXSsBQtlnXGUJKgD
         0HZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ogodDjzd8PHPpuPSoClvKVCajMEhNTrcVTpVmFQpWzM=;
        b=VVSv2VzGwSlxA+Mi9I1f7MT+jbhgaQ6RfdvucFc1KTbj79lV9JBLgIdewEFKSECxv5
         PxjCju8N+uARxUTjuK6SdiDebVArZATJtDYX3BG8Q5jVgIBIP1V3vYyg07Z6DkYLeXIX
         6pBX9oUS46CkzyqkHPNnIEphocgMe2ZtfBPd0oMX1BEW1mypDjAudXBO+ZWXHjsPWGIu
         xh8UNfNlNn9rMLXij5vmq3NmfjlHbeofK14EtL5BEgyZGkQwgo08bP0yFbioff5kU1w7
         bdTZSTlHW/FY0IUmQWVBtIVjfl96DO1YasZnGmaRKIF2a41Y6Itj3FmnQaPFze3i0IWb
         M9PA==
X-Gm-Message-State: AGi0Puazsc1mALrz9r27gUgqOH+BUk8ZOWs2qCNUEKBqKi00Sunmm7jS
        oMBAYpEOkCpuy8k0WICmN4EKg5UTnMHmCcQSpH4=
X-Google-Smtp-Source: APiQypLkOPv9XvJcixw5/HEBAopvEPWoj0V5KlF0LYPlod4X5nZXk3a/Sl+gjBNkBBQdUcJSFy6eET93fHz1kss/xiA=
X-Received: by 2002:a9d:355:: with SMTP id 79mr5935086otv.275.1588770254594;
 Wed, 06 May 2020 06:04:14 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5Lq/5LiA?= <teroincn@gmail.com>
Date:   Wed, 6 May 2020 21:04:02 +0800
Message-ID: <CANTwqXA8_cdV9TRqRrLjTngoiaABji=XA7AfcdvV_D1GQYRYYA@mail.gmail.com>
Subject: [BUG] is there a memleak in edac_device_register_sysfs_main_kobj
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com
Cc:     linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi all,
I notice that most of the usage of kobject_init_and_add in drivers are
wrong, and now some drivers code has maken it right
please see commit dfb5394f804e (https://lkml.org/lkml/2020/4/11/282)
function edac_device_register_sysfs_main_kobj() in
drivers/edac/edac_device_sysfs.c may
have the similar issue and leak kobject.
if kobject_init_and_add() failed, the edac_dev->kobj may already
increased it's refcnt and allocated memory to store it's name,
so a kobject_put is need before return.

int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
{
...

/* register */
err = kobject_init_and_add(&edac_dev->kobj,
&ktype_device_ctrl,&edac_subsys->dev_root->kobj,  "%s",
edac_dev->name);
if (err) {
    edac_dbg(1, "Failed to register '.../edac/%s'\n",   edac_dev->name);
    goto err_kobj_reg;
}
kobject_uevent(&edac_dev->kobj, KOBJ_ADD);

/* At this point, to 'free' the control struct,
* edac_device_unregister_sysfs_main_kobj() must be used
*/

edac_dbg(4, "Registered '.../edac/%s' kobject\n", edac_dev->name);

return 0;

/* Error exit stack */
err_kobj_reg:
      module_put(edac_dev->owner);

err_out:
      return err;
}

Best regards,
Lin Yi
