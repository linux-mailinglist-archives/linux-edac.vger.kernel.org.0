Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBD841650F
	for <lists+linux-edac@lfdr.de>; Thu, 23 Sep 2021 20:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242708AbhIWSQc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Sep 2021 14:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242889AbhIWSQX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Sep 2021 14:16:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E71C061788;
        Thu, 23 Sep 2021 11:14:21 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d6800010999bf90259edb.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6800:109:99bf:9025:9edb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 97FE21EC056A;
        Thu, 23 Sep 2021 20:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632420855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=R7oLhQbzsvsWj62mAcUhSOp2J72g6MKSMJkSIUrXPks=;
        b=ZPDOHZfv/mpV4aX4K9LrNeUYhNAzsUrOnoVZwtAo9CwQ5VnyKDbcpsONX+MUqJpEm7TKqp
        YyypdTVA8mDa7fOIuQfrLspmdHOYYyn2eQsv+Z1dwc8u+NrjFJib+CEytAaPOCUeHF0Qp1
        CFjyWJep9rSIrqhS0wKp04lWYkby/l8=
Date:   Thu, 23 Sep 2021 20:14:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Joshi, Mukul" <Mukul.Joshi@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCHv3 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Message-ID: <YUzD9wxtV411S8TC@zn.tnic>
References: <20210913021311.12896-2-mukul.joshi@amd.com>
 <20210922193620.15925-1-mukul.joshi@amd.com>
 <YUyPM7VfYFG/PJmu@yaz-ubuntu>
 <DM4PR12MB52639349DF98DB01A3B155EFEEA39@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YUy4CdcUWJzQfM4N@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUy4CdcUWJzQfM4N@yaz-ubuntu>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 23, 2021 at 05:23:21PM +0000, Yazen Ghannam wrote:
> Shouldn't the error still be reported to EDAC for decoding and counting? I
> think users want this.

You know what happens with users getting ECCs reported, right? They
think immediately their hw is going bad and start wanting to replace
it...

So what does actually tell you if you were a simple user and you had 5
correctable errors in the GPU VRAM?

All you wanna do is play, I'd say.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
