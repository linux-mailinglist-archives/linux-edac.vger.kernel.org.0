Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F1E2CC4FB
	for <lists+linux-edac@lfdr.de>; Wed,  2 Dec 2020 19:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgLBSYf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Dec 2020 13:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbgLBSYf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Dec 2020 13:24:35 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0853CC0613CF;
        Wed,  2 Dec 2020 10:23:55 -0800 (PST)
Received: from zn.tnic (p200300ec2f161b00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:1b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7193B1EC04DB;
        Wed,  2 Dec 2020 19:23:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606933433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4K5oryCh4lYprceHfJITgYNxkJkNbvO0oAmzKtsMskk=;
        b=eyF7oJ8jzZXnSjEQtaZrUqi4mwuWKRWOIW9O8LaGm8MqDGJY2ivCpGoIYOt1Z6+twhPWwg
        BD27rstCZtNJappHLb/XnRJL/bLtkDIm1ccUAtRxsnvNQZrxM7nK48jtE06jmDLK5BhWQv
        ogqK7rU9rqVC++YIVNJfV+c9klFxF94=
Date:   Wed, 2 Dec 2020 19:23:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Troy Lee <troy_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Tony Luck <tony.luck@intel.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        James Morse <james.morse@arm.com>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        "leetroy@gmail.com" <leetroy@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan M Schaeckeler <sschaeck@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] edac: Supporting AST2400 and AST2600 edac driver
Message-ID: <20201202182349.GJ2951@zn.tnic>
References: <20201202063612.21241-1-troy_lee@aspeedtech.com>
 <20201202063612.21241-3-troy_lee@aspeedtech.com>
 <CACPK8XcBTm8-cAPmtswHbYAf2B+PdBiZ2s1XK1UqKA_NQX_-mw@mail.gmail.com>
 <PS1PR06MB26008E4BCB805553EDEC45038AF30@PS1PR06MB2600.apcprd06.prod.outlook.com>
 <b6dd3a91-abe7-4e9d-b801-6e54e4c88827@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6dd3a91-abe7-4e9d-b801-6e54e4c88827@www.fastmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 03, 2020 at 01:32:44AM +1030, Andrew Jeffery wrote:
> On Wed, 2 Dec 2020, at 19:11, Troy Lee wrote:
> > Hi Joel,
> > 
> > Thanks for the suggestion, I'll fix the review and create an new patch 
> > against 
> > latest Linux branch. Those exported function will be referenced in 
> > other driver yet 
> > to be upstream, so should I move those exported functions out of this 
> > patch?
> > 
> 
> Yes, let's leave the exports out of this patch, and add them in when you send 
> the patch that depends on them.

And when you do, almost all new exports are EXPORT_SYMBOL_GPL - not
EXPORT_SYMBOL.

Also, I'd like to see how those exports are going to be used. An EDAC
driver function exported to another driver sounds strange. We have only
one other case like this in the EDAC tree:

drivers/edac/amd64_edac.c:554:EXPORT_SYMBOL_GPL(amd64_get_dram_hole_info);

and even that is not really needed...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
