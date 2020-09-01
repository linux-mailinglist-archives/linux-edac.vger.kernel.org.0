Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FCE259E69
	for <lists+linux-edac@lfdr.de>; Tue,  1 Sep 2020 20:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgIASvo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Sep 2020 14:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbgIASvo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 1 Sep 2020 14:51:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF011C061244;
        Tue,  1 Sep 2020 11:51:43 -0700 (PDT)
Received: from zn.tnic (p200300ec2f111c0024978c1e0fa9a8a0.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1c00:2497:8c1e:fa9:a8a0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21A361EC0402;
        Tue,  1 Sep 2020 20:51:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598986300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tc9v2kAw0PVA7I9RWib1GcZ989FrHTMdQDbO4s8BKM8=;
        b=RAsJU/OBy9MVu0v9nJvhrlC7qFhgUbojEJXggI3sDNKRqkznwo4p4O5LUZrWOgi1S4LGXA
        WHdxRWK8gce4sytF0KJtgIJSRBm2gxHNLMp93EprPEVSnf+KGt8I3HKKMBZaeorURfc/QT
        pUus+ahMEd2CnViPPQyRsecadxqUEEE=
Date:   Tue, 1 Sep 2020 20:51:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Stefan Schaeckeler <sschaeck@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Tero Kristo <t-kristo@ti.com>, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] EDAC/aspeed: Fix handling of platform_get_irq() error
Message-ID: <20200901185136.GD8392@zn.tnic>
References: <20200827070743.26628-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827070743.26628-1-krzk@kernel.org>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 27, 2020 at 09:07:42AM +0200, Krzysztof Kozlowski wrote:
> platform_get_irq() returns -ERRNO on error.  In such case comparison
> to 0 would pass the check.
> 
> Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/edac/aspeed_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Both applied,
thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
