Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAD026A51C
	for <lists+linux-edac@lfdr.de>; Tue, 15 Sep 2020 14:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIOM1g (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Sep 2020 08:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgIOMZ5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Sep 2020 08:25:57 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A879C06174A;
        Tue, 15 Sep 2020 05:25:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e420013f677fd615296f5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:13f6:77fd:6152:96f5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 768FE1EC0269;
        Tue, 15 Sep 2020 14:25:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600172754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=K5PRCiL1uVP1UOlHVT3dH33iRtILlU8JGDHIerxnDaI=;
        b=NyncvIYU6/XCVB9C4FONbMXPFXHZcHv/vM/vY5fUw9a7iS91r0otUIJUhVBeixUWHvJe9b
        IaKMAe+5isfeqTFpQdbXhDgdQk/BlaRw6NPelpCPSwAaR4LSiQ8vy6aQ3zJCIn2FG73rI0
        QDzM4XVHrH0h0OLHw5wy865LCc8B7sk=
Date:   Tue, 15 Sep 2020 14:25:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Linuxarm <linuxarm@huawei.com>, Robert Richter <rric@kernel.org>
Subject: Re: [PATCH 1/1] EDAC/ghes: Fix for NULL pointer dereference in
 ghes_edac_register()
Message-ID: <20200915122511.GG14436@zn.tnic>
References: <20200825130108.2132-1-shiju.jose@huawei.com>
 <20200826085229.GB22390@zn.tnic>
 <cd947c4ec6044521a92e2cc39eae5406@huawei.com>
 <20200911164817.GA19320@zn.tnic>
 <66270fbc43fc4bd686b638586710d9dd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66270fbc43fc4bd686b638586710d9dd@huawei.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 15, 2020 at 10:54:33AM +0000, Shiju Jose wrote:
> I debug with adding more logs. I found that in our platform
> hw->num_dimms was 32 when called ghes_edac_register() second time when
> probe a new ghes instance, the check !(hw->num_dimms % 16) in the
> enumerate_dimms() passed and it allocated memory for hw->dimms. Thus
> it did not fail with NULL pointer dereference in ghes_edac_register().

Oh, what a lucky coincidence ;-\

> With the your new fix hw->num_dimms reset to 0.

Thanks for testing and digging out what is happening on your machine. So
I've queued them here:

https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-for-next

Will send them to Linus on the weekend so that they make it into 5.9.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
