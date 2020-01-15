Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F8E13CFB7
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2020 23:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgAOWFq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Jan 2020 17:05:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52918 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbgAOWFq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Jan 2020 17:05:46 -0500
Received: from zn.tnic (p200300EC2F0C7700F109D32638BACFBD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7700:f109:d326:38ba:cfbd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E3AA1EC0CD0;
        Wed, 15 Jan 2020 23:05:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579125945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MmGvXr5GRjkQZp4Iw4Ch9p182qR2k7SqZ2G/xLDXwBo=;
        b=oq0/uXf2idgYdzfGlQ3KEfTttmSUsgg70GJikYO+uemQKJfXRYhoOnWVeByujf9qGwlCAZ
        tgwguH61/ogMoYgF2IRzjb6jASPEzF9AsWhaST7AtyNepRInweniwC3oM/xnISYBnNnWO2
        DpUmsjuLSQ91s7XZ1iBjPcyULlbATvQ=
Date:   Wed, 15 Jan 2020 23:05:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shiping Ji <shiping.linux@gmail.com>
Cc:     sashal@kernel.org, James Morse <james.morse@arm.com>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        hangl@microsoft.com, Lei Wang <lewan@microsoft.com>,
        shji@microsoft.com, ruizhao@microsoft.com,
        Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>, ray.jui@broadcom.com,
        wangglei@gmail.com
Subject: Re: [PATCH v9 2/2] EDAC: add EDAC driver for DMC520
Message-ID: <20200115220436.GP20975@zn.tnic>
References: <6a462190-0af2-094a-daa8-f480d54a1fbf@gmail.com>
 <20200115213848.GO20975@zn.tnic>
 <3f1f28fd-2abf-2e1c-ef46-1992058b7a1a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f1f28fd-2abf-2e1c-ef46-1992058b7a1a@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 15, 2020 at 01:49:56PM -0800, Shiping Ji wrote:
> Lei will be the author of this driver in the git history. I could ask
> her to send the patch again if that's the correct way to go. Please
> confirm.

No need - you only have to send the patch with her From: at the
beginning. Btw, you make her an author in git by doing:

git commit --amend --author="Lei Wang <leiwang_git@outlook.com>"

But before you send again, let me take a look at the rest of the patch
first, tomorrow most likely.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
