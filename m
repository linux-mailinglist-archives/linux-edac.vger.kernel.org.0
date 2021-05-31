Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFFE395808
	for <lists+linux-edac@lfdr.de>; Mon, 31 May 2021 11:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhEaJZA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 May 2021 05:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhEaJY7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 May 2021 05:24:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296A0C061574;
        Mon, 31 May 2021 02:23:20 -0700 (PDT)
Received: from zn.tnic (p200300ec2f080f0029ca4f7a5f3cda43.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:f00:29ca:4f7a:5f3c:da43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ACB711EC04E4;
        Mon, 31 May 2021 11:23:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622452998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kq3vQ72vcCrVSFjmJnb+obsvykqJLYPd+KsL6bN5T9Q=;
        b=GeLLiL/+vgZYidrke6+K46iC4EZyweZltDLCIMSmJFS66LlcTO0zLmmG3xlsWwjKz233lC
        UHhQWw2veNEGSaVpYolQZ188KglCHXNfW4028mkF4MxFxyLOxgXfw3bcShmMBoFKUnMv6z
        FTUA8MSyNey5xVk/3ikH6ESsHcZUKsA=
Date:   Mon, 31 May 2021 11:23:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Johannes Thumshirn <morbidrsa@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Doug Thompson <dougthompson@xmission.com>,
        Dave Jiang <djiang@mvista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] EDAC, mpc85xx: Fix error return code in two functions
Message-ID: <YLSq/6iN8Aw3j8R4@zn.tnic>
References: <20210528032637.9231-1-thunder.leizhen@huawei.com>
 <YLSg/8REPQoX8HL7@zn.tnic>
 <daec460d-754c-d904-f81c-91bdfaccefad@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <daec460d-754c-d904-f81c-91bdfaccefad@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 31, 2021 at 05:15:54PM +0800, Leizhen (ThunderTown) wrote:
> So how about change to -ENODEV?

Yah, better.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
