Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DC3245644
	for <lists+linux-edac@lfdr.de>; Sun, 16 Aug 2020 09:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgHPHF3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 16 Aug 2020 03:05:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55498 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgHPHF3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 16 Aug 2020 03:05:29 -0400
Received: from zn.tnic (p200300ec2f26be000c615dc96c916289.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:c61:5dc9:6c91:6289])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 252A91EC0330;
        Sun, 16 Aug 2020 09:05:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597561528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=a5+PcjCA3qZozEe72H9WLoOsy1HJx/M117AvR4P2wVw=;
        b=oEXpI345zgYrHfGCXq5gZ2gRt9N4taPbunLdklxD2SqanfOeQfIQ1YVJ6mOGlXT2+xpH8m
        T/Fbs4NeWMAo5rqPUqTMdKTmetEyclOpZ3OmSNNbB7ASENFgvR6+CJ6imI4t5rOBFPSM6q
        WY0hq3zqe1wITfT8jVQgB8gKfd73YcU=
Date:   Sun, 16 Aug 2020 09:06:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Cc:     andrianov <andrianov@ispras.ru>, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org
Subject: Re: Regarding bug in drivers/edac/x38_edac.c
Message-ID: <20200816070621.GB21914@zn.tnic>
References: <CAD=jOEZ9t4ztYtPKL9B1KA9=f4mniu6-bF_1-JWoPKJTE0kiaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=jOEZ9t4ztYtPKL9B1KA9=f4mniu6-bF_1-JWoPKJTE0kiaw@mail.gmail.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Aug 16, 2020 at 12:05:57PM +0530, Madhuparna Bhowmik wrote:
> 2. Even if we ignore the 1st point above and probe is called after init
> finishes,

AFAIR and if you don't have any async probing (which I don't believe for
this driver or for any other EDAC driver), the ->probe() function gets
called during pci_register_driver(). From the docs:

Documentation/PCI/pci.rst:

"pci_register_driver() call
==========================

...

Once added, the driver probe routine will be invoked for any unclaimed
PCI devices listed in its (newly updated) pci_ids list."

You could verify that by adding some debugging printks to a driver's
probe function.

I believe it ends up somewhere in the driver core, looks like in

really_probe():

        if (dev->bus->probe) {
                ret = dev->bus->probe(dev);

in drivers/base/dd.c but I could be mistaken.

> In general, calling the probe function from init itself is a bit strange.

Yes, that is ugly - the init function tries what the probe function has
already tried, again.

But I don't think either 1. or 2. of yours happens - it is actually
clumsy but the mci_pdev is simply a check to verify whether the
->probe() succeeded and try it again.

Now, if you have that hardware, you could verify all that but I think
the reality is, I don't think anyone uses that hardware anymore and we
will remove them at some point in the future so you might wanna look at
some other drivers which *actually* are still in use.

:-)

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
