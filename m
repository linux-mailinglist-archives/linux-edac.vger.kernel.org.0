Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CAD525184
	for <lists+linux-edac@lfdr.de>; Thu, 12 May 2022 17:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355761AbiELPqg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 May 2022 11:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355527AbiELPqf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 12 May 2022 11:46:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05F34924B;
        Thu, 12 May 2022 08:46:34 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0DA221EC064A;
        Thu, 12 May 2022 17:46:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652370389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5A+AEM/knJdEP/jzf7EnaLn5j0IOaFFZE+d42d3tpDw=;
        b=jtkqKTBnGNw4G44BNIxcP7o9xZ0luxxsEL9u0jRWMnIwt6P/J3V32oBf5nbeNSbovpBj/9
        MwnHf+V8d0W848NToWvaLvDcAsU9wr/rg9y87MCauBal+mH6udwM6Ij6uWY6goFCSKSQ/9
        QPlDc2kq4Br5L9IROjDEAiAlRgAEgZs=
Date:   Thu, 12 May 2022 17:46:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Doug Thompson <dougthompson@xmission.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC: Fix some refcount leaks
Message-ID: <Yn0r2Dd7Pgr0DrMd@zn.tnic>
References: <20220512075906.21915-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220512075906.21915-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 12, 2022 at 11:59:06AM +0400, Miaoqian Lin wrote:
> kobject_init_and_add() takes reference even when it fails.
> According to the doc of kobject_init_and_add()
> 
>    If this function returns an error, kobject_put() must be called to
>    properly clean up the memory associated with the object.
> 
> Fix this by calling kobject_put() when kobject_init_and_add() fails.

$ git grep -w kobject_init_and_add drivers/edac/
drivers/edac/edac_device_sysfs.c:259:   err = kobject_init_and_add(&edac_dev->kobj, &ktype_device_ctrl,
drivers/edac/edac_device_sysfs.c:538:   err = kobject_init_and_add(&block->kobj, &ktype_block_ctrl,
drivers/edac/edac_device_sysfs.c:637:   err = kobject_init_and_add(&instance->kobj, &ktype_instance_ctrl,
drivers/edac/edac_pci_sysfs.c:175:      err = kobject_init_and_add(&pci->kobj, &ktype_pci_instance,
drivers/edac/edac_pci_sysfs.c:372:      err = kobject_init_and_add(edac_pci_top_main_kobj,

Wanna audit them all, make sure they all put the kobject properly and do
a single patch fixing those which need fixing?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
