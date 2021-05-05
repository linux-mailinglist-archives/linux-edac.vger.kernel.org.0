Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B14374B8E
	for <lists+linux-edac@lfdr.de>; Thu,  6 May 2021 00:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhEEW4B (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 May 2021 18:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhEEW4B (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 May 2021 18:56:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D7EC061574;
        Wed,  5 May 2021 15:55:03 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b070001dc1f090e11b831.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:700:1dc:1f09:e11:b831])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 86BE41EC03E4;
        Thu,  6 May 2021 00:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620255302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cnqon5MvgowBb3EWUqNjyFY3UgIvU3IW4qe8TPE+cc8=;
        b=ErEhNePtA2sfWh3ZRAqR3CAWQcI6kYG52j5fUR0i226meWFvvL0zURcD7pnMa3a1VZLlPE
        /E03fofwdn2Hfw6UTi9eB/dS4JK5duCIF2YoZpMoAMZstzUrG/bXN+8kDGt3WGv09LqVhq
        FA4axolUov5+yb5fC8FUEUacrkedaUQ=
Date:   Thu, 6 May 2021 00:55:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     wangglei <wangglei@gmail.com>,
        "Lei Wang (DPLAT)" <Wang.Lei@microsoft.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hang Li <hangl@microsoft.com>,
        Brandon Waller <bwaller@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH] EDAC: update edac printk wrappers to use
 printk_ratelimited.
Message-ID: <YJMiRF8D3EG28d2V@zn.tnic>
References: <20210505173027.78428-1-wangglei@gmail.com>
 <YJLdZCcsgWG6TrKz@zn.tnic>
 <SJ0PR21MB199984A8B47FBEECEC5D11CE90599@SJ0PR21MB1999.namprd21.prod.outlook.com>
 <YJL1vU6HNBWPKy8g@zn.tnic>
 <20210505202357.GC4967@sequoia>
 <YJMIbB31oEDaXm0C@zn.tnic>
 <20210505214846.GE4967@sequoia>
 <YJMWBBBlQ6TwFad9@zn.tnic>
 <20210505221605.GF4967@sequoia>
 <20210505224357.GG4967@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210505224357.GG4967@sequoia>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 05, 2021 at 05:43:57PM -0500, Tyler Hicks wrote:
> This is x86-specific 

That's because it is used by x86 currently. It shouldn't be hard to use
it on another arch though as the machinery is pretty generic.

> and not applicable in our situation.

What is your situation? ARM?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
