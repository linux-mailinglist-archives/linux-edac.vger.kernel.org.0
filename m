Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA80B40E988
	for <lists+linux-edac@lfdr.de>; Thu, 16 Sep 2021 20:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhIPSH7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Sep 2021 14:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344443AbhIPSEw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 16 Sep 2021 14:04:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4288C04309C;
        Thu, 16 Sep 2021 09:36:40 -0700 (PDT)
Received: from zn.tnic (p200300ec2f11c600e73b4cdd38695acb.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:c600:e73b:4cdd:3869:5acb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2800B1EC01B5;
        Thu, 16 Sep 2021 18:36:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631810195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+7ddXl1VhC5cKCH603B8euBD2SfYgtpwndMg074Sibw=;
        b=A8T2xHSbKQoVIReSXSD2AQRbj+IwXmxL6RwUpxF/GO3Kw/6acgURWgfdUXxp9ZWW7KYto+
        j0n5MsMz//QraO5gj2tAhx3S6VFqjPKVWFj+yQ1YD+3zf/4gkMDsQkjU0UMbwaV2kPQFcV
        WgW35aZw7a2IKslqMQJWoKRLnNMKqek=
Date:   Thu, 16 Sep 2021 18:36:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Naveen Krishna Chatradhi <nchatrad@amd.com>,
        linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v3 1/3] x86/amd_nb: Add support for northbridges on
 Aldebaran
Message-ID: <YUNyjSfTxIT7VY2H@zn.tnic>
References: <20210806074350.114614-4-nchatrad@amd.com>
 <20210823185437.94417-1-nchatrad@amd.com>
 <20210823185437.94417-2-nchatrad@amd.com>
 <YSYeo6S2OSZbBpb4@zn.tnic>
 <YS/Dsc2gWGGCWnbs@yaz-ubuntu>
 <YTEKMHqjY/IUBfgl@zn.tnic>
 <YT+TYrOZpe1IEv28@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YT+TYrOZpe1IEv28@yaz-ubuntu>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 13, 2021 at 06:07:30PM +0000, Yazen Ghannam wrote:
> I really like this idea. I've gone over the current and future code a few
> times to make sure things are okay. As far as I can tell, this idea should
> work most of the time, since the "node_id" value is mostly used to look up the
> right devices in the nb array. But there is one case so far where the "real"
> hardware node_id is needed during address translation.

Yap, I figured as much as this is kinda like the only place where you'd
care about the actual node id.

> This case is in the new code in review for Data Fabric v3.5, and it
> only applies to the GPU devices.
>
> What do you think about having a couple of helper functions to go between the
> hardware and Linux index IDs? Most cases will use "hardware -> Linux index",
> and when needed there can be a "Linux index -> hardware".

That's fine as long as it is properly documented what it does.

> I think we still need some piece of info to indicate a device is a GPU based
> on its node_id. The AMD NB code doesn't need to know, but the address
> translation code does. The AMD NB enumeration can be mostly generic. I think
> it may be enough to save an "id offset" value and also a "first special index"
> value. Then we can go back and forth between the appropriate values without
> having to allocate a bunch of unused memory or hardcoding certain values.

Well, since we're going to need this in the translation logic and that
is part of amd64_edac and there we said we'll move the family type up
into amd64_pvt so that you can have a family descriptor per node, then I
guess you're all set. :-)

> Thanks for the idea!

Sure, np.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
