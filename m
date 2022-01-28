Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BF84A00BA
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jan 2022 20:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbiA1TQe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 28 Jan 2022 14:16:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51730 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbiA1TQd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 28 Jan 2022 14:16:33 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7ADF21EC01A9;
        Fri, 28 Jan 2022 20:16:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643397388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jWFbBbIR3wRkZ0xumkSqRJo+9xN9XL7+UNQ9tK1p/dc=;
        b=SCZqIDec8gkSvt8Xz25rB+K33h0mZaofOJJpokBk5VNmfoUjv43Yog2SU7NavxzKF9JvKa
        8qQ5F5CLyD5hCovMEmN0hWjxPTgLI6Q4a1MkbsuSW2gPRpT3zcP0Z67zbY84+Z6Ca5fj8J
        sf3ahXYKRliSitx6dtNZC0x0zwl4Rg0=
Date:   Fri, 28 Jan 2022 20:16:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: Re: [PATCH 1/2] edac: altera: fix deferred probing
Message-ID: <YfRBCPRPkf+gD18/@zn.tnic>
References: <20220124185503.6720-1-s.shtylyov@omp.ru>
 <20220124185503.6720-2-s.shtylyov@omp.ru>
 <7b964ac0-6356-9330-a745-b43e620d051b@kernel.org>
 <YfQ3xUpLOPvDu5W+@zn.tnic>
 <ba83ca78-6a15-caf5-71ba-76d5b2b1b41d@omp.ru>
 <9f28d2de-5119-a7a6-9da7-08b2ce13f1a0@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f28d2de-5119-a7a6-9da7-08b2ce13f1a0@omp.ru>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 28, 2022 at 10:02:46PM +0300, Sergey Shtylyov wrote:
> >    I think the -stable people will pick it up based on the Fixes: tag. 

My last info is that they don't do that yet.

> Ah, you were wondering about returing -EPROBE_DEFER? It started to be returned
> by the commit 9ec36cafe43bf835f8f29273597a5b0cbc8267ef several months before that...

More precisely, I'm wondering after which commit does the deferred
probing code interpret -EPROBE_DEFER properly so that a backport of this
commit would be even worth the trouble?

Because if we backport it to kernel where there's not even deferred
probing support, then that backport is a waste of time.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
