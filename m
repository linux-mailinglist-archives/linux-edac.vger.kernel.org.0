Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33859F4FBD
	for <lists+linux-edac@lfdr.de>; Fri,  8 Nov 2019 16:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfKHPcO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 8 Nov 2019 10:32:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59148 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfKHPcO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 8 Nov 2019 10:32:14 -0500
Received: from zn.tnic (p200300EC2F0D3700C146D27A9F02E8E8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3700:c146:d27a:9f02:e8e8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BEC711EC0D03;
        Fri,  8 Nov 2019 16:32:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573227128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Wy2nApVSv0Jbeun95X8bJdRkeSPWfkwqp16W5VjvXSQ=;
        b=oXvp/OSEVBnqkFXh3X/bJm8gHHcJmwurn9LAgHETk+DvQI2DU/yKp04mOAoXwTlZLhXml3
        xZL3iV6jYVCunLJB4cfTXT5MrVlGTADTagu7TIPIZyJwsIokQHoP7NMt4aQg0JYXNNMMNW
        jZbHiNve4Z2jYsOE/PLgU63y6pX6tio=
Date:   Fri, 8 Nov 2019 16:32:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] EDAC, ghes: Fix locking and memory barrier issues
Message-ID: <20191108153203.GE4503@zn.tnic>
References: <20191105200732.3053-1-rrichter@marvell.com>
 <20191105201115.v2pe6k6g2brx5itv@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191105201115.v2pe6k6g2brx5itv@rric.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Nov 05, 2019 at 08:11:22PM +0000, Robert Richter wrote:
> On 05.11.19 20:07:51, Robert Richter wrote:
> > The ghes registration and refcount is broken in several ways:
> > 
> >  * ghes_edac_register() returns with success for a 2nd instance even
> >    if a first instance is still running. This is not correct as the
> >    first instance may fail later. A subsequent registration may not
> >    finish before the first. Parallel registrations must be avoided.
> > 
> >  * The refcount was increased even if a registration failed. This
> >    leads to stale counters preventing the device from being released.
> > 
> >  * The ghes refcount may not be decremented properly on
> >    unregistration. Always decrement the refcount once
> >    ghes_edac_unregister() is called to keep the refcount sane.
> > 
> >  * The ghes_pvt pointer is handed to the irq handler before
> >    registration finished.
> > 
> >  * The mci structure could be freed while the irq handler is running.
> > 
> > Fix this by adding a mutex to ghes_edac_register(). This mutex
> > serializes instances to register and unregister. The refcount is only
> > increased if the registration succeeded. This makes sure the refcount
> > is in a consistent state after registering or unregistering a device.
> > Note: A spinlock cannot be used here as the code section may sleep.
> > 
> > The ghes_pvt is protected by ghes_lock now. This ensures the pointer
> > is not updated before registration was finished or while the irq
> > handler is running. It is unset before unregistering the device
> > including necessary (implicit) memory barriers making the changes
> > visible to other cpus. Thus, the device can not be used anymore by an
> > interrupt.
> > 
> > Also, rename ghes_init to ghes_refcount for better readability and
> > switch to refcount API.
> > 
> > A refcount is needed. There can be multiple GHES structures being
> > defined (see ACPI 6.3 specification, 18.3.2.7 Generic Hardware Error
> > Source, "Some platforms may describe multiple Generic Hardware Error
> > Source structures with different notification types, ...").
> > 
> > Another approach to use the mci's device refcount (get_device()) and
> > have a release function does not work here. A release function will be
> > called only for device_release() with the last put_device() call. The
> > device must be deleted *before* that with device_del(). This is only
> > possible by maintaining an own refcount.
> > 
> > Fixes: 0fe5f281f749 ("EDAC, ghes: Model a single, logical memory controller")
> > Fixes: 1e72e673b9d1 ("EDAC/ghes: Fix Use after free in ghes_edac remove path")
> > Co-developed-by: James Morse <james.morse@arm.com>
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Co-developed-by: Borislav Petkov <bp@suse.de>
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Signed-off-by: Robert Richter <rrichter@marvell.com>
> 
> I hope this SOB chain is correct now.

Yeah.

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
