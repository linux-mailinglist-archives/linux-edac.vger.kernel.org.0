Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31A33DCAC0
	for <lists+linux-edac@lfdr.de>; Sun,  1 Aug 2021 10:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhHAIUF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 1 Aug 2021 04:20:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59602 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhHAIUF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 1 Aug 2021 04:20:05 -0400
Received: from nazgul.tnic (unknown [109.121.183.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9368E1EC0298;
        Sun,  1 Aug 2021 10:19:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1627805992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=d0OLSPqVKgQFg7jRtyWZRmLKN9g40crpfr956IdpeB4=;
        b=YCAxe0mHHlS1aW03BT+GaJUrX15VVPAn9khHDqAfR3TbUBwviRfDf5LNqmbskWSwdt6b1I
        cnhwPdjJa06tQEg1fsdevDJ70tLz0edpjeNU0be3gORuCwfvsZ8cniFoWqj+XjuinS/0V/
        SA/Pdeyk7XFVCYCae6SXIHGDqmXb5bM=
Date:   Sun, 1 Aug 2021 10:20:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     nil Yi <teroincn@gmail.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org
Subject: Re: [BUG] drivers: edac: edac_pci_sysfs.c: memory leak in
 edac_pci_create_instance_kobj
Message-ID: <YQZZN/7ak0e/fdFx@nazgul.tnic>
References: <CANTwqXCcxMyJq8e4FM5ERJVNbPA01wCve769s6LcdYnSOnsXMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANTwqXCcxMyJq8e4FM5ERJVNbPA01wCve769s6LcdYnSOnsXMA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Aug 01, 2021 at 02:27:08PM +0800, nil Yi wrote:
> Any feedback would be appreciated, thanks :)

Yes, I guess the couple of kobject_init_and_add() calls in EDAC-land
should be fixed similar to what

17ed808ad243 ("EDAC: Fix reference count leaks")

did.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
