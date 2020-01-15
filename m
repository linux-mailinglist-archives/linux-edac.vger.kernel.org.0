Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD6413CF48
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2020 22:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgAOVi7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Jan 2020 16:38:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48844 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgAOVi6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Jan 2020 16:38:58 -0500
Received: from zn.tnic (p200300EC2F0C7700F109D32638BACFBD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7700:f109:d326:38ba:cfbd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 36EDB1EC01AD;
        Wed, 15 Jan 2020 22:38:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579124337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LBMtE/WMICvJacbss6a6c+JL3sMqakCf7ajkvPVSGoo=;
        b=JSk1F/Vcfrva9TnlLBIVasySWnMIdW/M+wVf3lz4G4ILhs9oEKcj0SIZ+hCC5rKyENug+m
        ViBqPkNwMGLa10+B0A5/XUJxrMcu/PoyEVuUSbvM284vucuDOru9eBDD7mtgubw5OV09UP
        qo71qnAvNtpRVfXCaiCXtWV2V7DNV5Y=
Date:   Wed, 15 Jan 2020 22:38:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shiping Ji <shiping.linux@gmail.com>, sashal@kernel.org
Cc:     James Morse <james.morse@arm.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        hangl@microsoft.com, Lei Wang <lewan@microsoft.com>,
        shji@microsoft.com, ruizhao@microsoft.com,
        Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>, ray.jui@broadcom.com,
        wangglei@gmail.com
Subject: Re: [PATCH v9 2/2] EDAC: add EDAC driver for DMC520
Message-ID: <20200115213848.GO20975@zn.tnic>
References: <6a462190-0af2-094a-daa8-f480d54a1fbf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a462190-0af2-094a-daa8-f480d54a1fbf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 15, 2020 at 06:32:33AM -0800, Shiping Ji wrote:
> New driver supports error detection and correction on the devices with ARM
> DMC-520 memory controller.
> 
> Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> Reviewed-by: James Morse <james.morse@arm.com>

This mail still has your From: because I guess you pasted the patch in
the mail.

But, if you look at what I wrote here:

https://lkml.kernel.org/r/20200107195606.GM29542@zn.tnic

you'll see the

From: Lei Wang <leiwang_git@outlook.com>

which is the last From: in the mail and that is taken by git as the
author of the patch.

However, if I apply this mail of yours, it will make you the
author. Because in git there can be only one author per patch
and other authors can be additionally accredited with the
Co-developed-by: tag from the same doc I was pointing at before:
Documentation/process/submitting-patches.rst

Looking at this driver, however, you have supplied three authors. And I
think you guys need to discuss it amongst yourselves who is going to be
the author of this driver in the git history.

If there are more questions, I'm pretty sure Sasha would be glad to
explain to you how the whole authorship thing works and what the
implications are.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
