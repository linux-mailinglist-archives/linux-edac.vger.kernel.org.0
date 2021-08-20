Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E433F3005
	for <lists+linux-edac@lfdr.de>; Fri, 20 Aug 2021 17:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbhHTPsZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Aug 2021 11:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238154AbhHTPsZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 20 Aug 2021 11:48:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54995C061575;
        Fri, 20 Aug 2021 08:47:47 -0700 (PDT)
Received: from zn.tnic (p200300ec2f107b0070f9113f083a3500.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:7b00:70f9:113f:83a:3500])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D475E1EC05BC;
        Fri, 20 Aug 2021 17:47:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629474461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=M//f32sE6c8MwQqCGHF5yibrp9di7YnjAbZUBDXiVwk=;
        b=SyPqG4Wf5yxs1htAFXtH3AZEGcumkKA2T0IgUiemCSrvIYca4ofDz5/HIuvQ20lFw2ukUo
        s3Eoh9p+YbV0J2B0w7kFyNnat4nEjWge0jUqZBK2nORvswK2DPcQlKk1O44ARVYfsmbYnX
        vYFkLEEj+P47TEICxG00r8rNLHoRamk=
Date:   Fri, 20 Aug 2021 17:48:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sumanth Kamatala <skamatala@juniper.net>
Subject: Re: [PATCH] x86/mce/dev-mcelog: Call mce_register_decode_chain()
 much earlier
Message-ID: <YR/Oxark0bhLlona@zn.tnic>
References: <20210819224452.1619400-1-tony.luck@intel.com>
 <YR+f/fdGIxWcLTP2@zn.tnic>
 <20210820144314.GA1622759@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820144314.GA1622759@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 20, 2021 at 07:43:14AM -0700, Luck, Tony wrote:
> How can the kernel tell that all consumers have registered? Is there
> some new kernel crystal ball functionality that can predict that an
> EDAC driver module is going to be loaded at some point in the future
> when user space is up and running :-)

The crystal ball is called mcheck_late_init(). There's even:

        /*
         * Flush out everything that has been logged during early boot, now that
         * everything has been initialized (workqueues, decoders, ...).
         */
        mce_schedule_work();

in there. That thing is late_initcall() and by that time mcelog should
have been registered. And I wonder why isn't that working as expected...

> I think the best we could do would be to set a timer for some point
> far enough out (one minute?, two minutes?) to give a chance for
> modules to load.

Forget modules - only the built-in stuff. We cannot be waiting
indefinitely until someone loads mcelog for decoding.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
