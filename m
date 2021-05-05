Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942C33749D3
	for <lists+linux-edac@lfdr.de>; Wed,  5 May 2021 23:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhEEVFr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 May 2021 17:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhEEVFq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 May 2021 17:05:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC6CC061574;
        Wed,  5 May 2021 14:04:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b0700e564ac8d2a0c80af.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:700:e564:ac8d:2a0c:80af])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB98D1EC03E4;
        Wed,  5 May 2021 23:04:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620248687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sFKStqMTp87LYvLhL4y5JagHNHCcA1psQUaO5LXStq4=;
        b=FB6zP19Q4DqHwlMSA3f1aaFAjjOmc5byZ7ZuIZYxXNvDN0eJSvDtM/To7ZoK8lwiy/8Nx7
        7FBP5PK1YJkwJTBQG7X22HfPil3rP1/n6VUe/2TJgGUimIqK+IwqhLG0TJOOzM+Bybo9ay
        oycO7L7VuQ4ncXbIq0RNiHnGq6MtMmY=
Date:   Wed, 5 May 2021 23:04:44 +0200
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
Message-ID: <YJMIbB31oEDaXm0C@zn.tnic>
References: <20210505173027.78428-1-wangglei@gmail.com>
 <YJLdZCcsgWG6TrKz@zn.tnic>
 <SJ0PR21MB199984A8B47FBEECEC5D11CE90599@SJ0PR21MB1999.namprd21.prod.outlook.com>
 <YJL1vU6HNBWPKy8g@zn.tnic>
 <20210505202357.GC4967@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210505202357.GC4967@sequoia>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 05, 2021 at 03:23:57PM -0500, Tyler Hicks wrote:
>  Would it be any more acceptable to add an
> edac_mc_printk_ratelimited() macro, which uses printk_ratelimited(),
> and then call that new macro from edac_ce_error()?

You guys are way off here: the intent of EDAC drivers is to accurately
report errors for purposes of counting them and doing analysis on
that collected data as to whether components are going wrong - not to
ratelimit them as some nuisance output.

With breaking the EDAC reporting, you're barking up the wrong tree - if
you don't want to see those errors, do not load the drivers. It is that
simple.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
