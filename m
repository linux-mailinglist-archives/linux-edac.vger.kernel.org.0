Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462EC397B4E
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jun 2021 22:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbhFAUht (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Jun 2021 16:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhFAUhs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 1 Jun 2021 16:37:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61FBC061574;
        Tue,  1 Jun 2021 13:36:06 -0700 (PDT)
Received: from zn.tnic (p200300ec2f111d0004f27110e64a0196.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1d00:4f2:7110:e64a:196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 66A0C1EC04F3;
        Tue,  1 Jun 2021 22:36:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622579765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/JK3lYtJiNtQPSL8Cztpwpa5zs1zRzYriYt8JjW4ptM=;
        b=YuceAqid1U9cijNCIyYyO/PfGeS/A8LFM+6xh+MZUgAQfHEh82SKZL9PeFSaIb31+GGxMr
        MkJj3Wa4KGRe4xsBC3PtC93uHaDBRMPX1juSnuhBitjSqh7VKh7lQ3k2uUfHE/VMZ22RU3
        XTuODbBi8F3fjhFbAUua5jeEf7ChIfg=
Date:   Tue, 1 Jun 2021 22:35:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Christopher BeSerra <beserra@amazon.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] x86/mce: Provide sysfs interface to show CMCI storm
 state
Message-ID: <YLaaLws+4FEHOqQs@zn.tnic>
References: <20210601200505.966849-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210601200505.966849-1-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 01, 2021 at 01:05:05PM -0700, Tony Luck wrote:
> Scripts that process error logs can do better if they know whether
> Linux is executing in CMCI storm mode (only polling and reporting
> some errors instead of trying to report them all). While it is possible
> to parse the console log for:
> 
> 	CMCI storm detected: switching to poll mode
> 	CMCI storm subsided: switching to interrupt mode
> 
> messages, that is error prone.
> 
> Add a new file to sysfs to report the current storm count.
> 
> Reported-by: Christopher BeSerra <beserra@amazon.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> RFC questions:
> 1) Is there a better way to do this?

Probably.

But I'm unclear as to what this whole use case is. The very first
"Scripts that process error logs" already sounds like a bad idea - I'd
expect userspace consumers to open the trace_mce_record() and get the
MCE records from there. And in that case CMCI storm shouldn't matter...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
